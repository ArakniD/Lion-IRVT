//#############################################################################
//
// FILE:   bts_main.c
//
// TITLE:  This is the main file for the solution
//         Additional solution support files are
//             <solution>.c -> solution source file
//             <solution>.h -> solution header file
//             <solution>_settings.h -> powerSUITE generated settings
//             <solution>_hal.c -> device drivers source file
//             <solution>_hal.h -> device drivers header file
//
//#############################################################################
// $TI Release:  $
// $Release Date:  $
// $Copyright:
// Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
//
// ALL RIGHTS RESERVED
// $
//#############################################################################
//*****************************************************************************
// includes section
//*****************************************************************************
#include <bts.h>

//
//---  State Machine Related ---
//
uint16_t vTimer0[4];         // Virtual Timers based on CPU Timer 0 (A events)
uint16_t vTimer1[4];         // Virtual Timers based on CPU Timer 1 (B events)
uint16_t vTimer2[4];         // Virtual Timers based on CPU Timer 2 (C events)

//
// Variable declarations for state machine
//
void (*Alpha_State_Ptr)(void); // Base States pointer
void (*A_Task_Ptr)(void);      // State pointer A branch
void (*B_Task_Ptr)(void);      // State pointer B branch
void (*C_Task_Ptr)(void);      // State pointer C branch

//
// State Machine function prototypes
//------------------------------------
// Alpha states
//
void A0(void);  //state A0
void B0(void);  //state B0
void C0(void);  //state C0

//
// A branch states
//
void A1(void);  //state A1
void A2(void);  //state A2
void A3(void);  //state A3

//
// B branch states
//
void B1(void);  //state B1
void B2(void);  //state B2
void B3(void);  //state B3

//
// C branch states
//
void C1(void);  //state C1
void C2(void);  //state C2
void C3(void);  //state C3

//
// main() function
//
void main(void)
{
    //
    // Set up the basic device configuration such as initializing PLL,
    // copying code from FLASH to RAM, and initializing the CPU timers that
    // are used in the background A, B, C tasks
    //
    BTS_HAL_setupDevice();

    //
    // Place actuation pins (ePWM signals that control the
    // synchronous buck and active load) in a safe state for the system.
    // The pins are configured for GPIO function with static low output
    // while the system is initialized.
    //
    BTS_HAL_setupSyncBuckPinsGpio();

    BTS_HAL_SetupI2C_GPIO();

    BTS_HAL_SetupI2C_Init();

    BTS_HAL_setupCanBus();

    //
    // Tasks State-machine initialization
    //
    Alpha_State_Ptr = &A0;
    A_Task_Ptr = &A1;
    B_Task_Ptr = &B1;
    C_Task_Ptr = &C1;

    //
    // Stop ePWM clocks
    //
    BTS_HAL_disableEpwmCounting();

    //
    // Set up ePWM for synchronous buck and active load control.
    // Include comparator monitoring of the inductor current feedback
    // signal (ILFB) for over-current trip protection.
    //
    BTS_HAL_setupSyncBuckPwm(BTS_EPWM_BASE_CH1);
    BTS_HAL_setupSyncBuckPwm(BTS_EPWM_BASE_CH2);
    BTS_HAL_setupSyncBuckPwm(BTS_EPWM_BASE_CH3);
    BTS_HAL_setupSyncBuckPwm(BTS_EPWM_BASE_CH4);
    BTS_HAL_setupSyncBuckPwm(BTS_EPWM_BASE_CH5);
    BTS_HAL_setupSyncBuckPwm(BTS_EPWM_BASE_CH6);
    BTS_HAL_setupSyncBuckPwm(BTS_EPWM_BASE_CH7);
    BTS_HAL_setupSyncBuckPwm(BTS_EPWM_BASE_CH8);

    BTS_HAL_setupAdcClock(BTS_EPWM_BASE_ADC1);
    BTS_HAL_setupAdcClock(BTS_EPWM_BASE_ADC2);

#if BTS_SFRA_ENABLED && ( BTS_SFRA_ISR_SRC == BTS_SFRA_ISR_SRC_PWM)
    BTS_HAL_setupSfraClock(BTS_EPWM_BASE_CH1);

    Interrupt_enable(INT_EPWM1);
#endif

    BTS_setupHrpwmMepScaleFactor();

    //
    // Start ePWM clocks
    //
    BTS_HAL_enableEpwmCounting();

    //
    // Configure the embedded ADC to sample Vin, Vout, ILFB, and ILFB_AVG
    //
    // setup SPI
    BTS_HAL_SetupSpiPinsGpio_Adc1();
    BTS_HAL_SetupSpi(BTS_SPI_BASE_ADC1);

    BTS_HAL_SetupSpiPinsGpio_Adc2();
    BTS_HAL_SetupSpi(BTS_SPI_BASE_ADC2);

    BTS_HAL_setupExAdcGpio_Adc1();
    BTS_HAL_setupExAdc_ch1_4();

    BTS_HAL_setupExAdcGpio_Adc2();
    BTS_HAL_setupExAdc_ch5_8();

    //
    // Initialize global variables used in solution
    //
    BTS_initUserVariables();
    BTS_initProgramVariables();
    BTS_initController();

    //
    // Configure DCL and SFRA libraries
    //
    BTS_setupSfra();
    BTS_setupSfraGui();

    //
    // Configure and enable system interrupt
    //
    BTS_HAL_setupInterruptTrigger_Adc1();
    BTS_HAL_setupInterruptTrigger_Adc2();

    BTS_HAL_setupInterrupt_Adc1();
    BTS_HAL_setupInterrupt_Adc2();

    BTS_HAL_setupInterrupt_I2c();

    BTS_HAL_setupInterrupt();

    //
    // Read in the calibration
    BTS_readCalibration();



    //
    // Switch actuation pins over to ePWM function
    //
    BTS_HAL_setupSyncBuckPinsEpwm();

    BTS_HAL_ExAdcTxframe(BTS_SPI_BASE_ADC1);

    BTS_HAL_ExAdcTxframe(BTS_SPI_BASE_ADC2);

    //
    // Background loop with periodic branches to state-machine tasks.
    // Frequency of task branching is configured in setupDevice() routine.
    //
    for(;;)
    {
        //
        // Background state machine entry & exit point
        //
        (*Alpha_State_Ptr)();   // jump to an Alpha state (A0,B0,...)
    }
} //END MAIN CODE


