-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions._Quest
-- Class: ModuleScript
-- bytes: 565

local _ = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local v1 = ServerStorage.GameModules:FindFirstChild("AttackNPCS")

if v1 then
    v1 = require(ServerStorage.GameModules.AttackNPCS)
end

return function(arg1, arg2, _) -- line: 6
    -- upvalues:
    --  [1] v1 (copy)

    if not v1 then
        return
    end

    local v2 = v1:GET_STATS(arg2.Name)

    if not v2 then
        return
    end

    local Task = v2.Task

    if Task == "Hit the Training Dummy" then
        _G.UpdateTask(arg1, Task)
    end
end
