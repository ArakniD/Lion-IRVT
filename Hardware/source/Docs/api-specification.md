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
| **Endpoints** | 28 (see §1.1) |
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
| 9 | POST | `/api/slot/<n>/pause` | Pause the slot, keeping its counters |
| 10 | POST | `/api/slot/<n>/resume` | Resume a paused slot |
| 11 | POST | `/api/abort_all` | Abort every slot |
| 12 | GET | `/api/results` | Paged result history across all slots |
| 13 | GET | `/api/catalog` | Chemistries and cell models |
| 14 | POST | `/api/chemistry/<name>` | Override a chemistry profile, persisted to NVS |
| 15 | POST | `/api/wifi` | Store station credentials |
| 16 | GET | `/api/registers` | Raw BTS register block read |
| 17 | POST | `/api/registers` | Raw BTS register write |
| 18 | GET | `/api/i2c_diag` | Bus-level I2C diagnostic |
| 19 | GET | `/api/calibration` | Full calibration state, telemetry and persisted gains |
| 20 | POST | `/api/calibration/enter` | `CAL_CMD_ENTER` |
| 21 | POST | `/api/calibration/exit` | `CAL_CMD_EXIT` |
| 22 | POST | `/api/calibration/clear` | `CAL_CMD_CLEAR` |
| 23 | POST | `/api/calibration/voltage` | `CAL_CMD_CAPTURE_VOLTAGE` |
| 24 | POST | `/api/calibration/zero_current` | `CAL_CMD_ZERO_CURRENT` |
| 25 | POST | `/api/calibration/fixed_current` | `CAL_CMD_SET_FIXED_CURRENT` |
| 26 | POST | `/api/calibration/current` | `CAL_CMD_CAPTURE_CURRENT` |
| 27 | POST | `/api/calibration/save` | `CAL_CMD_COMPUTE_SAVE` |
| 28 | OPTIONS | `/*` | CORS preflight |

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
    "watchdog_timeout_s": 30,
    "watchdog_enabled": true,
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
| `unit.input_voltage_v` | float, 3 dp | DC input bus, register 1176 |
| `unit.trip_status` | uint32 | Two bits per channel. **Always 0** — see §2.7 |
| `unit.consecutive_errors` | uint32 | Failed poll cycles in a row; 0 when healthy |
| `unit.watchdog_timeout_s` | float, 0 dp | The unit's configured host-watchdog timeout, register 1196. **0 = disabled** |
| `unit.watchdog_enabled` | bool | `watchdog_timeout_s > 0`. Convenience only, derived from the field above |
| `unit.slots` | int | 8 |
| `unit.max_current_a` | float, 1 dp | 10.0, the unit envelope from `BTS_CMPSS_FULLSCALE_A` |
| `unit.max_voltage_v` | float, 1 dp | 5.0, the per-channel output range |
| `unit.bts_accumulators_live` | bool | Positive test only — see §1.3.2 |
| `unit.uptime_s` | uint32 | ESP32 uptime, not a wall clock |
| `unit.wifi_sta` / `wifi_ap` | bool | Station joined / SoftAP active |

> **There is no remaining-seconds field.** The BTS publishes a live countdown
> at `eWatchdogRemaining_s` (1220), but the ESP32 mirror does not yet know
> that register exists (§2.11), so neither HTTP nor BLE carries it. A host
> that wants the countdown must read 1220 directly through
> `GET /api/registers?addr=1220&count=1`.

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
| `bts` | object | **The BTS's own view of the slot.** Always present. See below |
| `config` | object | Present **only when `configured`** |
| `profile` | object | Present only when `configured`; the resolved envelope after clamping |

`last_result` is **omitted** from this endpoint to keep the poll response
small. Fetch it from `/api/slot/<n>` or `/api/results`.

The `bts` object carries the unit's own state and counters for the slot,
decoded from its status word and runtime block. It is the only place the six
per-direction counters surface as named JSON:

```json
"bts": {
  "paused": true,
  "watchdog_tripped": false,
  "restored": true,
  "ended": false,
  "charge_mah": 1842.3,
  "charge_mwh": 6871.9,
  "charge_seconds": 4380,
  "discharge_mah": 0.0,
  "discharge_mwh": 0.0,
  "discharge_seconds": 0
}
```

| Key | Type | Meaning |
|---|---|---|
| `paused` | bool | Status bit 15. The slot is held; its direction bit still says what a resume would do |
| `watchdog_tripped` | bool | Status bit 17. Paused **because the host link went quiet** |
| `restored` | bool | Status bit 18. Paused **because the unit reset mid-run** and came back holding the counters |
| `ended` | bool | Status bit 2. Test finished normally. See the note in §2.7 — nothing on the C2000 currently asserts it |
| `charge_mah` / `charge_mwh` | float, 1 dp | Charge-direction totals |
| `charge_seconds` | float, 0 dp | Seconds spent charging this run |
| `discharge_mah` / `discharge_mwh` | float, 1 dp | Discharge-direction totals |
| `discharge_seconds` | float, 0 dp | Seconds spent discharging this run |

> **`restored` is the one an operator has to act on.** It means the unit
> reset while this slot was running. The cell may have been changed in the
> meantime, so the proxy will not auto-resume — resuming is a deliberate user
> action over HTTP or BLE. See §2.10.

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

#### 1.3.2 `bts_accumulators_live`

`bts_link_stats_are_live()` probes the BTS accumulators once at start-up.
The current C2000 firmware **does** populate them (§2.8.1), but the probe is
a **positive test only**: a unit that has been idle since power-up reads
all-zero and the flag stays `false`, exactly as it did on the older firmware
that never wrote them at all. A `false` here does not mean the accumulators
are dead.

Either way the ESP32 keeps its own integration (`coulomb_counter.c`) as the
reported `live_mah` / `live_mwh`, because it samples on real elapsed time at
the 250 ms poll rather than the BTS's fixed 150 ms step. The flag only says
whether the BTS figures are worth comparing against; the figures themselves
are always in the slot object's `bts{}`.

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
the ESP32's integration is possible. They **are** populated by the current
firmware — see §2.8.1. `live` is the `bts_link_stats_are_live()` probe, which
is a positive test only and stays false on a unit that has been idle since
power-up (§1.3.2).

