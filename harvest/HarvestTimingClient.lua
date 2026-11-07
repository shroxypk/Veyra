-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.HarvestTimingClient
-- Class: LocalScript
-- bytes: 33294

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local LocalPlayer = Players.LocalPlayer
local HarvestTiming = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("HarvestTiming")
local HarvestTiming_1 = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild(
    "HarvestTiming",
    math.huge
)
local Holder = HarvestTiming_1:WaitForChild("Holder")
Holder.Visible = false
local color = Color3.fromRGB(64, 200, 90)
local color_1 = Color3.fromRGB(255, 205, 70)
local color_2 = Color3.fromRGB(150, 150, 150)
local color_3 = Color3.fromRGB(190, 190, 190)
local color_4 = Color3.fromRGB(10, 20, 10)
local New = NumberSequence.new
local keypoint = NumberSequenceKeypoint.new(0, 0)
local keypoint_1 = NumberSequenceKeypoint.new(0.5, 0)
local v1 = New(
    { keypoint, keypoint_1, NumberSequenceKeypoint.new(0.501, 1), NumberSequenceKeypoint.new(1, 1) }
)
local v2 = nil
local v3 = 0

local _ = function() --[[ hidePrompts ]] -- line: 81
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] ProximityPromptService (copy)

    v3 += 1
    ProximityPromptService.Enabled = false
end

local _ = function() --[[ showPromptsSoon ]] -- line: 86
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] ProximityPromptService (copy)

    v3 += 1
    local v4 = v3
    task.delay(0.6, function() -- line: 90
        -- upvalues:
        --  [1] v4 (copy)
        --  [2] v3 (ref)
        --  [3] ProximityPromptService (ref)

        if v4 == v3 then
            ProximityPromptService.Enabled = true
        end
    end)
end

local _ = function(arg1, arg2, arg3) --[[ inArc ]] -- line: 102
    return arg3 >= (arg1 - arg2) % 1
end

local _ = function(arg4, arg5) --[[ roundPointer ]] -- line: 107
    local v6 = math.max(arg5 - arg4.StartTime, 0)

    return (arg4.StartPos + (arg4.Direction or 1) * arg4.Speed * v6) % 1
end

local _ = function(arg6, arg7, arg8) --[[ attr ]] -- line: 117
    local attribute = arg6:GetAttribute(arg7)

    if typeof(attribute) == typeof(arg8) then
        return attribute
    end

    return arg8
end

local _ = function() --[[ getInteractKey ]] -- line: 127
    -- upvalues:
    --  [1] LocalPlayer (copy)

    local v8 = LocalPlayer:FindFirstChild("Binds")
    local v9 = v8

    if v9 then
        v9 = v8:FindFirstChild("Interact")
    end

    v8 = v9

    if v8 then
        v8 = if v9.Value ~= "" then Enum.KeyCode:FromName(v9.Value) else false
    end

    return v8 or Enum.KeyCode.E
end

local _ = function(arg9) --[[ radiusOf ]] -- line: 136
    local Offset = arg9.Size.X.Offset

    if Offset > 0 then
        return Offset / 2
    end

    return arg9.AbsoluteSize.X / 2
end

local function ringBlock(
    arg10,
    arg11,
    arg12,
    arg13,
    arg14,
    arg15,
    arg16,
    arg17,
    arg18
) -- line: 150
    local v11 = math.rad(arg13)
    local Frame = Instance.new("Frame")
    Frame.Name = arg11
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.Position = UDim2.fromScale(
        0.5 + math.sin(v11) * arg12 / arg18,
        0.5 - math.cos(v11) * arg12 / arg18
    )
    Frame.Size = UDim2.fromScale(arg14 / arg18, arg15 / arg18)
    Frame.Rotation = arg13
    Frame.BackgroundColor3 = arg16
    Frame.BorderSizePixel = 0
    Frame.ZIndex = arg17
    Frame.Parent = arg10

    return Frame
end

local function zoneGroup(arg19, arg20, arg21) -- line: 168
    local Frame_1 = Instance.new("Frame")
    Frame_1.Name = arg20
    Frame_1.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame_1.Position = UDim2.fromScale(0.5, 0.5)
    Frame_1.Size = UDim2.fromScale(1, 1)
    Frame_1.BackgroundTransparency = 1
    Frame_1.BorderSizePixel = 0
    Frame_1.ZIndex = arg21
    Frame_1.Parent = arg19

    return Frame_1
end

