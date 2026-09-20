"""Byte-exact codecs for the GATT records in ``ble_proto.h``.

Every format string here was verified field-by-field against the header, not
transcribed from a specification. That distinction is not pedantry: all three
client bugs recorded in ``Docs/ble-specification.md`` section 11 came from
writing a ``struct`` format out of a design document, and none of them was
caught by testing, because a dry run never serialises a byte.

``tests/test_protocol.py`` re-derives these offsets from the header itself and
fails if the two drift apart.

ENDIANNESS
----------
GATT records are **little**-endian; the BTS I2C register wire format is
**big**-endian. They are opposite. Everything in this module is little-endian
("<"); the big-endian conversion lives in :mod:`.registers` and nothing above
the transport ever sees the C2000's byte order.

DECODING IS PREFIX-TOLERANT
---------------------------
The interface is append-only, so a longer record than we expect means a newer
firmware appended a field. Each decoder takes the prefix it understands rather
than rejecting on length inequality. A record *shorter* than expected is a
real error - it means truncation, usually a notification sent at the default
23-byte ATT MTU before the MTU was negotiated.
"""

from __future__ import annotations

import struct
from dataclasses import dataclass
from typing import ClassVar, Final

from ..const import (
    CalResult,
    CalStatusBit,
    CellChemistry,
    SlotFault,
    SlotState,
    StatusBit,
    UnitState,
)


class ProtocolError(ValueError):
    """A record could not be decoded, or a value could not be encoded."""


def _uuid(discriminator: int) -> str:
    """Build a service UUID from its 16-bit discriminator.

    Every UUID in the service is the same 128-bit base with the discriminator
    substituted into bytes 2-3 of the leading group. Discriminators are
    allocated sequentially and are never renumbered - they are the client's
    contract.
    """
    return f"e5f1{discriminator:04x}-9a4c-4b7d-8f2e-1c3a5b7d9f01"


SERVICE_UUID: Final = _uuid(0x0001)
UNIT_STATUS_UUID: Final = _uuid(0x0002)
COMMAND_UUID: Final = _uuid(0x0003)
SLOT_SELECT_UUID: Final = _uuid(0x0004)
SLOT_CONFIG_UUID: Final = _uuid(0x0005)
SLOT_RESULT_UUID: Final = _uuid(0x0006)
SLOT_SERIAL_UUID: Final = _uuid(0x0007)
CATALOG_INDEX_UUID: Final = _uuid(0x0008)
CATALOG_ENTRY_UUID: Final = _uuid(0x0009)
SLOT_STATUS_UUID: Final = _uuid(0x000A)
CAL_CONTROL_UUID: Final = _uuid(0x000B)
CAL_STATUS_UUID: Final = _uuid(0x000C)
#: Register access, added for BLE_PROTO_VERSION 4. Absent on older firmware,
#: which is why every use of it is feature-detected rather than version-gated.
REGISTER_UUID: Final = _uuid(0x000D)

NOTIFY_UUIDS: Final = (UNIT_STATUS_UUID, SLOT_STATUS_UUID, CAL_STATUS_UUID)


# --- wire formats -----------------------------------------------------------
#
# Each is annotated with the C field it covers so a reviewer can diff against
# ble_proto.h without leaving this file.

# ble_unit_status_t, 24 B (proto 3; was 20 B in proto 2 before
# watchdog_timeout_s was appended).
#   B version  B slot_count  B online  B unit_state
#   I trip_status  f input_voltage_v  I uptime_s
#   B stats_live  B wifi_connected  H reserved  f watchdog_timeout_s
UNIT_STATUS_FMT: Final = "<BBBBIfIBBHf"
UNIT_STATUS_LEN: Final = struct.calcsize(UNIT_STATUS_FMT)

