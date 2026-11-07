-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Backpack.BackpackClient
-- Class: LocalScript
-- bytes: 70025

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local Modules = ReplicatedStorage.Modules
local _ = require(Modules.ByteNetMax)
local Packets_m = require(Modules.Packets)
local _ = require(Modules.Basic)
local ViewportHandle_m = require(Modules.ViewportHandle)
local Items_m = require(Modules.Items)
local Skills_m = require(Modules.Skills)
local StateManager_m = require(Modules.StateManager)
local Slider_m = require(Modules.Slider)
local v2 = require(Modules.CreateBindableAction)
local GamepadLayer_m = require(Modules.GamepadLayer)
local PadBinds_m = require(Modules.PadBinds)
local Formatter_m = require(Modules.Formatter)
local StatManager_m = require(Modules.StatManager)
local Weight_m = require(Modules.Weight)
local GrimoireRarity_m = require(Modules.GrimoireRarity)
local HalloweenWeapons_m = require(Modules.HalloweenWeapons)
local v3, v4 = require(Modules.scriptObjs).GetPlayerCharacter()
local v5 = StateManager_m.require(v4)
local v6 = StatManager_m.require(v3)
local Binds = v3:WaitForChild("Binds")
local Bin = v3:WaitForChild("bin")
local States = v4:WaitForChild("States")
local Inventory = v3:WaitForChild("Inventory")
local _ = v4.PrimaryPart
local Humanoid = v4:WaitForChild("Humanoid")
local v7 = script.Parent:FindFirstChild("Toolbar")

if v7 then
    v7 = script.Parent.Toolbar:FindFirstChild("PadLegend")
end

if v7 then
    v7.Visible = false
end

while true do
    if CollectionService:HasTag(v4, "BPLoaded") then
        break
    end

    CollectionService:GetInstanceAddedSignal("BPLoaded"):Wait()
end

local mouse = v3:GetMouse()
local PlayerGui = v3:WaitForChild("PlayerGui")
local Gameplay = PlayerGui:WaitForChild("Gameplay")
local Menu = Gameplay.Main.Menu
local Backpack = v3:WaitForChild("Backpack")
local _ = Services_m.Maid.new()
local Parent = script.Parent
local v9 = Gameplay.Main.Menu.Inventory
local Order = Parent.Toolbar.Order
local Objects = PlayerGui:WaitForChild(".objects")
local Slots = v9.Slots
local v10 = require(Modules.UI.InventoryFilterSort).new(v9)
local t = {}
local BackpackUtils_m = require(Modules.BackpackUtils)
local Categories = BackpackUtils_m.Categories
local Keys = BackpackUtils_m._keys
local t_1 = {}
local t_2 = {}
local t_3 = {}
local v11 = nil
local v12 = false

local _ = function(arg1) --[[ findTemplate ]] -- line: 95
    -- upvalues:
    --  [1] t_1 (copy)

    for key, val in t_1 do
        if key.Name == arg1 then
            return val
        end
    end

    return nil
end

local _ = function(arg2) --[[ getSlotStock ]] -- line: 105
    return arg2:GetAttribute("Stock") or 1
end

local _ = function(arg3) --[[ isSlotEquipped ]] -- line: 109
    local Equipped = arg3:FindFirstChild("Equipped")
    local Vanity = arg3:FindFirstChild("Vanity")

    return Equipped and Equipped.Visible or (Vanity and Vanity.Visible or false)
end

local function parseStats(arg4) -- line: 116
    local t_4 = {}
    local Stats = arg4:GetAttribute("Stats")

    if type(Stats) == "string" then
        for key_1, val_1 in string.gmatch(Stats, "([%w_]+)%s+(%-?[%d%.]+)") do
            t_4[key_1] = (t_4[key_1] or 0) + (tonumber(val_1) or 0)
        end
    end

    return t_4
end

local function scoreEntries(arg5) -- line: 127
    -- upvalues:
    --  [1] Items_m (copy)
    --  [2] Formatter_m (copy)
    --  [3] parseStats (copy)

    local t_5 = {}

    for _, val_2 in arg5 do
        local v16 = Items_m:LookupItem(Formatter_m.formatItem(val_2.container.Name))
        local v17 = v16

        if v17 then
            v17 = v16.BaseDamage
        end

        val_2.baseDamage = v17

        if not val_2.baseDamage then
            val_2.stats = parseStats(val_2.container)

            for key_3, val_3 in val_2.stats do
                t_5[key_3] = math.max(t_5[key_3] or 0, val_3)
            end
        end
    end

    for _, val_4 in arg5 do
        if val_4.baseDamage then
            val_4.score = val_4.baseDamage
        else
            local v18 = 0

            for key_5, val_5 in val_4.stats do
                v18 += val_5 / math.max(t_5[key_5] or 1, 1)
            end

            val_4.score = v18
        end
    end
end

local function byName(arg6, arg7) -- line: 153
    return arg6.name < arg7.name
end

local t_6 = {
    NameAsc = byName,
    NameDesc = function(arg8, arg9) --[[ NameDesc ]] -- line: 159
        return arg8.name > arg9.name
    end,
    Stars = function(arg10, arg11) --[[ Stars ]] -- line: 162
        return if arg10.stars == arg11.stars then arg10.name < arg11.name else arg10.stars > arg11.stars
    end,
    Best = function(arg12, arg13) --[[ Best ]] -- line: 168
        return if arg12.score == arg13.score then if arg12.stars == arg13.stars then arg12.name < arg13.name else arg12.stars > arg13.stars else arg12.score > arg13.score
    end,
    QuantityDesc = function(arg14, arg15) --[[ QuantityDesc ]] -- line: 177
        return if arg14.stock == arg15.stock then arg14.name < arg15.name else arg14.stock > arg15.stock
    end,
    QuantityAsc = function(arg16, arg17) --[[ QuantityAsc ]] -- line: 183
        return if arg16.stock == arg17.stock then arg16.name < arg17.name else arg16.stock < arg17.stock
    end
}

local function ApplySort() -- line: 191
    -- upvalues:
    --  [1] v10 (copy)
    --  [2] t_6 (copy)
    --  [3] byName (copy)
    --  [4] t_1 (copy)
    --  [5] scoreEntries (copy)

    local SortMode = v10.SortMode
    local v21 = t_6[SortMode] or byName
    local v22 = SortMode == "Best"
    local t_7 = {}

    for key_6, val_6 in t_1 do
        local t_8 = {
            container = key_6,
            template = val_6,
            name = string.lower(val_6.Label.Text),
            stock = key_6:GetAttribute("Stock") or 1,
            stars = key_6:GetAttribute("Quality") or 0,
            score = 0,
            equipped = nil
        }
        local Equipped_1 = val_6:FindFirstChild("Equipped")
        local Vanity_1 = val_6:FindFirstChild("Vanity")
        t_8.equipped = Equipped_1 and Equipped_1.Visible or (Vanity_1 and Vanity_1.Visible or false)
        table.insert(t_7, t_8)
    end

    if v22 then
        scoreEntries(t_7)
    end

    table.sort(t_7, function(arg18, arg19) -- line: 213
        -- upvalues:
        --  [1] v21 (copy)

        if arg18.equipped ~= arg19.equipped then
            return arg18.equipped
        end

        return v21(arg18, arg19)
    end)

    for key_7, val_7 in t_7 do
        val_7.template.LayoutOrder = key_7
    end
end

local v24 = false

local _ = function() --[[ ScheduleSort ]] -- line: 226
    -- upvalues:
    --  [1] v24 (ref)
    --  [2] ApplySort (copy)

    if v24 then
        return
    end

    v24 = true
    task.defer(function() -- line: 231
        -- upvalues:
        --  [1] v24 (ref)
        --  [2] ApplySort (ref)

        v24 = false
        ApplySort()
    end)
end

local t_9 = {}
v10.Changed:Connect(function(arg20) -- line: 237
    -- upvalues:
    --  [1] v24 (ref)
    --  [2] ApplySort (copy)
    --  [3] t (copy)

    if arg20 == "Sort" then
        if v24 then
            return
        end

        v24 = true
        task.defer(function() -- line: 231
            -- upvalues:
            --  [1] v24 (ref)
            --  [2] ApplySort (ref)

            v24 = false
            ApplySort()
        end)

        return
    else
        if arg20 == "Filter" then
            for _, val_8 in t do
                val_8()
            end
        end

        return
    end
end)
local t_10 = {
    Armor = {
        Field = "ArmorType",
        Order = { Helmet = 1, Face = 2, Neck = 3, Chest = 4, Back = 5, Legs = 6 },
        Labels = { Helmet = "Helmets" },
        Fallback = "Other"
    },
    Weapon = {
        Field = "MasteryType",
        Order = { Heavy = 1, Medium = 2, Light = 3 },
        Labels = {},
        Fallback = "Other"
    }
}
local color = Color3.fromRGB(215, 215, 222)
local font = Font.new("rbxasset://fonts/families/Balthazar.json")
local t_13 = {}

