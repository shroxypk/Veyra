-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Light.Conviction
-- Class: ModuleScript
-- bytes: 1604

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local CurrentCamera = workspace.CurrentCamera
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local Effects = _G.GetModule("Effects")
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map }
raycastParams.FilterType = Enum.RaycastFilterType.Include

local function main(arg1, arg2, arg3) -- line: 18
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] GrimoireRarity_m (copy)
    --  [3] Services_m (copy)
    --  [4] Utility_m (copy)
    --  [5] Effects (copy)
    --  [6] ReplicatedStorage (copy)

    if (CurrentCamera.CFrame.Position - arg3.Position).Magnitude > 300 then
        return
    end

    local v2 = GrimoireRarity_m:GetPlayerVariant(arg2)
    local v3 = v2 and v2.Primary or Color3.fromRGB(255, 245, 165)

    if arg1 == "Explosion" then
        local v4 = script.FX:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v4, v2)
        v4.CFrame = arg3
        v4.Parent = workspace.Effects
        Services_m.Debris(v4, 2)
        Utility_m.EmitParticles(v4)
        Effects.AddLight(arg3, v3, 6, 1)
        Services_m.PlaySound(
            ReplicatedStorage.SFX.Explosions.Blast,
            arg3,
            150,
            0.25,
            Random.new():NextNumber(1.75, 2),
            nil
        )
    end
end

return main
