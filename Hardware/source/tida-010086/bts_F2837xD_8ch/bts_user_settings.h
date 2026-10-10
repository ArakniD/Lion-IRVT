/*
 * bts_settings.h
 *
 *  Created on: Aug 11, 2020
 *      Author: a0230328
 */
//custom settings

#ifndef BTS_USER_SETTINGS_H_
#define BTS_USER_SETTINGS_H_

#include "bts_user_calibration.h"

//
//=============================================================================
// Build mode: GPIO28/29 role selection
//=============================================================================
//
// GPIO28 and GPIO29 are physically shared between three functions, so the
// build has to choose. BTS_DEBUG_CONSOLE selects which:
//
//   BTS_DEBUG_CONSOLE == true   (bench debug)
//     GPIO28 = SCIRXDA, GPIO29 = SCITXDA. The AT command console runs on
//     SCIA, reachable over the TMDSCNCD28379D's isolated FTDI backchannel -
//     the COM port that enumerates on the same USB cable as the XDS100v2.
//     Channel 1's GPIO trip input shares GPIO28 and is therefore disabled;
//     it is not physically connected in this configuration. The WS2812B
//     LED string is disabled too, as it needs GPIO29.
//
//   BTS_DEBUG_CONSOLE == false  (production)
//     GPIO28 = channel 1 GPIO trip input (digital in).
//     GPIO29 = SCITXDA, idle. The AT command console is not available in
//     this build - there is no free SCI port for it, so the host uses I2C
//     or CAN.
//
// SCIB is not an alternative: GPIO18 is SPICLKA and GPIO19 is the ADC1 chip
// select for the external 24-bit SPI ADCs.
//
// Channel 1 keeps its CMPSS over-current trip in both modes. Only the
// separate GPIO trip input is affected.
//
// PRODUCTION since 2026-10-02. The AT console moved to the ESP32, which
// serves the same grammar over I2C (see Docs/at-command-specification.md).
//
// THE LED STRING ALSO MOVED TO THE ESP32, 2026-10-02, and the SCIA driver
// that used to feed it is permanently off - see BTS_LED_DRIVER_ENABLED.
//
#define BTS_DEBUG_CONSOLE (false)

//
// BTS_LED_DRIVER_ENABLED IS FALSE IN BOTH ARMS AND SHOULD STAY THAT WAY.
//
// The WS2812B string is driven by the ESP32 now, over SPI3 on its GPIO13.
// The C2000 driver that used to do it could never have worked: it clocked
// raw colour bytes out of SCIA at 800 kbaud, but a WS2812B decodes pulse
// WIDTHS - 400 ns high is a 0, 800 ns high is a 1 - and a UART cannot
// produce them. It forces a LOW start bit before every byte and holds each
// data bit for a full 1250 ns bit time, so the strip saw framing noise and
// latched nothing. No pixel ever lit from this core.
//
// Driving it properly needs a peripheral that can emit a free-running bit
// pattern, which here means SPI. GPIO29 - the wire that is physically
// present - has no SPI mux option (GPIO, SCITXDA, EM1SDCKE, OUTPUTXBAR6,
// EQEP3B, SD2_C3), and both usable SPI ports are held by the ADS131M08
// pair. Hence the move. See esp32-btle-proxy/components/led_strip/.
//
// Setting this true again re-enables dead code AND hands SCIA to it, so do
// not do it to get the console back - use BTS_DEBUG_CONSOLE for that.
//
#if (BTS_DEBUG_CONSOLE == true)
    //
    // Bench debug: SCIA carries the AT console on the FTDI backchannel.
    //
    #define BTS_CONSOLE_ENABLED       (true)
    #define BTS_CONSOLE_SCI_BASE      SCIA_BASE
    #define BTS_CONSOLE_TX_PINCONFIG  GPIO_29_SCITXDA
    #define BTS_CONSOLE_RX_PINCONFIG  GPIO_28_SCIRXDA
    #define BTS_CONSOLE_RX_INT        INT_SCIA_RX
    // The FTDI backchannel is a standard 115200 8N1 port.
    #define BTS_CONSOLE_BAUDRATE      ((uint32_t)115200)

    // GPIO29 is the console TX, so the LED string cannot have it.
    #define BTS_LED_DRIVER_ENABLED    (false)
#else
    //
    // Production: no console. GPIO29 is left muxed to SCITXDA and idle -
    // the LED string it used to feed is driven by the ESP32 now.
    //
    #define BTS_CONSOLE_ENABLED       (false)
    #define BTS_LED_DRIVER_ENABLED    (false)
#endif

#define BTS_ENABLE_DETECT_CODE (false)

//
//=============================================================================
// External GPIO trip inputs (per slot) - NOT FITTED ON THIS BOARD
//=============================================================================
//
// The board has no external trip line wired to any slot, so every one of
// these is false and stays false. The only hardware trip is each slot's CMPSS
// over-current comparator - BTS_TRIP_HW_CHn_ENABLED below.
//
// These were not separate switches until 2026-10-09. The GPIO pin setup and
// the Input X-BAR routing were compiled in for every slot whose
// BTS_TRIP_HW_CHn_ENABLED was true, so enabling the comparators also
// configured eight GPIO trip inputs that go nowhere - and one of them,
// channel 6's INPUT14 <- GPIO44, collides with CPU1's slot 5-8 acquisition
// DRDY (XINT5, INPUT14 <- GPIO49). Acquisition happened to be configured
// later and won, so nothing broke, but only by ordering.
//
// A later board revision may fit the lines. Before setting any of these true:
//
//   * The one-shot inputs read TZ1/TZ2 (Input X-BAR INPUT1/INPUT2), not the
//     INPUT9..INPUT14 the routing in BTS_HAL_setupTripSystem() uses. A GPIO
//     trip has to reach the trip zone through Digital Compare (DCBH, say),
//     as the comparators do - see BTS_HAL_setupEPWMTripZone().
//   * Channel 6's INPUT14 must move first: INPUT7 and INPUT8 are free.
//   * Channels 7 and 8 have no input at all - INPUT15/16 do not exist.
//   * Channel 1's pin, GPIO28, is the debug console RX.
//
// Each still requires that slot's BTS_TRIP_HW_CHn_ENABLED as well.
//
#define BTS_TRIP_GPIO_CH1_ENABLED (false)
#define BTS_TRIP_GPIO_CH2_ENABLED (false)
#define BTS_TRIP_GPIO_CH3_ENABLED (false)
#define BTS_TRIP_GPIO_CH4_ENABLED (false)
#define BTS_TRIP_GPIO_CH5_ENABLED (false)
#define BTS_TRIP_GPIO_CH6_ENABLED (false)
#define BTS_TRIP_GPIO_CH7_ENABLED (false)
#define BTS_TRIP_GPIO_CH8_ENABLED (false)

//
//=============================================================================
// Hardware trip lines (per slot)
//=============================================================================
//
// Each slot's CMPSS over-current comparator reaches its ePWM trip zone and
// latches the PWM low within a switching cycle. Enabled here; the routing is
// built by BTS_HAL_setupTripRouting() and armed by BTS_HAL_armTripZones().
//
// THESE ENABLE THE COMPARATOR TRIPS ONLY. The external GPIO trip inputs are
// not fitted on this board and have their own switches, all false - see
// BTS_TRIP_GPIO_CHn_ENABLED above. The one-shot inputs they would arrive on
// (OSHT1/OSHT2) stay masked either way.
//
// HOW THE COMPARATOR REACHES THE TRIP ZONE, because the obvious route does
// not work. The one-shot inputs OSHT1/OSHT2 read TZ1/TZ2, which are hardwired
// to Input X-BAR INPUT1/INPUT2 (see XBAR_InputNum in xbar.h) - not to the
// ePWM X-BAR where the comparators actually arrive. Nothing in this project
// writes INPUT1SELECT/INPUT2SELECT, so both sat at their reset default of
// GPIO0, which this board muxes as EPWM1A (BTS_EPWM_H_PIN_CONFIG_EPWM_CH1):
// channel 1's trip zones were watching channel 1's own high-side gate drive
// and latched OST1+OST2 the instant the converter switched. That is the
// observed EPwm1Regs.TZOSTFLG = 0x0003 which re-asserted immediately after
// every TZCLR write.
//
// The comparators now reach the trip zones through the DIGITAL COMPARE
// submodule instead, which is the path the ePWM X-BAR outputs TRIP4..TRIP12
// actually feed. DCAEVT1 is a one-shot, so the latching behaviour is the
// same; only the route differs. INPUT1/INPUT2 are left alone.
//
// TRIP LEVEL is BTS_CMPSS_TRIP_A (9.5 A), deliberately ABOVE the software
// limit of 8 A - see the layering note at that definition. The software trip
// in BTS_tripEpwm() remains the first line and still requires BTS_OCP_TRIGGER.
//
// ARMING IS DEFERRED, and this matters. An unpowered current-sense chain
// outputs ~0 V, which on a 1.25 V-centred chain reads as -10 A and trips the
// low comparator. Arming at boot would therefore latch an over-current on
// every slot before the board did anything. serviceTripArming() in bts_cpu1.c
// arms the zones once a slot is actually commanded to run and disarms when
// the last one stops.
//
// A slot the ENABLE strap masks off is left out of its group's trip OR
// entirely, for the same reason - its sense chain is never powered.
//
#define BTS_TRIP_HW_CH1_ENABLED (true)
#define BTS_TRIP_HW_CH2_ENABLED (true)
#define BTS_TRIP_HW_CH3_ENABLED (true)
#define BTS_TRIP_HW_CH4_ENABLED (true)
#define BTS_TRIP_HW_CH5_ENABLED (true)
#define BTS_TRIP_HW_CH6_ENABLED (true)
#define BTS_TRIP_HW_CH7_ENABLED (true)
#define BTS_TRIP_HW_CH8_ENABLED (true)

