# RESUME HERE — written 2026-09-30, coverage ended mid-session

Everything below is **committed and building**. There is no dirty work in
progress. Last commit is `7bdddfd`.

## State: clean

| ToDo | Status | Commit |
|---|---|---|
| 01 Canbus telemetry | DONE | `8cb945d` |
| 02 ePWM X-BAR / CMPSS trips | DONE | `719c028` |
| 03 ADC to 100 kHz + CLA | DONE | `e889543` |
| 04 LED timer + CCCV | DONE | `ac1bb42` |
| 05 HA register mirror | **NOT STARTED** — do this next | — |
| 06 Slot tuning registers | **PART 1 DONE** | `6c2c838` |
| 07 SFRA runtime switch | DONE | `b253cf5` |

Working tree carries only untracked `Docs/hardware-todo.md`, which is the
user's own file and marked "AGENT IGNORE THIS FILE". Leave it.

**Nothing has been pushed.** The user has not asked for a push.

## Next task: ToDo 05

This was deliberately ordered last, because ToDo 06 moved `TOTAL_REGISTERS`
again and doing 05 first would have meant rewriting it twice.

**The numbers in `ToDo/05...md` are now one revision stale.** It was written
before ToDo 06. Use these instead:

| Constant | HA mirror holds | C2000 has NOW |
|---|---|---|
| `TOTAL_REGISTERS` | 315 | **280** (was 267 before ToDo 06) |
| `TOP_ADDRESS` | 1256 | **1116** (was 1064) |
| `UNIT_BASE` | 1152 | **960** |
| `SET_STRIDE` | 96 | **72** |

Everything else in ToDo 05 still holds: the merged charge/discharge limits are
a *semantic* change and not just an address change, and the 17 failing tests
in `tests/test_registers.py` are **correct** — fix the mirror, never the
tests.

The HA mirror also now needs the 13 new tuning registers at 1068–1116, which
ToDo 05 predates entirely. `esp32-btle-proxy/.../bts_regs.h` is a correct
second opinion and was updated in `6c2c838` — but note the two headers use
different conventions for the same identifier families (byte offsets and masks
vs register indices and bit positions), so copying a line across compiles and
is silently wrong.

## ToDo 07 — RESOLVED and DONE

The mode-table conflict was decided by the user in the notes below: modes 6
and 7 (the unused grouped internal-ADC modes) became the two SFRA modes, and
**mode 0 was left alone** — which is the safe outcome, since an unstrapped
board decodes to mode 0 through the pull-ups.

Both mode macros had to stop being pure bit arithmetic: group size is forced
to 1 for a sweep, and the converter test is explicit because bit 2 is set for
both tuning modes while only mode 6 sweeps the internal-ADC loop.

SFRA now runs on a strap-latched runtime flag; the library remains a build
switch. SCIA ownership rides the same strap because CPUSEL is boot-time only.
See `ToDo/07...md` for the full changelog.

## What the user confirmed this session

**The CC and CV DCL coefficients have been tested on hardware on the
ADS131M08 paths and are good.** This retires the "CV loop stability is
unverified" risk recorded in ToDo 04's changelog — that caveat is now stale,
and the CCCV switch is not a risk item.

## Standing constraints (unchanged)

- **Read `C:/ti/ccs2101/ccs/theia/resources/ai/CCS.md` before ANY ccs-* MCP
  tool.** CCS install dir is `C:/ti/ccs2101`.
- **`buildProject` MCP tool for CPU1, never gmake.** The `cpu2/makefile` gmake
  invocation is the single approved exception.
- Rebuild AND verify **both** cores after any shared-header edit; confirm all
  eight shared symbols (`registers`, `ipcMsg`, `calValidFlags`, `supervision`,
  `canData`, `cpu1Status`, `startup_mode`, `startup_enable`) resolve to the
  same address in both maps.
- **Check `CPU2TOCPU1RAM`** on any register-count change. It is the binding
  constraint: 0x2d0 used, **304 words free** after ToDo 06.
- Never edit `.syscfg`, `.project`, `.cproject`, `.ccsproject`, `.settings`,
  or anything under the SDK.
- Line endings differ **per file** — detect, never hard-code, and assert match
  counts on every substitution.
- Do not push to `origin/master`.
- Commit messages end with
  `Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>`.

## Traps worth re-reading before touching this code

- **Bash heredocs mangle backticks and apostrophes.** Two patchers failed this
  session. Write the script to a file with the Write tool and run it, rather
  than piping a heredoc.
- `git stash` is blocked by the auto-mode classifier. To measure a build delta,
  copy the file aside and edit in place instead.
- Build-log greps must skip lines starting `"C:` — the embedded compiler
  command lines contain `--diag_warning=225` and match naive error greps.
- A function called above its definition in `com_cpu2.c` links only with a
  forward declaration; this cost one failed CPU2 link this session.

## Human notes for resumption

typedef enum {
    eModeIndependent       = 0,  // 8 independent slots
    eModePairs             = 1,  // 1+2, 3+4, 5+6, 7+8
    eModeQuads             = 2,  // 1-4, 5-8
    eModeOctet             = 3,  // 1-8 as one group
    eModeIndependentIntAdc = 4,  // as above, internal ADC voltage control
    eModePairsIntAdc       = 5,
    eModeQuadsIntAdc       = 6,
    eModeOctetIntAdc       = 7,
} BTS_SlotMode;

change eModeQuadsIntAdc to SFRA on INTERNAL ADC
chaneg eModeOctetIntAdc to SFRA on ADS131M08 ADC