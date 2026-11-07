-- Decompiled with Veyra harvester
-- Instance: StarterGui.Notification.Window.NotifyClient
-- Class: LocalScript
-- bytes: 27483

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local AlertNotification_m = require(Modules.UI.AlertNotification)
local InventoryListener_m = require(Modules.UI.InventoryListener)
local ReputationNotification_m = require(Modules.UI.ReputationNotification)
local FlourishNotification_m = require(Modules.UI.FlourishNotification)
local BaseQueue_m = require(Modules.UI.BaseQueue)
local BackpackUtils_m = require(Modules.BackpackUtils)
local Skills_m = require(Modules.Skills)
local StatManager_m = require(Modules.StatManager)
local _ = BackpackUtils_m.Categories
local Skills = Skills_m.Skills
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local v2 = StatManager_m.require(LocalPlayer)
local Unlocked_ScreenGui = Instance.new("ScreenGui")
Unlocked_ScreenGui.Name = "Unlocked"
Unlocked_ScreenGui.ResetOnSpawn = true
Unlocked_ScreenGui.Parent = PlayerGui
local v3 = BaseQueue_m.new("Sequential")
local v4 = BaseQueue_m.new("Sequential")
local v5 = BaseQueue_m.new("Sequential")
local Unlock = script:WaitForChild("Unlock")
local Colors = Unlock:WaitForChild("Colors")
local t = {
    BeamColor = Color3.fromRGB(235, 255, 252),
    BeamGlowColor = Color3.fromRGB(235, 255, 252),
    ShineColor = Color3.fromRGB(220, 255, 250),
    FlashColor = Color3.fromRGB(255, 255, 255)
}
local _ = {
    GrowTime = 0.45,
    HoldTime = 4,
    CloseTime = 0.35,
    Flash = true,
    Shine = true,
    TextStagger = 0.12,
    GridDriftTime = 8,
    GlowImage = "rbxassetid://12820082481",
    LinesImage = "rbxassetid://7262762946",
    EdgeHeight = 40,
    Spread = 7,
    SpawnRate = 7,
    LifeMin = 1.8,
    LifeMax = 3,
    LengthMin = 0.1,
    LengthMax = 0.35,
    ThicknessMin = 1,
    ThicknessMax = 3,
    PuffChance = 0.3,
    LinesSpeed = 1.1,
    LinesTileWidth = 320,
    PreviewInStudio = false
}

local _ = function(arg1) --[[ unlockColor ]] -- line: 89
    -- upvalues:
    --  [1] Colors (copy)
    --  [2] t (copy)

    local attribute = Colors:GetAttribute(arg1)

    if typeof(attribute) == "Color3" then
        return attribute
    end

    return t[arg1]
end

local v6 = StarterGui:FindFirstChild("Notification")

for _, val in { "Window", "NotifyClient", "Unlock", "Colors" } do
    local v8 = v6

    if v8 then
        v8 = v6:FindFirstChild(val)
    end

    v6 = v8
end

if v6 and v6 ~= Colors then
    v6.AttributeChanged:Connect(function(attribute_4) -- line: 104
        -- upvalues:
        --  [1] Colors (copy)
        --  [2] v6 (ref)

        Colors:SetAttribute(attribute_4, v6:GetAttribute(attribute_4))
    end)
end

local New = Random.new()

local _ = function(arg3, arg4, arg5) --[[ newGradient ]] -- line: 112
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Transparency = arg4
    UIGradient.Rotation = arg5
    UIGradient.Parent = arg3

    return UIGradient
end

