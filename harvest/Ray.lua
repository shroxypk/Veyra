-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.Ray
-- Class: ModuleScript
-- bytes: 1376

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

function t.Draw(t1: table, vec1: Vector3, vec2: Vector3) -- line: 16
    local Ceive = t1.Ceive

    if not Ceive.Enabled then
        return
    end

    if t1.Propertys.AlwaysOnTop then
        Ceive.AOTWireframeHandle:AddLine(vec1, vec2)
    else
        Ceive.WireframeHandle:AddLine(vec1, vec2)
    end

    local Ceive_1 = t1.Ceive
    Ceive_1.ActiveRays += 1
    t1.Ceive.ScheduleCleaning()
end

function t.Create(t2: table, vec3: Vector3, vec4: Vector3) -- line: 34
    local t_2 = {
        Origin = vec3,
        End = vec4,
        AlwaysOnTop = t2.Propertys.AlwaysOnTop,
        Transparency = t2.Propertys.Transparency,
        Color3 = t2.Propertys.Color3,
        Enabled = true,
        Destroy = false
    }
    t2.Retain(t2, t_2)

    return t_2
end

function t.Update(arg6, arg7) -- line: 50
    local Ceive_2 = arg6.Ceive
    Ceive_2.PushProperty("AlwaysOnTop", arg7.AlwaysOnTop)
    Ceive_2.PushProperty("Transparency", arg7.Transparency)
    Ceive_2.PushProperty("Color3", arg7.Color3)
    arg6:Draw(arg7.Origin, arg7.End)
end

return t
