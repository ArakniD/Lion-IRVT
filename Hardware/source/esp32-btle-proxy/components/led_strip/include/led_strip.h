/*
 * led_strip.h
 *
 * WS2812B slot indicators, one LED per BTS slot, driven from the ESP32.
 *
 * WHY THIS LIVES HERE AND NOT ON THE C2000
 * ----------------------------------------
 * It used to be on the C2000, clocking raw colour bytes out of SCIA at
 * 800 kbaud, and it never lit a single pixel. A WS2812B decodes pulse
 * WIDTHS - 400 ns high is a 0, 800 ns high is a 1, in a 1250 ns slot - and a
 * UART cannot produce them: it forces a LOW start bit before every byte and
 * holds each data bit for a whole 1250 ns bit time. The strip saw framing
 * noise and latched nothing.
 *
 * The fix needs a peripheral that can emit a free-running bit pattern, which
 * on the C2000 meant an SPI port - and both of its usable ones are taken by
 * the ADS131M08 pair, with GPIO29 (the wire that is physically there) having
 * no SPI mux option at all. The ESP32 has a spare SPI host and a free pin, so
 * the whole function moves here and reads slot state over the I2C link that
 * was already being polled.
 *
 * WIRING
 * ------
 *   DIN   GPIO25     WS2812B data in, via SPI3 (VSPI) MOSI
 *
 * The chain runs in reverse slot order: LED 1, the first after DIN, shows
 * slot 8, and LED 8 shows slot 1. led_strip.c maps this in one place.
 *
 * GPIO25 is an ordinary output-capable pin with no boot or JTAG role, so
 * nothing on this line can stop the board booting or entering the bootloader.
 *
 * It was GPIO13 until a PCB layout error put the 5V pin out of line. GPIO12
 * was tried next and rejected: it is MTDI, a boot strapping pin that picks the
 * flash voltage, and a level shifter that idles high would stop a 3.3 V module
 * booting. GPIO14 was tried after that and gave no drive on the bench - a
 * scope saw nothing even with the pin driven as a plain GPIO - and GPIO13 was
 * inaccessible. GPIO35 cannot be used at all: it is input-only. GPIO25 was
 * verified by scope, first as a plain 1 Hz GPIO and then as SPI3 MOSI.
 *
 * SPI3 is otherwise unused - the ST7789 panel is on SPI2 (HSPI), despite
 * sitting on the VSPI-default pads.
 *
 * HOW THE BITSTREAM IS BUILT
 * --------------------------
 * Each WS2812B bit becomes four SPI bits at 3.2 MHz (312.5 ns each), giving
 * the part's own 1.25 us bit period:
 *
 *   0  ->  1000     312 ns high, 938 ns low
 *   1  ->  1110     938 ns high, 312 ns low
 *
 * The WS2812B samples DIN roughly 450-600 ns after each rising edge: a line
 * still high then is a 1, already low is a 0. So what has to be right is that
 * a 0 is well SHORT of that point and a 1 well PAST it. 312 ns and 938 ns sit
 * on either side of it with margin, and both are inside the datasheet's
 * T0H 220-380 ns / T1H 580-1000 ns windows (the "V5" WS2812B / WS2813 table).
 *
 * WHY NOT THE 2.5 MHz 1000/1100 THAT WAS HERE BEFORE. It gave T0H = 400 ns
 * and T1H = 800 ns, the figures in the oldest WS2812 datasheet. On these
 * parts, through the level shifter's added rise time, a 400 ns zero was still
 * high at the sample point and read as a ONE - every colour byte decoded as
 * 0xFF, so each LED showed full white or a saturated primary whatever the
 * frame asked for, while the byte order and the LED index were right. The
 * newer parts specify T0H at 220-380 ns precisely because 400 ns is marginal.
 *
 * Two WS2812B bits pack into one SPI byte, so 24 bits of colour become 12
 * bytes and the whole 8-LED frame is 96 bytes in a single DMA transfer, 240 us
 * long. MOSI idles low between transfers, which is what the >280 us reset
 * latch of the newer parts needs - the next frame is 25 ms away.
 */

#ifndef LED_STRIP_H
#define LED_STRIP_H

/*
 * BRING-UP TEST MODE
 * ------------------
 * 0  normal: the strip shows slot state.
 * 1  PIN TOGGLE: SPI is not used at all. The data pin is driven as a plain
 *    GPIO, high 500 ms / low 500 ms, forever. This separates "the firmware or
 *    the pin is wrong" from "the SPI peripheral is not reaching the pad": if a
 *    meter or scope sees 1 Hz on the pin, the pin and the wiring are good and
 *    the fault is in the SPI path. If it does not, the pad is not being
 *    driven - check the pin number, the level shifter, and whether something
 *    else is holding the line.
 * 2  SPI, ALL WHITE at full brightness, repeated every 25 ms. Every bit of
 *    colour is a 1 (1100), so the scope sees a dense burst of 800 ns pulses
 *    rather than the mostly-low frame the amber or off states give.
 *
 * Either mode, and the normal one, log the pad's actual state from the GPIO
 * matrix at start-up: direction, pull, and which peripheral signal drives it.
 */
#ifndef LED_STRIP_TEST_MODE
#define LED_STRIP_TEST_MODE 0
#endif

#include <stdbool.h>
#include <stdint.h>
#include "esp_err.h"

#ifdef __cplusplus
extern "C" {
#endif

/* One indicator per slot. */
#define LED_STRIP_COUNT     8

/*
 * Hard brightness ceiling, 26/255 (10%).
 *
 * These are indicators, not lighting. A WS2812B draws about 20 mA per colour
 * channel, so about 60 mA at full white and about 480 mA for all eight;
 * capping the scale at 10% holds the whole strip to roughly 50 mA even if
 * every pixel went white at once. That matters on this board: an OTA update
 * browned the ESP32 out on the backup cell, so the 5V rail has little to
 * spare. The cap is in the driver, not the caller, so no configuration can
 * exceed it: led_strip_init() clamps `brightness` to this and says so in the
 * log.
 */
#define LED_STRIP_MAX_BRIGHTNESS    26

typedef struct {
    int      data_gpio;     /* WS2812B DIN */
    uint16_t refresh_ms;    /* frame interval; sets the flash timebase */
    uint8_t  brightness;    /* 0-LED_STRIP_MAX_BRIGHTNESS, scales every channel linearly */
} led_strip_config_t;

/*
 * Claims SPI3 and starts the refresh task. The task polls
 * bts_link_get_snapshot() and derives each LED's colour from the slot's
 * decoded status, so there is nothing to feed it.
 *
 * Not fatal to the application if it fails: a tester with dark indicators
 * still works over BLE, HTTP and the AT console.
 */
esp_err_t led_strip_init(const led_strip_config_t *config);

/*
 * Blanks every LED and holds them off until led_strip_resume().
 *
 * Exists for the bench: the indicators are the only output that cannot be
 * silenced by closing a browser tab.
 */
void led_strip_blank(void);
void led_strip_resume(void);

#ifdef __cplusplus
}
#endif

#endif /* LED_STRIP_H */