local function CreateContents(arg21, arg22) -- line: 267
    -- upvalues:
    --  [1] t_9 (copy)
    --  [2] t_10 (copy)
    --  [3] v10 (copy)
    --  [4] t (copy)
    --  [5] Services_m (copy)
    --  [6] t_13 (copy)
    --  [7] Slots (copy)

    if not t_9[arg21] then
        local v25 = script.TemplateContents:Clone()
        v25.Name = arg21
        v25.LayoutOrder = arg22
        local v26 = script.Header:Clone()
        v26.Label.Text = arg21
        v26.Parent = v25
        local Items = v25.Items
        local UIGridLayout = Items:FindFirstChildWhichIsA("UIGridLayout")

        if UIGridLayout then
            UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
        end

        local v27 = t_10[arg21]
        local v28 = nil

        if v27 then
            v28 = Items:Clone()

            if UIGridLayout then
                UIGridLayout:Destroy()
            end

            local New = Instance.new("UIListLayout")
            New.SortOrder = Enum.SortOrder.LayoutOrder
            New.Padding = UDim.new(0, 6)
            New.Parent = Items
        end

        local v30 = 0

        t[arg21] = function() --[[ handleVisible ]] -- line: 301
            -- upvalues:
            --  [1] v25 (copy)
            --  [2] v30 (ref)
            --  [3] v10 (ref)
            --  [4] arg21 (copy)
            --  [5] v26 (copy)

            local v31 = false
            local v32 = v25

            if v30 > 0 then
                v31 = v10:IsCategoryShown(arg21)
            end

            v32.Visible = v31
            v26.Count.Text = "(" .. v30 .. ")"
        end

        v10:AddCategory(arg21, arg22)
        v25.Visible = if v30 > 0 then v10:IsCategoryShown(arg21) else false
        v26.Count.Text = "(" .. v30 .. ")"
        local v34 = Services_m.Maid.new()

        local function watchList(arg23, arg24) -- line: 313
            -- upvalues:
            --  [1] v34 (copy)
            --  [2] v30 (ref)
            --  [3] v25 (copy)
            --  [4] v10 (ref)
            --  [5] arg21 (copy)
            --  [6] v26 (copy)

            v34:GiveTask(arg23.ChildAdded:Connect(function(child) -- line: 314
                -- upvalues:
                --  [1] v30 (ref)
                --  [2] v25 (ref)
                --  [3] v10 (ref)
                --  [4] arg21 (ref)
                --  [5] v26 (ref)
                --  [6] arg24 (copy)

                if not child:IsA("GuiObject") then
                    return
                end

                v30 += 1
                local v35 = false
                local v36 = v25

                if v30 > 0 then
                    v35 = v10:IsCategoryShown(arg21)
                end

                v36.Visible = v35
                v26.Count.Text = "(" .. v30 .. ")"

                if arg24 then
                    arg24(1)
                end
            end))
            v34:GiveTask(arg23.ChildRemoved:Connect(function(child_1) -- line: 320
                -- upvalues:
                --  [1] v30 (ref)
                --  [2] v25 (ref)
                --  [3] v10 (ref)
                --  [4] arg21 (ref)
                --  [5] v26 (ref)
                --  [6] arg24 (copy)

                if not child_1:IsA("GuiObject") then
                    return
                end

                v30 -= 1
                local v38 = false
                local v39 = v25

                if v30 > 0 then
                    v38 = v10:IsCategoryShown(arg21)
                end

                v39.Visible = v38
                v26.Count.Text = "(" .. v30 .. ")"

                if arg24 then
                    arg24(-1)
                end
            end))
        end

        if not v27 then
            watchList(Items)
        end

        t_13[arg21] = {
            Holder = v25,
            Items = Items,
            Sub = v27,
            SubTemplate = v28,
            Subs = {},
            Watch = watchList,
            Maid = v34
        }
        v34:GiveTask(v26.Label.MouseEnter:Connect(function() -- line: 342
            -- upvalues:
            --  [1] v26 (copy)

            v26.Label.TextTransparency = 0.4
        end))
        v34:GiveTask(v26.Label.MouseLeave:Connect(function() -- line: 345
            -- upvalues:
            --  [1] v26 (copy)

            v26.Label.TextTransparency = 0
        end))
        v34:GiveTask(v26.Label.Activated:Connect(function() -- line: 348
            -- upvalues:
            --  [1] Items (copy)

            Items.Visible = not Items.Visible
        end))
        v25.Parent = Slots
        v34.Holder = v25
        t_9[arg21] = v25
    end

    return t_9[arg21]
end

local function CreateSubSection(arg27, arg28) -- line: 361
    -- upvalues:
    --  [1] font (copy)
    --  [2] color (copy)

    local Sub = arg27.Sub
    local Frame = Instance.new("Frame")
    Frame.Name = arg28
    Frame.LayoutOrder = Sub.Order[arg28] or 99
    Frame.Size = UDim2.fromScale(1, 0)
    Frame.AutomaticSize = Enum.AutomaticSize.Y
    Frame.BackgroundTransparency = 1
    Frame.Visible = false
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 2)
    UIListLayout.Parent = Frame
    local SubHeader_TextButton = Instance.new("TextButton")
    SubHeader_TextButton.Name = "SubHeader"
    SubHeader_TextButton.LayoutOrder = 0
    SubHeader_TextButton.Size = UDim2.new(1, -6, 0, 18)
    SubHeader_TextButton.BackgroundTransparency = 1
    SubHeader_TextButton.AutoButtonColor = false
    SubHeader_TextButton.Text = ""
    SubHeader_TextButton.ZIndex = 2
    SubHeader_TextButton.Parent = Frame
    local Label_TextLabel = Instance.new("TextLabel")
    Label_TextLabel.Name = "Label"
    Label_TextLabel.Position = UDim2.fromOffset(2, 0)
    Label_TextLabel.Size = UDim2.new(1, -40, 1, 0)
    Label_TextLabel.BackgroundTransparency = 1
    Label_TextLabel.FontFace = font
    Label_TextLabel.Text = Sub.Labels[arg28] or arg28
    Label_TextLabel.TextColor3 = color
    Label_TextLabel.TextSize = 15
    Label_TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    Label_TextLabel.ZIndex = 2
    Label_TextLabel.Parent = SubHeader_TextButton
    local TextLabel_1 = Instance.new("TextLabel")
    TextLabel_1.Name = "Count"
    TextLabel_1.AnchorPoint = Vector2.new(1, 0)
    TextLabel_1.Position = UDim2.fromScale(1, 0)
    TextLabel_1.Size = UDim2.new(0, 36, 1, 0)
    TextLabel_1.BackgroundTransparency = 1
    TextLabel_1.FontFace = font
    TextLabel_1.TextColor3 = color
    TextLabel_1.TextTransparency = 0.25
    TextLabel_1.TextSize = 14
    TextLabel_1.TextXAlignment = Enum.TextXAlignment.Right
    TextLabel_1.ZIndex = 2
    TextLabel_1.Parent = SubHeader_TextButton
    local Frame_1 = Instance.new("Frame")
    Frame_1.Name = "Divide"
    Frame_1.AnchorPoint = Vector2.new(0, 1)
    Frame_1.Position = UDim2.fromScale(0, 1)
    Frame_1.Size = UDim2.new(1, 0, 0, 1)
    Frame_1.BackgroundColor3 = color
    Frame_1.BorderSizePixel = 0
    Frame_1.ZIndex = 2
    Frame_1.Parent = SubHeader_TextButton
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Transparency = NumberSequence.new(
        { NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 1) }
    )
    UIGradient.Parent = Frame_1
    local v41 = arg27.SubTemplate:Clone()
    v41.Name = "Items"
    v41.LayoutOrder = 1
    v41.Position = UDim2.new()
    v41.Size = UDim2.new(1, 0, 0, 30)
    v41.AutomaticSize = Enum.AutomaticSize.Y
    v41.Parent = Frame
    local v42 = 0

    local _ = function() --[[ refresh ]] -- line: 440
        -- upvalues:
        --  [1] Frame (copy)
        --  [2] v42 (ref)
        --  [3] TextLabel_1 (copy)

        Frame.Visible = v42 > 0
        TextLabel_1.Text = "(" .. v42 .. ")"
    end

    Frame.Visible = v42 > 0 and true
    TextLabel_1.Text = "(" .. v42 .. ")"
    arg27.Watch(v41, function(arg29) -- line: 446
        -- upvalues:
        --  [1] v42 (ref)
        --  [2] Frame (copy)
        --  [3] TextLabel_1 (copy)

        v42 += arg29
        Frame.Visible = v42 > 0
        TextLabel_1.Text = "(" .. v42 .. ")"
    end)
    arg27.Maid:GiveTask(SubHeader_TextButton.MouseEnter:Connect(function() -- line: 451
        -- upvalues:
        --  [1] Label_TextLabel (copy)

        Label_TextLabel.TextTransparency = 0.4
    end))
    arg27.Maid:GiveTask(SubHeader_TextButton.MouseLeave:Connect(function() -- line: 454
        -- upvalues:
        --  [1] Label_TextLabel (copy)

        Label_TextLabel.TextTransparency = 0
    end))
    arg27.Maid:GiveTask(SubHeader_TextButton.Activated:Connect(function() -- line: 457
        -- upvalues:
        --  [1] v41 (copy)
        --  [2] Frame_1 (copy)

        v41.Visible = not v41.Visible
        Frame_1.Visible = v41.Visible
    end))
    Frame.Parent = arg27.Items
    arg27.Subs[arg28] = v41

    return v41
end

