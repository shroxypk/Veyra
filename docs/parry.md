# Auto Parry: timing model and evidence

Auto Parry is experimental and available in the panel. This is its technical note. It exists so the claims
in `README.md` can be checked instead of trusted, and so nobody has to reverse
engineer the reasoning later.

## The mechanic, measured

From the game's own state machine (`StateManager`, `CastFn_Counter`) and live
probes:

| Quantity | Value | How it was obtained |
| --- | --- | --- |
| Granted parry window | `0.30 s` (`StateDuration_Parrying`) | constant across every grant observed |
| Send to grant (`outbound`) | `0.056 - 0.073 s` | `StateEnd_Parrying - StateDuration_Parrying - GetServerTimeNow()` sampled at send |
| Grant visible on client | `0.150 - 0.236 s` | attribute replication, i.e. `outbound` plus the inbound leg |
| Lockout after a whiff | `0.93 - 0.97 s` (measured `StateDuration_ParryCooldown = 1.25`) | measured `sentToCanParry` |
| Successful parry | removes `ParryCooldown`, adds `APF` 0.5 s + `ParriedAttack` 0.25 s | `CastFn_Counter` |

`End Block` does not cancel a granted window (11 of 12 measured), so a press is a
short pulse, not a hold. Pressing again while a window is open cannot extend it.

## Lockout is max, not sum

A successful parry removes `ParryCooldown` and applies `APF` (0.5s) and
`ParriedAttack` (0.25s) simultaneously. The lockout is the later of the two
expiries, not their sum. The scheduler computes:

```lua
grace = max(StateEnd_APF, StateEnd_ParriedAttack)
```

This means a second hit arriving 0.4s after a successful parry is covered by
the grace window (APF ends at 0.5s), not forced into an orphan.

## Why the press is centred where it is

The animation track is itself delayed by the inbound leg, so an impact authored
at marker time `m` lands on this client's clock at `trackStart + m`: the inbound
delay cancels. A press sent at local time `S` opens the parry at `S + outbound`.
The impact therefore has to fall in `[S + outbound, S + outbound + 0.30]`, which
puts the ideal press at:

```
S = impact - outbound - 0.15
```

The pre-fix code used the *observed* grant lag (`0.15 s`) as the lead, pressing
about 90 ms too early. `tests/runtime/verify_parry_coverage.lua` quantifies that
mistake: it misses 972 of the residuals the current build covers.

## Coverage-maximising chain assignment

When two attacks arrive within one lockout window (0.75s), the scheduler
compares two strategies:

1. **Parry first, drop second**: 1 parry + 0 parries
2. **Roll first, parry second**: 0 parries + 1 parry (if spacing allows)

It chooses whichever covers more hits. Ties break toward parry. Assignments
are emitted as `{kind="parry"|"roll", candidate}` on `state.orphans`. The
`kind="parry"` entries still become presses; `kind="roll"` entries are for
Auto Dodge.

## AoE route

Assets classified as AoE never produce parry presses. Classification triggers:
- Name matches `screech|roar|bomb|summon|explosion|field|rupture`
- Attacker carries `State_HyperArmor`
- Learned from C1 store as `aoe=true`

AoE assets publish to orphans with `kind="roll"` and use their own learned
`rollLead` (default 0.34s). Examples: Screech, Bomb, RageScreech.

## Profile decay

Per-asset wins/losses are tracked in `Veyra/parry_learned.json`. When:
- Losses >= 5 AND
- Win rate < 0.35

The authored profile is demoted to derived and re-derived once from keyframes.
`placeVersion` is stored; on change, all authored profiles are marked stale
and re-derived on first sight.

## Marker accuracy was measured, not assumed

`tests/data/parry_marker_residuals.json` holds real impacts from replicated
fights, recorded without moving or attacking (`tools/observe_parry.lua`, reduced
by `tools/summarise_parry_obs.py`). Each sample pairs the attacking animation,
the marker the profile schedules on, and the moment damage actually landed.
Only hostile-NPC to player melee inside 8 studs is kept, because that is exactly
the case the scheduler predicts; player swings carry their own combo semantics
and pollute the timing.

Six clean samples: residual `impact - marker` = `+0.001 ... +0.037 s`, median
`+0.020 s`, stdev `0.013 s`. The band asserted by
`tests/unit/test_parry_marker_residuals.py` is wider than that.

## Coverage proof

`tests/runtime/verify_parry_coverage.lua` runs the shipped `parry_math` against
every residual in `[-0.100, +0.130] s` for markers between `0.30 s` and `0.90 s`,
on 60 Hz frames, and asserts that one centred press covers all of them. It also
asserts the window is centred on the marker within a frame.

