---
name: bts-c2000-interfaces
description: Documentation and procedures for the 8-channel bidirectional battery tester on TI C2000 F28379D (dual-core). Covers I2C slave/master interfaces, UART AT command set, ESP32 interaction as I2C master, calibration EEPROM process, CAN data, register map, current/power accumulators, Core1 HRPWM control vs Core2 communications, and build guidance for TI Code Composer Studio with C2000Ware and PowerSUITE.
---

# BTS C2000 Interfaces Skill

## Overview

This skill provides the authoritative interface specification, operational model, and development guidance for the dual-core TI TMS320F28379D battery tester solution (BTS). Core 1 runs the 8-channel synchronous bidirectional DC-DC control loops (HRPWM + DCL). Core 2 owns all external communication (I2C slave for ESP32, I2C master for EEPROM/ADS1119, UART AT commands, CAN telemetry, WS2812B LEDs) and non-volatile configuration.

Use this skill whenever editing, extending, or generating code related to registers, I2C/UART/CAN protocols, calibration, status LEDs, IPC between cores, or when preparing a build/deploy for TI CCS.

## Processors and Build Platform

- **MCU**: Texas Instruments TMS320F28379D (dual C28x cores + CLA)
- **Core assignment**:
  - CPU1: Real-time control – HRPWM updates, ADC/SPI external ADC reads, DCL current/voltage loops, trip zone handling, cell voltage/current sampling via on-chip ADC, IPC consumer.
  - CPU2: Communications & configuration – I2C slave (ESP32), I2C master (EEPROM + ADS1119 temp sensors), SCIB UART (AT commands), CANA (telemetry), SCIA (WS2812B), LED status, calibration load/save, IPC producer.
- **SDK / Libraries** (mandatory where possible):
  - C2000Ware (driverlib, device support)
  - Digital Control Library (DCL) FPU32
  - PowerSUITE / SFRA (optional frequency response)
  - SFO library for HRPWM MEP calibration
- **Build environment**: TI Code Composer Studio (CCS) with C2000 compiler. Dual-core project structure (CPU1 and CPU2 projects or single dual-core project). Flash/RAM sections use `CPU1TOCPU2RAM` / `CPU2TOCPU1RAM` for shared data.
- **Shared memory** — the message RAMs are single-writer, which determines the whole data-flow design:
  - CPU2→CPU1 RAM (`0x03F800`), written only by CPU2: `registers[]` (the register file), `ipcMsg` (single-register mailbox), `calibrationData[NUM_CHANNELS]`
  - CPU1→CPU2 RAM (`0x03FC00`), written only by CPU1: `cpu1Status` (status bits, cell V/I, input voltage, unit state, trip status), `canData[NUM_CHANNELS]`, `startup_mode` / `startup_enable`
  - CPU1 never writes `registers[]`; it publishes measurements through `cpu1Status` and CPU2 mirrors them in.

For the full IPC contract, flag allocation, boot and calibration data flows,
interrupt ownership, register-map strides, trip-source identification, and the
C28x 16-bit-byte / 32-bit-float constraints, see
`references/ipc-and-core-responsibilities.md`.

Always prefer driverlib APIs (`I2C_*`, `SCI_*`, `CAN_*`, `EPWM_*`, `HRPWM_*`, `IPC_*`, `GPIO_*`, `ADC_*`, `CPUTimer_*`) over bit-band or direct register writes.

## System Operation Summary

8 independent bidirectional synchronous buck/boost channels. Each channel supports charge (CC/CV) and discharge (CC/CV) with independent voltage/current limits, min/max cell temperature, and trip protection (CMPSS + GPIO).

- Mode register (per channel) encodes enable + direction (charge/discharge).
- Control setpoints are written via I2C/UART/CAN into the register map; Core 2 validates and IPC-notifies Core 1.
- Core 1 applies setpoints through `BTS_updateReference` → DCL loops → HRPWM duty.
- Measurements (Iout/Vout from external SPI ADCs, Cell V/I from on-chip ADC, temperature from ADS1119) are written back into the register map and CAN telemetry.
- Unit-level input voltage monitoring enforces charge/discharge restrict/disable thresholds.
- Status LEDs (WS2812B) reflect per-channel running/charging/discharging/finished/trip states.
- Calibration coefficients and global voltage thresholds are stored in external I2C EEPROM and loaded at boot.

