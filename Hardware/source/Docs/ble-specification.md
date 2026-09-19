# BLE Interface Specification

The complete GATT surface of the eight-channel battery test system (BTS), as
implemented by the ESP32 proxy in `esp32-btle-proxy/components/ble_svc/`.

This is the reference for anyone writing a BLE client. The operator procedure
is in [`README.md`](README.md); the calibration engineering contract is in
[`calibration-design.md`](calibration-design.md).

Everything here is read from source. Where the firmware declares something it
never actually writes, that is called out rather than glossed over.

---

## Read this first: the endianness split

> **BLE records are packed LITTLE-endian. The I2C register wire format is
> BIG-endian. They are opposite.**
>
> | Layer | Byte order | Defined by |
> |---|---|---|
> | GATT characteristic values | **little**-endian | `ble_proto.h` |
> | BTS I2C register payloads | **big**-endian | `floatGetWireByte()` in `com_cpu2.c` |
>
> Little-endian is the ESP32's native order and the order a browser's
> `DataView` uses with `littleEndian=true`, so a BLE client never byte-swaps.
> The C2000 is a 16-bit-word machine that emits its floats most-significant
> byte first; that conversion happens inside `bts_regs.h`
> (`bts_wire_to_f32()` / `bts_f32_to_wire()`) and **nothing above `bts_link`
> ever sees the C2000's byte order**.
>
> This matters because the same quantity — say `ads_v_pu` — appears in both
> formats: at register 1056 over I2C as big-endian, and at offset 12 of
> characteristic `000c` as little-endian. A client that reads one and assumes
> the other's order gets a plausible-looking but wrong float. Python clients
> should use `"<"` prefixes throughout (as `ble_verify.py` and `calibrate.py`
> do); C clients on a little-endian host can `memcpy` a BLE record directly
> into the packed struct.

---

## 1. Service and UUIDs

| | |
|---|---|
| **Service UUID** | `e5f10001-9a4c-4b7d-8f2e-1c3a5b7d9f01` |
| **Type** | Primary |
| **Characteristic count** | 11 |

### 1.1 UUID derivation

Every UUID in this service is the same 128-bit base with a 16-bit
discriminator substituted into bytes 2–3 of the leading group:

```
e5f1 XXXX -9a4c-4b7d-8f2e-1c3a5b7d9f01
     ^^^^
     discriminator, 0x0001 = the service itself
```

In source this is the `TESTER_UUID128(a, b)` macro (`ble_svc.c:31-33`), where
`a` is the high byte and `b` the low byte of the discriminator:

```c
#define TESTER_UUID128(a, b)                                            \
    BLE_UUID128_INIT(0x01, 0x9f, 0x7d, 0x5b, 0x3a, 0x1c, 0x2e, 0x8f,    \
                     0x7d, 0x4b, 0x4c, 0x9a, (b), (a), 0xf1, 0xe5)
```

NimBLE's `BLE_UUID128_INIT` takes its bytes **least-significant first**, which
is why the array reads as the UUID reversed. A client only needs the textual
form. In Python:

```python
def uuid(disc):
    return f"e5f1{disc:04x}-9a4c-4b7d-8f2e-1c3a5b7d9f01"
```

Discriminators are allocated sequentially and **are never renumbered**. The
two calibration characteristics were appended as `000b` and `000c`; the nine
that existed before kept their numbers, because the discriminator is the
client's contract (`ble_svc.c:543-545`).

---

## 2. Characteristic table

All 11 characteristics of service `e5f10001-…`, in GATT declaration order
(`s_gatt_svcs[]`, `ble_svc.c:499-562`).

| # | Discriminator | Name | Properties | Payload struct | Size |
|---|---|---|---|---|---|
| 1 | `0002` | Unit status | READ, NOTIFY | `ble_unit_status_t` | 20 B |
| 2 | `0003` | Command | WRITE | `ble_cmd_t` | 4 B |
| 3 | `0004` | Slot select | READ, WRITE | `uint8_t` | 1 B |
| 4 | `0005` | Slot config | READ, WRITE | `ble_slot_config_t` | 80 B |
| 5 | `0006` | Slot result | READ | `ble_slot_result_t` | 116 B |
| 6 | `0007` | Slot serial | WRITE | UTF-8 text, no NUL | 1–31 B |
| 7 | `0008` | Catalogue index | READ, WRITE | `uint8_t` | 1 B |
| 8 | `0009` | Catalogue entry | READ | `ble_catalog_entry_t` | 96 B |
| 9 | `000a` | Slot status | READ, NOTIFY | `ble_slot_status_t` | 40 B |
| 10 | `000b` | Calibration control | WRITE | `ble_cal_cmd_t` | 8 B |
| 11 | `000c` | Calibration status | READ, NOTIFY | `ble_cal_status_t` | 48 B |

Characteristics 1–9 are the pre-existing surface (`BLE_PROTO_VERSION` 1);
10 and 11 were added for version 2.

No characteristic has WRITE-WITHOUT-RESPONSE, INDICATE, or any security
property. There is **no pairing, bonding or encryption** — the link is open,
and the device is expected to live on a bench, not on a hostile network.

### 2.1 Write length is exact

Every write goes through `read_flat()` (`ble_svc.c:237-249`), which compares
the attribute value length against `sizeof(struct)` and **rejects anything
that is not an exact match** with `BLE_ATT_ERR_INVALID_ATTR_VALUE_LEN`
(0x0D). A client must not pad, truncate, or send a partial record. The one
exception is the slot-serial characteristic, which takes a variable-length
string (see §3.6).

---

## 3. Characteristic reference

Offsets are byte offsets from the start of the attribute value. All
multi-byte fields are **little**-endian. Every struct is
`__attribute__((packed))` and hand-padded to a multiple of 4, so no compiler
inserts anything.

### 3.1 `0002` — Unit status (READ, NOTIFY), 20 B

`ble_unit_status_t`. Built by `build_unit_status()` from the `bts_link`
snapshot.

