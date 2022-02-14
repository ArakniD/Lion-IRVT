//#############################################################################
//
// FILE:   ttplpfc_hal.h
//
// TITLE: This is the solution header file.
//
//#############################################################################
// $TI Release: TIDM_1007 v1.00.02.00 $
// $Release Date: Tue Mar 23 14:55:26 CDT 2021 $
// $Copyright:
// Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
//
// ALL RIGHTS RESERVED
// $
//#############################################################################

#ifndef TTPLPFC_HAL_H
#define TTPLPFC_HAL_H

#ifdef __cplusplus

extern "C" {
#endif


//
// the includes
//

//
// Include files for device support, F2806x in this case
//
#include "inc/hw_types.h"
#include "driverlib.h"
#include "device.h"
#include "ttplpfc_settings.h"


void TTPLPFC_HAL_setupDevice(void);
void TTPLPFC_HAL_setupPWM(uint32_t base1, uint32_t base2, uint32_t base3,
                           uint32_t base4, uint16_t pwm_period_ticks,
                           uint16_t pwm_dbred_ticks, uint16_t pwm_dbfed_ticks);

void TTPLPFC_HAL_setupADC(void);

void TTPLPFC_HALconfigurePWM1chUpCnt(uint32_t n, uint16_t period);
void TTPLPFC_HAL_setupBoardProtection(uint32_t base1, uint32_t base2,
                                      uint32_t base3,
                          uint32_t base4, float32_t current_limit,
                          float32_t current_max_sense);
void TTPLPFC_HAL_setupCMPSS(uint32_t base1, float32_t current_limit,
                            float32_t current_max_sense );

void TTPLPFC_calibrateOffset(volatile float32_t *ac_cur_sensedOffset,
                                   volatile float32_t *IL1c_sensedOffset,
                                   volatile float32_t *IL2c_sensedOffset ,
                                   volatile float32_t *IL3c_sensedOffset ,
                                   float32_t k1, float32_t k2);
void TTPLPFC_HAL_setupProfilingGPIO(void);
void TTPLPFC_HAL_setupRelayGPIO(void);
void TTPLPFC_HAL_toggleLED(void);
void TTPLPFC_HAL_setupLEDGPIO(void);
void TTPLPFC_HAL_disablePWMCLKCounting(void);
void TTPLPFC_HAL_enablePWMCLKCounting(void);
void TTPLPFC_HAL_setupTrigForADC(void);


void TTPLPFC_HAL_setupGainChangeGPIO(void);

void TTPLPFC_HAL_setupEPWMtoTriggerADCSOC(uint32_t base);

void TTPLPFC_HAL_setPinsAsPWM();

void TTPLPFC_HAL_setupCLA(void);

//
// Function Prototypes
//
//
//CLA C Tasks defined in Cla1Tasks_C.cla
//
__attribute__((interrupt))  void Cla1Task1();
__attribute__((interrupt))  void Cla1Task2();
__attribute__((interrupt))  void Cla1Task3();
__attribute__((interrupt))  void Cla1Task4();
__attribute__((interrupt))  void Cla1Task5();
__attribute__((interrupt))  void Cla1Task6();
__attribute__((interrupt))  void Cla1Task7();
__attribute__((interrupt))  void Cla1BackgroundTask();

extern uint16_t Cla1ProgLoadStart;
extern uint16_t Cla1ProgLoadEnd;
extern uint16_t Cla1ProgLoadSize;
extern uint16_t Cla1ProgRunStart;
extern uint16_t Cla1ProgRunEnd;
extern uint16_t Cla1ProgRunSize;

//
// ISR related
//
#if TTPLPFC_CONTROL_RUNNING_ON == C28x_CORE

#ifndef __TMS320C28XX_CLA__
    #pragma INTERRUPT (ISR1, HPI)
    #pragma CODE_SECTION(ISR1,"isrcodefuncs");
    interrupt void ISR1(void);
    static inline void TTPLPFC_HAL_clearISR1InterruptFlag(
            uint16_t pie_group_no);
    static inline void TTPLPFC_HAL_setupInterrupt(void);
#endif

#endif

#if TTPLPFC_INSTRUMENTATION_ISR_RUNNING_ON == C28x_CORE

#ifndef __TMS320C28XX_CLA__
    #pragma CODE_SECTION(ISR2,"ramfuncs");
    interrupt void ISR2(void);
    static inline void TTPLPFC_HAL_clearISR1InterruptFlag(
            uint16_t pie_group_no);
    static inline void TTPLPFC_HAL_setupInterrupt(void);
#endif

#endif

//
// Inline functions
//

static inline void TTPLPFC_HAL_EPWM_setCounterCompareValueOptimized(
        uint32_t base, EPWM_CounterCompareModule compModule, uint16_t compCount)
{
    uint32_t registerOffset;

    //
    // Get the register offset for the Counter compare
    //
    registerOffset = EPWM_O_CMPA + (uint16_t)compModule;

    //
    // Write to the counter compare registers.
    //
    #pragma diag_suppress = 770
    #pragma diag_suppress = 173
    if((compModule == EPWM_COUNTER_COMPARE_A) ||
    (compModule == EPWM_COUNTER_COMPARE_B))
    {
        //
        // write to CMPA or COMPB bits
        //
        HWREGH(base + registerOffset + 1) = (uint16_t)compCount;
    }
    else
    {
        //
        // write to COMPC or COMPD bits
        //
        HWREGH(base + registerOffset) = compCount;
    }
    #pragma diag_warning = 770
    #pragma diag_warning = 173
}

static inline void TTPLPFC_HAL_setupECAPforProfilingCode(void)
{

    //
    // Route profiling GPIO through INPUTXBAR
    //
    XBAR_setInputPin(TTPLPFC_PROFILING1_INPUTXBAR, TTPLPFC_GPIO_PROFILING1);
    XBAR_setInputPin(TTPLPFC_PROFILING2_INPUTXBAR, TTPLPFC_GPIO_PROFILING2);


    //
    // Configure ECAP to measure the rising to falling edge pulse
    //
    ECAP_disableTimeStampCapture(TTPLPFC_PROFILING1_ECAP);

    ECAP_stopCounter(TTPLPFC_PROFILING1_ECAP);
    ECAP_enableCaptureMode(TTPLPFC_PROFILING1_ECAP);

    ECAP_setCaptureMode(TTPLPFC_PROFILING1_ECAP, ECAP_CONTINUOUS_CAPTURE_MODE,
                        ECAP_EVENT_4);

    ECAP_setEventPolarity(TTPLPFC_PROFILING1_ECAP, ECAP_EVENT_1,
                          ECAP_EVNT_FALLING_EDGE);
    ECAP_setEventPolarity(TTPLPFC_PROFILING1_ECAP, ECAP_EVENT_2,
                          ECAP_EVNT_RISING_EDGE);
    ECAP_setEventPolarity(TTPLPFC_PROFILING1_ECAP, ECAP_EVENT_3,
                          ECAP_EVNT_FALLING_EDGE);
    ECAP_setEventPolarity(TTPLPFC_PROFILING1_ECAP, ECAP_EVENT_4,
                          ECAP_EVNT_RISING_EDGE);

    ECAP_enableCounterResetOnEvent(TTPLPFC_PROFILING1_ECAP, ECAP_EVENT_1);
    ECAP_enableCounterResetOnEvent(TTPLPFC_PROFILING1_ECAP, ECAP_EVENT_2);
    ECAP_enableCounterResetOnEvent(TTPLPFC_PROFILING1_ECAP, ECAP_EVENT_3);
    ECAP_enableCounterResetOnEvent(TTPLPFC_PROFILING1_ECAP, ECAP_EVENT_4);

    ECAP_startCounter(TTPLPFC_PROFILING1_ECAP);
    ECAP_enableTimeStampCapture(TTPLPFC_PROFILING1_ECAP);
    ECAP_reArm(TTPLPFC_PROFILING1_ECAP);


    ECAP_disableTimeStampCapture(TTPLPFC_PROFILING2_ECAP);

    ECAP_stopCounter(TTPLPFC_PROFILING2_ECAP);
    ECAP_enableCaptureMode(TTPLPFC_PROFILING2_ECAP);

    ECAP_setCaptureMode(TTPLPFC_PROFILING2_ECAP, ECAP_CONTINUOUS_CAPTURE_MODE,
                        ECAP_EVENT_4);

    ECAP_setEventPolarity(TTPLPFC_PROFILING2_ECAP, ECAP_EVENT_1,
                          ECAP_EVNT_FALLING_EDGE);
    ECAP_setEventPolarity(TTPLPFC_PROFILING2_ECAP, ECAP_EVENT_2,
                          ECAP_EVNT_RISING_EDGE);
    ECAP_setEventPolarity(TTPLPFC_PROFILING2_ECAP, ECAP_EVENT_3,
                          ECAP_EVNT_FALLING_EDGE);
    ECAP_setEventPolarity(TTPLPFC_PROFILING2_ECAP, ECAP_EVENT_4,
                          ECAP_EVNT_RISING_EDGE);

    ECAP_enableCounterResetOnEvent(TTPLPFC_PROFILING2_ECAP, ECAP_EVENT_1);
    ECAP_enableCounterResetOnEvent(TTPLPFC_PROFILING2_ECAP, ECAP_EVENT_2);
    ECAP_enableCounterResetOnEvent(TTPLPFC_PROFILING2_ECAP, ECAP_EVENT_3);
    ECAP_enableCounterResetOnEvent(TTPLPFC_PROFILING2_ECAP, ECAP_EVENT_4);

    ECAP_startCounter(TTPLPFC_PROFILING2_ECAP);
    ECAP_enableTimeStampCapture(TTPLPFC_PROFILING2_ECAP);
    ECAP_reArm(TTPLPFC_PROFILING2_ECAP);

    //
    // Recognize the XBAR as ECAP input
    //
    ECAP_selectECAPInput(TTPLPFC_PROFILING1_ECAP,
                       (ECAP_InputCaptureSignals)TTPLPFC_PROFILING1_ECAP_XBAR_MUX);
    ECAP_selectECAPInput(TTPLPFC_PROFILING2_ECAP,
                       (ECAP_InputCaptureSignals)TTPLPFC_PROFILING2_ECAP_XBAR_MUX);

}

static inline void TTPLPFC_HAL_updatePWM(uint32_t base1, uint32_t base2,
                                    uint32_t base3, uint32_t base4,
                                    float32_t duty, float32_t phase1ScaleFactor,
                                    float32_t phase2ScaleFactor,
                                    float32_t phase3ScaleFactor)
{
    uint32_t dutyPWMReg;

    dutyPWMReg = (uint32_t)((float32_t)(TTPLPFC_PWM_PERIOD / 2.0) *
            fabsf(duty));

    TTPLPFC_HAL_EPWM_setCounterCompareValueOptimized(base2,
                   EPWM_COUNTER_COMPARE_A, (uint32_t)((float32_t)dutyPWMReg *
                           (float32_t)phase1ScaleFactor));
    TTPLPFC_HAL_EPWM_setCounterCompareValueOptimized(base3,
                   EPWM_COUNTER_COMPARE_A, (uint32_t)((float32_t)dutyPWMReg *
                           (float32_t)phase2ScaleFactor));
    TTPLPFC_HAL_EPWM_setCounterCompareValueOptimized(base4,
                   EPWM_COUNTER_COMPARE_A, (uint32_t)((float32_t)dutyPWMReg *
                           (float32_t)phase3ScaleFactor));

}

static inline void TTPLPFC_HAL_closeRelay(void)
{
    HWREG(GPIODATA_BASE  + GPIO_O_GPASET ) = TTPLPFC_GPIO_RELAY_SET;
}

static inline void TTPLPFC_HAL_openRelay(void)
{
    HWREG(GPIODATA_BASE  + GPIO_O_GPACLEAR ) = TTPLPFC_GPIO_RELAY_CLEAR;
}

static inline void TTPLPFC_HAL_gainHighSetforLowCurrent(void)
{
    GPIO_writePin(TTPLPFC_GPIO_I_SENSE_GAIN_ADJUST, 1);
}

static inline void TTPLPFC_HAL_gainLowSetforHighCurrent(void)
{
    GPIO_writePin(TTPLPFC_GPIO_I_SENSE_GAIN_ADJUST, 0);
}

static inline void TTPLPFC_HAL_setProfilingGPIO(void)
{
    #pragma diag_suppress = 770
    #pragma diag_suppress = 173
    HWREG(GPIODATA_BASE + GPIO_O_GPASET ) = TTPLPFC_GPIO_PROFILING1_SET;
    #pragma diag_warning = 770
    #pragma diag_warning = 173
}

static inline void TTPLPFC_HAL_resetProfilingGPIO(void)
{
    #pragma diag_suppress = 770
    #pragma diag_suppress = 173
    HWREG(GPIODATA_BASE + GPIO_O_GPACLEAR ) = TTPLPFC_GPIO_PROFILING1_CLEAR;
    #pragma diag_warning = 770
    #pragma diag_warning = 173
}

static inline void TTPLPFC_HAL_setProfilingGPIO2(void)
{
    #pragma diag_suppress = 770
    #pragma diag_suppress = 173
    HWREG(GPIODATA_BASE + GPIO_O_GPASET ) = TTPLPFC_GPIO_PROFILING2_SET;
    #pragma diag_warning = 770
    #pragma diag_warning = 173
}

static inline void TTPLPFC_HAL_resetProfilingGPIO2(void)
{
    #pragma diag_suppress = 770
    #pragma diag_suppress = 173
    HWREG(GPIODATA_BASE + GPIO_O_GPACLEAR ) = TTPLPFC_GPIO_PROFILING2_CLEAR;
    #pragma diag_warning = 770
    #pragma diag_warning = 173
}

static inline void TTPLPFC_HAL_clearPWMTripFlags(uint32_t base)
{
    //
    // clear all the configured trip sources for the PWM module
    //
    EPWM_clearTripZoneFlag(base,
                           ( EPWM_TZ_INTERRUPT_OST |
                             EPWM_TZ_INTERRUPT_CBC |
                             EPWM_TZ_INTERRUPT_DCAEVT1 )
                           );
}

static inline void clearOSTPWMTripFlag(uint32_t base)
{
    //
    // clear all the configured trip sources for the PWM module
    //
    EPWM_clearTripZoneFlag(base, EPWM_TZ_INTERRUPT_OST);
}

#pragma FUNC_ALWAYS_INLINE(TTPLPFC_HAL_forceOSTPWMTrip)
static inline void TTPLPFC_HAL_forceOSTPWMTrip(uint32_t base)
{
    EPWM_forceTripZoneEvent(base, EPWM_TZ_FORCE_EVENT_OST);
}

static inline void TTPLPFC_HAL_clearPWMInterruptFlag(uint32_t base)
{
    EPWM_clearEventTriggerInterruptFlag(base);
}

static inline void TTPLPFC_HAL_enablePWMInterruptGeneration(uint32_t base)
{
    EPWM_setInterruptSource(base, EPWM_INT_TBCTR_D_CMPB);
    EPWM_setInterruptEventCount(base, TTPLPFC_CNTRL_ISR_FREQ_RATIO);
    EPWM_enableInterrupt(base);
    EPWM_clearEventTriggerInterruptFlag(base);
}


#ifndef __TMS320C28XX_CLA__
static inline void TTPLPFC_HAL_clearISR1InterruptFlag(uint16_t pie_group_no)
{
    Interrupt_clearACKGroup(pie_group_no);
}


static inline void TTPLPFC_HAL_setupInterrupt(void)
{
    CPUTimer_enableInterrupt(
            TTPLPFC_C28x_INSTRUMENTATION_INTERRUPT_TRIG_CPUTIMER_BASE
            );
    CPUTimer_clearOverflowFlag(
            TTPLPFC_C28x_INSTRUMENTATION_INTERRUPT_TRIG_CPUTIMER_BASE
            );

#if TTPLPFC_CONTROL_RUNNING_ON == C28x_CORE
    Interrupt_register(TTPLPFC_C28x_CONTROLISR_INTERRUPT, &ISR1);
    TTPLPFC_HAL_enablePWMInterruptGeneration(
            TTPLPFC_C28x_CONTROLISR_INTERRUPT_TRIG_PWM_BASE);
    TTPLPFC_HAL_clearISR1InterruptFlag(
            TTPLPFC_C28x_CONTROLISR_INTERRUPT_PIE_GROUP_NO);
    Interrupt_enable(TTPLPFC_C28x_CONTROLISR_INTERRUPT);
#endif

#if TTPLPFC_INSTRUMENTATION_ISR_RUNNING_ON == C28x_CORE
    Interrupt_register(TTPLPFC_C28x_INSTRUMENTATION_INTERRUPT, &ISR2);
    Interrupt_enable(TTPLPFC_C28x_INSTRUMENTATION_INTERRUPT);
#endif

#if TTPLPFC_CONTROL_RUNNING_ON == CLA_CORE ||                                  \
    TTPLPFC_INSTRUMENTATION_ISR_RUNNING_ON == CLA_CORE
    TTPLPFC_HAL_setupCLA();
#endif

    EALLOW;

    //
    //Enable Global interrupt INTM
    //
    EINT;

    //
    //Enable Global realtime interrupt DBGM
    //
    ERTM;
    EDIS;
}

#endif

#ifdef __cplusplus
}
#endif


#endif
