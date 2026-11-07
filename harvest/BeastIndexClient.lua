-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Main.Menu.Pages.BeastIndex.BeastIndexClient
-- Class: LocalScript
-- bytes: 35571

local _ = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local BeastDefinitions_m = require(ReplicatedStorage.Modules.BeastDefinitions)
local ViewportHandle_m = require(ReplicatedStorage.Modules.ViewportHandle)
local v2, _ = require(ReplicatedStorage.Modules.scriptObjs).GetPlayerCharacter()
local BeastIndex = v2:WaitForChild("BeastIndex")
local Claimed = BeastIndex:WaitForChild("Claimed")
local BeastIndexData = ReplicatedStorage:WaitForChild("BeastIndexData")
local Tools = ReplicatedStorage:WaitForChild("Tools")
local ClaimBeastReward = ReplicatedStorage.Remotes:WaitForChild("ClaimBeastReward")
local Parent = script.Parent
local List = Parent.EnemyList.List
local List_1 = Parent.EnemyInfo.List
local Label = Parent.EnemyList.Discovered.Label
local Info = List_1.Info
local Entry = script.Entry
local Item = script.Item
local DropChance = script.DropChance
local ChestDrops = script.ChestDrops
local ChestDropRow = script.ChestDropRow
local EnemyImage = List_1.Top.Art.EnemyImage
local Title = List_1.Title
local Description = List_1.Top.Description
local Label_1 = Info.Info_1.Label
local Label_2 = Info.Info_2.Label
local Label_3 = Info.Info_3.Label
local List_2 = List_1.Drops.List
local Achievement = List_1.Achievement
local Info_1 = Achievement.Info
local Label_4 = Achievement.Reward.Label
local Front = Achievement.ProgressBar.Front
local Percent = Achievement.ProgressBar.Percent
local Claim = Achievement.ProgressBar.Claim
local Box = Parent.Search.Box
local NoResults = Parent.EnemyList.NoResults
require(ReplicatedStorage.Modules.CurrencyInfo).AttachHover(Achievement.Reward, "LockedEssence")
local New = Parent.Parent.Buttons.BeastIndex.New
local t = {}
local t_1 = {}
local t_2 = {}
local t_3 = {}
local v4 = nil
local t_4 = {}

for key, _ in pairs(BeastDefinitions_m) do
    table.insert(t_4, key)
end

table.sort(t_4, function(arg1, arg2) -- line: 75
    -- upvalues:
    --  [1] BeastDefinitions_m (copy)

    return BeastDefinitions_m[arg1].DisplayName < BeastDefinitions_m[arg2].DisplayName
end)
local t_5 = {}

for key_1, val_1 in t_4 do
    t_5[val_1] = key_1
end

local v6 = #t_4

local _ = function(arg3) --[[ getCount ]] -- line: 86
    -- upvalues:
    --  [1] BeastIndex (copy)

    return BeastIndex:GetAttribute(arg3) or 0
end

local _ = function(arg4) --[[ isDiscovered ]] -- line: 90
    -- upvalues:
    --  [1] BeastIndex (copy)

    return (BeastIndex:GetAttribute(arg4) or 0) > 0 and true
end

local _ = function(arg5) --[[ isClaimed ]] -- line: 94
    -- upvalues:
    --  [1] Claimed (copy)

    return if Claimed:GetAttribute(arg5) ~= true then false else true
end

local _ = function(arg6) --[[ isClaimable ]] -- line: 98
    -- upvalues:
    --  [1] Claimed (copy)
    --  [2] BeastIndex (copy)
    --  [3] BeastDefinitions_m (copy)

    local v10 = not (if Claimed:GetAttribute(arg6) ~= true then false else true)

    if v10 then
        v10 = (BeastIndex:GetAttribute(arg6) or 0) >= BeastDefinitions_m[arg6].MilestoneKills and true
    end

    return v10
end

local _ = function(arg7) --[[ hasNew ]] -- line: 104
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] Claimed (copy)
    --  [3] BeastIndex (copy)
    --  [4] BeastDefinitions_m (copy)

    local v11 = true

    if t_3[arg7] ~= true then
        v11 = not (if Claimed:GetAttribute(arg7) ~= true then false else true)

        if v11 then
            v11 = (BeastIndex:GetAttribute(arg7) or 0) >= BeastDefinitions_m[arg7].MilestoneKills and true
        end
    end

    return v11
end

local function getDrops(arg8) -- line: 108
    -- upvalues:
    --  [1] BeastIndexData (copy)
    --  [2] Tools (copy)

    local t_6 = {}
    local v13 = BeastIndexData:FindFirstChild(arg8)
    local v14 = v13

    if v14 then
        v14 = v13:FindFirstChild("Drops")
    end

    if v14 then
        for _, child in v14:GetChildren() do
            if child.Name ~= "Nothing" then
                if Tools:FindFirstChild(child.Name) then
                    table.insert(t_6, child.Name)
                else
                    warn(`[BeastIndex] No item model for drop '{child.Name}' ({arg8})`)
                end
            end
        end

        table.sort(t_6)
    end

    return t_6
