-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Components.Collision.Colliders.Triangle
-- Class: ModuleScript
-- bytes: 3456

local Dot: Vector3 = Vector3.new().Dot
local Cross: Vector3 = Vector3.new().Cross
local math_clamp: any = math.clamp

local _: any = function(arg1) --[[ SafeUnit ]] -- line: 12
    if arg1.Magnitude == 0 then
        return Vector3.new(0, 0, 0)
    end

    return arg1.Unit
end

local _: any = function(arg2, arg3, arg4) --[[ ClosestPointOnLineSegment ]] -- line: 20
    -- upvalues:
    --  [1] Dot (copy)
    --  [2] math_clamp (copy)

    local v1: any = arg3 - arg2

    return arg2 + math_clamp(Dot(arg4 - arg2, v1) / Dot(v1, v1), 0, 1) * v1
end

local _: any = function(arg5, arg6, arg7) --[[ ProjectOnPlane ]] -- line: 26
    return arg7 - (arg7 - arg5):Dot(arg6) * arg6
end

local _: any = function(arg8, arg9, arg10, arg11) --[[ SameSide ]] -- line: 34
    -- upvalues:
    --  [1] Cross (copy)
    --  [2] Dot (copy)

    if Dot(Cross(arg11 - arg10, arg8 - arg10), (Cross(arg11 - arg10, arg9 - arg10))) >= 0 then
        return true
    end

    return false
end

local _: any = function(arg12, arg13, arg14, arg15) --[[ PointInTriangle ]] -- line: 44
    -- upvalues:
    --  [1] Cross (copy)
    --  [2] Dot (copy)

    if Dot(Cross(arg15 - arg14, arg12 - arg14), (Cross(arg15 - arg14, arg13 - arg14))) >= 0 then
        if if Dot(Cross(arg15 - arg13, arg12 - arg13), (Cross(arg15 - arg13, arg14 - arg13))) >= 0 then true else false then
            if if Dot(Cross(arg14 - arg13, arg12 - arg13), (Cross(arg14 - arg13, arg15 - arg13))) >= 0 then true else false then
                return true
            end
        end
    end

    return false
end

local function ClosestPointOnTri(arg16, arg17, arg18, arg19) -- line: 52
    -- upvalues:
    --  [1] Dot (copy)
    --  [2] math_clamp (copy)
    --  [3] Cross (copy)

    debug.profilebegin("Triangle")
    local v8: any = arg17 - arg16
    local v10: any = arg16 + math_clamp(Dot(arg19 - arg16, v8) / Dot(v8, v8), 0, 1) * v8
    local v11: any = arg18 - arg17
    local v13: any = arg17 + math_clamp(Dot(arg19 - arg17, v11) / Dot(v11, v11), 0, 1) * v11
    local v14: any = arg16 - arg18
    local v16: any = arg18 + math_clamp(Dot(arg19 - arg18, v14) / Dot(v14, v14), 0, 1) * v14
    local v17: any = Cross(arg17 - arg16, arg18 - arg16)
    v14 = if v17.Magnitude == 0 then Vector3.new(0, 0, 0) else v17.Unit
    local v18: any = arg19 - (arg19 - (arg16 + arg17 + arg18) * 0.3333):Dot(v14) * v14
    local v20 = Dot(Cross(arg18 - arg17, arg19 - arg17), (Cross(arg18 - arg17, arg16 - arg17))) >= 0
    local v23

    if v20 then
        v20 = Dot(Cross(arg18 - arg16, arg19 - arg16), (Cross(arg18 - arg16, arg17 - arg16))) >= 0

        if v20 then
            v20 = Dot(Cross(arg17 - arg16, arg19 - arg16), (Cross(arg17 - arg16, arg18 - arg16))) >= 0
            v23 = if v20 then true else false
        else
            v23 = false
        end
    else
        v23 = false
    end

    if v23 then
        debug.profileend()

        return v18, v14
    end

    local Magnitude = (v10 - arg19).Magnitude
    local Magnitude_1 = (v13 - arg19).Magnitude
    v20 = (v16 - arg19).Magnitude
    local v24 = math.min(Magnitude, Magnitude_1, v20)

    if v24 == Magnitude then
        debug.profileend()

        return v10, v14
    end

    if v24 == Magnitude_1 then
        debug.profileend()

        return v13, v14
    end

    if v24 == v20 then
        debug.profileend()

        return v16, v14
    end

    debug.profileend()

    return arg19, v14
end

return ClosestPointOnTri
