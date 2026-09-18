/*
 * display.h
 *
 * ST7789 status display.
 *
 * WIRING
 * ------
 * SPI2 (HSPI) in its hardware-default pin arrangement, so the SPI peripheral
 * drives the pads directly through the IO_MUX rather than the GPIO matrix:
 *
 *   MOSI  GPIO23      hardware VSPID
 *   SCK   GPIO18      hardware VSPICLK
 *   RES   GPIO17
 *   DC    GPIO16
 *   BLK   GPIO4       backlight, active high
 *   CS    not used    the panel is the only device on this bus
 *
 * GPIO21/22 stay with the BTS I2C link and GPIO1/3 with the console UART;
 * none of the display pins collide with either.
 *
 * MEMORY
 * ------
 * A full 240x240 RGB565 framebuffer is 115 kB, against roughly 89 kB of
 * free heap once NimBLE and WiFi are up. So the UI renders one horizontal
 * band at a time into a small scratch buffer and pushes each band as it is
 * finished. UI_BAND_H sets the band height; the buffer is
 * 240 * UI_BAND_H * 2 bytes.
 *
 * The display task owns the panel entirely - nothing else touches it - and
 * pulls its data from test_engine_get_status() and bts_link_get_snapshot(),
 * so it is a pure consumer and cannot stall the control loop.
 */

#ifndef DISPLAY_H
#define DISPLAY_H

#include <stdbool.h>
#include "esp_err.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    int mosi_gpio;
    int sclk_gpio;
    int reset_gpio;
    int dc_gpio;
    int backlight_gpio;
    int width;
    int height;
    /*
     * Many 240x240 ST7789 boards map the visible area partway into the
     * controller's 240x320 memory. These shift the drawn window to suit;
     * 0/0 is correct for the common 1.3" module.
     */
    int x_offset;
    int y_offset;
    bool invert_colour;     /* most IPS ST7789 panels need this true */
    /*
     * Set when red and blue come out transposed - some modules wire the
     * panel's colour filter in BGR order. This is a hue swap only; text
     * appearing purple with dim greys is a byte-order problem instead, and
     * is handled by data_endian in display.c.
     */
    bool bgr_order;
    /*
     * SPI mode 0 (CPOL=0, CPHA=0) is what the ST7789 datasheet specifies and
     * what most modules want. Some breakout boards latch on the opposite
     * clock edge and need mode 2 (CPOL=1, CPHA=0); a mismatch shows as a
     * blank or speckled panel rather than an error, because the bus is
     * write-only and nothing can report the failure.
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
