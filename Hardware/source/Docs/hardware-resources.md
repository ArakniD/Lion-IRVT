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
tables and are recorded in [§7](#7-known-conflicts-and-latent-bugs). Two are
resource conflicts of exactly the kind this file exists to prevent — a
trip-vector registration that silently collapses to one slot, and a CPU2 timer
claimed twice — and both are masked today only by a build flag.

---

## 1. PIE interrupt allocation

No PIE vector may be claimed by both cores. Each core has its own PIE and its
own vector table, so the same *number* on the two cores is not a conflict —
but a device-global resource feeding that vector (see [§4](#4-input-x-bar))
absolutely is.

### 1.1 CPU1 — real-time control

| Interrupt | PIE grp.ch | Handler | Registered at | Body at | Services |
|---|---|---|---|---|---|
| `INT_ADCA1` | **1.1** | `adcCellVoltageISR` | `bts_cpu1.c:919` | `bts_cpu1.c:1965` | On-chip 12-bit ADC: 8 cell voltages, 8 cell currents, 1 reference |
| `INT_EPWM1_TZ` … `INT_EPWM8_TZ` | **2.1–2.8** | `epwmTripISR` | `bts_hal.c:1482` | `bts_cpu1.c:2020` | ePWM trip zones, all 8 slots. **See §7.1 — the registration is wrong** |
| `INT_EPWM1` | **3.1** | `epwm1ISR` | `bts_hal.c:1475` | `bts_cpu1.c:1100` | SFRA sweep. Compiled out: `BTS_SFRA_ENABLED (false)`, `bts_user_settings.h:270` |
| `INT_SPIA_RX` | **6.1** | `ISR2` → `BTS_ExAdcRead_ch1_4()` | `bts_hal.c:1461` | `bts_cpu1.c:1085`, `bts_hal.h:212` | SPIA RX FIFO — ADS131M08 #1 frame for slots 1–4 |
| `INT_SPIC_RX` | **6.9** | `ISR4` → `BTS_ExAdcRead_ch5_8()` | `bts_hal.c:1468` | `bts_cpu1.c:1092`, `bts_hal.h:227` | SPIC RX FIFO — ADS131M08 #2 frame for slots 5–8 |
| `INT_XINT3` | **12.1** | `ISR1` → `BTS_runISR_ch1_4()` | `bts_hal.c:1460` | `bts_cpu1.c:1059`, `bts.h:759` | SPI ADC1 DRDY on GPIO25. Runs the slot 1–4 control loops |
| `INT_XINT5` | **12.3** | `ISR3` → `BTS_runISR_ch5_8()` | `bts_hal.c:1467` | `bts_cpu1.c:1072`, `bts.h:816` | SPI ADC2 DRDY on GPIO49. Runs the slot 5–8 control loops |

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
> bounded poll, not an ISR. See §7.3 for a flaw in that poll.

### 1.2 CPU2 — communications and configuration

| Interrupt | PIE grp.ch | Handler | Registered at | Body at | Services |
|---|---|---|---|---|---|
| `INT_XINT1` | **1.4** | `ads1119Drdy1ISR` | `com_cpu2.c:1506` | `com_cpu2.c:1734` | ADS1119 #1 DRDY on GPIO42 (slots 1–4 cell temperature) |
| `INT_XINT2` | **1.5** | `ads1119Drdy2ISR` | `com_cpu2.c:1507` | `com_cpu2.c:1746` | ADS1119 #2 DRDY on GPIO43 (slots 5–8 cell temperature) |
| `INT_TIMER0` | **1.7** | `ledTimerISR` | `led_driver.c:43` | `led_driver.c:131` | WS2812B refresh at 80 Hz. **Production build only**; see §7.2 |
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
| `adcCellVoltageISR` | `INT_ADCA1` | 1 | `INTERRUPT_ACK_GROUP1` | `bts_cpu1.c:2002` |
| `epwmTripISR` | `INT_EPWMx_TZ` | 2 | `INTERRUPT_ACK_GROUP2` | `bts_cpu1.c:2119` |
| `epwm1ISR` | `INT_EPWM1` | 3 | `INTERRUPT_ACK_GROUP3` | `bts_cpu1.c:1104` |
| `BTS_ExAdcRead_ch1_4()` (from `ISR2`) | `INT_SPIA_RX` | 6 | `INTERRUPT_ACK_GROUP6` | `bts_hal.h:220` |
| `BTS_ExAdcRead_ch5_8()` (from `ISR4`) | `INT_SPIC_RX` | 6 | `INTERRUPT_ACK_GROUP6` | `bts_hal.h:235` |
| `BTS_runISR_ch1_4()` (from `ISR1`) | `INT_XINT3` | **12** | `INTERRUPT_ACK_GROUP12` | `bts.h:811` |
| `BTS_runISR_ch5_8()` (from `ISR3`) | `INT_XINT5` | **12** | `INTERRUPT_ACK_GROUP12` | `bts.h:862` |
| `ads1119Drdy1ISR` | `INT_XINT1` | 1 | `INTERRUPT_ACK_GROUP1` | `com_cpu2.c:1741` |
| `ads1119Drdy2ISR` | `INT_XINT2` | 1 | `INTERRUPT_ACK_GROUP1` | `com_cpu2.c:1749` |
| `ledTimerISR` | `INT_TIMER0` | 1 | `INTERRUPT_ACK_GROUP1` | `led_driver.c:134`, stub `:148` |
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

**CPU Timer 0 is different** — it *is* a PIE interrupt at 1.7 and its handler
does need `INTERRUPT_ACK_GROUP1`.

### What it looked like when it broke

> **Defect 2 — the ACK group did not follow the XINT move.** When CPU1 moved
> its SPI DRDY lines from XINT1/XINT2 to XINT3/XINT5 (see §4), the PIE group
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

The CMPSS comparators do **not** go through the Input X-BAR. They reach the
ePWM trip zones through the separate **ePWM X-BAR** at `EPWMXBAR_BASE`
`0x7A00`. Each `TRIPn` output selects among muxes; `CMPSSn` occupies mux
`(n-1)*2` (`bts_hal.c:919-923`).

| Slot | CMPSS | ePWM X-BAR trip | Mux | Set at | State |
|---|---|---|---|---|---|
| 1 | `CMPSS1` | `XBAR_TRIP4` | `MUX00` | `bts_hal.c:1140` | Compiled out |
| 2 | `CMPSS2` | `XBAR_TRIP5` | `MUX02` | `bts_hal.c:1143` | Compiled out |
| 3 | `CMPSS3` | `XBAR_TRIP7` | `MUX04` | `bts_hal.c:1146` | Compiled out |
| 4 | `CMPSS4` | `XBAR_TRIP8` | `MUX06` | `bts_hal.c:1149` | Compiled out |
| 5 | `CMPSS5` | `XBAR_TRIP9` | `MUX08` | `bts_hal.c:1152` | Compiled out |
| 6 | `CMPSS6` | `XBAR_TRIP10` | `MUX10` | `bts_hal.c:1155` | Compiled out |
| 7 | `CMPSS7` | `XBAR_TRIP11` | `MUX12` | `bts_hal.c:1158` | Compiled out |
| 8 | `CMPSS8` | `XBAR_TRIP12` | `MUX14` | `bts_hal.c:1161` | Compiled out |

All eight CMPSS modules are still *configured* unconditionally
(`bts_hal.c:1118-1125`) — only the X-BAR routing and the trip-zone signals are
gated on `BTS_TRIP_HW_CHn_ENABLED`.

> `XBAR_TRIP6` is skipped: `INPUT6` feeds ePWM TRIP6 directly, and `INPUT6` is
> XINT3's input (CPU1's SPI ADC1 DRDY). Do not route a CMPSS to TRIP6.

### ePWM module allocation

| Module | Purpose | Configured at |
|---|---|---|
| `EPWM1`–`EPWM8` | Slot 1–8 synchronous buck/boost, HRPWM on both edges | `bts_hal.c:599` via `bts_cpu1.c:846-853` |
| `EPWM1` *(also)* | **SOCA trigger for the on-chip ADC** | `bts_hal.c:1336` via `bts_cpu1.c:826` — see §7.4 |
| `EPWM11` | ADS131M08 #1 master clock, GPIO20 | `bts_hal.c:763` via `bts_cpu1.c:855` |
| `EPWM12` | ADS131M08 #2 master clock, GPIO22 | `bts_hal.c:763` via `bts_cpu1.c:856` |
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

All `ADC_TRIGGER_EPWM1_SOCA` unless noted. Configured `bts_hal.c:1286-1310`.

| | SOC0 | SOC1 | SOC2 | SOC3 | SOC4 | SOC5 | SOC6 |
|---|---|---|---|---|---|---|---|
| **ADCA** | IN3 — ch1 V | IN5 — ch3 V | IN15 — ch4 V | IN2 — ch1 I | IN4 — ch3 I | IN14 — ch4 I | IN0 — **reference** |
| **ADCB** | IN3 — ch2 V | IN0 — **bus V**, SW-only | IN1 — SW-only | IN2 — ch2 I | | | |
| **ADCC** | IN3 — ch6 V | IN5 — ch8 V | IN2 — ch6 I | IN4 — ch8 I | | | |
| **ADCD** | IN1 — ch5 V | IN3 — ch7 V | IN0 — ch5 I | IN2 — ch7 I | | | |

ADC interrupt sources: **ADCA INT1 ← SOC0** (`bts_hal.c:1315`, drives PIE 1.1);
**ADCB INT1 ← SOC2** (`bts_hal.c:1326`, polled only — see §1.1 and §7.3).

### What it looked like when it broke

> **Defect 4 — `ADC_readResult()` called with the control base.** Every slot
> read back ADCCTL1/ADCCTL2 as if they were conversions. The symptom was a
> **constant 8320 (0x2080)** on every channel's cell voltage and current —
> identical across all eight slots, perfectly stable, and unmoved by anything
> connected to the hardware. A shorted slot still reported a healthy voltage.
>
> A constant that is the same on every channel and never moves is the
> signature: real ADC noise is never that quiet. **Fixed** in
> `adcCellVoltageISR` (`bts_cpu1.c:1975-1994`, with the rationale at
> `:1968-1972`) and in the bus-voltage read (`bts_cpu1.c:1893`).

---

## 7. Known conflicts and latent bugs

### 7.1 All eight trip-zone ISRs are registered into the ePWM1 vector

**Status: live defect, currently masked. Found 2026-09-21 while compiling
these tables; not previously known.**

`bts_hal.c:1482-1483`:

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

**Fix** (not applied here — this document records, it does not change
behaviour): either stride by `0x00010001U`, or, clearer and immune to the same
mistake, index an explicit table:

```c
static const uint32_t tzInts[8] = {
    INT_EPWM1_TZ, INT_EPWM2_TZ, INT_EPWM3_TZ, INT_EPWM4_TZ,
    INT_EPWM5_TZ, INT_EPWM6_TZ, INT_EPWM7_TZ, INT_EPWM8_TZ,
};
```

**This must be fixed before any `BTS_TRIP_HW_CHn_ENABLED` is set true.**

### 7.2 CPU Timer 0 on CPU2 is double-booked

**Status: latent in the current build, live in a production build. Not
previously known.**

Two subsystems claim CPU2's Timer 0 with incompatible configurations:

| Claimant | Configuration | Where | Guard |
|---|---|---|---|
| WS2812B LED driver | period `SYSCLK/80` (80 Hz), **interrupt enabled**, `INT_TIMER0` registered | `led_driver.c:40-45` | `#if BTS_LED_DRIVER_ENABLED == true` |
| ADS1119 settle dwell | period `0xFFFFFFFF` free-running, **interrupt disabled**, counter read only | `com_cpu2.c:1482-1485` | **none — unconditional** |

In `main()`, `LEDDriver_init()` runs at `com_cpu2.c:3384` and `initADS1119()`
at `com_cpu2.c:3414`. **The ADS1119 claim runs second and wins.**

In the current build this is harmless: `BTS_DEBUG_CONSOLE` is `true`
(`bts_user_settings.h:42`), so `BTS_LED_DRIVER_ENABLED` is `false` and
`LEDDriver_init()` is a no-op stub (`led_driver.c:144`).

Set `BTS_DEBUG_CONSOLE` to `false` for a production build and the LED driver
becomes real — then `initADS1119()` silently calls
`CPUTimer_disableInterrupt(CPUTIMER0_BASE)` and reprograms the period. The
registered, enabled `ledTimerISR` never fires again and the WS2812B string
freezes on whatever it last displayed. **Status indication would appear to
work at boot and then stop, with no error** — and a frozen LED showing
"running" on a slot that has since tripped is actively misleading.

The comment at `com_cpu2.c:1476-1480` shows the author knew the timer was
shared ("CPU timer 0 is otherwise only started by the WS2812B driver, which is
compiled out in a console build, so start it here") — but the code that
follows is not guarded by that condition.

**Fix**: wrap the ADS1119 timer setup in
`#if (BTS_LED_DRIVER_ENABLED == false)`, or move the dwell timebase to CPU
Timer 2, which is unused on CPU2.

### 7.3 The ADCB end-of-conversion flag is never cleared on the success path

**Status: minor, in the supervision path. Not previously known.**

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

**Fix**: clear the flag after a successful read as well as after a timeout.

### 7.4 EPWM1's period is written twice; the ADC trigger rate is not 10 kHz

**Status: works, but the comment and the intent disagree with the hardware.**

`BTS_HAL_setupAdcTrigger(EPWM1_BASE)` (`bts_cpu1.c:826`) sets `EPWM1` TBPRD to
`DEVICE_SYSCLK_FREQ / 10000 - 1` = 15999 and enables SOCA on `TBCTR == 0`,
commented "10kHz" (`bts_hal.c:1340`).

Twenty lines later, `BTS_HAL_setupSyncBuckPwm(BTS_EPWM_BASE_CH1)`
(`bts_cpu1.c:846`) — where `BTS_EPWM_BASE_CH1` **is** `EPWM1_BASE`
(`bts_user_settings.h:406`) — overwrites TBPRD with `BTS_DRV_EPWM_TBPRD` = 802.
It does not touch the SOC registers, so the SOCA trigger survives at the new,
much shorter period.

Two compounding errors:

1. TBCLK is `EPWMCLK` = `SYSCLK/2` = 80 MHz, not `SYSCLK`. Even unmolested,
   TBPRD 15999 would have given 5 kHz, not 10 kHz.
2. TBPRD is then replaced by the switching-frequency value anyway.

**Actual ADCA trigger rate: 80 MHz / 803 ≈ 99.6 kHz** — the converter
switching frequency, roughly 10x the documented intent. `adcCellVoltageISR`
(17 result reads plus 8 `BTS_storeValuesF28()` calls) therefore runs every
~10 µs on CPU1.

This is survivable — the conversions fit in the window and the system is
running — but it is a substantial and unintended CPU1 interrupt load, and the
"10kHz" comment will mislead anyone budgeting ISR time. If a 10 kHz
cell-voltage sample rate is what is wanted, use
`EPWM_setADCTriggerEventPrescale()` (which divides the SOC event, leaving the
switching period alone) rather than a second TBPRD write, or move the SOC
trigger to `EPWM9`/`EPWM10`, which are free.

Note also that ADCA INT1 is sourced from **SOC0** (`bts_hal.c:1315`) while the
ISR reads SOC0–SOC6. The interrupt asserts when SOC0 finishes, so SOC1–SOC6 —
including the SOC6 reference subtracted from every current reading — are read
one conversion cycle stale. At ~100 kHz that is ~10 µs and immaterial, but if
the trigger rate is ever reduced, source the interrupt from the **last** SOC in
the round robin instead.

---

## 8. Rules

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

7. **All pin muxing for both cores happens on CPU1.** `GPxMUX`/`GPyGMUX`, pad
   config and qualification are writable only from CPU1 — a
   `GPIO_setPinConfig()` executed on CPU2 is silently discarded.
   `BTS_HAL_setupCpu2Pins()` (`bts_hal.c:960`) establishes CPU2's pins before
   CPU2 is released. `GPIO_setInterruptPin()` is **not** a mux operation and
   *is* callable from CPU2 — which is exactly what makes rule 1 a trap.

### What it looked like when it broke

> **Defect 3 — `EINT` ran before the last `Interrupt_register()`.**
> `BTS_HAL_setupInterrupt()` used to end with `EINT`/`ERTM`, but
> `adcCellVoltageISR` was not registered until afterwards, in `main()`.
>
> By then the ADC was already converting and raising ADCINT1:
> `BTS_HAL_setupADC()` (`bts_cpu1.c:823`) arms the interrupt and
> `BTS_HAL_setupAdcTrigger()` (`:826`) starts ePWM1 driving SOCA. ADCINT1
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
> (`bts_hal.c:1502`, rationale at `:1489-1501`), called from `bts_cpu1.c:925`
> after every registration. The header carries the ordering requirement at
> `bts_hal.h:102-107`. CPU2 already had this right — its `EINT`/`ERTM` are at
> `com_cpu2.c:3386-3387`, after all of
> `initI2C_Slave`/`initUART`/`initCAN`/`initTimer`/`LEDDriver_init`.
>
> Note that CPU2's `initADS1119()` runs *after* `EINT` (`com_cpu2.c:3414`) and
> is safe only because it registers `INT_XINT1`/`INT_XINT2` **before** calling
> `Interrupt_enable()` on them (`com_cpu2.c:1506-1507` vs `:1537`/`:1541`),
> and clears any latched PIE state first (`:1533`). Registering before
> enabling is the general form of rule 2.

---

## 9. Source index

| Resource | Declared in | Applied in |
|---|---|---|
| XINT selection, DRDY pins, trip pins | `bts_user_settings.h:355-379`, `:501-546` | `bts_hal.c:413-473` |
| Input X-BAR writes | — | `bts_hal.c:925-946`, `:1236-1257`; `com_cpu2.c:1501-1504` |
| Input X-BAR allocation comment | — | `bts_hal.c:1196-1233` (keep in step with §4) |
| CPU1 interrupt registration | — | `bts_hal.c:1457-1486`; `bts_cpu1.c:919-920` |
| CPU1 global enable | `bts_hal.h:102-107` | `bts_hal.c:1502`; called `bts_cpu1.c:925` |
| CPU1 ISR bodies | `bts_hal.h:128-131` | `bts_cpu1.c:1059-1106`, `:1965`, `:2020` |
| CPU1 ACK groups | — | `bts.h:811`, `:862`; `bts_hal.h:220`, `:235`; `bts_cpu1.c:1104`, `:2002`, `:2119` |
| CPU2 interrupt registration | — | `com_cpu2.c:339-342`, `:1315`, `:1383`, `:1399`, `:1506-1507`; `led_driver.c:43` |
| CPU2 global enable | — | `com_cpu2.c:3386-3387` |
| ADC SOC / interrupt setup | — | `bts_hal.c:1286-1326` |
| Trip zone signals and interrupt masking | `bts_user_settings.h:113-120` | `bts_hal.c:1061-1109` |
| PIE group numbers | `driverlib/f2837xd/driverlib/inc/hw_ints.h` | — |
| XINT → X-BAR input mapping | `driverlib/f2837xd/driverlib/gpio.c:127-147` | — |
| X-BAR input → peripheral mapping | `driverlib/f2837xd/driverlib/xbar.h:199-215` | — |
