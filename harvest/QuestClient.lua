-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Quest.QuestClient
-- Class: LocalScript
-- bytes: 41578

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local CreateBindableAction_m = require(Modules.CreateBindableAction)
local v2 = require(Modules.GamepadLayer)
local ClientNPCS_m = require(Modules.ClientNPCS)
local QuestProgress_m = require(Modules.QuestProgress)
local BackpackUtils_m = require(Modules.BackpackUtils)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Bin = LocalPlayer:WaitForChild("bin")
local Binds = LocalPlayer:WaitForChild("Binds")
local Quests = LocalPlayer:WaitForChild("Quests")
local QuestIndicators = PlayerGui:WaitForChild("QuestIndicators")
local Remotes = ReplicatedStorage.Remotes
local QuestIndex = Remotes.Player.QuestIndex
local Log = script.Parent.Log
local Scrolling = Log.LeftPage.Scrolling
local Info = Log.RightPage.Info
local Display = Info.Display
local Tracking = Log.Parent.Tracking
local UIListLayout = Tracking.Quests.UIListLayout
local SearchBox = Log.SearchBox
local UpdateQuestLog = Remotes.Client.UpdateQuestLog
local QuestJournal = Binds:WaitForChild("Quest Journal")
local color = Color3.fromRGB(155, 255, 140)
local color_1 = Color3.fromRGB(255, 255, 255)
local color_2 = Color3.fromRGB(255, 138, 138)
local color_3 = Color3.fromRGB(120, 120, 120)
local color_4 = Color3.fromRGB(22, 22, 22)
local t = {}
local t_1 = {}
local v3 = nil
local v4 = nil
local t_2 = {}
local v5 = Services_m.Maid.new()
local Sound = Instance.new("Sound")
Sound.SoundId = "rbxassetid://10066914500"
Sound.Parent = game:GetService("SoundService")
local v6 = nil
local v7 = nil

local _ = function() --[[ getHoldTrack ]] -- line: 65
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] v6 (ref)
    --  [3] v7 (ref)
    --  [4] ReplicatedStorage (copy)

    local v8 = LocalPlayer.Character
    local v9 = v8

    if v9 then
        v9 = v8:FindFirstChildOfClass("Humanoid")
    end

    v8 = v9

    if v8 then
        v8 = v9:FindFirstChildOfClass("Animator")
    end

    if not v8 then
        return nil
    end

    if v8 ~= v6 then
        v6 = v8
        v7 = v8:LoadAnimation(ReplicatedStorage.Animations.Items.BookHold)
    end

    return v7
end

local _ = function(arg1) --[[ getIndicatorGui ]] -- line: 79
    -- upvalues:
    --  [1] QuestIndicators (copy)

    local v10 = QuestIndicators:FindFirstChild(arg1)

    if not v10 then
        v10 = Instance.new("ScreenGui")
        v10.Name = arg1
        v10.ResetOnSpawn = false
        v10.Parent = QuestIndicators
    end

    return v10
end

local _ = function(arg2) --[[ matchesSearch ]] -- line: 90
    -- upvalues:
    --  [1] SearchBox (copy)

    local v11 = string.upper(SearchBox.Text)
    local v12 = true

    if v11 ~= "" then
        v12 = if string.find(string.upper(arg2), v11, 1, true) == nil then false else true
    end

    return v12
end

local _ = function(arg3) --[[ isHidingCompleted ]] -- line: 95
    -- upvalues:
    --  [1] t_1 (copy)

    local v13 = t_1[arg3]

    if v13 == nil then
        return true
    end

    return v13
end

local _ = function(arg4) --[[ refreshEntryVisibility ]] -- line: 104
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] SearchBox (copy)

    local v14 = arg4.data:GetAttribute("Completed")
    local v15

    if v14 then
        v15 = t_1[arg4.category]
        v14 = if v15 ~= nil then v15 else true
    end

    local Template = arg4.template
    local QuestName = arg4.questName
    local v16 = string.upper(SearchBox.Text)
    v15 = true

    if v16 ~= "" then
        v15 = if string.find(string.upper(QuestName), v16, 1, true) == nil then false else true
    end

    if v15 then
        v15 = not v14
    end

    Template.Visible = v15
end

