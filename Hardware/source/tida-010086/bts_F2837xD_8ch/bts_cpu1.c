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
#include <math.h>

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
static void checkGroupIntegrity(void);
static void publishStatusToCpu2(void);
void updateStatusRegisters(void);
void modeCallback(float value, uint16_t channel);
void BTS_HandleRegisterWrite(void);

//
// Runtime slot calibration (design doc sections 5-7). CPU1 owns the state
// machine and the captures; CPU2 owns registers[] and the F-RAM write.
//
static void calHandleCommand(uint16_t opcode, float32_t argument);
static void calServiceDeadMan(void);
static void calPublishTelemetry(void);
static uint16_t calSlotIsCalibrating(uint16_t ch);

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
// Bound on the ADCB end-of-conversion poll in updateInputVoltage(). The
// conversion itself is sub-microsecond; this only has to be large enough
// not to false-trip, and finite so a dead flag cannot wedge the task loop.
//
#define BTS_ADCB_EOC_MAX_POLLS ((uint16_t)2000)

//
// Diagnostic counter: non-zero means the input-voltage read timed out and
// the guard is running on a substituted 0 V rather than a live measurement.
//
volatile uint32_t adcbEocTimeouts = 0;

//
//=============================================================================
// Charge / energy accumulators
//=============================================================================
//
// Integrated from the ADS131M08 pair - the same sensor the CC loop regulates
// against - rather than the 12-bit internal ADC in the stats block.
//
// Charge and discharge accumulate their own positive magnitudes, so a charge
// followed by a discharge on one slot leaves two separate totals instead of
// cancelling. Each pair is zeroed only when its own direction starts.
//
static float32_t accChargeMah[NUM_CHANNELS];
static float32_t accChargeMwh[NUM_CHANNELS];
static float32_t accChargeSeconds[NUM_CHANNELS];
static float32_t accDischargeMah[NUM_CHANNELS];
static float32_t accDischargeMwh[NUM_CHANNELS];
static float32_t accDischargeSeconds[NUM_CHANNELS];

//
// The C tasks rotate C1 -> C2 -> C3 off one TASKC_FREQ_HZ timer, so C1 sees
// every third tick. Derived rather than written out so a change to the task
// rate carries into the integration.
//
#define BTS_ACC_DT_HOURS  ((float32_t)3.0 / ((float32_t)TASKC_FREQ_HZ * (float32_t)3600.0))
#define BTS_ACC_DT_SECONDS ((float32_t)3.0 / (float32_t)TASKC_FREQ_HZ)

//
// Zeroes one direction's counters at the moment that direction starts. The
// opposite set is left alone so the two totals from a charge/discharge cycle
// survive independently.
//
// Called ONLY on a fresh start - STOPPED->run or END->run. A resume from
// PAUSED, a trip, a fault and a watchdog pause all reset nothing.
//
static void accResetDirection(uint16_t ch, uint16_t charging)
{
    if (charging) {
        accChargeMah[ch] = (float32_t)0.0;
        accChargeMwh[ch] = (float32_t)0.0;
        accChargeSeconds[ch] = (float32_t)0.0;
    } else {
        accDischargeMah[ch] = (float32_t)0.0;
        accDischargeMwh[ch] = (float32_t)0.0;
        accDischargeSeconds[ch] = (float32_t)0.0;
    }
}

//
//=============================================================================
// Slot state model
//=============================================================================
//
// A slot is exactly one of STOPPED, CHARGING, DISCHARGING, PAUSED or END.
// PAUSED keeps the direction bit set alongside it, so a host sees both that
// the slot is held and which way it will resume.
//
static uint16_t slotIsRunning(uint16_t ch)
{
    return (status[ch].running && !status[ch].paused) ? 1U : 0U;
}

//
// Enters PAUSED from a running state. The converter reference goes to zero
// BEFORE enable_logic is cleared, the same ordering a trip exit uses - the
// control loop may run between the two writes.
//
static void slotPause(uint16_t ch, uint16_t wdTripped, uint16_t restored)
{
    BTS_ctrlLoopVariables[ch].ioutRef_pu = (float32_t)0.0;
    BTS_ctrlLoopVariables[ch].voutRef_pu = (float32_t)0.0;
    BTS_userInputs[ch].enable_logic = 0;

    status[ch].paused    = 1;
    status[ch].wdTripped = wdTripped;
    status[ch].restored  = restored;
    //
    // running stays set: PAUSED is a held run, not a stop, and the direction
    // bit has to survive so a resume knows which way to go.
    //
    status[ch].stopped   = 0;
    status[ch].finished  = 0;
}

//
// Leaves PAUSED back into whichever direction the slot held. Resets nothing:
// the counters picking up where they stopped is the point of the state.
//
static void slotResume(uint16_t ch)
{
    if (!status[ch].paused) {
        return;
    }

    status[ch].paused    = 0;
    status[ch].wdTripped = 0;
    status[ch].restored  = 0;
    status[ch].running   = 1;
    status[ch].stopped   = 0;

    BTS_userInputs[ch].direction_logic = status[ch].charging;
    BTS_userInputs[ch].enable_logic    = 1;
}

//
// Full stop. Clears the pause and END indications too, so a host that stops a
// paused slot gets a clean STOPPED rather than a mixture.
//
static void slotStop(uint16_t ch)
{
    BTS_ctrlLoopVariables[ch].ioutRef_pu = (float32_t)0.0;
    BTS_ctrlLoopVariables[ch].voutRef_pu = (float32_t)0.0;
    BTS_userInputs[ch].enable_logic = 0;

    status[ch].running   = 0;
    status[ch].stopped   = 1;
    status[ch].paused    = 0;
    status[ch].wdTripped = 0;
    status[ch].restored  = 0;
}

//
// Host watchdog, CPU1 half. CPU2 owns the countdown but must never touch a
// slot's control state, so it bumps supervision.wdPauseSeq and the pause
// happens here.
//
static void serviceHostWatchdog(void)
{
    static uint32_t wdSeqSeen = 0U;
    uint32_t seq = supervision.wdPauseSeq;
    uint16_t ch;

    if (seq == wdSeqSeen) {
        return;
    }
    wdSeqSeen = seq;

    for (ch = 0; ch < NUM_CHANNELS; ch++) {
        if (slotIsRunning(ch)) {
            slotPause(ch, 1U, 0U);
        }
    }
    updateStatusRegisters();
}