local function GetSlotList(arg30, arg31, arg32) -- line: 468
    -- upvalues:
    --  [1] CreateContents (copy)
    --  [2] t_13 (copy)
    --  [3] CreateSubSection (copy)

    local v46 = CreateContents(arg30, arg31)
    local v47 = t_13[arg30]

    if not v47 or not v47.Sub then
        return v46.Items
    end

    v46 = arg32[v47.Sub.Field]
    v46 = if not v46 then v47.Sub.Fallback else if v47.Sub.Order[v46] then v46 else v47.Sub.Fallback

    return v47.Subs[v46] or CreateSubSection(v47, v46)
end

local Options = script.Options
local Drop = Options.Frame.Drop
local Lock = Options.Frame.Lock
local Sell = Options.Frame.Sell
local SellHalf = Options.Frame.SellHalf
local SellAll = Options.Frame.SellAll

for _, child_2 in Options.Frame:GetChildren() do
    if child_2:IsA("TextButton") then
        child_2.MouseEnter:Connect(function() -- line: 495
            -- upvalues:
            --  [1] child_2 (copy)

            child_2.TextTransparency = 0.5
        end)
        child_2.MouseLeave:Connect(function() -- line: 498
            -- upvalues:
            --  [1] child_2 (copy)

            child_2.TextTransparency = 0
        end)
    end
end

local DropUI = Parent.DropUI

local function UnHighlight() -- line: 506
    -- upvalues:
    --  [1] v11 (ref)
    --  [2] Options (copy)
    --  [3] t_1 (copy)
    --  [4] DropUI (copy)

    v11 = nil
    Options.Parent = script

    for _, val_9 in t_1 do
        if val_9:GetAttribute("Highlighted") then
            val_9:SetAttribute("Highlighted", false)
        end
    end

    DropUI.Visible = false
end

local ToggleMulti = v9.ToggleMulti
local v49 = script
local v50 = if v49:GetAttribute("SELLING") ~= true then false else true
local child_2 = if v49:GetAttribute("MULTISELL") ~= true then false else true

local function refreshSell() -- line: 533
    -- upvalues:
    --  [1] v11 (ref)
    --  [2] Options (copy)
    --  [3] t_1 (copy)
    --  [4] t_3 (copy)
    --  [5] DropUI (copy)

    v11 = nil
    Options.Parent = script

    for _, val_10 in t_1 do
        if val_10:GetAttribute("selecting") then
            val_10:SetAttribute("selecting", false)
        end
    end

    table.clear(t_3)
    DropUI.Visible = false
end

local function syncSellAttribute() -- line: 549
    -- upvalues:
    --  [1] refreshSell (copy)
    --  [2] v50 (ref)
    --  [3] v49 (copy)
    --  [4] child_2 (ref)
    --  [5] Options (copy)
    --  [6] ToggleMulti (copy)

    refreshSell()
    v50 = if v49:GetAttribute("SELLING") ~= true then false else true
    child_2 = if v49:GetAttribute("MULTISELL") ~= true then false else true
    Options.Visible = false
    ToggleMulti.Text = if not child_2 then "Multi Sell: Off" else "Multi Sell: On"
    ToggleMulti.Visible = v50
end

local function toggleMultiSell() -- line: 561
    -- upvalues:
    --  [1] v49 (copy)

    v49:SetAttribute("MULTISELL", not v49:GetAttribute("MULTISELL"))
end

local function selectSell() -- line: 565
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] t_3 (copy)

    ReplicatedStorage.Remotes.Player.SellEvent:InvokeServer("SellOne", t_3)
end

ToggleMulti.Activated:Connect(toggleMultiSell)
ToggleMulti.Sell.Activated:Connect(selectSell)
v49:GetAttributeChangedSignal("SELLING"):Connect(syncSellAttribute)
v49:GetAttributeChangedSignal("MULTISELL"):Connect(syncSellAttribute)
refreshSell()
v50 = if v49:GetAttribute("SELLING") ~= true then false else true
child_2 = if v49:GetAttribute("MULTISELL") ~= true then false else true
Options.Visible = false
ToggleMulti.Text = if not child_2 then "Multi Sell: Off" else "Multi Sell: On"
ToggleMulti.Visible = v50
ReplicatedStorage.Remotes.Player.SellEvent.Bindable.Event:Connect(function(arguments) -- line: 576
    -- upvalues:
    --  [1] UnHighlight (copy)
    --  [2] v49 (copy)
    --  [3] Sell (copy)
    --  [4] SellHalf (copy)
    --  [5] SellAll (copy)
    --  [6] Drop (copy)
    --  [7] v3 (copy)
    --  [8] Bin (copy)
    --  [9] Menu (copy)

    UnHighlight()

    if arguments ~= true then
        arguments = false
    else
        arguments = true
    end

    script:SetAttribute("SELLING", arguments)

    if not arguments then
        v49:SetAttribute("MULTISELL", nil)
    end

    Sell.Visible = arguments
    SellHalf.Visible = arguments
    SellAll.Visible = arguments
    Drop.Visible = not arguments
    v3:SetAttribute("InMenu", arguments)
    Bin.InGUI.Value = arguments
    Bin.ViewingInventory.Value = arguments
    Menu.Visible = arguments
end)

local _ = function() --[[ CanEquip ]] -- line: 599
    -- upvalues:
    --  [1] v5 (copy)
    --  [2] v3 (copy)

    local v55 = v5:IsIncapacitated()

    if not v3:HasTag("ProcessingInventory") and (not v55 and _G.Use) then
        return true
    end
end

local function InBounds(arg34) -- line: 606
    -- upvalues:
    --  [1] CollectionService (copy)
    --  [2] PlayerGui (copy)

    local v56 = nil
    local v57 = math.huge

    for _, val_11 in CollectionService:GetTagged("dragObject") do
        if val_11:IsDescendantOf(PlayerGui) then
            local Magnitude = (val_11.AbsolutePosition - arg34.AbsolutePosition).Magnitude

            if v57 > Magnitude then
                v56 = val_11
                v57 = Magnitude
            end
        end
    end

    return v56
end

local v58 = BackpackUtils_m.getValidStats()

local function updateEquippedBadge(arg35) -- line: 624
    -- upvalues:
    --  [1] v6 (copy)
    --  [2] v58 (copy)

    local v59 = arg35:GetAttribute("RealName") or arg35.Name

    if v6:GetStat("FightingStyle") == v59 then
        arg35.Equipped.Visible = true
        arg35.Vanity.Visible = false

        return
    end

    local v60 = false
    local v61 = false

    for _, val_12 in v58 do
        if v59 == v6:GetStat(val_12.Equipped) then
            v60 = true
            break
        end

        if v59 == v6:GetStat(val_12.Vanity) then
            v61 = true
        end
    end

    arg35.Equipped.Visible = v60
    local v62 = v61 and not v60
    arg35.Vanity.Visible = v62
end

local function HandleEquipped() -- line: 648
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] updateEquippedBadge (copy)
    --  [3] v24 (ref)
    --  [4] ApplySort (copy)

    for _, val_13 in t_1 do
        updateEquippedBadge(val_13)
    end

    if v24 then
        return
    end

    v24 = true
    task.defer(function() -- line: 231
        -- upvalues:
        --  [1] v24 (ref)
        --  [2] ApplySort (ref)

        v24 = false
        ApplySort()
    end)
end

v6:OnStatChanged("FightingStyle", HandleEquipped)

for _, val_14 in v58 do
    v6:OnStatChanged(val_14.Equipped, HandleEquipped)
    v6:OnStatChanged(val_14.Vanity, HandleEquipped)
end

local _ = function(arg36) --[[ createOrderFrame ]] -- line: 664
    -- upvalues:
    --  [1] Order (copy)

    local v63 = script.OrderButton:Clone()
    v63.Name = arg36
    v63.UI.Key.Text = arg36
    v63.LayoutOrder = if arg36 == 0 then 1 else 0
    v63.Parent = Order

    return v63
end

local function OrderToolbar() -- line: 673
    -- upvalues:
    --  [1] Order (copy)

    for index = 0, 9 do
        local v65 = script.OrderButton:Clone()
        v65.Name = index
        v65.UI.Key.Text = index
        v65.LayoutOrder = if index == 0 then 1 else 0
        v65.Parent = Order
    end
end

v4.ChildAdded:Connect(function(child_5) -- line: 679
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] UnHighlight (copy)

    if not child_5:IsA("Tool") then
        return
    end

    local Name = child_5.Name
    local v67

    for key_16, val_15 in t_1 do
        if key_16.Name == Name then
            v67 = val_15
        end
    end

    v67 = nil

    if v67 then
        UnHighlight()
        v67:SetAttribute("Highlighted", true)
    end
end)
v4.ChildRemoved:Connect(function(child_6) -- line: 691
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] UnHighlight (copy)

    if not child_6:IsA("Tool") then
        return
    end

    local Name_1 = child_6.Name
    local v68

    for key_17, val_16 in t_1 do
        if key_17.Name == Name_1 then
            v68 = val_16
        end
    end

    v68 = nil

    if v68 then
        UnHighlight()
        v68:SetAttribute("Highlighted", false)
    end
end)

local function Backspace() -- line: 703
    -- upvalues:
    --  [1] Bin (copy)
    --  [2] Humanoid (copy)

    if Bin.Chatting.Value then
        return
    end

    Humanoid:UnequipTools()
end

local function GetToolObject(arg39) -- line: 711
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] v4 (copy)

    for _, val_17 in { v3.Backpack, v4 } do
        for _, child_3 in val_17:GetChildren() do
            if child_3.Name == arg39 and child_3:IsA("Tool") then
                return child_3
            end
        end
    end
end

