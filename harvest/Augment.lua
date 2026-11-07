-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Chat.DialogueClient.DialogueManager.Actions.types.Augment
-- Class: ModuleScript
-- bytes: 1391

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
    local v1 = ReplicatedStorage.UI.AugmentPrompt:Clone()
    v1.Parent = PlayerGui
    local v2 = true

    repeat
        task.wait()
        local _, Result = pcall(function() -- line: 22
            -- upvalues:
            --  [1] Character (copy)
            --  [2] Owner (copy)
            --  [3] v1 (copy)
            --  [4] v2 (ref)

            local v3 = Character and Character.PrimaryPart
            local v4 = Owner and Owner.PrimaryPart

            if not v3 or not v4 or (v3.Position - v4.Position).Magnitude > 15 or not v1.Parent then
                v2 = false
            end
        end)

        if Result then
            warn(Result)
        end

        local _ = warn
    until not v2

    if v1 then
        v1:Destroy()
    end
end

return main
