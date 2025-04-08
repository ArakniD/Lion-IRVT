/*
 * bts_settings.h
 *
 *  Created on: Aug 11, 2020
 *      Author: a0230328
 */
//custom settings

#ifndef BTS_USER_SETTINGS_H_
#define BTS_USER_SETTINGS_H_

#include "bts_user_calibration.h"

#define BTS_ENABLE_DETECT_CODE (false)
#define BTS_ENABLE_CH1 (true)
#define BTS_ENABLE_CH2 (false)
#define BTS_ENABLE_CH3 (false)
#define BTS_ENABLE_CH4 (false)
#define BTS_ENABLE_CH5 (false)
#define BTS_ENABLE_CH6 (false)
#define BTS_ENABLE_CH7 (false)
#define BTS_ENABLE_CH8 (false)

#define BTS_TRIP_CODE   (true)
#define BTS_OCP_TRIGGER (false)
#define BTS_USER_DEFAULT_TRIP_A           ((float32_t)8)

#define BTS_USER_DEFAULT_TRIP_pu (BTS_IoutGain_ch1_pu *BTS_USER_DEFAULT_TRIP_A +BTS_IoutOffset_ch1_pu)
#define BTS_USER_DEFAULT_TRIP_16b ((int16_t)(BTS_USER_DEFAULT_TRIP_pu *(float32_t)32768.0))
#define BTS_USER_DEFAULT_TRIP_N_16b (-1*BTS_USER_DEFAULT_TRIP_16b)

#define BTS_USER_TRIP_pu(x)     (BTS_userInputs[i].IoutGain_pu *BTS_USER_DEFAULT_TRIP_A + BTS_userInputs[i].IoutOffset_pu)
#define BTS_USER_TRIP_16b(x)    ((int16_t)(BTS_USER_TRIP_pu(x) *(float32_t)32768.0))
#define BTS_USER_TRIP_N_16b(x)  (((int16_t)-1)*BTS_USER_TRIP_16b(x))

#define BTS_SFRA_MODE_CC_PLANT  0
#define BTS_SFRA_MODE_CC_CLOSED 1

#define BTS_SFRA_ENABLED (true)
#define BTS_SFRA_CH_SELECT BTS_SFRA_CH1

#define BTS_ISR_MODE BTS_ISR_MODE_CLOSED_LOOP
#define BTS_ISR_MODE_OPEN_LOOP 1
#define BTS_ISR_MODE_CLOSED_LOOP 2

#define BTS_ISR_CL_MODE_CCCV 1
#define BTS_ISR_CL_MODE_CV 2
#define BTS_ISR_CL_MODE_CC 3

#define BTS_SFRA_CH1 (1)
#define BTS_SFRA_CH2 (2)
#define BTS_SFRA_CH3 (3)
#define BTS_SFRA_CH4 (4)
#define BTS_SFRA_CH5 (5)
#define BTS_SFRA_CH6 (6)
#define BTS_SFRA_CH7 (7)
#define BTS_SFRA_CH8 (8)

#define BTS_SFRA_CAPTURE_DUTY_IOUT (1)
#define BTS_SFRA_CAPTURE_ISET_IOUT (2)
#define BTS_SFRA_CAPTURE_ISET_VOUT (3)
#define BTS_SFRA_CAPTURE_VSET_VOUT (4)

#define BTS_LAB_OPEN_LOOP_ACMC_IOUT (1)
#define BTS_LAB_CLOSED_LOOP_ACMC_IOUT (2)
#define BTS_LAB_OPEN_LOOP_ACMC_VOUT (3)
#define BTS_LAB_CLOSED_LOOP_ACMC_VOUT (4)
#define BTS_LAB_CLOSED_LOOP_CCCV (5)

#define BTS_LAB_TYPE    BTS_LAB_CLOSED_LOOP_ACMC_IOUT


