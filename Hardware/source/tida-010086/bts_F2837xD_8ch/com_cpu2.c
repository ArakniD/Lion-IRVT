/*
 * com_cpu2.c
 *
 *  Created on: 15 Apr. 2025
 *      Author: lucas
 */

#ifdef CPU2

#include "driverlib.h"
#include "device.h"
#include "registers.h"
#include "led_driver.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

// ADS1119 Configuration
#define ADS1119_ADDR_1 0x40  // First ADS1119 (channels 0-3)
#define ADS1119_ADDR_2 0x41  // Second ADS1119 (channels 4-7)
#define ADS1119_CONFIG_REG 0x01
#define ADS1119_DATA_REG 0x00
#define ADS1119_CONFIG_CONT 0x85C3  // Continuous, 16-bit, 2.048V ref, 90 SPS
#define ADS1119_DRDY_GPIO_1 42     // DRDY for ADS1119 #1
#define ADS1119_DRDY_GPIO_2 43     // DRDY for ADS1119 #2

// EEPROM layout
#define EEPROM_I2C_ADDR       0x50
#define EEPROM_GLOBAL_V_ADDR  0x0100   // 16 bytes = 4 floats

// Validation limits
#define MIN_VOLTAGE 8.0f
#define MAX_VOLTAGE 16.8f

// Default global voltage thresholds, used when the EEPROM copy is invalid
#define DEFAULT_CHARGE_DISABLE_V     9.0f
#define DEFAULT_CHARGE_RESTRICT_V    10.0f
#define DEFAULT_DISCHARGE_RESTRICT_V 15.0f
#define DEFAULT_DISCHARGE_DISABLE_V  16.0f

// Default cell temperature window
#define DEFAULT_MIN_CELL_TEMP        10.0f
#define DEFAULT_MAX_CELL_TEMP        85.0f

//
// Default on-chip ADC scaling for cell voltage and current.
//
// The F2837xD ADC is configured for 12-bit single-ended operation against a
// 3.3 V reference (BTS_HAL_setupADC). BTS_monitor_Iout_Vout normalises the
// raw count to 0..1 and then multiplies by 2.5 before applying these gains,
// so a gain of 1.0 with zero offset yields a 0..2.5 V reading. The cell
// voltage divider and the current-sense amplifier are both unity by default;
// a real gain/offset pair is established by the calibration procedure and
// stored in EEPROM.
//
#define DEFAULT_F28V_GAIN            1.0f
#define DEFAULT_F28V_OFFSET          0.0f
#define DEFAULT_F28I_GAIN            1.0f
#define DEFAULT_F28I_OFFSET          0.0f

//
// Per-channel default Iout/Vout calibration, taken from the PowerSUITE
// generated two-point calibration in bts_user_calibration.h.
//
static const float32_t defaultIoutGain_pu[NUM_CHANNELS] = {
    BTS_IoutGain_ch1_pu, BTS_IoutGain_ch2_pu, BTS_IoutGain_ch3_pu, BTS_IoutGain_ch4_pu,
    BTS_IoutGain_ch5_pu, BTS_IoutGain_ch6_pu, BTS_IoutGain_ch7_pu, BTS_IoutGain_ch8_pu
};
static const float32_t defaultIoutOffset_pu[NUM_CHANNELS] = {
    BTS_IoutOffset_ch1_pu, BTS_IoutOffset_ch2_pu, BTS_IoutOffset_ch3_pu, BTS_IoutOffset_ch4_pu,
    BTS_IoutOffset_ch5_pu, BTS_IoutOffset_ch6_pu, BTS_IoutOffset_ch7_pu, BTS_IoutOffset_ch8_pu
};
static const float32_t defaultIoutGain_A[NUM_CHANNELS] = {
    BTS_IoutGain_ch1_A, BTS_IoutGain_ch2_A, BTS_IoutGain_ch3_A, BTS_IoutGain_ch4_A,
    BTS_IoutGain_ch5_A, BTS_IoutGain_ch6_A, BTS_IoutGain_ch7_A, BTS_IoutGain_ch8_A
};
static const float32_t defaultIoutOffset_A[NUM_CHANNELS] = {
    BTS_IoutOffset_ch1_A, BTS_IoutOffset_ch2_A, BTS_IoutOffset_ch3_A, BTS_IoutOffset_ch4_A,
    BTS_IoutOffset_ch5_A, BTS_IoutOffset_ch6_A, BTS_IoutOffset_ch7_A, BTS_IoutOffset_ch8_A
};
static const float32_t defaultVoutGain_pu[NUM_CHANNELS] = {
    BTS_VoutGain_ch1_pu, BTS_VoutGain_ch2_pu, BTS_VoutGain_ch3_pu, BTS_VoutGain_ch4_pu,
    BTS_VoutGain_ch5_pu, BTS_VoutGain_ch6_pu, BTS_VoutGain_ch7_pu, BTS_VoutGain_ch8_pu
};
static const float32_t defaultVoutOffset_pu[NUM_CHANNELS] = {
    BTS_VoutOffset_ch1_pu, BTS_VoutOffset_ch2_pu, BTS_VoutOffset_ch3_pu, BTS_VoutOffset_ch4_pu,
    BTS_VoutOffset_ch5_pu, BTS_VoutOffset_ch6_pu, BTS_VoutOffset_ch7_pu, BTS_VoutOffset_ch8_pu
};
static const float32_t defaultVoutGain_V[NUM_CHANNELS] = {
    BTS_VoutGain_ch1_V, BTS_VoutGain_ch2_V, BTS_VoutGain_ch3_V, BTS_VoutGain_ch4_V,
    BTS_VoutGain_ch5_V, BTS_VoutGain_ch6_V, BTS_VoutGain_ch7_V, BTS_VoutGain_ch8_V
};
static const float32_t defaultVoutOffset_V[NUM_CHANNELS] = {
    BTS_VoutOffset_ch1_V, BTS_VoutOffset_ch2_V, BTS_VoutOffset_ch3_V, BTS_VoutOffset_ch4_V,
    BTS_VoutOffset_ch5_V, BTS_VoutOffset_ch6_V, BTS_VoutOffset_ch7_V, BTS_VoutOffset_ch8_V
};

// mV to Temperature lookup table (placeholder)
static const struct {
    float mV;
    float tempC;
} mvToTempTable[] = {
    {500.0f, 0.0f},
    {600.0f, 10.0f},
    {700.0f, 20.0f},
    {800.0f, 30.0f},
    {900.0f, 40.0f},
    {1000.0f, 50.0f},
    {1100.0f, 60.0f},
    {1200.0f, 70.0f},
    {1300.0f, 80.0f},
    {1400.0f, 90.0f}
};
#define MV_TO_TEMP_TABLE_SIZE (sizeof(mvToTempTable) / sizeof(mvToTempTable[0]))

