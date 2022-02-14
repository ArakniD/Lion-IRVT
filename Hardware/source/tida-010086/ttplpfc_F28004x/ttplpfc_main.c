//#############################################################################
//
// FILE:   ttplpfc_main.c
//
// TITLE: This is the main file for the solution, following is the
//         <solution>.c -> solution source file
//         <solution>.h -> solution header file
//         <solution>_settings.h -> powerSUITE generated settings
//         <boad name>_hal.c -> board drivers source file
//         <boad name>_hal.h -> board drivers header file
//         <optional>
//         <solution>_cla.cla -> cla task file
//
//#############################################################################
// $TI Release:
// $Release Date:
// $Copyright:
// Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
//
// ALL RIGHTS RESERVED
// $
//#############################################################################

//*****************************************************************************
// the includes
//*****************************************************************************

#include "ttplpfc.h"

//
// State Machine Related
//

//
// Virtual Timers slaved off CPU Timer 0 (A events)
//
int16_t vTimer0[4];

//
// Virtual Timers slaved off CPU Timer 1 (B events)
//
int16_t vTimer1[4];

//
// Virtual Timers slaved off CPU Timer 2 (C events)
//
int16_t vTimer2[4];

//
// Variable declarations for state machine
//
void (*Alpha_State_Ptr)(void);
void (*A_Task_Ptr)(void);
void (*B_Task_Ptr)(void);
void (*C_Task_Ptr)(void);

//
// State Machine function prototypes
//

//
// Alpha states
//
void A0(void);
void B0(void);

//
// A branch states
//
void A1(void);

//
// B branch states
//
void B1(void);
void B2(void);
void B3(void);

//
// Note that the watchdog is disabled in codestartbranch.asm
// for this project. This is to prevent it from expiring while
// c_init routine initializes the global variables before
// reaching the main()
//

void main(void)
{
    //
    // This routine sets up the basic device configuration such as
    // initializing PLL, copying code from FLASH to RAM,
    // this routine will also initialize the CPU timers that are used in
    // the background task for this system
    //
    TTPLPFC_HAL_setupDevice();

    //
    // Tasks State-machine init
    //
    Alpha_State_Ptr = &A0;
    A_Task_Ptr = &A1;
    B_Task_Ptr = &B1;

    //
    // Stop all PWM mode clock
    //
    TTPLPFC_HAL_disablePWMCLKCounting();

    TTPLPFC_HAL_setupPWM(TTPLPFC_LOW_FREQ_PWM_BASE, TTPLPFC_HIGH_FREQ_PWM1_BASE,
                         TTPLPFC_HIGH_FREQ_PWM2_BASE,
                         TTPLPFC_HIGH_FREQ_PWM3_BASE,
                         TTPLPFC_PWM_PERIOD,
                         TTPLPFC_HIGH_FREQ_PWM_DEADBAND_RED_COUNT,
                         TTPLPFC_HIGH_FREQ_PWM_DEADBAND_FED_COUNT);

    //
    // power up ADC on the device
    //
    TTPLPFC_HAL_setupADC();


    //
    // Profiling GPIO
    //
    TTPLPFC_HAL_setupProfilingGPIO();

    //
    //profiling eCAP
    //
    TTPLPFC_HAL_setupECAPforProfilingCode();

    //
    //configure LED GPIO
    //
    TTPLPFC_HAL_setupLEDGPIO();

    //
    //configure Relay GPIO
    //
    TTPLPFC_HAL_setupRelayGPIO();

    //
    //configure gain change GPIO
    //
    TTPLPFC_HAL_setupGainChangeGPIO();
    TTPLPFC_HAL_gainLowSetforHighCurrent();

    //
    // Initialize global variables
    //
    TTPLPFC_globalVariablesInit();

#if TTPLPFC_SFRA_TYPE == TTPLPFC_SFRA_DISABLED
#else
    TTPLPFC_setupSFRA();
#endif

    //
    // Enable PWM Clocks
    //
    TTPLPFC_HAL_enablePWMCLKCounting();

    TTPLPFC_HAL_setupTrigForADC();

    //
    // Offset Calibration Routine
    //
    TTPLPFC_calibrateOffset(&TTPLPFC_ac_cur_senseOffset_pu,
                            &TTPLPFC_iL1_senseOffset_pu,
                            &TTPLPFC_iL2_senseOffset_pu,
                            &TTPLPFC_iL3_senseOffset_pu , k1 , k2);

    //
    // note the value below is determined by looking at the DC component
    //
    TTPLPFC_ac_cur_senseOffset_pu = 0.5025f;
    TTPLPFC_iL1_senseOffset_pu = 0.5f;
    TTPLPFC_iL2_senseOffset_pu = 0.5f;
    TTPLPFC_iL3_senseOffset_pu = 0.5f;

    //
    // clear any spurious flags in the SDFM module
    // setup protection and trips for the board
    //
    TTPLPFC_HAL_setupBoardProtection(
            TTPLPFC_LOW_FREQ_PWM_BASE, TTPLPFC_HIGH_FREQ_PWM1_BASE,
            TTPLPFC_HIGH_FREQ_PWM2_BASE, TTPLPFC_HIGH_FREQ_PWM3_BASE,
            TTPLPFC_I_TRIP_LIMIT,
            TTPLPFC_I_MAX_SENSE);

    //
    // safe to setup PWM pins
    //
    TTPLPFC_HAL_setPinsAsPWM();

    //
    // ISR Mapping
    //
    TTPLPFC_HAL_setupInterrupt();

    //
    // IDLE loop. Just sit and loop forever,
    // periodically will branch into A0-A3,
    // B0-B3, C0-C3 tasks
    // Frequency of this branching is set in setupDevice routine:
    //
    for(;;)
    {
        //
        // State machine entry & exit point
        //

        //
        // jump to an Alpha state (A0,B0,...)
        //
        (*Alpha_State_Ptr)();
    }
}

