# Lion LVRT — Home Assistant integration

Home Assistant control and monitoring for the eight-channel Lion IRVT battery
tester (TIDA-010086 + ESP32 proxy).

Written for someone installing and operating this, not for someone reading the
firmware. The wire-level contracts live in [`../Docs/`](../Docs/).

---

## What you get

Per slot (eight of them), as their own Home Assistant devices:

| Kind | Entities |
|---|---|
| **Mode** | one `select` — idle / charge / discharge / test |
| **Buttons** | start test, stop, pause, resume, clear fault |
| **Measurements** | voltage, current, cell temperature, charge moved, energy moved, progress, elapsed |
| **Status** | state, fault, running, charging, paused, needs-operator, reverse polarity, calibrating, calibration valid, group follower, slot disabled |
| **Configuration** | charge/discharge voltage and current limits, cell temperature window |
| **Unit counters** | the BTS's own per-direction mAh / mWh / seconds |

Plus, for the unit: input voltage, unit state, uptime, online, WiFi, host
watchdog armed and its timeout, charge-allowed and discharge-allowed, an
abort-all button, and the four input-bus thresholds.

Services: `configure_slot`, `set_serial`, `set_mode`, `resume_slot`,
`calibration_command`, `get_result`.

---

## Installation

Copy `custom_components/lion_lvrt/` into your Home Assistant `config/custom_components/`
directory and restart, or add this repository to HACS as a custom repository.

The tester advertises as `BTS-Tester`, so Home Assistant discovers it
automatically if a Bluetooth adapter or proxy is in range — **Settings →
Devices & Services** will show it waiting to be configured.

### Bluetooth proxies

Nothing special is required. An ESPHome or Shelly Bluetooth proxy presents the
tester like any other device and `bleak-retry-connector` picks the adapter with
the best signal. The proxy must be a **connectable** one — a passive scanner
sees the advertisement but cannot be written to.

---

## Choosing a transport

This is the one decision worth understanding before you set up, because it
decides which controls appear.

The system has **two separate control surfaces**:

* **The test engine**, on the ESP32. `start` runs a whole characterisation —
  check rest, charge, rest, discharge, rest, optional recharge — and picks the
  direction itself.
* **The mode register**, on the C2000. Writing `eChX_Mode` commands the
  converter directly: run/stop and charge/discharge, nothing more.

"Test this cell" is the first. "Charge this slot" is the second. They are
reached differently:

| Transport | Test engine | Charge / discharge | Needs |
|---|:---:|:---:|---|
| **Bluetooth** | yes | only on firmware ≥ proto 4 | an adapter or proxy in range |
| **CAN** | no | yes | SocketCAN on the HA host, wired to the unit |
| **HTTP** | yes | yes | the tester joined to your WiFi |

Bluetooth is the default and works on a bench unit with no network. If your
proxy firmware predates `BLE_PROTO_VERSION` 4 it has no register
characteristic, so charge and discharge are **not offered in the mode
dropdown** — the integration reports what it can actually do rather than
listing an action that would fail. Two ways to get them back:

1. Add a CAN interface or the HTTP address during setup (both fields are
   optional and either one is enough), or
2. Flash the firmware in this repository, which adds characteristic `000d`.

A CAN-only setup is the mirror image: full converter control and configuration,
but no characterisation tests, because the test engine lives on the ESP32 and
CAN does not reach it.

---

## Safety behaviour you should know about

**The poll is a keepalive.** The unit pauses every running slot if no host
command arrives within its watchdog timeout (default 30 s). Home Assistant's
polling feeds that watchdog. If you widen the scan interval past the timeout
you will get a warning in the log — and eventually slots that pause on their
own.

**Some pauses need you, not an automation.** A slot paused because the
watchdog fired, or because the unit reset and restored the run from F-RAM,
comes back with `needs_operator` on. The resume *button* refuses it. That is
deliberate: both mean the unit lost contact with the host mid-run, and the cell
in the holder may not be the cell the counters belong to. To override, call the
service with the flag:

