# Supervision, Pause State and Register Map v2 — Design Specification

Authoritative contract for three coupled changes to the BTS firmware and the
ESP32 proxy:

1. A **30 s host watchdog** that pauses every slot if the host stops talking.
2. A **PAUSED** slot state, with direction-scoped counters that survive it.
3. **FRAM state persistence** every 6 s, restored as PAUSED on boot.

Plus the register-map reorder that makes per-slot runtime data readable in one
burst, and per-direction run-time seconds counters.

This document is the contract. Implementations must not deviate from the
addresses, bit positions or opcodes here without updating this file first.

---

## 0. Why this exists

The instrument charges lithium cells unattended. Today, if the ESP32 loses
power or its I2C link drops, **the converters keep running** — there is no
supervision timeout anywhere in the firmware. That is the safety gap this
closes.

The persistence and pause work follows from the same requirement: a slot that
was mid-run when the BTS reset must come back knowing what it was doing and
how far it had got, without silently resuming into a cell that may have been
swapped in the meantime.

---

## 1. Register map v2 — breaking reorder

### 1.1 Why reorder at all

A slot's live data is currently spread across five blocks (control 36, stats
320, cell temp 992, sense 1092, discharge 1156). Reading eight slots costs the
ESP32 ~33 I2C transactions per cycle. Grouping each slot's runtime data
contiguously makes it **one burst per slot**.

> **This breaks every hard-coded address.** 81 defines in the ESP32 mirror and
> the superseded `esp32-controller` component. Both the C2000 and the ESP32
> must be rebuilt and flashed together — there is no compatibility window. The
> superseded `esp32-controller` is left broken; it already has two other
> defects and is documented as do-not-use.

### 1.2 Layout

Three regions. Per-slot strides are fixed and generous so a future field does
not shift everything again.

| Region | Base | Stride | Regs/slot | Range |
|---|---|---|---|---|
| **Runtime** (RO) | 0 | 48 B (12 regs) | 12 | 0 – 383 |
| **Settings** (RW) | 384 | 96 B (24 regs) | 24 | 384 – 1151 |
| **Unit** | 1152 | — | — | 1152 – 1256 |

Verified arithmetic: runtime ch7 ends at 383, immediately before the settings
base; settings ch7 ends at 1151, immediately before the unit base.

**Total 315 registers**, top address 1256. That is 10 more than v1's 305: the
16 new run-time-seconds registers, less the 16 deleted min/max-voltage
registers, plus 8 spare settings slots, the watchdog timeout register and the
watchdog countdown register. Costs **19 words** of `CPU2TOCPU1RAM`. Confirm
against the map file after building — overflow here is a link-time failure
(`#10099-D`).

### 1.3 Runtime block — `BTS_RT_BASE(ch)`, stride 48

Everything a host polls at 1 Hz, in one burst of 12 registers.

| Offset | Enum | Units | Source |
|---|---|---|---|
| +0 | `eChX_Status` | bitfield | §2 |
| +4 | `eChX_CellVoltage` | V | internal 12-bit ADC |
| +8 | `eChX_CellCurrent` | A | internal 12-bit ADC |
| +12 | `eChX_SenseVoltage` | V | ADS131M08 16-bit |
| +16 | `eChX_SenseCurrent` | A | ADS131M08 16-bit |
| +20 | `eChX_CellTemp` | °C | ADS1119 |
| +24 | `eChX_ChargeAcc_mAh` | mAh | §3 |
| +28 | `eChX_ChargeAcc_mWh` | mWh | §3 |
| +32 | `eChX_ChargeRuntime_s` | s | §3 |
| +36 | `eChX_DischargeAcc_mAh` | mAh | §3 |
| +40 | `eChX_DischargeAcc_mWh` | mWh | §3 |
| +44 | `eChX_DischargeRuntime_s` | s | §3 |

All `REG_ACCESS_RO`. Channel 0 at 0–47, channel 7 at 336–383.

### 1.4 Settings block — `BTS_SET_BASE(ch)`, stride 96

Everything a host writes, grouped per slot so configuring a slot is also one
burst. 24 registers of which 21 are used; 3 spare for future settings.

