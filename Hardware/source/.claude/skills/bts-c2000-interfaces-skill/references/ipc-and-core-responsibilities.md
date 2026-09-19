# BTS Inter-Processor Communication and Core Responsibilities

Authoritative reference for how CPU1 and CPU2 divide the work on the
TMS320F28379D, and how they exchange data. Every mechanism below is
cross-checked against the TI device documentation and the C2000Ware driverlib
headers shipped with the Digital Power SDK 5.03.00.00.

Sources used for verification:

| Fact | Verified against |
|------|------------------|
| Message RAM base addresses | `driverlib/f2837xd/driverlib/inc/hw_memmap.h` — `CPU1_TO_CPU2_MSG_RAM_BASE`, `CPU2_TO_CPU1_MSG_RAM_BASE` |
| Message RAM ownership | `2837xD_RAM_lnk_cpu1.cmd` / `..._cpu2.cmd` (the `PUTBUFFER` / `GETBUFFER` GROUPs) |
| IPC API surface | `driverlib/f2837xd/driverlib/ipc.h` |
| PIE group assignments | `driverlib/f2837xd/driverlib/inc/hw_ints.h` |
| Trip-zone flag semantics | `driverlib/f2837xd/driverlib/epwm.h` |
| RAM occupancy | `cpu1/bts_F2837xD_8ch_cpu1.map`, `cpu2/bts_F2837xD_8ch_cpu2.map` |

---

## 1. Core responsibility split

### CPU1 — the "BTS CPU" (real-time control)

Owns everything with a hard deadline.

- 8 × synchronous bidirectional buck/boost control loops (DCL FPU32, HRPWM)
- External SPI ADC acquisition (`ISR1`–`ISR4`), on-chip ADC cell V/I sampling
- Trip handling: CMPSS over-current and GPIO group trips via ePWM trip zones
- Background state machine (A/B/C tasks) at 1 kHz / 100 Hz / 10 Hz
- Input bus-voltage monitoring and the unit state machine
- Slot grouping: latches the MODE/ENABLE dip straps and derives leader/follower
- **The runtime calibration state machine** — `calState`, the capture set, the
  two-point maths, the dead-man timeout
- Boots CPU2 (`Device_bootCPU2`) and mux-configures the pins for **both** cores
- Recalculates program variables when CPU2 signals a calibration change

CPU1 **never writes** `registers[]`, with one deliberate exception:
`modeCallback()` sets `eCalSlot` when mode bit 2 routes a channel into
calibration (`bts_cpu1.c:1031`), so that both calibration entry points land in
the same handler. It is otherwise a consumer of configuration and a producer
of measurements.

### CPU2 — the "com CPU" (communications and configuration)

Owns everything external-facing and non-volatile.

- I2CA target (address 0x50) — host / ESP32 register access
- I2CB controller — FM24V10 F-RAM (0x50) and two ADS1119 temperature ADCs
  (0x40, 0x41), on **GPIO40/41**
- SCIA — the AT command console, **only in a `BTS_DEBUG_CONSOLE` build**
- SCIA — WS2812B status LEDs, **only in a production build**. The two uses are
  mutually exclusive: they need the same pin.
- CANA at 500 kbit/s, extended IDs from `0x1C000000` — telemetry and register
  access
- Boot-time calibration load, runtime calibration save, deferred F-RAM writes
- **Sole writer of `registers[]`**

---

## 2. Shared memory

The F2837xD provides two dedicated message RAM blocks. Each is writable by
exactly one core and readable by both — this single-writer rule is the
foundation of the whole design, and is why the register file lives on CPU2.

| Block | Address | Length | Writer | Reader |
|-------|---------|--------|--------|--------|
| `CPU2TOCPU1RAM` | `0x03F800` | `0x400` (1024 words) | CPU2 | CPU1 |
| `CPU1TOCPU2RAM` | `0x03FC00` | `0x400` (1024 words) | CPU1 | CPU2 |

### Objects in CPU2 → CPU1 RAM (CPU2 writes)

