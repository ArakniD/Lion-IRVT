/*
 * at_console.h - AT command interface on the ESP32's UART.
 *
 * Presents the same AT grammar the C2000 serves on its own console, but
 * reaches the registers over I2C instead of directly. Tooling written against
 * the unit's console works unchanged against the proxy.
 *
 * WHY THIS EXISTS
 * ---------------
 * The C2000's console lives on SCIA, and SCIA is contended four ways: the AT
 * console, the WS2812B LED driver, channel 1's GPIO trip on GPIO28, and CPU1's
 * SFRA GUI. A production unit gives SCIA to the LEDs, which leaves no console
 * at all. Putting the same interface on the ESP32 restores it without taking
 * anything back from the unit.
 *
 * IT TAKES THE PORT FROM THE LOG OUTPUT
 * -------------------------------------
 * A UART cannot carry both an AT dialogue and a log stream: ESP_LOG output
 * would interleave with responses and break any parser expecting a clean
 * "+NAME=value\r\nOK\r\n". So starting this console redirects the ESP-IDF log
 * away from UART0. That is deliberate and was specified; logs remain available
 * over the network interfaces.
 */

#ifndef AT_CONSOLE_H
#define AT_CONSOLE_H

#include "esp_err.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Start the AT console on UART0 and silence logging on that port.
 *
 * Creates one task that owns the UART for the lifetime of the firmware.
 * Returns ESP_ERR_INVALID_STATE if already started.
 */
esp_err_t at_console_start(void);

/*
 * Whether the console is running and therefore owns UART0.
 */
bool at_console_is_active(void);

#ifdef __cplusplus
}
#endif

#endif /* AT_CONSOLE_H */
