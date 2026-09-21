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
source disagree, the source wins — `Docs/api-specification.md` §2.11 already
records the known disagreements, including a live one in the ESP32 mirror.

| Question | Read |
|---|---|
| Complete I2C register map, HTTP API, wire formats, dead registers | `Docs/api-specification.md` |
| Full GATT spec, characteristic layouts, notify behaviour | `Docs/ble-specification.md` |
| The calibration contract — opcodes, maths, safety rules, RAM budget | `Docs/calibration-design.md` |
| Operator bench procedure, wiring, troubleshooting | `Docs/README.md`, `Docs/calibration-flow.md` |
| **PIE / ACK / XINT / Input X-BAR / ADC base allocation — who owns what** | **`Docs/hardware-resources.md`** |
| IPC mechanics, core split, message-RAM discipline, trip identification | `references/ipc-and-core-responsibilities.md` |
| I2C operational notes, pad byte, target watchdog, ESP32 patterns | `references/i2c-interface-spec.md` |
| AT console — and why it may not exist in your build | `references/uart-at-commands.md` |
| F-RAM layout, header/CRC contract, load/save flow, defaults | `references/calibration.md` |

---

## Read this before touching anything

Nine facts that invalidate the obvious guess. Each is confirmed in source.

0. **The register map is v2, and every v1 address is wrong.** Three regions
   — runtime (base 0, stride 48 B, RO), settings (base 384, stride 96 B),
   unit (1152–1256) — replacing v1's nine scattered blocks. **315 registers,
   top address 1256.** A slot's live data is now one contiguous 12-register
   burst, which took the ESP32 poll cycle from 33 transactions to 9. There is
   no compatibility window: the C2000 and any host flash together. Complete
   map: `Docs/api-specification.md` §2.8.

1. **`eChX_CellVoltage` / `eChX_CellCurrent` are the 12-bit internal ADC**,
   not the 16-bit ADS131M08 — the opposite of what the naming suggests. The
   ADS131M08 engineering values (`Vsense_V` / `Isense_A`) are the
   `eChX_SenseVoltage` / `eChX_SenseCurrent` pair, two registers along in the
   same runtime block. They are what the CC loop regulates against and what
   the accumulators integrate.

2. **The storage device is an FM24V10 F-RAM, not an EEPROM.** The functions
   are still called `readEEPROM` / `writeEEPROM` and the macros still say
   `EEPROM_*` (`com_cpu2.c:88-106`). It is 128 KiB, byte-writable, with no
   page-write delay — which is why a save can be a single block write, and
   why a 6 s periodic state save needs no wear-levelling.

3. **The two header files use identical names for different things.** See the
   collision table below. Copying a line between `registers.h` and
   `bts_regs.h` compiles and is silently wrong. **They have drifted before** —
   see that section for the failure mode.

4. **The build is CC-only.** `BTS_LAB_TYPE = BTS_LAB_CLOSED_LOOP_ACMC_IOUT`
   (`bts_user_settings.h:305`) selects `BTS_ISR_CL_MODE_CC`, so the CV loop
   and the CC-CV crossover are compiled out. `voutRef_pu` is computed every
   millisecond and ignored.

5. **Every hardware over-current trip is disabled.**
   `BTS_TRIP_HW_CH1..8_ENABLED (false)` (`bts_user_settings.h:113-120`). The
   only over-current protection left is the software check in
   `BTS_tripEpwm()`, which acts within a control period rather than a
   switching cycle. **The host watchdog is not a substitute** — it is a
   supervision timeout measured in seconds. Do not run unattended
   high-current tests. See `bts_user_settings.h:74-111` for why the trips are
   masked (TZ1/TZ2 are hardwired to Input X-BAR INPUT1/INPUT2, which sit at
   their GPIO0 reset default — channel 1's trip zone was watching its own
   gate drive).

