"""BTS register map v2 - addresses, access rules and the big-endian wire codec.

Transcribed from ``tida-010086/bts_F2837xD_8ch/registers.h``, which is the
authority. The ESP32 mirror ``bts_regs.h`` is a second hand-maintained copy
with no build coupling to the first, and the two have drifted - see
:data:`CAL_TELEMETRY_BASE` for the case that matters.

WIRE FORMAT
-----------
Register payloads are **big**-endian float32, the opposite of the GATT
records. ``index = byte_address / 4``. Both reads and writes auto-increment,
bounded at the top of the map.

Reads over I2C must fetch ``1 + count*4`` bytes and discard the first: the
C2000 starts clocking out its TX register the instant it acknowledges the
repeated start, before its ISR can run, so every reply carries one stale pad
byte. That is a property of the peripheral, not a fixable target bug. This
module exposes :func:`decode_block` which does the discarding, so callers
never open-code the offset.
"""

from __future__ import annotations

import struct
from dataclasses import dataclass
from typing import Final

# --- region geometry --------------------------------------------------------
#
# Three regions with fixed, deliberately generous per-slot strides so a future
# field does not shift everything again. The blocks do NOT share a stride;
# assuming a uniform stride is the single most common bug in this codebase and
# produced silent cross-channel corruption in v1.

NUM_CHANNELS: Final = 8
REGISTER_SIZE: Final = 4

RT_BASE: Final = 0
RT_STRIDE: Final = 48
RT_REG_COUNT: Final = 12

SET_BASE: Final = 384
SET_STRIDE: Final = 96
SET_REG_COUNT: Final = 24

UNIT_BASE: Final = 1152

#: ``TOTAL_REGISTERS`` on the C2000: 96 runtime + 192 settings + 27 unit.
#:
#: The ESP32 mirror says 314, because it is missing ``eWatchdogRemaining_s``.
#: The C2000 value is the correct one - it is the array the target actually
#: bounds-checks against.
TOTAL_REGISTERS: Final = 315
TOP_ADDRESS: Final = 1256

# --- runtime block, byte offsets within a channel (all read-only) -----------

RT_STATUS: Final = 0
RT_CELL_VOLTAGE: Final = 4       # internal 12-bit ADC
RT_CELL_CURRENT: Final = 8       # internal 12-bit ADC
RT_SENSE_VOLTAGE: Final = 12     # ADS131M08 16-bit
RT_SENSE_CURRENT: Final = 16     # ADS131M08 16-bit
RT_CELL_TEMP: Final = 20         # ADS1119
RT_CHARGE_MAH: Final = 24
RT_CHARGE_MWH: Final = 28
RT_CHARGE_SECONDS: Final = 32
RT_DISCHARGE_MAH: Final = 36
RT_DISCHARGE_MWH: Final = 40
RT_DISCHARGE_SECONDS: Final = 44

# --- settings block, byte offsets within a channel (all read/write) ---------

SET_MODE: Final = 0
SET_CHARGE_V_MIN: Final = 4
SET_CHARGE_V_MAX: Final = 8
SET_DISCHARGE_V_MIN: Final = 12
SET_DISCHARGE_V_MAX: Final = 16
SET_CHARGE_I_MIN: Final = 20
SET_CHARGE_I_MAX: Final = 24
SET_DISCHARGE_I_MIN: Final = 28
SET_DISCHARGE_I_MAX: Final = 32
SET_MIN_CELL_TEMP: Final = 36
SET_MAX_CELL_TEMP: Final = 40
#: The 12 calibration registers keep their internal order, so the
#: ``CAL_*`` offsets below are relative to here.
SET_CAL_FIRST: Final = 44

CAL_F28V_GAIN: Final = 0
CAL_F28V_OFFSET: Final = 4
CAL_F28I_GAIN: Final = 8
CAL_F28I_OFFSET: Final = 12
CAL_IOUT_GAIN_PU: Final = 16
CAL_IOUT_OFFSET_PU: Final = 20
CAL_IOUT_GAIN_A: Final = 24
CAL_IOUT_OFFSET_A: Final = 28
CAL_VOUT_GAIN_PU: Final = 32
CAL_VOUT_OFFSET_PU: Final = 36
CAL_VOUT_GAIN_V: Final = 40
CAL_VOUT_OFFSET_V: Final = 44

# --- unit block -------------------------------------------------------------

