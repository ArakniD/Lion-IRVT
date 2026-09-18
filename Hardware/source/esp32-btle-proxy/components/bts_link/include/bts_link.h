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
    float    cell_temp_c;
    float    current_acc;      /* see bts_link_stats_are_live() */
    float    power_acc;        /* see bts_link_stats_are_live() */
    float    min_voltage_v;
    float    max_voltage_v;
    uint32_t status_bits;      /* BTS_STATUS_* */
    bool     cmpss_trip;
    bool     gpio_trip;
    bool     valid;            /* false until the first good read */
} bts_channel_state_t;

/* Unit-wide state, refreshed by the poll task. */
typedef struct {
    float            input_voltage_v;
    bts_unit_state_t unit_state;
    uint32_t         trip_status;
    bool             online;           /* last poll cycle completed */
    uint32_t         consecutive_errors;
    int64_t          last_poll_us;
} bts_unit_status_t;

/* Full snapshot handed out by bts_link_get_snapshot(). */
typedef struct {
    bts_channel_state_t channel[BTS_NUM_CHANNELS];
    bts_unit_status_t   unit;
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

/* Convenience wrappers over the control block. */
esp_err_t bts_link_set_mode(uint8_t channel, uint32_t mode);
esp_err_t bts_link_stop_channel(uint8_t channel);
esp_err_t bts_link_stop_all(void);

/*
 * Writes the eight control-block limit registers for a channel.
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
 * Whether the BTS is populating its own mAh/mWh accumulators.
 *
 * As of the current F2837xD firmware it is NOT: eChX_CurrentAcc,
 * eChX_PowerAcc, eChX_MinVoltage and eChX_MaxVoltage are declared
 * REG_ACCESS_RO in registers.c and no code path on either core ever assigns
 * them, so they read back as a constant 0. They are also RO, which means the
 * host cannot zero them either - the "reset the watt and current counters in
 * the BTS via registers" step is not possible against this firmware build.
 *
 * The test engine therefore integrates charge and energy on the ESP32 from
 * the polled voltage/current pair (see coulomb_counter.c) and treats the BTS
 * accumulators as advisory. This function probes them at startup: if a
 * future BTS build starts populating them, it returns true and the raw
 * values are surfaced alongside the locally integrated ones for comparison.
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
