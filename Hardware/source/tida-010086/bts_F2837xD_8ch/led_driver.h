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

// Function prototypes
void LEDDriver_init(void);
void LEDDriver_update(void);
__interrupt void ledTimerISR(void);

#endif // LED_DRIVER_H
