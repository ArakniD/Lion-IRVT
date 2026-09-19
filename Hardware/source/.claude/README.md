# Battery Tester Solution (BTS) – TI C2000 F28379D Dual-Core

## Project Summary

8-channel synchronous bidirectional DC-DC battery tester / cycler built on the Texas Instruments TMS320F28379D.

- **Core 1 (CPU1)**: Real-time control – HRPWM generation, DCL current/voltage loops (CC/CV), external SPI ADC reads, on-chip ADC cell voltage/current sampling, trip-zone handling, IPC consumer.
- **Core 2 (CPU2)**: Communications & non-volatile storage – I2C slave (ESP32 register access), I2C master (EEPROM + ADS1119 temperature), UART AT-command interface, CAN telemetry, WS2812B status LEDs, calibration load/save, IPC producer.

The design follows TI C2000Ware driverlib, Digital Control Library (DCL), and PowerSUITE conventions. SFRA support is optionally available.

## Build Platform

- **IDE / Compiler**: TI Code Composer Studio (CCS) with C2000 compiler tools
- **SDK**: C2000Ware (latest recommended), PowerSUITE / SFRA packages
- **Target**: TMS320F28379D (dual C28x + CLA)
- **Project structure**: Dual-core (CPU1 + CPU2) with shared RAM sections `CPU1TOCPU2RAM` / `CPU2TOCPU1RAM`
- **Key libraries used**:
  - driverlib (I2C, SCI, CAN, EPWM, HRPWM, ADC, GPIO, IPC, CPUTimer, …)
  - DCL FPU32
  - SFO (HRPWM MEP calibration)
  - SFRA (optional)

## Features Requested / Implemented in this Workspace

The following capabilities have been specified and partially or fully implemented across the supplied sources (`registers.*`, `com_cpu2.c`, `bts_cpu1.c`, `bts.*`, `led_driver.*`):

### Register Map & IPC
- Unified float register file (`registers[TOTAL_REGISTERS]`) covering:
  - Per-channel control (mode, charge/discharge V/I min/max)
  - Per-channel status bitfield
  - Stats (current/power accumulators, min/max voltage, cell V/I)
  - Calibration coefficients (F28 ADC gains/offsets, Iout/Vout gains/offsets, cell temp limits)
  - Unit-level (CalibrationMode, UnitState, InputVoltage, TripStatus)
- IPC mailbox (`ipcMsg`) for Core2 → Core1 register writes
- Access-type tables (`regConfig`, `uartRegConfig`) for validation and name lookup

### External Interfaces (Core 2)
- **I2C Slave (I2CA, addr 0x50)**: Register read/write for ESP32 or other host. 16-bit address + 32-bit float (big-endian). Auto-increment support. CalibrationMode=2 triggers full EEPROM save.
- **I2C Master (I2CB)**: EEPROM (calibration blocks + global voltages) and dual ADS1119 temperature ADCs (DRDY interrupts, round-robin mux).
- **UART AT Commands (SCIB, 1 Mbaud)**: `AT+<short|long name>?` / `AT+<name>=value` with short names (C0M, C0CA, …) and long names. SFRA_CAL support.
- **CAN (CANA, 500 kbit/s, extended ID)**: Periodic per-channel telemetry (V/I) + host register R/W object.
- **WS2812B LEDs (SCIA)**: Per-channel status colour/pattern (red = below min, green flash = charging, blue strobe = discharging, white = finished).

### Control & Protection (Core 1)
- 8 independent bidirectional synchronous converters with HRPWM
- DCL-based CC and CV loops (selectable CCCV / CV / CC modes)
- Direction-aware trip and MOSFET force-off logic
- CMPSS + GPIO trip-zone support with latched `eTripStatus` bitfield
- Input-voltage state machine (ChargeDisable / ChargeRestrict / OK / DischargeRestrict / DischargeDisable) that can force channels off
- Background state machine (A/B/C tasks at 1 kHz / 100 Hz / 10 Hz) for reference updates, SFRA, monitoring, and register handling

### Calibration
- Per-channel EEPROM image with header validation (0xA5CC | ch)
- Load at boot with safe defaults on failure
- Runtime write of coefficients + commit via CalibrationMode = 2
- Global voltage thresholds also stored in EEPROM

### Measurement & Accumulators
- External SPI ADCs for high-bandwidth I/V (Core 1 ISR path)
- On-chip ADC for cell voltage/current (averaged)
- ADS1119 for cell temperature (mV → °C table)
- **Charge / discharge accumulators**: mAh and mWh per slot per direction, integrated on Core 1 in the 6.67 Hz `C1()` task from the 16-bit ADS131M08 pair. Charge at `eChX_ChargeAcc_mAh`/`_mWh` (320/332), discharge at `eChX_DischargeAcc_mAh`/`_mWh` (1156+). Each pair is zeroed only when its own direction starts.

### Status & Telemetry
- Per-channel status bitfield exposed via registers, UART, and (indirectly) LEDs
- CAN frames carry live V/I; the `CAN_data` mAh/mWh fields are populated from the accumulator matching each slot's direction, but are not yet transmitted
- Unit state and trip sources visible to the host

## Outstanding / Planned Items Visible in Source

- Resolve the `#error "calculate a gain and offset for defaults here"` in `loadCalibration`
- Replace placeholder `mvToTempTable` with real thermistor / sensor characterisation
- Complete any missing HAL files (`bts_hal.*`) referenced by the control code
- Transmit the populated `canData[].mAh`/`.mWh` in `sendCANData()`
- Optional: RTC timestamp, host-commanded accumulator reset (the counters are RO and self-reset per direction)

## How to Use with a Build Agent / TI CCS AI Tools

1. Point the agent at this repository (or the extracted sources).
2. Load the companion skill `bts-c2000-interfaces` (located under `.grok/skills/`) for authoritative interface, register, calibration, and dual-core rules.
3. Prefer driverlib + existing `BTS_*` helpers; never invent new pin maps or IPC flags without updating both cores.
4. When adding registers, update the enum, both config tables, and `TOTAL_REGISTERS`.
5. All new shared data that Core 1 must see must be placed in the correct dual-port RAM section and protected by the existing IPC flag protocol.

## Key Source Files

| File            | Core | Role |
|-----------------|------|------|
| registers.h/c   | both | Register map, shared structs, access tables |
| com_cpu2.c      | CPU2 | I2C / UART / CAN / LED / ADS1119 / EEPROM |
| bts_cpu1.c      | CPU1 | Main, ISRs, state machine, register handler, trips |
| bts.c / bts.h   | CPU1 | Control loops, variables, SFRA, monitoring |
| led_driver.*    | CPU2 | WS2812B status LEDs |

## License / Origin

Derived from TI TIDM-DC-DC-BUCK PowerSUITE example (v2.00.00.00) and heavily extended for multi-channel bidirectional battery testing, dual-core communication, and external host interfaces.

---

For full interface details, ESP32 interaction notes, UART command list, and calibration EEPROM layout, refer to the agent skill `bts-c2000-interfaces` and its `references/` documents.
