//#############################################################################
//
// FILE:  buck_hal.c
//
// TITLE: Solution hardware abstraction layer
//        Low level functions and resources with hardware dependencies
//        Example: Functions to read current and voltage signals
//        Example: Functions to configure device peripherals
//
//#############################################################################
// $TI Release:
// $Release Date:
// $Copyright:
// Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
//
// ALL RIGHTS RESERVED
// $
//#############################################################################

#include <bts_hal.h>

//
//=============================================================================
// variables
//=============================================================================
//

adc_data  BTS_ADC1;
adc_data  BTS_ADC2;
//
// Non-zero if the SYSPLL never locked. Set just before the unit halts, so a
// debugger attaching to a dead board can tell a clock failure from a hang.
//
volatile uint16_t BTS_pllLockFailed = 0U;

//
// PLL state captured by CPU1 itself immediately after SysCtl_setClock().
//
// The CLKCFG block cannot be read reliably over JTAG on this part - it
// returns 0x0000 whether the core is halted or running, and a single
// non-reproducible 0x0010 misled this investigation twice. Latching the
// values into ordinary RAM from CPU1's own code sidesteps that entirely.
//
volatile uint16_t BTS_pllMultAfter   = 0xFFFFU;  // SYSPLLMULT
volatile uint16_t BTS_pllStsAfter    = 0xFFFFU;  // SYSPLLSTS  (bit0 = LOCKS)
volatile uint16_t BTS_pllCtl1After   = 0xFFFFU;  // SYSPLLCTL1 (PLLEN/PLLCLKEN)
volatile uint16_t BTS_clkSrcAfter    = 0xFFFFU;  // CLKSRCCTL1
volatile uint16_t BTS_sysDivAfter    = 0xFFFFU;  // SYSCLKDIVSEL
volatile uint16_t BTS_lospcpAfter    = 0xFFFFU;  // LOSPCP  -> LSPCLK divider
volatile uint16_t BTS_perDivAfter    = 0xFFFFU;  // PERCLKDIVSEL -> EPWMCLKDIV
volatile uint16_t BTS_tmr2ClkAfter   = 0xFFFFU;  // TMR2CLKCTL -> Timer2 source

//
// Missing Clock Detect (MCD) state, and a measured - not assumed - SYSCLK.
//
// MCD watches OSCCLK. If the selected oscillator stops or glitches, the
// hardware switches SYSCLK to INTOSC1 (~10 MHz) on its own and latches
// MCDCR.MCLKSTS. That failover does NOT rewrite SYSPLLMULT, SYSPLLSTS or
// SYSPLLCTL1 - they keep reading the values they were programmed with. That
// is exactly why every register read in this investigation looked perfect
// while the board behaved as if it were running at 10 MHz.
//
// MCLKSTS is sticky: only MCLKCLR or a power-on reset clears it. And
// SysCtl_setClock() begins with
//     if(SysCtl_isMCDClockFailureDetected()) { status = false; }
// i.e. if the flag is already latched it returns false having touched no PLL
// register at all - and device.c discards that return value. So a single
// oscillator glitch can leave the device on INTOSC1 across every subsequent
// warm reset, silently.
//
volatile uint16_t BTS_mcdBefore      = 0xFFFFU;  // MCDCR as found at entry
volatile uint16_t BTS_mcdAfter       = 0xFFFFU;  // MCDCR after clock setup
volatile uint16_t BTS_mcdLive        = 0xFFFFU;  // MCDCR sampled in task C3
volatile uint16_t BTS_mcdTrips       = 0U;       // runtime MCLKSTS assertions
volatile uint16_t BTS_setClockOk     = 0xFFFFU;  // SysCtl_setClock() return

//
// SYSCLK measured against INTOSC1 rather than inferred from CLKCFG. Timer1
// counts SYSCLK while Timer2 counts INTOSC1 for a fixed window, so the ratio
// is ground truth taken by the core itself - no JTAG, no debugger, no GEL.
//
volatile uint32_t BTS_sysclkTicks    = 0U;       // SYSCLK cycles per window
volatile uint32_t BTS_sysclkKHz      = 0U;       // derived SYSCLK in kHz

volatile uint16_t BTS_ExAdcRxflag1 ;
volatile uint16_t BTS_ExAdcRxflag2 ;

#if(BUCK_DRV_EPWM_HR_ENABLED == true)
    volatile uint32_t ePWM[9] =
                        {0, EPWM1_BASE, EPWM2_BASE, EPWM3_BASE, EPWM4_BASE,
                            EPWM5_BASE, EPWM6_BASE, EPWM7_BASE, EPWM8_BASE};
#endif

#if(BTS_DRV_EPWM_HR_ENABLED == true)
    volatile uint32_t ePWM[9] =
                        {0, EPWM1_BASE, EPWM2_BASE, EPWM3_BASE, EPWM4_BASE,
                            EPWM5_BASE, EPWM6_BASE, EPWM7_BASE, EPWM8_BASE};
#endif


//
// BTS_HAL_setupDevice - Initialize device after boot and configure system
// resources (such as PLL) and moving ramfuncs from FLASH to RAM
//

//
//=============================================================================
// PLL start-up
//=============================================================================
//
// The F2837xD has a documented erratum where the SYSPLL intermittently fails
// to lock after a power cycle, leaving the device running from the raw
// oscillator. Driverlib's SysCtl_setClock() already re-locks five times with
// an `RPT #60 || NOP` settle between attempts, but that has proven too short
// on this board: the device was measured running at ~10 MHz (INTOSC2) instead
// of the configured 200 MHz - exactly 1/20, i.e. the PLL multiplier never
// applied. Symptoms were a 16x-slow task chain and an AT console that only
// answered at ~7267 baud instead of 115200.
//
// BTS_HAL_pllSettle() gives the PLL a far longer settle window, and
// BTS_HAL_pllIsLocked() checks the outcome rather than assuming it.
//
// WHY THIS MUST BE FATAL
//
// Every timing in this unit derives from SYSCLK: the ePWM switching period
// and dead time, the control-loop rate, the ADC trigger, the over-current
// trip response and the host watchdog. Running a bidirectional converter
// into a lithium cell with a 20x timing error is not a degraded mode, it is
// a hazard - the dead time alone would be 20x short. So a failure to lock
// stops the unit before any PWM is configured rather than continuing.
//
#define BTS_PLL_SETTLE_REPEATS   256U
#define BTS_PLL_LOCK_ATTEMPTS    10U

//
// Long settle delay for the PLL, replacing driverlib's `RPT #60 || NOP`.
// RPT takes an 8-bit count, so 256 repeats is issued as four blocks of 64.
//
static void BTS_HAL_pllSettle(void)
{
    uint16_t i;
    for (i = 0U; i < (BTS_PLL_SETTLE_REPEATS / 64U); i++) {
        asm(" RPT #63 || NOP");
    }
}

static inline bool BTS_HAL_pllIsLocked(void)
{
    return ((HWREGH(CLKCFG_BASE + SYSCTL_O_SYSPLLSTS) &
             SYSCTL_SYSPLLSTS_LOCKS) != 0U);
}

//
// True if the missing-clock detector has latched a failure.
//
static inline bool BTS_HAL_mcdTripped(void)
{
    return ((HWREGH(CLKCFG_BASE + SYSCTL_O_MCDCR) &
             SYSCTL_MCDCR_MCLKSTS) != 0U);
}

//
// Measure SYSCLK against INTOSC1 and return the result in kHz.
//
// Timer1 counts SYSCLK, Timer2 counts INTOSC1 (a fixed ~10 MHz that MCD
// itself falls back to, so it is present in every failure mode). Run both
// for a window bounded by Timer2, then scale.
//
// This is the only SYSCLK figure in the firmware that is measured rather
// than asserted. Both timers are saved and restored, so it is safe to call
// during bring-up and again later from a background task.
//
#define BTS_CLKMEAS_INTOSC1_HZ   10000000UL
#define BTS_CLKMEAS_WINDOW       0x4000UL     // INTOSC1 cycles per window

static uint32_t BTS_HAL_measureSysclkKHz(void)
{
    uint16_t t1TCR, t1TPR, t1TPRH, t2TCR, t2TPR, t2TPRH, t2CLKCTL;
    uint32_t t1PRD, t2PRD, elapsed;

    //
    // Back up both timers - the task scheduler owns them.
    //
    t1TCR = HWREGH(CPUTIMER1_BASE + CPUTIMER_O_TCR);
    t1PRD = HWREG(CPUTIMER1_BASE + CPUTIMER_O_PRD);
    t1TPR = HWREGH(CPUTIMER1_BASE + CPUTIMER_O_TPR);
    t1TPRH = HWREGH(CPUTIMER1_BASE + CPUTIMER_O_TPRH);
    t2CLKCTL = HWREGH(CPUSYS_BASE + SYSCTL_O_TMR2CLKCTL);
    t2TCR = HWREGH(CPUTIMER2_BASE + CPUTIMER_O_TCR);
    t2PRD = HWREG(CPUTIMER2_BASE + CPUTIMER_O_PRD);
    t2TPR = HWREGH(CPUTIMER2_BASE + CPUTIMER_O_TPR);
    t2TPRH = HWREGH(CPUTIMER2_BASE + CPUTIMER_O_TPRH);

    EALLOW;

    //
    // Timer1 free-runs on SYSCLK from a known top.
    //
    HWREGH(CPUTIMER1_BASE + CPUTIMER_O_TCR) |= CPUTIMER_TCR_TSS;
    HWREG(CPUTIMER1_BASE + CPUTIMER_O_PRD) = 0xFFFFFFFFUL;
    HWREG(CPUTIMER1_BASE + CPUTIMER_O_TPR) = 0U;
    HWREGH(CPUTIMER1_BASE + CPUTIMER_O_TCR) |= CPUTIMER_TCR_TRB;

    //
    // Timer2 on INTOSC1, no prescale, bounding the window.
    //
    HWREGH(CPUSYS_BASE + SYSCTL_O_TMR2CLKCTL) =
        (HWREGH(CPUSYS_BASE + SYSCTL_O_TMR2CLKCTL) &
         (uint16_t)~(SYSCTL_TMR2CLKCTL_TMR2CLKSRCSEL_M |
                     SYSCTL_TMR2CLKCTL_TMR2CLKPRESCALE_M)) | 1U;
    HWREGH(CPUTIMER2_BASE + CPUTIMER_O_TCR) |= CPUTIMER_TCR_TSS;
    HWREG(CPUTIMER2_BASE + CPUTIMER_O_PRD) = BTS_CLKMEAS_WINDOW;
    HWREG(CPUTIMER2_BASE + CPUTIMER_O_TPR) = 0U;
    HWREGH(CPUTIMER2_BASE + CPUTIMER_O_TCR) |= CPUTIMER_TCR_TRB;
    HWREGH(CPUTIMER2_BASE + CPUTIMER_O_TCR) |= CPUTIMER_TCR_TIF;

    //
    // Release both as close together as possible, then wait out the window.
    //
    HWREGH(CPUTIMER2_BASE + CPUTIMER_O_TCR) &= ~CPUTIMER_TCR_TSS;
    HWREGH(CPUTIMER1_BASE + CPUTIMER_O_TCR) &= ~CPUTIMER_TCR_TSS;

    while ((HWREGH(CPUTIMER2_BASE + CPUTIMER_O_TCR) & CPUTIMER_TCR_TIF) == 0U) {
        ;
    }

    HWREGH(CPUTIMER1_BASE + CPUTIMER_O_TCR) |= CPUTIMER_TCR_TSS;
    HWREGH(CPUTIMER2_BASE + CPUTIMER_O_TCR) |= CPUTIMER_TCR_TSS;

    elapsed = 0xFFFFFFFFUL - HWREG(CPUTIMER1_BASE + CPUTIMER_O_TIM);

    //
    // Restore.
    //
    HWREGH(CPUTIMER1_BASE + CPUTIMER_O_TCR) = t1TCR;
    HWREG(CPUTIMER1_BASE + CPUTIMER_O_PRD) = t1PRD;
    HWREGH(CPUTIMER1_BASE + CPUTIMER_O_TPR) = t1TPR;
    HWREGH(CPUTIMER1_BASE + CPUTIMER_O_TPRH) = t1TPRH;
    HWREGH(CPUSYS_BASE + SYSCTL_O_TMR2CLKCTL) = t2CLKCTL;
    HWREGH(CPUTIMER2_BASE + CPUTIMER_O_TCR) = t2TCR;
    HWREG(CPUTIMER2_BASE + CPUTIMER_O_PRD) = t2PRD;
    HWREGH(CPUTIMER2_BASE + CPUTIMER_O_TPR) = t2TPR;
    HWREGH(CPUTIMER2_BASE + CPUTIMER_O_TPRH) = t2TPRH;
    HWREGH(CPUTIMER1_BASE + CPUTIMER_O_TCR) |= CPUTIMER_TCR_TRB;
    HWREGH(CPUTIMER2_BASE + CPUTIMER_O_TCR) |= CPUTIMER_TCR_TRB;

    EDIS;

    BTS_sysclkTicks = elapsed;

    //
    // kHz = elapsed * (INTOSC1 / window) / 1000. Ordered to stay in 32 bits:
    // INTOSC1/window is exact for the chosen constants.
    //
    return ((elapsed * (BTS_CLKMEAS_INTOSC1_HZ / BTS_CLKMEAS_WINDOW)) / 1000UL);
}

