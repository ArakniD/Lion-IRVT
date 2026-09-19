# Lion-IRVT

An eight-channel bidirectional battery test system (BTS) — charge and discharge,
constant-current and constant-voltage — for testing and characterising
18650-class lithium cells. The workspace file is `18650-Tester-Project.DsnWrk`;
that is what the instrument is for.

The power stage and control card derive from Texas Instruments reference design
**TIDA-010086**, a 10 A battery formation and test design that TI documents as
scalable to eight channels. Here it is built out to all eight, retargeted to the
**TMS320F28379D**, and split across both of its cores. An ESP32 sits on top as
host controller.

| Layer | Device | Job |
|---|---|---|
| Control | F28379D **CPU1** | Eight independent synchronous bidirectional converters. HRPWM, DCL control loops, external SPI ADC (ADS131M08), on-chip ADC, trip handling. |
| Communication | F28379D **CPU2** | I2C slave register file for the host, I2C master for F-RAM and the ADS1119 temperature converters, UART AT console, CAN telemetry, WS2812B status LEDs, calibration persistence. |
| Supervision | **ESP32** (LOLIN32 v1.0.0) | I2C master. Owns the test sequence and cell limits, integrates mAh/mWh, records results, and exposes BLE GATT, a JSON HTTP API and an ST7789 LCD with a rotary encoder. |

The two C2000 cores share data through the message RAMs under a single-writer
rule: **CPU1 never writes the register file.** It publishes measurements into
`cpu1Status` under a seqlock and CPU2 mirrors them into `registers[]`. Every
data-flow decision in the firmware follows from that.

---

## Repository layout

| Path | Contents |
|---|---|
| `Design/` | Pre-layout analysis, not build inputs: TINA-TI simulations (`.TSC`) of the current loop and the synchronous buck, the inductor/LC selection spreadsheet, and vendor app notes. |
| `Hardware/schematics/` | Altium projects. `TIDA-010086/` is the modified TI reference design, `TIDA-010086_exTrip/` the added external trip logic, `Lion-IRVT/` the front-end and cell-holder sheets, `controlCARD/` the F28379D controlCARD reference. |
| `Hardware/mechanical/` | DXF/DWG for the 4-wire 18650 slot jig and the enclosure, plus laser-cut sheet layouts. |
| `Hardware/publish/` | A generated output set from Feb 2021 — Gerbers, drills, BOM, pick-and-place, assembly drawings, 3D/STEP. A snapshot, not regenerated on every change. |
| `Hardware/source/` | **All firmware.** See below. |
| `References/` | Component libraries, footprints, vendor 3D models and datasheets. **Entirely gitignored** (`References/*`) — the directory exists locally but nothing in it is tracked. Expect it to be empty on a fresh clone. |

Inside `Hardware/source/`:

| Path | Contents |
|---|---|
| `tida-010086/bts_F2837xD_8ch/` | The C2000 dual-core firmware. This is the instrument. |
| `esp32-btle-proxy/` | **Current** ESP32 host firmware (ESP-IDF). |
| `esp32-controller/` | Superseded ESPHome-based controller (2025). |
| `esp32-bridge/` | Superseded Arduino WiFi bridge (2024). |
| `Docs/` | The authoritative interface and calibration specifications. Start here. |
| `references/` | Datasheets and manuals used while writing the firmware: F2837xD TRM, controlCARD guide, ADS131M08, ADS1119, the LOLIN32 schematic, and the XTIDA-010086E3 schematic PDF. |
| `.claude/` | Agent skills and project notes. |

### Documents

`Hardware/source/Docs/` is source-verified and is the thing to read before the
code:

| File | What it is |
|---|---|
| [`README.md`](Hardware/source/Docs/README.md) | Operator bench procedure for slot calibration. Wiring, safety, step by step, troubleshooting. |
| [`calibration-design.md`](Hardware/source/Docs/calibration-design.md) | The engineering contract: register addresses, opcodes, the two-point mathematics, the state machine, F-RAM layout, RAM budget. |
| [`calibration-flow.md`](Hardware/source/Docs/calibration-flow.md) | The same, as Mermaid flow, state and sequence diagrams. |
| [`ble-specification.md`](Hardware/source/Docs/ble-specification.md) | The full GATT service: 11 characteristics, packed layouts, notify behaviour, protocol versioning. |
| [`api-specification.md`](Hardware/source/Docs/api-specification.md) | Part 1 the HTTP API; Part 2 the complete I2C register map, all 305 registers, with the transaction shapes. |

