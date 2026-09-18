/*
 * display.c
 *
 * ST7789 status UI. See display.h for the wiring and the memory strategy.
 *
 * LAYOUT (240x240)
 * ----------------
 *   y   0..19    header: BTS link state, WiFi and BLE indicators
 *   y  20..39    column titles
 *   y  40..231   eight slot rows, 24 px each
 *   y 232..239   footer rule
 *
 * A slot row is
 *
 *   <state>  <volts>  <amps>  <mAh>  <mWh>
 *
 * with the state letter colour-coded: D discharge, C charge, R rest,
 * G good/complete, F fault, and a dim dash when the slot is idle.
 */

#include <string.h>
#include <stdio.h>
#include <math.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_log.h"
#include "esp_check.h"
#include "esp_heap_caps.h"
#include "driver/spi_master.h"
#include "driver/gpio.h"
#include "esp_lcd_panel_io.h"
#include "esp_lcd_panel_vendor.h"
#include "esp_lcd_panel_ops.h"

#include "display.h"
#include "ui_font.h"
#include "test_engine.h"
#include "bts_link.h"
#include "web_api.h"

static const char *TAG = "display";

#define LCD_HOST            SPI2_HOST
/*
 * Conservative default. 40 MHz works on a short, well-grounded ribbon but
 * is marginal on breadboard jumpers - the symptom is a blank or noise-
 * speckled panel rather than an error, because the bus has no read-back.
 * Raise it once the panel is known good.
 */
#define LCD_DEFAULT_CLOCK_HZ (10 * 1000 * 1000)
#define LCD_CMD_BITS        8
#define LCD_PARAM_BITS      8

/*
 * Band height. 240 * 24 * 2 = 11.5 kB, which covers exactly one slot row and
 * keeps the scratch buffer comfortably inside DRAM alongside the BLE and
 * WiFi stacks.
 */
#define UI_BAND_H           24

#define TASK_STACK          4096
#define TASK_PRIO           3

/* RGB565. */
#define C_BLACK     0x0000
#define C_WHITE     0xFFFF
#define C_GREY      0x8410
#define C_DIM       0x4208
#define C_RED       0xF800
#define C_GREEN     0x07E0
#define C_BLUE      0x001F
#define C_YELLOW    0xFFE0
#define C_CYAN      0x07FF
#define C_ORANGE    0xFD20
#define C_HEADER_BG 0x18E3

static esp_lcd_panel_handle_t s_panel;
static uint16_t              *s_band;
static display_config_t       s_cfg;
static bool                   s_ble_connected;

void display_set_ble_connected(bool connected)
{
    s_ble_connected = connected;
}

/* ------------------------------------------------------------------ */
/* Band drawing primitives                                            */
/*                                                                    */
/* All coordinates are absolute screen coordinates; `band_y` is the    */
/* y of the band's first row, and anything outside is clipped.         */
/* ------------------------------------------------------------------ */

static void band_clear(uint16_t colour)
{
    /*
     * memset only works for a colour whose two bytes are equal (black,
     * white); everything else has to be written as pixels.
     */
    const uint8_t hi = (uint8_t)(colour >> 8);
    const uint8_t lo = (uint8_t)(colour & 0xFF);
    if (hi == lo) {
        memset(s_band, hi, (size_t)s_cfg.width * UI_BAND_H * sizeof(uint16_t));
        return;
    }
    const size_t n = (size_t)s_cfg.width * UI_BAND_H;
    for (size_t i = 0; i < n; i++) {
        s_band[i] = colour;
    }
}

static inline void band_px(int x, int y, int band_y, uint16_t colour)
{
    const int ly = y - band_y;
    if (x < 0 || x >= s_cfg.width || ly < 0 || ly >= UI_BAND_H) {
        return;
    }
    s_band[(size_t)ly * s_cfg.width + x] = colour;
}

static void band_fill_rect(int x, int y, int w, int h, int band_y, uint16_t colour)
{
    for (int yy = y; yy < y + h; yy++) {
        for (int xx = x; xx < x + w; xx++) {
            band_px(xx, yy, band_y, colour);
        }
    }
}

static void band_char(int x, int y, int band_y, char c, uint16_t colour, int scale)
{
    const uint8_t *g = ui_font_glyph(c);
    for (int col = 0; col < FONT_W; col++) {
        const uint8_t bits = g[col];
        for (int row = 0; row < FONT_H; row++) {
            if (!(bits & (1u << row))) {
                continue;
            }
            if (scale == 1) {
                band_px(x + col, y + row, band_y, colour);
            } else {
                band_fill_rect(x + col * scale, y + row * scale,
                               scale, scale, band_y, colour);
            }
        }
    }
}

