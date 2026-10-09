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
#include "bts_cla_shared.h"
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
static void serviceTermination(void);
static void servicePreChargeBalance(void);
static void serviceDivergenceFault(void);

//
// Consecutive C1 passes each slot has satisfied its termination condition.
//
// A charge ends on a CURRENT threshold, and current is the noisiest thing
// measured here - a single sample dipping under I_MIN is not a finished
// charge. The condition has to hold for BTS_TERM_DWELL_PASSES passes in a
// row; anything failing resets the count to zero.
//
// Reset by slotStop(), slotFinish() and a fresh start, so a resumed slot
// earns its termination again from scratch rather than inheriting progress
// from before it was held.
//
static uint16_t termDwell[NUM_CHANNELS];

//
// Pre-charge balance supervisor state. All indexed by slot.
//
//   balanceDwell      consecutive passes the current condition has held, and
//                     doubles as the BALANCING / SOFT_START elapsed counter
//   softStartRetries  attempts used, against BTS_SOFT_START_MAX_RETRIES
//   softStartHold     passes still to wait out after a trip, ~100 ms
//
static uint16_t balanceDwell[NUM_CHANNELS];
static uint16_t softStartRetries[NUM_CHANNELS];
static uint16_t softStartHold[NUM_CHANNELS];
static uint16_t divergeDwell[NUM_CHANNELS];
static uint16_t softStartElapsed[NUM_CHANNELS];

//
// How long a termination condition must hold. C1 is nominally 10 Hz but was
// measured on hardware at 0.69 Hz, so this is deliberately expressed in
// PASSES rather than seconds - at the nominal rate it is ~0.5 s and at the
// measured rate ~7 s. Both are short against any real charge and long
// against measurement noise.
//
#define BTS_TERM_DWELL_PASSES  ((uint16_t)5)

//
// CLA1 - the internal-ADC telemetry filter. See bts_cla.cla.
//
static void BTS_initCla(void);
static void BTS_updateFilteredTelemetry(void);
static void BTS_refreshCellFromCla(void);

//
// 1 while CLA1 is not demonstrably advancing BTS_claRunCount. Set by
// BTS_updateFilteredTelemetry() and read by BTS_refreshCellFromCla(), which
// leaves the cell readings alone rather than fabricating a 0 V when it is
// set. Non-static so it can be watched from the debugger during bring-up.
//
volatile uint16_t claFastStale = 1U;
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

#ifdef _STANDALONE
//
// Bounded CPU2 boot - see tryBootCpu2(). Declared here because main() and
// C3() both call it and it is defined further down.
//
// Per-attempt ceiling on waiting for CPU2's ROM. CPU2 reaches SYSTEM_READY
// within microseconds of reset; by the time CPU1 gets here it has spent many
// milliseconds in its own init, so a healthy CPU2 is already waiting and
// this only ever bounds the failure case.
//
#define BTS_CPU2_BOOT_TIMEOUT_US    500000UL
#define BTS_CPU2_BOOT_POLL_US          100UL

#ifdef _FLASH
#define BTS_CPU2_BOOT_MODE   C1C2_BROM_BOOTMODE_BOOT_FROM_FLASH
#else
#define BTS_CPU2_BOOT_MODE   C1C2_BROM_BOOTMODE_BOOT_FROM_RAM
#endif

static bool tryBootCpu2(uint32_t timeoutUs);
#endif

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
// Tick at which each slot last accumulated. 0 means "no baseline" - the next
// pass establishes one and integrates nothing, so a slot can never bank the
// whole interval since boot on its first sample.
//
static uint32_t accLastTick[NUM_CHANNELS];

//
// The C tasks rotate C1 -> C2 -> C3 off one TASKC_FREQ_HZ timer, so C1 sees
// every third tick. Derived rather than written out so a change to the task
// rate carries into the integration.
//
//
// Monotonic tick for the accumulators.
//
// accTick counts C-task dispatches (C1->C2->C3), incremented once per C0()
// pass, so one tick is one TASKC period. The accumulator reads the DIFFERENCE
// between ticks rather than assuming a fixed interval, because the C chain
// does not run at its nominal rate: measured at ~1.3 Hz against a nominal
// 6.67 Hz, which made every mAh/mWh/runtime figure ~9x low.
//
#define BTS_ACC_TICK_SECONDS  ((float32_t)1.0 / (float32_t)TASKC_FREQ_HZ)

//
// Reject an implausible interval. A gap this long means the task chain
// stalled, a debugger halted the core, or a breakpoint was hit - integrating
// across it would inject a large bogus quantity. The sample is dropped and
// the timestamp re-baselined, so the counters under-report slightly rather
// than jumping.
//
#define BTS_ACC_MAX_GAP_S     ((float32_t)2.0)

volatile uint32_t accTick = 0U;

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
// Clears a slot's over-current indication: status bit 3 and its two bits in
// eTripStatus. Neither ever cleared before, so one trip left the slot showing
// a fault until the unit was power-cycled, even after it ran cleanly again.
//
// Called only where an operator hands the slot back - a fresh start,
// re-arming the pre-charge sequence, removing the cell, or an explicit
// BTS_MODE_CLEAR_FAULT - because by then the fault has been seen and the
// slot is being used again. NEVER from the trip path, never on a timer, and
// deliberately NOT on a stop: the ESP32 engine writes a stop as its first
// reaction to a trip (fail() -> bts_link_stop_channel()), so clearing there
// would wipe the fault about a second after it happened, and before
// anything on the bench had shown it.
//
// The hardware latch is already gone by then. epwmTripISR() clears the trip
// zone's flags as it handles the trip, and BTS_HAL_armTripZones() clears
// DCAEVT1 again before re-enabling it. So this only brings the reported
// state into line with the hardware, and it cannot release a trip.
//
// A trip that recurs sets everything again: the comparator is re-armed, and
// the ISR sets the bits afresh on the next over-current. And if the
// comparator is STILL asserted when the slot is re-armed, the ISR fires at
// once and the slot stops with the bits set - a persistent fault cannot be
// cleared by restarting into it.
//
static void slotClearOverCurrent(uint16_t ch)
{
    const uint32_t mask = 3UL << (ch * 2U);   // cmpss and gpio bits, as in epwmTripISR()
    bool           wasDisabled;

    status[ch].overCurrentTrip = 0;

    //
    // epwmTripISR() read-modify-writes the same word, and it can preempt any
    // task. Keep it out across the clear, or a trip on another channel could
    // write back a copy taken before this channel's bits came off.
    //
    wasDisabled = Interrupt_disableGlobal();
    cpu1Status.tripStatus &= ~mask;
    if (!wasDisabled) {
        Interrupt_enableGlobal();
    }
}

//
// Full stop. Clears the pause and END indications too, so a host that stops a
// paused slot gets a clean STOPPED rather than a mixture.
//
// It does NOT clear the over-current indication: a trip ends in a stop -
// epwmTripISR() calls this, and the ESP32 sends one straight after - and the
// fault has to outlive both. See slotClearOverCurrent().
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

    //
    // THE DIRECTION BITS ARE CLEARED HERE. They were not, and a stopped slot
    // kept whichever direction it last ran. Two things went wrong as a
    // result: the LED driver tests CHARGING|DISCHARGING above its FINISHED
    // branch, so a slot that had ever run could never show the finished
    // colour and showed idle-green through the wrong path; and a host
    // reading the status word saw a direction on a slot doing nothing.
    //
    // A pause is different and must NOT clear these - slotPause() leaves
    // them deliberately, because a resume has to know which way to go.
    //
    status[ch].charging    = 0;
    status[ch].discharging = 0;

    //
    // Leaving the pre-charge sequence too. A stop is an operator saying
    // "stand down", so the slot must not keep driving its rail; re-arming is
    // an explicit WAITING command.
    //
    status[ch].waiting   = 0;
    status[ch].balancing = 0;
    status[ch].ready     = 0;
    status[ch].softStart = 0;

    btsSlotPreCharging[ch] = 0U;

    termDwell[ch] = 0U;
    balanceDwell[ch] = 0U;
    softStartRetries[ch] = 0U;
}

//
// ==================== Pre-charge balance lifecycle ====================
//
// Arms a slot to watch for a cell approaching its contacts. The converter
// stays off - WAITING only watches.
//
static void slotWait(uint16_t ch)
{
    BTS_ctrlLoopVariables[ch].ioutRef_pu = (float32_t)0.0;
    BTS_ctrlLoopVariables[ch].voutRef_pu = (float32_t)0.0;
    BTS_userInputs[ch].enable_logic = 0;

    status[ch].running   = 0;
    status[ch].stopped   = 0;
    status[ch].finished  = 0;
    status[ch].paused    = 0;
    status[ch].wdTripped = 0;
    status[ch].restored  = 0;

    status[ch].waiting   = 1;
    status[ch].balancing = 0;
    status[ch].ready     = 0;
    status[ch].softStart = 0;

    btsSlotPreCharging[ch] = 0U;
    termDwell[ch] = 0U;
    balanceDwell[ch] = 0U;
    softStartRetries[ch] = 0U;
}

//
// Begin driving the output capacitors toward the ADS reading.
//
// enable_logic goes to 1 because the converter genuinely runs here - which is
// also what arms the trip system for this slot, and that is wanted: balancing
// drives real current into real capacitance and every protection should be
// live, exactly as it is for a running slot.
//
static void slotBalance(uint16_t ch)
{
    status[ch].waiting   = 1;
    status[ch].balancing = 1;
    status[ch].ready     = 0;
    status[ch].softStart = 0;

    //
    // Hand the control ISR the balancing duty path BEFORE enabling the
    // stage, so the first pass after enable_logic goes high is already a
    // balance step and never a stale control-loop output.
    //
    btsSlotPreCharging[ch] = 1U;
    BTS_userInputs[ch].enable_logic = 1;

    balanceDwell[ch] = 0U;
}

