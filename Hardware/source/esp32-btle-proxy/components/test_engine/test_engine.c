/*
 * test_engine.c
 *
 * Per-slot battery test state machine. See test_engine.h for the sequence
 * and the reasoning behind the termination conditions.
 *
 * THREADING
 * ---------
 * One task ticks every TICK_MS and owns all state transitions. The public
 * control entry points mutate slot state under s_lock; the tick holds the
 * same lock for the whole of its pass. Lock order is always
 *
 *     s_lock  ->  bts_link's internal mutexes
 *
 * and never the reverse, because nothing inside bts_link ever calls back
 * into the engine.
 *
 * Change notifications are collected during the tick and fired after the
 * lock is dropped, so a slow BLE stack cannot stall the control loop.
 */

#include <string.h>
#include <stdio.h>
#include <math.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/semphr.h"
#include "esp_log.h"
#include "esp_timer.h"
#include "test_engine.h"
#include "result_store.h"

static const char *TAG = "test_engine";

#define TICK_MS                 250
#define TASK_STACK              5120
#define TASK_PRIO               5

/* Wall-clock ceiling on a whole test when the config does not set one. */
#define DEFAULT_MAX_MINUTES     720

/*
 * How long a channel sits stopped before its open-circuit voltage is
 * believed. The cell has normally been idle for far longer than this by the
 * time an operator presses start; this only covers the case where a test is
 * restarted straight after one finishes.
 */
#define OCV_SETTLE_S            10

/*
 * Settle time after the discharge terminates, before rested_voltage_v is
 * recorded. Deliberately shorter than the chemistry's rest_minutes (which
 * governs the post-charge rest): this one only has to let the ohmic sag
 * recover enough for the number to mean something, and holding a finished
 * slot for half an hour to record one voltage is a bad trade on an eight
 * slot tester.
 */
#define DISCHARGE_SETTLE_S      300

/*
 * modeCallback() runs on CPU1 off the register write, and the status bits
 * are republished to CPU2 on their own cadence. Do not believe STOPPED
 * until this long after issuing a run command, or the engine reads the
 * stale pre-command status and concludes the channel finished instantly.
 */
#define MODE_GRACE_MS           3000

/* Consecutive failed poll cycles before a running channel is shut down. */
#define BTS_OFFLINE_TICKS       20

#define NO_CELL_VOLTAGE_V       0.30f
#define REVERSED_VOLTAGE_V      (-0.05f)

/* Measured current is allowed this much over the setpoint before faulting. */
#define OVER_CURRENT_MARGIN     1.30f

typedef struct {
    slot_state_t            state;
    slot_fault_t            fault;
    bool                    configured;
    bool                    result_saved;
    slot_config_t           config;
    cell_resolved_profile_t profile;

    int64_t                 state_entered_us;
    int64_t                 test_started_us;
    int64_t                 mode_issued_us;
    /* Cleared on every state entry; set once the power stage is commanded. */
    bool                    power_started;

    coulomb_counter_t       discharge_cc;
    coulomb_counter_t       charge_cc;   /* CHARGE and RECHARGE both use this */

    float                   recharge_target_mah;

    bool                    changed;     /* pending notification */

    slot_result_t           result;
} slot_ctx_t;

static slot_ctx_t        s_slot[SLOT_COUNT];
static SemaphoreHandle_t s_lock;
static slot_change_cb_t  s_change_cb;
static bool              s_ready;

/* ------------------------------------------------------------------ */
/* Small helpers                                                      */
/* ------------------------------------------------------------------ */

static const char *k_state_names[SLOT_STATE_COUNT] = {
    "IDLE", "CHECK_REST", "CHARGE", "REST", "DISCHARGE",
    "DISCHARGE_REST", "RECHARGE", "COMPLETE", "FAULT", "ABORTED",
    "BTS_PAUSED",
};

static const char *k_fault_names[SLOT_FAULT_COUNT] = {
    "NONE", "OVER_TEMP", "UNDER_TEMP", "OVER_CURRENT", "CMPSS_TRIP",
    "GPIO_TRIP", "TIMEOUT", "BTS_OFFLINE", "UNIT_STATE", "NO_CELL",
    "CELL_REVERSED", "COMMS",
};

const char *slot_state_name(slot_state_t state)
{
    return (state < SLOT_STATE_COUNT) ? k_state_names[state] : "?";
}

const char *slot_fault_name(slot_fault_t fault)
{
    return (fault < SLOT_FAULT_COUNT) ? k_fault_names[fault] : "?";
}

static inline uint32_t seconds_since(int64_t us)
{
    if (us == 0) {
        return 0;
    }
    const int64_t d = esp_timer_get_time() - us;
    return (d > 0) ? (uint32_t)(d / 1000000) : 0;
}

/* True while the power stage is meant to be enabled. */
static inline bool state_is_powered(slot_state_t s)
{
    return s == SLOT_STATE_CHARGE ||
           s == SLOT_STATE_DISCHARGE ||
           s == SLOT_STATE_RECHARGE;
}

static void enter_state(uint8_t slot, slot_state_t state)
{
    slot_ctx_t *c = &s_slot[slot];
    if (c->state != state) {
        ESP_LOGI(TAG, "slot %u: %s -> %s", slot,
                 slot_state_name(c->state), slot_state_name(state));
    }
    c->state            = state;
    c->state_entered_us = esp_timer_get_time();
    c->power_started    = false;
    c->changed          = true;
}

static void fail(uint8_t slot, slot_fault_t fault)
{
    slot_ctx_t *c = &s_slot[slot];
    bts_link_stop_channel(slot);
    coulomb_stop(&c->discharge_cc);
    coulomb_stop(&c->charge_cc);
    c->fault = fault;
    ESP_LOGE(TAG, "slot %u fault: %s (in %s)", slot,
             slot_fault_name(fault), slot_state_name(c->state));
    enter_state(slot, SLOT_STATE_FAULT);
}

