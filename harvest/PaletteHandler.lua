-- Decompiled with Veyra harvester
-- Instance: StarterGui.AllianceUI.Clans.EditFrame.Palette.Palette.PaletteHandler
-- Class: LocalScript
-- bytes: 4919

local _ = math.ceil
local math_clamp = math.clamp
local math_atan2 = math.atan2
local _ = tostring
local _ = string.sub
local FromHSV = Color3.fromHSV
local New = UDim2.new
local Parent = script.Parent
local New_1 = Vector2.new
local Ring = Parent:WaitForChild("Ring")
local Slider = Parent.Parent:WaitForChild("Slider")
local Slide = Slider:WaitForChild("Slide")
local Color = Parent.Parent.Slider:WaitForChild("Color")
local RGB = Parent.Parent.RGB
local Color_1 = Parent.Color
local UserInputService = game:GetService("UserInputService")
local mouse = game.Players.LocalPlayer:GetMouse()
local v1 = false
local v2 = false

local _ = function(arg1) --[[ toPolar ]] -- line: 32
    -- upvalues:
    --  [1] math_atan2 (copy)

    return math_atan2(arg1.y, arg1.x), arg1.magnitude
end

local _ = function(arg2) --[[ radToDeg ]] -- line: 36
    return (arg2 + 3.141592653589793) / 6.283185307179586 * 360
end

local v4 = 0
local v5 = 0
local v6 = 1

local _ = function(arg3) --[[ convertToRGB ]] -- line: 45
    -- upvalues:
    --  [1] math_clamp (copy)

    return (math_clamp(math.floor(arg3 * 255), 1, 255))
end

local function Update(arg4) -- line: 50
    -- upvalues:
    --  [1] FromHSV (copy)
    --  [2] v4 (ref)
    --  [3] v5 (ref)
    --  [4] v6 (ref)
    --  [5] Color (copy)
    --  [6] Color_1 (copy)
    --  [7] RGB (copy)
    --  [8] math_clamp (copy)

    local v7 = FromHSV(v4, v5, v6)
    Color.BackgroundColor3 = arg4 and arg4 or v7
    Color_1.ImageColor3 = Color.BackgroundColor3
    RGB.R.TextBox.Text = math_clamp(math.floor(Color.BackgroundColor3.R * 255), 1, 255)
    RGB.G.TextBox.Text = math_clamp(math.floor(Color.BackgroundColor3.G * 255), 1, 255)
    RGB.B.TextBox.Text = math_clamp(math.floor(Color.BackgroundColor3.B * 255), 1, 255)
end

local function UpdateSlide(_, arg6) -- line: 63
    -- upvalues:
    --  [1] Slider (copy)
    --  [2] Slide (copy)
    --  [3] math_clamp (copy)
    --  [4] New (copy)
    --  [5] v6 (ref)
    --  [6] FromHSV (copy)
    --  [7] Update (copy)

    local v9 = math_clamp(
        arg6 - Slider.AbsolutePosition.y,
        0,
        Slider.AbsoluteSize.y - Slide.AbsoluteSize.y
    )
    Slide.Position = New(0.5, 0, 0, v9)
    v6 = 1 - v9 / (Slider.AbsoluteSize.y - Slide.AbsoluteSize.y)
    Slide.BackgroundColor3 = FromHSV(0, 0, 1 - v6)
    Update()
end

local function UpdateRing(arg7, arg8) -- line: 73
    -- upvalues:
    --  [1] Parent (copy)
    --  [2] New_1 (copy)
    --  [3] Ring (copy)
    --  [4] New (copy)
    --  [5] math_atan2 (copy)
    --  [6] v4 (ref)
    --  [7] v5 (ref)
    --  [8] Slider (copy)
    --  [9] FromHSV (copy)
    --  [10] Update (copy)

    local v12 = Parent.AbsoluteSize.x / 2
    local v14 = New_1(arg7, arg8) - Parent.AbsolutePosition - Parent.AbsoluteSize / 2

    if v14:Dot(v14) > v12 * v12 then
        v14 = v14.unit * v12
    end

    Ring.Position = New(0.5, v14.x, 0.5, v14.y)
    local v17 = v14 * New_1(1, -1)
    v4, v5 = (math_atan2(v17.y, v17.x) + 3.141592653589793) / 6.283185307179586 * 360 / 360, v17.magnitude / v12
    Slider.BackgroundColor3 = FromHSV(v4, v5, 1)
    Update()
end

Parent.MouseButton1Down:Connect(function() -- line: 90
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] UpdateRing (copy)
    --  [3] mouse (copy)

    v1 = true
    UpdateRing(mouse.X, mouse.Y)
end)
Slider.MouseButton1Down:Connect(function() -- line: 94
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] UpdateSlide (copy)
    --  [3] mouse (copy)

    v2 = true
    UpdateSlide(mouse.X, mouse.Y)
end)
UserInputService.InputEnded:Connect(function(input) -- line: 99
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] v2 (ref)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        v1 = false
        v2 = false
    end
end)
Parent.MouseMoved:Connect(function() -- line: 106
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] UpdateRing (copy)
    --  [3] mouse (copy)

    if v1 then
        UpdateRing(mouse.X, mouse.Y)
    end
end)
Slider.MouseMoved:Connect(function() -- line: 111
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] UpdateSlide (copy)
    --  [3] mouse (copy)

    if v2 then
        UpdateSlide(mouse.X, mouse.Y)
    end
end)

for _, descendant in pairs(RGB:GetDescendants()) do
    if descendant:IsA("TextBox") then
        descendant.FocusLost:Connect(function(_) -- line: 119
            -- upvalues:
            --  [1] RGB (copy)
            --  [2] Update (copy)

            local v20 = tonumber(RGB.R.TextBox.Text)
            local v21 = tonumber(RGB.G.TextBox.Text)
            local v22 = tonumber(RGB.B.TextBox.Text)

            if typeof(v20) ~= "number" then
                v20 = 255
            end

            if typeof(v21) ~= "number" then
                v21 = 255
            end

            if typeof(v22) ~= "number" then
                v22 = 255
            end

            Update(Color3.fromRGB(v20, v21, v22))
        end)
    end
end