//
// Public accessor so CPU1 tasks can re-measure without duplicating the code.
//
uint32_t BTS_HAL_getMeasuredSysclkKHz(void)
{
    return (BTS_HAL_measureSysclkKHz());
}

//
// Periodic clock-health check, called from a slow background task.
//
// MCD is not only a boot-time concern: a marginal oscillator can drop out
// while the unit is running, at which point the hardware silently switches
// SYSCLK to INTOSC1 and every PLL register keeps reading correct. This is
// the only thing that would catch that, and it is why the counter is kept
// rather than just the current state - a trip that self-clears still leaves
// evidence.
//
// Deliberately does NOT halt: a converter mid-cycle is stopped through the
// normal shutdown path, not from a background poll. It records, and the
// supervisor acts on BTS_mcdTrips.
//
void BTS_HAL_pollClockHealth(void)
{
    BTS_mcdLive = HWREGH(CLKCFG_BASE + SYSCTL_O_MCDCR);

    if (BTS_HAL_mcdTripped()) {
        if (BTS_mcdTrips < 0xFFFFU) {
            BTS_mcdTrips++;
        }
    }
}

//
// Halts the unit with every converter output driven low.
//
// Reached only when the clock cannot be trusted, so nothing here may depend
// on a calibrated timebase: the trip zones are forced by register write, not
// by the control loop, and the function never returns.
//
static void BTS_HAL_clockFailureHalt(void)
{
    uint16_t ch;

    EALLOW;
    //
    // Force every ePWM into its one-shot trip state, which drives both
    // outputs low in hardware and latches them there.
    //
    for (ch = 0U; ch < 8U; ch++) {
        uint32_t base = EPWM1_BASE + (uint32_t)ch * (EPWM2_BASE - EPWM1_BASE);
        EPWM_forceTripZoneEvent(base, EPWM_TZ_FORCE_EVENT_OST);
    }
    EDIS;

    //
    // Interrupts off, then spin. A watchdog reset from here is acceptable -
    // it retries the PLL, which is the only recovery available.
    //
    DINT;
    for (;;) {
        ;
    }
}

void BTS_HAL_setupDevice(void)
{
    uint16_t attempt;

    //
    // Capture and CLEAR the missing-clock detector BEFORE Device_init().
    //
    // This ordering is the whole fix. SysCtl_setClock() short-circuits on a
    // latched MCLKSTS and returns false without touching a single PLL
    // register; device.c discards that return. MCLKSTS survives a warm reset,
    // so one oscillator glitch pins the device on INTOSC1 indefinitely while
    // SYSPLLMULT/SYSPLLSTS/SYSPLLCTL1 keep reporting the configured values.
    // Clearing it here means Device_init() can actually program the PLL.
    //
    BTS_mcdBefore = HWREGH(CLKCFG_BASE + SYSCTL_O_MCDCR);
    if (BTS_HAL_mcdTripped()) {
        SysCtl_resetMCD();
    }

    //
    // Initialize device clock and peripherals
    //
    Device_init();

    //
    // Device_init() has already run driverlib's own lock sequence. Verify it
    // actually took, and retry with a much longer settle if it did not.
    //
    // The loop condition tests the MCD as well as the lock bit: a latched MCD
    // means the core is on INTOSC1 no matter what the PLL status says.
    //
    for (attempt = 0U; (attempt < BTS_PLL_LOCK_ATTEMPTS) &&
                       (!BTS_HAL_pllIsLocked() || BTS_HAL_mcdTripped());
         attempt++) {
        //
        // Clear any MCD latched by the previous attempt, or setClock() below
        // will short-circuit exactly as the original failure did.
        //
        SysCtl_resetMCD();

        EALLOW;
        //
        // Drop back to the oscillator before touching the multiplier, so the
        // core is never clocked from a PLL mid-relock.
        //
        HWREGH(CLKCFG_BASE + SYSCTL_O_SYSPLLCTL1) &=
            ~(uint16_t)SYSCTL_SYSPLLCTL1_PLLCLKEN;
        HWREGH(CLKCFG_BASE + SYSCTL_O_SYSPLLCTL1) &=
            ~(uint16_t)SYSCTL_SYSPLLCTL1_PLLEN;
        EDIS;

        BTS_HAL_pllSettle();

        //
        // Re-run the full driverlib sequence, which rewrites the multiplier
        // and the dividers together. Its return value is checked here - the
        // stock device.c throws it away, which is how the original failure
        // stayed invisible.
        //
        BTS_setClockOk = (uint16_t)SysCtl_setClock(DEVICE_SETCLOCK_CFG);
        BTS_HAL_pllSettle();
    }

    //
    // Fatal if it never locked - see the note above on why this cannot be a
    // warning. Recorded for the debugger before the outputs are killed.
    //
    //
    // Latch the PLL state from CPU1 itself - see the note on these globals.
    //
    BTS_pllMultAfter = HWREGH(CLKCFG_BASE + SYSCTL_O_SYSPLLMULT);
    BTS_pllStsAfter  = HWREGH(CLKCFG_BASE + SYSCTL_O_SYSPLLSTS);
    BTS_pllCtl1After = HWREGH(CLKCFG_BASE + SYSCTL_O_SYSPLLCTL1);
    BTS_clkSrcAfter  = HWREGH(CLKCFG_BASE + SYSCTL_O_CLKSRCCTL1);
    BTS_sysDivAfter  = HWREGH(CLKCFG_BASE + SYSCTL_O_SYSCLKDIVSEL);
    //
    // The peripheral clock path, read from CPU1 for the same reason.
    // LOSPCP sets LSPCLK (SCI/SPI/I2C); PERCLKDIVSEL holds EPWMCLKDIV.
    //
    BTS_lospcpAfter  = HWREGH(CLKCFG_BASE + SYSCTL_O_LOSPCP);
    BTS_perDivAfter  = HWREGH(CLKCFG_BASE + SYSCTL_O_PERCLKDIVSEL);
    BTS_tmr2ClkAfter = HWREGH(CLKCFG_BASE + SYSCTL_O_TMR2CLKCTL);

    BTS_mcdAfter = HWREGH(CLKCFG_BASE + SYSCTL_O_MCDCR);

    //
    // Measure SYSCLK and hold the unit if it is not what the firmware has
    // been compiled to assume.
    //
    // The lock bit alone is NOT sufficient evidence: under an MCD failover it
    // reads locked while the core runs from INTOSC1. Every derived timing -
    // PWM period, dead time, trip response, control-loop rate - comes from
    // DEVICE_SYSCLK_FREQ, so a mismatch here is a hazard, not a degradation.
    // +/-5% covers INTOSC2's +/-2% tolerance and the measurement window's
    // quantisation, while still catching the ~20x error seen on this board.
    //
    BTS_sysclkKHz = BTS_HAL_measureSysclkKHz();

    {
        uint32_t expectedKHz = (uint32_t)(DEVICE_SYSCLK_FREQ / 1000U);
        uint32_t lowKHz  = expectedKHz - (expectedKHz / 20U);
        uint32_t highKHz = expectedKHz + (expectedKHz / 20U);

        if (!BTS_HAL_pllIsLocked() || BTS_HAL_mcdTripped() ||
            (BTS_sysclkKHz < lowKHz) || (BTS_sysclkKHz > highKHz)) {
            BTS_pllLockFailed = 1U;
            BTS_HAL_clockFailureHalt();
        }
    }
    BTS_pllLockFailed = 0U;
    //SysCtl_setLowSpeedClock(SYSCTL_LSPCLK_PRESCALE_1);
    //
    // Disable pin locks and enable internal pull-ups.
    //
    Device_initGPIO();

    //
    // Initialize PIE and clear PIE registers. Disables CPU interrupts.
    //
    Interrupt_initModule();

    //
    // Initialize the PIE vector table with pointers to the shell Interrupt
    // Service Routines (ISR).
    //
    Interrupt_initVectorTable();

    // Setup trip system
    BTS_HAL_setupTripSystem();

    //
    // Initialize CPU timers for task scheduling
    //

    //
    // TASK A FREQUENCY
    //
    CPUTimer_setPeriod(TASKA_CPUTIMER_BASE, DEVICE_SYSCLK_FREQ / TASKA_FREQ_HZ);

    //
    // TASK B FREQUENCY
    //
    CPUTimer_setPeriod(TASKB_CPUTIMER_BASE, DEVICE_SYSCLK_FREQ / TASKB_FREQ_HZ);

    //
    // TASK C FREQUENCY
    //
    CPUTimer_setPeriod(TASKC_CPUTIMER_BASE, DEVICE_SYSCLK_FREQ / TASKC_FREQ_HZ);

    //
    // Initialize pre-scale counter to divide by 1 (SYSCLKOUT)
    //
    CPUTimer_setPreScaler(TASKA_CPUTIMER_BASE, 0);

    //
    // Initialize pre-scale counter to divide by 1 (SYSCLKOUT)
    //
    CPUTimer_setPreScaler(TASKB_CPUTIMER_BASE, 0);

    //
    // Initialize pre-scale counter to divide by 1 (SYSCLKOUT)
    //
    CPUTimer_setPreScaler(TASKC_CPUTIMER_BASE, 0);

    //
    // Make sure timer is stopped
    //
    CPUTimer_stopTimer(TASKA_CPUTIMER_BASE);
    CPUTimer_stopTimer(TASKB_CPUTIMER_BASE);
    CPUTimer_stopTimer(TASKC_CPUTIMER_BASE);
    CPUTimer_setEmulationMode(TASKA_CPUTIMER_BASE,
                              CPUTIMER_EMULATIONMODE_STOPAFTERNEXTDECREMENT);
    CPUTimer_setEmulationMode(TASKB_CPUTIMER_BASE,
                              CPUTIMER_EMULATIONMODE_STOPAFTERNEXTDECREMENT);
    CPUTimer_setEmulationMode(TASKC_CPUTIMER_BASE,
                              CPUTIMER_EMULATIONMODE_STOPAFTERNEXTDECREMENT);

    //
    // Reload and start all counter register with period value
    //
    CPUTimer_startTimer(TASKA_CPUTIMER_BASE);
    CPUTimer_startTimer(TASKB_CPUTIMER_BASE);
    CPUTimer_startTimer(TASKC_CPUTIMER_BASE);
}

extern volatile uint32_t startup_mode;
extern volatile uint32_t startup_enable;

/* SN74HC148DR
 * This is attached to the three inputs, so its a single select
 * based on parity really */
uint8_t truth_table[8] = {
  7, // 0 Input 7=L
  6, // 1 Input 6=L
  5, // 2 Input 5=L
  4, // 3 Input 4=L
  3, // 4 Input 3=L
  2, // 5 Input 2=L
  1, // 6 Input 1=L
  0  // 7 Input 0=L or ALL OFF
};


