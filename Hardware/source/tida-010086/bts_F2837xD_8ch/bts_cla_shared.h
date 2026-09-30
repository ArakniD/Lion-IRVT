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
//   alpha = 2*pi*fc / fs,  fc = 20 Hz,  fs = 99.67 kSPS
//         = 2*pi*20 / 99670 = 0.0012608
//
// fs is the ADC trigger rate, which since the prescaler went to 1 is the
// switching frequency itself. The chain was VERIFIED ON HARDWARE rather than
// derived from the settings header, which used to contradict itself:
//
//   PERCLKDIVSEL = 0x51      -> EPWMCLKDIV /2, so EPWMCLK = SYSCLK/2 = 90 MHz
//   SYSCLK       = 180 MHz   -> device.h non-LaunchPad branch (IMULT 18)
//   EPwm1Regs.TBCTL  = 0x8010 -> up-count, both TB dividers /1
//   EPwm1Regs.TBPRD  = 902    -> 90e6 / 903 = 99.67 kHz switching
//   EPwm1Regs.ETPS   = 0x0820 -> SOCPSSEL set, so ETSOCPS holds the divider
//   EPwm1Regs.ETSOCPS-> SOCAPRD2 = BTS_ADC_SOC_PRESCALE
//
//   99.67 kHz / 1 = 99.67 kSPS
//
// ALPHA IS TIED TO fs, SO THE TWO MOVE TOGETHER. The corner stays at 20 Hz
// across the rate change; only the per-sample step shrinks, because there are
// 15x as many samples in the same second. Settling is ~36.6 ms to within 1%,
// against the 100 ms telemetry period - so a reported value is still a true
// average of the interval rather than a snapshot of part of it.
//
// History, because two earlier values are recorded in commits and in the
// docs: 0.012605 assumed 9.97 kSPS and delivered a 13.3 Hz corner, and
// 0.018912 was correct for the 6.645 kSPS the prescaler used to give. Neither
// is right for this rate.
//
#define BTS_CLA_ALPHA   0.0012608f

//
// Filter state and liveness counter. Written by Cla1Task1 at the ADC rate,
// read by C1() at 10 Hz.
//
// Both sides see a 32-bit aligned float, so a read is a single access on the
// C28x and a single store on the CLA - no lock is needed and none is possible
// (the CLA cannot be made to wait). A torn value is not reachable for the
// floats; BTS_claRunCount is a 32-bit object at an even address, so it is a
// single MOVL on the C28x and a single MMOV32 on the CLA - also untearable.
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
// 32-BIT, AND THE WIDTH IS LOAD BEARING. The test is inequality against the
// value seen on the previous pass, so the counter must not be able to wrap
// back onto that value inside one observation period.
//
// It very nearly could. At 99.67 kSPS a 16-bit counter wraps every 657 ms,
// and while C1()'s NOMINAL period is 100 ms, C1() was MEASURED ON HARDWARE at
// 0.69 Hz - a ~1.45 s period, longer than the wrap. CPU1's whole A/B/C task
// chain runs about 9x below nominal and the cause is still open; see the
// project note bts-cpu1-task-chain-runs-slow.
//
// A 16-bit counter could therefore read the same value on two consecutive
// passes with the CLA running perfectly, claFastStale would latch to 1,
// BTS_refreshCellFromCla() would stop updating, and the cell readings the
// reverse polarity check trusts would freeze - the exact failure this counter
// exists to detect, produced by the detector itself. At 32 bits the wrap is
// ~12 hours, which no plausible task rate can alias.
//
// This is why the rate change had to widen it: at the old 6.645 kSPS the
// 16-bit wrap was 9.86 s and even the measured 1.45 s period had 6.8x margin.
//
extern volatile uint32_t BTS_claRunCount;

//
// FAST filter state - the protection path's copy.
//
// Separate from the 20 Hz pair above because the two exist for opposite
// reasons. The 20 Hz filter is for a display and may lag; THIS pair replaces
// what adcCellVoltageISR's 8-deep ring used to provide to the reverse
// polarity check, group supervision and BTS_cellVoltageAsCtrl16b(), and those
// must not lag.
//
// BTS_CLA_FAST_ALPHA is set so the response matches the old ring's: the ring
// was an 8-sample box mean, and a single-pole IIR with alpha = 2/(N+1) has
// the same settling time as an N-sample mean. At 99.67 kSPS that is ~184 us
// to settle within 1%, against the 1204 us the ring spanned at the old rate -
// so the protection path got faster, not slower, as well as being refreshed
// every sweep instead of once per telemetry pass.
//
extern volatile float32_t BTS_claCellVoltageFast[BTS_CLA_NUM_CH];
extern volatile float32_t BTS_claCellCurrentFast[BTS_CLA_NUM_CH];

//
//   alpha = 2 / (N + 1),  N = BTS_f28AverageFactor = 8
//
#define BTS_CLA_FAST_ALPHA   0.22222f

//
// 0 until the task has run once. The first pass loads the state with the raw
// sample instead of filtering towards it from zero, so the reported voltage
// does not ramp up from 0 V over the first 37 ms of every boot.
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
