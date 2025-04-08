//#############################################################################
//
// FILE:  buck_hal.c
//
// TITLE: Solution hardware abstraction layer
//        Low level functions and resources with hardware dependencies
//        Example: Functions to read current and voltage signals
//        Example: Functions to configure device peripherals
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

#include <bts_hal.h>

//
//=============================================================================
// variables
//=============================================================================
//

adc_data  BTS_ADC1;
adc_data  BTS_ADC2;
volatile uint16_t BTS_ExAdcRxflag1 ;
volatile uint16_t BTS_ExAdcRxflag2 ;

#if(BUCK_DRV_EPWM_HR_ENABLED == true)
    volatile uint32_t ePWM[9] =
                        {0, EPWM1_BASE, EPWM2_BASE, EPWM3_BASE, EPWM4_BASE,
                            EPWM5_BASE, EPWM6_BASE, EPWM7_BASE, EPWM8_BASE};
#endif

#if(BTS_DRV_EPWM_HR_ENABLED == true)
    volatile uint32_t ePWM[9] =
                        {0, EPWM1_BASE, EPWM2_BASE, EPWM3_BASE, EPWM4_BASE,
                            EPWM5_BASE, EPWM6_BASE, EPWM7_BASE, EPWM8_BASE};
#endif


//
// BTS_HAL_setupDevice - Initialize device after boot and configure system
// resources (such as PLL) and moving ramfuncs from FLASH to RAM
//

void BTS_HAL_setupDevice(void)
{
    //
    // Initialize device clock and peripherals
    //
    Device_init();
    //SysCtl_setLowSpeedClock(SYSCTL_LSPCLK_PRESCALE_1);
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
    // Initialize CPU timers for task scheduling
    //

    //
    // TASK A FREQUENCY
    //
    CPUTimer_setPeriod(TASKA_CPUTIMER_BASE, DEVICE_SYSCLK_FREQ / TASKA_FREQ_HZ);

    //
    // TASK B FREQUENCY
    //
    CPUTimer_setPeriod(TASKB_CPUTIMER_BASE, DEVICE_SYSCLK_FREQ / TASKB_FREQ_HZ);

    //
    // TASK C FREQUENCY
    //
    CPUTimer_setPeriod(TASKC_CPUTIMER_BASE, DEVICE_SYSCLK_FREQ / TASKC_FREQ_HZ);

    //
    // Initialize pre-scale counter to divide by 1 (SYSCLKOUT)
    //
    CPUTimer_setPreScaler(TASKA_CPUTIMER_BASE, 0);

    //
    // Initialize pre-scale counter to divide by 1 (SYSCLKOUT)
    //
    CPUTimer_setPreScaler(TASKB_CPUTIMER_BASE, 0);

    //
    // Initialize pre-scale counter to divide by 1 (SYSCLKOUT)
    //
    CPUTimer_setPreScaler(TASKC_CPUTIMER_BASE, 0);

    //
    // Make sure timer is stopped
    //
    CPUTimer_stopTimer(TASKA_CPUTIMER_BASE);
    CPUTimer_stopTimer(TASKB_CPUTIMER_BASE);
    CPUTimer_stopTimer(TASKC_CPUTIMER_BASE);
    CPUTimer_setEmulationMode(TASKA_CPUTIMER_BASE,
                              CPUTIMER_EMULATIONMODE_STOPAFTERNEXTDECREMENT);
    CPUTimer_setEmulationMode(TASKB_CPUTIMER_BASE,
                              CPUTIMER_EMULATIONMODE_STOPAFTERNEXTDECREMENT);
    CPUTimer_setEmulationMode(TASKC_CPUTIMER_BASE,
                              CPUTIMER_EMULATIONMODE_STOPAFTERNEXTDECREMENT);

    //
    // Reload and start all counter register with period value
    //
    CPUTimer_startTimer(TASKA_CPUTIMER_BASE);
    CPUTimer_startTimer(TASKB_CPUTIMER_BASE);
    CPUTimer_startTimer(TASKC_CPUTIMER_BASE);
}



void BTS_HAL_setupExAdc_ch1_4(void)
{
    /* (OPTIONAL) Provide additional delay time for power supply settling */
    delay_ms_2(50);

    /* (REQUIRED) Set nRESET pin high for ADC operation */

    GPIO_writePin(BTS_SPI_RESET_GPIO_ADC1, 1);
    delay_ms_2(1);

    /* (OPTIONAL) Toggle nRESET pin to ensure default register settings. */
    /* NOTE: This also ensures that the device registers are unlocked.   */
    GPIO_writePin(BTS_SPI_RESET_GPIO_ADC1, 0);
    delay_ms_2(1);
    GPIO_writePin(BTS_SPI_RESET_GPIO_ADC1, 1);
    delay_ms_2(1);

    /* (REQUIRED) Initialize internal 'registerMap' array with device default settings */
//        restoreRegisterDefaults();

    /* (OPTIONAL) Validate first response word when beginning SPI communication: (0xFF20 | CHANCNT) */
//        uint16_t response = sendCommand(OPCODE_NULL);

    /* (OPTIONAL) Define your initial register settings here */
//        writeSingleRegister(CLOCK_ADDRESS, (CLOCK_DEFAULT & ~CLOCK_OSR_MASK) | CLOCK_OSR_256);

    /* (REQUIRED) Configure MODE register settings
     * NOTE: This function call is required here for this particular code implementation to work.
     * This function will enforce the MODE register settings as selected in the 'ads131m0x.h' header file.
     */
//        writeSingleRegister(MODE_ADDRESS, MODE_DEFAULT);

    //while(!GPIO_readPin(BTS_SPI_DRDY_GPIO_ADC1));

    //adc 1 mode set
    //adc register 0x02
    // cs1 bar low

    //default 24 bit mode 0x0510/////////////////////////
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 0);
    //wreg add
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x6100); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //reg data
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0005); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);

    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0100); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //no crc
