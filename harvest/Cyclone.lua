-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Cyclone
-- Class: ModuleScript
-- bytes: 1557

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Cyclone = ReplicatedStorage.Effects.WeaponFX.Cyclone
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
    --  [1] Cyclone (copy)
    --  [2] Utility_m (copy)
    --  [3] v2 (copy)

    if not arg2 or not arg2.PrimaryPart or (arg2.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    local PrimaryPart = arg2.PrimaryPart

    if arg3 == "FX" then
        local v3 = Cyclone.FX:Clone()
        v3.CFrame = PrimaryPart.CFrame * CFrame.new(0, 2, 0)
        v3.Parent = workspace.Effects
        _G.Debris(v3, 3)
        Utility_m.EmitParticles(v3.Attachment, true)
        v2:ShakeOnce(2, 7, 0, 0.1)

        return
    end

    if arg3 == "Spark" then
        local v5 = Cyclone.FX:Clone()
        v5.CFrame = PrimaryPart.CFrame * CFrame.new(0, 2.5, 0)
        v5.Parent = workspace.Effects
        _G.Debris(v5, 2)
        Utility_m.EmitParticles(v5.Spark, true)
    end
end
