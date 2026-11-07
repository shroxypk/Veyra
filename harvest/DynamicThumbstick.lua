-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.DynamicThumbstick
-- Class: ModuleScript
-- bytes: 24094

local v4
local t = { 0.10999999999999999, 0.30000000000000004, 0.4, 0.5, 0.6, 0.7, 0.75 }
local v1 = #t
local Value = Enum.ContextActionPriority.High.Value
local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Success, v2 = pcall(function() -- line: 37
    return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickMoveOverButtons2")
end)
local v3 = Success and v2
v2 = pcall
v2, v4 = v2(function() -- line: 44
    return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickSafeAreaUpdate")
end)
local v5 = v2 and v4
v2 = Players.LocalPlayer

if not v2 then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    v2 = Players.LocalPlayer
end

local BaseCharacterController_m = require(script.Parent:WaitForChild("BaseCharacterController"))
local t_1 = setmetatable({}, BaseCharacterController_m)
t_1.__index = t_1

function t_1.new() -- line: 61
    -- upvalues:
    --  [1] BaseCharacterController_m (copy)
    --  [2] t_1 (copy)

    local t_2 = setmetatable(BaseCharacterController_m.new(), t_1)
    t_2.moveTouchObject = nil
    t_2.moveTouchLockedIn = false
    t_2.moveTouchFirstChanged = false
    t_2.moveTouchStartPosition = nil
    t_2.startImage = nil
    t_2.endImage = nil
    t_2.middleImages = {}
    t_2.startImageFadeTween = nil
    t_2.endImageFadeTween = nil
    t_2.middleImageFadeTweens = {}
    t_2.isFirstTouch = true
    t_2.thumbstickFrame = nil
    t_2.onRenderSteppedConn = nil
    t_2.fadeInAndOutBalance = 0.5
    t_2.fadeInAndOutHalfDuration = 0.3
    t_2.hasFadedBackgroundInPortrait = false
    t_2.hasFadedBackgroundInLandscape = false
    t_2.tweenInAlphaStart = nil
    t_2.tweenOutAlphaStart = nil

    return t_2
end

function t_1.GetIsJumping(arg1) -- line: 96
    local IsJumping = arg1.isJumping
    arg1.isJumping = false

    return IsJumping
end

function t_1.Enable(t1: table, b1: boolean?, arg2: any) -- line: 102
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] ContextActionService (copy)

    if b1 == nil then
        return false
    end

    b1 = if b1 then true else false

    if t1.enabled == b1 then
        return true
    end

    if b1 then
        if not t1.thumbstickFrame then
            t1:Create(arg2)
        end

        t1:BindContextActions()
    else
        if v3 then
            t1:UnbindContextActions()
        else
            ContextActionService:UnbindAction("DynamicThumbstickAction")
        end

        t1:OnInputEnded()
    end

    t1.enabled = b1
    t1.thumbstickFrame.Visible = b1

    return nil
end

function t_1.OnInputEnded(arg3) -- line: 131
    arg3.moveTouchObject = nil
    arg3.moveVector = Vector3.new(0, 0, 0)
    arg3:FadeThumbstick(false)
end

function t_1.FadeThumbstick(t2: table, b2: boolean?) -- line: 137
    -- upvalues:
    --  [1] TweenService (copy)
    --  [2] tweenInfo (copy)
    --  [3] t (copy)

    if not b2 and t2.moveTouchObject then
        return
    end

    if t2.isFirstTouch then
        return
    end

    if t2.startImageFadeTween then
        t2.startImageFadeTween:Cancel()
    end

    if t2.endImageFadeTween then
        t2.endImageFadeTween:Cancel()
    end

    for index = 1, #t2.middleImages do
        local _ = #t2.middleImages

        if t2.middleImageFadeTweens[index] then
            t2.middleImageFadeTweens[index]:Cancel()
        end
    end

    if b2 then
        t2.startImageFadeTween = TweenService:Create(
            t2.startImage,
            tweenInfo,
            { ImageTransparency = 0 }
        )
        t2.startImageFadeTween:Play()
        t2.endImageFadeTween = TweenService:Create(
            t2.endImage,
            tweenInfo,
            { ImageTransparency = 0.2 }
        )
        t2.endImageFadeTween:Play()

        for index_1 = 1, #t2.middleImages do
            local t_3 = { ImageTransparency = t[index_1] }
            local _ = #t2.middleImages
            t2.middleImageFadeTweens[index_1] = TweenService:Create(
                t2.middleImages[index_1],
                tweenInfo,
                t_3
            )
            t2.middleImageFadeTweens[index_1]:Play()
        end
    else
        t2.startImageFadeTween = TweenService:Create(
            t2.startImage,
            tweenInfo,
            { ImageTransparency = 1 }
        )
        t2.startImageFadeTween:Play()
        t2.endImageFadeTween = TweenService:Create(
            t2.endImage,
            tweenInfo,
            { ImageTransparency = 1 }
        )
        t2.endImageFadeTween:Play()

        for index_2 = 1, #t2.middleImages do
            local _ = #t2.middleImages
            t2.middleImageFadeTweens[index_2] = TweenService:Create(
                t2.middleImages[index_2],
                tweenInfo,
                { ImageTransparency = 1 }
            )
            t2.middleImageFadeTweens[index_2]:Play()
        end
    end