//
// Rails matched. The converter is parked - not driving, but still armed.
//
// This is NOT a latch. An unloaded output capacitor drifts, so the supervisor
// re-checks every pass and drops back to BALANCING if the differential
// re-opens while the operator is still seating the cell.
//
static void slotReady(uint16_t ch)
{
    BTS_ctrlLoopVariables[ch].ioutRef_pu = (float32_t)0.0;
    BTS_ctrlLoopVariables[ch].voutRef_pu = (float32_t)0.0;
    BTS_userInputs[ch].enable_logic = 0;

    status[ch].waiting   = 1;
    status[ch].balancing = 0;
    status[ch].ready     = 1;
    status[ch].softStart = 0;

    btsSlotPreCharging[ch] = 0U;
    balanceDwell[ch] = 0U;
}

//
// Ends one slot because its test COMPLETED, as distinct from slotStop()'s
// "something halted it".
//
// The converter is shut down identically - same references zeroed, same
// enable dropped - but the status is the other way round: finished is set
// and stopped is left clear, so a host can tell a charge that reached its
// termination current from one an operator stopped, a trip stopped, or the
// watchdog paused. status[].finished is bit 2, BTS_STATUS_END.
//
// Nothing cleared it until now except a fresh start (see the register write
// handler), and that is deliberate: END persists until the slot is started
// again, which is what makes the next termination distinguishable from this
// one.
//
static void slotFinish(uint16_t ch)
{
    BTS_ctrlLoopVariables[ch].ioutRef_pu = (float32_t)0.0;
    BTS_ctrlLoopVariables[ch].voutRef_pu = (float32_t)0.0;
    BTS_userInputs[ch].enable_logic = 0;

    status[ch].running   = 0;
    status[ch].stopped   = 0;
    status[ch].finished  = 1;
    status[ch].paused    = 0;
    status[ch].wdTripped = 0;
    status[ch].restored  = 0;

    //
    // A completed test keeps its direction bit, unlike a stop: a host wants
    // to know which way the run that just ended was going.
    //
    // The pre-charge state is dropped, though. The cell that just finished is
    // still in the holder, so the slot is not waiting for anything; the
    // supervisor re-arms WAITING once it sees that cell removed.
    //
    status[ch].waiting   = 0;
    status[ch].balancing = 0;
    status[ch].ready     = 0;
    status[ch].softStart = 0;

    btsSlotPreCharging[ch] = 0U;

    termDwell[ch] = 0U;
    balanceDwell[ch] = 0U;
    softStartRetries[ch] = 0U;
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

        //
        // Re-arm a slot that was armed when power went away. Only the WAITING
        // bit is restored - the supervisor works out within a few passes
        // whether a cell is present and where in the sequence the slot
        // belongs, from readings that are current rather than remembered.
        //
        if ((f & BTS_STATE_F_WAITING) != 0UL) {
            status[ch].waiting = 1U;
            status[ch].stopped = 0U;
        }

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
        cpu1Status.calTelemetry[6] = m->CellVoltageFilt_V;
        cpu1Status.calTelemetry[7] = m->CellCurrentFilt_I;
    }
}

