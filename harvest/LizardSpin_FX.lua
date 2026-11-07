-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.LizardBoss.LizardSpin_FX
-- Class: ModuleScript
-- bytes: 1614

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local VFX_m = require(Modules.Shared.VFX)
local _ = require(Modules.CameraShaker)
local _ = require(Modules.GrimoireRarity)
local ForgeVFX_m = require(Modules.Packages.ForgeVFX)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include
VFX_m.init()
local t = {}

return function(arg1, arg2, arg3, arg4) -- line: 24
    -- upvalues:
    --  [1] Services_m (copy)
    --  [2] t (copy)
    --  [3] ForgeVFX_m (copy)

    if arg2 and (arg2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 then
        return
    end

    if arg1 == "Start" then
        local v2 = script.Slash:Clone()
        Services_m.Debris(v2, 8)
        local Weld = Instance.new("Weld")
        Services_m.Debris(Weld, 8)
        Weld.Part0 = arg3
        Weld.Part1 = v2
        Weld.C0 = CFrame.new(0, -3, 0)
        Weld.Parent = arg3
        t[arg4 .. "Spin"] = v2
        t[arg4 .. "Weld"] = Weld
        v2.Parent = workspace.Effects
        ForgeVFX_m.enable(v2)

        return
    end

    if arg1 == "Update" then
        local v3 = t[arg4 .. "Spin"]
        local v4 = t[arg4 .. "Weld"]
        ForgeVFX_m.disable(v3)
        Services_m.Debris(v3, 3)
        Services_m.Debris(v4, 3)
    end
end
