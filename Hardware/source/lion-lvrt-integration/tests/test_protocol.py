"""Protocol codec tests.

The most valuable test here is :func:`test_layouts_match_firmware_header`,
which parses ``ble_proto.h`` and compares it field-by-field against the
``struct`` formats. Every client bug recorded in ``ble-specification.md``
section 11 was a silent layout drift that no behavioural test could catch,
because a test that builds objects directly never serialises a byte.
"""

from __future__ import annotations

import re
import struct
from pathlib import Path

import pytest

from custom_components.lion_lvrt.const import (
    CellChemistry,
    SlotFault,
    SlotState,
    StatusBit,
    UnitState,
)
from custom_components.lion_lvrt.protocol import ble as proto

#: The firmware header, relative to the repository root.
HEADER = (
    Path(__file__).resolve().parents[2]
    / "esp32-btle-proxy"
    / "components"
    / "ble_svc"
    / "include"
    / "ble_proto.h"
)

_C_SIZES = {
    "uint8_t": 1,
    "int8_t": 1,
    "uint16_t": 2,
    "int16_t": 2,
    "uint32_t": 4,
    "int32_t": 4,
    "int64_t": 8,
    "uint64_t": 8,
    "float": 4,
    "char": 1,
}

_PY_SIZES = {"B": 1, "b": 1, "H": 2, "h": 2, "I": 4, "i": 4, "q": 8, "Q": 8, "f": 4}


def _parse_header() -> dict[str, list[tuple[int, str, str, int]]]:
    """Extract every packed struct as (offset, ctype, name, count)."""
    if not HEADER.exists():  # pragma: no cover - only on a partial checkout
        pytest.skip(f"firmware header not found at {HEADER}")
    text = HEADER.read_text(encoding="utf-8", errors="replace")
    out: dict[str, list[tuple[int, str, str, int]]] = {}
    pattern = re.compile(
        r"typedef struct __attribute__\(\(packed\)\)\s*\{(.*?)\}\s*(\w+);", re.S
    )
    field_re = re.compile(
        r"^\s*(u?int(?:8|16|32|64)_t|float|char)\s+(\w+)\s*(?:\[(\d+)\])?\s*;"
    )
    for body, name in pattern.findall(text):
        offset = 0
        fields: list[tuple[int, str, str, int]] = []
        for raw_line in body.splitlines():
            line = re.sub(r"/\*.*?\*/", "", raw_line)
            match = field_re.match(line)
            if not match:
                continue
            ctype, field_name, array = match.groups()
            count = int(array) if array else 1
            fields.append((offset, ctype, field_name, count))
            offset += _C_SIZES[ctype] * count
        out[name] = fields
    return out


def _format_offsets(fmt: str) -> list[int]:
    """Byte offsets of each field in a struct format string."""
    offsets: list[int] = []
    offset = 0
    for token in re.findall(r"(\d*)([BbHhIiqQfs])", fmt):
        repeat, code = token
        if code == "s":
            offsets.append(offset)
            offset += int(repeat or 1)
        else:
            for _ in range(int(repeat or 1)):
                offsets.append(offset)
                offset += _PY_SIZES[code]
    return offsets


