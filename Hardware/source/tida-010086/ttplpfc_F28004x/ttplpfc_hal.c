//#############################################################################
//
// FILE:   ttplpfc_hal.c
//
// TITLE: solution hardware abstraction layer header file
//        This file consists of common variables and functions
//        for a particular hardware board, like functions to read current
//        and voltage signals on the board and functions to setup the
//        basic peripherals of the device
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

#include <ttplpfc_hal.h>

//
// This routine sets up the basic device configuration such as initializing PLL
// copying code from FLASH to RAM
//
void TTPLPFC_HAL_setupDevice(void)
{

    //
    // Initialize device clock and peripherals
    //
    Device_init();

    //
    // Disable pin locks and enable internal pull-ups.
    //
    Device_initGPIO();

    //
    // Initialize PIE and clear PIE registers. Disables CPU interrupts.
    //
    Interrupt_initModule();

    //
    // Initialize the PIE vector table with pointers to the shell Interrupt
    // Service Routines (ISR).
    //
    Interrupt_initVectorTable();

    //
    // initialize CPU timers
    //

    //
    // Initialize timer period to maximum
    //
    CPUTimer_setPeriod(CPUTIMER0_BASE, DEVICE_SYSCLK_FREQ / 100 );

    //
    // Initialize timer period to maximum
    //
    CPUTimer_setPeriod(CPUTIMER1_BASE, DEVICE_SYSCLK_FREQ / 10 );

    //
    // Initialize timer period to maximum
    //
    CPUTimer_setPeriod(CPUTIMER2_BASE, DEVICE_SYSCLK_FREQ / 10000 );

    //
    // Initialize pre-scale counter to divide by 1 (SYSCLKOUT)
    //
    CPUTimer_setPreScaler(CPUTIMER0_BASE, 0);

    //
    // Initialize pre-scale counter to divide by 1 (SYSCLKOUT)
    //
    CPUTimer_setPreScaler(CPUTIMER1_BASE, 0);

    //
    // Initialize pre-scale counter to divide by 1 (SYSCLKOUT)
    //
    CPUTimer_setPreScaler(CPUTIMER2_BASE, 0);

    //
    // Make sure timer is stopped
    //
    CPUTimer_stopTimer(CPUTIMER0_BASE);
    CPUTimer_stopTimer(CPUTIMER1_BASE);
    CPUTimer_stopTimer(CPUTIMER2_BASE);
    CPUTimer_setEmulationMode(CPUTIMER0_BASE,
                              CPUTIMER_EMULATIONMODE_STOPAFTERNEXTDECREMENT);
    CPUTimer_setEmulationMode(CPUTIMER1_BASE,
                              CPUTIMER_EMULATIONMODE_STOPAFTERNEXTDECREMENT);
    CPUTimer_setEmulationMode(CPUTIMER2_BASE,
                              CPUTIMER_EMULATIONMODE_STOPAFTERNEXTDECREMENT);
    //
    // Reload all counter register with period value
    //
    CPUTimer_reloadTimerCounter(CPUTIMER0_BASE);
    CPUTimer_reloadTimerCounter(CPUTIMER1_BASE);
    CPUTimer_reloadTimerCounter(CPUTIMER2_BASE);

    CPUTimer_resumeTimer(CPUTIMER0_BASE);
    CPUTimer_resumeTimer(CPUTIMER1_BASE);
    CPUTimer_resumeTimer(CPUTIMER2_BASE);

}

void TTPLPFC_HAL_setupADC(void)
{

    ADC_setVREF(ADCA_BASE, ADC_REFERENCE_INTERNAL, ADC_REFERENCE_3_3V);
    ADC_setVREF(ADCB_BASE, ADC_REFERENCE_INTERNAL, ADC_REFERENCE_3_3V);
    ADC_setVREF(ADCC_BASE, ADC_REFERENCE_INTERNAL, ADC_REFERENCE_3_3V);

    ADC_setPrescaler(ADCA_BASE, ADC_CLK_DIV_2_0);
    ADC_setPrescaler(ADCB_BASE, ADC_CLK_DIV_2_0);
    ADC_setPrescaler(ADCC_BASE, ADC_CLK_DIV_2_0);

    ADC_enableConverter(ADCA_BASE);
    ADC_enableConverter(ADCB_BASE);
    ADC_enableConverter(ADCC_BASE);

    DEVICE_DELAY_US(1000);

    //
    // setup ADC conversions for current and voltage signals
    //

    //
    //IL1
    //
    ADC_setupSOC(TTPLPFC_IL1_ADC_MODULE, TTPLPFC_IL1_ADC_SOC_NO,
                 TTPLPFC_IL1_ADC_TRIG_SOURCE,
                 TTPLPFC_IL1_ADC_PIN, TTPLPFC_IL1_ADC_ACQPS_SYS_CLKS);
    //
    //IL2
    //
    ADC_setupSOC(TTPLPFC_IL2_ADC_MODULE, TTPLPFC_IL2_ADC_SOC_NO,
                 TTPLPFC_IL2_ADC_TRIG_SOURCE,
                 TTPLPFC_IL2_ADC_PIN, TTPLPFC_IL2_ADC_ACQPS_SYS_CLKS);
    //
    //IL3
    //
    ADC_setupSOC(TTPLPFC_IL3_ADC_MODULE, TTPLPFC_IL3_ADC_SOC_NO,
                 TTPLPFC_IL3_ADC_TRIG_SOURCE,
                 TTPLPFC_IL3_ADC_PIN, TTPLPFC_IL3_ADC_ACQPS_SYS_CLKS);

    //
    //AC_CUR
    //
    ADC_setupSOC(TTPLPFC_AC_CUR_ADC_MODULE, TTPLPFC_AC_CUR_ADC_SOC_NO,
                 TTPLPFC_AC_CUR_ADC_TRIG_SOURCE,
                 TTPLPFC_AC_CUR_ADC_PIN, TTPLPFC_AC_CUR_ADC_ACQPS_SYS_CLKS);
    //
    //AC_CUR
    //
    ADC_setupSOC(TTPLPFC_AC_CUR_ADC_MODULE, TTPLPFC_AC_CUR_ADC_SOC_NO_2,
                 TTPLPFC_AC_CUR_ADC_TRIG_SOURCE_2, TTPLPFC_AC_CUR_ADC_PIN,
                 TTPLPFC_AC_CUR_ADC_ACQPS_SYS_CLKS);
    //
    //AC_CUR
    //
    ADC_setupSOC(TTPLPFC_AC_CUR_ADC_MODULE, TTPLPFC_AC_CUR_ADC_SOC_NO_3,
                 TTPLPFC_AC_CUR_ADC_TRIG_SOURCE_3, TTPLPFC_AC_CUR_ADC_PIN,
                 TTPLPFC_AC_CUR_ADC_ACQPS_SYS_CLKS);

    //
    //AC_N
    //
    ADC_setupSOC(TTPLPFC_AC_N_ADC_MODULE, TTPLPFC_AC_N_ADC_SOC_NO,
                 TTPLPFC_AC_N_ADC_TRIG_SOURCE,
                 TTPLPFC_AC_N_ADC_PIN, TTPLPFC_AC_N_ADC_ACQPS_SYS_CLKS);
    ADC_setupSOC(TTPLPFC_AC_N_ADC_MODULE, TTPLPFC_AC_N_ADC_SOC_NO2,
                 TTPLPFC_AC_N_ADC_TRIG_SOURCE_2,
                 TTPLPFC_AC_N_ADC_PIN, TTPLPFC_AC_N_ADC_ACQPS_SYS_CLKS);
    ADC_setupSOC(TTPLPFC_AC_N_ADC_MODULE, TTPLPFC_AC_N_ADC_SOC_NO3,
                 TTPLPFC_AC_N_ADC_TRIG_SOURCE_3,
                 TTPLPFC_AC_N_ADC_PIN, TTPLPFC_AC_N_ADC_ACQPS_SYS_CLKS);
    //
    //AC_L
    //
    ADC_setupSOC(TTPLPFC_AC_L_ADC_MODULE, TTPLPFC_AC_L_ADC_SOC_NO,
                 TTPLPFC_AC_L_ADC_TRIG_SOURCE,
                 TTPLPFC_AC_L_ADC_PIN, TTPLPFC_AC_L_ADC_ACQPS_SYS_CLKS);
    ADC_setupSOC(TTPLPFC_AC_L_ADC_MODULE, TTPLPFC_AC_L_ADC_SOC_NO2,
                 TTPLPFC_AC_L_ADC_TRIG_SOURCE_2,
                 TTPLPFC_AC_L_ADC_PIN, TTPLPFC_AC_L_ADC_ACQPS_SYS_CLKS);
    ADC_setupSOC(TTPLPFC_AC_L_ADC_MODULE, TTPLPFC_AC_L_ADC_SOC_NO3,
                 TTPLPFC_AC_L_ADC_TRIG_SOURCE_3,
                 TTPLPFC_AC_L_ADC_PIN, TTPLPFC_AC_L_ADC_ACQPS_SYS_CLKS);

    //
    //VBUS
    //
    ADC_setupSOC(TTPLPFC_VBUS_ADC_MODULE, TTPLPFC_VBUS_ADC_SOC_NO,
                 TTPLPFC_VBUS_ADC_TRIG_SOURCE,
                 TTPLPFC_VBUS_ADC_PIN, TTPLPFC_VBUS_ADC_ACQPS_SYS_CLKS);

    ADC_setupSOC(TTPLPFC_VBUS_ADC_MODULE, TTPLPFC_VBUS_ADC_SOC_NO2,
                 TTPLPFC_VBUS_ADC_TRIG_SOURCE_2,
                 TTPLPFC_VBUS_ADC_PIN, TTPLPFC_VBUS_ADC_ACQPS_SYS_CLKS);

    ADC_setupSOC(TTPLPFC_VBUS_ADC_MODULE, TTPLPFC_VBUS_ADC_SOC_NO3,
                 TTPLPFC_VBUS_ADC_TRIG_SOURCE_3,
                 TTPLPFC_VBUS_ADC_PIN, TTPLPFC_VBUS_ADC_ACQPS_SYS_CLKS);

}