//
// Boot restore, CPU1 half. CPU2 has already written the counters into the
// runtime registers and the per-slot flags into supervision.restoreFlags;
// this reconstructs the slot state from them.
//
// A slot that was mid-run comes back PAUSED + RESTORED with the converter
// off - never running. The cell may have been swapped while the unit was
// down, so nothing here may re-energise a slot on its own.
//
static void applyRestoredSlotStates(void)
{
    uint32_t flags = supervision.restoreFlags;
    uint16_t ch;

    for (ch = 0; ch < NUM_CHANNELS; ch++) {
        uint32_t f = (flags >> BTS_STATE_FLAGS_SHIFT(ch)) & BTS_STATE_FLAGS_MASK;

        accChargeMah[ch]        = registers[BTS_RT_BASE(ch) + BTS_RT_CHARGE_MAH];
        accChargeMwh[ch]        = registers[BTS_RT_BASE(ch) + BTS_RT_CHARGE_MWH];
        accChargeSeconds[ch]    = registers[BTS_RT_BASE(ch) + BTS_RT_CHARGE_SECONDS];
        accDischargeMah[ch]     = registers[BTS_RT_BASE(ch) + BTS_RT_DISCHARGE_MAH];
        accDischargeMwh[ch]     = registers[BTS_RT_BASE(ch) + BTS_RT_DISCHARGE_MWH];
        accDischargeSeconds[ch] = registers[BTS_RT_BASE(ch) + BTS_RT_DISCHARGE_SECONDS];

        slotStop(ch);
        status[ch].finished = ((f & BTS_STATE_F_END) != 0UL) ? 1U : 0U;

        if ((f & BTS_STATE_F_RUNNING) != 0UL) {
            status[ch].charging    = ((f & BTS_STATE_F_CHARGING) != 0UL) ? 1U : 0U;
            status[ch].discharging = !status[ch].charging;
            status[ch].running     = 1;
            slotPause(ch, 0U, 1U);
        }
    }

    updateStatusRegisters();
}

//
//=============================================================================
// Runtime slot calibration state
//=============================================================================
//
// Only one slot calibrates at a time, so a single capture set is enough.
// Everything here is touched from the 100 Hz B3 task and the 10 Hz C1 task,
// never from an ISR.
//
static uint16_t  calSlot      = BTS_CAL_SLOT_NONE;
static uint32_t  calStatusBits = 0U;
static uint32_t  calLastResult = (uint32_t)eCalErrOk;
static uint32_t  calSaveSeq    = 0U;

//
// Captures. The ADS and internal paths are sampled at the same instant from
// the same physical stimulus, so both are recorded per point.
//
static float32_t calV_lo_adsPu, calV_lo_f28, calV_lo_V;
static float32_t calV_hi_adsPu, calV_hi_f28, calV_hi_V;
static float32_t calI_zero_adsPu, calI_zero_f28;
static float32_t calI_hi_adsPu, calI_hi_f28, calI_hi_A;

//
// Dead-man timeout. A bench supply left driving an unattended slot is the
// main physical risk in this procedure, so fixed-current mode expires if no
// command arrives. C1 runs at 10 Hz / 3 alpha states, i.e. ~6.67 Hz, so 800
// passes is comfortably over the specified 120 s.
//
#define BTS_CAL_DEADMAN_PASSES ((uint16_t)800U)
static uint16_t calIdlePasses = 0U;

//
// Classification window for a voltage capture, in raw ADS per-unit. A point
// between the two is too close to the other to give a useful two-point fit.
//
#define BTS_CAL_V_LO_MAX_PU ((float32_t)0.2)
#define BTS_CAL_V_HI_MIN_PU ((float32_t)0.8)

// Minimum separation between the two points, section 6.6.
#define BTS_CAL_MIN_V_SPAN  ((float32_t)1.0)
#define BTS_CAL_MIN_I_SPAN  ((float32_t)0.5)

//
// Validation windows, section 8.2. Applied on CPU1 before the result is
// handed to CPU2, so a bad fit never reaches the F-RAM.
//
#define BTS_CAL_IOUT_GAIN_PU_MIN ((float32_t)0.05)
#define BTS_CAL_IOUT_GAIN_PU_MAX ((float32_t)0.20)
#define BTS_CAL_VOUT_GAIN_PU_MIN ((float32_t)0.10)
#define BTS_CAL_VOUT_GAIN_PU_MAX ((float32_t)0.40)
#define BTS_CAL_F28_GAIN_MIN     ((float32_t)0.5)
#define BTS_CAL_F28_GAIN_MAX     ((float32_t)2.0)
#define BTS_CAL_F28V_OFFSET_ABS  ((float32_t)1.0)
#define BTS_CAL_F28I_OFFSET_ABS  ((float32_t)2.0)

//
// Raw per-unit converter readings, before any calibration gain/offset.
//
// The two paths do NOT share a per-unit definition and must not be
// conflated: the ADS131M08 is 16-bit signed full scale, while the internal
// path is expressed as volts-at-the-pin so it matches how
// BTS_monitor_Iout_Vout() scales the same reading.
//
static float32_t calAdsVoltagePu(const BTS_measValue *m)
{
    return (float32_t)m->Sum_V / ((float32_t)BTS_senseAverageFactor * 32768.0f);
}

static float32_t calAdsCurrentPu(const BTS_measValue *m)
{
    return (float32_t)m->Sum_I / ((float32_t)BTS_senseAverageFactor * 32768.0f);
}

static float32_t calF28VoltagePu(const BTS_measValue *m)
{
    return ((float32_t)m->Sum_CellV /
            ((float32_t)BTS_f28AverageFactor * 4096.0f)) * 2.5f;
}

static float32_t calF28CurrentPu(const BTS_measValue *m)
{
    return ((float32_t)m->Sum_CellI /
            ((float32_t)BTS_f28AverageFactor * 4096.0f)) * 2.5f;
}

//
// Rejects a gain that is zero, denormal, NaN or Inf. A NaN fails every
// ordered comparison, so the self-compare catches it; the magnitude test
// catches the rest.
//
static uint16_t calGainUsable(float32_t g)
{
    float32_t mag = (g < 0.0f) ? -g : g;

    if (g != g) {
        return 0U;
    }
    return ((mag > 1.0e-20f) && (mag < 1.0e20f)) ? 1U : 0U;
}

static uint16_t calSlotIsCalibrating(uint16_t ch)
{
    return (BTS_userInputs[ch].calState != BTS_CAL_STATE_NORMAL) ? 1U : 0U;
}

//
// Leaves calibration on one slot, reference first. Safe to call on a slot
// that is not calibrating.
//
static void calExitSlot(uint16_t ch)
{
    BTS_userInputs[ch].ioutCal_pu   = (float32_t)0.0;
    BTS_userInputs[ch].voutCal_pu   = (float32_t)0.0;
    BTS_ctrlLoopVariables[ch].ioutRef_pu = (float32_t)0.0;
    BTS_ctrlLoopVariables[ch].voutRef_pu = (float32_t)0.0;
    BTS_userInputs[ch].enable_logic = 0;
    BTS_userInputs[ch].calState     = BTS_CAL_STATE_NORMAL;
    status[ch].calibrating          = 0;
}

static void calClearCaptures(void)
{
    calStatusBits &= ~((1UL << BTS_CAL_ST_V_LO)       |
                       (1UL << BTS_CAL_ST_V_HI)       |
                       (1UL << BTS_CAL_ST_I_ZERO)     |
                       (1UL << BTS_CAL_ST_I_LOADED)   |
                       (1UL << BTS_CAL_ST_V_COMPUTED) |
                       (1UL << BTS_CAL_ST_I_COMPUTED) |
                       (1UL << BTS_CAL_ST_SAVED));
}

//
// Ends the whole session: every slot leaves calibration, the window closes.
//
static void calExitAll(void)
{
    uint16_t ch;

    for (ch = 0; ch < NUM_CHANNELS; ch++) {
        calExitSlot(ch);
    }

    calSlot       = BTS_CAL_SLOT_NONE;
    calStatusBits = 0U;
    calIdlePasses = 0U;
}

