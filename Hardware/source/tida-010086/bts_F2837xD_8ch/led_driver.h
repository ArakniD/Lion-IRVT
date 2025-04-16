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
#define COLOR_RED   {0, 255, 0}    // Solid Red for below min voltage
#define COLOR_GREEN {255, 0, 0}    // Flashing Green for charging
#define COLOR_BLUE  {0, 0, 255}    // Strobing Blue for discharging
#define COLOR_WHITE {255, 255, 255} // Solid White for complete

// Function prototypes
void LEDDriver_init(void);
void LEDDriver_update(void);

#endif // LED_DRIVER_H
