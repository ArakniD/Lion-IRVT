//#############################################################################
//
// FILE:   ttplpfc.c
//
// TITLE: This is the solution file.
//
//#############################################################################
// $TI Release: TIDM_1007 v1.00.02.00 $
// $Release Date: Tue Mar 23 14:55:26 CDT 2021 $
// $Copyright:
// Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
//
// ALL RIGHTS RESERVED
// $
//#############################################################################

//
// the includes
//

#include "ttplpfc.h"

//
// System Related
//
#pragma SET_DATA_SECTION("controlVariables")

//
// RAMP to generate forced angle when grid is not presentting
//
RAMPGEN TTPLPFC_rgen;

TTPLPFC_GI_STRUCT TTPLPFC_gi;
TTPLPFC_GV_STRUCT TTPLPFC_gv;

SPLL_1PH_SOGI TTPLPFC_spll1;
SPLL_1PH_NOTCH TTPLPFC_spll2;
SPLL_1PH_SOGI_FLL TTPLPFC_spll3;

TTPLPFC_NOTCH_2P2Z_STRUCT TTPLPFC_notch1;
TTPLPFC_NOTCH_2P2Z_STRUCT TTPLPFC_notch2;
TTPLPFC_NOTCH_2P2Z_STRUCT TTPLPFC_notch_50Hz;
TTPLPFC_NOTCH_2P2Z_STRUCT TTPLPFC_notch_60Hz;
TTPLPFC_NOTCH_2P2Z_STRUCT TTPLPFC_spll_notch_50Hz;
TTPLPFC_NOTCH_2P2Z_STRUCT TTPLPFC_spll_notch_60Hz;

//
// Sine analyzer block for RMS Volt, Curr and Power measurements
//
POWER_MEAS_SINE_ANALYZER TTPLPFC_sine_mains;

uint16_t TTPLPFC_guiPowerStageStart;
uint16_t TTPLPFC_guiPowerStageStop;

volatile TTPLPFC_Lab_EnumType TTPLPFC_lab;
volatile TTPLPFC_boardState TTPLPFC_board_State;
volatile TTPLPFC_boardStatus TTPLPFC_board_Status;

//
// Inductor Current Measurement
//
float32_t TTPLPFC_iL1_sensed_pu;
float32_t TTPLPFC_iL2_sensed_pu;
float32_t TTPLPFC_iL3_sensed_pu;
float32_t TTPLPFC_iL1_senseOffset_pu;
float32_t TTPLPFC_iL2_senseOffset_pu;
float32_t TTPLPFC_iL3_senseOffset_pu;
float32_t TTPLPFC_iL1_sensed_Amps;
float32_t TTPLPFC_iL2_sensed_Amps;
float32_t TTPLPFC_iL3_sensed_Amps;

//
// AC Current Measurement
//
float32_t TTPLPFC_ac_cur_sensed_pu;
float32_t TTPLPFC_ac_cur_senseOffset_pu;
float32_t TTPLPFC_ac_cur_sensed_Amps;

//
// AC Grid Sync offset
//
float32_t TTPLPFC_thetaOffset_pu;

//
// AC Drop Test Variables
//
float32_t TTPLPFC_acSine_regen;
float32_t TTPLPFC_acCosine_regen;
float32_t TTPLPFC_regen_theta;
float32_t TTPLPFC_acSine_regen_freq;
float32_t TTPLPFC_acSine_regen_ISRperiod;
float32_t TTPLPFC_ac_vol_regen_Volts;
float32_t TTPLPFC_ac_vol_regen_magnitude;
float32_t TTPLPFC_ac_volRMS_regen_Volts;
uint16_t TTPLPFC_acDrop_flag;
uint16_t TTPLPFC_autoStart_disable;
uint16_t TTPLPFC_UVP_disable;
uint16_t TTPLPFC_syncInit_cnt;
uint16_t TTPLPFC_clearTrip_cnt;
uint16_t TTPLPFC_ac_resume_cnt;
uint16_t TTPLPFC_acFault_cnt;
uint16_t TTPLPFC_brownOut_cnt;
uint16_t TTPLPFC_brownOut_state;
uint16_t TTPLPFC_brownOut_resume_cnt;
uint16_t TTPLPFC_brownOut_flag;

//
// Output Voltage measurement
//
volatile float32_t TTPLPFC_vBus_sensed_pu;
volatile float32_t TTPLPFC_vBus_sensedOffset_pu;
volatile float32_t TTPLPFC_vBus_sensed_Volts;

//
// Input voltage measurement
//
volatile float32_t TTPLPFC_ac_L_sensed_pu;
volatile float32_t TTPLPFC_ac_N_sensed_pu;
volatile float32_t TTPLPFC_ac_vol_sensed_pu;
volatile float32_t TTPLPFC_ac_vol_sensed_Volts;
volatile float32_t TTPLPFC_ac_L_senseOffset_pu;
volatile float32_t TTPLPFC_ac_N_senseOffset_pu;
volatile float32_t TTPLPFC_ac_vol_senseOffset_pu;

//
// Filtered DC bus measurement
//
volatile float32_t TTPLPFC_vBusAvg_pu;
volatile float32_t TTPLPFC_vRmsAvg_pu;

volatile float32_t TTPLPFC_threshold_PZC1;
volatile float32_t TTPLPFC_threshold_PZC2;
volatile float32_t TTPLPFC_threshold_NZC1;
volatile float32_t TTPLPFC_threshold_NZC2;

//
// Current set point
//
volatile float32_t TTPLPFC_ac_cur_ref_pu;
float32_t TTPLPFC_ac_cur_ref_inst_pu;
float32_t TTPLPFC_ac_cur_ref_inst_prev_pu;
volatile float32_t TTPLPFC_inductor_voltage_drop_feedforward;

//
// Voltage set point
//
volatile float32_t TTPLPFC_vBusRef_pu;
volatile float32_t TTPLPFC_vBusRefSlewed_pu;

//
// Adaptive Dead Time variables
// 10 corresponds to 100ns dead time
//
uint32_t TTPLPFC_dbRED_SetValue_ticks;
uint32_t TTPLPFC_dbRED_SetValue_Temp_ticks;
uint32_t TTPLPFC_dbFED_SetValue_ticks;
uint32_t TTPLPFC_dbRED_SetValue1_ticks;
uint32_t TTPLPFC_dbRED_SetValue_Temp1_ticks;
uint32_t TTPLPFC_dbRED_SetValue2_ticks;
uint32_t TTPLPFC_dbRED_SetValue_Temp2_ticks;
uint32_t TTPLPFC_dbRED_SetValue3_ticks;
uint32_t TTPLPFC_dbRED_SetValue_Temp3_ticks;
uint32_t TTPLPFC_dbRED_Min_ticks;
uint32_t TTPLPFC_dbRED_Max_ticks;

volatile float32_t TTPLPFC_softstart_duty;