//        SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0000); // adc address 0x02
//        SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //cs bar high
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 1);

    SysCtl_delay(10000);

// desired 16 bit mode/////////////////////////////////
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 0);
    //wreg add
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x6100); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //reg data
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0000); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);

    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0100); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //no crc
//        SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0000); // adc address 0x02
//        SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //cs bar high
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 1);

    SysCtl_delay(100000);
#if 0
    // desired 16 bit mode/////////////////////////////////
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 0);
    //wreg add
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x6100); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //reg data
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0400); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);

    //SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0000); // adc address 0x02
    //SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //no crc
//        SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0000); // adc address 0x02
//        SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //cs bar high
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 1);
#endif
    SysCtl_delay(100000);

    //adc register 0x03. mode register, 0xFF47, external reference ENABLED, OSR 128 16k SAMPLE RATE
    // cs1 bar low
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 0);
    //wreg add
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x6180); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //reg data
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0xFF43); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //crc
    //SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0000); // adc address 0x02
    //SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //cs bar high
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 1);

    SysCtl_delay(10000);

    /* (OPTIONAL) Read back all registers */

}

void BTS_HAL_setupExAdc_ch5_8(void)
{
    /* (OPTIONAL) Provide additional delay time for power supply settling */
    delay_ms_2(50);

    /* (REQUIRED) Set nRESET pin high for ADC operation */

    GPIO_writePin(BTS_SPI_RESET_GPIO_ADC2, 1);
    delay_ms_2(1);

    /* (OPTIONAL) Toggle nRESET pin to ensure default register settings. */
    /* NOTE: This also ensures that the device registers are unlocked.   */
    GPIO_writePin(BTS_SPI_RESET_GPIO_ADC2, 0);
    delay_ms_2(1);
    GPIO_writePin(BTS_SPI_RESET_GPIO_ADC2, 1);
    delay_ms_2(1);

    /* (REQUIRED) Initialize internal 'registerMap' array with device default settings */
//        restoreRegisterDefaults();

    /* (OPTIONAL) Validate first response word when beginning SPI communication: (0xFF20 | CHANCNT) */
//        uint16_t response = sendCommand(OPCODE_NULL);

    /* (OPTIONAL) Define your initial register settings here */
//        writeSingleRegister(CLOCK_ADDRESS, (CLOCK_DEFAULT & ~CLOCK_OSR_MASK) | CLOCK_OSR_256);

    /* (REQUIRED) Configure MODE register settings
     * NOTE: This function call is required here for this particular code implementation to work.
     * This function will enforce the MODE register settings as selected in the 'ads131m0x.h' header file.
     */
//        writeSingleRegister(MODE_ADDRESS, MODE_DEFAULT);

    //while(!GPIO_readPin(BTS_SPI_DRDY_GPIO_ADC2));

    //adc 1 mode set
    //adc register 0x02
    // cs1 bar low

    //default 24 bit mode 0x0510/////////////////////////
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC2, 0);
    //wreg add
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x6100); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);
    //reg data
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x0005); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);

    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x0100); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);
    //no crc
//        SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x0000); // adc address 0x02
//        SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);
    //cs bar high
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC2, 1);

    SysCtl_delay(10000);

// desired 16 bit mode/////////////////////////////////
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC2, 0);
    //wreg add
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x6100); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);
    //reg data
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x0000); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);

    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x0100); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);
    //no crc
//        SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x0000); // adc address 0x02
//        SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);
    //cs bar high
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC2, 1);

    SysCtl_delay(100000);


    //adc register 0x03. mode register, 0xFF47, external reference ENABLED, OSR 256 13.95k SAMPLE RATE ( 0xFF47)
    //adc register 0x03. mode register, 0xFF4B, external reference ENABLED, OSR 512 13.95k SAMPLE RATE ( 0xFF47)
    // cs1 bar low
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC2, 0);
    //wreg add
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x6180); // adc address 0x03
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);
    //reg data
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0xFF43); // adc address 0x03 // 0xFF47
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);
    //crc
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x0000); // adc address 0x03
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);
    //cs bar high
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC2, 1);

    SysCtl_delay(10000);

    /* (OPTIONAL) Read back all registers */

}


void delay_ms_2(const uint32_t delay_time_ms)
{
    /* --- INSERT YOUR CODE HERE --- */
   const uint32_t cycles_per_loop = 3;
   SysCtl_delay(delay_time_ms * SysCtl_getClock(100000000U) / (cycles_per_loop * 1000u));
   //MAP_SysCtlDelay( delay_time_ms * getSysClockHz() / (cycles_per_loop * 1000u) );
}



