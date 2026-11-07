-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.Multipliers.Family Name
-- Class: ModuleScript
-- bytes: 1276

local Players = game:GetService("Players")
local Modules = game:GetService("ReplicatedStorage").Modules
local Names_m = require(Modules.Names)
local StatManager_m = require(Modules.StatManager)

return function(arg1, _, arg3, _) -- line: 13
    -- upvalues:
    --  [1] Players (copy)
    --  [2] Names_m (copy)
    --  [3] StatManager_m (copy)

    if not arg1 or not arg3 then
        return 0
    end

    local playerFromCharacter = Players:GetPlayerFromCharacter(arg1)

    if not playerFromCharacter then
        return 0
    end

    local v1 = Names_m:GetFamilyBuffs(playerFromCharacter)

    if next(v1) == nil then
        return 0
    end

    local AttackTypes = arg3.AttackTypes

    if type(AttackTypes) ~= "table" then
        return 0
    end

    local v2 = 0

    if table.find(AttackTypes, "P") then
        v2 += tonumber(v1.PhysicalDamage) or 0
    end

    if table.find(AttackTypes, "M") then
        v2 += tonumber(v1.MagicDamage) or 0

        if v1.Magic then
            local v3 = StatManager_m.require(playerFromCharacter)
            local v4 = v3

            if v4 then
                v4 = v3:GetStat("Magic")
            end

            v2 += Names_m:GetFamilyMagicBonus(playerFromCharacter, v4)
        end
    end

    return v2 / 100
end
