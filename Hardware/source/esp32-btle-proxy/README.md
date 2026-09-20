# esp32-btle-proxy

BLE and WiFi proxy for the TIDA-010086 eight-channel battery test system
(BTS), with a battery test state machine on top of the raw I2C register map.

The ESP32 is the supervisor: it owns the test sequence, integrates capacity,
enforces the cell's limits, records results, and exposes all of it over both
a GATT service (for a Web Bluetooth UI) and a JSON HTTP API.

---

## Hardware

| | |
|---|---|
| Board | Wemos LOLIN32 v1.0.0, ESP-WROOM-32, with the on-board lithium charger and a backup cell |
| Target | `esp32` (Xtensa, dual core) |
| Flash | 4 MB |
| Programming port | COM6 (Silicon Labs CP210x) |
| BTS link | I2C master, SDA = GPIO21, SCL = GPIO22, 100 kHz |
| BTS address | `0x50` |
| Unit envelope | 0–5 V and ±10 A per channel, 8 channels |

The backup cell is why `test_engine_init()` stops the channels at boot: the
proxy can outlive a BTS power cycle, so at startup it cannot know what the
unit is doing and must not assume the channels are idle. The one exception is
a slot the BTS reports `PAUSED` — see the watchdog and pause section below.

---

## Building and flashing

`export.ps1` does not work on this machine — it resolves `python` from PATH
and finds the system 3.6 interpreter before the IDF venv. Use the bundled
environment script instead:

```powershell
cd esp32-btle-proxy
. .\idf_env.ps1          # sets IDF_PATH, the venv, the toolchain and ESP_IDF_VERSION
idf.py build
idf.py -p COM6 flash monitor
```

`idf_env.ps1` mirrors the paths the CCStudio ESP-IDF extension is configured
with (`idf.customExtraVars` in the editor settings). The one non-obvious
variable is `ESP_IDF_VERSION`: `idf_component_manager` reads it unconditionally
and crashes on `None` if it is unset.

The build is also driveable from the editor's ESP-IDF extension, which sets
the same environment itself.

---

## Register map v2 and the host watchdog

The BTS register map was reorganised in v2, and **every address moved**. Both
the C2000 and this firmware must be flashed together - there is no
compatibility window. The authoritative contract is
`Docs/supervision-and-state-design.md`; `components/bts_link/include/bts_regs.h`
is the mirror this project builds against.

Three regions replace the nine scattered blocks of v1:

| Region | Base | Stride | Regs/slot | Range |
|---|---|---|---|---|
| runtime (RO) | 0 | 48 B | 12 | 0 – 383 |
| settings (RW) | 384 | 96 B | 24 | 384 – 1151 |
| unit | 1152 | — | — | 1152 – 1252 |

**314 registers, top address 1252.** A slot's whole live state - status, both
measurement paths, temperature and six counters - is one contiguous burst,
which took the poll cycle from **33 I2C transactions to 9** (8 slots + the
unit block; 10 while calibration is active). `eChX_MinVoltage`/`MaxVoltage`
are deleted: they were declared RO and never written.

Always derive addresses with `BTS_RT_ADDR()`, `BTS_SET_ADDR()` and
`BTS_CAL_ADDR()` rather than open-coding the arithmetic.

### The host watchdog

The unit runs a countdown, 30 s by default, reloaded by **any** host command
on any interface - including a register **read**, so this firmware's 250 ms
poll keeps it fed without a dedicated keep-alive. When it expires every
`CHARGING`/`DISCHARGING` slot is paused with `WD_TRIPPED` and its converter
off. That is the supervision this instrument previously had nowhere: before
v2, losing the ESP32 left the converters running.

**The read-path reload is load-bearing here.** This firmware's steady-state
poll issues nothing but reads, so a BTS build that reloads only in
`applyHostRegisterWrite()` would pause every running slot 30 s after the last
mode command, however healthily the proxy is polling. Verify it against the
I2C target read path, not just the write path, before trusting a long run.

It is **not** over-current protection. Hardware over-current trips are
disabled on this build and the software check in `BTS_tripEpwm()` remains the
only fast protection.

The timeout is readable and writable at `eHostWatchdog_s` (1196) and appears
in `GET /api/status` as `unit.watchdog_timeout_s`. Writing 0 disables it,
which is for bench work where nothing is polling. The unit publishes only the
configured timeout, **not the remaining seconds**, so no host can show a live
countdown - only whether supervision is armed.

### PAUSED, and why a restored slot never auto-resumes

