-- Decompiled with Veyra harvester
-- Instance: StarterGui.HarvestRings.HarvestRingsClient
-- Class: LocalScript
-- bytes: 20650

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local HarvestRings = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("HarvestRings")
local Misc = ReplicatedStorage:WaitForChild("Animations"):WaitForChild("Misc")
local HarvestingIdle = Misc:WaitForChild("HarvestingIdle")
local Harvesting = Misc:WaitForChild("Harvesting")
local Holder = script.Parent:WaitForChild("Holder")
local Arena = Holder:WaitForChild("Arena")
local Outer = Arena:WaitForChild("Outer")
local Rings = Arena:WaitForChild("Rings")
local Player = Arena:WaitForChild("Player")
local Spinner = Player:WaitForChild("Spinner")
local Power = Arena:WaitForChild("Power")
local Fill = Holder:WaitForChild("Health"):WaitForChild("Fill")
local Result = Holder:WaitForChild("Result")
local Hint = Holder:FindFirstChild("Hint")
local Title = Holder:FindFirstChild("Title")
local ClosingRing = script:WaitForChild("ClosingRing")
Holder.Visible = false
local t = {
    MaxTurnSpeed = 540,
    TurnResponse = 9,
    TurnSmoothing = 14,
    StickDeadzone = 0.35,
    CutSpeed = 1,
    PassTime = 0.25,
    MissColor = Color3.fromRGB(150, 150, 150),
    SafetyClose = 15
}
local v1 = nil

local _ = function(arg1, arg2) --[[ angleDiff ]] -- line: 91
    return (arg1 - arg2 + 180) % 360 - 180
end

local _ = function(arg3) --[[ angleOf ]] -- line: 96
    local v2 = math.atan2(arg3.X, -arg3.Y)

    return math.deg(v2) % 360
end

local _ = function(arg4) --[[ radiusOf ]] -- line: 100
    return arg4.Size.X.Offset / 2
end

local _ = function() --[[ ringCentre ]] -- line: 104
    -- upvalues:
    --  [1] Player (copy)

    return Player.AbsolutePosition + Player.AbsoluteSize / 2
end

local _ = function(arg5, arg6, arg7) --[[ attr ]] -- line: 108
    local v3 = arg5

    if v3 then
        v3 = arg5:GetAttribute(arg6)
    end

    if typeof(v3) == typeof(arg7) then
        return v3
    end

    return arg7
end

local _ = function() --[[ getInteractKey ]] -- line: 118
    -- upvalues:
    --  [1] LocalPlayer (copy)

    local v5 = LocalPlayer:FindFirstChild("Binds")
    local v6 = v5

    if v6 then
        v6 = v5:FindFirstChild("Interact")
    end

    v5 = v6

    if v5 then
        v5 = if v6.Value ~= "" then Enum.KeyCode:FromName(v6.Value) else false
    end

    return v5 or Enum.KeyCode.E
end

local _ = function(arg8) --[[ getKeyName ]] -- line: 125
    -- upvalues:
    --  [1] UserInputService (copy)

    local v8 = UserInputService:GetStringForKeyCode(arg8)

    if v8 ~= "" then
        return v8
    end

    return arg8.Name
end

local function setGap(arg9) -- line: 134
    if not arg9.gradient then
        return
    end

    local v10 = math.clamp(math.cos((math.rad(arg9.gapHalf))) * 0.5 + 0.5, 0.01, 0.99)
    arg9.gradient.Rotation = 0
    arg9.gradient.Transparency = NumberSequence.new(
        {
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(v10 - 0.005, 0),
            NumberSequenceKeypoint.new(v10, 1),
            NumberSequenceKeypoint.new(1, 1)
        }
    )
end

local _ = function(arg10, arg11, arg12) --[[ placeRing ]] -- line: 150
    arg10.gui.Size = UDim2.fromOffset(arg11 * 2, arg11 * 2)
    arg10.gui.Rotation = arg12 - 90
