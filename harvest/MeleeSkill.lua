-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.BlightBoss.MeleeSkill
-- Class: ModuleScript
-- bytes: 1946

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

    if (arg2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 or not arg3 then
        return
    end

    if arg1 == "Slash" then
        local v2 = script.RightClaw:Clone()
        v2.CFrame = arg2 * CFrame.new(0, -2.5, 0) * CFrame.Angles(0, 0, 0)
        v2.Parent = workspace.Effects
        Utility_m.EmitParticles(v2)
        _G.Debris(v2, 2)

        return
    end

    if arg1 == "Slash2" then
        local v4 = script.LeftClaw:Clone()
        v4.CFrame = arg2 * CFrame.new(0, -2.5, 0) * CFrame.Angles(0, 0, 0)
        v4.Parent = workspace.Effects
        Utility_m.EmitParticles(v4)
        _G.Debris(v4, 2)

        return
    end

    if arg1 == "Slash3" then
        local v6 = script.DoubleClaw:Clone()
        v6.CFrame = arg2 * CFrame.new(0, -2.5, 0) * CFrame.Angles(0, 0, 0)
        v6.Parent = workspace.Effects
        Utility_m.EmitParticles(v6)
        local v8 = script.GroundEmit:Clone()
        v8.CFrame = arg3.PrimaryPart.CFrame * CFrame.new(0, -arg3.PrimaryPart.Size.Y / 2, 0)
        v8.Parent = workspace.Effects
        Utility_m.EmitParticles(v8)
        _G.Debris({ v6, v8 }, 2)

        return
    end

    if arg1 == "Slash4" then
        local v10 = script.RightClaw:Clone()
        v10.CFrame = arg2 * CFrame.new(0, -2.5, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
        v10.Parent = workspace.Effects
        Utility_m.EmitParticles(v10)
        _G.Debris(v10, 2)
    end
end