## I2C Interfaces

### I2C Slave (I2CA) – ESP32 / External Host Access

- Pins: GPIO32 = SDA, GPIO33 = SCL
- Slave address: `0x50`
- Mode: Slave with RX/TX FIFO interrupts
- Protocol: Register-oriented 16-bit address + 32-bit float payload (big-endian byte order inside the float)

**Write sequence (host → device)**:
1. START + Slave addr (W)
2. Address high byte
3. Address low byte
4. 4 data bytes (float, MSB first)
5. (optional auto-increment for multi-register writes)
6. STOP

**Read sequence**:
1. START + Slave addr (W)
2. Address high + low
3. RESTART + Slave addr (R)
4. 4 data bytes returned
5. STOP

On write of a RW register, Core 2 updates `registers[]` and raises `IPC_FLAG0` to Core 1. Special case: writing `eCalibrationMode = 2.0f` triggers `saveCalibration()` for all channels + global voltages.

Address space is byte-oriented in the protocol but the internal `registers[]` array is indexed by `addr/4`. Only addresses present in `regConfig[]` with `REG_ACCESS_RW` are writable.

See `references/i2c-interface-spec.md` for full register map, access types, and ESP32 example code patterns.

### I2C Master (I2CB) – EEPROM + ADS1119

- Pins: GPIO34 = SDA, GPIO35 = SCL
- Used for:
  - External EEPROM at address `0x50` (same address as the slave; different bus)
  - Two ADS1119 ADCs (0x40 channels 0-3, 0x41 channels 4-7) for cell temperature (mV → °C lookup)
- Calibration blocks (`BTS_channelCalibration`) are written/read at offset `channel * sizeof(BTS_channelCalibration)`.
- Global voltage thresholds stored at EEPROM address 0x0100 (16 bytes = 4 floats).
- ADS1119 continuous conversion, DRDY on GPIO42/43 → XINT1/XINT2, round-robin channel mux.

## Serial (UART) Interface – AT Command Set

- SCIB: GPIO18 TX, GPIO19 RX, 1 000 000 baud, 8N1
- Commands are line-based (`\r` or `\n` terminated), prefix `AT+`
- Short names (e.g. `C0M`) or long names (e.g. `Ch0_Mode`) accepted (case sensitive match against `uartRegConfig[]`)

**Query**:
```
AT+C0M?
→ +C0M=1.00
OK
```

**Write**:
```
AT+C0M=1
OK
```
or
```
AT+Ch0_Mode=3.0
OK
```

**SFRA** (when enabled):
```
AT+SFRA_CAL
OK
```

Error responses: `ERROR: Invalid register`, `ERROR: Read-only register`, `ERROR: Invalid command`.

Writing `CalibrationMode=2` forces EEPROM save of all channels.

SCIA (GPIO28) is dedicated to WS2812B LED bit-banging at ~800 kbit/s and is not part of the command interface.

## CAN Interface

- CANA, 500 kbit/s, extended 29-bit IDs
- Base ID: `0x1C000000`
- TX objects 1-8: per-channel telemetry (channel, voltage, current)
- RX object 9: host register read/write (addr + R/W flag + float)
- Periodic TX driven by CPU Timer 1 (round-robin channels)

## Calibration Process

1. At boot Core 2 calls `loadCalibration()`:
   - Reads each channel’s `BTS_channelCalibration` from EEPROM.
   - Validates header `0xA5CC | channel`, temperature range, gain/offset sanity.
   - On success loads into `registers[]` and IPC-notifies Core 1.
   - On failure installs safe defaults (including PowerSUITE-generated gains).
   - Loads global charge/discharge voltage thresholds; falls back to 9/10/15/16 V if invalid.