//
// Bring CLA1 up on the internal-ADC telemetry filter. See bts_cla.cla.
//
// Must run after BTS_HAL_setupDevice() - that is what copies the Cla1Prog
// image out of flash into RAMLS4 - and after BTS_HAL_setupADC(), which arms
// ADCA INT2 on SOC6 with Interrupt_disable(INT_ADCA2) so the flag reaches
// CLA1 and nothing else.
//
// CLA1's peripheral clock is already on: Device_enableAllPeripherals()
// enables SYSCTL_PERIPH_CLK_CLA1 (device/device.c:175).
//
static void BTS_initCla(void)
{
    //
    // LS4 = CLA program, LS5 = CLA data.
    //
    // Order matters. TI's own cla_asin_cpu01.c sets the controller select
    // (LSxMSEL) FIRST and the program/data select (LSxCLAPGM) second; doing
    // it the other way round can leave the block handed to the CLA while it
    // is still typed as data, and the fetch aborts.
    //
    MemCfg_setLSRAMControllerSel(MEMCFG_SECT_LS4,
                                 MEMCFG_LSRAMCONTROLLER_CPU_CLA1);
    MemCfg_setCLAMemType(MEMCFG_SECT_LS4, MEMCFG_CLA_MEM_PROGRAM);

    MemCfg_setLSRAMControllerSel(MEMCFG_SECT_LS5,
                                 MEMCFG_LSRAMCONTROLLER_CPU_CLA1);
    MemCfg_setCLAMemType(MEMCFG_SECT_LS5, MEMCFG_CLA_MEM_DATA);

    //
    // All eight vectors are mapped even though only task 1 is enabled. An
    // unmapped MVECT holds whatever the reset value was; if a stray trigger
    // ever reached a task with a garbage vector the CLA would fetch from a
    // random address. bts_cla.cla defines empty bodies for tasks 2-8 for
    // exactly this reason.
    //
    // The (uint16_t) casts are what --diag_suppress=770 is for: MVECTn holds
    // a 16-bit CLA program address, and the CLA program space is entirely
    // below 0x10000, so the narrowing is correct here.
    //
    CLA_mapTaskVector(CLA1_BASE, CLA_MVECT_1, (uint16_t)&Cla1Task1);
    CLA_mapTaskVector(CLA1_BASE, CLA_MVECT_2, (uint16_t)&Cla1Task2);
    CLA_mapTaskVector(CLA1_BASE, CLA_MVECT_3, (uint16_t)&Cla1Task3);
    CLA_mapTaskVector(CLA1_BASE, CLA_MVECT_4, (uint16_t)&Cla1Task4);
    CLA_mapTaskVector(CLA1_BASE, CLA_MVECT_5, (uint16_t)&Cla1Task5);
    CLA_mapTaskVector(CLA1_BASE, CLA_MVECT_6, (uint16_t)&Cla1Task6);
    CLA_mapTaskVector(CLA1_BASE, CLA_MVECT_7, (uint16_t)&Cla1Task7);
    CLA_mapTaskVector(CLA1_BASE, CLA_MVECT_8, (uint16_t)&Cla1Task8);

    //
    // IACKE lets software force a task with CLA_forceTasks(); harmless here
    // and useful for bringing the filter up on the bench without the ADC.
    //
    CLA_enableIACK(CLA1_BASE);
    CLA_enableTasks(CLA1_BASE, CLA_TASKFLAG_1);

    //
    // ADCA INT2 fires at the end of SOC6, the last conversion in the sweep,
    // so task 1 sees all seventeen results already latched. INT_ADCA2 is
    // disabled at the PIE, so this flag has exactly one consumer.
    //
    CLA_setTriggerSource(CLA_TASK_1, CLA_TRIGGER_ADCA2);
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
    // Start CLA1 filtering the internal ADC. Telemetry only - the control
    // loop and the protection paths keep reading the unfiltered samples.
    //
    BTS_initCla();

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
    //
    // Latch the slot-tuning selection BEFORE anything reads it: the SCIA
    // ownership decision below, BTS_initSlotGrouping() and the ePWM phase
    // setup all branch on it.
    //
    // The slot under test comes from the ENABLE straps. ENABLE normally
    // means "highest enabled slot", but in a tuning mode there is only one
    // slot under test, so the same three pins name it directly.
    //
    //
    // THE BUILD GETS A VETO, not just the strap.
    //
    // btsSfraActive gates whether CPU1 keeps SCIA for the SFRA GUI. In a
    // build with no SFRA library compiled in there is nothing to keep it
    // FOR - and keeping it strands the port: CPU1 never calls
    // SysCtl_selectCPUForPeripheral(), so CPU2's LED driver writes to a
    // peripheral it does not own and every SCIA register reads back zero.
    //
    // That is not hypothetical. Observed on hardware 2026-10-02 with the LED
    // string connected and dark: the MODE straps were open, pull-ups made
    // them read 0b111, truth_table[7] decoded that to mode 7
    // (eModeSfraAds131Closed), btsSfraActive latched to 1, and SCIA was held
    // by a core with no SFRA code in it. Pin muxing and GPIO ownership were
    // both correct, which is what made it hard to see.
    //
    // BTS_SFRA_ENABLED is a compile-time constant, so in a production build
    // this whole expression folds to 0 and the strap cannot strand the port.
    //
    btsSfraActive = (BTS_SFRA_ENABLED == true) &&
                    BTS_MODE_IS_SFRA((uint16_t)startup_mode) ? 1U : 0U;
    btsSfraSlot   = (uint16_t)startup_enable & 0x7U;

    BTS_initSlotGrouping((uint16_t)startup_mode, (uint16_t)startup_enable);
    BTS_HAL_setupGroupPhase(BTS_MODE_GROUP_SIZE((uint16_t)startup_mode));

    //
    // Route the over-current comparators to the trip zones, grouped to match
    // the same strap. This cannot happen in BTS_HAL_setupTripSystem() with
    // the rest of the trip plumbing: that runs inside BTS_HAL_setupDevice(),
    // before BTS_HAL_setupGPIO() has even configured the strap pins as
    // inputs, so the grouping is not known yet.
    //
    // The trips are configured here but left DISARMED - see
    // BTS_HAL_armTripZones() and serviceTripArming() for why arming waits.
    //
    BTS_HAL_setupTripRouting(BTS_MODE_GROUP_SIZE((uint16_t)startup_mode),
                             (uint16_t)startup_enable);

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
    //
    // Seed the tuning registers from the compile-time BTS_DCL_* constants
    // BEFORE the controllers are built, so a unit that has never been tuned
    // - or whose F-RAM record fails to validate - starts on the shipped
    // tuning rather than on a zeroed registers[], which would give every
    // biquad a constant-zero output and leave no slot able to regulate.
    //
    // CPU2's F-RAM reload arrives later over IPC and overwrites these.
    //
    BTS_seedSlotTuningRegisters();
    BTS_initController();

    //
    // DELIBERATELY NOT calling BTS_applySlotTuning() here.
    //
    // registers[] lives in CPU2TOCPU1RAM and is populated by CPU2, which at
    // this point in CPU1's boot has not run yet - the block still reads all
    // zeros. BTS_initController() has just installed valid coefficients from
    // the compile-time BTS_DCL_* constants, and applying a zeroed register
    // block over the top would replace them with a biquad that outputs a
    // constant zero, leaving no slot able to regulate.
    //
    // CPU2 seeds the defaults, loads any stored tuning over them, and then
    // raises BTS_IPC_FLAG_CAL_RELOAD. The apply happens there, by which time
    // the registers hold real values. A host write to any tuning register
    // re-applies as well.
    //
    // Found on hardware 2026-10-02: the controllers read 0.0 at runtime
    // while registers[] held the correct values, because this call ran
    // before CPU2 had written them.
    //

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
    //
    // ADCA INT1 is NOT enabled in the PIE. The internal ADC now triggers 1:1
    // with EPWM1 at 99.67 kHz, and the CLA consumes every sweep; a C28x ISR
    // at that rate would be an interrupt every 10.03 us on a core already
    // running the control loops off the ADS131M08 DRDY interrupts.
    //
    // adcCellVoltageISR() is still registered so the vector is valid and the
    // handler can be re-enabled from the debugger for a bring-up check, but
    // nothing calls it in normal operation. See BTS_HAL_setupADC() for the
    // ADC-side half of this, and bts_cla.cla for what replaced it.
    //
    Interrupt_register(INT_ADCA1, &adcCellVoltageISR);
    Interrupt_disable(INT_ADCA1);

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
    // THE STRAP DECIDES, not the build. btsSfraActive was latched from
    // startup_mode a few lines above, so a tuning binary hands SCIA to CPU1
    // only when the operator actually strapped a slot-tuning mode; strapped
    // to anything else it gives SCIA to CPU2 and the console and LED driver
    // work normally. That is the whole point of making SFRA runtime: one
    // binary, and the sweep costs nothing until it is asked for.
    //
    // This cannot be changed after boot. CPUSEL is a one-shot ownership
    // write, which is exactly why the selection rides on the MODE strap -
    // itself latched once at reset - rather than on a host register.
    //
    if (btsSfraActive == 0U) {
        SysCtl_selectCPUForPeripheral(SYSCTL_CPUSEL5_SCI, 1, SYSCTL_CPUSEL_CPU2); // SCIA
    }

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
    // output in production.
    //
    // GPIO28 goes to CPU2 only when it is the console RX. Keyed on the
    // console rather than on BTS_TRIP_GPIO_CH1_ENABLED, which is now always
    // false - testing the trip macro would have handed GPIO28 to CPU2 in
    // every build, including production where nothing on CPU2 uses it.
    //
    GPIO_setControllerCore(29, GPIO_CORE_CPU2);
#if (BTS_CONSOLE_ENABLED == true)
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
    // Standalone builds only. Under CCS the debugger loads and starts CPU2
    // itself.
    //
    // This used to be a plain Device_bootCPU2() call, which spins with no
    // timeout until CPU2's boot ROM reports ready - so a CPU2 that never got
    // there stalled CPU1 here, before its background loop, with no control
    // tasks, no supervision and no trip arming. tryBootCpu2() makes one
    // bounded attempt; if CPU2 is not ready, CPU1 carries on and C3 retries.
    // See the note above tryBootCpu2().
    //
    // This mirrors TI's own project configurations, where _STANDALONE is a
    // separate build config from plain _FLASH (see the C2000Ware dual-core
    // examples, e.g. led_ex1_blinky.projectspec).
    //
#ifdef _STANDALONE
    (void)tryBootCpu2(BTS_CPU2_BOOT_TIMEOUT_US);
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
        // Regulation mode, bits 6 and 7. The ISR has tracked ctrlMode_logic
        // all along; it simply was never copied here until the CCCV work.
        //
        // BOTH BITS ARE CLEAR UNLESS THE SLOT IS ACTUALLY REGULATING.
        //
        // ctrlMode_logic is 0 on an idle slot as well as on a slot running
        // in constant current, so testing it alone made every stopped slot
        // publish CONST_CURRENT. Observed on hardware: an empty slot 1 read
        // status 0x80 with running == 0, which a host would show as "in CC"
        // on a slot doing nothing.
        //
        // These bits report what the LOOP is doing, so they only mean
        // anything while the loop is closed.
        //
        if (slotIsRunning(ch)) {
            status[ch].constVoltage =
                (BTS_ctrlLoopVariables[ch].ctrlMode_logic != 0U) ? 1U : 0U;
            status[ch].constCurrent =
                (BTS_ctrlLoopVariables[ch].ctrlMode_logic == 0U) ? 1U : 0U;
        } else {
            status[ch].constVoltage = 0U;
            status[ch].constCurrent = 0U;
        }

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
        bitset |= (status[ch].waiting & 0x1) << BTS_STATUS_WAITING;
        bitset |= (status[ch].balancing & 0x1) << BTS_STATUS_BALANCING;
        bitset |= (status[ch].ready & 0x1) << BTS_STATUS_READY;
        bitset |= (status[ch].softStart & 0x1) << BTS_STATUS_SOFT_START;
        bitset |= (status[ch].wdTripped & 0x1) << BTS_STATUS_WD_TRIPPED;
        bitset |= (status[ch].restored & 0x1) << BTS_STATUS_RESTORED;
        cpu1Status.statusBits[ch] = bitset;

        cpu1Status.cellVoltage[ch] = BTS_measValues[ch].CellVoltageFilt_V;
        cpu1Status.cellCurrent[ch] = BTS_measValues[ch].CellCurrentFilt_I;

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
        canData[ch].voltage = BTS_measValues[ch].CellVoltageFilt_V;
        canData[ch].current = BTS_measValues[ch].CellCurrentFilt_I;
        //
        // CAN carries the total for the direction the slot is set to, so a
        // listener sees the figure for the test in progress.
        //
        canData[ch].mAh = status[ch].charging ? accChargeMah[ch] : accDischargeMah[ch];
        canData[ch].mWh = status[ch].charging ? accChargeMwh[ch] : accDischargeMwh[ch];

        //
        // Run state for the frame's byte 0. Reduced here rather than on CPU2
        // because ChannelStatus is this core's; re-deriving it from the
        // packed status word on the other side would be a second encoding of
        // the same thing, free to drift.
        //
        // Direction is reported whenever the slot holds one, INCLUDING while
        // paused - a resume goes back to that direction, so a listener that
        // saw only PAUSED would not know which way. This mirrors the status
        // word, where RUNNING and the direction bit both survive a pause.
        //
        {
            uint16_t canState = 0U;

            if (status[ch].running) {
                canState |= status[ch].charging ? BTS_CAN_STATE_CHARGING
                                                : BTS_CAN_STATE_DISCHARGING;
            }
            if (status[ch].paused) {
                canState |= BTS_CAN_STATE_PAUSED;
            }

            //
            // FAULT is anything that blocks the slot from acting, which is a
            // wider set than an over-current trip:
            //
            //   overCurrentTrip   the software trip in BTS_tripEpwm()
            //   reversePolarity   cell wired backwards; the slot is stopped
            //   groupDisconnect   a group member stopped tracking, so every
            //                     slot in that group was stopped with it
            //   slotDisabled      masked off by the ENABLE strap at power-on
            //
            // All four mean the same thing to a listener: this slot will not
            // run, and asking it to will not change that. They are separable
            // through the status word for a host that needs to know which.
            //
            if (status[ch].overCurrentTrip || status[ch].reversePolarity ||
                status[ch].groupDisconnect || status[ch].slotDisabled) {
                canState |= BTS_CAN_STATE_FAULT;
            }

            canData[ch].state = canState;
        }
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


//
// ============================================================================
// CPU2 boot, bounded and non-blocking
// ============================================================================
//
// driverlib's Device_bootCPU2() spins with NO timeout until CPU2's boot ROM
// reports C2_BOOTROM_BOOTSTS_SYSTEM_READY. If that never happens CPU1 hangs
// right there - before its background loop starts, so the control tasks, the
// slot supervision and the trip arming all never run. A dead comms core must
// not be allowed to take the control core down with it.
//
// This does the same handshake as Device_bootCPU2() but never waits longer
// than BTS_CPU2_BOOT_TIMEOUT_US per attempt. If CPU2's ROM is not ready yet,
// CPU1 carries on into its background loop and retries from the C3 task
// (~6.7 Hz) until it gets through. Every step here matches Device_bootCPU2()
// in device/device.c exactly - only the waits differ - so the two cannot
// disagree about the protocol.
//
// WHAT THIS DOES NOT FIX: a cold power-up with the XDS100 attached. If the
// probe holds TRSTn high at reset, CPU1's own boot ROM takes the emulation
// path (SelectMode_Boot.c), finds the EMU key at 0x0D00 cleared by the
// power-on RAM init, and parks in WAIT_BOOT. This code never runs at all in
// that case - it is decided in ROM. Unplug the probe for a standalone boot,
// or let CCS start the cores.
//
// Only the FLASH and RAM boot modes are used here, and neither needs the pin
// muxing Device_bootCPU2() does for the peripheral bootloaders, so that part
// is not reproduced.
//
#if defined(_STANDALONE)

typedef enum {
    eCpu2BootPending  = 0,   // not yet commanded, or a command was lost
    eCpu2BootSent     = 1,   // command issued, waiting for the ROM's ACK
    eCpu2BootAlready  = 2,   // CPU2 was already booted (e.g. by CCS)
    eCpu2BootAcked    = 3,   // ROM acknowledged and branched to flash
} BTS_cpu2BootState;

static BTS_cpu2BootState cpu2BootState = eCpu2BootPending;
static uint32_t          cpu2BootAttempts = 0UL;

//
// C3 passes to wait for the ROM's ACK before treating a sent command as lost
// and sending it again. C3 runs at ~6.7 Hz, so 10 passes is ~1.5 s - orders of
// magnitude longer than the ROM takes to service the command.
//
#define BTS_CPU2_ACK_WAIT_PASSES   10U
static uint16_t          cpu2AckWait = 0U;

//
// True once CPU2's ROM has acknowledged a boot command.
//
static bool cpu2AlreadyBooted(void)
{
    uint32_t sts = HWREG(IPC_BASE + IPC_O_BOOTSTS);

    return ((sts & 0x0000000FUL) == C2_BOOTROM_BOOTSTS_C2TOC1_BOOT_CMD_ACK) &&
           ((sts & 0x80000000UL) != 0UL);
}

//
// One bounded attempt. Returns true once CPU2 has been commanded (or was
// already running), false if its ROM was not ready inside the timeout.
//
static bool tryBootCpu2(uint32_t timeoutUs)
{
    uint32_t waited = 0UL;

    if ((cpu2BootState == eCpu2BootAcked) ||
        (cpu2BootState == eCpu2BootAlready)) {
        return true;
    }

    //
    // A command has gone out: confirm it actually landed.
    //
    // Sending the command is not the same as CPU2 booting. CPU2's ROM handles
    // it inside its IPC interrupt, and only reports C2TOC1_BOOT_CMD_ACK once
    // it has resolved the flash entry and is about to branch there. Observed
    // 2026-10-08 with the debugger attached: the ROM consumed the command
    // flag (IPCFLG back to 0) but BOOTSTS went back to SYSTEM_READY rather
    // than ACK, and CPU2 stayed parked in ROM with I2CA never configured.
    // This state machine used to record Sent and stop there, so that boot was
    // lost for good. Now a command that is not acknowledged in time is sent
    // again.
    //
    if (cpu2BootState == eCpu2BootSent) {
        if (cpu2AlreadyBooted()) {
            cpu2BootState = eCpu2BootAcked;
            return true;
        }
        if (++cpu2AckWait < BTS_CPU2_ACK_WAIT_PASSES) {
            return true;
        }
        //
        // No ACK. Fall through and resend - but only once the ROM is back at
        // SYSTEM_READY, which the wait below checks. Anything else means the
        // ROM is still busy with the last command and must be left alone.
        //
        cpu2AckWait   = 0U;
        cpu2BootState = eCpu2BootPending;
    }

    cpu2BootAttempts++;

    //
    // Already booted - by CCS, or by a previous attempt that this state
    // somehow missed. Sending a second boot command would be refused by
    // the ROM anyway; record it and stop.
    //
    if (cpu2AlreadyBooted()) {
        cpu2BootState = eCpu2BootAlready;
        return true;
    }

    //
    // Wait for CPU2's ROM to be ready to accept a command. This is the loop
    // Device_bootCPU2() runs with no limit.
    //
    //
    // The low nibble must be exactly SYSTEM_READY. Masking with it, as
    // Device_bootCPU2() does, also passes on 3 (ACK) - harmless there, but
    // here it would send a second command into a ROM that has just branched.
    //
    while ((HWREG(IPC_BASE + IPC_O_BOOTSTS) & 0x0000000FUL) !=
           C2_BOOTROM_BOOTSTS_SYSTEM_READY) {
        if (waited >= timeoutUs) {
            return false;
        }
        DEVICE_DELAY_US(BTS_CPU2_BOOT_POLL_US);
        waited += BTS_CPU2_BOOT_POLL_US;
    }

    //
    // The ROM takes the command through IPC flags 0 and 31. Both must be
    // clear. Flag 0 doubles as BTS_IPC_FLAG_REG_WRITE, but nothing on CPU2
    // can raise it before CPU2 is running, so it is clear here in practice.
    //
    while (((HWREG(IPC_BASE + IPC_O_FLG) & IPC_FLG_IPC0)  != 0UL) ||
           ((HWREG(IPC_BASE + IPC_O_FLG) & IPC_FLG_IPC31) != 0UL)) {
        if (waited >= timeoutUs) {
            return false;
        }
        DEVICE_DELAY_US(BTS_CPU2_BOOT_POLL_US);
        waited += BTS_CPU2_BOOT_POLL_US;
    }

    HWREG(IPC_BASE + IPC_O_BOOTMODE) = BTS_CPU2_BOOT_MODE;
    HWREG(IPC_BASE + IPC_O_SENDCOM)  = BROM_IPC_EXECUTE_BOOTMODE_CMD;
    HWREG(IPC_BASE + IPC_O_SET)      = 0x80000001UL;

    cpu2BootState = eCpu2BootSent;
    return true;
}

#endif  // _STANDALONE


//
// Seeds the converter's duty before the gate drive is enabled.
//
// WHY THIS EXISTS: without it a slot starts every run from 0% duty.
//
// For a CHARGE that is harmless - the output is the cell, the energy flows
// into it, and starting at zero duty means starting at zero current and
// ramping up. That is why a 1 A charge ran for the life of the project with
// nothing to show a problem.
//
// For a DISCHARGE into anything that holds the node up - a bench supply, or
// a cell - 0% is the WORST case, not the safe one. This is a synchronous
// buck: in discharge, with current below the reverse-current threshold,
// BTS_ctrlDirection() drives dutyH and dutyL from the same dutySet_pu
// (bts.h:588), so a high side at ~0% means the low side is effectively on
// across a node something else is holding at Vout. The whole of Vout then
// sits across the inductor in the direction that drives current INTO the
// slot.
//
// Measured on hardware 2026-10-02: slot 1 at 3.492 V from a bench supply,
// 14.41 V input, IMAX 0.1 A. Required duty Vout/Vin = 24.2%; actual 0%. The
// CMPSS low comparator latched its -9.5 A one-shot (COMPSTS bit 9,
// TZOSTFLG = 0x0040 DCAEVT1) the instant the slot enabled, while the
// measured current was 8 mA. The trip was correct and the firmware was not.
//
// WHAT IS SEEDED. A buck's steady-state duty is Vout/Vin, so that is the
// feed-forward term. It is not enough to write it to dutySet_pu alone: the
// CC controller is a biquad that integrates, and it would start from its own
// state and drag the duty back. So the biquad's state is preloaded too.
//
// The preload is exact rather than approximate, and the arithmetic matters:
//
//   DCL_runDF22_C4 computes  uk = ek*b0 + x1
//                            x1 = ek*b1 + x2 - uk*a1
//                            x2 = ek*b2      - uk*a2
//
// At t = 0 no current is flowing yet, so the current error ek is ~0 and
// uk reduces to x1. Setting x1 = D makes the very first control effort the
// feed-forward duty. For the SECOND pass to hold it as well, x2 must satisfy
// both x1 = x2 - D*a1 and x2 = -D*a2, which is consistent only when
// 1 + a1 + a2 == 0 - the condition for a pole at z = 1.
//
// The shipped CC coefficients have exactly that: a1 = -1.96058023,
// a2 = +0.96058023, sum with 1 is 0.0 to the last bit. The controller IS an
// integrator, so x1 = D with x2 = -D*a2 sits the loop at duty D with zero
// error and no step on any subsequent pass.
//
// If a future retune breaks that condition the seed still removes the
// inrush - x1 = D is what the first edge uses - and the loop converges from
// a sane duty rather than from zero. It degrades, it does not become unsafe.
//
// Vsense_V is used rather than CellVoltage_V because Vsense_V is the
// ADS131M08, which is the converter's own regulated node and is separately
// calibrated. CellVoltage_V is the 12-bit internal ADC.
//
static void BTS_seedConverterDuty(uint16_t ch)
{
    float32_t vin  = registers[BTS_REG_IDX(eInputVoltage)];
    float32_t vout = BTS_measValues[ch].Vsense_V;
    float32_t duty;

    //
    // No input, or a node that is not holding any voltage, means there is
    // nothing to feed forward from. Leaving the duty at zero is correct in
    // that case: with no output voltage there is no reverse-current path to
    // guard against, which is the ordinary empty-slot start.
    //
    if ((vin <= (float32_t)0.0) || (vout <= (float32_t)0.0)) {
        BTS_userInputs[ch].dutyRef_pu = (float32_t)0.0;
        return;
    }

    duty = vout / vin;

    //
    // Clamped to the same band the control effort is clamped to, so the seed
    // can never ask for a duty the loop would immediately reject.
    //
    if (duty > BTS_DUTY_SET_MAX_PU) {
        duty = BTS_DUTY_SET_MAX_PU;
    }
    if (duty < BTS_DUTY_SET_MIN_PU) {
        duty = BTS_DUTY_SET_MIN_PU;
    }

    BTS_userInputs[ch].dutyRef_pu = duty;

    //
    // The biquad is NOT preloaded here, and the first version of this
    // function was wrong to try.
    //
    // BTS_tripEpwm() zeroes ctrl_cc->x1 and x2 on every control pass while
    // tripFlag is set, and tripFlag is set for the whole time a slot is idle.
    // At 100 kHz a preload written here is erased thousands of times over
    // before the gate drive enables. Confirmed on hardware 2026-10-02: the
    // duty reached dutySetRef_pu correctly at 0.2395, x1 read 0.0, and the
    // slot tripped exactly as it had before.
    //
    // dutyRef_pu propagates to dutySetRef_pu through BTS_updateReference(),
    // and the ISR applies it at the trip-release edge instead.
    //
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
        //
        // Arm the pre-charge sequence. Reachable from STOPPED or END only:
        // a running slot is already past this, and a paused one resumes
        // rather than re-arming.
        //
        // The stored-calibration requirement was REMOVED on 2026-10-02 at the
        // operator's direction: the shipped per-channel defaults are
        // pre-calibrated and correct for this hardware, so a slot with no
        // F-RAM record still has a meaningful differential between its two
        // sense paths. A forced calibration step will be reintroduced later.
        //
        // The original reasoning is kept because it still describes the real
        // risk: this sequence drives the power stage from the difference
        // between the two sense paths, so if the defaults are ever wrong for
        // a board, this is the path that will act on it. It is safe here
        // because both paths were verified against an external reference on
        // slot 1 - the ADS131M08 read 3.48 V and the internal ADC 3.53 V
        // against an applied 3.492 V.
        //
        //
        // Fault acknowledgement. An edge command, handled first and not
        // retained, like pause and resume.
        //
        // Clears the latched fault indicators once a host has seen them: the
        // over-current indication and the group-disconnect bit. Reverse
        // polarity is not latched - C1() re-measures it every pass - so it
        // is left alone. Carried across the group, as every command is.
        //
        // A member that is driving is skipped. A trip stops the slot, so a
        // driving slot has nothing to acknowledge.
        //
        // WHY THIS EXISTS. The ESP32 test engine will not start a slot whose
        // trip bit is set - its safety check runs before the slot is ever
        // powered - while the indication otherwise clears only on a fresh
        // start. So a tripped slot could never be run through the engine
        // again. The engine sends this when an operator clears its fault.
        //
        if (mode & BTS_MODE_CLEAR_FAULT) {
            uint16_t m;
            for (m = 0; m < NUM_CHANNELS; m++) {
                if ((btsSlotLeader[m] != channel) || (btsSlotEnabled[m] == 0U)) {
                    continue;
                }
                if (status[m].running || status[m].balancing ||
                    status[m].softStart) {
                    continue;
                }
                slotClearOverCurrent(m);
                status[m].groupDisconnect = 0;
            }
            updateStatusRegisters();
            return;
        }

        if (mode & BTS_MODE_WAITING) {
            if (status[channel].running || status[channel].paused) {
                return;
            }

            {
                uint16_t m;
                for (m = 0; m < NUM_CHANNELS; m++) {
                    if ((btsSlotLeader[m] == channel) &&
                        (btsSlotEnabled[m] != 0U)) {
                        //
                        // Re-arming is the operator taking the slot back,
                        // so a past over-current comes off here.
                        //
                        slotClearOverCurrent(m);
                        slotWait(m);
                    }
                }
            }
            updateStatusRegisters();
            return;
        }

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
            //
            // The limits are direction-agnostic since the 2026-09-22 register
            // compression: the mode register already selects charge or
            // discharge, so one voltage pair and one current pair serves
            // both and there is nothing to choose between here.
            //
            uint16_t regBase = BTS_SET_BASE(channel);

            //
            // THE CURRENT SETTINGS BELONG TO THE GROUP, NOT TO THE SLOT.
            //
            // Group members are wired in PARALLEL, so the leader's register
            // holds the total current for the whole group and each slot
            // carries its share of it: a group of two set to 6 A runs 3 A per
            // slot, a group of four runs 1.5 A, a group of eight 0.75 A.
            //
            // Voltage is NOT divided, for the same reason - parallel slots
            // all sit at the same voltage, so each one's limits are the
            // group's limits unchanged.
            //
            // The accumulators are likewise per slot and undivided: each slot
            // measures the current it actually carried, so a host wanting the
            // group's charge sums its members. That is also what makes the
            // division safe to get wrong in only one direction - an
            // over-divided reference under-delivers current, it does not
            // over-deliver it.
            //
            // btsGroupMembers is never zero, so this cannot divide by zero.
            //
            float32_t groupShare = (float32_t)1.0 /
                                   (float32_t)btsGroupMembers[channel];

            status[channel].running   = 1;
            status[channel].stopped   = 0;
            status[channel].paused    = 0;
            status[channel].wdTripped = 0;
            status[channel].restored  = 0;

            BTS_userInputs[channel].vref_charge_V    = registers[regBase + BTS_SET_V_MAX];
            BTS_userInputs[channel].vref_discharge_V = registers[regBase + BTS_SET_V_MIN];
            BTS_userInputs[channel].iref_A           = registers[regBase + BTS_SET_I_MAX] * groupShare;
            BTS_userInputs[channel].iref_cuttout_A   = registers[regBase + BTS_SET_I_MIN] * groupShare;
            BTS_userInputs[channel].direction_logic  = status[channel].charging;

            //
            // Seed the duty BEFORE enable_logic goes high - the next control
            // ISR acts on enable_logic, so anything set after it is already
            // a pass late and the first PWM edge has gone out at 0%.
            //
            BTS_seedConverterDuty(channel);

            BTS_userInputs[channel].enable_logic     = 1;

            //
            // A fresh start - STOPPED->run or END->run. This is the only
            // place a counter set is zeroed, and only the starting
            // direction's set. Clearing END here is what makes the next
            // termination distinguishable from this one.
            //
            status[channel].finished = 0;
            termDwell[channel] = 0U;
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

                //
                // The pre-charge state travels too. The members' outputs are
                // paralleled onto one physical rail, so they balance and soft
                // start as one converter - a host must not see the leader
                // balancing while its members read idle.
                //
                status[m].waiting     = status[channel].waiting;
                status[m].balancing   = status[channel].balancing;
                status[m].ready       = status[channel].ready;
                status[m].softStart   = status[channel].softStart;

                //
                // The leader's iref_A is ALREADY its per-slot share, so this
                // copies rather than divides again. Voltage passes through
                // untouched: parallel slots share a voltage, not a current.
                //
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
                    //
                    // A fresh start hands the slot back, so a past
                    // over-current comes off here - see
                    // slotClearOverCurrent() for why a stop does not.
                    //
                    slotClearOverCurrent(m);
                }
            }
            if (status[channel].running) {
                status[channel].groupDisconnect = 0;
                slotClearOverCurrent(channel);
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
        } else if ((regIdx >= BTS_REG_IDX(BTS_TUNING_BASE_ADDR)) &&
                   (regIdx <  BTS_REG_IDX(BTS_TUNING_BASE_ADDR) +
                              BTS_TUNING_COUNT)) {
            //
            // A slot-tuning coefficient changed. Push the whole block into
            // every controller rather than the single field - the biquad is
            // only meaningful as a set, and a host writing five coefficients
            // one at a time would otherwise run four passes with a mixed
            // tuning installed.
            //
            // This decode is NOT optional. The tuning block sits above the
            // unit registers, so without a branch here the index falls
            // outside every other test, the IPC flag is acked, and the write
            // is accepted by CPU2 and silently dropped - registers[] would
            // show the new value while the controllers kept the old one.
            //
            BTS_applySlotTuning();
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
        //
        // The same reload carries the slot tuning: CPU2 restores it from
        // F-RAM alongside the calibration and raises this one flag for both.
        //
        BTS_applySlotTuning();
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
    //
    // The internal-ADC pair is NOT derived from Sum_CellV/Sum_CellI any more.
    //
    // Those sums come from the 8-deep ring adcCellVoltageISR used to fill,
    // and that ISR is masked in the PIE now that the ADC triggers 1:1 with
    // EPWM1 - see BTS_HAL_setupADC(). Leaving this arithmetic in place would
    // have produced a plausible-looking number frozen at whatever the ring
    // held when the ISR was last serviced, which the reverse-polarity check
    // would then have trusted.
    //
    // BTS_refreshCellFromCla() writes CellVoltage_V / CellCurrent_I from the
    // CLA's fast filter instead, and runs immediately before these calls in
    // C1(). The sums are still accumulated above so a bring-up build that
    // re-enables the ISR still works.
    //
}