local v69 = false
local v70 = false
local v71 = false

local function ActivateSkill(arg40) -- line: 727
    -- upvalues:
    --  [1] Skills_m (copy)
    --  [2] v71 (ref)
    --  [3] v5 (copy)
    --  [4] States (copy)
    --  [5] v70 (ref)
    --  [6] v69 (ref)
    --  [7] Services_m (copy)
    --  [8] ReplicatedStorage (copy)
    --  [9] Packets_m (copy)

    local Name_2 = arg40.Name
    local v72 = Skills_m.Skills[Name_2]

    if not v72 then
        return
    end

    if v71 then
        return
    end

    v71 = true
    local v73 = v72.EnergyCost or 0
    local Style = v72.Style
    local clock = os.clock()
    local v74 = false
    local v75 = false

    for _, val_18 in { "Parried", "Stunned" } do
        if v5:HasState(val_18) then
            v75 = true
            break
        end
    end

    if not v75 and v5:CanUseSkill() then
        if not (v73 <= States.Energy.Value) then
            if v5:HasState(Name_2) then
                v74 = if v70 then v74 else if v69 then v74 else true
            end
        else
            v74 = if v70 then v74 else if v69 then v74 else true
        end
    end

    if not v74 and not v75 then
        task.wait()
    end

    if not (os.clock() - clock > 0.5) and not v74 and not v75 then
    end

    v71 = false

    if not v74 then
        Services_m.PlaySound(ReplicatedStorage.SFX.Misc.SkillError, script)

        return
    end

    _G.Use = false
    v69 = true
    Packets_m.Magic.packets.Cast.send({ Skill = Name_2 })
    v69 = false
    v70 = true

    if Style == "Transform" then
        _G.Use = true
        task.wait()
    elseif Style == "DoubleClick" then
        task.wait()
        _G.Use = true
    else
        _G.Use = true
    end

    v70 = false
end

local v76 = script.InventorySlot.Size.X.Offset / 2

local function applySlotSize(arg41) -- line: 809
    -- upvalues:
    --  [1] Order (copy)

    local v77 = if arg41:GetAttribute("Highlighted") ~= true then false else true
    local v78

    if arg41:IsDescendantOf(Order) then
        v78 = if not v77 then 1.0909090909090908 else 1.1818181818181819
        arg41.Size = UDim2.fromScale(v78, v78)

        return
    end

    v78 = v77 and UDim2.new(0, 65, 0, 65) or UDim2.new(0, 60, 0, 60)
    arg41.Size = v78
end

local _ = function(arg42, arg43) --[[ templateUpdated ]] -- line: 819
    arg42.New.Visible = arg43
end

local function SetTextContrast(arg44, arg45) -- line: 823
    local _, _, v81 = arg45:ToHSV()

    if v81 < 0.71 then
        arg44.TextColor3 = Color3.fromRGB(255, 255, 255)

        return
    end

    arg44.TextColor3 = Color3.fromRGB(5, 5, 5)
    arg44.UIStroke.Color = Color3.fromRGB(54, 54, 54)
end

local gradient = ColorSequence.new(
    {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 154, 74)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 58, 22)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 154, 74))
    }
)
local t_19 = { Q1 = true, Q2 = true, Q3 = true }

local function createGradeTag(arg46) -- line: 844
    local TextLabel_2 = Instance.new("TextLabel")
    TextLabel_2.Name = "Grade"
    TextLabel_2.AnchorPoint = Vector2.new(0, 0)
    TextLabel_2.Position = UDim2.fromOffset(3, 3)
    TextLabel_2.Size = UDim2.fromOffset(19, 11)
    TextLabel_2.BackgroundColor3 = Color3.fromRGB(24, 25, 28)
    TextLabel_2.BackgroundTransparency = 0.15
    TextLabel_2.BorderSizePixel = 0
    TextLabel_2.FontFace = Font.fromEnum(Enum.Font.SourceSansBold)
    TextLabel_2.TextSize = 11
    TextLabel_2.Text = ""
    TextLabel_2.ZIndex = 9
    TextLabel_2.Visible = false
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 3)
    UICorner.Parent = TextLabel_2
    TextLabel_2.Parent = arg46

    return TextLabel_2
end

