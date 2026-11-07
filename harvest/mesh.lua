-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.Mesh
-- Class: ModuleScript
-- bytes: 2928

local _ = function(
    arg1,
    arg2,
    arg3,
    arg4,
    arg5
) --[[ Map ]] -- line: 1
    return (arg1 - arg2) / (arg3 - arg2) * (arg5 - arg4) + arg4
end

local t = {}
t.__index = t

function t.Init(
    arg6,
    arg7,
    arg8,
    arg9,
    arg10
) -- line: 8
    -- upvalues:
    --  [1] t (copy)

    local t_1 = setmetatable({}, t)
    t_1.Ceive = arg6
    t_1.Propertys = arg7
    t_1.Request = arg8
    t_1.Release = arg9
    t_1.Retain = arg10

    return t_1
end

function t.Draw(
    t1: table,
    u1: CFrame,
    vec1: Vector3,
    arg11: any,
    arg12: any
) -- line: 20
    local Ceive = t1.Ceive

    if not Ceive.Enabled then
        return
    end

    local v1 = -math.huge
    local v2 = -math.huge
    local v3 = -math.huge
    local v4 = math.huge
    local v5 = math.huge
    local v6 = math.huge

    for _, val in arg11 do
        v1 = math.max(v1, val.x)
        v2 = math.max(v2, val.y)
        v3 = math.max(v3, val.z)
        v4 = math.min(v4, val.x)
        v5 = math.min(v5, val.y)
        v6 = math.min(v6, val.z)
    end

    for key_1, val_1 in arg11 do
        arg11[key_1] = u1 * CFrame.new(
            Vector3.new(
                (val_1.x - v4) / (v1 - v4) * 1 + -0.5,
                (val_1.y - v5) / (v2 - v5) * 1 + -0.5,
                (val_1.z - v6) / (v3 - v6) * 1 + -0.5
            ) * vec1
        )
    end

    for _, val_2 in arg12 do
        if #val_2 == 3 then
            v6 = arg11[val_2[1].v]
            v5 = arg11[val_2[2].v]
            v4 = arg11[val_2[3].v]
            Ceive.Ray:Draw(v6.Position, v5.Position)
            Ceive.Ray:Draw(v5.Position, v4.Position)
            Ceive.Ray:Draw(v4.Position, v6.Position)
        else
            v3 = arg11[val_2[1].v]
            v2 = arg11[val_2[2].v]
            v1 = arg11[val_2[3].v]
            local v7 = arg11[val_2[4].v]
            Ceive.Ray:Draw(v3.Position, v2.Position)
            Ceive.Ray:Draw(v3.Position, v7.Position)
            Ceive.Ray:Draw(v7.Position, v2.Position)
            Ceive.Ray:Draw(v1.Position, v7.Position)
            Ceive.Ray:Draw(v2.Position, v1.Position)
        end
    end
end

function t.Create(
    t2: table,
    u2: CFrame,
    vec2: Vector3,
    arg13: any,
    arg14: any
) -- line: 79
    local t_2 = {
        Transform = u2,
        Size = vec2,
        Vertices = arg13,
        Faces = arg14,
        AlwaysOnTop = t2.Propertys.AlwaysOnTop,
        Transparency = t2.Propertys.Transparency,
        Color3 = t2.Propertys.Color3,
        Enabled = true,
        Destroy = false
    }
    t2.Retain(t2, t_2)

    return t_2
end

function t.Update(arg15, arg16) -- line: 97
    local Ceive_1 = arg15.Ceive
    Ceive_1.PushProperty("AlwaysOnTop", arg16.AlwaysOnTop)
    Ceive_1.PushProperty("Transparency", arg16.Transparency)
    Ceive_1.PushProperty("Color3", arg16.Color3)
    arg15:Draw(arg16.Transform, arg16.Size, arg16.Vertices, arg16.Faces)
end

return t