| Offset | Size | Type | Field | Meaning |
|---|---|---|---|---|
| 0 | 1 | `uint8` | `version` | `BLE_PROTO_VERSION`, currently **2**. See §7. |
| 1 | 1 | `uint8` | `slot_count` | `SLOT_COUNT` = 8 |
| 2 | 1 | `uint8` | `online` | 1 = the last I2C poll cycle to the BTS completed |
| 3 | 1 | `uint8` | `unit_state` | `bts_unit_state_t`, see §3.1.1 |
| 4 | 4 | `uint32` | `trip_status` | Two bits per channel, CMPSS then GPIO. See §3.1.2 |
| 8 | 4 | `float32` | `input_voltage_v` | DC input bus volts, from register 984 |
| 12 | 4 | `uint32` | `uptime_s` | ESP32 uptime in seconds, not a wall clock |
| 16 | 1 | `uint8` | `stats_live` | 1 if the BTS populates its own mAh/mWh accumulators. **Always 0** — see §3.1.3 |
| 17 | 1 | `uint8` | `wifi_connected` | 1 when the ESP32 is joined to a station network |
| 18 | 2 | `uint16` | `reserved` | Zero |
| | **20** | | | |

Python: `struct.unpack("<BBBBIfIBBH", data)`

#### 3.1.1 `unit_state` values

Mirrors the C2000 `UnitState` enum. Governs whether slots may charge or
discharge at all.

| Value | Name | Effect |
|---|---|---|
| 0 | `INPUT_LOW_CHARGE_DISABLED` | Input below `eChargeDisableV` (default 9.0 V). **No slot will start.** |
| 1 | `INPUT_LOW_CHARGE_RESTRICTED` | Input below `eChargeRestrictV` (default 10.0 V). Charge refused. |
| 2 | `INPUT_OK` | Normal |
| 3 | `INPUT_HIGH_DISCHARGE_RESTRICTED` | Input above `eDischargeRestrictV` (default 15.0 V). Discharge refused. |
| 4 | `INPUT_HIGH_DISCHARGE_DISABLED` | Input above `eDischargeDisableV` (default 16.0 V) |

#### 3.1.2 `trip_status` bit layout

```
bit (ch*2)     CMPSS over-current trip on channel ch
bit (ch*2 + 1) GPIO group trip on channel ch
bits 16-31     reserved, zero
```

> **This word is currently always zero.** The bits are set only in
> `epwmTripISR()` (`bts_cpu1.c:1715-1718`), whose trip-zone interrupt is
> enabled per channel only when `BTS_TRIP_HW_CHn_ENABLED` is true
> (`bts_hal.c:1098-1102`). All eight are `(false)` in this build
> (`bts_user_settings.h:113-120`), so the ISR is never entered and the
> hardware trip sources are masked at the module. The **software**
> over-current path (`BTS_tripEpwm()`, `bts.h:350-380`) forces the trip zone
> and brings the PWM down, but it does not raise the interrupt and does not
> set these bits. Do not use `trip_status` as a fault indicator on this
> firmware.

#### 3.1.3 `stats_live`

`bts_link_stats_are_live()` probes the BTS accumulators at start-up — the
charge pair at `eChX_ChargeAcc_mAh` / `_mWh` and the discharge pair at
`eChX_DischargeAcc_mAh` / `_mWh`. The current C2000 firmware does populate
them, but the probe is a **positive test only**: a unit that has been idle
since power-up reads all-zero and the flag stays **false**, exactly as it did
on the older firmware that never wrote them at all.

Either way the ESP32 keeps its own integration (`coulomb_counter.c`) as the
reported figure, so `live_mah` / `live_mwh` in the slot record are still the
ones to use. The flag only says whether the BTS values are worth comparing
against.

---

### 3.2 `0003` — Command (WRITE), 4 B

`ble_cmd_t`. Self-addressed: the slot is in the payload, **not** taken from
slot-select.

| Offset | Size | Type | Field | Meaning |
|---|---|---|---|---|
| 0 | 1 | `uint8` | `opcode` | `ble_cmd_op_t`, see below |
| 1 | 1 | `uint8` | `slot` | 0-based slot index. Ignored by `ABORT_ALL`. |
| 2 | 2 | `uint16` | `reserved` | Write 0 |
| | **4** | | | |

| Opcode | Name | Action |
|---|---|---|
| 1 | `BLE_CMD_START` | `test_engine_start(slot)` |
| 2 | `BLE_CMD_ABORT` | `test_engine_abort(slot)` |
| 3 | `BLE_CMD_CLEAR_FAULT` | `test_engine_clear_fault(slot)` |
| 4 | `BLE_CMD_ABORT_ALL` | `test_engine_abort_all()` |

Any other opcode returns `BLE_ATT_ERR_REQ_NOT_SUPPORTED` (0x06). A refusal by
the test engine returns `BLE_ATT_ERR_UNLIKELY` (0x0E); the reason is not
carried in the ATT error — read the slot's `state` and `fault` fields to find
out why (`ble_svc.c:270-279`).

---

### 3.3 `0004` — Slot select (READ, WRITE), 1 B

A single `uint8` slot index, 0 to 7. A write of 8 or more is rejected with
`BLE_ATT_ERR_INVALID_ATTR_VALUE_LEN`. Reading it returns the current
selection.

This is the stateful cursor described in §4.

---

### 3.4 `0005` — Slot config (READ, WRITE), 80 B

`ble_slot_config_t`.

**The read and the write address different slots.** A read returns the
configuration of the slot named by slot-select; a write applies to the slot
in the payload's own `slot` field (`ble_svc.c:341-372`). This asymmetry is
easy to trip over — always set the payload `slot` on a write, and do not
assume the write went where slot-select points.

| Offset | Size | Type | Field | Meaning |
|---|---|---|---|---|
| 0 | 1 | `uint8` | `slot` | Target slot on write; echoed on read |
| 1 | 1 | `uint8` | `chemistry` | `cell_chemistry_t`: 0 LCO, 1 LTO, 2 LFP, 3 NMC, 4 NCA |
| 2 | 1 | `uint8` | `auto_recharge` | 1 = recharge to the shipping state after the discharge |
| 3 | 1 | `uint8` | `reserved` | Write 0 |
| 4 | 4 | `float32` | `capacity_mah` | 0 → the model's default |
| 8 | 4 | `float32` | `charge_c` | C-rate. 0 → the chemistry's default |
| 12 | 4 | `float32` | `discharge_c` | C-rate. 0 → the chemistry's default |
| 16 | 4 | `float32` | `shipping_pct` | Storage state of charge, percent. `<= 0` on write → 60.0 |
| 20 | 4 | `uint32` | `max_duration_minutes` | Test timeout. 0 → no limit |
| 24 | 24 | `char[24]` | `model_name` | Not guaranteed NUL-terminated |
| 48 | 32 | `char[32]` | `serial` | Not guaranteed NUL-terminated |
| | **80** | | | |

