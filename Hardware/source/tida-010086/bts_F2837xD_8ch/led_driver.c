/*
 * led_driver.c
 *
 *  Created on: 15 Apr. 2025
 *      Author: lucas
 */


#include "led_driver.h"
#include "device.h"

#ifdef CPU2

// LED colour tables (GRB order for WS2812B)
static const uint16_t colorRed[3]   = COLOR_RED;
static const uint16_t colorGreen[3] = COLOR_GREEN;
static const uint16_t colorBlue[3]  = COLOR_BLUE;
static const uint16_t colorWhite[3] = COLOR_WHITE;

// LED buffer (GRB order)
static uint16_t ledBuffer[LED_BUFFER_SIZE];

// UART initialization for WS2812B
void LEDDriver_init(void) {
    // Configure GPIO for SCIA_TX (GPIO_29)
    GPIO_setPinConfig(GPIO_29_SCITXDA);
    GPIO_setDirectionMode(29, GPIO_DIR_MODE_OUT);

    // UART config: 800 kbps (WS2812B timing), 8-bit, no parity
    SCI_setConfig(SCIA_BASE, DEVICE_LSPCLK_FREQ, 800000, (SCI_CONFIG_WLEN_8 | SCI_CONFIG_STOP_ONE | SCI_CONFIG_PAR_NONE));
    SCI_resetChannels(SCIA_BASE);
    SCI_enableFIFO(SCIA_BASE);
    SCI_enableModule(SCIA_BASE);
    SCI_performSoftwareReset(SCIA_BASE);
    SCI_disableInterrupt(SCIA_BASE, SCI_INT_RXRDY_BRKDT | SCI_INT_TXRDY);

    // Initialize timer for LED updates (80 Hz for smooth flashing)
    CPUTimer_setPeriod(CPUTIMER0_BASE, DEVICE_SYSCLK_FREQ / 80);
    CPUTimer_setPreScaler(CPUTIMER0_BASE, 0);
    CPUTimer_enableInterrupt(CPUTIMER0_BASE);
    Interrupt_register(INT_TIMER0, &ledTimerISR);
    Interrupt_enable(INT_TIMER0);
    CPUTimer_startTimer(CPUTIMER0_BASE);

    // Clear LED buffer
    for (uint16_t i = 0; i < LED_BUFFER_SIZE; i++) {
        ledBuffer[i] = 0;
    }
}

// Update LED states based on status registers
void LEDDriver_update(void) {
    static uint32_t toggle = 0;
    static uint32_t strobe = 0;

    toggle = (toggle + 1) % 40;  // 2 Hz at an 80 Hz update rate
    strobe = (strobe + 1) % 8;   // 10 Hz at an 80 Hz update rate

    for (uint16_t ch = 0; ch < NUM_LEDS; ch++) {
        // Status registers are 10 per channel, not one per LED.
        uint16_t regIdx = BTS_CTRL_BASE(ch) + BTS_REG_IDX(eCh0_Status);
        uint32_t status = (uint32_t)registers[regIdx];
        uint16_t* ledData = &ledBuffer[ch * 3]; // GRB order
        const uint16_t* color = 0;

        if (!(status & (1 << 0))) {            // Not running
            color = colorRed;
        } else if (status & (1 << 4)) {        // Charging - flashing green
            color = (toggle < 20) ? colorGreen : 0;
        } else if (status & (1 << 5)) {        // Discharging - strobing blue
            color = (strobe < 4) ? colorBlue : 0;
        } else if (status & (1 << 2)) {        // Finished
            color = colorWhite;
        }

        if (color) {
            ledData[0] = color[0]; // G
            ledData[1] = color[1]; // R
            ledData[2] = color[2]; // B
        } else {
            ledData[0] = 0;
            ledData[1] = 0;
            ledData[2] = 0;
        }
    }

    // Send LED data via UART
    for (uint16_t i = 0; i < LED_BUFFER_SIZE; i++) {
        SCI_writeCharBlockingFIFO(SCIA_BASE, ledBuffer[i] & 0xFFU);
    }

    // WS2812B reset pulse (>50 us)
    DEVICE_DELAY_US(60);
}

// Timer ISR for periodic LED updates
__interrupt void ledTimerISR(void) {
    LEDDriver_update();
    CPUTimer_clearOverflowFlag(CPUTIMER0_BASE);
    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP1);
}
#endif
