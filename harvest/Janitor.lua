-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Zone.Janitor
-- Class: ModuleScript
-- bytes: 7448

local Heartbeat = game:GetService("RunService").Heartbeat
local proxy = newproxy(true)

getmetatable(proxy).__tostring = function() -- line: 11
    return "IndicesReference"
end

local proxy_1 = newproxy(true)

getmetatable(proxy_1).__tostring = function() -- line: 16
    return "LinkToInstanceIndex"
end

local t = { ClassName = "Janitor", __index = { CurrentlyCleaning = true, [proxy] = nil } }
local t_2 = { ["function"] = true, RBXScriptConnection = "Disconnect" }

function t.new() -- line: 40
    -- upvalues:
    --  [1] proxy (copy)
    --  [2] t (copy)

    return (setmetatable({ CurrentlyCleaning = false, [proxy] = nil }, t))
end

function t.Is(arg1) -- line: 52
    -- upvalues:
    --  [1] t (copy)

    return if type(arg1) == "table" then if getmetatable(arg1) ~= t then false else true else false
end

t.is = t.Is

function t.__index.Add(arg2, arg3, arg4, arg5) -- line: 65
    -- upvalues:
    --  [1] proxy (copy)
    --  [2] t_2 (copy)

    if arg5 == nil then
        arg5 = newproxy(false)
    end

    local v4

    if arg5 then
        arg2:Remove(arg5)
        v4 = arg2[proxy]

        if not v4 then
            v4 = {}
            arg2[proxy] = v4
        end

        v4[arg5] = arg3
    end

    v4 = arg4 or (t_2[typeof(arg3)] or "Destroy")
    arg4 = v4

    if type(arg3) ~= "function" and not arg3[arg4] then
        warn(
            string.format(
                "Object %s doesn't have method %s, are you sure you want to add it? Traceback: %s",
                tostring(arg3),
                tostring(arg4),
                debug.traceback(nil, 2)
            )
        )
    end

    arg2[arg3] = arg4

    return arg3, arg5
end

t.__index.Give = t.__index.Add

function t.__index.AddObject(arg6, arg7) -- line: 131
    local proxy_2 = newproxy(false)

    return arg6:Add(arg7, false, proxy_2), proxy_2
end

t.__index.GiveObject = t.__index.AddObject

function t.__index.Remove(arg8, arg9) -- line: 155
    -- upvalues:
    --  [1] proxy (copy)

    local v6 = arg8[proxy]

    if v6 then
        local v7 = v6[arg9]

        if v7 then
            local v8 = arg8[v7]

            if v8 then
                if v8 == true then
                    v7()
                else
                    local v9 = v7[v8]

                    if v9 then
                        v9(v7)
                    end
                end

                arg8[v7] = nil
            end

            v6[arg9] = nil
        end
    end

    return arg8
end

function t.__index.Get(arg10, arg11) -- line: 189
    -- upvalues:
    --  [1] proxy (copy)

    local v10 = arg10[proxy]

    if v10 then
        return v10[arg11]
    end
end

function t.__index.Cleanup(arg12) -- line: 200
    -- upvalues:
    --  [1] proxy (copy)

    if not arg12.CurrentlyCleaning then
        arg12.CurrentlyCleaning = nil

        for key, val in next, arg12 do
            if key ~= proxy then
                local v11 = type(key)

                if v11 == "string" or v11 == "number" then
                    arg12[key] = nil
                else
                    if val == true then
                        key()
                    else
                        local v12 = key[val]

                        if v12 then
                            v12(key)
                        end
                    end

                    arg12[key] = nil
                end
            end
        end

        local v13 = arg12[proxy]

        if v13 then
            for key_1, _ in next, v13 do
                v13[key_1] = nil
            end

            arg12[proxy] = {}
        end

        arg12.CurrentlyCleaning = false
    end
end

t.__index.Clean = t.__index.Cleanup

function t.__index.Destroy(arg13) -- line: 246
    arg13:Cleanup()
end

t.__call = t.__index.Cleanup
local t_4 = { Connected = true }
t_4.__index = t_4

function t_4.Disconnect(arg14) -- line: 260
    if arg14.Connected then
        arg14.Connected = false
        arg14.Connection:Disconnect()
    end
end

function t_4.__tostring(arg15) -- line: 267
    return "Disconnect<" .. tostring(arg15.Connected) .. ">"
end

function t.__index.LinkToInstance(arg16, arg17, arg18) -- line: 277
    -- upvalues:
    --  [1] proxy_1 (copy)
    --  [2] t_4 (copy)
    --  [3] Heartbeat (copy)

    local v14 = arg18 and newproxy(false) or proxy_1
    local v15 = if arg17.Parent ~= nil then false else true
    local t_5 = setmetatable({}, t_4)
    local v16 = nil

    local function ChangedFunction(_, arg20) -- line: 283
        -- upvalues:
        --  [1] t_5 (copy)
        --  [2] v15 (ref)
        --  [3] Heartbeat (ref)
        --  [4] v16 (ref)
        --  [5] arg16 (copy)

        if t_5.Connected then
            v15 = if arg20 ~= nil then false else true

            if v15 then
                coroutine.wrap(function() -- line: 289
                    -- upvalues:
                    --  [1] Heartbeat (ref)
                    --  [2] t_5 (ref)
                    --  [3] v16 (ref)
                    --  [4] arg16 (ref)
                    --  [5] v15 (ref)

                    Heartbeat:Wait()

                    if not t_5.Connected then
                        return
                    end

                    if not v16.Connected then
                        arg16:Cleanup()

                        return
                    end

                    while true do
                        if not v15 then
                            break
                        end

                        if not v16.Connected or not t_5.Connected then
                            break
                        end

                        Heartbeat:Wait()
                    end

                    if t_5.Connected and v15 then
                        arg16:Cleanup()
                    end
                end)()
            end
        end
    end

    v16 = arg17.AncestryChanged:Connect(ChangedFunction)
    t_5.Connection = v16

    if v15 and t_5.Connected then
        v15 = if arg17.Parent ~= nil then false else true

        if v15 then
            coroutine.wrap(function() -- line: 289
                -- upvalues:
                --  [1] Heartbeat (ref)
                --  [2] t_5 (copy)
                --  [3] v16 (ref)
                --  [4] arg16 (copy)
                --  [5] v15 (ref)

                Heartbeat:Wait()

                if not t_5.Connected then
                    return
                end

                if not v16.Connected then
                    arg16:Cleanup()

                    return
                end

                while true do
                    if not v15 then
                        break
                    end

                    if not v16.Connected or not t_5.Connected then
                        break
                    end

                    Heartbeat:Wait()
                end

                if t_5.Connected and v15 then
                    arg16:Cleanup()
                end
            end)()
        end
    end

    return arg16:Add(t_5, "Disconnect", v14)
end

function t.__index.LinkToInstances(arg21, ...) -- line: 325
    -- upvalues:
    --  [1] t (copy)

    local v18 = t.new()

    for _, val_2 in ipairs({ ... }) do
        v18:Add(arg21:LinkToInstance(val_2, true), "Disconnect")
    end

    return v18
end

for key_3, val_3 in next, t.__index do
    t.__index[string.sub(string.lower(key_3), 1, 1) .. string.sub(key_3, 2)] = val_3
end

return t
