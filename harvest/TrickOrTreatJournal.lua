-- Decompiled with Veyra harvester
-- Instance: StarterGui.HalloweenUI.TrickOrTreatJournal
-- Class: LocalScript
-- bytes: 7536

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local StatManager_m = require(ReplicatedStorage.Modules.StatManager)
local TrickOrTreatInfo_m = require(ReplicatedStorage:WaitForChild("TrickOrTreatInfo"))

if not TrickOrTreatInfo_m.ENABLED then
    return
end

local LocalPlayer = Players.LocalPlayer
local t = {
    Npcs = "rgb(150, 170, 235)",
    Tricks = "rgb(190, 120, 230)",
    Treats = "rgb(255, 190, 90)"
}
local t_1 = {}

local function refreshPrompt(u1: userdata) -- line: 37
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] LocalPlayer (copy)

    local v2 = u1:FindFirstAncestorOfClass("Model")

    if not v2 then
        return
    end

    local v3 = t_1[u1]
    local v4 = t_1

    if not v3 then
        v3 = u1.ActionText
    end

    v4[u1] = v3
    local v6 = if string.find(v2:GetAttribute("Claimed") or "", `,{LocalPlayer.UserId},`, 1, true) == nil then false else true
    local WindowEndsAt = v2:GetAttribute("WindowEndsAt")
    local v8 = if typeof(WindowEndsAt) == "number" then WindowEndsAt <= workspace:GetServerTimeNow() and true else false

    if (if v2:GetAttribute("Leaving") ~= true then if v2:GetAttribute("Following") == nil then false else true else true) or v8 and not v6 then
        u1.Enabled = false

        return
    end

    u1.Enabled = true
    u1.ActionText = if not v6 then t_1[u1] else "Come back later"
end

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
CollectionService:GetInstanceRemovedSignal("TrickOrTreatPrompt"):Connect(function(arg1) -- line: 55
    -- upvalues:
    --  [1] t_1 (copy)

    t_1[arg1] = nil
end)
task.spawn(function() -- line: 59
    -- upvalues:
    --  [1] CollectionService (copy)
    --  [2] refreshPrompt (copy)

    task.wait(0.3)

    for _, val in CollectionService:GetTagged("TrickOrTreatPrompt") do
        if val:IsA("ProximityPrompt") then
            refreshPrompt(val)
        end
    end
end)
local v10 = 60
local Quest = PlayerGui:WaitForChild("Gameplay"):WaitForChild("Quest", v10)
local v11 = Quest

if v11 then
    v10 = "QuestClient"
    v11 = Quest:WaitForChild(v10, 30)
end

local v12 = Quest

if v12 then
    v10 = "Log"
    v12 = Quest:WaitForChild(v10, 30)
end

if not v11 or not v12 then
    return
end

local Scrolling = v12:WaitForChild("LeftPage"):WaitForChild("Scrolling")
local Info = v12:WaitForChild("RightPage"):WaitForChild("Info")
v10 = Info:WaitForChild("Display")
local v14 = v10
v10 = StatManager_m.require(LocalPlayer)

while not v10 do
    task.wait(1)
    v10 = StatManager_m.require(LocalPlayer)
end

local v18 = v11:WaitForChild("TemplateContents"):Clone()
v18.Name = "!TrickOrTreat"
local v20 = v11:WaitForChild("Header"):Clone()
v20.Label.Text = TrickOrTreatInfo_m.CATEGORY
local HideCompleted = v20:FindFirstChild("HideCompleted")

if HideCompleted then
    HideCompleted:Destroy()
end

v20.Parent = v18
v18.Visible = true
v18.Parent = Scrolling
local t_2 = {}
local v24 = nil
local v25 = nil

local _ = function() --[[ counts ]] -- line: 106
    -- upvalues:
    --  [1] TrickOrTreatInfo_m (copy)
    --  [2] v10 (ref)

    return TrickOrTreatInfo_m.Parse(v10:GetStat(TrickOrTreatInfo_m.STAT))
end

local _ = function(s1: string) --[[ sectionOf ]] -- line: 110
    -- upvalues:
    --  [1] TrickOrTreatInfo_m (copy)

    for _, val_1 in TrickOrTreatInfo_m.Sections do
        if val_1.Id == TrickOrTreatInfo_m.ById[s1].Section then
            return val_1
        end
    end

    return nil
end

local _ = function() --[[ unshow ]] -- line: 119
    -- upvalues:
    --  [1] v24 (ref)
    --  [2] t_2 (copy)
    --  [3] v25 (ref)
    --  [4] v14 (copy)

    if v24 and t_2[v24] then
        t_2[v24]:SetAttribute("Highlighted", false)
    end

    v24 = nil
    v25 = nil
    local Tasks = v14:FindFirstChild("Tasks")

    if Tasks then
        Tasks.Visible = true
    end