#if BTS_LAB_TYPE == BTS_LAB_OPEN_LOOP_ACMC_IOUT
#define BTS_SFRA_CAPTURE_SETTINGS BTS_SFRA_CAPTURE_DUTY_IOUT
#define BTS_ISR_CL_MODE BTS_ISR_CL_MODE_CC
#define BTS_ISR_MODE BTS_ISR_MODE_OPEN_LOOP
#elif BTS_LAB_TYPE == BTS_LAB_CLOSED_LOOP_ACMC_IOUT
#define BTS_SFRA_CAPTURE_SETTINGS BTS_SFRA_CAPTURE_ISET_IOUT
#define BTS_ISR_CL_MODE BTS_ISR_CL_MODE_CC
#define BTS_ISR_MODE BTS_ISR_MODE_CLOSED_LOOP
#else
#define BTS_ISR_CL_MODE BTS_ISR_CL_MODE_CCCV
#define BTS_ISR_MODE BTS_ISR_MODE_CLOSED_LOOP
#endif

//
// Device clocking conditions
//
#define BTS_SYSCLK_HZ        DEVICE_SYSCLK_FREQ
#define BTS_SYSCLK_NS        ((float32_t)1000000000 / BTS_SYSCLK_HZ)
#define BTS_EPWM_HZ          (DEVICE_SYSCLK_FREQ/2)
#define BTS_EPWM_NS          ((float32_t)1000000000 / BTS_EPWM_HZ)


//
// TASK configuration
//
#define TASKA_CPUTIMER_BASE CPUTIMER0_BASE
#define TASKB_CPUTIMER_BASE CPUTIMER1_BASE
#define TASKC_CPUTIMER_BASE CPUTIMER2_BASE

#define TASKA_FREQ_HZ         ((uint16_t)1000)
#define TASKB_FREQ_HZ         ((uint16_t) 200)
#define TASKC_FREQ_HZ         ((uint16_t)  20)

#define GET_TASKA_TIMER_OVERFLOW_STATUS CPUTimer_getTimerOverflowStatus(TASKA_CPUTIMER_BASE)
#define CLEAR_TASKA_TIMER_OVERFLOW_FLAG CPUTimer_clearOverflowFlag(TASKA_CPUTIMER_BASE)

#define GET_TASKB_TIMER_OVERFLOW_STATUS CPUTimer_getTimerOverflowStatus(TASKB_CPUTIMER_BASE)
#define CLEAR_TASKB_TIMER_OVERFLOW_FLAG CPUTimer_clearOverflowFlag(TASKB_CPUTIMER_BASE)

#define GET_TASKC_TIMER_OVERFLOW_STATUS CPUTimer_getTimerOverflowStatus(TASKC_CPUTIMER_BASE)
#define CLEAR_TASKC_TIMER_OVERFLOW_FLAG CPUTimer_clearOverflowFlag(TASKC_CPUTIMER_BASE)


#define BTS_DRV_EPWM_HR_ENABLED           true
#define BTS_EPWM_HR_ENABLED               true

#define BTS_DRV_EPWM_BASE                 EPWM1_BASE
#define BTS_DRV_EPWM_NUM                  ((uint16_t)1)
#define BTS_DRV_EPWM_H_GPIO               ((uint16_t)1)
#define BTS_DRV_EPWM_H_PIN_CONFIG_EPWM    GPIO_0_EPWM1A
#define BTS_DRV_EPWM_H_PIN_CONFIG_GPIO    GPIO_0_GPIO0
#define BTS_DRV_EPWM_L_GPIO               ((uint16_t)3)
#define BTS_DRV_EPWM_L_PIN_CONFIG_EPWM    GPIO_1_EPWM1B
#define BTS_DRV_EPWM_L_PIN_CONFIG_GPIO    GPIO_1_GPIO1

//CHANNEL 1
#define BTS_EPWM_BASE_CH1                 EPWM1_BASE
#define BTS_EPWM_NUM_CH1                  ((uint16_t)1)
#define BTS_EPWM_H_GPIO_CH1               ((uint16_t)1)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_CH1    GPIO_0_EPWM1A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_CH1    GPIO_0_GPIO0
#define BTS_EPWM_L_GPIO_CH1               ((uint16_t)1)
#define BTS_EPWM_L_PIN_CONFIG_EPWM_CH1    GPIO_1_EPWM1B
#define BTS_EPWM_L_PIN_CONFIG_GPIO_CH1    GPIO_1_GPIO1

