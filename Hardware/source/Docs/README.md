# Slot Calibration — Bench Procedure

How to calibrate one or more slots on the eight-channel battery test system
(BTS), with the hardware in front of you.

This is the operator's document. The engineering contract — register
addresses, opcodes, the two-point mathematics — is in
[`calibration-design.md`](calibration-design.md). You do not need to read it to
run a calibration.

---

## Read this first

> ### Hardware over-current protection is currently DISABLED
>
> All eight hardware trips are switched off in this firmware build
> (`BTS_TRIP_HW_CH1..8_ENABLED (false)`, `bts_user_settings.h:113-120`). The
> only over-current protection left is a software check that runs once per
> control pass — fast enough for a gradual overload, **not** fast enough for a
> genuine short.
>
> Three consequences, all of which matter during calibration because
> calibration deliberately drives real current:
>
> 1. **Do not run calibration unattended.** Stay at the bench with a hand near
>    the supply's output switch.
> 2. **Set the bench supply's own current limit before you start.** 3 A is a
>    sensible backstop for the 2.5 A the procedure draws. The supply's limit is
>    your fast protection, because the unit's is not armed.
> 3. Consider enabling the hardware trip for the slot you are about to
>    calibrate, if the trip links on that slot are wired.

> ### Enter the DMM current as a MAGNITUDE
>
> Calibration runs in **discharge**, and the firmware applies the discharge
> sign itself. When the meter reads `-2.4991 A`, you enter `2.4991`.
>
> Entering `-2.4991` is the single easiest way to end up with an inverted
> current reading on that slot — it will look plausible, pass validation, and
> report every subsequent discharge with the wrong sign. `calibrate.py` takes
> the absolute value for you; if you are driving the sequence by hand over
> HTTP, this is on you.

---

## What calibration does, and why

Each slot has two independent measurement paths looking at the same cell:

| Path | Converter | Resolution | Used for |
|---|---|---|---|
| External | ADS131M08 | 16-bit | the control loop's current reference, and reporting |
| Internal | F2837xD on-chip ADC | 12-bit at a 2.5 V reference | the cell voltage and current a host reads today |

Neither is accurate out of the box. Component tolerance in the sense
resistors, the divider networks and the converter references means each slot
reads a few percent off, and differently from its neighbours.

Calibration measures that error against a **traceable external reference** —
your DMM — at two points per quantity, fits a straight line through them, and
stores the resulting gain and offset for that slot. Both paths are calibrated
at the same time, from the same physical stimulus, so they agree with each
other as well as with the meter.

The results live in the FM24V10 F-RAM on the unit and are reloaded at every
boot. They survive a power cycle. (The function names in the firmware say
`readEEPROM` / `writeEEPROM`, but the part is F-RAM — there is no write-cycle
budget to worry about and no erase delay.)

**A slot needs calibrating when:** it is a new or repaired unit, a sense
resistor or converter has been replaced, the slot disagrees with a meter by
more than about 1 %, or the firmware's calibration header revision has changed
(after which every slot falls back to compiled defaults and reports no ticks).

---

## Equipment

| | |
|---|---|
| **DC bench supply** | 0–5 V, 3 A, with an adjustable current limit and a genuine constant-current mode. This is both the voltage source for the voltage phase and the current sink path for the current phase. |
| **DMM** | Agilent/Keysight with a LAN port, SCPI on TCP 5025. Verified models: 34401A, 34410A, 34411A, 34450A, 34460A, 34461A, 34465A, 34470A. It must measure DC volts and DC amps to at least 2.5 A. |
| **Host** | A PC with Python 3.10+, `bleak` installed, on the same network as the DMM and in Bluetooth range of the tester. |
| **Leads** | Two pairs of test leads for the slot terminals, plus a set for the DMM. Use leads rated for 3 A on the current path — thin probe leads drop enough voltage at 2.5 A to matter. |
| **The tester** | Powered from its DC input, advertising over BLE as `BTS-Tester`. |

