-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.InnerRealm.TrainingDummies
-- Class: ModuleScript
-- bytes: 1387

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StatManager_m = require(ReplicatedStorage.Modules.StatManager)
local Config_m = require(script.Parent.Config)
local InnerRealm = ReplicatedStorage.Remotes:WaitForChild("InnerRealm")

local _ = function() --[[ getData ]] -- line: 12
    -- upvalues:
    --  [1] StatManager_m (copy)
    --  [2] Players (copy)

    return StatManager_m.require(Players.LocalPlayer)
end

local t = {
    DisplayName = "Training Dummies",
    __override = true,
    start = function() --[[ start ]] -- line: 20
        -- upvalues:
        --  [1] StatManager_m (copy)
        --  [2] Players (copy)

        if StatManager_m.require(Players.LocalPlayer):GetStat("RealmDummiesRepaired") then
            return "repaired"
        end

        return "broken"
    end,
    nodes = nil
}
local t_1 = { broken = nil, repaired = nil }
local t_2 = {
    text = `The training dummies lie in pieces. With some work they could stand again. Repairing them costs [b]{Config_m.DummyRepairCost} Marks[/b].`,
    choices = nil
}
local t_3 = {
    text = `Repair them ({Config_m.DummyRepairCost} Marks).`,
    chatEvent = { remote = InnerRealm, args = { "RepairDummies" } }
}
t_2.choices = { t_3 }
t_1.broken = t_2
t_1.repaired = { text = "The training dummies stand ready for you." }
t.nodes = t_1

return t