REG_CHARGE_DISABLE_V: Final = 1152
REG_CHARGE_RESTRICT_V: Final = 1156
REG_DISCHARGE_RESTRICT_V: Final = 1160
REG_DISCHARGE_DISABLE_V: Final = 1164
REG_CALIBRATION_MODE: Final = 1168
REG_UNIT_STATE: Final = 1172
REG_INPUT_VOLTAGE: Final = 1176
REG_TRIP_STATUS: Final = 1180
REG_SLOT_MODE: Final = 1184
REG_SLOT_ENABLE: Final = 1188
REG_GROUP_SIZE: Final = 1192
#: Host watchdog timeout, seconds. Any host command - including a register
#: READ - reloads the countdown. Writing 0 disables supervision entirely.
REG_HOST_WATCHDOG_S: Final = 1196
REG_CAL_SLOT: Final = 1200
REG_CAL_COMMAND: Final = 1204
REG_CAL_ARGUMENT: Final = 1208
REG_CAL_STATUS: Final = 1212
REG_CAL_RESULT: Final = 1216
#: Live watchdog countdown. Reads 0 both when the watchdog has fired and when
#: it is disabled; distinguish the two by reading REG_HOST_WATCHDOG_S, which
#: is in the same burst.
REG_WATCHDOG_REMAINING_S: Final = 1220

#: Calibration live telemetry, nine consecutive floats.
#:
#: **This is 1224 on the C2000, not 1220.** The ESP32 mirror omits
#: ``eWatchdogRemaining_s`` from its unit block and starts this window at
#: 1220, so every one of the nine floats it reads is one register low -
#: ``ads_v_pu`` actually carries the watchdog countdown. Any value this
#: integration reads over BLE characteristic 000c or HTTP /api/calibration
#: inherits that shift until the firmware mirror is corrected; reading the
#: registers directly through CAN or 000d does not.
CAL_TELEMETRY_BASE: Final = 1224
REG_CAL_ADS_V_PU: Final = 1224
REG_CAL_ADS_I_PU: Final = 1228
REG_CAL_ADS_V_V: Final = 1232
REG_CAL_ADS_I_A: Final = 1236
REG_CAL_F28_V_PU: Final = 1240
REG_CAL_F28_I_PU: Final = 1244
REG_CAL_F28_V_V: Final = 1248
REG_CAL_F28_I_A: Final = 1252
REG_CAL_TEMP_C: Final = 1256


def rt_addr(channel: int, offset: int) -> int:
    """Byte address of a runtime register for ``channel``."""
    _check_channel(channel)
    return RT_BASE + channel * RT_STRIDE + offset


def set_addr(channel: int, offset: int) -> int:
    """Byte address of a settings register for ``channel``."""
    _check_channel(channel)
    return SET_BASE + channel * SET_STRIDE + offset


def cal_addr(channel: int, offset: int) -> int:
    """Byte address within ``channel``'s 12-register calibration block."""
    return set_addr(channel, SET_CAL_FIRST) + offset


def _check_channel(channel: int) -> None:
    if not 0 <= channel < NUM_CHANNELS:
        raise ValueError(f"channel {channel} out of range 0-{NUM_CHANNELS - 1}")


def index_of(address: int) -> int:
    """Convert a byte address to an index into the target's register array."""
    if address % REGISTER_SIZE:
        raise ValueError(f"address {address} is not register-aligned")
    idx = address // REGISTER_SIZE
    if not 0 <= idx < TOTAL_REGISTERS:
        raise ValueError(f"address {address} outside the map (0-{TOP_ADDRESS})")
    return idx


#: Registers a host may write. Everything else is silently dropped by the
#: target - a write to a read-only register is not an error, it simply does
#: nothing, so a client must read back rather than trust the write.
def is_writable(address: int) -> bool:
    """Whether ``regConfig[]`` marks this address ``REG_ACCESS_RW``."""
    if UNIT_BASE <= address <= TOP_ADDRESS:
        return address in _WRITABLE_UNIT
    if SET_BASE <= address < SET_BASE + NUM_CHANNELS * SET_STRIDE:
        # 21 of the 24 settings registers are used; the spare at +92 exists
        # but is not meaningfully writable.
        return (address - SET_BASE) % SET_STRIDE <= SET_CAL_FIRST + CAL_VOUT_OFFSET_V
    # The entire runtime region is read-only.
    return False


