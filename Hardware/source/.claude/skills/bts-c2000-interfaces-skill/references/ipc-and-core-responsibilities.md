# BTS Inter-Processor Communication and Core Responsibilities

Authoritative reference for how CPU1 and CPU2 divide the work on the
TMS320F28379D, and how they exchange data. Every mechanism below is
cross-checked against the TI device documentation and the C2000Ware driverlib
headers shipped with the Digital Power SDK 5.03.00.00.

Sources used for verification:

| Fact | Verified against |
|------|------------------|
| Message RAM base addresses | `driverlib/f2837xd/driverlib/inc/hw_memmap.h` — `CPU1_TO_CPU2_MSG_RAM_BASE`, `CPU2_TO_CPU1_MSG_RAM_BASE` |
| Message RAM ownership | `device_support/f2837xd/common/cmd/2837xD_FLASH_lnk_cpu1.cmd` and `..._cpu2.cmd` (the `PUTBUFFER` / `GETBUFFER` GROUPs) |
| IPC API surface | `driverlib/f2837xd/driverlib/ipc.h` |
| PIE group assignments | `driverlib/f2837xd/driverlib/inc/hw_ints.h` |
| Trip-zone flag semantics | `driverlib/f2837xd/driverlib/epwm.h` |

---

## 1. Core responsibility split

### CPU1 — the "BTS CPU" (real-time control)

Owns everything with a hard deadline.

- 8 × synchronous bidirectional buck/boost control loops (DCL FPU32, HRPWM)
- External SPI ADC acquisition (`ISR1`–`ISR4`), on-chip ADC cell V/I sampling
- Trip handling: CMPSS over-current and GPIO group trips via ePWM trip zones
- Background state machine (A/B/C tasks) at 1 kHz / 100 Hz / 10 Hz
- Input bus-voltage monitoring and the unit state machine
- Boots CPU2 (`Device_bootCPU2`)
- Recalculates program variables when CPU2 signals a calibration change

CPU1 **never writes** `registers[]`. It is a consumer of configuration and a
producer of measurements.

### CPU2 — the "com CPU" (communications and configuration)

Owns everything external-facing and non-volatile.

- I2CA target (address 0x50) — ESP32 / host register access
- I2CB controller — calibration EEPROM (0x50) and two ADS1119 temperature ADCs (0x40, 0x41)
- SCIB UART at 1 Mbaud — `AT+` command set
- CANA at 500 kbit/s, extended IDs from `0x1C000000` — telemetry and register access
- SCIA — WS2812B status LEDs
- Boot-time calibration load and runtime calibration save
- Sole writer of `registers[]`

---

## 2. Shared memory

The F2837xD provides two dedicated message RAM blocks. Each is writable by
exactly one core and readable by both — this single-writer rule is the
foundation of the whole design, and is why the register file lives on CPU2.

| Block | Address | Length | Writer | Reader |
|-------|---------|--------|--------|--------|
| `CPU2TOCPU1RAM` | `0x03F800` | `0x400` | CPU2 | CPU1 |
| `CPU1TOCPU2RAM` | `0x03FC00` | `0x400` | CPU1 | CPU2 |

### Objects in CPU2 → CPU1 RAM (CPU2 writes)

| Symbol | Purpose |
|--------|---------|
| `registers[TOTAL_REGISTERS]` | The register file — the single source of truth for configuration |
| `ipcMsg` | Single-register mailbox: `{regAddr, value}` |
| `calibrationData[NUM_CHANNELS]` | Last validated EEPROM image per channel |

### Objects in CPU1 → CPU2 RAM (CPU1 writes)

| Symbol | Purpose |
|--------|---------|
| `cpu1Status` | Status bits, cell V/I, input voltage, unit state, trip status |
| `canData[NUM_CHANNELS]` | Per-channel telemetry for CAN transmission |
| `startup_mode`, `startup_enable` | Strap-pin state latched at boot |

### Linker requirements

Both `2837xD_RAM_lnk_cpu1.cmd` and `2837xD_RAM_lnk_cpu2.cmd` must declare the
**same origins and lengths**, and must place the application sections plus the
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