Markers earlier than `outbound + window/2` leave no room for a centred
press from animation start. A later, off-centre press may still cover the hit
if the input arrives in time. Feint gates beyond that arrival deadline are
rejected rather than extending the deadline artificially.

## What the scheduler refuses to do

Each of these exists because the alternative costs the ~1 s lockout:

- no press while `ParryCooldown`, `Attacking`, `Parried`, `Ragdoll`, `Occupied`,
  `Dodging`, `Blocking` or `UsingSkill` is active;
- no press during the `APF` grace after a successful parry (hits are negated
  already);
- no press in `InSafezone` (damage is discarded there);
- no press for an attacker that is stunned, parried or downed mid-swing;
- no press when the attacker is out of range, above/below the character, or
  facing away (dot product below `0.25`), unless the swing starts inside 8 studs
  where spin attacks make facing meaningless;
- no press while `State_Burning` is set (burn ticks are unparryable);
- sending a press does not discard other pending attacks: the server may reject
  the input. State and cooldown gates regulate subsequent presses.

## Learning rules

- **Attribution scoring**: Damage is scored across all pending candidates by
  facing cone (0.3), reach margin (0.2), LOS (0.2), track-position fit (0.2),
  and damage-magnitude z-score (0.1). Learning only occurs when the top score
  beats the runner-up by 0.25. Ambiguous events are diagnostic only.
- **Bias/unparryable**: Learned from damage residuals only when attribution is
  confident. Strike counters track ambiguous hits; 2 strikes confirms
  unparryable, 2 parries clears it.
- **Cooldown expiry** comes from `StateEnd_ParryCooldown` when present, because
  the replicated flag clears one inbound leg late and waiting for it moves the
  next press ~0.1 s too late.
  Anticipating expiry never relaxes the other `CanBlock` predicates (blocking,
  incapacitation, dodging, parrying, skills, flying, occupation, or attacking).
- **Calibration is optional.** Pending attacks continue through the scheduler
  while it waits, and a real press cancels the idle calibration pulse.

## Honest ceiling

### What remains

- **Unknown mob animations**: The pose-derived system can estimate impacts from
  keyframe motion, but has not been validated against live combat data for
  the Dire Wolf, Alke, lizard, ogre, golem, zombie, graveyard, and pumpkin
  sets. The collector (`tools/collector_v4.lua`) captures facing, LOS,
  HyperArmor, burning state, and RTT to improve these estimates.

- **Multi-attacker attribution**: When two mobs attack simultaneously, the
  scoring system may still misattribute damage. The 0.25 margin requirement
  prevents bad learning, but coverage could suffer.

- **Projectile tracking**: Ballistic projectiles are detected via DescendantAdded
  and velocity checks, but this does not cover homing or AoE fields.

- **Server rejection**: The reject inference (ParryCooldown without Parrying)
  triggers a re-press, but the server-side reason for rejection is not visible
  to the client.

- **Mobile/touch**: The system assumes keyboard/mouse input. Touch devices
  may not support the same keybind checks.

### Mob coverage and pose-derived candidates

The bundled table contains 176 marker profiles and 11 additional pose-derived
profiles. Authored entries take precedence. Unknown non-looping candidate
animations can be fetched once per session; successful estimates are cached in
`Veyra/parry_derived.json` with best-effort file I/O.

Keyframes must be sorted by time before calculating composed pose-position
speeds. The estimator groups bursts above `max(4, peakSpeed * 0.15)`, ending
a burst below half that threshold. Peaks within 0.28 seconds are clustered;
the candidate impact is the cluster midpoint plus 0.03 seconds. Derived hits
before 0.20 seconds are conservatively discarded, not proven impossible.

Against 25 known marker profiles with detected bursts, 23 of 26 reference hits
were within 0.125 seconds (median 0.030, p90 0.128, maximum 0.611 seconds).
Two additional profiles produced no retained burst. These are exploratory
comparisons, not held-out validation or a measured parry success rate. Missing
and extra predicted hits, attack classification, latency and server rules can
still cause failures on unseen attacks.

The first unknown swing may receive a defensive block, capped at 1.5 seconds,
when ready, in range, and with no profiled attacks pending. It releases when
the track stops or the attacker becomes invalid/out of range. A held block
does not extend the parry window or guarantee mitigation of unblockable moves.

`tools/derive_parry_profiles.py` consumes a local sorted-pose probe JSON;
`tools/import_parry_assets.py` merges the resulting derived JSON into a marker
dump while preserving authored profiles. Probe data is local research input.

