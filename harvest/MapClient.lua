-- Decompiled with Veyra harvester
-- Instance: StarterGui.Map.MapClient
-- Class: LocalScript
-- bytes: 10271

local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("TweenService")
local _ = game:GetService("RunService")
local _ = game:GetService("CollectionService")
local Modules = ReplicatedStorage.Modules
local _ = require(Modules.Permissions)
local MapService_m = require(Modules.MapService)
local _ = require(Modules.StatManager)
local BackpackUtils_m = require(Modules.BackpackUtils)
local CreateBindableAction_m = require(Modules.CreateBindableAction)
local GamepadLayer_m = require(Modules.GamepadLayer)
local v1, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local Settings = v1:WaitForChild("Settings")
local Bin = v1:WaitForChild("bin")
local Map = v1:WaitForChild("Binds"):WaitForChild("Map")
local Main = script.Parent.Main
local Filters = Main.Filters
local v3 = Main.Contents
local _ = v3.MapImage
MapService_m.init(v3, Main.Zoom)
Main.Centralize.MouseButton1Up:Connect(function() -- line: 58
    -- upvalues:
    --  [1] MapService_m (copy)

    MapService_m.centerOnPlayer()
end)
Main.Centralize.MouseEnter:Connect(function() -- line: 61
    -- upvalues:
    --  [1] BackpackUtils_m (copy)

    BackpackUtils_m:ShowHover(
        { key = "Center Position", text = "Focus the map around your current position" }
    )
end)
Main.Centralize.MouseLeave:Connect(function() -- line: 67
    -- upvalues:
    --  [1] BackpackUtils_m (copy)

    BackpackUtils_m:HideHover()
end)

function MapService_m.onWaypointChanged(arg1) -- line: 71
    -- upvalues:
    --  [1] Main (copy)

    Main.Click.Text = if arg1 then "Click pin to clear it" else "Click anywhere to place a waypoint"
end

function MapService_m.onRegionDiscovered(_) -- line: 75
end

local _ = function(arg3) --[[ createFilter ]] -- line: 80
    -- upvalues:
    --  [1] Filters (copy)

    local v5 = script.Checkbox:Clone()
    v5.Label.Text = arg3
    v5.Name = arg3
    v5.Parent = Filters.Options

    return v5
end

for key, val in {
    ToggleWaypoints = { text = "Waypoint Gates", category = "WaypointGates" },
    ToggleQuestMarkers = { text = "Quest Markers", category = "QuestGivers" },
    ToggleAreaMarkers = { text = "Area Names", category = "Locations" },
    ToggleQuestObjectives = { text = "Quest Objectives", category = "Objectives" },
    ToggleDeathMarker = { text = "Death Marker", category = "DeathMarker" }
} do
    v3 = Settings:FindFirstChild(key)
    local Text = val.text
    local Category = val.category
    local v7 = script.Checkbox:Clone()
    v7.Label.Text = Text
    v7.Name = Text
    v7.Parent = Filters.Options

    local function updateSetting() -- line: 97
        -- upvalues:
        --  [1] MapService_m (copy)
        --  [2] Category (copy)
        --  [3] v3 (copy)

        MapService_m.setFilter(Category, v3.Value)
    end

    v7.Activated:Connect(function() -- line: 101
        -- upvalues:
        --  [1] ReplicatedStorage (copy)
        --  [2] v3 (copy)

        ReplicatedStorage.Remotes.Player.UpdateSettings:FireServer(v3)
    end)
    v3:GetPropertyChangedSignal("Value"):Connect(updateSetting)
    MapService_m.setFilter(Category, v3.Value)
    MapService_m.bindFilterButton(v7, Category)
end

local v8 = script.Checkbox:Clone()
v8.Label.Text = "Map Header"
v8.Name = "Map Header"
v8.Parent = Filters.Options
local ToggleHeader = Settings.ToggleHeader