end

local _ = function(arg9, arg10) --[[ getStat ]] -- line: 129
    -- upvalues:
    --  [1] BeastIndexData (copy)

    local v15 = BeastIndexData:FindFirstChild(arg9)
    local v16 = v15

    if v16 then
        v16 = v15:GetAttribute(arg10)
    end

    return v16
end

local function updateAmount() -- line: 134
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] BeastIndex (copy)
    --  [3] v6 (copy)
    --  [4] Label (copy)

    local v17 = 0

    for _, val_2 in t_4 do
        if if not ((BeastIndex:GetAttribute(val_2) or 0) > 0) then false else true then
            v17 += 1
        end
    end

    local str = tostring(v6)
    local _ = math.floor(v17 / v6 * 100)
    Label.Text = `{v17} of {str} Discovered`
end

local _ = function() --[[ updateMenuNew ]] -- line: 148
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] t_3 (copy)
    --  [3] Claimed (copy)
    --  [4] BeastIndex (copy)
    --  [5] BeastDefinitions_m (copy)
    --  [6] New (copy)

    local v21 = false

    for _, val_3 in t_4 do
        local v22 = true

        if t_3[val_3] ~= true then
            v22 = not (if Claimed:GetAttribute(val_3) ~= true then false else true)

            if v22 then
                v22 = (BeastIndex:GetAttribute(val_3) or 0) >= BeastDefinitions_m[val_3].MilestoneKills and true
            end
        end

        if v22 then
            v21 = true
            break
        end
    end

    New.Visible = v21
end

local _ = function(arg11, arg12) --[[ setEntrySelected ]] -- line: 162
    -- upvalues:
    --  [1] t (copy)

    local v24 = arg11 and t[arg11]
    local v25 = v24

    if v25 then
        v25 = v24:FindFirstChild("Selected")
    end

    if v25 then
        v25.Visible = arg12
    end
end

local _ = function(arg13, arg14) --[[ getDropChance ]] -- line: 171
    -- upvalues:
    --  [1] BeastIndexData (copy)

    local v26 = BeastIndexData:FindFirstChild(arg13)
    local v27 = v26

    if v27 then
        v27 = v26:FindFirstChild("Drops")
    end

    v26 = v27

    if v26 then
        v26 = v27:FindFirstChild(arg14)
    end

    local v28 = v26

    if v28 then
        v28 = v26:GetAttribute("Chance")
    end

    return v28
end

local v29 = script:FindFirstAncestorWhichIsA("ScreenGui")
local v30 = DropChance:Clone()
v30.Name = "BeastDropChance"
v30.Visible = false
v30.Parent = v29
local v31 = ChestDrops:Clone()
v31.Name = "BeastChestDrops"
v31.Visible = false
v31.Parent = v29
local v32 = nil
local v33 = nil
local t_7 = {}

local _ = function(arg15) --[[ formatChance ]] -- line: 206
    local v34 = arg15 * 100

    if v34 >= 99.95 then
        return "100%"
    end

    if v34 >= 10 then
        return string.format("%.0f%%", v34)
    end

    if v34 >= 0.1 then
        return string.format("%.1f%%", v34)
    end

    if v34 > 0 then
        return "<0.1%"
    end

    return "0%"
end

local function isOnScreen(arg16) -- line: 221
    -- upvalues:
    --  [1] v29 (copy)

    local v35 = arg16

    while v35 do
        if v35 == v29 then
            break
        end

        if v35:IsA("GuiObject") and not v35.Visible then
            return false
        end

        v35 = v35.Parent
    end

    return if v35 ~= v29 then false else v29.Enabled
end

local _ = function() --[[ hideTooltip ]] -- line: 232
    -- upvalues:
    --  [1] v32 (ref)
    --  [2] v30 (copy)
    --  [3] v31 (copy)
    --  [4] v33 (ref)

    v32 = nil
    v30.Visible = false
    v31.Visible = false

    if v33 then
        v33:Disconnect()
        v33 = nil
    end
end

local vec2 = Vector2.new(16, 12)

local function placeTooltip(arg17, arg18, arg19) -- line: 244
    -- upvalues:
    --  [1] v29 (copy)
    --  [2] UserInputService (copy)
    --  [3] GuiService (copy)
    --  [4] vec2 (copy)

    local AbsoluteSize = v29.AbsoluteSize
    local UIScale = arg17:FindFirstChildOfClass("UIScale")

    if UIScale and arg17.AbsoluteSize.Y > 0 then
        UIScale.Scale = math.min(1, (AbsoluteSize.Y - 16) / (arg17.AbsoluteSize.Y / UIScale.Scale))
    end

    local AbsoluteSize_1 = arg17.AbsoluteSize
    local v37

    if arg19 then
        v37 = UserInputService:GetMouseLocation()

        if not v29.IgnoreGuiInset then
            v37 -= GuiService:GetGuiInset()
        end

        v37 += vec2
    else
        v37 = arg18.AbsolutePosition - Vector2.new(0, AbsoluteSize_1.Y + 4)
    end

    local X = v37.X
    local v38 = math.max(AbsoluteSize.X - AbsoluteSize_1.X - 8, 8)
    local v39 = math.clamp(X, 8, v38)
    local Y = v37.Y
    local v40 = math.max(AbsoluteSize.Y - AbsoluteSize_1.Y - 8, 8)
    local v41 = math.clamp(Y, 8, v40)
    arg17.Position = UDim2.fromOffset(v39, v41)