| Symbol | Address | Purpose |
|--------|---------|---------|
| `ipcMsg` | `0x03F800` | Single-register mailbox: `{regAddr, value}` |
| `calValidFlags[8]` | `0x03F804` | Persisted `calFlags` per channel, for status bits 13/14 |
| `registers[TOTAL_REGISTERS]` | `0x03F814` | The register file — the single source of truth |

### Objects in CPU1 → CPU2 RAM (CPU1 writes)

| Symbol | Address | Purpose |
|--------|---------|---------|
| `startup_mode`, `startup_enable` | `0x03FC00` | Strap-pin state latched at boot |
| `canData[8]` | `0x03FC04` | Per-channel telemetry for CAN transmission |
| `cpu1Status` | `0x03FC80` | Everything else CPU1 publishes — see §2.2 |

### 2.1 `calibrationData[]` is no longer shared

It used to live in `CPU2TOCPU1RAM` at 256 words. It is now **CPU2-private
`.bss`** (`registers.c:39`, resolving to `0x0000a000` in both maps).

The reason is a hard limit. Before the calibration work, `CPU2TOCPU1RAM` held
914 of its 1024 words. The 30 new registers cost 60 more and the two added
`BTS_channelCalibration` fields another 16, which overflowed the block:

```
#10099-D ... section "MSGRAM_CPU2_TO_CPU1" size 0x88
```

Every float in `calibrationData[]` is also published through `registers[]`,
which is what CPU1 actually reads, so the full image had no reason to be
shared. Only the persisted validity flags cross, as `calValidFlags[8]`.

**Current occupancy, read from the map files:**

| Block | Used | Free |
|---|---|---|
| `CPU2TOCPU1RAM` | 734 words (`0x2DE`) | **290 words** (`0x122`) |
| `CPU1TOCPU2RAM` | 412 words (`0x19C`) | **612 words** (`0x264`) |

`CPU2TOCPU1RAM` is the binding constraint on any new shared register: 30
registers cost 60 words. Overflow is a link-time failure, not a runtime one,
so the cost of getting it wrong is a rebuild — but **check the map** rather
than guessing.

### 2.2 `BTS_cpu1Status`

One struct, one writer, guarded by a seqlock (`registers.h:633-679`). It
carries, in addition to the obvious status/measurement fields:

- `strapsValid`, `slotMode`, `slotEnable`, `groupSize` — the dip straps.
  Carried **inside** the struct rather than read from the bare globals so they
  inherit the `seq` guard: the two cores boot independently, `CPU1TOCPU2RAM`
  is `NOLOAD` from CPU2's side, and its power-up contents are not guaranteed
  zero. `strapsValid` stays 0 until CPU1 has latched.
- `senseVoltage[8]`, `senseCurrent[8]` — the ADS131M08 engineering values,
  which had no path to a host at all before the sense block was added.
- `calActiveSlot`, `calStatus`, `calResult`, `calTelemetry[8]` — the
  calibration window.
- `calSaveSeq`, `calSaveSlot`, `calSaveFlags`, `calComputed[12]` — the
  compute-and-save handshake. CPU1 fills `calComputed` in
  `BTS_CAL_F28V_GAIN`…`BTS_CAL_VOUT_OFFSET_V` order and then **bumps
  `calSaveSeq`**; CPU2 compares against its own `calRuntimeSaveSeqSeen` and
  acts exactly once. A sequence counter rather than a flag, so a missed poll
  does not lose the result and a repeated poll does not double-write.

### 2.3 Linker requirements

Both `2837xD_RAM_lnk_cpu1.cmd` and `2837xD_RAM_lnk_cpu2.cmd` declare the
**same origins and lengths**, and place the application sections plus the
driverlib `MSGRAM_*` sections. The block a core does not own is marked
`TYPE = NOLOAD` so its image never initialises memory belonging to the other
core:

