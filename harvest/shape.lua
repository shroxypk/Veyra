-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.mod.shape
-- Class: ModuleScript
-- bytes: 5942

local Utility_m: any = require("./utility")
local t: any = {
    getSurfaceCFrame = function(u1: CFrame, vec1: Vector3, vec2: Vector3) --[[ getSurfaceCFrame ]] -- line: 7
        local v1 = vec1:Dot(Vector3.new(0, 1, 0))
        local v2 = if math.abs(v1) > 0.99 then Vector3.new(0, 0, 1) else Vector3.new(0, 1, 0)
        local cframe: any = CFrame.lookAt(Vector3.new(0, 0, 0), vec1, v2)

        return u1 * CFrame.new(vec2) * cframe
    end
}

function t.getPointWithinBox(n1: number, u2: CFrame, vec3: Vector3, arg1: any) -- line: 13
    -- upvalues:
    --  [1] t (copy)

    debug.profilebegin("getPointWithinBox")
    local rng: any = Random.new(n1)
    local v3: Vector3 = vec3 / 2
    local v4 = rng:NextNumber(-1, 1)
    local v5 = rng:NextNumber(-1, 1)
    local v6: Vector3 = Vector3.new(v4, v5, rng:NextNumber(-1, 1)) * v3
    local v7 = t.getSurfaceCFrame(u2, Vector3.FromNormalId(arg1), v6)
    debug.profileend()

    return v7
end

function t.getPointOnBox(n2: number, u3: CFrame, vec4: Vector3, arg2: any) -- line: 34
    -- upvalues:
    --  [1] t (copy)

    debug.profilebegin("getPointOnBox")
    local rng_1: any = Random.new(n2)
    local vec3_1: any = Vector3.FromNormalId(arg2)
    local v8: Vector3 = vec4 / 2
    local v9: any = Vector3.new(1, 1, 1) - vec3_1:Abs()
    local v10 = rng_1:NextNumber(-1, 1)
    local v11 = rng_1:NextNumber(-1, 1)
    local v12 = t.getSurfaceCFrame(
        u3,
        vec3_1,
        Vector3.new(v10, v11, rng_1:NextNumber(-1, 1)) * v8 * v9 + vec3_1 * v8
    )
    debug.profileend()

    return v12
end

function t.getPointWithinCylinder(
    n3: number,
    n4: number,
    n5: number,
    u4: CFrame,
    vec5: Vector3,
    arg3: any
) -- line: 58
    -- upvalues:
    --  [1] Utility_m (copy)

    debug.profilebegin("getPointWithinCylinder")
    local rng_2: any = Random.new(n3)
    local v13 = rng_2:NextNumber(n4, 1)
    local v14: number = math.sqrt(v13)
    local v15: any = rng_2:NextNumber(0, 6.283185307179586)

    if arg3 == Enum.NormalId.Left or arg3 == Enum.NormalId.Right then
        local v16 = if arg3 ~= Enum.NormalId.Right then 1 else -1
        u4 *= CFrame.fromOrientation(0, 1.5707963267948966 * v16, 0)
        vec5 = Vector3.new(vec5.Z, vec5.Y, vec5.X)
    else
        u4 = if arg3 == Enum.NormalId.Front then u4 * CFrame.fromOrientation(
            0,
            3.141592653589793,
            0
        ) else if arg3 ~= Enum.NormalId.Back then u4 else u4 * CFrame.fromOrientation(
            0,
            3.141592653589793,
            0
        )
    end

    local v18: any = 1 - rng_2:NextNumber() ^ Utility_m.lerp(0.5, 1, (math.sqrt(n5)))
    local v19: any = Utility_m.lerp(1, n5, v18)
    local v20 = v18 * 2 - 1
    local v21 = v14 * math.sin(v15) * v19
    local v22: Vector3 = Vector3.new(v20, v21, v14 * math.cos(v15) * v19) * vec5 / 2
    local v23 = math.sin(v15) * v19
    local v24: Vector3 = Vector3.new(0, v23, math.cos(v15) * v19) * vec5 / 2
    local v25 = math.cos(v15) * v19
    local v26: Vector3 = Vector3.new(0, v25, -math.sin(v15) * v19) * vec5 / 2
    v19 = v26.Magnitude > 0.001 and v26.Unit or u4.UpVector
    local v28: any = u4 * CFrame.new(v22) * CFrame.lookAt(Vector3.new(0, 0, 0), v24, v19)
    debug.profileend()

    return v28
