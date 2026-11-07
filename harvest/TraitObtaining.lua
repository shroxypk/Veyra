-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Chat.DialogueClient.DialogueManager.Actions.types.TraitObtaining
-- Class: ModuleScript
-- bytes: 1412

local Players = game:GetService("Players")
local _ = game:GetService("ReplicatedStorage")
local ContextActionService = game:GetService("ContextActionService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function main(arg1) -- line: 8
    -- upvalues:
    --  [1] ContextActionService (copy)
    --  [2] LocalPlayer (copy)
    --  [3] PlayerGui (copy)

    ContextActionService:UnbindAction("ChatSkipKeys")
    arg1:HideChatBox()
    local Owner = arg1.Owner
    local Character = LocalPlayer.Character
    local TraitUI = PlayerGui:WaitForChild("TraitUI")
    TraitUI.Enabled = true
    local v1 = true

    repeat
        task.wait()
        local _, Result = pcall(function() -- line: 22
            -- upvalues:
            --  [1] Character (copy)
            --  [2] Owner (copy)
            --  [3] v1 (ref)

            local v2 = Character and Character.PrimaryPart
            local v3 = Owner and Owner.PrimaryPart

            if not v2 or not v3 or (v2.Position - v3.Position).Magnitude > 15 then
                v1 = false
            end

            if Owner:HasTag("MeditationSpot") and not Character:GetAttribute("Meditating") then
                v1 = false
            end
        end)

        if Result then
            warn(Result)
        end

        local _ = warn
    until not v1

    TraitUI.Enabled = false
end

return main
