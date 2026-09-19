"""Guided two-point slot calibration for the TIDA-010086 battery test system.

Drives the calibration sequence in Docs/calibration-design.md section 12 over
BLE, using an Agilent/Keysight LAN DMM as the external reference:

    python tools/calibrate.py                  # full bench run, slots 1-8
    python tools/calibrate.py --slots 3,4      # just those slots
    python tools/calibrate.py --dry-run        # simulated bench, no hardware

Configuration (DMM address, SCPI port, BLE address) is prompted for on the
first run and persisted to calibrate.ini next to this file.

SAFETY
------
The BTS hardware over-current trips are disabled in this firmware build
(bts_user_settings.h:113-120), so the bench supply's own current limit is the
backstop. Do not leave a run unattended. Every exit path from this script -
normal, Ctrl-C, or an unhandled exception - issues CAL_CMD_EXIT so a slot is
never left driving current.

The DMM current reading is entered as a MAGNITUDE. The firmware applies the
discharge sign itself; passing a signed value inverts that slot's current
calibration.
"""

from __future__ import annotations

import argparse
import asyncio
import configparser
import json
import math
import random
import socket
import struct
import sys
import time
from dataclasses import dataclass, field
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Callable, Optional, Sequence

TOOL_VERSION = "1.0"
CONFIG_PATH = Path(__file__).with_name("calibrate.ini")

DEVICE_NAME = "BTS-Tester"


# --------------------------------------------------------------------------
# BLE / register constants, mirroring Docs/calibration-design.md
# --------------------------------------------------------------------------

def uuid(disc: int) -> str:
    return f"e5f1{disc:04x}-9a4c-4b7d-8f2e-1c3a5b7d9f01"


SERVICE = uuid(0x0001)
UNIT_STATUS = uuid(0x0002)
SLOT_SELECT = uuid(0x0004)
SLOT_STATUS = uuid(0x000A)
CAL_CONTROL = uuid(0x000B)
CAL_STATUS = uuid(0x000C)

# ble_cal_cmd_t   { u8 opcode; u8 slot; u16 rsvd; f32 arg; }
CAL_CMD_FMT = "<BBHf"
# ble_cal_status_t, from ble_proto.h - field order is authoritative:
#   u8 slot; u8 active; u8 v_tick; u8 i_tick; u32 status_bits; u32 result; f32 x9
CAL_STATUS_FMT = "<BBBBII" + "f" * 9
CAL_STATUS_LEN = struct.calcsize(CAL_STATUS_FMT)

# ble_slot_status_t, from ble_proto.h
SLOT_FMT = "<BBBBffffffIII"
SLOT_LEN = struct.calcsize(SLOT_FMT)

CAL_CMD_NONE = 0
CAL_CMD_ENTER = 1
CAL_CMD_EXIT = 2
CAL_CMD_CAPTURE_VOLTAGE = 3
CAL_CMD_ZERO_CURRENT = 4
CAL_CMD_SET_FIXED_CURRENT = 5
CAL_CMD_CAPTURE_CURRENT = 6
CAL_CMD_COMPUTE_SAVE = 7
CAL_CMD_CLEAR = 8

CMD_NAMES = {
    CAL_CMD_NONE: "CAL_CMD_NONE",
    CAL_CMD_ENTER: "CAL_CMD_ENTER",
    CAL_CMD_EXIT: "CAL_CMD_EXIT",
    CAL_CMD_CAPTURE_VOLTAGE: "CAL_CMD_CAPTURE_VOLTAGE",
    CAL_CMD_ZERO_CURRENT: "CAL_CMD_ZERO_CURRENT",
    CAL_CMD_SET_FIXED_CURRENT: "CAL_CMD_SET_FIXED_CURRENT",
    CAL_CMD_CAPTURE_CURRENT: "CAL_CMD_CAPTURE_CURRENT",
    CAL_CMD_COMPUTE_SAVE: "CAL_CMD_COMPUTE_SAVE",
    CAL_CMD_CLEAR: "CAL_CMD_CLEAR",
}

# eCalResult, design doc section 5.3. Never printed as a bare number.
RESULT_TEXT = {
    0: "OK",
    1: "busy - another slot is already in calibration",
    2: "slot is running a test - stop it first",
    3: "slot is disabled by its ENABLE strap, or is a group follower",
    4: "per-unit reading outside the required window",
    5: "insufficient captures for the requested computation",
    6: "computed gain failed validation",
    7: "F-RAM write failed",
    8: "argument out of range",
    9: "slot is not in the calibration state",
}

# eCalStatus, design doc section 5.2.
CAL_STATUS_BITS = [
    "active",
    "v_low_captured",
    "v_high_captured",
    "i_zero_captured",
    "i_loaded_captured",
    "v_computed",
    "i_computed",
    "written_to_fram",
    "driving_current",
    "last_command_failed",
]

# BTS_STATUS_* bit positions, from registers.h plus the calibration additions.
BTS_STATUS_CALIBRATING = 12
BTS_STATUS_CAL_V_VALID = 13
BTS_STATUS_CAL_I_VALID = 14

