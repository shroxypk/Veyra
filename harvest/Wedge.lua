-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.Wedge
-- Class: ModuleScript
-- bytes: 3017

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
    local v5 = nil
    local v6 = nil
    local v7 = nil
    local v8 = nil

    local function CalculateYFace(arg6, arg7, arg8) -- line: 38
        -- upvalues:
        --  [1] Position (copy)
        --  [2] v5 (ref)
        --  [3] v6 (ref)
        --  [4] Ceive (copy)
        --  [5] b1 (copy)

        local v9 = Position + (arg6 - arg7 + arg8)
        local v10 = Position + (arg6 + arg7 + arg8)
        local v11 = Position + (arg6 - arg7 - arg8)
        local v12 = Position + (arg6 + arg7 - arg8)
        v5 = v9
        v6 = v10
        Ceive.Ray:Draw(v9, v10)
        Ceive.Ray:Draw(v9, v11)
        Ceive.Ray:Draw(v10, v12)

        if b1 ~= false then
            Ceive.Ray:Draw(v10, v11)
        end

        Ceive.Ray:Draw(v11, v12)
    end

    local function CalculateZFace(arg9, arg10, arg11) -- line: 58
        -- upvalues:
        --  [1] Position (copy)
        --  [2] v7 (ref)
        --  [3] v8 (ref)
        --  [4] Ceive (copy)
        --  [5] b1 (copy)

        local v13 = Position + (arg9 - arg10 + arg11)
        local v14 = Position + (arg9 + arg10 + arg11)
        local v15 = Position + (-arg9 - arg10 + arg11)
        local v16 = Position + (-arg9 + arg10 + arg11)
        v7 = v13
        v8 = v14
        Ceive.Ray:Draw(v13, v14)
        Ceive.Ray:Draw(v13, v15)
        Ceive.Ray:Draw(v14, v16)

        if b1 ~= false then
            Ceive.Ray:Draw(v14, v15)
        end

        Ceive.Ray:Draw(v15, v16)
    end

    CalculateYFace(-v2, v3, v4)
    CalculateZFace(v2, v3, -v4)
    Ceive.Ray:Draw(v5, v7)
    Ceive.Ray:Draw(v6, v8)

    if b1 ~= false then
        Ceive.Ray:Draw(v6, v7)
    end
end

function t.Create(t2: table, u2: CFrame, vec2: Vector3, b2: boolean) -- line: 89
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

function t.Update(arg12, arg13) -- line: 106
    local Ceive_1 = arg12.Ceive
    Ceive_1.PushProperty("AlwaysOnTop", arg13.AlwaysOnTop)
    Ceive_1.PushProperty("Transparency", arg13.Transparency)
    Ceive_1.PushProperty("Color3", arg13.Color3)
    arg12:Draw(arg13.Transform, arg13.Size, arg13.DrawTriangles)
end

return t