6. **The Input X-BAR is device-global, not per-core.** Each core has its own
   PIE vector, but `GPIO_setInterruptPin()` writes the **single shared Input
   X-BAR**. Both cores used to claim XINT1/XINT2, so CPU2's `initADS1119()`
   ran last and silently disconnected the SPI ADCs' DRDY interrupts. Fixed:
   CPU1 now owns XINT3/XINT5, CPU2 keeps XINT1/XINT2. Allocation tables, the
   remaining INPUT14 contention and the rest of the device-global resources:
   **`Docs/hardware-resources.md`**.

7. **`ADC_readResult()` takes the RESULT base, not the control base.**
   `ADCxRESULT_BASE` (`0x0B00`, `0x0B20`, …), not `ADCx_BASE` (`0x7400`, …).
   Every *other* ADC API takes the control base, so the wrong one reads
   naturally and **compiles, links and runs** — driverlib only `ASSERT`s it.
   What comes back is ADCCTL1/ADCCTL2, which is where a constant **8320
   (0x2080)**, identical on all eight slots and never moving, came from. A
   value that quiet is never a real conversion.

8. **The ACK group follows the interrupt's PIE group, not the handler's
   work.** `Interrupt_clearACKGroup()` re-opens one group; ack the wrong one
   and the real group stays latched forever — the interrupt fires **exactly
   once** and then stops, with no fault and no log. CPU1's DRDY handlers ack
   `GROUP12` because `INT_XINT3`/`INT_XINT5` are 12.1/12.3, regardless of the
   SPI peripheral they service. Read the group out of the `hw_ints.h`
   constant. **CPU Timer 1/2 go direct to INT13/INT14 and must not ack at
   all**; Timer 0 is a PIE interrupt and must. Table:
   `Docs/hardware-resources.md` §2.

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
| `CPU2TOCPU1RAM` | `0x03F800` | CPU2 | `ipcMsg`, `supervision`, `calValidFlags[8]`, `registers[TOTAL_REGISTERS]` |
| `CPU1TOCPU2RAM` | `0x03FC00` | CPU1 | `startup_mode`, `startup_enable`, `canData[8]`, `cpu1Status` |

CPU1 **never writes** `registers[]`, with exactly one deliberate exception:
`modeCallback()` sets `eCalSlot` when mode bit 2 routes a channel into
calibration. Everything else CPU1 produces travels through `cpu1Status` under
its `seq` seqlock and is mirrored in by CPU2.

`supervision` is the CPU2 → CPU1 mailbox that carries the watchdog and the
boot restore: `wdPauseSeq`, bumped once per watchdog expiry, and
`restoreFlags`, three bits per slot. CPU2 writes it; **CPU1 performs the
actual pause**, because CPU2 must never touch a slot's control state.

`calibrationData[]` is **no longer shared** — it is CPU2-private `.bss`
(`registers.c:39`, at `0x0000a000` in both maps). Only the persisted validity
flags cross, as `calValidFlags[8]`, because CPU1 needs them for the display
ticks after a power cycle.

**`CPU2TOCPU1RAM` is the binding constraint on any new shared register.** The
v2 map's 315 registers cost 630 words on their own. Current occupancy, read
from the map files after the v2 build:

| Block | Used | Free |
|---|---|---|
| `CPU2TOCPU1RAM` | 790 words (`0x316`) | **234 words** (`0x0EA`) |
| `CPU1TOCPU2RAM` | 508 words (`0x1FC`) | 516 words (`0x204`) |

Overflow is a link-time failure (`#10099-D ... section
"MSGRAM_CPU2_TO_CPU1"`), not a runtime one — but check the `.map` after
adding anything shared, and confirm every shared symbol resolves to the same
address in `cpu1/*.map` and `cpu2/*.map`.

**Verified after the v2 build:** both cores build clean and all eight shared
symbols — `registers`, `ipcMsg`, `calValidFlags`, `supervision`, `canData`,
`cpu1Status`, `startup_mode`, `startup_enable` — resolve to identical
addresses in both map files.

Full IPC contract, flag allocation, boot and calibration data flows, interrupt
ownership, register strides and trip-source identification:
`references/ipc-and-core-responsibilities.md`. The allocation tables it points
at — PIE, ACK groups, XINT, Input X-BAR, ePWM/CMPSS routing, ADC bases — live
in `Docs/hardware-resources.md`, which is authoritative for all of them.

