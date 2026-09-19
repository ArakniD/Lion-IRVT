---
name: bts-c2000-interfaces
description: Interfaces, operational model and traps for the 8-channel bidirectional battery tester on TI C2000 F28379D (dual-core) and its ESP32 proxy. Covers the I2C register bus (host/target and F-RAM/ADS1119 controller), the AT command console, CAN telemetry, the runtime externally-referenced slot calibration protocol, FM24V10 F-RAM persistence, IPC and message-RAM discipline between the control core and the comms core, status/mode bitfields, WS2812B status LEDs, and build guidance for TI Code Composer Studio with C2000Ware and PowerSUITE. Use when editing registers, protocols, calibration, IPC or LED/trip behaviour, or when reasoning about what a host actually sees.
---

# BTS C2000 Interfaces Skill

## Overview

Operational model, constraints and traps for the dual-core TI TMS320F28379D
battery tester (BTS). CPU1 runs the 8-channel synchronous bidirectional DC-DC
control loops (HRPWM + DCL) and owns the runtime calibration state machine.
CPU2 owns all external communication (I2C target for the ESP32, I2C controller
for the FM24V10 F-RAM and the ADS1119 temperature ADCs, the AT command
console, CAN telemetry, WS2812B LEDs) and all non-volatile configuration.

**`Docs/` is authoritative for the interface specifications.** It is newer,
verified against source, and far more complete than anything that can be
usefully inlined here. This skill exists to tell you *how the system behaves*,
*what will bite you*, and *which `Docs/` page to open*. Where a doc and the
source disagree, the source wins — `Docs/api-specification.md` §2.9 already
records the known disagreements.

| Question | Read |
|---|---|
| Complete I2C register map, HTTP API, wire formats, dead registers | `Docs/api-specification.md` |
| Full GATT spec, characteristic layouts, notify behaviour | `Docs/ble-specification.md` |
| The calibration contract — opcodes, maths, safety rules, RAM budget | `Docs/calibration-design.md` |
| Operator bench procedure, wiring, troubleshooting | `Docs/README.md`, `Docs/calibration-flow.md` |
| IPC mechanics, core split, message-RAM discipline, trip identification | `references/ipc-and-core-responsibilities.md` |
| I2C operational notes, pad byte, target watchdog, ESP32 patterns | `references/i2c-interface-spec.md` |
| AT console — and why it may not exist in your build | `references/uart-at-commands.md` |
| F-RAM layout, header/CRC contract, load/save flow, defaults | `references/calibration.md` |

---

## Read this before touching anything

Six facts that invalidate the obvious guess. Each is confirmed in source.

1. **`eChX_CellVoltage` / `eChX_CellCurrent` are the 12-bit internal ADC**,
   not the 16-bit ADS131M08 — the opposite of what the naming suggests. The
   ADS131M08 engineering values (`Vsense_V` / `Isense_A`) live in the **sense
   block at 1092+**. They were computed at 10 Hz and read by nothing until
   that block was added (`bts_cpu1.c` `publishStatusToCpu2`,
   `com_cpu2.c:2032-2036`).

2. **The storage device is an FM24V10 F-RAM, not an EEPROM.** The functions
   are still called `readEEPROM` / `writeEEPROM` and the macros still say
   `EEPROM_*` (`com_cpu2.c:88-106, 762-780`). It is 128 KiB, byte-writable,
   with no page-write delay — which is why a save can be a single block write.

3. **The two header files use identical names for different things.** See the
   collision table below. Copying a line between `registers.h` and
   `bts_regs.h` compiles and is silently wrong.

4. **The build is CC-only.** `BTS_LAB_TYPE = BTS_LAB_CLOSED_LOOP_ACMC_IOUT`
   (`bts_user_settings.h:305`) selects `BTS_ISR_CL_MODE_CC`, so the CV loop
   and the CC-CV crossover are compiled out. `voutRef_pu` is computed every
   millisecond and ignored.

