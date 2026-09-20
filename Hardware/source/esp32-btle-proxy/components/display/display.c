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
 * G good/complete, F fault, P paused, W watchdog-paused, and a dim dash
 * when the slot is idle.
 *
 * Three other screens replace the table: the waiting screen while the BTS
 * has never answered, the boot self-test, and the calibration screen, which
 * outranks the table whenever a slot is being calibrated.
 */

#include <string.h>
#include <stdio.h>
#include <math.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_log.h"
#include "esp_check.h"
#include "esp_heap_caps.h"
#include "esp_timer.h"
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
#include "input.h"

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

/* Input-servicing cadence; the data refresh is much slower. */
#define UI_TICK_MS          20

#define TASK_STACK          4096
#define TASK_PRIO           3

/* RGB565. */
/*
 * Colours are written here in natural RGB565 (red in the high bits) and
 * byte-swapped on the way to the panel by RGB565().
 *
 * WHY NOT data_endian
 * -------------------
 * esp_lcd_panel_dev_config_t has a data_endian field, and setting it to
 * BIG looks like the right fix, but on this driver it only selects a bit in
 * the ST7789's RAMCTRL register - which the controller applies to its
 * parallel/RGB interfaces, not to SPI. Over SPI the panel always consumes
 * the most significant byte first, so the swap has to happen in the data.
 *
 * Getting this wrong is not a colour cast but a scramble: yellow (31,63,0)
 * becomes (28,7,31), which reads as purple, and green becomes red. The
 * giveaway is that white, black and grey look right, because their two
 * bytes are equal or near-equal.
 */
#define RGB565(c)   ((uint16_t)((((c) & 0x00FF) << 8) | (((c) & 0xFF00) >> 8)))

#define C_BLACK     RGB565(0x0000)
#define C_WHITE     RGB565(0xFFFF)
#define C_GREY       RGB565(0x8410)
#define C_DIM        RGB565(0x4208)
#define C_RED        RGB565(0xF800)
#define C_GREEN     RGB565(0x07E0)
#define C_BLUE       RGB565(0x001F)
#define C_YELLOW     RGB565(0xFFE0)
#define C_CYAN       RGB565(0x07FF)
#define C_ORANGE     RGB565(0xFD20)
#define C_HEADER_BG RGB565(0x18E3)
#define C_SELECT_BG RGB565(0x2124)   /* selected row tint */

/*
 * Input feedback border.
 *
 * The encoder is the only control on the unit, so it has to feel connected:
 * a flash confirms the firmware saw the event even when the consequence is
 * off-screen or subtle. Rotation and press flash different colours so they
 * are distinguishable without reading the row.
 */
#define BORDER_W            3
#define FLASH_MS            90
#define C_FLASH_ROTATE      C_CYAN
#define C_FLASH_PRESS       C_GREEN
#define C_FLASH_LONG        C_ORANGE

static esp_lcd_panel_handle_t s_panel;
static uint16_t              *s_band;
static display_config_t       s_cfg;
static bool                   s_ble_connected;
/*
 * Slot the encoder currently points at, 0-based. The menu system will build
 * on this; for now turning the encoder moves the highlight and the button
 * is acknowledged in the log, so the hardware can be verified before any
 * action is wired to it.
 */
static int                    s_selected_slot;
static int64_t                s_flash_until_us;
static uint16_t               s_flash_colour;
/* Whether a coloured border is currently on the glass, so it is only
 * redrawn on a transition rather than every pass. */
static bool                   s_border_lit;

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

/*
 * Fills an arbitrary screen rectangle in one transfer.
 *
 * Uses the band buffer as scratch, so w*h must not exceed its capacity.
 * This is how the border is drawn without repainting the whole screen: four
 * thin edges total about 5.7 kB, roughly 5 ms on the bus, against ~92 ms
 * for a full 240x240 repaint. That difference is what makes the flash feel
 * immediate rather than laggy.
 */
static void fill_screen_rect(int x, int y, int w, int h, uint16_t colour)
{
    const size_t n = (size_t)w * (size_t)h;
    if (n == 0 || n > (size_t)s_cfg.width * UI_BAND_H) {
        return;
    }
    for (size_t i = 0; i < n; i++) {
        s_band[i] = colour;
    }
    esp_lcd_panel_draw_bitmap(s_panel,
                              s_cfg.x_offset + x,
                              s_cfg.y_offset + y,
                              s_cfg.x_offset + x + w,
                              s_cfg.y_offset + y + h,
                              s_band);
}

