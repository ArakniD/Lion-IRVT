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

    // Setup trip system
    BTS_HAL_setupTripSystem();

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

extern volatile uint32_t startup_mode;
extern volatile uint32_t startup_enable;

/* SN74HC148DR
 * This is attached to the three inputs, so its a single select
 * based on parity really */
uint8_t truth_table[8] = {
  7, // 0 Input 7=L
  6, // 1 Input 6=L
  5, // 2 Input 5=L
  4, // 3 Input 4=L
  3, // 4 Input 3=L
  2, // 5 Input 2=L
  1, // 6 Input 1=L
  0  // 7 Input 0=L or ALL OFF
};


void BTS_HAL_setupGPIO(void)
{
    // Configure GPIOs Mode options
    GPIO_setPinConfig(BTS_MODE_GPIO_CFG_0);
    GPIO_setPinConfig(BTS_MODE_GPIO_CFG_1);
    GPIO_setPinConfig(BTS_MODE_GPIO_CFG_2);
    GPIO_setDirectionMode(BTS_MODE_GPIO_PIN_0, GPIO_DIR_MODE_IN);
    GPIO_setDirectionMode(BTS_MODE_GPIO_PIN_1, GPIO_DIR_MODE_IN);
    GPIO_setDirectionMode(BTS_MODE_GPIO_PIN_2, GPIO_DIR_MODE_IN);
    GPIO_setPadConfig(BTS_MODE_GPIO_PIN_0, GPIO_PIN_TYPE_STD);
    GPIO_setPadConfig(BTS_MODE_GPIO_PIN_1, GPIO_PIN_TYPE_STD);
    GPIO_setPadConfig(BTS_MODE_GPIO_PIN_2, GPIO_PIN_TYPE_STD);

    // Configure GPIOs Enable options
    GPIO_setPinConfig(BTS_EN_GPIO_CFG_0);
    GPIO_setPinConfig(BTS_EN_GPIO_CFG_1);
    GPIO_setPinConfig(BTS_EN_GPIO_CFG_2);
    GPIO_setDirectionMode(BTS_EN_GPIO_PIN_0, GPIO_DIR_MODE_IN);
    GPIO_setDirectionMode(BTS_EN_GPIO_PIN_1, GPIO_DIR_MODE_IN);
    GPIO_setDirectionMode(BTS_EN_GPIO_PIN_2, GPIO_DIR_MODE_IN);
    GPIO_setPadConfig(BTS_EN_GPIO_PIN_0, GPIO_PIN_TYPE_STD);
    GPIO_setPadConfig(BTS_EN_GPIO_PIN_1, GPIO_PIN_TYPE_STD);
    GPIO_setPadConfig(BTS_EN_GPIO_PIN_2, GPIO_PIN_TYPE_STD);

    // startup_enable
    startup_enable  = (GPIO_readPin(BTS_EN_GPIO_PIN_0) ? 1 : 0) << 0;
    startup_enable |= (GPIO_readPin(BTS_EN_GPIO_PIN_1) ? 1 : 0) << 1;
    startup_enable |= (GPIO_readPin(BTS_EN_GPIO_PIN_2) ? 1 : 0) << 2;
    startup_enable = truth_table[startup_enable];

    // startup_mode
    startup_mode  = (GPIO_readPin(BTS_MODE_GPIO_PIN_0) ? 1 : 0) << 0;
    startup_mode |= (GPIO_readPin(BTS_MODE_GPIO_PIN_1) ? 1 : 0) << 1;
    startup_mode |= (GPIO_readPin(BTS_MODE_GPIO_PIN_2) ? 1 : 0) << 2;
    startup_mode = truth_table[startup_mode];
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

// Function to configure CMPSS for current monitoring (COMPH and COMPL combined)
void BTS_HAL_setupCMPSS(uint32_t cmpssBase, uint32_t adcPin) {
    EALLOW;
    // Configure high comparator (COMPH) for +10A
    CMPSS_configHighComparator(cmpssBase, CMPSS_INSRC_PIN | adcPin);
    CMPSS_configOutputsHigh(cmpssBase, CMPSS_TRIP_FILTER | CMPSS_TRIPOUT_LATCH);
    CMPSS_configFilterHigh(cmpssBase, 0, 8, CMPSS_THRESHOLD_HIGH); // Prescale 0, window 8

    // Configure low comparator (COMPL) for -10A
    CMPSS_configLowComparator(cmpssBase, CMPSS_INSRC_PIN | adcPin);
    CMPSS_configOutputsLow(cmpssBase, CMPSS_TRIP_FILTER | CMPSS_TRIPOUT_LATCH);
    CMPSS_configFilterLow(cmpssBase, 0, 8, CMPSS_THRESHOLD_LOW);

    // Enable OR of COMPH and COMPL outputs
    HWREGH(cmpssBase + CMPSS_O_COMPSTS) |= CMPSS_COMPSTS_COMPHLATCH | CMPSS_COMPSTS_COMPLLATCH;

    // Enable CMPSS module
    CMPSS_enableModule(cmpssBase);
    EDIS;
}

// Function to configure Input X-BAR for a given input line
void BTS_HAL_setupInputXBAR(uint32_t inputXbarLine, uint32_t sourceType, uint32_t sourceId) {
    EALLOW;
    // Map sourceType: 0 for GPIO, 1 for CMPSS
    if (sourceType == 0) {
        // GPIO source
        XBAR_setInputPin((XBAR_InputNum)(XBAR_INPUT1 + (inputXbarLine - 1)), sourceId);
    } else {
        // CMPSS source (sourceId is mux value: 0, 2, ..., 14)
        XBAR_setInputPin((XBAR_InputNum)(XBAR_INPUT1 + (inputXbarLine - 1)), sourceId);
    }
    EDIS;
}

// Function to configure GPIO for trip input
void BTS_HAL_setupTripGPIO(uint32_t gpioPin) {
    GPIO_setPinConfig(gpioPin | GPIO_PIN_TYPE_STD);
    GPIO_setDirectionMode(gpioPin, GPIO_DIR_MODE_IN);
    GPIO_setQualificationMode(gpioPin, GPIO_QUAL_SYNC);
}

// Function to configure ePWM Trip Zone
void BTS_HAL_setupEPWMTripZone(uint32_t epwmBase) {
    EALLOW;
    // Enable TZ1 (CMPSS) and TZ2 (GPIO AND group trip)
    EPWM_enableTripZoneSignals(epwmBase, EPWM_TZ_SIGNAL_OSHT1 | EPWM_TZ_SIGNAL_OSHT2);

    // Configure trip actions: force EPWMA and EPWMB low
    EPWM_setTripZoneAction(epwmBase, EPWM_TZ_ACTION_EVENT_TZA, EPWM_TZ_ACTION_LOW);
    EPWM_setTripZoneAction(epwmBase, EPWM_TZ_ACTION_EVENT_TZB, EPWM_TZ_ACTION_LOW);

    // Enable trip zone interrupt
    EPWM_enableTripZoneInterrupt(epwmBase, EPWM_TZ_INTERRUPT_OST);
    EDIS;
}

// Function to configure all trip mechanisms
void BTS_HAL_setupTripSystem(void) {
    // Configure comparators (assuming COMP1-8 map to channels)
    // Map: A2->COMP1A, B2->COMP2B, A4->COMP3A, IN14->COMP4A, D0->COMP5D, C2->COMP6C, D2->COMP7D, C4->COMP8C

    // Configure CMPSS for each channel
    BTS_HAL_setupCMPSS(CMPSS1_BASE, BTS_TRP_PIN_CONFIG_COMP_CH1); // Channel 1, ADCIN0
    BTS_HAL_setupCMPSS(CMPSS2_BASE, BTS_TRP_PIN_CONFIG_COMP_CH2); // Channel 2, ADCIN2
    BTS_HAL_setupCMPSS(CMPSS3_BASE, BTS_TRP_PIN_CONFIG_COMP_CH3); // Channel 3, ADCIN4
    BTS_HAL_setupCMPSS(CMPSS4_BASE, BTS_TRP_PIN_CONFIG_COMP_CH4); // Channel 4, ADCIN6
    BTS_HAL_setupCMPSS(CMPSS5_BASE, BTS_TRP_PIN_CONFIG_COMP_CH5); // Channel 5, ADCIN0 (ADC2)
    BTS_HAL_setupCMPSS(CMPSS6_BASE, BTS_TRP_PIN_CONFIG_COMP_CH6); // Channel 6, ADCIN2 (ADC2)
    BTS_HAL_setupCMPSS(CMPSS7_BASE, BTS_TRP_PIN_CONFIG_COMP_CH7); // Channel 7, ADCIN4 (ADC2)
    BTS_HAL_setupCMPSS(CMPSS8_BASE, BTS_TRP_PIN_CONFIG_COMP_CH8); // Channel 8, ADCIN6 (ADC2)

    // Configure Input X-BAR for CMPSS trips (INPUT1 to INPUT8)
    BTS_HAL_setupInputXBAR(1, 1, XBAR_OUT_MUX00_CMPSS1_CTRIPOUTH_OR_L);  // INPUT1: CMPSS1.COMPH/COMPL
    BTS_HAL_setupInputXBAR(2, 1, XBAR_OUT_MUX02_CMPSS2_CTRIPOUTH_OR_L);  // INPUT2: CMPSS2.COMPH/COMPL
    BTS_HAL_setupInputXBAR(3, 1, XBAR_OUT_MUX04_CMPSS3_CTRIPOUTH_OR_L);  // INPUT3: CMPSS3.COMPH/COMPL
    BTS_HAL_setupInputXBAR(4, 1, XBAR_OUT_MUX06_CMPSS4_CTRIPOUTH_OR_L);  // INPUT4: CMPSS4.COMPH/COMPL
    BTS_HAL_setupInputXBAR(5, 1, XBAR_OUT_MUX08_CMPSS5_CTRIPOUTH_OR_L);  // INPUT5: CMPSS5.COMPH/COMPL
    BTS_HAL_setupInputXBAR(6, 1, XBAR_OUT_MUX10_CMPSS6_CTRIPOUTH_OR_L);  // INPUT6: CMPSS6.COMPH/COMPL
    BTS_HAL_setupInputXBAR(7, 1, XBAR_OUT_MUX12_CMPSS7_CTRIPOUTH_OR_L);  // INPUT7: CMPSS7.COMPH/COMPL
    BTS_HAL_setupInputXBAR(8, 1, XBAR_OUT_MUX14_CMPSS8_CTRIPOUTH_OR_L);  // INPUT8: CMPSS8.COMPH/COMPL

    // Configure GPIOs for individual trips, group trip, and AND gate outputs
    BTS_HAL_setupTripGPIO(BTS_TRP_PIN_CONFIG_GPIO_CH1);
    BTS_HAL_setupTripGPIO(BTS_TRP_PIN_CONFIG_GPIO_CH2);
    BTS_HAL_setupTripGPIO(BTS_TRP_PIN_CONFIG_GPIO_CH3);
    BTS_HAL_setupTripGPIO(BTS_TRP_PIN_CONFIG_GPIO_CH4);
    BTS_HAL_setupTripGPIO(BTS_TRP_PIN_CONFIG_GPIO_CH5);
    BTS_HAL_setupTripGPIO(BTS_TRP_PIN_CONFIG_GPIO_CH6);
    BTS_HAL_setupTripGPIO(BTS_TRP_PIN_CONFIG_GPIO_CH7);
    BTS_HAL_setupTripGPIO(BTS_TRP_PIN_CONFIG_GPIO_CH8);

    // Configure Input X-BAR for GPIO AND group trips (INPUT9 to INPUT16)
    BTS_HAL_setupInputXBAR(9, 0, BTS_TRP_PIN_CONFIG_GPIO_CH1);
    BTS_HAL_setupInputXBAR(9, 0, BTS_TRP_PIN_CONFIG_GPIO_CH2);
    BTS_HAL_setupInputXBAR(9, 0, BTS_TRP_PIN_CONFIG_GPIO_CH3);
    BTS_HAL_setupInputXBAR(9, 0, BTS_TRP_PIN_CONFIG_GPIO_CH4);
    BTS_HAL_setupInputXBAR(9, 0, BTS_TRP_PIN_CONFIG_GPIO_CH5);
    BTS_HAL_setupInputXBAR(9, 0, BTS_TRP_PIN_CONFIG_GPIO_CH6);
    BTS_HAL_setupInputXBAR(9, 0, BTS_TRP_PIN_CONFIG_GPIO_CH7);
    BTS_HAL_setupInputXBAR(9, 0, BTS_TRP_PIN_CONFIG_GPIO_CH8);

    // Configure Trip Zones for all ePWM modules
    for (uint16_t i = 1; i <= 8; i++) {
        uint32_t epwmBase = EPWM1_BASE + (i - 1) * 0x1000;
        BTS_HAL_setupEPWMTripZone(epwmBase);
    }
}

// Update BTS_HAL_setupADC
void BTS_HAL_setupADC(void)
{
    ADC_setPrescaler(ADCA_BASE, ADC_CLK_DIV_4_0);
    ADC_setPrescaler(ADCB_BASE, ADC_CLK_DIV_4_0);
    ADC_setPrescaler(ADCC_BASE, ADC_CLK_DIV_4_0);
    ADC_setPrescaler(ADCD_BASE, ADC_CLK_DIV_4_0);

    ADC_setMode(ADCA_BASE, ADC_RESOLUTION_12BIT, ADC_MODE_SINGLE_ENDED);
    ADC_setMode(ADCB_BASE, ADC_RESOLUTION_12BIT, ADC_MODE_SINGLE_ENDED);
    ADC_setMode(ADCC_BASE, ADC_RESOLUTION_12BIT, ADC_MODE_SINGLE_ENDED);
    ADC_setMode(ADCD_BASE, ADC_RESOLUTION_12BIT, ADC_MODE_SINGLE_ENDED);

    ADC_setSOCPriority(ADCA_BASE, ADC_PRI_ALL_ROUND_ROBIN);
    ADC_setSOCPriority(ADCB_BASE, ADC_PRI_ALL_ROUND_ROBIN);
    ADC_setSOCPriority(ADCC_BASE, ADC_PRI_ALL_ROUND_ROBIN);
    ADC_setSOCPriority(ADCD_BASE, ADC_PRI_ALL_ROUND_ROBIN);

    // Cell voltage: Ch1=A3, Ch2=B3, Ch3=A5, Ch4=IN15, Ch5=D1, Ch6=C3, Ch7=D3, Ch8=C5
    ADC_setupSOC(ADCA_BASE, ADC_SOC_NUMBER0, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN3, 15);
    ADC_setupSOC(ADCB_BASE, ADC_SOC_NUMBER0, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN3, 15);
    ADC_setupSOC(ADCA_BASE, ADC_SOC_NUMBER1, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN5, 15);
    ADC_setupSOC(ADCA_BASE, ADC_SOC_NUMBER2, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN15, 15);
    ADC_setupSOC(ADCD_BASE, ADC_SOC_NUMBER0, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN1, 15);
    ADC_setupSOC(ADCC_BASE, ADC_SOC_NUMBER0, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN3, 15);
    ADC_setupSOC(ADCD_BASE, ADC_SOC_NUMBER1, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN3, 15);
    ADC_setupSOC(ADCC_BASE, ADC_SOC_NUMBER1, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN5, 15);

    // Cell current: Ch1=A2, Ch2=B2, Ch3=A4, Ch4=IN14, Ch5=D0, Ch6=C2, Ch7=D2, Ch8=C4
    ADC_setupSOC(ADCA_BASE, ADC_SOC_NUMBER3, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN2, 15);
    ADC_setupSOC(ADCB_BASE, ADC_SOC_NUMBER3, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN2, 15);
    ADC_setupSOC(ADCA_BASE, ADC_SOC_NUMBER4, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN4, 15);
    ADC_setupSOC(ADCA_BASE, ADC_SOC_NUMBER5, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN14, 15);
    ADC_setupSOC(ADCD_BASE, ADC_SOC_NUMBER2, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN0, 15); // Note: D0 used here
    ADC_setupSOC(ADCC_BASE, ADC_SOC_NUMBER2, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN2, 15);
    ADC_setupSOC(ADCD_BASE, ADC_SOC_NUMBER3, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN2, 15);
    ADC_setupSOC(ADCC_BASE, ADC_SOC_NUMBER3, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN4, 15);

    // Reference: A0
    ADC_setupSOC(ADCA_BASE, ADC_SOC_NUMBER6, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN0, 15);

    // B0, B1 (software triggered)
    ADC_setupSOC(ADCB_BASE, ADC_SOC_NUMBER1, ADC_TRIGGER_SW_ONLY, ADC_CH_ADCIN0, 15);
    ADC_setupSOC(ADCB_BASE, ADC_SOC_NUMBER2, ADC_TRIGGER_SW_ONLY, ADC_CH_ADCIN1, 15);

    // ADC interrupt
    ADC_enableInterrupt(ADCA_BASE, ADC_INT_NUMBER1);
    ADC_clearInterruptStatus(ADCA_BASE, ADC_INT_NUMBER1);
    ADC_setInterruptSource(ADCA_BASE, ADC_INT_NUMBER1, ADC_SOC_NUMBER0);

    ADC_enableConverter(ADCA_BASE);
    ADC_enableConverter(ADCB_BASE);
    ADC_enableConverter(ADCC_BASE);
    ADC_enableConverter(ADCD_BASE);
    DEVICE_DELAY_US(1000);
}

// Add ePWM trigger setup for 10kHz
void BTS_HAL_setupAdcTrigger(uint32_t EPWM_BASE)
{
    // Configure ePWM1 for 10kHz trigger
    EPWM_setClockPrescaler(EPWM_BASE, EPWM_CLOCK_DIVIDER_1, EPWM_HSCLOCK_DIVIDER_1);
    EPWM_setTimeBasePeriod(EPWM_BASE, DEVICE_SYSCLK_FREQ / 10000 - 1); // 10kHz
    EPWM_setTimeBaseCounterMode(EPWM_BASE, EPWM_COUNTER_MODE_UP);
    EPWM_setPeriodLoadMode(EPWM_BASE, EPWM_PERIOD_SHADOW_LOAD);
    EPWM_disablePhaseShiftLoad(EPWM_BASE);

    // Trigger SOCA at counter zero
    EPWM_enableADCTrigger(EPWM_BASE, EPWM_SOC_A);
    EPWM_setADCTriggerSource(EPWM_BASE, EPWM_SOC_A, EPWM_SOC_TBCTR_ZERO);
    EPWM_setADCTriggerEventPrescale(EPWM_BASE, EPWM_SOC_A, 1);
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
    EALLOW;
    #if(BTS_SFRA_ENABLED == true) && (BTS_SFRA_ISR_SRC == BTS_SFRA_ISR_SRC_PWM)
    Interrupt_register(INT_EPWM1, &epwm1ISR);
    Interrupt_enable(INT_EPWM1);
#endif
    // Register trip ISR for EPWM1 to EPWM8
    for (uint16_t i = 1; i <= 8; i++) {
        Interrupt_register(INT_EPWM1 + (i - 1), &epwmTripISR);
        Interrupt_enable(INT_EPWM1 + (i - 1));
    }
    EINT;  // Enable Global interrupt INTM
    ERTM;  // Enable Global real-time interrupt DBGM
    EDIS;
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