//
// Display Values
//
volatile float32_t TTPLPFC_vBus_overVoltage_Volts;
volatile float32_t TTPLPFC_vBus_underVoltage_Volts;
volatile float32_t TTPLPFC_dutyPU;
volatile float32_t TTPLPFC_powerRms_Watts;
volatile float32_t TTPLPFC_ac_curRms_sensed_Amps;
volatile float32_t TTPLPFC_ac_volRms_sensed_Volts;
volatile float32_t TTPLPFC_ac_volRms_overVoltage_Volts;
volatile float32_t TTPLPFC_ac_volRms_underVoltage_Volts;
volatile float32_t TTPLPFC_powerFactor;
volatile float32_t TTPLPFC_apparentPower_VA;
volatile float32_t TTPLPFC_acFreqAvg_Hz;
volatile float32_t TTPLPFC_ac_volEma_sensed_Volts;
volatile float32_t TTPLPFC_ac_volRmsEma_sensed_Volts;
volatile int32_t TTPLPFC_autoStartSlew;

//
// Phase-Shedding Variables
//
volatile float32_t TTPLPFC_iref1_pu;
volatile float32_t TTPLPFC_iref2_pu;
volatile float32_t TTPLPFC_deltaIref_pu;

//
// per unit duty value
//
volatile float32_t TTPLPFC_dutyPU;
volatile float32_t TTPLPFC_dutyPU_DC;

//
// Flags for clearing trips and closing the loops and the Relay
//
volatile int32_t TTPLPFC_closeGiLoop;
volatile int32_t TTPLPFC_closeGvLoop;
volatile int32_t TTPLPFC_clearTrip;
volatile int32_t TTPLPFC_rlyConnect;
volatile int32_t TTPLPFC_firstTimeGvLoop;

//
// Flags for detecting ZCD
//
volatile float32_t TTPLPFC_acSine;
volatile float32_t TTPLPFC_acSinePrev;
volatile float32_t TTPLPFC_acCosine;
volatile float32_t TTPLPFC_acCosinePrev;
volatile int32_t TTPLPFC_zeroCrossDetectFlag;
int32_t TTPLPFC_posZeroCrossingStart;
int32_t TTPLPFC_negZeroCrossingStart;
volatile TTPLPFC_pwmSwState TTPLPFC_pwm_SwState;
volatile TTPLPFC_acVolState TTPLPFC_ac_vol_State;
volatile TTPLPFC_interleavingState TTPLPFC_interleaving_State;
volatile int32_t TTPLPFC_state_slew = 0;
volatile int32_t TTPLPFC_state_slew_max = 10;

volatile float32_t TTPLPFC_gi_out;
volatile float32_t TTPLPFC_gv_out;

volatile float32_t TTPLPFC_vBusSensedBuff[10];
volatile float32_t TTPLPFC_vBus_sensedFiltered;
volatile int32_t TTPLPFC_vBusSensedBuffIndex = 0;

volatile float32_t TTPLPFC_vBus_sensedFiltered_notch1;
volatile float32_t TTPLPFC_vBus_sensedFiltered_notch2;

volatile float32_t TTPLPFC_ac_vol_sensed_buff[5];
volatile int32_t TTPLPFC_ac_vol_sensed_buff_index = 0;
volatile int32_t TTPLPFC_ac_sign_filtered;

volatile float32_t TTPLPFC_spll_sine;
volatile float32_t TTPLPFC_spll_cosine;
volatile float32_t TTPLPFC_voltage_error;

//
// 1 if using non linear voltage loop, 0 otherwise
//
volatile uint32_t TTPLPFC_nonLinearVoltageLoopFlag;
volatile uint32_t TTPLPFC_nonLinearVoltageLoopFlagDelay;

volatile uint32_t TTPLPFC_softStartDeadBandFED;

//
// Variables used to calibrate measurement offsets
// Offset filter coefficient K1: 0.05/(T+0.05);
//
float32_t k1 = 0.998f;

//
//Offset filter coefficient K2: T/(T+0.05)
//
float32_t k2 = 0.001999f;

volatile float32_t TTPLPFC_phase1ScaleFactor = 1.0f;
volatile float32_t TTPLPFC_phase2ScaleFactor = 1.0f;
volatile float32_t TTPLPFC_phase3ScaleFactor = 1.0f;

////
//// Variable to log how many times ISR1 is nested from
////
volatile int32_t TTPLPFC_ISR1_nestingCounter;
volatile int32_t TTPLPFC_ISR1_nests;
volatile int32_t TTPLPFC_ISR1_nestsMax;
volatile float32_t TTPLPFC_ISR1_nestsAvg;

//
// eCAP Profiling related variables
//

//
// Variables to log the capture value for profiling ISR1
//
uint32_t  TTPLPFC_ISR1cap1Count;
uint32_t  TTPLPFC_ISR1cap2Count;
uint32_t  TTPLPFC_ISR1cap3Count;
uint32_t  TTPLPFC_ISR1cap4Count;

//
// Variable for logging the the max value and also computing the average for ISR1
//
uint32_t TTPLPFC_ISR1_capCountMax;
float32_t TTPLPFC_ISR1cap1CountAvg;
float32_t TTPLPFC_ISR2_LoadingAvg_accountingForNesting;

//
// Variables to compute the loading percentage for ISR1
//
float32_t TTPLPFC_ISR1_Loading;
float32_t TTPLPFC_ISR1_LoadingMax;

//
// Variables to log the capture value for profiling ISR2
//
uint32_t  TTPLPFC_ISR2cap1Count;
uint32_t  TTPLPFC_ISR2cap2Count;
uint32_t  TTPLPFC_ISR2cap3Count;
uint32_t  TTPLPFC_ISR2cap4Count;

//
// Variables to compute the loading percentage for ISR2
// subtracts the ISR1 nesting cycles
//
float32_t TTPLPFC_ISR2_Loading;
float32_t TTPLPFC_ISR2_LoadingAvg;

uint32_t TTPLPFC_Regen_cnt;
uint32_t TTPLPFC_Regen_cnt_Max;
uint32_t TTPLPFC_SPLL_regen_syncOn;
uint32_t TTPLPFC_acDrop_cnt;

//
// Variables for ac drop and brown out shutdown counter
//
float32_t TTPLPFC_ac_period_sec;
float32_t TTPLPFC_ISR1_period_sec;
float32_t TTPLPFC_acSine_brownOutMax_sec;
float32_t TTPLPFC_acSine_acDropMax_sec;
uint32_t TTPLPFC_acSine_brownOutMax_cnt;
uint32_t TTPLPFC_acSine_acDropMax_cnt;
float32_t TTPLPFC_syncInitMax_sec;
uint32_t TTPLPFC_syncInitMax_cnt;
float32_t TTPLPFC_ac_resumeMax_sec;
uint32_t TTPLPFC_ac_resumeMax_cnt;
uint32_t TTPLPFC_ac_period_cnt;

#pragma SET_DATA_SECTION()

