-- Decompiled with Veyra harvester
-- Instance: StarterGui.TradeUI.TradeClient
-- Class: LocalScript
-- bytes: 21869

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local _ = game:GetService("CollectionService")
local _ = game:GetService("TextService")
local Modules = ReplicatedStorage.Modules
local _ = require(Modules.Basic)
local Items_m = require(Modules.Items)
local BackpackUtils_m = require(Modules.BackpackUtils)
local PaidItems_m = require(ReplicatedStorage:WaitForChild("PaidItems"))
local v3, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local Inventory = v3:WaitForChild("Inventory")
local _ = v3:WaitForChild("PlayerGui"):WaitForChild("Permanent")
local v5 = Services_m.Maid.new()
local Categories = BackpackUtils_m.Categories
local _ = BackpackUtils_m.StatOrder
local Main = script.Parent.Main
local Invite = script.Parent.Invite
local TradingUtils = ReplicatedStorage:WaitForChild("Trading_Utils")
local color = Color3.fromRGB(255, 106, 106)
local color_1 = Color3.fromRGB(170, 255, 127)

local function Cleanup() -- line: 36
    -- upvalues:
    --  [1] Main (copy)

    for _, child in Main.LocalPlayer.Slots:GetChildren() do
        if child:IsA("GuiButton") then
            child:Destroy()
        end
    end

    for _, child_1 in Main.Player2.Slots:GetChildren() do
        if child_1:IsA("GuiButton") then
            child_1:Destroy()
        end
    end

    for _, child_2 in Main.Chat.History:GetChildren() do
        if child_2:IsA("Frame") then
            child_2:Destroy()
        end
    end
end

function RequestSlot(arg1, arg2) -- line: 54
    for _, descendant in arg2:GetDescendants() do
        if (descendant:GetAttribute("RealName") or descendant.Name) == arg1 then
            return descendant
        end
    end
end