end

local _ = function(arg20, arg21, arg22) --[[ showTooltip ]] -- line: 275
    -- upvalues:
    --  [1] v32 (ref)
    --  [2] v30 (copy)
    --  [3] v31 (copy)
    --  [4] v33 (ref)
    --  [5] placeTooltip (copy)
    --  [6] RunService (copy)
    --  [7] isOnScreen (copy)

    v32 = nil
    v30.Visible = false
    v31.Visible = false

    if v33 then
        v33:Disconnect()
        v33 = nil
    end

    v32 = arg20
    placeTooltip(arg21, arg20, arg22)
    arg21.Visible = true
    v33 = RunService.RenderStepped:Connect(function() -- line: 282
        -- upvalues:
        --  [1] v32 (ref)
        --  [2] arg20 (copy)
        --  [3] isOnScreen (ref)
        --  [4] v30 (ref)
        --  [5] v31 (ref)
        --  [6] v33 (ref)
        --  [7] placeTooltip (ref)
        --  [8] arg21 (copy)
        --  [9] arg22 (copy)

        if v32 == arg20 then
            if arg20.Parent then
                if not isOnScreen(arg20) then
                    v32 = nil
                    v30.Visible = false
                    v31.Visible = false

                    if v33 then
                        v33:Disconnect()
                        v33 = nil
                    end

                    return
                end

                placeTooltip(arg21, arg20, arg22)

                return
            else
                v32 = nil
                v30.Visible = false
                v31.Visible = false

                if v33 then
                    v33:Disconnect()
                    v33 = nil
                end

                return
            end
        else
            v32 = nil
            v30.Visible = false
            v31.Visible = false

            if v33 then
                v33:Disconnect()
                v33 = nil
            end

            return
        end
    end)
end

