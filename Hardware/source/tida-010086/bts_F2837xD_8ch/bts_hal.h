//#############################################################################
//
// FILE:  buck_hal.h
//
// TITLE: Solution hardware abstraction layer
//        Low level functions and resources with hardware dependencies
//        Example: Functions to read current and voltage signals
//        Example: Functions to configure device peripherals
//
//#############################################################################
// $TI Release: TIDM_DC_DC_BUCK v2.00.00.00 $
// $Release Date: Wed May 27 12:53:14 CDT 2020 $
// $Copyright:
// Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
//
// ALL RIGHTS RESERVED
// $
//#############################################################################

#ifndef BTS_HAL_H
#define BTS_HAL_H

#ifdef __cplusplus

extern "C" {
#endif

//
//=============================================================================
// includes
//=============================================================================
//
#include "driverlib.h"
#include "device.h"
#include <bts_user_settings.h>

//
//=============================================================================
// variables
//=============================================================================
//
#if(BUCK_DRV_EPWM_HR_ENABLED == true)
    extern volatile uint32_t ePWM[9];
#endif

#if(BTS_DRV_EPWM_HR_ENABLED == true)
    extern volatile uint32_t ePWM[9];
#endif


typedef struct
{
    volatile uint16_t response;
    volatile uint16_t crc;
    volatile int32_t channel0;
    volatile int32_t channel1;
    volatile int32_t channel2;
    volatile int32_t channel3;
    volatile int32_t channel4;
    volatile int32_t channel5;
    volatile int32_t channel6;
    volatile int32_t channel7;
} adc_data;

extern adc_data  BTS_ADC1;
extern adc_data  BTS_ADC2;
extern volatile uint16_t BTS_ExAdcRxflag1 ;
extern volatile uint16_t BTS_ExAdcRxflag2 ;
extern uint32_t  MEP_ScaleFactor;

//
//=============================================================================
// Function prototypes from HAL source
//=============================================================================
//
void BTS_HAL_setupDevice(void);
void BTS_HAL_setupExAdc_ch1_4(void);
void BTS_HAL_setupExAdc_ch5_8(void);
void delay_ms_2(const uint32_t);
void BTS_HAL_setupExAdcGpio_Adc1(void);
void BTS_HAL_setupExAdcGpio_Adc2(void);

void BTS_HAL_setupSyncBuckPinsGpio(void);
void BTS_HAL_setupSyncBuckPinsEpwm(void);
void BTS_HAL_setupSyncBuckPwm(uint32_t);
void BTS_HAL_setupAdcClock(uint32_t EPWM_BASE);

void BTS_HAL_disableEpwmCounting(void);
void BTS_HAL_enableEpwmCounting(void);
void BTS_HAL_setupSfraClock(uint32_t EPWM_BASE);
void BTS_HAL_setupInterruptTrigger_Adc1(void);
void BTS_HAL_setupInterruptTrigger_Adc2(void);
void BTS_HAL_setupInterrupt(void);
void BTS_HAL_setupInterrupt_Adc1(void);
void BTS_HAL_setupInterrupt_Adc2(void);
void BTS_HAL_setupGPIO(void);
void BTS_HAL_SetupSpi(uint32_t base);
void BTS_HAL_SetupSpiPinsGpio_Adc1(void);
void BTS_HAL_SetupSpiPinsGpio_Adc2(void);

__interrupt void ISR1(void);
__interrupt void ISR2(void);
__interrupt void ISR3(void);
__interrupt void ISR4(void);
__interrupt void epwm1ISR(void);

static inline void BTS_HAL_ExAdcTxframe(uint32_t base){
    //set CS low before this function
    //clear TX fifo


    //send bytes for N channel data read
    uint16_t crcWordIn =0;
    int i =0;

#ifdef ENABLE_CRC_IN
    // Build CRC word (only if "RX_CRC_EN" register bit is enabled)
    crcWordIn = calculateCRC(&DataTx[0], bytesPerWord * 2, 0xFFFF);
    crcTx[0] = upperByte(crcWordIn);
    crcTx[1] = lowerByte(crcWordIn);
#endif

//disable FIFO interrupts
//    SPI_disableInterrupt(SPIA_BASE, SPI_INT_TXFF);
// send null word
//   SPI_writeDataBlockingFIFO(base, 0x0000);
    HWREGH(base + SPI_O_TXBUF) = 0x0000;
//send CRC
//   SPI_writeDataBlockingFIFO(base, crcWordIn);
    HWREGH(base + SPI_O_TXBUF) = crcWordIn;
//send rest 8 words
   for( i=0;i<8U;i++){
//       SPI_writeDataBlockingFIFO(base, 0x0000);
       HWREGH(base + SPI_O_TXBUF) = 0x0000;

   }

//enable fifo interrupts
//   SPI_enableInterrupt(SPIA_BASE, SPI_INT_TXFF);
}

static inline void BTS_HAL_ExAdcRxframe(adc_data *DataStruct, uint32_t base){
// read from the buffer
    DataStruct->response=HWREGH(base + SPI_O_RXBUF);

    DataStruct->channel0=HWREGH(base + SPI_O_RXBUF);
    DataStruct->channel1=HWREGH(base + SPI_O_RXBUF);
    DataStruct->channel2=HWREGH(base + SPI_O_RXBUF);
    DataStruct->channel3=HWREGH(base + SPI_O_RXBUF);
    DataStruct->channel4=HWREGH(base + SPI_O_RXBUF);
    DataStruct->channel5=HWREGH(base + SPI_O_RXBUF);
    DataStruct->channel6=HWREGH(base + SPI_O_RXBUF);
    DataStruct->channel7=HWREGH(base + SPI_O_RXBUF);
    DataStruct->crc=HWREGH(base + SPI_O_RXBUF);

}

static inline void BTS_ExAdcSendTxFrame_ch1_4(void){
    if(BTS_ExAdcRxflag1==1)// data is available in the FIFO to read
    {
        BTS_ExAdcRxflag1 =0;

        GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 0);// make cs low and send the data

        //send command to read data
        BTS_HAL_ExAdcTxframe(BTS_SPI_BASE_ADC1);

    }
}

