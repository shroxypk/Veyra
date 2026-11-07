-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.TraitRequirements
-- Class: ModuleScript
-- bytes: 1686

local t = {}
local t_1 = {
    NPCKills = "NPC Kills",
    PlayerKills = "Player Kills",
    SpiritMeter = function() --[[ SpiritMeter ]] -- line: 16
        return "Full Spirit Meter"
    end,
    AirDashUnlocked = function() --[[ AirDashUnlocked ]] -- line: 19
        return "Air Dash unlocked"
    end
}

local function statLine(arg1, arg2) -- line: 24
    -- upvalues:
    --  [1] t_1 (copy)

    local v1 = t_1[arg1] or arg1

    if type(v1) == "function" then
        return v1(arg2)
    end

    return `{arg2} {v1}`
end

function t.lines(arg3) -- line: 33
    -- upvalues:
    --  [1] statLine (copy)

    local t_2 = {}
    local v2 = arg3 and arg3.Required

    if type(v2) ~= "table" then
        return t_2
    end

    local Stat = v2.Stat

    if type(Stat) == "table" then
        if Stat.Level then
            table.insert(t_2, `Level {Stat.Level}`)
        end

        local t_3 = {}

        for key in Stat do
            if key ~= "Level" then
                table.insert(t_3, key)
            end
        end

        table.sort(t_3)

        for _, val in t_3 do
            table.insert(t_2, statLine(val, Stat[val]))
        end
    end

    if type(v2.Quest) == "string" then
        table.insert(t_2, `Quest: {v2.Quest}`)
    end

    if type(v2.Prereq) == "table" then
        local t_4 = {}

        for key_2 in v2.Prereq do
            table.insert(t_4, key_2)
        end

        table.sort(t_4)

        for _, val_1 in t_4 do
            table.insert(t_2, `Trait: {val_1}`)
        end
    end

    return t_2
end

function t.text(arg4) -- line: 79
    -- upvalues:
    --  [1] t (copy)

    return table.concat(t.lines(arg4), " + ")
end

return t
