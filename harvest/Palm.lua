-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Wind.Palm
-- Class: ModuleScript
-- bytes: 1752

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = Services_m.VFX
local Tempest = ReplicatedStorage.Effects.WindFX.Tempest
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local Utility_m = require(ReplicatedStorage.Modules.Utility)

local function main(arg1, arg2) -- line: 14
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] Tempest (copy)
    --  [3] Services_m (copy)
    --  [4] Utility_m (copy)
    --  [5] ReplicatedStorage (copy)

    local v2 = arg2

    if v2 then
        v2 = arg2.PrimaryPart
    end

    if not v2 or (v2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 300 then
        return
    end

    local v3 = GrimoireRarity_m:GetPlayerVariant(arg2)

    if arg1 == "FX" then
        local v4 = Tempest.TempestSEmit:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v4, v3)
        v4.CFrame = v2.CFrame * CFrame.new(0, 1.5, 0) * CFrame.Angles(0, 0, 0)
        v4.Parent = workspace.Effects
        Services_m.Debris(v4, 2)
        Utility_m.EmitParticles(v4)
        Services_m.PlaySound(
            ReplicatedStorage.SFX.Skills.WooshExplosion,
            v2,
            nil,
            nil,
            nil,
            0.1
        )

        return
    end

    if arg1 == "FX2" then
        local v7 = Tempest.TempestSmall:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v7, v3)
        v7.CFrame = v2.CFrame * CFrame.new(0, 1, 0) * CFrame.Angles(0, 0, 0)
        v7.Parent = workspace.Effects
        Services_m.Debris(v7, 2)
        Utility_m.EmitParticles(v7)
    end
end

return main