---

## The three ESP32 projects — build the right one

There are three, and only one is live.

| Directory | Added | Toolchain | Status |
|---|---|---|---|
| `esp32-bridge/` | Aug 2024 | Arduino `.ino` | **Superseded.** A WiFi/OSC bridge over a packet-oriented I2C protocol that predates the float register map. |
| `esp32-controller/` | Apr 2025 | ESPHome YAML + C++ components | **Superseded.** Adds a HID barcode scanner and a `bts_i2c` component. Its I2C layer is wrong in two ways: `bytes_to_float()` assembles the float in host order under a comment asserting "BTS uses little-endian float", when the wire format is big-endian; and `read_register()` requests four bytes where five are needed, so it never discards the lead-in pad byte. Do not copy from it. |
| `esp32-btle-proxy/` | Sep 2026 | ESP-IDF v6.1 | **Current.** Everything else in this README refers to this one. |

The two superseded trees are retained for the pin assignments and the
barcode-scanner work, not as a starting point.

---

## Building

### C2000 firmware

TI Code Composer Studio, installed here at `C:/ti/ccs2101`. The dependency is
the **C2000Ware Digital Power SDK** (`C:/ti/c2000/C2000Ware_DigitalPower_SDK_5_03_00_00`)
for driverlib, DCL, the SFO HRPWM calibration library and SFRA.

Open the project `bts_F2837xD_8ch` from
`Hardware/source/tida-010086/bts_F2837xD_8ch`. It has **two build
configurations, `cpu1` and `cpu2`, and both must be built** — they compile the
same sources with `--define=CPU1` or `--define=CPU2` and link against different
`.cmd` files, producing `bts_F2837xD_8ch_cpu1.out` and `..._cpu2.out`.

- `cpu1` is the active configuration; CCS's own build tooling handles it, and
  inside CCS that is the only supported way to build it.
- `cpu2` is built from its generated `cpu2/makefile`, which the CCS build
  produced and which carries the full `--define=CPU2` command line.

After building, check the `.map` files. Every shared symbol must land at the
same address in both, and `CPU2TOCPU1RAM` must not overflow — see the TODO
section.

> **Loading both cores.** Starting a debug session loads only the active
> configuration (`cpu1`). CPU2 is left running whatever was in its RAM, and
> because CPU2 owns I2CA, a CPU1-only reload leaves the ESP32 link dead while
> CPU1 looks perfectly healthy. Load CPU2's `.out` explicitly, restart, then
> resume CPU2 first and CPU1 second — CPU1's `Device_bootCPU2()` needs CPU2
> already at its entry point.

The build links for RAM (`2837xD_RAM_lnk_cpu1.cmd` / `_cpu2.cmd`).

### ESP32 firmware

ESP-IDF **v6.1**, target `esp32`, on the LOLIN32 v1.0.0 (ESP-WROOM-32, 4 MB).

**The stock `export.ps1` does not work on this machine.** It resolves `python`
from `PATH` and finds the system Anaconda 3.6 interpreter before the IDF venv.
`idf_env.ps1` sets the same variables directly, taken from the paths the
editor's ESP-IDF extension is configured with, and additionally sets
`ESP_IDF_VERSION`, which `idf_component_manager` reads unconditionally and
crashes on `None` if it is unset.

```powershell
cd Hardware\source\esp32-btle-proxy
. .\idf_env.ps1
idf.py build
idf.py -p COM6 flash monitor
```

Configuration lives in `sdkconfig.defaults`; regenerate `sdkconfig` from it
rather than hand-editing. The partition table is custom (`partitions.csv`):
dual OTA slots plus a second NVS partition for the result history, so filling
it with test records cannot displace the WiFi credentials or chemistry
overrides.

> This board has no auto-program circuit that works reliably. If `esptool`
> reports `Wrong boot mode detected (0x13)`, use the BOOT button, or see
> `tools/enter_download.py`.

---

## Tools

`Hardware/source/esp32-btle-proxy/tools/`.

> **Python on this machine:** the system `python` is **3.6** and too old for
> every script here. Use the IDF venv interpreter:
> `C:\Espressif\tools\python\v6.1\venv\Scripts\python.exe` (3.11).