void BTS_HAL_setupExAdcGpio_Adc1(void)
{
    // configure xint GPIO for ADC ///////////////////////////////////
    GPIO_setPinConfig(BTS_SPI_DRDY_PIN_CONFIG_ADC1);
    GPIO_setDirectionMode(BTS_SPI_DRDY_GPIO_ADC1, GPIO_DIR_MODE_IN);
    GPIO_setQualificationMode(BTS_SPI_DRDY_GPIO_ADC1, GPIO_QUAL_SYNC);
    //
    // Select GPIO40 as XINT1
    //
    GPIO_setInterruptPin(BTS_SPI_DRDY_GPIO_ADC1, BTS_PSI_DRDY_XINT_GPIO1);

    //
    // Configure XINT1 to be a triggered by a falling edge and XINT2 to be
    // triggered by a rising edge.
    //
    GPIO_setInterruptType(BTS_PSI_DRDY_XINT_GPIO1, GPIO_INT_TYPE_FALLING_EDGE);

    //
    // Enable XINT1
    //
    GPIO_enableInterrupt(BTS_PSI_DRDY_XINT_GPIO1);


    GPIO_setAnalogMode(BTS_SPI_RESET_GPIO_ADC1, GPIO_ANALOG_DISABLED);    //pin 24 digital mode
    // configure reset pin
    GPIO_setPadConfig(BTS_SPI_RESET_GPIO_ADC1, GPIO_PIN_TYPE_PULLUP);     // Enable pullup on GPIO24
    GPIO_writePin(BTS_SPI_RESET_GPIO_ADC1, 1);                            // Load output latch
    GPIO_setPinConfig(BTS_SPI_RESET_PIN_CONFIG_ADC1);                     // GPIO24 = GPIO24
    GPIO_setDirectionMode(BTS_SPI_RESET_GPIO_ADC1, GPIO_DIR_MODE_OUT);
}

void BTS_HAL_setupExAdcGpio_Adc2(void)
{
    // configure xint GPIO for ADC ///////////////////////////////////
    GPIO_setPinConfig(BTS_SPI_DRDY_PIN_CONFIG_ADC2);
    GPIO_setDirectionMode(BTS_SPI_DRDY_GPIO_ADC2, GPIO_DIR_MODE_IN);
    GPIO_setQualificationMode(BTS_SPI_DRDY_GPIO_ADC2, GPIO_QUAL_SYNC);
    //
    // Select GPIO49 as XINT2
    //
    GPIO_setInterruptPin(BTS_SPI_DRDY_GPIO_ADC2, BTS_PSI_DRDY_XINT_GPIO2);

    //
    // Configure XINT2 to be a triggered by a falling edge and XINT2 to be
    // triggered by a rising edge.
    //
    GPIO_setInterruptType(BTS_PSI_DRDY_XINT_GPIO2, GPIO_INT_TYPE_FALLING_EDGE);

    //
    // Enable XINT2
    //
    GPIO_enableInterrupt(BTS_PSI_DRDY_XINT_GPIO2);


    GPIO_setAnalogMode(BTS_SPI_RESET_GPIO_ADC2, GPIO_ANALOG_DISABLED);    //pin 24 digital mode
    // configure reset pin
    GPIO_setPadConfig(BTS_SPI_RESET_GPIO_ADC2, GPIO_PIN_TYPE_PULLUP);     // Enable pullup on GPIO24
    GPIO_writePin(BTS_SPI_RESET_GPIO_ADC2, 1);                            // Load output latch
    GPIO_setPinConfig(BTS_SPI_RESET_PIN_CONFIG_ADC2);                     // GPIO24 = GPIO24
    GPIO_setDirectionMode(BTS_SPI_RESET_GPIO_ADC2, GPIO_DIR_MODE_OUT);
}


/* ArakniD: DONE */
void BTS_HAL_setupSyncBuckPinsGpio(void)
{
    GPIO_writePin(BTS_EPWM_H_GPIO_CH1, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_CH1, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_CH1);

    GPIO_writePin(BTS_EPWM_L_GPIO_CH1, 0);
    GPIO_setDirectionMode(BTS_EPWM_L_GPIO_CH1, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_GPIO_CH1);

    GPIO_writePin(BTS_EPWM_H_GPIO_CH2, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_CH2, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_CH2);

    GPIO_writePin(BTS_EPWM_L_GPIO_CH2, 0);
    GPIO_setDirectionMode(BTS_EPWM_L_GPIO_CH2, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_GPIO_CH2);

    GPIO_writePin(BTS_EPWM_H_GPIO_CH3, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_CH3, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_CH3);

    GPIO_writePin(BTS_EPWM_L_GPIO_CH3, 0);
    GPIO_setDirectionMode(BTS_EPWM_L_GPIO_CH3, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_GPIO_CH3);

    GPIO_writePin(BTS_EPWM_H_GPIO_CH4, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_CH4, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_CH4);

    GPIO_writePin(BTS_EPWM_L_GPIO_CH4, 0);
    GPIO_setDirectionMode(BTS_EPWM_L_GPIO_CH4, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_GPIO_CH4);

    GPIO_writePin(BTS_EPWM_H_GPIO_CH5, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_CH5, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_CH5);

    GPIO_writePin(BTS_EPWM_L_GPIO_CH5, 0);
    GPIO_setDirectionMode(BTS_EPWM_L_GPIO_CH5, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_GPIO_CH5);

    GPIO_writePin(BTS_EPWM_H_GPIO_CH6, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_CH6, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_CH6);

    GPIO_writePin(BTS_EPWM_L_GPIO_CH6, 0);
    GPIO_setDirectionMode(BTS_EPWM_L_GPIO_CH6, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_GPIO_CH6);

    GPIO_writePin(BTS_EPWM_H_GPIO_CH7, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_CH7, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_CH7);

    GPIO_writePin(BTS_EPWM_L_GPIO_CH7, 0);
    GPIO_setDirectionMode(BTS_EPWM_L_GPIO_CH7, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_GPIO_CH7);

    GPIO_writePin(BTS_EPWM_H_GPIO_CH8, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_CH8, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_CH8);

    GPIO_writePin(BTS_EPWM_L_GPIO_CH8, 0);
    GPIO_setDirectionMode(BTS_EPWM_L_GPIO_CH8, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_GPIO_CH8);

    // Setup ADC1 external clock
    GPIO_writePin(BTS_EPWM_H_GPIO_ADC1, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_ADC1, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_ADC1);

    // Setup ADC2 external clock
    GPIO_writePin(BTS_EPWM_H_GPIO_ADC2, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_ADC2, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_ADC2);
}


