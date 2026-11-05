# Clover RPG combat research

Reviewed 2026-11-04 using public wiki pages and local source. No game-client
execution or combat input was used for this review. Wiki statements below are
community reports, not independently verified server behavior. The changelog
page does not identify a dated build for the listed changes.

## Findings and implementation implications

| Reported mechanic | Source | Current implementation / implication |
| --- | --- | --- |
| Holding F blocks; blocked attacks build posture and can cause guardbreak and stun. | [Combat Mechanics](https://cloverrpg.fandom.com/wiki/Combat_Mechanics) | The unknown-attack hold has no posture check. A 1.5-second cap does not establish that holding is beneficial. Need the actual posture representation and attack blockability before relying on this fallback. |
| F immediately before impact is a parry. | Combat Mechanics | Supports the timed-block model, but supplies no numeric window or network timing. Existing measured constants remain session-specific evidence. |
| Misdirect cancels a basic attack before it lands. | Combat Mechanics | Animation motion is not proof an impact will occur. Existing authored feint gates cover some profiles; derived profiles have no cancellation gate. |
| Blocking is unavailable during Misdirect. | [Changelog](https://cloverrpg.fandom.com/wiki/Changelog) | Normal readiness delegates to CanParry. The cooldown-expiry exception manually reconstructs eligibility; verify that it includes every current predicate before treating it as equivalent. Do not invent a state name from the wiki term. |
| Failed parries cause a short period in which attacks and abilities are unavailable; rolling is unaffected. | Changelog | False-positive inputs cost more than cooldown alone. The idle calibration pulse and guesses for unknown animations can incur this penalty. Exact end-lag duration is undocumented here. |
| Only one mob at a time may use skills and grabs against a player. | Changelog | This does not say basic attacks cannot overlap. Do not replace multi-attacker scheduling with a universal single-attacker assumption. |
| Mushknight's close-range sequence includes grabs; its dash can guardbreak held block while being parryable; its ground slam is described as parryable. The page warns of an unparryable move in the sequence. | [Mushknight](https://cloverrpg.fandom.com/wiki/Mushknight) | Requires per-move classification. The wiki uses informal move names and supplies neither animation IDs nor impact times. It cannot justify blacklisting a particular ID or the whole mob. |
| Basic and critical attacks differ by weapon. | Combat Mechanics | Model/weapon context may matter even where an animation ID is shared. |
| Endurance increases maximum resolve; resolve's detailed behavior is marked TBA. | [BloxInformer Stats](https://bloxinformer.com/wikis/clover-rpg/stats/) | Do not infer a posture/resolve conversion, guardbreak threshold or resource formula from this page. |

## Coverage and source limitations

- [Monsters](https://cloverrpg.fandom.com/wiki/Monsters) provides a regional
  inventory including melee creatures, archers and casters, not a complete
  attack catalog. Animation release time is not automatically projectile
  arrival time.
- [Alke](https://cloverrpg.fandom.com/wiki/Alke) and
  [Blightseeker](https://cloverrpg.fandom.com/wiki/Blightseeker) have WIP movesets.
  These pages do not validate the current pose-derived profiles.
- [BloxInformer overview](https://bloxinformer.com/wikis/clover-rpg/) supplies
  game context but still contains pre-release wording. Treat page freshness
  separately from the apparent currency of its navigation or player counts.
- The public pages reviewed do not establish exact hitboxes, attack-ID mappings,
  targeting attributes, parry windows, invulnerability duration or latency rules.

## Local code audit

1. **Unknown means unknown.** `attackLike` accepts generic non-looping animations
   based on duration and excluded names. That can include non-attacks. The
   fallback immediately treats accepted clips as potential blocking targets.
2. **Timing and defense type are separate.** Profiles currently supply hits,
   length and optional feint gates/offsets; they do not prove parryability or
   distinguish grabs, guardbreaking attacks and projectiles.
3. **Threat geometry is approximate.** `incoming` accepts distance below eight
   studs before checking configured range. Thus a six-stud setting can still
   react between six and eight studs. Neither proximity nor facing establishes
   the attack's target or hitbox overlap.
4. **Cooldown anticipation needs current eligibility evidence.** Reconstructing
   only known CanParry predicates can become stale when combat rules change.
5. **Pose validation has an optimistic metric.** Nearest predicted hit per
   reference impact does not penalize extra guesses or one guess matched to
   multiple hits. The 23/26 comparison is not a success rate.
6. **A generic cluster is not guaranteed coverage.** Adjacent peaks within 0.28s
   can chain into a span longer than the measured 0.25s window. A midpoint
   cannot be assumed to protect every constituent hit.

## Next evidence-driven work

| Priority | Work | Evidence needed |
| --- | --- | --- |
| 1 | Separate known parryable, known unblockable and unknown moves. | Verified mob/move/animation associations and defense outcomes; wiki names alone are insufficient. |
| 2 | Reassess unknown holds and idle calibration. | Posture semantics, guardbreak behavior and failed-parry recovery. Favor fewer false inputs over claiming universal first-swing protection. |
| 3 | Correct locally provable geometry and evaluation issues. | Offline boundary tests for configured range; one-to-one timing matching with false-positive and missed-hit counts. |
| 4 | Validate cooldown readiness and cancellations. | Current authoritative predicates or an authorized test environment; no speculative state names. |
| 5 | Validate timing independently. | Separate tuning and validation samples, including interruptions, different speeds and multi-mob situations. Report per-attack results, not just aggregate nearest-hit error. |

An authorized test environment with server hit/grant timestamps would resolve
many remaining uncertainties. A public wiki cannot establish ban-free executor
use or flawless defense in a live server.
