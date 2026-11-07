-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.Multipliers.Potion
-- Class: ModuleScript
-- bytes: 528

local Players = game:GetService("Players")
local Alchemy_m = require(game:GetService("ReplicatedStorage").Modules.Alchemy)

return function(arg1, arg2, _, _) -- line: 8
    -- upvalues:
    --  [1] Players (copy)
    --  [2] Alchemy_m (copy)

    if not arg1 or not arg2 then
        return 0
    end

    if Players:GetPlayerFromCharacter(arg1) then
        if Players:GetPlayerFromCharacter(arg2) then
            return 0
        end

        return Alchemy_m.GetEffect(arg1, "Slaying")
    else
        return 0
    end
end