local _ = function(arg4, arg5, arg6) --[[ updateSetting ]] -- line: 114
    arg4:FindFirstChild("Check", true).Visible = arg5.Value

    if arg6 then
        arg6(arg5.Value)
    end
end

local function headerCallback(b1: boolean) -- line: 123
    -- upvalues:
    --  [1] Main (copy)

    Main.Header.Visible = b1
end

v8.Activated:Connect(function() -- line: 127
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] ToggleHeader (copy)

    ReplicatedStorage.Remotes.Player.UpdateSettings:FireServer(ToggleHeader)
end)
ToggleHeader:GetPropertyChangedSignal("Value"):Connect(function() -- line: 131
    -- upvalues:
    --  [1] v8 (copy)
    --  [2] ToggleHeader (copy)
    --  [3] headerCallback (copy)
    --  [4] Main (copy)

    local v9 = ToggleHeader
    local v10 = headerCallback
    v8:FindFirstChild("Check", true).Visible = v9.Value

    if v10 then
        Main.Header.Visible = v9.Value
    end
end)
local Check_2 = v8:FindFirstChild("Check", true)
Check_2.Visible = ToggleHeader.Value

if headerCallback then
    Main.Header.Visible = ToggleHeader.Value
end

local v11 = nil
local v12 = nil

local _ = function() --[[ getHoldTrack ]] -- line: 139
    -- upvalues:
    --  [1] v1 (copy)
    --  [2] v11 (ref)
    --  [3] v12 (ref)
    --  [4] ReplicatedStorage (copy)

    local v13 = v1.Character
    local v14 = v13

    if v14 then
        v14 = v13:FindFirstChildOfClass("Humanoid")
    end

    v13 = v14

    if v13 then
        v13 = v14:FindFirstChildOfClass("Animator")
    end

    if not v13 then
        return nil
    end

    if v13 ~= v11 then
        v11 = v13
        v12 = v13:LoadAnimation(ReplicatedStorage.Animations.Items.BookHold)
    end

    return v12
end

local function notifyQuestGuide() -- line: 154
    -- upvalues:
    --  [1] v1 (copy)
    --  [2] ReplicatedStorage (copy)

    local v15 = v1:FindFirstChild("Quests")
    local v16 = v15

    if v16 then
        v16 = v15:FindFirstChild("QuestGuide")
    end

    v15 = v16

    if v15 then
        v15 = not v16:GetAttribute("Completed")

        if v15 then
            v15 = v16:FindFirstChild("Tasks")

            if v15 then
                v15 = v16.Tasks:FindFirstChild("Open your map")
            end
        end
    end

    if v15 then
        if (v15:GetAttribute("TaskProgress") or 0) < (v15:GetAttribute("TaskMax") or 1) then
            ReplicatedStorage.Remotes.Client.UpdateQuestLog:FireServer("MapOpened", "QuestGuide")
        end
    end
end

local _ = function(arg7) --[[ setMapOpen ]] -- line: 163
    -- upvalues:
    --  [1] Main (copy)
    --  [2] notifyQuestGuide (copy)
    --  [3] MapService_m (copy)
    --  [4] v1 (copy)
    --  [5] v11 (ref)
    --  [6] v12 (ref)
    --  [7] ReplicatedStorage (copy)

    Main.Visible = arg7

    if arg7 then
        notifyQuestGuide()
        MapService_m.refreshPoints()
    end

    local v18 = v1.Character
    local v19 = v18

    if v19 then
        v19 = v18:FindFirstChildOfClass("Humanoid")
    end

    v18 = v19

    if v18 then
        v18 = v19:FindFirstChildOfClass("Animator")
    end

    local v20

    if not v18 then
        v20 = nil
    else
        if v18 ~= v11 then
            local _ = MapService_m.refreshPoints
            v11 = v18
            v12 = v18:LoadAnimation(ReplicatedStorage.Animations.Items.BookHold)
        end

        v20 = v12
    end

    if v20 then
        if arg7 then
            v20:Play(0.2)

            return
        end

        v20:Stop(0.2)
    end