### Bench automation

| Script | |
|---|---|
| **`calibrate.py`** | The significant one. Guided two-point slot calibration, walking slots 1–8 and prompting at each connection change. Drives the tester over **BLE** (`bleak`) and an Agilent/Keysight **DMM over LAN SCPI on TCP 5025** as the traceable reference. Refuses to advance until the live per-unit reading is inside the required window, prints a before/after gain table, and writes a JSON report. Config is prompted once and persisted to `calibrate.ini`. Flags: `--slots 3,5` or `--slots 2-4`, `--dry-run` (full flow against a simulated tester and DMM, **no hardware needed**), `--reconfigure`, `--report`, `--allow-unknown-dmm`. Every exit path — normal, Ctrl-C, or an unhandled exception — issues `CAL_CMD_EXIT`, so a slot is never left driving current. |

### BLE bring-up

| Script | |
|---|---|
| `ble_scan.py` | Scan and dump anything that looks like the tester. Confirms it is advertising before you try to connect. |
| `ble_verify.py` | Connect and verify the whole GATT interface against the packed structs in `ble_proto.h`, subscribing to both notify characteristics. Non-zero exit on failure, so it works as a bench smoke test. |

### Serial and flashing

These exist because the LOLIN32's reset circuit cannot reliably self-enter
download mode on this host. They are a diagnostic chain, roughly in the order
they were written, and each one's docstring records what the previous
established.

| Script | |
|---|---|
| `probe_reset.py` | Determines which DTR/RTS combination drives EN and IO0, by reading the ROM's own `boot:0x..` banner rather than guessing polarity. |
| `probe_io0.py` | Given that RTS drives EN, tests whether DTR reaches IO0 at all. |
| `probe_dtr_alone.py` | Characterises DTR on its own. |
| `sweep_reset.py` | Sweeps the EN-release / IO0-assert timing gap looking for a window that works. |
| `enter_download.py` | The result: drives DTR/RTS directly to enter download mode, after which `idf.py -p COM6 --before no-reset flash`. |
| `try_download_hard.py` | Last-resort strategies, each verified by a real esptool SYNC. |

### Code generation

| Script | |
|---|---|
| `gen_font.py` | Generates `components/display/ui_font.c`, the 5×7 UI font table. The output is committed; re-run only if the glyph set changes. |

---

## Interfaces

Five host interfaces. Register tables are **not** duplicated here — the
specifications are authoritative.

