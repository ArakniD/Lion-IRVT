/*
 * com_cpu2.c
 *
 *  Created on: 15 Apr. 2025
 *      Author: lucas
 */

#ifdef CPU2

#include "driverlib.h"
#include "device.h"
#include "registers.h"
#include "led_driver.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

//
// ADS1119 configuration (schematic page 12, U7 and U9)
//
// Both converters sit on I2CB alongside the FM24V10 F-RAM. They are NOT
// memory-addressed devices: every access is a single command byte (Table 7),
// so they must not be driven through the F-RAM i2cReadBlock/i2cWriteBlock
// helpers, which always prepend a 16-bit memory address.
//
#define ADS1119_ADDR_1 0x40  // U7, A1=DGND A0=DGND, thermistors TemP1..TemP4
#define ADS1119_ADDR_2 0x41  // U9, A1=DGND A0=DVDD, thermistors TemP5..TemP8

//
// Command bytes (Table 7). Commands latch on the eighth falling edge of SCL.
//
#define ADS1119_CMD_RESET      0x06U  // 0000 011x
#define ADS1119_CMD_START      0x08U  // 0000 100x - START/SYNC
#define ADS1119_CMD_POWERDOWN  0x02U  // 0000 001x
#define ADS1119_CMD_RDATA      0x10U  // 0001 xxxx
#define ADS1119_CMD_RREG_CFG   0x20U  // 0010 0rxx, r=0 -> configuration (0h)
#define ADS1119_CMD_RREG_STAT  0x24U  // 0010 0rxx, r=1 -> status (1h)
#define ADS1119_CMD_WREG       0x40U  // 0100 00xx + one data byte

//
// Configuration register (Table 8/10) is a single 8-bit register at 0h:
//
//   7:5 MUX   011..110 = AIN0..AIN3 vs AGND (single-ended)
//   4   GAIN  0 = 1
//   3:2 DR    01 = 90 SPS
//   1   CM    1 = continuous
//   0   VREF  1 = external REFP/REFN
//
// The thermistor nets TemP1..TemP4 land on AIN0..AIN3 of U7 individually
// (and TemP5..TemP8 on U9), so all four channels are single-ended against
// AGND - MUX 011 + channel, not the differential 000..010 codes.
//
// VREF is external: REFP carries Vref_2_50_1 / Vref_2_50_2 and REFN goes to
// AGND, so full scale is the 2.50 V reference, not the internal 2.048 V.
//
#define ADS1119_MUX_SHIFT       5U
#define ADS1119_MUX_AIN0_AGND   3U     // 011; +channel selects AIN1..AIN3
#define ADS1119_CFG_GAIN_1      0x00U
//
// Data rate. The part offers 20, 90, 330 and 1000 SPS only - there is no
// slower setting. 20 SPS is the one to use here: cell temperature moves
// slowly, and it is the rate at which the digital filter gives 16-bit
// noise-free resolution with simultaneous 50/60 Hz mains rejection.
//
// It also keeps the DRDY interrupt load down. Each conversion drives a
// blocking I2C read from the ISR, so at 8 channels across two devices
// this is 40 transfers a second rather than 180.
//
#define ADS1119_CFG_DR_20SPS    0x00U  // DR = 00
#define ADS1119_CFG_CM_CONT     0x02U  // CM = 1
#define ADS1119_CFG_VREF_EXT    0x01U  // VREF = 1, external
#define ADS1119_CFG_BASE        (ADS1119_CFG_GAIN_1 | ADS1119_CFG_DR_20SPS |                                  ADS1119_CFG_CM_CONT | ADS1119_CFG_VREF_EXT)

// Configuration byte selecting single-ended AIN<ch> for ch = 0..3.
#define ADS1119_CFG_FOR_CH(ch)  ((uint16_t)ADS1119_CFG_BASE |                                                  (uint16_t)(((ADS1119_MUX_AIN0_AGND + (ch)) &                                              0x07U) << ADS1119_MUX_SHIFT))

//
// External reference in millivolts. The converter is 16-bit bipolar, so a
// full-scale code of +32767 corresponds to +VREF and -32768 to -VREF.
//
#define ADS1119_VREF_MV         2500.0f
#define ADS1119_FULL_SCALE      32768.0f

#define ADS1119_CHANNELS_PER_DEV 4U

//
// AIN input -> BTS slot mapping.
//
// The thermistor inputs are wired in reverse on BOTH converters: the
// highest AIN carries the lowest slot. U7 (0x40) AIN3..AIN0 are slots
// 1..4, and U9 (0x41) AIN3..AIN0 are slots 5..8. Confirmed against the
// schematic 2026-09-22.
//
// Publishing the raw AIN index put every temperature on the wrong slot -
// a hot cell on slot 1 was reported as slot 4. The zero-based register
// index for AIN <ch> on <unit> is therefore (3 - ch) + unit*4.
//
#define ADS1119_SLOT_FOR_AIN(ch)  ((ADS1119_CHANNELS_PER_DEV - 1U) - (ch))

#define ADS1119_DRDY_GPIO_1 42     // DRDY for ADS1119 #1 (net DRDY3)
#define ADS1119_DRDY_GPIO_2 43     // DRDY for ADS1119 #2 (net DRDY4)

// EEPROM layout
//
// The stride is fixed rather than derived from sizeof(BTS_channelCalibration).
// It used to be 2*sizeof(), which put channel 4's block at 0x0100 - exactly
// where the global voltage thresholds live. saveAllCalibration() iterates
// 0->7, so channel 0 wrote the globals and channel 4 then overwrote them;
// at the next boot they failed validation and the 9/10/15/16 V defaults were
// silently installed. Channel 4's own block still validated, so nothing
// looked wrong - the thresholds simply never persisted.
//
// A fixed stride also decouples the wire layout from sizeof, so adding struct
// fields no longer moves every channel's block. The FM24V10 is 128 KiB, so
// the generosity costs nothing.
//
#define EEPROM_I2C_ADDR       0x50
#define CAL_FRAM_STRIDE_BYTES 128U     // per channel, fixed
#define CAL_FRAM_BASE         0x0000U  // ch N at BASE + N*STRIDE, ends 0x03FF
#define EEPROM_GLOBAL_V_ADDR  0x0400   // 16 bytes = 4 floats (was 0x0100)

//
// Slot runtime state, 8 slots x 64 B: 0x0500 .. 0x06FF.
//
// The stride was 32 B while the record was 40 B, so every slot overwrote the
// first 8 bytes of the next one - the saveCounter and crc32 of slots 0..6
// were destroyed by their successor and could never validate. Only slot 7,
// having no successor, ever restored. Widened to 64 B, which both fixes the
// overrun and leaves 8 spare words per slot for later runtime fields.
//
// The FM24V10 is 128 KiB, so this region ends at 0x06FF and the whole map
// occupies well under 1% of the part. Space is not a constraint here.
//
#define STATE_FRAM_BASE       0x0500U
#define STATE_FRAM_STRIDE     64U

//
// Polling bound for the blocking I2C helpers. At 160 MHz this is a few
// hundred microseconds - long enough for a 400 kHz transfer to complete,
// short enough that a DRDY ISR talking to an absent device does not stall
// the console. (Was 1000000, i.e. milliseconds per failed attempt.)
//
#define BTS_I2C_TIMEOUT_ITERATIONS 20000UL

//
// Idle-loop passes the host bus may sit busy, with no address match,
// before the target is assumed stuck and reset. The loop runs flat out,
// so this is a large number for a short wall-clock time.
//
#define BTS_I2C_TARGET_STUCK_PASSES 200000UL

//
// Address this unit answers to on the host bus.
//
#define BTS_I2C_TARGET_ADDRESS 0x50U

// Validation limits
#define MIN_VOLTAGE 8.0f
#define MAX_VOLTAGE 16.8f

// Default global voltage thresholds, used when the EEPROM copy is invalid
#define DEFAULT_CHARGE_DISABLE_V     9.0f
#define DEFAULT_CHARGE_RESTRICT_V    10.0f
#define DEFAULT_DISCHARGE_RESTRICT_V 15.0f
#define DEFAULT_DISCHARGE_DISABLE_V  16.0f

// Default cell temperature window
#define DEFAULT_MAX_CELL_TEMP        85.0f

//
// Per-slot limit defaults, installed when a slot has no valid F-RAM record.
//
// These are SLOT SETTINGS, persisted with the runtime record - deliberately
// not part of BTS_channelCalibration, so an operator changing a charge
// current never rewrites the calibration image.
//
// Deliberately conservative: a single lithium-ion cell's usual 3.0 - 4.2 V
// window, and 1 A against a hardware over-current trip at +/-8 A. A slot
// that has never been configured should do something safe and unremarkable,
// not run at the hardware's limit. Zero is NOT an acceptable fallback - it
// presents as a dead slot and hides the missing record.
//
#define DEFAULT_SLOT_VOLTAGE_MIN     3.0f
#define DEFAULT_SLOT_VOLTAGE_MAX     4.2f
#define DEFAULT_SLOT_CURRENT_MIN     0.0f
#define DEFAULT_SLOT_CURRENT_MAX     1.0f

//
// Default on-chip ADC scaling for cell voltage and current.
//
// The F2837xD ADC is configured for 12-bit single-ended operation against a
// 3.3 V reference (BTS_HAL_setupADC). BTS_monitor_Iout_Vout normalises the
// raw count to 0..1 and then multiplies by 2.5 before applying these gains,
// so a gain of 1.0 with zero offset yields a 0..2.5 V reading. The cell
// voltage divider and the current-sense amplifier are both unity by default;
// a real gain/offset pair is established by the calibration procedure and
// stored in EEPROM.
//
#define DEFAULT_F28V_GAIN            1.0f
#define DEFAULT_F28V_OFFSET          0.0f
/* Must track BTS_F28I_GAIN_DEFAULT - see the derivation there. */
#define DEFAULT_F28I_GAIN            9.66f
#define DEFAULT_F28I_OFFSET          0.0f

//
// Per-channel default Iout/Vout calibration, taken from the PowerSUITE
// generated two-point calibration in bts_user_calibration.h.
//
static const float32_t defaultIoutGain_pu[NUM_CHANNELS] = {
    BTS_IoutGain_ch1_pu, BTS_IoutGain_ch2_pu, BTS_IoutGain_ch3_pu, BTS_IoutGain_ch4_pu,
    BTS_IoutGain_ch5_pu, BTS_IoutGain_ch6_pu, BTS_IoutGain_ch7_pu, BTS_IoutGain_ch8_pu
};
static const float32_t defaultIoutOffset_pu[NUM_CHANNELS] = {
    BTS_IoutOffset_ch1_pu, BTS_IoutOffset_ch2_pu, BTS_IoutOffset_ch3_pu, BTS_IoutOffset_ch4_pu,
    BTS_IoutOffset_ch5_pu, BTS_IoutOffset_ch6_pu, BTS_IoutOffset_ch7_pu, BTS_IoutOffset_ch8_pu
};
static const float32_t defaultIoutGain_A[NUM_CHANNELS] = {
    BTS_IoutGain_ch1_A, BTS_IoutGain_ch2_A, BTS_IoutGain_ch3_A, BTS_IoutGain_ch4_A,
    BTS_IoutGain_ch5_A, BTS_IoutGain_ch6_A, BTS_IoutGain_ch7_A, BTS_IoutGain_ch8_A
};
static const float32_t defaultIoutOffset_A[NUM_CHANNELS] = {
    BTS_IoutOffset_ch1_A, BTS_IoutOffset_ch2_A, BTS_IoutOffset_ch3_A, BTS_IoutOffset_ch4_A,
    BTS_IoutOffset_ch5_A, BTS_IoutOffset_ch6_A, BTS_IoutOffset_ch7_A, BTS_IoutOffset_ch8_A
};
static const float32_t defaultVoutGain_pu[NUM_CHANNELS] = {
    BTS_VoutGain_ch1_pu, BTS_VoutGain_ch2_pu, BTS_VoutGain_ch3_pu, BTS_VoutGain_ch4_pu,
    BTS_VoutGain_ch5_pu, BTS_VoutGain_ch6_pu, BTS_VoutGain_ch7_pu, BTS_VoutGain_ch8_pu
};
static const float32_t defaultVoutOffset_pu[NUM_CHANNELS] = {
    BTS_VoutOffset_ch1_pu, BTS_VoutOffset_ch2_pu, BTS_VoutOffset_ch3_pu, BTS_VoutOffset_ch4_pu,
    BTS_VoutOffset_ch5_pu, BTS_VoutOffset_ch6_pu, BTS_VoutOffset_ch7_pu, BTS_VoutOffset_ch8_pu
};
static const float32_t defaultVoutGain_V[NUM_CHANNELS] = {
    BTS_VoutGain_ch1_V, BTS_VoutGain_ch2_V, BTS_VoutGain_ch3_V, BTS_VoutGain_ch4_V,
    BTS_VoutGain_ch5_V, BTS_VoutGain_ch6_V, BTS_VoutGain_ch7_V, BTS_VoutGain_ch8_V
};
static const float32_t defaultVoutOffset_V[NUM_CHANNELS] = {
    BTS_VoutOffset_ch1_V, BTS_VoutOffset_ch2_V, BTS_VoutOffset_ch3_V, BTS_VoutOffset_ch4_V,
    BTS_VoutOffset_ch5_V, BTS_VoutOffset_ch6_V, BTS_VoutOffset_ch7_V, BTS_VoutOffset_ch8_V
};

//
// Signal-conditioned thermistor response.
//
// The NTC does not reach the converter directly - it goes through the board
// amplifier stage first, so the useful curve is of the amplifier output, not
// of the raw divider. This fourth-order fit was measured on the hardware and
// covers roughly 20 C to 100 C over 0.1 V to 2.9 V in:
//
//   degC = 0.4038*V^4 - 0.2199*V^3 - 3.2834*V^2 + 28.366*V + 18.323
//
// The curve is well behaved below that: it bottoms out at +18.3 C for 0 V
// in, so a low reading is a cold sensor, never a missing one. There is no
// input this conditioning can produce that maps to an implausible value.
//
// At the other end the converter full scale is the 2.50 V reference, so the
// top of the amplifier range is not reachable - readings saturate near
// 81 C. That is a property of the analogue front end, not of this code.
//
#define BTS_NTC_POLY_C4   ((float)0.4038)
#define BTS_NTC_POLY_C3   ((float)-0.2199)
#define BTS_NTC_POLY_C2   ((float)-3.2834)
#define BTS_NTC_POLY_C1   ((float)28.366)
#define BTS_NTC_POLY_C0   ((float)18.323)

//
// Upper end of the fitted range. The curve bottoms out at +18.3 C for
// 0 V in, so only the top needs bounding.
//
#define BTS_NTC_V_MAX     ((float)2.95)


//
// Measured temperatures live in registers[BTS_CELLTEMP_IDX(ch)] - there is no
// separate local buffer. CPU2 is the only writer of that block.
//
static volatile uint16_t currentAdsChannel[2] = {0, 0}; // Track channel for each ADS1119

//
// Consecutive I2C failures per converter. If an ADS1119 is absent or its
// bus is wedged, every DRDY edge costs a full set of I2C timeouts; left
// unchecked that starves the console and the register interfaces. After
// this many failures the offending DRDY interrupt is masked and its
// temperatures simply stop updating.
//
#define ADS1119_MAX_CONSECUTIVE_FAILURES 8U
static volatile uint16_t adsFailCount[2] = {0, 0};

//
// Forward declarations - every ISR below is registered before it is defined.
//
__interrupt void i2cSlaveISR(void);
__interrupt void i2cSlaveFifoISR(void);
__interrupt void i2cTargetISR(void);
__interrupt void i2cMasterISR(void);
__interrupt void canISR(void);
__interrupt void uartRxISR(void);
__interrupt void timerISR(void);
__interrupt void ads1119Drdy1ISR(void);
__interrupt void ads1119Drdy2ISR(void);

//
// Background tasks, driven from the idle loop in main().
//
void BTS_serviceADS1119(void);
void BTS_serviceDeferredWork(void);

void uartSendResponse(const char* response);
void saveCalibration(uint16_t channel);
void loadCalibration(void);
static void loadSlotStates(void);
static void hostWatchdogFeed(void);
static void notifyCpu1RegisterWrite(uint16_t regIdx, float32_t value);
static void notifyCpu1CalibrationReload(void);
#if (BTS_CONSOLE_ENABLED == true)
static void formatRegisterValue(char *out, uint16_t outSize,
                                const char *name, float32_t value);
#endif

void initI2C_Slave(void)
{
    //
    // I2CA (GPIO32/33) is the host register command bus; the unit is an I2C
    // target at 0x50. The pins were muxed by CPU1 in BTS_HAL_setupCpu2Pins() -
    // the mux registers are not writable from CPU2.
    //
    // Configured to run from the FIFOs, following TI's own master/slave
    // example. Three details here are easy to get wrong and each one on its
    // own stops the target answering:
    //
    //   The prescaler must be set even though a target never drives SCL. It
    //   divides SYSCLK to the module clock, which the TRM requires to sit
    //   between 7 and 12 MHz because it times the data setup and hold windows
    //   and clocks the input filter.
    //
    //   I2CCNT is decremented by the target as well as the controller. Left
    //   at zero the module acknowledges its address and then holds SCL low
    //   indefinitely while its own status register still reports the bus free.
    //
    //   With the FIFO enabled the basic RRDY and XRDY interrupts must not be
    //   used - the TRM is explicit about this - and the FIFO interrupts arrive
    //   on a different PIE vector, INT_I2CA_FIFO, not INT_I2CA.
    //
    I2C_disableModule(I2CA_BASE);

    I2C_initController(I2CA_BASE, DEVICE_SYSCLK_FREQ, 100000, I2C_DUTYCYCLE_50);
    I2C_setConfig(I2CA_BASE, I2C_TARGET_RECEIVE_MODE);
    I2C_setOwnAddress(I2CA_BASE, BTS_I2C_TARGET_ADDRESS);
    I2C_disableLoopback(I2CA_BASE);
    I2C_setBitCount(I2CA_BASE, I2C_BITCOUNT_8);
    I2C_setDataCount(I2CA_BASE, 2);
    I2C_setAddressMode(I2CA_BASE, I2C_ADDR_MODE_7BITS);

    I2C_enableFIFO(I2CA_BASE);

    //
    // Interrupt on every received byte. The command framing is only two or
    // six bytes long, so there is nothing to gain from batching and a great
    // deal to lose: a partially filled FIFO would stall mid-command.
    //
    I2C_setFIFOInterruptLevel(I2CA_BASE, I2C_FIFO_TXEMPTY, I2C_FIFO_RX1);

    I2C_clearInterruptStatus(I2CA_BASE,
                             I2C_INT_ADDR_TARGET | I2C_INT_ARB_LOST |
                             I2C_INT_NO_ACK | I2C_INT_STOP_CONDITION |
                             I2C_INT_RXFF | I2C_INT_TXFF);

    //
    // Basic sources on 8.1, FIFO sources on 8.2.
    //
    I2C_enableInterrupt(I2CA_BASE,
                        I2C_INT_ADDR_TARGET | I2C_INT_ARB_LOST |
                        I2C_INT_NO_ACK | I2C_INT_STOP_CONDITION |
                        I2C_INT_RXFF | I2C_INT_TXFF);

    I2C_setEmulationMode(I2CA_BASE, I2C_EMULATION_FREE_RUN);

    Interrupt_register(INT_I2CA, &i2cSlaveISR);
    Interrupt_register(INT_I2CA_FIFO, &i2cSlaveFifoISR);
    Interrupt_enable(INT_I2CA);
    Interrupt_enable(INT_I2CA_FIFO);

    I2C_enableModule(I2CA_BASE);
}