| Offset | Enum | Access |
|---|---|---|
| +0 | `eChX_Mode` | RW |
| +4 | `eChX_ChargeVoltageMin` | RW |
| +8 | `eChX_ChargeVoltageMax` | RW |
| +12 | `eChX_DischargeVoltageMin` | RW |
| +16 | `eChX_DischargeVoltageMax` | RW |
| +20 | `eChX_ChargeCurrentMin` | RW |
| +24 | `eChX_ChargeCurrentMax` | RW |
| +28 | `eChX_DischargeCurrentMin` | RW |
| +32 | `eChX_DischargeCurrentMax` | RW |
| +36 | `eChX_MinCellTemp` | RW |
| +40 | `eChX_MaxCellTemp` | RW |
| +44 | `eChX_F28V_Gain` | RW |
| +48 | `eChX_F28V_Offset` | RW |
| +52 | `eChX_F28I_Gain` | RW |
| +56 | `eChX_F28I_Offset` | RW |
| +60 | `eChX_IoutGain_pu` | RW |
| +64 | `eChX_IoutOffset_pu` | RW |
| +68 | `eChX_IoutGain_A` | RW |
| +72 | `eChX_IoutOffset_A` | RW |
| +76 | `eChX_VoutGain_pu` | RW |
| +80 | `eChX_VoutOffset_pu` | RW |
| +84 | `eChX_VoutGain_V` | RW |
| +88 | `eChX_VoutOffset_V` | RW |
| +92 | *(spare)* | — |

The 12-register calibration block keeps its internal order, so
`BTS_CAL_F28V_GAIN`..`BTS_CAL_VOUT_OFFSET_V` remain offsets 0..11 **relative to
`eChX_F28V_Gain`**. `saveCalibration()`/`loadCalibration()` index through a new
`BTS_CAL_BASE(ch) = BTS_SET_BASE(ch) + 11` and need no other change.

### 1.5 Unit block — base 1152

| Addr | Enum | Access |
|---|---|---|
| 1152 | `eChargeDisableV` | RW |
| 1156 | `eChargeRestrictV` | RW |
| 1160 | `eDischargeRestrictV` | RW |
| 1164 | `eDischargeDisableV` | RW |
| 1168 | `eCalibrationMode` | RW |
| 1172 | `eUnitState` | RO |
| 1176 | `eInputVoltage` | RO |
| 1180 | `eTripStatus` | RO |
| 1184 | `eSlotMode` | RO |
| 1188 | `eSlotEnable` | RO |
| 1192 | `eGroupSize` | RO |
| 1196 | `eHostWatchdog_s` | RW | §4 |
| 1200 | `eCalSlot` | RW |
| 1204 | `eCalCommand` | RW |
| 1208 | `eCalArgument` | RW |
| 1212 | `eCalStatus` | RO |
| 1216 | `eCalResult` | RO |
| 1220 | `eWatchdogRemaining_s` | RO | §4 |

Calibration telemetry (the 9 live values) follows at **1224–1256**, keeping its
existing internal order. 1256 is the top of the map.

`eWatchdogRemaining_s` is the live countdown, in seconds, so a host can show
how long is left rather than only that supervision is armed. It reads **0**
when the watchdog has fired **and** when it is disabled; a host distinguishes
the two by reading `eHostWatchdog_s`, which is in the same burst. CPU2 owns
it and writes it straight into `registers[]` — no IPC, since CPU2 owns both
the register file and the timebase.

### 1.6 Registers removed

`eChX_MinVoltage` and `eChX_MaxVoltage` (v1 324/328) are **deleted**. They were
declared RO and never written on either core — 16 registers of permanent 0.0.
Removing them offsets most of the cost of the 16 new run-time-seconds
registers.

If per-run voltage extremes are wanted later, add them to the settings block's
spare space — and actually write them.

---

## 2. Slot state model

### 2.1 The five states

A slot is in exactly one of:

| State | Meaning |
|---|---|
| **STOPPED** | Idle. Converter off. Counters hold their last values. |
| **CHARGING** | Running, delivering charge. |
| **DISCHARGING** | Running, drawing charge. |
| **PAUSED** | Was charging or discharging; converter off, direction remembered, counters frozen and intact. |
| **END** | Test finished normally. Converter off, counters hold final values. |

`PAUSED` is **not** a direction of its own. A paused slot keeps its
`CHARGING` or `DISCHARGING` status bit set alongside `PAUSED`, so a host can
see both that it is paused and what it will resume into.