local function addBeamEdge(arg6, arg7, arg8, arg9) -- line: 121
    -- upvalues:
    --  [1] Colors (copy)
    --  [2] t (copy)
    --  [3] TweenService (copy)
    --  [4] New (copy)

    local v10 = if arg9 ~= 1 then 180 else 0
    local CanvasGroup = Instance.new("CanvasGroup")
    CanvasGroup.Name = arg7
    CanvasGroup.AnchorPoint = Vector2.new(0.5, 0.5)
    CanvasGroup.Position = UDim2.new(0.5, 0, arg8, 0)
    CanvasGroup.Size = UDim2.new(1, 0, 0, 40)
    CanvasGroup.BackgroundTransparency = 1
    CanvasGroup.ZIndex = 6
    local sequence_1 = NumberSequence.new(
        {
            NumberSequenceKeypoint.new(0, 0.1),
            NumberSequenceKeypoint.new(0.35, 0.25),
            NumberSequenceKeypoint.new(0.75, 0.75),
            NumberSequenceKeypoint.new(1, 1)
        }
    )
    local UIGradient_1 = Instance.new("UIGradient")
    UIGradient_1.Transparency = sequence_1
    UIGradient_1.Rotation = v10
    UIGradient_1.Parent = CanvasGroup
    local Glow_ImageLabel = Instance.new("ImageLabel")
    Glow_ImageLabel.Name = "Glow"
    Glow_ImageLabel.BackgroundTransparency = 1
    Glow_ImageLabel.Image = "rbxassetid://12820082481"
    local BeamGlowColor = Colors:GetAttribute("BeamGlowColor")
    Glow_ImageLabel.ImageColor3 = if typeof(BeamGlowColor) == "Color3" then BeamGlowColor else t.BeamGlowColor
    Glow_ImageLabel.ImageTransparency = 0.65
    Glow_ImageLabel.Size = UDim2.new(1.2, 0, 0.7, 0)
    Glow_ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    Glow_ImageLabel.Position = UDim2.fromScale(0.5 - 0.1 * arg9, 0.5)
    Glow_ImageLabel.ZIndex = 1
    Glow_ImageLabel.Parent = CanvasGroup
    TweenService:Create(
        Glow_ImageLabel,
        TweenInfo.new(
            0.9,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.InOut,
            -1,
            true
        ),
        { ImageTransparency = 0.82 }
    ):Play()
    local ImageLabel_1 = Instance.new("ImageLabel")
    ImageLabel_1.Name = "Lines"
    ImageLabel_1.BackgroundTransparency = 1
    ImageLabel_1.Image = "rbxassetid://7262762946"
    local BeamColor = Colors:GetAttribute("BeamColor")
    ImageLabel_1.ImageColor3 = if typeof(BeamColor) == "Color3" then BeamColor else t.BeamColor
    ImageLabel_1.ImageTransparency = 0.45
    ImageLabel_1.ScaleType = Enum.ScaleType.Tile
    ImageLabel_1.TileSize = UDim2.new(0, 320, 1, 0)
    ImageLabel_1.AnchorPoint = Vector2.new(0, 0.5)
    ImageLabel_1.Size = UDim2.new(1, 320, 0, 14)
    ImageLabel_1.ZIndex = 2
    local v15 = if arg9 ~= 1 then 0 else -320
    ImageLabel_1.Position = UDim2.new(0, v15, 0.5, 0)
    ImageLabel_1.Parent = CanvasGroup
    local v16 = TweenService
    local tweenInfo_1 = TweenInfo.new(1.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1)
    local t_3 = { Position = nil }
    local v17 = if arg9 ~= 1 then -320 else 0
    t_3.Position = UDim2.new(0, v17, 0.5, 0)
    v16:Create(ImageLabel_1, tweenInfo_1, t_3):Play()

    local function spawnStreak() -- line: 174
        -- upvalues:
        --  [1] CanvasGroup (copy)
        --  [2] New (ref)
        --  [3] Colors (ref)
        --  [4] t (ref)
        --  [5] v10 (copy)
        --  [6] arg9 (copy)
        --  [7] TweenService (ref)

        if not CanvasGroup.Parent then
            return
        end

        local v18 = New:NextNumber() < 0.3 and true
        local v22 = New:NextNumber(0.1, 0.35) * (if v18 then 1.6 else 1)
        local v19 = if v18 then 1.25 else 1
        local v23 = New:NextNumber(1.8, 3) * v19
        local v24 = New:NextNumber(-7, 7)
        local v25 = nil

        if v18 then
            v25 = Instance.new("ImageLabel")
            v25.Image = "rbxassetid://12820082481"
            local BeamGlowColor_1 = Colors:GetAttribute("BeamGlowColor")
            v25.ImageColor3 = if typeof(BeamGlowColor_1) == "Color3" then BeamGlowColor_1 else t.BeamGlowColor
            v25.ImageTransparency = New:NextNumber(0.45, 0.7)
            v25.BackgroundTransparency = 1
            v25.Size = UDim2.new(v22, 0, 0, New:NextInteger(8, 16))
            v25.ZIndex = 3
        else
            v25 = Instance.new("Frame")
            local BeamColor_1 = Colors:GetAttribute("BeamColor")
            v25.BackgroundColor3 = if typeof(BeamColor_1) == "Color3" then BeamColor_1 else t.BeamColor
            v25.BackgroundTransparency = 0
            v25.BorderSizePixel = 0
            v25.Size = UDim2.new(v22, 0, 0, New:NextInteger(1, 3))
            v25.ZIndex = 4
            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(1, 0)
            UICorner.Parent = v25
            local sequence = NumberSequence.new(
                {
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(0.55, 0.75),
                    NumberSequenceKeypoint.new(0.9, 0.1),
                    NumberSequenceKeypoint.new(0.96, 0),
                    NumberSequenceKeypoint.new(1, 0.6)
                }
            )
            local v29 = v10
            local UIGradient_2 = Instance.new("UIGradient")
            UIGradient_2.Transparency = sequence
            UIGradient_2.Rotation = v29
            UIGradient_2.Parent = v25
        end

        v25.Name = "Streak"
        v25.AnchorPoint = Vector2.new(0.5, 0.5)
        v18 = if arg9 ~= 1 then 1 + v22 / 2 else -v22 / 2 or 1 + v22 / 2
        local v30 = if arg9 ~= 1 then -v22 / 2 else 1 + v22 / 2 or -v22 / 2
        v25.Position = UDim2.new(v18, 0, 0.5, v24)
        v25.Parent = CanvasGroup
        local v32 = TweenService:Create(
            v25,
            TweenInfo.new(v23, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            { Position = UDim2.new(v30, 0, 0.5, v24) }
        )
        v32.Completed:Once(function() -- line: 223
            -- upvalues:
            --  [1] v25 (ref)

            v25:Destroy()
        end)
        v32:Play()
    end

    CanvasGroup.Parent = arg6
    task.spawn(function() -- line: 232
        -- upvalues:
        --  [1] CanvasGroup (copy)
        --  [2] spawnStreak (copy)
        --  [3] New (ref)

        while true do
            if not CanvasGroup.Parent then
                break
            end

            spawnStreak()
            task.wait(New:NextNumber(0.5, 1.5) / 7)
        end
    end)
    task.delay(0.02, spawnStreak)
    task.delay(0.04, spawnStreak)
    task.delay(0.06, spawnStreak)
    task.delay(0.08, spawnStreak)

    return CanvasGroup
end

local t_6 = {
    { "CanvasGroup", { "GroupTransparency" } },
    { "TextLabel", { "BackgroundTransparency", "TextTransparency", "TextStrokeTransparency" } },
    { "ImageLabel", { "BackgroundTransparency", "ImageTransparency" } },
    { "GuiObject", { "BackgroundTransparency" } },
    { "UIStroke", { "Transparency" } },
    { "UIShadow", { "Transparency" } }
}

local function snapshotTransparency(arg10) -- line: 257
    -- upvalues:
    --  [1] t_6 (copy)

    local t_7 = {}
    local Result, Success, t_8

    for _, descendant in arg10:GetDescendants() do
        if not descendant:GetAttribute("NoFade") then
            local v33 = descendant:FindFirstAncestorWhichIsA("CanvasGroup")

            if v33 then
                if not v33:IsDescendantOf(arg10) then
                    for _, val_1 in t_6 do
                        if descendant:IsA(val_1[1]) then
                            t_8 = {}

                            for _, val_2 in val_1[2] do
                                Success, Result = pcall(function() -- line: 271
                                    -- upvalues:
                                    --  [1] descendant (copy)
                                    --  [2] val_2 (copy)

                                    return descendant[val_2]
                                end)

                                if Success then
                                    t_8[val_2] = Result
                                end
                            end

                            t_7[descendant] = t_8
                            break
                        end
                    end
                end
            else
                for _, val_3 in t_6 do
                    if descendant:IsA(val_3[1]) then
                        t_8 = {}

                        for _, val_4 in val_3[2] do
                            Success, Result = pcall(function() -- line: 271
                                -- upvalues:
                                --  [1] descendant (copy)
                                --  [2] val_2 (copy)

                                return descendant[val_2]
                            end)

                            if Success then
                                t_8[val_4] = Result
                            end
                        end

                        t_7[descendant] = t_8
                        break
                    end
                end
            end
        end
    end

    return t_7
end

local _ = function(arg11, arg12, arg13) --[[ setLineText ]] -- line: 286
    local v34 = arg11:FindFirstChild(arg12)
    local Shadow

    if v34 then
        if type(arg13) ~= "string" then
            return
        end

        v34.Text = arg13
        Shadow = v34:FindFirstChild("Shadow")

        if Shadow and Shadow:IsA("TextLabel") then
            Shadow.Text = arg13
        end

        return
    else
        return
    end
end

local function PlayUnlock(arg14) -- line: 302
    -- upvalues:
    --  [1] Unlock (copy)
    --  [2] TweenService (copy)
    --  [3] addBeamEdge (copy)
    --  [4] Colors (copy)
    --  [5] t (copy)
    --  [6] snapshotTransparency (copy)

    local v35 = arg14 or {}
    arg14 = v35
    v35 = arg14.Duration or 4
    local v36 = Unlock:Clone()
    v36.Visible = false
    local Frame = v36:WaitForChild("Frame")
    local Size = v36.Size
    local t_9 = {}
    local Skill = arg14.Skill
    local Skill_1 = Frame:FindFirstChild("Skill")

    if Skill_1 and type(Skill) == "string" then
        Skill_1.Text = Skill
        local Shadow_1 = Skill_1:FindFirstChild("Shadow")

        if Shadow_1 and Shadow_1:IsA("TextLabel") then
            Shadow_1.Text = Skill
        end
    end

    local Title = arg14.Title
    local UnlockedLabel = Frame:FindFirstChild("UnlockedLabel")

    if UnlockedLabel and type(Title) == "string" then
        UnlockedLabel.Text = Title
        local Shadow_2 = UnlockedLabel:FindFirstChild("Shadow")

        if Shadow_2 and Shadow_2:IsA("TextLabel") then
            Shadow_2.Text = Title
        end
    end

    local Description = arg14.Description
    local Description_1 = Frame:FindFirstChild("Description")

    if Description_1 and type(Description) == "string" then
        Description_1.Text = Description
        local Shadow_3 = Description_1:FindFirstChild("Shadow")

        if Shadow_3 and Shadow_3:IsA("TextLabel") then
            Shadow_3.Text = Description
        end
    end

    local v37 = v36:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
    v37.Parent = v36
    local Frame_1 = Instance.new("Frame")
    Frame_1.Name = "OpenFlash"
    Frame_1:SetAttribute("NoFade", true)
    Frame_1.Size = UDim2.fromScale(1, 1)
    Frame_1.BackgroundTransparency = 1
    Frame_1.BorderSizePixel = 0
    Frame_1.ZIndex = 30
    Frame_1.Parent = v36
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "OpenShine"
    Frame_2:SetAttribute("NoFade", true)
    Frame_2.Size = UDim2.fromScale(1, 1)
    Frame_2.BackgroundTransparency = 1
    Frame_2.BorderSizePixel = 0
    Frame_2.ZIndex = 29
    Frame_2.Parent = v36
    local sequence_2 = NumberSequence.new(
        {
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.42, 1),
            NumberSequenceKeypoint.new(0.5, 0.55),
            NumberSequenceKeypoint.new(0.58, 1),
            NumberSequenceKeypoint.new(1, 1)
        }
    )
    local UIGradient_3 = Instance.new("UIGradient")
    UIGradient_3.Transparency = sequence_2
    UIGradient_3.Rotation = 0
    UIGradient_3.Parent = Frame_2
    UIGradient_3.Offset = Vector2.new(-1, 0)
    local Grid = v36:FindFirstChild("Grid")

    if Grid and Grid.ScaleType == Enum.ScaleType.Tile then
        local Offset = Grid.TileSize.X.Offset
        local Frame_3 = Instance.new("Frame")
        Frame_3.Name = "GridClip"
        Frame_3.BackgroundTransparency = 1
        Frame_3.ClipsDescendants = true
        Frame_3.AnchorPoint = Grid.AnchorPoint
        Frame_3.Position = Grid.Position
        Frame_3.Size = Grid.Size
        Frame_3.ZIndex = Grid.ZIndex
        Frame_3.Parent = v36
        Grid.AnchorPoint = Vector2.zero
        Grid.Position = UDim2.new(0, -Offset, 0, 0)
        Grid.Size = UDim2.new(1, Offset, 1, 0)
        Grid.Parent = Frame_3
        TweenService:Create(
            Grid,
            TweenInfo.new(8, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
            { Position = UDim2.new(0, 0, 0, 0) }
        ):Play()
    end

    local t_12 = { addBeamEdge(v36, "BeamTop", 0, -1), (addBeamEdge(v36, "BeamBottom", 1, 1)) }

    local _ = function(arg15, arg16) --[[ setText ]] -- line: 376
        -- upvalues:
        --  [1] Frame (copy)

        local v41 = Frame:FindFirstChild(arg15)

        if v41 then
            v41.TextColor3 = arg16
        end
    end

    local t_13 = {
        FlashColor = nil,
        ShineColor = nil,
        BackgroundColor = nil,
        GridColor = nil,
        SkillTextColor = nil,
        UnlockedTextColor = nil,
        DescriptionTextColor = nil,
        TextStrokeColor = nil,
        BeamColor = nil,
        BeamGlowColor = nil
    }

    function t_13.FlashColor(arg17) -- line: 383
        -- upvalues:
        --  [1] Frame_1 (copy)

        Frame_1.BackgroundColor3 = arg17
    end

    function t_13.ShineColor(arg18) -- line: 384
        -- upvalues:
        --  [1] Frame_2 (copy)

        Frame_2.BackgroundColor3 = arg18
    end

    function t_13.BackgroundColor(arg19) -- line: 385
        -- upvalues:
        --  [1] v36 (copy)

        local UIShadow = v36:FindFirstChildOfClass("UIShadow")

        if UIShadow then
            UIShadow.Color = arg19
        end
    end

    function t_13.GridColor(arg20) -- line: 389
        -- upvalues:
        --  [1] Grid (copy)

        if Grid then
            Grid.ImageColor3 = arg20
        end
    end

    function t_13.SkillTextColor(arg21) -- line: 392
        -- upvalues:
        --  [1] Frame (copy)

        local Skill_2 = Frame:FindFirstChild("Skill")

        if Skill_2 then
            Skill_2.TextColor3 = arg21
        end
    end

    function t_13.UnlockedTextColor(arg22) -- line: 393
        -- upvalues:
        --  [1] Frame (copy)

        local UnlockedLabel_1 = Frame:FindFirstChild("UnlockedLabel")

        if UnlockedLabel_1 then
            UnlockedLabel_1.TextColor3 = arg22
        end
    end

    function t_13.DescriptionTextColor(arg23) -- line: 394
        -- upvalues:
        --  [1] Frame (copy)

        local Description_2 = Frame:FindFirstChild("Description")

        if Description_2 then
            Description_2.TextColor3 = arg23
        end
    end

    function t_13.TextStrokeColor(arg24) -- line: 395
        -- upvalues:
        --  [1] Frame (copy)

        for _, descendant_1 in Frame:GetDescendants() do
            if descendant_1:IsA("UIStroke") then
                descendant_1.Color = arg24
            end
        end
    end

    function t_13.BeamColor(arg25) -- line: 400
        -- upvalues:
        --  [1] t_12 (copy)

        for _, val_5 in t_12 do
            for _, child in val_5:GetChildren() do
                if child.Name == "Lines" then
                    child.ImageColor3 = arg25
                elseif child.Name == "Streak" and child:IsA("Frame") then
                    child.BackgroundColor3 = arg25
                end
            end
        end
    end

    function t_13.BeamGlowColor(arg26) -- line: 411
        -- upvalues:
        --  [1] t_12 (copy)

        for _, val_6 in t_12 do
            for _, child_1 in val_6:GetChildren() do
                if child_1.Name ~= "Glow" then
                    if child_1.Name == "Streak" and child_1:IsA("ImageLabel") then
                        child_1.ImageColor3 = arg26
                    end
                else
                    child_1.ImageColor3 = arg26
                end
            end
        end
    end

    for key_11, val_7 in t_13 do
        local attribute_1 = Colors:GetAttribute(key_11)
        local v42 = if typeof(attribute_1) == "Color3" then attribute_1 else t[key_11]

        if v42 then
            val_7(v42)
        end
    end

    table.insert(t_9, Colors.AttributeChanged:Connect(function(attribute_3) -- line: 427
        -- upvalues:
        --  [1] t_13 (copy)
        --  [2] Colors (ref)
        --  [3] t (ref)

        local v43 = t_13[attribute_3]
        local attribute_2 = Colors:GetAttribute(attribute_3)
        local v44 = if typeof(attribute_2) == "Color3" then attribute_2 else t[attribute_3]

        if v43 and v44 then
            v43(v44)
        end
    end))
    local v45 = snapshotTransparency(v36)
    local t_14 = {}

    for _, val_8 in { "Skill", "UnlockedLabel", "Description" } do
        local v46 = Frame:FindFirstChild(val_8)

        if v46 then
            local t_15 = {}

            for key_13, val_9 in v45 do
                if key_13 ~= v46 then
                    if key_13:IsDescendantOf(v46) then
                        for key_14 in val_9 do
                            key_13[key_14] = 1
                        end

                        table.insert(t_15, key_13)
                    end
                else
                    for key_15 in val_9 do
                        key_13[key_15] = 1
                    end

                    table.insert(t_15, key_13)
                end
            end

            table.insert(t_14, t_15)
        end
    end

    v37.Scale = 0
    v36.Visible = true
    v36.Parent = script.Parent
    TweenService:Create(
        v37,
        TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        { Scale = 1 }
    ):Play()
    Frame_1.BackgroundTransparency = 0.35
    TweenService:Create(
        Frame_1,
        TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { BackgroundTransparency = 1 }
    ):Play()
    Frame_2.BackgroundTransparency = 0
    task.delay(0.27, function() -- line: 467
        -- upvalues:
        --  [1] TweenService (ref)
        --  [2] UIGradient_3 (copy)
        --  [3] Frame_2 (copy)

        local v51 = TweenService:Create(
            UIGradient_3,
            TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            { Offset = Vector2.new(1, 0) }
        )
        v51.Completed:Once(function() -- line: 469
            -- upvalues:
            --  [1] Frame_2 (ref)

            Frame_2.BackgroundTransparency = 1
        end)
        v51:Play()
    end)

    for key_16, val_10 in t_14 do
        task.delay(0.225 + (key_16 - 1) * 0.12, function() -- line: 477
            -- upvalues:
            --  [1] val_10 (copy)
            --  [2] TweenService (ref)
            --  [3] v45 (copy)

            for _, val_11 in val_10 do
                TweenService:Create(
                    val_11,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    v45[val_11]
                ):Play()
            end
        end)
    end

    task.wait(0.45 + v35)
    Frame.ClipsDescendants = true
    local v53 = TweenService
    v53:Create(
        v36,
        TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        { Size = UDim2.new(Size.X.Scale, Size.X.Offset, 0, 0) }
    ):Play()
    task.delay(0.175, function() -- line: 492
        -- upvalues:
        --  [1] v45 (copy)
        --  [2] TweenService (ref)

        for key_18, val_12 in v45 do
            if key_18.Parent then
                local t_18 = {}

                for key_19 in val_12 do
                    t_18[key_19] = 1
                end

                TweenService:Create(key_18, TweenInfo.new(0.175, Enum.EasingStyle.Linear), t_18):Play()
            end
        end
    end)
    task.wait(0.35)

    for _, val_13 in t_9 do
        val_13:Disconnect()
    end

    v36:Destroy()
end

local _ = function(arg28) --[[ QueueUnlock ]] -- line: 513
    -- upvalues:
    --  [1] v5 (copy)
    --  [2] Services_m (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] PlayUnlock (copy)

    v5:Push(function() -- line: 514
        -- upvalues:
        --  [1] Services_m (ref)
        --  [2] ReplicatedStorage (ref)
        --  [3] PlayUnlock (ref)
        --  [4] arg28 (copy)

        Services_m.PlaySound(ReplicatedStorage.SFX.Misc.Unlock, script)
        local Success_1, Result_1 = pcall(PlayUnlock, arg28)

        if not Success_1 then
            warn("[NotifyClient] Skill unlock notification failed:", Result_1)
        end
    end)
end

local function onSkillAdded(arg29) -- line: 524
    -- upvalues:
    --  [1] Skills (copy)
    --  [2] BackpackUtils_m (copy)
    --  [3] v5 (copy)
    --  [4] Services_m (copy)
    --  [5] ReplicatedStorage (copy)
    --  [6] PlayUnlock (copy)

    local Name = arg29.Name
    local v55 = Skills[Name]

    if not v55 then
        return
    end

    local _ = v55.Image or "http://www.roblox.com/asset/?id=3712573417"
    local v57 = v55.Description or ""
    local Skillset = v55.Skillset
    local _ = Color3.new(1, 1, 1)
    local v58 = BackpackUtils_m.SkillColors[string.gsub(Skillset, " Passive", "")]

    if v58 then
        local _ = v55.Color or v58.BackgroundColor
    end

    local t_19 = { Skill = string.upper(Name), Title = "UNLOCKED", Description = v57 }
    v5:Push(function() -- line: 514
        -- upvalues:
        --  [1] Services_m (ref)
        --  [2] ReplicatedStorage (ref)
        --  [3] PlayUnlock (ref)
        --  [4] t_19 (copy)

        Services_m.PlaySound(ReplicatedStorage.SFX.Misc.Unlock, script)
        local Success_2, Result_2 = pcall(PlayUnlock, t_19)

        if not Success_2 then
            warn("[NotifyClient] Skill unlock notification failed:", Result_2)
        end
    end)
end

_G.CreateAlert = AlertNotification_m.new

function _G.CreateSignificantAlert(arg30, arg31) -- line: 552
    -- upvalues:
    --  [1] FlourishNotification_m (copy)

    task.spawn(function() -- line: 553
        -- upvalues:
        --  [1] FlourishNotification_m (ref)
        --  [2] arg30 (copy)
        --  [3] arg31 (copy)

        FlourishNotification_m.new(arg30, arg31):Play(script.Parent.Alerts)
    end)
end

LocalPlayer.Skills.ChildAdded:Connect(onSkillAdded)
LocalPlayer:WaitForChild("ReputationChanged").OnClientEvent:Connect(function(_, arg33, arg34, arg35) -- line: 560
    -- upvalues:
    --  [1] ReputationNotification_m (copy)
    --  [2] v4 (copy)

    local v62 = ReputationNotification_m.new({ Message = arg33, Value = arg34, Increment = arg35 })
    v4:Push(function() -- line: 567
        -- upvalues:
        --  [1] v62 (copy)

        v62:Play(script.Parent)
    end)
end)
local Level = v2:GetStat("Level")
v2:OnStatChanged("Level", function() -- line: 573
    -- upvalues:
    --  [1] v2 (copy)
    --  [2] Level (ref)
    --  [3] FlourishNotification_m (copy)
    --  [4] ReplicatedStorage (copy)
    --  [5] v3 (copy)

    local Level_1 = v2:GetStat("Level")

    if Level_1 > Level then
        local v63 = FlourishNotification_m.new(
            "LEVEL INCREASED",
            ReplicatedStorage.SFX.Misc.LevelUp
        )
        v3:Push(function() -- line: 581
            -- upvalues:
            --  [1] v63 (copy)

            v63:Play(script.Parent.Alerts)
        end)
    end

    Level = Level_1
end)
ReplicatedStorage.Remotes.gameEvents.OnClientEvent:Connect(function(arg36, arg37, arg38) -- line: 589
    -- upvalues:
    --  [1] FlourishNotification_m (copy)
    --  [2] v3 (copy)

    if arg37 == "Significant" then
        local v64 = FlourishNotification_m.new(arg36, arg38)
        v3:Push(function() -- line: 596
            -- upvalues:
            --  [1] v64 (copy)

            v64:Play(script.Parent.Alerts)
        end)

        return
    end

    _G.CreateAlert(arg36, arg38)
end)
InventoryListener_m.new()