volatile uint16_t BTS_dbgI2cbMdr = 0xFFFFU;
volatile uint16_t BTS_dbgI2cbStr = 0xFFFFU;

void initI2C_Master(void)
{
    //
    // I2CB (GPIO40/41) carries the calibration EEPROM (0x50) and the two
    // ADS1119 temperature ADCs (0x40/0x41), whose DRDY lines are GPIO42/43.
    // Pins muxed by CPU1 in BTS_HAL_setupCpu2Pins().
    //
    I2C_disableModule(I2CB_BASE);

    //
    // Drive I2CMDR to a known-zero state before anything else.
    //
    // I2C_setConfig() is a read-modify-write that preserves STT and STP, and
    // I2C_enableModule() only ORs IRS in - so neither can clear a stop that
    // was armed but never completed. A frame abandoned mid-transfer therefore
    // leaves STP set, and every later re-init faithfully restores it: the
    // module comes back up already believing it owes the bus a stop, holds
    // SCL low waiting to send it, and BB latches busy forever. That is why
    // i2cRecoverBus() ran 47836 times without ever freeing the bus - it
    // finished by calling this function, which put the stuck bit straight
    // back.
    //
    // Measured on hardware 2026-09-22: I2CMDR read 0x4E20
    // (FREE|STP|MST|TRX|IRS) with I2CSTR 0x1010 (BUS_BUSY|TX_DATA_RDY) and
    // SCL - not SDA - clamped low in GPBDAT. Clearing IRS alone released SCL
    // instantly and dropped I2CSTR to 0x0410, which is what proves the
    // CONTROLLER was holding the wire, not a target on it.
    //
    HWREGH(I2CB_BASE + I2C_O_MDR) = 0U;

    //
    // A peripheral reset clears the latched state the mode register cannot
    // reach. I2CA's recovery path has always done this; I2CB never did.
    //
    SysCtl_resetPeripheral(SYSCTL_PERIPH_RES_I2CB);
    SysCtl_delay(100U);
    HWREGH(I2CB_BASE + I2C_O_MDR) = 0U;

    I2C_initController(I2CB_BASE, DEVICE_SYSCLK_FREQ, 400000, I2C_DUTYCYCLE_50);
    I2C_setConfig(I2CB_BASE, I2C_CONTROLLER_SEND_MODE);
    I2C_setBitCount(I2CB_BASE, I2C_BITCOUNT_8);

    //
    // Digital loopback OFF. I2CMDR.DLB is NOT cleared by a module reset and
    // was observed SET on hardware (I2CMDR = 0x4E20), which ties the
    // transmitter straight back to the receiver: the controller ACKs its own
    // address and never drives the pins, so the FM24V10 (0x50) and both
    // ADS1119s (0x40/0x41) are unreachable and every read returns nothing.
    // That is why calibration, slot state and the temperatures all failed to
    // load while the bus looked electrically healthy.
    //
    // I2CA has always called this; I2CB never did.
    //
    I2C_disableLoopback(I2CB_BASE);

    //
    // Explicit 7-bit addressing for the same reason - all three devices on
    // this bus are 7-bit, and the mode bit is not reset either.
    //
    I2C_setAddressMode(I2CB_BASE, I2C_ADDR_MODE_7BITS);

    I2C_setEmulationMode(I2CB_BASE, I2C_EMULATION_FREE_RUN);
    I2C_enableModule(I2CB_BASE);

    //
    // Latched by CPU2 itself. Peripheral registers have proven unreliable to
    // read over JTAG on this part, so the only trustworthy observation is one
    // the core makes of its own bus.
    //
    BTS_dbgI2cbMdr = HWREGH(I2CB_BASE + I2C_O_MDR);
    BTS_dbgI2cbStr = HWREGH(I2CB_BASE + I2C_O_STR);
}

//
// Blocking byte-level EEPROM/I2C helpers. These run only at boot and on an
// explicit calibration save, so a polled implementation is appropriate.
//
//
// I2CB bus recovery.
//
// A module reset clears a latched BB inside the controller, but it cannot
// free the WIRE. If the controller was reset - or the CPU halted - while a
// target was mid-byte, that target is still driving SDA low waiting for the
// clocks to finish its transfer. Every subsequent START then fails
// arbitration and the whole bus looks dead, which is exactly the state a
// debugger halt during an F-RAM transfer leaves behind.
//
// The documented escape is to bit-bang up to nine SCL pulses with SDA
// released: nine is enough for any target to clock out the rest of its byte
// plus the ACK, after which it releases SDA and we can issue a clean STOP.
//
// The pins are temporarily taken back from the I2C peripheral to plain GPIO
// to do this, then handed back. GPIO40/41 belong to CPU2 (assigned by CPU1
// in BTS_HAL_setupCpu2Pins), so these writes are permitted here.
//
#define BTS_I2CB_SDA_PIN   40U
#define BTS_I2CB_SCL_PIN   41U
#define BTS_I2CB_RECOVERY_PULSES  9U

//
// Half-bit delay for the recovery clocking, ~5 us => ~100 kHz. SysCtl_delay
// is 5 cycles per count, so this is SYSCLK/(5*200000).
//
#define BTS_I2C_RECOVERY_HALFBIT  ((DEVICE_SYSCLK_FREQ / 1000000U) * 1U)

//
// Counts how often the wire had to be freed. Non-zero means a transfer was
// interrupted mid-byte - worth knowing, since it is invisible otherwise.
//
volatile uint16_t BTS_dbgBusRecoveries = 0U;
volatile uint16_t BTS_dbgBusRecoverOk  = 0xFFU;

static bool i2cRecoverBus(void)
{
    uint16_t i;
    bool     freed;

    BTS_dbgBusRecoveries++;

    //
    // Park the module so it is not driving the pins while we do.
    //
    // Clearing IRS is not enough on its own: STP survives it, so the module
    // resumes clamping SCL the moment it is re-enabled. Zero the whole mode
    // register so the controller genuinely lets go of both wires first -
    // otherwise the bit-banging below fights the peripheral for the pins and
    // the nine pulses accomplish nothing.
    //
    I2C_disableModule(I2CB_BASE);
    HWREGH(I2CB_BASE + I2C_O_MDR) = 0U;

    //
    // Both pins to open-drain GPIO. SDA stays an input so a target can keep
    // driving it; only SCL is driven, and only low - the bus pull-ups provide the
    // high level, as an open-drain bus requires.
    //
    GPIO_setPinConfig(GPIO_40_GPIO40);
    GPIO_setPinConfig(GPIO_41_GPIO41);
    GPIO_setPadConfig(BTS_I2CB_SDA_PIN, GPIO_PIN_TYPE_OD | GPIO_PIN_TYPE_PULLUP);
    GPIO_setPadConfig(BTS_I2CB_SCL_PIN, GPIO_PIN_TYPE_OD | GPIO_PIN_TYPE_PULLUP);
    GPIO_setDirectionMode(BTS_I2CB_SDA_PIN, GPIO_DIR_MODE_IN);
    GPIO_setDirectionMode(BTS_I2CB_SCL_PIN, GPIO_DIR_MODE_OUT);
    GPIO_writePin(BTS_I2CB_SCL_PIN, 1);

    //
    // Nine pulses, ~100 kHz so the slowest target on the bus can follow.
    // Stop early the moment SDA floats high - the target has let go.
    //
    for (i = 0U; i < BTS_I2CB_RECOVERY_PULSES; i++) {
        if (GPIO_readPin(BTS_I2CB_SDA_PIN) != 0U) {
            break;
        }
        GPIO_writePin(BTS_I2CB_SCL_PIN, 0);
        SysCtl_delay(BTS_I2C_RECOVERY_HALFBIT);
        GPIO_writePin(BTS_I2CB_SCL_PIN, 1);
        SysCtl_delay(BTS_I2C_RECOVERY_HALFBIT);
    }

    //
    // Both wires have to be released, not just SDA. The failure actually seen
    // here clamped SCL while SDA floated high, so an SDA-only test reported
    // 'still stuck' on a bus whose data line had never been the problem, and
    // reported nothing at all about the line that was.
    //
    freed = (GPIO_readPin(BTS_I2CB_SDA_PIN) != 0U) &&
            (GPIO_readPin(BTS_I2CB_SCL_PIN) != 0U);

    //
    // Manual STOP: SDA low->high while SCL is high. Leaves every target in
    // its idle state rather than half-addressed.
    //
    GPIO_setDirectionMode(BTS_I2CB_SDA_PIN, GPIO_DIR_MODE_OUT);
    GPIO_writePin(BTS_I2CB_SDA_PIN, 0);
    SysCtl_delay(BTS_I2C_RECOVERY_HALFBIT);
    GPIO_writePin(BTS_I2CB_SCL_PIN, 1);
    SysCtl_delay(BTS_I2C_RECOVERY_HALFBIT);
    GPIO_writePin(BTS_I2CB_SDA_PIN, 1);
    SysCtl_delay(BTS_I2C_RECOVERY_HALFBIT);
    GPIO_setDirectionMode(BTS_I2CB_SDA_PIN, GPIO_DIR_MODE_IN);

    //
    // Hand the pins back and re-establish the controller from scratch: the
    // prescaler and bit count are part of initI2C_Master(), so reusing it
    // keeps one definition of the module's configuration.
    //
    GPIO_setPinConfig(GPIO_40_SDAB);
    GPIO_setPinConfig(GPIO_41_SCLB);
    initI2C_Master();

    BTS_dbgBusRecoverOk = freed ? 1U : 0U;
    return freed;
}

static bool i2cMasterWaitBusFree(void)
{
    //
    // Bounded: these helpers are also reached from the ADS1119 DRDY ISRs, so
    // an absent or wedged device on the bus must not stall the CPU forever.
    //
    uint32_t guard = 0;
    while (I2C_isBusBusy(I2CB_BASE)) {
        if (++guard > BTS_I2C_TIMEOUT_ITERATIONS) {
            //
            // BB latches until a stop is actually seen on the wire. A
            // transfer that ended without one - a read whose stop was
            // requested but never completed, or a device that stretched
            // the clock through it - leaves the module permanently busy,
            // and from then on every setTargetAddress() write is ignored
            // and no new START is ever emitted. Without this the first
            // wedged transfer would silently disable the bus for good.
            //
            // Resetting through nIRS is the documented way out: it clears
            // BB and returns the module to its idle state. The clocking
            // configuration survives, so only the enable has to be
            // re-asserted.
            //
            I2C_disableModule(I2CB_BASE);
            SysCtl_delay(100U);
            I2C_enableModule(I2CB_BASE);
            I2C_clearStatus(I2CB_BASE,
                            I2C_STS_NO_ACK | I2C_STS_ARB_LOST |
                            I2C_STS_REG_ACCESS_RDY | I2C_STS_STOP_CONDITION);

            if (!I2C_isBusBusy(I2CB_BASE)) {
                return true;
            }

            //
            // Still busy after a module reset: the controller is not the
            // problem, a target is holding the wire. Clock it free.
            //
            (void)i2cRecoverBus();
            return !I2C_isBusBusy(I2CB_BASE);
        }
    }
    return true;
}

//
// Waits for a requested stop condition to actually appear on the bus.
//
// Bounded like every other wait here: if the stop never lands the
// module is left busy and the next caller's bus-free wait performs the
// reset, rather than this spinning forever inside an ISR.
//
static void i2cMasterWaitStopComplete(void)
{
    uint32_t guard = 0;
    while (I2C_isBusBusy(I2CB_BASE)) {
        if (++guard > BTS_I2C_TIMEOUT_ITERATIONS) {
            return;
        }
    }
}

static bool i2cMasterWaitReady(void)
{
    uint32_t guard = 0;
    while ((I2C_getStatus(I2CB_BASE) & I2C_STS_REG_ACCESS_RDY) == 0U) {
        if (++guard > BTS_I2C_TIMEOUT_ITERATIONS) {
            return false;
        }
        if (I2C_getStatus(I2CB_BASE) & I2C_STS_NO_ACK) {
            I2C_clearStatus(I2CB_BASE, I2C_STS_NO_ACK);
            return false;
        }
    }
    return true;
}

//
// Writes a block to the EEPROM at a 16-bit word address.
//
static bool i2cWriteBlock(uint16_t devAddr, uint16_t memAddr,
                          const uint16_t *bytes, uint16_t count)
{
    uint16_t i;

    if (!i2cMasterWaitBusFree()) {
        return false;
    }

    I2C_setTargetAddress(I2CB_BASE, devAddr);
    I2C_setConfig(I2CB_BASE, I2C_CONTROLLER_SEND_MODE);
    I2C_setDataCount(I2CB_BASE, count + 2U);

    I2C_putData(I2CB_BASE, (memAddr >> 8) & 0xFFU);
    I2C_putData(I2CB_BASE, memAddr & 0xFFU);
    I2C_sendStartCondition(I2CB_BASE);

    for (i = 0; i < count; i++) {
        uint32_t guard = 0;
        while ((I2C_getStatus(I2CB_BASE) & I2C_STS_TX_DATA_RDY) == 0U) {
            if (++guard > BTS_I2C_TIMEOUT_ITERATIONS) {
                I2C_sendStopCondition(I2CB_BASE);
                return false;
            }
        }
        I2C_putData(I2CB_BASE, bytes[i] & 0xFFU);
    }

    I2C_sendStopCondition(I2CB_BASE);

    if (!i2cMasterWaitReady()) {
        return false;
    }

    //
    // ARDY only says the module finished its own work; the stop still
    // has to land before the bus belongs to anyone else.
    //
    i2cMasterWaitStopComplete();
    return true;
}

//
// Reads a block from the EEPROM using the usual write-address / restart-read
// sequence.
//
static bool i2cReadBlock(uint16_t devAddr, uint16_t memAddr,
                         uint16_t *bytes, uint16_t count)
{
    uint16_t i;

    if (!i2cMasterWaitBusFree()) {
        return false;
    }

    // Phase 1: write the memory address, no stop (repeated start follows).
    I2C_setTargetAddress(I2CB_BASE, devAddr);
    I2C_setConfig(I2CB_BASE, I2C_CONTROLLER_SEND_MODE);
    I2C_setDataCount(I2CB_BASE, 2U);
    I2C_putData(I2CB_BASE, (memAddr >> 8) & 0xFFU);
    I2C_putData(I2CB_BASE, memAddr & 0xFFU);
    I2C_sendStartCondition(I2CB_BASE);

    if (!i2cMasterWaitReady()) {
        I2C_sendStopCondition(I2CB_BASE);
        return false;
    }

    // Phase 2: repeated start, read count bytes.
    I2C_setConfig(I2CB_BASE, I2C_CONTROLLER_RECEIVE_MODE);
    I2C_setDataCount(I2CB_BASE, count);
    I2C_sendStartCondition(I2CB_BASE);

    for (i = 0; i < count; i++) {
        uint32_t guard = 0;
        while ((I2C_getStatus(I2CB_BASE) & I2C_STS_RX_DATA_RDY) == 0U) {
            if (++guard > BTS_I2C_TIMEOUT_ITERATIONS) {
                I2C_sendStopCondition(I2CB_BASE);
                return false;
            }
            if (I2C_getStatus(I2CB_BASE) & I2C_STS_NO_ACK) {
                I2C_clearStatus(I2CB_BASE, I2C_STS_NO_ACK);
                I2C_sendStopCondition(I2CB_BASE);
                return false;
            }
        }
        bytes[i] = I2C_getData(I2CB_BASE) & 0xFFU;
    }

    I2C_sendStopCondition(I2CB_BASE);

    //
    // Let the stop reach the wire before handing the bus on. Returning
    // the moment STP is requested leaves BB set for the next caller,
    // whose setTargetAddress() is then ignored - which is how a
    // perfectly healthy device ends up looking absent.
    //
    i2cMasterWaitStopComplete();
    return true;
}

//
//=============================================================================
// ADS1119 command-protocol helpers
//=============================================================================
//
// The ADS1119 is command-based, not memory-addressed: an access is a single
// command byte, optionally followed by one data byte (WREG) or by a repeated
// start and a read phase (RREG, RDATA). The F-RAM helpers above always emit
// a 16-bit memory address first and so cannot be used here.
//

//
// Writes a command, and optionally its data byte, then stops.
//
//   S  ADDR W A  CMD A  [DATA A]  P
//
// Used for the bare commands (RESET, START/SYNC, POWERDOWN) and for WREG,
// which is the same frame with one payload byte appended.
//
static bool ads1119Write(uint16_t devAddr, uint16_t cmd,
                         const uint16_t *data)
{
    uint16_t count = (data != 0) ? 2U : 1U;
    uint32_t guard;

    if (!i2cMasterWaitBusFree()) {
        return false;
    }

    //
    // One atomic write to I2CMDR starts the frame with the stop already
    // armed, so the module emits it once the byte count reaches zero.
    //
    // The driverlib sequence cannot be used here. It needs three separate
    // writes to get a frame moving, and setting STP in a later one races the
    // transfer: on a one-byte command the frame is torn down before the
    // eighth falling edge of SCL, which is exactly where the ADS1119 latches
    // a command, so the part never sees it. Arming the stop up front is safe
    // because the module honours the byte count first.
    //
    I2C_setTargetAddress(I2CB_BASE, devAddr);
    HWREGH(I2CB_BASE + I2C_O_CNT) = count;

    //
    // The first byte goes in before the frame starts so it is ready the
    // moment the address has been acknowledged.
    //
    I2C_putData(I2CB_BASE, cmd & 0xFFU);

    HWREGH(I2CB_BASE + I2C_O_MDR) = I2C_MDR_FREE | I2C_MDR_STT |
                                    I2C_MDR_STP  | I2C_MDR_MST |
                                    I2C_MDR_TRX  | I2C_MDR_IRS;

    //
    // I2CB runs without its transmit FIFO, so I2CDXR holds exactly one byte:
    // the second one can only be handed over once the first has been taken.
    //
    if (data != 0) {
        guard = 0;
        while ((I2C_getStatus(I2CB_BASE) & I2C_STS_TX_DATA_RDY) == 0U) {
            if (++guard > BTS_I2C_TIMEOUT_ITERATIONS) {
                i2cMasterWaitStopComplete();
                return false;
            }
            if (I2C_getStatus(I2CB_BASE) & I2C_STS_NO_ACK) {
                I2C_clearStatus(I2CB_BASE, I2C_STS_NO_ACK);
                i2cMasterWaitStopComplete();
                return false;
            }
        }
        I2C_putData(I2CB_BASE, *data & 0xFFU);
    }

    //
    // Wait for the stop the module was told to send. Neither XRDY nor ARDY
    // can stand in for this: XRDY is already high at the start because
    // I2CDXR is empty, and ARDY is latched and self-clearing, so on frames
    // this short it can set and clear again before the first poll.
    //
    i2cMasterWaitStopComplete();

    //
    // The part latches a command on the eighth falling edge of SCL and then
    // acts on it; starting the next frame immediately can arrive while it is
    // still doing so.
    //
    DEVICE_DELAY_US(50);

    return (I2C_getStatus(I2CB_BASE) & I2C_STS_NO_ACK) == 0U;
}

