-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.Multipliers.Superiority Complex
-- Class: ModuleScript
-- bytes: 821

local Players = game:GetService("Players")
local StatManager_m = require(game:GetService("ReplicatedStorage").Modules.StatManager)

return function(arg1, arg2, arg3) -- line: 8
    -- upvalues:
    --  [1] Players (copy)
    --  [2] StatManager_m (copy)

    local _ = table.find(arg3.AttackTypes, "M")
    local playerFromCharacter = Players:GetPlayerFromCharacter(arg1)
    local playerFromCharacter_1 = Players:GetPlayerFromCharacter(arg2)
    local v2 = StatManager_m.require(playerFromCharacter)
    local v3 = StatManager_m.require(playerFromCharacter_1)
    local v4 = v2

    if v4 then
        v4 = v3

        if v4 then
            v4 = if v3:GetStat("Magic") ~= v2:GetStat("Magic") then false else true
        end
    end

    return if arg1:FindFirstChild("Superiority Complex") and v4 then 0.05 else 0
end