end

local _ = function(arg13, arg14) --[[ setPower ]] -- line: 160
    -- upvalues:
    --  [1] Power (copy)

    Power.Text = string.format("x%.2f", 1 + (arg14 or 0) * arg13.damagePerMomentum)
end

local _ = function(arg15) --[[ setHealth ]] -- line: 164
    -- upvalues:
    --  [1] Fill (copy)

    if typeof(arg15) == "number" then
        Fill.Size = UDim2.fromScale(math.clamp(arg15, 0, 1), 1)
    end
end

local v13 = 0
local t_2 = { Critical = "CRITICAL!", Hit = "PULL", Miss = "MISS", Done = "HARVESTED" }

local function showResult(arg16, arg17) -- line: 171
    -- upvalues:
    --  [1] v13 (ref)
    --  [2] Result (copy)
    --  [3] t_2 (copy)
    --  [4] TweenService (copy)

    v13 += 1
    local t_3 = { Critical = nil, Hit = nil, Miss = nil, Done = nil }
    local v14 = Result
    local v15 = v13
    local color = Color3.fromRGB(255, 201, 94)
    local v16 = v14

    if v16 then
        v16 = v14:GetAttribute("CriticalColor")
    end

    local v17 = typeof(v16)
    t_3.Critical = if v17 == typeof(color) then v16 else color
    local v19 = Result
    local color_1 = Color3.fromRGB(64, 200, 90)
    v16 = v19

    if v16 then
        v16 = v19:GetAttribute("HitColor")
    end

    local v20 = typeof(v16)
    t_3.Hit = if v20 == typeof(color_1) then v16 else color_1
    local v21 = Result
    local color_2 = Color3.fromRGB(190, 190, 190)
    v16 = v21

    if v16 then
        v16 = v21:GetAttribute("MissColor")
    end

    local v22 = typeof(v16)
    t_3.Miss = if v22 == typeof(color_2) then v16 else color_2
    local v23 = Result
    local color_3 = Color3.fromRGB(64, 200, 90)
    v16 = v23

    if v16 then
        v16 = v23:GetAttribute("HitColor")
    end

    local v24 = typeof(v16)
    t_3.Done = if v24 == typeof(color_3) then v16 else color_3
    Result.Text = t_2[arg16] or ""
    local v25 = t_3[arg16] or Color3.new(1, 1, 1)
    Result.TextColor3 = v25
    Result.TextTransparency = 0
    Result.TextStrokeTransparency = 0.4

    if arg17 then
        return
    end

    task.delay(0.45, function() -- line: 191
        -- upvalues:
        --  [1] v15 (copy)
        --  [2] v13 (ref)
        --  [3] TweenService (ref)
        --  [4] Result (ref)

        if v15 == v13 then
            TweenService:Create(
                Result,
                TweenInfo.new(0.2),
                { TextTransparency = 1, TextStrokeTransparency = 1 }
            ):Play()
        end
    end)
end

