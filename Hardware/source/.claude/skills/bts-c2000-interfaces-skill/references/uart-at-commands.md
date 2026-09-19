# AT Command Console (SCIA)

## First: does your build even have one?

The console is **conditional**, and the condition also controls the status
LEDs and channel 1's GPIO trip input. `BTS_DEBUG_CONSOLE`
(`bts_user_settings.h:42`) chooses what GPIO28 and GPIO29 do, and the roles
are mutually exclusive:

| `BTS_DEBUG_CONSOLE` | GPIO28 | GPIO29 | Console | WS2812B LEDs | Ch1 GPIO trip |
|---|---|---|---|---|---|
| `true` — **current setting** | SCIRXDA | SCITXDA | **SCIA, 115200 8N1** | disabled | disabled |
| `false` — production | ch1 trip input | SCITXDA @ 800 kbaud | **none** | enabled | enabled |

In a production build there is no console at all. `initUART()` compiles to
nothing, `uartSendResponse()` discards its argument, and the host must use
I2C or CAN.

> **There is no SCIB console.** GPIO18 is SPICLKA and GPIO19 is the ADC1 chip
> select for the external SPI ADCs, so SCIB is not an alternative. Earlier
> revisions of this document described a 1 Mbaud SCIB console on GPIO18/19;
> no such port exists.

Channel 1 keeps its CMPSS over-current trip in both modes — only the separate
GPIO trip input is affected. (Though see `SKILL.md`: every hardware trip is
currently masked anyway.)

## Physical

- **SCIA**, GPIO28 = RX, GPIO29 = TX, **115200 8N1**
- Reaches the TMDSCNCD28379D's isolated FTDI backchannel — the COM port that
  enumerates on the same USB cable as the XDS debug probe. No extra adapter.
- Line termination accepted: `\r`, `\n` or `\r\n`. Responses end `\r\n`.
- Pins are muxed by **CPU1** in `BTS_HAL_setupCpu2Pins()`; the mux registers
  are not writable from CPU2.

RX is interrupt-driven from the FIFO (`SCI_INT_RXFF`, one character deep) and
the whole FIFO is drained per interrupt. Enabling `SCI_INT_RXRDY_BRKDT`
instead sets `RXBKINTENA`, which never fires in FIFO mode — characters then
pile up until the FIFO overflows and no ISR ever runs.

**The command is parsed inside the RX ISR** (`uartRxISR`, `com_cpu2.c`), not
in a background task. Keep anything added there short; a register write funnels
straight into `applyHostRegisterWrite()`, which is cheap, but an F-RAM save is
deferred to the idle loop for exactly this reason.

---

## Syntax

All commands start with `AT+`. The name is matched **case-sensitively** against
both the short and long names in `uartRegConfig[]`, in table order.

### Query

```
AT+C0M?
+C0M=1.00
OK
```

Values print with **two decimal places**, rendered from a scaled `int32_t` in
`formatRegisterValue()` — not `printf("%f")`, which promotes to `double` and
is a hard compile error under `--float_operations_allowed=32`.

Two decimals is lossy. A gain like `0.1005` reads back as `0.10`. Use I2C or
BLE when you need the exact stored float.

### Write

```
AT+C0M=1
OK
```

or by long name:

```
AT+Ch0_Mode=3.0
OK
```

Parsed with `strtof`, not `atof` — same float-width constraint.

### SFRA

```
AT+SFRA_CAL
OK
```

Only when SFRA is compiled in **and** `sfraEnabled` is set at runtime.
`BTS_SFRA_ENABLED` is currently `false` (`bts_user_settings.h:270`), so this
command is not available in the current build.

### Errors

- `ERROR: Invalid register` — name not in `uartRegConfig[]`
- `ERROR: Read-only register` — RW attempted on an `REG_ACCESS_RO` entry
- `ERROR: Invalid command` — `AT+` with neither `=` nor `?`
- `ERROR: Invalid SFRA command` — `SFRA_CAL` with an argument or a `?`

A line that does not begin with `AT+` produces **no response at all** — the
buffer is simply reset. Silence is not an error indication.

---

## Register names

Both short and long names work. The full table is `uartRegConfig[]` in
`registers.c`, which is sized `TOTAL_REGISTERS` and must stay index-aligned
with `regConfig[]`. A representative sample:

