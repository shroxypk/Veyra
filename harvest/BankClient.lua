-- Decompiled with Veyra harvester
-- Instance: StarterGui.BankUI.BankClient
-- Class: LocalScript
-- bytes: 11938

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local Basic_m = require(Modules.Basic)
local Items_m = require(Modules.Items)
local Formatter_m = require(Modules.Formatter)
local v2, v3 = require(Modules.scriptObjs).GetPlayerCharacter()
local Inventory = v2:WaitForChild("Inventory")
local _ = v2:WaitForChild("PlayerGui"):WaitForChild(".objects")
local _ = Services_m.Maid.new()
local Bank = v2:WaitForChild("Bank")
local BackpackUtils_m = require(Modules.BackpackUtils)
local Categories = BackpackUtils_m.Categories
local _ = BackpackUtils_m.StatOrder
local Main = script.Parent.Main
local Contents = Main.Account.Contents
local Amount = Contents.Balance.Amount
Main.Inventory.Slots.UIGridLayout.Changed:Connect(function() -- line: 32
    -- upvalues:
    --  [1] Main (copy)

    Main.Inventory.Slots.CanvasSize = UDim2.new(
        0,
        0,
        0,
        Main.Inventory.Slots.UIGridLayout.AbsoluteContentSize.Y + 18
    )
end)

local _ = function(arg1) --[[ CalculatePrice ]] -- line: 37
    -- upvalues:
    --  [1] Basic_m (copy)

    return Basic_m.BankBase + arg1 * Basic_m.BankIncrement
end

local function CREATEBANKSLOT(arg2) -- line: 43
    -- upvalues:
    --  [1] Items_m (copy)
    --  [2] Categories (copy)
    --  [3] Services_m (copy)
    --  [4] BackpackUtils_m (copy)
    --  [5] ReplicatedStorage (copy)
    --  [6] Main (copy)

    local v5 = arg2.Name:split("_")[1]
    local v6 = Items_m.AllItems[v5]

    if not v6 then
        return
    end

    local Type = v6.Type

    if not v6.Desc and not v6.Description then
    end

    local v7 = Categories[Type]
    local Color = v7.Color
    local Order = v7.Order
    local v8 = Color:lerp(Color3.new(0, 0, 0), 0.3)
    local v9 = Services_m.Maid.new()

    local _ = function() --[[ cleanup ]] -- line: 59
        -- upvalues:
        --  [1] v9 (ref)

        if v9 then
            v9:Destroy()
            v9 = nil
        end
    end

    v9:GiveTask(arg2.AncestryChanged:Connect(function(_, arg4) -- line: 66
        -- upvalues:
        --  [1] v9 (ref)

        if not arg4 and v9 then
            v9:Destroy()
            v9 = nil
        end
    end))
    local v10 = script.InventorySlot:Clone()
    v10:SetAttribute("RealName", arg2.Name)
    v10.Name = Order .. arg2.Name
    v10.BackgroundColor3 = Color
    v10.Outline.ImageColor3 = v8
    local v11
    v10.Label.Text, v11 = v5, v10
    v9:GiveTask(v11)
    local t = {}

    function t.Stock() -- line: 83
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] v10 (copy)

        local Stock = arg2:GetAttribute("Stock")
        v10.Stock.Visible = Stock > 1 and true
        v10.Stock.Text = "x" .. Stock
    end

    function t.Quality() -- line: 89
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] BackpackUtils_m (ref)
        --  [3] v10 (copy)
        --  [4] Type (copy)

        BackpackUtils_m:SetQuality(v10, Type, (arg2:GetAttribute("Quality")))
    end

    function t.Enchantment() -- line: 94
        -- upvalues:
        --  [1] BackpackUtils_m (ref)
        --  [2] v10 (copy)
        --  [3] arg2 (copy)

        BackpackUtils_m:SetEnchantment(v10, arg2:GetAttribute("Enchantment"))
    end

    arg2.AttributeChanged:Connect(function(attribute) -- line: 98
        -- upvalues:
        --  [1] t (copy)

        local v15 = t[attribute]

        if v15 then
            v15()
        end
    end)

    for _, val in pairs(t) do
        val()
    end

    v10.MouseEnter:Connect(function() -- line: 109
        -- upvalues:
        --  [1] BackpackUtils_m (ref)
        --  [2] arg2 (copy)

        BackpackUtils_m:ShowHover({ key = arg2.Name, container = arg2 })
    end)
    v10.MouseLeave:Connect(function() -- line: 115
        -- upvalues:
        --  [1] BackpackUtils_m (ref)

        BackpackUtils_m:HideHover()
    end)
    v10.Activated:Connect(function() -- line: 118
        -- upvalues:
        --  [1] ReplicatedStorage (ref)
        --  [2] arg2 (copy)
        --  [3] Main (ref)

        ReplicatedStorage.Remotes.Bank:InvokeServer(
            "WithdrawItem",
            arg2,
            (tonumber(Main.Inventory.BottomBar.Stock.Text))
        )
    end)
    v10.Parent = Main.Bank.Slots
