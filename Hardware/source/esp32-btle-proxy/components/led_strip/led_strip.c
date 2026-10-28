/*
 * led_strip.c - WS2812B slot indicators over SPI3.
 *
 * See led_strip.h for the wiring, the bitstream encoding, and why this
 * function moved off the C2000.
 */

#include "led_strip.h"

#include <string.h>

#include "bts_link.h"
#include "bts_regs.h"
#include "driver/gpio.h"
#include "driver/spi_master.h"
#include "esp_check.h"
#include "esp_heap_caps.h"
#include "esp_log.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

static const char *TAG = "led_strip";

/*
 * 3.2 MHz: four SPI bits per WS2812B bit, 312.5 ns each, 1.25 us per bit.
 * APB 80 MHz / 25, so the rate is exact. See the header for why 2.5 MHz was
 * replaced: its 400 ns zero-pulse read as a one on these parts.
 */
#define LED_SPI_HOST        SPI3_HOST
#define LED_SPI_HZ          (3200000)

/* Two WS2812B bits per SPI byte; 24 bits of colour per LED. */
#define LED_BYTES_PER_LED   12
#define LED_FRAME_BYTES     (LED_STRIP_COUNT * LED_BYTES_PER_LED)

#define LED_TASK_STACK      3072
#define LED_TASK_PRIORITY   4

/*
 * Flash patterns, in milliseconds, as period and lit portion. A duty other
 * than half is deliberate in places: the trip pattern is long-on/short-off
 * so it reads differently from the faster faults at a glance.
 */
#define MS_TRIP_PERIOD          2500
#define MS_TRIP_ON              2000
#define MS_REVERSE_PERIOD        250
#define MS_REVERSE_ON            125
#define MS_DISCONNECT_PERIOD     500
#define MS_DISCONNECT_ON         250
#define MS_CAL_PERIOD            300
#define MS_CAL_ON                150
#define MS_PAUSE_PERIOD         1000
#define MS_PAUSE_ON              500
#define MS_BALANCE_PERIOD        300
#define MS_BALANCE_ON            150
#define MS_READY_PERIOD          500
#define MS_READY_ON              250
#define MS_OFFLINE_PERIOD        500
#define MS_OFFLINE_ON            250

typedef struct {
    uint8_t r, g, b;
} rgb_t;

/*
 * Written as RGB and reordered when encoded, unlike the C2000 tables which
 * were stored pre-swapped into GRB and needed a comment on every line
 * explaining that yellow only looked right by coincidence.
 *
 * These are HUES at full scale, not drive levels. Every one of them, and
 * every pixel written for any state, passes through scale() in
 * encode_pixel() - the single point where the brightness limit is applied -
 * so at the 10% cap white drives 26/26/26 and amber 26/10/0. Keeping the
 * table full-scale preserves each colour's channel ratios exactly; scaling
 * the table by hand instead would round amber's green to nothing and make
 * the limit something every new colour had to remember.
 */
static const rgb_t C_OFF    = {   0,   0,   0 };
static const rgb_t C_RED    = { 255,   0,   0 };
static const rgb_t C_GREEN  = {   0, 255,   0 };
static const rgb_t C_BLUE   = {   0,   0, 255 };
static const rgb_t C_WHITE  = { 255, 255, 255 };
static const rgb_t C_YELLOW = { 255, 255,   0 };
static const rgb_t C_AMBER  = { 255,  96,   0 };

static spi_device_handle_t s_spi;
static uint8_t            *s_frame;         /* DMA-capable, LED_FRAME_BYTES */
static led_strip_config_t  s_cfg;
static volatile bool       s_blanked;
static bool                s_ready;

/*
 * One SPI byte carries two WS2812B bits: 0 -> 1000, 1 -> 1110.
 * Indexed by those two bits, high bit first.
 *
 *   0: 312 ns high, 938 ns low
 *   1: 938 ns high, 312 ns low
 */
