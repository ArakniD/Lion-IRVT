"""Transport abstraction.

Three transports reach the same unit with different capabilities:

===========  =========================  ================================
Transport    Reaches                    Register access
===========  =========================  ================================
BLE          ESP32 proxy GATT           only with firmware proto 4
CAN          C2000 CANA directly        always (mailbox object 9)
HTTP         ESP32 proxy web API        always (/api/registers)
===========  =========================  ================================

The distinction matters because the ESP32's test engine and the BTS's own
mode register are different control surfaces. BLE drives the *test engine*
(start a characterisation, abort it, pause it); a raw ``eChX_Mode`` write
drives the *converter* directly. A deployment with only BLE and a proto-3
firmware can run tests but cannot command a bare charge or discharge, which
is why :attr:`Transport.supports_registers` is checked rather than assumed.
"""

from __future__ import annotations

import abc
from dataclasses import dataclass

from ..protocol.ble import CalStatus, SlotConfig, SlotResult, SlotStatus, UnitStatus


class TransportError(Exception):
    """The transport failed. Distinct from the unit refusing a command."""


class UnitRefusedError(Exception):
    """The unit understood the command and declined it.

    Never retried: a refusal will be refused again. The reason is not carried
    in the transport's error - read the slot status or calibration result.
    """


@dataclass(frozen=True, slots=True)
class DeviceSnapshot:
    """Everything one poll cycle produced."""

    unit: UnitStatus
    slots: dict[int, SlotStatus]
    cal: CalStatus | None = None


class Transport(abc.ABC):
    """One way of reaching the unit."""

    #: Whether this transport can read and write arbitrary registers. False
    #: for BLE against firmware older than proto 4, which has no register
    #: characteristic at all.
    supports_registers: bool = False

    #: Whether this transport can drive the ESP32 test engine (start, abort,
    #: pause, resume, per-slot cell configuration). False for raw CAN, which
    #: talks to the C2000 and never sees the proxy.
    supports_test_engine: bool = False

    #: Whether the transport delivers unsolicited updates. Polling transports
    #: are driven by the coordinator's interval instead.
    supports_notifications: bool = False

    @abc.abstractmethod
    async def async_connect(self) -> None:
        """Establish the link. Idempotent."""

    @abc.abstractmethod
    async def async_disconnect(self) -> None:
        """Tear the link down. Must not raise."""

    @abc.abstractmethod
    async def async_poll(self) -> DeviceSnapshot:
        """Read a complete snapshot.

        Any successful read also feeds the unit's host watchdog, which pauses
        every running slot if no host command arrives within its timeout.
        """

    async def async_read_register(self, address: int) -> float:
        raise TransportError(
            f"{type(self).__name__} cannot read registers"
        )

    async def async_write_register(self, address: int, value: float) -> None:
        raise TransportError(
            f"{type(self).__name__} cannot write registers"
        )

    # --- test-engine operations, optional ---------------------------------

    async def async_start(self, slot: int) -> None:
        raise TransportError(f"{type(self).__name__} cannot start a test")

    async def async_abort(self, slot: int) -> None:
        raise TransportError(f"{type(self).__name__} cannot abort a test")

    async def async_abort_all(self) -> None:
        raise TransportError(f"{type(self).__name__} cannot abort tests")

    async def async_pause(self, slot: int) -> None:
        raise TransportError(f"{type(self).__name__} cannot pause a slot")

    async def async_resume(self, slot: int) -> None:
        raise TransportError(f"{type(self).__name__} cannot resume a slot")

    async def async_clear_fault(self, slot: int) -> None:
        raise TransportError(f"{type(self).__name__} cannot clear a fault")

    async def async_read_config(self, slot: int) -> SlotConfig:
        raise TransportError(f"{type(self).__name__} cannot read slot config")

    async def async_write_config(self, config: SlotConfig) -> None:
        raise TransportError(f"{type(self).__name__} cannot write slot config")

    async def async_read_result(self, slot: int) -> SlotResult:
        raise TransportError(f"{type(self).__name__} cannot read results")

    async def async_set_serial(self, slot: int, serial: str) -> None:
        raise TransportError(f"{type(self).__name__} cannot set a serial")

    async def async_cal_command(
        self, opcode: int, slot: int = 0, arg: float = 0.0
    ) -> CalStatus:
        raise TransportError(f"{type(self).__name__} cannot drive calibration")
