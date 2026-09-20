"""BLE transport, over the ESP32 proxy's GATT service.

Works with a directly reachable adapter and, unchanged, through a Home
Assistant Bluetooth proxy (ESPHome or Shelly): the proxy presents a normal
``BLEDevice`` and ``bleak_retry_connector`` routes the connection to whichever
adapter has the best signal.

THREE THINGS THIS LAYER MUST GET RIGHT
--------------------------------------
1. **Slot-select is a global cursor.** Four characteristics take their slot
   from a single static on the device, not from the payload, and it is shared
   across everything the client is doing. Every read that depends on it is
   therefore serialised under :attr:`_slot_lock`, with the write and the read
   inside the same critical section.

2. **The MTU must be negotiated before subscribing.** Notifications are never
   segmented, so at the default 23-byte ATT MTU a 68-byte slot-status record
   is silently truncated to 20 bytes rather than failing.

3. **A GATT write succeeding says nothing about acceptance.** The ATT layer
   returns a bare 0x0E for "the unit refused" and for "the stack failed"
   alike. Commands are verified by reading state back.
"""

from __future__ import annotations

import asyncio
import logging
from typing import Any, Callable

from ..const import BleCommand, CalCommand, SLOT_COUNT
from ..protocol import ble as proto
from ..protocol.ble import (
    CalStatus,
    ProtocolError,
    SlotConfig,
    SlotResult,
    SlotStatus,
    UnitStatus,
)
from .base import DeviceSnapshot, Transport, TransportError, UnitRefusedError

_LOGGER = logging.getLogger(__name__)

#: Largest record in the service is 116 B; 247 is the firmware's preferred MTU.
MIN_USABLE_MTU = 128

#: The device tracks exactly one connection handle, so overlapping operations
#: from one client are the only concurrency hazard - hence a single lock.
_COMMAND_SETTLE_S = 0.3