local function hookTooltip(arg23, arg24, arg25) -- line: 294
    -- upvalues:
    --  [1] v32 (ref)
    --  [2] v30 (copy)
    --  [3] v31 (copy)
    --  [4] v33 (ref)
    --  [5] placeTooltip (copy)
    --  [6] RunService (copy)
    --  [7] isOnScreen (copy)

    arg23.MouseEnter:Connect(function() -- line: 295
        -- upvalues:
        --  [1] arg23 (copy)
        --  [2] arg24 (copy)
        --  [3] v32 (ref)
        --  [4] v30 (ref)
        --  [5] v31 (ref)
        --  [6] v33 (ref)
        --  [7] placeTooltip (ref)
        --  [8] RunService (ref)
        --  [9] isOnScreen (ref)

        local v42 = arg23
        local v43 = arg24()
        v32 = nil
        v30.Visible = false
        v31.Visible = false

        if v33 then
            v33:Disconnect()
            v33 = nil
        end

        v32 = v42
        placeTooltip(v43, v42, true)
        v43.Visible = true
        local v44 = true
        v33 = RunService.RenderStepped:Connect(function() -- line: 282
            -- upvalues:
            --  [1] v32 (ref)
            --  [2] v42 (copy)
            --  [3] isOnScreen (ref)
            --  [4] v30 (ref)
            --  [5] v31 (ref)
            --  [6] v33 (ref)
            --  [7] placeTooltip (ref)
            --  [8] v43 (copy)
            --  [9] v44 (copy)

            if v32 == v42 then
                if v42.Parent then
                    if not isOnScreen(v42) then
                        v32 = nil
                        v30.Visible = false
                        v31.Visible = false

                        if v33 then
                            v33:Disconnect()
                            v33 = nil
                        end

                        return
                    end

                    placeTooltip(v43, v42, v44)

                    return
                else
                    v32 = nil
                    v30.Visible = false
                    v31.Visible = false

                    if v33 then
                        v33:Disconnect()
                        v33 = nil
                    end

                    return
                end
            else
                v32 = nil
                v30.Visible = false
                v31.Visible = false

                if v33 then
                    v33:Disconnect()
                    v33 = nil
                end

                return
            end
        end)
    end)
    arg23.MouseLeave:Connect(function() -- line: 299
        -- upvalues:
        --  [1] v32 (ref)
        --  [2] arg23 (copy)
        --  [3] v30 (ref)
        --  [4] v31 (ref)
        --  [5] v33 (ref)

        if v32 == arg23 then
            v32 = nil
            v30.Visible = false
            v31.Visible = false

            if v33 then
                v33:Disconnect()
                v33 = nil
            end
        end
    end)
    arg23.InputBegan:Connect(function(input) -- line: 306
        -- upvalues:
        --  [1] arg23 (copy)
        --  [2] arg24 (copy)
        --  [3] v32 (ref)
        --  [4] v30 (ref)
        --  [5] v31 (ref)
        --  [6] v33 (ref)
        --  [7] placeTooltip (ref)
        --  [8] RunService (ref)
        --  [9] isOnScreen (ref)
        --  [10] arg25 (copy)

        if input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        local v45 = arg23
        local v46 = arg24()
        v32 = nil
        v30.Visible = false
        v31.Visible = false

        if v33 then
            v33:Disconnect()
            v33 = nil
        end

        v32 = v45
        placeTooltip(v46, v45, false)
        v46.Visible = true
        local v47 = false
        v33 = RunService.RenderStepped:Connect(function() -- line: 282
            -- upvalues:
            --  [1] v32 (ref)
            --  [2] v45 (copy)
            --  [3] isOnScreen (ref)
            --  [4] v30 (ref)
            --  [5] v31 (ref)
            --  [6] v33 (ref)
            --  [7] placeTooltip (ref)
            --  [8] v46 (copy)
            --  [9] v47 (copy)

            if v32 == v45 then
                if v45.Parent then
                    if not isOnScreen(v45) then
                        v32 = nil
                        v30.Visible = false
                        v31.Visible = false

                        if v33 then
                            v33:Disconnect()
                            v33 = nil
                        end

                        return
                    end

                    placeTooltip(v46, v45, v47)

                    return
                else
                    v32 = nil
                    v30.Visible = false
                    v31.Visible = false

                    if v33 then
                        v33:Disconnect()
                        v33 = nil
                    end

                    return
                end
            else
                v32 = nil
                v30.Visible = false
                v31.Visible = false

                if v33 then
                    v33:Disconnect()
                    v33 = nil
                end

                return
            end
        end)
        task.delay(arg25, function() -- line: 313
            -- upvalues:
            --  [1] v32 (ref)
            --  [2] arg23 (ref)
            --  [3] v30 (ref)
            --  [4] v31 (ref)
            --  [5] v33 (ref)

            if v32 == arg23 then
                v32 = nil
                v30.Visible = false
                v31.Visible = false

                if v33 then
                    v33:Disconnect()
                    v33 = nil
                end
            end
        end)
    end)
end

local _ = function(arg27, arg28) --[[ hookDropTooltip ]] -- line: 322
    -- upvalues:
    --  [1] hookTooltip (copy)
    --  [2] v30 (copy)

    if typeof(arg28) ~= "number" then
        return
    end

    local v48 = arg28 * 100
    local v49 = if not (v48 >= 99.95) then if not (v48 >= 10) then if not (v48 >= 0.1) then if not (v48 > 0) then "0%" else "<0.1%" else string.format(
        "%.1f%%",
        v48
    ) else string.format("%.0f%%", v48) else "100%"
    local v50 = `Drop chance: {v49}`
    hookTooltip(arg27, function() -- line: 329
        -- upvalues:
        --  [1] v30 (ref)
        --  [2] v50 (copy)

        v30.Text = v50

        return v30
    end, 2.5)
end

local _ = function(arg29) --[[ usesChest ]] -- line: 337
    -- upvalues:
    --  [1] BeastIndexData (copy)

    local v51 = BeastIndexData:FindFirstChild(arg29)
    local v52 = v51

    if v52 then
        v52 = v51:GetAttribute("Chest")
    end

    return v52 == true
end

local function getChestContents(arg30) -- line: 342
    -- upvalues:
    --  [1] BeastIndexData (copy)

    local t_8 = {}
    local v54 = BeastIndexData:FindFirstChild(arg30)
    local v55 = v54

    if v55 then
        v55 = v54:FindFirstChild("Drops")
    end

    if v55 then
        for _, child_1 in v55:GetChildren() do
            if child_1.Name ~= "Nothing" then
                table.insert(
                    t_8,
                    { Name = child_1.Name, Chance = child_1:GetAttribute("Chance") or 0 }
                )
            end
        end

        table.sort(t_8, function(arg31, arg32) -- line: 353
            return if arg31.Chance == arg32.Chance then arg31.Name < arg32.Name else arg31.Chance > arg32.Chance
        end)
    end

    return t_8
end