//
// Publishes the CLA's FAST filter into the fields the protection path reads.
//
// CellVoltage_V and CellCurrent_I are what the reverse-polarity check, group
// supervision and BTS_cellVoltageAsCtrl16b() consume. They used to come from
// the 8-deep ring that adcCellVoltageISR filled; with the ADC triggering 1:1
// with EPWM1 that ISR is masked and the ring is dead, so the values come from
// CLA1 instead.
//
// This is a change of source, not of meaning: same counts, same scaling, and
// a faster response than the ring gave (~184 us to settle against 1204 us).
//
// IF THE CLA IS NOT RUNNING these fields are left ALONE rather than zeroed. A
// stale voltage is a far better failure than a fabricated 0 V, which the
// reverse-polarity check reads as a fault and which would stop every slot.
// claNotRunning is published so the condition is visible rather than silent.
//
static void BTS_refreshCellFromCla(void)
{
    uint16_t ch;

    if ((BTS_claPrimed == 0U) || (claFastStale != 0U)) {
        return;
    }

    for (ch = 0U; ch < NUM_CHANNELS; ch++) {
        BTS_measValue *m = &BTS_measValues[ch];

        m->CellVoltage_V = ((BTS_claCellVoltageFast[ch] / 4096.0f) * 2.5f) *
                           m->F28V_Gain + m->F28V_Offset;
        m->CellCurrent_I = ((BTS_claCellCurrentFast[ch] / 4096.0f) * 2.5f) *
                           m->F28I_Gain + m->F28I_Offset;
    }
}