end

function t_1.FadeThumbstickFrame(t3: table, n1: number, n2: number) -- line: 180
    t3.fadeInAndOutHalfDuration = n1 * 0.5
    t3.fadeInAndOutBalance = n2
    t3.tweenInAlphaStart = tick()
end

function t_1.InputInFrame(t4: table, u1: userdata) -- line: 186
    local AbsolutePosition = t4.thumbstickFrame.AbsolutePosition
    local v12 = AbsolutePosition + t4.thumbstickFrame.AbsoluteSize
    local Position = u1.Position

    return Position.X >= AbsolutePosition.X and (Position.Y >= AbsolutePosition.Y and (Position.X <= v12.X and (Position.Y <= v12.Y and true)))
end

function t_1.DoFadeInBackground(arg4) -- line: 198
    -- upvalues:
    --  [1] v2 (ref)

    local PlayerGui = v2:FindFirstChildOfClass("PlayerGui")
    local v13 = false

    if PlayerGui then
        if PlayerGui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft or PlayerGui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight then
            v13 = arg4.hasFadedBackgroundInLandscape
            arg4.hasFadedBackgroundInLandscape = true
        elseif PlayerGui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
            v13 = arg4.hasFadedBackgroundInPortrait
            arg4.hasFadedBackgroundInPortrait = true
        end
    end

    if not v13 then
        arg4.fadeInAndOutHalfDuration = 0.3
        arg4.fadeInAndOutBalance = 0.5
        arg4.tweenInAlphaStart = tick()
    end
end

function t_1.DoMove(t5: table, vec1: Vector3) -- line: 221
    local v14 = vec1

    if v14.Magnitude < t5.radiusOfDeadZone then
        v14 = Vector3.new(0, 0, 0)
    else
        v14 = v14.Unit * (1 - math.max(
            0,
            (t5.radiusOfMaxSpeed - v14.Magnitude) / t5.radiusOfMaxSpeed
        ))
        v14 = Vector3.new(v14.X, 0, v14.Y)
    end

    t5.moveVector = v14
end

function t_1.LayoutMiddleImages(t6: table, vec2: Vector3, vec3: Vector3) -- line: 239
    -- upvalues:
    --  [1] v1 (copy)

    local v15 = t6.thumbstickSize / 2 + t6.middleSize
    local v16 = vec3 - vec2
    local v17 = v16.Magnitude - t6.thumbstickRingSize / 2 - t6.middleSize
    local Unit_1 = v16.Unit
    local v18 = t6.middleSpacing
    v18 = if not (t6.middleSpacing * v1 < v17) then v18 else v17 / v1

    for index_3 = 1, v1 do
        local v19 = t6.middleImages[index_3]
        local v20 = v15 + v18 * (index_3 - 1)
        local _ = v1

        if v17 > v15 + v18 * (index_3 - 2) then
            local v22 = vec3 - Unit_1 * v20
            local v23 = math.clamp(1 - (v20 - v17) / v18, 0, 1)
            v19.Visible = true
            v19.Position = UDim2.new(0, v22.X, 0, v22.Y)
            v19.Size = UDim2.new(0, t6.middleSize * v23, 0, t6.middleSize * v23)
        else
            v19.Visible = false
        end
    end
