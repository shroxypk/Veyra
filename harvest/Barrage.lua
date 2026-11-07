-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Skills.Barrage
-- Class: ModuleScript
-- bytes: 1916

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Utility_m = require(Services_m.ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

return function(arg1, arg2, arg3) -- line: 17
    -- upvalues:
    --  [1] Utility_m (copy)

    if arg1 == "Slash" then
        local v2 = script.SlashProjectile:Clone()
        v2.CFrame = arg2 * CFrame.Angles(0, 0, (math.rad(arg3)))
        v2.Parent = workspace.Effects
        Utility_m.Toggle(v2, true)
        local v3 = script.Floor:Clone()
        v3.CFrame = arg2 * CFrame.new(0, -2.5, 0)
        v3.Parent = workspace.Effects
        Utility_m.EmitParticles(v3)
        local t = { CFrame = nil }
        local Tween = _G.Tween
        local t_1 = { 0.1, "Linear", Enum.EasingDirection.Out }
        t.CFrame = v2.CFrame * CFrame.new(0, 0, -6)
        Tween(
            v2,
            t_1,
            t,
            false,
            true
        )
        task.wait(0.1)

        for _, descendant in v2:GetDescendants() do
            if not descendant:IsA("ParticleEmitter") then
                if descendant:IsA("Trail") then
                    descendant.Enabled = false
                end
            else
                descendant.Enabled = false
            end
        end

        Utility_m.EmitParticles(v2)

        for _, descendant_1 in v2:GetDescendants() do
            if descendant_1:IsA("Beam") then
                _G.Tween(
                    descendant_1,
                    { 0.2, "Linear", Enum.EasingDirection.In },
                    { Width0 = 0, Width1 = 0 }
                )
            end
        end

        _G.Debris({ v2, v3 }, 4)
    end
end
