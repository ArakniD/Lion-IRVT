# AT Command Specification

The unit and its ESP32 proxy both answer the same AT command grammar over a
serial port. Tooling is written once and pointed at either.

---

## 1. Why there are two consoles

The C2000's console lives on **SCIA**, and SCIA is contended four ways:

| Claimant | Needs |
|---|---|
| AT console | GPIO28 RX + GPIO29 TX |
| WS2812B LED driver | GPIO29 TX |
| Channel 1 GPIO trip | GPIO28 as a digital input |
| CPU1's SFRA GUI | the whole port |

`BTS_DEBUG_CONSOLE` picks between them at build time, and a **production unit
gives SCIA to the LEDs** — so a shipped unit has no AT console at all.

The ESP32 proxy carries the same interface on its own UART and reaches the
registers over I2C instead of directly. Nothing is taken back from the unit.

| | C2000 console | ESP32 proxy console |
|---|---|---|
| Port | SCIA, GPIO28/29 | UART0 |
| Baud | 115200 8N1 | 115200 8N1 |
| Available in a production build | **no** | yes |
| Reaches registers | directly | over I2C |
| Source | `com_cpu2.c`, `uartRxISR()` | `components/at_console/at_console.c` |

**Enabling the ESP32 console silences ESP-IDF logging on UART0.** An AT
dialogue and a log stream cannot share a port: log lines would interleave with
responses and break any parser expecting a clean `+NAME=value\r\nOK\r\n`.
Logs remain available over the network interfaces.

---

## 2. Grammar

```
AT+<name>?              read a register
AT+<name>=<value>       write a register
AT+C<n>PAUSE            pause slot n (0-7)
AT+C<n>RESUME           resume slot n
```

Every line is terminated `\r` or `\n`; every response ends `\r\n`.

**A bare `AT` is ignored, deliberately.** Both consoles test for the `AT+`
prefix and silently drop anything else — there is no `OK` handshake. Probe
with a register the unit always has:

```
AT+InputVoltage?
+InputVoltage=14.52
OK
```

**Names are case sensitive**, and both the short and long form of every
register resolve. `AT+VIN?` and `AT+InputVoltage?` are the same query.

**Lines are limited to 64 characters** on both consoles. Beyond that,
characters are dropped and the line runs on — an overlong command is
truncated rather than split into two, so neither console invents a command
that was never typed.

---

## 3. Responses

| Case | Response |
|---|---|
| Read | `+<name>=<value>` then `OK` |
| Write | `OK` |
| Pause / resume | `OK` |
| Unknown name | `ERROR: Invalid register` |
| Write to a read-only register | `ERROR: Read-only register` |
| `AT+<name>` with neither `?` nor `=` | `ERROR: Invalid command` |
| I2C transport failure | `ERROR: Link failure` *(proxy only)* |

**Values always carry two decimal places**, including negatives
(`+C0CURR=-1.50`). The firmware renders them from a scaled 32-bit integer
because its build forbids double-returning functions
(`--float_operations_allowed=32`); the ESP32 uses `%.2f`. The text is
identical for every value either console can carry — and the *format* is what
matters, because a parser written against one console must not misread the
other.

Two decimals is a real limit. A calibration gain of `0.0012608` reads as
`+CVZ0=0.00`; read those over I2C, HTTP or BLE instead, which carry the full
float32.

---

## 4. Register names

Every register in the map has a short and a long name, both accepted. The
table is `uartRegConfig[]` in `registers.c` — **280 registers, 114 read-only,
166 writable.**

| Example | Short | Long |
|---|---|---|
| Slot 1 status | `C0S` | `Ch0_Status` |
| Slot 1 cell voltage | `C0VOLT` | `Ch0_CellVoltage` |
| Slot 1 voltage max | `C0VMAX` | `Ch0_VoltageMax` |
| Input voltage | `VIN` | `InputVoltage` |
| Host watchdog | `WD` | `HostWatchdog_s` |
| CC biquad b0 | `CCB0` | `DCL_CC_B0` |

Slot numbers in names are **0-based** (`C0` is front-panel slot 1), matching
the register map.

### The proxy's table is generated, not transcribed

`esp32-btle-proxy/tools/gen_at_registers.py` reads `uartRegConfig[]` out of
the C2000 source and emits all 280 rows with their addresses and access flags.
Hand-copying would drift the first time a register was added, and **drift here
is silent**: an unknown name simply reports `ERROR: Invalid register`, and a
wrong access flag turns a writable register read-only.

Re-run it whenever the register map changes:

```
cd esp32-btle-proxy
python3 tools/gen_at_registers.py
```

`tools/check_at_parity.py` holds the two consoles together — error strings,
response format, grammar keywords, line-buffer length, and every one of the
280 name/address/access rows. Run it in CI or before a release.

---

## 5. Where the two consoles differ

Both divergences are deliberate and pinned by the parity check.

**`AT+SFRA_CAL` exists only on the unit.** It calls `SFRA_startCalibration()`
inside the firmware and has no register representation, so a proxy that
reaches the unit only over I2C cannot perform it. The proxy reports
`ERROR: Invalid register` rather than pretending to succeed. It is also gated
on SFRA being compiled in — see the `cpu1_sfra` build configuration.

**Only the proxy can report `ERROR: Link failure`.** The unit's console reads
its own memory and cannot fail that way; the proxy's read crosses I2C. A
transport failure is reported rather than returning a stale or fabricated
value.

---

## 6. Worked examples

Verified against the attached hardware.

```
AT+InputVoltage?            +InputVoltage=14.52 / OK
AT+VIN?                     same, via the short name
AT+C0VOLT?                  +C0VOLT=0.00   (empty holder reads ~0 V)
AT+NoSuchReg?               ERROR: Invalid register
AT+C0S=1                    ERROR: Read-only register
AT+C0VMAX=3.70              OK
AT+C0VMAX?                  +C0VMAX=3.70
```

### Starting a charge

The mode register is a bitmask: `RUN` 0x01, `CHARGE` 0x02, `CALIBRATE` 0x04,
`PAUSE` 0x08, `RESUME` 0x10. A charge is `RUN|CHARGE` = 3.

```
AT+C0VMAX=3.70              voltage limit; charge holds this in CV
AT+C0IMAX=0.50              CC current
AT+C0IMIN=0.05              charge terminates here, once in CV
AT+C0VMIN=0                 0 disables the discharge cut-off entirely
AT+C0M=3                    RUN | CHARGE
```

A charge never reads `V_MIN`, so leaving it at zero cannot block or terminate
one. Watch progress with `AT+C0VOLT?`, `AT+C0CURR?` and `AT+C0S?`; the status
word carries CC on bit 7 and CV on bit 6.

### Stopping

```
AT+C0PAUSE                  hold, direction remembered
AT+C0RESUME                 resume in that direction
AT+C0M=0                    stop
```

---

## 7. Host watchdog

**Any command — including a read — feeds the watchdog.** If `HostWatchdog_s`
is non-zero and nothing is received within it, running slots are paused with
`WD_TRIPPED` set. Writing 0 disables supervision.

A console left open is therefore itself a keepalive. Do not rely on that for
an unattended run: set the timeout to suit the test, not the operator.
