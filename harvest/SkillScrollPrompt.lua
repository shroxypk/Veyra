-- Decompiled with Veyra harvester
-- Instance: StarterPack.ToolClass.SkillScrollPrompt
-- Class: ModuleScript
-- bytes: 16399

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local SkillEvent = ReplicatedStorage.Remotes.Player.SkillEvent
local color = Color3.fromRGB(225, 225, 225)
local color_1 = Color3.fromRGB(175, 175, 175)
local color_2 = Color3.fromRGB(189, 255, 208)
local color_3 = Color3.fromRGB(255, 133, 133)
local color_4 = Color3.fromRGB(15, 15, 24)
local font = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Bold)
local font_1 = Font.new("rbxasset://fonts/families/Arial.json")
local font_2 = Font.new(
    "rbxasset://fonts/families/Arial.json",
    Enum.FontWeight.Regular,
    Enum.FontStyle.Italic
)

local function make(s1: string, arg1: any, arg2: any) -- line: 29
    local v1 = Instance.new(s1)
    local v2 = arg1 or {}

    for key, val in v2 do
        v1[key] = val
    end

    local v2 = arg2 or {}

    for _, val_1 in v2 do
        val_1.Parent = v1
    end

    return v1
end

local function outline(
    s2: string,
    n1: number,
    u1: Color3,
    n2: number?,
    n3: number?
) -- line: 40
    -- upvalues:
    --  [1] make (copy)

    n3 = n3 or 6

    return (make(
        "ImageLabel",
        {
            Name = "Outline",
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.new(1, n3, 1, n3),
            Image = s2,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(n1, n1, n1, n1),
            ImageColor3 = u1,
            ImageTransparency = n2 or 0,
            ZIndex = 2
        }
    ))
end

local function stroke() -- line: 57
    -- upvalues:
    --  [1] make (copy)

    return (make(
        "UIStroke",
        {
            Thickness = 1.5,
            Color = Color3.new(0, 0, 0),
            ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
        }
    ))
end

local function label(arg3) -- line: 61
    -- upvalues:
    --  [1] color (copy)
    --  [2] font_1 (copy)
    --  [3] make (copy)

    local t_2 = {
        BackgroundTransparency = 1,
        TextColor3 = color,
        FontFace = font_1,
        TextSize = 15,
        RichText = true,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = nil,
        ZIndex = 3
    }
    local v5
    t_2.AutomaticSize, v5 = Enum.AutomaticSize.Y, arg3

    for key_2, val_2 in v5 do
        t_2[key_2] = val_2
    end

    return (make("TextLabel", t_2))
end

local function button(s3: string) -- line: 80
    -- upvalues:
    --  [1] make (copy)
    --  [2] color_4 (copy)
    --  [3] font (copy)
    --  [4] color (copy)
    --  [5] outline (copy)

    local t_3 = {
        AutoButtonColor = true,
        BackgroundColor3 = color_4,
        Size = UDim2.new(0.5, -6, 0, 30),
        FontFace = font,
        TextSize = 18,
        TextColor3 = color,
        Text = s3,
        ZIndex = 3
    }
    local v6 = make
    local t_4 = { CornerRadius = UDim.new(0, 3) }

    return (v6(
        "TextButton",
        t_3,
        {
            make("UICorner", t_4),
            (outline("rbxassetid://100408357904796", 6, Color3.fromRGB(111, 111, 124), 0.6))
        }
    ))
end