---

## System operation

8 independent bidirectional synchronous buck/boost slots. Each supports charge
and discharge with independent voltage/current limits, a min/max cell
temperature window and trip protection.

- `eChX_Mode` (settings offset 0) encodes run + direction + calibration entry
  + pause/resume. Bit 0 = run, bit 1 = **charge** (clear = discharge), bit 2 =
  enter calibration, bit 3 = **pause**, bit 4 = **resume**. Note the
  asymmetry: `0x00` is stop and `0x01` is *start a discharge*, one bit apart.
  Bits 3 and 4 are **edge commands** — acted on at the write, not retained,
  handled before the run/stop decode.
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
  flash for the slot under calibration and a flash for a paused slot. **`BTS_LED_DRIVER_ENABLED`
  is currently `false`** — see the console note below.
- Calibration coefficients, global voltage thresholds **and per-slot run
  state** persist in the FM24V10 F-RAM and load at boot.

### The slot state model

A slot is in exactly one of **five** states. `PAUSED` is **not a direction**:
it sits alongside `CHARGING` or `DISCHARGING`, so a host sees both that the
slot is held and what a resume would do.

| State | Meaning | Bits |
|---|---|---|
| **STOPPED** | Idle. Converter off. Counters hold their last values | `STOPPED` |
| **CHARGING** | Running, delivering charge | `RUNNING` + `CHARGING` |
| **DISCHARGING** | Running, drawing charge | `RUNNING` + `DISCHARGING` |
| **PAUSED** | Converter off, direction remembered, counters frozen and intact | `RUNNING` + `PAUSED` + direction (+ `WD_TRIPPED` or `RESTORED`) |
| **END** | Test finished normally. Converter off, counters hold final values | `STOPPED` + `FINISHED` |

`slotIsRunning(ch)` is `running && !paused` (`bts_cpu1.c:161`) — that is the
test for "actually delivering power", and it gates the counters.

```
  STOPPED ──start(charge)──────> CHARGING
  STOPPED ──start(discharge)───> DISCHARGING

  CHARGING/DISCHARGING ──watchdog timeout──> PAUSED (+WD_TRIPPED)
  CHARGING/DISCHARGING ──pause command─────> PAUSED
  CHARGING/DISCHARGING ──trip/fault────────> STOPPED
  CHARGING/DISCHARGING ──termination───────> END

  PAUSED ──resume command──> CHARGING or DISCHARGING  (whichever it held)
  PAUSED ──stop command────> STOPPED
  END    ──start───────────> CHARGING or DISCHARGING
  boot with a saved run ───> PAUSED (+RESTORED)
```

Three rules that are easy to break:

- **Entering PAUSED zeroes the converter reference first**, then clears
  `enable_logic`. Same ordering as a trip exit — the control loop may run
  between the two writes (`slotPause()`, `bts_cpu1.c:171`).
- **`RUNNING` stays set through a pause.** A pause is a held run, not a stop,
  and the direction bit has to survive so a resume knows which way to go.
- **`slotStop()` clears the pause and END indications too**, so a host that
  stops a paused slot gets a clean STOPPED rather than a mixture.

> **`END` is bit 2, not bit 16.** `BTS_STATUS_END` is an **alias for
> `BTS_STATUS_FINISHED`** — that bit was declared from the start and never
> driven, so it was given the END meaning rather than spending a second bit.
> Bit 16 is unused and reads a constant 0. An early revision of the ESP32
> header defined END at bit 16; that is stale.
>
> The bit is now driven end to end, but **no C2000 path currently asserts
> it**: `status[].finished` is cleared on start, pause and stop, and restored
> from F-RAM at boot, but termination is still the ESP32's job.
> `iref_cuttout_A` is loaded from `eChX_ChargeCurrentMin` and never read.

### Counters

