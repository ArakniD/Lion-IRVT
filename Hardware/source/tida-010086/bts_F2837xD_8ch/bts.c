//#############################################################################
//
// FILE:  buck.c
//
// TITLE: Solution functions and resources
//        High level components that apply universally across hardware variants
//
//#############################################################################
// $TI Release: TIDM_DC_DC_BUCK v2.00.00.00 $
// $Release Date: Wed May 27 12:53:14 CDT 2020 $
// $Copyright:
// Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
//
// ALL RIGHTS RESERVED
// $
//#############################################################################

//
//=============================================================================
// includes
//=============================================================================
//
#include <bts.h>

//
//=============================================================================
// Global variables
//=============================================================================
//
BTS_measValue BTS_measValues[PWM_CH_MAX];

BTS_userInput BTS_userInputs[PWM_CH_MAX];

BTS_DCL_CTRL_TYPE   BTS_ctrl_cc[PWM_CH_MAX]
    = { BTS_DCL_CTRL_DEFAULTS,BTS_DCL_CTRL_DEFAULTS,
        BTS_DCL_CTRL_DEFAULTS,BTS_DCL_CTRL_DEFAULTS,
        BTS_DCL_CTRL_DEFAULTS,BTS_DCL_CTRL_DEFAULTS,
        BTS_DCL_CTRL_DEFAULTS,BTS_DCL_CTRL_DEFAULTS};

BTS_DCL_CTRL_TYPE   BTS_ctrl_cv[PWM_CH_MAX]
    = {BTS_DCL_CTRL_DEFAULTS, BTS_DCL_CTRL_DEFAULTS,
       BTS_DCL_CTRL_DEFAULTS, BTS_DCL_CTRL_DEFAULTS,
       BTS_DCL_CTRL_DEFAULTS, BTS_DCL_CTRL_DEFAULTS,
       BTS_DCL_CTRL_DEFAULTS, BTS_DCL_CTRL_DEFAULTS};

//
//=====================================
// Variables used by the program to run the BUCK solution.
//
// This subset of variables can be used interactively to monitor and
// control the execution of the BUCK solution.
//
// See bts.h for a description of the variables.
//



//
//=====================================
// Variables used by the program to run the BUCK solution.
//
// See bts.h for a description of the variables.
//


uint32_t             MEP_ScaleFactor;
uint16_t             BUCK_sfoStatus;
uint16_t             BTS_sfoStatus;




//
//=====================================
// Variables that are useful for debug of the BUCK solution.
//
// See bts.h for a description of the variables.
//



//
//=====================================
// DCL control variables
//
volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_ch1    = BTS_DCL_CTRL_DEFAULTS;
volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_ch2    = BTS_DCL_CTRL_DEFAULTS;
volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_ch3    = BTS_DCL_CTRL_DEFAULTS;
volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_ch4    = BTS_DCL_CTRL_DEFAULTS;
volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_ch5    = BTS_DCL_CTRL_DEFAULTS;
volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_ch6    = BTS_DCL_CTRL_DEFAULTS;
volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_ch7    = BTS_DCL_CTRL_DEFAULTS;
volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_ch8    = BTS_DCL_CTRL_DEFAULTS;


//
//=====================================
// DCL control variables
//
BTS_ctrlLoopVariable BTS_ctrlLoopVariables[PWM_CH_MAX];

//
//=====================================
// I2C EEPROM and external control access vars
//
#define I2CA_ADDRESS   0x30
#define I2CB_ADDRESS   0x40

#define EEPROM_SLAVE_ADDRESS        0x50

struct  I2CHandle EEPROM;
struct I2CHandle I2CA;
struct I2CHandle I2CB;

//
// Function Prototypes
//
__interrupt void i2cAISR(void);
__interrupt void i2cAFIFOISR(void);

__interrupt void i2cBISR(void);
__interrupt void i2cBFIFOISR(void);

void BTS_readCalibration(void);

struct I2CHandle *i2c_int_crnt_responderPtr;                   // Used in interrupt

uint16_t AvailableI2C_slaves[MAX_I2C_IN_NETWORK];

uint16_t I2CA_TXdata[MAX_BUFFER_SIZE];
uint16_t I2CB_TXdata[MAX_BUFFER_SIZE];

uint16_t I2CA_RXdata[MAX_BUFFER_SIZE];
uint16_t I2CB_RXdata[MAX_BUFFER_SIZE];

uint32_t I2CA_ControlAddr;
uint32_t I2CB_ControlAddr;

//
//=====================================
// SFRA variables
//


#if(BTS_SFRA_ENABLED == true)
SFRA_F32             BTS_sfra;
BTS_SfraDataType    BTS_sfraData;
#endif

//
//=============================================================================
// solution functions
//=============================================================================
//