---

### 1.7 `POST /api/slot/<n>/start` · `/abort` · `/clear` · `/pause` · `/resume`

No body. All five return `{"ok":true}` on success.

| Action | Calls | Effect on the BTS |
|---|---|---|
| `/start` | `test_engine_start(n)` | Mode write with RUN + direction. Zeroes the starting direction's counter set |
| `/abort` | `test_engine_abort(n)` | Mode write of `0x00`. Zeroes nothing |
| `/clear` | `test_engine_clear_fault(n)` | Clears the proxy's own fault latch |
| `/pause` | `test_engine_pause(n)` | Mode bit 3. Converter reference to zero, direction remembered, **counters frozen and kept** |
| `/resume` | `test_engine_resume(n)` | Mode bit 4. Resumes the held direction, **zeroes nothing**, clears `WD_TRIPPED` and `RESTORED` |

| Status | When |
|---|---|
| `200` | Accepted |
| `404` | Bad slot, or an unrecognised action segment |
| `409` | `"slot is not in a state that accepts this action"` — including a resume on a slot that is not paused |
| `500` | Any other engine error, with the `esp_err_t` name as the message |

> **The action is matched on the trailing segment, exactly.**
> `h_slot_action()` takes `strrchr(uri, '/')` and `strcmp`s it, so
> `/api/slot/2/please_start_now` is a 404 rather than a start
> (`web_api.c:533-575`). This replaced an earlier `strstr()` over the whole
> URI, which had to be abandoned when pause and resume arrived: under
> substring matching `/resume` contains no other action's name, but the
> ordering of the tests became load-bearing in a way nothing in the URI
> expressed. Exact segment matching removes the trap. The `/config` and
> `/serial` dispatchers ahead of it are unchanged.

`/pause` and `/resume` are the host-initiated half of the PAUSED state. The
other two entries into it — a watchdog timeout and a boot restore — happen on
the unit and surface through `bts.watchdog_tripped` / `bts.restored` in
§1.3. A restored slot **must not** be auto-resumed; see §2.10.

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

Range is `0` to `(BTS_TOTAL_REGISTERS - 1) * 4` inclusive. The ESP32's
`BTS_TOTAL_REGISTERS` is currently **314**, giving a ceiling of **1252** — one
register short of the unit's own top address of **1256**. That is the mirror
defect in §2.11: `eCalTemp_C` at 1256 cannot be reached through this endpoint
until the mirror is corrected.

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
| `h_slot_post_dispatch` | `POST /api/slot/*` | `strstr` for `/config` and `/serial`, then the **exact** trailing segment for `start`\|`abort`\|`clear`\|`pause`\|`resume` |
| `h_cal_post_dispatch` | `POST /api/calibration/*` | `strcmp` on the **last** segment, via `strrchr(uri, '/')` |

The slot number is parsed out of the URI by each handler itself
(`slot_from_uri()`, `web_api.c:178-190`), which looks for `/slot/` and
`atoi`s what follows, returning −1 for anything missing or ≥ 8. So every
handler has one check rather than trusting a wildcard match.

Note the dispatchers differ in strictness. The calibration one and the slot
**action** one both `strcmp` the final segment and so are **exact**; only the
`/config` and `/serial` tests ahead of the actions are still substring
matches. The action tests were converted to exact matching when pause and
resume arrived — see §1.7.

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

The BTS is an **I2C target** exposing a flat array of 315 IEEE-754 `float32`
registers. This is the interface the ESP32 proxy uses
(`components/bts_link/`), and it is available to any other host on the same
bus.

| | |
|---|---|
| **Bus** | I2CA on the F2837xD (`com_cpu2.c:298-301`) |
| **Target address** | `0x50`, 7-bit (`BTS_I2C_TARGET_ADDRESS`) |
| **Bus speed** | **50 kHz** — see §2.2 |
| **Register size** | 4 bytes, always |
| **Register count** | 315 (`TOTAL_REGISTERS`) |
| **Map version** | **v2** — see the warning below |
| **Address space** | Byte addresses 0 to 1256 inclusive, always a multiple of 4 |
| **Index** | `index = address / 4` |
| **Payload byte order** | **Big-endian** |

> ### Map v2 moved every address
>
> The v1 map spread a slot's live data across five blocks at five different
> strides, which cost the ESP32 ~33 I2C transactions per poll cycle. v2
> regroups it into **three regions** so a slot's runtime data is one
> contiguous burst, and the cycle is now **9 transactions** — eight slots
> plus the unit block (`bts_poll_task()`, `bts_link.c`). That reduction is
> the entire point of the reorder.
>
> **Every hard-coded v1 address is wrong under v2.** There is no
> compatibility window and no version register: the C2000 and any host must
> be updated together. The superseded `esp32-controller/` component is left
> broken and remains do-not-use.

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

At the top of the map (address 1256) the pointer stops advancing, and a read
that continues past it **repeats register 1256** indefinitely. Unbounded it
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

`applyHostRegisterWrite()` (`com_cpu2.c:2553`) writes `registers[]`,
raises `IPC_FLAG0` to CPU1 with the address and value, **reloads the host
watchdog** (§2.10), and handles three special cases:

- `eCalibrationMode` (1168) written as exactly `2.0f` sets a deferred-save
  flag. The F-RAM write happens from CPU2's idle loop, never in the ISR.
  There is **no acknowledgement** — the register is not cleared and there is
  no "save complete" indication. (`eCalStatus` bit 7 is the modern equivalent
  for the runtime calibration path.)
- `eCalCommand` (1204) written non-zero **self-clears to 0** immediately, and
  clears `eCalStatus` bit 7. A host polling 1204 sees 0 as soon as the write
  is accepted; the opcode itself already travelled to CPU1 in the IPC
  payload.
- `eHostWatchdog_s` (1196) written as `0.0f` raises a deferred warning on the
  AT console. Disabling supervision on a machine that charges lithium cells
  unattended is a legitimate bench setting and a dangerous production one, so
  it is said out loud. See §2.10 and the known-issue note there.

