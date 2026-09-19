# API Specification — HTTP and I2C

The two non-BLE interfaces of the eight-channel battery test system (BTS):

- **Part 1 — HTTP**, served by the ESP32 proxy on the LAN. The interface for
  a browser, for scripted integration, and for bulk retrieval of the result
  history.
- **Part 2 — I2C register map**, the ESP32's own link to the TI F2837xD, and
  the interface for any other host that wants to talk to the unit directly.

The BLE interface is in [`ble-specification.md`](ble-specification.md); the
calibration engineering contract is in
[`calibration-design.md`](calibration-design.md).

Everything here is read from source. Where the firmware declares something it
never writes, that is called out rather than glossed over.

---

## Read this first: the endianness split

> **HTTP carries JSON numbers — no byte order applies. The I2C register wire
> format is BIG-endian. The BLE records are LITTLE-endian.**
>
> The C2000 is a 16-bit-word machine whose `floatGetWireByte()`
> (`com_cpu2.c:2350-2355`) emits a float most-significant byte first. The
> conversion happens in `bts_regs.h` (`bts_wire_to_f32()` /
> `bts_f32_to_wire()`), and nothing above `bts_link` — not the HTTP layer,
> not BLE — ever sees the C2000's byte order.
>
> If you are writing an I2C client of your own, this is the single detail
> most likely to cost you an afternoon, alongside the lead-in pad byte in
> §2.3. Use a shift-and-OR through a `uint32_t`, not a `memcpy` of a float:
> the helpers in `bts_regs.h` are written that way precisely so they are
> correct regardless of the host's own byte order.

---

# Part 1 — HTTP API

Implemented in `esp32-btle-proxy/components/web_api/web_api.c` on
`esp_http_server`.

| | |
|---|---|
| **Port** | 80 (`web_api_config_t.port`, 0 → 80) |
| **Content type** | `application/json` on every response |
| **Endpoints** | 26 (see §1.1) |
| **Route table entries** | 15 (`s_routes[]`, `web_api.c:1122-1142`) |
| **Authentication** | **None** |
| **Encryption** | **None** — plain HTTP |
| **Network** | WiFi station, with SoftAP fallback (`BTS-Tester`, open) if no credentials are stored or the join fails |

There is no captive portal and no login. A tester that cannot be talked to
because someone changed the WiFi password is worse than an open AP on a bench
network — but do not put this device on an untrusted one.

## 1. Endpoints

### 1.1 Summary

| # | Method | URI | Purpose |
|---|---|---|---|
| 1 | GET | `/api/status` | Unit plus all eight slots |
| 2 | GET | `/api/slot/<n>` | One slot, with its resolved profile and last result |
| 3 | GET | `/api/slot/<n>/result` | That slot's latest result alone |
| 4 | POST | `/api/slot/<n>/config` | Set slot configuration; every field optional |
| 5 | POST | `/api/slot/<n>/serial` | Set the slot's serial/barcode |
| 6 | POST | `/api/slot/<n>/start` | Start the test |
| 7 | POST | `/api/slot/<n>/abort` | Abort the test |
| 8 | POST | `/api/slot/<n>/clear` | Clear the slot's fault |
| 9 | POST | `/api/abort_all` | Abort every slot |
| 10 | GET | `/api/results` | Paged result history across all slots |
| 11 | GET | `/api/catalog` | Chemistries and cell models |
| 12 | POST | `/api/chemistry/<name>` | Override a chemistry profile, persisted to NVS |
| 13 | POST | `/api/wifi` | Store station credentials |
| 14 | GET | `/api/registers` | Raw BTS register block read |
| 15 | POST | `/api/registers` | Raw BTS register write |
| 16 | GET | `/api/i2c_diag` | Bus-level I2C diagnostic |
| 17 | GET | `/api/calibration` | Full calibration state, telemetry and persisted gains |
| 18 | POST | `/api/calibration/enter` | `CAL_CMD_ENTER` |
| 19 | POST | `/api/calibration/exit` | `CAL_CMD_EXIT` |
| 20 | POST | `/api/calibration/clear` | `CAL_CMD_CLEAR` |
| 21 | POST | `/api/calibration/voltage` | `CAL_CMD_CAPTURE_VOLTAGE` |
| 22 | POST | `/api/calibration/zero_current` | `CAL_CMD_ZERO_CURRENT` |
| 23 | POST | `/api/calibration/fixed_current` | `CAL_CMD_SET_FIXED_CURRENT` |
| 24 | POST | `/api/calibration/current` | `CAL_CMD_CAPTURE_CURRENT` |
| 25 | POST | `/api/calibration/save` | `CAL_CMD_COMPUTE_SAVE` |
| 26 | OPTIONS | `/*` | CORS preflight |

`<n>` is a **0-based** slot index, 0 to 7. Front-panel slot 3 is
`/api/slot/2`.

### 1.2 Common response shapes

**Success with no payload** — `send_ok()`:

```json
{"ok":true}
```

**Error** — `send_error()`, on every 4xx and 5xx it raises:

```json
{"ok":false,"error":"human-readable reason"}
```

> **One error path does not follow the pattern.** If a response overflows the
> 6144-byte buffer, `send_json()` emits `500 Internal Server Error` with the
> body `{"error":"response too large"}` — no `"ok"` key — **and it does not
> set the CORS header** (`web_api.c:43-48`). A browser sees an opaque network
> failure rather than the 500. This is reachable in practice only on
> `/api/slot/<n>`, which is the largest non-chunked response.

Numbers are emitted with a fixed number of decimals by `json_kv_f()`; the
tables below give the precision where it matters.

---

### 1.3 `GET /api/status`

Unit state plus every slot. **Chunked** — the response grows with the number
of configured slots and exceeds the buffer at eight, so it is flushed between
array elements.

Query parameters: none.

```json
{
  "unit": {
    "online": true,
    "unit_state": 2,
    "input_voltage_v": 12.041,
    "trip_status": 0,
    "consecutive_errors": 0,
    "slots": 8,
    "max_current_a": 10.0,
    "max_voltage_v": 5.0,
    "bts_accumulators_live": false,
    "uptime_s": 4211,
    "wifi_sta": true,
    "wifi_ap": false
  },
  "slots": [ { /* see below */ } ]
}
```

| Key | Type | Meaning |
|---|---|---|
| `unit.online` | bool | The last I2C poll cycle to the BTS completed |
| `unit.unit_state` | 0–4 | See §1.3.1 |
| `unit.input_voltage_v` | float, 3 dp | DC input bus, register 984 |
| `unit.trip_status` | uint32 | Two bits per channel. **Always 0** — see §2.7 |
| `unit.consecutive_errors` | uint32 | Failed poll cycles in a row; 0 when healthy |
| `unit.slots` | int | 8 |
| `unit.max_current_a` | float, 1 dp | 10.0, the unit envelope from `BTS_CMPSS_FULLSCALE_A` |
| `unit.max_voltage_v` | float, 1 dp | 5.0, the per-channel output range |
| `unit.bts_accumulators_live` | bool | **Always false** — see §2.6 |
| `unit.uptime_s` | uint32 | ESP32 uptime, not a wall clock |
| `unit.wifi_sta` / `wifi_ap` | bool | Station joined / SoftAP active |

Each element of `slots`:

| Key | Type | Meaning |
|---|---|---|
| `slot` | 0–7 | Slot index |
| `state` | string | `IDLE`, `CHECK_REST`, `CHARGE`, `REST`, `DISCHARGE`, `DISCHARGE_REST`, `RECHARGE`, `COMPLETE`, `FAULT`, `ABORTED` |
| `fault` | string | `NONE`, `OVER_TEMP`, `UNDER_TEMP`, `OVER_CURRENT`, `CMPSS_TRIP`, `GPIO_TRIP`, `TIMEOUT`, `BTS_OFFLINE`, `UNIT_STATE`, `NO_CELL`, `CELL_REVERSED`, `COMMS` |
| `configured` | bool | A cell profile has been applied |
| `voltage_v` | float, 3 dp | Cell volts, **12-bit internal ADC** (register `eChX_CellVoltage`) |
| `current_a` | float, 3 dp | Cell amps, same path. Negative = discharge |
| `temp_c` | float, 1 dp | Cell temperature, from the ADS1119 converters |
| `live_mah` / `live_mwh` | float, 1 dp | ESP32-integrated charge and energy for the current phase |
| `progress` | float, 3 dp | 0..1 and beyond |
| `elapsed_s`, `state_elapsed_s` | uint32 | Seconds since test start / state entry |
| `bts_status` | uint32 | Raw BTS status word, see §2.7 |
| `serial` | string | The slot's serial, possibly empty |
| `config` | object | Present **only when `configured`** |
| `profile` | object | Present only when `configured`; the resolved envelope after clamping |

`last_result` is **omitted** from this endpoint to keep the poll response
small. Fetch it from `/api/slot/<n>` or `/api/results`.

