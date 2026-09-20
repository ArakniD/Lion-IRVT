"""Device-layer tests: the safety policy.

These cover the rules that prevent a slot from being commanded into a state
the unit would refuse, or resumed when an operator has to decide first. They
are the reason the device layer exists rather than entities calling transports
directly.
"""

from __future__ import annotations

import pytest

from custom_components.lion_lvrt.const import (
    CalCommand,
    CalResult,
    SlotMode,
    StatusBit,
    UnitState,
)
from custom_components.lion_lvrt.device import LionDevice
from custom_components.lion_lvrt.transport.ble import BleTransport
from custom_components.lion_lvrt.transport.base import (
    TransportError,
    UnitRefusedError,
)
from tests.simulator.fake_ble import FakeBleClient
from tests.simulator.unit import SimulatedUnit


async def _device(unit: SimulatedUnit, **kwargs) -> LionDevice:
    client = FakeBleClient(unit, **kwargs)
    transport = BleTransport(lambda: client)
    device = LionDevice(transport, slot_count=unit.slot_count)
    await device.async_connect()
    await device.async_poll()
    return device


# --- capability reporting ---------------------------------------------------


async def test_direct_mode_needs_register_access() -> None:
    unit = SimulatedUnit()
    assert (await _device(unit)).supports_direct_mode

    limited = await _device(unit, include_registers=False)
    assert not limited.supports_direct_mode
    with pytest.raises(TransportError, match="register characteristic"):
        await limited.async_charge(0)


async def test_can_secondary_grants_direct_mode_to_a_ble_primary() -> None:
    """Adding CAN to a BLE setup restores charge/discharge control."""
    unit = SimulatedUnit()
    ble = BleTransport(lambda: FakeBleClient(unit, include_registers=False))

    class StubRegisterLink(TransportError.__bases__[0]):  # placeholder
        pass

    from custom_components.lion_lvrt.transport.base import Transport

    class FakeRegisterTransport(Transport):
        supports_registers = True

        async def async_connect(self) -> None: ...
        async def async_disconnect(self) -> None: ...
        async def async_poll(self): raise TransportError("poll via primary")

        async def async_read_register(self, address: int) -> float:
            return unit.read_register(address)

        async def async_write_register(self, address: int, value: float) -> None:
            unit.write_register(address, value)

    device = LionDevice(ble, register_transport=FakeRegisterTransport())
    await device.async_connect()
    await device.async_poll()

    assert device.supports_direct_mode
    await device.async_charge(0)
    assert unit.slots[0].running and unit.slots[0].charging


# --- unit-state gating ------------------------------------------------------


async def test_charge_refused_when_the_input_bus_is_low() -> None:
    """The unit refuses this outright and reports nothing - catch it here.

    modeCallback() leaves the channel stopped with no error anywhere, so a
    client that just writes the register sees a slot that silently does
    nothing.
    """
    unit = SimulatedUnit(
        unit_state=UnitState.INPUT_LOW_CHARGE_DISABLED, input_voltage_v=8.2
    )
    device = await _device(unit)

    with pytest.raises(UnitRefusedError, match="INPUT_LOW_CHARGE_DISABLED"):
        await device.async_charge(0)
    assert not unit.slots[0].running


async def test_discharge_refused_when_the_input_bus_is_high() -> None:
    unit = SimulatedUnit(
        unit_state=UnitState.INPUT_HIGH_DISCHARGE_DISABLED, input_voltage_v=16.5
    )
    device = await _device(unit)

    with pytest.raises(UnitRefusedError, match="INPUT_HIGH"):
        await device.async_discharge(0)
    assert not unit.slots[0].running


async def test_charge_allowed_when_discharge_is_restricted() -> None:
    """A high bus blocks discharge but still permits charging."""
    unit = SimulatedUnit(unit_state=UnitState.INPUT_HIGH_DISCHARGE_RESTRICTED)
    device = await _device(unit)

    await device.async_charge(0)
    assert unit.slots[0].running and unit.slots[0].charging

    with pytest.raises(UnitRefusedError):
        await device.async_discharge(1)


async def test_stop_is_always_permitted() -> None:
    """Whatever the bus is doing, stopping must never be refused."""
    unit = SimulatedUnit(unit_state=UnitState.INPUT_LOW_CHARGE_DISABLED)
    device = await _device(unit)
    await device.async_stop(0)
    assert not unit.slots[0].running