```
/* CPU1 linker file */
CPU1TOCPU2RAM       : > CPU1TOCPU2RAM, PAGE = 1                  /* we write */
CPU2TOCPU1RAM       : > CPU2TOCPU1RAM, PAGE = 1, TYPE = NOLOAD   /* they write */
MSGRAM_CPU1_TO_CPU2 : > CPU1TOCPU2RAM, PAGE = 1
MSGRAM_CPU2_TO_CPU1 : > CPU2TOCPU1RAM, PAGE = 1, TYPE = NOLOAD
```

The CPU2 file is the mirror image. Omitting these produces linker warning
`#10247-D: creating output section "..." without a SECTIONS specification`,
which silently places shared data at an address the other core does not agree
on.

`NOLOAD` has a runtime consequence as well as a link-time one: memory a core
does not own is **not zero-initialised from its image**, so anything it reads
out of the other core's block before that core has written it is whatever the
RAM powered up holding. Both `strapsValid` and the explicit
`calValidFlags[ch] = 0` at the top of `loadCalibration()` exist for this
reason.

**Verification:** after building both configurations, confirm every shared
symbol resolves to the same address in `cpu1/*.map` and `cpu2/*.map`. They
currently agree:

```
ipcMsg          0003f800    calValidFlags   0003f804
registers       0003f814    startup_mode    0003fc00
canData         0003fc04    cpu1Status      0003fc80
```

The driverlib IPC `PUTBUFFER`/`GETBUFFER` GROUPs are separate from the
application sections and must keep the orientation TI specifies: each core's
`PUTBUFFER` goes in *its own* "TO" RAM, and its `GETBUFFER` is a `DSECT` in
the other core's RAM.

---

## 3. IPC flags

`IPC_FLAG0`–`IPC_FLAG31` are hardware flag bits; the BTS uses three, all in
the CPU2 → CPU1 direction. Symbolic names are in `registers.h:620-622`:

| Macro | Flag | Meaning | Payload |
|-------|------|---------|---------|
| `BTS_IPC_FLAG_REG_WRITE` | `IPC_FLAG0` | One register changed | `ipcMsg` |
| `BTS_IPC_FLAG_TEMP_UPDATE` | `IPC_FLAG1` | Cell temperature refreshed | `ipcMsg` |
| `BTS_IPC_FLAG_CAL_RELOAD` | `IPC_FLAG2` | Whole calibration block reloaded | none |

CPU1 → CPU2 has **no flags at all**. Everything in that direction travels
through `cpu1Status` under the seqlock and is polled by CPU2's 8 Hz timer ISR.

### Correct driverlib API

| Operation | Function |
|-----------|----------|
| Raise a flag to the remote core | `IPC_setFlagLtoR(type, flag)` |
| Check whether our flag is still pending | `IPC_isFlagBusyLtoR(type, flag)` |
| Check whether the remote raised a flag | `IPC_isFlagBusyRtoL(type, flag)` |
| Acknowledge and clear a remote flag | `IPC_ackFlagRtoL(type, flag)` |

`type` is `IPC_CPU1_L_CPU2_R` on CPU1 and `IPC_CPU2_L_CPU1_R` on CPU2.

**`IPC_clearFlagRtoL` does not exist.** The receiver clears with
`IPC_ackFlagRtoL`. Calling the non-existent name compiles (implicit
declaration) and fails at link with `#10234-D: unresolved symbols remain`.

### Discipline

- **Write data before raising the flag.** `registers[]` is in CPU2's RAM, so
  by the time CPU1 observes the flag the value has settled.
- **The sender must not block.** `notifyCpu1RegisterWrite()` skips the
  notification if the previous flag is still unacknowledged, because CPU1
  re-reads the affected block from `registers[]` anyway. A blocking
  `while (IPC_isFlagBusyLtoR(...))` inside an ISR — as an earlier revision of
  `loadCalibration` did — deadlocks if CPU1 is not yet running.
- **One notification per logical change.** Boot sends a single
  `BTS_IPC_FLAG_CAL_RELOAD` after the whole register file is populated, rather
  than one flag per register against a half-built file.