end

function t_1.MoveStick(arg5, arg6) -- line: 270
    local v24 = Vector2.new(arg5.moveTouchStartPosition.X, arg5.moveTouchStartPosition.Y) - arg5.thumbstickFrame.AbsolutePosition
    local v25 = Vector2.new(arg6.X, arg6.Y) - arg5.thumbstickFrame.AbsolutePosition
    arg5.endImage.Position = UDim2.new(0, v25.X, 0, v25.Y)
    arg5:LayoutMiddleImages(v24, v25)
end

function t_1.BindContextActions(arg7) -- line: 278
    -- upvalues:
    --  [1] TweenService (copy)
    --  [2] v3 (ref)
    --  [3] ContextActionService (copy)
    --  [4] Value (copy)
    --  [5] UserInputService (copy)

    local function inputBegan(arg8) -- line: 279
        -- upvalues:
        --  [1] arg7 (copy)
        --  [2] TweenService (ref)

        if arg7.moveTouchObject then
            return Enum.ContextActionResult.Pass
        end

        if not arg7:InputInFrame(arg8) then
            return Enum.ContextActionResult.Pass
        end

        if arg7.isFirstTouch then
            arg7.isFirstTouch = false
            local tweenInfo_1 = TweenInfo.new(
                0.5,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            )
            local t_4 = { Size = UDim2.new(0, 0, 0, 0) }
            TweenService:Create(arg7.startImage, tweenInfo_1, t_4):Play()
            local t_5 = {
                Size = UDim2.new(0, arg7.thumbstickSize, 0, arg7.thumbstickSize),
                ImageColor3 = Color3.new(0, 0, 0)
            }
            TweenService:Create(arg7.endImage, tweenInfo_1, t_5):Play()
        end

        arg7.moveTouchLockedIn = false
        arg7.moveTouchObject = arg8
        arg7.moveTouchStartPosition = arg8.Position
        arg7.moveTouchFirstChanged = true
        arg7:DoFadeInBackground()

        return Enum.ContextActionResult.Pass
    end

    local function inputChanged(u2: userdata) -- line: 311
        -- upvalues:
        --  [1] arg7 (copy)

        if u2 == arg7.moveTouchObject then
            if arg7.moveTouchFirstChanged then
                arg7.moveTouchFirstChanged = false
                local vec2_3 = Vector2.new(
                    u2.Position.X - arg7.thumbstickFrame.AbsolutePosition.X,
                    u2.Position.Y - arg7.thumbstickFrame.AbsolutePosition.Y
                )
                arg7.startImage.Visible = true
                arg7.startImage.Position = UDim2.new(0, vec2_3.X, 0, vec2_3.Y)
                arg7.endImage.Visible = true
                arg7.endImage.Position = arg7.startImage.Position
                arg7:FadeThumbstick(true)
                arg7:MoveStick(u2.Position)
            end

            arg7.moveTouchLockedIn = true
            local vec2_4 = Vector2.new(
                u2.Position.X - arg7.moveTouchStartPosition.X,
                u2.Position.Y - arg7.moveTouchStartPosition.Y
            )

            if not (math.abs(vec2_4.X) > 0) then
                if math.abs(vec2_4.Y) > 0 then
                    arg7:DoMove(vec2_4)
                    arg7:MoveStick(u2.Position)
                end
            else
                arg7:DoMove(vec2_4)
                arg7:MoveStick(u2.Position)
            end

            return Enum.ContextActionResult.Sink
        end

        return Enum.ContextActionResult.Pass
    end

    local _ = function(arg9) --[[ inputEnded ]] -- line: 344
        -- upvalues:
        --  [1] arg7 (copy)

        if arg9 == arg7.moveTouchObject then
            arg7:OnInputEnded()

            if arg7.moveTouchLockedIn then
                return Enum.ContextActionResult.Sink
            end
        end

        return Enum.ContextActionResult.Pass
    end

    local function handleInput(_, arg11, arg12) -- line: 354
        -- upvalues:
        --  [1] inputBegan (copy)
        --  [2] v3 (ref)
        --  [3] arg7 (copy)
        --  [4] inputChanged (copy)

        if arg11 == Enum.UserInputState.Begin then
            return (inputBegan(arg12))
        end

        if arg11 == Enum.UserInputState.Change then
            if v3 then
                if arg12 == arg7.moveTouchObject then
                    return Enum.ContextActionResult.Sink
                end

                return Enum.ContextActionResult.Pass
            else
                return (inputChanged(arg12))
            end
        else
            if arg11 == Enum.UserInputState.End then
                if arg12 == arg7.moveTouchObject then
                    arg7:OnInputEnded()

                    if arg7.moveTouchLockedIn then
                        return Enum.ContextActionResult.Sink
                    end
                end

                return Enum.ContextActionResult.Pass
            end

            if arg11 == Enum.UserInputState.Cancel then
                arg7:OnInputEnded()
            end

            return
        end
    end

    ContextActionService:BindActionAtPriority(
        "DynamicThumbstickAction",
        handleInput,
        false,
        Value,
        Enum.UserInputType.Touch
    )

    if v3 then
        arg7.TouchMovedCon = UserInputService.TouchMoved:Connect(function(u3: userdata, _: boolean) -- line: 382
            -- upvalues:
            --  [1] inputChanged (copy)

            inputChanged(u3)
        end)
    end