static void band_text(int x, int y, int band_y, const char *s,
                      uint16_t colour, int scale)
{
    for (int i = 0; s[i] != '\0'; i++) {
        band_char(x + i * FONT_CELL_W * scale, y, band_y, s[i], colour, scale);
    }
}

/* Right-aligns `s` so numeric columns line up on their last digit. */
static void band_text_right(int right_x, int y, int band_y, const char *s,
                            uint16_t colour, int scale)
{
    band_text(right_x - ui_text_width(s, scale), y, band_y, s, colour, scale);
}

static void push_band(int band_y)
{
    int h = UI_BAND_H;
    if (band_y + h > s_cfg.height) {
        h = s_cfg.height - band_y;
    }
    if (h <= 0) {
        return;
    }
    esp_lcd_panel_draw_bitmap(s_panel,
                              s_cfg.x_offset,
                              s_cfg.y_offset + band_y,
                              s_cfg.x_offset + s_cfg.width,
                              s_cfg.y_offset + band_y + h,
                              s_band);
}

/* ------------------------------------------------------------------ */
/* Indicators                                                         */
/* ------------------------------------------------------------------ */

/*
 * A small WiFi glyph: three arcs over a dot, drawn as widening brackets so
 * it reads at this size without antialiasing. Greyed out when down.
 */
static void draw_wifi_icon(int x, int y, int band_y, bool up)
{
    const uint16_t c = up ? C_GREEN : C_DIM;
    for (int arc = 0; arc < 3; arc++) {
        const int r = 2 + arc * 3;
        for (int dx = -r; dx <= r; dx++) {
            const int dy = (int)lroundf(sqrtf((float)(r * r - dx * dx)));
            band_px(x + dx, y + 8 - dy, band_y, c);
        }
    }
    band_fill_rect(x - 1, y + 7, 2, 2, band_y, c);
}

/*
 * The Bluetooth rune, as two triangles meeting on a vertical stem. Drawn
 * with explicit segments rather than a bitmap so it scales with the row.
 */
static void draw_ble_icon(int x, int y, int band_y, bool up)
{
    const uint16_t c = up ? C_CYAN : C_DIM;
    const int h = 12;
    const int mid = y + h / 2;

    for (int i = 0; i < h; i++) {
        band_px(x, y + i, band_y, c);
    }
    for (int i = 0; i <= 3; i++) {
        band_px(x + i, y + i, band_y, c);                 /* upper right  */
        band_px(x + i, y + h - 1 - i, band_y, c);         /* lower right  */
        band_px(x + 3 - i, mid - 3 + i, band_y, c);       /* upper inner  */
        band_px(x + 3 - i, mid + 3 - i, band_y, c);       /* lower inner  */
    }
}

/* ------------------------------------------------------------------ */
/* State presentation                                                 */
/* ------------------------------------------------------------------ */

/*
 * The single-letter state code and its colour.
 *
 *   D discharge   C charge (and the shipping recharge)
 *   R rest        G complete/good   F fault
 *
 * CHECK_REST shows 'R' too: from the operator's side it is the same thing,
 * the slot is settling before anything happens.
 */
static char state_letter(slot_state_t st, uint16_t *colour)
{
    switch (st) {
    case SLOT_STATE_DISCHARGE:
        *colour = C_ORANGE;  return 'D';
    case SLOT_STATE_CHARGE:
    case SLOT_STATE_RECHARGE:
        *colour = C_YELLOW;  return 'C';
    case SLOT_STATE_CHECK_REST:
    case SLOT_STATE_REST:
    case SLOT_STATE_DISCHARGE_REST:
        *colour = C_BLUE;    return 'R';
    case SLOT_STATE_COMPLETE:
        *colour = C_GREEN;   return 'G';
    case SLOT_STATE_FAULT:
        *colour = C_RED;     return 'F';
    case SLOT_STATE_ABORTED:
        *colour = C_RED;     return 'A';
    case SLOT_STATE_IDLE:
    default:
        *colour = C_DIM;     return '-';
    }
}

/*
 * Formats a value into a fixed width, dropping precision as the number
 * grows so a four-digit mWh reading cannot push the column out of line.
 */