void BTS_initUserVariables(void)
{
    BTS_userInput_ch1.direction_logic=1;
    BTS_userInput_ch1.enable_logic=0;
    BTS_userInput_ch1.dutyRef_pu=0.0;
    BTS_userInput_ch1.iref_A=1.0;
    BTS_userInput_ch1.vref_charge_V=3.7;
    BTS_userInput_ch1.vref_discharge_V=0.5;
    BTS_userInput_ch1.pendingUpdate = 0;

    BTS_userInput_ch1.IoutGain_pu = BTS_IoutGain_ch1_pu;
    BTS_userInput_ch1.IoutOffset_pu = BTS_IoutOffset_ch1_pu;
    BTS_userInput_ch1.IoutGain_A = BTS_IoutGain_ch1_A;
    BTS_userInput_ch1.IoutOffset_A = BTS_IoutOffset_ch1_A;

    BTS_userInput_ch1.VoutGain_pu = BTS_VoutGain_ch1_pu;
    BTS_userInput_ch1.VoutOffset_pu = BTS_VoutOffset_ch1_pu;
    BTS_userInput_ch1.VoutGain_V = BTS_VoutGain_ch1_V;
    BTS_userInput_ch1.VoutOffset_V = BTS_VoutOffset_ch1_V;

    BTS_userInput_ch2.direction_logic=1;
    BTS_userInput_ch2.enable_logic=0;
    BTS_userInput_ch2.dutyRef_pu=0.0;
    BTS_userInput_ch2.iref_A=1.0;
    BTS_userInput_ch2.vref_charge_V=3.7;
    BTS_userInput_ch2.vref_discharge_V=0.5;
    BTS_userInput_ch2.pendingUpdate = 0;

    BTS_userInput_ch2.IoutGain_pu = BTS_IoutGain_ch2_pu;
    BTS_userInput_ch2.IoutOffset_pu = BTS_IoutOffset_ch2_pu;
    BTS_userInput_ch2.IoutGain_A = BTS_IoutGain_ch2_A;
    BTS_userInput_ch2.IoutOffset_A = BTS_IoutOffset_ch2_A;

    BTS_userInput_ch2.VoutGain_pu = BTS_VoutGain_ch2_pu;
    BTS_userInput_ch2.VoutOffset_pu = BTS_VoutOffset_ch2_pu;
    BTS_userInput_ch2.VoutGain_V = BTS_VoutGain_ch2_V;
    BTS_userInput_ch2.VoutOffset_V = BTS_VoutOffset_ch2_V;

    BTS_userInput_ch3.direction_logic=1;
    BTS_userInput_ch3.enable_logic=0;
    BTS_userInput_ch3.dutyRef_pu=0.0;
    BTS_userInput_ch3.iref_A=1.0;
    BTS_userInput_ch3.vref_charge_V=3.7;
    BTS_userInput_ch3.vref_discharge_V=0.5;
    BTS_userInput_ch3.pendingUpdate = 0;

    BTS_userInput_ch3.IoutGain_pu = BTS_IoutGain_ch3_pu;
    BTS_userInput_ch3.IoutOffset_pu = BTS_IoutOffset_ch3_pu;
    BTS_userInput_ch3.IoutGain_A = BTS_IoutGain_ch3_A;
    BTS_userInput_ch3.IoutOffset_A = BTS_IoutOffset_ch3_A;

    BTS_userInput_ch3.VoutGain_pu = BTS_VoutGain_ch3_pu;
    BTS_userInput_ch3.VoutOffset_pu = BTS_VoutOffset_ch3_pu;
    BTS_userInput_ch3.VoutGain_V = BTS_VoutGain_ch3_V;
    BTS_userInput_ch3.VoutOffset_V = BTS_VoutOffset_ch3_V;

    BTS_userInput_ch4.direction_logic=1;
    BTS_userInput_ch4.enable_logic=0;
    BTS_userInput_ch4.dutyRef_pu=0.0;
    BTS_userInput_ch4.iref_A=1.0;
    BTS_userInput_ch4.vref_charge_V=3.7;
    BTS_userInput_ch4.vref_discharge_V=0.5;
    BTS_userInput_ch4.pendingUpdate = 0;

    BTS_userInput_ch4.IoutGain_pu = BTS_IoutGain_ch4_pu;
    BTS_userInput_ch4.IoutOffset_pu = BTS_IoutOffset_ch4_pu;
    BTS_userInput_ch4.IoutGain_A = BTS_IoutGain_ch4_A;
    BTS_userInput_ch4.IoutOffset_A = BTS_IoutOffset_ch4_A;

    BTS_userInput_ch4.VoutGain_pu = BTS_VoutGain_ch4_pu;
    BTS_userInput_ch4.VoutOffset_pu = BTS_VoutOffset_ch4_pu;
    BTS_userInput_ch4.VoutGain_V = BTS_VoutGain_ch4_V;
    BTS_userInput_ch4.VoutOffset_V = BTS_VoutOffset_ch4_V;

    BTS_userInput_ch5.direction_logic=1;
    BTS_userInput_ch5.enable_logic=0;
    BTS_userInput_ch5.dutyRef_pu=0.0;
    BTS_userInput_ch5.iref_A=1.0;
    BTS_userInput_ch5.vref_charge_V=3.7;
    BTS_userInput_ch5.vref_discharge_V=0.5;
    BTS_userInput_ch5.pendingUpdate = 0;

    BTS_userInput_ch5.IoutGain_pu = BTS_IoutGain_ch5_pu;
    BTS_userInput_ch5.IoutOffset_pu = BTS_IoutOffset_ch5_pu;
    BTS_userInput_ch5.IoutGain_A = BTS_IoutGain_ch5_A;
    BTS_userInput_ch5.IoutOffset_A = BTS_IoutOffset_ch5_A;

    BTS_userInput_ch5.VoutGain_pu = BTS_VoutGain_ch5_pu;
    BTS_userInput_ch5.VoutOffset_pu = BTS_VoutOffset_ch5_pu;
    BTS_userInput_ch5.VoutGain_V = BTS_VoutGain_ch5_V;
    BTS_userInput_ch5.VoutOffset_V = BTS_VoutOffset_ch5_V;

    BTS_userInput_ch6.direction_logic=1;
    BTS_userInput_ch6.enable_logic=0;
    BTS_userInput_ch6.dutyRef_pu=0.0;
    BTS_userInput_ch6.iref_A=1.0;
    BTS_userInput_ch6.vref_charge_V=3.7;
    BTS_userInput_ch6.vref_discharge_V=0.5;
    BTS_userInput_ch6.pendingUpdate = 0;

    BTS_userInput_ch6.IoutGain_pu = BTS_IoutGain_ch6_pu;
    BTS_userInput_ch6.IoutOffset_pu = BTS_IoutOffset_ch6_pu;
    BTS_userInput_ch6.IoutGain_A = BTS_IoutGain_ch6_A;
    BTS_userInput_ch6.IoutOffset_A = BTS_IoutOffset_ch6_A;

    BTS_userInput_ch6.VoutGain_pu = BTS_VoutGain_ch6_pu;
    BTS_userInput_ch6.VoutOffset_pu = BTS_VoutOffset_ch6_pu;
    BTS_userInput_ch6.VoutGain_V = BTS_VoutGain_ch6_V;
    BTS_userInput_ch6.VoutOffset_V = BTS_VoutOffset_ch6_V;

    BTS_userInput_ch7.direction_logic=1;
    BTS_userInput_ch7.enable_logic=0;
    BTS_userInput_ch7.dutyRef_pu=0.0;
    BTS_userInput_ch7.iref_A=1.0;
    BTS_userInput_ch7.vref_charge_V=3.7;
    BTS_userInput_ch7.vref_discharge_V=0.5;
    BTS_userInput_ch7.pendingUpdate = 0;

    BTS_userInput_ch7.IoutGain_pu = BTS_IoutGain_ch7_pu;
    BTS_userInput_ch7.IoutOffset_pu = BTS_IoutOffset_ch7_pu;
    BTS_userInput_ch7.IoutGain_A = BTS_IoutGain_ch7_A;
    BTS_userInput_ch7.IoutOffset_A = BTS_IoutOffset_ch7_A;

    BTS_userInput_ch7.VoutGain_pu = BTS_VoutGain_ch7_pu;
    BTS_userInput_ch7.VoutOffset_pu = BTS_VoutOffset_ch7_pu;
    BTS_userInput_ch7.VoutGain_V = BTS_VoutGain_ch7_V;
    BTS_userInput_ch7.VoutOffset_V = BTS_VoutOffset_ch7_V;

    BTS_userInput_ch8.direction_logic=1;
    BTS_userInput_ch8.enable_logic=0;
    BTS_userInput_ch8.dutyRef_pu=0.0;
    BTS_userInput_ch8.iref_A=1.0;
    BTS_userInput_ch8.vref_charge_V=3.7;
    BTS_userInput_ch8.vref_discharge_V=0.5;
    BTS_userInput_ch8.pendingUpdate = 0;

    BTS_userInput_ch8.IoutGain_pu = BTS_IoutGain_ch8_pu;
    BTS_userInput_ch8.IoutOffset_pu = BTS_IoutOffset_ch8_pu;
    BTS_userInput_ch8.IoutGain_A = BTS_IoutGain_ch8_A;
    BTS_userInput_ch8.IoutOffset_A = BTS_IoutOffset_ch8_A;

    BTS_userInput_ch8.VoutGain_pu = BTS_VoutGain_ch8_pu;
    BTS_userInput_ch8.VoutOffset_pu = BTS_VoutOffset_ch8_pu;
    BTS_userInput_ch8.VoutGain_V = BTS_VoutGain_ch8_V;
    BTS_userInput_ch8.VoutOffset_V = BTS_VoutOffset_ch8_V;

}

