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
// Local helpers
//
static void updateInputVoltage(void);
static void publishStatusToCpu2(void);
void updateStatusRegisters(void);
void modeCallback(float value, uint16_t channel);
void BTS_HandleRegisterWrite(void);

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

    //
    // Configure every pin CPU2's peripherals use, while CPU1 still owns the
    // mux registers. This must precede both the peripheral (CPUSEL) and pin
    // (GPxCSEL) handovers below, and CPU2 starting.
    //
    BTS_HAL_setupCpu2Pins();

    //
    // Assign the peripherals CPU2 drives over to CPU2.
    //
    // Like the GSx RAM, every peripheral belongs to CPU1 after reset and only
    // CPU1 can reassign it. A core writing a peripheral it does not own has
    // no effect - CAN_initRAM() in particular then spins forever waiting for
    // a RAM_INIT that never completes.
    //
    // CPU2 owns: I2CA (GPIO32/33, the host register bus), I2CB (GPIO40/41,
    // EEPROM + the two ADS1119 temperature ADCs), SCIA (GPIO29 - debug
    // console or WS2812B LED string, per BTS_DEBUG_CONSOLE) and CANA.
    // CPU1 keeps the ePWMs, ADCs, CMPSS and the SPI ports for the external
    // ADCs.
    //
    SysCtl_selectCPUForPeripheral(SYSCTL_CPUSEL7_I2C, 1, SYSCTL_CPUSEL_CPU2); // I2CA
    SysCtl_selectCPUForPeripheral(SYSCTL_CPUSEL7_I2C, 2, SYSCTL_CPUSEL_CPU2); // I2CB
    SysCtl_selectCPUForPeripheral(SYSCTL_CPUSEL8_CAN, 1, SYSCTL_CPUSEL_CPU2); // CANA

    //
    // SCIA is contended: CPU2 uses it for the WS2812B LEDs, or for the debug
    // console when BTS_DEBUG_CONSOLE is set. CPU1 needs it only for
    // the SFRA GUI. They cannot both have it.
    //
#if (BTS_SFRA_ENABLED == true)
    //
    // Leave SCIA with CPU1 for the SFRA GUI. CPU2's LED driver and, if
    // selected, its console will not function.
    //
#else
    SysCtl_selectCPUForPeripheral(SYSCTL_CPUSEL5_SCI, 1, SYSCTL_CPUSEL_CPU2); // SCIA
#endif

    //
    // Hand CPU2 the GPIO pins its peripherals use.
    //
    // Peripheral ownership (CPUSEL) and pin ownership (GPxCSEL) are separate.
    // The GPIO mux registers belong to CPU1 after reset, so GPIO_setPinConfig
    // on CPU2 is silently discarded until the pin is assigned here - the
    // peripheral ends up configured but unable to reach any pin.
    //
    GPIO_setControllerCore(32, GPIO_CORE_CPU2);   // I2CA SDAA - register bus
    GPIO_setControllerCore(33, GPIO_CORE_CPU2);   // I2CA SCLA
    GPIO_setControllerCore(40, GPIO_CORE_CPU2);   // I2CB SDAB - EEPROM + ADS1119
    GPIO_setControllerCore(41, GPIO_CORE_CPU2);   // I2CB SCLB
    GPIO_setControllerCore(42, GPIO_CORE_CPU2);   // ADS1119 #1 DRDY
    GPIO_setControllerCore(43, GPIO_CORE_CPU2);   // ADS1119 #2 DRDY
    GPIO_setControllerCore(30, GPIO_CORE_CPU2);   // CANA RX
    GPIO_setControllerCore(31, GPIO_CORE_CPU2);   // CANA TX

    //
    // GPIO29 is CPU2's in both modes: console TX when debugging, WS2812B LED
    // output in production. GPIO28 is CPU2's console RX only in a debug
    // build - in production it stays with CPU1 as channel 1's trip input.
    //
    GPIO_setControllerCore(29, GPIO_CORE_CPU2);
#if (BTS_TRIP_GPIO_CH1_ENABLED == false)
    GPIO_setControllerCore(28, GPIO_CORE_CPU2);