TradingUtils.ChildAdded:Connect(function(child_9) -- line: 63
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] v5 (copy)
    --  [3] Players (copy)
    --  [4] Cleanup (copy)
    --  [5] Main (copy)
    --  [6] color_1 (copy)
    --  [7] color (copy)
    --  [8] ReplicatedStorage (copy)

    child_9:WaitForChild("Players")
    local v7 = child_9:FindFirstChild(v3.Name, true)

    if not v7 then
        return
    end

    (function() --[[ CreateTrade ]] -- line: 69
        -- upvalues:
        --  [1] v5 (ref)
        --  [2] v7 (copy)
        --  [3] Players (ref)
        --  [4] Cleanup (ref)
        --  [5] Main (ref)
        --  [6] v3 (ref)
        --  [7] color_1 (ref)
        --  [8] color (ref)
        --  [9] ReplicatedStorage (ref)

        v5:Destroy()
        local v8 = nil
        local v9 = nil

        for _, child_3 in v7.Parent:GetChildren() do
            if child_3 ~= v7 then
                v8 = child_3
                v9 = Players[child_3.Name]
                break
            end
        end

        Cleanup()
        Main.LocalPlayer.Header.Text = v3.Name
        Main.Player2.Header.Text = v8.Name

        local _ = function(b1: boolean?, u1: userdata) --[[ DecisionDisplay ]] -- line: 88
            -- upvalues:
            --  [1] color_1 (ref)
            --  [2] color (ref)

            u1.Text = if not b1 then "DECIDING" else "ACCEPTED"
            u1.TextColor3 = b1 and color_1 or color
        end

        v5:GiveTask(v7:GetAttributeChangedSignal("Decided"):Connect(function() -- line: 93
            -- upvalues:
            --  [1] v7 (ref)
            --  [2] Main (ref)
            --  [3] color_1 (ref)
            --  [4] color (ref)

            local Decided = v7:GetAttribute("Decided")
            local Decision = Main.LocalPlayer.Decision
            Decision.Text = if Decided then "ACCEPTED" else "DECIDING"
            Decision.TextColor3 = Decided and color_1 or color
        end))
        v5:GiveTask(v8:GetAttributeChangedSignal("Decided"):Connect(function() -- line: 96
            -- upvalues:
            --  [1] v8 (ref)
            --  [2] Main (ref)
            --  [3] color_1 (ref)
            --  [4] color (ref)

            local Decided_2 = v8:GetAttribute("Decided")
            local Decision_1 = Main.Player2.Decision
            Decision_1.Text = if Decided_2 then "ACCEPTED" else "DECIDING"
            Decision_1.TextColor3 = Decided_2 and color_1 or color
        end))
        local Decided_3 = v7:GetAttribute("Decided")
        local Decision_2 = Main.LocalPlayer.Decision
        Decision_2.Text = if Decided_3 then "ACCEPTED" else "DECIDING"
        Decision_2.TextColor3 = Decided_3 and color_1 or color
        local Decided_4 = v8:GetAttribute("Decided")
        local Decision_3 = Main.Player2.Decision
        Decision_3.Text = if Decided_4 then "ACCEPTED" else "DECIDING"
        Decision_3.TextColor3 = Decided_4 and color_1 or color

        local _ = function(arg4, arg5) --[[ CreateText ]] -- line: 103
            -- upvalues:
            --  [1] Main (ref)

            local v17 = script.ChatTemplate:Clone()
            v17.Person.Text = arg4.Name
            v17.Chat.Text = arg5 or "<error>"
            v17.Parent = Main.Chat.History
        end

        local function SendText() -- line: 110
            -- upvalues:
            --  [1] ReplicatedStorage (ref)
            --  [2] v9 (ref)
            --  [3] Main (ref)

            ReplicatedStorage.Remotes.FilterText:FireServer(v9, Main.Chat.ChatBox.Text)
            Main.Chat.ChatBox.Text = ""
        end

        v5:GiveTask(ReplicatedStorage.Remotes.FilterText.OnClientEvent:Connect(function(arg6, arg7) -- line: 115
            -- upvalues:
            --  [1] v3 (ref)
            --  [2] v9 (ref)
            --  [3] Main (ref)

            if arg6 == v3 or arg6 == v9 then
                local v18 = script.ChatTemplate:Clone()
                v18.Person.Text = arg6.Name
                v18.Chat.Text = arg7 or "<error>"
                v18.Parent = Main.Chat.History
            end
        end))
        v5:GiveTask(Main.Chat.Send.MouseButton1Up:Connect(SendText))
        v5:GiveTask(Main.Chat.ChatBox.FocusLost:Connect(function(arg8) -- line: 122
            -- upvalues:
            --  [1] ReplicatedStorage (ref)
            --  [2] v9 (ref)
            --  [3] Main (ref)

            if arg8 then
                ReplicatedStorage.Remotes.FilterText:FireServer(v9, Main.Chat.ChatBox.Text)
                Main.Chat.ChatBox.Text = ""
            end
        end))

        local function AddItem(arg9, arg10) -- line: 128
            return CREATETRADESLOT(arg9, arg10)
        end

        local _ = function(arg11, arg12) --[[ RemoveItem ]] -- line: 132
            local v22 = RequestSlot(arg11, arg12)

            if v22 then
                v22:Destroy()
            end
        end

        v5:GiveTask(v7.Items.ChildAdded:Connect(function(child_4) -- line: 139
            -- upvalues:
            --  [1] Main (ref)
            --  [2] ReplicatedStorage (ref)

            local v23 = CREATETRADESLOT(child_4, Main.LocalPlayer.Slots)

            if not v23 then
                return
            end

            v23.MouseButton1Up:Connect(function() -- line: 145
                -- upvalues:
                --  [1] ReplicatedStorage (ref)
                --  [2] child_4 (copy)

                ReplicatedStorage.Remotes.Trading:InvokeServer("RemoveItem", nil, child_4.Name)
            end)
        end))
        v5:GiveTask(v7.Items.ChildRemoved:Connect(function(child_5) -- line: 150
            -- upvalues:
            --  [1] Main (ref)

            local v25 = RequestSlot(child_5.Name, Main.LocalPlayer.Slots)

            if v25 then
                v25:Destroy()
            end
        end))
        v5:GiveTask(v8.Items.ChildAdded:Connect(AddItem))
        v5:GiveTask(v8.Items.ChildRemoved:Connect(function(child_6) -- line: 154
            -- upvalues:
            --  [1] Main (ref)

            local v28 = RequestSlot(child_6.Name, Main.Player2.Slots)

            if v28 then
                v28:Destroy()
            end
        end))
        v5:GiveTask(v7.AncestryChanged:Connect(function(_, arg17) -- line: 158
            -- upvalues:
            --  [1] v5 (ref)
            --  [2] Main (ref)

            if not arg17 then
                v5:Destroy()
                Main.Visible = false
            end
        end))
        Main.Visible = true
    end)()
end)
Main.Accept.MouseButton1Up:Connect(function() -- line: 171
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    ReplicatedStorage.Remotes.Trading:InvokeServer("AcceptTrade")
end)
Main.Decline.MouseButton1Up:Connect(function() -- line: 175
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    ReplicatedStorage.Remotes.Trading:InvokeServer("CancelTrade")
end)