//
// True when at least one slot still wants a hardware trip. Used to decide
// whether the trip ISR and the shared X-BAR plumbing are worth configuring.
//
#define BTS_TRIP_HW_ANY_ENABLED                                           \
    (BTS_TRIP_HW_CH1_ENABLED || BTS_TRIP_HW_CH2_ENABLED ||                \
     BTS_TRIP_HW_CH3_ENABLED || BTS_TRIP_HW_CH4_ENABLED ||                \
     BTS_TRIP_HW_CH5_ENABLED || BTS_TRIP_HW_CH6_ENABLED ||                \
     BTS_TRIP_HW_CH7_ENABLED || BTS_TRIP_HW_CH8_ENABLED)
//
//=============================================================================
// Internal-ADC (C2000) cell voltage / current calibration defaults
//=============================================================================
//
// These seed BTS_userInputs[].F28*_Gain/Offset at init so a cell-voltage
// reading is never silently multiplied by a zero gain while waiting for the
// EEPROM calibration to arrive over IPC.
//
// Keep these in step with DEFAULT_F28V_GAIN / DEFAULT_F28V_OFFSET /
// DEFAULT_F28I_GAIN / DEFAULT_F28I_OFFSET in com_cpu2.c, which are what CPU2
// writes into registers[] when a channel has no valid stored calibration.
// BTS_monitor_Iout_Vout() converts counts to volts via
// (sum / (avgFactor * 4096)) * 2.5, which yields VOLTS AT THE ADC PIN. The
// cell sits behind a ~2.412:1 resistive divider, so the gain is what turns a
// pin voltage back into a cell voltage.
//
// THIS WAS 1.0 AND THAT WAS WRONG. Unity gain does not mean "uncorrected" in
// any useful sense - it means the divider is never undone, so every host read
// the pin voltage while the register was named for the cell. Measured on
// hardware 2026-10-02: a 3.492 V cell reported as 1.45 V. The error is not
// cosmetic, because a discharge cut-off is compared against this number: at a
// 2.5 V floor the slot reads as already empty while the cell is still full.
//
// Note validateCalibration() in com_cpu2.c accepts an F28V_Gain in 2.0..3.0.
// That band used to be 0.5..2.0, which could not express 2.412 at all while
// admitting the wrong default of 1.0.
//
#define BTS_F28V_GAIN_DEFAULT             ((float32_t)2.4121)
#define BTS_F28V_OFFSET_DEFAULT           ((float32_t)0.0)
//
// Default current gain for the on-chip ADC path.
//
// The sense chain is centred on the external 1.25 V reference (ADC-A0):
//   0.00 V at pin -> -10 A,  1.25 V -> 0 A,  2.50 V -> +10 A
//
// adcCellVoltageISR() already subtracts the A0 reference, so Sum_CellI
// carries (Vpin - 1.25 V) in counts, and BTS_monitor_Iout_Vout() forms
//   avgValue = Sum_CellI / (N * 4096),  CellCurrent_I = avgValue * 2.5 * gain
//
// At +10 A the delta is +1.25 V. With VREFHI measured at 3.019 V (derived
// from A0 = 1696 counts) that is 1696 counts, so avgValue * 2.5 = 1.0351.
// The gain that maps it to 10 A is therefore 10 / 1.0351 = 9.66.
//
// A gain of 1.0 - the old default - reported 1.035 A at a true 10 A, i.e.
// ~9.7x low. That is exactly the discrepancy seen during the 1 A charge
// test, where the host register read 0.106 A against the ADS131M08's 0.995 A.
//
// This is a nominal default for an uncalibrated slot; a runtime calibration
// still overrides it per channel.
//
#define BTS_F28I_GAIN_DEFAULT             ((float32_t)9.66)
#define BTS_F28I_OFFSET_DEFAULT           ((float32_t)0.0)

//
// All eight control blocks are compiled in. Which slots actually run is a
// runtime decision taken from the ENABLE dip switch (see startup_enable and
// BTS_SLOT_ENABLED in registers.h) - a slot the strap masks off is held with
// its PWM down rather than being absent from the binary.
//
#define BTS_ENABLE_CH1 (true)
#define BTS_ENABLE_CH2 (true)
#define BTS_ENABLE_CH3 (true)
#define BTS_ENABLE_CH4 (true)
#define BTS_ENABLE_CH5 (true)
#define BTS_ENABLE_CH6 (true)
#define BTS_ENABLE_CH7 (true)
#define BTS_ENABLE_CH8 (true)

//
//=============================================================================
// Slot grouping supervision
//=============================================================================
//
// In a grouped mode only the lowest-numbered slot closes the control loop;
// the rest mirror its duty. Each follower's own internal-ADC voltage is
// compared against the leader's, so a cell that falls out of the group -
// disconnected, or simply drifting - is caught and the whole group stopped.
//
// The tolerance is a percentage of the leader's voltage with an absolute
// floor, because a pure percentage collapses to nothing near 0 V.
//
#define BTS_GROUP_VDIFF_PCT               ((float32_t)0.10)   // 10 % of leader
#define BTS_GROUP_VDIFF_FLOOR_V           ((float32_t)0.20)   // never tighter than this
//
// Consecutive C1 passes out of tolerance before the group is faulted. C1
// runs every third 20 Hz tick, so 5 passes is roughly 750 ms.
//
#define BTS_GROUP_VDIFF_DEBOUNCE          ((uint16_t)5)
//
// A cell voltage below this is wired backwards. Negative enough to be
// unambiguous rather than measurement noise around zero.
//
#define BTS_REVERSE_POLARITY_V            ((float32_t)-0.10)

#define BTS_TRIP_CODE   (true)
//
// Software over-current trip, evaluated in BTS_tripEpwm() every control pass
// against ioutTrip_16b / ioutTrip_n_16b (+/-BTS_USER_DEFAULT_TRIP_A).
//
// This is the FIRST line of over-current defence, not a fallback. It fires at
// BTS_USER_DEFAULT_TRIP_A (8 A) while the CMPSS comparator sits above it at
// BTS_CMPSS_TRIP_A (9.5 A), so in normal operation this catches the fault and
// the hardware trip never fires. The comparator is there for what a control
// period is too slow for - a genuine short.
//
// It must therefore stay true. Leaving it false would push every over-current
// onto the hardware trip, which is a harsher stop: the comparator latches the
// PWM low in hardware rather than bringing the reference down.
//
// It matters even more while a slot's trips are unarmed. serviceTripArming()
// only arms the comparators once a slot is running, and an ENABLE-strapped-off
// slot is never armed at all, so this is the only protection those slots have.
//
#define BTS_OCP_TRIGGER (true)
#define BTS_USER_DEFAULT_TRIP_A           ((float32_t)8)

//
//=============================================================================
// CMPSS over-current trip thresholds
//=============================================================================
//
// Each channel's current-sense signal is presented to a CMPSS comparator on
// an ADC input pin. The comparator compares that pin against the module's
// internal 12-bit DAC, so the trip level is expressed as a DAC count.
//
// SIGNAL SCALING - and the correction this block used to get wrong.
//
// The IoutS1-8 sense signals come from instrumentation amplifiers whose
// common-mode voltage is 1.25 V, so ZERO CURRENT SITS AT 1.25 V, not at the
// DAC's mid-scale. The chain spans +/-10 A across 0 V to 2.50 V:
//
//   0.00 V -> -10 A      1.25 V -> 0 A      2.50 V -> +10 A
//
// which is 0.125 V per amp. This is the same scaling the on-chip ADC path
// uses and states at BTS_F28I_GAIN_DEFAULT above, measured on hardware
// 2026-09-21 - the two must agree, because they are the same physical signal.
//
// The DAC reference is VDDA, which on this controlCARD is the REF5030's
// 3.0 V rail - measured 3.019 V from A0 reading 1696 counts. The ADC and the
// CMPSS DAC therefore share a reference, which is why a count computed here
// is directly comparable with an ADC result.
//
//   count(I) = (1.25 V + I * 0.125 V/A) / VREF * 4095
//
// WHAT THIS REPLACED, because the error was not a small one: the previous
// form assumed 0 A at DAC mid-scale (2048) and derived counts-per-amp from
// mid-scale / 10 A. That put +8 A at 3686 counts, which against a 3.019 V
// reference is 2.718 V at the pin - a level the sense chain reaches only at
// +11.7 A, past its own full scale. THE HIGH-SIDE TRIP WAS UNREACHABLE. The
// low side fared better but was still wrong: 410 counts is 0.302 V, which is
// -7.6 A rather than -8 A.
//
// The error was invisible because every BTS_TRIP_HW_CHn_ENABLED was false,
// so the thresholds were computed, written to the DAC, and never consulted.
//
#define BTS_CMPSS_DAC_MAX                 ((float32_t)4095)

//
// Sense-chain transfer function. BTS_CMPSS_ZERO_A_V is the instrumentation
// amplifier's common mode; volts-per-amp follows from it and full scale.
//
#define BTS_CMPSS_ZERO_A_V                ((float32_t)1.25)
#define BTS_CMPSS_FULLSCALE_A             ((float32_t)10)
#define BTS_CMPSS_VOLTS_PER_A             (BTS_CMPSS_ZERO_A_V / BTS_CMPSS_FULLSCALE_A)

//
// DAC reference. Measured, not nominal - see BTS_VIN_REF_VOLTS below for the
// same 3.019 V figure derived independently from the A0 reference reading.
//
#define BTS_CMPSS_VREF_V                  ((float32_t)3.019)
#define BTS_CMPSS_COUNTS_PER_V            (BTS_CMPSS_DAC_MAX / BTS_CMPSS_VREF_V)

// Clamp so an over-large trip setting cannot wrap the 12-bit field.
#define BTS_CMPSS_CLAMP(x)                                                    \
    ((x) < (float32_t)0 ? (float32_t)0 :                                      \
    ((x) > BTS_CMPSS_DAC_MAX ? BTS_CMPSS_DAC_MAX : (x)))

