-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.InnerRealm.MagicTrainer
-- Class: ModuleScript
-- bytes: 2380

local Players = game:GetService("Players")
local StatManager_m = require(game:GetService("ReplicatedStorage").Modules.StatManager)
local Config_m = require(script.Parent.Config)

local _ = function() --[[ getTrainer ]] -- line: 11
    -- upvalues:
    --  [1] StatManager_m (copy)
    --  [2] Players (copy)
    --  [3] Config_m (copy)

    local v1 = StatManager_m.require(Players.LocalPlayer)
    local v2 = v1 and v1:GetStat("Magic") or "None"

    return v2, Config_m.Trainers[v2]
end

local t = {
    __override = true,
    start = function() --[[ start ]] -- line: 20
        -- upvalues:
        --  [1] StatManager_m (copy)
        --  [2] Players (copy)
        --  [3] Config_m (copy)

        local v3 = StatManager_m.require(Players.LocalPlayer)
        local v4 = v3 and v3:GetStat("Magic") or "None"
        local v5 = v4

        return if v5 == "None" then "locked" else if v5 ~= "" then if Config_m.Trainers[v4] then "train" else "noTrainer" else "locked"
    end,
    nodes = nil
}
local t_1 = {
    locked = {
        text = "Nothing stirs here... yet. Perhaps once a grimoire has chosen you, its memories will take shape here."
    },
    noTrainer = {
        text = "Your grimoire hovers here in silence. Its memories are too faint to teach you anything... yet."
    },
    train = {
        text = function() --[[ text ]] -- line: 41
            -- upvalues:
            --  [1] StatManager_m (copy)
            --  [2] Players (copy)
            --  [3] Config_m (copy)

            local v6 = StatManager_m.require(Players.LocalPlayer)
            local v7 = v6 and v6:GetStat("Magic") or "None"
            local v8 = Config_m.Trainers[v7]
            v6 = v8 and v8.Greeting or "..."

            return v6
        end,
        choices = { { text = "Teach me.", action = "RealmTrainer" } }
    }
}
t.nodes = t_1

return (setmetatable(t, {
    __index = function(_, arg2) --[[ __index ]] -- line: 57
        -- upvalues:
        --  [1] StatManager_m (copy)
        --  [2] Players (copy)
        --  [3] Config_m (copy)

        if arg2 == "DisplayName" then
            local v9 = StatManager_m.require(Players.LocalPlayer)
            local v10 = v9 and v9:GetStat("Magic") or "None"
            local v11 = Config_m.Trainers[v10]
            v9 = v11 and v11.Name or "Grimoire Echo"

            return v9
        end

        return nil
    end
}))