// Temperature reading buffer
static volatile float channelTemps[NUM_CHANNELS];
static volatile uint16_t currentAdsChannel[2] = {0, 0}; // Track channel for each ADS1119

//
// Forward declarations - every ISR below is registered before it is defined.
//
__interrupt void i2cSlaveISR(void);
__interrupt void i2cTargetISR(void);
__interrupt void i2cMasterISR(void);
__interrupt void canISR(void);
__interrupt void uartRxISR(void);
__interrupt void timerISR(void);
__interrupt void ads1119Drdy1ISR(void);
__interrupt void ads1119Drdy2ISR(void);

void uartSendResponse(const char* response);
void saveCalibration(uint16_t channel);
void loadCalibration(void);
static void notifyCpu1RegisterWrite(uint16_t regIdx, float32_t value);
static void notifyCpu1CalibrationReload(void);
static void formatRegisterValue(char *out, uint16_t outSize,
                                const char *name, float32_t value);

void initI2C_Slave(void)
{
    GPIO_setPinConfig(GPIO_32_SDAA);
    GPIO_setPinConfig(GPIO_33_SCLA);
    GPIO_setPadConfig(32, GPIO_PIN_TYPE_OD | GPIO_PIN_TYPE_PULLUP);
    GPIO_setPadConfig(33, GPIO_PIN_TYPE_OD | GPIO_PIN_TYPE_PULLUP);
    GPIO_setQualificationMode(32, GPIO_QUAL_ASYNC);
    GPIO_setQualificationMode(33, GPIO_QUAL_ASYNC);

    I2C_disableModule(I2CA_BASE);
    I2C_setOwnAddress(I2CA_BASE, 0x50);
    I2C_setBitCount(I2CA_BASE, I2C_BITCOUNT_8);
    I2C_setConfig(I2CA_BASE, I2C_TARGET_RECEIVE_MODE);
    I2C_setEmulationMode(I2CA_BASE, I2C_EMULATION_FREE_RUN);
    I2C_enableModule(I2CA_BASE);
    I2C_enableInterrupt(I2CA_BASE,
                        I2C_INT_RX_DATA_RDY | I2C_INT_TX_DATA_RDY |
                        I2C_INT_ADDR_TARGET | I2C_INT_STOP_CONDITION);
    Interrupt_register(INT_I2CA, &i2cSlaveISR);
    Interrupt_enable(INT_I2CA);
}

void initI2C_Master(void)
{
    GPIO_setPinConfig(GPIO_34_SDAB);
    GPIO_setPinConfig(GPIO_35_SCLB);
    GPIO_setPadConfig(34, GPIO_PIN_TYPE_OD | GPIO_PIN_TYPE_PULLUP);
    GPIO_setPadConfig(35, GPIO_PIN_TYPE_OD | GPIO_PIN_TYPE_PULLUP);
    GPIO_setQualificationMode(34, GPIO_QUAL_ASYNC);
    GPIO_setQualificationMode(35, GPIO_QUAL_ASYNC);

    I2C_disableModule(I2CB_BASE);
    I2C_initController(I2CB_BASE, DEVICE_SYSCLK_FREQ, 400000, I2C_DUTYCYCLE_50);
    I2C_setConfig(I2CB_BASE, I2C_CONTROLLER_SEND_MODE);
    I2C_setBitCount(I2CB_BASE, I2C_BITCOUNT_8);
    I2C_setEmulationMode(I2CB_BASE, I2C_EMULATION_FREE_RUN);
    I2C_enableModule(I2CB_BASE);
}

//
// Blocking byte-level EEPROM/I2C helpers. These run only at boot and on an
// explicit calibration save, so a polled implementation is appropriate.
//
static void i2cMasterWaitBusFree(void)
{
    while (I2C_isBusBusy(I2CB_BASE)) { }
}

static bool i2cMasterWaitReady(void)
{
    uint32_t guard = 0;
    while ((I2C_getStatus(I2CB_BASE) & I2C_STS_REG_ACCESS_RDY) == 0U) {
        if (++guard > 1000000UL) {
            return false;
        }
        if (I2C_getStatus(I2CB_BASE) & I2C_STS_NO_ACK) {
            I2C_clearStatus(I2CB_BASE, I2C_STS_NO_ACK);
            return false;
        }
    }
    return true;
}

//
// Writes a block to the EEPROM at a 16-bit word address.
//
static bool i2cWriteBlock(uint16_t devAddr, uint16_t memAddr,
                          const uint16_t *bytes, uint16_t count)
{
    uint16_t i;

    i2cMasterWaitBusFree();

    I2C_setTargetAddress(I2CB_BASE, devAddr);
    I2C_setConfig(I2CB_BASE, I2C_CONTROLLER_SEND_MODE);
    I2C_setDataCount(I2CB_BASE, count + 2U);

    I2C_putData(I2CB_BASE, (memAddr >> 8) & 0xFFU);
    I2C_putData(I2CB_BASE, memAddr & 0xFFU);
    I2C_sendStartCondition(I2CB_BASE);

    for (i = 0; i < count; i++) {
        uint32_t guard = 0;
        while ((I2C_getStatus(I2CB_BASE) & I2C_STS_TX_DATA_RDY) == 0U) {
            if (++guard > 1000000UL) {
                I2C_sendStopCondition(I2CB_BASE);
                return false;
            }
        }
        I2C_putData(I2CB_BASE, bytes[i] & 0xFFU);
    }

    I2C_sendStopCondition(I2CB_BASE);
    return i2cMasterWaitReady();
}