Six per slot, two independent sets of {mAh, mWh, seconds}, all in the runtime
block and all RO. Integrated on CPU1 in `C1()` at 6.667 Hz from `Isense_A` /
`Vsense_V` — the **16-bit ADS131M08**, not the 12-bit path. Each direction
accumulates **positive magnitude** into its own set, so a charge then a
discharge leaves two separate totals. The seconds counter advances on the
same timestep as its set's mAh and mWh.

- **Advance only while `slotIsRunning(ch)` and not calibrating.** Paused,
  stopped, ended and tripped slots freeze.
- **Reset only on a fresh start**, and only the starting direction's set:
  `STOPPED → run` and `END → run` zero one set; a **resume zeroes nothing**,
  and so do a trip, a fault and a watchdog pause (`accResetDirection()`,
  `bts_cpu1.c:139`). In a group the leader's reset propagates to followers.
- **Survive a reset**, through the F-RAM state block below.

### Host watchdog

A 30 s supervision timeout (`eHostWatchdog_s`, 1196, RW; **0 disables**). On
expiry every slot that is `CHARGING` or `DISCHARGING` pauses with
`WD_TRIPPED` set. The live countdown is `eWatchdogRemaining_s` (1220, RO),
which reads 0 both when fired **and** when disabled — read the timeout beside
it to tell them apart.

**Four reload hooks, one per interface**, and the fourth is the one that
matters:

| Interface | Hook |
|---|---|
| I2C register **write** | `applyHostRegisterWrite()` (`com_cpu2.c:2553`) |
| I2C register **read** | `i2cSlaveFifoISR()` **transmit branch** (`com_cpu2.c:2915`) |
| UART AT | via `applyHostRegisterWrite()` |
| CAN | via `applyHostRegisterWrite()` |

The read hook exists because a polling host proves it is alive by **reading**.
The ESP32's steady state is nine read transactions every 250 ms and not a
single write, so a unit that reloaded on writes alone would pause every
running slot 30 s after the last mode command while the link was healthy.
**Verified on hardware:** `eWatchdogRemaining_s` holds at 30.0 while the
ESP32 polls.

**CPU2 owns the countdown, CPU1 performs the pause.** CPU2 has the interfaces
and the timebase (`hostWatchdogTick()` in the 8 Hz `timerISR`), but it must
never write a slot's control state — it bumps `supervision.wdPauseSeq` and
`serviceHostWatchdog()` on CPU1 acts on it.

> **Not a substitute for the trip system.** Seconds, not switching cycles.
> Hardware trips are off and `BTS_tripEpwm()` is still the only fast
> protection.

### F-RAM slot state persistence

Every **6 s** and on each state transition, CPU2 saves a per-slot record —
direction, END flag and all six counters, with a CRC-32.

```
0x0000 - 0x03FF   calibration, 8 channels x 128 B stride
0x0400 - 0x040F   global voltage thresholds
0x0500 - 0x05FF   slot runtime state, 8 slots x 32 B stride
```

`STATE_FRAM_BASE 0x0500`, `STATE_FRAM_STRIDE 32` — a fixed stride decoupled
from `sizeof`, for the same reason as the calibration block. Writes are
deferred to `BTS_serviceDeferredWork()`, one slot per pass, so the eight
stagger across the window and never hold the I2C controller for eight
transfers at once. A **paused** slot is saved as running in its held
direction.

Boot restore (`loadSlotStates()`, `com_cpu2.c:1272`):

| Record | Result |
|---|---|
| Invalid or absent | `STOPPED`, counters zeroed. **The normal first-boot case — do not log it as an error** |
| Valid, was STOPPED or END | Counters and that state restored |
| Valid, was CHARGING or DISCHARGING | Counters restored, slot comes back **`PAUSED` + `RESTORED`**, converter off |

> ### A slot never resumes power by itself after a reset
>
> The safety-critical rule. The cell may have been swapped while the unit was
> off. `applyRestoredSlotStates()` calls `slotStop()` then `slotPause()` — it
> cannot re-energise a slot. **Verified on hardware:** a slot came back
> `PAUSED` + `RESTORED` with its counters kept and refused to auto-resume.

