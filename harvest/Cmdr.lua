-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Cmdr
-- Class: ModuleScript
-- bytes: 1173

local RunService = game:GetService("RunService")
local Util_m = require(script.Shared:WaitForChild("Util"))

if RunService:IsServer() == false then
    error("Cmdr server module is somehow running on a client!")
end

local t_2 = setmetatable({
    ReplicatedRoot = nil,
    RemoteFunction = nil,
    RemoteEvent = nil,
    Util = Util_m,
    DefaultCommandsFolder = script.BuiltInCommands
}, {
    __index = function(arg1, arg2) --[[ __index ]] -- line: 16
        local v2 = arg1.Registry[arg2]

        if v2 and type(v2) == "function" then
            return function(_, ...) -- line: 19
                -- upvalues:
                --  [1] v2 (copy)
                --  [2] arg1 (copy)

                return v2(arg1.Registry, ...)
            end
        end
    end
})
t_2.Registry = require(script.Shared.Registry)(t_2)
t_2.Dispatcher = require(script.Shared.Dispatcher)(t_2)
require(script.Initialize)(t_2)

function t_2.RemoteFunction.OnServerInvoke(arg4, arg5, arg6) -- line: 33
    -- upvalues:
    --  [1] t_2 (ref)

    if #arg5 > 100000 then
        return "Input too long"
    end

    return t_2.Dispatcher:EvaluateAndRun(arg5, arg4, arg6)
end

return t_2
