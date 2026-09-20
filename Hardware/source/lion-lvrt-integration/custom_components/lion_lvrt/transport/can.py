"""CAN transport, over SocketCAN on the Home Assistant host.

Talks to the C2000 directly rather than through the ESP32 proxy, which has
two consequences that shape this module:

* **Register access always works** - the mailbox (object 9) reads and writes
  any register, so this transport can command a bare charge or discharge
  regardless of the proxy's BLE protocol version.
* **The test engine is unreachable.** Start/abort/pause of a *characterisation
  run* live on the ESP32; over CAN there is only the converter's own mode
  register. :attr:`supports_test_engine` is False accordingly.

Home Assistant has no CAN integration, so this uses ``python-can`` against a
Linux SocketCAN interface (``can0``). The dependency is optional and imported
lazily: a BLE-only install must not require it.

THE TELEMETRY FRAMES ARE HALF-USABLE
------------------------------------
Periodic telemetry carries a complete voltage but only the low word of the
current float, so this transport reads runtime data through the mailbox
instead. Telemetry frames are consumed only as a liveness signal.
"""

from __future__ import annotations

import asyncio
import logging
from typing import Any

from ..protocol import can as proto
from ..protocol import registers as regs
from ..protocol.ble import CalStatus, SlotStatus, UnitStatus
from ..const import CalResult, SLOT_COUNT, UnitState
from .base import DeviceSnapshot, Transport, TransportError

_LOGGER = logging.getLogger(__name__)

#: How long to wait for a mailbox reply. The unit answers from its CAN ISR,
#: so this is bus latency only; a timeout means the unit is not on the bus.
MAILBOX_TIMEOUT_S = 1.0


class CanTransport(Transport):
    """SocketCAN register access to the C2000."""

    supports_registers = True
    supports_test_engine = False
    supports_notifications = False

    def __init__(
        self,
        interface: str = "can0",
        *,
        bitrate: int = proto.CAN_BITRATE,
        slot_count: int = SLOT_COUNT,
        bus_factory: Any | None = None,
    ) -> None:
        self._interface = interface
        self._bitrate = bitrate
        self._slot_count = slot_count
        self._bus_factory = bus_factory
        self._bus: Any | None = None
        self._lock = asyncio.Lock()

    async def async_connect(self) -> None:
        if self._bus is not None:
            return
        if self._bus_factory is not None:
            bus = self._bus_factory()
            self._bus = await bus if asyncio.iscoroutine(bus) else bus
            return
        try:
            import can as python_can  # noqa: PLC0415 - optional dependency
        except ImportError as err:
            raise TransportError(
                "the CAN transport needs the 'python-can' package; install it "
                "or configure a different transport"
            ) from err
        try:
            self._bus = await asyncio.get_running_loop().run_in_executor(
                None,
                lambda: python_can.Bus(
                    channel=self._interface,
                    interface="socketcan",
                    bitrate=self._bitrate,
                ),
            )
        except Exception as err:  # noqa: BLE001
            raise TransportError(
                f"could not open CAN interface {self._interface}: {err}"
            ) from err

    async def async_disconnect(self) -> None:
        bus, self._bus = self._bus, None
        if bus is None:
            return
        try:
            await asyncio.get_running_loop().run_in_executor(None, bus.shutdown)
        except Exception as err:  # noqa: BLE001
            _LOGGER.debug("Ignoring CAN shutdown error: %s", err)

    # --- mailbox ----------------------------------------------------------

    async def _mailbox(self, can_id: int, data: bytes, *, expect: bool) -> bytes | None:
        bus = self._bus
        if bus is None:
            raise TransportError("CAN bus not open")

        import can as python_can  # noqa: PLC0415

        msg = python_can.Message(
            arbitration_id=can_id, data=data, is_extended_id=True
        )
        loop = asyncio.get_running_loop()

        async with self._lock:
            try:
                await loop.run_in_executor(None, lambda: bus.send(msg))
            except Exception as err:  # noqa: BLE001
                raise TransportError(f"CAN send failed: {err}") from err
            if not expect:
                return None

            deadline = loop.time() + MAILBOX_TIMEOUT_S
            while loop.time() < deadline:
                remaining = max(0.0, deadline - loop.time())
                reply = await loop.run_in_executor(
                    None, lambda t=remaining: bus.recv(timeout=t)
                )
                if reply is None:
                    break
                if reply.arbitration_id == proto.MAILBOX_ID and len(reply.data) >= 8:
                    return bytes(reply.data)
            raise TransportError(
                f"no mailbox reply within {MAILBOX_TIMEOUT_S}s - is the unit "
                f"on {self._interface} at {self._bitrate} bit/s?"
            )

    async def async_read_register(self, address: int) -> float:
        can_id, data = proto.encode_register_read(address)
        reply = await self._mailbox(can_id, data, expect=True)
        assert reply is not None
        got_addr, value = proto.decode_register_reply(reply)
        if got_addr != address:
            raise TransportError(
                f"mailbox replied for register {got_addr}, expected {address}"
            )
        return value

    async def async_write_register(self, address: int, value: float) -> None:
        can_id, data = proto.encode_register_write(address, value)
        await self._mailbox(can_id, data, expect=False)

    async def async_read_block(self, address: int, count: int) -> list[float]:
        """Read consecutive registers.

        The mailbox has no burst mode - unlike I2C, which auto-increments - so
        this is one round trip per register. Callers should prefer reading
        only the registers they need.
        """
        return [
            await self.async_read_register(address + i * regs.REGISTER_SIZE)
            for i in range(count)
        ]

    # --- snapshot ---------------------------------------------------------

    async def async_poll(self) -> DeviceSnapshot:
        """Assemble a snapshot from register reads.

        The unit-status record this produces is synthesised: there is no ESP32
        on this path, so proxy-owned fields (uptime, wifi, the ESP32's own
        integration) are reported as absent rather than invented.
        """
        unit_state_raw = await self.async_read_register(regs.REG_UNIT_STATE)
        input_v = await self.async_read_register(regs.REG_INPUT_VOLTAGE)
        trip = await self.async_read_register(regs.REG_TRIP_STATUS)
        watchdog = await self.async_read_register(regs.REG_HOST_WATCHDOG_S)

        try:
            state = UnitState(int(unit_state_raw))
        except ValueError:
            state = UnitState.INPUT_OK

        unit = UnitStatus(
            version=0,
            slot_count=self._slot_count,
            online=True,
            unit_state=state,
            trip_status=int(trip),
            input_voltage_v=input_v,
            uptime_s=0,
            stats_live=True,
            wifi_connected=False,
            watchdog_timeout_s=watchdog,
        )

        slots: dict[int, SlotStatus] = {}
        for ch in range(self._slot_count):
            block = regs.RuntimeBlock.from_floats(
                await self.async_read_block(
                    regs.rt_addr(ch, regs.RT_STATUS), regs.RT_REG_COUNT
                )
            )
            slots[ch] = _slot_status_from_runtime(ch, block)

        return DeviceSnapshot(unit=unit, slots=slots, cal=await self._read_cal())

    async def _read_cal(self) -> CalStatus | None:
        try:
            slot = await self.async_read_register(regs.REG_CAL_SLOT)
            status = await self.async_read_register(regs.REG_CAL_STATUS)
            result = await self.async_read_register(regs.REG_CAL_RESULT)
            telemetry = await self.async_read_block(regs.CAL_TELEMETRY_BASE, 9)
        except TransportError as err:
            _LOGGER.debug("Calibration registers unreadable: %s", err)
            return None

        try:
            result_code = CalResult(int(result))
        except ValueError:
            result_code = CalResult.OK
        bits = int(status)
        return CalStatus(
            slot=int(slot) if 0 <= int(slot) < self._slot_count else CalStatus.NO_SLOT,
            active=bool(bits & 0x001),
            v_tick=False,
            i_tick=False,
            status_bits=bits,
            result=result_code,
            ads_v_pu=telemetry[0],
            ads_i_pu=telemetry[1],
            ads_v_v=telemetry[2],
            ads_i_a=telemetry[3],
            f28_v_pu=telemetry[4],
            f28_i_pu=telemetry[5],
            f28_v_v=telemetry[6],
            f28_i_a=telemetry[7],
            temp_c=telemetry[8],
        )


