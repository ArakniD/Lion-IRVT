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

#define BTS_ENABLE_CH1 (true)
#define BTS_ENABLE_CH2 (true)
#define BTS_ENABLE_CH3 (true)
#define BTS_ENABLE_CH4 (true)

#define BTS_TRIP_CODE (true)
#define BTS_OCP_TRIGGER (false)
#define BTS_USER_DEFAULT_TRIP_A           ((float32_t)12.0)
#define BTS_USER_DEFAULT_TRIP_pu (BTS_IoutGain_ch1_pu *BTS_USER_DEFAULT_TRIP_A +BTS_IoutOffset_ch1_pu)
#define BTS_USER_DEFAULT_TRIP_16b ((int16_t)(BTS_USER_DEFAULT_TRIP_pu *(float32_t)32768.0))
#define BTS_USER_DEFAULT_TRIP_N_16b (-1*BTS_USER_DEFAULT_TRIP_16b)

#define BTS_ISR_MODE BTS_ISR_MODE_CLOSED_LOOP
#define BTS_ISR_MODE_OPEN_LOOP 1
#define BTS_ISR_MODE_CLOSED_LOOP 2

#define BTS_ISR_CL_MODE BTS_ISR_CL_MODE_CCCV

#define BTS_ISR_CL_MODE_CCCV 1
#define BTS_ISR_CL_MODE_CV 2
#define BTS_ISR_CL_MODE_CC 3


#define BTS_SFRA_ENABLED (false)
#define BTS_SFRA_CH_SELECT BTS_SFRA_CH1

#define BTS_SFRA_CH1 (1)
#define BTS_SFRA_CH2 (2)
#define BTS_SFRA_CH3 (3)
#define BTS_SFRA_CH4 (4)


#define BTS_SFRA_CAPTURE_SETTINGS BTS_SFRA_CAPTURE_ISET_IOUT
#define BTS_SFRA_CAPTURE_DUTY_IOUT (1)
#define BTS_SFRA_CAPTURE_ISET_IOUT (2)
#define BTS_SFRA_CAPTURE_ISET_VOUT (3)
#define BTS_SFRA_CAPTURE_VSET_VOUT (4)


#define BTS_LAB_OPEN_LOOP_ACMC_IOUT (1)
#define BTS_LAB_CLOSED_LOOP_ACMC_IOUT (2)
#define BTS_LAB_OPEN_LOOP_ACMC_VOUT (3)
#define BTS_LAB_CLOSED_LOOP_ACMC_VOUT (4)
#define BTS_LAB_CLOSED_LOOP_CCCV (5)



//
// Device clocking conditions
//
#define BTS_SYSCLK_HZ        ((float32_t)100 * 1000000)
#define BTS_SYSCLK_NS        ((float32_t)1000000000 / BTS_SYSCLK_HZ)
#define BTS_EPWM_HZ          ((float32_t)100 * 1000000)
#define BTS_EPWM_NS          ((float32_t)1000000000 / BTS_EPWM_HZ)
#define BTS_INTOSC_HZ        ((float32_t) 10 * 1000000)


//
// TASK configuration
//
#define TASKA_CPUTIMER_BASE CPUTIMER0_BASE
#define TASKB_CPUTIMER_BASE CPUTIMER1_BASE
#define TASKC_CPUTIMER_BASE CPUTIMER2_BASE

#define TASKA_FREQ_HZ         ((uint16_t)1000)
#define TASKB_FREQ_HZ         ((uint16_t) 100)
#define TASKC_FREQ_HZ         ((uint16_t)  10)

#define GET_TASKA_TIMER_OVERFLOW_STATUS CPUTimer_getTimerOverflowStatus(TASKA_CPUTIMER_BASE)
#define CLEAR_TASKA_TIMER_OVERFLOW_FLAG CPUTimer_clearOverflowFlag(TASKA_CPUTIMER_BASE)

#define GET_TASKB_TIMER_OVERFLOW_STATUS CPUTimer_getTimerOverflowStatus(TASKB_CPUTIMER_BASE)
#define CLEAR_TASKB_TIMER_OVERFLOW_FLAG CPUTimer_clearOverflowFlag(TASKB_CPUTIMER_BASE)

#define GET_TASKC_TIMER_OVERFLOW_STATUS CPUTimer_getTimerOverflowStatus(TASKC_CPUTIMER_BASE)
#define CLEAR_TASKC_TIMER_OVERFLOW_FLAG CPUTimer_clearOverflowFlag(TASKC_CPUTIMER_BASE)


#define BTS_DRV_EPWM_HR_ENABLED           true
#define BTS_EPWM_HR_ENABLED           true

#define BTS_DRDY_ADC1 ISR1
#define BTS_RXFIFO_SPI1 ISR2

#define BTS_DRV_EPWM_BASE                 EPWM2_BASE //change here
#define BTS_DRV_EPWM_NUM                  ((uint16_t)2)
#define BTS_DRV_EPWM_H_GPIO               ((uint16_t)2)
#define BTS_DRV_EPWM_H_PIN_CONFIG_EPWM    GPIO_2_EPWM2A
#define BTS_DRV_EPWM_H_PIN_CONFIG_GPIO    GPIO_2_GPIO2
#define BTS_DRV_EPWM_L_GPIO               ((uint16_t)3)
#define BTS_DRV_EPWM_L_PIN_CONFIG_EPWM    GPIO_3_EPWM2B
#define BTS_DRV_EPWM_L_PIN_CONFIG_GPIO    GPIO_3_GPIO3


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



