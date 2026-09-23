# Data Flow — measurement, control, calibration and settings

How a number gets from a sense resistor to a phone, and how a command gets
back. Four subsystems are in the path and each one changes the representation:
the C2000's two cores, the ESP32 proxy, and whatever is holding the BLE
connection.

The wire-level contracts are elsewhere and this document does not restate
them — [`api-specification.md`](api-specification.md) for the I2C register map
and the HTTP API, [`ble-specification.md`](ble-specification.md) for the GATT
service, [`calibration-design.md`](calibration-design.md) for the calibration
mathematics. This is the shape of the system those documents describe in
pieces.

Everything below is drawn from the source, not from intent. Where a path is
dead or a value is never consumed, the diagram says so rather than omitting
it — the dead paths are the ones that cost debugging time.

---

## 1. The three rules everything else follows

Read these first; every diagram in this document is a consequence of them.

**CPU1 never writes the register file.** `registers[]` lives in
`CPU2TOCPU1RAM`, which the F2837xD permits only CPU2 to write. CPU1 publishes
measurements into `cpu1Status` (in the other message RAM) under a seqlock and
CPU2 copies them across. There is one deliberate exception, `modeCallback()`
setting `eCalSlot`.

**CPU1 performs every state change.** CPU2 owns the interfaces, so it is CPU2
that notices a watchdog timeout or reads a saved slot state at boot — but it
performs neither. It publishes the event into the `supervision` mailbox and
CPU1 acts on it, because CPU1 owns `enable_logic` and the control loop.

**Endianness differs by interface.** I2C register payloads are **big-endian**
(the C2000 emits the float MSB first). BLE records are **little-endian**.
HTTP carries JSON numbers, so no byte order applies. The conversion happens
in `bts_regs.h`; nothing above `bts_link` sees the C2000's byte order.

---

## 2. Measurement path — silicon to phone

The direction almost all the traffic goes. Four converters feed it and they
do **not** all reach a host.

```mermaid
flowchart LR
    subgraph SILICON ["Analogue front end"]
        SHUNT["Sense resistor<br/>+ divider network"]
        NTC["NTC thermistor<br/>×8"]
    end

    subgraph CPU1 ["F28379D CPU1 — control core"]
        ADS["ADS131M08<br/>SPI, 16-bit WORD mode"]
        INT["On-chip ADC<br/>12-bit @ 2.5 V ref<br/>17 SOCs @ 6.645 kSPS"]
        CLA["CLA1 task 1<br/>20 Hz IIR per channel<br/>runs on EVERY sweep"]
        PROT["Reverse polarity check<br/>+ group supervision"]
        LOOP["DCL control loop<br/>HRPWM, per slot"]
        ACC["mAh / mWh / seconds<br/>integrated per direction"]
        DEAD["Isense_A / Vsense_V<br/>engineering values"]
        PUB["cpu1Status<br/>seqlock, CPU1TOCPU2RAM"]
    end

    subgraph CPU2 ["F28379D CPU2 — comms core"]
        ADS1119["2 × ADS1119<br/>I2CB, 0x40 / 0x41"]
        MIRROR["mirrorCpu1Status()<br/>seqlock read"]
        REGS["registers[267]<br/>CPU2TOCPU1RAM"]
    end

    subgraph ESP ["ESP32 proxy"]
        LINK["bts_link<br/>I2C master @ 50 kHz"]
        ENGINE["test_engine<br/>+ coulomb_counter"]
    end

    subgraph HOSTS ["Hosts"]
        BLEH["BLE GATT<br/>notify"]
        HTTPH["HTTP JSON"]
        LCD["ST7789 LCD"]
    end

    SHUNT --> ADS
    SHUNT --> INT
    NTC --> ADS1119

    ADS -->|"ioutSense_pu<br/>raw per-unit"| LOOP
    ADS -->|"16-bit sums"| ACC
    ADS -.->|"computed at 10 Hz,<br/>NEVER READ"| DEAD
    INT -->|"8-deep ring, meaned at 10 Hz<br/>CellVoltage_V / CellCurrent_I"| PROT
    INT -->|"ADCA INT2 at SOC6,<br/>every sweep"| CLA
    CLA -->|"CellVoltageFilt_V<br/>CellCurrentFilt_I"| PUB
    PROT -.->|"fallback only, if the<br/>CLA stops advancing"| PUB
    ACC --> PUB
    LOOP --> PUB

    PUB -->|"IPC message RAM"| MIRROR
    MIRROR --> REGS
    ADS1119 -->|"publishCellTemp()<br/>AIN index INVERTED to slot"| REGS

    REGS -->|"9 bursts / 250 ms"| LINK
    LINK --> ENGINE
    ENGINE --> BLEH
    ENGINE --> HTTPH
    ENGINE --> LCD

    style DEAD stroke-dasharray: 5 5
    style PROT stroke-dasharray: 5 5
```

