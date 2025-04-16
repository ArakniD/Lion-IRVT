/*
 * cpu2.c
 *
 *  Created on: 15 Apr. 2025
 *      Author: lucas
 */


#ifdef CPU2


void initI2C_Slave(void) {
    GPIO_setPinConfig(GPIO_32_I2CA_SDA);
    GPIO_setPinConfig(GPIO_33_I2CA_SCL);
    I2C_setSlaveAddress(I2CA_BASE, 0x50);
    I2C_setConfig(I2CA_BASE, I2C_SLAVE_MODE);
    I2C_enableModule(I2CA_BASE);
    I2C_enableInterrupt(I2CA_BASE, I2C_INT_RX_RDY | I2C_INT_TX_RDY | I2C_INT_ADDR_SLAVE);
    Interrupt_register(INT_I2CA, i2cSlaveISR);
    Interrupt_enable(INT_I2CA);
}

void initI2C_Master(void) {
    GPIO_setPinConfig(GPIO_34_I2CB_SDA);
    GPIO_setPinConfig(GPIO_35_I2CB_SCL);
    I2C_setConfig(I2CB_BASE, I2C_MASTER_MODE);
    I2C_setSlaveAddress(I2CB_BASE, 0x50);
    I2C_setBitCount(I2CB_BASE, I2C_BITCOUNT_8);
    I2C_setDataCount(I2CB_BASE, sizeof(BTS_channelCalibration));
    I2C_setFIFOInterruptLevel(I2CB_BASE, I2C_FIFO_TX1, I2C_FIFO_RX1);
    I2C_enableModule(I2CB_BASE);
    I2C_enableInterrupt(I2CB_BASE, I2C_INT_STOP_CONDITION);
    Interrupt_register(INT_I2CB, i2cMasterISR);
    Interrupt_enable(INT_I2CB);
}

