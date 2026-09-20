"""Register map tests.

These guard the arithmetic that the firmware's own development rules single
out: *"Assuming ten registers per channel everywhere is the single most common
bug in this codebase and produced silent cross-channel corruption."*

They also pin the one place where the two hand-maintained register headers
have provably drifted.
"""

from __future__ import annotations

import re
import struct
from pathlib import Path

import pytest

from custom_components.lion_lvrt.protocol import registers as regs

SOURCE_ROOT = Path(__file__).resolve().parents[2]
C2000_HEADER = SOURCE_ROOT / "tida-010086" / "bts_F2837xD_8ch" / "registers.h"
ESP32_MIRROR = (
    SOURCE_ROOT
    / "esp32-btle-proxy"
    / "components"
    / "bts_link"
    / "include"
    / "bts_regs.h"
)


def _c2000_enum() -> dict[str, int]:
    """Parse the ``RegisterAddress`` enum from the C2000 header."""
    if not C2000_HEADER.exists():  # pragma: no cover
        pytest.skip(f"C2000 header not found at {C2000_HEADER}")
    text = C2000_HEADER.read_text(encoding="utf-8", errors="replace")
    return {
        name: int(value)
        for name, value in re.findall(r"^\s*(e\w+)\s*=\s*(\d+)\s*,", text, re.M)
    }


# --- address arithmetic -----------------------------------------------------


def test_runtime_block_geometry() -> None:
    """Channel 7's runtime block must end immediately before the settings base."""
    assert regs.rt_addr(0, regs.RT_STATUS) == 0
    assert regs.rt_addr(7, regs.RT_DISCHARGE_SECONDS) == 380
    last = regs.rt_addr(7, regs.RT_DISCHARGE_SECONDS) + regs.REGISTER_SIZE
    assert last == regs.SET_BASE


def test_settings_block_geometry() -> None:
    """Channel 7's settings block must end immediately before the unit base."""
    assert regs.set_addr(0, regs.SET_MODE) == 384
    assert regs.set_addr(7, 92) + regs.REGISTER_SIZE == regs.UNIT_BASE


def test_blocks_do_not_share_a_stride() -> None:
    """The regression this guards produced cross-channel corruption in v1."""
    assert regs.RT_STRIDE != regs.SET_STRIDE
    for ch in range(1, 8):
        assert regs.rt_addr(ch, 0) - regs.rt_addr(ch - 1, 0) == 48
        assert regs.set_addr(ch, 0) - regs.set_addr(ch - 1, 0) == 96


def test_channel_range_is_enforced() -> None:
    for bad in (-1, 8, 99):
        with pytest.raises(ValueError, match="channel"):
            regs.rt_addr(bad, 0)
        with pytest.raises(ValueError, match="channel"):
            regs.set_addr(bad, 0)


def test_calibration_block_offsets() -> None:
    """The 12 calibration registers keep their order at settings offset 44."""
    assert regs.cal_addr(0, regs.CAL_F28V_GAIN) == 384 + 44
    assert regs.cal_addr(0, regs.CAL_VOUT_OFFSET_V) == 384 + 44 + 44
    # And they must not spill into the next channel's block.
    assert regs.cal_addr(0, regs.CAL_VOUT_OFFSET_V) < regs.set_addr(1, 0)


@pytest.mark.parametrize(
    ("enum_name", "constant"),
    [
        ("eChargeDisableV", regs.REG_CHARGE_DISABLE_V),
        ("eChargeRestrictV", regs.REG_CHARGE_RESTRICT_V),
        ("eDischargeRestrictV", regs.REG_DISCHARGE_RESTRICT_V),
        ("eDischargeDisableV", regs.REG_DISCHARGE_DISABLE_V),
        ("eUnitState", regs.REG_UNIT_STATE),
        ("eInputVoltage", regs.REG_INPUT_VOLTAGE),
        ("eTripStatus", regs.REG_TRIP_STATUS),
        ("eHostWatchdog_s", regs.REG_HOST_WATCHDOG_S),
        ("eCalSlot", regs.REG_CAL_SLOT),
        ("eCalCommand", regs.REG_CAL_COMMAND),
        ("eCalArgument", regs.REG_CAL_ARGUMENT),
        ("eCalStatus", regs.REG_CAL_STATUS),
        ("eCalResult", regs.REG_CAL_RESULT),
        ("eWatchdogRemaining_s", regs.REG_WATCHDOG_REMAINING_S),
        ("eCalAdsV_pu", regs.REG_CAL_ADS_V_PU),
        ("eCalTemp_C", regs.REG_CAL_TEMP_C),
    ],
)
def test_unit_addresses_match_the_c2000(enum_name: str, constant: int) -> None:
    """The C2000 header is the authority - it is the array being indexed."""
    enum = _c2000_enum()
    assert enum_name in enum, f"{enum_name} missing from registers.h"
    assert enum[enum_name] == constant