# --- slot availability guards ----------------------------------------------


async def test_strap_disabled_slot_is_refused() -> None:
    unit = SimulatedUnit()
    unit.slots[4].enabled = False
    device = await _device(unit)

    with pytest.raises(UnitRefusedError, match="ENABLE strap"):
        await device.async_charge(4)


async def test_group_follower_names_its_leader() -> None:
    """A follower has no control loop; the error says what to command."""
    unit = SimulatedUnit()
    unit.slots[3].follower = True
    device = await _device(unit)

    with pytest.raises(UnitRefusedError, match="follower"):
        await device.async_discharge(3)


async def test_calibrating_slot_cannot_be_started() -> None:
    unit = SimulatedUnit()
    device = await _device(unit)
    await device.async_cal_command(CalCommand.ENTER, slot=2)
    await device.async_poll()

    with pytest.raises(UnitRefusedError, match="calibration"):
        await device.async_charge(2)


async def test_slot_range_is_checked() -> None:
    unit = SimulatedUnit()
    device = await _device(unit)
    for bad in (-1, 8, 100):
        with pytest.raises(ValueError, match="out of range"):
            await device.async_charge(bad)


# --- pause and resume -------------------------------------------------------


async def test_watchdog_pause_refuses_a_plain_resume() -> None:
    """The link died mid-run, so the cell may have been swapped."""
    unit = SimulatedUnit(host_watchdog_s=30.0)
    device = await _device(unit)
    await device.async_discharge(0)

    unit.tick_watchdog(31.0)
    await device.async_poll()

    status = device.snapshot.slots[0]
    assert status.is_paused and status.needs_operator
    assert status.resume_direction == "discharge"

    with pytest.raises(UnitRefusedError, match="watchdog"):
        await device.async_resume(0)

    # The override is explicit.
    await device.async_resume(0, force=True)
    assert unit.slots[0].running


async def test_restored_pause_refuses_a_plain_resume() -> None:
    unit = SimulatedUnit()
    device = await _device(unit)
    await device.async_charge(1)

    unit.simulate_reset_restore()
    await device.async_poll()

    assert device.snapshot.slots[1].needs_operator
    with pytest.raises(UnitRefusedError, match="F-RAM|reset"):
        await device.async_resume(1)


async def test_ordinary_pause_resumes_without_force() -> None:
    """An operator-initiated pause carries no such doubt."""
    unit = SimulatedUnit()
    device = await _device(unit)
    await device.async_discharge(2)
    await device.async_pause(2)
    await device.async_poll()

    assert device.snapshot.slots[2].is_paused
    assert not device.snapshot.slots[2].needs_operator

    await device.async_resume(2)
    assert unit.slots[2].running


async def test_a_slot_holding_a_paused_run_cannot_be_restarted() -> None:
    unit = SimulatedUnit()
    device = await _device(unit)
    await device.async_charge(0)
    unit.tick_watchdog(31.0)
    await device.async_poll()

    with pytest.raises(UnitRefusedError, match="operator"):
        await device.async_charge(0)


# --- accumulators -----------------------------------------------------------


async def test_direction_accumulators_reset_only_on_their_own_start() -> None:
    """A charge then a discharge leaves two independent totals."""
    unit = SimulatedUnit()
    device = await _device(unit)

    await device.async_charge(0)
    unit.slots[0].charge_mah = 500.0
    await device.async_stop(0)

    # Stopping must not clear it.
    await device.async_poll()
    assert device.snapshot.slots[0].bts_charge_mah == pytest.approx(500.0)

    # Starting the *other* direction must not clear it either.
    await device.async_discharge(0)
    unit.slots[0].discharge_mah = 480.0
    await device.async_poll()
    assert device.snapshot.slots[0].bts_charge_mah == pytest.approx(500.0)
    assert device.snapshot.slots[0].bts_discharge_mah == pytest.approx(480.0)

    # Restarting a charge clears only the charge pair.
    await device.async_charge(0)
    await device.async_poll()
    assert device.snapshot.slots[0].bts_charge_mah == 0.0
    assert device.snapshot.slots[0].bts_discharge_mah == pytest.approx(480.0)


# --- mode encoding ----------------------------------------------------------


