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