> **CPU1 decodes only three cases.** `BTS_HandleRegisterWrite()`
> (`bts_cpu1.c:1398`) acts on the **settings region** — the mode register at
> each slot's offset 0, and the 12-register calibration group at offset 11 —
> plus `eCalCommand`. **Everything else has its IPC flag acked and is
> silently discarded**: the value lands in `registers[]` and a host reads it
> back, but nothing on the control core reacts to it. The runtime region is
> read-only and never reaches this decode at all. This is why a write to, for
> example, `eChX_ChargeVoltageMax` only takes effect when the mode register is
> next written: `modeCallback()` latches the limit registers at start
> (`bts_cpu1.c:1210`).

### Timing

| | |
|---|---|
| CPU1 services register writes | task B3, **≈66 Hz** (200 Hz / 3 alpha states) |
| CPU1 publishes status and telemetry | task C1, **≈6.7 Hz** (20 Hz / 3) |
| CPU2 mirrors `cpu1Status` into `registers[]` | CPU Timer 1 ISR, **8 Hz** |
| CPU2 ticks the host watchdog and the state-save scheduler | same ISR, **8 Hz** |
| ESP32 poll cycle | 250 ms, **9 transactions** (was 33 under v1) |

So a write and its visible effect are separated by **up to ~300 ms** of
firmware latency plus one ESP32 poll interval. Do not write-then-immediately-
read-back and conclude the write failed.

---

## 2.6 Registers that are declared but never written

Under v2 this list is nearly empty. Two of its former entries were **deleted
from the map**, and the accumulators are live.

| Register | Status under v2 |
|---|---|
| `eChX_MinVoltage`, `eChX_MaxVoltage` | **Deleted.** They were RO and never written on either core — 16 registers of permanent 0.0. Removing them paid for most of the 16 new run-time-seconds registers. They do not exist at any address; a host that still reads their v1 addresses (324/328 + ch×24) now gets whatever v2 put there, which is live runtime data for a different slot |
| `eChX_ChargeAcc_mAh` / `_mWh`, `eChX_DischargeAcc_mAh` / `_mWh` | **Live.** Integrated on CPU1 and published in the runtime block. See §2.8 |
| `eChX_ChargeRuntime_s`, `eChX_DischargeRuntime_s` | **Live.** New in v2, on the same timestep as the mAh/mWh |
| Status bit 2 (`FINISHED` / `END`) | **Now driven.** See §2.7 |
| `eChX_SettingsSpare` | Reserved. RO, reads 0.0, one per slot at settings offset 23. Intentionally unused — the place to put a future per-slot setting without moving anything |
| `eTripStatus` | Still always 0 in this build. See §2.7 |

The accumulators remain **RO**, so a host still cannot zero them on demand.
The BTS zeroes a direction's set itself when that direction starts — see
§2.8.1 for the exact reset rule. The ESP32 keeps its own integration
(`coulomb_counter.c`) as the reported figure and reports the BTS values beside
it for comparison.

If per-run voltage extremes are wanted back, add them to the settings block's
spare space — and actually write them.

---

## 2.7 Status and trip bitfields

### `eChX_Status` (runtime block offset 0, RO)

Packed by `publishStatusToCpu2()` on CPU1 (`bts_cpu1.c:1108`) and carried
to the host as a `float32`.

| Bit | Name | Meaning | Written? |
|---|---|---|---|
| 0 | `RUNNING` | Slot is executing a charge or discharge. **Stays set while PAUSED** — a pause is a held run | yes |
| 1 | `STOPPED` | Slot is not running | yes |
| 2 | `FINISHED` / `END` | Test finished normally. Converter off, counters hold final values | **yes — new in v2** |
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
| 15 | `PAUSED` | Converter off, direction remembered, counters frozen | **yes — new in v2** |
| 16 | — | **Unused. Reads a constant 0** — see below | no |
| 17 | `WD_TRIPPED` | Paused *by the host watchdog* — the link died mid-run | **yes — new in v2** |
| 18 | `RESTORED` | Paused *by a FRAM boot restore* — the unit reset mid-run | **yes — new in v2** |
| 19–23 | — | Reserved and free | — |
| 24–31 | — | **Unusable** — see below | — |

> ### Bit 16 is not END. Read bit 2.
>
> An early revision of the ESP32 header defined `BTS_STATUS_END` at bit 16.
> That is **not** what shipped. END is an **alias for bit 2**
> (`registers.h:478`, `bts_cpu1.c:1142`), because bit 2 had been declared
> from the start and never driven — so it was given the meaning rather than
> spending a second bit on the same state. **Bit 16 is unused and reads a
> constant 0.** A host that polls bit 16 for end-of-test will wait forever.

> ### Bit 23 is the hard ceiling
>
> The status word reaches a host as a `float32`, whose **24-bit significand
> represents integers exactly only up to 2²⁴ − 1**. Bit 23 is the last bit
> that survives the conversion intact; anything at bit 24 or above would be
> silently rounded away or corrupt its neighbours. The C2000 side must never
> publish past it (`registers.h:418-421`). The same applies to `eTripStatus`
> and to any other bitfield carried through this map.

**Decoding the slot state.** A slot is in exactly one of five states, but
`PAUSED` is *not* a direction — it sits alongside `CHARGING` or
`DISCHARGING`, so a host sees both that the slot is held and what a resume
would do:

| State | Bits set |
|---|---|
| STOPPED | `STOPPED` |
| CHARGING | `RUNNING` + `CHARGING` |
| DISCHARGING | `RUNNING` + `DISCHARGING` |
| PAUSED | `RUNNING` + `PAUSED` + the direction bit, optionally + `WD_TRIPPED` or `RESTORED` |
| END | `STOPPED` + `FINISHED` |

So `running && !paused` is the test for "actually delivering power"
(`slotIsRunning()`, `bts_cpu1.c:161`). Bits 17 and 18 say *why* a slot is
paused, which is what a host needs to decide whether resuming is safe: a
watchdog pause means the link died, a restore means the unit reset and the
cell may have been swapped while it was off. Both clear on resume
(`slotResume()`, `bts_cpu1.c:192`).

Three of these bits are not what their names suggest:

- **Bit 3 (`OVERCURRENT`) is never set in this build**, for the same reason
  the trip word is always zero — below.