async def test_mode_bit_asymmetry() -> None:
    """Stop and start-a-discharge differ only in bit 0."""
    assert int(SlotMode.STOP) == 0x00
    assert SlotMode.run_discharge() == 0x01
    assert SlotMode.run_charge() == 0x03

    unit = SimulatedUnit()
    device = await _device(unit)
    await device.async_discharge(5)
    assert unit.slots[5].running and not unit.slots[5].charging
    assert unit.slots[5].current_a < 0


# --- watchdog ---------------------------------------------------------------


async def test_disabling_the_watchdog_is_allowed_but_warned(caplog) -> None:
    unit = SimulatedUnit()
    device = await _device(unit)
    await device.async_set_host_watchdog(0.0)
    assert "Disabling the host watchdog" in caplog.text
    assert unit.host_watchdog_s == 0.0


async def test_a_disabled_watchdog_never_pauses_a_slot() -> None:
    unit = SimulatedUnit(host_watchdog_s=0.0)
    device = await _device(unit)
    await device.async_discharge(0)
    unit.tick_watchdog(600.0)
    await device.async_poll()
    assert device.snapshot.slots[0].is_running


async def test_polling_feeds_the_watchdog() -> None:
    """The poll is the keepalive - a read counts as a host command."""
    unit = SimulatedUnit(host_watchdog_s=30.0)
    device = await _device(unit)
    unit.tick_watchdog(29.0)
    assert unit.watchdog_remaining_s == pytest.approx(1.0)

    await device.async_poll()
    assert unit.watchdog_remaining_s == pytest.approx(30.0)


# --- calibration ------------------------------------------------------------


async def test_fixed_current_is_clamped_before_the_wire() -> None:
    unit = SimulatedUnit()
    device = await _device(unit)
    await device.async_cal_command(CalCommand.ENTER, slot=0)

    with pytest.raises(ValueError, match="outside 0.0-0.8"):
        await device.async_cal_command(CalCommand.SET_FIXED_CURRENT, arg=0.95)
    with pytest.raises(ValueError, match="outside 0.0-0.8"):
        await device.async_cal_command(CalCommand.SET_FIXED_CURRENT, arg=-0.1)

    await device.async_cal_command(CalCommand.SET_FIXED_CURRENT, arg=0.5)


async def test_capture_current_takes_a_magnitude() -> None:
    """A signed value must be corrected - a raw register write would not be."""
    unit = SimulatedUnit()
    device = await _device(unit)
    await device.async_cal_command(CalCommand.ENTER, slot=0)
    await device.async_cal_command(CalCommand.ZERO_CURRENT)
    status = await device.async_cal_command(CalCommand.CAPTURE_CURRENT, arg=-4.2)
    assert status.result is CalResult.OK


async def test_opcode_none_is_rejected_not_a_noop() -> None:
    unit = SimulatedUnit()
    device = await _device(unit)
    with pytest.raises(ValueError, match="not a no-op"):
        await device.async_cal_command(CalCommand.NONE)


async def test_calibration_refused_while_a_slot_runs() -> None:
    unit = SimulatedUnit()
    device = await _device(unit)
    await device.async_discharge(0)

    with pytest.raises(UnitRefusedError, match="stop it first"):
        await device.async_cal_command(CalCommand.ENTER, slot=1)


async def test_full_calibration_sequence_sets_the_persisted_ticks() -> None:
    unit = SimulatedUnit()
    device = await _device(unit)

    await device.async_cal_command(CalCommand.ENTER, slot=3)
    unit.cal_telemetry[0] = 0.1
    await device.async_cal_command(CalCommand.CAPTURE_VOLTAGE, arg=0.85)
    unit.cal_telemetry[0] = 0.9
    await device.async_cal_command(CalCommand.CAPTURE_VOLTAGE, arg=4.20)
    await device.async_cal_command(CalCommand.ZERO_CURRENT)
    await device.async_cal_command(CalCommand.SET_FIXED_CURRENT, arg=0.5)
    await device.async_cal_command(CalCommand.CAPTURE_CURRENT, arg=5.02)
    status = await device.async_cal_command(CalCommand.COMPUTE_SAVE)

    assert status.v_tick and status.i_tick
    await device.async_poll()
    bits = device.snapshot.slots[3].status_bits
    assert bits & StatusBit.CAL_V_VALID
    assert bits & StatusBit.CAL_I_VALID
