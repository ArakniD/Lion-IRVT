/*
 * display.c
 *
 * ST7789 front panel: a 320x240 landscape status table, a menu and a fault
 * dialog, all driven from the rotary encoder. See display.h for the wiring,
 * the memory strategy and how the rotation is done.
 *
 * LAYOUT (320x240)
 * ----------------
 *   y   0..15    header: BTS link state, WiFi and BLE indicators
 *   y  16..27    column titles
 *   y  28..235   eight slot rows, 26 px each
 *
 *   x   0..217   the slot table
 *   x 220..319   the menu pane
 *
 * A slot row is
 *
 *   <slot> <mode>  <VOLTS>  <AMPS>   mAh   degC
 *          CC/CV                     mWh   mins
 *
 * with volts and amps at double size, because they are what an operator
 * reads from across the bench, and the rest in the small font, stacked two
 * to a column - six small columns side by side would not fit beside the
 * menu pane at this font size. The mode is a
 * three-letter code: IDL CHG DSG RST CHK RCH END FLT ABT PSE PWD PRS RDY BAL
 * SS - see mode_code().
 *
 * NAVIGATION
 * ----------
 * Everything is the encoder: turn to move, press to choose.
 *
 *   SLOTS        turn picks a slot; press opens its menu
 *   MENU         Run mode >, Settings >, Back; and Clear fault / Resume
 *                / Pause when they apply
 *   RUN MODE     Idle, Auto-test, Discharge, Charge, Back; press applies
 *   SETTINGS     every slot setting; press edits, Back saves
 *   EDIT         turn adjusts, faster turning takes bigger steps; press
 *                accepts
 *
 * A long press always goes back one level. With nothing pressed for a
 * minute the panel returns to the slot list, so an abandoned menu does not
 * sit over the live table.
 *
 * FAULTS
 * ------
 * A slot that faults raises a dialog over everything, naming the fault and
 * its slot, with "Clear fault" and "Ignore". A press on Clear acknowledges it
 * on both the engine and the unit; Ignore dismisses the dialog for that one
 * fault, and the slot stays faulted - it cannot be started until cleared.
 *
 * Two screens replace the table entirely: the waiting screen while the BTS
 * has never answered, and the calibration screen, which outranks everything
 * while a slot is being calibrated.
 */

#include <string.h>
#include <stdio.h>
#include <math.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/semphr.h"
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
 * Band height. 320 * 26 * 2 = 16.6 kB per buffer, which covers exactly one
 * slot row, and there are two of them so the next band can be drawn while
 * the last is still clocking out. 33 kB of DMA-capable RAM against the
 * roughly 89 kB left once NimBLE and WiFi are up.
 */
#define UI_BAND_H           26

/* Input-servicing cadence; the data refresh is much slower. */
#define UI_TICK_MS          20

/* The menu gives up and returns to the slot list after this much idling. */
#define MENU_IDLE_MS        60000

/*
 * The unit's latched fault indications. Each holds the slot off until it is
 * cleared, and the engine refuses to start a slot carrying any of them - so
 * the panel has to treat every one as a fault, not just the over-current, or
 * a slot can be held off with no way to clear it from here.
 */
#define UNIT_LATCH_BITS     (BTS_STATUS_OVERCURRENT | BTS_STATUS_GROUP_DISCONNECT)

/*
 * Panel re-sync interval. The table is redrawn twice a second already, so a
 * panel that goes blank while that continues has lost its CONFIGURATION, not
 * its pixels - a supply dip or ESD on the ribbon can knock the ST7789 back to
 * sleep or reset its registers, and no amount of pixel data brings it back.
 * So once a minute the controller is re-initialised (sleep-out, pixel format,
 * orientation, inversion, display on) and the backlight re-asserted, then the
 * whole screen redrawn. On a healthy panel this is invisible.
 */
#define PANEL_RESYNC_MS     60000

#define TASK_STACK          6144
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
#define C_GREY      RGB565(0x8410)
#define C_DIM       RGB565(0x4208)
#define C_RULE      RGB565(0x1082)
#define C_RED       RGB565(0xF800)
#define C_DARK_RED  RGB565(0x6000)
#define C_GREEN     RGB565(0x07E0)
#define C_BLUE      RGB565(0x041F)
#define C_YELLOW    RGB565(0xFFE0)
#define C_CYAN      RGB565(0x07FF)
#define C_ORANGE    RGB565(0xFD20)
#define C_HEADER_BG RGB565(0x18E3)
#define C_SELECT_BG RGB565(0x2124)   /* selected row tint     */
#define C_PANE_BG   RGB565(0x0841)   /* menu pane background  */
#define C_CURSOR_BG RGB565(0x2945)   /* menu cursor tint      */
#define C_EDIT_BG   RGB565(0x0200)   /* value being edited    */

/* ------------------------------------------------------------------ */
/* Geometry                                                           */
/* ------------------------------------------------------------------ */

#define HEADER_H    16
#define TITLES_Y    16
#define TITLES_H    12
#define ROWS_TOP    28
#define ROW_H       UI_BAND_H

#define TABLE_W     218          /* slot table, x 0..217          */
#define PANE_X      220          /* menu pane, x 220..319         */
#define PANE_TEXT_X (PANE_X + 4)

/*
 * Slot-row columns. Right edges, so numbers line up on their last digit.
 * Volts and amps are at scale 2 (12 px per character): "4.205" is 60 px and
 * "-9.99" is 60 px, which is what the two big columns are sized for.
 */
#define COL_SLOT_X  2
#define COL_MODE_X  12
#define COL_V_R     96
#define COL_A_R     160
/*
 * The small stack. mAh/mWh are capped at four characters by fmt_value()
 * ("9999", then "10k"), and temperature at four ("81.3"), so each column is
 * 24 px plus a gap.
 */
#define COL_MAH_R   188          /* mAh over mWh                  */
#define COL_TEMP_R  216          /* degC over minutes             */

/* ------------------------------------------------------------------ */
/* State                                                              */
/* ------------------------------------------------------------------ */

static esp_lcd_panel_handle_t s_panel;
static esp_lcd_panel_io_handle_t s_io;
static display_config_t       s_cfg;
static bool                   s_ble_connected;

/*
 * Two band buffers, alternated. esp_lcd queues a colour transfer and returns
 * before the DMA has read it, so drawing the next band into the same buffer
 * would overwrite pixels still on their way to the panel. One buffer in
 * flight and one being drawn removes that race without waiting on every
 * band; the semaphore below makes sure a buffer is free before reuse.
 */
static uint16_t              *s_bufs[2];
static uint16_t              *s_band;
static int                    s_buf_idx;
static SemaphoreHandle_t      s_flush_sem;
static int                    s_inflight;

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

static bool on_flush_done(esp_lcd_panel_io_handle_t io,
                          esp_lcd_panel_io_event_data_t *edata, void *ctx)
{
    (void)io;
    (void)edata;
    (void)ctx;
    BaseType_t woken = pdFALSE;
    xSemaphoreGiveFromISR(s_flush_sem, &woken);
    return woken == pdTRUE;
}

/* Waits for transfers so at most `keep` remain in flight. */
static void flush_wait(int keep)
{
    while (s_inflight > keep) {
        if (xSemaphoreTake(s_flush_sem, pdMS_TO_TICKS(200)) != pdTRUE) {
            /* A lost completion would wedge the UI for good; give up on it. */
            ESP_LOGW(TAG, "panel flush timed out");
            s_inflight = keep;
            break;
        }
        s_inflight--;
    }
}

/* Switches to the other buffer, waiting until it is no longer in flight. */
static void band_next(void)
{
    s_buf_idx ^= 1;
    s_band = s_bufs[s_buf_idx];
    flush_wait(1);
}

static void band_clear(uint16_t colour)
{
    band_next();
    /*
     * memset only works for a colour whose two bytes are equal (black,
     * white); everything else has to be written as pixels.
     */
    const uint8_t hi = (uint8_t)(colour >> 8);
    const uint8_t lo = (uint8_t)(colour & 0xFF);
    const size_t n = (size_t)s_cfg.width * UI_BAND_H;
    if (hi == lo) {
        memset(s_band, hi, n * sizeof(uint16_t));
        return;
    }
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
    /* Clip once, then fill rows directly: this runs for every background. */
    int y0 = (y > band_y) ? y : band_y;
    int y1 = (y + h < band_y + UI_BAND_H) ? y + h : band_y + UI_BAND_H;
    int x0 = (x > 0) ? x : 0;
    int x1 = (x + w < s_cfg.width) ? x + w : s_cfg.width;
    for (int yy = y0; yy < y1; yy++) {
        uint16_t *row = &s_band[(size_t)(yy - band_y) * s_cfg.width];
        for (int xx = x0; xx < x1; xx++) {
            row[xx] = colour;
        }
    }
}

