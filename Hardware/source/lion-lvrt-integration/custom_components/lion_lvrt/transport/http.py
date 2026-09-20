"""HTTP transport, over the ESP32 proxy's web API.

The most capable single transport: it reaches both the test engine
(``/api/slot/<n>/start`` and friends) and the raw register file
(``/api/registers``), so a deployment with WiFi needs nothing else.

Its drawback is that it depends on the proxy having joined a network, which a
bench unit on a backup battery may not have done. BLE works regardless, which
is why BLE remains the default.

ROUTE ORDERING IS LOAD-BEARING ON THE DEVICE
--------------------------------------------
The firmware's URI matcher takes the first matching pattern, and its route
table is ordered deliberately. This client always sends fully-qualified paths
so it never depends on that ordering resolving in its favour.
"""

from __future__ import annotations

import logging
from typing import Any

from ..const import CalResult, SLOT_COUNT, UnitState
from ..protocol import registers as regs
from ..protocol.ble import (
    CalStatus,
    CellChemistry,
    SlotConfig,
    SlotFault,
    SlotResult,
    SlotState,
    SlotStatus,
    UnitStatus,
)
from .base import DeviceSnapshot, Transport, TransportError, UnitRefusedError

_LOGGER = logging.getLogger(__name__)

DEFAULT_TIMEOUT_S = 10.0

#: Calibration actions, keyed by opcode, as the API spells them.
_CAL_ACTIONS = {
    1: "enter",
    2: "exit",
    3: "voltage",
    4: "zero_current",
    5: "fixed_current",
    6: "current",
    7: "save",
    8: "clear",
}


