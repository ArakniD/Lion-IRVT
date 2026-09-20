"""Number entities: per-slot limits and unit thresholds.

These write the settings block directly, so they need a register-capable
transport and the platform sets up nothing without one.

Every value is clamped to the unit's hardware envelope before it is sent.
The firmware clamps again as a backstop - it is the last code that runs
before the values reach the power stage - but arriving pre-clamped means the
operator sees the value that will actually be applied.
"""

from __future__ import annotations

import logging
from dataclasses import dataclass

from homeassistant.components.number import (
    NumberDeviceClass,
    NumberEntity,
    NumberEntityDescription,
    NumberMode,
)
from homeassistant.config_entries import ConfigEntry
from homeassistant.const import (
    EntityCategory,
    UnitOfElectricCurrent,
    UnitOfElectricPotential,
    UnitOfTemperature,
    UnitOfTime,
)
from homeassistant.core import HomeAssistant
from homeassistant.exceptions import HomeAssistantError
from homeassistant.helpers.entity_platform import AddEntitiesCallback

from .const import DOMAIN, UNIT_MAX_CURRENT_A, UNIT_MAX_VOLTAGE_V
from .coordinator import LionCoordinator
from .entity import LionEntity, LionSlotEntity
from .protocol import registers as regs
from .transport.base import TransportError, UnitRefusedError

_LOGGER = logging.getLogger(__name__)


@dataclass(frozen=True, kw_only=True)
class SlotNumberDescription(NumberEntityDescription):
    """A writable per-slot register."""

    #: Byte offset within the slot's settings block.
    offset: int


@dataclass(frozen=True, kw_only=True)
class UnitNumberDescription(NumberEntityDescription):
    address: int


SLOT_NUMBERS: tuple[SlotNumberDescription, ...] = (
    SlotNumberDescription(
        key="charge_voltage_max",
        translation_key="charge_voltage_max",
        offset=regs.SET_CHARGE_V_MAX,
        device_class=NumberDeviceClass.VOLTAGE,
        native_unit_of_measurement=UnitOfElectricPotential.VOLT,
        native_min_value=0.0,
        native_max_value=UNIT_MAX_VOLTAGE_V,
        native_step=0.01,
        mode=NumberMode.BOX,
        entity_category=EntityCategory.CONFIG,
    ),
    SlotNumberDescription(
        key="charge_voltage_min",
        translation_key="charge_voltage_min",
        offset=regs.SET_CHARGE_V_MIN,
        device_class=NumberDeviceClass.VOLTAGE,
        native_unit_of_measurement=UnitOfElectricPotential.VOLT,
        native_min_value=0.0,
        native_max_value=UNIT_MAX_VOLTAGE_V,
        native_step=0.01,
        mode=NumberMode.BOX,
        entity_category=EntityCategory.CONFIG,
    ),
    SlotNumberDescription(
        key="discharge_voltage_min",
        translation_key="discharge_voltage_min",
        offset=regs.SET_DISCHARGE_V_MIN,
        device_class=NumberDeviceClass.VOLTAGE,
        native_unit_of_measurement=UnitOfElectricPotential.VOLT,
        native_min_value=0.0,
        native_max_value=UNIT_MAX_VOLTAGE_V,
        native_step=0.01,
        mode=NumberMode.BOX,
        entity_category=EntityCategory.CONFIG,
    ),
    SlotNumberDescription(
        key="discharge_voltage_max",
        translation_key="discharge_voltage_max",
        offset=regs.SET_DISCHARGE_V_MAX,
        device_class=NumberDeviceClass.VOLTAGE,
        native_unit_of_measurement=UnitOfElectricPotential.VOLT,
        native_min_value=0.0,
        native_max_value=UNIT_MAX_VOLTAGE_V,
        native_step=0.01,
        mode=NumberMode.BOX,
        entity_category=EntityCategory.CONFIG,
    ),
    SlotNumberDescription(
        key="charge_current_max",
        translation_key="charge_current_max",
        offset=regs.SET_CHARGE_I_MAX,
        device_class=NumberDeviceClass.CURRENT,
        native_unit_of_measurement=UnitOfElectricCurrent.AMPERE,
        native_min_value=0.0,
        native_max_value=UNIT_MAX_CURRENT_A,
        native_step=0.05,
        mode=NumberMode.BOX,
        entity_category=EntityCategory.CONFIG,
    ),
    SlotNumberDescription(
        key="discharge_current_max",
        translation_key="discharge_current_max",
        offset=regs.SET_DISCHARGE_I_MAX,
        device_class=NumberDeviceClass.CURRENT,
        native_unit_of_measurement=UnitOfElectricCurrent.AMPERE,
        native_min_value=0.0,
        native_max_value=UNIT_MAX_CURRENT_A,
        native_step=0.05,
        mode=NumberMode.BOX,
        entity_category=EntityCategory.CONFIG,
    ),
    SlotNumberDescription(
        key="min_cell_temp",
        translation_key="min_cell_temp",
        offset=regs.SET_MIN_CELL_TEMP,
        device_class=NumberDeviceClass.TEMPERATURE,
        native_unit_of_measurement=UnitOfTemperature.CELSIUS,
        # The converter's fourth-order fit bottoms out near +18 C for 0 V in
        # and saturates near 81 C, so values outside that are not meaningful.
        native_min_value=-10.0,
        native_max_value=80.0,
        native_step=0.5,
        mode=NumberMode.BOX,
        entity_category=EntityCategory.CONFIG,
    ),
    SlotNumberDescription(
        key="max_cell_temp",
        translation_key="max_cell_temp",
        offset=regs.SET_MAX_CELL_TEMP,
        device_class=NumberDeviceClass.TEMPERATURE,
        native_unit_of_measurement=UnitOfTemperature.CELSIUS,
        native_min_value=-10.0,
        native_max_value=80.0,
        native_step=0.5,
        mode=NumberMode.BOX,
        entity_category=EntityCategory.CONFIG,
    ),
)


