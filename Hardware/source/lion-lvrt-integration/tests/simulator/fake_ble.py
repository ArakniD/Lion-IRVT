"""A bleak-compatible fake client backed by :class:`SimulatedUnit`.

Implements the subset of the bleak API the transport uses - ``read_gatt_char``,
``write_gatt_char``, ``start_notify``, ``disconnect``, ``services``,
``mtu_size`` - with the device's own semantics, including the ones that make
clients fail:

* Writes are rejected unless the length matches exactly.
* The slot-select cursor is global and shared.
* A refusal surfaces as a bare ATT 0x0E with no diagnosis.
* ``mtu_size`` is configurable, so a test can reproduce the truncation that
  happens when a client subscribes before negotiating the MTU.
"""

from __future__ import annotations

from dataclasses import dataclass, field
from typing import Any, Callable

from custom_components.lion_lvrt.protocol import ble as proto

from .unit import (
    ATT_INVALID_ATTR_VALUE_LEN,
    ATT_REQ_NOT_SUPPORTED,
    ATT_UNLIKELY,
    AttError,
    SimulatedUnit,
)


class BleakErrorSim(Exception):
    """Stands in for ``bleak.BleakError``, carrying the ATT code."""

    def __init__(self, code: int) -> None:
        super().__init__(f"ATT error 0x{code:02X}")
        self.code = code


@dataclass
class FakeCharacteristic:
    uuid: str


@dataclass
class FakeService:
    uuid: str
    characteristics: list[FakeCharacteristic] = field(default_factory=list)


