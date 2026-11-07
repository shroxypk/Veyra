-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.LocalQuest
-- Class: LocalScript
-- bytes: 26376

local _ = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local ObjectTracker_m = require(Modules.ObjectTracker)
local QuestProgress_m = require(Modules.QuestProgress)
local Quests = Modules.ClientNPCS.Quests
local v2 = require(Modules.scriptObjs).GetPlayerCharacter()
local Settings = v2:WaitForChild("Settings")
local Quests_1 = v2:WaitForChild("Quests")
local PlayerGui = v2:WaitForChild("PlayerGui")
local QuestIndicators = script.QuestIndicators
QuestIndicators.Parent = PlayerGui
local t = { "QuestObject", "QuestNPC" }
local t_1 = { TrackPosition = true, Object = true }
local t_2 = { ReturnPosition = true, ReturnNPC = true, Quest = true }
local color = Color3.fromRGB(255, 255, 0)
local color_1 = Color3.fromRGB(11, 210, 255)
local color_2 = Color3.fromRGB(6, 6, 6)
local v3 = not Settings.QuestIcons.Value

local _ = function() --[[ getRoot ]] -- line: 40
    -- upvalues:
    --  [1] v2 (copy)

    local Character = v2.Character
    local v4 = Character

    if v4 then
        v4 = Character:FindFirstChild("HumanoidRootPart")
    end

    return v4
end

local function doCleanup(arg1) -- line: 45
    for index = #arg1, 1, -1 do
        local v5 = arg1[index]
        arg1[index] = nil
        local v6 = typeof(v5)

        if v6 == "RBXScriptConnection" then
            v5:Disconnect()
        elseif v6 == "Instance" then
            v5:Destroy()
        elseif v6 == "function" then
            v5()
        elseif v6 == "table" and v5.Disconnect then
            v5:Disconnect()
        end
    end
end

local t_3 = {}

local _ = function(arg2) --[[ paintMarker ]] -- line: 68
    -- upvalues:
    --  [1] Quests_1 (copy)
    --  [2] color_2 (copy)

    local v7 = if Quests_1:FindFirstChild(arg2.key) ~= nil then false else true
    arg2.image.ImageColor3 = v7 and arg2.activeColor or color_2
end

local _ = function(arg3) --[[ refreshNpcMarkers ]] -- line: 73
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] Quests_1 (copy)
    --  [3] color_2 (copy)

    for _, val in t_3 do
        if val.key == arg3 then
            local v9 = if Quests_1:FindFirstChild(val.key) ~= nil then false else true
            val.image.ImageColor3 = v9 and val.activeColor or color_2
        end
    end
end

local _ = function(arg4) --[[ hasQuestTag ]] -- line: 81
    -- upvalues:
    --  [1] t (copy)

    for _, val_1 in t do
        if arg4:HasTag(val_1) then
            return true
        end
    end

    return false
end

local function onQuestTagAdded(arg5) -- line: 90
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] Quests (copy)
    --  [3] color (copy)
    --  [4] color_1 (copy)
    --  [5] Quests_1 (copy)
    --  [6] color_2 (copy)

    if t_3[arg5] then
        return
    end

    local Name = arg5.Name
    local v11 = Quests:FindFirstChild(Name, true)

    if not v11 then
        return
    end

    local v12 = script.QuestDisplay:Clone()
    v12.Enabled = true
    v12.Parent = arg5
    local t_4 = { key = Name, gui = v12, image = v12.Main.Exclamation, activeColor = nil }
    local v13 = color

    if v11:GetAttribute("CooldownType") ~= "OneTime" or not v13 then
        v13 = color_1
    end

    t_4.activeColor = v13
    t_3[arg5] = t_4
    v12 = if Quests_1:FindFirstChild(t_4.key) ~= nil then false else true
    t_4.image.ImageColor3 = v12 and t_4.activeColor or color_2
end

