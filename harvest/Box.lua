-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.Box
-- Class: ModuleScript
-- bytes: 3385

local t = {}
t.__index = t

function t.Init(
    arg1,
    arg2,
    arg3,
    arg4,
    arg5
) -- line: 4
    -- upvalues:
    --  [1] t (copy)

    local t_1 = setmetatable({}, t)
    t_1.Ceive = arg1
    t_1.Propertys = arg2
    t_1.Request = arg3
    t_1.Release = arg4
    t_1.Retain = arg5

    return t_1
end

function t.Draw(t1: table, u1: CFrame, vec1: Vector3, b1: boolean) -- line: 16
    local Ceive = t1.Ceive

    if not Ceive.Enabled then
        return
    end

    local Position = u1.Position
    local v1 = vec1 * 0.5
    local v2 = u1.UpVector * v1.Y
    local v3 = u1.RightVector * v1.X
    local v4 = u1.LookVector * v1.Z

    local function CalculateYFace(arg6, arg7, arg8) -- line: 32
        -- upvalues:
        --  [1] Position (copy)
        --  [2] Ceive (copy)
        --  [3] b1 (copy)

        local v5 = Position + (arg6 - arg7 + arg8)
        local v6 = Position + (arg6 + arg7 + arg8)
        local v7 = Position + (arg6 - arg7 - arg8)
        local v8 = Position + (arg6 + arg7 - arg8)
        Ceive.Ray:Draw(v5, v6)
        Ceive.Ray:Draw(v5, v7)
        Ceive.Ray:Draw(v6, v8)

        if b1 ~= false then
            Ceive.Ray:Draw(v6, v7)
        end

        Ceive.Ray:Draw(v7, v8)
    end

    local function CalculateZFace(arg9, arg10, arg11) -- line: 49
        -- upvalues:
        --  [1] Position (copy)
        --  [2] Ceive (copy)
        --  [3] b1 (copy)

        local v9 = Position + (arg9 - arg10 + arg11)
        local v10 = Position + (arg9 + arg10 + arg11)
        local v11 = Position + (-arg9 - arg10 + arg11)
        local v12 = Position + (-arg9 + arg10 + arg11)
        Ceive.Ray:Draw(v9, v10)
        Ceive.Ray:Draw(v9, v11)
        Ceive.Ray:Draw(v10, v12)

        if b1 ~= false then
            Ceive.Ray:Draw(v10, v11)
        end

        Ceive.Ray:Draw(v11, v12)
    end

    local function CalculateXFace(arg12, arg13, arg14) -- line: 66
        -- upvalues:
        --  [1] Position (copy)
        --  [2] Ceive (copy)
        --  [3] b1 (copy)

        local v13 = Position + (arg12 - arg13 - arg14)
        local v14 = Position + (arg12 - arg13 + arg14)
        local v15 = Position + (-arg12 - arg13 - arg14)
        local v16 = Position + (-arg12 - arg13 + arg14)
        Ceive.Ray:Draw(v13, v14)
        Ceive.Ray:Draw(v13, v15)
        Ceive.Ray:Draw(v14, v16)

        if b1 ~= false then
            Ceive.Ray:Draw(v14, v15)
        end

        Ceive.Ray:Draw(v15, v16)
    end

    CalculateXFace(v2, v3, v4)
    CalculateXFace(v2, -v3, v4)
    CalculateYFace(v2, v3, v4)
    CalculateYFace(-v2, v3, v4)
    CalculateZFace(v2, v3, v4)
    CalculateZFace(v2, v3, -v4)
end

function t.Create(t2: table, u2: CFrame, vec2: Vector3, b2: boolean) -- line: 93
    local t_2 = {
        Transform = u2,
        Size = vec2,
        DrawTriangles = b2,
        AlwaysOnTop = t2.Propertys.AlwaysOnTop,
        Transparency = t2.Propertys.Transparency,
        Color3 = t2.Propertys.Color3,
        Enabled = true,
        Destroy = false
    }
    t2.Retain(t2, t_2)

    return t_2
end

function t.Update(arg15, arg16) -- line: 110
    local Ceive_1 = arg15.Ceive
    Ceive_1.PushProperty("AlwaysOnTop", arg16.AlwaysOnTop)
    Ceive_1.PushProperty("Transparency", arg16.Transparency)
    Ceive_1.PushProperty("Color3", arg16.Color3)
    arg15:Draw(arg16.Transform, arg16.Size, arg16.DrawTriangles)
end

return t
