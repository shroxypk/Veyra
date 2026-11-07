-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.StateMachine
-- Class: ModuleScript
-- bytes: 3287

local t = {}
t.__index = t

function t.new(t1: table) -- line: 20
    -- upvalues:
    --  [1] t (copy)

    if t1.states == nil or t1.transitions == nil or t1.initialState == nil then
        error("Invalid state machine definition")
    end

    for _, val in pairs(t1.transitions) do
        if val.name == "__start" or val.name == "__all" then
            error(`Transition name {val.name} is reserved`)
        end

        if typeof(val.from) == "table" then
            local t_1 = {}

            for _, val_1 in pairs(val.from) do
                t_1[val_1] = true
            end

            val.from = t_1
        end

        if typeof(val.to) == "table" then
            local t_2 = {}

            for _, val_2 in pairs(val.to) do
                t_2[val_2] = true
            end

            val.to = t_2
        end
    end

    t1._transitionHooks = {}
    t1._transitioning = false

    return (setmetatable(t1, t))
end

function t._FindTransition(t2: table, s1: string, s2: string) -- line: 57
    for _, val_3 in pairs(t2.transitions) do
        if typeof(val_3.from) == "string" then
            if (val_3.from == s1 or val_3.from[s1]) and (if typeof(val_3.to) ~= "string" then val_3.to[s2] else val_3.to == s2 or val_3.to[s2]) then
                return val_3
            end
        elseif val_3.from[s1] and (if typeof(val_3.to) ~= "string" then val_3.to[s2] else val_3.to == s2 or val_3.to[s2]) then
            return val_3
        end
    end

    return nil
end

function t.Hook(t3: table, s3: string, f1: (...any) -> ...any) -- line: 70
    t3._transitionHooks[s3] = f1
end

function t.Transition(t4: table, s4: string) -- line: 74
    if t4._transitioning then
        error("Cannot transition during a transition")
    end

    if t4._currentState == s4 then
        error("Cannot transition to the same state")
    end

    local v1 = t4:_FindTransition(t4._currentState, s4)

    if not v1 then
        error(`No transition possible from {t4._currentState} to {s4}`)
    end

    t4._transitioning = true
    local Success, Result = pcall(function() -- line: 91
        -- upvalues:
        --  [1] t4 (copy)
        --  [2] v1 (copy)
        --  [3] s4 (copy)

        local v2 = t4._transitionHooks[v1.name] or function() -- line: 92
        end
        v2(t4._currentState, s4)
        v2 = t4._transitionHooks.__all or function() -- line: 95
        end
        v2(t4._currentState, s4)
    end)
    t4._transitioning = false

    if not Success then
        error(`Transition from {t4._currentState} to {s4} failed: {Result}`)
    end

    t4._currentState = s4
end

function t.Start(arg1) -- line: 108
    arg1._transitioning = true
    (arg1._transitionHooks.__start or function() -- line: 111
    end)(nil, arg1.initialState)
    arg1._transitioning = false
    arg1._currentState = arg1.initialState
end

function t.Destroy(arg2) -- line: 119
    if arg2._transitionHooks then
        for key_4, _ in pairs(arg2._transitionHooks) do
            arg2._transitionHooks[key_4] = nil
        end
    end

    for key_5 in arg2 do
        arg2[key_5] = nil
    end

    arg2.states = nil
    arg2.transitions = nil
    arg2.initialState = nil
    arg2._transitionHooks = nil
    arg2._transitioning = nil
    setmetatable(arg2, nil)
end

return t