end

local function show(s2: string) -- line: 131
    -- upvalues:
    --  [1] TrickOrTreatInfo_m (copy)
    --  [2] v10 (ref)
    --  [3] v24 (ref)
    --  [4] t_2 (copy)
    --  [5] v14 (copy)
    --  [6] Info (copy)
    --  [7] v25 (ref)
    --  [8] t (copy)

    local v26 = TrickOrTreatInfo_m.ById[s2]
    local v27 = TrickOrTreatInfo_m.Parse(v10:GetStat(TrickOrTreatInfo_m.STAT))[s2] or 0
    local v28

    for _, val_2 in TrickOrTreatInfo_m.Sections do
        if val_2.Id == TrickOrTreatInfo_m.ById[s2].Section then
            v28 = val_2
        end
    end

    v28 = nil

    if v24 and t_2[v24] then
        t_2[v24]:SetAttribute("Highlighted", false)
    end

    v24 = s2
    t_2[s2]:SetAttribute("Highlighted", true)
    local v29 = v14:FindFirstChild("Tasks")

    if v29 then
        v29.Visible = false
    end

    Info.Repeatable.Visible = false
    Info.Return.Visible = false
    v29 = if not (v27 > 0) then "???" else v26.Name
    v25 = v29
    v14.Header.Text = v29
    v29 = v28 and `<font color='{t[v28.Id] or "rgb(200,200,200)"}'>{v28.Name}</font>` or ""

    if v27 > 0 then
        local v30 = if v27 ~= 1 then "s" else ""
        v14.Description.Text = `{v29}\n{v26.Description}\n\n<font color='rgb(221, 158, 81)'>Encountered {v27} time{v30}</font>`

        return
    end

    local Description_1 = v14.Description
    local _ = TrickOrTreatInfo_m.ById
    Description_1.Text = `{v29}\n<i>{v26.Hint}</i>`
end

local function refresh() -- line: 157
    -- upvalues:
    --  [1] TrickOrTreatInfo_m (copy)
    --  [2] v10 (ref)
    --  [3] t_2 (copy)
    --  [4] v20 (copy)
    --  [5] v24 (ref)
    --  [6] show (copy)

    local v31 = TrickOrTreatInfo_m.Parse(v10:GetStat(TrickOrTreatInfo_m.STAT))
    local v32 = 0

    for _, val_3 in TrickOrTreatInfo_m.Entries do
        local v33 = t_2[val_3.Id]
        local v34 = v31[val_3.Id] or 0

        if v34 > 0 then
            v32 += 1
        end

        if v33 then
            v33.Label.Text = if not (v34 > 0) then "<font color='rgb(140, 140, 140)'>???</font>" else val_3.Name
        end
    end

    local v36 = #TrickOrTreatInfo_m.Entries
    v20.Count.Text = `({v32}/{v36})`

    if v24 then
        show(v24)
    end
end

for _, val_4 in TrickOrTreatInfo_m.Entries do
    local v37 = v11:WaitForChild("SubTemplate"):Clone()
    v37.Name = string.format("%02d_%s", val_4.Order, val_4.Id)
    v37.LayoutOrder = val_4.Order
    local Track = v37:FindFirstChild("Track")

    if Track then
        Track:Destroy()
    end

    v37.Button.MouseButton1Up:Connect(function() -- line: 184
        -- upvalues:
        --  [1] show (copy)
        --  [2] val_4 (copy)

        show(val_4.Id)
    end)
    v37.MouseEnter:Connect(function() -- line: 187
        -- upvalues:
        --  [1] v37 (copy)

        v37.BackgroundTransparency = 0.9
    end)
    v37.MouseLeave:Connect(function() -- line: 190
        -- upvalues:
        --  [1] v37 (copy)

        v37.BackgroundTransparency = 1
    end)
    t_2[val_4.Id] = v37
    v37.Parent = v18.Items
end

v14.Header:GetPropertyChangedSignal("Text"):Connect(function() -- line: 198
    -- upvalues:
    --  [1] v24 (ref)
    --  [2] v14 (copy)
    --  [3] v25 (ref)
    --  [4] t_2 (copy)

    if v24 and v14.Header.Text ~= v25 then
        if v24 and t_2[v24] then
            t_2[v24]:SetAttribute("Highlighted", false)
        end

        v24 = nil
        v25 = nil
        local Tasks_1 = v14:FindFirstChild("Tasks")

        if Tasks_1 then
            Tasks_1.Visible = true
        end
    end
end)
v10:OnStatChanged(TrickOrTreatInfo_m.STAT, refresh)
refresh()
