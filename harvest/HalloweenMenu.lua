-- Decompiled with Veyra harvester
-- Instance: StarterGui.HalloweenUI.HalloweenMenu
-- Class: LocalScript
-- bytes: 52440

local R43
local ContentProvider = game:GetService("ContentProvider")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local v1 = require(ReplicatedStorage.Modules.Icon)
local Formatter_m = require(ReplicatedStorage.Modules.Formatter)
local StatManager_m = require(ReplicatedStorage.Modules.StatManager)
local Items_m = require(ReplicatedStorage.Modules.Items)
local ViewportHandle_m = require(ReplicatedStorage.Modules.ViewportHandle)
local HalloweenQuestInfo_m = require(ReplicatedStorage:WaitForChild("HalloweenQuestInfo"))
local HalloweenRewards_m = require(ReplicatedStorage:WaitForChild("HalloweenRewards"))
local Parent = script.Parent
local Shop = Parent.Shop
local Pass = Parent.Pass
local color = Color3.fromRGB(232, 168, 82)
local UnixTimestamp = DateTime.fromUniversalTime(2026, 11, 28).UnixTimestamp
local v4 = Color3.fromRGB(38, 40, 60)
local color_1 = Color3.fromRGB(255, 255, 255)
local color_2 = Color3.fromRGB(255, 245, 235)
local color_3 = Color3.fromRGB(120, 115, 190)

local _ = function(arg1, arg2) --[[ showModel ]] -- line: 60
    -- upvalues:
    --  [1] ViewportHandle_m (copy)
    --  [2] color_1 (copy)
    --  [3] color_2 (copy)

    local v5 = ViewportHandle_m.new(arg1, arg2)

    if v5 then
        v5.Ambient = color_1
        v5.LightColor = color_2
        v5.ZIndex = 2
    end

    return v5
end

local v6 = {}
v6[Color3.fromRGB(88, 66, 40):ToHex()] = Color3.fromRGB(102, 60, 46)
v6[Color3.fromRGB(191, 141, 132):ToHex()] = Color3.fromRGB(246, 172, 128)
local color_4 = Color3.fromRGB(232, 118, 30)
local color_5 = Color3.fromRGB(96, 150, 70)

local _ = function(arg3) --[[ show ]] -- line: 84
    -- upvalues:
    --  [1] Shop (copy)
    --  [2] Pass (copy)

    Shop.Visible = arg3 == Shop
    Pass.Visible = arg3 == Pass
end

Pass.QuotePlate:Destroy()
local v10 = (634 - Pass.Size.Y.Offset) / 2 + 40

for _, val in { Pass, Shop } do
    val.Position = val.Position - UDim2.fromOffset(0, v10)
end

local QuestHolder_Frame = Instance.new("Frame")
QuestHolder_Frame.Name = "QuestHolder"
QuestHolder_Frame.AnchorPoint = Pass.AnchorPoint
QuestHolder_Frame.Position = Pass.Position
QuestHolder_Frame.Size = Pass.Size
QuestHolder_Frame.BackgroundTransparency = 1
QuestHolder_Frame.Parent = Parent
local Offset = Pass.Size.X.Offset
local v11 = Shop.Panel:Clone()
v11.Name = "QuestPanel"

for _, child in v11:GetChildren() do
    if child.Name ~= "PanelOverlay" then
        child:Destroy()
    end
end

v11.Position = UDim2.fromOffset(0, 488)
v11.Size = UDim2.fromOffset(Offset, 146)
v11.SliceScale = 0.7
v11.PanelOverlay.SliceScale = 0.7
v11.Parent = QuestHolder_Frame
local v12 = Pass.Main.Detail.ContentsHeader:Clone()
v12.Name = "QuestHeader"
v12.Text = "Daily Quests"
v12.Position = UDim2.fromOffset(20, 15)
v12.Size = UDim2.fromOffset(300, 20)
v12.ZIndex = v11.PanelOverlay.ZIndex + 1
v12.Parent = v11
local v13 = Pass.Main.Detail.Description:Clone()
v13.Name = "QuestReset"
v13.TextXAlignment = Enum.TextXAlignment.Right
v13.TextYAlignment = Enum.TextYAlignment.Center
v13.Position = UDim2.fromOffset(Offset - 70 - 300, 15)
v13.Size = UDim2.fromOffset(300, 20)
v13.ZIndex = v12.ZIndex
v13.Parent = v11
local Card1 = Shop.Panel.Card1
local v14 = (Offset - 32 - 10 * (HalloweenQuestInfo_m.ACTIVE - 1)) / HalloweenQuestInfo_m.ACTIVE
local t = {}

for index = 1, HalloweenQuestInfo_m.ACTIVE do
    local _ = HalloweenQuestInfo_m.ACTIVE
    local v15 = Card1:Clone()
    v15.Name = "Quest" .. index
    v15.Position = UDim2.fromOffset(16 + (index - 1) * (v14 + 10), 40)
    v15.Size = UDim2.fromOffset(v14, 90)
    v15.Icon:Destroy()
    v15.ItemName.TextXAlignment = Enum.TextXAlignment.Left
    v15.ItemName.Position = UDim2.fromOffset(12, 7)
    v15.ItemName.Size = UDim2.new(1, -24, 0, 18)
    v15.ItemType.TextXAlignment = Enum.TextXAlignment.Left
    v15.ItemType.TextYAlignment = Enum.TextYAlignment.Top
    v15.ItemType.TextWrapped = true
    v15.ItemType.Position = UDim2.fromOffset(12, 27)
    v15.ItemType.Size = UDim2.new(1, -24, 0, 30)
    local Price = v15.Price
    local Purchase = v15.Purchase
    Price.AnchorPoint = Vector2.zero
    Price.Position = UDim2.new(1, -112, 0, 62)
    Price.Size = UDim2.fromOffset(100, 20)
    Purchase.AnchorPoint = Vector2.zero
    Purchase.Position = UDim2.fromOffset(12, 62)
    Purchase.Size = UDim2.new(1, -136, 0, 20)
    local Frame_1 = Instance.new("Frame")
    Frame_1.Name = "Fill"
    Frame_1.BorderSizePixel = 0
    Frame_1.BackgroundColor3 = color_4
    Frame_1.Size = UDim2.fromScale(0, 1)
    Frame_1.ZIndex = Purchase.ZIndex
    Frame_1.Parent = Purchase
    Purchase.Label.ZIndex = Frame_1.ZIndex + 1
    v15.Parent = v11
    t[index] = v15
end

local v16 = nil

local function readState(arg4) -- line: 189
    -- upvalues:
    --  [1] v16 (ref)
    --  [2] HttpService (copy)

    local v17 = v16 and v16:GetStat("HalloweenQuests") or ""
    local v18 = if v17 == "" then "{}" else v17 or "{}"
    local Success, Result = pcall(HttpService.JSONDecode, HttpService, v18)

    if Success then
        if type(Result) ~= "table" or Result.R ~= arg4 then
            return {}, {}
        end

        local v19 = Result.P

        if type(Result.P) ~= "table" or not v19 then
            v19 = {}
        end

        local v20 = Result.D

        if type(Result.D) ~= "table" or not v20 then
            v20 = {}
        end

        return v19, v20
    end

    return {}, {}
end

