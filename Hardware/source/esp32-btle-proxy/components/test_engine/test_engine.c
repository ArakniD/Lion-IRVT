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
#include "nvs.h"
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

/*
 * A charge that reaches charge_v_max plus this has escaped its CV loop.
 *
 * The C2000 regulates the charge ceiling; the engine never used to check it,
 * so when the CV controller failed to take over (2026-11-09, slot 8: CV held
 * off by stale integrator state) a 4.20 V cell was charged at full current to
 * 4.445 V and only a hardware trip stopped it. 50 mV clears the loop's
 * regulation band and sense noise, and is well short of an unsafe voltage.
 */
#define OVER_VOLTAGE_MARGIN_V   0.050f

/*
 * A discharge that is moving charge INTO the cell has reached its floor.
 *
 * The C2000 used to do exactly this: its CV clamp was symmetric, so once the
 * cell sagged below V_MIN the loop pushed charge back in to hold it there,
 * and the cell never sat under the cutoff long enough for either end of the
 * link to call the discharge finished. Seen on hardware 2026-11-07 - +2.8 A
 * into a cell the engine believed was discharging, then -8 A, then +2.8 A,
 * round and round. The C2000 now clamps that output to its own direction,
 * but the engine must not depend on it: a discharge reading this much
 * CHARGING current for this long is over, whatever the voltage says.
 */
#define REVERSE_CURRENT_A       0.10f
#define REVERSE_CURRENT_TICKS   4       /* 1 s at TICK_MS */

/* Input-window fault: must be reported this many ticks in a row. */
#define UNIT_STATE_TICKS        4       /* 1 s at TICK_MS */

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

    /* SLOT_STATE_DIRECT only: which way the bare run goes. */
    bool                    direct_charge;

    /* The last mode start_power() sent, and whether it has been re-sent. */
    uint32_t                start_mode;
    bool                    start_retried;

    /* Consecutive ticks a discharge has read charging current. */
    uint8_t                 reverse_ticks;

    /* Consecutive ticks the unit has reported its input outside the window. */
    uint8_t                 unit_state_ticks;

    /*
     * The powered state a BTS_PAUSED slot goes back to on a resume, or IDLE
     * when there is nothing to pick up: a slot restored from F-RAM after a
     * reset was never this engine's run. See enter_bts_paused().
     */
    slot_state_t            resume_state;

    /*
     * When the current BTS pause began, 0 when not paused. A pause is not
     * test time: the clocks are stopped at this instant and, on a resume,
     * every start time is moved forward by the length of the pause - so the
     * elapsed time, the time limit and the result's discharge seconds all
     * count only time the stage was actually driving.
     */
    int64_t                 paused_since_us;

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
    "BTS_PAUSED", "DIRECT",
};

static const char *k_fault_names[SLOT_FAULT_COUNT] = {
    "NONE", "OVER_TEMP", "UNDER_TEMP", "OVER_CURRENT", "CMPSS_TRIP",
    "GPIO_TRIP", "TIMEOUT", "BTS_OFFLINE", "UNIT_STATE", "NO_CELL",
    "CELL_REVERSED", "COMMS", "OVER_VOLTAGE", "DISCONNECT",
};

const char *slot_state_name(slot_state_t state)
{
    return (state < SLOT_STATE_COUNT) ? k_state_names[state] : "?";
}

const char *slot_fault_name(slot_fault_t fault)
{
    return (fault < SLOT_FAULT_COUNT) ? k_fault_names[fault] : "?";
}

static uint32_t test_elapsed_s(const slot_ctx_t *c);

static inline uint32_t seconds_since(int64_t us)
{
    if (us == 0) {
        return 0;
    }
    const int64_t d = esp_timer_get_time() - us;
    return (d > 0) ? (uint32_t)(d / 1000000) : 0;
}

/*
 * The test's elapsed run time, with any pause taken out. While paused the
 * clock reads as it did the moment the pause began; leave_bts_paused() then
 * moves the start forward by the pause's length, so it carries on from there.
 */
static uint32_t test_elapsed_s(const slot_ctx_t *c)
{
    if (c->test_started_us == 0) {
        return 0;
    }
    const int64_t end = (c->paused_since_us != 0) ? c->paused_since_us
                                                  : esp_timer_get_time();
    const int64_t d = end - c->test_started_us;
    return (d > 0) ? (uint32_t)(d / 1000000) : 0;
}

/* True while the power stage is meant to be enabled. */
static inline bool state_is_powered(slot_state_t s)
{
    return s == SLOT_STATE_CHARGE ||
           s == SLOT_STATE_DISCHARGE ||
           s == SLOT_STATE_RECHARGE ||
           s == SLOT_STATE_DIRECT;
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
    c->reverse_ticks    = 0;
    c->unit_state_ticks = 0;
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

    /*
     * The unit has one current setpoint for both directions, so it is written
     * for the direction starting now: a charge regulates to the charge current
     * and tapers out at the termination current, a discharge to the discharge
     * current.
     */
    const bts_limits_dir_t dir = (mode & BTS_MODE_CHARGE) ? BTS_LIMITS_CHARGE
                                                          : BTS_LIMITS_DISCHARGE;
    esp_err_t err = bts_link_set_limits(slot, &limits, dir);
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "slot %u limit write failed: %s", slot, esp_err_to_name(err));
        return err;
    }
    ESP_LOGI(TAG, "slot %u: %s at %.3f A (taper %.3f A), %.3f-%.3f V", slot,
             dir == BTS_LIMITS_CHARGE ? "charge" : "discharge",
             dir == BTS_LIMITS_CHARGE ? limits.charge_current_max
                                      : limits.discharge_current_max,
             dir == BTS_LIMITS_CHARGE ? limits.charge_current_min : 0.0f,
             limits.discharge_voltage_min, limits.charge_voltage_max);

    err = bts_link_set_mode(slot, mode);
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "slot %u mode write failed: %s", slot, esp_err_to_name(err));
        return err;
    }

    c->mode_issued_us = esp_timer_get_time();
    c->power_started  = true;
    c->start_retried  = false;
    c->start_mode     = mode;
    return ESP_OK;
}

