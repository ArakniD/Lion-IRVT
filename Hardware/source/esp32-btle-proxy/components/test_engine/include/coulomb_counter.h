/*
 * coulomb_counter.h
 *
 * Charge and energy integration on the ESP32.
 *
 * WHY THIS EXISTS
 * ---------------
 * The requirement was to reset the BTS mAh/mWh counters over I2C and then
 * read them back at the end of a discharge. Only half of that is possible
 * against the current F2837xD firmware:
 *
 *   1. The BTS does now integrate. CPU1 accumulates the ADS131M08 pair in
 *      its C1 task and publishes per-direction totals - charge at
 *      eChX_ChargeAcc_mAh/_mWh (320/332), discharge at
 *      eChX_DischargeAcc_mAh/_mWh (1156+).
 *   2. But they are still REG_ACCESS_RO and i2cSlaveISR() drops any host
 *      write to a RO register, so the host cannot zero them on demand. The
 *      BTS zeroes a direction's pair itself when that direction starts,
 *      which covers the reset-then-discharge sequence but nothing else.
 *
 * This integrator stays the reported figure: it samples on real elapsed time
 * at the 250 ms poll rather than the BTS's fixed 150 ms step, and it does
 * not lose a partial interval at either end of a run. The BTS totals are
 * read each poll and reported beside these for comparison.
 *
 * METHOD
 * ------
 * Trapezoidal integration against the actual elapsed time between samples
 * (esp_timer_get_time()), not against the nominal poll interval - a poll
 * cycle that runs long because the bus retried must not under-count.
 *
 * Sign convention follows the BTS: discharge current is reported positive in
 * discharge mode. The counter accumulates magnitude into the direction it
 * was told to count, so a charge and a discharge on the same slot produce
 * two separate positive totals rather than cancelling.
 */

#ifndef COULOMB_COUNTER_H
#define COULOMB_COUNTER_H

#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    double   mah;              /* integrated charge                  */
    double   mwh;              /* integrated energy                  */
    float    peak_current_a;
    float    peak_temp_c;
    float    min_voltage_v;
    float    max_voltage_v;
    int64_t  start_us;
    int64_t  last_sample_us;
    float    last_current_a;   /* for the trapezoid                  */
    float    last_power_w;
    uint32_t sample_count;
    bool     running;
} coulomb_counter_t;

/* Zeroes the accumulator and marks it running from now. */
void coulomb_reset(coulomb_counter_t *cc);

/*
 * Folds one sample in.
 *
 * `current_a` is taken as a magnitude: pass the absolute value. Samples with
 * a non-positive dt, or arriving while the counter is stopped, are ignored.
 */
void coulomb_update(coulomb_counter_t *cc, float voltage_v, float current_a,
                    float temp_c, int64_t now_us);

void coulomb_stop(coulomb_counter_t *cc);

/* Elapsed run time in seconds. */
double coulomb_elapsed_s(const coulomb_counter_t *cc);

#ifdef __cplusplus
}
#endif

#endif /* COULOMB_COUNTER_H */