# Register map: the per-channel calibration block, for the before/after table.
REG_CAL_BASE = 592
REG_CAL_STRIDE = 48
CAL_FIELDS = [
    "F28V_Gain", "F28V_Offset", "F28I_Gain", "F28I_Offset",
    "IoutGain_pu", "IoutOffset_pu", "IoutGain_A", "IoutOffset_A",
    "VoutGain_pu", "VoutOffset_pu", "VoutGain_V", "VoutOffset_V",
]

# Capture windows, design doc section 5.1 / 6.6.
PU_LOW_MAX = 0.2
PU_HIGH_MIN = 0.8

#
# Suggested supply voltages for the two capture points.
#
# NOT the design doc's worked example of 1.0 V / 4.0 V. At the measured
# VoutGain_pu of 0.2031 (bts_user_calibration.h:46-49), 1.0 V reads 0.2024 pu,
# which is ABOVE the "< 0.2" low window and is rejected with CAL_ERR_PU_RANGE;
# 4.0 V reads 0.8117 pu, clearing "> 0.8" by only 1.5%, so a slot whose gain
# runs 2% low also fails. These values leave real margin at both ends.
#
SUGGEST_V_LOW = 0.85    # ~0.173 pu
SUGGEST_V_HIGH = 4.25   # ~0.863 pu

FIXED_CURRENT_PU = 0.25
FIXED_CURRENT_PU_MAX = 0.8
SETTLE_S = 2.0
CMD_LATENCY_S = 0.20

SUPPORTED_DMM_MODELS = (
    "34401A", "34410A", "34411A", "34450A",
    "34460A", "34461A", "34465A", "34470A",
)
SUPPORTED_DMM_VENDORS = ("agilent", "keysight", "hewlett-packard", "hewlett packard")


class CalibrationError(RuntimeError):
    """A step failed in a way that ends this slot's calibration."""


class AbortRun(RuntimeError):
    """The operator asked to stop the whole run."""


def result_text(code: int) -> str:
    return RESULT_TEXT.get(code, f"unknown result code {code}")


def status_text(bits: int) -> str:
    on = [n for i, n in enumerate(CAL_STATUS_BITS) if bits & (1 << i)]
    return ",".join(on) if on else "-"


# --------------------------------------------------------------------------
# DMM
# --------------------------------------------------------------------------

class ScpiDmm:
    """Agilent/Keysight DMM over raw SCPI on TCP 5025.

    Deliberately sockets rather than VISA: the bench needs no extra runtime
    beyond the standard library, and the whole command set used here is four
    SCPI verbs.
    """

    def __init__(self, host: str, port: int = 5025, timeout: float = 15.0) -> None:
        self.host = host
        self.port = port
        self.timeout = timeout
        self._sock: Optional[socket.socket] = None
        self.idn = ""

    def connect(self, allow_unknown: bool = False) -> str:
        self._sock = socket.create_connection((self.host, self.port), timeout=self.timeout)
        self._sock.settimeout(self.timeout)
        self.idn = self.query("*IDN?")
        vendor, model = self._parse_idn(self.idn)
        if not self._supported(vendor, model):
            if not allow_unknown:
                self.close()
                raise CalibrationError(
                    f"unsupported DMM {self.idn!r}\n"
                    f"  supported: Agilent/Keysight {', '.join(SUPPORTED_DMM_MODELS)}\n"
                    f"  override with --allow-unknown-dmm if you know it speaks the same SCPI"
                )
            print(f"  WARNING: unrecognised DMM {self.idn!r}, continuing on --allow-unknown-dmm")
        self.write("*RST")
        self.write("*CLS")
        return self.idn

    @staticmethod
    def _parse_idn(idn: str) -> tuple[str, str]:
        parts = [p.strip() for p in idn.split(",")]
        vendor = parts[0] if parts else ""
        model = parts[1] if len(parts) > 1 else ""
        return vendor, model

    @staticmethod
    def _supported(vendor: str, model: str) -> bool:
        v = vendor.lower()
        if not any(k in v for k in SUPPORTED_DMM_VENDORS):
            return False
        m = model.upper()
        return any(known in m for known in SUPPORTED_DMM_MODELS)

    def write(self, cmd: str) -> None:
        assert self._sock is not None, "DMM not connected"
        self._sock.sendall((cmd + "\n").encode("ascii"))

    def query(self, cmd: str) -> str:
        assert self._sock is not None, "DMM not connected"
        self.write(cmd)
        chunks: list[bytes] = []
        while True:
            chunk = self._sock.recv(4096)
            if not chunk:
                raise CalibrationError("DMM closed the connection mid-query")
            chunks.append(chunk)
            if b"\n" in chunk:
                break
        return b"".join(chunks).decode("ascii", "replace").strip()

    def read_voltage(self) -> float:
        self.write("CONF:VOLT:DC AUTO")
        return float(self.query("READ?"))

    def read_current(self) -> float:
        self.write("CONF:CURR:DC AUTO")
        return float(self.query("READ?"))

    def close(self) -> None:
        if self._sock is not None:
            try:
                self._sock.close()
            finally:
                self._sock = None


