/*
 * bts_cpu1.c (previously bts_main.c)
 *
 * TITLE: Main file for the solution
 *        Additional solution support files are
 *            <solution>.c -> solution source file
 *            <solution>.h -> solution header file
 *            <solution>_settings.h -> powerSUITE generated settings
 *            <solution>_hal.c -> device drivers source file
 *            <solution>_hal.h -> device drivers header file
 *
 * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
 * ALL RIGHTS RESERVED
 */

#ifdef CPU1
#include <bts.h>
#include "registers.h"

//
//--- State Machine Related ---
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


__interrupt void adcCellVoltageISR(void);

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

// Global unit state
volatile UnitState unitState = eInputOK;

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

    // Setup the GPIO for Mode Switches etc
    BTS_HAL_setupGPIO();

    // Initialize ADC
    BTS_HAL_setupADC();

    // Setup ADC trigger for 10kHz sampling
    BTS_HAL_setupAdcTrigger(EPWM1_BASE);

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

#if BTS_SFRA_ENABLED && (BTS_SFRA_ISR_SRC == BTS_SFRA_ISR_SRC_PWM)
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

    BTS_HAL_setupInterrupt();

    // Register ADC interrupt for cell voltages and currents
    Interrupt_register(INT_ADCA1, &adcCellVoltageISR);
    Interrupt_enable(INT_ADCA1);

    //
    // Switch actuation pins over to ePWM function
    //
    BTS_HAL_setupSyncBuckPinsEpwm();

    BTS_HAL_ExAdcTxframe(BTS_SPI_BASE_ADC1);
    BTS_HAL_ExAdcTxframe(BTS_SPI_BASE_ADC2);

#ifdef _FLASH
    Device_bootCPU2(C1C2_BROM_BOOTMODE_BOOT_FROM_FLASH);
#else
    Device_bootCPU2(C1C2_BROM_BOOTMODE_BOOT_FROM_RAM);
#endif

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
#pragma CODE_SECTION(ISR1, "isrcodefuncs")
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

#pragma CODE_SECTION(ISR3, "isrcodefuncs")
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

#pragma CODE_SECTION(ISR2, "isrcodefuncs")
#pragma INTERRUPT(ISR2, HPI)
interrupt void ISR2(void)
{
    BTS_ExAdcRead_ch1_4();
}

#pragma CODE_SECTION(ISR4, "isrcodefuncs")
#pragma INTERRUPT(ISR4, HPI)
interrupt void ISR4(void)
{
    BTS_ExAdcRead_ch5_8();
}

#if (BTS_SFRA_ENABLED == true) && (BTS_SFRA_ISR_SRC == BTS_SFRA_ISR_SRC_PWM)
#pragma CODE_SECTION(epwm1ISR, "isrcodefuncs")
#pragma INTERRUPT(epwm1ISR, HPI)
interrupt void epwm1ISR(void)
{
    BTS_ISR_SFRA();
    EPWM_clearEventTriggerInterruptFlag(BTS_EPWM_BASE_CH1);
    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP3);
}
#endif

extern volatile float registers[TOTAL_REGISTERS];

void updateStatusRegisters(void)
{
    uint16_t ch = 0;
    for (ch = 0; ch < NUM_CHANNELS; ch++) {
        uint32_t bitset = 0;
        bitset |= (status[ch].running & 0x1) << 0;
        bitset |= (status[ch].stopped & 0x1) << 1;
        bitset |= (status[ch].finished & 0x1) << 2;
        bitset |= (status[ch].overCurrentTrip & 0x1) << 3;
        bitset |= (status[ch].charging & 0x1) << 4;
        bitset |= (status[ch].discharging & 0x1) << 5;
        bitset |= (status[ch].constVoltage & 0x1) << 6;
        bitset |= (status[ch].constCurrent & 0x1) << 7;
        registers[eCh0_Status / 4 + ch * 10] = (float)bitset;
    }
}

