"""Constants for the Lion LVRT battery-tester integration.

Every value here is transcribed from firmware source, not from a design
document. Where the two disagree the source wins - see
``Docs/ble-specification.md`` section 11 for the history of that class of bug.

Provenance for each group is named in the comment above it so a future reader
can re-verify against the firmware rather than trusting this file.
"""

from __future__ import annotations

from enum import IntEnum, IntFlag
from typing import Final

DOMAIN: Final = "lion_lvrt"

# ``BLE_DEVICE_NAME`` in esp32-btle-proxy/main/main.c
DEFAULT_DEVICE_NAME: Final = "BTS-Tester"

# ``SLOT_COUNT`` = ``BTS_NUM_CHANNELS`` in bts_regs.h
SLOT_COUNT: Final = 8

# ``BLE_PROTO_VERSION`` in components/ble_svc/include/ble_proto.h.
#
# The interface is append-only, so a device reporting a HIGHER version still
# decodes correctly for every field we know. We therefore treat this as a
# minimum, not an equality test, and feature-detect characteristics instead
# (ble-specification.md section 7.1).
PROTO_VERSION_MIN: Final = 3

# Proto 3 grew ble_slot_status_t from 40 to 68 bytes and ble_unit_status_t
# from 20 to 24. A proto-2 device is still usable read-only for the common
# prefix, which is why decoding is prefix-tolerant.
PROTO_VERSION_PAUSE_RESUME: Final = 3

CONF_TRANSPORT: Final = "transport"
CONF_ADDRESS: Final = "address"
CONF_CAN_INTERFACE: Final = "can_interface"
CONF_CAN_BITRATE: Final = "can_bitrate"
CONF_HTTP_HOST: Final = "http_host"
CONF_SLOT_COUNT: Final = "slot_count"

TRANSPORT_BLE: Final = "ble"
TRANSPORT_CAN: Final = "can"
TRANSPORT_HTTP: Final = "http"

# The BLE notify task ticks at 500 ms and emits slot/unit status every second
# tick (ble-specification.md section 6.1), so polling faster than 1 Hz gains
# nothing. Notifications are best-effort and silently dropped when the NimBLE
# mbuf pool is exhausted, so we poll as a floor beneath the live feed.
DEFAULT_SCAN_INTERVAL_S: Final = 5.0
FAST_SCAN_INTERVAL_S: Final = 1.0

# The unit pauses every running slot if no host command arrives within
# eHostWatchdog_s (default 30 s). Any register READ feeds it, so the
# coordinator's poll doubles as the keepalive - see supervision design section 4.
DEFAULT_HOST_WATCHDOG_S: Final = 30.0
WATCHDOG_FEED_MARGIN: Final = 3.0


class UnitState(IntEnum):
    """``bts_unit_state_t`` - mirrors the C2000 ``UnitState`` enum.

    Governs whether slots may charge or discharge at all; a slot start is
    refused outright by ``modeCallback()`` when the input is outside the
    window, leaving the channel stopped with no error anywhere.
    """

    INPUT_LOW_CHARGE_DISABLED = 0
    INPUT_LOW_CHARGE_RESTRICTED = 1
    INPUT_OK = 2
    INPUT_HIGH_DISCHARGE_RESTRICTED = 3
    INPUT_HIGH_DISCHARGE_DISABLED = 4

    @property
    def charge_allowed(self) -> bool:
        """Whether the unit will accept a charge command in this state."""
        return self in (
            UnitState.INPUT_OK,
            UnitState.INPUT_HIGH_DISCHARGE_RESTRICTED,
            UnitState.INPUT_HIGH_DISCHARGE_DISABLED,
        )

    @property
    def discharge_allowed(self) -> bool:
        """Whether the unit will accept a discharge command in this state."""
        return self in (
            UnitState.INPUT_LOW_CHARGE_RESTRICTED,
            UnitState.INPUT_OK,
        )


class SlotState(IntEnum):
    """``slot_state_t`` from components/test_engine/include/test_engine.h.

    This is the ESP32 test engine's sequence state, which is a different thing
    from the BTS status word: the engine drives a full characterisation
    (check-rest, charge, rest, discharge, rest, recharge) while the BTS only
    knows running/stopped/paused and a direction.
    """

    IDLE = 0
    CHECK_REST = 1
    CHARGE = 2
    REST = 3
    DISCHARGE = 4
    DISCHARGE_REST = 5
    RECHARGE = 6
    COMPLETE = 7
    FAULT = 8
    ABORTED = 9
    # The BTS holds a run this engine did not start: the host watchdog fired,
    # or the unit reset and restored from F-RAM. Never auto-resumed, because
    # the cell may have been swapped while the unit was off.
    BTS_PAUSED = 10

    @property
    def is_active(self) -> bool:
        """True while the power stage may be enabled."""
        return self in (
            SlotState.CHECK_REST,
            SlotState.CHARGE,
            SlotState.REST,
            SlotState.DISCHARGE,
            SlotState.DISCHARGE_REST,
            SlotState.RECHARGE,
        )

    @property
    def is_terminal(self) -> bool:
        """True once the engine has stopped of its own accord."""
        return self in (
            SlotState.COMPLETE,
            SlotState.FAULT,
            SlotState.ABORTED,
        )


class SlotFault(IntEnum):
    """``slot_fault_t`` from test_engine.h."""

    NONE = 0
    OVER_TEMP = 1
    UNDER_TEMP = 2
    OVER_CURRENT = 3
    CMPSS_TRIP = 4
    GPIO_TRIP = 5
    TIMEOUT = 6
    BTS_OFFLINE = 7
    UNIT_STATE = 8
    NO_CELL = 9
    CELL_REVERSED = 10
    COMMS = 11