- **Bits 6 and 7 are constants.** The build is CC-only
  (`BTS_LAB_TYPE = BTS_LAB_CLOSED_LOOP_ACMC_IOUT` → `BTS_ISR_CL_MODE_CC`,
  `bts_user_settings.h:305-315`), so `ctrlMode_logic` is hard-assigned 0
  (`bts.h:572-576`) and the CV branch is compiled out. Bit 7 is always 1 and
  bit 6 always 0. They are genuinely reported now — before the calibration
  work neither was copied out of the ISR and both read 0 — but they cannot
  vary on this build.

> **Bit 2 is driven, but nothing currently asserts it.** `status[].finished`
> is cleared on a fresh start, on a pause and on a stop, and it is
> **restored** from the F-RAM state block at boot (`bts_cpu1.c:274`) — so a
> slot that ended before a reset comes back showing END. But no termination
> path in the C2000 firmware sets it to 1: `iref_cuttout_A` is loaded from
> `eChX_ChargeCurrentMin` and never read, and termination is still the
> ESP32's job. The bit is wired end to end and a future C2000-side
> termination will light it without any host change; today it is only ever
> observed non-zero across a restore.

Bits 13 and 14 are driven from the **persisted** `calFlags` that CPU2 mirrors
into `calValidFlags[]` at boot and on each save, not from the in-session
capture — a slot calibrated in an earlier session still shows its ticks after
a power cycle (`bts_cpu1.c:1128-1133`).

### `eTripStatus` (1180, RO)

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

### `eChX_Mode` (settings block offset 0, RW)

The only register that causes an action rather than storing a value.

| Bit | Mask | Meaning |
|---|---|---|
| 0 | `0x01` | RUN. Clear = stop |
| 1 | `0x02` | CHARGE. **Clear = DISCHARGE** |
| 2 | `0x04` | Enter calibration |
| 3 | `0x08` | **PAUSE** — hold a running slot. Edge command |
| 4 | `0x10` | **RESUME** — release a paused slot. Edge command |

| Value | Effect |
|---|---|
| `0x00` | Stop |
| `0x01` | Run, discharge — or **resume** a paused slot |
| `0x03` | Run, charge — or **resume** a paused slot |
| `0x04` | Enter calibration on this channel |
| `0x08` | Pause this channel |
| `0x10` | Resume this channel |

> **Bits 3 and 4 are edge commands.** They are acted on at the write and
> **not retained**, so a host never has to clear them afterwards and there is
> no "un-pause" bit to manage (`modeCallback()`, `bts_cpu1.c:1243-1268`).
> They are handled *before* the run/stop decode, so a mode word carrying both
> a pause and a run is a pause.
>
> Resume on a slot that is not paused returns without effect. Writing plain
> RUN (bit 0) to a paused slot is **also** a resume, so a host that predates
> v2 still works — it cannot pause, but it will not get stuck.
>
> A resume zeroes **nothing**: the counters pick up exactly where they
> stopped, which is the point of the state. It also clears `WD_TRIPPED` and
> `RESTORED`. A pause zeroes the converter reference *before* clearing
> `enable_logic`, the same ordering a trip exit uses.

> **Note the asymmetry.** Bit 1 clear means *discharge*, so "stop" (`0x00`)
> and "start a discharge" (`0x01`) differ only in bit 0. A stray bit here
> starts a discharge rather than doing nothing.
>
> `modeCallback()` also **refuses the command outright** if the DC input
> voltage is outside the charge/discharge restrict window, leaving the
> channel stopped with no error anywhere. Always read the status register
> back.
>
> Bit 2 is a second entry point into calibration, equivalent to writing
> `eCalSlot` then `CAL_CMD_ENTER`; both route to the same handler on CPU1 so
> the one-slot-at-a-time rule is enforced in one place. A start on a slot
> that was calibrating exits its calibration first, reference down before
> anything else changes.

---

## 2.8 The complete register map

**315 registers, byte addresses 0 to 1256.** `index = address / 4`.

Three regions, each with a fixed and deliberately generous per-slot stride so
that adding a field later does not move every address again:

| Region | Base | Stride | Regs/slot | Access | Range |
|---|---|---|---|---|---|
| **Runtime** | 0 | 48 B (12 regs) | 12 | all RO | 0 – 383 |
| **Settings** | 384 | 96 B (24 regs) | 24 | mostly RW | 384 – 1151 |
| **Unit** | 1152 | — | unit-scoped | mixed | 1152 – 1256 |

The arithmetic closes exactly: runtime channel 7 ends at 383, immediately
before the settings base; settings channel 7 ends at 1151, immediately before
the unit base.

```
address = base + channel * stride + offset
```

**Derive every per-slot address through its region's base and stride.**
`BTS_RT_BASE(ch)` and `BTS_SET_BASE(ch)` on the C2000, `BTS_RT_ADDR(ch, off)`
and `BTS_SET_ADDR(ch, off)` on the ESP32. The two strides differ, and mixing
them produces silent cross-channel corruption rather than an error.

Never insert a register mid-map. Register addresses are hard-coded by
external hosts, so every addition appends into the spare space its region
already carries, or above the current top.

---

### Runtime block — base 0, stride 48, `ch` = 0–7, all RO

`BTS_RT_ADDR(ch, off)`. Everything a host polls at 1 Hz, contiguous, so a
slot is **one 12-register burst**. This grouping is what took the ESP32 poll
cycle from 33 transactions to 9.

| Address | Offset | Name | Units | Meaning |
|---|---|---|---|---|
| `0 + ch*48` | 0 | `eChX_Status` | bitfield | Status word, §2.7 |
| `4 + ch*48` | 4 | `eChX_CellVoltage` | V | Cell voltage, **12-bit internal ADC** |
| `8 + ch*48` | 8 | `eChX_CellCurrent` | A | Cell current, 12-bit internal ADC. Negative = discharge |
| `12 + ch*48` | 12 | `eChX_SenseVoltage` | V | `Vsense_V`, the **16-bit ADS131M08** voltage |
| `16 + ch*48` | 16 | `eChX_SenseCurrent` | A | `Isense_A`, the 16-bit ADS131M08 current |
| `20 + ch*48` | 20 | `eChX_CellTemp` | °C | **Measured** cell temperature, from the ADS1119 |
| `24 + ch*48` | 24 | `eChX_ChargeAcc_mAh` | mAh | Charge-direction charge total, §2.8.1 |
| `28 + ch*48` | 28 | `eChX_ChargeAcc_mWh` | mWh | Charge-direction energy total |
| `32 + ch*48` | 32 | `eChX_ChargeRuntime_s` | s | Seconds spent charging this run |
| `36 + ch*48` | 36 | `eChX_DischargeAcc_mAh` | mAh | Discharge-direction charge total |
| `40 + ch*48` | 40 | `eChX_DischargeAcc_mWh` | mWh | Discharge-direction energy total |
| `44 + ch*48` | 44 | `eChX_DischargeRuntime_s` | s | Seconds spent discharging this run |

