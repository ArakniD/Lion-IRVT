# Slot Calibration — Design and Implementation Specification

Authoritative design for the externally-referenced, per-slot calibration process
across the C2000 BTS firmware, the ESP32 proxy, and the bench automation script.

This document is the contract. Implementations must not deviate from the register
addresses, command opcodes, status bits, or mathematics defined here without
updating this file first.

---

## 1. Goal

Replace the compile-time calibration constants in `bts_user_calibration.h` with a
runtime, externally-referenced two-point calibration performed per slot, using:

- an external DC bench supply as the voltage source and current source, and
- an external DMM (Agilent/Keysight, LAN/SCPI) as the reference instrument.

Both measurement paths are calibrated simultaneously from the same physical
stimulus:

| Path | Device | Resolution | Registers calibrated |
|---|---|---|---|
| External | ADS131M08 | 16-bit | `IoutGain/Offset_pu`, `IoutGain/Offset_A`, `VoutGain/Offset_pu`, `VoutGain/Offset_V` |
| Internal | F2837xD on-chip ADC | 12-bit @ 2.5 V ref | `F28V_Gain/Offset`, `F28I_Gain/Offset` |

Results are persisted to the FM24V10 F-RAM and reloaded at boot.

---

## 2. Existing behaviour that must be preserved

- `registers[]` is written **only** by CPU2. CPU1 publishes via `cpu1Status`
  under the `seq` seqlock. Calibration must not violate this.
- Register addresses are hard-coded by external hosts. **Never insert a register
  mid-map.** All new registers append above the current top (`eGroupSize` = 1032).
- The `BTS_*_BASE(ch)` macros are the only legal way to index a block.
- `--float_operations_allowed=32`: no doubles, use `strtof` not `atof`.
- A C28x byte is 16 bits; a `float` is 2 words. Anything crossing I2C/CAN/UART
  must be packed explicitly.

### 2.1 Facts that are easy to get wrong

These were each verified in source and each one invalidates an obvious guess:

1. **The build is CC-only.** `BTS_LAB_TYPE = BTS_LAB_CLOSED_LOOP_ACMC_IOUT`
   (`bts_user_settings.h:305`) selects `BTS_ISR_CL_MODE_CC`. The CV loop and the
   CC-CV crossover in `bts.h:525-570` are **compiled out**. `voutRef_pu` is
   computed every millisecond and ignored. Fixed-current calibration therefore
   works with the live control path; a fixed-*voltage* calibration mode would
   not, and is deliberately not part of this design.

2. **The current sense side is never gain-corrected.** `ioutSense_pu =
   current_16b / 32768` (`bts.h:518`) — calibration is folded into the
   *setpoint* only (`bts.c:570`). The loop closes in raw-ADC per-unit space.
   This is precisely why `IoutGain_pu` (A→pu, for the reference) and
   `IoutGain_A` (pu→A, for reporting) are stored as a reciprocal pair.

3. **CPU1 does not see the new registers unless it is told to.**
   `BTS_HandleRegisterWrite()` (`bts_cpu1.c:568, 576-577`) only decodes indices
   below `eCh0_CurrentAcc` and inside the calibration block. Everything else —
   including `eCalibrationMode` at index 244 — has its `IPC_FLAG0` acked and
   silently discarded. The new block at 1036+ falls in the same hole and
   **must be added to the decode explicitly**, or every calibration command will
   be accepted by CPU2 and quietly ignored by CPU1.

4. **F-RAM writes never happen in an ISR.** Writing `eCalibrationMode = 2.0f`
   sets `calibrationSavePending` (`com_cpu2.c:1974-1976`) and the idle-loop
   `BTS_serviceDeferredWork()` (`com_cpu2.c:2076-2090`) performs the save. The
   comment at `com_cpu2.c:1961-1967` says this is deliberate. `CAL_CMD_COMPUTE_SAVE`
   must use the same deferred pattern.

5. **Status word ceiling is bit 23, not 31.** The word reaches the host as a
   `float32`, whose 24-bit significand makes integers exact only to bit 23
   (`registers.h:353-356`). Bits 12–23 are free; never go past 23.

6. `eCalibrationMode` decodes **only** exact float `2.0f`, with no tolerance, and
   is never cleared or acknowledged — there is no "save complete" indication
   today. The new `eCalStatus` bit 7 supplies one.

---

## 3. Bugs that must be fixed as part of this work