end

local function mapAction(_, arg9) -- line: 183
    -- upvalues:
    --  [1] Bin (copy)
    --  [2] Main (copy)
    --  [3] notifyQuestGuide (copy)
    --  [4] MapService_m (copy)
    --  [5] v1 (copy)
    --  [6] v11 (ref)
    --  [7] v12 (ref)
    --  [8] ReplicatedStorage (copy)

    if Bin.Event.Value ~= "" then
        return
    end

    if arg9 == Enum.UserInputState.Begin then
        local v21 = not Main.Visible
        Main.Visible = v21

        if v21 then
            notifyQuestGuide()
            MapService_m.refreshPoints()
        end

        local v22 = v1.Character
        local v23 = v22

        if v23 then
            v23 = v22:FindFirstChildOfClass("Humanoid")
        end

        v22 = v23

        if v22 then
            v22 = v23:FindFirstChildOfClass("Animator")
        end

        local v24

        if not v22 then
            v24 = nil
        else
            if v22 ~= v11 then
                local _ = MapService_m.refreshPoints
                v11 = v22
                v12 = v22:LoadAnimation(ReplicatedStorage.Animations.Items.BookHold)
            end

            v24 = v12
        end

        if v24 then
            if v21 then
                v24:Play(0.2)

                return
            end

            v24:Stop(0.2)
        end
    end
end

CreateBindableAction_m("Map", Map, mapAction)
GamepadLayer_m.setTap(Enum.KeyCode.DPadDown, function() -- line: 196
    -- upvalues:
    --  [1] Bin (copy)
    --  [2] Main (copy)
    --  [3] notifyQuestGuide (copy)
    --  [4] MapService_m (copy)
    --  [5] v1 (copy)
    --  [6] v11 (ref)
    --  [7] v12 (ref)
    --  [8] ReplicatedStorage (copy)

    if Bin.Event.Value ~= "" then
        return
    end

    if Enum.UserInputState.Begin == Enum.UserInputState.Begin then
        local v25 = not Main.Visible
        Main.Visible = v25

        if v25 then
            notifyQuestGuide()
            MapService_m.refreshPoints()
        end

        local v26 = v1.Character
        local v27 = v26

        if v27 then
            v27 = v26:FindFirstChildOfClass("Humanoid")
        end

        v26 = v27

        if v26 then
            v26 = v27:FindFirstChildOfClass("Animator")
        end

        local v28

        if not v26 then
            v28 = nil
        else
            if v26 ~= v11 then
                local _ = MapService_m.refreshPoints
                v11 = v26
                v12 = v26:LoadAnimation(ReplicatedStorage.Animations.Items.BookHold)
            end

            v28 = v12
        end

        if v28 then
            if v25 then
                v28:Play(0.2)

                return
            end

            v28:Stop(0.2)
        end
    end
end)
Main.Close.MouseButton1Up:Connect(function() -- line: 200
    -- upvalues:
    --  [1] Main (copy)
    --  [2] v1 (copy)
    --  [3] v11 (ref)
    --  [4] v12 (ref)
    --  [5] ReplicatedStorage (copy)

    Main.Visible = false
    local v29 = v1.Character
    local v30 = v29

    if v30 then
        v30 = v29:FindFirstChildOfClass("Humanoid")
    end

    v29 = v30

    if v29 then
        v29 = v30:FindFirstChildOfClass("Animator")
    end

    local v31

    if not v29 then
        v31 = nil
    else
        if v29 ~= v11 then
            v11 = v29
            v12 = v29:LoadAnimation(ReplicatedStorage.Animations.Items.BookHold)
        end

        v31 = v12
    end

    if v31 then
        v31:Stop(0.2)
    end
end)