//
// Computes and validates the two-point results, then hands them to CPU2 for
// the F-RAM write. Voltage and current are independent: whichever is complete
// is computed, and partial completion is reported rather than failing.
//
static uint32_t calComputeAndSave(void)
{
    float32_t out[BTS_CAL_REGS_PER_CH];
    uint32_t  flags = BTS_CAL_FLAG_EXTERNAL;
    uint16_t  base;
    uint16_t  i;
    uint16_t  haveV;
    uint16_t  haveI;

    if (calSlot >= NUM_CHANNELS) {
        return (uint32_t)eCalErrNotCalibrating;
    }

    haveV = ((calStatusBits & (1UL << BTS_CAL_ST_V_LO)) != 0UL) &&
            ((calStatusBits & (1UL << BTS_CAL_ST_V_HI)) != 0UL);
    haveI = ((calStatusBits & (1UL << BTS_CAL_ST_I_ZERO))   != 0UL) &&
            ((calStatusBits & (1UL << BTS_CAL_ST_I_LOADED)) != 0UL);

    if (!haveV && !haveI) {
        return (uint32_t)eCalErrNoCaptures;
    }

    //
    // Start from what the slot is running now, so an incomplete session
    // leaves the other path's stored values alone rather than zeroing them.
    //
    base = BTS_CAL_BASE(calSlot);
    for (i = 0; i < BTS_CAL_REGS_PER_CH; i++) {
        out[i] = registers[base + i];
    }

    if (haveV) {
        float32_t dV   = calV_hi_V - calV_lo_V;
        float32_t dF28 = calV_hi_f28 - calV_lo_f28;
        float32_t gPu;
        float32_t gF28;
        float32_t span = (dV < 0.0f) ? -dV : dV;

        if (span < BTS_CAL_MIN_V_SPAN) {
            return (uint32_t)eCalErrPuRange;
        }

        gPu  = (calV_hi_adsPu - calV_lo_adsPu) / dV;
        gF28 = dF28 != 0.0f ? (dV / dF28) : 0.0f;

        if (!calGainUsable(gPu) || !calGainUsable(gF28)) {
            return (uint32_t)eCalErrValidate;
        }
        if ((gPu < BTS_CAL_VOUT_GAIN_PU_MIN) || (gPu > BTS_CAL_VOUT_GAIN_PU_MAX)) {
            return (uint32_t)eCalErrValidate;
        }
        if ((gF28 < BTS_CAL_F28_GAIN_MIN) || (gF28 > BTS_CAL_F28_GAIN_MAX)) {
            return (uint32_t)eCalErrValidate;
        }

        out[BTS_CAL_VOUT_GAIN_PU]   = gPu;
        out[BTS_CAL_VOUT_OFFSET_PU] = calV_lo_adsPu - calV_lo_V * gPu;
        out[BTS_CAL_VOUT_GAIN_V]    = 1.0f / gPu;
        out[BTS_CAL_VOUT_OFFSET_V]  = -out[BTS_CAL_VOUT_OFFSET_PU] / gPu;

        out[BTS_CAL_F28V_GAIN]      = gF28;
        out[BTS_CAL_F28V_OFFSET]    = calV_lo_V - calV_lo_f28 * gF28;

        if ((out[BTS_CAL_F28V_OFFSET] < -BTS_CAL_F28V_OFFSET_ABS) ||
            (out[BTS_CAL_F28V_OFFSET] >  BTS_CAL_F28V_OFFSET_ABS)) {
            return (uint32_t)eCalErrValidate;
        }

        flags |= BTS_CAL_FLAG_V_VALID;
        calStatusBits |= (1UL << BTS_CAL_ST_V_COMPUTED);
    }

    if (haveI) {
        //
        // The operator supplies a magnitude; calibration current always flows
        // in discharge, so the sign is applied here. Entering a signed value
        // would otherwise invert the slot's whole current reading.
        //
        float32_t iHi  = -calI_hi_A;
        float32_t dF28 = calI_hi_f28 - calI_zero_f28;
        float32_t gPu;
        float32_t gF28;
        float32_t span = (calI_hi_A < 0.0f) ? -calI_hi_A : calI_hi_A;

        if (span < BTS_CAL_MIN_I_SPAN) {
            return (uint32_t)eCalErrPuRange;
        }

        gPu  = (calI_hi_adsPu - calI_zero_adsPu) / iHi;
        gF28 = dF28 != 0.0f ? (iHi / dF28) : 0.0f;

        if (!calGainUsable(gPu) || !calGainUsable(gF28)) {
            return (uint32_t)eCalErrValidate;
        }
        if ((gPu < BTS_CAL_IOUT_GAIN_PU_MIN) || (gPu > BTS_CAL_IOUT_GAIN_PU_MAX)) {
            return (uint32_t)eCalErrValidate;
        }
        if ((gF28 < BTS_CAL_F28_GAIN_MIN) || (gF28 > BTS_CAL_F28_GAIN_MAX)) {
            return (uint32_t)eCalErrValidate;
        }

        out[BTS_CAL_IOUT_GAIN_PU]   = gPu;
        out[BTS_CAL_IOUT_OFFSET_PU] = calI_zero_adsPu;
        out[BTS_CAL_IOUT_GAIN_A]    = 1.0f / gPu;
        out[BTS_CAL_IOUT_OFFSET_A]  = -calI_zero_adsPu / gPu;

        out[BTS_CAL_F28I_GAIN]      = gF28;
        out[BTS_CAL_F28I_OFFSET]    = -calI_zero_f28 * gF28;

        if ((out[BTS_CAL_F28I_OFFSET] < -BTS_CAL_F28I_OFFSET_ABS) ||
            (out[BTS_CAL_F28I_OFFSET] >  BTS_CAL_F28I_OFFSET_ABS)) {
            return (uint32_t)eCalErrValidate;
        }

        flags |= BTS_CAL_FLAG_I_VALID;
        calStatusBits |= (1UL << BTS_CAL_ST_I_COMPUTED);
    }

    //
    // Hand over for persistence. CPU2 writes F-RAM from its idle loop and
    // sets status bit 7 when it lands - CPU1 must not claim SAVED itself.
    //
    for (i = 0; i < BTS_CAL_REGS_PER_CH; i++) {
        cpu1Status.calComputed[i] = out[i];
    }
    cpu1Status.calSaveSlot  = calSlot;
    cpu1Status.calSaveFlags = flags;
    calSaveSeq++;
    cpu1Status.calSaveSeq   = calSaveSeq;

    return (uint32_t)eCalErrOk;
}