local function CREATESLOT(arg47, arg48) -- line: 867
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] Formatter_m (copy)
    --  [3] Items_m (copy)
    --  [4] Skills_m (copy)
    --  [5] Categories (copy)
    --  [6] Services_m (copy)
    --  [7] UnHighlight (copy)
    --  [8] t_2 (copy)
    --  [9] BackpackUtils_m (copy)
    --  [10] v6 (copy)
    --  [11] GrimoireRarity_m (copy)
    --  [12] v4 (copy)
    --  [13] GetSlotList (copy)
    --  [14] SetTextContrast (copy)
    --  [15] ViewportHandle_m (copy)
    --  [16] v10 (copy)
    --  [17] v24 (ref)
    --  [18] ApplySort (copy)
    --  [19] createGradeTag (copy)
    --  [20] Inventory (copy)
    --  [21] t_19 (copy)
    --  [22] HalloweenWeapons_m (copy)
    --  [23] gradient (copy)
    --  [24] updateEquippedBadge (copy)
    --  [25] applySlotSize (copy)
    --  [26] t_3 (copy)
    --  [27] Humanoid (copy)
    --  [28] v50 (ref)
    --  [29] child_2 (ref)
    --  [30] Lock (copy)
    --  [31] Drop (copy)
    --  [32] Sell (copy)
    --  [33] SellHalf (copy)
    --  [34] SellAll (copy)
    --  [35] v11 (ref)
    --  [36] Options (copy)
    --  [37] InBounds (copy)
    --  [38] v76 (copy)
    --  [39] Packets_m (copy)
    --  [40] Order (copy)
    --  [41] v5 (copy)
    --  [42] v3 (copy)
    --  [43] Bin (copy)
    --  [44] DropUI (copy)
    --  [45] Objects (copy)
    --  [46] v12 (ref)
    --  [47] ActivateSkill (copy)
    --  [48] UserInputService (copy)
    --  [49] mouse (copy)
    --  [50] GamepadLayer_m (copy)

    if not arg47:IsA("Tool") or t_1[arg47] then
        return
    end

    local v85 = Formatter_m.formatItem(arg47.Name)
    local v86 = Items_m:LookupItem(v85)
    local v87 = Skills_m.Skills[v85]
    local v88 = v86 or v87

    if not v88 then
        warn(`Backpack: no item or skill data for "{arg47.Name}"`)

        return
    end

    local v89 = if not v87 then v88.Type else "Abilities"
    local v91 = Categories[v89]

    if not v91 then
        local g_warn = warn
        local g_tostring = tostring(v89)
        local Name_3 = arg47.Name
        g_warn(`Backpack: no category "{g_tostring}" for "{Name_3}"`)

        return
    end

    local v93 = Services_m.Maid.new()
    local v94 = script.InventorySlot:Clone()

    local _ = function() --[[ cleanup ]] -- line: 895
        -- upvalues:
        --  [1] UnHighlight (ref)
        --  [2] v93 (ref)
        --  [3] t_1 (ref)
        --  [4] arg47 (copy)
        --  [5] t_2 (ref)
        --  [6] v94 (copy)

        UnHighlight()

        if v93 then
            v93:Destroy()
            v93 = nil
        end

        t_1[arg47] = nil
        t_2[v94] = nil
    end

    local AncestryChanged = arg47.AncestryChanged

    local function v95(_, arg50) -- line: 907
        -- upvalues:
        --  [1] UnHighlight (ref)
        --  [2] v93 (ref)
        --  [3] t_1 (ref)
        --  [4] arg47 (copy)
        --  [5] t_2 (ref)
        --  [6] v94 (copy)

        if not arg50 then
            UnHighlight()

            if v93 then
                v93:Destroy()
                v93 = nil
            end

            t_1[arg47] = nil
            t_2[v94] = nil
        end
    end

    v93:GiveTask(AncestryChanged:Connect(v95))
    local v96 = nil
    local v97 = nil
    local Position = nil
    local AbsolutePosition = nil
    v95 = v86
    local v100

    if v95 then
        v100 = arg47:GetAttribute("Locked")
        v95 = if v100 ~= true then false else true
    end

    v100 = v91.Order
    local Color = v91.Color
    local v101 = Categories[v91.ID]
    local ID_1

    if v101 then
        ID_1 = v91.ID
        v100 = v101.Order
    end

    v101 = Color
    local v102 = BackpackUtils_m.SkillColors[v88.Skillset]
    local v104

    if v102 then
        v101 = v102.BackgroundColor

        if v88.Skillset == v6:GetStat("Magic") then
            v104 = "MagicVariant"

            if v6:GetStat(v104) ~= "Default" then
                v104 = v4
                local v105 = GrimoireRarity_m:GetPlayerVariant(v104)

                if v105 then
                    v101 = v105.Button
                end
            end
        end
    end

    v104 = 70
    local color_1 = Color3.fromRGB(70, v104, 70)
    local v107 = ID_1
    v104 = v100
    local v108 = GetSlotList(v107, v104, v88)
    v94:SetAttribute("RealName", arg47.Name)
    v104 = v100
    v94.Name = v104 .. arg47.Name
    v93:GiveTask(v94)
    t_1[arg47] = v94
    t_2[v94] = v108
    v104 = v94.New
    v104.Visible = not arg48
    v94.BackgroundColor3 = v101
    v94.Outline.ImageColor3 = color_1
    v94.Label.Text = v85
    local v113 = SetTextContrast
    v104 = v94.Label
    v113(v104, v101)
    v94:SetAttribute("Highlighted", false)

    if ID_1 ~= "Weapon" then
        local New_7 = ViewportHandle_m.new
        v104 = v85
        v101 = New_7(v104, v94)

        if v101 then
            local New_6 = UDim2.new
            v104 = 0.85
            v101.Size = New_6(v104, 0, 0.85, 0)
        end
    end

    if v87 then
        local Stock = v94.Stock
        Stock.Visible = false
    else
        v104 = arg47:GetAttribute("Stock")
        local v115 = v104 or 1
        local t_20 = {}

        function t_20.Stock() -- line: 974
            -- upvalues:
            --  [1] arg47 (copy)
            --  [2] v94 (copy)
            --  [3] v115 (ref)
            --  [4] v10 (ref)
            --  [5] v24 (ref)
            --  [6] ApplySort (ref)

            local v116 = arg47:GetAttribute("Stock") or 1
            v94.Stock.Visible = v116 > 1 and true
            v94.Stock.Text = "x" .. v116

            if v116 > v115 then
                v94.New.Visible = true
            end

            if v116 ~= v115 and string.find(v10.SortMode, "Quantity", 1, true) and not v24 then
                v24 = true
                task.defer(function() -- line: 231
                    -- upvalues:
                    --  [1] v24 (ref)
                    --  [2] ApplySort (ref)

                    v24 = false
                    ApplySort()
                end)
            end

            v115 = v116
        end

        function t_20.Quality() -- line: 991
            -- upvalues:
            --  [1] arg47 (copy)
            --  [2] BackpackUtils_m (ref)
            --  [3] v94 (copy)
            --  [4] ID_1 (ref)
            --  [5] v10 (ref)
            --  [6] v24 (ref)
            --  [7] ApplySort (ref)

            local Quality = arg47:GetAttribute("Quality")

            if Quality then
                BackpackUtils_m:SetQuality(v94, ID_1, Quality)
            end

            if v10.SortMode == "Stars" or v10.SortMode == "Best" then
                if v24 then
                    return
                end

                v24 = true
                task.defer(function() -- line: 231
                    -- upvalues:
                    --  [1] v24 (ref)
                    --  [2] ApplySort (ref)

                    v24 = false
                    ApplySort()
                end)
            end
        end

        function t_20.Enchantment() -- line: 1002
            -- upvalues:
            --  [1] arg47 (copy)
            --  [2] BackpackUtils_m (ref)
            --  [3] v94 (copy)

            local Enchantment = arg47:GetAttribute("Enchantment")

            if Enchantment and Enchantment ~= "" then
                BackpackUtils_m:SetEnchantment(v94, Enchantment)
            end
        end

        function t_20.Locked() -- line: 1009
            -- upvalues:
            --  [1] v95 (ref)
            --  [2] arg47 (copy)
            --  [3] v94 (copy)

            v95 = if arg47:GetAttribute("Locked") ~= true then false else true
            v94.Lock.Visible = v95
        end

        function t_20.Bounded() -- line: 1014
            -- upvalues:
            --  [1] arg47 (copy)
            --  [2] v94 (copy)

            if arg47:GetAttribute("Bounded") then
                v94.Outline.ImageColor3 = Color3.fromRGB(120, 18, 50)
            end
        end

        v104 = v88.Type
        v104 = v88.Type

        if v104 == "Material" or v104 == "Consumable" then
            v104 = createGradeTag(v94)
            v100 = v104
            v104 = Inventory:FindFirstChild(arg47.Name)
            local v119 = v104

            function v104() --[[ refreshGrade ]] -- line: 1025
                -- upvalues:
                --  [1] v119 (copy)
                --  [2] arg47 (copy)
                --  [3] BackpackUtils_m (ref)
                --  [4] v100 (copy)

                local v120 = if not v119 then arg47 else if not v119.Parent then arg47 else v119
                local _, v122, v123 = BackpackUtils_m.getQualityBuckets(v120)
                v100.Visible = v123

                if v123 then
                    v100.Text = "\226\152\133" .. v122
                    v100.TextColor3 = BackpackUtils_m.QualityColors[v122]
                end
            end

            for key_21 in t_19 do
                t_20[key_21] = v104
            end

            if v119 then
                v93:GiveTask(v119.AttributeChanged:Connect(function(attribute) -- line: 1042
                    -- upvalues:
                    --  [1] t_19 (ref)
                    --  [2] v119 (copy)
                    --  [3] arg47 (copy)
                    --  [4] BackpackUtils_m (ref)
                    --  [5] v100 (copy)

                    if t_19[attribute] then
                        local v124 = if not v119 then arg47 else if not v119.Parent then arg47 else v119
                        local _, v126, v127 = BackpackUtils_m.getQualityBuckets(v124)
                        v100.Visible = v127

                        if v127 then
                            v100.Text = "\226\152\133" .. v126
                            v100.TextColor3 = BackpackUtils_m.QualityColors[v126]
                        end
                    end
                end))
            end
        end

        function v104() -- line: 1052
        end

        if HalloweenWeapons_m.Is(v88) then
            local UIGradient_1 = Instance.new("UIGradient")
            UIGradient_1.Name = "HalloweenBorder"
            UIGradient_1.Rotation = 45
            UIGradient_1.Color = gradient
            UIGradient_1.Parent = v94.Outline

            function v104() -- line: 1060
                -- upvalues:
                --  [1] v94 (copy)

                v94.Outline.ImageColor3 = Color3.new(1, 1, 1)
            end
        end

        v93:GiveTask(arg47.AttributeChanged:Connect(function(attribute_1) -- line: 1065
            -- upvalues:
            --  [1] t_20 (copy)
            --  [2] v104 (ref)

            local v128 = t_20[attribute_1]

            if v128 then
                v128()
            end

            if v128 then
                v104()
            end
        end))

        for _, val_19 in t_20 do
            val_19()
        end

        v104()
        updateEquippedBadge(v94)
    end

    v93:GiveTask(v94:GetAttributeChangedSignal("Highlighted"):Connect(function() -- line: 1083
        -- upvalues:
        --  [1] v94 (copy)
        --  [2] applySlotSize (ref)

        local v129 = if v94:GetAttribute("Highlighted") ~= true then false else true
        applySlotSize(v94)
        v94.Highlight.Visible = v129
    end))
    v93:GiveTask(v94:GetAttributeChangedSignal("selecting"):Connect(function() -- line: 1089
        -- upvalues:
        --  [1] v94 (copy)
        --  [2] t_3 (ref)
        --  [3] arg47 (copy)

        local v130 = if v94:GetAttribute("selecting") ~= true then false else true
        v94.MultiSelect.Visible = v130
        local v131 = table.find(t_3, arg47)

        if v130 and not v131 then
            table.insert(t_3, arg47)

            return
        end

        if not v130 and v131 then
            table.remove(t_3, v131)
        end
    end))
    v93:GiveTask(v94.MouseButton2Click:Connect(function() -- line: 1102
        -- upvalues:
        --  [1] v86 (copy)
        --  [2] v4 (ref)
        --  [3] arg47 (copy)
        --  [4] Humanoid (ref)
        --  [5] v50 (ref)
        --  [6] child_2 (ref)
        --  [7] v88 (copy)
        --  [8] v95 (ref)
        --  [9] Lock (ref)
        --  [10] Drop (ref)
        --  [11] v6 (ref)
        --  [12] Sell (ref)
        --  [13] SellHalf (ref)
        --  [14] SellAll (ref)
        --  [15] v11 (ref)
        --  [16] Options (ref)
        --  [17] v94 (copy)

        if not v86 then
            return
        end

        if v4:FindFirstChild(arg47.Name) then
            Humanoid:UnequipTools()
        end

        if not v50 and not child_2 then
            local Bounded = arg47:GetAttribute("Bounded")
            local v132 = v88.Droppable

            if v132 then
                v132 = not Bounded and not v95
            end

            Lock.Text = if not v95 then "Lock" else "Unlock"
            Lock.Visible = true
            local v134 = v132
            local v135 = Drop

            if v134 then
                v134 = if v6:GetStat("FightingStyle") == arg47.Name then false else true
            end

            v135.Visible = v134 == true
            Sell.Visible = false
            SellHalf.Visible = false
            SellAll.Visible = false
            v11 = arg47
            Options.Parent = v94
            Options.Visible = true
        end

        if child_2 and Sell.Visible then
            v94:SetAttribute("selecting", not v94:GetAttribute("selecting"))
        end
    end))
    v93:GiveTask(v94.MouseEnter:Connect(function() -- line: 1133
        -- upvalues:
        --  [1] v96 (ref)
        --  [2] v94 (copy)
        --  [3] BackpackUtils_m (ref)
        --  [4] arg47 (copy)
        --  [5] v86 (copy)
        --  [6] v50 (ref)
        --  [7] child_2 (ref)
        --  [8] v88 (copy)
        --  [9] Lock (ref)
        --  [10] v95 (ref)
        --  [11] Drop (ref)
        --  [12] Sell (ref)
        --  [13] SellHalf (ref)
        --  [14] SellAll (ref)
        --  [15] v11 (ref)
        --  [16] Options (ref)

        if v96 then
            return
        end

        v94.New.Visible = false
        BackpackUtils_m:ShowHover({ key = arg47.Name })

        if v86 and v50 and not child_2 then
            local v137 = arg47:GetAttribute("Stock") or 1
            local v138 = if v88.Sellable ~= true then false else true
            Lock.Text = if v95 then "Unlock" else "Lock"
            Lock.Visible = true
            Drop.Visible = false
            Sell.Visible = v138
            local v141 = v138 and v137 > 2
            SellHalf.Visible = v141
            SellAll.Visible = v138
            v11 = arg47
            Options.Visible = true
            Options.Parent = v94
        end
    end))
    v93:GiveTask(v94.MouseLeave:Connect(function() -- line: 1162
        -- upvalues:
        --  [1] BackpackUtils_m (ref)

        BackpackUtils_m:HideHover()
    end))

    local function handleDrop(arg53) -- line: 1167
        -- upvalues:
        --  [1] InBounds (ref)
        --  [2] v94 (copy)
        --  [3] v108 (copy)
        --  [4] v76 (ref)
        --  [5] Packets_m (ref)
        --  [6] arg47 (copy)
        --  [7] v6 (ref)
        --  [8] Order (ref)
        --  [9] t_2 (ref)

        local v142 = InBounds(v94)

        if not v142 then
            v94.Parent = v108

            return
        end

        if (v94.AbsolutePosition - v142.AbsolutePosition).Magnitude >= v76 then
            if (v94.AbsolutePosition - arg53.AbsolutePosition).Magnitude > 40 then
                v94.Parent = v108
                Packets_m.Inventory.packets.OrderDefault.send({ Tool = arg47.Name })

                return
            end

            v94.Parent = arg53

            return
        else
            local num = tonumber(v142.Name)

            if v6:GetStat(`Tool{num}`) == arg47.Name then
                v94.Parent = arg53

                return
            end

            local v146 = Packets_m.Inventory.queries.OrderBackpack.invoke(
                { Tool = arg47, index = num }
            )

            if not v146 or not v146.Replaced then
                v94.Parent = arg53

                return
            end

            local TextButton_1 = v142:FindFirstChildWhichIsA("TextButton")

            if TextButton_1 and TextButton_1 ~= v94 then
                if v146.Swapped and arg53:IsDescendantOf(Order) then
                    TextButton_1.Parent = arg53
                else
                    local v148 = t_2[TextButton_1] or v108
                    TextButton_1.Parent = v148
                end
            end

            v94.Parent = v142

            return
        end
    end

    v93:GiveTask(v94.InputBegan:Connect(function(input) -- line: 1228
        -- upvalues:
        --  [1] v5 (ref)
        --  [2] v3 (ref)
        --  [3] Bin (ref)
        --  [4] v96 (ref)
        --  [5] BackpackUtils_m (ref)
        --  [6] DropUI (ref)
        --  [7] Position (ref)
        --  [8] AbsolutePosition (ref)
        --  [9] v94 (copy)
        --  [10] Objects (ref)
        --  [11] handleDrop (copy)
        --  [12] arg47 (copy)
        --  [13] v12 (ref)
        --  [14] v86 (copy)
        --  [15] v4 (ref)
        --  [16] Humanoid (ref)
        --  [17] ActivateSkill (ref)

        local v149 = v5:IsIncapacitated()

        if not (if not v3:HasTag("ProcessingInventory") and (not v149 and _G.Use) then true else nil) then
            return
        end

        local UserInputType_MouseButton1 = Enum.UserInputType.MouseButton1
        local UserInputType_Touch = Enum.UserInputType.Touch

        if input.UserInputType ~= UserInputType_MouseButton1 and input.UserInputType ~= UserInputType_Touch then
            return
        end

        if Bin.ViewingInventory.Value then
            v96 = true
            BackpackUtils_m:HideHover()
            DropUI.Visible = false
            Position = input.Position
            AbsolutePosition = v94.AbsolutePosition
            local v152 = AbsolutePosition
            local v153 = false
            local v154 = v94
            local Parent_1 = v94.Parent
            v154.AnchorPoint = Vector2.new(0, 0)
            v94.Position = UDim2.new(0, AbsolutePosition.X, 0, AbsolutePosition.Y)
            v94.Size = UDim2.fromOffset(v94.AbsoluteSize.X, v94.AbsoluteSize.Y)
            v94.Parent = Objects
            local v159 = nil
            v159 = input.Changed:Connect(function() -- line: 1255
                -- upvalues:
                --  [1] input (copy)
                --  [2] v159 (ref)
                --  [3] v96 (ref)
                --  [4] v152 (ref)
                --  [5] v94 (ref)
                --  [6] handleDrop (ref)
                --  [7] Parent_1 (copy)
                --  [8] v153 (ref)

                if input.UserInputState ~= Enum.UserInputState.End then
                    return
                end

                v159:Disconnect()
                v96 = false
                v152 = v94.AbsolutePosition
                local Success, Result = pcall(handleDrop, Parent_1)

                if not Success then
                    warn("Backpack drop failed:", Result)
                    v94.Parent = Parent_1
                end

                v153 = true
            end)

            repeat
                task.wait()
            until v153

            if (AbsolutePosition - v152).Magnitude > 10 then
                return
            end

            if input.UserInputType == Enum.UserInputType.Touch then
                BackpackUtils_m:ShowHover({ key = arg47.Name })
                v12 = true
            end
        end

        if v86 then
            if arg47.Parent == v4 then
                Humanoid:UnequipTools()

                return
            end

            Humanoid:EquipTool(arg47)

            return
        else
            if arg47:FindFirstChild("Skill") then
                ActivateSkill(arg47)
            end

            return
        end
    end))
    v93:GiveTask(v94.InputChanged:Connect(function(input_1) -- line: 1297
        -- upvalues:
        --  [1] v97 (ref)

        if input_1.UserInputType == Enum.UserInputType.MouseMovement or input_1.UserInputType == Enum.UserInputType.Touch then
            v97 = input_1
        end
    end))
    v93:GiveTask(UserInputService.InputChanged:Connect(function(input_2) -- line: 1303
        -- upvalues:
        --  [1] v96 (ref)
        --  [2] v94 (copy)
        --  [3] mouse (ref)
        --  [4] v97 (ref)
        --  [5] Position (ref)
        --  [6] AbsolutePosition (ref)

        if not v96 then
            return
        end

        if input_2.KeyCode == Enum.KeyCode.Thumbstick1 then
            v94.Position = UDim2.new(0, mouse.X, 0, mouse.Y)

            return
        end

        if input_2 == v97 then
            local v166 = input_2.Position - Position
            v94.Position = UDim2.new(0, AbsolutePosition.X + v166.X, 0, AbsolutePosition.Y + v166.Y)
        end
    end))
    local v168 = nil

    for index_1 = 0, 9 do
        local v171 = Order:FindFirstChild((tostring(index_1)))

        if v171 then
            if v6:GetStat(`Tool{index_1}`) == arg47.Name then
                v168 = v171
            end
        end
    end

    local Parent_2 = v94:GetPropertyChangedSignal("Parent")
    v93:GiveTask(Parent_2:Connect(function() -- line: 1322
        -- upvalues:
        --  [1] v94 (copy)
        --  [2] Order (ref)
        --  [3] GamepadLayer_m (ref)
        --  [4] applySlotSize (ref)
        --  [5] Objects (ref)

        if v94:IsDescendantOf(Order) then
            v94.Key.Text = v94.Parent.UI.Key.Text
            v94.Key.Visible = not GamepadLayer_m.isGamepadActive()
            v94.AnchorPoint = Vector2.new(0.5, 0.5)
            v94.Position = UDim2.new(0.5, 0, 0.5, 0)
            applySlotSize(v94)

            return
        end

        if v94.Parent ~= Objects then
            v94.Key.Visible = false
            v94.AnchorPoint = Vector2.new(0, 0)
            applySlotSize(v94)

            return
        end

        v94.Key.Visible = false
        v94.AnchorPoint = Vector2.new(0, 0)
    end))
    v94.Parent = v168 or v108
    local v181 = v24
    local _ = Parent_2:Connect(function() -- line: 1322
        -- upvalues:
        --  [1] v94 (copy)
        --  [2] Order (ref)
        --  [3] GamepadLayer_m (ref)
        --  [4] applySlotSize (ref)
        --  [5] Objects (ref)

        if v94:IsDescendantOf(Order) then
            v94.Key.Text = v94.Parent.UI.Key.Text
            v94.Key.Visible = not GamepadLayer_m.isGamepadActive()
            v94.AnchorPoint = Vector2.new(0.5, 0.5)
            v94.Position = UDim2.new(0.5, 0, 0.5, 0)
            applySlotSize(v94)

            return
        end

        if v94.Parent ~= Objects then
            v94.Key.Visible = false
            v94.AnchorPoint = Vector2.new(0, 0)
            applySlotSize(v94)

            return
        end

        v94.Key.Visible = false
        v94.AnchorPoint = Vector2.new(0, 0)
    end)

    if not v181 then
        v24 = true
        task.defer(function() -- line: 231
            -- upvalues:
            --  [1] v24 (ref)
            --  [2] ApplySort (ref)

            v24 = false
            ApplySort()
        end)
    end