//
// Sends a bare single-byte command (RESET, START/SYNC, POWERDOWN).
//
static bool ads1119Command(uint16_t devAddr, uint16_t cmd)
{
    return ads1119Write(devAddr, cmd, 0);
}

//
// WREG: writes the single 8-bit configuration register.
//
//   S  ADDR W A  WREG A  DATA A  P
//
static bool ads1119WriteConfig(uint16_t devAddr, uint16_t cfg)
{
    uint16_t value = cfg & 0xFFU;

    return ads1119Write(devAddr, ADS1119_CMD_WREG, &value);
}

//
// Issues a command and reads its response after a repeated start.
//
//   S  ADDR W A  CMD A  Sr  ADDR R A  DATA ... P
//
// Used by RREG (configuration or status) and RDATA.
//
static bool ads1119ReadAfterCommand(uint16_t devAddr, uint16_t cmd,
                                    uint16_t *bytes, uint16_t count)
{
    uint16_t i;
    uint32_t guard;

    if (!i2cMasterWaitBusFree()) {
        return false;
    }

    //
    // Both phases drive I2CMDR with a single write rather than going through
    // I2C_setConfig() / I2C_sendStartCondition() separately.
    //
    // The driverlib helpers issue three writes to get a frame moving, and
    // I2C_setConfig() preserves STT and STP while it does so. On frames this
    // short the transfer can complete between those writes, so the sequence
    // has to be committed atomically or the repeated start below lands on a
    // transaction the module has already finished. These are the exact mode
    // words that were verified working against both converters by hand.
    //
    //   MST | TRX | IRS | FREE | STT        - write phase, no stop
    //   MST |       IRS | FREE | STT | STP  - read phase, stop after N bytes
    //

    //
    // Phase 1: the command byte. No stop - a repeated start follows.
    //
    I2C_setTargetAddress(I2CB_BASE, devAddr);
    HWREGH(I2CB_BASE + I2C_O_CNT) = 1U;
    I2C_putData(I2CB_BASE, cmd & 0xFFU);
    HWREGH(I2CB_BASE + I2C_O_MDR) = I2C_MDR_FREE | I2C_MDR_STT |
                                    I2C_MDR_MST  | I2C_MDR_TRX |
                                    I2C_MDR_IRS;

    //
    // The command has to be on the wire before the repeated start. ARDY is
    // the module's own "ready for the next phase" signal and is the right
    // one here precisely because no stop is involved.
    //
    guard = 0;
    while ((I2C_getStatus(I2CB_BASE) & I2C_STS_REG_ACCESS_RDY) == 0U) {
        if (++guard > BTS_I2C_TIMEOUT_ITERATIONS) {
            I2C_sendStopCondition(I2CB_BASE);
            i2cMasterWaitStopComplete();
            return false;
        }
        if (I2C_getStatus(I2CB_BASE) & I2C_STS_NO_ACK) {
            I2C_clearStatus(I2CB_BASE, I2C_STS_NO_ACK);
            I2C_sendStopCondition(I2CB_BASE);
            i2cMasterWaitStopComplete();
            return false;
        }
    }

    //
    // Phase 2: repeated start into a read, with the stop already armed so
    // the module releases the bus itself once the last byte has come in.
    //
    HWREGH(I2CB_BASE + I2C_O_CNT) = count;
    HWREGH(I2CB_BASE + I2C_O_MDR) = I2C_MDR_FREE | I2C_MDR_STT |
                                    I2C_MDR_STP  | I2C_MDR_MST |
                                    I2C_MDR_IRS;

    for (i = 0; i < count; i++) {
        guard = 0;
        while ((I2C_getStatus(I2CB_BASE) & I2C_STS_RX_DATA_RDY) == 0U) {
            if (++guard > BTS_I2C_TIMEOUT_ITERATIONS) {
                I2C_sendStopCondition(I2CB_BASE);
                i2cMasterWaitStopComplete();
                return false;
            }
            if (I2C_getStatus(I2CB_BASE) & I2C_STS_NO_ACK) {
                I2C_clearStatus(I2CB_BASE, I2C_STS_NO_ACK);
                I2C_sendStopCondition(I2CB_BASE);
                i2cMasterWaitStopComplete();
                return false;
            }
        }
        bytes[i] = I2C_getData(I2CB_BASE) & 0xFFU;
    }

    //
    // The stop was armed with the read, so just wait for it to land before
    // handing the bus on - leaving BB set makes the next caller's target
    // address write silently ignored.
    //
    i2cMasterWaitStopComplete();
    return true;
}

//
// A C28x byte is 16 bits wide, so the EEPROM image is packed two bytes per
// word. These helpers convert between the packed on-wire form and the
// in-memory struct.
//
#define CAL_EEPROM_BYTES (2U * (uint16_t)sizeof(BTS_channelCalibration))

static void calibrationToBytes(const BTS_channelCalibration *cal, uint16_t *bytes)
{
    const uint16_t *words = (const uint16_t *)cal;
    uint16_t i;
    for (i = 0; i < (uint16_t)sizeof(BTS_channelCalibration); i++) {
        bytes[i * 2U]      = words[i] & 0xFFU;
        bytes[i * 2U + 1U] = (words[i] >> 8) & 0xFFU;
    }
}

static void bytesToCalibration(const uint16_t *bytes, BTS_channelCalibration *cal)
{
    uint16_t *words = (uint16_t *)cal;
    uint16_t i;
    for (i = 0; i < (uint16_t)sizeof(BTS_channelCalibration); i++) {
        words[i] = (bytes[i * 2U] & 0xFFU) | ((bytes[i * 2U + 1U] & 0xFFU) << 8);
    }
}

bool writeEEPROM(uint16_t channel, const BTS_channelCalibration* data)
{
    uint16_t bytes[CAL_EEPROM_BYTES];
    uint16_t eepromAddr = CAL_FRAM_BASE + channel * CAL_FRAM_STRIDE_BYTES;

    calibrationToBytes(data, bytes);
    return i2cWriteBlock(EEPROM_I2C_ADDR, eepromAddr, bytes, CAL_EEPROM_BYTES);
}

bool readEEPROM(uint16_t channel, BTS_channelCalibration* data)
{
    uint16_t bytes[CAL_EEPROM_BYTES];
    uint16_t eepromAddr = CAL_FRAM_BASE + channel * CAL_FRAM_STRIDE_BYTES;

    if (!i2cReadBlock(EEPROM_I2C_ADDR, eepromAddr, bytes, CAL_EEPROM_BYTES)) {
        return false;
    }
    bytesToCalibration(bytes, data);
    return true;
}

//
// CRC-32 over the struct's words, excluding the trailing crc32 field itself.
// Each 16-bit C28x word contributes its two wire bytes low half first, which
// is the little-endian word order the image is written in.
//
static uint32_t calibrationCrc32(const BTS_channelCalibration *cal)
{
    const uint16_t *words = (const uint16_t *)cal;
    uint16_t nWords = (uint16_t)sizeof(BTS_channelCalibration) - 2U;
    uint32_t crc = 0xFFFFFFFFUL;
    uint16_t i;
    uint16_t b;
    uint16_t bit;

    for (i = 0; i < nWords; i++) {
        for (b = 0; b < 2U; b++) {
            crc ^= (uint32_t)((words[i] >> (b * 8U)) & 0xFFU);
            for (bit = 0; bit < 8U; bit++) {
                crc = (crc & 1UL) ? ((crc >> 1) ^ 0xEDB88320UL) : (crc >> 1);
            }
        }
    }
    return crc ^ 0xFFFFFFFFUL;
}

//
// True when a and b agree to within 0.1 %, used to catch a partially-written
// block through the reciprocal gain pair.
//
static bool calWithinTenth(float32_t a, float32_t b)
{
    float32_t diff = a - b;
    float32_t mag  = (b < 0.0f) ? -b : b;

    if (diff < 0.0f) {
        diff = -diff;
    }
    return (diff <= (mag * 0.001f));
}

//
// A calibration block is valid when the header matches and the channel it
// carries is the one we asked for. The channel lives in the low half of the
// header word rather than being OR-ed into the magic value, which would
// alias for channels >= 4.
//
static bool validateCalibration(const BTS_channelCalibration* cal, uint16_t channel)
{
    if ((cal->header & BTS_CAL_HEADER_MASK) != BTS_CAL_HEADER) {
        return false;
    }
    if ((cal->header & BTS_CAL_CHANNEL_MASK) != (uint32_t)channel) {
        return false;
    }
    if (cal->MaxCellTemp < -40.0f || cal->MaxCellTemp > 100.0f) {
        return false;
    }
    if (cal->F28V_Gain < 0.5f || cal->F28V_Gain > 2.0f || cal->F28V_Offset < -1.0f || cal->F28V_Offset > 1.0f) {
        return false;
    }
    //
    // The current gain band spans 20.0 because the on-chip current path is
    // referenced to 1.25 V and spans +/-10 A, so its nominal gain is ~9.66
    // (see BTS_F28I_GAIN_DEFAULT). The old 0.5..2.0 band predates that and
    // would reject the default outright, silently falling back to compiled-in
    // values and masking a stored calibration.
    //
    if (cal->F28I_Gain < 0.5f || cal->F28I_Gain > 20.0f || cal->F28I_Offset < -2.0f || cal->F28I_Offset > 2.0f) {
        return false;
    }
    //
    // The Iout/Vout gains were not range-checked at all, so a corrupt or
    // half-written block passed straight into the control loop's setpoint
    // arithmetic. Windows derived from the known-good compiled values.
    //
    if (cal->IoutGain_pu < 0.05f || cal->IoutGain_pu > 0.20f) {
        return false;
    }
    if (cal->VoutGain_pu < 0.10f || cal->VoutGain_pu > 0.40f) {
        return false;
    }
    //
    // The pu and engineering gains are a reciprocal pair. Disagreement means
    // a partially-written block, whatever the individual values look like.
    //
    if (cal->IoutGain_A == 0.0f || cal->VoutGain_V == 0.0f) {
        return false;
    }
    if (!calWithinTenth(1.0f / cal->IoutGain_pu, cal->IoutGain_A)) {
        return false;
    }
    if (!calWithinTenth(1.0f / cal->VoutGain_pu, cal->VoutGain_V)) {
        return false;
    }
    if (cal->crc32 != calibrationCrc32(cal)) {
        return false;
    }
    return true;
}

static bool validateGlobalVoltages(void)
{
    float chargeDisableV = registers[BTS_REG_IDX(eChargeDisableV)];
    float chargeRestrictV = registers[BTS_REG_IDX(eChargeRestrictV)];
    float dischargeRestrictV = registers[BTS_REG_IDX(eDischargeRestrictV)];
    float dischargeDisableV = registers[BTS_REG_IDX(eDischargeDisableV)];

    return (chargeDisableV >= MIN_VOLTAGE &&
            chargeDisableV <= chargeRestrictV &&
            chargeRestrictV <= dischargeRestrictV &&
            dischargeRestrictV <= dischargeDisableV &&
            dischargeDisableV <= MAX_VOLTAGE);
}

//
//=============================================================================
// CPU2 -> CPU1 notification
//=============================================================================
//
// registers[] lives in CPU2TOCPU1RAM and is written here before the flag is
// raised, so CPU1 sees a settled value. These are non-blocking: if the
// previous flag has not been acknowledged yet the notification is skipped,
// because CPU1 re-reads the affected block from registers[] anyway.
//
static void notifyCpu1RegisterWrite(uint16_t regIdx, float32_t value)
{
    if (IPC_isFlagBusyLtoR(IPC_CPU2_L_CPU1_R, BTS_IPC_FLAG_REG_WRITE)) {
        return;
    }
    ipcMsg.regAddr = regIdx;
    ipcMsg.value = value;
    IPC_setFlagLtoR(IPC_CPU2_L_CPU1_R, BTS_IPC_FLAG_REG_WRITE);
}

//
// Signals that every channel's calibration has been rewritten. CPU1 responds
// by reloading all channels and recalculating its program variables.
//
static void notifyCpu1CalibrationReload(void)
{
    IPC_setFlagLtoR(IPC_CPU2_L_CPU1_R, BTS_IPC_FLAG_CAL_RELOAD);
}

//
// Installs the compiled-in defaults for one channel.
//
static void applyDefaultCalibration(uint16_t ch)
{
    uint16_t tempBase = BTS_TEMP_BASE(ch);
    uint16_t calBase  = BTS_CAL_BASE(ch);

    registers[tempBase + BTS_TEMP_MAX] = DEFAULT_MAX_CELL_TEMP;

    registers[calBase + BTS_CAL_F28V_GAIN]      = DEFAULT_F28V_GAIN;
    registers[calBase + BTS_CAL_F28V_OFFSET]    = DEFAULT_F28V_OFFSET;
    registers[calBase + BTS_CAL_F28I_GAIN]      = DEFAULT_F28I_GAIN;
    registers[calBase + BTS_CAL_F28I_OFFSET]    = DEFAULT_F28I_OFFSET;
    registers[calBase + BTS_CAL_IOUT_GAIN_PU]   = defaultIoutGain_pu[ch];
    registers[calBase + BTS_CAL_IOUT_OFFSET_PU] = defaultIoutOffset_pu[ch];
    registers[calBase + BTS_CAL_IOUT_GAIN_A]    = defaultIoutGain_A[ch];
    registers[calBase + BTS_CAL_IOUT_OFFSET_A]  = defaultIoutOffset_A[ch];
    registers[calBase + BTS_CAL_VOUT_GAIN_PU]   = defaultVoutGain_pu[ch];
    registers[calBase + BTS_CAL_VOUT_OFFSET_PU] = defaultVoutOffset_pu[ch];
    registers[calBase + BTS_CAL_VOUT_GAIN_V]    = defaultVoutGain_V[ch];
    registers[calBase + BTS_CAL_VOUT_OFFSET_V]  = defaultVoutOffset_V[ch];
}

//
// Copies a validated EEPROM block into the register file.
//
static void applyStoredCalibration(uint16_t ch, const BTS_channelCalibration *cal)
{
    uint16_t tempBase = BTS_TEMP_BASE(ch);
    uint16_t calBase  = BTS_CAL_BASE(ch);

    registers[tempBase + BTS_TEMP_MAX] = cal->MaxCellTemp;

    registers[calBase + BTS_CAL_F28V_GAIN]      = cal->F28V_Gain;
    registers[calBase + BTS_CAL_F28V_OFFSET]    = cal->F28V_Offset;
    registers[calBase + BTS_CAL_F28I_GAIN]      = cal->F28I_Gain;
    registers[calBase + BTS_CAL_F28I_OFFSET]    = cal->F28I_Offset;
    registers[calBase + BTS_CAL_IOUT_GAIN_PU]   = cal->IoutGain_pu;
    registers[calBase + BTS_CAL_IOUT_OFFSET_PU] = cal->IoutOffset_pu;
    registers[calBase + BTS_CAL_IOUT_GAIN_A]    = cal->IoutGain_A;
    registers[calBase + BTS_CAL_IOUT_OFFSET_A]  = cal->IoutOffset_A;
    registers[calBase + BTS_CAL_VOUT_GAIN_PU]   = cal->VoutGain_pu;
    registers[calBase + BTS_CAL_VOUT_OFFSET_PU] = cal->VoutOffset_pu;
    registers[calBase + BTS_CAL_VOUT_GAIN_V]    = cal->VoutGain_V;
    registers[calBase + BTS_CAL_VOUT_OFFSET_V]  = cal->VoutOffset_V;
}

//
// Boot-time calibration load.
//
// For each channel: read the EEPROM block, and if it validates, load it into
// the register file; otherwise install safe defaults. The global voltage
// thresholds get the same treatment. Once the whole register file is
// populated, CPU1 is notified once so it can recalculate every channel's
// program variables and start running - rather than being interrupted eight
// times mid-population with a partially-valid register file.
//
void loadCalibration(void)
{
    uint16_t ch;
    uint16_t voltageBytes[16];

    for (ch = 0; ch < NUM_CHANNELS; ch++) {
        BTS_channelCalibration cal;

        //
        // calValidFlags[] is NOLOAD from CPU1's side, and CPU1 reads it every
        // status pass for the display ticks. Clear it before anything can
        // observe the RAM's power-up contents as validity.
        //
        calibrationData[ch].calFlags = 0UL;
        calValidFlags[ch] = 0UL;

        if (readEEPROM(ch, &cal) && validateCalibration(&cal, ch)) {
            calibrationData[ch] = cal;
            calValidFlags[ch] = cal.calFlags;
            applyStoredCalibration(ch, &cal);
        } else {
            applyDefaultCalibration(ch);
        }
    }

    //
    // Global charge/discharge voltage thresholds.
    //
    if (i2cReadBlock(EEPROM_I2C_ADDR, EEPROM_GLOBAL_V_ADDR, voltageBytes, 16U)) {
        float32_t voltages[4];
        uint16_t *dst = (uint16_t *)voltages;
        uint16_t i;
        for (i = 0; i < 8U; i++) {
            dst[i] = (voltageBytes[i * 2U] & 0xFFU) |
                     ((voltageBytes[i * 2U + 1U] & 0xFFU) << 8);
        }

        registers[BTS_REG_IDX(eChargeDisableV)]     = voltages[0];
        registers[BTS_REG_IDX(eChargeRestrictV)]    = voltages[1];
        registers[BTS_REG_IDX(eDischargeRestrictV)] = voltages[2];
        registers[BTS_REG_IDX(eDischargeDisableV)]  = voltages[3];
    }

    if (!validateGlobalVoltages()) {
        registers[BTS_REG_IDX(eChargeDisableV)]     = DEFAULT_CHARGE_DISABLE_V;
        registers[BTS_REG_IDX(eChargeRestrictV)]    = DEFAULT_CHARGE_RESTRICT_V;
        registers[BTS_REG_IDX(eDischargeRestrictV)] = DEFAULT_DISCHARGE_RESTRICT_V;
        registers[BTS_REG_IDX(eDischargeDisableV)]  = DEFAULT_DISCHARGE_DISABLE_V;
    }

    //
    // The register file is now complete and consistent - tell CPU1 to
    // recalculate its program variables from it and go.
    //
    registers[BTS_REG_IDX(eCalSlot)]     = (float32_t)BTS_CAL_SLOT_NONE;
    registers[BTS_REG_IDX(eCalCommand)]  = 0.0f;
    registers[BTS_REG_IDX(eCalArgument)] = 0.0f;
    registers[BTS_REG_IDX(eCalStatus)]   = 0.0f;
    registers[BTS_REG_IDX(eCalResult)]   = 0.0f;

    //
    // The watchdog is armed from boot, not from the host's first command:
    // a host that never appears is exactly the case it exists to catch.
    //
    registers[BTS_REG_IDX(eHostWatchdog_s)]      = BTS_HOST_WD_DEFAULT_S;
    registers[BTS_REG_IDX(eWatchdogRemaining_s)] = BTS_HOST_WD_DEFAULT_S;
    hostWatchdogFeed();

    notifyCpu1CalibrationReload();
}