//
// Signed current to DAC count. The high comparator takes the positive trip
// and the low comparator the negative one, so the sign is applied by these
// two wrappers rather than passed in by the caller.
//
#define BTS_CMPSS_DAC_COUNT(amps)                                             \
    ((uint16_t)BTS_CMPSS_CLAMP((BTS_CMPSS_ZERO_A_V +                          \
                                (amps) * BTS_CMPSS_VOLTS_PER_A) *             \
                               BTS_CMPSS_COUNTS_PER_V))

#define BTS_CMPSS_DAC_HIGH_COUNT(amps)    BTS_CMPSS_DAC_COUNT(amps)
#define BTS_CMPSS_DAC_LOW_COUNT(amps)     BTS_CMPSS_DAC_COUNT(-(amps))

//
// HARDWARE TRIP LEVEL - deliberately ABOVE the software trip.
//
// The two protections are layered rather than duplicated:
//
//   BTS_USER_DEFAULT_TRIP_A  8.0 A   software, acts within a control period
//   BTS_CMPSS_TRIP_A         9.5 A   hardware, acts within a switching cycle
//   BTS_CMPSS_FULLSCALE_A   10.0 A   sense chain full scale
//
// In normal operation BTS_tripEpwm() catches an over-current first and the
// comparator never fires. The comparator exists for what software is too slow
// for - a genuine short, where the current is past 9.5 A long before the next
// control pass. Setting the two equal would let the hardware win every race
// and leave the software path, and its diagnostics, untested.
//
// 0.5 A of headroom remains below full scale, so the threshold is reachable
// with margin for sense-chain and DAC tolerance.
//
#define BTS_CMPSS_TRIP_A                  ((float32_t)9.5)

// +9.5 A -> 2.4375 V -> 3306 counts;  -9.5 A -> 0.0625 V -> 84 counts.
#define BTS_CMPSS_TRIP_HIGH               BTS_CMPSS_DAC_HIGH_COUNT(BTS_CMPSS_TRIP_A)
#define BTS_CMPSS_TRIP_LOW                BTS_CMPSS_DAC_LOW_COUNT(BTS_CMPSS_TRIP_A)

// Add new averaging factor for F28 ADC
#define BTS_f28AverageFactor 8  // Smaller factor for faster response

#define BTS_USER_DEFAULT_TRIP_pu (BTS_IoutGain_ch1_pu *BTS_USER_DEFAULT_TRIP_A +BTS_IoutOffset_ch1_pu)
#define BTS_USER_DEFAULT_TRIP_16b ((int16_t)(BTS_USER_DEFAULT_TRIP_pu *(float32_t)32768.0))
#define BTS_USER_DEFAULT_TRIP_N_16b (-1*BTS_USER_DEFAULT_TRIP_16b)

#define BTS_USER_TRIP_pu(x)     (BTS_userInputs[i].IoutGain_pu *BTS_USER_DEFAULT_TRIP_A + BTS_userInputs[i].IoutOffset_pu)
#define BTS_USER_TRIP_16b(x)    ((int16_t)(BTS_USER_TRIP_pu(x) *(float32_t)32768.0))
#define BTS_USER_TRIP_N_16b(x)  (((int16_t)-1)*BTS_USER_TRIP_16b(x))

//
//=============================================================================
// Pre-charge balance (ToDo 08)
//=============================================================================
//
// A cell is seated onto a rail that has been driven to match it, so the
// contact closes across near-zero volts instead of dumping the cell into a
// flat output capacitor.
//
// WHY THE CURRENT READING IS THE INSERTION TEST
// ---------------------------------------------
// The output capacitors sit AFTER the current sense resistor, so the shunt
// only sees current the switching FETs produce - never charge moving between
// the cell and the rail through the contacts. That is what makes the
// sequence decidable:
//
//   balanced, no cell   voltages match AND current is zero
//   cell inserted       voltages match AND current is NOT zero
//
// Without that placement the two conditions would be indistinguishable.

//
// ADS reading above which a cell is considered to be approaching. Below it a
// slot is empty and the sequence re-arms.
//
#define BTS_INSERT_DETECT_V          ((float32_t)0.25)

//
// How closely the two paths must agree to call the rail balanced, as a
// fraction of the ADS reading. The brief's 10%.
//
#define BTS_BALANCE_TOL_FRAC         ((float32_t)0.10)

//
// Absolute floor on that tolerance, so a near-zero ADS reading does not
// demand an impossibly tight match - 10% of 0.3 V is 30 mV, which is inside
// the noise of a 12-bit converter on a 2.5 V reference.
//
#define BTS_BALANCE_TOL_MIN_V        ((float32_t)0.050)

//
// Current below which the rail is considered unloaded, i.e. no cell bridging
// the contacts yet.
//
#define BTS_BALANCE_ZERO_I_A         ((float32_t)0.050)

//
// Divergence between the two paths that faults a RUNNING slot, as a fraction.
// The brief's 20%.
//
#define BTS_DIVERGE_FAULT_FRAC       ((float32_t)0.20)

//
// Consecutive supervisor passes a condition must hold. The supervisor runs in
// B1 at TASKB_FREQ_HZ/3, so this is a few tens of milliseconds - long enough
// to reject a single noisy sample, short enough to catch a real insertion.
//
#define BTS_BALANCE_DWELL_PASSES     ((uint16_t)3)

//
// Supervisor passes BALANCING may run before giving up and faulting.
//
#define BTS_BALANCE_TIMEOUT_PASSES   ((uint16_t)500)

//
// Soft-start attempts before the slot faults. Per the brief: 40.
//
#define BTS_SOFT_START_MAX_RETRIES   ((uint16_t)40)

//
// Supervisor passes to hold off after a trip during soft start, ~100 ms.
//
#define BTS_SOFT_START_RETRY_PASSES  ((uint16_t)7)

//
// Supervisor passes soft start may run before it is deemed failed and retried.
//
#define BTS_SOFT_START_TIMEOUT_PASSES ((uint16_t)200)

//
// Duty increment per control-ISR pass while balancing. The ISR runs at the
// ADS131M08 sample rate, so a step this small still converges in well under
// a second while keeping the rail's rate of change gentle.
//
#define BTS_BALANCE_DUTY_STEP_PU     ((float32_t)0.0002)

//
// Duty ceiling while balancing. Charging an output capacitor needs very
// little, and a low ceiling bounds the current a bad differential could ask
// for. Well below BTS_DUTY_SET_MAX_PU.
//
#define BTS_BALANCE_DUTY_MAX_PU      ((float32_t)0.15)

#define BTS_SFRA_MODE_CC_PLANT  0
#define BTS_SFRA_MODE_CC_CLOSED 1

//
// Whether the SFRA library is COMPILED IN.
//
// This stays a build switch: the library, its five sweep arrays and the GUI
// serial comms are real flash and RAM, and a production unit has no reason
// to carry them. What is no longer a build switch is whether a sweep RUNS -
// that is selected by the MODE straps at boot (modes 6 and 7) and tested
// through BTS_SFRA_IS_ACTIVE(). A tuning binary strapped to a normal mode
// behaves exactly like a production one.
//
// SELECTED BY THE BUILD CONFIGURATION, not by editing this line. The
// "cpu1_sfra" configuration passes --define=BTS_SFRA_BUILD=1; "cpu1" does
// not. Both are flash builds and are otherwise identical, so a tuning image
// and a production image can be produced from one source tree without a
// working-tree change between them.
//
// Overriding on the command line works too: -DBTS_SFRA_BUILD=1.
//
#ifndef BTS_SFRA_BUILD
#define BTS_SFRA_BUILD 0
#endif

#if (BTS_SFRA_BUILD != 0)
#define BTS_SFRA_ENABLED (true)
#else
#define BTS_SFRA_ENABLED (false)
#endif

//
// True only when a sweep is actually running: the library is compiled in AND
// the straps selected a slot-tuning mode.
//
// In a production build this is the constant 0, so every guarded branch
// collapses at compile time and the control ISR carries no test at all -
// the runtime switch costs a production unit nothing.
//
#if (BTS_SFRA_ENABLED == true)
    #define BTS_SFRA_IS_ACTIVE()   (btsSfraActive != 0U)
#else
    #define BTS_SFRA_IS_ACTIVE()   (0)
#endif
#if BTS_SFRA_ENABLED == true
#warning "SFRA IS ENABLED BY DEFINITION"
#endif

#define BTS_SFRA_CH_SELECT BTS_SFRA_CH1

#define BTS_ISR_MODE BTS_ISR_MODE_CLOSED_LOOP
#define BTS_ISR_MODE_OPEN_LOOP 1
#define BTS_ISR_MODE_CLOSED_LOOP 2

#define BTS_ISR_CL_MODE_CCCV 1
#define BTS_ISR_CL_MODE_CV 2
#define BTS_ISR_CL_MODE_CC 3

#define BTS_SFRA_CH1 (1)
#define BTS_SFRA_CH2 (2)
#define BTS_SFRA_CH3 (3)
#define BTS_SFRA_CH4 (4)
#define BTS_SFRA_CH5 (5)
#define BTS_SFRA_CH6 (6)
#define BTS_SFRA_CH7 (7)
#define BTS_SFRA_CH8 (8)

#define BTS_SFRA_CAPTURE_DUTY_IOUT (1)
#define BTS_SFRA_CAPTURE_ISET_IOUT (2)
#define BTS_SFRA_CAPTURE_ISET_VOUT (3)
#define BTS_SFRA_CAPTURE_VSET_VOUT (4)

#define BTS_LAB_OPEN_LOOP_ACMC_IOUT (1)
#define BTS_LAB_CLOSED_LOOP_ACMC_IOUT (2)
#define BTS_LAB_OPEN_LOOP_ACMC_VOUT (3)
#define BTS_LAB_CLOSED_LOOP_ACMC_VOUT (4)
#define BTS_LAB_CLOSED_LOOP_CCCV (5)