A slot can be `PAUSED` with its `CHARGING` or `DISCHARGING` bit still set:
the converter is off, the direction is remembered and the counters are frozen
intact. Two bits say why - `WD_TRIPPED` (the host link died mid-run) and
`RESTORED` (the unit reset and rebuilt the run from F-RAM at boot).

`RESTORED` is the safety-critical one. **The engine never resumes it.** The
cell may have been swapped while the unit was off, so the run is parked in
`SLOT_STATE_BTS_PAUSED` - which is neither a fault nor an idle slot the
engine may reuse - and only an explicit operator action over HTTP or BLE
resumes it. `test_engine_init()`'s boot sweep skips a paused slot for the
same reason: stopping it would discard the state the unit deliberately kept.

Pause and resume are edge command bits in the mode register (3 and 4), acted
on at the write and not retained.

---

## One thing the BTS firmware still cannot do

Found by reading the C2000 sources. **Not a fault in this project — it is a
limitation of the BTS build in `tida-010086/bts_F2837xD_8ch/`.**

### The mAh/mWh accumulators cannot be reset on demand

The specified sequence was "reset the watt and current counters in the BTS
via registers, then initiate the discharge". The **populated** half of that is
solved on the BTS side; the **host-commanded reset** half is not:

- CPU1 integrates `Isense_A`/`Vsense_V` — the 16-bit ADS131M08 pair — in its
  6.67 Hz `C1()` task and publishes both directions' totals in each slot's
  runtime block, now with a run-time seconds counter beside each mAh/mWh
  pair. Both accumulate positive magnitude into their own direction, so a
  charge and a discharge on one slot give two separate totals.
- They are **still `REG_ACCESS_RO`**, and `i2cSlaveISR()` still drops host
  writes to RO registers, so a host cannot zero them whenever it likes.
- What replaces that: the BTS resets a direction's set itself in
  `modeCallback()` at the moment that direction starts, and only that set.
  A pause and resume zeroes nothing, which is the point of the state.

**What this firmware does:** keeps its own trapezoidal integration
(`coulomb_counter.c`) as the reported figure, because it samples on real
elapsed time at the 250 ms poll rather than a fixed 150 ms step and does not
lose a partial interval at the ends of a run. The BTS's own counters are read
each poll and reported beside it (`bts_raw` in the result JSON, `bts` in the
slot status) so the two can be compared. `try_reset_bts_accumulators()` still
issues the write for a future build that makes the registers writable.

For a slot the BTS is holding paused, the **BTS's** counters are the ones
reported: the run may predate this boot entirely, and where both exist the
BTS's kept counting up to the moment of the pause.

Note that `bts_link_stats_are_live()` is a **positive test only**: a unit that
has been idle since power-up reads all-zero and is indistinguishable from an
older firmware that never wrote these registers.

### End-of-test is now signalled — but the engine still owns the cutoff

`BTS_STATUS_FINISHED` (bit 2) was declared and never assigned on either core.
In v2 it carries the `END` semantic and is driven, alongside an explicit
`BTS_STATUS_END` at bit 16; `BTS_STATUS_ENDED_MASK` accepts either, so the
engine works against a unit built either way. It still watches cell voltage
against the cutoff itself and issues the stop rather than depending on the
unit to do so.

---

## Register map contract

`components/bts_link/include/bts_regs.h` is a hand-maintained mirror of
`tida-010086/bts_F2837xD_8ch/registers.h`. **There is no build coupling
between the two projects — if the C2000 map changes, update `bts_regs.h` to
match.**

Two details are easy to get wrong, and the older ESPHome component in
`esp32-controller/components/bts_i2c/` gets both of them wrong (it is also
still on the v1 map and is documented as do-not-use):

**Byte order is big-endian.** `floatGetWireByte()` in `com_cpu2.c` emits
word1-high, word1-low, word0-high, word0-low, which is the float MSB first.
A `memcpy` into a `float` on the ESP32 produces garbage. Use
`bts_wire_to_f32()` / `bts_f32_to_wire()`.

**Offsets and status bits mean different things on the two sides.** In
`bts_regs.h` the offsets are **byte** offsets and `BTS_STATUS_*` are
**masks**; the C2000 header uses register **indices** and bit **positions**.
Copying a line between the two files compiles and is silently wrong — there
is a warning block above `BTS_STATUS_RUNNING` saying so.

Register addresses on the wire are **byte** addresses (index × 4). Reads
auto-increment, so a whole block is one transaction; writes rewind to the
address phase, so a burst write must not resend the address.

