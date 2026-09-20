"""The device controller: one unit, one or two transports, one safety policy.

Sits between Home Assistant's entities and the wire. Its job is to decide
*which* transport serves a given operation and to refuse the ones that cannot
be performed safely, in one place rather than in every entity.

TWO CONTROL SURFACES, NOT ONE
-----------------------------
The system has two ways to make a slot move current, and conflating them is
the easiest mistake to make here:

* **The test engine**, on the ESP32. ``start`` runs a whole characterisation -
  check rest, charge, rest, discharge, rest, optional recharge - and decides
  the direction itself. Reached over BLE or HTTP.
* **The mode register**, on the C2000. Writing ``eChX_Mode`` commands the
  converter directly: run/stop and charge/discharge, nothing more. Reached
  over any transport with register access.

"Charge this slot" is the second. "Test this cell" is the first. This module
exposes both and never silently substitutes one for the other.
"""

from __future__ import annotations

import asyncio
import logging

from .const import (
    CAL_FIXED_CURRENT_MAX_PU,
    CalCommand,
    CalResult,
    SLOT_COUNT,
    SlotMode,
    StatusBit,
)
from .protocol import registers as regs
from .protocol.ble import CalStatus, SlotConfig, SlotResult, SlotStatus
from .transport.base import (
    DeviceSnapshot,
    Transport,
    TransportError,
    UnitRefusedError,
)

_LOGGER = logging.getLogger(__name__)