You do **not** need a cell in the slot. Calibration uses the external supply
for both phases. Remove any cell before you start.

---

## Bench preconditions

These two will waste an afternoon if you skip them.

**1. The DC input must be above `eChargeDisableV` (default 9 V).**

Below it, the unit settles into `eInputLow_ChargeDisabled` and **no slot will
start** — the guard is checked both when a mode is written and again at 10 Hz
while running, so a marginal input stops a slot a fraction of a second after
it starts, which looks like an intermittent fault rather than a supply
problem. Check the reported input voltage before you begin:

```
curl http://<tester-ip>/api/status | grep input_voltage
```

Note this is the guard on the **input bus**, not the cell voltage on the slot.

**2. A latched `TZOSTFLG` cannot be cleared while its trip source is still
asserted.**

If a slot tripped earlier, clearing the fault does nothing until you remove
whatever is asserting the trip. A clear that "doesn't take" is this, not a
dead slot. Fix the cause, then clear.

---

## Wiring

Calibration has two phases and they need different connections. The script
prompts you at each change; this is what those prompts mean.

### Voltage phase — DMM in PARALLEL

The supply sets the slot terminal voltage; the DMM measures what is really
there.

```
    DC bench supply                    BTS slot N
    +-------------+                  +-----------+
    |          (+)|------------+-----| (+)       |
    |             |            |     |           |
    |          (-)|------+-----|-----| (-)       |
    +-------------+      |     |     +-----------+
                         |     |
                       (-)|   |(+)
                      +---------+
                      |   DMM   |   CONF:VOLT:DC
                      +---------+
```

Connect the DMM **at the slot terminals**, not at the supply. The lead
resistance between them is exactly the error you are trying to calibrate out.

Supply output ON, current limit 0.5 A is plenty for this phase.

### Current phase — DMM in SERIES

The slot draws a fixed discharge current; the supply is the sink path for it,
and the DMM counts every amp on the way through.

```
    DC bench supply                    BTS slot N
    +-------------+                  +-----------+
    |          (+)|---+          +---| (+)       |
    |             |   |          |   |           |
    |             | +---------+  |   |           |
    |             | |   DMM   |--+   |           |
    |             | +---------+      |           |
    |             |   |  CONF:CURR:DC|           |
    |             |   +--------------+           |
    |          (-)|---------------------| (-)    |
    +-------------+                  +-----------+
```

Move the DMM's lead from the volts jack to the **amps jack** — on most
Keysight meters that is a physically different terminal, and forgetting is the
usual cause of a reading of zero.

Set the supply to about 3.7 V and **set its current limit to 3 A**. That limit
is the safety backstop for the whole procedure.

---

## Procedure

### The automated way

```powershell
cd esp32-btle-proxy
py -3.10 tools\calibrate.py
```

On the first run it asks for the DMM's IP address, the SCPI port (5025) and
the tester's BLE address (leave blank to scan for `BTS-Tester`). Those are
saved to `tools\calibrate.ini` and reused.

The script then walks slots 1 to 8, prompting at each connection change and
refusing to advance until the slot's live reading is inside the required
window. Useful flags:

| Flag | Effect |
|---|---|
| `--slots 3,5` | only those slots; `--slots 2-4` also works |
| `--dry-run` | the whole flow against a simulated tester and DMM, no hardware |
| `--reconfigure` | re-prompt for the addresses |
| `--report out.json` | where the JSON report goes |

At any prompt, `s` skips the current slot; Ctrl-C stops the run. Both paths
issue `CAL_CMD_EXIT`, so a slot is never left driving current.

### What happens per slot

1. **Connect** — supply and DMM across the slot, DMM in parallel.
2. **Enter calibration** — the slot stops regulating and zeroes its reference,
   but keeps measuring. Its LED flashes white.