//
// BUCK_HAL_setupSyncBuckPinsEpwm - Configure synchronous buck pins
// to be controlled by ePWM module
//

/* ArakniD: DONE */
void BTS_HAL_setupSyncBuckPinsEpwm(void)
{
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_CH1);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_EPWM_CH1);

    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_CH2);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_EPWM_CH2);

    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_CH3);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_EPWM_CH3);

    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_CH4);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_EPWM_CH4);

    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_CH5);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_EPWM_CH5);

    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_CH6);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_EPWM_CH6);

    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_CH7);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_EPWM_CH7);

    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_CH8);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_EPWM_CH8);

    // Setup ADC1 external clock
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_ADC1);

    // Setup ADC2 external clock
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_ADC2);
}


//
// BUCK_HAL_setupSyncBuckPwm - Configure ePWM to actuate complementary
// Buck switches with variable duty-cycle control and deadband
//
void BTS_HAL_setupSyncBuckPwm(uint32_t EPWM_BASE)
{
    //
    // Maximum supported ePWM clock speed is specified in the datasheet
    //
    EPWM_setClockPrescaler(EPWM_BASE,
                           BTS_DRV_EPWM_EPWMCLK_DIV,
                           BTS_DRV_EPWM_HSCLK_DIV);

    EPWM_setEmulationMode(EPWM_BASE, EPWM_EMULATION_FREE_RUN);

    //
    // Configure ePWM for count-up operation
    //
    EPWM_setTimeBaseCounter(EPWM_BASE, 0);
    EPWM_setTimeBasePeriod(EPWM_BASE, BTS_DRV_EPWM_TBPRD);
    EPWM_setPeriodLoadMode(EPWM_BASE, EPWM_PERIOD_SHADOW_LOAD);
    EPWM_setTimeBaseCounterMode(EPWM_BASE, EPWM_COUNTER_MODE_UP);
    EPWM_disablePhaseShiftLoad(EPWM_BASE);

    //
    // Set Compare values
    //
    EPWM_setCounterCompareValue(EPWM_BASE,
                                EPWM_COUNTER_COMPARE_A,
                                0U);
    EPWM_setCounterCompareValue(EPWM_BASE,
                                EPWM_COUNTER_COMPARE_B,
                                BTS_DRV_EPWM_TBPRD);

    HRPWM_setCounterCompareValue(EPWM_BASE,
                                     HRPWM_COUNTER_COMPARE_A,
                                     0);
    HRPWM_setCounterCompareValue(EPWM_BASE,
                                     HRPWM_COUNTER_COMPARE_B,
                                     1000U);


    //
    // Set up counter mode
    //
    EPWM_setTimeBaseCounterMode(EPWM_BASE, EPWM_COUNTER_MODE_UP);
    EPWM_disablePhaseShiftLoad(EPWM_BASE);
    EPWM_setClockPrescaler(EPWM_BASE,
                           EPWM_CLOCK_DIVIDER_1,
                           EPWM_HSCLOCK_DIVIDER_1);


    //
    // Use shadow mode to update CMPA on TBPRD
    //
    EPWM_setCounterCompareShadowLoadMode(EPWM_BASE,
                                         EPWM_COUNTER_COMPARE_A,
                                         EPWM_COMP_LOAD_ON_CNTR_PERIOD);

    HRPWM_setCounterCompareShadowLoadEvent(EPWM_BASE,
                                               HRPWM_CHANNEL_A,
                                               HRPWM_LOAD_ON_CNTR_PERIOD);

    EPWM_setCounterCompareShadowLoadMode(EPWM_BASE,
                                         EPWM_COUNTER_COMPARE_B,
                                         EPWM_COMP_LOAD_ON_CNTR_PERIOD);

    HRPWM_setCounterCompareShadowLoadEvent(EPWM_BASE,
                                               HRPWM_CHANNEL_B,
                                               HRPWM_LOAD_ON_CNTR_PERIOD);


    //
    // Configure Action Qualifier SubModule to:
    //     Output High when TBCTR=0
    //     Output  Low when TBCTR=CMPA (for VMC only)
    //
    // Use shadow mode to update AQCTL
    //
    EPWM_setActionQualifierShadowLoadMode(EPWM_BASE,
                                          EPWM_ACTION_QUALIFIER_A,
                                          EPWM_AQ_LOAD_ON_CNTR_PERIOD);
    EPWM_setActionQualifierAction(EPWM_BASE,
                                  EPWM_AQ_OUTPUT_A,
                                  EPWM_AQ_OUTPUT_HIGH,
                                  EPWM_AQ_OUTPUT_ON_TIMEBASE_ZERO);

    EPWM_setActionQualifierAction(EPWM_BASE,
                                      EPWM_AQ_OUTPUT_A,
                                      EPWM_AQ_OUTPUT_LOW,
                                      EPWM_AQ_OUTPUT_ON_TIMEBASE_UP_CMPA);
    // CONFIGURE COMPB
    EPWM_setActionQualifierShadowLoadMode(EPWM_BASE,
                                          EPWM_ACTION_QUALIFIER_B,
                                          EPWM_AQ_LOAD_ON_CNTR_PERIOD);
    EPWM_setActionQualifierAction(EPWM_BASE,
                                  EPWM_AQ_OUTPUT_B,
                                  EPWM_AQ_OUTPUT_HIGH,
                                  EPWM_AQ_OUTPUT_ON_TIMEBASE_ZERO);


    EPWM_setActionQualifierAction(EPWM_BASE,
                                      EPWM_AQ_OUTPUT_B,
                                      EPWM_AQ_OUTPUT_LOW,
                                      EPWM_AQ_OUTPUT_ON_TIMEBASE_UP_CMPB);

    //
    // Align the HRPWM CMPA behavior with EPWM
    //
    HRPWM_setMEPEdgeSelect(EPWM_BASE,
                           HRPWM_CHANNEL_A,
                           HRPWM_MEP_CTRL_FALLING_EDGE);

    HRPWM_setMEPControlMode(EPWM_BASE,
                            HRPWM_CHANNEL_A,
                            HRPWM_MEP_DUTY_PERIOD_CTRL);

    HRPWM_setMEPEdgeSelect(EPWM_BASE,
                           HRPWM_CHANNEL_B,
                           HRPWM_MEP_CTRL_RISING_EDGE);

    HRPWM_setMEPControlMode(EPWM_BASE,
                            HRPWM_CHANNEL_B,
                            HRPWM_MEP_DUTY_PERIOD_CTRL);

    //
    // Configure Dead Band Generator for active high complementary PWMs
    //
    EPWM_setDeadBandDelayMode(EPWM_BASE, EPWM_DB_RED, true);
    EPWM_setDeadBandDelayMode(EPWM_BASE, EPWM_DB_FED, true);

    EPWM_setRisingEdgeDeadBandDelayInput(EPWM_BASE,
                                         EPWM_DB_INPUT_EPWMA);
    EPWM_setFallingEdgeDeadBandDelayInput(EPWM_BASE,
                                          EPWM_DB_INPUT_EPWMB);// old value EPWMA

    EPWM_setDeadBandDelayPolarity(EPWM_BASE,
                                  EPWM_DB_FED,
                                  EPWM_DB_POLARITY_ACTIVE_LOW);
    EPWM_setDeadBandDelayPolarity(EPWM_BASE,
                                  EPWM_DB_RED,
                                  EPWM_DB_POLARITY_ACTIVE_HIGH);

    EPWM_setFallingEdgeDelayCount(EPWM_BASE,
                                  BTS_DRV_EPWM_DEADBAND_FED);
    EPWM_setRisingEdgeDelayCount(EPWM_BASE,
                                 BTS_DRV_EPWM_DEADBAND_RED);

    EPWM_setFallingEdgeDelayCount(EPWM_BASE,
                                  BTS_DRV_EPWM_DEADBAND_FED);
    EPWM_setRisingEdgeDelayCount(EPWM_BASE,
                                 BTS_DRV_EPWM_DEADBAND_RED);


    #if(BTS_DRV_EPWM_HR_ENABLED == true)
        //
        // HRCAL uses the EPWM1 clock
        //
        // SysCtl_enablePeripheral(SYSCTL_PERIPH_CLK_EPWM2);

//        HRPWM_enableAutoConversion(EPWM_BASE);
    #endif
}

