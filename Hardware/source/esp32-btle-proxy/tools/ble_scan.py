"""Scan for BLE advertisers and dump anything that looks like the BTS tester.

Bench utility: run from the laptop to confirm the ESP32 proxy is advertising before
trying to connect to it.

    python tools/ble_scan.py [seconds]
"""

import asyncio
import sys

from bleak import BleakScanner

DURATION = float(sys.argv[1]) if len(sys.argv) > 1 else 10.0


async def main():
    print(f"scanning {DURATION:.0f}s ...", flush=True)
    found = await BleakScanner.discover(timeout=DURATION, return_adv=True)

    if not found:
        print("no BLE devices seen at all - is the adapter on?")
        return

    rows = []
    for address, (device, adv) in found.items():
        name = adv.local_name or device.name or ""
        rows.append((adv.rssi if adv.rssi is not None else -999, address, name, adv))

    rows.sort(reverse=True)

    print(f"\n{len(rows)} device(s):\n")
    for rssi, address, name, adv in rows:
        flag = "  <== BTS" if "BTS" in (name or "").upper() else ""
        print(f"  {rssi:>4} dBm  {address}  {name!r}{flag}")
        if flag:
            for uuid in adv.service_uuids or []:
                print(f"                 service: {uuid}")
            for uuid, blob in (adv.service_data or {}).items():
                print(f"                 svc data {uuid}: {blob.hex()}")
            for cid, blob in (adv.manufacturer_data or {}).items():
                print(f"                 mfr 0x{cid:04X}: {blob.hex()}")


asyncio.run(main())
