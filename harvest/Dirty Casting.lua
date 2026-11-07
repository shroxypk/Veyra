-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.Multipliers.Dirty Casting
-- Class: ModuleScript
-- bytes: 489

local StateManager_m = require(game:GetService("ReplicatedStorage").Modules.StateManager)

local function main(u1: userdata, _: userdata, arg1: any) -- line: 7
    -- upvalues:
    --  [1] StateManager_m (copy)

    local v1 = table.find(arg1.AttackTypes, "M")
    local v2 = StateManager_m.require(u1)
    local v3 = 0

    if v1 and v2:HasState("Dirty Casting Multiplier") then
        v2:RemoveState("Dirty Casting Multiplier")
        v3 = 0.15
    end

    return v3
end

return main
