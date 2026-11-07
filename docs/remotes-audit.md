# Remotes & Attack-Surface Audit — Clover (place 8248288152)

Source: instance tree from `native-rs.rbxlx` (58 MB dump), harvested across
865 decompiled sources (`sources/`), 1,299 client-visible modules total.

## Remote inventory (125 remotes in `ReplicatedStorage.Remotes`)

All of these are live and reachable from the client. `Client` / `UpdateQuestLog`
subset (server→client) confirmed in tree; the rest below are client→server.

### Money/economy (client-triggerable, server-validated)
- `Player.ShopEvent` (RemoteFunction) — shop purchases
- `Player.SellEvent` — sell items ("SellOne")
- `Player.InventoryEvent` — inventory ops
- `Bank` (RemoteFunction) — "StartBanking"/"StopBanking"/"BuySlot"
- `Player.Consumables` — use items
- `Trades/trading` equivalents (Trading, ExchangeEvent, ClaimBeastReward)

### Social/Guild (highest-risk surface found)
- `Alliance` (RemoteFunction) — **"Invite", "Kick", "Promote", "Demote", "Disband",
  "Leave", "PurchaseUpgrade"** all InvokeServer'd directly from client code.
  → Each resolves guild membership **server-side** (Cmdr/guild service); but
  "Promote"/"Kick" style actions on *other* players are exactly where a missing
  ownership check becomes an exploit. These need args-audit per-call-site.
- `Player.UpdateParty` / `PartyRemoteFunction` — party state changes.

### Admin/debug remnants
- `Cmdr.Server commands.*` (killServer, kickServer, fetchServer, …): **server-side
  modules only**. Cmdr's dispatch goes through `CmdrFunction` RemoteFunction in
  `CmdrClient`, and admin commands carry a "admins" permission gate in the
  server command modules. No client-reachable privilege escalation seen.
- `Admin` (RemoteFunction in `Remotes`) — by-name admin surface, server-gated.

### Combat-adjacent (already live in veyra)
- `Combat` (RemoteEvent) — the combat channel our parry module uses
- `Roll`, `Block` (RemoteFunction), `Dodge` — parity/roll channels
- `NPC` (RemoteEvent) — NPC interaction channel
- `Ragdoll` / `Freeze` — state channels

## What's NOT visible client-side (by design)
- **Server Script bodies** (ServerScriptService / ServerStorage). The harvest
  can't recover them — sources aren't replicated. The path index (`stubs/`)
  maps *where the server references them* (752 skeleton paths) but no bodies.
- Anything in `ServerStorage.GameModules.*` (AttackNPCS, ZeroRagdoll, TagPlayers).

## Verdict for "backdoors"
No client-side shortcut to admin: every dangerous action (Kick/Promote/Disband/
BuySlot etc.) crosses a server-side handler that checks ownership/membership.
The client only supplies parameters; the server decides whether they're legal.
Cmdr admin commands are server modules — their code is not in the dump.