local function refreshHint() -- line: 198
    -- upvalues:
    --  [1] Hint (copy)
    --  [2] UserInputService (copy)
    --  [3] LocalPlayer (copy)

    if not Hint then
        return
    end

    if Hint:GetAttribute("KeyboardText") == nil then
        Hint:SetAttribute("KeyboardText", Hint.Text)
    end

    local v28 = UserInputService:GetLastInputType()
    local v30

    if v28 == Enum.UserInputType.Touch then
        local v29 = Hint
        v30 = v29
        local v31 = Hint

        if v30 then
            v30 = v29:GetAttribute("TouchText")
        end

        v31.Text = if typeof(v30) == "string" then v30 else "Drag to aim"

        return
    end

    if string.find(v28.Name, "Gamepad") then
        local v33 = Hint
        v30 = v33
        local v34 = Hint

        if v30 then
            v30 = v33:GetAttribute("GamepadText")
        end

        v34.Text = if typeof(v30) == "string" then v30 else "Aim with a stick  \194\183  B to cancel"

        return
    end

    local v32 = Hint
    local Text = Hint.Text
    v30 = v32

    if v30 then
        v30 = v32:GetAttribute("KeyboardText")
    end

    local v36 = if typeof(v30) == typeof(Text) then v30 else Text
    local v37 = Hint
    local string_gsub = string.gsub
    local v38 = LocalPlayer:FindFirstChild("Binds")
    local v39 = v38

    if v39 then
        v39 = v38:FindFirstChild("Interact")
    end

    v38 = v39

    if v38 then
        v38 = if v39.Value ~= "" then Enum.KeyCode:FromName(v39.Value) else false
    end

    local v40 = v38 or Enum.KeyCode.E
    v38 = UserInputService:GetStringForKeyCode(v40)
    v37.Text = string_gsub(
        v36,
        "<b>E</b>",
        "<b>" .. (if v38 ~= "" then v38 else v40.Name) .. "</b>"
    )
end

local function startAnimation(arg18) -- line: 223
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] HarvestingIdle (copy)
    --  [3] Harvesting (copy)

    local v42 = LocalPlayer.Character
    local v43 = v42

    if v43 then
        v43 = v42:FindFirstChildOfClass("Humanoid")
    end

    v42 = v43

    if v42 then
        v42 = v43:FindFirstChildOfClass("Animator")
    end

    if not v42 then
        return
    end

    v43 = v42:LoadAnimation(HarvestingIdle)
    v43.Priority = Enum.AnimationPriority.Action
    v43.Looped = true
    local v44 = v42:LoadAnimation(Harvesting)
    v44.Priority = Enum.AnimationPriority.Action2
    v44.Looped = false
    arg18.anim = { idle = v43, cut = v44 }
    v43:Play(0.2)
end

local _ = function(arg19) --[[ playCut ]] -- line: 245
    -- upvalues:
    --  [1] t (copy)

    local Anim = arg19.anim

    if not Anim then
        return
    end

    Anim.cut:Play(0.05, nil, t.CutSpeed)
end

local _ = function(arg20) --[[ stopAnimation ]] -- line: 254
    local Anim_1 = arg20.anim

    if not Anim_1 then
        return
    end

    arg20.anim = nil
    Anim_1.idle:Stop(0.2)
    Anim_1.cut:Stop(0.2)
end

local function addRing(arg21, arg22) -- line: 269
    -- upvalues:
    --  [1] ClosingRing (copy)
    --  [2] setGap (copy)
    --  [3] Rings (copy)

    local v45 = ClosingRing:Clone()
    v45.Visible = false
    local UIStroke = v45:FindFirstChildWhichIsA("UIStroke")
    local t_5 = {
        id = arg22.Id,
        gui = v45,
        stroke = UIStroke,
        gradient = nil,
        startTime = nil,
        travel = nil,
        gapCenter = nil,
        gapHalf = nil,
        spin = nil,
        critShare = nil,
        reported = false
    }
    local v46 = UIStroke

    if v46 then
        v46 = UIStroke:FindFirstChildWhichIsA("UIGradient")
    end

    t_5.gradient = v46
    t_5.startTime = arg22.StartTime
    t_5.travel = math.max(arg22.Travel, 0.05)
    t_5.gapCenter = arg22.GapCenter
    t_5.gapHalf = arg22.GapHalf
    t_5.spin = arg22.Spin or 0
    t_5.critShare = arg22.CritShare
    setGap(t_5)
    local OuterRadius = arg21.outerRadius
    local GapCenter = t_5.gapCenter
    t_5.gui.Size = UDim2.fromOffset(OuterRadius * 2, OuterRadius * 2)
    t_5.gui.Rotation = GapCenter - 90
    v45.Parent = Rings
    arg21.rings[t_5.id] = t_5
end