### 2.2 Status bits

Bits 0–14 keep their current meaning and positions. Append:

```c
#define BTS_STATUS_PAUSED            15U
#define BTS_STATUS_END      BTS_STATUS_FINISHED  /* bit 2 - see below */
#define BTS_STATUS_WD_TRIPPED        17U  /* paused *by the watchdog*      */
#define BTS_STATUS_RESTORED          18U  /* paused by a FRAM boot restore */
```

Bits 17 and 18 distinguish *why* a slot is paused, which a host needs to decide
whether resuming is safe. Both are cleared on resume.

> **Ceiling is bit 23.** The word crosses to hosts as a float32 whose 24-bit
> significand is exact only to bit 23. Do not go past it.

The existing `BTS_STATUS_FINISHED` (bit 2), never written to date, becomes the
`END` indicator and is now driven — keep both the old name and the new
semantic, do not add a second bit for the same thing.

> **Corrected 2026-09-19.** An earlier revision of this table defined
> `BTS_STATUS_END` as bit **16** while the paragraph above required bit 2 to
> carry the meaning — the two could not both be true. Resolved in favour of
> the paragraph: `BTS_STATUS_END` is an **alias for bit 2**, and **bit 16 is
> unused and free**. A host must read bit 2 for END. Anything that polled bit
> 16 will read a constant 0.

### 2.3 Transitions

```
  STOPPED ──start(charge)──> CHARGING ──┐
  STOPPED ──start(discharge)─> DISCHARGING ──┐
                                             │
  CHARGING/DISCHARGING ──watchdog timeout──> PAUSED (+WD_TRIPPED)
  CHARGING/DISCHARGING ──pause command────> PAUSED
  CHARGING/DISCHARGING ──trip/fault───────> STOPPED
  CHARGING/DISCHARGING ──termination──────> END

  PAUSED ──resume command──> CHARGING or DISCHARGING  (whichever it held)
  PAUSED ──stop command────> STOPPED
  END    ──start───────────> CHARGING or DISCHARGING
  boot with saved run ─────> PAUSED (+RESTORED)
```

**Entering PAUSED always zeroes the converter reference first**, then clears
`enable_logic`. Same ordering as a trip exit.

### 2.4 Mode register

`eChX_Mode` gains two command bits alongside the existing run/direction bits:

| Bit | Meaning |
|---|---|
| 0 | run (1) / stop (0) |
| 1 | charge (1) / discharge (0) |
| 2 | enter calibration (existing) |
| 3 | **pause** — write 1 to pause a running slot |
| 4 | **resume** — write 1 to resume a paused slot |

Bits 3 and 4 are edge commands: acted on at the write and not retained. Writing
resume to a slot that is not paused returns without effect. Writing bit 0 = 1
to a paused slot is also a resume, so a host that only knows the old protocol
still works.

---

## 3. Counters

### 3.1 What accumulates

Per slot, two independent sets:

| Set | mAh | mWh | seconds |
|---|---|---|---|
| Charge | `eChX_ChargeAcc_mAh` | `eChX_ChargeAcc_mWh` | `eChX_ChargeRuntime_s` |
| Discharge | `eChX_DischargeAcc_mAh` | `eChX_DischargeAcc_mWh` | `eChX_DischargeRuntime_s` |

Both accumulate **positive magnitude into their own direction**, so a charge
followed by a discharge yields two separate positive totals rather than
cancelling.

Integrate `Isense_A`/`Vsense_V` — the 16-bit ADS131M08 pair, the sensor the CC
loop regulates against. The run-time seconds counter advances by the same
timestep, so all three of a direction's counters stay consistent.

### 3.2 When they advance

Only while the slot is **actually running**: `CHARGING` or `DISCHARGING`, not
`PAUSED`, not `STOPPED`, not `END`, not calibrating. A paused slot's counters
freeze and resume exactly where they left off — that is the point of the state.

### 3.3 When they reset

**Only on a fresh start**, and only the set for the direction starting:

- `STOPPED → CHARGING` zeroes the charge set. Discharge set untouched.
- `STOPPED → DISCHARGING` zeroes the discharge set. Charge set untouched.
- `END → CHARGING` / `END → DISCHARGING` likewise.
- `PAUSED → resume` zeroes **nothing**.
- A trip, a fault or a watchdog pause zeroes **nothing**.