static const uint8_t k_pair[4] = {
    0x88,   /* 00 -> 1000 1000 */
    0x8E,   /* 01 -> 1000 1110 */
    0xE8,   /* 10 -> 1110 1000 */
    0xEE,   /* 11 -> 1110 1110 */
};

/*
 * Full-scale channel value -> drive level. The ONLY place brightness is
 * applied, and every pixel goes through it.
 *
 * The hard ceiling is enforced here as well as in led_strip_init(): this is
 * the line between a colour and the wire, so nothing that reaches the strip -
 * a new state colour, a test pattern, a config that skipped init's clamp -
 * can drive a channel above LED_STRIP_MAX_BRIGHTNESS.
 *
 * Rounded rather than truncated, so a non-zero component of a mixed colour
 * does not vanish at low brightness and shift the hue.
 */
static inline uint8_t scale(uint8_t value)
{
    uint16_t level = s_cfg.brightness;
    if (level > LED_STRIP_MAX_BRIGHTNESS) {
        level = LED_STRIP_MAX_BRIGHTNESS;
    }
    return (uint8_t)(((uint16_t)value * level + 127u) / 255u);
}

/* Encodes one pixel in WS2812B wire order: green, red, blue. */
static void encode_pixel(uint8_t *dst, rgb_t c)
{
    const uint8_t ordered[3] = { scale(c.g), scale(c.r), scale(c.b) };

    for (int byte = 0; byte < 3; byte++) {
        uint8_t v = ordered[byte];
        for (int pair = 0; pair < 4; pair++) {
            /* Most significant pair first - the WS2812B is MSB-first. */
            *dst++ = k_pair[(v >> (6 - pair * 2)) & 0x03u];
        }
    }
}

/*
 * Position in the chain of the LED that shows `slot` (0-based).
 *
 * The strip runs backwards relative to the slots: LED 1, the first one after
 * DIN, sits at slot 8 and LED 8 at slot 1. Kept in one place so the mapping
 * cannot drift between the per-slot colours and the link-down flash.
 */
static inline int led_for_slot(int slot)
{
    return (LED_STRIP_COUNT - 1) - slot;
}

/*
 * True while a flash pattern is in its lit portion.
 *
 * `tick` counts refreshes, so the periods stay in real time regardless of
 * what refresh_ms is set to - the C2000 version hard-coded its periods in
 * units of an 80 Hz tick and silently changed every flash rate if that timer
 * was ever retuned.
 */
static bool flash(uint32_t tick, uint32_t period_ms, uint32_t on_ms)
{
    uint32_t period = period_ms / s_cfg.refresh_ms;
    uint32_t on     = on_ms / s_cfg.refresh_ms;

    if (period == 0) {
        return true;
    }
    return (tick % period) < on;
}

/*
 * Colour for one slot.
 *
 * The order is the C2000's, and it is safety-first on purpose: a fault is
 * shown even though a faulted slot is also, necessarily, not running. Testing
 * "not running" first - as an earlier version did - made a trip look
 * identical to an idle slot.
 */
