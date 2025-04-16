/*
 * led_driver.c
 *
 *  Created on: 15 Apr. 2025
 *      Author: lucas
 */


#include "led_driver.h"
#include "device.h"

#ifdef CPU2
// External reference to shared registers
extern volatile float registers[TOTAL_REGISTERS];

// LED buffer (GRB order)
static uint8_t ledBuffer[LED_BUFFER_SIZE];

// UART initialization for WS2812B
void LEDDriver_init(void) {
    // Configure GPIO for SCIA_TX (GPIO_28)
    GPIO_setPinConfig(GPIO_28_SCIA_TX);
    GPIO_setDirectionMode(28, GPIO_DIR_MODE_OUT);

    // UART config: 800 kbps (WS2812B timing), 8-bit, no parity
    SCI_setConfig(SCIA_BASE, DEVICE_LSPCLK_FREQ, 800000, (SCI_CONFIG_WLEN_8 | SCI_CONFIG_STOP_ONE | SCI_CONFIG_PAR_NONE));
    SCI_enableModule(SCIA_BASE);
    SCI_disableInterrupt(SCIA_BASE, SCI_INT_RXRDY_BRKDT | SCI_INT_TXRDY);

    // Initialize timer for LED updates (80 Hz for smooth flashing)
    CPUTimer_setPeriod(CPUTIMER0_BASE, 60000000 / 80); // 80 Hz @ 60 MHz
    CPUTimer_enableInterrupt(CPUTIMER0_BASE);
    Interrupt_register(INT_TIMER0, ledTimerISR);
    Interrupt_enable(INT_TIMER0);
    CPUTimer_startTimer(CPUTIMER0_BASE);

    // Clear LED buffer
    for (uint16_t i = 0; i < LED_BUFFER_SIZE; i++) {
        ledBuffer[i] = 0;
    }
}

// Update LED states based on status registers
void LEDDriver_update(void) {
    for (uint16_t ch = 0; ch < NUM_LEDS; ch++) {
        uint16_t statusReg = eCh0_Status + ch * 40; // Byte address
        uint16_t regIdx = statusReg / 4; // Index into registers[]
        uint32_t status = (uint32_t)registers[regIdx];
        uint8_t* ledData = &ledBuffer[ch * 3]; // GRB order

        // Default: Off
        ledData[0] = 0; // G
        ledData[1] = 0; // R
        ledData[2] = 0; // B

        if (!(status & (1 << 0))) { // Not running (below min voltage assumed)
            ledData[0] = COLOR_RED[0];
            ledData[1] = COLOR_RED[1];
            ledData[2] = COLOR_RED[2];
        } else if (status & (1 << 4)) { // Charging
            static uint32_t toggle = 0;
            toggle = (toggle + 1) % 40; // 2 Hz at 80 Hz update rate
            if (toggle < 20) {
                ledData[0] = COLOR_GREEN[0];
                ledData[1] = COLOR_GREEN[1];
                ledData[2] = COLOR_GREEN[2];
            }
        } else if (status & (1 << 5)) { // Discharging
            static uint32_t strobe = 0;
            strobe = (strobe + 1) % 8; // 10 Hz at 80 Hz update rate
            if (strobe < 4) {
                ledData[0] = COLOR_BLUE[0];
                ledData[1] = COLOR_BLUE[1];
                ledData[2] = COLOR_BLUE[2];
            }
        } else if (status & (1 << 2)) { // Finished
            ledData[0] = COLOR_WHITE[0];
            ledData[1] = COLOR_WHITE[1];
            ledData[2] = COLOR_WHITE[2];
        }
    }

    // Send LED data via UART
    SCI_disableModule(SCIA_BASE);
    for (uint16_t i = 0; i < LED_BUFFER_SIZE; i++) {
        SCI_writeCharBlockingFIFO(SCIA_BASE, ledBuffer[i]);
    }
    SCI_enableModule(SCIA_BASE);

    // WS2812B reset pulse (>50 µs)
    DEVICE_DELAY_US(60);
}

// Timer ISR for periodic LED updates
__interrupt void ledTimerISR(void) {
    LEDDriver_update();
    CPUTimer_clearOverflowFlag(CPUTIMER0_BASE);
}
#endif