So a full charge-then-discharge cycle ends with both sets populated, which is
the intended result.

---

## 4. Host watchdog

### 4.1 Behaviour

A countdown, default **30 s**, reloaded by **any** host command on any
interface. When it reaches zero, every slot that is `CHARGING` or
`DISCHARGING` transitions to `PAUSED` with `WD_TRIPPED` set.

The timeout is configurable at `eHostWatchdog_s` (1196), RW, in seconds.
Writing **0 disables** the watchdog — necessary for bench work where nothing is
polling, and it must be logged loudly when it happens.

### 4.2 What reloads it

Every host command on every interface: I2C register write, I2C register
**read** (a polling host proves it is alive by reading), UART AT command, CAN
register access. All three write paths already funnel through
`applyHostRegisterWrite()` (`com_cpu2.c:2174`), reached from
`BTS_serviceDeferredWork()` for I2C, `canISR()` and `uartRxISR()`. Reads need
their own hook in the I2C target path.

Reload the counter from the **one** place each interface touches, not scattered
through the parsers.

### 4.3 Where it runs

CPU2 owns it — it owns the interfaces and the timebase. Decrement in the
existing `timerISR()` (CPU Timer 1, already running), and signal CPU1 through a
new field in the register file, which CPU1 already polls. CPU1 performs the
actual pause, because CPU1 owns `enable_logic` and the control loop.

**CPU2 must never write to a slot's control state directly** — the single-writer
rule stands. It sets a flag; CPU1 acts on it.

### 4.4 Not a substitute for the trip system

The watchdog is a supervision timeout measured in seconds. It is not, and must
not be described as, over-current protection. Say so in the documentation:
hardware over-current trips are currently disabled and the software check in
`BTS_tripEpwm()` remains the only fast protection.

---

## 5. FRAM state persistence

### 5.1 What is saved

Every **6 s**, and additionally on any state transition, CPU2 writes a
per-slot record:

```c
typedef struct {
    uint32_t  header;      /* 0x5A5E0000 | channel                      */
    uint32_t  stateFlags;  /* running direction + END, at save time      */
    float32_t chargeMah;
    float32_t chargeMwh;
    float32_t chargeSeconds;
    float32_t dischargeMah;
    float32_t dischargeMwh;
    float32_t dischargeSeconds;
    uint32_t  saveCounter;  /* increments every save; staleness/wear info */
    uint32_t  crc32;        /* over all preceding fields                  */
} BTS_slotRuntimeState;
```

### 5.2 FRAM map

Existing content is untouched. The new block starts clear of it:

```
0x0000 - 0x03FF   calibration, 8 channels x 128 B stride
0x0400 - 0x040F   global voltage thresholds
0x0500 - 0x05FF   slot runtime state, 8 slots x 32 B stride   <-- new
```

`#define STATE_FRAM_BASE 0x0500U`, `#define STATE_FRAM_STRIDE 32U`. A fixed
stride decoupled from `sizeof`, for the same reason as the calibration block —
adding a field must not move every slot.

### 5.3 Write discipline

- **Never from an ISR.** Set a pending flag; `BTS_serviceDeferredWork()` does
  the write, exactly as `calibrationSavePending` already does.
- Stagger the eight slots across the 6 s window rather than writing all eight
  in one pass, so a save never blocks the I2C controller for long.
- FM24V10 F-RAM has no write-endurance concern at this rate (10^14 cycles), so
  a periodic unconditional write is fine. Do not add wear-levelling.

### 5.4 Boot restore

In `loadCalibration()`'s boot path, after calibration:

1. Read each slot's record; validate header and CRC.
2. **Invalid or absent** → slot starts `STOPPED`, counters zeroed. This is the
   normal first-boot case and must not be logged as an error.
3. **Valid, saved state was STOPPED or END** → restore the counters, restore
   that state. Nothing was running, so nothing to resume.
4. **Valid, saved state was CHARGING or DISCHARGING** → restore the counters
   **and** set `PAUSED` + `RESTORED`, with the saved direction bit. The
   converter stays off. The slot resumes only on an explicit command.

Rule 4 is the safety-critical one: **a slot never resumes power by itself after
a reset.** The cell may have been changed while the unit was off.

