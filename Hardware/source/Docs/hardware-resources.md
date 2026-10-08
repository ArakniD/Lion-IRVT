# Hardware Resource Allocation — CPU1 / CPU2

Authoritative allocation reference for the device-global and per-core hardware
resources of the eight-channel battery tester (TI TMS320F28379D, dual C28x).

**This file is the authority.** The skill
(`.claude/skills/bts-c2000-interfaces-skill/`) points here rather than
duplicating these tables; the in-source comment above the trip X-BAR block in
`bts_hal.c:1196-1233` is a convenience copy and must be kept in step.

Every row is traceable to a file and line. PIE group numbers come from
`driverlib/f2837xd/driverlib/inc/hw_ints.h`, which encodes them in the
constant itself: `INT_XINT3 = 0x00780C01` is vector ID `0x78`, group `0x0C`
(12), channel `0x01`.

## Why this file exists

Four defects fixed on hardware on 2026-09-21 had a single root cause: these
allocations were implicit. Two cores were writing the same device-global
register with no table saying who owned it, and an ACK group was reasoned
about from what a handler *touched* rather than from which interrupt *invoked*
it. Each defect below carries a "what it looked like when it broke" note,
because the symptom is what a future reader recognises first.

Four further problems, none previously known, were found while compiling these
tables and are recorded in [§8](#8-known-conflicts-and-latent-bugs). Two are
resource conflicts of exactly the kind this file exists to prevent — a
trip-vector registration that silently collapses to one slot, and a CPU2 timer
claimed twice. Both have since been fixed; the timer conflict has additionally
been dissolved, because the subsystem that was the second claimant no longer
runs on this device at all.

[§7](#7-cla1-allocation) covers CLA1, which is a third processor on this die
and does not appear in any of the PIE, X-BAR or timer tables — its trigger
never reaches a PIE channel and its code and data live in RAM blocks the C28x
gives away at boot.

---

## 1. PIE interrupt allocation

No PIE vector may be claimed by both cores. Each core has its own PIE and its
own vector table, so the same *number* on the two cores is not a conflict —
but a device-global resource feeding that vector (see [§4](#4-input-x-bar))
absolutely is.

### 1.1 CPU1 — real-time control

| Interrupt | PIE grp.ch | Handler | Registered at | Body at | Services |
|---|---|---|---|---|---|
| `INT_ADCA1` | **1.1** | `adcCellVoltageISR` — **registered but masked** | `bts_cpu1.c:1022` | `bts_cpu1.c:2217` | On-chip 12-bit ADC: 8 cell voltages, 8 cell currents, 1 reference. `Interrupt_disable(INT_ADCA1)` in `main()`; the sweep is consumed by CLA1 instead. See [§8.4](#84-the-adc-trigger-rate-is-9967-ksps-one-sweep-per-switching-period) |
| `INT_ADCA2` | **1.2** | — **masked, routed to CLA1** | — | `bts_cla.cla` | ADCA INT2 ← SOC6. `Interrupt_disable(INT_ADCA2)`; the flag drives CLA1 task 1 instead. See [§7](#7-cla1-allocation) |
| `INT_EPWM1_TZ` … `INT_EPWM8_TZ` | **2.1–2.8** | `epwmTripISR` | `bts_hal.c:1978` | `bts_cpu1.c:2272` | ePWM trip zones, all 8 slots. **Was §8.1 — now fixed, registered from an explicit table** |
| `INT_EPWM1` | **3.1** | `epwm1ISR` | `bts_hal.c:1955` | `bts_cpu1.c:1203` | SFRA sweep. Compiled out: `BTS_SFRA_ENABLED (false)`, `bts_user_settings.h:270` |
| `INT_SPIA_RX` | **6.1** | `ISR2` → `BTS_ExAdcRead_ch1_4()` | `bts_hal.c:1941` | `bts_cpu1.c:1188`, `bts_hal.h:240` | SPIA RX FIFO — ADS131M08 #1 frame for slots 1–4 |
| `INT_SPIC_RX` | **6.9** | `ISR4` → `BTS_ExAdcRead_ch5_8()` | `bts_hal.c:1948` | `bts_cpu1.c:1195`, `bts_hal.h:255` | SPIC RX FIFO — ADS131M08 #2 frame for slots 5–8 |
| `INT_XINT3` | **12.1** | `ISR1` → `BTS_runISR_ch1_4()` | `bts_hal.c:1940` | `bts_cpu1.c:1162`, `bts.h:759` | SPI ADC1 DRDY on GPIO25. Runs the slot 1–4 control loops |
| `INT_XINT5` | **12.3** | `ISR3` → `BTS_runISR_ch5_8()` | `bts_hal.c:1947` | `bts_cpu1.c:1175`, `bts.h:816` | SPI ADC2 DRDY on GPIO49. Runs the slot 5–8 control loops |

The `BTS_SPI_DRDY_XINT_ADC1/2` and `BTS_DRDY_ADC1/2` indirections that select
XINT3/XINT5 and `ISR1`/`ISR3` are at `bts_user_settings.h:521-525` and
`542-546`.

> **CPU1 uses all three CPU timers but registers no timer ISR.** Timers 0/1/2
> are the A/B/C background task timebases (1 kHz / 200 Hz / 20 Hz,
> `bts_user_settings.h:333-339`), started in `bts_hal.c:84-129` and **polled**
> through `GET_TASKx_TIMER_OVERFLOW_STATUS` in `A0()`/`B0()`/`C0()`
> (`bts_cpu1.c:1518`, `1537`, `1557`). `CPUTimer_enableInterrupt()` is never
> called on CPU1. Do not "fix" this by registering `INT_TIMER0` — the polled
> design is what keeps the task machine outside interrupt context.

> **`INT_ADCB1` (1.2) is deliberately not registered.** `bts_hal.c:1323-1326`
> arms ADCB's own INT1 flag so `updateInputVoltage()` can spin on it
> (`bts_cpu1.c:1877`), but `Interrupt_enable(INT_ADCB1)` is never called, so
> the PIE never propagates it. This is intentional: the bus-voltage read is a
> bounded poll, not an ISR. See §8.3 for a flaw in that poll.

> **`INT_ADCA2` (1.2) is armed in the ADC and masked in the PIE.** This is not
> an oversight either. `ADC_enableInterrupt(ADCA_BASE, ADC_INT_NUMBER2)`
> (`bts_hal.c:1755`) arms both the `ADCINT2` status flag and its PIE line;
> `Interrupt_disable(INT_ADCA2)` (`:1759`) takes the PIE line straight back
> out. The flag itself is what `CLA1TASKSRCSEL1` samples, so CLA1 task 1 still
> triggers on every sweep while CPU1 never sees a vector. Continuous mode
> (`ADC_enableContinuousMode`, `:1758`) means the flag re-arms without anyone
> clearing it — nothing on the C28x side ever would.

### 1.2 CPU2 — communications and configuration

| Interrupt | PIE grp.ch | Handler | Registered at | Body at | Services |
|---|---|---|---|---|---|
| `INT_XINT1` | **1.4** | `ads1119Drdy1ISR` | `com_cpu2.c:1506` | `com_cpu2.c:1734` | ADS1119 #1 DRDY on GPIO42 (slots 1–4 cell temperature) |
| `INT_XINT2` | **1.5** | `ads1119Drdy2ISR` | `com_cpu2.c:1507` | `com_cpu2.c:1746` | ADS1119 #2 DRDY on GPIO43 (slots 5–8 cell temperature) |
| `INT_I2CA` | **8.1** | `i2cSlaveISR` | `com_cpu2.c:339` | `com_cpu2.c:2883` | I2C target framing (start/stop/AAS/NACK) |
| `INT_I2CA_FIFO` | **8.2** | `i2cSlaveFifoISR` | `com_cpu2.c:340` | `com_cpu2.c:2976` | I2C target data bytes, and the watchdog reload on a host read |
| `INT_SCIA_RX` | **9.1** | `uartRxISR` | `com_cpu2.c:1383` | `com_cpu2.c:3247` | AT console RX. Console build only (`BTS_CONSOLE_ENABLED`) |
| `INT_CANA0` | **9.5** | `canISR` | `com_cpu2.c:1315` | `com_cpu2.c:3140` | CAN telemetry + the host register mailbox |
| `INT_TIMER1` | **direct to CPU INT13** | `timerISR` | `com_cpu2.c:1399` | `com_cpu2.c:2525` | 8 Hz: status mirror, host watchdog tick, state-save marking, CAN round-robin |

`INT_I2CA` and `INT_I2CA_FIFO` are two different vectors and the split is not
optional: with the FIFO enabled the TRM forbids the basic RRDY/XRDY
interrupts, and the FIFO sources arrive only on `INT_I2CA_FIFO`. Mixing them
lets a data byte be parsed as an address byte.

`INT_SCIA_RX` is **9.1**, not 9.3 — 9.3 is SCIB, which this project cannot use
for a console because GPIO18 is SPICLKA and GPIO19 is the ADC1 chip select.

**I2CB has no interrupt.** The F-RAM and ADS1119 controller transfers are
bounded polled loops driven from `BTS_serviceADS1119()` /
`BTS_serviceDeferredWork()` in CPU2's idle loop. `i2cTargetISR` and
`i2cMasterISR` are declared at `com_cpu2.c:255-256` and **never defined or
registered** — dead declarations, not an allocation.

> **`INT_TIMER2` is unclaimed on CPU2, and `ledTimerISR` is registered in no
> build.** It used to hold this table's only direct-INT14 row, driving the
> WS2812B string at 80 Hz. That string now hangs off the ESP32 instead
> (2026-10-02), and `BTS_LED_DRIVER_ENABLED` is `(false)` in **both** arms of
> the `BTS_DEBUG_CONSOLE` switch (`bts_user_settings.h:83`, `:92`), so
> `LEDDriver_init()` — the only caller of
> `Interrupt_register(INT_TIMER2, &ledTimerISR)` (`led_driver.c:76`) — is the
> no-op stub at `led_driver.c:213` everywhere. `ledTimerISR` still exists as a
> stub body (`led_driver.c:216`), but nothing points a vector at it and CPU
> Timer 2 on CPU2 is never started. See [§8.2](#82-cpu-timer-0-on-cpu2-was-double-booked).

---

## 2. ACK group allocation

### The rule

> **The ACK group must match the PIE group of the *interrupt that invoked the
> handler*, not of anything the handler happens to touch.**

`Interrupt_clearACKGroup()` writes `PIEACK`, which re-opens one PIE group for
further interrupts. Acking the wrong group leaves the real group latched and
permanently blocked — the interrupt fires exactly once and then stops, with no
fault, no trap and no log. Meanwhile the group that *was* acked is re-opened
spuriously.

### Table

| Handler | Invoked by | PIE group | Acks | Where |
|---|---|---|---|---|
| `adcCellVoltageISR` *(masked — never entered)* | `INT_ADCA1` | 1 | `INTERRUPT_ACK_GROUP1` | `bts_cpu1.c:2002` |
| `epwmTripISR` | `INT_EPWMx_TZ` | 2 | `INTERRUPT_ACK_GROUP2` | `bts_cpu1.c:2119` |
| `epwm1ISR` | `INT_EPWM1` | 3 | `INTERRUPT_ACK_GROUP3` | `bts_cpu1.c:1104` |
| `BTS_ExAdcRead_ch1_4()` (from `ISR2`) | `INT_SPIA_RX` | 6 | `INTERRUPT_ACK_GROUP6` | `bts_hal.h:220` |
| `BTS_ExAdcRead_ch5_8()` (from `ISR4`) | `INT_SPIC_RX` | 6 | `INTERRUPT_ACK_GROUP6` | `bts_hal.h:235` |
| `BTS_runISR_ch1_4()` (from `ISR1`) | `INT_XINT3` | **12** | `INTERRUPT_ACK_GROUP12` | `bts.h:811` |
| `BTS_runISR_ch5_8()` (from `ISR3`) | `INT_XINT5` | **12** | `INTERRUPT_ACK_GROUP12` | `bts.h:862` |
| `ads1119Drdy1ISR` | `INT_XINT1` | 1 | `INTERRUPT_ACK_GROUP1` | `com_cpu2.c:1741` |
| `ads1119Drdy2ISR` | `INT_XINT2` | 1 | `INTERRUPT_ACK_GROUP1` | `com_cpu2.c:1749` |
| `ledTimerISR` *(stub — registered in no build)* | `INT_TIMER2`, if it ever were | **none — direct INT14** | **must NOT ack** | `led_driver.c:216` |
| `i2cSlaveISR` | `INT_I2CA` | 8 | `INTERRUPT_ACK_GROUP8` | `com_cpu2.c:2968` |
| `i2cSlaveFifoISR` | `INT_I2CA_FIFO` | 8 | `INTERRUPT_ACK_GROUP8` | `com_cpu2.c:3135` |
| `canISR` | `INT_CANA0` | 9 | `INTERRUPT_ACK_GROUP9` | `com_cpu2.c:3187` |
| `uartRxISR` | `INT_SCIA_RX` | 9 | `INTERRUPT_ACK_GROUP9` | `com_cpu2.c:3348` (and early-exit paths `:3274`, `:3306`) |
| `timerISR` | `INT_TIMER1` | **none — direct INT13** | **must NOT ack** | `com_cpu2.c:2554-2557` |

### CPU Timer 1 and 2 bypass the PIE

`INT_TIMER1 = 0x000D0000` and `INT_TIMER2 = 0x000E0000` have vector IDs 13 and
14 and **no group/channel bytes at all**. `Interrupt_enable()` recognises this
and sets `IER` directly instead of touching `PIEIER`
(`driverlib/interrupt.c:323-326`). There is no acknowledge group to clear, and
calling `Interrupt_clearACKGroup()` from such a handler re-opens an unrelated
group. `timerISR` correctly does not ack, and says why at `com_cpu2.c:2554`.

**CPU Timer 0 is different** — it *is* a PIE interrupt at 1.7 and a handler
registered on it does need `INTERRUPT_ACK_GROUP1`. Nothing registers one now:
Timer 0 on CPU2 is the ADS1119 settle dwell's alone, run with its interrupt
disabled (`CPUTimer_disableInterrupt(CPUTIMER0_BASE)` in `initADS1119()`) and
only its counter read. **CPU Timer 2 on CPU2 is now free as well** — the LED
driver that briefly held it is retired (§8.2).

The rule below is quoted from the LED move because the mechanism generalises,
not because that driver still runs. `ledTimerISR` had
`Interrupt_clearACKGroup(INTERRUPT_ACK_GROUP1)` in both its live body and its
stub, correct for Timer 0 and wrong for Timer 2; carrying it across would have
re-opened PIE group 1 — which carries the ADC interrupts — from a handler that
never arrived through it. Both copies were deleted. The driver has since left
the C2000 entirely, so what survives is the rule rather than the example:
**moving a handler between timers changes its acknowledge obligation, and the
compiler will not tell you.**

### What it looked like when it broke

> **Defect 2 — the ACK group did not follow the XINT move.** When CPU1 moved
> its SPI DRDY lines from XINT1/XINT2 to XINT3/XINT5 (see [§4](#4-input-x-bar)), the PIE group
> went from 1 to **12**, but `BTS_runISR_ch1_4()` and `BTS_runISR_ch5_8()`
> still acked `INTERRUPT_ACK_GROUP1`.
>
> Group 12 was left permanently un-acknowledged. DRDY fired **exactly once**
> per core-reset and the entire external-ADC sample ring froze — no control
> loop pass, no `Isense_A`/`Vsense_V` update, no accumulator movement, and no
> error anywhere. The ISRs were correctly registered and correctly enabled;
> they simply were never entered a second time.
>
> The wrong group was chosen by reasoning about what the handler *did* (it
> services the SPI ADCs, and the SPI RX interrupts are in group 6; group 1 was
> inherited from the pre-move code) rather than about what *invoked* it.

---

## 3. XINT allocation

`GPIO_setInterruptPin()` resolves an XINT to a fixed Input X-BAR input — the
mapping is hard-coded in `driverlib/gpio.c:127-147` and cannot be changed.

| XINT | X-BAR input | PIE grp.ch | Owner | GPIO | Purpose |
|---|---|---|---|---|---|
| XINT1 | `INPUT4` | 1.4 | **CPU2** | GPIO42 | ADS1119 #1 DRDY — `com_cpu2.c:1501` |
| XINT2 | `INPUT5` | 1.5 | **CPU2** | GPIO43 | ADS1119 #2 DRDY — `com_cpu2.c:1503` |
| XINT3 | `INPUT6` | 12.1 | **CPU1** | GPIO25 | SPI ADC1 DRDY — `bts_hal.c:424` |
| XINT4 | `INPUT13` | 12.2 | *unused* | — | **See caveat below** |
| XINT5 | `INPUT14` | 12.3 | **CPU1** | GPIO49 | SPI ADC2 DRDY — `bts_hal.c:455` |

> **XINT4 is free as an interrupt, but `INPUT13` is not free as a resource.**
> `INPUT13` is assigned to the channel-5 GPIO trip (`bts_hal.c:1248`,
> currently compiled out). Claiming XINT4 for something new therefore
> forecloses the channel-5 hardware trip, exactly the way XINT5 currently
> forecloses channel 6. If you take XINT4, move the channel-5 trip to one of
> the genuinely free inputs first.

---

## 4. Input X-BAR

> ### The Input X-BAR is device-global, not per-core
>
> There is **one** Input X-BAR for the whole device, at `INPUTXBAR_BASE`
> `0x7900`. `GPIO_setInterruptPin()` is not a per-core GPIO operation: it
> resolves the XINT to an X-BAR input and writes that single shared select
> register (`driverlib/gpio.c`). `GPIO_setInterruptType()` is the same — it
> writes `XINT*CR` in the shared `XINT_BASE` block at `0x7070`.
>
> A driverlib call being available on both cores does not make the hardware
> behind it per-core. **Last writer wins, and CPU2 boots last.**

This device has `INPUT1`..`INPUT14` **only**. `XBAR_O_INPUT14SELECT` is the
last select register; the next register is `INPUTSELECTLOCK`. There is no
`INPUT15`/`INPUT16`, and `BTS_HAL_setupInputXBAR()` rejects anything outside
1..14 (`bts_hal.c:940-942`) rather than writing past the register file.

| Input | Also feeds | Assigned to | GPIO | Set at | State |
|---|---|---|---|---|---|
| `INPUT1` | ePWM **TZ1**, TRIP1 | — | — | — | **Free** — but see the reset-default warning |
| `INPUT2` | ePWM **TZ2**, TRIP2 | — | — | — | **Free** — but see the reset-default warning |
| `INPUT3` | ePWM TZ3, TRIP3 | — | — | — | **Free** |
| `INPUT4` | XINT1, ADC wrappers | ADS1119 #1 DRDY (CPU2) | GPIO42 | `com_cpu2.c:1501` | Active |
| `INPUT5` | XINT2, EXTSYNCIN1 | ADS1119 #2 DRDY (CPU2) | GPIO43 | `com_cpu2.c:1503` | Active |
| `INPUT6` | XINT3, EXTSYNCIN2, TRIP6 | SPI ADC1 DRDY (CPU1) | GPIO25 | `bts_hal.c:424` | Active |
| `INPUT7` | eCAP1 | — | — | — | **Free** |
| `INPUT8` | eCAP2 | — | — | — | **Free** |
| `INPUT9` | eCAP3 | Channel 1 GPIO trip | GPIO28 | `bts_hal.c:1236` | Compiled out |
| `INPUT10` | eCAP4 | Channel 2 GPIO trip | GPIO26 | `bts_hal.c:1239` | Compiled out |
| `INPUT11` | eCAP5 | Channel 3 GPIO trip | GPIO27 | `bts_hal.c:1242` | Compiled out |
| `INPUT12` | eCAP6 | Channel 4 GPIO trip | GPIO34 | `bts_hal.c:1245` | Compiled out |
| `INPUT13` | XINT4 | Channel 5 GPIO trip | GPIO39 | `bts_hal.c:1248` | Compiled out |
| `INPUT14` | XINT5 | **SPI ADC2 DRDY (CPU1)** *and* **channel 6 GPIO trip** | GPIO49 / GPIO44 | `bts_hal.c:455` / `bts_hal.c:1251` | **DOUBLE-BOOKED** |
| *(`INPUT15`)* | — | Channel 7 GPIO trip | GPIO45 | `bts_hal.c:1254` | **Does not exist** — call rejected |
| *(`INPUT16`)* | — | Channel 8 GPIO trip | GPIO46 | `bts_hal.c:1257` | **Does not exist** — call rejected |

**Free inputs: `INPUT1`, `INPUT2`, `INPUT3`, `INPUT7`, `INPUT8`.**

> ### `INPUT14` is double-booked
>
> XINT5 (CPU1's SPI ADC2 DRDY, GPIO49) and the channel-6 GPIO trip (GPIO44)
> both target `INPUT14`. Only one can win. **Today the hardware trips are all
> compiled out (`BTS_TRIP_HW_CH1..8_ENABLED (false)`,
> `bts_user_settings.h:113-120`), so XINT5 owns it and slots 5–8 acquire
> correctly.**
>
> Re-enabling `BTS_TRIP_HW_CH6_ENABLED` without moving one of them will
> silently repoint `INPUT14` at GPIO44 and kill slot 5–8 acquisition — the
> same failure mode as Defect 1, in the opposite direction. Move the channel-6
> trip to `INPUT7` or `INPUT8`, or move XINT5's DRDY to XINT4/`INPUT13` (and
> then relocate the channel-5 trip).

> ### Channels 7 and 8 have no Input X-BAR path at all
>
> Their trips target `INPUT15`/`INPUT16`, which do not exist on this device.
> Both calls are rejected by the bounds check and return silently. Wiring the
> channel 7/8 hardware trips requires taking two of the free inputs. This is a
> design gap, not a bug — but it means "enable all eight hardware trips" is
> not currently expressible: there are 8 trips and only 5 free inputs.

> ### `INPUT1` and `INPUT2` are "free" only in the sense of unassigned
>
> They are hardwired to ePWM **TZ1** and **TZ2** — the one-shot trip inputs
> every slot's trip zone reads. Nothing in this project ever writes
> `INPUT1SELECT`/`INPUT2SELECT`, so both sit at their **reset default of
> GPIO0**, which this board muxes as EPWM1A
> (`BTS_EPWM_H_PIN_CONFIG_EPWM_CH1`, `bts_user_settings.h:409`).
>
> Channel 1's trip zones were therefore watching channel 1's own high-side
> gate drive, and latched OST1+OST2 the instant the converter switched — the
> observed `EPwm1Regs_TZOSTFLG = 0x0003` that re-asserted immediately after
> every TZCLR write. Routing `INPUT1`/`INPUT2` deliberately is a
> **prerequisite** for re-enabling any hardware trip
> (`bts_user_settings.h:74-111`).

### What it looked like when it broke

> **Defect 1 — both cores claimed XINT1/XINT2.** CPU1 pointed them at the
> external SPI ADC DRDY pins (GPIO25/GPIO49); CPU2's `initADS1119()` pointed
> them at the ADS1119 DRDY pins (GPIO42/43). CPU1 configures first and boots
> CPU2 afterwards, so CPU2 overwrote both selects and won.
>
> The SPI ADCs' DRDY lines were disconnected from their interrupts and
> `ISR1`/`ISR3` never fired. It was invisible because acquisition did not
> depend on them: `BTS_HAL_setupInterrupt_Adc1/2()` also registers the SPI RX
> FIFO interrupts (`ISR2`/`ISR4`, PIE 6.1/6.9), which are genuinely per-core
> and were unaffected. Two registered, enabled ISRs were simply dead code, and
> nothing reported it.
>
> **Fixed:** CPU1 now owns XINT3 (`INPUT6`) and XINT5 (`INPUT14`); CPU2 keeps
> XINT1/XINT2. The rationale is recorded at `bts_user_settings.h:513-520`.

---

## 5. ePWM X-BAR, CMPSS and ePWM module allocation

**Status: the hardware over-current trips are live.** All eight are enabled
and routed; see §5.1 for how a comparator actually reaches a trip zone, which
is not the obvious path.

**Seen on hardware, 2026-10-08.** The CMPSS1 low comparator latched
(`TZOSTFLG` 0x0040, DCAEVT1) on every discharge enable while
the deadband took its two delays from two independent sources (`DBCTL`
IN_MODE 2). Both now come from EPWMA (IN_MODE 0), and 1 A charge, 1 A
discharge and 100 mA discharge all start and run with no latch. So the trip
path is proven end to end - comparator, ePWM X-BAR, Digital Compare, one-shot
- but only by a fault. **The ±9.5 A level itself has not been tested against
a real over-current.**

The CMPSS comparators do **not** go through the Input X-BAR. They reach the
ePWM trip zones through the separate **ePWM X-BAR** at `EPWMXBAR_BASE`
`0x7A00`. Each `TRIPn` output selects among 16 muxes and **can enable several
at once, OR-ing them onto that one output** — which is what makes a grouped
trip possible with no software in the path. `CMPSSn` occupies mux `(n-1)*2`.

| Slot | CMPSS | ePWM X-BAR trip | Mux |
|---|---|---|---|
| 1 | `CMPSS1` | `XBAR_TRIP4` | `MUX00` |
| 2 | `CMPSS2` | `XBAR_TRIP5` | `MUX02` |
| 3 | `CMPSS3` | `XBAR_TRIP7` | `MUX04` |
| 4 | `CMPSS4` | `XBAR_TRIP8` | `MUX06` |
| 5 | `CMPSS5` | `XBAR_TRIP9` | `MUX08` |
| 6 | `CMPSS6` | `XBAR_TRIP10` | `MUX10` |
| 7 | `CMPSS7` | `XBAR_TRIP11` | `MUX12` |
| 8 | `CMPSS8` | `XBAR_TRIP12` | `MUX14` |

The tables live at the top of `BTS_HAL_setupTripRouting()`'s block in
`bts_hal.c`; the routing itself is built there, and the trip zones are
configured in `BTS_HAL_setupEPWMTripZone()`.

> `XBAR_TRIP6` is skipped: `INPUT6` feeds ePWM TRIP6 directly, and `INPUT6` is
> XINT3's input (CPU1's SPI ADC1 DRDY). Do not route a CMPSS to TRIP6.

### 5.1 A comparator reaches the trip zone through Digital Compare, not TZ1/TZ2

This is the part that is easy to get wrong, and getting it wrong is what
produced the `TZOSTFLG = 0x0003` that re-asserted after every `TZCLR` write.

The one-shot inputs `OSHT1`/`OSHT2` read **TZ1/TZ2**, which are hardwired to
Input X-BAR `INPUT1`/`INPUT2` — *not* to the ePWM X-BAR where the comparators
arrive. Nothing in this project writes `INPUT1SELECT`/`INPUT2SELECT`, so both
sat at their reset default of **GPIO0**, which this board muxes as EPWM1A.
Channel 1's trip zones were watching channel 1's own high-side gate drive and
latched the instant the converter switched.

The ePWM X-BAR outputs `TRIP4..TRIP12` reach a trip zone only through the
**Digital Compare submodule**:

```c
EPWM_selectDigitalCompareTripInput(base, EPWM_DC_TRIP_TRIPINn, EPWM_DC_TYPE_DCAH);
EPWM_setTripZoneDigitalCompareEventCondition(base, EPWM_TZ_DC_OUTPUT_A1,
                                             EPWM_TZ_EVENT_DCXH_HIGH);
EPWM_enableTripZoneSignals(base, EPWM_TZ_SIGNAL_DCAEVT1);
```

`DCAEVT1` is a **one-shot**, so the latching behaviour is identical to what
`OSHT1` would have given; only the route differs. `INPUT1`/`INPUT2` are left
alone.

Two consequences worth knowing:

- **`DCAEVT1` has its own action register.** It does not follow `TZA`/`TZB`, so
  `EPWM_setTripZoneAction(base, EPWM_TZ_ACTION_EVENT_DCAEVT1, ...)` is required
  or the flag latches and the pins do not move.
- **The ISR must read `EPWM_TZ_FLAG_DCAEVT1`.** A handler testing only
  `EPWM_TZ_FLAG_OST` sees nothing, forever.

### 5.2 Trip levels, and the zero that was wrong

The sense chain is an instrumentation amplifier with a **1.25 V common mode**:
0 V is −10 A, 1.25 V is 0 A, 2.50 V is +10 A. The CMPSS DAC shares the ADC's
3.019 V reference (the REF5030 rail, measured from A0 = 1696 counts).

The previous threshold maths assumed 0 A at DAC **mid-scale** and derived
counts-per-amp from `2048 / 10 A`. That put +8 A at 3686 counts = 2.718 V,
which the sense chain only reaches at **+11.7 A** — past its own full scale.
**The high-side trip was unreachable**, and the low side asked for −7.6 A
rather than −8 A. The error was invisible because every trip was disabled, so
the thresholds were computed, written to the DAC, and never consulted.

Corrected to `count(I) = (1.25 + I × 0.125) / 3.019 × 4095`:

| | Level | Acts within | Counts |
|---|---|---|---|
| Software, `BTS_tripEpwm()` | **±8.0 A** | a control period (~150 µs) | — |
| Hardware, CMPSS | **±9.5 A** | a switching cycle (<1 µs) | 3306 / 84 |
| Sense chain full scale | ±10.0 A | — | 3391 / 0 |

The two are **layered, not duplicated**. In normal operation the software trip
catches an over-current first and the comparator never fires; the comparator
exists for what a control period is too slow for — a genuine short. Setting
them equal would let the hardware win every race and leave the software path,
and its diagnostics, untested.

### 5.3 Grouped trips: one X-BAR output per group

Slots in a group share one load and one control loop, so an over-current on
any member makes every member unsafe. `BTS_HAL_setupTripRouting()` gives each
group **one** trip output carrying the OR of that group's comparators, and
points every ePWM in the group at it — so all of them trip in the same
switching cycle, in hardware:

```
ungrouped   TRIP4 = CMPSS1            -> ePWM1
pairs       TRIP4 = CMPSS1 | CMPSS2   -> ePWM1, ePWM2
quads       TRIP4 = CMPSS1..CMPSS4    -> ePWM1..ePWM4
octet       TRIP4 = CMPSS1..CMPSS8    -> ePWM1..ePWM8
```

The group leader's `TRIPn` is the one used, matching `BTS_GROUP_LEADER()`.

**A partial group is not a group.** If the ENABLE strap masks off any member,
the *whole* group is left unrouted and unarmed. A disabled slot's sense chain
is unpowered and floats near 0 V — which reads as −10 A and would trip the
group the instant it armed — and a group missing a member cannot safely run
anyway, so arming the survivors would suggest it was usable. Masking slot 8
therefore disables the pair 7–8, the quad 5–8 and the octet 1–8, while leaving
the lower groups fully protected.

> **Ordering contract.** `BTS_HAL_setupTripRouting()` must run **after**
> `BTS_HAL_setupGPIO()` has latched the straps. It cannot live in
> `BTS_HAL_setupTripSystem()` with the rest of the trip plumbing, because that
> runs from `BTS_HAL_setupDevice()` before the strap pins are even inputs.
> It is called from `main()` alongside `BTS_initSlotGrouping()`.

### 5.4 The trips are armed on first run, not at boot

`BTS_HAL_setupTripRouting()` configures every trip zone and leaves them all
**disarmed**. `serviceTripArming()` (`bts_cpu1.c`, called at 10 Hz from `C1()`)
arms them once any slot's `enable_logic` is set and disarms when the last one
clears.

The reason is the sense chain again: before its supply has settled it outputs
near 0 V, which on a 1.25 V-centred chain means −10 A. Arming during boot
latches an over-current on every slot before the board has done anything — and
because `DCAEVT1` is a one-shot it *stays* latched, with a naive clear simply
re-latching while the source is still asserted. The unit would come up unable
to start any slot.

Nothing is given up by waiting. An unarmed trip only matters while current is
flowing, and no current flows until a slot runs.

### 5.5 Group semantics: what the leader owns

Only a group **leader** has a control loop; followers mirror its duty.
`modeCallback()` rejects a mode write to a follower or to a strap-disabled
slot outright, so a host must address the leader.

What the leader's registers mean for the group:

| Quantity | Scope | Why |
|---|---|---|
| Mode, direction, run/stop, pause/resume | **Shared** — the leader's write carries to every member | The group shares one load; members cannot disagree about which way it is driving |
| `V_MIN` / `V_MAX` | **Shared, undivided** | Members are in **parallel** — they all sit at the same voltage |
| `I_MIN` / `I_MAX` | **Shared, DIVIDED** across members | The leader's register is the group **total**; each slot carries its share |
| mAh / mWh / seconds | **Per slot, undivided** | Each slot measures the current it actually carried |

So a group of four set to 6 A runs **1.5 A per slot**, and a host reading the
group's delivered charge **sums its members' accumulators**. The division is
by the count of *enabled* members (`btsGroupMembers[]`), not the nominal group
size, so a part-populated group still delivers the total that was asked for.

The leader's own reference is divided once, in `modeCallback()`; followers copy
that already-divided value rather than dividing again.

> Before this, the current was copied to followers **undivided** — a group of
> eight set to 5 A would have drawn 40 A from the bus.

### ePWM module allocation

| Module | Purpose | Configured at |
|---|---|---|
| `EPWM1`–`EPWM8` | Slot 1–8 synchronous buck/boost, HRPWM on both edges | `bts_hal.c:975` via `bts_cpu1.c:949-956` |
| `EPWM1` *(also)* | **SOCA trigger for the on-chip ADC**, prescale /1 — one sweep per switching period | `bts_hal.c:1818-1828` via `bts_cpu1.c:923` — see [§8.4](#84-the-adc-trigger-rate-is-9967-ksps-one-sweep-per-switching-period) |
| `EPWM11` | ADS131M08 #1 master clock, GPIO20 | `bts_hal.c:763` via `bts_cpu1.c:958` |
| `EPWM12` | ADS131M08 #2 master clock, GPIO22 | `bts_hal.c:763` via `bts_cpu1.c:959` |
| `EPWM9`, `EPWM10` | — | **Free** |

`EPWM1` is also the sync-chain master for group interleaving; every other
module forwards its pulse (`BTS_HAL_setupGroupPhase()`, `bts_hal.c:1379`).

---

## 6. ADC base addresses

> ### `ADC_readResult()` takes the RESULT base, not the control base
>
> Two entirely separate address blocks, and passing the wrong one **compiles,
> links and runs**. `ADC_readResult()` only `ASSERT`s the base
> (`driverlib/adc.h:906-923`), and asserts are compiled out in a release build.

| ADC | Control base (`ADCx_BASE`) | Result base (`ADCxRESULT_BASE`) |
|---|---|---|
| A | `0x7400` | **`0x0B00`** |
| B | `0x7480` | **`0x0B20`** |
| C | `0x7500` | **`0x0B40`** |
| D | `0x7580` | **`0x0B60`** |

Rule of thumb: **every API except `ADC_readResult()` takes `ADCx_BASE`.**
`ADC_setupSOC`, `ADC_enableInterrupt`, `ADC_clearInterruptStatus`,
`ADC_getInterruptStatus`, `ADC_forceSOC`, `ADC_setPrescaler`, `ADC_setMode`,
`ADC_enableConverter` — all control base. Only the result read differs.

### SOC allocation

All `ADC_TRIGGER_EPWM1_SOCA` unless noted. Configured `bts_hal.c:1680-1704`.

| | SOC0 | SOC1 | SOC2 | SOC3 | SOC4 | SOC5 | SOC6 |
|---|---|---|---|---|---|---|---|
| **ADCA** | IN3 — ch1 V | IN5 — ch3 V | IN15 — ch4 V | IN2 — ch1 I | IN4 — ch3 I | IN14 — ch4 I | IN0 — **reference** |
| **ADCB** | IN3 — ch2 V | IN0 — **bus V**, SW-only | IN1 — SW-only | IN2 — ch2 I | | | |
| **ADCC** | IN3 — ch6 V | IN5 — ch8 V | IN2 — ch6 I | IN4 — ch8 I | | | |
| **ADCD** | IN1 — ch5 V | IN3 — ch7 V | IN0 — ch5 I | IN2 — ch7 I | | | |

Seventeen SOCs in total, all on the one `EPWM1` SOCA event, converting in
parallel across the four converters. **SOC6 is last in ADCA's round robin**,
which is what makes it the right interrupt source for anything that wants the
whole sweep — including the A0 reference every current reading is differential
about.

ADC interrupt sources:

| Flag | Source SOC | PIE | Used by |
|---|---|---|---|
| **ADCA INT1** | SOC0 | 1.1, **masked** | `adcCellVoltageISR` (`bts_hal.c:1709`) — registered, never entered. Continuous mode, so the converter never stalls on an unacknowledged flag |
| **ADCA INT2** | **SOC6** | 1.2, **masked** | **CLA1 task 1** via `CLA1TASKSRCSEL1` (`bts_hal.c:1755-1759`) — see [§7](#7-cla1-allocation) |
| **ADCB INT1** | SOC2 | not enabled | polled by `updateInputVoltage()` (`bts_hal.c:1728`) — see §1.1 and §8.3 |

`ADC_setInterruptPulseMode(ADCA_BASE, ADC_PULSE_END_OF_CONV)` (`bts_hal.c:1781`)
applies to **ADCA only** and is a requirement of the CLA path, not a
preference: in the default `ADC_PULSE_END_OF_ACQ_WIN` mode the flag asserts
when the acquisition window closes, which is *before* the result register is
written — the CLA would latch the previous sweep. TI's own `cla_adc_fir32`
example makes the same change for the same reason. The side effect on ADCA
INT1 is that it now sets ~106 ns later, at end-of-conversion rather than
end-of-acquisition — which would be strictly safer for `adcCellVoltageISR`
if that ISR still ran.

### What it looked like when it broke

> **Defect 4 — `ADC_readResult()` called with the control base.** Every slot
> read back ADCCTL1/ADCCTL2 as if they were conversions. The symptom was a
> **constant 8320 (0x2080)** on every channel's cell voltage and current —
> identical across all eight slots, perfectly stable, and unmoved by anything
> connected to the hardware. A shorted slot still reported a healthy voltage.
>
> A constant that is the same on every channel and never moves is the
> signature: real ADC noise is never that quiet. **Fixed** in
> `adcCellVoltageISR` (`bts_cpu1.c:2217`, rationale immediately above it) and
> in the bus-voltage read. `bts_cla.cla` carries the same warning at its SOC
> map, because the CLA reads the identical set of registers and would fail the
> identical way.

---

## 7. CLA1 allocation

CLA1 is a third processor on this die, independent of both C28x cores. It does
not appear in the PIE tables, the X-BAR tables or the timer tables, and that is
precisely why it needs its own section: its trigger never reaches a PIE
channel, and the RAM it executes from is taken away from CPU1 at boot and never
given back.

**CPU1 owns CLA1. CPU2's CLA is deliberately untouched** — it is reserved for
the ADS131M08 current control loop in a later phase. `bts_cla.cla` is wrapped
in `#ifdef CPU1` for exactly this reason: the project compiles every root-level
source under both configurations.

### 7.1 What CLA1 does here

One task. `Cla1Task1` reads all seventeen ADC results, subtracts the A0
reference from each current, and folds both sets through **two** single-pole
IIRs in float32: a 20 Hz pair for telemetry and a fast pair
(`alpha = 2/(N+1)`, N = 8) that carries the protection path — the reverse
polarity check, group supervision and `BTS_cellVoltageAsCtrl16b()`. It
replaced `adcCellVoltageISR`'s 8-deep ring, which no longer runs. The
over-current trips read neither pair; they run off the ADS131M08 and the
CMPSS comparators. The rate chain, the filter
mathematics and the C28x-side consumers are in
[`data-flow.md` §2](data-flow.md#2-measurement-path--silicon-to-phone); this
section is the resource side.

Tasks 2–8 are defined as empty bodies and are **not** enabled in `MIER`. They
exist because `BTS_initCla()` maps all eight `MVECT` registers — an unmapped
vector left at its reset value sends the CLA off to fetch from wherever that
happens to point, if it is ever triggered.

### 7.2 The trigger does not go through the PIE

```
EPWM1 SOCA ──► ADCA SOC6 conversion ──► ADCINT2 flag ──► CLA1TASKSRCSEL1 ──► task 1
                                              │
                                              └──► PIE 1.2  ✗ masked
```

`CLA_setTriggerSource(CLA_TASK_1, CLA_TRIGGER_ADCA2)` (`bts_cpu1.c:893`) writes
the task-1 field of `CLA1TASKSRCSEL1`. That register samples the peripheral's
interrupt flag directly; the PIE is not in the path. So `Interrupt_disable(INT_ADCA2)`
costs nothing and buys the guarantee that CPU1 can never be dragged into a
vector for an interrupt it has no handler for.

**SOC6 is the trigger, not SOC0.** SOC6 is last in ADCA's round robin, so when
its flag sets, every result register in the sweep holds this period's
conversion. Triggering off SOC0 — which is what ADCA INT1 uses — would hand the
CLA sixteen values from the *previous* period and one from this one.

### 7.3 Memory: LS4 and LS5 belong to the CLA

The CLA's address bus is **16 bits wide** (TRM 6.7.2). It can only reach the
LSx RAM blocks and the ADC result window at `0x0B00-0x0B6F`. RAMGS, RAMM and
flash are all out of range — which is why every shared object has to be placed
by hand, and why `ADC_readResult()`'s RESULT base (§6) is not merely the
correct API but the only reachable one.

| Block | Origin | Length | Owner | Contents |
|---|---|---|---|---|
| `RAMLS4` | `0x00A000` | `0x800` | **CLA program** | `Cla1Prog`, `0x1A0` words used. Loads from `FLASHK`, runs from RAM |
| `RAMLS5` | `0x00A800` | `0x800` | **CLA data** | `CLADataLS5` `0x22` words at `0x00A940`, `.scratchpad` `0x28` words at `0x00A900`, `.const_cla` |

Both blocks are handed over in `BTS_initCla()` (`bts_cpu1.c:843`):

```c
MemCfg_setLSRAMControllerSel(MEMCFG_SECT_LS4, MEMCFG_LSRAMCONTROLLER_CPU_CLA1);
MemCfg_setCLAMemType(MEMCFG_SECT_LS4, MEMCFG_CLA_MEM_PROGRAM);   // LS5: ..._MEM_DATA
```

**Controller select before memory type, always** — `LSxMSEL` before
`LSxCLAPGM`. That is the order TI's own `cla_asin_cpu01.c` uses. Declaring a
block CLA *program* while the C28x still
masters it can abort the CLA's first instruction fetch, and the failure looks
like a CLA that simply never starts — no fault, no flag, `BTS_claRunCount`
stuck at zero.

**CPU2 was moved out of LS4/LS5 to make room.** CPU2's `.bss` used to sit in
`RAMLS4_5`; it is now on `RAMGS12`/`RAMGS13` (`2837xD_RAM_lnk_cpu2.cmd`). The
LSx blocks are per-core, so this was not strictly a collision — but leaving
CPU2's allocation there would have made the next person to read the two linker
files believe it was.

### 7.4 Every shared object is defined in C, not in the `.cla`

`bts_cla_data.c` defines the four shared objects and `bts_cla_shared.h` only
declares them:

```c
#pragma DATA_SECTION(BTS_claCellVoltageFilt, "CLADataLS5")
volatile float32_t BTS_claCellVoltageFilt[BTS_CLA_NUM_CH];
```

This is a toolchain constraint, quoted verbatim from TI in the header: the CLA
compiler cannot export a symbol the C28x linker resolves. Defining the array in
`bts_cla.cla` links — and gives the two processors two different arrays.

`bts_cla_data.c` also carries a compile-time guard:

```c
#if (BTS_CLA_NUM_CH != NUM_CHANNELS)
#error "BTS_CLA_NUM_CH in bts_cla_shared.h must match NUM_CHANNELS"
#endif
```

### 7.5 Initialisation order

`BTS_initCla()` is called from `main()` at `bts_cpu1.c:929`, and its position is
load-bearing at both ends:

| Step | Where | Why it must be there |
|---|---|---|
| `BTS_HAL_setupADC()` | `bts_cpu1.c:920` | arms ADCA INT2; the CLA's trigger source must exist before it is selected |
| `BTS_HAL_setupAdcTrigger(EPWM1_BASE)` | `:923` | starts EPWM1 SOCA |
| **`BTS_initCla()`** | **`:929`** | after the ADC is configured, and after `BTS_HAL_setupDevice()` has copied `Cla1Prog`/`.const_cla` out of flash (`device.c:94`, `:101`) |
| `BTS_HAL_setupSyncBuckPwm(...)` | `:949` | rewrites `TBPRD`; does **not** touch the SOC registers, so the trigger survives |

`BTS_initCla()` itself does five things, in this order: hand LS4 to the CLA and
type it program, hand LS5 to the CLA and type it data, map all eight `MVECT`
registers, `CLA_enableIACK()` (so the filter can be forced from the bench
without the ADC running), and `CLA_enableTasks(CLA1_BASE, CLA_TASKFLAG_1)`.
The trigger select is last.

The copy out of flash is **not** here — `Device_init()` does it
(`device/device.c:94`, `:101`) long before `main()` reaches this point. That is
what the note at `bts_cpu1.c:835` is guarding: `BTS_initCla()` must run after
`BTS_HAL_setupDevice()`, or it maps `MVECT` entries pointing at an `RAMLS4`
that has not been populated yet.

### 7.6 Source index

| Item | File |
|---|---|
| Task body, SOC→channel map, filter | `bts_cla.cla` |
| Shared declarations, alpha, rate derivation | `bts_cla_shared.h` |
| Shared definitions, `CLADataLS5` pragmas, channel-count guard | `bts_cla_data.c` |
| LS4/LS5 handover, `MVECT`, `MIER`, trigger select | `bts_cpu1.c:843-910` |
| `Cla1Prog` / `CLADataLS5` / `.scratchpad` placement | `2837xD_RAM_lnk_cpu1.cmd` |
| ADCA INT2 arm + PIE mask, `ADC_PULSE_END_OF_CONV` | `bts_hal.c:1746-1781` |
| C28x-side scaling and liveness fallback | `bts_cpu1.c:1630` |
| CPU2 `.bss` moved off `RAMLS4_5` | `2837xD_RAM_lnk_cpu2.cmd` |

---

## 8. Known conflicts and latent bugs

### 8.1 All eight trip-zone ISRs used to register into the ePWM1 vector

**Status: FIXED. Was a live defect, masked by a build flag. Found 2026-09-21
while compiling these tables; the fix is now in `bts_hal.c:1974-1980`. Kept
here because the mechanism generalises to every `INT_*` constant on this
device.**

The code used to read:

```c
for (uint16_t i = 1; i <= 8; i++) {
    Interrupt_register(INT_EPWM1_TZ + (i - 1), &epwmTripISR);
    Interrupt_enable(INT_EPWM1_TZ + (i - 1));
}
```

The `INT_*` constants pack **vector ID in bits 31:16** and **group/channel in
bits 15:0**. `INT_EPWM1_TZ` is `0x00280201`; `INT_EPWM2_TZ` is `0x00290202`.
The stride is `0x00010001`, not `1`.

Adding 1 increments only the channel byte, so:

| `i` | `INT_EPWM1_TZ + (i-1)` | Vector ID written | Correct vector ID |
|---|---|---|---|
| 1 | `0x00280201` | `0x28` | `0x28` |
| 2 | `0x00280202` | `0x28` | `0x29` |
| 3 | `0x00280203` | `0x28` | `0x2A` |
| … | … | `0x28` | … |
| 8 | `0x00280208` | `0x28` | `0x2F` |

`Interrupt_register()` derives its target slot **only** from bits 31:16
(`driverlib/interrupt.h:250-251`), so all eight iterations write `epwmTripISR`
into the **ePWM1 trip-zone slot**, eight times over. Vectors 2.2–2.8 keep
`Interrupt_defaultHandler` — `ESTOP0` followed by an infinite loop
(`driverlib/interrupt.c:176-206`).

`Interrupt_enable()` reads group from bits 15:8 and channel from bits 7:0, so
it is **correct**: `PIEIER2` bits 0–7 all get enabled. The enable is right and
the registration is wrong — the worst combination.

**Why it has not bitten yet:** `BTS_HAL_setupEPWMTripZone()` calls
`EPWM_disableTripZoneInterrupt()` on every slot whose
`BTS_TRIP_HW_CHn_ENABLED` is false (`bts_hal.c:1105-1107`), and all eight are
false. Nothing can currently raise 2.2–2.8.

**What will happen when it does:** re-enable any hardware trip on channels 2–8
and the first trip on that slot drops CPU1 into the default handler's infinite
loop with PIE group 2 never acknowledged. That is Defect 3 all over again, in
group 2 instead of group 1: the background tasks stop, the register file
freezes with stale values, and the unit looks alive while all supervision is
dead — *with the converter in a tripped state it can no longer report*.

**Fix, now applied** (`bts_hal.c:1974-1980`) — an explicit table, which is
immune to the same mistake rather than merely correct:

```c
static const uint32_t tzInts[8] = {
    INT_EPWM1_TZ, INT_EPWM2_TZ, INT_EPWM3_TZ, INT_EPWM4_TZ,
    INT_EPWM5_TZ, INT_EPWM6_TZ, INT_EPWM7_TZ, INT_EPWM8_TZ,
};
for (uint16_t i = 0; i < 8U; i++) {
    Interrupt_register(tzInts[i], &epwmTripISR);
    Interrupt_enable(tzInts[i]);
}
```

The general rule survives the fix: **never do arithmetic on an `INT_*`
constant.** The vector ID and the group/channel live in different halves of the
same word and `Interrupt_register()` and `Interrupt_enable()` read different
halves, so an off-by-stride error corrupts one and not the other — which is why
this presented as eight enabled trips pointing at one handler rather than as
anything failing outright.

### 8.2 CPU Timer 0 on CPU2 was double-booked

**Status: FIXED, and since superseded — kept as a record.** It was latent
while the console build shipped and live — LEDs dead — in any production
build. Not previously known at the time. The LED driver has since left the
C2000 altogether; see [the 2026-10-02 update](#update-2026-10-02--the-led-driver-left-the-c2000-and-none-of-this-could-ever-have-lit-the-string)
at the end of this section, which is the part a reader debugging the LEDs
today needs.

Two subsystems claimed CPU2's Timer 0 with incompatible configurations:

| Claimant | Configuration | Guard |
|---|---|---|
| WS2812B LED driver | period `SYSCLK/80` (80 Hz), **interrupt enabled**, `INT_TIMER0` registered | `#if BTS_LED_DRIVER_ENABLED == true` |
| ADS1119 settle dwell | period `0xFFFFFFFF` free-running, **interrupt disabled**, counter read only | **none — unconditional** |

In `main()`, `LEDDriver_init()` runs before `initADS1119()`. **The ADS1119
claim ran second and won**: it called
`CPUTimer_disableInterrupt(CPUTIMER0_BASE)` and reprogrammed the period, so
the registered, enabled `ledTimerISR` never fired again.

With `BTS_DEBUG_CONSOLE` `true` this was invisible — `BTS_LED_DRIVER_ENABLED`
is then `false` and `LEDDriver_init()` is a no-op stub. In a production build
the LED refresh tick stopped moments after boot. At the time that was read as
the string going dark *having briefly worked* — it had not, and never did; see
the 2026-10-02 update below. **A frozen LED showing "running" for a slot that
has since tripped is actively misleading**, which is what made this worth
fixing rather than documenting.

The comment in `initADS1119()` showed the author knew the timer was shared
("CPU timer 0 is otherwise only started by the WS2812B driver, which is
compiled out in a console build") — but the code below it was never guarded by
that condition.

**Fixed** by moving the LED *tick* to **CPU Timer 2**, not by guarding the
ADS1119 setup. The ADS1119 dwell genuinely needs a free-running counter on
Timer 0 in both build flavours, and Timer 2 was the only timer with no other
claimant on this core.

Timer 2 is free **on CPU2 only**, and the distinction matters:

| Core | Timer 0 | Timer 1 | Timer 2 |
|---|---|---|---|
| CPU1 | Task A (`TASKA_CPUTIMER_BASE`) | Task B, and borrowed by `BTS_HAL_measureSysclkKHz()` | Task C (`TASKC_CPUTIMER_BASE`), also borrowed by the clock measurement |
| CPU2 | ADS1119 settle dwell | `timerISR` at 8 Hz | **Free** — was the WS2812B refresh; see the update below |

CPU2 runs neither the A/B/C task chain nor `BTS_HAL_setupDevice()`, so it
never calls the clock measurement. **Do not make the same move on CPU1** —
Timer 2 is the Task C timebase there.

One consequence, covered in §1.2: Timer 2 reaches the CPU directly on INT14
and does not pass through the PIE, so `ledTimerISR` must **not** call
`Interrupt_clearACKGroup()`. Both the live handler and its no-op stub had that
call for Timer 0 and both lost it.

#### Update 2026-10-02 — the LED driver left the C2000, and none of this could ever have lit the string

**Everything above is still true of the code as it was, and the Timer 0 /
ADS1119 facts are still true today.** What has changed is that the WS2812B
string is no longer driven from this device at all, so the timer contention
this section describes no longer exists in either direction:

- `BTS_LED_DRIVER_ENABLED` is `(false)` in **both** arms of the
  `BTS_DEBUG_CONSOLE` switch (`bts_user_settings.h:83`, `:92`).
  `LEDDriver_init()`, `LEDDriver_update()` and `LEDDriver_due()` are the no-op
  stubs at `led_driver.c:213-215` in every build.
- `Interrupt_register(INT_TIMER2, &ledTimerISR)` (`led_driver.c:76`) sits
  inside the compiled-out arm, so **Timer 2 on CPU2 is free again** and
  `INT_TIMER2` is claimed by nothing.
- `led_driver.c` and `led_driver.h` remain in the project and still compile.
  The idle-loop call `if (LEDDriver_due()) { LEDDriver_update(); }` at the
  bottom of `main()` in `com_cpu2.c` still exists and is now a no-op.
- Timer 0 remains the ADS1119 dwell's alone — the four-line claim in
  `initADS1119()` (`com_cpu2.c`, `CPUTimer_setPeriod`/`setPreScaler`/
  `disableInterrupt`/`startTimer` on `CPUTIMER0_BASE`) is unchanged.
- GPIO29 is still muxed to `GPIO_29_SCITXDA` unconditionally in
  `BTS_HAL_setupCpu2Pins()` (`bts_hal.c:1394`) and is simply **idle** in a
  production build.

**And the part that matters most: fixing this timer bug could never have lit
the string.** `LEDDriver_update()` clocked raw colour bytes out of SCIA at
800 kbaud, but a WS2812B decodes pulse *widths* — 400 ns high is a 0, 800 ns
high is a 1, in a 1250 ns slot — and a UART cannot produce them. It forces a
LOW start bit before every byte and holds each data bit for a full bit time.
The strip saw framing noise and latched nothing. **No pixel ever lit from this
core**, in any build, at any point in the project's history.

So the timer double-booking above was a real bug and worth fixing — as were
the LED-ISR starvation of CPU2 and the SCIA stranding by an unstrapped MODE
strap — but none of the three was ever the reason the LEDs were dark. Each one
would have been uncovered only to reveal the next, with the UART problem
waiting underneath all of them. This is the section's real lesson: a chain of
genuine defects in a subsystem is not evidence that the subsystem can work.

**It could not be fixed in place.** Driving a WS2812B needs a peripheral that
emits a free-running bit pattern — on this device, SPI. GPIO29, the wire that
physically exists, has **no SPI mux option** (its choices are GPIO, SCITXDA,
EM1SDCKE, OUTPUTXBAR6, EQEP3B, SD2_C3), and both usable SPI ports (SPIA, SPIC)
are held by the ADS131M08 pair (§1.1). The Output X-BAR has no ePWM source. An
eCAP APWM reached through OUTPUTXBAR6 would have worked electrically but needs
192 software duty updates per refresh — reintroducing exactly the ISR
starvation that had just been fixed.

The driver therefore moved to the **ESP32 proxy**, which has a free SPI host
and a free pin: SPI3 (VSPI) MOSI on its GPIO13, four SPI bits per WS2812B bit
at 2.5 MHz, 96 bytes per frame in one DMA transfer from a FreeRTOS task. That
is off-device and so outside this file's scope; it is documented in
[`esp32-btle-proxy/components/led_strip/include/led_strip.h`](../esp32-btle-proxy/components/led_strip/include/led_strip.h)
and in
[`supervision-and-state-design.md` §2.5.1](supervision-and-state-design.md#251-slot-indication--the-ws2812b-string).
It lit on 2026-10-02, for the first time in the project.

The move is not free, and two costs are worth stating plainly.

**The colours are now one poll stale.** A C2000-resident driver read
`registers[]` directly. The ESP32 driver colours from the snapshot its
existing I2C poll fills at a 250 ms interval, so a slot changing state can
take up to ~250 ms longer to reach the strip than it used to. For an
indicator that is comfortably acceptable — but it means the LEDs must never
be used to time anything, and a slot that trips and is read back within one
poll window can legitimately show its previous colour.

**And the strip now depends on the proxy**, which is the heavier of the two:

> **One hazard moved rather than went away.** §8.2 called a frozen LED showing
> "running" for a slot that has since tripped *actively misleading*, and that
> is now the ESP32's failure mode: if the proxy is unplugged, crashes or is
> held in reset it sends no frames, and the WS2812B latches hold their last
> colour **indefinitely**. The driver's amber-unison link-down state covers
> only the case where the ESP32 is alive and the I2C link is down — it cannot
> cover the ESP32 itself being dead. The indicators are no longer evidence
> about a slot unless something independently confirms the proxy is running.

### 8.2.1 SCIA is contended two ways, and the production console is now a choice

Not a defect - a consequence worth stating in one place, because it is why the
ESP32 grew an AT console of its own. **This section used to list four
claimants. Two have since been retired**, and the conclusion it drew has been
overtaken by that; the current list is short.

| Claimant | Pins | Selected by | State |
|---|---|---|---|
| CPU2's AT command console | GPIO28 RX, GPIO29 TX | `BTS_DEBUG_CONSOLE == true` (`bts_user_settings.h:48`) | Debug build only - **off today** |
| CPU1's SFRA GUI | the whole port | MODE strap 6 or 7 **and** an SFRA build | Resolved at boot |
| ~~WS2812B LED driver~~ | ~~GPIO29 TX~~ | — | **Retired** - moved to the ESP32, §8.2 |
| ~~Channel 1 GPIO trip~~ | ~~GPIO28 as a digital input~~ | — | **Never enabled**, by standing instruction |

The two retired rows are gone for different reasons. The LED driver left the
device entirely on 2026-10-02 and `BTS_LED_DRIVER_ENABLED` is now `(false)` in
both arms (`bts_user_settings.h:83`, `:92`). The channel-1 GPIO trip is
`BTS_TRIP_GPIO_CH1_ENABLED (false)` in both arms as well (`:85`, `:93`) and is
to stay that way - channel 1 keeps its CMPSS over-current trip in either mode,
which is the comparator that actually protects the slot.

The first row is resolved at build time by one switch. The second is resolved
at **boot** by `SysCtl_selectCPUForPeripheral()` (`bts_cpu1.c:1382`), a
one-shot ownership write - CPU1 keeps SCIA only when `btsSfraActive` latched,
which needs `BTS_SFRA_ENABLED` **and** a strap of mode 6 or 7
(`eModeSfraAds131Plant` / `eModeSfraAds131Closed`, `registers.h:1190-1191`);
otherwise it hands the port to CPU2. That is precisely why SFRA selection has
to ride on a strap latched at reset rather than on a host register: the
ownership cannot be changed while the unit runs.

**A production build no longer loses its console for LED reasons.** That was
the whole content of this section's original heading: GPIO29 had to carry
either the console TX or the LED data line, and in production the LEDs took
it. **That constraint is gone.** GPIO29 is still muxed to `GPIO_29_SCITXDA`
(`bts_hal.c:1394`) and now sits idle, and nothing but the console wants it, so
a production build could carry the C2000 AT console at no cost.

It deliberately does not. The project ships `BTS_DEBUG_CONSOLE (false)` and
uses the **ESP32's** console instead, which carries the same grammar on its
own UART, is reachable without opening the enclosure, and reaches the
registers over I2C - see
[`at-command-specification.md`](at-command-specification.md). The point of
recording the change here is that if the C2000 console is ever wanted back, it
is now a free decision rather than a trade against the indicators.

### 8.3 The ADCB end-of-conversion flag was never cleared on the success path

**Status: FIXED.** Minor, in the supervision path. Not previously known.

`updateInputVoltage()` (`bts_cpu1.c:1864-1922`) forces ADCB SOC1/SOC2, then
spins on ADCB INT1 with a bounded wait. It clears the flag **only on the
timeout branch** (`bts_cpu1.c:1889`); on the success path the flag is left
set, and nothing else clears it (the only other
`ADC_clearInterruptStatus(ADCB_BASE, …)` is the one-time setup at
`bts_hal.c:1325`).

From the second call onward the `while` therefore exits immediately on the
stale flag, and the result is read before the freshly-forced conversion lands
— so the bus voltage is one sample (100 ms at the 10 Hz `C1()` rate) old. At
that timescale the reading is still usable, so the input-voltage guard behaves
correctly in practice.

The real cost is that **the bounded-wait guard is dead code after the first
pass**: `adcbEocTimeouts` can no longer increment, so a genuinely stuck ADCB
would be indistinguishable from a healthy one, and the "treat a timeout as
0 V, which is the safe reading" protection at `bts_cpu1.c:1882-1890` would
never trigger.

**Fixed** as described: `updateInputVoltage()` now calls
`ADC_clearInterruptStatus(ADCB_BASE, ADC_INT_NUMBER1)` on the success path as
well as on the timeout branch, and gates the result read on `adcbTimedOut` so
a timeout yields the safe 0 V rather than a stale register. The bounded-wait
guard — and therefore `adcbEocTimeouts` — is live again on every pass.

### 8.4 The ADC trigger rate is 99.67 kSPS, one sweep per switching period

**Status: FIXED, twice over.** The original trigger defect is fixed, and the
rate has since been taken to its final value. Note that **three different
figures appear in the history below** — 9.97 kSPS, 6.645 kSPS and 99.67 kSPS.
Only the last is current. Anything derived from an earlier one — filter
coefficients, ISR budgets, aliasing arguments — is stale.

`BTS_HAL_setupAdcTrigger(EPWM1_BASE)` (`bts_cpu1.c:923`) used to set `EPWM1`
TBPRD to `DEVICE_SYSCLK_FREQ / 10000 - 1` and enable SOCA on `TBCTR == 0`,
commented "10kHz". Twenty-six lines later `BTS_HAL_setupSyncBuckPwm(BTS_EPWM_BASE_CH1)`
(`bts_cpu1.c:949`) — where `BTS_EPWM_BASE_CH1` **is** `EPWM1_BASE` — overwrote
TBPRD with the switching-frequency value. The SOC registers were untouched, so
the trigger survived at the much shorter period and fired at the full switching
rate.

Two compounding errors, both now moot: TBCLK is `EPWMCLK` = `SYSCLK/2`, not
`SYSCLK`, so even unmolested the divisor was wrong by 2; and TBPRD was replaced
anyway.

**Fixed** the way this section originally recommended —
`EPWM_setADCTriggerEventPrescale()`, which divides the SOC *event* and leaves
the switching period alone. That the divider is now 1 does not make the API
choice moot: writing TBPRD here would still be overwritten twenty-six lines
later, and the prescaler remains the only knob that can slow acquisition
without moving the switching frequency. `BTS_HAL_setupAdcTrigger()`
(`bts_hal.c:1818`) is three calls and no TBPRD write at all:

```c
EPWM_enableADCTrigger(EPWM_BASE, EPWM_SOC_A);
EPWM_setADCTriggerSource(EPWM_BASE, EPWM_SOC_A, EPWM_SOC_TBCTR_ZERO);
EPWM_setADCTriggerEventPrescale(EPWM_BASE, EPWM_SOC_A, BTS_ADC_SOC_PRESCALE);
```

#### The actual rate, read off the device

`bts_user_settings.h` disagreed with itself — the comment block around
`BTS_ADC_SOC_PRESCALE` claimed prescale 10 and 9.97 kSPS while the `#define`
two lines below said 15, and it assumed SYSCLK 200 MHz when this build runs at
180. `_LAUNCHXL_F28379D` is **not** in the project's symbol list, so `device.h`
takes the IMULT-18 branch: `(20 MHz × 18 × 1) / 2` = 180 MHz.

Five registers settle it with nothing left to infer:

| Register | Value | Meaning |
|---|---|---|
| `PERCLKDIVSEL` | `0x0051` | `EPWMCLKDIV` = 1 → **EPWMCLK = SYSCLK/2 = 90 MHz** |
| `EPwm1Regs.TBCTL` | `0x8010` | up-count; `HSPCLKDIV` and `CLKDIV` both ÷1 → TBCLK = EPWMCLK |
| `EPwm1Regs.TBPRD` | `902` | 90e6 / 903 = **99.67 kHz** switching |
| `EPwm1Regs.ETPS` | `0x0820` | `SOCPSSEL` **set** → the extended divider in `ETSOCPS` is live, not `ETPS.SOCAPRD` |
| `EPwm1Regs.ETSOCPS` | — | `SOCAPRD2` = `BTS_ADC_SOC_PRESCALE`. Was `0x005F` (15); **now 1** |

**99.67 kHz / 1 = 99.67 kSPS.** At prescale 15 it read 6.645 kSPS.

The `ETPS`/`ETSOCPS` distinction is the easy one to get wrong: with `SOCPSSEL`
set, reading `ETPS.SOCAPRD` gives you a stale two-bit field that no longer
controls anything. The live divider is the 5-bit `SOCAPRD2` in `ETSOCPS` at
offset `0x33`.

This matters beyond documentation. The CLA's filter coefficient is
`2*pi*fc/fs`, so a wrong `fs` is a wrong cutoff. `BTS_CLA_ALPHA` has been
re-derived at each rate and the 20 Hz corner held throughout:

| `fs` assumed | `BTS_CLA_ALPHA` | Actual corner |
|---|---|---|
| 9.97 kSPS *(never real)* | 0.012605 | 13.3 Hz — wrong |
| 6.645 kSPS | 0.018912 | 20 Hz |
| **99.67 kSPS** *(current)* | **0.0012608** | **20 Hz** |

The derivation is recorded in `bts_cla_shared.h` register by register so the
next person does not have to re-measure it.

#### Why 1:1 is affordable — and why the ISR had to go

At prescale 1 the sweep runs every 10.03 µs. ADCA is the busiest converter at
7 SOCs; at 622 ns per SOC that is a 4.36 µs sweep inside that period, about
43 % utilisation, with the sweep comfortably complete before the next trigger.
The converter can take it.

**CPU1 could not.** An ADCA INT1 every 10.03 µs would land on a core already
servicing eight ADS131M08 DRDY interrupts. So `INT_ADCA1` is masked in the PIE
(`Interrupt_disable(INT_ADCA1)` in `main()`) and the ADC's INT1 is put into
**continuous mode** (`ADC_enableContinuousMode(ADCA_BASE, ADC_INT_NUMBER1)` in
`BTS_HAL_setupADC()`) so the converter does not stall waiting for an
acknowledgement that will never arrive. The ISR body is left registered so a
bring-up build can restore it by deleting one line.

That masking is what made the fast CLA filter mandatory rather than optional.
With the ISR dead, `CellVoltage_16b[]` is never written, so `CellVoltage_V`
would have frozen at its last value — and the reverse-polarity check would
have gone on trusting it. `BTS_refreshCellFromCla()` re-sources that pair from
the CLA's fast filter; see [§7.1](#71-what-cla1-does-here) and
[`data-flow.md` §2](data-flow.md#2-measurement-path--silicon-to-phone).

#### ADCA INT1 was sourced from SOC0 — now moot

ADCA INT1 fires on **SOC0** (`bts_hal.c:1709`) while `adcCellVoltageISR` read
SOC0–SOC6, so SOC1–SOC6 — including the SOC6 reference subtracted from every
current reading — were one conversion cycle stale. This no longer has a
consumer: the ISR is masked. **CLA1 never had the problem**, because it
triggers off SOC6, the last conversion in the sweep, so every register it
reads is from the current period. If ADCA INT1 is ever re-enabled for
bring-up, move it to SOC6 at the same time.
---

## 9. Rules

These are the invariants. Each one has already cost a hardware debugging
session.

1. **The Input X-BAR and `XINT*CR` are device-global on a dual-core part.**
   One instance at `0x7900` / `0x7070` for the whole device. A per-core
   driverlib call does not imply per-core hardware. Before pointing an XINT at
   a pin on either core, check [§4](#4-input-x-bar) — and update it. Last
   writer wins, and **CPU2 boots last**.

2. **`EINT` goes last, after every `Interrupt_register()`.** Not after most of
   them. See the defect note below.

3. **The ACK group follows the PIE group of the interrupt, not of the work.**
   Look up the vector in `hw_ints.h`, read the group out of the constant, ack
   that. If a handler is reachable from more than one vector, it needs the
   group passed in — it cannot guess.

4. **`ADC_readResult()` takes `ADCxRESULT_BASE`.** Everything else takes
   `ADCx_BASE`. There is no compile-time or run-time error for getting this
   wrong; there is only a plausible-looking constant.

5. **Never breakpoint CPU2 mid-I2C-transaction.** Halting the core while the
   host-facing target is part way through a transfer leaves the I2C target
   **wedged**: SCL held low, `BUS_BUSY` set, no interrupt pending.
   `serviceI2CTargetWatchdog()` cannot recover it, because it runs from the
   idle loop of the core you just stopped. **The ESP32 link will not come back
   without a CPU2 reload or a power cycle.** If you must break on CPU2, break
   somewhere `i2cSlaveISR`/`i2cSlaveFifoISR` is not active.

6. **A debug session loads CPU1 only.** CPU2 keeps running whatever was in its
   RAM. Since CPU2 owns I2CA, a CPU1-only reload leaves the ESP32 link dead
   while CPU1 looks perfectly healthy. Load CPU2's `.out` explicitly, then
   restart.

7. **Never do arithmetic on an `INT_*` constant.** The vector ID is in bits
   31:16 and the group/channel in 15:0. `Interrupt_register()` reads only the
   first and `Interrupt_enable()` only the second, so a wrong stride corrupts
   one and silently leaves the other correct. List the constants. See §8.1.

8. **`LSxMSEL` before `LSxCLAPGM`.** Hand mastership of an LS block to the CLA
   before declaring it CLA program memory. The reverse order can abort the
   CLA's first instruction fetch, and the symptom is a CLA that never starts —
   no fault, no flag, just a run counter stuck at zero. See
   [§7.3](#73-memory-ls4-and-ls5-belong-to-the-cla).

9. **Anything the CLA and the C28x share is defined in C.** The CLA compiler
   cannot export a symbol the C28x linker resolves. Declaring it in the `.cla`
   file links successfully and produces two separate objects.

10. **All pin muxing for both cores happens on CPU1.**
 `GPxMUX`/`GPyGMUX`, pad
   config and qualification are writable only from CPU1 — a
   `GPIO_setPinConfig()` executed on CPU2 is silently discarded.
   `BTS_HAL_setupCpu2Pins()` (`bts_hal.c:1336`) establishes CPU2's pins before
   CPU2 is released. `GPIO_setInterruptPin()` is **not** a mux operation and
   *is* callable from CPU2 — which is exactly what makes rule 1 a trap.

### What it looked like when it broke

> **Defect 3 — `EINT` ran before the last `Interrupt_register()`.**
> `BTS_HAL_setupInterrupt()` used to end with `EINT`/`ERTM`, but
> `adcCellVoltageISR` was not registered until afterwards, in `main()`.
>
> By then the ADC was already converting and raising ADCINT1:
> `BTS_HAL_setupADC()` (`bts_cpu1.c:920`) arms the interrupt and
> `BTS_HAL_setupAdcTrigger()` (`:923`) starts ePWM1 driving SOCA. ADCINT1
> fired into the still-default PIE vector —
> `Interrupt_defaultHandler`/`Interrupt_illegalOperationHandler`, an infinite
> loop — with PIE group 1 never acknowledged. CPU1 vanished into it and every
> group-1 interrupt was starved from then on.
>
> **The symptom was not a hang.** The background tasks had already stopped, so
> the register file simply froze with stale internal-ADC values — a shorted
> slot still reporting 5.078 V. A frozen `cpu1Status.seq` is the tell: CPU2
> keeps mirroring happily, and every host interface keeps answering.
>
> **Fixed:** `EINT`/`ERTM` moved out into `BTS_HAL_enableGlobalInterrupts()`
> (`bts_hal.c:1998`, rationale immediately above it), called from
> `bts_cpu1.c:1028` after every registration. The header carries the ordering
> requirement at `bts_hal.h:122-127`. CPU2 already had this right — its
> `EINT`/`ERTM` are at
> `com_cpu2.c:3386-3387`, after all of
> `initI2C_Slave`/`initUART`/`initCAN`/`initTimer`/`LEDDriver_init`.
>
> Note that CPU2's `initADS1119()` runs *after* `EINT` (`com_cpu2.c:3414`) and
> is safe only because it registers `INT_XINT1`/`INT_XINT2` **before** calling
> `Interrupt_enable()` on them (`com_cpu2.c:1506-1507` vs `:1537`/`:1541`),
> and clears any latched PIE state first (`:1533`). Registering before
> enabling is the general form of rule 2.

---

## 10. Source index

| Resource | Declared in | Applied in |
|---|---|---|
| XINT selection, DRDY pins, trip pins | `bts_user_settings.h:355-379`, `:501-546` | `bts_hal.c:413-473` |
| Input X-BAR writes | — | `bts_hal.c:925-946`, `:1236-1257`; `com_cpu2.c:1501-1504` |
| Input X-BAR allocation comment | — | `bts_hal.c:1196-1233` (keep in step with §4) |
| CPU1 interrupt registration | — | `bts_hal.c:1936-1981`; `bts_cpu1.c:1022` |
| CPU1 global enable | `bts_hal.h:122-127` | `bts_hal.c:1998`; called `bts_cpu1.c:1028` |
| CPU1 ISR bodies | `bts_hal.h:148-151` | `bts_cpu1.c:1162-1209`, `:2217`, `:2272` |
| CPU1 ACK groups | — | `bts.h:811`, `:862`; `bts_hal.h:240`, `:255`; `bts_cpu1.c:1207`, `:2254`, `:2371` |
| CPU2 interrupt registration | — | `com_cpu2.c:339-342`, `:1315`, `:1383`, `:1399`, `:1506-1507` (`led_driver.c:76` is compiled out — see §8.2) |
| CPU2 global enable | — | `com_cpu2.c:3386-3387` |
| ADC SOC / interrupt setup | — | `bts_hal.c:1680-1781` |
| ADC SOC trigger and event prescale | `bts_hal.h:136` | `bts_hal.c:1818-1828`; `BTS_ADC_SOC_PRESCALE` at `bts_user_settings.h:931` |
| CLA1 task body and SOC map | `bts_cla_shared.h` | `bts_cla.cla` |
| CLA1 shared data definitions | `bts_cla_shared.h` | `bts_cla_data.c` |
| CLA1 init: LS4/LS5, `MVECT`, `MIER`, trigger | — | `bts_cpu1.c:843-910`; called `:929` |
| CLA1 memory placement | — | `2837xD_RAM_lnk_cpu1.cmd` (`Cla1Prog`, `CLADataLS5`, `.scratchpad`) |
| Trip zone signals and interrupt masking | `bts_user_settings.h:113-120` | `bts_hal.c:1437-1490` |
| PIE group numbers | `driverlib/f2837xd/driverlib/inc/hw_ints.h` | — |
| XINT → X-BAR input mapping | `driverlib/f2837xd/driverlib/gpio.c:127-147` | — |
| X-BAR input → peripheral mapping | `driverlib/f2837xd/driverlib/xbar.h:199-215` | — |