class BleTransport(Transport):
    """Talks to the proxy over GATT."""

    supports_test_engine = True
    supports_notifications = True

    def __init__(
        self,
        client_factory: Callable[[], Any],
        *,
        slot_count: int = SLOT_COUNT,
    ) -> None:
        """``client_factory`` returns a connected bleak-compatible client.

        Injected rather than constructed here so the test suite can substitute
        a simulator without a Bluetooth stack, and so Home Assistant can hand
        in a ``bleak_retry_connector``-managed client that knows about proxies.
        """
        self._client_factory = client_factory
        self._client: Any | None = None
        self._slot_count = slot_count
        self._slot_lock = asyncio.Lock()
        self._chars: set[str] = set()
        self._notify_cb: Callable[[DeviceSnapshot], None] | None = None
        self._last_unit: UnitStatus | None = None
        self._slots: dict[int, SlotStatus] = {}
        self._cal: CalStatus | None = None

    # --- lifecycle --------------------------------------------------------

    async def async_connect(self) -> None:
        if self._client is not None:
            return
        client = self._client_factory()
        if asyncio.iscoroutine(client):
            client = await client
        self._client = client

        await self._discover_characteristics()

        mtu = getattr(client, "mtu_size", 0) or 0
        if mtu and mtu < MIN_USABLE_MTU:
            # Not fatal - reads still work via Read Blob - but notifications
            # would be truncated, so say so rather than decode rubbish.
            _LOGGER.warning(
                "ATT MTU is %d; notifications carrying records larger than "
                "%d bytes will be truncated. Expected 247",
                mtu,
                mtu - 3,
            )

    async def _discover_characteristics(self) -> None:
        """Record which characteristics exist.

        Feature detection, not version comparison: a firmware may backport a
        characteristic without bumping ``BLE_PROTO_VERSION``, and the version
        byte only tells us what the *device* thinks it implements.
        """
        client = self._client
        assert client is not None
        found: set[str] = set()
        services = getattr(client, "services", None)
        if services is not None:
            for service in services:
                if service.uuid.lower() != proto.SERVICE_UUID.lower():
                    continue
                for char in service.characteristics:
                    found.add(char.uuid.lower())
        self._chars = found
        self.supports_registers = proto.REGISTER_UUID.lower() in found
        if not self.supports_registers:
            _LOGGER.info(
                "This firmware has no register characteristic (%s), so direct "
                "charge/discharge mode control is unavailable over BLE. "
                "Configure the CAN or HTTP transport for it, or flash a "
                "firmware with BLE_PROTO_VERSION 4",
                proto.REGISTER_UUID,
            )

    def has_characteristic(self, uuid: str) -> bool:
        return uuid.lower() in self._chars

    async def async_disconnect(self) -> None:
        client, self._client = self._client, None
        if client is None:
            return
        try:
            await client.disconnect()
        except Exception as err:  # noqa: BLE001 - teardown must not raise
            _LOGGER.debug("Ignoring error during disconnect: %s", err)

    # --- reads ------------------------------------------------------------

    async def _read(self, uuid: str) -> bytes:
        client = self._client
        if client is None:
            raise TransportError("not connected")
        try:
            return bytes(await client.read_gatt_char(uuid))
        except Exception as err:  # noqa: BLE001
            raise TransportError(f"read of {uuid} failed: {err}") from err

    async def _write(self, uuid: str, data: bytes) -> None:
        client = self._client
        if client is None:
            raise TransportError("not connected")
        try:
            # response=True throughout: no characteristic here offers
            # write-without-response, and a read could otherwise overtake the
            # write that selected the slot.
            await client.write_gatt_char(uuid, data, response=True)
        except Exception as err:  # noqa: BLE001
            raise TransportError(f"write to {uuid} failed: {err}") from err

    async def _select_and_read(self, slot: int, uuid: str) -> bytes:
        """Point the device's cursor at ``slot`` and read ``uuid``.

        Held under one lock so a concurrent operation cannot move the cursor
        between the write and the read.
        """
        if not 0 <= slot < self._slot_count:
            raise ValueError(f"slot {slot} out of range")
        async with self._slot_lock:
            await self._write(proto.SLOT_SELECT_UUID, bytes([slot]))
            return await self._read(uuid)

    async def async_poll(self) -> DeviceSnapshot:
        unit = UnitStatus.decode(await self._read(proto.UNIT_STATUS_UUID))
        self._last_unit = unit

        slots: dict[int, SlotStatus] = {}
        for slot in range(min(unit.slot_count or self._slot_count, self._slot_count)):
            raw = await self._select_and_read(slot, proto.SLOT_STATUS_UUID)
            try:
                slots[slot] = SlotStatus.decode(raw)
            except ProtocolError as err:
                _LOGGER.warning("Slot %d status undecodable: %s", slot, err)
        self._slots = slots

        cal = None
        if self.has_characteristic(proto.CAL_STATUS_UUID):
            try:
                cal = CalStatus.decode(await self._read(proto.CAL_STATUS_UUID))
            except (ProtocolError, TransportError) as err:
                _LOGGER.debug("Calibration status unavailable: %s", err)
        self._cal = cal

        return DeviceSnapshot(unit=unit, slots=slots, cal=cal)

    async def async_read_config(self, slot: int) -> SlotConfig:
        return SlotConfig.decode(
            await self._select_and_read(slot, proto.SLOT_CONFIG_UUID)
        )

    async def async_read_result(self, slot: int) -> SlotResult:
        return SlotResult.decode(
            await self._select_and_read(slot, proto.SLOT_RESULT_UUID)
        )

    # --- commands ---------------------------------------------------------

    async def _command(self, opcode: BleCommand, slot: int = 0) -> None:
        try:
            await self._write(
                proto.COMMAND_UUID, proto.encode_command(int(opcode), slot)
            )
        except TransportError as err:
            # 0x0E means the unit refused OR the stack failed, with no way to
            # tell them apart from the ATT response. Surface it as a refusal,
            # which is the interpretation that does not cause a retry.
            raise UnitRefusedError(
                f"{opcode.name} on slot {slot} was refused; read the slot's "
                f"state and fault to find out why ({err})"
            ) from err

    async def async_start(self, slot: int) -> None:
        await self._command(BleCommand.START, slot)

    async def async_abort(self, slot: int) -> None:
        await self._command(BleCommand.ABORT, slot)

    async def async_abort_all(self) -> None:
        await self._command(BleCommand.ABORT_ALL, 0)

    async def async_clear_fault(self, slot: int) -> None:
        await self._command(BleCommand.CLEAR_FAULT, slot)

    async def async_pause(self, slot: int) -> None:
        await self._command(BleCommand.PAUSE, slot)

    async def async_resume(self, slot: int) -> None:
        # Deliberately an operator action and never automatic: a slot that
        # comes back paused after a watchdog trip or an F-RAM restore may hold
        # a cell that was swapped while the unit was off.
        await self._command(BleCommand.RESUME, slot)

    async def async_write_config(self, config: SlotConfig) -> None:
        # The payload's own slot field is what the device honours on a write;
        # slot-select steers only the read. Encoding validates both.
        await self._write(proto.SLOT_CONFIG_UUID, config.encode())

    async def async_set_serial(self, slot: int, serial: str) -> None:
        raw = serial.encode("utf-8")
        if not 1 <= len(raw) <= 31:
            raise ValueError(
                f"serial must be 1-31 UTF-8 bytes, got {len(raw)}"
            )
        async with self._slot_lock:
            await self._write(proto.SLOT_SELECT_UUID, bytes([slot]))
            await self._write(proto.SLOT_SERIAL_UUID, raw)

    async def async_cal_command(
        self, opcode: int, slot: int = 0, arg: float = 0.0
    ) -> CalStatus:
        """Issue a calibration command and read the outcome back.

        The read-back is mandatory, not a convenience: the ATT response cannot
        distinguish a refusal from a transport failure, and the specific
        ``eCalResult`` code exists only in characteristic 000c.
        """
        if not self.has_characteristic(proto.CAL_CONTROL_UUID):
            raise TransportError(
                "this firmware predates BLE_PROTO_VERSION 2 and has no "
                "calibration interface"
            )
        payload = proto.encode_cal_command(int(opcode), slot, arg)
        write_error: Exception | None = None
        try:
            await self._write(proto.CAL_CONTROL_UUID, payload)
        except TransportError as err:
            # Do NOT give up here. ATT 0x0E carries no diagnosis, and the
            # firmware returns it for every non-zero eCalResult - so the
            # command may well have been understood and declined for a
            # specific, reportable reason. That reason exists only in
            # characteristic 000c, so fall through and read it.
            write_error = err

        # bts_link refreshes the calibration window on the next poll, and the
        # poll interval is 250 ms, so a read any sooner returns stale values.
        await asyncio.sleep(_COMMAND_SETTLE_S)
        try:
            status = CalStatus.decode(await self._read(proto.CAL_STATUS_UUID))
        except (ProtocolError, TransportError) as err:
            # Only now is the write error final: nothing can say why.
            raise UnitRefusedError(
                f"calibration opcode {CalCommand(opcode).name} failed and the "
                f"status could not be read back ({write_error or err})"
            ) from (write_error or err)

        self._cal = status
        return status

    # --- registers (proto 4 only) ----------------------------------------

    async def async_read_register(self, address: int) -> float:
        if not self.supports_registers:
            raise TransportError(
                "this firmware has no register characteristic; use the CAN or "
                "HTTP transport for register access"
            )
        async with self._slot_lock:
            await self._write(
                proto.REGISTER_UUID, proto.encode_register_cmd(address)
            )
            _addr, value = proto.decode_register_value(
                await self._read(proto.REGISTER_UUID)
            )
        return value

    async def async_write_register(self, address: int, value: float) -> None:
        if not self.supports_registers:
            raise TransportError(
                "this firmware has no register characteristic; use the CAN or "
                "HTTP transport for register access"
            )
        await self._write(
            proto.REGISTER_UUID,
            proto.encode_register_cmd(address, value, write=True),
        )

    # --- notifications ----------------------------------------------------

    async def async_start_notify(
        self, callback: Callable[[DeviceSnapshot], None]
    ) -> None:
        """Subscribe to the three notifying characteristics.

        Treat the feed as live data, not as a log: delivery is best-effort and
        a notification is silently dropped if the device's mbuf pool is
        exhausted. The coordinator still polls underneath.
        """
        client = self._client
        if client is None:
            raise TransportError("not connected")
        self._notify_cb = callback

        for uuid in proto.NOTIFY_UUIDS:
            if not self.has_characteristic(uuid):
                continue
            try:
                await client.start_notify(uuid, self._on_notify)
            except Exception as err:  # noqa: BLE001
                _LOGGER.warning("Could not subscribe to %s: %s", uuid, err)

    def _on_notify(self, sender: Any, data: bytearray) -> None:
        uuid = getattr(sender, "uuid", str(sender)).lower()
        raw = bytes(data)
        try:
            if uuid == proto.UNIT_STATUS_UUID.lower():
                self._last_unit = UnitStatus.decode(raw)
            elif uuid == proto.SLOT_STATUS_UUID.lower():
                # A notification may be for any slot regardless of the cursor,
                # so decode the record's own slot field.
                status = SlotStatus.decode(raw)
                self._slots[status.slot] = status
            elif uuid == proto.CAL_STATUS_UUID.lower():
                self._cal = CalStatus.decode(raw)
            else:
                return
        except ProtocolError as err:
            _LOGGER.debug("Dropping undecodable notification from %s: %s", uuid, err)
            return

        if self._notify_cb and self._last_unit is not None:
            self._notify_cb(
                DeviceSnapshot(
                    unit=self._last_unit, slots=dict(self._slots), cal=self._cal
                )
            )
