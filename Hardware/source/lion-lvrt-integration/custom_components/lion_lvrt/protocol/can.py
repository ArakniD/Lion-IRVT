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

TELEMETRY IS FIXED-POINT, AND CARRIES THE WHOLE SLOT
----------------------------------------------------
The frame packs state, voltage, current and both accumulators into its eight
bytes as scaled integers. There is no float on the wire, so there is nothing
to truncate:

===== ==========================================================
Byte  Contents
===== ==========================================================
0     slot index (bits 0-3), run state (bits 4-7)
1-2   voltage, signed 16-bit millivolts, little-endian
3-4   current, signed 16-bit milliamps, little-endian
5-7   mAh and mWh as two unsigned 12-bit fields sharing byte 6
===== ==========================================================

The accumulators are scaled - 4 mAh and 16 mWh per LSB - which buys a 16 Ah
and 65 Wh reach out of 12 bits each. Both saturate at their ceiling rather
than wrapping, so :attr:`CanTelemetry.mah_saturated` distinguishes "at least
this much" from an exact reading.

An earlier layout put raw floats in the frame and ran out of room, sending
only the low 16-bit word of the current float. The sign and exponent live in
the missing half, so that value was unreconstructable rather than merely
coarse, and the accumulators did not fit at all. Hosts written against that
layout must be updated together with the firmware - the two are not
distinguishable on the wire.
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

#: Run-state bits in the high nibble of byte 0. ``BTS_CAN_STATE_*`` in
#: registers.h. CHARGING and DISCHARGING are mutually exclusive; PAUSED and
#: FAULT are independent of both, so a paused slot still reports the direction
#: it would resume into.
CAN_STATE_CHARGING: Final = 0x10
CAN_STATE_DISCHARGING: Final = 0x20
CAN_STATE_PAUSED: Final = 0x40
CAN_STATE_FAULT: Final = 0x80

#: Engineering units per LSB of the two 12-bit accumulator fields.
CAN_MAH_SCALE: Final = 4
CAN_MWH_SCALE: Final = 16
#: Both fields are 12 bits, and the firmware saturates rather than wrapping.
CAN_ACC_FIELD_MAX: Final = 0x0FFF


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
    current_a: float
    mah: float
    mwh: float

    #: Run state, decoded from byte 0's high nibble.
    charging: bool
    discharging: bool
    paused: bool
    fault: bool

    #: True when an accumulator reached its 12-bit ceiling. The firmware
    #: saturates rather than wrapping, so the value is a floor ("at least
    #: this much") rather than a measurement.
    mah_saturated: bool
    mwh_saturated: bool

    @property
    def running(self) -> bool:
        """Whether the slot holds a direction, paused or not.

        A paused slot keeps its direction bit, matching the status word where
        RUNNING survives a pause - so this is "has a test in progress",
        not "is delivering power right now".
        """
        return self.charging or self.discharging

    @classmethod
    def decode(cls, can_id: int, data: bytes) -> "CanTelemetry":
        channel = channel_of(can_id)
        if channel is None:
            raise ValueError(f"CAN id 0x{can_id:08X} is not a telemetry frame")
        if len(data) < 8:
            raise ValueError(f"telemetry frame is {len(data)} bytes, need 8")

        state = data[0] & 0xF0

        # Signed 16-bit milli-units, little-endian.
        mv, ma = struct.unpack("<hh", bytes(data[1:5]))

        # Two 12-bit fields sharing byte 6: mAh takes its low nibble, mWh its
        # high one.
        mah_raw = data[5] | ((data[6] & 0x0F) << 8)
        mwh_raw = ((data[6] >> 4) & 0x0F) | (data[7] << 4)

        return cls(
            channel=data[0] & 0x0F,
            voltage_v=mv / 1000.0,
            current_a=ma / 1000.0,
            mah=float(mah_raw * CAN_MAH_SCALE),
            mwh=float(mwh_raw * CAN_MWH_SCALE),
            charging=bool(state & CAN_STATE_CHARGING),
            discharging=bool(state & CAN_STATE_DISCHARGING),
            paused=bool(state & CAN_STATE_PAUSED),
            fault=bool(state & CAN_STATE_FAULT),
            mah_saturated=mah_raw == CAN_ACC_FIELD_MAX,
            mwh_saturated=mwh_raw == CAN_ACC_FIELD_MAX,
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
