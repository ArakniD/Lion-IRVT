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
| BTS link | I2C controller, SDA = GPIO21, SCL = GPIO22, **50 kHz** (see below) |
| Status panel | ST7789 on SPI2/HSPI, MOSI = GPIO23, SCK = GPIO18, CS = GPIO19 (external 10 k pull-up), DC = GPIO16, RST = GPIO17, BL = GPIO4 |
| Slot LEDs | 8x WS2812B on SPI3/VSPI, DIN = GPIO13 |
| Encoder | A = GPIO32, B = GPIO27, switch = GPIO33 |
| KEY0 button | GPIO34 (input only, pulled up on the LCD board) |
| BTS address | `0x50` |
| Unit envelope | 0–5 V and ±10 A per channel, 8 channels |

The backup cell is why `test_engine_init()` stops the channels at boot: the
proxy can outlive a BTS power cycle, so at startup it cannot know what the
unit is doing and must not assume the channels are idle. The one exception is
a slot the BTS reports `PAUSED` — see the watchdog and pause section below.

### The I2C link runs at 50 kHz

`main.c` asks for 100 kHz, but `bts_link.c` sets the device to **50 kHz**,
and that is what runs. The BTS board pulls the bus up with only 10 kΩ, over a
ribbon, so rise time — not bandwidth — is the limit: at 100 pF a 10 k
pull-up takes ~850 ns to rise, against the 1000 ns standard mode allows. The
ESP32's internal pull-ups are enabled as well. A poll cycle is nine
transactions, so 50 kHz costs nothing that matters.

At start-up the link tries 50 kHz and 10 kHz, in both pin orders, before
falling back to the configured pins, so a swapped SDA/SCL or a marginal
harness still comes up. After any failed transfer the bus is reset
(`bus_recover()`), and the poll task does **not** scan the bus while the link
is down — ESP-IDF v6.1's `i2c_master_probe()` leaves state behind on failure
that crashed the next transfer.

### Verified on a bare ESP32, 2026-10-08

On a fresh board with no BTS attached: BLE GATT (all 12 characteristics,
reads and notifications, proto 7, with register access correctly refused —
`tools/ble_verify.py --no-bts`), the setup page, every WiFi and OTA error
path, and two full WiFi updates, one rolled back by a reset during its trial
and one confirmed. **Not yet seen:** an update confirming itself on a live
BTS link, rather than through the 180 s fallback.

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

## Register map v2.1 and the host watchdog

The BTS register map was reorganised in v2, and **every address moved**. Both
the C2000 and this firmware must be flashed together - there is no
compatibility window. For any individual address the authority is
`Docs/api-specification.md` §2.8;
`components/bts_link/include/bts_regs.h` is the mirror this project builds
against.

Four regions replace the nine scattered blocks of v1:

| Region | Base | Stride | Regs/slot | Range |
|---|---|---|---|---|
| runtime (RO) | 0 | 48 B | 12 | 0 – 383 |
| settings (RW) | 384 | 72 B | 18 | 384 – 959 |
| unit (mixed) | 960 | — | 27 total | 960 – 1064 |
| slot tuning (RW) | 1068 | — | 13 total | 1068 – 1116 |

**280 registers, top address 1116.** The settings stride was 24 registers
until the 2026-09-22 compression merged the charge and discharge limit pairs,
which pulled the unit base down from 1152 to 960; the slot tuning block - the
DCL biquad coefficients, one set for the whole unit - was appended above it
afterwards. Anything still quoting 1152, 1252 or a 24-register stride predates
that change.

A slot's whole live state - status, both
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
  `C1()` task and publishes both directions' totals in each slot's
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
elapsed time at the 250 ms poll and does not lose a partial interval at the
ends of a run. The BTS's own counters are read
each poll and reported beside it (`bts_raw` in the result JSON, `bts` in the
slot status) so the two can be compared. `try_reset_bts_accumulators()` still
issues the write for a future build that makes the registers writable.

For a slot the BTS is holding paused, the **BTS's** counters are the ones
reported: the run may predate this boot entirely, and where both exist the
BTS's kept counting up to the moment of the pause.

Note that `bts_link_stats_are_live()` is a **positive test only**: a unit that
has been idle since power-up reads all-zero and is indistinguishable from an
older firmware that never wrote these registers.

### End-of-test: the BTS terminates, the engine sequences

The C2000 now ends a phase itself and reports it as END, status bit 2
(`BTS_STATUS_FINISHED`; `BTS_STATUS_END` is an alias for it, and bit 16 is
unused). A discharge ends at `V_MIN`; a charge ends once its CV loop holds
`V_MAX` and the current has fallen to `I_MIN`. `bts_says_done()` treats END
as the end of the current phase, and the engine moves on to the next step of
the test — rest, discharge, recharge.