### 3.1 F-RAM channel 4 collides with the global voltage block

`CAL_EEPROM_BYTES = 2 * sizeof(BTS_channelCalibration)` = 64 wire bytes, and
`writeEEPROM()` uses `eepromAddr = channel * CAL_EEPROM_BYTES`
(`com_cpu2.c:747-754`). Channel 4 therefore occupies `0x0100`–`0x013F`, and
`EEPROM_GLOBAL_V_ADDR` is `0x0100`–`0x010F` (`com_cpu2.c:91`). They overlap on
channel 4's `header`, `dateTime`, `MinCellTemp` and `MaxCellTemp`.

The failure is invisible, which is why it has survived: `saveAllCalibration()`
iterates 0→7, so channel 0 writes the globals to `0x0100` and **channel 4 then
overwrites them**. At next boot `loadCalibration()` reads `0x0100` as globals,
gets channel 4's header and temps reinterpreted as floats,
`validateGlobalVoltages()` rejects them, and 9/10/15/16 V defaults are silently
installed. Channel 4's own block still validates, so nothing looks wrong — the
global thresholds simply never persist.

**Fix:** a fixed, generous stride with the globals moved well clear. The FM24V10
is 128 KiB, so space is not a constraint:

```c
#define CAL_FRAM_STRIDE_BYTES   128U        /* per channel, fixed, not sizeof-derived */
#define CAL_FRAM_BASE           0x0000U     /* ch N at BASE + N*STRIDE, ends 0x03FF */
#define EEPROM_GLOBAL_V_ADDR    0x0400U     /* was 0x0100 */
```

A fixed stride also decouples the wire layout from `sizeof`, so adding struct
fields no longer silently moves every channel's block.

### 3.2 `Isense_A` / `Vsense_V` are computed but never published

`BTS_monitor_Iout_Vout()` (`bts_cpu1.c:628-631`) produces the ADS131M08
engineering values, but nothing reads them — not `publishStatusToCpu2()`, not
`cpu1Status`, not `canData`, not `registers[]`. The 16-bit converter's readings
are dead, and every host interface today is showing the **12-bit internal ADC**
values via `eChX_CellVoltage` / `eChX_CellCurrent`.

This is the opposite of what the register-map naming suggests, and it must be
fixed before calibration: the process captures both paths simultaneously and
needs both visible.

### 3.3 CC/CV status bits are tracked but never reported

`BTS_ctrlLoopVariables[].ctrlMode_logic` tracks CC (0) vs CV (1) in the ISR
(`bts.h:558, 564, 570, 576`) but is never copied into
`status[].constCurrent/constVoltage`, so bits 6 and 7 are always 0. Copy it in
`publishStatusToCpu2()` — the calibration display shows the regulation mode, and
this is a two-line fix in the same function being edited anyway.

> Bits 2 (`FINISHED`), and the dead stats accumulators at 320/324/328/332, are
> also never written. Those are **out of scope** here — noted so the next reader
> does not mistake them for calibration regressions.

---

## 4. Register map additions

All addresses are byte addresses; index = address / 4. Appended contiguously
above `eGroupSize` (1032). Update `registers.h` enum, `NUM_*` counts,
`TOTAL_REGISTERS`, `regConfig[]` and `uartRegConfig[]` **together** — the tables
are sized `TOTAL_REGISTERS` and must stay index-aligned.

### 4.1 Calibration control block (unit-level, 5 registers)

Only one slot calibrates at a time, so this block is unit-scoped rather than
per-slot. That is a deliberate RAM decision — see §9.

| Addr | Enum | Access | Meaning |
|---|---|---|---|
| 1036 | `eCalSlot` | RW | Slot under calibration, 0–7. 255 = none. |
| 1040 | `eCalCommand` | RW | Command opcode, see §5. Write triggers action. |
| 1044 | `eCalArgument` | RW | Float payload for the command. Write **before** the opcode. |
| 1048 | `eCalStatus` | RO | Progress bitfield, see §5.2. |
| 1052 | `eCalResult` | RO | Result code of the last command, see §5.3. |

### 4.2 Calibration live telemetry (unit-level, 9 registers)

Live values for the slot named by `eCalSlot`, so the operator can watch the
calibration converge. Zero when no slot is selected.

