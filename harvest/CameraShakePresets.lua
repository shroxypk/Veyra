-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.CameraShaker.CameraShaker.CameraShakePresets
-- Class: ModuleScript
-- bytes: 4023

local CameraShakeInstance_m = require(script.Parent.CameraShakeInstance)
local t = {
    SmallBump = function() --[[ SmallBump ]] -- line: 23
        -- upvalues:
        --  [1] CameraShakeInstance_m (copy)

        local v1 = CameraShakeInstance_m.new(2.5, 4, 0.1, 0.75)
        v1.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
        v1.RotationInfluence = Vector3.new(1, 1, 1)

        return v1
    end,
    SmallerBump = function() --[[ SmallerBump ]] -- line: 30
        -- upvalues:
        --  [1] CameraShakeInstance_m (copy)

        local v2 = CameraShakeInstance_m.new(2.25, 3.5, 0.1, 0.75)
        v2.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
        v2.RotationInfluence = Vector3.new(0.7, 0.7, 0.7)

        return v2
    end,
    SmallestBump = function() --[[ SmallestBump ]] -- line: 37
        -- upvalues:
        --  [1] CameraShakeInstance_m (copy)

        local v3 = CameraShakeInstance_m.new(1, 3, 0.1, 0.75)
        v3.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
        v3.RotationInfluence = Vector3.new(0.7, 0.7, 0.7)

        return v3
    end,
    Bump = function() --[[ Bump ]] -- line: 46
        -- upvalues:
        --  [1] CameraShakeInstance_m (copy)

        local v4 = CameraShakeInstance_m.new(2.25, 3.5, 0.1, 0.7)
        v4.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
        v4.RotationInfluence = Vector3.new(1, 1, 1)

        return v4
    end,
    Explosion = function() --[[ Explosion ]] -- line: 56
        -- upvalues:
        --  [1] CameraShakeInstance_m (copy)

        local v5 = CameraShakeInstance_m.new(2, 5, 0, 0.75)
        v5.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
        v5.RotationInfluence = Vector3.new(3, 1, 1)

        return v5
    end,
    Earthquake = function() --[[ Earthquake ]] -- line: 71
        -- upvalues:
        --  [1] CameraShakeInstance_m (copy)

        local v6 = CameraShakeInstance_m.new(0.6, 3.5, 2, 10)
        v6.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
        v6.RotationInfluence = Vector3.new(1, 1, 4)

        return v6
    end,
    BadTrip = function() --[[ BadTrip ]] -- line: 81
        -- upvalues:
        --  [1] CameraShakeInstance_m (copy)

        local v7 = CameraShakeInstance_m.new(10, 0.15, 5, 10)
        v7.PositionInfluence = Vector3.new(0, 0, 0.15)
        v7.RotationInfluence = Vector3.new(2, 1, 4)

        return v7
    end,
    HandheldCamera = function() --[[ HandheldCamera ]] -- line: 91
        -- upvalues:
        --  [1] CameraShakeInstance_m (copy)

        local v8 = CameraShakeInstance_m.new(1, 0.25, 5, 10)
        v8.PositionInfluence = Vector3.new(0, 0, 0)
        v8.RotationInfluence = Vector3.new(1, 0.5, 0.5)

        return v8
    end,
    Vibration = function() --[[ Vibration ]] -- line: 101
        -- upvalues:
        --  [1] CameraShakeInstance_m (copy)

        local v9 = CameraShakeInstance_m.new(0.4, 20, 2, 2)
        v9.PositionInfluence = Vector3.new(0, 0.15, 0)
        v9.RotationInfluence = Vector3.new(1.25, 0, 4)

        return v9
    end,
    RoughDriving = function() --[[ RoughDriving ]] -- line: 111
        -- upvalues:
        --  [1] CameraShakeInstance_m (copy)

        local v10 = CameraShakeInstance_m.new(1, 2, 1, 1)
        v10.PositionInfluence = Vector3.new(0, 0, 0)
        v10.RotationInfluence = Vector3.new(1, 1, 1)

        return v10
    end,
    SmallEarthquake = function() --[[ SmallEarthquake ]] -- line: 119
        -- upvalues:
        --  [1] CameraShakeInstance_m (copy)

        local v11 = CameraShakeInstance_m.new(3, 6, 0, 4)
        v11.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
        v11.RotationInfluence = Vector3.new(2, 1, 1)

        return v11
    end
}

return (setmetatable({}, {
    __index = function(_, arg2) --[[ __index ]] -- line: 129
        -- upvalues:
        --  [1] t (copy)

        local v12 = t[arg2]

        if type(v12) == "function" then
            return v12()
        end

        error("No preset found with index \"" .. arg2 .. "\"")
    end
}))