local function drawArc(
    arg22,
    arg23,
    arg24,
    arg25,
    arg26,
    arg27,
    arg28,
    arg29
) -- line: 187
    -- upvalues:
    --  [1] ringBlock (copy)

    local v13 = arg23 + arg26 / 2
    local v14 = arg25 * 360
    local v15 = arg24 * 360
    local v16 = 6.283185307179586 * v13 / 360 + 0.5
    local v17 = math.deg(v16 / 2 / v13)
    local v18 = v14 - v17 * 2

    if v18 <= 0 then
        ringBlock(
            arg22,
            "Segment",
            arg23,
            v15 + v14 / 2,
            6.283185307179586 * v13 * (v14 / 360),
            arg26,
            arg27,
            arg28,
            arg29
        )

        return
    end

    local v19 = math.ceil(v18) + 1

    for index = 0, v19 - 1 do
        ringBlock(
            arg22,
            "Segment",
            arg23,
            v15 + v17 + v18 * (index / (v19 - 1)),
            v16,
            arg26,
            arg27,
            arg28,
            arg29
        )
    end
end

local _ = function(
    arg30,
    arg31,
    arg32,
    arg33,
    arg34,
    arg35,
    arg36,
    arg37
) --[[ drawDivider ]] -- line: 212
    -- upvalues:
    --  [1] ringBlock (copy)

    ringBlock(
        arg30,
        "Divider",
        arg31,
        arg32 * 360,
        arg33,
        arg34 + 2,
        arg35,
        arg36,
        arg37
    )
end

local t_1 = { Preview = true, GreenZone = true, CritZone = true, Dividers = true }

local function clearDrawn(arg38) -- line: 221
    -- upvalues:
    --  [1] t_1 (copy)

    for _, child in arg38:GetChildren() do
        if t_1[child.Name] then
            child:Destroy()
        end
    end
end

local function collectPointerParts(arg39) -- line: 230
    local t_2 = {}

    for _, descendant in arg39:GetDescendants() do
        if not descendant:IsA("ImageLabel") then
            if descendant:IsA("ImageButton") then
                table.insert(
                    t_2,
                    { inst = descendant, prop = "ImageColor3", color = descendant.ImageColor3 }
                )
            elseif descendant:IsA("GuiObject") and descendant.BackgroundTransparency < 1 then
                table.insert(
                    t_2,
                    {
                        inst = descendant,
                        prop = "BackgroundColor3",
                        color = descendant.BackgroundColor3
                    }
                )
            end
        else
            table.insert(
                t_2,
                { inst = descendant, prop = "ImageColor3", color = descendant.ImageColor3 }
            )

            if descendant:IsA("GuiObject") and descendant.BackgroundTransparency < 1 then
                table.insert(
                    t_2,
                    {
                        inst = descendant,
                        prop = "BackgroundColor3",
                        color = descendant.BackgroundColor3
                    }
                )
            end
        end
    end

    return t_2
end

local function outlineBand(arg40) -- line: 274
    local Offset_1 = arg40.Size.X.Offset
    local v20 = if not (Offset_1 > 0) then arg40.AbsoluteSize.X / 2 else Offset_1 / 2
    local UIStroke = arg40:FindFirstChildOfClass("UIStroke")

    if not UIStroke then
        return v20, 9
    end

    local Thickness = UIStroke.Thickness
    local v22 = "Outer"
    pcall(function() -- line: 286
        -- upvalues:
        --  [1] v22 (ref)
        --  [2] UIStroke (copy)

        v22 = UIStroke.BorderStrokePosition.Name
    end)

    if v22 == "Center" then
        return v20, Thickness
    end

    if v22 == "Inner" then
        return v20 - Thickness / 2, Thickness
    end

    return v20 + Thickness / 2, Thickness
end

local _ = function(arg41) --[[ healthGradient ]] -- line: 300
    -- upvalues:
    --  [1] v1 (copy)

    local UIGradient = arg41:FindFirstChildWhichIsA("UIGradient", true)

    if UIGradient then
        UIGradient.Transparency = v1
    end

    return UIGradient
end

