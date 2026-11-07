-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Rush
-- Class: ModuleScript
-- bytes: 2488

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local RelentlessRush = ReplicatedStorage.Effects.WeaponFX.RelentlessRush
local g_require_1 = require
local CurrentCamera = workspace.CurrentCamera
g_require_1(ReplicatedStorage.Modules:FindFirstChild("CameraShaker")).new(Enum.RenderPriority.Camera.Value, function(
    arg1
) -- line: 13
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end):Start()
local Effects = _G.GetModule("Effects")
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map }
raycastParams.FilterType = Enum.RaycastFilterType.Include

return function(arg2, arg3, ...) -- line: 26
    -- upvalues:
    --  [1] RelentlessRush (copy)
    --  [2] raycastParams (copy)
    --  [3] Effects (copy)
    --  [4] Utility_m (copy)

    if not arg2 or not arg2.PrimaryPart or (arg2.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    local PrimaryPart = arg2.PrimaryPart
    local _ = ...

    if arg3 == "rot" then
        local v3 = RelentlessRush.Rotate:Clone()
        v3.CFrame = PrimaryPart.CFrame
        v3.Parent = workspace.Effects
        _G.Debris(v3, 4)
        local v4 = workspace:Raycast(PrimaryPart.Position, Vector3.new(0, -10, 0), raycastParams)

        if v4 and v4.Instance then
            Effects:SetParticleColor(v3, v4.Instance.Color, "Ground")
        end

        Utility_m.ParticleHandler(v3, true)
        local BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.MaxForce = Vector3.new(200000, 50000, 200000)
        BodyVelocity.Parent = PrimaryPart

        repeat
            BodyVelocity.Velocity = PrimaryPart.CFrame.LookVector * 35
            v3.CFrame = PrimaryPart.CFrame
            task.wait()
        until tick() - tick() > 0.5

        BodyVelocity:Destroy()
        PrimaryPart.Velocity = Vector3.new(0, 0, 0)
        Utility_m.ParticleHandler(v3, false)

        return
    end

    if arg3 == "Final" then
        local v5 = RelentlessRush.Emit:Clone()
        v5.CFrame = PrimaryPart.CFrame * CFrame.Angles(0, 3.6651914291880923, 0)
        v5.Parent = workspace.Effects
        _G.Debris(v5, 3)
        Utility_m.EmitParticles(v5, 1)
    end
end
