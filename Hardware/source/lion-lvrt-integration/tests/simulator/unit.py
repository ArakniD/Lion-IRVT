"""A firmware-accurate simulator of the BTS and its ESP32 proxy.

The point of this module is to reproduce the behaviours that break clients,
not to be a convenient stub. A simulator that always succeeds would have
passed every one of the three client bugs recorded in
``Docs/ble-specification.md`` section 11.

So it deliberately reproduces:

* **The slot-select cursor**, a single global on the device shared by four
  characteristics, so a client that reads without selecting gets the wrong
  slot's data rather than an error.
* **Exact write lengths.** Every write is length-checked for an exact match
  and rejected with ATT 0x0D otherwise.
* **Opaque refusals.** A refused command returns ATT 0x0E with no diagnosis,
  exactly as the firmware does, so a client cannot accidentally depend on a
  reason it will not have in the field.
* **The unit-state gate.** A charge command while the input bus is low is
  accepted at the transport level and silently does nothing, which is what
  ``modeCallback()`` does.
* **Read-only registers**, whose writes are silently dropped.
* **The host watchdog**, which pauses every running slot when no command
  arrives in time.

``BLE_PROTO_VERSION`` is settable so a client can be tested against a
firmware without the calibration or register characteristics.
"""

from __future__ import annotations

import struct
from dataclasses import dataclass, field

from custom_components.lion_lvrt.const import (
    BleCommand,
    CalCommand,
    CalResult,
    CalStatusBit,
    CellChemistry,
    SlotFault,
    SlotMode,
    SlotState,
    StatusBit,
    UnitState,
)
from custom_components.lion_lvrt.protocol import ble as proto
from custom_components.lion_lvrt.protocol import can as canproto
from custom_components.lion_lvrt.protocol import registers as regs

#: ATT error codes the firmware actually raises.
ATT_REQ_NOT_SUPPORTED = 0x06
ATT_INVALID_ATTR_VALUE_LEN = 0x0D
ATT_UNLIKELY = 0x0E


class AttError(Exception):
    """An ATT-layer rejection, carrying only its code - as on the wire."""

    def __init__(self, code: int) -> None:
        super().__init__(f"ATT error 0x{code:02X}")
        self.code = code


@dataclass
class SimSlot:
    """One slot's state inside the simulated unit."""

    index: int
    enabled: bool = True
    follower: bool = False

    state: SlotState = SlotState.IDLE
    fault: SlotFault = SlotFault.NONE
    configured: bool = False

    voltage_v: float = 3.7
    current_a: float = 0.0
    temp_c: float = 24.0

    # The BTS's own per-direction accumulators. Each pair is zeroed only when
    # its own direction starts - never on stop, trip, or a mode write that
    # does not start the slot.
    charge_mah: float = 0.0
    charge_mwh: float = 0.0
    charge_seconds: float = 0.0
    discharge_mah: float = 0.0
    discharge_mwh: float = 0.0
    discharge_seconds: float = 0.0

    live_mah: float = 0.0
    live_mwh: float = 0.0
    elapsed_s: int = 0
    state_elapsed_s: int = 0
    progress: float = 0.0

    running: bool = False
    charging: bool = False
    paused: bool = False
    wd_tripped: bool = False
    restored: bool = False
    ended: bool = False
    calibrating: bool = False
    cal_v_valid: bool = False
    cal_i_valid: bool = False

    config: proto.SlotConfig | None = None
    result: proto.SlotResult | None = None

    limits: dict[int, float] = field(default_factory=dict)
    calibration: dict[int, float] = field(default_factory=dict)

    @property
    def status_bits(self) -> int:
        bits = 0
        if self.running:
            bits |= StatusBit.RUNNING
        else:
            bits |= StatusBit.STOPPED
        if self.ended:
            bits |= StatusBit.FINISHED
        if self.charging:
            bits |= StatusBit.CHARGING
        elif self.running or self.paused:
            bits |= StatusBit.DISCHARGING
        if self.running:
            # CC-only build: bit 7 is always set while running, bit 6 never.
            bits |= StatusBit.CONST_CURRENT
        if self.follower:
            bits |= StatusBit.SLAVE_MODE
        if self.voltage_v < 0:
            bits |= StatusBit.REVERSE_POLARITY
        if not self.enabled:
            bits |= StatusBit.SLOT_DISABLED
        if self.calibrating:
            bits |= StatusBit.CALIBRATING
        if self.cal_v_valid:
            bits |= StatusBit.CAL_V_VALID
        if self.cal_i_valid:
            bits |= StatusBit.CAL_I_VALID
        if self.paused:
            bits |= StatusBit.PAUSED
        if self.wd_tripped:
            bits |= StatusBit.WD_TRIPPED
        if self.restored:
            bits |= StatusBit.RESTORED
        return int(bits)