//
// Copy CLA1's filtered cell V/I into the telemetry fields, applying the same
// counts -> engineering conversion BTS_monitor_Iout_Vout uses above.
//
// The CLA stores raw ADC counts, so the scaling has to be identical or the
// filtered and unfiltered numbers would disagree by a constant factor and
// look like a calibration fault. It is written out rather than factored into
// a shared helper because BTS_monitor_Iout_Vout runs from ramfuncs and is on
// the hot path; this one runs at 10 Hz.
//
// Falls back to the unfiltered values whenever CLA1 is not demonstrably
// running - if the program image failed to copy into RAMLS4, if LSxCLAPGM was
// never set, or if the ADCA INT2 trigger is not reaching CLA1TASKSRCSEL1,
// BTS_claRunCount stops advancing and these fields would otherwise report a
// frozen number, or 0 V, with nothing to distinguish it from a real reading.
//
// Called once per C1() pass, i.e. at 10 Hz, right after the eight
// BTS_monitor_Iout_Vout calls that refresh the unfiltered pair.
//
static void BTS_updateFilteredTelemetry(void)
{
    static uint32_t lastRunCount = 0U;
    uint16_t claSeenRunning;
    uint32_t nowRunCount = BTS_claRunCount;
    uint16_t ch;

    //
    // At 99.67 kSPS the counter advances ~9967 times per nominal 100 ms pass,
    // so equality across a pass means the CLA genuinely is not running. The
    // first pass cannot tell - lastRunCount starts at 0 and the CLA may
    // legitimately be at 0 - so the stale flag only latches once a difference
    // has actually been observed.
    //
    // THIS COMPARISON IS WHY BTS_claRunCount IS 32-BIT. This observer is
    // slower than nominal: C1() was measured on hardware at 0.69 Hz, a
    // ~1.45 s period, against the 657 ms a 16-bit counter takes to wrap at
    // this ADC rate. A 16-bit counter could alias to the same value across two
    // passes and latch claFastStale on a perfectly healthy CLA, freezing the
    // readings this flag is supposed to protect. 32 bits wraps in ~12 hours.
    //
    claSeenRunning = (nowRunCount != lastRunCount) ? 1U : 0U;
    lastRunCount = nowRunCount;

    //
    // Published for BTS_refreshCellFromCla(), which runs BEFORE this on the
    // next pass and needs the same liveness answer. Also the one place the
    // condition is observable from a debugger.
    //
    claFastStale = (claSeenRunning != 0U) ? 0U : 1U;

    for (ch = 0U; ch < NUM_CHANNELS; ch++) {
        BTS_measValue *m = &BTS_measValues[ch];

        if ((claSeenRunning != 0U) && (BTS_claPrimed != 0U)) {
            float32_t vCounts = BTS_claCellVoltageFilt[ch];
            float32_t iCounts = BTS_claCellCurrentFilt[ch];

            m->CellVoltageFilt_V = ((vCounts / 4096.0f) * 2.5f) *
                                   m->F28V_Gain + m->F28V_Offset;
            m->CellCurrentFilt_I = ((iCounts / 4096.0f) * 2.5f) *
                                   m->F28I_Gain + m->F28I_Offset;
        } else {
            m->CellVoltageFilt_V = m->CellVoltage_V;
            m->CellCurrentFilt_I = m->CellCurrent_I;
        }
    }
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
        //
        // One tick per C-task dispatch, BEFORE the task runs so the slot it
        // services sees the current tick. This is the accumulators' time
        // base: it advances with the TASKC timer regardless of how long the
        // chain actually takes, so a measured interval stays honest even
        // when the tasks run slower than nominal.
        //
        accTick++;

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
    // Pre-charge balance and the two-path divergence check.
    //
    // Here rather than in C1 because both need a timebase the C chain cannot
    // offer: the brief's 100 ms soft-start retry, and a divergence fault
    // prompt enough to matter while a cell is being seated. B1 was empty and
    // runs three times faster than any single C task.
    //
    servicePreChargeBalance();
    serviceDivergenceFault();

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
//
// Boot-time arm delay for the hardware over-current trips.
//
// THE PROBLEM. Each slot's current-sense chain is an instrumentation amplifier
// referenced to 1.25 V, and 1.25 V is what it reads at zero current. Before
// its supply has come up and settled, its output sits near 0 V - and on that
// chain 0 V means -10 A, well past the low comparator's -9.5 A threshold.
// Arming the trips during boot therefore latches an over-current on every
// slot before the board has done anything at all. Because the trip is a
// one-shot it then STAYS latched, and clearing it while the source is still
// asserted just re-latches: the unit would come up unable to start any slot,
// exactly the TZOSTFLG = 0x0003 pattern seen when TZ1/TZ2 were misrouted.
//
// THE RULE. Arm once a slot has actually been commanded to run - by then its
// sense chain is powered and reading a real current - and disarm again when
// the last slot stops, so an idle unit is never holding an armed comparator
// against a chain that may be powering down.
//
// The extra delay costs nothing in protection terms. An unarmed trip only
// matters while current is flowing, and no current flows until a slot runs.
//
// Called at 10 Hz from C1(). BTS_HAL_armTripZones() is idempotent, so this
// tracks the edge rather than the level only to avoid pointless register
// writes.
//
static void serviceTripArming(void)
{
    static uint16_t tripsArmed = 0U;
    uint16_t        wantArmed  = 0U;
    uint16_t        ch;

    for (ch = 0U; ch < NUM_CHANNELS; ch++) {
        //
        // enable_logic rather than slotIsRunning(): a paused slot keeps its
        // sense chain powered, and re-arming it on every pause/resume would
        // be churn for no benefit. This asks "is the converter live".
        //
        if (BTS_userInputs[ch].enable_logic != 0U) {
            wantArmed = 1U;
            break;
        }
    }

    if (wantArmed == tripsArmed) {
        return;
    }

    BTS_HAL_armTripZones(wantArmed != 0U);
    tripsArmed = wantArmed;
}

void C1(void)
{
    //
    // FIRST: refresh the internal-ADC pair from CLA1. Everything below reads
    // CellVoltage_V / CellCurrent_I - the reverse-polarity check, group
    // supervision, the telemetry publish - and the ring that used to supply
    // them is no longer filled.
    //
    BTS_refreshCellFromCla();

    BTS_monitor_Iout_Vout(&BTS_measValues_ch1);
    BTS_monitor_Iout_Vout(&BTS_measValues_ch2);
    BTS_monitor_Iout_Vout(&BTS_measValues_ch3);
    BTS_monitor_Iout_Vout(&BTS_measValues_ch4);
    BTS_monitor_Iout_Vout(&BTS_measValues_ch5);
    BTS_monitor_Iout_Vout(&BTS_measValues_ch6);
    BTS_monitor_Iout_Vout(&BTS_measValues_ch7);
    BTS_monitor_Iout_Vout(&BTS_measValues_ch8);

    //
    // Refresh the CLA-filtered copy from the same pass, so the filtered and
    // unfiltered pairs a host reads always describe the same instant.
    //
    BTS_updateFilteredTelemetry();

    //
    // Integrate charge, energy and run time from the measurements just
    // refreshed. Counters advance only while a slot is genuinely running:
    // a paused, stopped, ended, tripped or calibrating slot contributes
    // nothing and its totals freeze exactly where they were.
    //
    //
    // The accumulators used to live here, integrating all eight slots every
    // C1 pass with a hard-coded dt. That is now accIntegrateSlot(), called
    // from C2 one slot at a time - see the note there.
    //

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
            //
            // A balancing or soft-starting slot is driving the stage just as
            // a running one is, so it is stopped on the same evidence. It
            // does not carry `running`, which is why the test cannot be
            // slotIsRunning() alone.
            //
            if (status[ch].running || status[ch].balancing ||
                status[ch].softStart) {
                slotStop(ch);
            }
        } else {
            status[ch].reversePolarity = 0;
        }
    }

    //
    // Terminate any test that has run to completion, BEFORE the group check:
    // a slot that just ended is no longer running, so checkGroupIntegrity()
    // correctly stops watching it rather than reporting the shutdown it just
    // performed as a group member falling out of step.
    //
    serviceTermination();

    checkGroupIntegrity();

    //
    // Arm the hardware trips once a slot is actually running, and drop them
    // again when none is. See serviceTripArming() for why this is not done
    // at boot.
    //
    serviceTripArming();

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