`config`: `chemistry`, `model`, `capacity_mah` (0 dp), `charge_c` /
`discharge_c` (2 dp), `auto_recharge_to_shipping`, `shipping_pct` (1 dp),
`max_duration_minutes`.

`profile`: `chemistry`, `model`, `capacity_mah`, `charge_v_max`,
`discharge_v_min`, `storage_v`, `charge_current_a`, `discharge_current_a`,
`charge_term_current_a`, `temp_min_c`, `temp_max_c`, `rest_tolerance_pct`,
`rest_minutes`.

Status: `200` always. A BTS that is offline shows as `unit.online: false`,
not as an HTTP error.

#### 1.3.1 `unit_state`

| Value | Meaning |
|---|---|
| 0 | `INPUT_LOW_CHARGE_DISABLED` — input below `eChargeDisableV` (default 9.0 V). **No slot will start.** |
| 1 | `INPUT_LOW_CHARGE_RESTRICTED` — below `eChargeRestrictV` (default 10.0 V); charge refused |
| 2 | `INPUT_OK` |
| 3 | `INPUT_HIGH_DISCHARGE_RESTRICTED` — above `eDischargeRestrictV` (default 15.0 V); discharge refused |
| 4 | `INPUT_HIGH_DISCHARGE_DISABLED` — above `eDischargeDisableV` (default 16.0 V) |

---

### 1.4 `GET /api/slot/<n>`

One slot. Same object as a `/api/status` array element, **plus**
`last_result` (the same shape as `result` in §1.6). Not chunked.

| Status | When |
|---|---|
| `200` | OK |
| `404` | `{"ok":false,"error":"bad slot"}` — the segment is missing, non-numeric, or ≥ 8 |
| `500` | Response exceeded the buffer — see the caveat in §1.2 |

---

### 1.5 `POST /api/slot/<n>/config`

Every field is optional. **The handler starts from the slot's current
configuration**, so a body of `{"serial":"ABC123"}` changes the serial and
nothing else — it does not reset the chemistry (`web_api.c:405-412`).

| Field | Type | Validation |
|---|---|---|
| `chemistry` | string | One of `LCO`, `LTO`, `LFP`, `NMC`, `NCA`, case-insensitive. Unknown → 400 |
| `model` | string | Must match a catalogue model, or be `""`. Unknown → 400; longer than 23 chars → 400 |
| `serial` | string | ≤ 31 chars. **Rejected, not truncated**, if longer — a half-written barcode on a test record looks like a genuine serial |
| `capacity_mah` | number | 0 → the model's default |
| `charge_c` | number | C-rate; 0 → the chemistry's default |
| `discharge_c` | number | C-rate; 0 → the chemistry's default |
| `shipping_pct` | number | Must be `> 0` and `<= 100`, else 400. `<= 0` after merge → 60.0 |
| `max_duration_minutes` | number | Cast to `uint32`. 0 → no limit |
| `auto_recharge_to_shipping` | bool | |

**Response:** the slot object (as in §1.3, without `last_result`) so the
client sees the **resolved** profile rather than what it asked for. The
profile is clamped to the unit envelope — 10 A and 5 V — before it reaches
the power stage.

| Status | When |
|---|---|
| `200` | Applied; body is the slot object |
| `400` | Body larger than 1024 bytes, or a validation failure above |
| `404` | Bad slot |
| `409` | `{"ok":false,"error":"slot is running"}` |

---

### 1.6 `POST /api/slot/<n>/serial`

```json
{"serial": "ABC123456"}
```

| Status | When |
|---|---|
| `200` | `{"ok":true}` |
| `400` | Missing body, or no `serial` key |
| `404` | Bad slot |
| `500` | `test_engine_set_serial()` failed |

### `GET /api/slot/<n>/result`

```json
{
  "slot": 2,
  "result": {
    "valid": true,
    "serial": "ABC123456",
    "model": "30Q",
    "chemistry": "NMC",
    "start_voltage_v": 4.198,
    "end_voltage_v": 2.502,
    "rested_voltage_v": 3.114,
    "discharge_mah": 2941.3,
    "discharge_mwh": 10284.7,
    "max_temp_c": 38.2,
    "max_current_a": 3.000,
    "min_voltage_v": 2.498,
    "max_voltage_v": 4.201,
    "discharge_seconds": 3529,
    "recharged": true,
    "recharge_mah": 1764.0,
    "shipping_voltage_v": 3.712,
    "bts_raw": {"live": true, "discharge_mah": 3481.2, "discharge_mwh": 12208.6,
                "charge_mah": 1771.4, "charge_mwh": 6537.0},
    "completed_uptime_s": 21480
  }
}
```

When no result is stored, `result` is `{"valid":false}` and nothing else.

> **`completed_uptime_s` is ESP32 uptime in seconds, not a Unix epoch.** The
> device has no real-time clock (`test_engine.c:366`). The BLE record calls
> the same value `completed_unix`, which is a misnomer; this endpoint's name
> is the honest one. Apply a wall-clock timestamp at the moment you retrieve
> the result.

`bts_raw` is the unit's own accumulators, reported so a comparison against
the ESP32's integration is possible without a firmware change. `live` is
**always false** and both values are **always 0.000** — see §2.6.

---

### 1.7 `POST /api/slot/<n>/start` · `/abort` · `/clear`

No body. All three return `{"ok":true}` on success.

| Action | Calls |
|---|---|
| `/start` | `test_engine_start(n)` |
| `/abort` | `test_engine_abort(n)` |
| `/clear` | `test_engine_clear_fault(n)` |

| Status | When |
|---|---|
| `200` | Accepted |
| `404` | Bad slot, or an unrecognised action segment |
| `409` | `"slot not startable - configure it, or clear its fault"` |
| `500` | Any other engine error, with the `esp_err_t` name as the message |

> **The action is matched with `strstr()`, not by exact segment**
> (`web_api.c:1089-1092`). `/api/slot/2/start` and
> `/api/slot/2/please_start_now` both hit `/start`. The first match in the
> order **config → serial → start/abort/clear** wins, so a URI containing
> two of these words dispatches to whichever appears first in that list, not
> in the URI.

### `POST /api/abort_all`

No body, no failure path. Always `200 {"ok":true}`.

---

### 1.8 `GET /api/results`

Paged history across every slot, newest-first as `result_store` holds it.
**Chunked.**

| Query | Default | Range |
|---|---|---|
| `offset` | 0 | any `uint32` |
| `limit` | 10 | **clamped to 10**; 0 or > 10 also becomes 10 |

```json
{
  "total": 47,
  "offset": 0,
  "results": [ {"index": 0, "result": { /* as §1.6 */ }} ]
}
```

The array stops early when `result_store_history_at()` runs out, so a page
past the end returns `results: []` with `total` still correct. Status: `200`.

> Query parsing is best-effort. The whole query string must fit in 95 bytes
> and each value in 15, or `query_u32()` **silently returns the default**
> (`web_api.c:193-204`). Values are parsed with `strtoul`, so `limit=abc`
> reads as 0 and becomes 10.

---

### 1.9 `GET /api/catalog`

Every chemistry and cell model the firmware knows. **Chunked.** No query
parameters. Status: `200`.

```json
{
  "chemistries": [
    {"name":"NMC","nominal_v":3.70,"charge_v_max":4.200,
     "discharge_v_min":2.500,"storage_v":3.700,"default_charge_c":0.50,
     "default_discharge_c":1.00,"charge_term_c":0.050,"temp_min_c":0.0,
     "temp_max_c":45.0,"rest_tolerance_pct":1.0,"rest_minutes":30}
  ],
  "models": [
    {"name":"30Q","manufacturer":"Samsung","chemistry":"NMC",
     "capacity_mah":3000,"charge_current_max_a":4.00,
     "discharge_current_max_a":15.00}
  ]
}
```

This build ships 5 chemistries (LCO, LTO, LFP, NMC, NCA) and 9 models
(Samsung 20Q/25R/30Q/30R, Sony VTC3/VTC4/VTC5/VTC5A/VTC6).

---

### 1.10 `POST /api/chemistry/<name>`

Overrides a chemistry profile and persists it to NVS. `<name>` is matched
case-insensitively against the chemistry names above.

Every field optional; what is not supplied keeps its current value, so a
client can nudge one cutoff without restating the envelope.

`nominal_v`, `charge_v_max`, `discharge_v_min`, `storage_v`,
`default_charge_c`, `default_discharge_c`, `charge_term_c`, `temp_min_c`,
`temp_max_c`, `rest_tolerance_pct`, `rest_minutes`.

Sanity-checked **after** the merge; all of these must hold or the whole
request is rejected with 400 `"profile fails sanity check"`:

- `charge_v_max > discharge_v_min`
- `charge_v_max <= 5.0` (`BTS_UNIT_MAX_VOLTAGE_V`)
- `discharge_v_min >= 0.0`
- `temp_max_c > temp_min_c`
- `default_charge_c > 0.0` and `default_discharge_c > 0.0`