UNIT_NUMBERS: tuple[UnitNumberDescription, ...] = (
    UnitNumberDescription(
        key="charge_disable_v",
        translation_key="charge_disable_v",
        address=regs.REG_CHARGE_DISABLE_V,
        device_class=NumberDeviceClass.VOLTAGE,
        native_unit_of_measurement=UnitOfElectricPotential.VOLT,
        native_min_value=0.0,
        native_max_value=60.0,
        native_step=0.1,
        mode=NumberMode.BOX,
        entity_category=EntityCategory.CONFIG,
    ),
    UnitNumberDescription(
        key="charge_restrict_v",
        translation_key="charge_restrict_v",
        address=regs.REG_CHARGE_RESTRICT_V,
        device_class=NumberDeviceClass.VOLTAGE,
        native_unit_of_measurement=UnitOfElectricPotential.VOLT,
        native_min_value=0.0,
        native_max_value=60.0,
        native_step=0.1,
        mode=NumberMode.BOX,
        entity_category=EntityCategory.CONFIG,
    ),
    UnitNumberDescription(
        key="discharge_restrict_v",
        translation_key="discharge_restrict_v",
        address=regs.REG_DISCHARGE_RESTRICT_V,
        device_class=NumberDeviceClass.VOLTAGE,
        native_unit_of_measurement=UnitOfElectricPotential.VOLT,
        native_min_value=0.0,
        native_max_value=60.0,
        native_step=0.1,
        mode=NumberMode.BOX,
        entity_category=EntityCategory.CONFIG,
    ),
    UnitNumberDescription(
        key="discharge_disable_v",
        translation_key="discharge_disable_v",
        address=regs.REG_DISCHARGE_DISABLE_V,
        device_class=NumberDeviceClass.VOLTAGE,
        native_unit_of_measurement=UnitOfElectricPotential.VOLT,
        native_min_value=0.0,
        native_max_value=60.0,
        native_step=0.1,
        mode=NumberMode.BOX,
        entity_category=EntityCategory.CONFIG,
    ),
    UnitNumberDescription(
        key="host_watchdog",
        translation_key="host_watchdog",
        address=regs.REG_HOST_WATCHDOG_S,
        native_unit_of_measurement=UnitOfTime.SECONDS,
        # 0 disables supervision. Allowed, because the firmware allows it and
        # a bench operator may need it - but the device layer logs a warning
        # whenever it is written.
        native_min_value=0.0,
        native_max_value=600.0,
        native_step=1.0,
        mode=NumberMode.BOX,
        entity_category=EntityCategory.CONFIG,
    ),
)


async def async_setup_entry(
    hass: HomeAssistant,
    entry: ConfigEntry,
    async_add_entities: AddEntitiesCallback,
) -> None:
    coordinator: LionCoordinator = hass.data[DOMAIN][entry.entry_id]

    if not coordinator.device.supports_direct_mode:
        _LOGGER.info(
            "No register-capable transport configured, so the settings "
            "numbers are unavailable. Add the CAN or HTTP transport to edit "
            "slot limits from Home Assistant"
        )
        return

    entities: list[NumberEntity] = [
        LionUnitNumber(coordinator, d) for d in UNIT_NUMBERS
    ]
    for slot in range(coordinator.device.slot_count):
        entities.extend(
            LionSlotNumber(coordinator, slot, d) for d in SLOT_NUMBERS
        )
    async_add_entities(entities, update_before_add=True)


class _RegisterNumber(NumberEntity):
    """Common read/write behaviour for a single register.

    The register file is not part of the coordinator's snapshot - it is far
    larger than anything polled at 1 Hz - so these entities read their own
    value on demand and cache it.
    """

    _address: int
    _attr_native_value: float | None = None

    @property
    def _coordinator(self) -> LionCoordinator:
        raise NotImplementedError

    async def async_update(self) -> None:
        device = self._coordinator.device
        try:
            self._attr_native_value = await device.async_read_register(self._address)
        except TransportError as err:
            _LOGGER.debug("Could not read register %d: %s", self._address, err)
            self._attr_native_value = None

    async def async_set_native_value(self, value: float) -> None:
        device = self._coordinator.device
        try:
            await device.async_write_register(self._address, float(value))
        except (TransportError, UnitRefusedError, ValueError) as err:
            raise HomeAssistantError(str(err)) from err
        # Read back rather than assume: a write to a register the target
        # considers read-only is silently discarded, not rejected.
        await self.async_update()
        self.async_write_ha_state()


class LionSlotNumber(LionSlotEntity, _RegisterNumber):
    entity_description: SlotNumberDescription

    def __init__(
        self,
        coordinator: LionCoordinator,
        slot: int,
        description: SlotNumberDescription,
    ) -> None:
        super().__init__(coordinator, slot, description.key)
        self.entity_description = description
        self._address = regs.set_addr(slot, description.offset)

    @property
    def _coordinator(self) -> LionCoordinator:
        return self.coordinator


class LionUnitNumber(LionEntity, _RegisterNumber):
    entity_description: UnitNumberDescription

    def __init__(
        self, coordinator: LionCoordinator, description: UnitNumberDescription
    ) -> None:
        super().__init__(coordinator, description.key)
        self.entity_description = description
        self._address = description.address

    @property
    def _coordinator(self) -> LionCoordinator:
        return self.coordinator
