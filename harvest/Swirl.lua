-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Skills.Swirl
-- Class: ModuleScript
-- bytes: 2433

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local _ = Services_m.TweenService
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

return function(arg1, arg2) -- line: 18
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Utility_m (copy)

    if (arg2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    if arg1 == "Swirl" then
        local v2 = ReplicatedStorage.Effects.MagicFX.Swirl.Tornado:Clone()
        v2.CFrame = arg2 * CFrame.Angles(0, 0, 0) * CFrame.new(0, -15, 0)
        local v4 = ReplicatedStorage.Effects.MagicFX.Swirl.SwirlCut:Clone()
        v4.CFrame = arg2 * CFrame.new(0, 1, 0) * CFrame.Angles(0, -1.5707963267948966, 0)
        v4.Parent = workspace.Effects
        Utility_m.Toggle(v2, true)
        Utility_m.EmitParticles(v4)
        _G.Tween(
            v2,
            { 0.25, "Linear", Enum.EasingDirection.Out, false, false, -1 },
            { Orientation = v2.Orientation + Vector3.new(0, 360, 0) }
        )
        _G.Tween(
            v2,
            { 0.3, "Linear", Enum.EasingDirection.Out },
            { Position = v2.Position + Vector3.new(0, 12, 0) }
        )
        v2.Parent = workspace.Effects
        task.delay(0.2, function() -- line: 39
            -- upvalues:
            --  [1] v2 (copy)

            for _, descendant in pairs(v2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    _G.Tween(
                        descendant,
                        { 0.2, "Linear", Enum.EasingDirection.In },
                        { Width0 = 0, Width1 = 0 }
                    )
                end
            end
        end)
        task.wait(0.4)

        for _, descendant_1 in v2:GetDescendants() do
            if not descendant_1:IsA("ParticleEmitter") then
                if descendant_1:IsA("Trail") then
                    descendant_1.Enabled = false
                end
            else
                descendant_1.Enabled = false
            end
        end

        _G.Debris({ v2, v4 }, 3)
    end
end