> **Endianness differs by interface and this is the detail most likely to cost
> you an afternoon.** The I2C register wire format is **big-endian** (the
> C2000's `floatGetWireByte()` emits the float MSB first). The BLE records are
> **little-endian**. HTTP carries JSON numbers, so no byte order applies. The
> conversion happens in `bts_regs.h`; nothing above `bts_link` sees the C2000's
> byte order.

| Interface | Where | Authority |
|---|---|---|
| **I2C register map** | C2000 CPU2 as slave at `0x50` on I2CA (GPIO32/33); the ESP32 is master. 305 float registers, 16-bit byte addresses, blocks with **differing strides** — always derive through the base macros. A read must fetch `1 + count×4` bytes and **discard the first**: the target clocks out a stale byte before its ISR can run. The bus runs at 50 kHz. | [`api-specification.md`](Hardware/source/Docs/api-specification.md) Part 2 |
| **BLE GATT** | ESP32, NimBLE. One primary service `e5f10001-…`, 11 characteristics, advertised as `BTS-Tester`. The 128-bit service UUID is in the **scan response**, not the advertising payload, because it will not fit alongside the name. `BLE_PROTO_VERSION` (currently 2) is published so a client can refuse a firmware it cannot decode. Disconnecting does **not** abort running tests. | [`ble-specification.md`](Hardware/source/Docs/ble-specification.md) |
| **HTTP API** | ESP32, port 80, JSON, **no authentication and no encryption**. Unit and per-slot status, slot config and control, result history, the cell catalogue, raw register access for bring-up, and the calibration endpoints. WiFi comes up APSTA: stored station credentials are joined if present and the SoftAP stays up either way. | [`api-specification.md`](Hardware/source/Docs/api-specification.md) Part 1 |
| **UART AT console** | C2000 CPU2, SCIA on the controlCARD FTDI backchannel at 115200 8N1. `AT+<name>?` and `AT+<name>=<value>` against short or long register names. **Only available in the debug build** (`BTS_DEBUG_CONSOLE == true`): the console takes GPIO28/29, which in production carry the WS2812B LED string and channel 1's GPIO trip. | `.claude/skills/bts-c2000-interfaces-skill/references/uart-at-commands.md` |
| **CAN** | C2000 CPU2, CANA, 500 kbit/s, extended IDs from `0x1C000000`. Message objects 1–8 are per-channel telemetry; object 9 is a host register read/write. | `.claude/skills/bts-c2000-interfaces-skill/SKILL.md` |

---

## Calibration

Each slot's measurement error is calibrated out against a **traceable external
reference** — your DMM — at two points per quantity, replacing what used to be
compile-time constants in `bts_user_calibration.h` with per-slot runtime values
persisted to the on-board FM24V10 F-RAM and reloaded at every boot.

Both measurement paths are calibrated from the same physical stimulus at the
same instant: the 16-bit ADS131M08 and the 12-bit on-chip ADC. They therefore
agree with each other as well as with the meter.

Read [`Docs/README.md`](Hardware/source/Docs/README.md) before running it. Two
things from it belong here:

> ### Hardware over-current protection is disabled in this build
>
> All eight hardware trips are `(false)` in `bts_user_settings.h:113-120`. The
> only over-current protection left is a software check that runs once per
> control pass — fast enough for a gradual overload, **not** fast enough for a
> genuine short. Calibration deliberately drives about 2.5 A.
>
> **Do not run calibration unattended, and set the bench supply's own current
> limit (3 A) before you start.** The supply's limit is your fast protection,
> because the unit's is not armed.

> **Enter the DMM current as a magnitude.** Calibration runs in discharge and
> the firmware applies the sign itself. Entering `-2.4991` where `2.4991` was
> wanted inverts that slot's current reading — it will look plausible, pass
> validation, and be wrong on every subsequent discharge.

---

## TODO and known limitations

Verified against the source, not aspirational. Split by whether it is a
decision or a gap.

### By design — do not "fix" these without reading why

- **The ESP32 owns the test sequence, not the BTS.** The C2000 regulates;
  termination, capacity integration, cell limits and state are the proxy's job.
  Two of the gaps below follow from this rather than being defects.
- **The build is CC-only.** `BTS_LAB_TYPE = BTS_LAB_CLOSED_LOOP_ACMC_IOUT`
  (`bts_user_settings.h:305`) selects `BTS_ISR_CL_MODE_CC`, which compiles out
  the CV loop and the CC-CV crossover in `bts.h` entirely. `voutRef_pu` is
  computed every millisecond and ignored. CV termination is done by the ESP32
  against measured cell voltage.
- **Calibration telemetry is unit-scoped, not per-slot.** Only one slot
  calibrates at a time; eight copies of the nine-register window would cost 144
  words of message RAM and buy nothing.
- **The ESP32 keeps its own coulomb counting even though the BTS now has
  accumulators.** `coulomb_counter.c` integrates against the actual elapsed
  time between polls, which is finer than the BTS's fixed 150 ms step, so it
  stays the reported figure. The BTS totals are read alongside it for
  comparison.

### Not yet implemented

| | |
|---|---|
| **The per-run min/max voltage trackers are never written.** | `eChX_MinVoltage` (324) and `eChX_MaxVoltage` (328) are declared `REG_ACCESS_RO` and no code path on either core assigns them — they read back a constant `0.0`. The mAh/mWh accumulators that used to share this defect are now live: 320/332 are the charge pair, 1156 + ch×8 the discharge pair, each zeroed by the BTS when a run starts in that direction. They remain RO, so a host still cannot zero them on demand. |
| **The BTS never signals end-of-test.** | Status bit 2 (`FINISHED`) is declared and published in the bitfield but never assigned; it is only *read*, in `publishStatusToCpu2()`. The ESP32 engine decides termination, and also honours `BTS_STATUS_FINISHED` and an unexpected `STOPPED` so a future build that does assert them works unchanged. |
| **No current-taper termination.** | `iref_cuttout_A` is loaded from the register map and propagated across a slot group (`bts_cpu1.c:1077, 1107`) and then **never read**. CC-to-cutoff taper is done on the ESP32 against the configured `charge_term_c`. |
| **All hardware over-current trips are disabled.** | `BTS_TRIP_HW_CH1..8_ENABLED (false)`, `bts_user_settings.h:113-120`. Only the software check in `BTS_tripEpwm()` (`bts.h:350`) is active — one control pass, not one switching cycle. The trip links need wiring and the X-BAR routing needs fixing before these go back to `true`; `bts_hal.c:1200-1216` records exactly what is wrong with the current routing (the one-shot zones read TZ1/TZ2, not TRIPIN9–12, and INPUT15/16 do not exist on this device). |
| **`eTripStatus` (988) is always zero, and so is status bit 3.** | The bits are set only in `epwmTripISR()`, whose trip-zone interrupt is enabled per channel only when that channel's `BTS_TRIP_HW_CHn_ENABLED` is true (`bts_hal.c:1098-1102`). The software trip path sets the trip-zone flags itself and does not go through the ISR. **Do not use `eTripStatus` as a fault indicator against this firmware.** |
| **`bts_regs.h` is a hand-maintained mirror of `registers.h` with no build coupling.** | Adding a register means editing both. Worse, the two files use the **same identifiers for different things**: `BTS_STATUS_*` and `BTS_CAL_ST_*` are bit *positions* on the C2000 and bit *masks* on the ESP32; the calibration and sense block offsets are register *indices* on one side and *byte* offsets on the other; and `BTS_SENSE_BASE` is a function-like macro returning an index on the C2000 and a bare byte-address constant on the ESP32. Copying a line between the files compiles and is wrong. |
| **`CPU2TOCPU1RAM` is the binding constraint on new shared registers.** | 1024 words, **258 free** after the calibration and accumulator blocks. Overflow is a *link-time* failure (`#10099-D`, section `MSGRAM_CPU2_TO_CPU1`), so it fails loudly — but any further addition needs a rebuild and a glance at the map. `CPU1TOCPU2RAM` has 548 free. |
| **Every slot must be recalibrated after this change.** | The F-RAM header magic was bumped `0xA5CC` → `0xA5CD` for the `calFlags`/`crc32` revision and the fixed 128-byte stride, so every existing block now fails validation and the slot falls back to compiled defaults with no green ticks. The same change fixes a long-standing bug in which channel 4's block overwrote the global voltage thresholds — which consequently have *never* persisted. |
| **No mDNS.** | Nothing in the firmware registers a `.local` name. Use the IP address the device logs on connect (`idf.py monitor`). |

---

## Working on this codebase

`Hardware/source/CLAUDE.md` holds the agent guidelines — most importantly, that
`C:/ti/ccs2101/ccs/theia/resources/ai/CCS.md` must be read before touching any
CCS tooling, and that CCS projects are built through the project MCP server
rather than by invoking `gmake` directly.

`Hardware/source/.claude/skills/bts-c2000-interfaces-skill/` is the system
overview and the interface authority for the C2000 side: the IPC contract and
core responsibilities, the I2C specification, the UART AT command set and the
calibration EEPROM process. `.claude/README.md` alongside it is a
feature-by-feature summary of what the firmware implements.

Two rules the whole firmware design rests on, and that are easy to break:

- **Never insert a register mid-map.** External hosts hard-code byte addresses.
  Append above the current top, and update the `registers.h` enum, the `NUM_*`
  counts, `TOTAL_REGISTERS`, `regConfig[]` and `uartRegConfig[]` **together** —
  the tables are sized by `TOTAL_REGISTERS` and must stay index-aligned.
- **CPU1 does not decode every register it is sent.** `BTS_HandleRegisterWrite()`
  only handles indices below `eCh0_CurrentAcc` and inside the calibration
  blocks. Anything else has its IPC flag acked and is silently discarded, so a
  new register needs an explicit entry or it will be accepted by CPU2 and
  quietly ignored by CPU1.

---

## Licence and provenance

Licensed under the **GNU General Public License v3** — see [`LICENSE`](LICENSE).

The power stage, control card and the original firmware derive from TI
reference design **TIDA-010086**, whose own firmware descends from the TI
`TIDM-DC-DC-BUCK` PowerSUITE example. TI's notice and disclaimer is retained
in `Hardware/schematics/TIDA-010086/`. The build-out to eight channels, the
split across both cores, the host interfaces and the runtime calibration are
this project's.