//
// Reads a block from the EEPROM using the usual write-address / restart-read
// sequence.
//
static bool i2cReadBlock(uint16_t devAddr, uint16_t memAddr,
                         uint16_t *bytes, uint16_t count)
{
    uint16_t i;

    i2cMasterWaitBusFree();

    // Phase 1: write the memory address, no stop (repeated start follows).
    I2C_setTargetAddress(I2CB_BASE, devAddr);
    I2C_setConfig(I2CB_BASE, I2C_CONTROLLER_SEND_MODE);
    I2C_setDataCount(I2CB_BASE, 2U);
    I2C_putData(I2CB_BASE, (memAddr >> 8) & 0xFFU);
    I2C_putData(I2CB_BASE, memAddr & 0xFFU);
    I2C_sendStartCondition(I2CB_BASE);

    if (!i2cMasterWaitReady()) {
        I2C_sendStopCondition(I2CB_BASE);
        return false;
    }

    // Phase 2: repeated start, read count bytes.
    I2C_setConfig(I2CB_BASE, I2C_CONTROLLER_RECEIVE_MODE);
    I2C_setDataCount(I2CB_BASE, count);
    I2C_sendStartCondition(I2CB_BASE);

    for (i = 0; i < count; i++) {
        uint32_t guard = 0;
        while ((I2C_getStatus(I2CB_BASE) & I2C_STS_RX_DATA_RDY) == 0U) {
            if (++guard > 1000000UL) {
                I2C_sendStopCondition(I2CB_BASE);
                return false;
            }
            if (I2C_getStatus(I2CB_BASE) & I2C_STS_NO_ACK) {
                I2C_clearStatus(I2CB_BASE, I2C_STS_NO_ACK);
                I2C_sendStopCondition(I2CB_BASE);
                return false;
            }
        }
        bytes[i] = I2C_getData(I2CB_BASE) & 0xFFU;
    }

    I2C_sendStopCondition(I2CB_BASE);
    return true;
}

//
// A C28x byte is 16 bits wide, so the EEPROM image is packed two bytes per
// word. These helpers convert between the packed on-wire form and the
// in-memory struct.
//
#define CAL_EEPROM_BYTES (2U * (uint16_t)sizeof(BTS_channelCalibration))

static void calibrationToBytes(const BTS_channelCalibration *cal, uint16_t *bytes)
{
    const uint16_t *words = (const uint16_t *)cal;
    uint16_t i;
    for (i = 0; i < (uint16_t)sizeof(BTS_channelCalibration); i++) {
        bytes[i * 2U]      = words[i] & 0xFFU;
        bytes[i * 2U + 1U] = (words[i] >> 8) & 0xFFU;
    }
}

static void bytesToCalibration(const uint16_t *bytes, BTS_channelCalibration *cal)
{
    uint16_t *words = (uint16_t *)cal;
    uint16_t i;
    for (i = 0; i < (uint16_t)sizeof(BTS_channelCalibration); i++) {
        words[i] = (bytes[i * 2U] & 0xFFU) | ((bytes[i * 2U + 1U] & 0xFFU) << 8);
    }
}

bool writeEEPROM(uint16_t channel, const BTS_channelCalibration* data)
{
    uint16_t bytes[CAL_EEPROM_BYTES];
    uint16_t eepromAddr = channel * CAL_EEPROM_BYTES;

    calibrationToBytes(data, bytes);
    return i2cWriteBlock(EEPROM_I2C_ADDR, eepromAddr, bytes, CAL_EEPROM_BYTES);
}

bool readEEPROM(uint16_t channel, BTS_channelCalibration* data)
{
    uint16_t bytes[CAL_EEPROM_BYTES];
    uint16_t eepromAddr = channel * CAL_EEPROM_BYTES;

    if (!i2cReadBlock(EEPROM_I2C_ADDR, eepromAddr, bytes, CAL_EEPROM_BYTES)) {
        return false;
    }
    bytesToCalibration(bytes, data);
    return true;
}

//
// A calibration block is valid when the header matches and the channel it
// carries is the one we asked for. The channel lives in the low half of the
// header word rather than being OR-ed into the magic value, which would
// alias for channels >= 4.
//
static bool validateCalibration(const BTS_channelCalibration* cal, uint16_t channel)
{
    if ((cal->header & BTS_CAL_HEADER_MASK) != BTS_CAL_HEADER) {
        return false;
    }
    if ((cal->header & BTS_CAL_CHANNEL_MASK) != (uint32_t)channel) {
        return false;
    }
    if (cal->MinCellTemp < -40.0f || cal->MaxCellTemp > 100.0f || cal->MinCellTemp >= cal->MaxCellTemp) {
        return false;
    }
    if (cal->F28V_Gain < 0.5f || cal->F28V_Gain > 2.0f || cal->F28V_Offset < -1.0f || cal->F28V_Offset > 1.0f) {
        return false;
    }
    if (cal->F28I_Gain < 0.5f || cal->F28I_Gain > 2.0f || cal->F28I_Offset < -2.0f || cal->F28I_Offset > 2.0f) {
        return false;
    }
    return true;
}

static bool validateGlobalVoltages(void)
{
    float chargeDisableV = registers[BTS_REG_IDX(eChargeDisableV)];
    float chargeRestrictV = registers[BTS_REG_IDX(eChargeRestrictV)];
    float dischargeRestrictV = registers[BTS_REG_IDX(eDischargeRestrictV)];
    float dischargeDisableV = registers[BTS_REG_IDX(eDischargeDisableV)];

    return (chargeDisableV >= MIN_VOLTAGE &&
            chargeDisableV <= chargeRestrictV &&
            chargeRestrictV <= dischargeRestrictV &&
            dischargeRestrictV <= dischargeDisableV &&
            dischargeDisableV <= MAX_VOLTAGE);
}

//
//=============================================================================
// CPU2 -> CPU1 notification
//=============================================================================
//
// registers[] lives in CPU2TOCPU1RAM and is written here before the flag is
// raised, so CPU1 sees a settled value. These are non-blocking: if the
// previous flag has not been acknowledged yet the notification is skipped,
// because CPU1 re-reads the affected block from registers[] anyway.
//
static void notifyCpu1RegisterWrite(uint16_t regIdx, float32_t value)
{
    if (IPC_isFlagBusyLtoR(IPC_CPU2_L_CPU1_R, BTS_IPC_FLAG_REG_WRITE)) {
        return;
    }
    ipcMsg.regAddr = regIdx;
    ipcMsg.value = value;
    IPC_setFlagLtoR(IPC_CPU2_L_CPU1_R, BTS_IPC_FLAG_REG_WRITE);
}

//
// Signals that every channel's calibration has been rewritten. CPU1 responds
// by reloading all channels and recalculating its program variables.
//
static void notifyCpu1CalibrationReload(void)
{
    IPC_setFlagLtoR(IPC_CPU2_L_CPU1_R, BTS_IPC_FLAG_CAL_RELOAD);
}