end

local function CREATESLOT(arg6) -- line: 125
    -- upvalues:
    --  [1] Formatter_m (copy)
    --  [2] Items_m (copy)
    --  [3] Categories (copy)
    --  [4] BackpackUtils_m (copy)
    --  [5] ReplicatedStorage (copy)
    --  [6] Main (copy)

    if not arg6 then
        return
    end

    local v17 = Formatter_m.formatItem(arg6.Name)
    local v18 = Items_m:LookupItem(v17)
    local v19 = if Items_m:GetBaseName(v17) == v17 then false else true
    local v20 = v18 and (if v18.Type == "Armor" then not v18.Soulbound else if v18.HalloweenWeapon ~= true then false else not v18.Soulbound)

    if not v18 or not v18.Tradeable and (not v19 and not v20) then
        return
    end

    local Type_1 = v18.Type

    if not v18.Desc and not v18.Description then
    end

    local v22 = Categories[Type_1]
    local Color_1 = v22.Color
    local Order_1 = v22.Order
    local v23 = Color_1:lerp(Color3.new(0, 0, 0), 0.3)
    local v24 = script.InventorySlot:Clone()
    v24:SetAttribute("RealName", arg6.Name)
    v24.Name = Order_1 .. arg6.Name
    v24.BackgroundColor3 = Color_1
    v24.Outline.ImageColor3 = v23
    v24.Label.Text = v17
    local t_2 = {}

    function t_2.Bounded() -- line: 157
        -- upvalues:
        --  [1] arg6 (copy)
        --  [2] v24 (copy)

        if arg6:GetAttribute("Bounded") then
            v24.Outline.ImageColor3 = Color3.fromRGB(120, 18, 50)
        end
    end

    function t_2.Stock() -- line: 164
        -- upvalues:
        --  [1] arg6 (copy)
        --  [2] v24 (copy)

        local Stock_2 = arg6:GetAttribute("Stock")
        v24.Stock.Visible = Stock_2 > 1 and true
        v24.Stock.Text = "x" .. Stock_2
    end

    function t_2.Quality() -- line: 170
        -- upvalues:
        --  [1] arg6 (copy)
        --  [2] BackpackUtils_m (ref)
        --  [3] v24 (copy)
        --  [4] Type_1 (copy)

        BackpackUtils_m:SetQuality(v24, Type_1, (arg6:GetAttribute("Quality")))
    end

    function t_2.Enchantment() -- line: 175
        -- upvalues:
        --  [1] BackpackUtils_m (ref)
        --  [2] v24 (copy)
        --  [3] arg6 (copy)

        BackpackUtils_m:SetEnchantment(v24, arg6:GetAttribute("Enchantment"))
    end

    arg6.AttributeChanged:Connect(function(attribute_1) -- line: 179
        -- upvalues:
        --  [1] t_2 (copy)

        local v28 = t_2[attribute_1]

        if v28 then
            v28()
        end
    end)

    for _, val_1 in pairs(t_2) do
        val_1()
    end

    v24.MouseEnter:Connect(function() -- line: 190
        -- upvalues:
        --  [1] BackpackUtils_m (ref)
        --  [2] arg6 (copy)

        BackpackUtils_m:ShowHover({ key = arg6.Name, container = arg6 })
    end)
    v24.MouseLeave:Connect(function() -- line: 196
        -- upvalues:
        --  [1] BackpackUtils_m (ref)

        BackpackUtils_m:HideHover()
    end)
    v24.Activated:Connect(function() -- line: 199
        -- upvalues:
        --  [1] ReplicatedStorage (ref)
        --  [2] arg6 (copy)
        --  [3] Main (ref)

        ReplicatedStorage.Remotes.Bank:InvokeServer(
            "StoreItem",
            arg6,
            (tonumber(Main.Inventory.BottomBar.Stock.Text))
        )
    end)
    arg6.AncestryChanged:Connect(function(_, arg9) -- line: 203
        -- upvalues:
        --  [1] v24 (copy)

        if not arg9 then
            v24:Destroy()
        end
    end)
    v24.Parent = Main.Inventory.Slots
end