local function onQuestTagRemoved(arg6) -- line: 115
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_3 (copy)

    local v15

    if arg6:IsDescendantOf(game) then
        for _, val_2 in t do
            if arg6:HasTag(val_2) then
                v15 = true
            end
        end

        v15 = false

        if v15 then
            return
        end
    end

    v15 = t_3[arg6]

    if v15 then
        t_3[arg6] = nil
        v15.gui:Destroy()
    end
end

local t_5 = {}

local _ = function(arg7) --[[ isViewing ]] -- line: 132
    return if arg7.screenGui:GetAttribute("status") ~= true then false else true
end

local _ = function(arg8, arg9) --[[ computeVisible ]] -- line: 136
    -- upvalues:
    --  [1] v3 (ref)

    if not arg8.alive or v3 then
        return false
    end

    if arg9:GetAttribute("Hidden") then
        return false
    end

    local v17 = arg8.billboards[arg9]

    return if v17 == nil then false else v17()
end

local _ = function(arg10, arg11) --[[ refreshBillboard ]] -- line: 147
    -- upvalues:
    --  [1] v3 (ref)

    local v19

    if not arg10.alive or v3 then
        v19 = false
    elseif arg11:GetAttribute("Hidden") then
        v19 = false
    else
        local v20 = arg10.billboards[arg11]
        v19 = if v20 == nil then false else v20()
    end

    arg11.Enabled = v19
end

local function refreshQuest(arg12) -- line: 151
    -- upvalues:
    --  [1] v3 (ref)

    for key_3 in arg12.syncs do
        key_3()
    end

    local v21

    for key_4 in arg12.billboards do
        if not arg12.alive or v3 then
            v21 = false
        elseif key_4:GetAttribute("Hidden") then
            v21 = false
        else
            local v22 = arg12.billboards[key_4]
            v21 = if v22 == nil then false else v22()
        end

        key_4.Enabled = v21
    end
end

local _ = function() --[[ refreshAll ]] -- line: 160
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] refreshQuest (copy)

    for _, val_3 in t_5 do
        refreshQuest(val_3)
    end
end

local function addBillboard(arg13, arg14, arg15, arg16) -- line: 166
    -- upvalues:
    --  [1] v3 (ref)

    arg13.billboards[arg14] = arg16
    local Hidden = arg14:GetAttributeChangedSignal("Hidden")
    table.insert(arg15, Hidden:Connect(function() -- line: 168
        -- upvalues:
        --  [1] arg13 (copy)
        --  [2] arg14 (copy)
        --  [3] v3 (ref)

        local v23 = arg13
        local v24 = arg14
        local v25

        if not v23.alive or v3 then
            v25 = false
        elseif v24:GetAttribute("Hidden") then
            v25 = false
        else
            local v26 = v23.billboards[v24]
            v25 = if v26 == nil then false else v26()
        end

        v24.Enabled = v25
    end))
    table.insert(arg15, function() -- line: 171
        -- upvalues:
        --  [1] arg13 (copy)
        --  [2] arg14 (copy)

        arg13.billboards[arg14] = nil
    end)
    table.insert(arg15, arg14)
    local v27

    if not arg13.alive or v3 then
        v27 = false
    else
        local _ = table.insert

        if arg14:GetAttribute("Hidden") then
            v27 = false
        else
            local v28 = arg13.billboards[arg14]
            v27 = if v28 == nil then false else v28()
        end
    end

    arg14.Enabled = v27
end

local _ = function(arg17, arg18) --[[ newIndicatorPart ]] -- line: 178
    local v29 = script.IndicatorPart:Clone()
    v29.Name = arg18
    v29.Parent = arg17.folder

    return v29
end