//
// BUCK_HAL_setupSyncBuckPwm - Configure ePWM to actuate complementary
// Buck switches with variable duty-cycle control and deadband
//
void BTS_HAL_setupAdcClock(uint32_t EPWM_BASE)
{
    //
    // Maximum supported ePWM clock speed is specified in the datasheet
    //
    EPWM_setClockPrescaler(EPWM_BASE,
                           BTS_DRV_ADC_EPWMCLK_DIV,
                           BTS_DRV_ADC_HSCLK_DIV);

    EPWM_setEmulationMode(EPWM_BASE, EPWM_EMULATION_FREE_RUN);

    //
    // Configure ePWM for count-up operation
    //
    EPWM_setTimeBaseCounter(EPWM_BASE, 0);
    EPWM_setTimeBasePeriod(EPWM_BASE, BTS_DRV_ADC_TBPRD);
    EPWM_setPeriodLoadMode(EPWM_BASE, EPWM_PERIOD_SHADOW_LOAD);
    EPWM_setTimeBaseCounterMode(EPWM_BASE, EPWM_COUNTER_MODE_UP);
    EPWM_disablePhaseShiftLoad(EPWM_BASE);

    //
    // Set Compare values
    //
    EPWM_setCounterCompareValue(EPWM_BASE,
                                EPWM_COUNTER_COMPARE_A,
                                (BTS_DRV_ADC_TBPRD / 2));
    EPWM_setCounterCompareValue(EPWM_BASE,
                                EPWM_COUNTER_COMPARE_B,
                                (BTS_DRV_ADC_TBPRD + 1) / 2);


    //
    // Set up counter mode
    //
    EPWM_setTimeBaseCounterMode(EPWM_BASE, EPWM_COUNTER_MODE_UP);
    EPWM_disablePhaseShiftLoad(EPWM_BASE);
    EPWM_setClockPrescaler(EPWM_BASE,
                           EPWM_CLOCK_DIVIDER_1,
                           EPWM_HSCLOCK_DIVIDER_1);


    //
    // Use shadow mode to update CMPA on TBPRD
    //
    EPWM_setCounterCompareShadowLoadMode(EPWM_BASE,
                                         EPWM_COUNTER_COMPARE_A,
                                         EPWM_COMP_LOAD_ON_CNTR_PERIOD);

    EPWM_setCounterCompareShadowLoadMode(EPWM_BASE,
                                         EPWM_COUNTER_COMPARE_B,
                                         EPWM_COMP_LOAD_ON_CNTR_PERIOD);

    //
    // Configure Action Qualifier SubModule to:
    //     Output High when TBCTR=0
    //     Output  Low when TBCTR=CMPA (for VMC only)
    //
    // Use shadow mode to update AQCTL
    //
    EPWM_setActionQualifierShadowLoadMode(EPWM_BASE,
                                          EPWM_ACTION_QUALIFIER_A,
                                          EPWM_AQ_LOAD_ON_CNTR_PERIOD);

    EPWM_setActionQualifierAction(EPWM_BASE,
                                  EPWM_AQ_OUTPUT_A,
                                  EPWM_AQ_OUTPUT_TOGGLE,
                                  EPWM_AQ_OUTPUT_ON_TIMEBASE_ZERO);

    EPWM_setActionQualifierAction(EPWM_BASE,
                                  EPWM_AQ_OUTPUT_A,
                                  EPWM_AQ_OUTPUT_TOGGLE,
                                  EPWM_AQ_OUTPUT_ON_TIMEBASE_UP_CMPA);

    /*EPWM_setActionQualifierAction(EPWM_BASE,
                                  EPWM_AQ_OUTPUT_A,
                                  EPWM_AQ_OUTPUT_TOGGLE,
                                  EPWM_AQ_OUTPUT_ON_TIMEBASE_UP_CMPB);

    EPWM_setActionQualifierAction(EPWM_BASE,
                                  EPWM_AQ_OUTPUT_A,
                                  EPWM_AQ_OUTPUT_TOGGLE,
                                  EPWM_AQ_OUTPUT_ON_TIMEBASE_PERIOD);

    EPWM_setActionQualifierAction(EPWM_BASE,
                                  EPWM_AQ_OUTPUT_A,
                                  EPWM_AQ_OUTPUT_TOGGLE,
                                  EPWM_AQ_OUTPUT_ON_TIMEBASE_DOWN_CMPB);

    EPWM_setActionQualifierAction(EPWM_BASE,
                                  EPWM_AQ_OUTPUT_A,
                                  EPWM_AQ_OUTPUT_TOGGLE,
                                  EPWM_AQ_OUTPUT_ON_TIMEBASE_DOWN_CMPA);
*/

}