end

function t.getPointWithinSphere(
    n6: number,
    n7: number,
    n8: number,
    u5: CFrame,
    vec6: Vector3,
    arg4: any
) -- line: 108
    -- upvalues:
    --  [1] t (copy)

    debug.profilebegin("getPointWithinSphere")
    local rng_3: any = Random.new(n6)
    local v29: any = rng_3:NextNumber()
    local v30: any = rng_3:NextNumber()
    local v31: any = v29 * 2 * 3.141592653589793
    local v32: number = math.acos(2 * v30 - 1) * n8
    local v33: any = rng_3:NextNumber(n7, 1) ^ 0.3333333333333333
    local v34: number = math.sin(v31)
    local v35: number = math.cos(v31)
    local v36: number = math.sin(v32)
    local v37: number = math.cos(v32)
    local vec3_2 = Vector3.FromNormalId(arg4)

    if arg4 == Enum.NormalId.Left or arg4 == Enum.NormalId.Right then
        vec6 = Vector3.new(vec6.Z, vec6.Y, vec6.X)
    elseif arg4 == Enum.NormalId.Top or arg4 == Enum.NormalId.Bottom then
        vec6 = Vector3.new(vec6.X, vec6.Z, vec6.Y)
    end

    local v38: Vector3 = vec6 / 2
    local v39: any = t.getSurfaceCFrame(u5, vec3_2, Vector3.new(0, 0, 0))
    local v40: Vector3 = Vector3.new(v33 * v36 * v35, v33 * v36 * v34, v33 * v37) * v38
    local v41: Vector3 = Vector3.new(-v36 * v34, v36 * v35, 0) * v38
    v38 = if v41.Magnitude > 0.001 then v41.Unit else Vector3.new(1, 0, 0)
    local v44: any = v39 * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(v40) * CFrame.lookAt(
        Vector3.new(0, 0, 0),
        v40,
        v38
    )
    debug.profileend()

    return v44
end

function t.getPointWithinDisc(
    n9: number,
    n10: number,
    n11: number,
    u6: CFrame,
    vec7: Vector3,
    arg5: any
) -- line: 160
    -- upvalues:
    --  [1] Utility_m (copy)
    --  [2] t (copy)

    debug.profilebegin("getPointWithinDisc")
    local v45: any = Random.new(n9)
    local vec3_3: any = Vector3.FromNormalId(arg5)
    local v46: any = Vector3.new(1, 1, 1) - vec3_3:Abs() * n10
    local v47: Vector3 = vec7 / 2
    local v48: any = v45:NextNumber(n10, 1)
    local v49: any = Utility_m.lerp(1, 0.5, n11 ^ 4)
    local v51: any = v45:NextNumber(1 - n11, 1) ^ v49
    local v52: any = v45:NextNumber(0, 6.283185307179586)
    local v53 = v48 * 2 - 1
    local v54 = v51 * math.sin(v52)
    v45 = Vector3.new(v53, v54, v51 * math.cos(v52))

    if arg5 == Enum.NormalId.Bottom or arg5 == Enum.NormalId.Top then
        v45 = Vector3.new(v45.Z, v45.X, v45.Y)
    elseif arg5 == Enum.NormalId.Front or arg5 == Enum.NormalId.Back then
        v45 = Vector3.new(v45.Y, v45.Z, v45.X)
    end

    local v55: any = t.getSurfaceCFrame(u6, vec3_3, v45 * (v47 * v46) + vec3_3 * n10 * v47)
    debug.profileend()

    return v55
end

return t