void TTPLPFC_HALconfigurePWM1chUpCnt(uint32_t base1, uint16_t period)
{

    //
    // Time Base SubModule Registers
    //
    EPWM_setPeriodLoadMode(base1, EPWM_PERIOD_DIRECT_LOAD);
    EPWM_setTimeBasePeriod(base1, period - 1);
    EPWM_setTimeBaseCounter(base1, 0);
    EPWM_setPhaseShift(base1, 0);
    EPWM_setTimeBaseCounterMode(base1, EPWM_COUNTER_MODE_UP);
    EPWM_setClockPrescaler(base1, EPWM_CLOCK_DIVIDER_1, EPWM_HSCLOCK_DIVIDER_1);

    //
    // configure PWM 1 as master and Phase 2 as slaves and
    // let it pass the sync in pulse from PWM1
    //
    EPWM_disablePhaseShiftLoad(base1);
    EPWM_setSyncOutPulseMode(base1, EPWM_SYNC_OUT_PULSE_ON_COUNTER_ZERO);

    //
    // Counter Compare Submodule Registers
    // set duty 0% initially
    //
    EPWM_setCounterCompareValue(base1, EPWM_COUNTER_COMPARE_A, 0);
    EPWM_setCounterCompareShadowLoadMode(base1, EPWM_COUNTER_COMPARE_A,
                                         EPWM_COMP_LOAD_ON_CNTR_ZERO);

    //
    // Action Qualifier SubModule Registers
    //
    HWREGH(base1 + EPWM_O_AQCTLA) = 0 ;
    EPWM_setActionQualifierAction(base1, EPWM_AQ_OUTPUT_A ,
                                  EPWM_AQ_OUTPUT_LOW,
                                  EPWM_AQ_OUTPUT_ON_TIMEBASE_UP_CMPA);
    EPWM_setActionQualifierAction(base1, EPWM_AQ_OUTPUT_A ,
                                  EPWM_AQ_OUTPUT_HIGH,
                                  EPWM_AQ_OUTPUT_ON_TIMEBASE_ZERO);

}

void TTPLPFC_HAL_setupCMPSS(
        uint32_t base1, float current_limit, float current_max_sense )
{
    //
    //Enable CMPSS1
    //
    CMPSS_enableModule(base1);

    //
    //Use VDDA as the reference for comparator DACs
    //
    CMPSS_configDAC(base1,
                    CMPSS_DACVAL_SYSCLK | CMPSS_DACREF_VDDA |
                    CMPSS_DACSRC_SHDW);

    //
    //Set DAC to H~75% and L ~25% values
    //
    CMPSS_setDACValueHigh(base1,
                          2048 +
                          (int16_t)((float)current_limit * (float)2048.0 /
                                  (float)current_max_sense));
    CMPSS_setDACValueLow(base1,
                         2048 -
                         (int16_t)((float)current_limit * (float)2048.0 /
                                 (float)current_max_sense));

    //
    // Make sure the asynchronous path compare high and low event
    // does not go to the OR gate with latched digital filter output
    // hence no additional parameter CMPSS_OR_ASYNC_OUT_W_FILT  is passed
    // comparator oputput is "not" inverted for high compare event
    //
    CMPSS_configHighComparator(base1, CMPSS_INSRC_DAC );

    //
    // Comparator output is inverted for for low compare event
    //
    CMPSS_configLowComparator(base1, CMPSS_INSRC_DAC | CMPSS_INV_INVERTED);

    CMPSS_configFilterHigh(base1, 2, 10, 7);
    CMPSS_configFilterLow(base1, 2, 10, 7);

    //
    //Reset filter logic & start filtering
    //
    CMPSS_initFilterHigh(base1);
    CMPSS_initFilterLow(base1);

    //
    // Configure CTRIPOUT path
    //
    CMPSS_configOutputsHigh(base1, CMPSS_TRIP_FILTER | CMPSS_TRIP_FILTER);
    CMPSS_configOutputsLow(base1, CMPSS_TRIP_FILTER | CMPSS_TRIP_FILTER);

    //
    //Comparator hysteresis control , set to 2x typical value
    //
    CMPSS_setHysteresis(base1, 2);

    //
    // Clear the latched comparator events
    //
    CMPSS_clearFilterLatchHigh(base1);
    CMPSS_clearFilterLatchLow(base1);
}

