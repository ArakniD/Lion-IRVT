The ToDo\ folder is for agent instructions for modifications post human review to source code

ToDo instructions will be marked with a changelog and completion status, with reference to checkin once completed, and kept for recording documentation

Ordering within the folder is by numbers  aka 01. is first, followed by future numbers.

On completion, record the ToDo completion at the end of this Agent.mds

### Record of ToDo's completed below

| ToDo | Completed | Commit | Notes |
|---|---|---|---|
| `01.Canbus telemetry.md` | 2026-09-24 | `8cb945d` | Fixed-point 8-byte frame carrying state, V, I, mAh and mWh. Breaking wire change; in-tree host decoder updated with it. Compile-verified only - no hardware this session. |
| `02.ePWM X-BAR CMPSS and ePWM trip enable.md` | 2026-09-24 | `719c028` | Hardware over-current trips enabled at +/-9.5 A via Digital Compare, grouped per the MODE strap, armed on first run. Found and fixed the threshold maths, which made the high-side trip unreachable, and the undivided group current. Compile-verified only - **the trips have never fired on a board.** |
| `03.ADC Prescaled to 100kHz with CLA enabled.md` | 2026-09-30 | `e889543` | On-chip ADC to 99.67 kSPS, 1:1 with ePWM1 (prescale 15 -> 1). ADCA INT1 PIE-masked and put in continuous mode, so the C28x is out of the fast path; CLA1 now runs a 20 Hz telemetry IIR **and** a fast IIR that carries the protection path, replacing the dead 8-sample ring. Widened `BTS_claRunCount` to 32-bit - at the new rate a 16-bit counter wrapped in 657 ms against a **measured** 1.45 s `C1()` period and could have frozen the readings it exists to protect. ADCB EOC flag now cleared on the success path. Compile-verified only - no hardware this session. |
| `04.CPU2 Timer0 double booked for LED and ADS1119.md` | 2026-09-30 | `ac1bb42` | LED refresh moved to CPU Timer 2 on CPU2 - `initADS1119()` was reprogramming Timer 0 with its interrupt disabled AFTER `LEDDriver_init()`, so the WS2812B string was dead in every production build. Switched `BTS_LAB_TYPE` to CCCV, which had been compiled out since the beginning, and added `serviceTermination()`: a charge ends in CV at `I_MIN`, a discharge at `V_MIN`, `V_MIN == 0` disables that check, and the group leader ends its whole group. This is the first code to set the END bit. CCCV grew `isrcodefuncs` past its region and the link failed - RUN moved to RAMGS8_9_10, LOAD to FLASHE. CC/CV plumbed to web/BLE/display, `BLE_PROTO_VERSION` 5 -> 6. Compile-verified on both cores and the ESP32 - **the CV coefficients have never run on hardware.** |
| `06.SFRA Mode Enablement and Slot Control Calibration in FRAM.md` | 2026-09-30 | `6c2c838` | **PART 1 ONLY.** 13 DCL slot-tuning registers at 1068-1116 (TOTAL_REGISTERS 267 -> 280), one set unit-wide, persisted as a CRC-checked F-RAM record at 0x0700 and applied to all eight CC/CV controllers at boot and on host write. Defaults seeded from the compiled BTS_DCL_* before F-RAM can load, and a zero-b0 set is rejected - registers[] starts zeroed and a zeroed biquad outputs constant zero, so no slot would regulate at all. The runtime SFRA switch is NOT done and is filed as ToDo 07, blocked on a mode-table conflict: MODE 0b000 is both eModeIndependent and the pulled-high unstrapped default. Compile-verified on both cores and the ESP32 - no hardware. |
| `07.SFRA runtime mode switch.md` | 2026-09-30 | `b253cf5` | MODE 6/7 repurposed from the unused grouped internal-ADC modes to the two slot-tuning (SFRA) modes - 6 sweeps the internal-ADC loop, 7 the ADS131M08 loop. Mode 0 deliberately NOT taken: the straps are pulled high so an unstrapped board decodes to 0, and SFRA there would sweep every unstrapped unit at power-on. Both mode macros stopped being pure bit arithmetic - group size forced to 1 (bit pattern said 4 and 8) and the converter test made explicit (bit 2 is set for both, but mode 7 sweeps the ADS131M08). SFRA now RUNS on a strap-latched runtime flag while the library stays a build switch, so one tuning binary serves every slot and a production build carries no test at all. SCIA ownership rides the same strap, since CPUSEL is boot-time only. Verified in BOTH build flavours - the production build compiles none of the new code. |
| `05.Home Assistant register mirror is stale.md` | 2026-09-30 | `5c17bbe` | HA integration mirror brought from v1 to v2.1 + tuning: TOTAL_REGISTERS 315 -> 280, unit base 1152 -> 960, settings stride 96 -> 72, and the 13 tuning registers added. The charge/discharge limit merge was semantic, not just addresses - `ChannelLimits` emitted four duplicate writes where the later silently won, and `number.py` had two HA entities per merged register that would have moved each other's displayed value. `SET_I_MIN` had no entity at all, so a CCCV charge could not terminate from HA. Also caught the BLE record drifting 68 -> 70 B from ToDo 04. Added per-slot and exhaustive unit/tuning header checks - the gap that let the stride change go unnoticed for two revisions. **106 passed, 16 skipped, 0 failed.** |
| `08.CCM-slot-mode-transition.md` | 2026-10-02 | `f6a458e` | Pre-charge balance: a cell is now seated onto a rail already driven to match it. WAITING/BALANCING/READY/SOFT_START added, supervised from B1. The decidability hinges on shunt placement - the output caps sit after the sense resistor, so matched voltages plus zero current is a balanced empty rail and matched plus current flowing is a connected cell. Soft start runs in diode emulation with 40 retries; removing the cell clears a fault. Fixed two authorised pre-existing defects: `BTS_ctrlDirection()` discarded all four of its own duty branches, and `slotStop()` never cleared the direction bits. Build switched to production, enabling the LEDs and ch1's GPIO trip. BLE proto 6 -> 7. Re-measured the C-task rate at 85.9 Hz, correcting a stale memory. Compile-verified on all three targets - **nothing that drives a FET has run on hardware.** |