local function bindTasks(arg5, arg6, arg7, arg8) -- line: 109
    -- upvalues:
    --  [1] QuestProgress_m (copy)

    local t_3 = {}
    local v17 = nil

    local _ = function(arg9, arg10) --[[ applyRow ]] -- line: 113
        -- upvalues:
        --  [1] QuestProgress_m (ref)
        --  [2] arg5 (copy)
        --  [3] arg8 (copy)

        local v18 = QuestProgress_m.getMax(arg9)
        local v19 = arg5:GetAttribute("Completed") and v18 or arg10.progress
        arg10.done = v18 <= v19
        arg8.update(arg10, arg9, v19, v18)
    end

    local _ = function() --[[ evaluate ]] -- line: 120
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] v17 (ref)
        --  [3] arg8 (copy)

        local v21 = 0
        local v22 = 0

        for _, val in t_3 do
            v21 += 1

            if val.done then
                v22 += 1
            end
        end

        local v23 = v21 > 0 and v22 == v21

        if v23 ~= v17 then
            v17 = v23
            arg8.allDone(v23)
        end
    end

    local function removeRow(arg11) -- line: 136
        -- upvalues:
        --  [1] t_3 (copy)

        local v24 = t_3[arg11]

        if not v24 then
            return
        end

        t_3[arg11] = nil
        v24.stop()

        for _, val_1 in v24.connections do
            val_1:Disconnect()
        end

        v24.gui:Destroy()
    end

    local function addRow(arg12) -- line: 149
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] arg8 (copy)
        --  [3] QuestProgress_m (ref)
        --  [4] arg5 (copy)
        --  [5] v17 (ref)

        if t_3[arg12] then
            return
        end

        local v25 = arg8.add(arg12)
        local v26 = v25.connections or {}
        v25.connections = v26
        v25.done = false
        v25.progress = 0
        t_3[arg12] = v25
        v25.stop = QuestProgress_m.watch(arg12, function(arg13) -- line: 160
            -- upvalues:
            --  [1] t_3 (ref)
            --  [2] arg12 (copy)
            --  [3] v25 (copy)
            --  [4] QuestProgress_m (ref)
            --  [5] arg5 (ref)
            --  [6] arg8 (ref)
            --  [7] v17 (ref)

            if t_3[arg12] ~= v25 then
                return
            end

            v25.progress = arg13
            local v27 = arg12
            local v28 = v25
            local v29 = QuestProgress_m.getMax(v27)
            local v30 = arg5:GetAttribute("Completed") and v29 or v28.progress
            v28.done = v29 <= v30
            arg8.update(v28, v27, v30, v29)
            v27 = 0
            v28 = 0

            for _, val_2 in t_3 do
                v27 += 1

                if val_2.done then
                    v28 += 1
                end
            end

            local v32 = v27 > 0 and v28 == v27

            if v32 ~= v17 then
                v17 = v32
                arg8.allDone(v32)
            end
        end)
    end

    arg7:GiveTask(arg5:GetAttributeChangedSignal("Completed"):Connect(function() -- line: 170
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] QuestProgress_m (ref)
        --  [3] arg5 (copy)
        --  [4] arg8 (copy)
        --  [5] v17 (ref)

        for key_3, val_3 in t_3 do
            local v33 = QuestProgress_m.getMax(key_3)
            local v34 = arg5:GetAttribute("Completed") and v33 or val_3.progress
            val_3.done = v33 <= v34
            arg8.update(val_3, key_3, v34, v33)
        end

        local v36 = 0
        local v37 = 0

        for _, val_4 in t_3 do
            v36 += 1

            if val_4.done then
                v37 += 1
            end
        end

        local v38 = v36 > 0 and v37 == v36

        if v38 ~= v17 then
            v17 = v38
            arg8.allDone(v38)
        end
    end))
    arg7:GiveTask(arg6.ChildAdded:Connect(function(child_1) -- line: 177
        -- upvalues:
        --  [1] addRow (copy)
        --  [2] t_3 (copy)
        --  [3] v17 (ref)
        --  [4] arg8 (copy)

        addRow(child_1)
        local v39 = 0
        local v40 = 0

        for _, val_5 in t_3 do
            v39 += 1

            if val_5.done then
                v40 += 1
            end
        end

        local v41 = v39 > 0 and v40 == v39

        if v41 ~= v17 then
            v17 = v41
            arg8.allDone(v41)
        end
    end))
    arg7:GiveTask(arg6.ChildRemoved:Connect(function(child_2) -- line: 181
        -- upvalues:
        --  [1] removeRow (copy)
        --  [2] t_3 (copy)
        --  [3] v17 (ref)
        --  [4] arg8 (copy)

        removeRow(child_2)
        local v42 = 0
        local v43 = 0

        for _, val_6 in t_3 do
            v42 += 1

            if val_6.done then
                v43 += 1
            end
        end

        local v44 = v42 > 0 and v43 == v42

        if v44 ~= v17 then
            v17 = v44
            arg8.allDone(v44)
        end
    end))
    arg7:GiveTask(function() -- line: 185
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] removeRow (copy)

        for key_7 in t_3 do
            removeRow(key_7)
        end
    end)

    for _, child in arg6:GetChildren() do
        addRow(child)
    end

    local v45 = 0
    local v46 = 0

    for _, val_7 in t_3 do
        v45 += 1

        if val_7.done then
            v46 += 1
        end
    end

    local v47 = v45 > 0 and v46 == v45

    if v47 ~= v17 then
        v17 = v47
        arg8.allDone(v47)
    end
end

