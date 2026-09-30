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
    # Last settings register in the block: offset 17 (VoutOffset_V) = byte 68.
    assert regs.set_addr(7, 68) + regs.REGISTER_SIZE == regs.UNIT_BASE


def test_blocks_do_not_share_a_stride() -> None:
    """The regression this guards produced cross-channel corruption in v1."""
    assert regs.RT_STRIDE != regs.SET_STRIDE
    for ch in range(1, 8):
        assert regs.rt_addr(ch, 0) - regs.rt_addr(ch - 1, 0) == 48
        assert regs.set_addr(ch, 0) - regs.set_addr(ch - 1, 0) == 72


def test_channel_range_is_enforced() -> None:
    for bad in (-1, 8, 99):
        with pytest.raises(ValueError, match="channel"):
            regs.rt_addr(bad, 0)
        with pytest.raises(ValueError, match="channel"):
            regs.set_addr(bad, 0)


def test_calibration_block_offsets() -> None:
    """The 12 calibration registers keep their order at settings offset 24."""
    assert regs.cal_addr(0, regs.CAL_F28V_GAIN) == 384 + 24
    assert regs.cal_addr(0, regs.CAL_VOUT_OFFSET_V) == 384 + 24 + 44
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


def test_cal_telemetry_base_follows_the_c2000() -> None:
    """Calibration telemetry starts immediately after the watchdog countdown.

    Derived from the header rather than hard-coded: this test previously
    pinned 1220/1224, which were the v1 addresses, and kept asserting them
    for two revisions after the firmware moved. Reading the values out of
    the enum means it tracks the map instead of restating it.

    It also used to ``xfail`` on the ESP32 mirror placing the window one
    register low. That drift is fixed, so a mismatch is now a hard failure -
    all three copies of this map must agree.
    """
    enum = _c2000_enum()
    watchdog = enum["eWatchdogRemaining_s"]
    telemetry = enum["eCalAdsV_pu"]

    assert telemetry == watchdog + regs.REGISTER_SIZE
    assert regs.CAL_TELEMETRY_BASE == telemetry
    assert regs.REG_WATCHDOG_REMAINING_S == watchdog

    if ESP32_MIRROR.exists():
        mirror = ESP32_MIRROR.read_text(encoding="utf-8", errors="replace")
        match = re.search(r"#define\s+BTS_REG_CAL_ADS_V_PU\s+(\d+)", mirror)
        assert match, "ESP32 mirror no longer defines BTS_REG_CAL_ADS_V_PU"
        assert int(match.group(1)) == telemetry, (
            f"ESP32 mirror places cal telemetry at {match.group(1)}, "
            f"the C2000 at {telemetry}"
        )


def test_every_unit_and_tuning_address_matches_the_c2000() -> None:
    """Exhaustive address check against the firmware enum.

    The parametrised test above covers a hand-picked 16. This one walks every
    unit and tuning register, so a future addition cannot be missed here by
    being left off a list.
    """
    enum = _c2000_enum()
    pairs = {
        "eChargeDisableV": regs.REG_CHARGE_DISABLE_V,
        "eChargeRestrictV": regs.REG_CHARGE_RESTRICT_V,
        "eDischargeRestrictV": regs.REG_DISCHARGE_RESTRICT_V,
        "eDischargeDisableV": regs.REG_DISCHARGE_DISABLE_V,
        "eCalibrationMode": regs.REG_CALIBRATION_MODE,
        "eUnitState": regs.REG_UNIT_STATE,
        "eInputVoltage": regs.REG_INPUT_VOLTAGE,
        "eTripStatus": regs.REG_TRIP_STATUS,
        "eSlotMode": regs.REG_SLOT_MODE,
        "eSlotEnable": regs.REG_SLOT_ENABLE,
        "eGroupSize": regs.REG_GROUP_SIZE,
        "eHostWatchdog_s": regs.REG_HOST_WATCHDOG_S,
        "eCalSlot": regs.REG_CAL_SLOT,
        "eCalCommand": regs.REG_CAL_COMMAND,
        "eCalArgument": regs.REG_CAL_ARGUMENT,
        "eCalStatus": regs.REG_CAL_STATUS,
        "eCalResult": regs.REG_CAL_RESULT,
        "eWatchdogRemaining_s": regs.REG_WATCHDOG_REMAINING_S,
        "eCalAdsV_pu": regs.REG_CAL_ADS_V_PU,
        "eCalAdsI_pu": regs.REG_CAL_ADS_I_PU,
        "eCalAdsV_V": regs.REG_CAL_ADS_V_V,
        "eCalAdsI_A": regs.REG_CAL_ADS_I_A,
        "eCalF28V_pu": regs.REG_CAL_F28_V_PU,
        "eCalF28I_pu": regs.REG_CAL_F28_I_PU,
        "eCalF28V_V": regs.REG_CAL_F28_V_V,
        "eCalF28I_A": regs.REG_CAL_F28_I_A,
        "eCalTemp_C": regs.REG_CAL_TEMP_C,
        "eDCL_CC_B0": regs.REG_DCL_CC_B0,
        "eDCL_CC_B1": regs.REG_DCL_CC_B1,
        "eDCL_CC_B2": regs.REG_DCL_CC_B2,
        "eDCL_CC_A1": regs.REG_DCL_CC_A1,
        "eDCL_CC_A2": regs.REG_DCL_CC_A2,
        "eDCL_CV_Z0": regs.REG_DCL_CV_Z0,
        "eDCL_CV_Z1": regs.REG_DCL_CV_Z1,
        "eDCL_CV_P1": regs.REG_DCL_CV_P1,
        "eDCL_CV_B0": regs.REG_DCL_CV_B0,
        "eDCL_CV_B1": regs.REG_DCL_CV_B1,
        "eDCL_CV_B2": regs.REG_DCL_CV_B2,
        "eDCL_CV_A1": regs.REG_DCL_CV_A1,
        "eDCL_CV_A2": regs.REG_DCL_CV_A2,
    }
    for name, mirrored in pairs.items():
        assert name in enum, f"{name} missing from registers.h"
        assert enum[name] == mirrored, f"{name}: C2000 {enum[name]}, mirror {mirrored}"


