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
| Hardware resource allocation (PIE, ACK, XINT, X-BAR, ADC bases) | **`Docs/hardware-resources.md`** — authoritative; §6 below summarises rather than duplicates |
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
- **The slot state machine** — `slotPause()` / `slotResume()` / `slotStop()`,
  and the six per-direction counters. CPU1 owns `enable_logic`, so **every**
  state change goes through it, including the ones CPU2 detects: a watchdog
  timeout and a boot restore both arrive as data in `supervision` and are
  acted on here
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
- **The host watchdog countdown** — CPU2 owns the interfaces and the
  timebase, so it detects the timeout. It does **not** perform the pause
- **Slot state persistence** — the 6 s F-RAM save and the boot restore
- **Sole writer of `registers[]`**

> CPU2 detects two events that change a slot's state — a watchdog timeout and
> a boot restore — and performs **neither**. It publishes each into
> `supervision` and CPU1 acts. The single-writer rule covers control state,
> not just memory.

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
| `supervision` | `0x03F804` | Watchdog / boot-restore mailbox — see §2.3 |
| `calValidFlags[8]` | `0x03F808` | Persisted `calFlags` per channel, for status bits 13/14 |
| `registers[TOTAL_REGISTERS]` | `0x03F818` | The register file — the single source of truth |

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

**Current occupancy, read from the map files after the v2 build:**

| Block | Used | Free |
|---|---|---|
| `CPU2TOCPU1RAM` | 790 words (`0x316`) | **234 words** (`0x0EA`) |
| `CPU1TOCPU2RAM` | 508 words (`0x1FC`) | **516 words** (`0x204`) |

`CPU2TOCPU1RAM` is the binding constraint on any new shared register: each
costs two words, and v2's 315 registers account for 630 of the 790 used.
Overflow is a link-time failure, not a runtime one, so the cost of getting it
wrong is a rebuild — but **check the map** rather than guessing.

**Verified after the v2 build:** both cores build clean and all eight shared
symbols — `registers`, `ipcMsg`, `calValidFlags`, `supervision`, `canData`,
`cpu1Status`, `startup_mode`, `startup_enable` — resolve to identical
addresses in `cpu1/*.map` and `cpu2/*.map`.

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
- `chargeMah/Mwh/Seconds[8]` and `dischargeMah/Mwh/Seconds[8]` — the six
  per-direction counters, integrated in `C1()` and mirrored into the runtime
  block by CPU2.

### 2.3 The supervision mailbox

`supervision` is the other CPU2 → CPU1 structure, and it exists because of a
rule rather than a convenience:

```c
typedef struct {
    uint32_t wdPauseSeq;     // bumped once per watchdog expiry
    uint32_t restoreFlags;   // 3 bits per slot: BTS_STATE_F_* << (ch * 3)
} BTS_supervision;
```

**CPU2 owns the host interfaces and the timebase, so it is the core that
detects a watchdog timeout and the core that reads the F-RAM state block. But
it must never write a slot's control state.** The single-writer rule covers
control as well as memory. So in both cases CPU2 only publishes a fact here,
and CPU1 performs the action:

| Event | CPU2 does | CPU1 does |
|---|---|---|
| Watchdog expiry | `wdPauseSeq++` in `hostWatchdogTick()` (8 Hz timer ISR) | `serviceHostWatchdog()` sees the change and calls `slotPause(ch, wdTripped=1, …)` for every running slot |
| Boot restore | Writes the counters into `registers[]`, packs `restoreFlags`, raises `IPC_FLAG3` | `applyRestoredSlotStates()` reconstructs each slot: `slotStop()` then, if it was running, `slotPause(ch, …, restored=1)` |

A **sequence counter** for the watchdog rather than a flag: CPU1 keeps its own
`wdSeqSeen` and compares, so a missed poll cannot lose the pause and a
repeated poll cannot double-apply it. There is nothing to acknowledge.

`restoreFlags` packs three bits per slot (`BTS_STATE_F_RUNNING`,
`_CHARGING`, `_END`) into one word — 24 bits for eight slots, inside the
float-safe range if it ever had to cross as one. It is published **once**,
after the whole file is consistent.