Strings are fixed-width fields, **not** C strings. The firmware copies
`sizeof - 1` bytes and NUL-terminates itself (`ble_svc.c:362-364`); a client
decoding a read must split on the first `\0` and must not assume one is
present. Zero-fill the unused tail on a write.

A write with `slot >= 8` or `chemistry >= 5` is rejected with 0x0D. A refusal
by the test engine (for example, the slot is running) returns 0x0E.

---

### 3.5 `0006` — Slot result (READ), 116 B

`ble_slot_result_t`, for the slot named by slot-select. If the slot has no
stored result, everything except `slot` reads back zero and `valid` is 0.

| Offset | Size | Type | Field | Meaning |
|---|---|---|---|---|
| 0 | 1 | `uint8` | `slot` | Slot index |
| 1 | 1 | `uint8` | `valid` | 0 = no result; every field below is zero |
| 2 | 1 | `uint8` | `chemistry` | `cell_chemistry_t` |
| 3 | 1 | `uint8` | `recharged` | 1 = the auto-recharge to shipping ran |
| 4 | 4 | `float32` | `start_voltage_v` | Cell volts at test start |
| 8 | 4 | `float32` | `end_voltage_v` | Cell volts at discharge cutoff |
| 12 | 4 | `float32` | `rested_voltage_v` | Cell volts after the post-discharge rest |
| 16 | 4 | `float32` | `discharge_mah` | Measured capacity |
| 20 | 4 | `float32` | `discharge_mwh` | Measured energy |
| 24 | 4 | `float32` | `max_temp_c` | Peak cell temperature over the test |
| 28 | 4 | `float32` | `max_current_a` | Peak current magnitude |
| 32 | 4 | `float32` | `min_voltage_v` | Lowest cell voltage seen |
| 36 | 4 | `float32` | `max_voltage_v` | Highest cell voltage seen |
| 40 | 4 | `float32` | `recharge_mah` | Charge returned during the recharge phase |
| 44 | 4 | `float32` | `shipping_voltage_v` | Cell volts at the end of the recharge |
| 48 | 4 | `uint32` | `discharge_seconds` | Discharge phase duration |
| 52 | 8 | `int64` | `completed_unix` | See the note below |
| 60 | 24 | `char[24]` | `model_name` | Not guaranteed NUL-terminated |
| 84 | 32 | `char[32]` | `serial` | Not guaranteed NUL-terminated |
| | **116** | | | |

> **`completed_unix` is not a Unix epoch.** `test_engine.c:366` assigns it
> `esp_timer_get_time() / 1000000`, which is **seconds of ESP32 uptime**. The
> HTTP API is honest about this and calls the same value
> `completed_uptime_s`. The device has no real-time clock; a client that needs
> a wall-clock timestamp must apply its own at the moment it retrieves the
> result.

---

### 3.6 `0007` — Slot serial (WRITE), 1–31 B

The only variable-length characteristic. Write raw UTF-8 with **no NUL
terminator**: the handler rejects a zero-length write and anything of
`SERIAL_MAX` (32) bytes or more, then NUL-terminates internally
(`ble_svc.c:374-393`). So the accepted range is 1 to 31 bytes.

Applies to the slot named by **slot-select**, not to anything in the payload.
Intended for a barcode scanner acting as a keyboard wedge over a UI.

---

### 3.7 `0008` — Catalogue index (READ, WRITE), 1 B

A `uint8` cursor into the flat catalogue. Unlike slot-select this is **not
range-checked on write** — any value is accepted, and an out-of-range index
simply produces a catalogue entry whose `index` and `total` are set and whose
remaining fields are zero.

---

### 3.8 `0009` — Catalogue entry (READ), 96 B

`ble_catalog_entry_t`, for the index in characteristic `0008`.

The catalogue is one flat list so it can be paged with a single pair of
characteristics: **chemistries occupy `[0, chem_count)`, models follow at
`[chem_count, chem_count + model_count)`**. In this build that is 5
chemistries (LCO, LTO, LFP, NMC, NCA) then 9 models (Samsung 20Q/25R/30Q/30R,
Sony VTC3/VTC4/VTC5/VTC5A/VTC6), so `total` = 14.

| Offset | Size | Type | Field | Meaning |
|---|---|---|---|---|
| 0 | 1 | `uint8` | `index` | Echo of the requested index |
| 1 | 1 | `uint8` | `kind` | 0 = chemistry, 1 = model |
| 2 | 1 | `uint8` | `chemistry` | `cell_chemistry_t`. For a chemistry entry, equals `index` |
| 3 | 1 | `uint8` | `total` | Total catalogue entries. Read this first to size the walk |
| 4 | 4 | `float32` | `capacity_mah` | **Models only**; 0 for a chemistry |
| 8 | 4 | `float32` | `charge_v_max` | Charge ceiling. A model inherits the chemistry's if its own is 0 |
| 12 | 4 | `float32` | `discharge_v_min` | Discharge cutoff, same inheritance |
| 16 | 4 | `float32` | `storage_v` | Shipping-state cell voltage, from the chemistry |
| 20 | 4 | `float32` | `charge_c` | Default charge C-rate, from the chemistry |
| 24 | 4 | `float32` | `discharge_c` | Default discharge C-rate, from the chemistry |
| 28 | 4 | `float32` | `charge_current_max_a` | **Models only**; 0 for a chemistry |
| 32 | 4 | `float32` | `discharge_current_max_a` | **Models only**; 0 for a chemistry |
| 36 | 4 | `float32` | `temp_min_c` | Chemistry temperature window, low |
| 40 | 4 | `float32` | `temp_max_c` | Chemistry temperature window, high |
| 44 | 4 | `uint32` | `rest_minutes` | Rest period between phases |
| 48 | 24 | `char[24]` | `name` | Chemistry or model name |
| 72 | 24 | `char[24]` | `manufacturer` | **Models only**; empty for a chemistry |
| | **96** | | | |

If `index >= total` the record is zero apart from `index` and `total` — which
is also how a client discovers the end of the list without reading `total`
first.

---

### 3.9 `000a` — Slot status (READ, NOTIFY), 40 B