void BTS_HAL_setupGPIO(void)
{
    // Configure GPIOs Mode options
    GPIO_setPinConfig(BTS_MODE_GPIO_CFG_0);
    GPIO_setPinConfig(BTS_MODE_GPIO_CFG_1);
    GPIO_setPinConfig(BTS_MODE_GPIO_CFG_2);
    GPIO_setDirectionMode(BTS_MODE_GPIO_PIN_0, GPIO_DIR_MODE_IN);
    GPIO_setDirectionMode(BTS_MODE_GPIO_PIN_1, GPIO_DIR_MODE_IN);
    GPIO_setDirectionMode(BTS_MODE_GPIO_PIN_2, GPIO_DIR_MODE_IN);
    GPIO_setPadConfig(BTS_MODE_GPIO_PIN_0, GPIO_PIN_TYPE_STD);
    GPIO_setPadConfig(BTS_MODE_GPIO_PIN_1, GPIO_PIN_TYPE_STD);
    GPIO_setPadConfig(BTS_MODE_GPIO_PIN_2, GPIO_PIN_TYPE_STD);

    // Configure GPIOs Enable options
    GPIO_setPinConfig(BTS_EN_GPIO_CFG_0);
    GPIO_setPinConfig(BTS_EN_GPIO_CFG_1);
    GPIO_setPinConfig(BTS_EN_GPIO_CFG_2);
    GPIO_setDirectionMode(BTS_EN_GPIO_PIN_0, GPIO_DIR_MODE_IN);
    GPIO_setDirectionMode(BTS_EN_GPIO_PIN_1, GPIO_DIR_MODE_IN);
    GPIO_setDirectionMode(BTS_EN_GPIO_PIN_2, GPIO_DIR_MODE_IN);
    GPIO_setPadConfig(BTS_EN_GPIO_PIN_0, GPIO_PIN_TYPE_STD);
    GPIO_setPadConfig(BTS_EN_GPIO_PIN_1, GPIO_PIN_TYPE_STD);
    GPIO_setPadConfig(BTS_EN_GPIO_PIN_2, GPIO_PIN_TYPE_STD);

    // startup_enable
    startup_enable  = (GPIO_readPin(BTS_EN_GPIO_PIN_0) ? 1 : 0) << 0;
    startup_enable |= (GPIO_readPin(BTS_EN_GPIO_PIN_1) ? 1 : 0) << 1;
    startup_enable |= (GPIO_readPin(BTS_EN_GPIO_PIN_2) ? 1 : 0) << 2;
    startup_enable = truth_table[startup_enable];

    // startup_mode
    startup_mode  = (GPIO_readPin(BTS_MODE_GPIO_PIN_0) ? 1 : 0) << 0;
    startup_mode |= (GPIO_readPin(BTS_MODE_GPIO_PIN_1) ? 1 : 0) << 1;
    startup_mode |= (GPIO_readPin(BTS_MODE_GPIO_PIN_2) ? 1 : 0) << 2;
    startup_mode = truth_table[startup_mode];
}

void BTS_HAL_setupExAdc_ch1_4(void)
{
    /* (OPTIONAL) Provide additional delay time for power supply settling */
    delay_ms_2(50);

    /* (REQUIRED) Set nRESET pin high for ADC operation */

    GPIO_writePin(BTS_SPI_RESET_GPIO_ADC1, 1);
    delay_ms_2(1);

    /* (OPTIONAL) Toggle nRESET pin to ensure default register settings. */
    /* NOTE: This also ensures that the device registers are unlocked.   */
    GPIO_writePin(BTS_SPI_RESET_GPIO_ADC1, 0);
    delay_ms_2(1);
    GPIO_writePin(BTS_SPI_RESET_GPIO_ADC1, 1);
    delay_ms_2(1);

    /* (REQUIRED) Initialize internal 'registerMap' array with device default settings */
//        restoreRegisterDefaults();

    /* (OPTIONAL) Validate first response word when beginning SPI communication: (0xFF20 | CHANCNT) */
//        uint16_t response = sendCommand(OPCODE_NULL);

    /* (OPTIONAL) Define your initial register settings here */
//        writeSingleRegister(CLOCK_ADDRESS, (CLOCK_DEFAULT & ~CLOCK_OSR_MASK) | CLOCK_OSR_256);

    /* (REQUIRED) Configure MODE register settings
     * NOTE: This function call is required here for this particular code implementation to work.
     * This function will enforce the MODE register settings as selected in the 'ads131m0x.h' header file.
     */
//        writeSingleRegister(MODE_ADDRESS, MODE_DEFAULT);

    //while(!GPIO_readPin(BTS_SPI_DRDY_GPIO_ADC1));

    //adc 1 mode set
    //adc register 0x02
    // cs1 bar low

    //default 24 bit mode 0x0510/////////////////////////
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 0);
    //wreg add
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x6100); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //reg data
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0005); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);

    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0100); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //no crc
//        SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0000); // adc address 0x02
//        SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //cs bar high
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 1);

    SysCtl_delay(10000);

// desired 16 bit mode/////////////////////////////////
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 0);
    //wreg add
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x6100); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //reg data
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0000); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);

    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0100); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //no crc
//        SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0000); // adc address 0x02
//        SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //cs bar high
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 1);

    SysCtl_delay(100000);
#if 0
    // desired 16 bit mode/////////////////////////////////
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 0);
    //wreg add
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x6100); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //reg data
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0400); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);

    //SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0000); // adc address 0x02
    //SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //no crc
//        SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0000); // adc address 0x02
//        SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //cs bar high
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 1);
#endif
    SysCtl_delay(100000);

    //adc register 0x03. mode register, 0xFF47, external reference ENABLED, OSR 128 16k SAMPLE RATE
    // cs1 bar low
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 0);
    //wreg add
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x6180); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //reg data
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0xFF43); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //crc
    //SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC1, 0x0000); // adc address 0x02
    //SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC1);
    //cs bar high
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 1);

    SysCtl_delay(10000);

    /* (OPTIONAL) Read back all registers */

}

void BTS_HAL_setupExAdc_ch5_8(void)
{
    /* (OPTIONAL) Provide additional delay time for power supply settling */
    delay_ms_2(50);

    /* (REQUIRED) Set nRESET pin high for ADC operation */

    GPIO_writePin(BTS_SPI_RESET_GPIO_ADC2, 1);
    delay_ms_2(1);

    /* (OPTIONAL) Toggle nRESET pin to ensure default register settings. */
    /* NOTE: This also ensures that the device registers are unlocked.   */
    GPIO_writePin(BTS_SPI_RESET_GPIO_ADC2, 0);
    delay_ms_2(1);
    GPIO_writePin(BTS_SPI_RESET_GPIO_ADC2, 1);
    delay_ms_2(1);

    /* (REQUIRED) Initialize internal 'registerMap' array with device default settings */
//        restoreRegisterDefaults();

    /* (OPTIONAL) Validate first response word when beginning SPI communication: (0xFF20 | CHANCNT) */
//        uint16_t response = sendCommand(OPCODE_NULL);

    /* (OPTIONAL) Define your initial register settings here */
//        writeSingleRegister(CLOCK_ADDRESS, (CLOCK_DEFAULT & ~CLOCK_OSR_MASK) | CLOCK_OSR_256);

    /* (REQUIRED) Configure MODE register settings
     * NOTE: This function call is required here for this particular code implementation to work.
     * This function will enforce the MODE register settings as selected in the 'ads131m0x.h' header file.
     */
//        writeSingleRegister(MODE_ADDRESS, MODE_DEFAULT);

    //while(!GPIO_readPin(BTS_SPI_DRDY_GPIO_ADC2));

    //adc 1 mode set
    //adc register 0x02
    // cs1 bar low

    //default 24 bit mode 0x0510/////////////////////////
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC2, 0);
    //wreg add
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x6100); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);
    //reg data
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x0005); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);

    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x0100); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);
    //no crc
//        SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x0000); // adc address 0x02
//        SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);
    //cs bar high
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC2, 1);

    SysCtl_delay(10000);

// desired 16 bit mode/////////////////////////////////
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC2, 0);
    //wreg add
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x6100); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);
    //reg data
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x0000); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);

    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x0100); // adc address 0x02
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);
    //no crc
//        SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x0000); // adc address 0x02
//        SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);
    //cs bar high
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC2, 1);

    SysCtl_delay(100000);


    //adc register 0x03. mode register, 0xFF47, external reference ENABLED, OSR 256 13.95k SAMPLE RATE ( 0xFF47)
    //adc register 0x03. mode register, 0xFF4B, external reference ENABLED, OSR 512 13.95k SAMPLE RATE ( 0xFF47)
    // cs1 bar low
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC2, 0);
    //wreg add
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x6180); // adc address 0x03
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);
    //reg data
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0xFF43); // adc address 0x03 // 0xFF47
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);
    //crc
    SPI_writeDataBlockingFIFO(BTS_SPI_BASE_ADC2, 0x0000); // adc address 0x03
    SPI_readDataBlockingFIFO(BTS_SPI_BASE_ADC2);
    //cs bar high
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC2, 1);

    SysCtl_delay(10000);

    /* (OPTIONAL) Read back all registers */

}


void delay_ms_2(const uint32_t delay_time_ms)
{
    /* --- INSERT YOUR CODE HERE --- */
   const uint32_t cycles_per_loop = 3;
   SysCtl_delay(delay_time_ms * SysCtl_getClock(100000000U) / (cycles_per_loop * 1000u));
   //MAP_SysCtlDelay( delay_time_ms * getSysClockHz() / (cycles_per_loop * 1000u) );
}



void BTS_HAL_setupExAdcGpio_Adc1(void)
{
    // configure xint GPIO for ADC ///////////////////////////////////
    GPIO_setPinConfig(BTS_SPI_DRDY_PIN_CONFIG_ADC1);
    GPIO_setDirectionMode(BTS_SPI_DRDY_GPIO_ADC1, GPIO_DIR_MODE_IN);
    GPIO_setQualificationMode(BTS_SPI_DRDY_GPIO_ADC1, GPIO_QUAL_SYNC);
    //
    // Route this ADC's DRDY pin to its external interrupt. The XINT number
    // comes from bts_user_settings.h - see the note there about why CPU1 owns
    // XINT3/XINT5 rather than XINT1/XINT2.
    //
    GPIO_setInterruptPin(BTS_SPI_DRDY_GPIO_ADC1, BTS_PSI_DRDY_XINT_GPIO1);

    //
    // DRDY asserts low when a conversion is ready.
    //
    GPIO_setInterruptType(BTS_PSI_DRDY_XINT_GPIO1, GPIO_INT_TYPE_FALLING_EDGE);

    GPIO_enableInterrupt(BTS_PSI_DRDY_XINT_GPIO1);


    // configure reset pin
    //
    // GPIO_setAnalogMode is not called here: on the F2837xD only GPIO42 and
    // GPIO43 have an analog mux (driverlib asserts pin == 42 || pin == 43).
    // GPIO24 is digital-only, so it needs no analog-mode selection.
    //
    GPIO_setPadConfig(BTS_SPI_RESET_GPIO_ADC1, GPIO_PIN_TYPE_PULLUP);     // Enable pullup on GPIO24
    GPIO_writePin(BTS_SPI_RESET_GPIO_ADC1, 1);                            // Load output latch
    GPIO_setPinConfig(BTS_SPI_RESET_PIN_CONFIG_ADC1);                     // GPIO24 = GPIO24
    GPIO_setDirectionMode(BTS_SPI_RESET_GPIO_ADC1, GPIO_DIR_MODE_OUT);
}

void BTS_HAL_setupExAdcGpio_Adc2(void)
{
    // configure xint GPIO for ADC ///////////////////////////////////
    GPIO_setPinConfig(BTS_SPI_DRDY_PIN_CONFIG_ADC2);
    GPIO_setDirectionMode(BTS_SPI_DRDY_GPIO_ADC2, GPIO_DIR_MODE_IN);
    GPIO_setQualificationMode(BTS_SPI_DRDY_GPIO_ADC2, GPIO_QUAL_SYNC);
    //
    // As for ADC1 above - the XINT number is set in bts_user_settings.h.
    //
    GPIO_setInterruptPin(BTS_SPI_DRDY_GPIO_ADC2, BTS_PSI_DRDY_XINT_GPIO2);

    //
    // DRDY asserts low when a conversion is ready.
    //
    GPIO_setInterruptType(BTS_PSI_DRDY_XINT_GPIO2, GPIO_INT_TYPE_FALLING_EDGE);

    GPIO_enableInterrupt(BTS_PSI_DRDY_XINT_GPIO2);


    // configure reset pin
    //
    // As with ADC1: GPIO48 is digital-only, so no analog-mode call.
    //
    GPIO_setPadConfig(BTS_SPI_RESET_GPIO_ADC2, GPIO_PIN_TYPE_PULLUP);     // Enable pullup on GPIO48
    GPIO_writePin(BTS_SPI_RESET_GPIO_ADC2, 1);                            // Load output latch
    GPIO_setPinConfig(BTS_SPI_RESET_PIN_CONFIG_ADC2);                     // GPIO48 = GPIO48
    GPIO_setDirectionMode(BTS_SPI_RESET_GPIO_ADC2, GPIO_DIR_MODE_OUT);
}


