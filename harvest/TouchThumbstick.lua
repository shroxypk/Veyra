-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.TouchThumbstick
-- Class: ModuleScript
-- bytes: 9032

local _ = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local _ = UserSettings():GetService("UserGameSettings")
local Success, Result = pcall(function() -- line: 13
    return UserSettings():IsUserFeatureEnabled("UserClampClassicThumbstick")
end)
local v1 = Success and Result
local BaseCharacterController_m = require(script.Parent:WaitForChild("BaseCharacterController"))
local t = setmetatable({}, BaseCharacterController_m)
t.__index = t

function t.new() -- line: 26
    -- upvalues:
    --  [1] BaseCharacterController_m (copy)
    --  [2] t (copy)

    local t_1 = setmetatable(BaseCharacterController_m.new(), t)
    t_1.isFollowStick = false
    t_1.thumbstickFrame = nil
    t_1.moveTouchObject = nil
    t_1.onTouchMovedConn = nil
    t_1.onTouchEndedConn = nil
    t_1.screenPos = nil
    t_1.stickImage = nil
    t_1.thumbstickSize = nil

    return t_1
end

function t.Enable(t1: table, b1: boolean?, arg1: any) -- line: 41
    if b1 == nil then
        return false
    end

    b1 = if b1 then true else false

    if t1.enabled == b1 then
        return true
    end

    t1.moveVector = Vector3.new(0, 0, 0)
    t1.isJumping = false

    if b1 then
        if not t1.thumbstickFrame then
            t1:Create(arg1)
        end

        t1.thumbstickFrame.Visible = true
    else
        t1.thumbstickFrame.Visible = false
        t1:OnInputEnded()
    end

    t1.enabled = b1
end

function t.OnInputEnded(arg2) -- line: 62
    arg2.thumbstickFrame.Position = arg2.screenPos
    arg2.stickImage.Position = UDim2.new(
        0,
        arg2.thumbstickFrame.Size.X.Offset / 2 - arg2.thumbstickSize / 4,
        0,
        arg2.thumbstickFrame.Size.Y.Offset / 2 - arg2.thumbstickSize / 4
    )
    arg2.moveVector = Vector3.new(0, 0, 0)
    arg2.isJumping = false
    arg2.thumbstickFrame.Position = arg2.screenPos
    arg2.moveTouchObject = nil
end

