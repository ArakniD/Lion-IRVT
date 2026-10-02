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
# this script decodes stays put.
#
# An OLDER firmware is the real hazard - proto 2's ble_slot_status_t is 40 B
# where this decodes 74, so it would be rejected here rather than misread.
#
# Raised to 6 with the CCCV work, which appended the two regulation flags
# (70 B), and to 7 with the pre-charge balance work, which appended four more
# (74 B). A proto-6 unit returns 70 and is short by exactly those four, so it
# must be rejected rather than silently reported as not balancing.
MIN_PROTO_VERSION = 7

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
CAL_CONTROL   = uuid(0x000b)
CAL_STATUS    = uuid(0x000c)
REGISTER      = uuid(0x000d)

UNIT_STATES = {
    0: "INPUT_LOW_CHARGE_DISABLED",
    1: "INPUT_LOW_CHARGE_RESTRICTED",
    2: "INPUT_OK",
    3: "INPUT_HIGH_DISCHARGE_RESTRICTED",
    4: "INPUT_HIGH_DISCHARGE_DISABLED",
}

# BTS_STATUS_* bit positions, from registers.h. Note that registers.h gives
# these as POSITIONS (0U, 1U, ...) while the ESP32's bts_regs.h gives the same
# names as MASKS (1u << 0, ...) - this list is indexed, so it follows the
# C2000.
#
# Bit 2 "finished" carries the END semantic. Bits 16 and 19-21 are the
# pre-charge balance sequence, added with BLE_PROTO_VERSION 7: bit 16 was
# unused in earlier builds and this list used to stop at bit 18.
STATUS_BITS = [
    "running", "stopped", "finished(end)", "overCurrentTrip",
    "charging", "discharging", "constVoltage", "constCurrent",
    "slaveMode", "groupDisconnect", "reversePolarity", "slotDisabled",
    "calibrating", "calVoltageValid", "calCurrentValid",
    "paused", "waiting", "watchdogTripped", "restored",
    "balancing", "ready", "softStart",
]

# ble_cal_status_t, characteristic 000c:
#   B slot  B active  B v_tick  B i_tick  I status_bits  I result
#   f ads_v_pu  f ads_i_pu  f ads_v_v  f ads_i_a
#   f f28_v_pu  f f28_i_pu  f f28_v_v  f f28_i_a  f temp_c
#
# The nine telemetry floats are the unit's registers 1032-1064 - the top of
# the 15-register calibration window that starts at eCalSlot (1008).
CAL_STATUS_FMT = "<BBBBII" + "f" * 9
CAL_STATUS_LEN = struct.calcsize(CAL_STATUS_FMT)
assert CAL_STATUS_LEN == 48, CAL_STATUS_LEN

# ble_register_cmd_t, characteristic 000d:
#   H addr (BYTE address, index = addr / 4)  B write  B count (must be 1)
#   f value (native little-endian, NOT the C2000's big-endian I2C order)
REG_CMD_FMT = "<HBBf"
REG_CMD_LEN = struct.calcsize(REG_CMD_FMT)
assert REG_CMD_LEN == 8, REG_CMD_LEN

# BTS_TOTAL_REGISTERS and the top byte address it implies, from bts_regs.h.
TOTAL_REGISTERS = 280
TOP_REGISTER_ADDR = (TOTAL_REGISTERS - 1) * 4   # 1116

# A harmless read target: eUnitState, the first register of the unit block.
REG_UNIT_STATE = 960


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
#   B bts_const_voltage  B bts_const_current            (proto 6)
#   B bts_waiting  B bts_balancing  B bts_ready  B bts_soft_start  (proto 7)
SLOT_FMT = "<BBBBffffffIIIBBBBffffffBBBBBB"
SLOT_LEN = struct.calcsize(SLOT_FMT)
assert SLOT_LEN == 74, SLOT_LEN


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
     c_mah, c_mwh, c_s, d_mah, d_mwh, d_s,
     const_v, const_i,
     waiting, balancing, ready, soft_start) = struct.unpack(SLOT_FMT, b[:SLOT_LEN])
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
        "bts_regulation": "CV" if const_v else ("CC" if const_i else "-"),
        "bts_precharge": ("SOFT_START" if soft_start else
                          "READY" if ready else
                          "BALANCING" if balancing else
                          "WAITING" if waiting else "-"),
    }