| Status | When |
|---|---|
| `200` | `{"ok":true}` |
| `400` | Missing body, or the sanity check failed |
| `404` | Missing or unknown chemistry name |
| `500` | NVS write failed, or the chemistry has no profile |

> The name is taken with `strrchr(uri, '/')` — the **last** path segment, not
> a wildcard capture. `/api/chemistry/foo/NMC` resolves to `NMC`.

---

### 1.11 `POST /api/wifi`

```json
{"ssid": "bench-net", "password": "..."}
```

`password` is optional (omit for an open network); `ssid` is required.
Limits: SSID 32 chars, password 64. Stored in the default NVS partition under
the `wifi` namespace, then the station reconnects.

| Status | When |
|---|---|
| `200` | `{"ok":true}` |
| `400` | Missing body, or missing `ssid` |
| `500` | NVS save failed |

---

### 1.12 `GET /api/registers`

Raw register block read. For bring-up and for verifying block strides against
a live unit; **not part of the control surface**.

| Query | Default | Behaviour |
|---|---|---|
| `addr` | 0 | Byte address. Must be a multiple of 4, else 400 |
| `count` | 8 | Registers to read. 0 or > 32 → **clamped to 32**, not an error |

```json
{"addr":592,"count":12,"ok":true,
 "values":[1.0000,0.0000,1.0000,0.0000,0.1002,0.0013,9.9800,-0.0130,
           0.2029,0.0011,4.9285,-0.0054]}
```

| Status | When |
|---|---|
| `200`, `ok: true` | Values present |
| `200`, `ok: false` | **The I2C read failed.** `error` holds the `esp_err_t` name; no `values` array |
| `400` | `addr` is not a multiple of 4 |

> **Two traps here.**
>
> 1. **A failed read returns HTTP 200.** A client that checks only the status
>    code will treat a dead I2C bus as a successful empty response. Check the
>    `ok` key.
> 2. **`addr` is not range-checked.** It is cast to `uint16_t` and sent as-is
>    (`web_api.c:740`), unlike the POST below, which does bound it. An
>    address past the top of the map returns `-1.0000` for every register —
>    that is the target's own out-of-range sentinel (`com_cpu2.c:2527`), not
>    a real reading. A burst that runs off the end repeats the last register
>    rather than wrapping (§2.4).

The read is a **single I2C transaction** regardless of `count`, using the
target's auto-increment.

---

### 1.13 `POST /api/registers`

Generic register write, the mirror of the read above.

```json
{"addr": 1044, "value": 0.84968}
```

Both keys are required.

| Status | When |
|---|---|
| `200` | `{"ok":true}` |
| `400` | Missing body, missing `addr` or `value`, `addr` out of range, or `addr % 4 != 0` |
| `502` | The I2C write failed; the message is the `esp_err_t` name |

Range is `0` to `(BTS_TOTAL_REGISTERS - 1) * 4` = **1216** inclusive.

> **Deliberately unguarded beyond the address checks.** This is the escape
> hatch for bring-up and for anything the typed endpoints do not cover
> (`web_api.c:762-768`). The unit enforces its own RW access list per
> register — but it does so **silently**: a write to a read-only register is
> dropped by the target with no NAK and no error, so this endpoint returns
> `{"ok":true}` for a write that did nothing (§2.5).
>
> There is also no readback. A `200` means the bytes reached the bus, not
> that the register changed.
>
> Driving calibration through this endpoint bypasses the argument
> sanitisation the typed endpoints apply. In particular
> `bts_link_cal_capture_current()` takes `fabsf()` of the measured amps
> (`bts_link.c:330`); writing a signed value straight into `eCalArgument`
> (1044) does not get that, and a negative current capture inverts the slot's
> stored gain in a way that passes validation and looks plausible
> afterwards.

---

### 1.14 `GET /api/i2c_diag`

Bus-level diagnostic, for bring-up. Separates the two failure modes that both
surface as a bare `ESP_ERR_TIMEOUT` through `/api/registers`.

```json
{"sda_high":true,"scl_high":true,"expected_addr":80,"targets_found":1,
 "addresses":[80],"verdict":"bus healthy"}
```

| Key | Meaning |
|---|---|
| `sda_high` / `scl_high` | The line read as a plain input. Both must idle high |
| `expected_addr` | 80 decimal = `0x50` |
| `targets_found` | Devices that answered a probe across `0x08`–`0x77` |
| `addresses` | Up to 16 responding addresses, **decimal** |
| `verdict` | One of the three strings below |

| Verdict | Meaning |
|---|---|
| `"a bus line is stuck low - check pull-ups and wiring"` | No transfer can work until this is fixed. The scan is skipped — probing a stuck bus produces 128 timeouts and takes half a minute |
| `"bus idle but no target answered - check address, power, or whether SDA and SCL are swapped"` | Wiring is sane, nothing is answering |
| `"bus healthy"` | At least one target responded |

Status: `200`. A full scan takes a few seconds and holds the bus mutex, so
the poll task stalls for the duration.

---

### 1.15 `GET /api/calibration`

Full calibration state: the live telemetry window, the capture flags broken
out, the persisted-validity ticks, and the selected slot's stored gains.

```json
{
  "calibration": {
    "active": true,
    "slot": 2,
    "status": 7,
    "result": 0,
    "result_text": "ok",
    "captures": {
      "voltage_low": true, "voltage_high": true,
      "current_zero": false, "current_loaded": false,
      "voltage_computed": false, "current_computed": false,
      "saved": false, "driving": false, "failed": false
    },
    "live": {
      "ads_v_pu": 0.86312, "ads_i_pu": 0.00004,
      "ads_v_v": 4.24991, "ads_i_a": 0.0004,
      "f28_v_pu": 1.70021, "f28_i_pu": 0.00011,
      "f28_v_v": 4.24973, "f28_i_a": 0.0005,
      "temp_c": 23.4
    },
    "ticks": {"voltage_valid": false, "current_valid": false}
  },
  "gains": {
    "f28v_gain": 1.000000, "f28v_offset": 0.000000,
    "f28i_gain": 1.000000, "f28i_offset": 0.000000,
    "iout_gain_pu": 0.100200, "iout_offset_pu": 0.001300,
    "iout_gain_a": 9.980040, "iout_offset_a": -0.012974,
    "vout_gain_pu": 0.202900, "vout_offset_pu": 0.001100,
    "vout_gain_v": 4.928536, "vout_offset_v": -0.005421
  }
}
```

| Key | Meaning |
|---|---|
| `active` | `eCalStatus` bit 0 |
| `slot` | Slot under calibration; **255 when none** |
| `status` | The raw `eCalStatus` bitfield, §1.16.2 |
| `result` / `result_text` | `eCalResult` of the last command and its text, §1.16.3 |
| `captures.*` | The status bits broken out, so a client need not carry its own copy of the numbering |
| `live.*` | Registers 1056–1088. `_pu` is the raw **pre-gain** reading; `_v`/`_a` are post-gain. 5 dp on the pu values, 4 dp on the engineering values, 1 dp on the temperature |
| `ticks.*` | Slot status bits 13/14 — the **persisted** validity, so a slot calibrated last month still shows its ticks |
| `gains` | The selected slot's 12-register calibration block, read live from 592 + slot×48. **Omitted** when `slot` is 255 or the read fails |

Status: `200` always. `live.*` holds its last values when calibration is not
active — `active` is what tells them apart.

> **Freshness.** The `bts_link` poll task reads the 1036–1088 window as one
> burst, but **only** while calibration is active or a command has just been
> issued (`bts_link.c:504-519`). The cycle is 250 ms. Reading this endpoint
> immediately after a POST can return the pre-command state; allow one poll
> interval.

---

### 1.16 `POST /api/calibration/<action>`

Eight actions, all of which map one-to-one onto the opcodes in
[`calibration-design.md`](calibration-design.md) §5.

| URI | Opcode | Body | Argument |
|---|---|---|---|
| `/api/calibration/enter` | 1 `ENTER` | `{"slot": 0-7}` | required |
| `/api/calibration/exit` | 2 `EXIT` | none | — |
| `/api/calibration/voltage` | 3 `CAPTURE_VOLTAGE` | `{"measured_v": <float>}` | required |
| `/api/calibration/zero_current` | 4 `ZERO_CURRENT` | none | — |
| `/api/calibration/fixed_current` | 5 `SET_FIXED_CURRENT` | `{"pu": 0.0-0.8}` | required |
| `/api/calibration/current` | 6 `CAPTURE_CURRENT` | `{"measured_a": <float>}` | required, **magnitude** |
| `/api/calibration/save` | 7 `COMPUTE_SAVE` | none | — |
| `/api/calibration/clear` | 8 `CLEAR` | none | — |

The four no-argument actions ignore the body entirely; send `{}` or nothing.

Every action returns `{"ok":true}` on success and the mapping below on
failure (`send_cal_result()`, `web_api.c:886-898`):

