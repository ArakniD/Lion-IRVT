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

BTS_measValues BTS_measValues_ch1;
BTS_measValues BTS_measValues_ch2;
BTS_measValues BTS_measValues_ch3;
BTS_measValues BTS_measValues_ch4;
BTS_measValues BTS_measValues_ch5;
BTS_measValues BTS_measValues_ch6;
BTS_measValues BTS_measValues_ch7;
BTS_measValues BTS_measValues_ch8;

BTS_userInput BTS_userInput_ch1;
BTS_userInput BTS_userInput_ch2;
BTS_userInput BTS_userInput_ch3;
BTS_userInput BTS_userInput_ch4;
BTS_userInput BTS_userInput_ch5;
BTS_userInput BTS_userInput_ch6;
BTS_userInput BTS_userInput_ch7;
BTS_userInput BTS_userInput_ch8;

BTS_DCL_CTRL_TYPE   BTS_ctrl_cc_ch1    = BTS_DCL_CTRL_DEFAULTS;
BTS_DCL_CTRL_TYPE   BTS_ctrl_cc_ch2    = BTS_DCL_CTRL_DEFAULTS;
BTS_DCL_CTRL_TYPE   BTS_ctrl_cc_ch3    = BTS_DCL_CTRL_DEFAULTS;
BTS_DCL_CTRL_TYPE   BTS_ctrl_cc_ch4    = BTS_DCL_CTRL_DEFAULTS;
BTS_DCL_CTRL_TYPE   BTS_ctrl_cc_ch5    = BTS_DCL_CTRL_DEFAULTS;
BTS_DCL_CTRL_TYPE   BTS_ctrl_cc_ch6    = BTS_DCL_CTRL_DEFAULTS;
BTS_DCL_CTRL_TYPE   BTS_ctrl_cc_ch7    = BTS_DCL_CTRL_DEFAULTS;
BTS_DCL_CTRL_TYPE   BTS_ctrl_cc_ch8    = BTS_DCL_CTRL_DEFAULTS;

BTS_DCL_CTRL_TYPE   BTS_ctrl_cv_ch1    = BTS_DCL_CTRL_DEFAULTS;
BTS_DCL_CTRL_TYPE   BTS_ctrl_cv_ch2    = BTS_DCL_CTRL_DEFAULTS;
BTS_DCL_CTRL_TYPE   BTS_ctrl_cv_ch3    = BTS_DCL_CTRL_DEFAULTS;
BTS_DCL_CTRL_TYPE   BTS_ctrl_cv_ch4    = BTS_DCL_CTRL_DEFAULTS;
BTS_DCL_CTRL_TYPE   BTS_ctrl_cv_ch5    = BTS_DCL_CTRL_DEFAULTS;
BTS_DCL_CTRL_TYPE   BTS_ctrl_cv_ch6    = BTS_DCL_CTRL_DEFAULTS;
BTS_DCL_CTRL_TYPE   BTS_ctrl_cv_ch7    = BTS_DCL_CTRL_DEFAULTS;
BTS_DCL_CTRL_TYPE   BTS_ctrl_cv_ch8    = BTS_DCL_CTRL_DEFAULTS;

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
BTS_ctrlLoopVariable BTS_ctrlLoopVariable_ch1;
BTS_ctrlLoopVariable BTS_ctrlLoopVariable_ch2;
BTS_ctrlLoopVariable BTS_ctrlLoopVariable_ch3;
BTS_ctrlLoopVariable BTS_ctrlLoopVariable_ch4;
BTS_ctrlLoopVariable BTS_ctrlLoopVariable_ch5;
BTS_ctrlLoopVariable BTS_ctrlLoopVariable_ch6;
BTS_ctrlLoopVariable BTS_ctrlLoopVariable_ch7;
BTS_ctrlLoopVariable BTS_ctrlLoopVariable_ch8;

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

struct I2CHandle *i2c_int_crnt_responderPtr;                   // Used in interrupt

uint16_t AvailableI2C_slaves[MAX_I2C_IN_NETWORK];

uint16_t I2CA_TXdata[MAX_BUFFER_SIZE];
uint16_t I2CB_TXdata[MAX_BUFFER_SIZE];

uint16_t I2CA_RXdata[MAX_BUFFER_SIZE];
uint16_t I2CB_RXdata[MAX_BUFFER_SIZE];