//
// Integrate one slot's charge, energy and run time.
//
// Called from C2, one slot per pass, so the cost is spread across eight C2
// dispatches instead of landing on every C1. C1 already runs the eight
// BTS_monitor_Iout_Vout() conversions and the input-voltage guard, and the
// C chain was measured running far below its nominal rate, so the work is
// moved off the busiest task rather than added to it.
//
// The interval is MEASURED, not assumed. accTick advances once per C-task
// dispatch; the elapsed time is the tick difference times the TASKC period.
// The previous code added a fixed 3/TASKC_FREQ_HZ every pass, which is only
// correct if the chain hits its nominal rate - it does not, and a 60 s charge
// at 1 A therefore banked 6.45 s and 1.79 mAh instead of 60 s and 16.7 mAh.
//
// Counters advance only while a slot is genuinely running: paused, stopped,
// ended, tripped or calibrating all contribute nothing and freeze the totals
// exactly where they were.
//
static void accIntegrateSlot(uint16_t ch)
{
    uint32_t now = accTick;

    if ((slotIsRunning(ch) == 0U) || calSlotIsCalibrating(ch)) {
        //
        // Not running: drop the baseline so the pass after a resume
        // integrates from that moment rather than from when it stopped.
        //
        accLastTick[ch] = 0U;
        return;
    }

    if (accLastTick[ch] == 0U) {
        //
        // First pass for this slot - establish the baseline and integrate
        // nothing. Without this the slot would bank every tick since boot.
        //
        accLastTick[ch] = now;
        return;
    }

    //
    // Unsigned subtraction, so a 32-bit wrap still yields the true delta.
    //
    uint32_t dTicks = now - accLastTick[ch];
    accLastTick[ch] = now;

    if (dTicks == 0U) {
        return;                     // same tick, nothing elapsed
    }

    float32_t dt_s = (float32_t)dTicks * BTS_ACC_TICK_SECONDS;

    if (dt_s > BTS_ACC_MAX_GAP_S) {
        //
        // Implausible gap - a stall, a debugger halt or a breakpoint. The
        // baseline is already re-set above, so the next pass resumes cleanly.
        //
        return;
    }

    float32_t dt_h = dt_s / (float32_t)3600.0;
    float32_t i_A  = fabsf(BTS_measValues[ch].Isense_A);
    float32_t p_W  = fabsf(BTS_measValues[ch].Isense_A * BTS_measValues[ch].Vsense_V);

    if (status[ch].charging) {
        accChargeMah[ch] += i_A * (float32_t)1000.0 * dt_h;
        accChargeMwh[ch] += p_W * (float32_t)1000.0 * dt_h;
        accChargeSeconds[ch] += dt_s;
    } else {
        accDischargeMah[ch] += i_A * (float32_t)1000.0 * dt_h;
        accDischargeMwh[ch] += p_W * (float32_t)1000.0 * dt_h;
        accDischargeSeconds[ch] += dt_s;
    }
}

