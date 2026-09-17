---
name: ti-ccstudio-check-bp-compatibility
description: Check whether one or more BoosterPacks are compatible with a LaunchPad. Identifies pin conflicts, warnings, and unknown signals. Use when selecting BoosterPacks for a LaunchPad or when stacking multiple BoosterPacks.
allowed-tools: Bash, Read, Glob, Grep
---

# Check BoosterPack Compatibility

Check pin-level compatibility between a LaunchPad and one or more BoosterPacks.

## Invocation

```
/check-bp-compatibility <LP-BOARD> <BP-BOARD-1> [<BP-BOARD-2> ...]
```

Examples:
- `/check-bp-compatibility LP-EM-CC1314R10 BOOSTXL-EDUMKII`
- `/check-bp-compatibility LP-CC1312R7 BOOSTXL-SHARP128 BOOSTXL-EDUMKII`

---

## Step 1 — Locate AGENTS.md files

Find the CCS `ai/boards/` directory dynamically:

```bash
find /Users/a0792138/ti -name "CCS.md" -path "*/ai/CCS.md" 2>/dev/null | head -1 | xargs dirname
```

This returns the `ai/` root. Board files are at `ai/boards/<BOARD-NAME>/AGENTS.md`.

For each board (LP + all BPs):
- Found → mark **RESOLVED**
- Not found → mark **UNKNOWN** — do not abort, continue with partial info

---

## Step 2 — Ask about suppressions

Before running analysis, ask the user:

> Are there any LP signals you don't need for this project? I'll suppress warnings for those pins.
> Examples: "backchannel UART", "SWD/debug", "LEDs", "buttons", or "none"

Map their answer to suppression sets:

| User says | Suppress warnings/conflicts on |
|---|---|
| "uart" / "backchannel" | `UART_TX`, `UART_RX`, `UART_RTS`, `UART_CTS` |
| "swd" / "debug" / "jtag" | `SWD_DIO`, `SWD_CLK`, `SWO` |
| "leds" / "led" | `Red_LED`, `Green_LED`, `Blue_LED` (downgrade conflict → warning) |
| "buttons" / "btn" | `BTN1`, `BTN2` (downgrade conflict → warning) |
| "none" / empty | no suppressions |

Multiple suppressions are additive ("uart and swd" → suppress both sets).

---

## Step 3 — Parse LP 40-pin table

In the LP AGENTS.md, find the section headed `## 40-Pin BoosterPack Header` or `## BoosterPack Header Pin Mapping`.

Extract the `| Pin | MCU Pin | Function | Notes |` table. Build a map:

```
pin_number (int) → { mcu_pin, function, notes }
```

Skip if LP is UNKNOWN — report partial results in Step 6.

---

## Step 4 — Parse BP pin mapping table(s)

For each BP AGENTS.md: find the section headed `## BoosterPack Pin Mapping` (or any heading containing "Pin Mapping").

Extract all rows where the pin is connected (not NC / `—` / blank). BP files use varied pin number formats — extract the integer:

| Format seen | Extract |
|---|---|
| `\| Pin 7 (J1.7) \|` | 7 |
| `\| Pin 7  (J1.7)  \|` | 7 |
| `\| 7 \|` | 7 |
| `\| BP7 \|` | 7 |

**Fuzzy normalization** — normalize BP function strings to canonical labels (case-insensitive keyword matching):

| Canonical label | Match rule |
|---|---|
| `Power` | contains: 3v3, 3.3v, 5v, 5.0v, vcc, vdd, power, supply |
| `Ground` | contains: gnd, ground, agnd, dgnd |
| `—` | contains: nc, n/c, "not connected", "no connect", or is blank |
| `UART_TX` | contains (uart OR serial) AND (tx OR transmit) |
| `UART_RX` | contains (uart OR serial) AND (rx OR receive) |
| `UART_RTS` | contains (uart OR serial) AND rts |
| `UART_CTS` | contains (uart OR serial) AND cts |
| `SPI_CLK` | contains spi AND (clk OR clock OR sck OR sclk) |
| `SPI_MOSI` | contains spi AND (mosi OR pico OR sdo) |
| `SPI_MISO` | contains spi AND (miso OR poci OR sdi) |
| `SPI_CS` | contains spi AND (cs OR sel OR nss OR ce OR chip OR enable) |
| `Flash_CS` | contains flash AND (cs OR sel OR enable) |
| `I2C_SCL` | contains (i2c OR iic OR twi) AND (scl OR clock OR clk) |
| `I2C_SDA` | contains (i2c OR iic OR twi) AND (sda OR data OR dat) |
| `GPIO` | contains gpio, or contains "digital" with no spi/i2c/uart match |
| `Analog` | contains analog, adc, ain, or "channel" with a digit |
| `PWM` | contains pwm OR pulse |
| `Red_LED` | contains red AND led |
| `Green_LED` | contains green AND led |
| `Blue_LED` | contains blue AND led |
| `BTN1` | contains (btn OR button OR sw) AND (1 OR left) |
| `BTN2` | contains (btn OR button OR sw) AND (2 OR right) |
| `SWD_DIO` | contains (swd OR jtag) AND (dio OR tms OR data) |
| `SWD_CLK` | contains (swd OR jtag) AND (clk OR tck OR clock) |
| `SWO` | contains swo |
| `LaunchPad Reset` | contains lp_rst OR "launchpad reset" |
| `BoosterPack Reset` | contains bp_rst OR "boosterpack reset" |