def _slot_status_from_runtime(
    channel: int, block: regs.RuntimeBlock
) -> SlotStatus:
    """Build a slot record from the C2000's runtime block alone.

    Fields the ESP32 owns - the engine's sequence state, its locally
    integrated mAh/mWh, progress against a configured capacity - do not exist
    on this path. They are reported as zero/idle rather than guessed at, and
    the BTS's own accumulators are carried in the ``bts_*`` fields where they
    belong.
    """
    from ..const import SlotFault, SlotState, StatusBit  # noqa: PLC0415

    bits = block.status_bits
    if bits & StatusBit.PAUSED:
        state = SlotState.BTS_PAUSED
    elif bits & StatusBit.CHARGING and bits & StatusBit.RUNNING:
        state = SlotState.CHARGE
    elif bits & StatusBit.DISCHARGING and bits & StatusBit.RUNNING:
        state = SlotState.DISCHARGE
    elif bits & StatusBit.FINISHED:
        state = SlotState.COMPLETE
    else:
        state = SlotState.IDLE

    return SlotStatus(
        slot=channel,
        state=state,
        fault=SlotFault.NONE,
        configured=False,
        # The 16-bit ADS131M08 path, which is the better measurement and the
        # one the accumulators integrate.
        voltage_v=block.sense_voltage_v,
        current_a=block.sense_current_a,
        temp_c=block.cell_temp_c,
        live_mah=0.0,
        live_mwh=0.0,
        progress=0.0,
        elapsed_s=int(block.charge_seconds + block.discharge_seconds),
        state_elapsed_s=0,
        status_bits=bits,
        bts_paused=bool(bits & StatusBit.PAUSED),
        bts_wd_tripped=bool(bits & StatusBit.WD_TRIPPED),
        bts_restored=bool(bits & StatusBit.RESTORED),
        bts_ended=bool(bits & StatusBit.FINISHED),
        bts_charge_mah=block.charge_mah,
        bts_charge_mwh=block.charge_mwh,
        bts_charge_seconds=block.charge_seconds,
        bts_discharge_mah=block.discharge_mah,
        bts_discharge_mwh=block.discharge_mwh,
        bts_discharge_seconds=block.discharge_seconds,
    )