//
// Installs the compiled-in defaults for one channel.
//
static void applyDefaultCalibration(uint16_t ch)
{
    uint16_t tempBase = BTS_TEMP_BASE(ch);
    uint16_t calBase  = BTS_CAL_BASE(ch);

    registers[tempBase + BTS_TEMP_MIN] = DEFAULT_MIN_CELL_TEMP;
    registers[tempBase + BTS_TEMP_MAX] = DEFAULT_MAX_CELL_TEMP;

    registers[calBase + BTS_CAL_F28V_GAIN]      = DEFAULT_F28V_GAIN;
    registers[calBase + BTS_CAL_F28V_OFFSET]    = DEFAULT_F28V_OFFSET;
    registers[calBase + BTS_CAL_F28I_GAIN]      = DEFAULT_F28I_GAIN;
    registers[calBase + BTS_CAL_F28I_OFFSET]    = DEFAULT_F28I_OFFSET;
    registers[calBase + BTS_CAL_IOUT_GAIN_PU]   = defaultIoutGain_pu[ch];
    registers[calBase + BTS_CAL_IOUT_OFFSET_PU] = defaultIoutOffset_pu[ch];
    registers[calBase + BTS_CAL_IOUT_GAIN_A]    = defaultIoutGain_A[ch];
    registers[calBase + BTS_CAL_IOUT_OFFSET_A]  = defaultIoutOffset_A[ch];
    registers[calBase + BTS_CAL_VOUT_GAIN_PU]   = defaultVoutGain_pu[ch];
    registers[calBase + BTS_CAL_VOUT_OFFSET_PU] = defaultVoutOffset_pu[ch];
    registers[calBase + BTS_CAL_VOUT_GAIN_V]    = defaultVoutGain_V[ch];
    registers[calBase + BTS_CAL_VOUT_OFFSET_V]  = defaultVoutOffset_V[ch];
}

//
// Copies a validated EEPROM block into the register file.
//
static void applyStoredCalibration(uint16_t ch, const BTS_channelCalibration *cal)
{
    uint16_t tempBase = BTS_TEMP_BASE(ch);
    uint16_t calBase  = BTS_CAL_BASE(ch);

    registers[tempBase + BTS_TEMP_MIN] = cal->MinCellTemp;
    registers[tempBase + BTS_TEMP_MAX] = cal->MaxCellTemp;

    registers[calBase + BTS_CAL_F28V_GAIN]      = cal->F28V_Gain;
    registers[calBase + BTS_CAL_F28V_OFFSET]    = cal->F28V_Offset;
    registers[calBase + BTS_CAL_F28I_GAIN]      = cal->F28I_Gain;
    registers[calBase + BTS_CAL_F28I_OFFSET]    = cal->F28I_Offset;
    registers[calBase + BTS_CAL_IOUT_GAIN_PU]   = cal->IoutGain_pu;
    registers[calBase + BTS_CAL_IOUT_OFFSET_PU] = cal->IoutOffset_pu;
    registers[calBase + BTS_CAL_IOUT_GAIN_A]    = cal->IoutGain_A;
    registers[calBase + BTS_CAL_IOUT_OFFSET_A]  = cal->IoutOffset_A;
    registers[calBase + BTS_CAL_VOUT_GAIN_PU]   = cal->VoutGain_pu;
    registers[calBase + BTS_CAL_VOUT_OFFSET_PU] = cal->VoutOffset_pu;
    registers[calBase + BTS_CAL_VOUT_GAIN_V]    = cal->VoutGain_V;
    registers[calBase + BTS_CAL_VOUT_OFFSET_V]  = cal->VoutOffset_V;
}

//
// Boot-time calibration load.
//
// For each channel: read the EEPROM block, and if it validates, load it into
// the register file; otherwise install safe defaults. The global voltage
// thresholds get the same treatment. Once the whole register file is
// populated, CPU1 is notified once so it can recalculate every channel's
// program variables and start running - rather than being interrupted eight
// times mid-population with a partially-valid register file.
//
void loadCalibration(void)
{
    uint16_t ch;
    uint16_t voltageBytes[16];

    for (ch = 0; ch < NUM_CHANNELS; ch++) {
        BTS_channelCalibration cal;

        if (readEEPROM(ch, &cal) && validateCalibration(&cal, ch)) {
            calibrationData[ch] = cal;
            applyStoredCalibration(ch, &cal);
        } else {
            applyDefaultCalibration(ch);
        }
    }

    //
    // Global charge/discharge voltage thresholds.
    //
    if (i2cReadBlock(EEPROM_I2C_ADDR, EEPROM_GLOBAL_V_ADDR, voltageBytes, 16U)) {
        float32_t voltages[4];
        uint16_t *dst = (uint16_t *)voltages;
        uint16_t i;
        for (i = 0; i < 8U; i++) {
            dst[i] = (voltageBytes[i * 2U] & 0xFFU) |
                     ((voltageBytes[i * 2U + 1U] & 0xFFU) << 8);
        }

        registers[BTS_REG_IDX(eChargeDisableV)]     = voltages[0];
        registers[BTS_REG_IDX(eChargeRestrictV)]    = voltages[1];
        registers[BTS_REG_IDX(eDischargeRestrictV)] = voltages[2];
        registers[BTS_REG_IDX(eDischargeDisableV)]  = voltages[3];
    }

    if (!validateGlobalVoltages()) {
        registers[BTS_REG_IDX(eChargeDisableV)]     = DEFAULT_CHARGE_DISABLE_V;
        registers[BTS_REG_IDX(eChargeRestrictV)]    = DEFAULT_CHARGE_RESTRICT_V;
        registers[BTS_REG_IDX(eDischargeRestrictV)] = DEFAULT_DISCHARGE_RESTRICT_V;
        registers[BTS_REG_IDX(eDischargeDisableV)]  = DEFAULT_DISCHARGE_DISABLE_V;
    }

    //
    // The register file is now complete and consistent - tell CPU1 to
    // recalculate its program variables from it and go.
    //
    notifyCpu1CalibrationReload();
}