Channel 0 occupies 0–44, channel 7 occupies 336–380.

> **`eChX_CellVoltage` / `eChX_CellCurrent` are the 12-bit on-chip ADC,
> despite the naming.** The 16-bit ADS131M08's engineering values are the
> *sense* pair two registers along. Every host interface — HTTP, BLE, the
> panel — shows the 12-bit path unless it explicitly reads the sense pair.
> The sense pair is what the CC loop regulates against and what the
> accumulators integrate.

`eChX_CellTemp` is the **measurement**, written directly by CPU2 from the two
ADS1119 converters on I2CB. The configured min/max window is a separate pair
in the settings block. `mirrorCpu1Status()` deliberately does not touch this
register — it has no CPU1 source.

#### 2.8.1 Counter semantics

Six counters per slot, two independent sets:

| Set | mAh | mWh | seconds |
|---|---|---|---|
| Charge | `eChX_ChargeAcc_mAh` | `eChX_ChargeAcc_mWh` | `eChX_ChargeRuntime_s` |
| Discharge | `eChX_DischargeAcc_mAh` | `eChX_DischargeAcc_mWh` | `eChX_DischargeRuntime_s` |

- Integrated on CPU1 in `C1()` (`bts_cpu1.c:1654`) from `Isense_A` and
  `Vsense_V` — the **16-bit ADS131M08** pair, the same sensor the CC loop
  regulates against.
- Both sets accumulate **positive magnitude into their own direction**, so a
  charge followed by a discharge leaves two separate positive totals rather
  than cancelling.
- The seconds counter advances on the **same timestep** as its set's mAh and
  mWh, so all three of a direction stay consistent.
- **They advance only while a slot is genuinely running** — `RUNNING` and not
  `PAUSED`, not `STOPPED`, not `END`, not calibrating. A paused slot's
  counters freeze and resume exactly where they left off; that is the point
  of the PAUSED state.
- **They reset only on a fresh start**, and only the set for the direction
  starting:

  | Transition | Effect |
  |---|---|
  | `STOPPED → CHARGING` | Charge set zeroed. Discharge set untouched |
  | `STOPPED → DISCHARGING` | Discharge set zeroed. Charge set untouched |
  | `END → CHARGING` / `→ DISCHARGING` | Same as above |
  | `PAUSED → resume` | **Nothing** zeroed |
  | Trip, fault, or watchdog pause | **Nothing** zeroed |

  So a full charge-then-discharge cycle ends with both sets populated, which
  is the intended result. In a group the leader's reset propagates to every
  follower.
- The step is the C1 task period. The C tasks rotate C1→C2→C3 off the
  `TASKC_FREQ_HZ` (20 Hz) timer, so C1 sees every third tick — 6.667 Hz, a
  150 ms rectangular step. A host wanting finer resolution should integrate
  its own polled samples, as the ESP32 proxy does (`coulomb_counter.c`).
- All six are `REG_ACCESS_RO`: a host cannot zero them on demand. The
  start-of-direction reset is what replaces that.
- They **survive a reset**. CPU2 saves all six to F-RAM every 6 s and on each
  state transition, and restores them at boot — see §2.10.

> There is no dedicated HTTP or BLE field for the raw counters, but the
> `/api/status` slot object carries them under `bts{}` (§1.3) and the BLE
> slot-status record carries all six from proto 3. A direct read is
> `GET /api/registers?addr=0&count=12` per slot, or one I2C burst.

---

### Settings block — base 384, stride 96, `ch` = 0–7

`BTS_SET_ADDR(ch, off)`. Everything a host writes, grouped per slot so
configuring a slot is also one burst. 23 of the 24 registers are used.

| Address | Offset | Name | Access | Units | Meaning |
|---|---|---|---|---|---|
| `384 + ch*96` | 0 | `eChX_Mode` | **RW** | bitfield | Run/charge/calibrate/pause/resume command. See §2.7 |
| `388 + ch*96` | 4 | `eChX_ChargeVoltageMin` | RW | V | Charge-phase lower voltage bound |
| `392 + ch*96` | 8 | `eChX_ChargeVoltageMax` | RW | V | Charge-phase voltage ceiling; latched into `vref_charge_V` at start |
| `396 + ch*96` | 12 | `eChX_DischargeVoltageMin` | RW | V | Discharge cutoff; latched into `vref_discharge_V` |
| `400 + ch*96` | 16 | `eChX_DischargeVoltageMax` | RW | V | Discharge-phase upper voltage bound |
| `404 + ch*96` | 20 | `eChX_ChargeCurrentMin` | RW | A | Charge termination current. Loaded into `iref_cuttout_A` and **never read** |
| `408 + ch*96` | 24 | `eChX_ChargeCurrentMax` | RW | A | Charge current setpoint |
| `412 + ch*96` | 28 | `eChX_DischargeCurrentMin` | RW | A | Discharge cutoff current |
| `416 + ch*96` | 32 | `eChX_DischargeCurrentMax` | RW | A | Discharge current setpoint |
| `420 + ch*96` | 36 | `eChX_MinCellTemp` | RW | °C | Configured lower trip limit |
| `424 + ch*96` | 40 | `eChX_MaxCellTemp` | RW | °C | Configured upper trip limit |
| `428 + ch*96` | 44 | `eChX_F28V_Gain` | RW | V per V-at-pin | Internal-ADC voltage gain |
| `432 + ch*96` | 48 | `eChX_F28V_Offset` | RW | V | Internal-ADC voltage offset |
| `436 + ch*96` | 52 | `eChX_F28I_Gain` | RW | A per V-at-pin | Internal-ADC current gain |
| `440 + ch*96` | 56 | `eChX_F28I_Offset` | RW | A | Internal-ADC current offset |
| `444 + ch*96` | 60 | `eChX_IoutGain_pu` | RW | pu per A | A → per-unit, for the control loop's setpoint |
| `448 + ch*96` | 64 | `eChX_IoutOffset_pu` | RW | pu | |
| `452 + ch*96` | 68 | `eChX_IoutGain_A` | RW | A per pu | per-unit → A, for reporting. **Reciprocal of `IoutGain_pu`** |
| `456 + ch*96` | 72 | `eChX_IoutOffset_A` | RW | A | |
| `460 + ch*96` | 76 | `eChX_VoutGain_pu` | RW | pu per V | V → per-unit |
| `464 + ch*96` | 80 | `eChX_VoutOffset_pu` | RW | pu | |
| `468 + ch*96` | 84 | `eChX_VoutGain_V` | RW | V per pu | per-unit → V. **Reciprocal of `VoutGain_pu`** |
| `472 + ch*96` | 88 | `eChX_VoutOffset_V` | RW | V | |
| `476 + ch*96` | 92 | `eChX_SettingsSpare` | RO | — | Reserved, reads 0.0 |