3. **Voltage, low point** — set the supply to about **0.85 V**. Wait for the
   live per-unit reading to settle below 0.2. The DMM reading is captured.
4. **Voltage, high point** — raise the supply to about **4.25 V**, per-unit
   above 0.8. Captured.
5. **Current, zero point** — supply output off, current path broken. The slot
   captures what it reads with no current flowing. This is the offset.
6. **Current, loaded point** — DMM into series, supply to 3.7 V with its limit
   at 3 A, output on. The slot drives 0.25 pu of discharge (about 2.5 A) and
   settles for two seconds. The DMM reading is captured as a magnitude.
7. **Compute and save** — the two-point fit runs, the results are validated
   against their expected windows, written to F-RAM and reloaded into the
   control core.
8. **Exit** — the reference is zeroed and the slot returns to normal.
9. **Verify** — the script reads the slot's status bits back and confirms both
   ticks are set.

> **Why 0.85 V and 4.25 V, when the design document's worked example says 1.0 V
> and 4.0 V?** At the gain these slots actually have, 1.0 V reads 0.2024
> per-unit — just *above* the `< 0.2` low window, so the capture is rejected.
> 4.0 V clears the high window by only 1.5 %. The values here leave margin at
> both ends. If your slot's gain differs, follow the live per-unit number the
> script prints rather than the voltage.

### Doing it by hand

Every step is an HTTP POST, if you would rather drive it yourself. Full
request and response shapes are in
[`api-specification.md`](api-specification.md).

```bash
T=http://<tester-ip>
curl -X POST $T/api/calibration/enter         -d '{"slot":2}'
curl -X POST $T/api/calibration/voltage       -d '{"measured_v":0.84968}'
curl -X POST $T/api/calibration/voltage       -d '{"measured_v":4.24992}'
curl -X POST $T/api/calibration/zero_current  -d '{}'
curl -X POST $T/api/calibration/fixed_current -d '{"pu":0.25}'
sleep 2
curl -X POST $T/api/calibration/current       -d '{"measured_a":2.4991}'   # MAGNITUDE
curl -X POST $T/api/calibration/save          -d '{}'
curl -X POST $T/api/calibration/exit          -d '{"slot":2}'
curl     $T/api/calibration
```

`slot` is **0-based** on the wire (slot 3 on the front panel is `{"slot":2}`).
The script shows you 1-based numbers and converts.

---

## Reading the display

While a slot is calibrating, the panel switches to the calibration screen and
shows only that slot:

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

- **Two number columns.** `ADS131` is the 16-bit external converter, `F28 ADC`
  the 12-bit internal one. They should agree to roughly the resolution of the
  12-bit path — around 1 mV on voltage. A large disagreement after a
  successful calibration means one path's wiring is not what you think.
- **`pu` rows** are the raw per-unit readings the two-point maths consumes,
  before any gain is applied. These are the numbers the capture windows
  (< 0.2, > 0.8) are checked against.
- **The green ticks `[v]`** at the right of the V and A rows are the point of
  the whole exercise. A tick means that slot has valid, persisted calibration
  for that quantity. They are driven from what is stored in F-RAM, not from
  this session's captures, so **a slot calibrated last month still shows its
  ticks today**. A slot with no tick is running on compiled defaults.
- **The footer** lists which capture points are currently held: `LO set`,
  `HI set`, `I0 set`, `I1 set`. They clear when you exit or clear.
- **The slot's LED flashes white** while it is calibrating. A fault colour
  out-ranks it — if the LED shows a trip, the trip is what matters.

The encoder does nothing during calibration. Press and long-press only write
to the log; the procedure is driven over BLE or HTTP.

---

## Troubleshooting