local function requirementRow(s4: string, b1: boolean) -- line: 97
    -- upvalues:
    --  [1] make (copy)
    --  [2] color_4 (copy)
    --  [3] outline (copy)
    --  [4] label (copy)
    --  [5] color_2 (copy)
    --  [6] color_3 (copy)

    local t_6 = {
        Name = "Requirement",
        BackgroundColor3 = color_4,
        BackgroundTransparency = 0.3,
        Size = UDim2.new(1, 0, 0, 28),
        ZIndex = 3
    }
    local v10 = make
    local v12 = make("UICorner", { CornerRadius = UDim.new(0, 3) })
    local v14 = outline("rbxassetid://100408357904796", 6, Color3.fromRGB(111, 111, 124), 0.6)
    local t_9 = {
        Name = "Text",
        AutomaticSize = Enum.AutomaticSize.None,
        Position = UDim2.fromOffset(10, 0),
        Size = UDim2.new(1, -20, 1, 0),
        TextWrapped = false,
        TextTruncate = Enum.TextTruncate.AtEnd,
        TextColor3 = nil,
        Text = nil
    }
    local v15 = label
    t_9.TextColor3 = b1 and color_2 or color_3
    t_9.Text = s4

    return (v10("Frame", t_6, { v12, v14, (v15(t_9)) }))
end

local v17 = false

local function close() -- line: 122
    -- upvalues:
    --  [1] LocalPlayer (copy)

    local SkillScrollPrompt = LocalPlayer.PlayerGui:FindFirstChild("SkillScrollPrompt")

    if SkillScrollPrompt then
        SkillScrollPrompt:Destroy()
    end
end

