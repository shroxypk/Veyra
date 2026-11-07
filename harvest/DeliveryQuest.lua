-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Chat.DialogueClient.DialogueManager.Actions.DeliveryQuest
-- Class: ModuleScript
-- bytes: 380

local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function main(arg1) -- line: 4
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    local Owner = arg1.Owner
    ReplicatedStorage.Remotes.Client.UpdateQuestLog:FireServer(
        "Delivery",
        arg1:GetCurrentNode().quest,
        Owner
    )
end

return main