void TTPLPFC_HAL_setupBoardProtection(uint32_t base1, uint32_t base2,
                          uint32_t base3, uint32_t base4, float current_limit,
                          float current_max_sense)
{
    //
    // Disable all the muxes first
    //
    XBAR_enableEPWMMux(XBAR_TRIP4, 0x00);

#if TTPLPFC_BOARD_PROTECTION_IL1_SENSE == 1
    ASysCtl_selectCMPHPMux(TTPLPFC_BOARD_PROTECTION_IL1_CMPSS_ASYSCTRL_CMPHPMUX,
                         TTPLPFC_BOARD_PROTECTION_IL1_CMPSS_ASYSCTRL_MUX_VALUE);
    ASysCtl_selectCMPLPMux(TTPLPFC_BOARD_PROTECTION_IL1_CMPSS_ASYSCTRL_CMPLPMUX,
                         TTPLPFC_BOARD_PROTECTION_IL1_CMPSS_ASYSCTRL_MUX_VALUE);

    TTPLPFC_HAL_setupCMPSS(TTPLPFC_BOARD_PROTECTION_IL1_CMPSS_BASE,
               current_limit, current_max_sense );
    XBAR_setEPWMMuxConfig(XBAR_TRIP4,
                          TTPLPFC_BOARD_PROTECTION_IL1_XBAR_MUX_VAL);
    XBAR_enableEPWMMux(XBAR_TRIP4, TTPLPFC_BOARD_PROTECTION_IL1_XBAR_MUX);
#else
    #endif

#if TTPLPFC_BOARD_PROTECTION_IL2_SENSE == 1
    ASysCtl_selectCMPHPMux(TTPLPFC_BOARD_PROTECTION_IL2_CMPSS_ASYSCTRL_CMPHPMUX,
                         TTPLPFC_BOARD_PROTECTION_IL2_CMPSS_ASYSCTRL_MUX_VALUE);
    ASysCtl_selectCMPLPMux(TTPLPFC_BOARD_PROTECTION_IL2_CMPSS_ASYSCTRL_CMPLPMUX,
                         TTPLPFC_BOARD_PROTECTION_IL2_CMPSS_ASYSCTRL_MUX_VALUE);

    TTPLPFC_HAL_setupCMPSS(TTPLPFC_BOARD_PROTECTION_IL2_CMPSS_BASE, current_limit,
               current_max_sense );
    XBAR_setEPWMMuxConfig(XBAR_TRIP4,
                          TTPLPFC_BOARD_PROTECTION_IL2_XBAR_MUX_VAL);
    XBAR_enableEPWMMux(XBAR_TRIP4, TTPLPFC_BOARD_PROTECTION_IL2_XBAR_MUX);
#else
#endif

#if TTPLPFC_BOARD_PROTECTION_IL3_SENSE == 1
    ASysCtl_selectCMPHPMux(TTPLPFC_BOARD_PROTECTION_IL3_CMPSS_ASYSCTRL_CMPHPMUX,
                         TTPLPFC_BOARD_PROTECTION_IL3_CMPSS_ASYSCTRL_MUX_VALUE);
    ASysCtl_selectCMPLPMux(TTPLPFC_BOARD_PROTECTION_IL3_CMPSS_ASYSCTRL_CMPLPMUX,
                         TTPLPFC_BOARD_PROTECTION_IL3_CMPSS_ASYSCTRL_MUX_VALUE);

    TTPLPFC_HAL_setupCMPSS(TTPLPFC_BOARD_PROTECTION_IL3_CMPSS_BASE,
               current_limit, current_max_sense );
    XBAR_setEPWMMuxConfig(XBAR_TRIP4,
                          TTPLPFC_BOARD_PROTECTION_IL3_XBAR_MUX_VAL);
    XBAR_enableEPWMMux(XBAR_TRIP4,
                       TTPLPFC_BOARD_PROTECTION_IL3_XBAR_MUX);
#else
#endif

#if TTPLPFC_BOARD_PROTECTION_AC_CUR == 1
    //
    // Note on F28004x there is an additional MUX on the CMPSS ,
    // configured in the analogsysctrl
    //
    ASysCtl_selectCMPHPMux(
            TTPLPFC_BOARD_PROTECTION_AC_CUR_CMPSS_ASYSCTRL_CMPHPMUX,
            TTPLPFC_BOARD_PROTECTION_AC_CUR_CMPSS_ASYSCTRL_MUX_VALUE);
    ASysCtl_selectCMPLPMux(
            TTPLPFC_BOARD_PROTECTION_AC_CUR_CMPSS_ASYSCTRL_CMPLPMUX,
            TTPLPFC_BOARD_PROTECTION_AC_CUR_CMPSS_ASYSCTRL_MUX_VALUE);

    //
    // AC_CUR CMPSS
    //
    TTPLPFC_HAL_setupCMPSS(TTPLPFC_BOARD_PROTECTION_AC_CUR_CMPSS_BASE,
                           current_limit, current_max_sense );

    //
    // Set source for XBAR TRIP 4 from the CMPSS for AC_CUR
    //
    XBAR_setEPWMMuxConfig(XBAR_TRIP4,
                          TTPLPFC_BOARD_PROTECTION_AC_CUR_XBAR_MUX_VAL);

    //
    // Enable Mux to generate TRIP4
    //
    XBAR_enableEPWMMux(XBAR_TRIP4,
                       TTPLPFC_BOARD_PROTECTION_AC_CUR_XBAR_MUX );
#else
    #warning BOARD_PROTECTION_AC_CUR is disable
#endif

#if TTPLPFC_BOARD_PROTECTION_AC_CUR == 1 ||                                    \
        TTPLPFC_BOARD_PROTECTION_IL1_SENSE == 1 ||                             \
        TTPLPFC_BOARD_PROTECTION_IL2_SENSE == 1 ||                             \
        TTPLPFC_BOARD_PROTECTION_IL3_SENSE == 1

    //
    //Trip 4 is the input to the DCAHCOMPSEL
    //
    EPWM_selectDigitalCompareTripInput(base1,
                                       EPWM_DC_TRIP_TRIPIN4,
                                       EPWM_DC_TYPE_DCAH);
    EPWM_setTripZoneDigitalCompareEventCondition(base1,
                                                 EPWM_TZ_DC_OUTPUT_A1,
                                                 EPWM_TZ_EVENT_DCXH_HIGH);
    EPWM_setDigitalCompareEventSource(base1,
                                      EPWM_DC_MODULE_A,
                                      EPWM_DC_EVENT_1,
                                      EPWM_DC_EVENT_SOURCE_ORIG_SIGNAL);
    EPWM_setDigitalCompareEventSyncMode(base1,
                                        EPWM_DC_MODULE_A ,
                                        EPWM_DC_EVENT_1,
                                        EPWM_DC_EVENT_INPUT_NOT_SYNCED);

    EPWM_selectDigitalCompareTripInput(base2,
                                       EPWM_DC_TRIP_TRIPIN4,
                                       EPWM_DC_TYPE_DCAH);
    EPWM_setTripZoneDigitalCompareEventCondition(base2,
                                                 EPWM_TZ_DC_OUTPUT_A1,
                                                 EPWM_TZ_EVENT_DCXH_HIGH);
    EPWM_setDigitalCompareEventSource(base2,
                                      EPWM_DC_MODULE_A,
                                      EPWM_DC_EVENT_1,
                                      EPWM_DC_EVENT_SOURCE_ORIG_SIGNAL);
    EPWM_setDigitalCompareEventSyncMode(base2,
                                        EPWM_DC_MODULE_A ,
                                        EPWM_DC_EVENT_1,
                                        EPWM_DC_EVENT_INPUT_NOT_SYNCED);

    EPWM_selectDigitalCompareTripInput(base3,
                                       EPWM_DC_TRIP_TRIPIN4,
                                       EPWM_DC_TYPE_DCAH);
    EPWM_setTripZoneDigitalCompareEventCondition(base3,
                                                 EPWM_TZ_DC_OUTPUT_A1,
                                                 EPWM_TZ_EVENT_DCXH_HIGH);
    EPWM_setDigitalCompareEventSource(base3,
                                      EPWM_DC_MODULE_A,
                                      EPWM_DC_EVENT_1,
                                      EPWM_DC_EVENT_SOURCE_ORIG_SIGNAL);
    EPWM_setDigitalCompareEventSyncMode(base3,
                                        EPWM_DC_MODULE_A ,
                                        EPWM_DC_EVENT_1,
                                        EPWM_DC_EVENT_INPUT_NOT_SYNCED);

    EPWM_selectDigitalCompareTripInput(base4,
                                       EPWM_DC_TRIP_TRIPIN4,
                                       EPWM_DC_TYPE_DCAH);
    EPWM_setTripZoneDigitalCompareEventCondition(base4,
                                                 EPWM_TZ_DC_OUTPUT_A1,
                                                 EPWM_TZ_EVENT_DCXH_HIGH);
    EPWM_setDigitalCompareEventSource(base4,
                                      EPWM_DC_MODULE_A,
                                      EPWM_DC_EVENT_1,
                                      EPWM_DC_EVENT_SOURCE_ORIG_SIGNAL);
    EPWM_setDigitalCompareEventSyncMode(base4,
                                        EPWM_DC_MODULE_A ,
                                        EPWM_DC_EVENT_1,
                                        EPWM_DC_EVENT_INPUT_NOT_SYNCED);

    //
    // Enable the following trips Emulator Stop, TZ1-3 and DCAEVT1
    //
    EPWM_enableTripZoneSignals(base1, EPWM_TZ_SIGNAL_DCAEVT1);
    EPWM_enableTripZoneSignals(base2, EPWM_TZ_SIGNAL_DCAEVT1);
    EPWM_enableTripZoneSignals(base3, EPWM_TZ_SIGNAL_DCAEVT1);
    EPWM_enableTripZoneSignals(base4, EPWM_TZ_SIGNAL_DCAEVT1);

#else
    #warning All current comparator based protections are disabled
#endif


#if TTPLPFC_BOARD_PROTECTION_L1 == 1
    GPIO_setDirectionMode(TTPLPFC_GPIO_BOARD_PROTECTION_L1, GPIO_DIR_MODE_IN);
    GPIO_setQualificationMode(TTPLPFC_GPIO_BOARD_PROTECTION_L1, GPIO_QUAL_SYNC);
    GPIO_setPinConfig(TTPLPFC_GPIO_BOARD_PROTECTION_L1_PIN_CONFIG);
    XBAR_setInputPin(XBAR_INPUT1, TTPLPFC_GPIO_BOARD_PROTECTION_L1);
    EPWM_enableTripZoneSignals(base1, EPWM_TZ_SIGNAL_OSHT1);
    EPWM_enableTripZoneSignals(base2, EPWM_TZ_SIGNAL_OSHT1);
    EPWM_enableTripZoneSignals(base3, EPWM_TZ_SIGNAL_OSHT1);
    EPWM_enableTripZoneSignals(base4, EPWM_TZ_SIGNAL_OSHT1);
#else
#endif


#if TTPLPFC_BOARD_PROTECTION_L2 == 1
    GPIO_setDirectionMode(TTPLPFC_GPIO_BOARD_PROTECTION_L2, GPIO_DIR_MODE_IN);
    GPIO_setQualificationMode(TTPLPFC_GPIO_BOARD_PROTECTION_L2, GPIO_QUAL_SYNC);
    GPIO_setPinConfig(TTPLPFC_GPIO_BOARD_PROTECTION_L2_PIN_CONFIG);
    XBAR_setInputPin(XBAR_INPUT2, TTPLPFC_GPIO_BOARD_PROTECTION_L2);
    EPWM_enableTripZoneSignals(base1, EPWM_TZ_SIGNAL_OSHT2);
    EPWM_enableTripZoneSignals(base2, EPWM_TZ_SIGNAL_OSHT2);
    EPWM_enableTripZoneSignals(base3, EPWM_TZ_SIGNAL_OSHT2);
    EPWM_enableTripZoneSignals(base4, EPWM_TZ_SIGNAL_OSHT2);
#else
#endif


#if TTPLPFC_BOARD_PROTECTION_L3 == 1
    GPIO_setDirectionMode(TTPLPFC_GPIO_BOARD_PROTECTION_L3, GPIO_DIR_MODE_IN);
    GPIO_setQualificationMode(TTPLPFC_GPIO_BOARD_PROTECTION_L3, GPIO_QUAL_SYNC);
    GPIO_setPinConfig(TTPLPFC_GPIO_BOARD_PROTECTION_L3_PIN_CONFIG);
    XBAR_setInputPin(XBAR_INPUT3, TTPLPFC_GPIO_BOARD_PROTECTION_L3);
    EPWM_enableTripZoneSignals(base1, EPWM_TZ_SIGNAL_OSHT3);
    EPWM_enableTripZoneSignals(base2, EPWM_TZ_SIGNAL_OSHT3);
    EPWM_enableTripZoneSignals(base3, EPWM_TZ_SIGNAL_OSHT3);
    EPWM_enableTripZoneSignals(base4, EPWM_TZ_SIGNAL_OSHT3);
#else
#endif

    //
    // Enable the following trips Emulator Stop
    //
    EPWM_enableTripZoneSignals(base1, EPWM_TZ_SIGNAL_CBC6);
    EPWM_enableTripZoneSignals(base2, EPWM_TZ_SIGNAL_CBC6);
    EPWM_enableTripZoneSignals(base3, EPWM_TZ_SIGNAL_CBC6);
    EPWM_enableTripZoneSignals(base4, EPWM_TZ_SIGNAL_CBC6);

    //
    // What do we want the OST/CBC events to do?
    // TZA events can force EPWMxA
    // TZB events can force EPWMxB
    //
    EPWM_setTripZoneAction(base1, EPWM_TZ_ACTION_EVENT_TZA, EPWM_TZ_ACTION_LOW);
    EPWM_setTripZoneAction(base1, EPWM_TZ_ACTION_EVENT_TZB, EPWM_TZ_ACTION_LOW);
    EPWM_setTripZoneAction(base2, EPWM_TZ_ACTION_EVENT_TZA, EPWM_TZ_ACTION_LOW);
    EPWM_setTripZoneAction(base2, EPWM_TZ_ACTION_EVENT_TZB, EPWM_TZ_ACTION_LOW);
    EPWM_setTripZoneAction(base3, EPWM_TZ_ACTION_EVENT_TZA, EPWM_TZ_ACTION_LOW);
    EPWM_setTripZoneAction(base3, EPWM_TZ_ACTION_EVENT_TZB, EPWM_TZ_ACTION_LOW);
    EPWM_setTripZoneAction(base4, EPWM_TZ_ACTION_EVENT_TZA, EPWM_TZ_ACTION_LOW);
    EPWM_setTripZoneAction(base4, EPWM_TZ_ACTION_EVENT_TZB, EPWM_TZ_ACTION_LOW);

    //
    // Clear any spurious trip
    //
    EPWM_clearTripZoneFlag(base1,
                           (EPWM_TZ_INTERRUPT_OST | EPWM_TZ_INTERRUPT_DCAEVT1));
    EPWM_clearTripZoneFlag(base2,
                           (EPWM_TZ_INTERRUPT_OST | EPWM_TZ_INTERRUPT_DCAEVT1));
    EPWM_clearTripZoneFlag(base3,
                           (EPWM_TZ_INTERRUPT_OST | EPWM_TZ_INTERRUPT_DCAEVT1));
    EPWM_clearTripZoneFlag(base4,
                           (EPWM_TZ_INTERRUPT_OST | EPWM_TZ_INTERRUPT_DCAEVT1));


    EPWM_forceTripZoneEvent(base1, EPWM_TZ_FORCE_EVENT_OST);
    EPWM_forceTripZoneEvent(base2, EPWM_TZ_FORCE_EVENT_OST);
    EPWM_forceTripZoneEvent(base3, EPWM_TZ_FORCE_EVENT_OST);
    EPWM_forceTripZoneEvent(base4, EPWM_TZ_FORCE_EVENT_OST);
}