/* ArakniD: DONE */
void BTS_HAL_setupSyncBuckPinsGpio(void)
{
    GPIO_writePin(BTS_EPWM_H_GPIO_CH1, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_CH1, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_CH1);

    GPIO_writePin(BTS_EPWM_L_GPIO_CH1, 0);
    GPIO_setDirectionMode(BTS_EPWM_L_GPIO_CH1, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_GPIO_CH1);

    GPIO_writePin(BTS_EPWM_H_GPIO_CH2, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_CH2, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_CH2);

    GPIO_writePin(BTS_EPWM_L_GPIO_CH2, 0);
    GPIO_setDirectionMode(BTS_EPWM_L_GPIO_CH2, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_GPIO_CH2);

    GPIO_writePin(BTS_EPWM_H_GPIO_CH3, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_CH3, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_CH3);

    GPIO_writePin(BTS_EPWM_L_GPIO_CH3, 0);
    GPIO_setDirectionMode(BTS_EPWM_L_GPIO_CH3, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_GPIO_CH3);

    GPIO_writePin(BTS_EPWM_H_GPIO_CH4, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_CH4, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_CH4);

    GPIO_writePin(BTS_EPWM_L_GPIO_CH4, 0);
    GPIO_setDirectionMode(BTS_EPWM_L_GPIO_CH4, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_GPIO_CH4);

    GPIO_writePin(BTS_EPWM_H_GPIO_CH5, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_CH5, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_CH5);

    GPIO_writePin(BTS_EPWM_L_GPIO_CH5, 0);
    GPIO_setDirectionMode(BTS_EPWM_L_GPIO_CH5, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_GPIO_CH5);

    GPIO_writePin(BTS_EPWM_H_GPIO_CH6, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_CH6, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_CH6);

    GPIO_writePin(BTS_EPWM_L_GPIO_CH6, 0);
    GPIO_setDirectionMode(BTS_EPWM_L_GPIO_CH6, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_GPIO_CH6);

    GPIO_writePin(BTS_EPWM_H_GPIO_CH7, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_CH7, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_CH7);

    GPIO_writePin(BTS_EPWM_L_GPIO_CH7, 0);
    GPIO_setDirectionMode(BTS_EPWM_L_GPIO_CH7, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_GPIO_CH7);

    GPIO_writePin(BTS_EPWM_H_GPIO_CH8, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_CH8, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_CH8);

    GPIO_writePin(BTS_EPWM_L_GPIO_CH8, 0);
    GPIO_setDirectionMode(BTS_EPWM_L_GPIO_CH8, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_GPIO_CH8);

    // Setup ADC1 external clock
    GPIO_writePin(BTS_EPWM_H_GPIO_ADC1, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_ADC1, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_ADC1);

    // Setup ADC2 external clock
    GPIO_writePin(BTS_EPWM_H_GPIO_ADC2, 0);
    GPIO_setDirectionMode(BTS_EPWM_H_GPIO_ADC2, GPIO_DIR_MODE_OUT);
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_GPIO_ADC2);
}


//
// BUCK_HAL_setupSyncBuckPinsEpwm - Configure synchronous buck pins
// to be controlled by ePWM module
//

/* ArakniD: DONE */
void BTS_HAL_setupSyncBuckPinsEpwm(void)
{
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_CH1);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_EPWM_CH1);

    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_CH2);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_EPWM_CH2);

    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_CH3);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_EPWM_CH3);

    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_CH4);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_EPWM_CH4);

    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_CH5);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_EPWM_CH5);

    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_CH6);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_EPWM_CH6);

    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_CH7);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_EPWM_CH7);

    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_CH8);
    GPIO_setPinConfig(BTS_EPWM_L_PIN_CONFIG_EPWM_CH8);

    // Setup ADC1 external clock
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_ADC1);

    // Setup ADC2 external clock
    GPIO_setPinConfig(BTS_EPWM_H_PIN_CONFIG_EPWM_ADC2);
}


//
// BUCK_HAL_setupSyncBuckPwm - Configure ePWM to actuate complementary
// Buck switches with variable duty-cycle control and deadband
//
void BTS_HAL_setupSyncBuckPwm(uint32_t EPWM_BASE)
{
    //
    // Maximum supported ePWM clock speed is specified in the datasheet
    //
    EPWM_setClockPrescaler(EPWM_BASE,
                           BTS_DRV_EPWM_EPWMCLK_DIV,
                           BTS_DRV_EPWM_HSCLK_DIV);

    EPWM_setEmulationMode(EPWM_BASE, EPWM_EMULATION_FREE_RUN);

    //
    // Configure ePWM for count-up operation
    //
    EPWM_setTimeBaseCounter(EPWM_BASE, 0);
    EPWM_setTimeBasePeriod(EPWM_BASE, BTS_DRV_EPWM_TBPRD);
    EPWM_setPeriodLoadMode(EPWM_BASE, EPWM_PERIOD_SHADOW_LOAD);
    EPWM_setTimeBaseCounterMode(EPWM_BASE, EPWM_COUNTER_MODE_UP);
    EPWM_disablePhaseShiftLoad(EPWM_BASE);

    //
    // Set Compare values
    //
    EPWM_setCounterCompareValue(EPWM_BASE,
                                EPWM_COUNTER_COMPARE_A,
                                0U);
    EPWM_setCounterCompareValue(EPWM_BASE,
                                EPWM_COUNTER_COMPARE_B,
                                BTS_DRV_EPWM_TBPRD);

    HRPWM_setCounterCompareValue(EPWM_BASE,
                                     HRPWM_COUNTER_COMPARE_A,
                                     0);
    HRPWM_setCounterCompareValue(EPWM_BASE,
                                     HRPWM_COUNTER_COMPARE_B,
                                     1000U);


    //
    // Set up counter mode
    //
    EPWM_setTimeBaseCounterMode(EPWM_BASE, EPWM_COUNTER_MODE_UP);
    EPWM_disablePhaseShiftLoad(EPWM_BASE);
    EPWM_setClockPrescaler(EPWM_BASE,
                           EPWM_CLOCK_DIVIDER_1,
                           EPWM_HSCLOCK_DIVIDER_1);


    //
    // Use shadow mode to update CMPA on TBPRD
    //
    EPWM_setCounterCompareShadowLoadMode(EPWM_BASE,
                                         EPWM_COUNTER_COMPARE_A,
                                         EPWM_COMP_LOAD_ON_CNTR_PERIOD);

    HRPWM_setCounterCompareShadowLoadEvent(EPWM_BASE,
                                               HRPWM_CHANNEL_A,
                                               HRPWM_LOAD_ON_CNTR_PERIOD);

    EPWM_setCounterCompareShadowLoadMode(EPWM_BASE,
                                         EPWM_COUNTER_COMPARE_B,
                                         EPWM_COMP_LOAD_ON_CNTR_PERIOD);

    HRPWM_setCounterCompareShadowLoadEvent(EPWM_BASE,
                                               HRPWM_CHANNEL_B,
                                               HRPWM_LOAD_ON_CNTR_PERIOD);


    //
    // Configure Action Qualifier SubModule to:
    //     Output High when TBCTR=0
    //     Output  Low when TBCTR=CMPA (for VMC only)
    //
    // Use shadow mode to update AQCTL
    //
    EPWM_setActionQualifierShadowLoadMode(EPWM_BASE,
                                          EPWM_ACTION_QUALIFIER_A,
                                          EPWM_AQ_LOAD_ON_CNTR_PERIOD);
    EPWM_setActionQualifierAction(EPWM_BASE,
                                  EPWM_AQ_OUTPUT_A,
                                  EPWM_AQ_OUTPUT_HIGH,
                                  EPWM_AQ_OUTPUT_ON_TIMEBASE_ZERO);

    EPWM_setActionQualifierAction(EPWM_BASE,
                                      EPWM_AQ_OUTPUT_A,
                                      EPWM_AQ_OUTPUT_LOW,
                                      EPWM_AQ_OUTPUT_ON_TIMEBASE_UP_CMPA);
    // CONFIGURE COMPB
    EPWM_setActionQualifierShadowLoadMode(EPWM_BASE,
                                          EPWM_ACTION_QUALIFIER_B,
                                          EPWM_AQ_LOAD_ON_CNTR_PERIOD);
    EPWM_setActionQualifierAction(EPWM_BASE,
                                  EPWM_AQ_OUTPUT_B,
                                  EPWM_AQ_OUTPUT_HIGH,
                                  EPWM_AQ_OUTPUT_ON_TIMEBASE_ZERO);


    EPWM_setActionQualifierAction(EPWM_BASE,
                                      EPWM_AQ_OUTPUT_B,
                                      EPWM_AQ_OUTPUT_LOW,
                                      EPWM_AQ_OUTPUT_ON_TIMEBASE_UP_CMPB);

    //
    // Align the HRPWM CMPA behavior with EPWM
    //
    HRPWM_setMEPEdgeSelect(EPWM_BASE,
                           HRPWM_CHANNEL_A,
                           HRPWM_MEP_CTRL_FALLING_EDGE);

    HRPWM_setMEPControlMode(EPWM_BASE,
                            HRPWM_CHANNEL_A,
                            HRPWM_MEP_DUTY_PERIOD_CTRL);

    HRPWM_setMEPEdgeSelect(EPWM_BASE,
                           HRPWM_CHANNEL_B,
                           HRPWM_MEP_CTRL_RISING_EDGE);

    HRPWM_setMEPControlMode(EPWM_BASE,
                            HRPWM_CHANNEL_B,
                            HRPWM_MEP_DUTY_PERIOD_CTRL);

    //
    // Configure Dead Band Generator for active high complementary PWMs
    //
    EPWM_setDeadBandDelayMode(EPWM_BASE, EPWM_DB_RED, true);
    EPWM_setDeadBandDelayMode(EPWM_BASE, EPWM_DB_FED, true);

    EPWM_setRisingEdgeDeadBandDelayInput(EPWM_BASE,
                                         EPWM_DB_INPUT_EPWMA);
    EPWM_setFallingEdgeDeadBandDelayInput(EPWM_BASE,
                                          EPWM_DB_INPUT_EPWMB);// old value EPWMA

    EPWM_setDeadBandDelayPolarity(EPWM_BASE,
                                  EPWM_DB_FED,
                                  EPWM_DB_POLARITY_ACTIVE_LOW);
    EPWM_setDeadBandDelayPolarity(EPWM_BASE,
                                  EPWM_DB_RED,
                                  EPWM_DB_POLARITY_ACTIVE_HIGH);

    EPWM_setFallingEdgeDelayCount(EPWM_BASE,
                                  BTS_DRV_EPWM_DEADBAND_FED);
    EPWM_setRisingEdgeDelayCount(EPWM_BASE,
                                 BTS_DRV_EPWM_DEADBAND_RED);

    EPWM_setFallingEdgeDelayCount(EPWM_BASE,
                                  BTS_DRV_EPWM_DEADBAND_FED);
    EPWM_setRisingEdgeDelayCount(EPWM_BASE,
                                 BTS_DRV_EPWM_DEADBAND_RED);


    #if(BTS_DRV_EPWM_HR_ENABLED == true)
        //
        // HRCAL uses the EPWM1 clock
        //
        // SysCtl_enablePeripheral(SYSCTL_PERIPH_CLK_EPWM2);

//        HRPWM_enableAutoConversion(EPWM_BASE);
    #endif
}

//
// BUCK_HAL_setupSyncBuckPwm - Configure ePWM to actuate complementary
// Buck switches with variable duty-cycle control and deadband
//
void BTS_HAL_setupAdcClock(uint32_t EPWM_BASE)
{
    //
    // Maximum supported ePWM clock speed is specified in the datasheet
    //
    EPWM_setClockPrescaler(EPWM_BASE,
                           BTS_DRV_ADC_EPWMCLK_DIV,
                           BTS_DRV_ADC_HSCLK_DIV);

    EPWM_setEmulationMode(EPWM_BASE, EPWM_EMULATION_FREE_RUN);

    //
    // Configure ePWM for count-up operation
    //
    EPWM_setTimeBaseCounter(EPWM_BASE, 0);
    EPWM_setTimeBasePeriod(EPWM_BASE, BTS_DRV_ADC_TBPRD);
    EPWM_setPeriodLoadMode(EPWM_BASE, EPWM_PERIOD_SHADOW_LOAD);
    EPWM_setTimeBaseCounterMode(EPWM_BASE, EPWM_COUNTER_MODE_UP);
    EPWM_disablePhaseShiftLoad(EPWM_BASE);

    //
    // Set Compare values
    //
    EPWM_setCounterCompareValue(EPWM_BASE,
                                EPWM_COUNTER_COMPARE_A,
                                (BTS_DRV_ADC_TBPRD / 2));
    EPWM_setCounterCompareValue(EPWM_BASE,
                                EPWM_COUNTER_COMPARE_B,
                                (BTS_DRV_ADC_TBPRD + 1) / 2);


    //
    // Set up counter mode
    //
    EPWM_setTimeBaseCounterMode(EPWM_BASE, EPWM_COUNTER_MODE_UP);
    EPWM_disablePhaseShiftLoad(EPWM_BASE);
    EPWM_setClockPrescaler(EPWM_BASE,
                           EPWM_CLOCK_DIVIDER_1,
                           EPWM_HSCLOCK_DIVIDER_1);


    //
    // Use shadow mode to update CMPA on TBPRD
    //
    EPWM_setCounterCompareShadowLoadMode(EPWM_BASE,
                                         EPWM_COUNTER_COMPARE_A,
                                         EPWM_COMP_LOAD_ON_CNTR_PERIOD);

    EPWM_setCounterCompareShadowLoadMode(EPWM_BASE,
                                         EPWM_COUNTER_COMPARE_B,
                                         EPWM_COMP_LOAD_ON_CNTR_PERIOD);

    //
    // Configure Action Qualifier SubModule to:
    //     Output High when TBCTR=0
    //     Output  Low when TBCTR=CMPA (for VMC only)
    //
    // Use shadow mode to update AQCTL
    //
    EPWM_setActionQualifierShadowLoadMode(EPWM_BASE,
                                          EPWM_ACTION_QUALIFIER_A,
                                          EPWM_AQ_LOAD_ON_CNTR_PERIOD);

    EPWM_setActionQualifierAction(EPWM_BASE,
                                  EPWM_AQ_OUTPUT_A,
                                  EPWM_AQ_OUTPUT_TOGGLE,
                                  EPWM_AQ_OUTPUT_ON_TIMEBASE_ZERO);

    EPWM_setActionQualifierAction(EPWM_BASE,
                                  EPWM_AQ_OUTPUT_A,
                                  EPWM_AQ_OUTPUT_TOGGLE,
                                  EPWM_AQ_OUTPUT_ON_TIMEBASE_UP_CMPA);

    /*EPWM_setActionQualifierAction(EPWM_BASE,
                                  EPWM_AQ_OUTPUT_A,
                                  EPWM_AQ_OUTPUT_TOGGLE,
                                  EPWM_AQ_OUTPUT_ON_TIMEBASE_UP_CMPB);

    EPWM_setActionQualifierAction(EPWM_BASE,
                                  EPWM_AQ_OUTPUT_A,
                                  EPWM_AQ_OUTPUT_TOGGLE,
                                  EPWM_AQ_OUTPUT_ON_TIMEBASE_PERIOD);

    EPWM_setActionQualifierAction(EPWM_BASE,
                                  EPWM_AQ_OUTPUT_A,
                                  EPWM_AQ_OUTPUT_TOGGLE,
                                  EPWM_AQ_OUTPUT_ON_TIMEBASE_DOWN_CMPB);

    EPWM_setActionQualifierAction(EPWM_BASE,
                                  EPWM_AQ_OUTPUT_A,
                                  EPWM_AQ_OUTPUT_TOGGLE,
                                  EPWM_AQ_OUTPUT_ON_TIMEBASE_DOWN_CMPA);
*/

}