class SimDmm:
    """Simulated DMM reading the dry-run bench model."""

    def __init__(self, bench: "SimBench") -> None:
        self.bench = bench
        self.idn = "Keysight Technologies,34461A,SIM000000,A.03.00-SIMULATED"

    def connect(self, allow_unknown: bool = False) -> str:
        return self.idn

    def read_voltage(self) -> float:
        return self.bench.true_voltage_v()

    def read_current(self) -> float:
        return self.bench.true_current_a()

    def close(self) -> None:
        pass


# --------------------------------------------------------------------------
# Transports
# --------------------------------------------------------------------------

@dataclass
class CalState:
    slot: int
    result: int
    status: int
    ads_v_pu: float
    ads_i_pu: float
    ads_v_v: float
    ads_i_a: float
    f28_v_pu: float
    f28_i_pu: float
    f28_v_v: float
    f28_i_a: float
    temp_c: float
    v_valid: bool
    i_valid: bool

    @classmethod
    def unpack(cls, raw: bytes) -> "CalState":
        if len(raw) < CAL_STATUS_LEN:
            raise CalibrationError(
                f"calibration status record is {len(raw)}B, expected {CAL_STATUS_LEN}B - "
                "firmware and this script disagree on BLE_PROTO_VERSION"
            )
        f = struct.unpack(CAL_STATUS_FMT, raw[:CAL_STATUS_LEN])
        return cls(
            slot=f[0], result=f[5], status=f[4],
            ads_v_pu=f[6], ads_i_pu=f[7], ads_v_v=f[8], ads_i_a=f[9],
            f28_v_pu=f[10], f28_i_pu=f[11], f28_v_v=f[12], f28_i_a=f[13],
            temp_c=f[14], v_valid=bool(f[2]), i_valid=bool(f[3]),
        )

    def bit(self, n: int) -> bool:
        return bool(self.status & (1 << n))


class Transport:
    """What the guided flow needs from the tester, over whatever link."""

    async def connect(self) -> None: ...
    async def close(self) -> None: ...
    async def send(self, opcode: int, slot: int, arg: float = 0.0) -> CalState: ...
    async def read_cal(self) -> CalState: ...
    async def read_slot_status_bits(self, slot: int) -> int: ...
    async def read_cal_block(self, slot: int) -> Optional[dict[str, float]]:
        """Persisted gains for `slot`, or None when no register path exists."""
        return None


class BleTransport(Transport):
    """bleak, reusing the connect pattern from ble_verify.py."""

    def __init__(self, address: Optional[str], http_host: Optional[str] = None) -> None:
        self.address = address
        self.http_host = http_host
        self._client: Any = None

    async def connect(self) -> None:
        try:
            from bleak import BleakClient, BleakScanner
        except ImportError as exc:  # pragma: no cover - bench dependency
            raise CalibrationError(
                "bleak is not installed. `pip install bleak`, or use --dry-run."
            ) from exc

        address = self.address
        if not address:
            print(f"scanning for {DEVICE_NAME} ...", flush=True)
            dev = await BleakScanner.find_device_by_name(DEVICE_NAME, timeout=15.0)
            if dev is None:
                raise CalibrationError(f"{DEVICE_NAME} is not advertising")
            address = dev.address
            self.address = address

        print(f"connecting to {address} ...", flush=True)
        self._client = BleakClient(address, timeout=25.0)
        await self._client.connect()

        uuids = {c.uuid.lower()
                 for s in self._client.services if s.uuid.lower() == SERVICE.lower()
                 for c in s.characteristics}
        if not uuids:
            raise CalibrationError(f"service {SERVICE} not present on {address}")
        for needed in (CAL_CONTROL, CAL_STATUS):
            if needed.lower() not in uuids:
                raise CalibrationError(
                    f"characteristic {needed} missing - this firmware predates "
                    "BLE_PROTO_VERSION 2 and has no calibration interface"
                )
        print(f"connected, mtu={self._client.mtu_size}")

    async def close(self) -> None:
        if self._client is not None:
            try:
                await self._client.disconnect()
            finally:
                self._client = None

    async def send(self, opcode: int, slot: int, arg: float = 0.0) -> CalState:
        payload = struct.pack(CAL_CMD_FMT, opcode, slot, 0, float(arg))
        await self._client.write_gatt_char(CAL_CONTROL, payload, response=True)
        await asyncio.sleep(CMD_LATENCY_S)
        return await self.read_cal()

    async def read_cal(self) -> CalState:
        return CalState.unpack(await self._client.read_gatt_char(CAL_STATUS))

    async def read_slot_status_bits(self, slot: int) -> int:
        await self._client.write_gatt_char(SLOT_SELECT, bytes([slot]), response=True)
        raw = await self._client.read_gatt_char(SLOT_STATUS)
        if len(raw) < SLOT_LEN:
            raise CalibrationError("slot status record too short to decode")
        return struct.unpack(SLOT_FMT, raw[:SLOT_LEN])[12]

    async def read_cal_block(self, slot: int) -> Optional[dict[str, float]]:
        """Persisted gains via GET /api/registers, when an HTTP host is known.

        There is no GATT characteristic for the calibration block, so without
        an HTTP host the before/after table has no "before" column.
        """
        if not self.http_host:
            return None
        import urllib.request

        addr = REG_CAL_BASE + slot * REG_CAL_STRIDE
        url = f"http://{self.http_host}/api/registers?addr={addr}&count=12"
        try:
            with urllib.request.urlopen(url, timeout=5.0) as resp:
                doc = json.loads(resp.read().decode("utf-8"))
        except Exception as exc:
            print(f"  (register read-back failed: {exc})")
            return None
        if not doc.get("ok") or len(doc.get("values", [])) < 12:
            return None
        return dict(zip(CAL_FIELDS, (float(v) for v in doc["values"][:12])))


