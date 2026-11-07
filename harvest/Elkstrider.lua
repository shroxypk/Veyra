-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Crits.Elkstrider
-- Class: ModuleScript
-- bytes: 1248

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Utility_m = require(Services_m.ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

return function(arg1, arg2, _) -- line: 17
    -- upvalues:
    --  [1] Utility_m (copy)

    if arg1 == "Jump" then
        local v2 = script.Jump:Clone()
        v2.CFrame = arg2 * CFrame.new(0, -2.5, 0)
        v2.Parent = workspace.Effects
        Utility_m.EmitParticles(v2)
        _G.Debris(v2, 4)

        return
    end

    if arg1 == "Swirl" then
        local v3 = script.Swirl:Clone()
        _G.Debris(v3, 4)
        v3.CFrame = arg2 * CFrame.Angles(0, 3.141592653589793, 0)
        v3.Parent = workspace.Effects
        Utility_m.EmitParticles(v3)

        return
    end

    if arg1 == "Slash" then
        local v4 = script.Slash:Clone()
        _G.Debris(v4, 4)
        v4.CFrame = arg2 * CFrame.Angles(0, 3.141592653589793, 0)
        v4.Parent = workspace.Effects
        Utility_m.EmitParticles(v4)
    end
end