// Function to configure CMPSS for current monitoring (COMPH and COMPL combined)
//
// Configures one channel's over-current comparator.
//
// The current-sense signal arrives on a CMPSS input pin and is compared
// against the module's internal 12-bit DAC. The high comparator trips above
// +BTS_USER_DEFAULT_TRIP_A, the low comparator below -BTS_USER_DEFAULT_TRIP_A
// (see the DAC count calculation in bts_user_settings.h).
//
// Note the negative input must be CMPSS_INSRC_DAC: with CMPSS_INSRC_PIN the
// comparator ignores the DAC entirely and no threshold applies, which left
// the trip asserted permanently.
//
void BTS_HAL_setupCMPSS(uint32_t cmpssBase) {
    EALLOW;

    //
    // DAC reference VDDA, shadow value loaded on system clock, value taken
    // from the user-programmed shadow register rather than the ramp generator.
    //
    CMPSS_configDAC(cmpssBase,
                    CMPSS_DACVAL_SYSCLK | CMPSS_DACREF_VDDA | CMPSS_DACSRC_SHDW);

    //
    // High comparator: trips when the sense pin rises above +trip.
    //
    CMPSS_configHighComparator(cmpssBase, CMPSS_INSRC_DAC);
    CMPSS_setDACValueHigh(cmpssBase, BTS_CMPSS_TRIP_HIGH);
    CMPSS_configOutputsHigh(cmpssBase, CMPSS_TRIP_FILTER | CMPSS_TRIPOUT_FILTER);
    CMPSS_configFilterHigh(cmpssBase, 0, 8, 5);
    CMPSS_initFilterHigh(cmpssBase);

    //
    // Low comparator: trips when the sense pin falls below -trip. The low
    // comparator's output is inverted so that "below threshold" asserts.
    //
    CMPSS_configLowComparator(cmpssBase, CMPSS_INSRC_DAC | CMPSS_INV_INVERTED);
    CMPSS_setDACValueLow(cmpssBase, BTS_CMPSS_TRIP_LOW);
    CMPSS_configOutputsLow(cmpssBase, CMPSS_TRIP_FILTER | CMPSS_TRIPOUT_FILTER);
    CMPSS_configFilterLow(cmpssBase, 0, 8, 5);
    CMPSS_initFilterLow(cmpssBase);

    //
    // Clear any latch left over from before the thresholds were programmed.
    //
    CMPSS_clearFilterLatchHigh(cmpssBase);
    CMPSS_clearFilterLatchLow(cmpssBase);

    CMPSS_enableModule(cmpssBase);
    EDIS;
}

// Function to configure Input X-BAR for a given input line
//
// Routes one channel's CMPSS trip output to an ePWM X-BAR trip signal.
//
// CMPSS comparator outputs do NOT go through the Input X-BAR - they reach the
// ePWM trip zones via the ePWM X-BAR. Each TRIPn output selects among muxes;
// CMPSSn occupies mux (n-1)*2. Configure the mux, then enable it.
//
void BTS_HAL_setupCmpssEpwmXBAR(XBAR_TripNum trip, XBAR_EPWMMuxConfig muxConfig,
                                uint32_t muxMask) {
    XBAR_setEPWMMuxConfig(trip, muxConfig);
    XBAR_enableEPWMMux(trip, muxMask);
}

void BTS_HAL_setupInputXBAR(uint32_t inputXbarLine, uint32_t sourceType, uint32_t sourceId) {
    //
    // Input X-BAR inputs select a GPIO by bare pin number. sourceType is
    // retained for call-site clarity but both branches are identical - the
    // Input X-BAR has no other source.
    //
    (void)sourceType;

    //
    // This device has INPUT1..INPUT14 only (XBAR_O_INPUT1SELECT 0x0 ..
    // XBAR_O_INPUT14SELECT 0xD; the next register is INPUTSELECTLOCK at
    // 0x1E). Calls above 14 would compute an address past the last select
    // register and write into reserved space, so they are rejected here
    // rather than silently corrupting the X-BAR.
    //
    if ((inputXbarLine < 1U) || (inputXbarLine > 14U)) {
        return;
    }

    XBAR_setInputPin((XBAR_InputNum)(XBAR_INPUT1 + (inputXbarLine - 1)),
                     (uint16_t)sourceId);
}

//
// Configures every pin that CPU2's peripherals use.
//
// The GPIO mux registers (GPyMUX/GPyGMUX), pad config and qualification are
// writable only from CPU1 - a GPIO_setPinConfig() executed on CPU2 is
// silently discarded. GPIO_setControllerCore() hands over pin *data*
// ownership, not the right to mux. So CPU1 establishes the full pin
// configuration here, before releasing CPU2, and CPU2 then touches only its
// peripheral registers.
//
// Must be called before the GPxCSEL assignments and before CPU2 runs.
//
void BTS_HAL_setupCpu2Pins(void)
{
    //
    // I2CA (GPIO32/33) - host register command bus, unit is a target at 0x50.
    // Open-drain with pull-up and asynchronous qualification, as I2C requires.
    //
    GPIO_setPinConfig(GPIO_32_SDAA);
    GPIO_setPadConfig(32, GPIO_PIN_TYPE_OD | GPIO_PIN_TYPE_PULLUP);
    GPIO_setQualificationMode(32, GPIO_QUAL_ASYNC);
    GPIO_setPinConfig(GPIO_33_SCLA);
    GPIO_setPadConfig(33, GPIO_PIN_TYPE_OD | GPIO_PIN_TYPE_PULLUP);
    GPIO_setQualificationMode(33, GPIO_QUAL_ASYNC);

    //
    // I2CB (GPIO40/41) - calibration EEPROM at 0x50 plus the two ADS1119
    // temperature ADCs at 0x40 and 0x41.
    //
    GPIO_setPinConfig(GPIO_40_SDAB);
    GPIO_setPadConfig(40, GPIO_PIN_TYPE_OD | GPIO_PIN_TYPE_PULLUP);
    GPIO_setQualificationMode(40, GPIO_QUAL_ASYNC);
    GPIO_setPinConfig(GPIO_41_SCLB);
    GPIO_setPadConfig(41, GPIO_PIN_TYPE_OD | GPIO_PIN_TYPE_PULLUP);
    GPIO_setQualificationMode(41, GPIO_QUAL_ASYNC);

    //
    // ADS1119 DRDY inputs (GPIO42/43). Plain GPIO inputs - GPIO_42_GPIO42
    // and GPIO_43_GPIO43 select MUX=0/GMUX=0, which is GPIO mode. Routed to
    // XINT1/XINT2; CPU2 enables the interrupts once its I2C bus is idle.
    //
    GPIO_setPinConfig(GPIO_42_GPIO42);
    GPIO_setDirectionMode(42, GPIO_DIR_MODE_IN);
    GPIO_setPadConfig(42, GPIO_PIN_TYPE_PULLUP);
    GPIO_setQualificationMode(42, GPIO_QUAL_SYNC);

    GPIO_setPinConfig(GPIO_43_GPIO43);
    GPIO_setDirectionMode(43, GPIO_DIR_MODE_IN);
    GPIO_setPadConfig(43, GPIO_PIN_TYPE_PULLUP);
    GPIO_setQualificationMode(43, GPIO_QUAL_SYNC);

    //
    // CANA (GPIO30 = CANRXA, GPIO31 = CANTXA) - telemetry and register access.
    // Both are MUX=1/GMUX=0 in GPAMUX2. RX is asynchronous; TX gets a pull-up
    // so the bus idles recessive before the transceiver is driven.
    //
    GPIO_setPinConfig(GPIO_30_CANRXA);
    GPIO_setPadConfig(30, GPIO_PIN_TYPE_STD);
    GPIO_setQualificationMode(30, GPIO_QUAL_ASYNC);

    GPIO_setPinConfig(GPIO_31_CANTXA);
    GPIO_setPadConfig(31, GPIO_PIN_TYPE_PULLUP);
    GPIO_setQualificationMode(31, GPIO_QUAL_ASYNC);

    //
    // SCIA on GPIO29. In a debug build this is the AT console TX and GPIO28
    // is its RX; in production GPIO29 drives the WS2812B LED string and
    // GPIO28 belongs to CPU1 as channel 1's trip input.
    //
    GPIO_setPinConfig(GPIO_29_SCITXDA);
    GPIO_setPadConfig(29, GPIO_PIN_TYPE_STD);
    GPIO_setQualificationMode(29, GPIO_QUAL_ASYNC);

#if (BTS_CONSOLE_ENABLED == true)
    GPIO_setPinConfig(GPIO_28_SCIRXDA);
    GPIO_setPadConfig(28, GPIO_PIN_TYPE_PULLUP);
    GPIO_setQualificationMode(28, GPIO_QUAL_ASYNC);
#endif

    //
    // Heartbeat LED (GPIO47). Driven by CPU2 from its 8 Hz timer ISR, so it
    // reports the state of the core that owns the host interfaces: a stalled
    // CPU2 freezes the LED, which is the failure worth seeing.
    //
    GPIO_setPinConfig(BTS_RUN_LED_PIN_CONFIG);
    GPIO_setDirectionMode(BTS_RUN_LED_GPIO, GPIO_DIR_MODE_OUT);
    GPIO_setPadConfig(BTS_RUN_LED_GPIO, GPIO_PIN_TYPE_STD);
    GPIO_writePin(BTS_RUN_LED_GPIO, 0);
}

// Function to configure GPIO for trip input
//
// pinConfig is the packed mux encoding (e.g. GPIO_28_GPIO28) for
// GPIO_setPinConfig; pin is the bare pin number (e.g. 28) that every other
// GPIO API expects. Passing the encoding where a pin number is required
// trips driverlib's ASSERT(pin <= 168).
//
void BTS_HAL_setupTripGPIO(uint32_t pinConfig, uint32_t pin) {
    GPIO_setPinConfig(pinConfig);
    GPIO_setDirectionMode(pin, GPIO_DIR_MODE_IN);
    GPIO_setPadConfig(pin, GPIO_PIN_TYPE_STD);
    GPIO_setQualificationMode(pin, GPIO_QUAL_SYNC);
}