//
// datalogger
//
DLOG_4CH TTPLPFC_dLog1;
float32_t TTPLPFC_dBuff1[100];
float32_t TTPLPFC_dBuff2[100];
float32_t TTPLPFC_dBuff3[100];
float32_t TTPLPFC_dBuff4[100];
float32_t TTPLPFC_dVal1;
float32_t TTPLPFC_dVal2;
float32_t TTPLPFC_dVal3;
float32_t TTPLPFC_dVal4;

//
// SFRA Related Variables
//
#if TTPLPFC_SFRA_TYPE != TTPLPFC_SFRA_DISABLED
float32_t TTPLPFC_plantMagVect[TTPLPFC_SFRA_FREQ_LENGTH];
float32_t TTPLPFC_plantPhaseVect[TTPLPFC_SFRA_FREQ_LENGTH];
float32_t TTPLPFC_olMagVect[TTPLPFC_SFRA_FREQ_LENGTH];
float32_t TTPLPFC_olPhaseVect[TTPLPFC_SFRA_FREQ_LENGTH];
float32_t TTPLPFC_freqVect[TTPLPFC_SFRA_FREQ_LENGTH];
#endif

SFRA_F32 TTPLPFC_sfra1;

#if TTPLPFC_SFRA_TYPE != TTPLPFC_SFRA_DISABLED
void TTPLPFC_setupSFRA(void)
{
    int16_t i;

    SFRA_F32_reset(&TTPLPFC_sfra1);

    SFRA_F32_config(&TTPLPFC_sfra1,
                    TTPLPFC_SFRA_ISR_FREQ,
                    TTPLPFC_SFRA_AMPLITUDE,
                    TTPLPFC_SFRA_FREQ_LENGTH,
                    TTPLPFC_SFRA_FREQ_START,
                    TTPLPFC_SFRA_FREQ_STEP_MULTIPLY,
                    TTPLPFC_plantMagVect,
                    TTPLPFC_plantPhaseVect,
                    TTPLPFC_olMagVect,
                    TTPLPFC_olPhaseVect,
                    NULL,
                    NULL,
                    TTPLPFC_freqVect,
                    1);

    SFRA_F32_resetFreqRespArray(&TTPLPFC_sfra1);

    //
    // Re-initialize the frequency array to make SFRA sweep go fast
    //
    i = 0;

    #if TTPLPFC_SFRA_TYPE == TTPLPFC_SFRA_CURRENT// current loop
        TTPLPFC_sfra1.freqVect[i++] = TTPLPFC_SFRA_FREQ_START;
        for(;i < TTPLPFC_sfra1.vecLength;i++)
        {
            if(TTPLPFC_sfra1.freqVect[i - 1] < 10)
                TTPLPFC_sfra1.freqVect[i] =
                        TTPLPFC_sfra1.freqVect[i - 1] + 2;
            else if(TTPLPFC_sfra1.freqVect[i - 1] < 50)
                TTPLPFC_sfra1.freqVect[i] =
                        TTPLPFC_sfra1.freqVect[i - 1] + 10;
            else
                TTPLPFC_sfra1.freqVect[i] =
                        TTPLPFC_sfra1.freqVect[i - 1] * TTPLPFC_sfra1.freqStep;
        }
    #else
        TTPLPFC_sfra1.freqVect[0] = 2;
        TTPLPFC_sfra1.freqVect[1] = 4;
        TTPLPFC_sfra1.freqVect[2] = 6;
        TTPLPFC_sfra1.freqVect[3] = 8;
        TTPLPFC_sfra1.freqVect[4] = 10;
        TTPLPFC_sfra1.freqVect[5] = 12;
        TTPLPFC_sfra1.freqVect[6] = 14;
        TTPLPFC_sfra1.freqVect[7] = 16;
        TTPLPFC_sfra1.freqVect[8] = 18;
        TTPLPFC_sfra1.freqVect[9] = 20;
        TTPLPFC_sfra1.freqVect[10] = 22;
        TTPLPFC_sfra1.freqVect[11] = 24;
        TTPLPFC_sfra1.freqVect[12] = 26;
        TTPLPFC_sfra1.freqVect[13] = 28;
        TTPLPFC_sfra1.freqVect[14] = 30;
        TTPLPFC_sfra1.freqVect[15] = 35;
        TTPLPFC_sfra1.freqVect[16] = 40;
        TTPLPFC_sfra1.freqVect[17] = 45;
        TTPLPFC_sfra1.freqVect[18] = 55;
        TTPLPFC_sfra1.freqVect[19] = 65;
        TTPLPFC_sfra1.freqVect[20] = 70;
        TTPLPFC_sfra1.freqVect[21] = 80;
        TTPLPFC_sfra1.freqVect[22] = 90;
        TTPLPFC_sfra1.freqVect[23] = 130;
        TTPLPFC_sfra1.freqVect[24] = 140;
        TTPLPFC_sfra1.freqVect[25] = 150;
        TTPLPFC_sfra1.freqVect[26] = 160;
        TTPLPFC_sfra1.freqVect[27] = 170;
        TTPLPFC_sfra1.freqVect[28] = 210;
        TTPLPFC_sfra1.freqVect[29] = 250;
    #endif

    //
    //configures the SCI channel for communication with SFRA host GUI
    //to change SCI channel change #defines in the settings.h file
    //the GUI also changes a LED status, this can also be changed with #define
    //in the file pointed to above
    //
    SFRA_GUI_config(TTPLPFC_SFRA_GUI_SCI_BASE,
                    TTPLPFC_SCI_VBUS_CLK,
                    TTPLPFC_SFRA_GUI_SCI_BAUDRATE,
                    TTPLPFC_SFRA_GUI_SCIRX_GPIO,
                    TTPLPFC_SFRA_GUI_SCIRX_GPIO_PIN_CONFIG,
                    TTPLPFC_SFRA_GUI_SCITX_GPIO,
                    TTPLPFC_SFRA_GUI_SCITX_GPIO_PIN_CONFIG,
                    TTPLPFC_SFRA_GUI_LED_INDICATOR,
                    TTPLPFC_SFRA_GUI_LED_GPIO,
                    TTPLPFC_SFRA_GUI_LED_GPIO_PIN_CONFIG,
                    &TTPLPFC_sfra1,
                    TTPLPFC_SFRA_GUI_PLOT_OL_PLANT);
}
#endif


