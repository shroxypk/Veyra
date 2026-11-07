-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.UI.AugmentPrompt.AugmentClient
-- Class: LocalScript
-- bytes: 6267

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = game:GetService("CollectionService")
local _ = game:GetService("UserInputService")
local Modules = ReplicatedStorage.Modules
local Items_m = require(Modules.Items)
local BackpackUtils_m = require(Modules.BackpackUtils)
local _ = BackpackUtils_m.StatOrder
local Categories = BackpackUtils_m.Categories
local StatManager_m = require(Modules.StatManager)
local v2, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StatManager_m.require(v2)
local Inventory = v2:WaitForChild("Inventory")
local Parent = script.Parent
local Frame = Parent.Frame
local Hover = script.Hover

local _ = function() --[[ disconnect ]] -- line: 33
end

local _ = function() --[[ UnHighlight ]] -- line: 37
    -- upvalues:
    --  [1] Hover (copy)

    Hover.Parent = script
end

local function createSlot(arg1) -- line: 41
    -- upvalues:
    --  [1] Items_m (copy)
    --  [2] Categories (copy)
    --  [3] Services_m (copy)
    --  [4] ReplicatedStorage (copy)
    --  [5] v4 (copy)
    --  [6] Frame (copy)

    if not arg1 then
        return
    end

    local Name = arg1.Name
    local v5 = Items_m.AllItems[Name]

    if not v5 or v5.Type ~= "Augment" then
        return
    end

    local v6 = Categories[v5.Type]
    local Color = v6.Color
    local Order = v6.Order
    local v7 = Color:lerp(Color3.new(0, 0, 0), 0.3)
    local v8 = Services_m.Maid.new()

    local _ = function() --[[ cleanup ]] -- line: 62
        -- upvalues:
        --  [1] v8 (ref)

        if v8 then
            v8:Destroy()
            v8 = nil
        end
    end

    local v9 = script.InventorySlot:Clone()
    v9:SetAttribute("RealName", arg1.Name)
    v9.Name = Order .. arg1.Name
    v9.BackgroundColor3 = Color
    v9.Outline.ImageColor3 = v7
    v9.Label.Text = Name
    v8:GiveTask(v9)
    v8:GiveTask(v9.MouseButton1Click:Connect(function() -- line: 78
        -- upvalues:
        --  [1] ReplicatedStorage (ref)
        --  [2] v4 (ref)
        --  [3] arg1 (copy)

        ReplicatedStorage.Remotes.Grimoire:FireServer("EquipAugment", v4:GetStat("Augment1"), arg1)
    end))
    v8:GiveTask(arg1:GetAttributeChangedSignal("Stock"):Connect(function() --[[ updateStock ]] -- line: 82
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v9 (copy)

        local Stock = arg1:GetAttribute("Stock")
        v9.Stock.Visible = Stock > 1 and true
        v9.Stock.Text = "x" .. Stock
    end))
    v8:GiveTask(arg1.AncestryChanged:Connect(function(_, arg3) -- line: 90
        -- upvalues:
        --  [1] v8 (ref)

        if not arg3 and v8 then
            v8:Destroy()
            v8 = nil
        end
    end))
    local Stock_2 = arg1:GetAttribute("Stock")
    v9.Stock.Visible = Stock_2 > 1 and true
    v9.Stock.Text = "x" .. Stock_2
    v9.Parent = Frame.Inventory.Slots
end

local function connectAugment(arg4) -- line: 101
    -- upvalues:
    --  [1] Frame (copy)
    --  [2] Services_m (copy)
    --  [3] v4 (copy)
    --  [4] Items_m (copy)
    --  [5] Hover (copy)

    local v12 = Frame.Augments[arg4]
    local v13 = Services_m.Maid.new()

    local function update() -- line: 106
        -- upvalues:
        --  [1] v4 (ref)
        --  [2] arg4 (copy)
        --  [3] Items_m (ref)
        --  [4] Hover (ref)
        --  [5] v13 (copy)
        --  [6] v12 (copy)

        local v14 = v4:GetStat(arg4)
        local v15 = Items_m.AllItems[v14]

        if not v15 then
            Hover.Parent = script
            v13:Destroy()
            v12.Icon.Image = ""
            v12.Empty.Visible = true

            return
        end

        v13:Destroy()
        local Desc = v15.Desc
        local Icon = v15.Icon
        v12.Empty.Visible = false
        v12.Icon.Image = Icon
        v13:GiveTask(v12.MouseEnter:Connect(function() -- line: 127
            -- upvalues:
            --  [1] Hover (ref)
            --  [2] v14 (copy)
            --  [3] Desc (copy)
            --  [4] v12 (ref)

            Hover.Display.Header.Text = v14
            Hover.Display.Description.Text = Desc
            Hover.Parent = v12
        end))
        v13:GiveTask(v12.MouseLeave:Connect(function() -- line: 133
            -- upvalues:
            --  [1] Hover (ref)

            Hover.Parent = script
        end))
    end

    v12:SetAttribute("Highlighted", false)
    v4:OnStatChanged(arg4, update)
    update()
end

connectAugment("Augment1")
connectAugment("Augment2")
connectAugment("Augment3")

local function connectXP() -- line: 147
    -- upvalues:
    --  [1] v4 (copy)
    --  [2] Frame (copy)

    local AugmentLevel = v4:GetStat("AugmentLevel")
    local AugmentXP = v4:GetStat("AugmentXP")
    local AugmentMXP = v4:GetStat("AugmentMXP")
    Frame.Level.Label.Text = AugmentLevel
    Frame.Bar.Front:TweenSize(
        UDim2.new(AugmentXP / AugmentMXP, 0, 1, 0),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.5,
        true
    )
    local _ = UDim2.new(AugmentXP / AugmentMXP, 0, 1, 0)

    for _, child in Frame.Augments:GetChildren() do
        if child:IsA("TextButton") then
            child.Locked.Visible = AugmentLevel < tonumber(child.Name:sub(8)) and true
        end
    end
end

v4:OnStatChanged("AugmentLevel", connectXP)
v4:OnStatChanged("AugmentXP", connectXP)
connectXP()
Frame.Level.MouseEnter:Connect(function() -- line: 168
    -- upvalues:
    --  [1] Frame (copy)

    Frame.Level.Info.Visible = true
end)
Frame.Level.MouseLeave:Connect(function() -- line: 171
    -- upvalues:
    --  [1] Frame (copy)

    Frame.Level.Info.Visible = false
end)
Frame.Close.MouseButton1Up:Once(function() -- line: 175
    -- upvalues:
    --  [1] Parent (copy)

    Parent:Destroy()
end)
Frame.Inventory.Slots.UIGridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- line: 178
    -- upvalues:
    --  [1] Frame (copy)

    Frame.Inventory.Empty.Visible = Frame.Inventory.Slots.UIGridLayout.AbsoluteContentSize.Magnitude == 0
end)
Inventory.ChildAdded:Connect(createSlot)

for _, child_1 in Inventory:GetChildren() do
    task.spawn(createSlot, child_1)
end