// Function to configure ePWM Trip Zone
//
// channel is 0-based and selects that slot's BTS_TRIP_HW_CHn_ENABLED setting.
// When a slot's hardware trip is disabled the trip SIGNALS are left masked,
// so neither the CMPSS comparator nor the GPIO input can reach this ePWM's
// one-shot latch. The trip ACTIONS are still programmed, because the software
// over-current path (BTS_tripEpwm) forces a trip through the same trip zone
// and must still bring the outputs low.
//
void BTS_HAL_setupEPWMTripZone(uint32_t epwmBase, uint16_t channel) {
    static const bool tripHwEnabled[8] = {
        BTS_TRIP_HW_CH1_ENABLED, BTS_TRIP_HW_CH2_ENABLED,
        BTS_TRIP_HW_CH3_ENABLED, BTS_TRIP_HW_CH4_ENABLED,
        BTS_TRIP_HW_CH5_ENABLED, BTS_TRIP_HW_CH6_ENABLED,
        BTS_TRIP_HW_CH7_ENABLED, BTS_TRIP_HW_CH8_ENABLED,
    };
    bool hwTrip = (channel < 8U) ? tripHwEnabled[channel] : false;

    EALLOW;
    if (hwTrip) {
        // Enable TZ1 (CMPSS) and TZ2 (GPIO AND group trip)
        EPWM_enableTripZoneSignals(epwmBase, EPWM_TZ_SIGNAL_OSHT1 | EPWM_TZ_SIGNAL_OSHT2);
    } else {
        //
        // Trip links are not wired on this slot. Mask both one-shot sources
        // so an unpowered, floating sense chain cannot latch a spurious
        // over-current at boot. See BTS_TRIP_HW_CHn_ENABLED in
        // bts_user_settings.h for what protection this gives up.
        //
        EPWM_disableTripZoneSignals(epwmBase, EPWM_TZ_SIGNAL_OSHT1 | EPWM_TZ_SIGNAL_OSHT2);
    }

    // Configure trip actions: force EPWMA and EPWMB low
    EPWM_setTripZoneAction(epwmBase, EPWM_TZ_ACTION_EVENT_TZA, EPWM_TZ_ACTION_LOW);
    EPWM_setTripZoneAction(epwmBase, EPWM_TZ_ACTION_EVENT_TZB, EPWM_TZ_ACTION_LOW);

    //
    // Clear anything latched while the trip sources were still being
    // configured, so a stale flag cannot re-enter the ISR the moment the
    // interrupt is enabled.
    //
    EPWM_clearOneShotTripZoneFlag(epwmBase,
                                  EPWM_TZ_OST_FLAG_OST1 | EPWM_TZ_OST_FLAG_OST2);
    EPWM_clearTripZoneFlag(epwmBase, EPWM_TZ_FLAG_OST | EPWM_TZ_INTERRUPT);

    //
    // The trip-zone interrupt is only useful when a hardware source can
    // raise it. The software trip path sets the flags itself and does not
    // rely on this ISR.
    //
    if (hwTrip) {
        // Enable trip zone interrupt
        EPWM_enableTripZoneInterrupt(epwmBase, EPWM_TZ_INTERRUPT_OST);
    } else {
        EPWM_disableTripZoneInterrupt(epwmBase, EPWM_TZ_INTERRUPT_OST);
    }
    EDIS;
}

// Function to configure all trip mechanisms
void BTS_HAL_setupTripSystem(void) {
    // Configure comparators (assuming COMP1-8 map to channels)
    // Map: A2->COMP1A, B2->COMP2B, A4->COMP3A, IN14->COMP4A, D0->COMP5D, C2->COMP6C, D2->COMP7D, C4->COMP8C

    // Configure CMPSS for each channel. The comparator input pin is fixed by
    // the device pinout; the trip level comes from the internal DAC.
    BTS_HAL_setupCMPSS(CMPSS1_BASE); // Channel 1
    BTS_HAL_setupCMPSS(CMPSS2_BASE); // Channel 2
    BTS_HAL_setupCMPSS(CMPSS3_BASE); // Channel 3
    BTS_HAL_setupCMPSS(CMPSS4_BASE); // Channel 4
    BTS_HAL_setupCMPSS(CMPSS5_BASE); // Channel 5
    BTS_HAL_setupCMPSS(CMPSS6_BASE); // Channel 6
    BTS_HAL_setupCMPSS(CMPSS7_BASE); // Channel 7
    BTS_HAL_setupCMPSS(CMPSS8_BASE); // Channel 8

    //
    // Route each channel's CMPSS trip to an ePWM X-BAR trip signal.
    //
    // The previous code pushed XBAR_OUT_MUX* constants into the *Input*
    // X-BAR, which interprets its argument as a GPIO pin number - so those
    // calls silently selected GPIO1, GPIO5, GPIO9, ... instead of wiring up
    // any comparator.
    //
    // Each route is gated on its slot's BTS_TRIP_HW_CHn_ENABLED. A slot whose
    // trip links are not wired leaves its X-BAR mux unconfigured, so nothing
    // drives the ePWM trip input even if the comparator itself latches.
    //
#if (BTS_TRIP_HW_CH1_ENABLED == true)
    BTS_HAL_setupCmpssEpwmXBAR(XBAR_TRIP4,  XBAR_EPWM_MUX00_CMPSS1_CTRIPH_OR_L, XBAR_MUX00);
#endif
#if (BTS_TRIP_HW_CH2_ENABLED == true)
    BTS_HAL_setupCmpssEpwmXBAR(XBAR_TRIP5,  XBAR_EPWM_MUX02_CMPSS2_CTRIPH_OR_L, XBAR_MUX02);
#endif
#if (BTS_TRIP_HW_CH3_ENABLED == true)
    BTS_HAL_setupCmpssEpwmXBAR(XBAR_TRIP7,  XBAR_EPWM_MUX04_CMPSS3_CTRIPH_OR_L, XBAR_MUX04);
#endif
#if (BTS_TRIP_HW_CH4_ENABLED == true)
    BTS_HAL_setupCmpssEpwmXBAR(XBAR_TRIP8,  XBAR_EPWM_MUX06_CMPSS4_CTRIPH_OR_L, XBAR_MUX06);
#endif
#if (BTS_TRIP_HW_CH5_ENABLED == true)
    BTS_HAL_setupCmpssEpwmXBAR(XBAR_TRIP9,  XBAR_EPWM_MUX08_CMPSS5_CTRIPH_OR_L, XBAR_MUX08);
#endif
#if (BTS_TRIP_HW_CH6_ENABLED == true)
    BTS_HAL_setupCmpssEpwmXBAR(XBAR_TRIP10, XBAR_EPWM_MUX10_CMPSS6_CTRIPH_OR_L, XBAR_MUX10);
#endif
#if (BTS_TRIP_HW_CH7_ENABLED == true)
    BTS_HAL_setupCmpssEpwmXBAR(XBAR_TRIP11, XBAR_EPWM_MUX12_CMPSS7_CTRIPH_OR_L, XBAR_MUX12);
#endif
#if (BTS_TRIP_HW_CH8_ENABLED == true)
    BTS_HAL_setupCmpssEpwmXBAR(XBAR_TRIP12, XBAR_EPWM_MUX14_CMPSS8_CTRIPH_OR_L, XBAR_MUX14);
#endif

    // Configure GPIOs for individual trips, group trip, and AND gate outputs
#if (BTS_TRIP_GPIO_CH1_ENABLED == true) && (BTS_TRIP_HW_CH1_ENABLED == true)
    BTS_HAL_setupTripGPIO(BTS_TRP_PIN_CONFIG_GPIO_CH1, BTS_TRP_PIN_GPIO_CH1);
#else
    //
    // GPIO28 is the debug console RX in this build - leave it to SCIA.
    // Channel 1 keeps its CMPSS over-current trip; only the GPIO trip
    // input is unavailable, and it is not physically connected here.
    //
#endif
#if (BTS_TRIP_HW_CH2_ENABLED == true)
    BTS_HAL_setupTripGPIO(BTS_TRP_PIN_CONFIG_GPIO_CH2, BTS_TRP_PIN_GPIO_CH2);
#endif
#if (BTS_TRIP_HW_CH3_ENABLED == true)
    BTS_HAL_setupTripGPIO(BTS_TRP_PIN_CONFIG_GPIO_CH3, BTS_TRP_PIN_GPIO_CH3);
#endif
#if (BTS_TRIP_HW_CH4_ENABLED == true)
    BTS_HAL_setupTripGPIO(BTS_TRP_PIN_CONFIG_GPIO_CH4, BTS_TRP_PIN_GPIO_CH4);
#endif
#if (BTS_TRIP_HW_CH5_ENABLED == true)
    BTS_HAL_setupTripGPIO(BTS_TRP_PIN_CONFIG_GPIO_CH5, BTS_TRP_PIN_GPIO_CH5);
#endif
#if (BTS_TRIP_HW_CH6_ENABLED == true)
    BTS_HAL_setupTripGPIO(BTS_TRP_PIN_CONFIG_GPIO_CH6, BTS_TRP_PIN_GPIO_CH6);
#endif
#if (BTS_TRIP_HW_CH7_ENABLED == true)
    BTS_HAL_setupTripGPIO(BTS_TRP_PIN_CONFIG_GPIO_CH7, BTS_TRP_PIN_GPIO_CH7);
#endif
#if (BTS_TRIP_HW_CH8_ENABLED == true)
    BTS_HAL_setupTripGPIO(BTS_TRP_PIN_CONFIG_GPIO_CH8, BTS_TRP_PIN_GPIO_CH8);
#endif

    //
    // Configure Input X-BAR for the GPIO trips.
    //
    // XBAR_setInputPin takes a bare pin number. Each X-BAR input can select
    // exactly one pin, so the eight trips need eight separate inputs -
    // INPUT9..INPUT16. The previous code assigned all eight to INPUT9, where
    // each call simply overwrote the last and only channel 8 survived.
    //
    // WARNING - this routing does not actually trip anything as written, and
    // is retained only so the pin assignments are not lost:
    //
    //   * The ePWM one-shot trip zones read TZ1/TZ2, which are hardwired to
    //     Input X-BAR INPUT1/INPUT2 - not INPUT9..16. Reaching the one-shot
    //     from INPUT9..12 (TRIPIN9..12) requires the Digital Compare
    //     submodule (DCTRIPSEL + setTripZoneDigitalCompareEventCondition),
    //     which this project never configures.
    //   * INPUT15 and INPUT16 do not exist on this device - it has INPUT1..14
    //     only. Those two calls are now rejected by the bounds check in
    //     BTS_HAL_setupInputXBAR() instead of writing past the register file.
    //
    // All of this is currently inert because every BTS_TRIP_HW_CHn_ENABLED is
    // false. Before re-enabling a hardware trip, wire TZ1/TZ2 (INPUT1/INPUT2)
    // or set up the Digital Compare path - and note INPUT1/INPUT2 default to
    // GPIO0, which is EPWM1A on this board.
    //
    // Input X-BAR allocation, since it is one device-global resource shared
    // by both cores and nothing else records who owns what:
    //
    //   INPUT4  XINT1  CPU2, ADS1119 DRDY1
    //   INPUT5  XINT2  CPU2, ADS1119 DRDY2
    //   INPUT6  XINT3  CPU1, external SPI ADC1 DRDY
    //   INPUT14 XINT5  CPU1, external SPI ADC2 DRDY
    //   INPUT9..14     GPIO trips ch1..ch6 (below, all currently compiled out)
    //
    // INPUT14 is therefore double-booked between XINT5 and the channel-6 GPIO
    // trip. Only one can win, and today the trips are disabled so it is XINT5.
    // Re-enabling the channel-6 hardware trip means moving one of them - the
    // free inputs are INPUT1, 2, 3, 7 and 8.
    //

    //
    // CPU2's two ADS1119 DRDY lines. These MUST be routed here, by CPU1: the
    // Input X-BAR is device-global and its select registers are writable only
    // from CPU1, so CPU2's GPIO_setInterruptPin(42/43, XINT1/2) configures the
    // XINT edge logic but never connects a pin to it.
    //
    // Without these two writes INPUT4SELECT and INPUT5SELECT stay at their
    // reset value of 0 (GPIO0), no DRDY edge ever reaches the PIE, CPU2's
    // acquisition state machine sits in eAdsIdle forever and every channel
    // reports 0.00 degrees C - while both converters still answer on I2C and
    // report "ok" at boot, which makes it look like a sensor fault.
    //
    // The allocation above has listed INPUT4/INPUT5 all along; only the
    // programming was missing.
    //
    BTS_HAL_setupInputXBAR(4, 0, 42U);   // XINT1 <- GPIO42, ADS1119 #1 DRDY
    BTS_HAL_setupInputXBAR(5, 0, 43U);   // XINT2 <- GPIO43, ADS1119 #2 DRDY
#if (BTS_TRIP_GPIO_CH1_ENABLED == true) && (BTS_TRIP_HW_CH1_ENABLED == true)
    BTS_HAL_setupInputXBAR(9,  0, BTS_TRP_PIN_GPIO_CH1);
#endif
#if (BTS_TRIP_HW_CH2_ENABLED == true)
    BTS_HAL_setupInputXBAR(10, 0, BTS_TRP_PIN_GPIO_CH2);
#endif
#if (BTS_TRIP_HW_CH3_ENABLED == true)
    BTS_HAL_setupInputXBAR(11, 0, BTS_TRP_PIN_GPIO_CH3);
#endif
#if (BTS_TRIP_HW_CH4_ENABLED == true)
    BTS_HAL_setupInputXBAR(12, 0, BTS_TRP_PIN_GPIO_CH4);
#endif
#if (BTS_TRIP_HW_CH5_ENABLED == true)
    BTS_HAL_setupInputXBAR(13, 0, BTS_TRP_PIN_GPIO_CH5);
#endif
#if (BTS_TRIP_HW_CH6_ENABLED == true)
    BTS_HAL_setupInputXBAR(14, 0, BTS_TRP_PIN_GPIO_CH6);
#endif
#if (BTS_TRIP_HW_CH7_ENABLED == true)
    BTS_HAL_setupInputXBAR(15, 0, BTS_TRP_PIN_GPIO_CH7);
#endif
#if (BTS_TRIP_HW_CH8_ENABLED == true)
    BTS_HAL_setupInputXBAR(16, 0, BTS_TRP_PIN_GPIO_CH8);
#endif

    // Configure Trip Zones for all ePWM modules
    for (uint16_t i = 1; i <= 8; i++) {
        uint32_t epwmBase = EPWM1_BASE + (i - 1) * 0x1000;
        BTS_HAL_setupEPWMTripZone(epwmBase, i - 1U);
    }
}