Channel 0 occupies 384–476, channel 7 occupies 1056–1148.

**The temperature window** is the pair at offsets 36/40 — the *configured*
trip limits, not a measurement. The measured temperature is `eChX_CellTemp`
in the runtime block. Both limits are mirrored into the F-RAM calibration
image.

**The 12-register calibration group** is offsets 44 to 88 — that is
`BTS_CAL_BASE(ch) = BTS_SET_BASE(ch) + 11` on the C2000, i.e. byte address
**428 + ch×96**. Its internal order is unchanged from v1 and matches
`BTS_channelCalibration`'s float members, so it doubles as the F-RAM image
layout and `saveCalibration()` / `loadCalibration()` index through it exactly
as before.

A write anywhere in the calibration group makes CPU1 reload the **whole
channel** and schedule a recalculation (`BTS_loadCalibrationFromRegisters()`)
— it is one of the three cases CPU1 decodes at all.

The two reciprocal pairs are stored separately and validated against each
other to within 0.1 %, which is what catches a partially-written F-RAM block.
Typical good values: `IoutGain_pu ≈ 0.100`, `VoutGain_pu ≈ 0.203`. Validation
windows are in [`calibration-design.md`](calibration-design.md) §8.2.

> **Writing the calibration registers does not persist them.** They live in
> RAM until an explicit save — either `eCalibrationMode = 2.0f` (the legacy
> path) or `CAL_CMD_COMPUTE_SAVE`.

The eight limit registers are **latched by `modeCallback()` at start**, not
applied live. Write the limits first, then the mode.

---

### Unit block — base 1152

| Address | Name | Access | Units | Meaning |
|---|---|---|---|---|
| 1152 | `eChargeDisableV` | **RW** | V | Below this, no slot will start at all. Default 9.0 |
| 1156 | `eChargeRestrictV` | **RW** | V | Below this, charge is refused. Default 10.0 |
| 1160 | `eDischargeRestrictV` | **RW** | V | Above this, discharge is refused. Default 15.0 |
| 1164 | `eDischargeDisableV` | **RW** | V | Above this, discharge is disabled. Default 16.0 |
| 1168 | `eCalibrationMode` | **RW** | command | Writing exactly `2.0f` triggers a deferred F-RAM save of the whole calibration image. **No acknowledgement**, and the register is never cleared. Decoded with no tolerance — `1.9999f` does nothing |
| 1172 | `eUnitState` | RO | enum | `UnitState`, 0–4. See §1.3.1 |
| 1176 | `eInputVoltage` | RO | V | DC input bus voltage |
| 1180 | `eTripStatus` | RO | bitfield | Two bits per channel. **Always 0** — see §2.7 |
| 1184 | `eSlotMode` | RO | 0–7 | `BTS_SlotMode`. Low two bits = group size, bit 2 selects the converter |
| 1188 | `eSlotEnable` | RO | 0–7 | Index of the **highest enabled** slot: 0 enables slot 1 alone, 7 enables all eight |
| 1192 | `eGroupSize` | RO | 1/2/4/8 | Slots per group, `1 << (mode & 3)` |
| 1196 | `eHostWatchdog_s` | **RW** | s | Host watchdog timeout. Default **30.0**. **0 disables** — see §2.9 |
| 1200 | `eCalSlot` | **RW** | 0–7 | Slot under calibration. **255 = none** |
| 1204 | `eCalCommand` | **RW** | opcode | Command, 0–8. **Consumed on write and self-clears to 0** |
| 1208 | `eCalArgument` | **RW** | varies | Float payload. **Write this BEFORE the opcode** |
| 1212 | `eCalStatus` | RO | bitfield | Calibration progress, §1.16.2 |
| 1216 | `eCalResult` | RO | code | Outcome of the last calibration command, §1.16.3 |
| 1220 | `eWatchdogRemaining_s` | RO | s | Live watchdog countdown — see §2.9 |
| 1224 | `eCalAdsV_pu` | RO | pu | ADS131M08 voltage, **raw pre-gain** |
| 1228 | `eCalAdsI_pu` | RO | pu | ADS131M08 current, raw pre-gain |
| 1232 | `eCalAdsV_V` | RO | V | ADS131M08 voltage, post-gain |
| 1236 | `eCalAdsI_A` | RO | A | ADS131M08 current, post-gain |
| 1240 | `eCalF28V_pu` | RO | V at the ADC pin | Internal ADC voltage, raw pre-gain |
| 1244 | `eCalF28I_pu` | RO | V at the ADC pin | Internal ADC current, raw pre-gain |
| 1248 | `eCalF28V_V` | RO | V | Internal ADC voltage, post-gain |
| 1252 | `eCalF28I_A` | RO | A | Internal ADC current, post-gain |
| 1256 | `eCalTemp_C` | RO | °C | Live cell temperature of the slot under calibration |

**1256 is the top of the map.** A read past it repeats 1256 (§2.4).

#### Global voltage thresholds — 1152 to 1164