/* Draws the four edges. C_BLACK erases. */
static void draw_border(uint16_t colour)
{
    const int w = s_cfg.width;
    const int h = s_cfg.height;

    fill_screen_rect(0, 0, w, BORDER_W, colour);                  /* top    */
    fill_screen_rect(0, h - BORDER_W, w, BORDER_W, colour);       /* bottom */
    fill_screen_rect(0, 0, BORDER_W, h, colour);                  /* left   */
    fill_screen_rect(w - BORDER_W, 0, BORDER_W, h, colour);       /* right  */
}

/* Starts a flash; the task turns it off once it has run its course. */
static void flash_border(uint16_t colour)
{
    s_flash_colour   = colour;
    s_flash_until_us = esp_timer_get_time() + (FLASH_MS * 1000LL);
    draw_border(colour);
    s_border_lit = true;
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
 *   P paused by a command or a boot restore
 *   W paused because the host watchdog fired
 *
 * CHECK_REST shows 'R' too: from the operator's side it is the same thing,
 * the slot is settling before anything happens.
 *
 * P and W are deliberately different letters rather than one colour-coded
 * badge: a stopped slot and a paused one look alike on the glass otherwise,
 * and the distinction between "I paused this" and "the link died" is the
 * whole reason an operator would go and look at the unit.
 */
static char state_letter(slot_state_t st, bool wd_tripped, uint16_t *colour)
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
    case SLOT_STATE_BTS_PAUSED:
        if (wd_tripped) {
            *colour = C_RED;    return 'W';
        }
        *colour = C_CYAN;    return 'P';
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

    const bool selected = ((int)slot == s_selected_slot);
    band_clear(selected ? C_SELECT_BG : C_BLACK);

    uint16_t sc;
    const char letter = state_letter(st.state, st.bts_wd_tripped, &sc);

    /* A caret in the left margin, so the selection survives a colour-blind
     * reading of the background tint. */
    if (selected) {
        band_text(0, y + 7, y, ">", C_WHITE, 1);
    }

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
        band_fill_rect(40, y + 2, s_cfg.width - 42, ROW_H - 4, y,
                       selected ? C_SELECT_BG : C_BLACK);
        band_text(44, y + 7, y, slot_fault_name(st.fault), C_RED, 1);
    } else if (st.state == SLOT_STATE_BTS_PAUSED) {
        /*
         * Why it is paused, not just that it is. A restored pause means the
         * unit rebooted and the cell in the holder may not be the one the
         * counters belong to, which is the case an operator must not resume
         * on reflex - so it is spelled out rather than colour-coded.
         */
        const char *why = st.bts_restored   ? "PAUSED - UNIT RESET"
                          : st.bts_wd_tripped ? "PAUSED - LINK LOST"
                                              : "PAUSED";
        band_fill_rect(40, y + 2, s_cfg.width - 42, ROW_H - 4, y,
                       selected ? C_SELECT_BG : C_BLACK);
        band_text(44, y + 7, y, why, st.bts_restored ? C_ORANGE : C_CYAN, 1);
    }

    band_fill_rect(0, y + ROW_H - 1, s_cfg.width, 1, y, RGB565(0x1082));
    push_band(y);
}

/*
 * Calibration screen.
 *
 * Shows only the slot under calibration: both measurement paths side by
 * side in engineering units and in the raw per-unit the two-point maths
 * actually consumes, so an operator adjusting a bench supply can see the pu
 * land inside its window rather than inferring it from the volts.
 */
#define CAL_COL_ADS_R   162
#define CAL_COL_F28_R   224
#define CAL_TICK_X      228

/*
 * The 5x7 font covers ASCII only, so the tick is drawn rather than typed:
 * a short stroke and a tall one sharing a baseline.
 */
static void band_tick(int x, int y, int band_y, uint16_t colour)
{
    band_fill_rect(x,     y + 5, 3, 4, band_y, colour);
    band_fill_rect(x + 3, y,     3, 9, band_y, colour);
}