// Update BTS_HAL_setupADC
void BTS_HAL_setupADC(void)
{
    ADC_setPrescaler(ADCA_BASE, ADC_CLK_DIV_4_0);
    ADC_setPrescaler(ADCB_BASE, ADC_CLK_DIV_4_0);
    ADC_setPrescaler(ADCC_BASE, ADC_CLK_DIV_4_0);
    ADC_setPrescaler(ADCD_BASE, ADC_CLK_DIV_4_0);

    ADC_setMode(ADCA_BASE, ADC_RESOLUTION_12BIT, ADC_MODE_SINGLE_ENDED);
    ADC_setMode(ADCB_BASE, ADC_RESOLUTION_12BIT, ADC_MODE_SINGLE_ENDED);
    ADC_setMode(ADCC_BASE, ADC_RESOLUTION_12BIT, ADC_MODE_SINGLE_ENDED);
    ADC_setMode(ADCD_BASE, ADC_RESOLUTION_12BIT, ADC_MODE_SINGLE_ENDED);

    ADC_setSOCPriority(ADCA_BASE, ADC_PRI_ALL_ROUND_ROBIN);
    ADC_setSOCPriority(ADCB_BASE, ADC_PRI_ALL_ROUND_ROBIN);
    ADC_setSOCPriority(ADCC_BASE, ADC_PRI_ALL_ROUND_ROBIN);
    ADC_setSOCPriority(ADCD_BASE, ADC_PRI_ALL_ROUND_ROBIN);

    // Cell voltage: Ch1=A3, Ch2=B3, Ch3=A5, Ch4=IN15, Ch5=D1, Ch6=C3, Ch7=D3, Ch8=C5
    ADC_setupSOC(ADCA_BASE, ADC_SOC_NUMBER0, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN3, 15);
    ADC_setupSOC(ADCB_BASE, ADC_SOC_NUMBER0, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN3, 15);
    ADC_setupSOC(ADCA_BASE, ADC_SOC_NUMBER1, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN5, 15);
    ADC_setupSOC(ADCA_BASE, ADC_SOC_NUMBER2, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN15, 15);
    ADC_setupSOC(ADCD_BASE, ADC_SOC_NUMBER0, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN1, 15);
    ADC_setupSOC(ADCC_BASE, ADC_SOC_NUMBER0, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN3, 15);
    ADC_setupSOC(ADCD_BASE, ADC_SOC_NUMBER1, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN3, 15);
    ADC_setupSOC(ADCC_BASE, ADC_SOC_NUMBER1, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN5, 15);

    // Cell current: Ch1=A2, Ch2=B2, Ch3=A4, Ch4=IN14, Ch5=D0, Ch6=C2, Ch7=D2, Ch8=C4
    ADC_setupSOC(ADCA_BASE, ADC_SOC_NUMBER3, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN2, 15);
    ADC_setupSOC(ADCB_BASE, ADC_SOC_NUMBER3, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN2, 15);
    ADC_setupSOC(ADCA_BASE, ADC_SOC_NUMBER4, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN4, 15);
    ADC_setupSOC(ADCA_BASE, ADC_SOC_NUMBER5, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN14, 15);
    ADC_setupSOC(ADCD_BASE, ADC_SOC_NUMBER2, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN0, 15); // Note: D0 used here
    ADC_setupSOC(ADCC_BASE, ADC_SOC_NUMBER2, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN2, 15);
    ADC_setupSOC(ADCD_BASE, ADC_SOC_NUMBER3, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN2, 15);
    ADC_setupSOC(ADCC_BASE, ADC_SOC_NUMBER3, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN4, 15);

    // Reference: A0
    ADC_setupSOC(ADCA_BASE, ADC_SOC_NUMBER6, ADC_TRIGGER_EPWM1_SOCA, ADC_CH_ADCIN0, 15);

    // B0, B1 (software triggered)
    ADC_setupSOC(ADCB_BASE, ADC_SOC_NUMBER1, ADC_TRIGGER_SW_ONLY, ADC_CH_ADCIN0, 15);
    ADC_setupSOC(ADCB_BASE, ADC_SOC_NUMBER2, ADC_TRIGGER_SW_ONLY, ADC_CH_ADCIN1, 15);

    // ADC interrupt
    ADC_enableInterrupt(ADCA_BASE, ADC_INT_NUMBER1);
    ADC_clearInterruptStatus(ADCA_BASE, ADC_INT_NUMBER1);
    ADC_setInterruptSource(ADCA_BASE, ADC_INT_NUMBER1, ADC_SOC_NUMBER0);

    //
    // ADCB end-of-conversion flag for the software-triggered input-voltage
    // reads. updateInputVoltage() spins on this flag, so without a source
    // selected it can never assert and CPU1's whole background task loop
    // wedges on the first pass - taking the input-voltage guard, reverse
    // polarity check and group supervision down with it.
    //
    // This is a POLLED flag, not an interrupt. ADC_enableInterrupt() arms the
    // ADCINT1 flag *and* its route to PIE 1.2, and no ISR is registered for
    // INT_ADCB1 - so leaving 1.2 unmasked sends the first conversion into
    // driverlib's Interrupt_defaultHandler, an infinite loop, with PIE group
    // 1 never acknowledged. That takes ADCA1 down with it, which is the whole
    // cell-measurement path. Mask the PIE channel explicitly: the status flag
    // still sets and updateInputVoltage() still sees it.
    //
    ADC_enableInterrupt(ADCB_BASE, ADC_INT_NUMBER1);
    ADC_clearInterruptStatus(ADCB_BASE, ADC_INT_NUMBER1);
    ADC_setInterruptSource(ADCB_BASE, ADC_INT_NUMBER1, ADC_SOC_NUMBER2);
    Interrupt_disable(INT_ADCB1);

    //
    // ADCA INT2 - the CLA1 Task 1 trigger, and nothing else.
    //
    // Source is SOC6, the A0 reference channel and the last conversion in the
    // EPWM1 SOCA sweep, so by the time this flag sets every cell voltage and
    // current result register for this sample period has been written. The
    // CLA reads all seventeen results directly; sourcing the trigger any
    // earlier would have it read the previous sweep's tail.
    //
    // Deliberately independent of ADCA INT1, which drives adcCellVoltageISR
    // off SOC0 at the head of the same sweep. The two share no flag and no
    // acknowledge: the CLA path cannot delay the control path, and the
    // control path cannot starve the CLA.
    //
    // Interrupt_disable(INT_ADCA2) for the same reason the ADCB block above
    // masks PIE 1.2 - ADC_enableInterrupt() arms both the status flag and its
    // PIE route, and there is no C28x handler for ADCA2. The CLA takes its
    // trigger from the peripheral's interrupt signal via CLA1TASKSRCSEL, not
    // from the PIE, so masking the PIE channel costs nothing.
    //
    // Continuous mode so the flag pulses on every EOC whether or not it has
    // been cleared. Nothing on the C28x side ever clears ADCINT2, and the CLA
    // has no way to; without this the CLA would run exactly once.
    //
    ADC_enableInterrupt(ADCA_BASE, ADC_INT_NUMBER2);
    ADC_clearInterruptStatus(ADCA_BASE, ADC_INT_NUMBER2);
    ADC_setInterruptSource(ADCA_BASE, ADC_INT_NUMBER2, ADC_SOC_NUMBER6);
    ADC_enableContinuousMode(ADCA_BASE, ADC_INT_NUMBER2);
    Interrupt_disable(INT_ADCA2);

    //
    // Pulse ADCA's interrupt flags at end-of-CONVERSION, not the reset
    // default of end-of-acquisition-window.
    //
    // Required for the CLA: TI's cla_adc_fir32 example does the same, because
    // a task triggered at end-of-acquisition starts while the SAR is still
    // converting and reads the PREVIOUS sweep's result registers. With
    // continuous mode on INT2 that error would be invisible - every sample
    // would simply be one period stale, and the filter would hide it.
    //
    // This also moves ADCINT1, and therefore adcCellVoltageISR, one ADC
    // conversion later. That direction is strictly safer: the ISR currently
    // reads SOC0's result at end-of-acquisition, i.e. before the conversion
    // that produces it has latched. The shift is ~106 ns at 12-bit against a
    // 100 us sample period.
    //
    // ADCB/C/D keep the default. Their results are read by the CLA (which
    // reads them well after SOC6 on ADCA completes) or polled (ADCB INT1 for
    // the input voltage), so neither is timing-sensitive in this way.
    //
    ADC_setInterruptPulseMode(ADCA_BASE, ADC_PULSE_END_OF_CONV);

    ADC_enableConverter(ADCA_BASE);
    ADC_enableConverter(ADCB_BASE);
    ADC_enableConverter(ADCC_BASE);
    ADC_enableConverter(ADCD_BASE);
    DEVICE_DELAY_US(1000);
}

//
// ePWM1 SOCA - the cell V/I acquisition trigger for adcCellVoltageISR.
//
// EPWM1 is shared: it is both channel 1's switching leg and the ADC trigger
// source. Its period therefore belongs to the converter, NOT to the sample
// rate - BTS_HAL_setupSyncBuckPwm(BTS_EPWM_BASE_CH1) runs AFTER this
// function and sets TBPRD to BTS_DRV_EPWM_TBPRD (902 on this device), so
// anything written to TBPRD here is overwritten and has no effect.
//
// That is what used to happen: this function wrote TBPRD for a nominal
// 10 kHz, the PWM setup replaced it, and the ADC ended up triggering once
// per switching period. With EPWMCLK = SYSCLK/2 = 90 MHz and TBPRD 902 that
// is 90e6/903 = 99.67 kHz - ten times the documented intent, so
// adcCellVoltageISR ran every ~10 us and read all eight slots each time.
//
// The sample rate is set with the SOC event prescaler instead, which divides
// the trigger without touching the switching period:
//
//   99.67 kHz / BTS_ADC_SOC_PRESCALE(15) = 6.645 kSPS
//
// Verified on the live device, not derived from the headers: TBCTL 0x8010,
// TBPRD 902, ETPS 0x0820 (SOCPSSEL set), ETSOCPS 0x005F (SOCAPRD2 = 15),
// PERCLKDIVSEL 0x51. BTS_ADC_SOC_PRESCALE is 15 while its own comment block
// says 10, and SYSCLK is 180 MHz rather than 200 - see bts_cla_shared.h.
//
// Note TBCLK is EPWMCLK (SYSCLK/2), not SYSCLK - the old
// "DEVICE_SYSCLK_FREQ / 10000" form was doubly wrong for that reason too.
//
void BTS_HAL_setupAdcTrigger(uint32_t EPWM_BASE)
{
    //
    // Only the SOC configuration belongs here. Clock prescaler, period and
    // counter mode are the converter's and are set by
    // BTS_HAL_setupSyncBuckPwm().
    //
    EPWM_enableADCTrigger(EPWM_BASE, EPWM_SOC_A);
    EPWM_setADCTriggerSource(EPWM_BASE, EPWM_SOC_A, EPWM_SOC_TBCTR_ZERO);
    EPWM_setADCTriggerEventPrescale(EPWM_BASE, EPWM_SOC_A,
                                    BTS_ADC_SOC_PRESCALE);
}

void BTS_HAL_setupSfraClock(uint32_t EPWM_BASE)
{
    EPWM_setInterruptSource(EPWM_BASE, EPWM_INT_TBCTR_ZERO);

    EPWM_enableInterrupt(EPWM_BASE);
    EPWM_setInterruptEventCount(EPWM_BASE, 1U);
}