void modeCallback(float value, uint16_t channel)
{
    uint32_t mode = (uint32_t)value;

    if (channel < NUM_CHANNELS) {
        float chargeDisableV = registers[eChargeDisableV / 4];
        float chargeRestrictV = registers[eChargeRestrictV / 4];
        float dischargeRestrictV = registers[eDischargeRestrictV / 4];
        float dischargeDisableV = registers[eDischargeDisableV / 4];

        float inputV = registers[eInputVoltage / 4];
        if ((mode & 0x02) && (inputV <= chargeRestrictV)) {
            status[channel].running = 0;
            status[channel].stopped = 1;
            BTS_userInputs[channel].enable_logic = 0;
            updateStatusRegisters();
            return;
        }
        if (!(mode & 0x02) && (inputV >= dischargeRestrictV)) {
            status[channel].running = 0;
            status[channel].stopped = 1;
            BTS_userInputs[channel].enable_logic = 0;
            updateStatusRegisters();
            return;
        }

        status[channel].running = mode & 0x01;
        status[channel].stopped = !(mode & 0x01);
        status[channel].charging = (mode & 0x02) >> 1;
        status[channel].discharging = !((mode & 0x02) >> 1);
        if (mode & 0x01) {
            uint16_t regBase = channel * 10;
            float vMin = (mode & 0x02) ? registers[(eCh0_ChargeVoltageMin / 4) + regBase] : registers[(eCh0_DischargeVoltageMin / 4) + regBase];
            float vMax = (mode & 0x02) ? registers[(eCh0_ChargeVoltageMax / 4) + regBase] : registers[(eCh0_DischargeVoltageMax / 4) + regBase];
            float iMin = (mode & 0x02) ? registers[(eCh0_ChargeCurrentMin / 4) + regBase] : registers[(eCh0_DischargeCurrentMin / 4) + regBase];
            float iMax = (mode & 0x02) ? registers[(eCh0_ChargeCurrentMax / 4) + regBase] : registers[(eCh0_DischargeCurrentMax / 4) + regBase];

            BTS_userInputs[channel].vref_charge_V = vMax;
            BTS_userInputs[channel].vref_discharge_V = vMin;
            BTS_userInputs[channel].iref_A = iMax;
            BTS_userInputs[channel].iref_cuttout_A = iMin;
            BTS_userInputs[channel].direction_logic = status[channel].charging;
            BTS_userInputs[channel].enable_logic = 1;
        } else {
            BTS_userInputs[channel].enable_logic = 0;
        }
        updateStatusRegisters();
    }
}

extern volatile struct { uint16_t regAddr; float value; } ipcMsg;

void BTS_HandleRegisterWrite(void)
{
    if (IPC_isFlagBusyRtoL(IPC_CPU1_L_CPU2_R, IPC_FLAG0)) {
        uint16_t regAddr = ipcMsg.regAddr;
        if (regAddr < NUM_CONTROL_REGISTERS) {
            registers[regAddr] = ipcMsg.value;
            uint16_t channel = regAddr / 10;
            if (regAddr % 10 == 0) { // Mode register
                modeCallback(ipcMsg.value, channel);
            }
        } else if (regAddr >= eCh0_CellVoltage/4 && regAddr < (eCh0_CellVoltage/4 + NUM_CHANNELS)) {
            registers[regAddr] = ipcMsg.value;
        }
        IPC_clearFlagRtoL(IPC_CPU1_L_CPU2_R, IPC_FLAG0);
    }
    if (IPC_isFlagBusyRtoL(IPC_CPU1_L_CPU2_R, IPC_FLAG1)) {
        uint16_t regIdx = ipcMsg.regAddr;
        if (regIdx >= eCh0_CellVoltage/4 && regIdx < (eCh0_CellVoltage/4 + NUM_CHANNELS)) {
            registers[regIdx] = ipcMsg.value;
        }
        IPC_clearFlagRtoL(IPC_CPU1_L_CPU2_R, IPC_FLAG1);
    }
}

// Update BTS_monitor_Iout_Vout
#pragma CODE_SECTION(BTS_monitor_Iout_Vout, "ramfuncs")
void BTS_monitor_Iout_Vout(BTS_measValue* measValues)
{
    measValues->Sum_I = 0U;
    measValues->Sum_V = 0U;
    measValues->Sum_CellV = 0U;
    measValues->Sum_CellI = 0U;
    uint16_t index;
    float32_t avgValue = 0.0;
    for (index = 0U; index < BTS_senseAverageFactor; index++) {
        measValues->Sum_I += measValues->Isense_16b[index];
        measValues->Sum_V += measValues->Vsense_16b[index];
    }
    for (index = 0U; index < BTS_f28AverageFactor; index++) {
        measValues->Sum_CellV += measValues->CellVoltage_16b[index];
        measValues->Sum_CellI += measValues->CellCurrent_16b[index];
    }
    avgValue = (float32_t)measValues->Sum_I / ((float32_t)BTS_senseAverageFactor * 32768.0);
    measValues->Isense_A = measValues->IoutGain_A * avgValue + measValues->IoutOffset_A;
    avgValue = (float32_t)measValues->Sum_V / ((float32_t)BTS_senseAverageFactor * 32768.0);
    measValues->Vsense_V = measValues->VoutGain_V * avgValue + measValues->VoutOffset_V;
    avgValue = (float32_t)measValues->Sum_CellV / ((float32_t)BTS_f28AverageFactor * 4096.0);
    measValues->CellVoltage_V = (avgValue * 2.5f) * measValues->F28V_Gain + measValues->F28V_Offset;
    avgValue = (float32_t)measValues->Sum_CellI / ((float32_t)BTS_f28AverageFactor * 4096.0);
    measValues->CellCurrent_I = (avgValue * 2.5f) * measValues->F28I_Gain + measValues->F28I_Offset;
}
//
//=============================================================================
// STATE-MACHINE SEQUENCING AND SYNCRONIZATION FOR SLOW BACKGROUND TASKS
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
// A - TASKS (executed at 1kHz)
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
// B - TASKS (executed at 100Hz)
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
    BTS_HandleRegisterWrite();
    //
    // Execute task B1 the next time CpuTimer1 decrements to 0
    //
    B_Task_Ptr = &B1;
}

