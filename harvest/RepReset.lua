-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Chat.DialogueClient.DialogueManager.Actions.types.RepReset
-- Class: ModuleScript
-- bytes: 441

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("ContextActionService")
local LocalPlayer = Players.LocalPlayer

local function main(arg1) -- line: 8
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] ReplicatedStorage (copy)

    local _ = LocalPlayer.Character
    ReplicatedStorage.Remotes.RepResetRemote:FireServer(arg1.Owner)
end

return main