local function fillChestTooltip(arg33) -- line: 363
    -- upvalues:
    --  [1] t_7 (copy)
    --  [2] getChestContents (copy)
    --  [3] ChestDropRow (copy)
    --  [4] v31 (copy)

    for _, val_4 in t_7 do
        val_4:Destroy()
    end

    table.clear(t_7)

    for key_7, val_5 in getChestContents(arg33) do
        local v56 = ChestDropRow:Clone()
        v56.Name = val_5.Name
        v56.ItemName.Text = val_5.Name
        local v57 = val_5.Chance * 100
        v56.Chance.Text = if v57 >= 99.95 then "100%" else if not (v57 >= 10) then if not (v57 >= 0.1) then if not (v57 > 0) then "0%" else "<0.1%" else string.format(
            "%.1f%%",
            v57
        ) else string.format("%.0f%%", v57)
        v56.LayoutOrder = key_7
        v56.Parent = v31
        table.insert(t_7, v56)
    end

    return v31
end

local function clearDrops() -- line: 382
    -- upvalues:
    --  [1] v32 (ref)
    --  [2] v30 (copy)
    --  [3] v31 (copy)
    --  [4] v33 (ref)
    --  [5] t_1 (copy)
    --  [6] ViewportHandle_m (copy)
    --  [7] t_2 (copy)

    v32 = nil
    v30.Visible = false
    v31.Visible = false

    if v33 then
        v33:Disconnect()
        v33 = nil
    end

    for _, val_6 in t_1 do
        ViewportHandle_m:Destroy(val_6)
    end

    for _, val_7 in t_2 do
        val_7:Destroy()
    end

    table.clear(t_1)
    table.clear(t_2)
end

local _ = function(arg34, arg35, arg36) --[[ addDropTile ]] -- line: 396
    -- upvalues:
    --  [1] Item (copy)
    --  [2] List_2 (copy)
    --  [3] t_2 (copy)
    --  [4] ViewportHandle_m (copy)
    --  [5] t_1 (copy)

    local v59 = Item:Clone()
    v59.Name = arg35
    v59.ItemName.Text = arg35
    v59.LayoutOrder = arg34
    v59.Parent = List_2
    table.insert(t_2, v59)
    local v60 = ViewportHandle_m.new(arg36, v59.PortFrame)

    if v60 then
        table.insert(t_1, v60)
    end

    return v59
end

local function showDrops(arg37) -- line: 412
    -- upvalues:
    --  [1] clearDrops (copy)
    --  [2] BeastIndexData (copy)
    --  [3] BeastDefinitions_m (copy)
    --  [4] Item (copy)
    --  [5] List_2 (copy)
    --  [6] t_2 (copy)
    --  [7] ViewportHandle_m (copy)
    --  [8] t_1 (copy)
    --  [9] hookTooltip (copy)
    --  [10] fillChestTooltip (copy)
    --  [11] getDrops (copy)
    --  [12] v30 (copy)

    clearDrops()
    local v61 = BeastIndexData:FindFirstChild(arg37)
    local v62 = v61

    if v62 then
        v62 = v61:GetAttribute("Chest")
    end

    if if v62 ~= true then false else true then
        local v64 = BeastDefinitions_m[arg37].ChestIcon or "Chest I"
        local v65 = Item:Clone()
        v65.Name = "Chest"
        v65.ItemName.Text = "Chest"
        v65.LayoutOrder = 1
        v65.Parent = List_2
        table.insert(t_2, v65)
        local v66 = ViewportHandle_m.new(v64, v65.PortFrame)

        if v66 then
            table.insert(t_1, v66)
        end

        hookTooltip(v65, function() -- line: 420
            -- upvalues:
            --  [1] fillChestTooltip (ref)
            --  [2] arg37 (copy)

            return (fillChestTooltip(arg37))
        end, 6)

        return
    end

    for key_10, val_8 in getDrops(arg37) do
        local v67 = Item:Clone()
        v67.Name = val_8
        v67.ItemName.Text = val_8
        v67.LayoutOrder = key_10
        v67.Parent = List_2
        table.insert(t_2, v67)
        local v68 = ViewportHandle_m.new(val_8, v67.PortFrame)

        if v68 then
            table.insert(t_1, v68)
        end

        local v69 = BeastIndexData:FindFirstChild(arg37)
        local v70 = v69

        if v70 then
            v70 = v69:FindFirstChild("Drops")
        end

        v69 = v70

        if v69 then
            v69 = v70:FindFirstChild(val_8)
        end

        v68 = v69

        if v68 then
            v68 = v69:GetAttribute("Chance")
        end

        if typeof(v68) == "number" then
            local v71 = v68 * 100
            local v72 = if not (v71 >= 99.95) then if not (v71 >= 10) then if not (v71 >= 0.1) then if not (v71 > 0) then "0%" else "<0.1%" else string.format(
                "%.1f%%",
                v71
            ) else string.format("%.0f%%", v71) else "100%"
            local v73 = `Drop chance: {v72}`
            hookTooltip(v67, function() -- line: 329
                -- upvalues:
                --  [1] v30 (ref)
                --  [2] v73 (copy)

                v30.Text = v73

                return v30
            end, 2.5)
        end
    end
end

