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

//
// Slot grouping, resolved once at init from the MODE dip switch by
// BTS_initSlotGrouping(). The control ISR runs at the switching frequency,
// so it reads these tables rather than recomputing a group membership on
// every pass.
//
uint16_t btsSlotLeader[PWM_CH_MAX]     = {0, 1, 2, 3, 4, 5, 6, 7};
uint16_t btsSlotIsLeader[PWM_CH_MAX]   = {1, 1, 1, 1, 1, 1, 1, 1};
uint16_t btsSlotEnabled[PWM_CH_MAX]    = {1, 1, 1, 1, 1, 1, 1, 1};
uint16_t btsSlotUsesIntAdc[PWM_CH_MAX] = {0, 0, 0, 0, 0, 0, 0, 0};

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

//
// Resolves the MODE/ENABLE straps into the per-slot lookup tables the control
// ISR uses. Call once, after CPU1 has latched the straps in
// BTS_HAL_setupGPIO() and before the ePWM counters are released.
//
// mode   0-7 from the MODE switch   (grouping + which ADC closes the loop)
// enable 0-7 from the ENABLE switch (index of the highest enabled slot)
//
void BTS_initSlotGrouping(uint16_t mode, uint16_t enable)
{
    uint16_t ch;

    for (ch = 0; ch < PWM_CH_MAX; ch++) {
        btsSlotLeader[ch]     = BTS_GROUP_LEADER(ch, mode);
        btsSlotIsLeader[ch]   = BTS_IS_GROUP_LEADER(ch, mode) ? 1U : 0U;
        btsSlotEnabled[ch]    = BTS_SLOT_ENABLED(ch, enable) ? 1U : 0U;
        btsSlotUsesIntAdc[ch] = BTS_MODE_USES_INT_ADC(mode) ? 1U : 0U;

        //
        // A follower is never independently startable, and a masked-off slot
        // never runs at all. Publish both through the status word so the
        // host and the LEDs agree with what the straps actually selected.
        //
        status[ch].slaveMode    = (btsSlotIsLeader[ch] == 0U) ? 1U : 0U;
        status[ch].slotDisabled = (btsSlotEnabled[ch] == 0U) ? 1U : 0U;

        if (btsSlotEnabled[ch] == 0U) {
            status[ch].running = 0;
            status[ch].stopped = 1;
            BTS_userInputs[ch].enable_logic = 0;
        }
    }
}

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

    //
    // Internal-ADC (C2000) cell voltage and current calibration.
    //
    // Unlike the Iout/Vout pairs above, these have no per-channel compiled-in
    // constant - the real values are meant to arrive from EEPROM, which CPU2
    // publishes into registers[] and signals with BTS_IPC_FLAG_CAL_RELOAD.
    // That notification is a single one-shot raised during CPU2's boot, so if
    // CPU1 is not yet polling IPC when it lands the gains are never copied and
    // stay at their zero-initialised value. A zero gain silently multiplies
    // every cell-voltage reading to 0.0 V - the measurement looks dead while
    // the ADC is in fact sampling correctly.
    //
    // Seeding unity gain here makes the reading correct-by-default and means a
    // missed or late calibration reload degrades to raw scaling rather than to
    // zero. A subsequent BTS_loadCalibrationFromRegisters() still overwrites
    // these with the stored calibration.
    //
    {
        uint16_t ch;
        for (ch = 0; ch < NUM_CHANNELS; ch++) {
            BTS_userInputs[ch].F28V_Gain   = BTS_F28V_GAIN_DEFAULT;
            BTS_userInputs[ch].F28V_Offset = BTS_F28V_OFFSET_DEFAULT;
            BTS_userInputs[ch].F28I_Gain   = BTS_F28I_GAIN_DEFAULT;
            BTS_userInputs[ch].F28I_Offset = BTS_F28I_OFFSET_DEFAULT;

            BTS_userInputs[ch].calState   = BTS_CAL_STATE_NORMAL;
            BTS_userInputs[ch].ioutCal_pu = (float32_t)0.0;
            BTS_userInputs[ch].voutCal_pu = (float32_t)0.0;
        }
    }

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
    //
    // Calibration is a per-channel runtime state, not the compile-time
    // switch it used to be: one slot drives a reference while the other
    // seven keep running normally.
    //
    if (userInput->calState != BTS_CAL_STATE_NORMAL) {
        if (userInput->calState == BTS_CAL_STATE_FIXED_I) {
            ctrlLoopVariable->ioutRef_pu = userInput->ioutCal_pu;
            ctrlLoopVariable->voutRef_pu = (float32_t)1.0;
        } else {
            //
            // Calibration idle. The converter is held off but the ADCs keep
            // sampling, which is what the zero-current capture needs.
            //
            userInput->enable_logic      = 0;
            ctrlLoopVariable->ioutRef_pu = (float32_t)0.0;
            ctrlLoopVariable->voutRef_pu = (float32_t)0.0;
        }

        //
        // Calibration current always flows in discharge, which the loop
        // represents with a negative direction coefficient.
        //
        ctrlLoopVariable->direction_coeff = -1.0;
        ctrlLoopVariable->direction_logic = 0U;

#if(BTS_TRIP_CODE)
        ctrlLoopVariable->tripFlag = userInput->enable_logic ? 0U : 1U;
#endif
        return;
    }