//
// The control law the slots run.
//
// BTS_LAB_CLOSED_LOOP_CCCV: constant current until the cell reaches its
// voltage limit, then constant voltage while the current falls away. This
// is the behaviour a charge cycle actually needs, and it is what drives
// termination - see serviceTermination() in bts_cpu1.c.
//
// It was BTS_LAB_CLOSED_LOOP_ACMC_IOUT (CC only) for a long time, which
// compiled the entire CV half of BTS_ctrlISR() out. Three things that looked
// like separate omissions were all that one setting:
//
//   - iref_cuttout_A was loaded from I_MIN and read by nothing.
//   - status[].finished (bit 2, END) was never set by any path.
//   - ctrlMode_logic was pinned to 0, so the CC/CV status bits published
//     "always CC" rather than tracking the loop.
//
// Switching it changes the sensor path as well: BTS_cellVoltageAsCtrl16b()
// becomes live for the internal-ADC MODE straps, because the CV loop needs
// a cell voltage. That function reads CLA1's fast filter - the 8-deep ring
// it used to read is no longer filled - which is why the ADC/CLA work had
// to land before this switch.
//
#define BTS_LAB_TYPE    BTS_LAB_CLOSED_LOOP_CCCV


#if BTS_LAB_TYPE == BTS_LAB_OPEN_LOOP_ACMC_IOUT
#define BTS_SFRA_CAPTURE_SETTINGS BTS_SFRA_CAPTURE_DUTY_IOUT
#define BTS_ISR_CL_MODE BTS_ISR_CL_MODE_CC
#define BTS_ISR_MODE BTS_ISR_MODE_OPEN_LOOP
#elif BTS_LAB_TYPE == BTS_LAB_CLOSED_LOOP_ACMC_IOUT
#define BTS_SFRA_CAPTURE_SETTINGS BTS_SFRA_CAPTURE_ISET_IOUT
#define BTS_ISR_CL_MODE BTS_ISR_CL_MODE_CC
#define BTS_ISR_MODE BTS_ISR_MODE_CLOSED_LOOP
#else
//
// CCCV and the two ACMC_VOUT labs.
//
// BTS_SFRA_CAPTURE_SETTINGS has to be defined here even though CCCV is not
// primarily an SFRA mode. Without it the macro is undefined, every
// "#if(BTS_SFRA_CAPTURE_SETTINGS == ...)" test below silently evaluates it
// as 0, no branch matches, and BTS_SFRA_AMPLITUDE never gets defined - which
// is invisible today only because that whole block sits inside
// "#if(BTS_SFRA_ENABLED == true)" and SFRA is off. Turning SFRA on would
// fail to compile at bts.c's BTS_SFRA_AMPLITUDE use, a long way from here.
//
// VSET_VOUT is the correct capture point for a voltage loop: the injection
// goes into the voltage setpoint, which is what CV regulates.
//
#define BTS_SFRA_CAPTURE_SETTINGS BTS_SFRA_CAPTURE_VSET_VOUT
#define BTS_ISR_CL_MODE BTS_ISR_CL_MODE_CCCV
#define BTS_ISR_MODE BTS_ISR_MODE_CLOSED_LOOP
#endif

//
// Device clocking conditions
//
#define BTS_SYSCLK_HZ        DEVICE_SYSCLK_FREQ
#define BTS_SYSCLK_NS        ((float32_t)1000000000 / BTS_SYSCLK_HZ)
#define BTS_EPWM_HZ          (DEVICE_SYSCLK_FREQ/2)
#define BTS_EPWM_NS          ((float32_t)1000000000 / BTS_EPWM_HZ)


//
// TASK configuration
//
#define TASKA_CPUTIMER_BASE CPUTIMER0_BASE
#define TASKB_CPUTIMER_BASE CPUTIMER1_BASE
#define TASKC_CPUTIMER_BASE CPUTIMER2_BASE

#define TASKA_FREQ_HZ         ((uint16_t)1000)
#define TASKB_FREQ_HZ         ((uint16_t) 200)
#define TASKC_FREQ_HZ         ((uint16_t)  20)

#define GET_TASKA_TIMER_OVERFLOW_STATUS CPUTimer_getTimerOverflowStatus(TASKA_CPUTIMER_BASE)
#define CLEAR_TASKA_TIMER_OVERFLOW_FLAG CPUTimer_clearOverflowFlag(TASKA_CPUTIMER_BASE)

#define GET_TASKB_TIMER_OVERFLOW_STATUS CPUTimer_getTimerOverflowStatus(TASKB_CPUTIMER_BASE)
#define CLEAR_TASKB_TIMER_OVERFLOW_FLAG CPUTimer_clearOverflowFlag(TASKB_CPUTIMER_BASE)

#define GET_TASKC_TIMER_OVERFLOW_STATUS CPUTimer_getTimerOverflowStatus(TASKC_CPUTIMER_BASE)
#define CLEAR_TASKC_TIMER_OVERFLOW_FLAG CPUTimer_clearOverflowFlag(TASKC_CPUTIMER_BASE)

// GPIO assignments
// CMPSS thresholds for �10A
#define CMPSS_THRESHOLD_HIGH 836  // 2.45V (+10A) = 836 counts
#define CMPSS_THRESHOLD_LOW 17    // 0.05V (-10A) = 17 counts

#define BTS_TRP_PIN_CONFIG_GPIO_CH1     GPIO_28_GPIO28
#define BTS_TRP_PIN_CONFIG_GPIO_CH2     GPIO_26_GPIO26
#define BTS_TRP_PIN_CONFIG_GPIO_CH3     GPIO_27_GPIO27
#define BTS_TRP_PIN_CONFIG_GPIO_CH4     GPIO_34_GPIO34
#define BTS_TRP_PIN_CONFIG_GPIO_CH5     GPIO_39_GPIO39
#define BTS_TRP_PIN_CONFIG_GPIO_CH6     GPIO_44_GPIO44
#define BTS_TRP_PIN_CONFIG_GPIO_CH7     GPIO_45_GPIO45
#define BTS_TRP_PIN_CONFIG_GPIO_CH8     GPIO_46_GPIO46

//
// The bare pin numbers for the trip inputs above.
//
// GPIO_setPinConfig() takes the packed mux encoding (GPIO_28_GPIO28 ==
// 0x00081800), but GPIO_setDirectionMode(), GPIO_setQualificationMode(),
// GPIO_setPadConfig() and XBAR_setInputPin() all take a plain pin number.
// Passing the encoding to those trips driverlib's ASSERT(pin <= 168).
//
#define BTS_TRP_PIN_GPIO_CH1            28U
#define BTS_TRP_PIN_GPIO_CH2            26U
#define BTS_TRP_PIN_GPIO_CH3            27U
#define BTS_TRP_PIN_GPIO_CH4            34U
#define BTS_TRP_PIN_GPIO_CH5            39U
#define BTS_TRP_PIN_GPIO_CH6            44U
#define BTS_TRP_PIN_GPIO_CH7            45U
#define BTS_TRP_PIN_GPIO_CH8            46U


//
//=============================================================================
// Over-current comparator per slot - NOT CMPSSn for slot n
//=============================================================================
//
// Each CMPSS has a fixed pair of input pins (datasheet SPRS880 Table 4-1, TRM
// SPRUHM8K Figure 10-1), and this board routes each slot's sense nets to
// whichever ADC pins suited the layout. So the comparator that can watch a
// slot is the one that owns the pin its current-sense net IoutSn lands on -
// and for slots 2, 3, 5, 7 and 8 that is a different number:
//
//   slot  ePWM   IoutSn  J5   device pin  comparator input  CMPSS   X-BAR mux
//    1    ePWM1  IoutS1  106  ADCINA2     CMPIN1P           CMPSS1  MUX00
//    2    ePWM2  IoutS2  103  ADCINB2     CMPIN3P           CMPSS3  MUX04
//    3    ePWM3  IoutS3  100  ADCINA4     CMPIN2P           CMPSS2  MUX02
//    4    ePWM4  IoutS4   96  ADCIN14     CMPIN4P           CMPSS4  MUX06
//    5    ePWM5  IoutS5   93  ADCIND0     CMPIN7P           CMPSS7  MUX12
//    6    ePWM6  IoutS6   90  ADCINC2     CMPIN6P           CMPSS6  MUX10
//    7    ePWM7  IoutS7   87  ADCIND2     CMPIN8P           CMPSS8  MUX14
//    8    ePWM8  IoutS8   84  ADCINC4     CMPIN5P           CMPSS5  MUX08
//
// IoutSn to J5 pin to device pin is schematic XTIDA-010086E3 sheet 13. J5 is
// the controlCARD socket; TI's controlCARD pinout numbers the same pin
// 121 - n. These are also the pins the ADC samples as each slot's current
// (BTS_HAL_setupADC() and bts_cla.cla), so a board that moves one changes
// both places.
//
// Each slot's voltage-sense net VoutSn lands on the SAME comparator's
// negative pin (VoutS2 on ADCINB3 = CMPIN3N, and so on). Nothing reads it
// there: the high and the low comparator both take their negative input
// from the internal DAC (CMPSS_INSRC_DAC, BTS_HAL_setupCMPSS()).
//
// Until 2026-10-09 the routing used CMPSSn for slot n - right for slots 1, 4
// and 6 only. Applied by btsSlotCmpss[] in bts_hal.c. The full per-slot map,
// with both sense nets, their links and ADC channels, is in
// Docs/hardware-resources.md section 5.
//
#define BTS_TRP_CMPSS_CH1               (1U)
#define BTS_TRP_CMPSS_CH2               (3U)
#define BTS_TRP_CMPSS_CH3               (2U)
#define BTS_TRP_CMPSS_CH4               (4U)
#define BTS_TRP_CMPSS_CH5               (7U)
#define BTS_TRP_CMPSS_CH6               (6U)
#define BTS_TRP_CMPSS_CH7               (8U)
#define BTS_TRP_CMPSS_CH8               (5U)

