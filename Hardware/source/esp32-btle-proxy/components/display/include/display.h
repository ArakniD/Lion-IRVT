/*
 * display.h
 *
 * ST7789 status display.
 *
 * Landscape, 320x240, driven from the rotary encoder: a slot table, a menu
 * pane and a fault dialog. display.c describes the screens.
 *
 * WIRING
 * ------
 * SPI2 (HSPI) in its hardware-default pin arrangement, so the SPI peripheral
 * drives the pads directly through the IO_MUX rather than the GPIO matrix:
 *
 *   MOSI  GPIO23      hardware VSPID
 *   SCK   GPIO18      hardware VSPICLK
 *   CS    GPIO19      active low, external 10k pull-up to 3V3
 *   RES   GPIO17
 *   DC    GPIO16
 *   BLK   GPIO4       backlight, active high
 *
 * The module has no tie from CS to ground, so CS is driven. The pull-up holds
 * the panel deselected from reset until display_init() takes the pin.
 *
 * GPIO21/22 stay with the BTS I2C link and GPIO1/3 with the console UART;
 * none of the display pins collide with either.
 *
 * MEMORY
 * ------
 * A full 320x240 RGB565 framebuffer is 150 kB, against roughly 89 kB of
 * free heap once NimBLE and WiFi are up. So the UI renders one horizontal
 * band at a time into a small scratch buffer and pushes each band as it is
 * finished. UI_BAND_H sets the band height; the buffer is
 * width * UI_BAND_H * 2 bytes, and two of them alternate so the next band is
 * drawn while the last is still on the bus.
 *
 * ORIENTATION
 * -----------
 * `width` and `height` are the LOGICAL size, after rotation. The panel is a
 * 240x320 portrait part mounted on its side, so the UI asks for 320x240 and
 * `rotation` turns it: the controller's MADCTL swaps and mirrors the axes,
 * so everything above this driver - every coordinate in display.c - is plain
 * landscape and never sees the rotation.
 *
 * The display task owns the panel entirely - nothing else touches it - and
 * pulls its data from test_engine_get_status() and bts_link_get_snapshot(),
 * so it is a pure consumer and cannot stall the control loop.
 */

#ifndef DISPLAY_H
#define DISPLAY_H

/*
 * BRING-UP TEST MODE
 * ------------------
 * With this set to 1 the display runs ONLY the boot test pattern, and every
 * press of KEY0 tears the panel down and brings it up again on the next SPI
 * mode / clock combination: modes 0..3 at 10 MHz, then 0..3 at 2 MHz. The
 * pattern shows which combination is active, and the log prints each step, so
 * "which one lights the panel" is a read-off. The backlight is forced on the
 * moment the test starts, so a dark panel means the panel, not the backlight
 * logic. Set to 0 for the normal UI.
 *
 * Nothing else is reachable from the encoder while this is on.
 */
#ifndef DISPLAY_TEST_CYCLE
#define DISPLAY_TEST_CYCLE 0
#endif

/*
 * Draws the encoder's live pin levels and raw count in the header, e.g.
 * "A1 B1 S1 K1 n0". For bring-up of the encoder and its wiring; set to 0 for
 * the finished unit.
 */
#ifndef DISPLAY_INPUT_HUD
#define DISPLAY_INPUT_HUD 0
#endif

#include <stdbool.h>
#include "esp_err.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    int mosi_gpio;
    int sclk_gpio;
    int cs_gpio;            /* -1 if CS is tied low on the module */
    int reset_gpio;
    int dc_gpio;
    int backlight_gpio;
    int width;
    int height;
    /*
     * Where the visible area sits in the controller's 240x320 memory, in
     * PANEL coordinates (before rotation). 0/0 for a full 240x320 module;
     * 240x240 boards often need an offset here.
     */
    int x_offset;
    int y_offset;
    /*
     * Rotation applied by the controller, as quarter turns counter-clockwise
     * from the panel's native portrait orientation: 0, 1 (90 CCW), 2 or 3.
     * With 1 or 3, `width`/`height` must already be the swapped, landscape
     * size. If the picture comes out upside down, use 3 instead of 1; if it
     * is mirrored, the module wires its scan direction the other way and
     * `mirror` corrects it.
     */
    int rotation;
    bool mirror;
    /*
     * Many IPS ST7789 modules need this true, but not all: the 320x240 panel
     * needs false. The symptom of the wrong value is a photographic negative -
     * black background shown as white, every colour replaced by its
     * complement (yellow reads blue, red reads cyan) - and nothing else is
     * wrong, so it is the first thing to flip when the picture is there but
     * the colours are not.
     */
    bool invert_colour;
    /*
     * Set when red and blue come out transposed - some modules wire the
     * panel's colour filter in BGR order. This is a hue swap only; text
     * appearing purple with dim greys is a byte-order problem instead, and
     * is handled by data_endian in display.c.
     */
    bool bgr_order;
    /*
     * SPI mode 0 (CPOL=0, CPHA=0) is what the ST7789 datasheet specifies and
     * what this panel wants. The controller samples on the rising clock edge,
     * so mode 3 (CPOL=1, CPHA=1) works too; modes 1 and 2 sample on the wrong
     * edge and do not. A mismatch shows as a blank or speckled panel rather
     * than an error, because the bus is write-only and nothing can report the
     * failure - DISPLAY_TEST_CYCLE above finds the right one by trying all.
     */
    int spi_mode;           /* 0..3, default 0 */
    uint32_t pclk_hz;       /* 0 => 10 MHz */
    /*
     * Draws colour bars and a text sample for a few seconds at boot. With a
     * write-only bus this is the only way to tell "the panel is not being
     * driven" from "the UI is drawing nothing" - if the bars appear, the SPI
     * link, mode and clock are all correct.
     */
    bool self_test;
    uint32_t refresh_ms;
} display_config_t;

/* Brings up the panel and starts the UI task. */
esp_err_t display_init(const display_config_t *config);

/* Mirrored into the header row; the display cannot see the BLE stack. */
void display_set_ble_connected(bool connected);

#ifdef __cplusplus
}
#endif

#endif /* DISPLAY_H */
