"""Binary sensors: slot and unit condition flags.

Several of these are wired to bits the current firmware never sets. They are
still exposed, with the reason recorded in the description, because omitting
them would make a future firmware that *does* set them silently invisible -
and because an operator asking "is the over-current flag showing?" deserves
an answer of "no" rather than a missing entity.
"""

from __future__ import annotations

from collections.abc import Callable
from dataclasses import dataclass

from homeassistant.components.binary_sensor import (
    BinarySensorDeviceClass,
    BinarySensorEntity,
    BinarySensorEntityDescription,
)
from homeassistant.config_entries import ConfigEntry
from homeassistant.const import EntityCategory
from homeassistant.core import HomeAssistant
from homeassistant.helpers.entity_platform import AddEntitiesCallback

from .const import DOMAIN, SlotFault, StatusBit
from .coordinator import LionCoordinator
from .entity import LionEntity, LionSlotEntity
from .protocol.ble import SlotStatus, UnitStatus


@dataclass(frozen=True, kw_only=True)
class SlotBinaryDescription(BinarySensorEntityDescription):
    value_fn: Callable[[SlotStatus], bool]


@dataclass(frozen=True, kw_only=True)
class UnitBinaryDescription(BinarySensorEntityDescription):
    value_fn: Callable[[UnitStatus], bool]


SLOT_BINARY_SENSORS: tuple[SlotBinaryDescription, ...] = (
    SlotBinaryDescription(
        key="running",
        translation_key="running",
        device_class=BinarySensorDeviceClass.RUNNING,
        value_fn=lambda s: s.is_running,
    ),
    SlotBinaryDescription(
        key="charging",
        translation_key="charging",
        device_class=BinarySensorDeviceClass.BATTERY_CHARGING,
        value_fn=lambda s: s.is_charging,
    ),
    SlotBinaryDescription(
        key="paused",
        translation_key="paused",
        value_fn=lambda s: s.is_paused,
    ),
    SlotBinaryDescription(
        key="needs_operator",
        translation_key="needs_operator",
        device_class=BinarySensorDeviceClass.PROBLEM,
        # A watchdog pause or an F-RAM restore means the unit lost the host
        # mid-run: the cell in the holder may not be the cell the counters
        # belong to, so resuming is an operator decision.
        value_fn=lambda s: s.needs_operator,
    ),
    SlotBinaryDescription(
        key="fault",
        translation_key="fault",
        device_class=BinarySensorDeviceClass.PROBLEM,
        value_fn=lambda s: s.fault is not SlotFault.NONE,
    ),
    SlotBinaryDescription(
        key="reverse_polarity",
        translation_key="reverse_polarity",
        device_class=BinarySensorDeviceClass.PROBLEM,
        value_fn=lambda s: bool(s.status_bits & StatusBit.REVERSE_POLARITY),
    ),
    SlotBinaryDescription(
        key="calibrating",
        translation_key="calibrating",
        entity_category=EntityCategory.DIAGNOSTIC,
        value_fn=lambda s: bool(s.status_bits & StatusBit.CALIBRATING),
    ),
    SlotBinaryDescription(
        key="calibration_valid",
        translation_key="calibration_valid",
        entity_category=EntityCategory.DIAGNOSTIC,
        # Driven from the PERSISTED validity flags, so a slot calibrated in an
        # earlier session still reads true after a power cycle.
        value_fn=lambda s: bool(
            s.status_bits & StatusBit.CAL_V_VALID
            and s.status_bits & StatusBit.CAL_I_VALID
        ),
    ),
    SlotBinaryDescription(
        key="group_follower",
        translation_key="group_follower",
        entity_category=EntityCategory.DIAGNOSTIC,
        # A follower has no control loop of its own and mirrors its group
        # leader; commanding it is refused by the unit.
        value_fn=lambda s: bool(s.status_bits & StatusBit.SLAVE_MODE),
    ),
    SlotBinaryDescription(
        key="slot_disabled",
        translation_key="slot_disabled",
        entity_category=EntityCategory.DIAGNOSTIC,
        value_fn=lambda s: bool(s.status_bits & StatusBit.SLOT_DISABLED),
    ),
    SlotBinaryDescription(
        key="overcurrent_trip",
        translation_key="overcurrent_trip",
        device_class=BinarySensorDeviceClass.PROBLEM,
        entity_category=EntityCategory.DIAGNOSTIC,
        # NEVER SET on the current build: every hardware trip source is masked
        # (BTS_TRIP_HW_CHn_ENABLED is false for all eight), so epwmTripISR()
        # is never entered. The software over-current path brings the PWM down
        # without raising this bit. Do not use it as the fault indicator -
        # that is the `fault` sensor.
        value_fn=lambda s: bool(s.status_bits & StatusBit.OVERCURRENT_TRIP),
    ),
)


