-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Chat.DialogueClient.DialogueManager.Actions.npcTypes.Trainer
-- Class: ModuleScript
-- bytes: 1414

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContextActionService = game:GetService("ContextActionService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function main(arg1) -- line: 8
    -- upvalues:
    --  [1] ContextActionService (copy)
    --  [2] LocalPlayer (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] PlayerGui (copy)

    ContextActionService:UnbindAction("ChatSkipKeys")
    arg1:HideChatBox()
    local Owner = arg1.Owner
    local Character = LocalPlayer.Character
    local v1 = ReplicatedStorage.UI[Owner.Name]:Clone()
    v1.Parent = PlayerGui
    local v2 = ReplicatedStorage.UI.TrainerClient:Clone()
    v2.Parent = v1
    v2.Enabled = true
    local v3 = true

    repeat
        task.wait()
        local _, Result = pcall(function() -- line: 26
            -- upvalues:
            --  [1] Character (copy)
            --  [2] Owner (copy)
            --  [3] v3 (ref)

            local v4 = Character and Character.PrimaryPart
            local v5 = Owner and Owner.PrimaryPart

            if not v4 or not v5 or (v4.Position - v5.Position).Magnitude > 15 then
                v3 = false
            end
        end)

        if Result then
            warn(Result)
        end

        local _ = warn
    until not v3

    v1:Destroy()
end

return main