void saveCalibration(uint16_t channel)
{
    BTS_channelCalibration cal;
    uint16_t tempBase = BTS_TEMP_BASE(channel);
    uint16_t calBase  = BTS_CAL_BASE(channel);

    cal.header   = BTS_CAL_MAKE_HEADER(channel);
    cal.dateTime = CPUTimer_getTimerCount(CPUTIMER1_BASE);

    cal.MinCellTemp   = registers[tempBase + BTS_TEMP_MIN];
    cal.MaxCellTemp   = registers[tempBase + BTS_TEMP_MAX];
    cal.F28V_Gain     = registers[calBase + BTS_CAL_F28V_GAIN];
    cal.F28V_Offset   = registers[calBase + BTS_CAL_F28V_OFFSET];
    cal.F28I_Gain     = registers[calBase + BTS_CAL_F28I_GAIN];
    cal.F28I_Offset   = registers[calBase + BTS_CAL_F28I_OFFSET];
    cal.IoutGain_pu   = registers[calBase + BTS_CAL_IOUT_GAIN_PU];
    cal.IoutOffset_pu = registers[calBase + BTS_CAL_IOUT_OFFSET_PU];
    cal.IoutGain_A    = registers[calBase + BTS_CAL_IOUT_GAIN_A];
    cal.IoutOffset_A  = registers[calBase + BTS_CAL_IOUT_OFFSET_A];
    cal.VoutGain_pu   = registers[calBase + BTS_CAL_VOUT_GAIN_PU];
    cal.VoutOffset_pu = registers[calBase + BTS_CAL_VOUT_OFFSET_PU];
    cal.VoutGain_V    = registers[calBase + BTS_CAL_VOUT_GAIN_V];
    cal.VoutOffset_V  = registers[calBase + BTS_CAL_VOUT_OFFSET_V];

    if (validateCalibration(&cal, channel)) {
        if (writeEEPROM(channel, &cal)) {
            calibrationData[channel] = cal;
        }
    }

    //
    // Channel 0 also carries the unit-wide voltage thresholds.
    //
    if (channel == 0 && validateGlobalVoltages()) {
        float32_t voltages[4];
        uint16_t voltageBytes[16];
        const uint16_t *src = (const uint16_t *)voltages;
        uint16_t i;

        voltages[0] = registers[BTS_REG_IDX(eChargeDisableV)];
        voltages[1] = registers[BTS_REG_IDX(eChargeRestrictV)];
        voltages[2] = registers[BTS_REG_IDX(eDischargeRestrictV)];
        voltages[3] = registers[BTS_REG_IDX(eDischargeDisableV)];

        for (i = 0; i < 8U; i++) {
            voltageBytes[i * 2U]      = src[i] & 0xFFU;
            voltageBytes[i * 2U + 1U] = (src[i] >> 8) & 0xFFU;
        }
        i2cWriteBlock(EEPROM_I2C_ADDR, EEPROM_GLOBAL_V_ADDR, voltageBytes, 16U);
    }
}

//
// Commits every channel to EEPROM. Triggered by a host writing
// eCalibrationMode = 2.
//
static void saveAllCalibration(void)
{
    uint16_t ch;
    for (ch = 0; ch < NUM_CHANNELS; ch++) {
        saveCalibration(ch);
    }
}

void initCAN(void)
{
    GPIO_setPinConfig(GPIO_31_CANTXA);
    GPIO_setPinConfig(GPIO_30_CANRXA);
    GPIO_setQualificationMode(30, GPIO_QUAL_ASYNC);

    CAN_initModule(CANA_BASE);
    CAN_setBitRate(CANA_BASE, DEVICE_SYSCLK_FREQ, CAN_BITRATE, 16);
    CAN_enableInterrupt(CANA_BASE, CAN_INT_IE0 | CAN_INT_ERROR | CAN_INT_STATUS);
    Interrupt_register(INT_CANA0, &canISR);
    Interrupt_enable(INT_CANA0);

    for (uint16_t i = 0; i < NUM_CHANNELS; i++) {
        CAN_setupMessageObject(CANA_BASE, i + 1, CAN_MSG_ID_BASE | ((uint32_t)i << 20) | 0x01,
                               CAN_MSG_FRAME_EXT, CAN_MSG_OBJ_TYPE_TX, 0,
                               CAN_MSG_OBJ_NO_FLAGS, 8);
    }
    CAN_setupMessageObject(CANA_BASE, 9, CAN_MSG_ID_BASE | 0x02, CAN_MSG_FRAME_EXT,
                           CAN_MSG_OBJ_TYPE_RX, 0x1FFFFFFF,
                           CAN_MSG_OBJ_RX_INT_ENABLE, 8);

    CAN_startModule(CANA_BASE);
}

void sendCANData(uint16_t channel)
{
    uint16_t data[8];
    const uint16_t *v;
    const uint16_t *c;

    if (channel >= NUM_CHANNELS) return;

    v = (const uint16_t *)&canData[channel].voltage;
    c = (const uint16_t *)&canData[channel].current;

    data[0] = canData[channel].channel & 0xFFU;
    data[1] = 0;
    data[2] = v[0] & 0xFFU;
    data[3] = (v[0] >> 8) & 0xFFU;
    data[4] = v[1] & 0xFFU;
    data[5] = (v[1] >> 8) & 0xFFU;
    data[6] = c[0] & 0xFFU;
    data[7] = (c[0] >> 8) & 0xFFU;

    CAN_sendMessage(CANA_BASE, channel + 1, 8, data);
}

volatile uint16_t sfraEnabled = 0;

void initUART(void)
{
    GPIO_setPinConfig(GPIO_18_SCITXDB);
    GPIO_setPinConfig(GPIO_19_SCIRXDB);
    SCI_setConfig(SCIB_BASE, DEVICE_LSPCLK_FREQ, 1000000, (SCI_CONFIG_WLEN_8 | SCI_CONFIG_STOP_ONE | SCI_CONFIG_PAR_NONE));
    SCI_resetChannels(SCIB_BASE);
    SCI_enableFIFO(SCIB_BASE);
    SCI_enableModule(SCIB_BASE);
    SCI_performSoftwareReset(SCIB_BASE);
    SCI_enableInterrupt(SCIB_BASE, SCI_INT_RXRDY_BRKDT);
    Interrupt_register(INT_SCIB_RX, &uartRxISR);
    Interrupt_enable(INT_SCIB_RX);
}

void initTimer(void)
{
    CPUTimer_setPeriod(CPUTIMER1_BASE, DEVICE_SYSCLK_FREQ / 8);
    CPUTimer_setPreScaler(CPUTIMER1_BASE, 0);
    CPUTimer_enableInterrupt(CPUTIMER1_BASE);
    Interrupt_register(INT_TIMER1, &timerISR);
    Interrupt_enable(INT_TIMER1);
    CPUTimer_startTimer(CPUTIMER1_BASE);
}