static void fmt_value(char *buf, size_t len, float v, int decimals)
{
    if (isnan(v) || isinf(v)) {
        snprintf(buf, len, "-");
        return;
    }
    const float a = fabsf(v);
    if (a >= 10000.0f) {
        snprintf(buf, len, "%.0fk", (double)(v / 1000.0f));
    } else if (a >= 1000.0f && decimals > 0) {
        snprintf(buf, len, "%.0f", (double)v);
    } else {
        snprintf(buf, len, "%.*f", decimals, (double)v);
    }
}

/* ------------------------------------------------------------------ */
/* Screens                                                            */
/* ------------------------------------------------------------------ */

/* Column right-edges, chosen so the widest expected value just fits. */
#define COL_V_R     96
#define COL_A_R     140
#define COL_MAH_R   190
#define COL_MWH_R   238

#define ROW_H       24
#define ROWS_TOP    40

static void draw_header(const bts_snapshot_t *snap)
{
    band_clear(C_HEADER_BG);

    const bool bts_up = snap->unit.online;
    if (bts_up) {
        band_text(4, 6, 0, "BTS LINK OK", C_GREEN, 1);
    } else {
        band_text(4, 6, 0, "WAITING FOR BTS", C_RED, 1);
    }

    draw_wifi_icon(180, 4, 0, web_api_sta_connected());
    draw_ble_icon(212, 4, 0, s_ble_connected);

    push_band(0);
}

static void draw_titles(void)
{
    /*
     * Everything here is in absolute screen coordinates and the band starts
     * at y=20, so the text sits at y=26. Drawing it at y=6 - inside the
     * header's band, not this one - clips it away entirely.
     */
    const int band_y = 20;

    band_clear(C_BLACK);
    band_text(4, band_y + 6, band_y, "SLOT", C_GREY, 1);
    band_text_right(COL_V_R, band_y + 6, band_y, "VOLT", C_GREY, 1);
    band_text_right(COL_A_R, band_y + 6, band_y, "AMP", C_GREY, 1);
    band_text_right(COL_MAH_R, band_y + 6, band_y, "mAh", C_GREY, 1);
    band_text_right(COL_MWH_R, band_y + 6, band_y, "mWh", C_GREY, 1);
    band_fill_rect(0, band_y + 18, s_cfg.width, 1, band_y, C_DIM);
    push_band(band_y);
}

static void draw_slot_row(uint8_t slot)
{
    const int y = ROWS_TOP + slot * ROW_H;

    slot_status_t st;
    test_engine_get_status(slot, &st);

    band_clear(C_BLACK);

    uint16_t sc;
    const char letter = state_letter(st.state, &sc);

    /* State badge. */
    char badge[2] = { letter, '\0' };
    band_fill_rect(2, y + 2, 18, 18, y, sc);
    band_text(7, y + 7, y, badge, C_BLACK, 1);

    /* Slot number, 1-based for the operator. */
    char num[4];
    snprintf(num, sizeof(num), "%u", (unsigned)(slot + 1));
    band_text(26, y + 7, y, num, C_WHITE, 1);

    char v[12];
    fmt_value(v, sizeof(v), st.voltage_v, 3);
    band_text_right(COL_V_R, y + 7, y, v, C_WHITE, 1);

    fmt_value(v, sizeof(v), st.current_a, 2);
    band_text_right(COL_A_R, y + 7, y, v, C_WHITE, 1);

    fmt_value(v, sizeof(v), (float)st.live_mah, 0);
    band_text_right(COL_MAH_R, y + 7, y, v, C_WHITE, 1);

    fmt_value(v, sizeof(v), (float)st.live_mwh, 0);
    band_text_right(COL_MWH_R, y + 7, y, v, C_WHITE, 1);

    /* Fault reason replaces the numbers - it is what the operator needs. */
    if (st.state == SLOT_STATE_FAULT) {
        band_fill_rect(40, y + 2, s_cfg.width - 42, ROW_H - 4, y, C_BLACK);
        band_text(44, y + 7, y, slot_fault_name(st.fault), C_RED, 1);
    }

    band_fill_rect(0, y + ROW_H - 1, s_cfg.width, 1, y, 0x1082);
    push_band(y);
}

/*
 * Boot/idle screen, shown while the BTS has never answered.
 *
 * The slot table would be eight rows of dashes at that point, which tells
 * an operator nothing. This says what is actually wrong.
 */
