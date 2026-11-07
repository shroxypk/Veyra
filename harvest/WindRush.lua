-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Wind.WindRush
-- Class: ModuleScript
-- bytes: 1449

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Lunge = ReplicatedStorage.Effects.WindFX.Lunge
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local CameraShaker_m = require(ReplicatedStorage.Modules:FindFirstChild("CameraShaker"))
local CurrentCamera = workspace.CurrentCamera
CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 14
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end):Start()
local Utility_m = require(ReplicatedStorage.Modules.Utility)

return function(arg2, arg3, ...) -- line: 21
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] Lunge (copy)
    --  [3] Utility_m (copy)

    if not arg2 or (arg2.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    local v3 = GrimoireRarity_m:GetPlayerVariant(arg2)

    if arg3 == "Start" then
        local PrimaryPart = arg2.PrimaryPart
        local v4 = Lunge.Start:Clone()
        v4.CFrame = PrimaryPart.CFrame * CFrame.new(0, 0, 4)
        GrimoireRarity_m:ApplyVariantEffect(v4, v3)
        v4.Parent = workspace.Effects
        _G.Debris(v4, 1.25)
        Utility_m.EmitParticles(v4)

        return
    end

    if arg3 == "" then
    end
end