//
// Eight slots, eight comparators, one each. A repeated entry would leave a
// slot watched by another slot's current, so anything but a one-to-one
// assignment of CMPSS1..8 fails the build. This checks only that the table
// IS one; whether it matches the board is the schematic's question.
//
#if (((1U << (BTS_TRP_CMPSS_CH1 - 1U)) | (1U << (BTS_TRP_CMPSS_CH2 - 1U)) | \
      (1U << (BTS_TRP_CMPSS_CH3 - 1U)) | (1U << (BTS_TRP_CMPSS_CH4 - 1U)) | \
      (1U << (BTS_TRP_CMPSS_CH5 - 1U)) | (1U << (BTS_TRP_CMPSS_CH6 - 1U)) | \
      (1U << (BTS_TRP_CMPSS_CH7 - 1U)) | (1U << (BTS_TRP_CMPSS_CH8 - 1U))) != 0xFFU)
#error "BTS_TRP_CMPSS_CH1..8 must give each slot its own comparator, CMPSS1..8"
#endif


#define BTS_DRV_EPWM_HR_ENABLED           true
#define BTS_EPWM_HR_ENABLED               true

#define BTS_DRV_EPWM_BASE                 EPWM1_BASE
#define BTS_DRV_EPWM_NUM                  ((uint16_t)1)
#define BTS_DRV_EPWM_H_GPIO               ((uint16_t)1)
#define BTS_DRV_EPWM_H_PIN_CONFIG_EPWM    GPIO_0_EPWM1A
#define BTS_DRV_EPWM_H_PIN_CONFIG_GPIO    GPIO_0_GPIO0
#define BTS_DRV_EPWM_L_GPIO               ((uint16_t)3)
#define BTS_DRV_EPWM_L_PIN_CONFIG_EPWM    GPIO_1_EPWM1B
#define BTS_DRV_EPWM_L_PIN_CONFIG_GPIO    GPIO_1_GPIO1

//CHANNEL 1
#define BTS_EPWM_BASE_CH1                 EPWM1_BASE
#define BTS_EPWM_NUM_CH1                  ((uint16_t)1)
#define BTS_EPWM_H_GPIO_CH1               ((uint16_t)1)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_CH1    GPIO_0_EPWM1A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_CH1    GPIO_0_GPIO0
#define BTS_EPWM_L_GPIO_CH1               ((uint16_t)1)
#define BTS_EPWM_L_PIN_CONFIG_EPWM_CH1    GPIO_1_EPWM1B
#define BTS_EPWM_L_PIN_CONFIG_GPIO_CH1    GPIO_1_GPIO1

//CHANNEL 2
#define BTS_EPWM_BASE_CH2                 EPWM2_BASE
#define BTS_EPWM_NUM_CH2                  ((uint16_t)2)
#define BTS_EPWM_H_GPIO_CH2               ((uint16_t)2)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_CH2    GPIO_2_EPWM2A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_CH2    GPIO_2_GPIO2
#define BTS_EPWM_L_GPIO_CH2               ((uint16_t)3)
#define BTS_EPWM_L_PIN_CONFIG_EPWM_CH2    GPIO_3_EPWM2B
#define BTS_EPWM_L_PIN_CONFIG_GPIO_CH2    GPIO_3_GPIO3

//CHANNEL 3
#define BTS_EPWM_BASE_CH3                 EPWM3_BASE
#define BTS_EPWM_NUM_CH3                  ((uint16_t)3)
#define BTS_EPWM_H_GPIO_CH3               ((uint16_t)4)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_CH3    GPIO_4_EPWM3A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_CH3    GPIO_4_GPIO4
#define BTS_EPWM_L_GPIO_CH3               ((uint16_t)5)
#define BTS_EPWM_L_PIN_CONFIG_EPWM_CH3    GPIO_5_EPWM3B
#define BTS_EPWM_L_PIN_CONFIG_GPIO_CH3    GPIO_5_GPIO5

//CHANNEL 4
#define BTS_EPWM_BASE_CH4                 EPWM4_BASE
#define BTS_EPWM_NUM_CH4                  ((uint16_t)4)
#define BTS_EPWM_H_GPIO_CH4               ((uint16_t)6)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_CH4    GPIO_6_EPWM4A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_CH4    GPIO_6_GPIO6
#define BTS_EPWM_L_GPIO_CH4               ((uint16_t)7)
#define BTS_EPWM_L_PIN_CONFIG_EPWM_CH4    GPIO_7_EPWM4B
#define BTS_EPWM_L_PIN_CONFIG_GPIO_CH4    GPIO_7_GPIO7

//CHANNEL 5
#define BTS_EPWM_BASE_CH5                 EPWM5_BASE
#define BTS_EPWM_NUM_CH5                  ((uint16_t)5)
#define BTS_EPWM_H_GPIO_CH5               ((uint16_t)8)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_CH5    GPIO_8_EPWM5A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_CH5    GPIO_8_GPIO8
#define BTS_EPWM_L_GPIO_CH5               ((uint16_t)9)
#define BTS_EPWM_L_PIN_CONFIG_EPWM_CH5    GPIO_9_EPWM5B
#define BTS_EPWM_L_PIN_CONFIG_GPIO_CH5    GPIO_9_GPIO9

//CHANNEL 6
#define BTS_EPWM_BASE_CH6                 EPWM6_BASE
#define BTS_EPWM_NUM_CH6                  ((uint16_t)6)
#define BTS_EPWM_H_GPIO_CH6               ((uint16_t)10)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_CH6    GPIO_10_EPWM6A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_CH6    GPIO_10_GPIO10
#define BTS_EPWM_L_GPIO_CH6               ((uint16_t)11)
#define BTS_EPWM_L_PIN_CONFIG_EPWM_CH6    GPIO_11_EPWM6B
#define BTS_EPWM_L_PIN_CONFIG_GPIO_CH6    GPIO_11_GPIO11

//CHANNEL 7
#define BTS_EPWM_BASE_CH7                 EPWM7_BASE
#define BTS_EPWM_NUM_CH7                  ((uint16_t)7)
#define BTS_EPWM_H_GPIO_CH7               ((uint16_t)12)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_CH7    GPIO_12_EPWM7A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_CH7    GPIO_12_GPIO12
#define BTS_EPWM_L_GPIO_CH7               ((uint16_t)13)
#define BTS_EPWM_L_PIN_CONFIG_EPWM_CH7    GPIO_13_EPWM7B
#define BTS_EPWM_L_PIN_CONFIG_GPIO_CH7    GPIO_13_GPIO13

//CHANNEL 8
#define BTS_EPWM_BASE_CH8                 EPWM8_BASE
#define BTS_EPWM_NUM_CH8                  ((uint16_t)8)
#define BTS_EPWM_H_GPIO_CH8               ((uint16_t)14)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_CH8    GPIO_14_EPWM8A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_CH8    GPIO_14_GPIO14
#define BTS_EPWM_L_GPIO_CH8               ((uint16_t)15)
#define BTS_EPWM_L_PIN_CONFIG_EPWM_CH8    GPIO_15_EPWM8B
#define BTS_EPWM_L_PIN_CONFIG_GPIO_CH8    GPIO_15_GPIO15

//CHANNEL 11 (ADC1 CLK)
#define BTS_EPWM_BASE_ADC1                EPWM11_BASE
#define BTS_EPWM_NUM_ADC1                 ((uint16_t)11)
#define BTS_EPWM_H_GPIO_ADC1              ((uint16_t)20)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_ADC1   GPIO_20_EPWM11A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_ADC1   GPIO_20_GPIO20

//CHANNEL 12 (ADC2 CLK)
#define BTS_EPWM_BASE_ADC2                EPWM12_BASE
#define BTS_EPWM_NUM_ADC2                 ((uint16_t)12)
#define BTS_EPWM_H_GPIO_ADC2              ((uint16_t)22)
#define BTS_EPWM_H_PIN_CONFIG_EPWM_ADC2   GPIO_22_EPWM12A
#define BTS_EPWM_H_PIN_CONFIG_GPIO_ADC2   GPIO_22_GPIO22

//ADC1 24b sd ch1-4
#define BTS_SPI_BASE_ADC1                 SPIA_BASE
#define BTS_SPI_CS_GPIO_ADC1              ((uint16_t)19)
#define BTS_SPI_DRDY_GPIO_ADC1            ((uint16_t)25)
#define BTS_SPI_RESET_GPIO_ADC1           ((uint16_t)24)
#define BTS_SPI_DOUT_GPIO_ADC1            ((uint16_t)17)
#define BTS_SPI_DIN_GPIO_ADC1             ((uint16_t)16)
#define BTS_SPI_SCLK_GPIO_ADC1            ((uint16_t)18)
#define BTS_SPI_CS_PIN_CONFIG_ADC1        GPIO_19_GPIO19
#define BTS_SPI_DRDY_PIN_CONFIG_ADC1      GPIO_25_GPIO25
#define BTS_SPI_RESET_PIN_CONFIG_ADC1     GPIO_24_GPIO24
#define BTS_SPI_DOUT_PIN_CONFIG_ADC1      GPIO_17_SPISOMIA
#define BTS_SPI_DIN_PIN_CONFIG_ADC1       GPIO_16_SPISIMOA
#define BTS_SPI_SCLK_PIN_CONFIG_ADC1      GPIO_18_SPICLKA
//
// XINT3, not XINT1. The Input X-BAR is a single device-global resource, not
// per-core: GPIO_setInterruptPin() resolves XINT1 -> INPUT4 and writes
// INPUT4SELECT in the one X-BAR at 0x7900. CPU2 points XINT1/XINT2 at the
// ADS1119 DRDY pins after CPU1 has set them here, and CPU2 boots last, so it
// won. ISR1/ISR3 never saw a DRDY edge. XINT3 -> INPUT6 and XINT5 -> INPUT14
// are ours alone. (XINT4 -> INPUT13 is reserved for the channel-5 GPIO trip.)
//
#define BTS_SPI_DRDY_XINT_ADC1            INT_XINT3
#define BTS_PSI_DRDY_XINT_GPIO1           GPIO_INT_XINT3
#define BTS_SPI_DRDY_CINT_ADC1            INT_SPIA_RX
#define BTS_DRDY_ADC1                     ISR1
#define BTS_RXFIFO_SPI1                   ISR2

