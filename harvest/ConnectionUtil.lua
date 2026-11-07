-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CommonUtils.ConnectionUtil
-- Class: ModuleScript
-- bytes: 956

local t = {}
t.__index = t

function t.new() -- line: 25
    -- upvalues:
    --  [1] t (copy)

    local t_1 = setmetatable({}, t)
    t_1._connections = {}

    return t_1
end

function t.trackConnection(arg1, arg2, arg3) -- line: 33
    if arg1._connections[arg2] then
        arg1._connections[arg2]()
    end

    arg1._connections[arg2] = function() -- line: 38
        -- upvalues:
        --  [1] arg3 (copy)

        arg3:Disconnect()
    end
end

function t.trackBoundFunction(arg4, arg5, arg6) -- line: 41
    if arg4._connections[arg5] then
        arg4._connections[arg5]()
    end

    arg4._connections[arg5] = arg6
end

function t.disconnect(arg7, arg8) -- line: 48
    if arg7._connections[arg8] then
        arg7._connections[arg8]()
        arg7._connections[arg8] = nil
    end
end

function t.disconnectAll(arg9) -- line: 55
    for _, val in pairs(arg9._connections) do
        val()
    end

    arg9._connections = {}
end

return t