//
// C - TASKS (executed at 10Hz)
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

    updateInputVoltage();

    float chargeDisableV = registers[eChargeDisableV / 4];
    float chargeRestrictV = registers[eChargeRestrictV / 4];
    float dischargeRestrictV = registers[eDischargeRestrictV / 4];
    float dischargeDisableV = registers[eDischargeDisableV / 4];

    for (uint16_t ch = 0; ch < NUM_CHANNELS; ch++) {
        uint16_t base = (eCh0_MinCellTemp / 4) + ch * 10;
        float minTemp = registers[base + 0];
        float maxTemp = registers[base + 1];

        float inputV = registers[eInputVoltage / 4];
        if (status[ch].running) {
            if (status[ch].charging && inputV <= chargeRestrictV) {
                status[ch].running = 0;
                status[ch].stopped = 1;
                BTS_userInputs[ch].enable_logic = 0;
                updateStatusRegisters();
            }
            if (status[ch].discharging && inputV >= dischargeRestrictV) {
                status[ch].running = 0;
                status[ch].stopped = 1;
                BTS_userInputs[ch].enable_logic = 0;
                updateStatusRegisters();
            }
        }
    }
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

static void updateInputVoltage(void)
{
    ADC_forceSOC(ADCB_BASE, ADC_SOC_NUMBER1);
    ADC_forceSOC(ADCB_BASE, ADC_SOC_NUMBER2);

    while(ADC_getInterruptStatus(ADCB_BASE, ADC_INT_NUMBER1) == 0);

    uint16_t busVoltageRaw = ADC_readResult(ADCB_BASE, ADC_SOC_NUMBER1);
    uint16_t spareRaw = ADC_readResult(ADCB_BASE, ADC_SOC_NUMBER2);

    float busVoltage = (busVoltageRaw * 17.9f * 3.3f) / (4096.0f * 2.5f);
    registers[eInputVoltage / 4] = busVoltage;

    float chargeDisableV = registers[eChargeDisableV / 4];
    float chargeRestrictV = registers[eChargeRestrictV / 4];
    float dischargeRestrictV = registers[eDischargeRestrictV / 4];
    float dischargeDisableV = registers[eDischargeDisableV / 4];

    if (busVoltage <= chargeDisableV) {
        if (unitState != eInputLow_ChargeDisabled) {
            unitState = eInputLow_ChargeRestricted;
        }
        static uint16_t lowCount = 0;
        if (unitState == eInputLow_ChargeRestricted && ++lowCount >= 10) {
            unitState = eInputLow_ChargeDisabled;
            lowCount = 0;
        }
    } else if (busVoltage <= chargeRestrictV) {
        unitState = eInputLow_ChargeRestricted;
    } else if (busVoltage >= dischargeDisableV) {
        if (unitState != eInputHigh_DischargeDisabled) {
            unitState = eInputHigh_DischargeRestricted;
        }
        static uint16_t highCount = 0;
        if (unitState == eInputHigh_DischargeRestricted && ++highCount >= 10) {
            unitState = eInputHigh_DischargeDisabled;
            highCount = 0;
        }
    } else if (busVoltage >= dischargeRestrictV) {
        unitState = eInputHigh_DischargeRestricted;
    } else {
        unitState = eInputOK;
    }

    registers[eUnitState / 4] = (float)unitState;
}

