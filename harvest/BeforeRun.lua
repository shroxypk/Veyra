-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Types.BeforeRun
-- Class: ModuleScript
-- bytes: 484

local Permissions_m = require(
    require(game:GetService("ReplicatedFirst").Services).ReplicatedStorage.Modules.Permissions
)

return function(arg1) -- line: 6
    -- upvalues:
    --  [1] Permissions_m (copy)

    arg1:RegisterHook("BeforeRun", function(arg2) -- line: 7
        -- upvalues:
        --  [1] Permissions_m (ref)

        if not Permissions_m:HasAccess(arg2.Executor) then
            return "You don't have permission to run this command!"
        end
    end)
end