void C2(void)
{
    static uint16_t channel = 0;

    //
    // Service one channel's pending calibration update per pass. This only
    // touches in-memory program variables; EEPROM persistence lives on CPU2.
    //
    BTS_monitor_program_update(channel);

    //
    // One slot's accumulators per pass, same rotation.
    //
    accIntegrateSlot(channel);

    channel = (channel + 1U) % NUM_CHANNELS;

    //
    // Execute task C3 the next time CpuTimer2 decrements to 0
    //
    C_Task_Ptr = &C3;
}

void C3(void)
{
    //
    // Watch for a post-boot clock failover. MCD can fire at any time and the
    // PLL registers will not show it - see BTS_HAL_pollClockHealth().
    //
    BTS_HAL_pollClockHealth();

#ifdef _STANDALONE
    //
    // Drive the CPU2 boot to completion: retry a command main() could not
    // send, and resend one the ROM never acknowledged. Zero timeout - this
    // runs in the background task chain and must not stall it. A no-op once
    // CPU2 has acknowledged.
    //
    (void)tryBootCpu2(0UL);
#endif

    //
    // Execute task C1 the next time CpuTimer2 decrements to 0
    //
    C_Task_Ptr = &C1;
}

//
// Ends a test that has run to completion.
//
// CHARGE terminates on CURRENT. In CCCV the loop holds V_MAX while the cell
// takes progressively less current, so a charge is finished when that current
// has fallen to I_MIN. Two guards, and both are load bearing:
//
//   The loop must be IN CV (ctrlMode_logic != 0). A charge starts in CC with
//   current ramping up from zero, so |I| is below I_MIN at the very moment
//   the slot starts - an unguarded test would end every charge immediately.
//   Being in CV is what distinguishes "current has fallen away because the
//   cell is full" from "current has not risen yet".
//
//   I_MIN must be non-zero. Zero means no termination current was configured,
//   and |I| <= 0 would never be satisfied anyway, but testing it explicitly
//   keeps the intent obvious next to the V_MIN rule below.
//
// DISCHARGE terminates on VOLTAGE, at V_MIN, with no CV requirement - a
// discharge runs in CC the whole way down and simply stops when the cell
// reaches its floor. V_MIN == 0 DISABLES the check entirely: a zero floor is
// how an operator asks to run the cell down without a voltage cutoff, not a
// request to terminate at 0 V.
//
// The sensor is the ADS131M08 (Isense_A / Vsense_V), NOT the internal ADC.
// That is the converter the CC loop regulates against and the one the
// accumulators integrate, so a slot ends on the same measurement that decided
// its current - and, unlike the internal-ADC pair, it is live for every MODE
// strap rather than only those with btsSlotUsesIntAdc set.
//
// GROUPED SLOTS: only the LEADER decides, and it ends its whole group.
// Followers do not run a controller at all - they mirror the leader's duty -
// so a follower's own reading is not a control input and must not be allowed
// to end anything on its own. This mirrors how start and stop already
// propagate from a leader to its members.
//
static void serviceTermination(void)
{
    uint16_t ch;

    for (ch = 0; ch < NUM_CHANNELS; ch++) {
        uint16_t terminate = 0U;

        //
        // Only a running, non-calibrating leader can terminate. A calibrating
        // slot is driving a bench reference, not running a test.
        //
        if ((slotIsRunning(ch) == 0U) || calSlotIsCalibrating(ch) ||
            (btsSlotIsLeader[ch] == 0U)) {
            termDwell[ch] = 0U;
            continue;
        }

        if (status[ch].charging) {
            float32_t iMin = BTS_userInputs[ch].iref_cuttout_A;

            if ((iMin > (float32_t)0.0) &&
                (BTS_ctrlLoopVariables[ch].ctrlMode_logic != 0U) &&
                (fabsf(BTS_measValues[ch].Isense_A) <= iMin)) {
                terminate = 1U;
            }
        } else {
            float32_t vMin = BTS_userInputs[ch].vref_discharge_V;

            //
            // vMin == 0 disables the check - see the note above.
            //
            if ((vMin > (float32_t)0.0) &&
                (BTS_measValues[ch].Vsense_V <= vMin)) {
                terminate = 1U;
            }
        }

        if (terminate == 0U) {
            termDwell[ch] = 0U;
            continue;
        }

        if (++termDwell[ch] < BTS_TERM_DWELL_PASSES) {
            continue;
        }

        //
        // Confirmed. End the leader and every member of its group together -
        // a partially ended group would leave the leader driving followers
        // that consider themselves finished.
        //
        {
            uint16_t m;

            for (m = 0; m < NUM_CHANNELS; m++) {
                if ((m != ch) && (btsSlotLeader[m] == ch) &&
                    (btsSlotEnabled[m] != 0U)) {
                    slotFinish(m);
                }
            }
            slotFinish(ch);
        }

        updateStatusRegisters();
    }
}

//
// ==================== Pre-charge balance supervisor ====================
//
// Runs in B1 rather than C1. The brief asks for a 100 ms trip retry and a
// prompt divergence fault, and B1 is both empty and three times faster than
// the C chain. (The C chain is no longer the 0.69 Hz it was measured at in
// September - a latent missed-clock detection was keeping the PLL off full
// speed, and it now runs above nominal - but B1 is still the better home for
// a 100 ms timebase.)
//
// THE SHUNT PLACEMENT IS WHAT MAKES THIS DECIDABLE. The output capacitors sit
// after the current sense resistor, so the shunt only reads current the
// switching FETs produce - never charge moving between a cell and the rail
// through the contacts. So:
//
//   voltages match + current zero      rail is balanced, no cell yet
//   voltages match + current non-zero  a cell is bridging the contacts
//
// Without that, "balanced successfully" and "cell inserted" would be the same
// reading and the sequence could not be sequenced at all.
//
// GROUPED MODES: only the leader is supervised. The members' outputs are
// physically paralleled onto one rail, so balancing the leader balances all
// of them - and followers have no control loop of their own to run.
//
static void servicePreChargeBalance(void)
{
    uint16_t ch;

    for (ch = 0; ch < NUM_CHANNELS; ch++) {
        float32_t vAds;
        float32_t vInt;
        float32_t iAds;
        float32_t tol;
        uint16_t  cellPresent;
        uint16_t  matched;
        uint16_t  loaded;

        //
        // Disabled slots and followers never run the sequence. A follower is
        // driven by its leader's duty and cannot balance independently.
        //
        if ((btsSlotEnabled[ch] == 0U) || (btsSlotIsLeader[ch] == 0U)) {
            continue;
        }

        //
        // Calibration owns the slot outright. Entering it cancels an armed
        // sequence - we are deliberately bringing up a controlled external
        // source and must not also be driving the rail.
        //
        if (calSlotIsCalibrating(ch)) {
            if (status[ch].waiting || status[ch].balancing ||
                status[ch].ready || status[ch].softStart) {
                slotStop(ch);
                updateStatusRegisters();
            }
            continue;
        }

        vAds = BTS_measValues[ch].Vsense_V;
        vInt = BTS_measValues[ch].CellVoltage_V;
        iAds = fabsf(BTS_measValues[ch].Isense_A);

        cellPresent = (vAds > BTS_INSERT_DETECT_V) ? 1U : 0U;

        //
        // Tolerance is a fraction of the ADS reading with an absolute floor,
        // so a near-zero reading does not demand a match tighter than the
        // 12-bit converter can resolve.
        //
        tol = vAds * BTS_BALANCE_TOL_FRAC;
        if (tol < BTS_BALANCE_TOL_MIN_V) {
            tol = BTS_BALANCE_TOL_MIN_V;
        }
        matched = (fabsf(vInt - vAds) <= tol) ? 1U : 0U;
        loaded  = (iAds > BTS_BALANCE_ZERO_I_A) ? 1U : 0U;

        //
        // A slot that has finished its test re-arms once the cell is taken
        // out, so the next cell is met by an armed slot without an operator
        // having to command anything.
        //
        if (status[ch].finished && !cellPresent) {
            slotWait(ch);
            updateStatusRegisters();
            continue;
        }

        //
        // Nothing below applies unless the slot is in the sequence.
        //
        if (!status[ch].waiting) {
            continue;
        }

        //
        // The cell went away, at any point in the sequence. Stand the
        // converter down and re-arm - this is also how a fault is cleared,
        // per the brief: pull the cell, the slot goes back to waiting.
        //
        // The soft-start fault below parks the slot with only `waiting` set
        // and the over-current bit up, so it has to be included here - and
        // the bit has to come off. Before this, removing the cell re-armed
        // nothing for that case and the fault indication never cleared.
        //
        if (!cellPresent) {
            if (status[ch].balancing || status[ch].ready ||
                status[ch].softStart || status[ch].overCurrentTrip) {
                slotClearOverCurrent(ch);
                slotWait(ch);
                updateStatusRegisters();
            }
            continue;
        }

        //
        // ---- SOFT_START ----
        //
        if (status[ch].softStart) {
            //
            // Holding off after a trip. The converter is already down; wait
            // out the ~100 ms and try again.
            //
            if (softStartHold[ch] > 0U) {
                softStartHold[ch]--;
                if (softStartHold[ch] == 0U) {
                    if (softStartRetries[ch] >= BTS_SOFT_START_MAX_RETRIES) {
                        //
                        // Out of attempts. Fault, and leave it faulted until
                        // the cell is removed.
                        //
                        slotStop(ch);
                        status[ch].waiting = 1;
                        status[ch].overCurrentTrip = 1;
                        updateStatusRegisters();
                    } else {
                        softStartRetries[ch]++;
                        BTS_userInputs[ch].enable_logic = 1;
                        balanceDwell[ch] = 0U;
                    }
                }
                continue;
            }

            //
            // A trip during soft start: drop the converter and schedule a
            // retry rather than failing outright. Inrush into a pre-biased
            // cell is exactly what soft start exists to survive.
            //
            if (BTS_ctrlLoopVariables[ch].tripFlag != 0U) {
                BTS_userInputs[ch].enable_logic = 0;
                softStartHold[ch] = BTS_SOFT_START_RETRY_PASSES;
                continue;
            }

            //
            // Done when the average current is no longer negative - the
            // inductor current is positive across the whole cycle, so the
            // synchronous rectifier can be engaged without the cell driving
            // current backwards through it.
            //
            if (BTS_measValues[ch].Isense_A >= (float32_t)0.0) {
                if (++balanceDwell[ch] >= BTS_BALANCE_DWELL_PASSES) {
                    status[ch].waiting   = 0;
                    status[ch].softStart = 0;
                    status[ch].running   = 1;
                    status[ch].stopped   = 0;
                    balanceDwell[ch] = 0U;
                    softStartRetries[ch] = 0U;
                    updateStatusRegisters();
                }
            } else {
                balanceDwell[ch] = 0U;

                //
                // Not converging. Give it a bounded time, then treat it as a
                // failed attempt and retry - the same path a trip takes.
                //
                if (++softStartElapsed[ch] > BTS_SOFT_START_TIMEOUT_PASSES) {
                    BTS_userInputs[ch].enable_logic = 0;
                    softStartElapsed[ch] = 0U;
                    softStartHold[ch] = BTS_SOFT_START_RETRY_PASSES;
                }
            }
            continue;
        }

        //
        // ---- READY ----
        //
        if (status[ch].ready) {
            //
            // A load appearing on a matched rail is the insertion: the shunt
            // cannot see cell-to-rail charge transfer, so any current here is
            // the converter meeting a cell that is now connected.
            //
            if (loaded) {
                if (++balanceDwell[ch] >= BTS_BALANCE_DWELL_PASSES) {
                    status[ch].ready     = 0;
                    status[ch].softStart = 1;
                    //
                    // Out of the balancing duty path: from here the control
                    // loop runs, in diode emulation, into a connected cell.
                    //
                    btsSlotPreCharging[ch] = 0U;
                    BTS_userInputs[ch].enable_logic = 1;
                    balanceDwell[ch] = 0U;
                    softStartRetries[ch] = 0U;
                    softStartHold[ch] = 0U;
                    updateStatusRegisters();
                }
                continue;
            }

            //
            // READY is re-verified, not latched: an unloaded output capacitor
            // drifts, and the operator may take a while to seat the cell.
            //
            if (!matched) {
                slotBalance(ch);
                updateStatusRegisters();
            } else {
                balanceDwell[ch] = 0U;
            }
            continue;
        }

        //
        // ---- BALANCING ----
        //
        if (status[ch].balancing) {
            if (++balanceDwell[ch] > BTS_BALANCE_TIMEOUT_PASSES) {
                //
                // Could not reach the target. Stand down and fault rather
                // than drive the rail indefinitely.
                //
                slotStop(ch);
                status[ch].waiting = 1;
                updateStatusRegisters();
                continue;
            }

            //
            // Balanced only when the voltages agree AND nothing is drawing -
            // a matched pair with current flowing means a cell is already
            // connected, which is a different state.
            //
            if (matched && !loaded) {
                slotReady(ch);
                updateStatusRegisters();
            }
            continue;
        }

        //
        // ---- WAITING ----
        //
        // A cell is approaching. If the rail already matches there is nothing
        // to do; otherwise drive it.
        //
        if (matched) {
            slotReady(ch);
        } else {
            slotBalance(ch);
        }
        updateStatusRegisters();
    }
}