void initADS1119(void)
{
    uint16_t configData[3];

    GPIO_setPinConfig(GPIO_42_GPIO42);
    GPIO_setDirectionMode(ADS1119_DRDY_GPIO_1, GPIO_DIR_MODE_IN);
    GPIO_setQualificationMode(ADS1119_DRDY_GPIO_1, GPIO_QUAL_SYNC);
    GPIO_setInterruptPin(ADS1119_DRDY_GPIO_1, GPIO_INT_XINT1);
    GPIO_setInterruptType(GPIO_INT_XINT1, GPIO_INT_TYPE_FALLING_EDGE);
    GPIO_enableInterrupt(GPIO_INT_XINT1);

    GPIO_setPinConfig(GPIO_43_GPIO43);
    GPIO_setDirectionMode(ADS1119_DRDY_GPIO_2, GPIO_DIR_MODE_IN);
    GPIO_setQualificationMode(ADS1119_DRDY_GPIO_2, GPIO_QUAL_SYNC);
    GPIO_setInterruptPin(ADS1119_DRDY_GPIO_2, GPIO_INT_XINT2);
    GPIO_setInterruptType(GPIO_INT_XINT2, GPIO_INT_TYPE_FALLING_EDGE);
    GPIO_enableInterrupt(GPIO_INT_XINT2);

    Interrupt_register(INT_XINT1, &ads1119Drdy1ISR);
    Interrupt_register(INT_XINT2, &ads1119Drdy2ISR);
    Interrupt_enable(INT_XINT1);
    Interrupt_enable(INT_XINT2);

    configData[0] = ADS1119_CONFIG_REG;
    configData[1] = (ADS1119_CONFIG_CONT >> 8) & 0xFFU;
    configData[2] = ADS1119_CONFIG_CONT & 0xFFU;

    i2cWriteBlock(ADS1119_ADDR_1, 0, configData, 3U);
    i2cWriteBlock(ADS1119_ADDR_2, 0, configData, 3U);
}

float mVToTemperature(float mV)
{
    if (mV <= mvToTempTable[0].mV) return mvToTempTable[0].tempC;
    if (mV >= mvToTempTable[MV_TO_TEMP_TABLE_SIZE-1].mV) return mvToTempTable[MV_TO_TEMP_TABLE_SIZE-1].tempC;

    for (uint16_t i = 0; i < MV_TO_TEMP_TABLE_SIZE-1; i++) {
        if (mV >= mvToTempTable[i].mV && mV < mvToTempTable[i+1].mV) {
            float mVRange = mvToTempTable[i+1].mV - mvToTempTable[i].mV;
            float tempRange = mvToTempTable[i+1].tempC - mvToTempTable[i].tempC;
            return mvToTempTable[i].tempC + (mV - mvToTempTable[i].mV) * tempRange / mVRange;
        }
    }
    return 0.0f;
}

float readADS1119Data(uint16_t adsAddr, uint16_t channel)
{
    uint16_t data[2];
    int16_t raw;
    float mV;

    (void)channel;

    if (!i2cReadBlock(adsAddr, ADS1119_DATA_REG, data, 2U)) {
        return 0.0f;
    }

    raw = (int16_t)(((data[0] & 0xFFU) << 8) | (data[1] & 0xFFU));
    mV = ((float)raw * 2048.0f) / 32768.0f;

    return mVToTemperature(mV);
}

void configureNextChannel(uint16_t adsAddr, uint16_t nextChannel)
{
    uint16_t channelConfig = ADS1119_CONFIG_CONT | (nextChannel << 12);
    uint16_t configData[3];

    configData[0] = ADS1119_CONFIG_REG;
    configData[1] = (channelConfig >> 8) & 0xFFU;
    configData[2] = channelConfig & 0xFFU;

    i2cWriteBlock(adsAddr, 0, configData, 3U);
}

#pragma CODE_SECTION(ads1119Drdy1ISR, "isrcodefuncs")
#pragma INTERRUPT(ads1119Drdy1ISR, HPI)
__interrupt void ads1119Drdy1ISR(void)
{
    uint16_t channel = currentAdsChannel[0];
    float temp = readADS1119Data(ADS1119_ADDR_1, channel);

    //
    // Measured temperature goes to the min-temp slot of the channel's
    // 2-register temperature block.
    //
    uint16_t regIdx = BTS_TEMP_BASE(channel) + BTS_TEMP_MIN;
    channelTemps[channel] = temp;
    registers[regIdx] = temp;
    notifyCpu1RegisterWrite(regIdx, temp);

    currentAdsChannel[0] = (currentAdsChannel[0] + 1) % 4;
    configureNextChannel(ADS1119_ADDR_1, currentAdsChannel[0]);

    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP1);
}

#pragma CODE_SECTION(ads1119Drdy2ISR, "isrcodefuncs")
#pragma INTERRUPT(ads1119Drdy2ISR, HPI)
__interrupt void ads1119Drdy2ISR(void)
{
    uint16_t channel = currentAdsChannel[1];
    float temp = readADS1119Data(ADS1119_ADDR_2, channel);

    uint16_t regIdx = BTS_TEMP_BASE(channel + 4) + BTS_TEMP_MIN;
    channelTemps[channel + 4] = temp;
    registers[regIdx] = temp;
    notifyCpu1RegisterWrite(regIdx, temp);

    currentAdsChannel[1] = (currentAdsChannel[1] + 1) % 4;
    configureNextChannel(ADS1119_ADDR_2, currentAdsChannel[1]);

    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP1);
}

//
// Mirrors the measurements and status CPU1 published in CPU1TOCPU2RAM into
// the register file, so the external interfaces see current data. The seq
// counter is even and unchanged across a consistent snapshot.
//
static void mirrorCpu1Status(void)
{
    uint32_t seqBefore;
    uint32_t statusBits[NUM_CHANNELS];
    float32_t cellV[NUM_CHANNELS];
    float32_t cellI[NUM_CHANNELS];
    float32_t inputV;
    uint32_t unitState;
    uint32_t tripStatus;
    uint16_t ch;
    uint16_t attempts = 0;

    do {
        seqBefore = cpu1Status.seq;
        if (seqBefore & 1U) {
            continue;   // CPU1 is mid-update
        }
        for (ch = 0; ch < NUM_CHANNELS; ch++) {
            statusBits[ch] = cpu1Status.statusBits[ch];
            cellV[ch] = cpu1Status.cellVoltage[ch];
            cellI[ch] = cpu1Status.cellCurrent[ch];
        }
        inputV     = cpu1Status.inputVoltage;
        unitState  = cpu1Status.unitState;
        tripStatus = cpu1Status.tripStatus;
    } while (cpu1Status.seq != seqBefore && ++attempts < 4U);

    if (attempts >= 4U) {
        return;   // could not get a clean snapshot; try again next tick
    }

    for (ch = 0; ch < NUM_CHANNELS; ch++) {
        registers[BTS_CTRL_BASE(ch) + BTS_REG_IDX(eCh0_Status)] = (float32_t)statusBits[ch];
        registers[BTS_STATS_BASE(ch) + (BTS_REG_IDX(eCh0_CellVoltage) - BTS_REG_IDX(eCh0_CurrentAcc))] = cellV[ch];
        registers[BTS_STATS_BASE(ch) + (BTS_REG_IDX(eCh0_CellCurrent) - BTS_REG_IDX(eCh0_CurrentAcc))] = cellI[ch];
    }

    registers[BTS_REG_IDX(eInputVoltage)] = inputV;
    registers[BTS_REG_IDX(eUnitState)]    = (float32_t)unitState;
    registers[BTS_REG_IDX(eTripStatus)]   = (float32_t)tripStatus;
}

