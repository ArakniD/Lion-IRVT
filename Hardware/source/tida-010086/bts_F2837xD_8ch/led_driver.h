/*
 * led_driver.h
 *
 *  Created on: 15 Apr. 2025
 *      Author: lucas
 */

#ifndef LED_DRIVER_H
#define LED_DRIVER_H

#include "registers.h"
#include "driverlib.h"

// LED configuration
#define NUM_LEDS 8                  // One LED per channel
#define BITS_PER_LED 24             // 24-bit RGB (8 bits per color)
#define LED_BUFFER_SIZE (NUM_LEDS * BITS_PER_LED / 8) // 24 bytes

// LED color definitions (GRB order for WS2812B)
#define COLOR_RED   {0, 255, 0}     // Fault, or a slot the straps disabled
#define COLOR_GREEN {255, 0, 0}     // Idle / not under control
#define COLOR_BLUE  {0, 0, 255}     // Charging or discharging
#define COLOR_WHITE {255, 255, 255} // Test complete
//
// GRB order, like every table here - not RGB. Yellow is red plus green, which
// happens to read the same either way, but anything else written as RGB would
// be silently wrong.
//
#define COLOR_YELLOW {255, 255, 0}  // Balancing / soft start

//
// Flash timing, in 12.5 ms ticks of the 80 Hz update.
//
// Each pattern is a period and the portion of it the LED is lit, so a
// duty other than half is expressible - the trip pattern is deliberately
// long-on/short-off to read differently from the faster faults.
//
#define LED_TICK_HZ             80U

#define LED_TRIP_PERIOD        200U   // 2500 ms
#define LED_TRIP_ON            160U   // 2000 ms on, 500 ms off

#define LED_REVERSE_PERIOD      20U   // 250 ms
#define LED_REVERSE_ON          10U

#define LED_DISCONNECT_PERIOD   40U   // 500 ms
#define LED_DISCONNECT_ON       20U

#define LED_CAL_PERIOD          24U   // 300 ms
#define LED_CAL_ON              12U

// Slower than the fault flashes: a pause is a held state, not an alarm.
#define LED_PAUSE_PERIOD        80U   // 1000 ms
#define LED_PAUSE_ON            40U

//
// Pre-charge balance. Yellow while the rail is being driven or the converter
// is soft starting; green flashing at 500 ms once the rail matches and a cell
// can be seated.
//
// READY flashes rather than sitting solid because solid green is already
// "idle" - the final fallback in LEDDriver_update() - and an operator must be
// able to tell a slot that is ready to accept a cell from one that is simply
// doing nothing.
//
#define LED_BALANCE_PERIOD      24U   // 300 ms
#define LED_BALANCE_ON          12U

#define LED_READY_PERIOD        40U   // 500 ms
#define LED_READY_ON            20U

// Function prototypes
void LEDDriver_init(void);

//
// Rebuilds the pixel buffer and clocks it out over SCIA.
//
// MUST NOT be called from an interrupt. It blocks on the SCI TX FIFO and then
// busy-waits ~60 us for the WS2812B reset pulse - roughly 360 us in total at
// 800 kbaud for 24 bytes. Call it from the idle loop; LEDDriver_due() says
// when.
//
void LEDDriver_update(void);

//
// True once per refresh interval, consumed by the caller.
//
// The timer ISR only sets a flag now. Doing the transfer in the ISR blocked
// every other interrupt on CPU2 for its whole duration, including the I2C
// target ISR that serves the ESP32 at several kHz - see the note in
// led_driver.c.
//
bool LEDDriver_due(void);
__interrupt void ledTimerISR(void);

#endif // LED_DRIVER_H
