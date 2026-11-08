# Capability matrix — what is actually reachable from the client

Evidence gathered from the place dump (`place 8248288152`), the 865-file
decompiled harvest, the 752-path server reference index, and live probes.
Every row is either **verified working** or **verified impossible**; nothing
here is speculative.

## Authority model

The server owns every state that matters:

| State | Owner | Client sees |
|---|---|---|
| Damage / hit registration | Server | `State_*` attributes only |
| `State_Attacking`, `State_Blocking`, `State_Dodging` | Server | replicated attributes |
| Parry grant (`State_Parrying`) | Server | attribute + `StateEnd_Parrying` |
| Economy, items, currency | Server | display values only |
| Position / physics | Server (anti-desync) | local prediction, corrected |

The client sends *intent* packets; the server validates and applies. There is
no client-side path that writes authoritative state.

## What works (and is what the module does)

| Capability | Mechanism | Status |
|---|---|---|
| Read mob attack animations | `Animator.AnimationPlayed` + pose keyframes | ✅ used |
| Predict impact time | profile `hits` + track `TimePosition`/`Speed` | ✅ used |
| Timed parry | `BlockInput` `"Block Input"` / `"End Block"` | ✅ verified 9/9 standing |
| Timed dodge | `RollInput` `"Roll"` / `"Cancel"` | ✅ used |
| AoE → roll routing | name keywords + learned flags | ✅ used |
| Chain coverage planning | forward simulation of parry vs roll | ✅ C16 |
| Minigame key/mouse taps | `VirtualInputManager` | ✅ separate module |
| Read every replicated module source | decompile via executor | ✅ 865 files |
| Enumerate remotes | `Remotes` folder walk | ✅ 125 remotes |

## What does not work (verified)

| Attempt | Result | Why |
|---|---|---|
| `AttackInput` with `"Attack"` / `"End Attack"` | **inert** — no swing, no state change | those action strings do not exist; only `LightAttack`, `HeavyAttack`, `Uppercut`, `Slam` are real |
| `AttackInput` with a real action from the executor | **no swing** | the server accepts the packet shape but the swing is driven by the game's own input/state path |
| Cancel a swing to parry mid-combo | **impossible** | no cancel action exists; `CanBlock` refuses while `Attacking`, for humans too |
| Write `State_*` attributes to fake a parry | **kick** | server rejects client-authored state |
| Read server `Script` bodies | **impossible** | never compiled client-side, never replicated |
| Teleport / position writes | **server-corrected** | position is authoritative |
| Economy edits via remotes | **server re-validates** | see `docs/remotes-audit.md` |

## Detection surface

The server sees packet *cadence*, not just packet content. Sending actions
outside the game's own input path is observable — the mid-session kick
happened while injecting packets, not while running the timing-only modules.

The timing-only modules (`auto_parry`, `auto_dodge`, `minigames`) send the
same packets a human sends, at human-plausible rates. That is the ceiling:
**same intent, better timing**. There is no safe path above it.

## Conclusion

The assistant is at the maximum the client can safely reach. Further "bypass"
work is either inert (packets the server ignores) or detected (state writes,
position writes). The remaining gains are timing accuracy and coverage, not
privilege.
