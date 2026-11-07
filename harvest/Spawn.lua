-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Chat.DialogueClient.DialogueManager.Actions.npcTypes.Spawn
-- Class: ModuleScript
-- bytes: 342

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function main(arg1) -- line: 6
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    ReplicatedStorage.Remotes.NPC:FireServer("SetSpawn", arg1.Owner)
end

return main
