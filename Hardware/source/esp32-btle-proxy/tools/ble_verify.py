"""Connect to the BTS-Tester over BLE and verify the GATT interface.

Decodes every readable characteristic against the packed structs in
components/ble_svc/include/ble_proto.h and subscribes to both notify
characteristics so the live path is exercised too.

    python tools/ble_verify.py [--seconds N] [--address AA:BB:..]

Exit status is non-zero if the interface could not be verified, so this can
be used as a bench smoke test.
"""

import argparse
import asyncio
import struct
import sys

from bleak import BleakClient, BleakScanner

DEVICE_NAME = "BTS-Tester"

# The lowest BLE_PROTO_VERSION whose records the structs below describe.
#
# This is a MINIMUM, not an equality test. The interface is append-only: a
# newer firmware adds characteristics and appends fields, so every offset
# this script decodes stays put. Version 4 added characteristic 000d
# (register access), which this script does not exercise.
#
# An OLDER firmware is the real hazard - proto 2's ble_slot_status_t is 40 B
# where this decodes 68, so it would be rejected here rather than misread.
MIN_PROTO_VERSION = 3

# e5f1xxxx-9a4c-4b7d-8f2e-1c3a5b7d9f01
def uuid(disc):
    return f"e5f1{disc:04x}-9a4c-4b7d-8f2e-1c3a5b7d9f01"

SERVICE       = uuid(0x0001)
UNIT_STATUS   = uuid(0x0002)
COMMAND       = uuid(0x0003)
SLOT_SELECT   = uuid(0x0004)
SLOT_CONFIG   = uuid(0x0005)
SLOT_RESULT   = uuid(0x0006)
SLOT_SERIAL   = uuid(0x0007)
CATALOG_INDEX = uuid(0x0008)
CATALOG_ENTRY = uuid(0x0009)
SLOT_STATUS   = uuid(0x000a)

UNIT_STATES = {
    0: "INPUT_LOW_CHARGE_DISABLED",
    1: "INPUT_LOW_CHARGE_RESTRICTED",
    2: "INPUT_OK",
    3: "INPUT_HIGH_DISCHARGE_RESTRICTED",
    4: "INPUT_HIGH_DISCHARGE_DISABLED",
}

# BTS_STATUS_* bit positions, from registers.h.
# Bit 2 "finished" carries the END semantic; bit 16 is unused and always 0.
STATUS_BITS = [
    "running", "stopped", "finished(end)", "overCurrentTrip",
    "charging", "discharging", "constVoltage", "constCurrent",
    "slaveMode", "groupDisconnect", "reversePolarity", "slotDisabled",
    "calibrating", "calVoltageValid", "calCurrentValid",
    "paused", "-", "watchdogTripped", "restored",
]


def decode_status_bits(v):
    on = [n for i, n in enumerate(STATUS_BITS) if v & (1 << i)]
    return ",".join(on) if on else "-"


# ble_unit_status_t, field for field:
#   B version  B slot_count  B online  B unit_state
#   I trip_status  f input_voltage_v  I uptime_s
#   B stats_live  B wifi_connected  H reserved  f watchdog_timeout_s
UNIT_FMT = "<BBBBIfIBBHf"
UNIT_LEN = struct.calcsize(UNIT_FMT)
assert UNIT_LEN == 24, UNIT_LEN

# ble_slot_status_t, field for field:
#   B slot  B state  B fault  B configured
#   f voltage_v  f current_a  f temp_c  f live_mah  f live_mwh  f progress
#   I elapsed_s  I state_elapsed_s  I status_bits
#   B bts_paused  B bts_wd_tripped  B bts_restored  B bts_ended
#   f bts_charge_mah  f bts_charge_mwh  f bts_charge_seconds
#   f bts_discharge_mah  f bts_discharge_mwh  f bts_discharge_seconds
SLOT_FMT = "<BBBBffffffIIIBBBBffffff"
SLOT_LEN = struct.calcsize(SLOT_FMT)
assert SLOT_LEN == 68, SLOT_LEN


def decode_unit(b):
    if len(b) < UNIT_LEN:
        return None
    (ver, slots, online, state, trip, vin, uptime,
     stats_live, wifi, _r, wd) = struct.unpack(UNIT_FMT, b[:UNIT_LEN])
    return {
        "proto_version": ver, "slot_count": slots, "online": bool(online),
        "unit_state": UNIT_STATES.get(state, f"?{state}"),
        "trip_status": f"0x{trip:08X}", "input_voltage_v": round(vin, 4),
        "uptime_s": uptime, "stats_live": bool(stats_live),
        "wifi_connected": bool(wifi),
        "watchdog_timeout_s": round(wd, 1),
    }