> The restore path is the safety-critical one: a slot that was running comes
> back **PAUSED + RESTORED**, never running. `applyRestoredSlotStates()`
> calls `slotStop()` first and `slotPause()` second, so there is no code path
> through it that re-energises a slot. **Verified on hardware.**

CPU2 arms its periodic state saves only after CPU1 has acknowledged
`IPC_FLAG3` (`stateSaveArmed`), so a 6 s tick cannot overwrite a record
before it has been applied.

### 2.4 Linker requirements

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
symbol resolves to the same address in `cpu1/*.map` and `cpu2/*.map`. All
eight currently agree:

```
ipcMsg          0003f800    supervision     0003f804
calValidFlags   0003f808    registers       0003f818
startup_mode    0003fc00    startup_enable  0003fc02
canData         0003fc04    cpu1Status      0003fc80
```

The driverlib IPC `PUTBUFFER`/`GETBUFFER` GROUPs are separate from the
application sections and must keep the orientation TI specifies: each core's
`PUTBUFFER` goes in *its own* "TO" RAM, and its `GETBUFFER` is a `DSECT` in
the other core's RAM.

---

## 3. IPC flags

`IPC_FLAG0`–`IPC_FLAG31` are hardware flag bits; the BTS uses **four**, all in
the CPU2 → CPU1 direction. Symbolic names are in `registers.h:697-700`:

| Macro | Flag | Meaning | Payload |
|-------|------|---------|---------|
| `BTS_IPC_FLAG_REG_WRITE` | `IPC_FLAG0` | One register changed | `ipcMsg` |
| `BTS_IPC_FLAG_TEMP_UPDATE` | `IPC_FLAG1` | Cell temperature refreshed | `ipcMsg` |
| `BTS_IPC_FLAG_CAL_RELOAD` | `IPC_FLAG2` | Whole calibration block reloaded | none |
| `BTS_IPC_FLAG_STATE_RESTORE` | `IPC_FLAG3` | Slot runtime state came back from F-RAM | `supervision.restoreFlags` |

`IPC_FLAG3` follows the same one-flag-per-logical-change discipline as
`IPC_FLAG2`: `loadSlotStates()` populates every slot's counters in
`registers[]` and the whole of `supervision.restoreFlags`, **then** raises the
flag once. CPU1's `applyRestoredSlotStates()` reconstructs all eight slots
from a file it knows is consistent.

The **watchdog** does not use a flag at all. CPU2 bumps
`supervision.wdPauseSeq` and CPU1 polls it in `serviceHostWatchdog()`, called
unconditionally at the end of `BTS_HandleRegisterWrite()`. A counter rather
than a flag, for the same reason as `calSaveSeq`: a missed poll cannot lose
the event, and there is nothing for CPU1 to acknowledge.

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
if (regIdx in BTS_SET_BASE(0) .. BTS_SET_BASE(NUM_CHANNELS)) {
    offset = (regIdx - BTS_SET_BASE(0)) % BTS_SET_REGS_PER_CH;
    if (offset == BTS_SET_MODE)              → modeCallback()
    else if (offset in the calibration group) → BTS_loadCalibrationFromRegisters()
}
else if (regIdx == BTS_REG_IDX(eCalCommand)) → calHandleCommand()
```

**The decode is by index range, so it has to be re-derived every time the map
moves** — which v2 did. Note what this means under v2: the whole runtime
region (indices 0–95) is read-only and a write there never reaches here at
all, so a write is either in the settings region or in the unit region.

Everything else — including `eCalibrationMode` and `eHostWatchdog_s` — has its
flag acked and is **silently discarded**. That is correct for registers CPU2
acts on itself (the watchdog timeout is one: CPU2 owns the countdown), and a
trap for anything new: a register CPU1 must react to needs an explicit branch
here, or every write will be accepted by CPU2 and quietly ignored by CPU1.

`BTS_HandleRegisterWrite()` also handles `IPC_FLAG3` and then calls
`serviceHostWatchdog()` unconditionally, so the supervision work rides on the
same B3-task cadence as the register decode.

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
        seed eHostWatchdog_s / eWatchdogRemaining_s = 30.0, hostWatchdogFeed()
        notifyCpu1CalibrationReload()             <-- one IPC_FLAG2
      loadSlotStates():
        for each slot: readSlotState() -> validateSlotState()
          valid   -> restore the six counters into registers[],
                     pack BTS_STATE_F_* into supervision.restoreFlags
          invalid -> zero the counters  (the normal first-boot case,
                     NOT logged as an error)
        IPC_setFlagLtoR(BTS_IPC_FLAG_STATE_RESTORE)   <-- one IPC_FLAG3
CPU2: bring up I2CA / console / CAN / timer / LEDs, then EINT, banner,
      then initADS1119() last
CPU1: B3 task -> BTS_HandleRegisterWrite() sees IPC_FLAG2
        -> BTS_loadCalibrationFromRegisters(ch) for all 8 channels
        -> pendingUpdate = 1
      ... and sees IPC_FLAG3
        -> applyRestoredSlotStates(): counters into the acc[] arrays,
           slotStop(ch), then slotPause(ch, restored=1) if it was running
CPU2: timerISR arms stateSaveArmed once IPC_FLAG3 is acknowledged
CPU1: C2 task -> BTS_monitor_program_update(ch)
        -> BTS_calcUserProgramVariables(ch)  (trip thresholds, meas gains)
```