def test_cal_telemetry_base_follows_the_c2000_not_the_mirror() -> None:
    """The ESP32 mirror has drifted; we must follow the C2000.

    ``eWatchdogRemaining_s`` occupies 1220 on the C2000, so calibration
    telemetry starts at 1224. The ESP32 mirror omits that register entirely
    and starts its window at 1220, which shifts all nine telemetry floats one
    register low - ``ads_v_pu`` would actually carry the watchdog countdown.
    """
    enum = _c2000_enum()
    assert enum["eWatchdogRemaining_s"] == 1220
    assert enum["eCalAdsV_pu"] == 1224
    assert regs.CAL_TELEMETRY_BASE == 1224

    if ESP32_MIRROR.exists():
        mirror = ESP32_MIRROR.read_text(encoding="utf-8", errors="replace")
        match = re.search(r"#define\s+BTS_REG_CAL_ADS_V_PU\s+(\d+)", mirror)
        if match and int(match.group(1)) != 1224:
            pytest.xfail(
                f"ESP32 mirror still places cal telemetry at "
                f"{match.group(1)}; calibration values read over BLE 000c or "
                f"HTTP /api/calibration are shifted one register until "
                f"bts_regs.h is corrected"
            )


def test_total_registers_matches_the_c2000() -> None:
    """96 runtime + 192 settings + 27 unit = 315.

    The ESP32 mirror says 314 - the same off-by-one as the telemetry base.
    """
    assert regs.TOTAL_REGISTERS == 96 + 192 + 27


# --- access rules -----------------------------------------------------------


def test_runtime_registers_are_read_only() -> None:
    """A write here is silently dropped by the target, not rejected."""
    for ch in range(8):
        assert not regs.is_writable(regs.rt_addr(ch, regs.RT_STATUS))
        assert not regs.is_writable(regs.rt_addr(ch, regs.RT_CHARGE_MAH))


def test_settings_registers_are_writable() -> None:
    for ch in range(8):
        assert regs.is_writable(regs.set_addr(ch, regs.SET_MODE))
        assert regs.is_writable(regs.set_addr(ch, regs.SET_MAX_CELL_TEMP))


def test_read_only_unit_registers() -> None:
    for address in (
        regs.REG_UNIT_STATE,
        regs.REG_INPUT_VOLTAGE,
        regs.REG_TRIP_STATUS,
        regs.REG_CAL_STATUS,
        regs.REG_CAL_RESULT,
        regs.REG_WATCHDOG_REMAINING_S,
    ):
        assert not regs.is_writable(address)

    for address in (regs.REG_HOST_WATCHDOG_S, regs.REG_CAL_COMMAND):
        assert regs.is_writable(address)


def test_index_conversion_rejects_bad_addresses() -> None:
    assert regs.index_of(0) == 0
    assert regs.index_of(384) == 96
    with pytest.raises(ValueError, match="aligned"):
        regs.index_of(3)
    # Aligned but past the top of the map (1256 is the last valid address).
    with pytest.raises(ValueError, match="outside"):
        regs.index_of(1260)


# --- wire codec -------------------------------------------------------------


def test_register_payloads_are_big_endian() -> None:
    """The opposite of the GATT records - this is the C2000's own order."""
    assert regs.f32_to_wire(1.0) == struct.pack(">f", 1.0)
    assert regs.f32_to_wire(1.0) != struct.pack("<f", 1.0)
    assert regs.wire_to_f32(regs.f32_to_wire(3.7)) == pytest.approx(3.7)


def test_block_decode_discards_the_i2c_pad_byte() -> None:
    """Every I2C read is preceded by one stale byte from the TX register."""
    payload = b"".join(regs.f32_to_wire(v) for v in (1.0, 2.0, 3.0))
    assert regs.decode_block(b"\xAB" + payload, 3) == [1.0, 2.0, 3.0]
    # Transports without the pad byte must opt out.
    assert regs.decode_block(payload, 3, skip_pad=False) == [1.0, 2.0, 3.0]


def test_block_decode_rejects_a_short_read() -> None:
    with pytest.raises(ValueError, match="short register block"):
        regs.decode_block(b"\xAB" + b"\0" * 8, 3)


def test_runtime_block_decodes_in_order() -> None:
    values = [float(i) for i in range(12)]
    block = regs.RuntimeBlock.from_floats(values)
    assert block.status_bits == 0
    assert block.cell_voltage_v == 1.0
    assert block.sense_voltage_v == 3.0
    assert block.discharge_seconds == 11.0


def test_limits_write_in_ascending_address_order() -> None:
    limits = regs.ChannelLimits(4.2, 4.2, 2.5, 4.2, 0.05, 2.0, 0.05, 2.0, 5.0, 45.0)
    writes = limits.as_writes(3)
    assert [a for a, _ in writes] == sorted(a for a, _ in writes)
    assert all(regs.is_writable(a) for a, _ in writes)
    assert writes[0][0] == regs.set_addr(3, regs.SET_CHARGE_V_MIN)