//
// Commits one channel's register-file calibration to F-RAM.
//
// extraFlags is OR-ed into the stored calFlags, so a runtime calibration can
// mark which of the two paths it established while a plain re-save preserves
// whatever was already recorded.
//
static bool saveCalibrationFlags(uint16_t channel, uint32_t extraFlags)
{
    BTS_channelCalibration cal;
    uint16_t tempBase = BTS_TEMP_BASE(channel);
    uint16_t calBase  = BTS_CAL_BASE(channel);
    bool     written  = false;

    cal.header   = BTS_CAL_MAKE_HEADER(channel);
    cal.dateTime = CPUTimer_getTimerCount(CPUTIMER1_BASE);

    cal.MaxCellTemp   = registers[tempBase + BTS_TEMP_MAX];
    cal.F28V_Gain     = registers[calBase + BTS_CAL_F28V_GAIN];
    cal.F28V_Offset   = registers[calBase + BTS_CAL_F28V_OFFSET];
    cal.F28I_Gain     = registers[calBase + BTS_CAL_F28I_GAIN];
    cal.F28I_Offset   = registers[calBase + BTS_CAL_F28I_OFFSET];
    cal.IoutGain_pu   = registers[calBase + BTS_CAL_IOUT_GAIN_PU];
    cal.IoutOffset_pu = registers[calBase + BTS_CAL_IOUT_OFFSET_PU];
    cal.IoutGain_A    = registers[calBase + BTS_CAL_IOUT_GAIN_A];
    cal.IoutOffset_A  = registers[calBase + BTS_CAL_IOUT_OFFSET_A];
    cal.VoutGain_pu   = registers[calBase + BTS_CAL_VOUT_GAIN_PU];
    cal.VoutOffset_pu = registers[calBase + BTS_CAL_VOUT_OFFSET_PU];
    cal.VoutGain_V    = registers[calBase + BTS_CAL_VOUT_GAIN_V];
    cal.VoutOffset_V  = registers[calBase + BTS_CAL_VOUT_OFFSET_V];

    cal.calFlags = calibrationData[channel].calFlags | extraFlags;
    cal.crc32    = calibrationCrc32(&cal);

    if (validateCalibration(&cal, channel)) {
        if (writeEEPROM(channel, &cal)) {
            calibrationData[channel] = cal;
            calValidFlags[channel] = cal.calFlags;
            written = true;
        }
    }

    //
    // Channel 0 also carries the unit-wide voltage thresholds.
    //
    if (channel == 0 && validateGlobalVoltages()) {
        float32_t voltages[4];
        uint16_t voltageBytes[16];
        const uint16_t *src = (const uint16_t *)voltages;
        uint16_t i;

        voltages[0] = registers[BTS_REG_IDX(eChargeDisableV)];
        voltages[1] = registers[BTS_REG_IDX(eChargeRestrictV)];
        voltages[2] = registers[BTS_REG_IDX(eDischargeRestrictV)];
        voltages[3] = registers[BTS_REG_IDX(eDischargeDisableV)];

        for (i = 0; i < 8U; i++) {
            voltageBytes[i * 2U]      = src[i] & 0xFFU;
            voltageBytes[i * 2U + 1U] = (src[i] >> 8) & 0xFFU;
        }
        i2cWriteBlock(EEPROM_I2C_ADDR, EEPROM_GLOBAL_V_ADDR, voltageBytes, 16U);
    }

    return written;
}

void saveCalibration(uint16_t channel)
{
    (void)saveCalibrationFlags(channel, 0UL);
}

//
// Commits every channel to EEPROM. Triggered by a host writing
// eCalibrationMode = 2.
//
static void saveAllCalibration(void)
{
    uint16_t ch;
    for (ch = 0; ch < NUM_CHANNELS; ch++) {
        saveCalibration(ch);
    }
}

//
//=============================================================================
// Slot runtime state persistence
//=============================================================================
//
// Same word-pair packing as the calibration image: a C28x "byte" is 16 bits,
// so each struct word contributes its two wire bytes low half first.
//
#define STATE_EEPROM_BYTES (2U * (uint16_t)sizeof(BTS_slotRuntimeState))

//
// Save/restore instrumentation. The F-RAM write result was previously
// discarded, so a failing transfer looked identical to a successful one.
//
volatile uint16_t BTS_dbgSaveOk    = 0xFFU;
volatile uint16_t BTS_dbgSaveCh    = 0xFFU;
volatile uint16_t BTS_dbgSaveFails = 0U;
volatile uint16_t BTS_dbgReadOk    = 0xFFU;
volatile uint16_t BTS_dbgValidOk   = 0xFFU;
volatile uint32_t BTS_dbgHdrSeen   = 0xFFFFFFFFUL;
volatile uint32_t BTS_dbgCrcSeen   = 0UL;
volatile uint32_t BTS_dbgCrcCalc   = 0UL;


//
// The record must fit inside its stride. A 40-byte record in a 32-byte stride
// silently corrupted seven of the eight slots for weeks; this makes the same
// mistake a build error instead of a field failure.
//
// A negative array bound is a hard error in any C compiler, so a violated
// condition fails the build rather than the field. Typedef'd, so it costs
// nothing at runtime and may appear at file scope.
//
typedef char bts_stateRecordFitsStride[
    (STATE_EEPROM_BYTES <= STATE_FRAM_STRIDE) ? 1 : -1];

//
// The record should fill its stride exactly: 32 C28x words = 64 wire bytes.
// If this fires, a field was added without taking the words back out of
// `reserved`, and every slot after slot 0 is about to be corrupted.
//
typedef char bts_stateRecordFillsStride[
    (STATE_EEPROM_BYTES == STATE_FRAM_STRIDE) ? 1 : -1];

//
// Same generator and seed as calibrationCrc32(), over a different struct.
//
static uint32_t slotStateCrc32(const BTS_slotRuntimeState *st)
{
    const uint16_t *words = (const uint16_t *)st;
    uint16_t nWords = (uint16_t)sizeof(BTS_slotRuntimeState) - 2U;
    uint32_t crc = 0xFFFFFFFFUL;
    uint16_t i;
    uint16_t b;
    uint16_t bit;

    for (i = 0; i < nWords; i++) {
        for (b = 0; b < 2U; b++) {
            crc ^= (uint32_t)((words[i] >> (b * 8U)) & 0xFFU);
            for (bit = 0; bit < 8U; bit++) {
                crc = (crc & 1UL) ? ((crc >> 1) ^ 0xEDB88320UL) : (crc >> 1);
            }
        }
    }
    return crc ^ 0xFFFFFFFFUL;
}

static bool writeSlotState(uint16_t channel, const BTS_slotRuntimeState *st)
{
    uint16_t bytes[STATE_EEPROM_BYTES];
    const uint16_t *words = (const uint16_t *)st;
    uint16_t addr = STATE_FRAM_BASE + channel * STATE_FRAM_STRIDE;
    uint16_t i;

    for (i = 0; i < (uint16_t)sizeof(BTS_slotRuntimeState); i++) {
        bytes[i * 2U]      = words[i] & 0xFFU;
        bytes[i * 2U + 1U] = (words[i] >> 8) & 0xFFU;
    }
    return i2cWriteBlock(EEPROM_I2C_ADDR, addr, bytes, STATE_EEPROM_BYTES);
}

static bool readSlotState(uint16_t channel, BTS_slotRuntimeState *st)
{
    uint16_t bytes[STATE_EEPROM_BYTES];
    uint16_t *words = (uint16_t *)st;
    uint16_t addr = STATE_FRAM_BASE + channel * STATE_FRAM_STRIDE;
    uint16_t i;

    if (!i2cReadBlock(EEPROM_I2C_ADDR, addr, bytes, STATE_EEPROM_BYTES)) {
        return false;
    }
    for (i = 0; i < (uint16_t)sizeof(BTS_slotRuntimeState); i++) {
        words[i] = (bytes[i * 2U] & 0xFFU) | ((bytes[i * 2U + 1U] & 0xFFU) << 8);
    }
    return true;
}

static bool validateSlotState(const BTS_slotRuntimeState *st, uint16_t channel)
{
    if ((st->header & BTS_STATE_HEADER_MASK) != BTS_STATE_HEADER) {
        return false;
    }
    if ((st->header & BTS_STATE_CHANNEL_MASK) != (uint32_t)channel) {
        return false;
    }
    return (st->crc32 == slotStateCrc32(st));
}

//
// Per-slot save counter, kept across saves so a host can tell a fresh record
// from a stale one and see how much writing the block has taken.
//
static uint32_t slotStateSaveCounter[NUM_CHANNELS];

//
// Composes and writes one slot's record from the register file. Called only
// from BTS_serviceDeferredWork() - F-RAM is never written from an ISR.
//
static bool saveSlotState(uint16_t channel)
{
    BTS_slotRuntimeState st;
    uint16_t rtBase = BTS_RT_BASE(channel);
    uint32_t bits   = (uint32_t)registers[rtBase + BTS_RT_STATUS];
    uint32_t flags  = 0UL;

    //
    // A paused slot is saved as running in its held direction: that is what
    // the restore has to reconstruct, and it is what a power cut mid-pause
    // should come back as.
    //
    if ((bits & (1UL << BTS_STATUS_RUNNING)) != 0UL) {
        flags |= BTS_STATE_F_RUNNING;
        if ((bits & (1UL << BTS_STATUS_CHARGING)) != 0UL) {
            flags |= BTS_STATE_F_CHARGING;
        }
    }
    if ((bits & (1UL << BTS_STATUS_END)) != 0UL) {
        flags |= BTS_STATE_F_END;
    }

    st.header           = BTS_STATE_MAKE_HEADER(channel);
    st.stateFlags       = flags;
    st.chargeMah        = registers[rtBase + BTS_RT_CHARGE_MAH];
    st.chargeMwh        = registers[rtBase + BTS_RT_CHARGE_MWH];
    st.chargeSeconds    = registers[rtBase + BTS_RT_CHARGE_SECONDS];
    st.dischargeMah     = registers[rtBase + BTS_RT_DISCHARGE_MAH];
    st.dischargeMwh     = registers[rtBase + BTS_RT_DISCHARGE_MWH];
    st.dischargeSeconds = registers[rtBase + BTS_RT_DISCHARGE_SECONDS];

    //
    // Slot settings travel with the runtime record, not the calibration
    // image, so changing a charge current never rewrites calibration.
    //
    {
        uint16_t setBase = BTS_SET_BASE(channel);
        st.voltageMin = registers[setBase + BTS_SET_V_MIN];
        st.voltageMax = registers[setBase + BTS_SET_V_MAX];
        st.currentMin = registers[setBase + BTS_SET_I_MIN];
        st.currentMax = registers[setBase + BTS_SET_I_MAX];
    }

    st.saveCounter      = ++slotStateSaveCounter[channel];
    st.reserved[0]      = 0UL;
    st.reserved[1]      = 0UL;
    st.crc32            = slotStateCrc32(&st);

    return writeSlotState(channel, &st);
}

//
// Boot restore. Populates the runtime counters and supervision.restoreFlags,
// then raises one IPC flag once the whole file is consistent - the same
// discipline as the calibration reload, not one flag per slot.
//
// An absent or invalid record is the normal first-boot case: the slot starts
// STOPPED with zeroed counters and nothing is logged.
//
static void loadSlotStates(void)
{
    uint32_t restoreFlags = 0UL;
    uint16_t ch;

    for (ch = 0; ch < NUM_CHANNELS; ch++) {
        BTS_slotRuntimeState st;
        uint16_t rtBase  = BTS_RT_BASE(ch);
        uint16_t setBase = BTS_SET_BASE(ch);

        bool rdOk = readSlotState(ch, &st);
        bool vdOk = rdOk && validateSlotState(&st, ch);
        if (ch == 0U) {
            BTS_dbgReadOk  = rdOk ? 1U : 0U;
            BTS_dbgValidOk = vdOk ? 1U : 0U;
            BTS_dbgHdrSeen = st.header;
            BTS_dbgCrcSeen = st.crc32;
            BTS_dbgCrcCalc = slotStateCrc32(&st);
        }

        if (vdOk) {
            registers[rtBase + BTS_RT_CHARGE_MAH]        = st.chargeMah;
            registers[rtBase + BTS_RT_CHARGE_MWH]        = st.chargeMwh;
            registers[rtBase + BTS_RT_CHARGE_SECONDS]    = st.chargeSeconds;
            registers[rtBase + BTS_RT_DISCHARGE_MAH]     = st.dischargeMah;
            registers[rtBase + BTS_RT_DISCHARGE_MWH]     = st.dischargeMwh;
            registers[rtBase + BTS_RT_DISCHARGE_SECONDS] = st.dischargeSeconds;

            //
            // Slot settings come back with the runtime record.
            //
            registers[setBase + BTS_SET_V_MIN] = st.voltageMin;
            registers[setBase + BTS_SET_V_MAX] = st.voltageMax;
            registers[setBase + BTS_SET_I_MIN] = st.currentMin;
            registers[setBase + BTS_SET_I_MAX] = st.currentMax;

            slotStateSaveCounter[ch] = st.saveCounter;
            restoreFlags |= (st.stateFlags & BTS_STATE_FLAGS_MASK)
                            << BTS_STATE_FLAGS_SHIFT(ch);
        } else {
            registers[rtBase + BTS_RT_CHARGE_MAH]        = 0.0f;
            registers[rtBase + BTS_RT_CHARGE_MWH]        = 0.0f;
            registers[rtBase + BTS_RT_CHARGE_SECONDS]    = 0.0f;
            registers[rtBase + BTS_RT_DISCHARGE_MAH]     = 0.0f;
            registers[rtBase + BTS_RT_DISCHARGE_MWH]     = 0.0f;
            registers[rtBase + BTS_RT_DISCHARGE_SECONDS] = 0.0f;

            //
            // No valid record - install the compiled limits rather than
            // leaving zeros, which would present as a 0 A / 0 V slot.
            //
            registers[setBase + BTS_SET_V_MIN] = DEFAULT_SLOT_VOLTAGE_MIN;
            registers[setBase + BTS_SET_V_MAX] = DEFAULT_SLOT_VOLTAGE_MAX;
            registers[setBase + BTS_SET_I_MIN] = DEFAULT_SLOT_CURRENT_MIN;
            registers[setBase + BTS_SET_I_MAX] = DEFAULT_SLOT_CURRENT_MAX;

            slotStateSaveCounter[ch] = 0UL;
        }
    }

    supervision.restoreFlags = restoreFlags;
    IPC_setFlagLtoR(IPC_CPU2_L_CPU1_R, BTS_IPC_FLAG_STATE_RESTORE);
}

void initCAN(void)
{
    //
    // CANA pins (GPIO30 = RX, GPIO31 = TX) muxed by CPU1.
    //
    CAN_initModule(CANA_BASE);
    CAN_setBitRate(CANA_BASE, DEVICE_SYSCLK_FREQ, CAN_BITRATE, 16);
    CAN_enableInterrupt(CANA_BASE, CAN_INT_IE0 | CAN_INT_ERROR | CAN_INT_STATUS);
    Interrupt_register(INT_CANA0, &canISR);
    Interrupt_enable(INT_CANA0);

    for (uint16_t i = 0; i < NUM_CHANNELS; i++) {
        CAN_setupMessageObject(CANA_BASE, i + 1, CAN_MSG_ID_BASE | ((uint32_t)i << 20) | 0x01,
                               CAN_MSG_FRAME_EXT, CAN_MSG_OBJ_TYPE_TX, 0,
                               CAN_MSG_OBJ_NO_FLAGS, 8);
    }
    CAN_setupMessageObject(CANA_BASE, 9, CAN_MSG_ID_BASE | 0x02, CAN_MSG_FRAME_EXT,
                           CAN_MSG_OBJ_TYPE_RX, 0x1FFFFFFF,
                           CAN_MSG_OBJ_RX_INT_ENABLE, 8);

    CAN_startModule(CANA_BASE);
}

void sendCANData(uint16_t channel)
{
    uint16_t data[8];
    const uint16_t *v;
    const uint16_t *c;

    if (channel >= NUM_CHANNELS) return;

    v = (const uint16_t *)&canData[channel].voltage;
    c = (const uint16_t *)&canData[channel].current;

    data[0] = canData[channel].channel & 0xFFU;
    data[1] = 0;
    data[2] = v[0] & 0xFFU;
    data[3] = (v[0] >> 8) & 0xFFU;
    data[4] = v[1] & 0xFFU;
    data[5] = (v[1] >> 8) & 0xFFU;
    data[6] = c[0] & 0xFFU;
    data[7] = (c[0] >> 8) & 0xFFU;

    CAN_sendMessage(CANA_BASE, channel + 1, 8, data);
}

volatile uint16_t sfraEnabled = 0;

void initUART(void)
{
#if (BTS_CONSOLE_ENABLED == true)
    //
    // Present only in a debug build (BTS_DEBUG_CONSOLE): the AT console
    // runs on SCIA (GPIO28/29), reaching the controlCARD's isolated FTDI
    // backchannel over the same USB cable as the debug probe.
    //
    //
    // Console pins (GPIO28/29) muxed by CPU1.
    //
    SCI_setConfig(BTS_CONSOLE_SCI_BASE, DEVICE_LSPCLK_FREQ, BTS_CONSOLE_BAUDRATE,
                  (SCI_CONFIG_WLEN_8 | SCI_CONFIG_STOP_ONE | SCI_CONFIG_PAR_NONE));
    SCI_resetChannels(BTS_CONSOLE_SCI_BASE);
    SCI_enableFIFO(BTS_CONSOLE_SCI_BASE);
    SCI_enableModule(BTS_CONSOLE_SCI_BASE);
    SCI_performSoftwareReset(BTS_CONSOLE_SCI_BASE);

    //
    // With the FIFO enabled the receiver raises RXFFINT, not RXRDY - enabling
    // SCI_INT_RXRDY_BRKDT here sets RXBKINTENA, which never fires in FIFO
    // mode, so characters pile up until the FIFO overflows and no ISR runs.
    // Interrupt after every character so AT commands are processed promptly.
    //
    SCI_setFIFOInterruptLevel(BTS_CONSOLE_SCI_BASE, SCI_FIFO_TX16, SCI_FIFO_RX1);
    SCI_enableInterrupt(BTS_CONSOLE_SCI_BASE, SCI_INT_RXFF);
    SCI_clearInterruptStatus(BTS_CONSOLE_SCI_BASE, SCI_INT_RXFF);

    Interrupt_register(BTS_CONSOLE_RX_INT, &uartRxISR);
    Interrupt_enable(BTS_CONSOLE_RX_INT);
#else
    //
    // Production build: GPIO29 drives the WS2812B LED string and GPIO28 is
    // channel 1's trip input, so no console port exists. The host talks to
    // the unit over I2C or CAN instead.
    //
#endif
}

void initTimer(void)
{
    CPUTimer_setPeriod(CPUTIMER1_BASE, DEVICE_SYSCLK_FREQ / 8);
    CPUTimer_setPreScaler(CPUTIMER1_BASE, 0);
    CPUTimer_enableInterrupt(CPUTIMER1_BASE);
    Interrupt_register(INT_TIMER1, &timerISR);
    Interrupt_enable(INT_TIMER1);
    CPUTimer_startTimer(CPUTIMER1_BASE);
}

