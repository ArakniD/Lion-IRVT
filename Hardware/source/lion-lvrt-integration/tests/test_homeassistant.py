"""Entity, coordinator and config-flow tests.

These need the real Home Assistant, which needs Python 3.12+. Without it the
whole module skips with an actionable message rather than silently passing -
a stubbed framework would test the stub, not the integration.
"""

from __future__ import annotations

import pytest

from tests.conftest import requires_ha

pytestmark = requires_ha

# Imported lazily: at module scope these would fail collection on a machine
# without Home Assistant, before the skip marker could take effect.
if True:  # pragma: no cover - import guard only
    try:
        from homeassistant.exceptions import HomeAssistantError
        from pytest_homeassistant_custom_component.common import MockConfigEntry
    except ImportError:  # pragma: no cover
        MockConfigEntry = None  # type: ignore[assignment]


from custom_components.lion_lvrt.const import (
    CONF_ADDRESS,
    CONF_SLOT_COUNT,
    CONF_TRANSPORT,
    DOMAIN,
    TRANSPORT_BLE,
    UnitState,
)
from tests.simulator.fake_ble import FakeBleClient
from tests.simulator.unit import SimulatedUnit


@pytest.fixture
def mock_entry():
    return MockConfigEntry(
        domain=DOMAIN,
        title="Bench tester",
        data={
            CONF_TRANSPORT: TRANSPORT_BLE,
            CONF_ADDRESS: "AA:BB:CC:DD:EE:FF",
            CONF_SLOT_COUNT: 8,
        },
        unique_id="AA:BB:CC:DD:EE:FF",
    )


async def _setup(hass, mock_entry, unit: SimulatedUnit, **client_kwargs):
    """Bring the integration up against the simulator."""
    from custom_components.lion_lvrt.coordinator import LionCoordinator
    from custom_components.lion_lvrt.device import LionDevice
    from custom_components.lion_lvrt.transport.ble import BleTransport

    mock_entry.add_to_hass(hass)
    client = FakeBleClient(unit, **client_kwargs)
    device = LionDevice(BleTransport(lambda: client), slot_count=unit.slot_count)
    await device.async_connect()

    coordinator = LionCoordinator(hass, device, mock_entry, scan_interval_s=5.0)
    await coordinator.async_config_entry_first_refresh()
    hass.data.setdefault(DOMAIN, {})[mock_entry.entry_id] = coordinator

    from custom_components.lion_lvrt import PLATFORMS

    await hass.config_entries.async_forward_entry_setups(mock_entry, PLATFORMS)
    await hass.async_block_till_done()
    return coordinator, unit


# --- entity creation --------------------------------------------------------


async def test_every_slot_gets_its_entities(hass, mock_entry) -> None:
    unit = SimulatedUnit()
    await _setup(hass, mock_entry, unit)

    for slot in range(8):
        assert hass.states.get(f"sensor.slot_{slot + 1}_voltage") is not None
        assert hass.states.get(f"sensor.slot_{slot + 1}_state") is not None
        assert hass.states.get(f"select.slot_{slot + 1}_mode") is not None


async def test_slot_naming_is_one_based(hass, mock_entry) -> None:
    """The front panel is 1-based; the wire is 0-based.

    Naming entities the way the panel is labelled avoids an off-by-one every
    time an operator maps a dashboard to hardware.
    """
    unit = SimulatedUnit()
    unit.slots[0].voltage_v = 3.99
    await _setup(hass, mock_entry, unit)

    state = hass.states.get("sensor.slot_1_voltage")
    assert state is not None
    assert float(state.state) == pytest.approx(3.99)


# --- mode select ------------------------------------------------------------


async def test_mode_options_reflect_capability(hass, mock_entry) -> None:
    """Without register access, charge/discharge must not be offered."""
    unit = SimulatedUnit()
    await _setup(hass, mock_entry, unit, include_registers=False)

    options = hass.states.get("select.slot_1_mode").attributes["options"]
    assert "charge" not in options
    assert "discharge" not in options
    assert "test" in options


