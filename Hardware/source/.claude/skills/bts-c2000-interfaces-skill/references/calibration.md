# Calibration — Persistence, F-RAM Layout and Boot

The **runtime calibration contract** — opcodes, status bits, result codes, the
two-point mathematics, the guard conditions, the safety rules and the RAM
budget — lives in `Docs/calibration-design.md`. Read that first; it is
authoritative and this file does not duplicate it.

The operator-facing procedure is in `Docs/README.md`, with diagrams in
`Docs/calibration-flow.md`.

This file covers the persistence side: where the bytes live, what makes a
block valid, and what happens at boot.

---

## The storage device is an FM24V10 F-RAM

Not an EEPROM. It is 128 KiB, byte-writable, with no page-write delay and no
write-endurance concern at the rate this firmware uses it — which is why a
save can be one contiguous block write rather than a paged sequence.

**The functions are still named `readEEPROM` / `writeEEPROM` and the macros
still say `EEPROM_*`** (`com_cpu2.c:88-106`, `762-780`). That naming is
historical. Do not read it as evidence of an EEPROM's constraints, and do not
"fix" it casually — the names are load-bearing across `com_cpu2.c`.

It shares I2CB (GPIO40/41, 400 kHz) with the two ADS1119 temperature
converters. The F-RAM is memory-addressed and uses
`i2cWriteBlock` / `i2cReadBlock`, which always emit a 16-bit word address; the
ADS1119 is command-based and **must not** go through those helpers.

---

## `BTS_channelCalibration`

`registers.h:484-513`.

```c
typedef struct _BTS_channelCalibration
{
    uint32_t  header;           // magic | channel, see below
    uint32_t  dateTime;         // CPUTimer1 count snapshot

    float32_t MinCellTemp;
    float32_t MaxCellTemp;
    float32_t F28V_Gain;        // internal ADC, cell voltage
    float32_t F28V_Offset;
    float32_t F28I_Gain;        // internal ADC, cell current
    float32_t F28I_Offset;
    float32_t IoutGain_pu;
    float32_t IoutOffset_pu;
    float32_t IoutGain_A;
    float32_t IoutOffset_A;
    float32_t VoutGain_pu;
    float32_t VoutOffset_pu;
    float32_t VoutGain_V;
    float32_t VoutOffset_V;

    // Appended at the END so every field above keeps its F-RAM offset.
    uint32_t  calFlags;         // BTS_CAL_FLAG_*
    uint32_t  crc32;            // over all preceding fields
} BTS_channelCalibration;
```

`calFlags`:

| Flag | Value | Meaning |
|---|---|---|
| `BTS_CAL_FLAG_V_VALID` | `0x1` | voltage calibration established |
| `BTS_CAL_FLAG_I_VALID` | `0x2` | current calibration established |
| `BTS_CAL_FLAG_EXTERNAL` | `0x4` | externally referenced, not a compiled default |

The V/I flags are what drive status bits 13/14. They come from the **persisted**
block, mirrored into `calValidFlags[]` at boot and on each save, so a slot
calibrated in an earlier session still shows its ticks after a power cycle
(`com_cpu2.c` `loadCalibration`, `saveCalibrationFlags`).

The twelve floats from `F28V_Gain` to `VoutOffset_V` are in the **same order**
as the `BTS_CAL_*` index offsets into the 12-register per-channel calibration
block. That parallel is relied on by `applyStoredCalibration()`,
`saveCalibrationFlags()` and CPU1's `calComputed[]` handshake. Keep it.

### The header is a two-field word

```c
#define BTS_CAL_HEADER         0xA5CD0000UL
#define BTS_CAL_HEADER_MASK    0xFFFF0000UL
#define BTS_CAL_CHANNEL_MASK   0x0000FFFFUL
#define BTS_CAL_MAKE_HEADER(ch) (BTS_CAL_HEADER | ((uint32_t)(ch) & BTS_CAL_CHANNEL_MASK))
```

`registers.h:858-867`. Magic in the **high half**, channel in the **low half**,
each checked against its own mask.

> An earlier revision of this document described the header as
> `0xA5CC | channel`. That form is **wrong**: OR-ing the channel into the low
> byte of a 16-bit magic aliases for channels ≥ 4. The code comment at
> `registers.h:858-860` calls this out explicitly.

The magic was bumped `0xA5CC0000` → `0xA5CD0000` for the `calFlags` / `crc32`
revision and the fixed 128-byte stride. Pre-change images are therefore
**rejected rather than reinterpreted**: every slot falls back to compiled
defaults once and must be recalibrated. That is deliberate — the old images
have an unknown-good channel 4 (see below) and no `calFlags`.

### CRC-32

`calibrationCrc32()` (`com_cpu2.c:783-805`) is a standard reflected CRC-32
(polynomial `0xEDB88320`, init `0xFFFFFFFF`, final XOR `0xFFFFFFFF`) over
every word of the struct **except the trailing `crc32` field itself**, each
16-bit C28x word contributing its two wire bytes low half first — matching the
little-endian word order the image is written in.