local function buildGui(arg42) -- line: 308
    -- upvalues:
    --  [1] Holder (copy)
    --  [2] outlineBand (copy)
    --  [3] UserInputService (copy)
    --  [4] LocalPlayer (copy)
    --  [5] color_1 (copy)
    --  [6] color (copy)
    --  [7] color_3 (copy)
    --  [8] v1 (copy)
    --  [9] clearDrawn (copy)
    --  [10] HarvestTiming_1 (copy)
    --  [11] color_4 (copy)
    --  [12] collectPointerParts (copy)
    --  [13] color_2 (copy)

    local v23 = Holder:Clone()
    v23.Name = "Session"
    local Ring = v23.Ring
    local Outline = Ring.Outline
    local Zones = Outline.Zones
    local v24, v25 = outlineBand(Outline)
    local Health = Ring.Health
    local Spinner = Ring.Spinner
    local Result = v23.Result
    local Title = v23.Title
    local Power = Ring.Power
    Title.Text = tostring(arg42.Title or "")
    local Hint = v23:FindFirstChild("Hint")
    local v28

    if Hint and Hint:IsA("TextLabel") then
        local v26 = UserInputService:GetLastInputType()

        if v26 == Enum.UserInputType.Touch then
            Hint.Visible = false
        elseif string.find(v26.Name, "Gamepad") then
            local GamepadText = Hint:GetAttribute("GamepadText")
            Hint.Text = if typeof(GamepadText) == "string" then GamepadText else "Press <font color='#ff5959'><b>B</b></font> to cancel"
        else
            v28 = LocalPlayer:FindFirstChild("Binds")
            local v29 = v28

            if v29 then
                v29 = v28:FindFirstChild("Interact")
            end

            v28 = v29

            if v28 then
                v28 = if v29.Value ~= "" then Enum.KeyCode:FromName(v29.Value) else false
            end

            local v27 = v28 or Enum.KeyCode.E
            v28 = UserInputService:GetStringForKeyCode(v27)

            if v28 == "" then
                v28 = v27.Name
            end

            Hint.Text = string.gsub(Hint.Text, "<b>E</b>", "<b>" .. v28 .. "</b>")
        end
    end

    local t_5 = {
        TextTransparency = Result.TextTransparency,
        TextStrokeTransparency = Result.TextStrokeTransparency,
        Colors = nil
    }
    local t_6 = { Critical = nil, Hit = nil, Miss = nil }
    v28 = color_1
    local CriticalColor = Result:GetAttribute("CriticalColor")
    local v30 = typeof(CriticalColor)
    t_6.Critical = if v30 == typeof(v28) then CriticalColor else v28
    local v31 = color
    local HitColor = Result:GetAttribute("HitColor")
    local v32 = typeof(HitColor)
    t_6.Hit = if v32 == typeof(v31) then HitColor else v31
    local v33 = color_3
    local MissColor = Result:GetAttribute("MissColor")
    local v34 = typeof(MissColor)
    t_6.Miss = if v34 == typeof(v33) then MissColor else v33
    t_5.Colors = t_6
    Result.Text = ""
    local UIGradient_1 = Health.Right:FindFirstChildWhichIsA("UIGradient", true)

    if UIGradient_1 then
        UIGradient_1.Transparency = v1
    end

    local UIGradient_2 = Health.Left:FindFirstChildWhichIsA("UIGradient", true)

    if UIGradient_2 then
        UIGradient_2.Transparency = v1
    end

    clearDrawn(Zones)
    Zones.Visible = false
    local v35 = Zones:Clone()
    v23.Visible = true
    v23.Parent = HarvestTiming_1
    local t_7 = {
        gui = v23,
        ring = Ring,
        zones = Zones,
        zonesBlank = v35,
        zoneStyle = nil,
        spinner = nil,
        pointerParts = nil,
        pointerMissColor = nil,
        healthRight = nil,
        healthLeft = nil,
        power = nil,
        result = nil,
        resultStyle = nil,
        follow = nil,
        followOffset = nil
    }
    local t_8 = {
        Radius = v24,
        FrameSize = nil,
        Thickness = nil,
        GreenColor = nil,
        CritColor = nil,
        DividerColor = nil,
        DividerWidth = nil
    }
    local Offset_2 = Outline.Size.X.Offset
    t_8.FrameSize = (if Offset_2 > 0 then Offset_2 / 2 else Outline.AbsoluteSize.X / 2) * 2
    local Thickness_1 = Zones:GetAttribute("Thickness")
    local v37 = typeof(Thickness_1)
    t_8.Thickness = if v37 == typeof(v25) then Thickness_1 else v25
    local v39 = color
    local GreenColor = Zones:GetAttribute("GreenColor")
    local v40 = typeof(GreenColor)
    t_8.GreenColor = if v40 == typeof(v39) then GreenColor else v39
    local v41 = color_1
    local CritColor = Zones:GetAttribute("CritColor")
    local v42 = typeof(CritColor)
    t_8.CritColor = if v42 == typeof(v41) then CritColor else v41
    local v43 = color_4
    local DividerColor = Zones:GetAttribute("DividerColor")
    local v44 = typeof(DividerColor)
    t_8.DividerColor = if v44 == typeof(v43) then DividerColor else v43
    local DividerWidth = Zones:GetAttribute("DividerWidth")
    t_8.DividerWidth = if typeof(DividerWidth) == "number" then DividerWidth else 1
    t_7.zoneStyle = t_8
    t_7.spinner = Spinner
    t_7.pointerParts = collectPointerParts(Spinner)
    local v45 = color_2
    local MissColor_1 = Spinner:GetAttribute("MissColor")
    local v46 = typeof(MissColor_1)
    t_7.pointerMissColor = if v46 == typeof(v45) then MissColor_1 else v45
    t_7.healthRight = UIGradient_1
    t_7.healthLeft = UIGradient_2
    t_7.power = Power
    t_7.result = Result
    t_7.resultStyle = t_5
    local FollowCharacter = v23:GetAttribute("FollowCharacter")
    t_7.follow = if typeof(FollowCharacter) == "boolean" then FollowCharacter else false
    local FollowOffset = v23:GetAttribute("FollowOffset")
    local v48 = typeof(FollowOffset)
    t_7.followOffset = if v48 == typeof(Vector3.new(0, 0, 0)) then FollowOffset else Vector3.new(0, 0, 0)

    return t_7