void BTS_HAL_SetupI2C_GPIO(void)
{
    // I2CA pins (SDA / SCL) - External
    GPIO_setDirectionMode(BTS_I2C_EXT_PIN_SDA, GPIO_DIR_MODE_IN);
    GPIO_setPadConfig(BTS_I2C_EXT_PIN_SDA, GPIO_PIN_TYPE_PULLUP);
    GPIO_setMasterCore(BTS_I2C_EXT_PIN_SDA, GPIO_CORE_CPU1);
    GPIO_setQualificationMode(BTS_I2C_EXT_PIN_SDA, GPIO_QUAL_ASYNC);

    GPIO_setDirectionMode(BTS_I2C_EXT_PIN_SCL, GPIO_DIR_MODE_IN);
    GPIO_setPadConfig(BTS_I2C_EXT_PIN_SCL, GPIO_PIN_TYPE_PULLUP);
    GPIO_setMasterCore(BTS_I2C_EXT_PIN_SCL, GPIO_CORE_CPU1);
    GPIO_setQualificationMode(BTS_I2C_EXT_PIN_SCL, GPIO_QUAL_ASYNC);

    GPIO_setPinConfig(BTS_I2C_EXT_CFG_SDA);
    GPIO_setPinConfig(BTS_I2C_EXT_CFG_SCL);

    // I2CB pins (SDAA / SCLA) - Internal
    GPIO_setDirectionMode(BTS_I2C_INT_PIN_SDA, GPIO_DIR_MODE_IN);
    GPIO_setPadConfig(BTS_I2C_INT_PIN_SDA, GPIO_PIN_TYPE_PULLUP);
    GPIO_setMasterCore(BTS_I2C_INT_PIN_SDA, GPIO_CORE_CPU1);
    GPIO_setQualificationMode(BTS_I2C_INT_PIN_SDA, GPIO_QUAL_ASYNC);

    GPIO_setDirectionMode(BTS_I2C_INT_PIN_SCL, GPIO_DIR_MODE_IN);
    GPIO_setPadConfig(BTS_I2C_INT_PIN_SCL, GPIO_PIN_TYPE_PULLUP);
    GPIO_setMasterCore(BTS_I2C_INT_PIN_SCL, GPIO_CORE_CPU1);
    GPIO_setQualificationMode(BTS_I2C_INT_PIN_SCL, GPIO_QUAL_ASYNC);

    GPIO_setPinConfig(BTS_I2C_INT_CFG_SDA);
    GPIO_setPinConfig(BTS_I2C_INT_CFG_SCL);
}