A parry cannot be extended indefinitely by holding block. The measured whiff
lockout limits repeated failed attempts; it is not a universal uptime ceiling,
because successful parries have different recovery behavior. This build aims
to align inputs with impacts, but does not establish that every profiled attack
is parryable. See [combat research](combat-research.md) for public-source rules,
guardbreak and failed-parry recovery concerns, and remaining implementation gaps.

## Live diagnostics

Fresh stationary calibration on 2026-10-27 confirmed
`StateDuration_Parrying = 0.25`, `StateDuration_ParryCooldown = 0.8`, and a
numeric `StateEnd_ParryCooldown`. The grant became visible after 0.148 s.
These are one-session measurements, not combat success-rate evidence.
The interface lifecycle test also passed against the loaded 176-profile build.

`getgenv().VeyraParry` exposes:

`status`, `profiles`, `attempts`, `grants`, `confirmed`, `damageEvents`,
`covered`, `missed`, `lead`, `grantLag`, `bias`, `hitResiduals`, `unparryable`,
`unparryableSkips`, `unobservedGrants`, `successByAsset`, `cooldownWait`, `unknownAssets`, and a bounded `log`.

`range` defaults to 14 studs, `leadOffset` is an optional manual seconds
adjustment (default 0). Confirmed counts are local deflection signals and nearby
animation attribution is approximate.

## Reproducing the dataset

```sh
# harvest markers from every animation in the game (needs the executor)
#   -> Veyra_parry_assets_full.json
python tools/import_parry_assets.py path/to/parry_assets_full.json \
    tests/data/parry_marker_residuals.json

# reduce a passive recording into the residual dataset
python tools/summarise_parry_obs.py path/to/Veyra_parry_obs.json

python -m unittest discover -s tests/unit
```

## Verified outcome counters

The calibration pulse is not marked successful until the client observes a
server-issued `State_Parrying` grant and reads its timing metadata. A sent
`Block Input` alone cannot establish calibration. `unobservedGrants` counts
ordinary parry attempts whose session expires without a visible grant; this is
not proof of server rejection. `successByAsset` counts confirmed local
`State_ParriedAttack` events attributed to the last scheduled attack. Where
multiple enemies overlap, asset attribution is approximate.

## Experimental attack release

The scheduler can request a synthetic M1 release before an inbound attack and
resume afterward via `AttackInput.send({Action="End Attack"})` and
`AttackInput.send({Action="Attack"})`. Combat tests have not verified that this
interrupts a held attack or improves parry success. A calibration grant is not
evidence of a successful combat parry.

## Auto Dodge

**Auto Dodge** is a separate toggle in the Combat tab. It exists because parry
cannot cover everything: it only presses for animations that have a profile, and
a whiff or a successful parry leaves `ParryCooldown` running for roughly a
second.

The division of labour is explicit in code. Auto Parry publishes three values
each frame: the soonest profiled impact (`impactIn`), why it cannot press
(`blockedReason`), and how long its cooldown still runs (`cooldownWait`). Auto
Dodge rolls only when parry provably cannot cover the hit:

| Situation | Who acts |
| --- | --- |
| Profiled attack, parry ready | Parry presses; dodge stays out |
| Profiled attack, cooldown ends before impact | Parry aims its press at the real expiry; dodge stays out |
| Profiled attack, cooldown outlives the impact | Dodge rolls |
| Animation with no profile (grabs, boss skills, unknown mobs) | Dodge rolls |
| Parry session already in flight | Nobody; a roll would cancel the pending parry |

Everything it uses was read from the recovered client sources, not guessed. A
roll is requested with `Packets.Combat.packets.RollInput.send({Action="Roll",
typeOf=""})`; the client uses `typeOf` only for the special dashes `Surge`,
`AirDash` and `Lightning Dash`, so a plain defensive roll sends an empty string.
The server answers on the same packet with `success` or `rejected`, and those
answers are counted instead of assuming a send worked. The gate is the game's own
`StateManager:CanDash()` (alive, no `DashCooldown`, not parried/occupied/stunned/
attacking/flying/incapacitated/using a skill/dodging/parrying), plus a safezone
and text-focus check.

Reaction clips (hit, parry, dodge, roll, locomotion) are filtered out, so an
NPC's flinch cannot trigger a roll. Rolls are spaced 0.55 s apart and back off
for 0.4 s after a rejection. Auto Dodge does not enable, disable, or replace Auto
Parry, and neither module touches the other's input.