local function setupTask(arg19, arg20) -- line: 185
    -- upvalues:
    --  [1] addBillboard (copy)
    --  [2] v3 (ref)
    --  [3] ObjectTracker_m (copy)
    --  [4] QuestProgress_m (copy)

    local t_6 = {}
    local Name_1 = arg20.Name
    local TrackPosition = arg20:GetAttribute("TrackPosition")
    local Object = arg20:GetAttribute("Object")
    local v30 = false
    local t_7 = {}

    local _ = function() --[[ isActive ]] -- line: 195
        -- upvalues:
        --  [1] v30 (ref)
        --  [2] arg20 (copy)

        local v31 = not v30

        if v31 then
            v31 = not arg20:GetAttribute("Hidden")
        end

        return v31
    end

    local function refreshTask() -- line: 199
        -- upvalues:
        --  [1] t_7 (copy)

        for _, val_4 in t_7 do
            val_4()
        end
    end

    if typeof(TrackPosition) == "Vector3" and TrackPosition ~= Vector3.new(0, 0, 0) then
        local v32 = script.IndicatorPart:Clone()
        v32.Name = Name_1
        v32.Parent = arg19.folder
        v32.Position = TrackPosition
        table.insert(t_6, v32)
        local v33 = script.TaskDisplay:Clone()
        v33.Name = Name_1
        v33.Main.header.Text = Name_1
        v33.Adornee = v32
        v33.Parent = arg19.screenGui
        addBillboard(arg19, v33, t_6, function() -- line: 217
            -- upvalues:
            --  [1] v30 (ref)
            --  [2] arg20 (copy)
            --  [3] arg19 (copy)

            local v34 = not v30

            if v34 then
                v34 = not arg20:GetAttribute("Hidden")
            end

            if v34 then
                v34 = if arg19.screenGui:GetAttribute("status") ~= true then false else true
            end

            return v34
        end)
        table.insert(t_7, function() -- line: 220
            -- upvalues:
            --  [1] arg19 (copy)
            --  [2] v33 (copy)
            --  [3] v3 (ref)

            local v35 = arg19
            local v36 = v33
            local v37

            if not v35.alive or v3 then
                v37 = false
            elseif v36:GetAttribute("Hidden") then
                v37 = false
            else
                local v38 = v35.billboards[v36]
                v37 = if v38 == nil then false else v38()
            end

            v36.Enabled = v37
        end)
        arg19.distanceGuis[v33] = arg20
        table.insert(t_6, function() -- line: 225
            -- upvalues:
            --  [1] arg19 (copy)
            --  [2] v33 (copy)

            arg19.distanceGuis[v33] = nil
        end)
    end

    if arg20:HasTag("TrackClosest") and Object then
        local v41 = script.ObjectTrack:Clone()
        v41.Name = Name_1
        v41.Main.header.Text = Name_1
        v41.Parent = arg19.screenGui
        local v42 = nil
        addBillboard(arg19, v41, t_6, function() -- line: 238
            -- upvalues:
            --  [1] v42 (ref)
            --  [2] v30 (ref)
            --  [3] arg20 (copy)
            --  [4] arg19 (copy)

            local v43 = false

            if v42 ~= nil then
                v43 = not v30

                if v43 then
                    v43 = not arg20:GetAttribute("Hidden")
                end

                if v43 then
                    v43 = if arg19.screenGui:GetAttribute("status") ~= true then false else true
                end
            end

            return v43
        end)
        local v44 = arg19.key .. "/" .. Name_1
        ObjectTracker_m.Register(v44, Object)
        ObjectTracker_m.OnClosestChanged(v44, function(_, arg22) -- line: 245
            -- upvalues:
            --  [1] arg19 (copy)
            --  [2] v41 (copy)
            --  [3] v42 (ref)
            --  [4] ObjectTracker_m (ref)
            --  [5] v3 (ref)

            if not arg19.alive or not v41.Parent then
                return
            end

            local v45 = arg22 and ObjectTracker_m.GetAnchor(arg22)
            v42 = v45
            v41.Adornee = v42
            local v46 = arg19
            local v47 = v41
            local v48

            if not v46.alive or v3 then
                v48 = false
            elseif v47:GetAttribute("Hidden") then
                v48 = false
            else
                local v49 = v46.billboards[v47]
                v48 = if v49 == nil then false else v49()
            end

            v47.Enabled = v48
        end)
        table.insert(t_6, function() -- line: 253
            -- upvalues:
            --  [1] ObjectTracker_m (ref)
            --  [2] v44 (copy)

            ObjectTracker_m.Unregister(v44)
        end)

        local function syncTracking() -- line: 258
            -- upvalues:
            --  [1] arg19 (copy)
            --  [2] v3 (ref)
            --  [3] v30 (ref)
            --  [4] arg20 (copy)
            --  [5] ObjectTracker_m (ref)
            --  [6] v44 (copy)

            if arg19.alive then
                local v50 = if arg19.screenGui:GetAttribute("status") ~= true then false else true

                if v50 and not v3 then
                    v50 = not v30

                    if v50 then
                        v50 = not arg20:GetAttribute("Hidden")
                    end

                    if v50 then
                        ObjectTracker_m.StartTracking(v44)

                        return
                    end
                end
            end

            ObjectTracker_m.StopTracking(v44)
        end

        arg19.syncs[syncTracking] = true
        table.insert(t_6, function() -- line: 266
            -- upvalues:
            --  [1] arg19 (copy)
            --  [2] syncTracking (copy)

            arg19.syncs[syncTracking] = nil
        end)
        table.insert(t_7, function() -- line: 269
            -- upvalues:
            --  [1] arg19 (copy)
            --  [2] v3 (ref)
            --  [3] v30 (ref)
            --  [4] arg20 (copy)
            --  [5] ObjectTracker_m (ref)
            --  [6] v44 (copy)
            --  [7] v41 (copy)

            if arg19.alive then
                local v51 = if arg19.screenGui:GetAttribute("status") ~= true then false else true

                if v51 then
                    if not v3 then
                        v51 = not v30

                        if v51 then
                            v51 = not arg20:GetAttribute("Hidden")
                        end

                        if v51 then
                            ObjectTracker_m.StartTracking(v44)
                        else
                            ObjectTracker_m.StopTracking(v44)
                        end
                    else
                        ObjectTracker_m.StopTracking(v44)
                    end
                else
                    ObjectTracker_m.StopTracking(v44)
                end
            else
                ObjectTracker_m.StopTracking(v44)
            end

            local v52 = arg19
            local v53 = v41
            local v54

            if not v52.alive or v3 then
                v54 = false
            elseif v53:GetAttribute("Hidden") then
                v54 = false
            else
                local v55 = v52.billboards[v53]
                v54 = if v55 == nil then false else v55()
            end

            v53.Enabled = v54
        end)

        if arg19.alive then
            local v56 = if arg19.screenGui:GetAttribute("status") ~= true then false else true

            if v56 then
                if not v3 then
                    v56 = not v30

                    if v56 then
                        v56 = not arg20:GetAttribute("Hidden")
                    end

                    if v56 then
                        ObjectTracker_m.StartTracking(v44)
                    else
                        ObjectTracker_m.StopTracking(v44)
                    end
                else
                    ObjectTracker_m.StopTracking(v44)
                end
            else
                ObjectTracker_m.StopTracking(v44)
            end
        else
            ObjectTracker_m.StopTracking(v44)
        end
    end

    table.insert(t_6, arg20:GetAttributeChangedSignal("Hidden"):Connect(refreshTask))
    table.insert(t_6, QuestProgress_m.watch(arg20, function(arg23) -- line: 277
        -- upvalues:
        --  [1] QuestProgress_m (ref)
        --  [2] arg20 (copy)
        --  [3] v30 (ref)
        --  [4] t_7 (copy)

        local v57 = arg23 >= QuestProgress_m.getMax(arg20) and true

        if v57 ~= v30 then
            v30 = v57

            for _, val_5 in t_7 do
                val_5()
            end
        end
    end))

    return t_6