static rgb_t colour_for(const bts_channel_state_t *ch, uint32_t tick)
{
    const uint32_t s = ch->status_bits;

    if (s & BTS_STATUS_SLOT_DISABLED) {
        /* Masked off by the ENABLE strap - never going to run. */
        return C_RED;
    }
    if (s & BTS_STATUS_OVERCURRENT) {
        return flash(tick, MS_TRIP_PERIOD, MS_TRIP_ON) ? C_RED : C_OFF;
    }
    if (s & BTS_STATUS_REVERSE_POLARITY) {
        return flash(tick, MS_REVERSE_PERIOD, MS_REVERSE_ON) ? C_RED : C_OFF;
    }
    if (s & BTS_STATUS_GROUP_DISCONNECT) {
        return flash(tick, MS_DISCONNECT_PERIOD, MS_DISCONNECT_ON) ? C_RED : C_OFF;
    }
    if (s & BTS_STATUS_CALIBRATING) {
        /*
         * Below the faults on purpose: a slot that trips during calibration
         * must still read as tripped.
         */
        return flash(tick, MS_CAL_PERIOD, MS_CAL_ON) ? C_WHITE : C_OFF;
    }
    if (ch->paused) {
        /*
         * A watchdog or restore pause flashes red - the link died or the
         * unit reset under a running test - a deliberate one blue.
         */
        rgb_t c = (ch->wd_tripped || ch->restored) ? C_RED : C_BLUE;
        return flash(tick, MS_PAUSE_PERIOD, MS_PAUSE_ON) ? c : C_OFF;
    }
    if (ch->balancing || ch->soft_start) {
        /*
         * Driving the rail to match an unseated cell, or starting into one
         * just seated. Below every fault, above the direction states.
         */
        return flash(tick, MS_BALANCE_PERIOD, MS_BALANCE_ON) ? C_YELLOW : C_OFF;
    }
    if (ch->ready) {
        /*
         * Rails matched: it is safe to seat a cell. Flashing, because solid
         * green already means idle and an operator has to be able to tell a
         * slot that is ready to accept a cell from one doing nothing.
         */
        return flash(tick, MS_READY_PERIOD, MS_READY_ON) ? C_GREEN : C_OFF;
    }
    if (s & (BTS_STATUS_CHARGING | BTS_STATUS_DISCHARGING)) {
        return (s & BTS_STATUS_RUNNING) ? C_BLUE : C_GREEN;
    }
    if (ch->ended) {
        return C_WHITE;
    }
    return C_GREEN;     /* Idle, or simply not under control. */
}

/*
 * Link down: flash all eight amber in unison.
 *
 * Unison is the cue. Per-slot states are never synchronised across the whole
 * strip, so an operator can tell "the proxy cannot see the unit" from any
 * real per-slot condition without reading a colour key. Showing the last
 * known colours instead would assert slot states that may no longer be true,
 * and going dark would be indistinguishable from the box being powered off.
 */
static void render(uint32_t tick)
{
    bts_snapshot_t snap;
    bts_link_get_snapshot(&snap);

    bool offline = !snap.unit.online;
    bool lit = flash(tick, MS_OFFLINE_PERIOD, MS_OFFLINE_ON);

    for (int i = 0; i < LED_STRIP_COUNT; i++) {
        rgb_t c;

#if LED_STRIP_TEST_MODE == 2
        c = (rgb_t){ 255, 255, 255 };
        (void)lit; (void)offline; (void)snap;
        encode_pixel(&s_frame[led_for_slot(i) * LED_BYTES_PER_LED], c);
        continue;
#endif
        if (s_blanked) {
            c = C_OFF;
        } else if (offline || !snap.channel[i].valid) {
            c = lit ? C_AMBER : C_OFF;
        } else {
            c = colour_for(&snap.channel[i], tick);
        }
        /*
         * The strip is wired with its first LED at slot 8, so slot i drives
         * pixel (COUNT - 1 - i): LED 1 shows slot 8 and LED 8 shows slot 1.
         * The first pixel in the frame is the one nearest DIN.
         */
        encode_pixel(&s_frame[led_for_slot(i) * LED_BYTES_PER_LED], c);
    }

    spi_transaction_t tx = {
        .length    = LED_FRAME_BYTES * 8,
        .tx_buffer = s_frame,
    };

    /*
     * Blocking, and deliberately so: at 3.2 MHz the frame takes 240 us and
     * this task has nothing else to do. The reset latch needs MOSI low for
     * >50 us afterwards, which comes free - every symbol ends in a 0 bit, so
     * the line rests low between frames and the next refresh is 25 ms away.
     */
    esp_err_t err = spi_device_transmit(s_spi, &tx);
    if (err != ESP_OK) {
        ESP_LOGW(TAG, "transmit failed: %s", esp_err_to_name(err));
    }
}

