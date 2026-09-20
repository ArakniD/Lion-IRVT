# I2C Interfaces — Operational Notes

Two separate buses, both at address `0x50`, both easy to confuse with each
other.

**The complete register map — every address, stride, access type, units and
meaning — is in `Docs/api-specification.md` Part 2.** It is authoritative and
is not duplicated here; a duplicated table is exactly what went stale last
time. This file covers the parts that are operational rather than tabular:
how the buses behave, what breaks, and why.

---

## I2CA — host register bus (target side)

| Property | Value | Source |
|---|---|---|
| Pins | GPIO32 = SDAA, GPIO33 = SCLA | `bts_hal.c:972-976`, `bts_user_settings.h:556-557` |
| Address | `0x50`, 7-bit | `BTS_I2C_TARGET_ADDRESS`, `com_cpu2.c:125` |
| Target clock config | 100 kHz | `com_cpu2.c` `initI2C_Slave` |
| Actual bus speed | **50 kHz**, set by the ESP32 controller | `bts_link.c:708` |
| Pull-ups | board 10 kΩ + ESP32 internal | |

The 100 kHz in `I2C_initController()` on the target sets the module
prescaler, which the TRM requires even on a target because it times the data
setup/hold windows and clocks the input filter. It does **not** set the bus
speed — a target never drives SCL. The controller decides, and the ESP32 runs
50 kHz because the ribbon to the BTS board with weak pull-ups will not
reliably make the rise time at 100 kHz.

### Protocol

```
write:  S 0x50+W  addrHi addrLo  b0 b1 b2 b3 [b0 b1 b2 b3 ...]  P
read:   S 0x50+W  addrHi addrLo  Sr 0x50+R  pad b0 b1 b2 b3 [...]  P
```

- The address on the wire is a **byte** address; the index into `registers[]`
  is `address / 4`.
- Each register is one IEEE-754 float in **big-endian** byte order. (BLE is
  little-endian. CAN is little-endian word order. They are all different.)
- Both directions auto-increment by 4 after a **complete** register, so a
  burst over a block is one transaction. A burst write must **not** re-send
  the address between registers.

### The lead-in pad byte

> **A read must fetch `1 + count*4` bytes and discard the first.**

The C2000 starts clocking data out the instant it acknowledges the repeated
start — before its ISR can possibly run. Whatever `I2CDXR` holds at that
moment goes out first, so every reply carries one stale byte in front. The
target mitigates this by staging the first real byte during the *address*
phase (`com_cpu2.c` `eI2cAddrLo` case), which is why the reply is only one
byte late rather than four; it cannot eliminate it.

This is a property of the peripheral, not a fixable target bug. A client that
omits the discard gets every float assembled from three bytes of one register
and one byte of the next — plausible-looking nonsense, which on a control
register is worse than an obvious failure.

The pad is **one byte per transaction**, not per register: a 14-register burst
reads 57 bytes and drops exactly one.

The reference implementation is `bus_read_block()` in
`esp32-btle-proxy/components/bts_link/bts_link.c:52-91`. Keep its handling
when adding a new read path.

### Edge cases

| Situation | Behaviour |
|---|---|
| Write to an `REG_ACCESS_RO` register | Silently dropped — no NACK, no error |
| Write to an address ≥ `TOTAL_REGISTERS` | Silently dropped |
| Read of an address ≥ `TOTAL_REGISTERS` | Returns `-1.0f`, a valid float, not an error |
| Auto-increment past the top (1256) | Stops advancing; a continuing read repeats register 1256 |
| Read with no preceding address write | Continues from wherever the last transaction left off |
| Concurrent I2C / UART / CAN writes | Last writer wins; CPU1 is notified of the final value only |
| NaN / Inf written to an RW register | Stored verbatim; the device does not sanitise |

The address persisting between transactions is deliberate (it is what makes
burst reads work) but it means **always write the address** before a read you
care about.

### Interrupt split

Framing is on **PIE 8.1** (`INT_I2CA` → `i2cSlaveISR`: address match, stop,
arbitration-lost, NACK) and the data bytes are on **PIE 8.2**
(`INT_I2CA_FIFO` → `i2cSlaveFifoISR`). With the FIFO enabled the TRM forbids
the basic RRDY/XRDY interrupts, and mixing the two is what previously let a
data byte be parsed as an address byte.