### What the diagram is telling you

**The 16-bit converter's engineering values are dead.**
`BTS_monitor_Iout_Vout()` computes `Isense_A` and `Vsense_V` at 10 Hz and
nothing reads them — not `cpu1Status`, not `canData`, not `registers[]`. The
ADS131M08 still matters, because its *raw per-unit* value is what closes the
control loop and what the accumulators integrate. But what a host sees in
`eChX_CellVoltage` and `eChX_CellCurrent` is the **12-bit on-chip ADC**. The
register naming suggests the opposite.

**`eChX_SenseVoltage` and `eChX_SenseCurrent` exist in the map and are
published**, so the runtime burst is self-consistent — but they come from the
same internal path, not from the dead ADS engineering values.

**The thermistor inputs are wired in reverse.** On both converters the highest
AIN carries the lowest slot: `AIN3 → slot 1`. `ADS1119_SLOT_FOR_AIN()` inverts
it at the publish call. A console `ChN` is a **slot**, not an AIN.

**A temperature of 18.32 °C is not a measurement.** `BTS_NTC_POLY_C0` is
18.323 and the Horner evaluation returns exactly C0 for a zero input, so that
value means an open input. `publishCellTemp()` is called unconditionally, so
an all-zero transfer publishes the floor as if it were valid.

### The internal ADC is filtered by the CLA, and only for telemetry

`CellVoltage_V` and `CellCurrent_I` are a **1.2 ms snapshot taken once
every 100 ms**. `adcCellVoltageISR` pushes each sweep into an 8-deep ring
(`BTS_f28AverageFactor`, `bts_user_settings.h:278`) and
`BTS_monitor_Iout_Vout()` means that ring at 10 Hz. At 6.645 kSPS eight
samples is 1.2 ms, so **98.8 % of the conversions are discarded**, and
whatever ripple happens to sit inside that window aliases straight through
to the host.

CLA1 task 1 (`bts_cla.cla`) closes that gap. It runs on *every* sweep and
folds each sample into a single-pole IIR:

```
y += alpha * (x - y)      alpha = 2*pi*fc/fs = 2*pi*20/6645 = 0.018912
```

One float32 multiply-accumulate per channel, sixteen channels plus the A0
reference, on a processor that is not the C28x. The C28x cost is zero.
`BTS_updateFilteredTelemetry()` (`bts_cpu1.c:1630`) scales the result out
of counts into volts and amps using the same gains `BTS_monitor_Iout_Vout()`
uses, and publishes it as `CellVoltageFilt_V` / `CellCurrentFilt_I`.

```mermaid
flowchart LR
    SOC["EPWM1 SOCA<br/>TBPRD 902 @ 90 MHz<br/>event prescale /15"]
    SWEEP["17 SOCs across ADCA-D<br/>SOC0..SOC5 V/I, SOC6 = A0 ref"]
    I1["ADCA INT1 ← SOC0<br/>PIE 1.1, enabled"]
    I2["ADCA INT2 ← SOC6<br/>PIE masked, continuous"]
    ISR["adcCellVoltageISR<br/>8-deep ring per channel"]
    CLA1["CLA1 task 1<br/>IIR, alpha 0.018912"]
    MEAN["BTS_monitor_Iout_Vout()<br/>ring mean @ 10 Hz"]
    UPD["BTS_updateFilteredTelemetry()<br/>counts → V/A @ 10 Hz"]
    SAFE["Reverse polarity,<br/>group supervision,<br/>BTS_cellVoltageAsCtrl16b()"]
    TEL["cpu1Status, canData,<br/>calibration telemetry"]

    SOC --> SWEEP
    SWEEP --> I1 --> ISR --> MEAN
    SWEEP --> I2 --> CLA1 --> UPD
    MEAN -->|"CellVoltage_V<br/>CellCurrent_I"| SAFE
    MEAN -.->|"fallback"| UPD
    UPD -->|"CellVoltageFilt_V<br/>CellCurrentFilt_I"| TEL
```

