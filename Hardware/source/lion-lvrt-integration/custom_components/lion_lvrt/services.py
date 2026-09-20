"""Services for operations that do not fit an entity.

Three kinds live here:

* **Slot configuration** - a cell profile is eight coupled fields written as
  one record, which is a service call rather than eight number entities that
  could be left half-applied.
* **Forced resume** - the override for a slot the unit paused on a watchdog
  trip or an F-RAM restore. Deliberately not a button: it needs an explicit
  argument so it cannot be pressed by accident.
* **Calibration** - a stateful bench procedure driven opcode by opcode.
"""

from __future__ import annotations

import logging

import voluptuous as vol
from homeassistant.core import HomeAssistant, ServiceCall, ServiceResponse, SupportsResponse
from homeassistant.exceptions import HomeAssistantError
from homeassistant.helpers import config_validation as cv

from .const import (
    CAL_FIXED_CURRENT_MAX_PU,
    CalCommand,
    CellChemistry,
    DOMAIN,
    SLOT_COUNT,
)
from .coordinator import LionCoordinator
from .protocol.ble import SlotConfig
from .transport.base import TransportError, UnitRefusedError

_LOGGER = logging.getLogger(__name__)

SERVICE_CONFIGURE_SLOT = "configure_slot"
SERVICE_SET_SERIAL = "set_serial"
SERVICE_RESUME_SLOT = "resume_slot"
SERVICE_SET_MODE = "set_mode"
SERVICE_CALIBRATION = "calibration_command"
SERVICE_GET_RESULT = "get_result"

ATTR_ENTRY = "entry_id"
ATTR_SLOT = "slot"

_SLOT = vol.All(vol.Coerce(int), vol.Range(min=0, max=SLOT_COUNT - 1))

_BASE = {
    vol.Required(ATTR_SLOT): _SLOT,
    vol.Optional(ATTR_ENTRY): cv.string,
}

CONFIGURE_SCHEMA = vol.Schema(
    {
        **_BASE,
        vol.Required("chemistry"): vol.In([c.name.lower() for c in CellChemistry]),
        vol.Optional("model_name", default=""): cv.string,
        vol.Optional("serial", default=""): cv.string,
        # 0 means "use the model default" for each of these, which is why the
        # minimum is 0 rather than something positive.
        vol.Optional("capacity_mah", default=0.0): vol.All(
            vol.Coerce(float), vol.Range(min=0, max=100000)
        ),
        vol.Optional("charge_c", default=0.0): vol.All(
            vol.Coerce(float), vol.Range(min=0, max=10)
        ),
        vol.Optional("discharge_c", default=0.0): vol.All(
            vol.Coerce(float), vol.Range(min=0, max=10)
        ),
        vol.Optional("auto_recharge", default=False): cv.boolean,
        vol.Optional("shipping_pct", default=60.0): vol.All(
            vol.Coerce(float), vol.Range(min=0, max=100)
        ),
        vol.Optional("max_duration_minutes", default=0): vol.All(
            vol.Coerce(int), vol.Range(min=0, max=100000)
        ),
    }
)

SET_SERIAL_SCHEMA = vol.Schema(
    {**_BASE, vol.Required("serial"): vol.All(cv.string, vol.Length(min=1, max=31))}
)

RESUME_SCHEMA = vol.Schema({**_BASE, vol.Optional("force", default=False): cv.boolean})

SET_MODE_SCHEMA = vol.Schema(
    {**_BASE, vol.Required("mode"): vol.In(["stop", "charge", "discharge"])}
)

CALIBRATION_SCHEMA = vol.Schema(
    {
        vol.Optional(ATTR_ENTRY): cv.string,
        vol.Required("command"): vol.In([c.name.lower() for c in CalCommand if c]),
        vol.Optional(ATTR_SLOT): _SLOT,
        vol.Optional("value", default=0.0): vol.Coerce(float),
    }
)

GET_RESULT_SCHEMA = vol.Schema(_BASE)


def _coordinator(hass: HomeAssistant, call: ServiceCall) -> LionCoordinator:
    """Resolve which unit a call is addressed to.

    With a single unit configured the ``entry_id`` may be omitted; with more
    than one it is required, because guessing would command the wrong
    hardware.
    """
    entries: dict[str, LionCoordinator] = hass.data.get(DOMAIN, {})
    if not entries:
        raise HomeAssistantError("no Lion LVRT tester is configured")

    entry_id = call.data.get(ATTR_ENTRY)
    if entry_id is not None:
        if entry_id not in entries:
            raise HomeAssistantError(f"no configured tester with entry_id {entry_id}")
        return entries[entry_id]

    if len(entries) > 1:
        raise HomeAssistantError(
            f"{len(entries)} testers are configured; pass entry_id to say "
            "which one this call is for"
        )
    return next(iter(entries.values()))


