/*
 * input.c
 *
 * Rotary encoder via PCNT, plus a debounced push switch. See input.h for
 * the wiring and why PCNT rather than GPIO interrupts.
 */

#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"
#include "esp_log.h"
#include "esp_check.h"
#include "esp_timer.h"
#include "driver/pulse_cnt.h"
#include "driver/gpio.h"

#include "input.h"

static const char *TAG = "input";

#define PCNT_HIGH_LIMIT     1000
#define PCNT_LOW_LIMIT      (-1000)
/*
 * 1 us. Mechanical encoder contacts ring for tens of microseconds, but the
 * filter runs off APB (80 MHz) and its field is 10 bits, so 1023 cycles -
 * about 12.8 us - is the ceiling. Combined with the quadrature decode's own
 * immunity this is enough in practice; the divide-by-detent below absorbs
 * whatever gets through.
 */
#define GLITCH_FILTER_NS    1000

/*
 * Poll cadence.
 *
 * 5 ms was too aggressive: pcnt_unit_get_count() takes the driver's
 * spinlock, and at 200 Hz on a core also running the WiFi and BLE stacks
 * that starved IDLE0 badly enough to trip the task watchdog. 20 ms is still
 * far faster than a human can turn a detent - the PCNT hardware counts the
 * edges regardless of when we read them, so polling rate affects latency,
 * never accuracy.
 */
#define POLL_MS             20
#define DEBOUNCE_MS         25
#define DEFAULT_LONG_MS     800

#define QUEUE_DEPTH         16
#define TASK_STACK          3072
#define TASK_PRIO           4

static pcnt_unit_handle_t s_pcnt;
static QueueHandle_t      s_queue;
static input_config_t     s_cfg;
static volatile bool      s_switch_down;
static bool               s_trace;

bool input_switch_is_down(void)
{
    return s_switch_down;
}

bool input_wait_event(input_event_t *out, uint32_t timeout_ms)
{
    if (out == NULL || s_queue == NULL) {
        return false;
    }
    return xQueueReceive(s_queue, out, pdMS_TO_TICKS(timeout_ms)) == pdTRUE;
}

static void post(input_event_type_t type, int32_t steps)
{
    const input_event_t ev = { .type = type, .steps = steps };
    /*
     * Drop rather than block: the UI is the only consumer and a full queue
     * means it is busy redrawing. Losing a detent is better than stalling
     * the input task, which would make the encoder feel dead.
     */
    (void)xQueueSend(s_queue, &ev, 0);
}

/*
 * Polls the PCNT accumulator and the switch.
 *
 * Rotation is read as a delta and converted to detents; the remainder is
 * carried so a partial detent is not lost across polls. The switch is
 * debounced by requiring a level to persist for DEBOUNCE_MS.
 */
static void input_task(void *arg)
{
    (void)arg;

    int     last_count   = 0;
    int32_t carry        = 0;

    bool    stable_down  = false;    /* debounced switch state        */
    bool    raw_last     = false;
    int64_t raw_since_us = 0;
    int64_t press_start  = 0;
    bool    long_fired   = false;

    for (;;) {
        /* ---- rotation ---- */
        int count = 0;
        if (pcnt_unit_get_count(s_pcnt, &count) == ESP_OK) {
            int32_t delta = count - last_count;
            last_count = count;

            if (delta != 0) {
                if (s_cfg.invert_direction) {
                    delta = -delta;
                }
                carry += delta;

                const int32_t detents = carry / INPUT_COUNTS_PER_DETENT;
                if (detents != 0) {
                    carry -= detents * INPUT_COUNTS_PER_DETENT;
                    post(detents > 0 ? INPUT_EVENT_ROTATE_CW
                                     : INPUT_EVENT_ROTATE_CCW,
                         detents > 0 ? detents : -detents);
                }
            }
        }

        /* ---- switch ---- */
        if (s_cfg.switch_gpio >= 0) {
            const int level = gpio_get_level(s_cfg.switch_gpio);
            const bool raw_down = s_cfg.switch_active_low ? (level == 0)
                                                          : (level != 0);
            const int64_t now = esp_timer_get_time();

            if (raw_down != raw_last) {
                raw_last = raw_down;
                raw_since_us = now;
            } else if (raw_down != stable_down &&
                       (now - raw_since_us) >= (DEBOUNCE_MS * 1000LL)) {
                stable_down = raw_down;
                s_switch_down = raw_down;

                if (raw_down) {
                    press_start = now;
                    long_fired = false;
                } else if (!long_fired) {
                    /* Released before the threshold: a short press. The
                     * long-press already fired for a held button, so it does
                     * not also produce a press on release. */
                    post(INPUT_EVENT_PRESS, 1);
                }
            }

            if (stable_down && !long_fired) {
                const uint32_t threshold = s_cfg.long_press_ms
                                               ? s_cfg.long_press_ms
                                               : DEFAULT_LONG_MS;
                if ((now - press_start) >= (int64_t)threshold * 1000LL) {
                    long_fired = true;
                    post(INPUT_EVENT_LONG_PRESS, 1);
                }
            }
        }

        /*
         * Diagnostic heartbeat while the encoder is being brought up. Cheap
         * enough at 0.5 Hz, and it makes a dead pad obvious from the log
         * without needing a scope.
         */
        if (s_trace) {
            static int64_t last_trace_us;
            const int64_t now_us = esp_timer_get_time();
            if (now_us - last_trace_us > 2000000) {
                last_trace_us = now_us;
                input_log_pin_state("live");
            }
        }

        vTaskDelay(pdMS_TO_TICKS(POLL_MS));
    }
}