@pytest.mark.parametrize(
    ("c_name", "fmt"),
    [
        ("ble_unit_status_t", proto.UNIT_STATUS_FMT),
        ("ble_slot_status_t", proto.SLOT_STATUS_FMT),
        ("ble_slot_config_t", proto.SLOT_CONFIG_FMT),
        ("ble_slot_result_t", proto.SLOT_RESULT_FMT),
        ("ble_catalog_entry_t", proto.CATALOG_ENTRY_FMT),
        ("ble_cmd_t", proto.COMMAND_FMT),
        ("ble_cal_cmd_t", proto.CAL_CMD_FMT),
        ("ble_cal_status_t", proto.CAL_STATUS_FMT),
    ],
)
def test_layouts_match_firmware_header(c_name: str, fmt: str) -> None:
    """Each struct format must match the header field for field.

    Where the two disagree, the header wins - this test tells you which one
    moved, rather than letting a plausible-looking float reach a dashboard.
    """
    structs = _parse_header()
    assert c_name in structs, f"{c_name} not found in {HEADER.name}"
    fields = structs[c_name]

    c_size = fields[-1][0] + _C_SIZES[fields[-1][1]] * fields[-1][3]
    assert struct.calcsize(fmt) == c_size, (
        f"{c_name} is {c_size} B in the header but {struct.calcsize(fmt)} B "
        f"in the Python format"
    )

    py_offsets = _format_offsets(fmt)
    c_offsets = [f[0] for f in fields]
    assert py_offsets == c_offsets, (
        f"{c_name} field offsets differ.\n"
        f"  header: {c_offsets}\n"
        f"  python: {py_offsets}"
    )


def test_uuid_derivation() -> None:
    assert proto.SERVICE_UUID == "e5f10001-9a4c-4b7d-8f2e-1c3a5b7d9f01"
    assert proto.SLOT_STATUS_UUID == "e5f1000a-9a4c-4b7d-8f2e-1c3a5b7d9f01"
    assert proto.CAL_STATUS_UUID == "e5f1000c-9a4c-4b7d-8f2e-1c3a5b7d9f01"


def test_unit_status_roundtrip() -> None:
    raw = struct.pack(
        proto.UNIT_STATUS_FMT, 3, 8, 1, 2, 0, 12.5, 3600, 0, 1, 0, 30.0
    )
    unit = proto.UnitStatus.decode(raw)
    assert unit.version == 3
    assert unit.unit_state is UnitState.INPUT_OK
    assert unit.input_voltage_v == pytest.approx(12.5)
    assert unit.watchdog_armed


def test_unit_status_accepts_proto2_record() -> None:
    """A 20-byte record from older firmware decodes, watchdog reported off."""
    raw = struct.pack("<BBBBIfIBBH", 2, 8, 1, 2, 0, 12.0, 10, 0, 0, 0)
    unit = proto.UnitStatus.decode(raw)
    assert unit.version == 2
    assert unit.watchdog_timeout_s == 0.0
    assert not unit.watchdog_armed


def test_short_record_is_rejected_loudly() -> None:
    """Truncation must fail, not decode a prefix as if it were complete.

    A 68-byte notification is cut to 20 bytes at the default 23-byte MTU; a
    client that accepted that would report a plausible wrong voltage.
    """
    with pytest.raises(proto.ProtocolError, match="MTU"):
        proto.SlotStatus.decode(b"\0" * 20)


def test_slot_status_longer_record_decodes_prefix() -> None:
    """A future firmware appending a field must not break this client."""
    raw = _slot_status(slot=1) + b"\xAA" * 16
    status = proto.SlotStatus.decode(raw)
    assert status.slot == 1


def _slot_status(**kwargs) -> bytes:
    values = {
        "slot": 0, "state": int(SlotState.DISCHARGE), "fault": 0, "configured": 1,
        "voltage_v": 3.7, "current_a": -1.5, "temp_c": 25.0,
        "live_mah": 100.0, "live_mwh": 370.0, "progress": 0.05,
        "elapsed_s": 60, "state_elapsed_s": 30, "status_bits": 0,
        "bts_paused": 0, "bts_wd_tripped": 0, "bts_restored": 0, "bts_ended": 0,
        "bts_charge_mah": 0.0, "bts_charge_mwh": 0.0, "bts_charge_seconds": 0.0,
        "bts_discharge_mah": 0.0, "bts_discharge_mwh": 0.0,
        "bts_discharge_seconds": 0.0,
    }
    values.update(kwargs)
    return struct.pack(proto.SLOT_STATUS_FMT, *values.values())