`ble_slot_status_t`. A **read** returns the slot named by slot-select; a
**notification** may be for any slot, so always decode the `slot` field
rather than assuming the selected one.

| Offset | Size | Type | Field | Meaning |
|---|---|---|---|---|
| 0 | 1 | `uint8` | `slot` | Slot index this record describes |
| 1 | 1 | `uint8` | `state` | `slot_state_t`, see §3.9.1 |
| 2 | 1 | `uint8` | `fault` | `slot_fault_t`, see §3.9.2 |
| 3 | 1 | `uint8` | `configured` | 1 = a cell profile has been applied |
| 4 | 4 | `float32` | `voltage_v` | Cell volts. **12-bit internal ADC**, from register `eChX_CellVoltage` |
| 8 | 4 | `float32` | `current_a` | Cell amps, same path. Negative = discharge |
| 12 | 4 | `float32` | `temp_c` | Cell temperature from the ADS1119 converters |
| 16 | 4 | `float32` | `live_mah` | ESP32-integrated charge for the current phase |
| 20 | 4 | `float32` | `live_mwh` | ESP32-integrated energy for the current phase |
| 24 | 4 | `float32` | `progress` | 0..1 and beyond; may exceed 1 on a cell over its rated capacity |
| 28 | 4 | `uint32` | `elapsed_s` | Seconds since the test started |
| 32 | 4 | `uint32` | `state_elapsed_s` | Seconds in the current state |
| 36 | 4 | `uint32` | `status_bits` | Raw BTS status word, see §3.9.3 |
| | **40** | | | |

Python: `struct.unpack("<BBBBffffffIII", data)`

> `voltage_v` and `current_a` are the **12-bit on-chip ADC** values, not the
> 16-bit ADS131M08. The 16-bit converter's engineering values live in
> registers 1092–1152 (`eChX_SenseVoltage` / `eChX_SenseCurrent`) and are
> reachable over HTTP or the generic register read; there is no GATT
> characteristic for them.

#### 3.9.1 `slot_state_t`

| Value | Name | | Value | Name |
|---|---|---|---|---|
| 0 | `IDLE` | | 5 | `DISCHARGE_REST` |
| 1 | `CHECK_REST` | | 6 | `RECHARGE` |
| 2 | `CHARGE` | | 7 | `COMPLETE` |
| 3 | `REST` | | 8 | `FAULT` |
| 4 | `DISCHARGE` | | 9 | `ABORTED` |

#### 3.9.2 `slot_fault_t`

| Value | Name | | Value | Name |
|---|---|---|---|---|
| 0 | `NONE` | | 6 | `TIMEOUT` |
| 1 | `OVER_TEMP` | | 7 | `BTS_OFFLINE` |
| 2 | `UNDER_TEMP` | | 8 | `UNIT_STATE` |
| 3 | `OVER_CURRENT` | | 9 | `NO_CELL` |
| 4 | `CMPSS_TRIP` | | 10 | `CELL_REVERSED` |
| 5 | `GPIO_TRIP` | | 11 | `COMMS` |

#### 3.9.3 `status_bits` — the BTS status word

Packed by `publishStatusToCpu2()` on C2000 CPU1 (`bts_cpu1.c:950-964`) and
carried through unchanged.

| Bit | Name | Set when | Written? |
|---|---|---|---|
| 0 | `RUNNING` | Slot is executing a charge or discharge | yes |
| 1 | `STOPPED` | Slot is not running | yes |
| 2 | `FINISHED` | — | **never** |
| 3 | `OVERCURRENT` | An over-current trip latched | **never in this build** |
| 4 | `CHARGING` | Mode bit 1 set at the last start | yes |
| 5 | `DISCHARGING` | Mode bit 1 clear at the last start | yes |
| 6 | `CONST_VOLTAGE` | Loop is in CV regulation | always 0, see below |
| 7 | `CONST_CURRENT` | Loop is in CC regulation | always 1, see below |
| 8 | `SLAVE_MODE` | Slot follows a lower-numbered group leader | yes |
| 9 | `GROUP_DISCONNECT` | A member of this slot's group fell out of sync | yes |
| 10 | `REVERSE_POLARITY` | Measured cell voltage is negative | yes |
| 11 | `SLOT_DISABLED` | Masked off by the ENABLE strap | yes |
| 12 | `CALIBRATING` | Slot is in the runtime calibration state | yes |
| 13 | `CAL_V_VALID` | Persisted voltage calibration is valid | yes |
| 14 | `CAL_I_VALID` | Persisted current calibration is valid | yes |
| 15–23 | — | Reserved. **Bit 23 is the hard ceiling.** See below | — |

Three of these are not what their names suggest:

- **Bit 2 (`FINISHED`) is never set.** `status[].finished` is read in
  `publishStatusToCpu2()` but assigned nowhere in the firmware. Use
  `state == COMPLETE` from the ESP32's own test engine instead.
- **Bit 3 (`OVERCURRENT`) is never set in this build**, for the same reason
  `trip_status` is always zero — see §3.1.2.
- **Bits 6 and 7 are constant.** The build is CC-only
  (`BTS_LAB_TYPE = BTS_LAB_CLOSED_LOOP_ACMC_IOUT` →
  `BTS_ISR_CL_MODE_CC`, `bts_user_settings.h:305-315`), so
  `ctrlMode_logic` is hard-assigned 0 (`bts.h:572-576`) and the CV branch is
  compiled out. Bit 7 is therefore always 1 and bit 6 always 0 whenever the
  slot is running. They are genuinely reported now — before the calibration
  work they were both stuck at 0 — but they cannot vary.

> **Why bit 23 is the ceiling.** The status word reaches a host as a
> `float32`, whose 24-bit significand represents integers exactly only up to
> 2²⁴ − 1. Bit 23 is the last bit that survives the conversion intact; bit 24
> and above would be silently rounded. The C2000 side must never publish past
> bit 23 (`registers.h:420-424`), which leaves bits 15–23 free for future use.

---

### 3.10 `000b` — Calibration control (WRITE), 8 B

`ble_cal_cmd_t`. Commands go straight through to the BTS; the ESP32 holds no
calibration state of its own (`ble_svc.c:283-288`).