class HttpTransport(Transport):
    """Talks to the proxy's REST API."""

    supports_registers = True
    supports_test_engine = True
    supports_notifications = False

    def __init__(
        self,
        host: str,
        session: Any,
        *,
        slot_count: int = SLOT_COUNT,
        timeout_s: float = DEFAULT_TIMEOUT_S,
    ) -> None:
        self._base = host.rstrip("/")
        if not self._base.startswith(("http://", "https://")):
            self._base = f"http://{self._base}"
        self._session = session
        self._slot_count = slot_count
        self._timeout_s = timeout_s

    async def async_connect(self) -> None:
        # Stateless; a failed probe here would be indistinguishable from the
        # unit being briefly offline, so connection is proven by the first poll.
        await self._get("/api/status")

    async def async_disconnect(self) -> None:
        return None

    # --- plumbing ---------------------------------------------------------

    async def _request(
        self, method: str, path: str, payload: dict | None = None
    ) -> dict:
        url = f"{self._base}{path}"
        try:
            async with self._session.request(
                method, url, json=payload, timeout=self._timeout_s
            ) as response:
                # One firmware error path emits {"error":...} with no "ok" key
                # and no CORS header when a response overflows its 6 KiB
                # buffer, so don't assume the documented envelope.
                body = await response.json(content_type=None)
                if response.status >= 400:
                    raise UnitRefusedError(
                        f"{method} {path} returned {response.status}: "
                        f"{body.get('error', body)}"
                    )
        except UnitRefusedError:
            raise
        except Exception as err:  # noqa: BLE001
            raise TransportError(f"{method} {url} failed: {err}") from err

        if isinstance(body, dict) and body.get("ok") is False:
            raise UnitRefusedError(body.get("error", "unit refused the request"))
        return body if isinstance(body, dict) else {"value": body}

    async def _get(self, path: str) -> dict:
        return await self._request("GET", path)

    async def _post(self, path: str, payload: dict | None = None) -> dict:
        return await self._request("POST", path, payload)

    # --- snapshot ---------------------------------------------------------

    async def async_poll(self) -> DeviceSnapshot:
        body = await self._get("/api/status")
        unit_body = body.get("unit", body)

        try:
            state = UnitState(int(unit_body.get("unit_state", 2)))
        except (ValueError, TypeError):
            state = UnitState.INPUT_OK

        unit = UnitStatus(
            version=int(unit_body.get("proto_version", 0)),
            slot_count=int(unit_body.get("slot_count", self._slot_count)),
            online=bool(unit_body.get("online", True)),
            unit_state=state,
            trip_status=int(unit_body.get("trip_status", 0)),
            input_voltage_v=float(unit_body.get("input_voltage_v", 0.0)),
            uptime_s=int(unit_body.get("uptime_s", 0)),
            stats_live=bool(unit_body.get("stats_live", False)),
            wifi_connected=bool(unit_body.get("wifi_connected", True)),
            watchdog_timeout_s=float(unit_body.get("watchdog_timeout_s", 0.0)),
        )

        slots: dict[int, SlotStatus] = {}
        for entry in body.get("slots", []):
            slot = int(entry.get("slot", -1))
            if not 0 <= slot < self._slot_count:
                continue
            slots[slot] = _slot_from_json(slot, entry)

        return DeviceSnapshot(unit=unit, slots=slots, cal=await self._read_cal())

    async def _read_cal(self) -> CalStatus | None:
        try:
            body = await self._get("/api/calibration")
        except (TransportError, UnitRefusedError) as err:
            _LOGGER.debug("Calibration state unavailable over HTTP: %s", err)
            return None
        telemetry = body.get("telemetry", {})
        try:
            result = CalResult(int(body.get("result", 0)))
        except ValueError:
            result = CalResult.OK
        slot = int(body.get("slot", CalStatus.NO_SLOT))
        return CalStatus(
            slot=slot if 0 <= slot < self._slot_count else CalStatus.NO_SLOT,
            active=bool(body.get("active", False)),
            v_tick=bool(body.get("v_tick", False)),
            i_tick=bool(body.get("i_tick", False)),
            status_bits=int(body.get("status", 0)),
            result=result,
            ads_v_pu=float(telemetry.get("ads_v_pu", 0.0)),
            ads_i_pu=float(telemetry.get("ads_i_pu", 0.0)),
            ads_v_v=float(telemetry.get("ads_v_v", 0.0)),
            ads_i_a=float(telemetry.get("ads_i_a", 0.0)),
            f28_v_pu=float(telemetry.get("f28_v_pu", 0.0)),
            f28_i_pu=float(telemetry.get("f28_i_pu", 0.0)),
            f28_v_v=float(telemetry.get("f28_v_v", 0.0)),
            f28_i_a=float(telemetry.get("f28_i_a", 0.0)),
            temp_c=float(telemetry.get("temp_c", 0.0)),
        )

    # --- commands ---------------------------------------------------------

    async def async_start(self, slot: int) -> None:
        await self._post(f"/api/slot/{slot}/start")

    async def async_abort(self, slot: int) -> None:
        await self._post(f"/api/slot/{slot}/abort")

    async def async_abort_all(self) -> None:
        await self._post("/api/abort_all")

    async def async_clear_fault(self, slot: int) -> None:
        await self._post(f"/api/slot/{slot}/clear")

    async def async_pause(self, slot: int) -> None:
        # The proxy's REST surface predates pause/resume, so these go through
        # the register file - the same edge-command bits the BLE opcodes set.
        from ..const import SlotMode  # noqa: PLC0415

        await self.async_write_register(
            regs.set_addr(slot, regs.SET_MODE), float(SlotMode.PAUSE)
        )

    async def async_resume(self, slot: int) -> None:
        from ..const import SlotMode  # noqa: PLC0415

        await self.async_write_register(
            regs.set_addr(slot, regs.SET_MODE), float(SlotMode.RESUME)
        )

    async def async_set_serial(self, slot: int, serial: str) -> None:
        await self._post(f"/api/slot/{slot}/serial", {"serial": serial})

    async def async_read_config(self, slot: int) -> SlotConfig:
        body = await self._get(f"/api/slot/{slot}")
        cfg = body.get("config", {})
        try:
            chem = CellChemistry(int(cfg.get("chemistry", 3)))
        except (ValueError, TypeError):
            chem = CellChemistry.NMC
        return SlotConfig(
            slot=slot,
            chemistry=chem,
            auto_recharge=bool(cfg.get("auto_recharge", False)),
            capacity_mah=float(cfg.get("capacity_mah", 0.0)),
            charge_c=float(cfg.get("charge_c", 0.0)),
            discharge_c=float(cfg.get("discharge_c", 0.0)),
            shipping_pct=float(cfg.get("shipping_pct", 60.0)),
            max_duration_minutes=int(cfg.get("max_duration_minutes", 0)),
            model_name=str(cfg.get("model_name", "")),
            serial=str(cfg.get("serial", "")),
        )

    async def async_write_config(self, config: SlotConfig) -> None:
        await self._post(
            f"/api/slot/{config.slot}/config",
            {
                "chemistry": int(config.chemistry),
                "auto_recharge": config.auto_recharge,
                "capacity_mah": config.capacity_mah,
                "charge_c": config.charge_c,
                "discharge_c": config.discharge_c,
                "shipping_pct": config.shipping_pct,
                "max_duration_minutes": config.max_duration_minutes,
                "model_name": config.model_name,
                "serial": config.serial,
            },
        )

    async def async_read_result(self, slot: int) -> SlotResult:
        body = await self._get(f"/api/slot/{slot}/result")
        try:
            chem = CellChemistry(int(body.get("chemistry", 3)))
        except (ValueError, TypeError):
            chem = CellChemistry.NMC
        return SlotResult(
            slot=slot,
            valid=bool(body.get("valid", False)),
            chemistry=chem,
            recharged=bool(body.get("recharged", False)),
            start_voltage_v=float(body.get("start_voltage_v", 0.0)),
            end_voltage_v=float(body.get("end_voltage_v", 0.0)),
            rested_voltage_v=float(body.get("rested_voltage_v", 0.0)),
            discharge_mah=float(body.get("discharge_mah", 0.0)),
            discharge_mwh=float(body.get("discharge_mwh", 0.0)),
            max_temp_c=float(body.get("max_temp_c", 0.0)),
            max_current_a=float(body.get("max_current_a", 0.0)),
            min_voltage_v=float(body.get("min_voltage_v", 0.0)),
            max_voltage_v=float(body.get("max_voltage_v", 0.0)),
            recharge_mah=float(body.get("recharge_mah", 0.0)),
            shipping_voltage_v=float(body.get("shipping_voltage_v", 0.0)),
            discharge_seconds=int(body.get("discharge_seconds", 0)),
            # The API is honest that this is uptime, not a wall clock.
            completed_uptime_s=int(body.get("completed_uptime_s", 0)),
            model_name=str(body.get("model_name", "")),
            serial=str(body.get("serial", "")),
        )

    async def async_cal_command(
        self, opcode: int, slot: int = 0, arg: float = 0.0
    ) -> CalStatus:
        action = _CAL_ACTIONS.get(int(opcode))
        if action is None:
            raise ValueError(f"calibration opcode {opcode} has no HTTP action")
        payload: dict[str, Any] = {}
        if int(opcode) == 1:
            payload["slot"] = slot
        if int(opcode) in (3, 5, 6):
            payload["value"] = arg
        await self._post(f"/api/calibration/{action}", payload or None)
        status = await self._read_cal()
        if status is None:
            raise TransportError("calibration status unreadable after command")
        return status

    # --- registers --------------------------------------------------------

    async def async_read_register(self, address: int) -> float:
        body = await self._get(f"/api/registers?addr={address}&count=1")
        values = body.get("values") or body.get("registers") or []
        if not values:
            raise TransportError(f"no value returned for register {address}")
        first = values[0]
        return float(first["value"] if isinstance(first, dict) else first)

    async def async_write_register(self, address: int, value: float) -> None:
        if not regs.is_writable(address):
            raise ValueError(
                f"register {address} is read-only; the unit would silently "
                "discard this write"
            )
        await self._post("/api/registers", {"addr": address, "value": value})


