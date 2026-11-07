-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Lightning.Volt
-- Class: ModuleScript
-- bytes: 3207

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local CameraShaker_m = require(ReplicatedStorage.Modules:FindFirstChild("CameraShaker"))
local CurrentCamera = workspace.CurrentCamera
local v3 = CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 9
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end)
v3:Start()
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local Effects = _G.GetModule("Effects")
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.pCharacters, workspace.FightableNPCS }
raycastParams.FilterType = Enum.RaycastFilterType.Exclude

return function(arg2, arg3, arg4) -- line: 22
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] CurrentCamera (copy)
    --  [3] Utility_m (copy)
    --  [4] Services_m (copy)
    --  [5] ReplicatedStorage (copy)
    --  [6] raycastParams (copy)
    --  [7] Effects (copy)
    --  [8] v3 (copy)

    local v4 = GrimoireRarity_m:GetPlayerVariant(arg3)
    local Magnitude = (CurrentCamera.CFrame.Position - arg4.Position).Magnitude

    if Magnitude > 400 then
        return
    end

    if arg2 == "Place" then
        local v5 = script.Lightning:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v5, v4)
        v5:PivotTo(CFrame.new(arg4.Position + Vector3.new(0, v5.Lightning.Size.Y / 2, 0)))
        v5.Parent = workspace.Effects
        Utility_m.EmitParticles(v5.Lightning.BeamShot)
        Services_m.PlaySound(
            ReplicatedStorage.SFX.Effects.LightningStatic,
            arg4,
            200,
            0.75,
            nil,
            nil
        )
        Services_m.Debris(v5, 4)

        return
    end

    if arg2 == "Origin" then
        local v6 = script.Indicator:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v6, v4)
        v6.CFrame = CFrame.new(arg4.Position)
        v6.Parent = workspace.Effects
        Utility_m.EmitParticles(v6)
        Services_m.Debris(v6, 4)

        return
    end

    if arg2 == "Explosion" then
        local v7 = script.Lightning:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v7, v4)
        v7:PivotTo(CFrame.new(arg4.Position + Vector3.new(0, 1.75, 0)))
        v7.Parent = workspace.Effects
        local v8 = workspace:Raycast(arg4.Position, Vector3.new(0, -15, 0), raycastParams)

        if v8 and v8.Instance then
            local Material = v8.Material
            Effects:SetParticleColor(
                v7,
                v8.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(Material) or v8.Instance.Color,
                "RocMis"
            )
        end

        Utility_m.EmitParticles(v7)

        if Magnitude < 100 then
            v3:ShakeOnce(4, 7, 0, 0.2)
        end

        Services_m.PlaySound(
            ReplicatedStorage.SFX.Effects.Thunder_Explosion,
            arg4,
            200,
            0.85,
            nil,
            nil
        )
        Services_m.Debris(v7, 5)
    end
end