Three details in `initI2C_Slave()` each stop the target answering on their
own, and are commented in place:

- The prescaler must be set even though a target never drives SCL.
- `I2CCNT` is decremented by the target as well as the controller. Left at
  zero the module ACKs its address then holds SCL low forever while its own
  status register still reports the bus free.
- The FIFO interrupts arrive on `INT_I2CA_FIFO`, not `INT_I2CA`.

`AAS` is a **level, not a latched flag** — it stays asserted for as long as
this unit is the addressed target. It has to be edge-detected, and the
direction bit watched as well, because a register read is addressed twice
(write the address, repeated start, read) without `AAS` necessarily dropping
in between. Keying purely off its edge meant the read half was never
recognised and the transmit side was never primed.

### Target watchdog

A target interrupted mid-byte — the host resetting, a cable pulled, a transfer
abandoned on timeout — can be left holding SCL low with `BUS_BUSY` set and no
interrupt pending. Nothing on the target side clears that: the ISR only runs
when the module asks, and a wedged module never asks. The bus then jams for
every device on it.

`serviceI2CTargetWatchdog()` (`com_cpu2.c:2615`, called from the idle loop)
watches for `BUS_BUSY` persisting with no address-match activity and
reinitialises. Note it does a **full `SysCtl_resetPeripheral()`**, not just
the module reset bit: clearing `IRS` releases SCL, but the module comes back
still believing it is an addressed target transmitter (`TARGET_DIR` set) and
clamps the clock again. Only the system-controller reset drops that latched
state.

> ### Halting CPU2 in the debugger wedges the target, and the watchdog
> ### cannot rescue it
>
> The recovery above runs from **CPU2's idle loop**. A breakpoint that stops
> CPU2 part way through an I2C transaction stops the very loop that would
> clear the jam, so the target is left holding SCL with `BUS_BUSY` set and
> nothing running to notice.
>
> The ESP32 link does **not** recover when you resume — it needs a reload or
> a power cycle. This is a debugging artefact, not a firmware fault, but it
> costs a bring-up session every time. If you must break on CPU2, break
> somewhere the I2C ISR is not active.

### What a write actually does

`applyHostRegisterWrite()` (`com_cpu2.c:2553`) is the single funnel for
I2C, UART and CAN writes:

1. `registers[regIdx] = value`
2. `notifyCpu1RegisterWrite()` → `IPC_FLAG0` with `ipcMsg` as payload —
   **non-blocking**, skipped if the previous flag is unacknowledged, because
   CPU1 re-reads the affected block from `registers[]` anyway.
3. **`hostWatchdogFeed()`** — this is the reload hook for all three write
   paths. See the watchdog section below.
4. If the register is `eCalibrationMode` and the value is exactly `2.0f`, set
   `calibrationSavePending` for the idle loop.
5. If the register is `eCalCommand` and the value is non-zero, **self-clear it
   to 0** and clear `eCalStatus` bit 7. The opcode already travelled to CPU1
   in the IPC payload, so clearing the register cannot lose it — and a host
   polling `eCalCommand` sees 0 as soon as the write is accepted.
6. If the register is `eHostWatchdog_s` and the value is `0.0f`, raise a
   deferred warning — supervision has just been turned off.

CPU1 only *decodes* a subset: the settings region's mode register and
calibration group, and `eCalCommand`. Anything else — including
`eHostWatchdog_s` — has its flag acked and is silently discarded. The runtime
region is RO and never reaches the decode at all. **A new register that CPU1
must act on needs an explicit branch in `BTS_HandleRegisterWrite()`.**

### A READ also reloads the host watchdog

The fourth reload hook, and the one that is easy to miss: `i2cSlaveFifoISR()`
calls `hostWatchdogFeed()` on its **transmit** branch
(`com_cpu2.c:2915`), so a host that only ever reads still proves it is alive.

That is not an optimisation. The ESP32's steady state is nine read
transactions every 250 ms and **not a single write**, so a unit that reloaded
on writes alone would pause every running slot 30 s after the last mode
command while the link was perfectly healthy.