//
// Brings one converter up, following the start-up sequence in the ADS1119
// datasheet (section 9.2.2): RESET, WREG, optional RREG sanity check, then
// START/SYNC to begin converting continuously.
//
// Returns true if the converter acknowledged and read back the configuration
// it was given. A false return means the part is absent or unreachable; its
// DRDY interrupt is then left masked rather than costing a full set of I2C
// timeouts on every edge.
//
static bool ads1119Start(uint16_t devAddr)
{
    uint16_t cfg = ADS1119_CFG_FOR_CH(0U);
    uint16_t readback = 0;

    //
    // Reset first so the part is in a known state regardless of what the
    // shared RESET1/RESET2 line did earlier.
    //
    if (!ads1119Command(devAddr, ADS1119_CMD_RESET)) {
        return false;
    }

    //
    // The datasheet gives no explicit recovery time for the RESET command,
    // but the power-on reset takes around 500 us to release. Give the part
    // the same margin before configuring it: a WREG that lands while the
    // reset is still settling is accepted on the bus and then discarded,
    // which reads back as 00h and looks exactly like a missing device.
    //
    DEVICE_DELAY_US(1000);

    if (!ads1119WriteConfig(devAddr, cfg)) {
        return false;
    }

    //
    // The part has no ID register, so reading the configuration back is the
    // identification. Distinguish the two ways this can fail, because they
    // mean very different things on the bench.
    //
    if (!ads1119ReadAfterCommand(devAddr, ADS1119_CMD_RREG_CFG, &readback, 1U)) {
        return false;
    }

    if ((readback & 0xFFU) != (cfg & 0xFFU)) {
        //
        // It answered but did not keep the configuration. Retry once: the
        // usual cause is a WREG that raced the reset above.
        //
        if (!ads1119WriteConfig(devAddr, cfg)) {
            return false;
        }
        if (!ads1119ReadAfterCommand(devAddr, ADS1119_CMD_RREG_CFG,
                                     &readback, 1U)) {
            return false;
        }
        if ((readback & 0xFFU) != (cfg & 0xFFU)) {
            return false;
        }
    }

    //
    // CM = 1 alone does not start anything. Continuous conversion begins
    // only on START/SYNC, which must be re-issued whenever CM changes.
    //
    return ads1119Command(devAddr, ADS1119_CMD_START);
}

void initADS1119(void)
{
    //
    // Free-running timebase for the settling delay between channels.
    //
    // CPU timer 0 is otherwise only started by the WS2812B driver, which
    // is compiled out in a console build, so start it here and let it run
    // with no interrupt. Only the counter is read.
    //
    CPUTimer_setPeriod(CPUTIMER0_BASE, 0xFFFFFFFFUL);
    CPUTimer_setPreScaler(CPUTIMER0_BASE, 0U);
    CPUTimer_disableInterrupt(CPUTIMER0_BASE);
    CPUTimer_startTimer(CPUTIMER0_BASE);

    bool ok1;
    bool ok2;

    //
    // Pins and interrupt routing first, but the interrupts themselves stay
    // masked: the DRDY ISRs perform blocking I2C transfers, so one firing
    // during the configuration writes below would deadlock against the
    // transfer already in progress.
    //
    //
    // DRDY pins (GPIO42/43) are configured as GPIO inputs by CPU1. The XINT
    // routing and edge selection are not pin-mux registers, so CPU2 sets
    // those itself.
    //
    GPIO_setInterruptPin(ADS1119_DRDY_GPIO_1, GPIO_INT_XINT1);
    GPIO_setInterruptType(GPIO_INT_XINT1, GPIO_INT_TYPE_FALLING_EDGE);
    GPIO_setInterruptPin(ADS1119_DRDY_GPIO_2, GPIO_INT_XINT2);
    GPIO_setInterruptType(GPIO_INT_XINT2, GPIO_INT_TYPE_FALLING_EDGE);

    Interrupt_register(INT_XINT1, &ads1119Drdy1ISR);
    Interrupt_register(INT_XINT2, &ads1119Drdy2ISR);

    //
    // Configure both converters for channel 0 and start them converting.
    // CPU1 pulses the shared RESET1/RESET2 lines during its own start-up,
    // well before it releases CPU2, so the reset cannot land after these
    // writes and silently return the configuration register to 00h.
    //
    ok1 = ads1119Start(ADS1119_ADDR_1);
    ok2 = ads1119Start(ADS1119_ADDR_2);

    currentAdsChannel[0] = 0U;
    currentAdsChannel[1] = 0U;
    adsFailCount[0] = ok1 ? 0U : ADS1119_MAX_CONSECUTIVE_FAILURES;
    adsFailCount[1] = ok2 ? 0U : ADS1119_MAX_CONSECUTIVE_FAILURES;

#if (BTS_CONSOLE_ENABLED == true)
    uartSendResponse(ok1 ? "ADS1119 @0x40 ok" : "ADS1119 @0x40 not found");
    uartSendResponse(ok2 ? "ADS1119 @0x41 ok" : "ADS1119 @0x41 not found");
#endif

    //
    // Now the bus is idle, accept DRDY. Clear anything the PIE latched while
    // the converters were being configured, otherwise a stale edge fires the
    // ISR immediately and it contends with this still-unfinished init.
    //
    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP1);

    if (ok1) {
        GPIO_enableInterrupt(GPIO_INT_XINT1);
        Interrupt_enable(INT_XINT1);
    }
    if (ok2) {
        GPIO_enableInterrupt(GPIO_INT_XINT2);
        Interrupt_enable(INT_XINT2);
    }
}

float mVToTemperature(float mV)
{
    float v = mV * (float)0.001;
    float t;

    //
    // No low-end rejection. The amplifier holds its output above ground, so
    // the fit bottoms out at +18.3 C for 0 V in - there is no input voltage
    // that produces a nonsensically low temperature, and a reading of a few
    // tens of millivolts is a genuine measurement just under 19 C rather
    // than a sign of a missing sensor.
    //
    // Negative inputs are the one exception: the converter is bipolar, so a
    // negative code means the input went below AGND, which the conditioning
    // cannot legitimately produce.
    //
    if (v < (float)0.0) {
        v = (float)0.0;
    }

    //
    // The top of the amplifier range sits above the converter full scale, so
    // a reading cannot legitimately exceed it. Clamp rather than reject:
    // this end is a genuine over-temperature, not a wiring fault.
    //
    if (v > BTS_NTC_V_MAX) {
        v = BTS_NTC_V_MAX;
    }

    //
    // Horner's method - four multiply-adds rather than building the powers.
    //
    t = BTS_NTC_POLY_C4;
    t = t * v + BTS_NTC_POLY_C3;
    t = t * v + BTS_NTC_POLY_C2;
    t = t * v + BTS_NTC_POLY_C1;
    t = t * v + BTS_NTC_POLY_C0;

    return t;
}

float readADS1119Data(uint16_t adsAddr, uint16_t channel)
{
    uint16_t data[2];
    int16_t raw;
    float mV;
    uint16_t unit = (adsAddr == ADS1119_ADDR_1) ? 0U : 1U;

    (void)channel;

    //
    // RDATA, then a repeated start and two bytes MSB first.
    //
    if (!ads1119ReadAfterCommand(adsAddr, ADS1119_CMD_RDATA, data, 2U)) {
        //
        // No response. Give up on this converter after a run of failures so a
        // missing device cannot monopolise the CPU.
        //
        if (adsFailCount[unit] < ADS1119_MAX_CONSECUTIVE_FAILURES) {
            adsFailCount[unit]++;
            if (adsFailCount[unit] >= ADS1119_MAX_CONSECUTIVE_FAILURES) {
                GPIO_disableInterrupt((unit == 0U) ? GPIO_INT_XINT1
                                                   : GPIO_INT_XINT2);
            }
        }
        return 0.0f;
    }

    adsFailCount[unit] = 0;

    //
    // Bipolar 16-bit result against the external 2.50 V reference on
    // REFP/REFN, not the internal 2.048 V.
    //
    raw = (int16_t)(((data[0] & 0xFFU) << 8) | (data[1] & 0xFFU));
    mV = ((float)raw * ADS1119_VREF_MV) / ADS1119_FULL_SCALE;

    return mVToTemperature(mV);
}

//
// Points the converter's multiplexer at the next thermistor. Writing the
// configuration register restarts the conversion by itself, so no further
// START/SYNC is needed here.
//
void configureNextChannel(uint16_t adsAddr, uint16_t nextChannel)
{
    ads1119WriteConfig(adsAddr, ADS1119_CFG_FOR_CH(nextChannel));
}

//
// Publishes one channel's measured temperature.
//
// This goes to eChX_CellTemp (RO), NOT to the min/max pair at 512: that pair
// is the configured trip window, is mirrored into the F-RAM calibration
// image, and writing a measurement over it destroys the configuration.
//
// A failed read is left out of the register file entirely rather than
// published as 0.0 degrees C, which would read as a plausible temperature.
//
static void publishCellTemp(uint16_t channel, float temp, bool valid)
{
    if (!valid) {
        return;
    }

    registers[BTS_CELLTEMP_IDX(channel)] = temp;

    //
    // Advisory to CPU1's control loops; the value is already settled in
    // registers[] before the flag is raised. Non-blocking: if the previous
    // notification has not been acknowledged the update is simply skipped,
    // since CPU1 re-reads the register anyway.
    //
    if (!IPC_isFlagBusyLtoR(IPC_CPU2_L_CPU1_R, BTS_IPC_FLAG_TEMP_UPDATE)) {
        IPC_setFlagLtoR(IPC_CPU2_L_CPU1_R, BTS_IPC_FLAG_TEMP_UPDATE);
    }
}

//
//=============================================================================
// Background temperature acquisition
//=============================================================================
//
// The converters are serviced from the main loop, not from the DRDY
// interrupts. An I2C transfer at 400 kHz takes tens of microseconds, and the
// old code ran a whole RDATA frame plus a reconfiguration write inside the
// ISR with spin-waits throughout. That starved everything else on this core:
// the AT console dropped characters and the I2CA slave could not answer the
// host while a conversion was being collected.
//
// Now a DRDY edge only records that a result is waiting. BTS_serviceADS1119()
// performs one short, non-blocking step per call from the idle loop, so the
// bus is driven continuously in the background while the interrupts stay
// trivially short.
//
typedef enum {
    eAdsIdle = 0,       // waiting for DRDY
    eAdsReadCmd,        // RDATA command frame issued
    eAdsReadData,       // collecting the two result bytes
    eAdsSetMux,         // starting the WREG frame for the next channel
    eAdsMuxDone,        // waiting for the WREG frame to complete
    eAdsStart,          // re-arming conversions after the mux change
    eAdsStartDone,      // waiting for the START/SYNC frame to finish
    eAdsSettle,         // letting the new channel settle
} BTS_adsState;

static volatile BTS_adsState adsState[2]   = {eAdsIdle, eAdsIdle};
static volatile uint16_t     adsPending[2] = {0U, 0U};
static uint16_t              adsRxBytes[2][2];
static uint16_t              adsRxCount[2] = {0U, 0U};
static uint32_t              adsGuard[2]   = {0U, 0U};

//
// Consecutive service passes that found I2CB busy while a conversion was
// waiting to be read. The main loop runs this far faster than the 20 SPS
// conversion rate, so a genuine transfer by the other converter or the F-RAM
// clears in a handful of passes; this threshold is well beyond that and only
// a truly wedged controller can reach it.
//
#define ADS1119_BUS_STALL_PASSES  2000U
static uint16_t              adsBusBusyPasses[2] = {0U, 0U};

//
// Times the temperature path had to invoke bus recovery. Distinct from
// BTS_dbgBusRecoveries, which counts the bit-banging itself: this says the
// stall was detected HERE, on the path that had no recovery at all before.
//
volatile uint16_t BTS_dbgAdsBusStalls = 0U;
static uint32_t              adsDwellStart[2] = {0U, 0U};
static uint16_t              adsSampleCh[2] = {0U, 0U};

//
// Bound on how many service calls one transfer phase may occupy before it is
// abandoned. The idle loop calls in continuously, so this is a generous
// ceiling that only trips on genuinely stuck hardware.
//
#define ADS1119_PHASE_MAX_POLLS  2000UL

//
// Poll bound for the one byte handed over inside the WREG frame. A byte
// at 400 kHz is about 22 us, so this is generous while staying far
// below the 55 ms interface timeout of the part.
//
#define ADS1119_WREG_BYTE_TIMEOUT  20000UL

//
// Service calls to dwell on a channel after switching the mux. The idle
// loop calls in continuously, so this is a coarse delay rather than a
// calibrated one - it only has to be long enough that the reading
// belongs to the new channel.
//
//
// Settling time after a mux change, in SYSCLK counts.
//
// This has to outlast one full conversion so the result that follows was
// started on the new input. At 20 SPS a conversion is 50 ms, so allow 60.
// Counting service calls instead of time does not work: a call is a few
// instructions at 160 MHz, so the loop races the converter and publishes
// whatever was already in the output register.
//
#define ADS1119_SETTLE_US        (60000UL)
#define ADS1119_SETTLE_COUNTS    ((uint32_t)(ADS1119_SETTLE_US) * (uint32_t)(DEVICE_SYSCLK_FREQ / 1000000U))

#pragma CODE_SECTION(ads1119Drdy1ISR, "isrcodefuncs")
#pragma INTERRUPT(ads1119Drdy1ISR, HPI)
__interrupt void ads1119Drdy1ISR(void)
{
    //
    // Record the edge and leave. All bus activity happens in the background
    // service routine.
    //
    adsPending[0] = 1U;
    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP1);
}

#pragma CODE_SECTION(ads1119Drdy2ISR, "isrcodefuncs")
#pragma INTERRUPT(ads1119Drdy2ISR, HPI)
__interrupt void ads1119Drdy2ISR(void)
{
    adsPending[1] = 1U;
    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP1);
}

//
// Abandons the transfer in progress on one converter and counts the failure.
//
static void ads1119Abort(uint16_t unit)
{
    uint32_t guard = 0;

    //
    // Get the bus back, not just the state machine.
    //
    // An abort happens mid-frame, so the module is part way through
    // clocking a byte and is holding SCL low. Requesting a stop and
    // walking away leaves it that way: SCL never returns high, every
    // later transfer finds the bus busy, and both converters go quiet
    // with nothing in the status register to say why. Reset the module
    // through nIRS if the stop does not complete promptly.
    //
    I2C_sendStopCondition(I2CB_BASE);

    while (I2C_isBusBusy(I2CB_BASE)) {
        if (++guard > ADS1119_PHASE_MAX_POLLS) {
            I2C_disableModule(I2CB_BASE);
            SysCtl_delay(100U);
            I2C_enableModule(I2CB_BASE);
            break;
        }
    }

    I2C_clearStatus(I2CB_BASE,
                    I2C_STS_NO_ACK | I2C_STS_ARB_LOST |
                    I2C_STS_REG_ACCESS_RDY | I2C_STS_STOP_CONDITION);

    adsState[unit]   = eAdsIdle;
    adsRxCount[unit] = 0U;
    adsGuard[unit]   = 0U;

    if (adsFailCount[unit] < ADS1119_MAX_CONSECUTIVE_FAILURES) {
        adsFailCount[unit]++;
        if (adsFailCount[unit] >= ADS1119_MAX_CONSECUTIVE_FAILURES) {
            //
            // Persistently unreachable: stop taking its interrupts so a dead
            // converter cannot keep occupying the bus.
            //
            GPIO_disableInterrupt((unit == 0U) ? GPIO_INT_XINT1
                                               : GPIO_INT_XINT2);
        }
    }
}