void BTS_HAL_SetupI2C_Init()
{
    // External I2CA Base
    I2C_disableModule(BTS_I2C_EXT_BASE);
    I2C_initMaster(BTS_I2C_EXT_BASE, DEVICE_SYSCLK_FREQ, 100000, I2C_DUTYCYCLE_50);
    I2C_setConfig(BTS_I2C_EXT_BASE, I2C_MASTER_SEND_MODE);
    I2C_setSlaveAddress(BTS_I2C_EXT_BASE, 80);
    I2C_setOwnSlaveAddress(BTS_I2C_EXT_BASE, 96); //I2CA address
    I2C_disableLoopback(BTS_I2C_EXT_BASE);
    I2C_setBitCount(BTS_I2C_EXT_BASE, I2C_BITCOUNT_8);
    I2C_setDataCount(BTS_I2C_EXT_BASE, 2);
    I2C_setAddressMode(BTS_I2C_EXT_BASE, I2C_ADDR_MODE_7BITS);
    I2C_enableFIFO(BTS_I2C_EXT_BASE);
    I2C_clearInterruptStatus(BTS_I2C_EXT_BASE, I2C_INT_ARB_LOST | I2C_INT_NO_ACK);
    I2C_setFIFOInterruptLevel(BTS_I2C_EXT_BASE, I2C_FIFO_TXEMPTY, I2C_FIFO_RX2);
    I2C_enableInterrupt(BTS_I2C_EXT_BASE, I2C_INT_ADDR_SLAVE | I2C_INT_ARB_LOST | I2C_INT_NO_ACK | I2C_INT_STOP_CONDITION);
    I2C_setEmulationMode(BTS_I2C_EXT_BASE, I2C_EMULATION_FREE_RUN);
    I2C_enableModule(BTS_I2C_EXT_BASE);

    // Internal I2CB - Internal
    I2C_disableModule(BTS_I2C_INT_BASE);
    I2C_initMaster(BTS_I2C_INT_BASE, DEVICE_SYSCLK_FREQ, 400000, I2C_DUTYCYCLE_50);
    I2C_setConfig(BTS_I2C_INT_BASE, I2C_MASTER_SEND_MODE);
    I2C_setSlaveAddress(BTS_I2C_INT_BASE, 80);
    I2C_setOwnSlaveAddress(BTS_I2C_INT_BASE, 96); //I2CA address
    I2C_disableLoopback(BTS_I2C_INT_BASE);
    I2C_setBitCount(BTS_I2C_INT_BASE, I2C_BITCOUNT_8);
    I2C_setDataCount(BTS_I2C_INT_BASE, 2);
    I2C_setAddressMode(BTS_I2C_INT_BASE, I2C_ADDR_MODE_7BITS);
    I2C_enableFIFO(BTS_I2C_INT_BASE);
    I2C_clearInterruptStatus(BTS_I2C_INT_BASE, I2C_INT_ARB_LOST | I2C_INT_NO_ACK);
    I2C_setFIFOInterruptLevel(BTS_I2C_INT_BASE, I2C_FIFO_TXEMPTY, I2C_FIFO_RX2);
    I2C_enableInterrupt(BTS_I2C_INT_BASE, I2C_INT_ARB_LOST | I2C_INT_NO_ACK | I2C_INT_STOP_CONDITION);
    I2C_setEmulationMode(BTS_I2C_INT_BASE, I2C_EMULATION_FREE_RUN);
    I2C_enableModule(BTS_I2C_INT_BASE);
}


void BTS_HAL_setupCanBus()
{
        GPIO_setPinConfig(BTS_CAN_PIN_CANRX);
        GPIO_setPinConfig(BTS_CAN_PIN_CANTX);

        //
        // Initialize the CAN controllers
        //
        CAN_initModule(BTS_CAN_BASE);

        //
        // Set up the CAN bus bit rate to 500kHz for each module
        // Refer to the Driver Library User Guide for information on how to set
        // tighter timing control. Additionally, consult the device data sheet
        // for more information about the CAN module clocking.
        //
        CAN_setBitRate(BTS_CAN_BASE, DEVICE_SYSCLK_FREQ, 500000, 16);
}

void BTS_HAL_setupSfraClock(uint32_t EPWM_BASE)
{
    EPWM_setInterruptSource(EPWM_BASE, EPWM_INT_TBCTR_ZERO);

    EPWM_enableInterrupt(EPWM_BASE);
    EPWM_setInterruptEventCount(EPWM_BASE, 1U);
}

void BTS_HAL_enableEpwmCounting(void)
{
    SysCtl_enablePeripheral(SYSCTL_PERIPH_CLK_TBCLKSYNC);
}

void BTS_HAL_disableEpwmCounting(void){

    SysCtl_disablePeripheral(SYSCTL_PERIPH_CLK_TBCLKSYNC);
}

void BTS_HAL_setupInterruptTrigger_Adc1(void)
{
    Interrupt_enable(BTS_SPI_DRDY_XINT_ADC1);
    SPI_clearInterruptStatus(BTS_SPI_BASE_ADC1, SPI_INT_RXFF );
    SPI_resetRxFIFO(BTS_SPI_BASE_ADC1);
    SPI_resetTxFIFO(BTS_SPI_BASE_ADC1);
    Interrupt_enable(BTS_SPI_DRDY_CINT_ADC1);

}

void BTS_HAL_setupInterruptTrigger_Adc2(void)
{
    Interrupt_enable(BTS_SPI_DRDY_XINT_ADC2);
    SPI_clearInterruptStatus(BTS_SPI_BASE_ADC2, SPI_INT_RXFF );
    SPI_resetRxFIFO(BTS_SPI_BASE_ADC2);
    SPI_resetTxFIFO(BTS_SPI_BASE_ADC2);
    Interrupt_enable(BTS_SPI_DRDY_CINT_ADC2);

}

void BTS_HAL_setupInterrupt_Adc1(void)
{
    SPI_clearInterruptStatus(BTS_SPI_BASE_ADC1, SPI_INT_RXFF );
    Interrupt_register(BTS_SPI_DRDY_XINT_ADC1, &BTS_DRDY_ADC1);
    Interrupt_register(BTS_SPI_DRDY_CINT_ADC1, &BTS_RXFIFO_SPI1);
}

void BTS_HAL_setupInterrupt_Adc2(void)
{
    SPI_clearInterruptStatus(BTS_SPI_BASE_ADC2, SPI_INT_RXFF );
    Interrupt_register(BTS_SPI_DRDY_XINT_ADC2, &BTS_DRDY_ADC2);
    Interrupt_register(BTS_SPI_DRDY_CINT_ADC2, &BTS_RXFIFO_SPI2);
}

void BTS_HAL_setupInterrupt(void)
{
#if(BTS_SFRA_ENABLED == true) && (BTS_SFRA_ISR_SRC == BTS_SFRA_ISR_SRC_PWM)
    Interrupt_register(INT_EPWM1, &epwm1ISR);
    Interrupt_enable(INT_EPWM1);
#endif
    EALLOW;
    EINT;  // Enable Global interrupt INTM
    ERTM;  // Enable Global real-time interrupt DBGM
    EDIS;
}