void writeEEPROM(uint16_t channel, BTS_channelCalibration* data) {
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

void readEEPROM(uint16_t channel, BTS_channelCalibration* data) {
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

void loadCalibration(void) {
    for (uint16_t ch = 0; ch < NUM_CHANNELS; ch++) {
        BTS_channelCalibration cal;
        readEEPROM(ch, &cal);
        if ((cal.header >> 8) == 0xA5 && (cal.header & 0xFF) == ch) {
            calibrationData[ch] = cal;
            registers[eCh0_IoutGain_pu / 4 + ch * 8] = cal.IoutGain_pu;
            registers[eCh0_IoutOffset_pu / 4 + ch * 8] = cal.IoutOffset_pu;
            registers[eCh0_IoutGain_A / 4 + ch * 8] = cal.IoutGain_A;
            registers[eCh0_IoutOffset_A / 4 + ch * 8] = cal.IoutOffset_A;
            registers[eCh0_VoutGain_pu / 4 + ch * 8] = cal.VoutGain_pu;
            registers[eCh0_VoutOffset_pu / 4 + ch * 8] = cal.VoutOffset_pu;
            registers[eCh0_VoutGain_V / 4 + ch * 8] = cal.VoutGain_V;
            registers[eCh0_VoutOffset_V / 4 + ch * 8] = cal.VoutOffset_V;
            ipcMsg.regAddr = eCh0_IoutGain_pu / 4 + ch * 8;
            ipcMsg.value = cal.IoutGain_pu;
            IPC_setFlagLtoR(IPC_CPU1_L_CPU2_R, IPC_FLAG0);
            // Repeat for other fields...
        }
    }
}

void saveCalibration(uint16_t channel) {
    BTS_channelCalibration cal;
    cal.header = (0xA5 << 8) | channel;
    cal.dateTime = DEVICE_GETTIMERCOUNT;
    cal.IoutGain_pu = registers[eCh0_IoutGain_pu / 4 + channel * 8];
    cal.IoutOffset_pu = registers[eCh0_IoutOffset_pu / 4 + channel * 8];
    cal.IoutGain_A = registers[eCh0_IoutGain_A / 4 + channel * 8];
    cal.IoutOffset_A = registers[eCh0_IoutOffset_A / 4 + channel * 8];
    cal.VoutGain_pu = registers[eCh0_VoutGain_pu / 4 + channel * 8];
    cal.VoutOffset_pu = registers[eCh0_VoutOffset_pu / 4 + channel * 8];
    cal.VoutGain_V = registers[eCh0_VoutGain_V / 4 + channel * 8];
    cal.VoutOffset_V = registers[eCh0_VoutOffset_V / 4 + channel * 8];
    writeEEPROM(channel, &cal);
}

void initCAN(void) {
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

void sendCANData(uint16_t channel) {
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

void initUART(void) {
    // Use SCIB for USB-emulated UART (GPIO_18/19 or controlCARD default)
    GPIO_setPinConfig(GPIO_18_SCIB_TX);
    GPIO_setPinConfig(GPIO_19_SCIB_RX);
    SCI_setConfig(SCIB_BASE, DEVICE_LSPCLK_FREQ, 1000000, (SCI_CONFIG_WLEN_8 | SCI_CONFIG_STOP_ONE | SCI_CONFIG_PAR_NONE));
    SCI_enableModule(SCIB_BASE);
    SCI_enableInterrupt(SCIB_BASE, SCI_INT_RXRDY_BRKDT);
    Interrupt_register(INT_SCIB_RX, uartRxISR);
    Interrupt_enable(INT_SCIB_RX);
}

void initTimer(void) {
    CPUTimer_setPeriod(CPUTIMER1_BASE, DEVICE_SYSCLK_FREQ / 8);
    CPUTimer_enableInterrupt(CPUTIMER1_BASE);
    Interrupt_register(INT_TIMER1, timerISR);
    Interrupt_enable(INT_TIMER1);
    CPUTimer_startTimer(CPUTIMER1_BASE);
}

static uint16_t currentChannel = 0;

__interrupt void timerISR(void) {
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

#pragma CODE_SECTION(i2cSlaveISR,"isrcodefuncs");
#pragma INTERRUPT(i2cSlaveISR, HPI)
__interrupt void i2cSlaveISR(void) {
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
                // Allow continuation of writing without sending another address
                // check if we havn't exceeded the register list address
                if (currentRegAddr / 4 < TOTAL_REGISTERS) {
                    byteCount = 2;
                } else {
                    byteCount = 0; // restart the writing process
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

#pragma CODE_SECTION(i2cMasterISR,"isrcodefuncs");
#pragma INTERRUPT(i2cMasterISR, HPI)
__interrupt void i2cMasterISR(void) {
    uint32_t intSource = I2C_getInterruptStatus(I2CB_BASE);
    if (intSource & I2C_INT_STOP_CONDITION) {
        I2C_clearInterruptStatus(I2CB_BASE, I2C_INT_STOP_CONDITION);
    }
}

#pragma CODE_SECTION(canISR,"isrcodefuncs");
#pragma INTERRUPT(canISR, HPI)
__interrupt void canISR(void) {
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

// Placeholder SFRA function (awaiting source)
void SFRA_startCalibration(void) {
    // Example: SFRA1_inject(100.0f, 1000.0f, 10.0f);
    uartSendResponse("SFRA Calibration Started");
}

#define UART_BUFFER_SIZE 64
static char uartBuffer[UART_BUFFER_SIZE];
static uint16_t uartBufIdx = 0;

void uartSendResponse(const char* response) {
    while (*response) {
        SCI_writeCharBlockingFIFO(SCIB_BASE, *response++);
    }
    SCI_writeCharBlockingFIFO(SCIB_BASE, '\r');
    SCI_writeCharBlockingFIFO(SCIB_BASE, '\n');
}

#pragma CODE_SECTION(uartRxISR,"isrcodefuncs");
#pragma INTERRUPT(uartRxISR, HPI)
__interrupt void uartRxISR(void) {
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
    loadCalibration();

    while (1) {
       __WFI();
    }

}



#endif