5. **Every hardware over-current trip is disabled.**
   `BTS_TRIP_HW_CH1..8_ENABLED (false)` (`bts_user_settings.h:113-120`). The
   only over-current protection left is the software check in
   `BTS_tripEpwm()`, which acts within a control period rather than a
   switching cycle. Do not run unattended high-current tests. See
   `bts_user_settings.h:74-111` for why they are masked (TZ1/TZ2 are hardwired
   to Input X-BAR INPUT1/INPUT2, which sit at their GPIO0 reset default —
   channel 1's trip zone was watching its own gate drive).

6. **The Input X-BAR is device-global, not per-core.** Each core has its own
   PIE vector, but `GPIO_setInterruptPin()` writes the **single shared Input
   X-BAR**. Both cores used to claim XINT1/XINT2, so CPU2's `initADS1119()`
   ran last and silently disconnected the SPI ADCs' DRDY interrupts. Fixed
   2026-09-19: CPU1 now owns XINT3/XINT5, CPU2 keeps XINT1/XINT2. Allocation
   table and the remaining INPUT14 contention:
   `references/ipc-and-core-responsibilities.md` §6.1.

---

## Processors and build platform

- **MCU**: TMS320F28379D (dual C28x + CLA), 160 MHz.
- **CPU1** — real-time control. HRPWM, DCL loops, external SPI ADC
  acquisition, on-chip ADC cell V/I, trip handling, the A/B/C background task
  machine (1 kHz / 100 Hz / 10 Hz), unit input-voltage state machine, the
  runtime calibration state machine and capture set. Boots CPU2.
- **CPU2** — communications and configuration. I2CA target (0x50), I2CB
  controller (F-RAM 0x50, ADS1119 0x40/0x41), the AT console, CANA, WS2812B,
  F-RAM load/save. **Sole writer of `registers[]`.**
- **SDK**: C2000Ware driverlib + device support, DCL FPU32, PowerSUITE/SFRA
  (`BTS_SFRA_ENABLED` is currently `false`), SFO for HRPWM MEP.
- **Build**: TI CCS, two configurations (`cpu1/`, `cpu2/`). Always build
  through the `buildProject` MCP tool, never `gmake` directly.
- **Float constraint**: `--float_operations_allowed=32`. No doubles — use
  `strtof` not `atof`, and never `printf("%f")` (it promotes). See
  `formatRegisterValue` in `com_cpu2.c` for the scaled-integer idiom.
- **C28x byte is 16 bits.** A `float` is two words, not four bytes. Anything
  crossing I2C/CAN/UART must be packed explicitly — never `memcpy` a struct
  onto the wire.

Prefer driverlib (`I2C_*`, `SCI_*`, `CAN_*`, `EPWM_*`, `HRPWM_*`, `IPC_*`,
`GPIO_*`, `ADC_*`, `CPUTimer_*`) over raw register access.

### Shared memory

Both message RAMs are single-writer, and that rule is the foundation of the
whole data-flow design.

| Block | Address | Writer | Contents |
|---|---|---|---|
| `CPU2TOCPU1RAM` | `0x03F800` | CPU2 | `ipcMsg`, `calValidFlags[8]`, `registers[TOTAL_REGISTERS]` |
| `CPU1TOCPU2RAM` | `0x03FC00` | CPU1 | `startup_mode`, `startup_enable`, `canData[8]`, `cpu1Status` |

CPU1 **never writes** `registers[]`, with exactly one deliberate exception:
`modeCallback()` sets `eCalSlot` when mode bit 2 routes a channel into
calibration (`bts_cpu1.c:1031`). Everything else CPU1 produces travels through
`cpu1Status` under its `seq` seqlock and is mirrored in by CPU2.

`calibrationData[]` is **no longer shared** — it is CPU2-private `.bss`
(`registers.c:39`, at `0x0000a000` in both maps). Only the persisted validity
flags cross, as `calValidFlags[8]`, because CPU1 needs them for the display
ticks after a power cycle.

**`CPU2TOCPU1RAM` is the binding constraint on any new shared register.** The
30 registers added this session plus two new struct fields overflowed it
(`#10099-D ... section "MSGRAM_CPU2_TO_CPU1"`), which is what forced
`calibrationData[]` out. Current occupancy, from the map files:

| Block | Used | Free |
|---|---|---|
| `CPU2TOCPU1RAM` | 766 words (`0x2FE`) | 258 words (`0x102`) |
| `CPU1TOCPU2RAM` | 476 words (`0x1DC`) | 548 words (`0x224`) |

Overflow is a link-time failure, not a runtime one — but check the `.map`
after adding anything shared, and confirm every shared symbol resolves to the
same address in `cpu1/*.map` and `cpu2/*.map`.

Full IPC contract, flag allocation, boot and calibration data flows, interrupt
ownership, register strides and trip-source identification:
`references/ipc-and-core-responsibilities.md`.

---

## System operation

8 independent bidirectional synchronous buck/boost slots. Each supports charge
and discharge with independent voltage/current limits, a min/max cell
temperature window and trip protection.

- `eChX_Mode` (per channel) encodes run + direction + calibration entry.
  Bit 0 = run, bit 1 = **charge** (clear = discharge), bit 2 = enter
  calibration. Note the asymmetry: `0x00` is stop and `0x01` is *start a
  discharge*, one bit apart.
- Setpoints arrive over I2C/UART/CAN into `registers[]`; CPU2 validates access
  and raises `IPC_FLAG0`; CPU1 applies them through
  `BTS_updateReference` → DCL → HRPWM duty.
- Slots are **grouped** by the MODE dip strap (independent / pairs / quads /
  octet, and a parallel set of modes that closes the voltage loop on the
  internal ADC instead of the ADS131M08). Only a **group leader** has a
  control loop; followers mirror it. `modeCallback()` and `CAL_CMD_ENTER` both
  reject writes to a follower or a strap-disabled slot.
- Unit-level input bus voltage enforces charge/discharge restrict and disable
  thresholds — **at mode-write time and again at 10 Hz in `C1()`**. A slot in
  calibration is exempt from both; missing either one stops the slot a
  fraction of a second after it starts.
- WS2812B LEDs reflect running / charging / discharging / trip, plus a white
  flash for the slot under calibration. **`BTS_LED_DRIVER_ENABLED` is
  currently `false`** — see the console note below.
- Calibration coefficients and global voltage thresholds persist in the
  FM24V10 F-RAM and load at boot.

---

## Interfaces at a glance

### I2C target (I2CA) — host / ESP32 register bus

- **GPIO32 = SDA, GPIO33 = SCL**, 7-bit address `0x50`, 100 kHz.
- Register-oriented: 16-bit big-endian byte address + 32-bit **big-endian**
  float payload. (The BLE side is little-endian. Do not confuse them.)
- Byte address ÷ 4 = index into `registers[]`. Only `REG_ACCESS_RW` entries in
  `regConfig[]` accept writes; writes elsewhere are silently dropped.
- Both reads and writes auto-increment, bounded at the top of the map.
- **A read must fetch `1 + count*4` bytes and discard the first.** The C2000
  starts clocking out its TX register the instant it acknowledges the repeated
  start, before its ISR can run, so every reply is preceded by one stale pad
  byte. This is a property of the peripheral, not a fixable target bug.
- Framing lives on PIE 8.1 (`i2cSlaveISR`) and the data bytes on 8.2
  (`i2cSlaveFifoISR`). With the FIFO enabled the TRM forbids the basic
  RRDY/XRDY interrupts — mixing the two lets a data byte be parsed as an
  address byte.

Detail, traps and ESP32 patterns: `references/i2c-interface-spec.md`.
Complete map: `Docs/api-specification.md` Part 2.

### I2C controller (I2CB) — F-RAM + ADS1119

- **GPIO40 = SDA, GPIO41 = SCL**, 400 kHz. (Not GPIO34/35.)
- FM24V10 F-RAM at `0x50` — same address as the target, different bus.
- Two ADS1119 at `0x40` (slots 1-4) and `0x41` (slots 5-8), continuous
  conversion, DRDY on GPIO42/43 → XINT1/XINT2, round-robin mux.
- The ADS1119 is **command-based, not memory-addressed** — it must not be
  driven through the F-RAM's `i2cReadBlock`/`i2cWriteBlock` helpers, which
  always emit a 16-bit word address.
- Cell temperature comes from a measured **fourth-order polynomial fit of the
  amplifier output**, not a raw thermistor table
  (`com_cpu2.c:196-223`). It bottoms out at +18.3 °C for 0 V in, so a low
  reading is a cold sensor and never a missing one; it saturates near 81 °C
  because the converter full scale is the 2.50 V reference.

### AT command console

**Conditional.** `BTS_DEBUG_CONSOLE` (`bts_user_settings.h:42`) picks what
GPIO28/29 do, and the two roles are mutually exclusive:

| `BTS_DEBUG_CONSOLE` | GPIO28 | GPIO29 | Console | LEDs | Ch1 GPIO trip |
|---|---|---|---|---|---|
| `true` (current) | SCIRXDA | SCITXDA | **SCIA @ 115200 8N1** | off | off |
| `false` | ch1 trip in | WS2812B TX | **none** | on | on |

There is no SCIB console: GPIO18 is SPICLKA and GPIO19 is the ADC1 chip
select. In a production build the host must use I2C or CAN.

Command reference and what changes between the two builds:
`references/uart-at-commands.md`.

### CAN (CANA)

500 kbit/s, extended 29-bit IDs, base `0x1C000000`. TX objects 1-8 carry
per-channel telemetry (channel byte + voltage + current, little-endian words);
object 9 is a host register read/write mailbox (`addr` big-endian, R/W flag,
then float in little-endian word order — note it differs from the I2C wire
order). Periodic TX is round-robin from the 8 Hz CPU Timer 1 ISR.

`canData[].mAh` / `.mWh` are now populated by `publishStatusToCpu2()` from
the accumulator matching each slot's direction, but `sendCANData()` still
does not transmit them.

---

## Calibration

The old flow — host writes the gain registers, then writes
`eCalibrationMode = 2.0f` to commit — **still exists and still works**. It now
sits alongside a full runtime, externally-referenced two-point calibration.

The runtime process in one paragraph: a host selects a slot in `eCalSlot`,
then drives a **9-opcode command protocol** through `eCalArgument` /
`eCalCommand` (argument first — the command is consumed on write and
self-clears). CPU1 puts the slot into a per-channel `calState`, holding the
converter off for the voltage and zero-current captures and driving a fixed
**discharge** current for the loaded capture. Both measurement paths — the
16-bit ADS131M08 and the 12-bit internal ADC — are captured from the same
physical stimulus at the same instant. `CAL_CMD_COMPUTE_SAVE` runs the
two-point maths, validates against gain windows, and hands the result to CPU2,
which writes the F-RAM **from the idle loop, never from an ISR**. Progress is
a bitfield in `eCalStatus`, failures a code in `eCalResult`, and live
telemetry streams through the window at 1056-1088.

Safety properties that must survive any edit: trips stay armed; the
fixed-current setpoint is clamped to 0.8 pu (≈8 A); the input-voltage
exemption is scoped to the one slot in `calState == 2` and honoured in **both**
enforcement points; one slot at a time; rejected while any slot is running a
test; a **120 s dead-man timeout** (`BTS_CAL_DEADMAN_PASSES`, 800 passes of
the ~6.67 Hz C1 task) drops the reference if no command arrives; and every
exit path zeroes the reference before changing state.

**Read `Docs/calibration-design.md` before changing any of this.** It is the
contract: opcode table, status bits, result codes, the exact two-point
mathematics, the guard conditions, the sign convention and the safety rules.
`references/calibration.md` covers the persistence side — F-RAM layout, the
header/CRC contract, the load/save flow and the defaults.

---

## The `BTS_*` name collision

`registers.h` (C2000) and `esp32-btle-proxy/components/bts_link/include/bts_regs.h`
(ESP32) are two hand-maintained transcriptions of the same map, with **no
build coupling**. Every address, stride, base, count, opcode and result code
agrees; `TOTAL_REGISTERS` / `BTS_TOTAL_REGISTERS` is 305 on both sides.

But four identifier families mean different things in the two files:

| Identifier | `registers.h` (C2000) | `bts_regs.h` (ESP32) |
|---|---|---|
| `BTS_STATUS_*` | bit **positions** (`0U`, `1U`, …) | bit **masks** (`1u << 0`, …) |
| `BTS_CAL_ST_*` | bit **positions** | bit **masks** |
| `BTS_CAL_F28V_GAIN` … `BTS_CAL_VOUT_OFFSET_V` | register **indices**, 0-11 | **byte** offsets, 0-44 |
| `BTS_SENSE_VOLTAGE` / `BTS_SENSE_CURRENT` | indices, 0 and 1 | byte offsets, 0 and 4 |
| `BTS_SENSE_BASE` | function-like macro returning an **index** | a bare constant `1092`, a **byte address** |

Each convention is self-consistent — the C2000 indexes `registers[]`, the
ESP32 addresses the wire. `BTS_SENSE_BASE` is the sharpest case: the same
spelling is a macro on one side and a constant on the other. **Copying a line
between these files compiles and is silently wrong.** When you change one,
change the other, and check the whole family rather than the one line you
came for.

---

## Status word

`eChX_Status`, packed by `publishStatusToCpu2()` and carried to hosts as a
`float32`.

| Bit | Name | Populated? |
|---|---|---|
| 0 | `RUNNING` | yes |
| 1 | `STOPPED` | yes |
| 2 | `FINISHED` | **never written** |
| 3 | `OVERCURRENT_TRIP` | yes |
| 4 | `CHARGING` | yes |
| 5 | `DISCHARGING` | yes |
| 6 | `CONST_VOLTAGE` | yes — now driven from `ctrlMode_logic` |
| 7 | `CONST_CURRENT` | yes — now driven from `ctrlMode_logic` |
| 8 | `SLAVE_MODE` | yes |
| 9 | `GROUP_DISCONNECT` | yes |
| 10 | `REVERSE_POLARITY` | yes |
| 11 | `SLOT_DISABLED` | yes |
| 12 | `CALIBRATING` | yes |
| 13 | `CAL_V_VALID` | yes, from **persisted** `calFlags` |
| 14 | `CAL_I_VALID` | yes, from **persisted** `calFlags` |

Bits 6/7 were tracked in the ISR all along but never copied out, so they read
0 on every earlier build. Bits 13/14 come from `calValidFlags[]` rather than
the in-session capture, so a slot calibrated in an earlier session still shows
its ticks after a power cycle.

> **The hard ceiling is bit 23.** The word reaches the host as a `float32`,
> whose 24-bit significand makes integers exact only to bit 23
> (`registers.h:420-424`). Bits 15-23 are free. Never go past 23.

---

## Declared but never written

Do not mistake any of these for a bug you introduced. They read back as a
constant `0.0`, and because they are `REG_ACCESS_RO` a host cannot clear them
either.

| What | Where | Note |
|---|---|---|
| `eChX_MinVoltage` (324 + ch×24) | stats block | Intended per-run voltage floor |
| `eChX_MaxVoltage` (328 + ch×24) | stats block | Intended per-run voltage ceiling |
| Status bit 2 (`FINISHED`) | `status[].finished` | Read into the bitset, never set |
| `iref_cuttout_A` | `BTS_userInput` | Loaded from `ChargeCurrentMin`, read by nothing |
| `eTripStatus` (988) | unit block | See below |
| `canData[].mAh` / `.mWh` | CAN struct | Populated now, but still not transmitted |

`eTripStatus` is mirrored from `cpu1Status.tripStatus`, which is only ever
written by `epwmTripISR`. That ISR is registered and enabled unconditionally,
but `BTS_HAL_setupEPWMTripZone()` masks the one-shot trip **signals** and
disables the trip-zone **interrupt** on any slot whose `BTS_TRIP_HW_CHn_ENABLED`
is false (`bts_hal.c:1057-1105`) — which is all eight. So the word stays 0
until the trip links are wired and those flags are turned back on. The
software trip path forces the outputs low through the same trip zone without
going near this ISR.

The two accumulator slots that used to sit in this table — 320 and 332 — are
now live as `eChX_ChargeAcc_mAh` / `_mWh`, with the discharge pair appended at
1156 + ch×8. See the accumulator note below. The ESP32 still integrates
charge and energy itself (`coulomb_counter.c`) and reports the BTS figures
beside its own.

### Charge / energy accumulators

Four registers per slot, all `REG_ACCESS_RO`:

| Register | Address |
|---|---|
| `eChX_ChargeAcc_mAh` | 320 + ch×24 |
| `eChX_ChargeAcc_mWh` | 332 + ch×24 |
| `eChX_DischargeAcc_mAh` | 1156 + ch×8 |
| `eChX_DischargeAcc_mWh` | 1160 + ch×8 |

Integrated on CPU1 in `C1()` from `Isense_A` / `Vsense_V` — the **16-bit
ADS131M08**, not the 12-bit path in the stats block — at the C1 rate of
6.667 Hz (`TASKC_FREQ_HZ / 3`, since the C tasks rotate C1→C2→C3 off one
20 Hz timer). Published through `cpu1Status` and mirrored by CPU2 like every
other CPU1-produced value.

Each direction accumulates **positive magnitude** into its own pair, so a
charge then a discharge on one slot leaves two separate totals. **A pair is
zeroed only when its own direction starts** (`modeCallback()`, propagated to
group followers) — never on stop, on trip, or on a mode write that does not
start the slot. Accumulation runs only while `status[ch].running` and the
slot is not calibrating. They stay RO, so a host cannot zero them on demand;
the start-of-direction reset is what replaces that.

---

## Key source files

| File | Core | Responsibility |
|---|---|---|
| `registers.h` | both | Register enum, block macros, status bits, cal protocol enums, IPC structs |
| `registers.c` | both | `regConfig[]`, `uartRegConfig[]`, message-RAM placement pragmas |
| `com_cpu2.c` | CPU2 | I2C target + controller, F-RAM, ADS1119, AT console, CAN, deferred work |
| `bts_cpu1.c` | CPU1 | Main, ISRs, A/B/C task machine, `modeCallback`, calibration state machine, trips |
| `bts.c` / `bts.h` | CPU1 | Control loops, `BTS_updateReference`, `calState` handling, SFRA |
| `bts_hal.c` | CPU1 | PWM/ADC/SPI/GPIO/trip-zone setup, pin mux for both cores |
| `bts_user_settings.h` | both | Build mode, lab type, trip enables, averaging factors |
| `bts_user_calibration.h` | both | Per-channel **boot defaults** only — no longer a calibration mechanism |
| `led_driver.c/h` | CPU2 | WS2812B status indication |
| `esp32-btle-proxy/.../bts_regs.h` | ESP32 | Hand-maintained mirror of the register map |

---

## Development rules

- **Never insert a register mid-map.** Hosts hard-code byte addresses; every
  addition appends above the current top (1216). Adding one means updating,
  together: the enum, the `NUM_*` count, `TOTAL_REGISTERS`, `regConfig[]`,
  `uartRegConfig[]` (both are sized `TOTAL_REGISTERS` and must stay
  index-aligned), the ESP32 `bts_regs.h` mirror, and `Docs/api-specification.md`.
- **Index through the `BTS_*_BASE(ch)` macros.** The blocks do not share a
  stride (control 10/ch, stats 6/ch, temperature 2/ch, calibration 12/ch,
  sense 2/ch, cell-temp 1/ch, plus three unit-scoped blocks). Assuming ten
  registers per channel everywhere is the single most common bug in this
  codebase and produced silent cross-channel corruption.
- **A new CPU1-visible register costs `CPU2TOCPU1RAM`.** Check the map.
- **If CPU1 needs to act on a register write, add it to the decode.**
  `BTS_HandleRegisterWrite()` only decodes the control block, the calibration
  block and `eCalCommand`. Everything else — including `eCalibrationMode` —
  has its `IPC_FLAG0` acked and silently discarded.
- **Never write F-RAM from an ISR.** Set a pending flag and let
  `BTS_serviceDeferredWork()` in the idle loop do it. Both the
  `eCalibrationMode` commit and `CAL_CMD_COMPUTE_SAVE` use this pattern; a
  synchronous write inside the I2C target ISR held off the host mid-transaction.
- **Validate before every F-RAM write.** `validateCalibration()` checks the
  two-field header, the temperature window, the F28 gains, the Iout/Vout gain
  windows, the reciprocal-pair agreement and the CRC-32. All of it.
- **Do not hard-code pins outside the HAL / init functions** — the `#define`s
  in `bts_user_settings.h` exist for this. Note that all pin muxing for
  *both* cores happens on CPU1 (`BTS_HAL_setupCpu2Pins`); the mux registers
  are not writable from CPU2.
- **Build through the CCS MCP `buildProject` tool.** Both configurations, then
  check the maps.