void BTS_calcUserProgramVariables(uint16_t i)
{
    BTS_ctrlLoopVariables[i].ioutTrip_16b   = BTS_USER_TRIP_16b(i);
    BTS_ctrlLoopVariables[i].ioutTrip_n_16b = BTS_USER_TRIP_N_16b(i);

    BTS_measValues[i].IoutGain_A    = BTS_userInputs[i].IoutGain_A;
    BTS_measValues[i].IoutOffset_A  = BTS_userInputs[i].IoutOffset_A;
    BTS_measValues[i].VoutGain_V    = BTS_userInputs[i].VoutGain_V;
    BTS_measValues[i].VoutOffset_V  = BTS_userInputs[i].VoutOffset_V;
}

// Initialise the program variables from the user input
// call this routine to transfer user-input into running programme
void BTS_initProgramVariables(void)
{
    uint16_t i;

    for (i=0;i<8;i++)
    {
        BTS_calcUserProgramVariables(i);
    }
}



/* This function checks if we can write calibration */
void BTS_writeCalibration(uint16_t channel)
{
    uint16_t status;
    uint16_t i;
    BTS_channelCalibration data;

    // Ensure the I2C Device had been found before
    for (i=0,status=0;i<MAX_I2C_IN_NETWORK && status==0;i++){
        if (AvailableI2C_slaves[i] == EEPROM_SLAVE_ADDRESS)
        {
            status = 1;
        }
    }

    if (status) {
        EEPROM.currentHandlePtr     = &EEPROM;
        EEPROM.SlaveAddr            = EEPROM_SLAVE_ADDRESS;
        EEPROM.WriteCycleTime_in_us = 10000;    //6ms for EEPROM this code was tested
        EEPROM.base                 = BTS_I2C_INT_BASE;
        EEPROM.pControlAddr         = &BTS_I2C_INT_CNTADDR;
        EEPROM.NumOfAddrBytes       = 2;

        BTS_I2C_INT_CNTADDR   = i * 64;
        EEPROM.pControlAddr   = &BTS_I2C_INT_CNTADDR;
        EEPROM.pRX_MsgBuffer  = BTS_I2C_INT_RXDATA;
        EEPROM.NumOfDataBytes = sizeof(BTS_channelCalibration);

        data.header  = (uint32_t)0x000000A5 << 24;
        data.header |= ((uint32_t)channel + 1UL) << 16;

        // Copy from USER INPUT data
        data.IoutGain_pu    = BTS_userInputs[i].IoutGain_pu    ;
        data.IoutOffset_pu  = BTS_userInputs[i].IoutOffset_pu  ;
        data.IoutGain_A     = BTS_userInputs[i].IoutGain_A     ;
        data.IoutOffset_A   = BTS_userInputs[i].IoutOffset_A   ;
        data.VoutGain_pu    = BTS_userInputs[i].VoutGain_pu    ;
        data.VoutOffset_pu  = BTS_userInputs[i].VoutOffset_pu  ;
        data.VoutGain_V     = BTS_userInputs[i].VoutGain_V     ;
        data.VoutOffset_V   = BTS_userInputs[i].VoutOffset_V   ;

        // Write data out to the EEPROM
        status = I2C_MasterTransmit(&EEPROM);

        while(I2C_getStatus(EEPROM.base) & I2C_STS_BUS_BUSY);
    }
}