function t.Create(arg3, arg4) -- line: 71
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] UserInputService (copy)
    --  [3] GuiService (copy)

    if arg3.thumbstickFrame then
        arg3.thumbstickFrame:Destroy()
        arg3.thumbstickFrame = nil

        if arg3.onTouchMovedConn then
            arg3.onTouchMovedConn:Disconnect()
            arg3.onTouchMovedConn = nil
        end

        if arg3.onTouchEndedConn then
            arg3.onTouchEndedConn:Disconnect()
            arg3.onTouchEndedConn = nil
        end

        if arg3.absoluteSizeChangedConn then
            arg3.absoluteSizeChangedConn:Disconnect()
            arg3.absoluteSizeChangedConn = nil
        end
    end

    arg3.thumbstickFrame = Instance.new("Frame")
    arg3.thumbstickFrame.Name = "ThumbstickFrame"
    arg3.thumbstickFrame.Active = true
    arg3.thumbstickFrame.Visible = false
    arg3.thumbstickFrame.BackgroundTransparency = 1
    local OuterImage_ImageLabel = Instance.new("ImageLabel")
    OuterImage_ImageLabel.Name = "OuterImage"
    OuterImage_ImageLabel.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
    OuterImage_ImageLabel.ImageRectOffset = Vector2.new()
    OuterImage_ImageLabel.ImageRectSize = Vector2.new(220, 220)
    OuterImage_ImageLabel.BackgroundTransparency = 1
    OuterImage_ImageLabel.Position = UDim2.new(0, 0, 0, 0)
    arg3.stickImage = Instance.new("ImageLabel")
    arg3.stickImage.Name = "StickImage"
    arg3.stickImage.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
    arg3.stickImage.ImageRectOffset = Vector2.new(220, 0)
    arg3.stickImage.ImageRectSize = Vector2.new(111, 111)
    arg3.stickImage.BackgroundTransparency = 1
    arg3.stickImage.ZIndex = 2

    local function ResizeThumbstick() -- line: 111
        -- upvalues:
        --  [1] arg4 (copy)
        --  [2] arg3 (copy)
        --  [3] OuterImage_ImageLabel (copy)

        local v5 = math.min(arg4.AbsoluteSize.X, arg4.AbsoluteSize.Y) <= 500 and true
        arg3.thumbstickSize = if not v5 then 120 else 70
        arg3.screenPos = v5 and UDim2.new(
            0,
            arg3.thumbstickSize / 2 - 10,
            1,
            -arg3.thumbstickSize - 20
        ) or UDim2.new(0, arg3.thumbstickSize / 2, 1, -arg3.thumbstickSize * 1.75)
        arg3.thumbstickFrame.Size = UDim2.new(0, arg3.thumbstickSize, 0, arg3.thumbstickSize)
        arg3.thumbstickFrame.Position = arg3.screenPos
        OuterImage_ImageLabel.Size = UDim2.new(0, arg3.thumbstickSize, 0, arg3.thumbstickSize)
        arg3.stickImage.Size = UDim2.new(0, arg3.thumbstickSize / 2, 0, arg3.thumbstickSize / 2)
        arg3.stickImage.Position = UDim2.new(
            0,
            arg3.thumbstickSize / 2 - arg3.thumbstickSize / 4,
            0,
            arg3.thumbstickSize / 2 - arg3.thumbstickSize / 4
        )
    end

    ResizeThumbstick()
    arg3.absoluteSizeChangedConn = arg4:GetPropertyChangedSignal("AbsoluteSize"):Connect(
        ResizeThumbstick
    )
    OuterImage_ImageLabel.Parent = arg3.thumbstickFrame
    arg3.stickImage.Parent = arg3.thumbstickFrame
    local vec2_2 = nil

    local _ = function(u1: Vector2) --[[ DoMove ]] -- line: 133
        -- upvalues:
        --  [1] arg3 (copy)
        --  [2] v1 (ref)

        local v9 = u1 / (arg3.thumbstickSize / 2)
        local Magnitude = v9.magnitude

        if Magnitude < 0.05 then
            v9 = Vector3.new()
        else
            v9 = if v1 then v9.unit * math.min(1, (Magnitude - 0.05) / 0.95) else v9.unit * ((Magnitude - 0.05) / 0.95)
            v9 = Vector3.new(v9.X, 0, v9.Y)
        end

        arg3.moveVector = v9
    end

    local function MoveStick(vec1: Vector3) -- line: 155
        -- upvalues:
        --  [1] vec2_2 (ref)
        --  [2] arg3 (copy)

        local v10 = Vector2.new(vec1.X - vec2_2.X, vec1.Y - vec2_2.Y)
        local Magnitude_1 = v10.magnitude
        local v11 = arg3.thumbstickFrame.AbsoluteSize.X / 2

        if arg3.isFollowStick and Magnitude_1 > v11 then
            local v12 = v10.unit * v11
            arg3.thumbstickFrame.Position = UDim2.new(
                0,
                vec1.X - arg3.thumbstickFrame.AbsoluteSize.X / 2 - v12.X,
                0,
                vec1.Y - arg3.thumbstickFrame.AbsoluteSize.Y / 2 - v12.Y
            )
        else
            v10 = v10.unit * math.min(Magnitude_1, v11)
        end

        arg3.stickImage.Position = UDim2.new(
            0,
            v10.X + arg3.stickImage.AbsoluteSize.X / 2,
            0,
            v10.Y + arg3.stickImage.AbsoluteSize.Y / 2
        )
    end

    arg3.thumbstickFrame.InputBegan:Connect(function(input: userdata) -- line: 172
        -- upvalues:
        --  [1] arg3 (copy)
        --  [2] vec2_2 (ref)

        if arg3.moveTouchObject or input.UserInputType ~= Enum.UserInputType.Touch or input.UserInputState ~= Enum.UserInputState.Begin then
            return
        end

        arg3.moveTouchObject = input
        arg3.thumbstickFrame.Position = UDim2.new(
            0,
            input.Position.X - arg3.thumbstickFrame.Size.X.Offset / 2,
            0,
            input.Position.Y - arg3.thumbstickFrame.Size.Y.Offset / 2
        )
        vec2_2 = Vector2.new(
            arg3.thumbstickFrame.AbsolutePosition.X + arg3.thumbstickFrame.AbsoluteSize.X / 2,
            arg3.thumbstickFrame.AbsolutePosition.Y + arg3.thumbstickFrame.AbsoluteSize.Y / 2
        )
        local _ = Vector2.new(input.Position.X - vec2_2.X, input.Position.Y - vec2_2.Y)
    end)
    arg3.onTouchMovedConn = UserInputService.TouchMoved:Connect(function(u3: userdata, _: boolean) -- line: 187
        -- upvalues:
        --  [1] arg3 (copy)
        --  [2] vec2_2 (ref)
        --  [3] v1 (ref)
        --  [4] MoveStick (copy)

        if u3 == arg3.moveTouchObject then
            vec2_2 = Vector2.new(
                arg3.thumbstickFrame.AbsolutePosition.X + arg3.thumbstickFrame.AbsoluteSize.X / 2,
                arg3.thumbstickFrame.AbsolutePosition.Y + arg3.thumbstickFrame.AbsoluteSize.Y / 2
            )
            local v13 = Vector2.new(u3.Position.X - vec2_2.X, u3.Position.Y - vec2_2.Y) / (arg3.thumbstickSize / 2)
            local Magnitude_2 = v13.magnitude

            if Magnitude_2 < 0.05 then
                v13 = Vector3.new()
            else
                v13 = if v1 then v13.unit * math.min(1, (Magnitude_2 - 0.05) / 0.95) else v13.unit * ((Magnitude_2 - 0.05) / 0.95)
                v13 = Vector3.new(v13.X, 0, v13.Y)
            end

            arg3.moveVector = v13
            MoveStick(u3.Position)
        end
    end)
    arg3.onTouchEndedConn = UserInputService.TouchEnded:Connect(function(arg5, _) -- line: 197
        -- upvalues:
        --  [1] arg3 (copy)

        if arg5 == arg3.moveTouchObject then
            arg3:OnInputEnded()
        end
    end)
    GuiService.MenuOpened:Connect(function() -- line: 203
        -- upvalues:
        --  [1] arg3 (copy)

        if arg3.moveTouchObject then
            arg3:OnInputEnded()
        end
    end)
    arg3.thumbstickFrame.Parent = arg4
end

return t