The DC **input bus** guard, not cell voltage. Drives `eUnitState`. Defaults
from `DEFAULT_CHARGE_DISABLE_V` and friends, installed when the persisted
values fail validation.

> **These never persisted before the calibration work.** The F-RAM block for
> channel 4 collided with `EEPROM_GLOBAL_V_ADDR`, so `saveAllCalibration()`
> wrote the globals at `0x0100` and channel 4 then overwrote them; at the
> next boot they failed validation and the defaults were silently
> reinstalled. Fixed by a fixed 128-byte per-channel stride with the globals
> moved to `0x0400`. The guard is checked both at mode-write time and again
> at 10 Hz, so a marginal input stops a slot a fraction of a second after it
> starts.

#### Slot grouping — 1184 to 1192

Latched from the MODE/ENABLE dip switches by CPU1 at boot and mirrored here,
so a host can see how the unit is strapped without reading the switches
itself. Both straps arrive through an SN74HC148 8:3 priority encoder.

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

#### Calibration control — 1200 to 1216

Unit-scoped rather than per-slot because only one slot calibrates at a time;
the per-slot form would need 72 registers (144 words) and does not fit in
`CPU2TOCPU1RAM`.

> **Ordering is not advisory.** The command is consumed the instant it is
> written and the register self-clears, so an argument that arrives
> afterwards applies to nothing. Write 1208, then 1204, then read 1216.
> A burst write from 1200 with three registers achieves slot, command,
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

#### Calibration live telemetry — 1224 to 1256

A window on the slot named by `eCalSlot`. **Zero when no slot is selected.**

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

> **Registers 1200 to 1256 are one contiguous 15-register burst.** That is
> how the ESP32 refreshes the whole calibration state in a single
> transaction (`poll_cal_window()`, `bts_link.c`), and it is skipped entirely
> unless calibration is live — a feature used once per unit on a bench does
> not lengthen the normal 9-transaction cycle. Index 1 of that burst is
> `eCalCommand`, which self-clears and carries nothing useful for a host.
>
> The ESP32 mirror currently declares this window as **14** registers and is
> one register out of step across it. See §2.11.

---

## 2.9 The host watchdog

A supervision timeout that pauses every running slot if the host stops
talking. Before v2 there was none: if the ESP32 lost power or its I2C link
dropped, **the converters kept running**. That is the safety gap this closes.

| | |
|---|---|
| **Timeout register** | `eHostWatchdog_s` (1196), RW, seconds. Default **30.0** |
| **Countdown register** | `eWatchdogRemaining_s` (1220), RO, seconds |
| **Tick** | CPU Timer 1 ISR on CPU2, 8 Hz |
| **On expiry** | Every slot that is `CHARGING` or `DISCHARGING` → `PAUSED` with `WD_TRIPPED` set, converter off, counters frozen and intact |
| **Disable** | Write `0.0` to `eHostWatchdog_s` |

### What reloads it

**Any host command on any interface**, from exactly one hook per interface
rather than scattered through the parsers:

| Interface | Hook |
|---|---|
| I2C register **write** | `applyHostRegisterWrite()` (`com_cpu2.c:2553`) |
| I2C register **read** | `i2cSlaveFifoISR()` transmit branch (`com_cpu2.c:2915`) |
| UART AT command | via `applyHostRegisterWrite()` |
| CAN register access | via `applyHostRegisterWrite()` |

> ### The read hook is the one that matters
>
> A polling host proves it is alive by **reading**. The ESP32's steady state
> is reads only — nine read transactions every 250 ms and not a single write
> — so a unit that reloaded on writes alone would pause every running slot
> 30 s after the last mode command while the link was perfectly healthy.
>
> The hook sits on the transmit side rather than the address phase, because
> that is where a read is unambiguous; the address phase is shared with a
> write.
>
> **Verified on hardware:** `eWatchdogRemaining_s` holds steady at 30.0 while
> the ESP32 polls, with no writes on the bus.

### Reading the countdown

`eWatchdogRemaining_s` reads **0** both when the watchdog has **fired** and
when it is **disabled**. A host distinguishes the two by reading
`eHostWatchdog_s`, which is 24 bytes away in the same burst: timeout 0 means
disabled, timeout non-zero with remaining 0 means fired.

CPU2 writes the countdown straight into `registers[]` — no IPC, since CPU2
owns both the register file and the timebase.

### Where the pause happens

CPU2 owns the countdown because it owns the interfaces and the timebase. But
**CPU2 never writes a slot's control state** — the single-writer rule stands.
On expiry it bumps `supervision.wdPauseSeq` in the message RAM, and **CPU1**
performs the pause in `serviceHostWatchdog()` (`bts_cpu1.c:230`), because
CPU1 owns `enable_logic` and the control loop.

### This is not over-current protection

The watchdog is a supervision timeout measured in **seconds**. Hardware
over-current trips are disabled in this build and the software check in
`BTS_tripEpwm()` remains the only fast protection. Do not describe or rely on
the watchdog as anything else.

> **Known issue: a spurious disable warning.** The AT console periodically
> prints `WARNING: host watchdog DISABLED - slots will not pause if the host
> stops responding` even when `eHostWatchdog_s` reads 30.0 and the countdown
> is healthy. `hostWdDisableWarn` is set only where a write of `0.0` arrives
> (`com_cpu2.c:2573`) and the flag reads 0 when sampled, so the trigger has
> not been identified. Supervision is verifiably armed — the message is
> cosmetic, but it is alarming and wrong. Ignore it and check
> `eHostWatchdog_s` / `eWatchdogRemaining_s` instead.

---

## 2.10 Slot state persistence

A slot that was mid-run when the BTS reset comes back knowing what it was
doing and how far it had got — **without silently resuming into a cell that
may have been swapped in the meantime.**

### What is saved

Every **6 s**, and additionally on any state transition, CPU2 writes a
per-slot record to the FM24V10 F-RAM: a header, the running direction and END
flag at save time, all six counters, a save counter and a CRC-32
(`BTS_slotRuntimeState`, `registers.h:553`).

| | |
|---|---|
| **Base** | `0x0500` (`STATE_FRAM_BASE`) |
| **Stride** | 32 bytes (`STATE_FRAM_STRIDE`), fixed and decoupled from `sizeof` |
| **Extent** | `0x0500` – `0x05FF`, 8 slots. Clear of the calibration blocks at `0x0000`–`0x03FF` and the global thresholds at `0x0400` |