/*
 * Pushes the resolved limits, then the mode, in that order.
 *
 * modeCallback() latches vref_charge_V / vref_discharge_V / iref_A /
 * iref_cuttout_A out of the control block at the instant the mode register
 * is written, so the limits have to already be in place. It also refuses
 * the command outright when the DC input voltage sits outside the
 * charge/discharge restrict window, which is why check_safety() watches the
 * unit state rather than relying on a status read-back.
 */
static esp_err_t start_power(uint8_t slot, uint32_t mode)
{
    slot_ctx_t *c = &s_slot[slot];
    bts_channel_limits_t limits;

    cell_profile_to_bts_limits(&c->profile, &limits);

    esp_err_t err = bts_link_set_limits(slot, &limits);
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "slot %u limit write failed: %s", slot, esp_err_to_name(err));
        return err;
    }

    err = bts_link_set_mode(slot, mode);
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "slot %u mode write failed: %s", slot, esp_err_to_name(err));
        return err;
    }

    c->mode_issued_us = esp_timer_get_time();
    c->power_started  = true;
    return ESP_OK;
}

/*
 * The specified "reset the watt and current counters in the BTS via
 * registers" step.
 *
 * The registers are REG_ACCESS_RO and i2cSlaveISR() drops host writes to
 * them, so this cannot succeed - but it no longer needs to. The BTS zeroes
 * a direction's set itself the moment that direction starts, so by the time
 * the mode write below lands the counters are already at zero. The write is
 * kept so a later build that does make them writable needs no change here.
 */
static void try_reset_bts_accumulators(uint8_t slot)
{
    (void)bts_link_write_reg(BTS_RT_ADDR(slot, BTS_RT_DISCHARGE_MAH), 0.0f);
    (void)bts_link_write_reg(BTS_RT_ADDR(slot, BTS_RT_DISCHARGE_MWH), 0.0f);
    (void)bts_link_write_reg(BTS_RT_ADDR(slot, BTS_RT_DISCHARGE_SECONDS), 0.0f);
}

/* ------------------------------------------------------------------ */
/* Per-tick safety checks                                             */
/* ------------------------------------------------------------------ */

/*
 * Returns the fault to raise, or SLOT_FAULT_NONE.
 *
 * These run on every active state, every tick. The BTS has its own CMPSS
 * and GPIO trips in hardware; this is the slower supervisory layer that
 * also covers temperature, the wall-clock ceiling and the link itself.
 */
static slot_fault_t check_safety(uint8_t slot, const bts_snapshot_t *snap)
{
    const slot_ctx_t          *c  = &s_slot[slot];
    const bts_channel_state_t *ch = &snap->channel[slot];

    if (!snap->unit.online && snap->unit.consecutive_errors >= BTS_OFFLINE_TICKS) {
        return SLOT_FAULT_BTS_OFFLINE;
    }
    if (!ch->valid) {
        /*
         * A single bad channel read is tolerated - the unit-level check
         * above catches a sustained outage, and faulting a slot on one
         * dropped I2C transaction would make the tester unusable.
         */
        return SLOT_FAULT_NONE;
    }

    if (ch->cmpss_trip) {
        return SLOT_FAULT_CMPSS_TRIP;
    }
    if (ch->gpio_trip) {
        return SLOT_FAULT_GPIO_TRIP;
    }

    if (ch->cell_temp_c > c->profile.temp_max_c) {
        return SLOT_FAULT_OVER_TEMP;
    }
    if (ch->cell_temp_c < c->profile.temp_min_c) {
        return SLOT_FAULT_UNDER_TEMP;
    }

    if (state_is_powered(c->state) && c->power_started) {
        const float setpoint = (c->state == SLOT_STATE_DISCHARGE)
                                   ? c->profile.discharge_current_a
                                   : c->profile.charge_current_a;
        /* Skip the first couple of seconds: the loop is still ramping. */
        if (seconds_since(c->mode_issued_us) > 2 &&
            fabsf(ch->cell_current_a) > setpoint * OVER_CURRENT_MARGIN) {
            return SLOT_FAULT_OVER_CURRENT;
        }

        /*
         * The unit refuses to start, and will stop, outside its input
         * window. Treat the disabled states as a fault so the operator sees
         * why the test stalled rather than watching it sit at 0 A.
         */
        if (snap->unit.unit_state == BTS_UNIT_INPUT_LOW_CHARGE_DISABLED &&
            (c->state == SLOT_STATE_CHARGE || c->state == SLOT_STATE_RECHARGE)) {
            return SLOT_FAULT_UNIT_STATE;
        }
        if (snap->unit.unit_state == BTS_UNIT_INPUT_HIGH_DISCHARGE_DISABLED &&
            c->state == SLOT_STATE_DISCHARGE) {
            return SLOT_FAULT_UNIT_STATE;
        }
    }

    const uint32_t limit_min = c->config.max_duration_minutes
                                   ? c->config.max_duration_minutes
                                   : DEFAULT_MAX_MINUTES;
    if (c->test_started_us != 0 && seconds_since(c->test_started_us) > limit_min * 60u) {
        return SLOT_FAULT_TIMEOUT;
    }

    return SLOT_FAULT_NONE;
}

/*
 * Whether the BTS has stopped a channel we asked to run.
 *
 * A secondary termination signal only - the engine does not depend on it,
 * because status[].finished is never asserted by the current BTS firmware
 * (see test_engine.h). It does catch the case where the BTS stops a channel
 * on its own, e.g. an input-voltage excursion.
 *
 * A pause is explicitly NOT "done": the run is intact and resumable, and
 * treating it as a termination would write a truncated result.
 */
