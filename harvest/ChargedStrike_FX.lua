-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Misc.ChargedStrike_FX
-- Class: ModuleScript
-- bytes: 3582

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local VFX_m = require(Modules.Shared.VFX)
local CameraShaker_m = require(Modules.CameraShaker)
local _ = require(Modules.GrimoireRarity)
local ForgeVFX_m = require(Modules.Packages.ForgeVFX)
local CurrentCamera = workspace.CurrentCamera
local v2 = CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 19
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end)
local t = {}
VFX_m.init()
v2:Start()

local function main(s1: string, u1: userdata, n1: number, ...) -- line: 28
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] Services_m (copy)
    --  [4] t (copy)
    --  [5] ForgeVFX_m (copy)
    --  [6] v2 (copy)

    if not u1 or not u1.PrimaryPart then
        return
    end

    local Magnitude = (CurrentCamera.CFrame.Position - u1.PrimaryPart.Position).Magnitude

    if Magnitude > 400 then
        return
    end

    if s1 == "Charge" then
        local _ = u1.PrimaryPart
        local LeftLeg = u1:FindFirstChild("Left Leg")
        local v3 = ReplicatedStorage.Effects.Skills.ChargedStrike_FX.ChargingFX:Clone()
        Services_m.Debris(v3, 3)
        t[n1 .. "EnergyFX"] = v3
        v3.CFrame = CFrame.new(0, 0, 0)
        v3.Parent = LeftLeg:FindFirstChild("LeftFootAttachment")
        local v4 = t
        local v5 = n1 .. "Sizes"
        v4[v5] = t[n1 .. "Sizes"] or {}

        for _, val in v3:QueryDescendants("ParticleEmitter") do
            t[n1 .. "Sizes"][val] = val.Size
            local Size = val.Size
            val.Size = NumberSequence.new(0.5)
            _G.Tween(val, { 0.2, "Linear", Enum.EasingDirection.Out, 0, 0, true }, { Size = Size })
        end

        ForgeVFX_m.enable(v3)

        return
    end

    if s1 == "Strike" then
        local PrimaryPart_1 = u1.PrimaryPart
        local v7 = t[n1 .. "EnergyFX"]
        v7.Parent, v7.WorldPosition = workspace.Effects, v7.WorldPosition
        local v8 = t[n1 .. "Sizes"]

        for _, val_1 in v7:QueryDescendants("ParticleEmitter") do
            ForgeVFX_m.disable(val_1)
            local v9 = v8 and v8[val_1]
            val_1.Size = v9
        end

        t[n1 .. "Sizes"] = nil
        local v10 = ReplicatedStorage.Effects.Skills.ChargedStrike_FX.StrikeFX:Clone()
        Services_m.Debris(v10, 5)
        v10.CFrame = CFrame.lookAt(
            PrimaryPart_1.Position,
            PrimaryPart_1.Position + PrimaryPart_1.CFrame.LookVector
        ) * CFrame.new(0, 0, -5.5)
        v10.Parent = workspace.Effects
        v7.Parent = v10
        ForgeVFX_m.emit(v7)
        ForgeVFX_m.emit(v10)
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
        Services_m.Debris(ColorCorrectionEffect, 3)
        ColorCorrectionEffect.Parent = game.Lighting
        _G.Tween(
            ColorCorrectionEffect,
            { 0.085, "Linear", Enum.EasingDirection.Out, 0, 0, true },
            { Contrast = 1 }
        )

        if Magnitude < 100 then
            v2:ShakeOnce(2.5, 20, 0, 0.45)

            return
        end
    elseif s1 == "Cleanup" then
        if t[n1 .. "EnergyFX"] then
            t[n1 .. "EnergyFX"] = nil
        end

        if t[n1 .. "Sizes"] then
            t[n1 .. "Sizes"] = nil
        end
    end
end

return main