end

local _ = function(arg24, arg25) --[[ unbindTask ]] -- line: 288
    -- upvalues:
    --  [1] doCleanup (copy)

    local v58 = arg24.tasks[arg25]

    if not v58 then
        return
    end

    arg24.tasks[arg25] = nil
    v58.connection:Disconnect()
    doCleanup(v58.content)
end

local function bindTask(arg26, arg27) -- line: 298
    -- upvalues:
    --  [1] doCleanup (copy)
    --  [2] setupTask (copy)
    --  [3] t_1 (copy)

    if arg26.tasks[arg27] then
        return
    end

    local t_8 = { content = {} }
    arg26.tasks[arg27] = t_8

    local _ = function() --[[ rebuild ]] -- line: 306
        -- upvalues:
        --  [1] doCleanup (ref)
        --  [2] t_8 (copy)
        --  [3] arg26 (copy)
        --  [4] arg27 (copy)
        --  [5] setupTask (ref)

        doCleanup(t_8.content)

        if arg26.alive and arg26.tasks[arg27] == t_8 then
            t_8.content = setupTask(arg26, arg27)
        end
    end

    t_8.connection = arg27.AttributeChanged:Connect(function(attribute) -- line: 313
        -- upvalues:
        --  [1] t_1 (ref)
        --  [2] doCleanup (ref)
        --  [3] t_8 (copy)
        --  [4] arg26 (copy)
        --  [5] arg27 (copy)
        --  [6] setupTask (ref)

        if t_1[attribute] then
            doCleanup(t_8.content)

            if arg26.alive and arg26.tasks[arg27] == t_8 then
                t_8.content = setupTask(arg26, arg27)
            end
        end
    end)
    doCleanup(t_8.content)

    if arg26.alive and arg26.tasks[arg27] == t_8 then
        t_8.content = setupTask(arg26, arg27)
    end