### Addendum, 2026-10-02 — ToDo 04 item 1 superseded

The WS2812B string moved off the C2000 entirely in `bd48bfd`, and **lit for
the first time**: eight solid green, all slots idle.

ToDo 04's Timer 2 move, and the two later fixes in the same area (the LED ISR
starving CPU2's I2C target; SCIA stranded by an unstrapped MODE strap), were
each correct fixes to real defects — but none of them could ever have
produced light. `LEDDriver_update()` sent raw colour bytes over a UART, and a
WS2812B decodes pulse *widths*; a UART forces a start bit before every byte
and holds each bit for a full bit time. No pixel ever lit from that core.

The C2000 cannot drive one: GPIO29 has no SPI mux option and both usable SPI
ports belong to the ADS131M08 pair. The ESP32 does it on SPI3/GPIO13 at
2.5 MHz, four SPI bits per WS2812B bit, deriving colour from the I2C slot
status it already polls. `BTS_LED_DRIVER_ENABLED` is now `false` in both arms
and **CPU Timer 2 on CPU2 is free again**.

See [`04.CPU2 Timer0 double booked for LED and ADS1119.md`](04.CPU2%20Timer0%20double%20booked%20for%20LED%20and%20ADS1119.md)
for the full note, and `Docs/supervision-and-state-design.md` §2.5.1 for the
current design.

### Addendum, 2026-10-08 - first FET-driving runs on hardware

Earlier entries here say the trips never fired, the CV coefficients never
ran, and "nothing that drives a FET has run on hardware". The first and last
are no longer true for slot 1:

- **Charge**, 1 A into a short: 205 s at 1.00 A, no trip.
- **Discharge**, 1 A and 100 mA from an external supply: steady, no trip on
  enable - previously every discharge enable latched the CMPSS comparator.
- **Discharge termination**: `V_MIN` 0.5 V, supply wound to 0 V, slot ended
  in END (`FINISHED`).
- **Standalone flash boot**: both cores from flash with the debugger
  unplugged (`c490094`).
- **F-RAM**: boot reads now succeed; slot 1's calibration, slot state and the
  global voltage thresholds load at boot.

Still NOT verified on hardware: **charge termination** (the short never
reaches CV), **the CV loop** on a real cell, and **the trip level** against a
real over-current. Commits: `c490094` (C2000), `b373e90` (ESP32).

### Addendum, 2026-10-08 (later) - ESP32 OTA, WiFi setup, HACS

Not ToDo items, recorded here for the same reason:

- **ESP32 firmware update over WiFi** with rollback; a new image confirms
  itself once the BTS link answers, or after 180 s. A setup page at `/` for
  WiFi credentials and updates. Verified on a bare ESP32 (no BTS): two full
  updates, one rolled back by a reset mid-trial. Not yet seen confirming on a
  live BTS link. Commits `69f847a`, `985b82b`.
- **Home Assistant integration moved** to its own repository, ha-lion-irvt,
  checked out as the `lion-lvrt-integration` submodule (`7d8f53e`). Release
  v1.0.0 passes the HACS validator and hassfest on GitHub.
- **I2CB at 100 kHz, not 400** (`c490094`): the board has 10 kOhm pull-ups,
  out of spec for fast mode. 400 kHz caused ~327 F-RAM save failures and a
  bus stall a second; 100 kHz, 0 of each. Recorded in
  `Docs/hardware-resources.md` section 10.

Open, found while documenting:

- ~~`eTripStatus` and status bit 3 never clear~~ - fixed 2026-10-09: they
  clear on a fresh start, a WAITING re-arm, or cell removal; not on a stop.
- ~~Channel 6's GPIO trip loses `INPUT14`~~ - moot 2026-10-09: the GPIO
  trips have their own switches, all false (not fitted on this board).
  Channel 6's trip input is being debugged at the bench - see
  `Docs/hardware-resources.md` section 4.
- ~~Slots 2, 3, 5, 7 and 8 were tripped by another slot's comparator~~ -
  fixed 2026-10-09: each slot is bound to the comparator on its own current
  pin (`BTS_TRP_CMPSS_CH1..8`: CMPSS 1, 3, 2, 4, 7, 6, 8, 5). ToDo 02 had
  specified the groups as CMPSSn for slot n, which the device's fixed
  comparator pins and this board's routing do not allow. Read back on the
  board: slot 2's trip now carries CMPSS3. Not yet seen to fire on a real
  over-current. See `Docs/hardware-resources.md` section 5.0.
- A calibration commit (`CALM=2`) does not set a slot's calibration-valid
  flags.
- The ESP32's AT console once repeated its last reply ~17,000 times.

