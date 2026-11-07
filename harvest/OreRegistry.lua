-- Decompiled with Veyra harvester
-- Instance: Workspace.Map.Harvestable.HarvestController.OreRegistry
-- Class: ModuleScript
-- bytes: 1383

local t = {}
local t_1 = { Power = 5, Mineable = { Copper = 0.2, Stone = 0.4, Silver = 0.5 } }
t.Pebble = t_1
local t_3 = { Power = 5, Mineable = { Stone = 0.3, Silver = 0.3, Gold = 0.2, Copper = 0.2 } }
t["Stone Cluster"] = t_3
local t_5 = {
    Power = 10,
    Mineable = { Amber = 0.2, Stone = 0.1, Tin = 0.2, Gold = 0.2, Copper = 0.2, Steel = 0.1 }
}
t.Boulder = t_5
local t_7 = { Power = 10, Mineable = { Copper = 0.1, Amber = 0.3, Tin = 0.3, Steel = 0.3 } }
t["Ore Cluster"] = t_7
local t_9 = { Power = 15, Mineable = { Fungite = 0.8, Stone = 0.2 } }
t["Fungite Ore"] = t_9
local t_11 = { Power = 15, Mineable = { Moldstone = 0.2, Fungite = 0.2, Gloomium = 0.6 } }
t.Sporestone = t_11
local t_13 = { Power = 15, Mineable = { Fungite = 0.1, Gloomium = 0.4, Moldstone = 0.5 } }
t["Mossite Vein"] = t_13
local t_15 = {
    Power = 20,
    Mineable = { Stone = 0.3, Mournite = 0.2, Netherite = 0.2, Ashenstone = 0.3 }
}
t["Ashbound Rock"] = t_15
local t_17 = { Power = 30, Mineable = { Viridium = 0.4, Oblivium = 0.4, Ashenstone = 0.2 } }
t["Umbral Vein"] = t_17
local t_19 = { Power = 30, Mineable = { Stone = 0.2, Oblivium = 0.4, Viridium = 0.4 } }
t["Tainted Core"] = t_19
local t_21 = { Power = 40, Mineable = { Stone = 0.7, Witherclay = 0.3 } }
t["Wither Ore"] = t_21
local t_23 = { Power = 30, Mineable = { Stone = 0.7, Spectrite = 0.3 } }
t["Spectral Ore"] = t_23

return t