end

local function setupReturn(arg29) -- line: 322
    -- upvalues:
    --  [1] addBillboard (copy)
    --  [2] v3 (ref)

    local t_9 = {}
    local Data = arg29.data
    local v61 = Data:GetAttribute("ReturnPosition")

    if typeof(v61) == "Vector3" then
        v61 = CFrame.new(v61)
    end

    if typeof(v61) ~= "CFrame" then
        return t_9
    end

    local v62 = script.IndicatorPart:Clone()
    v62.Name = "Return"
    v62.Parent = arg29.folder
    v62.CFrame = v61
    table.insert(t_9, v62)
    v61 = script.ReturnDisplay:Clone()
    v61.Name = "Return"
    local Header = v61.Main.header
    Header.Text = Data:GetAttribute("ReturnNPC") or (Data:GetAttribute("Quest") or arg29.key)
    v61.Parent = v62
    addBillboard(arg29, v61, t_9, function() -- line: 343
        -- upvalues:
        --  [1] arg29 (copy)

        return if arg29.screenGui:GetAttribute("Return") ~= true then false else true
    end)
    table.insert(t_9, arg29.screenGui:GetAttributeChangedSignal("Return"):Connect(function() -- line: 347
        -- upvalues:
        --  [1] arg29 (copy)
        --  [2] v61 (copy)
        --  [3] v3 (ref)

        local v65 = arg29
        local v66 = v61
        local v67

        if not v65.alive or v3 then
            v67 = false
        elseif v66:GetAttribute("Hidden") then
            v67 = false
        else
            local v68 = v65.billboards[v66]
            v67 = if v68 == nil then false else v68()
        end

        v66.Enabled = v67
    end))

    return t_9
end

local _ = function(arg30) --[[ getScreenGui ]] -- line: 354
    -- upvalues:
    --  [1] QuestIndicators (copy)

    local v69 = QuestIndicators:FindFirstChild(arg30)

    if not v69 then
        v69 = Instance.new("ScreenGui")
        v69.Name = arg30
        v69.ResetOnSpawn = false
        v69.Parent = QuestIndicators
    end

    return v69
end

