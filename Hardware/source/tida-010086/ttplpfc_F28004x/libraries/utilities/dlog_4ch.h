//#############################################################################
//
//  FILE:     dlog_4ch.h
//
//  TITLE:    Four Channel Data Logger (DLOG_4CH) Module
//
//#############################################################################
// $TI Release: Utilities Library v1.02.00.00 $
// $Release Date: Tue Mar 23 14:55:34 CDT 2021 $
// $Copyright:
// Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
//
// ALL RIGHTS RESERVED
// $
//#############################################################################

#ifndef DLOG_4CH_H
#define DLOG_4CH_H

#ifdef __cplusplus
extern "C" {
#endif

//*****************************************************************************
//
//! \addtogroup DLOG_4CH
//! @{
//
//*****************************************************************************

//
// Included Files
//
#include <stdint.h>
#ifndef __TMS320C28XX_CLA__
#include <math.h>
#else
#include <CLAmath.h>
#endif


//#############################################################################
//
// Macro Definitions
//
//#############################################################################
#ifndef C2000_IEEE754_TYPES
#define C2000_IEEE754_TYPES
#ifdef __TI_EABI__
typedef float         float32_t;
typedef double        float64_t;
#else // TI COFF
typedef float         float32_t;
typedef long double   float64_t;
#endif // __TI_EABI__
#endif // C2000_IEEE754_TYPES


//! \brief Defines the Four Channel Data Logger (DLOG_4CH) structure
//!
//! \details The dlog can be used to perform data logging to emulate an
//!          oscilloscope in software to graphically observe system
//!          variables
//!
typedef volatile struct{
	float32_t *inputPtr1;
	float32_t *inputPtr2;
	float32_t *inputPtr3;
	float32_t *inputPtr4;
	float32_t *outputPtr1;
	float32_t *outputPtr2;
	float32_t *outputPtr3;
	float32_t *outputPtr4;
	float32_t prevValue;
	float32_t trigValue;
	int16_t status;
	int16_t preScalar;
	int16_t skipCount;
	int16_t size;
	int16_t count;
} DLOG_4CH;

//! \brief resets internal storage data
//! \param *v The DLOG_4CH structure pointer
//! \return None
//!
static inline void DLOG_4CH_reset(DLOG_4CH *v)
{
	v->prevValue=0;
	v->trigValue=0;
	v->status=0;
	v->skipCount=0;
	v->count=0;
}

//! \brief Configures DLOG_4CH module
//! \param *v The pointer to DLOG_4CH structure pointer
//! \param input_ptr1 Pointer to data being buffered in the first buffer
//! \param input_ptr2 Pointer to data being buffered in the second buffer
//! \param input_ptr3 Pointer to data being buffered in the third buffer
//! \param input_ptr4 Pointer to data being buffered in the fourth buffer
//! \param output_ptr1 Pointer to where first array of buffered data is stored
//! \param output_ptr2 Pointer to where second array of buffered data is stored
//! \param output_ptr3 Pointer to where third array of buffered data is stored
//! \param output_ptr4 Pointer to where fourth array of buffered data is stored
//! \param size Data buffer size
//! \param trigValue Trigger point for the datalogger
//! \param preScalar Variable to skip data logging points
//! \return None
//!
static inline void DLOG_4CH_config(DLOG_4CH *v,
                                  float32_t *inputPtr1,
                                  float32_t *inputPtr2,
                                  float32_t *inputPtr3,
                                  float32_t *inputPtr4,
                                  float32_t *outputPtr1,
                                  float32_t *outputPtr2,
                                  float32_t *outputPtr3,
                                  float32_t *outputPtr4,
                                  float32_t size,
                                  float32_t trigValue,
                                  float32_t preScalar
                                  )
{
    v->inputPtr1 = inputPtr1;
    v->inputPtr2 = inputPtr2;
    v->inputPtr3 = inputPtr3;
    v->inputPtr4 = inputPtr4;
    v->outputPtr1 = outputPtr1;
    v->outputPtr2 = outputPtr2;
    v->outputPtr3 = outputPtr3;
    v->outputPtr4 = outputPtr4;
    v->prevValue = (float32_t)(0);
    v->trigValue = (float32_t)(trigValue);
    v->status = 1;
    v->preScalar = preScalar;
    v->skipCount = 0;
    v->size = size;
    v->count = 0;
}

//! \brief Run the DLOG_4CH module
//! \param *v The DLOG_4CH structure pointer
//! \return None
//!
static inline void DLOG_4CH_run(DLOG_4CH *v)
{
	switch(v->status)
	{
        //
        // wait for trigger
        //
        case 1: 
            if(*v->inputPtr1>v->trigValue && v->prevValue<v->trigValue)
            {
                //
                // rising edge detected start logging data
                //
                v->status=2;
            }
            break;
        case 2:
            v->skipCount++;
            if(v->skipCount==v->preScalar)
            {
                v->skipCount=0;
                v->outputPtr1[v->count]=*v->inputPtr1;
                v->outputPtr2[v->count]=*v->inputPtr2;
                v->outputPtr3[v->count]=*v->inputPtr3;
                v->outputPtr4[v->count]=*v->inputPtr4;
                v->count++;
                if(v->count==v->size)
                {
                    v->count=0;
                    v->status=1;
                }
            }
            break;
	}
	v->prevValue=*v->inputPtr1;
}

//*****************************************************************************
//
// Close the Doxygen group.
//! @}
//
//*****************************************************************************

#ifdef __cplusplus
}
#endif // extern "C"

#endif // end of _DLOG_4CH_H_ definition

//
// End of File
//

