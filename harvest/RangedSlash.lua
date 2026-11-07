-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Skills.RangedSlash
-- Class: ModuleScript
-- bytes: 2499

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local TweenService = Services_m.TweenService
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local _ = _G.GetModule("Effects")
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

return function(arg1, arg2, arg3, arg4) -- line: 18
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Utility_m (copy)
    --  [3] TweenService (copy)

    if arg1 == "Projectile" then
        local v2 = arg4 - workspace:GetServerTimeNow()

        if v2 <= 0 then
            return
        end

        local v3 = ReplicatedStorage.Effects.MagicFX.RangedSlashFX.SlashProjectile:Clone()
        _G.Debris(v3, 4)
        v3.CFrame = arg2
        v3.Parent = workspace.Effects
        Utility_m.Toggle(v3, true)
        local v5 = TweenService:Create(
            v3,
            TweenInfo.new(v2, Enum.EasingStyle.Linear),
            { Position = arg3 }
        )
        v5.Completed:Once(function() -- line: 33
            -- upvalues:
            --  [1] Utility_m (ref)
            --  [2] v3 (copy)

            Utility_m.Toggle(v3, false)
        end)
        v5:Play()

        return
    else
        if arg1 == "EmitSlash" then
            local v6 = ReplicatedStorage.Effects.MagicFX.RangedSlashFX.Slash:Clone()
            _G.Debris(v6, 4)
            v6.Parent = workspace.Effects
            v6.CFrame = arg2 * CFrame.new(0, 1, 0) * CFrame.Angles(0, -1.5707963267948966, 0)
            Utility_m.EmitParticles(v6)

            return
        end

        if arg1 == "Explosion" then
            local v8 = ReplicatedStorage.Effects.MagicFX.RangedSlashFX.SmallExpolosion:Clone()
            v8.Name = math.random()
            v8.CFrame = arg2
            v8.Parent = workspace.Effects
            Utility_m.EmitParticles(v8)
            _G.Debris(v8, 4)

            return
        end

        if arg1 == "Parried" then
            local v9 = ReplicatedStorage.Effects.MagicFX.RangedSlashFX.ParryExplosion:Clone()
            v9.Name = math.random()
            v9.CFrame = arg2
            v9.Parent = workspace.Effects
            Utility_m.EmitParticles(v9)
            _G.Debris(v9, 4)
        end

        return
    end
end