| Addr | Enum | Access | Meaning |
|---|---|---|---|
| 1056 | `eCalAdsV_pu` | RO | ADS131M08 voltage, per-unit (raw, pre-gain) |
| 1060 | `eCalAdsI_pu` | RO | ADS131M08 current, per-unit (raw, pre-gain) |
| 1064 | `eCalAdsV_V` | RO | ADS131M08 voltage, volts (post-gain) |
| 1068 | `eCalAdsI_A` | RO | ADS131M08 current, amps (post-gain) |
| 1072 | `eCalF28V_pu` | RO | Internal ADC voltage, per-unit (raw, pre-gain) |
| 1076 | `eCalF28I_pu` | RO | Internal ADC current, per-unit (raw, pre-gain) |
| 1080 | `eCalF28V_V` | RO | Internal ADC voltage, volts (post-gain) |
| 1084 | `eCalF28I_A` | RO | Internal ADC current, amps (post-gain) |
| 1088 | `eCalTemp_C` | RO | Live cell temperature of the slot under calibration |

"Per-unit (raw, pre-gain)" is the normalised converter reading **before** any
calibration gain/offset is applied — this is the quantity the two-point maths
consumes, and it must not be silently pre-scaled.

- ADS path: `sum / (BTS_senseAverageFactor * 32768.0)`
- Internal path: `(sum / (BTS_f28AverageFactor * 4096.0)) * 2.5`

The internal-path quantity is in volts-at-the-pin, matching how
`BTS_monitor_Iout_Vout()` scales it (`bts_cpu1.c:632-635`). Keep that definition
exactly — the gain/offset pair is defined against it.

### 4.3 Per-slot external ADC engineering values (16 registers)

Fixes §3.2. Stride 8 bytes, base 1092.

| Addr | Enum | Access | Meaning |
|---|---|---|---|
| 1092 + ch*8 | `eChX_SenseVoltage` | RO | `Vsense_V`, ADS131M08 volts |
| 1096 + ch*8 | `eChX_SenseCurrent` | RO | `Isense_A`, ADS131M08 amps |

Range 1092–1152 (16 registers, stride 4). Add `BTS_SENSE_BASE(ch)` alongside the
existing base macros.

**Total added: 30 registers** (`TOTAL_REGISTERS` 259 → 289).

### 4.4 Status bits

Bits 0–11 are in use (`registers.h:372-383`). Append:

```c
#define BTS_STATUS_CALIBRATING     12U  /* slot is in the calibration state   */
#define BTS_STATUS_CAL_V_VALID     13U  /* voltage calibration computed & OK  */
#define BTS_STATUS_CAL_I_VALID     14U  /* current calibration computed & OK  */
```

Bits 13/14 drive the green ticks on the ESP32 display. They are set from the
persisted calibration validity, not merely from the in-session capture, so a slot
calibrated in an earlier session still shows its ticks.

Extend `status[]`, `publishStatusToCpu2()` and the ESP32 `bts_regs.h` mirror
(which currently stops at bit 7 — note `tools/ble_verify.py` already knows 12
names; reconcile all three).

### 4.5 Mode register

`eChX_Mode` bit 2 (`0x04`) = enter calibration. Writing it is equivalent to
`eCalSlot = X; eCalCommand = CAL_CMD_ENTER`. Both entry points route to the same
handler so the one-slot-at-a-time rule is enforced in one place.

---

## 5. Command protocol

Write `eCalArgument` first, then `eCalCommand`. The command is consumed on write,
`eCalResult` is updated synchronously, and `eCalCommand` self-clears to 0.

### 5.1 Opcodes

| Code | Name | Argument | Action |
|---|---|---|---|
| 0 | `CAL_CMD_NONE` | — | idle |
| 1 | `CAL_CMD_ENTER` | — | Put `eCalSlot` into the calibration state. Force-exits calibration on every other slot. Rejected if any slot is running a test. |
| 2 | `CAL_CMD_EXIT` | — | Zero the reference, disable the slot, leave calibration. Captures discarded unless already saved. |
| 3 | `CAL_CMD_CAPTURE_VOLTAGE` | measured volts | Sample both paths. Classify by ADS pu: `< 0.2` → low point, `> 0.8` → high point. Anything between is rejected with `CAL_ERR_PU_RANGE`. |
| 4 | `CAL_CMD_ZERO_CURRENT` | — | With the converter disabled and no current flowing, capture the zero-current pu of both current paths as the low point at 0.0 A. |
| 5 | `CAL_CMD_SET_FIXED_CURRENT` | pu setpoint | Put the slot into fixed-current **DISCHARGE** at the given uncalibrated pu. 1.0 pu ≈ 10 A (`BTS_ISET_MAX_A`), so 0.25 pu ≈ 2.5 A. Clamped, see §7. |
| 6 | `CAL_CMD_CAPTURE_CURRENT` | measured amps (magnitude) | Sample both current paths, store as the high point against the supplied magnitude. |
| 7 | `CAL_CMD_COMPUTE_SAVE` | — | Run the two-point maths (§6), validate, write F-RAM, reload into CPU1 via IPC. |
| 8 | `CAL_CMD_CLEAR` | — | Discard all in-session captures; stay in calibration. |

