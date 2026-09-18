/*
 * coulomb_counter.c
 *
 * Trapezoidal charge/energy integration. See coulomb_counter.h for why this
 * runs on the ESP32 rather than reading the BTS accumulators.
 */

#include <string.h>
#include <math.h>
#include "esp_timer.h"
#include "coulomb_counter.h"

void coulomb_reset(coulomb_counter_t *cc)
{
    if (cc == NULL) {
        return;
    }
    memset(cc, 0, sizeof(*cc));
    cc->start_us       = esp_timer_get_time();
    cc->last_sample_us = cc->start_us;
    cc->min_voltage_v  = INFINITY;
    cc->max_voltage_v  = -INFINITY;
    cc->peak_temp_c    = -INFINITY;
    cc->running        = true;
}

void coulomb_update(coulomb_counter_t *cc, float voltage_v, float current_a,
                    float temp_c, int64_t now_us)
{
    if (cc == NULL || !cc->running) {
        return;
    }

    const int64_t dt_us = now_us - cc->last_sample_us;
    if (dt_us <= 0) {
        /* Clock went backwards or a duplicate sample; ignore it. */
        return;
    }

    const double dt_h = (double)dt_us / 3600000000.0;  /* us -> hours */
    const float  i    = fabsf(current_a);
    const float  p    = i * voltage_v;                 /* watts */

    /*
     * Trapezoid against the previous sample. On the first update after a
     * reset last_current_a is 0, which biases the first interval low by
     * half a sample - negligible at a 250 ms poll against a multi-hour
     * discharge, and it errs conservative.
     */
    cc->mah += ((double)cc->last_current_a + (double)i) * 0.5 * dt_h * 1000.0;
    cc->mwh += ((double)cc->last_power_w   + (double)p) * 0.5 * dt_h * 1000.0;

    cc->last_current_a = i;
    cc->last_power_w   = p;
    cc->last_sample_us = now_us;
    cc->sample_count++;

    if (i > cc->peak_current_a)   cc->peak_current_a = i;
    if (temp_c > cc->peak_temp_c) cc->peak_temp_c    = temp_c;
    if (voltage_v < cc->min_voltage_v) cc->min_voltage_v = voltage_v;
    if (voltage_v > cc->max_voltage_v) cc->max_voltage_v = voltage_v;
}

void coulomb_stop(coulomb_counter_t *cc)
{
    if (cc != NULL) {
        cc->running = false;
    }
}

double coulomb_elapsed_s(const coulomb_counter_t *cc)
{
    if (cc == NULL || cc->start_us == 0) {
        return 0.0;
    }
    const int64_t end = cc->running ? esp_timer_get_time() : cc->last_sample_us;
    return (double)(end - cc->start_us) / 1000000.0;
}