uint32_t I2CA_ControlAddr;
uint32_t I2CB_ControlAddr;
uint16_t status;

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

    BTS_userInput_ch8.IoutGain_pu = BTS_IoutGain_ch8_pu;
    BTS_userInput_ch8.IoutOffset_pu = BTS_IoutOffset_ch8_pu;
    BTS_userInput_ch8.IoutGain_A = BTS_IoutGain_ch8_A;
    BTS_userInput_ch8.IoutOffset_A = BTS_IoutOffset_ch8_A;

    BTS_userInput_ch8.VoutGain_pu = BTS_VoutGain_ch8_pu;
    BTS_userInput_ch8.VoutOffset_pu = BTS_VoutOffset_ch8_pu;
    BTS_userInput_ch8.VoutGain_V = BTS_VoutGain_ch8_V;
    BTS_userInput_ch8.VoutOffset_V = BTS_VoutOffset_ch8_V;

}

void BTS_initProgramVariables(void){

    BTS_ctrlLoopVariable_ch1.ioutTrip_16b =BTS_USER_DEFAULT_TRIP_16b;
    BTS_ctrlLoopVariable_ch1.ioutTrip_n_16b =((int16_t)-1) * BTS_USER_DEFAULT_TRIP_16b;

    BTS_ctrlLoopVariable_ch2.ioutTrip_16b =BTS_USER_DEFAULT_TRIP_16b;
    BTS_ctrlLoopVariable_ch2.ioutTrip_n_16b =((int16_t)-1) * BTS_USER_DEFAULT_TRIP_16b;

    BTS_ctrlLoopVariable_ch3.ioutTrip_16b =BTS_USER_DEFAULT_TRIP_16b;
    BTS_ctrlLoopVariable_ch3.ioutTrip_n_16b =((int16_t)-1) * BTS_USER_DEFAULT_TRIP_16b;

    BTS_ctrlLoopVariable_ch4.ioutTrip_16b =BTS_USER_DEFAULT_TRIP_16b;
    BTS_ctrlLoopVariable_ch4.ioutTrip_n_16b =((int16_t)-1) * BTS_USER_DEFAULT_TRIP_16b;

    BTS_ctrlLoopVariable_ch5.ioutTrip_16b =BTS_USER_DEFAULT_TRIP_16b;
    BTS_ctrlLoopVariable_ch5.ioutTrip_n_16b =((int16_t)-1) * BTS_USER_DEFAULT_TRIP_16b;

    BTS_ctrlLoopVariable_ch6.ioutTrip_16b =BTS_USER_DEFAULT_TRIP_16b;
    BTS_ctrlLoopVariable_ch6.ioutTrip_n_16b =((int16_t)-1) * BTS_USER_DEFAULT_TRIP_16b;

    BTS_ctrlLoopVariable_ch7.ioutTrip_16b =BTS_USER_DEFAULT_TRIP_16b;
    BTS_ctrlLoopVariable_ch7.ioutTrip_n_16b =((int16_t)-1) * BTS_USER_DEFAULT_TRIP_16b;

    BTS_ctrlLoopVariable_ch8.ioutTrip_16b =BTS_USER_DEFAULT_TRIP_16b;
    BTS_ctrlLoopVariable_ch8.ioutTrip_n_16b =((int16_t)-1) * BTS_USER_DEFAULT_TRIP_16b;

    BTS_measValues_ch1.IoutGain_A = BTS_IoutGain_ch1_A;
    BTS_measValues_ch1.IoutOffset_A = BTS_IoutOffset_ch1_A;
    BTS_measValues_ch1.VoutGain_V = BTS_VoutGain_ch1_V;
    BTS_measValues_ch1.VoutOffset_V =BTS_VoutOffset_ch1_V;

    BTS_measValues_ch2.IoutGain_A = BTS_IoutGain_ch2_A;
    BTS_measValues_ch2.IoutOffset_A = BTS_IoutOffset_ch2_A;
    BTS_measValues_ch2.VoutGain_V = BTS_VoutGain_ch2_V;
    BTS_measValues_ch2.VoutOffset_V =BTS_VoutOffset_ch2_V;

    BTS_measValues_ch3.IoutGain_A = BTS_IoutGain_ch3_A;
    BTS_measValues_ch3.IoutOffset_A = BTS_IoutOffset_ch3_A;
    BTS_measValues_ch3.VoutGain_V = BTS_VoutGain_ch3_V;
    BTS_measValues_ch3.VoutOffset_V =BTS_VoutOffset_ch3_V;

    BTS_measValues_ch4.IoutGain_A = BTS_IoutGain_ch4_A;
    BTS_measValues_ch4.IoutOffset_A = BTS_IoutOffset_ch4_A;
    BTS_measValues_ch4.VoutGain_V = BTS_VoutGain_ch4_V;
    BTS_measValues_ch4.VoutOffset_V =BTS_VoutOffset_ch4_V;

    BTS_measValues_ch5.IoutGain_A = BTS_IoutGain_ch5_A;
    BTS_measValues_ch5.IoutOffset_A = BTS_IoutOffset_ch5_A;
    BTS_measValues_ch5.VoutGain_V = BTS_VoutGain_ch5_V;
    BTS_measValues_ch5.VoutOffset_V =BTS_VoutOffset_ch5_V;

    BTS_measValues_ch6.IoutGain_A = BTS_IoutGain_ch6_A;
    BTS_measValues_ch6.IoutOffset_A = BTS_IoutOffset_ch6_A;
    BTS_measValues_ch6.VoutGain_V = BTS_VoutGain_ch6_V;
    BTS_measValues_ch6.VoutOffset_V =BTS_VoutOffset_ch6_V;

    BTS_measValues_ch7.IoutGain_A = BTS_IoutGain_ch7_A;
    BTS_measValues_ch7.IoutOffset_A = BTS_IoutOffset_ch7_A;
    BTS_measValues_ch7.VoutGain_V = BTS_VoutGain_ch7_V;
    BTS_measValues_ch7.VoutOffset_V =BTS_VoutOffset_ch7_V;

    BTS_measValues_ch8.IoutGain_A = BTS_IoutGain_ch8_A;
    BTS_measValues_ch8.IoutOffset_A = BTS_IoutOffset_ch8_A;
    BTS_measValues_ch8.VoutGain_V = BTS_VoutGain_ch8_V;
    BTS_measValues_ch8.VoutOffset_V =BTS_VoutOffset_ch8_V;
}