# ble_slot_status_t, 68 B (proto 3; was 40 B before the bts_* block).
#   B slot  B state  B fault  B configured
#   f voltage_v  f current_a  f temp_c  f live_mah  f live_mwh  f progress
#   I elapsed_s  I state_elapsed_s  I status_bits
#   B bts_paused  B bts_wd_tripped  B bts_restored  B bts_ended
#   f bts_charge_mah  f bts_charge_mwh  f bts_charge_seconds
#   f bts_discharge_mah  f bts_discharge_mwh  f bts_discharge_seconds
SLOT_STATUS_FMT: Final = "<BBBBffffffIIIBBBBffffff"
SLOT_STATUS_LEN: Final = struct.calcsize(SLOT_STATUS_FMT)

#: The proto-2 prefix, for decoding a record from older firmware.
SLOT_STATUS_V2_FMT: Final = "<BBBBffffffIII"
SLOT_STATUS_V2_LEN: Final = struct.calcsize(SLOT_STATUS_V2_FMT)

# ble_slot_config_t, 80 B.
SLOT_CONFIG_FMT: Final = "<BBBBffffI24s32s"
SLOT_CONFIG_LEN: Final = struct.calcsize(SLOT_CONFIG_FMT)

# ble_slot_result_t, 116 B. Eleven floats at offsets 4-44, then a uint32, then
# completed_unix as an int64 at offset 52.
SLOT_RESULT_FMT: Final = "<BBBB" + "f" * 11 + "Iq24s32s"
SLOT_RESULT_LEN: Final = struct.calcsize(SLOT_RESULT_FMT)

# ble_catalog_entry_t, 96 B.
CATALOG_ENTRY_FMT: Final = "<BBBBffffffffffI24s24s"
CATALOG_ENTRY_LEN: Final = struct.calcsize(CATALOG_ENTRY_FMT)

# ble_cmd_t, 4 B.
COMMAND_FMT: Final = "<BBH"
COMMAND_LEN: Final = struct.calcsize(COMMAND_FMT)

# ble_cal_cmd_t, 8 B.
CAL_CMD_FMT: Final = "<BBHf"
CAL_CMD_LEN: Final = struct.calcsize(CAL_CMD_FMT)

# ble_cal_status_t, 48 B. The ticks are at offsets 2-3 and `result` is a
# uint32 at offset 8 - an earlier client had them at the end with result as a
# uint8, and because its length check was "< 44" a 48-byte record passed and
# misdecoded silently.
CAL_STATUS_FMT: Final = "<BBBBII" + "f" * 9
CAL_STATUS_LEN: Final = struct.calcsize(CAL_STATUS_FMT)

# ble_register_cmd_t / ble_register_value_t, characteristic 000d (proto 4).
#   H addr  B write  B count  f value
REGISTER_CMD_FMT: Final = "<HBBf"
REGISTER_CMD_LEN: Final = struct.calcsize(REGISTER_CMD_FMT)

# These sizes are the contract with the firmware. A mismatch means this file
# and ble_proto.h have drifted, which must fail loudly at import rather than
# produce plausible-looking rubbish at runtime.
assert UNIT_STATUS_LEN == 24, UNIT_STATUS_LEN
assert SLOT_STATUS_LEN == 68, SLOT_STATUS_LEN
assert SLOT_CONFIG_LEN == 80, SLOT_CONFIG_LEN
assert SLOT_RESULT_LEN == 116, SLOT_RESULT_LEN
assert CATALOG_ENTRY_LEN == 96, CATALOG_ENTRY_LEN
assert COMMAND_LEN == 4, COMMAND_LEN
assert CAL_CMD_LEN == 8, CAL_CMD_LEN
assert CAL_STATUS_LEN == 48, CAL_STATUS_LEN


def _text(raw: bytes) -> str:
    """Decode a fixed-width character field.

    These are not C strings: the firmware copies ``sizeof - 1`` bytes and
    NUL-terminates itself, so a client must split on the first NUL and must
    not assume one is present.
    """
    return raw.split(b"\0", 1)[0].decode("utf-8", errors="replace").strip()