end

local function followCharacter(arg43) -- line: 404
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] HarvestTiming_1 (copy)

    local Ui = arg43.ui

    if not Ui.follow then
        return
    end

    local Character = LocalPlayer.Character
    local v49 = Character

    if v49 then
        v49 = Character:FindFirstChild("HumanoidRootPart")
    end

    local CurrentCamera = workspace.CurrentCamera

    if not v49 or not CurrentCamera then
        return
    end

    local v50 = v49.Position + Ui.followOffset
    local v51, v52

    if HarvestTiming_1.IgnoreGuiInset then
        v51, v52 = CurrentCamera:WorldToViewportPoint(v50)
    else
        v51, v52 = CurrentCamera:WorldToScreenPoint(v50)
    end

    if not v52 then
        return
    end

    v52 = Ui.gui
    local v53 = Ui.ring.AbsolutePosition + Ui.ring.AbsoluteSize / 2 - (v52.AbsolutePosition + v52.AbsoluteSize * v52.AnchorPoint)
    v52.Position = UDim2.fromOffset(math.round(v51.X - v53.X), (math.round(v51.Y - v53.Y)))
end

local _ = function(arg44, arg45) --[[ setPointer ]] -- line: 443
    arg44.ui.spinner.Rotation = arg45 % 1 * 360
end

local _ = function(arg46, arg47) --[[ setPointerMissed ]] -- line: 448
    local Ui_1 = arg46.ui

    for _, val in Ui_1.pointerParts do
        val.inst[val.prop] = arg47 and Ui_1.pointerMissColor or val.color
    end
end

local _ = function(arg48, arg49) --[[ setZonesVisible ]] -- line: 455
    arg48.ui.zones.Visible = arg49
end

local function placeZones(arg50, arg51) -- line: 459
    -- upvalues:
    --  [1] clearDrawn (copy)
    --  [2] zoneGroup (copy)
    --  [3] drawArc (copy)
    --  [4] ringBlock (copy)

    local Ui_2 = arg50.ui
    local Zones_1 = Ui_2.zones
    local ZoneStyle = Ui_2.zoneStyle
    clearDrawn(Zones_1)
    drawArc(
        zoneGroup(Zones_1, "GreenZone", 3),
        ZoneStyle.Radius,
        arg51.GreenStart,
        arg51.GreenSize,
        ZoneStyle.Thickness,
        ZoneStyle.GreenColor,
        3,
        ZoneStyle.FrameSize
    )
    drawArc(
        zoneGroup(Zones_1, "CritZone", 4),
        ZoneStyle.Radius,
        arg51.RedStart,
        arg51.RedSize,
        ZoneStyle.Thickness,
        ZoneStyle.CritColor,
        4,
        ZoneStyle.FrameSize
    )
    local v56 = zoneGroup(Zones_1, "Dividers", 6)

    for _, val_1 in {
        arg51.GreenStart,
        arg51.GreenStart + arg51.GreenSize,
        arg51.RedStart,
        arg51.RedStart + arg51.RedSize
    } do
        ringBlock(
            v56,
            "Divider",
            ZoneStyle.Radius,
            val_1 % 1 * 360,
            ZoneStyle.DividerWidth,
            ZoneStyle.Thickness + 2,
            ZoneStyle.DividerColor,
            6,
            ZoneStyle.FrameSize
        )
    end
end