local function refreshQuests() -- line: 198
    -- upvalues:
    --  [1] HalloweenQuestInfo_m (copy)
    --  [2] readState (copy)
    --  [3] t (copy)
    --  [4] Formatter_m (copy)
    --  [5] color_5 (copy)
    --  [6] color_4 (copy)

    local v21 = HalloweenQuestInfo_m.Rotation(workspace:GetServerTimeNow())
    local v22, v23 = readState(v21)
    local v24 = HalloweenQuestInfo_m.Active(v21)

    for key_2, val_1 in t do
        local v25 = v24[key_2]
        local v26 = v25 ~= nil
        val_1.Visible = v26

        if v25 then
            v26 = if v23[v25.Id] ~= true then false else true
            local v27 = v26 and v25.Goal or math.min(v22[v25.Id] or 0, v25.Goal)
            val_1.ItemName.Text = v25.Title
            val_1.ItemType.Text = v25.Description
            val_1.Price.Amount.Text = Formatter_m.addCommas(v25.Reward.CandyCorn or 0)
            val_1.Purchase.Fill.Size = UDim2.fromScale(v27 / v25.Goal, 1)
            local v28 = v26 and color_5 or color_4
            val_1.Purchase.Fill.BackgroundColor3 = v28
            local Label = val_1.Purchase.Label

            if v26 then
                v28 = "Complete"
            else
                local v29 = Formatter_m.addCommas(v27)
                local v30 = Formatter_m.addCommas(v25.Goal)
                v28 = `{v29} / {v30}`
            end

            Label.Text = v28
        end
    end
end

local HalloweenRewards = nil

local _ = function(arg5) --[[ stat ]] -- line: 225
    -- upvalues:
    --  [1] v16 (ref)

    local v32 = v16

    if v32 then
        v32 = v16:GetStat(arg5)
    end

    return v32
end

local _ = function(u1: userdata, arg6: any) --[[ clickable ]] -- line: 230
    local Click_TextButton = Instance.new("TextButton")
    Click_TextButton.Name = "Click"
    Click_TextButton.Size = UDim2.fromScale(1, 1)
    Click_TextButton.BackgroundTransparency = 1
    Click_TextButton.Text = ""
    Click_TextButton.ZIndex = u1.ZIndex + 10
    Click_TextButton.Parent = u1
    Click_TextButton.Activated:Connect(arg6)

    return Click_TextButton
end

local _ = function(u2: userdata, b1: boolean) --[[ setEnabled ]] -- line: 242
    u2.Label.TextTransparency = if not b1 then 0.45 else 0
end

local _ = function(n1: number) --[[ shortAmount ]] -- line: 247
    if n1 < 1000 then
        return (tostring(n1))
    end

    local v35, v36

    if n1 % 1000 == 0 then
        local v34 = n1 // 1000
        v35 = `{v34}k`

        if not v35 then
            v36 = string.format("%.1f", n1 / 1000)
            v35 = `{v36}k`
        end
    else
        v36 = string.format("%.1f", n1 / 1000)
        v35 = `{v36}k`
    end

    return v35
end

local t_1 = {}

for index_1 = 1, HalloweenRewards_m.Shop.SLOTS do
    local v37 = "Card" .. index_1
    local _ = HalloweenRewards_m.Shop.SLOTS
    t_1[index_1] = Shop.Panel:FindFirstChild(v37)
    local Glow_ImageLabel = Instance.new("ImageLabel")
    Glow_ImageLabel.Name = "Glow"
    Glow_ImageLabel.Image = "rbxassetid://98953772467036"
    Glow_ImageLabel.ImageColor3 = color_3
    Glow_ImageLabel.ImageTransparency = 0.65
    Glow_ImageLabel.BackgroundTransparency = 1
    Glow_ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    Glow_ImageLabel.Position = UDim2.fromScale(0.5, 0.5)
    Glow_ImageLabel.Size = UDim2.fromScale(1.3, 1.3)
    Glow_ImageLabel.ZIndex = 0
    Glow_ImageLabel.Parent = t_1[index_1].Icon
end

local Chest = HalloweenRewards_m.Shop.Chest
local v38 = Card1:Clone()
local QuotePlate = Shop.Panel:FindFirstChild("QuotePlate")

if QuotePlate then
    QuotePlate:Destroy()
end

v38.Name = "ChestRow"
v38.Position = UDim2.fromOffset(Card1.Position.X.Offset, 300)
local Panel = Shop.Panel:FindFirstChild("Card" .. HalloweenRewards_m.Shop.SLOTS)
v38.Size = UDim2.fromOffset(
    Panel.Position.X.Offset + Panel.Size.X.Offset - Card1.Position.X.Offset,
    58
)
v38.SliceScale = 0.8
v38.Frame.SliceScale = 0.8
local Icon = v38.Icon
Icon.AnchorPoint = Vector2.new(0, 0.5)
Icon.Position = UDim2.new(0, 10, 0.5, 0)
Icon.Size = UDim2.fromOffset(50, 50)
v38.ItemName.TextXAlignment = Enum.TextXAlignment.Left
v38.ItemName.Position = UDim2.fromOffset(70, 10)
v38.ItemName.Text = Chest.Name
local Purchase_1 = v38.Purchase
local Price_1 = v38.Price
Purchase_1.AnchorPoint = Vector2.new(1, 0.5)
Purchase_1.Position = UDim2.new(1, -16, 0.5, 0)
Price_1.AnchorPoint = Vector2.new(1, 0.5)
Price_1.Position = UDim2.new(1, -16 - Purchase_1.Size.X.Offset - 10, 0.5, 0)
local v40 = v38.Size.X.Offset - 16 - Purchase_1.Size.X.Offset - 10 - Price_1.Size.X.Offset - 14 - 70
v38.ItemName.Size = UDim2.fromOffset(v40, 20)
v38.ItemType.TextXAlignment = Enum.TextXAlignment.Left
R43.Position = UDim2.fromOffset(70, 32)
R43.Size = UDim2.fromOffset(v40, 14)
R43.TextScaled = true
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
UITextSizeConstraint.MaxTextSize = R43.TextSize
UITextSizeConstraint.MinTextSize = 9
UITextSizeConstraint.Parent = R43
R43.Text = Chest.Description
Price_1.Amount.Text = Formatter_m.addCommas(Chest.Price)
Purchase_1.Label.Text = "Purchase"
v38.Parent = Shop.Panel
task.spawn(function() -- line: 329
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] color_1 (copy)
    --  [3] color_2 (copy)
    --  [4] Icon (copy)

    local HalloweenChestPreview = ReplicatedStorage:WaitForChild("HalloweenChestPreview", 30)

    if not HalloweenChestPreview then
        return
    end

    local Preview_ViewportFrame = Instance.new("ViewportFrame")
    Preview_ViewportFrame.Name = "Preview"
    Preview_ViewportFrame.BackgroundTransparency = 1
    Preview_ViewportFrame.Size = UDim2.fromScale(1, 1)
    Preview_ViewportFrame.Ambient = color_1
    Preview_ViewportFrame.LightColor = color_2
    Preview_ViewportFrame.ZIndex = Icon.ZIndex + 1
    local v41 = HalloweenChestPreview:Clone()
    v41.Parent = Preview_ViewportFrame
    local Camera = Instance.new("Camera")
    Camera.FieldOfView = 30
    Camera.Parent = Preview_ViewportFrame
    Preview_ViewportFrame.CurrentCamera = Camera
    local v42, v43 = v41:GetBoundingBox()
    local v46 = v43.Magnitude / 2 / math.tan((math.rad(Camera.FieldOfView / 2))) * 1.05
    v43 = 0
    Preview_ViewportFrame.Parent = Icon

    while true do
        if not Preview_ViewportFrame.Parent then
            break
        end

        v43 += task.wait() * 0.6
        Camera.CFrame = CFrame.lookAt(
            v42.Position + CFrame.Angles(0, v43, 0) * (Vector3.new(0, 0.45, 1)).Unit * v46,
            v42.Position
        )
    end