local function getCategory(arg16) -- line: 197
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] ClientNPCS_m (copy)
    --  [3] t_1 (copy)
    --  [4] t (copy)
    --  [5] SearchBox (copy)
    --  [6] Services_m (copy)
    --  [7] ReplicatedStorage (copy)
    --  [8] BackpackUtils_m (copy)
    --  [9] Scrolling (copy)

    local v48 = t_2[arg16]

    if v48 then
        return v48
    end

    local v49 = script.TemplateContents:Clone()
    v49.Name = arg16
    local v50 = script.Header:Clone()
    v50.Label.Text = arg16
    v50.Parent = v49
    local Items = v49.Items
    local v51 = 0

    local _ = function() --[[ refresh ]] -- line: 213
        -- upvalues:
        --  [1] v49 (ref)
        --  [2] v51 (ref)
        --  [3] ClientNPCS_m (ref)
        --  [4] arg16 (copy)
        --  [5] v50 (copy)

        v49.Visible = v51 > 0
        local v53 = ClientNPCS_m:GetLegacyCount(arg16)
        local Count = v50.Count
        Count.Text = if v51 == v53 then `({v51}/{v53})` or `({v51}/?)` else `({v51}/?)`
    end

    Items.ChildAdded:Connect(function(child_3) -- line: 219
        -- upvalues:
        --  [1] v51 (ref)
        --  [2] v49 (ref)
        --  [3] ClientNPCS_m (ref)
        --  [4] arg16 (copy)
        --  [5] v50 (copy)

        if child_3:IsA("GuiObject") then
            v51 += 1
            v49.Visible = v51 > 0
            local v56 = ClientNPCS_m:GetLegacyCount(arg16)
            local Count_1 = v50.Count
            Count_1.Text = if v51 == v56 then `({v51}/{v56})` or `({v51}/?)` else `({v51}/?)`
        end
    end)
    Items.ChildRemoved:Connect(function(child_4) -- line: 225
        -- upvalues:
        --  [1] v51 (ref)
        --  [2] v49 (ref)
        --  [3] ClientNPCS_m (ref)
        --  [4] arg16 (copy)
        --  [5] v50 (copy)

        if child_4:IsA("GuiObject") then
            v51 -= 1
            v49.Visible = v51 > 0
            local v59 = ClientNPCS_m:GetLegacyCount(arg16)
            local Count_2 = v50.Count
            Count_2.Text = if v51 == v59 then `({v51}/{v59})` or `({v51}/?)` else `({v51}/?)`
        end
    end)
    local HideCompleted = v50:FindFirstChild("HideCompleted")

    if HideCompleted then
        local Check = HideCompleted:FindFirstChild("Check", true)

        local _ = function() --[[ refreshToggle ]] -- line: 237
            -- upvalues:
            --  [1] Check (copy)
            --  [2] arg16 (copy)
            --  [3] t_1 (ref)

            if Check then
                local v62 = t_1[arg16]
                Check.Visible = if v62 ~= nil then v62 else true
            end
        end

        HideCompleted.Activated:Connect(function() -- line: 243
            -- upvalues:
            --  [1] t_1 (ref)
            --  [2] arg16 (copy)
            --  [3] Check (copy)
            --  [4] t (ref)
            --  [5] SearchBox (ref)
            --  [6] Services_m (ref)
            --  [7] ReplicatedStorage (ref)

            local v64 = t_1
            local v65 = arg16
            local v66 = t_1[arg16]
            local v67 = if v66 ~= nil then v66 else true
            v64[v65] = not v67

            if Check then
                local v68 = Check
                v67 = t_1[arg16]
                v68.Visible = if v67 ~= nil then v67 else true
            end

            local v70

            for _, val_8 in t do
                if val_8.category == arg16 then
                    local v69 = val_8.data:GetAttribute("Completed")

                    if v69 then
                        v70 = t_1[val_8.category]
                        v69 = if v70 ~= nil then v70 else true
                    end

                    local Template_1 = val_8.template
                    local QuestName_1 = val_8.questName
                    local v71 = string.upper(SearchBox.Text)
                    v70 = true

                    if v71 ~= "" then
                        v70 = if string.find(string.upper(QuestName_1), v71, 1, true) == nil then false else true
                    end

                    if v70 then
                        v70 = not v69
                    end

                    Template_1.Visible = v70
                end
            end

            Services_m.PlaySound(ReplicatedStorage.SFX.Player.Swipe, script)
        end)
        HideCompleted.MouseEnter:Connect(function() -- line: 256
            -- upvalues:
            --  [1] BackpackUtils_m (ref)

            BackpackUtils_m:ShowHover(
                {
                    key = "Hide Completed",
                    text = "Hide the quests you've already completed in this category"
                }
            )
        end)
        HideCompleted.MouseLeave:Connect(function() -- line: 262
            -- upvalues:
            --  [1] BackpackUtils_m (ref)

            BackpackUtils_m:HideHover()
        end)

        if Check then
            local v72 = t_1[arg16]
            Check.Visible = if v72 ~= nil then v72 else true
        end
    end

    v49.Visible = v51 > 0
    local v75 = ClientNPCS_m:GetLegacyCount(arg16)
    local Count_3 = v50.Count
    Count_3.Text = if v51 == v75 then `({v51}/{v75})` or `({v51}/?)` else `({v51}/?)`
    v49.Parent = Scrolling
    t_2[arg16] = v49

    return v49
end

local function scrollTo(arg19) -- line: 275
    -- upvalues:
    --  [1] Scrolling (copy)
    --  [2] TweenService (copy)
    --  [3] Sound (copy)

    local vec2 = Vector2.new(
        Scrolling.CanvasPosition.X,
        Scrolling.CanvasPosition.Y + (arg19.AbsolutePosition.Y - Scrolling.AbsolutePosition.Y)
    )
    TweenService:Create(Scrolling, TweenInfo.new(0.2), { CanvasPosition = vec2 }):Play()
    Sound:Play()
end

local _ = function() --[[ clearInfo ]] -- line: 282
    -- upvalues:
    --  [1] v5 (copy)
    --  [2] v3 (ref)
    --  [3] Display (copy)
    --  [4] Info (copy)

    v5:Destroy()

    if v3 and v3.template.Parent then
        v3.template:SetAttribute("Highlighted", false)
    end

    v3 = nil
    Display.Header.Text = ""
    Display.Description.Text = ""
    Info.Repeatable.Visible = false
    Info.Return.Visible = false
end