| Status | When |
|---|---|
| `200` | Accepted, `eCalResult == 0` |
| `400` | Missing or unparseable argument; `slot` outside 0–7; `pu` outside 0.0–0.8 (`ESP_ERR_INVALID_ARG` → `"argument out of range"`) |
| `404` | Missing or unknown action segment |
| `409` | **The unit refused.** The message is the `eCalResult` text |
| `502` | I2C transport failure; the message is the `esp_err_t` name |

> **409 is the interesting one.** It means the command reached the BTS and
> the BTS said no. The nine reasons are in §1.16.3 and each has a specific
> remedy in [`README.md`](README.md)'s troubleshooting table. Do not retry a
> 409 — a refusal will be refused again.

`measured_a` is passed through `fabsf()` before it reaches the wire. The
firmware applies the discharge sign itself; entering a signed value is the
single easiest way to invert a slot's current reading permanently.

`pu` is checked twice: the ESP32 rejects `< 0.0` or `> 0.8` before anything
goes on the bus (`bts_link.c:320-322`), and the unit clamps again. 1.0 pu ≈
10 A, so 0.8 is about 8 A.

#### 1.16.1 The three-write sequence

Each action is **three I2C transactions under one take of the bus mutex**
(`cal_command()`, `bts_link.c:242-277`):

1. write `eCalArgument` (1044)
2. write `eCalCommand` (1040)
3. read `eCalResult` (1052)

They cannot be interleaved with the poll task or another caller, because the
opcode is **consumed on write and self-clears** — an argument that arrived
afterwards would be applied to nothing. `enter` writes `eCalSlot` (1036)
first, as a fourth transaction outside that group.

#### 1.16.2 `status` bitfield (`eCalStatus`)

| Bit | Mask | `captures` key | Meaning |
|---|---|---|---|
| 0 | `0x001` | (`active`) | Calibration active |
| 1 | `0x002` | `voltage_low` | Voltage low point captured |
| 2 | `0x004` | `voltage_high` | Voltage high point captured |
| 3 | `0x008` | `current_zero` | Current zero point captured |
| 4 | `0x010` | `current_loaded` | Current loaded point captured |
| 5 | `0x020` | `voltage_computed` | Voltage calibration computed and valid |
| 6 | `0x040` | `current_computed` | Current calibration computed and valid |
| 7 | `0x080` | `saved` | Written to F-RAM |
| 8 | `0x100` | `driving` | Fixed-current mode currently driving |
| 9 | `0x200` | `failed` | Last command failed — read `result` |

Bit 7 is owned by CPU2, which performs the F-RAM write from its idle loop and
never from an ISR, and is OR-ed back over whatever CPU1 published
(`com_cpu2.c:2046-2048`). Any new command clears it
(`com_cpu2.c:2180-2183`), so bit 7 always refers to the most recent `save`.

#### 1.16.3 `result` codes (`eCalResult`)

| Code | `result_text` | Meaning |
|---|---|---|
| 0 | `ok` | Accepted |
| 1 | `another slot is calibrating` | One slot at a time |
| 2 | `slot is running a test` | Stop it — `POST /api/abort_all` |
| 3 | `slot disabled or not a group leader` | ENABLE strap masks it off, or it follows a lower-numbered leader |
| 4 | `pu outside the required window` | The reading is between 0.2 and 0.8; the firmware cannot tell which point you meant |
| 5 | `insufficient captures` | Voltage needs both points; current needs the zero plus one loaded point |
| 6 | `computed gain failed validation` | Almost always a wiring error |
| 7 | `F-RAM write failed` | Check the I2C bus: `GET /api/i2c_diag` |
| 8 | `argument out of range` | |
| 9 | `not in the calibration state` | Issue `enter` first |
| other | `unknown` | |

---

## 2 (Part 1). Route ordering — do not "tidy" this

`esp_http_server` is configured with
`cfg.uri_match_fn = httpd_uri_match_wildcard`, and that matcher **honours
only a TRAILING asterisk**. A pattern with the wildcard anywhere else does
not match the way it reads: the matcher compares the literal prefix up to the
asterisk and then accepts any tail.

Two consequences shape the whole route table.

### The first matching pattern wins

`httpd_register_uri_handler()` appends, and dispatch takes the **first
registered pattern that matches**. So every exact path must be registered
**before** any wildcard that would also match it.

In `s_routes[]` (`web_api.c:1122-1142`) that ordering is:

```
/api/status            GET     exact
/api/catalog           GET     exact
/api/results           GET     exact
/api/registers         GET     exact
/api/registers         POST    exact
/api/calibration       GET     exact     <-- BEFORE /api/calibration/*
/api/i2c_diag          GET     exact
/api/abort_all         POST    exact
/api/wifi              POST    exact
/api/chemistry/*       POST    wildcard
/api/calibration/*     POST    wildcard
/api/slot/*            POST    wildcard
/api/slot/*            GET     wildcard
/*                     OPTIONS wildcard  <-- last
```

Move `GET /api/calibration` below `POST /api/calibration/*` and the exact
path still works only because the methods differ. Move `/*` anywhere but
last and it would swallow every OPTIONS request that a more specific pattern
should have handled. **Neither of these is a style choice.**

### Per-action dispatch is manual, and has to be

A pattern like `/api/slot/*/config` **never matches**, because the asterisk
is not trailing — the matcher takes `/api/slot/` as the literal prefix and
accepts anything after it. Registering the per-action patterns individually
therefore does not work: they all collapse onto the `/api/slot/` prefix and
whichever was registered first wins every request.

> **This is not hypothetical.** It is what made a config POST return 405: the
> GET pattern matched it first (`web_api.c:1057-1072`).

So **one pattern is registered per method** and the trailing segment is
dispatched in C:

| Dispatcher | Registered pattern | Picks on |
|---|---|---|
| `h_slot_get_dispatch` | `GET /api/slot/*` | `strstr(uri, "/result")` → result, else the slot object |
| `h_slot_post_dispatch` | `POST /api/slot/*` | `strstr` for `/config`, `/serial`, then `/start`\|`/abort`\|`/clear`, in that order |
| `h_cal_post_dispatch` | `POST /api/calibration/*` | `strcmp` on the **last** segment, via `strrchr(uri, '/')` |

The slot number is parsed out of the URI by each handler itself
(`slot_from_uri()`, `web_api.c:178-190`), which looks for `/slot/` and
`atoi`s what follows, returning −1 for anything missing or ≥ 8. So every
handler has one check rather than trusting a wildcard match.

Note the two dispatchers differ in strictness: the calibration one uses
`strcmp` on the final segment and so is **exact**, while the slot one uses
`strstr` over the whole URI and so is **substring** (see §1.7).

**If you refactor this file:** keep the exact paths above the wildcards, keep
`/*` last, and do not replace the manual dispatch with mid-path wildcards.
They will compile, register without error, and route everything to the wrong
handler.

---

## 3 (Part 1). CORS

The tester is a LAN appliance and its web UI is served from elsewhere — a
local file, or a dev server — so a browser reaching it cross-origin is the
normal case rather than the exception (`web_api.c:50-55`).

| Response path | `Access-Control-Allow-Origin: *` |
|---|---|
| `send_json()` success | yes |
| `send_json()` 500 "response too large" | **no** — see §1.2 |
| `chunk_begin()` (status, results, catalog) | yes, set before the first chunk |
| `send_error()` — every 4xx and 5xx it raises | yes |
| `h_options()` preflight | yes |

Preflight, `OPTIONS /*` → `204 No Content` with:

```
Access-Control-Allow-Origin: *
Access-Control-Allow-Methods: GET, POST, OPTIONS
Access-Control-Allow-Headers: Content-Type
```

There is no `Access-Control-Max-Age`, so browsers apply their own default and
will re-preflight regularly. Credentials are not allowed (`*` cannot be
combined with `Access-Control-Allow-Credentials`), which is moot — there is
no authentication.

---

# Part 2 — I2C register map

The BTS is an **I2C target** exposing a flat array of 305 IEEE-754 `float32`
registers. This is the interface the ESP32 proxy uses
(`components/bts_link/`), and it is available to any other host on the same
bus.

| | |
|---|---|
| **Bus** | I2CA on the F2837xD (`com_cpu2.c:298-301`) |
| **Target address** | `0x50`, 7-bit (`BTS_I2C_TARGET_ADDRESS`) |
| **Bus speed** | **50 kHz** — see §2.2 |
| **Register size** | 4 bytes, always |
| **Register count** | 305 (`TOTAL_REGISTERS`) |
| **Address space** | Byte addresses 0 to 1216 inclusive, always a multiple of 4 |
| **Index** | `index = address / 4` |
| **Payload byte order** | **Big-endian** |

> `0x50` is also the address of the FM24V10 F-RAM — but that part is on
> **I2CB**, a separate bus that the C2000 owns as controller
> (`com_cpu2.c:340-347`). The two never collide.

---

## 2.1 Transaction shapes

### Write