Interrupts on CPU2 are enabled only *after* `loadCalibration()`, so a host
write can never race the boot-time load. `initADS1119()` runs last because its
DRDY ISRs drive I2CB continuously — everything else is already up before they
start.

**The watchdog is armed from boot, not from the host's first command**
(`com_cpu2.c:1050-1055`). A unit that comes up with a slot restored and no
host ever appearing does not sit with supervision disabled.

**Periodic state saves are armed only after CPU1 acknowledges `IPC_FLAG3`.**
Otherwise a 6 s tick could overwrite a slot's record with the not-yet-applied
zeroes of a half-restored file.

### 4.2 Runtime configuration change

```
Host (I2C / console / CAN)
  -> CPU2 applyHostRegisterWrite(regIdx, value)
       registers[regIdx] = value
       notifyCpu1RegisterWrite()            <-- IPC_FLAG0
       [eCalibrationMode == 2.0f  -> calibrationSavePending]
       [eCalCommand != 0          -> self-clear, clear eCalStatus bit 7]
       hostWatchdogFeed()                   <-- reload, every write path
       [eHostWatchdog_s == 0.0f   -> hostWdDisableWarn, printed from the idle loop]
  -> CPU1 BTS_HandleRegisterWrite()
       settings +0       -> modeCallback()   (run / direction / cal / pause / resume)
       calibration group -> BTS_loadCalibrationFromRegisters(ch), pendingUpdate = 1
       eCalCommand       -> calHandleCommand(opcode, registers[eCalArgument])
       IPC_FLAG3         -> applyRestoredSlotStates()
       then always       -> serviceHostWatchdog()
  -> CPU1 C2 task -> BTS_monitor_program_update(ch)
                       -> BTS_calcUserProgramVariables(ch)
```

A host **read** has its own reload hook, in `i2cSlaveFifoISR()`'s transmit
branch. That is the path the ESP32 actually exercises — its steady state is
nine reads every 250 ms and no writes at all.

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
                             the six counters / input V / unit state /
                             trip status / straps / calibration window
                          -> detect a state transition, mark stateSavePending[ch]
                          -> stage calComputed[] if calSaveSeq changed
                        -> hostWatchdogTick()   (countdown, 8 ticks per second)
                          sendCANData(channel)    (round robin)
CPU2 idle loop          -> BTS_serviceDeferredWork()
                             one slot's state record per pass, plus any
                             pending calibration write