- **A skipped notification must be harmless.** It is, because every consumer
  re-reads from `registers[]` — except `eCalCommand`, whose opcode travels in
  the `ipcMsg` payload and whose register self-clears. That one is a real
  single-shot, and it is why CPU2 clears `eCalCommand` only *after*
  `notifyCpu1RegisterWrite()` has staged the payload.

### 3.1 CPU1's decode is partial, and that matters

`BTS_HandleRegisterWrite()` (`bts_cpu1.c`) decodes exactly three cases:

```c
if (regIdx < BTS_REG_IDX(eCh0_ChargeAcc_mAh))           → control block, modeCallback()
else if (regIdx within BTS_CAL_BASE(0)..+96)            → calibration block reload
else if (regIdx == BTS_REG_IDX(eCalCommand))            → calHandleCommand()
```

Everything else — including `eCalibrationMode` at index 244 — has its flag
acked and is **silently discarded**. That is correct for registers CPU2 acts
on itself, and a trap for anything new: a register CPU1 must react to needs an
explicit branch here, or every write will be accepted by CPU2 and quietly
ignored by CPU1.

---

## 4. Data flows

### 4.1 Boot

```
CPU1: BTS_HAL_setupDevice() ... mux pins for BOTH cores ... Device_bootCPU2()
CPU2: Device_init() -> initI2C_Master()
      loadCalibration():
        for each channel:
          calValidFlags[ch] = 0          <-- before anything can observe RAM noise
          readEEPROM() -> validateCalibration()
            valid   -> applyStoredCalibration(), publish calFlags
            invalid -> applyDefaultCalibration()
        read global voltage thresholds at F-RAM 0x0400
          invalid -> 9 / 10 / 15 / 16 V defaults
        init the calibration control block (eCalSlot = 255, rest 0)
        notifyCpu1CalibrationReload()             <-- one IPC_FLAG2
CPU2: bring up I2CA / console / CAN / timer / LEDs, then EINT, banner,
      then initADS1119() last
CPU1: B3 task -> BTS_HandleRegisterWrite() sees IPC_FLAG2
        -> BTS_loadCalibrationFromRegisters(ch) for all 8 channels
        -> pendingUpdate = 1
CPU1: C2 task -> BTS_monitor_program_update(ch)
        -> BTS_calcUserProgramVariables(ch)  (trip thresholds, meas gains)
```

Interrupts on CPU2 are enabled only *after* `loadCalibration()`, so a host
write can never race the boot-time load. `initADS1119()` runs last because its
DRDY ISRs drive I2CB continuously — everything else is already up before they
start.

### 4.2 Runtime configuration change

```
Host (I2C / console / CAN)
  -> CPU2 applyHostRegisterWrite(regIdx, value)
       registers[regIdx] = value
       notifyCpu1RegisterWrite()            <-- IPC_FLAG0
       [eCalibrationMode == 2.0f  -> calibrationSavePending]
       [eCalCommand != 0          -> self-clear, clear eCalStatus bit 7]
  -> CPU1 BTS_HandleRegisterWrite()
       control register  -> modeCallback()
       calibration block -> BTS_loadCalibrationFromRegisters(ch), pendingUpdate = 1
       eCalCommand       -> calHandleCommand(opcode, registers[eCalArgument])
  -> CPU1 C2 task -> BTS_monitor_program_update(ch)
                       -> BTS_calcUserProgramVariables(ch)
```

`BTS_monitor_program_update` updates **in-memory program variables only**.
CPU1 has no F-RAM access — persistence is CPU2's job.

### 4.3 Measurement and status path (CPU1 → CPU2)

```
CPU1 adcCellVoltageISR  -> BTS_measValues[].{CellVoltage,CellCurrent}_16b
CPU1 ISR1..ISR4 (SPI)   -> BTS_measValues[].{Isense,Vsense}_16b
CPU1 C1 task (10 Hz)    -> BTS_monitor_Iout_Vout()  (averaging + gains)
                           calServiceDeadMan(), calPublishTelemetry()
                        -> publishStatusToCpu2()
                             cpu1Status.seq++      (odd = update in progress)
                             status bits, cell V/I, sense V/I, input V,
                             unit state, straps, cal window, canData[]
                             cpu1Status.seq++      (even = consistent)
CPU2 timerISR (8 Hz)    -> mirrorCpu1Status()
                             seqlock read, up to 4 attempts, give up and
                             retry next tick on a torn snapshot
                          -> registers[] status / cell V/I / sense V/I /
                             input V / unit state / trip status / straps /
                             calibration window
                          -> stage calComputed[] if calSaveSeq changed
                          sendCANData(channel)    (round robin)
CPU2 idle loop          -> BTS_serviceDeferredWork()  (the F-RAM write)
```

