-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.BlightBoss.RangedSkill2
-- Class: ModuleScript
-- bytes: 2108

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Utility_m = require(ReplicatedStorage.Modules.Utility)

return function(arg1, arg2, arg3) -- line: 13
    -- upvalues:
    --  [1] Utility_m (copy)
    --  [2] ReplicatedStorage (copy)

    if (arg2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 or not arg3 then
        return
    end

    if arg1 == "HandAura" then
        local v2 = script.HandAura:Clone()
        local v3 = Utility_m.CreateWeld(arg3["Left Arm"], v2)
        v2.Parent = workspace.Effects
        Utility_m.Toggle(v2, true)
        task.wait(0.5)
        Utility_m.Toggle(v2, false)
        _G.Debris(v2, 2)
        _G.Debris(v3, 0.4)

        return
    end

    if arg1 == "EmitEye" then
        local v4 = script.EyeEmit:Clone()
        v4.CFrame = arg2 * CFrame.new(0, 5, 0)
        v4.Parent = workspace.Effects
        Utility_m.EmitParticles(v4)
        local v5 = script.GroundEmit:Clone()
        v5.CFrame = arg3.PrimaryPart.CFrame * CFrame.new(0, -arg3.PrimaryPart.Size.Y / 2, 0)
        v5.Parent = workspace.Effects
        Utility_m.EmitParticles(v5)
        local v7 = ReplicatedStorage.Effects.Ball:Clone()
        v7.CFrame = v4.CFrame
        v7.Color = Color3.fromRGB(255, 85, 0)
        v7.Transparency = 0.5
        v7.Size = Vector3.new(5, 5, 5)
        v7.Material = Enum.Material.ForceField
        v7.Parent = workspace.Effects
        _G.Tween(
            v7,
            { 0.3, "EntranceExpressive", Enum.EasingDirection.Out },
            { Size = Vector3.new(100, 100, 100), Transparency = 1 },
            true
        )
        _G.Debris({ v4, v5 }, 3)

        return
    end

    if arg1 == "Eye" then
        local v8 = script.Eye:Clone()
        v8.CFrame = arg2 * CFrame.new(0, 5, 0)
        v8.Parent = workspace.Effects
        Utility_m.Toggle(v8, true)
        task.wait(1.5)
        Utility_m.Toggle(v8, false)
        _G.Debris(v8, 0.2)
    end
end
