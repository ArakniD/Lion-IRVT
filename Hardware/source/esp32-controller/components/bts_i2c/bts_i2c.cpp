/**
 * bts_i2c.cpp
 *
 * Implementation of the I2C library for the TI C2000 F28379D BTS system.
 *
 * Created on: April 20, 2025
 * Author: Grok
 */

#include "bts_i2c.h"

BTSI2C::BTSI2C() {}

bool BTSI2C::begin() {
    Wire.begin();
    Wire.setClock(100000); // 100 kHz I2C
    return true;
}

float BTSI2C::read_voltage(uint8_t channel) {
    if (channel >= NUM_CHANNELS) return 0.0f;
    float value;
    read_register(eCh0_CellVoltage + channel * 24, value);
    return value;
}

float BTSI2C::read_current(uint8_t channel) {
    if (channel >= NUM_CHANNELS) return 0.0f;
    float value;
    read_register(eCh0_CellCurrent + channel * 24, value);
    return value;
}

float BTSI2C::read_temperature(uint8_t channel) {
    if (channel >= NUM_CHANNELS) return 0.0f;
    float value;
    read_register(eCh0_MinCellTemp + channel * 8, value);
    return value;
}

ChannelStatus BTSI2C::read_status(uint8_t channel) {
    ChannelStatus status = {0};
    if (channel >= NUM_CHANNELS) return status;
    float value;
    if (read_register(eCh0_Status + channel * 40, value)) {
        uint32_t bits = (uint32_t)value;
        status.running = bits & (1 << 0);
        status.stopped = bits & (1 << 1);
        status.finished = bits & (1 << 2);
        status.over_current_trip = bits & (1 << 3);
        status.charging = bits & (1 << 4);
        status.discharging = bits & (1 << 5);
        status.const_voltage = bits & (1 << 6);
        status.const_current = bits & (1 << 7);
    }
    // Read trip status
    float trip_value;
    if (read_register(eTripStatus, trip_value)) {
        uint32_t trip_bits = (uint32_t)trip_value;
        status.cmpss_trip = trip_bits & (1 << (channel * 2));
        status.gpio_trip = trip_bits & (1 << (channel * 2 + 1));
    }
    return status;
}

float BTSI2C::read_input_voltage() {
    float value;
    read_register(eInputVoltage, value);
    return value;
}

UnitState BTSI2C::read_unit_state() {
    float value;
    read_register(eUnitState, value);
    return (UnitState)(uint32_t)value;
}

bool BTSI2C::read_trip_status(uint8_t channel, bool cmpss) {
    if (channel >= NUM_CHANNELS) return false;
    float value;
    if (read_register(eTripStatus, value)) {
        uint32_t bits = (uint32_t)value;
        return bits & (1 << (channel * 2 + (cmpss ? 0 : 1)));
    }
    return false;
}

void BTSI2C::set_mode(uint8_t channel, bool enable, bool charge) {
    if (channel >= NUM_CHANNELS) return;
    uint32_t mode = 0;
    mode |= enable ? 1 : 0;
    mode |= charge ? 2 : 0;
    write_register(eCh0_Mode + channel * 40, (float)mode);
}

void BTSI2C::set_battery_profile(uint8_t channel, const BatteryProfile& profile) {
    if (channel >= NUM_CHANNELS) return;
    uint16_t base = eCh0_ChargeVoltageMin + channel * 40;
    write_register(base + 0, profile.charge_voltage_min);
    write_register(base + 4, profile.charge_voltage_max);
    write_register(base + 8, profile.discharge_voltage_min);
    write_register(base + 12, profile.discharge_voltage_max);
    write_register(base + 16, profile.charge_current_min);
    write_register(base + 20, profile.charge_current_max);
    write_register(base + 24, profile.discharge_current_min);
    write_register(base + 28, profile.discharge_current_max);
    write_register(eCh0_MinCellTemp + channel * 8, profile.min_cell_temp);
    write_register(eCh0_MaxCellTemp + channel * 8, profile.max_cell_temp);
}

void BTSI2C::set_calibration_mode(float mode) {
    write_register(eCalibrationMode, mode);
}

void BTSI2C::set_global_voltages(float charge_disable, float charge_restrict,
                                 float discharge_restrict, float discharge_disable) {
    write_register(eChargeDisableV, charge_disable);
    write_register(eChargeRestrictV, charge_restrict);
    write_register(eDischargeRestrictV, discharge_restrict);
    write_register(eDischargeDisableV, discharge_disable);
}

void BTSI2C::apply_samsung_25r_profile(uint8_t channel) {
    BatteryProfile profile = {
        4.20f,  // charge_voltage_max
        3.60f,  // charge_voltage_min
        3.60f,  // discharge_voltage_max
        2.50f,  // discharge_voltage_min
        5.0f,   // charge_current_max
        0.1f,   // charge_current_min
        20.0f,  // discharge_current_max
        0.1f,   // discharge_current_min
        -20.0f, // min_cell_temp
        60.0f   // max_cell_temp
    };
    set_battery_profile(channel, profile);
}

void BTSI2C::apply_samsung_20q_profile(uint8_t channel) {
    BatteryProfile profile = {
        4.20f,  // charge_voltage_max
        3.60f,  // charge_voltage_min
        3.60f,  // discharge_voltage_max
        2.50f,  // discharge_voltage_min
        4.0f,   // charge_current_max
        0.1f,   // charge_current_min
        15.0f,  // discharge_current_max
        0.1f,   // discharge_current_min
        -20.0f, // min_cell_temp
        60.0f   // max_cell_temp
    };
    set_battery_profile(channel, profile);
}

bool BTSI2C::read_register(uint16_t reg_addr, float& value) {
    Wire.beginTransmission(BTS_I2C_ADDRESS);
    Wire.write(reg_addr >> 8);
    Wire.write(reg_addr & 0xFF);
    if (Wire.endTransmission() != 0) {
        return false;
    }

    Wire.requestFrom(BTS_I2C_ADDRESS, REGISTER_SIZE);
    if (Wire.available() != REGISTER_SIZE) {
        return false;
    }

    uint8_t bytes[REGISTER_SIZE];
    for (uint8_t i = 0; i < REGISTER_SIZE; i++) {
        bytes[i] = Wire.read();
    }
    value = bytes_to_float(bytes);
    return true;
}

bool BTSI2C::write_register(uint16_t reg_addr, float value) {
    uint8_t bytes[REGISTER_SIZE];
    float_to_bytes(value, bytes);

    Wire.beginTransmission(BTS_I2C_ADDRESS);
    Wire.write(reg_addr >> 8);
    Wire.write(reg_addr & 0xFF);
    for (uint8_t i = 0; i < REGISTER_SIZE; i++) {
        Wire.write(bytes[i]);
    }
    return Wire.endTransmission() == 0;
}

float BTSI2C::bytes_to_float(uint8_t* bytes) {
    union {
        float f;
        uint8_t b[4];
    } u;
    // BTS uses little-endian float
    u.b[0] = bytes[0];
    u.b[1] = bytes[1];
    u.b[2] = bytes[2];
    u.b[3] = bytes[3];
    return u.f;
}

void BTSI2C::float_to_bytes(float value, uint8_t* bytes) {
    union {
        float f;
        uint8_t b[4];
    } u;
    u.f = value;
    bytes[0] = u.b[0];
    bytes[1] = u.b[1];
    bytes[2] = u.b[2];
    bytes[3] = u.b[3];
}