//
// ISR1() interrupt function
//
#pragma CODE_SECTION(ISR1,"isrcodefuncs");
#pragma INTERRUPT(ISR1, HPI)
interrupt void ISR1(void)
{
    //
    // ISR is triggered by the ADC every DRDY cycle
    // Send the new data Transmit frame
    // Run the control loop
    //

    BTS_runISR_ch1_4();


}
#pragma CODE_SECTION(ISR3,"isrcodefuncs");
#pragma INTERRUPT(ISR3, HPI)
interrupt void ISR3(void)
{
    //
    // ISR is triggered by the ADC every DRDY cycle
    // Send the new data Transmit frame
    // Run the control loop
    //

    BTS_runISR_ch5_8();


}

#pragma CODE_SECTION(ISR2,"isrcodefuncs");
#pragma INTERRUPT(ISR2, HPI)
interrupt void ISR2(void)
{
    BTS_ExAdcRead_ch1_4();

}
#pragma CODE_SECTION(ISR4,"isrcodefuncs");
#pragma INTERRUPT(ISR4, HPI)
interrupt void ISR4(void)
{
    BTS_ExAdcRead_ch5_8();

}

#if (BTS_SFRA_ENABLED == true) && ( BTS_SFRA_ISR_SRC == BTS_SFRA_ISR_SRC_PWM)
#pragma CODE_SECTION(epwm1ISR,"isrcodefuncs");
#pragma INTERRUPT(epwm1ISR, HPI)
interrupt void epwm1ISR(void)
{
    BTS_ISR_SFRA();

    EPWM_clearEventTriggerInterruptFlag(BTS_EPWM_BASE_CH1);

    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP3);                    // Acknowledge the interrupt
}
#endif
//
//=============================================================================
//  STATE-MACHINE SEQUENCING AND SYNCRONIZATION FOR SLOW BACKGROUND TASKS
//=============================================================================
//
//
//--------------------------------- FRAME WORK --------------------------------
//
void A0(void)
{
    //
    // loop rate synchronizer for A-tasks
    //
    if(GET_TASKA_TIMER_OVERFLOW_STATUS == 1)
    {
        CLEAR_TASKA_TIMER_OVERFLOW_FLAG;    // clear flag

        //
        // jump to an A Task (A1,A2,A3,...)
        //
        (*A_Task_Ptr)();

        vTimer0[0]++;           // virtual timer 0, instance 0 (spare)
    }
    Alpha_State_Ptr = &B0;      // Comment out to allow only A tasks
}

void B0(void)
{
    //
    // loop rate synchronizer for B-tasks
    //
    if(GET_TASKB_TIMER_OVERFLOW_STATUS  == 1)
    {
        CLEAR_TASKB_TIMER_OVERFLOW_FLAG;                // clear flag

        //
        // jump to an B Task (B1,B2,B3,...)
        //
        (*B_Task_Ptr)();

        vTimer1[0]++;           // virtual timer 1, instance 0 (spare)
    }

    Alpha_State_Ptr = &C0;      // Allow C state tasks
}