```yaml
action: lion_lvrt.resume_slot
data:
  slot: 0
  force: true
```

**The unit can refuse a command without reporting anything.** If the DC input
bus is outside its window, the firmware rejects a charge or discharge outright
and leaves the slot stopped with no error set anywhere. The integration checks
the unit state first and raises a message saying which state blocked it, rather
than letting the slot silently do nothing.

**Do not disable the host watchdog** (setting its timeout to 0) on anything
unattended. It is the only mechanism that stops the converters when the host
goes away mid-run. The integration allows it, because the firmware does and a
bench operator sometimes needs it, but it logs a warning every time.

---

## Things the hardware does that look like bugs

Worth knowing before you file one:

* **The over-current trip flag is never set.** Every hardware trip source is
  masked in this firmware build, so `binary_sensor.*_over_current_trip` stays
  off even during a software over-current. Use the **fault** sensor instead.
* **Voltage and current come from the 12-bit internal ADC**, not the 16-bit
  converter, despite what the register names suggest. Where a register
  transport is configured the 16-bit sense values are available too.
* **Result timestamps are not wall-clock.** `completed_uptime_s` is seconds of
  proxy uptime — the device has no real-time clock. Stamp your own on retrieval.
* **A charge total and a discharge total coexist.** Each direction's
  accumulator is zeroed only when that direction starts, never on stop or
  trip, so a slot that charged then discharged shows both.
* **Slots can be strapped into groups.** A follower has no control loop of its
  own and mirrors its leader; commanding it is refused. `group_follower` tells
  you which ones those are.

---

## Calibration

The bench procedure is in [`../Docs/calibration-flow.md`](../Docs/calibration-flow.md).
From Home Assistant, each step is one service call that returns the live
telemetry, so you can watch a bench supply land inside the capture window:

```yaml
action: lion_lvrt.calibration_command
data:
  command: enter
  slot: 2
response_variable: cal
```

Then `capture_voltage` with the measured volts, `zero_current`,
`set_fixed_current` with a per-unit setpoint (0.0–0.8, where 1.0 pu ≈ 10 A),
`capture_current` with the measured amps, and `compute_save`.

Only `enter` takes a slot; every other command applies to whichever slot the
unit already holds. A reading between 0.2 and 0.8 pu is refused with
`pu_range` — the firmware cannot tell which capture point you meant.

A slot in calibration drops its reference after 120 s with no command, so
don't leave the procedure half-finished.

---

## Testing

```bash
python -m pip install -r requirements-test.txt
python -m pytest
```

The suite runs against a firmware-accurate simulator — no hardware needed. The
simulator deliberately reproduces the behaviours that break clients: the shared
slot-select cursor, exact write-length checks, refusals that carry no reason,
read-only register writes that are silently dropped, MTU truncation, and the
host watchdog.

Two tiers:

* **Protocol, transport and device tests** import no Home Assistant and run on
  **Python 3.10+**.
* **Entity, service and config-flow tests** need Home Assistant, which needs
  **Python 3.12+**. On an older interpreter they skip with a message saying so
  rather than silently passing.

The test worth knowing about is `test_layouts_match_firmware_header`: it parses
`ble_proto.h` and compares every struct field-by-field against the Python
decoder. Every client bug on record in this project was a silent layout drift
that behavioural tests could not catch, because a dry run never serialises a
byte.

---

## Layout

```
custom_components/lion_lvrt/
  protocol/         wire codecs — no Home Assistant imports
    ble.py            little-endian GATT records
    registers.py      big-endian register map v2
    can.py            mixed-endian CAN frames
  transport/        one class per link
    base.py           capability interface
    ble.py  can.py  http.py
  device.py         safety policy, transport selection
  coordinator.py    polling + notification fan-out
  sensor.py  binary_sensor.py  select.py  button.py  number.py
  config_flow.py  services.py  const.py
tests/
  simulator/        the fake unit
  test_protocol.py  test_registers.py  test_transport.py
  test_device.py    test_homeassistant.py
```