end)
task.spawn(function() -- line: 365
    -- upvalues:
    --  [1] Players (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] Chest (copy)
    --  [4] Parent (copy)
    --  [5] HalloweenRewards_m (copy)
    --  [6] v38 (copy)
    --  [7] Shop (copy)

    local UserInputService = game:GetService("UserInputService")
    local GuiService = game:GetService("GuiService")
    local RunService = game:GetService("RunService")
    local v47 = Players.LocalPlayer:WaitForChild("PlayerGui")
    local v48 = nil

    for _ = 1, 60 do
        v48 = v47:FindFirstChild("BeastIndexClient", true)

        if v48 then
            break
        end

        task.wait(1)
    end

    v47 = v48

    if v47 then
        v47 = v48:FindFirstChild("ChestDrops")
    end

    local v49 = v48

    if v49 then
        v49 = v48:FindFirstChild("ChestDropRow")
    end

    v48 = ReplicatedStorage:WaitForChild("BeastIndexData", 60)
    local v50 = v48

    if v50 then
        v50 = v48:WaitForChild("Headless", 10)
    end

    v48 = v50

    if v48 then
        v48 = v50:FindFirstChild("Drops")
    end

    if not v47 or not v49 or not v48 then
        return
    end

    v50 = Vector2.new(16, 12)

    local _ = function(n2: number) --[[ formatChance ]] -- line: 392
        local v51 = n2 * 100

        if v51 >= 99.95 then
            return "100%"
        end

        if v51 >= 10 then
            return string.format("%.0f%%", v51)
        end

        if v51 >= 0.1 then
            return string.format("%.1f%%", v51)
        end

        if v51 > 0 then
            return "<0.1%"
        end

        return "0%"
    end

    local v52 = v47:Clone()
    v52.Name = "HoardDrops"
    v52.Visible = false
    v52.ZIndex = 50

    for _, descendant in v52:GetDescendants() do
        if descendant:IsA("GuiObject") then
            descendant.ZIndex = 51
        end
    end

    v47 = v52:FindFirstChild("Title")

    if v47 then
        v47.Text = Chest.Name
    end

    v52.Parent = Parent
    local t_2 = {}

    for _, child_1 in v48:GetChildren() do
        if child_1.Name ~= "Nothing" then
            local t_3 = { Name = child_1.Name, Chance = child_1:GetAttribute("Chance") or 0 }
            table.insert(t_2, t_3)
        end
    end

    function v48(arg7, arg8) --[[ byChance ]] -- line: 427
        return if arg7.Chance == arg8.Chance then arg7.Name < arg8.Name else arg7.Chance > arg8.Chance
    end

    table.sort(t_2, v48)

    for _, val_2 in { HalloweenRewards_m.HoardGear, HalloweenRewards_m.Filler } do
        local t_4 = {}

        for key_6 in val_2.Items do
            local t_5 = { Name = key_6, Chance = HalloweenRewards_m.RollChance(val_2, key_6) }
            table.insert(t_4, t_5)
        end

        table.sort(t_4, v48)
        table.move(
            t_4,
            1,
            #t_4,
            #t_2 + 1,
            t_2
        )
    end

    for key_7, val_3 in t_2 do
        local v64 = v49:Clone()
        v64.Name = val_3.Name
        v64.ItemName.Text = val_3.Name
        local Chance = v64.Chance
        local v65 = val_3.Chance * 100
        Chance.Text = if v65 >= 99.95 then "100%" else if v65 >= 10 then string.format(
            "%.0f%%",
            v65
        ) else if v65 >= 0.1 then string.format("%.1f%%", v65) else if not (v65 > 0) then "0%" else "<0.1%"
        v64.LayoutOrder = key_7

        for _, descendant_1 in v64:GetDescendants() do
            if descendant_1:IsA("GuiObject") then
                descendant_1.ZIndex = 52
            end
        end

        v64.ZIndex = 51
        v64.Parent = v52
    end

    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "HoardHover"
    Frame_2.BackgroundTransparency = 1
    Frame_2.Size = UDim2.new(0, v38.ItemName.Position.X.Offset + v38.ItemName.Size.X.Offset, 1, 0)
    Frame_2.ZIndex = v38.ItemName.ZIndex + 3
    Frame_2.Parent = v38
    local v67 = false
    local v68 = true
    local v69 = nil

    function v49() --[[ hide ]] -- line: 467
        -- upvalues:
        --  [1] v67 (ref)
        --  [2] v52 (copy)
        --  [3] v69 (ref)

        v67 = false
        v52.Visible = false

        if v69 then
            v69:Disconnect()
            v69 = nil
        end
    end

    local function place() -- line: 475
        -- upvalues:
        --  [1] Parent (ref)
        --  [2] v52 (copy)
        --  [3] v68 (ref)
        --  [4] UserInputService (copy)
        --  [5] GuiService (copy)
        --  [6] v50 (copy)
        --  [7] Frame_2 (copy)

        local AbsoluteSize = Parent.AbsoluteSize
        local UIScale = v52:FindFirstChildOfClass("UIScale")

        if UIScale and v52.AbsoluteSize.Y > 0 then
            UIScale.Scale = math.min(
                1,
                (AbsoluteSize.Y - 16) / (v52.AbsoluteSize.Y / UIScale.Scale)
            )
        end

        local AbsoluteSize_1 = v52.AbsoluteSize
        local v70

        if v68 then
            v70 = UserInputService:GetMouseLocation()

            if not Parent.IgnoreGuiInset then
                v70 -= GuiService:GetGuiInset()
            end

            v70 += v50
        else
            v70 = Frame_2.AbsolutePosition - Vector2.new(0, AbsoluteSize_1.Y + 4)
        end

        local X = v70.X
        local v71 = math.max(AbsoluteSize.X - AbsoluteSize_1.X - 8, 8)
        local v72 = math.clamp(X, 8, v71)
        local Y = v70.Y
        local v73 = math.max(AbsoluteSize.Y - AbsoluteSize_1.Y - 8, 8)
        local v74 = math.clamp(Y, 8, v73)
        v52.Position = UDim2.fromOffset(v72, v74)
    end

    local _ = function(b2: boolean) --[[ show ]] -- line: 497
        -- upvalues:
        --  [1] v67 (ref)
        --  [2] v52 (copy)
        --  [3] v69 (ref)
        --  [4] v68 (ref)
        --  [5] place (copy)
        --  [6] RunService (copy)
        --  [7] Parent (ref)
        --  [8] Shop (ref)
        --  [9] Frame_2 (copy)

        v67 = false
        v52.Visible = false

        if v69 then
            v69:Disconnect()
            v69 = nil
        end

        v67, v68 = true, b2
        place()
        v52.Visible = true
        v69 = RunService.RenderStepped:Connect(function() -- line: 502
            -- upvalues:
            --  [1] v67 (ref)
            --  [2] Parent (ref)
            --  [3] Shop (ref)
            --  [4] Frame_2 (ref)
            --  [5] v52 (ref)
            --  [6] v69 (ref)
            --  [7] place (ref)

            if v67 then
                if Parent.Enabled then
                    if Shop.Visible then
                        if not Frame_2:IsDescendantOf(Parent) then
                            v67 = false
                            v52.Visible = false

                            if v69 then
                                v69:Disconnect()
                                v69 = nil
                            end

                            return
                        end

                        place()

                        return
                    else
                        v67 = false
                        v52.Visible = false

                        if v69 then
                            v69:Disconnect()
                            v69 = nil
                        end

                        return
                    end
                else
                    v67 = false
                    v52.Visible = false

                    if v69 then
                        v69:Disconnect()
                        v69 = nil
                    end

                    return
                end
            else
                v67 = false
                v52.Visible = false

                if v69 then
                    v69:Disconnect()
                    v69 = nil
                end

                return
            end
        end)
    end

    Frame_2.MouseEnter:Connect(function() -- line: 511
        -- upvalues:
        --  [1] v67 (ref)
        --  [2] v52 (copy)
        --  [3] v69 (ref)
        --  [4] v68 (ref)
        --  [5] place (copy)
        --  [6] RunService (copy)
        --  [7] Parent (ref)
        --  [8] Shop (ref)
        --  [9] Frame_2 (copy)

        v67 = false
        v52.Visible = false

        if v69 then
            v69:Disconnect()
            v69 = nil
        end

        v67, v68 = true, true
        place()
        v52.Visible = true
        v69 = RunService.RenderStepped:Connect(function() -- line: 502
            -- upvalues:
            --  [1] v67 (ref)
            --  [2] Parent (ref)
            --  [3] Shop (ref)
            --  [4] Frame_2 (ref)
            --  [5] v52 (ref)
            --  [6] v69 (ref)
            --  [7] place (ref)

            if v67 then
                if Parent.Enabled then
                    if Shop.Visible then
                        if not Frame_2:IsDescendantOf(Parent) then
                            v67 = false
                            v52.Visible = false

                            if v69 then
                                v69:Disconnect()
                                v69 = nil
                            end

                            return
                        end

                        place()

                        return
                    else
                        v67 = false
                        v52.Visible = false

                        if v69 then
                            v69:Disconnect()
                            v69 = nil
                        end

                        return
                    end
                else
                    v67 = false
                    v52.Visible = false

                    if v69 then
                        v69:Disconnect()
                        v69 = nil
                    end

                    return
                end
            else
                v67 = false
                v52.Visible = false

                if v69 then
                    v69:Disconnect()
                    v69 = nil
                end

                return
            end
        end)
    end)
    Frame_2.MouseLeave:Connect(v49)
    Frame_2.InputBegan:Connect(function(input) -- line: 515
        -- upvalues:
        --  [1] v67 (ref)
        --  [2] v52 (copy)
        --  [3] v69 (ref)
        --  [4] v68 (ref)
        --  [5] place (copy)
        --  [6] RunService (copy)
        --  [7] Parent (ref)
        --  [8] Shop (ref)
        --  [9] Frame_2 (copy)

        if input.UserInputType == Enum.UserInputType.Touch then
            v67 = false
            v52.Visible = false

            if v69 then
                v69:Disconnect()
                v69 = nil
            end

            v67, v68 = true, false
            place()
            v52.Visible = true
            v69 = RunService.RenderStepped:Connect(function() -- line: 502
                -- upvalues:
                --  [1] v67 (ref)
                --  [2] Parent (ref)
                --  [3] Shop (ref)
                --  [4] Frame_2 (ref)
                --  [5] v52 (ref)
                --  [6] v69 (ref)
                --  [7] place (ref)

                if v67 then
                    if Parent.Enabled then
                        if Shop.Visible then
                            if not Frame_2:IsDescendantOf(Parent) then
                                v67 = false
                                v52.Visible = false

                                if v69 then
                                    v69:Disconnect()
                                    v69 = nil
                                end

                                return
                            end

                            place()

                            return
                        else
                            v67 = false
                            v52.Visible = false

                            if v69 then
                                v69:Disconnect()
                                v69 = nil
                            end

                            return
                        end
                    else
                        v67 = false
                        v52.Visible = false

                        if v69 then
                            v69:Disconnect()
                            v69 = nil
                        end

                        return
                    end
                else
                    v67 = false
                    v52.Visible = false

                    if v69 then
                        v69:Disconnect()
                        v69 = nil
                    end

                    return
                end
            end)
            task.delay(6, function() -- line: 518
                -- upvalues:
                --  [1] v67 (ref)
                --  [2] v68 (ref)
                --  [3] v52 (ref)
                --  [4] v69 (ref)

                if v67 and not v68 then
                    v67 = false
                    v52.Visible = false

                    if v69 then
                        v69:Disconnect()
                        v69 = nil
                    end
                end
            end)
        end
    end)
end)
local v77 = 0
local v78 = nil

