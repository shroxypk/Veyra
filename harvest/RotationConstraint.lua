-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Components.Constraints.RotationConstraint
-- Class: ModuleScript
-- bytes: 1384

local _ = function(arg1) --[[ SafeUnit ]] -- line: 1
    if arg1.Magnitude == 0 then
        return Vector3.new(0, 0, 0)
    end

    return arg1.Unit
end

return function(arg2, arg3, arg4) -- line: 9
    debug.profilebegin("Rotation Constraint")
    local v1 = arg4.Bones[arg2.ParentIndex]

    if not v1 then
        debug.profileend()

        return arg3
    end

    local v2 = arg4.Bones[v1.ParentIndex]

    if not v2 then
        debug.profileend()

        return arg3
    end

    local RotationLimit = v1.RotationLimit
    local Position = v1.Position
    local v3 = v1.Position - v2.Position
    local v4 = if v3.Magnitude ~= 0 then v3.Unit else Vector3.new(0, 0, 0)
    local Magnitude = (arg3 - Position).Magnitude
    local v5 = arg3 - Position
    v2 = if v5.Magnitude ~= 0 then v5.Unit else Vector3.new(0, 0, 0)

    if RotationLimit >= 180 then
        debug.profileend()

        return arg3
    end

    if RotationLimit <= 0 then
        debug.profileend()

        return Position + v4 * Magnitude
    end

    local v6 = math.rad(arg2.RotationLimit)
    local v10

    if v6 <= math.acos((v4:Dot(v2))) then
        local v8 = v4:Cross(v2)
        v10 = CFrame.fromAxisAngle(if v8.Magnitude == 0 then Vector3.new(0, 0, 0) else v8.Unit, v6) * v4
    else
        v10 = v2
    end

    arg3 = Position + v10 * Magnitude
    debug.profileend()

    return arg3
end
