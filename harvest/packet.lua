-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.packets.packet
-- Class: ModuleScript
-- bytes: 4684

local Players: any = game:GetService("Players")
local RunService: any = game:GetService("RunService")
local _: any = require(script.Parent.Parent.types)
local Client_m: any = require(script.Parent.Parent.process.client)
local Server_m: any = require(script.Parent.Parent.process.server)
local v1 = if RunService:IsServer() then "server" else "client"

return function(arg1: any, n1: number) -- line: 16
    -- upvalues:
    --  [1] Server_m (copy)
    --  [2] Client_m (copy)
    --  [3] v1 (copy)
    --  [4] Players (copy)

    local v2: any = arg1.reliabilityType or "reliable"
    local t: any = {}
    local v3: (...any) -> ...any = if v2 ~= "reliable" then Server_m.sendPlayerUnreliable else Server_m.sendPlayerReliable
    local v4: (...any) -> ...any = if v2 ~= "reliable" then Server_m.sendAllUnreliable else Server_m.sendAllReliable
    local v5: (...any) -> ...any = if v2 ~= "reliable" then Client_m.sendUnreliable else Client_m.sendReliable
    local Write: any = arg1.value.write
    local t_1: any = {}
    setmetatable(t_1, {
        __index = function(arg2) --[[ __index ]] -- line: 43
            -- upvalues:
            --  [1] v1 (ref)

            if (arg2 == "sendTo" or arg2 == "sendToAllExcept" or arg2 == "sendToAll") and v1 == "client" then
                error("You cannot use sendTo, sendToAllExcept, or sendToAll on the client")

                return
            end

            if arg2 == "send" and v1 == "server" then
                error("You cannot use send on the server")
            end
        end
    })
    t_1.reader = arg1.value.read

    if v1 == "server" then
        function t_1.sendToList(arg3: any, t1: table) -- line: 59
            -- upvalues:
            --  [1] v3 (copy)
            --  [2] n1 (copy)
            --  [3] Write (copy)

            for _, val in t1 do
                v3(val, n1, Write, arg3)
            end
        end

        function t_1.sendTo(arg4: any, u1: userdata) -- line: 65
            -- upvalues:
            --  [1] v3 (copy)
            --  [2] n1 (copy)
            --  [3] Write (copy)

            v3(u1, n1, Write, arg4)
        end

        function t_1.sendToAllExcept(arg5: any, u2: userdata) -- line: 69
            -- upvalues:
            --  [1] Players (ref)
            --  [2] v3 (copy)
            --  [3] n1 (copy)
            --  [4] Write (copy)

            for _, val_1 in Players:GetPlayers() do
                if val_1 ~= u2 then
                    v3(val_1, n1, Write, arg5)
                end
            end
        end

        function t_1.sendToAll(arg6) -- line: 77
            -- upvalues:
            --  [1] v4 (copy)
            --  [2] n1 (copy)
            --  [3] Write (copy)

            v4(n1, Write, arg6)
        end
    elseif v1 == "client" then
        function t_1.send(arg7) -- line: 81
            -- upvalues:
            --  [1] v5 (copy)
            --  [2] n1 (copy)
            --  [3] Write (copy)

            v5(n1, Write, arg7)
        end
    end

    function t_1.wait() -- line: 86
        -- upvalues:
        --  [1] t (copy)

        local thread: any = coroutine.running()
        local v6: number = nil
        table.insert(t, function(arg8, arg9) -- line: 91
            -- upvalues:
            --  [1] thread (copy)
            --  [2] t (ref)
            --  [3] v6 (ref)

            task.spawn(thread, arg8, arg9)
            table.remove(t, v6)
        end)
        v6 = #t

        return coroutine.yield()
    end

    function t_1.listen(arg10) -- line: 105
        -- upvalues:
        --  [1] t (copy)
        --  [2] t_1 (copy)

        table.insert(t, arg10)

        return function() -- line: 108
            -- upvalues:
            --  [1] t_1 (ref)
            --  [2] arg10 (copy)

            t_1.disconnect(arg10)
        end
    end

    function t_1.disconnectAll() -- line: 113
        -- upvalues:
        --  [1] t (copy)

        table.clear(t)
    end

    function t_1.disconnect(arg11) -- line: 120
        -- upvalues:
        --  [1] t (copy)

        for key_2, val_2 in t do
            if val_2 ~= arg11 then
                if typeof(val_2) == "table" and val_2.OnceCallback == arg11 then
                    table.remove(t, key_2)

                    return
                end
            else
                table.remove(t, key_2)

                return
            end
        end
    end

    function t_1.listenOnce(arg12) -- line: 129
        -- upvalues:
        --  [1] t (copy)

        table.insert(t, { OnceCallback = arg12 })
    end

    function t_1.getListeners() -- line: 135
        -- upvalues:
        --  [1] t (copy)

        return t
    end

    return t_1
end