//ADC2 24b sd ch5-8
#define BTS_SPI_BASE_ADC2                 SPIC_BASE
#define BTS_SPI_CS_GPIO_ADC2              ((uint16_t)53)
#define BTS_SPI_DRDY_GPIO_ADC2            ((uint16_t)49)
#define BTS_SPI_RESET_GPIO_ADC2           ((uint16_t)48)
#define BTS_SPI_DOUT_GPIO_ADC2            ((uint16_t)51)
#define BTS_SPI_DIN_GPIO_ADC2             ((uint16_t)50)
#define BTS_SPI_SCLK_GPIO_ADC2            ((uint16_t)52)
#define BTS_SPI_CS_PIN_CONFIG_ADC2        GPIO_53_GPIO53
#define BTS_SPI_DRDY_PIN_CONFIG_ADC2      GPIO_49_GPIO49
#define BTS_SPI_RESET_PIN_CONFIG_ADC2     GPIO_48_GPIO48
#define BTS_SPI_DOUT_PIN_CONFIG_ADC2      GPIO_51_SPISOMIC
#define BTS_SPI_DIN_PIN_CONFIG_ADC2       GPIO_50_SPISIMOC
#define BTS_SPI_SCLK_PIN_CONFIG_ADC2      GPIO_52_SPICLKC
// XINT5 -> INPUT14, not XINT2 -> INPUT5. See the note on ADC1 above.
#define BTS_SPI_DRDY_XINT_ADC2            INT_XINT5
#define BTS_PSI_DRDY_XINT_GPIO2           GPIO_INT_XINT5
#define BTS_SPI_DRDY_CINT_ADC2            INT_SPIC_RX
#define BTS_DRDY_ADC2                     ISR3
#define BTS_RXFIFO_SPI2                   ISR4


// I2C Internal - Master Mode (FRAM/EEPROM)
#define BTS_I2C_INT_BASE                   I2CB_BASE
#define BTS_I2C_INT_SPEED                  400000
#define BTS_I2C_INT_PIN_SDA                ((uint16_t)40)
#define BTS_I2C_INT_PIN_SCL                ((uint16_t)41)
#define BTS_I2C_INT_CFG_SDA                GPIO_40_SDAB
#define BTS_I2C_INT_CFG_SCL                GPIO_41_SCLB
#define BTS_I2C_INT_RXDATA                 I2CB_RXdata
#define BTS_I2C_INT_TXDATA                 I2CB_TXdata
#define BTS_I2C_INT_CNTADDR                I2CB_ControlAddr

// I2C External - Slave mode
#define BTS_I2C_EXT_BASE                   I2CA_BASE
#define BTS_I2C_EXT_SPEED                  400000
#define BTS_I2C_EXT_PIN_SDA                ((uint16_t)32)
#define BTS_I2C_EXT_PIN_SCL                ((uint16_t)33)
#define BTS_I2C_EXT_CFG_SDA                GPIO_32_SDAA
#define BTS_I2C_EXT_CFG_SCL                GPIO_33_SCLA
#define BTS_I2C_EXT_RXDATA                 I2CA_RXdata
#define BTS_I2C_EXT_TXDATA                 I2CA_TXdata
#define BTS_I2C_EXT_CNTADDR                I2CA_ControlAddr

// CAN External - CC/CV set-point and data stream
#define BTS_CAN_BASE                        CANA_BASE
#define BTS_CAN_PIN_CANRX                   GPIO_30_CANRXA
#define BTS_CAN_PIN_CANTX                   GPIO_31_CANTXA

// MODE OPTIONS
#define BTS_MODE_GPIO_CFG_0                     GPIO_54_GPIO54
#define BTS_MODE_GPIO_CFG_1                     GPIO_55_GPIO55
#define BTS_MODE_GPIO_CFG_2                     GPIO_56_GPIO56
#define BTS_MODE_GPIO_PIN_0                     ((uint16_t)54)
#define BTS_MODE_GPIO_PIN_1                     ((uint16_t)55)
#define BTS_MODE_GPIO_PIN_2                     ((uint16_t)56)

// ENABLE OPTIONS
#define BTS_EN_GPIO_CFG_0                       GPIO_57_GPIO57
#define BTS_EN_GPIO_CFG_1                       GPIO_58_GPIO58
#define BTS_EN_GPIO_CFG_2                       GPIO_59_GPIO59
#define BTS_EN_GPIO_PIN_0                       ((uint16_t)57)
#define BTS_EN_GPIO_PIN_1                       ((uint16_t)58)
#define BTS_EN_GPIO_PIN_2                       ((uint16_t)59)


/*
 *  volatile float32_t iref_A;
    volatile float32_t vref_charge_V;
    volatile float32_t vref_discharge_V;
    volatile uint16_t  direction_logic;
    volatile uint16_t  enable_logic;
 */
#define BTS_I2C_ADR_USER_CH1                0x0100
#define BTS_I2C_ADR_USER_CH2                0x0200
#define BTS_I2C_ADR_USER_CH3                0x0300
#define BTS_I2C_ADR_USER_CH4                0x0400
#define BTS_I2C_ADR_USER_CH5                0x0500
#define BTS_I2C_ADR_USER_CH6                0x0600
#define BTS_I2C_ADR_USER_CH7                0x0700
#define BTS_I2C_ADR_USER_CH8                0x0800

/*
 *  float32_t IoutGain_pu;
    float32_t IoutOffset_pu;
    float32_t IoutGain_A;
    float32_t IoutOffset_A;

    float32_t VoutGain_pu;
    float32_t VoutOffset_pu;
    float32_t VoutGain_V;
    float32_t VoutOffset_V;

    uint16_t  pendingUpdate;
 */
#define BTS_I2C_ADR_CAL_CH1                0x1100
#define BTS_I2C_ADR_CAL_CH2                0x1200
#define BTS_I2C_ADR_CAL_CH3                0x1300
#define BTS_I2C_ADR_CAL_CH4                0x1400
#define BTS_I2C_ADR_CAL_CH5                0x1500
#define BTS_I2C_ADR_CAL_CH6                0x1600
#define BTS_I2C_ADR_CAL_CH7                0x1700
#define BTS_I2C_ADR_CAL_CH8                0x1800

#define BTS_senseAverageFactor 32 //32U

//
//=============================================================================
// ADS131M08 control-path conditioning
//=============================================================================
//
// The DRDY interrupt delivers one current/voltage pair per slot every
// 1 / BTS_ADS131_FDATA_HZ. The two loops take it differently, on purpose:
//
//   CC (current)  a ROLLING MEAN of the last BTS_CC_AVG_N samples, updated
//                 every sample. Short enough to stay well inside the loop's
//                 bandwidth, long enough to knock down sample-to-sample
//                 noise. Before 2026-10-10 the loop took the single latest
//                 raw sample.
//   CV (voltage)  a single-pole IIR at BTS_CV_FILT_FC_HZ, also updated every
//                 sample. The voltage loop is the OUTER loop and must be
//                 slower than the current loop it commands, so its input is
//                 deliberately much heavier filtered: ~100 Hz against the CC
//                 path's ~3.5 kHz - comfortably more than the 10x separation
//                 the outer loop needs.
//
// Both loops still EXECUTE on every DRDY sample, so the DCL biquads keep the
// sample period they were designed for (BTS_SFRA_ISR_FREQ, 31.25 kHz - see
// BTS_DCL_CC_* below; the actual rate is BTS_ADS131_FDATA_HZ, within 2.3%).
// Only the input is conditioned; the loop rate is unchanged.
//
// The 32-deep ring above is the TELEMETRY path. It is meaned at the C1()
// rate into Isense_A / Vsense_V and is never read by either loop.
//
// fDATA = CLKIN / 2 / OSR = (90 MHz / (BTS_DRV_ADC_TBPRD + 1)) / 2 / 128.
// Written out rather than derived, because BTS_DRV_ADC_TBPRD is computed
// with truncating integer division and the true clock is what matters.
//
#define BTS_ADS131_OSR             (128U)
#define BTS_ADS131_FDATA_HZ        ((float32_t)31960.2)   // 8.1818 MHz / 2 / 128

//
// Samples in the CC loop's rolling mean. A power of two keeps the divide a
// shift. 4 at 31.96 kSPS spans 125 us, puts the first null at 8 kHz and the
// -3 dB point at ~3.5 kHz, and adds 1.5 samples (47 us) of group delay.
//
#define BTS_CC_AVG_N               (4U)
#define BTS_CC_AVG_SHIFT           (2U)

#if ((1U << BTS_CC_AVG_SHIFT) != BTS_CC_AVG_N)
#error "BTS_CC_AVG_N must equal 1 << BTS_CC_AVG_SHIFT"
#endif

//
// CV input filter: y += alpha * (x - y), alpha = 1 - exp(-2*pi*fc/fs).
// fc = 100 Hz at fs = 31.96 kSPS gives alpha = 0.019467.
//
#define BTS_CV_FILT_FC_HZ          ((float32_t)100.0)
#define BTS_CV_FILT_ALPHA          ((float32_t)0.019467)

//
// Input bus voltage (Vin sense) smoothing.
//
// updateInputVoltage() runs from C1(). Each pass it now takes
// BTS_VIN_OVERSAMPLE back-to-back conversions of the sense pin and of the A0
// reference and averages them, then runs the result through a single-pole
// IIR. The raw single conversion it used to take moved by +/-0.5 V on BTLE -
// a few counts of switching noise on a 12-bit reading, multiplied by the
// sense gain of ~6.2. The filter weight below gives a time constant of
// roughly 1 / BTS_VIN_FILT_ALPHA C1() passes.
//
// Both thresholds the bus voltage drives (restrict and disable) already
// debounce their own transitions, so the filter only has to remove noise,
// not decide anything.
//
#define BTS_VIN_OVERSAMPLE         (16U)
#define BTS_VIN_FILT_ALPHA         ((float32_t)0.25)