local function popZones(arg52, arg53) -- line: 483
    -- upvalues:
    --  [1] TweenService (copy)

    if arg53 then
        if arg53.popped then
            return
        end

        arg53.popped = true
    end

    local Ui_3 = arg52.ui
    local Zones_2 = Ui_3.zones
    local UIScale, tweenInfo

    if Zones_2.Visible then
        if not Zones_2:FindFirstChild("GreenZone") then
            Zones_2.Visible = false

            return
        end

        local v57 = Ui_3.zonesBlank:Clone()
        v57.Parent = Zones_2.Parent
        Ui_3.zones = v57
        Zones_2.Name = "ZonesPop"
        tweenInfo = TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

        for _, descendant_1 in Zones_2:GetDescendants() do
            if descendant_1.Name == "Segment" or descendant_1.Name == "Divider" then
                TweenService:Create(descendant_1, tweenInfo, { BackgroundTransparency = 1 }):Play()
            end
        end

        UIScale = Instance.new("UIScale")
        UIScale.Parent = Zones_2
        TweenService:Create(UIScale, tweenInfo, { Scale = 1.3 }):Play()
        task.delay(0.33, function() -- line: 517
            -- upvalues:
            --  [1] Zones_2 (copy)

            Zones_2:Destroy()
        end)

        return
    else
        Zones_2.Visible = false

        return
    end
end

local _ = function(arg54, arg55) --[[ drawHealth ]] -- line: 527
    local Ui_4 = arg54.ui
    local v58 = (1 - math.clamp(arg55, 0, 1)) * 360

    if Ui_4.healthRight then
        Ui_4.healthRight.Rotation = math.min(v58, 180) + 180
    end

    if Ui_4.healthLeft then
        Ui_4.healthLeft.Rotation = math.max(v58, 180) + 180
    end
end

local _ = function(arg56, arg57) --[[ setHealth ]] -- line: 540
    if typeof(arg57) ~= "number" then
        return
    end

    arg56.healthTarget = math.clamp(arg57, 0, 1)

    if not arg56.healthShown then
        arg56.healthShown = arg56.healthTarget
        local Ui_5 = arg56.ui
        local v59 = (1 - math.clamp(arg56.healthShown, 0, 1)) * 360

        if Ui_5.healthRight then
            Ui_5.healthRight.Rotation = math.min(v59, 180) + 180
        end

        if Ui_5.healthLeft then
            Ui_5.healthLeft.Rotation = math.max(v59, 180) + 180
        end
    end
end

local _ = function(arg58, arg59) --[[ stepHealth ]] -- line: 555
    local HealthTarget = arg58.healthTarget
    local v60 = arg58.healthShown

    if not HealthTarget or not v60 or v60 == HealthTarget then
        return
    end

    v60 += (HealthTarget - v60) * math.min(arg59 * 12, 1)

    if math.abs(HealthTarget - v60) < 0.002 then
        v60 = HealthTarget
    end

    arg58.healthShown = v60
    local Ui_6 = arg58.ui
    local v62 = (1 - math.clamp(v60, 0, 1)) * 360

    if Ui_6.healthRight then
        Ui_6.healthRight.Rotation = math.min(v62, 180) + 180
    end

    if Ui_6.healthLeft then
        Ui_6.healthLeft.Rotation = math.max(v62, 180) + 180
    end
end

local _ = function(arg60, arg61) --[[ setMomentum ]] -- line: 571
    if typeof(arg61) ~= "number" then
        return
    end

    arg60.ui.power.Text = string.format("x%.2f", 1 + arg61 * (arg60.data.DamagePerMomentum or 0))
end

local _ = function(arg62, arg63, arg64) --[[ setResultText ]] -- line: 582
    local Result_1 = arg62.ui.result
    local ResultStyle = arg62.ui.resultStyle
    arg62.resultToken = (arg62.resultToken or 0) + 1
    Result_1.Text = arg63
    Result_1.TextColor3 = arg64
    Result_1.TextTransparency = ResultStyle.TextTransparency
    Result_1.TextStrokeTransparency = ResultStyle.TextStrokeTransparency

    return arg62.resultToken
end

local _ = function(arg65) --[[ clearResult ]] -- line: 597
    local Result_2 = arg65.ui.result
    local ResultStyle_1 = arg65.ui.resultStyle
    local TextColor3 = arg65.ui.result.TextColor3
    arg65.resultToken = (arg65.resultToken or 0) + 1
    Result_2.Text = ""
    Result_2.TextColor3 = TextColor3
    Result_2.TextTransparency = ResultStyle_1.TextTransparency
    Result_2.TextStrokeTransparency = ResultStyle_1.TextStrokeTransparency
    local _ = arg65.resultToken