//
// Faults a RUNNING slot whose two sense paths have diverged.
//
// A rapid rise on the converter rail that the ADS path does not see means the
// cell is no longer bridging the contacts - a cell pulled mid-test, or a
// contact that has opened - and the converter is now driving into its own
// output capacitor with the loop still asking for current.
//
static void serviceDivergenceFault(void)
{
    uint16_t ch;

    for (ch = 0; ch < NUM_CHANNELS; ch++) {
        float32_t vAds;
        float32_t vInt;
        float32_t limit;

        if ((slotIsRunning(ch) == 0U) || calSlotIsCalibrating(ch)) {
            continue;
        }

        vAds = BTS_measValues[ch].Vsense_V;
        vInt = BTS_measValues[ch].CellVoltage_V;

        //
        // Referenced to the ADS path, which is the one that still reads the
        // cell. A floor keeps a near-zero reading from making any difference
        // look like 20%.
        //
        limit = vAds * BTS_DIVERGE_FAULT_FRAC;
        if (limit < BTS_BALANCE_TOL_MIN_V) {
            limit = BTS_BALANCE_TOL_MIN_V;
        }

        if (fabsf(vInt - vAds) > limit) {
            if (++divergeDwell[ch] >= BTS_BALANCE_DWELL_PASSES) {
                uint16_t m;

                for (m = 0; m < NUM_CHANNELS; m++) {
                    if ((btsSlotLeader[m] == ch) && (btsSlotEnabled[m] != 0U)) {
                        slotStop(m);
                        status[m].groupDisconnect = 1;
                    }
                }
                divergeDwell[ch] = 0U;
                updateStatusRegisters();
            }
        } else {
            divergeDwell[ch] = 0U;
        }
    }
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

    bool     adcbTimedOut  = (adcWait >= BTS_ADCB_EOC_MAX_POLLS);
    uint16_t busVoltageRaw = adcbTimedOut ? 0U :
                             ADC_readResult(ADCBRESULT_BASE, ADC_SOC_NUMBER1);

    if (adcbTimedOut) {
        //
        // Treat a timeout as "input voltage unknown", which is the safe
        // reading: 0 V drives unitState to charge-disabled below rather
        // than leaving a stale value that looks healthy.
        //
        adcbEocTimeouts++;
    }

    //
    // Clear on BOTH paths, and only after the result has been read.
    //
    // This used to clear on the timeout branch alone. Nothing else clears
    // ADCB INT1 - the only other ADC_clearInterruptStatus(ADCB_BASE, ...) is
    // the one-time setup in BTS_HAL_setupADC() - so from the second call
    // onward the flag was already set on entry and the wait above exited
    // immediately, before the freshly-forced conversion had landed. The
    // reading was one call old: 100 ms at the 10 Hz C1() rate.
    //
    // At that timescale a stale bus voltage is still usable, so the guard
    // behaved correctly and the bug was invisible. The real cost was that the
    // bounded wait became dead code after the first pass - adcbEocTimeouts
    // could never increment again, so a genuinely stuck ADCB would have been
    // indistinguishable from a healthy one and the "treat a timeout as 0 V"
    // protection above would never have fired.
    //
    ADC_clearInterruptStatus(ADCB_BASE, ADC_INT_NUMBER1);

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
// EPWM_getTripZoneFlagStatus() reports *which kind* of trip fired. Two kinds
// can reach this handler:
//
//   EPWM_TZ_FLAG_DCAEVT1  the CMPSS over-current comparator, arriving through
//                         the Digital Compare submodule. This is the live
//                         hardware trip - see BTS_HAL_setupEPWMTripZone() for
//                         why it does not come in on OSHT1.
//   EPWM_TZ_FLAG_OST      the one-shot inputs TZ1/TZ2. Both are masked in this
//                         build, so this only appears if something re-enables
//                         them; it is still handled rather than ignored.
//
// A GROUPED TRIP RAISES THIS ON EVERY MEMBER AT ONCE. The group's comparators
// are OR-ed onto one X-BAR trip output that every ePWM in the group watches,
// so the hardware has already stopped all of them before this runs - the loop
// below simply finds several channels flagged rather than one. That is the
// point of the grouped routing: no software in the stopping path.
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

        if ((tzStatus & (EPWM_TZ_FLAG_DCAEVT1 | EPWM_TZ_FLAG_OST)) == 0U) {
            continue;
        }

        // TripStatusBitfield packs two bits per channel: cmpss then gpio.
        if (tzStatus & EPWM_TZ_FLAG_DCAEVT1) {
            //
            // The over-current comparator. Reported in the cmpss bit, which
            // is what it is regardless of the route it took to get here.
            //
            tripBits |= 1UL << (channel * 2U);
        }
        if (tzStatus & EPWM_TZ_FLAG_OST) {
            uint16_t ostStatus = EPWM_getOneShotTripZoneFlagStatus(epwmBase);

            if (ostStatus & EPWM_TZ_OST_FLAG_OST1) {
                tripBits |= 1UL << (channel * 2U);
            }
            if (ostStatus & EPWM_TZ_OST_FLAG_OST2) {   // GPIO group trip
                tripBits |= 1UL << (channel * 2U + 1U);
            }
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
        EPWM_clearTripZoneFlag(epwmBase,
                               EPWM_TZ_FLAG_OST | EPWM_TZ_FLAG_DCAEVT1 |
                               EPWM_TZ_INTERRUPT);

        //
        // If the source re-asserts immediately the flag will still be set on
        // the next pass. Mask this channel's trip interrupt after a burst so
        // a stuck input cannot starve the background loop.
        //
        if (EPWM_getTripZoneFlagStatus(epwmBase) &
            (EPWM_TZ_FLAG_DCAEVT1 | EPWM_TZ_FLAG_OST)) {
            if (++reentryCount[channel] >= 16U) {
                //
                // Masks the INTERRUPT only. The trip ACTION - both outputs
                // forced low - stays latched in hardware, so the channel is
                // still safe; this only stops a permanently-asserted source
                // from starving the background loop.
                //
                EPWM_disableTripZoneInterrupt(epwmBase,
                                              EPWM_TZ_INTERRUPT_OST |
                                              EPWM_TZ_INTERRUPT_DCAEVT1);
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
