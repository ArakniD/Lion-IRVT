"""BTS register map v2.1 - addresses, access rules and the big-endian wire codec.

Transcribed from ``tida-010086/bts_F2837xD_8ch/registers.h``, which is the
authority. The ESP32 mirror ``bts_regs.h`` is a second hand-maintained copy
with no build coupling to the first.

**This file was two revisions stale until 2026-09-30** and its own comments
asserted the opposite - that it was current and the firmware mirrors were
wrong. It was written against v1 and never followed the C2000 through the v2
reorder (2026-09-19) or the v2.1 settings compression (2026-09-22). Every
unit address was 192 bytes high, so a read of ``eUnitState`` landed on
``eCh6_VoutOffset_pu`` and returned a calibration coefficient as a state
enum; the settings stride was wrong as well as the base, so a per-slot
settings read walked into another slot.

Corrected against the firmware, which was verified mechanically: all 280
registers satisfy ``byte_address == index * 4``, the map is fully dense, and
``regConfig[]``/``uartRegConfig[]`` agree with the enum entry for entry.

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
# Four regions. The blocks do NOT share a stride; assuming a uniform stride is
# the single most common bug in this codebase and produced silent
# cross-channel corruption in v1.
#
# THE MAP IS FULLY DENSE. Despite an old comment in registers.h about
# "generous strides so a future field does not shift everything", there is no
# reserved padding anywhere: runtime ends at 380 and settings start at 384,
# settings end at 956 and the unit block starts at 960, the unit block ends at
# 1064 and tuning starts at 1068. Inserting a register anywhere shifts every
# address above it and is a breaking change for every host.

NUM_CHANNELS: Final = 8
REGISTER_SIZE: Final = 4

RT_BASE: Final = 0
RT_STRIDE: Final = 48
RT_REG_COUNT: Final = 12

#: 18 registers per slot, not 24. The v2.1 compression merged the separate
#: charge/discharge limit pairs into one direction-agnostic pair and dropped
#: the minimum cell temperature, taking the stride from 96 B to 72 B and
#: pulling the unit base down from 1152 to 960.
SET_BASE: Final = 384
SET_STRIDE: Final = 72
SET_REG_COUNT: Final = 18

UNIT_BASE: Final = 960

#: Slot tuning: the 13 DCL control-loop coefficients, one set for the whole
#: unit rather than per slot. Appended above the unit block because they are
#: written once by the system builder and never polled - see TUNING_BASE.
TUNING_BASE: Final = 1068
TUNING_REG_COUNT: Final = 13

#: ``TOTAL_REGISTERS`` on the C2000: 96 runtime + 144 settings + 27 unit
#: + 13 tuning.
TOTAL_REGISTERS: Final = 280

#: Byte address of the LAST register, not the size of the map. The map spans
#: bytes 0..1119; this is the address of ``eDCL_CV_A2``, whose four bytes
#: occupy 1116..1119.
TOP_ADDRESS: Final = 1116

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

#: The limits are DIRECTION-AGNOSTIC as of v2.1. One voltage pair and one
#: current pair serve both directions; the mode register picks which way the
#: slot runs. The old ``SET_CHARGE_*``/``SET_DISCHARGE_*`` split is GONE - it
#: was not a rename, the registers genuinely merged, so a caller that writes
#: a "charge" and a "discharge" value separately now writes the same address
#: twice and the second silently wins.
#:
#: V_MIN additionally carries a behaviour: it is the discharge termination
#: threshold, and **zero disables that check** rather than meaning "stop at
#: 0 V". I_MIN is the charge termination current, tested only once the loop
#: is in constant-voltage.
SET_V_MIN: Final = 4
SET_V_MAX: Final = 8
SET_I_MIN: Final = 12
SET_I_MAX: Final = 16

#: The minimum cell temperature was removed in the v2.1 compression. Only the
#: maximum remains.
SET_MAX_CELL_TEMP: Final = 20
#: The 12 calibration registers keep their internal order, so the
#: ``CAL_*`` offsets below are relative to here.
SET_CAL_FIRST: Final = 24

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

REG_CHARGE_DISABLE_V: Final = 960
REG_CHARGE_RESTRICT_V: Final = 964
REG_DISCHARGE_RESTRICT_V: Final = 968
REG_DISCHARGE_DISABLE_V: Final = 972
REG_CALIBRATION_MODE: Final = 976
REG_UNIT_STATE: Final = 980
REG_INPUT_VOLTAGE: Final = 984
REG_TRIP_STATUS: Final = 988
#: The latched MODE strap. Values 6 and 7 are the slot-tuning (SFRA) modes;
#: they were the grouped internal-ADC modes before 2026-09-30 and a host that
#: still reads them that way will report a group of 4 or 8 for a mode whose
#: group size is 1.
REG_SLOT_MODE: Final = 992
REG_SLOT_ENABLE: Final = 996
REG_GROUP_SIZE: Final = 1000
#: Host watchdog timeout, seconds. Any host command - including a register
#: READ - reloads the countdown. Writing 0 disables supervision entirely.
REG_HOST_WATCHDOG_S: Final = 1004
REG_CAL_SLOT: Final = 1008
REG_CAL_COMMAND: Final = 1012
REG_CAL_ARGUMENT: Final = 1016
REG_CAL_STATUS: Final = 1020
REG_CAL_RESULT: Final = 1024
#: Live watchdog countdown. Reads 0 both when the watchdog has fired and when
#: it is disabled; distinguish the two by reading REG_HOST_WATCHDOG_S, which
#: is in the same burst.
REG_WATCHDOG_REMAINING_S: Final = 1028

#: Calibration live telemetry, nine consecutive floats, immediately after
#: ``REG_WATCHDOG_REMAINING_S``.
CAL_TELEMETRY_BASE: Final = 1032
REG_CAL_ADS_V_PU: Final = 1032
REG_CAL_ADS_I_PU: Final = 1036
REG_CAL_ADS_V_V: Final = 1040
REG_CAL_ADS_I_A: Final = 1044
REG_CAL_F28_V_PU: Final = 1048
REG_CAL_F28_I_PU: Final = 1052
REG_CAL_F28_V_V: Final = 1056
REG_CAL_F28_I_A: Final = 1060
REG_CAL_TEMP_C: Final = 1064


# --- slot tuning block ------------------------------------------------------
#
# The DCL biquad coefficients for the CC and CV control loops, writable so a
# unit can be tuned in the field instead of rebuilt.
#
# ONE SET FOR THE WHOLE UNIT - every slot is the same converter, so there is
# no per-slot stride here.
#
# These are deliberately NOT in any poll window. They are written once by a
# system builder during slot tuning and read back only on request; polling
# them would cost a round trip for data that changes once in the life of a
# unit.
#
# Z0/Z1/P1 are the CV zero and pole frequencies the coefficients were derived
# from. The firmware never reads them - they carry the design intent so a
# later re-derivation does not have to work backwards from the biquad.

REG_DCL_CC_B0: Final = 1068
REG_DCL_CC_B1: Final = 1072
REG_DCL_CC_B2: Final = 1076
REG_DCL_CC_A1: Final = 1080
REG_DCL_CC_A2: Final = 1084
REG_DCL_CV_Z0: Final = 1088
REG_DCL_CV_Z1: Final = 1092
REG_DCL_CV_P1: Final = 1096
REG_DCL_CV_B0: Final = 1100
REG_DCL_CV_B1: Final = 1104
REG_DCL_CV_B2: Final = 1108
REG_DCL_CV_A1: Final = 1112
REG_DCL_CV_A2: Final = 1116


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
    """Whether ``regConfig[]`` marks this address ``REG_ACCESS_RW``.

    Checked against the firmware tables: 114 read-only, 166 writable. The
    whole runtime block is read-only, the whole settings block and the whole
    tuning block are writable, and the unit block is mixed.
    """
    # Slot tuning is writable in its entirety - the block exists to be
    # written by the system builder.
    if TUNING_BASE <= address <= TOP_ADDRESS:
        return True
    if UNIT_BASE <= address < TUNING_BASE:
        return address in _WRITABLE_UNIT
    if SET_BASE <= address < SET_BASE + NUM_CHANNELS * SET_STRIDE:
        # Every one of the 18 settings registers is writable, so the offset
        # arithmetic the old version used is gone: it compared against a
        # hard-coded 88 and would have called the last register read-only.
        return True
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
    """The five settings-block limit registers for a channel.

    **These limits are direction-agnostic.** Until the v2.1 compression there
    were separate charge and discharge pairs and this class carried ten
    fields; the firmware merged them and the mode register now selects the
    direction. A caller that still thinks in charge/discharge pairs would
    write the same address twice here and silently keep whichever value went
    last, so the old field names were removed rather than aliased - a hard
    failure at the call site is the point.

    ``voltage_min`` and ``current_min`` are not merely bounds, they are the
    CCCV termination thresholds: a discharge ends at ``voltage_min`` and a
    charge ends when the current falls to ``current_min`` while the loop is
    in constant-voltage. **``voltage_min = 0`` disables the discharge
    termination check** rather than meaning "run to 0 V".

    The caller is expected to have clamped to the unit envelope already; the
    firmware clamps again as a backstop because it is the last code that runs
    before the values reach the power stage.
    """

    voltage_min: float
    voltage_max: float
    current_min: float
    current_max: float
    max_cell_temp: float

    def as_writes(self, channel: int) -> list[tuple[int, float]]:
        """Address/value pairs, in ascending address order."""
        return [
            (set_addr(channel, SET_V_MIN), self.voltage_min),
            (set_addr(channel, SET_V_MAX), self.voltage_max),
            (set_addr(channel, SET_I_MIN), self.current_min),
            (set_addr(channel, SET_I_MAX), self.current_max),
            (set_addr(channel, SET_MAX_CELL_TEMP), self.max_cell_temp),
        ]