static inline void BTS_ExAdcSendTxFrame_ch5_8(void){
    if(BTS_ExAdcRxflag2==1)// data is available in the FIFO to read
    {
        BTS_ExAdcRxflag2 =0;

        GPIO_writePin(BTS_SPI_CS_GPIO_ADC2, 0);// make cs low and send the data

        //send command to read data
        BTS_HAL_ExAdcTxframe(BTS_SPI_BASE_ADC2);

    }
}

static inline void BTS_ExAdcRead_ch1_4(){
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 1);// make cs high
    BTS_HAL_ExAdcRxframe(&BTS_ADC1,BTS_SPI_BASE_ADC1);
//    SPI_clearInterruptStatus(BTS_SPI_BASE_ADC1, SPI_INT_RXFF );
    BTS_ExAdcRxflag1=1; // flag to hold receive is complete
    //SPI_resetRxFIFO(BTS_SPI_BASE_ADC1);
    //SPI_resetTxFIFO(BTS_SPI_BASE_ADC1);
    SPI_clearInterruptStatus(BTS_SPI_BASE_ADC1, SPI_INT_RXFF );
    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP6);

    if (GPIO_readPin(BTS_SPI_DRDY_GPIO_ADC1) == 0) {
        BTS_ExAdcSendTxFrame_ch1_4();
    }
}

static inline void BTS_ExAdcRead_ch5_8(){
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC2, 1);// make cs high
    BTS_HAL_ExAdcRxframe(&BTS_ADC2,BTS_SPI_BASE_ADC2);
//    SPI_clearInterruptStatus(BTS_SPI_BASE_ADC2, SPI_INT_RXFF );
    BTS_ExAdcRxflag2=1; // flag to hold receive is complete
    //SPI_resetRxFIFO(BTS_SPI_BASE_ADC2);
    //SPI_resetTxFIFO(BTS_SPI_BASE_ADC2);
    SPI_clearInterruptStatus(BTS_SPI_BASE_ADC2, SPI_INT_RXFF );
    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP6);

    if (GPIO_readPin(BTS_SPI_DRDY_GPIO_ADC2) == 0) {
        BTS_ExAdcSendTxFrame_ch5_8();
    }
}

//
//=============================================================================
// static inline functions
//=============================================================================
//

#pragma FUNC_ALWAYS_INLINE(BTS_HAL_getLowSpeedClock)
static inline uint32_t BTS_HAL_getLowSpeedClock(void)
{
    #ifdef USE_INTOSC
        return( SysCtl_getLowSpeedClock((uint32_t)BUCK_INTOSC_HZ) );
    #else
        return( SysCtl_getLowSpeedClock(DEVICE_OSCSRC_FREQ) );
    #endif
}



static inline void BTS_HAL_updateDuty(uint32_t EPWM_BASE, float32_t dutySetH_pu, float32_t dutySetL_pu)
{
    uint16_t comp= dutySetH_pu *BTS_DRV_EPWM_TBPRD;
    uint16_t compHR = ((float32_t)BTS_DRV_EPWM_TBPRD*dutySetH_pu-(float32_t)comp) * (float32_t)MEP_ScaleFactor;
    EPWM_setCounterCompareValue(EPWM_BASE,
                                EPWM_COUNTER_COMPARE_A,
                                comp);
    HRPWM_setHiResCounterCompareValueOnly(EPWM_BASE,
                                          HRPWM_COUNTER_COMPARE_A,
                                          compHR);

    comp= dutySetL_pu *BTS_DRV_EPWM_TBPRD;
    compHR = ((float32_t)BTS_DRV_EPWM_TBPRD*dutySetL_pu-(float32_t)comp) * (float32_t)MEP_ScaleFactor;
    EPWM_setCounterCompareValue(EPWM_BASE,
                                EPWM_COUNTER_COMPARE_B,
                                comp);
    HRPWM_setHiResCounterCompareValueOnly(EPWM_BASE,
                                          HRPWM_COUNTER_COMPARE_B,
                                          compHR);
}




#pragma FUNC_ALWAYS_INLINE(BTS_HAL_clearInterruptFlags);
static inline void BTS_HAL_clearInterruptFlags(void)
{
    ///
}


#ifdef __cplusplus
}
#endif                                  /* extern "C" */

#endif
