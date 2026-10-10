//#############################################################################
//
// FILE:  buck.h
//
// TITLE: Solution functions and resources
//        High level components that apply universally across hardware variants
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

#ifndef BTS_H
#define BTS_H

#ifdef __cplusplus

extern "C" {
#endif

//
//=============================================================================
// includes and defines
//=============================================================================
//
#include "bts_hal.h"
#include "DCL_fdlog.h"
#include "DCL_TCM.h"
#include "registers.h"
#include "bts_cla_shared.h"   // BTS_claCellVoltageFast, read by the CV loop

#if(BTS_DRV_EPWM_HR_ENABLED == true)
    #include "SFO_V8.h"
#endif

#if(BTS_DCL_CORE == BTS_DCL_FPU32)
    #include "DCLF32.h"
#endif


#if(BTS_SFRA_ENABLED == true)
    //
    // Only pull in SFRA includes if SFRA is enabled
    //
    #include <stddef.h>
    #include "sfra_f32.h"
    #include "sfra_gui_scicomms_driverlib.h"

    //
    // Use macros to call the SFRA functions
    // The input parameters are passed through to the underlying SFRA functions
    //
    #define BTS_SFRA_INJECT(x) SFRA_F32_inject(x)
    #define BTS_SFRA_COLLECT(x, y) SFRA_F32_collect(x, y)
    #define BTS_SFRA_GUI_RUN_COMMS(x) SFRA_GUI_runSerialHostComms(x)
    #define BTS_SFRA_RUN_BACKGROUND(x) SFRA_F32_runBackgroundTask(x)
#else
    //
    // The macros will eliminate the SFRA function calls when not enabled
    //   BTS_SFRA_INJECT(x) will be replaced inline with just the (x) value
    //   The other macros will be replaced inline with empty code blocks {}
    //
    #define BTS_SFRA_INJECT(x) (x)
    #define BTS_SFRA_COLLECT(x, y) {}
    #define BTS_SFRA_GUI_RUN_COMMS(x) {}
    #define BTS_SFRA_RUN_BACKGROUND(x) {}
#endif



//
//=============================================================================
// typdefs and externs
//=============================================================================
//


//
//=====================================
// Variables used by the program to run the BUCK solution.
//
// This subset of variables can be used interactively in the watch window
// to monitor and control the execution of the BTS solution.
//

//=====================================
//


extern ChannelStatus status[];

//
// Slot grouping tables, filled in by BTS_initSlotGrouping() from the MODE and
// ENABLE dip switches. Indexed by channel:
//
//   btsSlotLeader     channel that closes the loop for this slot's group
//   btsSlotIsLeader   1 if this slot is its own leader
//   btsSlotEnabled    1 if the ENABLE strap selected this slot
//   btsSlotUsesIntAdc 1 if the voltage loop reads the C2000's internal ADC
//   btsGroupMembers   how many ENABLED slots share this slot's group
//
// btsGroupMembers is what the leader's current setting is divided by. The
// members of a group are wired in PARALLEL, so they share the total current
// but all see the same voltage - a 6 A setting on a group of three is 2 A per
// slot, while the voltage limits pass through untouched. It counts only
// ENABLED slots, so a part-populated group still divides by what is really
// there rather than by the nominal group size.
//
extern uint16_t btsSlotLeader[];
extern uint16_t btsSlotIsLeader[];
extern uint16_t btsSlotEnabled[];
extern uint16_t btsSlotUsesIntAdc[];
extern uint16_t btsGroupMembers[];

void BTS_initSlotGrouping(uint16_t mode, uint16_t enable);



extern BTS_measValue BTS_measValues[];
#define BTS_measValues_ch1 BTS_measValues[0]
#define BTS_measValues_ch2 BTS_measValues[1]
#define BTS_measValues_ch3 BTS_measValues[2]
#define BTS_measValues_ch4 BTS_measValues[3]
#define BTS_measValues_ch5 BTS_measValues[4]
#define BTS_measValues_ch6 BTS_measValues[5]
#define BTS_measValues_ch7 BTS_measValues[6]
#define BTS_measValues_ch8 BTS_measValues[7]



extern BTS_userInput BTS_userInputs[];
#define BTS_userInput_ch1 BTS_userInputs[0]
#define BTS_userInput_ch2 BTS_userInputs[1]
#define BTS_userInput_ch3 BTS_userInputs[2]
#define BTS_userInput_ch4 BTS_userInputs[3]
#define BTS_userInput_ch5 BTS_userInputs[4]
#define BTS_userInput_ch6 BTS_userInputs[5]
#define BTS_userInput_ch7 BTS_userInputs[6]
#define BTS_userInput_ch8 BTS_userInputs[7]

extern BTS_ctrlLoopVariable BTS_ctrlLoopVariables[];
#define BTS_ctrlLoopVariable_ch1 BTS_ctrlLoopVariables[0]
#define BTS_ctrlLoopVariable_ch2 BTS_ctrlLoopVariables[1]
#define BTS_ctrlLoopVariable_ch3 BTS_ctrlLoopVariables[2]
#define BTS_ctrlLoopVariable_ch4 BTS_ctrlLoopVariables[3]
#define BTS_ctrlLoopVariable_ch5 BTS_ctrlLoopVariables[4]
#define BTS_ctrlLoopVariable_ch6 BTS_ctrlLoopVariables[5]
#define BTS_ctrlLoopVariable_ch7 BTS_ctrlLoopVariables[6]
#define BTS_ctrlLoopVariable_ch8 BTS_ctrlLoopVariables[7]

extern volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_cc[];
#define   BTS_ctrl_cc_ch1 BTS_ctrl_cc[0]
#define   BTS_ctrl_cc_ch2 BTS_ctrl_cc[1]
#define   BTS_ctrl_cc_ch3 BTS_ctrl_cc[2]
#define   BTS_ctrl_cc_ch4 BTS_ctrl_cc[3]
#define   BTS_ctrl_cc_ch5 BTS_ctrl_cc[4]
#define   BTS_ctrl_cc_ch6 BTS_ctrl_cc[5]
#define   BTS_ctrl_cc_ch7 BTS_ctrl_cc[6]
#define   BTS_ctrl_cc_ch8 BTS_ctrl_cc[7]

extern volatile BTS_DCL_CTRL_TYPE   BTS_ctrl_cv[];
#define   BTS_ctrl_cv_ch1 BTS_ctrl_cv[0]
#define   BTS_ctrl_cv_ch2 BTS_ctrl_cv[1]
#define   BTS_ctrl_cv_ch3 BTS_ctrl_cv[2]
#define   BTS_ctrl_cv_ch4 BTS_ctrl_cv[3]
#define   BTS_ctrl_cv_ch5 BTS_ctrl_cv[4]
#define   BTS_ctrl_cv_ch6 BTS_ctrl_cv[5]
#define   BTS_ctrl_cv_ch7 BTS_ctrl_cv[6]
#define   BTS_ctrl_cv_ch8 BTS_ctrl_cv[7]

#if(BTS_SFRA_ENABLED)
#if(BTS_SFRA_CH_SELECT == BTS_SFRA_CH1)
#define BTS_ctrlLoopVariable_chx BTS_ctrlLoopVariable_ch1
#define BTS_userInput_chx BTS_userInput_ch1
#define BTS_measValues_chx BTS_measValues_ch1
#define BTS_ctrl_cc_chx BTS_ctrl_cc_ch1
#define BTS_ctrl_cv_chx BTS_ctrl_cv_ch1

#define EPWMx_BASE EPWM1_BASE
#define BTS_ADC_current BTS_ADC1.channel0
#define BTS_ADC_voltage BTS_ADC1.channel1

#elif(BTS_SFRA_CH_SELECT == BTS_SFRA_CH2)
#define BTS_ctrlLoopVariable_chx BTS_ctrlLoopVariable_ch2
#define BTS_userInput_chx BTS_userInput_ch2
#define BTS_measValues_chx BTS_measValues_ch2
#define BTS_ctrl_cc_chx BTS_ctrl_cc_ch2
#define BTS_ctrl_cv_chx BTS_ctrl_cv_ch2

#define EPWMx_BASE EPWM2_BASE
#define BTS_ADC_current BTS_ADC1.channel2
#define BTS_ADC_voltage BTS_ADC1.channel3

#elif(BTS_SFRA_CH_SELECT == BTS_SFRA_CH3)
#define BTS_ctrlLoopVariable_chx BTS_ctrlLoopVariable_ch3
#define BTS_userInput_chx BTS_userInput_ch3
#define BTS_measValues_chx BTS_measValues_ch3
#define BTS_ctrl_cc_chx BTS_ctrl_cc_ch3
#define BTS_ctrl_cv_chx BTS_ctrl_cv_ch3

#define EPWMx_BASE EPWM3_BASE
#define BTS_ADC_current BTS_ADC1.channel4
#define BTS_ADC_voltage BTS_ADC1.channel5

#elif(BTS_SFRA_CH_SELECT == BTS_SFRA_CH4)
#define BTS_ctrlLoopVariable_chx BTS_ctrlLoopVariable_ch4
#define BTS_userInput_chx BTS_userInput_ch4
#define BTS_measValues_chx BTS_measValues_ch4
#define BTS_ctrl_cc_chx BTS_ctrl_cc_ch4
#define BTS_ctrl_cv_chx BTS_ctrl_cv_ch4

#define EPWMx_BASE EPWM4_BASE
#define BTS_ADC_current BTS_ADC1.channel6
#define BTS_ADC_voltage BTS_ADC1.channel7

#elif(BTS_SFRA_CH_SELECT == BTS_SFRA_CH5)
#define BTS_ctrlLoopVariable_chx BTS_ctrlLoopVariable_ch5
#define BTS_userInput_chx BTS_userInput_ch5
#define BTS_measValues_chx BTS_measValues_ch5
#define BTS_ctrl_cc_chx BTS_ctrl_cc_ch5
#define BTS_ctrl_cv_chx BTS_ctrl_cv_ch5

#define EPWMx_BASE EPWM5_BASE
#define BTS_ADC_current BTS_ADC2.channel0
#define BTS_ADC_voltage BTS_ADC2.channel1

#elif(BTS_SFRA_CH_SELECT == BTS_SFRA_CH6)
#define BTS_ctrlLoopVariable_chx BTS_ctrlLoopVariable_ch6
#define BTS_userInput_chx BTS_userInput_ch6
#define BTS_measValues_chx BTS_measValues_ch6
#define BTS_ctrl_cc_chx BTS_ctrl_cc_ch6
#define BTS_ctrl_cv_chx BTS_ctrl_cv_ch6

#define EPWMx_BASE EPWM6_BASE
#define BTS_ADC_current BTS_ADC2.channel2
#define BTS_ADC_voltage BTS_ADC2.channel3

#elif(BTS_SFRA_CH_SELECT == BTS_SFRA_CH7)
#define BTS_ctrlLoopVariable_chx BTS_ctrlLoopVariable_ch7
#define BTS_userInput_chx BTS_userInput_ch7
#define BTS_measValues_chx BTS_measValues_ch7
#define BTS_ctrl_cc_chx BTS_ctrl_cc_ch7
#define BTS_ctrl_cv_chx BTS_ctrl_cv_ch7

#define EPWMx_BASE EPWM7_BASE
#define BTS_ADC_current BTS_ADC2.channel4
#define BTS_ADC_voltage BTS_ADC2.channel5

#elif(BTS_SFRA_CH_SELECT == BTS_SFRA_CH8)
#define BTS_ctrlLoopVariable_chx BTS_ctrlLoopVariable_ch8
#define BTS_userInput_chx BTS_userInput_ch8
#define BTS_measValues_chx BTS_measValues_ch8
#define BTS_ctrl_cc_chx BTS_ctrl_cc_ch8
#define BTS_ctrl_cv_chx BTS_ctrl_cv_ch8

#define EPWMx_BASE EPWM8_BASE
#define BTS_ADC_current BTS_ADC2.channel6
#define BTS_ADC_voltage BTS_ADC2.channel7

#endif

#endif



//
//=====================================
// Variables used by the program to run the BTS solution.
//

//=====================================
//



extern uint32_t   MEP_ScaleFactor;
extern uint16_t   BUCK_sfoStatus;
extern uint16_t   BTS_sfoStatus;


//
//=====================================
// SFRA variables
//
#if(BTS_SFRA_ENABLED == true)
    extern SFRA_F32 BTS_sfra;

    //
    //=====================================
    // BTS_SfraDataType - SFRA sweep data
    //
    typedef struct {
        float32_t  plantMagVect[BTS_SFRA_FREQ_LENGTH];
        float32_t  plantPhaseVect[BTS_SFRA_FREQ_LENGTH];
        float32_t  olMagVect[BTS_SFRA_FREQ_LENGTH];
        float32_t  olPhaseVect[BTS_SFRA_FREQ_LENGTH];
        float32_t  freqVect[BTS_SFRA_FREQ_LENGTH];
    } BTS_SfraDataType;
    extern BTS_SfraDataType BTS_sfraData;
#endif


//
//=============================================================================
// Function prototypes from solution source
//=============================================================================
//

void BTS_setupSfra(void);
void BTS_setupSfraGui(void);

//
// ==================== Slot tuning (SFRA) at runtime ====================
//
// 1 when the MODE straps selected a slot-tuning mode at boot, 0 otherwise.
//
// SFRA used to be purely compile-time: BTS_SFRA_ENABLED gated ~20 #if sites
// and a tuning build was a different binary. It still gates whether the SFRA
// library is COMPILED IN - that part cannot be runtime, because the library,
// its sweep arrays and the GUI comms are real flash and RAM that a
// production build has no reason to carry - but WHETHER IT RUNS is now
// decided by the strap, so one tuning binary serves every slot and every
// mode instead of needing a rebuild per sweep.
//
// Latched once in main() from startup_mode. Never changes while running: it
// selects SCIA's owning CPU, which is a boot-time CPUSEL write.
//
extern uint16_t btsSfraActive;

//
// The slot under test, 0-7, taken from the ENABLE straps. Meaningless unless
// btsSfraActive is set.
//
extern uint16_t btsSfraSlot;

void BTS_setupHrpwmMepScaleFactor(void);

void BTS_updateReference(BTS_userInput *, BTS_ctrlLoopVariable *);
void BTS_initUserVariables(void);
void BTS_initProgramVariables(void);
void BTS_initController(void);
void BTS_monitor_Iout_Vout(BTS_measValue* );

//
// Recalculates the derived program variables (trip thresholds and the
// measurement gains/offsets) for one channel from BTS_userInputs[channel].
//
void BTS_calcUserProgramVariables(uint16_t channel);

//
// Applies a pending calibration update for one channel. In-memory only -
// CPU1 never writes EEPROM; persistence is CPU2's responsibility and is
// triggered by the host writing eCalibrationMode.
//
void BTS_monitor_program_update(uint16_t channel);

//
// Copies the calibration registers published by CPU2 into BTS_userInputs[]
// and flags the channel for recalculation.
//
void BTS_loadCalibrationFromRegisters(uint16_t channel);

//
// Seeds the slot-tuning registers from the compile-time BTS_DCL_* constants.
//
// Called once before CPU2's F-RAM load can arrive, so the registers hold the
// shipped tuning rather than zero if the unit has never been tuned - a zeroed
// biquad would make the controller output constant 0 and no slot would
// regulate at all.
//
void BTS_seedSlotTuningRegisters(void);

//
// Applies the slot-tuning registers to every channel's CC and CV controller.
//
// One tuning for the whole unit: each slot is the same converter with the
// same passives. Called at boot after CPU2's F-RAM reload and again whenever
// the host writes one of the coefficients.
//
void BTS_applySlotTuning(void);

//
//=============================================================================
// static inline functions
//=============================================================================
//


#pragma FUNC_ALWAYS_INLINE(BTS_updateHrpwmMepScaleFactor)
static inline void BTS_updateHrpwmMepScaleFactor(void)
{
    #if(BTS_EPWM_HR_ENABLED == true)
        BTS_sfoStatus = SFO();
    #endif
}


static inline void BTS_tripEpwm(uint32_t EPWM_BASE, BTS_DCL_CTRL_TYPE* ctrl_cc, BTS_ctrlLoopVariable *ctrlLoopVariable, int16_t current_16b)
{

#if(BTS_OCP_TRIGGER)
    if(current_16b> (ctrlLoopVariable->ioutTrip_16b) ||current_16b<(ctrlLoopVariable->ioutTrip_n_16b)){

        ctrlLoopVariable->tripFlag=1;
    }

#endif

    if(ctrlLoopVariable->tripFlag ){
        //FORCE TRIP
        EPWM_forceTripZoneEvent(EPWM_BASE,EPWM_TZ_FORCE_EVENT_OST);
        EPWM_setTripZoneAction(EPWM_BASE,  EPWM_TZ_ACTION_EVENT_TZA,EPWM_TZ_ACTION_LOW);

        EPWM_setCounterCompareValue(EPWM_BASE,EPWM_COUNTER_COMPARE_A, 0U);
        EPWM_setCounterCompareValue(EPWM_BASE, EPWM_COUNTER_COMPARE_B, BTS_DRV_EPWM_TBPRD);

        HRPWM_setHiResCounterCompareValueOnly(EPWM_BASE,HRPWM_COUNTER_COMPARE_A,0U);
        HRPWM_setHiResCounterCompareValueOnly(EPWM_BASE,HRPWM_COUNTER_COMPARE_B,0U);

        ctrl_cc->x1=0.0;
        ctrl_cc->x2=0.0;

        //
        // Re-arm the seed for the next release.
        //
        // The two lines above run on EVERY pass while tripFlag is set, and
        // tripFlag is set the whole time a slot is idle (BTS_updateReference
        // ties it to enable_logic, bts.c:720-725). That is correct - a
        // controller must not accumulate state while its output is forced
        // low - but it also means a seed written from the task level is
        // erased long before the gate drive ever enables.
        //
        // So the seed is applied HERE, on the release edge, and this flag is
        // what remembers that it is still owed.
        //
        ctrlLoopVariable->seedPending = 1U;
    }

    else{
        //
        // TRIP RELEASE EDGE - the only moment the biquad may be seeded.
        //
        // A synchronous buck started from zero duty is safe in charge and
        // dangerous in discharge: with dutyH = dutyL = 0 the low side is
        // effectively across a node something else is holding up, and the
        // whole of Vout appears across the inductor driving current INTO the
        // slot. Measured 2026-10-02: a 3.492 V bench supply on slot 1 with a
        // 0.1 A limit latched the CMPSS -9.5 A one-shot the instant the slot
        // enabled, at 8 mA of real current.
        //
        // dutySetRef_pu carries the feed-forward duty Vout/Vin computed by
        // BTS_seedConverterDuty() at slot start. In THIS build it has no
        // other reader - the open-loop branch that consumes it (bts.h, the
        // BTS_ISR_MODE_OPEN_LOOP block) is compiled out - so it is free to
        // act as the seed channel without a new field in message RAM.
        //
        // WHY x1 AND x2, AND WHY EXACTLY THESE VALUES
        //
        //   DCL_runDF22_C4:  uk = ek*b0 + x1
        //                    x1 = ek*b1 + x2 - uk*a1
        //                    x2 = ek*b2      - uk*a2
        //
        // At the release edge no current is flowing yet, so ek is ~0 and uk
        // collapses to x1: setting x1 = D puts the FIRST PWM edge at the
        // feed-forward duty. For the second pass to hold it, x2 must satisfy
        // both x1 = x2 - D*a1 and x2 = -D*a2, which is consistent only when
        // 1 + a1 + a2 == 0 - a pole at z = 1.
        //
        // The shipped CC coefficients satisfy it exactly: a1 = -1.96058023,
        // a2 = +0.96058023, and 1 + a1 + a2 is 0.0 to the last bit. The
        // controller IS an integrator, so this pair is a true equilibrium -
        // the loop sits at duty D with zero error and takes no step on any
        // later pass.
        //
        // If a retune ever breaks that condition the seed still removes the
        // inrush, because x1 = D is what the first edge uses; the loop then
        // converges from a sane duty instead of from zero. It degrades, it
        // does not become unsafe.
        //
        if (ctrlLoopVariable->seedPending != 0U) {
            ctrl_cc->x1 = ctrlLoopVariable->dutySetRef_pu;
            ctrl_cc->x2 = -(ctrlLoopVariable->dutySetRef_pu * ctrl_cc->a2);
            ctrlLoopVariable->seedPending = 0U;
        }

        //
        // Clears the OST flag this function's own EPWM_forceTripZoneEvent()
        // raises, so a software trip releases once tripFlag drops.
        //
        // DELIBERATELY NOT EPWM_TZ_FLAG_DCAEVT1. That flag belongs to the
        // CMPSS over-current comparator, and this runs every control pass:
        // clearing it here would release a genuine hardware over-current
        // within a control period of it latching, which is exactly the
        // cycle-by-cycle protection the comparator exists to provide. A
        // DCAEVT1 trip is cleared only by epwmTripISR(), after it has stopped
        // the slot and recorded the cause.
        //
        EPWM_clearTripZoneFlag(EPWM_BASE, EPWM_TZ_FLAG_OST);
    }


}

//
// Store one ADS131M08 sample pair.
//
// The argument is int32_t: the ADS131M08 is a 24-bit converter, and taking
// it through an int16_t here would discard the low 8 bits of every reading
// and clip the range.
//
// SIGN EXTENSION. BTS_ADC1/2.channelN are int32_t but the SPI frame delivers
// the sample as a bare 16-bit word in WLENGTH=00 mode, so a negative reading
// arrives as 0x0000FFEA rather than 0xFFFFFFEA. This used to be corrected by
// accident - the old int16_t parameter truncated it, and the compiler
// sign-extended on the way back out. Widening the parameter removed that, so
// the extension has to be explicit or every near-zero reading reads as
// +65514 instead of -22, which is +2.0 pu instead of 0.
//
// BTS_ADS131_SIGN_EXTEND is keyed to the configured word length, so raising
// WLENGTH to 24-bit changes one macro rather than this function.
//
#pragma FUNC_ALWAYS_INLINE(BTS_storeValuesAds)
static inline void BTS_storeValuesAds(BTS_measValue* measValue, int32_t current_raw, int32_t voltage_raw)
{
    if (measValue->Index < BTS_senseAverageFactor) {
        measValue->Isense_24b[measValue->Index] = BTS_ADS131_SIGN_EXTEND(current_raw);
        measValue->Vsense_24b[measValue->Index] = BTS_ADS131_SIGN_EXTEND(voltage_raw);
        measValue->Index = measValue->Index + 1U;
    } else {
        measValue->Index = 0U;
    }
}

//
// Conditions one ADS131M08 sample pair for the control loops, on EVERY DRDY.
//
// This is the control path, and it is separate from the telemetry ring
// BTS_storeValuesAds() fills. The ring is only meaned at the C1() rate into
// Isense_A / Vsense_V for reporting; the loops never read it.
//
//   current  rolling mean of the last BTS_CC_AVG_N samples. Running sum,
//            so each sample is one add and one subtract, not N adds.
//   voltage  single-pole IIR, y += alpha * (x - y), corner
//            BTS_CV_FILT_FC_HZ. The outer (CV) loop sees a ~100 Hz input
//            against the inner (CC) loop's ~3.5 kHz.
//
// Returned in the signed 16-bit full-scale domain BTS_ctrlISR() takes, so
// the per-unit scaling downstream is unchanged.
//
// The first call LOADS both filters from the sample instead of converging
// from zero, so the loops never see a ramp from 0 A / 0 V after boot. A slot
// that is idle still runs this every sample, so a start begins on a settled
// value rather than on the first sample it happens to get.
//
#pragma FUNC_ALWAYS_INLINE(BTS_conditionCtrlInputs)
static inline void BTS_conditionCtrlInputs(BTS_measValue* m,
                                           int32_t current_raw,
                                           int32_t voltage_raw,
                                           int16_t *current_16b,
                                           int16_t *voltage_16b)
{
    int32_t i = BTS_ADS131_SIGN_EXTEND(current_raw);
    int32_t v = BTS_ADS131_SIGN_EXTEND(voltage_raw);
    uint16_t k;

    if (m->ctrlPrimed == 0U) {
        for (k = 0U; k < BTS_CC_AVG_N; k++) {
            m->ctrlI_ring[k] = i;
        }
        m->ctrlI_sum  = i * (int32_t)BTS_CC_AVG_N;
        m->ctrlI_idx  = 0U;
        m->ctrlV_filt = (float32_t)v;
        m->ctrlPrimed = 1U;
    } else {
        m->ctrlI_sum += i - m->ctrlI_ring[m->ctrlI_idx];
        m->ctrlI_ring[m->ctrlI_idx] = i;
        m->ctrlI_idx = (m->ctrlI_idx + 1U) & (BTS_CC_AVG_N - 1U);

        m->ctrlV_filt += BTS_CV_FILT_ALPHA * ((float32_t)v - m->ctrlV_filt);
    }

    //
    // An arithmetic shift of a signed sum rounds toward minus infinity, so a
    // mean of exactly -0.5 LSB reads -1 rather than 0. At 1 LSB in 32768
    // that is below anything the loop can act on.
    //
    *current_16b = (int16_t)(m->ctrlI_sum >> BTS_CC_AVG_SHIFT);
    *voltage_16b = (int16_t)m->ctrlV_filt;
}

//
// Store one on-chip ADC sample pair. 12-bit single-ended, so int16_t is
// exact - the width only needs widening on the ADS path above.
//
#pragma FUNC_ALWAYS_INLINE(BTS_storeValuesF28)
static inline void BTS_storeValuesF28(BTS_measValue* measValue, int16_t cell_voltage_16b, int16_t cell_current_16b)
{
    if (measValue->F28Index < BTS_f28AverageFactor) {
        measValue->CellVoltage_16b[measValue->F28Index] = cell_voltage_16b;
        measValue->CellCurrent_16b[measValue->F28Index] = cell_current_16b;
        measValue->F28Index = measValue->F28Index + 1U;
    } else {
        measValue->F28Index = 0U;
    }
}

//
// Presents the C2000's own cell-voltage reading in the domain the control
// loop actually compares against.
//
// BTS_ctrlISR() computes voutSense_pu as voltage_16b / 32768, and the CV
// error subtracts that from voutSet_pu - which BTS_updateReference() derives
// using VoutGain_pu / VoutOffset_pu, the *external* converter's per-unit
// calibration. The internal ADC therefore cannot simply be substituted: its
// own calibration pair (F28V_Gain / F28V_Offset) yields volts, not per-unit,
// so feeding its counts in raw would compare two different quantities.
//
// Both calibrations are composed here - counts to volts, then volts to the
// same per-unit scale the setpoint uses - and the result is re-expressed as
// the signed 16-bit quantity BTS_ctrlISR() expects.
//
// Note the internal ADC is 12-bit against a 2.5 V reference where the
// ADS131M08 is 16-bit, so in these modes the voltage loop quantises on the
// sensor rather than on the actuator.
//
#pragma FUNC_ALWAYS_INLINE(BTS_cellVoltageAsCtrl16b)
static inline int16_t BTS_cellVoltageAsCtrl16b(const BTS_measValue* measValue,
                                               const BTS_userInput* userInput)
{
    float32_t volts;
    float32_t pu;
    uint16_t  ch = (uint16_t)(measValue - &BTS_measValues[0]);

    //
    // Reads CLA1's FAST filter, not the ring.
    //
    // The ring is no longer filled: the internal ADC triggers 1:1 with EPWM1
    // at 99.67 kSPS and adcCellVoltageISR is masked in the PIE, because a
    // C28x interrupt every 10.03 us is not affordable on a core already
    // running the control loops. Reading the ring here would have returned
    // whatever it held when that ISR was last serviced - a fixed number the
    // CV loop would have regulated against forever.
    //
    // The fast filter settles in ~184 us against the ring's 1204 us, so the
    // CV loop sees LESS lag than it would have, not more - which matters
    // because this runs at the ADS131M08 DRDY rate, not at 10 Hz.
    //
    // Counts to volts, matching how BTS_monitor_Iout_Vout() scales the same
    // reading: 12-bit unsigned against the 2.5 V reference.
    //
    volts = ((BTS_claCellVoltageFast[ch] / (float32_t)4096.0)
             * (float32_t)2.5) * measValue->F28V_Gain + measValue->F28V_Offset;

    //
    // Volts to the setpoint's per-unit domain.
    //
    pu = volts * userInput->VoutGain_pu + userInput->VoutOffset_pu;

    pu = pu * (float32_t)32768.0;

    if (pu > (float32_t)32767.0) {
        pu = (float32_t)32767.0;
    } else if (pu < (float32_t)-32768.0) {
        pu = (float32_t)-32768.0;
    }

    return (int16_t)pu;
}


static inline void BTS_ctrlDirection(uint32_t EPWM_BASE, BTS_ctrlLoopVariable *ctrlLoopVariable,int16_t current_16b){

    //In charge mode, check if current goes below negative trip value, then shutdown low side mosfet
    //In discharge mode,  check if current goes above positive trip, then shutdown high side mosfet

    if(ctrlLoopVariable->direction_logic){
        //charge mode

        if(current_16b < ((int16_t)ctrlLoopVariable->ioutTrip_n_16b)){
            EPWM_setActionQualifierContSWForceAction(EPWM_BASE,EPWM_AQ_OUTPUT_B,EPWM_AQ_SW_OUTPUT_HIGH);
            ctrlLoopVariable->dutyH_pu = ctrlLoopVariable->dutySet_pu;
            ctrlLoopVariable->dutyL_pu = 1.0;
        }
        else{
            EPWM_setActionQualifierContSWForceAction(EPWM_BASE,EPWM_AQ_OUTPUT_B,EPWM_AQ_SW_DISABLED);
            ctrlLoopVariable->dutyH_pu = ctrlLoopVariable->dutySet_pu;
            ctrlLoopVariable->dutyL_pu = ctrlLoopVariable->dutySet_pu;
        }
    }
    else{
        //discharge mode

        if(current_16b >((int16_t)ctrlLoopVariable->ioutTrip_16b)){
            EPWM_setActionQualifierContSWForceAction(EPWM_BASE,EPWM_AQ_OUTPUT_A,EPWM_AQ_SW_OUTPUT_LOW);
            ctrlLoopVariable->dutyH_pu = 0;
            ctrlLoopVariable->dutyL_pu = ctrlLoopVariable->dutySet_pu;
        }
        else{
            EPWM_setActionQualifierContSWForceAction(EPWM_BASE,EPWM_AQ_OUTPUT_A,EPWM_AQ_SW_DISABLED);
            ctrlLoopVariable->dutyH_pu = ctrlLoopVariable->dutySet_pu;
            ctrlLoopVariable->dutyL_pu = ctrlLoopVariable->dutySet_pu;
        }

    }

    //
    // The two unconditional assignments that used to sit here have been
    // removed. They overwrote dutyH_pu and dutyL_pu with dutySet_pu on every
    // pass, discarding all four branches above - so the asymmetric duty this
    // function computes to protect against reverse current never reached the
    // PWM. The action-qualifier forcing still took effect, which is why the
    // protection appeared to work; only the duty shaping was lost.
    //
    // Present since d184a22. Soft start needs exactly this asymmetric path,
    // which is why it is fixed here rather than worked around.
    //
}

#pragma FUNC_ALWAYS_INLINE(BTS_ctrlISR)
static inline void BTS_ctrlISR(BTS_DCL_CTRL_TYPE* ctrl_cc, BTS_DCL_CTRL_TYPE* ctrl_cv, uint32_t EPWM_BASE, BTS_ctrlLoopVariable *ctrlLoopVariable, int16_t current_16b, int16_t voltage_16b, int16_t currentRaw_16b){

    //
    // TWO current readings, for two different jobs.
    //
    //   currentRaw_16b  this DRDY's sample, unfiltered. The software
    //                   over-current trip and the reverse-current guard in
    //                   BTS_ctrlDirection() use it - a protection test must
    //                   not wait for an average to catch up.
    //   current_16b     the BTS_CC_AVG_N rolling mean. The CC loop's error
    //                   is formed on this.
    //
    // voltage_16b is already the ~100 Hz CV input; nothing here needs the
    // raw voltage. See BTS_conditionCtrlInputs().
    //
#if(BTS_TRIP_CODE)
    BTS_tripEpwm(EPWM_BASE, ctrl_cc, ctrlLoopVariable, currentRaw_16b);

#endif


    ctrlLoopVariable->ioutSense_pu= (float32_t)((int16_t)current_16b)/32768.0f;
    ctrlLoopVariable->voutSense_pu= (float32_t)((int16_t)voltage_16b)/32768.0f;


#if(BTS_ISR_MODE == BTS_ISR_MODE_CLOSED_LOOP)


#if((BTS_ISR_CL_MODE == BTS_ISR_CL_MODE_CCCV)|| (BTS_ISR_CL_MODE == BTS_ISR_CL_MODE_CV))

    //
    // The CV setpoint. In a tuning build SFRA perturbs this instead, but only
    // while a sweep is actually active - so the test is on the runtime flag,
    // not on the compile-time macro alone. A tuning binary strapped to a
    // normal mode runs exactly like a production one.
    //
    if (!BTS_SFRA_IS_ACTIVE()) {
        ctrlLoopVariable->voutSet_pu= ctrlLoopVariable->voutRef_pu;
    }
    ctrlLoopVariable->ek_cv_pu = ctrlLoopVariable->direction_coeff *(ctrlLoopVariable->voutSet_pu - ctrlLoopVariable->voutSense_pu);
    ctrlLoopVariable->uk_cv_pu = BTS_DCL_RUN_IMMEDIATE(ctrl_cv, ctrlLoopVariable->ek_cv_pu);

    //only update when current is in limit
    if (BTS_DCL_RUN_CLAMP(&(ctrlLoopVariable->uk_cv_pu),ctrlLoopVariable->ioutRef_pu, -1.0*ctrlLoopVariable->ioutRef_pu) ==0){
        //record current command
        ctrlLoopVariable->ioutSet_pu = ctrlLoopVariable->uk_cv_pu;

         BTS_DCL_RUN_PARTIAL(ctrl_cv,
                              ctrlLoopVariable->ek_cv_pu,
                              ctrlLoopVariable->uk_cv_pu);
     }
     else{
         if(ctrlLoopVariable->uk_cv_pu <= BTS_ISET_MIN_PU)
             {
             ctrlLoopVariable->ioutSet_pu = BTS_ISET_MIN_PU;
             }
             if(ctrlLoopVariable->uk_cv_pu >= BTS_ISET_MAX_PU)
             {
                 ctrlLoopVariable->ioutSet_pu = BTS_ISET_MAX_PU;
             }
     }

#endif

#if(BTS_ISR_CL_MODE == BTS_ISR_CL_MODE_CCCV)
    if(ctrlLoopVariable->ek_cv_pu<-0.001){
        ctrlLoopVariable->ioutSet_pu = ctrlLoopVariable->direction_coeff*ctrlLoopVariable->uk_cv_pu;
        ctrlLoopVariable->ctrlMode_logic=1;
    }
    else if(ctrlLoopVariable->ek_cv_pu>0.1)
    {
        ctrlLoopVariable->ioutSet_pu = ctrlLoopVariable->direction_coeff* ctrlLoopVariable->ioutRef_pu;
//        ctrlLoopVariable->ioutSet_pu=  BUCK_SFRA_INJECT(ctrlLoopVariable->ioutRef_pu);
        ctrlLoopVariable->ctrlMode_logic=0;
    }
//    ctrlLoopVariable->ioutSet_pu=  BUCK_SFRA_INJECT(ctrlLoopVariable->ioutRef_pu);

#elif(BTS_ISR_CL_MODE == BTS_ISR_CL_MODE_CV)
    ctrlLoopVariable->ioutSet_pu = ctrlLoopVariable->direction_coeff*ctrlLoopVariable->uk_cv_pu;
    ctrlLoopVariable->ctrlMode_logic=1;

#elif(BTS_ISR_CL_MODE == BTS_ISR_CL_MODE_CC)
    if (!BTS_SFRA_IS_ACTIVE()) {
        ctrlLoopVariable->ioutSet_pu = ctrlLoopVariable->direction_coeff* ctrlLoopVariable->ioutRef_pu;
    }
    ctrlLoopVariable->ctrlMode_logic=0;

#endif


#if((BTS_ISR_CL_MODE == BTS_ISR_CL_MODE_CCCV)||(BTS_ISR_CL_MODE == BTS_ISR_CL_MODE_CV)||(BTS_ISR_CL_MODE == BTS_ISR_CL_MODE_CC))

    ctrlLoopVariable->ek_cc_pu = (ctrlLoopVariable->ioutSet_pu - ctrlLoopVariable->ioutSense_pu);
    //         Calculate the required control effort (duty cycle)
    ctrlLoopVariable->uk_cc_pu = BTS_DCL_RUN_IMMEDIATE(ctrl_cc, ctrlLoopVariable->ek_cc_pu);

        if(BTS_DCL_RUN_CLAMP(&(ctrlLoopVariable->uk_cc_pu),BTS_DUTY_SET_MAX_PU, BTS_DUTY_SET_MIN_PU) == 0){
            //         Only update the duty cycle if the control effort is within range
            ctrlLoopVariable->dutySet_pu = ctrlLoopVariable->uk_cc_pu;
            BTS_ctrlDirection(EPWM_BASE, ctrlLoopVariable, currentRaw_16b);

            BTS_HAL_updateDuty(EPWM_BASE, ctrlLoopVariable->dutyH_pu,ctrlLoopVariable->dutyL_pu);
            BTS_DCL_RUN_PARTIAL(ctrl_cc,
                                 ctrlLoopVariable->ek_cc_pu,
                                 ctrlLoopVariable->uk_cc_pu);
        }
        else{
            if(ctrlLoopVariable->uk_cc_pu <= BTS_DUTY_SET_MIN_PU)
            {
                ctrlLoopVariable->dutySet_pu = BTS_DUTY_SET_MIN_PU;
                BTS_HAL_updateDuty(EPWM_BASE,BTS_DUTY_SET_MIN_PU,BTS_DUTY_SET_MIN_PU);
                ctrlLoopVariable->dutySet_pu = BTS_DUTY_SET_MIN_PU;
            }
            if(ctrlLoopVariable->uk_cc_pu >= BTS_DUTY_SET_MAX_PU)
            {
                ctrlLoopVariable->dutySet_pu = BTS_DUTY_SET_MAX_PU;
                BTS_HAL_updateDuty(EPWM_BASE,BTS_DUTY_SET_MAX_PU,BTS_DUTY_SET_MAX_PU);
                ctrlLoopVariable->dutySet_pu = BTS_DUTY_SET_MAX_PU;
            }

        }
#endif

#endif

/*
 * OPEN LOOP BUCK
 * DUTY CONTROL
 */

#if(BTS_ISR_MODE == BTS_ISR_MODE_OPEN_LOOP)

    if (!BTS_SFRA_IS_ACTIVE()) {
        ctrlLoopVariable->dutySet_pu = ctrlLoopVariable->dutySetRef_pu;
    }
    if(ctrlLoopVariable->dutySet_pu <= BTS_DUTY_SET_MIN_PU)
    {
        BTS_HAL_updateDuty(EPWM_BASE,BTS_DUTY_SET_MIN_PU,BTS_DUTY_SET_MIN_PU);
        ctrlLoopVariable->dutySet_pu = BTS_DUTY_SET_MIN_PU;
    }
    if(ctrlLoopVariable->dutySet_pu >= BTS_DUTY_SET_MAX_PU)
    {
        BTS_HAL_updateDuty(EPWM_BASE,BTS_DUTY_SET_MAX_PU,BTS_DUTY_SET_MAX_PU);
        ctrlLoopVariable->dutySet_pu = BTS_DUTY_SET_MAX_PU;
    }

    BTS_ctrlDirection(EPWM_BASE, ctrlLoopVariable,currentRaw_16b);

    BTS_HAL_updateDuty(EPWM_BASE, ctrlLoopVariable->dutyH_pu,ctrlLoopVariable->dutyL_pu);

#if(BTS_SFRA_ENABLED)
    //BTS_SFRA_COLLECT(&(ctrlLoopVariable->dutySet_pu),
    //                  &(ctrlLoopVariable->ioutSense_pu));

#endif

#endif


}



//
// Runs one slot's share of the control ISR.
//
// A disabled slot is held down. A group leader closes its loop as usual. A
// follower does not run a controller at all - it mirrors whatever duty its
// leader just computed, which is what makes the group act as one converter.
// The interleave between them comes from the ePWM phase configured at init,
// not from anything done here.
//
//
// 1 while a slot is actively driving its rail toward the ADS reading.
//
// Set by the supervisor in B1, read by the control ISR. A plain uint16_t per
// slot: the ISR only tests it, and a torn read is not reachable on a 16-bit
// aligned word on this core.
//
extern uint16_t btsSlotPreCharging[];

//
// One balancing step. Called from the control ISR in place of the loop.
//
// Moves the rail toward the target by a bounded step per sample, so the
// approach is gradual regardless of how far away it starts. The step is tiny
// because this runs at the ADS131M08 sample rate - thousands of passes per
// second - so even a small increment converges quickly.
//
#pragma FUNC_ALWAYS_INLINE(BTS_balanceSlot)
static inline void BTS_balanceSlot(uint16_t ch, uint32_t EPWM_BASE,
                                   BTS_ctrlLoopVariable *ctrlLoopVariable)
{
    float32_t target = BTS_measValues[ch].Vsense_V;
    float32_t actual = BTS_measValues[ch].CellVoltage_V;
    float32_t duty   = ctrlLoopVariable->dutySet_pu;

    //
    // A trip stands the stage down immediately, the same as anywhere else.
    //
    if (ctrlLoopVariable->tripFlag != 0U) {
        BTS_HAL_updateDuty(EPWM_BASE, (float32_t)0.0, (float32_t)0.0);
        ctrlLoopVariable->dutySet_pu = (float32_t)0.0;
        return;
    }

    if (actual < target) {
        duty += BTS_BALANCE_DUTY_STEP_PU;
    } else if (actual > target) {
        duty -= BTS_BALANCE_DUTY_STEP_PU;
    }

    //
    // Clamped well below the running maximum. Balancing charges capacitance,
    // which needs very little duty, and a low ceiling bounds the current a
    // fault in the differential could ask for.
    //
    if (duty > BTS_BALANCE_DUTY_MAX_PU) {
        duty = BTS_BALANCE_DUTY_MAX_PU;
    } else if (duty < BTS_DUTY_SET_MIN_PU) {
        duty = BTS_DUTY_SET_MIN_PU;
    }

    ctrlLoopVariable->dutySet_pu = duty;
    ctrlLoopVariable->dutyH_pu   = duty;
    ctrlLoopVariable->dutyL_pu   = duty;

    BTS_HAL_updateDuty(EPWM_BASE, duty, duty);
}

//
// Takes the RAW DRDY sample pair. Conditioning happens here, once per slot
// per sample, so leaders, followers and disabled slots all keep their filters
// primed and current - a slot that starts, or a follower that is promoted by
// a re-strap, begins from a settled value. See BTS_conditionCtrlInputs().
//
#pragma FUNC_ALWAYS_INLINE(BTS_runSlot)
static inline void BTS_runSlot(uint16_t ch, BTS_DCL_CTRL_TYPE* ctrl_cc,
                               BTS_DCL_CTRL_TYPE* ctrl_cv, uint32_t EPWM_BASE,
                               BTS_ctrlLoopVariable *ctrlLoopVariable,
                               int32_t current_raw, int32_t voltage_raw)
{
    int16_t currentRaw_16b = (int16_t)BTS_ADS131_SIGN_EXTEND(current_raw);
    int16_t current_16b;
    int16_t voltage_16b;

    BTS_conditionCtrlInputs(&BTS_measValues[ch], current_raw, voltage_raw,
                            &current_16b, &voltage_16b);

    if (btsSlotEnabled[ch] == 0U) {
        BTS_HAL_updateDuty(EPWM_BASE, (float32_t)0.0, (float32_t)0.0);
        return;
    }

    if (btsSlotIsLeader[ch] != 0U) {
        //
        // BALANCING: drive the output capacitors toward the ADS reading with
        // no cell on the rail yet.
        //
        // This is not the control loop. The loop regulates current into a
        // cell; here there is no cell, only capacitance, and the target is a
        // voltage. A slew-limited duty nudge is both sufficient and far
        // safer than letting a current loop wind up against an open circuit.
        //
        // The synchronous rectifier stays commanded, because the rail must be
        // able to move DOWN as well as up - a cell at 3.0 V meeting a rail at
        // 3.6 V needs the low side to pull it down. That is safe here
        // precisely because no cell is connected: there is nothing to drive
        // current backwards out of.
        //
        if (btsSlotPreCharging[ch] != 0U) {
            BTS_balanceSlot(ch, EPWM_BASE, ctrlLoopVariable);
            return;
        }

        //
        // MODE 4/5 close the voltage loop on the internal ADC instead. That
        // reading comes from the CLA's FAST filter (~4 kHz corner at
        // 99.67 kSPS), not from the ~100 Hz CV filter the ADS131M08 path
        // gets in BTS_conditionCtrlInputs(). Left as it is: those modes are
        // a comparison path and have not run on hardware.
        //
        if (btsSlotUsesIntAdc[ch] != 0U) {
            voltage_16b = BTS_cellVoltageAsCtrl16b(&BTS_measValues[ch],
                                                   &BTS_userInputs[ch]);
        }
        BTS_ctrlISR(ctrl_cc, ctrl_cv, EPWM_BASE, ctrlLoopVariable,
                    current_16b, voltage_16b, currentRaw_16b);
    } else {
        const BTS_ctrlLoopVariable *leader =
            &BTS_ctrlLoopVariables[btsSlotLeader[ch]];

        //
        // Follow the leader's duty, but keep this slot's own trip logic live
        // so its over-current protection still bites independently.
        //
#if(BTS_TRIP_CODE)
        BTS_tripEpwm(EPWM_BASE, ctrl_cc, ctrlLoopVariable, currentRaw_16b);
#endif
        ctrlLoopVariable->ioutSense_pu = (float32_t)current_16b / (float32_t)32768.0;
        ctrlLoopVariable->voutSense_pu = (float32_t)voltage_16b / (float32_t)32768.0;
        ctrlLoopVariable->dutySet_pu   = leader->dutySet_pu;
        ctrlLoopVariable->dutyH_pu     = leader->dutyH_pu;
        ctrlLoopVariable->dutyL_pu     = leader->dutyL_pu;

        if (ctrlLoopVariable->tripFlag == 0U) {
            BTS_HAL_updateDuty(EPWM_BASE, leader->dutyH_pu, leader->dutyL_pu);
        }
    }
}
#pragma FUNC_ALWAYS_INLINE(BTS_ISR_SFRA)
static inline void BTS_ISR_SFRA(void){

#if(BTS_SFRA_ENABLED == (true))
    //
    // SFRA INJECT - PLANT or CLOSED, chosen by the MODE strap at boot.
    //
    // The two sweeps differ only in where the perturbation enters:
    //
    //   PLANT  (mode 6) injects at the DUTY CYCLE, so the loop is open and
    //          the sweep measures the converter itself - duty in, current
    //          out. This is what a new set of DCL coefficients is derived
    //          FROM.
    //
    //   CLOSED (mode 7) injects at the CURRENT SETPOINT, so the loop is
    //          closed and the sweep measures the tuned system - Iset in,
    //          current out. This is what CONFIRMS a set of coefficients
    //          once they are installed.
    //
    // Both collect the same signal (ioutSense_pu), so only the injection
    // point moves. The selection is a runtime branch rather than the #if it
    // used to be, because the mode arrives on a strap and a single tuning
    // binary has to serve both sweeps - otherwise a system builder would
    // reflash between measuring the plant and checking the result.
    //
    if (BTS_MODE_SFRA_IS_CLOSED((uint16_t)startup_mode)) {
        BTS_ctrlLoopVariable_chx.ioutSet_pu =
            BTS_SFRA_INJECT(BTS_ctrlLoopVariable_chx.ioutRef_pu);
    } else {
        BTS_ctrlLoopVariable_chx.dutySet_pu =
            BTS_SFRA_INJECT(BTS_ctrlLoopVariable_chx.dutySetRef_pu);
    }

    BTS_storeValuesAds(&BTS_measValues_chx,BTS_ADC_current, BTS_ADC_voltage);

#if(BTS_ENABLE_SWITCH)
    BTS_detectEnable(EPWMx_BASE,&BTS_ctrlLoopVariable_chx , &BTS_userInput_chx);
#endif

    //
    // The sweep measures the loop as it actually runs, so it gets the same
    // conditioned inputs the production path does.
    //
    {
        int16_t sfraI_16b;
        int16_t sfraV_16b;

        BTS_conditionCtrlInputs(&BTS_measValues_chx, BTS_ADC_current,
                                BTS_ADC_voltage, &sfraI_16b, &sfraV_16b);
        BTS_ctrlISR(&BTS_ctrl_cc_chx, &BTS_ctrl_cv_chx, EPWMx_BASE,
                    &BTS_ctrlLoopVariable_chx, sfraI_16b, sfraV_16b,
                    (int16_t)BTS_ADS131_SIGN_EXTEND(BTS_ADC_current));
    }

    //
    // SFRA COLLECT - the reference is whichever signal was injected, and the
    // response is always the sensed current.
    //
    if (BTS_MODE_SFRA_IS_CLOSED((uint16_t)startup_mode)) {
        BTS_SFRA_COLLECT(&(BTS_ctrlLoopVariable_chx.ioutSet_pu),
                         &(BTS_ctrlLoopVariable_chx.ioutSense_pu));
    } else {
        BTS_SFRA_COLLECT(&(BTS_ctrlLoopVariable_chx.dutySet_pu),
                         &(BTS_ctrlLoopVariable_chx.ioutSense_pu));
    }

#endif
}

#pragma FUNC_ALWAYS_INLINE(BTS_runISR_ch1_4)
static inline void BTS_runISR_ch1_4(void){

    if (BTS_ExAdcRxflag1 == 1) {
        BTS_ExAdcSendTxFrame_ch1_4();
#if (BTS_SFRA_ENABLED == true) && ( BTS_SFRA_ISR_SRC == BTS_SFRA_ISR_SRC_ADC) && ( BTS_SFRA_CHANNEL <= 4)
        BTS_ISR_SFRA();
#endif
    }

#if(BTS_SFRA_ENABLED ==(false))

#if(BTS_ENABLE_CH1)
    BTS_storeValuesAds(&BTS_measValues_ch1,BTS_ADC1.channel0, BTS_ADC1.channel1);
#if(BTS_ENABLE_DETECT_CODE)
    BTS_detectEnable(EPWM1_BASE,&BTS_ctrlLoopVariable_ch1 , &BTS_userInput_ch1);
#endif
    BTS_runSlot(0, &BTS_ctrl_cc_ch1, &BTS_ctrl_cv_ch1, EPWM1_BASE, &BTS_ctrlLoopVariable_ch1, BTS_ADC1.channel0, BTS_ADC1.channel1);
#endif

#if(BTS_ENABLE_CH2)
    BTS_storeValuesAds(&BTS_measValues_ch2,BTS_ADC1.channel2, BTS_ADC1.channel3);
#if(BTS_ENABLE_DETECT_CODE)
    BTS_detectEnable(EPWM2_BASE,&BTS_ctrlLoopVariable_ch2 , &BTS_userInput_ch2);
#endif
    BTS_runSlot(1, &BTS_ctrl_cc_ch2, &BTS_ctrl_cv_ch2, EPWM2_BASE, &BTS_ctrlLoopVariable_ch2, BTS_ADC1.channel2, BTS_ADC1.channel3);
#endif

#if(BTS_ENABLE_CH3)
    BTS_storeValuesAds(&BTS_measValues_ch3,BTS_ADC1.channel4, BTS_ADC1.channel5);
#if(BTS_ENABLE_DETECT_CODE)
    BTS_detectEnable(EPWM3_BASE,&BTS_ctrlLoopVariable_ch3 , &BTS_userInput_ch3);
#endif
    BTS_runSlot(2, &BTS_ctrl_cc_ch3, &BTS_ctrl_cv_ch3, EPWM3_BASE, &BTS_ctrlLoopVariable_ch3, BTS_ADC1.channel4, BTS_ADC1.channel5);
#endif

#if(BTS_ENABLE_CH4)
    BTS_storeValuesAds(&BTS_measValues_ch4,BTS_ADC1.channel6, BTS_ADC1.channel7);
#if(BTS_ENABLE_DETECT_CODE)
    BTS_detectEnable(EPWM4_BASE,&BTS_ctrlLoopVariable_ch4 , &BTS_userInput_ch4);
#endif
    BTS_runSlot(3, &BTS_ctrl_cc_ch4, &BTS_ctrl_cv_ch4, EPWM4_BASE, &BTS_ctrlLoopVariable_ch4, BTS_ADC1.channel6, BTS_ADC1.channel7);
#endif

#endif

    //
    // GROUP12, not GROUP1: this runs from ISR1 on the SPI ADC1 DRDY edge,
    // which is XINT3 (PIE 12.1) since CPU1 moved off XINT1/XINT2 - those
    // belong to CPU2's ADS1119 lines in the shared Input X-BAR. Acking the
    // wrong group leaves group 12 blocked, so DRDY fires exactly once and
    // the whole external-ADC ring then freezes.
    //
    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP12);

}