def _fixed(value: str, size: int) -> bytes:
    """Encode a string into a fixed-width field, zero-filling the tail."""
    raw = value.encode("utf-8")[: size - 1]
    return raw.ljust(size, b"\0")


def _require(data: bytes, minimum: int, what: str) -> None:
    if len(data) < minimum:
        raise ProtocolError(
            f"{what}: got {len(data)} bytes, need at least {minimum}. "
            "A short record usually means the ATT MTU was not negotiated "
            "before subscribing - a 68-byte notification is truncated to 20 "
            "at the default 23-byte MTU."
        )


@dataclass(frozen=True, slots=True)
class UnitStatus:
    """Decoded ``ble_unit_status_t``."""

    version: int
    slot_count: int
    online: bool
    unit_state: UnitState
    trip_status: int
    input_voltage_v: float
    uptime_s: int
    stats_live: bool
    wifi_connected: bool
    watchdog_timeout_s: float

    @classmethod
    def decode(cls, data: bytes) -> "UnitStatus":
        # Proto 2 emitted 20 bytes without watchdog_timeout_s. Accept it and
        # report the watchdog as disabled rather than refusing the device.
        _require(data, 20, "unit status")
        if len(data) >= UNIT_STATUS_LEN:
            fields = struct.unpack(UNIT_STATUS_FMT, data[:UNIT_STATUS_LEN])
            watchdog = fields[10]
        else:
            fields = struct.unpack("<BBBBIfIBBH", data[:20]) + (0.0,)
            watchdog = 0.0
        try:
            state = UnitState(fields[3])
        except ValueError:
            state = UnitState.INPUT_OK
        return cls(
            version=fields[0],
            slot_count=fields[1],
            online=bool(fields[2]),
            unit_state=state,
            trip_status=fields[4],
            input_voltage_v=fields[5],
            uptime_s=fields[6],
            stats_live=bool(fields[7]),
            wifi_connected=bool(fields[8]),
            watchdog_timeout_s=watchdog,
        )

    @property
    def watchdog_armed(self) -> bool:
        """Whether host supervision is active.

        A timeout of 0 disables the watchdog entirely, which is a bench-only
        setting: it removes the only thing that stops the converters when the
        host goes away mid-run.
        """
        return self.watchdog_timeout_s > 0.0


