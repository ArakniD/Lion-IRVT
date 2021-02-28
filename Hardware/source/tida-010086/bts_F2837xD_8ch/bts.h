//#############################################################################
//
// FILE:  buck.h
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

#ifndef BTS_H
#define BTS_H

#ifdef __cplusplus

extern "C" {
#endif

//
//=============================================================================
// includes and defines
//=============================================================================
//
#include "bts_hal.h"
#include "DCL_fdlog.h"
#include "DCL_TCM.h"

#if(BTS_DRV_EPWM_HR_ENABLED == true)
    #include "SFO_V8.h"
#endif

#if(BTS_DCL_CORE == BTS_DCL_FPU32)
    #include "DCLF32.h"
#endif


#if(BTS_SFRA_ENABLED == true)
    //
    // Only pull in SFRA includes if SFRA is enabled
    //
    #include <stddef.h>
    #include "sfra_f32.h"
    #include "sfra_gui_scicomms_driverlib.h"

    //
    // Use macros to call the SFRA functions
    // The input parameters are passed through to the underlying SFRA functions
    //
    #define BTS_SFRA_INJECT(x) SFRA_F32_inject(x)
    #define BTS_SFRA_COLLECT(x, y) SFRA_F32_collect(x, y)
    #define BTS_SFRA_GUI_RUN_COMMS(x) SFRA_GUI_runSerialHostComms(x)
    #define BTS_SFRA_RUN_BACKGROUND(x) SFRA_F32_runBackgroundTask(x)
#else
    //
    // The macros will eliminate the SFRA function calls when not enabled
    //   BTS_SFRA_INJECT(x) will be replaced inline with just the (x) value
    //   The other macros will be replaced inline with empty code blocks {}
    //
    #define BTS_SFRA_INJECT(x) (x)
    #define BTS_SFRA_COLLECT(x, y) {}
    #define BTS_SFRA_GUI_RUN_COMMS(x) {}
    #define BTS_SFRA_RUN_BACKGROUND(x) {}
#endif



//
//=============================================================================
// typdefs and externs
//=============================================================================
//


//
//=====================================
// Variables used by the program to run the BUCK solution.
//
// This subset of variables can be used interactively in the watch window
// to monitor and control the execution of the BTS solution.
//

//=====================================
//


typedef struct
{
    float32_t Isense_A;
    float32_t Vsense_V;
    int16_t Isense_16b[BTS_senseAverageFactor];
    int16_t Vsense_16b[BTS_senseAverageFactor];
    int32_t Sum_I;
    int32_t Sum_V;
    uint16_t Index;
    float32_t IoutGain_A;
    float32_t IoutOffset_A;
    float32_t VoutGain_V;
    float32_t VoutOffset_V;

}BTS_measValues;

extern BTS_measValues BTS_measValues_ch1;
extern BTS_measValues BTS_measValues_ch2;
extern BTS_measValues BTS_measValues_ch3;
extern BTS_measValues BTS_measValues_ch4;
extern BTS_measValues BTS_measValues_ch5;
extern BTS_measValues BTS_measValues_ch6;
extern BTS_measValues BTS_measValues_ch7;
extern BTS_measValues BTS_measValues_ch8;

typedef struct
{
    volatile float32_t iref_A;
    volatile float32_t vref_charge_V;
    volatile float32_t vref_discharge_V;
    volatile uint16_t direction_logic;
    volatile uint16_t enable_logic;
    volatile float32_t dutyRef_pu;
    volatile float32_t ioutCal_pu;
    volatile float32_t voutCal_pu;

    float32_t IoutGain_pu;
    float32_t IoutOffset_pu;
    float32_t IoutGain_A;
    float32_t IoutOffset_A;

    float32_t VoutGain_pu;
    float32_t VoutOffset_pu;
    float32_t VoutGain_V;
    float32_t VoutOffset_V;

}BTS_userInput;
extern BTS_userInput BTS_userInput_ch1;
extern BTS_userInput BTS_userInput_ch2;
extern BTS_userInput BTS_userInput_ch3;
extern BTS_userInput BTS_userInput_ch4;
extern BTS_userInput BTS_userInput_ch5;
extern BTS_userInput BTS_userInput_ch6;
extern BTS_userInput BTS_userInput_ch7;
extern BTS_userInput BTS_userInput_ch8;

typedef struct
{
    float32_t dutySet_pu; // this variable is used in the open loop
    float32_t dutySetRef_pu;

    float32_t ioutRef_pu;
    float32_t ioutSet_pu;
    float32_t ioutSense_pu;

    float32_t voutRef_pu;
    float32_t voutSet_pu;
    float32_t voutSense_pu;

    float32_t uk_cc_pu;
    float32_t ek_cc_pu;
    float32_t uk_cv_pu;
    float32_t ek_cv_pu;
    float32_t direction_coeff;

    float32_t dutyH_pu;
    float32_t dutyL_pu;

    uint16_t ctrlMode_logic;
    uint16_t direction_logic;

    int16_t ioutTrip_16b;
    int16_t ioutTrip_n_16b;
    uint16_t tripFlag;

}BTS_ctrlLoopVariable;
extern BTS_ctrlLoopVariable BTS_ctrlLoopVariable_ch1;
extern BTS_ctrlLoopVariable BTS_ctrlLoopVariable_ch2;
extern BTS_ctrlLoopVariable BTS_ctrlLoopVariable_ch3;
extern BTS_ctrlLoopVariable BTS_ctrlLoopVariable_ch4;
extern BTS_ctrlLoopVariable BTS_ctrlLoopVariable_ch5;
extern BTS_ctrlLoopVariable BTS_ctrlLoopVariable_ch6;
extern BTS_ctrlLoopVariable BTS_ctrlLoopVariable_ch7;
extern BTS_ctrlLoopVariable BTS_ctrlLoopVariable_ch8;


extern volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_cc_ch1;
extern volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_cc_ch2;
extern volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_cc_ch3;
extern volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_cc_ch4;
extern volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_cc_ch5;
extern volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_cc_ch6;
extern volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_cc_ch7;
extern volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_cc_ch8;

extern volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_cv_ch1;
extern volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_cv_ch2;
extern volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_cv_ch3;
extern volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_cv_ch4;
extern volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_cv_ch5;
extern volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_cv_ch6;
extern volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_cv_ch7;
extern volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_cv_ch8;

#if(BTS_SFRA_ENABLED)
#if(BTS_SFRA_CH_SELECT == BTS_SFRA_CH1)
#define BTS_ctrlLoopVariable_chx BTS_ctrlLoopVariable_ch1
#define BTS_userInput_chx BTS_userInput_ch1
#define BTS_measValues_chx BTS_measValues_ch1
#define BTS_ctrl_cc_chx BTS_ctrl_cc_ch1
#define BTS_ctrl_cv_chx BTS_ctrl_cv_ch1

#define EPWMx_BASE EPWM1_BASE
#define BTS_ADC_current BTS_ADC1.channel0
#define BTS_ADC_voltage BTS_ADC1.channel1

#elif(BTS_SFRA_CH_SELECT == BTS_SFRA_CH2)
#define BTS_ctrlLoopVariable_chx BTS_ctrlLoopVariable_ch2
#define BTS_userInput_chx BTS_userInput_ch2
#define BTS_measValues_chx BTS_measValues_ch2
#define BTS_ctrl_cc_chx BTS_ctrl_cc_ch2
#define BTS_ctrl_cv_chx BTS_ctrl_cv_ch2

#define EPWMx_BASE EPWM2_BASE
#define BTS_ADC_current BTS_ADC1.channel2
#define BTS_ADC_voltage BTS_ADC1.channel3

#elif(BTS_SFRA_CH_SELECT == BTS_SFRA_CH3)
#define BTS_ctrlLoopVariable_chx BTS_ctrlLoopVariable_ch3
#define BTS_userInput_chx BTS_userInput_ch3
#define BTS_measValues_chx BTS_measValues_ch3
#define BTS_ctrl_cc_chx BTS_ctrl_cc_ch3
#define BTS_ctrl_cv_chx BTS_ctrl_cv_ch3

#define EPWMx_BASE EPWM3_BASE
#define BTS_ADC_current BTS_ADC1.channel4
#define BTS_ADC_voltage BTS_ADC1.channel5

#elif(BTS_SFRA_CH_SELECT == BTS_SFRA_CH4)
#define BTS_ctrlLoopVariable_chx BTS_ctrlLoopVariable_ch4
#define BTS_userInput_chx BTS_userInput_ch4
#define BTS_measValues_chx BTS_measValues_ch4
#define BTS_ctrl_cc_chx BTS_ctrl_cc_ch4
#define BTS_ctrl_cv_chx BTS_ctrl_cv_ch4

#define EPWMx_BASE EPWM4_BASE
#define BTS_ADC_current BTS_ADC1.channel6
#define BTS_ADC_voltage BTS_ADC1.channel7

#elif(BTS_SFRA_CH_SELECT == BTS_SFRA_CH5)
#define BTS_ctrlLoopVariable_chx BTS_ctrlLoopVariable_ch5
#define BTS_userInput_chx BTS_userInput_ch5
#define BTS_measValues_chx BTS_measValues_ch5
#define BTS_ctrl_cc_chx BTS_ctrl_cc_ch5
#define BTS_ctrl_cv_chx BTS_ctrl_cv_ch5

#define EPWMx_BASE EPWM5_BASE
#define BTS_ADC_current BTS_ADC2.channel0
#define BTS_ADC_voltage BTS_ADC2.channel1

#elif(BTS_SFRA_CH_SELECT == BTS_SFRA_CH6)
#define BTS_ctrlLoopVariable_chx BTS_ctrlLoopVariable_ch6
#define BTS_userInput_chx BTS_userInput_ch6
#define BTS_measValues_chx BTS_measValues_ch6
#define BTS_ctrl_cc_chx BTS_ctrl_cc_ch6
#define BTS_ctrl_cv_chx BTS_ctrl_cv_ch6

#define EPWMx_BASE EPWM6_BASE
#define BTS_ADC_current BTS_ADC2.channel2
#define BTS_ADC_voltage BTS_ADC2.channel3

#elif(BTS_SFRA_CH_SELECT == BTS_SFRA_CH7)
#define BTS_ctrlLoopVariable_chx BTS_ctrlLoopVariable_ch7
#define BTS_userInput_chx BTS_userInput_ch7
#define BTS_measValues_chx BTS_measValues_ch7
#define BTS_ctrl_cc_chx BTS_ctrl_cc_ch7
#define BTS_ctrl_cv_chx BTS_ctrl_cv_ch7

#define EPWMx_BASE EPWM7_BASE
#define BTS_ADC_current BTS_ADC2.channel4
#define BTS_ADC_voltage BTS_ADC2.channel5

#elif(BTS_SFRA_CH_SELECT == BTS_SFRA_CH8)
#define BTS_ctrlLoopVariable_chx BTS_ctrlLoopVariable_ch8
#define BTS_userInput_chx BTS_userInput_ch8
#define BTS_measValues_chx BTS_measValues_ch8
#define BTS_ctrl_cc_chx BTS_ctrl_cc_ch8
#define BTS_ctrl_cv_chx BTS_ctrl_cv_ch8

#define EPWMx_BASE EPWM8_BASE
#define BTS_ADC_current BTS_ADC2.channel6
#define BTS_ADC_voltage BTS_ADC2.channel7

#endif

#endif



//
//=====================================
// Variables used by the program to run the BTS solution.
//

//=====================================
//



extern uint32_t   MEP_ScaleFactor;
extern uint16_t   BUCK_sfoStatus;
extern uint16_t   BTS_sfoStatus;


//
//=====================================
// SFRA variables
//
#if(BTS_SFRA_ENABLED == true)
    extern SFRA_F32 BTS_sfra;

    //
    //=====================================
    // BTS_SfraDataType - SFRA sweep data
    //
    typedef struct {
        float32_t  plantMagVect[BTS_SFRA_FREQ_LENGTH];
        float32_t  plantPhaseVect[BTS_SFRA_FREQ_LENGTH];
        float32_t  olMagVect[BTS_SFRA_FREQ_LENGTH];
        float32_t  olPhaseVect[BTS_SFRA_FREQ_LENGTH];
        float32_t  freqVect[BTS_SFRA_FREQ_LENGTH];
    } BTS_SfraDataType;
    extern BTS_SfraDataType BTS_sfraData;
#endif


//
//=============================================================================
// Function prototypes from solution source
//=============================================================================
//

void BTS_setupSfra(void);
void BTS_setupSfraGui(void);

void BTS_setupHrpwmMepScaleFactor(void);

void BTS_updateReference(BTS_userInput *, BTS_ctrlLoopVariable *);
void BTS_initUserVariables(void);
void BTS_initProgramVariables(void);
void BTS_initController(void);
void BTS_monitor_Iout_Vout(BTS_measValues* );

//
//=============================================================================
// static inline functions
//=============================================================================
//


#pragma FUNC_ALWAYS_INLINE(BTS_updateHrpwmMepScaleFactor)
static inline void BTS_updateHrpwmMepScaleFactor(void)
{
    #if(BTS_EPWM_HR_ENABLED == true)
        BTS_sfoStatus = SFO();
    #endif
}


static inline void BTS_tripEpwm(uint32_t EPWM_BASE, BTS_DCL_CTRL_TYPE* ctrl_cc, BTS_ctrlLoopVariable *ctrlLoopVariable, int16_t current_16b)
{

#if(BTS_OCP_TRIGGER)
    if(current_16b> (ctrlLoopVariable->ioutTrip_16b) ||current_16b<(ctrlLoopVariable->ioutTrip_n_16b)){

        ctrlLoopVariable->tripFlag=1;
    }

#endif

    if(ctrlLoopVariable->tripFlag ){
        //FORCE TRIP
        EPWM_forceTripZoneEvent(EPWM_BASE,EPWM_TZ_FORCE_EVENT_OST);
        EPWM_setTripZoneAction(EPWM_BASE,  EPWM_TZ_ACTION_EVENT_TZA,EPWM_TZ_ACTION_LOW);

        EPWM_setCounterCompareValue(EPWM_BASE,EPWM_COUNTER_COMPARE_A, 0U);
        EPWM_setCounterCompareValue(EPWM_BASE, EPWM_COUNTER_COMPARE_B, BTS_DRV_EPWM_TBPRD);

        HRPWM_setHiResCounterCompareValueOnly(EPWM_BASE,HRPWM_COUNTER_COMPARE_A,0U);
        HRPWM_setHiResCounterCompareValueOnly(EPWM_BASE,HRPWM_COUNTER_COMPARE_B,0U);

        ctrl_cc->x1=0.0;
        ctrl_cc->x2=0.0;

    }

    else{
        EPWM_clearTripZoneFlag(EPWM_BASE, EPWM_TZ_FLAG_OST);
    }


}


#pragma FUNC_ALWAYS_INLINE(BTS_storeValues)
static inline void BTS_storeValues(BTS_measValues* measValues, int16_t current_16b, int16_t voltage_16b){
    if(measValues->Index<BTS_senseAverageFactor){
        measValues->Isense_16b[measValues->Index]= current_16b;
        measValues->Vsense_16b[measValues->Index]= voltage_16b;
        measValues->Index =measValues->Index+1U;
    }
    else{
        measValues->Index=0U;
    }

}
static inline void BTS_ctrlDirection(uint32_t EPWM_BASE, BTS_ctrlLoopVariable *ctrlLoopVariable,int16_t current_16b){

    //In charge mode, check if current goes below negative trip value, then shutdown low side mosfet
    //In discharge mode,  check if current goes above positive trip, then shutdown high side mosfet

    if(ctrlLoopVariable->direction_logic){
        //charge mode

        if(current_16b <((int16_t)BTS_USER_DEFAULT_TRIP_N_16b)){
            EPWM_setActionQualifierContSWForceAction(EPWM_BASE,EPWM_AQ_OUTPUT_B,EPWM_AQ_SW_OUTPUT_HIGH);
            ctrlLoopVariable->dutyH_pu = ctrlLoopVariable->dutySet_pu;
            ctrlLoopVariable->dutyL_pu = 1.0;
        }
        else{
            EPWM_setActionQualifierContSWForceAction(BTS_DRV_EPWM_BASE,EPWM_AQ_OUTPUT_B,EPWM_AQ_SW_DISABLED);
            ctrlLoopVariable->dutyH_pu = ctrlLoopVariable->dutySet_pu;
            ctrlLoopVariable->dutyL_pu = ctrlLoopVariable->dutySet_pu;
        }
    }
    else{
        //discharge mode

        if(current_16b >((int16_t)BTS_USER_DEFAULT_TRIP_16b)){
            EPWM_setActionQualifierContSWForceAction(EPWM_BASE,EPWM_AQ_OUTPUT_A,EPWM_AQ_SW_OUTPUT_LOW);
            ctrlLoopVariable->dutyH_pu = 0;
            ctrlLoopVariable->dutyL_pu = ctrlLoopVariable->dutySet_pu;
        }
        else{
            EPWM_setActionQualifierContSWForceAction(BTS_DRV_EPWM_BASE,EPWM_AQ_OUTPUT_A,EPWM_AQ_SW_DISABLED);
            ctrlLoopVariable->dutyH_pu = ctrlLoopVariable->dutySet_pu;
            ctrlLoopVariable->dutyL_pu = ctrlLoopVariable->dutySet_pu;
        }

    }

    ctrlLoopVariable->dutyH_pu = ctrlLoopVariable->dutySet_pu;
    ctrlLoopVariable->dutyL_pu = ctrlLoopVariable->dutySet_pu;

}

#pragma FUNC_ALWAYS_INLINE(BTS_ctrlISR)
static inline void BTS_ctrlISR(BTS_DCL_CTRL_TYPE* ctrl_cc, BTS_DCL_CTRL_TYPE* ctrl_cv, uint32_t EPWM_BASE, BTS_ctrlLoopVariable *ctrlLoopVariable, int16_t current_16b, int16_t voltage_16b){

#if(BTS_TRIP_CODE)
    BTS_tripEpwm(EPWM_BASE, ctrl_cc, ctrlLoopVariable, current_16b);

#endif


    ctrlLoopVariable->ioutSense_pu= (float32_t)((int16_t)current_16b)/32768.0f;
    ctrlLoopVariable->voutSense_pu= (float32_t)((int16_t)voltage_16b)/32768.0f;


#if(BTS_ISR_MODE == BTS_ISR_MODE_CLOSED_LOOP)


#if((BTS_ISR_CL_MODE == BTS_ISR_CL_MODE_CCCV)|| (BTS_ISR_CL_MODE == BTS_ISR_CL_MODE_CV))

#if(BTS_SFRA_ENABLED== (false))
    ctrlLoopVariable->voutSet_pu= ctrlLoopVariable->voutRef_pu;
#endif
    ctrlLoopVariable->ek_cv_pu = ctrlLoopVariable->direction_coeff *(ctrlLoopVariable->voutSet_pu - ctrlLoopVariable->voutSense_pu);
    ctrlLoopVariable->uk_cv_pu = BTS_DCL_RUN_IMMEDIATE(ctrl_cv, ctrlLoopVariable->ek_cv_pu);

    //only update when current is in limit
    if (BTS_DCL_RUN_CLAMP(&(ctrlLoopVariable->uk_cv_pu),ctrlLoopVariable->ioutRef_pu, -1.0*ctrlLoopVariable->ioutRef_pu) ==0){
        //record current command
        ctrlLoopVariable->ioutSet_pu = ctrlLoopVariable->uk_cv_pu;

         BTS_DCL_RUN_PARTIAL(ctrl_cv,
                              ctrlLoopVariable->ek_cv_pu,
                              ctrlLoopVariable->uk_cv_pu);
     }
     else{
         if(ctrlLoopVariable->uk_cv_pu <= BTS_ISET_MIN_PU)
             {
             ctrlLoopVariable->ioutSet_pu = BTS_ISET_MIN_PU;
             }
             if(ctrlLoopVariable->uk_cv_pu >= BTS_ISET_MAX_PU)
             {
                 ctrlLoopVariable->ioutSet_pu = BTS_ISET_MAX_PU;
             }
     }

#endif

#if(BTS_ISR_CL_MODE == BTS_ISR_CL_MODE_CCCV)
    if(ctrlLoopVariable->ek_cv_pu<-0.001){
        ctrlLoopVariable->ioutSet_pu = ctrlLoopVariable->direction_coeff*ctrlLoopVariable->uk_cv_pu;
        ctrlLoopVariable->ctrlMode_logic=1;
    }
    else if(ctrlLoopVariable->ek_cv_pu>0.1)
    {
        ctrlLoopVariable->ioutSet_pu = ctrlLoopVariable->direction_coeff* ctrlLoopVariable->ioutRef_pu;
//        ctrlLoopVariable->ioutSet_pu=  BUCK_SFRA_INJECT(ctrlLoopVariable->ioutRef_pu);
        ctrlLoopVariable->ctrlMode_logic=0;
    }
//    ctrlLoopVariable->ioutSet_pu=  BUCK_SFRA_INJECT(ctrlLoopVariable->ioutRef_pu);

#elif(BTS_ISR_CL_MODE == BTS_ISR_CL_MODE_CV)
    ctrlLoopVariable->ioutSet_pu = ctrlLoopVariable->direction_coeff*ctrlLoopVariable->uk_cv_pu;
    ctrlLoopVariable->ctrlMode_logic=1;

#elif(BTS_ISR_CL_MODE == BTS_ISR_CL_MODE_CC)
#if(BTS_SFRA_ENABLED== (false))
    ctrlLoopVariable->ioutSet_pu = ctrlLoopVariable->direction_coeff* ctrlLoopVariable->ioutRef_pu;
#endif
    ctrlLoopVariable->ctrlMode_logic=0;

#endif


#if((BTS_ISR_CL_MODE == BTS_ISR_CL_MODE_CCCV)||(BTS_ISR_CL_MODE == BTS_ISR_CL_MODE_CV)||(BTS_ISR_CL_MODE == BTS_ISR_CL_MODE_CC))

    ctrlLoopVariable->ek_cc_pu = (ctrlLoopVariable->ioutSet_pu - ctrlLoopVariable->ioutSense_pu);
    //         Calculate the required control effort (duty cycle)
    ctrlLoopVariable->uk_cc_pu = BTS_DCL_RUN_IMMEDIATE(ctrl_cc, ctrlLoopVariable->ek_cc_pu);

        if(BTS_DCL_RUN_CLAMP(&(ctrlLoopVariable->uk_cc_pu),BTS_DUTY_SET_MAX_PU, BTS_DUTY_SET_MIN_PU) == 0){
            //         Only update the duty cycle if the control effort is within range
            ctrlLoopVariable->dutySet_pu = ctrlLoopVariable->uk_cc_pu;
            BTS_ctrlDirection(EPWM_BASE, ctrlLoopVariable, current_16b);

            BTS_HAL_updateDuty(EPWM_BASE, ctrlLoopVariable->dutyH_pu,ctrlLoopVariable->dutyL_pu);
            BTS_DCL_RUN_PARTIAL(ctrl_cc,
                                 ctrlLoopVariable->ek_cc_pu,
                                 ctrlLoopVariable->uk_cc_pu);
        }
        else{
            if(ctrlLoopVariable->uk_cc_pu <= BTS_DUTY_SET_MIN_PU)
            {
                ctrlLoopVariable->dutySet_pu = BTS_DUTY_SET_MIN_PU;
                BTS_HAL_updateDuty(EPWM_BASE,BTS_DUTY_SET_MIN_PU,BTS_DUTY_SET_MIN_PU);
                ctrlLoopVariable->dutySet_pu = BTS_DUTY_SET_MIN_PU;
            }
            if(ctrlLoopVariable->uk_cc_pu >= BTS_DUTY_SET_MAX_PU)
            {
                ctrlLoopVariable->dutySet_pu = BTS_DUTY_SET_MAX_PU;
                BTS_HAL_updateDuty(EPWM_BASE,BTS_DUTY_SET_MAX_PU,BTS_DUTY_SET_MAX_PU);
                ctrlLoopVariable->dutySet_pu = BTS_DUTY_SET_MAX_PU;
            }

        }
#endif

#endif

/*
 * OPEN LOOP BUCK
 * DUTY CONTROL
 */

#if(BTS_ISR_MODE == BTS_ISR_MODE_OPEN_LOOP)

#if(BTS_SFRA_ENABLED== (false))
    ctrlLoopVariable->dutySet_pu = ctrlLoopVariable->dutySetRef_pu;
#endif
    if(ctrlLoopVariable->dutySet_pu <= BTS_DUTY_SET_MIN_PU)
    {
        BTS_HAL_updateDuty(EPWM_BASE,BTS_DUTY_SET_MIN_PU,BTS_DUTY_SET_MIN_PU);
        ctrlLoopVariable->dutySet_pu = BTS_DUTY_SET_MIN_PU;
    }
    if(ctrlLoopVariable->dutySet_pu >= BTS_DUTY_SET_MAX_PU)
    {
        BTS_HAL_updateDuty(EPWM_BASE,BTS_DUTY_SET_MAX_PU,BTS_DUTY_SET_MAX_PU);
        ctrlLoopVariable->dutySet_pu = BTS_DUTY_SET_MAX_PU;
    }

    BTS_ctrlDirection(EPWM_BASE, ctrlLoopVariable,current_16b);

    BTS_HAL_updateDuty(EPWM_BASE, ctrlLoopVariable->dutyH_pu,ctrlLoopVariable->dutyL_pu);

#if(BTS_SFRA_ENABLED)
    //BTS_SFRA_COLLECT(&(ctrlLoopVariable->dutySet_pu),
    //                  &(ctrlLoopVariable->ioutSense_pu));

#endif

#endif


}



#pragma FUNC_ALWAYS_INLINE(BTS_ISR_SFRA)
static inline void BTS_ISR_SFRA(void){

#if(BTS_SFRA_ENABLED == (true))
//SFRA INJECT
#if(BTS_SFRA_CAPTURE_SETTINGS == BTS_SFRA_CAPTURE_DUTY_IOUT)
    BTS_ctrlLoopVariable_chx.dutySet_pu = BTS_SFRA_INJECT(BTS_ctrlLoopVariable_chx.dutySetRef_pu);
#elif((BTS_SFRA_CAPTURE_SETTINGS == BTS_SFRA_CAPTURE_ISET_IOUT) ||(BTS_SFRA_CAPTURE_SETTINGS == BTS_SFRA_CAPTURE_ISET_VOUT))
    BTS_ctrlLoopVariable_chx.ioutSet_pu = BTS_SFRA_INJECT(BTS_ctrlLoopVariable_chx.ioutRef_pu);
#elif(BTS_SFRA_CAPTURE_SETTINGS ==BTS_SFRA_CAPTURE_VSET_VOUT)
    BTS_ctrlLoopVariable_chx.voutSet_pu = BTS_SFRA_INJECT(BTS_ctrlLoopVariable_chx.voutRef_pu);
#endif

    BTS_storeValues(&BTS_measValues_chx,BTS_ADC_current, BTS_ADC_voltage);

#if(BTS_ENABLE_SWITCH)
    BTS_detectEnable(EPWMx_BASE,&BTS_ctrlLoopVariable_chx , &BTS_userInput_chx);
#endif

    BTS_ctrlISR(&BTS_ctrl_cc_chx,&BTS_ctrl_cv_chx,EPWMx_BASE, &BTS_ctrlLoopVariable_chx, BTS_ADC_current, BTS_ADC_voltage);

    //SFRA COLLECT
#if(BTS_SFRA_CAPTURE_SETTINGS == BTS_SFRA_CAPTURE_DUTY_IOUT)
    BTS_SFRA_COLLECT(&(BTS_ctrlLoopVariable_chx.dutySet_pu),&(BTS_ctrlLoopVariable_chx.ioutSense_pu));
#elif((BTS_SFRA_CAPTURE_SETTINGS == BTS_SFRA_CAPTURE_ISET_IOUT))
    BTS_SFRA_COLLECT(&(BTS_ctrlLoopVariable_chx.ioutSet_pu),&(BTS_ctrlLoopVariable_chx.ioutSense_pu));
#elif((BTS_SFRA_CAPTURE_SETTINGS ==BTS_SFRA_CAPTURE_ISET_VOUT))
    BTS_SFRA_COLLECT(&(BTS_ctrlLoopVariable_chx.ioutSet_pu),&(BTS_ctrlLoopVariable_chx.voutSense_pu));
#elif((BTS_SFRA_CAPTURE_SETTINGS ==BTS_SFRA_CAPTURE_VSET_VOUT))
    BTS_SFRA_COLLECT(&(BTS_ctrlLoopVariable_chx.voutSet_pu),&(BTS_ctrlLoopVariable_chx.voutSense_pu));
#endif

#endif
}

#pragma FUNC_ALWAYS_INLINE(BTS_runISR_ch1_4)
static inline void BTS_runISR_ch1_4(void){

    if (BTS_ExAdcRxflag1 == 1) {
        BTS_ExAdcSendTxFrame_ch1_4();
#if (BTS_SFRA_ENABLED == true) && ( BTS_SFRA_ISR_SRC == BTS_SFRA_ISR_SRC_ADC) && ( BTS_SFRA_CHANNEL <= 4)
        BTS_ISR_SFRA();
#endif
    }

#if(BTS_SFRA_ENABLED ==(false))

#if(BTS_ENABLE_CH1)
    BTS_storeValues(&BTS_measValues_ch1,BTS_ADC1.channel0, BTS_ADC1.channel1);
#if(BTS_ENABLE_DETECT_CODE)
    BTS_detectEnable(EPWM1_BASE,&BTS_ctrlLoopVariable_ch1 , &BTS_userInput_ch1);
#endif
    BTS_ctrlISR(&BTS_ctrl_cc_ch1,&BTS_ctrl_cv_ch1,EPWM1_BASE, &BTS_ctrlLoopVariable_ch1, BTS_ADC1.channel0, BTS_ADC1.channel1);
#endif

#if(BTS_ENABLE_CH2)
    BTS_storeValues(&BTS_measValues_ch2,BTS_ADC1.channel2, BTS_ADC1.channel3);
#if(BTS_ENABLE_DETECT_CODE)
    BTS_detectEnable(EPWM2_BASE,&BTS_ctrlLoopVariable_ch2 , &BTS_userInput_ch2);
#endif
    BTS_ctrlISR(&BTS_ctrl_cc_ch2,&BTS_ctrl_cv_ch2,EPWM2_BASE, &BTS_ctrlLoopVariable_ch2, BTS_ADC1.channel2, BTS_ADC1.channel3);
#endif

#if(BTS_ENABLE_CH3)
    BTS_storeValues(&BTS_measValues_ch3,BTS_ADC1.channel4, BTS_ADC1.channel5);
#if(BTS_ENABLE_DETECT_CODE)
    BTS_detectEnable(EPWM3_BASE,&BTS_ctrlLoopVariable_ch3 , &BTS_userInput_ch3);
#endif
    BTS_ctrlISR(&BTS_ctrl_cc_ch3,&BTS_ctrl_cv_ch3,EPWM3_BASE, &BTS_ctrlLoopVariable_ch3, BTS_ADC1.channel4, BTS_ADC1.channel5);
#endif

#if(BTS_ENABLE_CH4)
    BTS_storeValues(&BTS_measValues_ch4,BTS_ADC1.channel6, BTS_ADC1.channel7);
#if(BTS_ENABLE_DETECT_CODE)
    BTS_detectEnable(EPWM4_BASE,&BTS_ctrlLoopVariable_ch4 , &BTS_userInput_ch4);
#endif
    BTS_ctrlISR(&BTS_ctrl_cc_ch4,&BTS_ctrl_cv_ch4,EPWM4_BASE, &BTS_ctrlLoopVariable_ch4, BTS_ADC1.channel6, BTS_ADC1.channel7);
#endif

#endif

    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP1);                    // Acknowledge the interrupt

}