/*
 * Logs the encoder pin levels and the raw PCNT count.
 *
 * Both A and B should idle HIGH with the internal pull-ups on, and turning
 * the shaft should move the raw count. This separates the three ways the
 * encoder can appear dead:
 *
 *   levels stuck at 0     the pads are being held low - either the encoder
 *                         common is on 3V3 rather than GND (so the pull-ups
 *                         cannot win), the pull-ups are not applied, or the
 *                         pins are shorted.
 *   levels move, count 0  the pads work but PCNT is not decoding them.
 *   count moves, no event the decode works and the fault is above, in the
 *                         detent division or the queue.
 */
void input_log_pin_state(const char *when)
{
    int count = 0;
    if (s_pcnt != NULL) {
        (void)pcnt_unit_get_count(s_pcnt, &count);
    }
    ESP_LOGI(TAG, "encoder %s: A=%d B=%d SW=%d raw_count=%d",
             when ? when : "",
             gpio_get_level(s_cfg.encoder_a_gpio),
             gpio_get_level(s_cfg.encoder_b_gpio),
             s_cfg.switch_gpio >= 0 ? gpio_get_level(s_cfg.switch_gpio) : -1,
             count);
}

esp_err_t input_init(const input_config_t *config)
{
    if (config == NULL) {
        return ESP_ERR_INVALID_ARG;
    }
    s_cfg = *config;
    s_trace = config->trace;

    s_queue = xQueueCreate(QUEUE_DEPTH, sizeof(input_event_t));
    if (s_queue == NULL) {
        return ESP_ERR_NO_MEM;
    }

    /* ---- switch ---- */
    if (s_cfg.switch_gpio >= 0) {
        const gpio_config_t sw = {
            .pin_bit_mask = BIT64(s_cfg.switch_gpio),
            .mode = GPIO_MODE_INPUT,
            /* The board has no external pull on this line. */
            .pull_up_en = s_cfg.switch_active_low ? GPIO_PULLUP_ENABLE
                                                  : GPIO_PULLUP_DISABLE,
            .pull_down_en = s_cfg.switch_active_low ? GPIO_PULLDOWN_DISABLE
                                                    : GPIO_PULLDOWN_ENABLE,
            .intr_type = GPIO_INTR_DISABLE,
        };
        ESP_RETURN_ON_ERROR(gpio_config(&sw), TAG, "switch gpio");
    }

    /*
     * ---- encoder pull-ups ----
     *
     * PCNT calls gpio_input_enable() on its channel pins but never touches
     * the pull resistors, so an encoder whose common pin goes to ground
     * leaves A and B floating between detents. A floating input does not
     * produce clean edges - it picks up noise and counts erratically, or
     * (as here) does not count at all.
     *
     * This must run BEFORE pcnt_new_channel(): that call routes the pad
     * through the GPIO matrix, and configuring the pad afterwards would
     * undo the routing.
     */
    const gpio_config_t enc_pins = {
        .pin_bit_mask = BIT64(s_cfg.encoder_a_gpio) | BIT64(s_cfg.encoder_b_gpio),
        .mode = GPIO_MODE_INPUT,
        .pull_up_en = GPIO_PULLUP_ENABLE,
        .pull_down_en = GPIO_PULLDOWN_DISABLE,
        .intr_type = GPIO_INTR_DISABLE,
    };
    ESP_RETURN_ON_ERROR(gpio_config(&enc_pins), TAG, "encoder gpio");

    /* ---- quadrature decode ---- */
    const pcnt_unit_config_t unit_cfg = {
        .high_limit = PCNT_HIGH_LIMIT,
        .low_limit  = PCNT_LOW_LIMIT,
        /* Wrap rather than saturate, so continuous spinning keeps counting;
         * the task reads deltas and does not care about the absolute value. */
        .flags.accum_count = true,
    };
    ESP_RETURN_ON_ERROR(pcnt_new_unit(&unit_cfg, &s_pcnt), TAG, "pcnt unit");

    const pcnt_glitch_filter_config_t filter = {
        .max_glitch_ns = GLITCH_FILTER_NS,
    };
    ESP_RETURN_ON_ERROR(pcnt_unit_set_glitch_filter(s_pcnt, &filter),
                        TAG, "glitch filter");

    /*
     * Full quadrature: both channels are counted, each using the other as
     * its direction input. That yields four counts per detent and, more
     * importantly, rejects the single-channel bounce that makes a cheap
     * encoder jump backwards.
     */
    pcnt_chan_config_t chan_a_cfg = {
        .edge_gpio_num  = s_cfg.encoder_a_gpio,
        .level_gpio_num = s_cfg.encoder_b_gpio,
    };
    pcnt_channel_handle_t chan_a = NULL;
    ESP_RETURN_ON_ERROR(pcnt_new_channel(s_pcnt, &chan_a_cfg, &chan_a),
                        TAG, "pcnt chan A");

    pcnt_chan_config_t chan_b_cfg = {
        .edge_gpio_num  = s_cfg.encoder_b_gpio,
        .level_gpio_num = s_cfg.encoder_a_gpio,
    };
    pcnt_channel_handle_t chan_b = NULL;
    ESP_RETURN_ON_ERROR(pcnt_new_channel(s_pcnt, &chan_b_cfg, &chan_b),
                        TAG, "pcnt chan B");

    ESP_RETURN_ON_ERROR(
        pcnt_channel_set_edge_action(chan_a,
                                     PCNT_CHANNEL_EDGE_ACTION_DECREASE,
                                     PCNT_CHANNEL_EDGE_ACTION_INCREASE),
        TAG, "chan A edge");
    ESP_RETURN_ON_ERROR(
        pcnt_channel_set_level_action(chan_a,
                                      PCNT_CHANNEL_LEVEL_ACTION_KEEP,
                                      PCNT_CHANNEL_LEVEL_ACTION_INVERSE),
        TAG, "chan A level");
    ESP_RETURN_ON_ERROR(
        pcnt_channel_set_edge_action(chan_b,
                                     PCNT_CHANNEL_EDGE_ACTION_INCREASE,
                                     PCNT_CHANNEL_EDGE_ACTION_DECREASE),
        TAG, "chan B edge");
    ESP_RETURN_ON_ERROR(
        pcnt_channel_set_level_action(chan_b,
                                      PCNT_CHANNEL_LEVEL_ACTION_KEEP,
                                      PCNT_CHANNEL_LEVEL_ACTION_INVERSE),
        TAG, "chan B level");

    /* Watch points at the limits are what make accum_count work. */
    ESP_RETURN_ON_ERROR(pcnt_unit_add_watch_point(s_pcnt, PCNT_HIGH_LIMIT),
                        TAG, "watch high");
    ESP_RETURN_ON_ERROR(pcnt_unit_add_watch_point(s_pcnt, PCNT_LOW_LIMIT),
                        TAG, "watch low");

    ESP_RETURN_ON_ERROR(pcnt_unit_enable(s_pcnt), TAG, "pcnt enable");
    ESP_RETURN_ON_ERROR(pcnt_unit_clear_count(s_pcnt), TAG, "pcnt clear");
    ESP_RETURN_ON_ERROR(pcnt_unit_start(s_pcnt), TAG, "pcnt start");

    /*
     * Pinned to core 1: core 0 carries the WiFi and BLE stacks, and this
     * task's periodic spinlock acquisition is exactly the kind of load that
     * interferes with them.
     */
    if (xTaskCreatePinnedToCore(input_task, "input", TASK_STACK, NULL,
                                TASK_PRIO, NULL, 1) != pdPASS) {
        return ESP_ERR_NO_MEM;
    }

    ESP_LOGI(TAG, "encoder A=%d B=%d SW=%d (%s), %d counts/detent, pull-ups on",
             s_cfg.encoder_a_gpio, s_cfg.encoder_b_gpio, s_cfg.switch_gpio,
             s_cfg.switch_active_low ? "pull-up, active low" : "active high",
             INPUT_COUNTS_PER_DETENT);
    input_log_pin_state("at init");
    return ESP_OK;
}