local function showInfo(arg20) -- line: 296
    -- upvalues:
    --  [1] v5 (copy)
    --  [2] v3 (ref)
    --  [3] Display (copy)
    --  [4] Info (copy)
    --  [5] Services_m (copy)
    --  [6] ReplicatedStorage (copy)
    --  [7] bindTasks (copy)

    v5:Destroy()

    if v3 and v3.template.Parent then
        v3.template:SetAttribute("Highlighted", false)
    end

    v3 = nil
    Display.Header.Text = ""
    Display.Description.Text = ""
    Info.Repeatable.Visible = false
    Info.Return.Visible = false
    v3 = arg20
    local Data = arg20.data
    arg20.template:SetAttribute("Highlighted", true)
    Services_m.PlaySound(ReplicatedStorage.SFX.Player.Swipe, script)
    Display.Header.Text = arg20.questName
    Display.Description.Text = Data:GetAttribute("QuestDescription") or ""
    Info.Repeatable.Visible = if Data:GetAttribute("CooldownType") == "OneTime" then false else true
    Info.Return.message.Text = `Return to {arg20.returnNpc} to complete your quest.`
    local v80 = false

    local function refreshReturn() -- line: 310
        -- upvalues:
        --  [1] Info (ref)
        --  [2] v80 (ref)
        --  [3] Data (copy)

        local v81 = v80
        local Return = Info.Return

        if v81 then
            v81 = not Data:GetAttribute("Completed")
        end

        Return.Visible = v81
    end

    v5:GiveTask(Data:GetAttributeChangedSignal("Completed"):Connect(refreshReturn))
    local t_5 = {
        add = function(arg21) --[[ add ]] -- line: 316
            -- upvalues:
            --  [1] Display (ref)

            local v83 = script.TaskTemplate:Clone()
            v83.Name = arg21.Name
            v83.Visible = not arg21:GetAttribute("Hidden")
            v83.Parent = Display.Tasks

            return {
                gui = v83,
                connections = {
                    arg21:GetAttributeChangedSignal("Hidden"):Connect(function() -- line: 325
                        -- upvalues:
                        --  [1] v83 (copy)
                        --  [2] arg21 (copy)

                        v83.Visible = not arg21:GetAttribute("Hidden")
                    end)
                }
            }
        end,
        update = function(arg22, arg23, arg24, arg25) --[[ update ]] -- line: 331
            local v85 = `\226\128\162 {arg23.Name} <b><font color='rgb(221, 158, 81)'>({arg24}/{arg25})</font></b>`
            local Label = arg22.gui.Label
            Label.Text = arg22.done and `<s>{v85}</s>` or v85
        end,
        allDone = nil
    }

    function t_5.allDone(arg26) -- line: 335
        -- upvalues:
        --  [1] v80 (ref)
        --  [2] Info (ref)
        --  [3] Data (copy)

        v80 = arg26
        local v87 = v80
        local Return_1 = Info.Return

        if v87 then
            v87 = not Data:GetAttribute("Completed")
        end

        Return_1.Visible = v87
    end

    bindTasks(Data, arg20.tasks, v5, t_5)
    local v88 = v80
    local Return_2 = Info.Return

    if v88 then
        v88 = not Data:GetAttribute("Completed")
    end

    Return_2.Visible = v88
end

local _ = function(arg27) --[[ setBookOpen ]] -- line: 344
    -- upvalues:
    --  [1] Log (copy)
    --  [2] LocalPlayer (copy)
    --  [3] v6 (ref)
    --  [4] v7 (ref)
    --  [5] ReplicatedStorage (copy)
    --  [6] QuestIndex (copy)

    Log.Visible = arg27
    local v89 = LocalPlayer.Character
    local v90 = v89

    if v90 then
        v90 = v89:FindFirstChildOfClass("Humanoid")
    end

    v89 = v90

    if v89 then
        v89 = v90:FindFirstChildOfClass("Animator")
    end

    local v91

    if not v89 then
        v91 = nil
    else
        if v89 ~= v6 then
            v6 = v89
            v7 = v89:LoadAnimation(ReplicatedStorage.Animations.Items.BookHold)
        end

        v91 = v7
    end

    if v91 then
        if arg27 then
            v91:Play(0.2)
        else
            v91:Stop(0.2)
        end
    end

    task.spawn(pcall, QuestIndex.InvokeServer, QuestIndex, arg27)
end

local _ = function(arg28, arg29) --[[ setTrackButton ]] -- line: 359
    -- upvalues:
    --  [1] color_2 (copy)
    --  [2] color_1 (copy)

    local Track = arg28.template:FindFirstChild("Track")

    if not Track then
        return
    end

    Track.Label.Text = if not arg29 then "TRACK" else "UNTRACK"
    Track.Label.TextColor3 = arg29 and color_2 or color_1
end

local _ = function() --[[ stopTracking ]] -- line: 368
    -- upvalues:
    --  [1] v4 (ref)

    if not v4 then
        return
    end

    local v93 = v4
    v4 = nil
    v93.maid:Destroy()
end

