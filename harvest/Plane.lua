-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.Plane
-- Class: ModuleScript
-- bytes: 1896

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

function t.Draw(t1: table, vec1: Vector3, vec2: Vector3, vec3: Vector3) -- line: 16
    local Ceive = t1.Ceive

    if not Ceive.Enabled then
        return
    end

    vec3 *= Vector3.new(1, 1, 0)
    local cframe = CFrame.lookAt(vec1, vec1 + vec2)
    local v1 = vec3 * 0.5
    (function(arg6, arg7, arg8) --[[ CalculateZFace ]] -- line: 35
        -- upvalues:
        --  [1] vec1 (copy)
        --  [2] Ceive (copy)

        local v2 = vec1 + (arg6 - arg7 + arg8)
        local v3 = vec1 + (arg6 + arg7 + arg8)
        local v4 = vec1 + (-arg6 - arg7 + arg8)
        local v5 = vec1 + (-arg6 + arg7 + arg8)
        Ceive.Ray:Draw(v2, v3)
        Ceive.Ray:Draw(v2, v4)
        Ceive.Ray:Draw(v3, v5)
        Ceive.Ray:Draw(v3, v4)
        Ceive.Ray:Draw(v4, v5)
    end)(cframe.UpVector * v1.Y, cframe.RightVector * v1.X, cframe.LookVector * v1.Z)
end

function t.Create(t2: table, vec4: Vector3, vec5: Vector3, vec6: Vector3) -- line: 53
    local t_2 = {
        Position = vec4,
        Normal = vec5,
        Size = vec6,
        AlwaysOnTop = t2.Propertys.AlwaysOnTop,
        Transparency = t2.Propertys.Transparency,
        Color3 = t2.Propertys.Color3,
        Enabled = true,
        Destroy = false
    }
    t2.Retain(t2, t_2)

    return t_2
end

function t.Update(arg9, arg10) -- line: 70
    local Ceive_1 = arg9.Ceive
    Ceive_1.PushProperty("AlwaysOnTop", arg10.AlwaysOnTop)
    Ceive_1.PushProperty("Transparency", arg10.Transparency)
    Ceive_1.PushProperty("Color3", arg10.Color3)
    arg9:Draw(arg10.Position, arg10.Normal, arg10.Size)
end

return t