| Offset | Size | Type | Field | Meaning |
|---|---|---|---|---|
| 0 | 1 | `uint8` | `opcode` | `bts_cal_cmd_t`, see §5.1 |
| 1 | 1 | `uint8` | `slot` | 0–7. **Read only by `ENTER`** |
| 2 | 2 | `uint16` | `reserved` | Write 0 |
| 4 | 4 | `float32` | `arg` | Command argument; ignored by the opcodes that take none |
| | **8** | | | |

Python: `struct.pack("<BBHf", opcode, slot, 0, arg)`

---

### 3.11 `000c` — Calibration status (READ, NOTIFY), 48 B

`ble_cal_status_t`. Unit-scoped: it reports the slot the **unit** has under
calibration (`eCalSlot`), and is unaffected by slot-select.

| Offset | Size | Type | Field | Meaning |
|---|---|---|---|---|
| 0 | 1 | `uint8` | `slot` | Slot under calibration, 0–7. **255 = none** |
| 1 | 1 | `uint8` | `active` | 1 when `eCalStatus` bit 0 is set |
| 2 | 1 | `uint8` | `v_tick` | Persisted voltage calibration valid (slot status bit 13) |
| 3 | 1 | `uint8` | `i_tick` | Persisted current calibration valid (slot status bit 14) |
| 4 | 4 | `uint32` | `status_bits` | `eCalStatus` bitfield, see §5.2 |
| 8 | 4 | `uint32` | `result` | `eCalResult` of the last command, see §5.3 |
| 12 | 4 | `float32` | `ads_v_pu` | ADS131M08 voltage, per-unit, **raw pre-gain** |
| 16 | 4 | `float32` | `ads_i_pu` | ADS131M08 current, per-unit, raw pre-gain |
| 20 | 4 | `float32` | `ads_v_v` | ADS131M08 voltage, volts, post-gain |
| 24 | 4 | `float32` | `ads_i_a` | ADS131M08 current, amps, post-gain |
| 28 | 4 | `float32` | `f28_v_pu` | Internal ADC voltage, volts-at-the-pin, raw pre-gain |
| 32 | 4 | `float32` | `f28_i_pu` | Internal ADC current, volts-at-the-pin, raw pre-gain |
| 36 | 4 | `float32` | `f28_v_v` | Internal ADC voltage, volts, post-gain |
| 40 | 4 | `float32` | `f28_i_a` | Internal ADC current, amps, post-gain |
| 44 | 4 | `float32` | `temp_c` | Live cell temperature of the slot under calibration |
| | **48** | | | |

Python: `struct.unpack("<BBBBII" + "f" * 9, data)`

The nine floats are exactly registers 1056–1088 in order. `_pu` means the
normalised converter reading **before** any calibration gain or offset — that
is the quantity the two-point fit consumes, and it is what the `< 0.2` /
`> 0.8` capture windows are checked against. All nine are zero when no slot
is selected.

> The `f28_*_pu` pair is not dimensionless. It is
> `(sum / (BTS_f28AverageFactor × 4096)) × 2.5`, i.e. **volts at the ADC
> pin**, matching how `BTS_monitor_Iout_Vout()` scales it. The internal
> gain/offset pair is defined against that quantity.

> **Fixed 2026-09-19.** `tools/calibrate.py` previously declared
> `CAL_STATUS_FMT = "<BBH" + "f"*9 + "BBH"` (44 B) with the ticks at the
> **end** and `result` as a `uint8` at offset 1, which does not match the
> 48-byte struct above. Because its length check was `len(raw) < 44`, a
> 48-byte record passed and it misdecoded silently rather than failing loudly.
> It now uses the layout in this table. The lesson generalises: verify a
> client's `struct` format against `ble_proto.h` field by field — a `--dry-run`
> never serialises a byte, so it cannot catch this class of drift.

---

## 4. The slot-select idiom

Four characteristics share a single cursor rather than each carrying a slot
number, which keeps the per-slot records small enough to fit comfortably in a
notification and keeps the characteristic count down.

**The sequence is: write `0004`, then read.**

| Characteristic | Op | Slot comes from |
|---|---|---|
| `0004` slot select | READ / WRITE | itself |
| `0005` slot config | **READ** | slot-select |
| `0005` slot config | **WRITE** | the payload's own `slot` field |
| `0006` slot result | READ | slot-select |
| `0007` slot serial | WRITE | slot-select |
| `000a` slot status | **READ** | slot-select |
| `000a` slot status | **NOTIFY** | the record's own `slot` field |

Everything else — `0002`, `0003`, `0008`, `0009`, `000b`, `000c` — ignores
slot-select entirely.

Three consequences worth knowing:

1. **The cursor is global, not per-connection.** `s_selected_slot` is a
   single static (`ble_svc.c:53`). The server tracks one connection handle
   (`s_conn_handle`), so this is only a hazard if a client opens overlapping
   operations against itself.
2. **It survives disconnects** and defaults to 0 at boot.
3. **Notifications are not filtered by it.** A subscriber to `000a` receives
   records for every non-idle slot, so decode `slot` from each one.

To walk all eight slots, write the index and read in the same round trip:

```python
for slot in range(8):
    await client.write_gatt_char(SLOT_SELECT, bytes([slot]), response=True)
    cfg = await client.read_gatt_char(SLOT_CONFIG)
```

Use `response=True`. A write-without-response is not offered by this
characteristic, and even if the stack downgraded it the read could overtake
the write.

---

## 5. Calibration over BLE

The BLE calibration surface is a thin shim: `handle_cal_cmd()`
(`ble_svc.c:289-339`) switches on the opcode and calls the matching
`bts_link_cal_*()` wrapper, each of which writes `eCalArgument` then
`eCalCommand` then reads `eCalResult` back — all three under one take of the
I2C bus mutex, because the opcode is consumed on write and self-clears, so an
argument that arrived afterwards would apply to nothing.

**The opcode numbering is identical on every layer**: the BLE `opcode` byte,
`bts_cal_cmd_t` in `bts_regs.h`, `BTS_calCommand` in `registers.h`, and the
design document's §5.1 table all use the same 0–8.

### 5.1 Opcodes