It is computed on save and checked on load. A block that fails the CRC is
discarded and the channel gets compiled defaults.

---

## F-RAM address map

```c
#define EEPROM_I2C_ADDR       0x50
#define CAL_FRAM_STRIDE_BYTES 128U     // per channel, FIXED
#define CAL_FRAM_BASE         0x0000U  // ch N at BASE + N*STRIDE
#define EEPROM_GLOBAL_V_ADDR  0x0400   // 16 bytes = 4 floats
```

`com_cpu2.c:103-106`.

| Address | Content |
|---|---|
| `0x0000 + ch * 0x80` | Channel 0-7 calibration block (ends `0x03FF`) |
| `0x0400` | 4 × float32 global voltage thresholds (16 wire bytes) |

Global voltage order: `ChargeDisableV`, `ChargeRestrictV`,
`DischargeRestrictV`, `DischargeDisableV`.

### Why the stride is fixed, and what it fixes

The stride used to be `2 * sizeof(BTS_channelCalibration)` — 64 wire bytes —
so channel 4's block landed at `0x0100`…`0x013F`. The global voltage block
was at `0x0100`…`0x010F`. **They overlapped**, on channel 4's `header`,
`dateTime`, `MinCellTemp` and `MaxCellTemp`.

The failure was invisible, which is why it survived. `saveAllCalibration()`
iterates 0→7: channel 0 writes the globals to `0x0100`, then channel 4
overwrites them. At the next boot `loadCalibration()` reads `0x0100` as
globals, gets channel 4's header and temperatures reinterpreted as floats,
`validateGlobalVoltages()` rejects them, and the 9/10/15/16 V defaults are
silently installed. Channel 4's own block still validated, so nothing looked
wrong — **the global voltage thresholds simply never persisted**.

A fixed stride also decouples the wire layout from `sizeof`, so adding a
struct field no longer moves every channel's block. The FM24V10 is 128 KiB;
the generosity costs nothing.

### Packing

A C28x byte is 16 bits, so the image is packed two wire bytes per word:
`CAL_EEPROM_BYTES = 2 * sizeof(BTS_channelCalibration)`, converted by
`calibrationToBytes()` / `bytesToCalibration()` (`com_cpu2.c:742-760`),
low half first. Never `memcpy` the struct onto the wire.

---

## Validation

`validateCalibration()` (`com_cpu2.c:825-870`) must pass **all** of:

| Check | Condition |
|---|---|
| Header magic | `(header & 0xFFFF0000) == 0xA5CD0000` |
| Header channel | `(header & 0x0000FFFF) == channel` |
| Temperature window | `-40 ≤ MinCellTemp`, `MaxCellTemp ≤ 100`, `Min < Max` |
| `F28V_Gain` | 0.5 … 2.0 |
| `F28V_Offset` | −1.0 … 1.0 |
| `F28I_Gain` | 0.5 … 2.0 |
| `F28I_Offset` | −2.0 … 2.0 |
| `IoutGain_pu` | 0.05 … 0.20 |
| `VoutGain_pu` | 0.10 … 0.40 |
| Reciprocal pair | `IoutGain_A ≈ 1/IoutGain_pu` and `VoutGain_V ≈ 1/VoutGain_pu`, to 0.1 % |
| CRC-32 | `crc32 == calibrationCrc32(cal)` |

The Iout/Vout gain windows, the reciprocal check and the CRC are all new. The
Iout/Vout gains were previously **not range-checked at all**, so a corrupt or
half-written block passed straight into the control loop's setpoint
arithmetic. The reciprocal test is specifically the partial-write detector:
the two halves of each pair are written from different register slots, so a
torn write shows up as disagreement even when both individual values look
plausible.

The same windows are applied on CPU1 in `calComputeAndSave()`
(`BTS_CAL_IOUT_GAIN_PU_MIN` etc., `bts_cpu1.c:149-157`) **before** the result
is handed to CPU2, so a bad two-point fit never reaches the F-RAM.

`validateGlobalVoltages()` requires
`8.0 V ≤ ChargeDisableV ≤ ChargeRestrictV ≤ DischargeRestrictV ≤ DischargeDisableV ≤ 16.8 V`,
reading them from `registers[]` rather than from a buffer.

---

## Boot — `loadCalibration()`

`com_cpu2.c:972-1041`. Runs on CPU2 **before interrupts are enabled**, so a
host write can never race it.

For each channel:

1. Clear `calibrationData[ch].calFlags` and `calValidFlags[ch]` first —
   `calValidFlags[]` is `NOLOAD` from CPU1's side and CPU1 reads it every
   status pass, so the RAM's power-up contents must not be observed as
   validity.