#if TTPLPFC_CONTROL_RUNNING_ON == C28x_CORE
interrupt void ISR1(void)
{
    //
    // Increment the ISR1 Nest counter
    //
    TTPLPFC_ISR1_nestingCounter++;

    TTPLPFC_HAL_setProfilingGPIO();

    #if TTPLPFC_LAB == 1
        TTPLPFC_runISR1_lab1();
    #elif TTPLPFC_LAB == 2
        TTPLPFC_runISR1_lab2();
    #elif TTPLPFC_LAB == 3
        TTPLPFC_runISR1_lab3();
    #elif TTPLPFC_LAB == 4
        TTPLPFC_runISR1_lab4();
    #elif TTPLPFC_LAB == 5
        TTPLPFC_runISR1_lab5();
    #elif TTPLPFC_LAB == 6
        TTPLPFC_runISR1_lab6();
    #elif TTPLPFC_LAB == 7
        TTPLPFC_runISR1_lab7();
    #elif TTPLPFC_LAB == 8
        TTPLPFC_runISR1_lab8();
    #elif TTPLPFC_LAB == 9
        TTPLPFC_runISR1_lab9();
    #else
    #warning undefined lab
    #endif

    TTPLPFC_HAL_clearISR1InterruptFlag(
            TTPLPFC_C28x_CONTROLISR_INTERRUPT_PIE_GROUP_NO);

    TTPLPFC_HAL_resetProfilingGPIO();

}
#endif

#if TTPLPFC_INSTRUMENTATION_ISR_RUNNING_ON == C28x_CORE
interrupt void ISR2(void)
{

    //
    // Reset the ISR1 nesting counter to zero to log the number of nests
    // of ISR1 from ISR2
    //
    TTPLPFC_ISR1_nestingCounter = 0;

    TTPLPFC_HAL_setProfilingGPIO2();

    TTPLPFC_runISR2();

    TTPLPFC_HAL_resetProfilingGPIO2();

    //
    // Log the number of nests, the max and compute the average number of nests
    //
    TTPLPFC_ISR1_nests = TTPLPFC_ISR1_nestingCounter;

    if(TTPLPFC_ISR1_nests > TTPLPFC_ISR1_nestsMax)
    {
        TTPLPFC_ISR1_nestsMax = TTPLPFC_ISR1_nests;
    }

    //
    // Take nesting count average over 100 cycles
    //
    TTPLPFC_ISR1_nestsAvg = TTPLPFC_ISR1_nestsAvg +
            0.01f * (float32_t)(TTPLPFC_ISR1_nests - TTPLPFC_ISR1_nestsAvg);

}
#endif