| Code | Name | `slot` used? | `arg` | Action |
|---|---|---|---|---|
| 0 | `NONE` | no | — | Idle. Not dispatched by the BLE handler |
| 1 | `ENTER` | **yes** | — | Put the slot into calibration. Force-exits every other slot. Refused if any slot is running a test |
| 2 | `EXIT` | no | — | Zero the reference, leave calibration. Captures discarded unless already saved |
| 3 | `CAPTURE_VOLTAGE` | no | measured volts | Sample both paths. ADS pu `< 0.2` → low point, `> 0.8` → high point, between → `PU_RANGE` |
| 4 | `ZERO_CURRENT` | no | — | Capture the zero-current pu of both current paths as the low point at 0.0 A |
| 5 | `SET_FIXED_CURRENT` | no | pu setpoint | Drive fixed-current **discharge**. 1.0 pu ≈ 10 A. Clamped to 0.0–0.8 |
| 6 | `CAPTURE_CURRENT` | no | measured amps, **magnitude** | Store as the high current point |
| 7 | `COMPUTE_SAVE` | no | — | Two-point fit, validate, F-RAM write, IPC reload into CPU1 |
| 8 | `CLEAR` | no | — | Discard in-session captures; stay in calibration |

Only `ENTER` reads the `slot` byte, and it is the only opcode whose slot is
range-checked in the BLE layer (`slot >= 8` → 0x0D). For every other opcode
the slot is whatever the unit already has in `eCalSlot`.

`CAPTURE_CURRENT` takes a **magnitude**. `bts_link_cal_capture_current()`
applies `fabsf()` before it reaches the wire (`bts_link.c:330`), so a signed
value sent over BLE is corrected for you. The one path that does **not** get
this protection is a raw write to `eCalArgument` through
`POST /api/registers`.

`SET_FIXED_CURRENT` is range-checked twice: `bts_link_cal_set_fixed_current()`
rejects `< 0.0` or `> 0.8` before it goes on the wire (`bts_link.c:320-322`),
and the unit clamps again. A rejected value returns
`ESP_ERR_INVALID_ARG`, which the BLE layer surfaces as 0x0E.

### 5.2 `status_bits` (`eCalStatus`)

| Bit | Mask | Meaning |
|---|---|---|
| 0 | `0x001` | Calibration active |
| 1 | `0x002` | Voltage low point captured |
| 2 | `0x004` | Voltage high point captured |
| 3 | `0x008` | Current zero point captured |
| 4 | `0x010` | Current loaded point captured |
| 5 | `0x020` | Voltage calibration computed and valid |
| 6 | `0x040` | Current calibration computed and valid |
| 7 | `0x080` | Written to F-RAM |
| 8 | `0x100` | Fixed-current mode currently driving |
| 9 | `0x200` | Last command failed — read `result` |

Bit 7 is owned by CPU2 (it performs the F-RAM write from its idle loop, never
from an ISR) and is OR-ed back over whatever CPU1 published
(`com_cpu2.c:2046-2048`). Writing a new command clears it
(`com_cpu2.c:2180-2183`), so bit 7 always refers to the most recent
`COMPUTE_SAVE`.

### 5.3 `result` (`eCalResult`)

| Code | Name | Meaning |
|---|---|---|
| 0 | `OK` | Command accepted |
| 1 | `BUSY` | Another slot is already in calibration |
| 2 | `TESTING` | A slot is running a charge/discharge test — stop it first |
| 3 | `SLOT_UNAVAILABLE` | Slot is strap-disabled, or is a group follower with no control loop of its own |
| 4 | `PU_RANGE` | The per-unit reading is between 0.2 and 0.8 — the firmware cannot tell which point you meant |
| 5 | `INSUFFICIENT` | Not enough captures for the requested computation |
| 6 | `VALIDATE` | A computed gain fell outside its expected window |
| 7 | `FRAM` | The F-RAM write did not complete |
| 8 | `ARG` | Argument out of range |
| 9 | `NOT_ACTIVE` | The slot is not in the calibration state |

### 5.4 How failure is reported

**A refusal is not visible in the ATT response.** `handle_cal_cmd()` returns
`BLE_ATT_ERR_UNLIKELY` (0x0E) for *any* non-zero result and for any transport
error (`ble_svc.c:332-337`). The specific code is only in characteristic
`000c`.

A client must therefore **read `000c` after every command** and look at
`result` and bit 9, rather than treating a successful GATT write as success.
The `bts_link` layer already refreshes the calibration register window on the
next poll after any command (`s_cal_poll_due`, `bts_link.c:268-270`), but the
poll interval is 250 ms — allow at least that before reading back.
`calibrate.py` uses a 200 ms `CMD_LATENCY_S` plus the read's own round trip.

---

## 6. Notifications

Three characteristics notify: `0002` (unit status), `000a` (slot status) and
`000c` (calibration status). Nothing indicates.

A client must write the CCCD for each characteristic it wants
(`start_notify()` in bleak, `startNotifications()` in Web Bluetooth).
Subscriptions are logged but not otherwise tracked, and nothing is queued
while a client is unsubscribed.

### 6.1 Rates

`notify_task()` (`ble_svc.c:606-659`) ticks every **500 ms** and alternates:

| Characteristic | Rate | Condition |
|---|---|---|
| `000c` calibration status | **2 Hz** (every tick) | only while `active` is 1 |
| `000a` slot status | 1 Hz (every second tick) | per slot, only for slots **not** in `IDLE`, `COMPLETE`, `FAULT` or `ABORTED` |
| `000a` slot status | event-driven, extra | on **every** slot state change, from the engine task |
| `0002` unit status | 1 Hz (every second tick) | unconditional once connected |

The calibration rate is deliberately double the rest: an operator adjusting a
bench supply to land inside a pu window is watching the number move, and 1 Hz
feels unresponsive (`ble_svc.c:597-605`). It costs nothing when idle, because
the calibration notify is skipped entirely unless a slot is actually
calibrating.

An idle unit therefore emits exactly one notification per second (unit
status). Eight running slots emit nine.

### 6.2 Delivery is best-effort

If the NimBLE mbuf pool is exhausted the notification is **silently dropped**
(`ble_svc.c:578-581`) — there is no retry and no sequence number. A client
that needs a guaranteed-current value must read the characteristic. Treat
notifications as a live feed, not as a log.

### 6.3 Notifications are not segmented

A notification is capped at `MTU - 3` bytes and is never split across
packets. With the default 23-byte ATT MTU a 40-byte slot-status notification
would be **truncated to 20 bytes**. Negotiate the MTU before subscribing
(§8).

---

## 7. `BLE_PROTO_VERSION`