//CHANNEL 2
#define BTS_EPWM_BASE_CH2                 EPWM2_BASE
#define BTS_EPWM_NUM_CH2                  ((uint16_t)2)
#define BTS_EPWM_H_GPIO_CH2               ((uint16_t)2)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_CH2    GPIO_2_EPWM2A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_CH2    GPIO_2_GPIO2
#define BTS_EPWM_L_GPIO_CH2               ((uint16_t)3)
#define BTS_EPWM_L_PIN_CONFIG_EPWM_CH2    GPIO_3_EPWM2B
#define BTS_EPWM_L_PIN_CONFIG_GPIO_CH2    GPIO_3_GPIO3

//CHANNEL 3
#define BTS_EPWM_BASE_CH3                 EPWM3_BASE
#define BTS_EPWM_NUM_CH3                  ((uint16_t)3)
#define BTS_EPWM_H_GPIO_CH3               ((uint16_t)4)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_CH3    GPIO_4_EPWM3A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_CH3    GPIO_4_GPIO4
#define BTS_EPWM_L_GPIO_CH3               ((uint16_t)5)
#define BTS_EPWM_L_PIN_CONFIG_EPWM_CH3    GPIO_5_EPWM3B
#define BTS_EPWM_L_PIN_CONFIG_GPIO_CH3    GPIO_5_GPIO5

//CHANNEL 4
#define BTS_EPWM_BASE_CH4                 EPWM4_BASE
#define BTS_EPWM_NUM_CH4                  ((uint16_t)4)
#define BTS_EPWM_H_GPIO_CH4               ((uint16_t)6)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_CH4    GPIO_6_EPWM4A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_CH4    GPIO_6_GPIO6
#define BTS_EPWM_L_GPIO_CH4               ((uint16_t)7)
#define BTS_EPWM_L_PIN_CONFIG_EPWM_CH4    GPIO_7_EPWM4B
#define BTS_EPWM_L_PIN_CONFIG_GPIO_CH4    GPIO_7_GPIO7

//CHANNEL 5
#define BTS_EPWM_BASE_CH5                 EPWM5_BASE
#define BTS_EPWM_NUM_CH5                  ((uint16_t)5)
#define BTS_EPWM_H_GPIO_CH5               ((uint16_t)8)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_CH5    GPIO_8_EPWM5A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_CH5    GPIO_8_GPIO8
#define BTS_EPWM_L_GPIO_CH5               ((uint16_t)9)
#define BTS_EPWM_L_PIN_CONFIG_EPWM_CH5    GPIO_9_EPWM5B
#define BTS_EPWM_L_PIN_CONFIG_GPIO_CH5    GPIO_9_GPIO9

//CHANNEL 6
#define BTS_EPWM_BASE_CH6                 EPWM6_BASE
#define BTS_EPWM_NUM_CH6                  ((uint16_t)6)
#define BTS_EPWM_H_GPIO_CH6               ((uint16_t)10)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_CH6    GPIO_10_EPWM6A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_CH6    GPIO_10_GPIO10
#define BTS_EPWM_L_GPIO_CH6               ((uint16_t)11)
#define BTS_EPWM_L_PIN_CONFIG_EPWM_CH6    GPIO_11_EPWM6B
#define BTS_EPWM_L_PIN_CONFIG_GPIO_CH6    GPIO_11_GPIO11

//CHANNEL 7
#define BTS_EPWM_BASE_CH7                 EPWM7_BASE
#define BTS_EPWM_NUM_CH7                  ((uint16_t)7)
#define BTS_EPWM_H_GPIO_CH7               ((uint16_t)12)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_CH7    GPIO_12_EPWM7A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_CH7    GPIO_12_GPIO12
#define BTS_EPWM_L_GPIO_CH7               ((uint16_t)13)
#define BTS_EPWM_L_PIN_CONFIG_EPWM_CH7    GPIO_13_EPWM7B
#define BTS_EPWM_L_PIN_CONFIG_GPIO_CH7    GPIO_13_GPIO13