One IPC flag is raised after the whole file is consistent, not one per slot.
Periodic saves are **armed only once CPU1 acknowledges the restore**, so a
6 s tick cannot overwrite a record before it has been applied.

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
| `true` (current) | SCIRXDA | SCITXDA | **SCIA, see the baud warning** | off | off |
| `false` | ch1 trip in | WS2812B TX | **none** | on | on |

> ### The console's real baud rate is ~7267, not 115200
>
> **Open-issue, root cause not established.** `BTS_CONSOLE_BAUDRATE` is
> `115200` and `SCI_setConfig()` computes BRR = 42 from
> `DEVICE_LSPCLK_FREQ` — which by the arithmetic should give about
> 145 kbaud, already not 115200. In practice the console only works when the
> host connects at **approximately 7267 baud**; at 115200 every received byte
> is framing garbage (observed 254, 248, 254, 245 … where `A`, `T`, `+` were
> sent).
>
> The working rate implies the real LSPCLK is far lower than
> `DEVICE_LSPCLK_FREQ` claims. This has **not** been confirmed: reading
> `ClkCfgRegs` over JTAG returned all zeros, a known artefact on this part
> when the registers are read while the core is running. **Halt the core
> before judging the PLL**, and do not change the baud constant until the
> clock tree has been read properly — the same LSPCLK feeds SPI and the LED
> driver's 800 kbaud timing.

New registers become addressable through `uartRegConfig[]` automatically, so
v2's additions already have names: `C<n>CHS` / `C<n>DHS` for the per-slot
run-time seconds, `WD` for the watchdog timeout and `WDREM` for the
countdown. Pause and resume have explicit commands —
**`AT+C<n>PAUSE` / `AT+C<n>RESUME`** — rather than making an operator compute
a mode bitmask to stop a cell safely.

**Verified on hardware:** `AT+WD?` → `+WD=30.00`; `AT+C0CHS?`, `AT+C0PAUSE`
and `AT+C0RESUME` all answer `OK`.

> **Known bug:** the console periodically prints `WARNING: host watchdog
> DISABLED` even when `eHostWatchdog_s` reads 30.0 and the countdown is
> healthy. `hostWdDisableWarn` is set only where a write of `0.0` arrives
> (`com_cpu2.c:2573`) and reads 0 when sampled, so the trigger has not been
> found. Cosmetic — supervision is verifiably armed — but alarming and wrong.

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
telemetry streams through the window at 1224-1256.

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
build coupling**.

> ### They have drifted before — check the mirror when either changes
>
> In the v2 reorder `bts_regs.h` lost `eWatchdogRemaining_s` (1220), which put
> every calibration telemetry address in it 4 bytes low: telemetry at
> 1220–1252 against the C2000's 1224–1256, `BTS_TOTAL_REGISTERS` 314 against
> 315, and `BTS_CAL_WINDOW_COUNT` 14 against a 15-register window.
>
> `poll_cal_window()` would have misdecoded every telemetry value during a
> bench calibration, shifted by one register — and **only** during one, since
> that window is read only while calibration is live. Normal polling looked
> perfectly healthy. Found and fixed 2026-09-20.
>
> The lesson stands: when either file changes, diff them register by register.
> `registers.h` is authoritative; fix the mirror against it, never the
> reverse. Details: `Docs/api-specification.md` §2.11.

Every region base, stride and per-slot offset otherwise agrees, and so do the
opcode, result-code and status-bit numbering. But three identifier families
mean different things in the two files:

| Identifier | `registers.h` (C2000) | `bts_regs.h` (ESP32) |
|---|---|---|
| `BTS_STATUS_*` | bit **positions** (`0U`, `1U`, …) | bit **masks** (`1u << 0`, …) |
| `BTS_CAL_ST_*` | bit **positions** | bit **masks** |
| `BTS_RT_*`, `BTS_SET_*`, `BTS_CAL_F28V_GAIN` … | register **index** offsets (0, 1, 2 …) | **byte** offsets (0, 4, 8 …) |
| `BTS_RT_BASE`, `BTS_SET_BASE` | function-like macros returning an **index** | bare constants `0` and `384`, **byte addresses** |