#endif


    //
    // Hand the global-shared RAM blocks CPU2 uses over to CPU2.
    //
    // After reset every GSx block is owned by CPU1. CPU2 cannot write - or
    // execute from - a block it does not own, and only CPU1 can change the
    // ownership. CPU2's linker file places .bss/.sysmem in GS11-GS13 and its
    // ramfuncs (including Flash_initModule) in GS14/GS15, so without this the
    // memcpy in CPU2's Device_init silently fails, CPU2 executes zeros at
    // 0x01A000 and traps into boot ROM at 0x3FE00A.
    //
    // Must happen before CPU2 starts running. CPU1 keeps GS0-GS10.
    //
    MemCfg_setGSRAMControllerSel(MEMCFG_SECT_GS11 | MEMCFG_SECT_GS12 |
                                 MEMCFG_SECT_GS13 | MEMCFG_SECT_GS14 |
                                 MEMCFG_SECT_GS15,
                                 MEMCFG_GSRAMCONTROLLER_CPU2);

    //
    // Release CPU2.
    //
    // Only do this in a standalone (no-debugger) build. When running under
    // CCS the debugger loads and starts CPU2 itself, and Device_bootCPU2()
    // would block forever in its do/while waiting for the boot ROM to report
    // C2_BOOTROM_BOOTSTS_SYSTEM_READY - leaving CPU1 stalled here and CPU2
    // parked in boot ROM around 0x3FE00A.
    //
    // This mirrors TI's own project configurations, where _STANDALONE is a
    // separate build config from plain _FLASH (see the C2000Ware dual-core
    // examples, e.g. led_ex1_blinky.projectspec).
    //
#ifdef _STANDALONE
#ifdef _FLASH
    Device_bootCPU2(C1C2_BROM_BOOTMODE_BOOT_FROM_FLASH);
#else
    Device_bootCPU2(C1C2_BROM_BOOTMODE_BOOT_FROM_RAM);
#endif
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

//
// Publishes the CPU1-owned status and measurements into the CPU1->CPU2
// message RAM. CPU2 mirrors these into registers[] for the external
// interfaces. seq is bumped either side of the payload so CPU2 can detect a
// torn read.
//
static void publishStatusToCpu2(void)
{
    uint16_t ch;

    cpu1Status.seq++;

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
        cpu1Status.statusBits[ch] = bitset;

        cpu1Status.cellVoltage[ch] = BTS_measValues[ch].CellVoltage_V;
        cpu1Status.cellCurrent[ch] = BTS_measValues[ch].CellCurrent_I;

        canData[ch].channel = ch;
        canData[ch].voltage = BTS_measValues[ch].CellVoltage_V;
        canData[ch].current = BTS_measValues[ch].CellCurrent_I;
    }

    cpu1Status.unitState = (uint32_t)unitState;

    cpu1Status.seq++;
}

void updateStatusRegisters(void)
{
    publishStatusToCpu2();
}

void modeCallback(float value, uint16_t channel)
{
    uint32_t mode = (uint32_t)value;

    if (channel < NUM_CHANNELS) {
        float chargeRestrictV = registers[BTS_REG_IDX(eChargeRestrictV)];
        float dischargeRestrictV = registers[BTS_REG_IDX(eDischargeRestrictV)];

        float inputV = registers[BTS_REG_IDX(eInputVoltage)];
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
            uint16_t regBase = BTS_CTRL_BASE(channel);
            uint16_t vMinIdx = (mode & 0x02) ? BTS_REG_IDX(eCh0_ChargeVoltageMin)  : BTS_REG_IDX(eCh0_DischargeVoltageMin);
            uint16_t vMaxIdx = (mode & 0x02) ? BTS_REG_IDX(eCh0_ChargeVoltageMax)  : BTS_REG_IDX(eCh0_DischargeVoltageMax);
            uint16_t iMinIdx = (mode & 0x02) ? BTS_REG_IDX(eCh0_ChargeCurrentMin)  : BTS_REG_IDX(eCh0_DischargeCurrentMin);
            uint16_t iMaxIdx = (mode & 0x02) ? BTS_REG_IDX(eCh0_ChargeCurrentMax)  : BTS_REG_IDX(eCh0_DischargeCurrentMax);

            BTS_userInputs[channel].vref_charge_V    = registers[regBase + vMaxIdx];
            BTS_userInputs[channel].vref_discharge_V = registers[regBase + vMinIdx];
            BTS_userInputs[channel].iref_A           = registers[regBase + iMaxIdx];
            BTS_userInputs[channel].iref_cuttout_A   = registers[regBase + iMinIdx];
            BTS_userInputs[channel].direction_logic  = status[channel].charging;
            BTS_userInputs[channel].enable_logic     = 1;
        } else {
            BTS_userInputs[channel].enable_logic = 0;
        }
        updateStatusRegisters();
    }
}