local function updateAchievement(arg38) -- line: 434
    -- upvalues:
    --  [1] BeastDefinitions_m (copy)
    --  [2] BeastIndex (copy)
    --  [3] Info_1 (copy)
    --  [4] Label_4 (copy)
    --  [5] Percent (copy)
    --  [6] Front (copy)
    --  [7] Claim (copy)
    --  [8] Claimed (copy)

    local v74 = BeastDefinitions_m[arg38]
    local MilestoneKills = v74.MilestoneKills
    local v75 = math.min(BeastIndex:GetAttribute(arg38) or 0, MilestoneKills)
    Info_1.Text = `Defeat this enemy {MilestoneKills} times`
    Label_4.Text = `+{v74.MilestoneReward}\nLocked\nEssence`
    Percent.Text = `{v75}/{MilestoneKills}`
    Front.Size = UDim2.fromScale(v75 / MilestoneKills, 1)
    local v80 = Claim
    local v82 = not (if Claimed:GetAttribute(arg38) ~= true then false else true)

    if v82 then
        v82 = (BeastIndex:GetAttribute(arg38) or 0) >= BeastDefinitions_m[arg38].MilestoneKills and true
    end

    v80.Visible = v82
end

local _ = function(arg39) --[[ refreshPage ]] -- line: 448
    -- upvalues:
    --  [1] Label_1 (copy)
    --  [2] BeastIndex (copy)
    --  [3] updateAchievement (copy)

    Label_1.Text = BeastIndex:GetAttribute(arg39) or 0
    updateAchievement(arg39)
end

local color = Color3.new(0, 0, 0)
local color_1 = Color3.new(1, 1, 1)

local function updateEntry(arg40) -- line: 458
    -- upvalues:
    --  [1] t (copy)
    --  [2] BeastIndex (copy)
    --  [3] color_1 (copy)
    --  [4] color (copy)
    --  [5] BeastDefinitions_m (copy)
    --  [6] t_3 (copy)
    --  [7] Claimed (copy)

    local v84 = t[arg40]

    if not v84 then
        return
    end

    local v85 = (BeastIndex:GetAttribute(arg40) or 0) > 0 and true
    local v86 = v85 and color_1 or color
    v84.EnemyIcon.ImageColor3 = v86
    v86 = v85 and BeastDefinitions_m[arg40].DisplayName or ""
    v84.Info.Title.Text = v86
    v84.Info.KillLabel.Text = `Kills: {BeastIndex:GetAttribute(arg40) or 0}`
    v86 = v85
    local New_1 = v84.New

    if v86 then
        v86 = true

        if t_3[arg40] ~= true then
            v86 = not (if Claimed:GetAttribute(arg40) ~= true then false else true)

            if v86 then
                v86 = (BeastIndex:GetAttribute(arg40) or 0) >= BeastDefinitions_m[arg40].MilestoneKills and true
            end
        end
    end

    New_1.Visible = v86
end

local _ = function(arg41) --[[ normalize ]] -- line: 476
    return string.lower((string.gsub(arg41, "%s+", " ")))
end

local function matchesSearch(arg42, arg43) -- line: 480
    -- upvalues:
    --  [1] BeastIndex (copy)
    --  [2] BeastDefinitions_m (copy)
    --  [3] getChestContents (copy)

    if arg43 == "" then
        return true
    end

    if not (if not ((BeastIndex:GetAttribute(arg42) or 0) > 0) then false else true) then
        return false
    end

    if string.find(
        string.lower((string.gsub(BeastDefinitions_m[arg42].DisplayName, "%s+", " "))),
        arg43,
        1,
        true
    ) then
        return true
    end

    for _, val_9 in getChestContents(arg42) do
        if string.find(string.lower((string.gsub(val_9.Name, "%s+", " "))), arg43, 1, true) then
            return true
        end
    end

    return false
end

local function applySearch() -- line: 503
    -- upvalues:
    --  [1] Box (copy)
    --  [2] t (copy)
    --  [3] matchesSearch (copy)
    --  [4] NoResults (copy)
    --  [5] List (copy)

    local v89 = string.match(string.lower((string.gsub(Box.Text, "%s+", " "))), "^%s*(.-)%s*$")
    local v90 = 0

    for key_12, val_10 in t do
        local v91 = matchesSearch(key_12, v89)
        val_10.Visible = v91

        if v91 then
            v90 += 1
        end
    end

    NoResults.Visible = if v90 ~= 0 then false else next(t) ~= nil
    List.CanvasPosition = Vector2.zero
end

Box:GetPropertyChangedSignal("Text"):Connect(applySearch)