The version byte is at offset 0 of the unit-status record, so a client can
read it in one operation before it commits to decoding anything else.

| Version | Characteristics | What changed |
|---|---|---|
| 1 | 9 (`0002`–`000a`) | Original interface: unit status, command, slot select/config/result/serial, catalogue index/entry, slot status |
| **2** | **11** (`0002`–`000c`) | Added `000b` calibration control and `000c` calibration status. **No existing struct changed and no discriminator moved.** Status-word bits 12–14 defined. Notify tick halved to 500 ms so calibration can notify at 2 Hz; the slot and unit cadence stayed at 1 Hz |

### 7.1 Handling a mismatch

Version 2 is **purely additive**, which is the property a client should rely
on rather than the number itself:

- **Client knows 2, device reports 1.** The nine original characteristics
  decode normally. `000b` and `000c` are absent from the GATT table — the
  device has no calibration interface at all. Do not attempt to drive
  calibration; the registers do not exist on that firmware either.
- **Client knows 1, device reports 2.** Everything the client understands
  still decodes at the same offsets. It will simply not see the two extra
  characteristics.
- **Device reports something higher.** Assume append-only until proven
  otherwise: decode what you know, and refuse to *write* any record whose
  layout you cannot verify. A write is length-checked for an exact match, so
  a stale client's write of a grown struct is rejected rather than
  misapplied — which is the safe failure.

**Prefer feature detection to version comparison.** `calibrate.py` does the
right thing (`calibrate.py:370-380`): it enumerates the service's
characteristics and checks that `000b` and `000c` are present, reporting
"this firmware predates `BLE_PROTO_VERSION` 2 and has no calibration
interface" if not. That survives a firmware that backports a feature without
bumping the number.

Note there is **no length field** in any record. A client that wants to be
robust against a future append should check the received length against the
size it expects and decode only the prefix it knows — not reject on
inequality, which is what the `calibrate.py` bug in §3.11 ended up doing
wrong in the other direction.

---

## 8. GAP, advertising and connection

### 8.1 Device name

`"BTS-Tester"`, from `BLE_DEVICE_NAME` in `main.c:70`, passed to
`ble_svc_init()`. It is set in two places: the advertising payload's complete
local name, and the GAP device-name characteristic
(`ble_svc_gap_device_name_set()`). The internal buffer is 32 bytes, so a
custom name is truncated at 31 characters.

Both `ble_verify.py` and `calibrate.py` find the device with
`BleakScanner.find_device_by_name("BTS-Tester")`.

### 8.2 Advertising payload

| Field | Value |
|---|---|
| Flags | `BLE_HS_ADV_F_DISC_GEN` \| `BLE_HS_ADV_F_BREDR_UNSUP` — general discoverable, BR/EDR not supported |
| TX power level | Present, `BLE_HS_ADV_TX_PWR_LVL_AUTO` |
| Complete local name | `BTS-Tester` |

### 8.3 Scan response payload

| Field | Value |
|---|---|
| Complete list of 128-bit service UUIDs | `e5f10001-9a4c-4b7d-8f2e-1c3a5b7d9f01` |

> **The service UUID is in the scan response, not the advertisement.** A
> 128-bit UUID is 16 bytes plus 2 of header; with the name it does not fit in
> the 31-byte advertising payload. Web Bluetooth needs the UUID present to
> offer the device in a filtered chooser, so it goes in the scan response
> instead (`ble_svc.c:732-736`). A client scanning **passively** will see the
> name but not the UUID — scan actively, or filter on the name.

### 8.4 Connection parameters

| | |
|---|---|
| Mode | Undirected connectable (`BLE_GAP_CONN_MODE_UND`), general discoverable |
| Duration | `BLE_HS_FOREVER` — advertising never times out |
| Concurrent clients | **One.** A single `s_conn_handle` is tracked |
| Security | None. No pairing, bonding, or encryption is required or offered |

Advertising restarts automatically on disconnect, on advertising complete,
and after a failed connection.

### 8.5 MTU

| | |
|---|---|
| Preferred ATT MTU | **247** (`CONFIG_BT_NIMBLE_ATT_PREFERRED_MTU`) |
| Usable payload | 244 (`BLE_PROTO_MAX_PAYLOAD` = 247 − 3) |
| Largest record | 116 B (`ble_slot_result_t`) |

Every record fits in a single 247-byte ATT operation, so no read needs a Read
Blob sequence once the MTU is negotiated. At the default 23-byte MTU,
however, only the 20-byte unit-status and the 1-byte cursors fit — everything
larger needs Read Blob on a read and would be **truncated** on a notification
(§6.3).

Negotiate the MTU immediately after connecting. Most stacks do this on their
own; bleak exposes the result as `client.mtu_size`, and both bench scripts
print it.

### 8.6 Disconnect behaviour

**A disconnect does not abort running tests.** This is deliberate
(`ble_svc.c:685-689`): a multi-hour discharge must survive an operator
walking away with the tablet. The test engine supervises itself and results
are persisted to NVS.

Calibration is different: the design requires a host-loss timeout to zero the
reference, and a slot in fixed-current mode auto-exits after 120 s with no
calibration command (the dead-man timer, design doc §7 rule 6).

---

## 9. ATT error codes

Every error a handler can return, and what it actually means here.

| Code | Name | Raised when |
|---|---|---|
| 0x06 | `REQ_NOT_SUPPORTED` | Unknown command or calibration opcode |
| 0x0D | `INVALID_ATTR_VALUE_LEN` | Write length is not an exact match; slot ≥ 8; chemistry ≥ 5; serial empty or ≥ 32 bytes |
| 0x0E | `UNLIKELY` | The test engine or the BTS **refused** the operation; an mbuf copy failed; a read or write reached an unrecognised UUID |
| 0x11 | `INSUFFICIENT_RES` | The response mbuf could not be appended to |

> **0x0E carries no diagnosis.** It is returned both for "the unit said no"
> and for "something went wrong in the stack". Read the slot's `state` and
> `fault` (for commands) or characteristic `000c`'s `result` (for
> calibration) to find out which. Do not retry on 0x0E — a refusal will be
> refused again.

---

## 10. Worked example: one calibration capture

Connect, select a slot, enter calibration, and take the voltage low point.
Uses `bleak`; the full guided flow is `tools/calibrate.py`.