async def test_mode_options_include_directions_with_registers(
    hass, mock_entry
) -> None:
    unit = SimulatedUnit()
    await _setup(hass, mock_entry, unit)

    options = hass.states.get("select.slot_1_mode").attributes["options"]
    assert "charge" in options and "discharge" in options


async def test_selecting_charge_commands_the_slot(hass, mock_entry) -> None:
    unit = SimulatedUnit()
    await _setup(hass, mock_entry, unit)

    await hass.services.async_call(
        "select",
        "select_option",
        {"entity_id": "select.slot_3_mode", "option": "charge"},
        blocking=True,
    )
    assert unit.slots[2].running and unit.slots[2].charging


async def test_selecting_charge_on_a_low_bus_raises(hass, mock_entry) -> None:
    """The unit would silently refuse; the UI must say so instead."""
    unit = SimulatedUnit(unit_state=UnitState.INPUT_LOW_CHARGE_DISABLED)
    await _setup(hass, mock_entry, unit)

    with pytest.raises(HomeAssistantError, match="INPUT_LOW"):
        await hass.services.async_call(
            "select",
            "select_option",
            {"entity_id": "select.slot_1_mode", "option": "charge"},
            blocking=True,
        )
    assert not unit.slots[0].running


async def test_paused_is_reported_but_not_selectable(hass, mock_entry) -> None:
    unit = SimulatedUnit()
    coordinator, _ = await _setup(hass, mock_entry, unit)

    await coordinator.device.async_discharge(0)
    unit.tick_watchdog(31.0)
    await coordinator.async_refresh()
    await hass.async_block_till_done()

    assert hass.states.get("select.slot_1_mode").state == "paused"
    with pytest.raises(HomeAssistantError, match="cannot be selected"):
        await hass.services.async_call(
            "select",
            "select_option",
            {"entity_id": "select.slot_1_mode", "option": "paused"},
            blocking=True,
        )


# --- buttons ----------------------------------------------------------------


async def test_resume_button_refuses_a_watchdog_pause(hass, mock_entry) -> None:
    """The override belongs in the service, where force is explicit."""
    unit = SimulatedUnit()
    coordinator, _ = await _setup(hass, mock_entry, unit)

    await coordinator.device.async_discharge(1)
    unit.tick_watchdog(31.0)
    await coordinator.async_refresh()

    with pytest.raises(HomeAssistantError, match="watchdog"):
        await hass.services.async_call(
            "button",
            "press",
            {"entity_id": "button.slot_2_resume"},
            blocking=True,
        )
    assert not unit.slots[1].running


async def test_abort_all_stops_every_slot(hass, mock_entry) -> None:
    unit = SimulatedUnit()
    coordinator, _ = await _setup(hass, mock_entry, unit)
    for slot in range(8):
        await coordinator.device.async_discharge(slot)

    await hass.services.async_call(
        "button", "press", {"entity_id": "button.bench_tester_abort_all"},
        blocking=True,
    )
    assert not any(s.running for s in unit.slots)


# --- binary sensors ---------------------------------------------------------


async def test_needs_operator_flags_a_restored_run(hass, mock_entry) -> None:
    unit = SimulatedUnit()
    coordinator, _ = await _setup(hass, mock_entry, unit)

    await coordinator.device.async_charge(0)
    unit.simulate_reset_restore()
    await coordinator.async_refresh()
    await hass.async_block_till_done()

    assert hass.states.get("binary_sensor.slot_1_needs_operator").state == "on"


async def test_watchdog_armed_reflects_the_timeout(hass, mock_entry) -> None:
    unit = SimulatedUnit(host_watchdog_s=0.0)
    await _setup(hass, mock_entry, unit)
    assert (
        hass.states.get("binary_sensor.bench_tester_host_watchdog_armed").state
        == "off"
    )


# --- services ---------------------------------------------------------------