end

OrderToolbar()
UserInputService.TouchStarted:Connect(function() -- line: 1349
    -- upvalues:
    --  [1] v12 (ref)
    --  [2] BackpackUtils_m (copy)

    if v12 then
        v12 = false
        BackpackUtils_m:HideHover()
    end
end)
Backpack.ChildAdded:Connect(CREATESLOT)

for _, child_4 in Backpack:GetChildren() do
    task.spawn(CREATESLOT, child_4, true)
end

local SearchBox = v9:FindFirstChild("SearchBox", true)

local function UpdateInputOfSearchText() -- line: 1364
    -- upvalues:
    --  [1] SearchBox (copy)
    --  [2] t_1 (copy)
    --  [3] Order (copy)

    local v184 = string.upper(SearchBox.Text)

    for _, val_20 in t_1 do
        if val_20:IsA("TextButton") then
            local v185 = string.upper(val_20.Label.Text)
            val_20.Visible = if v184 ~= "" then if string.find(v185, v184, 1, true) == nil then val_20:IsDescendantOf(
                Order
            ) else true else true
        end
    end
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(UpdateInputOfSearchText)
v4.ChildAdded:Connect(function(child_7) -- line: 1383
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] Services_m (copy)

    local _, handleLabel

    if child_7:IsA("Configuration") then
        if not child_7:HasTag("CD") then
            return
        end

        local v188 = child_7.Name:split("_")[1]
        local v190

        for key_25, val_21 in t_1 do
            if key_25.Name == v188 then
                v190 = val_21
            end
        end

        v190 = nil

        if not v190 then
            return
        end

        local v191 = Services_m.Maid.new()

        _ = function() --[[ disconnect ]] -- line: 1397
            -- upvalues:
            --  [1] v191 (ref)

            if v191 then
                v191:Destroy()
                v191 = nil
            end
        end

        local InitialTime = child_7:GetAttribute("InitialTime")
        local v192 = script.CD:Clone()
        v191:GiveTask(v192)
        v191:GiveTask(child_7.AncestryChanged:Connect(function(_, arg59) -- line: 1409
            -- upvalues:
            --  [1] v191 (ref)

            if not arg59 and v191 then
                v191:Destroy()
                v191 = nil
            end
        end))

        function handleLabel() -- line: 1415
            -- upvalues:
            --  [1] child_7 (copy)
            --  [2] InitialTime (copy)
            --  [3] v192 (copy)

            local v193 = child_7:GetAttribute("Time") or 0
            local v194 = if InitialTime and InitialTime > 0 then math.clamp(
                v193 / InitialTime,
                0,
                1
            ) else 0
            v192.Label.Text = string.format("%.1f", v193)
            v192.Size = UDim2.new(v192.Size.X.Scale, 0, v194, 0)
        end

        v191:GiveTask(child_7:GetAttributeChangedSignal("Time"):Connect(handleLabel))
        handleLabel()
        v192.Parent = v190

        return
    else
        return
    end