@dataclass(frozen=True, slots=True)
class SlotStatus:
    """Decoded ``ble_slot_status_t``."""

    slot: int
    state: SlotState
    fault: SlotFault
    configured: bool
    voltage_v: float
    current_a: float
    temp_c: float
    live_mah: float
    live_mwh: float
    progress: float
    elapsed_s: int
    state_elapsed_s: int
    status_bits: int
    bts_paused: bool = False
    bts_wd_tripped: bool = False
    bts_restored: bool = False
    bts_ended: bool = False
    bts_charge_mah: float = 0.0
    bts_charge_mwh: float = 0.0
    bts_charge_seconds: float = 0.0
    bts_discharge_mah: float = 0.0
    bts_discharge_mwh: float = 0.0
    bts_discharge_seconds: float = 0.0

    @classmethod
    def decode(cls, data: bytes) -> "SlotStatus":
        _require(data, SLOT_STATUS_V2_LEN, "slot status")
        head = struct.unpack(SLOT_STATUS_V2_FMT, data[:SLOT_STATUS_V2_LEN])
        try:
            state = SlotState(head[1])
        except ValueError:
            state = SlotState.IDLE
        try:
            fault = SlotFault(head[2])
        except ValueError:
            fault = SlotFault.NONE

        tail: tuple = ()
        if len(data) >= SLOT_STATUS_LEN:
            tail = struct.unpack("<BBBBffffff", data[40:SLOT_STATUS_LEN])

        return cls(
            slot=head[0],
            state=state,
            fault=fault,
            configured=bool(head[3]),
            voltage_v=head[4],
            current_a=head[5],
            temp_c=head[6],
            live_mah=head[7],
            live_mwh=head[8],
            progress=head[9],
            elapsed_s=head[10],
            state_elapsed_s=head[11],
            status_bits=head[12],
            bts_paused=bool(tail[0]) if tail else False,
            bts_wd_tripped=bool(tail[1]) if tail else False,
            bts_restored=bool(tail[2]) if tail else False,
            bts_ended=bool(tail[3]) if tail else False,
            bts_charge_mah=tail[4] if tail else 0.0,
            bts_charge_mwh=tail[5] if tail else 0.0,
            bts_charge_seconds=tail[6] if tail else 0.0,
            bts_discharge_mah=tail[7] if tail else 0.0,
            bts_discharge_mwh=tail[8] if tail else 0.0,
            bts_discharge_seconds=tail[9] if tail else 0.0,
        )

    @property
    def status(self) -> StatusBit:
        """The raw BTS status word as a flag set."""
        return StatusBit(self.status_bits & 0xFFFFFF)

    @property
    def is_running(self) -> bool:
        return bool(self.status_bits & StatusBit.RUNNING)

    @property
    def is_charging(self) -> bool:
        """Charging *now* - the direction bit alone is stale once paused."""
        return bool(self.status_bits & StatusBit.CHARGING) and self.is_running

    @property
    def is_discharging(self) -> bool:
        return bool(self.status_bits & StatusBit.DISCHARGING) and self.is_running

    @property
    def is_paused(self) -> bool:
        return bool(self.status_bits & StatusBit.PAUSED) or self.bts_paused

    @property
    def resume_direction(self) -> str | None:
        """What a paused slot would resume into.

        PAUSED is not a direction of its own: the slot keeps its CHARGING or
        DISCHARGING bit set alongside it precisely so this is answerable.
        """
        if not self.is_paused:
            return None
        if self.status_bits & StatusBit.CHARGING:
            return "charge"
        if self.status_bits & StatusBit.DISCHARGING:
            return "discharge"
        return None

    @property
    def needs_operator(self) -> bool:
        """Whether resuming requires an explicit operator decision.

        A watchdog pause means the link died mid-run; a restore means the unit
        reset and the cell in the holder may not be the cell the counters
        belong to. Neither may be auto-resumed.
        """
        return self.bts_wd_tripped or self.bts_restored or bool(
            self.status_bits & (StatusBit.WD_TRIPPED | StatusBit.RESTORED)
        )


@dataclass(frozen=True, slots=True)
class SlotConfig:
    """``ble_slot_config_t``.

    The read and the write address different slots: a read returns the slot
    named by slot-select, a write applies to the payload's own ``slot`` field.
    Always set ``slot`` when encoding.
    """

    slot: int
    chemistry: CellChemistry
    auto_recharge: bool
    capacity_mah: float
    charge_c: float
    discharge_c: float
    shipping_pct: float
    max_duration_minutes: int
    model_name: str
    serial: str

    @classmethod
    def decode(cls, data: bytes) -> "SlotConfig":
        _require(data, SLOT_CONFIG_LEN, "slot config")
        f = struct.unpack(SLOT_CONFIG_FMT, data[:SLOT_CONFIG_LEN])
        try:
            chem = CellChemistry(f[1])
        except ValueError:
            chem = CellChemistry.NMC
        return cls(
            slot=f[0],
            chemistry=chem,
            auto_recharge=bool(f[2]),
            capacity_mah=f[4],
            charge_c=f[5],
            discharge_c=f[6],
            shipping_pct=f[7],
            max_duration_minutes=f[8],
            model_name=_text(f[9]),
            serial=_text(f[10]),
        )

    def encode(self) -> bytes:
        if not 0 <= self.slot < 8:
            raise ProtocolError(f"slot {self.slot} out of range 0-7")
        if not 0 <= int(self.chemistry) < 5:
            raise ProtocolError(f"chemistry {self.chemistry} out of range 0-4")
        return struct.pack(
            SLOT_CONFIG_FMT,
            self.slot,
            int(self.chemistry),
            1 if self.auto_recharge else 0,
            0,
            self.capacity_mah,
            self.charge_c,
            self.discharge_c,
            self.shipping_pct,
            self.max_duration_minutes,
            _fixed(self.model_name, 24),
            _fixed(self.serial, 32),
        )