#pragma FUNC_ALWAYS_INLINE(BTS_runISR_ch5_8)
static inline void BTS_runISR_ch5_8(void){

    BTS_ExAdcSendTxFrame_ch5_8();

#if (BTS_SFRA_ENABLED == true) && ( BTS_SFRA_ISR_SRC == BTS_SFRA_ISR_SRC_ADC) && ( BTS_SFRA_CHANNEL >= 5)
        BTS_ISR_SFRA();
#endif

#if(BTS_SFRA_ENABLED ==(false))

#if(BTS_ENABLE_CH5)
    BTS_storeValuesAds(&BTS_measValues_ch5,BTS_ADC2.channel0, BTS_ADC2.channel1);
#if(BTS_ENABLE_DETECT_CODE)
    BTS_detectEnable(EPWM5_BASE,&BTS_ctrlLoopVariable_ch5 , &BTS_userInput_ch5);
#endif
    BTS_runSlot(4, &BTS_ctrl_cc_ch5, &BTS_ctrl_cv_ch5, EPWM5_BASE, &BTS_ctrlLoopVariable_ch5, BTS_ADC2.channel0, BTS_ADC2.channel1);
#endif

#if(BTS_ENABLE_CH6)
    BTS_storeValuesAds(&BTS_measValues_ch6,BTS_ADC2.channel2, BTS_ADC2.channel3);
#if(BTS_ENABLE_DETECT_CODE)
    BTS_detectEnable(EPWM6_BASE,&BTS_ctrlLoopVariable_ch6 , &BTS_userInput_ch6);
#endif
    BTS_runSlot(5, &BTS_ctrl_cc_ch6, &BTS_ctrl_cv_ch6, EPWM6_BASE, &BTS_ctrlLoopVariable_ch6, BTS_ADC2.channel2, BTS_ADC2.channel3);
#endif

#if(BTS_ENABLE_CH7)
    BTS_storeValuesAds(&BTS_measValues_ch7,BTS_ADC2.channel4, BTS_ADC2.channel5);
#if(BTS_ENABLE_DETECT_CODE)
    BTS_detectEnable(EPWM7_BASE,&BTS_ctrlLoopVariable_ch7 , &BTS_userInput_ch7);
#endif
    BTS_runSlot(6, &BTS_ctrl_cc_ch7, &BTS_ctrl_cv_ch7, EPWM7_BASE, &BTS_ctrlLoopVariable_ch7, BTS_ADC2.channel4, BTS_ADC2.channel5);
#endif

#if(BTS_ENABLE_CH8)
    BTS_storeValuesAds(&BTS_measValues_ch8,BTS_ADC2.channel6, BTS_ADC2.channel7);
#if(BTS_ENABLE_DETECT_CODE)
    BTS_detectEnable(EPWM8_BASE,&BTS_ctrlLoopVariable_ch8 , &BTS_userInput_ch8);
#endif
    BTS_runSlot(7, &BTS_ctrl_cc_ch8, &BTS_ctrl_cv_ch8, EPWM8_BASE, &BTS_ctrlLoopVariable_ch8, BTS_ADC2.channel6, BTS_ADC2.channel7);
#endif

#endif

    // GROUP12: ISR3 runs on SPI ADC2 DRDY = XINT5 (PIE 12.3). See the note
    // on the ch1-4 handler above.
    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP12);

}


#ifdef __cplusplus
}
#endif                                  /* extern "C" */

#endif