local function showBeast(arg44) -- line: 522
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] t (copy)
    --  [3] BeastDefinitions_m (copy)
    --  [4] EnemyImage (copy)
    --  [5] Title (copy)
    --  [6] Description (copy)
    --  [7] BeastIndexData (copy)
    --  [8] Label_2 (copy)
    --  [9] Label_3 (copy)
    --  [10] Label_1 (copy)
    --  [11] BeastIndex (copy)
    --  [12] updateAchievement (copy)
    --  [13] showDrops (copy)
    --  [14] List_1 (copy)
    --  [15] t_3 (copy)
    --  [16] updateEntry (copy)
    --  [17] t_4 (copy)
    --  [18] Claimed (copy)
    --  [19] New (copy)

    local v93 = v4
    local v94 = v93 and t[v93]
    local v95 = v94

    if v95 then
        v95 = v94:FindFirstChild("Selected")
    end

    if v95 then
        v95.Visible = false
    end

    v4 = arg44
    v93 = arg44 and t[arg44]
    v94 = v93

    if v94 then
        v94 = v93:FindFirstChild("Selected")
    end

    if v94 then
        v94.Visible = true
    end

    v93 = BeastDefinitions_m[arg44]
    EnemyImage.Image = v93.BackgroundImage
    Title.Text = v93.DisplayName
    Description.Text = v93.Description
    local v96 = BeastIndexData:FindFirstChild(arg44)
    v93 = v96

    if v93 then
        v93 = v96:GetAttribute("Health")
    end

    local v97 = BeastIndexData:FindFirstChild(arg44)
    v96 = v97

    if v96 then
        v96 = v97:GetAttribute("XP")
    end

    local v98 = Label_2
    v98.Text = v93 and math.floor(v93) or "?"
    local v100 = Label_3
    v100.Text = v96 and math.floor(v96) or "?"
    Label_1.Text = BeastIndex:GetAttribute(arg44) or 0
    updateAchievement(arg44)
    showDrops(arg44)
    List_1.CanvasPosition = Vector2.zero
    List_1.Visible = true
    t_3[arg44] = nil
    updateEntry(arg44)
    v96 = false

    for _, val_11 in t_4 do
        local v102 = true

        if t_3[val_11] ~= true then
            v102 = not (if Claimed:GetAttribute(val_11) ~= true then false else true)

            if v102 then
                v102 = (BeastIndex:GetAttribute(val_11) or 0) >= BeastDefinitions_m[val_11].MilestoneKills and true
            end
        end

        if v102 then
            v96 = true
            break
        end
    end

    New.Visible = v96
end

local function createEntry(arg45) -- line: 551
    -- upvalues:
    --  [1] BeastDefinitions_m (copy)
    --  [2] Entry (copy)
    --  [3] t_5 (copy)
    --  [4] BeastIndex (copy)
    --  [5] showBeast (copy)
    --  [6] t (copy)
    --  [7] v4 (ref)
    --  [8] updateEntry (copy)
    --  [9] List (copy)
    --  [10] applySearch (copy)

    local v104 = BeastDefinitions_m[arg45]
    local v105 = Entry:Clone()
    local _ = v105.Info
    v105.Name = arg45
    v105.LayoutOrder = t_5[arg45]
    v105.EnemyIcon.Image = v104.IconImage
    v105.MouseButton1Up:Connect(function() -- line: 561
        -- upvalues:
        --  [1] arg45 (copy)
        --  [2] BeastIndex (ref)
        --  [3] showBeast (ref)

        if if not ((BeastIndex:GetAttribute(arg45) or 0) > 0) then false else true then
            showBeast(arg45)
        end
    end)
    local BackgroundColor3 = v105.BackgroundColor3
    local v107 = BackgroundColor3:Lerp(Color3.new(1, 1, 1), 0.08)
    v105.MouseEnter:Connect(function() -- line: 569
        -- upvalues:
        --  [1] v105 (copy)
        --  [2] v107 (copy)

        v105.BackgroundColor3 = v107
    end)
    v105.MouseLeave:Connect(function() -- line: 572
        -- upvalues:
        --  [1] v105 (copy)
        --  [2] BackgroundColor3 (copy)

        v105.BackgroundColor3 = BackgroundColor3
    end)
    t[arg45] = v105
    local v108 = if v4 ~= arg45 then false else true
    local v109 = arg45 and t[arg45]
    local v110 = v109

    if v110 then
        v110 = v109:FindFirstChild("Selected")
    end

    if v110 then
        v110.Visible = v108
    end

    updateEntry(arg45)
    v105.Parent = List
    applySearch()
end

local t_10 = {}

for _, val_12 in t_4 do
    local v111 = val_12
    t_10[val_12] = (BeastIndex:GetAttribute(v111) or 0) > 0 and true
    createEntry(val_12)
end

Claim.MouseButton1Up:Connect(function() -- line: 591
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] Claimed (copy)
    --  [3] BeastIndex (copy)
    --  [4] BeastDefinitions_m (copy)
    --  [5] Claim (copy)
    --  [6] ClaimBeastReward (copy)

    if v4 then
        local v113 = v4
        local v115 = not (if Claimed:GetAttribute(v113) ~= true then false else true)

        if v115 then
            v115 = (BeastIndex:GetAttribute(v113) or 0) >= BeastDefinitions_m[v113].MilestoneKills and true
        end

        if v115 then
            Claim.Visible = false
            ClaimBeastReward:FireServer(v4)
        end
    end