@dataclass(frozen=True, slots=True)
class SlotResult:
    """``ble_slot_result_t``."""

    slot: int
    valid: bool
    chemistry: CellChemistry
    recharged: bool
    start_voltage_v: float
    end_voltage_v: float
    rested_voltage_v: float
    discharge_mah: float
    discharge_mwh: float
    max_temp_c: float
    max_current_a: float
    min_voltage_v: float
    max_voltage_v: float
    recharge_mah: float
    shipping_voltage_v: float
    discharge_seconds: int
    #: NOT a Unix epoch despite the C field name - it is seconds of ESP32
    #: uptime. The device has no real-time clock, so a caller that needs a
    #: wall clock must stamp it on retrieval.
    completed_uptime_s: int
    model_name: str
    serial: str

    @classmethod
    def decode(cls, data: bytes) -> "SlotResult":
        _require(data, SLOT_RESULT_LEN, "slot result")
        f = struct.unpack(SLOT_RESULT_FMT, data[:SLOT_RESULT_LEN])
        try:
            chem = CellChemistry(f[2])
        except ValueError:
            chem = CellChemistry.NMC
        return cls(
            slot=f[0],
            valid=bool(f[1]),
            chemistry=chem,
            recharged=bool(f[3]),
            start_voltage_v=f[4],
            end_voltage_v=f[5],
            rested_voltage_v=f[6],
            discharge_mah=f[7],
            discharge_mwh=f[8],
            max_temp_c=f[9],
            max_current_a=f[10],
            min_voltage_v=f[11],
            max_voltage_v=f[12],
            recharge_mah=f[13],
            shipping_voltage_v=f[14],
            discharge_seconds=f[15],
            completed_uptime_s=f[16],
            model_name=_text(f[17]),
            serial=_text(f[18]),
        )


@dataclass(frozen=True, slots=True)
class CatalogEntry:
    """``ble_catalog_entry_t``.

    The catalogue is one flat list: chemistries occupy ``[0, chem_count)`` and
    models follow. An index past the end returns a record that is zero apart
    from ``index`` and ``total``, which is how a client finds the end.
    """

    index: int
    kind: int
    chemistry: CellChemistry
    total: int
    capacity_mah: float
    charge_v_max: float
    discharge_v_min: float
    storage_v: float
    charge_c: float
    discharge_c: float
    charge_current_max_a: float
    discharge_current_max_a: float
    temp_min_c: float
    temp_max_c: float
    rest_minutes: int
    name: str
    manufacturer: str

    KIND_CHEMISTRY: ClassVar[int] = 0
    KIND_MODEL: ClassVar[int] = 1

    @classmethod
    def decode(cls, data: bytes) -> "CatalogEntry":
        _require(data, CATALOG_ENTRY_LEN, "catalog entry")
        f = struct.unpack(CATALOG_ENTRY_FMT, data[:CATALOG_ENTRY_LEN])
        try:
            chem = CellChemistry(f[2])
        except ValueError:
            chem = CellChemistry.NMC
        return cls(
            index=f[0],
            kind=f[1],
            chemistry=chem,
            total=f[3],
            capacity_mah=f[4],
            charge_v_max=f[5],
            discharge_v_min=f[6],
            storage_v=f[7],
            charge_c=f[8],
            discharge_c=f[9],
            charge_current_max_a=f[10],
            discharge_current_max_a=f[11],
            temp_min_c=f[12],
            temp_max_c=f[13],
            rest_minutes=f[14],
            name=_text(f[15]),
            manufacturer=_text(f[16]),
        )

    @property
    def is_model(self) -> bool:
        return self.kind == CatalogEntry.KIND_MODEL