#pragma FUNC_ALWAYS_INLINE(BTS_runISR_ch5_8)
static inline void BTS_runISR_ch5_8(void){

    BTS_ExAdcSendTxFrame_ch5_8();

#if (BTS_SFRA_ENABLED == true) && ( BTS_SFRA_ISR_SRC == BTS_SFRA_ISR_SRC_ADC) && ( BTS_SFRA_CHANNEL >= 5)
        BTS_ISR_SFRA();
#endif

#if(BTS_SFRA_ENABLED ==(false))

#if(BTS_ENABLE_CH5)
    BTS_storeValues(&BTS_measValues_ch5,BTS_ADC2.channel0, BTS_ADC2.channel1);
#if(BTS_ENABLE_DETECT_CODE)
    BTS_detectEnable(EPWM5_BASE,&BTS_ctrlLoopVariable_ch5 , &BTS_userInput_ch5);
#endif
    BTS_ctrlISR(&BTS_ctrl_cc_ch5,&BTS_ctrl_cv_ch5,EPWM5_BASE, &BTS_ctrlLoopVariable_ch5, BTS_ADC2.channel0, BTS_ADC2.channel1);
#endif

#if(BTS_ENABLE_CH6)
    BTS_storeValues(&BTS_measValues_ch6,BTS_ADC2.channel2, BTS_ADC2.channel3);
#if(BTS_ENABLE_DETECT_CODE)
    BTS_detectEnable(EPWM6_BASE,&BTS_ctrlLoopVariable_ch6 , &BTS_userInput_ch6);
#endif
    BTS_ctrlISR(&BTS_ctrl_cc_ch6,&BTS_ctrl_cv_ch6,EPWM6_BASE, &BTS_ctrlLoopVariable_ch6, BTS_ADC2.channel2, BTS_ADC2.channel3);
#endif

#if(BTS_ENABLE_CH7)
    BTS_storeValues(&BTS_measValues_ch7,BTS_ADC2.channel4, BTS_ADC2.channel5);
#if(BTS_ENABLE_DETECT_CODE)
    BTS_detectEnable(EPWM7_BASE,&BTS_ctrlLoopVariable_ch7 , &BTS_userInput_ch7);
#endif
    BTS_ctrlISR(&BTS_ctrl_cc_ch7,&BTS_ctrl_cv_ch7,EPWM7_BASE, &BTS_ctrlLoopVariable_ch7, BTS_ADC2.channel4, BTS_ADC2.channel5);
#endif

#if(BTS_ENABLE_CH8)
    BTS_storeValues(&BTS_measValues_ch8,BTS_ADC2.channel6, BTS_ADC2.channel7);
#if(BTS_ENABLE_DETECT_CODE)
    BTS_detectEnable(EPWM8_BASE,&BTS_ctrlLoopVariable_ch8 , &BTS_userInput_ch8);
#endif
    BTS_ctrlISR(&BTS_ctrl_cc_ch8,&BTS_ctrl_cv_ch8,EPWM8_BASE, &BTS_ctrlLoopVariable_ch8, BTS_ADC2.channel6, BTS_ADC2.channel7);
#endif

#endif

    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP1);                    // Acknowledge the interrupt

}


#ifdef __cplusplus
}
#endif                                  /* extern "C" */

#endif
