-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Flame.Field
-- Class: ModuleScript
-- bytes: 2757

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local _ = Services_m.VFX
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local _ = _G.GetModule("Effects")
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include
local CurrentCamera = workspace.CurrentCamera

local function main(arg1, arg2, arg3) -- line: 21
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] GrimoireRarity_m (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] Services_m (copy)
    --  [5] Utility_m (copy)
    --  [6] TweenService (copy)
    --  [7] raycastParams (copy)

    local _, v3 = CurrentCamera:WorldToScreenPoint(arg3.Position)

    if not v3 or (CurrentCamera.CFrame.Position - arg3.Position).Magnitude > 400 then
        return
    end

    local v4 = GrimoireRarity_m:GetPlayerVariant(arg2)

    if arg1 == "Release" then
        local v5 = ReplicatedStorage.Effects.FireField:Clone()
        Services_m.Debris(v5, 4)
        v5.CFrame = arg3 * CFrame.new(0, -4, 0)
        Utility_m.Toggle(v5, false)
        GrimoireRarity_m:ApplyVariantEffect(v5, v4)
        v5.Parent = workspace.Effects
        Utility_m.EmitParticles(v5)
        local v6 = script.LandExpolosion:Clone()
        Services_m.Debris(v6, 2)
        v6.CFrame = arg3
        GrimoireRarity_m:ApplyVariantEffect(v6, v4)
        v6.Parent = workspace.Effects
        Utility_m.EmitParticles(v6)
        local v7 = script.Impact:Clone()
        v7.Parent = v6
        v7:Play()
        task.delay(0.75, function() -- line: 50
            -- upvalues:
            --  [1] v7 (copy)

            _G.FadeSound(v7)
        end)
        task.wait(0.5)
        TweenService:Create(
            v5.PointLight,
            TweenInfo.new(0.7, Enum.EasingStyle.Linear),
            { Brightness = 0 }
        ):Play()

        return
    end

    if arg1 == "Leap" then
        local v9 = ReplicatedStorage.Effects.Leap:Clone()
        v9.CFrame = arg3 * CFrame.new(0, -2, 0) * CFrame.Angles(
            0,
            -1.5707963267948966,
            0.5235987755982988
        )
        local v11 = workspace:Raycast(arg3.Position, Vector3.new(0, -10, 0), raycastParams)

        if v11 and v11.Instance then
        end

        GrimoireRarity_m:ApplyVariantEffect(v9, v4)
        v9.Parent = workspace.Effects
        Utility_m.EmitParticles(v9)
    end
end

return main