local function open(s5: string, f1: ((...any) -> ...any)?) -- line: 130
    -- upvalues:
    --  [1] v17 (ref)
    --  [2] SkillEvent (copy)
    --  [3] LocalPlayer (copy)
    --  [4] make (copy)
    --  [5] outline (copy)
    --  [6] label (copy)
    --  [7] font (copy)
    --  [8] font_2 (copy)
    --  [9] stroke (copy)
    --  [10] requirementRow (copy)
    --  [11] color_1 (copy)
    --  [12] color_3 (copy)
    --  [13] button (copy)
    --  [14] color_2 (copy)
    --  [15] close (copy)

    local Result

    if v17 then
        return
    end

    v17 = true
    local Success
    Success, Result = pcall(function() -- line: 135
        -- upvalues:
        --  [1] SkillEvent (ref)
        --  [2] s5 (copy)

        return SkillEvent:InvokeServer("ScrollCheck", s5)
    end)
    v17 = false
    local New, Outline, SkillScrollPrompt_1, _, fitPanel, _, t_11, t_12, t_13, t_14, t_15, t_16, t_18, t_19, t_20, t_22, t_23, t_24, t_26, t_27, t_29, t_33, t_34, _

    if Success then
        if type(Result) ~= "table" then
            return
        end

        SkillScrollPrompt_1 = LocalPlayer.PlayerGui:FindFirstChild("SkillScrollPrompt")

        if SkillScrollPrompt_1 then
            SkillScrollPrompt_1:Destroy()
        end

        local v18 = make(
            "ScreenGui",
            {
                Name = "SkillScrollPrompt",
                ResetOnSpawn = true,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                DisplayOrder = 20
            }
        )
        t_11 = {
            Name = "Panel",
            AnchorPoint = nil,
            Position = nil,
            Size = nil,
            BackgroundColor3 = nil,
            BackgroundTransparency = 0.1
        }
        New = Vector2.new
        local v19 = make
        t_11.AnchorPoint = New(0.5, 0.5)
        t_11.Position = UDim2.fromScale(0.5, 0.5)
        t_11.Size = UDim2.new(0.9, 0, 0, 0)
        t_11.BackgroundColor3 = Color3.fromRGB(14, 14, 22)
        t_13 = { MaxSize = Vector2.new(360, math.huge) }
        local v21 = make("UISizeConstraint", t_13)
        t_14 = {
            Name = "Shadow",
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.new(1, 45, 1, 45),
            Image = "http://www.roblox.com/asset/?id=186491278",
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(42, 48, 54, 48),
            ImageTransparency = 0.4,
            ZIndex = 0
        }
        t_12 = {
            v21,
            make("ImageLabel", t_14),
            (outline(
                "rbxassetid://100408357904796",
                6,
                Color3.fromRGB(41, 41, 65),
                0,
                6
            ))
        }
        local v25 = v19("Frame", t_11, t_12)
        v25.Parent = v18
        t_15 = {
            Name = "Content",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            ZIndex = 3
        }
        local v26 = make
        t_16 = {
            PaddingLeft = UDim.new(0, 12),
            PaddingRight = UDim.new(0, 12),
            PaddingTop = UDim.new(0, 12),
            PaddingBottom = UDim.new(0, 12)
        }
        local v28 = make("UIPadding", t_16)
        t_18 = { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }
        local v30 = v26("Frame", t_15, { v28, (make("UIListLayout", t_18)) })
        v30.Parent = v25

        function fitPanel() -- line: 193
            -- upvalues:
            --  [1] v25 (copy)
            --  [2] v30 (copy)

            v25.Size = UDim2.new(0.9, 0, 0, v30.AbsoluteSize.Y)
        end

        v30:GetPropertyChangedSignal("AbsoluteSize"):Connect(fitPanel)
        local v32 = 0

        _ = function(arg4) --[[ add ]] -- line: 199
            -- upvalues:
            --  [1] v32 (ref)
            --  [2] v30 (copy)

            v32 += 1
            arg4.LayoutOrder = v32
            arg4.Parent = v30

            return arg4
        end

        t_19 = {
            Name = "HeaderBox",
            BackgroundColor3 = Color3.fromRGB(89, 101, 107),
            BackgroundTransparency = 0.1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            ZIndex = 3
        }
        local v34 = make
        t_20 = { Rotation = 90, Color = nil }
        local v35 = make
        t_20.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(120, 120, 120))
        local v36 = v35("UIGradient", t_20)
        t_22 = {
            Name = "Grid",
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Image = "rbxassetid://112699988810212",
            ScaleType = Enum.ScaleType.Tile,
            TileSize = UDim2.fromOffset(64, 64),
            ImageTransparency = 0.85,
            ZIndex = 3
        }
        local v38 = make("ImageLabel", t_22)
        local v40 = outline(
            "rbxassetid://125189053531863",
            13,
            Color3.fromRGB(130, 131, 146),
            0,
            5
        )
        t_23 = {
            Name = "Text",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            ZIndex = 3
        }
        local v41 = make
        t_24 = {
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 8),
            PaddingBottom = UDim.new(0, 10)
        }
        local v43 = make("UIPadding", t_24)
        t_26 = { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder }
        local v45 = make("UIListLayout", t_26)
        t_27 = {
            LayoutOrder = 1,
            FontFace = font,
            TextSize = 14,
            TextColor3 = Color3.fromRGB(200, 200, 200),
            Text = "Skill Scroll"
        }
        local v47 = label(t_27, nil)
        local v48 = label({ LayoutOrder = 2, FontFace = font, TextSize = 26, Text = Result.Skill })
        local v49 = label
        t_29 = {
            LayoutOrder = 3,
            FontFace = font_2,
            TextSize = 14,
            TextColor3 = Color3.fromRGB(215, 215, 215),
            Text = nil
        }
        local v51 = type(Result.Description)
        local v52 = Result.Description

        if v51 ~= "string" or not v52 then
            v52 = ""
        end

        t_29.Text = v52
        local v53 = v34(
            "Frame",
            t_19,
            { v36, v38, v40, (v41("Frame", t_23, { v43, v45, v47, v48, (v49(t_29)) })) }
        )
        v32 += 1
        v53.LayoutOrder = v32
        v53.Parent = v30

        for _, child in v53:FindFirstChild("Text"):GetChildren() do
            if child:IsA("TextLabel") then
                stroke().Parent = child
            end
        end

        local v54 = label({ FontFace = font, TextSize = 18, Text = "Requirements" })
        v32 += 1
        v54.LayoutOrder = v32
        v54.Parent = v30
        stroke().Parent = v54
        local v55 = Result.Rows or {}

        for _, val_3 in v55 do
            local v56 = requirementRow(val_3.Text, val_3.Met)
            v32 += 1
            v56.LayoutOrder = v32
            v56.Parent = v30
        end

        local v57 = label(
            {
                FontFace = font_2,
                TextSize = 13,
                TextColor3 = color_1,
                Text = "Insight and Skill Points are spent when you learn it.\nScroll is consumed on use."
            }
        )
        v32 += 1
        v57.LayoutOrder = v32
        v57.Parent = v30
        local v58 = label({ TextSize = 14, TextColor3 = color_3, Text = "", Visible = false })
        v32 += 1
        v58.LayoutOrder = v32
        v58.Parent = v30

        _ = function(s6: string?) --[[ setStatus ]] -- line: 276
            -- upvalues:
            --  [1] v58 (copy)

            v58.Text = s6 or ""
            v58.Visible = s6 ~= nil
        end

        if Result.Known then
            local v60 = `You already know {Result.Skill}.`
            v58.Text = v60 or ""
            v58.Visible = if v60 == nil then false else true
        elseif not Result.CanLearn then
            local _ = color_1
            v58.Text = "You don't meet the requirements yet."
            v58.Visible = true
        end

        t_33 = {
            Name = "Buttons",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 34),
            ZIndex = 3
        }
        local v63 = make
        t_34 = {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 12),
            SortOrder = Enum.SortOrder.LayoutOrder
        }
        local v65 = v63("Frame", t_33, { (make("UIListLayout", t_34)) })
        v32 += 1
        v65.LayoutOrder = v32
        v65.Parent = v30
        local v66 = button("Close")
        v66.Name = "Close"
        v66.LayoutOrder = 1
        v66.Parent = v65
        local v67 = button("Learn")
        v67.Name = "Learn"
        v67.LayoutOrder = 2
        v67.TextColor3 = Result.CanLearn and color_2 or Color3.fromRGB(110, 110, 110)
        local _ = Enum.SortOrder.LayoutOrder
        v67.AutoButtonColor = if Result.CanLearn ~= true then false else true

        if Result.CanLearn then
            Outline = v67:FindFirstChild("Outline")
            Outline.ImageColor3 = Color3.fromRGB(235, 235, 240)
            Outline.ImageTransparency = 0.25
        end

        v67.Parent = v65
        v66.Activated:Connect(close)
        v67.Activated:Connect(function() -- line: 320
            -- upvalues:
            --  [1] v17 (ref)
            --  [2] Result (copy)
            --  [3] SkillEvent (ref)
            --  [4] s5 (copy)
            --  [5] LocalPlayer (ref)
            --  [6] f1 (copy)
            --  [7] v58 (copy)

            if v17 or not Result.CanLearn then
                return
            end

            v17 = true
            local Success_1, Result_1 = pcall(function() -- line: 325
                -- upvalues:
                --  [1] SkillEvent (ref)
                --  [2] s5 (ref)

                return SkillEvent:InvokeServer("ScrollLearn", s5)
            end)
            v17 = false
            local Message

            if Success_1 then
                if type(Result_1) == "table" and Result_1.Learned then
                    local SkillScrollPrompt_2 = LocalPlayer.PlayerGui:FindFirstChild(
                        "SkillScrollPrompt"
                    )

                    if SkillScrollPrompt_2 then
                        SkillScrollPrompt_2:Destroy()
                    end

                    if f1 then
                        f1()

                        return
                    end
                elseif Success_1 and type(Result_1) == "table" and Result_1.Message then
                    Message = Result_1.Message
                    v58.Text = Message or ""
                    local v69 = Message ~= nil
                    v58.Visible = v69
                end

                return
            end

            if Success_1 and type(Result_1) == "table" and Result_1.Message then
                Message = Result_1.Message
                v58.Text = Message or ""
                v58.Visible = Message ~= nil
            end
        end)
        v18.Parent = LocalPlayer.PlayerGui
        v25.Size = UDim2.new(0.9, 0, 0, v30.AbsoluteSize.Y)

        return
    else
        return
    end
end

return { Open = open, Close = close }
