"""Test configuration.

TWO TIERS, ONE SUITE
--------------------
The protocol, transport and device layers deliberately do not import Home
Assistant, so their tests run on any Python 3.10+. The entity and config-flow
tests need the real thing.

Home Assistant requires Python 3.12+, which is not always what a bench
machine has. So this file installs a **minimal stub** of the handful of
Home Assistant symbols that ``custom_components/lion_lvrt/__init__.py``
imports at module scope, but only when the real package is absent. The stub
exists purely so that importing ``custom_components.lion_lvrt.const`` does
not drag in a framework the hardware layer never uses; it is never used to
*test* Home Assistant behaviour. Tests that need real Home Assistant are
skipped with a message saying so.

Install the full harness with::

    python -m pip install -r requirements-test.txt

which pulls in ``pytest-homeassistant-custom-component`` and its pinned
Home Assistant, and then every test in this suite runs for real.
"""

from __future__ import annotations

import sys
import types
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

try:  # pragma: no cover - depends on the environment, not on the code
    import homeassistant  # noqa: F401

    HA_AVAILABLE = True
except ImportError:
    HA_AVAILABLE = False


#: Skip marker for tests that need the real framework.
requires_ha = pytest.mark.skipif(
    not HA_AVAILABLE,
    reason=(
        "Home Assistant is not installed (it needs Python 3.12+). "
        "Run `python -m pip install -r requirements-test.txt` on a 3.12+ "
        "interpreter to enable the entity and config-flow tests."
    ),
)


def _install_ha_stubs() -> None:
    """Register just enough of the Home Assistant namespace to import.

    Only module-scope imports in the integration are covered. Anything that
    actually exercises framework behaviour is skipped rather than faked -
    a stub that pretended to be Home Assistant would test nothing and hide
    real breakage.
    """

    def module(name: str, **attrs: object) -> types.ModuleType:
        mod = types.ModuleType(name)
        for key, value in attrs.items():
            setattr(mod, key, value)
        sys.modules[name] = mod
        return mod

    class _Sentinel:
        """Accepts any attribute, call or subscript."""

        def __init__(self, *args: object, **kwargs: object) -> None: ...
        def __getattr__(self, item: str) -> "_Sentinel":
            return _Sentinel()
        def __call__(self, *args: object, **kwargs: object) -> "_Sentinel":
            return _Sentinel()
        def __class_getitem__(cls, item: object) -> type:
            return cls

    class _HomeAssistantError(Exception):
        pass

    class _ConfigEntryNotReady(_HomeAssistantError):
        pass

    module("homeassistant")
    module("homeassistant.core", HomeAssistant=_Sentinel, ServiceCall=_Sentinel,
           ServiceResponse=dict, SupportsResponse=_Sentinel())
    module(
        "homeassistant.config_entries",
        ConfigEntry=_Sentinel,
        ConfigFlow=_Sentinel,
        ConfigFlowResult=dict,
    )
    module(
        "homeassistant.exceptions",
        HomeAssistantError=_HomeAssistantError,
        ConfigEntryNotReady=_ConfigEntryNotReady,
    )
    module("homeassistant.const", Platform=_Sentinel(), EntityCategory=_Sentinel(),
           UnitOfElectricCurrent=_Sentinel(), UnitOfElectricPotential=_Sentinel(),
           UnitOfEnergy=_Sentinel(), UnitOfTemperature=_Sentinel(),
           UnitOfTime=_Sentinel())
    module("homeassistant.helpers")
    module("homeassistant.helpers.config_validation", string=str, boolean=bool)
    module("homeassistant.helpers.device_registry", DeviceInfo=dict)
    module("homeassistant.helpers.entity_platform", AddEntitiesCallback=_Sentinel)
    module("homeassistant.helpers.aiohttp_client",
           async_get_clientsession=lambda hass: None)
    module(
        "homeassistant.helpers.update_coordinator",
        DataUpdateCoordinator=_Sentinel,
        CoordinatorEntity=_Sentinel,
        UpdateFailed=_HomeAssistantError,
    )
    module("homeassistant.components")
    for platform, extra in (
        ("sensor", ("SensorDeviceClass", "SensorEntity", "SensorEntityDescription",
                    "SensorStateClass")),
        ("binary_sensor", ("BinarySensorDeviceClass", "BinarySensorEntity",
                           "BinarySensorEntityDescription")),
        ("button", ("ButtonEntity", "ButtonEntityDescription")),
        ("select", ("SelectEntity",)),
        ("number", ("NumberDeviceClass", "NumberEntity", "NumberEntityDescription",
                    "NumberMode")),
    ):
        module(
            f"homeassistant.components.{platform}",
            **{name: _Sentinel for name in extra},
        )

    if "voluptuous" not in sys.modules:
        try:
            import voluptuous  # noqa: F401
        except ImportError:
            module("voluptuous", Schema=_Sentinel, Required=_Sentinel,
                   Optional=_Sentinel, All=_Sentinel, Range=_Sentinel,
                   In=_Sentinel, Coerce=_Sentinel, Length=_Sentinel)


if not HA_AVAILABLE:
    _install_ha_stubs()


@pytest.fixture
def simulated_unit():
    """A tester with default settings: 8 slots, input OK, watchdog armed."""
    from tests.simulator.unit import SimulatedUnit

    return SimulatedUnit()


@pytest.fixture
def fake_client(simulated_unit):
    from tests.simulator.fake_ble import FakeBleClient

    return FakeBleClient(simulated_unit)