//CHANNEL 8
#define BTS_EPWM_BASE_CH8                 EPWM8_BASE
#define BTS_EPWM_NUM_CH8                  ((uint16_t)8)
#define BTS_EPWM_H_GPIO_CH8               ((uint16_t)14)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_CH8    GPIO_14_EPWM8A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_CH8    GPIO_14_GPIO14
#define BTS_EPWM_L_GPIO_CH8               ((uint16_t)15)
#define BTS_EPWM_L_PIN_CONFIG_EPWM_CH8    GPIO_15_EPWM8B
#define BTS_EPWM_L_PIN_CONFIG_GPIO_CH8    GPIO_15_GPIO15

//CHANNEL 11 (ADC1 CLK)
#define BTS_EPWM_BASE_ADC1                EPWM11_BASE
#define BTS_EPWM_NUM_ADC1                 ((uint16_t)11)
#define BTS_EPWM_H_GPIO_ADC1              ((uint16_t)20)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_ADC1   GPIO_20_EPWM11A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_ADC1   GPIO_20_GPIO20

//CHANNEL 12 (ADC2 CLK)
#define BTS_EPWM_BASE_ADC2                EPWM12_BASE
#define BTS_EPWM_NUM_ADC2                 ((uint16_t)12)
#define BTS_EPWM_H_GPIO_ADC2              ((uint16_t)22)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_ADC2   GPIO_22_EPWM12A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_ADC2   GPIO_22_GPIO22

//ADC1 24b sd ch1-4
#define BTS_SPI_BASE_ADC1                 SPIA_BASE
#define BTS_SPI_CS_GPIO_ADC1              ((uint16_t)19)
#define BTS_SPI_DRDY_GPIO_ADC1            ((uint16_t)25)
#define BTS_SPI_RESET_GPIO_ADC1           ((uint16_t)24)
#define BTS_SPI_DOUT_GPIO_ADC1            ((uint16_t)17)
#define BTS_SPI_DIN_GPIO_ADC1             ((uint16_t)16)
#define BTS_SPI_SCLK_GPIO_ADC1            ((uint16_t)18)
#define BTS_SPI_CS_PIN_CONFIG_ADC1        GPIO_19_GPIO19
#define BTS_SPI_DRDY_PIN_CONFIG_ADC1      GPIO_25_GPIO25
#define BTS_SPI_RESET_PIN_CONFIG_ADC1     GPIO_24_GPIO24
#define BTS_SPI_DOUT_PIN_CONFIG_ADC1      GPIO_17_SPISOMIA
#define BTS_SPI_DIN_PIN_CONFIG_ADC1       GPIO_16_SPISIMOA
#define BTS_SPI_SCLK_PIN_CONFIG_ADC1      GPIO_18_SPICLKA
#define BTS_SPI_DRDY_XINT_ADC1            INT_XINT1
#define BTS_PSI_DRDY_XINT_GPIO1           GPIO_INT_XINT1
#define BTS_SPI_DRDY_CINT_ADC1            INT_SPIA_RX
#define BTS_DRDY_ADC1                     ISR1
#define BTS_RXFIFO_SPI1                   ISR2

//ADC2 24b sd ch5-8
#define BTS_SPI_BASE_ADC2                 SPIC_BASE
#define BTS_SPI_CS_GPIO_ADC2              ((uint16_t)53)
#define BTS_SPI_DRDY_GPIO_ADC2            ((uint16_t)49)
#define BTS_SPI_RESET_GPIO_ADC2           ((uint16_t)48)
#define BTS_SPI_DOUT_GPIO_ADC2            ((uint16_t)51)
#define BTS_SPI_DIN_GPIO_ADC2             ((uint16_t)50)
#define BTS_SPI_SCLK_GPIO_ADC2            ((uint16_t)52)
#define BTS_SPI_CS_PIN_CONFIG_ADC2        GPIO_53_GPIO53
#define BTS_SPI_DRDY_PIN_CONFIG_ADC2      GPIO_49_GPIO49
#define BTS_SPI_RESET_PIN_CONFIG_ADC2     GPIO_48_GPIO48
#define BTS_SPI_DOUT_PIN_CONFIG_ADC2      GPIO_51_SPISOMIC
#define BTS_SPI_DIN_PIN_CONFIG_ADC2       GPIO_50_SPISIMOC
#define BTS_SPI_SCLK_PIN_CONFIG_ADC2      GPIO_52_SPICLKC
#define BTS_SPI_DRDY_XINT_ADC2            INT_XINT2
#define BTS_PSI_DRDY_XINT_GPIO2           GPIO_INT_XINT2
#define BTS_SPI_DRDY_CINT_ADC2            INT_SPIC_RX
#define BTS_DRDY_ADC2                     ISR3
#define BTS_RXFIFO_SPI2                   ISR4


