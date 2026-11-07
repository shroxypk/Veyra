-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Components.Constraints.DistanceConstraint
-- Class: ModuleScript
-- bytes: 591

local _ = function(arg1) --[[ SafeUnit ]] -- line: 1
    if arg1.Magnitude == 0 then
        return Vector3.new(0, 0, 0)
    end

    return arg1.Unit
end

return function(arg2, arg3, arg4) -- line: 9
    debug.profilebegin("Distance Constraint")
    local v1 = arg4.Bones[arg2.ParentIndex]

    if v1 then
        local v2 = arg3 - v1.Position
        local v3 = if v2.Magnitude ~= 0 then v2.Unit else Vector3.new(0, 0, 0)
        local v4 = v1.Position + v3 * arg2.FreeLength
        debug.profileend()

        return v4
    end

    local _ = arg2.ParentIndex
    debug.profileend()
end
