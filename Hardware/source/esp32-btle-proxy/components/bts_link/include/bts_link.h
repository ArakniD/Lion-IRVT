/*
 * bts_link.h
 *
 * Thread-safe I2C transport to the TIDA-010086 BTS unit, plus a cached
 * snapshot of every channel's live state.
 *
 * A single poll task owns the I2C bus and refreshes the snapshot at a fixed
 * cadence. Everything else in the firmware (the test engine, the BLE GATT
 * server, the web API) reads the snapshot under a mutex rather than touching
 * the bus, so a slow BLE client cannot stall the control loop.
 *
 * Writes go straight to the bus and are serialised against the poll task by
 * the same bus mutex.
 */

#ifndef BTS_LINK_H
#define BTS_LINK_H

#include <stdint.h>
#include <stdbool.h>
#include "esp_err.h"
#include "bts_regs.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Live state of one channel, refreshed by the poll task. */
typedef struct {
    float    cell_voltage_v;
    float    cell_current_a;
    /* The ADS131M08 pair, which is what the BTS's CC loop regulates against
     * and what its own counters integrate. */
    float    sense_voltage_v;
    float    sense_current_a;
    float    cell_temp_c;
    /*
     * Per-direction totals from the BTS itself. Each accumulates positive
     * magnitude and is zeroed only when its own direction starts, so a
     * charge and a discharge on one slot leave two independent figures.
     * The seconds counters advance on the same timestep as the mAh/mWh, so
     * all three of a direction stay consistent across a pause.
     */
    float    charge_mah;
    float    charge_mwh;
    float    charge_seconds;
    float    discharge_mah;
    float    discharge_mwh;
    float    discharge_seconds;
    uint32_t status_bits;      /* BTS_STATUS_* */
    bool     cmpss_trip;
    bool     gpio_trip;
    /*
     * Decoded from status_bits. `paused` keeps its direction bit set, so
     * `charging`/`discharging` still say what a resume would do. The two
     * reasons are mutually informative rather than exclusive: wd_tripped
     * means the host link died mid-run, restored means the unit reset and
     * came back holding the counters.
     */
    bool     paused;
    bool     wd_tripped;
    bool     restored;
    bool     ended;
    /*
     * Which half of the CCCV law is regulating right now. In a charge the
     * slot starts in CC and crosses to CV once the cell reaches its voltage
     * limit; the charge then terminates when the current has fallen to
     * I_MIN, so seeing CV is what says the taper has begun. A discharge runs
     * in CC throughout.
     *
     * Exactly one of the two is set while a slot runs. Both read false for a
     * stopped slot, because the BTS publishes the loop's state rather than
     * the slot's intent.
     */
    bool     const_voltage;
    bool     const_current;
    /*
     * Pre-charge balance. `waiting` stays true through the whole sequence,
     * so it answers "is this slot armed"; the other three say where in it.
     */
    bool     waiting;
    bool     balancing;
    bool     ready;
    bool     soft_start;
    bool     valid;            /* false until the first good read */
} bts_channel_state_t;

/* Unit-wide state, refreshed by the poll task. */
typedef struct {
    float            input_voltage_v;
    bts_unit_state_t unit_state;
    uint32_t         trip_status;
    /*
     * The unit's configured host-watchdog timeout in seconds, 0 when it is
     * disabled. The unit publishes only the timeout, not the remaining
     * count, so a host cannot show a countdown - see bts_link.h notes and
     * the README.
     */
    float            watchdog_timeout_s;

    /*
     * Strap configuration, latched by the C2000 at power-on and fixed for
     * the life of the boot - the MODE and ENABLE straps are read once and
     * never re-sampled, so these do not change while the unit is up.
     *
     * slot_mode    bts_slot_mode_t: grouping plus the internal-ADC variants
     * slot_enable  index of the HIGHEST enabled slot, so 7 means all eight
     *              and 0 means slot 1 only. Not a bitmask.
     * group_size   slots per group: 1, 2, 4 or 8
     *
     * These matter to a host beyond display. In a grouped mode only the
     * group leader accepts commands, and a host that issues a start to a
     * follower will have it silently rejected; and accumulated charge for a
     * group is the SUM of its members' individual accumulators, because each
     * slot still measures its own current.
     */
    uint8_t          slot_mode;
    uint8_t          slot_enable;
    uint8_t          group_size;

    bool             online;           /* last poll cycle completed */
    uint32_t         consecutive_errors;
    int64_t          last_poll_us;
} bts_unit_status_t;