def _slot_from_json(slot: int, entry: dict) -> SlotStatus:
    """Decode one slot object from ``/api/status``."""
    try:
        state = SlotState(int(entry.get("state", 0)))
    except (ValueError, TypeError):
        state = SlotState.IDLE
    try:
        fault = SlotFault(int(entry.get("fault", 0)))
    except (ValueError, TypeError):
        fault = SlotFault.NONE

    return SlotStatus(
        slot=slot,
        state=state,
        fault=fault,
        configured=bool(entry.get("configured", False)),
        voltage_v=float(entry.get("voltage_v", 0.0)),
        current_a=float(entry.get("current_a", 0.0)),
        temp_c=float(entry.get("temp_c", 0.0)),
        live_mah=float(entry.get("live_mah", 0.0)),
        live_mwh=float(entry.get("live_mwh", 0.0)),
        progress=float(entry.get("progress", 0.0)),
        elapsed_s=int(entry.get("elapsed_s", 0)),
        state_elapsed_s=int(entry.get("state_elapsed_s", 0)),
        status_bits=int(entry.get("status_bits", 0)),
        bts_paused=bool(entry.get("bts_paused", False)),
        bts_wd_tripped=bool(entry.get("bts_wd_tripped", False)),
        bts_restored=bool(entry.get("bts_restored", False)),
        bts_ended=bool(entry.get("bts_ended", False)),
        bts_charge_mah=float(entry.get("bts_charge_mah", 0.0)),
        bts_charge_mwh=float(entry.get("bts_charge_mwh", 0.0)),
        bts_charge_seconds=float(entry.get("bts_charge_seconds", 0.0)),
        bts_discharge_mah=float(entry.get("bts_discharge_mah", 0.0)),
        bts_discharge_mwh=float(entry.get("bts_discharge_mwh", 0.0)),
        bts_discharge_seconds=float(entry.get("bts_discharge_seconds", 0.0)),
    )