#define BTS_senseAverageFactor 32U

#define VIN ((float32_t)12V)


#define BTS_DCL_CC_B0                ((float32_t) 0.0342955642)
#define BTS_DCL_CC_B1                ((float32_t)-0.0611383610)
#define BTS_DCL_CC_B2                ((float32_t) 0.0270789596)
#define BTS_DCL_CC_A1                ((float32_t)-1.9244278933)
#define BTS_DCL_CC_A2                ((float32_t) 0.9244278933)




#define BTS_DCL_CV_KDC               ((float32_t)5000)
#define BTS_DCL_CV_Z0                ((float32_t)0.100)
#define BTS_DCL_CV_Z1                ((float32_t)1.000)
#define BTS_DCL_CV_P1                ((float32_t)1.000)


#define BTS_DCL_CV_B0                ((float32_t) 1.3718226)
#define BTS_DCL_CV_B1                ((float32_t)-2.4455344)
#define BTS_DCL_CV_B2                ((float32_t) 1.0831584)
#define BTS_DCL_CV_A1                ((float32_t)-1.9244279)
#define BTS_DCL_CV_A2                ((float32_t) 0.9244279)




#if(BTS_SFRA_ENABLED == true)
//    #define BTS_SFRA_ISR_FREQ             BTS_DRV_EPWM_SWITCHING_FREQUENCY
    #define BTS_SFRA_ISR_FREQ             ((float32_t)16000)
    #define BTS_SFRA_FREQ_START           ((float32_t)10)

    //
    // SFRA step Multiply = 10^(1/No of steps per decade(35))
    //
    #define BTS_SFRA_FREQ_STEP_MULTIPLY   ((float32_t)1.0680004)
    #define BTS_SFRA_FREQ_LENGTH          ((int16_t)100)

#if(BTS_SFRA_CAPTURE_SETTINGS == BTS_SFRA_CAPTURE_DUTY_IOUT)
    #define BTS_SFRA_AMPLITUDE            ((float32_t)0.005)
#elif((BTS_SFRA_CAPTURE_SETTINGS==BTS_SFRA_CAPTURE_ISET_IOUT)||(BTS_SFRA_CAPTURE_SETTINGS==BTS_SFRA_CAPTURE_ISET_VOUT))
#define BTS_SFRA_AMPLITUDE            ((float32_t)0.1)
#elif(BTS_SFRA_CAPTURE_SETTINGS == BTS_SFRA_CAPTURE_VSET_VOUT)
#define BTS_SFRA_AMPLITUDE            ((float32_t)0.005)
#endif
    #define BTS_SFRA_SWEEP_SPEED          ((int16_t)1)

    #define BTS_SFRA_GUI_SCI_BASE         SCIA_BASE
    #define BTS_SFRA_GUI_SCI_BAUDRATE     ((uint32_t)57600)
    #define BTS_SFRA_GUI_SCIRX_GPIO       ((uint16_t)28)
    #define BTS_SFRA_GUI_SCIRX_PIN_CONFIG GPIO_28_SCIRXDA
    #define BTS_SFRA_GUI_SCITX_GPIO       ((uint16_t)29)
    #define BTS_SFRA_GUI_SCITX_PIN_CONFIG GPIO_29_SCITXDA

    #define BTS_SFRA_GUI_LED_ENABLE       ((uint16_t)1)
    #define BTS_SFRA_GUI_LED_GPIO         ((uint16_t)34)
    #define BTS_SFRA_GUI_LED_PIN_CONFIG   GPIO_34_GPIO34
    #define BTS_SFRA_GUI_PLOT_OPTION      ((uint16_t)1)
#endif

//#define BTS_SFRA_CHANNEL ((uint16_t)2)

#define BTS_DUTY_SET_MIN_PU               ((float32_t)0.00)
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

#define BTS_DRV_EPWM_SWITCHING_FREQUENCY  ((float32_t)100 * 1000)

#if(BTS_DRV_EPWM_HR_ENABLED == true)
    #define BTS_DRV_EPWM_CMPAHR_BITS          8
    #define BTS_DRV_EPWM_CMPAHR_SCALE         ((uint16_t)0x1 << BUCK_DRV_EPWM_CMPAHR_BITS)
    #define BTS_DRV_EPWM_CMPBHR_BITS          8
    #define BTS_DRV_EPWM_CMPBHR_SCALE         ((uint16_t)0x1 << BUCK_DRV_EPWM_CMPBHR_BITS)
#endif


//
// Heart beat LED on board
//
#define BTS_RUN_LED_GPIO                  32
#define BTS_RUN_LED_PIN_CONFIG            GPIO_32_GPIO32
#define BTS_RUN_LED_PRESCALE              ((uint16_t)5)

#endif /* BTS_USER_SETTINGS_H_ */
