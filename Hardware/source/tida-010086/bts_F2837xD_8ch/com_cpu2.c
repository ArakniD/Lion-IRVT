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
#include <string.h>
#include <stdlib.h>

// ADS1119 Configuration
#define ADS1119_ADDR_1 0x40  // First ADS1119 (channels 0-3)
#define ADS1119_ADDR_2 0x41  // Second ADS1119 (channels 4-7)
#define ADS1119_CONFIG_REG 0x01
#define ADS1119_DATA_REG 0x00
#define ADS1119_CONFIG_CONT 0x85C3  // Continuous, 16-bit, 2.048V ref, 90 SPS
#define ADS1119_DRDY_GPIO_1 42     // DRDY for ADS1119 #1
#define ADS1119_DRDY_GPIO_2 43     // DRDY for ADS1119 #2

// Validation constants
#define CAL_HEADER_VALID 0xA5CC
#define MIN_VOLTAGE 8.0f
#define MAX_VOLTAGE 16.8f

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
static volatile uint16_t currentChannel[2] = {0, 0}; // Track channel for each ADS1119

void initI2C_Slave(void)
{
    GPIO_setPinConfig(GPIO_32_I2CA_SDA);
    GPIO_setPinConfig(GPIO_33_I2CA_SCL);
    I2C_setSlaveAddress(I2CA_BASE, 0x50);
    I2C_setConfig(I2CA_BASE, I2C_SLAVE_MODE);
    I2C_enableModule(I2CA_BASE);
    I2C_enableInterrupt(I2CA_BASE, I2C_INT_RX_RDY | I2C_INT_TX_RDY | I2C_INT_ADDR_SLAVE);
    Interrupt_register(INT_I2CA, i2cSlaveISR);
    Interrupt_enable(INT_I2CA);
}

void initI2C_Master(void)
{
    GPIO_setPinConfig(GPIO_34_I2CB_SDA);
    GPIO_setPinConfig(GPIO_35_I2CB_SCL);
    I2C_setConfig(I2CB_BASE, I2C_MASTER_MODE);
    I2C_setSlaveAddress(I2CB_BASE, 0x50);
    I2C_setBitCount(I2CB_BASE, I2C_BITCOUNT_8);
    I2C_setDataCount(I2CB_BASE, sizeof(BTS_channelCalibration));
    I2C_enableFIFO(I2CB_BASE);
    I2C_setFIFOInterruptLevel(I2CB_BASE, I2C_FIFO_TX1, I2C_FIFO_RX1);
    I2C_enableInterrupt(I2CB_BASE, I2C_INT_STOP_CONDITION);
    Interrupt_register(INT_I2CB, i2cMasterISR);
    Interrupt_enable(INT_I2CB);
}

void writeEEPROM(uint16_t channel, BTS_channelCalibration* data)
{
    uint16_t eepromAddr = channel * sizeof(BTS_channelCalibration);
    uint8_t* bytes = (uint8_t*)data;
    I2C_setTargetAddress(I2CB_BASE, 0x50);
    I2C_setDataCount(I2CB_BASE, 2 + sizeof(BTS_channelCalibration));
    I2C_putData(I2CB_BASE, eepromAddr >> 8);
    I2C_putData(I2CB_BASE, eepromAddr & 0xFF);
    for (uint16_t i = 0; i < sizeof(BTS_channelCalibration); i++) {
        I2C_putData(I2CB_BASE, bytes[i]);
    }
    I2C_sendStartCondition(I2CB_BASE);
    while (I2C_getStatus(I2CB_BASE) & I2C_STS_BUSY);
}

void readEEPROM(uint16_t channel, BTS_channelCalibration* data)
{
    uint16_t eepromAddr = channel * sizeof(BTS_channelCalibration);
    I2C_setTargetAddress(I2CB_BASE, 0x50);
    I2C_setDataCount(I2CB_BASE, 2);
    I2C_putData(I2CB_BASE, eepromAddr >> 8);
    I2C_putData(I2CB_BASE, eepromAddr & 0xFF);
    I2C_sendStartCondition(I2CB_BASE);
    while (I2C_getStatus(I2CB_BASE) & I2C_STS_BUSY);
    I2C_setDataCount(I2CB_BASE, sizeof(BTS_channelCalibration));
    I2C_sendStartCondition(I2CB_BASE);
    for (uint16_t i = 0; i < sizeof(BTS_channelCalibration); i++) {
        ((uint8_t*)data)[i] = I2C_getData(I2CB_BASE);
    }
    I2C_sendStopCondition(I2CB_BASE);
}

