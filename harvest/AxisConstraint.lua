-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Components.Constraints.AxisConstraint
-- Class: ModuleScript
-- bytes: 1911

local _ = function(arg1) --[[ SafeUnit ]] -- line: 1
    if arg1.Magnitude == 0 then
        return Vector3.new(0, 0, 0)
    end

    return arg1.Unit
end

return function(arg2, arg3, arg4, arg5) -- line: 9
    debug.profilebegin("Axis Constraint")
    local v1 = arg5:Inverse() * arg3
    local X = v1.X
    local Y = v1.Y
    local Z = v1.Z
    local XAxisLimits = arg2.XAxisLimits
    local YAxisLimits = arg2.YAxisLimits
    local ZAxisLimits = arg2.ZAxisLimits
    local v2 = if arg2.AxisLocked[1] then 0 else 1
    local v3 = if not arg2.AxisLocked[2] then 1 else 0
    local v4 = if not arg2.AxisLocked[3] then 1 else 0
    local v5 = XAxisLimits.Min + arg2.Radius
    local v6 = v5 <= XAxisLimits.Max - arg2.Radius and XAxisLimits.Max - arg2.Radius or v5
    local v7 = YAxisLimits.Min + arg2.Radius
    local v8 = v7 <= YAxisLimits.Max - arg2.Radius and YAxisLimits.Max - arg2.Radius or v7
    local v9 = ZAxisLimits.Min + arg2.Radius
    local v10 = v9 <= ZAxisLimits.Max - arg2.Radius and ZAxisLimits.Max - arg2.Radius or v9
    local v11 = X < v5 and v5 or (X > v6 and v6 or X)
    local v12 = v11
    v11 = Y < v7 and v7 or (Y > v8 and v8 or Y)
    local v13 = v11
    v11 = Z < v9 and v9 or (Z > v10 and v10 or Z)
    local v14 = v12 * v2
    local v15 = v13 * v3
    local v16 = v11 * v4
    arg3 = arg5 * Vector3.new(v14, v15, v16)
    local v17 = arg5.RightVector
    v8 = arg5.UpVector
    v6 = arg5.LookVector
    local v18 = arg3 - arg4
    v5 = if v18.Magnitude == 0 then Vector3.new(0, 0, 0) else v18.Unit

    if v14 ~= v1.X then
        v4 = v17:Dot(v5) < 0 and -v17 or v17
        arg2:ClipVelocity(arg3, v4)
    end

    if v15 ~= v1.Y then
        v17 = v8:Dot(v5) < 0 and -v8 or v8
        arg2:ClipVelocity(arg3, v17)
    end

    if v16 ~= v1.Z then
        v8 = v6:Dot(v5) > 0 and -v6 or v6
        arg2:ClipVelocity(arg3, v8)
    end

    debug.profileend()

    return arg3
end