//
// Handles messages from the communications CPU.
//
//   BTS_IPC_FLAG_REG_WRITE   one register changed; ipcMsg carries the index
//   BTS_IPC_FLAG_TEMP_UPDATE a cell temperature was refreshed
//   BTS_IPC_FLAG_CAL_RELOAD  the whole calibration block was reloaded
//
// registers[] itself lives in CPU2's message RAM and has already been
// updated by CPU2 before the flag was raised - CPU1 only reacts to the
// change, it never writes the register file.
//
void BTS_HandleRegisterWrite(void)
{
    if (IPC_isFlagBusyRtoL(IPC_CPU1_L_CPU2_R, BTS_IPC_FLAG_REG_WRITE)) {
        uint16_t regIdx = ipcMsg.regAddr;

        if (regIdx < BTS_REG_IDX(eCh0_CurrentAcc)) {
            //
            // Control block: 10 registers per channel, mode is the first.
            //
            uint16_t channel = regIdx / BTS_CTRL_REGS_PER_CH;
            if ((regIdx % BTS_CTRL_REGS_PER_CH) == 0) {
                modeCallback(ipcMsg.value, channel);
            }
        } else if (regIdx >= BTS_CAL_BASE(0) &&
                   regIdx <  BTS_CAL_BASE(0) + NUM_CHANNELS * BTS_CAL_REGS_PER_CH) {
            //
            // Calibration block: pull the whole channel in and schedule a
            // recalculation on the next C2 task.
            //
            uint16_t channel = (regIdx - BTS_CAL_BASE(0)) / BTS_CAL_REGS_PER_CH;
            BTS_loadCalibrationFromRegisters(channel);
        }

        IPC_ackFlagRtoL(IPC_CPU1_L_CPU2_R, BTS_IPC_FLAG_REG_WRITE);
    }

    if (IPC_isFlagBusyRtoL(IPC_CPU1_L_CPU2_R, BTS_IPC_FLAG_TEMP_UPDATE)) {
        //
        // Temperatures are advisory to the control loops; the value is
        // already visible in registers[]. Nothing to recalculate.
        //
        IPC_ackFlagRtoL(IPC_CPU1_L_CPU2_R, BTS_IPC_FLAG_TEMP_UPDATE);
    }

    if (IPC_isFlagBusyRtoL(IPC_CPU1_L_CPU2_R, BTS_IPC_FLAG_CAL_RELOAD)) {
        //
        // CPU2 has reloaded every channel's calibration (boot, or a bulk
        // host update). Re-derive the whole program.
        //
        uint16_t ch;
        for (ch = 0; ch < NUM_CHANNELS; ch++) {
            BTS_loadCalibrationFromRegisters(ch);
        }
        IPC_ackFlagRtoL(IPC_CPU1_L_CPU2_R, BTS_IPC_FLAG_CAL_RELOAD);
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

    float chargeRestrictV = registers[BTS_REG_IDX(eChargeRestrictV)];
    float dischargeRestrictV = registers[BTS_REG_IDX(eDischargeRestrictV)];
    float inputV = registers[BTS_REG_IDX(eInputVoltage)];

    for (uint16_t ch = 0; ch < NUM_CHANNELS; ch++) {
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
    // Publish this pass's measurements and status to CPU2.
    //
    publishStatusToCpu2();

    //
    // Execute task C2 the next time CpuTimer2 decrements to 0
    //
    C_Task_Ptr = &C2;
}

void C2(void)
{
    static uint16_t channel = 0;

    //
    // Service one channel's pending calibration update per pass. This only
    // touches in-memory program variables; EEPROM persistence lives on CPU2.
    //
    BTS_monitor_program_update(channel);

    channel = (channel + 1U) % NUM_CHANNELS;

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

    float busVoltage = (busVoltageRaw * 17.9f * 3.3f) / (4096.0f * 2.5f);

    //
    // registers[] is CPU2-owned; publish through the CPU1->CPU2 block and
    // let CPU2 mirror it into eInputVoltage / eUnitState.
    //
    cpu1Status.inputVoltage = busVoltage;

    float chargeDisableV = registers[BTS_REG_IDX(eChargeDisableV)];
    float chargeRestrictV = registers[BTS_REG_IDX(eChargeRestrictV)];
    float dischargeRestrictV = registers[BTS_REG_IDX(eDischargeRestrictV)];
    float dischargeDisableV = registers[BTS_REG_IDX(eDischargeDisableV)];

    static uint16_t lowCount = 0;
    static uint16_t highCount = 0;

    if (busVoltage <= chargeDisableV) {
        if (unitState != eInputLow_ChargeDisabled) {
            unitState = eInputLow_ChargeRestricted;
        }
        if (unitState == eInputLow_ChargeRestricted && ++lowCount >= 10) {
            unitState = eInputLow_ChargeDisabled;
            lowCount = 0;
        }
    } else if (busVoltage <= chargeRestrictV) {
        unitState = eInputLow_ChargeRestricted;
        lowCount = 0;
    } else if (busVoltage >= dischargeDisableV) {
        if (unitState != eInputHigh_DischargeDisabled) {
            unitState = eInputHigh_DischargeRestricted;
        }
        if (unitState == eInputHigh_DischargeRestricted && ++highCount >= 10) {
            unitState = eInputHigh_DischargeDisabled;
            highCount = 0;
        }
    } else if (busVoltage >= dischargeRestrictV) {
        unitState = eInputHigh_DischargeRestricted;
        highCount = 0;
    } else {
        unitState = eInputOK;
        lowCount = 0;
        highCount = 0;
    }

    cpu1Status.unitState = (uint32_t)unitState;
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
        BTS_storeValuesF28(&BTS_measValues[ch], vRaw[ch], cellCurrent);
    }

    ADC_clearInterruptStatus(ADCA_BASE, ADC_INT_NUMBER1);
    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP1);
}