void C0(void)
{
    //
    // loop rate synchronizer for C-tasks
    //
    if(GET_TASKC_TIMER_OVERFLOW_STATUS  == 1)
    {
        CLEAR_TASKC_TIMER_OVERFLOW_FLAG;                // clear flag

        //
        // jump to an C Task (C1,C2,C3,...)
        //
        (*C_Task_Ptr)();

        vTimer2[0]++;           // virtual timer 2, instance 0 (spare)
    }

    Alpha_State_Ptr = &A0;      // Return to A state tasks
}

//
//=============================================================================
//  A - TASKS (executed at 1kHz)
//=============================================================================
//
void A1(void)
{
    //
    // Calculate the effective ePWM duty or Vout setting based on a
    // combination of user input and maximum slew rate allowed
    //

    BTS_updateReference(&BTS_userInput_ch1,&BTS_ctrlLoopVariable_ch1);
    BTS_updateReference(&BTS_userInput_ch2,&BTS_ctrlLoopVariable_ch2);
    BTS_updateReference(&BTS_userInput_ch3,&BTS_ctrlLoopVariable_ch3);
    BTS_updateReference(&BTS_userInput_ch4,&BTS_ctrlLoopVariable_ch4);
    BTS_updateReference(&BTS_userInput_ch5,&BTS_ctrlLoopVariable_ch5);
    BTS_updateReference(&BTS_userInput_ch6,&BTS_ctrlLoopVariable_ch6);
    BTS_updateReference(&BTS_userInput_ch7,&BTS_ctrlLoopVariable_ch7);
    BTS_updateReference(&BTS_userInput_ch8,&BTS_ctrlLoopVariable_ch8);

    //
    // Execute task A2 the next time CpuTimer0 decrements to 0
    //
    A_Task_Ptr = &A2;
}

void A2(void)
{
    //
    // Service SCI link for SFRA GUI
    //
    BTS_SFRA_GUI_RUN_COMMS(&BTS_sfra);

    //
    // Execute task A3 the next time CpuTimer0 decrements to 0
    //
    A_Task_Ptr = &A3;
}

void A3(void)
{
    //
    // Calibrate HRPWM MEP Scale Factor
    //
    BTS_updateHrpwmMepScaleFactor();

    //
    // Execute task A1 the next time CpuTimer0 decrements to 0
    //
    A_Task_Ptr = &A1;
}

//
//=============================================================================
//  B - TASKS (executed at 100Hz)
//=============================================================================
//
void B1(void)
{
    //
    // Toggle on-board LED to indicate program execution
    //

    //
    // Execute task B2 the next time CpuTimer1 decrements to 0
    //
    B_Task_Ptr = &B2;
}

void B2(void)
{
    //
    // Manage SFRA sweep
    //
    BTS_SFRA_RUN_BACKGROUND(&BTS_sfra);

    //
    // Execute task B3 the next time CpuTimer1 decrements to 0
    //
    B_Task_Ptr = &B3;
}

void B3(void)
{
    //
    // SPARE
    //

    //
    // Execute task B1 the next time CpuTimer1 decrements to 0
    //
    B_Task_Ptr = &B1;
}

//
//=============================================================================
//  C - TASKS (executed at 10Hz)
//=============================================================================
//
void C1(void)
{


    BTS_monitor_Iout_Vout(&BTS_measValues_ch1);
    BTS_monitor_Iout_Vout(&BTS_measValues_ch2);
    BTS_monitor_Iout_Vout(&BTS_measValues_ch3);
    BTS_monitor_Iout_Vout(&BTS_measValues_ch4);
    BTS_monitor_Iout_Vout(&BTS_measValues_ch5);
    BTS_monitor_Iout_Vout(&BTS_measValues_ch6);
    BTS_monitor_Iout_Vout(&BTS_measValues_ch7);
    BTS_monitor_Iout_Vout(&BTS_measValues_ch8);


    //
    // Execute task C2 the next time CpuTimer2 decrements to 0
    //
    C_Task_Ptr = &C2;
}

void C2(void)
{
    static uint16_t channel = 0;

    channel = ++channel % 8;

    BTS_monitor_program_update(&BTS_userInputs[channel], &BTS_measValues[channel]);

    //
    // Execute task C3 the next time CpuTimer2 decrements to 0
    //
    C_Task_Ptr = &C3;
}

void C3(void)
{


    //
    // Execute task C1 the next time CpuTimer2 decrements to 0
    //
    C_Task_Ptr = &C1;
}

//
// End of buck_main.c
//