local function removeRing(arg23, arg24, arg25) -- line: 297
    -- upvalues:
    --  [1] t (copy)
    --  [2] TweenService (copy)

    local tweenInfo_1 = TweenInfo.new(t.PassTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v48 = if not arg25 then 1.15 else 0.45
    local v49 = arg23.innerRadius * 2 * v48

    if arg24.stroke then
        if not arg25 then
            arg24.stroke.Color = t.MissColor
        end

        TweenService:Create(arg24.stroke, tweenInfo_1, { Transparency = 1 }):Play()
    end

    for _, descendant in arg24.gui:GetDescendants() do
        if descendant:IsA("GuiObject") then
            TweenService:Create(descendant, tweenInfo_1, { BackgroundTransparency = 1 }):Play()
        end
    end

    local t_6 = { Size = UDim2.fromOffset(v49, v49) }
    TweenService:Create(arg24.gui, tweenInfo_1, t_6):Play()
    task.delay(t.PassTime + 0.05, function() -- line: 316
        -- upvalues:
        --  [1] arg24 (copy)

        arg24.gui:Destroy()
    end)
end

local function close(arg26, arg27) -- line: 325
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] ContextActionService (copy)
    --  [3] Holder (copy)
    --  [4] ProximityPromptService (copy)

    if arg26.closed then
        return
    end

    arg26.closed = true

    for _, val in arg26.connections do
        val:Disconnect()
    end

    if v1 == arg26 then
        v1 = nil
        ContextActionService:UnbindAction("HarvestRingsCancel")
        ContextActionService:UnbindAction("HarvestRingsStick")
    end

    local Anim_2 = arg26.anim

    if Anim_2 then
        arg26.anim = nil
        Anim_2.idle:Stop(0.2)
        Anim_2.cut:Stop(0.2)
    end

    task.delay(arg27 or 0, function() -- line: 343
        -- upvalues:
        --  [1] arg26 (copy)
        --  [2] v1 (ref)
        --  [3] Holder (ref)
        --  [4] ProximityPromptService (ref)

        for _, val_1 in arg26.rings do
            val_1.gui:Destroy()
        end

        table.clear(arg26.rings)

        if not v1 then
            Holder.Visible = false
            ProximityPromptService.Enabled = true
        end
    end)
end

local function step(arg28, arg29) -- line: 356
    -- upvalues:
    --  [1] t (copy)
    --  [2] UserInputService (copy)
    --  [3] Player (copy)
    --  [4] Spinner (copy)
    --  [5] HarvestRings (copy)
    --  [6] removeRing (copy)
    --  [7] close (copy)

    if arg28.closed or arg29 <= 0 then
        return
    end

    local v51 = arg28.stick

    if v51 and v51.Magnitude > t.StickDeadzone then
        local vec2 = Vector2.new(v51.X, -v51.Y)
        arg28.target = math.deg((math.atan2(vec2.X, -vec2.Y))) % 360
    elseif arg28.useMouse then
        local v54 = UserInputService:GetMouseLocation() - (Player.AbsolutePosition + Player.AbsoluteSize / 2)

        if v54.Magnitude > 6 then
            arg28.target = math.deg((math.atan2(v54.X, -v54.Y))) % 360
        end
    end

    v51 = if arg28.target then math.clamp(
        ((arg28.target - arg28.pointer + 180) % 360 - 180) * t.TurnResponse,
        -t.MaxTurnSpeed,
        t.MaxTurnSpeed
    ) else 0
    arg28.velocity = arg28.velocity + (v51 - arg28.velocity) * math.min(arg29 * t.TurnSmoothing, 1)
    arg28.velocity = math.clamp(arg28.velocity, -t.MaxTurnSpeed, t.MaxTurnSpeed)
    arg28.pointer = (arg28.pointer + arg28.velocity * arg29) % 360
    Spinner.Rotation = arg28.pointer
    v51 = workspace:GetServerTimeNow()

    for key_3, val_2 in arg28.rings do
        local v57 = v51 - val_2.startTime

        if not (v57 < 0) then
            val_2.gui.Visible = true
            local v58 = math.min(v57 / val_2.travel, 1)
            local v59 = val_2.gapCenter + val_2.spin * math.min(v57, val_2.travel)
            local v60 = arg28.outerRadius + (arg28.innerRadius - arg28.outerRadius) * v58
            val_2.gui.Size = UDim2.fromOffset(v60 * 2, v60 * 2)
            val_2.gui.Rotation = v59 - 90

            if v58 >= 1 and not val_2.reported then
                val_2.reported = true
                arg28.rings[key_3] = nil
                HarvestRings:FireServer("Report", val_2.id, arg28.pointer, v51)
                removeRing(
                    arg28,
                    val_2,
                    if not (math.abs((arg28.pointer - v59 + 180) % 360 - 180) <= val_2.gapHalf) then false else true
                )
            end
        end
    end

    if os.clock() - arg28.lastHeard > t.SafetyClose then
        close(arg28, 0)
    end