static void draw_cal_screen(const bts_snapshot_t *snap)
{
    const bts_cal_state_t *cal = &snap->cal;

    char title[24];
    snprintf(title, sizeof(title), "SLOT %u", (unsigned)(cal->slot + 1));

    char v_ads[12], v_f28[12], vpu_ads[12], vpu_f28[12];
    char a_ads[12], a_f28[12], apu_ads[12], apu_f28[12], temp[16];

    fmt_value(v_ads,   sizeof(v_ads),   cal->ads_v_v,  4);
    fmt_value(v_f28,   sizeof(v_f28),   cal->f28_v_v,  4);
    fmt_value(vpu_ads, sizeof(vpu_ads), cal->ads_v_pu, 4);
    fmt_value(vpu_f28, sizeof(vpu_f28), cal->f28_v_pu, 4);
    fmt_value(a_ads,   sizeof(a_ads),   cal->ads_i_a,  4);
    fmt_value(a_f28,   sizeof(a_f28),   cal->f28_i_a,  4);
    fmt_value(apu_ads, sizeof(apu_ads), cal->ads_i_pu, 4);
    fmt_value(apu_f28, sizeof(apu_f28), cal->f28_i_pu, 4);
    fmt_value(temp,    sizeof(temp),    cal->temp_c,   1);
    strncat(temp, " C", sizeof(temp) - strlen(temp) - 1);

    for (int band_y = 20; band_y < s_cfg.height; band_y += UI_BAND_H) {
        band_clear(C_BLACK);

        if (band_y == 20) {
            band_fill_rect(0, 20, s_cfg.width, UI_BAND_H, band_y, C_HEADER_BG);
            band_text(4, 27, band_y, "CALIBRATION", C_YELLOW, 1);
            band_text_right(236, 27, band_y, title, C_WHITE, 1);
        } else if (band_y == 44) {
            band_text_right(CAL_COL_ADS_R, 51, band_y, "ADS131", C_GREY, 1);
            band_text_right(CAL_COL_F28_R, 51, band_y, "F28 ADC", C_GREY, 1);
            band_fill_rect(0, 62, s_cfg.width, 1, band_y, C_DIM);
        } else if (band_y == 68) {
            band_text(8, 75, band_y, "V", C_WHITE, 1);
            band_text_right(CAL_COL_ADS_R, 75, band_y, v_ads, C_WHITE, 1);
            band_text_right(CAL_COL_F28_R, 75, band_y, v_f28, C_WHITE, 1);
            if (cal->v_tick) {
                band_tick(CAL_TICK_X, 74, band_y, C_GREEN);
            }
        } else if (band_y == 92) {
            band_text(8, 99, band_y, "pu", C_GREY, 1);
            band_text_right(CAL_COL_ADS_R, 99, band_y, vpu_ads, C_GREY, 1);
            band_text_right(CAL_COL_F28_R, 99, band_y, vpu_f28, C_GREY, 1);
        } else if (band_y == 116) {
            band_text(8, 123, band_y, "A", C_WHITE, 1);
            band_text_right(CAL_COL_ADS_R, 123, band_y, a_ads, C_WHITE, 1);
            band_text_right(CAL_COL_F28_R, 123, band_y, a_f28, C_WHITE, 1);
            if (cal->i_tick) {
                band_tick(CAL_TICK_X, 122, band_y, C_GREEN);
            }
        } else if (band_y == 140) {
            band_text(8, 147, band_y, "pu", C_GREY, 1);
            band_text_right(CAL_COL_ADS_R, 147, band_y, apu_ads, C_GREY, 1);
            band_text_right(CAL_COL_F28_R, 147, band_y, apu_f28, C_GREY, 1);
        } else if (band_y == 164) {
            band_text(8, 171, band_y, "T", C_WHITE, 1);
            band_text_right(CAL_COL_ADS_R, 171, band_y, temp, C_CYAN, 1);
        } else if (band_y == 188) {
            /* Which capture points are held, so the operator knows what
             * COMPUTE_SAVE would have to work with. */
            static const struct {
                const char *label;
                uint32_t    bit;
                int         x;
            } points[] = {
                { "LO", BTS_CAL_ST_V_LOW,    8 },
                { "HI", BTS_CAL_ST_V_HIGH,  60 },
                { "I0", BTS_CAL_ST_I_ZERO, 112 },
                { "IL", BTS_CAL_ST_I_LOADED, 164 },
            };
            band_fill_rect(0, 190, s_cfg.width, 1, band_y, C_DIM);
            for (size_t i = 0; i < sizeof(points) / sizeof(points[0]); i++) {
                const bool held = (cal->status_bits & points[i].bit) != 0;
                band_text(points[i].x, 197, band_y, points[i].label,
                          held ? C_GREEN : C_DIM, 1);
                band_text(points[i].x + 18, 197, band_y, held ? "set" : "---",
                          held ? C_GREEN : C_DIM, 1);
            }
        } else if (band_y == 212 && cal->result != BTS_CAL_ERR_OK) {
            /* The last refusal, which is otherwise only visible over the
             * API - and the bench operator is the one who has to act on it. */
            band_text(8, 219, band_y, bts_link_cal_result_name(cal->result),
                      C_RED, 1);
        }

        push_band(band_y);
    }
}