//
// Full-scale divisor for the ADS131M08 sample ring.
//
// This tracks the configured SPI WORD length, NOT the converter's silicon
// width. The part is 24-bit, but BTS_HAL_setupExAdc_ch1_4/5_8() write the
// MODE register as 0x0000 (WLENGTH = 00), so every sample arrives as 16-bit
// two's complement and full scale is 2^15.
//
// If WLENGTH is ever raised to 24-bit (MODE 0x0100), change this to
// 8388608.0 in the same commit - the sample storage is already int32_t, so
// nothing else has to move. Getting the two out of step scales every
// current and voltage reading by 256.
//
#define BTS_ADS131_FULLSCALE ((float32_t)32768.0)

//
// Input bus-voltage sense scaling.
//
// updateInputVoltage() measures ratiometrically against ADC-A0, which carries
// an external 1.25 V taken from the reference divider. Working from the ratio
// means the ADC's own reference cancels and never has to be assumed - this
// controlCARD runs 3.0 V, not the 3.3 V an earlier hard-coded formula used,
// which alone put every reading ~10% high.
//
// BTS_VIN_SENSE_GAIN is the external amplifier's gain, derived from its
// attenuation rather than from the nominal "17.9 V gives 2.5 V at the pin"
// figure: (1 / 0.139) - 1 = 6.1942. The naive 17.9/2.5 = 7.16 ignores the
// amplifier's own attenuation and reads ~16% high.
//
// Verified on hardware 2026-09-21: A0 = 1696 counts (so VREFHI = 3.019 V,
// and A0 agrees to 0.3% with the current-sense mid-rail, an independent
// 1.25 V source); the sense pin measured 2.4204 V, giving 14.99 V against a
// bench meter reading 14.88 V - 0.76%, within divider and meter tolerance.
//
// The charge/discharge guards compare against this value, so an error here
// moves the restrict/disable thresholds.
//
#define BTS_VIN_REF_VOLTS  ((float32_t)1.25)
#define BTS_VIN_SENSE_ATTEN ((float32_t)0.139)
#define BTS_VIN_SENSE_GAIN ((float32_t)((1.0 / BTS_VIN_SENSE_ATTEN) - 1.0))

//
// Sign-extend one ADS131M08 sample to the full int32_t.
//
// The SPI frame delivers the sample as a bare word with no sign extension
// above the configured WLENGTH, so a small negative reading arrives as
// 0x0000FFEA rather than 0xFFFFFFEA. Without this every value just below
// zero reads as ~+65514, i.e. +2.0 pu instead of 0.
//
// Keyed to the 16-bit word mode set in BTS_HAL_setupExAdc_*. For 24-bit
// words this becomes a sign test against 0x00800000 with a 0xFF000000 fill.
//
#define BTS_ADS131_SIGN_EXTEND(x) \
    ((int32_t)(((uint32_t)(x) & 0x8000UL) ? ((uint32_t)(x) | 0xFFFF0000UL) \
                                          : ((uint32_t)(x) & 0x0000FFFFUL)))

#define VIN ((float32_t)12)


#if 0

#define BTS_DCL_CC_B0                ((float32_t) 0.0342955642)
#define BTS_DCL_CC_B1                ((float32_t)-0.0611383610)
#define BTS_DCL_CC_B2                ((float32_t) 0.0270789596)
#define BTS_DCL_CC_A1                ((float32_t)-1.9244278933)
#define BTS_DCL_CC_A2                ((float32_t) 0.9244278933)
#elif 0
//Kdc 150
//Fz0 0.1
//Fz1 0.7
//Fp1 0.5

#define BTS_DCL_CC_B0                ((float32_t) 0.1755347)
#define BTS_DCL_CC_B1                ((float32_t) -0.3244942)
#define BTS_DCL_CC_B2                ((float32_t)  0.1494189)
#define BTS_DCL_CC_A1                ((float32_t) -1.9042804)
#define BTS_DCL_CC_A2                ((float32_t) 0.9042804)
#else
//Kdc 50
//Fz0 0.1
//Fz1 0.5
//Fp1 0.2
#define BTS_DCL_CC_B0                ((float32_t) 0.0331015)
#define BTS_DCL_CC_B1                ((float32_t) -0.0623757)
#define BTS_DCL_CC_B2                ((float32_t)  0.0293372)
#define BTS_DCL_CC_A1                ((float32_t) -1.9605802)
#define BTS_DCL_CC_A2                ((float32_t) 0.9605802)
#endif

#if 0
#define BTS_DCL_CV_KDC               ((float32_t)5000)
#define BTS_DCL_CV_Z0                ((float32_t)0.100)
#define BTS_DCL_CV_Z1                ((float32_t)1.000) // 2
#define BTS_DCL_CV_P1                ((float32_t)1.000) // 2

#define BTS_DCL_CV_B0                ((float32_t) 1.3718226)
#define BTS_DCL_CV_B1                ((float32_t)-2.4455344)
#define BTS_DCL_CV_B2                ((float32_t) 1.0831584)
#define BTS_DCL_CV_A1                ((float32_t)-1.9244279)
#define BTS_DCL_CV_A2                ((float32_t) 0.9244279)
#else

#define BTS_DCL_CV_KDC               ((float32_t)5000)
#define BTS_DCL_CV_Z0                ((float32_t)0.100)
#define BTS_DCL_CV_Z1                ((float32_t)2.000) // 2
#define BTS_DCL_CV_P1                ((float32_t)2.000) // 2

#define BTS_DCL_CV_B0                ((float32_t) 8.0377472)
#define BTS_DCL_CV_B1                ((float32_t)-13.2244008)
#define BTS_DCL_CV_B2                ((float32_t) 5.2402228)
#define BTS_DCL_CV_A1                ((float32_t)-1.6651931)
#define BTS_DCL_CV_A2                ((float32_t) 0.6651931)

#endif


#define BTS_SFRA_ISR_SRC_ADC 0
#define BTS_SFRA_ISR_SRC_PWM 1
#define BTS_SFRA_ISR_SRC                   BTS_SFRA_ISR_SRC_ADC

#if(BTS_SFRA_ENABLED == true)
    //#define BTS_SFRA_EPWM               (EPWM9_BASE)
    //#define BTS_SFRA_TDRD               ((BTS_DRV_EPWM_SWITCHING_FREQUENCY / BTS_SFRA_ISR_FREQ_REQ ) - 1)
#if (BTS_SFRA_ISR_SRC == BTS_SFRA_ISR_SRC_ADC)
    //
    // The DRDY rate the loops run at - 31.96 kSPS since CLKIN went to
    // 8.1818 MHz (BTS_ADS131_FDATA_HZ). Left at the 31.25 kHz the DCL
    // coefficients were designed for; the 2.3% difference shifts every
    // swept frequency by the same 2.3%.
    //
    #define BTS_SFRA_ISR_FREQ             ((float32_t)31250)
    #define BTS_SFRA_FREQ_LENGTH          ((int16_t)103)
#else
    #define BTS_SFRA_ISR_FREQ             ((float32_t)100000)
    #define BTS_SFRA_FREQ_LENGTH          ((int16_t)120)
#endif

    #define BTS_SFRA_FREQ_START           ((float32_t)10.0f)

    //
    // SFRA step Multiply = 10^(1/No of steps per decade(35))
    //
    #define BTS_SFRA_FREQ_STEP_MULTIPLY   ((float32_t) 1.0746078283213174972f)

#if(BTS_SFRA_CAPTURE_SETTINGS == BTS_SFRA_CAPTURE_DUTY_IOUT)
    #define BTS_SFRA_AMPLITUDE            ((float32_t)0.0075)
#elif((BTS_SFRA_CAPTURE_SETTINGS==BTS_SFRA_CAPTURE_ISET_IOUT)||(BTS_SFRA_CAPTURE_SETTINGS==BTS_SFRA_CAPTURE_ISET_VOUT))
#define BTS_SFRA_AMPLITUDE            ((float32_t)0.1)
#elif(BTS_SFRA_CAPTURE_SETTINGS == BTS_SFRA_CAPTURE_VSET_VOUT)
#define BTS_SFRA_AMPLITUDE            ((float32_t)0.005)
#endif
    #define BTS_SFRA_SWEEP_SPEED          ((int16_t)3)

    #define BTS_SFRA_GUI_SCI_BASE         SCIA_BASE
    #define BTS_SFRA_GUI_SCI_BAUDRATE     ((uint32_t)57600)
    #define BTS_SFRA_GUI_SCIRX_GPIO       ((uint16_t)28)
    #define BTS_SFRA_GUI_SCIRX_PIN_CONFIG GPIO_28_SCIRXDA
    #define BTS_SFRA_GUI_SCITX_GPIO       ((uint16_t)29)
    #define BTS_SFRA_GUI_SCITX_PIN_CONFIG GPIO_29_SCITXDA

    #define BTS_SFRA_GUI_LED_ENABLE       ((uint16_t)1)
    #define BTS_SFRA_GUI_LED_GPIO         ((uint16_t)47)
    #define BTS_SFRA_GUI_LED_PIN_CONFIG   GPIO_47_GPIO47
    #define BTS_SFRA_GUI_PLOT_OPTION      ((uint16_t)SFRA_GUI_PLOT_GH_H)
#endif

#define BTS_SFRA_CHANNEL 1

#define BTS_DUTY_SET_MIN_PU               ((float32_t)0.0)
#define BTS_DUTY_SET_MAX_PU               ((float32_t)0.55)


//
// Control Configuration
//
#define BTS_DCL_CTRL_TYPE                 DCL_DF22

#define BTS_DCL_FPU32                     1
#define BTS_DCL_CLA                       2
#define BTS_DCL_CORE                      BTS_DCL_FPU32
#define BTS_DCL_PI                        CONST_PI_32