| Short | Long | Access |
|---|---|---|
| `C0M` | `Ch0_Mode` | RW |
| `C0CVMAX` | `Ch0_ChargeVoltageMax` | RW |
| `C0S` | `Ch0_Status` | RO |
| `C0VOLT` | `Ch0_CellVoltage` | RO — **internal 12-bit ADC** |
| `C0CURR` | `Ch0_CellCurrent` | RO — **internal 12-bit ADC** |
| `C0SV` | `Ch0_SenseVoltage` | RO — **ADS131M08, 16-bit** |
| `C0SI` | `Ch0_SenseCurrent` | RO — **ADS131M08, 16-bit** |
| `C0TEMP` | `Ch0_CellTemp` | RO — measured, from ADS1119 |
| `C0MINT` | `Ch0_MinCellTemp` | RW — configured limit, not a measurement |
| `CDV` | `ChargeDisableV` | RW |
| `CALM` | `CalibrationMode` | RW |
| `UNITST` | `UnitState` | RO |
| `VIN` | `InputVoltage` | RO |
| `TRIPS` | `TripStatus` | RO — **never written on this build** |
| `SMD` / `SEN` / `SGS` | `SlotMode` / `SlotEnable` / `GroupSize` | RO — dip straps |
| `CALSLOT` | `CalSlot` | RW |
| `CALCMD` | `CalCommand` | RW |
| `CALARG` | `CalArgument` | RW |
| `CALSTAT` | `CalStatus` | RO |
| `CALRES` | `CalResult` | RO |
| `CALAVPU` … `CALFIA` | `CalAdsV_pu` … `CalF28I_A` | RO — live telemetry |
| `CALTEMP` | `CalTemp_C` | RO |

Note the naming trap: `C0VOLT` / `C0CURR` are the **internal** ADC, while
`C0SV` / `C0SI` are the external ADS131M08 — the opposite of what the names
suggest. See `SKILL.md`.

---

## Side effects

- Any RW write raises `IPC_FLAG0` to CPU1 with `ipcMsg` as the payload. CPU1
  only decodes the control block, the per-channel calibration block and
  `eCalCommand`; anything else is acked and discarded.
- `AT+CALM=2` sets `calibrationSavePending`; the idle loop then saves all
  eight channels plus the global voltage thresholds to F-RAM. There is **no
  completion response** — `OK` acknowledges the register write, not the save.
  Poll `CALSTAT` bit 7 (runtime path) or just re-read the gains.
- `AT+CALCMD=<n>` self-clears to 0 on acceptance, so a read-back of `CALCMD`
  is always 0 and tells you nothing. Read `CALRES` and `CALSTAT` instead.
  Write `CALARG` **before** `CALCMD`.
- A mode write goes to `modeCallback()` on CPU1, which **refuses it outright**
  if the slot is strap-disabled, is a group follower, or the DC input voltage
  is outside the charge/discharge restrict window. The channel is left stopped
  and nothing is reported. Always read `C0S` back.

---

## Example session

```
AT+C0M?
+C0M=0.00
OK
AT+C0CVMAX=4.20
OK
AT+C0CCMAX=2.00
OK
AT+C0M=3
OK
AT+C0S?
+C0S=145.00
OK
```

`145` = `0b10010001` → bit 0 RUNNING, bit 4 CHARGING, bit 7 CONST_CURRENT.
Bit 7 is now genuinely populated from `ctrlMode_logic`; on earlier builds the
same state read as `17`. The build is CC-only, so bit 6 (CONST_VOLTAGE) will
not appear.

Calibration by hand, one slot:

```
AT+CALSLOT=3
OK
AT+CALCMD=1          ; CAL_CMD_ENTER
OK
AT+CALSTAT?
+CALSTAT=1.00        ; bit 0, active
OK
AT+CALARG=0.85       ; the DMM's reading, volts
OK
AT+CALCMD=3          ; CAL_CMD_CAPTURE_VOLTAGE
OK
AT+CALRES?
+CALRES=0.00         ; eCalErrOk
OK
```

The full opcode table, the pu windows the captures are checked against, and
the reason the supply is set to 0.85 V and 4.25 V rather than 1 V and 4 V, are
in `Docs/calibration-design.md`. The operator procedure is `Docs/README.md`.

---

## Boot banner

On a debug build CPU2 prints a banner once interrupts are enabled, then
`initADS1119()` reports each converter:

```
BTS F2837xD CPU2 ready
+ChargeDisableV=9.00
+Ch0_F28V_Gain=1.00
OK
ADS1119 @0x40 ok
ADS1119 @0x41 not found
```

The two echoed registers are a deliberate probe of the F-RAM load: a
`ChargeDisableV` of exactly 9.00 with a `Ch0_F28V_Gain` of exactly 1.00 means
**both** fell back to compiled defaults — i.e. the F-RAM image failed
validation, or this is the first boot after a header-magic bump.

`ADS1119 ... not found` means the part did not acknowledge or did not read
back the configuration it was given; its DRDY interrupt is then left masked
and every temperature on those four slots stays at its last value. That line
is the quickest check that the I2CB wiring is good.

Note the ordering: the banner is printed **before** `initADS1119()`, so it
still appears even if a device on I2CB is absent or holding the bus.
