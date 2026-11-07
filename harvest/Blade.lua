-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Wind.Blade
-- Class: ModuleScript
-- bytes: 2356

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.HttpService
local VFX = Services_m.VFX
local CameraShaker_m = require(ReplicatedStorage.Modules:FindFirstChild("CameraShaker"))
local CurrentCamera = workspace.CurrentCamera
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 13
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end):Start()
local _ = require(ReplicatedStorage.Modules.Utility)

local function main(arg2, arg3, arg4) -- line: 20
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] GrimoireRarity_m (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] VFX (copy)
    --  [5] Services_m (copy)

    if (CurrentCamera.CFrame.Position - arg4.Position).Magnitude > 300 then
        return
    end

    local v3 = GrimoireRarity_m:GetPlayerVariant(arg3)

    if arg2 == "Explosion" then
        local v4 = ReplicatedStorage.Effects.WindFX.WindSlice.Projectile:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v4, v3)
        v4.CFrame = arg4
        v4.Parent = workspace.Effects
        VFX.Emit2(v4.Impact)
        v4.sound:Play()
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
