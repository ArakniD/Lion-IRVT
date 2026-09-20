"""Transport tests, against the firmware-accurate simulator.

These exercise the behaviours that a naive stub would let pass: the shared
slot-select cursor, exact write lengths, opaque refusals, silently dropped
read-only writes, and MTU truncation.
"""

from __future__ import annotations

import asyncio

import pytest

from custom_components.lion_lvrt.const import (
    CalCommand,
    CalResult,
    CellChemistry,
)
from custom_components.lion_lvrt.protocol import ble as proto
from custom_components.lion_lvrt.protocol import can as canproto
from custom_components.lion_lvrt.protocol import registers as regs
from custom_components.lion_lvrt.transport.ble import BleTransport
from custom_components.lion_lvrt.transport.base import (
    TransportError,
    UnitRefusedError,
)
from tests.simulator.fake_ble import FakeBleClient
from tests.simulator.unit import SimulatedUnit

# asyncio_mode=auto in pytest.ini handles the async tests; the CAN codec
# tests below are deliberately synchronous.


async def _connected(unit: SimulatedUnit, **kwargs) -> tuple[BleTransport, FakeBleClient]:
    client = FakeBleClient(unit, **kwargs)
    transport = BleTransport(lambda: client)
    await transport.async_connect()
    return transport, client


# --- discovery and capability ----------------------------------------------


async def test_poll_reads_every_slot() -> None:
    unit = SimulatedUnit()
    transport, _ = await _connected(unit)
    snapshot = await transport.async_poll()

    assert snapshot.unit.version == 3
    assert len(snapshot.slots) == 8
    assert all(snapshot.slots[i].slot == i for i in range(8))


async def test_register_support_is_feature_detected() -> None:
    """Absence of characteristic 000d must disable direct mode, not crash."""
    unit = SimulatedUnit()
    with_regs, _ = await _connected(unit)
    assert with_regs.supports_registers

    without, _ = await _connected(unit, include_registers=False)
    assert not without.supports_registers
    with pytest.raises(TransportError, match="register characteristic"):
        await without.async_read_register(regs.REG_INPUT_VOLTAGE)


async def test_missing_calibration_characteristic_is_reported() -> None:
    """A proto-1 firmware has no calibration interface at all."""
    unit = SimulatedUnit(proto_version=1)
    transport, _ = await _connected(unit, include_cal=False)
    with pytest.raises(TransportError, match="calibration interface"):
        await transport.async_cal_command(CalCommand.ENTER, slot=0)


# --- the slot-select cursor -------------------------------------------------


async def test_slot_select_precedes_every_dependent_read() -> None:
    """The cursor is a single global on the device, shared by 4 characteristics."""
    unit = SimulatedUnit()
    unit.slots[5].voltage_v = 4.05
    transport, client = await _connected(unit)

    status = await transport.async_poll()
    assert status.slots[5].voltage_v == pytest.approx(4.05)

    selects = [w for w in client.writes if w[0] == proto.SLOT_SELECT_UUID.lower()]
    assert len(selects) >= 8, "each slot read must set the cursor first"


async def test_concurrent_reads_do_not_interleave_the_cursor() -> None:
    """Two reads racing must not read each other's slot.

    Without the lock, task A's select can land between task B's select and
    its read, and B silently gets A's data.
    """
    unit = SimulatedUnit()
    for i in range(8):
        unit.slots[i].voltage_v = 3.0 + i / 10

    transport, _ = await _connected(unit)
    results = await asyncio.gather(
        *(transport.async_read_config(i) for i in range(8)),
        *(transport._select_and_read(i, proto.SLOT_STATUS_UUID) for i in range(8)),
    )
    statuses = [proto.SlotStatus.decode(r) for r in results[8:]]
    for i, status in enumerate(statuses):
        assert status.slot == i
        assert status.voltage_v == pytest.approx(3.0 + i / 10)


# --- write validation -------------------------------------------------------


async def test_exact_write_length_is_enforced() -> None:
    """The device rejects anything that is not an exact size match."""
    unit = SimulatedUnit()
    _, client = await _connected(unit)
    from tests.simulator.fake_ble import BleakErrorSim

    with pytest.raises(BleakErrorSim) as err:
        await client.write_gatt_char(proto.COMMAND_UUID, b"\x01\x00")
    assert err.value.code == 0x0D


async def test_serial_length_bounds() -> None:
    unit = SimulatedUnit()
    transport, _ = await _connected(unit)
    with pytest.raises(ValueError, match="1-31"):
        await transport.async_set_serial(0, "")
    with pytest.raises(ValueError, match="1-31"):
        await transport.async_set_serial(0, "x" * 32)


# --- refusals are opaque ----------------------------------------------------


async def test_refusal_surfaces_as_unit_refused_not_transport_error() -> None:
    """ATT 0x0E means "refused" or "stack failed" with no way to tell apart.

    It must never be retried - a refusal will be refused again.
    """
    unit = SimulatedUnit()
    transport, _ = await _connected(unit)
    # Not configured, so the engine refuses the start.
    with pytest.raises(UnitRefusedError, match="state and fault"):
        await transport.async_start(0)
    assert unit.refusals


async def test_start_succeeds_once_configured() -> None:
    unit = SimulatedUnit()
    transport, _ = await _connected(unit)
    await transport.async_write_config(
        proto.SlotConfig(
            slot=0,
            chemistry=CellChemistry.NMC,
            auto_recharge=False,
            capacity_mah=3000.0,
            charge_c=0.5,
            discharge_c=1.0,
            shipping_pct=60.0,
            max_duration_minutes=0,
            model_name="Samsung 30Q",
            serial="SN1",
        )
    )
    await transport.async_start(0)
    assert unit.slots[0].running


