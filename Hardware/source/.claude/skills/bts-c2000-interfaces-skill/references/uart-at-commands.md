# UART AT Command Reference (SCIB)

## Physical

- SCIB: GPIO18 (TX), GPIO19 (RX)
- 1 000 000 baud, 8 data bits, no parity, 1 stop bit
- Line termination: `\r`, `\n` or `\r\n`
- Response terminator: `\r\n`

## Command Syntax

All commands start with `AT+`.

### Query

```
AT+<name>?
```

Response:

```
+<name>=<value>
OK
```

Value is printed with 2 decimal places (`%.2f`).

### Write

```
AT+<name>=<value>
```

Response on success:

```
OK
```

### Special

```
AT+SFRA_CAL
```

Starts SFRA calibration (only when SFRA is compiled in and enabled).

## Register Names

Both short and long names from `uartRegConfig[]` are accepted.

Examples:

| Short  | Long                     | Access |
|--------|--------------------------|--------|
| C0M    | Ch0_Mode                 | RW     |
| C0CVMIN| Ch0_ChargeVoltageMin     | RW     |
| C0S    | Ch0_Status               | RO     |
| C0CA   | Ch0_CurrentAcc           | RO     |
| C0VOLT | Ch0_CellVoltage          | RO     |
| C0CURR | Ch0_CellCurrent          | RO     |
| C0MINT | Ch0_MinCellTemp          | RW     |
| CDV    | ChargeDisableV           | RW     |
| CALM   | CalibrationMode          | RW     |
| UNITST | UnitState                | RO     |
| VIN    | InputVoltage             | RO     |
| TRIPS  | TripStatus               | RO     |

Full table lives in `registers.c` (`uartRegConfig`).

## Error Responses

- `ERROR: Invalid register`
- `ERROR: Read-only register`
- `ERROR: Invalid command`
- `ERROR: Invalid SFRA command`

## Side Effects

- Writing any RW control register raises IPC_FLAG0 to Core 1.
- Writing `CalibrationMode=2` (value 2.0f) forces a full EEPROM save of all channel calibrations and the global voltage thresholds.
- Mode register writes are processed by `modeCallback()` on Core 1, which applies enable/direction and set-points, subject to the current unit input-voltage state.

## Example Session

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
+C0S=17.00
OK
AT+CALM=2
OK
```

(Status 17 = 0b10001 → running + charging)