#pragma CODE_SECTION(adcCellVoltageISR, "isrcodefuncs")
#pragma INTERRUPT(adcCellVoltageISR, HPI)
__interrupt void adcCellVoltageISR(void)
{
    int16_t vRaw[8] = {
        ADC_readResult(ADCA_BASE, ADC_SOC_NUMBER0), // Ch1: A3
        ADC_readResult(ADCB_BASE, ADC_SOC_NUMBER0), // Ch2: B3
        ADC_readResult(ADCA_BASE, ADC_SOC_NUMBER1), // Ch3: A5
        ADC_readResult(ADCA_BASE, ADC_SOC_NUMBER2), // Ch4: IN15
        ADC_readResult(ADCD_BASE, ADC_SOC_NUMBER0), // Ch5: D1
        ADC_readResult(ADCC_BASE, ADC_SOC_NUMBER0), // Ch6: C3
        ADC_readResult(ADCD_BASE, ADC_SOC_NUMBER1), // Ch7: D3
        ADC_readResult(ADCC_BASE, ADC_SOC_NUMBER1)  // Ch8: C5
    };
    int16_t iRaw[8] = {
        ADC_readResult(ADCA_BASE, ADC_SOC_NUMBER3), // Ch1: A2
        ADC_readResult(ADCB_BASE, ADC_SOC_NUMBER3), // Ch2: B2
        ADC_readResult(ADCA_BASE, ADC_SOC_NUMBER4), // Ch3: A4
        ADC_readResult(ADCA_BASE, ADC_SOC_NUMBER5), // Ch4: IN14
        ADC_readResult(ADCD_BASE, ADC_SOC_NUMBER2), // Ch5: D0
        ADC_readResult(ADCC_BASE, ADC_SOC_NUMBER2), // Ch6: C2
        ADC_readResult(ADCD_BASE, ADC_SOC_NUMBER3), // Ch7: D2
        ADC_readResult(ADCC_BASE, ADC_SOC_NUMBER3)  // Ch8: C4
    };
    int16_t refRaw = ADC_readResult(ADCA_BASE, ADC_SOC_NUMBER6); // A0

    for (uint16_t ch = 0; ch < NUM_CHANNELS; ch++) {
        int16_t cellCurrent = iRaw[ch] - refRaw;
        BTS_storeValuesf28(&BTS_measValues[ch], vRaw[ch], cellCurrent);
        registers[(eCh0_CellVoltage / 4) + ch] = BTS_measValues[ch].CellVoltage_V;
        registers[(eCh0_CellCurrent / 4) + ch] = BTS_measValues[ch].CellCurrent_I;
    }

    ADC_clearInterruptStatus(ADCA_BASE, ADC_INT_NUMBER1);
    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP1);
}

// Interrupt handler for ePWM Trip Zone
#pragma CODE_SECTION(epwmTripISR, "isrcodefuncs")
#pragma INTERRUPT(epwmTripISR, HPI)
__interrupt void epwmTripISR(void) {
    // Determine which ePWM module triggered
    uint32_t intSource = Interrupt_getVectorNumber();
    uint16_t epwmIndex = (intSource - INT_EPWM1) + 1;
    uint32_t epwmBase = EPWM1_BASE + (epwmIndex - 1) * 0x1000;
    uint16_t channel = epwmIndex - 1;

    // Get trip zone status
    uint32_t tzStatus = EPWM_getTripZoneFlagStatus(epwmBase);

    if (tzStatus & EPWM_TZ_FLAG_OST) {
        // Update existing status register (overCurrentTrip bit)
        uint16_t statusReg = eCh0_Status / 4 + channel * 10;
        //(uint32_t)registers[statusReg] = (uint32_t)registers[statusReg] | (uint32_t)(1 << 3);

        // Update trip status register (eTripStatus)
        TripStatusBitfield* tripStatus = (TripStatusBitfield*)&registers[eTripStatus / 4];
        if (EPWM_getTripZoneFlagStatus(epwmBase) & EPWM_TZ_FLAG_DCAEVT1) {
            // CMPSS trip (TZ1)
            switch (channel) {
                case 0: tripStatus->ch0_cmpss = 1; break;
                case 1: tripStatus->ch1_cmpss = 1; break;
                case 2: tripStatus->ch2_cmpss = 1; break;
                case 3: tripStatus->ch3_cmpss = 1; break;
                case 4: tripStatus->ch4_cmpss = 1; break;
                case 5: tripStatus->ch5_cmpss = 1; break;
                case 6: tripStatus->ch6_cmpss = 1; break;
                case 7: tripStatus->ch7_cmpss = 1; break;
            }
        }
        if (EPWM_getTripZoneFlagStatus(epwmBase) & EPWM_TZ_FLAG_DCAEVT2) {
            // GPIO trip (TZ2)
            switch (channel) {
                case 0: tripStatus->ch0_gpio = 1; break;
                case 1: tripStatus->ch1_gpio = 1; break;
                case 2: tripStatus->ch2_gpio = 1; break;
                case 3: tripStatus->ch3_gpio = 1; break;
                case 4: tripStatus->ch4_gpio = 1; break;
                case 5: tripStatus->ch5_gpio = 1; break;
                case 6: tripStatus->ch6_gpio = 1; break;
                case 7: tripStatus->ch7_gpio = 1; break;
            }
        }

        // Clear trip flags
        EPWM_clearTripZoneFlag(epwmBase, EPWM_TZ_FLAG_OST | EPWM_TZ_FLAG_DCAEVT1 | EPWM_TZ_FLAG_DCAEVT2);
    }

    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP3);
}

#endif
