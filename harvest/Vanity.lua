-- Decompiled with Veyra harvester
-- Instance: StarterGui.Vanity
-- Class: LocalScript
-- bytes: 8056

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local StarterGui = game:GetService("StarterGui")
local v2, v3, _, v5, _, _, _ = require(ReplicatedStorage.Modules.scriptObjs).new()
local Chatting = v5.Chatting
local Cinematic = v5.Cinematic
local InGUI = v5.InGUI
local Event = v5.Event
local ViewingInventory = v5.ViewingInventory
Chatting.Value = false
InGUI.Value = false
Event.Value = ""
ViewingInventory.Value = false
local PlayerGui = v2:WaitForChild("PlayerGui")
local CurrencyUI = PlayerGui:WaitForChild("CurrencyUI")
local DangerUI = PlayerGui:WaitForChild("DangerUI")
local List = PlayerGui:WaitForChild("List")
local Gameplay = PlayerGui:WaitForChild("Gameplay")
local Backpack = Gameplay:WaitForChild("Backpack")
local _ = Gameplay:WaitForChild("Chat")
local CinematicMode = Gameplay:WaitForChild("CinematicMode")
local Player = Gameplay.Player
local Main = Gameplay.Main
local Quest = Gameplay:FindFirstChild("Quest")
local _ = { "Dead", "Event", "Chatting", "Cinematic", "GUI", "Gameplay" }

local _ = function() --[[ getState ]] -- line: 43
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] CollectionService (copy)
    --  [3] Event (copy)
    --  [4] Chatting (copy)
    --  [5] Cinematic (copy)
    --  [6] InGUI (copy)

    if v3:GetAttribute("InCutscene") then
        return "Cutscene"
    end

    if CollectionService:HasTag(v3, "Dead") then
        return "Dead"
    end

    return if Event.Value == "" then if not Chatting.Value then if not Cinematic.Value then if not InGUI.Value then "Gameplay" else "GUI" else "Cinematic" else "Chat" else "Event"
end

local t_1 = {
    Cutscene = function() -- line: 83
        -- upvalues:
        --  [1] Player (copy)
        --  [2] Backpack (copy)
        --  [3] Main (copy)
        --  [4] Quest (copy)
        --  [5] CinematicMode (copy)
        --  [6] StarterGui (copy)
        --  [7] List (copy)
        --  [8] CurrencyUI (copy)
        --  [9] DangerUI (copy)

        Player.Visible = false
        Backpack.Visible = false
        Main.Visible = false

        if Quest then
            Quest.Visible = false
        end

        CinematicMode.Visible = false
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
        List.Enabled = false
        CurrencyUI.Enabled = false
        DangerUI.Enabled = false

        if Quest then
            Quest.Visible = false
        end
    end,
    Dead = function() -- line: 97
        -- upvalues:
        --  [1] Player (copy)
        --  [2] Backpack (copy)
        --  [3] Main (copy)
        --  [4] Quest (copy)
        --  [5] CinematicMode (copy)
        --  [6] DangerUI (copy)

        Player.Visible = false
        Backpack.Visible = false
        Main.Visible = false

        if Quest then
            Quest.Visible = false
        end

        CinematicMode.Visible = false
        DangerUI.Enabled = false
    end,
    Event = function() -- line: 103
        -- upvalues:
        --  [1] Player (copy)
        --  [2] Backpack (copy)
        --  [3] Main (copy)
        --  [4] Quest (copy)
        --  [5] CinematicMode (copy)

        Player.Visible = false
        Backpack.Visible = false
        Main.Visible = false

        if Quest then
            Quest.Visible = false
        end

        CinematicMode.Visible = false
    end,
    Chat = function() -- line: 108
        -- upvalues:
        --  [1] Player (copy)
        --  [2] Backpack (copy)
        --  [3] Main (copy)
        --  [4] Quest (copy)
        --  [5] CinematicMode (copy)

        Player.Visible = false
        Backpack.Visible = false
        Main.Visible = false

        if Quest then
            Quest.Visible = false
        end

        CinematicMode.Visible = false

        if Quest then
            Quest.Visible = true
        end
    end,
    Cinematic = function() -- line: 117
        -- upvalues:
        --  [1] Player (copy)
        --  [2] Backpack (copy)
        --  [3] Main (copy)
        --  [4] Quest (copy)
        --  [5] CinematicMode (copy)
        --  [6] DangerUI (copy)
        --  [7] CurrencyUI (copy)

        Player.Visible = false
        Backpack.Visible = false
        Main.Visible = false

        if Quest then
            Quest.Visible = false
        end

        CinematicMode.Visible = true
        DangerUI.Enabled = false
        CurrencyUI.Enabled = false
    end,
    GUI = function() -- line: 124
        -- upvalues:
        --  [1] Player (copy)
        --  [2] Main (copy)
        --  [3] CinematicMode (copy)
        --  [4] DangerUI (copy)
        --  [5] StarterGui (copy)
        --  [6] List (copy)
        --  [7] Backpack (copy)
        --  [8] ViewingInventory (copy)
        --  [9] Quest (copy)

        Player.Visible = false
        Main.Visible = true
        CinematicMode.Visible = false
        DangerUI.Enabled = true
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
        List.Enabled = false
        Backpack.Visible = ViewingInventory.Value
        Backpack.Toolbar.Order.Visible = ViewingInventory.Value

        if Quest then
            Quest.Visible = false
        end
    end,
    Gameplay = function() -- line: 141
        -- upvalues:
        --  [1] Player (copy)
        --  [2] Main (copy)
        --  [3] CinematicMode (copy)
        --  [4] DangerUI (copy)
        --  [5] StarterGui (copy)
        --  [6] v2 (copy)
        --  [7] List (copy)
        --  [8] CurrencyUI (copy)
        --  [9] Backpack (copy)
        --  [10] Quest (copy)

        Player.Visible = true
        Main.Visible = true
        CinematicMode.Visible = false
        DangerUI.Enabled = true
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, v2:GetAttribute("Loaded") or false)
        List.Enabled = true
        CurrencyUI.Enabled = true
        Backpack.Visible = true
        Backpack.Toolbar.Order.Visible = true

        if Quest then
            Quest.Visible = true
        end
    end
}