`CAL_CMD_CAPTURE_VOLTAGE` requires two captures on opposite sides before
`COMPUTE_SAVE` will compute a voltage result. Likewise current needs the zero
point plus one loaded point. `COMPUTE_SAVE` computes and saves whichever of the
two (voltage / current) is complete, and reports partial completion rather than
failing outright.

### 5.2 `eCalStatus` bitfield

| Bit | Meaning |
|---|---|
| 0 | Calibration active |
| 1 | Voltage low point captured |
| 2 | Voltage high point captured |
| 3 | Current zero point captured |
| 4 | Current loaded point captured |
| 5 | Voltage calibration computed and valid |
| 6 | Current calibration computed and valid |
| 7 | Written to F-RAM |
| 8 | Fixed-current mode currently driving |
| 9 | Last command failed (see `eCalResult`) |

### 5.3 `eCalResult` codes

`0` OK · `1` busy/another slot active · `2` slot running a test · `3` slot
disabled by strap or not a group leader · `4` pu outside the required window ·
`5` insufficient captures · `6` computed gain failed validation · `7` F-RAM write
failed · `8` argument out of range · `9` not in calibration state.

---

## 6. Two-point mathematics

The existing compile-time form in `bts_user_calibration.h:40-53` is the reference
and must be reproduced exactly so that runtime and compile-time results agree.

### 6.1 Voltage — external (ADS131M08)

Points `(pu_lo, V_lo)` and `(pu_hi, V_hi)`:

```
VoutGain_pu   = (pu_hi - pu_lo) / (V_hi - V_lo)
VoutOffset_pu = pu_lo - V_lo * VoutGain_pu
VoutGain_V    = 1.0 / VoutGain_pu
VoutOffset_V  = -VoutOffset_pu / VoutGain_pu
```

### 6.2 Voltage — internal (on-chip ADC)

Let `x = (sum / (BTS_f28AverageFactor * 4096.0)) * 2.5`, captured at the same two
instants as above, giving `(x_lo, V_lo)` and `(x_hi, V_hi)`:

```
F28V_Gain   = (V_hi - V_lo) / (x_hi - x_lo)
F28V_Offset = V_lo - x_lo * F28V_Gain
```

This inverts `CellVoltage_V = x * F28V_Gain + F28V_Offset` (`bts_cpu1.c:633`).

### 6.3 Current — external (ADS131M08)

Points `(pu_zero, 0.0)` and `(pu_hi, I_hi)`:

```
IoutGain_pu   = (pu_hi - pu_zero) / (I_hi - 0.0)
IoutOffset_pu = pu_zero
IoutGain_A    = 1.0 / IoutGain_pu
IoutOffset_A  = -IoutOffset_pu / IoutGain_pu
```

### 6.4 Current — internal (on-chip ADC)

With `x` defined as in §6.2 on the cell-current channel:

```
F28I_Gain   = (I_hi - 0.0) / (x_hi - x_zero)
F28I_Offset = -x_zero * F28I_Gain
```

### 6.5 Sign convention

Calibration current flows in **discharge**, which the control loop represents
with `direction_coeff = -1`. The operator enters the DMM reading as a
**magnitude**. The firmware applies the discharge sign internally so the stored
gain matches the running convention. Document this in the README — entering a
signed value is the single easiest way to invert a slot's current reading.

### 6.6 Guard conditions

Reject and return `CAL_ERR_PU_RANGE` / `CAL_ERR_VALIDATE` if:

- the two points are insufficiently separated (`|V_hi - V_lo| < 1.0 V`,
  `|I_hi| < 0.5 A`),
- any computed gain is zero, denormal, NaN or Inf,
- a computed gain falls outside the validation window in §8.