// Interrupt handler for ePWM Trip Zone
//
// All eight modules share this handler, so the source has to be identified
// from the hardware rather than from the vector. driverlib has no
// "get current vector" API - the supported mechanism is to read each
// module's trip-zone flags (TZFLG) and service whichever have latched.
//
// EPWM_getTripZoneFlagStatus() reports *which kind* of trip fired
// (EPWM_TZ_FLAG_OST for the one-shot inputs); EPWM_getOneShotTripZoneFlagStatus()
// reports *which one-shot input* fired. BTS_HAL_setupEPWMTripZone() enables
// OSHT1 (CMPSS via Input X-BAR) and OSHT2 (GPIO group trip), so those map to
// EPWM_TZ_OST_FLAG_OST1 and EPWM_TZ_OST_FLAG_OST2 respectively.
//
#pragma CODE_SECTION(epwmTripISR, "isrcodefuncs")
#pragma INTERRUPT(epwmTripISR, HPI)
__interrupt void epwmTripISR(void) {
    uint32_t tripBits = cpu1Status.tripStatus;
    uint16_t channel;
    //
    // Guards against a permanently-asserted trip source. If a channel keeps
    // re-entering, its trip interrupt is masked so the background loop can
    // still run - the trip action itself (PWM forced low) stays latched in
    // hardware, so the channel remains safe.
    //
    static uint16_t reentryCount[NUM_CHANNELS] = {0};

    for (channel = 0; channel < NUM_CHANNELS; channel++) {
        uint32_t epwmBase = EPWM1_BASE + (uint32_t)channel * (EPWM2_BASE - EPWM1_BASE);
        uint16_t tzStatus = EPWM_getTripZoneFlagStatus(epwmBase);

        if ((tzStatus & EPWM_TZ_FLAG_OST) == 0U) {
            continue;
        }

        uint16_t ostStatus = EPWM_getOneShotTripZoneFlagStatus(epwmBase);

        // TripStatusBitfield packs two bits per channel: cmpss then gpio.
        if (ostStatus & EPWM_TZ_OST_FLAG_OST1) {   // CMPSS over-current trip
            tripBits |= 1UL << (channel * 2U);
        }
        if (ostStatus & EPWM_TZ_OST_FLAG_OST2) {   // GPIO group trip
            tripBits |= 1UL << (channel * 2U + 1U);
        }

        status[channel].overCurrentTrip = 1;
        status[channel].running = 0;
        status[channel].stopped = 1;
        BTS_userInputs[channel].enable_logic = 0;
        BTS_ctrlLoopVariables[channel].tripFlag = 1;

        //
        // Clear the latched one-shot sources, then the OST flag itself and
        // the global trip-zone interrupt flag so the next trip can assert.
        //
        EPWM_clearOneShotTripZoneFlag(epwmBase,
                                      EPWM_TZ_OST_FLAG_OST1 | EPWM_TZ_OST_FLAG_OST2);
        EPWM_clearTripZoneFlag(epwmBase, EPWM_TZ_FLAG_OST | EPWM_TZ_INTERRUPT);

        //
        // If the source re-asserts immediately the flag will still be set on
        // the next pass. Mask this channel's trip interrupt after a burst so
        // a stuck input cannot starve the background loop.
        //
        if (EPWM_getTripZoneFlagStatus(epwmBase) & EPWM_TZ_FLAG_OST) {
            if (++reentryCount[channel] >= 16U) {
                EPWM_disableTripZoneInterrupt(epwmBase, EPWM_TZ_INTERRUPT_OST);
            }
        } else {
            reentryCount[channel] = 0;
        }
    }

    cpu1Status.tripStatus = tripBits;
    updateStatusRegisters();

    //
    // The trip-zone interrupts (INT_EPWMx_TZ) are in PIE group 2.
    //
    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP2);
}

#endif
