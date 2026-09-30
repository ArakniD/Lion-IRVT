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
