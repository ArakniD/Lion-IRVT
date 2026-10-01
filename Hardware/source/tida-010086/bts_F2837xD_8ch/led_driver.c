/*
 * led_driver.c
 *
 *  Created on: 15 Apr. 2025
 *      Author: lucas
 */


#include "led_driver.h"
#include "device.h"

#ifdef CPU2
#if (BTS_LED_DRIVER_ENABLED == true)

// LED colour tables (GRB order for WS2812B)
static const uint16_t colorRed[3]   = COLOR_RED;
static const uint16_t colorGreen[3] = COLOR_GREEN;
static const uint16_t colorBlue[3]  = COLOR_BLUE;
static const uint16_t colorWhite[3] = COLOR_WHITE;
static const uint16_t colorYellow[3] = COLOR_YELLOW;

// LED buffer (GRB order)
static uint16_t ledBuffer[LED_BUFFER_SIZE];

// UART initialization for WS2812B
void LEDDriver_init(void) {
    //
    // GPIO29 is muxed to SCITXDA by CPU1 in BTS_HAL_setupCpu2Pins(); the mux
    // registers are not writable from CPU2.
    //

    // UART config: 800 kbps (WS2812B timing), 8-bit, no parity
    SCI_setConfig(SCIA_BASE, DEVICE_LSPCLK_FREQ, 800000, (SCI_CONFIG_WLEN_8 | SCI_CONFIG_STOP_ONE | SCI_CONFIG_PAR_NONE));
    SCI_resetChannels(SCIA_BASE);
    SCI_enableFIFO(SCIA_BASE);
    SCI_enableModule(SCIA_BASE);
    SCI_performSoftwareReset(SCIA_BASE);
    SCI_disableInterrupt(SCIA_BASE, SCI_INT_RXRDY_BRKDT | SCI_INT_TXRDY);

    //
    // Timer for LED updates, 80 Hz for smooth flashing.
    //
    // CPU TIMER 2, NOT TIMER 0. Timer 0 is the ADS1119 dwell timebase, and
    // initADS1119() reprograms it to a free-running 0xFFFFFFFF period with
    // the interrupt DISABLED. main() calls initADS1119() after this function,
    // so on Timer 0 the LED tick was silently switched off moments after it
    // was started - the string never updated in a production build.
    //
    // Timer 2 is free ON CPU2 ONLY. It is not free on CPU1: the task
    // scheduler owns it as TASKC_CPUTIMER_BASE, and BTS_HAL_measureSysclkKHz()
    // borrows it to count INTOSC1. CPU2 runs neither.
    //
    CPUTimer_setPeriod(CPUTIMER2_BASE, DEVICE_SYSCLK_FREQ / 80);
    CPUTimer_setPreScaler(CPUTIMER2_BASE, 0);
    CPUTimer_enableInterrupt(CPUTIMER2_BASE);
    Interrupt_register(INT_TIMER2, &ledTimerISR);
    Interrupt_enable(INT_TIMER2);
    CPUTimer_startTimer(CPUTIMER2_BASE);

    // Clear LED buffer
    for (uint16_t i = 0; i < LED_BUFFER_SIZE; i++) {
        ledBuffer[i] = 0;
    }
}

