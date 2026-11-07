-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Flame.BurstPistol
-- Class: ModuleScript
-- bytes: 2560

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local VFX = Services_m.VFX

function EnableProjectile(arg1, arg2) -- line: 11
    -- upvalues:
    --  [1] VFX (copy)

    VFX.Enable(arg1.Attachment, arg2)
    arg1.Trail.Trail.Enabled = arg2
end

local function main(arg3, arg4, arg5) -- line: 17
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] VFX (copy)
    --  [3] Services_m (copy)

    local v2 = arg4

    if v2 then
        v2 = arg4.PrimaryPart
    end

    if not v2 or (v2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    v2 = GrimoireRarity_m:GetPlayerVariant(arg4)

    if arg3 == "WindUp" then
        local v3 = script.WindUp.Attachment:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v3, v2)
        v3.Parent = arg4["Left Arm"]
        v3.Sound:Play()
        VFX.Emit2(v3)
        Services_m.Debris(v3, 4)

        return
    end

    if arg3 == "Explosion" then
        local v4 = script.Projectile:Clone()
        EnableProjectile(v4, false)
        GrimoireRarity_m:ApplyVariantEffect(v4, v2)
        v4.CFrame = arg5
        v4.Parent = workspace.Effects
        VFX.Emit2(v4.Impact)
        v4.Sound:Play()
        _G.Tween(v4.PointLight, { 0.7, "Quad", "Out" }, { Range = 20, Brightness = 0 })
        local Magnitude = (v4.Position - Services_m.Players.LocalPlayer.Character.PrimaryPart.Position).Magnitude

        if Magnitude <= 50 and Magnitude <= 20 then
            local BloomEffect = Instance.new("BloomEffect")
            BloomEffect.Intensity = 3.3
            BloomEffect.Size = 25
            BloomEffect.Threshold = 1.5
            BloomEffect.Parent = workspace.CurrentCamera
            _G.Tween(BloomEffect, { 0.321, "Quad", "In" }, { Intensity = 0 })
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
            ColorCorrectionEffect.Contrast = 0.2
            ColorCorrectionEffect.Saturation = 0.5
            ColorCorrectionEffect.Parent = workspace.CurrentCamera
            _G.Tween(
                ColorCorrectionEffect,
                { 0.256, "Quad", "In" },
                { Contrast = 0, Saturation = 0 }
            )
            Services_m.Debris({ BloomEffect, ColorCorrectionEffect }, 1)
        end

        Services_m.Debris(v4, 2)
    end
end

return main
