-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Chat.DialogueClient.DialogueManager.Actions.npcTypes.Guild
-- Class: ModuleScript
-- bytes: 1166

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
    local Owner = arg1.Owner
    local Character = Players.LocalPlayer.Character
    ReplicatedStorage.Remotes.Guild:Fire(true)
    local v1 = true

    repeat
        task.wait()
        local _, Result = pcall(function() -- line: 18
            -- upvalues:
            --  [1] Character (copy)
            --  [2] Owner (copy)
            --  [3] v1 (ref)

            local v2 = Character and Character.PrimaryPart
            local v3 = Owner and Owner.PrimaryPart

            if not v2 or not v3 or (v2.Position - v3.Position).Magnitude > 15 then
                v1 = false
            end
        end)

        if Result then
            warn(Result)
        end
    until not v1

    ReplicatedStorage.Remotes.Guild:Fire(false)
end

return main