The engine still watches the cell voltage against its own cutoffs and can
issue the stop itself, so a unit that never asserts END still finishes a
test. Discharge termination is verified on hardware; charge termination is
not yet.

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

## Slot indicators

Eight WS2812B pixels, one per BTS slot, are driven from this firmware —
`components/led_strip/`, one `SPI3_HOST` transfer every 25 ms from a FreeRTOS
task at priority 4. Colour comes from `bts_link_get_snapshot()`, so the
indicators ride on the poll that was already running and there is nothing to
feed them.

**This used to be the C2000's job, and it never lit a single pixel.**
`LEDDriver_update()` clocked raw colour bytes out of SCIA at 800 kbaud, but a
WS2812B decodes pulse *widths* — 400 ns high is a 0, 800 ns high is a 1, each
inside a 1250 ns slot — and a UART cannot produce them: it forces a low start
bit before every byte and holds each data bit for a full bit time, so the strip
saw framing noise and latched nothing. Fixing it in place needed a peripheral
that emits a free-running bit pattern, which on that device means SPI — and
GPIO29, the wire that physically exists, has no SPI mux option, while both
usable SPI ports are held by the ADS131M08 pair. The full account, including
the per-slot colour priority chain, is in
[`Docs/supervision-and-state-design.md` §2.5.1](../Docs/supervision-and-state-design.md#251-slot-indication--the-ws2812b-string).

**SPI3 and not SPI2.** The ST7789 panel holds SPI2, which *is* HSPI: it sits on
GPIO23/GPIO18 — VSPI's IO_MUX default pads — but reaches them through the GPIO
matrix, so SPI3 was the genuinely free host. Sharing one would let an LED frame
stall a panel repaint and vice versa.

**Four SPI bits per WS2812B bit at 2.5 MHz** (80 MHz / 32, so one SPI bit is
400 ns): `1000` is a 0, `1100` is a 1, landing both symbols on the part's exact
nominal widths with a 1600 ns slot well inside the 650–1850 ns it tolerates.
Two WS2812B bits pack into one SPI byte, so the whole eight-LED frame is 96
bytes in a single 307 us DMA transfer, and MOSI rests low afterwards — which
covers the 50 us reset latch for free. The rate is a deliberate departure from
the commonly-cited **3.333 MHz**, where the same `1100` symbol gives
T1H = 600 ns, *below* the 650 ns minimum for a logic 1. That works on some
strips and fails on others, which on a safety indicator is the worst failure
mode available.

**The encoder's B channel moved from GPIO13 to GPIO27** to free the MOSI pin.
GPIO14 was the other candidate and was rejected: it is MTMS, and a JTAG pin on
the encoder would make the box awkward to debug later. GPIO27 carries no
strapping or JTAG role. A and the switch have since moved off GPIO15 and GPIO2,
which are strapping pins, to GPIO32 and GPIO33. Full pin map:
[`Docs/esp32-hardware-connections.md`](../Docs/esp32-hardware-connections.md).

### What it costs

**Indication lags by up to one poll.** Colour derives from the 250 ms I2C
snapshot rather than from the unit's registers directly, so a state change can
take ~250 ms longer to reach the strip than a C2000-resident driver would have
needed. Against an operator's reaction time that is nothing; it is recorded
because it is a real difference.

**The strip now depends on this firmware being alive.** If the ESP32 is
unplugged, crashes, or is held in reset it sends no frames at all — and a
WS2812B latch holds its last colour **indefinitely**, leaving a pixel that
still shows a slot running when it has since tripped. All eight flashing
amber in unison covers the case where this firmware is running but cannot
reach the unit; by construction it cannot cover this firmware being dead.
Treat the strip as an indicator, never as evidence that a slot is safe.

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
| `000d` | read, write | `ble_register_cmd_t` - raw register access |

All records are packed little-endian, which is what `DataView` with
`littleEndian=true` reads — note this is the *opposite* of the BTS I2C wire
format; nothing past `bts_link` sees the C2000's byte order.

`ble_proto.h` is the contract. `BLE_PROTO_VERSION` is **7**, published in the
unit-status record so a client can refuse to decode a firmware it does not
understand rather than silently misreading a struct. The interface is
**append-only**: a newer version adds characteristics and appends fields, so
every offset an older client decodes stays put and no characteristic is ever
renumbered - the discriminators are the client's contract.

| Version | What it added |
|---|---|
| 3 | The watchdog timeout on `ble_unit_status_t` (24 B), and the pause flags and six counters on `ble_slot_status_t` |
| 4 | Characteristic `000d`, raw register access - this is what lets a BLE client reach the C2000 mode register, and so charge and discharge, at all |
| 6 | The two CC/CV regulation flags at the end of the slot record (70 B) |
| 7 | The four pre-charge balance flags - waiting, balancing, ready, soft start (74 B) |

`tools/ble_verify.py` decodes every readable characteristic, checks the
version first, and fails rather than misreading a shorter record.

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
| GET | `/` | the setup page: unit state, WiFi and firmware update |
| GET | `/api/wifi` | station SSID, join state, addresses. Never the password |
| POST | `/api/wifi` | `{"ssid":"...","password":"..."}` |
| GET | `/api/ota` | running version and slot, trial state, whether a key is set |
| POST | `/api/ota/key` | `{"current":"...","key":"..."}` — set or change the update key |
| POST | `/api/ota` | raw `.bin` body, `X-OTA-Key` header — firmware update |
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

### Joining a network from the setup page

Join the `BTS-Tester` access point and browse to `http://192.168.4.1/`. The
WiFi card takes an SSID and password, saves them to flash and joins at once;
the AP stays up throughout, so a wrong password costs nothing but a retry.

After five failed joins the station stops retrying continuously. The ESP32
has one radio, so every attempt to find the saved network takes the AP off
its channel for a scan; a client notices the beacons stop, drops the AP and
takes its own time to rejoin. So the retry period depends on whether anyone
is on the AP:

| | Retry every | Measured, laptop on the AP, saved network absent |
|---|---|---|
| Nobody on the AP | **30 s** | — (nothing to disturb) |
| A client on the AP | **5 min** | page answered 44 of 48 probes over 4 min; the 4 misses were the first 20 s, before the backoff took hold |

A flat 30 s cadence, tried first, left the page unreachable for about 20 s of
every 35 — usable, but not for typing a password.

To stop it looking at all, **Forget network** on the setup page (or
`POST /api/wifi` with `{"ssid":""}`) erases the saved credentials; the AP is
then steady.

The password is write-only: `GET /api/wifi` never returns it, because anything
it returned would be readable by anyone in range of the open AP.

---

## Firmware update over WiFi

Two app slots, `ota_0` and `ota_1`. An upload is written into whichever is not
running, the boot slot is switched, and the proxy restarts into it.

**A new image is on trial until the BTS answers.** Rollback is enabled
(`CONFIG_BOOTLOADER_APP_ROLLBACK_ENABLE`), so the bootloader marks a freshly
written image `PENDING_VERIFY`. `components/ota` confirms it once the BTS link
completes a poll — real registers back over I2C, not merely "it booted". An
image that never gets there and is rebooted is **rolled back** to the previous
slot automatically.

That cannot be the only rule: the proxy has a backup cell and often runs with
the rack powered down, and an image that waited forever for the link would be
rolled back by the next power blip. So after **180 s** without a link it is
confirmed anyway, and the log says it was confirmed *without* the BTS. Such an
image is still on WiFi, so it can always be replaced by another upload.

### Doing an update

1. Set an update key once (uploads are refused until there is one):
   on the setup page, or
   `curl -X POST http://$BTS/api/ota/key -d '{"key":"choose-one"}'`.
2. Build as normal; the image is `build/bts_btle_proxy.bin`.
3. Upload it from the setup page, or:

   ```bash
   curl -X POST http://$BTS/api/ota -H "X-OTA-Key: choose-one" \n        --data-binary @build/bts_btle_proxy.bin
   ```

4. The proxy restarts. `GET /api/ota` shows `pending_verify: true` until the
   BTS answers, then `confirmed: true`.

The upload is checked before any of it is accepted: an image for another chip,
another ESP-IDF project, or not an app at all (a bootloader or partition table
posted by mistake) is refused from its first 288 bytes, before a megabyte goes
over the air. The whole image is then hash-checked before the boot slot moves.

**An update is refused while any slot is running** (`409`). The restart stops
every slot that is not paused — `test_engine_init()` has to, since a freshly
booted proxy cannot know what an unheld channel is doing — so an update in the
middle of a shift would end every test. Pause or finish them first, or add
`?force=1` to the URL if you mean it.

### What the key is, and is not

The key stops an accidental upload and casual access on a bench LAN. **It is
not a security boundary.** It is set through the same unauthenticated API
(trust on first use): the first set needs nothing, every later change needs the
current key. So it protects a unit provisioned before an attacker reached it,
and not one provisioned after. The rest of the API has no authentication at
all. If that matters on your network, the answer is the network.

### First flash after enabling rollback

Rollback changes the **bootloader**, not just the app. The first time, flash
everything over USB (`idf.py -p COM6 flash`), not just the app — an old
bootloader ignores the trial state, and every later OTA image would be
accepted without confirmation.

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