// Update LED states based on status registers
//
// Priority is deliberately safety-first: a fault is shown even though the
// slot is also, necessarily, not running. The previous ordering tested
// "not running" first, which meant a trip looked identical to an idle slot.
//
void LEDDriver_update(void) {
    static uint32_t tick = 0;

    tick++;

    for (uint16_t ch = 0; ch < NUM_LEDS; ch++) {
        // The status register is the first of a slot's 12 runtime registers.
        uint16_t regIdx = BTS_RT_BASE(ch) + BTS_RT_STATUS;
        uint32_t status = (uint32_t)registers[regIdx];
        uint16_t* ledData = &ledBuffer[ch * 3]; // GRB order
        const uint16_t* color = 0;

        if (status & (1UL << BTS_STATUS_SLOT_DISABLED)) {
            // Masked off by the ENABLE strap - never going to run.
            color = colorRed;
        } else if (status & (1UL << BTS_STATUS_OVERCURRENT_TRIP)) {
            color = ((tick % LED_TRIP_PERIOD) < LED_TRIP_ON) ? colorRed : 0;
        } else if (status & (1UL << BTS_STATUS_REVERSE_POLARITY)) {
            color = ((tick % LED_REVERSE_PERIOD) < LED_REVERSE_ON) ? colorRed : 0;
        } else if (status & (1UL << BTS_STATUS_GROUP_DISCONNECT)) {
            color = ((tick % LED_DISCONNECT_PERIOD) < LED_DISCONNECT_ON) ? colorRed : 0;
        } else if (status & (1UL << BTS_STATUS_CALIBRATING)) {
            //
            // Ranked below the fault states on purpose: a slot that trips
            // during calibration must still read as tripped.
            //
            color = ((tick % LED_CAL_PERIOD) < LED_CAL_ON) ? colorWhite : 0;
        } else if (status & (1UL << BTS_STATUS_PAUSED)) {
            //
            // Ranked below the faults and above running, like the
            // calibration flash. A watchdog or restore pause flashes red -
            // the link died or the unit reset - a deliberate one blue.
            //
            const uint16_t* pauseColor =
                (status & ((1UL << BTS_STATUS_WD_TRIPPED) |
                           (1UL << BTS_STATUS_RESTORED))) ? colorRed : colorBlue;
            color = ((tick % LED_PAUSE_PERIOD) < LED_PAUSE_ON) ? pauseColor : 0;
        } else if (status & ((1UL << BTS_STATUS_BALANCING) |
                             (1UL << BTS_STATUS_SOFT_START))) {
            //
            // Driving the rail, or starting into a freshly seated cell.
            // Ranked below every fault - a slot that trips while balancing
            // must still read as tripped - and above the direction states,
            // which it precedes.
            //
            color = ((tick % LED_BALANCE_PERIOD) < LED_BALANCE_ON)
                        ? colorYellow : 0;
        } else if (status & (1UL << BTS_STATUS_READY)) {
            //
            // Rails matched: it is safe to seat a cell. Flashing, because
            // solid green is idle.
            //
            color = ((tick % LED_READY_PERIOD) < LED_READY_ON)
                        ? colorGreen : 0;
        } else if (status & ((1UL << BTS_STATUS_CHARGING) |
                             (1UL << BTS_STATUS_DISCHARGING))) {
            if (status & (1UL << BTS_STATUS_RUNNING)) {
                color = colorBlue;
            } else {
                color = colorGreen;
            }
        } else if (status & (1UL << BTS_STATUS_FINISHED)) {
            color = colorWhite;
        } else {
            // Idle, or simply not under control.
            color = colorGreen;
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
//
// CPU Timer 2 is connected directly to CPU INT14, not through the PIE, so
// there is no acknowledge group to clear - exactly as timerISR() documents
// for Timer 1 on INT13. Calling Interrupt_clearACKGroup() here would be
// acknowledging a group this interrupt never came through.
//
__interrupt void ledTimerISR(void) {
    LEDDriver_update();
    CPUTimer_clearOverflowFlag(CPUTIMER2_BASE);
}

#else  /* BTS_LED_DRIVER_ENABLED == false */

//
// The WS2812B driver bit-bangs on SCIA, which the debug console takes over
// when BTS_DEBUG_CONSOLE is set. Provide no-op stubs so main() does
// not need conditional compilation.
//
void LEDDriver_init(void) { }
void LEDDriver_update(void) { }
__interrupt void ledTimerISR(void) {
    //
    // Never registered in this build, but kept symmetrical with the live
    // version above: Timer 2, and no PIE acknowledge - INT14 is direct.
    //
    CPUTimer_clearOverflowFlag(CPUTIMER2_BASE);
}

#endif /* BTS_LED_DRIVER_ENABLED */
#endif