end

local function open(arg30) -- line: 415
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] close (copy)
    --  [3] UserInputService (copy)
    --  [4] Outer (copy)
    --  [5] Player (copy)
    --  [6] ProximityPromptService (copy)
    --  [7] Title (copy)
    --  [8] Result (copy)
    --  [9] refreshHint (copy)
    --  [10] Power (copy)
    --  [11] Fill (copy)
    --  [12] Spinner (copy)
    --  [13] Holder (copy)
    --  [14] startAnimation (copy)
    --  [15] ContextActionService (copy)
    --  [16] t (copy)
    --  [17] HarvestRings (copy)
    --  [18] LocalPlayer (copy)
    --  [19] RunService (copy)
    --  [20] step (copy)

    if v1 then
        close(v1, 0)
    end

    local t_7 = {
        id = arg30.Session,
        damagePerMomentum = arg30.DamagePerMomentum or 0,
        rings = {},
        connections = {},
        pointer = 0,
        velocity = 0,
        target = nil,
        stick = nil,
        useMouse = UserInputService.MouseEnabled,
        outerRadius = Outer.Size.X.Offset / 2,
        innerRadius = nil,
        lastHeard = nil,
        closed = false
    }
    local v62 = Player.Size.X.Offset / 2
    local v63 = Player:FindFirstChildWhichIsA("UIStroke") and Player:FindFirstChildWhichIsA(
        "UIStroke"
    ).Thickness / 2 or 0
    t_7.innerRadius = v62 + v63
    t_7.lastHeard = os.clock()
    v1 = t_7
    ProximityPromptService.Enabled = false

    if Title then
        Title.Text = tostring(arg30.Title or "Harvesting")
    end

    Result.Text = ""
    refreshHint()
    Power.Text = string.format("x%.2f", 1 + 0 * t_7.damagePerMomentum)
    local v66 = arg30.Health or 1

    if typeof(v66) == "number" then
        Fill.Size = UDim2.fromScale(math.clamp(v66, 0, 1), 1)
    end

    Spinner.Rotation = 0
    Holder.Visible = true
    startAnimation(t_7)

    local function aimTouch(arg31) -- line: 453
        -- upvalues:
        --  [1] t_7 (copy)
        --  [2] Player (ref)

        if arg31.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        t_7.useMouse = false
        local v68 = Vector2.new(arg31.Position.X, arg31.Position.Y) - (Player.AbsolutePosition + Player.AbsoluteSize / 2)

        if v68.Magnitude > 6 then
            t_7.target = math.deg((math.atan2(v68.X, -v68.Y))) % 360
        end
    end

    table.insert(t_7.connections, UserInputService.InputBegan:Connect(aimTouch))
    table.insert(t_7.connections, UserInputService.InputChanged:Connect(function(input) -- line: 465
        -- upvalues:
        --  [1] t_7 (copy)
        --  [2] aimTouch (copy)

        if input.UserInputType == Enum.UserInputType.MouseMovement then
            t_7.useMouse = true

            return
        end

        aimTouch(input)
    end))
    table.insert(t_7.connections, UserInputService.LastInputTypeChanged:Connect(refreshHint))
    ContextActionService:BindActionAtPriority(
        "HarvestRingsStick",
        function(_, _, arg35) -- line: 475
            -- upvalues:
            --  [1] t_7 (copy)
            --  [2] t (ref)

            t_7.stick = Vector2.new(arg35.Position.X, arg35.Position.Y)

            if t_7.stick.Magnitude > t.StickDeadzone then
                t_7.useMouse = false
            end

            return Enum.ContextActionResult.Sink
        end,
        false,
        5000,
        Enum.KeyCode.Thumbstick1,
        Enum.KeyCode.Thumbstick2
    )
    local v72 = ContextActionService
    local v73 = LocalPlayer:FindFirstChild("Binds")
    local v74 = v73

    if v74 then
        v74 = v73:FindFirstChild("Interact")
    end

    v73 = v74

    if v73 then
        v73 = if v74.Value ~= "" then Enum.KeyCode:FromName(v74.Value) else false
    end

    v72:BindActionAtPriority(
        "HarvestRingsCancel",
        function(_, arg37) -- line: 484
            -- upvalues:
            --  [1] HarvestRings (ref)
            --  [2] close (ref)
            --  [3] t_7 (copy)

            if arg37 == Enum.UserInputState.Begin then
                HarvestRings:FireServer("Cancel")
                close(t_7, 0)
            end

            return Enum.ContextActionResult.Sink
        end,
        false,
        5000,
        v73 or Enum.KeyCode.E,
        Enum.KeyCode.ButtonB
    )
    table.insert(t_7.connections, RunService.RenderStepped:Connect(function(deltaTime) -- line: 492
        -- upvalues:
        --  [1] step (ref)
        --  [2] t_7 (copy)

        step(t_7, deltaTime)
    end))