def test_paused_slot_keeps_its_direction() -> None:
    """PAUSED is not a direction: the slot says what it would resume into."""
    bits = int(StatusBit.PAUSED | StatusBit.CHARGING | StatusBit.STOPPED)
    status = proto.SlotStatus.decode(
        _slot_status(status_bits=bits, bts_paused=1)
    )
    assert status.is_paused
    assert status.resume_direction == "charge"
    # Not charging *now* - the converter is off.
    assert not status.is_charging


def test_watchdog_pause_needs_an_operator() -> None:
    bits = int(StatusBit.PAUSED | StatusBit.DISCHARGING | StatusBit.WD_TRIPPED)
    status = proto.SlotStatus.decode(
        _slot_status(status_bits=bits, bts_paused=1, bts_wd_tripped=1)
    )
    assert status.needs_operator
    assert status.resume_direction == "discharge"


def test_restored_pause_needs_an_operator() -> None:
    """A restored run may hold a cell swapped while the unit was off."""
    bits = int(StatusBit.PAUSED | StatusBit.RESTORED)
    status = proto.SlotStatus.decode(
        _slot_status(status_bits=bits, bts_restored=1)
    )
    assert status.needs_operator


def test_fixed_width_strings_are_not_c_strings() -> None:
    """Fields are fixed width with no guaranteed NUL - split on the first."""
    config = proto.SlotConfig(
        slot=2,
        chemistry=CellChemistry.LFP,
        auto_recharge=True,
        capacity_mah=3000.0,
        charge_c=0.5,
        discharge_c=1.0,
        shipping_pct=60.0,
        max_duration_minutes=480,
        model_name="Samsung 30Q",
        serial="SN-0001",
    )
    raw = config.encode()
    assert len(raw) == proto.SLOT_CONFIG_LEN
    # The model name sits at offset 24 for 24 bytes. An earlier client sliced
    # this at 28:52 and silently read the wrong field.
    assert raw[24:48].split(b"\0")[0] == b"Samsung 30Q"
    assert proto.SlotConfig.decode(raw) == config


def test_config_rejects_out_of_range() -> None:
    def build(**kw):
        base = dict(
            slot=0, chemistry=CellChemistry.NMC, auto_recharge=False,
            capacity_mah=0.0, charge_c=0.0, discharge_c=0.0,
            shipping_pct=60.0, max_duration_minutes=0,
            model_name="", serial="",
        )
        base.update(kw)
        return proto.SlotConfig(**base)

    with pytest.raises(proto.ProtocolError, match="slot"):
        build(slot=8).encode()


def test_command_encoding_is_exact_length() -> None:
    assert len(proto.encode_command(1, 3)) == 4
    with pytest.raises(proto.ProtocolError):
        proto.encode_command(1, 99)


def test_cal_status_field_order() -> None:
    """Ticks at offsets 2-3 and result as a uint32 at offset 8.

    An earlier client placed the ticks at the end and result as a uint8 at
    offset 1, with a length check of "< 44" that let a 48-byte record through
    to be misdecoded rather than rejected.
    """
    raw = struct.pack(
        proto.CAL_STATUS_FMT, 2, 1, 1, 0, 0x021, 0, *([0.15] * 9)
    )
    status = proto.CalStatus.decode(raw)
    assert status.slot == 2
    assert status.v_tick is True
    assert status.i_tick is False
    assert int(status.result) == 0
    assert status.ads_v_pu == pytest.approx(0.15)


def test_cal_status_no_slot_sentinel() -> None:
    raw = struct.pack(proto.CAL_STATUS_FMT, 255, 0, 0, 0, 0, 0, *([0.0] * 9))
    assert proto.CalStatus.decode(raw).slot == proto.CalStatus.NO_SLOT


def test_unknown_enum_values_do_not_crash() -> None:
    """Firmware may add a state before this client knows it."""
    status = proto.SlotStatus.decode(_slot_status(state=200, fault=200))
    assert status.state is SlotState.IDLE
    assert status.fault is SlotFault.NONE