---

## 7. Calibration state and safety

`BTS_updateReference()` (`bts.c:557-605`) currently selects calibration behaviour
with the compile-time `BTS_CALIBRATION_ENABLED` / `BTS_CALIBATION_MODE` macros,
globally for all channels. **Convert this to a per-channel runtime state.** The
`ioutCal_pu` / `voutCal_pu` fields already exist in `BTS_userInput`
(`registers.h:532-533`) and are the right vehicle.

Add `volatile uint16_t calState;` to `BTS_userInput` (0 = normal, 1 = calibration
idle, 2 = calibration fixed-current). In `BTS_updateReference()`:

- `calState == 0` → existing normal-mode arithmetic, unchanged.
- `calState == 1` → `enable_logic = 0`, references zeroed. Measurement still runs.
- `calState == 2` → `ioutRef_pu = ioutCal_pu`, `voutRef_pu = 1.0`,
  `direction_logic = 0` (discharge), `direction_coeff = -1.0`.

The `BTS_CALIBRATION_ENABLED` macro path is removed; keep the header's
per-channel constants as boot defaults only.

### Mandatory safety rules

These are not optional and must be visible in code review:

1. **Trips stay armed.** CMPSS over-current and GPIO trip zones are never
   disabled, masked or re-thresholded during calibration. A trip exits
   calibration immediately and zeroes the reference.

   > **Bench warning.** All hardware over-current trips are presently disabled —
   > `BTS_TRIP_HW_CH1..8_ENABLED (false)`, `bts_user_settings.h:113-120` — leaving
   > the software check in `BTS_tripEpwm()` as the only over-current protection.
   > The file's own warning at `bts_user_settings.h:100-111` says not to run
   > unattended high-current tests in this configuration. Calibration drives real
   > current into an external supply, so **do not run this procedure unattended**,
   > and consider enabling hardware trips on the slot being calibrated first.

2. **Fixed-current pu is clamped.** Reject `CAL_CMD_SET_FIXED_CURRENT` with
   argument `< 0.0` or `> 0.8` pu (≈8 A). Returns `CAL_ERR_ARG`.
3. **Min-voltage cutout bypass is scoped.** It applies only to the slot in
   `calState == 2`, and only while it is. Every other slot keeps its cutout.
   Note the guard is on the **input bus** voltage, not cell voltage, and it is
   enforced in two places — at mode-write time (`bts_cpu1.c:472-485`) and again
   at 10 Hz in `C1()` (`bts_cpu1.c:815-830`). **Both** must honour the exemption,
   or the periodic guard will stop the slot mid-calibration a fraction of a
   second after it starts.
4. **One slot only.** `CAL_CMD_ENTER` force-exits calibration on all other slots
   before entering the requested one.
5. **Not while testing.** `CAL_CMD_ENTER` is rejected if any slot is running a
   charge/discharge test.
6. **Dead-man timeout.** If `calState == 2` and no calibration command has been
   received for **120 s**, auto-exit to `calState == 1` and zero the reference.
   A bench supply left driving an unattended slot is the main physical risk in
   this whole procedure; this is the mitigation.
7. **Exit is always safe.** `CAL_CMD_EXIT`, a trip, a host disconnect timeout or
   a unit-state change all zero the reference before changing state.
8. **Group followers are excluded.** A slot that is not a group leader has no
   control loop of its own (`bts_cpu1.c:464-466`). Reject `CAL_CMD_ENTER` on a
   follower or a strap-disabled slot with `CAL_ERR_SLOT_UNAVAILABLE`, and do not
   propagate calibration state to followers the way `modeCallback()` propagates
   a normal start.

---

## 8. Persistence

### 8.1 Struct

Extend `BTS_channelCalibration` with validity and integrity fields:

```c
uint32_t calFlags;   /* bit0 voltage cal valid, bit1 current cal valid,
                        bit2 externally referenced (vs compiled default) */
uint32_t crc32;      /* over all preceding fields, little-endian word order */
```

Place them at the **end** so the existing field offsets are unchanged, and bump
the header magic so pre-change F-RAM images are rejected rather than
misinterpreted. With the fixed 128-byte stride from §3.1 there is ample room.

The header is a **two-field** word — magic in the high half, channel in the low
half (`registers.h:685-688`):