//
// The command handler. Reached from BTS_HandleRegisterWrite() when CPU2
// signals a write to eCalCommand, and from modeCallback() for the eChX_Mode
// bit-2 entry point, so the one-slot-at-a-time rule lives in one place.
//
static void calHandleCommand(uint16_t opcode, float32_t argument)
{
    uint32_t result = (uint32_t)eCalErrOk;
    uint16_t ch;

    //
    // Any command is proof of life for the dead-man timer.
    //
    calIdlePasses = 0U;

    switch (opcode) {
    case eCalCmdEnter: {
        uint16_t slot = (uint16_t)registers[BTS_REG_IDX(eCalSlot)];

        if (slot >= NUM_CHANNELS) {
            result = (uint32_t)eCalErrArg;
            break;
        }
        //
        // A follower has no control loop of its own and a strap-disabled slot
        // never runs, so neither can be driven to a reference.
        //
        if ((btsSlotEnabled[slot] == 0U) || (btsSlotIsLeader[slot] == 0U)) {
            result = (uint32_t)eCalErrSlotUnavailable;
            break;
        }
        //
        // Rejected while any slot is running a charge/discharge test. A slot
        // already in calibration is not a test - it is force-exited below.
        //
        for (ch = 0; ch < NUM_CHANNELS; ch++) {
            if (status[ch].running && (calSlotIsCalibrating(ch) == 0U)) {
                result = (uint32_t)eCalErrSlotTesting;
                break;
            }
        }
        if (result != (uint32_t)eCalErrOk) {
            break;
        }

        //
        // One slot only: every other slot leaves calibration first.
        //
        for (ch = 0; ch < NUM_CHANNELS; ch++) {
            if (ch != slot) {
                calExitSlot(ch);
            }
        }

        calSlot       = slot;
        calStatusBits = (1UL << BTS_CAL_ST_ACTIVE);
        //
        // Deliberately not propagated to followers the way modeCallback()
        // propagates a normal start - a group mirrors a leader's duty, and
        // dragging seven cells along would be a bench hazard, not a feature.
        //
        BTS_userInputs[slot].ioutCal_pu = (float32_t)0.0;
        BTS_userInputs[slot].calState   = BTS_CAL_STATE_IDLE;
        BTS_userInputs[slot].enable_logic = 0;
        status[slot].calibrating = 1;
        break;
    }

    case eCalCmdExit:
        calExitAll();
        break;

    case eCalCmdClear:
        if (calSlot >= NUM_CHANNELS) {
            result = (uint32_t)eCalErrNotCalibrating;
            break;
        }
        calClearCaptures();
        break;

    case eCalCmdCaptureVoltage: {
        float32_t adsPu;

        if (calSlot >= NUM_CHANNELS) {
            result = (uint32_t)eCalErrNotCalibrating;
            break;
        }
        adsPu = calAdsVoltagePu(&BTS_measValues[calSlot]);

        if (adsPu < BTS_CAL_V_LO_MAX_PU) {
            calV_lo_adsPu = adsPu;
            calV_lo_f28   = calF28VoltagePu(&BTS_measValues[calSlot]);
            calV_lo_V     = argument;
            calStatusBits |= (1UL << BTS_CAL_ST_V_LO);
        } else if (adsPu > BTS_CAL_V_HI_MIN_PU) {
            calV_hi_adsPu = adsPu;
            calV_hi_f28   = calF28VoltagePu(&BTS_measValues[calSlot]);
            calV_hi_V     = argument;
            calStatusBits |= (1UL << BTS_CAL_ST_V_HI);
        } else {
            result = (uint32_t)eCalErrPuRange;
        }
        break;
    }

    case eCalCmdZeroCurrent:
        if (calSlot >= NUM_CHANNELS) {
            result = (uint32_t)eCalErrNotCalibrating;
            break;
        }
        //
        // The zero point is only meaningful with the converter off, so drop
        // out of fixed-current first rather than sampling a driven slot.
        //
        BTS_userInputs[calSlot].ioutCal_pu = (float32_t)0.0;
        BTS_userInputs[calSlot].calState   = BTS_CAL_STATE_IDLE;
        BTS_userInputs[calSlot].enable_logic = 0;
        calStatusBits &= ~(1UL << BTS_CAL_ST_DRIVING);

        calI_zero_adsPu = calAdsCurrentPu(&BTS_measValues[calSlot]);
        calI_zero_f28   = calF28CurrentPu(&BTS_measValues[calSlot]);
        calStatusBits |= (1UL << BTS_CAL_ST_I_ZERO);
        break;

    case eCalCmdSetFixedCurrent:
        if (calSlot >= NUM_CHANNELS) {
            result = (uint32_t)eCalErrNotCalibrating;
            break;
        }
        if ((argument < (float32_t)0.0) || (argument > BTS_CAL_FIXED_I_MAX_PU)) {
            result = (uint32_t)eCalErrArg;
            break;
        }
        BTS_userInputs[calSlot].ioutCal_pu   = argument;
        BTS_userInputs[calSlot].calState     = BTS_CAL_STATE_FIXED_I;
        BTS_userInputs[calSlot].enable_logic = 1;
        BTS_ctrlLoopVariables[calSlot].tripFlag = 0;
        calStatusBits |= (1UL << BTS_CAL_ST_DRIVING);
        break;

    case eCalCmdCaptureCurrent:
        if (calSlot >= NUM_CHANNELS) {
            result = (uint32_t)eCalErrNotCalibrating;
            break;
        }
        calI_hi_adsPu = calAdsCurrentPu(&BTS_measValues[calSlot]);
        calI_hi_f28   = calF28CurrentPu(&BTS_measValues[calSlot]);
        calI_hi_A     = (argument < 0.0f) ? -argument : argument;
        calStatusBits |= (1UL << BTS_CAL_ST_I_LOADED);
        break;

    case eCalCmdComputeSave:
        result = calComputeAndSave();
        break;

    case eCalCmdNone:
    default:
        return;
    }

    if (result == (uint32_t)eCalErrOk) {
        calStatusBits &= ~(1UL << BTS_CAL_ST_FAILED);
    } else {
        calStatusBits |= (1UL << BTS_CAL_ST_FAILED);
    }
    calLastResult = result;

    publishStatusToCpu2();
}

//
// Drops a slot left driving with no host attention back to calibration idle.
// Called from C1 at 10 Hz.
//
static void calServiceDeadMan(void)
{
    if ((calSlot >= NUM_CHANNELS) ||
        (BTS_userInputs[calSlot].calState != BTS_CAL_STATE_FIXED_I)) {
        calIdlePasses = 0U;
        return;
    }

    if (++calIdlePasses < BTS_CAL_DEADMAN_PASSES) {
        return;
    }

    calIdlePasses = 0U;
    BTS_userInputs[calSlot].ioutCal_pu   = (float32_t)0.0;
    BTS_userInputs[calSlot].calState     = BTS_CAL_STATE_IDLE;
    BTS_userInputs[calSlot].enable_logic = 0;
    calStatusBits &= ~(1UL << BTS_CAL_ST_DRIVING);
}