// I2C Internal - Master Mode (FRAM/EEPROM)
#define BTS_I2C_INT_BASE                   I2CB_BASE
#define BTS_I2C_INT_SPEED                  400000
#define BTS_I2C_INT_PIN_SDA                ((uint16_t)40)
#define BTS_I2C_INT_PIN_SCL                ((uint16_t)41)
#define BTS_I2C_INT_CFG_SDA                GPIO_40_SDAB
#define BTS_I2C_INT_CFG_SCL                GPIO_41_SCLB
#define BTS_I2C_INT_RXDATA                 I2CB_RXdata
#define BTS_I2C_INT_TXDATA                 I2CB_TXdata
#define BTS_I2C_INT_CNTADDR                I2CB_ControlAddr

// I2C External - Slave mode
#define BTS_I2C_EXT_BASE                   I2CA_BASE
#define BTS_I2C_EXT_SPEED                  400000
#define BTS_I2C_EXT_PIN_SDA                ((uint16_t)32)
#define BTS_I2C_EXT_PIN_SCL                ((uint16_t)33)
#define BTS_I2C_EXT_CFG_SDA                GPIO_32_SDAA
#define BTS_I2C_EXT_CFG_SCL                GPIO_33_SCLA
#define BTS_I2C_EXT_RXDATA                 I2CA_RXdata
#define BTS_I2C_EXT_TXDATA                 I2CA_TXdata
#define BTS_I2C_EXT_CNTADDR                I2CA_ControlAddr

// CAN External - CC/CV set-point and data stream
#define BTS_CAN_BASE                        CANA_BASE
#define BTS_CAN_PIN_CANRX                   GPIO_30_CANRXA
#define BTS_CAN_PIN_CANTX                   GPIO_31_CANTXA

/*
 *  volatile float32_t iref_A;
    volatile float32_t vref_charge_V;
    volatile float32_t vref_discharge_V;
    volatile uint16_t  direction_logic;
    volatile uint16_t  enable_logic;
 */
#define BTS_I2C_ADR_USER_CH1                0x0100
#define BTS_I2C_ADR_USER_CH2                0x0200
#define BTS_I2C_ADR_USER_CH3                0x0300
#define BTS_I2C_ADR_USER_CH4                0x0400
#define BTS_I2C_ADR_USER_CH5                0x0500
#define BTS_I2C_ADR_USER_CH6                0x0600
#define BTS_I2C_ADR_USER_CH7                0x0700
#define BTS_I2C_ADR_USER_CH8                0x0800

/*
 *  float32_t IoutGain_pu;
    float32_t IoutOffset_pu;
    float32_t IoutGain_A;
    float32_t IoutOffset_A;

    float32_t VoutGain_pu;
    float32_t VoutOffset_pu;
    float32_t VoutGain_V;
    float32_t VoutOffset_V;

    uint16_t  pendingUpdate;
 */
#define BTS_I2C_ADR_CAL_CH1                0x1100
#define BTS_I2C_ADR_CAL_CH2                0x1200
#define BTS_I2C_ADR_CAL_CH3                0x1300
#define BTS_I2C_ADR_CAL_CH4                0x1400
#define BTS_I2C_ADR_CAL_CH5                0x1500
#define BTS_I2C_ADR_CAL_CH6                0x1600
#define BTS_I2C_ADR_CAL_CH7                0x1700
#define BTS_I2C_ADR_CAL_CH8                0x1800

#define BTS_senseAverageFactor 32 //32U

#define VIN ((float32_t)12)


#if 0

