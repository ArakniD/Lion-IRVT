/*
 * bts_cla_data.c
 *
 * Definitions of the CPU1 <-> CLA1 shared filter state.
 *
 * This file exists because of a hard constraint in the toolchain, not as an
 * organisational preference: the CLA compiler cannot export a symbol the C28x
 * linker will resolve, so every object both sides touch has to be defined in
 * C and merely declared in the .cla source. See bts_cla_shared.h.
 *
 * #pragma DATA_SECTION puts them in CLADataLS5, which 2837xD_RAM_lnk_cpu1.cmd
 * maps to RAMLS5. RAMLS5 is handed to CLA1 as data memory in BTS_initCla().
 *
 * Guarded on CPU1: the project compiles every root-level source under both
 * build configurations, and CPU2's CLA is reserved for the ADS131M08 current
 * control loop in a later phase. Its linker file declares no RAMLS block at
 * all, so a CLADataLS5 section on that core would not place.
 *
 * Copyright (C) 2026 - see repository licence.
 */

#ifdef CPU1

#include "bts_cla_shared.h"
#include "registers.h"

//
// The CLA cannot include registers.h, so BTS_CLA_NUM_CH is a literal there.
// Catch any future change to NUM_CHANNELS at compile time rather than letting
// the CLA quietly filter the wrong number of slots.
//
#if (BTS_CLA_NUM_CH != NUM_CHANNELS)
#error "BTS_CLA_NUM_CH in bts_cla_shared.h must match NUM_CHANNELS"
#endif

#pragma DATA_SECTION(BTS_claCellVoltageFilt, "CLADataLS5")
volatile float32_t BTS_claCellVoltageFilt[BTS_CLA_NUM_CH];

#pragma DATA_SECTION(BTS_claCellCurrentFilt, "CLADataLS5")
volatile float32_t BTS_claCellCurrentFilt[BTS_CLA_NUM_CH];

#pragma DATA_SECTION(BTS_claRunCount, "CLADataLS5")
volatile uint16_t BTS_claRunCount;

#pragma DATA_SECTION(BTS_claPrimed, "CLADataLS5")
volatile uint16_t BTS_claPrimed;

#endif /* CPU1 */