local function CreateCD(arg18, arg19, arg20, arg21) -- line: 181
    -- upvalues:
    --  [1] Main (copy)
    --  [2] TweenService (copy)

    local v31 = script.Label:Clone()
    v31.Text = arg18
    v31.TextColor3 = arg19 or v31.TextColor3
    v31.Parent = Main
    local v33 = arg21 or 0.5
    v31:TweenSize(
        UDim2.new(0.2, 0, 0.05, 0),
        "Out",
        "Quad",
        v33,
        true
    )
    task.delay(v33 * 0.8, function() -- line: 189
        -- upvalues:
        --  [1] TweenService (ref)
        --  [2] v31 (copy)
        --  [3] v33 (copy)

        TweenService:Create(
            v31,
            TweenInfo.new(v33, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { TextTransparency = 1, TextStrokeTransparency = 1 }
        ):Play()
    end)

    if arg20 then
        arg20:Play()
    end

    _G.Debris(v31, 2)
end

local v36 = Services_m.Maid.new()
v3.ChildAdded:Connect(function(child_10) -- line: 198
    -- upvalues:
    --  [1] v36 (copy)
    --  [2] Invite (copy)
    --  [3] ReplicatedStorage (copy)

    if child_10.Name ~= "TradingInviteInfo" then
        return
    end

    v36:Destroy()
    local Inviting = child_10:WaitForChild("Inviting")
    Invite.Info.Text = `{Inviting.Value.Name} wants to trade with you.`
    Invite.Visible = true
    v36:GiveTask(Invite.Accept.MouseButton1Up:Connect(function() -- line: 209
        -- upvalues:
        --  [1] ReplicatedStorage (ref)
        --  [2] v36 (ref)
        --  [3] Invite (ref)

        if ReplicatedStorage.Remotes.Trading:InvokeServer("Join") then
            v36:Destroy()
            Invite.Visible = false
        end
    end))
    v36:GiveTask(Invite.Decline.MouseButton1Up:Connect(function() -- line: 216
        -- upvalues:
        --  [1] ReplicatedStorage (ref)
        --  [2] v36 (ref)
        --  [3] Invite (ref)

        if ReplicatedStorage.Remotes.Trading:InvokeServer("Decline") then
            v36:Destroy()
            Invite.Visible = false
        end
    end))
end)
v3.ChildRemoved:Connect(function(child_11) -- line: 223
    -- upvalues:
    --  [1] Invite (copy)

    if child_11.Name ~= "TradingInviteInfo" then
        return
    end

    Invite.Visible = false
end)
ReplicatedStorage.Remotes.Trading.Client.OnClientEvent:Connect(function(arg24, ...) -- line: 231
    -- upvalues:
    --  [1] CreateCD (copy)

    if arg24 == "Countdown" then
        CreateCD(...)
    end
end)

function CREATETRADESLOT(arg25, arg26) -- line: 237
    -- upvalues:
    --  [1] Items_m (copy)
    --  [2] Categories (copy)
    --  [3] Services_m (copy)
    --  [4] BackpackUtils_m (copy)
    --  [5] Main (copy)

    local v39 = arg25.Name:split("_")[1]
    local v40 = Items_m:LookupItem(v39)

    if not v40 or not v40.Tradeable then
        return
    end

    local Type = v40.Type

    if not v40.Desc and not v40.Description then
    end

    local v41 = Categories[Type]
    local Color = v41.Color
    local Order = v41.Order
    local v42 = Color:lerp(Color3.new(0, 0, 0), 0.3)
    local v43 = Services_m.Maid.new()
    local Value = arg25.Value

    local _ = function() --[[ cleanup ]] -- line: 257
        -- upvalues:
        --  [1] v43 (ref)

        if v43 then
            v43:Destroy()
            v43 = nil
        end
    end

    v43:GiveTask(Value.AncestryChanged:Connect(function(_, arg28) -- line: 264
        -- upvalues:
        --  [1] v43 (ref)

        if not arg28 and v43 then
            v43:Destroy()
            v43 = nil
        end
    end))
    local v44 = script.InventorySlot:Clone()
    v44:SetAttribute("RealName", arg25.Name)
    v44.Name = Order .. arg25.Name
    v44.BackgroundColor3 = Color
    v44.Outline.ImageColor3 = v42
    local v45
    v44.Label.Text, v45 = v39, v44
    v43:GiveTask(v45)
    local t = {}

    function t.Bounded() -- line: 281
        -- upvalues:
        --  [1] Value (copy)
        --  [2] v44 (copy)

        if Value:GetAttribute("Bounded") then
            v44.Outline.ImageColor3 = Color3.fromRGB(120, 18, 50)
        end
    end

    function t.Stock() -- line: 288
        -- upvalues:
        --  [1] arg25 (copy)
        --  [2] v44 (copy)

        local Stock = arg25:GetAttribute("Stock")
        v44.Stock.Visible = Stock > 1 and true
        v44.Stock.Text = "x" .. Stock
    end

    function t.Quality() -- line: 294
        -- upvalues:
        --  [1] BackpackUtils_m (ref)
        --  [2] v44 (copy)
        --  [3] Type (copy)
        --  [4] Value (copy)

        BackpackUtils_m:SetQuality(v44, Type, Value:GetAttribute("Quality"))
    end

    function t.Enchantment() -- line: 298
        -- upvalues:
        --  [1] BackpackUtils_m (ref)
        --  [2] v44 (copy)
        --  [3] Value (copy)

        BackpackUtils_m:SetEnchantment(v44, Value:GetAttribute("Enchantment"))
    end

    local function onAttributeChanged(arg29) -- line: 303
        -- upvalues:
        --  [1] t (copy)
        --  [2] v43 (ref)

        local v52 = t[arg29]

        if v52 and v43 then
            v52()
        end
    end

    v43:GiveTask(arg25.AttributeChanged:Connect(onAttributeChanged))
    v43:GiveTask(Value.AttributeChanged:Connect(onAttributeChanged))
    local _ = Value.AttributeChanged:Connect(onAttributeChanged)

    for _, val in pairs(t) do
        val()
    end

    v43:GiveTask(v44.MouseEnter:Connect(function() -- line: 316
        -- upvalues:
        --  [1] BackpackUtils_m (ref)
        --  [2] Value (copy)

        BackpackUtils_m:ShowHover({ key = Value.Name, container = Value })
    end))
    v43:GiveTask(v44.MouseLeave:Connect(function() -- line: 322
        -- upvalues:
        --  [1] BackpackUtils_m (ref)

        BackpackUtils_m:HideHover()
    end))
    local v54 = arg26
    local _ = v44.MouseLeave:Connect(function() -- line: 322
        -- upvalues:
        --  [1] BackpackUtils_m (ref)

        BackpackUtils_m:HideHover()
    end)

    if not v54 then
        v54 = Main.Player2.Slots
    end

    v44.Parent = v54

    return v44
end

function CREATESLOT(arg30, arg31) -- line: 331
    -- upvalues:
    --  [1] Items_m (copy)
    --  [2] PaidItems_m (copy)
    --  [3] v3 (copy)
    --  [4] Categories (copy)
    --  [5] Services_m (copy)
    --  [6] BackpackUtils_m (copy)
    --  [7] Inventory (copy)
    --  [8] ReplicatedStorage (copy)
    --  [9] Main (copy)

    if not arg30 then
        return
    end

    local v56 = arg30.Name:split("_")[1]
    local v57 = Items_m.AllItems[v56]
    local New, _, _

    if v57 then
        if v57.Tradeable then
            if arg30:GetAttribute("Untradable") then
                return
            end

            if PaidItems_m.IsPaid(arg30.Name) and not PaidItems_m.CanTradePaid(v3) then
                return
            end

            local Type_1 = v57.Type

            if not v57.Desc and not v57.Description then
            end

            local v58 = Categories[Type_1]
            local Color_1 = v58.Color
            New = Color3.new
            local Order_1 = v58.Order
            local v59 = Color_1:lerp(New(0, 0, 0), 0.3)
            local v60 = Services_m.Maid.new()
            local v61 = false

            _ = function() --[[ cleanup ]] -- line: 357
                -- upvalues:
                --  [1] v60 (ref)
                --  [2] v61 (ref)
                --  [3] BackpackUtils_m (ref)

                if v60 then
                    v60:Destroy()
                    v60 = nil
                end

                if v61 then
                    v61 = false
                    BackpackUtils_m:HideHover()
                end
            end

            local v62 = script.InventorySlot:Clone()
            v62:SetAttribute("RealName", arg30.Name)
            v62.Name = Order_1 .. arg30.Name
            v62.BackgroundColor3 = Color_1
            v62.Outline.ImageColor3 = v59
            local v63
            v62.Label.Text, v63 = v56, v62
            v60:GiveTask(v63)
            v60:GiveTask(arg30.AncestryChanged:Connect(function() -- line: 380
                -- upvalues:
                --  [1] arg30 (copy)
                --  [2] Inventory (ref)
                --  [3] v60 (ref)
                --  [4] v61 (ref)
                --  [5] BackpackUtils_m (ref)

                if not arg30:IsDescendantOf(Inventory) then
                    if v60 then
                        v60:Destroy()
                        v60 = nil
                    end

                    if v61 then
                        v61 = false
                        BackpackUtils_m:HideHover()
                    end
                end
            end))
            v60:GiveTask(v62.MouseEnter:Connect(function() -- line: 386
                -- upvalues:
                --  [1] v61 (ref)
                --  [2] BackpackUtils_m (ref)
                --  [3] arg30 (copy)

                v61 = true
                BackpackUtils_m:ShowHover({ key = arg30.Name })
            end))
            v60:GiveTask(v62.MouseLeave:Connect(function() -- line: 392
                -- upvalues:
                --  [1] v61 (ref)
                --  [2] BackpackUtils_m (ref)

                v61 = false
                BackpackUtils_m:HideHover()
            end))
            v60:GiveTask(v62.MouseButton1Up:Connect(function() -- line: 396
                -- upvalues:
                --  [1] ReplicatedStorage (ref)
                --  [2] arg30 (copy)

                ReplicatedStorage.Remotes.Trading:InvokeServer("AddItem", nil, arg30)
            end))
            local t_3 = {}

            function t_3.Bounded() -- line: 402
                -- upvalues:
                --  [1] arg30 (copy)
                --  [2] v62 (copy)

                if arg30:GetAttribute("Bounded") then
                    v62.Outline.ImageColor3 = Color3.fromRGB(120, 18, 50)
                end
            end

            function t_3.Stock() -- line: 409
                -- upvalues:
                --  [1] arg30 (copy)
                --  [2] v60 (ref)
                --  [3] v61 (ref)
                --  [4] BackpackUtils_m (ref)
                --  [5] v62 (copy)

                local v64 = arg30:GetAttribute("Stock") or 0

                if v64 <= 0 then
                    if v60 then
                        v60:Destroy()
                        v60 = nil
                    end

                    if v61 then
                        v61 = false
                        BackpackUtils_m:HideHover()
                    end

                    return
                end

                v62.Stock.Visible = v64 > 1
                v62.Stock.Text = "x" .. v64
            end

            function t_3.Quality() -- line: 419
                -- upvalues:
                --  [1] arg30 (copy)
                --  [2] BackpackUtils_m (ref)
                --  [3] v62 (copy)
                --  [4] Type_1 (copy)

                BackpackUtils_m:SetQuality(v62, Type_1, (arg30:GetAttribute("Quality")))
            end

            function t_3.Enchantment() -- line: 424
                -- upvalues:
                --  [1] BackpackUtils_m (ref)
                --  [2] v62 (copy)
                --  [3] arg30 (copy)

                BackpackUtils_m:SetEnchantment(v62, arg30:GetAttribute("Enchantment"))
            end

            v60:GiveTask(arg30.AttributeChanged:Connect(function(attribute_1) -- line: 428
                -- upvalues:
                --  [1] t_3 (copy)
                --  [2] v60 (ref)

                local v68 = t_3[attribute_1]

                if v68 and v60 then
                    v68()
                end
            end))
            local _ = arg30.AttributeChanged:Connect(function(attribute_1) -- line: 428
                -- upvalues:
                --  [1] t_3 (copy)
                --  [2] v60 (ref)

                local v68 = t_3[attribute_1]

                if v68 and v60 then
                    v68()
                end
            end)

            for _, val_1 in pairs(t_3) do
                if v60 then
                    val_1()
                end
            end

            if v60 then
                v62.Parent = arg31 or Main.Inventory.Slots
            end

            return
        else
            return
        end
    else
        return
    end
end

Inventory.ChildAdded:Connect(CREATESLOT)

for _, child_7 in Inventory:GetChildren() do
    task.spawn(CREATESLOT, child_7)
end

local SearchBox = Main.Inventory.SearchBox

function UpdateInputOfSearchText() -- line: 453
    -- upvalues:
    --  [1] SearchBox (copy)
    --  [2] Main (copy)

    local v85 = string.upper(SearchBox.Text)

    for _, child_8 in Main.Inventory.Slots:GetChildren() do
        if child_8:IsA("TextButton") then
            if v85 ~= "" then
                if string.find(string.upper(child_8.Name), v85) ~= nil then
                    child_8.Visible = true
                else
                    child_8.Visible = false
                end
            else
                child_8.Visible = true
                child_8.Visible = false
            end
        end
    end
end

SearchBox.Changed:Connect(UpdateInputOfSearchText)