#define BTS_DCL_CC_B0                ((float32_t) 0.0342955642)
#define BTS_DCL_CC_B1                ((float32_t)-0.0611383610)
#define BTS_DCL_CC_B2                ((float32_t) 0.0270789596)
#define BTS_DCL_CC_A1                ((float32_t)-1.9244278933)
#define BTS_DCL_CC_A2                ((float32_t) 0.9244278933)
#elif 0
//Kdc 150
//Fz0 0.1
//Fz1 0.7
//Fp1 0.5

#define BTS_DCL_CC_B0                ((float32_t) 0.1755347)
#define BTS_DCL_CC_B1                ((float32_t) -0.3244942)
#define BTS_DCL_CC_B2                ((float32_t)  0.1494189)
#define BTS_DCL_CC_A1                ((float32_t) -1.9042804)
#define BTS_DCL_CC_A2                ((float32_t) 0.9042804)
#else
//Kdc 50
//Fz0 0.1
//Fz1 0.5
//Fp1 0.2
#define BTS_DCL_CC_B0                ((float32_t) 0.0331015)
#define BTS_DCL_CC_B1                ((float32_t) -0.0623757)
#define BTS_DCL_CC_B2                ((float32_t)  0.0293372)
#define BTS_DCL_CC_A1                ((float32_t) -1.9605802)
#define BTS_DCL_CC_A2                ((float32_t) 0.9605802)
#endif

#if 0
#define BTS_DCL_CV_KDC               ((float32_t)5000)
#define BTS_DCL_CV_Z0                ((float32_t)0.100)
#define BTS_DCL_CV_Z1                ((float32_t)1.000) // 2
#define BTS_DCL_CV_P1                ((float32_t)1.000) // 2

#define BTS_DCL_CV_B0                ((float32_t) 1.3718226)
#define BTS_DCL_CV_B1                ((float32_t)-2.4455344)
#define BTS_DCL_CV_B2                ((float32_t) 1.0831584)
#define BTS_DCL_CV_A1                ((float32_t)-1.9244279)
#define BTS_DCL_CV_A2                ((float32_t) 0.9244279)
#else

#define BTS_DCL_CV_KDC               ((float32_t)5000)
#define BTS_DCL_CV_Z0                ((float32_t)0.100)
#define BTS_DCL_CV_Z1                ((float32_t)2.000) // 2
#define BTS_DCL_CV_P1                ((float32_t)2.000) // 2

#define BTS_DCL_CV_B0                ((float32_t) 8.0377472)
#define BTS_DCL_CV_B1                ((float32_t)-13.2244008)
#define BTS_DCL_CV_B2                ((float32_t) 5.2402228)
#define BTS_DCL_CV_A1                ((float32_t)-1.6651931)
#define BTS_DCL_CV_A2                ((float32_t) 0.6651931)

#endif


#define BTS_SFRA_ISR_SRC_ADC 0
#define BTS_SFRA_ISR_SRC_PWM 1
#define BTS_SFRA_ISR_SRC                   BTS_SFRA_ISR_SRC_ADC

#if(BTS_SFRA_ENABLED == true)
    //#define BTS_SFRA_EPWM               (EPWM9_BASE)
    //#define BTS_SFRA_TDRD               ((BTS_DRV_EPWM_SWITCHING_FREQUENCY / BTS_SFRA_ISR_FREQ_REQ ) - 1)
#if (BTS_SFRA_ISR_SRC == BTS_SFRA_ISR_SRC_ADC)
    #define BTS_SFRA_ISR_FREQ             ((float32_t)31250)
    #define BTS_SFRA_FREQ_LENGTH          ((int16_t)103)
#else
    #define BTS_SFRA_ISR_FREQ             ((float32_t)100000)
    #define BTS_SFRA_FREQ_LENGTH          ((int16_t)120)
#endif

    #define BTS_SFRA_FREQ_START           ((float32_t)10.0f)

    //
    // SFRA step Multiply = 10^(1/No of steps per decade(35))
    //
    #define BTS_SFRA_FREQ_STEP_MULTIPLY   ((float32_t) 1.0746078283213174972f)