static bool validateCalibration(BTS_channelCalibration* cal, uint16_t channel)
{
    if (cal->header != CAL_HEADER_VALID || (cal->header & 0xFF) != channel) {
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
    float chargeDisableV = registers[eChargeDisableV / 4];
    float chargeRestrictV = registers[eChargeRestrictV / 4];
    float dischargeRestrictV = registers[eDischargeRestrictV / 4];
    float dischargeDisableV = registers[eDischargeDisableV / 4];

    return (chargeDisableV >= MIN_VOLTAGE &&
            chargeDisableV <= chargeRestrictV &&
            chargeRestrictV <= dischargeRestrictV &&
            dischargeRestrictV <= dischargeDisableV &&
            dischargeDisableV <= MAX_VOLTAGE);
}

void loadCalibration(void)
{
    for (uint16_t ch = 0; ch < NUM_CHANNELS; ch++) {
        BTS_channelCalibration cal;
        readEEPROM(ch, &cal);
        if (validateCalibration(&cal, ch)) {
            calibrationData[ch] = cal;
            uint16_t base = (eCh0_MinCellTemp / 4) + ch * 10;
            registers[base + 0] = cal.MinCellTemp;
            registers[base + 1] = cal.MaxCellTemp;
            registers[base + 2] = cal.F28V_Gain;
            registers[base + 3] = cal.F28V_Offset;
            registers[base + 4] = cal.F28I_Gain;
            registers[base + 5] = cal.F28I_Offset;
            registers[base + 6] = cal.IoutGain_pu;
            registers[base + 7] = cal.IoutOffset_pu;
            registers[base + 8] = cal.IoutGain_A;
            registers[base + 9] = cal.IoutOffset_A;
            registers[base + 10] = cal.VoutGain_pu;
            registers[base + 11] = cal.VoutOffset_pu;
            registers[base + 12] = cal.VoutGain_V;
            registers[base + 13] = cal.VoutOffset_V;

            for (uint16_t i = 0; i < 10; i++) {
                ipcMsg.regAddr = base + i;
                ipcMsg.value = registers[base + i];
                IPC_setFlagLtoR(IPC_CPU2_L_CPU1_R, IPC_FLAG0);
                while (IPC_isFlagBusyLtoR(IPC_CPU2_L_CPU1_R, IPC_FLAG0));
            }
        } else {
            uint16_t base = (eCh0_MinCellTemp / 4) + ch * 10;
            registers[base + 0] = 10.0f;
            registers[base + 1] = 85.0f;
            registers[base + 2] = 1.0f;
#error "calculate a gain and offset for detaults here"
            registers[base + 3] = 0.0f;
            registers[base + 4] = 8.0f;
            registers[base + 5] = 0.0f;
            registers[base + 6] = BTS_IoutGain_ch1_pu;
            registers[base + 7] = BTS_IoutOffset_ch1_pu;
            registers[base + 8] = BTS_IoutGain_ch1_Af;
            registers[base + 9] = BTS_IoutOffset_ch1_Af;
            registers[base + 10] = BTS_VoutGain_ch1_puf;
            registers[base + 11] = BTS_VoutOffset_ch1_puf;
            registers[base + 12] = BTS_VoutGain_ch1_Vf;
            registers[base + 13] = BTS_VoutOffset_ch1_Vf;
        }
    }
    // Load global voltages
    uint8_t voltageData[16];
    I2C_setTargetAddress(I2CB_BASE, 0x50);
    I2C_setDataCount(I2CB_BASE, 2);
    I2C_putData(I2CB_BASE, 0x01);
    I2C_putData(I2CB_BASE, 0x00);
    I2C_sendStartCondition(I2CB_BASE);
    while (I2C_getStatus(I2CB_BASE) & I2C_STS_BUSY);
    I2C_setDataCount(I2CB_BASE, 16);
    I2C_sendStartCondition(I2CB_BASE);
    for (uint16_t i = 0; i < 16; i++) {
        voltageData[i] = I2C_getData(I2CB_BASE);
    }
    I2C_sendStopCondition(I2CB_BASE);

    float* voltages = (float*)voltageData;
    if (voltages[0] >= MIN_VOLTAGE && voltages[0] <= voltages[1] &&
        voltages[1] <= voltages[2] && voltages[2] <= voltages[3] &&
        voltages[3] <= MAX_VOLTAGE) {
        registers[eChargeDisableV / 4] = voltages[0];
        registers[eChargeRestrictV / 4] = voltages[1];
        registers[eDischargeRestrictV / 4] = voltages[2];
        registers[eDischargeDisableV / 4] = voltages[3];
    } else {
        registers[eChargeDisableV / 4] = 9.0f;
        registers[eChargeRestrictV / 4] = 10.0f;
        registers[eDischargeRestrictV / 4] = 15.0f;
        registers[eDischargeDisableV / 4] = 16.0f;
    }
}

void saveCalibration(uint16_t channel)
{
    BTS_channelCalibration cal;
    cal.header = CAL_HEADER_VALID | channel;
    cal.dateTime = DEVICE_GETTIMERCOUNT;

    uint16_t base = (eCh0_MinCellTemp / 4) + channel * 10;
    cal.MinCellTemp = registers[base + 0];
    cal.MaxCellTemp = registers[base + 1];
    cal.F28V_Gain = registers[base + 2];
    cal.F28V_Offset = registers[base + 3];
    cal.F28I_Gain = registers[base + 4];
    cal.F28I_Offset = registers[base + 5];
    cal.IoutGain_pu = registers[base + 6];
    cal.IoutOffset_pu = registers[base + 7];
    cal.IoutGain_A = registers[base + 8];
    cal.IoutOffset_A = registers[base + 9];
    cal.VoutGain_pu = registers[base + 10];
    cal.VoutOffset_pu = registers[base + 11];
    cal.VoutGain_V = registers[base + 12];
    cal.VoutOffset_V = registers[base + 13];

    if (validateCalibration(&cal, channel)) {
        writeEEPROM(channel, &cal);
    }

    if (channel == 0 && registers[eCalibrationMode / 4] == 2.0f) {
        uint8_t voltageData[16];
        float* voltages = (float*)voltageData;
        voltages[0] = registers[eChargeDisableV / 4];
        voltages[1] = registers[eChargeRestrictV / 4];
        voltages[2] = registers[eDischargeRestrictV / 4];
        voltages[3] = registers[eDischargeDisableV / 4];

        if (validateGlobalVoltages()) {
            I2C_setTargetAddress(I2CB_BASE, 0x50);
            I2C_setDataCount(I2CB_BASE, 18);
            I2C_putData(I2CB_BASE, 0x01);
            I2C_putData(I2CB_BASE, 0x00);
            for (uint16_t i = 0; i < 16; i++) {
                I2C_putData(I2CB_BASE, voltageData[i]);
            }
            I2C_sendStartCondition(I2CB_BASE);
            while (I2C_getStatus(I2CB_BASE) & I2C_STS_BUSY);
        }
    }
}

void initCAN(void)
{
    GPIO_setPinConfig(GPIO_30_CANA_TX);
    GPIO_setPinConfig(GPIO_31_CANA_RX);
    CAN_initModule(CANA_BASE);
    CAN_setBitRate(CANA_BASE, DEVICE_SYSCLK_FREQ, CAN_BITRATE, 16);
    CAN_enableInterrupt(CANA_BASE, CAN_INT_IE0 | CAN_INT_ERROR | CAN_INT_STATUS);
    CAN_enableMemoryAccess(CANA_BASE);
    Interrupt_register(INT_CANA0, canISR);
    Interrupt_enable(INT_CANA0);

    for (uint16_t i = 0; i < NUM_CHANNELS; i++) {
        CAN_setupMessageObject(CANA_BASE, i + 1, CAN_MSG_ID_BASE | (i << 20) | 0x01, CAN_MSG_FRAME_EXT, CAN_MSG_OBJ_TYPE_TX, 0, CAN_MSG_OBJ_NO_FLAGS, 8);
    }
    CAN_setupMessageObject(CANA_BASE, 9, CAN_MSG_ID_BASE | 0x02, CAN_MSG_FRAME_EXT, CAN_MSG_OBJ_TYPE_RX, 0x1FFFFFFF, CAN_MSG_OBJ_RX_INT_ENABLE, 8);

    CAN_startModule(CANA_BASE);
}

void sendCANData(uint16_t channel)
{
    if (channel >= NUM_CHANNELS) return;
    uint32_t msgId = CAN_MSG_ID_BASE | (channel << 20) | 0x01;
    uint8_t data[8];
    data[0] = canData[channel].channel;
    data[1] = 0;
    *(float*)&data[2] = canData[channel].voltage;
    *(float*)&data[6] = canData[channel].current;
    CAN_sendMessage(CANA_BASE, channel + 1, msgId, 8, data);
}

volatile uint8_t sfraEnabled = 0;

void initUART(void)
{
    GPIO_setPinConfig(GPIO_18_SCIB_TX);
    GPIO_setPinConfig(GPIO_19_SCIB_RX);
    SCI_setConfig(SCIB_BASE, DEVICE_LSPCLK_FREQ, 1000000, (SCI_CONFIG_WLEN_8 | SCI_CONFIG_STOP_ONE | SCI_CONFIG_PAR_NONE));
    SCI_enableModule(SCIB_BASE);
    SCI_enableInterrupt(SCIB_BASE, SCI_INT_RXRDY_BRKDT);
    Interrupt_register(INT_SCIB_RX, uartRxISR);
    Interrupt_enable(INT_SCIB_RX);
}

void initTimer(void)
{
    CPUTimer_setPeriod(CPUTIMER1_BASE, DEVICE_SYSCLK_FREQ / 8);
    CPUTimer_enableInterrupt(CPUTIMER1_BASE);
    Interrupt_register(INT_TIMER1, timerISR);
    Interrupt_enable(INT_TIMER1);
    CPUTimer_startTimer(CPUTIMER1_BASE);
}

void initADS1119(void)
{
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

    Interrupt_register(INT_XINT1, ads1119Drdy1ISR);
    Interrupt_register(INT_XINT2, ads1119Drdy2ISR);
    Interrupt_enable(INT_XINT1);
    Interrupt_enable(INT_XINT2);

    uint8_t configData[3] = {ADS1119_CONFIG_REG, ADS1119_CONFIG_CONT >> 8, ADS1119_CONFIG_CONT & 0xFF};

    I2C_setTargetAddress(I2CB_BASE, ADS1119_ADDR_1);
    I2C_setDataCount(I2CB_BASE, 3);
    for (uint16_t i = 0; i < 3; i++) {
        I2C_putData(I2CB_BASE, configData[i]);
    }
    I2C_sendStartCondition(I2CB_BASE);
    while (I2C_getStatus(I2CB_BASE) & I2C_STS_BUSY);

    I2C_setTargetAddress(I2CB_BASE, ADS1119_ADDR_2);
    I2C_setDataCount(I2CB_BASE, 3);
    for (uint16_t i = 0; i < 3; i++) {
        I2C_putData(I2CB_BASE, configData[i]);
    }
    I2C_sendStartCondition(I2CB_BASE);
    while (I2C_getStatus(I2CB_BASE) & I2C_STS_BUSY);
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
    uint8_t cmd = ADS1119_DATA_REG;
    I2C_setTargetAddress(I2CB_BASE, adsAddr);
    I2C_setDataCount(I2CB_BASE, 1);
    I2C_putData(I2CB_BASE, cmd);
    I2C_sendStartCondition(I2CB_BASE);
    while (I2C_getStatus(I2CB_BASE) & I2C_STS_BUSY);

    I2C_setDataCount(I2CB_BASE, 2);
    I2C_sendStartCondition(I2CB_BASE);
    uint8_t data[2];
    data[0] = I2C_getData(I2CB_BASE);
    data[1] = I2C_getData(I2CB_BASE);
    I2C_sendStopCondition(I2CB_BASE);

    int16_t raw = (data[0] << 8) | data[1];
    float mV = (raw * 2048.0f) / 32768.0f;

    return mVToTemperature(mV);
}

void configureNextChannel(uint16_t adsAddr, uint16_t nextChannel)
{
    uint16_t channelConfig = ADS1119_CONFIG_CONT | (nextChannel << 12);
    uint8_t configData[3] = {ADS1119_CONFIG_REG, channelConfig >> 8, channelConfig & 0xFF};

    I2C_setTargetAddress(I2CB_BASE, adsAddr);
    I2C_setDataCount(I2CB_BASE, 3);
    for (uint16_t i = 0; i < 3; i++) {
        I2C_putData(I2CB_BASE, configData[i]);
    }
    I2C_sendStartCondition(I2CB_BASE);
    while (I2C_getStatus(I2CB_BASE) & I2C_STS_BUSY);
}

#pragma CODE_SECTION(ads1119Drdy1ISR, "isrcodefuncs")
#pragma INTERRUPT(ads1119Drdy1ISR, HPI)
__interrupt void ads1119Drdy1ISR(void)
{
    uint16_t channel = currentChannel[0];
    float temp = readADS1119Data(ADS1119_ADDR_1, channel);

    uint16_t regIdx = (eCh0_MinCellTemp + channel * 4) / 4;
    channelTemps[channel] = temp;
    registers[regIdx] = temp;
    ipcMsg.regAddr = regIdx;
    ipcMsg.value = temp;
    IPC_setFlagLtoR(IPC_CPU2_L_CPU1_R, IPC_FLAG1);

    currentChannel[0] = (currentChannel[0] + 1) % 4;
    configureNextChannel(ADS1119_ADDR_1, currentChannel[0]);

    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP1);
}

