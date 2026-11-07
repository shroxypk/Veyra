-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Crits.CinderBlade
-- Class: ModuleScript
-- bytes: 1263

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

    if arg1 == "Dash" then
        local v2 = script.Dash:Clone()
        _G.Debris(v2, 4)
        v2.CFrame = arg2
        v2.Parent = workspace.Effects
        Utility_m.EmitParticles(v2)

        return
    end

    if arg1 == "Slash" then
        local v3 = script.Slash:Clone()
        _G.Debris(v3, 4)
        v3.PrimaryPart.CFrame = arg2 * CFrame.new(0, -2.5, 0) * CFrame.Angles(
            0,
            2.6179938779914944,
            1.5707963267948966
        )
        v3.Parent = workspace.Effects
        Utility_m.EmitParticles(v3)
        _G.Tween(
            v3.Rotate,
            { 3, "Linear", Enum.EasingDirection.In, false, 0, -1 },
            { Orientation = v3.Rotate.Orientation + Vector3.new(0, -360, 0) }
        )
    end
end