```c
#define BTS_CAL_HEADER          0xA5CC0000UL   /* -> 0xA5CD0000 for this revision */
#define BTS_CAL_HEADER_MASK     0xFFFF0000UL
#define BTS_CAL_CHANNEL_MASK    0x0000FFFFUL
#define BTS_CAL_MAKE_HEADER(ch) (BTS_CAL_HEADER | ((uint32_t)(ch) & BTS_CAL_CHANNEL_MASK))
```

> The skill reference doc describes this as `0xA5CC | channel`. That form is
> **wrong** and aliases for channels ≥ 4 — the code comment at `registers.h:683-684`
> calls this out explicitly. Use the masked two-field form above.

Bumping the magic to `0xA5CD0000` means every slot falls back to compiled
defaults on the first boot after this change, and must be recalibrated. That is
the intended behaviour: the pre-change images have an unknown-good channel 4 and
no `calFlags`.

### 8.2 Validation

`validateCalibration()` (`com_cpu2.c:774-792`) currently checks only the header,
temperature window and the F28 gains — the Iout/Vout gains are **not validated at
all**. Add windows derived from the known-good compile-time values
(`IoutGain_pu ≈ 0.100`, `VoutGain_pu ≈ 0.203`):

| Field | Min | Max |
|---|---|---|
| `IoutGain_pu` | 0.05 | 0.20 |
| `VoutGain_pu` | 0.10 | 0.40 |
| `F28V_Gain`, `F28I_Gain` | 0.5 | 2.0 |
| `F28V_Offset` | −1.0 | 1.0 |
| `F28I_Offset` | −2.0 | 2.0 |

Also require `IoutGain_A ≈ 1/IoutGain_pu` and `VoutGain_V ≈ 1/VoutGain_pu` to
within 0.1 %, catching a partially-written block.

### 8.3 Boot

`loadCalibration()` sets status bits 13/14 per channel from the persisted
`calFlags`, so the display ticks survive a power cycle. Unchanged otherwise: one
`BTS_IPC_FLAG_CAL_RELOAD` after the whole file is populated.

> Regression guard: `BTS_initUserVariables()` must keep seeding `F28V_Gain`,
> `F28V_Offset`, `F28I_Gain`, `F28I_Offset` from the compiled defaults. Those are
> IPC-only values and a missed one-shot reload previously left them at 0.0,
> producing a silent 0.0 V on every slot.

---

## 9. RAM budget

`CPU2TOCPU1RAM` is 1024 words. Before this work **914 were used** (`registers[]`
518 + `calibrationData[8]` 256 + `ipcMsg`), leaving 110.

The 30 new registers cost 60 words and the two added calibration struct fields
another 16, which overflowed the block — the link failed with
`#10099-D ... section "MSGRAM_CPU2_TO_CPU1" size 0x88`.

**Resolution: `calibrationData[]` moved out of the message RAM.** Every float in
it is also published through `registers[]`, which is what CPU1 actually reads,
so the full 288-word image had no reason to be shared. It is now CPU2-private
and only the persisted validity flags cross, as `calValidFlags[NUM_CHANNELS]`
(8 words) — CPU1 needs those for the display ticks after a power cycle.

Verified in the map files after the change:

| Block | Used | Free |
|---|---|---|
| `CPU2TOCPU1RAM` | 734 words | **290 words** |
| `CPU1TOCPU2RAM` | 412 words | **612 words** |

The unit-level telemetry window in §4.2 is still the right shape — eight
per-slot copies would need 72 registers (144 words) and buys nothing, since only
one slot calibrates at a time.

Overflow here is a link-time failure, not a runtime one, so any further addition
simply needs a rebuild and a glance at the map.

---

## 10. ESP32 work

### 10.1 `bts_regs.h`

Mirror everything above: new addresses, `BTS_SENSE_ADDR(ch)`, the calibration
command/status/result enums, the per-channel calibration block offsets (currently
absent — only `BTS_CAL_BASE`/`STRIDE`/`ADDR` exist), and status bits 8–14.

### 10.2 `bts_link`

- Add `bts_link_cal_*()` wrappers for each opcode. Each writes `eCalArgument`
  then `eCalCommand`, then reads back `eCalResult`.
- Extend `bts_snapshot_t` with a `bts_cal_state_t` sub-struct.
- Poll the calibration window (registers 1036–1088, one burst) **only while
  calibration is active**, to avoid adding cost to the normal 25-transaction
  250 ms cycle.