static void draw_waiting_screen(const bts_snapshot_t *snap)
{
    for (int band_y = 20; band_y < s_cfg.height; band_y += UI_BAND_H) {
        band_clear(C_BLACK);

        if (band_y <= 96 && 96 < band_y + UI_BAND_H) {
            band_text(24, 96, band_y, "WAITING FOR BTS", C_YELLOW, 2);
        }
        if (band_y <= 128 && 128 < band_y + UI_BAND_H) {
            band_text(28, 128, band_y, "I2C 0x50 no reply", C_GREY, 1);
        }
        if (band_y <= 148 && 148 < band_y + UI_BAND_H) {
            char line[40];
            snprintf(line, sizeof(line), "%u failed polls",
                     (unsigned)snap->unit.consecutive_errors);
            band_text(28, 148, band_y, line, C_DIM, 1);
        }
        if (band_y <= 176 && 176 < band_y + UI_BAND_H) {
            band_text(28, 176, band_y, "SDA 21  SCL 22", C_DIM, 1);
        }

        push_band(band_y);
    }
}

/*
 * Boot self-test: colour bars plus a text sample.
 *
 * The SPI link to the panel is write-only, so nothing in software can tell
 * whether pixels are actually landing. If these bars appear, the wiring,
 * SPI mode, clock and the ST7789 init sequence are all good, and any
 * remaining problem is in the UI drawing. If the panel stays blank, the
 * problem is below the UI - try spi_mode 2 and a lower pclk_hz.
 */
static void draw_self_test(void)
{
    static const uint16_t bars[] = {
        C_RED, C_GREEN, C_BLUE, C_YELLOW, C_CYAN, C_WHITE,
    };
    const int n = (int)(sizeof(bars) / sizeof(bars[0]));
    const int bar_w = s_cfg.width / n;

    for (int band_y = 0; band_y < s_cfg.height; band_y += UI_BAND_H) {
        band_clear(C_BLACK);

        /* Top half: colour bars. Bottom half: text at both scales. */
        if (band_y < s_cfg.height / 2) {
            for (int i = 0; i < n; i++) {
                band_fill_rect(i * bar_w, band_y, bar_w, UI_BAND_H,
                               band_y, bars[i]);
            }
        }
        if (band_y <= 140 && 140 < band_y + UI_BAND_H) {
            band_text(10, 140, band_y, "DISPLAY OK", C_WHITE, 2);
        }
        if (band_y <= 170 && 170 < band_y + UI_BAND_H) {
            band_text(10, 170, band_y, "abcdefg 0123456789", C_GREEN, 1);
        }
        if (band_y <= 190 && 190 < band_y + UI_BAND_H) {
            char line[48];
            snprintf(line, sizeof(line), "SPI mode %d  %lu kHz",
                     s_cfg.spi_mode, (unsigned long)(s_cfg.pclk_hz / 1000));
            band_text(10, 190, band_y, line, C_GREY, 1);
        }
        push_band(band_y);
    }
}

/* ------------------------------------------------------------------ */
/* Task                                                               */
/* ------------------------------------------------------------------ */

static void display_task(void *arg)
{
    (void)arg;
    bool showed_table = false;

    if (s_cfg.self_test) {
        draw_self_test();
        vTaskDelay(pdMS_TO_TICKS(4000));
    }

    for (;;) {
        bts_snapshot_t snap;
        bts_link_get_snapshot(&snap);

        draw_header(&snap);

        if (snap.unit.online) {
            if (!showed_table) {
                draw_titles();
                showed_table = true;
            }
            for (uint8_t slot = 0; slot < SLOT_COUNT && slot < 8; slot++) {
                draw_slot_row(slot);
            }
        } else {
            draw_waiting_screen(&snap);
            showed_table = false;
        }

        vTaskDelay(pdMS_TO_TICKS(s_cfg.refresh_ms));
    }
}

/* ------------------------------------------------------------------ */
/* Init                                                               */
/* ------------------------------------------------------------------ */