/*
 * Calibration window, registers 1008-1064 - 15 registers.
 *
 * Only refreshed while the unit reports calibration active; the fields hold
 * their last values otherwise, and `active` is what tells them apart. The
 * poll task skips the burst when idle so the normal 9-transaction cycle
 * does not get longer for a feature that is almost never in use.
 */
typedef struct {
    bool     active;           /* BTS_CAL_ST_ACTIVE in status_bits       */
    uint8_t  slot;             /* BTS_CAL_SLOT_NONE when none selected   */
    uint32_t status_bits;      /* BTS_CAL_ST_*                           */
    uint32_t result;           /* bts_cal_result_t of the last command   */

    float    ads_v_pu;         /* raw, pre-gain                          */
    float    ads_i_pu;
    float    ads_v_v;
    float    ads_i_a;
    float    f28_v_pu;
    float    f28_i_pu;
    float    f28_v_v;
    float    f28_i_a;
    float    temp_c;

    /* Persisted validity of the selected slot, from its status word. */
    bool     v_tick;
    bool     i_tick;
} bts_cal_state_t;

/* Full snapshot handed out by bts_link_get_snapshot(). */
typedef struct {
    bts_channel_state_t channel[BTS_NUM_CHANNELS];
    bts_unit_status_t   unit;
    bts_cal_state_t     cal;
} bts_snapshot_t;

typedef struct {
    int      sda_gpio;
    int      scl_gpio;
    uint32_t scl_speed_hz;
    uint32_t poll_interval_ms;
} bts_link_config_t;

/*
 * Brings up the I2C master and starts the poll task.
 *
 * Returns ESP_OK even if the BTS does not answer: the unit may be powered
 * down while the proxy is on its backup battery. Check
 * bts_link_get_snapshot()->unit.online to see whether the link is up.
 */
esp_err_t bts_link_init(const bts_link_config_t *config);

/* Copies the current snapshot. Safe from any task. */
void bts_link_get_snapshot(bts_snapshot_t *out);

/* Single-register access. Both serialise on the bus mutex. */
esp_err_t bts_link_read_reg(uint16_t reg_addr, float *out_value);
esp_err_t bts_link_write_reg(uint16_t reg_addr, float value);

/*
 * Burst read of `count` consecutive registers starting at reg_addr.
 *
 * Relies on the target's read auto-increment, so this is one transaction
 * rather than `count` of them.
 */
esp_err_t bts_link_read_block(uint16_t reg_addr, float *out_values, size_t count);

/* Convenience wrappers over the settings block's mode register. */
esp_err_t bts_link_set_mode(uint8_t channel, uint32_t mode);
esp_err_t bts_link_stop_channel(uint8_t channel);
esp_err_t bts_link_stop_all(void);

/*
 * Pause and resume, as the mode register's edge command bits.
 *
 * A pause zeroes the converter reference and freezes the direction's
 * counters without losing them; the resume picks up where it left off and
 * clears WD_TRIPPED/RESTORED. Both are no-ops on a slot in the wrong state,
 * so the caller checks the status bits afterwards rather than the return.
 */
esp_err_t bts_link_pause_channel(uint8_t channel);
esp_err_t bts_link_resume_channel(uint8_t channel);

