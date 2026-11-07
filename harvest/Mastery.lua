-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Chat.DialogueClient.DialogueManager.Actions.types.Mastery
-- Class: ModuleScript
-- bytes: 462

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("ContextActionService")
local LocalPlayer = Players.LocalPlayer

local function main(arg1) -- line: 8
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] ReplicatedStorage (copy)

    local _ = arg1.Owner
    local _ = LocalPlayer.Character
    ReplicatedStorage.Remotes.Mastery:InvokeServer("Challenge")
end

return main
