"""Per-slot action buttons and unit-wide controls."""

from __future__ import annotations

import logging
from collections.abc import Awaitable, Callable
from dataclasses import dataclass

from homeassistant.components.button import ButtonEntity, ButtonEntityDescription
from homeassistant.config_entries import ConfigEntry
from homeassistant.const import EntityCategory
from homeassistant.core import HomeAssistant
from homeassistant.exceptions import HomeAssistantError
from homeassistant.helpers.entity_platform import AddEntitiesCallback

from .const import DOMAIN
from .coordinator import LionCoordinator
from .device import LionDevice
from .entity import LionEntity, LionSlotEntity
from .transport.base import TransportError, UnitRefusedError

_LOGGER = logging.getLogger(__name__)


@dataclass(frozen=True, kw_only=True)
class SlotButtonDescription(ButtonEntityDescription):
    press_fn: Callable[[LionDevice, int], Awaitable[None]]


@dataclass(frozen=True, kw_only=True)
class UnitButtonDescription(ButtonEntityDescription):
    press_fn: Callable[[LionDevice], Awaitable[None]]


SLOT_BUTTONS: tuple[SlotButtonDescription, ...] = (
    SlotButtonDescription(
        key="start",
        translation_key="start",
        press_fn=lambda device, slot: device.async_start_test(slot),
    ),
    SlotButtonDescription(
        key="stop",
        translation_key="stop",
        press_fn=lambda device, slot: device.async_abort(slot),
    ),
    SlotButtonDescription(
        key="pause",
        translation_key="pause",
        press_fn=lambda device, slot: device.async_pause(slot),
    ),
    SlotButtonDescription(
        key="resume",
        translation_key="resume",
        # Not forced: a slot paused by a watchdog trip or an F-RAM restore is
        # refused here on purpose. Overriding that is the
        # lion_lvrt.resume_slot service, where force is an explicit argument.
        press_fn=lambda device, slot: device.async_resume(slot),
    ),
    SlotButtonDescription(
        key="clear_fault",
        translation_key="clear_fault",
        entity_category=EntityCategory.CONFIG,
        press_fn=lambda device, slot: device.async_clear_fault(slot),
    ),
)


UNIT_BUTTONS: tuple[UnitButtonDescription, ...] = (
    UnitButtonDescription(
        key="abort_all",
        translation_key="abort_all",
        press_fn=lambda device: device.async_abort_all(),
    ),
)


async def async_setup_entry(
    hass: HomeAssistant,
    entry: ConfigEntry,
    async_add_entities: AddEntitiesCallback,
) -> None:
    coordinator: LionCoordinator = hass.data[DOMAIN][entry.entry_id]

    entities: list[ButtonEntity] = [
        LionUnitButton(coordinator, description) for description in UNIT_BUTTONS
    ]
    for slot in range(coordinator.device.slot_count):
        entities.extend(
            LionSlotButton(coordinator, slot, description)
            for description in SLOT_BUTTONS
        )
    async_add_entities(entities)


class LionSlotButton(LionSlotEntity, ButtonEntity):
    entity_description: SlotButtonDescription

    def __init__(
        self,
        coordinator: LionCoordinator,
        slot: int,
        description: SlotButtonDescription,
    ) -> None:
        super().__init__(coordinator, slot, description.key)
        self.entity_description = description

    async def async_press(self) -> None:
        try:
            await self.entity_description.press_fn(
                self.coordinator.device, self.slot
            )
        except (UnitRefusedError, TransportError, ValueError) as err:
            raise HomeAssistantError(str(err)) from err
        await self.coordinator.async_request_refresh()


class LionUnitButton(LionEntity, ButtonEntity):
    entity_description: UnitButtonDescription

    def __init__(
        self, coordinator: LionCoordinator, description: UnitButtonDescription
    ) -> None:
        super().__init__(coordinator, description.key)
        self.entity_description = description

    async def async_press(self) -> None:
        try:
            await self.entity_description.press_fn(self.coordinator.device)
        except (UnitRefusedError, TransportError) as err:
            raise HomeAssistantError(str(err)) from err
        await self.coordinator.async_request_refresh()