static bool bts_says_done(const slot_ctx_t *c, const bts_channel_state_t *ch)
{
    if (!ch->valid || !c->power_started) {
        return false;
    }
    if ((esp_timer_get_time() - c->mode_issued_us) < (MODE_GRACE_MS * 1000LL)) {
        return false;
    }
    if (ch->paused) {
        return false;
    }
    if (ch->status_bits & BTS_STATUS_ENDED_MASK) {
        return true;
    }
    if ((ch->status_bits & BTS_STATUS_STOPPED) &&
        !(ch->status_bits & BTS_STATUS_RUNNING)) {
        return true;
    }
    return false;
}

/* ------------------------------------------------------------------ */
/* Result assembly                                                    */
/* ------------------------------------------------------------------ */

static void finish_test(uint8_t slot, const bts_snapshot_t *snap)
{
    slot_ctx_t    *c = &s_slot[slot];
    slot_result_t *r = &c->result;

    r->valid     = true;
    r->chemistry = c->profile.chemistry;
    /*
     * memcpy, not snprintf: both sides live inside s_slot, and snprintf's
     * arguments are `restrict`, so overlapping objects are undefined even
     * though these particular fields do not overlap. The sources are
     * already NUL-terminated and the destinations are the same width.
     */
    memcpy(r->serial, c->config.serial, sizeof(r->serial));
    memcpy(r->model_name, c->profile.model_name, sizeof(r->model_name));
    r->serial[sizeof(r->serial) - 1] = '\0';
    r->model_name[sizeof(r->model_name) - 1] = '\0';

    /* Advisory: the BTS's own totals, for comparison against the local ones. */
    r->bts_discharge_mah = snap->channel[slot].discharge_mah;
    r->bts_discharge_mwh = snap->channel[slot].discharge_mwh;
    r->bts_charge_mah    = snap->channel[slot].charge_mah;
    r->bts_charge_mwh    = snap->channel[slot].charge_mwh;
    r->completed_unix  = esp_timer_get_time() / 1000000;

    bts_link_stop_channel(slot);

    if (result_store_save(slot, r) != ESP_OK) {
        ESP_LOGW(TAG, "slot %u: result not persisted", slot);
    }
    c->result_saved = true;
    enter_state(slot, SLOT_STATE_COMPLETE);
}

/* ------------------------------------------------------------------ */
/* State handlers                                                     */
/* ------------------------------------------------------------------ */

static void tick_check_rest(uint8_t slot, const bts_channel_state_t *ch)
{
    slot_ctx_t *c = &s_slot[slot];

    if (seconds_since(c->state_entered_us) < OCV_SETTLE_S || !ch->valid) {
        return;
    }

    const float v = ch->cell_voltage_v;

    if (v < REVERSED_VOLTAGE_V) {
        fail(slot, SLOT_FAULT_CELL_REVERSED);
        return;
    }
    if (v < NO_CELL_VOLTAGE_V) {
        fail(slot, SLOT_FAULT_NO_CELL);
        return;
    }

    /*
     * "if the resting cell voltage is within 5% of the configured resting
     * voltage from maximum for that cell type, it can execute a discharge
     * cycle immediately" - rest_tolerance_pct is a percentage of
     * charge_v_max, so a 4.20 V NMC cell at 3.99 V or above goes straight
     * to discharge.
     */
    const float threshold =
        c->profile.charge_v_max * (1.0f - c->profile.rest_tolerance_pct / 100.0f);

    c->result.start_voltage_v = v;

    if (v >= threshold) {
        ESP_LOGI(TAG, "slot %u: %.3f V >= %.3f V, discharging immediately",
                 slot, v, threshold);
        enter_state(slot, SLOT_STATE_DISCHARGE);
    } else {
        ESP_LOGI(TAG, "slot %u: %.3f V < %.3f V, charging first",
                 slot, v, threshold);
        enter_state(slot, SLOT_STATE_CHARGE);
    }
}

static void tick_charge(uint8_t slot, const bts_channel_state_t *ch)
{
    slot_ctx_t *c = &s_slot[slot];

    if (!c->power_started) {
        coulomb_reset(&c->charge_cc);
        if (start_power(slot, BTS_MODE_RUN_CHARGE) != ESP_OK) {
            fail(slot, SLOT_FAULT_COMMS);
        }
        return;
    }
    if (!ch->valid) {
        return;
    }

    coulomb_update(&c->charge_cc, ch->cell_voltage_v, ch->cell_current_a,
                   ch->cell_temp_c, esp_timer_get_time());

    /*
     * Termination: the BTS runs CC up to ChargeVoltageMax then CV, tapering
     * toward iref_cuttout_A (which cell_profile_to_bts_limits() sets from
     * charge_term_c). Full is "in CV and the current has fallen to the
     * taper threshold". The voltage-plus-taper arm is a fallback for a BTS
     * build that does not publish the CV status bit.
     */
    const bool in_cv      = (ch->status_bits & BTS_STATUS_CONST_VOLTAGE) != 0;
    const bool tapered    = fabsf(ch->cell_current_a) <= c->profile.charge_term_current_a;
    const bool at_voltage = ch->cell_voltage_v >= c->profile.charge_v_max - 0.005f;

    if ((in_cv && tapered) ||
        (at_voltage && tapered && seconds_since(c->mode_issued_us) > 30) ||
        bts_says_done(c, ch)) {
        bts_link_stop_channel(slot);
        coulomb_stop(&c->charge_cc);
        ESP_LOGI(TAG, "slot %u: charge complete, %.0f mAh in, resting %u min",
                 slot, (float)c->charge_cc.mah, (unsigned)c->profile.rest_minutes);
        enter_state(slot, SLOT_STATE_REST);
    }
}