class CellChemistry(IntEnum):
    """``cell_chemistry_t`` from components/cell_profiles/include/cell_profiles.h."""

    LCO = 0
    LTO = 1
    LFP = 2
    NMC = 3
    NCA = 4


class StatusBit(IntFlag):
    """``BTS_STATUS_*`` masks, from the ESP32 mirror ``bts_regs.h``.

    Note the C2000 ``registers.h`` spells the same names as bit *positions*
    rather than masks; these are the masks. Mixing the two conventions
    compiles and is silently wrong.

    Bit 23 is a hard ceiling: the word reaches a host as a float32, whose
    24-bit significand represents integers exactly only to 2**24 - 1.
    """

    RUNNING = 1 << 0
    STOPPED = 1 << 1
    # Bit 2 was declared but never driven before register map v2. It now
    # carries the END semantic - a normally terminated test - rather than
    # spending a second bit on the same state.
    FINISHED = 1 << 2
    OVERCURRENT_TRIP = 1 << 3
    CHARGING = 1 << 4
    DISCHARGING = 1 << 5
    # Bits 6/7 are constant in this build: BTS_LAB_TYPE selects CC-only, so
    # the CV branch is compiled out. CONST_CURRENT is always 1 while running.
    CONST_VOLTAGE = 1 << 6
    CONST_CURRENT = 1 << 7
    SLAVE_MODE = 1 << 8
    GROUP_DISCONNECT = 1 << 9
    REVERSE_POLARITY = 1 << 10
    SLOT_DISABLED = 1 << 11
    CALIBRATING = 1 << 12
    # 13/14 come from the PERSISTED validity flags, so a slot calibrated in an
    # earlier session still shows its ticks after a power cycle.
    CAL_V_VALID = 1 << 13
    CAL_I_VALID = 1 << 14
    # PAUSED is not a direction: the slot keeps CHARGING or DISCHARGING set
    # alongside it, so a host sees both that it is paused and what it would
    # resume into. Bit 16 is unused and reads a constant 0.
    PAUSED = 1 << 15
    WD_TRIPPED = 1 << 17
    RESTORED = 1 << 18


#: Alias matching the firmware's ``BTS_STATUS_END``.
STATUS_END: Final = StatusBit.FINISHED


class SlotMode(IntFlag):
    """``eChX_Mode`` bits - the only register that causes an action.

    Note the asymmetry: bit 1 clear means *discharge*, so STOP (0x00) and
    "start a discharge" (0x01) differ only in bit 0. A stray bit here starts
    a discharge rather than doing nothing.
    """

    STOP = 0x00
    RUN = 0x01
    CHARGE = 0x02
    CALIBRATE = 0x04
    # Edge commands, consumed by modeCallback() rather than stored.
    PAUSE = 0x08
    RESUME = 0x10

    @staticmethod
    def run_charge() -> int:
        return int(SlotMode.RUN | SlotMode.CHARGE)

    @staticmethod
    def run_discharge() -> int:
        return int(SlotMode.RUN)


class BleCommand(IntEnum):
    """``ble_cmd_op_t`` opcodes for GATT characteristic 0003."""

    START = 1
    ABORT = 2
    CLEAR_FAULT = 3
    ABORT_ALL = 4
    PAUSE = 5
    RESUME = 6


class CalCommand(IntEnum):
    """``bts_cal_cmd_t``. The numbering is identical on every layer."""

    NONE = 0
    ENTER = 1
    EXIT = 2
    CAPTURE_VOLTAGE = 3
    ZERO_CURRENT = 4
    SET_FIXED_CURRENT = 5
    CAPTURE_CURRENT = 6
    COMPUTE_SAVE = 7
    CLEAR = 8


class CalResult(IntEnum):
    """``eCalResult`` codes.

    A GATT write succeeding says nothing about acceptance: the ATT layer
    returns 0x0E for any non-zero result. Always read characteristic 000c
    back after a command.
    """

    OK = 0
    BUSY = 1
    TESTING = 2
    SLOT_UNAVAILABLE = 3
    PU_RANGE = 4
    INSUFFICIENT = 5
    VALIDATE = 6
    FRAM = 7
    ARG = 8
    NOT_ACTIVE = 9


class CalStatusBit(IntFlag):
    """``eCalStatus`` bitfield masks."""

    ACTIVE = 0x001
    V_LOW_CAPTURED = 0x002
    V_HIGH_CAPTURED = 0x004
    I_ZERO_CAPTURED = 0x008
    I_LOADED_CAPTURED = 0x010
    V_COMPUTED = 0x020
    I_COMPUTED = 0x040
    SAVED_TO_FRAM = 0x080
    FIXED_CURRENT_DRIVING = 0x100
    LAST_COMMAND_FAILED = 0x200


# Hardware envelope of the TIDA-010086 unit, from bts_regs.h. Any profile
# asking for more than this is clamped before it reaches the BTS.
UNIT_MAX_CURRENT_A: Final = 10.0
UNIT_MAX_VOLTAGE_V: Final = 5.0

# CAL_CMD_SET_FIXED_CURRENT is clamped to 0.0-0.8 pu (~8 A) on both the ESP32
# and the unit. 1.0 pu is nominally 10 A.
CAL_FIXED_CURRENT_MAX_PU: Final = 0.8

# The per-unit capture windows the firmware checks against. A reading between
# the two is rejected with PU_RANGE because the firmware cannot tell which
# point was meant.
CAL_PU_LOW_MAX: Final = 0.2
CAL_PU_HIGH_MIN: Final = 0.8

# Dead-man timer: a slot in calibration drops its reference after 120 s with
# no calibration command (BTS_CAL_DEADMAN_PASSES).
CAL_DEADMAN_S: Final = 120.0