class FakeBleClient:
    """Enough of ``BleakClient`` for the BLE transport."""

    def __init__(
        self,
        unit: SimulatedUnit,
        *,
        mtu_size: int = 247,
        include_cal: bool = True,
        include_registers: bool | None = None,
    ) -> None:
        self.unit = unit
        self.mtu_size = mtu_size
        self.is_connected = True
        self.writes: list[tuple[str, bytes]] = []
        self._notify_cbs: dict[str, Callable[[Any, bytearray], None]] = {}

        if include_registers is None:
            include_registers = unit.has_registers_char

        uuids = [
            proto.UNIT_STATUS_UUID,
            proto.COMMAND_UUID,
            proto.SLOT_SELECT_UUID,
            proto.SLOT_CONFIG_UUID,
            proto.SLOT_RESULT_UUID,
            proto.SLOT_SERIAL_UUID,
            proto.CATALOG_INDEX_UUID,
            proto.CATALOG_ENTRY_UUID,
            proto.SLOT_STATUS_UUID,
        ]
        if include_cal:
            uuids += [proto.CAL_CONTROL_UUID, proto.CAL_STATUS_UUID]
        if include_registers:
            uuids.append(proto.REGISTER_UUID)

        self.services = [
            FakeService(
                uuid=proto.SERVICE_UUID,
                characteristics=[FakeCharacteristic(uuid=u) for u in uuids],
            )
        ]
        self._known = {u.lower() for u in uuids}

    async def disconnect(self) -> None:
        self.is_connected = False

    def _truncate(self, data: bytes) -> bytes:
        """Apply the ATT MTU ceiling, as the link does.

        A notification is never segmented, so at a small MTU the tail is
        simply lost - which is why this returns a short record rather than
        raising.
        """
        return data[: max(0, self.mtu_size - 3)]

    async def read_gatt_char(self, uuid: str, **_: Any) -> bytearray:
        key = uuid.lower()
        if key not in self._known:
            raise BleakErrorSim(ATT_UNLIKELY)
        unit = self.unit
        # Any host access feeds the watchdog, reads included.
        unit.feed_watchdog()

        if key == proto.UNIT_STATUS_UUID.lower():
            data = unit.unit_status_bytes()
        elif key == proto.SLOT_STATUS_UUID.lower():
            data = unit.slot_status_bytes(unit.selected_slot)
        elif key == proto.SLOT_SELECT_UUID.lower():
            data = bytes([unit.selected_slot])
        elif key == proto.SLOT_CONFIG_UUID.lower():
            data = unit.slot_config_bytes(unit.selected_slot)
        elif key == proto.SLOT_RESULT_UUID.lower():
            data = unit.slot_result_bytes(unit.selected_slot)
        elif key == proto.CATALOG_INDEX_UUID.lower():
            data = bytes([unit.catalog_index])
        elif key == proto.CATALOG_ENTRY_UUID.lower():
            data = unit.catalog_entry_bytes(unit.catalog_index)
        elif key == proto.CAL_STATUS_UUID.lower():
            data = unit.cal_status_bytes()
        elif key == proto.REGISTER_UUID.lower():
            data = getattr(self, "_register_reply", b"\0" * proto.REGISTER_CMD_LEN)
        else:
            raise BleakErrorSim(ATT_UNLIKELY)

        # A read is not truncated - the stack uses Read Blob - so only
        # notifications suffer the MTU ceiling.
        return bytearray(data)

    async def write_gatt_char(
        self, uuid: str, data: bytes, response: bool = True, **_: Any
    ) -> None:
        key = uuid.lower()
        if key not in self._known:
            raise BleakErrorSim(ATT_UNLIKELY)
        self.writes.append((key, bytes(data)))
        unit = self.unit
        unit.feed_watchdog()

        try:
            if key == proto.SLOT_SELECT_UUID.lower():
                self._exact(data, 1)
                if data[0] >= unit.slot_count:
                    raise AttError(ATT_INVALID_ATTR_VALUE_LEN)
                unit.selected_slot = data[0]

            elif key == proto.CATALOG_INDEX_UUID.lower():
                self._exact(data, 1)
                # Deliberately NOT range-checked, matching the firmware.
                unit.catalog_index = data[0]

            elif key == proto.COMMAND_UUID.lower():
                self._exact(data, proto.COMMAND_LEN)
                opcode, slot, _ = __import__("struct").unpack(
                    proto.COMMAND_FMT, data
                )
                unit.engine_command(opcode, slot)

            elif key == proto.SLOT_CONFIG_UUID.lower():
                self._exact(data, proto.SLOT_CONFIG_LEN)
                cfg = proto.SlotConfig.decode(bytes(data))
                if cfg.slot >= unit.slot_count or int(cfg.chemistry) >= 5:
                    raise AttError(ATT_INVALID_ATTR_VALUE_LEN)
                target = unit.slots[cfg.slot]
                if target.running:
                    raise AttError(ATT_UNLIKELY)
                target.config = cfg
                target.configured = True

            elif key == proto.SLOT_SERIAL_UUID.lower():
                if not 1 <= len(data) < 32:
                    raise AttError(ATT_INVALID_ATTR_VALUE_LEN)
                slot = unit.slots[unit.selected_slot]
                if slot.config is not None:
                    slot.config = proto.SlotConfig(
                        **{
                            **slot.config.__dict__,
                            "serial": bytes(data).decode("utf-8", "replace"),
                        }
                    )

            elif key == proto.CAL_CONTROL_UUID.lower():
                self._exact(data, proto.CAL_CMD_LEN)
                opcode, slot, _r, arg = __import__("struct").unpack(
                    proto.CAL_CMD_FMT, data
                )
                if opcode == 0:
                    # NONE has no case in the handler - rejected, not a no-op.
                    raise AttError(ATT_REQ_NOT_SUPPORTED)
                if opcode == 1 and slot >= unit.slot_count:
                    raise AttError(ATT_INVALID_ATTR_VALUE_LEN)
                result = unit.cal_command(opcode, slot, arg)
                if int(result) != 0:
                    # Any non-zero result is a bare 0x0E with no diagnosis.
                    raise AttError(ATT_UNLIKELY)

            elif key == proto.REGISTER_UUID.lower():
                self._exact(data, proto.REGISTER_CMD_LEN)
                import struct as _struct

                addr, write, _count, value = _struct.unpack(
                    proto.REGISTER_CMD_FMT, data
                )
                if write:
                    unit.write_register(addr, value)
                    self._register_reply = bytes(data)
                else:
                    got = unit.read_register(addr)
                    self._register_reply = _struct.pack(
                        proto.REGISTER_CMD_FMT, addr, 0, 1, got
                    )
            else:
                raise AttError(ATT_UNLIKELY)

        except AttError as err:
            raise BleakErrorSim(err.code) from None
        except ValueError as err:
            raise BleakErrorSim(ATT_INVALID_ATTR_VALUE_LEN) from err

    @staticmethod
    def _exact(data: bytes, length: int) -> None:
        """Every write is length-checked for an exact match."""
        if len(data) != length:
            raise AttError(ATT_INVALID_ATTR_VALUE_LEN)

    async def start_notify(
        self, uuid: str, callback: Callable[[Any, bytearray], None], **_: Any
    ) -> None:
        if uuid.lower() not in self._known:
            raise BleakErrorSim(ATT_UNLIKELY)
        self._notify_cbs[uuid.lower()] = callback

    async def stop_notify(self, uuid: str) -> None:
        self._notify_cbs.pop(uuid.lower(), None)

    # --- test hooks -------------------------------------------------------

    def push_slot_notification(self, slot: int) -> None:
        """Emit a slot-status notification, MTU truncation included."""
        cb = self._notify_cbs.get(proto.SLOT_STATUS_UUID.lower())
        if cb is None:
            return
        cb(
            FakeCharacteristic(uuid=proto.SLOT_STATUS_UUID),
            bytearray(self._truncate(self.unit.slot_status_bytes(slot))),
        )

    def push_unit_notification(self) -> None:
        cb = self._notify_cbs.get(proto.UNIT_STATUS_UUID.lower())
        if cb is None:
            return
        cb(
            FakeCharacteristic(uuid=proto.UNIT_STATUS_UUID),
            bytearray(self._truncate(self.unit.unit_status_bytes())),
        )

    def push_cal_notification(self) -> None:
        cb = self._notify_cbs.get(proto.CAL_STATUS_UUID.lower())
        if cb is None:
            return
        cb(
            FakeCharacteristic(uuid=proto.CAL_STATUS_UUID),
            bytearray(self._truncate(self.unit.cal_status_bytes())),
        )

    @property
    def subscribed(self) -> set[str]:
        return set(self._notify_cbs)


class FakeCanBus:
    """Enough of ``can.Bus`` for the CAN transport."""

    def __init__(self, unit: SimulatedUnit) -> None:
        self.unit = unit
        self._replies: list[Any] = []
        self.sent: list[tuple[int, bytes]] = []
        self.is_shutdown = False

    def send(self, msg: Any) -> None:
        self.sent.append((msg.arbitration_id, bytes(msg.data)))
        reply = self.unit.can_handle(msg.arbitration_id, bytes(msg.data))
        if reply is not None:
            self._replies.append(_FakeCanMessage(reply[0], reply[1]))

    def recv(self, timeout: float | None = None) -> Any | None:
        if self._replies:
            return self._replies.pop(0)
        return None

    def shutdown(self) -> None:
        self.is_shutdown = True


@dataclass
class _FakeCanMessage:
    arbitration_id: int
    data: bytes
    is_extended_id: bool = True