`cpu1Status.seq` is a seqlock: the reader retries while the counter is odd or
changed across the read. This avoids needing a lock between the cores.

Two ownership subtleties in `mirrorCpu1Status()`:

- `eCalStatus` bit 7 ("written to F-RAM") is **CPU2's**, so it is OR-ed back
  over whatever CPU1 published rather than overwritten.
- `eCalTemp_C` is filled by CPU2 from its own cell-temperature block — the
  ADS1119 converters are on CPU2's I2CB, so CPU1 has no reading to publish.

### 4.4 Calibration commit

Two paths, both ending in the idle loop. See `references/calibration.md`.
The rule that matters here: **F-RAM is never written from an ISR.** The
request arrives in the I2C target interrupt or the 8 Hz timer ISR, sets a
pending flag, and `BTS_serviceDeferredWork()` does the transfer.

---

## 5. Register map strides

The register file is indexed by `byte address / 4`. The blocks do **not** share
a stride — assuming 10 registers per channel everywhere is the single most
common bug in this codebase, and produced silent cross-channel corruption of
the calibration and temperature blocks.

| Block | Regs/channel | First address | Helper |
|-------|--------------|---------------|--------|
| Control | 10 | `eCh0_Mode` = 0 | `BTS_CTRL_BASE(ch)` |
| Stats | 6 | `eCh0_ChargeAcc_mAh` = 320 | `BTS_STATS_BASE(ch)` |
| Temperature limits | 2 | `eCh0_MinCellTemp` = 512 | `BTS_TEMP_BASE(ch)` |
| Global voltages | 4 total | `eChargeDisableV` = 576 | direct |
| Calibration | 12 | `eCh0_F28V_Gain` = 592 | `BTS_CAL_BASE(ch)` |
| Unit | 4 total | `eCalibrationMode` = 976 | direct |
| Cell temperature | 1 | `eCh0_CellTemp` = 992 | `BTS_CELLTEMP_IDX(ch)` |
| Slot grouping | 3 total | `eSlotMode` = 1024 | direct |
| Calibration control | 5 total | `eCalSlot` = 1036 | direct |
| Calibration telemetry | 9 total | `eCalAdsV_pu` = 1056 | direct |
| Sense (ADS131M08) | 2 | `eCh0_SenseVoltage` = 1092 | `BTS_SENSE_BASE(ch)` |
| Discharge accumulators | 2 | `eCh0_DischargeAcc_mAh` = 1156 | `BTS_DISCHACC_BASE(ch)` |

`TOTAL_REGISTERS` = **305**, top byte address **1216**.

Always index through the `BTS_*_BASE(ch)` macros in `registers.h`. Note that
`BTS_TEMP_BASE(ch)` is the configured **limit** pair and `BTS_CELLTEMP_IDX(ch)`
is the **measurement** — two different blocks with confusingly similar names.

Adding a register means updating, together: the enum, the `NUM_*` count,
`TOTAL_REGISTERS`, `regConfig[]`, `uartRegConfig[]` (both sized
`TOTAL_REGISTERS`, both must stay index-aligned), the ESP32 `bts_regs.h`
mirror, and `Docs/api-specification.md`. Append above 1152; never insert
mid-map, because external hosts hard-code byte addresses.

---

## 6. Interrupt ownership

No PIE vector may be claimed by both cores. Current allocation, with the group
numbers taken from `hw_ints.h`:

### CPU1