end

local t_9 = { Critical = "CRITICAL!", Hit = "HIT", Miss = "MISS" }

local function showResult(arg66, arg67) -- line: 601
    -- upvalues:
    --  [1] t_9 (copy)
    --  [2] TweenService (copy)

    local v63 = t_9[arg67]

    if not v63 then
        return
    end

    local Result_3 = arg66.ui.result
    local Result_4 = arg66.ui.result
    local ResultStyle_2 = arg66.ui.resultStyle
    local v64 = arg66.ui.resultStyle.Colors[arg67]
    arg66.resultToken = (arg66.resultToken or 0) + 1
    Result_4.Text = v63
    Result_4.TextColor3 = v64
    Result_4.TextTransparency = ResultStyle_2.TextTransparency
    Result_4.TextStrokeTransparency = ResultStyle_2.TextStrokeTransparency
    local ResultToken_1 = arg66.resultToken
    task.delay(0.45, function() -- line: 611
        -- upvalues:
        --  [1] arg66 (copy)
        --  [2] ResultToken_1 (copy)
        --  [3] Result_3 (copy)
        --  [4] TweenService (ref)

        if arg66.resultToken == ResultToken_1 and Result_3.Parent then
            TweenService:Create(
                Result_3,
                TweenInfo.new(0.2),
                { TextTransparency = 1, TextStrokeTransparency = 1 }
            ):Play()
        end
    end)
end

local function close(arg68, arg69) -- line: 622
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] ContextActionService (copy)
    --  [3] v3 (ref)
    --  [4] ProximityPromptService (copy)

    if arg68.closed then
        return
    end

    arg68.closed = true

    if arg68.connection then
        arg68.connection:Disconnect()
        arg68.connection = nil
    end

    if arg68.healthTarget then
        arg68.healthShown = arg68.healthTarget
        local Ui_7 = arg68.ui
        local v67 = (1 - math.clamp(arg68.healthShown, 0, 1)) * 360

        if Ui_7.healthRight then
            Ui_7.healthRight.Rotation = math.min(v67, 180) + 180
        end

        if Ui_7.healthLeft then
            Ui_7.healthLeft.Rotation = math.max(v67, 180) + 180
        end
    end

    if v2 == arg68 then
        v2 = nil
        ContextActionService:UnbindAction("HarvestTimingPress")
        ContextActionService:UnbindAction("HarvestTimingCancel")
        v3 += 1
        local v68 = v3
        task.delay(0.6, function() -- line: 90
            -- upvalues:
            --  [1] v68 (copy)
            --  [2] v3 (ref)
            --  [3] ProximityPromptService (ref)

            if v68 == v3 then
                ProximityPromptService.Enabled = true
            end
        end)
    end

    task.delay(arg69 or 0, function() -- line: 646
        -- upvalues:
        --  [1] arg68 (copy)

        arg68.ui.gui:Destroy()
    end)
end

local function onPress(_, arg71) -- line: 651
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] HarvestTiming (copy)
    --  [3] popZones (copy)
    --  [4] showResult (copy)

    local v69 = v2
    local v70 = v69 and v69.round

    if arg71 ~= Enum.UserInputState.Begin or not v70 or v70.pressed then
        return Enum.ContextActionResult.Sink
    end

    local v71 = workspace:GetServerTimeNow()

    if v71 < v70.StartTime then
        return Enum.ContextActionResult.Sink
    end

    v70.pressed = true
    v69.lastHeard = os.clock()
    local v72 = v70.drawnTime or v70.StartTime
    local v73 = math.clamp(v72, v70.StartTime, v71)
    local v74 = (v70.StartPos + (v70.Direction or 1) * v70.Speed * math.max(v73 - v70.StartTime, 0)) % 1
    v69.ui.spinner.Rotation = v74 % 1 * 360
    HarvestTiming:FireServer(v70.Id, v73)
    local v75 = v69.data.GreenGrace or 0
    local v76 = v69.data.RedGrace or 0
    local v77 = v70.RedSize + 2 * v76 >= (v74 - (v70.RedStart - v76)) % 1 and true
    v76 = v70.GreenSize + 2 * v75 >= (v74 - (v70.GreenStart - v75)) % 1

    if v77 or v76 then
        popZones(v69, v70)
        showResult(v69, if not v77 then "Hit" else "Critical")
    else
        local Ui_8 = v69.ui

        for _, val_2 in Ui_8.pointerParts do
            local v81 = Ui_8.pointerMissColor or val_2.color
            val_2.inst[val_2.prop] = v81
        end

        showResult(v69, "Miss")
    end

    return Enum.ContextActionResult.Sink