# --- calibration ------------------------------------------------------------


async def test_cal_command_reads_status_back() -> None:
    """A GATT write succeeding says nothing about acceptance."""
    unit = SimulatedUnit()
    transport, _ = await _connected(unit)
    status = await transport.async_cal_command(CalCommand.ENTER, slot=3)
    assert status.slot == 3
    assert status.active
    assert status.result is CalResult.OK


async def test_cal_refusal_reports_the_specific_reason() -> None:
    """ATT 0x0E carries no diagnosis - the transport must read 000c anyway.

    Giving up on the write error would lose the one thing that says WHY, and
    leave the caller with "ATT error 0x0E" instead of "a slot is running".
    """
    unit = SimulatedUnit()
    unit.slots[1].running = True
    transport, _ = await _connected(unit)

    status = await transport.async_cal_command(CalCommand.ENTER, slot=3)
    assert status.result is CalResult.TESTING
    assert status.failed


async def test_cal_pu_range_refusal() -> None:
    """A reading between 0.2 and 0.8 is ambiguous and must be refused."""
    unit = SimulatedUnit()
    transport, _ = await _connected(unit)
    await transport.async_cal_command(CalCommand.ENTER, slot=0)
    unit.cal_telemetry[0] = 0.5
    status = await transport.async_cal_command(CalCommand.CAPTURE_VOLTAGE, arg=2.0)
    assert status.result is CalResult.PU_RANGE
    assert status.failed


# --- notifications ----------------------------------------------------------


async def test_notification_decodes_its_own_slot() -> None:
    """Notifications are not filtered by the cursor."""
    unit = SimulatedUnit()
    transport, client = await _connected(unit)
    await transport.async_poll()

    seen: list[int] = []
    await transport.async_start_notify(
        lambda snap: seen.extend(sorted(snap.slots))
    )
    unit.slots[6].voltage_v = 4.11
    client.push_slot_notification(6)

    assert 6 in seen
    assert transport._slots[6].voltage_v == pytest.approx(4.11)


async def test_truncated_notification_is_dropped_not_misdecoded() -> None:
    """At a 23-byte MTU a 68-byte record arrives as 20 bytes.

    The only safe response is to drop it: decoding the prefix would report a
    plausible but wrong voltage.
    """
    unit = SimulatedUnit()
    transport, client = await _connected(unit, mtu_size=23)
    await transport.async_poll()

    before = dict(transport._slots)
    await transport.async_start_notify(lambda snap: None)
    client.push_slot_notification(2)

    assert transport._slots[2] == before[2], "truncated record must be ignored"


# --- registers --------------------------------------------------------------


async def test_register_read_write_roundtrip() -> None:
    unit = SimulatedUnit()
    transport, _ = await _connected(unit)
    await transport.async_write_register(regs.REG_HOST_WATCHDOG_S, 45.0)
    assert await transport.async_read_register(regs.REG_HOST_WATCHDOG_S) == 45.0


async def test_write_to_read_only_register_is_silently_dropped() -> None:
    """The target does not reject it - it simply does nothing.

    A client that assumes a successful write took effect is wrong, which is
    why the simulator records the drop for assertion.
    """
    unit = SimulatedUnit()
    transport, _ = await _connected(unit)
    address = regs.rt_addr(0, regs.RT_CELL_VOLTAGE)
    await transport.async_write_register(address, 99.0)

    assert unit.dropped_writes == [(address, 99.0)]
    assert await transport.async_read_register(address) != 99.0


# --- CAN --------------------------------------------------------------------


def test_can_mailbox_roundtrip() -> None:
    unit = SimulatedUnit()
    can_id, data = canproto.encode_register_write(regs.REG_HOST_WATCHDOG_S, 60.0)
    unit.can_handle(can_id, data)

    can_id, data = canproto.encode_register_read(regs.REG_HOST_WATCHDOG_S)
    reply = unit.can_handle(can_id, data)
    assert reply is not None
    address, value = canproto.decode_register_reply(reply[1])
    assert address == regs.REG_HOST_WATCHDOG_S
    assert value == pytest.approx(60.0)


def test_can_refuses_a_write_to_a_read_only_register() -> None:
    """Better to refuse locally than let the target drop it in silence."""
    with pytest.raises(ValueError, match="read-only"):
        canproto.encode_register_write(regs.rt_addr(0, regs.RT_STATUS), 1.0)


def test_can_telemetry_current_is_unrecoverable() -> None:
    """Only the low word of the current float is transmitted.

    The exponent and sign are in the missing half, so the value cannot be
    reconstructed - the decoder must report absence rather than a number.
    """
    unit = SimulatedUnit()
    unit.slots[2].voltage_v = 3.85
    unit.slots[2].current_a = -1.75

    can_id, data = unit.can_telemetry(2)
    frame = canproto.CanTelemetry.decode(can_id, data)

    assert frame.channel == 2
    assert frame.voltage_v == pytest.approx(3.85, abs=1e-5)
    assert frame.current_a is None


def test_can_telemetry_ids() -> None:
    assert canproto.telemetry_id(0) == 0x1C000001
    assert canproto.telemetry_id(7) == 0x1C700001
    assert canproto.MAILBOX_ID == 0x1C000002
    assert canproto.channel_of(0x1C300001) == 3
    assert canproto.channel_of(canproto.MAILBOX_ID) is None