void BTS_readCalibration(void)
{
    BTS_channelCalibration  framData;

    // Scan bus first, check fram is there
    uint16_t *pAvailableI2C_slaves = AvailableI2C_slaves;
        status = I2CBusScan(I2CA_BASE, pAvailableI2C_slaves);

    uint16_t i;

    EEPROM.currentHandlePtr     = &EEPROM;
    EEPROM.SlaveAddr            = EEPROM_SLAVE_ADDRESS;
    EEPROM.WriteCycleTime_in_us = 10000;    //6ms for EEPROM this code was tested
    EEPROM.base                 = BTS_I2C_INT_BASE;
    EEPROM.pControlAddr         = &ControlAddr;
    EEPROM.NumOfAddrBytes       = 2;


        // read fram one calibration slot at a time
        //Example 2: EEPROM Byte Read
           //Make sure 11 is written to EEPROM address 0x0
           ControlAddr = 0;
           EEPROM.pControlAddr   = &ControlAddr;
           EEPROM.pRX_MsgBuffer  = RX_MsgBuffer;
           EEPROM.NumOfDataBytes = 1;

           status = I2C_MasterReceiver(&EEPROM);

           while(I2C_getStatus(EEPROM.base) & I2C_STS_BUS_BUSY);



        // checksum validation

        // perform an in-place data upgrades

        // Copy into user input and controller if valid





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

   if(MasterSlave)
   {
       //I2CB working as slave
       //Disable I2CA FIFO interrupt to first trigger I2CB FIFO interrupt to read control address
       I2C_disableInterrupt(I2CA.base, (I2C_INT_TXFF));
   }


   handleI2C_ErrorCondition(&I2CB);

   Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP8);
}

//
// I2CB FIFO ISR
//
#pragma CODE_SECTION(i2cBFIFOISR,"isrcodefuncs");
#pragma INTERRUPT(i2cBFIFOISR, HPI)
__interrupt void i2cBFIFOISR(void)
{
    Write_Read_TX_RX_FIFO(&I2CB);

    uint16_t MasterSlave = HWREGH(I2CB.base + I2C_O_MDR);

    if(MasterSlave & I2C_MDR_MST)
    {
        //I2CB working in master configuration
        if(MasterSlave & I2C_MDR_TRX)
        {
           //I2CB working as Master Transmitter
           I2C_disableInterrupt(I2CB.base, (I2C_INT_TXFF));
        }
        else
        {
           //I2CB working as Master Receiver
           I2C_enableInterrupt(I2CA.base, (I2C_INT_TXFF));
           I2C_clearInterruptStatus(I2CA.base,(I2C_INT_TXFF));
        }
    }
   else
   {
       //I2CB working in slave configuration
       if(MasterSlave & I2C_MDR_TRX)
       {
           //I2CA = Master Receiver & I2CB = Slave Transmitter
           //So, I2CA RXFIFO interrupt is enabled  &
           //    I2CA TXFIFO interrupt is disabled
           I2C_enableInterrupt(I2CA.base, (I2C_INT_RXFF));
           I2C_disableInterrupt(I2CA.base, (I2C_INT_TXFF));
           I2C_clearInterruptStatus(I2CA.base,(I2C_INT_RXFF));

           I2C_disableInterrupt(I2CB.base, (I2C_INT_TXFF));
       }
       else
       {
           //I2CB working as slave receiver
           if(HWREGH(I2CA.base + I2C_O_CNT) == I2CA.NumOfAddrBytes)
           {
               //Enable I2CA Register Access Ready interrupt to change
               //to master receiver
               I2C_enableInterrupt(I2CA.base, I2C_INT_REG_ACCESS_RDY);
               if(I2CB.pTX_MsgBuffer == 0x0)
               {
                    I2CB.pTX_MsgBuffer = (uint16_t *)((uint32_t)(I2CB.pControlAddr) & 0x00FFFFFF);
                    I2CB.pRX_MsgBuffer = (uint16_t *)0;
               }
           }
           else
           {
               //Continue with I2CA master transmitter mode
               I2C_enableInterrupt(I2CA.base, (I2C_INT_TXFF));
               I2C_disableInterrupt(I2CA.base, (I2C_INT_RXFF));
               I2C_clearInterruptStatus(I2CA.base,(I2C_INT_TXFF | I2C_INT_RXFF));
               if(I2CB.pRX_MsgBuffer == 0x0)
               {
                   I2CB.pRX_MsgBuffer = (uint16_t *)((uint32_t)(I2CB.pControlAddr) & 0x00FFFFFF);
                   I2CB.pTX_MsgBuffer = (uint16_t *)0;
               }
           }
       }
   }

   Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP8);
}