local function refreshChest() -- line: 529
    -- upvalues:
    --  [1] v16 (ref)
    --  [2] Chest (copy)
    --  [3] v77 (ref)
    --  [4] v38 (copy)

    local v79 = v16

    if v79 then
        v79 = v16:GetStat("CandyCorn")
    end

    local v80 = (v79 or 0) >= Chest.Price
    local v81 = os.clock() < v77 and true
    v38.Purchase.Label.Text = if not v81 then "Purchase" else "Confirm?"
    v38.Purchase.Label.TextTransparency = if not v80 then 0.45 else 0
end

local Purchase_2 = v38.Purchase
local TextButton_1 = Instance.new("TextButton")
Instance.new("TextButton").Name = "Click"
TextButton_1.Size = UDim2.fromScale(1, 1)
TextButton_1.BackgroundTransparency = 1
TextButton_1.Text = ""
TextButton_1.ZIndex = Purchase_2.ZIndex + 10
TextButton_1.Parent = Purchase_2
TextButton_1.Activated:Connect(function() -- line: 536
    -- upvalues:
    --  [1] HalloweenRewards (ref)
    --  [2] v16 (ref)
    --  [3] Chest (copy)
    --  [4] v77 (ref)
    --  [5] v38 (copy)
    --  [6] refreshChest (copy)
    --  [7] v78 (ref)

    if HalloweenRewards then
        local v84 = v16

        if v84 then
            v84 = v16:GetStat("CandyCorn")
        end

        if (v84 or 0) < Chest.Price then
            return
        end

        local v89

        if os.clock() >= v77 then
            v77 = os.clock() + 3
            local v85 = v16

            if v85 then
                v85 = v16:GetStat("CandyCorn")
            end

            local v86 = (v85 or 0) >= Chest.Price
            local v87 = os.clock() < v77 and true
            v38.Purchase.Label.Text = if not v87 then "Purchase" else "Confirm?"
            v89 = if not v86 then 0.45 else 0
            v38.Purchase.Label.TextTransparency = v89
            task.delay(3, refreshChest)

            return
        end

        v77 = 0
        local v90 = v16

        if v90 then
            v90 = v16:GetStat("CandyCorn")
        end

        local v91 = (v90 or 0) >= Chest.Price
        local v92 = os.clock() < v77 and true
        v38.Purchase.Label.Text = if not v92 then "Purchase" else "Confirm?"
        v89 = if not v91 then 0.45 else 0
        v38.Purchase.Label.TextTransparency = v89

        if HalloweenRewards:InvokeServer("BuyChest") and v78 then
            v78()
        end

        return
    else
        return
    end
end)
local t_6 = {}