def test_per_slot_addresses_match_the_c2000() -> None:
    """The settings and runtime geometry, checked against the header.

    The unit block was header-verified from the start; the per-slot blocks
    were not, which is exactly where the v2.1 stride change slipped through
    unnoticed. This closes that gap.
    """
    enum = _c2000_enum()
    for ch in range(regs.NUM_CHANNELS):
        assert regs.rt_addr(ch, regs.RT_STATUS) == enum[f"eCh{ch}_Status"]
        assert regs.rt_addr(ch, regs.RT_CELL_TEMP) == enum[f"eCh{ch}_CellTemp"]
        assert regs.set_addr(ch, regs.SET_MODE) == enum[f"eCh{ch}_Mode"]
        assert regs.set_addr(ch, regs.SET_V_MIN) == enum[f"eCh{ch}_VoltageMin"]
        assert regs.set_addr(ch, regs.SET_V_MAX) == enum[f"eCh{ch}_VoltageMax"]
        assert regs.set_addr(ch, regs.SET_I_MIN) == enum[f"eCh{ch}_CurrentMin"]
        assert regs.set_addr(ch, regs.SET_I_MAX) == enum[f"eCh{ch}_CurrentMax"]
        assert regs.set_addr(ch, regs.SET_MAX_CELL_TEMP) == enum[f"eCh{ch}_MaxCellTemp"]
        assert regs.cal_addr(ch, regs.CAL_F28V_GAIN) == enum[f"eCh{ch}_F28V_Gain"]
        assert regs.cal_addr(ch, regs.CAL_VOUT_OFFSET_V) == enum[f"eCh{ch}_VoutOffset_V"]


def test_total_registers_matches_the_c2000() -> None:
    """96 runtime + 144 settings + 27 unit + 13 tuning = 280."""
    assert regs.TOTAL_REGISTERS == 96 + 144 + 27 + 13


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
    # Aligned but past the top of the map (1116 is the last valid address).
    with pytest.raises(ValueError, match="outside"):
        regs.index_of(1120)


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
    limits = regs.ChannelLimits(2.5, 4.2, 0.05, 2.0, 45.0)
    writes = limits.as_writes(3)
    assert [a for a, _ in writes] == sorted(a for a, _ in writes)
    assert all(regs.is_writable(a) for a, _ in writes)
    assert writes[0][0] == regs.set_addr(3, regs.SET_V_MIN)


def test_limits_addresses_are_distinct() -> None:
    """The merge regression: charge and discharge limits are ONE pair now.

    A mirror that still carries separate charge/discharge fields writes the
    same address twice and the later value silently wins, with no error and
    no read-back check on that path.
    """
    writes = regs.ChannelLimits(2.5, 4.2, 0.05, 2.0, 45.0).as_writes(0)
    assert len({a for a, _ in writes}) == len(writes)


def test_tuning_block_is_writable_and_above_the_unit_block() -> None:
    """Slot tuning sits above the unit block and is writable end to end."""
    assert regs.TUNING_BASE == 1068
    assert regs.TUNING_BASE > regs.UNIT_BASE
    assert regs.REG_DCL_CV_A2 == regs.TOP_ADDRESS
    for addr in range(regs.TUNING_BASE, regs.TOP_ADDRESS + 1, regs.REGISTER_SIZE):
        assert regs.is_writable(addr)
    span = regs.TOP_ADDRESS - regs.TUNING_BASE + regs.REGISTER_SIZE
    assert span // regs.REGISTER_SIZE == regs.TUNING_REG_COUNT


def test_map_is_dense() -> None:
    """Every region butts against the next - there is no reserved padding.

    registers.h still carries a comment about "generous strides so a future
    field does not shift everything"; it is not true and has not been for
    some time. Inserting a register anywhere shifts every address above it.
    """
    assert regs.rt_addr(7, regs.RT_DISCHARGE_SECONDS) + 4 == regs.SET_BASE
    assert regs.set_addr(7, 68) + 4 == regs.UNIT_BASE
    assert regs.REG_CAL_TEMP_C + 4 == regs.TUNING_BASE
    assert regs.index_of(regs.TOP_ADDRESS) + 1 == regs.TOTAL_REGISTERS