end

HarvestRings.OnClientEvent:Connect(function(arg39, arg40) -- line: 497
    -- upvalues:
    --  [1] open (copy)
    --  [2] v1 (ref)
    --  [3] addRing (copy)
    --  [4] Power (copy)
    --  [5] Fill (copy)
    --  [6] t (copy)
    --  [7] showResult (copy)
    --  [8] close (copy)

    if typeof(arg40) ~= "table" then
        return
    end

    if arg39 == "Open" then
        open(arg40)

        return
    end

    local v76 = v1

    if not v76 or v76.id ~= arg40.Session then
        return
    end

    v76.lastHeard = os.clock()

    if arg39 == "Ring" then
        addRing(v76, arg40)
        Power.Text = string.format("x%.2f", 1 + (arg40.Momentum or 0) * v76.damagePerMomentum)
        local Health = arg40.Health

        if typeof(Health) == "number" then
            Fill.Size = UDim2.fromScale(math.clamp(Health, 0, 1), 1)

            return
        end
    elseif arg39 == "Result" then
        Power.Text = string.format("x%.2f", 1 + (arg40.Momentum or 0) * v76.damagePerMomentum)
        local Health_1 = arg40.Health

        if typeof(Health_1) == "number" then
            Fill.Size = UDim2.fromScale(math.clamp(Health_1, 0, 1), 1)
        end

        if arg40.Result == "Hit" or arg40.Result == "Critical" then
            local Anim_3 = v76.anim

            if Anim_3 then
                Anim_3.cut:Play(0.05, nil, t.CutSpeed)
            end
        end

        if arg40.Finished then
            showResult("Done", true)

            return
        end

        showResult(arg40.Result)

        return
    elseif arg39 == "Close" then
        close(v76, if arg40.Outcome ~= "Done" then 0.35 else 0.6)
    end
end)
