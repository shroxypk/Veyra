-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Crits.Wolfcrest_FX
-- Class: ModuleScript
-- bytes: 4704

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
local _ = require(Modules.Utility)
local PartJoiner_m = require(script.PartJoiner)
local CurrentCamera = workspace.CurrentCamera
local v2 = CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 22
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end)
local t = {}
VFX_m.init()
v2:Start()

return function(s1: string, u1: userdata, n1: number) -- line: 31
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] t (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] Services_m (copy)
    --  [5] PartJoiner_m (copy)
    --  [6] ForgeVFX_m (copy)
    --  [7] v2 (copy)

    if (u1.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 300 then
        return
    end

    local v3 = t[n1] or {}
    local Magnitude = (CurrentCamera.CFrame.Position - u1.PrimaryPart.Position).Magnitude
    t[n1] = v3

    if s1 == "Windup" then
        local PrimaryPart = u1.PrimaryPart
        v3 = ReplicatedStorage.Effects.Skills.Wolfcrest_FX.Windup:Clone()
        Services_m.Debris(v3, 8)
        v3:PivotTo(PrimaryPart.CFrame * CFrame.Angles(0, 0, 1.5707963267948966))
        v3.Parent = workspace.Effects
        local WeldConstraint = Instance.new("WeldConstraint")
        WeldConstraint.Part0 = v3:FindFirstChild("Base")
        WeldConstraint.Part1 = PrimaryPart
        WeldConstraint.Parent = v3:FindFirstChild("Base")
        local v6 = ReplicatedStorage.Effects.Skills.Wolfcrest_FX.WeaponAura:Clone()
        v6.CFrame = v6.CFrame * (CFrame.new(0, 0, 1) * CFrame.Angles(0, 1.5707963267948966, 0))
        v6.Parent = u1:QueryDescendants("Motor6D#Handle")[1].Parent
        Services_m.Debris(v6, 8)
        local Blade = u1:FindFirstChild("Blade", true)
        local v8 = ReplicatedStorage.Effects.Skills.Wolfcrest_FX.Fake_Blade:Clone()
        v8.CFrame = Blade.CFrame
        v8.Transparency = 1
        PartJoiner_m.Weld(v8, Blade)
        v8.Parent = workspace.Effects
        _G.Tween(v8, { 0.4, "Linear", "Out" }, { Transparency = 0 })
        ForgeVFX_m.emit(v6:FindFirstChild("EnergyBladeActivate"))
        ForgeVFX_m.enable(v6:FindFirstChild("EnergyBladeEnable"))
        ForgeVFX_m.emit(v3)
        Services_m.PlaySound(ReplicatedStorage.SFX.Crits.WolfcrestCrit, PrimaryPart)
        t[n1].Windup = v3
        t[n1].Charge = v6
        t[n1].Blade = v8

        return
    end

    if s1 == "Slash" then
        local Windup = t[n1].Windup
        local Charge = t[n1].Charge
        local Blade_1 = t[n1].Blade
        local PrimaryPart_1 = u1.PrimaryPart

        if Windup then
            Windup:Destroy()
        end

        if Charge then
            Charge:Destroy()
        end

        if Blade_1 then
            _G.Tween(Blade_1, { 0.4, "Quad", "Out" }, { Transparency = 1 })
            Services_m.Debris(Blade_1, 1)
        end

        local v9 = ReplicatedStorage.Effects.Skills.Wolfcrest_FX.Slash:Clone()
        Services_m.Debris(v9, 8)
        v9:PivotTo(PrimaryPart_1.CFrame)
        v9.Parent = workspace.Effects
        ForgeVFX_m.emit(v9)
        local ClawBase = v9:FindFirstChild("Claw_Base", true)
        local t_1 = { CFrame = nil }
        local Tween = _G.Tween
        t_1.CFrame = ClawBase.CFrame * CFrame.Angles(0, -3.141592653589793, 0)
        Tween(ClawBase, { 0.35, "Linear", "Out" }, t_1)
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
        end

        t[n1].Slash = v9

        return
    end

    if s1 == "Cleanup" and t[n1] then
        local Blade_2 = t[n1].Blade

        if Blade_2 and Blade_2.Parent then
            _G.Tween(Blade_2, { 0.4, "Quad", "Out" }, { Transparency = 1 })
            Services_m.Debris(Blade_2, 1)
        end

        for key, val in t[n1] do
            if key ~= "Blade" then
                val:Destroy()
            end
        end

        t[n1] = nil
    end
end