local _ = function(arg1) --[[ setAllVisible ]] -- line: 73
    -- upvalues:
    --  [1] Player (copy)
    --  [2] Backpack (copy)
    --  [3] Main (copy)
    --  [4] Quest (copy)

    Player.Visible = arg1
    Backpack.Visible = arg1
    Main.Visible = arg1

    if Quest then
        Quest.Visible = arg1
    end
end

local v10 = nil

local function updateState() -- line: 161
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] CollectionService (copy)
    --  [3] Event (copy)
    --  [4] Chatting (copy)
    --  [5] Cinematic (copy)
    --  [6] InGUI (copy)
    --  [7] v10 (ref)
    --  [8] t_1 (copy)

    local v11 = if v3:GetAttribute("InCutscene") then "Cutscene" else if CollectionService:HasTag(
        v3,
        "Dead"
    ) then "Dead" else if Event.Value == "" then if not Chatting.Value then if not Cinematic.Value then if not InGUI.Value then "Gameplay" else "GUI" else "Cinematic" else "Chat" else "Event"

    if v11 == v10 then
    end

    v10 = v11
    local v12 = t_1[v11]

    if v12 then
        v12()
    end
end

CollectionService:GetInstanceAddedSignal("Dead"):Connect(updateState)
CollectionService:GetInstanceRemovedSignal("Dead"):Connect(updateState)
Cinematic:GetPropertyChangedSignal("Value"):Connect(updateState)
Chatting:GetPropertyChangedSignal("Value"):Connect(updateState)
InGUI:GetPropertyChangedSignal("Value"):Connect(updateState)
Event:GetPropertyChangedSignal("Value"):Connect(updateState)
ViewingInventory:GetPropertyChangedSignal("Value"):Connect(updateState)
v3:GetAttributeChangedSignal("InCutscene"):Connect(updateState)
local v13 = if v3:GetAttribute("InCutscene") then "Cutscene" else if CollectionService:HasTag(
    v3,
    "Dead"
) then "Dead" else if Event.Value == "" then if not Chatting.Value then if not Cinematic.Value then if not InGUI.Value then "Gameplay" else "GUI" else "Cinematic" else "Chat" else "Event"

if v13 == v10 then
end

v10 = v13
local v14 = t_1[v13]

if v14 then
    v14()
end
