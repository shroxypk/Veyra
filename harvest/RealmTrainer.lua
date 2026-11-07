-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Chat.DialogueClient.DialogueManager.Actions.npcTypes.RealmTrainer
-- Class: ModuleScript
-- bytes: 1675

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContextActionService = game:GetService("ContextActionService")
local StatManager_m = require(ReplicatedStorage.Modules.StatManager)
local Config_m = require(ReplicatedStorage.Modules.InnerRealm.Config)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function main(arg1) -- line: 14
    -- upvalues:
    --  [1] StatManager_m (copy)
    --  [2] LocalPlayer (copy)
    --  [3] Config_m (copy)
    --  [4] ReplicatedStorage (copy)
    --  [5] ContextActionService (copy)
    --  [6] PlayerGui (copy)

    local v1 = StatManager_m.require(LocalPlayer):GetStat("Magic")
    local v2 = Config_m.Trainers[v1]
    v1 = v2

    if v1 then
        v1 = ReplicatedStorage.UI:FindFirstChild(v2.Ui)
    end

    if not v1 then
        return
    end

    ContextActionService:UnbindAction("ChatSkipKeys")
    arg1:HideChatBox()
    local Owner = arg1.Owner
    local Character = LocalPlayer.Character
    local v3 = v1:Clone()

    if v3:FindFirstChild("DisplayName") then
        v3.DisplayName.Value = v2.Name
    end

    v3:SetAttribute("ChatLine", v2.ChatLine)
    v3.Parent = PlayerGui
    local v4 = ReplicatedStorage.UI.TrainerClient:Clone()
    v4.Parent = v3
    v4.Enabled = true
    v4 = true

    repeat
        task.wait()
        v1 = Character and Character.PrimaryPart
        local v5 = Owner and Owner.PrimaryPart
        v4 = if not v1 then false else if not v5 then false else if not ((v1.Position - v5.Position).Magnitude > 15) then v4 else false
    until not v4

    v3:Destroy()
end

return main