static void tick_rest(uint8_t slot, const bts_channel_state_t *ch)
{
    slot_ctx_t *c = &s_slot[slot];

    if (seconds_since(c->state_entered_us) < c->profile.rest_minutes * 60u) {
        return;
    }
    if (ch->valid) {
        /* The rested voltage after the charge is the discharge's true start. */
        c->result.start_voltage_v = ch->cell_voltage_v;
    }
    enter_state(slot, SLOT_STATE_DISCHARGE);
}

static void tick_discharge(uint8_t slot, const bts_channel_state_t *ch)
{
    slot_ctx_t *c = &s_slot[slot];

    if (!c->power_started) {
        /*
         * Order matters: zero the counters, then initiate. The BTS zeroes
         * its own pair on the mode write (see try_reset_bts_accumulators);
         * the local integrator is what produces the reported figures.
         */
        try_reset_bts_accumulators(slot);
        coulomb_reset(&c->discharge_cc);
        if (start_power(slot, BTS_MODE_RUN_DISCHARGE) != ESP_OK) {
            fail(slot, SLOT_FAULT_COMMS);
        }
        return;
    }
    if (!ch->valid) {
        return;
    }

    coulomb_update(&c->discharge_cc, ch->cell_voltage_v, ch->cell_current_a,
                   ch->cell_temp_c, esp_timer_get_time());

    /*
     * The engine owns the cutoff. Require the cell to actually be under load
     * before believing the voltage, otherwise the first samples - taken
     * while the power stage is still ramping - can read below the cutoff on
     * a sagging cell and end the test immediately.
     */
    const bool under_load = fabsf(ch->cell_current_a) > 0.05f;
    const bool at_cutoff  = ch->cell_voltage_v <= c->profile.discharge_v_min;

    if ((under_load && at_cutoff) || bts_says_done(c, ch)) {
        bts_link_stop_channel(slot);
        coulomb_stop(&c->discharge_cc);

        slot_result_t *r = &c->result;
        r->end_voltage_v     = ch->cell_voltage_v;
        r->discharge_mah     = (float)c->discharge_cc.mah;
        r->discharge_mwh     = (float)c->discharge_cc.mwh;
        r->max_temp_c        = c->discharge_cc.peak_temp_c;
        r->max_current_a     = c->discharge_cc.peak_current_a;
        r->min_voltage_v     = c->discharge_cc.min_voltage_v;
        r->max_voltage_v     = c->discharge_cc.max_voltage_v;
        r->discharge_seconds = (uint32_t)coulomb_elapsed_s(&c->discharge_cc);

        ESP_LOGI(TAG, "slot %u: discharge done %.1f mAh %.1f mWh in %us, "
                      "Vend %.3f Tmax %.1fC",
                 slot, r->discharge_mah, r->discharge_mwh,
                 (unsigned)r->discharge_seconds, r->end_voltage_v, r->max_temp_c);

        enter_state(slot, SLOT_STATE_DISCHARGE_REST);
    }
}

static void tick_discharge_rest(uint8_t slot, const bts_channel_state_t *ch,
                                const bts_snapshot_t *snap)
{
    slot_ctx_t *c = &s_slot[slot];

    if (seconds_since(c->state_entered_us) < DISCHARGE_SETTLE_S) {
        return;
    }
    if (ch->valid) {
        c->result.rested_voltage_v = ch->cell_voltage_v;
    }

    if (c->config.auto_recharge_to_shipping && c->result.discharge_mah > 0.0f) {
        /*
         * "add the % of recorded max discharge capacity by amperage counter
         * back into the cell" - the target is a fraction of what this test
         * actually removed, not of the datasheet capacity, so an aged cell
         * still lands at the right state of charge.
         */
        const float pct = (c->config.shipping_pct > 0.0f) ? c->config.shipping_pct : 60.0f;
        c->recharge_target_mah = c->result.discharge_mah * pct / 100.0f;
        ESP_LOGI(TAG, "slot %u: recharging to %.0f%% shipping = %.0f mAh",
                 slot, pct, c->recharge_target_mah);
        enter_state(slot, SLOT_STATE_RECHARGE);
    } else {
        finish_test(slot, snap);
    }
}

static void tick_recharge(uint8_t slot, const bts_channel_state_t *ch,
                          const bts_snapshot_t *snap)
{
    slot_ctx_t *c = &s_slot[slot];

    if (!c->power_started) {
        coulomb_reset(&c->charge_cc);
        if (start_power(slot, BTS_MODE_RUN_CHARGE) != ESP_OK) {
            fail(slot, SLOT_FAULT_COMMS);
        }
        return;
    }
    if (!ch->valid) {
        return;
    }

    coulomb_update(&c->charge_cc, ch->cell_voltage_v, ch->cell_current_a,
                   ch->cell_temp_c, esp_timer_get_time());

    /*
     * Terminated by coulomb count, not by voltage: the point of the shipping
     * state is a defined state of charge, and resting voltage is a poor SoC
     * proxy on a flat-plateau chemistry like LFP. charge_v_max remains a
     * hard backstop in case the target is unreachable.
     */
    const bool at_target  = c->charge_cc.mah >= (double)c->recharge_target_mah;
    const bool at_ceiling = ch->cell_voltage_v >= c->profile.charge_v_max;

    if (at_target || at_ceiling || bts_says_done(c, ch)) {
        bts_link_stop_channel(slot);
        coulomb_stop(&c->charge_cc);

        c->result.recharged          = true;
        c->result.recharge_mah       = (float)c->charge_cc.mah;
        c->result.shipping_voltage_v = ch->cell_voltage_v;

        if (at_ceiling && !at_target) {
            ESP_LOGW(TAG, "slot %u: recharge hit the %.3f V ceiling at %.0f of "
                          "%.0f mAh", slot, ch->cell_voltage_v,
                     c->result.recharge_mah, c->recharge_target_mah);
        }
        /* The recharge can be the hottest part of the cycle on a high C rate. */
        if (c->result.max_temp_c < c->charge_cc.peak_temp_c) {
            c->result.max_temp_c = c->charge_cc.peak_temp_c;
        }
        finish_test(slot, snap);
    }
}