void BTS_readCalibration(void)
{
    BTS_channelCalibration  * framData;
    uint16_t i;
    uint16_t hdr;
    uint16_t channel;
    uint16_t checksum;
    uint16_t status;

    status = I2CBusScan(BTS_I2C_INT_BASE, AvailableI2C_slaves);

    /* Check if the EEPROM has been found, otherwise dont load the settings */
    if (status) {
        //status = 0;
        for (i=0,status=0;i<MAX_I2C_IN_NETWORK && status==0;i++){
            if (AvailableI2C_slaves[i] == EEPROM_SLAVE_ADDRESS)
            {
                status = 1;
            }
        }
    }

    // If there is an EEPROM, then we attempt to read the data
    if (status) {
        EEPROM.currentHandlePtr     = &EEPROM;
        EEPROM.SlaveAddr            = EEPROM_SLAVE_ADDRESS;
        EEPROM.WriteCycleTime_in_us = 10000;    //6ms for EEPROM this code was tested
        EEPROM.base                 = BTS_I2C_INT_BASE;
        EEPROM.pControlAddr         = &BTS_I2C_INT_CNTADDR;
        EEPROM.NumOfAddrBytes       = 2;

        // Read channel calibration data out
        // use 64 byte offsets per channel to account for data data
        for (i=0;i<8;i++) {

            BTS_I2C_INT_CNTADDR   = i * 64;
            EEPROM.pControlAddr   = &BTS_I2C_INT_CNTADDR;
            EEPROM.pRX_MsgBuffer  = BTS_I2C_INT_RXDATA;
            EEPROM.NumOfDataBytes = sizeof(BTS_channelCalibration);

            status = I2C_MasterReceiver(&EEPROM);

            while(I2C_getStatus(EEPROM.base) & I2C_STS_BUS_BUSY);

            // checksum validation
            framData = (BTS_channelCalibration *) &BTS_I2C_INT_RXDATA;
            hdr         = (framData->header >> 24) & 0xFF;
            channel     = (framData->header >> 16) & 0xFF;
            checksum    = (framData->header ) & 0xFFFF;

            // perform an in-place data upgrades
            if (hdr == 0xA5 && channel == (i+1)) {
                // Copy over the USER INPUT data
                BTS_userInputs[i].IoutGain_pu    = framData->IoutGain_pu;
                BTS_userInputs[i].IoutOffset_pu  = framData->IoutOffset_pu;
                BTS_userInputs[i].IoutGain_A     = framData->IoutGain_A;
                BTS_userInputs[i].IoutOffset_A   = framData->IoutOffset_A;

                BTS_userInputs[i].VoutGain_pu    = framData->VoutGain_pu;
                BTS_userInputs[i].VoutOffset_pu  = framData->VoutOffset_pu;
                BTS_userInputs[i].VoutGain_V     = framData->VoutGain_V;
                BTS_userInputs[i].VoutOffset_V   = framData->VoutOffset_V;

                // Copy into user input and controller if valid
                BTS_calcUserProgramVariables(i);
            }
        }
    }
}