local function refreshShop() -- line: 557
    -- upvalues:
    --  [1] HalloweenRewards_m (copy)
    --  [2] v16 (ref)
    --  [3] t_1 (copy)
    --  [4] Items_m (copy)
    --  [5] Formatter_m (copy)
    --  [6] t_6 (copy)
    --  [7] ViewportHandle_m (copy)
    --  [8] color_1 (copy)
    --  [9] color_2 (copy)
    --  [10] Chest (copy)
    --  [11] v77 (ref)
    --  [12] v38 (copy)

    local v94 = HalloweenRewards_m.Shop.Active(
        HalloweenRewards_m.Shop.Rotation(workspace:GetServerTimeNow())
    )
    local v95 = v16

    if v95 then
        v95 = v16:GetStat("CandyCorn")
    end

    local v96 = v95 or 0
    local _

    for key_9, val_4 in t_1 do
        local v97 = v94[key_9]
        local v98 = v97 ~= nil
        val_4.Visible = v98

        if v97 then
            v98 = Items_m:LookupItem(v97.Item)
            val_4.ItemName.Text = v97.Item
            local ItemType_2 = val_4.ItemType
            ItemType_2.Text = if v98 then v98.ArmorType or (v98.Type or "") else ""
            val_4.Price.Amount.Text = Formatter_m.addCommas(v97.Price)
            val_4.Purchase.Label.Text = "Purchase"
            local Purchase_3 = val_4.Purchase
            local v100 = v96 >= v97.Price and true
            Purchase_3.Label.TextTransparency = if not v100 then 0.45 else 0

            if t_6[val_4] ~= v97.Item then
                t_6[val_4] = v97.Item

                for _, child_2 in val_4.Icon:GetChildren() do
                    if child_2:IsA("ViewportFrame") then
                        child_2:Destroy()
                    end
                end

                local v102 = ViewportHandle_m.new(v97.Item, val_4.Icon)

                if v102 then
                    v102.Ambient = color_1
                    v102.LightColor = color_2
                    v102.ZIndex = 2
                end
            end
        end
    end

    local v103 = v16

    if v103 then
        v103 = v16:GetStat("CandyCorn")
    end

    v96 = (v103 or 0) >= Chest.Price
    v94 = os.clock() < v77 and true
    v38.Purchase.Label.Text = if not v94 then "Purchase" else "Confirm?"
    v38.Purchase.Label.TextTransparency = if not v96 then 0.45 else 0
end

for key_11, val_5 in t_1 do
    local Purchase_4 = val_5.Purchase
    local TextButton_2 = Instance.new("TextButton")
    TextButton_2.Name = "Click"
    TextButton_2.Size = UDim2.fromScale(1, 1)
    TextButton_2.BackgroundTransparency = 1
    TextButton_2.Text = ""
    TextButton_2.ZIndex = Purchase_4.ZIndex + 10
    TextButton_2.Parent = Purchase_4
    TextButton_2.Activated:Connect(function() -- line: 589
        -- upvalues:
        --  [1] HalloweenRewards_m (copy)
        --  [2] key_11 (copy)
        --  [3] HalloweenRewards (ref)
        --  [4] v16 (ref)

        local v106 = HalloweenRewards_m.Shop.Active(
            HalloweenRewards_m.Shop.Rotation(workspace:GetServerTimeNow())
        )[key_11]

        if v106 and HalloweenRewards then
            local v107 = v16

            if v107 then
                v107 = v16:GetStat("CandyCorn")
            end

            if (v107 or 0) >= v106.Price then
                HalloweenRewards:InvokeServer("Buy", v106.Item)
            end
        end
    end)
end

local Detail = Pass.Main.Detail
local Scroll = Pass.Track.Scroll
local Tiers = HalloweenRewards_m.Pass.Tiers
local v109 = Pass.SwitchHint:Clone()
v109.Name = "ClickHint"
v109.Text = "Click any box to see its rewards"
v109.TextXAlignment = Enum.TextXAlignment.Right
v109.AnchorPoint = Vector2.new(1, 0)
v109.Position = UDim2.fromOffset(
    Pass.EndsTimer.Position.X.Offset + Pass.EndsTimer.Size.X.Offset,
    Pass.SwitchHint.Position.Y.Offset
)
v109.Parent = Pass
local color_6 = Color3.fromRGB(255, 190, 124)
local color_7 = Color3.fromRGB(232, 168, 82)
local Tier1 = Scroll.Tiers.Tier1
local Kind = Tier1:FindFirstChild("Kind")

if Kind then
    Kind:Destroy()
end

local v110 = Tier1.Amount.Size.Y.Offset - Tier1.Amount.Position.Y.Offset
local Offset_1 = Tier1.Size.Y.Offset
local v111 = math.floor(
    (Scroll.Size.Y.Offset - Scroll.ScrollBarThickness - (v110 + Offset_1 + 16)) / 2 + v110 + Offset_1 / 2
)
local Selected = Tier1:FindFirstChild("Selected")

if Selected then
    Selected:Destroy()
end

local Pointer = Tier1:FindFirstChild("Pointer")

if Pointer then
    Pointer:Destroy()
end

local ImageLabel_1 = Instance.new("ImageLabel")
ImageLabel_1.Name = "Pointer"
ImageLabel_1.BackgroundTransparency = 1
ImageLabel_1.Image = "rbxassetid://137220380222741"
ImageLabel_1.ImageColor3 = color
ImageLabel_1.ScaleType = Enum.ScaleType.Fit
ImageLabel_1.AnchorPoint = Vector2.new(0.5, 0)
ImageLabel_1.Size = UDim2.fromOffset(16, 12)
ImageLabel_1.Position = UDim2.new(0.5, 0, 1, 3)
local v112
ImageLabel_1.ZIndex, v112 = 7, ImageLabel_1
TweenService:Create(
    v112,
    TweenInfo.new(
        0.6,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.InOut,
        -1,
        true
    ),
    { Position = UDim2.new(0.5, 0, 1, 6) }
):Play()
Tier1.Parent = nil

local _ = function(n3: number) --[[ tierX ]] -- line: 659
    return (n3 - 1) * 84 + 40
end

local t_8 = {}
local v114, v116

for key_12, val_6 in Tiers do
    local v113 = Tier1:Clone()
    v113.Name = "Tier" .. key_12
    v113.Position = UDim2.fromOffset((key_12 - 1) * 84 + 40, v111)
    local Amount_3 = v113.Amount
    local Goal = val_6.Goal

    if Goal < 1000 then
        v114 = tostring(Goal)
    elseif Goal % 1000 == 0 then
        local v115 = Goal // 1000
        v114 = `{v115}k`

        if not v114 then
            v116 = string.format("%.1f", Goal / 1000)
            v114 = `{v116}k`
        end
    else
        v116 = string.format("%.1f", Goal / 1000)
        v114 = `{v116}k`
    end

    Amount_3.Text = v114
    v113.Icon.Image = "rbxassetid://" .. 98268985416120
    local ImageLabel_2 = Instance.new("ImageLabel")
    ImageLabel_2.Name = "Ready"
    ImageLabel_2.BackgroundTransparency = 1
    ImageLabel_2.Image = "rbxassetid://100408357904796"
    ImageLabel_2.ScaleType = Enum.ScaleType.Slice
    ImageLabel_2.SliceCenter = Rect.new(6, 6, 6, 6)
    ImageLabel_2.ImageColor3 = color_6
    ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel_2.Position = UDim2.fromScale(0.5, 0.5)
    ImageLabel_2.Size = UDim2.new(1, 4, 1, 4)
    ImageLabel_2.ZIndex = v113.ZIndex + 3
    ImageLabel_2.Visible = false
    ImageLabel_2.Parent = v113
    local Claimed_TextLabel = Instance.new("TextLabel")
    Claimed_TextLabel.Name = "Claimed"
    Claimed_TextLabel.BackgroundTransparency = 1
    Claimed_TextLabel.Text = "\226\156\147"
    Claimed_TextLabel.FontFace = Font.new("rbxasset://fonts/families/Merriweather.json")
    Claimed_TextLabel.TextSize = 16
    Claimed_TextLabel.TextColor3 = color_7
    Claimed_TextLabel.TextStrokeTransparency = 0
    Claimed_TextLabel.AnchorPoint = Vector2.new(1, 1)
    Claimed_TextLabel.Position = UDim2.new(1, -1, 1, -1)
    Claimed_TextLabel.Size = UDim2.fromOffset(16, 16)
    Claimed_TextLabel.ZIndex = v113.ZIndex + 4
    Claimed_TextLabel.Visible = false
    Claimed_TextLabel.Parent = v113
    v113.Parent = Scroll.Tiers
    t_8[key_12] = v113