#if(BTS_SFRA_CAPTURE_SETTINGS == BTS_SFRA_CAPTURE_DUTY_IOUT)
    #define BTS_SFRA_AMPLITUDE            ((float32_t)0.0075)
#elif((BTS_SFRA_CAPTURE_SETTINGS==BTS_SFRA_CAPTURE_ISET_IOUT)||(BTS_SFRA_CAPTURE_SETTINGS==BTS_SFRA_CAPTURE_ISET_VOUT))
#define BTS_SFRA_AMPLITUDE            ((float32_t)0.1)
#elif(BTS_SFRA_CAPTURE_SETTINGS == BTS_SFRA_CAPTURE_VSET_VOUT)
#define BTS_SFRA_AMPLITUDE            ((float32_t)0.005)
#endif
    #define BTS_SFRA_SWEEP_SPEED          ((int16_t)3)

    #define BTS_SFRA_GUI_SCI_BASE         SCIA_BASE
    #define BTS_SFRA_GUI_SCI_BAUDRATE     ((uint32_t)57600)
    #define BTS_SFRA_GUI_SCIRX_GPIO       ((uint16_t)28)
    #define BTS_SFRA_GUI_SCIRX_PIN_CONFIG GPIO_28_SCIRXDA
    #define BTS_SFRA_GUI_SCITX_GPIO       ((uint16_t)29)
    #define BTS_SFRA_GUI_SCITX_PIN_CONFIG GPIO_29_SCITXDA

    #define BTS_SFRA_GUI_LED_ENABLE       ((uint16_t)1)
    #define BTS_SFRA_GUI_LED_GPIO         ((uint16_t)47)
    #define BTS_SFRA_GUI_LED_PIN_CONFIG   GPIO_47_GPIO47
    #define BTS_SFRA_GUI_PLOT_OPTION      ((uint16_t)SFRA_GUI_PLOT_GH_H)
#endif

#define BTS_SFRA_CHANNEL 1

#define BTS_DUTY_SET_MIN_PU               ((float32_t)0.0)
#define BTS_DUTY_SET_MAX_PU               ((float32_t)0.55)


//
// Control Configuration
//
#define BTS_DCL_CTRL_TYPE                 DCL_DF22

#define BTS_DCL_FPU32                     1
#define BTS_DCL_CLA                       2
#define BTS_DCL_CORE                      BTS_DCL_FPU32
#define BTS_DCL_PI                        CONST_PI_32

#if(BTS_DCL_CTRL_TYPE == DCL_DF22)
    #define BTS_DCL_CTRL_DEFAULTS         DF22_DEFAULTS
    #define BTS_DCL_SPS_TYPE              DCL_DF22_SPS
    #define BTS_DCL_SPS_DEFAULTS          DF22_SPS_DEFAULTS
    #define BTS_DCL_RESET                 DCL_resetDF22
    #define BTS_DCL_LOAD_PID              DCL_loadDF22asSeriesPID
    #define BTS_DCL_LOAD_ZPK              DCL_loadDF22asZPK
    #define BTS_DCL_UPDATE                DCL_updateDF22

    #if(BTS_DCL_CORE == BTS_DCL_FPU32)
        #define BTS_DCL_RUN_IMMEDIATE     DCL_runDF22_C5
        #define BTS_DCL_RUN_PARTIAL       DCL_runDF22_C6
        #define BTS_DCL_RUN_CLAMP         DCL_runClamp_C2
    #elif(BTS_DCL_CORE == BTS_DCL_CLA)
        #define BTS_DCL_RUN_IMMEDIATE     DCL_runDF22_L2
        #define BTS_DCL_RUN_PARTIAL       DCL_runDF22_L3
        #define BTS_DCL_RUN_CLAMP         DCL_runClamp_L1
    #endif
#endif




//
// Synchronous buck ePWM configuration
//


#define BTS_DRV_EPWM_EPWMCLK_DIV          EPWM_CLOCK_DIVIDER_1
#define BTS_DRV_EPWM_HSCLK_DIV            EPWM_HSCLOCK_DIVIDER_1