local function startTracking(arg30) -- line: 377
    -- upvalues:
    --  [1] Services_m (copy)
    --  [2] QuestIndicators (copy)
    --  [3] v4 (ref)
    --  [4] color_2 (copy)
    --  [5] color_1 (copy)
    --  [6] bindTasks (copy)
    --  [7] color (copy)
    --  [8] color_3 (copy)
    --  [9] color_4 (copy)
    --  [10] Log (copy)
    --  [11] LocalPlayer (copy)
    --  [12] v6 (ref)
    --  [13] v7 (ref)
    --  [14] ReplicatedStorage (copy)
    --  [15] QuestIndex (copy)
    --  [16] showInfo (copy)
    --  [17] scrollTo (copy)
    --  [18] Tracking (copy)

    local v94 = Services_m.Maid.new()
    local Data_1 = arg30.data
    local Key = arg30.key
    local v95 = QuestIndicators:FindFirstChild(Key)

    if not v95 then
        v95 = Instance.new("ScreenGui")
        v95.Name = Key
        v95.ResetOnSpawn = false
        v95.Parent = QuestIndicators
    end

    v4 = { entry = arg30, maid = v94 }
    local v96 = script.TrackTask:Clone()
    local Items_1 = v96.Items
    v96.Name = arg30.key
    v96:SetAttribute("npcIndex", arg30.questName)
    Items_1.Header.Text = arg30.questName
    Items_1.Return.Text = `Return to {arg30.returnNpc}`
    local Tip = Data_1:GetAttribute("Tip")

    if Tip then
        Items_1.Tip.Text = Tip
        Items_1.Tip.Visible = true
    end

    v94:GiveTask(v96)
    local Track_1 = arg30.template:FindFirstChild("Track")

    if Track_1 then
        Track_1.Label.Text = "UNTRACK"
        local v97 = color_2 or color_1
        Track_1.Label.TextColor3 = v97
    end

    v94:GiveTask(function() -- line: 400
        -- upvalues:
        --  [1] arg30 (copy)
        --  [2] color_1 (ref)
        --  [3] v95 (copy)

        local Track_2 = arg30.template:FindFirstChild("Track")

        if Track_2 then
            Track_2.Label.Text = "TRACK"
            Track_2.Label.TextColor3 = color_1
        end

        v95:SetAttribute("status", false)
        v95:SetAttribute("Return", false)
    end)
    local v98 = false

    local function refreshReturn_1() --[[ refreshReturn ]] -- line: 407
        -- upvalues:
        --  [1] Items_1 (copy)
        --  [2] v98 (ref)
        --  [3] Data_1 (copy)

        local v99 = v98
        local Return_4 = Items_1.Return

        if v99 then
            v99 = not Data_1:GetAttribute("Completed")
        end

        Return_4.Visible = v99
    end

    v94:GiveTask(Data_1:GetAttributeChangedSignal("Completed"):Connect(refreshReturn_1))
    local t_9 = { add = nil, update = nil, allDone = nil }

    function t_9.add(arg31) -- line: 413
        -- upvalues:
        --  [1] Items_1 (copy)

        local v100 = script.TaskLabel:Clone()
        v100.Name = arg31.Name
        v100.Text = arg31.Name
        v100.Parent = Items_1

        local function refreshVisibility() -- line: 419
            -- upvalues:
            --  [1] v100 (copy)
            --  [2] arg31 (copy)

            v100.Visible = not arg31:GetAttribute("Hidden")
        end

        v100.Visible = not arg31:GetAttribute("Hidden")

        return {
            gui = v100,
            connections = { arg31:GetAttributeChangedSignal("Hidden"):Connect(refreshVisibility) }
        }
    end

    local v104 = bindTasks
    local Tasks = arg30.tasks

    function t_9.update(arg32, arg33, arg34, arg35) -- line: 431
        -- upvalues:
        --  [1] color (ref)
        --  [2] color_1 (ref)

        local v102 = `{arg33.Name} ({arg34}/{arg35})`
        local Gui = arg32.gui
        Gui.Text = arg32.done and `<s>{v102}</s>` or v102
        arg32.gui.TextColor3 = arg32.done and color or color_1
        arg32.gui.LayoutOrder = if not arg32.done then 1 else 0
    end

    function t_9.allDone(arg36) -- line: 437
        -- upvalues:
        --  [1] v98 (ref)
        --  [2] v96 (copy)
        --  [3] v95 (copy)
        --  [4] Items_1 (copy)
        --  [5] Data_1 (copy)

        v98 = arg36
        v96.LayoutOrder = if arg36 then -1 else 0
        v95:SetAttribute("Return", arg36)
        local v106 = v98
        local Return_5 = Items_1.Return

        if v106 then
            v106 = not Data_1:GetAttribute("Completed")
        end

        Return_5.Visible = v106
    end

    v104(Data_1, Tasks, v94, t_9)
    local View = Items_1.View
    v94:GiveTask(View.MouseEnter:Connect(function() -- line: 446
        -- upvalues:
        --  [1] View (copy)
        --  [2] color_3 (ref)

        View.BackgroundColor3 = color_3
    end))
    v94:GiveTask(View.MouseLeave:Connect(function() -- line: 449
        -- upvalues:
        --  [1] View (copy)
        --  [2] color_4 (ref)

        View.BackgroundColor3 = color_4
    end))
    v94:GiveTask(View.MouseButton1Up:Connect(function() -- line: 452
        -- upvalues:
        --  [1] Log (ref)
        --  [2] LocalPlayer (ref)
        --  [3] v6 (ref)
        --  [4] v7 (ref)
        --  [5] ReplicatedStorage (ref)
        --  [6] QuestIndex (ref)
        --  [7] showInfo (ref)
        --  [8] arg30 (copy)
        --  [9] scrollTo (ref)

        if not Log.Visible then
            Log.Visible = true
            local v107 = LocalPlayer.Character
            local v108 = v107

            if v108 then
                v108 = v107:FindFirstChildOfClass("Humanoid")
            end

            v107 = v108

            if v107 then
                v107 = v108:FindFirstChildOfClass("Animator")
            end

            local v109

            if not v107 then
                v109 = nil
            else
                if v107 ~= v6 then
                    v6 = v107
                    v7 = v107:LoadAnimation(ReplicatedStorage.Animations.Items.BookHold)
                end

                v109 = v7
            end

            if v109 then
                v109:Play(0.2)
            end

            task.spawn(pcall, QuestIndex.InvokeServer, QuestIndex, true)
        end

        showInfo(arg30)
        scrollTo(arg30.template)
    end))
    v96.Parent = Tracking.Quests
    v95:SetAttribute("status", true)
end