void TTPLPFC_globalVariablesInit(void)
{

    RAMPGEN_reset(&TTPLPFC_rgen);
    RAMPGEN_config(&TTPLPFC_rgen,
                   TTPLPFC_CONTROL_ISR_FREQUENCY,
                   TTPLPFC_AC_FREQ);

    TTPLPFC_gi.Kp = TTPLPFC_GI_PI_KP;
    TTPLPFC_gi.Ki = TTPLPFC_GI_PI_KI;
    TTPLPFC_gi.Umax = TTPLPFC_GI_PI_MAX;
    TTPLPFC_gi.Umin = TTPLPFC_GI_PI_MIN;
    TTPLPFC_gi.i10 = 0;
    TTPLPFC_gi.i6 = 0;

    TTPLPFC_gv.Ki = TTPLPFC_GV_PI_KI;
    TTPLPFC_gv.Kp = TTPLPFC_GV_PI_KP;
    TTPLPFC_gv.Umax = TTPLPFC_GV_PI_MAX;
    TTPLPFC_gv.Umin = TTPLPFC_GV_PI_MIN;
    TTPLPFC_gv.i10 = 0;
    TTPLPFC_gv.i6 = 0;

    SPLL_1PH_SOGI_reset(&TTPLPFC_spll1);
    SPLL_1PH_SOGI_config(&TTPLPFC_spll1,
                         TTPLPFC_AC_FREQ,
                         TTPLPFC_CONTROL_ISR_FREQUENCY,
                         (float32_t)(222.2862),
                         (float32_t)(-222.034));

    SPLL_1PH_NOTCH_reset(&TTPLPFC_spll2);
    SPLL_1PH_NOTCH_config(&TTPLPFC_spll2,
                          TTPLPFC_AC_FREQ,
                          TTPLPFC_CONTROL_ISR_FREQUENCY,
                          (float32_t)(222.2862),
                          (float32_t)(-222.034),
                          (float32_t) 0.25,
                          (float32_t) 0.00001);

    SPLL_1PH_SOGI_FLL_reset(&TTPLPFC_spll3);
    SPLL_1PH_SOGI_FLL_config(&TTPLPFC_spll3,
                             TTPLPFC_AC_FREQ,
                             TTPLPFC_CONTROL_ISR_FREQUENCY,
                             (float32_t)(222.2862),
                             (float32_t)(-222.034),
                             (float32_t) 0.5,
                             (float32_t) 20000);

    //
    // Sine analyzer initialization
    //
    POWER_MEAS_SINE_ANALYZER_reset(&TTPLPFC_sine_mains);
    POWER_MEAS_SINE_ANALYZER_config(&TTPLPFC_sine_mains,
                                    TTPLPFC_INSTRUMENTATION_ISR_FREQUENCY,
                                    (float32_t)0.08,
                                    (float32_t)TTPLPFC_GRID_MAX_FREQ,
                                    (float32_t)TTPLPFC_GRID_MIN_FREQ);

    TTPLPFC_computeNotchFltrCoeff(&TTPLPFC_notch1,
                           (float32_t)(TTPLPFC_INSTRUMENTATION_ISR_FREQUENCY),
                           (float32_t)(TTPLPFC_AC_FREQ*2.0) , 0.25f, 0.00001f);
    TTPLPFC_computeNotchFltrCoeff(&TTPLPFC_notch2,
                           (float32_t)(TTPLPFC_INSTRUMENTATION_ISR_FREQUENCY),
                           (float32_t)(TTPLPFC_AC_FREQ*2.0) , 0.25f, 0.00001f);
    TTPLPFC_notch1.x1 = 0;
    TTPLPFC_notch1.x2 = 0;
    TTPLPFC_notch2.x1 = 0;
    TTPLPFC_notch2.x2 = 0;

    TTPLPFC_computeNotchFltrCoeff(&TTPLPFC_notch_50Hz,
                           (float32_t)(TTPLPFC_INSTRUMENTATION_ISR_FREQUENCY),
                           (float32_t)(50*2.0) , 0.25f, 0.00001f);
    TTPLPFC_computeNotchFltrCoeff(&TTPLPFC_notch_60Hz,
                           (float32_t)(TTPLPFC_INSTRUMENTATION_ISR_FREQUENCY),
                           (float32_t)(60*2.0) , 0.25f, 0.00001f);

    TTPLPFC_computeNotchFltrCoeff(&TTPLPFC_spll_notch_50Hz,
                           (float32_t)(TTPLPFC_CONTROL_ISR_FREQUENCY),
                           (float32_t)(50*2.0) , 0.25f, 0.00001f);
    TTPLPFC_computeNotchFltrCoeff(&TTPLPFC_spll_notch_60Hz,
                           (float32_t)(TTPLPFC_CONTROL_ISR_FREQUENCY),
                           (float32_t)(60*2.0) , 0.25f, 0.00001f);

    DLOG_4CH_reset(&TTPLPFC_dLog1);
    DLOG_4CH_config(&TTPLPFC_dLog1,
                    &TTPLPFC_dVal1, &TTPLPFC_dVal2,
                    &TTPLPFC_dVal3, &TTPLPFC_dVal4,
                    TTPLPFC_dBuff1, TTPLPFC_dBuff2,
                    TTPLPFC_dBuff3, TTPLPFC_dBuff4,
                    100, 0.1f, 5);

    TTPLPFC_guiPowerStageStart = 0;
    TTPLPFC_guiPowerStageStop = 0;

    TTPLPFC_vBus_sensed_pu = 0;
    TTPLPFC_powerRms_Watts = 0;
    TTPLPFC_ac_curRms_sensed_Amps = 0;
    TTPLPFC_ac_volRms_sensed_Volts = 0;
    TTPLPFC_ac_volRms_overVoltage_Volts = 270;
    TTPLPFC_ac_volRms_underVoltage_Volts = 75;
    TTPLPFC_vBus_underVoltage_Volts = 110;
    TTPLPFC_acFreqAvg_Hz = 0;
    TTPLPFC_ac_volEma_sensed_Volts = 0;
    TTPLPFC_vBus_overVoltage_Volts = 440;
    TTPLPFC_ac_volRmsEma_sensed_Volts = 0;

    //
    //A.D.T Variables
    //
    TTPLPFC_dbFED_SetValue_ticks =
            TTPLPFC_HIGH_FREQ_PWM_DEADBAND_FED_COUNT;

    TTPLPFC_dbRED_SetValue_ticks =
            TTPLPFC_HIGH_FREQ_PWM_DEADBAND_RED_COUNT;
    TTPLPFC_dbRED_SetValue_Temp_ticks =
            TTPLPFC_HIGH_FREQ_PWM_DEADBAND_RED_COUNT;

    TTPLPFC_dbRED_SetValue1_ticks =
            TTPLPFC_HIGH_FREQ_PWM_DEADBAND_RED_COUNT;
    TTPLPFC_dbRED_SetValue_Temp1_ticks =
            TTPLPFC_HIGH_FREQ_PWM_DEADBAND_RED_COUNT;

    TTPLPFC_dbRED_SetValue2_ticks =
            TTPLPFC_HIGH_FREQ_PWM_DEADBAND_RED_COUNT;
    TTPLPFC_dbRED_SetValue_Temp2_ticks =
            TTPLPFC_HIGH_FREQ_PWM_DEADBAND_RED_COUNT;

    TTPLPFC_dbRED_SetValue3_ticks =
            TTPLPFC_HIGH_FREQ_PWM_DEADBAND_RED_COUNT;
    TTPLPFC_dbRED_SetValue_Temp3_ticks =
            TTPLPFC_HIGH_FREQ_PWM_DEADBAND_RED_COUNT;

    TTPLPFC_dbRED_Min_ticks = TTPLPFC_HIGH_FREQ_PWM_DEADBAND_RED_MIN_COUNT;
    TTPLPFC_dbRED_Max_ticks = TTPLPFC_HIGH_FREQ_PWM_DEADBAND_RED_MAX_COUNT;

    //
    //Variable initialization
    //
    TTPLPFC_iL1_sensed_pu = 0;
    TTPLPFC_iL1_senseOffset_pu = 0;

    TTPLPFC_iL2_sensed_pu = 0;
    TTPLPFC_iL2_senseOffset_pu = 0;

    TTPLPFC_iL3_sensed_pu = 0;
    TTPLPFC_iL3_senseOffset_pu = 0;

    TTPLPFC_ac_cur_sensed_pu = 0;
    TTPLPFC_ac_cur_senseOffset_pu = 0;

    TTPLPFC_vBus_sensed_pu = 0;
    TTPLPFC_vBus_sensedOffset_pu = 0;
    TTPLPFC_vBusRef_pu = TTPLPFC_VBUS_TYPICAL / TTPLPFC_VDCBUS_MAX_SENSE;

    TTPLPFC_ac_cur_ref_pu = 0.03f;

    TTPLPFC_ac_L_sensed_pu = 0;
    TTPLPFC_ac_L_senseOffset_pu = 0;

    TTPLPFC_ac_N_sensed_pu = 0;
    TTPLPFC_ac_N_senseOffset_pu = 0;

    TTPLPFC_ac_vol_senseOffset_pu = 0;

    TTPLPFC_dutyPU = 0;
    TTPLPFC_dutyPU_DC = 0;

    TTPLPFC_closeGiLoop = 0;
    TTPLPFC_closeGvLoop = 0;
    TTPLPFC_clearTrip = 0;
    TTPLPFC_rlyConnect = 0;
    TTPLPFC_firstTimeGvLoop = 1;
    TTPLPFC_acSine = 0;
    TTPLPFC_acSinePrev = 0;
    TTPLPFC_zeroCrossDetectFlag = 0;

    TTPLPFC_vBus_sensedFiltered_notch1 = 0;
    TTPLPFC_vBus_sensedFiltered_notch2 = 0;

    TTPLPFC_threshold_PZC1 = TTPLPFC_PWM_SWITCHING_PZC1;
    TTPLPFC_threshold_PZC2 = TTPLPFC_PWM_SWITCHING_PZC2;
    TTPLPFC_threshold_NZC1 = TTPLPFC_PWM_SWITCHING_NZC1;
    TTPLPFC_threshold_NZC2 = TTPLPFC_PWM_SWITCHING_NZC2;


    TTPLPFC_autoStartSlew = 0;

    TTPLPFC_vRmsAvg_pu = 0;
    TTPLPFC_vBusAvg_pu = 0;

    TTPLPFC_dutyPU_DC = 0.5f;

    TTPLPFC_thetaOffset_pu = 0;

    TTPLPFC_pwm_SwState.enum_pwmSwState = pwmSwState_defaultState;

    //
    // Interleaving variable and state Initilazation
    //
    TTPLPFC_iref1_pu =
            TTPLPFC_PHASE_SHEDDING_1PH_2PH_TRANSITION_CURRENT /
            TTPLPFC_I_MAX_SENSE;
    TTPLPFC_iref2_pu =
            TTPLPFC_PHASE_SHEDDING_2PH_3PH_TRANSITION_CURRENT /
            TTPLPFC_I_MAX_SENSE;
    TTPLPFC_deltaIref_pu =
            TTPLPFC_PHASE_SHEDDING_TRANSITION_CURRENT_HYSTERESIS /
            TTPLPFC_I_MAX_SENSE;
    TTPLPFC_interleaving_State.enum_interleavingState = interleavingState_3ph;

    TTPLPFC_nonLinearVoltageLoopFlagDelay = 0;
    TTPLPFC_nonLinearVoltageLoopFlag = 0;

    //
    // AutoStart and Under Voltage Protection enabled
    //
    TTPLPFC_autoStart_disable = 0;
    TTPLPFC_UVP_disable = 0;
}