class SimulatedUnit:
    """The BTS plus its proxy, as one object."""

    def __init__(
        self,
        *,
        slot_count: int = 8,
        proto_version: int = 3,
        unit_state: UnitState = UnitState.INPUT_OK,
        input_voltage_v: float = 12.0,
        has_registers_char: bool = True,
        host_watchdog_s: float = 30.0,
    ) -> None:
        self.slot_count = slot_count
        self.proto_version = proto_version
        self.unit_state = unit_state
        self.input_voltage_v = input_voltage_v
        self.has_registers_char = has_registers_char
        self.host_watchdog_s = host_watchdog_s
        self.watchdog_remaining_s = host_watchdog_s

        self.slots = [SimSlot(index=i) for i in range(slot_count)]
        self.selected_slot = 0
        self.catalog_index = 0
        self.uptime_s = 0
        self.online = True
        self.wifi_connected = False
        # A unit idle since power-up reads all-zero accumulators, so the
        # firmware's positive-only probe leaves this false. Mirrored here
        # because clients must not treat it as "the BTS has no accumulators".
        self.stats_live = False

        self.cal_slot: int | None = None
        self.cal_status_bits = 0
        self.cal_result = CalResult.OK
        self.cal_telemetry = [0.0] * 9

        #: Commands the simulator refused, for assertions in tests.
        self.refusals: list[str] = []
        #: Every register write that was dropped because the target is RO.
        self.dropped_writes: list[tuple[int, float]] = []

        self._registers: dict[int, float] = {}
        self._seed_registers()

    # --- register file ----------------------------------------------------

    def _seed_registers(self) -> None:
        self._registers[regs.REG_CHARGE_DISABLE_V] = 9.0
        self._registers[regs.REG_CHARGE_RESTRICT_V] = 10.0
        self._registers[regs.REG_DISCHARGE_RESTRICT_V] = 15.0
        self._registers[regs.REG_DISCHARGE_DISABLE_V] = 16.0
        self._registers[regs.REG_HOST_WATCHDOG_S] = self.host_watchdog_s
        for ch in range(self.slot_count):
            self._registers[regs.set_addr(ch, regs.SET_CHARGE_V_MAX)] = 4.2
            self._registers[regs.set_addr(ch, regs.SET_DISCHARGE_V_MIN)] = 2.5
            self._registers[regs.set_addr(ch, regs.SET_CHARGE_I_MAX)] = 2.0
            self._registers[regs.set_addr(ch, regs.SET_DISCHARGE_I_MAX)] = 2.0
            self._registers[regs.set_addr(ch, regs.SET_MIN_CELL_TEMP)] = 5.0
            self._registers[regs.set_addr(ch, regs.SET_MAX_CELL_TEMP)] = 45.0

    def read_register(self, address: int) -> float:
        """Read one register. Any host access feeds the watchdog."""
        self.feed_watchdog()
        regs.index_of(address)

        if regs.RT_BASE <= address < regs.SET_BASE:
            channel, offset = divmod(address - regs.RT_BASE, regs.RT_STRIDE)
            if channel < self.slot_count:
                return self._runtime_value(self.slots[channel], offset)
            return 0.0

        if address == regs.REG_UNIT_STATE:
            return float(int(self.unit_state))
        if address == regs.REG_INPUT_VOLTAGE:
            return self.input_voltage_v
        if address == regs.REG_TRIP_STATUS:
            # Always zero on this build: every hardware trip source is masked,
            # so epwmTripISR() is never entered.
            return 0.0
        if address == regs.REG_WATCHDOG_REMAINING_S:
            return self.watchdog_remaining_s
        if address == regs.REG_CAL_SLOT:
            return float(self.cal_slot if self.cal_slot is not None else 255)
        if address == regs.REG_CAL_STATUS:
            return float(self.cal_status_bits)
        if address == regs.REG_CAL_RESULT:
            return float(int(self.cal_result))
        if regs.CAL_TELEMETRY_BASE <= address <= regs.REG_CAL_TEMP_C:
            idx = (address - regs.CAL_TELEMETRY_BASE) // 4
            return self.cal_telemetry[idx]

        return self._registers.get(address, 0.0)

    def _runtime_value(self, slot: SimSlot, offset: int) -> float:
        return {
            regs.RT_STATUS: float(slot.status_bits),
            regs.RT_CELL_VOLTAGE: slot.voltage_v,
            regs.RT_CELL_CURRENT: slot.current_a,
            regs.RT_SENSE_VOLTAGE: slot.voltage_v,
            regs.RT_SENSE_CURRENT: slot.current_a,
            regs.RT_CELL_TEMP: slot.temp_c,
            regs.RT_CHARGE_MAH: slot.charge_mah,
            regs.RT_CHARGE_MWH: slot.charge_mwh,
            regs.RT_CHARGE_SECONDS: slot.charge_seconds,
            regs.RT_DISCHARGE_MAH: slot.discharge_mah,
            regs.RT_DISCHARGE_MWH: slot.discharge_mwh,
            regs.RT_DISCHARGE_SECONDS: slot.discharge_seconds,
        }.get(offset, 0.0)

    def write_register(self, address: int, value: float) -> None:
        """Write one register.

        A write to a read-only register is **silently dropped**, exactly as
        the target does - it is not an error, it simply does nothing. Tests
        assert on :attr:`dropped_writes` to catch a client that believes such
        a write succeeded.
        """
        self.feed_watchdog()
        regs.index_of(address)

        if not regs.is_writable(address):
            self.dropped_writes.append((address, value))
            return

        if regs.SET_BASE <= address < regs.UNIT_BASE:
            channel, offset = divmod(address - regs.SET_BASE, regs.SET_STRIDE)
            if channel < self.slot_count and offset == regs.SET_MODE:
                self._apply_mode(channel, int(value))
                return

        if address == regs.REG_HOST_WATCHDOG_S:
            self.host_watchdog_s = value
            self.watchdog_remaining_s = value

        if address == regs.REG_CAL_COMMAND:
            self._apply_cal_command(int(value))
            return

        self._registers[address] = value

    # --- mode semantics ---------------------------------------------------

    def _apply_mode(self, channel: int, mode: int) -> None:
        """Apply a write to ``eChX_Mode``.

        Reproduces ``modeCallback()``: the command is refused outright when
        the input bus is outside the window, leaving the channel stopped with
        no error reported anywhere. A client that does not read the status
        back sees nothing.
        """
        slot = self.slots[channel]

        if mode & SlotMode.PAUSE:
            if slot.running:
                slot.running = False
                slot.paused = True
                slot.current_a = 0.0
            return

        if mode & SlotMode.RESUME:
            if slot.paused:
                slot.paused = False
                slot.wd_tripped = False
                slot.restored = False
                slot.running = True
            return

        if mode & SlotMode.CALIBRATE:
            self._enter_calibration(channel)
            return

        if not mode & SlotMode.RUN:
            slot.running = False
            slot.paused = False
            slot.current_a = 0.0
            return

        charging = bool(mode & SlotMode.CHARGE)

        if not slot.enabled or slot.follower:
            self.refusals.append(
                f"slot {channel} start refused: "
                f"{'strap-disabled' if not slot.enabled else 'group follower'}"
            )
            return

        if charging and not self.unit_state.charge_allowed:
            self.refusals.append(
                f"slot {channel} charge refused: unit is {self.unit_state.name}"
            )
            return
        if not charging and not self.unit_state.discharge_allowed:
            self.refusals.append(
                f"slot {channel} discharge refused: unit is {self.unit_state.name}"
            )
            return

        # A pair is zeroed only when its own direction starts.
        if charging:
            slot.charge_mah = slot.charge_mwh = slot.charge_seconds = 0.0
        else:
            slot.discharge_mah = slot.discharge_mwh = slot.discharge_seconds = 0.0

        slot.running = True
        slot.paused = False
        slot.ended = False
        slot.charging = charging
        slot.current_a = 1.0 if charging else -1.0
        slot.state = SlotState.CHARGE if charging else SlotState.DISCHARGE

    def _enter_calibration(self, channel: int) -> CalResult:
        if any(s.running for s in self.slots):
            self.cal_result = CalResult.TESTING
            return self.cal_result
        slot = self.slots[channel]
        if not slot.enabled or slot.follower:
            self.cal_result = CalResult.SLOT_UNAVAILABLE
            return self.cal_result
        for other in self.slots:
            other.calibrating = False
        slot.calibrating = True
        self.cal_slot = channel
        self.cal_status_bits = int(CalStatusBit.ACTIVE)
        self.cal_result = CalResult.OK
        return self.cal_result

    def _apply_cal_command(self, opcode: int) -> CalResult:
        arg = self._registers.get(regs.REG_CAL_ARGUMENT, 0.0)
        slot_idx = int(self._registers.get(regs.REG_CAL_SLOT, 0))
        return self.cal_command(opcode, slot_idx, arg)

    def cal_command(self, opcode: int, slot: int = 0, arg: float = 0.0) -> CalResult:
        """Drive the calibration state machine."""
        # Bit 7 refers to the most recent COMPUTE_SAVE, so a new command
        # clears it.
        self.cal_status_bits &= ~int(CalStatusBit.SAVED_TO_FRAM)
        self.cal_status_bits &= ~int(CalStatusBit.LAST_COMMAND_FAILED)

        if opcode == CalCommand.ENTER:
            result = self._enter_calibration(slot)
        elif self.cal_slot is None:
            result = CalResult.NOT_ACTIVE
        elif opcode == CalCommand.EXIT:
            self.slots[self.cal_slot].calibrating = False
            self.cal_slot = None
            self.cal_status_bits = 0
            result = CalResult.OK
        elif opcode == CalCommand.CAPTURE_VOLTAGE:
            pu = self.cal_telemetry[0]
            if pu < 0.2:
                self.cal_status_bits |= int(CalStatusBit.V_LOW_CAPTURED)
                result = CalResult.OK
            elif pu > 0.8:
                self.cal_status_bits |= int(CalStatusBit.V_HIGH_CAPTURED)
                result = CalResult.OK
            else:
                result = CalResult.PU_RANGE
        elif opcode == CalCommand.ZERO_CURRENT:
            self.cal_status_bits |= int(CalStatusBit.I_ZERO_CAPTURED)
            result = CalResult.OK
        elif opcode == CalCommand.SET_FIXED_CURRENT:
            if not 0.0 <= arg <= 0.8:
                result = CalResult.ARG
            else:
                self.cal_status_bits |= int(CalStatusBit.FIXED_CURRENT_DRIVING)
                result = CalResult.OK
        elif opcode == CalCommand.CAPTURE_CURRENT:
            self.cal_status_bits |= int(CalStatusBit.I_LOADED_CAPTURED)
            result = CalResult.OK
        elif opcode == CalCommand.COMPUTE_SAVE:
            need_v = int(CalStatusBit.V_LOW_CAPTURED | CalStatusBit.V_HIGH_CAPTURED)
            need_i = int(
                CalStatusBit.I_ZERO_CAPTURED | CalStatusBit.I_LOADED_CAPTURED
            )
            if not (self.cal_status_bits & need_v or self.cal_status_bits & need_i):
                result = CalResult.INSUFFICIENT
            else:
                slot_obj = self.slots[self.cal_slot]
                if self.cal_status_bits & need_v == need_v:
                    self.cal_status_bits |= int(CalStatusBit.V_COMPUTED)
                    slot_obj.cal_v_valid = True
                if self.cal_status_bits & need_i == need_i:
                    self.cal_status_bits |= int(CalStatusBit.I_COMPUTED)
                    slot_obj.cal_i_valid = True
                self.cal_status_bits |= int(CalStatusBit.SAVED_TO_FRAM)
                result = CalResult.OK
        elif opcode == CalCommand.CLEAR:
            self.cal_status_bits = int(CalStatusBit.ACTIVE)
            result = CalResult.OK
        else:
            result = CalResult.ARG

        if result != CalResult.OK:
            self.cal_status_bits |= int(CalStatusBit.LAST_COMMAND_FAILED)
        self.cal_result = result
        return result

    # --- watchdog ---------------------------------------------------------

    def feed_watchdog(self) -> None:
        """Reload the countdown, as any host command does."""
        self.watchdog_remaining_s = self.host_watchdog_s

    def tick_watchdog(self, seconds: float) -> None:
        """Advance time without a host command.

        When the countdown reaches zero every running slot is paused with
        WD_TRIPPED set - the behaviour that closes the unattended-charging
        safety gap.
        """
        if self.host_watchdog_s <= 0:
            return
        self.watchdog_remaining_s = max(0.0, self.watchdog_remaining_s - seconds)
        if self.watchdog_remaining_s > 0:
            return
        for slot in self.slots:
            if slot.running:
                slot.running = False
                slot.paused = True
                slot.wd_tripped = True
                slot.current_a = 0.0

    def simulate_reset_restore(self) -> None:
        """Model a power cycle that restored running slots from F-RAM."""
        for slot in self.slots:
            if slot.running or slot.paused:
                slot.running = False
                slot.paused = True
                slot.restored = True
                slot.state = SlotState.BTS_PAUSED
                slot.current_a = 0.0
        self.uptime_s = 0

    # --- test engine ------------------------------------------------------

    def engine_command(self, opcode: int, slot: int) -> None:
        """Apply a ``ble_cmd_t`` opcode, raising AttError as the device does."""
        if opcode == BleCommand.ABORT_ALL:
            for s in self.slots:
                s.running = s.paused = False
                s.current_a = 0.0
                s.state = SlotState.ABORTED
            return

        if not 0 <= slot < self.slot_count:
            raise AttError(ATT_INVALID_ATTR_VALUE_LEN)
        target = self.slots[slot]

        if opcode == BleCommand.START:
            if not target.enabled or target.follower or target.paused:
                self.refusals.append(f"slot {slot} start refused by engine")
                raise AttError(ATT_UNLIKELY)
            if not target.configured:
                self.refusals.append(f"slot {slot} start refused: not configured")
                raise AttError(ATT_UNLIKELY)
            target.running = True
            target.state = SlotState.CHECK_REST
            target.fault = SlotFault.NONE
        elif opcode == BleCommand.ABORT:
            target.running = target.paused = False
            target.current_a = 0.0
            target.state = SlotState.ABORTED
        elif opcode == BleCommand.CLEAR_FAULT:
            if target.state != SlotState.FAULT:
                raise AttError(ATT_UNLIKELY)
            target.fault = SlotFault.NONE
            target.state = SlotState.IDLE
        elif opcode == BleCommand.PAUSE:
            if not target.running:
                raise AttError(ATT_UNLIKELY)
            target.running = False
            target.paused = True
            target.current_a = 0.0
        elif opcode == BleCommand.RESUME:
            if not target.paused:
                raise AttError(ATT_UNLIKELY)
            target.paused = False
            target.wd_tripped = False
            target.restored = False
            target.running = True
        else:
            raise AttError(ATT_REQ_NOT_SUPPORTED)

    # --- GATT record builders --------------------------------------------

    def unit_status_bytes(self) -> bytes:
        return struct.pack(
            proto.UNIT_STATUS_FMT,
            self.proto_version,
            self.slot_count,
            1 if self.online else 0,
            int(self.unit_state),
            0,
            self.input_voltage_v,
            self.uptime_s,
            1 if self.stats_live else 0,
            1 if self.wifi_connected else 0,
            0,
            self.host_watchdog_s,
        )

    def slot_status_bytes(self, index: int) -> bytes:
        s = self.slots[index]
        return struct.pack(
            proto.SLOT_STATUS_FMT,
            s.index,
            int(s.state),
            int(s.fault),
            1 if s.configured else 0,
            s.voltage_v,
            s.current_a,
            s.temp_c,
            s.live_mah,
            s.live_mwh,
            s.progress,
            s.elapsed_s,
            s.state_elapsed_s,
            s.status_bits,
            1 if s.paused else 0,
            1 if s.wd_tripped else 0,
            1 if s.restored else 0,
            1 if s.ended else 0,
            s.charge_mah,
            s.charge_mwh,
            s.charge_seconds,
            s.discharge_mah,
            s.discharge_mwh,
            s.discharge_seconds,
        )

    def slot_config_bytes(self, index: int) -> bytes:
        cfg = self.slots[index].config
        if cfg is None:
            cfg = proto.SlotConfig(
                slot=index,
                chemistry=CellChemistry.NMC,
                auto_recharge=False,
                capacity_mah=0.0,
                charge_c=0.0,
                discharge_c=0.0,
                shipping_pct=0.0,
                max_duration_minutes=0,
                model_name="",
                serial="",
            )
        return cfg.encode()

    def slot_result_bytes(self, index: int) -> bytes:
        result = self.slots[index].result
        if result is None:
            return struct.pack(
                proto.SLOT_RESULT_FMT,
                index, 0, 0, 0,
                *([0.0] * 11),
                0, 0, b"\0" * 24, b"\0" * 32,
            )
        return struct.pack(
            proto.SLOT_RESULT_FMT,
            result.slot,
            1 if result.valid else 0,
            int(result.chemistry),
            1 if result.recharged else 0,
            result.start_voltage_v,
            result.end_voltage_v,
            result.rested_voltage_v,
            result.discharge_mah,
            result.discharge_mwh,
            result.max_temp_c,
            result.max_current_a,
            result.min_voltage_v,
            result.max_voltage_v,
            result.recharge_mah,
            result.shipping_voltage_v,
            result.discharge_seconds,
            result.completed_uptime_s,
            result.model_name.encode()[:23].ljust(24, b"\0"),
            result.serial.encode()[:31].ljust(32, b"\0"),
        )

    def cal_status_bytes(self) -> bytes:
        slot = self.cal_slot if self.cal_slot is not None else 255
        v_tick = i_tick = False
        if self.cal_slot is not None:
            v_tick = self.slots[self.cal_slot].cal_v_valid
            i_tick = self.slots[self.cal_slot].cal_i_valid
        return struct.pack(
            proto.CAL_STATUS_FMT,
            slot,
            1 if self.cal_status_bits & int(CalStatusBit.ACTIVE) else 0,
            1 if v_tick else 0,
            1 if i_tick else 0,
            self.cal_status_bits,
            int(self.cal_result),
            *self.cal_telemetry,
        )

    def catalog_entry_bytes(self, index: int) -> bytes:
        """Five chemistries then nine models, total 14."""
        total = 14
        if index >= total:
            # Past the end the record is zero apart from index and total.
            return struct.pack(
                proto.CATALOG_ENTRY_FMT,
                index, 0, 0, total,
                *([0.0] * 10), 0,
                b"\0" * 24, b"\0" * 24,
            )
        is_model = index >= 5
        return struct.pack(
            proto.CATALOG_ENTRY_FMT,
            index,
            1 if is_model else 0,
            index if not is_model else 3,
            total,
            2000.0 if is_model else 0.0,
            4.2, 2.5, 3.8, 0.5, 1.0,
            10.0 if is_model else 0.0,
            20.0 if is_model else 0.0,
            5.0, 45.0, 30,
            (f"MODEL{index}" if is_model else f"CHEM{index}").encode().ljust(24, b"\0"),
            (b"Samsung" if is_model else b"").ljust(24, b"\0"),
        )

    # --- CAN --------------------------------------------------------------

    def can_handle(self, can_id: int, data: bytes) -> tuple[int, bytes] | None:
        """Process a mailbox frame, returning a reply frame for a read."""
        if can_id != canproto.MAILBOX_ID:
            return None
        address = ((data[0] & 0xFF) << 8) | (data[1] & 0xFF)
        if data[2] == 0x01:
            value = struct.unpack("<f", bytes(data[4:8]))[0]
            try:
                self.write_register(address, value)
            except ValueError:
                pass
            return None
        try:
            value = self.read_register(address)
        except ValueError:
            return None
        raw = struct.pack("<f", value)
        return canproto.MAILBOX_ID, bytes(
            [data[0], data[1], 0x00, 0x00, raw[0], raw[1], raw[2], raw[3]]
        )

    def can_telemetry(self, channel: int) -> tuple[int, bytes]:
        """Build a periodic telemetry frame, truncated current and all.

        The current's high word is genuinely absent here, because it is
        genuinely absent on the wire - a test that decodes this frame must
        cope with an unusable current rather than a merely imprecise one.
        """
        slot = self.slots[channel]
        v = struct.pack("<f", slot.voltage_v)
        c = struct.pack("<f", slot.current_a)
        return canproto.telemetry_id(channel), bytes(
            [channel, 0, v[0], v[1], v[2], v[3], c[0], c[1]]
        )
