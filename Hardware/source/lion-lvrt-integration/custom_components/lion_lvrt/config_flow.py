"""Config flow.

Supports Bluetooth auto-discovery (the proxy advertises as ``BTS-Tester``)
and manual set-up for CAN or HTTP.

The service UUID is in the **scan response**, not the advertisement - a
128-bit UUID plus the name does not fit in 31 bytes - so discovery in
``manifest.json`` matches on the local name. A passive-only scan sees the
name but not the UUID.
"""

from __future__ import annotations

import logging
from typing import Any

import voluptuous as vol
from homeassistant.config_entries import ConfigFlow, ConfigFlowResult
from homeassistant.helpers import config_validation as cv

from .const import (
    CONF_ADDRESS,
    CONF_CAN_BITRATE,
    CONF_CAN_INTERFACE,
    CONF_HTTP_HOST,
    CONF_SLOT_COUNT,
    CONF_TRANSPORT,
    DEFAULT_DEVICE_NAME,
    DOMAIN,
    SLOT_COUNT,
    TRANSPORT_BLE,
    TRANSPORT_CAN,
    TRANSPORT_HTTP,
)

_LOGGER = logging.getLogger(__name__)


class LionConfigFlow(ConfigFlow, domain=DOMAIN):
    """Set up one battery tester."""

    VERSION = 1

    def __init__(self) -> None:
        self._discovered_address: str | None = None
        self._discovered_name: str | None = None

    # --- Bluetooth discovery ---------------------------------------------

    async def async_step_bluetooth(
        self, discovery_info: Any
    ) -> ConfigFlowResult:
        """Handle a tester found by Home Assistant's Bluetooth stack.

        This fires for a device seen by any adapter, local or proxied.
        """
        await self.async_set_unique_id(discovery_info.address)
        self._abort_if_unique_id_configured()

        self._discovered_address = discovery_info.address
        self._discovered_name = discovery_info.name or DEFAULT_DEVICE_NAME
        self.context["title_placeholders"] = {"name": self._discovered_name}
        return await self.async_step_bluetooth_confirm()

    async def async_step_bluetooth_confirm(
        self, user_input: dict[str, Any] | None = None
    ) -> ConfigFlowResult:
        if user_input is not None:
            return self._create_entry(
                {
                    CONF_TRANSPORT: TRANSPORT_BLE,
                    CONF_ADDRESS: self._discovered_address,
                    CONF_SLOT_COUNT: user_input[CONF_SLOT_COUNT],
                    # Optional second link for register access, which is what
                    # enables direct charge/discharge on firmware without the
                    # register characteristic.
                    **_optional_links(user_input),
                },
                self._discovered_name or DEFAULT_DEVICE_NAME,
            )

        return self.async_show_form(
            step_id="bluetooth_confirm",
            data_schema=_link_schema(),
            description_placeholders={
                "name": self._discovered_name or DEFAULT_DEVICE_NAME,
                "address": self._discovered_address or "",
            },
        )

    # --- manual set-up ----------------------------------------------------

    async def async_step_user(
        self, user_input: dict[str, Any] | None = None
    ) -> ConfigFlowResult:
        if user_input is not None:
            transport = user_input[CONF_TRANSPORT]
            if transport == TRANSPORT_BLE:
                return await self.async_step_ble()
            if transport == TRANSPORT_CAN:
                return await self.async_step_can()
            return await self.async_step_http()

        return self.async_show_form(
            step_id="user",
            data_schema=vol.Schema(
                {
                    vol.Required(CONF_TRANSPORT, default=TRANSPORT_BLE): vol.In(
                        {
                            TRANSPORT_BLE: "Bluetooth LE (via a proxy or local adapter)",
                            TRANSPORT_CAN: "CAN bus (SocketCAN)",
                            TRANSPORT_HTTP: "HTTP (the proxy's web API)",
                        }
                    )
                }
            ),
        )

    async def async_step_ble(
        self, user_input: dict[str, Any] | None = None
    ) -> ConfigFlowResult:
        if user_input is not None:
            address = user_input[CONF_ADDRESS].upper()
            await self.async_set_unique_id(address)
            self._abort_if_unique_id_configured()
            return self._create_entry(
                {
                    CONF_TRANSPORT: TRANSPORT_BLE,
                    CONF_ADDRESS: address,
                    CONF_SLOT_COUNT: user_input[CONF_SLOT_COUNT],
                    **_optional_links(user_input),
                },
                DEFAULT_DEVICE_NAME,
            )

        return self.async_show_form(
            step_id="ble",
            data_schema=_link_schema(
                {vol.Required(CONF_ADDRESS): cv.string}
            ),
        )

    async def async_step_can(
        self, user_input: dict[str, Any] | None = None
    ) -> ConfigFlowResult:
        if user_input is not None:
            interface = user_input[CONF_CAN_INTERFACE]
            await self.async_set_unique_id(f"can:{interface}")
            self._abort_if_unique_id_configured()
            return self._create_entry(
                {
                    CONF_TRANSPORT: TRANSPORT_CAN,
                    CONF_CAN_INTERFACE: interface,
                    CONF_CAN_BITRATE: user_input[CONF_CAN_BITRATE],
                    CONF_SLOT_COUNT: user_input[CONF_SLOT_COUNT],
                },
                f"Battery tester ({interface})",
            )

        return self.async_show_form(
            step_id="can",
            data_schema=vol.Schema(
                {
                    vol.Required(CONF_CAN_INTERFACE, default="can0"): cv.string,
                    vol.Required(CONF_CAN_BITRATE, default=500000): vol.In(
                        [125000, 250000, 500000, 1000000]
                    ),
                    vol.Required(CONF_SLOT_COUNT, default=SLOT_COUNT): vol.All(
                        vol.Coerce(int), vol.Range(min=1, max=8)
                    ),
                }
            ),
        )

    async def async_step_http(
        self, user_input: dict[str, Any] | None = None
    ) -> ConfigFlowResult:
        if user_input is not None:
            host = user_input[CONF_HTTP_HOST]
            await self.async_set_unique_id(f"http:{host}")
            self._abort_if_unique_id_configured()
            return self._create_entry(
                {
                    CONF_TRANSPORT: TRANSPORT_HTTP,
                    CONF_HTTP_HOST: host,
                    CONF_SLOT_COUNT: user_input[CONF_SLOT_COUNT],
                },
                f"Battery tester ({host})",
            )

        return self.async_show_form(
            step_id="http",
            data_schema=vol.Schema(
                {
                    vol.Required(CONF_HTTP_HOST): cv.string,
                    vol.Required(CONF_SLOT_COUNT, default=SLOT_COUNT): vol.All(
                        vol.Coerce(int), vol.Range(min=1, max=8)
                    ),
                }
            ),
        )

    def _create_entry(self, data: dict[str, Any], title: str) -> ConfigFlowResult:
        return self.async_create_entry(title=title, data=data)


def _link_schema(extra: dict | None = None) -> vol.Schema:
    """Schema for a BLE set-up, with the optional register links."""
    fields: dict = dict(extra or {})
    fields[vol.Required(CONF_SLOT_COUNT, default=SLOT_COUNT)] = vol.All(
        vol.Coerce(int), vol.Range(min=1, max=8)
    )
    # Blank means "not configured". Either one grants register access, and
    # with it direct charge/discharge control.
    fields[vol.Optional(CONF_CAN_INTERFACE, default="")] = cv.string
    fields[vol.Optional(CONF_HTTP_HOST, default="")] = cv.string
    return vol.Schema(fields)


def _optional_links(user_input: dict[str, Any]) -> dict[str, Any]:
    out: dict[str, Any] = {}
    if user_input.get(CONF_CAN_INTERFACE):
        out[CONF_CAN_INTERFACE] = user_input[CONF_CAN_INTERFACE]
        out[CONF_CAN_BITRATE] = user_input.get(CONF_CAN_BITRATE, 500000)
    if user_input.get(CONF_HTTP_HOST):
        out[CONF_HTTP_HOST] = user_input[CONF_HTTP_HOST]
    return out