//
// Advances one converter by a single step. Returns immediately whenever the
// hardware is not ready yet, so no call blocks.
//
static void ads1119Service(uint16_t unit)
{
    uint16_t devAddr = (unit == 0U) ? ADS1119_ADDR_1 : ADS1119_ADDR_2;
    uint16_t status  = I2C_getStatus(I2CB_BASE);

    switch (adsState[unit]) {

    case eAdsIdle:
        //
        // Only start once DRDY has fired and the bus is genuinely free - the
        // other converter, the F-RAM, or a calibration save may be using it.
        //
        if (adsPending[unit] == 0U) {
            return;
        }

        if (I2C_isBusBusy(I2CB_BASE)) {
            //
            // Busy is normal for a few passes while another transfer on this
            // bus finishes. Permanently busy is not, and it used to be
            // invisible here: this branch simply returned, so a wedged
            // controller parked the state machine in eAdsIdle forever and
            // every channel reported 0.00 degrees C while both converters
            // still answered 'ok' at boot.
            //
            // i2cMasterWaitBusFree() is the only function that can recover
            // the bus, but it spins, and this runs in the main loop next to
            // the host interfaces. So count the busy passes instead and call
            // it once the bus has been stuck far longer than any legitimate
            // transfer could take - the recovery itself is bounded.
            //
            if (++adsBusBusyPasses[unit] > ADS1119_BUS_STALL_PASSES) {
                adsBusBusyPasses[unit] = 0U;
                BTS_dbgAdsBusStalls++;
                (void)i2cMasterWaitBusFree();
            }
            return;
        }

        adsBusBusyPasses[unit] = 0U;

        adsPending[unit] = 0U;
        adsRxCount[unit] = 0U;
        adsGuard[unit]   = 0U;

        //
        // Phase 1 of RDATA: the command byte, no stop, repeated start to
        // follow. Committed as a single write to I2CMDR for the reason given
        // in ads1119Write().
        //
        I2C_setTargetAddress(I2CB_BASE, devAddr);
        HWREGH(I2CB_BASE + I2C_O_CNT) = 1U;
        I2C_putData(I2CB_BASE, ADS1119_CMD_RDATA);
        HWREGH(I2CB_BASE + I2C_O_MDR) = I2C_MDR_FREE | I2C_MDR_STT |
                                        I2C_MDR_MST  | I2C_MDR_TRX |
                                        I2C_MDR_IRS;
        adsState[unit] = eAdsReadCmd;
        return;

    case eAdsReadCmd:
        if (status & I2C_STS_NO_ACK) {
            I2C_clearStatus(I2CB_BASE, I2C_STS_NO_ACK);
            ads1119Abort(unit);
            return;
        }
        if ((status & I2C_STS_REG_ACCESS_RDY) == 0U) {
            if (++adsGuard[unit] > ADS1119_PHASE_MAX_POLLS) {
                ads1119Abort(unit);
            }
            return;
        }

        //
        // Phase 2: repeated start into a read, with the stop pre-armed so the
        // module releases the bus itself after the second byte.
        //
        adsGuard[unit] = 0U;
        HWREGH(I2CB_BASE + I2C_O_CNT) = 2U;
        HWREGH(I2CB_BASE + I2C_O_MDR) = I2C_MDR_FREE | I2C_MDR_STT |
                                        I2C_MDR_STP  | I2C_MDR_MST |
                                        I2C_MDR_IRS;
        adsState[unit] = eAdsReadData;
        return;

    case eAdsReadData:
        if (status & I2C_STS_NO_ACK) {
            I2C_clearStatus(I2CB_BASE, I2C_STS_NO_ACK);
            ads1119Abort(unit);
            return;
        }
        if ((status & I2C_STS_RX_DATA_RDY) == 0U) {
            if (++adsGuard[unit] > ADS1119_PHASE_MAX_POLLS) {
                ads1119Abort(unit);
            }
            return;
        }

        adsGuard[unit] = 0U;
        adsRxBytes[unit][adsRxCount[unit]] = I2C_getData(I2CB_BASE) & 0xFFU;
        adsRxCount[unit]++;

        if (adsRxCount[unit] < 2U) {
            return;             // second byte still to come
        }

        //
        // Both bytes in. Convert and publish, then point the mux at the next
        // thermistor - the configuration write restarts conversion by itself.
        //
        {
            uint16_t channel = adsSampleCh[unit];
            int16_t  raw = (int16_t)(((adsRxBytes[unit][0] & 0xFFU) << 8) |
                                      (adsRxBytes[unit][1] & 0xFFU));
            float    mV  = ((float)raw * ADS1119_VREF_MV) / ADS1119_FULL_SCALE;

            adsFailCount[unit] = 0U;

            //
            // The first result after a mux change belongs to the old
            // input: the conversion was already in flight when the
            // configuration was written, and at 20 SPS that is a whole
            // 50 ms of stale charge on the new channel. Publishing it
            // smears one thermistor onto its neighbour - a hot sensor
            // shows up on the channel next to it, then vanishes.
            //
            //
            // No discard is needed here. The channel is latched when the
            // read starts, and the dwell after each mux change already
            // drops any conversion left over from the previous input, so
            // whatever arrives now genuinely belongs to this channel.
            //
            publishCellTemp(ADS1119_SLOT_FOR_AIN(channel) +
                                (unit * ADS1119_CHANNELS_PER_DEV),
                            mVToTemperature(mV), true);
        }

        //
        // A real sample was published for this channel, so move on.
        //
        // currentAdsChannel now names the input the mux is about to be
        // pointed at, and adsSampleCh keeps naming the one currently
        // selected - which is what the next conversion will return.
        //
        currentAdsChannel[unit] =
            (currentAdsChannel[unit] + 1U) % ADS1119_CHANNELS_PER_DEV;
        adsState[unit] = eAdsSetMux;
        return;

    case eAdsSetMux:
        //
        // The read armed its own stop, so wait for the bus to clear before
        // starting the configuration frame.
        //
        if (I2C_isBusBusy(I2CB_BASE)) {
            if (++adsGuard[unit] > ADS1119_PHASE_MAX_POLLS) {
                ads1119Abort(unit);
            }
            return;
        }

        adsGuard[unit] = 0U;

        //
        // WREG is command byte plus data byte, and both have to go out inside
        // one frame without a gap.
        //
        // The part resets its own I2C interface if a host starts a command
        // and then stalls for 14000 tMOD - about 55 ms at the 256 kHz
        // modulator. It also NACKs the trailing byte when that happens. So
        // the two bytes are pushed back to back here, with only the short
        // wait for I2CDXR to drain in between, rather than being split
        // across service calls where an interrupt could open a gap.
        //
        // The wait is for one byte at 400 kHz, roughly 22 us. That is long
        // by ISR standards but trivial next to the 50 ms budget, and it is
        // the only way to keep the frame contiguous without a transmit FIFO.
        //
        {
            uint16_t cfg = ADS1119_CFG_FOR_CH(currentAdsChannel[unit]);
            uint32_t guard = 0;

            I2C_setTargetAddress(I2CB_BASE, devAddr);
            HWREGH(I2CB_BASE + I2C_O_CNT) = 2U;
            I2C_putData(I2CB_BASE, ADS1119_CMD_WREG);
            HWREGH(I2CB_BASE + I2C_O_MDR) = I2C_MDR_FREE | I2C_MDR_STT |
                                            I2C_MDR_STP  | I2C_MDR_MST |
                                            I2C_MDR_TRX  | I2C_MDR_IRS;

            while ((I2C_getStatus(I2CB_BASE) & I2C_STS_TX_DATA_RDY) == 0U) {
                if (++guard > ADS1119_WREG_BYTE_TIMEOUT) {
                    ads1119Abort(unit);
                    return;
                }
                if (I2C_getStatus(I2CB_BASE) & I2C_STS_NO_ACK) {
                    I2C_clearStatus(I2CB_BASE, I2C_STS_NO_ACK);
                    ads1119Abort(unit);
                    return;
                }
            }

            I2C_putData(I2CB_BASE, cfg & 0xFFU);
        }

        //
        // Let the WREG frame finish before anything else touches the bus.
        //
        // The stop was armed with the frame, so the module emits it once
        // the byte count reaches zero. Moving straight on would start the
        // next frame on top of this one: the START/SYNC that follows
        // truncates the configuration write, the MUX field never takes
        // effect, and every channel keeps sampling AIN0 while the code
        // believes it is cycling.
        //
        adsState[unit] = eAdsMuxDone;
        return;

    case eAdsMuxDone:
        if (I2C_isBusBusy(I2CB_BASE)) {
            if (++adsGuard[unit] > ADS1119_PHASE_MAX_POLLS) {
                ads1119Abort(unit);
            }
            return;
        }

        if (status & I2C_STS_NO_ACK) {
            I2C_clearStatus(I2CB_BASE, I2C_STS_NO_ACK);
            ads1119Abort(unit);
            return;
        }

        adsGuard[unit] = 0U;

        adsState[unit] = eAdsStart;
        return;

    case eAdsStart:
        //
        // Re-arm conversions after the mux change.
        //
        // Writing the configuration register restarts an ongoing
        // conversion by itself, so in steady state this is redundant.
        // It matters on the edges: if the part has fallen back to its
        // reset defaults - single-shot mode - nothing else would ever
        // start it converting again, and the channel would read zero
        // forever with no error anywhere to show why.
        //
        if (I2C_isBusBusy(I2CB_BASE)) {
            if (++adsGuard[unit] > ADS1119_PHASE_MAX_POLLS) {
                ads1119Abort(unit);
            }
            return;
        }

        adsGuard[unit] = 0U;

        I2C_setTargetAddress(I2CB_BASE, devAddr);
        HWREGH(I2CB_BASE + I2C_O_CNT) = 1U;
        I2C_putData(I2CB_BASE, ADS1119_CMD_START);
        HWREGH(I2CB_BASE + I2C_O_MDR) = I2C_MDR_FREE | I2C_MDR_STT |
                                        I2C_MDR_STP  | I2C_MDR_MST |
                                        I2C_MDR_TRX  | I2C_MDR_IRS;

        //
        // Like the WREG above, this frame has to be allowed to finish.
        // The dwell that follows is counted in service calls, not bus
        // time, so without waiting here the next read would start on top
        // of this one.
        //
        adsState[unit] = eAdsStartDone;
        return;

    case eAdsStartDone:
        if (I2C_isBusBusy(I2CB_BASE)) {
            if (++adsGuard[unit] > ADS1119_PHASE_MAX_POLLS) {
                ads1119Abort(unit);
            }
            return;
        }

        if (status & I2C_STS_NO_ACK) {
            I2C_clearStatus(I2CB_BASE, I2C_STS_NO_ACK);
            ads1119Abort(unit);
            return;
        }

        adsGuard[unit] = 0U;

        //
        // Hold this channel for a while before moving on. The conversion
        // itself settles in one 20 SPS period, but the analogue front end
        // is slower than the converter and cell temperature does not move
        // quickly - dwelling here gives the reading time to be real rather
        // than a smear of the previous channel.
        //
        adsDwellStart[unit] = CPUTimer_getTimerCount(CPUTIMER0_BASE);
        adsState[unit]  = eAdsSettle;
        return;

    case eAdsSettle:
        //
        // Wait out the dwell, then require a completely fresh conversion.
        //
        // The dwell alone is not enough: DRDY keeps asserting throughout it,
        // so whatever is pending the moment it expires may still be the
        // conversion that was already in flight when the mux moved. Clearing
        // the pending flag at the end and waiting for the next edge
        // guarantees the sample that gets published started after the new
        // channel was selected.
        //
        // START/SYNC restarted the converter, so the first result arrives one
        // conversion period later - 50 ms at 20 SPS.
        //
        {
            //
            // CPU timer 0 counts down, so elapsed time is start - now,
            // and the subtraction wraps correctly on reload.
            //
            uint32_t now     = CPUTimer_getTimerCount(CPUTIMER0_BASE);
            uint32_t elapsed = adsDwellStart[unit] - now;

            if (elapsed < ADS1119_SETTLE_COUNTS) {
                adsPending[unit] = 0U;  // ignore results from the old input
                return;
            }
        }

        //
        // Settled. The mux now points at currentAdsChannel, so that is
        // the input the next conversion measures - record it as the
        // channel this result will be credited to.
        //
        adsSampleCh[unit] = currentAdsChannel[unit];
        adsState[unit]    = eAdsIdle;
        return;

    default:
        adsState[unit] = eAdsIdle;
        return;
    }
}

//
// Drives both converters. Called from the idle loop; performs at most one
// step per converter per call and never waits on the bus.
//
void BTS_serviceADS1119(void)
{
    ads1119Service(0U);
    ads1119Service(1U);
}

//
// Runtime calibration save handshake. CPU1 computes and validates the
// two-point result, then bumps calSaveSeq; this side notices the change and
// defers the F-RAM write to the idle loop, exactly as the eCalibrationMode
// commit does. Nothing here may touch the F-RAM - mirrorCpu1Status() runs
// inside timerISR.
//
static volatile uint16_t calRuntimeSavePending = 0U;
static volatile uint16_t calRuntimeSaveSlot    = 0U;
static volatile uint32_t calRuntimeSaveFlags   = 0U;
static uint32_t calRuntimeSaveSeqSeen = 0U;

//
// Pending per-slot state writes, one flag per slot rather than a bitmask:
// the flags are set from interrupts and cleared from the idle loop, and
// distinct array elements cannot lose each other's updates the way a
// read-modify-write on a shared word can.
//
static volatile uint16_t stateSavePending[NUM_CHANNELS];

static void stateSaveRequestAll(void)
{
    uint16_t ch;
    for (ch = 0; ch < NUM_CHANNELS; ch++) {
        stateSavePending[ch] = 1U;
    }
}

//
// Cleared until loadSlotStates() has run and CPU1 has acted on the restore.
// Without it the first mirror pass sees every slot's status change from the
// power-up contents of the message RAM, and writes that over eight valid
// records before the restore has been applied.
//
static volatile uint16_t stateSaveArmed = 0U;

//
// Mirrors the measurements and status CPU1 published in CPU1TOCPU2RAM into
// the register file, so the external interfaces see current data. The seq
// counter is even and unchanged across a consistent snapshot.
//
static void mirrorCpu1Status(void)
{
    uint32_t seqBefore;
    uint32_t statusBits[NUM_CHANNELS];
    float32_t cellV[NUM_CHANNELS];
    float32_t cellI[NUM_CHANNELS];
    float32_t senseV[NUM_CHANNELS];
    float32_t senseI[NUM_CHANNELS];
    float32_t chgMah[NUM_CHANNELS];
    float32_t chgMwh[NUM_CHANNELS];
    float32_t chgSec[NUM_CHANNELS];
    float32_t dchMah[NUM_CHANNELS];
    float32_t dchMwh[NUM_CHANNELS];
    float32_t dchSec[NUM_CHANNELS];
    float32_t calTelemetry[8];
    float32_t calComputed[BTS_CAL_REGS_PER_CH];
    uint32_t calActiveSlot;
    uint32_t calStatus;
    uint32_t calResult;
    uint32_t calSaveSeq;
    uint32_t calSaveSlot;
    uint32_t calSaveFlags;
    float32_t inputV;
    uint32_t unitState;
    uint32_t tripStatus;
    uint32_t strapsValid;
    uint32_t slotMode;
    uint32_t slotEnable;
    uint32_t groupSize;
    uint16_t ch;
    uint16_t i;
    uint16_t attempts = 0;
    uint16_t restoreDone;

    //
    // Until CPU1 has acknowledged the boot restore its accumulators are
    // still zero, and mirroring them would erase the counters loadSlotStates()
    // just put in the register file - which is exactly what CPU1 is about to
    // read them back from. Hold the counter mirror off until the handshake
    // completes; everything else mirrors from the first pass.
    //
    restoreDone = IPC_isFlagBusyLtoR(IPC_CPU2_L_CPU1_R,
                                     BTS_IPC_FLAG_STATE_RESTORE) ? 0U : 1U;

    do {
        seqBefore = cpu1Status.seq;
        if (seqBefore & 1U) {
            continue;   // CPU1 is mid-update
        }
        for (ch = 0; ch < NUM_CHANNELS; ch++) {
            statusBits[ch] = cpu1Status.statusBits[ch];
            cellV[ch] = cpu1Status.cellVoltage[ch];
            cellI[ch] = cpu1Status.cellCurrent[ch];
            senseV[ch] = cpu1Status.senseVoltage[ch];
            senseI[ch] = cpu1Status.senseCurrent[ch];
            chgMah[ch] = cpu1Status.chargeMah[ch];
            chgMwh[ch] = cpu1Status.chargeMwh[ch];
            chgSec[ch] = cpu1Status.chargeSeconds[ch];
            dchMah[ch] = cpu1Status.dischargeMah[ch];
            dchMwh[ch] = cpu1Status.dischargeMwh[ch];
            dchSec[ch] = cpu1Status.dischargeSeconds[ch];
        }
        for (i = 0; i < 8U; i++) {
            calTelemetry[i] = cpu1Status.calTelemetry[i];
        }
        for (i = 0; i < BTS_CAL_REGS_PER_CH; i++) {
            calComputed[i] = cpu1Status.calComputed[i];
        }
        calActiveSlot = cpu1Status.calActiveSlot;
        calStatus     = cpu1Status.calStatus;
        calResult     = cpu1Status.calResult;
        calSaveSeq    = cpu1Status.calSaveSeq;
        calSaveSlot   = cpu1Status.calSaveSlot;
        calSaveFlags  = cpu1Status.calSaveFlags;
        inputV     = cpu1Status.inputVoltage;
        unitState  = cpu1Status.unitState;
        tripStatus = cpu1Status.tripStatus;
        strapsValid = cpu1Status.strapsValid;
        slotMode    = cpu1Status.slotMode;
        slotEnable  = cpu1Status.slotEnable;
        groupSize   = cpu1Status.groupSize;
    } while (cpu1Status.seq != seqBefore && ++attempts < 4U);

    if (attempts >= 4U) {
        return;   // could not get a clean snapshot; try again next tick
    }

    for (ch = 0; ch < NUM_CHANNELS; ch++) {
        uint16_t rtBase = BTS_RT_BASE(ch);

        //
        // A state transition is due a save. Detected from the mirrored status
        // word rather than from a mode write, for two reasons: the bits here
        // are the ones that will be saved, whereas a mode write is seen
        // before CPU1 has acted on it; and a transition CPU1 made on its own
        // - a trip, a termination, a watchdog pause - has no host write to
        // hang off at all.
        //
        {
            static uint32_t lastSavedBits[NUM_CHANNELS];
            uint32_t stateBits = statusBits[ch] &
                ((1UL << BTS_STATUS_RUNNING)  | (1UL << BTS_STATUS_STOPPED) |
                 (1UL << BTS_STATUS_CHARGING) | (1UL << BTS_STATUS_DISCHARGING) |
                 (1UL << BTS_STATUS_PAUSED)   | (1UL << BTS_STATUS_END));

            if (stateBits != lastSavedBits[ch]) {
                lastSavedBits[ch] = stateBits;
                if (stateSaveArmed) {
                    stateSavePending[ch] = 1U;
                }
            }
        }

        registers[rtBase + BTS_RT_STATUS]        = (float32_t)statusBits[ch];
        registers[rtBase + BTS_RT_CELL_VOLTAGE]  = cellV[ch];
        registers[rtBase + BTS_RT_CELL_CURRENT]  = cellI[ch];
        registers[rtBase + BTS_RT_SENSE_VOLTAGE] = senseV[ch];
        registers[rtBase + BTS_RT_SENSE_CURRENT] = senseI[ch];
        if (restoreDone) {
            registers[rtBase + BTS_RT_CHARGE_MAH]    = chgMah[ch];
            registers[rtBase + BTS_RT_CHARGE_MWH]    = chgMwh[ch];
            registers[rtBase + BTS_RT_CHARGE_SECONDS] = chgSec[ch];
            registers[rtBase + BTS_RT_DISCHARGE_MAH] = dchMah[ch];
            registers[rtBase + BTS_RT_DISCHARGE_MWH] = dchMwh[ch];
            registers[rtBase + BTS_RT_DISCHARGE_SECONDS] = dchSec[ch];
        }
        //
        // BTS_RT_CELL_TEMP is deliberately not touched: the ADS1119
        // converters are on this core's I2CB, so the temperature register is
        // written directly by publishCellTemp() and has no CPU1 source to
        // mirror from.
        //
    }

    registers[BTS_REG_IDX(eInputVoltage)] = inputV;
    registers[BTS_REG_IDX(eUnitState)]    = (float32_t)unitState;
    registers[BTS_REG_IDX(eTripStatus)]   = (float32_t)tripStatus;

    //
    // Calibration window. Bit 7 (written to F-RAM) is owned by this side, so
    // it is OR-ed back over whatever CPU1 published rather than overwritten.
    //
    registers[BTS_REG_IDX(eCalSlot)]   = (float32_t)calActiveSlot;
    registers[BTS_REG_IDX(eCalStatus)] = (float32_t)(calStatus |
        ((uint32_t)registers[BTS_REG_IDX(eCalStatus)] & (1UL << BTS_CAL_ST_SAVED)));
    registers[BTS_REG_IDX(eCalResult)] = (float32_t)calResult;

    for (i = 0; i < 8U; i++) {
        registers[BTS_REG_IDX(eCalAdsV_pu) + i] = calTelemetry[i];
    }
    //
    // The cell temperature is this side's: the ADS1119 converters are on
    // CPU2's I2CB, so CPU1 has no reading to publish.
    //
    registers[BTS_REG_IDX(eCalTemp_C)] = (calActiveSlot < NUM_CHANNELS)
                                       ? registers[BTS_CELLTEMP_IDX((uint16_t)calActiveSlot)]
                                       : 0.0f;

    //
    // A new computed result. Stage it into the register file here - that is
    // CPU2-owned memory and cheap - but leave the F-RAM write to the idle
    // loop.
    //
    if ((calSaveSeq != calRuntimeSaveSeqSeen) && (calSaveSlot < NUM_CHANNELS)) {
        uint16_t calBase = BTS_CAL_BASE((uint16_t)calSaveSlot);

        calRuntimeSaveSeqSeen = calSaveSeq;
        for (i = 0; i < BTS_CAL_REGS_PER_CH; i++) {
            registers[calBase + i] = calComputed[i];
        }
        calRuntimeSaveSlot    = (uint16_t)calSaveSlot;
        calRuntimeSaveFlags   = calSaveFlags;
        calRuntimeSavePending = 1U;
    }

    //
    // Dip-switch straps. Only published once CPU1 says it has latched
    // them - the two cores boot independently, and this message RAM is
    // NOLOAD from CPU2's side, so before that the values are whatever the
    // RAM powered up holding.
    //
    if (strapsValid != 0U) {
        registers[BTS_REG_IDX(eSlotMode)]   = (float32_t)slotMode;
        registers[BTS_REG_IDX(eSlotEnable)] = (float32_t)slotEnable;
        registers[BTS_REG_IDX(eGroupSize)]  = (float32_t)groupSize;
    }
}

static volatile uint16_t canTxChannel = 0;