The hook is on the transmit side rather than the address phase because that is
where a read is unambiguous — the address phase is shared with a write. It
sits before the `txCount == 0` guard, so it runs once per transmitted byte
rather than once per register; harmless, since the feed is idempotent.

**Verified on hardware:** `eWatchdogRemaining_s` (1220) holds steady at 30.0
while the ESP32 polls, with no writes on the bus.

---

## I2CB — F-RAM and ADS1119 (controller side)

| Property | Value |
|---|---|
| Pins | **GPIO40 = SDAB, GPIO41 = SCLB** |
| Speed | 400 kHz |
| Devices | FM24V10 F-RAM `0x50`; ADS1119 `0x40` (slots 1-4), `0x41` (slots 5-8) |
| DRDY | GPIO42 → XINT1, GPIO43 → XINT2 |

The F-RAM at `0x50` shares its address with the host-facing target on I2CA.
Different bus, no conflict — but it makes grepping for `0x50` ambiguous.

**The two device families need different access helpers.** The F-RAM is
memory-addressed, so `i2cWriteBlock` / `i2cReadBlock` always emit a 16-bit
word address. The ADS1119 is **command-based**: an access is a single command
byte, sometimes followed by a read phase (`RREG`, `RDATA`). Driving it through
the F-RAM helpers sends a phantom address byte and the part does not respond.
Use `ads1119Command()` / `ads1119Write()` / `ads1119ReadAfterCommand()`.

The blocking helpers are bounded by `BTS_I2C_TIMEOUT_ITERATIONS` (20000
polls, a few hundred microseconds at 160 MHz). That bound matters because
these helpers are also reached from the DRDY ISRs — an absent or wedged device
must not stall the CPU.

ADS1119 acquisition is **non-blocking**: a DRDY edge only records that a
result is waiting, and `BTS_serviceADS1119()` in the idle loop does the
transfer and the mux advance. A converter that fails
`ADS1119_MAX_CONSECUTIVE_FAILURES` (8) times in a row has its DRDY interrupt
left masked rather than costing a full I2C timeout on every edge.

Temperature is a measured **fourth-order polynomial fit of the amplifier
output**, not a raw thermistor table (`com_cpu2.c:196-223`):

```
degC = 0.4038*V^4 - 0.2199*V^3 - 3.2834*V^2 + 28.366*V + 18.323
```

It bottoms out at +18.3 °C for 0 V in, so a low reading is a cold sensor and
never a missing one, and it saturates near 81 °C because the converter full
scale is the 2.50 V external reference. Both are properties of the analogue
front end, not of the code.

Measured temperatures are written straight into
`registers[BTS_CELLTEMP_IDX(ch)]`, which under v2 resolves into the **runtime
block** at `20 + ch*48`. There is no separate buffer. Note this is the
**measurement**; the configured min/max trip window is a separate pair in the
settings block at `420 + ch*96`, and that pair is what goes into the F-RAM
calibration image.

### The slot runtime state block

The F-RAM also carries per-slot run state, written every 6 s and on each state
transition, and restored at boot:

```
0x0000 - 0x03FF   calibration, 8 channels x 128 B stride
0x0400 - 0x040F   global voltage thresholds
0x0500 - 0x05FF   slot runtime state, 8 slots x 32 B stride
```

`STATE_FRAM_BASE 0x0500`, `STATE_FRAM_STRIDE 32` — fixed and decoupled from
`sizeof`, for the same reason as the calibration block. Each record holds a
header, the running direction and END flag, all six counters, a save counter
and a CRC-32.

Same discipline as everything else here: **never written from an ISR**.
`mirrorCpu1Status()` in the 8 Hz timer sets `stateSavePending[ch]`, and
`BTS_serviceDeferredWork()` writes **one slot per pass**, so the eight stagger
across the 6 s window and a save never holds the I2C controller — and
therefore the host bus — for eight transfers at once.

At boot, an invalid or absent record is the **normal first-boot case**: the
slot starts STOPPED with zeroed counters and nothing is logged. A record that
was saved mid-run brings the counters back and the slot comes up **PAUSED +
RESTORED** with the converter off. A slot never resumes power by itself.

