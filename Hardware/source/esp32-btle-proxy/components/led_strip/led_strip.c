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
#include "driver/spi_master.h"
#include "esp_check.h"
#include "esp_heap_caps.h"
#include "esp_log.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

static const char *TAG = "led_strip";

/*
 * 2.5 MHz: four SPI bits per WS2812B bit gives T0H = 400 ns and T1H = 800 ns,
 * both exactly nominal. See the header for why 3.333 MHz is not used.
 */
#define LED_SPI_HOST        SPI3_HOST
#define LED_SPI_HZ          (2500000)

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
 * One SPI byte carries two WS2812B bits: 0 -> 1000, 1 -> 1100.
 * Indexed by those two bits, high bit first.
 */
static const uint8_t k_pair[4] = {
    0x88,   /* 00 -> 1000 1000 */
    0x8C,   /* 01 -> 1000 1100 */
    0xC8,   /* 10 -> 1100 1000 */
    0xCC,   /* 11 -> 1100 1100 */
};

static inline uint8_t scale(uint8_t value)
{
    return (uint8_t)(((uint16_t)value * (uint16_t)s_cfg.brightness) / 255u);
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

        if (s_blanked) {
            c = C_OFF;
        } else if (offline || !snap.channel[i].valid) {
            c = lit ? C_AMBER : C_OFF;
        } else {
            c = colour_for(&snap.channel[i], tick);
        }
        encode_pixel(&s_frame[i * LED_BYTES_PER_LED], c);
    }

    spi_transaction_t tx = {
        .length    = LED_FRAME_BYTES * 8,
        .tx_buffer = s_frame,
    };

    /*
     * Blocking, and deliberately so: at 2.5 MHz the frame takes 307 us and
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

esp_err_t led_strip_init(const led_strip_config_t *config)
{
    ESP_RETURN_ON_FALSE(config != NULL, ESP_ERR_INVALID_ARG, TAG, "null config");
    ESP_RETURN_ON_FALSE(!s_ready, ESP_ERR_INVALID_STATE, TAG, "already started");

    s_cfg = *config;
    if (s_cfg.refresh_ms == 0) {
        s_cfg.refresh_ms = 25;
    }

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