2. Runtime: host writes calibration registers (F28V/I gains/offsets, Iout/Vout pu/A/V gains/offsets, min/max cell temp).
3. Commit: write `eCalibrationMode = 2.0f` → Core 2 calls `saveCalibration(ch)` for every channel (header + timestamp + all floats) and, if channel 0, also saves the four global voltage thresholds.
4. Validation is performed before every EEPROM write; invalid data is discarded.

`BTS_channelCalibration` layout (see registers.h) must stay binary-compatible with the EEPROM image.

## Current / Power Accumulators (Current Counter)

Registers `eChX_CurrentAcc` and `eChX_PowerAcc` (RO) are intended to accumulate charge (mAh) and energy (mWh) for capacity testing / coulomb counting.

- Intention: Integrate measured cell/current (`Isense_A` or `CellCurrent_I`) over time while the channel is running.
- Typical implementation location: Core 1 background task (C1/C2 at 10 Hz) or a dedicated low-rate ISR.
- Update rule (suggested):
  ```c
  delta_t_h = 1.0f / 3600.0f / update_rate_Hz;
  registers[eChX_CurrentAcc/4] += meas->Isense_A * 1000.0f * delta_t_h; // mAh
  registers[eChX_PowerAcc/4]   += meas->Isense_A * meas->Vsense_V * 1000.0f * delta_t_h; // mWh
  ```
- Reset on mode change to stopped or on explicit host command (future extension).
- Values are also mirrored into `canData[ch].mAh` / `.mWh` for CAN telemetry.
- Min/Max voltage registers track extrema while running.

These accumulators are currently declared in the register map but the continuous integration logic is a planned feature; implement it on Core 1 using the already-averaged `BTS_measValues`.

## ESP32 Interaction Model

The ESP32 is the primary external controller and acts as I2C master on the I2CA bus (address 0x50). It:

- Reads status, cell voltage/current, temperature, accumulators, trip status, unit state, input voltage.
- Writes mode, voltage/current limits, calibration coefficients.
- May also use the UART AT interface for debug or alternative control.
- Receives periodic CAN frames if connected to the same CAN bus.
- Is expected to respect the unit-level charge/discharge restrict/disable thresholds (or the C2000 will enforce them by clearing enable).

All multi-byte floats are IEEE-754 little-endian on the wire? No – the I2C slave code packs bytes as `((uint8_t*)&tempData)[3 - (byteCount-2)]`, i.e. big-endian byte order for the float. ESP32 code must match this endianness when packing/unpacking.

## Key Source Files

| File              | Core | Responsibility |
|-------------------|------|----------------|
| registers.h/c     | both | Register map, config tables, shared structs |
| com_cpu2.c        | CPU2 | All I2C/UART/CAN/LED/ADS1119/EEPROM |
| bts_cpu1.c        | CPU1 | Main, ISRs, state machine, register write handler, trips |
| bts.c / bts.h     | CPU1 | Control loops, user/program variables, SFRA, monitoring |
| led_driver.c/h    | CPU2 | WS2812B status indication |
| bts_hal.*         | CPU1 | (not supplied) HAL for PWM/ADC/SPI/GPIO |

## Development Rules

- Never hard-code device_id or pin numbers outside the HAL / init functions; use the existing `#define`s.
- All shared data that Core 1 reads must be in `CPU2TOCPU1RAM` (or dual-port sections) and protected by IPC flags or careful single-writer discipline.
- Prefer `BTS_*` and driverlib helpers over raw register access.
- When adding a new register, update both `regConfig[]`, `uartRegConfig[]`, the enum, and the TOTAL_REGISTERS calculation.
- Calibration header validation and range checks are mandatory before any EEPROM write.
- Temperature conversion uses a linear interpolation table; replace `mvToTempTable` with real sensor data when available.

## References

- IPC mechanics, core responsibility split, boot/calibration data flows, interrupt ownership, register strides, trip-source identification → `references/ipc-and-core-responsibilities.md`
- Detailed I2C protocol, register list, endianness, and ESP32 snippets → `references/i2c-interface-spec.md`
- UART command reference and example sessions → `references/uart-at-commands.md`
- Calibration EEPROM layout and validation rules → `references/calibration.md`