//
//=============================================================================
// Host watchdog and state-save scheduling
//=============================================================================
//
// CPU Timer 1 runs at 8 Hz (DEVICE_SYSCLK_FREQ / 8 period), which is the
// timebase for both. Derived rather than written out so a change to the timer
// period carries into the seconds arithmetic.
//
#define BTS_TIMER_TICKS_PER_S  8U
#define BTS_STATE_SAVE_PERIOD_S 6U

//
// The eight slots are staggered one per tick across the 6 s window rather
// than written in one pass, so a save never holds the I2C controller - and
// therefore the host bus - for eight transfers at once.
//
#define BTS_STATE_SAVE_TICKS   (BTS_STATE_SAVE_PERIOD_S * BTS_TIMER_TICKS_PER_S)

//
// Heartbeat LED half-periods, in 8 Hz ticks. The LED toggles every N ticks,
// so a "5 second flash" is a 5 s period: 2.5 s on, 2.5 s off.
//
#define BTS_HEARTBEAT_IDLE_TICKS ((BTS_TIMER_TICKS_PER_S * 5U) / 2U)  // 5 s period
#define BTS_HEARTBEAT_RUN_TICKS  ((BTS_TIMER_TICKS_PER_S * 1U) / 2U)  // 1 s period

static volatile uint16_t hostWdTicks = 0U;
static volatile uint16_t hostWdRemaining_s = 0U;
static volatile uint16_t hostWdExpired = 0U;

//
// Reloads the host watchdog. Called from exactly one place per interface:
// applyHostRegisterWrite() covers the I2C, UART and CAN write paths, and
// i2cSlaveFifoISR()'s transmit path covers an I2C read.
//
// A polling host proves it is alive by reading, so a read must reload too -
// the ESP32's steady state is reads only, and without this the watchdog
// would pause every slot 30 s after the last mode command while the link was
// perfectly healthy.
//
static void hostWatchdogFeed(void)
{
    uint16_t timeout = (uint16_t)registers[BTS_REG_IDX(eHostWatchdog_s)];

    //
    // Remaining before expired: the 8 Hz tick can land between these two
    // writes, and in that order it sees the stale expired flag and returns
    // rather than counting down from a half-reloaded zero.
    //
    hostWdTicks       = 0U;
    hostWdRemaining_s = timeout;
    hostWdExpired     = 0U;
}

//
// One 8 Hz tick of the countdown. Never touches slot control state - it only
// bumps supervision.wdPauseSeq, and CPU1 performs the pause.
//
static void hostWatchdogTick(void)
{
    uint16_t timeout = (uint16_t)registers[BTS_REG_IDX(eHostWatchdog_s)];

    if (timeout == 0U) {
        //
        // Disabled. Zero remaining, so a host reading the countdown beside
        // the timeout can tell "disabled" from "fired".
        //
        hostWdTicks       = 0U;
        hostWdRemaining_s = 0U;
        registers[BTS_REG_IDX(eWatchdogRemaining_s)] = 0.0f;
        return;
    }

    if (hostWdExpired) {
        registers[BTS_REG_IDX(eWatchdogRemaining_s)] = 0.0f;
        return;
    }

    if (++hostWdTicks < BTS_TIMER_TICKS_PER_S) {
        return;
    }
    hostWdTicks = 0U;

    if (hostWdRemaining_s > timeout) {
        hostWdRemaining_s = timeout;   // the host shortened the timeout
    }

    if (hostWdRemaining_s > 0U) {
        hostWdRemaining_s--;
    }
    registers[BTS_REG_IDX(eWatchdogRemaining_s)] = (float32_t)hostWdRemaining_s;

    if (hostWdRemaining_s == 0U) {
        hostWdExpired = 1U;
        supervision.wdPauseSeq++;
        //
        // A pause is a state transition, so every slot's record is due.
        //
        stateSaveRequestAll();
    }
}

//
// Heartbeat LED on GPIO47, one tick of the 8 Hz timer.
//
//   watchdog tripped  solid ON   - the host stopped talking and every slot
//                                  was paused; this is the state an operator
//                                  needs to spot across a room
//   any slot running  1 s period - something is drawing or delivering current
//   idle             5 s period - alive, host link healthy, nothing running
//
// Driven from CPU2's timer ISR rather than the background loop so it reports
// the health of the core that owns the host interfaces: if CPU2 stalls the
// LED freezes, which is exactly the failure worth seeing. A frozen LED and a
// solid LED mean different things - solid is deliberate, frozen is a fault -
// so the ON state is never entered except for the watchdog.
//
static void heartbeatTick(void)
{
    static uint16_t tick = 0U;
    uint16_t period;
    uint16_t ch;
    uint16_t running = 0U;

    if (hostWdExpired) {
        //
        // Solid on. Reset the counter so that clearing the watchdog restarts
        // the blink from a full period rather than mid-cycle.
        //
        tick = 0U;
        GPIO_writePin(BTS_RUN_LED_GPIO, 1);
        return;
    }

    for (ch = 0U; ch < NUM_CHANNELS; ch++) {
        uint32_t status = (uint32_t)registers[BTS_RT_BASE(ch) + BTS_RT_STATUS];
        //
        // Running means actually converting: a paused slot holds its
        // direction bits, so testing those alone would blink for a slot
        // that is stopped.
        //
        if ((status & (1UL << BTS_STATUS_RUNNING)) != 0UL) {
            running = 1U;
            break;
        }
    }

    period = running ? BTS_HEARTBEAT_RUN_TICKS : BTS_HEARTBEAT_IDLE_TICKS;

    if (++tick >= period) {
        tick = 0U;
        GPIO_togglePin(BTS_RUN_LED_GPIO);
    }
}

#pragma CODE_SECTION(timerISR, "isrcodefuncs")
#pragma INTERRUPT(timerISR, HPI)
__interrupt void timerISR(void)
{
    static uint16_t stateSaveTick = 0U;

    mirrorCpu1Status();
    hostWatchdogTick();
    heartbeatTick();

    //
    // One slot marked per tick: eight slots spread across the 6 s window.
    // Armed only once CPU1 has acknowledged the boot restore, so a periodic
    // save cannot overwrite a record before it has been applied.
    //
    if (!stateSaveArmed) {
        if (!IPC_isFlagBusyLtoR(IPC_CPU2_L_CPU1_R, BTS_IPC_FLAG_STATE_RESTORE)) {
            stateSaveArmed = 1U;
        }
    } else {
        if (++stateSaveTick >= BTS_STATE_SAVE_TICKS) {
            stateSaveTick = 0U;
        }
        if (stateSaveTick < NUM_CHANNELS) {
            stateSavePending[stateSaveTick] = 1U;
        }
    }

    sendCANData(canTxChannel);
    canTxChannel = (canTxChannel + 1) % NUM_CHANNELS;
    CPUTimer_clearOverflowFlag(CPUTIMER1_BASE);
    //
    // CPU Timer 1 is connected directly to CPU INT13, not through the PIE,
    // so there is no acknowledge group to clear.
    //
}

//
// Target-side command parser state.
//
// A host command is two address bytes followed by either data (a write) or a
// repeated start and a read. Tracking that as an explicit phase rather than a
// byte counter keeps the receive and transmit sides from sharing a counter -
// they previously did, and the read path then skipped its own first step and
// served whatever the buffer still held.
//
typedef enum {
    eI2cAddrHi = 0,     // waiting for the high address byte
    eI2cAddrLo,         // waiting for the low address byte
    eI2cData,           // address complete; any further bytes are payload
} BTS_i2cRxPhase;

static volatile BTS_i2cRxPhase rxPhase   = eI2cAddrHi;
static volatile uint16_t       rxDataIdx = 0;

volatile uint16_t currentRegAddr = 0;
volatile uint32_t dbgSlaveIsr = 0;
volatile uint32_t dbgSlaveAddr = 0;
volatile uint32_t dbgSlaveRx = 0;
volatile uint32_t dbgSlaveTx = 0;
volatile uint32_t dbgSlaveErr = 0;
volatile uint32_t dbgSlaveStuck = 0;
volatile uint16_t dbgRxSeq[8] = {0,0,0,0,0,0,0,0};
volatile uint16_t dbgRxIdx = 0;
volatile uint16_t dbgBcAtRx[8] = {0,0,0,0,0,0,0,0};
volatile uint16_t dbgLastReg = 0;
static volatile uint16_t aasPrev = 0;
static volatile uint16_t dirPrev = 0;
//
// Transmit-side byte counter, separate from byteCount which tracks the
// receive phase. A register read uses both: two bytes in, four out.
//
static volatile uint16_t txCount = 0;
volatile float tempData = 0.0f;
volatile uint16_t isWrite = 0;
static uint16_t readBuffer[4] = {0};
static volatile uint16_t bufferValid = 0;

//
// Applies a host register write from any interface (I2C, UART or CAN).
// Writes the register file, notifies CPU1, and handles the eCalibrationMode
// commit trigger.
//
//
// Set when a host asks for a calibration commit. The save writes the
// whole image to the F-RAM, far too long to run inside the I2C slave
// interrupt where the request arrives - doing so held off the host
// mid-transaction. Recorded here, carried out from the idle loop.
//
static volatile uint16_t calibrationSavePending = 0U;

static void applyHostRegisterWrite(uint16_t regIdx, float32_t value)
{
    registers[regIdx] = value;
    notifyCpu1RegisterWrite(regIdx, value);

    //
    // The reload hook for all three write paths: I2C target, UART AT and CAN
    // all funnel through here. The I2C read path has its own hook in
    // i2cSlaveFifoISR().
    //
    hostWatchdogFeed();

    if (regIdx == BTS_REG_IDX(eCalibrationMode) && value == 2.0f) {
        calibrationSavePending = 1U;
    }

    //
    // A slot limit changed: mark that slot for an immediate save rather than
    // waiting out the 6 s periodic sweep, so a power cut seconds after an
    // operator sets a charge current cannot lose it. The write itself still
    // happens from the idle loop - F-RAM is never written from an ISR, and
    // this runs inside one.
    //
    if ((regIdx >= BTS_SET_BASE(0)) &&
        (regIdx < (BTS_SET_BASE(0) + (NUM_CHANNELS * BTS_SET_REGS_PER_CH)))) {
        uint16_t setOffset = (uint16_t)(regIdx - BTS_SET_BASE(0));
        uint16_t field     = setOffset % BTS_SET_REGS_PER_CH;

        if ((field == BTS_SET_V_MIN) || (field == BTS_SET_V_MAX) ||
            (field == BTS_SET_I_MIN) || (field == BTS_SET_I_MAX)) {
            stateSavePending[setOffset / BTS_SET_REGS_PER_CH] = 1U;
        }
    }

    //
    // A calibration command is consumed on write. Self-clearing here rather
    // than waiting for CPU1 means a host polling eCalCommand sees 0 as soon
    // as the write is accepted; the opcode itself already travelled to CPU1
    // in the IPC payload, so clearing the register cannot lose it.
    //
    if ((regIdx == BTS_REG_IDX(eCalCommand)) && (value != 0.0f)) {
        registers[regIdx] = 0.0f;
        //
        // A fresh command supersedes any previous save indication.
        //
        registers[BTS_REG_IDX(eCalStatus)] =
            (float32_t)((uint32_t)registers[BTS_REG_IDX(eCalStatus)] &
                        ~(1UL << BTS_CAL_ST_SAVED));
    }
}

//
// Runs work that interrupt handlers deferred. Called from the idle
// loop, where a long F-RAM transfer costs nothing.
//
//
// Recovers the host-facing I2C target if it locks up.
//
// A target that is interrupted mid-byte - the host resetting, a cable pulled,
// a transfer abandoned on timeout - can be left holding SCL low with BUS_BUSY
// set and no interrupt pending to service. Nothing on this side clears that:
// the ISR only runs when the module asks it to, and a wedged module never
// asks. The bus then stays jammed for every device on it, and the host reports
// the unit as absent.
//
// Watch for BUS_BUSY that persists with no address match, and reinitialise
// the module through its reset bit when it does.
//
static void serviceI2CTargetWatchdog(void)
{
    static uint32_t busyPasses;
    static uint32_t lastAddrCount;

    //
    // Any address activity means the target is alive and talking; the bus
    // being busy is then just a transfer in progress.
    //
    if (dbgSlaveAddr != lastAddrCount) {
        lastAddrCount = dbgSlaveAddr;
        busyPasses = 0U;
        return;
    }

    if ((I2C_getStatus(I2CA_BASE) & I2C_STS_BUS_BUSY) == 0U) {
        busyPasses = 0U;
        return;
    }

    if (++busyPasses < BTS_I2C_TARGET_STUCK_PASSES) {
        return;
    }

    //
    // Busy for a long time with nothing happening: the module is stuck, not
    // working. Reset it and re-arm as a target.
    //
    busyPasses = 0U;
    dbgSlaveStuck++;

    //
    // A full peripheral reset, not just the module reset bit.
    //
    // Clearing IRS releases SCL, but the module comes straight back up
    // still believing it is an addressed target transmitter - TARGET_DIR
    // stays set - and clamps the clock again waiting to send a byte for
    // a transaction that no longer exists. Writing I2CDXR does not clear
    // it either. Only a reset through the system controller drops that
    // latched state.
    //
    I2C_disableModule(I2CA_BASE);
    SysCtl_resetPeripheral(SYSCTL_PERIPH_RES_I2CA);
    SysCtl_delay(100U);

    I2C_initController(I2CA_BASE, DEVICE_SYSCLK_FREQ, 100000, I2C_DUTYCYCLE_50);
    I2C_setConfig(I2CA_BASE, I2C_TARGET_RECEIVE_MODE);
    I2C_setOwnAddress(I2CA_BASE, BTS_I2C_TARGET_ADDRESS);
    I2C_disableLoopback(I2CA_BASE);
    I2C_setBitCount(I2CA_BASE, I2C_BITCOUNT_8);
    I2C_setDataCount(I2CA_BASE, 2);
    I2C_setAddressMode(I2CA_BASE, I2C_ADDR_MODE_7BITS);
    I2C_enableFIFO(I2CA_BASE);

    I2C_clearInterruptStatus(I2CA_BASE,
                             I2C_INT_ADDR_TARGET | I2C_INT_ARB_LOST |
                             I2C_INT_NO_ACK | I2C_INT_STOP_CONDITION |
                             I2C_INT_RXFF | I2C_INT_TXFF);

    I2C_setFIFOInterruptLevel(I2CA_BASE, I2C_FIFO_TXEMPTY, I2C_FIFO_RX1);

    I2C_setFIFOInterruptLevel(I2CA_BASE, I2C_FIFO_TXEMPTY, I2C_FIFO_RX1);

    I2C_enableInterrupt(I2CA_BASE,
                        I2C_INT_ADDR_TARGET | I2C_INT_ARB_LOST |
                        I2C_INT_NO_ACK | I2C_INT_STOP_CONDITION |
                        I2C_INT_RXFF | I2C_INT_TXFF);

    I2C_setEmulationMode(I2CA_BASE, I2C_EMULATION_FREE_RUN);
    I2C_enableModule(I2CA_BASE);

    rxPhase        = eI2cAddrHi;
    rxDataIdx      = 0;
    txCount        = 0;
    aasPrev        = 0;
    bufferValid    = 0;
    currentRegAddr = 0;
    tempData       = 0.0f;
}

void BTS_serviceDeferredWork(void)
{
    serviceI2CTargetWatchdog();

    //
    // Slot runtime state. One slot per pass, so a periodic save never holds
    // the I2C controller for eight transfers at once.
    //
    {
        uint16_t ch;
        for (ch = 0; ch < NUM_CHANNELS; ch++) {
            if (stateSavePending[ch] != 0U) {
                stateSavePending[ch] = 0U;
                BTS_dbgSaveOk = saveSlotState(ch) ? 1U : 0U;
                BTS_dbgSaveCh = ch;
                if (BTS_dbgSaveOk == 0U) { BTS_dbgSaveFails++; }
                break;
            }
        }
    }

    //
    // Runtime calibration commit. F-RAM is never written from an ISR - the
    // request arrives in timerISR and the transfer happens here.
    //
    if (calRuntimeSavePending != 0U) {
        uint16_t slot  = calRuntimeSaveSlot;
        uint32_t flags = calRuntimeSaveFlags;
        uint32_t st;

        calRuntimeSavePending = 0U;

        if (saveCalibrationFlags(slot, flags)) {
            st = (uint32_t)registers[BTS_REG_IDX(eCalStatus)] | (1UL << BTS_CAL_ST_SAVED);
            registers[BTS_REG_IDX(eCalStatus)] = (float32_t)st;
            registers[BTS_REG_IDX(eCalResult)] = (float32_t)eCalErrOk;
            //
            // The register file now holds the new gains; CPU1 reloads its
            // program variables from there.
            //
            notifyCpu1CalibrationReload();
        } else {
            registers[BTS_REG_IDX(eCalResult)] = (float32_t)eCalErrWriteFailed;
            st = (uint32_t)registers[BTS_REG_IDX(eCalStatus)] | (1UL << BTS_CAL_ST_FAILED);
            registers[BTS_REG_IDX(eCalStatus)] = (float32_t)st;
        }
    }

    if (calibrationSavePending == 0U) {
        return;
    }

    //
    // Cleared first so a request arriving during the save queues another
    // pass rather than being lost.
    //
    calibrationSavePending = 0U;
    saveAllCalibration();
}

//
// The register protocol carries each float MSB-first on the wire. A C28x
// "byte" is 16 bits, so a float is two 16-bit words rather than four bytes -
// indexing it as a byte array (as older revisions did) runs off the end of
// the object. These helpers pack and unpack explicitly:
//
//   wire byte 0 -> bits 31..24   word[1] high half
//   wire byte 1 -> bits 23..16   word[1] low half
//   wire byte 2 -> bits 15..8    word[0] high half
//   wire byte 3 -> bits  7..0    word[0] low half
//
static inline void floatPutWireByte(volatile float32_t *f, uint16_t index, uint16_t value)
{
    volatile uint16_t *w = (volatile uint16_t *)f;
    uint16_t word = 1U - (index >> 1);       // bytes 0,1 -> word 1; 2,3 -> word 0
    if ((index & 1U) == 0U) {
        w[word] = (w[word] & 0x00FFU) | ((value & 0xFFU) << 8);   // high half
    } else {
        w[word] = (w[word] & 0xFF00U) | (value & 0xFFU);          // low half
    }
}

static inline uint16_t floatGetWireByte(float32_t f, uint16_t index)
{
    const uint16_t *w = (const uint16_t *)&f;
    uint16_t word = 1U - (index >> 1);
    return ((index & 1U) == 0U) ? ((w[word] >> 8) & 0xFFU) : (w[word] & 0xFFU);
}

#pragma CODE_SECTION(i2cSlaveISR, "isrcodefuncs")
#pragma INTERRUPT(i2cSlaveISR, HPI)
//
// Host register bus, target side.
//
// The transaction shapes the ESP32 uses are:
//
//   write:  S 0x50 W  addrHi addrLo  d0 d1 d2 d3 ...  P
//   read:   S 0x50 W  addrHi addrLo  Sr 0x50 R  d0 d1 d2 d3 ...  P
//
// So a read is addressed twice and the register address has to survive the
// repeated start in between. That single requirement is what most of the
// state handling below is protecting.
//
// Framing lives on PIE 8.1 (address match, stop, errors) and the data bytes
// on 8.2 (the FIFOs). Keeping them apart is not cosmetic: with the FIFO
// enabled the TRM forbids the basic RRDY/XRDY interrupts, and mixing the two
// is what previously let a data byte be parsed as an address byte.
//
static void i2cTargetResetCommand(void)
{
    rxPhase     = eI2cAddrHi;
    txCount     = 0U;
    bufferValid = 0;
    tempData    = 0.0f;
}

