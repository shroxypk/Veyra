-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Chat.DialogueClient.DialogueManager.Actions.npcTypes.Sell
-- Class: ModuleScript
-- bytes: 1377

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
    local Character = Players.LocalPlayer.Character
    local Owner = arg1.Owner
    task.spawn(function() -- line: 13
        -- upvalues:
        --  [1] ReplicatedStorage (ref)
        --  [2] Character (copy)
        --  [3] Owner (copy)

        ReplicatedStorage.Remotes.Player.SellEvent.Bindable:Fire(true)
        local v1 = true

        repeat
            task.wait()
            local _, _ = pcall(function() -- line: 19
                -- upvalues:
                --  [1] Character (ref)
                --  [2] Owner (ref)
                --  [3] v1 (ref)

                local v2 = Character and Character.PrimaryPart
                local v3 = Owner and Owner.PrimaryPart

                if not v2 or not v3 or (v2.Position - v3.Position).Magnitude > 15 then
                    v1 = false
                end
            end)
        until not v1

        ReplicatedStorage.Remotes.Player.SellEvent.Bindable:Fire(false)
    end)
end

return main