Each convention is self-consistent — the C2000 indexes `registers[]`, the
ESP32 addresses the wire — and the v2 reorder sharpened the trap rather than
softening it: `BTS_RT_STATUS` is `0U` in both files, while
`BTS_RT_CELL_VOLTAGE` is `1U` on the C2000 and `4` on the ESP32. **Copying a
line between these files compiles and is silently wrong.** When you change
one, change the other, and check the whole family rather than the one line
you came for.

---

## Status word

`eChX_Status`, packed by `publishStatusToCpu2()` and carried to hosts as a
`float32`. Authoritative table: `Docs/api-specification.md` §2.7.

| Bit | Name | Populated? |
|---|---|---|
| 0 | `RUNNING` | yes — **stays set while PAUSED** |
| 1 | `STOPPED` | yes |
| 2 | `FINISHED` / `END` | **driven since v2** — but nothing asserts it yet |
| 3 | `OVERCURRENT_TRIP` | never in this build |
| 4 | `CHARGING` | yes |
| 5 | `DISCHARGING` | yes |
| 6 | `CONST_VOLTAGE` | always 0 — CC-only build |
| 7 | `CONST_CURRENT` | always 1 — CC-only build |
| 8 | `SLAVE_MODE` | yes |
| 9 | `GROUP_DISCONNECT` | yes |
| 10 | `REVERSE_POLARITY` | yes |
| 11 | `SLOT_DISABLED` | yes |
| 12 | `CALIBRATING` | yes |
| 13 | `CAL_V_VALID` | yes, from **persisted** `calFlags` |
| 14 | `CAL_I_VALID` | yes, from **persisted** `calFlags` |
| 15 | `PAUSED` | **yes — new in v2** |
| 16 | — | **unused, reads a constant 0** |
| 17 | `WD_TRIPPED` | **yes — new in v2** |
| 18 | `RESTORED` | **yes — new in v2** |

Bits 6/7 were tracked in the ISR all along but never copied out, so they read
0 on every build before the calibration work. Bits 13/14 come from
`calValidFlags[]` rather than the in-session capture, so a slot calibrated in
an earlier session still shows its ticks after a power cycle.

> **The hard ceiling is bit 23.** The word reaches the host as a `float32`,
> whose 24-bit significand makes integers exact only to bit 23
> (`registers.h:418-421`). Bits 19-23 are free. Never go past 23.

---

## Declared but never written

Under v2 this list is nearly empty — most of it was either deleted or
brought to life.

| What | Status |
|---|---|
| `eChX_MinVoltage`, `eChX_MaxVoltage` | **Deleted from the map.** RO and never written on either core, 16 registers of permanent 0.0. Removing them paid for most of the 16 new run-time-seconds registers. If per-run extremes are wanted back, use the settings block's spare register — and actually write them |
| The four accumulators + two seconds counters | **Live.** All six per slot, in the runtime block. See the counters section above |
| Status bit 2 (`FINISHED` / `END`) | **Driven**, but no termination path asserts it yet |
| `eChX_SettingsSpare` | Reserved by design. RO, reads 0.0, one per slot at settings offset 23 — the place to put a future per-slot setting without moving anything |
| `iref_cuttout_A` | Still loaded from `eChX_ChargeCurrentMin` and read by nothing. CC-to-cutoff taper is the ESP32's job |
| `eTripStatus` (1180) | Still always 0. See below |
| `canData[].mAh` / `.mWh` | Populated, but `sendCANData()` still does not transmit them |

`eTripStatus` is mirrored from `cpu1Status.tripStatus`, which is only ever
written by `epwmTripISR`. That ISR is registered and enabled unconditionally,
but `BTS_HAL_setupEPWMTripZone()` masks the one-shot trip **signals** and
disables the trip-zone **interrupt** on any slot whose
`BTS_TRIP_HW_CHn_ENABLED` is false — which is all eight. So the word stays 0
until the trip links are wired and those flags are turned back on. The
software trip path forces the outputs low through the same trip zone without
going near this ISR.