| What you see | What it means | What to do |
|---|---|---|
| `per-unit reading outside the required window` | The supply is set so the slot reads between 0.2 and 0.8 pu — the firmware cannot tell which point you meant. | Follow the live pu number the script prints. Below 0.2 for the low point, above 0.8 for the high. Roughly 0.85 V and 4.25 V. |
| `busy - another slot is already in calibration` | Only one slot calibrates at a time. | `CAL_CMD_EXIT` the other slot. `CAL_CMD_ENTER` force-exits the others, so this usually means a stale session from a crashed script. |
| `slot is running a test - stop it first` | A charge or discharge test is active somewhere on the unit. | Stop it: `POST /api/abort_all`. |
| `slot is disabled by its ENABLE strap, or is a group follower` | The ENABLE dip switch masks this slot off, or it follows a lower-numbered leader and has no control loop of its own. | Check the MODE/ENABLE straps. In a group, calibrate the leader. |
| `insufficient captures` | Voltage needs both points; current needs the zero plus one loaded point. | Capture the missing point. Save computes and stores whichever of the two is complete, so a partial result is normal, not a failure. |
| `computed gain failed validation` | The fit landed outside its expected window — `IoutGain_pu` outside 0.05–0.20, or `VoutGain_pu` outside 0.10–0.40. | Almost always a wiring error: DMM on the wrong terminals, in the wrong jack, or measuring a different slot. Check and redo. |
| `F-RAM write failed` | The I2C write to the FM24V10 did not complete. | Check the I2C bus: `GET /api/i2c_diag`. |
| The slot never starts; nothing happens | The input bus is below `eChargeDisableV` and the unit is in `eInputLow_ChargeDisabled`. | Bring the DC input above 9 V. Check `/api/status`. |
| The slot stops about half a second after starting | Same cause. The input guard runs again at 10 Hz. | As above. |
| The slot trips during the current phase | Real over-current, or a trip source still asserted. Calibration exits and zeroes the reference — as designed. | Check the wiring for a short. A latched `TZOSTFLG` will not clear while its source is asserted. |
| Nothing happens for two minutes, then the slot stops | The dead-man timeout. If no calibration command arrives for 120 s while a slot is driving current, it auto-exits. | Expected. Re-enter and continue. |
| DMM reads 0 A in the current phase | The lead is in the volts jack. | Move it to the amps jack. |
| Current reads the right size with the wrong sign afterwards | A signed value was entered where a magnitude was wanted. | Recalibrate that slot's current. Enter the absolute value. |
| `unsupported DMM` on connect | `*IDN?` returned a model the script does not know. | Check it is the right instrument. `--allow-unknown-dmm` overrides, if you are sure it speaks the same SCPI. |
| Both ticks stay grey after a successful save | The save reported bit 7 but the status bits did not follow. | Re-read `/api/calibration`. If it persists, the F-RAM image may have failed validation on reload — power-cycle and check. |

---

## After calibration

The script prints a before/after gain table per slot and writes a JSON report
(`calibration-report.json` by default). Keep it with the unit's records — it is
the evidence of what the slot measured against a traceable reference, on what
date.

Verify the result independently before you trust the unit:

1. Put a known voltage on the slot and confirm the reported voltage matches the
   DMM.
2. Confirm the external and internal paths agree to about the 12-bit path's
   resolution.
3. Power-cycle the unit and confirm the values and the green ticks survive.
4. Deliberately provoke an over-current during a calibration and confirm the
   slot still trips and exits. Do this once on a new unit — it is the check
   that the safety path is real.

---

## Safety summary

- **Hardware over-current trips are disabled.** The bench supply's current
  limit is your fast backstop. Set it. Stay at the bench.
- Calibration current is **discharge** — the external supply is the sink.
- Enter DMM currents as **magnitudes**.
- Only one slot calibrates at a time. Entering on one force-exits the others.
- Calibration is refused while any slot is running a test.
- The fixed-current setpoint is clamped to 0.8 pu (about 8 A).
- A trip, an exit, a host disconnect or a unit state change all zero the
  reference before anything else changes.
- A slot driving current with no command for 120 s auto-exits.
- Remove cells from the slot before calibrating it.
