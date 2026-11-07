-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.Multipliers.Grimoire Mastery
-- Class: ModuleScript
-- bytes: 527

local GrimoireMastery_m = require(game:GetService("ReplicatedStorage").Modules.GrimoireMastery)

return function(arg1, _, arg3, _) -- line: 7
    -- upvalues:
    --  [1] GrimoireMastery_m (copy)

    if not arg1 or not arg3 or arg3.NoGrimoireMastery then
        return 0
    end

    local AttackTypes = arg3.AttackTypes

    if AttackTypes then
        if not table.find(AttackTypes, "M") then
            return 0
        end

        return GrimoireMastery_m.GetBonus(arg1, "Damage")
    else
        return 0
    end
end