void TTPLPFC_HAL_setupTrigForADC()
{
    TTPLPFC_HAL_setupEPWMtoTriggerADCSOC(TTPLPFC_LOW_FREQ_PWM_BASE);
    TTPLPFC_HAL_setupEPWMtoTriggerADCSOC(TTPLPFC_HIGH_FREQ_PWM1_BASE);
    TTPLPFC_HAL_setupEPWMtoTriggerADCSOC(TTPLPFC_HIGH_FREQ_PWM2_BASE);
    TTPLPFC_HAL_setupEPWMtoTriggerADCSOC(TTPLPFC_HIGH_FREQ_PWM3_BASE);
}

void TTPLPFC_HAL_setupEPWMtoTriggerADCSOC(uint32_t base)
{
    //
    // Select SOC from counter at ctr =CMPBD
    //
    EPWM_setADCTriggerSource(base, EPWM_SOC_A, EPWM_SOC_TBCTR_D_CMPB );

    //
    // set duty 0% initially
    //
    EPWM_setCounterCompareValue(base, EPWM_COUNTER_COMPARE_B, (50 / 2));

    //
    // Generate pulse on 1st even
    //
    EPWM_setADCTriggerEventPrescale(base, EPWM_SOC_A, 1);

    //
    // Enable SOC on A group
    //
    EPWM_enableADCTrigger(base, EPWM_SOC_A);

    //
    //SOCB Code
    //
    EPWM_setADCTriggerSource(base, EPWM_SOC_B, EPWM_SOC_TBCTR_D_CMPA );

    //
    // Generate pulse on 1st even
    //
    EPWM_setADCTriggerEventPrescale(base, EPWM_SOC_B, 1);

    //
    // Enable SOC on B group
    //
    EPWM_enableADCTrigger(base, EPWM_SOC_B);
}

