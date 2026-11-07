-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Components.Collision.ColliderObject
-- Class: ModuleScript
-- bytes: 3511

local Collider_m = require(script.Parent:WaitForChild("Collider"))
local t = {}
local SBVERBOSELOG = require(
    script.Parent.Parent.Parent:WaitForChild("Dependencies"):WaitForChild("Utilities")
).SB_VERBOSE_LOG
t.__index = t

function t.new(t1: table, u1: userdata) -- line: 57
    -- upvalues:
    --  [1] t (copy)

    local t_2 = setmetatable(
        { m_Object = u1, m_Awake = true, m_LastSleepCycle = 0, Destroyed = false, Colliders = {} },
        t
    )
    t_2:m_LoadColliderTable(t1)
    local Parent = u1:GetPropertyChangedSignal("Parent")
    t_2.DestroyConnection = Parent:Connect(function() -- line: 68
        -- upvalues:
        --  [1] u1 (copy)
        --  [2] t_2 (copy)

        if u1.Parent == nil then
            t_2.Destroyed = true
        end
    end)

    return t_2
end

function t.m_LoadCollider(t2: table, t3: table) -- line: 80
    -- upvalues:
    --  [1] Collider_m (copy)

    local vec3 = Vector3.new(t3.ScaleX, t3.ScaleY, t3.ScaleZ)
    local vec3_1 = Vector3.new(t3.OffsetX, t3.OffsetY, t3.OffsetZ)
    local vec3_2 = Vector3.new(t3.RotationX, t3.RotationY, t3.RotationZ)
    local v2 = Collider_m.new()
    v2.Scale = vec3
    v2.Offset = vec3_1
    v2.Rotation = vec3_2
    v2.Type = t3.Type
    v2:SetObject(t2.m_Object)
    table.insert(t2.Colliders, v2)
end

function t.m_LoadColliderTable(t4: table, t5: table) -- line: 98
    for _, val in t5 do
        t4:m_LoadCollider(val)
    end
end

function t.GetObject(arg1) -- line: 108
    return arg1.m_Object
end

function t.GetCollisions(arg2, arg3, arg4) -- line: 116
    debug.profilebegin("ColliderObject::GetCollisions")

    if not arg2.m_Object then
        debug.profileend()

        return {}
    end

    if #arg2.Colliders == 0 then
        debug.profileend()

        return {}
    end

    debug.profilebegin("Sleep Cycle")

    if os.clock() - arg2.m_LastSleepCycle >= 0.2 then
        arg2.m_LastSleepCycle = os.clock()

        if arg2.m_Object:IsDescendantOf(workspace) then
            arg2.m_Awake = true
        else
            arg2.m_Awake = false
        end
    end

    debug.profileend()

    if not arg2.m_Awake then
        debug.profileend()

        return {}
    end

    local t_3 = {}
    debug.profilebegin("Determine Collisions")

    for _, val_1 in arg2.Colliders do
        debug.profilebegin("Determine collision")
        local v3, v4, v5 = val_1:GetClosestPoint(arg3, arg4)
        debug.profileend()

        if v3 then
            table.insert(t_3, { ClosestPoint = v4, Normal = v5 })
        end
    end

    debug.profileend()
    debug.profileend()

    return t_3
end

function t.Step(arg5) -- line: 164
    debug.profilebegin("ColliderObject::Step")

    for _, val_2 in arg5.Colliders do
        val_2:Step()
    end

    debug.profileend()
end

function t.DrawDebug(
    arg6,
    arg7,
    arg8,
    arg9,
    arg10
) -- line: 177
    for _, val_3 in arg6.Colliders do
        val_3:DrawDebug(
            arg6,
            arg7,
            arg8,
            arg9,
            arg10
        )
        val_3.InNarrowphase = false
    end
end

function t.Destroy(arg11) -- line: 185
    -- upvalues:
    --  [1] SBVERBOSELOG (copy)

    task.synchronize()
    SBVERBOSELOG(`Collider object destroying, object: {arg11.m_Object}`)
    arg11.DestroyConnection:Disconnect()

    if #arg11.Colliders ~= 0 then
        for _, val_4 in arg11.Colliders do
            val_4:Destroy()
        end
    end

    setmetatable(arg11, nil)
    task.desynchronize()
end

return t
