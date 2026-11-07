-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Effects.GroundTrail
-- Class: ModuleScript
-- bytes: 1504

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.TweenService
local _ = Services_m.ReplicatedStorage
local _ = Random.new()

return function(arg1, arg2, arg3, arg4) -- line: 8
    -- upvalues:
    --  [1] Services_m (copy)

    if typeof(arg2) == "CFrame" then
        arg2 = arg2.Position
    end

    if typeof(arg3) == "CFrame" then
        arg3 = arg3.Position
    end

    arg4 = arg4 or 20
    local t = { arg1, workspace.Effects, workspace.Camera }
    _G.FastSpawn(function() -- line: 19
        -- upvalues:
        --  [1] arg2 (ref)
        --  [2] arg4 (ref)
        --  [3] arg3 (ref)
        --  [4] Services_m (ref)
        --  [5] t (copy)

        local v2 = script.GroundTrail:Clone()
        v2.Position = arg2
        v2.Parent = workspace.Effects
        _G.Tween(
            v2.Start,
            { 0.1, "Quad", Enum.EasingDirection.Out },
            { Position = Vector3.new(0, 0, 0.25) }
        )
        _G.Tween(
            v2.End,
            { 0.1, "Quad", Enum.EasingDirection.Out },
            { Position = Vector3.new(0, 0, -0.25) }
        )

        for index = 0, arg4 do
            local v3 = arg2 + (arg3 - arg2).Unit * index * (arg3 - arg2).Magnitude / arg4
            local _ = arg4
            local v5, v6 = Services_m.RayCast(v3, CFrame.new(v3).upVector * -6, t)

            if v5 then
                v2.Position = v6
            end

            task.wait()
        end

        _G.Debris(v2, 4)
    end)
end