Inventory.ChildAdded:Connect(CREATESLOT)

for _, child in Inventory:GetChildren() do
    task.spawn(CREATESLOT, child)
end

Bank.ChildAdded:Connect(CREATEBANKSLOT)

for _, child_1 in Bank:GetChildren() do
    task.spawn(CREATEBANKSLOT, child_1)
end

Main.Close.Activated:Connect(function() -- line: 222
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    ReplicatedStorage.Remotes.Bank:InvokeServer("StopBanking")
end)
Contents.Deposit.Activated:Connect(function() -- line: 226
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Contents (copy)

    ReplicatedStorage.Remotes.Bank:InvokeServer(
        "DepositMarks",
        nil,
        (tonumber(Contents.Amount.Text))
    )
end)
Contents.Withdraw.Activated:Connect(function() -- line: 229
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Contents (copy)

    ReplicatedStorage.Remotes.Bank:InvokeServer(
        "WithdrawMarks",
        nil,
        (tonumber(Contents.Amount.Text))
    )
end)
Main.Bank.Empty._Add.Button.Activated:Connect(function() -- line: 233
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    ReplicatedStorage.Remotes.Bank:InvokeServer("BuySlot")
end)

local function syncSlots(arg10) -- line: 238
    -- upvalues:
    --  [1] Bank (copy)
    --  [2] Basic_m (copy)
    --  [3] Main (copy)
    --  [4] Formatter_m (copy)

    local CurrentSlots = Bank:GetAttribute("CurrentSlots")

    if CurrentSlots >= Basic_m.MaxBankSlots then
        Main.Bank.Empty._Add.Visible = false
    else
        Main.Bank.Empty._Add.Amount.Text = "BUY FOR " .. Formatter_m.addCommas(
            Basic_m.BankBase + (CurrentSlots + 1) * Basic_m.BankIncrement
        ) .. " MARKS"
    end

    if arg10 then
        for index = 1, Basic_m.MaxBankSlots do
            local _ = Basic_m.MaxBankSlots
            local v30 = script.Empty:Clone()
            v30.Name = index
            v30.Visible = false
            v30.Parent = Main.Bank.Empty
        end
    end

    for index_1 = 1, CurrentSlots do
        local v31 = Main.Bank.Empty:FindFirstChild(index_1)

        if v31 then
            v31.Visible = true
        end
    end
end

Bank:GetAttributeChangedSignal("CurrentSlots"):Connect(syncSlots)
syncSlots(true)

local function syncMarks() -- line: 267
    -- upvalues:
    --  [1] Amount (copy)
    --  [2] Formatter_m (copy)
    --  [3] Bank (copy)

    Amount.Text = Formatter_m.addCommas(Bank:GetAttribute("MarksStored")) .. ".00"
end

Bank:GetAttributeChangedSignal("MarksStored"):Connect(syncMarks)
Amount.Text = Formatter_m.addCommas(Bank:GetAttribute("MarksStored")) .. ".00"

local function syncAttribute() -- line: 275
    -- upvalues:
    --  [1] Main (copy)
    --  [2] v3 (copy)
    --  [3] BackpackUtils_m (copy)

    Main.Visible = v3:GetAttribute("Banking")
    BackpackUtils_m:HideHover()
end

v3:GetAttributeChangedSignal("Banking"):Connect(syncAttribute)
local SearchBox = Main.Inventory.SearchBox

function UpdateInputOfSearchText() -- line: 283
    -- upvalues:
    --  [1] SearchBox (copy)
    --  [2] Main (copy)

    local v34 = string.upper(SearchBox.Text)

    for _, child_2 in pairs(Main.Inventory.Slots:GetChildren()) do
        if child_2:IsA("TextButton") then
            if v34 ~= "" then
                if string.find(string.upper(child_2.Name), v34) ~= nil then
                    child_2.Visible = true
                else
                    child_2.Visible = false
                end
            else
                child_2.Visible = true
                child_2.Visible = false
            end
        end
    end
end

SearchBox.Changed:Connect(UpdateInputOfSearchText)
v2:GetAttributeChangedSignal("ProcessingTrading"):Connect(function() -- line: 299
    -- upvalues:
    --  [1] Main (copy)
    --  [2] v2 (copy)

    Main.Processing.Visible = v2:GetAttribute("ProcessingTrading")
end)
ReplicatedStorage.Remotes.Bank.Client.OnClientEvent:Connect(function(arg11, ...) -- line: 303
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    if arg11 == "PlaySound" then
        _G.PlaySound(ReplicatedStorage.SFX.Misc.Coins, script)
    end
end)
