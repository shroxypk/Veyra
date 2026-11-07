-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.EldritchIntroduction.RichText
-- Class: ModuleScript
-- bytes: 31030

local t = { ColorShortcuts = {} }
local t_1 = { Color = "TextColor3", StrokeColor = "TextStrokeColor3", ImageColor = "ImageColor3" }
local Typewriter = script.Parent.typewriter
t.ColorShortcuts.White = Color3.new(1, 1, 1)
t.ColorShortcuts.Black = Color3.new(0, 0, 0)
t.ColorShortcuts.Red = Color3.new(1, 0.4, 0.4)
t.ColorShortcuts.Green = Color3.new(0.4, 1, 0.4)
t.ColorShortcuts.Blue = Color3.new(0.4, 0.4, 1)
t.ColorShortcuts.Cyan = Color3.new(0.4, 0.85, 1)
t.ColorShortcuts.Orange = Color3.new(1, 0.5, 0.2)
t.ColorShortcuts.Yellow = Color3.new(1, 0.9, 0.2)
t.ColorShortcuts.Purple = Color3.new(0.560784, 0.117647, 0.576471)
t.ImageShortcuts = {}
t.ImageShortcuts.Eggplant = 639588687
t.ImageShortcuts.Thinking = 955646496
t.ImageShortcuts.Sad = 947900188
t.ImageShortcuts.Happy = 414889555
t.ImageShortcuts.Despicable = 711674643
local t_2 = {
    ContainerHorizontalAlignment = "Center",
    ContainerVerticalAlignment = "Top",
    TextYAlignment = "Center",
    TextScaled = false,
    TextScaleRelativeTo = "Frame",
    TextScale = 1,
    TextSize = 24,
    Font = Enum.Font.SourceSansSemibold.Name,
    TextColor3 = "White",
    TextStrokeColor3 = "Black",
    TextTransparency = 0,
    TextStrokeTransparency = 0.8,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ImageColor3 = "White",
    ImageTransparency = 0,
    ImageRectOffset = "0,0",
    ImageRectSize = "0,0",
    AnimateStepTime = 0.1,
    AnimateStepGrouping = "Letter",
    AnimateStepFrequency = 4,
    AnimateYield = 0,
    AnimateStyle = "Fade",
    AnimateStyleTime = 0.3,
    AnimateStyleNumPeriods = 3,
    AnimateStyleAmplitude = 0.5
}
local t_3 = {
    Appear = function(arg1) --[[ Appear ]] -- line: 227
        arg1.Visible = true
    end,
    Fade = function(arg2, arg3, arg4) --[[ Fade ]] -- line: 231
        arg2.Visible = true

        if arg2:IsA("TextLabel") then
            arg2.TextTransparency = 1 - arg3 * (1 - arg4.TextTransparency)

            return
        end

        if arg2:IsA("ImageLabel") then
            arg2.ImageTransparency = 1 - arg3 * (1 - arg4.ImageTransparency)
        end
    end,
    Wiggle = function(arg5, arg6, arg7) --[[ Wiggle ]] -- line: 240
        arg5.Visible = true
        local v1 = arg7.InitialSize.Y.Offset * (1 - arg6) * arg7.AnimateStyleAmplitude
        arg5.Position = arg7.InitialPosition + UDim2.new(
            0,
            0,
            0,
            math.sin(arg6 * 3.141592653589793 * 2 * arg7.AnimateStyleNumPeriods) * v1 / 2
        )
    end,
    Swing = function(arg8, arg9, arg10) --[[ Swing ]] -- line: 246
        arg8.Visible = true
        local v2 = 90 * (1 - arg9) * arg10.AnimateStyleAmplitude
        arg8.Rotation = math.sin(arg9 * 3.141592653589793 * 2 * arg10.AnimateStyleNumPeriods) * v2
    end,
    Spin = function(arg11, arg12, arg13) --[[ Spin ]] -- line: 252
        arg11.Visible = true
        arg11.Position = arg13.InitialPosition + UDim2.new(
            0,
            arg13.InitialSize.X.Offset / 2,
            0,
            arg13.InitialSize.Y.Offset / 2
        )
        arg11.AnchorPoint = Vector2.new(0.5, 0.5)
        arg11.Rotation = arg12 * arg13.AnimateStyleNumPeriods * 360
    end,
    Rainbow = function(arg14, arg15, arg16) --[[ Rainbow ]] -- line: 259
        arg14.Visible = true
        local color = Color3.fromHSV(arg15 * arg16.AnimateStyleNumPeriods % 1, 1, 1)

        if arg14:IsA("TextLabel") then
            local v3 = getColorFromString(arg16.TextColor3)
            arg14.TextColor3 = Color3.new(
                color.r + arg15 * (v3.r - color.r),
                color.g + arg15 * (v3.g - color.g),
                color.b + arg15 * (v3.b - color.b)
            )

            return
        end

        local v4 = getColorFromString(arg16.ImageColor3)
        arg14.ImageColor3 = Color3.new(
            color.r + arg15 * (v4.r - color.r),
            color.g + arg15 * (v4.g - color.g),
            color.b + arg15 * (v4.b - color.b)
        )
    end,
    RainbowWiggle = function(arg17, arg18, arg19) --[[ RainbowWiggle ]] -- line: 271
        arg17.Visible = true
        local color_1 = Color3.fromHSV(arg18 * arg19.AnimateStyleNumPeriods % 1, 1, 1)

        if arg17:IsA("TextLabel") then
            local v5 = getColorFromString(arg19.TextColor3)
            arg17.TextColor3 = Color3.new(
                color_1.r + arg18 * (v5.r - color_1.r),
                color_1.g + arg18 * (v5.g - color_1.g),
                color_1.b + arg18 * (v5.b - color_1.b)
            )
            local v6 = arg19.InitialSize.Y.Offset * (1 - arg18) * arg19.AnimateStyleAmplitude
            arg17.Position = arg19.InitialPosition + UDim2.new(
                0,
                0,
                0,
                math.sin(arg18 * 3.141592653589793 * 2 * arg19.AnimateStyleNumPeriods) * v6 / 2
            )

            return
        end

        local v7 = getColorFromString(arg19.ImageColor3)
        arg17.ImageColor3 = Color3.new(
            color_1.r + arg18 * (v7.r - color_1.r),
            color_1.g + arg18 * (v7.g - color_1.g),
            color_1.b + arg18 * (v7.b - color_1.b)
        )
    end
}
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local v8 = 0