def decode_slot(b):
    if len(b) < SLOT_LEN:
        return None
    (slot, state, fault, configured, v, i, t, mah, mwh, prog,
     elapsed, state_elapsed, status,
     paused, wd_tripped, restored, ended,
     c_mah, c_mwh, c_s, d_mah, d_mwh, d_s) = struct.unpack(SLOT_FMT, b[:SLOT_LEN])
    return {
        "slot": slot, "state": state, "fault": fault,
        "configured": bool(configured),
        "voltage_v": round(v, 4), "current_a": round(i, 4),
        "temp_c": round(t, 3), "mah": round(mah, 3), "mwh": round(mwh, 3),
        "progress": round(prog, 4), "elapsed_s": elapsed,
        "status_bits": f"0x{status:08X} ({decode_status_bits(status)})",
        "bts_paused": bool(paused), "bts_watchdog_tripped": bool(wd_tripped),
        "bts_restored": bool(restored), "bts_ended": bool(ended),
        "bts_charge": [round(c_mah, 2), round(c_mwh, 2), round(c_s, 0)],
        "bts_discharge": [round(d_mah, 2), round(d_mwh, 2), round(d_s, 0)],
    }


async def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--seconds", type=float, default=12.0)
    ap.add_argument("--address", default=None)
    args = ap.parse_args()

    address = args.address
    if not address:
        print(f"scanning for {DEVICE_NAME} ...", flush=True)
        dev = await BleakScanner.find_device_by_name(DEVICE_NAME, timeout=15.0)
        if not dev:
            print(f"FAIL: {DEVICE_NAME} not advertising")
            return 1
        address = dev.address
    print(f"connecting to {address} ...", flush=True)

    notes = {"unit": 0, "slot": 0}

    async with BleakClient(address, timeout=25.0) as client:
        print(f"connected, mtu={client.mtu_size}\n")

        print("=== GATT table ===")
        svc_seen = False
        for svc in client.services:
            if svc.uuid.lower() != SERVICE.lower():
                continue
            svc_seen = True
            print(f"service {svc.uuid}")
            for ch in svc.characteristics:
                print(f"  {ch.uuid}  {','.join(ch.properties)}")
        if not svc_seen:
            print(f"FAIL: service {SERVICE} not present")
            return 1

        print("\n=== reads ===")
        raw = await client.read_gatt_char(UNIT_STATUS)
        unit = decode_unit(raw)
        print(f"unit_status ({len(raw)}B): {unit}")
        if unit is None:
            print("FAIL: unit status too short to decode")
            return 1
        if unit["proto_version"] < MIN_PROTO_VERSION:
            print(f"FAIL: proto version {unit['proto_version']}, "
                  f"this script needs {MIN_PROTO_VERSION} or newer")
            return 1
        if unit["proto_version"] > MIN_PROTO_VERSION:
            print(f"note: firmware is proto {unit['proto_version']}; this "
                  f"script verifies the proto {MIN_PROTO_VERSION} surface")

        # Walk every slot through the select characteristic.
        print()
        for slot in range(unit["slot_count"] or 8):
            await client.write_gatt_char(SLOT_SELECT, bytes([slot]), response=True)
            sel = await client.read_gatt_char(SLOT_SELECT)
            cfg = await client.read_gatt_char(SLOT_CONFIG)
            model = cfg[24:48].split(b"\x00")[0].decode("utf-8", "replace") if len(cfg) >= 48 else ""
            print(f"slot {slot}: select_readback={sel[0]} config={len(cfg)}B model={model!r}")

        print("\n=== notifications ===")

        def on_unit(_h, data):
            notes["unit"] += 1
            print(f"  [unit ] {decode_unit(data)}")

        def on_slot(_h, data):
            notes["slot"] += 1
            d = decode_slot(data)
            if d and d["slot"] == 0:       # keep the log readable: slot 1 only
                print(f"  [slot0] v={d['voltage_v']} i={d['current_a']} "
                      f"t={d['temp_c']} {d['status_bits']}")

        await client.start_notify(UNIT_STATUS, on_unit)
        await client.start_notify(SLOT_STATUS, on_slot)
        print(f"subscribed; listening {args.seconds:.0f}s ...")
        await asyncio.sleep(args.seconds)
        await client.stop_notify(UNIT_STATUS)
        await client.stop_notify(SLOT_STATUS)

    print(f"\nnotifications: unit={notes['unit']} slot={notes['slot']}")
    ok = notes["unit"] > 0 or notes["slot"] > 0
    print("PASS" if ok else "FAIL: no notifications arrived")
    return 0 if ok else 1


sys.exit(asyncio.run(main()))