#pragma CODE_SECTION(i2cSlaveISR, "isrcodefuncs")
#pragma INTERRUPT(i2cSlaveISR, HPI)
__interrupt void i2cSlaveISR(void)
{
    uint32_t intSource = I2C_getInterruptStatus(I2CA_BASE);

    dbgSlaveIsr++;

    //
    // Reading I2CISRC advances the module's interrupt queue. Without it the
    // current source stays pending, this handler is never re-entered, and the
    // module ends up holding SCL low waiting for software that never comes.
    //
    (void)HWREGH(I2CA_BASE + I2C_O_ISRC);

    //
    // Errors first. A host that abandons a transfer - which it does on every
    // timeout - latches one of these, and left unhandled the target stops
    // servicing the bus entirely.
    //
    if (intSource & (I2C_INT_ARB_LOST | I2C_INT_NO_ACK)) {
        dbgSlaveErr++;
        I2C_clearStatus(I2CA_BASE, I2C_STS_ARB_LOST | I2C_STS_NO_ACK);
        i2cTargetResetCommand();
        currentRegAddr = 0;
    }

    //
    // Address match.
    //
    // AAS is a level, not a latched flag: it stays asserted for as long as
    // this unit is the addressed target, so it has to be edge-detected or
    // every later interrupt in the same transaction looks like a fresh
    // command and resets the parser mid-address.
    //
    {
        uint16_t aasNow = ((intSource & I2C_INT_ADDR_TARGET) != 0U) ? 1U : 0U;
        uint16_t dirNow = ((I2C_getStatus(I2CA_BASE) & I2C_STS_TARGET_DIR) != 0U)
                        ? 1U : 0U;

        //
        // A new phase is either AAS going high, or the direction
        // flipping while it stays high.
        //
        // A register read is addressed twice - write the address, then a
        // repeated start to read - and AAS does not necessarily drop in
        // between. Keying purely off its edge meant the read half was
        // never recognised, so the transmit side was never primed and the
        // host received everything one byte late.
        //
        if (((aasNow != 0U) && (aasPrev == 0U)) ||
            ((aasNow != 0U) && (dirNow != dirPrev))) {
            dbgSlaveAddr++;

            //
            // Only a write starts a new command. The second address match of
            // a register read must leave currentRegAddr alone - that address
            // is the whole point of the write phase that preceded it.
            //
            if ((I2C_getStatus(I2CA_BASE) & I2C_STS_TARGET_DIR) == 0U) {
                isWrite = 1U;
                i2cTargetResetCommand();
            } else {
                //
                // Read phase. The data was staged when the address was
                // received, so there is nothing to do here but note the
                // direction - touching the FIFO now would discard the
                // byte already waiting to go out.
                //
                isWrite = 0U;
            }
            }
        aasPrev = aasNow;
        dirPrev = dirNow;
    }

    //
    // Stop ends the transaction. Handled after the address match so a stop
    // left over from the previous command cannot wipe the address this one
    // has just supplied.
    //
    if (intSource & I2C_INT_STOP_CONDITION) {
        i2cTargetResetCommand();
        aasPrev = 0U;
    }

    I2C_clearInterruptStatus(I2CA_BASE, intSource);
    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP8);
}

//
// FIFO half of the target: the actual data bytes.
//
#pragma CODE_SECTION(i2cSlaveFifoISR, "isrcodefuncs")
#pragma INTERRUPT(i2cSlaveFifoISR, HPI)
__interrupt void i2cSlaveFifoISR(void)
{
    uint32_t intSource = I2C_getInterruptStatus(I2CA_BASE);

    dbgSlaveIsr++;

    //
    // Receive: drain the whole FIFO. More than one byte can arrive between
    // interrupts, and anything left behind stalls the bus.
    //
    if (intSource & I2C_INT_RXFF) {
        while (I2C_getRxFIFOStatus(I2CA_BASE) != I2C_FIFO_RX0) {
            uint16_t rxData = I2C_getData(I2CA_BASE) & 0xFFU;

            dbgSlaveRx++;
            if (dbgRxIdx < 8U) {
                dbgRxSeq[dbgRxIdx++] = rxData;
            }

            switch (rxPhase) {
            case eI2cAddrHi:
                currentRegAddr = (uint16_t)(rxData << 8);
                rxPhase        = eI2cAddrLo;
                break;

            case eI2cAddrLo:
                currentRegAddr |= rxData;
                dbgLastReg      = currentRegAddr;
                rxDataIdx       = 0U;
                rxPhase         = eI2cData;

                //
                // Stage the register now, while the address phase is
                // still in progress.
                //
                // If this turns out to be a read, the module starts
                // clocking data out the moment it acknowledges the
                // repeated start - before any interrupt can be serviced.
                // Whatever I2CDXR holds at that instant is what the host
                // receives first, so it has to be the real first byte
                // already. Waiting until the read phase to load it is
                // what put a stale byte in front of every reply and left
                // the four real bytes one place late.
                //
                {
                    uint16_t  regIdx = currentRegAddr / 4U;
                    float32_t v      = (regIdx < TOTAL_REGISTERS)
                                     ? registers[regIdx] : -1.0f;
                    uint16_t  i;

                    for (i = 0; i < 4U; i++) {
                        readBuffer[i] = floatGetWireByte(v, i);
                    }
                    bufferValid = 1;
                    txCount     = 1U;
                    I2C_putData(I2CA_BASE, readBuffer[0]);
                }
                break;

            case eI2cData:
            default:
                floatPutWireByte(&tempData, rxDataIdx, rxData);
                rxDataIdx++;

                if (rxDataIdx >= 4U) {
                    uint16_t regIdx = currentRegAddr / 4U;

                    if ((regIdx < TOTAL_REGISTERS) &&
                        (regConfig[regIdx].access == REG_ACCESS_RW)) {
                        applyHostRegisterWrite(regIdx, tempData);
                    }

                    tempData  = 0.0f;
                    rxDataIdx = 0U;

                    //
                    // Auto-increment for a multi-register write, bounded at
                    // the end of the map. Unbounded it walks off the end and
                    // stays there, and since the address persists across
                    // transactions every later read returns out of range.
                    //
                    if (((currentRegAddr + 4U) / 4U) < TOTAL_REGISTERS) {
                        currentRegAddr += 4U;
                    }
                }
                break;
            }
        }

        I2C_clearInterruptStatus(I2CA_BASE, I2C_INT_RXFF);
    }

    //
    // Transmit: the host is reading, so serve the register currentRegAddr
    // points at, one wire byte at a time.
    //
    if (intSource & I2C_INT_TXFF) {
        if ((I2C_getStatus(I2CA_BASE) & I2C_STS_TARGET_DIR) != 0U) {
            dbgSlaveTx++;

            //
            // The I2C read reload hook - the fourth and last of them, and the
            // one the design doc calls out separately. A polling host proves
            // it is alive by reading, and the ESP32's steady state is reads
            // only: without this the watchdog would pause every running slot
            // 30 s after the last mode command while the link was healthy.
            //
            // Placed on the transmit side rather than the address phase
            // because that is where a read is unambiguous - the address
            // phase is shared with a write.
            //
            hostWatchdogFeed();

            //
            // Load the register only at the start of a four-byte group.
            //
            // bufferValid is cleared as each register finishes so the
            // next one is fetched, but testing it here as well meant a
            // reload could happen part way through a group - after the
            // address had already auto-incremented - so the four bytes
            // the host received were spliced from two different
            // registers. txCount alone marks the group boundary.
            //
            if (txCount == 0U) {
                uint16_t  regIdx   = currentRegAddr / 4U;
                float32_t regValue = (regIdx < TOTAL_REGISTERS)
                                   ? registers[regIdx] : -1.0f;
                uint16_t  i;

                dbgLastReg = currentRegAddr;

                for (i = 0; i < 4U; i++) {
                    readBuffer[i] = floatGetWireByte(regValue, i);
                }
                bufferValid = 1;
                txCount     = 0U;
            }

            I2C_putData(I2CA_BASE, readBuffer[txCount]);
            txCount++;

            if (txCount >= 4U) {
                //
                // Register delivered. Auto-increment so a host can burst
                // consecutive registers without re-sending an address, and
                // force a reload on the next byte.
                //
                txCount     = 0U;
                bufferValid = 0;

                if (((currentRegAddr + 4U) / 4U) < TOTAL_REGISTERS) {
                    currentRegAddr += 4U;
                }
            }
        }

        I2C_clearInterruptStatus(I2CA_BASE, I2C_INT_TXFF);
    }

    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP8);
}

#pragma CODE_SECTION(canISR, "isrcodefuncs")
#pragma INTERRUPT(canISR, HPI)
__interrupt void canISR(void)
{
    //
    // The INT0ID field of the CAN interrupt register holds the message
    // object number that raised the interrupt, or CAN_INT_INT0ID_STATUS for
    // an error/status event. Object 9 is the host register read/write mailbox.
    //
    uint32_t intCause = CAN_getInterruptCause(CANA_BASE) & 0xFFFFU;

    if (intCause == CAN_INT_INT0ID_STATUS) {
        // Reading the status register clears the condition.
        (void)CAN_getStatus(CANA_BASE);
    } else if (intCause == 9U) {
        uint16_t data[8];
        CAN_MsgFrameType frameType;
        uint32_t rxMsgId = 0;

        if (CAN_readMessageWithID(CANA_BASE, 9, &frameType, &rxMsgId, data)) {
            uint16_t regAddr = ((data[0] & 0xFFU) << 8) | (data[1] & 0xFFU);
            uint16_t regIdx = regAddr / 4;

            if (data[2] == 0x01 && regIdx < TOTAL_REGISTERS &&
                regConfig[regIdx].access == REG_ACCESS_RW) {
                float32_t value;
                uint16_t *w = (uint16_t *)&value;
                w[0] = (data[4] & 0xFFU) | ((data[5] & 0xFFU) << 8);
                w[1] = (data[6] & 0xFFU) | ((data[7] & 0xFFU) << 8);
                applyHostRegisterWrite(regIdx, value);
            } else if (data[2] == 0x00 && regIdx < TOTAL_REGISTERS) {
                float32_t value = registers[regIdx];
                const uint16_t *w = (const uint16_t *)&value;
                uint16_t reply[8];
                reply[0] = data[0];
                reply[1] = data[1];
                reply[2] = 0x00;
                reply[3] = 0x00;
                reply[4] = w[0] & 0xFFU;
                reply[5] = (w[0] >> 8) & 0xFFU;
                reply[6] = w[1] & 0xFFU;
                reply[7] = (w[1] >> 8) & 0xFFU;
                CAN_sendMessage(CANA_BASE, 9, 8, reply);
            }
        }
        CAN_clearInterruptStatus(CANA_BASE, 9);
    }

    CAN_clearGlobalInterruptStatus(CANA_BASE, CAN_GLOBAL_INT_CANINT0);
    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP9);
}

void SFRA_startCalibration(void)
{
    uartSendResponse("SFRA Calibration Started");
}

#if (BTS_CONSOLE_ENABLED == true)
#define UART_BUFFER_SIZE 64
static char uartBuffer[UART_BUFFER_SIZE];
static uint16_t uartBufIdx = 0;
#endif

void uartSendResponse(const char* response)
{
#if (BTS_CONSOLE_ENABLED == true)
    while (*response) {
        SCI_writeCharBlockingFIFO(BTS_CONSOLE_SCI_BASE, (uint16_t)(*response++) & 0xFFU);
    }
    SCI_writeCharBlockingFIFO(BTS_CONSOLE_SCI_BASE, '\r');
    SCI_writeCharBlockingFIFO(BTS_CONSOLE_SCI_BASE, '\n');
#else
    (void)response;
#endif
}

#if (BTS_CONSOLE_ENABLED == true)
//
// Formats "+<name>=<value>" with two decimal places.
//
// printf's %f promotes its argument to double, which this project forbids
// (--float_operations_allowed=32), so the fraction is rendered from a scaled
// 32-bit integer instead.
//
static void formatRegisterValue(char *out, uint16_t outSize,
                                const char *name, float32_t value)
{
    int32_t scaled;
    int32_t whole;
    int32_t frac;
    bool negative = false;

    if (value < 0.0f) {
        negative = true;
        value = -value;
    }

    // Round to two decimal places.
    scaled = (int32_t)(value * 100.0f + 0.5f);
    whole  = scaled / 100;
    frac   = scaled % 100;

    snprintf(out, outSize, "+%s=%s%ld.%02ld",
             name, negative ? "-" : "", (long)whole, (long)frac);
}
#endif

#pragma CODE_SECTION(uartRxISR, "isrcodefuncs")
#pragma INTERRUPT(uartRxISR, HPI)
__interrupt void uartRxISR(void)
{
#if (BTS_CONSOLE_ENABLED == true)
    uint32_t intSource = SCI_getInterruptStatus(BTS_CONSOLE_SCI_BASE);
    //
    // Drain everything the FIFO holds - more than one character can arrive
    // between interrupts.
    //
    while (SCI_getRxFIFOStatus(BTS_CONSOLE_SCI_BASE) != SCI_FIFO_RX0) {
        char rxChar = (char)(SCI_readCharNonBlocking(BTS_CONSOLE_SCI_BASE) & 0xFFU);
        if (rxChar == '\n' || rxChar == '\r') {
            uartBuffer[uartBufIdx] = '\0';
            if (strncmp(uartBuffer, "AT+", 3) == 0) {
                char* cmd = uartBuffer + 3;
                char* valueStr = strchr(cmd, '=');
                char* query = strchr(cmd, '?');
                uint16_t regIdx = TOTAL_REGISTERS;

                if (strncmp(cmd, "SFRA_CAL", 8) == 0 && sfraEnabled) {
                    if (!valueStr && !query) {
                        SFRA_startCalibration();
                        uartSendResponse("OK");
                    } else {
                        uartSendResponse("ERROR: Invalid SFRA command");
                    }
                    uartBufIdx = 0;
                    SCI_clearInterruptStatus(BTS_CONSOLE_SCI_BASE, intSource);
                    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP9);
                    return;
                }

                char regName[32];
                if (valueStr) *valueStr = '\0';
                if (query) *query = '\0';
                strncpy(regName, cmd, sizeof(regName) - 1);
                regName[sizeof(regName) - 1] = '\0';

                //
                // AT+C<n>PAUSE / AT+C<n>RESUME. Reachable by writing the mode
                // register, but an operator at a console should not have to
                // compute a bitmask to stop a cell safely.
                //
                if ((regName[0] == 'C') && (regName[1] >= '0') &&
                    (regName[1] <= '7') && !valueStr && !query) {
                    uint16_t slot = (uint16_t)(regName[1] - '0');
                    uint32_t bit  = 0U;

                    if (strcmp(&regName[2], "PAUSE") == 0) {
                        bit = BTS_MODE_PAUSE;
                    } else if (strcmp(&regName[2], "RESUME") == 0) {
                        bit = BTS_MODE_RESUME;
                    }

                    if (bit != 0U) {
                        applyHostRegisterWrite(BTS_SET_BASE(slot) + BTS_SET_MODE,
                                               (float32_t)bit);
                        uartSendResponse("OK");
                        uartBufIdx = 0;
                        SCI_clearInterruptStatus(BTS_CONSOLE_SCI_BASE, intSource);
                        Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP9);
                        return;
                    }
                }

                for (uint16_t i = 0; i < TOTAL_REGISTERS; i++) {
                    if (strcmp(regName, uartRegConfig[i].shortName) == 0 ||
                        strcmp(regName, uartRegConfig[i].longName) == 0) {
                        regIdx = i;
                        break;
                    }
                }

                if (regIdx == TOTAL_REGISTERS) {
                    uartSendResponse("ERROR: Invalid register");
                } else if (valueStr) {
                    if (uartRegConfig[regIdx].access == REG_ACCESS_RO) {
                        uartSendResponse("ERROR: Read-only register");
                    } else {
                        // strtof, not atof: the project builds with
                        // --float_operations_allowed=32, which rules out the
                        // double-returning atof.
                        float value = strtof(valueStr + 1, 0);
                        applyHostRegisterWrite(regIdx, value);
                        uartSendResponse("OK");
                    }
                } else if (query) {
                    char response[40];
                    formatRegisterValue(response, sizeof(response), regName, registers[regIdx]);
                    uartSendResponse(response);
                    uartSendResponse("OK");
                } else {
                    uartSendResponse("ERROR: Invalid command");
                }
            }
            uartBufIdx = 0;
        } else if (uartBufIdx < UART_BUFFER_SIZE - 1) {
            uartBuffer[uartBufIdx++] = rxChar;
        }
    }
    SCI_clearInterruptStatus(BTS_CONSOLE_SCI_BASE, intSource);
#endif
    Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP9);
}

/*
 * CPU 2 Main Routine
 *
 * Boot order matters: the peripherals that reach the EEPROM come up first,
 * then loadCalibration() populates the register file from EEPROM (or from
 * defaults) and notifies CPU1 to recalculate and run. Interrupts are only
 * enabled once that initial register file is in place, so a host write can
 * never race the boot-time load.
 */
void main(void)
{
    Device_init();
    Device_initGPIO();
    Interrupt_initModule();
    Interrupt_initVectorTable();

    initI2C_Master();

    //
    // Establish the register file before anything can observe or modify it.
    //
    loadCalibration();

    //
    // Slot runtime state, after the calibration load so the whole register
    // file settles before either IPC flag goes up.
    //
    loadSlotStates();

    initI2C_Slave();
    initUART();
    initCAN();
    initTimer();
    LEDDriver_init();

    EINT;
    ERTM;

    //
    // Boot banner - confirms init completed and the console is alive.
    // Printed before any interrupt-driven work so it still appears if a
    // peripheral on the I2C bus is absent or misbehaving.
    //
#if (BTS_CONSOLE_ENABLED == true)
    uartSendResponse("");
    uartSendResponse("BTS F2837xD CPU2 ready");
    {
        char line[48];
        formatRegisterValue(line, sizeof(line), "ChargeDisableV",
                            registers[BTS_REG_IDX(eChargeDisableV)]);
        uartSendResponse(line);
        formatRegisterValue(line, sizeof(line), "Ch0_F28V_Gain",
                            registers[BTS_CAL_BASE(0) + BTS_CAL_F28V_GAIN]);
        uartSendResponse(line);
    }
    uartSendResponse("OK");
#endif

    //
    // Temperature acquisition last: its DRDY ISRs drive the I2CB bus, so the
    // console and the register interfaces are already up before they start.
    // If a converter is absent the bounded I2C helpers simply time out.
    //
    initADS1119();

    while (1) {
        //
        // Background work. Both perform at most one short, non-blocking
        // step per pass, so the console, the I2CA slave and CAN stay
        // responsive while I2CB is driven continuously.
        //
        BTS_serviceADS1119();
        BTS_serviceDeferredWork();
    }
}

#endif