def decode_cal_status(b):
    if len(b) < CAL_STATUS_LEN:
        return None
    (slot, active, v_tick, i_tick, status, result,
     ads_v_pu, ads_i_pu, ads_v_v, ads_i_a,
     f28_v_pu, f28_i_pu, f28_v_v, f28_i_a, temp_c) = struct.unpack(
        CAL_STATUS_FMT, b[:CAL_STATUS_LEN])
    return {
        "slot": "none" if slot == 255 else slot,
        "active": bool(active),
        "v_tick": bool(v_tick), "i_tick": bool(i_tick),
        "status_bits": f"0x{status:08X}", "result": result,
        "ads": [round(ads_v_pu, 5), round(ads_i_pu, 5),
                round(ads_v_v, 4), round(ads_i_a, 4)],
        "f28": [round(f28_v_pu, 5), round(f28_i_pu, 5),
                round(f28_v_v, 4), round(f28_i_a, 4)],
        "temp_c": round(temp_c, 2),
    }


async def read_register(client, addr):
    """Read one register over characteristic 000d, by BYTE address.

    A read writes the command with `write` = 0, then reads the reply back from
    the SAME characteristic. Returns None if the reply is short or addresses a
    different register.
    """
    await client.write_gatt_char(
        REGISTER, struct.pack(REG_CMD_FMT, addr, 0, 1, 0.0), response=True)
    raw = await client.read_gatt_char(REGISTER)
    if len(raw) < REG_CMD_LEN:
        return None
    got, _write, _count, value = struct.unpack(REG_CMD_FMT, raw[:REG_CMD_LEN])
    return value if got == addr else None


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
        present = set()          # lowercased UUIDs this firmware actually has
        for svc in client.services:
            if svc.uuid.lower() != SERVICE.lower():
                continue
            svc_seen = True
            print(f"service {svc.uuid}")
            for ch in svc.characteristics:
                present.add(ch.uuid.lower())
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

        # Calibration status, characteristic 000c. Readable at any time; the
        # unit reports slot 255 / inactive when no calibration is running, and
        # the telemetry floats are stale rather than absent - the firmware
        # polls registers 1008-1064 only while a calibration is active.
        print("\n=== calibration ===")
        if CAL_STATUS.lower() in present:
            raw = await client.read_gatt_char(CAL_STATUS)
            cal = decode_cal_status(raw)
            print(f"cal_status ({len(raw)}B): {cal}")
            if cal is None:
                print(f"FAIL: cal status is {len(raw)}B, "
                      f"need {CAL_STATUS_LEN}")
                return 1
        else:
            print(f"FAIL: characteristic {CAL_STATUS} missing")
            return 1
        if CAL_CONTROL.lower() not in present:
            print(f"FAIL: characteristic {CAL_CONTROL} missing")
            return 1
        print(f"cal_control {CAL_CONTROL} present (not exercised - writing "
              f"an opcode would enter calibration)")

        # Register access, characteristic 000d. Read-only here: a write
        # would change the unit's configuration. eUnitState is a safe
        # target, and the top of the map proves the register count.
        print("\n=== register access ===")
        if REGISTER.lower() in present:
            value = await read_register(client, REG_UNIT_STATE)
            if value is None:
                print(f"FAIL: register {REG_UNIT_STATE} read did not "
                      f"come back")
                return 1
            print(f"register {REG_UNIT_STATE} (eUnitState) = {value}")
            top = await read_register(client, TOP_REGISTER_ADDR)
            if top is None:
                print(f"FAIL: top register {TOP_REGISTER_ADDR} "
                      f"unreachable - this firmware's map is smaller "
                      f"than {TOTAL_REGISTERS} registers")
                return 1
            print(f"register {TOP_REGISTER_ADDR} (top of map, "
                  f"{TOTAL_REGISTERS} registers) = {top}")
        else:
            print(f"FAIL: characteristic {REGISTER} missing")
            return 1

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