**Verification:** after building both configurations, confirm every shared
symbol resolves to the same address in `cpu1/*.map` and `cpu2/*.map`. They
currently agree:

```
registers        0003f904    ipcMsg          0003f800
calibrationData  0003f804    cpu1Status      0003fc04
canData          0003fc3c    startup_mode    0003fc00
```

The driverlib IPC `PUTBUFFER`/`GETBUFFER` GROUPs are separate from the
application sections and must keep the orientation TI specifies: each core's
`PUTBUFFER` goes in *its own* "TO" RAM, and its `GETBUFFER` is a `DSECT` in the
other core's RAM.

---

## 3. IPC flags

`IPC_FLAG0`–`IPC_FLAG31` are hardware flag bits; the BTS uses three, all in the
CPU2 → CPU1 direction. Symbolic names are in `registers.h`:

| Macro | Flag | Meaning | Payload |
|-------|------|---------|---------|
| `BTS_IPC_FLAG_REG_WRITE` | `IPC_FLAG0` | One register changed | `ipcMsg` |
| `BTS_IPC_FLAG_TEMP_UPDATE` | `IPC_FLAG1` | Cell temperature refreshed | `ipcMsg` |
| `BTS_IPC_FLAG_CAL_RELOAD` | `IPC_FLAG2` | Whole calibration block reloaded | none |

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

- **Write data before raising the flag.** `registers[]` is in CPU2's RAM, so by
  the time CPU1 observes the flag the value has settled.
- **The sender must not block.** `notifyCpu1RegisterWrite` skips the
  notification if the previous flag is still unacknowledged, because CPU1
  re-reads the affected block from `registers[]` anyway. A blocking
  `while (IPC_isFlagBusyLtoR(...))` inside an ISR — as an earlier revision of
  `loadCalibration` did — deadlocks if CPU1 is not yet running.
- **One notification per logical change.** Boot sends a single
  `BTS_IPC_FLAG_CAL_RELOAD` after the whole register file is populated, rather
  than one flag per register against a half-built file.

---

## 4. Data flows

### 4.1 Boot

```
CPU1: BTS_HAL_setupDevice() ... Device_bootCPU2()
CPU2: Device_init() -> initI2C_Master()
      loadCalibration():
        for each channel:
          readEEPROM() -> validateCalibration()
            valid   -> applyStoredCalibration()   (EEPROM values)
            invalid -> applyDefaultCalibration()  (compiled-in defaults)
        read global voltage thresholds at EEPROM 0x0100
          invalid -> 9 / 10 / 15 / 16 V defaults
        notifyCpu1CalibrationReload()             <-- one IPC_FLAG2
CPU2: bring up I2CA / UART / CAN / timer / LEDs / ADS1119, then EINT
CPU1: B3 task -> BTS_HandleRegisterWrite() sees IPC_FLAG2
        -> BTS_loadCalibrationFromRegisters(ch) for all 8 channels
        -> sets pendingUpdate = 1
CPU1: C2 task -> BTS_monitor_program_update(ch)
        -> BTS_calcUserProgramVariables(ch)  (trip thresholds, meas gains)
```

Interrupts on CPU2 are enabled only *after* `loadCalibration()`, so a host
write can never race the boot-time load.

### 4.2 Runtime configuration change

```
Host (I2C / UART / CAN)
  -> CPU2 applyHostRegisterWrite(regIdx, value)
       registers[regIdx] = value
       notifyCpu1RegisterWrite()            <-- IPC_FLAG0
  -> CPU1 BTS_HandleRegisterWrite()
       control register  -> modeCallback()
       calibration block -> BTS_loadCalibrationFromRegisters(ch),
                            pendingUpdate = 1
  -> CPU1 C2 task -> BTS_monitor_program_update(ch)
                       -> BTS_calcUserProgramVariables(ch)
```

`BTS_monitor_program_update` updates **in-memory program variables only**.
CPU1 has no EEPROM access — persistence is CPU2's job.

### 4.3 Calibration commit

Writing `eCalibrationMode = 2.0` from any interface makes CPU2 call
`saveCalibration()` for all eight channels. Channel 0 also persists the four
global voltage thresholds. Every block is validated before it is written.

