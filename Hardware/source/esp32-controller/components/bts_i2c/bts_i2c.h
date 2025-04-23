/**
 * bts_i2c.h
 *
 * I2C library for interfacing an ESP32 with the TI C2000 F28379D BTS system.
 * Provides abstracted access to battery channel data and control registers.
 *
 * Created on: April 20, 2025
 * Author: Grok
 */

#ifndef BTS_I2C_H
#define BTS_I2C_H

#include <Wire.h>
#include <stdint.h>

#define BTS_I2C_ADDRESS 0x50
#define NUM_CHANNELS 8
#define REGISTER_SIZE 4 // 4 bytes per register (float32_t)

// Register addresses from registers.h
enum RegisterAddress {
    eCh0_Mode = 0,
    eCh0_ChargeVoltageMin = 4,
    eCh0_ChargeVoltageMax = 8,
    eCh0_DischargeVoltageMin = 12,
    eCh0_DischargeVoltageMax = 16,
    eCh0_ChargeCurrentMin = 20,
    eCh0_ChargeCurrentMax = 24,
    eCh0_DischargeCurrentMin = 28,
    eCh0_DischargeCurrentMax = 32,
    eCh0_Status = 36,
    // Other channels follow the same pattern, offset by 40 bytes
    eCh0_CellVoltage = 336,
    eCh0_CellCurrent = 340,
    eCh0_MinCellTemp = 512,
    eCh0_MaxCellTemp = 516,
    eChargeDisableV = 576,
    eChargeRestrictV = 580,
    eDischargeRestrictV = 584,
    eDischargeDisableV = 588,
    eCalibrationMode = 976,
    eUnitState = 980,
    eInputVoltage = 984,
    eTripStatus = 988
};

// Battery profile struct
struct BatteryProfile {
    float charge_voltage_max;    // V
    float charge_voltage_min;    // V
    float discharge_voltage_max; // V
    float discharge_voltage_min; // V
    float charge_current_max;    // A
    float charge_current_min;    // A
    float discharge_current_max; // A
    float discharge_current_min; // A
    float min_cell_temp;         // °C
    float max_cell_temp;         // °C
};

// Channel status struct
struct ChannelStatus {
    bool running;
    bool stopped;
    bool finished;
    bool over_current_trip;
    bool charging;
    bool discharging;
    bool const_voltage;
    bool const_current;
    bool cmpss_trip;
    bool gpio_trip;
};

// Unit state enum
enum UnitState {
    INPUT_LOW_CHARGE_DISABLED,
    INPUT_LOW_CHARGE_RESTRICTED,
    INPUT_OK,
    INPUT_HIGH_DISCHARGE_RESTRICTED,
    INPUT_HIGH_DISCHARGE_DISABLED
};

class BTSI2C {
public:
    BTSI2C();

    // Initialize I2C interface
    bool begin();

    // Read sensor data
    float read_voltage(uint8_t channel);
    float read_current(uint8_t channel);
    float read_temperature(uint8_t channel);
    ChannelStatus read_status(uint8_t channel);
    float read_input_voltage();
    UnitState read_unit_state();
    bool read_trip_status(uint8_t channel, bool cmpss);

    // Control functions
    void set_mode(uint8_t channel, bool enable, bool charge);
    void set_battery_profile(uint8_t channel, const BatteryProfile& profile);
    void set_calibration_mode(float mode);
    void set_global_voltages(float charge_disable, float charge_restrict,
                            float discharge_restrict, float discharge_disable);

    // Predefined battery profiles
    void apply_samsung_25r_profile(uint8_t channel);
    void apply_samsung_20q_profile(uint8_t channel);

private:
    // Low-level I2C read/write
    bool read_register(uint16_t reg_addr, float& value);
    bool write_register(uint16_t reg_addr, float value);

    // Convert bytes to float
    float bytes_to_float(uint8_t* bytes);
    // Convert float to bytes
    void float_to_bytes(float value, uint8_t* bytes);
};

#endif // BTS_I2C_H