async def test_configure_slot_service(hass, mock_entry) -> None:
    from custom_components.lion_lvrt.services import async_register_services

    unit = SimulatedUnit()
    await _setup(hass, mock_entry, unit)
    async_register_services(hass)

    await hass.services.async_call(
        DOMAIN,
        "configure_slot",
        {
            "slot": 4,
            "chemistry": "nmc",
            "model_name": "Samsung 30Q",
            "capacity_mah": 3000,
            "discharge_c": 1.0,
        },
        blocking=True,
    )
    assert unit.slots[4].configured
    assert unit.slots[4].config.model_name == "Samsung 30Q"


async def test_forced_resume_service(hass, mock_entry) -> None:
    from custom_components.lion_lvrt.services import async_register_services

    unit = SimulatedUnit()
    coordinator, _ = await _setup(hass, mock_entry, unit)
    async_register_services(hass)

    await coordinator.device.async_discharge(0)
    unit.tick_watchdog(31.0)
    await coordinator.async_refresh()

    with pytest.raises(HomeAssistantError):
        await hass.services.async_call(
            DOMAIN, "resume_slot", {"slot": 0}, blocking=True
        )

    await hass.services.async_call(
        DOMAIN, "resume_slot", {"slot": 0, "force": True}, blocking=True
    )
    assert unit.slots[0].running


async def test_calibration_service_returns_telemetry(hass, mock_entry) -> None:
    from custom_components.lion_lvrt.services import async_register_services

    unit = SimulatedUnit()
    unit.cal_telemetry[0] = 0.12
    await _setup(hass, mock_entry, unit)
    async_register_services(hass)

    response = await hass.services.async_call(
        DOMAIN,
        "calibration_command",
        {"command": "enter", "slot": 2},
        blocking=True,
        return_response=True,
    )
    assert response["slot"] == 2
    assert response["active"] is True
    assert response["ads_v_pu"] == pytest.approx(0.12)


# --- coordinator ------------------------------------------------------------


async def test_coordinator_warns_when_polling_is_too_slow(
    hass, mock_entry, caplog
) -> None:
    """A poll slower than the watchdog would let the unit pause every slot."""
    from custom_components.lion_lvrt.coordinator import LionCoordinator
    from custom_components.lion_lvrt.device import LionDevice
    from custom_components.lion_lvrt.transport.ble import BleTransport

    unit = SimulatedUnit(host_watchdog_s=10.0)
    mock_entry.add_to_hass(hass)
    device = LionDevice(BleTransport(lambda: FakeBleClient(unit)))
    await device.async_connect()

    coordinator = LionCoordinator(hass, device, mock_entry, scan_interval_s=30.0)
    await coordinator.async_config_entry_first_refresh()

    assert "host watchdog" in caplog.text


# --- config flow ------------------------------------------------------------


async def test_bluetooth_discovery_flow(hass) -> None:
    from homeassistant.components.bluetooth import BluetoothServiceInfoBleak
    from homeassistant.data_entry_flow import FlowResultType

    info = BluetoothServiceInfoBleak(
        name="BTS-Tester",
        address="AA:BB:CC:DD:EE:FF",
        rssi=-55,
        manufacturer_data={},
        service_data={},
        service_uuids=["e5f10001-9a4c-4b7d-8f2e-1c3a5b7d9f01"],
        source="local",
        device=None,
        advertisement=None,
        connectable=True,
        time=0,
        tx_power=None,
    )

    result = await hass.config_entries.flow.async_init(
        DOMAIN, context={"source": "bluetooth"}, data=info
    )
    assert result["type"] is FlowResultType.FORM
    assert result["step_id"] == "bluetooth_confirm"

    result = await hass.config_entries.flow.async_configure(
        result["flow_id"], {CONF_SLOT_COUNT: 8, "can_interface": "", "http_host": ""}
    )
    assert result["type"] is FlowResultType.CREATE_ENTRY
    assert result["data"][CONF_ADDRESS] == "AA:BB:CC:DD:EE:FF"