void TTPLPFC_calibrateOffset(volatile float *ac_cur_sensedOffset,
                     volatile float *IL1c_sensedOffset,
                     volatile float *IL2c_sensedOffset,
                     volatile float *IL3c_sensedOffset,
                     float k1, float k2)
{
    int16_t offsetCalCounter = 0;

    TTPLPFC_HAL_enablePWMInterruptGeneration(
            TTPLPFC_C28x_CONTROLISR_INTERRUPT_TRIG_PWM_BASE);

    offsetCalCounter = 0;
    while(offsetCalCounter < 20000)
    {
        if(EPWM_getEventTriggerInterruptStatus(
                TTPLPFC_C28x_CONTROLISR_INTERRUPT_TRIG_PWM_BASE) == 1)
        {
            if(offsetCalCounter > 1000)
            {
                //
                // offset of the inductor current sense
                //
                *ac_cur_sensedOffset =  k1 * (*ac_cur_sensedOffset) +
                                        k2 * (TTPLPFC_AC_CUR_FB) *
                                        TTPLPFC_ADC_PU_SCALE_FACTOR;
                *IL1c_sensedOffset =   k1 * (*IL1c_sensedOffset) +
                                        k2 * (TTPLPFC_IL1_FB) *
                                        TTPLPFC_ADC_PU_SCALE_FACTOR;
                *IL2c_sensedOffset =   k1 * (*IL2c_sensedOffset) +
                                        k2 * (TTPLPFC_IL2_FB) *
                                        TTPLPFC_ADC_PU_SCALE_FACTOR;
                *IL3c_sensedOffset =   k1 * (*IL3c_sensedOffset) +
                                        k2 * (TTPLPFC_IL3_FB) *
                                        TTPLPFC_ADC_PU_SCALE_FACTOR;
            }
            EPWM_clearEventTriggerInterruptFlag(
                    TTPLPFC_C28x_CONTROLISR_INTERRUPT_TRIG_PWM_BASE);
            offsetCalCounter++;
        }
    }

    ADC_setPPBCalibrationOffset(ADCA_BASE, ADC_PPB_NUMBER1, (0*4096.0));
    ADC_setPPBCalibrationOffset(ADCA_BASE, ADC_PPB_NUMBER2, (0*4096.0));
    ADC_setPPBCalibrationOffset(ADCA_BASE, ADC_PPB_NUMBER3, (0*4096.0));
}

void TTPLPFC_HAL_disablePWMCLKCounting(void)
{
    SysCtl_disablePeripheral(SYSCTL_PERIPH_CLK_TBCLKSYNC);
}

void TTPLPFC_HAL_enablePWMCLKCounting(void)
{
    SysCtl_enablePeripheral(SYSCTL_PERIPH_CLK_TBCLKSYNC);
}

void TTPLPFC_HAL_setupLEDGPIO(void)
{
    GPIO_setDirectionMode(TTPLPFC_GPIO_LED1, GPIO_DIR_MODE_OUT);
    GPIO_setDirectionMode(TTPLPFC_GPIO_LED2, GPIO_DIR_MODE_OUT);
    GPIO_setQualificationMode(TTPLPFC_GPIO_LED1, GPIO_QUAL_SYNC);
    GPIO_setQualificationMode(TTPLPFC_GPIO_LED2, GPIO_QUAL_SYNC);
    GPIO_setPinConfig(TTPLPFC_GPIO_LED1_PIN_CONFIG);
    GPIO_setPinConfig(TTPLPFC_GPIO_LED2_PIN_CONFIG);
}

void TTPLPFC_HAL_toggleLED(void)
{
    static uint16_t ledCnt1 = 0;

    if(ledCnt1 == 0)
    {
        GPIO_togglePin(TTPLPFC_GPIO_LED1);
        ledCnt1 = 5;
    }
    else
    {
        ledCnt1--;
    }

}

void TTPLPFC_HAL_setupProfilingGPIO(void)
{
    GPIO_setDirectionMode(TTPLPFC_GPIO_PROFILING1, GPIO_DIR_MODE_OUT);
    GPIO_setDirectionMode(TTPLPFC_GPIO_PROFILING2, GPIO_DIR_MODE_OUT);
    GPIO_setQualificationMode(TTPLPFC_GPIO_PROFILING1, GPIO_QUAL_SYNC);
    GPIO_setQualificationMode(TTPLPFC_GPIO_PROFILING2, GPIO_QUAL_SYNC);
    GPIO_setPinConfig(TTPLPFC_GPIO_PROFILING1_PIN_CONFIG);
    GPIO_setPinConfig(TTPLPFC_GPIO_PROFILING2_PIN_CONFIG);

#if TTPLPFC_CONTROL_RUNNING_ON == CLA_CORE
    GPIO_setMasterCore(TTPLPFC_GPIO_PROFILING1, GPIO_CORE_CPU1_CLA1);
    GPIO_setMasterCore(TTPLPFC_GPIO_PROFILING2, GPIO_CORE_CPU1_CLA1);
#endif
}

void TTPLPFC_HAL_setupRelayGPIO(void)
{
    GPIO_setDirectionMode(TTPLPFC_GPIO_RELAY, GPIO_DIR_MODE_OUT);
    GPIO_setQualificationMode(TTPLPFC_GPIO_RELAY, GPIO_QUAL_SYNC);

    GPIO_setPinConfig(TTPLPFC_GPIO_RELAY_PIN_CONFIG);

#if TTPLPFC_CONTROL_RUNNING_ON == CLA_CORE
    GPIO_setMasterCore(TTPLPFC_GPIO_RELAY, GPIO_CORE_CPU1_CLA1);
#endif

}

void TTPLPFC_HAL_setupGainChangeGPIO(void)
{
    GPIO_setDirectionMode(TTPLPFC_GPIO_I_SENSE_GAIN_ADJUST, GPIO_DIR_MODE_OUT);
    GPIO_setQualificationMode(TTPLPFC_GPIO_I_SENSE_GAIN_ADJUST, GPIO_QUAL_SYNC);
    GPIO_setPinConfig(TTPLPFC_GPIO_I_SENSE_GAIN_ADJUST_PIN_CONFIG);
}