end

function t_1.UnbindContextActions(arg13) -- line: 388
    -- upvalues:
    --  [1] ContextActionService (copy)

    ContextActionService:UnbindAction("DynamicThumbstickAction")

    if arg13.TouchMovedCon then
        arg13.TouchMovedCon:Disconnect()
    end
end

function t_1.Create(t7: table, u4: userdata) -- line: 396
    -- upvalues:
    --  [1] v5 (ref)
    --  [2] v1 (copy)
    --  [3] t (copy)
    --  [4] RunService (copy)
    --  [5] UserInputService (copy)
    --  [6] GuiService (copy)
    --  [7] v2 (ref)

    if t7.thumbstickFrame then
        t7.thumbstickFrame:Destroy()
        t7.thumbstickFrame = nil

        if t7.onRenderSteppedConn then
            t7.onRenderSteppedConn:Disconnect()
            t7.onRenderSteppedConn = nil
        end

        if t7.absoluteSizeChangedConn then
            t7.absoluteSizeChangedConn:Disconnect()
            t7.absoluteSizeChangedConn = nil
        end
    end

    local v28 = if not v5 then 0 else 100

    local function layoutThumbstickFrame(b4: boolean) -- line: 411
        -- upvalues:
        --  [1] t7 (copy)
        --  [2] v28 (copy)

        if b4 then
            t7.thumbstickFrame.Size = UDim2.new(1, v28, 0.4, v28)
            t7.thumbstickFrame.Position = UDim2.new(0, -v28, 0.6, 0)

            return
        end

        t7.thumbstickFrame.Size = UDim2.new(0.4, v28, 0.6666666666666666, v28)
        t7.thumbstickFrame.Position = UDim2.new(0, -v28, 0.3333333333333333, 0)
    end

    t7.thumbstickFrame = Instance.new("Frame")
    t7.thumbstickFrame.BorderSizePixel = 0
    t7.thumbstickFrame.Name = "DynamicThumbstickFrame"
    t7.thumbstickFrame.Visible = false
    t7.thumbstickFrame.BackgroundTransparency = 1
    t7.thumbstickFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    t7.thumbstickFrame.Active = false
    t7.thumbstickFrame.Size = UDim2.new(0.4, v28, 0.6666666666666666, v28)
    t7.thumbstickFrame.Position = UDim2.new(0, -v28, 0.3333333333333333, 0)
    t7.startImage = Instance.new("ImageLabel")
    t7.startImage.Name = "ThumbstickStart"
    t7.startImage.Visible = true
    t7.startImage.BackgroundTransparency = 1
    t7.startImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
    t7.startImage.ImageRectOffset = Vector2.new(1, 1)
    t7.startImage.ImageRectSize = Vector2.new(144, 144)
    t7.startImage.ImageColor3 = Color3.new(0, 0, 0)
    t7.startImage.AnchorPoint = Vector2.new(0.5, 0.5)
    t7.startImage.ZIndex = 10
    t7.startImage.Parent = t7.thumbstickFrame
    t7.endImage = Instance.new("ImageLabel")
    t7.endImage.Name = "ThumbstickEnd"
    t7.endImage.Visible = true
    t7.endImage.BackgroundTransparency = 1
    t7.endImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
    t7.endImage.ImageRectOffset = Vector2.new(1, 1)
    t7.endImage.ImageRectSize = Vector2.new(144, 144)
    t7.endImage.AnchorPoint = Vector2.new(0.5, 0.5)
    t7.endImage.ZIndex = 10
    t7.endImage.Parent = t7.thumbstickFrame

    for index_4 = 1, v1 do
        local _ = v1
        t7.middleImages[index_4] = Instance.new("ImageLabel")
        t7.middleImages[index_4].Name = "ThumbstickMiddle"
        t7.middleImages[index_4].Visible = false
        t7.middleImages[index_4].BackgroundTransparency = 1
        t7.middleImages[index_4].Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        t7.middleImages[index_4].ImageRectOffset = Vector2.new(1, 1)
        t7.middleImages[index_4].ImageRectSize = Vector2.new(144, 144)
        t7.middleImages[index_4].ImageTransparency = t[index_4]
        t7.middleImages[index_4].AnchorPoint = Vector2.new(0.5, 0.5)
        t7.middleImages[index_4].ZIndex = 9
        t7.middleImages[index_4].Parent = t7.thumbstickFrame
    end

    local function ResizeThumbstick() -- line: 467
        -- upvalues:
        --  [1] u4 (copy)
        --  [2] t7 (copy)
        --  [3] v28 (copy)

        local AbsoluteSize = u4.AbsoluteSize

        if if not (math.min(AbsoluteSize.X, AbsoluteSize.Y) > 500) then false else true then
            t7.thumbstickSize = 90
            t7.thumbstickRingSize = 40
            t7.middleSize = 20
            t7.middleSpacing = 28
            t7.radiusOfDeadZone = 4
            t7.radiusOfMaxSpeed = 40
        else
            t7.thumbstickSize = 45
            t7.thumbstickRingSize = 20
            t7.middleSize = 10
            t7.middleSpacing = 14
            t7.radiusOfDeadZone = 2
            t7.radiusOfMaxSpeed = 20
        end

        t7.startImage.Position = UDim2.new(
            0,
            t7.thumbstickRingSize * 3.3 + v28,
            1,
            -t7.thumbstickRingSize * 2.8 - v28
        )
        t7.startImage.Size = UDim2.new(
            0,
            t7.thumbstickRingSize * 3.7,
            0,
            t7.thumbstickRingSize * 3.7
        )
        t7.endImage.Position = t7.startImage.Position
        t7.endImage.Size = UDim2.new(0, t7.thumbstickSize * 0.8, 0, t7.thumbstickSize * 0.8)
    end

    ResizeThumbstick()
    t7.absoluteSizeChangedConn = u4:GetPropertyChangedSignal("AbsoluteSize"):Connect(
        ResizeThumbstick
    )
    local v34 = nil

    local function onCurrentCameraChanged() -- line: 505
        -- upvalues:
        --  [1] v34 (ref)
        --  [2] layoutThumbstickFrame (copy)

        if v34 then
            v34:Disconnect()
            v34 = nil
        end

        local CurrentCamera = workspace.CurrentCamera

        if CurrentCamera then
            v34 = CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() --[[ onViewportSizeChanged ]] -- line: 512
                -- upvalues:
                --  [1] CurrentCamera (copy)
                --  [2] layoutThumbstickFrame (ref)

                layoutThumbstickFrame(CurrentCamera.ViewportSize.X < CurrentCamera.ViewportSize.Y)
            end)
            local ViewportSize = CurrentCamera.ViewportSize
            layoutThumbstickFrame(if not (ViewportSize.X < ViewportSize.Y) then false else true)
        end
    end

    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(onCurrentCameraChanged)

    if workspace.CurrentCamera then
        onCurrentCameraChanged()
    end

    t7.moveTouchStartPosition = nil
    t7.startImageFadeTween = nil
    t7.endImageFadeTween = nil
    t7.middleImageFadeTweens = {}
    t7.onRenderSteppedConn = RunService.RenderStepped:Connect(function() -- line: 532
        -- upvalues:
        --  [1] t7 (copy)

        if t7.tweenInAlphaStart ~= nil then
            local v37 = tick() - t7.tweenInAlphaStart
            local v38 = t7.fadeInAndOutHalfDuration * 2 * t7.fadeInAndOutBalance
            t7.thumbstickFrame.BackgroundTransparency = 1 - math.min(v37 / v38, 1) * 0.35

            if v37 > v38 then
                t7.tweenOutAlphaStart = tick()
                t7.tweenInAlphaStart = nil

                return
            end
        elseif t7.tweenOutAlphaStart ~= nil then
            local v40 = tick() - t7.tweenOutAlphaStart
            local v41 = t7.fadeInAndOutHalfDuration * 2 - t7.fadeInAndOutHalfDuration * 2 * t7.fadeInAndOutBalance
            t7.thumbstickFrame.BackgroundTransparency = math.min(v40 / v41, 1) * 0.35 + 0.65

            if v40 > v41 then
                t7.tweenOutAlphaStart = nil
            end
        end
    end)
    t7.onTouchEndedConn = UserInputService.TouchEnded:connect(function(otherPart: userdata) -- line: 551
        -- upvalues:
        --  [1] t7 (copy)

        if otherPart == t7.moveTouchObject then
            t7:OnInputEnded()
        end
    end)
    GuiService.MenuOpened:connect(function() -- line: 557
        -- upvalues:
        --  [1] t7 (copy)

        if t7.moveTouchObject then
            t7:OnInputEnded()
        end
    end)
    local PlayerGui_1 = v2:FindFirstChildOfClass("PlayerGui")

    while not PlayerGui_1 do
        v2.ChildAdded:wait()
        PlayerGui_1 = v2:FindFirstChildOfClass("PlayerGui")
    end

    onCurrentCameraChanged = PlayerGui_1.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft or PlayerGui_1.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight

    local _ = function() --[[ longShowBackground ]] -- line: 573
        -- upvalues:
        --  [1] t7 (copy)

        t7.fadeInAndOutHalfDuration = 2.5
        t7.fadeInAndOutBalance = 0.05
        t7.tweenInAlphaStart = tick()
    end

    local v44 = nil
    v44 = PlayerGui_1:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(function() -- line: 579
        -- upvalues:
        --  [1] onCurrentCameraChanged (copy)
        --  [2] PlayerGui_1 (ref)
        --  [3] v44 (ref)
        --  [4] t7 (copy)

        if onCurrentCameraChanged then
            if PlayerGui_1.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait then
                if not onCurrentCameraChanged and PlayerGui_1.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait then
                    v44:disconnect()
                    t7.fadeInAndOutHalfDuration = 2.5
                    t7.fadeInAndOutBalance = 0.05
                    t7.tweenInAlphaStart = tick()

                    if onCurrentCameraChanged then
                        t7.hasFadedBackgroundInPortrait = true

                        return
                    else
                        t7.hasFadedBackgroundInLandscape = true
                    end
                end

                return
            end

            v44:disconnect()
            t7.fadeInAndOutHalfDuration = 2.5
            t7.fadeInAndOutBalance = 0.05
            t7.tweenInAlphaStart = tick()

            if onCurrentCameraChanged then
                t7.hasFadedBackgroundInPortrait = true

                return
            end

            t7.hasFadedBackgroundInLandscape = true

            return
        else
            if not onCurrentCameraChanged and PlayerGui_1.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait then
                v44:disconnect()
                t7.fadeInAndOutHalfDuration = 2.5
                t7.fadeInAndOutBalance = 0.05
                t7.tweenInAlphaStart = tick()

                if onCurrentCameraChanged then
                    t7.hasFadedBackgroundInPortrait = true

                    return
                end

                t7.hasFadedBackgroundInLandscape = true
            end

            return
        end
    end)
    t7.thumbstickFrame.Parent = u4

    if game:IsLoaded() then
        t7.fadeInAndOutHalfDuration = 2.5
        t7.fadeInAndOutBalance = 0.05
        t7.tweenInAlphaStart = tick()
    else
        coroutine.wrap(function() -- line: 599
            -- upvalues:
            --  [1] t7 (copy)

            game.Loaded:Wait()
            t7.fadeInAndOutHalfDuration = 2.5
            t7.fadeInAndOutBalance = 0.05
            t7.tweenInAlphaStart = tick()
        end)()
    end
end

return t_1
