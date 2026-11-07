-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Flame.Bind
-- Class: ModuleScript
-- bytes: 1332

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local _ = Services_m.VFX
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include
local CurrentCamera = workspace.CurrentCamera

local function main(arg1, arg2, arg3) -- line: 19
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] GrimoireRarity_m (copy)
    --  [3] Utility_m (copy)
    --  [4] Services_m (copy)

    local _, v3 = CurrentCamera:WorldToScreenPoint(arg3.Position)

    if not v3 or (CurrentCamera.CFrame.Position - arg3.Position).Magnitude > 400 then
        return
    end

    local v4 = GrimoireRarity_m:GetPlayerVariant(arg2)

    if arg1 == "Origin" then
        local v5 = script.Indicator:Clone()
        v5.CFrame = CFrame.new(arg3.Position)
        GrimoireRarity_m:ApplyVariantEffect(v5, v4)
        v5.Parent = workspace.Effects
        Utility_m.EmitParticles(v5)
        Services_m.Debris(v5, 4)
    end
end

return main