#pragma CODE_SECTION(ads1119Drdy2ISR, "isrcodefuncs")
#pragma INTERRUPT(ads1119Drdy2ISR, HPI)
__interrupt void ads1119Drdy2ISR(void)
{
    uint16_t channel = currentChannel[1];
    float temp = readADS1119Data(ADS1119_ADDR_2, channel);

    uint16_t regIdx = (eCh0_MinCellTemp + (channel + 4) * 4) / 4;
    channelTemps[channel + 4] = temp;
    registers[regIdx] = temp;
    ipcMsg.regAddr = regIdx;
    ipcMsg.value = temp;
    IPC_setFlagLtoR(IPC_CPU2_L_CPU1_R, IPC_FLAG1);

    currentChannel[1] = (currentChannel[1] + 1) % 4;
    configureNextChannel(ADS1119_ADDR_2, currentChannel[1]);

    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP1);
}

static uint16_t currentChannel = 0;

#pragma CODE_SECTION(timerISR, "isrcodefuncs")
#pragma INTERRUPT(timerISR, HPI)
__interrupt void timerISR(void)
{
    sendCANData(currentChannel);
    currentChannel = (currentChannel + 1) % NUM_CHANNELS;
    CPUTimer_clearOverflowFlag(CPUTIMER1_BASE);
}