class SimBench:
    """Dry-run model of one slot plus the external supply and DMM.

    Holds a plausible true gain per slot and a bench state the guided prompts
    move through, so --dry-run exercises the same code path as a real run.
    """

    # Known-good compile-time values from bts_user_calibration.h.
    TRUE_VOUT_GAIN_PU = 0.2029
    TRUE_IOUT_GAIN_PU = 0.1002

    def __init__(self, seed: int = 4) -> None:
        self._rng = random.Random(seed)
        self.slot = 255
        self.supply_v = 0.0
        self.series_connected = False
        self.fixed_pu = 0.0
        self.status = 0
        self.captures: dict[str, tuple[float, float]] = {}
        self.persisted: dict[int, dict[str, float]] = {}
        self.ticks: dict[int, tuple[bool, bool]] = {}
        self._gain_v: dict[int, float] = {}
        self._gain_i: dict[int, float] = {}

    def _v_gain(self, slot: int) -> float:
        if slot not in self._gain_v:
            self._gain_v[slot] = self.TRUE_VOUT_GAIN_PU * self._rng.uniform(0.97, 1.03)
        return self._gain_v[slot]

    def _i_gain(self, slot: int) -> float:
        if slot not in self._gain_i:
            self._gain_i[slot] = self.TRUE_IOUT_GAIN_PU * self._rng.uniform(0.97, 1.03)
        return self._gain_i[slot]

    def true_voltage_v(self) -> float:
        return self.supply_v + self._rng.uniform(-0.0004, 0.0004)

    def true_current_a(self) -> float:
        if not self.series_connected or self.fixed_pu <= 0.0:
            return self._rng.uniform(-0.0002, 0.0002)
        amps = self.fixed_pu / self._i_gain(self.slot)
        return amps + self._rng.uniform(-0.004, 0.004)

    def telemetry(self) -> dict[str, float]:
        v_pu = self.supply_v * self._v_gain(self.slot) + 0.0013
        i_pu = 0.0
        if self.series_connected and self.fixed_pu > 0.0:
            # Discharge: the firmware's own sign convention is negative.
            i_pu = -self.fixed_pu
        return {
            "ads_v_pu": v_pu,
            "ads_i_pu": i_pu,
            "ads_v_v": self.supply_v,
            "ads_i_a": -abs(self.true_current_a()) if i_pu else 0.0,
            "f28_v_pu": self.supply_v * 0.4 + 0.001,
            "f28_i_pu": i_pu * 4.0,
            "f28_v_v": self.supply_v * 0.999,
            "f28_i_a": -abs(self.true_current_a()) if i_pu else 0.0,
            "temp_c": 23.4,
        }