2. `readEEPROM(ch, &cal)` then `validateCalibration(&cal, ch)`.
3. Valid → copy into `calibrationData[ch]`, publish `calFlags` into
   `calValidFlags[ch]`, and `applyStoredCalibration()` into the temperature
   and calibration register slices.
4. Invalid → `applyDefaultCalibration()`.

Then the globals are read from `0x0400`; if `validateGlobalVoltages()` fails,
the 9 / 10 / 15 / 16 V defaults are installed. The calibration control block
(`eCalSlot` = 255, command/argument/status/result = 0) is initialised, and
**one** `BTS_IPC_FLAG_CAL_RELOAD` is raised after the whole register file is
consistent — not one flag per register against a half-built file.

CPU1 sees that flag in its B3 task, reloads all eight channels via
`BTS_loadCalibrationFromRegisters()`, and recalculates program variables in
the next C2 task.

> **Regression guard.** `BTS_initUserVariables()` must keep seeding
> `F28V_Gain`, `F28V_Offset`, `F28I_Gain`, `F28I_Offset` from the compiled
> defaults. Those are IPC-only values, and a missed one-shot reload previously
> left them at 0.0 — producing a silent 0.0 V on every slot.

---

## Defaults

`applyDefaultCalibration()` (`com_cpu2.c:917-943`) installs:

| Field | Default | Source |
|---|---|---|
| `MinCellTemp` / `MaxCellTemp` | 10 °C / 85 °C | `DEFAULT_MIN/MAX_CELL_TEMP` |
| `F28V_Gain` / `F28I_Gain` | 1.0 | `DEFAULT_F28V/I_GAIN` |
| `F28V_Offset` / `F28I_Offset` | 0.0 | `DEFAULT_F28V/I_OFFSET` |
| `IoutGain/Offset_pu`, `IoutGain/Offset_A` | per channel | `BTS_IoutGain_chN_*`, `bts_user_calibration.h` |
| `VoutGain/Offset_pu`, `VoutGain/Offset_V` | per channel | `BTS_VoutGain_chN_*`, `bts_user_calibration.h` |

The F28 gain of 1.0 with zero offset is meaningful, not a placeholder: the
internal ADC is 12-bit single-ended, `BTS_monitor_Iout_Vout()` normalises the
raw count to 0…1 and multiplies by 2.5, and the cell voltage divider and
current-sense amplifier are both unity by default — so 1.0/0.0 yields a
0…2.5 V reading at the pin (`com_cpu2.c:144-158`).

> The `#error "calculate a gain and offset for defaults here"` placeholder
> that earlier revisions of this document warned about **no longer exists**.
> Real defaults are in place throughout.

`bts_user_calibration.h` is now **boot defaults only**. The compile-time
`BTS_CALIBRATION_ENABLED` / `BTS_CALIBATION_MODE` switch it used to drive is
gone — it forced every channel into calibration at once, which is precisely
what the per-channel runtime `calState` replaced.

---

## Saving

Two paths, both ending in `saveCalibrationFlags()` (`com_cpu2.c:1049-1110`),
which builds a fresh struct from the **current register values**, ORs
`extraFlags` into the stored `calFlags`, computes the CRC, validates, and
writes only if valid.

### Bulk commit — the legacy path, still supported

A host writes `eCalibrationMode = 2.0f` (exact float, no tolerance) over I2C,
UART or CAN. `applyHostRegisterWrite()` sets `calibrationSavePending`;
`BTS_serviceDeferredWork()` in the idle loop calls `saveAllCalibration()`,
which saves all eight channels with `extraFlags = 0`. Channel 0 also writes
the four global voltage thresholds to `0x0400`, after
`validateGlobalVoltages()`.

`eCalibrationMode` is never cleared or acknowledged — there is no "save
complete" indication on this path. The runtime path's `eCalStatus` bit 7
supplies one.

### Runtime commit

CPU1's `CAL_CMD_COMPUTE_SAVE` fills `cpu1Status.calComputed[]` and bumps
`calSaveSeq`. CPU2's `mirrorCpu1Status()` notices the change exactly once,
stages the twelve floats into that channel's calibration register slice, and
sets `calRuntimeSavePending`. `BTS_serviceDeferredWork()` then calls
`saveCalibrationFlags(slot, flags)`, sets `eCalStatus` bit 7 on success, and
raises `BTS_IPC_FLAG_CAL_RELOAD` so CPU1 picks the new gains up from
`registers[]`.

**Neither path writes F-RAM from an ISR**, and that is deliberate: the request
arrives inside the I2C target interrupt or the 8 Hz timer ISR, and a
multi-hundred-byte blocking I2C transfer there held off the host
mid-transaction.

---

## Notes for future work

- `dateTime` is a free-running `CPUTIMER1` count, not a wall clock. Replace
  with an RTC if one is ever fitted.
- There is no explicit F-RAM image version field beyond the header magic.
  Bumping the magic is the migration mechanism, and it costs a full
  recalibration of every slot.