static volatile uint16_t canTxChannel = 0;

#pragma CODE_SECTION(timerISR, "isrcodefuncs")
#pragma INTERRUPT(timerISR, HPI)
__interrupt void timerISR(void)
{
    mirrorCpu1Status();
    sendCANData(canTxChannel);
    canTxChannel = (canTxChannel + 1) % NUM_CHANNELS;
    CPUTimer_clearOverflowFlag(CPUTIMER1_BASE);
    //
    // CPU Timer 1 is connected directly to CPU INT13, not through the PIE,
    // so there is no acknowledge group to clear.
    //
}

volatile uint16_t currentRegAddr = 0;
volatile uint16_t byteCount = 0;
volatile float tempData = 0.0f;
volatile uint16_t isWrite = 0;
static uint16_t readBuffer[4] = {0};
static volatile uint16_t bufferValid = 0;

//
// Applies a host register write from any interface (I2C, UART or CAN).
// Writes the register file, notifies CPU1, and handles the eCalibrationMode
// commit trigger.
//
static void applyHostRegisterWrite(uint16_t regIdx, float32_t value)
{
    registers[regIdx] = value;
    notifyCpu1RegisterWrite(regIdx, value);

    if (regIdx == BTS_REG_IDX(eCalibrationMode) && value == 2.0f) {
        saveAllCalibration();
    }
}

//
// The register protocol carries each float MSB-first on the wire. A C28x
// "byte" is 16 bits, so a float is two 16-bit words rather than four bytes -
// indexing it as a byte array (as older revisions did) runs off the end of
// the object. These helpers pack and unpack explicitly:
//
//   wire byte 0 -> bits 31..24   word[1] high half
//   wire byte 1 -> bits 23..16   word[1] low half
//   wire byte 2 -> bits 15..8    word[0] high half
//   wire byte 3 -> bits  7..0    word[0] low half
//
static inline void floatPutWireByte(volatile float32_t *f, uint16_t index, uint16_t value)
{
    volatile uint16_t *w = (volatile uint16_t *)f;
    uint16_t word = 1U - (index >> 1);       // bytes 0,1 -> word 1; 2,3 -> word 0
    if ((index & 1U) == 0U) {
        w[word] = (w[word] & 0x00FFU) | ((value & 0xFFU) << 8);   // high half
    } else {
        w[word] = (w[word] & 0xFF00U) | (value & 0xFFU);          // low half
    }
}

static inline uint16_t floatGetWireByte(float32_t f, uint16_t index)
{
    const uint16_t *w = (const uint16_t *)&f;
    uint16_t word = 1U - (index >> 1);
    return ((index & 1U) == 0U) ? ((w[word] >> 8) & 0xFFU) : (w[word] & 0xFFU);
}

#pragma CODE_SECTION(i2cSlaveISR, "isrcodefuncs")
#pragma INTERRUPT(i2cSlaveISR, HPI)
__interrupt void i2cSlaveISR(void)
{
    uint32_t intSource = I2C_getInterruptStatus(I2CA_BASE);

    if (intSource & I2C_INT_ADDR_TARGET) {
        isWrite = (I2C_getStatus(I2CA_BASE) & I2C_STS_TARGET_DIR) ? 0 : 1;
        byteCount = 0;
        tempData = 0.0f;
        currentRegAddr = 0;
        bufferValid = 0;
    }

    if (intSource & I2C_INT_STOP_CONDITION) {
        byteCount = 0;
        bufferValid = 0;
    }

    if (intSource & I2C_INT_RX_DATA_RDY) {
        uint16_t rxData = I2C_getData(I2CA_BASE) & 0xFFU;
        if (byteCount == 0) {
            currentRegAddr = rxData << 8;
            byteCount++;
        } else if (byteCount == 1) {
            currentRegAddr |= rxData;
            bufferValid = 0;
            byteCount++;
        } else {
            floatPutWireByte(&tempData, byteCount - 2, rxData);
            byteCount++;
            if (byteCount == 6) {
                uint16_t regIdx = currentRegAddr / 4;
                if (regIdx < TOTAL_REGISTERS && regConfig[regIdx].access == REG_ACCESS_RW) {
                    applyHostRegisterWrite(regIdx, tempData);
                }
                tempData = 0.0f;
                // Auto-increment for multi-register writes.
                currentRegAddr += 4;
                byteCount = ((currentRegAddr / 4) < TOTAL_REGISTERS) ? 2 : 0;
            }
        }
    }

    if (intSource & I2C_INT_TX_DATA_RDY) {
        uint16_t regIdx = currentRegAddr / 4;
        if (byteCount == 0) {
            float32_t regValue = (regIdx < TOTAL_REGISTERS) ? registers[regIdx] : -1.0f;
            uint16_t i;
            for (i = 0; i < 4U; i++) {
                readBuffer[i] = floatGetWireByte(regValue, i);
            }
            bufferValid = 1;
            I2C_putData(I2CA_BASE, readBuffer[0]);
            byteCount++;
        } else if (bufferValid && byteCount < 4) {
            I2C_putData(I2CA_BASE, readBuffer[byteCount]);
            byteCount++;
            if (byteCount == 4) {
                byteCount = 0;
                currentRegAddr += 4;
            }
        } else {
            I2C_putData(I2CA_BASE, 0xFF);
            byteCount = 0;
            bufferValid = 0;
        }
    }

    I2C_clearInterruptStatus(I2CA_BASE, intSource);
    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP8);
}

