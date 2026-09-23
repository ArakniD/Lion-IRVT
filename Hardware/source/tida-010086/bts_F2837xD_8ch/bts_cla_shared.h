/*
 * bts_cla_shared.h
 *
 * Contract between CPU1's C code and the CLA1 task in bts_cla.cla.
 *
 * TI's rule, quoted verbatim from their own asin.cla:
 *
 *   "the globals defined in the .cla source are global to the cla source
 *    file. i.e. they may be shared across tasks. All of the data shared
 *    between the CLA and the C28x CPU must be defined in the C (or C++)
 *    code, and not the CLA code."
 *
 * So every object below is DEFINED in bts_cla_data.c and only declared here.
 * bts_cla_data.c places them in the CLADataLS5 section, which the CPU1 linker
 * command file maps to RAMLS4/RAMLS5's data half - the CLA's address bus is
 * 16 bits wide (TRM 6.7.2), so nothing outside an LSx block is reachable.
 *
 * The task prototypes are here for the same reason TI puts them in
 * cla_ex1_asin_shared.h: declaring them makes the CLA compiler emit them as
 * .global so BTS_initCla() can take their addresses for the MVECT registers.
 *
 * Copyright (C) 2026 - see repository licence.
 */

#ifndef BTS_CLA_SHARED_H_
#define BTS_CLA_SHARED_H_

//
// hw_types.h does NOT include <stdint.h>; it typedefs uint8_t/int8_t from
// uint16_t/int16_t and assumes the caller has already pulled the fixed-width
// types in. driverlib.h does that for the C28x sources; this header is also
// read by bts_cla.cla, which deliberately does not include driverlib.h, so it
// has to pull them in itself.
//
#include <stdint.h>
#include "inc/hw_types.h"

#ifdef __cplusplus
extern "C" {
#endif

//
// Channel count as the CLA sees it. Deliberately a literal rather than
// NUM_CHANNELS from registers.h: that header drags in the whole register map
// and is not CLA-safe. bts_cla_data.c #errors if the two ever diverge.
//
#define BTS_CLA_NUM_CH  8

//
// Single-pole IIR coefficient:  y += alpha * (x - y)
//
//   alpha = 2*pi*fc / fs,  fc = 20 Hz,  fs = 6.645 kSPS
//         = 2*pi*20 / 6645 = 0.018912
//
// fs is set by the ADC trigger chain and was VERIFIED ON HARDWARE rather
// than derived from the settings header, which contradicts itself:
//
//   PERCLKDIVSEL = 0x51      -> EPWMCLKDIV /2, so EPWMCLK = SYSCLK/2 = 90 MHz
//   SYSCLK       = 180 MHz   -> device.h non-LaunchPad branch (IMULT 18)
//   EPwm1Regs.TBCTL  = 0x8010 -> up-count, both TB dividers /1
//   EPwm1Regs.TBPRD  = 902    -> 90e6 / 903 = 99.67 kHz switching
//   EPwm1Regs.ETPS   = 0x0820 -> SOCPSSEL set, so ETSOCPS holds the divider
//   EPwm1Regs.ETSOCPS= 0x005F -> SOCAPRD2 = 15
//
//   99.67 kHz / 15 = 6.645 kSPS
//
// BTS_ADC_SOC_PRESCALE is 15, not the 10 its own comment block claims - and
// SYSCLK is 180 MHz, not the 200 MHz implied by "EPWMCLK = 100 MHz". Both
// errors predate the CLA. Taking the header at its word gives alpha 0.012605
// and a 13.3 Hz corner, which is NOT the 20 Hz this filter is specified at.
//
// ~12 ms to settle to within 1%, against the 100 ms telemetry period - so the
// reported value is a true average of the interval rather than the 1.2 ms
// aliased snapshot the 8-deep ring gives.
//
#define BTS_CLA_ALPHA   0.018912f

//
// Filter state and liveness counter. Written by Cla1Task1 at the ADC rate,
// read by C1() at 10 Hz.
//
// Both sides see a 32-bit aligned float, so a read is a single access on the
// C28x and a single store on the CLA - no lock is needed and none is possible
// (the CLA cannot be made to wait). A torn value is not reachable for the
// floats; BTS_claRunCount is 16-bit and therefore single-access on both sides
// too.
//
// Units are raw ADC counts, NOT volts. C1() applies the same
// counts -> engineering conversion BTS_monitor_Iout_Vout() uses.
//
extern volatile float32_t BTS_claCellVoltageFilt[BTS_CLA_NUM_CH];
extern volatile float32_t BTS_claCellCurrentFilt[BTS_CLA_NUM_CH];

//
// Incremented once per task run. C1() watches it to decide whether the CLA is
// actually running; if it ever stops advancing the telemetry falls back to the
// unfiltered value rather than reporting a frozen - or zero - reading.
//
// 16-bit on purpose. It is only ever tested for inequality, and at 6.645 kSPS
// it wraps every 9.86 s against a 100 ms observation period - so a wrap can
// never alias two consecutive reads into looking equal.
//
extern volatile uint16_t BTS_claRunCount;

//
// 0 until the task has run once. The first pass loads the state with the raw
// sample instead of filtering towards it from zero, so the reported voltage
// does not ramp up from 0 V over the first 12 ms of every boot.
//
extern volatile uint16_t BTS_claPrimed;

//
// Symbols defined in the CLA assembly output. Declaring them here makes them
// .global, which is what lets the C28x take their addresses.
//
__interrupt void Cla1Task1(void);
__interrupt void Cla1Task2(void);
__interrupt void Cla1Task3(void);
__interrupt void Cla1Task4(void);
__interrupt void Cla1Task5(void);
__interrupt void Cla1Task6(void);
__interrupt void Cla1Task7(void);
__interrupt void Cla1Task8(void);

#ifdef __cplusplus
}
#endif

#endif /* BTS_CLA_SHARED_H_ */