local function refreshTracking() -- line: 464
    -- upvalues:
    --  [1] Quests (copy)
    --  [2] t (copy)
    --  [3] v4 (ref)
    --  [4] startTracking (copy)

    local Tracking_1 = Quests:GetAttribute("Tracking")
    local v110 = Tracking_1 and t[Tracking_1] or nil

    if v4 and v4.entry == v110 then
        return
    end

    if v4 then
        local v111 = v4
        v4 = nil
        v111.maid:Destroy()
    end

    if v110 then
        startTracking(v110)
    end
end

local _ = function(arg37) --[[ removeEntry ]] -- line: 479
    -- upvalues:
    --  [1] t (copy)
    --  [2] v3 (ref)
    --  [3] v5 (copy)
    --  [4] Display (copy)
    --  [5] Info (copy)
    --  [6] v4 (ref)

    if t[arg37.key] ~= arg37 then
        return
    end

    t[arg37.key] = nil

    if v3 == arg37 then
        v5:Destroy()

        if v3 and v3.template.Parent then
            v3.template:SetAttribute("Highlighted", false)
        end

        v3 = nil
        Display.Header.Text = ""
        Display.Description.Text = ""
        Info.Repeatable.Visible = false
        Info.Return.Visible = false
    end

    if v4 and v4.entry == arg37 and v4 then
        local v112 = v4
        v4 = nil
        v112.maid:Destroy()
    end

    arg37.maid:Destroy()
end

local function createEntry(arg38, arg39) -- line: 495
    -- upvalues:
    --  [1] Quests (copy)
    --  [2] t (copy)
    --  [3] v3 (ref)
    --  [4] v5 (copy)
    --  [5] Display (copy)
    --  [6] Info (copy)
    --  [7] v4 (ref)
    --  [8] ReplicatedStorage (copy)
    --  [9] Services_m (copy)
    --  [10] t_1 (copy)
    --  [11] SearchBox (copy)
    --  [12] showInfo (copy)
    --  [13] UpdateQuestLog (copy)
    --  [14] color_1 (copy)
    --  [15] getCategory (copy)
    --  [16] startTracking (copy)

    local Name = arg38.Name
    local Tasks_1 = arg38:WaitForChild("Tasks", 10)

    if not Tasks_1 or arg38.Parent ~= Quests then
        return
    end

    local v113 = t[Name]

    if v113 then
        if v113.data == arg38 then
            return
        end

        if t[v113.key] == v113 then
            t[v113.key] = nil

            if v3 == v113 then
                v5:Destroy()

                if v3 and v3.template.Parent then
                    v3.template:SetAttribute("Highlighted", false)
                end

                v3 = nil
                Display.Header.Text = ""
                Display.Description.Text = ""
                Info.Repeatable.Visible = false
                Info.Return.Visible = false
            end

            if v4 and v4.entry == v113 and v4 then
                local v114 = v4
                v4 = nil
                v114.maid:Destroy()
            end

            v113.maid:Destroy()
        end
    end

    local v115 = arg38:GetAttribute("Quest") or Name

    if not arg39 then
        _G.CreateAlert(
            `You've taken the quest <font color='rgb(255, 179, 71)'>({v115})</font>`,
            ReplicatedStorage.SFX.Misc.Alert
        )
        Services_m.PlaySound(ReplicatedStorage.SFX.Misc.Accept, script)
    end

    local t_12 = {
        key = Name,
        data = arg38,
        tasks = Tasks_1,
        questName = v115,
        returnNpc = arg38:GetAttribute("ReturnNPC") or Name,
        category = arg38:GetAttribute("Legacy") or "Other",
        maid = Services_m.Maid.new()
    }
    local v117 = script.SubTemplate:Clone()
    v117.Name = Name
    v117.Label.Text = v115
    v117:SetAttribute("QuestIndex", v115)
    t_12.template = v117
    t_12.maid:GiveTask(v117)

    local _ = function() --[[ applyCompleted ]] -- line: 535
        -- upvalues:
        --  [1] arg38 (copy)
        --  [2] v117 (copy)
        --  [3] Name (copy)
        --  [4] v115 (copy)
        --  [5] t_12 (copy)
        --  [6] t_1 (ref)
        --  [7] SearchBox (ref)

        local v118 = arg38:GetAttribute("Completed")
        local v119 = v117
        v119.Name = v118 and "_" .. Name or Name
        local Label_1 = v117.Label
        Label_1.Text = v118 and `<s><font color='rgb(155, 255, 140)'>{v115}</font></s>` or v115
        local v121 = t_12
        v118 = v121.data:GetAttribute("Completed")
        local v122

        if v118 then
            v122 = t_1[v121.category]
            v118 = if v122 ~= nil then v122 else true
        end

        local Template_2 = v121.template
        local QuestName_2 = v121.questName
        local v123 = string.upper(SearchBox.Text)
        v122 = true

        if v123 ~= "" then
            v122 = if string.find(string.upper(QuestName_2), v123, 1, true) == nil then false else true
        end

        if v122 then
            v122 = not v118
        end

        Template_2.Visible = v122
    end

    t_12.maid:GiveTask(arg38:GetAttributeChangedSignal("Completed"):Connect(function() -- line: 542
        -- upvalues:
        --  [1] arg38 (copy)
        --  [2] v117 (copy)
        --  [3] Name (copy)
        --  [4] v115 (copy)
        --  [5] t_12 (copy)
        --  [6] t_1 (ref)
        --  [7] SearchBox (ref)
        --  [8] ReplicatedStorage (ref)

        local v124 = arg38:GetAttribute("Completed")
        local v125 = v117
        v125.Name = v124 and "_" .. Name or Name
        local Label_2 = v117.Label
        Label_2.Text = v124 and `<s><font color='rgb(155, 255, 140)'>{v115}</font></s>` or v115
        local v127 = t_12
        v124 = v127.data:GetAttribute("Completed")
        local v128

        if v124 then
            v128 = t_1[v127.category]
            v124 = if v128 ~= nil then v128 else true
        end

        local Template_3 = v127.template
        local QuestName_3 = v127.questName
        local v129 = string.upper(SearchBox.Text)
        v128 = true

        if v129 ~= "" then
            v128 = if string.find(string.upper(QuestName_3), v129, 1, true) == nil then false else true
        end

        if v128 then
            v128 = not v124
        end

        Template_3.Visible = v128

        if arg38:GetAttribute("Completed") then
            _G.CreateAlert(
                `<font color='rgb(255, 179, 71)'>({v115})</font> was completed.`,
                ReplicatedStorage.SFX.Misc.Alert
            )
        end
    end))
    v117.Button.MouseButton1Up:Connect(function() -- line: 549
        -- upvalues:
        --  [1] showInfo (ref)
        --  [2] t_12 (copy)

        showInfo(t_12)
    end)
    v117.MouseEnter:Connect(function() -- line: 552
        -- upvalues:
        --  [1] v117 (copy)

        v117.BackgroundTransparency = 0.9
    end)
    v117.MouseLeave:Connect(function() -- line: 555
        -- upvalues:
        --  [1] v117 (copy)

        v117.BackgroundTransparency = 1
    end)
    v117.Track.MouseButton1Up:Connect(function() -- line: 558
        -- upvalues:
        --  [1] v4 (ref)
        --  [2] t_12 (copy)
        --  [3] UpdateQuestLog (ref)
        --  [4] Name (copy)

        UpdateQuestLog:FireServer(
            if not (if v4 == nil then false else v4.entry == t_12) then "Track" else "Untrack",
            Name
        )
    end)
    local Completed_1 = arg38:GetAttribute("Completed")
    v117.Name = Completed_1 and "_" .. Name or Name
    local Label_3 = v117.Label
    Label_3.Text = Completed_1 and `<s><font color='rgb(155, 255, 140)'>{v115}</font></s>` or v115
    local v135 = t_12.data:GetAttribute("Completed")
    local v136

    if v135 then
        v136 = t_1[t_12.category]
        v135 = if v136 ~= nil then v136 else true
    end

    local Template_4 = t_12.template
    local QuestName_4 = t_12.questName
    local v137 = string.upper(SearchBox.Text)
    v136 = true

    if v137 ~= "" then
        v136 = if string.find(string.upper(QuestName_4), v137, 1, true) == nil then false else true
    end

    if v136 then
        v136 = not v135
    end

    Template_4.Visible = v136
    v135 = t_12.template:FindFirstChild("Track")

    if v135 then
        v135.Label.Text = "TRACK"
        v135.Label.TextColor3 = color_1
    end

    v117.Parent = getCategory(t_12.category).Items
    t[Name] = t_12
    local Tracking_2 = Quests:GetAttribute("Tracking")
    local v138 = Tracking_2 and t[Tracking_2] or nil

    if v4 and v4.entry == v138 then
        return
    end

    if v4 then
        local v139 = v4
        v4 = nil
        v139.maid:Destroy()
    end

    if v138 then
        startTracking(v138)
    end