static void led_task(void *arg)
{
    (void)arg;
    uint32_t tick = 0;

    for (;;) {
        render(tick++);
        vTaskDelay(pdMS_TO_TICKS(s_cfg.refresh_ms));
    }
}

void led_strip_blank(void)
{
    s_blanked = true;
}

void led_strip_resume(void)
{
    s_blanked = false;
}

/*
 * Logs what the pad is actually doing, read back from the GPIO matrix and
 * IO_MUX rather than from what was asked for. An SPI MOSI that never reaches
 * the pin shows up here as the wrong function or as an input-only pad.
 */
static void report_pad(const char *when)
{
    gpio_io_config_t io = { 0 };
    if (gpio_get_io_config((gpio_num_t)s_cfg.data_gpio, &io) != ESP_OK) {
        ESP_LOGW(TAG, "%s: cannot read GPIO%d configuration", when, s_cfg.data_gpio);
        return;
    }
    ESP_LOGW(TAG, "%s: GPIO%d level=%d  ie=%d oe=%d oe_by_periph=%d od=%d  "
                  "pu=%d pd=%d  drive=%d  fun_sel=%d  sig_out=%d",
             when, s_cfg.data_gpio, gpio_get_level((gpio_num_t)s_cfg.data_gpio),
             (int)io.ie, (int)io.oe, (int)io.oe_ctrl_by_periph, (int)io.od,
             (int)io.pu, (int)io.pd, (int)io.drv, (int)io.fun_sel, (int)io.sig_out);
    /* sig_out 65 is VSPID, the SPI3 MOSI signal; 256 is plain GPIO output. */
}

#if LED_STRIP_TEST_MODE == 1
/*
 * Pin finder. The configured data pin toggles at about 1 Hz, and three other
 * output-capable pins that nothing in the firmware uses toggle faster, so a
 * scope or meter on the header can say which physical pin is which:
 *
 *   the data pin (GPIO25)   ~1 Hz
 *   GPIO14                  ~2 Hz
 *   GPIO26                  ~4 Hz
 *   GPIO13                  ~8 Hz
 *
 * A pin that is silent while the others toggle points at that pin or its
 * wiring, not at the firmware.
 */
static void pin_toggle_task(void *arg)
{
    (void)arg;
    const struct { gpio_num_t pin; int every; } probe[] = {
        { (gpio_num_t)s_cfg.data_gpio, 8 },   /* ~1 Hz  */
        { GPIO_NUM_14,                 4 },   /* ~2 Hz  */
        { GPIO_NUM_26,                 2 },   /* ~4 Hz  */
        { GPIO_NUM_13,                 1 },   /* ~8 Hz  */
    };
    const int n = (int)(sizeof(probe) / sizeof(probe[0]));
    int level[4] = { 0, 0, 0, 0 };

    for (int i = 0; i < n; i++) {
        gpio_reset_pin(probe[i].pin);
        gpio_set_direction(probe[i].pin, GPIO_MODE_OUTPUT);
        gpio_set_drive_capability(probe[i].pin, GPIO_DRIVE_CAP_3);
        gpio_set_level(probe[i].pin, 0);
    }
    report_pad("pin finder, before first edge");
    ESP_LOGW(TAG, "pin finder: GPIO%d ~1Hz, GPIO14 ~2Hz, GPIO26 ~4Hz, GPIO13 ~8Hz",
             s_cfg.data_gpio);

    for (uint32_t t = 1;; t++) {
        for (int i = 0; i < n; i++) {
            if ((t % (uint32_t)probe[i].every) == 0) {
                level[i] ^= 1;
                gpio_set_level(probe[i].pin, level[i]);
            }
        }
        vTaskDelay(pdMS_TO_TICKS(60));
    }
}
#endif