void TTPLPFC_HAL_setupPWM(uint32_t base1, uint32_t base2, uint32_t base3,
                           uint32_t base4, uint16_t pwm_period_ticks,
                           uint16_t pwm_db_ticks_ls, uint16_t pwm_db_ticks_hs)
{

    //
    // PWM clock on F2837x is divided by 2
    // ClkCfgRegs.PERCLKDIVSEL.bit.EPWMCLKDIV=1
    // Deadband needs to be 0.5us => 10ns*50=500ns
    // Time Base SubModule Registers
    //
    EPWM_setPeriodLoadMode(base1, EPWM_PERIOD_SHADOW_LOAD);
    EPWM_setTimeBasePeriod(base1, pwm_period_ticks >> 1);
    EPWM_setTimeBaseCounter(base1, 0);
    EPWM_setPhaseShift(base1, 0);
    EPWM_setTimeBaseCounterMode(base1, EPWM_COUNTER_MODE_UP_DOWN);
    EPWM_setClockPrescaler(base1, EPWM_CLOCK_DIVIDER_1, EPWM_HSCLOCK_DIVIDER_1);

    EPWM_setPeriodLoadMode(base2, EPWM_PERIOD_SHADOW_LOAD);
    EPWM_setTimeBasePeriod(base2, pwm_period_ticks >> 1);
    EPWM_setTimeBaseCounter(base2, 0);
    EPWM_setPhaseShift(base2, 0);
    EPWM_setTimeBaseCounterMode(base2, EPWM_COUNTER_MODE_UP_DOWN);
    EPWM_setClockPrescaler(base2, EPWM_CLOCK_DIVIDER_1, EPWM_HSCLOCK_DIVIDER_1);

    EPWM_setPeriodLoadMode(base3, EPWM_PERIOD_SHADOW_LOAD);
    EPWM_setTimeBasePeriod(base3, pwm_period_ticks >> 1);
    EPWM_setTimeBaseCounter(base3, 0);
    EPWM_setPhaseShift(base3, 0);
    EPWM_setTimeBaseCounterMode(base3, EPWM_COUNTER_MODE_UP_DOWN);
    EPWM_setClockPrescaler(base3, EPWM_CLOCK_DIVIDER_1, EPWM_HSCLOCK_DIVIDER_1);

    EPWM_setPeriodLoadMode(base4, EPWM_PERIOD_SHADOW_LOAD);
    EPWM_setTimeBasePeriod(base4, pwm_period_ticks >> 1);
    EPWM_setTimeBaseCounter(base4, 0);
    EPWM_setPhaseShift(base4, 0);
    EPWM_setTimeBaseCounterMode(base4, EPWM_COUNTER_MODE_UP_DOWN);
    EPWM_setClockPrescaler(base4, EPWM_CLOCK_DIVIDER_1, EPWM_HSCLOCK_DIVIDER_1);

    //
    // Counter Compare Submodule Registers
    // set duty 0% initially
    //
    EPWM_setCounterCompareValue(base1, EPWM_COUNTER_COMPARE_A, 0);

    //
    // set as immediate mode
    //
    EPWM_disableCounterCompareShadowLoadMode(base1, EPWM_COUNTER_COMPARE_A);

    //
    // set duty 0% initially
    //
    EPWM_setCounterCompareValue(base2, EPWM_COUNTER_COMPARE_A, 0);
    EPWM_setCounterCompareShadowLoadMode(base2, EPWM_COUNTER_COMPARE_A,
                                         EPWM_COMP_LOAD_ON_CNTR_ZERO);
    //
    // set duty 0% initially
    //
    EPWM_setCounterCompareValue(base3, EPWM_COUNTER_COMPARE_A, 0);
    EPWM_setCounterCompareShadowLoadMode(base3, EPWM_COUNTER_COMPARE_A,
                                         EPWM_COMP_LOAD_ON_CNTR_ZERO);
    //
    // set duty 0% initially
    //
    EPWM_setCounterCompareValue(base4, EPWM_COUNTER_COMPARE_A, 0);
    EPWM_setCounterCompareShadowLoadMode(base4, EPWM_COUNTER_COMPARE_A,
                                         EPWM_COMP_LOAD_ON_CNTR_ZERO);

    //
    // Action Qualifier SubModule Registers
    //

    //
    // to start don't configure the PWM to do anything
    //
    HWREGH(base1 + EPWM_O_AQCTLA) = 0;
    HWREGH(base2 + EPWM_O_AQCTLA) = 0;
    HWREGH(base3 + EPWM_O_AQCTLA) = 0;
    HWREGH(base4 + EPWM_O_AQCTLA) = 0;

    //
    // CTR = CMPA@UP , set to 1
    //
    EPWM_setActionQualifierAction(base2, EPWM_AQ_OUTPUT_A ,
            EPWM_AQ_OUTPUT_LOW, EPWM_AQ_OUTPUT_ON_TIMEBASE_UP_CMPA);
    EPWM_setActionQualifierAction(base2, EPWM_AQ_OUTPUT_B ,
                EPWM_AQ_OUTPUT_LOW, EPWM_AQ_OUTPUT_ON_TIMEBASE_UP_CMPA);

    //
    // CTR = CMPA@Down , toggle
    //
    EPWM_setActionQualifierAction(base2, EPWM_AQ_OUTPUT_A ,
            EPWM_AQ_OUTPUT_HIGH, EPWM_AQ_OUTPUT_ON_TIMEBASE_DOWN_CMPA);
    EPWM_setActionQualifierAction(base2, EPWM_AQ_OUTPUT_B ,
            EPWM_AQ_OUTPUT_HIGH, EPWM_AQ_OUTPUT_ON_TIMEBASE_DOWN_CMPA);

    //
    // CTR = CMPA@UP , set to 1
    //
    EPWM_setActionQualifierAction(base3, EPWM_AQ_OUTPUT_A ,
            EPWM_AQ_OUTPUT_LOW, EPWM_AQ_OUTPUT_ON_TIMEBASE_UP_CMPA);
    EPWM_setActionQualifierAction(base3, EPWM_AQ_OUTPUT_B ,
                    EPWM_AQ_OUTPUT_LOW, EPWM_AQ_OUTPUT_ON_TIMEBASE_UP_CMPA);
    //
    // CTR = CMPA@Down , toggle
    //
    EPWM_setActionQualifierAction(base3, EPWM_AQ_OUTPUT_A ,
            EPWM_AQ_OUTPUT_HIGH, EPWM_AQ_OUTPUT_ON_TIMEBASE_DOWN_CMPA);
    EPWM_setActionQualifierAction(base3, EPWM_AQ_OUTPUT_B ,
                EPWM_AQ_OUTPUT_HIGH, EPWM_AQ_OUTPUT_ON_TIMEBASE_DOWN_CMPA);

    //
    // CTR = CMPA@UP , set to 1
    //
    EPWM_setActionQualifierAction(base4, EPWM_AQ_OUTPUT_A ,
            EPWM_AQ_OUTPUT_LOW, EPWM_AQ_OUTPUT_ON_TIMEBASE_UP_CMPA);
    EPWM_setActionQualifierAction(base4, EPWM_AQ_OUTPUT_B ,
                EPWM_AQ_OUTPUT_LOW, EPWM_AQ_OUTPUT_ON_TIMEBASE_UP_CMPA);
    //
    // CTR = CMPA@Down , toggle
    //
    EPWM_setActionQualifierAction(base4, EPWM_AQ_OUTPUT_A ,
            EPWM_AQ_OUTPUT_HIGH, EPWM_AQ_OUTPUT_ON_TIMEBASE_DOWN_CMPA);
    EPWM_setActionQualifierAction(base4, EPWM_AQ_OUTPUT_B ,
            EPWM_AQ_OUTPUT_HIGH, EPWM_AQ_OUTPUT_ON_TIMEBASE_DOWN_CMPA);

    EPWM_setDeadBandControlShadowLoadMode(base2, EPWM_DB_LOAD_ON_CNTR_ZERO);
    EPWM_setDeadBandControlShadowLoadMode(base3, EPWM_DB_LOAD_ON_CNTR_ZERO);
    EPWM_setDeadBandControlShadowLoadMode(base4, EPWM_DB_LOAD_ON_CNTR_ZERO);

    EPWM_setRisingEdgeDelayCountShadowLoadMode(base2,
                                               EPWM_RED_LOAD_ON_CNTR_PERIOD);
    EPWM_setRisingEdgeDelayCountShadowLoadMode(base3,
                                               EPWM_RED_LOAD_ON_CNTR_PERIOD);
    EPWM_setRisingEdgeDelayCountShadowLoadMode(base4,
                                               EPWM_RED_LOAD_ON_CNTR_PERIOD);


    EPWM_setFallingEdgeDelayCountShadowLoadMode(base2,
                                                EPWM_FED_LOAD_ON_CNTR_ZERO);

    EPWM_setFallingEdgeDelayCountShadowLoadMode(base3,
                                                EPWM_FED_LOAD_ON_CNTR_ZERO);

    EPWM_setFallingEdgeDelayCountShadowLoadMode(base4,
                                                EPWM_FED_LOAD_ON_CNTR_ZERO);

    //
    // Active high complementary PWMs - Set up the deadband
    //

    EPWM_setDeadBandCounterClock(base2, EPWM_DB_COUNTER_CLOCK_FULL_CYCLE);
    EPWM_setRisingEdgeDelayCount(base2, pwm_db_ticks_hs);
    EPWM_setFallingEdgeDelayCount(base2, pwm_db_ticks_hs);
    EPWM_setDeadBandDelayMode(base2, EPWM_DB_RED, true);
    EPWM_setDeadBandDelayMode(base2, EPWM_DB_FED, true);
    EPWM_setRisingEdgeDeadBandDelayInput(base2, EPWM_DB_INPUT_EPWMA);
    EPWM_setFallingEdgeDeadBandDelayInput(base2, EPWM_DB_INPUT_EPWMA);
    EPWM_setDeadBandDelayPolarity(base2, EPWM_DB_FED,
                                  EPWM_DB_POLARITY_ACTIVE_LOW);
    EPWM_setDeadBandDelayPolarity(base2, EPWM_DB_RED,
                                  EPWM_DB_POLARITY_ACTIVE_HIGH);

    EPWM_setDeadBandCounterClock(base3, EPWM_DB_COUNTER_CLOCK_FULL_CYCLE);
    EPWM_setRisingEdgeDelayCount(base3, pwm_db_ticks_hs);
    EPWM_setFallingEdgeDelayCount(base3, pwm_db_ticks_hs);
    EPWM_setDeadBandDelayMode(base3, EPWM_DB_RED, true);
    EPWM_setDeadBandDelayMode(base3, EPWM_DB_FED, true);
    EPWM_setRisingEdgeDeadBandDelayInput(base3, EPWM_DB_INPUT_EPWMA);
    EPWM_setFallingEdgeDeadBandDelayInput(base3, EPWM_DB_INPUT_EPWMA);
    EPWM_setDeadBandDelayPolarity(base3, EPWM_DB_FED,
                                  EPWM_DB_POLARITY_ACTIVE_LOW);
    EPWM_setDeadBandDelayPolarity(base3, EPWM_DB_RED,
                                  EPWM_DB_POLARITY_ACTIVE_HIGH);

    EPWM_setDeadBandCounterClock(base4, EPWM_DB_COUNTER_CLOCK_FULL_CYCLE);
    EPWM_setRisingEdgeDelayCount(base4, pwm_db_ticks_hs);
    EPWM_setFallingEdgeDelayCount(base4, pwm_db_ticks_hs);
    EPWM_setDeadBandDelayMode(base4, EPWM_DB_RED, true);
    EPWM_setDeadBandDelayMode(base4, EPWM_DB_FED, true);
    EPWM_setRisingEdgeDeadBandDelayInput(base4, EPWM_DB_INPUT_EPWMA);
    EPWM_setFallingEdgeDeadBandDelayInput(base4, EPWM_DB_INPUT_EPWMA);
    EPWM_setDeadBandDelayPolarity(base4, EPWM_DB_FED,
                                  EPWM_DB_POLARITY_ACTIVE_LOW);
    EPWM_setDeadBandDelayPolarity(base4, EPWM_DB_RED,
                                  EPWM_DB_POLARITY_ACTIVE_HIGH);

    //
    // configure PWM 1 as master and Phase 2,3 and 4 as slaves and
    // let it pass the sync in pulse from PWM1
    //
    EPWM_disablePhaseShiftLoad(base1);
    EPWM_setSyncOutPulseMode(base1, EPWM_SYNC_OUT_PULSE_ON_COUNTER_ZERO);

    EPWM_enablePhaseShiftLoad(base2);

    //
    // This basically is aso SYNCIN pass, need to correct driver lib comments
    //
    EPWM_setSyncOutPulseMode(base2, EPWM_SYNC_OUT_PULSE_ON_SOFTWARE);
    EPWM_setPhaseShift(base2, 2 );
    EPWM_setCountModeAfterSync(base2, EPWM_COUNT_MODE_UP_AFTER_SYNC);

    EPWM_enablePhaseShiftLoad(base3);
    EPWM_setSyncOutPulseMode(base3, EPWM_SYNC_OUT_PULSE_ON_SOFTWARE);

    //
    //  3-Ph Interleaving Register Setting
    //
    EPWM_setPhaseShift(base3,
                       (2 + (uint16_t)((float)pwm_period_ticks /
                               (float)(3.0))));
    EPWM_setCountModeAfterSync(base3, EPWM_COUNT_MODE_UP_AFTER_SYNC);

    //
    // by default EPWM3 syncout is passed to EPWM4
    // so no configuration is needed here
    //
    SysCtl_setSyncInputConfig(SYSCTL_SYNC_IN_EPWM4 ,
                              SYSCTL_SYNC_IN_SRC_EPWM1SYNCOUT);

    EPWM_enablePhaseShiftLoad(base4);
    EPWM_setSyncOutPulseMode(base4, EPWM_SYNC_OUT_PULSE_ON_SOFTWARE);
    EPWM_setPhaseShift(base4,
                       (2 + (uint16_t)((float)pwm_period_ticks /
                               (float)(3.0))));
    EPWM_setCountModeAfterSync(base4, EPWM_COUNT_MODE_DOWN_AFTER_SYNC);


    EPWM_setActionQualifierContSWForceShadowMode(base1,
            EPWM_AQ_SW_SH_LOAD_ON_CNTR_ZERO);
    EPWM_setActionQualifierContSWForceShadowMode(base2,
            EPWM_AQ_SW_SH_LOAD_ON_CNTR_ZERO);
    EPWM_setActionQualifierContSWForceShadowMode(base3,
            EPWM_AQ_SW_SH_LOAD_ON_CNTR_ZERO);
    EPWM_setActionQualifierContSWForceShadowMode(base4,
            EPWM_AQ_SW_SH_LOAD_ON_CNTR_ZERO);

}