```
S  0x50+W  addrHi  addrLo  b0 b1 b2 b3  [b0 b1 b2 b3 ...]  P
```

The two address bytes are the **byte** address, big-endian. The four payload
bytes are the float, big-endian.

A burst write continues into the next register without re-sending the
address: after four data bytes the target's ISR resets its byte counter and
advances `currentRegAddr` by 4 (`com_cpu2.c:2566-2578`). **Do not resend the
address** between registers of a burst.

### Read

```
S  0x50+W  addrHi  addrLo  Sr  0x50+R  PAD  b0 b1 b2 b3  [b0 b1 b2 b3 ...]  P
```

A read is addressed **twice** — write the address, then a repeated start to
read — and the register address has to survive the repeated start in between.
Most of the target's state handling exists to protect that one requirement
(`com_cpu2.c:2358-2375`).

A burst read continues into the next register on the same terms.

---

## 2.2 Bus speed

**50 kHz.** `i2c_device_config_t.scl_speed_hz` is hard-coded to `50000`
(`bts_link.c:708`), which **overrides** the 100000 that `main.c` passes in
`bts_link_config_t.scl_speed_hz`. That configured value reaches only the
bring-up probe list, where it is logged but never applied — the probe loop's
`hz` field is not a bus-config field at all
(`bts_link.c:641-652, 669-679`).

> The comment above that line used to say "100 kHz" and has been corrected to
> match the code. The C2000 target's ISR does a fair amount of work per byte
> and the bus runs over a ribbon to the BTS board with 10 kΩ pull-ups, which
> is weak — the rise time may not make it inside a bit period even though the
> idle level reads high. 50 kHz is the conservative value that works.

The ESP32 enables its **internal** pull-ups in addition to the board's. Your
own client should assume the bus is marginal and start slow.

---

## 2.3 The lead-in pad byte

> ### A read must fetch `1 + count × 4` bytes and discard the first.
>
> The C2000 target starts clocking data out the instant it acknowledges the
> repeated start, which is before its interrupt can possibly be serviced.
> Whatever its transmit register happens to hold at that moment goes onto the
> wire **first**, so every reply is preceded by one byte of padding.
>
> That is a property of the peripheral, not a bug that can be fixed on the
> target (`bts_link.c:67-77`).
>
> **A client that omits this gets shifted garbage** — not an obvious failure,
> but every float assembled from three bytes of one register and one byte of
> the next. The values are plausible-looking nonsense, and on a
> control-surface register the consequences are worse than nonsense.

```c
uint8_t rx[1 + count * 4];
i2c_master_transmit_receive(dev, addr_buf, 2, rx, 1 + count * 4, timeout);

for (size_t i = 0; i < count; i++) {
    out[i] = bts_wire_to_f32(&rx[1 + i * 4]);   /* note the 1 + */
}
```

In Python with SMBus/`i2c_msg`:

```python
w = i2c_msg.write(0x50, [addr >> 8, addr & 0xFF])
r = i2c_msg.read(0x50, 1 + count * 4)           # the 1 is the pad
bus.i2c_rdwr(w, r)
data = bytes(r)[1:]                             # drop it
values = [struct.unpack(">f", data[i*4:i*4+4])[0] for i in range(count)]
```

The pad is **one byte per transaction**, not per register. A burst of 14
registers reads 57 bytes and discards exactly one.

> The `WIRE FORMAT` comment at the top of `bts_regs.h` (lines 10–24) shows
> the read shape **without** the pad byte, and is the one place in the tree
> that contradicts this. `bus_read_block()` is what actually runs; follow it.

---

## 2.4 Auto-increment

Both directions auto-increment by 4 **after a complete register**, so a burst
over a whole block is a single transaction.

The increment is **bounded, and it does not wrap**:

```c
if (((currentRegAddr + 4U) / 4U) < TOTAL_REGISTERS) {
    currentRegAddr += 4U;
}
```

At the top of the map (address 1216) the pointer stops advancing, and a read
that continues past it **repeats register 1216** indefinitely. Unbounded it
would walk off the end and stay there — and since the address persists across
transactions, every later read would return out of range
(`com_cpu2.c:2570-2577`).

The address also **persists between transactions**. A read with no preceding
address write continues from wherever the last one left off. Always write the
address.

A read of an index at or beyond `TOTAL_REGISTERS` returns **`-1.0f`**, the
target's out-of-range sentinel (`com_cpu2.c:2527, 2596`). It is a valid float,
so it does not look like an error — check your addresses.

---

## 2.5 Writes to read-only registers are silently dropped

```c
if ((regIdx < TOTAL_REGISTERS) &&
    (regConfig[regIdx].access == REG_ACCESS_RW)) {
    applyHostRegisterWrite(regIdx, tempData);
}
```

No NAK, no error, no status bit (`com_cpu2.c:2555-2560`). The transaction
completes normally and the register is unchanged. The RO/RW column in §2.8 is
the only way to know in advance.

The same applies to an out-of-range index: the bytes are consumed and
discarded.

### What a successful write actually does

`applyHostRegisterWrite()` (`com_cpu2.c:2163-2186`) writes `registers[]`,
raises `IPC_FLAG0` to CPU1 with the address and value, and handles two
special cases:

- `eCalibrationMode` (976) written as exactly `2.0f` sets a deferred-save
  flag. The F-RAM write happens from CPU2's idle loop, never in the ISR.
  There is **no acknowledgement** — the register is not cleared and there is
  no "save complete" indication. (`eCalStatus` bit 7 is the modern equivalent
  for the runtime calibration path.)
- `eCalCommand` (1040) written non-zero **self-clears to 0** immediately, and
  clears `eCalStatus` bit 7. A host polling 1040 sees 0 as soon as the write
  is accepted; the opcode itself already travelled to CPU1 in the IPC
  payload.

> **CPU1 decodes only three ranges.** `BTS_HandleRegisterWrite()`
> (`bts_cpu1.c:1140-1170`) acts on the control block (below index 80), the
> per-channel calibration block, and `eCalCommand`. **Everything else has its
> IPC flag acked and is silently discarded** — the value lands in
> `registers[]` and a host reads it back, but nothing on the control core
> reacts to it. This is why a write to, for example, `eChX_ChargeVoltageMax`
> only takes effect when the mode register is next written: `modeCallback()`
> latches the limit registers at start (`bts_cpu1.c:1067-1074`).

### Timing

| | |
|---|---|
| CPU1 services register writes | task B3, **≈66 Hz** (200 Hz / 3 alpha states) |
| CPU1 publishes status and telemetry | task C1, **≈6.7 Hz** (20 Hz / 3) |
| CPU2 mirrors `cpu1Status` into `registers[]` | CPU Timer 1 ISR, **8 Hz** |
| ESP32 poll cycle | 250 ms, 33 transactions |

So a write and its visible effect are separated by **up to ~300 ms** of
firmware latency plus one ESP32 poll interval. Do not write-then-immediately-
read-back and conclude the write failed.

---

## 2.6 Registers that are declared but never written

These read back as a constant **0.0** on this firmware. They are in the map,
they are `REG_ACCESS_RO` in `regConfig[]`, and no code path on either core
ever assigns them.

| Addresses | Registers | Note |
|---|---|---|
| 324 + ch×24 | `eChX_MinVoltage` | Intended per-run voltage floor |
| 328 + ch×24 | `eChX_MaxVoltage` | Intended per-run voltage ceiling |

The two accumulator slots in the same block — 320 and 332 — **are now
live**, as `eChX_ChargeAcc_mAh` and `eChX_ChargeAcc_mWh`. Along with
`eChX_CellVoltage` (336) and `eChX_CellCurrent` (340), and the discharge pair
at 1156 + ch×8, they are published from `cpu1Status` by `mirrorCpu1Status()`
(`com_cpu2.c`).

They remain **RO**, so a host still cannot zero them on demand. The BTS zeroes
a direction's pair itself when that direction starts — see the discharge
block at 1156 for the semantics. The ESP32 keeps its own integration
(`coulomb_counter.c`) as the reported figure and reports the BTS values beside
it for comparison.

---

## 2.7 Status and trip bitfields

### `eChX_Status` (control block offset 36, RO)

Packed by `publishStatusToCpu2()` on CPU1 (`bts_cpu1.c:950-964`) and carried
to the host as a `float32`.

| Bit | Name | Meaning | Written? |
|---|---|---|---|
| 0 | `RUNNING` | Slot is executing a charge or discharge | yes |
| 1 | `STOPPED` | Slot is not running | yes |
| 2 | `FINISHED` | — | **never** |
| 3 | `OVERCURRENT` | An over-current trip latched | **never in this build** |
| 4 | `CHARGING` | Mode bit 1 was set at the last start | yes |
| 5 | `DISCHARGING` | Mode bit 1 was clear at the last start | yes |
| 6 | `CONST_VOLTAGE` | Loop is in CV regulation | **always 0** |
| 7 | `CONST_CURRENT` | Loop is in CC regulation | **always 1** |
| 8 | `SLAVE_MODE` | Slot follows a lower-numbered group leader | yes |
| 9 | `GROUP_DISCONNECT` | A member of this slot's group fell out of sync | yes |
| 10 | `REVERSE_POLARITY` | Measured cell voltage is negative | yes |
| 11 | `SLOT_DISABLED` | Masked off by the ENABLE strap | yes |
| 12 | `CALIBRATING` | Slot is in the runtime calibration state | yes |
| 13 | `CAL_V_VALID` | **Persisted** voltage calibration is valid | yes |
| 14 | `CAL_I_VALID` | **Persisted** current calibration is valid | yes |
| 15–23 | — | Reserved and free | — |
| 24–31 | — | **Unusable** — see below | — |

