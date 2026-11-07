-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Flourish
-- Class: ModuleScript
-- bytes: 1884

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local FlurryFinish = ReplicatedStorage.Effects.WeaponFX.FlurryFinish
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
    --  [2] FlurryFinish (copy)
    --  [3] Utility_m (copy)

    if not arg2 or (arg2.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 300 then
        return
    end

    local PrimaryPart = arg2.PrimaryPart

    if arg3 == "Slash" then
        _G.PlaySound(
            ReplicatedStorage.SFX.Sword.Swing1,
            PrimaryPart,
            200,
            0.7,
            1.25,
            nil
        )
        local v2 = FlurryFinish.Slash:Clone()
        v2.CFrame = PrimaryPart.CFrame * CFrame.Angles(0, 3.6651914291880923, 0)
        v2.Parent = workspace.Effects
        _G.Debris(v2, 2)
        Utility_m.EmitParticles(v2, 1)

        return
    end

    if arg3 == "Strike" then
        _G.PlaySound(
            ReplicatedStorage.SFX.Skills.Flurry,
            PrimaryPart,
            200,
            0.7,
            nil,
            nil
        )
        local v4 = FlurryFinish.Emit:Clone()
        v4.CFrame = PrimaryPart.CFrame * CFrame.new(0.75, 0.125, -4.5)
        v4.Parent = workspace.Effects
        _G.Debris(v4, 2)
        Utility_m.EmitParticles(v4, 1)
    end
end