UNIT_BINARY_SENSORS: tuple[UnitBinaryDescription, ...] = (
    UnitBinaryDescription(
        key="online",
        translation_key="online",
        device_class=BinarySensorDeviceClass.CONNECTIVITY,
        value_fn=lambda u: u.online,
    ),
    UnitBinaryDescription(
        key="charge_allowed",
        translation_key="charge_allowed",
        entity_category=EntityCategory.DIAGNOSTIC,
        # The input bus governs this: a charge command outside the window is
        # refused outright, leaving the slot stopped with no error anywhere.
        value_fn=lambda u: u.unit_state.charge_allowed,
    ),
    UnitBinaryDescription(
        key="discharge_allowed",
        translation_key="discharge_allowed",
        entity_category=EntityCategory.DIAGNOSTIC,
        value_fn=lambda u: u.unit_state.discharge_allowed,
    ),
    UnitBinaryDescription(
        key="watchdog_armed",
        translation_key="watchdog_armed",
        device_class=BinarySensorDeviceClass.SAFETY,
        entity_category=EntityCategory.DIAGNOSTIC,
        # Off means nothing stops the converters if this host goes away
        # mid-run. That is the safety gap the watchdog exists to close.
        value_fn=lambda u: u.watchdog_armed,
    ),
    UnitBinaryDescription(
        key="wifi_connected",
        translation_key="wifi_connected",
        device_class=BinarySensorDeviceClass.CONNECTIVITY,
        entity_category=EntityCategory.DIAGNOSTIC,
        value_fn=lambda u: u.wifi_connected,
    ),
)


async def async_setup_entry(
    hass: HomeAssistant,
    entry: ConfigEntry,
    async_add_entities: AddEntitiesCallback,
) -> None:
    coordinator: LionCoordinator = hass.data[DOMAIN][entry.entry_id]

    entities: list[BinarySensorEntity] = [
        LionUnitBinarySensor(coordinator, d) for d in UNIT_BINARY_SENSORS
    ]
    for slot in range(coordinator.device.slot_count):
        entities.extend(
            LionSlotBinarySensor(coordinator, slot, d)
            for d in SLOT_BINARY_SENSORS
        )
    async_add_entities(entities)


class LionSlotBinarySensor(LionSlotEntity, BinarySensorEntity):
    entity_description: SlotBinaryDescription

    def __init__(
        self,
        coordinator: LionCoordinator,
        slot: int,
        description: SlotBinaryDescription,
    ) -> None:
        super().__init__(coordinator, slot, description.key)
        self.entity_description = description

    @property
    def is_on(self) -> bool | None:
        status = self.status
        if status is None:
            return None
        return self.entity_description.value_fn(status)

    @property
    def available(self) -> bool:
        # A strap-disabled slot still reports its own disabled flag, which
        # would otherwise be the one entity that can never be seen.
        if self.entity_description.key == "slot_disabled":
            return self.coordinator.last_update_success and self.status is not None
        return super().available


class LionUnitBinarySensor(LionEntity, BinarySensorEntity):
    entity_description: UnitBinaryDescription

    def __init__(
        self, coordinator: LionCoordinator, description: UnitBinaryDescription
    ) -> None:
        super().__init__(coordinator, description.key)
        self.entity_description = description

    @property
    def is_on(self) -> bool | None:
        if self.coordinator.data is None:
            return None
        return self.entity_description.value_fn(self.coordinator.data.unit)

    @property
    def available(self) -> bool:
        # "online" must stay available to report being offline.
        if self.entity_description.key == "online":
            return self.coordinator.last_update_success
        return super().available