//
// Configures the ePWM sync chain so that grouped slots interleave.
//
// Must run with TBCLKSYNC off - i.e. between BTS_HAL_setupSyncBuckPwm() for
// all eight modules and BTS_HAL_enableEpwmCounting() - because the phase
// registers are only safely written while the time bases are stopped.
//
// On F2837xD the sync path is a hardwired daisy chain, EPWM1 -> 2 -> 3 ...,
// with no general crossbar. Rather than trying to make each group leader a
// sync source (which the chain cannot express for arbitrary groupings),
// EPWM1 is always the single master and every other module passes the pulse
// along. Group membership then only decides each module's phase offset.
//
// Phase is a plain fraction of the period: slot i of a group of k sits at
// i/k of a switching cycle, so a pair runs 180 degrees apart, a quad 90, and
// an octet 45. That is true interleaving rather than simply alternating.
//
// groupSize is passed in rather than derived from the mode so this stays a
// HAL function, with no knowledge of the register map.
//
void BTS_HAL_setupGroupPhase(uint16_t groupSize)
{
    uint16_t ch;

    if (groupSize == 0U) {
        groupSize = 1U;
    }

    for (ch = 0; ch < BTS_HAL_NUM_PWM_CHANNELS; ch++) {
        uint32_t epwmBase = EPWM1_BASE + (uint32_t)ch * (EPWM2_BASE - EPWM1_BASE);
        uint16_t idx      = (uint16_t)(ch % groupSize);
        uint16_t phase    = (uint16_t)(((uint32_t)BTS_DRV_EPWM_PERIOD_TICKS *
                                        (uint32_t)idx) / (uint32_t)groupSize);

        if (ch == 0U) {
            //
            // The master. It takes no phase of its own and generates the
            // pulse the rest of the chain follows.
            //
            EPWM_disablePhaseShiftLoad(epwmBase);
            EPWM_setSyncOutPulseMode(epwmBase,
                                     EPWM_SYNC_OUT_PULSE_ON_COUNTER_ZERO);
            continue;
        }

        //
        // Everything downstream forwards the master's pulse, so a module
        // late in the chain still sees it.
        //
        EPWM_setSyncOutPulseMode(epwmBase, EPWM_SYNC_OUT_PULSE_ON_EPWMxSYNCIN);

        if (groupSize == 1U) {
            //
            // Independent slots keep the original free-running behaviour;
            // mode 0 must remain identical to how the unit ran before
            // grouping existed.
            //
            EPWM_disablePhaseShiftLoad(epwmBase);
            continue;
        }

        EPWM_setPhaseShift(epwmBase, phase);
        EPWM_setTimeBaseCounter(epwmBase, phase);
        EPWM_setCountModeAfterSync(epwmBase, EPWM_COUNT_MODE_UP_AFTER_SYNC);
        EPWM_enablePhaseShiftLoad(epwmBase);
    }
}

void BTS_HAL_enableEpwmCounting(void)
{
    SysCtl_enablePeripheral(SYSCTL_PERIPH_CLK_TBCLKSYNC);
}

void BTS_HAL_disableEpwmCounting(void){

    SysCtl_disablePeripheral(SYSCTL_PERIPH_CLK_TBCLKSYNC);
}

void BTS_HAL_setupInterruptTrigger_Adc1(void)
{
    Interrupt_enable(BTS_SPI_DRDY_XINT_ADC1);
    SPI_clearInterruptStatus(BTS_SPI_BASE_ADC1, SPI_INT_RXFF );
    SPI_resetRxFIFO(BTS_SPI_BASE_ADC1);
    SPI_resetTxFIFO(BTS_SPI_BASE_ADC1);
    Interrupt_enable(BTS_SPI_DRDY_CINT_ADC1);

}

void BTS_HAL_setupInterruptTrigger_Adc2(void)
{
    Interrupt_enable(BTS_SPI_DRDY_XINT_ADC2);
    SPI_clearInterruptStatus(BTS_SPI_BASE_ADC2, SPI_INT_RXFF );
    SPI_resetRxFIFO(BTS_SPI_BASE_ADC2);
    SPI_resetTxFIFO(BTS_SPI_BASE_ADC2);
    Interrupt_enable(BTS_SPI_DRDY_CINT_ADC2);

}

void BTS_HAL_setupInterrupt_Adc1(void)
{
    SPI_clearInterruptStatus(BTS_SPI_BASE_ADC1, SPI_INT_RXFF );
    Interrupt_register(BTS_SPI_DRDY_XINT_ADC1, &BTS_DRDY_ADC1);
    Interrupt_register(BTS_SPI_DRDY_CINT_ADC1, &BTS_RXFIFO_SPI1);
}

void BTS_HAL_setupInterrupt_Adc2(void)
{
    SPI_clearInterruptStatus(BTS_SPI_BASE_ADC2, SPI_INT_RXFF );
    Interrupt_register(BTS_SPI_DRDY_XINT_ADC2, &BTS_DRDY_ADC2);
    Interrupt_register(BTS_SPI_DRDY_CINT_ADC2, &BTS_RXFIFO_SPI2);
}

void BTS_HAL_setupInterrupt(void)
{
    EALLOW;
    #if(BTS_SFRA_ENABLED == true) && (BTS_SFRA_ISR_SRC == BTS_SFRA_ISR_SRC_PWM)
    Interrupt_register(INT_EPWM1, &epwm1ISR);
    Interrupt_enable(INT_EPWM1);
#endif
    //
    // Trip ISR for EPWM1 to EPWM8. Trip zones raise INT_EPWMx_TZ (PIE group
    // 2), not INT_EPWMx (group 3, the counter/event interrupt SFRA uses).
    //
    // The constants must be listed, not computed. An INT_* value packs the
    // PIE vector ID in bits 31:16 and the group/channel in 15:0, so the
    // stride between INT_EPWM1_TZ and INT_EPWM2_TZ is 0x00010001 - adding
    // (i-1) bumps only the channel byte and leaves the vector ID at ePWM1's.
    // Interrupt_register() reads bits 31:16 alone, so all eight iterations
    // used to write the *same* vector, leaving 2.2-2.8 on
    // Interrupt_defaultHandler - an infinite loop. Interrupt_enable() reads
    // the other half of the word and was correct, so every trip was enabled
    // and seven of them pointed at a hang. Latent only because every
    // BTS_TRIP_HW_CHn_ENABLED is currently false.
    //
    static const uint32_t tzInts[8] = {
        INT_EPWM1_TZ, INT_EPWM2_TZ, INT_EPWM3_TZ, INT_EPWM4_TZ,
        INT_EPWM5_TZ, INT_EPWM6_TZ, INT_EPWM7_TZ, INT_EPWM8_TZ
    };
    for (uint16_t i = 0; i < 8U; i++) {
        Interrupt_register(tzInts[i], &epwmTripISR);
        Interrupt_enable(tzInts[i]);
    }
    EDIS;
}

//
// EINT is deliberately NOT in BTS_HAL_setupInterrupt(): the ADC is already
// converting and raising ADCINT1 by the time that runs (BTS_HAL_setupADC()
// arms the interrupt, BTS_HAL_setupAdcTrigger() starts ePWM1 driving SOCA),
// and adcCellVoltageISR is not registered until after it returns.
//
// Enabling interrupts in between let ADCINT1 fire against the still-default
// PIE vector. That vector is the driverlib illegal-operation handler, which
// is an infinite loop - so CPU1 vanished into it with PIE group 1 never
// acknowledged, blocking every group-1 interrupt from then on. The symptom
// was not a hang: the background tasks had already stopped, so the register
// file simply froze with stale internal-ADC values and a shorted slot still
// reporting 5.078 V.
//
void BTS_HAL_enableGlobalInterrupts(void)
{
    EALLOW;
    EINT;  // Enable Global interrupt INTM
    ERTM;  // Enable Global real-time interrupt DBGM
    EDIS;
}

void BTS_HAL_SetupSpi(uint32_t spiBase)
{
    //
    // Must put SPI into reset before configuring it
    //
    SPI_disableModule(spiBase);
    //
    // SPI configuration. Use a 1MHz SPICLK and 16-bit word size.
    //
    SPI_enableHighSpeedMode(spiBase);
    SPI_setConfig(spiBase, DEVICE_LSPCLK_FREQ, SPI_PROT_POL0PHA0,
                  SPI_MODE_MASTER, DEVICE_LSPCLK_FREQ / 4, 16); // working code uses 16 bit


    //SPI_enableLoopback(SPIA_BASE);
    SPI_setEmulationMode(spiBase, SPI_EMULATION_STOP_MIDWAY);
    SPI_enableFIFO(spiBase);

    SPI_clearInterruptStatus(spiBase, SPI_INT_RX_DATA_TX_EMPTY|SPI_INT_RXFF|SPI_INT_TXFF );

    SPI_setFIFOInterruptLevel(spiBase, SPI_FIFO_TX0, SPI_FIFO_RX10);

    SPI_enableInterrupt(spiBase, SPI_INT_RXFF|SPI_INT_TXFF);


    //
    // Configuration complete. Enable the module.
    //
    SPI_enableModule(spiBase);

   // uint32_t junk;
    //while(junk = SPI_readDataNonBlocking(SPIA_BASE));
}

void BTS_HAL_SetupSpiPinsGpio_Adc1(void){
    // configure SPI GPIO pins for SPIA

    GPIO_setQualificationMode(BTS_SPI_DIN_GPIO_ADC1,   GPIO_QUAL_ASYNC); // asynch input
    GPIO_setQualificationMode(BTS_SPI_DOUT_GPIO_ADC1,  GPIO_QUAL_ASYNC); // asynch input
    GPIO_setQualificationMode(BTS_SPI_RESET_GPIO_ADC1, GPIO_QUAL_ASYNC); // asynch input changed from 9 to 56
    GPIO_setQualificationMode(BTS_SPI_SCLK_GPIO_ADC1,  GPIO_QUAL_ASYNC); // asynch input //not used
    GPIO_setPinConfig(BTS_SPI_DIN_PIN_CONFIG_ADC1);            // GPIO16 = SPISIMOA
    GPIO_setPinConfig(BTS_SPI_DOUT_PIN_CONFIG_ADC1);           // GPIO17 = SPIS0MIA
    GPIO_setPinConfig(BTS_SPI_SCLK_PIN_CONFIG_ADC1);           // GPIO18 = SPICLKA

    // cs bar for SPIA
    GPIO_setPadConfig(BTS_SPI_CS_GPIO_ADC1, GPIO_PIN_TYPE_PULLUP);     // Enable pullup on GPIO6
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC1, 1);                            // Load output latch
    GPIO_setPinConfig(BTS_SPI_CS_PIN_CONFIG_ADC1);                     // GPIO6 = GPIO6
    GPIO_setDirectionMode(BTS_SPI_CS_GPIO_ADC1, GPIO_DIR_MODE_OUT);    // GPIO6 = output
}

void BTS_HAL_SetupSpiPinsGpio_Adc2(void){
    // configure SPI GPIO pins for SPIA

    GPIO_setQualificationMode(BTS_SPI_DIN_GPIO_ADC2,   GPIO_QUAL_ASYNC); // asynch input
    GPIO_setQualificationMode(BTS_SPI_DOUT_GPIO_ADC2,  GPIO_QUAL_ASYNC); // asynch input
    GPIO_setQualificationMode(BTS_SPI_RESET_GPIO_ADC2, GPIO_QUAL_ASYNC); // asynch input changed from 9 to 56
    GPIO_setQualificationMode(BTS_SPI_SCLK_GPIO_ADC2,  GPIO_QUAL_ASYNC); // asynch input //not used
    GPIO_setPinConfig(BTS_SPI_DIN_PIN_CONFIG_ADC2);            // GPIO50 = SPISIMOC
    GPIO_setPinConfig(BTS_SPI_DOUT_PIN_CONFIG_ADC2);           // GPIO51 = SPISOMIC
    GPIO_setPinConfig(BTS_SPI_SCLK_PIN_CONFIG_ADC2);           // GPIO52 = SPICLKC

    // cs bar for SPIA
    GPIO_setPadConfig(BTS_SPI_CS_GPIO_ADC2, GPIO_PIN_TYPE_PULLUP);     // Enable pullup on GPIO6
    GPIO_writePin(BTS_SPI_CS_GPIO_ADC2, 1);                            // Load output latch
    GPIO_setPinConfig(BTS_SPI_CS_PIN_CONFIG_ADC2);                     // GPIO6 = GPIO6
    GPIO_setDirectionMode(BTS_SPI_CS_GPIO_ADC2, GPIO_DIR_MODE_OUT);    // GPIO6 = output
}

//
// End of buck_hal.c
//