---

## Working with the ESP32 mirror

`esp32-btle-proxy/components/bts_link/include/bts_regs.h` is a hand-maintained
transcription of `registers.h` with **no build coupling**.

> **They have drifted before.** In the v2 reorder the mirror lost
> `eWatchdogRemaining_s` (1220), putting its calibration telemetry at
> 1220-1252 where the C2000 has 1224-1256, `BTS_TOTAL_REGISTERS` 314 against
> `TOTAL_REGISTERS` 315, and `BTS_CAL_WINDOW_COUNT` 14 against a 15-register
> window. `poll_cal_window()` would have misdecoded every telemetry value
> during a bench calibration — shifted by one register, with `temp_c` picking
> up `eCalF28I_A` — and only during one, since that window is read only while
> calibration is live. Normal polling looked healthy throughout. Found and
> fixed 2026-09-20; details in `Docs/api-specification.md` §2.11.
>
> When either file changes, diff them register by register. `registers.h` is
> authoritative.

Every region base, stride and per-slot offset otherwise agrees, as do the
opcode, result-code and status-bit numbering. **But the same identifiers mean
different things in the two files.** See the collision table in `SKILL.md` —
`BTS_STATUS_*` and `BTS_CAL_ST_*` are bit *positions* on the C2000 and bit
*masks* on the ESP32; `BTS_RT_*`, `BTS_SET_*` and the `BTS_CAL_*` offsets are
register *indices* on the C2000 and *byte* offsets on the ESP32; and
`BTS_RT_BASE` / `BTS_SET_BASE` are function-like macros returning an index on
one side and bare byte-address constants on the other. Copying a line between
the files compiles and is silently wrong.

When you add a register, update both files, and check the whole identifier
family rather than the one line you came for.

The proxy's poll task runs a **9-transaction cycle every 250 ms**
(`bts_link.c`) — one 12-register burst per slot plus the unit window. That is
down from 33 under the v1 map, and the reduction is the whole point of the v2
reorder. The calibration window at 1200-1256 is one extra burst, taken **only
while calibration is active** (or once after a calibration command, via
`s_cal_poll_due`), so a feature used on a bench once per unit does not cost
the normal cycle anything.

**Those nine reads are also what feeds the unit's host watchdog** — see the
read hook above. A poll cycle that stops for 30 s pauses every running slot.

---

## Client patterns

C, with the pad byte:

```c
uint8_t addr_buf[2] = { addr >> 8, addr & 0xFF };
uint8_t rx[1 + count * 4];

i2c_master_transmit_receive(dev, addr_buf, 2, rx, 1 + count * 4, timeout);

for (size_t i = 0; i < count; i++) {
    uint32_t u = ((uint32_t)rx[1 + i*4 + 0] << 24) |   /* note the 1 + */
                 ((uint32_t)rx[1 + i*4 + 1] << 16) |
                 ((uint32_t)rx[1 + i*4 + 2] <<  8) |
                 ((uint32_t)rx[1 + i*4 + 3]);
    memcpy(&out[i], &u, 4);                            /* big-endian */
}
```

Python with SMBus:

```python
w = i2c_msg.write(0x50, [addr >> 8, addr & 0xFF])
r = i2c_msg.read(0x50, 1 + count * 4)     # the 1 is the pad
bus.i2c_rdwr(w, r)
data = bytes(r)[1:]                       # drop it
vals = [struct.unpack(">f", data[i*4:(i+1)*4])[0] for i in range(count)]
```

A write needs no pad handling:

```c
uint8_t buf[6];
buf[0] = addr >> 8;
buf[1] = addr & 0xFF;
uint32_t u; memcpy(&u, &value, 4);
buf[2] = u >> 24; buf[3] = u >> 16; buf[4] = u >> 8; buf[5] = u;  /* big-endian */
i2c_master_transmit(dev, buf, 6, timeout);
```

Read the status register back after any write that commands an action — a
mode write is refused outright if the DC input voltage is outside the
charge/discharge restrict window, leaving the channel stopped with no error
reported anywhere.