#if(BTS_DRV_EPWM_HSCLK_DIV == EPWM_HSCLOCK_DIVIDER_1)
    #define BTS_DRV_EPWM_TOTAL_CLKDIV     ((uint16_t)0x1 << BTS_DRV_EPWM_EPWMCLK_DIV)
#else
    #define BTS_DRV_EPWM_TOTAL_CLKDIV     (((uint16_t)0x1 << BTS_DRV_EPWM_EPWMCLK_DIV) * (BUCK_DRV_EPWM_HSCLK_DIV << 1))
#endif



#define BTS_DRV_EPWM_PERIOD_TICKS         ((uint32_t)(BTS_EPWM_HZ / BTS_DRV_EPWM_SWITCHING_FREQUENCY / BTS_DRV_EPWM_TOTAL_CLKDIV))
#define BTS_DRV_EPWM_TBPRD                ((uint32_t)BTS_DRV_EPWM_PERIOD_TICKS - 1)
#define BTS_DRV_EPWM_PERIOD_SEC           ((uint32_t)BTS_DRV_EPWM_PERIOD_TICKS / BTS_EPWM_HZ)
#define BTS_DRV_EPWM_DEADBAND_RED         ((uint16_t)(150 / BTS_EPWM_NS))
#define BTS_DRV_EPWM_DEADBAND_FED         ((uint16_t)(150 / BTS_EPWM_NS))
#define BTS_DRV_EPWM_DC_TRIP_OC           EPWM_DC_TRIP_TRIPIN4
#define BTS_DRV_EPWM_DC_TRIP_PCMC         EPWM_DC_TRIP_TRIPIN5

#define BTS_DRV_EPWM_SWITCHING_FREQUENCY  ((BTS_DRV_ADC_SWITCHING_FREQUENCY / (float32_t)2 / (float32_t)128 ) * (float32_t)3)

// 99,609.375 Hz

#define BTS_DRV_ADC_EPWMCLK_DIV          EPWM_CLOCK_DIVIDER_1
#define BTS_DRV_ADC_HSCLK_DIV            EPWM_HSCLOCK_DIVIDER_1

#if(BTS_DRV_ADC_HSCLK_DIV == EPWM_HSCLOCK_DIVIDER_1)
    #define BTS_DRV_ADC_TOTAL_CLKDIV     ((uint16_t)0x1 << BTS_DRV_ADC_EPWMCLK_DIV)
#else
    #define BTS_DRV_ADC_TOTAL_CLKDIV     (((uint16_t)0x1 << BTS_DRV_ADC_EPWMCLK_DIV) * (BUCK_DRV_ADC_HSCLK_DIV << 1))
#endif

#define BTS_DRV_ADC_PERIOD_TICKS         ((uint32_t)((BTS_EPWM_HZ) / BTS_DRV_ADC_SWITCHING_FREQUENCY / BTS_DRV_ADC_TOTAL_CLKDIV))
#define BTS_DRV_ADC_TBPRD                ((uint32_t)BTS_DRV_ADC_PERIOD_TICKS - 1)
#define BTS_DRV_ADC_PERIOD_SEC           ((uint32_t)BTS_DRV_ADC_PERIOD_TICKS / BTS_EPWM_HZ / 2)

#define BTS_DRV_ADC_SWITCHING_FREQUENCY  ((float32_t)8500 * 1000)

// Sampling speed of 33,203.125 Hz

#if(BTS_DRV_EPWM_HR_ENABLED == true)
    #define BTS_DRV_EPWM_CMPAHR_BITS          8
    #define BTS_DRV_EPWM_CMPAHR_SCALE         ((uint16_t)0x1 << BUCK_DRV_EPWM_CMPAHR_BITS)
    #define BTS_DRV_EPWM_CMPBHR_BITS          8
    #define BTS_DRV_EPWM_CMPBHR_SCALE         ((uint16_t)0x1 << BUCK_DRV_EPWM_CMPBHR_BITS)
#endif


//
// Heart beat LED on board
//
#define BTS_RUN_LED_GPIO                  47
#define BTS_RUN_LED_PIN_CONFIG            GPIO_47_GPIO47
#define BTS_RUN_LED_PRESCALE              ((uint16_t)5)

#endif /* BTS_USER_SETTINGS_H_ */