```

`cpu1Status.seq` is a seqlock: the reader retries while the counter is odd or
changed across the read. This avoids needing a lock between the cores.

Four ownership subtleties in `mirrorCpu1Status()`:

- `eCalStatus` bit 7 ("written to F-RAM") is **CPU2's**, so it is OR-ed back
  over whatever CPU1 published rather than overwritten.
- The runtime block's **cell-temperature** register is deliberately *not*
  touched. The ADS1119 converters are on CPU2's I2CB, so that register is
  written directly by `publishCellTemp()` and has no CPU1 source. Same for
  `eCalTemp_C` in the calibration window.
- The **six counters** are mirrored only once the boot restore has been
  applied. Before that CPU1's accumulators are still zero, and copying them
  would erase exactly what `loadSlotStates()` just restored.
- A **state transition** is detected here, from the mirrored status word
  rather than from a mode write — two reasons. The bits here are the ones
  that will be saved, whereas a mode write is seen before CPU1 has acted on
  it; and a transition CPU1 made on its own (a trip, a termination, a
  watchdog pause) has no host write to hang off at all.

### 4.4 Calibration commit

Two paths, both ending in the idle loop. See `references/calibration.md`.
The rule that matters here: **F-RAM is never written from an ISR.** The
request arrives in the I2C target interrupt or the 8 Hz timer ISR, sets a
pending flag, and `BTS_serviceDeferredWork()` does the transfer.

The 6 s slot-state save follows the same rule and adds one of its own: it
writes **one slot per pass**, so the eight stagger across the window and a
save never holds the I2C controller — and therefore the host bus — for eight
transfers at once.

---

## 5. Register map strides — v2

The register file is indexed by `byte address / 4`. Under **map v2** the
nine scattered blocks collapsed into **three regions**, each with a fixed,
generous per-slot stride so a future field does not move everything again:

| Region | Base | Regs/slot | Stride | Access | Helper |
|---|---|---|---|---|---|
| Runtime | 0 | **12** | 48 B | all RO | `BTS_RT_BASE(ch)` |
| Settings | 384 | **24** | 96 B | mostly RW | `BTS_SET_BASE(ch)` |
| Unit | 1152 | 27 total | — | mixed | direct |

`TOTAL_REGISTERS` = **315**, top byte address **1256**. Runtime ch7 ends at
383, immediately before the settings base; settings ch7 ends at 1151,
immediately before the unit base.

Sub-blocks within a slot, as offsets from their region's base — these are
what the named macros resolve to:

| Sub-block | Regs | Offset | Helper |
|---|---|---|---|
| Measured cell temperature | 1 | runtime +5 | `BTS_CELLTEMP_IDX(ch)` |
| Charge / discharge counters | 6 | runtime +6..+11 | direct |
| Mode register | 1 | settings +0 | `BTS_SET_BASE(ch)` |
| Temperature **limits** | 2 | settings +9 | `BTS_TEMP_BASE(ch)` |
| Calibration group | 12 | settings +11 | `BTS_CAL_BASE(ch)` |
| Spare | 1 | settings +23 | — |

**The two regions have different strides — 12 and 24.** Mixing them is the
single most common bug in this codebase and produces silent cross-channel
corruption rather than an error. Always index through the macros.

`BTS_TEMP_BASE(ch)` is the configured **limit** pair and
`BTS_CELLTEMP_IDX(ch)` the **measurement** — two different regions now, with
confusingly similar names. `BTS_CAL_BASE(ch)` is still `BTS_SET_BASE(ch) + 11`
and the calibration group keeps its internal order, so
`saveCalibration()` / `loadCalibration()` needed no change across the reorder.

Adding a register means updating, together: the enum, the `NUM_*` count,
`TOTAL_REGISTERS`, `regConfig[]`, `uartRegConfig[]` (both sized
`TOTAL_REGISTERS`, both must stay index-aligned), the ESP32 `bts_regs.h`
mirror, and `Docs/api-specification.md`. Put a new per-slot setting in the
settings region's **spare** register; a new runtime field has no spare and
would mean another breaking stride change. Never insert mid-map — external
hosts hard-code byte addresses.

---

## 6. Interrupt ownership

> **`Docs/hardware-resources.md` is the authority for every allocation
> table** — PIE interrupts per core, ACK groups, XINT assignments, the Input
> X-BAR, the ePWM X-BAR/CMPSS routing, ePWM module usage and the ADC base
> addresses, each row traced to a file and line. Read it before claiming any
> of them. This section covers only what you have to *understand*; it does not
> repeat the tables.

Three facts shape everything here.

**No PIE vector may be claimed by both cores.** Each core has its own PIE and
its own vector table, so the same vector number on the two cores is not itself
a conflict — but a device-global resource feeding that vector is (see §6.1).

**The ACK group must match the PIE group of the interrupt that invoked the
handler**, not of anything the handler happens to touch.
`Interrupt_clearACKGroup()` re-opens one PIE group; ack the wrong one and the
real group stays latched forever. The interrupt fires exactly once and then
stops, with no fault, no trap and no log — while the group you did ack is
re-opened spuriously. Look the vector up in `hw_ints.h` and read the group out
of the constant: `INT_XINT3 = 0x00780C01` is group `0x0C` = **12**.

CPU1's SPI DRDY handlers are the live example. `ISR1`/`ISR3` run on
`INT_XINT3` (**12.1**) and `INT_XINT5` (**12.3**), so `BTS_runISR_ch1_4()` and
`BTS_runISR_ch5_8()` ack `INTERRUPT_ACK_GROUP12` (`bts.h:811`, `:862`). They
used to ack group 1 — correct for the XINT1/XINT2 they were moved off, wrong
after the move — and group 12 was left permanently blocked, freezing the whole
external-ADC sample ring after a single DRDY edge.

**CPU Timer 1 and Timer 2 are wired directly to CPU INT13/INT14, not through
the PIE.** `INT_TIMER1 = 0x000D0000` has no group/channel bytes at all;
`Interrupt_enable()` sets `IER` directly (`driverlib/interrupt.c:323-326`).
There is no acknowledge group, and calling `Interrupt_clearACKGroup()` from
such a handler re-opens an unrelated group. CPU2's `timerISR` correctly does
not ack. **Timer 0 is different** — it *is* a PIE interrupt at 1.7 and does
need `INTERRUPT_ACK_GROUP1`.

Two further ordering rules, both of which have cost a debugging session:

- **`EINT` goes last, after every `Interrupt_register()`** — not after most of
  them. Enabling interrupts while any vector is still
  `Interrupt_defaultHandler` sends the core into an infinite loop with that
  PIE group never acknowledged. On CPU1 this is what
  `BTS_HAL_enableGlobalInterrupts()` exists for; it is called from
  `bts_cpu1.c:925`, after the last registration. The general form is *register
  before enable*, which is why CPU2's `initADS1119()` can safely run after
  `EINT`.
- **`INT_I2CA` (8.1) and `INT_I2CA_FIFO` (8.2) are two different vectors**,
  and the split is not optional: with the FIFO enabled the TRM forbids the
  basic RRDY/XRDY interrupts. Mixing them lets a data byte be parsed as an
  address byte.

> **There is a live latent defect in the trip-zone registration.**
> `bts_hal.c:1482` does `Interrupt_register(INT_EPWM1_TZ + (i - 1), ...)`, but
> the `INT_*` stride is `0x00010001`, not `1` — so all eight iterations write
> the **ePWM1** vector and 2.2–2.8 keep the default handler. It is masked only
> because every hardware trip is compiled out. See
> `Docs/hardware-resources.md` §7.1 before setting any
> `BTS_TRIP_HW_CHn_ENABLED` true.

### 6.1 The Input X-BAR is device-global

Each core has its own PIE, so `INT_XINT1` at 1.4 can legitimately have a
different handler on each. **The X-BAR that decides which pin drives XINT1
cannot.**

`GPIO_setInterruptPin()` is not a per-core GPIO operation: it resolves the
XINT to an Input X-BAR input — a fixed mapping in `driverlib/gpio.c:127-147`,
XINT1→`INPUT4`, XINT2→`INPUT5`, XINT3→`INPUT6`, XINT4→`INPUT13`,
XINT5→`INPUT14` — and writes that select register in the **single shared Input
X-BAR at `0x7900`**. There is one instance for the device.
`GPIO_setInterruptType()` is the same: it writes `XINT*CR` in the shared
`XINT_BASE` block at `0x7070`. This device has `INPUT1`..`INPUT14` only.

**Last writer wins, and CPU2 boots last.**

That is precisely the trap: `GPIO_setInterruptPin()` is callable from CPU2 —
unlike `GPIO_setPinConfig()`, which is silently discarded there — so it looks
like a per-core operation and behaves like a global one.

**The bug this caused, fixed 2026-09-19.** Both cores used to write XINT1 and
XINT2: CPU1 pointed them at the external SPI ADC DRDY pins (GPIO25/GPIO49),
CPU2 at the ADS1119 DRDY pins (GPIO42/43). CPU1 configures first and boots
CPU2 afterwards, so CPU2's `initADS1119()` overwrote both selects and won. The
SPI ADCs' DRDY lines were disconnected from their interrupts and `ISR1`/`ISR3`
never fired on a DRDY edge.

It was invisible because acquisition never depended on them:
`BTS_HAL_setupInterrupt_Adc1/2()` also registers `INT_SPIA_RX` (6.1) and
`INT_SPIC_RX` (6.9) — the RX-FIFO interrupts, `ISR2`/`ISR4` — which are
genuinely per-core and unaffected. Two registered, enabled ISRs were simply
dead code.

**Now:** CPU1 owns XINT3/`INPUT6` and XINT5/`INPUT14`; CPU2 keeps
XINT1/`INPUT4` and XINT2/`INPUT5`. Set in `bts_user_settings.h`
(`BTS_SPI_DRDY_XINT_ADC1/2`, `BTS_PSI_DRDY_XINT_GPIO1/2`, `:513-546`). The PIE
group moved from 1.4/1.5 to 12.1/12.3 — which is why the ACK group had to move
with it.

> **`INPUT14` is double-booked** between XINT5 and the channel-6 GPIO trip.
> Today the trips are all compiled out so XINT5 owns it; re-enabling the
> channel-6 hardware trip will silently kill slot 5–8 acquisition unless one of
> them moves first. Free inputs: `INPUT1`, `2`, `3`, `7`, `8` — and note
> `INPUT1`/`INPUT2` are ePWM TZ1/TZ2, sitting at their GPIO0 reset default.
> Channels 7 and 8 have **no** X-BAR path at all: their trips target
> `INPUT15`/`INPUT16`, which do not exist. Full picture:
> `Docs/hardware-resources.md` §4.

Treat the Input X-BAR and `XINT*CR` as **device-global resources needing an
allocation table**, the same way the PIE vectors do. A per-core driverlib call
does not imply per-core hardware. The allocation also appears as a comment in
`bts_hal.c` above the trip X-BAR block — `Docs/hardware-resources.md` is
authoritative over both; keep all three current.

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

> **`INT_EPWM1_TZ + n` is wrong too, and that is the current code.** The
> `INT_*` constants pack the vector ID in bits 31:16 and group/channel in bits
> 15:0, so the stride between adjacent interrupts is `0x00010001`, not `1`.
> Adding `n` bumps only the channel byte: `Interrupt_enable()` is satisfied,
> but `Interrupt_register()` reads bits 31:16 alone and writes all eight
> handlers into the **ePWM1** slot, leaving 2.2–2.8 on the default handler's
> infinite loop. Masked today only because the trips are disabled — fix it
> before enabling any. `Docs/hardware-resources.md` §7.1.

### Why they are masked

(The Input X-BAR allocation this depends on is in
`Docs/hardware-resources.md` §4 — `INPUT1`/`INPUT2` are listed free there in
the sense of *unassigned*, which is exactly the problem below.)

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
(`registers.h:418-421`). The same applies to `eTripStatus`, `eCalStatus` and
every other bitfield that crosses as a float.

Current allocation after v2:

| Bits | State |
|---|---|
| 0–14 | In use since v1 |
| 15 | `PAUSED` — new in v2 |
| **16** | **Unused, reads a constant 0** |
| 17 | `WD_TRIPPED` — new in v2 |
| 18 | `RESTORED` — new in v2 |
| 19–23 | Free |
| 24–31 | **Not usable at all** |

> Bit 16 is free but deliberately skipped. An early revision defined
> `BTS_STATUS_END` there; the shipped design makes END an **alias for bit 2**
> (`BTS_STATUS_FINISHED`) instead, because that bit was declared from the
> start and never driven. Anything that polls bit 16 reads a constant 0. Bit 2
> is now driven — cleared on start, pause and stop, and restored from the
> F-RAM state block — though no termination path asserts it yet.
