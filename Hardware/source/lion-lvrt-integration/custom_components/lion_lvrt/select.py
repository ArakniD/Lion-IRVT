"""Per-slot mode control.

The select entity is the answer to "modes for every slot". Its options span
both control surfaces described in :mod:`.device`:

* ``idle`` / ``charge`` / ``discharge`` write ``eChX_Mode`` directly and need
  a register-capable transport.
* ``test`` runs the ESP32's full characterisation sequence.

Options that the configured transports cannot deliver are **omitted from the
list** rather than offered and then failing: a dropdown that lists an action
the hardware cannot perform is worse than one that is honest about its
capability.
"""

from __future__ import annotations

import logging

from homeassistant.components.select import SelectEntity
from homeassistant.config_entries import ConfigEntry
from homeassistant.core import HomeAssistant
from homeassistant.exceptions import HomeAssistantError
from homeassistant.helpers.entity_platform import AddEntitiesCallback

from .const import DOMAIN, StatusBit
from .coordinator import LionCoordinator
from .entity import LionSlotEntity
from .transport.base import TransportError, UnitRefusedError

_LOGGER = logging.getLogger(__name__)

MODE_IDLE = "idle"
MODE_CHARGE = "charge"
MODE_DISCHARGE = "discharge"
MODE_TEST = "test"
MODE_PAUSED = "paused"
MODE_CALIBRATING = "calibrating"

#: Reported but never selectable: they describe a state the unit entered on
#: its own, and entering them from here would need a different command.
_READ_ONLY_MODES = (MODE_PAUSED, MODE_CALIBRATING)


async def async_setup_entry(
    hass: HomeAssistant,
    entry: ConfigEntry,
    async_add_entities: AddEntitiesCallback,
) -> None:
    coordinator: LionCoordinator = hass.data[DOMAIN][entry.entry_id]
    async_add_entities(
        LionSlotModeSelect(coordinator, slot)
        for slot in range(coordinator.device.slot_count)
    )


class LionSlotModeSelect(LionSlotEntity, SelectEntity):
    """What a slot is doing, and what it can be told to do."""

    _attr_translation_key = "slot_mode"

    def __init__(self, coordinator: LionCoordinator, slot: int) -> None:
        super().__init__(coordinator, slot, "mode")

    @property
    def options(self) -> list[str]:
        device = self.coordinator.device
        options = [MODE_IDLE]
        if device.supports_direct_mode:
            options += [MODE_CHARGE, MODE_DISCHARGE]
        if device.supports_test_engine:
            options.append(MODE_TEST)
        # A state the slot is currently in must appear in the list, or Home
        # Assistant renders the entity as having an invalid state.
        current = self.current_option
        if current and current not in options:
            options.append(current)
        return options

    @property
    def current_option(self) -> str | None:
        status = self.status
        if status is None:
            return None
        bits = status.status_bits
        if bits & StatusBit.CALIBRATING:
            return MODE_CALIBRATING
        if status.is_paused:
            return MODE_PAUSED
        if status.is_charging:
            return MODE_CHARGE
        if status.is_discharging:
            return MODE_DISCHARGE
        if status.state.is_active:
            return MODE_TEST
        return MODE_IDLE

    async def async_select_option(self, option: str) -> None:
        if option in _READ_ONLY_MODES:
            raise HomeAssistantError(
                f"'{option}' reports a state the unit entered on its own and "
                "cannot be selected. Use the pause or resume button, or the "
                f"{DOMAIN}.calibration_command service"
            )

        device = self.coordinator.device
        try:
            if option == MODE_IDLE:
                await self._stop()
            elif option == MODE_CHARGE:
                await device.async_charge(self.slot)
            elif option == MODE_DISCHARGE:
                await device.async_discharge(self.slot)
            elif option == MODE_TEST:
                await device.async_start_test(self.slot)
            else:
                raise HomeAssistantError(f"unknown mode '{option}'")
        except (UnitRefusedError, TransportError, ValueError) as err:
            raise HomeAssistantError(str(err)) from err

        # The unit can accept a mode write and still not act on it - an input
        # bus outside the window leaves the slot stopped with no error
        # anywhere. Refreshing immediately makes that visible.
        await self.coordinator.async_request_refresh()

    async def _stop(self) -> None:
        """Stop the slot, whichever surface started it."""
        device = self.coordinator.device
        status = self.status
        if status is not None and status.state.is_active:
            await device.async_abort(self.slot)
            return
        if device.supports_direct_mode:
            await device.async_stop(self.slot)
            return
        await device.async_abort(self.slot)
