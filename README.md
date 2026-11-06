# Veyra

A lightweight automation panel for Clover RPG.

## Load
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/shroxypk/Veyra/main/main.lua"))()
```

## Features
| Feature | Description |
|---------|-------------|
| **Auto Minigames** | Solves harvest & mining minigames |
| **Auto Gather** | Separate crop/ore navigation, obstacle replanning, optional experimental broom routes |
| **Auto Parry** | Times parries from animation data (180 profiles) |
| **Auto Dodge** | Rolls only when parry cannot cover the hit |
| **Quest Assistance** | Tracker + location map with pins |
| **Boss Attack Alerts** | Windup warnings for profiled bosses |
| **Broom Speed** | 1×–3× flight multiplier |

## Controls
Tabs group features into **Combat**, **Gathering**, **Movement**, **Guidance**, and **Settings**.

| Key | Action |
|-----|--------|
| Right Ctrl | Toggle panel |
| Delete | Minimize |
| Insert | Cycle size |
| End | Panic stop (disables all) |
*All rebindable in the Controls section.*

## Preferences
Saved to `Veyra/config.json` (geometry, hotkeys, ranges). Automation toggles always start **off**. `Reset Settings` restores defaults.

## Links
- [Gathering setup and limitations](docs/gathering.md)
- [Parry technical notes](docs/parry.md)
- [Combat research](docs/combat-research.md)
- [Diagnostics](docs/diagnostics.md)