> ### Bit 23 is the hard ceiling
>
> The status word reaches a host as a `float32`, whose **24-bit significand
> represents integers exactly only up to 2²⁴ − 1**. Bit 23 is the last bit
> that survives the conversion intact; anything at bit 24 or above would be
> silently rounded away or corrupt its neighbours. The C2000 side must never
> publish past bit 23 (`registers.h:420-424`). The same applies to
> `eTripStatus` and to any other bitfield carried through this map.

Four of these bits are not what their names suggest:

- **Bit 2 (`FINISHED`) is never set.** `status[].finished` is read in
  `publishStatusToCpu2()` but assigned nowhere in the firmware.
- **Bit 3 (`OVERCURRENT`) is never set in this build**, for the same reason
  the trip word is always zero — below.
- **Bits 6 and 7 are constants.** The build is CC-only
  (`BTS_LAB_TYPE = BTS_LAB_CLOSED_LOOP_ACMC_IOUT` → `BTS_ISR_CL_MODE_CC`,
  `bts_user_settings.h:305-315`), so `ctrlMode_logic` is hard-assigned 0
  (`bts.h:572-576`) and the CV branch is compiled out. Bit 7 is always 1 and
  bit 6 always 0. They are genuinely reported now — before the calibration
  work neither was copied out of the ISR and both read 0 — but they cannot
  vary on this build.

Bits 13 and 14 are driven from the **persisted** `calFlags` that CPU2 mirrors
into `calValidFlags[]` at boot and on each save, not from the in-session
capture — a slot calibrated in an earlier session still shows its ticks after
a power cycle (`bts_cpu1.c:944-949`).

### `eTripStatus` (988, RO)

```
bit (ch*2)     CMPSS over-current trip on channel ch
bit (ch*2 + 1) GPIO group trip on channel ch
bits 16-31     reserved
```

> **This word is currently always zero, and so is status bit 3.** The bits
> are set only in `epwmTripISR()` (`bts_cpu1.c:1715-1718`), whose trip-zone
> interrupt is enabled per channel only when `BTS_TRIP_HW_CHn_ENABLED` is
> true (`bts_hal.c:1098-1102`). All eight are `(false)` in this build
> (`bts_user_settings.h:113-120`), which also masks both one-shot trip
> sources at the ePWM module so a floating sense chain cannot latch a
> spurious trip at boot.
>
> The **software** over-current check (`BTS_tripEpwm()`, `bts.h:350-380`,
> with `BTS_OCP_TRIGGER` true) still runs every control pass and forces the
> trip zone, bringing the PWM down — but it sets the flags itself and does
> not go through the ISR, so it does not raise these bits either.
>
> Do not use `eTripStatus` as a fault indicator against this firmware. See
> the bench warning in [`README.md`](README.md).

### `eChX_Mode` (control block offset 0, RW)

The only register that causes an action rather than storing a value.

| Bit | Mask | Meaning |
|---|---|---|
| 0 | `0x01` | RUN. Clear = stop |
| 1 | `0x02` | CHARGE. **Clear = DISCHARGE** |
| 2 | `0x04` | Enter calibration |

| Value | Effect |
|---|---|
| `0x00` | Stop |
| `0x01` | Run, discharge |
| `0x03` | Run, charge |
| `0x04` | Enter calibration on this channel |

> **Note the asymmetry.** Bit 1 clear means *discharge*, so "stop" (`0x00`)
> and "start a discharge" (`0x01`) differ only in bit 0. A stray bit here
> starts a discharge rather than doing nothing.
>
> `modeCallback()` also **refuses the command outright** if the DC input
> voltage is outside the charge/discharge restrict window, leaving the
> channel stopped with no error anywhere (`bts_cpu1.c:1048-1061`). Always
> read the status register back.
>
> Bit 2 is a second entry point into calibration, equivalent to writing
> `eCalSlot` then `CAL_CMD_ENTER`; both route to the same handler on CPU1 so
> the one-slot-at-a-time rule is enforced in one place
> (`bts_cpu1.c:1030-1034`). A start on a slot that was calibrating exits its
> calibration first, reference down before anything else changes.

---

## 2.8 The complete register map

305 registers, byte addresses 0 to 1216. `index = address / 4`.

**The blocks do not share a stride.** Deriving an address by assuming ten
registers per channel everywhere produces silent cross-channel corruption.
Always derive through the base and stride: stats step by 24, temperature limits
by 8, control by 40, calibration by 48. The old ESPHome component
(`esp32-controller/components/bts_i2c/bts_i2c.cpp:23,37,45`) gets this right and
is a reasonable worked example — its actual defects are elsewhere, in byte order
and the missing lead-in pad byte (see §2.2).

### Block summary

| Block | Base | Stride | Regs/ch | Total | Address range |
|---|---|---|---|---|---|
| Control | 0 | 40 | 10 | 80 | 0 – 316 |
| Stats | 320 | 24 | 6 | 48 | 320 – 508 |
| Temperature limits | 512 | 8 | 2 | 16 | 512 – 572 |
| Global voltages | 576 | — | unit | 4 | 576 – 588 |
| Calibration (per channel) | 592 | 48 | 12 | 96 | 592 – 972 |
| Unit | 976 | — | unit | 4 | 976 – 988 |
| Cell temperature | 992 | 4 | 1 | 8 | 992 – 1020 |
| Slot grouping | 1024 | — | unit | 3 | 1024 – 1032 |
| Calibration control | 1036 | — | unit | 5 | 1036 – 1052 |
| Calibration telemetry | 1056 | — | unit | 9 | 1056 – 1088 |
| Sense (ADS131M08) | 1092 | 8 | 2 | 16 | 1092 – 1152 |
| Discharge accumulators | 1156 | 8 | 2 | 16 | 1156 – 1216 |

Any channel's address:

```
address = base + channel * stride + offset
```

Never insert a register mid-map. Register addresses are hard-coded by
external hosts, so every addition appends above the current top.

---

### Control block — base 0, stride 40, `ch` = 0–7

`BTS_CTRL_ADDR(ch, off)`

| Address | Offset | Name | Access | Units | Meaning |
|---|---|---|---|---|---|
| `0 + ch*40` | 0 | `eChX_Mode` | **RW** | bitfield | Run/charge/calibrate command. See §2.7 |
| `4 + ch*40` | 4 | `eChX_ChargeVoltageMin` | RW | V | Charge-phase lower voltage bound |
| `8 + ch*40` | 8 | `eChX_ChargeVoltageMax` | RW | V | Charge-phase voltage ceiling; latched into `vref_charge_V` at start |
| `12 + ch*40` | 12 | `eChX_DischargeVoltageMin` | RW | V | Discharge cutoff; latched into `vref_discharge_V` |
| `16 + ch*40` | 16 | `eChX_DischargeVoltageMax` | RW | V | Discharge-phase upper voltage bound |
| `20 + ch*40` | 20 | `eChX_ChargeCurrentMin` | RW | A | Charge termination current |
| `24 + ch*40` | 24 | `eChX_ChargeCurrentMax` | RW | A | Charge current setpoint |
| `28 + ch*40` | 28 | `eChX_DischargeCurrentMin` | RW | A | Discharge cutoff current |
| `32 + ch*40` | 32 | `eChX_DischargeCurrentMax` | RW | A | Discharge current setpoint |
| `36 + ch*40` | 36 | `eChX_Status` | RO | bitfield | Status word, §2.7 |

Channel 0 occupies 0–36, channel 7 occupies 280–316.

The eight limit registers are **latched by `modeCallback()` at start**, not
applied live. Write the limits first, then the mode. The ESP32 does exactly
that, and writes each limit as its own transaction rather than one burst, so
the failure granularity stays per-register (`bts_link.c:210-224`).

---

### Stats block — base 320, stride 24, `ch` = 0–7

`BTS_STATS_ADDR(ch, off)`