No keyword match → canonical = `UNKNOWN` for that pin.

If a BP is UNKNOWN (no AGENTS.md found): report LP pin info for all 40 pins, mark BP side as unavailable.

---

## Step 5 — Classify LP × BP

For each BP connected pin (non-`—`), look up LP function at that pin number:

| LP function | Result | Report label |
|---|---|---|
| `—` or pin not in LP table | ✓ Compatible | LP NC |
| `Power` or `Ground` | ✓ Compatible | — |
| Canonically matches BP function | ✓ Compatible | Shared — note if stacking |
| `GPIO` or `Analog` | ⚠ Soft warning | LP can repurpose; check SysConfig |
| `UART_TX/RX/RTS/CTS` | ⚠ Warning (suppressible) | Backchannel UART |
| `SWD_DIO/SWD_CLK/SWO` | ⚠ Warning (suppressible) | Debug pins |
| `Red_LED/Green_LED/Blue_LED` | ✗ Conflict | Hardware tied to MCU |
| `BTN1/BTN2` | ✗ Conflict | Pull-up tied to MCU |
| `Flash_CS` | ✗ Conflict | LP flash chip select |
| Any other function mismatch | ✗ Conflict | Function clash |
| BP canonical = `UNKNOWN` | ? Unknown | Cannot judge — LP pin shown |
| LP is UNKNOWN | ? Unknown | Cannot judge — BP pin shown |

**Workaround hints**: for any ✗ Conflict, check the LP `notes` field for that pin. If it mentions a resistor (e.g., "R10 0Ω", "DNM") or jumper, append to the conflict line:
> `LP Notes: <notes content>`

Apply suppressions from Step 2:
- Suppressed warnings → omit from report entirely
- Suppressed conflicts → downgrade to ⚠ warning, note suppression reason

---

## Step 6 — BP × BP conflict check (multi-pack only)

When 2+ BPs are specified, check every pin number used by more than one BP (ignoring `Power`, `Ground`, `—`):

| Both BPs have same canonical function | ⚠ Shared bus — may be intentional (e.g., shared SPI); note it |
| BPs have different functions at the same pin | ✗ BP stacking conflict |

---

## Step 7 — Report

```
LP: <LP-BOARD>  ×  <BP1> [× <BP2>]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

CONFLICTS  (N pins)
  Pin XX  LP: <func> (<mcu_pin>)  <BP>: <func>  → <reason>
                                                   LP Notes: <hint if present>

WARNINGS  (N pins)
  Pin XX  LP: <func>  <BP>: <func>  → <reason>
  [or: "WARNINGS — all suppressed per user request"]

BP STACKING CONFLICTS  (multi-BP only, N pins)
  Pin XX  <BP1>: <func>  <BP2>: <func>  → Function clash

BP STACKING SHARED  (multi-BP only, N pins)
  Pin XX  <BP1>: <func>  <BP2>: <func>  → Shared bus — verify intentional

UNKNOWN  (N pins)
  Pin XX  LP: <func>  <BP>: UNKNOWN ("<original string>")  → Cannot determine compatibility

COMPATIBLE  N pins ✓

─────────────────────────────────────────────────
BOARD RESOLUTION
  <LP-BOARD>:   ✓ found
  <BP-BOARD-1>: ✓ found
  <BP-BOARD-2>: ✗ not found — BP pin data unavailable
```

If any board was UNKNOWN, append:

> **Note**: AGENTS.md not found for one or more boards above. Results reflect only resolved boards.
> To improve results, ensure the missing board has an AGENTS.md in `ai/boards/`.

If the user asks to re-run with different suppressions, go back to Step 5 — do not re-parse the tables.

---

## Notes

- This skill is **read-only** — it never modifies any file
- Fuzzy normalization is best-effort; boards with canonical function labels in their AGENTS.md produce the most reliable results
- The `UNKNOWN` classification is intentional — it is better to flag uncertainty than to guess compatibility
