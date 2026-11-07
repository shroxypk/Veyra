-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.Multipliers.Profession
-- Class: ModuleScript
-- bytes: 1295

local Players = game:GetService("Players")
local Professions_m = require(game:GetService("ReplicatedStorage").Modules.Professions)

return function(arg1, arg2, _, _) -- line: 13
    -- upvalues:
    --  [1] Players (copy)
    --  [2] Professions_m (copy)

    if not arg1 or not arg2 then
        return 0
    end

    local playerFromCharacter = Players:GetPlayerFromCharacter(arg1)

    if playerFromCharacter and not Players:GetPlayerFromCharacter(arg2) then
        local Combat = Professions_m:GetPlayerBenefits(playerFromCharacter, "Combat")
        local v1 = Combat.pve_damage or 0

        if arg2:GetAttribute("Boss") then
            v1 += Combat.boss_damage or 0
        end

        local Humanoid = arg2:FindFirstChildWhichIsA("Humanoid")

        if Humanoid then
            v1 = if not (Humanoid.MaxHealth > 0) then v1 else if not (Humanoid.Health / Humanoid.MaxHealth < 0.3) then v1 else v1 + (Combat.execute_damage or 0)
        end

        if (Combat.warlord or 0) > 0 then
            local v2 = arg1:GetAttribute("WarlordStacks") or 0

            if v2 > 0 then
                if (arg1:GetAttribute("WarlordExpires") or 0) > os.clock() then
                    v1 += v2 * 0.03
                end
            end
        end

        return v1
    end

    return 0
end