class SimTransport(Transport):
    """Simulated tester implementing the section 5 command protocol."""

    def __init__(self) -> None:
        self.bench = SimBench()
        self.result = 0

    async def connect(self) -> None:
        print("dry run: simulated BTS-Tester, no radio in use")

    async def close(self) -> None:
        pass

    def _set_bit(self, n: int) -> None:
        self.bench.status |= (1 << n)

    async def send(self, opcode: int, slot: int, arg: float = 0.0) -> CalState:
        b = self.bench
        self.result = 0
        b.status &= ~(1 << 9)

        if opcode == CAL_CMD_ENTER:
            b.slot = slot
            b.status = 1 << 0
            b.captures.clear()
            b.supply_v = 0.0
            b.series_connected = False
            b.fixed_pu = 0.0
        elif opcode == CAL_CMD_EXIT:
            b.fixed_pu = 0.0
            b.status = 0
            b.slot = 255
        elif opcode == CAL_CMD_CLEAR:
            b.captures.clear()
            b.status = 1 << 0
        elif opcode == CAL_CMD_CAPTURE_VOLTAGE:
            pu = b.telemetry()["ads_v_pu"]
            if pu < PU_LOW_MAX:
                b.captures["v_lo"] = (pu, arg)
                self._set_bit(1)
            elif pu > PU_HIGH_MIN:
                b.captures["v_hi"] = (pu, arg)
                self._set_bit(2)
            else:
                self.result = 4
        elif opcode == CAL_CMD_ZERO_CURRENT:
            b.captures["i_zero"] = (b.telemetry()["ads_i_pu"], 0.0)
            self._set_bit(3)
        elif opcode == CAL_CMD_SET_FIXED_CURRENT:
            if arg < 0.0 or arg > FIXED_CURRENT_PU_MAX:
                self.result = 8
            else:
                b.fixed_pu = arg
                self._set_bit(8)
        elif opcode == CAL_CMD_CAPTURE_CURRENT:
            b.captures["i_hi"] = (b.telemetry()["ads_i_pu"], arg)
            self._set_bit(4)
        elif opcode == CAL_CMD_COMPUTE_SAVE:
            self._compute_save()
        else:
            self.result = 8

        if self.result != 0:
            self._set_bit(9)
        await asyncio.sleep(0)
        return await self.read_cal()

    def _compute_save(self) -> None:
        b = self.bench
        block = dict(zip(CAL_FIELDS, [1.0, 0.0, 1.0, 0.0,
                                      0.1, 0.0, 10.0, 0.0,
                                      0.2, 0.0, 5.0, 0.0]))
        did_any = False

        if "v_lo" in b.captures and "v_hi" in b.captures:
            (pu_lo, v_lo), (pu_hi, v_hi) = b.captures["v_lo"], b.captures["v_hi"]
            gain_pu, off_pu = two_point(pu_lo, v_lo, pu_hi, v_hi)
            block["VoutGain_pu"] = gain_pu
            block["VoutOffset_pu"] = off_pu
            block["VoutGain_V"] = 1.0 / gain_pu
            block["VoutOffset_V"] = -off_pu / gain_pu
            self._set_bit(5)
            did_any = True

        if "i_zero" in b.captures and "i_hi" in b.captures:
            (pu_zero, _), (pu_hi, i_hi) = b.captures["i_zero"], b.captures["i_hi"]
            gain_pu = (abs(pu_hi) - abs(pu_zero)) / i_hi
            block["IoutGain_pu"] = gain_pu
            block["IoutOffset_pu"] = pu_zero
            block["IoutGain_A"] = 1.0 / gain_pu
            block["IoutOffset_A"] = -pu_zero / gain_pu
            self._set_bit(6)
            did_any = True

        if not did_any:
            self.result = 5
            return

        self._set_bit(7)
        b.persisted[b.slot] = block
        b.ticks[b.slot] = (bool(b.status & (1 << 5)), bool(b.status & (1 << 6)))

    async def read_cal(self) -> CalState:
        b = self.bench
        t = b.telemetry() if b.slot != 255 else {k: 0.0 for k in (
            "ads_v_pu", "ads_i_pu", "ads_v_v", "ads_i_a",
            "f28_v_pu", "f28_i_pu", "f28_v_v", "f28_i_a", "temp_c")}
        v_ok, i_ok = b.ticks.get(b.slot, (False, False))
        return CalState(slot=b.slot, result=self.result, status=b.status,
                        v_valid=v_ok, i_valid=i_ok, **t)

    async def read_slot_status_bits(self, slot: int) -> int:
        v_ok, i_ok = self.bench.ticks.get(slot, (False, False))
        bits = 1 << 1  # stopped
        if v_ok:
            bits |= 1 << BTS_STATUS_CAL_V_VALID
        if i_ok:
            bits |= 1 << BTS_STATUS_CAL_I_VALID
        return bits

    async def read_cal_block(self, slot: int) -> Optional[dict[str, float]]:
        return self.bench.persisted.get(slot)

    def sim_step(self, step: str) -> None:
        """Move the simulated bench to the state the prompt asked the operator for."""
        b = self.bench
        if step == "connect":
            b.supply_v, b.series_connected, b.fixed_pu = 0.0, False, 0.0
        elif step == "v_low":
            b.supply_v = SUGGEST_V_LOW
        elif step == "v_high":
            b.supply_v = SUGGEST_V_HIGH
        elif step == "i_zero":
            b.supply_v, b.series_connected = 0.0, False
        elif step == "i_load":
            b.supply_v, b.series_connected = 3.7, True


def two_point(pu_lo: float, v_lo: float, pu_hi: float, v_hi: float) -> tuple[float, float]:
    """Design doc section 6.1: gain in pu-per-engineering-unit, plus its offset."""
    gain = (pu_hi - pu_lo) / (v_hi - v_lo)
    return gain, pu_lo - v_lo * gain


# --------------------------------------------------------------------------
# Configuration
# --------------------------------------------------------------------------

@dataclass
class Config:
    dmm_host: str = ""
    dmm_port: int = 5025
    ble_address: str = ""
    http_host: str = ""

    @classmethod
    def load(cls, path: Path) -> "Config":
        cfg = cls()
        if not path.exists():
            return cfg
        parser = configparser.ConfigParser()
        parser.read(path)
        cfg.dmm_host = parser.get("dmm", "host", fallback="")
        cfg.dmm_port = parser.getint("dmm", "port", fallback=5025)
        cfg.ble_address = parser.get("ble", "address", fallback="")
        cfg.http_host = parser.get("http", "host", fallback="")
        return cfg

    def save(self, path: Path) -> None:
        parser = configparser.ConfigParser()
        parser["dmm"] = {"host": self.dmm_host, "port": str(self.dmm_port)}
        parser["ble"] = {"address": self.ble_address}
        parser["http"] = {"host": self.http_host}
        with path.open("w", encoding="utf-8") as fh:
            parser.write(fh)