void TTPLPFC_computeNotchFltrCoeff(DCL_DF22 *coeff, float32_t Fs,
                                   float32_t notch_freq,
                                   float32_t c1, float32_t c2)
{
    float32_t temp1;
    float32_t temp2;
    float32_t wn2;
    float32_t Ts;
    Ts = 1 / Fs;

    //
    // pre warp the notch frequency
    //
    wn2 = 2 * Fs * tanf(notch_freq * TTPLPFC_PI_VALUE * Ts);

    temp1 = 4 * Fs * Fs + 4 * wn2 * c2 * Fs + wn2 * wn2;
    temp2 = 1 / ( 4 * Fs * Fs + 4 * wn2 * c1 * Fs + wn2 * wn2);

    coeff->b0 = temp1 * temp2;
    coeff->b1 = (-8 * Fs * Fs + 2 * wn2 * wn2) * temp2;
    coeff->b2 = (4 * Fs * Fs - 4 * wn2 * c2 * Fs + wn2 * wn2) * temp2;
    coeff->a1 = (-8 * Fs * Fs + 2 * wn2 * wn2) * temp2;
    coeff->a2 = (4 * Fs * Fs - 4 * wn2 * c1 * Fs + wn2 * wn2) * temp2;


}

void TTPLPFC_updateBoardStatus()
{
    if(TTPLPFC_board_Status.enum_boardStatus == boardStatus_NoFault)
    {
        if((TTPLPFC_PWM_TRIP_STATUS(EPWM1_BASE) & EPWM_TZ_INTERRUPT_CBC) != 0 )
            TTPLPFC_board_Status.enum_boardStatus =
                    boardStatus_EmulatorStopTrip;
    }

}


void TTPLPFC_runSFRABackGroundTasks(void)
{

    SFRA_F32_runBackgroundTask(&TTPLPFC_sfra1);
    SFRA_GUI_runSerialHostComms(&TTPLPFC_sfra1);

}