| Address | Offset | Name | Access | Units | Meaning |
|---|---|---|---|---|---|
| `320 + ch*24` | 0 | `eChX_ChargeAcc_mAh` | RO | mAh | Charge-direction charge total. See the discharge block at 1156 |
| `324 + ch*24` | 4 | `eChX_MinVoltage` | RO | V | **Never written — always 0.0.** See §2.6 |
| `328 + ch*24` | 8 | `eChX_MaxVoltage` | RO | V | **Never written — always 0.0** |
| `332 + ch*24` | 12 | `eChX_ChargeAcc_mWh` | RO | mWh | Charge-direction energy total |
| `336 + ch*24` | 16 | `eChX_CellVoltage` | RO | V | Cell voltage, **12-bit internal ADC** |
| `340 + ch*24` | 20 | `eChX_CellCurrent` | RO | A | Cell current, 12-bit internal ADC. Negative = discharge |

> **This block carries the 12-bit on-chip ADC, despite the naming.** The
> 16-bit ADS131M08's engineering values are in the *sense* block at 1092.
> Every host interface — HTTP, BLE, the panel — shows the 12-bit path here
> unless it explicitly reads 1092.

---

### Temperature limit block — base 512, stride 8, `ch` = 0–7

`BTS_TEMPLIM_ADDR(ch, off)`

| Address | Offset | Name | Access | Units | Meaning |
|---|---|---|---|---|---|
| `512 + ch*8` | 0 | `eChX_MinCellTemp` | **RW** | °C | Configured lower trip limit |
| `516 + ch*8` | 4 | `eChX_MaxCellTemp` | **RW** | °C | Configured upper trip limit |

These are the **configured window**, not a measurement — the measured
temperature is at 992. Both are mirrored into the F-RAM calibration image.

---

### Global voltage thresholds — base 576, unit-scoped

The DC **input bus** guard, not cell voltage. Drives `eUnitState`.

| Address | Name | Access | Units | Default | Meaning |
|---|---|---|---|---|---|
| 576 | `eChargeDisableV` | **RW** | V | 9.0 | Below this, no slot will start at all |
| 580 | `eChargeRestrictV` | **RW** | V | 10.0 | Below this, charge is refused |
| 584 | `eDischargeRestrictV` | **RW** | V | 15.0 | Above this, discharge is refused |
| 588 | `eDischargeDisableV` | **RW** | V | 16.0 | Above this, discharge is disabled |

Defaults from `DEFAULT_CHARGE_DISABLE_V` and friends
(`com_cpu2.c:133-136`), installed when the persisted values fail validation.

> **These have never actually persisted.** The F-RAM block for channel 4
> collided with `EEPROM_GLOBAL_V_ADDR`, so `saveAllCalibration()` wrote the
> globals at `0x0100` and channel 4 then overwrote them; at the next boot
> they failed validation and the defaults above were silently reinstalled.
> Fixed by the calibration work — a fixed 128-byte per-channel stride with
> the globals moved to `0x0400` (`com_cpu2.c:104-106`). The guard is checked
> both at mode-write time and again at 10 Hz, so a marginal input stops a
> slot a fraction of a second after it starts.

---

### Per-channel calibration block — base 592, stride 48, `ch` = 0–7

`BTS_CAL_ADDR(ch, off)`. The order matches `BTS_channelCalibration`'s float
members, so these double as the F-RAM image layout.

| Address | Offset | Name | Access | Units | Meaning |
|---|---|---|---|---|---|
| `592 + ch*48` | 0 | `eChX_F28V_Gain` | **RW** | V per V-at-pin | Internal-ADC voltage gain |
| `596 + ch*48` | 4 | `eChX_F28V_Offset` | **RW** | V | Internal-ADC voltage offset |
| `600 + ch*48` | 8 | `eChX_F28I_Gain` | **RW** | A per V-at-pin | Internal-ADC current gain |
| `604 + ch*48` | 12 | `eChX_F28I_Offset` | **RW** | A | Internal-ADC current offset |
| `608 + ch*48` | 16 | `eChX_IoutGain_pu` | **RW** | pu per A | A → per-unit, for the control loop's setpoint |
| `612 + ch*48` | 20 | `eChX_IoutOffset_pu` | **RW** | pu | |
| `616 + ch*48` | 24 | `eChX_IoutGain_A` | **RW** | A per pu | per-unit → A, for reporting. **Reciprocal of `IoutGain_pu`** |
| `620 + ch*48` | 28 | `eChX_IoutOffset_A` | **RW** | A | |
| `624 + ch*48` | 32 | `eChX_VoutGain_pu` | **RW** | pu per V | V → per-unit |
| `628 + ch*48` | 36 | `eChX_VoutOffset_pu` | **RW** | pu | |
| `632 + ch*48` | 40 | `eChX_VoutGain_V` | **RW** | V per pu | per-unit → V. **Reciprocal of `VoutGain_pu`** |
| `636 + ch*48` | 44 | `eChX_VoutOffset_V` | **RW** | V | |

A write anywhere in this block makes CPU1 reload the **whole channel** and
schedule a recalculation (`BTS_loadCalibrationFromRegisters()`,
`bts_cpu1.c:1153-1159`) — it is one of the three ranges CPU1 decodes at all.

The two reciprocal pairs are stored separately and validated against each
other to within 0.1 %, which is what catches a partially-written F-RAM block.
Typical good values: `IoutGain_pu ≈ 0.100`, `VoutGain_pu ≈ 0.203`. Validation
windows are in [`calibration-design.md`](calibration-design.md) §8.2.

> **Writing these does not persist them.** They live in RAM until an explicit
> save — either `eCalibrationMode = 2.0f` (the legacy path) or
> `CAL_CMD_COMPUTE_SAVE`.

---

### Unit block — base 976

| Address | Name | Access | Units | Meaning |
|---|---|---|---|---|
| 976 | `eCalibrationMode` | **RW** | command | Writing exactly `2.0f` triggers a deferred F-RAM save of the whole calibration image. **No acknowledgement**, and the register is never cleared. Decoded with no tolerance — `1.9999f` does nothing |
| 980 | `eUnitState` | RO | enum | `UnitState`, 0–4. See §1.3.1 |
| 984 | `eInputVoltage` | RO | V | DC input bus voltage |
| 988 | `eTripStatus` | RO | bitfield | Two bits per channel. **Always 0** — see §2.7 |

These four are consecutive, so one burst read of 4 registers from 976 covers
the whole unit state. That is what the ESP32 poll task does first each cycle,
because the trip bitfield is then available for the per-channel decode.

---

### Cell temperature block — base 992, stride 4, `ch` = 0–7

`BTS_CELLTEMP_ADDR(ch)`

| Address | Name | Access | Units | Meaning |
|---|---|---|---|---|
| `992 + ch*4` | `eChX_CellTemp` | RO | °C | **Measured** cell temperature |

Written by CPU2 from the two ADS1119 converters' DRDY ISRs on I2CB. Distinct
from the configured min/max limit pair at 512.

---

### Slot grouping — base 1024

Latched from the MODE/ENABLE dip switches by CPU1 at boot and mirrored here,
so a host can see how the unit is strapped without reading the switches
itself. Both straps arrive through an SN74HC148 8:3 priority encoder.

| Address | Name | Access | Units | Meaning |
|---|---|---|---|---|
| 1024 | `eSlotMode` | RO | 0–7 | `BTS_SlotMode`. Low two bits = group size, bit 2 selects the converter |
| 1028 | `eSlotEnable` | RO | 0–7 | Index of the **highest enabled** slot: 0 enables slot 1 alone, 7 enables all eight |
| 1032 | `eGroupSize` | RO | 1/2/4/8 | Slots per group, `1 << (mode & 3)` |

| `eSlotMode` | Grouping | Voltage feedback |
|---|---|---|
| 0 | 8 independent slots | ADS131M08 |
| 1 | pairs: 1+2, 3+4, 5+6, 7+8 | ADS131M08 |
| 2 | quads: 1–4, 5–8 | ADS131M08 |
| 3 | one group of 8 | ADS131M08 |
| 4–7 | as 0–3 | **C2000 internal ADC** |

The group leader is the lowest-numbered slot in the group. A follower has no
control loop of its own, which is why `CAL_CMD_ENTER` refuses one with
`CAL_ERR_SLOT_UNAVAILABLE`.

---

### Calibration control — base 1036, unit-scoped

Unit-scoped rather than per-slot because only one slot calibrates at a time;
the per-slot form would need 72 registers (144 words) and does not fit in
`CPU2TOCPU1RAM`.

| Address | Name | Access | Units | Meaning |
|---|---|---|---|---|
| 1036 | `eCalSlot` | **RW** | 0–7 | Slot under calibration. **255 = none** |
| 1040 | `eCalCommand` | **RW** | opcode | Command, 0–8. **Consumed on write and self-clears to 0** |
| 1044 | `eCalArgument` | **RW** | varies | Float payload. **Write this BEFORE the opcode** |
| 1048 | `eCalStatus` | RO | bitfield | Progress, §1.16.2 |
| 1052 | `eCalResult` | RO | code | Outcome of the last command, §1.16.3 |

> **Ordering is not advisory.** The command is consumed the instant it is
> written and the register self-clears, so an argument that arrives
> afterwards applies to nothing. Write 1044, then 1040, then read 1052.
> A burst write from 1036 with three registers achieves slot, command,
> argument in the **wrong** order — do not do that.