Every read is preceded by one **pad byte**: the C2000 starts clocking out
whatever its transmit register holds the instant it acknowledges the repeated
start, before its ISR can run. `bus_read_block()` fetches `1 + count*4` bytes
and discards the first. A read path that omits this returns shifted garbage.

---

## Test sequence

```
IDLE
 └─ CHECK_REST      measure open-circuit voltage after a 10 s settle
     ├─ V ≥ charge_v_max × (1 − rest_tolerance_pct/100)  →  DISCHARGE
     └─ otherwise                                        →  CHARGE
 ├─ CHARGE          CC at the charge C rate, then CV, until the current
 │                  tapers to charge_term_c × capacity
 ├─ REST            the chemistry's rest_minutes; the voltage at the end is
 │                  recorded as the discharge's true start voltage
 ├─ DISCHARGE       zero the counters, then CC at the discharge C rate until
 │                  the cell reaches discharge_v_min, integrating mAh/mWh
 ├─ DISCHARGE_REST  5 min settle, then record the true rested end voltage
 ├─ RECHARGE        only when auto_recharge_to_shipping is set: put back
 │                  shipping_pct of the mAh just removed, by coulomb count
 └─ COMPLETE
```

Any state can go to `FAULT` (which must be cleared explicitly, so an operator
has to see it) or `ABORTED`. A slot can also land in `BTS_PAUSED` from any
state including `IDLE`, when the unit reports the slot paused — a watchdog
timeout, or a run restored from F-RAM at boot. That is not a fault and not an
idle slot: starting or reconfiguring it is refused until an operator resumes
or aborts it.

The recharge target is a percentage of **what this test actually removed**,
not of the datasheet capacity, so an aged cell still lands at the right state
of charge. It terminates on coulomb count rather than voltage, because
resting voltage is a poor SoC proxy on a flat-plateau chemistry like LFP;
`charge_v_max` remains a hard backstop.

### Safety supervision

Every tick, on every active state: over/under temperature against the cell's
profile, over-current against the setpoint (30% margin, after a 2 s ramp
allowance), the BTS CMPSS and GPIO trip bits, the unit's input-voltage state,
a wall-clock ceiling (12 h by default), and the I2C link itself. A sustained
comms blackout stops every channel, so a dropped link cannot leave a cell on
load indefinitely.

The BTS's own 30 s host watchdog now backs that up from the other side: if
this firmware stops polling entirely, the unit pauses every running slot
itself rather than leaving the converters on.

This is the *slow supervisory* layer. The BTS's own CMPSS and GPIO trips are
the fast one, in hardware, and they stay authoritative.

---

## Cell definitions

`components/cell_profiles/` carries a two-layer model: a **chemistry** sets
the voltage envelope and default C rates; a **cell model** pins the capacity
and the manufacturer's continuous current ratings. Selecting a model implies
its chemistry. A user-entered capacity always wins, because aged cells are
the normal case.

Chemistries: **LCO, LTO, LFP, NMC, NCA**.

LTO is the outlier and is worth checking if something looks wrong: 2.4 V
nominal, 2.8 V max, **1.5 V** cutoff, and it tolerates sub-zero charging.
A NMC-shaped assumption would cut it off at 2.5 V and report roughly half
its capacity.

Models: **20Q, 25R, 30Q, 30R** (Samsung INR18650), **VTC3, VTC4, VTC5,
VTC5A, VTC6** (Sony/Murata).

Resolution order, in `cell_profile_resolve()`:

1. chemistry defaults
2. model overrides (capacity, datasheet voltages)
3. user capacity override
4. the cell's own continuous current rating
5. the unit envelope (±10 A, 0–5 V)

Chemistry profiles can be overridden at runtime and are persisted to NVS, so
a site can retune a cutoff without a firmware build.

---

## BLE interface

One primary service, `e5f10001-9a4c-4b7d-8f2e-1c3a5b7d9f01`. Every
characteristic shares the base with a 16-bit discriminator in bytes 2–3.

| UUID suffix | Access | Payload |
|---|---|---|
| `0002` | read, notify | `ble_unit_status_t` |
| `0003` | write | `ble_cmd_t` — start / abort / clear fault / abort all / pause / resume |
| `0004` | read, write | `uint8` slot select |
| `0005` | read, write | `ble_slot_config_t` |
| `0006` | read | `ble_slot_result_t` |
| `0007` | write | UTF-8 barcode for the selected slot |
| `0008` | read, write | `uint8` catalogue index |
| `0009` | read | `ble_catalog_entry_t` |
| `000a` | read, notify | `ble_slot_status_t` |
| `000b` | write | `ble_cal_cmd_t` |
| `000c` | read, notify | `ble_cal_status_t` |