/* ------------------------------------------------------------------ */
/* Tick                                                               */
/* ------------------------------------------------------------------ */

/*
 * Parks a slot the BTS is holding paused.
 *
 * Reached either from a running engine state (the watchdog fired while the
 * link was down and the BTS pulled the slot's power) or from IDLE at boot
 * (the unit reset and restored the run from F-RAM). Both stop the local
 * integrators - their totals no longer track the BTS's, which kept counting
 * up to the pause - and neither resumes anything.
 */
static void enter_bts_paused(uint8_t slot, const bts_channel_state_t *ch)
{
    slot_ctx_t *c = &s_slot[slot];

    coulomb_stop(&c->discharge_cc);
    coulomb_stop(&c->charge_cc);
    c->power_started = false;

    ESP_LOGW(TAG, "slot %u held PAUSED by the BTS (%s), was %s; counters kept "
                  "(%.0f mAh in / %.0f mAh out) - resume is an operator action",
             slot,
             ch->restored     ? "restored from F-RAM after a unit reset"
             : ch->wd_tripped ? "host watchdog timed out"
                              : "paused by command",
             (ch->status_bits & BTS_STATUS_CHARGING) ? "charging" : "discharging",
             ch->charge_mah, ch->discharge_mah);

    enter_state(slot, SLOT_STATE_BTS_PAUSED);
}

static void tick_slot(uint8_t slot, const bts_snapshot_t *snap)
{
    slot_ctx_t                *c  = &s_slot[slot];
    const bts_channel_state_t *ch = &snap->channel[slot];

    /*
     * A paused slot outranks everything below, including the safety checks:
     * the converter is already off and the counters are intact, so faulting
     * it would only lose the reason it is paused. IDLE is included because
     * that is how a run the engine never started - restored from F-RAM at
     * boot - becomes visible. FAULT and ABORTED are not: an operator has to
     * see those, and the engine stopped the channel on the way in, so the
     * BTS cannot be holding a run for one of them.
     */
    const bool adoptable = (c->state == SLOT_STATE_IDLE) ||
                           state_is_powered(c->state) ||
                           c->state == SLOT_STATE_CHECK_REST ||
                           c->state == SLOT_STATE_REST ||
                           c->state == SLOT_STATE_DISCHARGE_REST;
    if (ch->valid && ch->paused && adoptable) {
        enter_bts_paused(slot, ch);
        return;
    }

    switch (c->state) {
    case SLOT_STATE_IDLE:
    case SLOT_STATE_COMPLETE:
    case SLOT_STATE_FAULT:
    case SLOT_STATE_ABORTED:
        return;
    case SLOT_STATE_BTS_PAUSED:
        /* Leaves only when the BTS itself says the slot is no longer
         * paused: an operator resume, or an abort that stopped it. */
        if (ch->valid && !ch->paused) {
            ESP_LOGI(TAG, "slot %u no longer paused on the BTS", slot);
            enter_state(slot, SLOT_STATE_IDLE);
        }
        return;
    default:
        break;
    }

    const slot_fault_t f = check_safety(slot, snap);
    if (f != SLOT_FAULT_NONE) {
        fail(slot, f);
        return;
    }

    switch (c->state) {
    case SLOT_STATE_CHECK_REST:     tick_check_rest(slot, ch);           break;
    case SLOT_STATE_CHARGE:         tick_charge(slot, ch);               break;
    case SLOT_STATE_REST:           tick_rest(slot, ch);                 break;
    case SLOT_STATE_DISCHARGE:      tick_discharge(slot, ch);            break;
    case SLOT_STATE_DISCHARGE_REST: tick_discharge_rest(slot, ch, snap); break;
    case SLOT_STATE_RECHARGE:       tick_recharge(slot, ch, snap);       break;
    default:                                                             break;
    }
}

/* ------------------------------------------------------------------ */
/* Status                                                             */
/* ------------------------------------------------------------------ */

