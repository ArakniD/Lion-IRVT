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

The backup cell is why `test_engine_init()` stops every channel at boot: the
proxy can outlive a BTS power cycle, so at startup it cannot know what the
unit is doing and must not assume the channels are idle.

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

## Two things the BTS firmware cannot currently do

Both were found by reading the C2000 sources, and both change what this
firmware had to do. **Neither is a fault in this project — they are
limitations of the BTS build in `tida-010086/bts_F2837xD_8ch/`.**

### 1. The mAh/mWh accumulators cannot be reset on demand (partly resolved)

The specified sequence was "reset the watt and current counters in the BTS
via registers, then initiate the discharge". The **populated** half of that is
now solved on the BTS side; the **host-commanded reset** half is not:

- CPU1 integrates `Isense_A`/`Vsense_V` — the 16-bit ADS131M08 pair — in its
  6.67 Hz `C1()` task and publishes per-direction totals: charge at
  `eChX_ChargeAcc_mAh`/`_mWh` (320/332, the old `CurrentAcc`/`PowerAcc`
  addresses, renamed) and discharge at `eChX_DischargeAcc_mAh`/`_mWh`
  (1156 + ch×8). Both accumulate positive magnitude into their own direction,
  so a charge and a discharge on one slot give two separate totals.
- They are **still `REG_ACCESS_RO`**, and `i2cSlaveISR()` still drops host
  writes to RO registers, so a host cannot zero them whenever it likes.
- What replaces that: the BTS resets a direction's pair itself in
  `modeCallback()` at the moment that direction starts, and only that pair.
  So by the time a mode write has been accepted the counters for the run
  about to begin are already at zero — which is the behaviour the
  reset-then-discharge sequence actually needed.

**What this firmware does:** keeps its own trapezoidal integration
(`coulomb_counter.c`) as the reported figure, because it samples on real
elapsed time at the 250 ms poll rather than a fixed 150 ms step and does not
lose a partial interval at the ends of a run. The BTS's own counters are read
each poll and reported beside it (`bts_raw` in the result JSON) so the two can
be compared. `try_reset_bts_accumulators()` still issues the write for a
future build that makes the registers writable.

Note that `bts_link_stats_are_live()` is now a **positive test only**: a unit
that has been idle since power-up reads all-zero and is indistinguishable
from the older firmware that never wrote these registers.

### 2. The BTS never signals end-of-test

`status[].finished` is declared, and published in the status bitfield, but is
never assigned by any code path on either core — it is only read, in
`publishStatusToCpu2()` (`bts_cpu1.c:390`).

**What this firmware does instead:** the engine watches cell voltage against
the cutoff itself and issues the stop. It also honours `BTS_STATUS_FINISHED`
and an unexpected `STOPPED` as additional termination conditions, so a future
BTS build that does assert them will work without a change here.

---

## Register map contract

`components/bts_link/include/bts_regs.h` is a hand-maintained mirror of
`tida-010086/bts_F2837xD_8ch/registers.h`. **There is no build coupling
between the two projects — if the C2000 map changes, update `bts_regs.h` to
match.**

Two details are easy to get wrong, and the older ESPHome component in
`esp32-controller/components/bts_i2c/` gets both of them wrong:

**Byte order is big-endian.** `floatGetWireByte()` in `com_cpu2.c` emits
word1-high, word1-low, word0-high, word0-low, which is the float MSB first.
A `memcpy` into a `float` on the ESP32 produces garbage. Use
`bts_wire_to_f32()` / `bts_f32_to_wire()`.

**The blocks do not share a stride.**

| Block | Base | Stride/channel |
|---|---|---|
| control | 0 | 40 B (10 regs) |
| stats | 320 | 24 B (6 regs) |
| temp limits | 512 | 8 B (2 regs) |
| global voltage | 576 | — (4 regs total) |
| calibration | 592 | 48 B (12 regs) |
| unit | 976 | — (4 regs total) |
| measured cell temp | 992 | 4 B (1 reg) |
| sense (ADS131M08) | 1092 | 8 B (2 regs) |
| discharge accumulators | 1156 | 8 B (2 regs) |

Always derive addresses with `BTS_CTRL_ADDR()`, `BTS_STATS_ADDR()` and
friends rather than open-coding the arithmetic.

Register addresses on the wire are **byte** addresses (index × 4). Reads
auto-increment, so a whole block is one transaction; writes rewind to the
address phase, so a burst write must not resend the address.

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
has to see it) or `ABORTED`.

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
| `0003` | write | `ble_cmd_t` — start / abort / clear fault / abort all |
| `0004` | read, write | `uint8` slot select |
| `0005` | read, write | `ble_slot_config_t` |
| `0006` | read | `ble_slot_result_t` |
| `0007` | write | UTF-8 barcode for the selected slot |
| `0008` | read, write | `uint8` catalogue index |
| `0009` | read | `ble_catalog_entry_t` |
| `000a` | read, notify | `ble_slot_status_t` |

All records are packed little-endian, which is what `DataView` with
`littleEndian=true` reads — note this is the *opposite* of the BTS I2C wire
format; nothing past `bts_link` sees the C2000's byte order.

`ble_proto.h` is the contract. `BLE_PROTO_VERSION` is published in the
unit-status record so a client can refuse to decode a firmware it does not
understand rather than silently misreading a struct.

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
| GET | `/api/status` | unit + all slots |
| GET | `/api/slot/<n>` | one slot, with its resolved profile and last result |
| POST | `/api/slot/<n>/config` | all fields optional; unspecified fields keep their current value |
| POST | `/api/slot/<n>/start` · `/abort` · `/clear` | |
| POST | `/api/slot/<n>/serial` | `{"serial":"..."}` |
| GET | `/api/slot/<n>/result` | |
| GET | `/api/results?offset=&limit=` | rolling history, 64 deep |
| GET | `/api/catalog` | chemistries and cell models |
| POST | `/api/chemistry/<name>` | override and persist a chemistry profile |
| POST | `/api/abort_all` | |
| POST | `/api/wifi` | `{"ssid":"...","password":"..."}` |
| GET | `/api/registers?addr=&count=` | raw BTS registers, for bring-up |

Example. There is no mDNS responder in this firmware, so use the address the
device logs on connect (`idf.py monitor`) rather than a `.local` name:

```bash
BTS=192.168.1.50   # from the boot log
curl -X POST http://$BTS/api/slot/0/config \
  -d '{"model":"VTC6","serial":"ABC123","auto_recharge_to_shipping":true}'
curl -X POST http://$BTS/api/slot/0/start
curl http://$BTS/api/status
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
