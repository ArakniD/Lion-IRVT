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
| Auto-increment past the top (1216) | Stops advancing; a continuing read repeats register 1216 |
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

`serviceI2CTargetWatchdog()` (`com_cpu2.c`, called from the idle loop) watches
for `BUS_BUSY` persisting with no address-match activity and reinitialises.
Note it does a **full `SysCtl_resetPeripheral()`**, not just the module reset
bit: clearing `IRS` releases SCL, but the module comes back still believing it
is an addressed target transmitter (`TARGET_DIR` set) and clamps the clock
again. Only the system-controller reset drops that latched state.

### What a write actually does

`applyHostRegisterWrite()` (`com_cpu2.c:2162-2185`) is the single funnel for
I2C, UART and CAN writes:

1. `registers[regIdx] = value`
2. `notifyCpu1RegisterWrite()` → `IPC_FLAG0` with `ipcMsg` as payload —
   **non-blocking**, skipped if the previous flag is unacknowledged, because
   CPU1 re-reads the affected block from `registers[]` anyway.
3. If the register is `eCalibrationMode` and the value is exactly `2.0f`, set
   `calibrationSavePending` for the idle loop.
4. If the register is `eCalCommand` and the value is non-zero, **self-clear it
   to 0** and clear `eCalStatus` bit 7. The opcode already travelled to CPU1
   in the IPC payload, so clearing the register cannot lose it — and a host
   polling `eCalCommand` sees 0 as soon as the write is accepted.

CPU1 only *decodes* a subset: the control block, the per-channel calibration
block, and `eCalCommand`. Anything else has its flag acked and is silently
discarded. **A new register that CPU1 must act on needs an explicit branch in
`BTS_HandleRegisterWrite()`.**

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
`registers[BTS_CELLTEMP_IDX(ch)]` (992 + ch×4). There is no separate buffer.
Note this block is the **measurement**; the min/max limit pair at 512 + ch×8
is the configured trip window and is what goes into the F-RAM image.

---

## Working with the ESP32 mirror

`esp32-btle-proxy/components/bts_link/include/bts_regs.h` is a hand-maintained
transcription of `registers.h` with **no build coupling**. Every address,
stride, base, count, opcode and result code currently agrees, and
`BTS_TOTAL_REGISTERS` is 305 on both sides.

**But the same identifiers mean different things in the two files.** See the
collision table in `SKILL.md` — `BTS_STATUS_*` and `BTS_CAL_ST_*` are bit
*positions* on the C2000 and bit *masks* on the ESP32; the `BTS_CAL_*` and
`BTS_SENSE_*` offsets are register *indices* on the C2000 and *byte* offsets
on the ESP32; and `BTS_SENSE_BASE` is a function-like macro on one side and a
bare constant on the other. Copying a line between the files compiles and is
silently wrong.

When you add a register, update both files, and check the whole identifier
family rather than the one line you came for.

The proxy's poll task runs a **33-transaction cycle every 250 ms**
(`bts_link.c`). The calibration window at 1036-1088 is polled as one extra
burst, and **only while calibration is active** (or once after a calibration
command, via `s_cal_poll_due`), so a feature used on a bench once per unit
does not cost the normal cycle anything.

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