void BTS_HAL_setupInterrupt_I2c(void)
{
    //
    // Set I2C use, initializing it for FIFO mode
    //

    Interrupt_register(INT_I2CA, &i2cAISR);
    Interrupt_enable(INT_I2CA);

    Interrupt_register(INT_I2CB, &i2cBISR);
    Interrupt_enable(INT_I2CB);

    Interrupt_register(INT_I2CA_FIFO, &i2cAFIFOISR);
    Interrupt_enable(INT_I2CA_FIFO);

    Interrupt_register(INT_I2CB_FIFO, &i2cBFIFOISR);
    Interrupt_enable(INT_I2CB_FIFO);
}

void BTS_HAL_SetupSpi(uint32_t spiBase)
{
    //
    // Must put SPI into reset before configuring it
    //
    SPI_disableModule(spiBase);
    //
    // SPI configuration. Use a 1MHz SPICLK and 16-bit word size.
    //
    SPI_enableHighSpeedMode(spiBase);
    SPI_setConfig(spiBase, DEVICE_LSPCLK_FREQ, SPI_PROT_POL0PHA0,
                  SPI_MODE_MASTER, DEVICE_LSPCLK_FREQ / 4, 16); // working code uses 16 bit


    //SPI_enableLoopback(SPIA_BASE);
    SPI_setEmulationMode(spiBase, SPI_EMULATION_STOP_MIDWAY);
    SPI_enableFIFO(spiBase);

    SPI_clearInterruptStatus(spiBase, SPI_INT_RX_DATA_TX_EMPTY|SPI_INT_RXFF|SPI_INT_TXFF );

    SPI_setFIFOInterruptLevel(spiBase, SPI_FIFO_TX0, SPI_FIFO_RX10);

    SPI_enableInterrupt(spiBase, SPI_INT_RXFF|SPI_INT_TXFF);


    //
    // Configuration complete. Enable the module.
    //
    SPI_enableModule(spiBase);

   // uint32_t junk;
    //while(junk = SPI_readDataNonBlocking(SPIA_BASE));
}

void BTS_HAL_SetupSpiPinsGpio_Adc1(void){
    // configure SPI GPIO pins for SPIA

    GPIO_setQualificationMode(BTS_SPI_DIN_GPIO_ADC1,   GPIO_QUAL_ASYNC); // asynch input
    GPIO_setQualificationMode(BTS_SPI_DOUT_GPIO_ADC1,  GPIO_QUAL_ASYNC); // asynch input
    GPIO_setQualificationMode(BTS_SPI_RESET_GPIO_ADC1, GPIO_QUAL_ASYNC); // asynch input changed from 9 to 56
    GPIO_setQualificationMode(BTS_SPI_SCLK_GPIO_ADC1,  GPIO_QUAL_ASYNC); // asynch input //not used
    GPIO_setPinConfig(BTS_SPI_DIN_PIN_CONFIG_ADC1);            // GPIO16 = SPISIMOA
    GPIO_setPinConfig(BTS_SPI_DOUT_PIN_CONFIG_ADC1);           // GPIO17 = SPIS0MIA
    GPIO_setPinConfig(BTS_SPI_SCLK_PIN_CONFIG_ADC1);           // GPIO18 = SPICLKA

    // cs bar for SPIA
    GPIO_setPadConfig(BTS_SPI_CS_GPIO_ADC1, GPIO_PIN_TYPE_PULLUP);     // Enable pullup on GPIO6
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 1);                            // Load output latch
    GPIO_setPinConfig(BTS_SPI_CS_PIN_CONFIG_ADC1);                     // GPIO6 = GPIO6
    GPIO_setDirectionMode(BTS_SPI_CS_GPIO_ADC1, GPIO_DIR_MODE_OUT);    // GPIO6 = output
}

void BTS_HAL_SetupSpiPinsGpio_Adc2(void){
    // configure SPI GPIO pins for SPIA

    GPIO_setQualificationMode(BTS_SPI_DIN_GPIO_ADC2,   GPIO_QUAL_ASYNC); // asynch input
    GPIO_setQualificationMode(BTS_SPI_DOUT_GPIO_ADC2,  GPIO_QUAL_ASYNC); // asynch input
    GPIO_setQualificationMode(BTS_SPI_RESET_GPIO_ADC2, GPIO_QUAL_ASYNC); // asynch input changed from 9 to 56
    GPIO_setQualificationMode(BTS_SPI_SCLK_GPIO_ADC2,  GPIO_QUAL_ASYNC); // asynch input //not used
    GPIO_setPinConfig(BTS_SPI_DIN_PIN_CONFIG_ADC2);            // GPIO50 = SPISIMOC
    GPIO_setPinConfig(BTS_SPI_DOUT_PIN_CONFIG_ADC2);           // GPIO51 = SPISOMIC
    GPIO_setPinConfig(BTS_SPI_SCLK_PIN_CONFIG_ADC2);           // GPIO52 = SPICLKC

    // cs bar for SPIA
    GPIO_setPadConfig(BTS_SPI_CS_GPIO_ADC2, GPIO_PIN_TYPE_PULLUP);     // Enable pullup on GPIO6
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC2, 1);                            // Load output latch
    GPIO_setPinConfig(BTS_SPI_CS_PIN_CONFIG_ADC2);                     // GPIO6 = GPIO6
    GPIO_setDirectionMode(BTS_SPI_CS_GPIO_ADC2, GPIO_DIR_MODE_OUT);    // GPIO6 = output
}

//
// End of buck_hal.c
//