Publish the restored state to CPU1 through the existing calibration-reload IPC
pattern — one flag after the whole file is consistent, not one per slot.

---

## 6. ESP32 work

### 6.1 `bts_regs.h`

Rewrite for the v2 map: `BTS_RT_BASE`/`STRIDE`/`ADDR`, `BTS_SET_BASE`/etc, the
new unit addresses, the four new status bits, the two mode command bits.

> In this file the offsets are **byte** offsets and `BTS_STATUS_*` are
> **masks**, where the C2000 header uses register **indices** and bit
> **positions**. The warning block above `BTS_STATUS_RUNNING` explains it. Do
> not transcribe C2000 lines directly.

### 6.2 `bts_link.c`

- Poll each slot's runtime block as **one 12-register burst**. That takes the
  cycle from ~33 transactions to ~10 (8 slots + unit + calibration window).
- Preserve the lead-in pad byte handling in `bus_read_block()`.
- Extend `bts_channel_state_t` with the paused/end/watchdog/restored flags and
  the six counters.
- Add `bts_link_pause_channel()` / `bts_link_resume_channel()`.
- **Feed the watchdog**: the existing 250 ms poll already reads registers, which
  reloads it. Verify that is true of the *read* path, not just writes.

### 6.3 Boot-restore handling

On startup, and whenever a slot appears with `RESTORED` set, the test engine
must **not** auto-resume. Surface it: the slot shows as paused-restored with its
counters, and resuming is a user action over HTTP or BLE.

### 6.4 HTTP and BLE

- `POST /api/slot/<n>/pause` and `/resume`.
- BLE: extend `ble_cmd_t` opcodes with PAUSE and RESUME; add the paused/end/
  watchdog/restored flags and the six counters to `ble_slot_status_t`. Bump
  `BLE_PROTO_VERSION` to 3. Packed little-endian; do not renumber existing
  characteristics.
- `GET /api/status` reports the watchdog's remaining seconds and configured
  timeout.

### 6.5 Display

Show `PAUSE` for a paused slot in `state_letter()`, distinctly from stopped —
and flag a watchdog pause differently from a user pause, since one means the
link died and the other was deliberate.

### 6.6 LED

A paused slot flashes. Rank it below the fault states and above running, the
same way the calibration flash is ranked.

---

## 7. AT commands

The register names follow the map automatically through `uartRegConfig[]`, so
the new registers are addressable as soon as the table is updated. Add explicit
short names for the new runtime registers (`C0CHS` charge seconds, `C0DHS`
discharge seconds, `WD` watchdog) following the existing convention.

Pause/resume are reachable by writing the mode register, but add
`AT+C0PAUSE` / `AT+C0RESUME` as well — an operator at a serial console should
not have to compute a bitmask to stop a cell safely.

> The AT console is **conditional**: `BTS_DEBUG_CONSOLE` must be `true`, and in
> that build the WS2812B LED driver and channel 1's GPIO trip are compiled out
> (they share GPIO28/29). Serial testing and LED testing cannot happen in the
> same build.

---

## 8. Verification

Build and load both cores plus the ESP32, then:

1. **Watchdog.** Start a slot, pull the ESP32's I2C or power it down, confirm
   the slot pauses within 30 s with `WD_TRIPPED` set and the converter off.
   Confirm the counters froze and did not reset.
2. **Resume.** Reconnect, resume over I2C, confirm the counters continue from
   where they stopped rather than restarting.
3. **AT path.** Over the serial console: query a slot, pause it, resume it,
   read the counters. Confirm the watchdog is fed by AT traffic alone.
4. **Counter reset rule.** `STOPPED → charge → stop → discharge` must leave the
   charge set intact while only the discharge set zeroes at its start.
5. **Persistence.** Start a slot, wait past 6 s, reset the BTS. Confirm the slot
   comes back `PAUSED|RESTORED` with its counters and that it does **not**
   deliver current until resumed.
6. **First boot.** Erase the state block; confirm a clean `STOPPED` start with
   no error spam.
7. **BLE.** Verify the new opcodes and the extended status record, and that a
   stale client sees a clean version mismatch rather than garbage.

Bench preconditions that otherwise waste time: input supply above
`eChargeDisableV` or nothing starts; a latched `TZOSTFLG` cannot be cleared
while its source is asserted; and with hardware trips disabled, do not leave
high-current tests unattended.