```python
import asyncio, struct
from bleak import BleakClient, BleakScanner

def uuid(disc):
    return f"e5f1{disc:04x}-9a4c-4b7d-8f2e-1c3a5b7d9f01"

SERVICE     = uuid(0x0001)
UNIT_STATUS = uuid(0x0002)
SLOT_SELECT = uuid(0x0004)
SLOT_STATUS = uuid(0x000A)
CAL_CONTROL = uuid(0x000B)
CAL_STATUS  = uuid(0x000C)

CAL_CMD_FMT    = "<BBHf"                       # ble_cal_cmd_t,    8 B
CAL_STATUS_FMT = "<BBBBII" + "f" * 9           # ble_cal_status_t, 48 B
SLOT_FMT       = "<BBBBffffffIII"              # ble_slot_status_t, 40 B

CAL_CMD_ENTER, CAL_CMD_CAPTURE_VOLTAGE, CAL_CMD_EXIT = 1, 3, 2
SLOT = 2                                       # 0-based: front-panel slot 3


async def main():
    dev = await BleakScanner.find_device_by_name("BTS-Tester", timeout=15.0)
    async with BleakClient(dev, timeout=25.0) as client:
        print("mtu", client.mtu_size)          # expect 247, not 23

        # --- 1. Check the protocol version and that calibration exists -----
        ver = (await client.read_gatt_char(UNIT_STATUS))[0]
        chars = {c.uuid.lower()
                 for s in client.services if s.uuid.lower() == SERVICE.lower()
                 for c in s.characteristics}
        if CAL_STATUS.lower() not in chars:
            raise SystemExit(f"proto v{ver}: no calibration interface")

        # --- 2. Select the slot, then read its per-slot records ------------
        await client.write_gatt_char(SLOT_SELECT, bytes([SLOT]), response=True)
        bits = struct.unpack(SLOT_FMT,
                             (await client.read_gatt_char(SLOT_STATUS))[:40])[12]
        print(f"slot {SLOT} status 0x{bits:06X} "
              f"v_tick={bool(bits & 1 << 13)} i_tick={bool(bits & 1 << 14)}")

        async def cal_cmd(opcode, slot=0, arg=0.0):
            """Write the command, then READ the status back - the ATT
            response cannot tell you why the unit refused."""
            await client.write_gatt_char(
                CAL_CONTROL, struct.pack(CAL_CMD_FMT, opcode, slot, 0, arg),
                response=True)
            await asyncio.sleep(0.3)           # > the 250 ms I2C poll cycle
            raw = await client.read_gatt_char(CAL_STATUS)
            f = struct.unpack(CAL_STATUS_FMT, raw[:48])
            return {"slot": f[0], "active": f[1], "status": f[4],
                    "result": f[5], "ads_v_pu": f[6], "f28_v_pu": f[10]}

        # --- 3. Enter calibration. ENTER is the only opcode that uses slot -
        st = await cal_cmd(CAL_CMD_ENTER, slot=SLOT)
        if st["result"] != 0:
            raise SystemExit(f"enter refused, eCalResult={st['result']}")
        assert st["status"] & 0x001            # bit 0, calibration active

        # --- 4. Set the supply to about 0.85 V, wait for pu < 0.2 ---------
        while True:
            st = await cal_cmd(0)              # NONE is rejected by the BLE
            ...                                # handler; poll with a plain
                                               # read instead, as below
            raw = await client.read_gatt_char(CAL_STATUS)
            pu = struct.unpack(CAL_STATUS_FMT, raw[:48])[6]
            print(f"  ads_v_pu = {pu:.4f}")
            if pu < 0.2:
                break
            await asyncio.sleep(0.5)           # 000c notifies at 2 Hz too

        # --- 5. Read the DMM, capture against it --------------------------
        measured_v = 0.84968                   # from CONF:VOLT:DC / READ?
        st = await cal_cmd(CAL_CMD_CAPTURE_VOLTAGE, arg=measured_v)
        if st["result"] != 0:
            raise SystemExit(f"capture refused, eCalResult={st['result']}")
        assert st["status"] & 0x002            # bit 1, V low point held

        print("low point captured")

        # --- 6. Always exit, even on the error paths ----------------------
        await cal_cmd(CAL_CMD_EXIT)

asyncio.run(main())
```

Four things this example is written to make obvious:

1. **Feature-detect, don't version-compare.** The characteristic either
   exists or it does not.
2. **Slot-select and the calibration slot are independent.** `SLOT_SELECT`
   steers `000a`/`0005`/`0006`/`0007`; the calibration slot is set by
   `ENTER`'s payload byte and read back in `000c`'s `slot` field.
3. **Read `000c` after every command.** The GATT write succeeding says
   nothing about whether the unit accepted it.
4. **Opcode 0 (`NONE`) is rejected**, not a no-op — `handle_cal_cmd()` has no
   case for it and returns `REQ_NOT_SUPPORTED`. To poll the live telemetry,
   plainly read `000c` or subscribe to its notifications.

---

## 11. Client-side discrepancies found and fixed

All three were found on 2026-09-19 by diffing the scripts' wire formats against
`ble_proto.h`, and all three are now corrected. Recorded because the class of
bug recurs and none of it is caught by testing: a `--dry-run` constructs objects
directly and never serialises a byte.

| File | Issue | Status |
|---|---|---|
| `tools/calibrate.py:66-68` | `CAL_STATUS_FMT` was 44 B with the ticks last and `result` as a `uint8`; the struct is 48 B with the ticks at offsets 2–3 and `result` a `uint32` at offset 8. The length check (`< 44`) passed a 48-byte record, so it misdecoded rather than failing. See §3.11 | fixed |
| `tools/ble_verify.py:46-50` | `STATUS_BITS` listed 12 names, stopping at `slotDisabled` (bit 11). Bits 12–14 (`calibrating`, `calVoltageValid`, `calCurrentValid`) were missing, so `decode_status_bits()` silently dropped them | fixed |
| `tools/ble_verify.py:144` | Sliced the model name out of `ble_slot_config_t` at `cfg[28:52]`. `model_name` is at offset **24**, length 24 — the correct slice is `cfg[24:48]` | fixed |

The root cause in each case was writing the format from a design document
rather than from the header. Where the two disagree, the header wins.

None of these ever affected the firmware; the offsets in §3 are what the device
actually emits.