def configure(cfg: Config, path: Path, force: bool) -> Config:
    if cfg.dmm_host and not force:
        print(f"using {path.name}: DMM {cfg.dmm_host}:{cfg.dmm_port}, "
              f"BLE {cfg.ble_address or '(scan)'}, "
              f"HTTP {cfg.http_host or '(none)'}")
        return cfg

    print("=== configuration ===")

    def ask(label: str, current: str) -> str:
        suffix = f" [{current}]" if current else ""
        answer = input(f"  {label}{suffix}: ").strip()
        return answer or current

    cfg.dmm_host = ask("DMM IP address", cfg.dmm_host)
    cfg.dmm_port = int(ask("DMM SCPI port", str(cfg.dmm_port)) or 5025)
    cfg.ble_address = ask("BLE address (blank to scan for BTS-Tester)", cfg.ble_address)
    cfg.http_host = ask("Tester HTTP host, optional, for the gain read-back",
                        cfg.http_host)
    cfg.save(path)
    print(f"  saved to {path}")
    return cfg


# --------------------------------------------------------------------------
# Guided flow
# --------------------------------------------------------------------------

@dataclass
class SlotReport:
    slot: int            # 1-based, as the operator sees it
    index: int           # 0-based, as eCalSlot carries it
    status: str = "pending"
    error: Optional[str] = None
    captures: dict[str, float] = field(default_factory=dict)
    before: Optional[dict[str, float]] = None
    after: Optional[dict[str, float]] = None
    cal_status_bits: int = 0
    v_valid: bool = False
    i_valid: bool = False