function getLayerCollector(arg20) -- line: 291
    if not arg20 then
        return nil
    end

    if arg20:IsA("LayerCollector") then
        return arg20
    end

    if arg20 and arg20.Parent then
        return getLayerCollector(arg20.Parent)
    end

    return nil
end

function shallowCopy(arg21) -- line: 303
    local t_4 = {}

    for key, val in pairs(arg21) do
        t_4[key] = val
    end

    return t_4
end

function getColorFromString(arg22) -- line: 311
    -- upvalues:
    --  [1] t (copy)

    if t.ColorShortcuts[arg22] then
        return t.ColorShortcuts[arg22]
    end

    local v9, v10, v11 = arg22:match("(%d+),(%d+),(%d+)")

    return Color3.fromRGB(v9, v10, v11)
end

function getVector2FromString(arg23) -- line: 320
    local v12, v13 = arg23:match("(%d+),(%d+)")

    return Vector2.new(v12, v13)
end

function setHorizontalAlignment(arg24, arg25) -- line: 325
    if arg25 == "Left" then
        arg24.AnchorPoint = Vector2.new(0, 0)
        arg24.Position = UDim2.new(0, 0, 0, 0)

        return
    end

    if arg25 == "Center" then
        arg24.AnchorPoint = Vector2.new(0.5, 0)
        arg24.Position = UDim2.new(0.5, 0, 0, 0)

        return
    end

    if arg25 == "Right" then
        arg24.AnchorPoint = Vector2.new(1, 0)
        arg24.Position = UDim2.new(1, 0, 0, 0)
    end
end