class LionDevice:
    """A single battery tester."""

    def __init__(
        self,
        primary: Transport,
        *,
        register_transport: Transport | None = None,
        slot_count: int = SLOT_COUNT,
    ) -> None:
        """``register_transport`` is an optional second link used only for
        register access, so a BLE deployment can gain direct mode control by
        adding CAN without giving up the proxy's test engine.
        """
        self._primary = primary
        self._registers = register_transport
        self._slot_count = slot_count
        self._snapshot: DeviceSnapshot | None = None
        self._lock = asyncio.Lock()

    # --- capability -------------------------------------------------------

    @property
    def slot_count(self) -> int:
        return self._slot_count

    @property
    def transports(self) -> tuple[Transport, ...]:
        return tuple(t for t in (self._primary, self._registers) if t is not None)

    @property
    def _register_link(self) -> Transport | None:
        """Whichever transport can reach the register file, if any."""
        if self._registers is not None and self._registers.supports_registers:
            return self._registers
        if self._primary.supports_registers:
            return self._primary
        return None

    @property
    def supports_direct_mode(self) -> bool:
        """Whether charge/discharge can be commanded directly.

        False on a BLE-only link to firmware without the register
        characteristic. The test engine still works; only the bare
        charge/discharge commands are unavailable.
        """
        return self._register_link is not None

    @property
    def supports_test_engine(self) -> bool:
        return any(t.supports_test_engine for t in self.transports)

    @property
    def snapshot(self) -> DeviceSnapshot | None:
        return self._snapshot

    # --- lifecycle --------------------------------------------------------

    async def async_connect(self) -> None:
        await self._primary.async_connect()
        if self._registers is not None:
            try:
                await self._registers.async_connect()
            except TransportError as err:
                # A missing secondary link degrades capability but must not
                # stop the integration loading - the primary still works.
                _LOGGER.warning(
                    "Register transport unavailable, direct charge/discharge "
                    "control is disabled: %s",
                    err,
                )
                self._registers = None

    async def async_disconnect(self) -> None:
        for transport in self.transports:
            await transport.async_disconnect()

    async def async_poll(self) -> DeviceSnapshot:
        """Refresh the snapshot.

        This also feeds the unit's host watchdog: any host command, including
        a register read, reloads the countdown. If polling stops for longer
        than ``eHostWatchdog_s`` the unit pauses every running slot - which is
        the intended safety behaviour, not a failure to work around.
        """
        async with self._lock:
            snapshot = await self._primary.async_poll()
            self._snapshot = snapshot
            return snapshot

    def _slot(self, slot: int) -> SlotStatus | None:
        if self._snapshot is None:
            return None
        return self._snapshot.slots.get(slot)

    def _check_slot(self, slot: int) -> None:
        if not 0 <= slot < self._slot_count:
            raise ValueError(f"slot {slot} out of range 0-{self._slot_count - 1}")

    # --- test-engine control ---------------------------------------------

    def _engine(self) -> Transport:
        for transport in self.transports:
            if transport.supports_test_engine:
                return transport
        raise TransportError(
            "no configured transport reaches the test engine; a CAN-only "
            "setup can command charge and discharge but cannot run a "
            "characterisation test"
        )

    async def async_start_test(self, slot: int) -> None:
        """Start the full characterisation sequence on ``slot``."""
        self._check_slot(slot)
        self._guard_start(slot)
        await self._engine().async_start(slot)

    async def async_abort(self, slot: int) -> None:
        self._check_slot(slot)
        await self._engine().async_abort(slot)

    async def async_abort_all(self) -> None:
        await self._engine().async_abort_all()

    async def async_clear_fault(self, slot: int) -> None:
        self._check_slot(slot)
        await self._engine().async_clear_fault(slot)

    async def async_pause(self, slot: int) -> None:
        """Pause a running slot, freezing its counters without losing them."""
        self._check_slot(slot)
        for transport in self.transports:
            try:
                await transport.async_pause(slot)
                return
            except TransportError:
                continue
        raise TransportError("no configured transport can pause a slot")

    async def async_resume(self, slot: int, *, force: bool = False) -> None:
        """Resume a paused slot.

        Refuses a slot paused by a watchdog trip or an F-RAM restore unless
        ``force`` is set. That is not caution for its own sake: both mean the
        unit lost contact with the host mid-run, and the cell in the holder
        may not be the cell the counters belong to. The decision is an
        operator's to make explicitly.
        """
        self._check_slot(slot)
        status = self._slot(slot)
        if status is not None and status.needs_operator and not force:
            reason = (
                "the host watchdog fired"
                if status.bts_wd_tripped
                else "the unit reset and restored this run from F-RAM"
            )
            raise UnitRefusedError(
                f"slot {slot} was paused because {reason}; the cell may have "
                "been changed since. Resume with force=true to override"
            )
        for transport in self.transports:
            try:
                await transport.async_resume(slot)
                return
            except TransportError:
                continue
        raise TransportError("no configured transport can resume a slot")

    # --- direct mode control ---------------------------------------------

    # --- raw register access ----------------------------------------------

    async def async_read_register(self, address: int) -> float:
        """Read one register through whichever transport can reach it."""
        link = self._register_link
        if link is None:
            raise TransportError(
                "no register-capable transport is configured. This firmware's "
                "BLE service has no register characteristic - add the CAN or "
                "HTTP transport, or flash a build with BLE_PROTO_VERSION 4"
            )
        return await link.async_read_register(address)

    async def async_write_register(self, address: int, value: float) -> None:
        """Write one register.

        A write to a register the target considers read-only is silently
        dropped rather than rejected, so a caller that needs certainty must
        read back.
        """
        link = self._register_link
        if link is None:
            raise TransportError(
                "no register-capable transport is configured. This firmware's "
                "BLE service has no register characteristic - add the CAN or "
                "HTTP transport, or flash a build with BLE_PROTO_VERSION 4"
            )
        await link.async_write_register(address, value)

    async def async_set_mode(self, slot: int, mode: int) -> None:
        """Write ``eChX_Mode`` directly.

        Low-level and unguarded beyond range checks: callers should normally
        use :meth:`async_charge`, :meth:`async_discharge` or
        :meth:`async_stop`, which apply the unit-state policy.
        """
        self._check_slot(slot)
        await self.async_write_register(
            regs.set_addr(slot, regs.SET_MODE), float(mode)
        )

    async def async_charge(self, slot: int) -> None:
        """Command ``slot`` to charge."""
        self._guard_direction(slot, charging=True)
        await self.async_set_mode(slot, SlotMode.run_charge())

    async def async_discharge(self, slot: int) -> None:
        """Command ``slot`` to discharge."""
        self._guard_direction(slot, charging=False)
        await self.async_set_mode(slot, SlotMode.run_discharge())

    async def async_stop(self, slot: int) -> None:
        """Stop ``slot``. Always permitted."""
        await self.async_set_mode(slot, int(SlotMode.STOP))

    def _guard_start(self, slot: int) -> None:
        """Reject a start the unit would refuse, or that would be unsafe."""
        status = self._slot(slot)
        if status is None:
            return
        bits = status.status_bits
        if bits & StatusBit.SLOT_DISABLED:
            raise UnitRefusedError(
                f"slot {slot} is masked off by the ENABLE strap"
            )
        if bits & StatusBit.SLAVE_MODE:
            leader = _group_leader(slot, self._group_size())
            raise UnitRefusedError(
                f"slot {slot} is a group follower with no control loop of its "
                f"own; command slot {leader} instead"
            )
        if bits & StatusBit.CALIBRATING:
            raise UnitRefusedError(
                f"slot {slot} is in calibration; exit it before starting a run"
            )
        if status.needs_operator:
            raise UnitRefusedError(
                f"slot {slot} is holding a paused run that needs an operator "
                "decision; resume or abort it first"
            )

    def _guard_direction(self, slot: int, *, charging: bool) -> None:
        """Reject a direction the unit's input bus will not permit.

        ``modeCallback()`` refuses such a command outright and leaves the
        channel stopped with no error anywhere, so catching it here is the
        difference between a clear message and a slot that silently does
        nothing.
        """
        self._check_slot(slot)
        self._guard_start(slot)
        if self._snapshot is None:
            return
        state = self._snapshot.unit.unit_state
        if charging and not state.charge_allowed:
            raise UnitRefusedError(
                f"the unit is in {state.name} ({self._snapshot.unit.input_voltage_v:.2f} V "
                "input) and will refuse a charge command"
            )
        if not charging and not state.discharge_allowed:
            raise UnitRefusedError(
                f"the unit is in {state.name} ({self._snapshot.unit.input_voltage_v:.2f} V "
                "input) and will refuse a discharge command"
            )

    def _group_size(self) -> int:
        return 1

    # --- configuration ----------------------------------------------------

    async def async_read_config(self, slot: int) -> SlotConfig:
        self._check_slot(slot)
        return await self._engine().async_read_config(slot)

    async def async_write_config(self, config: SlotConfig) -> None:
        self._check_slot(config.slot)
        await self._engine().async_write_config(config)

    async def async_read_result(self, slot: int) -> SlotResult:
        self._check_slot(slot)
        return await self._engine().async_read_result(slot)

    async def async_set_serial(self, slot: int, serial: str) -> None:
        self._check_slot(slot)
        await self._engine().async_set_serial(slot, serial)

    async def async_set_limits(
        self, slot: int, limits: regs.ChannelLimits
    ) -> None:
        """Write a slot's ten voltage/current/temperature limit registers."""
        self._check_slot(slot)
        for address, value in limits.as_writes(slot):
            await self.async_write_register(address, value)

    async def async_set_host_watchdog(self, seconds: float) -> None:
        """Set the host supervision timeout.

        Writing 0 disables it. That removes the only mechanism that stops the
        converters when the host stops talking mid-run, so it is logged at
        warning level rather than passed through quietly.
        """
        if seconds <= 0:
            _LOGGER.warning(
                "Disabling the host watchdog: running slots will NOT be "
                "paused if this host stops communicating. Bench use only"
            )
        await self.async_write_register(regs.REG_HOST_WATCHDOG_S, float(seconds))

    # --- calibration ------------------------------------------------------

    async def async_cal_command(
        self, opcode: CalCommand, slot: int = 0, arg: float = 0.0
    ) -> CalStatus:
        """Issue a calibration command and return the resulting status.

        Raises :class:`UnitRefusedError` on a non-zero ``eCalResult``: a GATT
        or HTTP success says only that the command was delivered.
        """
        if opcode == CalCommand.NONE:
            raise ValueError("opcode NONE is rejected by the device, not a no-op")
        if opcode == CalCommand.ENTER:
            self._check_slot(slot)
        if opcode == CalCommand.SET_FIXED_CURRENT and not (
            0.0 <= arg <= CAL_FIXED_CURRENT_MAX_PU
        ):
            raise ValueError(
                f"fixed current {arg} pu outside 0.0-{CAL_FIXED_CURRENT_MAX_PU}"
            )
        if opcode == CalCommand.CAPTURE_CURRENT:
            # The firmware takes a magnitude; sending a signed value would be
            # corrected downstream on BLE but not through a raw register write.
            arg = abs(arg)

        status = await self._cal_link().async_cal_command(int(opcode), slot, arg)
        if status.result != CalResult.OK:
            raise UnitRefusedError(
                f"{opcode.name} refused: {status.result.name} "
                f"({_CAL_RESULT_HELP.get(status.result, 'see calibration-design.md')})"
            )
        return status

    def _cal_link(self) -> Transport:
        for transport in self.transports:
            if transport.supports_test_engine or transport.supports_registers:
                return transport
        raise TransportError("no transport can drive calibration")


def _group_leader(channel: int, group_size: int) -> int:
    """The controlling slot of ``channel``'s group.

    Slots are strapped into independent/pairs/quads/octet groups; only the
    leader has a control loop and followers mirror it.
    """
    return channel & ~(group_size - 1) if group_size > 1 else channel


_CAL_RESULT_HELP = {
    CalResult.BUSY: "another slot is already in calibration",
    CalResult.TESTING: "a slot is running a test - stop it first",
    CalResult.SLOT_UNAVAILABLE: "slot is strap-disabled or a group follower",
    CalResult.PU_RANGE: "reading is between 0.2 and 0.8 pu - adjust the "
    "supply so the firmware can tell which point you mean",
    CalResult.INSUFFICIENT: "not enough captures for this computation",
    CalResult.VALIDATE: "a computed gain fell outside its expected window",
    CalResult.FRAM: "the F-RAM write did not complete",
    CalResult.ARG: "argument out of range",
    CalResult.NOT_ACTIVE: "the slot is not in the calibration state",
}