class Calibrator:
    def __init__(self, transport: Transport, dmm: Any, dry_run: bool) -> None:
        self.t = transport
        self.dmm = dmm
        self.dry_run = dry_run
        self.active_slot: Optional[int] = None

    # -- plumbing ---------------------------------------------------------

    async def command(self, opcode: int, slot: int, arg: float = 0.0) -> CalState:
        state = await self.t.send(opcode, slot, arg)
        if state.result != 0:
            raise CalibrationError(
                f"{CMD_NAMES.get(opcode, opcode)} refused: {result_text(state.result)}"
            )
        return state

    def prompt(self, step: str, message: str) -> None:
        print(f"  ACTION: {message}")
        if self.dry_run:
            sim_step = getattr(self.t, "sim_step", None)
            if sim_step is not None:
                sim_step(step)
            print("          (dry run: assumed done)")
            return
        answer = input("          press Enter when done, or 's' to skip this slot: ")
        if answer.strip().lower() == "s":
            raise CalibrationError("skipped by operator")

    async def wait_for_pu(self, step: str, want: str, timeout: float = 120.0) -> CalState:
        """Block until the live ADS per-unit reading is inside the capture window.

        The firmware would reject a capture outside it with CAL_ERR_PU_RANGE;
        checking here means the operator adjusts the supply against a live
        number instead of guessing and retrying.
        """
        deadline = time.monotonic() + timeout
        last_print = 0.0
        while True:
            state = await self.t.read_cal()
            pu = state.ads_v_pu if want in ("low", "high") else abs(state.ads_i_pu)
            ok = (pu < PU_LOW_MAX) if want == "low" else (pu > PU_HIGH_MIN)
            now = time.monotonic()
            if ok:
                print(f"          pu = {pu:.4f}  OK")
                return state
            if now - last_print > 1.0 or last_print == 0.0:
                target = f"< {PU_LOW_MAX}" if want == "low" else f"> {PU_HIGH_MIN}"
                print(f"          pu = {pu:.4f}, need {target} ... adjust the supply")
                last_print = now
            if now > deadline:
                raise CalibrationError(
                    f"per-unit reading never reached the {want} window "
                    f"(last {pu:.4f}); check the slot wiring and the supply"
                )
            if self.dry_run:
                raise CalibrationError(
                    f"simulated bench never reached the {want} window ({pu:.4f})"
                )
            await asyncio.sleep(0.5)

    # -- the sequence -----------------------------------------------------

    async def run_slot(self, slot1: int) -> SlotReport:
        idx = slot1 - 1
        rep = SlotReport(slot=slot1, index=idx)
        print(f"\n=== slot {slot1} (eCalSlot {idx}) ===")

        try:
            rep.before = await self.t.read_cal_block(idx)

            self.prompt("connect",
                        f"connect the DC supply and the DMM across slot {slot1}, "
                        "DMM in PARALLEL for the voltage phase")

            await self.command(CAL_CMD_ENTER, idx)
            self.active_slot = idx
            print("  entered calibration")

            # --- voltage, low point ---
            self.prompt("v_low", f"set the supply to about {SUGGEST_V_LOW:.2f} V")
            await self.wait_for_pu("v_low", "low")
            v_lo = self.dmm.read_voltage()
            print(f"          DMM: {v_lo:.5f} V")
            st = await self.command(CAL_CMD_CAPTURE_VOLTAGE, idx, v_lo)
            rep.captures["v_low_v"] = v_lo
            rep.captures["v_low_pu"] = st.ads_v_pu

            # --- voltage, high point ---
            self.prompt("v_high", f"raise the supply to about {SUGGEST_V_HIGH:.2f} V")
            await self.wait_for_pu("v_high", "high")
            v_hi = self.dmm.read_voltage()
            print(f"          DMM: {v_hi:.5f} V")
            st = await self.command(CAL_CMD_CAPTURE_VOLTAGE, idx, v_hi)
            rep.captures["v_high_v"] = v_hi
            rep.captures["v_high_pu"] = st.ads_v_pu

            # --- current, zero point ---
            self.prompt("i_zero",
                        "turn the supply output OFF and break the slot current path")
            st = await self.command(CAL_CMD_ZERO_CURRENT, idx)
            rep.captures["i_zero_pu"] = st.ads_i_pu
            print(f"          zero captured at pu {st.ads_i_pu:.5f}")

            # --- current, loaded point ---
            self.prompt(
                "i_load",
                "move the DMM into SERIES with the slot, set the supply to about "
                "3.7 V, and set ITS current limit to 3 A as the backstop, then "
                "turn the output on",
            )
            await self.command(CAL_CMD_SET_FIXED_CURRENT, idx, FIXED_CURRENT_PU)
            print(f"  driving {FIXED_CURRENT_PU} pu discharge, settling {SETTLE_S:.0f} s ...")
            await asyncio.sleep(0.0 if self.dry_run else SETTLE_S)

            i_hi = abs(self.dmm.read_current())   # MAGNITUDE - the firmware signs it
            print(f"          DMM: {i_hi:.5f} A (entered as a magnitude)")
            st = await self.command(CAL_CMD_CAPTURE_CURRENT, idx, i_hi)
            rep.captures["i_high_a"] = i_hi
            rep.captures["i_high_pu"] = st.ads_i_pu

            # --- compute, validate, persist ---
            st = await self.command(CAL_CMD_COMPUTE_SAVE, idx)
            rep.cal_status_bits = st.status
            print(f"  compute/save: {status_text(st.status)}")
            if not st.bit(7):
                raise CalibrationError("compute completed but nothing was written to F-RAM")

            await self.command(CAL_CMD_EXIT, idx)
            self.active_slot = None

            bits = await self.t.read_slot_status_bits(idx)
            rep.v_valid = bool(bits & (1 << BTS_STATUS_CAL_V_VALID))
            rep.i_valid = bool(bits & (1 << BTS_STATUS_CAL_I_VALID))
            rep.after = await self.t.read_cal_block(idx)

            if not (rep.v_valid and rep.i_valid):
                raise CalibrationError(
                    f"slot status bits 13/14 after save: V={rep.v_valid} I={rep.i_valid} "
                    "- the display ticks will not both be green"
                )

            rep.status = "ok"
            print(f"  slot {slot1} calibrated: voltage tick + current tick")

        except CalibrationError as exc:
            rep.status = "skipped" if "skipped by operator" in str(exc) else "failed"
            rep.error = str(exc)
            print(f"  slot {slot1} {rep.status}: {exc}")
            await self.safe_exit()

        return rep

    async def safe_exit(self) -> None:
        """Leave calibration, whatever went wrong. Never raises."""
        if self.active_slot is None:
            return
        slot = self.active_slot
        self.active_slot = None
        try:
            await self.t.send(CAL_CMD_EXIT, slot)
            print(f"  CAL_CMD_EXIT sent for slot {slot + 1}, reference zeroed")
        except Exception as exc:  # the bench matters more than the traceback
            print(f"  WARNING: CAL_CMD_EXIT for slot {slot + 1} failed: {exc}")
            print("  CHECK THE SLOT - it may still be driving current")


# --------------------------------------------------------------------------
# Reporting
# --------------------------------------------------------------------------

def print_gain_table(rep: SlotReport) -> None:
    if rep.after is None and rep.before is None:
        return
    print(f"\n  gains, slot {rep.slot}")
    print(f"    {'field':<16} {'before':>14} {'after':>14} {'change':>10}")
    for name in CAL_FIELDS:
        before = rep.before.get(name) if rep.before else None
        after = rep.after.get(name) if rep.after else None
        b_txt = f"{before:.6g}" if before is not None else "n/a"
        a_txt = f"{after:.6g}" if after is not None else "n/a"
        if before is not None and after is not None and before != 0.0:
            delta = f"{(after - before) / abs(before) * 100.0:+.2f}%"
        else:
            delta = "-"
        print(f"    {name:<16} {b_txt:>14} {a_txt:>14} {delta:>10}")