### 4.4 Measurement path (CPU1 → CPU2)

```
CPU1 adcCellVoltageISR -> BTS_measValues[]
CPU1 C1 task (10 Hz)   -> publishStatusToCpu2()
                            cpu1Status.seq++      (odd = update in progress)
                            status bits, cell V/I, input V, unit state
                            canData[]
                            cpu1Status.seq++      (even = consistent)
CPU2 timerISR (8 Hz)   -> mirrorCpu1Status()
                            seqlock read, retry on torn snapshot
                            -> registers[] status / cell V / cell I /
                               input voltage / unit state / trip status
                          sendCANData(channel)    (round robin)
```

`cpu1Status.seq` is a seqlock: the reader retries while the counter is odd or
changed across the read. This avoids needing a lock between the cores.

---

## 5. Register map strides

The register file is indexed by `byte address / 4`. The blocks do **not** share
a stride — assuming 10 registers per channel everywhere is the single most
common bug in this codebase, and produced silent cross-channel corruption of
the calibration and temperature blocks.

| Block | Registers/channel | First address | Helper |
|-------|-------------------|---------------|--------|
| Control | 10 | `eCh0_Mode` = 0 | `BTS_CTRL_BASE(ch)` |
| Stats | 6 | `eCh0_CurrentAcc` = 320 | `BTS_STATS_BASE(ch)` |
| Temperature | 2 | `eCh0_MinCellTemp` = 512 | `BTS_TEMP_BASE(ch)` |
| Global voltages | 4 total | `eChargeDisableV` = 576 | direct |
| Calibration | 12 | `eCh0_F28V_Gain` = 592 | `BTS_CAL_BASE(ch)` |
| Unit | 4 total | `eCalibrationMode` = 976 | direct |

Always index through the `BTS_*_BASE(ch)` macros in `registers.h`.

---

## 6. Interrupt ownership

No PIE vector may be claimed by both cores. Current allocation:

### CPU1

| Interrupt | PIE group | Handler |
|-----------|-----------|---------|
| `INT_ADCA1` | 1.1 | `adcCellVoltageISR` |
| `INT_EPWM1_TZ` … `INT_EPWM8_TZ` | 2.1–2.8 | `epwmTripISR` |
| `INT_EPWM1` | 3.1 | `epwm1ISR` (SFRA only) |
| SPI ADC DRDY / RXFF | 6, 12 | `ISR1`–`ISR4` |

### CPU2

| Interrupt | PIE group | Handler |
|-----------|-----------|---------|
| `INT_TIMER0` | 1.7 | `ledTimerISR` |
| `INT_XINT1`, `INT_XINT2` | 1.4, 1.5 | `ads1119Drdy1ISR`, `ads1119Drdy2ISR` |
| `INT_I2CA` | 8.1 | `i2cSlaveISR` |
| `INT_SCIB_RX` | 9.3 | `uartRxISR` |
| `INT_CANA0` | 9.5 | `canISR` |
| `INT_TIMER1` | *direct to CPU INT13* | `timerISR` |

**CPU Timer 1 and Timer 2 are wired directly to CPU INT13/INT14, not through
the PIE.** Their handlers must **not** call `Interrupt_clearACKGroup` — there
is no acknowledge group to clear. Timer 0 *is* a PIE interrupt (group 1) and
does need the ACK.

---

## 7. ePWM trip source identification

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
  `((uint8_t*)&f)[0..3]` reads past the end of the object.
- `sizeof(BTS_channelCalibration)` is 32 *words*. Packing it into an EEPROM
  image takes 64 wire bytes — see `calibrationToBytes` / `bytesToCalibration`.
- Anything crossing the I2C/CAN/UART boundary must be packed and unpacked
  explicitly. Never `memcpy` a struct onto the wire.

## 9. Floating-point constraints

The project builds with `--float_operations_allowed=32`, so 64-bit
floating-point is a hard compile error (`#1558-D`). In practice:

- Use `strtof`, not `atof` (which returns `double`).
- `printf("%f")` promotes to `double` — format fixed-point from a scaled
  `int32_t` instead. See `formatRegisterValue` in `com_cpu2.c`.
