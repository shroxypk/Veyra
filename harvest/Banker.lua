-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Chat.DialogueClient.DialogueManager.Actions.npcTypes.Banker
-- Class: ModuleScript
-- bytes: 625

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContextActionService = game:GetService("ContextActionService")

local function main(arg1) -- line: 5
    -- upvalues:
    --  [1] ContextActionService (copy)
    --  [2] Players (copy)
    --  [3] ReplicatedStorage (copy)

    ContextActionService:UnbindAction("ChatSkipKeys")
    arg1:HideChatBox()
    local _ = arg1.Owner
    local _ = Players.LocalPlayer.Character
    ReplicatedStorage.Remotes.Bank:InvokeServer("StartBanking")
    ReplicatedStorage.Remotes.Bank:InvokeServer("StopBanking")
end

return main