//
// Publishes the live window on the slot under calibration. Zeroed when no
// slot is selected, so a stale reading cannot be mistaken for a live one.
//
static void calPublishTelemetry(void)
{
    uint16_t i;

    cpu1Status.calActiveSlot = calSlot;
    cpu1Status.calStatus     = calStatusBits;
    cpu1Status.calResult     = calLastResult;

    if (calSlot >= NUM_CHANNELS) {
        for (i = 0; i < 8U; i++) {
            cpu1Status.calTelemetry[i] = (float32_t)0.0;
        }
        return;
    }

    {
        const BTS_measValue *m = &BTS_measValues[calSlot];

        cpu1Status.calTelemetry[0] = calAdsVoltagePu(m);
        cpu1Status.calTelemetry[1] = calAdsCurrentPu(m);
        cpu1Status.calTelemetry[2] = m->Vsense_V;
        cpu1Status.calTelemetry[3] = m->Isense_A;
        cpu1Status.calTelemetry[4] = calF28VoltagePu(m);
        cpu1Status.calTelemetry[5] = calF28CurrentPu(m);
        cpu1Status.calTelemetry[6] = m->CellVoltage_V;
        cpu1Status.calTelemetry[7] = m->CellCurrent_I;
    }
}

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
    // Resolve the MODE/ENABLE straps into the per-slot grouping tables, then
    // phase the ePWMs to match. Both have to happen here: the straps were
    // latched in BTS_HAL_setupGPIO() above, and the phase registers may only
    // be written while the time bases are still stopped.
    //
    BTS_initSlotGrouping((uint16_t)startup_mode, (uint16_t)startup_enable);
    BTS_HAL_setupGroupPhase(BTS_MODE_GROUP_SIZE((uint16_t)startup_mode));

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
    // Every vector is populated now, so it is safe to let interrupts run.
    //
    BTS_HAL_enableGlobalInterrupts();

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
    GPIO_setControllerCore(BTS_RUN_LED_GPIO, GPIO_CORE_CPU2); // heartbeat LED

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
        uint32_t calFlags = calValidFlags[ch];

        //
        // Regulation mode. The ISR has tracked ctrlMode_logic all along; it
        // simply was never copied here, so bits 6 and 7 always read 0.
        //
        status[ch].constVoltage = (BTS_ctrlLoopVariables[ch].ctrlMode_logic != 0U) ? 1U : 0U;
        status[ch].constCurrent = (BTS_ctrlLoopVariables[ch].ctrlMode_logic == 0U) ? 1U : 0U;

        //
        // Calibration validity comes from the PERSISTED flags CPU2 mirrors
        // into calValidFlags[] (CPU2TOCPU1RAM) at boot and on each save, not
        // from the in-session capture - a slot calibrated in an earlier
        // session must still show its ticks after a power cycle.
        //
        status[ch].calVoltageValid = ((calFlags & BTS_CAL_FLAG_V_VALID) != 0UL) ? 1U : 0U;
        status[ch].calCurrentValid = ((calFlags & BTS_CAL_FLAG_I_VALID) != 0UL) ? 1U : 0U;

        bitset |= (status[ch].running & 0x1) << 0;
        bitset |= (status[ch].stopped & 0x1) << 1;
        //
        // END. Bit 2 is BTS_STATUS_FINISHED, declared from the start and
        // never driven until now; the design gives it the END meaning rather
        // than adding a second bit for the same thing. BTS_STATUS_END is an
        // alias for it, so this one assignment drives both names.
        //
        bitset |= (status[ch].finished & 0x1) << BTS_STATUS_END;
        bitset |= (status[ch].overCurrentTrip & 0x1) << 3;
        bitset |= (status[ch].charging & 0x1) << 4;
        bitset |= (status[ch].discharging & 0x1) << 5;
        bitset |= (status[ch].constVoltage & 0x1) << 6;
        bitset |= (status[ch].constCurrent & 0x1) << 7;
        bitset |= (status[ch].slaveMode & 0x1) << BTS_STATUS_SLAVE_MODE;
        bitset |= (status[ch].groupDisconnect & 0x1) << BTS_STATUS_GROUP_DISCONNECT;
        bitset |= (status[ch].reversePolarity & 0x1) << BTS_STATUS_REVERSE_POLARITY;
        bitset |= (status[ch].slotDisabled & 0x1) << BTS_STATUS_SLOT_DISABLED;
        bitset |= (status[ch].calibrating & 0x1) << BTS_STATUS_CALIBRATING;
        bitset |= (status[ch].calVoltageValid & 0x1) << BTS_STATUS_CAL_V_VALID;
        bitset |= (status[ch].calCurrentValid & 0x1) << BTS_STATUS_CAL_I_VALID;
        bitset |= (status[ch].paused & 0x1) << BTS_STATUS_PAUSED;
        bitset |= (status[ch].wdTripped & 0x1) << BTS_STATUS_WD_TRIPPED;
        bitset |= (status[ch].restored & 0x1) << BTS_STATUS_RESTORED;
        cpu1Status.statusBits[ch] = bitset;

        cpu1Status.cellVoltage[ch] = BTS_measValues[ch].CellVoltage_V;
        cpu1Status.cellCurrent[ch] = BTS_measValues[ch].CellCurrent_I;

        //
        // The ADS131M08 engineering values. Computed at 10 Hz since the
        // converter was fitted and, until now, read by nothing.
        //
        cpu1Status.senseVoltage[ch] = BTS_measValues[ch].Vsense_V;
        cpu1Status.senseCurrent[ch] = BTS_measValues[ch].Isense_A;

        cpu1Status.chargeMah[ch]    = accChargeMah[ch];
        cpu1Status.chargeMwh[ch]    = accChargeMwh[ch];
        cpu1Status.chargeSeconds[ch] = accChargeSeconds[ch];
        cpu1Status.dischargeMah[ch] = accDischargeMah[ch];
        cpu1Status.dischargeMwh[ch] = accDischargeMwh[ch];
        cpu1Status.dischargeSeconds[ch] = accDischargeSeconds[ch];

        canData[ch].channel = ch;
        canData[ch].voltage = BTS_measValues[ch].CellVoltage_V;
        canData[ch].current = BTS_measValues[ch].CellCurrent_I;
        //
        // CAN carries the total for the direction the slot is set to, so a
        // listener sees the figure for the test in progress.
        //
        canData[ch].mAh = status[ch].charging ? accChargeMah[ch] : accDischargeMah[ch];
        canData[ch].mWh = status[ch].charging ? accChargeMwh[ch] : accDischargeMwh[ch];
    }

    cpu1Status.unitState = (uint32_t)unitState;

    calPublishTelemetry();

    //
    // Dip-switch straps. Carried inside the seq guard so CPU2 never mirrors
    // them before they have been latched - the message RAM is NOLOAD from
    // CPU2's side, so its power-up contents are not guaranteed to be zero.
    //
    cpu1Status.slotMode    = startup_mode;
    cpu1Status.slotEnable  = startup_enable;
    cpu1Status.groupSize   = BTS_MODE_GROUP_SIZE((uint16_t)startup_mode);
    cpu1Status.strapsValid = 1U;

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
        //
        // A slot the ENABLE strap masked off does not run, and a slot that
        // follows a leader has no control loop of its own - in a group the
        // leader speaks for every member. Reject writes to either rather
        // than let a host half-start a group.
        //
        if ((btsSlotEnabled[channel] == 0U) || (btsSlotIsLeader[channel] == 0U)) {
            return;
        }

        //
        // Bit 2 is the calibration entry point. Routed through the same
        // handler as CAL_CMD_ENTER so the one-slot-at-a-time rule, the
        // not-while-testing rule and the follower rejection are enforced
        // in exactly one place.
        //
        // Returning here is also the mode-write half of the input-voltage
        // exemption: a slot entering calibration must not be measured
        // against eChargeRestrictV / eDischargeRestrictV below. The 10 Hz
        // half lives in C1().
        //
        if (mode & BTS_MODE_CALIBRATE) {
            registers[BTS_REG_IDX(eCalSlot)] = (float32_t)channel;
            calHandleCommand((uint16_t)eCalCmdEnter, (float32_t)0.0);
            return;
        }

        //
        // Pause and resume are edge commands, handled before the run/stop
        // decode and not retained - a host never has to clear them. They
        // carry across a group the same way a start does.
        //
        if (mode & BTS_MODE_PAUSE) {
            uint16_t m;
            for (m = 0; m < NUM_CHANNELS; m++) {
                if ((btsSlotLeader[m] == channel) && (btsSlotEnabled[m] != 0U) &&
                    slotIsRunning(m)) {
                    slotPause(m, 0U, 0U);
                }
            }
            updateStatusRegisters();
            return;
        }

        //
        // Writing run=1 to a paused slot is also a resume, so a host that
        // only knows the old protocol still works.
        //
        if ((mode & BTS_MODE_RESUME) ||
            ((mode & BTS_MODE_RUN) && status[channel].paused)) {
            uint16_t m;
            if (!status[channel].paused) {
                return;   // nothing to resume
            }
            for (m = 0; m < NUM_CHANNELS; m++) {
                if ((btsSlotLeader[m] == channel) && (btsSlotEnabled[m] != 0U)) {
                    slotResume(m);
                }
            }
            updateStatusRegisters();
            return;
        }

        //
        // A start on a slot that was calibrating ends its calibration first,
        // reference down before anything else changes.
        //
        if (calSlotIsCalibrating(channel)) {
            calExitAll();
        }

        float chargeRestrictV = registers[BTS_REG_IDX(eChargeRestrictV)];
        float dischargeRestrictV = registers[BTS_REG_IDX(eDischargeRestrictV)];

        float inputV = registers[BTS_REG_IDX(eInputVoltage)];
        if ((mode & BTS_MODE_CHARGE) && (inputV <= chargeRestrictV)) {
            slotStop(channel);
            updateStatusRegisters();
            return;
        }
        if (!(mode & BTS_MODE_CHARGE) && (inputV >= dischargeRestrictV)) {
            slotStop(channel);
            updateStatusRegisters();
            return;
        }

        status[channel].charging = (mode & BTS_MODE_CHARGE) >> 1;
        status[channel].discharging = !((mode & BTS_MODE_CHARGE) >> 1);
        if (mode & BTS_MODE_RUN) {
            uint16_t regBase = BTS_SET_BASE(channel);
            uint16_t vMinOff = (mode & BTS_MODE_CHARGE) ? BTS_SET_CHG_V_MIN : BTS_SET_DIS_V_MIN;
            uint16_t vMaxOff = (mode & BTS_MODE_CHARGE) ? BTS_SET_CHG_V_MAX : BTS_SET_DIS_V_MAX;
            uint16_t iMinOff = (mode & BTS_MODE_CHARGE) ? BTS_SET_CHG_I_MIN : BTS_SET_DIS_I_MIN;
            uint16_t iMaxOff = (mode & BTS_MODE_CHARGE) ? BTS_SET_CHG_I_MAX : BTS_SET_DIS_I_MAX;

            status[channel].running   = 1;
            status[channel].stopped   = 0;
            status[channel].paused    = 0;
            status[channel].wdTripped = 0;
            status[channel].restored  = 0;

            BTS_userInputs[channel].vref_charge_V    = registers[regBase + vMaxOff];
            BTS_userInputs[channel].vref_discharge_V = registers[regBase + vMinOff];
            BTS_userInputs[channel].iref_A           = registers[regBase + iMaxOff];
            BTS_userInputs[channel].iref_cuttout_A   = registers[regBase + iMinOff];
            BTS_userInputs[channel].direction_logic  = status[channel].charging;
            BTS_userInputs[channel].enable_logic     = 1;

            //
            // A fresh start - STOPPED->run or END->run. This is the only
            // place a counter set is zeroed, and only the starting
            // direction's set. Clearing END here is what makes the next
            // termination distinguishable from this one.
            //
            status[channel].finished = 0;
            accResetDirection(channel, status[channel].charging);
        } else {
            slotStop(channel);
        }

        //
        // Carry the leader's transition across its group. Followers take the
        // same run/direction state and the same references, since they track
        // the leader's duty and have to agree about which way it is driving.
        //
        {
            uint16_t m;
            for (m = 0; m < NUM_CHANNELS; m++) {
                if ((m == channel) || (btsSlotLeader[m] != channel)) {
                    continue;
                }
                if (btsSlotEnabled[m] == 0U) {
                    continue;
                }

                status[m].running     = status[channel].running;
                status[m].stopped     = status[channel].stopped;
                status[m].charging    = status[channel].charging;
                status[m].discharging = status[channel].discharging;
                status[m].paused      = status[channel].paused;
                status[m].wdTripped   = status[channel].wdTripped;
                status[m].restored    = status[channel].restored;

                BTS_userInputs[m].vref_charge_V    = BTS_userInputs[channel].vref_charge_V;
                BTS_userInputs[m].vref_discharge_V = BTS_userInputs[channel].vref_discharge_V;
                BTS_userInputs[m].iref_A           = BTS_userInputs[channel].iref_A;
                BTS_userInputs[m].iref_cuttout_A   = BTS_userInputs[channel].iref_cuttout_A;
                BTS_userInputs[m].direction_logic  = BTS_userInputs[channel].direction_logic;
                BTS_userInputs[m].enable_logic     = BTS_userInputs[channel].enable_logic;

                //
                // A fresh start clears a stale group fault; otherwise one
                // disconnection would keep the group latched off forever.
                // The accumulator reset rides along so every member of the
                // group starts its run from zero, as the leader does.
                //
                if (status[channel].running) {
                    status[m].groupDisconnect = 0;
                    status[m].finished = 0;
                    accResetDirection(m, status[m].charging);
                }
            }
            if (status[channel].running) {
                status[channel].groupDisconnect = 0;
            }
        }

        updateStatusRegisters();
    }
}

