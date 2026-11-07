-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Flurry
-- Class: ModuleScript
-- bytes: 1481

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Flurry = ReplicatedStorage.Effects.WeaponFX.Flurry
local g_require_1 = require
local CurrentCamera = workspace.CurrentCamera
g_require_1(ReplicatedStorage.Modules:FindFirstChild("CameraShaker")).new(Enum.RenderPriority.Camera.Value, function(
    arg1
) -- line: 13
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end):Start()
local Utility_m = require(ReplicatedStorage.Modules.Utility)

return function(arg2, arg3, ...) -- line: 20
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Flurry (copy)
    --  [3] Utility_m (copy)

    if not arg2 or not arg2.PrimaryPart or (arg2.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    local PrimaryPart = arg2.PrimaryPart

    if arg3 == "Lunges" then
        return
    end

    if arg3 == "Strike" then
        _G.PlaySound(
            ReplicatedStorage.SFX.Sword.Swing1,
            PrimaryPart,
            200,
            0.7,
            1.5,
            nil
        )
        local v2 = Flurry.Emit:Clone()
        v2.CFrame = PrimaryPart.CFrame * CFrame.new(0.75, 0.125, -4.5)
        v2.Parent = workspace.Effects
        _G.Debris(v2, 2)
        Utility_m.EmitParticles(v2, 2)
    end
end