#if(BTS_TRIP_CODE)
    if(userInput->enable_logic){
        ctrlLoopVariable->tripFlag=0;
    }
    else{
        ctrlLoopVariable->tripFlag=1;
    }
#endif

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
}

//
// Pulls the calibration block CPU2 published in registers[] into this
// channel's user input and marks it for recalculation. Called from the
// CPU1 background task when CPU2 signals that calibration data changed.
//
void BTS_loadCalibrationFromRegisters(uint16_t channel)
{
    uint16_t base = BTS_CAL_BASE(channel);

    BTS_userInputs[channel].F28V_Gain     = registers[base + BTS_CAL_F28V_GAIN];
    BTS_userInputs[channel].F28V_Offset   = registers[base + BTS_CAL_F28V_OFFSET];
    BTS_userInputs[channel].F28I_Gain     = registers[base + BTS_CAL_F28I_GAIN];
    BTS_userInputs[channel].F28I_Offset   = registers[base + BTS_CAL_F28I_OFFSET];
    BTS_userInputs[channel].IoutGain_pu   = registers[base + BTS_CAL_IOUT_GAIN_PU];
    BTS_userInputs[channel].IoutOffset_pu = registers[base + BTS_CAL_IOUT_OFFSET_PU];
    BTS_userInputs[channel].IoutGain_A    = registers[base + BTS_CAL_IOUT_GAIN_A];
    BTS_userInputs[channel].IoutOffset_A  = registers[base + BTS_CAL_IOUT_OFFSET_A];
    BTS_userInputs[channel].VoutGain_pu   = registers[base + BTS_CAL_VOUT_GAIN_PU];
    BTS_userInputs[channel].VoutOffset_pu = registers[base + BTS_CAL_VOUT_OFFSET_PU];
    BTS_userInputs[channel].VoutGain_V    = registers[base + BTS_CAL_VOUT_GAIN_V];
    BTS_userInputs[channel].VoutOffset_V  = registers[base + BTS_CAL_VOUT_OFFSET_V];

    BTS_userInputs[channel].pendingUpdate = 1;
}

//
// Applies a pending calibration update to the running program.
//
// This updates in-memory program variables only. It is driven by the
// communications CPU having changed the calibration registers; committing
// those values to EEPROM is CPU2's job and is triggered separately by the
// host writing eCalibrationMode, so there is no EEPROM access on this path.
//
#pragma CODE_SECTION(BTS_monitor_program_update,"ramfuncs");
void BTS_monitor_program_update(uint16_t channel)
{
    if (BTS_userInputs[channel].pendingUpdate)
    {
        BTS_calcUserProgramVariables(channel);
        BTS_userInputs[channel].pendingUpdate = 0;
    }
}


//
// End of buck.c
//