void TTPLPFC_HAL_setPinsAsPWM()
{
    GPIO_writePin(TTPLPFC_LOW_FREQ_PWM_H_GPIO, 0);
    GPIO_writePin(TTPLPFC_LOW_FREQ_PWM_L_GPIO, 0);
    GPIO_writePin(TTPLPFC_HIGH_FREQ_PWM1_H_GPIO, 0);
    GPIO_writePin(TTPLPFC_HIGH_FREQ_PWM1_L_GPIO, 0);
    GPIO_writePin(TTPLPFC_HIGH_FREQ_PWM2_H_GPIO, 0);
    GPIO_writePin(TTPLPFC_HIGH_FREQ_PWM2_L_GPIO, 0);
    GPIO_writePin(TTPLPFC_HIGH_FREQ_PWM3_H_GPIO, 0);
    GPIO_writePin(TTPLPFC_HIGH_FREQ_PWM3_L_GPIO, 0);
    GPIO_setDirectionMode( TTPLPFC_LOW_FREQ_PWM_H_GPIO, GPIO_DIR_MODE_OUT);
    GPIO_setPadConfig(TTPLPFC_LOW_FREQ_PWM_H_GPIO, GPIO_PIN_TYPE_STD);
    GPIO_setPinConfig(TTPLPFC_LOW_FREQ_PWM_H_GPIO_PIN_CONFIG );

    GPIO_setDirectionMode(TTPLPFC_LOW_FREQ_PWM_L_GPIO, GPIO_DIR_MODE_OUT);
    GPIO_setPadConfig(TTPLPFC_LOW_FREQ_PWM_L_GPIO, GPIO_PIN_TYPE_STD);
    GPIO_setPinConfig(TTPLPFC_LOW_FREQ_PWM_L_GPIO_PIN_CONFIG);

    GPIO_setDirectionMode(TTPLPFC_HIGH_FREQ_PWM1_H_GPIO, GPIO_DIR_MODE_OUT);
    GPIO_setPadConfig(TTPLPFC_HIGH_FREQ_PWM1_H_GPIO , GPIO_PIN_TYPE_STD);
    GPIO_setPinConfig(TTPLPFC_HIGH_FREQ_PWM1_H_GPIO_PIN_CONFIG );

    GPIO_setDirectionMode(TTPLPFC_HIGH_FREQ_PWM1_L_GPIO, GPIO_DIR_MODE_OUT);
    GPIO_setPadConfig(TTPLPFC_HIGH_FREQ_PWM1_L_GPIO, GPIO_PIN_TYPE_STD);
    GPIO_setPinConfig(TTPLPFC_HIGH_FREQ_PWM1_L_GPIO_PIN_CONFIG );

    GPIO_setDirectionMode(TTPLPFC_HIGH_FREQ_PWM2_H_GPIO, GPIO_DIR_MODE_OUT);
    GPIO_setPadConfig(TTPLPFC_HIGH_FREQ_PWM2_H_GPIO, GPIO_PIN_TYPE_STD);
    GPIO_setPinConfig(TTPLPFC_HIGH_FREQ_PWM2_H_GPIO_PIN_CONFIG);

    GPIO_setDirectionMode(TTPLPFC_HIGH_FREQ_PWM2_L_GPIO, GPIO_DIR_MODE_OUT);
    GPIO_setPadConfig(TTPLPFC_HIGH_FREQ_PWM2_L_GPIO, GPIO_PIN_TYPE_STD);
    GPIO_setPinConfig(TTPLPFC_HIGH_FREQ_PWM2_L_GPIO_PIN_CONFIG);

    GPIO_setDirectionMode(TTPLPFC_HIGH_FREQ_PWM3_H_GPIO, GPIO_DIR_MODE_OUT);
    GPIO_setPadConfig(TTPLPFC_HIGH_FREQ_PWM3_H_GPIO, GPIO_PIN_TYPE_STD);
    GPIO_setPinConfig(TTPLPFC_HIGH_FREQ_PWM3_H_GPIO_PIN_CONFIG);

    GPIO_setDirectionMode(TTPLPFC_HIGH_FREQ_PWM3_L_GPIO, GPIO_DIR_MODE_OUT);
    GPIO_setPadConfig(TTPLPFC_HIGH_FREQ_PWM3_L_GPIO, GPIO_PIN_TYPE_STD);
    GPIO_setPinConfig(TTPLPFC_HIGH_FREQ_PWM3_L_GPIO_PIN_CONFIG);
}