void BTS_initController(void)
{
    /*
     * Channel1
     */
    BTS_ctrl_cc_ch1.b0 = BTS_DCL_CC_B0;
    BTS_ctrl_cc_ch1.b1 = BTS_DCL_CC_B1;
    BTS_ctrl_cc_ch1.b2 = BTS_DCL_CC_B2;
    BTS_ctrl_cc_ch1.a1 = BTS_DCL_CC_A1;
    BTS_ctrl_cc_ch1.a2 = BTS_DCL_CC_A2;

    BTS_ctrl_cv_ch1.b0 = BTS_DCL_CV_B0;
    BTS_ctrl_cv_ch1.b1 = BTS_DCL_CV_B1;
    BTS_ctrl_cv_ch1.b2 = BTS_DCL_CV_B2;
    BTS_ctrl_cv_ch1.a1 = BTS_DCL_CV_A1;
    BTS_ctrl_cv_ch1.a2 = BTS_DCL_CV_A2;

    /*
     * Channel2
     */
    BTS_ctrl_cc_ch2.b0 = BTS_DCL_CC_B0;
    BTS_ctrl_cc_ch2.b1 = BTS_DCL_CC_B1;
    BTS_ctrl_cc_ch2.b2 = BTS_DCL_CC_B2;
    BTS_ctrl_cc_ch2.a1 = BTS_DCL_CC_A1;
    BTS_ctrl_cc_ch2.a2 = BTS_DCL_CC_A2;

    BTS_ctrl_cv_ch2.b0 = BTS_DCL_CV_B0;
    BTS_ctrl_cv_ch2.b1 = BTS_DCL_CV_B1;
    BTS_ctrl_cv_ch2.b2 = BTS_DCL_CV_B2;
    BTS_ctrl_cv_ch2.a1 = BTS_DCL_CV_A1;
    BTS_ctrl_cv_ch2.a2 = BTS_DCL_CV_A2;

    /*
     * Channel3
     */

    BTS_ctrl_cc_ch3.b0 = BTS_DCL_CC_B0;
    BTS_ctrl_cc_ch3.b1 = BTS_DCL_CC_B1;
    BTS_ctrl_cc_ch3.b2 = BTS_DCL_CC_B2;
    BTS_ctrl_cc_ch3.a1 = BTS_DCL_CC_A1;
    BTS_ctrl_cc_ch3.a2 = BTS_DCL_CC_A2;

    BTS_ctrl_cv_ch3.b0 = BTS_DCL_CV_B0;
    BTS_ctrl_cv_ch3.b1 = BTS_DCL_CV_B1;
    BTS_ctrl_cv_ch3.b2 = BTS_DCL_CV_B2;
    BTS_ctrl_cv_ch3.a1 = BTS_DCL_CV_A1;
    BTS_ctrl_cv_ch3.a2 = BTS_DCL_CV_A2;

    /*
     * Channel4
     */

    BTS_ctrl_cc_ch4.b0 = BTS_DCL_CC_B0;
    BTS_ctrl_cc_ch4.b1 = BTS_DCL_CC_B1;
    BTS_ctrl_cc_ch4.b2 = BTS_DCL_CC_B2;
    BTS_ctrl_cc_ch4.a1 = BTS_DCL_CC_A1;
    BTS_ctrl_cc_ch4.a2 = BTS_DCL_CC_A2;

    BTS_ctrl_cv_ch4.b0 = BTS_DCL_CV_B0;
    BTS_ctrl_cv_ch4.b1 = BTS_DCL_CV_B1;
    BTS_ctrl_cv_ch4.b2 = BTS_DCL_CV_B2;
    BTS_ctrl_cv_ch4.a1 = BTS_DCL_CV_A1;
    BTS_ctrl_cv_ch4.a2 = BTS_DCL_CV_A2;

    /*
     * Channel5
     */
    BTS_ctrl_cc_ch5.b0 = BTS_DCL_CC_B0;
    BTS_ctrl_cc_ch5.b1 = BTS_DCL_CC_B1;
    BTS_ctrl_cc_ch5.b2 = BTS_DCL_CC_B2;
    BTS_ctrl_cc_ch5.a1 = BTS_DCL_CC_A1;
    BTS_ctrl_cc_ch5.a2 = BTS_DCL_CC_A2;

    BTS_ctrl_cv_ch5.b0 = BTS_DCL_CV_B0;
    BTS_ctrl_cv_ch5.b1 = BTS_DCL_CV_B1;
    BTS_ctrl_cv_ch5.b2 = BTS_DCL_CV_B2;
    BTS_ctrl_cv_ch5.a1 = BTS_DCL_CV_A1;
    BTS_ctrl_cv_ch5.a2 = BTS_DCL_CV_A2;

    /*
     * Channel6
     */
    BTS_ctrl_cc_ch6.b0 = BTS_DCL_CC_B0;
    BTS_ctrl_cc_ch6.b1 = BTS_DCL_CC_B1;
    BTS_ctrl_cc_ch6.b2 = BTS_DCL_CC_B2;
    BTS_ctrl_cc_ch6.a1 = BTS_DCL_CC_A1;
    BTS_ctrl_cc_ch6.a2 = BTS_DCL_CC_A2;

    BTS_ctrl_cv_ch6.b0 = BTS_DCL_CV_B0;
    BTS_ctrl_cv_ch6.b1 = BTS_DCL_CV_B1;
    BTS_ctrl_cv_ch6.b2 = BTS_DCL_CV_B2;
    BTS_ctrl_cv_ch6.a1 = BTS_DCL_CV_A1;
    BTS_ctrl_cv_ch6.a2 = BTS_DCL_CV_A2;

    /*
     * Channel7
     */

    BTS_ctrl_cc_ch7.b0 = BTS_DCL_CC_B0;
    BTS_ctrl_cc_ch7.b1 = BTS_DCL_CC_B1;
    BTS_ctrl_cc_ch7.b2 = BTS_DCL_CC_B2;
    BTS_ctrl_cc_ch7.a1 = BTS_DCL_CC_A1;
    BTS_ctrl_cc_ch7.a2 = BTS_DCL_CC_A2;

    BTS_ctrl_cv_ch7.b0 = BTS_DCL_CV_B0;
    BTS_ctrl_cv_ch7.b1 = BTS_DCL_CV_B1;
    BTS_ctrl_cv_ch7.b2 = BTS_DCL_CV_B2;
    BTS_ctrl_cv_ch7.a1 = BTS_DCL_CV_A1;
    BTS_ctrl_cv_ch7.a2 = BTS_DCL_CV_A2;

    /*
     * Channel8
     */

    BTS_ctrl_cc_ch8.b0 = BTS_DCL_CC_B0;
    BTS_ctrl_cc_ch8.b1 = BTS_DCL_CC_B1;
    BTS_ctrl_cc_ch8.b2 = BTS_DCL_CC_B2;
    BTS_ctrl_cc_ch8.a1 = BTS_DCL_CC_A1;
    BTS_ctrl_cc_ch8.a2 = BTS_DCL_CC_A2;

    BTS_ctrl_cv_ch8.b0 = BTS_DCL_CV_B0;
    BTS_ctrl_cv_ch8.b1 = BTS_DCL_CV_B1;
    BTS_ctrl_cv_ch8.b2 = BTS_DCL_CV_B2;
    BTS_ctrl_cv_ch8.a1 = BTS_DCL_CV_A1;
    BTS_ctrl_cv_ch8.a2 = BTS_DCL_CV_A2;

}