def write_report(path: Path, cfg: Config, dmm_idn: str, dry_run: bool,
                 started: datetime, reports: Sequence[SlotReport]) -> None:
    doc = {
        "tool": "calibrate.py",
        "tool_version": TOOL_VERSION,
        "dry_run": dry_run,
        "started_utc": started.isoformat(),
        "finished_utc": datetime.now(timezone.utc).isoformat(),
        "dmm": {"idn": dmm_idn, "host": cfg.dmm_host, "port": cfg.dmm_port},
        "ble": {"address": cfg.ble_address or "(scanned)", "device_name": DEVICE_NAME},
        "slots": [
            {
                "slot": r.slot,
                "cal_slot_index": r.index,
                "status": r.status,
                "error": r.error,
                "captures": {k: round(v, 6) for k, v in r.captures.items()},
                "cal_status_bits": r.cal_status_bits,
                "cal_status": status_text(r.cal_status_bits),
                "voltage_tick": r.v_valid,
                "current_tick": r.i_valid,
                "gains_before": r.before,
                "gains_after": r.after,
            }
            for r in reports
        ],
        "summary": {
            "ok": sum(1 for r in reports if r.status == "ok"),
            "failed": sum(1 for r in reports if r.status == "failed"),
            "skipped": sum(1 for r in reports if r.status == "skipped"),
        },
    }
    path.write_text(json.dumps(doc, indent=2), encoding="utf-8")
    print(f"\nreport written to {path}")


# --------------------------------------------------------------------------
# Entry point
# --------------------------------------------------------------------------

def parse_slots(spec: str) -> list[int]:
    slots: list[int] = []
    for part in spec.split(","):
        part = part.strip()
        if not part:
            continue
        if "-" in part:
            lo, hi = (int(x) for x in part.split("-", 1))
            slots.extend(range(lo, hi + 1))
        else:
            slots.append(int(part))
    bad = [s for s in slots if not 1 <= s <= 8]
    if bad:
        raise SystemExit(f"slot numbers must be 1-8, got {bad}")
    return slots


async def run(args: argparse.Namespace) -> int:
    started = datetime.now(timezone.utc)
    cfg = Config.load(CONFIG_PATH)

    if args.dry_run:
        transport: Transport = SimTransport()
        dmm: Any = SimDmm(transport.bench)
    else:
        cfg = configure(cfg, CONFIG_PATH, args.reconfigure)
        if not cfg.dmm_host:
            raise SystemExit("no DMM host configured")
        transport = BleTransport(cfg.ble_address or None, cfg.http_host or None)
        dmm = ScpiDmm(cfg.dmm_host, cfg.dmm_port)

    print("\n=== DMM ===")
    idn = dmm.connect(allow_unknown=args.allow_unknown_dmm)
    print(f"  {idn}")

    print("\n=== tester ===")
    await transport.connect()
    if not args.dry_run and isinstance(transport, BleTransport) and transport.address:
        cfg.ble_address = transport.address
        cfg.save(CONFIG_PATH)

    print("\n" + "=" * 68)
    print("  HARDWARE OVER-CURRENT TRIPS ARE DISABLED IN THIS FIRMWARE BUILD.")
    print("  The bench supply's own current limit is the only fast backstop.")
    print("  Do not leave this run unattended. Enter DMM currents as MAGNITUDES.")
    print("=" * 68)

    cal = Calibrator(transport, dmm, args.dry_run)
    reports: list[SlotReport] = []
    try:
        for slot in parse_slots(args.slots):
            rep = await cal.run_slot(slot)
            print_gain_table(rep)
            reports.append(rep)
    except (KeyboardInterrupt, AbortRun):
        print("\ninterrupted - leaving calibration")
        await cal.safe_exit()
    except Exception as exc:
        print(f"\nunexpected failure: {exc}")
        await cal.safe_exit()
        raise
    finally:
        await cal.safe_exit()
        await transport.close()
        dmm.close()

    write_report(Path(args.report), cfg, idn, args.dry_run, started, reports)

    ok = sum(1 for r in reports if r.status == "ok")
    print(f"\n{ok}/{len(reports)} slots calibrated")
    for r in reports:
        if r.status != "ok":
            print(f"  slot {r.slot}: {r.status} - {r.error}")
    return 0 if reports and ok == len(reports) else 1


def main() -> int:
    ap = argparse.ArgumentParser(
        description="Guided two-point slot calibration for the TIDA-010086 BTS.")
    ap.add_argument("--slots", default="1-8",
                    help="slots to calibrate, 1-based, e.g. '1-8' or '3,5' (default 1-8)")
    ap.add_argument("--dry-run", action="store_true",
                    help="run the whole flow against a simulated tester and DMM")
    ap.add_argument("--reconfigure", action="store_true",
                    help="re-prompt for the DMM, BLE and HTTP settings")
    ap.add_argument("--allow-unknown-dmm", action="store_true",
                    help="continue even if *IDN? reports an unrecognised model")
    ap.add_argument("--report", default="calibration-report.json",
                    help="path for the JSON report (default calibration-report.json)")
    args = ap.parse_args()

    try:
        return asyncio.run(run(args))
    except KeyboardInterrupt:
        print("\naborted")
        return 130
    except CalibrationError as exc:
        print(f"error: {exc}")
        return 1


if __name__ == "__main__":
    sys.exit(main())