/*
 * Writes the ten settings-block limit registers for a channel.
 *
 * The caller is expected to have clamped these to the unit envelope already
 * (cell_profile_to_bts_limits() does that); this function clamps again as a
 * backstop because it is the last code that runs before the values reach the
 * power stage.
 */
typedef struct {
    float charge_voltage_min;
    float charge_voltage_max;
    float discharge_voltage_min;
    float discharge_voltage_max;
    float charge_current_min;
    float charge_current_max;
    float discharge_current_min;
    float discharge_current_max;
    float min_cell_temp;
    float max_cell_temp;
} bts_channel_limits_t;

esp_err_t bts_link_set_limits(uint8_t channel, const bts_channel_limits_t *limits);

/*
 * Calibration commands.
 *
 * Each writes eCalArgument, then eCalCommand, then reads eCalResult back,
 * all under the bus mutex so the three-step sequence cannot interleave with
 * the poll task or another caller. `out_result` receives the BTS_CAL_ERR_*
 * code; the esp_err_t return covers only the transport.
 *
 * A non-zero result is a refusal by the unit, not a bus failure - report it
 * rather than retrying.
 */
esp_err_t bts_link_cal_enter(uint8_t slot, uint32_t *out_result);
esp_err_t bts_link_cal_exit(uint32_t *out_result);
esp_err_t bts_link_cal_clear(uint32_t *out_result);
esp_err_t bts_link_cal_capture_voltage(float measured_v, uint32_t *out_result);
esp_err_t bts_link_cal_zero_current(uint32_t *out_result);
esp_err_t bts_link_cal_set_fixed_current(float pu, uint32_t *out_result);
esp_err_t bts_link_cal_capture_current(float measured_a, uint32_t *out_result);
esp_err_t bts_link_cal_compute_save(uint32_t *out_result);

/* Human-readable form of a BTS_CAL_ERR_* code, for API and log messages. */
const char *bts_link_cal_result_name(uint32_t result);

/*
 * Whether the BTS is populating its own mAh/mWh accumulators.
 *
 * The current F2837xD firmware does: CPU1 integrates the ADS131M08 pair in
 * its 6.67 Hz C1 task and publishes both directions' totals in the runtime
 * block at BTS_RT_CHARGE_MAH.. . They remain REG_ACCESS_RO, so a host still
 * cannot zero them on demand - the BTS resets a direction's set itself when
 * that direction starts, which is what the "reset then discharge" sequence
 * actually needed.
 *
 * They are still advisory here. The test engine keeps its own trapezoidal
 * integration (coulomb_counter.c), which samples on real elapsed time at the
 * 250 ms poll rather than a fixed 150 ms step, and reports the BTS figures
 * beside it for comparison. This probe is what gates that reporting: it can
 * legitimately read false on a unit that has been idle since power-up and
 * has never run a slot.
 */
bool bts_link_stats_are_live(void);

/*
 * Bus-level diagnostic, for bring-up.
 *
 * Reads SDA and SCL as plain inputs (temporarily detaching the I2C
 * peripheral) and scans the 7-bit address space. This separates the two
 * failure modes that both surface as ESP_ERR_TIMEOUT:
 *
 *   sda_high/scl_high false  -> a line is stuck low: no pull-ups, a shorted
 *                               or miswired cable, or a target mid-transfer
 *                               holding SDA down. Nothing on the bus can
 *                               work until this is fixed.
 *   lines high, no targets   -> wiring is sane but nothing is answering:
 *                               wrong address, target not powered, or SDA
 *                               and SCL swapped.
 *
 * `found` receives up to `max_found` responding addresses. Returns the
 * number found.
 */
typedef struct {
    bool sda_high;
    bool scl_high;
    int  target_count;
} bts_bus_diag_t;

int bts_link_bus_diagnose(bts_bus_diag_t *diag, uint8_t *found, int max_found);

#ifdef __cplusplus
}
#endif

#endif /* BTS_LINK_H */