void BTS_setupHrpwmMepScaleFactor(void)
{
    #if(BTS_EPWM_HR_ENABLED == true)

//         Calibrate MEP_ScaleFactor

        do {
            BTS_sfoStatus = SFO();
        } while(BTS_sfoStatus == SFO_INCOMPLETE);
    #endif
}



void BTS_setupSfra(void)
{
    #if(BTS_SFRA_ENABLED == true)
        SFRA_F32_reset(&BTS_sfra);
        SFRA_F32_config(&BTS_sfra,
                        BTS_SFRA_ISR_FREQ,
                        BTS_SFRA_AMPLITUDE,
                        BTS_SFRA_FREQ_LENGTH,
                        BTS_SFRA_FREQ_START,
                        BTS_SFRA_FREQ_STEP_MULTIPLY,
                        BTS_sfraData.plantMagVect,
                        BTS_sfraData.plantPhaseVect,
                        BTS_sfraData.olMagVect,
                        BTS_sfraData.olPhaseVect,
                        NULL,
                        NULL,
                        BTS_sfraData.freqVect,
                        BTS_SFRA_SWEEP_SPEED);
        SFRA_F32_resetFreqRespArray(&BTS_sfra);
        SFRA_F32_initFreqArrayWithLogSteps(&BTS_sfra,
                                           BTS_SFRA_FREQ_START,
                                           BTS_SFRA_FREQ_STEP_MULTIPLY);
    #endif
}

void BTS_setupSfraGui(void)
{
    #if(BTS_SFRA_ENABLED == true)
        SFRA_GUI_config(BTS_SFRA_GUI_SCI_BASE,
                        BTS_HAL_getLowSpeedClock(),
                        BTS_SFRA_GUI_SCI_BAUDRATE,
                        BTS_SFRA_GUI_SCIRX_GPIO,
                        BTS_SFRA_GUI_SCIRX_PIN_CONFIG,
                        BTS_SFRA_GUI_SCITX_GPIO,
                        BTS_SFRA_GUI_SCITX_PIN_CONFIG,
                        BTS_SFRA_GUI_LED_ENABLE,
                        BTS_SFRA_GUI_LED_GPIO,
                        BTS_SFRA_GUI_LED_PIN_CONFIG,
                        &BTS_sfra,
                        BTS_SFRA_GUI_PLOT_OPTION);
    #endif
}

//
// Defines
//



//
// I2CB ISR
//
#pragma CODE_SECTION(i2cBISR,"isrcodefuncs");
#pragma INTERRUPT(i2cBISR, HPI)
__interrupt void i2cBISR(void)
{
   uint16_t MasterSlave = I2C_getStatus(I2CB.base) & I2C_STS_ADDR_SLAVE;

   handleI2C_ErrorCondition(&I2CB);

   Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP8);
}

//
// I2CB FIFO ISR
// Internal I2C - FRAM and EEPROM access
//
#pragma CODE_SECTION(i2cBFIFOISR,"isrcodefuncs");
#pragma INTERRUPT(i2cBFIFOISR, HPI)
__interrupt void i2cBFIFOISR(void)
{
    Write_Read_TX_RX_FIFO(&I2CB);

    uint16_t MasterSlave = HWREGH(I2CB.base + I2C_O_MDR);

    //I2CB working in master configuration
    if(MasterSlave & I2C_MDR_TRX)
    {
       //I2CB working as Master Transmitter
       I2C_disableInterrupt(I2CB.base, (I2C_INT_TXFF));
    }

   Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP8);
}