end

local function safeCreateEntry(arg40, arg41) -- line: 571
    -- upvalues:
    --  [1] createEntry (copy)

    local Success, Result = pcall(createEntry, arg40, arg41)

    if not Success then
        warn(`[QuestLog] {arg40.Name}: {Result}`)
    end
end

local function refreshTrackingFrame() -- line: 578
    -- upvalues:
    --  [1] UIListLayout (copy)
    --  [2] Tracking (copy)
    --  [3] LocalPlayer (copy)

    local Y = UIListLayout.AbsoluteContentSize.Y
    Tracking.Size = UDim2.new(Tracking.Size.X.Scale, Tracking.Size.X.Offset, 0, (math.min(Y, 250)))
    local v141 = false
    local v142 = Tracking

    if Y > 0 then
        v141 = not LocalPlayer:GetAttribute("InMissionClient")
    end

    v142.Visible = v141
end

local function journalAction(_, arg43) -- line: 584
    -- upvalues:
    --  [1] Bin (copy)
    --  [2] Log (copy)
    --  [3] LocalPlayer (copy)
    --  [4] v6 (ref)
    --  [5] v7 (ref)
    --  [6] ReplicatedStorage (copy)
    --  [7] QuestIndex (copy)

    if Bin.Event.Value ~= "" then
        return
    end

    if arg43 == Enum.UserInputState.Begin then
        local v143 = not Log.Visible
        Log.Visible = v143
        local v144 = LocalPlayer.Character
        local v145 = v144

        if v145 then
            v145 = v144:FindFirstChildOfClass("Humanoid")
        end

        v144 = v145

        if v144 then
            v144 = v145:FindFirstChildOfClass("Animator")
        end

        local v146

        if not v144 then
            v146 = nil
        else
            if v144 ~= v6 then
                v6 = v144
                v7 = v144:LoadAnimation(ReplicatedStorage.Animations.Items.BookHold)
            end

            v146 = v7
        end

        if v146 then
            if v143 then
                v146:Play(0.2)
            else
                v146:Stop(0.2)
            end
        end

        task.spawn(pcall, QuestIndex.InvokeServer, QuestIndex, v143)
    end
end