- Keep the existing lead-in pad-byte handling in `bus_read_block()` — the C2000
  clocks out a stale TX byte before its ISR runs, and new read paths must not
  reintroduce that bug.

### 10.3 Web API

- `POST /api/registers` — generic register write (`{addr, value}`), the mirror of
  the existing read-only `GET`. Validate `addr % 4 == 0` and range.
- `POST /api/calibration/enter|exit|clear` — `{slot}`
- `POST /api/calibration/voltage` — `{measured_v}`
- `POST /api/calibration/zero_current`
- `POST /api/calibration/fixed_current` — `{pu}`
- `POST /api/calibration/current` — `{measured_a}`
- `POST /api/calibration/save`
- `GET  /api/calibration` — full state, captures, live telemetry, tick flags.

Respect the documented route-ordering constraint (`web_api.c:820-835`): only a
**trailing** wildcard is honoured, so register one pattern per method and
dispatch on the trailing segment manually.

### 10.4 BLE

Add two characteristics; **do not renumber the existing nine**:

| UUID | Name | Properties | Payload |
|---|---|---|---|
| `e5f1000b-…` | calibration control | WRITE | `ble_cal_cmd_t { uint8 opcode; uint8 slot; uint16 rsvd; float arg; }` |
| `e5f1000c-…` | calibration status | READ \| NOTIFY | `ble_cal_status_t` — slot, status bits, result, the 9 telemetry floats, tick flags |

Packed **little-endian**, consistent with the rest of `ble_proto.h` (and opposite
to the I2C wire order — do not confuse the two). Bump `BLE_PROTO_VERSION` to 2.
Notify at 2 Hz while calibration is active.

### 10.5 Display

Add a fourth screen, selected when `cal.active`, taking priority over the slot
table. It shows **only** the slot under calibration:

```
+--------------------------------+
| CALIBRATION      SLOT 3        |
+--------------------------------+
|           ADS131    F28 ADC    |
|  V        4.1982    4.1975  [v]|
|  pu       0.8412    0.8409     |
|  A       -2.4991   -2.4987  [v]|
|  pu      -0.2502   -0.2499     |
|  T        23.4 C               |
+--------------------------------+
| LO set  HI set   I0 set        |
+--------------------------------+
```

- Green tick right of the V row when status bit 13 is set; right of the A row
  when bit 14 is set. Draw it with the existing band primitives (two strokes via
  `band_fill_rect`) — there is no glyph table and the 5×7 font has no tick.
- Live temperature on screen as shown.
- Reuse `band_text_right` for the numeric columns; right-alignment already exists.
- Footer shows which capture points are held.

The encoder's PRESS and LONG_PRESS currently only log (`display.c:596-603`).
Leave that unchanged — calibration is driven over BLE/HTTP, not from the panel.

### 10.6 LED

Slot under calibration flashes **white**. Add to `LEDDriver_update()`
(`led_driver.c:59-103`) above the charging/discharging branch and below the fault
branches — a trip must still out-rank calibration:

```c
#define LED_CAL_PERIOD  24U   /* 300 ms */
#define LED_CAL_ON      12U   /* 50 % duty */
```

---

## 11. Bench automation script

`esp32-btle-proxy/tools/calibrate.py`.

- **BLE**: `bleak`, reusing the connection pattern in `ble_verify.py:96-165`
  (`BleakScanner.find_device_by_name("BTS-Tester")` → `BleakClient`), and the
  slot-select-then-read idiom.
- **DMM**: Agilent/Keysight over LAN, raw SCPI on **TCP port 5025**. Use the
  standard socket form rather than adding a VISA dependency. Commands:
  `*IDN?`, `*RST`, `*CLS`, `CONF:VOLT:DC AUTO`, `CONF:CURR:DC AUTO`, `READ?`.
  Verify the identity string on connect and abort if it is not a supported model.
- **Configuration step**: prompt for (and persist to `calibrate.ini`) the DMM IP
  address, the SCPI port, and the BLE device address.
- **Guided flow**: walk the operator through slots 1–8, prompting for each
  physical connection change, confirming the DMM identity, and refusing to
  advance until the live pu reading is in the required window.
- Print a before/after gain table per slot and write a JSON report.
- `--dry-run` must exercise the full flow with a simulated DMM.

The script drives the sequence in §12 and must surface `eCalResult` text for any
non-zero code rather than a bare number.

---

## 12. Operator process flow