//
// I2CA ISR
// External I2c bus - Access control registers from outside program
// Write ONLY for now..
// Read items coming
//
#pragma CODE_SECTION(i2cAISR,"isrcodefuncs");
#pragma INTERRUPT(i2cAISR, HPI)
__interrupt void i2cAISR(void)
{
    uint16_t MasterSlave = I2C_getStatus(I2CA.base) & I2C_STS_ADDR_SLAVE;
    uint16_t channel;

    /* External register access via STOP condition */
    switch(handleI2C_ErrorCondition(&I2CA))
    {
        case I2C_INTSRC_STOP_CONDITION:
        {
            uint16_t channel = (I2CA.pControlAddr >> 8 ) & 0x0FUL;

            /* Process stop condition here */
            switch ((I2CA.pControlAddr) & 0x00FFFFFF)
            {
            case BTS_I2C_ADR_CAL_CH1:
            case BTS_I2C_ADR_CAL_CH2:
            case BTS_I2C_ADR_CAL_CH3:
            case BTS_I2C_ADR_CAL_CH4:
            case BTS_I2C_ADR_CAL_CH5:
            case BTS_I2C_ADR_CAL_CH6:
            case BTS_I2C_ADR_CAL_CH7:
            case BTS_I2C_ADR_CAL_CH8:
                if (I2CA.NumOfDataBytes == 34)
                {
                    BTS_userInputs[channel].IoutGain_pu     = (uint32_t)BTS_I2C_EXT_RXDATA[0] | (uint32_t)BTS_I2C_EXT_RXDATA[1] << 8 | (uint32_t)BTS_I2C_EXT_RXDATA[2] << 16 | (uint32_t)BTS_I2C_EXT_RXDATA[3] << 24;
                    BTS_userInputs[channel].IoutOffset_pu   = (uint32_t)BTS_I2C_EXT_RXDATA[4] | (uint32_t)BTS_I2C_EXT_RXDATA[5] << 8 | (uint32_t)BTS_I2C_EXT_RXDATA[6] << 16 | (uint32_t)BTS_I2C_EXT_RXDATA[7] << 24;
                    BTS_userInputs[channel].IoutGain_A      = (uint32_t)BTS_I2C_EXT_RXDATA[8] | (uint32_t)BTS_I2C_EXT_RXDATA[9] << 8 | (uint32_t)BTS_I2C_EXT_RXDATA[10]<< 16 | (uint32_t)BTS_I2C_EXT_RXDATA[11]<< 24;
                    BTS_userInputs[channel].IoutOffset_A    = (uint32_t)BTS_I2C_EXT_RXDATA[12]| (uint32_t)BTS_I2C_EXT_RXDATA[13]<< 8 | (uint32_t)BTS_I2C_EXT_RXDATA[14]<< 16 | (uint32_t)BTS_I2C_EXT_RXDATA[15]<< 24;
                    BTS_userInputs[channel].VoutGain_pu     = (uint32_t)BTS_I2C_EXT_RXDATA[16]| (uint32_t)BTS_I2C_EXT_RXDATA[17]<< 8 | (uint32_t)BTS_I2C_EXT_RXDATA[18]<< 16 | (uint32_t)BTS_I2C_EXT_RXDATA[19]<< 24;
                    BTS_userInputs[channel].VoutOffset_pu   = (uint32_t)BTS_I2C_EXT_RXDATA[20]| (uint32_t)BTS_I2C_EXT_RXDATA[21]<< 8 | (uint32_t)BTS_I2C_EXT_RXDATA[22]<< 16 | (uint32_t)BTS_I2C_EXT_RXDATA[23]<< 24;
                    BTS_userInputs[channel].VoutGain_V      = (uint32_t)BTS_I2C_EXT_RXDATA[24]| (uint32_t)BTS_I2C_EXT_RXDATA[25]<< 8 | (uint32_t)BTS_I2C_EXT_RXDATA[26]<< 16 | (uint32_t)BTS_I2C_EXT_RXDATA[27]<< 24;
                    BTS_userInputs[channel].VoutOffset_V    = (uint32_t)BTS_I2C_EXT_RXDATA[28]| (uint32_t)BTS_I2C_EXT_RXDATA[29]<< 8 | (uint32_t)BTS_I2C_EXT_RXDATA[30]<< 16 | (uint32_t)BTS_I2C_EXT_RXDATA[31]<< 24;
                    BTS_userInputs[channel].pendingUpdate   = (uint32_t)BTS_I2C_EXT_RXDATA[32]| (uint32_t)BTS_I2C_EXT_RXDATA[33]<< 8 ;
                }
                break;
            case BTS_I2C_ADR_USER_CH1:
            case BTS_I2C_ADR_USER_CH2:
            case BTS_I2C_ADR_USER_CH3:
            case BTS_I2C_ADR_USER_CH4:
            case BTS_I2C_ADR_USER_CH5:
            case BTS_I2C_ADR_USER_CH6:
            case BTS_I2C_ADR_USER_CH7:
            case BTS_I2C_ADR_USER_CH8:
                if (I2CA.NumOfDataBytes == 14)
                {
                    BTS_userInputs[channel].iref_A             =  (uint32_t)BTS_I2C_EXT_RXDATA[0] | (uint32_t)BTS_I2C_EXT_RXDATA[1] << 8 | (uint32_t)BTS_I2C_EXT_RXDATA[2] << 16 | (uint32_t)BTS_I2C_EXT_RXDATA[3] << 24;
                    BTS_userInputs[channel].vref_charge_V      =  (uint32_t)BTS_I2C_EXT_RXDATA[4] | (uint32_t)BTS_I2C_EXT_RXDATA[5] << 8 | (uint32_t)BTS_I2C_EXT_RXDATA[6] << 16 | (uint32_t)BTS_I2C_EXT_RXDATA[7] << 24;
                    BTS_userInputs[channel].vref_discharge_V   =  (uint32_t)BTS_I2C_EXT_RXDATA[8] | (uint32_t)BTS_I2C_EXT_RXDATA[9] << 8 | (uint32_t)BTS_I2C_EXT_RXDATA[10]<< 16 | (uint32_t)BTS_I2C_EXT_RXDATA[11]<< 24;
                    BTS_userInputs[channel].direction_logic    =  (uint32_t)BTS_I2C_EXT_RXDATA[12];
                    BTS_userInputs[channel].enable_logic       =  (uint32_t)BTS_I2C_EXT_RXDATA[13];
                }
                break;
            }

            // Reset the receive buffer back to the origin
            I2CA.pRX_MsgBuffer = BTS_I2C_EXT_RXDATA

            break;
        }
    }



    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP8);
}

