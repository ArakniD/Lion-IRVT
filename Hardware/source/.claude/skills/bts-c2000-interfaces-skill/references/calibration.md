# Calibration Process & EEPROM Layout

## Overview

Calibration data is stored in an external I2C EEPROM (address 0x50 on the I2CB master bus). Each of the 8 channels has an independent `BTS_channelCalibration` block. Global charge/discharge voltage thresholds are stored separately.

## Structure (`BTS_channelCalibration`)

```c
typedef struct _BTS_channelCalibration {
    uint32_t  header;       // 0xA5CC | channel  (low byte = channel number)
    uint32_t  dateTime;     // DEVICE_GETTIMERCOUNT snapshot
    float32_t MinCellTemp;
    float32_t MaxCellTemp;
    float32_t F28V_Gain;    // on-chip ADC cell voltage
    float32_t F28V_Offset;
    float32_t F28I_Gain;    // on-chip ADC cell current
    float32_t F28I_Offset;
    float32_t IoutGain_pu;
    float32_t IoutOffset_pu;
    float32_t IoutGain_A;
    float32_t IoutOffset_A;
    float32_t VoutGain_pu;
    float32_t VoutOffset_pu;
    float32_t VoutGain_V;
    float32_t VoutOffset_V;
} BTS_channelCalibration;
```

Size is fixed; do not insert fields without updating both load/save and validation.

## EEPROM Map

| Address                  | Content                                      |
|--------------------------|----------------------------------------------|
| ch * sizeof(...)         | Channel 0..7 calibration block               |
| 0x0100                   | 4 × float32 global voltages (16 bytes)       |

Global voltages order:

1. ChargeDisableV
2. ChargeRestrictV
3. DischargeRestrictV
4. DischargeDisableV

## Boot Sequence (`loadCalibration`)

For each channel:

1. `readEEPROM(ch, &cal)`
2. `validateCalibration(&cal, ch)`:
   - header == 0xA5CC | ch
   - –40 °C ≤ MinCellTemp < MaxCellTemp ≤ 100 °C
   - 0.5 ≤ F28V_Gain ≤ 2.0, |F28V_Offset| ≤ 1.0
   - 0.5 ≤ F28I_Gain ≤ 2.0, |F28I_Offset| ≤ 2.0
3. On success: copy into `calibrationData[ch]` and the corresponding register slice; raise IPC for each float so Core 1 can update its local copies.
4. On failure: install compile-time defaults (PowerSUITE gains + safe 10 °C / 85 °C temperature window).

Global voltages are read from 0x0100 and validated against the ordered range 8.0 V … 16.8 V; otherwise defaults 9 / 10 / 15 / 16 V are used.

## Runtime Commit

Host writes the desired calibration registers (via I2C or UART).  
Then writes:

```
CalibrationMode = 2.0f
```

Core 2 responds by calling `saveCalibration(ch)` for every channel.  
Inside `saveCalibration`:

- Builds a fresh `BTS_channelCalibration` from the current register values
- Re-validates
- Writes to EEPROM only if valid
- If channel == 0 and CalibrationMode was 2, also writes the four global voltage floats to 0x0100 (after `validateGlobalVoltages`)

## Validation Rules (must be kept in sync)

```c
static bool validateCalibration(BTS_channelCalibration* cal, uint16_t channel)
{
    if (cal->header != (CAL_HEADER_VALID | channel)) return false;
    if (cal->MinCellTemp < -40.0f || cal->MaxCellTemp > 100.0f ||
        cal->MinCellTemp >= cal->MaxCellTemp) return false;
    if (cal->F28V_Gain < 0.5f || cal->F28V_Gain > 2.0f ||
        cal->F28V_Offset < -1.0f || cal->F28V_Offset > 1.0f) return false;
    if (cal->F28I_Gain < 0.5f || cal->F28I_Gain > 2.0f ||
        cal->F28I_Offset < -2.0f || cal->F28I_Offset > 2.0f) return false;
    return true;
}
```

Global voltage ordering:

```
MIN_VOLTAGE (8.0) ≤ ChargeDisableV ≤ ChargeRestrictV
                 ≤ DischargeRestrictV ≤ DischargeDisableV ≤ MAX_VOLTAGE (16.8)
```

## Defaults on Failure

Temperature window: 10 °C … 85 °C  
F28 gains: 1.0 (offsets 0) – **replace with calculated defaults** (there is a `#error` placeholder in the current source)  
Iout / Vout gains: PowerSUITE symbols `BTS_IoutGain_ch1_*` etc. (channel-specific macros exist)

## Notes for Future Work

- The `#error "calculate a gain and offset for defaults here"` in `loadCalibration` must be resolved before production.
- Timestamp (`dateTime`) is currently only a free-running counter; replace with RTC if available.
- Consider a CRC32 after the float block for stronger integrity checking.