//
// I2CA ISR
//
#pragma CODE_SECTION(i2cAISR,"isrcodefuncs");
#pragma INTERRUPT(i2cAISR, HPI)
__interrupt void i2cAISR(void)
{
    uint16_t MasterSlave = I2C_getStatus(I2CA.base) & I2C_STS_ADDR_SLAVE;

    if(MasterSlave)
    {
        //I2CA working as slave
        //Disable I2CB FIFO interrupt to first trigger I2CA FIFO interrupt to read control address
        I2C_disableInterrupt(I2CB.base, (I2C_INT_TXFF));
    }

    handleI2C_ErrorCondition(&I2CA);
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

    if(MasterSlave & I2C_MDR_MST)
    {
        //I2CA working in master configuration
        if(MasterSlave & I2C_MDR_TRX)
        {
          //I2CA working as Master Transmitter
          I2C_disableInterrupt(I2CA.base, (I2C_INT_TXFF));
        }
        else
        {
          //I2CA working as Master Receiver
          I2C_enableInterrupt(I2CB.base, (I2C_INT_TXFF));
          I2C_clearInterruptStatus(I2CB.base,(I2C_INT_TXFF));
        }
    }
    else
    {
        //I2CA working in slave configuration
        if(MasterSlave & I2C_MDR_TRX)
        {
            //I2CA = Slave Transmitter & I2CB = Master Receiver
            //So, I2CB RXFIFO interrupt is enabled  &
            //    I2CB TXFIFO interrupt is disabled
            I2C_enableInterrupt(I2CB.base, (I2C_INT_RXFF));
            I2C_disableInterrupt(I2CB.base, (I2C_INT_TXFF));
            I2C_clearInterruptStatus(I2CB.base,(I2C_INT_RXFF));

            I2C_disableInterrupt(I2CA.base, (I2C_INT_TXFF));
        }
       else
       {
           //I2CA working as slave receiver
           if(HWREGH(I2CB.base + I2C_O_CNT) == I2CB.NumOfAddrBytes)
           {
               //Enable I2CB Register Access Ready interrupt to change
               //to master receiver
               I2C_enableInterrupt(I2CB.base, I2C_INT_REG_ACCESS_RDY);
               if(I2CA.pTX_MsgBuffer == 0x0)
               {
                    I2CA.pTX_MsgBuffer = (uint16_t *)((uint32_t)(I2CA.pControlAddr) & 0x00FFFFFF);
                    I2CA.pRX_MsgBuffer = (uint16_t *)0;
               }
           }
           else
           {
               //Continue with I2CB master transmitter mode
               I2C_enableInterrupt(I2CB.base, (I2C_INT_TXFF));
               I2C_disableInterrupt(I2CB.base, (I2C_INT_RXFF));
               I2C_clearInterruptStatus(I2CB.base,(I2C_INT_TXFF | I2C_INT_RXFF));
               if(I2CA.pRX_MsgBuffer == 0x0)
               {
                   I2CA.pRX_MsgBuffer = (uint16_t *)((uint32_t)(I2CA.pControlAddr) & 0x00FFFFFF);
                   I2CA.pTX_MsgBuffer = (uint16_t *)0;
               }
           }
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


#pragma CODE_SECTION(BTS_monitor_Iout_Vout,"ramfuncs");
void BTS_monitor_Iout_Vout(BTS_measValues* measValues )
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