//
//  STATE-MACHINE SEQUENCING AND SYNCRONIZATION FOR SLOW BACKGROUND TASKS
//
void A0(void)
{
    //
    // loop rate synchronizer for A-tasks
    //
    if(TTPLPFC_GET_TASK_A_TIMER_OVERFLOW_STATUS == 1)
    {
        //
        // clear flag
        //
        TTPLPFC_CLEAR_TASK_A_TIMER_OVERFLOW_FLAG;

        //
        // jump to an A Task
        //
        (*A_Task_Ptr)();

        //
        // virtual timer 0, instance 0 (spare)
        //
        vTimer0[0]++;

    }

    //
    // Comment out to allow only A tasks
    //
    Alpha_State_Ptr = &B0;
}

void B0(void)
{
    //
    // loop rate synchronizer for B-tasks
    //
    if(TTPLPFC_GET_TASK_B_TIMER_OVERFLOW_STATUS  == 1)
    {
        //
        // clear flag
        //
        TTPLPFC_CLEAR_TASK_B_TIMER_OVERFLOW_FLAG;

        //
        // jump to a B Task
        //
        (*B_Task_Ptr)();

        //
        // virtual timer 1, instance 0 (spare)
        //
        vTimer1[0]++;
    }

    //
    // Go Back to A state tasks
    //
    Alpha_State_Ptr = &A0;
}

//
//  A - TASKS (executed in every 1 msec)
//
void A1(void)
{
    #if TTPLPFC_SFRA_TYPE != TTPLPFC_SFRA_DISABLED
        TTPLPFC_runSFRABackGroundTasks();
    #endif

    //
    // the next time CpuTimer0 'counter' reaches Period value go to A1
    //
    A_Task_Ptr = &A1;
}

//
//  B - TASKS (executed in every 5 msec)
//

//
// Update board status, Lab indicator update, Notch filter coeff calculation
//
void B1(void)
{
    TTPLPFC_updateBoardStatus();
    TTPLPFC_setLabIndicatorVariable();
    TTPLPFC_computeNotchFltrCoeff(&TTPLPFC_spll_notch_60Hz,
                                   (float32_t)(TTPLPFC_CONTROL_ISR_FREQUENCY),
                                   (float32_t)(60*2.0f) , 0.25f, 0.00001f);

    //
    // the next time CpuTimer1 'counter' reaches Period value go to B2
    //
    B_Task_Ptr = &B2;
}

void B2(void)

{

    //
    // Threshold setting for guiVbus and guiVrm
    // to initiate autoStart (Inverter mode).
    //
    TTPLPFC_autoStart();

    //
    // the next time CpuTimer1 'counter' reaches Period value go to B3
    //
    B_Task_Ptr = &B3;
}