function t.New(
    _,
    arg27,
    arg28,
    arg29,
    arg30,
    arg31
) -- line: 338
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] t_2 (copy)
    --  [3] TextService (copy)
    --  [4] t (copy)
    --  [5] v8 (ref)
    --  [6] RunService (copy)
    --  [7] t_3 (copy)
    --  [8] Typewriter (copy)

    for _, child in pairs(arg27:GetChildren()) do
        child:Destroy()
    end

    if arg30 == nil then
        arg30 = true
    end

    local v15 = {}
    local t_5 = {}

    if arg31 then
        arg28 = arg31.Text
        arg29 = arg31.StartingProperties
    end

    local t_15 = {}
    local t_6 = {}
    local t_7 = {}
    local v17 = 0
    local v18 = false
    local TextLabel = Instance.new("TextLabel")
    local ImageLabel = Instance.new("ImageLabel")
    local v19 = getLayerCollector(arg27)
    TextLabel.AutoLocalize = false
    local v20 = nil
    local v21 = nil

    local function applyMarkup(arg32, arg33) -- line: 366
        -- upvalues:
        --  [1] t_1 (ref)
        --  [2] t_5 (copy)
        --  [3] v15 (ref)
        --  [4] v20 (ref)
        --  [5] t_15 (copy)
        --  [6] t_2 (ref)
        --  [7] v21 (ref)

        arg32 = t_1[arg32] or arg32

        if arg33 == "/" then
            if t_5[arg32] then
                arg33 = t_5[arg32]
            else
                warn("Attempt to default <" .. arg32 .. "> to value with no default")
            end
        end

        if tonumber(arg33) then
            arg33 = tonumber(arg33)
        else
            arg33 = if arg33 == "false" then arg33 == "true" else if arg33 ~= "true" then arg33 else arg33 == "true"
        end

        v15[arg32] = arg33

        if not v20(arg32, arg33) then
            if arg32 == "ContainerHorizontalAlignment" and t_15[#t_15] then
                setHorizontalAlignment(t_15[#t_15].Container, arg33)
            elseif not t_2[arg32] then
                if arg32 == "Img" then
                    v21(arg33)
                else
                    return false
                end
            end
        end

        return true
    end

    function v20(arg34, arg35, arg36) --[[ applyProperty ]] -- line: 397
        -- upvalues:
        --  [1] TextLabel (copy)
        --  [2] ImageLabel (copy)

        local v22 = nil
        local v23 = false
        local v24 = pairs
        local v25 = if arg36 then { arg36 } or { TextLabel, ImageLabel } else {
            TextLabel,
            ImageLabel
        }

        for _, val_1 in v24(v25) do
            if pcall(function() -- line: 401
                -- upvalues:
                --  [1] v22 (ref)
                --  [2] val_1 (copy)
                --  [3] arg34 (copy)

                v22 = typeof(val_1[arg34])
            end) then
                local _ = pcall(function() -- line: 401
                    -- upvalues:
                    --  [1] v22 (ref)
                    --  [2] val_1 (copy)
                    --  [3] arg34 (copy)

                    v22 = typeof(val_1[arg34])
                end)

                if v22 == "Color3" then
                    val_1[arg34] = getColorFromString(arg35)
                elseif v22 == "Vector2" then
                    val_1[arg34] = getVector2FromString(arg35)
                else
                    val_1[arg34] = arg35
                end

                v23 = true
            end
        end

        return v23
    end

    for key_3, val_2 in pairs(t_2) do
        applyMarkup(key_3, val_2)
        t_5[t_1[key_3] or key_3] = v15[t_1[key_3] or key_3]
    end

    local v27 = arg29 or {}

    for key_4, val_3 in pairs(v27) do
        applyMarkup(key_4, val_3)
        t_5[t_1[key_4] or key_4] = v15[t_1[key_4] or key_4]
    end

    if arg31 then
        v15 = arg31.OverflowPickupProperties

        for key_5, val_4 in pairs(v15) do
            applyMarkup(key_5, val_4)
        end
    end

    local _ = function() --[[ getTextSize ]] -- line: 434
        -- upvalues:
        --  [1] v15 (ref)
        --  [2] v19 (copy)
        --  [3] arg27 (copy)

        if v15.TextScaled == true then
            local v28 = nil
            v28 = if v15.TextScaleRelativeTo ~= "Screen" then if v15.TextScaleRelativeTo ~= "Frame" then v28 else arg27.AbsoluteSize.Y else v19.AbsoluteSize.Y

            return (math.min(v15.TextScale * v28, 100))
        end

        return v15.TextSize
    end

    local v29 = 0

    local function newLine() -- line: 450
        -- upvalues:
        --  [1] t_15 (copy)
        --  [2] v29 (ref)
        --  [3] arg30 (ref)
        --  [4] v15 (ref)
        --  [5] v19 (copy)
        --  [6] arg27 (copy)
        --  [7] v18 (ref)
        --  [8] t_6 (copy)
        --  [9] v17 (ref)

        local v30 = t_15[#t_15]

        if v30 then
            v29 += v30.Size.Y.Offset

            if not arg30 then
                local v31 = v29
                local v33

                if v15.TextScaled == true then
                    local v32 = nil
                    v32 = if v15.TextScaleRelativeTo ~= "Screen" then if v15.TextScaleRelativeTo ~= "Frame" then v32 else arg27.AbsoluteSize.Y else v19.AbsoluteSize.Y
                    v33 = math.min(v15.TextScale * v32, 100)
                else
                    v33 = v15.TextSize
                end

                if v31 + v33 > arg27.AbsoluteSize.Y then
                    v18 = true

                    return
                end
            end
        end

        local Frame = Instance.new("Frame")
        Frame.Name = string.format("Line%03d", #t_15 + 1)
        Frame.Size = UDim2.new(0, 0, 0, 0)
        Frame.BackgroundTransparency = 1
        local Frame_1 = Instance.new("Frame", Frame)
        Frame_1.Name = "Container"
        Frame_1.Size = UDim2.new(0, 0, 0, 0)
        Frame_1.BackgroundTransparency = 1
        setHorizontalAlignment(Frame_1, v15.ContainerHorizontalAlignment)
        Frame.Parent = arg27
        table.insert(t_15, Frame)
        t_6[#t_15] = {}
        v17 = 0
    end

    newLine()

    local _ = function(arg37) --[[ addFrameProperties ]] -- line: 476
        -- upvalues:
        --  [1] t_7 (copy)
        --  [2] v15 (ref)

        t_7[arg37] = shallowCopy(v15)
        t_7[arg37].InitialSize = arg37.Size
        t_7[arg37].InitialPosition = arg37.Position
        t_7[arg37].InitialAnchorPoint = arg37.AnchorPoint
    end

    local function formatLabel(arg38, arg39, arg40, arg41) -- line: 483
        -- upvalues:
        --  [1] t_15 (copy)
        --  [2] v15 (ref)
        --  [3] v17 (ref)
        --  [4] arg27 (copy)
        --  [5] t_6 (copy)
        --  [6] newLine (copy)
        --  [7] t_7 (copy)

        local v35 = t_15[#t_15]
        local str = tostring(v15.TextYAlignment)

        if str == "Top" then
            arg38.Position = UDim2.new(0, v17, 0, 0)
            arg38.AnchorPoint = Vector2.new(0, 0)
        elseif str == "Center" then
            arg38.Position = UDim2.new(0, v17, 0.5, 0)
            arg38.AnchorPoint = Vector2.new(0, 0.5)
        elseif str == "Bottom" then
            arg38.Position = UDim2.new(0, v17, 1, 0)
            arg38.AnchorPoint = Vector2.new(0, 1)
        end

        v17 += arg40

        if v17 > arg27.AbsoluteSize.X and v17 ~= arg40 then
            arg38:Destroy()
            local v36 = t_6[#t_15][#t_6[#t_15]]

            if v36:IsA("TextLabel") and v36.Text == " " then
                v35.Container.Size = UDim2.new(0, v17 - arg40 - v36.Size.X.Offset, 1, 0)
                v36:Destroy()
                table.remove(t_6[#t_15])
            end

            newLine()
            arg41()

            return
        end

        arg38.Size = UDim2.new(0, arg40, 0, arg39)
        v35.Container.Size = UDim2.new(0, v17, 1, 0)
        v35.Size = UDim2.new(1, 0, 0, (math.max(v35.Size.Y.Offset, arg39)))
        arg38.Name = string.format("Group%03d", #t_6[#t_15] + 1)
        arg38.Parent = v35.Container
        table.insert(t_6[#t_15], arg38)
        t_7[arg38] = shallowCopy(v15)
        t_7[arg38].InitialSize = arg38.Size
        t_7[arg38].InitialPosition = arg38.Position
        t_7[arg38].InitialAnchorPoint = arg38.AnchorPoint
        v15.AnimateYield = 0
    end

    local function printText(arg42) -- line: 523
        -- upvalues:
        --  [1] newLine (copy)
        --  [2] v17 (ref)
        --  [3] v15 (ref)
        --  [4] v19 (copy)
        --  [5] arg27 (copy)
        --  [6] TextService (ref)
        --  [7] TextLabel (copy)
        --  [8] t_7 (copy)
        --  [9] formatLabel (ref)
        --  [10] v18 (ref)
        --  [11] printText (ref)

        if arg42 == "\n" then
            newLine()

            return
        end

        if arg42 == " " and v17 == 0 then
            return
        end

        local v38, v39

        if v15.TextScaled == true then
            v38 = nil
            v38 = if v15.TextScaleRelativeTo ~= "Screen" then if v15.TextScaleRelativeTo ~= "Frame" then v38 else arg27.AbsoluteSize.Y else v19.AbsoluteSize.Y
            v39 = math.min(v15.TextScale * v38, 100)
        else
            v39 = v15.TextSize
        end

        v38 = TextService:GetTextSize(
            arg42,
            v39,
            TextLabel.Font,
            Vector2.new(v19.AbsoluteSize.X, v39)
        ).X
        local v42 = TextLabel:Clone()
        v42.TextScaled = false
        v42.TextSize = v39
        v42.Text = arg42
        v42.TextTransparency = 1
        v42.TextStrokeTransparency = 1
        v42.TextWrapped = false
        local v43 = 0
        local v44 = 1

        for key_6, val_5 in utf8.graphemes(arg42) do
            local v45 = string.sub(arg42, key_6, val_5)
            local X = TextService:GetTextSize(
                v45,
                v39,
                TextLabel.Font,
                Vector2.new(v19.AbsoluteSize.X, v39)
            ).X
            local v48 = TextLabel:Clone()
            v48.Text = v45
            v48.TextScaled = false
            v48.TextSize = v39
            v48.Position = UDim2.new(0, v43, 0, 0)
            v48.Size = UDim2.new(0, X + 1, 0, v39)
            v48.Name = string.format("Char%03d", v44)
            v48.Parent = v42
            v48.Visible = false
            t_7[v48] = shallowCopy(v15)
            t_7[v48].InitialSize = v48.Size
            t_7[v48].InitialPosition = v48.Position
            t_7[v48].InitialAnchorPoint = v48.AnchorPoint
            v43 += X
            v44 += 1
        end

        formatLabel(v42, v39, v38, function() -- line: 562
            -- upvalues:
            --  [1] v18 (ref)
            --  [2] printText (ref)
            --  [3] arg42 (copy)

            if not v18 then
                printText(arg42)
            end
        end)
    end

    local function printImage(arg43) -- line: 565
        -- upvalues:
        --  [1] v15 (ref)
        --  [2] v19 (copy)
        --  [3] arg27 (copy)
        --  [4] ImageLabel (copy)
        --  [5] t (ref)
        --  [6] formatLabel (ref)
        --  [7] v18 (ref)
        --  [8] printImage (ref)

        local v50, v51

        if v15.TextScaled == true then
            v50 = nil
            v50 = if v15.TextScaleRelativeTo ~= "Screen" then if v15.TextScaleRelativeTo ~= "Frame" then v50 else arg27.AbsoluteSize.Y else v19.AbsoluteSize.Y
            v51 = math.min(v15.TextScale * v50, 100)
        else
            v51 = v15.TextSize
        end

        v50 = ImageLabel:Clone()

        if t.ImageShortcuts[arg43] then
            v50.Image = typeof(t.ImageShortcuts[arg43]) == "number" and "rbxassetid://" .. t.ImageShortcuts[arg43] or t.ImageShortcuts[arg43]
        else
            v50.Image = "rbxassetid://" .. arg43
        end

        v50.Size = UDim2.new(0, v51, 0, v51)
        v50.Visible = false
        formatLabel(v50, v51, v51, function() -- line: 579
            -- upvalues:
            --  [1] v18 (ref)
            --  [2] printImage (ref)
            --  [3] arg43 (copy)

            if not v18 then
                printImage(arg43)
            end
        end)
    end

    local function printSeries(arg44) -- line: 582
        -- upvalues:
        --  [1] applyMarkup (ref)
        --  [2] printText (ref)

        for _, val_6 in pairs(arg44) do
            local v53, v54 = string.match(val_6, "<(.+)=(.+)>")

            if v53 and v54 then
                if not applyMarkup(v53, v54) then
                    warn("Could not apply markup: ", val_6)
                end
            else
                printText(val_6)
            end
        end
    end

    local v55 = 1
    local v56 = #arg28
    local v57 = {}

    if arg31 then
        v55 = arg31.OverflowPickupIndex
    end

    local v60, v62, v63, v64

    while v55 do
        if not (v55 <= v56) then
            break
        end

        local v58, v59 = string.find(arg28, "<.->", v55)
        local v61
        v60, v61 = string.find(arg28, "[ \t\n]", v55)
        v62 = nil

        if v58 and (v59 and (not v60 or v58 < v60)) then
            v63 = v58
            v64 = v59
        else
            local v65 = v60 or v56 + 1
            v63 = v65
            v65 = v61 or v56 + 1
            v64 = v65
            v62 = true
        end

        v61 = v55 < v63 and string.sub(arg28, v55, v63 - 1) or nil
        v60 = v56 >= v63 and string.sub(arg28, v63, v64) or nil
        table.insert(v57, v61)

        if v62 then
            printSeries(v57)

            if v18 then
                break
            end

            printSeries({ v60 })

            if v18 then
                v55 = v63
                break
            end

            v57 = {}
        else
            table.insert(v57, v60)
        end

        v55 = v64 + 1
    end

    if not v18 then
        printSeries(v57)
    end

    v57 = Instance.new("UIListLayout")
    v57.HorizontalAlignment = v15.ContainerHorizontalAlignment
    v57.VerticalAlignment = v15.ContainerVerticalAlignment
    v57.Parent = arg27
    v57 = 0
    local v69 = arg27.AbsoluteSize.X
    printSeries = 0
    local v70 = pairs
    local v71 = t_15
    local v72

    for _, val_7 in v70(v71) do
        v57 += val_7.Size.Y.Offset
        local Container_2 = val_7.Container
        v62 = nil
        v72 = nil

        if Container_2.AnchorPoint.X == 0 then
            v62 = Container_2.Position.X.Offset
            v72 = Container_2.Size.X.Offset
        elseif Container_2.AnchorPoint.X == 0.5 then
            v62 = val_7.AbsoluteSize.X / 2 - Container_2.Size.X.Offset / 2
            v72 = val_7.AbsoluteSize.X / 2 + Container_2.Size.X.Offset / 2
        elseif Container_2.AnchorPoint.X == 1 then
            v62 = val_7.AbsoluteSize.X - Container_2.Size.X.Offset
            v72 = val_7.AbsoluteSize.X
        end

        v69 = math.min(v69, v62)
        printSeries = math.max(printSeries, v72)
    end

    v8 += 1
    local v73 = false
    local v74 = false
    local v60 = false
    local v75 = "TextAnimation" .. v8
    local t_8 = {}

    local function updateAnimations() -- line: 680
        -- upvalues:
        --  [1] v74 (ref)
        --  [2] t_8 (ref)
        --  [3] v73 (ref)
        --  [4] RunService (ref)
        --  [5] v75 (copy)
        --  [6] t_3 (ref)

        if if not v74 then v73 else #t_8 == 0 or v73 then
            v73 = true
            RunService:UnbindFromRenderStep(v75)
            t_8 = {}

            return
        end

        local now = tick()

        for index = #t_8, 1, -1 do
            local v76 = t_8[index]
            local Settings = v76.Settings
            local v77 = t_3[Settings.AnimateStyle]

            if not v77 then
                warn(
                    "No animation style found for: ",
                    Settings.AnimateStyle,
                    ", defaulting to Appear"
                )
                v77 = t_3.Appear
            end

            local v78 = math.min((now - v76.Start) / Settings.AnimateStyleTime, 1)
            v77(v76.Char, v78, Settings)

            if v78 >= 1 then
                table.remove(t_8, index)
            end
        end
    end

    function v62(arg45) --[[ setFrameToDefault ]] -- line: 705
        -- upvalues:
        --  [1] t_7 (copy)
        --  [2] v20 (ref)

        arg45.Position = t_7[arg45].InitialPosition
        arg45.Size = t_7[arg45].InitialSize
        arg45.AnchorPoint = t_7[arg45].InitialAnchorPoint

        for key_9, val_8 in pairs(t_7[arg45]) do
            v20(key_9, val_8, arg45)
        end
    end

    function v72(arg46, arg47) --[[ setGroupVisible ]] -- line: 714
        -- upvalues:
        --  [1] v62 (copy)

        arg46.Visible = arg47

        for _, child_1 in pairs(arg46:GetChildren()) do
            child_1.Visible = arg47

            if arg47 then
                v62(child_1)
            end
        end

        if arg47 and arg46:IsA("ImageLabel") then
            v62(arg46)
        end
    end

    local function animate(arg48) -- line: 727
        -- upvalues:
        --  [1] v73 (ref)
        --  [2] RunService (ref)
        --  [3] v75 (copy)
        --  [4] updateAnimations (copy)
        --  [5] t_6 (copy)
        --  [6] t_8 (ref)
        --  [7] v60 (ref)
        --  [8] t_7 (copy)
        --  [9] Typewriter (ref)
        --  [10] v74 (ref)

        v73 = false
        RunService:BindToRenderStep(v75, Enum.RenderPriority.Last.Value, updateAnimations)
        local AnimateStepGrouping = nil
        local AnimateStepTime = nil
        local AnimateStepFrequency = nil
        local v83 = nil

        for _, val_9 in pairs(t_6) do
            for _, val_10 in pairs(val_9) do
                val_10.Visible = false

                for _, val_11 in pairs(val_10:GetChildren()) do
                    val_11.Visible = false
                end
            end
        end

        local _ = function(arg49, arg50) --[[ animateCharacter ]] -- line: 743
            -- upvalues:
            --  [1] t_8 (ref)

            local t_9 = { Char = arg49, Settings = arg50, Start = tick() }
            table.insert(t_8, t_9)
        end

        local _ = function() --[[ yield ]] -- line: 747
            -- upvalues:
            --  [1] v60 (ref)
            --  [2] v83 (ref)
            --  [3] AnimateStepFrequency (ref)
            --  [4] AnimateStepTime (ref)

            if not v60 and v83 % AnimateStepFrequency == 0 and AnimateStepTime >= 0 then
                wait(AnimateStepTime > 0 and AnimateStepTime or nil)
            end
        end

        for _, val_12 in pairs(t_6) do
            for _, val_13 in pairs(val_12) do
                local v88 = t_7[val_13]
                v83 = if v88.AnimateStepGrouping ~= AnimateStepGrouping then 0 else if v88.AnimateStepFrequency == AnimateStepFrequency then v83 else 0
                AnimateStepGrouping = v88.AnimateStepGrouping
                AnimateStepTime = v88.AnimateStepTime
                AnimateStepFrequency = v88.AnimateStepFrequency

                if v88.AnimateYield > 0 then
                    Typewriter:Stop()
                    wait(v88.AnimateYield)
                end

                Typewriter:Play()

                if AnimateStepGrouping == "Word" or AnimateStepGrouping == "All" then
                    if val_13:IsA("TextLabel") then
                        val_13.Visible = true

                        for _, val_14 in pairs(val_13:GetChildren()) do
                            local v90 = t_7[val_14]
                            local v91 = t_8
                            local t_10 = { Char = val_14, Settings = v90, Start = tick() }
                            table.insert(v91, t_10)
                        end
                    else
                        local v92 = t_8
                        local t_13 = { Char = val_13, Settings = v88, Start = tick() }
                        table.insert(v92, t_13)
                    end

                    if AnimateStepGrouping == "Word" then
                        v83 += 1

                        if not v60 and v83 % AnimateStepFrequency == 0 and AnimateStepTime >= 0 then
                            wait(AnimateStepTime > 0 and AnimateStepTime or nil)
                        end
                    end
                elseif AnimateStepGrouping == "Letter" then
                    if val_13:IsA("TextLabel") then
                        val_13.Visible = true
                        local Text = val_13.Text
                        Text = 1

                        while true do
                            local v96 = val_13:FindFirstChild(string.format("Char%03d", Text))

                            if not v96 then
                                break
                            end

                            local v97 = t_8
                            local t_11 = { Char = v96, Settings = t_7[v96], Start = tick() }
                            table.insert(v97, t_11)
                            v83 += 1

                            if not v60 and v83 % AnimateStepFrequency == 0 and AnimateStepTime >= 0 then
                                v96 = AnimateStepTime > 0 and AnimateStepTime or nil
                                wait(v96)
                            end

                            if v73 then
                                return
                            end

                            local _ = Text + 1
                        end
                    else
                        local v101 = t_8
                        local t_12 = { Char = val_13, Settings = v88, Start = tick() }
                        table.insert(v101, t_12)
                        local v102 = v83 + 1

                        if not v60 and v102 % AnimateStepFrequency == 0 and AnimateStepTime >= 0 then
                            wait(AnimateStepTime > 0 and AnimateStepTime or nil)
                        end
                    end
                else
                    warn("Invalid step grouping: ", AnimateStepGrouping)
                end

                if v73 then
                    return
                end
            end
        end

        v74 = true

        if arg48 then
            while true do
                if not (#t_8 > 0) then
                    break
                end

                RunService.RenderStepped:Wait()
            end
        end

        Typewriter:Stop()
    end

    local t_14 = {
        Overflown = v18,
        OverflowPickupIndex = v55,
        StartingProperties = arg29,
        OverflowPickupProperties = v15,
        Text = arg28,
        ContentSize = Vector2.new(printSeries - v69, v57)
    }

    if arg31 then
        arg31.NextTextObject = t_14
    end

    function t_14.Animate(arg51, arg52) -- line: 855
        -- upvalues:
        --  [1] animate (copy)

        if arg52 then
            animate()
        else
            task.spawn(animate)
        end

        if arg51.NextTextObject then
            arg51.NextTextObject:Animate(arg52)
        end
    end

    function t_14.Show(arg53, arg54) -- line: 866
        -- upvalues:
        --  [1] v60 (ref)
        --  [2] v73 (ref)
        --  [3] t_6 (copy)
        --  [4] v62 (copy)

        if arg54 then
            v60 = true
        else
            v73 = true

            for _, val_15 in pairs(t_6) do
                for _, val_16 in pairs(val_15) do
                    val_16.Visible = true

                    for _, val_17 in pairs(val_16:GetChildren()) do
                        val_17.Visible = true
                        v62(val_17)
                    end

                    if val_16:IsA("ImageLabel") then
                        v62(val_16)
                    end
                end
            end
        end

        if arg53.NextTextObject then
            arg53.NextTextObject:Show(arg54)
        end
    end

    function t_14.Hide(arg55) -- line: 882
        -- upvalues:
        --  [1] v73 (ref)
        --  [2] t_6 (copy)

        v73 = true

        for _, val_18 in pairs(t_6) do
            for _, val_19 in pairs(val_18) do
                val_19.Visible = false

                for _, val_20 in pairs(val_19:GetChildren()) do
                    val_20.Visible = false
                end
            end
        end

        if arg55.NextTextObject then
            arg55.NextTextObject:Hide()
        end
    end

    return t_14
end

function t.ContinueOverflow(_, arg57, arg58) -- line: 898
    -- upvalues:
    --  [1] t (copy)

    return t:New(
        arg57,
        nil,
        nil,
        false,
        arg58
    )
end

return t