Opcodes, from [`calibration-design.md`](calibration-design.md) §5.1:

| Code | Name | Argument |
|---|---|---|
| 0 | `NONE` | — |
| 1 | `ENTER` | — (uses `eCalSlot`) |
| 2 | `EXIT` | — |
| 3 | `CAPTURE_VOLTAGE` | measured volts |
| 4 | `ZERO_CURRENT` | — |
| 5 | `SET_FIXED_CURRENT` | pu setpoint, 0.0–0.8 |
| 6 | `CAPTURE_CURRENT` | measured amps, **magnitude** |
| 7 | `COMPUTE_SAVE` | — |
| 8 | `CLEAR` | — |

---

### Calibration live telemetry — base 1056, unit-scoped, all RO

A window on the slot named by `eCalSlot`. **Zero when no slot is selected.**

| Address | Name | Units | Meaning |
|---|---|---|---|
| 1056 | `eCalAdsV_pu` | pu | ADS131M08 voltage, **raw pre-gain** |
| 1060 | `eCalAdsI_pu` | pu | ADS131M08 current, raw pre-gain |
| 1064 | `eCalAdsV_V` | V | ADS131M08 voltage, post-gain |
| 1068 | `eCalAdsI_A` | A | ADS131M08 current, post-gain |
| 1072 | `eCalF28V_pu` | V at the ADC pin | Internal ADC voltage, raw pre-gain |
| 1076 | `eCalF28I_pu` | V at the ADC pin | Internal ADC current, raw pre-gain |
| 1080 | `eCalF28V_V` | V | Internal ADC voltage, post-gain |
| 1084 | `eCalF28I_A` | A | Internal ADC current, post-gain |
| 1088 | `eCalTemp_C` | °C | Live cell temperature of the slot under calibration |

"Raw pre-gain" is the normalised converter reading **before** any calibration
gain or offset — the quantity the two-point fit consumes, and what the
`< 0.2` / `> 0.8` capture windows are checked against. It must not be
silently pre-scaled.

```
ADS path:      sum / (BTS_senseAverageFactor * 32768.0)
Internal path: (sum / (BTS_f28AverageFactor * 4096.0)) * 2.5
```

The internal-path quantity is therefore **volts at the pin**, not
dimensionless, matching how `BTS_monitor_Iout_Vout()` scales it. The internal
gain/offset pair is defined against exactly that.

`eCalTemp_C` is filled by **CPU2**, which owns the ADS1119 readings; CPU1 has
no temperature to publish.

> **Registers 1036 to 1088 are one contiguous 14-register burst** — that is
> `BTS_CAL_WINDOW_COUNT`, and it is how the ESP32 refreshes the whole
> calibration state in a single transaction (`poll_cal_window()`,
> `bts_link.c:401-437`). Index 1 of that burst is `eCalCommand`, which
> self-clears and carries nothing useful for a host.

---

### Sense block (ADS131M08) — base 1092, stride 8, `ch` = 0–7, all RO

`BTS_SENSE_ADDR(ch, off)`

| Address | Offset | Name | Units | Meaning |
|---|---|---|---|---|
| `1092 + ch*8` | 0 | `eChX_SenseVoltage` | V | `Vsense_V`, the **16-bit** ADS131M08 voltage |
| `1096 + ch*8` | 4 | `eChX_SenseCurrent` | A | `Isense_A`, the 16-bit ADS131M08 current |

Range 1092 to **1152** (channel 7's current register). The discharge
accumulator block picks up immediately above it at 1156.

These are the 16-bit converter's engineering values. They were computed every
control pass since the converter was fitted and, until the calibration work,
read by **nothing** — not `publishStatusToCpu2()`, not `cpu1Status`, not
`canData`, not `registers[]`. Every host interface was showing the 12-bit
internal ADC via the stats block at 336, which is the opposite of what the
register-map naming suggests.

> There is **no HTTP or BLE field for these**. Reach them with
> `GET /api/registers?addr=1092&count=16` or a direct I2C burst.

---

### Discharge accumulator block — base 1156, stride 8, `ch` = 0–7, all RO

`BTS_DISCHACC_ADDR(ch, off)`

| Address | Offset | Name | Units | Meaning |
|---|---|---|---|---|
| `1156 + ch*8` | 0 | `eChX_DischargeAcc_mAh` | mAh | Discharge-direction charge total |
| `1160 + ch*8` | 4 | `eChX_DischargeAcc_mWh` | mWh | Discharge-direction energy total |

Range 1156 to **1216**, the top of the map.

The charge direction's pair is at 320 and 332 in the stats block, at the
addresses that used to be `eChX_CurrentAcc` and `eChX_PowerAcc` — renamed,
not moved.

**Semantics, common to both pairs:**

- Integrated on CPU1 from `Isense_A` and `Vsense_V`, the **16-bit ADS131M08**
  pair published at 1092 — not the 12-bit internal ADC in the stats block.
  This is the same sensor the CC loop regulates against.
- Both accumulate **positive magnitude** into their own direction, so a
  charge followed by a discharge on one slot leaves two separate positive
  totals rather than cancelling.
- **A pair is zeroed only when its own direction starts.** Starting a charge
  zeroes the charge pair and leaves the discharge pair untouched, and vice
  versa. Nothing is zeroed on stop, on trip, or on a mode write that does not
  start the slot. In a group the leader's reset propagates to every follower.
- Accumulation runs only while the slot is `RUNNING` and not calibrating.
- The step is the C1 task period. The C tasks rotate C1→C2→C3 off the
  `TASKC_FREQ_HZ` (20 Hz) timer, so C1 sees every third tick — 6.667 Hz, a
  150 ms rectangular step. A host wanting finer resolution should integrate
  its own polled samples, as the ESP32 proxy does.
- Still `REG_ACCESS_RO`: a host cannot zero them on demand. The
  start-of-direction reset is what replaces that.

> There is **no HTTP or BLE field for these**. The result JSON reports them
> under `bts_raw` (`discharge_mah`, `discharge_mwh`, `charge_mah`,
> `charge_mwh`) at the end of a test, alongside the ESP32's own integration.
> Otherwise reach them with `GET /api/registers?addr=1156&count=16`.

---

## 2.9 Where the ESP32 mirror disagrees with the C2000

`esp32-btle-proxy/components/bts_link/include/bts_regs.h` is a **hand-maintained
transcription** of `tida-010086/bts_F2837xD_8ch/registers.h`. There is no
build coupling between the two projects, so they can drift.

**Every address, stride, base and register count agrees**, and so do the
opcode, result-code and status-bit numbering. `BTS_TOTAL_REGISTERS` is 305 on
both sides.

Three differences are deliberate but will bite a reader who moves between the
files, because the **same identifier means different things**:

| Identifier | In `registers.h` (C2000) | In `bts_regs.h` (ESP32) |
|---|---|---|
| `BTS_CAL_ST_*`, `BTS_STATUS_*` | bit **positions** (`0U`, `1U`, …) | bit **masks** (`1u << 0`, …) |
| `BTS_CAL_F28V_GAIN` … `BTS_CAL_VOUT_OFFSET_V` | **index** offsets, 0–11 | **byte** offsets, 0–44 |
| `BTS_SENSE_VOLTAGE` / `BTS_SENSE_CURRENT` | index offsets, 0 and 1 | byte offsets, 0 and 4 |
| `BTS_SENSE_BASE` | function-like macro `BTS_SENSE_BASE(ch)` returning an **index** | a bare constant `1092`, a **byte address** |

The convention is consistent within each file — the C2000 indexes
`registers[]`, the ESP32 addresses the wire — but `BTS_SENSE_BASE` in
particular is a genuine collision: the same spelling is a macro on one side
and a constant on the other. Copying a line between the two files compiles
and is wrong.

Two documentation defects, both now fixed in `bts_regs.h`:

- The `WIRE FORMAT` comment showed the read shape **without the lead-in pad
  byte**, contradicting `bus_read_block()` twenty lines of comment further
  down. The read shape now includes the pad byte.
- The same comment explained the write auto-increment in terms of "the ISR
  rewinds byteCount to 2". No variable of that name survives in `com_cpu2.c`.
  The described behaviour was correct; the mechanism named was stale, and the
  sentence now states the behaviour without naming a variable.

### Where the design document disagrees with the source

| Item | Design doc | Source |
|---|---|---|
| Sense block range (§4.3) | "Range 1092–1148" — **corrected to 1092–1152** | **1092–1152**. Sixteen registers at stride 4 from 1092 ends at `1092 + 15*4 = 1152`, and `registers.h` has `eCh7_SenseCurrent = 1152`. The doc's original figure was one register short |

Everything else in the design document — the 30 added registers, the
259 → 289 total, the block addresses, the opcode table, the status bitfield,
the result codes, the 0xA5CD0000 header, the 128-byte F-RAM stride and the
0x0400 global-voltage address — matches the implementation exactly.