/* Caller holds s_lock. `snap` may be NULL, in which case a fresh one is taken. */
static void fill_status_locked(uint8_t slot, const bts_snapshot_t *snap,
                               slot_status_t *out)
{
    const slot_ctx_t *c = &s_slot[slot];
    bts_snapshot_t local;

    if (snap == NULL) {
        bts_link_get_snapshot(&local);
        snap = &local;
    }
    const bts_channel_state_t *ch = &snap->channel[slot];

    memset(out, 0, sizeof(*out));
    out->state       = c->state;
    out->fault       = c->fault;
    out->configured  = c->configured;
    out->config      = c->config;
    out->profile     = c->profile;
    out->voltage_v   = ch->cell_voltage_v;
    out->current_a   = ch->cell_current_a;
    out->temp_c      = ch->cell_temp_c;
    out->status_bits = ch->status_bits;
    out->last_result = c->result;

    out->bts_paused            = ch->paused;
    out->bts_wd_tripped        = ch->wd_tripped;
    out->bts_restored          = ch->restored;
    out->bts_ended             = ch->ended;
    out->bts_charge_mah        = ch->charge_mah;
    out->bts_charge_mwh        = ch->charge_mwh;
    out->bts_charge_seconds    = ch->charge_seconds;
    out->bts_discharge_mah     = ch->discharge_mah;
    out->bts_discharge_mwh     = ch->discharge_mwh;
    out->bts_discharge_seconds = ch->discharge_seconds;

    out->elapsed_s       = seconds_since(c->test_started_us);
    out->state_elapsed_s = seconds_since(c->state_entered_us);

    switch (c->state) {
    case SLOT_STATE_DISCHARGE:
        out->live_mah = c->discharge_cc.mah;
        out->live_mwh = c->discharge_cc.mwh;
        out->progress = (c->profile.capacity_mah > 0.0f)
                            ? (float)(c->discharge_cc.mah / c->profile.capacity_mah)
                            : 0.0f;
        break;
    case SLOT_STATE_CHARGE:
        out->live_mah = c->charge_cc.mah;
        out->live_mwh = c->charge_cc.mwh;
        out->progress = (c->profile.capacity_mah > 0.0f)
                            ? (float)(c->charge_cc.mah / c->profile.capacity_mah)
                            : 0.0f;
        break;
    case SLOT_STATE_RECHARGE:
        out->live_mah = c->charge_cc.mah;
        out->live_mwh = c->charge_cc.mwh;
        out->progress = (c->recharge_target_mah > 0.0f)
                            ? (float)(c->charge_cc.mah / c->recharge_target_mah)
                            : 0.0f;
        break;
    case SLOT_STATE_REST:
        out->progress = (c->profile.rest_minutes > 0)
                            ? (float)out->state_elapsed_s /
                              (float)(c->profile.rest_minutes * 60u)
                            : 1.0f;
        break;
    case SLOT_STATE_DISCHARGE_REST:
        out->live_mah = c->discharge_cc.mah;
        out->live_mwh = c->discharge_cc.mwh;
        out->progress = (float)out->state_elapsed_s / (float)DISCHARGE_SETTLE_S;
        break;
    case SLOT_STATE_COMPLETE:
        out->live_mah = c->result.discharge_mah;
        out->live_mwh = c->result.discharge_mwh;
        out->progress = 1.0f;
        break;
    case SLOT_STATE_BTS_PAUSED:
        /*
         * Report the BTS's figures, not the local integrator's: the run may
         * predate this boot entirely, and where both exist the BTS's are the
         * ones that kept counting up to the pause.
         */
        out->live_mah = (ch->status_bits & BTS_STATUS_CHARGING)
                            ? ch->charge_mah : ch->discharge_mah;
        out->live_mwh = (ch->status_bits & BTS_STATUS_CHARGING)
                            ? ch->charge_mwh : ch->discharge_mwh;
        out->progress = (c->profile.capacity_mah > 0.0f)
                            ? (float)(out->live_mah / c->profile.capacity_mah)
                            : 0.0f;
        break;
    default:
        break;
    }
}

void test_engine_get_status(uint8_t slot, slot_status_t *out)
{
    if (slot >= SLOT_COUNT || out == NULL) {
        return;
    }
    if (xSemaphoreTake(s_lock, pdMS_TO_TICKS(200)) == pdTRUE) {
        fill_status_locked(slot, NULL, out);
        xSemaphoreGive(s_lock);
    } else {
        memset(out, 0, sizeof(*out));
    }
}

esp_err_t test_engine_get_result(uint8_t slot, slot_result_t *out)
{
    if (slot >= SLOT_COUNT || out == NULL) {
        return ESP_ERR_INVALID_ARG;
    }
    esp_err_t err = ESP_ERR_NOT_FOUND;
    if (xSemaphoreTake(s_lock, pdMS_TO_TICKS(200)) == pdTRUE) {
        if (s_slot[slot].result.valid) {
            *out = s_slot[slot].result;
            err = ESP_OK;
        }
        xSemaphoreGive(s_lock);
    }
    if (err != ESP_OK) {
        /* Fall back to whatever survived the last reboot. */
        err = result_store_load_latest(slot, out);
    }
    return err;
}

/* ------------------------------------------------------------------ */
/* Engine task                                                        */
/* ------------------------------------------------------------------ */

static void engine_task(void *arg)
{
    (void)arg;
    bts_snapshot_t snap;
    static slot_status_t pending[SLOT_COUNT];   /* too large for the stack */
    bool fire[SLOT_COUNT];

    for (;;) {
        bts_link_get_snapshot(&snap);
        memset(fire, 0, sizeof(fire));

        if (xSemaphoreTake(s_lock, pdMS_TO_TICKS(200)) == pdTRUE) {
            for (uint8_t slot = 0; slot < SLOT_COUNT; slot++) {
                tick_slot(slot, &snap);
                if (s_slot[slot].changed) {
                    s_slot[slot].changed = false;
                    fill_status_locked(slot, &snap, &pending[slot]);
                    fire[slot] = true;
                }
            }
            xSemaphoreGive(s_lock);
        }

        /* Notifications go out with the lock dropped. */
        slot_change_cb_t cb = s_change_cb;
        if (cb != NULL) {
            for (uint8_t slot = 0; slot < SLOT_COUNT; slot++) {
                if (fire[slot]) {
                    cb(slot, &pending[slot]);
                }
            }
        }

        vTaskDelay(pdMS_TO_TICKS(TICK_MS));
    }
}

/* ------------------------------------------------------------------ */
/* Control                                                            */
/* ------------------------------------------------------------------ */