end)
local Holder = DropUI.Holder
local TextControl = Holder.TextControl
local t_25 = {
    SliderData = { Start = 1, End = 99, Increment = 1 },
    MoveInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad)
}
local v200 = Slider_m.new(Holder, t_25)

local _ = function(arg62) --[[ getDropQuantity ]] -- line: 1438
    -- upvalues:
    --  [1] v11 (ref)

    local v201 = v11 and v11:GetAttribute("Stock") or 1
    local v202 = math.floor(tonumber(arg62) or 1)
    local v203 = math.max(1, v201)

    return (math.clamp(v202, 1, v203))
end

v200.Changed:Connect(function(n1: number) -- line: 1444
    -- upvalues:
    --  [1] TextControl (copy)

    TextControl.Text = n1
end)

local _ = function() --[[ SetupDrop ]] -- line: 1448
    -- upvalues:
    --  [1] v200 (copy)
    --  [2] v11 (ref)
    --  [3] DropUI (copy)

    v200:OverrideValue(1)
    v200._config.SliderData.End = v11:GetAttribute("Stock") or 1
    DropUI.Item.Text = v11.Name:split("_")[1] .. "(s)"
    DropUI.Visible = true
end

v200:Track()
TextControl.FocusLost:Connect(function() -- line: 1458
    -- upvalues:
    --  [1] v200 (copy)
    --  [2] TextControl (copy)
    --  [3] v11 (ref)

    local v204 = v200
    local Text = TextControl.Text
    local v205 = v11 and v11:GetAttribute("Stock") or 1
    local v206 = math.floor(tonumber(Text) or 1)
    local v207 = math.max(1, v205)
    v204:OverrideValue((math.clamp(v206, 1, v207)))
end)
Drop.Activated:Connect(function() -- line: 1462
    -- upvalues:
    --  [1] v11 (ref)
    --  [2] Drop (copy)
    --  [3] Packets_m (copy)
    --  [4] Options (copy)
    --  [5] v200 (copy)
    --  [6] DropUI (copy)

    if not v11 or not Drop.Visible then
        return
    end

    if (v11:GetAttribute("Stock") or 1) <= 1 then
        Packets_m.Inventory.packets.Drop.send({ Item = v11, Quantity = 1 })
        Options.Visible = false

        return
    end

    v200:OverrideValue(1)
    v200._config.SliderData.End = v11:GetAttribute("Stock") or 1
    DropUI.Item.Text = v11.Name:split("_")[1] .. "(s)"
    DropUI.Visible = true
end)

local function Sell_1(arg63) --[[ Sell ]] -- line: 1478
    -- upvalues:
    --  [1] v11 (ref)
    --  [2] v50 (ref)
    --  [3] t_1 (copy)
    --  [4] t_3 (copy)
    --  [5] ReplicatedStorage (copy)

    if not v11 or not v50 then
        return
    end

    local Name_4 = v11.Name
    local v208

    for key_27, val_23 in t_1 do
        if key_27.Name == Name_4 then
            v208 = val_23
        end
    end

    v208 = nil

    if v208 and v208.Equipped.Visible then
        return
    end

    v208 = next(t_3) and t_3 or v11
    ReplicatedStorage.Remotes.Player.SellEvent:InvokeServer(arg63, v208)
end

Sell.Activated:Connect(function() -- line: 1492
    -- upvalues:
    --  [1] Sell_1 (copy)

    Sell_1("SellOne")
end)
SellHalf.Activated:Connect(function() -- line: 1495
    -- upvalues:
    --  [1] Sell_1 (copy)

    Sell_1("SellHalf")
end)
SellAll.Activated:Connect(function() -- line: 1498
    -- upvalues:
    --  [1] Sell_1 (copy)

    Sell_1("SellAll")
end)
Lock.Activated:Connect(function() -- line: 1502
    -- upvalues:
    --  [1] v11 (ref)
    --  [2] Packets_m (copy)
    --  [3] Options (copy)

    if not v11 then
        return
    end

    if Packets_m.Inventory.queries.ToggleLock.invoke({ Item = v11 }) then
        Options.Visible = false
    end
end)
DropUI.Drop.Activated:Connect(function() -- line: 1513
    -- upvalues:
    --  [1] v11 (ref)
    --  [2] Drop (copy)
    --  [3] Packets_m (copy)
    --  [4] TextControl (copy)
    --  [5] Options (copy)
    --  [6] UnHighlight (copy)

    if not v11 or not Drop.Visible then
        return
    end

    local t_28 = { Item = v11, Quantity = nil }
    local Send = Packets_m.Inventory.packets.Drop.send
    local Text_1 = TextControl.Text
    local v209 = v11 and v11:GetAttribute("Stock") or 1
    local v210 = math.floor(tonumber(Text_1) or 1)
    local v211 = math.max(1, v209)
    t_28.Quantity = math.clamp(v210, 1, v211)
    Send(t_28)
    Options.Visible = false
    UnHighlight()
end)
DropUI.Close.Activated:Connect(function() -- line: 1525
    -- upvalues:
    --  [1] UnHighlight (copy)

    UnHighlight()
end)

local function syncAttribute() -- line: 1530
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] Bin (copy)
    --  [4] Menu (copy)
    --  [5] BackpackUtils_m (copy)

    if v3:GetAttribute("InMenu") then
        ReplicatedStorage.Remotes.Grimoire:FireServer("Open")
        Bin.InGUI.Value = true
        Bin.ViewingInventory.Value = true
        Menu.Visible = true

        return
    end

    BackpackUtils_m:HideHover()
    Menu.Visible = false
    ReplicatedStorage.Remotes.Grimoire:FireServer("Close")
    Bin.InGUI.Value = false
    Bin.ViewingInventory.Value = false
end

v3:SetAttribute("InMenu", false)
v3:GetAttributeChangedSignal("InMenu"):Connect(syncAttribute)
local Menu_1 = Binds:WaitForChild("Menu")
local ShowGrimoire = Binds:WaitForChild("Show Grimoire")

local function handleAction(arg64, arg65, _) -- line: 1557
    -- upvalues:
    --  [1] Menu_1 (copy)
    --  [2] v3 (copy)
    --  [3] ShowGrimoire (copy)
    --  [4] ReplicatedStorage (copy)

    if arg64 == Menu_1.Name and arg65 == Enum.UserInputState.Begin then
        v3:SetAttribute("InMenu", not v3:GetAttribute("InMenu"))

        return
    end

    if arg64 == ShowGrimoire.Name and arg65 == Enum.UserInputState.Begin then
        ReplicatedStorage.Remotes.Grimoire:FireServer("BookToggle")
    end
end