void TTPLPFC_setLabIndicatorVariable(void)
{
#if TTPLPFC_LAB == 1
    #if TTPLPFC_CONTROL_RUNNING_ON == CLA_CORE
        TTPLPFC_lab.enum_lab = Lab1_CLA;
    #else
        TTPLPFC_lab.enum_lab = Lab1;
    #endif
#elif TTPLPFC_LAB == 2
    #if TTPLPFC_CONTROL_RUNNING_ON == CLA_CORE
        TTPLPFC_lab.enum_lab = Lab2_CLA;
    #else
        TTPLPFC_lab.enum_lab = Lab2;
    #endif
#elif TTPLPFC_LAB == 3
    #if TTPLPFC_CONTROL_RUNNING_ON == CLA_CORE
        TTPLPFC_lab.enum_lab = Lab3_CLA;
    #else
        TTPLPFC_lab.enum_lab = Lab3;
    #endif
#elif TTPLPFC_LAB == 4
    #if TTPLPFC_CONTROL_RUNNING_ON == CLA_CORE
        TTPLPFC_lab.enum_lab = Lab4_CLA;
    #else
        TTPLPFC_lab.enum_lab = Lab4;
    #endif
#elif TTPLPFC_LAB == 5
    #if TTPLPFC_CONTROL_RUNNING_ON == CLA_CORE
        TTPLPFC_lab.enum_lab = Lab5_CLA;
    #else
        TTPLPFC_lab.enum_lab = Lab5;
    #endif
#elif TTPLPFC_LAB == 6
    #if TTPLPFC_CONTROL_RUNNING_ON == CLA_CORE
        TTPLPFC_lab.enum_lab = Lab6_CLA;
    #else
        TTPLPFC_lab.enum_lab = Lab6;
    #endif
#elif TTPLPFC_LAB == 7
    #if TTPLPFC_CONTROL_RUNNING_ON == CLA_CORE
        TTPLPFC_lab.enum_lab = Lab7_CLA;
    #else
        TTPLPFC_lab.enum_lab = Lab7;
    #endif
#elif TTPLPFC_LAB == 8
    #if TTPLPFC_CONTROL_RUNNING_ON == CLA_CORE
        TTPLPFC_lab.enum_lab = Lab8_CLA;
    #else
        TTPLPFC_lab.enum_lab = Lab8;
    #endif
#elif TTPLPFC_LAB == 9
    #if TTPLPFC_CONTROL_RUNNING_ON == CLA_CORE
        TTPLPFC_lab.enum_lab = Lab9_CLA;
    #else
        TTPLPFC_lab.enum_lab = Lab9;
    #endif
#endif

}