#pragma CODE_SECTION(canISR, "isrcodefuncs")
#pragma INTERRUPT(canISR, HPI)
__interrupt void canISR(void)
{
    //
    // The INT0ID field of the CAN interrupt register holds the message
    // object number that raised the interrupt, or CAN_INT_INT0ID_STATUS for
    // an error/status event. Object 9 is the host register read/write mailbox.
    //
    uint32_t intCause = CAN_getInterruptCause(CANA_BASE) & 0xFFFFU;

    if (intCause == CAN_INT_INT0ID_STATUS) {
        // Reading the status register clears the condition.
        (void)CAN_getStatus(CANA_BASE);
    } else if (intCause == 9U) {
        uint16_t data[8];
        CAN_MsgFrameType frameType;
        uint32_t rxMsgId = 0;

        if (CAN_readMessageWithID(CANA_BASE, 9, &frameType, &rxMsgId, data)) {
            uint16_t regAddr = ((data[0] & 0xFFU) << 8) | (data[1] & 0xFFU);
            uint16_t regIdx = regAddr / 4;

            if (data[2] == 0x01 && regIdx < TOTAL_REGISTERS &&
                regConfig[regIdx].access == REG_ACCESS_RW) {
                float32_t value;
                uint16_t *w = (uint16_t *)&value;
                w[0] = (data[4] & 0xFFU) | ((data[5] & 0xFFU) << 8);
                w[1] = (data[6] & 0xFFU) | ((data[7] & 0xFFU) << 8);
                applyHostRegisterWrite(regIdx, value);
            } else if (data[2] == 0x00 && regIdx < TOTAL_REGISTERS) {
                float32_t value = registers[regIdx];
                const uint16_t *w = (const uint16_t *)&value;
                uint16_t reply[8];
                reply[0] = data[0];
                reply[1] = data[1];
                reply[2] = 0x00;
                reply[3] = 0x00;
                reply[4] = w[0] & 0xFFU;
                reply[5] = (w[0] >> 8) & 0xFFU;
                reply[6] = w[1] & 0xFFU;
                reply[7] = (w[1] >> 8) & 0xFFU;
                CAN_sendMessage(CANA_BASE, 9, 8, reply);
            }
        }
        CAN_clearInterruptStatus(CANA_BASE, 9);
    }

    CAN_clearGlobalInterruptStatus(CANA_BASE, CAN_GLOBAL_INT_CANINT0);
    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP9);
}

void SFRA_startCalibration(void)
{
    uartSendResponse("SFRA Calibration Started");
}

#define UART_BUFFER_SIZE 64
static char uartBuffer[UART_BUFFER_SIZE];
static uint16_t uartBufIdx = 0;

void uartSendResponse(const char* response)
{
    while (*response) {
        SCI_writeCharBlockingFIFO(SCIB_BASE, (uint16_t)(*response++) & 0xFFU);
    }
    SCI_writeCharBlockingFIFO(SCIB_BASE, '\r');
    SCI_writeCharBlockingFIFO(SCIB_BASE, '\n');
}

//
// Formats "+<name>=<value>" with two decimal places.
//
// printf's %f promotes its argument to double, which this project forbids
// (--float_operations_allowed=32), so the fraction is rendered from a scaled
// 32-bit integer instead.
//
static void formatRegisterValue(char *out, uint16_t outSize,
                                const char *name, float32_t value)
{
    int32_t scaled;
    int32_t whole;
    int32_t frac;
    bool negative = false;

    if (value < 0.0f) {
        negative = true;
        value = -value;
    }

    // Round to two decimal places.
    scaled = (int32_t)(value * 100.0f + 0.5f);
    whole  = scaled / 100;
    frac   = scaled % 100;

    snprintf(out, outSize, "+%s=%s%ld.%02ld",
             name, negative ? "-" : "", (long)whole, (long)frac);
}

#pragma CODE_SECTION(uartRxISR, "isrcodefuncs")
#pragma INTERRUPT(uartRxISR, HPI)
__interrupt void uartRxISR(void)
{
    uint32_t intSource = SCI_getInterruptStatus(SCIB_BASE);
    if (intSource & SCI_INT_RXRDY_BRKDT) {
        char rxChar = (char)(SCI_readCharBlockingFIFO(SCIB_BASE) & 0xFFU);
        if (rxChar == '\n' || rxChar == '\r') {
            uartBuffer[uartBufIdx] = '\0';
            if (strncmp(uartBuffer, "AT+", 3) == 0) {
                char* cmd = uartBuffer + 3;
                char* valueStr = strchr(cmd, '=');
                char* query = strchr(cmd, '?');
                uint16_t regIdx = TOTAL_REGISTERS;

                if (strncmp(cmd, "SFRA_CAL", 8) == 0 && sfraEnabled) {
                    if (!valueStr && !query) {
                        SFRA_startCalibration();
                        uartSendResponse("OK");
                    } else {
                        uartSendResponse("ERROR: Invalid SFRA command");
                    }
                    uartBufIdx = 0;
                    SCI_clearInterruptStatus(SCIB_BASE, intSource);
                    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP9);
                    return;
                }

                char regName[32];
                if (valueStr) *valueStr = '\0';
                if (query) *query = '\0';
                strncpy(regName, cmd, sizeof(regName) - 1);
                regName[sizeof(regName) - 1] = '\0';

                for (uint16_t i = 0; i < TOTAL_REGISTERS; i++) {
                    if (strcmp(regName, uartRegConfig[i].shortName) == 0 ||
                        strcmp(regName, uartRegConfig[i].longName) == 0) {
                        regIdx = i;
                        break;
                    }
                }

                if (regIdx == TOTAL_REGISTERS) {
                    uartSendResponse("ERROR: Invalid register");
                } else if (valueStr) {
                    if (uartRegConfig[regIdx].access == REG_ACCESS_RO) {
                        uartSendResponse("ERROR: Read-only register");
                    } else {
                        // strtof, not atof: the project builds with
                        // --float_operations_allowed=32, which rules out the
                        // double-returning atof.
                        float value = strtof(valueStr + 1, 0);
                        applyHostRegisterWrite(regIdx, value);
                        uartSendResponse("OK");
                    }
                } else if (query) {
                    char response[40];
                    formatRegisterValue(response, sizeof(response), regName, registers[regIdx]);
                    uartSendResponse(response);
                    uartSendResponse("OK");
                } else {
                    uartSendResponse("ERROR: Invalid command");
                }
            }
            uartBufIdx = 0;
        } else if (uartBufIdx < UART_BUFFER_SIZE - 1) {
            uartBuffer[uartBufIdx++] = rxChar;
        }
    }
    SCI_clearInterruptStatus(SCIB_BASE, intSource);
    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP9);
}

/*
 * CPU 2 Main Routine
 *
 * Boot order matters: the peripherals that reach the EEPROM come up first,
 * then loadCalibration() populates the register file from EEPROM (or from
 * defaults) and notifies CPU1 to recalculate and run. Interrupts are only
 * enabled once that initial register file is in place, so a host write can
 * never race the boot-time load.
 */
void main(void)
{
    Device_init();
    Device_initGPIO();
    Interrupt_initModule();
    Interrupt_initVectorTable();

    initI2C_Master();

    //
    // Establish the register file before anything can observe or modify it.
    //
    loadCalibration();

    initI2C_Slave();
    initUART();
    initCAN();
    initTimer();
    LEDDriver_init();
    initADS1119();

    EINT;
    ERTM;

    while (1) {
        IDLE;
    }
}

#endif