**The filtered values are telemetry only.** That was a deliberate scope
decision, and the split is visible in the code: the reverse-polarity check
(`bts_cpu1.c:1900`), group supervision (`bts_cpu1.c:2070`, `:2080`) and
`BTS_cellVoltageAsCtrl16b()` (`bts.h:450`) all keep reading the unfiltered
`CellVoltage_V` / `CellCurrent_I`. A 20 Hz single pole adds ~12 ms of lag,
which is fine for a display and not fine for a trip. The three sinks the
filtered pair does reach are `cpu1Status` (`bts_cpu1.c:1269-1270`), the CAN
frame (`:1287-1288`) and the calibration telemetry window (`:827-828`).

**It fails back, not silent.** `BTS_claRunCount` is incremented once per
task run. `BTS_updateFilteredTelemetry()` compares it against the value it
saw 100 ms earlier; if it has not moved — the CLA never started, LS4/LS5
were never handed over, the ADCA INT2 trigger is not reaching
`CLA1TASKSRCSEL1` — telemetry reverts to the unfiltered pair rather than
reporting a frozen number, or 0 V, with nothing to distinguish it from a
real reading. `BTS_claPrimed` covers the other end: the first task run
*loads* the filter state from the raw sample instead of converging towards
it from zero, so telemetry does not ramp up from 0 V over the first 12 ms
of every boot.

Measured on the bench at the shipped coefficient: channel 4's raw current
(SOC5 − SOC6) spread 44 counts ≈ 259 mA across five consecutive sweeps,
while the filtered output moved about 2 counts ≈ 11 mA and stayed inside
the raw cluster — roughly a 20× reduction, with the filtered value tracking
the raw mean rather than chasing individual samples.