def async_register_services(hass: HomeAssistant) -> None:
    if hass.services.has_service(DOMAIN, SERVICE_CONFIGURE_SLOT):
        return

    async def configure_slot(call: ServiceCall) -> None:
        coordinator = _coordinator(hass, call)
        slot = call.data[ATTR_SLOT]
        config = SlotConfig(
            slot=slot,
            chemistry=CellChemistry[call.data["chemistry"].upper()],
            auto_recharge=call.data["auto_recharge"],
            capacity_mah=call.data["capacity_mah"],
            charge_c=call.data["charge_c"],
            discharge_c=call.data["discharge_c"],
            shipping_pct=call.data["shipping_pct"],
            max_duration_minutes=call.data["max_duration_minutes"],
            model_name=call.data["model_name"],
            serial=call.data["serial"],
        )
        await _run(coordinator.device.async_write_config(config))
        await coordinator.async_request_refresh()

    async def set_serial(call: ServiceCall) -> None:
        coordinator = _coordinator(hass, call)
        await _run(
            coordinator.device.async_set_serial(
                call.data[ATTR_SLOT], call.data["serial"]
            )
        )

    async def resume_slot(call: ServiceCall) -> None:
        coordinator = _coordinator(hass, call)
        await _run(
            coordinator.device.async_resume(
                call.data[ATTR_SLOT], force=call.data["force"]
            )
        )
        await coordinator.async_request_refresh()

    async def set_mode(call: ServiceCall) -> None:
        coordinator = _coordinator(hass, call)
        device = coordinator.device
        slot = call.data[ATTR_SLOT]
        mode = call.data["mode"]
        if mode == "charge":
            await _run(device.async_charge(slot))
        elif mode == "discharge":
            await _run(device.async_discharge(slot))
        else:
            await _run(device.async_stop(slot))
        await coordinator.async_request_refresh()

    async def calibration_command(call: ServiceCall) -> ServiceResponse:
        coordinator = _coordinator(hass, call)
        opcode = CalCommand[call.data["command"].upper()]
        slot = call.data.get(ATTR_SLOT, 0)
        value = call.data["value"]

        if opcode is CalCommand.ENTER and ATTR_SLOT not in call.data:
            raise HomeAssistantError("the 'enter' command needs a slot")
        if opcode is CalCommand.SET_FIXED_CURRENT and not (
            0.0 <= value <= CAL_FIXED_CURRENT_MAX_PU
        ):
            raise HomeAssistantError(
                f"fixed current must be 0.0-{CAL_FIXED_CURRENT_MAX_PU} pu "
                "(1.0 pu is about 10 A)"
            )

        try:
            status = await coordinator.device.async_cal_command(opcode, slot, value)
        except (UnitRefusedError, TransportError, ValueError) as err:
            raise HomeAssistantError(str(err)) from err

        # The live per-unit readings are what an operator adjusts a bench
        # supply against, so they are returned rather than only logged.
        return {
            "slot": status.slot,
            "active": status.active,
            "status_bits": status.status_bits,
            "result": status.result.name.lower(),
            "voltage_valid": status.v_tick,
            "current_valid": status.i_tick,
            "ads_v_pu": status.ads_v_pu,
            "ads_i_pu": status.ads_i_pu,
            "ads_v_v": status.ads_v_v,
            "ads_i_a": status.ads_i_a,
            "f28_v_pu": status.f28_v_pu,
            "f28_i_pu": status.f28_i_pu,
            "temp_c": status.temp_c,
        }

    async def get_result(call: ServiceCall) -> ServiceResponse:
        coordinator = _coordinator(hass, call)
        slot = call.data[ATTR_SLOT]
        try:
            result = await coordinator.device.async_read_result(slot)
        except (TransportError, UnitRefusedError) as err:
            raise HomeAssistantError(str(err)) from err
        return {
            "slot": result.slot,
            "valid": result.valid,
            "serial": result.serial,
            "model_name": result.model_name,
            "chemistry": result.chemistry.name.lower(),
            "discharge_mah": result.discharge_mah,
            "discharge_mwh": result.discharge_mwh,
            "discharge_seconds": result.discharge_seconds,
            "start_voltage_v": result.start_voltage_v,
            "end_voltage_v": result.end_voltage_v,
            "rested_voltage_v": result.rested_voltage_v,
            "max_temp_c": result.max_temp_c,
            "max_current_a": result.max_current_a,
            "recharged": result.recharged,
            "recharge_mah": result.recharge_mah,
            # Seconds of proxy uptime, NOT a wall clock - the device has no
            # RTC. A caller that needs a timestamp applies its own now.
            "completed_uptime_s": result.completed_uptime_s,
        }

    hass.services.async_register(
        DOMAIN, SERVICE_CONFIGURE_SLOT, configure_slot, schema=CONFIGURE_SCHEMA
    )
    hass.services.async_register(
        DOMAIN, SERVICE_SET_SERIAL, set_serial, schema=SET_SERIAL_SCHEMA
    )
    hass.services.async_register(
        DOMAIN, SERVICE_RESUME_SLOT, resume_slot, schema=RESUME_SCHEMA
    )
    hass.services.async_register(
        DOMAIN, SERVICE_SET_MODE, set_mode, schema=SET_MODE_SCHEMA
    )
    hass.services.async_register(
        DOMAIN,
        SERVICE_CALIBRATION,
        calibration_command,
        schema=CALIBRATION_SCHEMA,
        supports_response=SupportsResponse.ONLY,
    )
    hass.services.async_register(
        DOMAIN,
        SERVICE_GET_RESULT,
        get_result,
        schema=GET_RESULT_SCHEMA,
        supports_response=SupportsResponse.ONLY,
    )


async def _run(awaitable) -> None:
    """Translate the device layer's errors into Home Assistant's."""
    try:
        await awaitable
    except (UnitRefusedError, TransportError, ValueError) as err:
        raise HomeAssistantError(str(err)) from err


def async_unregister_services(hass: HomeAssistant) -> None:
    for service in (
        SERVICE_CONFIGURE_SLOT,
        SERVICE_SET_SERIAL,
        SERVICE_RESUME_SLOT,
        SERVICE_SET_MODE,
        SERVICE_CALIBRATION,
        SERVICE_GET_RESULT,
    ):
        hass.services.async_remove(DOMAIN, service)