esp_err_t test_engine_configure(uint8_t slot, const slot_config_t *config)
{
    if (!s_ready || slot >= SLOT_COUNT || config == NULL) {
        return ESP_ERR_INVALID_ARG;
    }

    cell_resolved_profile_t profile;
    esp_err_t err = cell_profile_resolve(config->chemistry,
                                         config->model_name,
                                         config->capacity_mah,
                                         config->charge_c,
                                         config->discharge_c,
                                         &profile);
    if (err != ESP_OK) {
        return err;
    }

    if (xSemaphoreTake(s_lock, portMAX_DELAY) != pdTRUE) {
        return ESP_ERR_TIMEOUT;
    }

    slot_ctx_t *c = &s_slot[slot];
    if (c->state != SLOT_STATE_IDLE && c->state != SLOT_STATE_COMPLETE &&
        c->state != SLOT_STATE_ABORTED && c->state != SLOT_STATE_FAULT) {
        xSemaphoreGive(s_lock);
        ESP_LOGW(TAG, "slot %u busy in %s, refusing reconfigure",
                 slot, slot_state_name(c->state));
        return ESP_ERR_INVALID_STATE;
    }

    c->config     = *config;
    c->profile    = profile;
    c->configured = true;
    c->changed    = true;

    xSemaphoreGive(s_lock);

    /*
     * Push the limits now rather than waiting for the start, so the slot is
     * visibly provisioned and a bad profile is rejected before a cell is
     * committed to it.
     */
    bts_channel_limits_t limits;
    cell_profile_to_bts_limits(&profile, &limits);
    esp_err_t lim_err = bts_link_set_limits(slot, &limits);
    if (lim_err != ESP_OK) {
        ESP_LOGW(TAG, "slot %u: limits not pushed (%s); will retry at start",
                 slot, esp_err_to_name(lim_err));
    }

    ESP_LOGI(TAG, "slot %u configured: %s %s %.0f mAh, chg %.2f A dchg %.2f A, "
                  "%.2f-%.2f V",
             slot, cell_chemistry_name(profile.chemistry),
             profile.model_name[0] ? profile.model_name : "(generic)",
             profile.capacity_mah, profile.charge_current_a,
             profile.discharge_current_a, profile.discharge_v_min,
             profile.charge_v_max);

    return ESP_OK;
}

esp_err_t test_engine_start(uint8_t slot)
{
    if (!s_ready || slot >= SLOT_COUNT) {
        return ESP_ERR_INVALID_ARG;
    }
    if (xSemaphoreTake(s_lock, portMAX_DELAY) != pdTRUE) {
        return ESP_ERR_TIMEOUT;
    }

    slot_ctx_t *c = &s_slot[slot];
    esp_err_t err = ESP_OK;

    if (!c->configured) {
        err = ESP_ERR_INVALID_STATE;
    } else if (c->state != SLOT_STATE_IDLE && c->state != SLOT_STATE_COMPLETE &&
               c->state != SLOT_STATE_ABORTED) {
        /*
         * A FAULT must be cleared explicitly, so an operator has to see it.
         * BTS_PAUSED is refused for the same reason and one more: the slot
         * holds a live run with intact counters, and starting a new test
         * over the top would discard it.
         */
        err = ESP_ERR_INVALID_STATE;
    } else {
        memset(&c->result, 0, sizeof(c->result));
        memset(&c->discharge_cc, 0, sizeof(c->discharge_cc));
        memset(&c->charge_cc, 0, sizeof(c->charge_cc));
        c->fault               = SLOT_FAULT_NONE;
        c->result_saved        = false;
        c->recharge_target_mah = 0.0f;
        c->mode_issued_us      = 0;
        c->test_started_us     = esp_timer_get_time();
        /* Stopped first: CHECK_REST needs an open-circuit reading. */
        bts_link_stop_channel(slot);
        enter_state(slot, SLOT_STATE_CHECK_REST);
    }

    xSemaphoreGive(s_lock);

    if (err != ESP_OK) {
        ESP_LOGW(TAG, "slot %u start refused (%s)", slot, esp_err_to_name(err));
    }
    return err;
}

esp_err_t test_engine_abort(uint8_t slot)
{
    if (!s_ready || slot >= SLOT_COUNT) {
        return ESP_ERR_INVALID_ARG;
    }
    if (xSemaphoreTake(s_lock, portMAX_DELAY) != pdTRUE) {
        return ESP_ERR_TIMEOUT;
    }

    slot_ctx_t *c = &s_slot[slot];
    bts_link_stop_channel(slot);
    coulomb_stop(&c->discharge_cc);
    coulomb_stop(&c->charge_cc);

    if (c->state != SLOT_STATE_IDLE && c->state != SLOT_STATE_COMPLETE) {
        enter_state(slot, SLOT_STATE_ABORTED);
    }
    xSemaphoreGive(s_lock);
    return ESP_OK;
}

esp_err_t test_engine_abort_all(void)
{
    esp_err_t err = ESP_OK;
    for (uint8_t slot = 0; slot < SLOT_COUNT; slot++) {
        esp_err_t one = test_engine_abort(slot);
        if (one != ESP_OK) {
            err = one;
        }
    }
    bts_link_stop_all();
    return err;
}

esp_err_t test_engine_clear_fault(uint8_t slot)
{
    if (!s_ready || slot >= SLOT_COUNT) {
        return ESP_ERR_INVALID_ARG;
    }
    if (xSemaphoreTake(s_lock, portMAX_DELAY) != pdTRUE) {
        return ESP_ERR_TIMEOUT;
    }
    slot_ctx_t *c = &s_slot[slot];
    if (c->state == SLOT_STATE_FAULT || c->state == SLOT_STATE_ABORTED) {
        c->fault = SLOT_FAULT_NONE;
        enter_state(slot, SLOT_STATE_IDLE);
    }
    xSemaphoreGive(s_lock);
    return ESP_OK;
}

/*
 * Pause and resume a run the BTS is holding.
 *
 * Both go straight to the unit's mode register; the engine's own state
 * follows on the next tick from the status bits, so there is exactly one
 * place that decides what a paused slot means. A resume is only offered for
 * a slot the BTS reports paused - in particular it must never be issued
 * automatically for a RESTORED slot, because the cell may have been changed
 * while the unit was off.
 */