end)
BeastIndex.AttributeChanged:Connect(function(attribute) -- line: 599
    -- upvalues:
    --  [1] BeastDefinitions_m (copy)
    --  [2] t_10 (copy)
    --  [3] BeastIndex (copy)
    --  [4] t_3 (copy)
    --  [5] updateEntry (copy)
    --  [6] applySearch (copy)
    --  [7] ReplicatedStorage (copy)
    --  [8] updateAmount (copy)
    --  [9] t_4 (copy)
    --  [10] Claimed (copy)
    --  [11] New (copy)
    --  [12] v4 (ref)
    --  [13] Label_1 (copy)
    --  [14] updateAchievement (copy)

    if not BeastDefinitions_m[attribute] then
        return
    end

    if not t_10[attribute] then
        if if not ((BeastIndex:GetAttribute(attribute) or 0) > 0) then false else true then
            t_10[attribute] = true
            t_3[attribute] = true
            updateEntry(attribute)
            applySearch()
            _G.CreateSignificantAlert(
                `New Bestiary Index: {BeastDefinitions_m[attribute].DisplayName}`,
                ReplicatedStorage.SFX.Misc.BeastAlert
            )
        else
            updateEntry(attribute)
        end
    else
        updateEntry(attribute)
    end

    updateAmount()
    local v118 = false

    for _, val_13 in t_4 do
        local v119 = true

        if t_3[val_13] ~= true then
            v119 = not (if Claimed:GetAttribute(val_13) ~= true then false else true)

            if v119 then
                v119 = (BeastIndex:GetAttribute(val_13) or 0) >= BeastDefinitions_m[val_13].MilestoneKills and true
            end
        end

        if v119 then
            v118 = true
            break
        end
    end

    New.Visible = v118

    if v4 == attribute then
        Label_1.Text = BeastIndex:GetAttribute(attribute) or 0
        updateAchievement(attribute)
    end
end)
Claimed.AttributeChanged:Connect(function(attribute_1) -- line: 624
    -- upvalues:
    --  [1] BeastDefinitions_m (copy)
    --  [2] updateEntry (copy)
    --  [3] t_4 (copy)
    --  [4] t_3 (copy)
    --  [5] Claimed (copy)
    --  [6] BeastIndex (copy)
    --  [7] New (copy)
    --  [8] v4 (ref)
    --  [9] Label_1 (copy)
    --  [10] updateAchievement (copy)

    if not BeastDefinitions_m[attribute_1] then
        return
    end

    updateEntry(attribute_1)
    local v122 = false

    for _, val_14 in t_4 do
        local v123 = true

        if t_3[val_14] ~= true then
            v123 = not (if Claimed:GetAttribute(val_14) ~= true then false else true)

            if v123 then
                v123 = (BeastIndex:GetAttribute(val_14) or 0) >= BeastDefinitions_m[val_14].MilestoneKills and true
            end
        end

        if v123 then
            v122 = true
            break
        end
    end

    New.Visible = v122

    if v4 == attribute_1 then
        Label_1.Text = BeastIndex:GetAttribute(attribute_1) or 0
        updateAchievement(attribute_1)
    end
end)
local ArrowLeft = Title.ArrowLeft
local ArrowRight = Title.ArrowRight

local function layoutTitleArrows() -- line: 648
    -- upvalues:
    --  [1] Title (copy)
    --  [2] ArrowLeft (copy)
    --  [3] ArrowRight (copy)

    local v126 = math.floor((Title.AbsoluteSize.X - Title.TextBounds.X) / 2 - 8 - 6)
    local v127 = math.min(v126, 80)
    local v128 = v127 >= 28 and true

    for _, val_15 in { ArrowLeft, ArrowRight } do
        val_15.Visible = v128

        if v128 then
            val_15.Size = UDim2.new(0, v127, val_15.Size.Y.Scale, val_15.Size.Y.Offset)
        end
    end
end

Title:GetPropertyChangedSignal("TextBounds"):Connect(layoutTitleArrows)
Title:GetPropertyChangedSignal("AbsoluteSize"):Connect(layoutTitleArrows)
layoutTitleArrows()
local v129
List_1.Visible, v129 = false, updateAmount
v129()
layoutTitleArrows = false

for _, val_16 in t_4 do
    local v130 = true

    if t_3[val_16] ~= true then
        v130 = not (if Claimed:GetAttribute(val_16) ~= true then false else true)

        if v130 then
            v130 = (BeastIndex:GetAttribute(val_16) or 0) >= BeastDefinitions_m[val_16].MilestoneKills and true
        end
    end

    local _ = BeastIndex:GetAttribute(val_16) or 0
    local _ = BeastDefinitions_m[val_16].MilestoneKills

    if v130 then
        layoutTitleArrows = true
        break
    end
end

New.Visible = layoutTitleArrows
