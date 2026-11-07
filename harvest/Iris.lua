-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris
-- Class: ModuleScript
-- bytes: 5195

local _ = require(script.Types)
local t = {}
local v1 = require(script.Internal)(t)
t.Disabled = false
t.Args = {}
t.Events = {}

function t.HasInit() -- line: 12
    -- upvalues:
    --  [1] v1 (copy)

    return v1._started
end

function t.Init(u1: userdata?, arg1: any) -- line: 16
    -- upvalues:
    --  [1] v1 (copy)
    --  [2] t (copy)

    if u1 == nil then
        u1 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end

    if arg1 == nil then
        arg1 = game:GetService("RunService").Heartbeat
    end

    v1.parentInstance = u1
    assert(v1._started == false, "Iris.Init can only be called once.")
    v1._started = true
    v1._generateRootInstance()
    v1._generateSelectionImageObject()
    task.spawn(function() -- line: 33
        -- upvalues:
        --  [1] arg1 (ref)
        --  [2] v1 (ref)

        if typeof(arg1) == "function" then
            while true do
                arg1()
                v1._cycle()
            end

            return
        end

        if arg1 ~= nil then
            arg1:Connect(function() -- line: 40
                -- upvalues:
                --  [1] v1 (ref)

                v1._cycle()
            end)
        end
    end)

    return t
end

function t.Connect(_: table, f1: (...any) -> ...any) -- line: 49
    -- upvalues:
    --  [1] v1 (copy)

    if v1._started == false then
        warn(
            "Iris:Connect() was called before calling Iris.Init(), the connected function will never run"
        )
    end

    table.insert(v1._connectedFunctions, f1)
end

function t.Append(u2: userdata) -- line: 56
    -- upvalues:
    --  [1] v1 (copy)

    local v3 = v1._GetParentWidget()
    u2.Parent = if v1._config.Parent then v1._config.Parent else v1._widgets[v3.type].ChildAdded(
        v3,
        { type = "userInstance" }
    )
end

function t.End() -- line: 67
    -- upvalues:
    --  [1] v1 (copy)

    if v1._stackIndex == 1 then
        error("Callback has too many calls to Iris.End()", 2)
    end

    v1._IDStack[v1._stackIndex] = nil
    local v5 = v1
    v5._stackIndex -= 1
end

function t.ForceRefresh() -- line: 81
    -- upvalues:
    --  [1] v1 (copy)

    v1._globalRefreshRequested = true
end

function t.UpdateGlobalConfig(t2: table) -- line: 85
    -- upvalues:
    --  [1] v1 (copy)
    --  [2] t (copy)

    for key, val in t2 do
        v1._rootConfig[key] = val
    end

    t.ForceRefresh()
end

function t.PushConfig(t3: table) -- line: 92
    -- upvalues:
    --  [1] t (copy)
    --  [2] v1 (copy)

    local v6 = t.State(-1)

    if v6.value == -1 then
        v6:set(t3)
    elseif v1._deepCompare(v6:get(), t3) == false then
        local v7
        v1._localRefreshActive, v7 = true, t3
        v6:set(v7)
    end

    v1._config = setmetatable(t3, { __index = v1._config })
end

function t.PopConfig() -- line: 110
    -- upvalues:
    --  [1] v1 (copy)

    v1._localRefreshActive = false
    v1._config = getmetatable(v1._config).__index
end

t.TemplateConfig = require(script.config)
t.UpdateGlobalConfig(t.TemplateConfig.colorDark)
t.UpdateGlobalConfig(t.TemplateConfig.sizeDefault)
t.UpdateGlobalConfig(t.TemplateConfig.utilityDefault)
v1._globalRefreshRequested = false

function t.PushId(arg2) -- line: 127
    -- upvalues:
    --  [1] v1 (copy)

    assert(
        if typeof(arg2) ~= "string" then false else true,
        "Iris expected Iris.PushId id to PushId to be a string."
    )
    v1._pushedId = tostring(arg2)
end

function t.PopId() -- line: 133
    -- upvalues:
    --  [1] v1 (copy)

    v1._pushedId = nil
end

function t.SetNextWidgetID(arg3) -- line: 137
    -- upvalues:
    --  [1] v1 (copy)

    v1._nextWidgetId = arg3
end

function t.State(arg4) -- line: 147
    -- upvalues:
    --  [1] v1 (copy)

    local v12 = v1._getID(2)

    if v1._states[v12] then
        return v1._states[v12]
    end

    v1._states[v12] = { value = arg4, ConnectedWidgets = {}, ConnectedFunctions = {} }
    setmetatable(v1._states[v12], v1.StateClass)

    return v1._states[v12]
end

function t.WeakState(arg5) -- line: 161
    -- upvalues:
    --  [1] v1 (copy)

    local v13 = v1._getID(2)

    if v1._states[v13] then
        if #v1._states[v13].ConnectedWidgets == 0 then
            v1._states[v13] = nil
        else
            return v1._states[v13]
        end
    end

    v1._states[v13] = { value = arg5, ConnectedWidgets = {}, ConnectedFunctions = {} }
    setmetatable(v1._states[v13], v1.StateClass)

    return v1._states[v13]
end

function t.ComputedState(arg6: any, f2: (...any) -> ...any) -- line: 179
    -- upvalues:
    --  [1] v1 (copy)

    local v14 = v1._getID(2)

    if v1._states[v14] then
        return v1._states[v14]
    end

    v1._states[v14] = { value = f2(arg6.value), ConnectedWidgets = {}, ConnectedFunctions = {} }
    arg6:onChange(function(arg7) -- line: 190
        -- upvalues:
        --  [1] v1 (ref)
        --  [2] v14 (copy)
        --  [3] f2 (copy)

        v1._states[v14]:set(f2(arg7))
    end)
    setmetatable(v1._states[v14], v1.StateClass)

    return v1._states[v14]
end

t.ShowDemoWindow = require(script.demoWindow)(t)
require(script.widgets)(v1)
require(script.API)(t)

return t