The resource side of this — which LS RAM block, which interrupt, why the
PIE channel is masked — is in
[`hardware-resources.md` §7](hardware-resources.md#7-cla1-allocation).

### Rates

| Stage | Rate | Set by |
|---|---|---|
| Control loop ISR | per switching cycle | HRPWM |
| Converter switching | **99.67 kHz** | `BTS_DRV_EPWM_TBPRD` = 902 at EPWMCLK 90 MHz |
| On-chip ADC sweep, 17 SOCs | **6.645 kSPS** | EPWM1 SOCA, `BTS_ADC_SOC_PRESCALE` = 15 |
| `adcCellVoltageISR` (ADCA INT1 ← SOC0) | 6.645 kHz | same trigger |
| CLA1 task 1 (ADCA INT2 ← SOC6) | 6.645 kHz | same trigger |
| Task A / B / C | 1 kHz / 200 Hz / 20 Hz | `TASKA/B/C_FREQ_HZ` |
| `BTS_monitor_Iout_Vout()` | 10 Hz | Task C |
| Accumulator integration | 150 ms fixed step | Task C |
| ADS1119 conversion | DRDY-driven, 4 channels round-robin | converter |
| ESP32 poll cycle | **250 ms, 9 I2C transactions** | `s_poll_interval_ms` |
| BLE notify | 500 ms tick; slots and unit on alternate passes = 1 Hz | `notify_task()` |

The 9-transaction poll cycle is the whole point of the v2 map: eight per-slot
runtime bursts of 12 registers plus one unit burst. Under v1 the same data
cost 33 transactions.

**The 6.645 kSPS figure was read off the live device, not off the headers.**
`bts_user_settings.h` contradicted itself for a long time — the comment block
around `BTS_ADC_SOC_PRESCALE` said prescale 10 and 9.97 kSPS while the
`#define` two lines below said 15, and it assumed SYSCLK 200 MHz when this
build runs at 180 (`_LAUNCHXL_F28379D` is not defined, so `device.h` takes
the IMULT-18 branch). Five registers settle it with nothing left to infer:
`PERCLKDIVSEL` 0x51 (EPWMCLK = SYSCLK/2 = 90 MHz), `TBCTL` 0x8010 (up-count,
both dividers ÷1), `TBPRD` 902 (90e6/903 = 99.67 kHz), `ETPS` 0x0820
(`SOCPSSEL` set, so the extended divider is the live one) and `ETSOCPS`
0x005F (`SOCAPRD2` = 15). 99.67 kHz / 15 = 6.645 kSPS. Anything derived from
the old numbers — filter coefficients, ISR budgets, aliasing arguments — is
wrong by a factor of 1.5; the CLA's alpha was, and had to be corrected from
0.012605 (13.3 Hz) to 0.018912.

---

## 3. Command path — host to converter

The reverse direction, and the one with the hazard in it: **CPU1 does not
decode every register CPU2 accepts.**

```mermaid
sequenceDiagram
    autonumber
    participant H as Host — BLE / HTTP / CAN
    participant E as ESP32<br/>bts_link
    participant C2 as CPU2<br/>I2CA target
    participant C1 as CPU1<br/>control core
    participant P as Converter

    H->>E: set mode / limits
    E->>C2: I2C write<br/>addr + 4 big-endian bytes

    Note over C2: regConfig[] access check.<br/>A write to an RO register is<br/>DROPPED with no NAK.

    C2->>C2: registers[idx] = value
    C2->>C2: reload host watchdog
    C2->>C1: ipcMsg{regAddr, value}<br/>+ IPC_FLAG0

    Note over C1: BTS_HandleRegisterWrite()<br/>decodes BY INDEX RANGE

    alt settings region, offset == MODE
        C1->>C1: modeCallback()<br/>latch limits, set enable_logic
        C1->>P: start / stop / direction
    else settings region, calibration group
        C1->>C1: BTS_loadCalibrationFromRegisters(ch)<br/>schedule recalculation
    else eCalCommand
        C1->>C1: calHandleCommand()
    else anything else
        C1-->>C1: flag ACKed, value DISCARDED
    end

    C1->>C2: ack IPC_FLAG0

    Note over C1,C2: eCalibrationMode and eHostWatchdog_s<br/>fall in the last branch. They are<br/>handled ON CPU2 and never reach here.

    P-->>C1: measurements
    C1->>C2: cpu1Status (seqlock)
    C2->>C2: mirror into registers[]
    E->>C2: next poll burst
    C2-->>E: updated values
    E-->>H: notify / JSON
```

### The trap

The decode on CPU1 is **by index range**, so every comparison in it is wrong
after a map change — and the failure is silent. CPU2 accepts the host write,
stores it in `registers[]`, raises the IPC flag, and CPU1 acks the flag without
acting. The host sees its value read back correctly on the next poll, because
it is genuinely in the register file. It just does nothing.

This has happened twice: once when the calibration block moved outside the
decode, and it is why `eCalCommand` has an explicit branch rather than falling
into the settings range.

**Registers handled entirely on CPU2** — and so correctly "discarded" by CPU1:
`eCalibrationMode`, `eHostWatchdog_s`, the four global voltage thresholds.

### Ordering rules that are not advisory

- **Limits before mode.** `modeCallback()` latches the four limit registers
  at start. Writing them afterwards affects nothing until the next start.
- **Argument before opcode.** `eCalCommand` is consumed on write and
  self-clears; an argument that arrives afterwards applies to nothing. A burst
  write from `eCalSlot` covering slot/command/argument delivers them in
  exactly the wrong order.

---

## 4. Settings and persistence

Two separate F-RAM images with different lifetimes, deliberately kept apart.

```mermaid
flowchart TD
    subgraph HOST ["Host"]
        SET["write limits<br/>V min/max, I min/max"]
        CAL["calibration<br/>COMPUTE_SAVE"]
    end

    subgraph RAM ["registers[] on CPU2"]
        SETR["settings block<br/>BTS_SET_BASE(ch) + 1..4"]
        CALR["calibration group<br/>BTS_CAL_BASE(ch), 12 regs"]
    end

    subgraph FRAM ["FM24V10 F-RAM — I2CB 0x50"]
        STATE["slot runtime state<br/>0x0500, 64-byte stride<br/>header 0x5A5F"]
        CALB["calibration image<br/>128-byte stride<br/>header 0xA5CD"]
        GLOB["global thresholds<br/>0x0400"]
    end

    SAVE["periodic save<br/>every 6 s + on<br/>state change"]
    RESTORE["supervision mailbox<br/>→ CPU1 acts"]
    GLOBR["global thresholds<br/>in registers[]"]

    SET --> SETR
    CAL --> CALR

    SETR -->|"saved with the<br/>run counters"| SAVE
    SAVE --> STATE
    CALR -->|"explicit save only"| CALB

    CALB -->|"boot load"| CALR
    GLOB -->|"boot load"| GLOBR

    STATE -.->|"boot restore:<br/>PAUSED + RESTORED,<br/>NEVER auto-resumed"| RESTORE

    style RESTORE stroke-width:2px
```

### Why the limits are not in the calibration image

Calibration is measured once against a traceable reference. Operating limits
change whenever someone adjusts a charge current. Keeping them in the same
F-RAM block meant rewriting the calibration image on every settings change,
which is what kept putting a measured calibration at risk of a partial write.
The limits now live in the slot's runtime-state record instead.

### The two headers, and why they were bumped

| Image | Header | Bumped because |
|---|---|---|
| Calibration | `0xA5CD` | the `calFlags`/`crc32` revision and the fixed 128-byte stride. Also fixed a collision in which channel 4's block overwrote the global voltage thresholds — which consequently had **never** persisted |
| Slot state | `0x5A5F` | the record grew to 64 bytes. The previous 20-word record ran 8 bytes into the next slot's header, so only slot 7 could ever validate |

Both bumps reject old images rather than reinterpreting them. Every slot falls
back to compiled defaults once and must be recalibrated.

### The restore rule

A slot that was mid-run when the unit reset comes back **PAUSED**, with its
counters intact, carrying `BTS_STATUS_RESTORED`, and **refuses to resume on
its own**. The cell may have been changed while the unit was off. Neither the
firmware nor the proxy will resume it; it takes an explicit command. This is
the single most safety-critical rule in the supervision design.

### I2CB is shared, and the two access styles do not mix

The F-RAM and both ADS1119 converters sit on the same bus, driven from the
same idle loop but in incompatible styles: the converters use a non-blocking
state machine that leaves a transfer **in flight** across service calls, while
the F-RAM uses blocking helpers that complete inside one call.

With no arbitration the frames interleaved, both were corrupted, and the
controller was left holding SCL with nothing running to clear it. Measured:
every F-RAM access failing, the failure and recovery counters climbing past
47 000 together, while both converters read correctly throughout.

`i2cbFramBusy` serialises them. A F-RAM acquire succeeds only while **both**
converters are parked in `eAdsIdle` or `eAdsSettle` — the only two states
holding no transaction — and a save that cannot acquire stays pending and
retries rather than being lost.

---

## 5. Calibration data flow

The operator procedure is in [`README.md`](README.md) and the state machine
and mathematics in [`calibration-design.md`](calibration-design.md) — the
diagrams for those are in [`calibration-flow.md`](calibration-flow.md). What
follows is only where the data goes.

```mermaid
sequenceDiagram
    autonumber
    participant D as DMM<br/>SCPI over LAN
    participant S as calibrate.py
    participant E as ESP32
    participant C2 as CPU2
    participant C1 as CPU1
    participant F as F-RAM

    Note over S,C1: ENTER — one slot at a time, unit-scoped

    S->>E: CAL_CMD_ENTER (slot N)
    E->>C2: write eCalSlot, then eCalCommand
    C2->>C1: IPC → calHandleCommand()
    C1->>C1: calState[N] = IDLE<br/>enable_logic low, measurement still runs

    loop while calibrating
        C1->>C2: cpu1Status.calTelemetry[9]
        C2->>C2: mirror to registers 1032–1064
        E->>C2: 15-register burst from 1008
        E->>S: live pu + engineering values
        S->>S: gate on pu window<br/>< 0.2 low, > 0.8 high
    end

    D->>S: READ? → traceable value
    S->>E: CAPTURE_VOLTAGE / CAPTURE_CURRENT<br/>argument = magnitude
    E->>C2: write eCalArgument, THEN eCalCommand
    C2->>C1: IPC
    C1->>C1: store capture point

    S->>E: COMPUTE_SAVE
    E->>C2: opcode
    C2->>C1: IPC
    C1->>C1: two-point fit, validate<br/>reciprocal pairs within 0.1 %
    C1->>C2: calComputed[12] + calSaveSeq
    C2->>F: write 128-byte block, CRC32
    C2->>C2: registers[] ← computed gains
    C2->>C1: IPC_FLAG2 — reload channel
    C1->>C1: recalculate program variables
```

### Three things worth keeping in mind

**Telemetry is unit-scoped, not per-slot.** Only one slot calibrates at a
time; eight copies of the nine-register window would cost 144 words of message
RAM and buy nothing.

**"Raw pre-gain" means exactly that.** The `< 0.2` / `> 0.8` capture windows
are checked against the normalised converter reading *before* any calibration
gain or offset. The two paths normalise differently, and the internal path's
quantity is **volts at the pin**, not dimensionless:

```
ADS path:       sum / (BTS_senseAverageFactor * 32768.0)
Internal path: (sum / (BTS_f28AverageFactor * 4096.0)) * 2.5
```

**Enter the DMM current as a magnitude.** Calibration runs in discharge and
the firmware applies the sign itself. Entering a negative value inverts that
slot's current reading — it will look plausible, pass validation, and be wrong
on every subsequent discharge.

---

## 6. Host interfaces — who can do what

Three transports reach the unit, and they do **not** offer the same controls,
because there are two separate control surfaces:

- **The test engine**, on the ESP32. `start` runs a whole characterisation —
  check rest, charge, rest, discharge, rest, optional recharge — and picks the
  direction itself.
- **The mode register**, on the C2000. Writing `eChX_Mode` commands the
  converter directly: run/stop and charge/discharge, nothing more.

"Test this cell" is the first. "Charge this slot" is the second.

```mermaid
flowchart TD
    subgraph CLIENTS ["Clients"]
        HA["Home Assistant<br/>lion_lvrt"]
        PY["calibrate.py<br/>ble_verify.py"]
        BROWSER["Browser / curl"]
        BENCH["AT console<br/>debug build only"]
    end

    subgraph TRANSPORT ["Transports"]
        BLE["BLE GATT<br/>12 chars, proto v4"]
        HTTP["HTTP :80<br/>JSON, no auth"]
        CAN["CAN 500 kbit/s<br/>ext IDs from 0x1C000000"]
        UART["SCIA 115200 8N1"]
    end

    subgraph SURFACES ["Control surfaces"]
        ENGINE["test engine<br/>ESP32"]
        MODE["mode register<br/>C2000"]
    end

    HA --> BLE
    HA --> HTTP
    HA --> CAN
    PY --> BLE
    BROWSER --> HTTP
    BENCH --> UART

    BLE --> ENGINE
    BLE -->|"char 000d,<br/>proto v4 only"| MODE
    HTTP --> ENGINE
    HTTP --> MODE
    CAN -->|"msg object 9"| MODE
    UART --> MODE

    MODE --> BTS["registers[] on CPU2"]
    ENGINE --> BTS
```

| Transport | Test engine | Charge / discharge | Needs |
|---|:---:|:---:|---|
| **BLE** | yes | only on proto ≥ 4 | an adapter or connectable proxy in range |
| **HTTP** | yes | yes | the tester joined to your WiFi |
| **CAN** | no | yes | SocketCAN on the host, wired to the unit |
| **AT console** | no | yes | a debug build — the pins carry the LEDs in production |

The BLE register characteristic (`000d`) was added in `BLE_PROTO_VERSION` 4.
A client talking to older proxy firmware has no way to reach the mode
register, which is why the Home Assistant integration hides charge and
discharge from the mode dropdown rather than offering an action that would
fail.

### The host watchdog cuts across all of them

Any host command on **any** interface reloads it — including an I2C register
*read*, which is what a polling host actually does. If nothing talks to the
unit for 30 seconds, every running slot pauses with the converter off and
`BTS_STATUS_WD_TRIPPED` set.

It is a supervision timeout measured in seconds. It is **not** over-current
protection, and with the hardware trips disabled in this build the only fast
protection is the bench supply's own current limit.

---

## 7. CAN telemetry — read the caveat

Message objects 1–8 carry per-channel telemetry; object 9 is a host register
read/write.

The per-channel frame is 8 bytes and packs only two quantities:

| Byte | Contents |
|---|---|
| 0 | channel index |
| 1 | zero |
| 2–5 | `voltage`, all four bytes |
| 6–7 | `current`, **low word only** |

**The current field is truncated.** `sendCANData()` packs `c[0]` and stops —
the float's upper word never goes on the wire, so the value cannot be
reconstructed. `canData` also carries `mAh` and `mWh` and **neither is
transmitted at all**; the frame has no room left.

A host that needs current or the accumulators reads them through the register
mailbox on message object 9 instead. The telemetry frames are trustworthy for
voltage only.