_WRITABLE_UNIT: Final = frozenset(
    {
        REG_CHARGE_DISABLE_V,
        REG_CHARGE_RESTRICT_V,
        REG_DISCHARGE_RESTRICT_V,
        REG_DISCHARGE_DISABLE_V,
        REG_CALIBRATION_MODE,
        REG_HOST_WATCHDOG_S,
        REG_CAL_SLOT,
        REG_CAL_COMMAND,
        REG_CAL_ARGUMENT,
    }
)


# --- wire codec -------------------------------------------------------------


def f32_to_wire(value: float) -> bytes:
    """Pack a float into the target's big-endian register payload."""
    return struct.pack(">f", value)


def wire_to_f32(raw: bytes) -> float:
    """Unpack a big-endian register payload."""
    if len(raw) < 4:
        raise ValueError(f"register payload too short: {len(raw)} bytes")
    return struct.unpack(">f", raw[:4])[0]


def decode_block(raw: bytes, count: int, *, skip_pad: bool = True) -> list[float]:
    """Decode a burst read into ``count`` floats.

    ``skip_pad`` discards the lead-in byte that the I2C target always emits.
    Transports that are not I2C (the GATT register characteristic, the CAN
    mailbox) have no such byte and pass ``skip_pad=False``.
    """
    body = raw[1:] if skip_pad else raw
    need = count * REGISTER_SIZE
    if len(body) < need:
        raise ValueError(
            f"short register block: {len(body)} bytes for {count} registers "
            f"(need {need}){' after discarding the pad byte' if skip_pad else ''}"
        )
    return [
        struct.unpack(">f", body[i * 4 : i * 4 + 4])[0] for i in range(count)
    ]


@dataclass(frozen=True, slots=True)
class RuntimeBlock:
    """One channel's 12-register runtime burst, decoded.

    Reading these as one burst rather than 12 transactions is the entire point
    of the v2 reorder.
    """

    status_bits: int
    cell_voltage_v: float
    cell_current_a: float
    sense_voltage_v: float
    sense_current_a: float
    cell_temp_c: float
    charge_mah: float
    charge_mwh: float
    charge_seconds: float
    discharge_mah: float
    discharge_mwh: float
    discharge_seconds: float

    @classmethod
    def from_floats(cls, values: list[float]) -> "RuntimeBlock":
        if len(values) < RT_REG_COUNT:
            raise ValueError(
                f"runtime block needs {RT_REG_COUNT} values, got {len(values)}"
            )
        return cls(
            # The status word travels as a float32 and is exact only to bit 23;
            # int() is safe for every bit the firmware is allowed to publish.
            status_bits=int(values[0]),
            cell_voltage_v=values[1],
            cell_current_a=values[2],
            sense_voltage_v=values[3],
            sense_current_a=values[4],
            cell_temp_c=values[5],
            charge_mah=values[6],
            charge_mwh=values[7],
            charge_seconds=values[8],
            discharge_mah=values[9],
            discharge_mwh=values[10],
            discharge_seconds=values[11],
        )


@dataclass(frozen=True, slots=True)
class ChannelLimits:
    """The ten settings-block limit registers for a channel.

    The caller is expected to have clamped to the unit envelope already; the
    firmware clamps again as a backstop because it is the last code that runs
    before the values reach the power stage.
    """

    charge_voltage_min: float
    charge_voltage_max: float
    discharge_voltage_min: float
    discharge_voltage_max: float
    charge_current_min: float
    charge_current_max: float
    discharge_current_min: float
    discharge_current_max: float
    min_cell_temp: float
    max_cell_temp: float

    def as_writes(self, channel: int) -> list[tuple[int, float]]:
        """Address/value pairs, in ascending address order."""
        return [
            (set_addr(channel, SET_CHARGE_V_MIN), self.charge_voltage_min),
            (set_addr(channel, SET_CHARGE_V_MAX), self.charge_voltage_max),
            (set_addr(channel, SET_DISCHARGE_V_MIN), self.discharge_voltage_min),
            (set_addr(channel, SET_DISCHARGE_V_MAX), self.discharge_voltage_max),
            (set_addr(channel, SET_CHARGE_I_MIN), self.charge_current_min),
            (set_addr(channel, SET_CHARGE_I_MAX), self.charge_current_max),
            (set_addr(channel, SET_DISCHARGE_I_MIN), self.discharge_current_min),
            (set_addr(channel, SET_DISCHARGE_I_MAX), self.discharge_current_max),
            (set_addr(channel, SET_MIN_CELL_TEMP), self.min_cell_temp),
            (set_addr(channel, SET_MAX_CELL_TEMP), self.max_cell_temp),
        ]