end

local function onCancel(_, arg73) -- line: 702
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] HarvestTiming (copy)
    --  [3] close (copy)

    local v82 = v2

    if arg73 ~= Enum.UserInputState.Begin or not v82 then
        return Enum.ContextActionResult.Sink
    end

    HarvestTiming:FireServer("Cancel")
    close(v82, 0)

    return Enum.ContextActionResult.Sink
end

local function open(arg74) -- line: 715
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] close (copy)
    --  [3] buildGui (copy)
    --  [4] v3 (ref)
    --  [5] ProximityPromptService (copy)
    --  [6] followCharacter (copy)
    --  [7] RunService (copy)
    --  [8] placeZones (copy)
    --  [9] ContextActionService (copy)
    --  [10] onPress (copy)
    --  [11] onCancel (copy)
    --  [12] LocalPlayer (copy)

    if v2 then
        close(v2, 0)
    end

    local t_10 = {
        id = arg74.Session,
        data = arg74,
        ui = buildGui(arg74),
        round = nil,
        closed = false,
        connection = nil,
        lastHeard = os.clock()
    }
    v2 = t_10
    v3 += 1
    ProximityPromptService.Enabled = false
    followCharacter(t_10)
    t_10.ui.power.Text = string.format("x%.2f", 1 + 0 * (t_10.data.DamagePerMomentum or 0))
    local v83 = arg74.Health or 1

    if typeof(v83) == "number" then
        t_10.healthTarget = math.clamp(v83, 0, 1)

        if not t_10.healthShown then
            t_10.healthShown = t_10.healthTarget
            local Ui_9 = t_10.ui
            local v84 = (1 - math.clamp(t_10.healthShown, 0, 1)) * 360

            if Ui_9.healthRight then
                Ui_9.healthRight.Rotation = math.min(v84, 180) + 180
            end

            if Ui_9.healthLeft then
                Ui_9.healthLeft.Rotation = math.max(v84, 180) + 180
            end
        end
    end

    t_10.connection = RunService.RenderStepped:Connect(function(deltaTime) -- line: 736
        -- upvalues:
        --  [1] t_10 (copy)
        --  [2] followCharacter (ref)
        --  [3] placeZones (ref)
        --  [4] close (ref)

        local Round = t_10.round
        followCharacter(t_10)
        local v85 = t_10
        local HealthTarget_1 = v85.healthTarget
        local v86 = v85.healthShown

        if HealthTarget_1 and v86 and v86 ~= HealthTarget_1 then
            v86 += (HealthTarget_1 - v86) * math.min(deltaTime * 12, 1)

            if math.abs(HealthTarget_1 - v86) < 0.002 then
                v86 = HealthTarget_1
            end

            v85.healthShown = v86
            local Ui_10 = v85.ui
            local v88 = (1 - math.clamp(v86, 0, 1)) * 360

            if Ui_10.healthRight then
                Ui_10.healthRight.Rotation = math.min(v88, 180) + 180
            end

            if Ui_10.healthLeft then
                Ui_10.healthLeft.Rotation = math.max(v88, 180) + 180
            end
        end

        if Round and not Round.pressed then
            local v89 = workspace:GetServerTimeNow()

            if v89 >= Round.StartTime then
                if not Round.shown then
                    Round.shown = true
                    placeZones(t_10, Round)
                    t_10.ui.zones.Visible = true

                    for _, val_3 in t_10.ui.pointerParts do
                        val_3.inst[val_3.prop] = val_3.color
                    end
                end

                Round.drawnTime = v89
                t_10.ui.spinner.Rotation = (Round.StartPos + (Round.Direction or 1) * Round.Speed * math.max(
                    v89 - Round.StartTime,
                    0
                )) % 1 % 1 * 360
            else
                t_10.ui.spinner.Rotation = Round.StartPos % 1 * 360
            end
        end

        if os.clock() - t_10.lastHeard > 15 then
            close(t_10, 0)
        end
    end)
    ContextActionService:BindActionAtPriority(
        "HarvestTimingPress",
        onPress,
        false,
        5000,
        Enum.KeyCode.Space,
        Enum.KeyCode.ButtonX,
        Enum.KeyCode.ButtonA,
        Enum.UserInputType.MouseButton1,
        Enum.UserInputType.Touch
    )
    local v92 = ContextActionService
    local v93 = onCancel
    local v94 = LocalPlayer:FindFirstChild("Binds")
    local v95 = v94

    if v95 then
        v95 = v94:FindFirstChild("Interact")
    end

    v94 = v95

    if v94 then
        v94 = if v95.Value ~= "" then Enum.KeyCode:FromName(v95.Value) else false
    end

    v92:BindActionAtPriority(
        "HarvestTimingCancel",
        v93,
        false,
        5000,
        v94 or Enum.KeyCode.E,
        Enum.KeyCode.ButtonB
    )