@dataclass(frozen=True, slots=True)
class CalStatus:
    """``ble_cal_status_t``.

    Unit-scoped: it reports the slot the *unit* has under calibration
    (``eCalSlot``), unaffected by slot-select.
    """

    #: 255 means no slot is under calibration.
    slot: int
    active: bool
    v_tick: bool
    i_tick: bool
    status_bits: int
    result: CalResult
    ads_v_pu: float
    ads_i_pu: float
    ads_v_v: float
    ads_i_a: float
    f28_v_pu: float
    f28_i_pu: float
    f28_v_v: float
    f28_i_a: float
    temp_c: float

    NO_SLOT: ClassVar[int] = 255

    @classmethod
    def decode(cls, data: bytes) -> "CalStatus":
        _require(data, CAL_STATUS_LEN, "calibration status")
        f = struct.unpack(CAL_STATUS_FMT, data[:CAL_STATUS_LEN])
        try:
            result = CalResult(f[5])
        except ValueError:
            result = CalResult.OK
        return cls(
            slot=f[0],
            active=bool(f[1]),
            v_tick=bool(f[2]),
            i_tick=bool(f[3]),
            status_bits=f[4],
            result=result,
            ads_v_pu=f[6],
            ads_i_pu=f[7],
            ads_v_v=f[8],
            ads_i_a=f[9],
            f28_v_pu=f[10],
            f28_i_pu=f[11],
            f28_v_v=f[12],
            f28_i_a=f[13],
            temp_c=f[14],
        )

    @property
    def status(self) -> CalStatusBit:
        return CalStatusBit(self.status_bits)

    @property
    def failed(self) -> bool:
        """Whether the last command was refused.

        Bit 9 and a non-zero result say the same thing; both are checked
        because the ATT response carries no diagnosis at all.
        """
        return bool(self.status_bits & CalStatusBit.LAST_COMMAND_FAILED) or (
            self.result != CalResult.OK
        )


def encode_command(opcode: int, slot: int = 0) -> bytes:
    """Encode ``ble_cmd_t`` for characteristic 0003.

    Self-addressed: the slot is in the payload, not taken from slot-select.
    """
    if not 0 <= slot < 8:
        raise ProtocolError(f"slot {slot} out of range 0-7")
    return struct.pack(COMMAND_FMT, int(opcode), slot, 0)


def encode_cal_command(opcode: int, slot: int = 0, arg: float = 0.0) -> bytes:
    """Encode ``ble_cal_cmd_t`` for characteristic 000b.

    Only ENTER reads the ``slot`` byte; for every other opcode the slot is
    whatever the unit already holds in ``eCalSlot``.
    """
    if not 0 <= slot < 8:
        raise ProtocolError(f"slot {slot} out of range 0-7")
    return struct.pack(CAL_CMD_FMT, int(opcode), slot, 0, float(arg))


def encode_register_cmd(addr: int, value: float = 0.0, write: bool = False) -> bytes:
    """Encode a register access for characteristic 000d (proto 4)."""
    if not 0 <= addr <= 0xFFFF:
        raise ProtocolError(f"register address {addr} out of range")
    return struct.pack(REGISTER_CMD_FMT, addr, 1 if write else 0, 1, float(value))


def decode_register_value(data: bytes) -> tuple[int, float]:
    """Decode a register read reply from characteristic 000d."""
    _require(data, REGISTER_CMD_LEN, "register value")
    addr, _write, _count, value = struct.unpack(
        REGISTER_CMD_FMT, data[:REGISTER_CMD_LEN]
    )
    return addr, value