v2("Menu", Menu_1, handleAction)
GamepadLayer_m.setTap(Enum.KeyCode.DPadLeft, function() -- line: 1572
    -- upvalues:
    --  [1] handleAction (copy)
    --  [2] Menu_1 (copy)

    handleAction(Menu_1.Name, Enum.UserInputState.Begin)
end)
v2("Show Grimoire", ShowGrimoire, handleAction)
ContextActionService:BindActionAtPriority(
    "Backspace",
    Backspace,
    false,
    5,
    Enum.KeyCode.Backspace
)
local v213

for index_2 = 0, 9 do
    Backspace = `Tool{index_2}`
    v2 = Binds["Tool Slot " .. index_2]
    local v214 = Order:FindFirstChild((tostring(index_2)))

    local function handleToolAction(arg67, arg68, _) -- line: 1596
        -- upvalues:
        --  [1] v2 (copy)
        --  [2] Bin (copy)
        --  [3] GetToolObject (copy)
        --  [4] v6 (copy)
        --  [5] Backspace (copy)
        --  [6] ActivateSkill (copy)
        --  [7] v5 (copy)
        --  [8] v3 (copy)
        --  [9] v4 (copy)
        --  [10] Humanoid (copy)

        if arg67 ~= v2.Name or arg68 ~= Enum.UserInputState.Begin or Bin.Chatting.Value then
            return
        end

        local v216 = GetToolObject(v6:GetStat(Backspace))

        if not v216 then
            return
        end

        if v216:FindFirstChild("Skill") then
            ActivateSkill(v216)

            return
        end

        local v217 = v5:IsIncapacitated()

        if if not v3:HasTag("ProcessingInventory") and (not v217 and _G.Use) then true else nil then
            if v216.Parent == v4 then
                Humanoid:UnequipTools()

                return
            end

            Humanoid:EquipTool(v216)
        end
    end

    PadBinds_m.bind(v2.Name, function(_, arg71) -- line: 1617
        -- upvalues:
        --  [1] handleToolAction (copy)
        --  [2] v2 (copy)

        handleToolAction(v2.Name, arg71)
    end)

    local function v213() --[[ change ]] -- line: 1621
        -- upvalues:
        --  [1] v2 (copy)
        --  [2] Keys (copy)
        --  [3] v214 (copy)

        local v219 = v2.Value
        local v220 = Enum.KeyCode:FromName(v219) or Enum.UserInputType:FromName(v219)

        if not v220 then
            return
        end

        v219 = Keys[v220] or v219

        if string.match(v219, "Mouse") then
            v219 = v219:gsub("^MouseButton(%d+)$", "MB%1")
        end

        v214.UI.Key.Text = v219
        v220 = v214:FindFirstChildWhichIsA("TextButton")

        if v220 then
            v220.Key.Text = v219
        end
    end

    local function updateBind() -- line: 1643
        -- upvalues:
        --  [1] v2 (copy)
        --  [2] ContextActionService (copy)
        --  [3] handleToolAction (copy)
        --  [4] v213 (copy)

        local Value = v2.Value
        local Name_5 = v2.Name
        local v221 = Enum.KeyCode:FromName(Value) or Enum.UserInputType:FromName(Value)
        ContextActionService:UnbindAction(Name_5)

        if not v221 then
            return
        end

        ContextActionService:BindActionAtPriority(
            Name_5,
            handleToolAction,
            false,
            1,
            v221
        )
        v213()
    end

    v2:GetPropertyChangedSignal("Value"):Connect(updateBind)
    task.spawn(updateBind)
end

local PadLegend = Order.Parent:WaitForChild("PadLegend")
local PadHint = script:WaitForChild("PadHint")
local t_29 = {}

for index_3 = 0, 9 do
    local v222 = Order:FindFirstChild((tostring(index_3)))

    if v222 then
        local v223 = PadHint:Clone()
        v223.Visible = false
        v223.Parent = v222
        t_29[index_3] = { button = v222, bindName = "Tool Slot " .. index_3, holder = v223 }
    end
end

local _ = function(arg72) --[[ slotPosition ]] -- line: 1696
    if arg72 == 0 then
        return 10
    end

    return arg72
end

local function formatPositions(arg73) -- line: 1701
    table.sort(arg73)
    local t_31 = {}
    local v224 = nil
    local v225 = nil

    local _ = function() --[[ flush ]] -- line: 1705
        -- upvalues:
        --  [1] v224 (ref)
        --  [2] t_31 (copy)
        --  [3] v225 (ref)

        if v224 then
            table.insert(t_31, if v225 > v224 then `{v224} - {v225}` else tostring(v224))
        end
    end

    for _, val_24 in arg73 do
        if v225 and val_24 == v225 + 1 then
            v225 = val_24
        else
            if v224 then
                table.insert(t_31, if v224 < v225 then `{v224} - {v225}` else tostring(v224))
            end

            v224 = val_24
            v225 = val_24
        end
    end

    if v224 then
        table.insert(t_31, if v224 < v225 then `{v224} - {v225}` else tostring(v224))
    end

    return table.concat(t_31, ", ")
end

local v230 = false

local function buildLegend() -- line: 1724
    -- upvalues:
    --  [1] t_29 (copy)
    --  [2] PadBinds_m (copy)
    --  [3] PadLegend (copy)
    --  [4] formatPositions (copy)

    local t_32 = { L2 = {}, R2 = {}, Both = {} }

    for key_29, val_25 in t_29 do
        local v231 = PadBinds_m.get(val_25.bindName)

        if v231 and v231.layer then
            local v232 = if key_29 ~= 0 then key_29 else 10
            table.insert(t_32[v231.layer], v232)
        end
    end

    local v233 = false

    for key_30, val_26 in t_32 do
        local v234 = PadLegend:FindFirstChild(key_30)

        if v234 then
            v234.Visible = #val_26 > 0 and true
            local Numbers = v234:FindFirstChild("Numbers")

            if Numbers and #val_26 > 0 then
                Numbers.Text = "(" .. formatPositions(val_26) .. ")"
            end

            v233 = v233 or #val_26 > 0
        end
    end

    return v233
end

local function refreshPadHints() -- line: 1749
    -- upvalues:
    --  [1] GamepadLayer_m (copy)
    --  [2] PadLegend (copy)
    --  [3] v230 (ref)
    --  [4] t_29 (copy)
    --  [5] PadBinds_m (copy)

    local v237 = GamepadLayer_m.isGamepadActive()
    local v238 = GamepadLayer_m.getLayer()
    local v239 = PadLegend
    local v240 = v237 and v230
    v239.Visible = v240

    for _, val_27 in t_29 do
        local v241 = val_27.button:FindFirstChildWhichIsA("TextButton")
        local v242 = v241

        if v242 then
            v242 = v241:FindFirstChild("Key")
        end

        if v242 then
            v242.Visible = not v237
        end

        v242 = v237

        if v242 then
            v242 = PadBinds_m.get(val_27.bindName)
        end

        v241 = if not v242 then false else not v242.layer or v238 == v242.layer
        val_27.holder.Visible = v241

        if v241 then
            val_27.holder.Image = PadBinds_m.getIcon(v242.key)
        end
    end
end

local function rebuild() -- line: 1783
    -- upvalues:
    --  [1] v230 (ref)
    --  [2] buildLegend (copy)
    --  [3] refreshPadHints (copy)

    v230 = buildLegend()
    refreshPadHints()
end

GamepadLayer_m.ModifierChanged:Connect(refreshPadHints)
GamepadLayer_m.InputModeChanged:Connect(refreshPadHints)
PadBinds_m.Changed:Connect(rebuild)

for _, val_28 in t_29 do
    val_28.button.ChildAdded:Connect(function(child_8) -- line: 1793
        -- upvalues:
        --  [1] refreshPadHints (copy)

        if child_8:IsA("TextButton") then
            task.defer(refreshPadHints)
        end
    end)
end

task.spawn(rebuild)
local color_2 = Color3.fromRGB(255, 200, 90)
local color_3 = Color3.fromRGB(230, 90, 90)
local WeightDisplay = v9.Top:FindFirstChild("WeightDisplay")
v9 = WeightDisplay

if v9 then
    v9 = WeightDisplay:FindFirstChild("Label")
end

if v9 then
    local TextColor3 = v9.TextColor3

    local function updateWeight() -- line: 1814
        -- upvalues:
        --  [1] Weight_m (copy)
        --  [2] v3 (copy)
        --  [3] v9 (copy)
        --  [4] TextColor3 (copy)
        --  [5] color_3 (copy)
        --  [6] color_2 (copy)

        local v245 = Weight_m.FormatNumber(Weight_m.GetCurrent(v3))

        if Weight_m.IsUnlimited(v3) then
            v9.Text = `Weight: {v245}/\226\136\158`
            v9.TextColor3 = TextColor3

            return
        end

        local v247 = Weight_m.GetMax(v3)
        local v248 = v247 > 0 and Weight_m.GetCurrent(v3) / v247 or 1
        local v249 = v9
        local v250 = Weight_m.FormatNumber(v247)
        v249.Text = `Weight: {v245}/{v250}`
        v9.TextColor3 = if v248 >= 1 then color_3 else if not (v248 >= 0.85) then TextColor3 else color_2
    end

    for _, val_29 in { Weight_m.ATTR_CURRENT, Weight_m.ATTR_MAX, Weight_m.ATTR_UNLIMITED } do
        v3:GetAttributeChangedSignal(val_29):Connect(updateWeight)
    end

    updateWeight()
else
    warn("[BackpackClient] Inventory.Top.WeightDisplay.Label is missing")
end
