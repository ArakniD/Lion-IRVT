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

ChannelStatus status[PWM_CH_MAX];

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
    BTS_measValues[i].F28V_Gain     = BTS_userInputs[i].F28V_Gain;
    BTS_measValues[i].F28V_Offset   = BTS_userInputs[i].F28V_Offset;
    BTS_measValues[i].F28I_Gain     = BTS_userInputs[i].F28I_Gain;
    BTS_measValues[i].F28I_Offset   = BTS_userInputs[i].F28I_Offset;
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


//
// End of buck.c
//
