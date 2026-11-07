-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.MatchmakingService.Cache
-- Class: ModuleScript
-- bytes: 1880

local t = { CreatedCaches = {} }
t.__index = t

function t.new(arg1, arg2) -- line: 7
    -- upvalues:
    --  [1] t (copy)

    if arg2 == nil then
        arg2 = 60
    end

    local t_1 = { Name = arg1, Cache = {}, Size = 0, DefaultTimeout = arg2 }
    setmetatable(t_1, t)
    t.CreatedCaches[arg1] = t_1

    return t_1
end

function t.GetCache(arg3) -- line: 25
    -- upvalues:
    --  [1] t (copy)

    return t.CreatedCaches[arg3]
end

function t.IsEmpty(arg4) -- line: 29
    return arg4.Size == 0
end

function t.AddItem(arg5, arg6, arg7, arg8) -- line: 33
    if arg8 == nil then
        arg8 = arg5.DefaultTimeout
    end

    local v2 = arg5:IsEmpty()
    arg5.Cache[arg6] = { Value = arg7, Timeout = os.clock() + arg8 }
    arg5.Size += 1

    if v2 then
        task.spawn(function() -- line: 48
            -- upvalues:
            --  [1] arg5 (copy)

            while true do
                if arg5:IsEmpty() then
                    break
                end

                local clock = os.clock()

                for key, val in pairs(arg5.Cache) do
                    if clock > val.Timeout then
                        arg5.Cache[key] = nil
                        local v3 = arg5
                        v3.Size -= 1
                    end
                end
            end
        end)
    end
end

function t.GetItem(arg9, arg10) -- line: 62
    local v4 = arg9.Cache[arg10]

    return v4 and v4.Value
end

function t.SetTimeoutForItem(arg11, arg12, arg13) -- line: 67
    local v6 = arg11.Cache[arg12]

    if v6 == nil then
        return false
    end

    v6.Timeout = os.clock() + arg13

    return true
end

function t.Clear(arg14) -- line: 78
    arg14.Cache = {}
    arg14.Size = 0
end

function t.Destroy(arg15) -- line: 83
    -- upvalues:
    --  [1] t (copy)

    arg15:Clear()
    t.CreatedCaches[arg15.Name] = nil
end

return t