esp_err_t test_engine_pause(uint8_t slot)
{
    if (!s_ready || slot >= SLOT_COUNT) {
        return ESP_ERR_INVALID_ARG;
    }

    bts_snapshot_t snap;
    bts_link_get_snapshot(&snap);
    if (!snap.channel[slot].valid) {
        return ESP_ERR_INVALID_STATE;
    }
    if (snap.channel[slot].paused) {
        return ESP_OK;
    }
    if (!(snap.channel[slot].status_bits & BTS_STATUS_RUNNING)) {
        return ESP_ERR_INVALID_STATE;
    }

    ESP_LOGI(TAG, "slot %u: pause requested", slot);
    return bts_link_pause_channel(slot);
}

esp_err_t test_engine_resume(uint8_t slot)
{
    if (!s_ready || slot >= SLOT_COUNT) {
        return ESP_ERR_INVALID_ARG;
    }

    bts_snapshot_t snap;
    bts_link_get_snapshot(&snap);
    if (!snap.channel[slot].valid || !snap.channel[slot].paused) {
        return ESP_ERR_INVALID_STATE;
    }

    ESP_LOGW(TAG, "slot %u: operator resume of a %s pause", slot,
             snap.channel[slot].restored     ? "restored"
             : snap.channel[slot].wd_tripped ? "watchdog"
                                             : "commanded");
    return bts_link_resume_channel(slot);
}

esp_err_t test_engine_set_serial(uint8_t slot, const char *serial)
{
    if (!s_ready || slot >= SLOT_COUNT || serial == NULL) {
        return ESP_ERR_INVALID_ARG;
    }
    if (xSemaphoreTake(s_lock, portMAX_DELAY) != pdTRUE) {
        return ESP_ERR_TIMEOUT;
    }

    slot_ctx_t *c = &s_slot[slot];
    snprintf(c->config.serial, sizeof(c->config.serial), "%s", serial);

    /*
     * A barcode scanned after the test finished still belongs on the result,
     * so patch and re-persist it as long as the slot has not been restarted.
     */
    esp_err_t err = ESP_OK;
    if (c->result.valid) {
        snprintf(c->result.serial, sizeof(c->result.serial), "%s", serial);
        if (c->result_saved) {
            err = result_store_save(slot, &c->result);
        }
    }
    c->changed = true;
    xSemaphoreGive(s_lock);

    ESP_LOGI(TAG, "slot %u serial set to '%s'", slot, serial);
    return err;
}

void test_engine_set_change_callback(slot_change_cb_t cb)
{
    s_change_cb = cb;
}

/* ------------------------------------------------------------------ */
/* Init                                                               */
/* ------------------------------------------------------------------ */

/*
 * Boot-time channel sweep.
 *
 * The proxy runs on a backup battery and can come up while the BTS is
 * mid-test from a previous session, so the default assumption is that
 * nothing should be on load until an operator says so.
 *
 * The exception is a slot the BTS reports PAUSED. Its converter is already
 * off and its counters are intact; a stop here would discard the run the
 * unit deliberately preserved - which is exactly what a restored slot is
 * for. Leave it alone and let the first tick park it in BTS_PAUSED.
 *
 * Deciding that needs one good poll, and bts_link_init() only starts the
 * poll task, so wait briefly for it. A unit that never answers falls through
 * and every slot is stopped - the safe direction, and a stop aimed at an
 * unreachable unit does nothing anyway.
 */
#define BOOT_SNAPSHOT_WAIT_MS   1500

static void stop_unheld_channels(void)
{
    bts_snapshot_t snap;
    const int64_t deadline = esp_timer_get_time() + (BOOT_SNAPSHOT_WAIT_MS * 1000LL);

    for (;;) {
        bts_link_get_snapshot(&snap);
        if (snap.channel[0].valid || esp_timer_get_time() >= deadline) {
            break;
        }
        vTaskDelay(pdMS_TO_TICKS(50));
    }

    for (uint8_t slot = 0; slot < SLOT_COUNT; slot++) {
        if (snap.channel[slot].valid && snap.channel[slot].paused) {
            ESP_LOGW(TAG, "slot %u came up PAUSED%s - left held, "
                          "awaiting an operator resume", slot,
                     snap.channel[slot].restored ? " (restored)" : "");
            continue;
        }
        bts_link_stop_channel(slot);
    }
}

esp_err_t test_engine_init(void)
{
    s_lock = xSemaphoreCreateMutex();
    if (s_lock == NULL) {
        return ESP_ERR_NO_MEM;
    }

    memset(s_slot, 0, sizeof(s_slot));
    for (uint8_t slot = 0; slot < SLOT_COUNT; slot++) {
        s_slot[slot].state = SLOT_STATE_IDLE;
        /*
         * Surface the last result across a reboot, so a power cut mid-shift
         * does not make a tested slot look like it was never run.
         */
        if (result_store_load_latest(slot, &s_slot[slot].result) != ESP_OK) {
            s_slot[slot].result.valid = false;
        } else {
            s_slot[slot].result_saved = true;
        }
    }

    stop_unheld_channels();

    s_ready = true;

    BaseType_t ok = xTaskCreate(engine_task, "test_engine", TASK_STACK,
                                NULL, TASK_PRIO, NULL);
    if (ok != pdPASS) {
        s_ready = false;
        return ESP_ERR_NO_MEM;
    }

    ESP_LOGI(TAG, "test engine ready, %d slots, BTS accumulators %s",
             SLOT_COUNT, bts_link_stats_are_live() ? "live" : "not populated");
    return ESP_OK;
}