CreateBindableAction_m("Quest Journal", QuestJournal, journalAction)
v2.setHold(Enum.KeyCode.DPadDown, function() -- line: 596
    -- upvalues:
    --  [1] Bin (copy)
    --  [2] Log (copy)
    --  [3] LocalPlayer (copy)
    --  [4] v6 (ref)
    --  [5] v7 (ref)
    --  [6] ReplicatedStorage (copy)
    --  [7] QuestIndex (copy)

    if Bin.Event.Value ~= "" then
        return
    end

    if Enum.UserInputState.Begin == Enum.UserInputState.Begin then
        local v147 = not Log.Visible
        Log.Visible = v147
        local v148 = LocalPlayer.Character
        local v149 = v148

        if v149 then
            v149 = v148:FindFirstChildOfClass("Humanoid")
        end

        v148 = v149

        if v148 then
            v148 = v149:FindFirstChildOfClass("Animator")
        end

        local v150

        if not v148 then
            v150 = nil
        else
            if v148 ~= v6 then
                v6 = v148
                v7 = v148:LoadAnimation(ReplicatedStorage.Animations.Items.BookHold)
            end

            v150 = v7
        end

        if v150 then
            if v147 then
                v150:Play(0.2)
            else
                v150:Stop(0.2)
            end
        end

        task.spawn(pcall, QuestIndex.InvokeServer, QuestIndex, v147)
    end
end)
Log.Close.MouseButton1Up:Connect(function() -- line: 600
    -- upvalues:
    --  [1] Log (copy)
    --  [2] LocalPlayer (copy)
    --  [3] v6 (ref)
    --  [4] v7 (ref)
    --  [5] ReplicatedStorage (copy)
    --  [6] QuestIndex (copy)

    Log.Visible = false
    local v151 = LocalPlayer.Character
    local v152 = v151

    if v152 then
        v152 = v151:FindFirstChildOfClass("Humanoid")
    end

    v151 = v152

    if v151 then
        v151 = v152:FindFirstChildOfClass("Animator")
    end

    local v153

    if not v151 then
        v153 = nil
    else
        if v151 ~= v6 then
            v6 = v151
            v7 = v151:LoadAnimation(ReplicatedStorage.Animations.Items.BookHold)
        end

        v153 = v7
    end

    if v153 then
        v153:Stop(0.2)
    end

    task.spawn(pcall, QuestIndex.InvokeServer, QuestIndex, false)
end)
SearchBox:GetPropertyChangedSignal("Text"):Connect(function() -- line: 604
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_1 (copy)
    --  [3] SearchBox (copy)

    local v155

    for _, val_9 in t do
        local v154 = val_9.data:GetAttribute("Completed")

        if v154 then
            v155 = t_1[val_9.category]
            v154 = if v155 ~= nil then v155 else true
        end

        local Template_5 = val_9.template
        local QuestName_5 = val_9.questName
        local v156 = string.upper(SearchBox.Text)
        v155 = true

        if v156 ~= "" then
            v155 = if string.find(string.upper(QuestName_5), v156, 1, true) == nil then false else true
        end

        if v155 then
            v155 = not v154
        end

        Template_5.Visible = v155
    end
end)
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(refreshTrackingFrame)
LocalPlayer:GetAttributeChangedSignal("InMissionClient"):Connect(refreshTrackingFrame)
local Y_1 = UIListLayout.AbsoluteContentSize.Y
Tracking.Size = UDim2.new(Tracking.Size.X.Scale, Tracking.Size.X.Offset, 0, (math.min(Y_1, 250)))
Tracking.Visible = if Y_1 > 0 then not LocalPlayer:GetAttribute("InMissionClient") else false
Quests.ChildAdded:Connect(function(child_6) -- line: 614
    -- upvalues:
    --  [1] createEntry (copy)

    local Success_1, Result_1 = pcall(createEntry, child_6, false)

    if not Success_1 then
        warn(`[QuestLog] {child_6.Name}: {Result_1}`)
    end
end)
Quests.ChildRemoved:Connect(function(child_7) -- line: 617
    -- upvalues:
    --  [1] t (copy)
    --  [2] v3 (ref)
    --  [3] v5 (copy)
    --  [4] Display (copy)
    --  [5] Info (copy)
    --  [6] v4 (ref)

    local v158 = t[child_7.Name]

    if v158 and v158.data == child_7 then
        if t[v158.key] ~= v158 then
            return
        end

        t[v158.key] = nil

        if v3 == v158 then
            v5:Destroy()

            if v3 and v3.template.Parent then
                v3.template:SetAttribute("Highlighted", false)
            end

            v3 = nil
            Display.Header.Text = ""
            Display.Description.Text = ""
            Info.Repeatable.Visible = false
            Info.Return.Visible = false
        end

        if v4 and v4.entry == v158 and v4 then
            local v159 = v4
            v4 = nil
            v159.maid:Destroy()
        end

        v158.maid:Destroy()
    end
end)
Quests:GetAttributeChangedSignal("Tracking"):Connect(refreshTracking)

for _, child_5 in Quests:GetChildren() do
    task.spawn(safeCreateEntry, child_5, true)
end

local Tracking_3 = Quests:GetAttribute("Tracking")
v2 = t[Tracking_3]
local _ = Quests:GetAttribute("Tracking")
local _ = task.spawn

if not Tracking_3 or not v2 then
    v2 = nil
end

if v4 then
    if v4.entry ~= v2 then
        if v4 then
            local v160 = v4
            v4 = nil
            v160.maid:Destroy()
        end

        if v2 then
            startTracking(v2)
        end
    end
else
    if v4 then
        local v161 = v4
        v4 = nil
        v161.maid:Destroy()
    end

    if v2 then
        startTracking(v2)
    end
end
