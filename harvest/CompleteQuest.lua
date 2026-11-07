-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Chat.DialogueClient.DialogueManager.Actions.CompleteQuest
-- Class: ModuleScript
-- bytes: 554

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function main(arg1) -- line: 6
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Services_m (copy)

    local Owner = arg1.Owner
    local v2 = arg1:GetCurrentNode().quest or Owner.Name
    ReplicatedStorage.Remotes.Client.UpdateQuestLog:FireServer("Complete", v2)
    Services_m.PlaySound(ReplicatedStorage.SFX.Misc.QuestCompletion, script)
end

return main