All records are packed little-endian, which is what `DataView` with
`littleEndian=true` reads — note this is the *opposite* of the BTS I2C wire
format; nothing past `bts_link` sees the C2000's byte order.

`ble_proto.h` is the contract. `BLE_PROTO_VERSION` is **3**, published in the
unit-status record so a client can refuse to decode a firmware it does not
understand rather than silently misreading a struct. Proto 3 **appends** to
`ble_unit_status_t` (the watchdog timeout, 24 B total) and to
`ble_slot_status_t` (the four pause flags and the six counters, 68 B total);
no characteristic was renumbered, because the discriminators are the client's
contract. `tools/ble_verify.py` decodes both and checks the version first.

The slot-status notification carries its slot number, so one subscription
covers all eight. Notifications fire on every state change, and once a second
while anything is running.

The 128-bit service UUID is advertised in the **scan response** — with the
device name it will not fit in the 31-byte advertising payload, and Web
Bluetooth needs it present to offer the device in a filtered chooser.

Disconnecting does **not** abort running tests. A multi-hour discharge has to
survive an operator walking away with the tablet.

---

## HTTP API

| Method | Path | |
|---|---|---|
| GET | `/api/status` | unit + all slots, with the watchdog timeout and per-slot pause flags and counters |
| GET | `/api/slot/<n>` | one slot, with its resolved profile and last result |
| POST | `/api/slot/<n>/config` | all fields optional; unspecified fields keep their current value |
| POST | `/api/slot/<n>/start` · `/abort` · `/clear` | |
| POST | `/api/slot/<n>/pause` · `/resume` | pause a running slot, or resume one the BTS is holding |
| POST | `/api/slot/<n>/serial` | `{"serial":"..."}` |
| GET | `/api/slot/<n>/result` | |
| GET | `/api/results?offset=&limit=` | rolling history, 64 deep |
| GET | `/api/catalog` | chemistries and cell models |
| POST | `/api/chemistry/<name>` | override and persist a chemistry profile |
| POST | `/api/abort_all` | |
| POST | `/api/wifi` | `{"ssid":"...","password":"..."}` |
| GET | `/api/registers?addr=&count=` | raw BTS registers, for bring-up |

Route ordering matters and is not obvious: `httpd_uri_match_wildcard()`
honours only a **trailing** asterisk, so a pattern with the wildcard in the
middle never matches. Exact paths are registered before the wildcards, one
wildcard pattern is registered per method, and the trailing action segment is
dispatched by hand — see the comment on the route table.

Example. There is no mDNS responder in this firmware, so use the address the
device logs on connect (`idf.py monitor`) rather than a `.local` name:

```bash
BTS=192.168.1.50   # from the boot log
curl -X POST http://$BTS/api/slot/0/config \
  -d '{"model":"VTC6","serial":"ABC123","auto_recharge_to_shipping":true}'
curl -X POST http://$BTS/api/slot/0/start
curl http://$BTS/api/status

# A slot that came back paused after a BTS reset, once the cell is confirmed:
curl -X POST http://$BTS/api/slot/0/resume
```

JSON is emitted and parsed by `json_min.c` rather than cJSON: IDF 6.1 no
longer bundles cJSON (it is a registry component fetched at configure time),
this project has to build offline, and the documents involved are flat and
fixed-shape.

WiFi comes up as APSTA. Stored station credentials are joined if present; the
SoftAP stays up either way, so a tester whose site network changed is still
reachable. The AP is open by default — a WPA2 key baked into shipped firmware
is not a security boundary; the bench network is.

---

## Layout

```
main/main.c                        init order and board wiring
components/bts_link/               I2C transport, 250 ms poll task, snapshot
  include/bts_regs.h               the register map contract
components/cell_profiles/          chemistries, cell models, resolution
components/test_engine/            the state machine
  coulomb_counter.c                local mAh/mWh integration
  result_store.c                   NVS ring buffer in the `results` partition
components/ble_svc/                NimBLE GATT server
  include/ble_proto.h              the BLE wire contract
components/web_api/                HTTP API, WiFi, minimal JSON
```

NimBLE rather than Bluedroid: with dual OTA slots in 4 MB, the ~100 kB
Bluedroid costs over NimBLE for a peripheral-only role is not affordable.

Results live in a **separate NVS partition** from the default one, so filling
it with test history cannot displace the chemistry overrides or the WiFi
credentials.

There is no factory partition — with a blank `otadata` the bootloader runs
`ota_0`, so a factory slot would only cost a third of the flash to hold a
copy of the same image.