volatile uint16_t currentRegAddr = 0;
volatile uint8_t byteCount = 0;
volatile float tempData = 0.0f;
volatile uint8_t isWrite = 0;
static uint8_t readBuffer[4] = {0};
static volatile uint8_t bufferValid = 0;

#pragma CODE_SECTION(i2cSlaveISR, "isrcodefuncs")
#pragma INTERRUPT(i2cSlaveISR, HPI)
__interrupt void i2cSlaveISR(void)
{
    uint32_t intSource = I2C_getInterruptStatus(I2CA_BASE);

    if (intSource & I2C_INT_ADDR_SLAVE) {
        isWrite = I2C_getStatus(I2CA_BASE) & I2C_STS_DIR ? 0 : 1;
        byteCount = 0;
        tempData = 0.0f;
        currentRegAddr = 0;
        bufferValid = 0;
    }

    if (intSource & I2C_INT_RX_RDY) {
        uint16_t rxData = I2C_getData(I2CA_BASE);
        if (byteCount == 0) {
            currentRegAddr = rxData << 8;
            byteCount++;
        } else if (byteCount == 1) {
            currentRegAddr |= rxData;
            bufferValid = 0;
            byteCount++;
        } else {
            ((uint8_t*)&tempData)[3 - (byteCount - 2)] = rxData;
            byteCount++;
            if (byteCount == 6) {
                uint16_t regIdx = currentRegAddr / 4;
                if (regIdx < TOTAL_REGISTERS && regConfig[regIdx].access == REG_ACCESS_RW) {
                    registers[regIdx] = tempData;
                    ipcMsg.regAddr = regIdx;
                    ipcMsg.value = tempData;
                    IPC_setFlagLtoR(IPC_CPU2_L_CPU1_R, IPC_FLAG0);
                    if (regIdx == eCalibrationMode / 4 && tempData == 2.0f) {
                        for (uint16_t ch = 0; ch < NUM_CHANNELS; ch++) {
                            saveCalibration(ch);
                        }
                    }
                }
                tempData = 0.0f;
                currentRegAddr += 4;
                if (currentRegAddr / 4 < TOTAL_REGISTERS) {
                    byteCount = 2;
                } else {
                    byteCount = 0;
                }
            }
        }
    }

    if (intSource & I2C_INT_TX_RDY) {
        uint16_t regIdx = currentRegAddr / 4;
        if (byteCount == 0) {
            float regValue = (regIdx < TOTAL_REGISTERS) ? registers[regIdx] : -1.0f;
            *(float*)readBuffer = regValue;
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
}

#pragma CODE_SECTION(i2cMasterISR, "isrcodefuncs")
#pragma INTERRUPT(i2cMasterISR, HPI)
__interrupt void i2cMasterISR(void)
{
    uint32_t intSource = I2C_getInterruptStatus(I2CB_BASE);
    if (intSource & I2C_INT_STOP_CONDITION) {
        I2C_clearInterruptStatus(I2CB_BASE, I2C_INT_STOP_CONDITION);
    }
}

#pragma CODE_SECTION(canISR, "isrcodefuncs")
#pragma INTERRUPT(canISR, HPI)
__interrupt void canISR(void)
{
    uint32_t intStatus = CAN_getInterruptCause(CANA_BASE);
    if (intStatus == CAN_INT_INT0ID) {
        uint32_t rxMsgId = CAN_getRxBufferMsgID(CANA_BASE, 9);
        uint8_t data[8];
        CAN_readMessage(CANA_BASE, 9, data);
        uint16_t regAddr = data[0] << 8 | data[1];
        uint16_t regIdx = regAddr / 4;
        if (data[2] == 0x01 && regIdx < TOTAL_REGISTERS && regConfig[regIdx].access == REG_ACCESS_RW) {
            float value = *(float*)&data[4];
            registers[regIdx] = value;
            ipcMsg.regAddr = regIdx;
            ipcMsg.value = value;
            IPC_setFlagLtoR(IPC_CPU2_L_CPU1_R, IPC_FLAG0);
        } else if (data[2] == 0x00 && regIdx < TOTAL_REGISTERS) {
            float value = registers[regIdx];
            CAN_sendMessage(CANA_BASE, 9, rxMsgId, 8, (uint8_t*)&value);
        }
        CAN_clearInterruptStatus(CANA_BASE, CAN_INT_INT0ID);
    }
    EINT;
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
        SCI_writeCharBlockingFIFO(SCIB_BASE, *response++);
    }
    SCI_writeCharBlockingFIFO(SCIB_BASE, '\r');
    SCI_writeCharBlockingFIFO(SCIB_BASE, '\n');
}

#pragma CODE_SECTION(uartRxISR, "isrcodefuncs")
#pragma INTERRUPT(uartRxISR, HPI)
__interrupt void uartRxISR(void)
{
    uint32_t intSource = SCI_getInterruptStatus(SCIB_BASE);
    if (intSource & SCI_INT_RXRDY_BRKDT) {
        char rxChar = SCI_readCharBlockingFIFO(SCIB_BASE);
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
                        float value = atof(valueStr + 1);
                        registers[regIdx] = value;
                        ipcMsg.regAddr = regIdx;
                        ipcMsg.value = value;
                        IPC_setFlagLtoR(IPC_CPU2_L_CPU1_R, IPC_FLAG0);
                        if (regIdx == eCalibrationMode / 4 && value == 2.0f) {
                            for (uint16_t ch = 0; ch < NUM_CHANNELS; ch++) {
                                saveCalibration(ch);
                            }
                        }
                        uartSendResponse("OK");
                    }
                } else if (query) {
                    char response[32];
                    snprintf(response, sizeof(response), "+%s=%.2f", regName, registers[regIdx]);
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
}

/*
 * CPU 2 Main Routine
 */
void main(void)
{
    Device_init();
    Interrupt_initModule();
    Interrupt_initVectorTable();

    initI2C_Slave();
    initI2C_Master();
    initUART();
    initCAN();
    initTimer();
    initSwitch();
    LEDDriver_init();
    initADS1119();
    loadCalibration();

    while (1) {
        __WFI();
    }
}

#endif