```
Configure: DMM IP, BLE address                 [script]
    |
Connect DMM  -> *IDN? verified
    |
For each slot 1..8:
    |
    +-- Prompt: connect DC supply + DMM to slot N
    |
    +-- CAL_CMD_ENTER (slot N)                 status bit 0
    |
    +-- VOLTAGE, low side ------------------------------------
    |     Supply set so ADS pu < 0.2  (use ~0.85 V, see below)
    |     DMM: CONF:VOLT:DC, READ?  -> V_lo
    |     CAL_CMD_CAPTURE_VOLTAGE (V_lo)        status bit 1
    |
    +-- VOLTAGE, high side -----------------------------------
    |     Supply set so ADS pu > 0.8  (use ~4.25 V, see below)
    |     DMM: READ?  -> V_hi
    |     CAL_CMD_CAPTURE_VOLTAGE (V_hi)        status bit 2
    |
    +-- CURRENT, zero ----------------------------------------
    |     Converter disabled, no current path
    |     CAL_CMD_ZERO_CURRENT                  status bit 3
    |
    +-- CURRENT, loaded --------------------------------------
    |     Prompt: move DMM in series, supply in current limit
    |     CAL_CMD_SET_FIXED_CURRENT (0.25 pu)   status bit 8
    |     settle ~2 s
    |     DMM: CONF:CURR:DC, READ?  -> I_hi
    |     CAL_CMD_CAPTURE_CURRENT (|I_hi|)      status bit 4
    |
    +-- CAL_CMD_COMPUTE_SAVE                    bits 5,6,7
    |     two-point maths, validate, F-RAM write, IPC reload
    |
    +-- CAL_CMD_EXIT                            reference zeroed
    |
    +-- Verify: status bits 13/14 set on slot N
```

### 12.1 Why 0.85 V and 4.25 V, and not 1.0 V and 4.0 V

The round numbers do not work. At the gain these slots actually have
(`VoutGain_pu` = 0.2031, `bts_user_calibration.h:46-49`):

| Supply | Reads | Against the window | Margin |
|---|---|---|---|
| 1.00 V | 0.2024 pu | **rejected** — above the `< 0.2` low window | −1.2 % |
| 4.00 V | 0.8117 pu | passes `> 0.8` | +1.5 % |
| **0.85 V** | 0.1720 pu | passes | **+14 %** |
| **4.25 V** | 0.8625 pu | passes | **+7.8 %** |

So 1.0 V fails outright with `CAL_ERR_PU_RANGE`, and 4.0 V clears the high
window by so little that a slot whose gain runs 2 % low fails too. The windows
are checked against the *uncalibrated* reading, which is exactly the quantity
that varies between slots — margin has to be left for it.

`calibrate.py` suggests 0.85 V and 4.25 V for this reason.

---

## 13. Documentation deliverables

In `Docs/`:

| File | Contents |
|---|---|
| `README.md` | Calibration overview, wiring, safety, step-by-step operator procedure, troubleshooting |
| `calibration-flow.md` | Mermaid process-flow and state diagrams |
| `ble-specification.md` | Full GATT table: all 11 characteristics, UUIDs, packed layouts, endianness, notify behaviour, version history |
| `api-specification.md` | Every HTTP endpoint with request/response JSON, plus the I2C register map including all additions |
| `calibration-design.md` | This document |

The BLE and API documents must cover the **existing** surface as well as the new
calibration additions — they are the first complete specification of either.

---

## 14. Verification

1. Both CCS configurations build clean via the `buildProject` MCP tool (never
   `gmake` directly). Check the `.map` files: every shared symbol must resolve to
   the same address in `cpu1/` and `cpu2/`, and `CPU2TOCPU1RAM` must not overflow.
2. ESP-IDF builds clean (`. .\idf_env.ps1; idf.py build`).
3. `calibrate.py --dry-run` completes the full flow against a simulated DMM.
4. On hardware: verify a slot calibrated through the flow reports a voltage
   within the DMM's reading, that both paths agree to within the 12-bit ADC's
   resolution, and that the values survive a power cycle.
5. Confirm a deliberate over-current during calibration still trips and exits.

Bench preconditions that will otherwise waste time: the input supply must exceed
`eChargeDisableV` (default 9 V) or the unit sits in `eInputLow_ChargeDisabled`
and no slot will start; and a latched `TZOSTFLG` cannot be cleared while its trip
source is still asserted.