| Interrupt | PIE group | Handler |
|-----------|-----------|---------|
| `INT_ADCA1` | 1.1 | `adcCellVoltageISR` |
| `INT_EPWM1_TZ` … `INT_EPWM8_TZ` | 2.1–2.8 | `epwmTripISR` |
| `INT_EPWM1` | 3.1 | `epwm1ISR` (SFRA only; `BTS_SFRA_ENABLED` is false) |
| `INT_SPIA_RX` | 6.1 | `ISR2` — SPI ADC1 RX FIFO |
| `INT_SPIC_RX` | 6.9 | `ISR4` — SPI ADC2 RX FIFO |
| `INT_XINT3` | 12.1 | `ISR1` — SPI ADC1 DRDY (see §6.1) |
| `INT_XINT5` | 12.3 | `ISR3` — SPI ADC2 DRDY (see §6.1) |

### CPU2

| Interrupt | PIE group | Handler |
|-----------|-----------|---------|
| `INT_XINT1`, `INT_XINT2` | 1.4, 1.5 | `ads1119Drdy1ISR`, `ads1119Drdy2ISR` |
| `INT_TIMER0` | 1.7 | `ledTimerISR` |
| `INT_I2CA` | 8.1 | `i2cSlaveISR` (framing) |
| `INT_I2CA_FIFO` | 8.2 | `i2cSlaveFifoISR` (data bytes) |
| `INT_SCIA_RX` | 9.1 | `uartRxISR` (debug-console build only) |
| `INT_CANA0` | 9.5 | `canISR` |
| `INT_TIMER1` | *direct to CPU INT13* | `timerISR` |

**CPU Timer 1 and Timer 2 are wired directly to CPU INT13/INT14, not through
the PIE.** Their handlers must **not** call `Interrupt_clearACKGroup` — there
is no acknowledge group to clear. Timer 0 *is* a PIE interrupt (group 1) and
does need the ACK.

The I2CA split across 8.1 and 8.2 is not optional: with the FIFO enabled the
TRM forbids the basic RRDY/XRDY interrupts, and the FIFO sources arrive on
`INT_I2CA_FIFO`, a different vector from `INT_I2CA`.

`INT_SCIA_RX` is PIE **9.1**, not 9.3 — 9.3 is SCIB, which this project does
not use for a console (GPIO18/19 are SPICLKA and the ADC1 chip select).

### 6.1 The Input X-BAR is device-global — XINT allocation

Each core has its own PIE, so `INT_XINT1` at 1.4 can legitimately have a
different handler on each. **The X-BAR that decides which pin drives XINT1
cannot.**

`GPIO_setInterruptPin()` is not a per-core GPIO operation: it resolves the
XINT to an Input X-BAR input and writes that select register in the **single
shared Input X-BAR at `0x7900`** (`driverlib/gpio.c`, `xbar.c`). There is one
instance for the device. `GPIO_setInterruptType()` is the same — it writes
`XINT*CR` in the shared `XINT_BASE` block.

| XINT | X-BAR input | PIE |
|---|---|---|
| XINT1 | `XBAR_INPUT4` | 1.4 |
| XINT2 | `XBAR_INPUT5` | 1.5 |
| XINT3 | `XBAR_INPUT6` | 12.1 |
| XINT4 | `XBAR_INPUT13` | 12.2 |
| XINT5 | `XBAR_INPUT14` | 12.3 |

This device has `INPUT1`..`INPUT14` only.

**The bug this caused, fixed 2026-09-19.** Both cores used to write XINT1 and
XINT2: CPU1 pointed them at the external SPI ADC DRDY pins (GPIO25/GPIO49),
CPU2 at the ADS1119 DRDY pins (GPIO42/43). CPU1 configures first
(`bts_cpu1.c:704-730`) and boots CPU2 afterwards, so CPU2's `initADS1119()`
overwrote both selects and won. The SPI ADCs' DRDY lines were disconnected
from their interrupts and `ISR1`/`ISR3` never fired on a DRDY edge.