//
//  Toggle LED, eCAP profiling
//
void B3(void)
{
    TTPLPFC_HAL_toggleLED();

    //
    // Get the capture counts for the ISR1 for the last two
    // ISRs, these are logged by reading the capture values
    //
    TTPLPFC_ISR1cap1Count = HWREG(TTPLPFC_PROFILING1_ECAP + ECAP_O_CAP1);
    TTPLPFC_ISR1cap2Count = HWREG(TTPLPFC_PROFILING1_ECAP + ECAP_O_CAP2);
    TTPLPFC_ISR1cap3Count = HWREG(TTPLPFC_PROFILING1_ECAP + ECAP_O_CAP3);
    TTPLPFC_ISR1cap4Count = HWREG(TTPLPFC_PROFILING1_ECAP + ECAP_O_CAP4);

    //
    // Capture ISR1 loading and log max value
    // look back at the last 2 captures to do the same
    //
    TTPLPFC_ISR1_Loading =  ((float32_t)TTPLPFC_ISR1cap1Count /
        ((float32_t)TTPLPFC_ISR1cap1Count + (float32_t)TTPLPFC_ISR1cap2Count) );

    if( TTPLPFC_ISR1_Loading > TTPLPFC_ISR1_LoadingMax )
    {
        TTPLPFC_ISR1_LoadingMax = TTPLPFC_ISR1_Loading;
    }

    TTPLPFC_ISR1_Loading =  ((float32_t)TTPLPFC_ISR1cap3Count /
        ((float32_t)TTPLPFC_ISR1cap3Count + (float32_t)TTPLPFC_ISR1cap4Count) );

    if( TTPLPFC_ISR1_Loading > TTPLPFC_ISR1_LoadingMax )
    {
        TTPLPFC_ISR1_LoadingMax = TTPLPFC_ISR1_Loading;
    }

    if( TTPLPFC_ISR1cap1Count > TTPLPFC_ISR1_capCountMax)
    {
       TTPLPFC_ISR1_capCountMax = TTPLPFC_ISR1cap1Count;
    }

    if( TTPLPFC_ISR1cap3Count > TTPLPFC_ISR1_capCountMax)
    {
      TTPLPFC_ISR1_capCountMax = TTPLPFC_ISR1cap3Count;
    }

    //
    // Compute the ISR1 capture average over 10 past samples
    //
    TTPLPFC_ISR1cap1CountAvg = TTPLPFC_ISR1cap1CountAvg + 0.1f *
                           (TTPLPFC_ISR1cap1Count - TTPLPFC_ISR1cap1CountAvg);

    //
    // Get the capture counts for the ISR2 for the last two
    // ISRs, these are logged by reading the capture values
    //
    TTPLPFC_ISR2cap1Count = HWREG(TTPLPFC_PROFILING2_ECAP + ECAP_O_CAP1);
    TTPLPFC_ISR2cap2Count = HWREG(TTPLPFC_PROFILING2_ECAP + ECAP_O_CAP2);
    TTPLPFC_ISR2cap3Count = HWREG(TTPLPFC_PROFILING2_ECAP + ECAP_O_CAP3);
    TTPLPFC_ISR2cap4Count = HWREG(TTPLPFC_PROFILING2_ECAP + ECAP_O_CAP4);

    //
    // Average last 2 captures of ISR2 and subtract
    // the average nesting * average ISR1 count
    // for an accurate loading of ISR2
    //
    TTPLPFC_ISR2_Loading = (
             (((float32_t)TTPLPFC_ISR2cap1Count ) /
        ((float32_t)TTPLPFC_ISR2cap1Count + (float32_t)TTPLPFC_ISR2cap2Count)) +
        (((float32_t)TTPLPFC_ISR2cap3Count )  /
        ((float32_t)TTPLPFC_ISR2cap3Count + (float32_t)TTPLPFC_ISR2cap4Count)))
                      * 0.5f;

    //
    // Further average over 10 samples of the average of 2 captures
    //
    TTPLPFC_ISR2_LoadingAvg = TTPLPFC_ISR2_LoadingAvg +
            (TTPLPFC_ISR2_Loading - TTPLPFC_ISR2_LoadingAvg) * 0.1f ;

    TTPLPFC_ISR2_LoadingAvg_accountingForNesting =  TTPLPFC_ISR2_LoadingAvg
            - TTPLPFC_ISR1_nestsAvg * TTPLPFC_ISR1_Loading * (float32_t)10000 /
            (float32_t)TTPLPFC_CONTROL_ISR_FREQUENCY;

    //
    // the next time CpuTimer1 'counter' reaches Period value go to B1
    //
    B_Task_Ptr = &B1;
}