local function destroyQuest(arg31) -- line: 365
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] doCleanup (copy)

    if not arg31.alive then
        return
    end

    arg31.alive = false

    if t_5[arg31.key] == arg31 then
        t_5[arg31.key] = nil
    end

    for key_8 in arg31.tasks do
        local v70 = arg31.tasks[key_8]

        if v70 then
            arg31.tasks[key_8] = nil
            v70.connection:Disconnect()
            doCleanup(v70.content)
        end
    end

    doCleanup(arg31.returnContent)
    doCleanup(arg31.cleanup)
end

local function startQuest(arg32) -- line: 382
    -- upvalues:
    --  [1] Quests_1 (copy)
    --  [2] t_5 (copy)
    --  [3] destroyQuest (copy)
    --  [4] QuestIndicators (copy)
    --  [5] refreshQuest (copy)
    --  [6] bindTask (copy)
    --  [7] doCleanup (copy)
    --  [8] setupReturn (copy)
    --  [9] t_2 (copy)

    local Name_2 = arg32.Name
    local Tasks = arg32:WaitForChild("Tasks", 10)

    if not Tasks or arg32.Parent ~= Quests_1 then
        return
    end

    if arg32:GetAttribute("Completed") then
        return
    end

    local v71 = t_5[Name_2]

    if v71 then
        destroyQuest(v71)
    end

    local Folder = Instance.new("Folder")
    Folder.Name = Name_2
    Folder.Parent = workspace.Objects
    local t_10 = {
        key = Name_2,
        data = arg32,
        screenGui = nil,
        folder = nil,
        billboards = nil,
        syncs = nil,
        distanceGuis = nil,
        tasks = nil,
        returnContent = nil,
        cleanup = nil,
        alive = true
    }
    local v72 = QuestIndicators:FindFirstChild(Name_2)

    if not v72 then
        v72 = Instance.new("ScreenGui")
        v72.Name = Name_2
        v72.ResetOnSpawn = false
        v72.Parent = QuestIndicators
    end

    t_10.screenGui = v72
    t_10.folder = Folder
    t_10.billboards = {}
    t_10.syncs = {}
    t_10.distanceGuis = {}
    t_10.tasks = {}
    t_10.returnContent = {}
    t_10.cleanup = { Folder }
    t_5[Name_2] = t_10
    table.insert(t_10.cleanup, t_10.screenGui:GetAttributeChangedSignal("status"):Connect(function() -- line: 417
        -- upvalues:
        --  [1] refreshQuest (ref)
        --  [2] t_10 (copy)

        refreshQuest(t_10)
    end))
    local _ = t_10.screenGui:GetAttributeChangedSignal("status"):Connect(function() -- line: 417
        -- upvalues:
        --  [1] refreshQuest (ref)
        --  [2] t_10 (copy)

        refreshQuest(t_10)
    end)

    for _, child in Tasks:GetChildren() do
        bindTask(t_10, child)
    end

    table.insert(t_10.cleanup, Tasks.ChildAdded:Connect(function(child_1) -- line: 424
        -- upvalues:
        --  [1] bindTask (ref)
        --  [2] t_10 (copy)

        bindTask(t_10, child_1)
    end))
    table.insert(t_10.cleanup, Tasks.ChildRemoved:Connect(function(child_2) -- line: 427
        -- upvalues:
        --  [1] t_10 (copy)
        --  [2] doCleanup (ref)

        local v74 = t_10
        local v75 = v74.tasks[child_2]

        if not v75 then
            return
        end

        v74.tasks[child_2] = nil
        v75.connection:Disconnect()
        doCleanup(v75.content)
    end))
    t_10.returnContent = setupReturn(t_10)
    table.insert(t_10.cleanup, arg32.AttributeChanged:Connect(function(attribute_1) -- line: 433
        -- upvalues:
        --  [1] arg32 (copy)
        --  [2] destroyQuest (ref)
        --  [3] t_10 (copy)
        --  [4] t_2 (ref)
        --  [5] doCleanup (ref)
        --  [6] setupReturn (ref)

        if attribute_1 == "Completed" then
            if arg32:GetAttribute("Completed") then
                destroyQuest(t_10)

                return
            end
        elseif t_2[attribute_1] then
            doCleanup(t_10.returnContent)
            t_10.returnContent = setupReturn(t_10)
        end
    end))