The ESP32 still integrates charge and energy itself (`coulomb_counter.c`) and
reports the BTS figures beside its own, because it samples on real elapsed
time rather than the BTS's fixed 150 ms step.

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
  addition goes into the spare space its region already carries, or above the
  current top (1256). Adding one means updating, together: the enum, the
  `NUM_*` count, `TOTAL_REGISTERS`, `regConfig[]`, `uartRegConfig[]` (both are
  sized `TOTAL_REGISTERS` and must stay index-aligned), the ESP32
  `bts_regs.h` mirror, and `Docs/api-specification.md`.
  - A per-slot field goes in its region's spare space — runtime has none, so
    a new runtime field means a stride change and another breaking reorder;
    settings has one spare register per slot precisely so it does not.
- **Index through the `BTS_RT_BASE(ch)` / `BTS_SET_BASE(ch)` macros.** The two
  per-slot regions have **different strides** — 12 registers and 24. Mixing
  them is the single most common bug in this codebase and produces silent
  cross-channel corruption rather than an error.
- **A new CPU1-visible register costs `CPU2TOCPU1RAM`** — two words each,
  234 words free. Check the map.
- **If CPU1 needs to act on a register write, add it to the decode.**
  `BTS_HandleRegisterWrite()` decodes the settings region (the mode register
  and the calibration group) and `eCalCommand`. Everything else — including
  `eCalibrationMode` and `eHostWatchdog_s` — has its `IPC_FLAG0` acked and
  silently discarded. The runtime region is RO and never reaches the decode.
- **Never write F-RAM from an ISR.** Set a pending flag and let
  `BTS_serviceDeferredWork()` in the idle loop do it. The `eCalibrationMode`
  commit, `CAL_CMD_COMPUTE_SAVE` and the 6 s slot-state save all use this
  pattern; a synchronous write inside the I2C target ISR held off the host
  mid-transaction.
- **CPU2 must never write a slot's control state.** The single-writer rule
  applies to control as well as to memory. The watchdog and the boot restore
  both go through `supervision` as a flag, and CPU1 performs the action.
- **Validate before every F-RAM write.** `validateCalibration()` checks the
  two-field header, the temperature window, the F28 gains, the Iout/Vout gain
  windows, the reciprocal-pair agreement and the CRC-32. All of it. The slot
  state block has its own header + CRC check with the same discipline.
- **Do not hard-code pins outside the HAL / init functions** — the `#define`s
  in `bts_user_settings.h` exist for this. Note that all pin muxing for
  *both* cores happens on CPU1 (`BTS_HAL_setupCpu2Pins`); the mux registers
  are not writable from CPU2.
- **Build through the CCS MCP `buildProject` tool.** Both configurations,
  then check the maps.

### Build and debug notes

- **Starting a debug session loads only `cpu1`.** CPU2 keeps running whatever
  was in its RAM. Since CPU2 owns I2CA, a CPU1-only reload leaves the ESP32
  link dead while CPU1 looks perfectly healthy. Load CPU2's `.out`
  explicitly, then restart.
- **Do not halt CPU2 mid-I2C-transaction.** A breakpoint that stops the core
  while the host-facing target is part way through a transfer leaves the I2C
  target **wedged**: SCL held low with `BUS_BUSY` set and no interrupt
  pending. `serviceI2CTargetWatchdog()` cannot recover it, because that runs
  from the idle loop of the core you just stopped. The ESP32 link does not
  come back without a reload or a power cycle. If you must break on CPU2,
  break somewhere the I2C ISR is not active.
- **After building, confirm every shared symbol resolves to the same address
  in `cpu1/*.map` and `cpu2/*.map`** — there are eight: `registers`,
  `ipcMsg`, `calValidFlags`, `supervision`, `canData`, `cpu1Status`,
  `startup_mode`, `startup_enable`.