void TTPLPFC_autoStart(void)
{
    #if TTPLPFC_LAB >= 5
        {
            #if TTPLPFC_LAB == 9
            {
                TTPLPFC_vBus_underVoltage_Volts = 340;
                TTPLPFC_ac_volRms_underVoltage_Volts = 75;
            }
            #else
            {
                TTPLPFC_vBus_underVoltage_Volts = 110;
                TTPLPFC_ac_volRms_underVoltage_Volts = 0;
            }
            #endif
        }
    #endif

    #if TTPLPFC_DC_CHECK == 1
        if(TTPLPFC_autoStartSlew < 100)
        {
            TTPLPFC_autoStartSlew++;
        }
    #else

        //
        // Auto Start for Inverter mode
        //
        #if TTPLPFC_LAB >= 5
            if(TTPLPFC_vBus_sensed_Volts >= TTPLPFC_vBus_underVoltage_Volts &&
               TTPLPFC_ac_volRms_sensed_Volts >=
               TTPLPFC_ac_volRms_underVoltage_Volts)
            {
                if(TTPLPFC_autoStartSlew < 5)
                {
                    TTPLPFC_autoStartSlew++;
                }

                if(TTPLPFC_autoStartSlew == 2)
                {
                    DINT;

                    if(TTPLPFC_sine_mains.acFreq > 55)
                    {
                        TTPLPFC_sine_mains.acFreq = 60;
                    }
                    else
                    {
                        TTPLPFC_sine_mains.acFreq = 50;
                    }

                    SPLL_1PH_SOGI_config(&TTPLPFC_spll1,
                                         TTPLPFC_sine_mains.acFreq,
                                         TTPLPFC_CONTROL_ISR_FREQUENCY,
                                         (float32_t)(222.2862),
                                         (float32_t)(-222.034));

                    SPLL_1PH_NOTCH_config(&TTPLPFC_spll2,
                                          TTPLPFC_sine_mains.acFreq,
                                          TTPLPFC_CONTROL_ISR_FREQUENCY,
                                          (float32_t)(222.2862),
                                          (float32_t)(-222.034),
                                          (float32_t) 0.25,
                                          (float32_t) 0.00001);

                    SPLL_1PH_SOGI_FLL_config(&TTPLPFC_spll3,
                                             TTPLPFC_sine_mains.acFreq,
                                             TTPLPFC_CONTROL_ISR_FREQUENCY,
                                             (float32_t)(222.2862),
                                             (float32_t)(-222.034),
                                             (float32_t) 0.5,
                                             (float32_t) 20000);

                    TTPLPFC_computeNotchFltrCoeff(&TTPLPFC_notch1,
                             (float32_t)(TTPLPFC_INSTRUMENTATION_ISR_FREQUENCY),
                             (float32_t)(TTPLPFC_sine_mains.acFreq*2.0) ,
                                           0.25f,
                                           0.00001f);

                    TTPLPFC_computeNotchFltrCoeff(&TTPLPFC_notch2,
                             (float32_t)(TTPLPFC_INSTRUMENTATION_ISR_FREQUENCY),
                             (float32_t)(TTPLPFC_sine_mains.acFreq*2.0),
                                           0.25f,
                                           0.00001f);

                    TTPLPFC_dutyPU = 0.01f;

                    TTPLPFC_HAL_AQ_SW_FORCE_PWMxA_LOW_PWMxB_LOW(
                            TTPLPFC_LOW_FREQ_PWM_BASE);

                    TTPLPFC_HAL_SET_PWM_DBRED(TTPLPFC_HIGH_FREQ_PWM1_BASE,
                                              TTPLPFC_PWM_PERIOD);
                    TTPLPFC_HAL_SET_PWM_DBFED(TTPLPFC_HIGH_FREQ_PWM1_BASE,
                                              TTPLPFC_PWM_PERIOD);

                    TTPLPFC_HAL_SET_PWM_DBRED(TTPLPFC_HIGH_FREQ_PWM2_BASE,
                                              TTPLPFC_PWM_PERIOD);
                    TTPLPFC_HAL_SET_PWM_DBFED(TTPLPFC_HIGH_FREQ_PWM2_BASE,
                                              TTPLPFC_PWM_PERIOD);

                    TTPLPFC_HAL_SET_PWM_DBRED(TTPLPFC_HIGH_FREQ_PWM3_BASE,
                                              TTPLPFC_PWM_PERIOD);
                    TTPLPFC_HAL_SET_PWM_DBFED(TTPLPFC_HIGH_FREQ_PWM3_BASE,
                                              TTPLPFC_PWM_PERIOD);
                    EINT;

                    TTPLPFC_nonLinearVoltageLoopFlag = 0;

                }

                if(TTPLPFC_autoStartSlew == 3)
                {
                    if(TTPLPFC_ac_volRms_sensed_Volts < 150 )
                    {
                        TTPLPFC_thetaOffset_pu =
                                TTPLPFC_LOW_LINE_INPUT_CAP_COMP_ADJUST;
                    }
                    else
                    {
                        TTPLPFC_thetaOffset_pu =
                                TTPLPFC_HIGH_LINE_INPUT_CAP_COMP_ADJUST;
                    }

                    DINT;
                    TTPLPFC_HAL_clearPWMTripFlags(TTPLPFC_LOW_FREQ_PWM_BASE);
                    TTPLPFC_HAL_clearPWMTripFlags(TTPLPFC_HIGH_FREQ_PWM1_BASE);
                    TTPLPFC_HAL_clearPWMTripFlags(TTPLPFC_HIGH_FREQ_PWM2_BASE);
                    TTPLPFC_HAL_clearPWMTripFlags(TTPLPFC_HIGH_FREQ_PWM3_BASE);
                    TTPLPFC_board_Status.enum_boardStatus = boardStatus_NoFault;
                    EINT;

                }
                if(TTPLPFC_autoStartSlew == 1)
                {
                    TTPLPFC_board_Status.enum_boardStatus =
                            boardStatus_Idle;
                    TTPLPFC_pwm_SwState.enum_pwmSwState =
                            pwmSwState_defaultState;
                }



            }
            else
            {
                TTPLPFC_rlyConnect = 0;
                TTPLPFC_autoStartSlew = 0;
                TTPLPFC_pwm_SwState.enum_pwmSwState = pwmSwState_defaultState;
                TTPLPFC_closeGiLoop = 0;
                TTPLPFC_closeGvLoop = 0;

            }

        //
        // Auto Start for PFC mode
        //
        #else
        if (TTPLPFC_autoStart_disable == 0)
        {
            if(TTPLPFC_ac_volRms_sensed_Volts > TTPLPFC_ac_volRms_underVoltage_Volts)

            {
                if(TTPLPFC_autoStartSlew < 5)
                {
                    TTPLPFC_autoStartSlew++;
                }

                if(TTPLPFC_autoStartSlew == 2)
                {


                    DINT;

                    if(TTPLPFC_sine_mains.acFreq > 55)
                    {
                        TTPLPFC_sine_mains.acFreq = 60;
                        TTPLPFC_ac_period_sec = (float32_t) (1/TTPLPFC_sine_mains.acFreq);
                    }
                    else
                    {
                        TTPLPFC_sine_mains.acFreq = 50;
                        TTPLPFC_ac_period_sec = (float32_t) (1/TTPLPFC_sine_mains.acFreq);
                    }



                    //
                    // Init ac drop and brown out counter max value for shutdown
                    //

                    //
                    // 1e-5 sec (= 10 us) @ 100 kHZ
                    //
                    TTPLPFC_ISR1_period_sec = (float32_t)(1/TTPLPFC_CONTROL_ISR_FREQUENCY);
                    TTPLPFC_ac_period_cnt = (uint32_t) (TTPLPFC_ac_period_sec
                                                        / TTPLPFC_ISR1_period_sec);

                    //
                    // 3 ac cycles 50e-3 sec or 60e-3 sec
                    //
                    TTPLPFC_acSine_brownOutMax_sec = (float32_t) (TTPLPFC_ac_period_sec * 3);

                    //
                    // 1.5 ac cycles 25e-3 sec or 30e-3
                    //
                    TTPLPFC_acSine_acDropMax_sec = (float32_t) (TTPLPFC_ac_period_sec * 1.5);

                    TTPLPFC_acSine_brownOutMax_cnt = (uint32_t) ( TTPLPFC_acSine_brownOutMax_sec
                                                               /  TTPLPFC_ISR1_period_sec);
                    TTPLPFC_acSine_acDropMax_cnt = (uint32_t) ( TTPLPFC_acSine_acDropMax_sec
                                                               /  TTPLPFC_ISR1_period_sec);

                    //
                    // 5 ac cycles
                    //
                    TTPLPFC_syncInitMax_sec = (float32_t) (TTPLPFC_ac_period_sec * 5);
                    TTPLPFC_syncInitMax_cnt = (uint32_t) ( TTPLPFC_syncInitMax_sec
                                                         / TTPLPFC_ISR1_period_sec );

                    //
                    // 3 ac cycles
                    //
                    TTPLPFC_ac_resumeMax_sec = (float32_t) (TTPLPFC_ac_period_sec * 3 );
                    TTPLPFC_ac_resumeMax_cnt = (uint32_t) ( TTPLPFC_ac_resumeMax_sec
                                                          / TTPLPFC_ISR1_period_sec );

                    //
                    // Init SPLL_regen variables
                    //
                    TTPLPFC_acSine_regen_ISRperiod = TTPLPFC_ISR1_period_sec;
                    TTPLPFC_acSine_regen_freq = TTPLPFC_sine_mains.acFreq;


                    //
                    // Set the magnitude of regen voltage from
                    // RMS mesurement at autostart = 4
                    //
                    TTPLPFC_ac_volRMS_regen_Volts = TTPLPFC_ac_volRms_sensed_Volts;
                    TTPLPFC_ac_vol_regen_magnitude = TTPLPFC_ac_volRMS_regen_Volts
                                                     * ((float32_t)1.4142135f);


                    //
                    // Init SPLL_regen variables
                    //
                    TTPLPFC_Regen_cnt = 0;
                    TTPLPFC_Regen_cnt_Max = 100;
                    TTPLPFC_SPLL_regen_syncOn = 0;
                    TTPLPFC_acDrop_cnt = 0;
                    SPLL_1PH_SOGI_config(&TTPLPFC_spll1,
                                         TTPLPFC_sine_mains.acFreq,
                                         TTPLPFC_CONTROL_ISR_FREQUENCY,
                                         (float32_t)(222.2862),
                                         (float32_t)(-222.034));

                    SPLL_1PH_NOTCH_config(&TTPLPFC_spll2,
                                          TTPLPFC_sine_mains.acFreq,
                                          TTPLPFC_CONTROL_ISR_FREQUENCY,
                                          (float32_t)(222.2862),
                                          (float32_t)(-222.034),
                                          (float32_t) 0.25,
                                          (float32_t) 0.00001);

                    SPLL_1PH_SOGI_FLL_config(&TTPLPFC_spll3,
                                             TTPLPFC_sine_mains.acFreq,
                                             TTPLPFC_CONTROL_ISR_FREQUENCY,
                                             (float32_t)(222.2862),
                                             (float32_t)(-222.034),
                                             (float32_t) 0.5,
                                             (float32_t) 20000);

                    TTPLPFC_computeNotchFltrCoeff(&TTPLPFC_notch1,
                             (float32_t)(TTPLPFC_INSTRUMENTATION_ISR_FREQUENCY),
                             (float32_t)(TTPLPFC_sine_mains.acFreq*2.0) ,
                                           0.25f,
                                           0.00001f);

                    TTPLPFC_computeNotchFltrCoeff(&TTPLPFC_notch2,
                             (float32_t)(TTPLPFC_INSTRUMENTATION_ISR_FREQUENCY),
                             (float32_t)(TTPLPFC_sine_mains.acFreq*2.0),
                                           0.25f,
                                           0.00001f);

                    TTPLPFC_dutyPU = 0.01f;

                    TTPLPFC_HAL_AQ_SW_FORCE_PWMxA_LOW_PWMxB_LOW(
                            TTPLPFC_LOW_FREQ_PWM_BASE);

                    TTPLPFC_HAL_SET_PWM_DBRED(TTPLPFC_HIGH_FREQ_PWM1_BASE,
                                              TTPLPFC_PWM_PERIOD);
                    TTPLPFC_HAL_SET_PWM_DBFED(TTPLPFC_HIGH_FREQ_PWM1_BASE,
                                              TTPLPFC_PWM_PERIOD);

                    TTPLPFC_HAL_SET_PWM_DBRED(TTPLPFC_HIGH_FREQ_PWM2_BASE,
                                              TTPLPFC_PWM_PERIOD);
                    TTPLPFC_HAL_SET_PWM_DBFED(TTPLPFC_HIGH_FREQ_PWM2_BASE,
                                              TTPLPFC_PWM_PERIOD);

                    TTPLPFC_HAL_SET_PWM_DBRED(TTPLPFC_HIGH_FREQ_PWM3_BASE,
                                              TTPLPFC_PWM_PERIOD);
                    TTPLPFC_HAL_SET_PWM_DBFED(TTPLPFC_HIGH_FREQ_PWM3_BASE,
                                              TTPLPFC_PWM_PERIOD);
                    EINT;

                    TTPLPFC_nonLinearVoltageLoopFlag = 0;

                }

                if(TTPLPFC_autoStartSlew == 3)
                {
                    if(TTPLPFC_ac_volRms_sensed_Volts < 150 )
                    {
                        TTPLPFC_thetaOffset_pu =
                                TTPLPFC_LOW_LINE_INPUT_CAP_COMP_ADJUST;
                    }
                    else
                    {
                        TTPLPFC_thetaOffset_pu =
                                TTPLPFC_HIGH_LINE_INPUT_CAP_COMP_ADJUST;
                    }

                    DINT;
                    TTPLPFC_HAL_clearPWMTripFlags(TTPLPFC_LOW_FREQ_PWM_BASE);
                    TTPLPFC_HAL_clearPWMTripFlags(TTPLPFC_HIGH_FREQ_PWM1_BASE);
                    TTPLPFC_HAL_clearPWMTripFlags(TTPLPFC_HIGH_FREQ_PWM2_BASE);
                    TTPLPFC_HAL_clearPWMTripFlags(TTPLPFC_HIGH_FREQ_PWM3_BASE);
                    TTPLPFC_board_Status.enum_boardStatus = boardStatus_NoFault;
                    EINT;

                }
                if(TTPLPFC_autoStartSlew == 1)
                {
                    TTPLPFC_board_Status.enum_boardStatus =
                            boardStatus_Idle;
                    TTPLPFC_pwm_SwState.enum_pwmSwState =
                            pwmSwState_defaultState;
                }



            }
            else
            {
                #if(TTPLPFC_LAB == 1 && TTPLPFC_PWM_AC_CHECK == 1)
                    if TTPLPFC_clearTrip == 1
                        {
                        TTPLPFC_HAL_clearPWMTripFlags(TTPLPFC_LOW_FREQ_PWM_BASE);
                        TTPLPFC_HAL_clearPWMTripFlags(TTPLPFC_HIGH_FREQ_PWM1_BASE);
                        TTPLPFC_HAL_clearPWMTripFlags(TTPLPFC_HIGH_FREQ_PWM2_BASE);
                        TTPLPFC_HAL_clearPWMTripFlags(TTPLPFC_HIGH_FREQ_PWM3_BASE);
                        board_Status.enum_boardStatus = boardStatus_NoFault;

                        clearTrip = 0;

                        pwm_SwState.enum_pwmSwState = pwmSwState_normalOperation;
                        }
                #else
                        TTPLPFC_rlyConnect = 0;
                        TTPLPFC_autoStartSlew = 0;
                        TTPLPFC_pwm_SwState.enum_pwmSwState =
                                pwmSwState_defaultState;
                        TTPLPFC_closeGiLoop = 0;
                        TTPLPFC_closeGvLoop = 0;

                #endif
            }
        }
        #endif
    #endif

#if TTPLPFC_DC_CHECK == 1
    if(TTPLPFC_autoStartSlew == 100)
#else
    if(TTPLPFC_autoStartSlew == 4)
#endif
    {

        DINT;

        TTPLPFC_vBusRefSlewed_pu = 0;

        TTPLPFC_gv.i6 = 0;
        TTPLPFC_gv.i10 = 0;

        TTPLPFC_gi.i10 = 0;
        TTPLPFC_gi.i6 = 0;

        TTPLPFC_closeGiLoop = 0;
        TTPLPFC_closeGvLoop = 0;

        TTPLPFC_clearTrip = 1;
        TTPLPFC_firstTimeGvLoop = 1;

        TTPLPFC_state_slew = 0;
        TTPLPFC_softstart_duty = 0;

        TTPLPFC_vBusRef_pu = TTPLPFC_VBUS_TYPICAL / TTPLPFC_VDCBUS_MAX_SENSE;

        TTPLPFC_ac_cur_ref_pu = 0.03f;

        TTPLPFC_ac_cur_ref_inst_pu = 0;
        TTPLPFC_ac_cur_ref_inst_prev_pu = 0;

        TTPLPFC_acSine = 0;
        TTPLPFC_acSinePrev = 0;
        TTPLPFC_zeroCrossDetectFlag = 0;

        #if TTPLPFC_LAB >= 5

        //
        // In inverter mode, it will not automatically start dc/ac conversion
        // pwmSwState has to be manually changed from defaultState
        // to normalOperation by user
        //
            TTPLPFC_pwm_SwState.enum_pwmSwState =
                    pwmSwState_defaultState;

        //
        // The negative sign in ac_cur_ref represents the reverse power flow
        // in inverter mode
        //
            TTPLPFC_ac_cur_ref_pu = -0.03f;
        #else

        //
        // In PFC mode, it will automatically start ac/dc conversion
        //
            TTPLPFC_pwm_SwState.enum_pwmSwState = pwmSwState_normalOperation;
        #endif

        EINT;

        TTPLPFC_autoStartSlew++;

#if TTPLPFC_DC_CHECK == 1

        TTPLPFC_HAL_clearPWMTripFlags(TTPLPFC_LOW_FREQ_PWM_BASE);
        TTPLPFC_HAL_clearPWMTripFlags(TTPLPFC_HIGH_FREQ_PWM1_BASE);
        TTPLPFC_HAL_clearPWMTripFlags(TTPLPFC_HIGH_FREQ_PWM2_BASE);
        TTPLPFC_HAL_clearPWMTripFlags(TTPLPFC_HIGH_FREQ_PWM3_BASE);

        TTPLPFC_rlyConnect = 1;
        TTPLPFC_closeGiLoop = 1;

#endif

    }

}