end

local v117 = (#Tiers - 1) * 84 + 40 + 40
Scroll.CanvasSize = UDim2.fromOffset(math.max(v117, Scroll.Size.X.Offset), 0)

for _, val_7 in { Scroll.Line, Scroll.Progress } do
    val_7.AnchorPoint = Vector2.new(0, 0.5)
    val_7.Position = UDim2.fromOffset(40, v111)
end

Scroll.Line.Size = UDim2.fromOffset((#Tiers - 1) * 84 + 40 - 40, Scroll.Line.Size.Y.Offset)

local _ = function(n4: number) --[[ scrollTo ]] -- line: 715
    -- upvalues:
    --  [1] Scroll (copy)
    --  [2] v117 (copy)

    local Offset_2 = Scroll.Size.X.Offset
    local v118 = math.max(v117 - Offset_2, 0)
    Scroll.CanvasPosition = Vector2.new(math.clamp((n4 - 1) * 84 + 40 - Offset_2 / 2, 0, v118), 0)
end

Detail.Preview.Size = UDim2.fromOffset(164, 164)
Detail.Preview.Position = UDim2.fromOffset(662, Detail.Preview.Position.Y.Offset)

local function showTierModel(s1: string, u3: userdata) -- line: 727
    -- upvalues:
    --  [1] Parent (copy)
    --  [2] color_1 (copy)
    --  [3] color_2 (copy)

    local v120 = Parent:FindFirstChild(s1)
    local Camera_1

    if v120 then
        if not v120:IsA("Model") then
            return nil
        end

        local Viewport = u3:FindFirstChild("Viewport")
        local ViewportFrame_1 = Instance.new("ViewportFrame")
        ViewportFrame_1.Name = "TierPreview"
        ViewportFrame_1.BackgroundTransparency = 1
        ViewportFrame_1.AnchorPoint = Viewport and Viewport.AnchorPoint or Vector2.new(0.5, 0.5)
        ViewportFrame_1.Position = Viewport and Viewport.Position or UDim2.fromScale(0.5, 0.5)
        ViewportFrame_1.Size = Viewport and Viewport.Size or UDim2.fromScale(1, 1)
        ViewportFrame_1.Ambient = color_1
        ViewportFrame_1.LightColor = color_2
        ViewportFrame_1.ZIndex = Viewport and Viewport.ZIndex or 5
        local v123 = v120:Clone()
        v123.Parent = ViewportFrame_1
        Camera_1 = Instance.new("Camera")
        Camera_1.FieldOfView = 30
        Camera_1.Parent = ViewportFrame_1
        ViewportFrame_1.CurrentCamera = Camera_1
        local v124
        local v125
        v124, v125 = v123:GetBoundingBox()
        local v126 = v124.Position + Vector3.new(0, v125.Y * 0.14, 0)
        local v129 = (math.max(v125.X, v125.Y) / 2 / math.tan((math.rad(Camera_1.FieldOfView / 2))) + v125.Z / 2) * 0.68
        ViewportFrame_1.Parent = u3
        task.spawn(function() -- line: 753
            -- upvalues:
            --  [1] ViewportFrame_1 (copy)
            --  [2] Camera_1 (copy)
            --  [3] v126 (copy)
            --  [4] v129 (copy)

            local v130 = 0

            while true do
                if not ViewportFrame_1.Parent then
                    break
                end

                v130 += task.wait()
                local cframe_1 = CFrame.Angles(0, math.sin(v130 * 0.5) * 0.13962634015954636, 0)
                Camera_1.CFrame = CFrame.lookAt(
                    v126 + cframe_1 * (Vector3.new(0, 0.12, -1)).Unit * v129,
                    v126
                )
            end
        end)

        return ViewportFrame_1
    else
        return nil
    end
end

local ImageLabel_3 = Instance.new("ImageLabel")
ImageLabel_3.Name = "CandyPreview"
ImageLabel_3.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel_3.Position = UDim2.fromScale(0.5, 0.5)
ImageLabel_3.Size = UDim2.fromScale(0.6, 0.6)
ImageLabel_3.SizeConstraint = Enum.SizeConstraint.RelativeXX
ImageLabel_3.BackgroundTransparency = 1
ImageLabel_3.Image = "rbxassetid://" .. 98268985416120
ImageLabel_3.ZIndex = Detail.Preview.ZIndex + 2
ImageLabel_3.Parent = Detail.Preview
Detail.Preview.Viewport.Visible = false
local v142 = Pass.EndsTimer:Clone()
v142.Name = "EarnedPlate"
v142.Position = Pass.EndsTimer.Position - UDim2.fromOffset(Pass.EndsTimer.Size.X.Offset + 8, 0)
v142.Label.Text = "Candy Corn Earned"
v142.Time.Text = "0"
v142.Parent = Pass
local v143 = 1

local function trackX(arg10) -- line: 788
    -- upvalues:
    --  [1] Tiers (copy)

    if arg10 < Tiers[1].Goal then
        return 40
    end

    for index_3 = 1, #Tiers - 1 do
        local Goal_1 = Tiers[index_3].Goal
        local Goal_2 = Tiers[index_3 + 1].Goal

        if arg10 < Goal_2 then
            return (index_3 - 1) * 84 + 40 + ((index_3 + 1 - 1) * 84 + 40 - ((index_3 - 1) * 84 + 40)) * (arg10 - Goal_1) / (Goal_2 - Goal_1)
        end
    end

    return (#Tiers - 1) * 84 + 40
end

local _ = function() --[[ halloweenRaceWorn ]] -- line: 803
    -- upvalues:
    --  [1] Players (copy)

    local CustomizeFolder = Players.LocalPlayer:FindFirstChild("CustomizeFolder")
    local v144 = CustomizeFolder

    if v144 then
        v144 = CustomizeFolder:FindFirstChild("RaceVariant")
    end

    return if v144 == nil then false else v144.Value == 100
end

local v146 = nil

local function refreshPass() -- line: 809
    -- upvalues:
    --  [1] v16 (ref)
    --  [2] HalloweenRewards_m (copy)
    --  [3] v142 (copy)
    --  [4] Formatter_m (copy)
    --  [5] Scroll (copy)
    --  [6] trackX (copy)
    --  [7] Tiers (copy)
    --  [8] t_8 (copy)
    --  [9] ImageLabel_1 (copy)
    --  [10] v143 (ref)
    --  [11] Detail (copy)
    --  [12] Players (copy)
    --  [13] v146 (ref)
    --  [14] showTierModel (copy)
    --  [15] ViewportHandle_m (copy)
    --  [16] color_1 (copy)
    --  [17] color_2 (copy)
    --  [18] ImageLabel_3 (copy)

    local v147 = v16

    if v147 then
        v147 = v16:GetStat("HalloweenCandyEarned")
    end

    local v148 = v147 or 0
    v147 = HalloweenRewards_m.Pass.ParseClaimed
    local v149 = v16

    if v149 then
        v149 = v16:GetStat("HalloweenPassClaimed")
    end

    v147 = v147(v149)
    v142.Time.Text = Formatter_m.addCommas(v148)
    Scroll.Progress.Size = UDim2.fromOffset(trackX(v148) - 40, Scroll.Progress.Size.Y.Offset)
    local v151

    for key_14, val_8 in Tiers do
        local v150 = t_8[key_14]
        v151 = v148 >= val_8.Goal
        local v152 = v147[val_8.Id] == true
        v150.Icon.ImageTransparency = if v151 then 0 else 0.6
        local v153 = v151 and not v152
        v150.Ready.Visible = v153
        v150.Claimed.Visible = v152
    end

    if ImageLabel_1 then
        ImageLabel_1.Parent = t_8[v143]
    end

    local v154 = Tiers[v143]
    Detail.ItemName.Text = v154.Name
    v151 = #Tiers
    Detail.ItemType.Text = `{v154.Type}  \194\183  Tier {v143} of {v151}`
    Detail.Description.Text = v154.Description

    for index_4 = 1, 3 do
        local v156 = Detail.Contents:FindFirstChild("Row" .. index_4)

        if v156 then
            v156.Visible = v154.Contents[index_4] ~= nil
            v156.Label.Text = v154.Contents[index_4] or ""
        end
    end

    local Amount_4 = Detail.Cost.Amount
    local v158 = Formatter_m.addCommas((math.min(v148, v154.Goal)))
    local v159 = Formatter_m.addCommas(v154.Goal)
    Amount_4.Text = `{v158} / {v159} Candy Corn`
    local v160 = if v147[v154.Id] ~= true then false else true
    v147 = not v160 and v148 >= v154.Goal
    Detail.Claim.Label.Text = if not v160 then if not v147 then "Locked" else "Claim" else "Claimed"
    Detail.Claim.Label.TextTransparency = if not v147 then 0.45 else 0

    if v160 and v154.Grants.RaceVariant then
        local CustomizeFolder_1 = Players.LocalPlayer:FindFirstChild("CustomizeFolder")
        local v162 = CustomizeFolder_1

        if v162 then
            v162 = CustomizeFolder_1:FindFirstChild("RaceVariant")
        end

        v147 = if v162 == nil then false else v162.Value == 100
        Detail.Claim.Label.Text = if not v147 then "Equip" else "Unequip"
        Detail.Claim.Label.TextTransparency = 0
    end

    v160 = v154.Grants.Item
    local v164 = v154.Preview or v160

    if v164 ~= v146 then
        v146 = v164

        for _, child_3 in Detail.Preview:GetChildren() do
            if child_3:IsA("ViewportFrame") and child_3 ~= Detail.Preview.Viewport then
                child_3:Destroy()
            end
        end

        local v165

        if v154.Preview then
            v165 = showTierModel(v154.Preview, Detail.Preview)
        elseif v160 then
            v165 = ViewportHandle_m.new(v160, Detail.Preview)

            if v165 then
                v165.Ambient = color_1
                v165.LightColor = color_2
                v165.ZIndex = 2
            end
        else
            v165 = nil
        end

        if v165 then
            v165.ZIndex = Detail.Preview.Viewport.ZIndex
        end

        ImageLabel_3.Visible = not v165
    end
end

for key_16, val_9 in t_8 do
    local TextButton_3 = Instance.new("TextButton")
    TextButton_3.Name = "Click"
    TextButton_3.Size = UDim2.fromScale(1, 1)
    TextButton_3.BackgroundTransparency = 1
    TextButton_3.Text = ""
    TextButton_3.ZIndex = val_9.ZIndex + 10
    TextButton_3.Parent = val_9
    TextButton_3.Activated:Connect(function() -- line: 879
        -- upvalues:
        --  [1] v143 (ref)
        --  [2] key_16 (copy)
        --  [3] refreshPass (copy)

        v143 = key_16
        refreshPass()
    end)
end

local Claim = Detail.Claim
local TextButton_4 = Instance.new("TextButton")
Instance.new("TextButton").Name = "Click"
TextButton_4.Size = UDim2.fromScale(1, 1)
TextButton_4.BackgroundTransparency = 1
TextButton_4.Text = ""
TextButton_4.ZIndex = Claim.ZIndex + 10
TextButton_4.Parent = Claim
TextButton_4.Activated:Connect(function() -- line: 885
    -- upvalues:
    --  [1] Detail (copy)
    --  [2] HalloweenRewards (ref)
    --  [3] v143 (ref)
    --  [4] refreshPass (copy)

    local Text = Detail.Claim.Label.Text

    if HalloweenRewards and Text == "Claim" then
        HalloweenRewards:InvokeServer("Claim", v143)

        return
    end

    if HalloweenRewards and (Text == "Equip" or Text == "Unequip") then
        HalloweenRewards:InvokeServer("RaceVariant", Text == "Equip")
        refreshPass()
    end
end)
task.spawn(function() -- line: 896
    -- upvalues:
    --  [1] Players (copy)
    --  [2] refreshPass (copy)

    local CustomizeFolder_2 = Players.LocalPlayer:WaitForChild("CustomizeFolder", 60)
    local v167 = CustomizeFolder_2

    if v167 then
        v167 = CustomizeFolder_2:WaitForChild("RaceVariant", 30)
    end

    if v167 then
        v167.Changed:Connect(refreshPass)
    end
end)
task.spawn(function() -- line: 904
    -- upvalues:
    --  [1] v16 (ref)
    --  [2] StatManager_m (copy)
    --  [3] Players (copy)
    --  [4] refreshQuests (copy)
    --  [5] refreshShop (copy)
    --  [6] refreshPass (copy)
    --  [7] HalloweenRewards_m (copy)
    --  [8] Tiers (copy)
    --  [9] v143 (ref)
    --  [10] Scroll (copy)
    --  [11] v117 (copy)
    --  [12] HalloweenRewards (ref)
    --  [13] ReplicatedStorage (copy)

    v16 = StatManager_m.require(Players.LocalPlayer)

    if v16 then
        v16:OnStatChanged("HalloweenQuests", refreshQuests)
        v16:OnStatChanged("CandyCorn", refreshShop)
        v16:OnStatChanged("HalloweenCandyEarned", refreshPass)
        v16:OnStatChanged("HalloweenPassClaimed", refreshPass)
        local ParseClaimed = HalloweenRewards_m.Pass.ParseClaimed
        local v168 = v16

        if v168 then
            v168 = v16:GetStat("HalloweenPassClaimed")
        end

        ParseClaimed = ParseClaimed(v168)

        for key_17, val_10 in Tiers do
            if not ParseClaimed[val_10.Id] then
                v143 = key_17
                break
            end
        end
    end

    refreshQuests()
    refreshShop()
    refreshPass()
    local Offset_3 = Scroll.Size.X.Offset
    local v169 = v143
    local v170 = math.max(v117 - Offset_3, 0)
    Scroll.CanvasPosition = Vector2.new(math.clamp((v169 - 1) * 84 + 40 - Offset_3 / 2, 0, v170), 0)
    HalloweenRewards = ReplicatedStorage.Remotes:WaitForChild("HalloweenRewards")
end)
local v172 = v1.new()

function v78() -- line: 933
    -- upvalues:
    --  [1] v172 (copy)

    v172:deselect()
end

v172:setImage(98268985416120)
v172:setOrder(9)
v172:setImageScale(0.95)
v172:getInstance("IconImage"):SetAttribute("TargetWidth", 27)
v172:modifyTheme(
    {
        { "IconButton", "BackgroundColor3", Color3.fromRGB(74, 38, 16) },
        { "Outline", "ImageColor3", Color3.fromRGB(150, 78, 26) }
    }
)
v172.selected:Connect(function() -- line: 945
    -- upvalues:
    --  [1] Pass (copy)
    --  [2] Shop (copy)
    --  [3] refreshQuests (copy)
    --  [4] Parent (copy)

    local v173 = Pass
    Shop.Visible = v173 == Shop
    Pass.Visible = v173 == Pass
    refreshQuests()
    Parent.Enabled = true
end)
v172.deselected:Connect(function() -- line: 950
    -- upvalues:
    --  [1] Parent (copy)

    Parent.Enabled = false
end)
local v175, v176

for _, val_11 in { Shop, Pass } do
    v1 = val_11.TitlePlate
    v175 = v1.ImageColor3
    v176 = if val_11 ~= Shop then Shop else Pass or Shop
    v1.Switch.MouseEnter:Connect(function() -- line: 959
        -- upvalues:
        --  [1] v1 (copy)
        --  [2] v175 (copy)

        v1.ImageColor3 = Color3.new(
            math.min(v175.R * 1.35, 1),
            math.min(v175.G * 1.35, 1),
            (math.min(v175.B * 1.35, 1))
        )
    end)
    v1.Switch.MouseLeave:Connect(function() -- line: 966
        -- upvalues:
        --  [1] v1 (copy)
        --  [2] v175 (copy)

        v1.ImageColor3 = v175
    end)
    v1.Switch.Activated:Connect(function() -- line: 969
        -- upvalues:
        --  [1] v1 (copy)
        --  [2] v175 (copy)
        --  [3] v176 (copy)
        --  [4] Shop (copy)
        --  [5] Pass (copy)

        v1.ImageColor3 = v175
        local v180 = v176
        Shop.Visible = v180 == Shop
        Pass.Visible = v180 == Pass
    end)
    val_11.Close.Activated:Connect(function() -- line: 974
        -- upvalues:
        --  [1] v172 (copy)

        v172:deselect()
    end)
end

Parent.Enabled = false
Shop.Visible = Pass == Shop
Pass.Visible = Pass == Pass

local _ = function(arg11) --[[ formatLeft ]] -- line: 983
    if arg11 <= 0 then
        return "Ended"
    end

    local v183 = arg11 // 86400
    local v184 = arg11 % 86400 // 3600
    local v185 = arg11 % 3600 // 60

    if v183 > 0 then
        return `{v183}d {v184}h`
    end

    if v184 > 0 then
        return `{v184}h {v185}m`
    end

    local v186 = math.max(v185, 1)

    return `{v186}m`
end

local _

for _, descendant_2 in Parent:GetDescendants() do
    if not descendant_2:IsA("ImageLabel") then
        if descendant_2:IsA("ImageButton") and descendant_2.Image == "rbxassetid://140650984089503" then
            descendant_2.ImageColor3 = v4
        elseif descendant_2:IsA("Frame") then
            descendant_2.BackgroundColor3 = v6[descendant_2.BackgroundColor3:ToHex()] or descendant_2.BackgroundColor3
        elseif descendant_2:IsA("TextLabel") then
            descendant_2.TextColor3 = v6[descendant_2.TextColor3:ToHex()] or descendant_2.TextColor3
        end
    elseif descendant_2.Image == "rbxassetid://140650984089503" then
        descendant_2.ImageColor3 = v4
    elseif descendant_2:IsA("Frame") then
        descendant_2.BackgroundColor3 = v6[descendant_2.BackgroundColor3:ToHex()] or descendant_2.BackgroundColor3
    elseif descendant_2:IsA("TextLabel") then
        descendant_2.TextColor3 = v6[descendant_2.TextColor3:ToHex()] or descendant_2.TextColor3
    end
end

task.spawn(function() -- line: 1012
    -- upvalues:
    --  [1] Parent (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] HalloweenRewards_m (copy)
    --  [4] ContentProvider (copy)

    local t_12 = { Parent, `rbxassetid://{98268985416120}` }
    local Tools = ReplicatedStorage:WaitForChild("Tools")

    for _, val_12 in HalloweenRewards_m.Shop.Items do
        local v189 = Tools:FindFirstChild(val_12.Item)

        if v189 then
            table.insert(t_12, v189)
        end
    end

    ContentProvider:PreloadAsync(t_12)
end)
v6 = HalloweenQuestInfo_m.Rotation(workspace:GetServerTimeNow())
v4 = HalloweenRewards_m.Shop.Rotation(workspace:GetServerTimeNow())
local v192

while true do
    local v190 = workspace:GetServerTimeNow()
    local Time_1 = Pass.EndsTimer.Time
    local v191 = UnixTimestamp - math.floor(v190)

    if v191 <= 0 then
        v192 = "Ended"
    else
        local v193 = v191 // 86400
        local v194 = v191 % 86400 // 3600
        local v195 = v191 % 3600 // 60

        if v193 > 0 then
            v192 = `{v193}d {v194}h`
        elseif v194 > 0 then
            v192 = `{v194}h {v195}m`
        else
            local v196 = math.max(v195, 1)
            v192 = `{v196}m`
        end
    end

    Time_1.Text = v192
    local Time_2 = Shop.RotationTimer.Time
    local v198 = math.ceil((HalloweenRewards_m.Shop.TimeLeft(v190)))

    if v198 <= 0 then
        v192 = "Ended"
    else
        local v199 = v198 // 86400
        local v200 = v198 % 86400 // 3600
        local v201 = v198 % 3600 // 60

        if v199 > 0 then
            v192 = `{v199}d {v200}h`
        elseif v200 > 0 then
            v192 = `{v200}h {v201}m`
        else
            local v202 = math.max(v201, 1)
            v192 = `{v202}m`
        end
    end

    Time_2.Text = v192
    local v204 = math.floor((HalloweenQuestInfo_m.TimeLeft(v190)))

    if v204 <= 0 then
        v198 = "Ended"
    else
        local v205 = v204 // 86400
        local v206 = v204 % 86400 // 3600
        local v207 = v204 % 3600 // 60

        if v205 > 0 then
            v198 = `{v205}d {v206}h`
        elseif v206 > 0 then
            v198 = `{v206}h {v207}m`
        else
            local v208 = math.max(v207, 1)
            v198 = `{v208}m`
        end
    end

    v13.Text = `New quests in {v198}`
    local v209 = HalloweenQuestInfo_m.Rotation(v190)

    if v209 ~= v6 then
        v6 = v209
        refreshQuests()
    end

    local v210 = HalloweenRewards_m.Shop.Rotation(v190)

    if v210 ~= v4 then
        v4 = v210
        refreshShop()
    end

    task.wait(1)
end