It was invisible because acquisition never depended on them:
`BTS_HAL_setupInterrupt_Adc1/2()` also registers `INT_SPIA_RX` (6.1) and
`INT_SPIC_RX` (6.9) — the RX-FIFO interrupts, `ISR2`/`ISR4` — which are
genuinely per-core and unaffected. Two registered ISRs were simply dead.

**Current allocation:**

| Input | XINT | Owner | Pin |
|---|---|---|---|
| `INPUT4` | XINT1 | CPU2 | GPIO42 — ADS1119 #1 DRDY |
| `INPUT5` | XINT2 | CPU2 | GPIO43 — ADS1119 #2 DRDY |
| `INPUT6` | XINT3 | CPU1 | GPIO25 — SPI ADC1 DRDY |
| `INPUT14` | XINT5 | CPU1 | GPIO49 — SPI ADC2 DRDY |
| `INPUT9`..`INPUT14` | — | CPU1 | GPIO trips ch1..ch6, all compiled out |

Set in `bts_user_settings.h` (`BTS_SPI_DRDY_XINT_ADC1/2`,
`BTS_PSI_DRDY_XINT_GPIO1/2`). The PIE group moved from 1.4/1.5 to 12.1/12.3,
which is safe only because `ISR1`/`ISR3` are `#pragma INTERRUPT(..., HPI)` and
never call `Interrupt_clearACKGroup`.

> **`INPUT14` is double-booked** between XINT5 and the channel-6 GPIO trip.
> Today the trips are all compiled out so XINT5 owns it; re-enabling the
> channel-6 hardware trip means moving one of them. Free inputs: `INPUT1`,
> `2`, `3`, `7`, `8`. The allocation table is also in a comment in `bts_hal.c`
> above the trip X-BAR block — keep both current.

Treat the Input X-BAR and `XINT*CR` as **device-global resources needing an
allocation table**, the same way the PIE vectors do. A per-core driverlib call
does not imply per-core hardware.

---

## 7. ePWM trip source identification

> **All eight hardware trips are currently disabled**
> (`BTS_TRIP_HW_CH1..8_ENABLED (false)`). `BTS_HAL_setupEPWMTripZone()` masks
> the one-shot trip *signals* and disables the trip-zone *interrupt* on every
> slot, so `epwmTripISR` never runs and `eTripStatus` stays 0 — even though
> the ISR is still registered and enabled. The trip *actions* are still
> programmed, because the software over-current path (`BTS_tripEpwm`) forces
> a trip through the same trip zone and must still bring the outputs low.
>
> The section below is what applies once the trip links are wired and the
> flags are turned back on.

driverlib has **no** `Interrupt_getVectorNumber()` — there is no
`Interrupt_get*` API at all. A shared trip handler must identify the source
from the hardware:

```c
for (channel = 0; channel < NUM_CHANNELS; channel++) {
    uint32_t base = EPWM1_BASE + channel * (EPWM2_BASE - EPWM1_BASE);
    if ((EPWM_getTripZoneFlagStatus(base) & EPWM_TZ_FLAG_OST) == 0U) continue;

    uint16_t ost = EPWM_getOneShotTripZoneFlagStatus(base);
    if (ost & EPWM_TZ_OST_FLAG_OST1) { /* CMPSS over-current  */ }
    if (ost & EPWM_TZ_OST_FLAG_OST2) { /* GPIO group trip     */ }

    EPWM_clearOneShotTripZoneFlag(base, EPWM_TZ_OST_FLAG_OST1 | EPWM_TZ_OST_FLAG_OST2);
    EPWM_clearTripZoneFlag(base, EPWM_TZ_FLAG_OST | EPWM_TZ_INTERRUPT);
}
```

Two distinct registers are involved, and confusing them is easy:

- `EPWM_getTripZoneFlagStatus()` (TZFLG) reports the **kind** of trip —
  `EPWM_TZ_FLAG_OST`, `_CBC`, `_DCAEVT1`, …
- `EPWM_getOneShotTripZoneFlagStatus()` (TZOSTFLG) reports **which one-shot
  input** latched — `EPWM_TZ_OST_FLAG_OST1`…`OST6`.