end

HarvestTiming.OnClientEvent:Connect(function(arg76, arg77) -- line: 790
    -- upvalues:
    --  [1] open (copy)
    --  [2] v2 (ref)
    --  [3] placeZones (copy)
    --  [4] showResult (copy)
    --  [5] popZones (copy)
    --  [6] close (copy)

    if typeof(arg77) ~= "table" then
        return
    end

    if arg76 == "Open" then
        open(arg77)

        return
    end

    local v97 = v2

    if not v97 or v97.id ~= arg77.Session then
        return
    end

    v97.lastHeard = os.clock()

    if arg76 == "Round" then
        arg77.pressed = false
        arg77.shown = false
        v97.round = arg77
        local Momentum = arg77.Momentum

        if typeof(Momentum) == "number" then
            v97.ui.power.Text = string.format(
                "x%.2f",
                1 + Momentum * (v97.data.DamagePerMomentum or 0)
            )
        end

        local Health_1 = arg77.Health

        if typeof(Health_1) ~= "number" then
            return
        end

        v97.healthTarget = math.clamp(Health_1, 0, 1)

        if not v97.healthShown then
            v97.healthShown = v97.healthTarget
            local Ui_11 = v97.ui
            local v98 = (1 - math.clamp(v97.healthShown, 0, 1)) * 360

            if Ui_11.healthRight then
                Ui_11.healthRight.Rotation = math.min(v98, 180) + 180
            end

            if Ui_11.healthLeft then
                Ui_11.healthLeft.Rotation = math.max(v98, 180) + 180

                return
            end
        end
    elseif arg76 == "Result" then
        local Momentum_1 = arg77.Momentum

        if typeof(Momentum_1) == "number" then
            v97.ui.power.Text = string.format(
                "x%.2f",
                1 + Momentum_1 * (v97.data.DamagePerMomentum or 0)
            )
        end

        local Health_2 = arg77.Health

        if typeof(Health_2) == "number" then
            v97.healthTarget = math.clamp(Health_2, 0, 1)

            if not v97.healthShown then
                v97.healthShown = v97.healthTarget
                local Ui_12 = v97.ui
                local v99 = (1 - math.clamp(v97.healthShown, 0, 1)) * 360

                if Ui_12.healthRight then
                    Ui_12.healthRight.Rotation = math.min(v99, 180) + 180
                end

                if Ui_12.healthLeft then
                    Ui_12.healthLeft.Rotation = math.max(v99, 180) + 180
                end
            end
        end

        if arg77.Result == "Void" then
            local Result_5 = v97.ui.result
            local ResultStyle_3 = v97.ui.resultStyle
            local TextColor3_1 = v97.ui.result.TextColor3
            v97.resultToken = (v97.resultToken or 0) + 1
            Result_5.Text = ""
            Result_5.TextColor3 = TextColor3_1
            Result_5.TextTransparency = ResultStyle_3.TextTransparency
            Result_5.TextStrokeTransparency = ResultStyle_3.TextStrokeTransparency
            local _ = v97.resultToken
            local Round_1 = v97.round

            if Round_1 and Round_1.popped then
                Round_1.popped = false
                placeZones(v97, Round_1)
            end

            v97.ui.zones.Visible = true

            for _, val_4 in v97.ui.pointerParts do
                val_4.inst[val_4.prop] = val_4.color
            end

            return
        end

        showResult(v97, arg77.Result)

        if arg77.Result == "Miss" then
            local Round_2 = v97.round

            if Round_2 and Round_2.popped then
                Round_2.popped = false
                placeZones(v97, Round_2)
            end

            v97.ui.zones.Visible = true
            local Ui_13 = v97.ui

            for _, val_5 in Ui_13.pointerParts do
                local v100 = Ui_13.pointerMissColor or val_5.color
                val_5.inst[val_5.prop] = v100
            end

            return
        end

        popZones(v97, v97.round)

        for _, val_6 in v97.ui.pointerParts do
            val_6.inst[val_6.prop] = val_6.color
        end

        return
    elseif arg76 == "Close" then
        close(v97, 0.35)
    end
end)