static void band_char(int x, int y, int band_y, char c, uint16_t colour, int scale)
{
    /* Whole glyph outside the band: skip it rather than clip every pixel. */
    if (y >= band_y + UI_BAND_H || y + FONT_H * scale <= band_y) {
        return;
    }
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

static void band_text_centre(int centre_x, int y, int band_y, const char *s,
                             uint16_t colour, int scale)
{
    band_text(centre_x - ui_text_width(s, scale) / 2, y, band_y, s, colour, scale);
}

static void push_band_h(int band_y, int h)
{
    if (band_y + h > s_cfg.height) {
        h = s_cfg.height - band_y;
    }
    if (h <= 0) {
        return;
    }
    /*
     * Logical coordinates. The rotation lives in the controller's MADCTL and
     * the window offset in esp_lcd_panel_set_gap(), so nothing here knows
     * the panel is on its side.
     */
    if (esp_lcd_panel_draw_bitmap(s_panel, 0, band_y, s_cfg.width, band_y + h,
                                  s_band) == ESP_OK) {
        s_inflight++;
    }
}

static void push_band(int band_y)
{
    push_band_h(band_y, UI_BAND_H);
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

/*
 * The 5x7 font covers ASCII only, so the tick is drawn rather than typed:
 * a short stroke and a tall one sharing a baseline.
 */
static void band_tick(int x, int y, int band_y, uint16_t colour)
{
    band_fill_rect(x,     y + 5, 3, 4, band_y, colour);
    band_fill_rect(x + 3, y,     3, 9, band_y, colour);
}

/* ------------------------------------------------------------------ */
/* State presentation                                                 */
/* ------------------------------------------------------------------ */

/*
 * The three-letter mode code and its colour.
 *
 * The engine's state comes first, because it is what a test is doing; the
 * BTS's own status word fills in for a slot the engine is not running - a
 * direct charge or discharge from this panel or a host, or a pre-charge
 * sequence.
 *
 *   CHG DSG RCH    powered: charging, discharging, recharging to shipping
 *   RST CHK        resting, or measuring the open-circuit voltage
 *   END            test complete, or the BTS ended a direct run on its own
 *   FLT ABT        faulted, aborted
 *   PSE PWD PRS    paused: by command, by the host watchdog, by a reset
 *   BAL SS RDY     pre-charge: balancing, soft start, ready for a cell
 *   OFF            disabled by the ENABLE strap
 *   IDL            idle
 *
 * The three pause codes are distinct on purpose. "I paused this" and "the
 * link died" look alike otherwise, and the difference is the whole reason an
 * operator would walk over to the unit.
 */
static const char *mode_code(const slot_status_t *st, uint16_t *colour)
{
    switch (st->state) {
    case SLOT_STATE_DISCHARGE:
        *colour = C_ORANGE; return "DSG";
    case SLOT_STATE_CHARGE:
        *colour = C_YELLOW; return "CHG";
    case SLOT_STATE_RECHARGE:
        *colour = C_YELLOW; return "RCH";
    case SLOT_STATE_DIRECT:
        /* A bare run from the menu or a host: the direction is the mode. */
        if (st->bts_paused) {
            *colour = C_CYAN;   return "PSE";
        }
        /* The commanded direction, not the status bits: those are one poll
         * behind and read as discharge on a slot that has just been stopped. */
        if (st->direct_charge) {
            *colour = C_YELLOW; return "CHG";
        }
        *colour = C_ORANGE; return "DSG";
    case SLOT_STATE_CHECK_REST:
        *colour = C_BLUE;   return "CHK";
    case SLOT_STATE_REST:
    case SLOT_STATE_DISCHARGE_REST:
        *colour = C_BLUE;   return "RST";
    case SLOT_STATE_COMPLETE:
        *colour = C_GREEN;  return "END";
    case SLOT_STATE_FAULT:
        *colour = C_RED;    return "FLT";
    case SLOT_STATE_ABORTED:
        *colour = C_RED;    return "ABT";
    case SLOT_STATE_BTS_PAUSED:
        if (st->bts_restored) {
            *colour = C_ORANGE; return "PRS";
        }
        if (st->bts_wd_tripped) {
            *colour = C_RED;    return "PWD";
        }
        *colour = C_CYAN;   return "PSE";
    case SLOT_STATE_IDLE:
    default:
        break;
    }

    /* The engine is idle; say what the unit is doing on its own. */
    const uint32_t b = st->status_bits;
    if (b & BTS_STATUS_SLOT_DISABLED) {
        *colour = C_DIM;    return "OFF";
    }
    if (b & UNIT_LATCH_BITS) {
        *colour = C_RED;    return "FLT";
    }
    if (st->bts_paused) {
        *colour = C_CYAN;   return "PSE";
    }
    if (b & BTS_STATUS_RUNNING) {
        if (b & BTS_STATUS_CHARGING) {
            *colour = C_YELLOW; return "CHG";
        }
        *colour = C_ORANGE; return "DSG";
    }
    if (st->bts_balancing) {
        *colour = C_YELLOW; return "BAL";
    }
    if (st->bts_soft_start) {
        *colour = C_YELLOW; return "SS";
    }
    if (st->bts_ready) {
        *colour = C_GREEN;  return "RDY";
    }
    if (st->bts_ended) {
        *colour = C_GREEN;  return "END";
    }
    *colour = C_DIM;
    return "IDL";
}

/*
 * The figures a row shows, chosen by what the slot is doing.
 *
 * A test reports the engine's own integration, which samples on real elapsed
 * time. A direct run has no engine integration at all, so it reports the
 * unit's per-direction counters instead - otherwise a panel-started charge
 * would sit on zero mAh for its whole run. Minutes follow the same rule.
 */
static void slot_figures(const slot_status_t *st, float *mah, float *mwh,
                         uint32_t *mins)
{
    const bool engine_run = st->state != SLOT_STATE_IDLE &&
                            st->state != SLOT_STATE_FAULT &&
                            st->state != SLOT_STATE_ABORTED &&
                            st->state != SLOT_STATE_DIRECT;
    if (engine_run) {
        *mah  = (float)st->live_mah;
        *mwh  = (float)st->live_mwh;
        *mins = st->elapsed_s / 60u;
        return;
    }
    /* A direct run's direction is what was commanded; the status bits are one
     * poll behind it. Everything else reads the bits. */
    const bool charging = (st->state == SLOT_STATE_DIRECT)
                              ? st->direct_charge
                              : (st->status_bits & BTS_STATUS_CHARGING) != 0;
    *mah  = charging ? st->bts_charge_mah : st->bts_discharge_mah;
    *mwh  = charging ? st->bts_charge_mwh : st->bts_discharge_mwh;
    *mins = (uint32_t)((charging ? st->bts_charge_seconds
                                 : st->bts_discharge_seconds) / 60.0f);
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
/* UI model                                                           */
/* ------------------------------------------------------------------ */

typedef enum {
    VIEW_SLOTS = 0,     /* turning picks a slot                      */
    VIEW_MENU,          /* the slot's top-level menu                 */
    VIEW_RUN,           /* run mode chooser                          */
    VIEW_SETTINGS,      /* list of settings                          */
    VIEW_EDIT,          /* one setting being adjusted                */
} ui_view_t;

typedef enum {
    MENU_RUN = 0,
    MENU_SETTINGS,
    MENU_CLEAR,
    MENU_RESUME,
    MENU_PAUSE,
    MENU_BACK,
} menu_item_t;

typedef enum {
    RUN_IDLE = 0,
    RUN_AUTO,
    RUN_DISCHARGE,
    RUN_CHARGE,
    RUN_BACK,
    RUN_COUNT,
} run_item_t;

/*
 * Editable settings.
 *
 * Each maps to one slot_config_t field. Voltages and currents are held in
 * millivolts and milliamps while editing, so the encoder steps whole units:
 * 1 mV / 1 mA when turned slowly, then 10, 100, 1000 as it speeds up.
 *
 * The voltage and current fields edit an OVERRIDE. Their starting value is
 * the effective one the profile resolves to, so an operator always adjusts
 * from what the slot will actually do. Turning one down to 0 stores "no
 * override" and so restores the chemistry or model default - for the cutoff
 * voltage that means the default cutoff, not 0 V.
 */
typedef enum {
    SET_CHEM = 0,
    SET_MODEL,
    SET_CAPACITY,
    SET_CHG_V,
    SET_DIS_V,
    SET_CHG_I,
    SET_DIS_I,
    SET_TERM_I,
    SET_TEMP_MAX,
    SET_TIME_MAX,
    SET_RECHARGE,
    SET_SHIP_PCT,
    SET_BACK,
    SET_COUNT,
} set_item_t;

typedef struct {
    const char *label;
    const char *unit;
    int32_t     min;
    int32_t     max;
    int         decimals;   /* display: value / 10^decimals          */
} set_def_t;

/* Units are stored mV, mA, mAh, 0.1 degC, minutes and percent. */
static const set_def_t k_set_defs[SET_COUNT] = {
    [SET_CHEM]     = { "Chem",     "",    0, CELL_CHEM_COUNT - 1,  0 },
    [SET_MODEL]    = { "Model",    "",    0, 0,                    0 },
    [SET_CAPACITY] = { "Cap",      "mAh", 100, 20000,              0 },
    [SET_CHG_V]    = { "Chg V",    "V",   0, 5000,                 3 },
    [SET_DIS_V]    = { "Cut V",    "V",   0, 5000,                 3 },
    [SET_CHG_I]    = { "Chg I",    "A",   0, 10000,                3 },
    [SET_DIS_I]    = { "Dsg I",    "A",   0, 10000,                3 },
    [SET_TERM_I]   = { "Term I",   "A",   0, 10000,                3 },
    [SET_TEMP_MAX] = { "T max",    "C",   0, 1000,                 1 },
    [SET_TIME_MAX] = { "Time",     "min", 0, 2880,                 0 },
    [SET_RECHARGE] = { "Rechg",    "",    0, 1,                    0 },
    [SET_SHIP_PCT] = { "Ship",     "%",   1, 100,                  0 },
    [SET_BACK]     = { "< Save",   "",    0, 0,                    0 },
};

static struct {
    ui_view_t   view;
    int         slot;           /* 0-based, the slot the menu acts on   */
    int         cursor;         /* item index within the current view   */

    /* The settings being edited, committed only on "Save". */
    slot_config_t edit_cfg;
    bool          edit_dirty;
    int32_t       edit_value;   /* the value under VIEW_EDIT            */
    int           edit_item;

    /* Fault dialog. */
    bool          fault_open;
    int           fault_slot;
    int           fault_cursor; /* 0 = Clear, 1 = Ignore                */
    /*
     * What has been acknowledged, per slot: a fault is shown again only if
     * the slot recovers and then faults afresh. Keyed on whether the slot is
     * faulted at all, so Ignore holds until the fault is actually cleared.
     */
    bool          fault_seen[SLOT_COUNT];

    /* Status line in the pane, for refusals and confirmations. */
    /* At most 16 characters: the pane title strip is 100 px wide. */
    char          note[20];
    uint16_t      note_colour;
    int64_t       note_until_us;

    int64_t       last_input_us;
} s_ui;

/* The unit's grouping, from the latest snapshot. 1 when ungrouped. */
static bts_unit_status_t ui_unit(void)
{
    bts_snapshot_t snap;
    bts_link_get_snapshot(&snap);
    return snap.unit;
}

static void set_note(const char *text, uint16_t colour)
{
    snprintf(s_ui.note, sizeof(s_ui.note), "%s", text);
    s_ui.note_colour   = colour;
    s_ui.note_until_us = esp_timer_get_time() + 4000000;
}

/* Whether a slot is faulted from the operator's point of view. */
static bool slot_is_faulted(const slot_status_t *st)
{
    if (st->state == SLOT_STATE_FAULT) {
        return true;
    }
    /*
     * The unit latches these until they are cleared, and will not run the
     * slot meanwhile - whether or not the engine owned the run that tripped.
     * So any slot the engine is not actively running counts as faulted while
     * a latch is up.
     */
    const bool engine_idle = st->state == SLOT_STATE_IDLE ||
                             st->state == SLOT_STATE_COMPLETE ||
                             st->state == SLOT_STATE_ABORTED;
    return engine_idle && (st->status_bits & UNIT_LATCH_BITS) != 0;
}

static const char *fault_text(const slot_status_t *st)
{
    if (st->state != SLOT_STATE_FAULT) {
        return (st->status_bits & BTS_STATUS_OVERCURRENT) ? "Over-current trip"
                                                          : "Group disconnect";
    }
    switch (st->fault) {
    case SLOT_FAULT_OVER_TEMP:     return "Over temperature";
    case SLOT_FAULT_UNDER_TEMP:    return "Under temperature";
    case SLOT_FAULT_OVER_CURRENT:  return "Over current";
    case SLOT_FAULT_CMPSS_TRIP:    return "Hardware trip";
    case SLOT_FAULT_GPIO_TRIP:     return "External trip";
    case SLOT_FAULT_TIMEOUT:       return "Time limit reached";
    case SLOT_FAULT_BTS_OFFLINE:   return "Unit link lost";
    case SLOT_FAULT_UNIT_STATE:    return "Input voltage";
    case SLOT_FAULT_NO_CELL:       return "No cell";
    case SLOT_FAULT_CELL_REVERSED: return "Cell reversed";
    case SLOT_FAULT_COMMS:         return "Command failed";
    default:                       return slot_fault_name(st->fault);
    }
}

/* ---- top menu ------------------------------------------------------ */

/*
 * The top menu's items depend on the slot: Clear only when there is a fault
 * to clear, Resume only on a paused slot, Pause only on a running one.
 * Built fresh each time so it follows the slot as it changes underneath.
 */
static int menu_items(const slot_status_t *st, menu_item_t *out)
{
    int n = 0;
    out[n++] = MENU_RUN;
    out[n++] = MENU_SETTINGS;
    if (slot_is_faulted(st) || st->state == SLOT_STATE_ABORTED) {
        out[n++] = MENU_CLEAR;
    }
    if (st->bts_paused) {
        out[n++] = MENU_RESUME;
    } else if (st->status_bits & BTS_STATUS_RUNNING) {
        out[n++] = MENU_PAUSE;
    }
    out[n++] = MENU_BACK;
    return n;
}

static const char *menu_label(menu_item_t item)
{
    switch (item) {
    case MENU_RUN:      return "Run mode   >";
    case MENU_SETTINGS: return "Settings   >";
    case MENU_CLEAR:    return "Clear fault";
    case MENU_RESUME:   return "Resume";
    case MENU_PAUSE:    return "Pause";
    case MENU_BACK:
    default:            return "< Back";
    }
}

static const char *const k_run_labels[RUN_COUNT] = {
    [RUN_IDLE]      = "Idle",
    [RUN_AUTO]      = "Auto-test",
    [RUN_DISCHARGE] = "Discharge",
    [RUN_CHARGE]    = "Charge",
    [RUN_BACK]      = "< Back",
};

/* Which run mode the slot is in now, so the list can mark it. */
static run_item_t current_run(const slot_status_t *st)
{
    switch (st->state) {
    case SLOT_STATE_CHECK_REST:
    case SLOT_STATE_CHARGE:
    case SLOT_STATE_REST:
    case SLOT_STATE_DISCHARGE:
    case SLOT_STATE_DISCHARGE_REST:
    case SLOT_STATE_RECHARGE:
        return RUN_AUTO;
    case SLOT_STATE_DIRECT:
        return st->direct_charge ? RUN_CHARGE : RUN_DISCHARGE;
    default:
        break;
    }
    if ((st->status_bits & BTS_STATUS_RUNNING) && !st->bts_paused) {
        return (st->status_bits & BTS_STATUS_CHARGING) ? RUN_CHARGE : RUN_DISCHARGE;
    }
    return RUN_IDLE;
}

/* ---- settings ------------------------------------------------------ */

static const cell_model_t *edit_model(void)
{
    return cell_model_find(s_ui.edit_cfg.model_name);
}

/* Model index for the editor: 0 is "none", then the table in order. */
static int32_t model_index(void)
{
    const cell_model_t *m = edit_model();
    if (m == NULL) {
        return 0;
    }
    for (size_t i = 0; i < cell_model_count(); i++) {
        if (cell_model_at(i) == m) {
            return (int32_t)i + 1;
        }
    }
    return 0;
}

/*
 * The value a setting shows and edits from.
 *
 * Overrides start from the effective value, not from 0: an operator turning
 * "Chg V" should start at the 4.200 V the slot will actually use.
 */
static int32_t setting_value(set_item_t item)
{
    const slot_config_t *c = &s_ui.edit_cfg;
    cell_resolved_profile_t p;
    const bool ok = (test_engine_resolve((uint8_t)s_ui.slot, c, &p) == ESP_OK);
    /* If the profile does not resolve, show what is stored rather than a
     * row of zeros that would read as real settings. */
#define EFFECTIVE(field, override, scale) \
    (int32_t)lroundf((ok ? p.field : (override)) * (scale))

    switch (item) {
    case SET_CHEM:     return (int32_t)c->chemistry;
    case SET_MODEL:    return model_index();
    case SET_CAPACITY: return EFFECTIVE(capacity_mah, c->capacity_mah, 1.0f);
    case SET_CHG_V:    return EFFECTIVE(charge_v_max, c->charge_v_max, 1000.0f);
    case SET_DIS_V:    return EFFECTIVE(discharge_v_min, c->discharge_v_min, 1000.0f);
    case SET_CHG_I:    return EFFECTIVE(charge_current_a, c->charge_current_a, 1000.0f);
    case SET_DIS_I:    return EFFECTIVE(discharge_current_a, c->discharge_current_a, 1000.0f);
    case SET_TERM_I:   return EFFECTIVE(charge_term_current_a, c->charge_term_current_a, 1000.0f);
    case SET_TEMP_MAX: return EFFECTIVE(temp_max_c, c->temp_max_c, 10.0f);
#undef EFFECTIVE
    case SET_TIME_MAX: return (int32_t)c->max_duration_minutes;
    case SET_RECHARGE: return c->auto_recharge_to_shipping ? 1 : 0;
    case SET_SHIP_PCT: return (int32_t)lroundf(c->shipping_pct);
    default:           return 0;
    }
}

static void setting_store(set_item_t item, int32_t v)
{
    slot_config_t *c = &s_ui.edit_cfg;
    switch (item) {
    case SET_CHEM:
        if ((cell_chemistry_t)v != c->chemistry) {
            /*
             * A model-backed config has capacity 0 - the model supplies it.
             * Dropping the model below would leave nothing, and the profile
             * would not resolve, so keep the capacity that was in force.
             */
            const int32_t kept_mah = setting_value(SET_CAPACITY);
            c->capacity_mah = (float)((kept_mah > 0) ? kept_mah : 3000);
            c->chemistry = (cell_chemistry_t)v;
            /*
             * A model belongs to one chemistry, and every voltage and
             * current override was chosen for the old one. Keeping them
             * would let a 4.2 V charge target follow the slot onto an LFP
             * cell, so they all go.
             */
            c->model_name[0] = '\0';
            c->charge_v_max = c->discharge_v_min = 0.0f;
            c->charge_current_a = c->discharge_current_a = 0.0f;
            c->charge_term_current_a = 0.0f;
            c->temp_max_c = 0.0f;
        }
        break;
    case SET_MODEL: {
        const cell_model_t *m = (v > 0) ? cell_model_at((size_t)(v - 1)) : NULL;
        const char *name = m ? m->name : "";
        if (strcmp(name, c->model_name) != 0) {
            /*
             * A model brings its own capacity; going back to no model keeps
             * the one in force, since a bare chemistry has none and would
             * not resolve at all.
             */
            const int32_t kept_mah = setting_value(SET_CAPACITY);
            snprintf(c->model_name, sizeof(c->model_name), "%s", name);
            if (m != NULL) {
                c->chemistry = m->chemistry;
            }
            /* Same reasoning as a chemistry change for the overrides. */
            c->capacity_mah = (m != NULL) ? 0.0f
                              : (float)((kept_mah > 0) ? kept_mah : 3000);
            c->charge_v_max = c->discharge_v_min = 0.0f;
            c->charge_current_a = c->discharge_current_a = 0.0f;
            c->charge_term_current_a = 0.0f;
            c->temp_max_c = 0.0f;
        }
        break;
    }
    case SET_CAPACITY:  c->capacity_mah = (float)v; break;
    /*
     * The cutoff has to stay below the CV target, or the profile will not
     * resolve and the slot cannot be saved. Hold a 100 mV window rather than
     * let the operator dial into a state that only fails at Save. 0 is let
     * through untouched: it means "no override", not 0 V.
     */
    case SET_CHG_V: {
        const int32_t floor_mv = setting_value(SET_DIS_V) + 100;
        c->charge_v_max = (float)((v == 0 || v > floor_mv) ? v : floor_mv) / 1000.0f;
        break;
    }
    case SET_DIS_V: {
        const int32_t ceil_mv = setting_value(SET_CHG_V) - 100;
        c->discharge_v_min = (float)((v == 0 || v < ceil_mv) ? v : ceil_mv) / 1000.0f;
        break;
    }
    case SET_CHG_I:     c->charge_current_a = (float)v / 1000.0f; break;
    case SET_DIS_I:     c->discharge_current_a = (float)v / 1000.0f; break;
    case SET_TERM_I:    c->charge_term_current_a = (float)v / 1000.0f; break;
    case SET_TEMP_MAX:  c->temp_max_c = (float)v / 10.0f; break;
    case SET_TIME_MAX:  c->max_duration_minutes = (uint32_t)v; break;
    case SET_RECHARGE:  c->auto_recharge_to_shipping = (v != 0); break;
    case SET_SHIP_PCT:  c->shipping_pct = (float)v; break;
    default: break;
    }
    s_ui.edit_dirty = true;
}

static int32_t setting_max(set_item_t item)
{
    if (item == SET_MODEL) {
        return (int32_t)cell_model_count();
    }
    /*
     * In a group the leader's currents are the GROUP TOTAL: 10 A per enabled
     * member, so a group of 4 dials up to 40 A and a group of 8 up to 80 A.
     * Voltages are not scaled - parallel slots share one voltage.
     */
    if (item == SET_CHG_I || item == SET_DIS_I || item == SET_TERM_I) {
        const bts_unit_status_t u = ui_unit();
        return k_set_defs[item].max * (int32_t)bts_group_members(&u, (uint8_t)s_ui.slot);
    }
    return k_set_defs[item].max;
}

/* Text for a setting's value, in the units the operator thinks in. */
static void setting_text(set_item_t item, int32_t v, char *buf, size_t len)
{
    const set_def_t *d = &k_set_defs[item];
    switch (item) {
    case SET_CHEM:
        snprintf(buf, len, "%s", cell_chemistry_name((cell_chemistry_t)v));
        return;
    case SET_MODEL: {
        const cell_model_t *m = (v > 0) ? cell_model_at((size_t)(v - 1)) : NULL;
        snprintf(buf, len, "%s", m ? m->name : "none");
        return;
    }
    case SET_RECHARGE:
        snprintf(buf, len, "%s", v ? "on" : "off");
        return;
    case SET_TIME_MAX:
        if (v == 0) {
            snprintf(buf, len, "auto");
            return;
        }
        break;
    default:
        break;
    }
    if (d->decimals == 0) {
        snprintf(buf, len, "%ld%s", (long)v, d->unit);
    } else {
        int scale = 1;
        for (int i = 0; i < d->decimals; i++) {
            scale *= 10;
        }
        snprintf(buf, len, "%ld.%0*ld%s", (long)(v / scale), d->decimals,
                 (long)labs(v % scale), d->unit);
    }
}

/*
 * The step for one detent at a given turning speed.
 *
 * Slow and deliberate turns move the last digit, which is 1 mV or 1 mA for
 * voltages and currents. Turning faster moves tens, hundreds, then
 * thousands, so crossing 4 V takes a spin rather than four thousand clicks.
 * The thresholds are in detents per second, measured by input.c.
 */
static int32_t accel_step(set_item_t item, float rate_dps)
{
    if (item == SET_CHEM || item == SET_MODEL || item == SET_RECHARGE) {
        return 1;
    }
    int32_t step;
    if (rate_dps < 6.0f) {
        step = 1;
    } else if (rate_dps < 14.0f) {
        step = 10;
    } else if (rate_dps < 28.0f) {
        step = 100;
    } else {
        step = 1000;
    }
    /*
     * Fields with little range do not need the top gears: a step is never
     * more than an eighth of the range. So currents and capacity reach
     * 1000 mA / 1000 mAh per detent, voltages top out at 100 mV - the whole
     * range is only 5 V - and percentages at 10.
     */
    const int32_t span = setting_max(item) - k_set_defs[item].min;
    while (step > 1 && step * 8 > span) {
        step /= 10;
    }
    return step;
}

/* ------------------------------------------------------------------ */
/* Actions                                                            */
/* ------------------------------------------------------------------ */

static void report(esp_err_t err, const char *ok_text)
{
    if (err == ESP_OK) {
        set_note(ok_text, C_GREEN);
        return;
    }
    switch (err) {
    case ESP_ERR_NOT_ALLOWED:
        set_note("Tripped/paused", C_RED);
        break;
    case ESP_ERR_INVALID_STATE:
        set_note("Busy or not set", C_RED);
        break;
    case ESP_ERR_INVALID_ARG:
        set_note("Bad settings", C_RED);
        break;
    default:
        set_note("Link failed", C_RED);
        break;
    }
}

static void apply_run(int slot, run_item_t run)
{
    slot_status_t st;
    test_engine_get_status((uint8_t)slot, &st);

    if (run != RUN_IDLE && slot_is_faulted(&st)) {
        set_note("Clear fault 1st", C_RED);
        return;
    }

    switch (run) {
    case RUN_IDLE:
        /*
         * Stop whatever is running, whoever started it. abort() stops the
         * channel on the unit and ends an engine test; on a slot the engine
         * is not running it is just the stop.
         */
        report(test_engine_abort((uint8_t)slot), "Stopped");
        break;
    case RUN_AUTO:
        report(test_engine_start((uint8_t)slot), "Auto-test on");
        break;
    case RUN_DISCHARGE:
    case RUN_CHARGE:
        report(test_engine_run_direct((uint8_t)slot, run == RUN_CHARGE),
               run == RUN_CHARGE ? "Charging" : "Discharging");
        break;
    default:
        break;
    }
}

static void clear_fault(int slot)
{
    /*
     * fault_seen is NOT reset here. The status this pass reads still shows
     * the latch - the clear has not reached the unit yet - so resetting it
     * would reopen the dialog at once. check_faults() resets it when the
     * slot actually reads healthy, which is what arms it for the next fault.
     */
    report(test_engine_clear_fault((uint8_t)slot), "Fault cleared");
}

static void open_settings(int slot)
{
    slot_status_t st;
    test_engine_get_status((uint8_t)slot, &st);
    s_ui.edit_cfg = st.config;
    /*
     * Nothing is saved until something is edited. Opening Settings on a
     * fresh slot and backing out must not configure it as the NMC default
     * below - that would get past the "configure first" refusal that
     * stops Charge and Auto-test running on a slot nobody has set up - and
     * a status read that timed out (it returns zeros) must not be written
     * back over the real configuration.
     */
    s_ui.edit_dirty = false;
    if (!st.configured) {
        /*
         * A fresh slot has no configuration at all. Start it from something
         * that resolves, so every field has a real value to edit from:
         * NMC at 3000 mAh is the common 18650 on this bench.
         */
        memset(&s_ui.edit_cfg, 0, sizeof(s_ui.edit_cfg));
        s_ui.edit_cfg.chemistry    = CELL_CHEM_NMC;
        s_ui.edit_cfg.capacity_mah = 3000.0f;
        s_ui.edit_cfg.shipping_pct = 60.0f;
    }
    if (s_ui.edit_cfg.shipping_pct <= 0.0f) {
        s_ui.edit_cfg.shipping_pct = 60.0f;
    }
    s_ui.view   = VIEW_SETTINGS;
    s_ui.cursor = 0;
}

static void save_settings(int slot)
{
    if (!s_ui.edit_dirty) {
        return;
    }
    /*
     * The serial is not edited here, and a barcode may have been scanned
     * over HTTP or BLE while the menu was open. Take the live one rather
     * than writing the snapshot's back over it.
     */
    slot_status_t now;
    test_engine_get_status((uint8_t)slot, &now);
    memcpy(s_ui.edit_cfg.serial, now.config.serial, sizeof(s_ui.edit_cfg.serial));
    esp_err_t err = test_engine_configure((uint8_t)slot, &s_ui.edit_cfg);
    report(err, "Settings saved");
    if (err == ESP_OK) {
        s_ui.edit_dirty = false;
    }
}

/* ------------------------------------------------------------------ */
/* Input handling                                                     */
/* ------------------------------------------------------------------ */

static int view_count(const slot_status_t *st)
{
    menu_item_t items[8];
    switch (s_ui.view) {
    case VIEW_MENU:     return menu_items(st, items);
    case VIEW_RUN:      return RUN_COUNT;
    case VIEW_SETTINGS: return SET_COUNT;
    default:            return SLOT_COUNT;
    }
}

static void go_back(void)
{
    switch (s_ui.view) {
    case VIEW_EDIT:
        s_ui.view = VIEW_SETTINGS;
        s_ui.cursor = s_ui.edit_item;
        break;
    case VIEW_SETTINGS:
        save_settings(s_ui.slot);
        s_ui.view = VIEW_MENU;
        s_ui.cursor = 1;
        break;
    case VIEW_RUN:
        s_ui.view = VIEW_MENU;
        s_ui.cursor = 0;
        break;
    case VIEW_MENU:
    default:
        s_ui.view = VIEW_SLOTS;
        s_ui.cursor = s_ui.slot;
        break;
    }
}

static void on_rotate(int32_t delta, float rate_dps)
{
    if (s_ui.fault_open) {
        /* Two buttons: any turn moves to the other one. */
        s_ui.fault_cursor = (delta > 0) ? 1 : 0;
        return;
    }

    if (s_ui.view == VIEW_EDIT) {
        const set_item_t item = (set_item_t)s_ui.edit_item;
        int32_t v = s_ui.edit_value + delta * accel_step(item, rate_dps);
        const int32_t lo = k_set_defs[item].min;
        const int32_t hi = setting_max(item);
        if (item == SET_CHEM || item == SET_MODEL) {
            /* Lists wrap; numbers clamp. */
            const int32_t n = hi - lo + 1;
            v = lo + (((v - lo) % n) + n) % n;
        } else {
            v = (v < lo) ? lo : (v > hi) ? hi : v;
        }
        s_ui.edit_value = v;
        return;
    }

    if (s_ui.view == VIEW_SLOTS) {
        /*
         * In a group only the leader is a slot you can pick: the followers
         * have no control loop and the unit ignores commands sent to them.
         * So the cursor moves a whole group per detent.
         */
        const bts_unit_status_t u = ui_unit();
        const int gs = bts_group_size(&u);
        int c = s_ui.cursor - (s_ui.cursor % gs) + delta * gs;
        c = (c < 0) ? 0 : (c > SLOT_COUNT - gs) ? SLOT_COUNT - gs : c;
        s_ui.cursor = c;
        s_ui.slot   = c;
        return;
    }

    slot_status_t st;
    test_engine_get_status((uint8_t)s_ui.slot, &st);
    const int n = view_count(&st);
    int c = s_ui.cursor + delta;
    /* Clamp rather than wrap: an operator scrolling to the end of a short
     * list should stop there, not jump to the other end. */
    c = (c < 0) ? 0 : (c >= n) ? n - 1 : c;
    s_ui.cursor = c;
    if (s_ui.view == VIEW_SLOTS) {
        s_ui.slot = c;
    }
}

static void on_press(void)
{
    if (s_ui.fault_open) {
        if (s_ui.fault_cursor == 0) {
            clear_fault(s_ui.fault_slot);
        } else {
            set_note("Fault ignored", C_ORANGE);
        }
        s_ui.fault_open = false;
        return;
    }

    slot_status_t st;
    test_engine_get_status((uint8_t)s_ui.slot, &st);

    switch (s_ui.view) {
    case VIEW_SLOTS:
        s_ui.slot   = s_ui.cursor;
        s_ui.view   = VIEW_MENU;
        s_ui.cursor = 0;
        break;

    case VIEW_MENU: {
        menu_item_t items[8];
        const int n = menu_items(&st, items);
        const menu_item_t item = items[(s_ui.cursor < n) ? s_ui.cursor : n - 1];
        switch (item) {
        case MENU_RUN:
            /*
             * A latched slot cannot run, so Run mode is not offered until the
             * operator has seen why and cleared it: the fault dialog opens in
             * its place, with Clear selected.
             */
            if (slot_is_faulted(&st)) {
                s_ui.fault_seen[s_ui.slot] = true;
                s_ui.fault_open   = true;
                s_ui.fault_slot   = s_ui.slot;
                s_ui.fault_cursor = 0;
                break;
            }
            s_ui.view   = VIEW_RUN;
            s_ui.cursor = current_run(&st);
            break;
        case MENU_SETTINGS:
            open_settings(s_ui.slot);
            break;
        case MENU_CLEAR:
            clear_fault(s_ui.slot);
            s_ui.cursor = 0;
            break;
        case MENU_RESUME:
            report(test_engine_resume((uint8_t)s_ui.slot), "Resumed");
            s_ui.cursor = 0;
            break;
        case MENU_PAUSE:
            report(test_engine_pause((uint8_t)s_ui.slot), "Paused");
            s_ui.cursor = 0;
            break;
        case MENU_BACK:
        default:
            go_back();
            break;
        }
        break;
    }

    case VIEW_RUN:
        if (s_ui.cursor == RUN_BACK) {
            go_back();
        } else {
            apply_run(s_ui.slot, (run_item_t)s_ui.cursor);
            s_ui.view   = VIEW_MENU;
            s_ui.cursor = 0;
        }
        break;

    case VIEW_SETTINGS:
        if (s_ui.cursor == SET_BACK) {
            go_back();
        } else if (s_ui.cursor == SET_SHIP_PCT && !s_ui.edit_cfg.auto_recharge_to_shipping) {
            set_note("Rechg is off", C_ORANGE);
        } else {
            s_ui.edit_item  = s_ui.cursor;
            s_ui.edit_value = setting_value((set_item_t)s_ui.cursor);
            s_ui.view       = VIEW_EDIT;
        }
        break;

    case VIEW_EDIT:
        /*
         * Only if it changed. The editor starts from the effective value,
         * so storing an untouched one would quietly turn a default into a
         * fixed override - one that then stops following capacity or
         * chemistry changes.
         */
        if (s_ui.edit_value != setting_value((set_item_t)s_ui.edit_item)) {
            setting_store((set_item_t)s_ui.edit_item, s_ui.edit_value);
        }
        go_back();
        break;
    }
}

/*
 * Opens the fault dialog for the first newly faulted slot.
 *
 * The slot the menu is open on comes first, so a fault that lands while an
 * operator is working on that slot is the one they see.
 */
static void check_faults(void)
{
    if (s_ui.fault_open) {
        return;
    }
    const bts_unit_status_t u = ui_unit();
    for (int i = 0; i < SLOT_COUNT; i++) {
        const int slot = (s_ui.slot + i) % SLOT_COUNT;
        /* A group faults as one, on its leader, which already carries every
         * member's trips - a dialog per follower would be noise. */
        if (bts_slot_is_follower(&u, (uint8_t)slot)) {
            s_ui.fault_seen[slot] = false;
            continue;
        }
        slot_status_t st;
        test_engine_get_status((uint8_t)slot, &st);
        const bool faulted = slot_is_faulted(&st);
        if (!faulted) {
            s_ui.fault_seen[slot] = false;
            continue;
        }
        if (s_ui.fault_seen[slot]) {
            continue;
        }
        s_ui.fault_seen[slot] = true;
        s_ui.fault_open   = true;
        s_ui.fault_slot   = slot;
        s_ui.fault_cursor = 0;
        ESP_LOGW(TAG, "slot %d fault shown: %s", slot + 1, fault_text(&st));
        return;
    }
}

/* ------------------------------------------------------------------ */
/* Screens                                                            */
/* ------------------------------------------------------------------ */

static void draw_header(const bts_snapshot_t *snap)
{
    band_clear(C_HEADER_BG);

    if (snap->unit.online) {
        band_text(4, 4, 0, "BTS LINK OK", C_GREEN, 1);
        char vin[20];
        snprintf(vin, sizeof(vin), "Vin %.2f", (double)snap->unit.input_voltage_v);
        band_text(84, 4, 0, vin, C_GREY, 1);
        const int gs = bts_group_size(&snap->unit);
        if (gs > 1) {
            char grp[16];
            snprintf(grp, sizeof(grp), "GROUPS OF %d", gs);
            band_text(156, 4, 0, grp, C_CYAN, 1);
        }
    } else {
        band_text(4, 4, 0, "WAITING FOR BTS", C_RED, 1);
    }

#if DISPLAY_INPUT_HUD
    /*
     * Live encoder pins and the raw PCNT count. A and B idle at 1; turning
     * the shaft should make them flicker and n move; a press takes S to 0 and
     * KEY0 takes K to 0. If the levels move and n does not, the pads work and
     * PCNT is not decoding them; if the levels never move, it is the wiring.
     */
    {
        int a, b, sw, k, n;
        input_debug_state(&a, &b, &sw, &k, &n);
        char hud[28];
        snprintf(hud, sizeof(hud), "A%d B%d S%d K%d n%d", a, b, sw, k, n);
        band_text(150, 4, 0, hud, C_YELLOW, 1);
    }
#endif
    draw_wifi_icon(284, 2, 0, web_api_sta_connected());
    draw_ble_icon(304, 2, 0, s_ble_connected);

    push_band_h(0, HEADER_H);
}

/*
 * The menu pane occupies x 210..319 and the same rows as the slot table,
 * one menu line per slot row. Drawn inside each slot-row band, so the
 * table and the pane repaint together with no extra pass.
 */
static void draw_pane_line(int line, int y, int band_y, const slot_status_t *sel)
{
    band_fill_rect(PANE_X - 2, y, s_cfg.width - PANE_X + 2, ROW_H, band_y, C_PANE_BG);
    band_fill_rect(PANE_X - 2, y, 1, ROW_H, band_y, C_DIM);

    const int ty = y + (ROW_H - FONT_H) / 2;
    const char *text = NULL;
    uint16_t colour = C_WHITE;
    bool cursor = false;
    bool marked = false;
    char buf[28];

    switch (s_ui.view) {
    case VIEW_SLOTS:
        /* The pane is a hint until a slot is picked. */
        if (line == 0) {
            snprintf(buf, sizeof(buf), "SLOT %d", s_ui.slot + 1);
            band_text(PANE_TEXT_X, ty - 3, band_y, buf, C_CYAN, 2);
        } else if (line == 2) {
            text = "Turn: slot";
            colour = C_GREY;
        } else if (line == 3) {
            text = "Press: menu";
            colour = C_GREY;
        }
        break;

    case VIEW_MENU: {
        menu_item_t items[8];
        const int n = menu_items(sel, items);
        if (line == 0) {
            snprintf(buf, sizeof(buf), "SLOT %d MENU", s_ui.slot + 1);
            text = buf;
            colour = C_CYAN;
        } else if (line - 1 < n) {
            text = menu_label(items[line - 1]);
            cursor = (s_ui.cursor == line - 1);
            if (items[line - 1] == MENU_CLEAR) {
                colour = C_RED;
            }
        }
        break;
    }

    case VIEW_RUN:
        if (line == 0) {
            snprintf(buf, sizeof(buf), "SLOT %d RUN", s_ui.slot + 1);
            text = buf;
            colour = C_CYAN;
        } else if (line - 1 < RUN_COUNT) {
            text = k_run_labels[line - 1];
            cursor = (s_ui.cursor == line - 1);
            marked = (line - 1 == (int)current_run(sel));
        }
        break;

    case VIEW_SETTINGS:
    case VIEW_EDIT: {
        /*
         * Seven settings fit under the title, so the list scrolls with the
         * cursor and keeps it in view.
         */
        const int visible = 7;
        const int sel_item = (s_ui.view == VIEW_EDIT) ? s_ui.edit_item : s_ui.cursor;
        int first = sel_item - visible / 2;
        if (first > SET_COUNT - visible) {
            first = SET_COUNT - visible;
        }
        if (first < 0) {
            first = 0;
        }
        if (line == 0) {
            snprintf(buf, sizeof(buf), "SLOT %d SET%s", s_ui.slot + 1,
                     s_ui.edit_dirty ? " *" : "");
            text = buf;
            colour = C_CYAN;
            break;
        }
        const int item = first + line - 1;
        if (item >= SET_COUNT) {
            break;
        }
        cursor = (item == sel_item);
        const bool editing = (s_ui.view == VIEW_EDIT && item == s_ui.edit_item);
        if (cursor) {
            band_fill_rect(PANE_X, y + 2, s_cfg.width - PANE_X, ROW_H - 4, band_y,
                           editing ? C_EDIT_BG : C_CURSOR_BG);
        }
        band_text(PANE_TEXT_X, ty, band_y, k_set_defs[item].label,
                  item == SET_BACK ? C_GREEN : C_WHITE, 1);
        if (item != SET_BACK) {
            char v[20];
            const int32_t value = editing ? s_ui.edit_value
                                          : setting_value((set_item_t)item);
            setting_text((set_item_t)item, value, v, sizeof(v));
            const bool greyed = (item == SET_SHIP_PCT &&
                                 !s_ui.edit_cfg.auto_recharge_to_shipping);
            band_text_right(s_cfg.width - 3, ty, band_y, v,
                            editing ? C_YELLOW : greyed ? C_DIM : C_GREY, 1);
        }
        return;
    }
    }

    if (cursor) {
        band_fill_rect(PANE_X, y + 2, s_cfg.width - PANE_X, ROW_H - 4, band_y,
                       C_CURSOR_BG);
        band_text(PANE_TEXT_X, ty, band_y, ">", C_YELLOW, 1);
    }
    if (text != NULL) {
        band_text(PANE_TEXT_X + 8, ty, band_y, text, colour, 1);
    }
    if (marked) {
        band_tick(s_cfg.width - 12, ty - 1, band_y, C_GREEN);
    }
}

static void draw_titles(void)
{
    const int band_y = TITLES_Y;
    band_clear(C_BLACK);
    const int ty = band_y + 2;
    band_text(COL_SLOT_X, ty, band_y, "# MODE", C_GREY, 1);
    band_text_right(COL_V_R, ty, band_y, "ADS V", C_GREY, 1);
    band_text_right(COL_A_R, ty, band_y, "ADS A", C_GREY, 1);
    band_text_right(COL_MAH_R, ty, band_y, "mAh", C_GREY, 1);
    band_text_right(COL_TEMP_R, ty, band_y, "C/m", C_GREY, 1);

    /* The note line borrows the pane's title strip while it is live. */
    band_fill_rect(PANE_X - 2, band_y, s_cfg.width - PANE_X + 2, TITLES_H,
                   band_y, C_PANE_BG);
    if (esp_timer_get_time() < s_ui.note_until_us) {
        band_text(PANE_TEXT_X, ty, band_y, s_ui.note, s_ui.note_colour, 1);
    }
    band_fill_rect(0, band_y + TITLES_H - 1, TABLE_W, 1, band_y, C_DIM);
    /* Only the 12 px title strip; the rest of this band is the first row,
     * which a full-height push would blank. */
    push_band_h(band_y, TITLES_H);
}

static void draw_dialog_part(int band_y);

static void draw_slot_row(uint8_t slot, const slot_status_t *sel)
{
    const int y = ROWS_TOP + slot * ROW_H;

    slot_status_t st;
    test_engine_get_status(slot, &st);

    const bool selected = ((int)slot == s_ui.slot);
    band_clear(C_BLACK);
    if (selected) {
        band_fill_rect(0, y, TABLE_W, ROW_H, y, C_SELECT_BG);
    }

    const int y_small_top = y + 3;              /* upper small line */
    const int y_small_bot = y + 15;             /* lower small line */
    const int y_big       = y + (ROW_H - FONT_H * 2) / 2;

    /*
     * A GROUP is shown once, on its leader's row, with the whole group's
     * current (and the voltage the members share). A follower's row only
     * says which group it belongs to: its own share of the current is not a
     * figure anyone should be reading, and showing it would invite adding
     * the rows up by eye.
     */
    const bts_unit_status_t u = ui_unit();
    const int gs = bts_group_size(&u);
    if (gs > 1 && bts_slot_is_follower(&u, slot)) {
        char num[4];
        snprintf(num, sizeof(num), "%u", (unsigned)(slot + 1));
        band_text(COL_SLOT_X, y_small_top, y, num, C_DIM, 1);
        const unsigned leader = bts_group_leader(&u, slot);
        char line[24];
        snprintf(line, sizeof(line), "part of group %u-%u",
                 leader + 1, (unsigned)(leader + gs));
        band_text(COL_MODE_X + 12, y + (ROW_H - FONT_H) / 2, y, line, C_DIM, 1);
        band_fill_rect(0, y + ROW_H - 1, TABLE_W, 1, y, C_RULE);
        draw_pane_line(slot, y, y, sel);
        draw_dialog_part(y);
        push_band(y);
        return;
    }

    /* Slot number, 1-based for the operator, with a caret when picked. In
     * a group the leader's row stands for the group, marked with its size. */
    char num[4];
    snprintf(num, sizeof(num), "%u", (unsigned)(slot + 1));
    band_text(COL_SLOT_X, y_small_top, y, num, selected ? C_YELLOW : C_WHITE, 1);
    if (selected) {
        band_text(COL_SLOT_X, y_small_bot, y, ">", C_YELLOW, 1);
    }
    if (gs > 1) {
        char g[8];
        snprintf(g, sizeof(g), "x%u", (unsigned)bts_group_members(&u, slot));
        band_text(COL_MODE_X + 18, y_small_bot, y, g, C_CYAN, 1);
    }

    /* Mode badge, small. */
    uint16_t mc;
    const char *mode = mode_code(&st, &mc);
    band_text(COL_MODE_X, y_small_top, y, mode, mc, 1);

    /* CC/CV under the mode: which half of the CCCV law is regulating. */
    if (st.bts_const_voltage || st.bts_const_current) {
        band_text(COL_MODE_X, y_small_bot, y, st.bts_const_voltage ? "CV" : "CC",
                  st.bts_const_voltage ? C_CYAN : C_GREY, 1);
    }

    const bool disabled = (st.status_bits & BTS_STATUS_SLOT_DISABLED) != 0;
    const uint16_t big = disabled ? C_DIM : C_WHITE;

    char v[16];
    /* The ADS131M08, not the 12-bit internal ADC: it is what the BTS
     * regulates against and integrates. */
    fmt_value(v, sizeof(v), st.sense_voltage_v, 3);
    band_text_right(COL_V_R, y_big, y, v, big, 2);

    /* One decimal from 10 A and none from 100 A, so the figure stays five
     * characters wide and cannot run into the volts - a group of eight
     * reaches 80 A. */
    const float ia = fabsf(st.sense_current_a);
    fmt_value(v, sizeof(v), st.sense_current_a, ia >= 99.95f ? 0 : ia >= 9.995f ? 1 : 2);
    band_text_right(COL_A_R, y_big, y, v, big, 2);

    /* The right-hand stack: mAh over mWh, deg C over minutes. */
    float mah, mwh;
    uint32_t mins;
    slot_figures(&st, &mah, &mwh, &mins);

    char a[12], b[12];
    fmt_value(a, sizeof(a), mah, 0);
    fmt_value(b, sizeof(b), mwh, 0);
    band_text_right(COL_MAH_R, y_small_top, y, a, C_GREY, 1);
    band_text_right(COL_MAH_R, y_small_bot, y, b, C_DIM, 1);

    if (st.temp_c > 0.0f) {
        snprintf(a, sizeof(a), "%.1f", (double)st.temp_c);
    } else {
        snprintf(a, sizeof(a), "--");
    }
    snprintf(b, sizeof(b), "%lu", (unsigned long)mins);
    band_text_right(COL_TEMP_R, y_small_top, y, a,
                    (st.temp_c >= st.profile.temp_max_c && st.profile.temp_max_c > 0.0f)
                        ? C_RED : C_GREY, 1);
    band_text_right(COL_TEMP_R, y_small_bot, y, b, C_DIM, 1);

    band_fill_rect(0, y + ROW_H - 1, TABLE_W, 1, y, C_RULE);

    draw_pane_line(slot, y, y, sel);
    /* The fault dialog sits over the rows it crosses, so it is drawn into
     * this band last, before the push. */
    draw_dialog_part(y);
    push_band(y);
}

/*
 * The fault dialog: a box over the middle of the screen, drawn into the
 * bands it crosses after the table has been drawn into them. It never needs
 * its own pass, so it costs nothing beyond the rows it covers.
 */
#define DLG_X   40
#define DLG_W   240
#define DLG_Y   (ROWS_TOP + ROW_H * 2)
#define DLG_H   (ROW_H * 4)

static void draw_dialog_part(int band_y)
{
    if (!s_ui.fault_open) {
        return;
    }
    if (band_y + UI_BAND_H <= DLG_Y || band_y >= DLG_Y + DLG_H) {
        return;
    }

    slot_status_t st;
    test_engine_get_status((uint8_t)s_ui.fault_slot, &st);

    band_fill_rect(DLG_X, DLG_Y, DLG_W, DLG_H, band_y, C_DARK_RED);
    /* Two-pixel border. */
    band_fill_rect(DLG_X, DLG_Y, DLG_W, 2, band_y, C_RED);
    band_fill_rect(DLG_X, DLG_Y + DLG_H - 2, DLG_W, 2, band_y, C_RED);
    band_fill_rect(DLG_X, DLG_Y, 2, DLG_H, band_y, C_RED);
    band_fill_rect(DLG_X + DLG_W - 2, DLG_Y, 2, DLG_H, band_y, C_RED);

    const int cx = DLG_X + DLG_W / 2;
    char title[24];
    snprintf(title, sizeof(title), "SLOT %d FAULT", s_ui.fault_slot + 1);
    band_text_centre(cx, DLG_Y + 8, band_y, title, C_WHITE, 2);
    band_text_centre(cx, DLG_Y + 34, band_y, fault_text(&st), C_YELLOW, 2);
    band_text_centre(cx, DLG_Y + 56, band_y, "Slot cannot run until cleared",
                     C_GREY, 1);

    /* The two buttons. */
    const char *labels[2] = { "CLEAR", "IGNORE" };
    for (int i = 0; i < 2; i++) {
        const int bx = DLG_X + 24 + i * 108;
        const int by = DLG_Y + DLG_H - 30;
        const bool on = (s_ui.fault_cursor == i);
        band_fill_rect(bx, by, 84, 22, band_y, on ? C_WHITE : C_DARK_RED);
        band_fill_rect(bx, by, 84, 1, band_y, C_GREY);
        band_fill_rect(bx, by + 21, 84, 1, band_y, C_GREY);
        band_text_centre(bx + 42, by + 4, band_y, labels[i],
                         on ? C_BLACK : C_GREY, 2);
    }
}

/*
 * Calibration screen.
 *
 * Shows only the slot under calibration: both measurement paths side by
 * side in engineering units and in the raw per-unit the two-point maths
 * actually consumes, so an operator adjusting a bench supply can see the pu
 * land inside its window rather than inferring it from the volts.
 */
#define CAL_COL_ADS_R   200
#define CAL_COL_F28_R   290
#define CAL_TICK_X      298

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

    /*
     * Every element is at a fixed screen y and is drawn into every band;
     * band_char() skips a glyph wholly outside the band and clips one that
     * straddles two, so each lands in whichever band contains it.
     */
    for (int band_y = HEADER_H; band_y < s_cfg.height; band_y += UI_BAND_H) {
        band_clear(C_BLACK);

        band_fill_rect(0, HEADER_H, s_cfg.width, 24, band_y, C_HEADER_BG);
        band_text(8, HEADER_H + 8, band_y, "CALIBRATION", C_YELLOW, 1);
        band_text_right(s_cfg.width - 8, HEADER_H + 8, band_y, title, C_WHITE, 1);

        band_text_right(CAL_COL_ADS_R, 50, band_y, "ADS131", C_GREY, 1);
        band_text_right(CAL_COL_F28_R, 50, band_y, "F28 ADC", C_GREY, 1);
        band_fill_rect(0, 61, s_cfg.width, 1, band_y, C_DIM);

        band_text(8, 70, band_y, "V", C_WHITE, 2);
        band_text_right(CAL_COL_ADS_R, 70, band_y, v_ads, C_WHITE, 2);
        band_text_right(CAL_COL_F28_R, 70, band_y, v_f28, C_WHITE, 2);
        if (cal->v_tick) {
            band_tick(CAL_TICK_X, 73, band_y, C_GREEN);
        }
        band_text(8, 92, band_y, "pu", C_GREY, 1);
        band_text_right(CAL_COL_ADS_R, 92, band_y, vpu_ads, C_GREY, 1);
        band_text_right(CAL_COL_F28_R, 92, band_y, vpu_f28, C_GREY, 1);

        band_text(8, 112, band_y, "A", C_WHITE, 2);
        band_text_right(CAL_COL_ADS_R, 112, band_y, a_ads, C_WHITE, 2);
        band_text_right(CAL_COL_F28_R, 112, band_y, a_f28, C_WHITE, 2);
        if (cal->i_tick) {
            band_tick(CAL_TICK_X, 115, band_y, C_GREEN);
        }
        band_text(8, 134, band_y, "pu", C_GREY, 1);
        band_text_right(CAL_COL_ADS_R, 134, band_y, apu_ads, C_GREY, 1);
        band_text_right(CAL_COL_F28_R, 134, band_y, apu_f28, C_GREY, 1);

        band_text(8, 156, band_y, "T", C_WHITE, 2);
        band_text_right(CAL_COL_ADS_R, 156, band_y, temp, C_CYAN, 2);

        /* Which capture points are held, so the operator knows what
         * COMPUTE_SAVE would have to work with. */
        static const struct {
            const char *label;
            uint32_t    bit;
            int         x;
        } points[] = {
            { "LO", BTS_CAL_ST_V_LOW,     8 },
            { "HI", BTS_CAL_ST_V_HIGH,   84 },
            { "I0", BTS_CAL_ST_I_ZERO,  160 },
            { "IL", BTS_CAL_ST_I_LOADED, 236 },
        };
        band_fill_rect(0, 184, s_cfg.width, 1, band_y, C_DIM);
        for (size_t i = 0; i < sizeof(points) / sizeof(points[0]); i++) {
            const bool held = (cal->status_bits & points[i].bit) != 0;
            band_text(points[i].x, 192, band_y, points[i].label,
                      held ? C_GREEN : C_DIM, 1);
            band_text(points[i].x + 18, 192, band_y, held ? "set" : "---",
                      held ? C_GREEN : C_DIM, 1);
        }

        /* The last refusal, which is otherwise only visible over the API -
         * and the bench operator is the one who has to act on it. */
        if (cal->result != BTS_CAL_ERR_OK) {
            band_text(8, 214, band_y, bts_link_cal_result_name(cal->result),
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
 */
static void draw_waiting_screen(const bts_snapshot_t *snap)
{
    char line[40];
    snprintf(line, sizeof(line), "%u failed polls",
             (unsigned)snap->unit.consecutive_errors);

    for (int band_y = HEADER_H; band_y < s_cfg.height; band_y += UI_BAND_H) {
        band_clear(C_BLACK);
        band_text_centre(s_cfg.width / 2, 90, band_y, "WAITING FOR BTS", C_YELLOW, 2);
        band_text_centre(s_cfg.width / 2, 124, band_y, "I2C 0x50 no reply", C_GREY, 1);
        band_text_centre(s_cfg.width / 2, 144, band_y, line, C_DIM, 1);
        band_text_centre(s_cfg.width / 2, 172, band_y, "SDA 21  SCL 22", C_DIM, 1);
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
 * problem is below the UI - run the bring-up test cycle (DISPLAY_TEST_CYCLE
 * in display.h) to find the SPI mode and clock that work.
 *
 * It also proves the rotation: "DISPLAY OK" must read left to right along
 * the long edge. Upside down means rotation 3 instead of 1; back to front
 * means the module needs `mirror`.
 */
#if DISPLAY_TEST_CYCLE
static char s_test_label[48];
#endif

static void draw_self_test(void)
{
    static const uint16_t bars[] = {
        C_RED, C_GREEN, C_BLUE, C_YELLOW, C_CYAN, C_WHITE,
    };
    const int n = (int)(sizeof(bars) / sizeof(bars[0]));
    const int bar_w = s_cfg.width / n;
    char line[48];
    snprintf(line, sizeof(line), "SPI mode %d  %lu kHz  %dx%d  rot %d",
             s_cfg.spi_mode, (unsigned long)(s_cfg.pclk_hz / 1000),
             s_cfg.width, s_cfg.height, s_cfg.rotation);

    for (int band_y = 0; band_y < s_cfg.height; band_y += UI_BAND_H) {
        band_clear(C_BLACK);

        /* Top half: colour bars. Bottom half: text at both scales. */
        if (band_y < s_cfg.height / 2) {
            for (int i = 0; i < n; i++) {
                band_fill_rect(i * bar_w, band_y, bar_w, UI_BAND_H,
                               band_y, bars[i]);
            }
        }
        band_text(10, 140, band_y, "DISPLAY OK", C_WHITE, 3);
        band_text(10, 172, band_y, "abcdefg 0123456789", C_GREEN, 1);
        band_text(10, 192, band_y, line, C_GREY, 1);
#if DISPLAY_TEST_CYCLE
        band_text(10, 212, band_y, s_test_label, C_YELLOW, 1);
#endif
        /* A marker in the top-left corner, so the orientation is never in
         * doubt even with the text unreadable. */
        band_fill_rect(0, 0, 12, 12, band_y, C_WHITE);
        push_band(band_y);
    }
}

/* ------------------------------------------------------------------ */
/* Task                                                               */
/* ------------------------------------------------------------------ */

static void draw_table(void)
{
    draw_titles();

    slot_status_t sel;
    test_engine_get_status((uint8_t)s_ui.slot, &sel);

    for (uint8_t slot = 0; slot < SLOT_COUNT; slot++) {
        draw_slot_row(slot, &sel);
    }
    /* Whatever the rows did not cover below the table. */
    const int bottom = ROWS_TOP + SLOT_COUNT * ROW_H;
    for (int y = bottom; y < s_cfg.height; y += UI_BAND_H) {
        band_clear(C_BLACK);
        push_band(y);
    }
}

#if DISPLAY_TEST_CYCLE
__attribute__((unused))
#endif
static esp_err_t apply_rotation(void);

/*
 * Re-sends the controller's configuration without resetting it, so the
 * picture never flickers. See PANEL_RESYNC_MS for why this exists.
 */
static void panel_resync(void)
{
    flush_wait(0);
    esp_err_t err = esp_lcd_panel_init(s_panel);
    if (err == ESP_OK) {
        err = esp_lcd_panel_invert_color(s_panel, s_cfg.invert_colour);
    }
    if (err == ESP_OK) {
        err = apply_rotation();
    }
    if (err == ESP_OK) {
        err = esp_lcd_panel_disp_on_off(s_panel, true);
    }
    if (s_cfg.backlight_gpio >= 0) {
        gpio_set_level(s_cfg.backlight_gpio, 1);
    }
    if (err != ESP_OK) {
        ESP_LOGW(TAG, "panel re-sync failed: %s", esp_err_to_name(err));
    }
}

static void display_task(void *arg)
{
    (void)arg;

    if (s_cfg.self_test) {
        draw_self_test();
        flush_wait(0);
        vTaskDelay(pdMS_TO_TICKS(4000));
    }

    /*
     * The loop ticks far faster than it repaints.
     *
     * Input has to be serviced within a few tens of milliseconds or the
     * encoder feels dead, and a turn should move the cursor at once, so
     * an input event forces a redraw. Without input the panel repaints on
     * refresh_ms, which is often enough for the numbers.
     */
    int64_t next_refresh_us = 0;
    int64_t next_resync_us  = esp_timer_get_time() + (int64_t)PANEL_RESYNC_MS * 1000;
    s_ui.last_input_us = esp_timer_get_time();

    for (;;) {
        const int64_t now = esp_timer_get_time();
        bool need_redraw = (now >= next_refresh_us);

        /*
         * The menus are hidden behind the waiting and calibration screens,
         * so input there would act blind - a press could start a test on a
         * slot the operator cannot see. Drain it instead.
         */
        bts_snapshot_t gate;
        bts_link_get_snapshot(&gate);
        const bool menus_visible = gate.unit.online &&
                                   !(gate.cal.active && gate.cal.slot < SLOT_COUNT);

        input_event_t ev;
        while (input_wait_event(&ev, 0)) {
            s_ui.last_input_us = esp_timer_get_time();
            /*
             * The e-stop is the one input that must work with the menus
             * hidden: it is exactly what you reach for when something is
             * wrong, and the waiting and calibration screens are not a reason
             * to ignore it.
             */
            if (!menus_visible && ev.type != INPUT_EVENT_KEY0_LONG_PRESS) {
                continue;
            }
            switch (ev.type) {
            case INPUT_EVENT_ROTATE_CW:
                on_rotate(ev.steps, ev.rate_dps);
                break;
            case INPUT_EVENT_ROTATE_CCW:
                on_rotate(-ev.steps, ev.rate_dps);
                break;
            case INPUT_EVENT_PRESS:
                on_press();
                break;
            case INPUT_EVENT_LONG_PRESS:
                /* Long press always backs out one level - or dismisses the
                 * dialog, which is the same as Ignore. */
                if (s_ui.fault_open) {
                    s_ui.fault_open = false;
                    set_note("Fault ignored", C_ORANGE);
                } else {
                    go_back();
                }
                break;
            case INPUT_EVENT_KEY0_LONG_PRESS:
                /*
                 * E-STOP. Hold KEY0 and every slot is stopped: the converter
                 * is switched off on the unit and any test or direct run on
                 * the engine is ended. The short press that began this hold
                 * has already taken the panel back to the slot list, so this
                 * works from any menu.
                 *
                 * It stops everything, not just the selected slot, and it does
                 * not clear faults - a faulted slot stays faulted and visible.
                 */
                {
                    const esp_err_t err = test_engine_abort_all();
                    ESP_LOGW(TAG, "KEY0 long press: E-STOP, all slots stopped (%s)",
                             esp_err_to_name(err));
                    s_ui.view   = VIEW_SLOTS;
                    s_ui.cursor = s_ui.slot;
                    s_ui.fault_open = false;
                    set_note(err == ESP_OK ? "ALL STOPPED" : "STOP FAILED",
                             err == ESP_OK ? C_ORANGE : C_RED);
                }
                break;
            case INPUT_EVENT_KEY0_PRESS:
                /* KEY0 is a quick way home from anywhere in the menus. */
                if (s_ui.view == VIEW_SETTINGS || s_ui.view == VIEW_EDIT) {
                    save_settings(s_ui.slot);
                }
                s_ui.view   = VIEW_SLOTS;
                s_ui.cursor = s_ui.slot;
                break;
            default:
                break;
            }
            need_redraw = true;
        }

        /* An abandoned menu returns to the table rather than covering it. */
        if (s_ui.view != VIEW_SLOTS &&
            (esp_timer_get_time() - s_ui.last_input_us) > (int64_t)MENU_IDLE_MS * 1000) {
            if (s_ui.view == VIEW_SETTINGS || s_ui.view == VIEW_EDIT) {
                /* Unsaved edits are dropped: a timeout is not a decision. */
                s_ui.edit_dirty = false;
            }
            s_ui.view   = VIEW_SLOTS;
            s_ui.cursor = s_ui.slot;
            need_redraw = true;
        }

        if (!need_redraw) {
            vTaskDelay(pdMS_TO_TICKS(UI_TICK_MS));
            continue;
        }
        next_refresh_us = esp_timer_get_time() + (int64_t)s_cfg.refresh_ms * 1000;

        if (esp_timer_get_time() >= next_resync_us) {
            next_resync_us = esp_timer_get_time() + (int64_t)PANEL_RESYNC_MS * 1000;
            panel_resync();
        }

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
        } else if (snap.unit.online) {
            check_faults();
            draw_table();
        } else {
            draw_waiting_screen(&snap);
        }

        vTaskDelay(pdMS_TO_TICKS(UI_TICK_MS));
    }
}

/* ------------------------------------------------------------------ */
/* Init                                                               */
/* ------------------------------------------------------------------ */

/*
 * Applies the rotation through the controller.
 *
 * Quarter turns counter-clockwise from the panel's native portrait. Each is
 * a swap of the axes plus a mirror, which is the only way MADCTL expresses
 * a rotation; the table is the standard one for the ST7789.
 */
static esp_err_t apply_rotation(void)
{
    bool swap = false, mx = false, my = false;
    switch (s_cfg.rotation & 3) {
    case 0: swap = false; mx = false; my = false; break;
    case 1: swap = true;  mx = false; my = true;  break;   /* 90 CCW  */
    case 2: swap = false; mx = true;  my = true;  break;   /* 180     */
    case 3: swap = true;  mx = true;  my = false; break;   /* 90 CW   */
    }
    if (s_cfg.mirror) {
        mx = !mx;
    }
    ESP_RETURN_ON_ERROR(esp_lcd_panel_swap_xy(s_panel, swap), TAG, "swap xy");
    ESP_RETURN_ON_ERROR(esp_lcd_panel_mirror(s_panel, mx, my), TAG, "mirror");
    /*
     * The offset is in panel coordinates, so it swaps with the axes: an
     * offset that pushes a 240x240 window down the long side becomes one
     * along x once the panel is on its side.
     */
    if (swap) {
        return esp_lcd_panel_set_gap(s_panel, s_cfg.y_offset, s_cfg.x_offset);
    }
    return esp_lcd_panel_set_gap(s_panel, s_cfg.x_offset, s_cfg.y_offset);
}

/*
 * Creates the SPI panel device and brings the controller up.
 *
 * Split from display_init() so the bring-up test mode can repeat it with a
 * different SPI mode. The SPI bus itself is initialised once and survives;
 * only the device on it, which is where the mode and clock live, and the
 * panel on top of that are rebuilt.
 */
static esp_err_t panel_bringup(void)
{
    const esp_lcd_panel_io_spi_config_t io_cfg = {
        /*
         * The panel is alone on this bus, but this module has no tie from CS
         * to ground, so the driver asserts it around each transaction. -1
         * remains valid for a module that does tie it low.
         */
        .cs_gpio_num = s_cfg.cs_gpio,
        .dc_gpio_num = s_cfg.dc_gpio,
        .spi_mode = s_cfg.spi_mode,
        .pclk_hz = s_cfg.pclk_hz,
        .trans_queue_depth = 10,
        .on_color_trans_done = on_flush_done,
        .lcd_cmd_bits = LCD_CMD_BITS,
        .lcd_param_bits = LCD_PARAM_BITS,
    };
    ESP_RETURN_ON_ERROR(esp_lcd_new_panel_io_spi((esp_lcd_spi_bus_handle_t)LCD_HOST,
                                                 &io_cfg, &s_io),
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
    ESP_RETURN_ON_ERROR(esp_lcd_new_panel_st7789(s_io, &panel_cfg, &s_panel),
                        TAG, "st7789");

    ESP_RETURN_ON_ERROR(esp_lcd_panel_reset(s_panel), TAG, "reset");
    ESP_RETURN_ON_ERROR(esp_lcd_panel_init(s_panel), TAG, "panel init");
    /* Most IPS ST7789 modules are wired such that the controller's idea of
     * colour polarity is inverted relative to the glass. */
    ESP_RETURN_ON_ERROR(esp_lcd_panel_invert_color(s_panel, s_cfg.invert_colour),
                        TAG, "invert");
    ESP_RETURN_ON_ERROR(apply_rotation(), TAG, "rotation");
    ESP_RETURN_ON_ERROR(esp_lcd_panel_disp_on_off(s_panel, true), TAG, "disp on");
    return ESP_OK;
}

#if DISPLAY_TEST_CYCLE
/* Releases the panel and its SPI device, leaving the bus ready to be reused. */
static void panel_teardown(void)
{
    flush_wait(0);
    s_inflight = 0;
    xQueueReset(s_flush_sem);
    if (s_panel != NULL) {
        esp_lcd_panel_del(s_panel);
        s_panel = NULL;
    }
    if (s_io != NULL) {
        esp_lcd_panel_io_del(s_io);
        s_io = NULL;
    }
}

/*
 * The combinations the test mode steps through. The first four are the four
 * SPI modes at the normal clock; the second four repeat them at a clock slow
 * enough to rule out a marginal wire, which on a write-only bus fails silently.
 */
static const struct {
    int      mode;
    uint32_t hz;
} k_test_cfgs[] = {
    { 0, 10 * 1000 * 1000 }, { 1, 10 * 1000 * 1000 },
    { 2, 10 * 1000 * 1000 }, { 3, 10 * 1000 * 1000 },
    { 0,  2 * 1000 * 1000 }, { 1,  2 * 1000 * 1000 },
    { 2,  2 * 1000 * 1000 }, { 3,  2 * 1000 * 1000 },
};
#define TEST_CFG_COUNT ((int)(sizeof(k_test_cfgs) / sizeof(k_test_cfgs[0])))

static void test_apply(int idx)
{
    panel_teardown();
    s_cfg.spi_mode = k_test_cfgs[idx].mode;
    s_cfg.pclk_hz  = k_test_cfgs[idx].hz;

    snprintf(s_test_label, sizeof(s_test_label), "TEST %d/%d  KEY0 = next",
             idx + 1, TEST_CFG_COUNT);

    /* Backlight on first and unconditionally, so a dark panel cannot be put
     * down to the backlight logic. */
    if (s_cfg.backlight_gpio >= 0) {
        gpio_set_level(s_cfg.backlight_gpio, 1);
    }

    const esp_err_t err = panel_bringup();
    ESP_LOGW(TAG, "TEST %d/%d: SPI mode %d at %lu kHz -> bring-up %s; "
                  "BLK(GPIO%d)=%d RES(GPIO%d)=%d CS(GPIO%d)=%d",
             idx + 1, TEST_CFG_COUNT, s_cfg.spi_mode,
             (unsigned long)(s_cfg.pclk_hz / 1000), esp_err_to_name(err),
             s_cfg.backlight_gpio, gpio_get_level(s_cfg.backlight_gpio),
             s_cfg.reset_gpio, gpio_get_level(s_cfg.reset_gpio),
             s_cfg.cs_gpio, gpio_get_level(s_cfg.cs_gpio));
    if (err != ESP_OK) {
        return;
    }
    draw_self_test();
    flush_wait(0);
}

/*
 * The whole display task in test mode: show the pattern, and on each KEY0
 * press move to the next SPI mode and bring the panel up again.
 */
static void display_test_task(void *arg)
{
    (void)arg;

    /* Start on whatever main.c configured, so the first picture is the
     * normal one. */
    int idx = 0;
    for (int i = 0; i < TEST_CFG_COUNT; i++) {
        if (k_test_cfgs[i].mode == s_cfg.spi_mode && k_test_cfgs[i].hz == s_cfg.pclk_hz) {
            idx = i;
            break;
        }
    }
    snprintf(s_test_label, sizeof(s_test_label), "TEST %d/%d  KEY0 = next",
             idx + 1, TEST_CFG_COUNT);
    ESP_LOGW(TAG, "DISPLAY TEST MODE: KEY0 steps SPI mode/clock; starting at %d/%d",
             idx + 1, TEST_CFG_COUNT);
    draw_self_test();
    flush_wait(0);

    /* KEY0 reads low at boot on this board, which posts a press at start-up.
     * Let it pass and drain it, so the first press the operator makes is the
     * first one counted. */
    vTaskDelay(pdMS_TO_TICKS(1500));
    input_event_t ev;
    while (input_wait_event(&ev, 0)) {
    }

    for (;;) {
        if (input_wait_event(&ev, 100) && ev.type == INPUT_EVENT_KEY0_PRESS) {
            idx = (idx + 1) % TEST_CFG_COUNT;
            test_apply(idx);
        }
    }
}
#endif /* DISPLAY_TEST_CYCLE */

esp_err_t display_init(const display_config_t *config)
{
    if (config == NULL) {
        return ESP_ERR_INVALID_ARG;
    }
    s_cfg = *config;
    if (s_cfg.width == 0)      s_cfg.width = 320;
    if (s_cfg.height == 0)     s_cfg.height = 240;
    if (s_cfg.refresh_ms == 0) s_cfg.refresh_ms = 500;
    if (s_cfg.pclk_hz == 0)    s_cfg.pclk_hz = LCD_DEFAULT_CLOCK_HZ;
    if (s_cfg.spi_mode < 0 || s_cfg.spi_mode > 3) {
        s_cfg.spi_mode = 0;
    }

    s_ui.slot  = 0;
    s_ui.view  = VIEW_SLOTS;

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

    s_flush_sem = xSemaphoreCreateCounting(4, 0);
    if (s_flush_sem == NULL) {
        return ESP_ERR_NO_MEM;
    }

    const size_t band_bytes = (size_t)s_cfg.width * UI_BAND_H * sizeof(uint16_t);

    const spi_bus_config_t bus = {
        .mosi_io_num = s_cfg.mosi_gpio,
        .miso_io_num = -1,               /* write-only panel */
        .sclk_io_num = s_cfg.sclk_gpio,
        .quadwp_io_num = -1,
        .quadhd_io_num = -1,
        .max_transfer_sz = (int)band_bytes,
    };
    ESP_RETURN_ON_ERROR(spi_bus_initialize(LCD_HOST, &bus, SPI_DMA_CH_AUTO),
                        TAG, "spi bus");

    /*
     * In test mode a bring-up failure must not leave the backlight off and
     * the board silent: log it, light the backlight, and carry on into the
     * test task, where a KEY0 press retries with another mode.
     */
    const esp_err_t up = panel_bringup();
    if (up != ESP_OK) {
        ESP_LOGE(TAG, "panel bring-up failed: %s", esp_err_to_name(up));
#if DISPLAY_TEST_CYCLE
        if (s_cfg.backlight_gpio >= 0) {
            gpio_set_level(s_cfg.backlight_gpio, 1);
        }
#else
        return up;
#endif
    }

    for (int i = 0; i < 2; i++) {
        s_bufs[i] = heap_caps_malloc(band_bytes, MALLOC_CAP_DMA);
        if (s_bufs[i] == NULL) {
            ESP_LOGE(TAG, "no DMA memory for the %d x %d band buffers",
                     s_cfg.width, UI_BAND_H);
            return ESP_ERR_NO_MEM;
        }
    }
    s_buf_idx = 1;
    s_band = s_bufs[0];

    /* Clear the whole panel before the backlight comes up. */
    for (int y = 0; y < s_cfg.height; y += UI_BAND_H) {
        band_clear(C_BLACK);
        push_band(y);
    }
    flush_wait(0);

    if (s_cfg.backlight_gpio >= 0) {
        gpio_set_level(s_cfg.backlight_gpio, 1);
    }

#if DISPLAY_TEST_CYCLE
    TaskFunction_t entry = display_test_task;
#else
    TaskFunction_t entry = display_task;
#endif
    if (xTaskCreate(entry, "display", TASK_STACK, NULL, TASK_PRIO, NULL)
            != pdPASS) {
        return ESP_ERR_NO_MEM;
    }

    ESP_LOGI(TAG, "ST7789 up: MOSI=%d SCK=%d CS=%d RES=%d DC=%d BLK=%d, %dx%d "
                  "rot %d%s, SPI mode %d at %lu Hz, offset %d,%d, invert %d",
             s_cfg.mosi_gpio, s_cfg.sclk_gpio, s_cfg.cs_gpio, s_cfg.reset_gpio,
             s_cfg.dc_gpio, s_cfg.backlight_gpio, s_cfg.width, s_cfg.height,
             s_cfg.rotation, s_cfg.mirror ? " mirrored" : "",
             s_cfg.spi_mode, (unsigned long)s_cfg.pclk_hz,
             s_cfg.x_offset, s_cfg.y_offset, (int)s_cfg.invert_colour);
    return ESP_OK;
}