/*
 * Re-sends a start the unit has not acted on.
 *
 * The write pacing in bts_link should stop the C2000 dropping a mode write,
 * but the mode register reads back whatever was written even when CPU1 never
 * saw it, so the only proof a start landed is the RUNNING bit. If it is still
 * clear a second after the mode went out - well past the 250 ms poll - the
 * mode is written once more. Only once: a slot that refuses twice is refusing
 * for a reason (the unit's input window, a latched trip), and the engine's own
 * checks will say which.
 */
static void retry_unstarted(uint8_t slot, const bts_channel_state_t *ch)
{
    slot_ctx_t *c = &s_slot[slot];
    if (!c->power_started || c->start_retried || !ch->valid) {
        return;
    }
    if (ch->status_bits & (BTS_STATUS_RUNNING | BTS_STATUS_ENDED_MASK)) {
        c->start_retried = true;    /* it landed; nothing to do */
        return;
    }
    if ((esp_timer_get_time() - c->mode_issued_us) < 1000000LL) {
        return;
    }
    c->start_retried = true;
    ESP_LOGW(TAG, "slot %u: start not seen by the unit after 1 s; re-sending "
                  "mode 0x%02X", slot, (unsigned)c->start_mode);
    if (bts_link_set_mode(slot, c->start_mode) == ESP_OK) {
        c->mode_issued_us = esp_timer_get_time();
    }
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
    /*
     * The C2000 stopped the slot because its two voltage readings disagreed
     * (serviceDivergenceFault) or a group member strayed. Before this check
     * the engine read only "stopped" and took it for a finished phase: slot 8
     * on 2026-11-12 'started' a charge that never drew current, sat in CHARGE
     * for three minutes, was stopped with this bit set, and the engine
     * carried on into REST as if the charge had completed.
     */
    if (state_is_powered(c->state) && c->power_started &&
        (ch->status_bits & BTS_STATUS_GROUP_DISCONNECT)) {
        return SLOT_FAULT_DISCONNECT;
    }

    if (ch->cell_temp_c > c->profile.temp_max_c) {
        return SLOT_FAULT_OVER_TEMP;
    }
    if (ch->cell_temp_c < c->profile.temp_min_c) {
        return SLOT_FAULT_UNDER_TEMP;
    }

    if (state_is_powered(c->state) && c->power_started) {
        const bool discharging = (c->state == SLOT_STATE_DISCHARGE) ||
                                 (c->state == SLOT_STATE_DIRECT && !c->direct_charge);
        const float setpoint = discharging ? c->profile.discharge_current_a
                                           : c->profile.charge_current_a;
        /* Skip the first couple of seconds: the loop is still ramping. */
        if (seconds_since(c->mode_issued_us) > 2 &&
            fabsf(ch->sense_current_a) > setpoint * OVER_CURRENT_MARGIN) {
            return SLOT_FAULT_OVER_CURRENT;
        }
        if (!discharging && c->profile.charge_v_max > 0.0f &&
            ch->sense_voltage_v > c->profile.charge_v_max + OVER_VOLTAGE_MARGIN_V) {
            return SLOT_FAULT_OVER_VOLTAGE;
        }

        /*
         * The unit refuses to start, and will stop, outside its input
         * window. Treat the disabled states as a fault so the operator sees
         * why the test stalled rather than watching it sit at 0 A.
         */
        /*
         * Held for UNIT_STATE_TICKS consecutive ticks before it counts. The
         * unit stops the channel itself the instant its input leaves the
         * window, so this fault only has to explain the stall, not cause the
         * stop - and a single misread status word faulted slot 1 on
         * 2026-11-11 with the input at 14.0 V the whole time.
         */
        const bool bad_input =
            (snap->unit.unit_state == BTS_UNIT_INPUT_LOW_CHARGE_DISABLED && !discharging) ||
            (snap->unit.unit_state == BTS_UNIT_INPUT_HIGH_DISCHARGE_DISABLED && discharging);
        slot_ctx_t *cm = &s_slot[slot];
        if (!bad_input) {
            cm->unit_state_ticks = 0;
        } else if (++cm->unit_state_ticks >= UNIT_STATE_TICKS) {
            return SLOT_FAULT_UNIT_STATE;
        }
    }

    const uint32_t limit_min = c->config.max_duration_minutes
                                   ? c->config.max_duration_minutes
                                   : DEFAULT_MAX_MINUTES;
    if (c->test_started_us != 0 && test_elapsed_s(c) > limit_min * 60u) {
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

    const float v = ch->sense_voltage_v;

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

    coulomb_update(&c->charge_cc, ch->sense_voltage_v, ch->sense_current_a,
                   ch->cell_temp_c, esp_timer_get_time());

    /*
     * Termination: the BTS runs CC up to ChargeVoltageMax then CV, tapering
     * toward iref_cuttout_A (which cell_profile_to_bts_limits() sets from
     * charge_term_c). Full is "in CV and the current has fallen to the
     * taper threshold". The voltage-plus-taper arm is a fallback for a BTS
     * build that does not publish the CV status bit - which every build did
     * until the firmware moved to CCCV; before that the CC-only control law
     * pinned ctrlMode_logic to 0 and this bit never set.
     *
     * The BTS now terminates a charge itself on the same condition, so
     * bts_says_done() below will usually fire first. This arm remains as the
     * host-side check.
     */
    const bool in_cv      = ch->const_voltage;
    const bool tapered    = fabsf(ch->sense_current_a) <= c->profile.charge_term_current_a;
    const bool at_voltage = ch->sense_voltage_v >= c->profile.charge_v_max - 0.005f;

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
        c->result.start_voltage_v = ch->sense_voltage_v;
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

    /*
     * Discharge current is negative. Only that sign is integrated: the
     * counter takes |I|, so a charging current fed to it would be ADDED to
     * the discharge total - which is how a loop holding the cell at its floor
     * would have inflated the capacity figure.
     */
    const bool reversed = ch->sense_current_a > REVERSE_CURRENT_A;
    coulomb_update(&c->discharge_cc, ch->sense_voltage_v,
                   reversed ? 0.0f : ch->sense_current_a,
                   ch->cell_temp_c, esp_timer_get_time());

    /*
     * The engine owns the cutoff. Require the cell to actually be under load
     * before believing the voltage, otherwise the first samples - taken
     * while the power stage is still ramping - can read below the cutoff on
     * a sagging cell and end the test immediately.
     *
     * Charging current in a discharge also ends it - see REVERSE_CURRENT_A.
     * The grace period is the same one bts_says_done() uses, so the ramp
     * and the unit's first status publish cannot trip it.
     */
    const bool under_load = fabsf(ch->sense_current_a) > 0.05f;
    const bool at_cutoff  = ch->sense_voltage_v <= c->profile.discharge_v_min;

    if (reversed &&
        (esp_timer_get_time() - c->mode_issued_us) >= (MODE_GRACE_MS * 1000LL)) {
        if (c->reverse_ticks < REVERSE_CURRENT_TICKS) {
            c->reverse_ticks++;
        }
    } else {
        c->reverse_ticks = 0;
    }
    const bool held_at_floor = c->reverse_ticks >= REVERSE_CURRENT_TICKS;

    if ((under_load && at_cutoff) || held_at_floor || bts_says_done(c, ch)) {
        if (held_at_floor) {
            ESP_LOGW(TAG, "slot %u: discharge reading +%.2f A at %.3f V - the "
                          "unit is holding the cell at its floor; ending the "
                          "discharge", slot, ch->sense_current_a,
                     ch->sense_voltage_v);
        }
        bts_link_stop_channel(slot);
        coulomb_stop(&c->discharge_cc);

        slot_result_t *r = &c->result;
        r->end_voltage_v     = ch->sense_voltage_v;
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
        c->result.rested_voltage_v = ch->sense_voltage_v;
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

    /* Charge current is positive; only that sign counts toward the target. */
    coulomb_update(&c->charge_cc, ch->sense_voltage_v,
                   (ch->sense_current_a > 0.0f) ? ch->sense_current_a : 0.0f,
                   ch->cell_temp_c, esp_timer_get_time());

    /*
     * Terminated by coulomb count, not by voltage: the point of the shipping
     * state is a defined state of charge, and resting voltage is a poor SoC
     * proxy on a flat-plateau chemistry like LFP. charge_v_max remains a
     * hard backstop in case the target is unreachable.
     */
    const bool at_target  = c->charge_cc.mah >= (double)c->recharge_target_mah;
    const bool at_ceiling = ch->sense_voltage_v >= c->profile.charge_v_max;

    if (at_target || at_ceiling || bts_says_done(c, ch)) {
        bts_link_stop_channel(slot);
        coulomb_stop(&c->charge_cc);

        c->result.recharged          = true;
        c->result.recharge_mah       = (float)c->charge_cc.mah;
        c->result.shipping_voltage_v = ch->sense_voltage_v;

        if (at_ceiling && !at_target) {
            ESP_LOGW(TAG, "slot %u: recharge hit the %.3f V ceiling at %.0f of "
                          "%.0f mAh", slot, ch->sense_voltage_v,
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
 * Reached either from a running engine state (the watchdog fired, or an
 * operator paused it) or from IDLE at boot (the unit reset and restored the
 * run from F-RAM). The integrators are stopped, not reset: a resume of this
 * engine's own run continues them from where they froze.
 *
 * The phase it was in is remembered, so a resume puts the slot back under
 * supervision in that phase - its cutoff, its termination and its result -
 * rather than dropping it to IDLE while the BTS drives it unsupervised.
 */
static void enter_bts_paused(uint8_t slot, const bts_channel_state_t *ch)
{
    slot_ctx_t *c = &s_slot[slot];

    coulomb_stop(&c->discharge_cc);
    coulomb_stop(&c->charge_cc);
    c->power_started = false;
    if (c->paused_since_us == 0) {
        c->paused_since_us = esp_timer_get_time();
    }

    /*
     * A restored slot was never this engine's run - the ESP32 restarted too,
     * or the BTS kept the run across a reset the engine never saw - so there
     * is no sequence to go back to. It resumes as a bare run in the direction
     * the BTS held. CHECK_REST and the two rests have no power to resume; a
     * pause landing in one of them returns to it.
     */
    if (c->state == SLOT_STATE_IDLE || ch->restored) {
        c->resume_state = SLOT_STATE_DIRECT;
        c->direct_charge = (ch->status_bits & BTS_STATUS_CHARGING) != 0;
    } else {
        c->resume_state = c->state;
    }

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

/*
 * Puts a resumed slot back into the phase it was paused in.
 *
 * Called once the BTS reports the slot running again. The limits were
 * already re-applied by test_engine_resume() before the resume went out, and
 * the BTS re-latches them on the resume itself; this restores the engine's
 * side - supervision, the counters and the phase's own termination - without
 * resetting anything a run has accumulated.
 */
static void leave_bts_paused(uint8_t slot)
{
    slot_ctx_t *c = &s_slot[slot];
    const slot_state_t back = c->resume_state;

    /*
     * Take the pause back out of every clock that spans it, so a test paused
     * overnight resumes at the elapsed time it was paused at rather than one
     * eight hours later - and so the pause cannot trip the time limit.
     */
    if (c->paused_since_us != 0) {
        const int64_t gap = esp_timer_get_time() - c->paused_since_us;
        if (gap > 0) {
            if (c->test_started_us != 0) {
                c->test_started_us += gap;
            }
            if (c->discharge_cc.start_us != 0) {
                c->discharge_cc.start_us += gap;
            }
            if (c->charge_cc.start_us != 0) {
                c->charge_cc.start_us += gap;
            }
        }
        c->paused_since_us = 0;
    }

    enter_state(slot, back);

    if (!state_is_powered(back)) {
        /* A rest or the open-circuit check: the timer restarts, which is the
         * conservative reading of "paused while resting". */
        return;
    }

    /*
     * enter_state() cleared power_started, which would make the phase's
     * handler issue a fresh start - and a fresh start zeroes the BTS's
     * counters for that direction. The stage is already running on the
     * resume, so mark it started and pick the integrators up where they
     * froze.
     */
    c->power_started  = true;
    c->start_retried  = true;
    c->mode_issued_us = esp_timer_get_time();

    if (back == SLOT_STATE_DIRECT) {
        /* A bare run keeps no integrator - the BTS's counters are its
         * figures, and they carry on from the pause by themselves. */
        if (c->test_started_us == 0) {
            c->test_started_us = esp_timer_get_time();
        }
        ESP_LOGI(TAG, "slot %u resumed as a direct %s", slot,
                 c->direct_charge ? "charge" : "discharge");
        return;
    }

    coulomb_counter_t *cc = (back == SLOT_STATE_DISCHARGE) ? &c->discharge_cc
                                                           : &c->charge_cc;
    if (cc->start_us == 0) {
        /* Never started here - a restored run. Count from now. */
        coulomb_reset(cc);
    } else {
        /* Continue: no credit for the paused interval. */
        cc->running        = true;
        cc->last_sample_us = esp_timer_get_time();
        cc->last_current_a = 0.0f;
        cc->last_power_w   = 0.0f;
    }

    ESP_LOGI(TAG, "slot %u resumed into %s, counters continued", slot,
             slot_state_name(back));
}

/*
 * A bare charge or discharge from test_engine_run_direct().
 *
 * Supervised like a test phase - tick_slot() runs check_safety() before this
 * - but with no sequence to advance: it ends when the BTS terminates it, at
 * the voltage limit, or on an operator stop, and returns to IDLE. No result
 * is recorded; the BTS's per-direction counters hold the figures.
 */
static void tick_direct(uint8_t slot, const bts_channel_state_t *ch)
{
    slot_ctx_t *c = &s_slot[slot];

    if (!ch->valid) {
        return;
    }

    bool done = bts_says_done(c, ch);
    if (c->direct_charge) {
        /* The BTS ends a charge on its own CV taper; this is the fallback. */
        done = done || (ch->const_voltage &&
                        fabsf(ch->sense_current_a) <= c->profile.charge_term_current_a);
    } else {
        const bool under_load = fabsf(ch->sense_current_a) > 0.05f;
        done = done || (under_load && ch->sense_voltage_v <= c->profile.discharge_v_min);

        /* Charging current in a discharge: held at the floor. See
         * REVERSE_CURRENT_A. */
        if (ch->sense_current_a > REVERSE_CURRENT_A &&
            (esp_timer_get_time() - c->mode_issued_us) >= (MODE_GRACE_MS * 1000LL)) {
            if (++c->reverse_ticks >= REVERSE_CURRENT_TICKS) {
                done = true;
            }
        } else {
            c->reverse_ticks = 0;
        }
    }

    if (done) {
        bts_link_stop_channel(slot);
        ESP_LOGI(TAG, "slot %u: direct %s ended at %.3f V", slot,
                 c->direct_charge ? "charge" : "discharge", ch->sense_voltage_v);
        c->test_started_us = 0;
        enter_state(slot, SLOT_STATE_IDLE);
    }
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
        /*
         * Leaves only when the BTS itself says the slot is no longer paused.
         * Running again is a resume: back into the phase it was in, still
         * supervised. Anything else is a stop or an abort, and ends it.
         *
         * It used to go to IDLE either way, so a resumed discharge ran on the
         * BTS with no engine watching its cutoff at all.
         */
        if (ch->valid && !ch->paused) {
            if (ch->status_bits & BTS_STATUS_RUNNING) {
                leave_bts_paused(slot);
            } else {
                ESP_LOGI(TAG, "slot %u no longer paused on the BTS", slot);
                c->test_started_us = 0;
                c->paused_since_us = 0;
                enter_state(slot, SLOT_STATE_IDLE);
            }
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

    if (state_is_powered(c->state)) {
        retry_unstarted(slot, ch);
    }

    switch (c->state) {
    case SLOT_STATE_CHECK_REST:     tick_check_rest(slot, ch);           break;
    case SLOT_STATE_CHARGE:         tick_charge(slot, ch);               break;
    case SLOT_STATE_REST:           tick_rest(slot, ch);                 break;
    case SLOT_STATE_DISCHARGE:      tick_discharge(slot, ch);            break;
    case SLOT_STATE_DISCHARGE_REST: tick_discharge_rest(slot, ch, snap); break;
    case SLOT_STATE_RECHARGE:       tick_recharge(slot, ch, snap);       break;
    case SLOT_STATE_DIRECT:         tick_direct(slot, ch);               break;
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
        bts_snapshot_group_totals(&local);
        snap = &local;
    }
    const bts_channel_state_t *ch = &snap->channel[slot];

    memset(out, 0, sizeof(*out));
    out->state       = c->state;
    out->fault       = c->fault;
    out->configured  = c->configured;
    out->config      = c->config;
    out->profile     = c->profile;
    /* The ADS131M08 pair: what the BTS regulates against and integrates,
     * and what every host now reports as the slot's voltage and current. */
    out->voltage_v   = ch->sense_voltage_v;
    out->current_a   = ch->sense_current_a;
    out->sense_voltage_v = ch->sense_voltage_v;
    out->sense_current_a = ch->sense_current_a;
    out->temp_c      = ch->cell_temp_c;
    out->status_bits = ch->status_bits;
    out->last_result = c->result;

    out->direct_charge         = c->direct_charge;
    out->bts_paused            = ch->paused;
    out->bts_wd_tripped        = ch->wd_tripped;
    out->bts_restored          = ch->restored;
    out->bts_ended             = ch->ended;
    out->bts_const_voltage     = ch->const_voltage;
    out->bts_const_current     = ch->const_current;
    out->bts_waiting           = ch->waiting;
    out->bts_balancing         = ch->balancing;
    out->bts_ready             = ch->ready;
    out->bts_soft_start        = ch->soft_start;
    out->bts_charge_mah        = ch->charge_mah;
    out->bts_charge_mwh        = ch->charge_mwh;
    out->bts_charge_seconds    = ch->charge_seconds;
    out->bts_discharge_mah     = ch->discharge_mah;
    out->bts_discharge_mwh     = ch->discharge_mwh;
    out->bts_discharge_seconds = ch->discharge_seconds;

    out->elapsed_s       = test_elapsed_s(c);
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
        /* A group is supervised as one slot on its leader: the whole group's
         * current against the group's setpoint, every member's trips. */
        bts_snapshot_group_totals(&snap);
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

static float clamp_override(float v, float lo, float hi)
{
    return (v < lo) ? lo : (v > hi) ? hi : v;
}

esp_err_t test_engine_resolve(uint8_t slot, const slot_config_t *config,
                              cell_resolved_profile_t *out)
{
    if (config == NULL || out == NULL || slot >= SLOT_COUNT) {
        return ESP_ERR_INVALID_ARG;
    }
    esp_err_t err = cell_profile_resolve(config->chemistry,
                                         config->model_name,
                                         config->capacity_mah,
                                         config->charge_c,
                                         config->discharge_c,
                                         out);
    if (err != ESP_OK) {
        return err;
    }

    /*
     * Overrides last, then the same envelope cell_profile_resolve() applies.
     * A model's continuous rating is a ceiling an override cannot lift: the
     * front panel makes a big number easy to dial in by accident.
     */
    const cell_model_t *model = cell_model_find(config->model_name);
    /* Per slot, times the slots in a group: the leader's current is a total. */
    const float unit_imax = BTS_UNIT_MAX_CURRENT_A * (float)bts_link_group_members(slot);
    const float chg_cap = (model && model->charge_current_max_a > 0.0f)
                              ? fminf(model->charge_current_max_a, unit_imax)
                              : unit_imax;
    const float dis_cap = (model && model->discharge_current_max_a > 0.0f)
                              ? fminf(model->discharge_current_max_a, unit_imax)
                              : unit_imax;

    /*
     * Voltage and temperature overrides may only be more conservative than
     * the cell's own limits: a lower charge target, a higher cutoff, a lower
     * temperature ceiling. The resolved defaults ARE those limits, so they
     * bound the overrides. An encoder spin that would have walked a 4.2 V
     * target to 5 V stops at 4.2 V.
     */
    const float v_ceiling = out->charge_v_max;
    const float v_floor   = out->discharge_v_min;
    const float t_ceiling = out->temp_max_c;
    if (config->charge_v_max > 0.0f) {
        out->charge_v_max = clamp_override(config->charge_v_max, 0.0f, v_ceiling);
    }
    if (config->discharge_v_min > 0.0f) {
        out->discharge_v_min = clamp_override(config->discharge_v_min, v_floor,
                                              BTS_UNIT_MAX_VOLTAGE_V);
    }
    if (config->charge_current_a > 0.0f) {
        out->charge_current_a = clamp_override(config->charge_current_a, 0.0f, chg_cap);
    }
    if (config->discharge_current_a > 0.0f) {
        out->discharge_current_a = clamp_override(config->discharge_current_a, 0.0f,
                                                  dis_cap);
    }
    if (config->charge_term_current_a > 0.0f) {
        out->charge_term_current_a = config->charge_term_current_a;
    }
    /*
     * Always, not only when the term current is overridden: a charge current
     * dialled below the default taper threshold would otherwise end every
     * charge the moment it entered CV.
     */
    if (out->charge_term_current_a > out->charge_current_a) {
        out->charge_term_current_a = out->charge_current_a;
    }
    if (config->temp_max_c > 0.0f) {
        out->temp_max_c = clamp_override(config->temp_max_c, 0.0f, t_ceiling);
    }

    /*
     * A cutoff at or above the CV target leaves no window to run in, and the
     * BTS would end a discharge the instant it started. Refuse it rather than
     * hand the unit a profile it cannot honour.
     */
    if (out->discharge_v_min >= out->charge_v_max) {
        return ESP_ERR_INVALID_ARG;
    }
    return ESP_OK;
}

static esp_err_t configure_slot(uint8_t slot, const slot_config_t *config, bool persist);

esp_err_t test_engine_configure(uint8_t slot, const slot_config_t *config)
{
    return configure_slot(slot, config, true);
}

/*
 * Per-slot configuration persistence.
 *
 * A slot's profile used to live in RAM only, so every reboot or OTA update
 * left all eight slots unconfigured - the panel, BLE, HTTP and Home Assistant
 * then had nothing to show or pre-load. One blob per slot in the "slotcfg"
 * namespace; ~120 B each, under 1 KB for the unit.
 *
 * The SERIAL IS NOT KEPT. It identifies the cell in the slot today, and the
 * slot outlives the cell; restoring yesterday's barcode onto a new cell would
 * file its result under the wrong serial.
 *
 * A version word guards against a layout change across firmware builds: a
 * blob of another size or version is ignored, and the slot simply comes up
 * unconfigured, as it always used to.
 */
#define SLOTCFG_NAMESPACE   "slotcfg"
#define SLOTCFG_VERSION     1u

typedef struct {
    uint32_t      version;
    slot_config_t config;
} slotcfg_blob_t;

static void slotcfg_key(uint8_t slot, char *buf, size_t len)
{
    snprintf(buf, len, "slot%u", (unsigned)slot);
}

static void slotcfg_save(uint8_t slot, const slot_config_t *config)
{
    slotcfg_blob_t blob;
    memset(&blob, 0, sizeof(blob));
    blob.version = SLOTCFG_VERSION;
    blob.config  = *config;
    blob.config.serial[0] = '\0';

    nvs_handle_t h;
    esp_err_t err = nvs_open(SLOTCFG_NAMESPACE, NVS_READWRITE, &h);
    if (err == ESP_OK) {
        char key[12];
        slotcfg_key(slot, key, sizeof(key));
        err = nvs_set_blob(h, key, &blob, sizeof(blob));
        if (err == ESP_OK) {
            err = nvs_commit(h);
        }
        nvs_close(h);
    }
    if (err != ESP_OK) {
        ESP_LOGW(TAG, "slot %u: config not persisted (%s)", slot, esp_err_to_name(err));
    }
}

/*
 * Restores each slot's saved configuration at boot. A profile that no longer
 * resolves - a custom model since deleted, say - is dropped and the slot left
 * unconfigured, rather than configured from figures that no longer exist.
 */
static void slotcfg_restore_all(void)
{
    nvs_handle_t h;
    if (nvs_open(SLOTCFG_NAMESPACE, NVS_READONLY, &h) != ESP_OK) {
        return;
    }
    for (uint8_t slot = 0; slot < SLOT_COUNT; slot++) {
        char key[12];
        slotcfg_key(slot, key, sizeof(key));
        slotcfg_blob_t blob;
        size_t len = sizeof(blob);
        if (nvs_get_blob(h, key, &blob, &len) != ESP_OK ||
            len != sizeof(blob) || blob.version != SLOTCFG_VERSION) {
            continue;
        }
        blob.config.model_name[CELL_NAME_MAX - 1] = '\0';
        blob.config.serial[0] = '\0';
        if (configure_slot(slot, &blob.config, false) == ESP_OK) {
            ESP_LOGI(TAG, "slot %u: restored saved profile", slot);
        } else {
            ESP_LOGW(TAG, "slot %u: saved profile no longer resolves, ignored", slot);
        }
    }
    nvs_close(h);
}

static esp_err_t configure_slot(uint8_t slot, const slot_config_t *config, bool persist)
{
    if (!s_ready || slot >= SLOT_COUNT || config == NULL) {
        return ESP_ERR_INVALID_ARG;
    }

    cell_resolved_profile_t profile;
    esp_err_t err = test_engine_resolve(slot, config, &profile);
    if (err != ESP_OK) {
        return err;
    }

    if (xSemaphoreTake(s_lock, portMAX_DELAY) != pdTRUE) {
        return ESP_ERR_TIMEOUT;
    }

    slot_ctx_t *c = &s_slot[slot];
    /*
     * A held pause may be reconfigured: the converter is off, and
     * test_engine_resume() writes the new limits before it lets the slot run
     * again, so the change takes effect on the resume. Nothing about the
     * run's counters or result is touched here.
     */
    if (c->state != SLOT_STATE_IDLE && c->state != SLOT_STATE_COMPLETE &&
        c->state != SLOT_STATE_ABORTED && c->state != SLOT_STATE_FAULT &&
        c->state != SLOT_STATE_BTS_PAUSED) {
        xSemaphoreGive(s_lock);
        ESP_LOGW(TAG, "slot %u busy in %s, refusing reconfigure",
                 slot, slot_state_name(c->state));
        return ESP_ERR_INVALID_STATE;
    }

    /*
     * A voltage or current override was chosen for one cell. If the
     * chemistry or the model has changed - from any interface, HTTP
     * included, which starts from the stored config - it no longer applies,
     * and keeping it would lay a 4.2 V charge target over an LFP cell. Drop
     * them and resolve again from the new cell's own defaults.
     */
    slot_config_t next = *config;
    if (c->configured &&
        (next.chemistry != c->config.chemistry ||
         strcasecmp(next.model_name, c->config.model_name) != 0)) {
        const bool had = next.charge_v_max > 0.0f || next.discharge_v_min > 0.0f ||
                         next.charge_current_a > 0.0f || next.discharge_current_a > 0.0f ||
                         next.charge_term_current_a > 0.0f || next.temp_max_c > 0.0f;
        if (had) {
            next.charge_v_max = next.discharge_v_min = 0.0f;
            next.charge_current_a = next.discharge_current_a = 0.0f;
            next.charge_term_current_a = 0.0f;
            next.temp_max_c = 0.0f;
            ESP_LOGW(TAG, "slot %u: cell changed, overrides dropped", slot);
            if (test_engine_resolve(slot, &next, &profile) != ESP_OK) {
                xSemaphoreGive(s_lock);
                return ESP_ERR_INVALID_ARG;
            }
        }
    }

    c->config     = next;
    c->profile    = profile;
    c->configured = true;
    c->changed    = true;

    xSemaphoreGive(s_lock);

    if (persist) {
        slotcfg_save(slot, &next);
    }

    /*
     * Push the limits now rather than waiting for the start, so the slot is
     * visibly provisioned and a bad profile is rejected before a cell is
     * committed to it.
     */
    bts_channel_limits_t limits;
    cell_profile_to_bts_limits(&profile, &limits);
    /* Voltages and temperature only: the current setpoint belongs to the
     * direction that starts, and is written then. */
    esp_err_t lim_err = bts_link_set_limits(slot, &limits, BTS_LIMITS_NEUTRAL);
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
    {
        /* A follower has no control loop, and the unit ignores a start sent
         * to one; the group runs from its leader. */
        bts_snapshot_t snap;
        bts_link_get_snapshot(&snap);
        if (bts_slot_is_follower(&snap.unit, slot)) {
            return ESP_ERR_NOT_ALLOWED;
        }
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
        c->paused_since_us     = 0;
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
    c->paused_since_us = 0;

    if (c->state == SLOT_STATE_DIRECT) {
        /* Stopping a bare run is the normal way to end it, not an abort. */
        c->test_started_us = 0;
        enter_state(slot, SLOT_STATE_IDLE);
    } else if (c->state != SLOT_STATE_IDLE && c->state != SLOT_STATE_COMPLETE) {
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
    /*
     * The converter stop is what actually makes the slots safe, and it is
     * written again here after the per-slot aborts. Its result is reported:
     * the engine's own bookkeeping cannot fail on a dead I2C link, so an
     * abort_all that said OK while the stop never reached the unit would be an
     * e-stop that lies.
     */
    const esp_err_t stop = bts_link_stop_all();
    return (stop != ESP_OK) ? stop : err;
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
    const bool engine_fault = (c->state == SLOT_STATE_FAULT ||
                               c->state == SLOT_STATE_ABORTED);
    if (engine_fault) {
        c->fault = SLOT_FAULT_NONE;
        enter_state(slot, SLOT_STATE_IDLE);
    }

    /*
     * Clear the unit's indication too. It latches the over-current and
     * group-disconnect bits until told otherwise, and check_safety() refuses
     * to run a slot whose trip bit is still set - so without this, a tripped
     * slot could never be started again.
     *
     * Also sent when the engine itself is idle but the unit shows a latch: a
     * direct run from the panel or a host trips without the engine ever
     * having owned the slot, and the operator still has to be able to clear
     * it. The unit ignores the command on a channel that is driving.
     *
     * Best effort: an unreachable unit leaves the bit set, and the next start
     * then faults again with the same reason, which is the honest outcome.
     */
    /*
     * The unit-only case is limited to an idle engine. A host clear landing
     * mid-test, between a trip and the engine's next tick, would otherwise
     * wipe the trip bits before check_safety() saw them, and the tripped
     * phase would be taken for one that ended normally.
     */
    bts_snapshot_t snap;
    bts_link_get_snapshot(&snap);
    bts_snapshot_group_totals(&snap);
    const bts_channel_state_t *ch = &snap.channel[slot];
    const bool unit_latched = ch->valid &&
        ((ch->status_bits & (BTS_STATUS_OVERCURRENT | BTS_STATUS_GROUP_DISCONNECT)) ||
         ch->cmpss_trip || ch->gpio_trip);
    if (engine_fault || (unit_latched && c->state == SLOT_STATE_IDLE)) {
        /* To the group's leader: the C2000 carries a clear across the group
         * from there, and ignores a command addressed to a follower. */
        const uint8_t leader = bts_group_leader(&snap.unit, slot);
        (void)bts_link_clear_fault_channel(leader);
        ESP_LOGI(TAG, "slot %u: fault clear sent to leader %u (status 0x%08lx)",
                 slot, leader, (unsigned long)ch->status_bits);
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
    const bts_channel_state_t *ch = &snap.channel[slot];
    if (!ch->valid || !ch->paused) {
        return ESP_ERR_INVALID_STATE;
    }

    /*
     * Re-apply the slot's settings for the direction the BTS is holding,
     * BEFORE the resume, so they are in the registers when the unit latches
     * them. The C2000 re-latches its limits on a resume too, from these
     * registers - this write is what puts the CURRENT profile there, including
     * anything an operator changed while the slot was paused.
     *
     * Only the limits are written. Nothing here, on either side, touches the
     * counters: a resume carries the run on from where it stopped.
     */
    if (xSemaphoreTake(s_lock, portMAX_DELAY) != pdTRUE) {
        return ESP_ERR_TIMEOUT;
    }
    const bool configured = s_slot[slot].configured;
    cell_resolved_profile_t profile = s_slot[slot].profile;
    xSemaphoreGive(s_lock);

    if (configured) {
        bts_channel_limits_t limits;
        cell_profile_to_bts_limits(&profile, &limits);
        const bts_limits_dir_t dir = (ch->status_bits & BTS_STATUS_CHARGING)
                                         ? BTS_LIMITS_CHARGE
                                         : BTS_LIMITS_DISCHARGE;
        const esp_err_t err = bts_link_set_limits(slot, &limits, dir);
        if (err != ESP_OK) {
            /* Resuming on limits that may be stale is how a cell overran its
             * floor; refuse instead, and the operator can retry. */
            ESP_LOGE(TAG, "slot %u: resume refused, limits not written (%s)",
                     slot, esp_err_to_name(err));
            return err;
        }
        ESP_LOGI(TAG, "slot %u: limits re-applied for resume: %s %.3f A, "
                      "%.3f-%.3f V", slot,
                 dir == BTS_LIMITS_CHARGE ? "charge" : "discharge",
                 dir == BTS_LIMITS_CHARGE ? limits.charge_current_max
                                          : limits.discharge_current_max,
                 limits.discharge_voltage_min, limits.charge_voltage_max);
    } else {
        ESP_LOGW(TAG, "slot %u: resuming with no profile on this proxy; the "
                      "unit's stored limits apply", slot);
    }

    ESP_LOGW(TAG, "slot %u: operator resume of a %s pause", slot,
             ch->restored     ? "restored"
             : ch->wd_tripped ? "watchdog"
                              : "commanded");
    return bts_link_resume_channel(slot);
}

esp_err_t test_engine_run_direct(uint8_t slot, bool charge)
{
    if (!s_ready || slot >= SLOT_COUNT) {
        return ESP_ERR_INVALID_ARG;
    }

    bts_snapshot_t snap;
    bts_link_get_snapshot(&snap);
    bts_snapshot_group_totals(&snap);
    const bts_channel_state_t *ch = &snap.channel[slot];
    if (!snap.unit.online || !ch->valid) {
        return ESP_ERR_INVALID_STATE;
    }
    /*
     * The unit refuses most of these itself, silently, and leaves the slot
     * stopped. Refusing here instead means the panel can say why.
     */
    if (ch->status_bits & (BTS_STATUS_OVERCURRENT | BTS_STATUS_GROUP_DISCONNECT |
                           BTS_STATUS_SLOT_DISABLED | BTS_STATUS_SLAVE_MODE |
                           BTS_STATUS_CALIBRATING)) {
        return ESP_ERR_NOT_ALLOWED;
    }
    /*
     * RUN on a paused slot is a resume on the BTS, which would sidestep the
     * rule that a restored or watchdog pause is resumed only by an operator,
     * on purpose, with the resume command.
     */
    if (ch->paused) {
        return ESP_ERR_NOT_ALLOWED;
    }
    if (ch->cmpss_trip || ch->gpio_trip) {
        return ESP_ERR_NOT_ALLOWED;
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
        /* A test, a held pause or a fault owns the slot. */
        err = ESP_ERR_INVALID_STATE;
    } else {
        /*
         * The same path the engine uses to start a phase: the slot's limits
         * first, then the mode word. Then SLOT_STATE_DIRECT, so tick_slot()
         * supervises the run - check_safety() is the only temperature limit
         * there is, because the C2000 treats cell temperature as advisory.
         * The time limit runs from here, as it would for a test.
         */
        c->fault           = SLOT_FAULT_NONE;
        c->direct_charge   = charge;
        c->test_started_us = esp_timer_get_time();
        c->paused_since_us = 0;
        err = start_power(slot, charge ? BTS_MODE_RUN_CHARGE : BTS_MODE_RUN_DISCHARGE);
        if (err == ESP_OK) {
            const int64_t issued = c->mode_issued_us;
            enter_state(slot, SLOT_STATE_DIRECT);
            /*
             * enter_state() clears power_started, but the stage is already
             * commanded: restore it so the over-current check and
             * bts_says_done() are armed from the first tick.
             */
            c->power_started  = true;
            c->mode_issued_us = issued;
        } else {
            c->test_started_us = 0;
            bts_link_stop_channel(slot);
        }
    }
    xSemaphoreGive(s_lock);

    if (err == ESP_OK) {
        ESP_LOGI(TAG, "slot %u: direct %s from the panel", slot,
                 charge ? "charge" : "discharge");
    } else {
        ESP_LOGW(TAG, "slot %u: direct %s refused (%s)", slot,
                 charge ? "charge" : "discharge", esp_err_to_name(err));
    }
    return err;
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

    /*
     * After s_ready (configure_slot checks it) and before the engine task
     * runs, so no tick ever sees a slot half-restored. cell_profiles_init()
     * has already loaded the custom models a saved profile may name.
     */
    slotcfg_restore_all();

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