void TTPLPFC_HAL_setupCLA(void)
{
    //
    // setup CLA to register an interrupt
    //
#if TTPLPFC_CONTROL_RUNNING_ON == CLA_CORE

    memcpy((uint32_t *)&Cla1ProgRunStart, (uint32_t *)&Cla1ProgLoadStart,
            (uint32_t)&Cla1ProgLoadSize );

    //
    // first assign memory to CLA
    //
    MemCfg_setLSRAMMasterSel(MEMCFG_SECT_LS0, MEMCFG_LSRAMMASTER_CPU_CLA1);
    MemCfg_setLSRAMMasterSel(MEMCFG_SECT_LS1, MEMCFG_LSRAMMASTER_CPU_CLA1);
    MemCfg_setLSRAMMasterSel(MEMCFG_SECT_LS2, MEMCFG_LSRAMMASTER_CPU_CLA1);
    MemCfg_setLSRAMMasterSel(MEMCFG_SECT_LS3, MEMCFG_LSRAMMASTER_CPU_CLA1);
    MemCfg_setLSRAMMasterSel(MEMCFG_SECT_LS4, MEMCFG_LSRAMMASTER_CPU_CLA1);
    MemCfg_setLSRAMMasterSel(MEMCFG_SECT_LS5, MEMCFG_LSRAMMASTER_CPU_CLA1);

    MemCfg_setCLAMemType(MEMCFG_SECT_LS0, MEMCFG_CLA_MEM_DATA);
    MemCfg_setCLAMemType(MEMCFG_SECT_LS1, MEMCFG_CLA_MEM_DATA);
    MemCfg_setCLAMemType(MEMCFG_SECT_LS2, MEMCFG_CLA_MEM_PROGRAM);
    MemCfg_setCLAMemType(MEMCFG_SECT_LS3, MEMCFG_CLA_MEM_PROGRAM);
    MemCfg_setCLAMemType(MEMCFG_SECT_LS4, MEMCFG_CLA_MEM_PROGRAM);
    MemCfg_setCLAMemType(MEMCFG_SECT_LS5, MEMCFG_CLA_MEM_PROGRAM);

    //
    // Suppressing #770-D conversion from pointer to smaller integer
    // The CLA address range is 16 bits so the addresses passed to the MVECT
    // registers will be in the lower 64KW address space. Turn the warning
    // back on after the MVECTs are assigned addresses
    //
    #pragma diag_suppress = 770

    CLA_mapTaskVector(CLA1_BASE , CLA_MVECT_1, (uint16_t)&Cla1Task1);
    CLA_mapTaskVector(CLA1_BASE , CLA_MVECT_2, (uint16_t)&Cla1Task2);
    CLA_mapTaskVector(CLA1_BASE , CLA_MVECT_3, (uint16_t)&Cla1Task3);
    CLA_mapTaskVector(CLA1_BASE , CLA_MVECT_4, (uint16_t)&Cla1Task4);
    CLA_mapTaskVector(CLA1_BASE , CLA_MVECT_5, (uint16_t)&Cla1Task5);
    CLA_mapTaskVector(CLA1_BASE , CLA_MVECT_6, (uint16_t)&Cla1Task6);
    CLA_mapTaskVector(CLA1_BASE , CLA_MVECT_7, (uint16_t)&Cla1Task7);
    CLA_mapBackgroundTaskVector(CLA1_BASE, (uint16_t)&Cla1BackgroundTask);

    #pragma diag_warning = 770

    CLA_enableIACK(CLA1_BASE);
    CLA_enableTasks(CLA1_BASE, CLA_TASKFLAG_ALL);

    //
    //Used to debug, the below line is intentionally commented
    //CLA_forceTasks(CLA1_BASE,CLA_TASKFLAG_1);
    //
    CLA_enableHardwareTrigger(CLA1_BASE);
    CLA_setTriggerSource(CLA_TASK_8, TTPLPFC_CLA_INSTRUMENTATIONISR_TRIG);
    CLA_enableBackgroundTask(CLA1_BASE);

    CLA_setTriggerSource(CLA_TASK_1, TTPLPFC_CLA_CONTROLISR_TRIG);

    TTPLPFC_HAL_enablePWMInterruptGeneration(EPWM1_BASE);
    TTPLPFC_HAL_clearPWMInterruptFlag(
            TTPLPFC_C28x_CONTROLISR_INTERRUPT_TRIG_PWM_BASE);


#endif
}