esp_err_t led_strip_init(const led_strip_config_t *config)
{
    ESP_RETURN_ON_FALSE(config != NULL, ESP_ERR_INVALID_ARG, TAG, "null config");
    ESP_RETURN_ON_FALSE(!s_ready, ESP_ERR_INVALID_STATE, TAG, "already started");

    s_cfg = *config;
    if (s_cfg.refresh_ms == 0) {
        s_cfg.refresh_ms = 25;
    }
    if (s_cfg.brightness > LED_STRIP_MAX_BRIGHTNESS) {
        ESP_LOGW(TAG, "brightness %u exceeds the %u/255 current limit; clamped",
                 (unsigned)s_cfg.brightness, (unsigned)LED_STRIP_MAX_BRIGHTNESS);
        s_cfg.brightness = LED_STRIP_MAX_BRIGHTNESS;
    }

#if LED_STRIP_TEST_MODE == 1
    ESP_LOGW(TAG, "LED TEST MODE 1: GPIO%d toggled at 1 Hz, SPI NOT started",
             s_cfg.data_gpio);
    s_ready = true;
    return (xTaskCreate(pin_toggle_task, "led_toggle", 3072, NULL, 4, NULL) == pdPASS)
               ? ESP_OK : ESP_ERR_NO_MEM;
#endif

    /*
     * DMA-capable: spi_device_transmit() on a buffer in regular heap would
     * either fail or silently fall back to a copy.
     */
    s_frame = heap_caps_malloc(LED_FRAME_BYTES, MALLOC_CAP_DMA);
    ESP_RETURN_ON_FALSE(s_frame != NULL, ESP_ERR_NO_MEM, TAG, "frame alloc");
    memset(s_frame, 0, LED_FRAME_BYTES);

    /*
     * MISO and SCLK are left unrouted. Only MOSI reaches a pad - the
     * WS2812B is a one-wire part and the clock is implicit in the bit
     * pattern, so routing SCLK would burn a pin to drive nothing.
     */
    const spi_bus_config_t bus = {
        .mosi_io_num     = s_cfg.data_gpio,
        .miso_io_num     = -1,
        .sclk_io_num     = -1,
        .quadwp_io_num   = -1,
        .quadhd_io_num   = -1,
        .max_transfer_sz = LED_FRAME_BYTES,
    };

    esp_err_t err = spi_bus_initialize(LED_SPI_HOST, &bus, SPI_DMA_CH_AUTO);
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "bus init: %s", esp_err_to_name(err));
        goto fail;
    }

    const spi_device_interface_config_t dev = {
        .clock_speed_hz = LED_SPI_HZ,
        .mode           = 0,
        .spics_io_num   = -1,       /* no chip select; the strip has none */
        .queue_size     = 1,
    };

    err = spi_bus_add_device(LED_SPI_HOST, &dev, &s_spi);
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "add device: %s", esp_err_to_name(err));
        spi_bus_free(LED_SPI_HOST);
        goto fail;
    }
    report_pad("after SPI3 add_device");

    /*
     * One frame of darkness before the task starts. A WS2812B powers up with
     * whatever its shift register happens to hold, which on a cold start is
     * often a few pixels at full white.
     */
    render(0);

    if (xTaskCreate(led_task, "led_strip", LED_TASK_STACK, NULL,
                    LED_TASK_PRIORITY, NULL) != pdPASS) {
        spi_bus_remove_device(s_spi);
        spi_bus_free(LED_SPI_HOST);
        err = ESP_ERR_NO_MEM;
        goto fail;
    }

    s_ready = true;
    ESP_LOGI(TAG, "WS2812B x%d on GPIO%d, SPI3 at %d Hz",
             LED_STRIP_COUNT, s_cfg.data_gpio, LED_SPI_HZ);
    return ESP_OK;

fail:
    heap_caps_free(s_frame);
    s_frame = NULL;
    return err;
}
