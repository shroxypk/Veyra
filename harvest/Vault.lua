-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Vault
-- Class: ModuleScript
-- bytes: 2213

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local VaultBreaker = ReplicatedStorage.Effects.WeaponFX.VaultBreaker
local g_require_1 = require
local CurrentCamera = workspace.CurrentCamera
local v2 = g_require_1(ReplicatedStorage.Modules:FindFirstChild("CameraShaker")).new(Enum.RenderPriority.Camera.Value, function(
    arg1
) -- line: 13
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end)
v2:Start()
local Utility_m = require(ReplicatedStorage.Modules.Utility)

return function(arg2, arg3, ...) -- line: 20
    -- upvalues:
    --  [1] VaultBreaker (copy)
    --  [2] Utility_m (copy)
    --  [3] v2 (copy)

    if not arg2 or (arg2.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    local PrimaryPart = arg2.PrimaryPart

    if arg3 == "WindUp" then
        local v3 = VaultBreaker.Charge:Clone()
        v3.CFrame = arg2["Right Arm"].CFrame
        v3.Parent = workspace.Effects
        _G.Debris(v3, 4)
        Utility_m.CreateWeld(v3, arg2["Right Arm"]).C0 = CFrame.new(0, 1, 0)
        Utility_m.ParticleHandler(v3, true)
        task.wait(0.425)
        Utility_m.ParticleHandler(v3, false)

        return
    end

    if arg3 == "Strike" then
        local v5 = VaultBreaker.Follow:Clone()
        v5.CFrame = PrimaryPart.CFrame
        v5.Parent = workspace.Effects
        _G.Debris(v5, 3)
        Utility_m.CreateWeld(v5, PrimaryPart).C0 = CFrame.new(0, 0, 7.5)
        Utility_m.ParticleHandler(v5, true)
        task.delay(0.35, function() -- line: 50
            -- upvalues:
            --  [1] Utility_m (ref)
            --  [2] v5 (copy)

            Utility_m.ParticleHandler(v5, false)
        end)
        local BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.MaxForce = Vector3.new(200000, 50000, 200000)
        BodyVelocity.Velocity = PrimaryPart.CFrame.LookVector * 80
        BodyVelocity.Parent = PrimaryPart
        _G.Debris(BodyVelocity, 0.25)
        v2:ShakeOnce(7, 11, 0, 0.2)
    end
end