//
// Handles messages from the communications CPU.
//
//   BTS_IPC_FLAG_REG_WRITE     one register changed; ipcMsg carries the index
//   BTS_IPC_FLAG_TEMP_UPDATE   a cell temperature was refreshed
//   BTS_IPC_FLAG_CAL_RELOAD    the whole calibration block was reloaded
//   BTS_IPC_FLAG_STATE_RESTORE slot runtime state came back from F-RAM
//
// registers[] itself lives in CPU2's message RAM and has already been
// updated by CPU2 before the flag was raised - CPU1 only reacts to the
// change, it never writes the register file.
//
void BTS_HandleRegisterWrite(void)
{
    if (IPC_isFlagBusyRtoL(IPC_CPU1_L_CPU2_R, BTS_IPC_FLAG_REG_WRITE)) {
        uint16_t regIdx = ipcMsg.regAddr;

        //
        // The decode is by index range, so it has to be re-derived from the
        // map every time the map moves. Under v2 the whole runtime region
        // (0 .. 95) is read-only and never reaches here; a write is either
        // in the settings region or in the unit region.
        //
        if ((regIdx >= BTS_SET_BASE(0)) && (regIdx < BTS_SET_BASE(NUM_CHANNELS))) {
            uint16_t channel = (regIdx - BTS_SET_BASE(0)) / BTS_SET_REGS_PER_CH;
            uint16_t offset  = (regIdx - BTS_SET_BASE(0)) % BTS_SET_REGS_PER_CH;

            if (offset == BTS_SET_MODE) {
                modeCallback(ipcMsg.value, channel);
            } else if ((offset >= (BTS_CAL_BASE(0) - BTS_SET_BASE(0))) &&
                       (offset <  (BTS_CAL_BASE(0) - BTS_SET_BASE(0)) +
                                  BTS_CAL_REGS_PER_CH)) {
                //
                // Calibration group: pull the whole channel in and schedule
                // a recalculation on the next C2 task.
                //
                BTS_loadCalibrationFromRegisters(channel);
            }
        } else if (regIdx == BTS_REG_IDX(eCalCommand)) {
            //
            // The runtime calibration command. This decode is not optional:
            // without it the index falls outside both branches above, the
            // flag is acked, and every command is accepted by CPU2 and
            // silently discarded here.
            //
            calHandleCommand((uint16_t)ipcMsg.value,
                             registers[BTS_REG_IDX(eCalArgument)]);
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

    if (IPC_isFlagBusyRtoL(IPC_CPU1_L_CPU2_R, BTS_IPC_FLAG_STATE_RESTORE)) {
        applyRestoredSlotStates();
        IPC_ackFlagRtoL(IPC_CPU1_L_CPU2_R, BTS_IPC_FLAG_STATE_RESTORE);
    }

    serviceHostWatchdog();
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
        measValues->Sum_I += measValues->Isense_24b[index];
        measValues->Sum_V += measValues->Vsense_24b[index];
    }
    for (index = 0U; index < BTS_f28AverageFactor; index++) {
        measValues->Sum_CellV += measValues->CellVoltage_16b[index];
        measValues->Sum_CellI += measValues->CellCurrent_16b[index];
    }
    //
    // Normalise each converter against its own full scale. The ADS131M08 is
    // 24-bit two's complement, so +/-full scale is 2^23, not the 2^15 a
    // 16-bit part would use - dividing by 32768 here would report a reading
    // 256x too large.
    //
    avgValue = (float32_t)measValues->Sum_I / ((float32_t)BTS_senseAverageFactor * BTS_ADS131_FULLSCALE);
    measValues->Isense_A = measValues->IoutGain_A * avgValue + measValues->IoutOffset_A;
    avgValue = (float32_t)measValues->Sum_V / ((float32_t)BTS_senseAverageFactor * BTS_ADS131_FULLSCALE);
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

    //
    // Integrate charge, energy and run time from the measurements just
    // refreshed. Counters advance only while a slot is genuinely running:
    // a paused, stopped, ended, tripped or calibrating slot contributes
    // nothing and its totals freeze exactly where they were.
    //
    for (uint16_t ch = 0; ch < NUM_CHANNELS; ch++) {
        if ((slotIsRunning(ch) == 0U) || calSlotIsCalibrating(ch)) {
            continue;
        }

        float32_t i_A = fabsf(BTS_measValues[ch].Isense_A);
        float32_t p_W = fabsf(BTS_measValues[ch].Isense_A * BTS_measValues[ch].Vsense_V);

        if (status[ch].charging) {
            accChargeMah[ch] += i_A * (float32_t)1000.0 * BTS_ACC_DT_HOURS;
            accChargeMwh[ch] += p_W * (float32_t)1000.0 * BTS_ACC_DT_HOURS;
            accChargeSeconds[ch] += BTS_ACC_DT_SECONDS;
        } else {
            accDischargeMah[ch] += i_A * (float32_t)1000.0 * BTS_ACC_DT_HOURS;
            accDischargeMwh[ch] += p_W * (float32_t)1000.0 * BTS_ACC_DT_HOURS;
            accDischargeSeconds[ch] += BTS_ACC_DT_SECONDS;
        }
    }

    updateInputVoltage();

    float chargeRestrictV = registers[BTS_REG_IDX(eChargeRestrictV)];
    float dischargeRestrictV = registers[BTS_REG_IDX(eDischargeRestrictV)];
    float inputV = registers[BTS_REG_IDX(eInputVoltage)];

    for (uint16_t ch = 0; ch < NUM_CHANNELS; ch++) {
        //
        // The calibration exemption, second of two places. The guard is on
        // the INPUT BUS voltage, and a bench supply driving one slot through
        // a DMM will normally sit outside the window - without this the slot
        // would be stopped a fraction of a second after it started.
        //
        if (calSlotIsCalibrating(ch)) {
            continue;
        }
        if (slotIsRunning(ch)) {
            if (status[ch].charging && inputV <= chargeRestrictV) {
                slotStop(ch);
                updateStatusRegisters();
            }
            if (status[ch].discharging && inputV >= dischargeRestrictV) {
                slotStop(ch);
                updateStatusRegisters();
            }
        }
    }

    //
    // Reverse polarity. A cell wired backwards reads negative on the
    // external converter; stop the slot rather than try to regulate it.
    //
    for (uint16_t ch = 0; ch < NUM_CHANNELS; ch++) {
        if (BTS_measValues[ch].CellVoltage_V < BTS_REVERSE_POLARITY_V) {
            status[ch].reversePolarity = 1;
            if (status[ch].running) {
                slotStop(ch);
            }
        } else {
            status[ch].reversePolarity = 0;
        }
    }

    checkGroupIntegrity();

    calServiceDeadMan();

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

//
// Watches the slots in each group for one that has fallen out of step.
//
// In a grouped mode only the leader regulates; the followers copy its duty
// blindly. If a follower's cell is disconnected, or simply drifting, nothing
// in the control path notices - so compare each follower's own internal-ADC
// voltage against the leader's, and shut the whole group down if one strays.
//
// The tolerance is a fraction of the leader's voltage with an absolute
// floor, so it stays meaningful at both ends of the range. A disagreement
// has to persist for several passes before it counts, which rejects a single
// noisy sample without meaningfully delaying a real disconnection.
//
static void checkGroupIntegrity(void)
{
    static uint16_t vdiffCount[NUM_CHANNELS] = {0};
    uint16_t ch;

    for (ch = 0; ch < NUM_CHANNELS; ch++) {
        uint16_t leader = btsSlotLeader[ch];
        float32_t leaderV;
        float32_t limit;

        //
        // Ungrouped, disabled, or not running: nothing to compare against.
        //
        if ((btsSlotIsLeader[ch] != 0U) || (btsSlotEnabled[ch] == 0U) ||
            (slotIsRunning(ch) == 0U)) {
            vdiffCount[ch] = 0U;
            continue;
        }

        leaderV = BTS_measValues[leader].CellVoltage_V;

        limit = leaderV * BTS_GROUP_VDIFF_PCT;
        if (limit < (float32_t)0.0) {
            limit = -limit;
        }
        if (limit < BTS_GROUP_VDIFF_FLOOR_V) {
            limit = BTS_GROUP_VDIFF_FLOOR_V;
        }

        float32_t diff = BTS_measValues[ch].CellVoltage_V - leaderV;
        if (diff < (float32_t)0.0) {
            diff = -diff;
        }

        if (diff > limit) {
            vdiffCount[ch]++;
        } else {
            vdiffCount[ch] = 0U;
            continue;
        }

        if (vdiffCount[ch] < BTS_GROUP_VDIFF_DEBOUNCE) {
            continue;
        }

        //
        // Confirmed. The group shares one control loop and one load, so a
        // member that is no longer tracking makes the others unsafe too -
        // stop every slot in the group, not just the one that strayed.
        //
        {
            uint16_t m;
            for (m = 0; m < NUM_CHANNELS; m++) {
                if (btsSlotLeader[m] != leader) {
                    continue;
                }
                status[m].groupDisconnect = 1;
                slotStop(m);
                BTS_ctrlLoopVariables[m].tripFlag = 1;
                vdiffCount[m] = 0U;
            }
        }
    }
}

static void updateInputVoltage(void)
{
    ADC_forceSOC(ADCB_BASE, ADC_SOC_NUMBER1);
    ADC_forceSOC(ADCB_BASE, ADC_SOC_NUMBER2);

    //
    // Bounded wait. A conversion at ADCCLK/4 with a 15-cycle S+H takes well
    // under a microsecond, so this budget is generous; the point is that a
    // misconfigured or disabled ADCBINT1 must never wedge the task loop the
    // way an unguarded spin does - that would silently disable the input
    // voltage guard and every other supervisory check in C1().
    //
    uint16_t adcWait = 0U;
    while ((ADC_getInterruptStatus(ADCB_BASE, ADC_INT_NUMBER1) == 0) &&
           (adcWait < BTS_ADCB_EOC_MAX_POLLS)) {
        adcWait++;
    }

    if (adcWait >= BTS_ADCB_EOC_MAX_POLLS) {
        //
        // Treat a timeout as "input voltage unknown", which is the safe
        // reading: 0 V drives unitState to charge-disabled below rather
        // than leaving a stale value that looks healthy.
        //
        adcbEocTimeouts++;
        ADC_clearInterruptStatus(ADCB_BASE, ADC_INT_NUMBER1);
    }

    uint16_t busVoltageRaw = (adcWait >= BTS_ADCB_EOC_MAX_POLLS) ? 0U :
                             ADC_readResult(ADCBRESULT_BASE, ADC_SOC_NUMBER1);

    //
    // Ratiometric against the external 1.25 V on ADC-A0, so the ADC's own
    // reference cancels and never has to be assumed.
    //
    //   busVoltage = (raw / refRaw) * 1.25 V * BTS_VIN_SENSE_GAIN
    //
    // The previous form hard-coded 3.3 V for VREFHI and took the gain as
    // 17.9/2.5. Both were wrong: this controlCARD runs a 3.0 V reference, and
    // that gain ignores the sense amplifier's own attenuation. Together they
    // read ~27% high, which looked like a sensor fault rather than two
    // arithmetic errors. A0 is a genuine divider off the same reference, so
    // the ratio is exact whatever the reference actually is.
    //
    // refRaw of 0 means the reference conversion has not completed yet -
    // report 0 V rather than dividing by it, which the input-voltage guard
    // reads as "supply absent" and refuses to start a slot. That is the safe
    // direction.
    //
    uint16_t vinRefRaw = ADC_readResult(ADCARESULT_BASE, ADC_SOC_NUMBER6);
    float busVoltage = (vinRefRaw == 0U) ? 0.0f
                     : (((float)busVoltageRaw / (float)vinRefRaw)
                        * BTS_VIN_REF_VOLTS * BTS_VIN_SENSE_GAIN);

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
    //
    // ADC_readResult() takes the RESULT base (ADCxRESULT_BASE, 0x0B00..),
    // not the peripheral control base (ADCx_BASE, 0x7400..). Passing the
    // control base compiles and runs, but returns configuration registers:
    // every slot read back ADCCTL1/ADCCTL2 as if they were conversions,
    // which is where the constant 8320 (0x2080) came from.
    //
    int16_t vRaw[8] = {
        ADC_readResult(ADCARESULT_BASE, ADC_SOC_NUMBER0), // Ch1: A3
        ADC_readResult(ADCBRESULT_BASE, ADC_SOC_NUMBER0), // Ch2: B3
        ADC_readResult(ADCARESULT_BASE, ADC_SOC_NUMBER1), // Ch3: A5
        ADC_readResult(ADCARESULT_BASE, ADC_SOC_NUMBER2), // Ch4: IN15
        ADC_readResult(ADCDRESULT_BASE, ADC_SOC_NUMBER0), // Ch5: D1
        ADC_readResult(ADCCRESULT_BASE, ADC_SOC_NUMBER0), // Ch6: C3
        ADC_readResult(ADCDRESULT_BASE, ADC_SOC_NUMBER1), // Ch7: D3
        ADC_readResult(ADCCRESULT_BASE, ADC_SOC_NUMBER1)  // Ch8: C5
    };
    int16_t iRaw[8] = {
        ADC_readResult(ADCARESULT_BASE, ADC_SOC_NUMBER3), // Ch1: A2
        ADC_readResult(ADCBRESULT_BASE, ADC_SOC_NUMBER3), // Ch2: B2
        ADC_readResult(ADCARESULT_BASE, ADC_SOC_NUMBER4), // Ch3: A4
        ADC_readResult(ADCARESULT_BASE, ADC_SOC_NUMBER5), // Ch4: IN14
        ADC_readResult(ADCDRESULT_BASE, ADC_SOC_NUMBER2), // Ch5: D0
        ADC_readResult(ADCCRESULT_BASE, ADC_SOC_NUMBER2), // Ch6: C2
        ADC_readResult(ADCDRESULT_BASE, ADC_SOC_NUMBER3), // Ch7: D2
        ADC_readResult(ADCCRESULT_BASE, ADC_SOC_NUMBER3)  // Ch8: C4
    };
    int16_t refRaw = ADC_readResult(ADCARESULT_BASE, ADC_SOC_NUMBER6); // A0

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
        slotStop(channel);
        BTS_ctrlLoopVariables[channel].tripFlag = 1;

        //
        // Trips stay armed through calibration and out-rank it: a trip on
        // the slot under calibration drops it out of fixed-current here, so
        // the reference is zero before the control loop next runs.
        //
        if (BTS_userInputs[channel].calState == BTS_CAL_STATE_FIXED_I) {
            BTS_userInputs[channel].ioutCal_pu = (float32_t)0.0;
            BTS_userInputs[channel].calState   = BTS_CAL_STATE_IDLE;
            calStatusBits &= ~(1UL << BTS_CAL_ST_DRIVING);
        }

        //
        // Slots sharing a group share a load, so one tripping makes the
        // rest unsafe. Raising each peer's tripFlag brings its PWM down
        // through BTS_tripEpwm() on its next control pass, within a few
        // switching periods.
        //
        // Their trip zones are deliberately not forced here: that sets
        // the same OST flag a genuine fault raises, and this handler
        // would then read it back and report an over-current against a
        // slot whose only problem was its group-mate.
        //
        {
            uint16_t m;
            uint16_t leader = btsSlotLeader[channel];

            for (m = 0; m < NUM_CHANNELS; m++) {
                if ((m == channel) || (btsSlotLeader[m] != leader)) {
                    continue;
                }
                status[m].running = 0;
                status[m].stopped = 1;
                status[m].paused  = 0;
                BTS_userInputs[m].enable_logic = 0;
                BTS_ctrlLoopVariables[m].tripFlag = 1;
            }
        }

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