A **paused** slot is saved as running in its held direction: that is what a
restore has to reconstruct, and what a power cut mid-pause should come back
as.

Writes are never issued from an ISR. `mirrorCpu1Status()` sets a pending
flag, and `BTS_serviceDeferredWork()` does the transfer from the idle loop —
one slot per pass, so the eight are staggered across the 6 s window and a
save never holds the I2C controller for eight transfers at once. F-RAM has no
write-endurance concern at this rate (10¹⁴ cycles), so the periodic write is
unconditional and there is no wear-levelling.

### Boot restore

`loadSlotStates()` (`com_cpu2.c:1272`) runs after calibration and populates
the runtime counters, then raises **one** IPC flag once the whole file is
consistent — not one per slot.

| Record | Result |
|---|---|
| Invalid or absent | Slot starts `STOPPED`, counters zeroed. **The normal first-boot case — not logged as an error** |
| Valid, saved state was STOPPED or END | Counters restored, that state restored. Nothing was running, so nothing to resume |
| Valid, saved state was CHARGING or DISCHARGING | Counters restored **and** the slot comes back `PAUSED` + `RESTORED` with the saved direction bit. **The converter stays off** |

> ### A slot never resumes power by itself after a reset
>
> This is the safety-critical rule. The cell may have been changed while the
> unit was off, so a restored slot resumes only on an explicit command.
> `applyRestoredSlotStates()` (`bts_cpu1.c:258`) calls `slotStop()` first and
> then `slotPause()` — it cannot re-energise a slot.
>
> **Verified on hardware:** a slot mid-run through a reset came back `PAUSED`
> + `RESTORED` with its counters intact and refused to auto-resume.
>
> A host must surface `RESTORED` to an operator rather than clearing it
> automatically. The ESP32 test engine does not auto-resume.

Periodic saves are **armed only after CPU1 acknowledges the restore**, so a
6 s tick cannot overwrite a record before it has been applied.

---

## 2.11 Where the ESP32 mirror disagrees with the C2000

`esp32-btle-proxy/components/bts_link/include/bts_regs.h` is a
**hand-maintained transcription** of `tida-010086/bts_F2837xD_8ch/registers.h`.
There is no build coupling between the two projects, so they can drift.

### Fixed 2026-09-20 — the mirror was one register short

**The ESP32 mirror was missing `eWatchdogRemaining_s`, which put every
calibration telemetry address below it 4 bytes low.** Corrected; recorded here
because the failure mode is instructive and the drift is easy to reintroduce.

`bts_regs.h` had `BTS_REG_CAL_ADS_V_PU` at 1220 running to
`BTS_REG_CAL_TEMP_C` at 1252, with `BTS_TOTAL_REGISTERS` 314 and a
15-register window declared as 14.

| Symbol | `registers.h` (authoritative) | mirror, before the fix |
|---|---|---|
| `eWatchdogRemaining_s` | 1220, RO | absent |
| `eCalAdsV_pu` … `eCalTemp_C` | 1224 – 1256 | 1220 – 1252 |
| Register count | 315 | 314 |
| Calibration burst | 15 registers from 1200 | 14 from 1200 |

Why it would have been painful to find: `poll_cal_window()` is read **only
while a calibration is active**, so every normal poll cycle was unaffected and
the unit looked healthy. The corruption would have surfaced as plausible but
wrong captured per-unit values during a bench calibration, with `temp_c`
carrying `eCalF28I_A`.

Current state, verified: the mirror declares 315 registers,
`BTS_REG_WATCHDOG_REMAINING_S` 1220, telemetry 1224–1256,
`BTS_CAL_WINDOW_COUNT` 15, and `poll_cal_window()` skips index 5 and assigns
6–14 to the nine telemetry values.

**The C2000 addresses are what the hardware answers on. Fix the mirror against
`registers.h`, never the other way round.**

### Deliberate differences that still catch a reader

Every region base, stride and per-slot offset agrees between the two files,
and so do the opcode, result-code and status-bit numbering. Three conventions
differ, and the **same identifier means different things**:

| Identifier | In `registers.h` (C2000) | In `bts_regs.h` (ESP32) |
|---|---|---|
| `BTS_STATUS_*`, `BTS_CAL_ST_*` | bit **positions** (`0U`, `1U`, …) | bit **masks** (`1u << 0`, …) |
| `BTS_RT_*`, `BTS_SET_*`, `BTS_CAL_F28V_GAIN` … | register **index** offsets (0, 1, 2 …) | **byte** offsets (0, 4, 8 …) |
| `BTS_RT_BASE`, `BTS_SET_BASE` | function-like macros returning an **index** | bare constants `0` and `384`, **byte addresses** |

The convention is consistent within each file — the C2000 indexes
`registers[]`, the ESP32 addresses the wire — but copying a line between the
two files compiles and is silently wrong. The v2 reorder sharpened this
rather than softening it: `BTS_RT_STATUS` is `0U` in both files, while
`BTS_RT_CELL_VOLTAGE` is `1U` on the C2000 and `4` on the ESP32.

### Where the design document disagrees with the source

| Item | Design doc | Source |
|---|---|---|
| Settings registers in use (§1.4) | "24 registers of which 21 are used; 3 spare" | **23 used, 1 spare.** The doc's own table lists 23 named registers at offsets 0–88 with one spare at 92, and `registers.c` declares exactly one `eChX_SettingsSpare` per slot. `registers.h`'s comment agrees with the source; the ESP32 mirror repeats the doc's "21 of the 24" |
| Slot state model (§2.1) | Five states, END reached by "termination" | The five states and every transition are implemented, but **no C2000 path currently sets END**. `status[].finished` is cleared on start, pause and stop, and restored from F-RAM, but never asserted by a termination — `iref_cuttout_A` is still loaded and never read. The bit is driven end to end; nothing lights it yet |

Everything else in the design document — the three region bases and strides,
the 315 total, the top address 1256, the status bit positions, the mode
command bits, the counter reset rules, the 30 s default, the four reload
hooks, the `0x0500`/32 F-RAM block and the boot-restore rules — matches the
implementation exactly.
