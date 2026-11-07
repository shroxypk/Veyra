-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Titles.TitleStyle.Animator
-- Class: ModuleScript
-- bytes: 9782

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local t = {}

local _ = function(arg1, arg2, arg3) --[[ enumFrom ]] -- line: 27
    if typeof(arg2) ~= "string" then
        return arg3
    end

    local Success, Result = pcall(function() -- line: 31
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)

        return arg1[arg2]
    end)

    return Success and Result or arg3
end

local _ = function(arg4, arg5) --[[ number ]] -- line: 37
    local v2 = arg4

    if typeof(arg4) ~= "number" or not v2 then
        v2 = arg5
    end

    return v2
end

local _ = function(arg6, arg7) --[[ vector2 ]] -- line: 41
    local v3 = arg6

    if typeof(arg6) ~= "Vector2" or not v3 then
        v3 = arg7
    end

    return v3
end

local function lerp(arg8, arg9, arg10) -- line: 46
    if typeof(arg8) == "Color3" then
        return arg8:Lerp(arg9, arg10)
    end

    return arg8 + (arg9 - arg8) * arg10
end

local function sample(arg11, arg12) -- line: 53
    -- upvalues:
    --  [1] lerp (copy)

    for index = 1, #arg11 - 1 do
        local v4 = arg11[index]
        local v5 = arg11[index + 1]

        if arg12 <= v5.Time then
            local v6 = v5.Time - v4.Time
            local v7 = v6 > 0 and (arg12 - v4.Time) / v6 or 0

            return lerp(v4.Value, v5.Value, v7)
        end
    end

    return arg11[#arg11].Value
end

local _ = function(arg13) --[[ isConstant ]] -- line: 64
    local Value = arg13[1].Value

    for _, val in arg13 do
        if val.Value ~= Value then
            return false
        end
    end

    return true
end

local function shiftSequence(arg14, arg15, arg16, arg17) -- line: 75
    -- upvalues:
    --  [1] sample (copy)

    local v8 = sample(arg14, (1 - arg15) % 1)
    local t_1 = { arg16(0, v8) }

    for _, val_1 in arg14 do
        if val_1.Time < 1 then
            local v9 = (val_1.Time + arg15) % 1

            if v9 > 0.0001 and v9 < 0.9999 then
                table.insert(t_1, arg16(v9, val_1.Value))
            end
        end
    end

    table.insert(t_1, arg16(1, v8))
    table.sort(t_1, function(arg18, arg19) -- line: 87
        return arg18.Time < arg19.Time
    end)

    return arg17(t_1)
end

local function newColorKeypoint(arg20, arg21) -- line: 93
    return ColorSequenceKeypoint.new(arg20, arg21)
end

local function newNumberKeypoint(arg22, arg23) -- line: 96
    return NumberSequenceKeypoint.new(arg22, arg23)
end

local function readConfig(u1: userdata, arg24: any) -- line: 100
    local v12
    local Animation = u1:GetAttribute("Animation")
    local t_2 = {
        Kind = Animation,
        Duration = nil,
        Delay = nil,
        EasingStyle = nil,
        EasingDirection = nil,
        StartOffset = nil,
        EndOffset = nil,
        Direction = nil,
        BaseRotation = nil,
        BaseColor = nil,
        BaseTransparency = nil
    }
    local Duration = u1:GetAttribute("Duration")
    local v11 = Duration

    if typeof(Duration) ~= "number" or not v11 then
        v11 = 2
    end

    t_2.Duration = math.max(v11, 0.05)
    local Delay = u1:GetAttribute("Delay")
    v11 = Delay

    if typeof(Delay) ~= "number" or not v11 then
        v11 = 1
    end

    t_2.Delay = math.max(v11, 0)
    local EasingStyle = Enum.EasingStyle
    local EasingStyle_1 = u1:GetAttribute("EasingStyle")
    local EasingStyle_Circular = Enum.EasingStyle.Circular

    if typeof(EasingStyle_1) ~= "string" then
        v12 = EasingStyle_Circular
    else
        local Success_1, Result_1 = pcall(function() -- line: 31
            -- upvalues:
            --  [1] EasingStyle (copy)
            --  [2] EasingStyle_1 (copy)

            return EasingStyle[EasingStyle_1]
        end)
        v12 = Success_1 and Result_1 or EasingStyle_Circular
    end

    t_2.EasingStyle = v12
    local EasingDirection = Enum.EasingDirection
    local EasingDirection_1 = u1:GetAttribute("EasingDirection")
    local EasingDirection_Out = Enum.EasingDirection.Out

    if typeof(EasingDirection_1) ~= "string" then
        v12 = EasingDirection_Out
    else
        local Success_2, Result_2 = pcall(function() -- line: 31
            -- upvalues:
            --  [1] EasingDirection (copy)
            --  [2] EasingDirection_1 (copy)

            return EasingDirection[EasingDirection_1]
        end)
        v12 = Success_2 and Result_2 or EasingDirection_Out
    end

    t_2.EasingDirection = v12
    local StartOffset = u1:GetAttribute("StartOffset")
    local vec2 = Vector2.new(-1, 0)
    v12 = StartOffset

    if typeof(StartOffset) ~= "Vector2" or not v12 then
        v12 = vec2
    end

    t_2.StartOffset = v12
    local EndOffset = u1:GetAttribute("EndOffset")
    local vec2_1 = Vector2.new(1, 0)
    v12 = EndOffset

    if typeof(EndOffset) ~= "Vector2" or not v12 then
        v12 = vec2_1
    end

    t_2.EndOffset = v12
    t_2.Direction = if u1:GetAttribute("Reverse") then -1 else 1
    v12 = arg24 and arg24.BaseRotation or u1.Rotation
    t_2.BaseRotation = v12
    v12 = arg24 and arg24.BaseColor or u1.Color.Keypoints
    t_2.BaseColor = v12
    v12 = arg24 and arg24.BaseTransparency or u1.Transparency.Keypoints
    t_2.BaseTransparency = v12

    if Animation == "Scroll" then
        local BaseColor = t_2.BaseColor
        local Value_1 = BaseColor[1].Value
        local v13

        for _, val_2 in BaseColor do
            if val_2.Value ~= Value_1 then
                v13 = false
            end
        end

        v13 = true
        v12 = not v13 and #t_2.BaseColor < 20
        t_2.ScrollColor = v12
        local BaseTransparency = t_2.BaseTransparency
        local Value_2 = BaseTransparency[1].Value

        for _, val_3 in BaseTransparency do
            if val_3.Value ~= Value_2 then
                v13 = false
            end
        end

        v13 = true
        v12 = not v13 and #t_2.BaseTransparency < 20
        t_2.ScrollTransparency = v12
        local v14

        if not (#t_2.BaseColor >= 20) then
            if #t_2.BaseTransparency >= 20 then
                local g_warn = warn
                v14 = u1:GetFullName()
                g_warn(`[TitleStyle.Animator] '{v14}' needs fewer than {20} keypoints to Scroll`)

                return t_2
            end
        else
            local g_warn_1 = warn
            v14 = u1:GetFullName()
            g_warn_1(`[TitleStyle.Animator] '{v14}' needs fewer than {20} keypoints to Scroll`)

            return t_2
        end
    elseif Animation ~= "Shine" and Animation ~= "Rotate" then
        local g_warn_2 = warn
        local str = tostring(Animation)
        local v15 = u1:GetFullName()
        g_warn_2(
            `[TitleStyle.Animator] unknown Animation '{str}' on {v15} (use Shine, Scroll or Rotate)`
        )

        return nil
    end

    return t_2
end

local function step(u2: userdata, arg25: any, n1: number) -- line: 130
    -- upvalues:
    --  [1] TweenService (copy)
    --  [2] shiftSequence (copy)
    --  [3] newColorKeypoint (copy)
    --  [4] newNumberKeypoint (copy)

    local Kind = arg25.Kind

    if Kind == "Shine" then
        local v16 = n1 % (arg25.Duration + arg25.Delay)

        if v16 >= arg25.Duration then
            u2.Offset = arg25.StartOffset

            return
        end

        u2.Offset = arg25.StartOffset:Lerp(
            arg25.EndOffset,
            (TweenService:GetValue(v16 / arg25.Duration, arg25.EasingStyle, arg25.EasingDirection))
        )

        return
    else
        if Kind == "Scroll" then
            local v19 = n1 / arg25.Duration * arg25.Direction % 1

            if arg25.ScrollColor then
                u2.Color = shiftSequence(arg25.BaseColor, v19, newColorKeypoint, ColorSequence.new)
            end

            if arg25.ScrollTransparency then
                u2.Transparency = shiftSequence(
                    arg25.BaseTransparency,
                    v19,
                    newNumberKeypoint,
                    NumberSequence.new
                )

                return
            end
        elseif Kind == "Rotate" then
            u2.Rotation = (arg25.BaseRotation + 360 * (n1 / arg25.Duration % 1) * arg25.Direction) % 360
        end

        return
    end
end

local t_3 = {}

local function track(u3: userdata) -- line: 157
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] t (copy)
    --  [3] readConfig (copy)

    if not u3:IsA("UIGradient") or t_3[u3] then
        return
    end

    t[u3] = readConfig(u3)
    t_3[u3] = u3.AttributeChanged:Connect(function() -- line: 162
        -- upvalues:
        --  [1] t (ref)
        --  [2] u3 (copy)
        --  [3] readConfig (ref)

        t[u3] = readConfig(u3, t[u3])
    end)
end

local function untrack(u4: userdata) -- line: 167
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_3 (copy)

    t[u4] = nil
    local v24 = t_3[u4]

    if v24 then
        v24:Disconnect()
        t_3[u4] = nil
    end
end

CollectionService:GetInstanceAddedSignal("AnimatedTitleGradient"):Connect(track)
CollectionService:GetInstanceRemovedSignal("AnimatedTitleGradient"):Connect(untrack)

for _, val_4 in CollectionService:GetTagged("AnimatedTitleGradient") do
    track(val_4)
end

RunService.RenderStepped:Connect(function() -- line: 182
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_3 (copy)
    --  [3] step (copy)

    local clock = os.clock()

    for key_5, val_5 in t do
        if key_5.Parent == nil then
            t[key_5] = nil
            local v25 = t_3[key_5]

            if v25 then
                v25:Disconnect()
                t_3[key_5] = nil
            end
        else
            step(key_5, val_5, clock)
        end
    end
end)

return {}