//
// I2CA FIFO ISR
//
#pragma CODE_SECTION(i2cAFIFOISR,"isrcodefuncs");
#pragma INTERRUPT(i2cAFIFOISR, HPI)
__interrupt void i2cAFIFOISR(void)
{
    Write_Read_TX_RX_FIFO(&I2CA);

    uint16_t MasterSlave = HWREGH(I2CA.base + I2C_O_MDR);

    //I2CB working in master configuration
    if(MasterSlave & I2C_MDR_TRX)
    {
       //I2CB working as Master Transmitter
       I2C_disableInterrupt(I2CA.base, (I2C_INT_TXFF));
    }

    // Check if we're in SLAVE mode and RECIEVE
    // in which case;
    if(MasterSlave & (I2C_MDR_MST | I2C_MDR_TRX) == 0)
    {
       if(I2CA.pRX_MsgBuffer == 0x0)
       {
          I2CA.pRX_MsgBuffer = (uint16_t *)((uint32_t)(I2CA.pControlAddr) & 0x00FFFFFF);
          I2CA.pTX_MsgBuffer = (uint16_t *)0;
       }
    }

    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP8);
}


#pragma CODE_SECTION(BTS_updateReference,"ramfuncs");
void BTS_updateReference(BTS_userInput *userInput, BTS_ctrlLoopVariable *ctrlLoopVariable)
{
#if(BTS_TRIP_CODE)
    if(userInput->enable_logic){
        ctrlLoopVariable->tripFlag=0;
    }
    else{
        ctrlLoopVariable->tripFlag=1;
    }
#endif

#if(BTS_CALIBRATION_ENABLED== false)
    ctrlLoopVariable->ioutRef_pu = userInput->iref_A * userInput->IoutGain_pu + userInput->IoutOffset_pu;

    ctrlLoopVariable->dutySetRef_pu=  userInput->dutyRef_pu;

    if(userInput->direction_logic ==1) {
        ctrlLoopVariable->direction_coeff=1.0;
        ctrlLoopVariable->direction_logic=1U;
        ctrlLoopVariable->voutRef_pu = userInput->vref_charge_V * userInput->VoutGain_pu + userInput->VoutOffset_pu;
    }
    else {
        ctrlLoopVariable->direction_coeff=-1.0;
        ctrlLoopVariable->direction_logic=0U;
        ctrlLoopVariable->voutRef_pu = userInput->vref_discharge_V * userInput->VoutGain_pu + userInput->VoutOffset_pu;
    }
#endif

#if(BTS_CALIBRATION_ENABLED== true)
#if(BTS_CALIBATION_MODE==BTS_CALIBRATION_CC)
    ctrlLoopVariable->ioutRef_pu = userInput->ioutCal_pu;
    ctrlLoopVariable->voutRef_pu = (float32_t)1.0;
#endif
#if(BTS_CALIBATION_MODE==BTS_CALIBRATION_CV)
    ctrlLoopVariable->ioutRef_pu = (float32_t)1.0;
    ctrlLoopVariable->voutRef_pu = userInput->voutCal_pu;
#endif
    if(userInput->direction_logic ==1) {
        ctrlLoopVariable->direction_coeff=1.0;
        ctrlLoopVariable->direction_logic=1U;
    }
    else {
        ctrlLoopVariable->direction_coeff=-1.0;
        ctrlLoopVariable->direction_logic=0U;}

#endif

}

#pragma CODE_SECTION(BTS_monitor_program_update,"ramfuncs");
void BTS_monitor_program_update(uint16_t channel)
{
    if ( BTS_userInputs[channel].pendingUpdate )
    {
        // Copy into user input and controller if valid
        BTS_calcUserProgramVariables(channel);

        // Write the settings into EEPROM to commit the data
        if (BTS_userInputs[channel].pendingUpdate == 2) {
            BTS_writeCalibration(channel);
        }

        BTS_userInputs[channel].pendingUpdate = 0;
    }
}

#pragma CODE_SECTION(BTS_monitor_Iout_Vout,"ramfuncs");
void BTS_monitor_Iout_Vout(BTS_measValue* measValues )
{
    measValues->Sum_I=0U;
    measValues->Sum_V=0U;
    uint16_t index;
    float32_t avgValue=0.0;
    for(index=0U; index<BTS_senseAverageFactor; index++){
        measValues->Sum_I += measValues->Isense_16b[index];
        measValues->Sum_V+= measValues->Vsense_16b[index];
    }
    avgValue= (float32_t)measValues->Sum_I/((float32_t)BTS_senseAverageFactor* 32768.0);
    measValues->Isense_A =measValues->IoutGain_A *avgValue +measValues->IoutOffset_A ;
    avgValue= (float32_t)measValues->Sum_V/((float32_t)BTS_senseAverageFactor* 32768.0);
    measValues->Vsense_V =measValues->VoutGain_V *avgValue  +measValues->VoutOffset_V;

}



//
// End of buck.c
//