/*
 * Boot/idle screen, shown while the BTS has never answered.
 *
 * The slot table would be eight rows of dashes at that point, which tells
 * an operator nothing. This says what is actually wrong.
 */static void draw_waiting_screen(const bts_snapshot_t *snap)
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

    /*
     * The loop ticks far faster than it repaints.
     *
     * Input has to be serviced within a few tens of milliseconds or the
     * encoder feels dead, and the flash is only 90 ms long - both need finer
     * granularity than the 500 ms data refresh. So the tick is short, input
     * and the flash are handled every pass, and the panel contents are
     * redrawn only when refresh_ms has elapsed or an event changed something.
     */
    int64_t next_refresh_us = 0;

    for (;;) {
        const int64_t now = esp_timer_get_time();
        bool need_redraw = (now >= next_refresh_us);

        input_event_t ev;
        while (input_wait_event(&ev, 0)) {
            switch (ev.type) {
            case INPUT_EVENT_ROTATE_CW:
                s_selected_slot += ev.steps;
                flash_border(C_FLASH_ROTATE);
                need_redraw = true;
                break;
            case INPUT_EVENT_ROTATE_CCW:
                s_selected_slot -= ev.steps;
                flash_border(C_FLASH_ROTATE);
                need_redraw = true;
                break;
            case INPUT_EVENT_PRESS:
                flash_border(C_FLASH_PRESS);
                ESP_LOGI(TAG, "select: slot %d", s_selected_slot + 1);
                break;
            case INPUT_EVENT_LONG_PRESS:
                flash_border(C_FLASH_LONG);
                ESP_LOGI(TAG, "menu request on slot %d", s_selected_slot + 1);
                break;
            default:
                break;
            }
            /* Clamp rather than wrap: an operator scrolling to the end of a
             * short list should stop there, not jump to the other end. */
            if (s_selected_slot < 0) {
                s_selected_slot = 0;
            }
            if (s_selected_slot >= SLOT_COUNT) {
                s_selected_slot = SLOT_COUNT - 1;
            }
        }

        /* Expire a finished flash. */
        if (s_border_lit && esp_timer_get_time() >= s_flash_until_us) {
            draw_border(C_BLACK);
            s_border_lit = false;
        }

        if (!need_redraw) {
            vTaskDelay(pdMS_TO_TICKS(UI_TICK_MS));
            continue;
        }
        next_refresh_us = esp_timer_get_time() + (int64_t)s_cfg.refresh_ms * 1000;

        bts_snapshot_t snap;
        bts_link_get_snapshot(&snap);

        draw_header(&snap);

        /*
         * Calibration outranks the slot table: the operator is at the bench
         * with a DMM in hand, and the seven other slots are idle by the
         * one-slot-at-a-time rule anyway.
         */
        if (snap.cal.active && snap.cal.slot < SLOT_COUNT) {
            draw_cal_screen(&snap);
            showed_table = false;
        } else if (snap.unit.online) {
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

        /*
         * Bands span the full width, so a repaint wipes the left and right
         * edges of a lit border. Put it back rather than waiting for the
         * flash to expire, otherwise a redraw that lands mid-flash leaves
         * the border half-drawn.
         */
        if (s_border_lit) {
            draw_border(s_flash_colour);
        }

        vTaskDelay(pdMS_TO_TICKS(UI_TICK_MS));
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
        .rgb_ele_order = s_cfg.bgr_order ? LCD_RGB_ELEMENT_ORDER_BGR
                                         : LCD_RGB_ELEMENT_ORDER_RGB,
        /*
         * Byte order is handled by RGB565() at the colour definitions, not
         * here: this driver's data_endian only sets a RAMCTRL bit that the
         * ST7789 applies to its parallel interface, not to SPI.
         */
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