`BTS_HAL_setupEPWMTripZone` enables `EPWM_TZ_SIGNAL_OSHT1` (CMPSS via Input
X-BAR) and `EPWM_TZ_SIGNAL_OSHT2` (GPIO group trip), so those map to
`EPWM_TZ_OST_FLAG_OST1` and `OST2`. Testing `EPWM_TZ_FLAG_DCAEVT1/2` for these
sources — as an earlier revision did — never matches, because digital-compare
events are not configured.

Clear `EPWM_TZ_INTERRUPT` as well as the source flags, or no further trip
interrupt will be generated.

Trip-zone interrupts are `INT_EPWMx_TZ` (**PIE group 2**), not `INT_EPWMx`
(group 3, the counter/event interrupt). Registering the trip handler on
`INT_EPWM1 + n` installs it on the wrong vector.

### Why they are masked

TZ1 and TZ2 are hardwired to Input X-BAR INPUT1 and INPUT2 (see `XBAR_InputNum`
in `xbar.h`), and nothing in this project ever writes
`INPUT1SELECT`/`INPUT2SELECT` — so both sit at their reset default of GPIO0,
which this board muxes as EPWM1A. Channel 1's trip zones were therefore
watching channel 1's own high-side gate drive and latched OST1+OST2 the
instant the converter switched. That is the observed
`EPwm1Regs_TZOSTFLG = 0x0003` which re-asserted immediately after every TZCLR
write. Fixing the INPUT1/INPUT2 routing is a prerequisite for re-enabling
them (`bts_user_settings.h:74-111`).

`epwmTripISR` also has a re-entry guard: a channel that keeps re-entering has
its trip interrupt masked so the background loop can still run. The trip
action (PWM forced low) stays latched in hardware, so the channel remains safe.

Bench note: a latched `TZOSTFLG` cannot be cleared while its trip source is
still asserted.

---

## 8. C28x type sizes

A C28x byte is **16 bits**. This changes the shape of any wire protocol:

| Type | `sizeof` | Real bits |
|------|----------|-----------|
| `char` / `uint8_t` | 1 | 16 |
| `int16_t` / `uint16_t` | 1 | 16 |
| `int32_t` / `float` | 2 | 32 |

Consequences:

- A `float` is **two words**, not four bytes. Indexing it as
  `((uint8_t*)&f)[0..3]` reads past the end of the object. Use
  `floatGetWireByte` / `floatPutWireByte` in `com_cpu2.c`, which map
  wire byte 0→word1-high, 1→word1-low, 2→word0-high, 3→word0-low — i.e.
  big-endian for the float as a whole.
- `sizeof(BTS_channelCalibration)` is in *words*. Packing it into an F-RAM
  image takes twice that many wire bytes — see `calibrationToBytes` /
  `bytesToCalibration`.
- Anything crossing the I2C/CAN/UART boundary must be packed and unpacked
  explicitly. Never `memcpy` a struct onto the wire.
- The three interfaces do **not** agree on byte order. I2C is big-endian for
  the float; CAN packs the two 16-bit words little-endian; BLE is
  little-endian throughout. Check which one you are writing for.

## 9. Floating-point constraints

The project builds with `--float_operations_allowed=32`, so 64-bit
floating-point is a hard compile error (`#1558-D`). In practice:

- Use `strtof`, not `atof` (which returns `double`).
- `printf("%f")` promotes to `double` — format fixed-point from a scaled
  `int32_t` instead. See `formatRegisterValue` in `com_cpu2.c`.
- Watch for implicit promotion in arithmetic: a bare `1.0` is a `double`
  literal. Write `1.0f`, or cast.

## 10. The status word's real ceiling is bit 23

`eChX_Status` is a `uint32_t` on both cores, but it reaches the host as a
`float32`. A 24-bit significand makes integers exact only to bit 23
(`registers.h:420-424`). Bits 0–14 are in use; **15–23 are free; 24–31 are
not usable at all**. The same applies to `eTripStatus`, `eCalStatus` and every
other bitfield that crosses as a float.
