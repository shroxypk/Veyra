-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.BlightBoss.BlightClaws
-- Class: ModuleScript
-- bytes: 2092

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local _ = Services_m.TweenService
local Utility_m = require(Services_m.ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

return function(arg1, arg2, arg3) -- line: 18
    -- upvalues:
    --  [1] Utility_m (copy)

    if (arg2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 or not arg3 then
        return
    end

    if arg1 == "Slash" then
        local v2 = script.DoubleClaw:Clone()
        v2.CFrame = arg2 * CFrame.new(0, -4, 0) * CFrame.Angles(0, 0, 0)
        v2.Parent = workspace.Effects
        Utility_m.EmitParticles(v2)
        local v4 = script.GroundEmit:Clone()
        v4.CFrame = arg2 * CFrame.new(0, -2.5, 0)
        v4.Parent = workspace.Effects
        Utility_m.EmitParticles(v4)
        _G.Debris({ v2, v4 }, 2)

        return
    end

    if arg1 == "Projectiles" then
        local function createProjectile() -- line: 35
            -- upvalues:
            --  [1] arg2 (copy)
            --  [2] Utility_m (ref)

            local v5 = math.random(50, 80)
            local Position = (arg2 * CFrame.new(math.random(-15, 15), math.random(-2, 2), -v5)).Position
            local _ = (arg2.Position - Position).Magnitude
            local v9 = script.Projectile:Clone()
            v9.CFrame = arg2 * CFrame.new(math.random(-10, 10), math.random(-4, 4), -5)
            v9.Parent = workspace.Effects
            Utility_m.Toggle(v9, true)
            _G.Tween(
                v9,
                { 0.4, "Linear", Enum.EasingDirection.Out },
                { Position = Position },
                false,
                true
            )
            Utility_m.Toggle(v9, false)
            _G.Debris(v9, 1)
        end

        for _ = 1, 12 do
            task.spawn(createProjectile)
        end
    end
end