esp_err_t display_init(const display_config_t *config)
{
    if (config == NULL) {
        return ESP_ERR_INVALID_ARG;
    }
    s_cfg = *config;
    if (s_cfg.width == 0)      s_cfg.width = 240;
    if (s_cfg.height == 0)     s_cfg.height = 240;
    if (s_cfg.refresh_ms == 0) s_cfg.refresh_ms = 500;
    if (s_cfg.pclk_hz == 0)    s_cfg.pclk_hz = LCD_DEFAULT_CLOCK_HZ;
    if (s_cfg.spi_mode < 0 || s_cfg.spi_mode > 3) {
        s_cfg.spi_mode = 0;
    }

    /* Backlight off until the panel has something on it, to avoid a flash
     * of uninitialised memory at boot. */
    if (s_cfg.backlight_gpio >= 0) {
        const gpio_config_t bl = {
            .pin_bit_mask = BIT64(s_cfg.backlight_gpio),
            .mode = GPIO_MODE_OUTPUT,
            .pull_up_en = GPIO_PULLUP_DISABLE,
            .pull_down_en = GPIO_PULLDOWN_DISABLE,
            .intr_type = GPIO_INTR_DISABLE,
        };
        ESP_RETURN_ON_ERROR(gpio_config(&bl), TAG, "backlight gpio");
        gpio_set_level(s_cfg.backlight_gpio, 0);
    }

    const spi_bus_config_t bus = {
        .mosi_io_num = s_cfg.mosi_gpio,
        .miso_io_num = -1,               /* write-only panel */
        .sclk_io_num = s_cfg.sclk_gpio,
        .quadwp_io_num = -1,
        .quadhd_io_num = -1,
        .max_transfer_sz = 240 * UI_BAND_H * (int)sizeof(uint16_t),
    };
    ESP_RETURN_ON_ERROR(spi_bus_initialize(LCD_HOST, &bus, SPI_DMA_CH_AUTO),
                        TAG, "spi bus");

    const esp_lcd_panel_io_spi_config_t io_cfg = {
        /*
         * No chip select: the panel is alone on this bus, and the common
         * 1.3" modules tie CS low on the board.
         */
        .cs_gpio_num = -1,
        .dc_gpio_num = s_cfg.dc_gpio,
        .spi_mode = s_cfg.spi_mode,
        .pclk_hz = s_cfg.pclk_hz,
        .trans_queue_depth = 10,
        .lcd_cmd_bits = LCD_CMD_BITS,
        .lcd_param_bits = LCD_PARAM_BITS,
    };
    esp_lcd_panel_io_handle_t io = NULL;
    ESP_RETURN_ON_ERROR(esp_lcd_new_panel_io_spi((esp_lcd_spi_bus_handle_t)LCD_HOST,
                                                 &io_cfg, &io),
                        TAG, "panel io");

    const esp_lcd_panel_dev_config_t panel_cfg = {
        .reset_gpio_num = s_cfg.reset_gpio,
        .rgb_ele_order = LCD_RGB_ELEMENT_ORDER_RGB,
        .bits_per_pixel = 16,
    };
    ESP_RETURN_ON_ERROR(esp_lcd_new_panel_st7789(io, &panel_cfg, &s_panel),
                        TAG, "st7789");

    ESP_RETURN_ON_ERROR(esp_lcd_panel_reset(s_panel), TAG, "reset");
    ESP_RETURN_ON_ERROR(esp_lcd_panel_init(s_panel), TAG, "panel init");
    /* Most IPS ST7789 modules are wired such that the controller's idea of
     * colour polarity is inverted relative to the glass. */
    ESP_RETURN_ON_ERROR(esp_lcd_panel_invert_color(s_panel, s_cfg.invert_colour),
                        TAG, "invert");
    ESP_RETURN_ON_ERROR(esp_lcd_panel_disp_on_off(s_panel, true), TAG, "disp on");

    s_band = heap_caps_malloc((size_t)s_cfg.width * UI_BAND_H * sizeof(uint16_t),
                              MALLOC_CAP_DMA);
    if (s_band == NULL) {
        ESP_LOGE(TAG, "no DMA memory for the %d x %d band buffer",
                 s_cfg.width, UI_BAND_H);
        return ESP_ERR_NO_MEM;
    }

    /* Clear the whole panel before the backlight comes up. */
    band_clear(C_BLACK);
    for (int y = 0; y < s_cfg.height; y += UI_BAND_H) {
        push_band(y);
    }

    if (s_cfg.backlight_gpio >= 0) {
        gpio_set_level(s_cfg.backlight_gpio, 1);
    }

    if (xTaskCreate(display_task, "display", TASK_STACK, NULL, TASK_PRIO, NULL)
            != pdPASS) {
        return ESP_ERR_NO_MEM;
    }

    ESP_LOGI(TAG, "ST7789 up: MOSI=%d SCK=%d RES=%d DC=%d BLK=%d, %dx%d, "
                  "SPI mode %d at %lu Hz, offset %d,%d, invert %d",
             s_cfg.mosi_gpio, s_cfg.sclk_gpio, s_cfg.reset_gpio,
             s_cfg.dc_gpio, s_cfg.backlight_gpio, s_cfg.width, s_cfg.height,
             s_cfg.spi_mode, (unsigned long)s_cfg.pclk_hz,
             s_cfg.x_offset, s_cfg.y_offset, (int)s_cfg.invert_colour);
    return ESP_OK;
}
