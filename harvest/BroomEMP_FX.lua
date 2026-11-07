-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Utility.BroomEMP_FX
-- Class: ModuleScript
-- bytes: 1885

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local VFX_m = require(Modules.Shared.VFX)
local CameraShaker_m = require(Modules.CameraShaker)
local ForgeVFX_m = require(Modules.Packages.ForgeVFX)
local CurrentCamera = workspace.CurrentCamera
local v2 = CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 17
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end)
VFX_m.init()
v2:Start()

local function main(u1: userdata) -- line: 24
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] Services_m (copy)
    --  [3] ForgeVFX_m (copy)
    --  [4] v2 (copy)

    if not u1 or (u1.PrimaryPart.Position - CurrentCamera.CFrame.Position).Magnitude > 500 then
        return
    end

    local Magnitude = (CurrentCamera.CFrame.Position - u1.PrimaryPart.Position).Magnitude
    local v3 = script.EMP:Clone()
    v3:PivotTo(u1.PrimaryPart.CFrame)
    local WeldConstraint = Instance.new("WeldConstraint")
    WeldConstraint.Part0 = v3
    WeldConstraint.Part1 = u1.PrimaryPart
    WeldConstraint.Parent = v3
    v3.Parent = workspace.Effects
    Services_m.Debris(v3, 4)
    Services_m.PlaySound(script.EMP_Sound, v3)
    ForgeVFX_m.emit(v3)

    if Magnitude < 100 then
        v2:ShakeOnce(4, 8, 0, 0.4)
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
        Services_m.Debris(ColorCorrectionEffect, 3)
        ColorCorrectionEffect.Parent = game.Lighting
        _G.Tween(
            ColorCorrectionEffect,
            { 0.085, "Linear", Enum.EasingDirection.Out, 0, 0, true },
            { Contrast = 1 }
        )
    end
end

return main