end

local function onQuestAdded(arg36) -- line: 445
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] Quests_1 (copy)
    --  [3] color_2 (copy)
    --  [4] startQuest (copy)

    local Name_3 = arg36.Name

    for _, val_6 in t_3 do
        if val_6.key == Name_3 then
            local v77 = if Quests_1:FindFirstChild(val_6.key) ~= nil then false else true
            val_6.image.ImageColor3 = v77 and val_6.activeColor or color_2
        end
    end

    local Success, Result = pcall(startQuest, arg36)

    if not Success then
        warn(`[QuestIndicators] {arg36.Name}: {Result}`)
    end
end

local function onQuestRemoved(arg37) -- line: 454
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] destroyQuest (copy)
    --  [3] t_3 (copy)
    --  [4] Quests_1 (copy)
    --  [5] color_2 (copy)

    local v79 = t_5[arg37.Name]

    if v79 and v79.data == arg37 then
        destroyQuest(v79)
    end

    local Name_4 = arg37.Name

    for _, val_7 in t_3 do
        if val_7.key == Name_4 then
            v79 = if Quests_1:FindFirstChild(val_7.key) ~= nil then false else true
            val_7.image.ImageColor3 = v79 and val_7.activeColor or color_2
        end
    end
end

local v81 = 0.25
RunService.Heartbeat:Connect(function(deltaTime) -- line: 467
    -- upvalues:
    --  [1] v81 (ref)
    --  [2] v3 (ref)
    --  [3] v2 (copy)
    --  [4] t_5 (copy)

    v81 += deltaTime

    if v81 < 0.25 then
        return
    end

    v81 = 0

    if v3 then
        return
    end

    local Character_1 = v2.Character
    local v82 = Character_1

    if v82 then
        v82 = Character_1:FindFirstChild("HumanoidRootPart")
    end

    if not v82 then
        return
    end

    local Position = v82.Position

    for _, val_8 in t_5 do
        if if val_8.screenGui:GetAttribute("status") ~= true then false else true then
            for key_13, val_9 in val_8.distanceGuis do
                if key_13.Enabled then
                    v82 = val_9:GetAttribute("TrackPosition")

                    if typeof(v82) == "Vector3" then
                        local v84 = val_9:GetAttribute("TrackRadius")

                        if not v84 or v84 == 0 then
                            v84 = 100
                        end

                        local Magnitude = (Position - v82).Magnitude
                        local Dist = key_13.Main.dist
                        local v85 = math.floor(Magnitude)
                        Dist.Text = `{v85}m`
                        key_13.Main.Visible = v84 < Magnitude and true
                    end
                end
            end
        end
    end
end)

for _, val_10 in t do
    CollectionService:GetInstanceAddedSignal(val_10):Connect(onQuestTagAdded)
    CollectionService:GetInstanceRemovedSignal(val_10):Connect(onQuestTagRemoved)

    for _, val_11 in CollectionService:GetTagged(val_10) do
        onQuestTagAdded(val_11)
    end
end

Quests_1.ChildAdded:Connect(onQuestAdded)
Quests_1.ChildRemoved:Connect(onQuestRemoved)

for _, child_3 in Quests_1:GetChildren() do
    task.spawn(onQuestAdded, child_3)
end

Settings.QuestIcons:GetPropertyChangedSignal("Value"):Connect(function() -- line: 529
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] Settings (copy)
    --  [3] t_5 (copy)
    --  [4] refreshQuest (copy)

    v3 = not Settings.QuestIcons.Value

    for _, val_12 in t_5 do
        refreshQuest(val_12)
    end
end)
