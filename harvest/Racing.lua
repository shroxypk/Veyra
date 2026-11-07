-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Chat.DialogueClient.DialogueManager.Actions.npcTypes.Racing
-- Class: ModuleScript
-- bytes: 510

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function main(arg1) -- line: 6
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    local Owner = arg1.Owner
    local RacingRemote = ReplicatedStorage.Remotes.RacingRemote
    local v2 = Owner:FindFirstChild("Course")

    if v2 then
        v2 = Owner.Course.Value
    end

    RacingRemote:FireServer("Start", v2)
end

return main
