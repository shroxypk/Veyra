-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.queries.query
-- Class: ModuleScript
-- bytes: 2705

local _: any = game:GetService("Players")
local RunService: any = game:GetService("RunService")
local _: any = require(script.Parent.Parent.types)
local Client_m: any = require(script.Parent.Parent.process.client)
local v1: any = require(script.Parent.Parent.process.server)
v1 = if RunService:IsServer() then "server" else "client"

return function(arg1: any, n1: number) -- line: 12
    -- upvalues:
    --  [1] Client_m (copy)
    --  [2] v1 (copy)

    local t: any = {}
    local _: any = arg1.response.write
    local t_1: any = {
        requestReader = arg1.request.read,
        responseReader = arg1.response.read,
        responseWriter = arg1.response.write
    }

    if v1 == "client" then
        local Invoke = Client_m.invoke
        local Write_1 = arg1.request.write

        function t_1.invoke(arg2) -- line: 26
            -- upvalues:
            --  [1] Invoke (copy)
            --  [2] n1 (copy)
            --  [3] Write_1 (copy)

            return (Invoke(n1, Write_1, arg2))
        end
    end

    function t_1.wait() -- line: 33
        -- upvalues:
        --  [1] t (copy)

        local thread: any = coroutine.running()
        local v2: number = nil
        table.insert(t, function(arg3, arg4) -- line: 37
            -- upvalues:
            --  [1] thread (copy)
            --  [2] t (ref)
            --  [3] v2 (ref)

            print(arg3)
            task.spawn(thread, arg3, arg4)
            table.remove(t, v2)
        end)
        v2 = #t

        return coroutine.yield()
    end

    function t_1.listen(arg5) -- line: 49
        -- upvalues:
        --  [1] t (copy)
        --  [2] t_1 (copy)

        table.insert(t, arg5)

        return function() -- line: 52
            -- upvalues:
            --  [1] t_1 (ref)
            --  [2] arg5 (copy)

            t_1.disconnect(arg5)
        end
    end

    function t_1.disconnectAll() -- line: 57
        -- upvalues:
        --  [1] t (copy)

        table.clear(t)
    end

    function t_1.disconnect(arg6) -- line: 62
        -- upvalues:
        --  [1] t (copy)

        for key, val in t do
            if val ~= arg6 then
                if typeof(val) == "table" and val.OnceCallback == arg6 then
                    table.remove(t, key)

                    return
                end
            else
                table.remove(t, key)

                return
            end
        end
    end

    function t_1.listenOnce(arg7) -- line: 71
        -- upvalues:
        --  [1] t (copy)

        table.insert(t, { OnceCallback = arg7 })
    end

    function t_1.getListeners() -- line: 77
        -- upvalues:
        --  [1] t (copy)

        return t
    end

    return t_1
end