#if(BTS_DCL_CTRL_TYPE == DCL_DF22)
    #define BTS_DCL_CTRL_DEFAULTS         DF22_DEFAULTS
    #define BTS_DCL_SPS_TYPE              DCL_DF22_SPS
    #define BTS_DCL_SPS_DEFAULTS          DF22_SPS_DEFAULTS
    #define BTS_DCL_RESET                 DCL_resetDF22
    #define BTS_DCL_LOAD_PID              DCL_loadDF22asSeriesPID
    #define BTS_DCL_LOAD_ZPK              DCL_loadDF22asZPK
    #define BTS_DCL_UPDATE                DCL_updateDF22

    #if(BTS_DCL_CORE == BTS_DCL_FPU32)
        #define BTS_DCL_RUN_IMMEDIATE     DCL_runDF22_C5
        #define BTS_DCL_RUN_PARTIAL       DCL_runDF22_C6
        #define BTS_DCL_RUN_CLAMP         DCL_runClamp_C2
    #elif(BTS_DCL_CORE == BTS_DCL_CLA)
        #define BTS_DCL_RUN_IMMEDIATE     DCL_runDF22_L2
        #define BTS_DCL_RUN_PARTIAL       DCL_runDF22_L3
        #define BTS_DCL_RUN_CLAMP         DCL_runClamp_L1
    #endif
#endif




//
// Synchronous buck ePWM configuration
//


#define BTS_DRV_EPWM_EPWMCLK_DIV          EPWM_CLOCK_DIVIDER_1
#define BTS_DRV_EPWM_HSCLK_DIV            EPWM_HSCLOCK_DIVIDER_1


#if(BTS_DRV_EPWM_HSCLK_DIV == EPWM_HSCLOCK_DIVIDER_1)
    #define BTS_DRV_EPWM_TOTAL_CLKDIV     ((uint16_t)0x1 << BTS_DRV_EPWM_EPWMCLK_DIV)
#else
    #define BTS_DRV_EPWM_TOTAL_CLKDIV     (((uint16_t)0x1 << BTS_DRV_EPWM_EPWMCLK_DIV) * (BUCK_DRV_EPWM_HSCLK_DIV << 1))
#endif



#define BTS_DRV_EPWM_PERIOD_TICKS         ((uint32_t)(BTS_EPWM_HZ / BTS_DRV_EPWM_SWITCHING_FREQUENCY / BTS_DRV_EPWM_TOTAL_CLKDIV))
#define BTS_DRV_EPWM_TBPRD                ((uint32_t)BTS_DRV_EPWM_PERIOD_TICKS - 1)
#define BTS_DRV_EPWM_PERIOD_SEC           ((uint32_t)BTS_DRV_EPWM_PERIOD_TICKS / BTS_EPWM_HZ)
#define BTS_DRV_EPWM_DEADBAND_RED         ((uint16_t)(150 / BTS_EPWM_NS))
#define BTS_DRV_EPWM_DEADBAND_FED         ((uint16_t)(150 / BTS_EPWM_NS))
#define BTS_DRV_EPWM_DC_TRIP_OC           EPWM_DC_TRIP_TRIPIN4
#define BTS_DRV_EPWM_DC_TRIP_PCMC         EPWM_DC_TRIP_TRIPIN5

//
// Converter switching frequency. A FIXED figure, deliberately no longer
// derived from BTS_DRV_ADC_SWITCHING_FREQUENCY.
//
// It used to be (CLKIN / 2 / 128) * 3, which with the old 8.5 MHz CLKIN
// constant came to 99,609.375 Hz and TBPRD 902 (99.67 kHz actual). Lowering
// CLKIN to 8.192 MHz through that formula would have silently moved the
// converter to 96 kHz and TBPRD 936 - changing the inductor ripple, the
// CLA's sample rate and every alpha tied to it. The ADS131M08 and the
// switching stage are not synchronised (separate ePWMs, no SYNC/RESET
// alignment), so nothing requires the two to be related.
//
// 99,609.375 keeps TBPRD 902, exactly what has run on the board.
//
#define BTS_DRV_EPWM_SWITCHING_FREQUENCY  ((float32_t)99609.375)

// 99,609.375 Hz requested -> TBPRD 902 -> 99.67 kHz actual

#define BTS_DRV_ADC_EPWMCLK_DIV          EPWM_CLOCK_DIVIDER_1
#define BTS_DRV_ADC_HSCLK_DIV            EPWM_HSCLOCK_DIVIDER_1

#if(BTS_DRV_ADC_HSCLK_DIV == EPWM_HSCLOCK_DIVIDER_1)
    #define BTS_DRV_ADC_TOTAL_CLKDIV     ((uint16_t)0x1 << BTS_DRV_ADC_EPWMCLK_DIV)
#else
    #define BTS_DRV_ADC_TOTAL_CLKDIV     (((uint16_t)0x1 << BTS_DRV_ADC_EPWMCLK_DIV) * (BUCK_DRV_ADC_HSCLK_DIV << 1))
#endif

//
// ADS131M08 master clock (CLKIN), driven by EPWM11A (ADC1, slots 1-4) and
// EPWM12A (ADC2, slots 5-8). See BTS_HAL_setupAdcClock().
//
// The period is the NEAREST integer to EPWMCLK / f, not the truncated one.
// The truncating divide this used to be turned a requested 8.5 MHz into
// TBPRD 9 and an actual 90 MHz / 10 = 9.0 MHz - read back off EPwm11Regs
// on 2026-10-10 - 7% above the part's 8.4 MHz limit for high-resolution
// mode (datasheet SBAS950B, 6.3: fCLKIN 0.3 / 8.192 / 8.4 MHz at gain 1-2).
//
// 8.192 MHz nominal rounds to TBPRD 10: 90 MHz / 11 = 8.1818 MHz, 0.13%
// under nominal. Duty 50% (toggle at zero and at CMPA = TBPRD/2), inside the
// 40-60% window. That gives fMOD 4.091 MHz and, at OSR 128,
// fDATA = 31.96 kSPS - see BTS_ADS131_FDATA_HZ.
//
#define BTS_DRV_ADC_PERIOD_TICKS         ((uint32_t)(((BTS_EPWM_HZ) / BTS_DRV_ADC_SWITCHING_FREQUENCY / BTS_DRV_ADC_TOTAL_CLKDIV) + (float32_t)0.5))
#define BTS_DRV_ADC_TBPRD                ((uint32_t)BTS_DRV_ADC_PERIOD_TICKS - 1)
#define BTS_DRV_ADC_PERIOD_SEC           ((uint32_t)BTS_DRV_ADC_PERIOD_TICKS / BTS_EPWM_HZ / 2)

#define BTS_DRV_ADC_SWITCHING_FREQUENCY  ((float32_t)8192 * 1000)

//
// ADC acquisition rate for adcCellVoltageISR (cell V/I on the internal ADC).
//
// EPWM1 is shared between channel 1's switching leg and the ADC SOCA
// trigger. Its period belongs to the converter (BTS_DRV_EPWM_TBPRD = 902 on
// this device, giving 99.67 kHz switching at EPWMCLK = SYSCLK/2 = 90 MHz -
// SYSCLK is 180 MHz here, NOT the 200 MHz of the LaunchPad branch).
//
// PRESCALE 1: THE ADC NOW SAMPLES 1:1 WITH THE SWITCHING PERIOD.
//
//   99.67 kHz / 1 = 99.67 kSPS
//
// This is only affordable because the C28x is no longer in the fast path.
// CLA1 task 1 consumes the sweep - see bts_cla.cla - and the C28x sees the
// data at 10 Hz through BTS_updateFilteredTelemetry() in C1(). A CPU ISR at
// 99.67 kHz would be an interrupt every 10.03 us on a core already running
// the ADS131M08 control loops off their DRDY interrupts.
//
// ADCA is the busiest converter at 7 SOCs; at 622 ns per SOC that is a
// 4.36 us sweep inside a 10.03 us period, so roughly 43% converter
// utilisation with the sweep comfortably complete before the next trigger.
//
// The prescaler is KEPT rather than deleted even though it now divides by 1:
// it is the one knob that can slow acquisition without touching the switching
// frequency. Range is 1..15 - driverlib ASSERTs preScaleCount < 16 - so 15,
// giving 6.645 kSPS, is the slowest reachable here. A sub-100 Hz acquisition
// is NOT reachable this way at all: EPWM1's period belongs to channel 1's
// converter and cannot be stretched, so a much slower rate would need a
// separate timer-triggered SOC source.
//
// BTS_CLA_ALPHA in bts_cla_shared.h is derived from whatever rate this
// produces - CHANGE ONE AND THE FILTER'S CORNER FREQUENCY MOVES. It has been
// re-derived at every rate this setting has had; the table is in
// bts_cla_shared.h.
//
// History for the next person, because three different figures appear in the
// commit log and only the last is real: the surrounding comment once claimed
// prescale 10 and 9.97 kSPS while the constant actually said 15 and the true
// rate was 6.645 kSPS, and SYSCLK was assumed to be 200 MHz when it is 180.
// The "124.5 kHz / 8.3 kSPS" in the original note assumed a clock this device
// does not run at either. Confirmed on the live device: TBPRD = 902,
// PERCLKDIVSEL = 0x51, ETPS = 0x0820 (SOCPSSEL set), SOCAPRD2 in ETSOCPS.
//
#define BTS_ADC_SOC_PRESCALE              ((uint16_t)1)

// Sampling speed of 33,203.125 Hz

#if(BTS_DRV_EPWM_HR_ENABLED == true)
    #define BTS_DRV_EPWM_CMPAHR_BITS          8
    #define BTS_DRV_EPWM_CMPAHR_SCALE         ((uint16_t)0x1 << BUCK_DRV_EPWM_CMPAHR_BITS)
    #define BTS_DRV_EPWM_CMPBHR_BITS          8
    #define BTS_DRV_EPWM_CMPBHR_SCALE         ((uint16_t)0x1 << BUCK_DRV_EPWM_CMPBHR_BITS)
#endif


//
// Heart beat LED on board
//
#define BTS_RUN_LED_GPIO                  47
#define BTS_RUN_LED_PIN_CONFIG            GPIO_47_GPIO47
#define BTS_RUN_LED_PRESCALE              ((uint16_t)5)

#endif /* BTS_USER_SETTINGS_H_ */
