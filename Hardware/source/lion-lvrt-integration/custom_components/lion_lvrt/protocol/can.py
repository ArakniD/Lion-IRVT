"""CAN frame codec for the BTS CANA interface.

500 kbit/s, extended 29-bit IDs, base ``0x1C000000``. Two frame families:

* **Telemetry**, IDs ``base | ch << 20 | 0x01``, transmitted round-robin from
  the 8 Hz CPU Timer 1 ISR, one object per channel.
* **Register mailbox**, ID ``base | 0x02``, a host-driven read/write.

BYTE ORDER
----------
The mailbox is mixed-endian and that is not a mistake in this file: ``addr``
is big-endian, and the float payload is little-endian **word** order, which
differs from the I2C register format (fully big-endian). ``canISR()`` in
``com_cpu2.c`` assembles the float from ``data[4..7]`` as two 16-bit
little-endian words, because the C2000 is a 16-bit-word machine.

TELEMETRY CURRENT IS UNUSABLE
-----------------------------
``sendCANData()`` packs all four bytes of the voltage float but **only the low
16-bit word** of the current float - the frame has no room for the second
word after the channel byte and its pad. The sign, exponent and high mantissa
bits are never transmitted, so the current in a telemetry frame is not merely
imprecise, it is unreconstructable. :class:`CanTelemetry` therefore reports
``current_a`` as ``None`` and exposes the raw word for diagnostics. Read
current through the register mailbox instead.
"""

from __future__ import annotations

import struct
from dataclasses import dataclass
from typing import Final

from .registers import NUM_CHANNELS, index_of, is_writable

#: ``CAN_MSG_ID_BASE`` in registers.h.
CAN_ID_BASE: Final = 0x1C000000
#: ``CAN_BITRATE``.
CAN_BITRATE: Final = 500_000

#: Discriminators in the low byte of the 29-bit ID.
CAN_KIND_TELEMETRY: Final = 0x01
CAN_KIND_MAILBOX: Final = 0x02

#: The channel index occupies bits 20-22 of the extended ID.
CAN_CHANNEL_SHIFT: Final = 20

MAILBOX_ID: Final = CAN_ID_BASE | CAN_KIND_MAILBOX

#: Periodic telemetry is emitted round-robin from an 8 Hz timer across 8
#: channels, so any one channel refreshes at 1 Hz.
TELEMETRY_CHANNEL_HZ: Final = 1.0


def telemetry_id(channel: int) -> int:
    """Extended CAN ID of ``channel``'s periodic telemetry object."""
    if not 0 <= channel < NUM_CHANNELS:
        raise ValueError(f"channel {channel} out of range")
    return CAN_ID_BASE | (channel << CAN_CHANNEL_SHIFT) | CAN_KIND_TELEMETRY


def channel_of(can_id: int) -> int | None:
    """Channel index carried by a telemetry ID, or None if not telemetry."""
    if (can_id & 0xFF) != CAN_KIND_TELEMETRY:
        return None
    channel = (can_id >> CAN_CHANNEL_SHIFT) & 0x7
    return channel if channel < NUM_CHANNELS else None


@dataclass(frozen=True, slots=True)
class CanTelemetry:
    """A decoded periodic telemetry frame."""

    channel: int
    voltage_v: float
    #: Always None - see the module docstring. Kept in the dataclass so a
    #: consumer that expects the field does not crash, and so the reason is
    #: discoverable at the point of use.
    current_a: None
    #: The low 16-bit word of the current float, as received. Useful only for
    #: confirming that frames are arriving at all.
    current_low_word: int

    @classmethod
    def decode(cls, can_id: int, data: bytes) -> "CanTelemetry":
        channel = channel_of(can_id)
        if channel is None:
            raise ValueError(f"CAN id 0x{can_id:08X} is not a telemetry frame")
        if len(data) < 8:
            raise ValueError(f"telemetry frame is {len(data)} bytes, need 8")
        # data[0] channel, data[1] pad, data[2..5] voltage (two LE words),
        # data[6..7] the LOW word of current only.
        voltage = struct.unpack("<f", bytes(data[2:6]))[0]
        current_low = data[6] | (data[7] << 8)
        return cls(
            channel=data[0] & 0xFF,
            voltage_v=voltage,
            current_a=None,
            current_low_word=current_low,
        )


def encode_register_read(address: int) -> tuple[int, bytes]:
    """Build a mailbox frame requesting ``address``.

    Returns ``(can_id, data)``. The unit replies on the same ID with the value
    in ``data[4..7]``.
    """
    index_of(address)  # validates alignment and range
    data = bytes(
        [
            (address >> 8) & 0xFF,
            address & 0xFF,
            0x00,  # read
            0x00,
            0,
            0,
            0,
            0,
        ]
    )
    return MAILBOX_ID, data


def encode_register_write(address: int, value: float) -> tuple[int, bytes]:
    """Build a mailbox frame writing ``value`` to ``address``.

    A write to a read-only register is silently dropped by the target, so this
    refuses one up front rather than letting a caller believe it succeeded.
    """
    index_of(address)
    if not is_writable(address):
        raise ValueError(
            f"register {address} is read-only; the target would silently "
            "discard this write"
        )
    # Little-endian word order, matching canISR()'s reassembly.
    raw = struct.pack("<f", float(value))
    data = bytes(
        [
            (address >> 8) & 0xFF,
            address & 0xFF,
            0x01,  # write
            0x00,
            raw[0],
            raw[1],
            raw[2],
            raw[3],
        ]
    )
    return MAILBOX_ID, data


def decode_register_reply(data: bytes) -> tuple[int, float]:
    """Decode a mailbox reply into ``(address, value)``."""
    if len(data) < 8:
        raise ValueError(f"mailbox reply is {len(data)} bytes, need 8")
    address = ((data[0] & 0xFF) << 8) | (data[1] & 0xFF)
    value = struct.unpack("<f", bytes(data[4:8]))[0]
    return address, value
