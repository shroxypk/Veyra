-- Decompiled with Veyra harvester
-- Instance: StarterGui.Permanent.Cursor
-- Class: LocalScript
-- bytes: 1074

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local _ = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local mouse = Players.LocalPlayer:GetMouse()
local _ = mouse.Icon
local MouseIcon = script.MouseIcon
local _ = {
    idle = "rbxassetid://98428842247007",
    shift = "rbxassetid://76829970172849",
    hidden = "rbxassetid://47872772"
}
MouseIcon.AnchorPoint = Vector2.zero
MouseIcon.Parent = script.Parent
RunService.Heartbeat:Connect(function() -- line: 21
    -- upvalues:
    --  [1] UserInputService (copy)
    --  [2] MouseIcon (copy)
    --  [3] mouse (copy)

    local v1 = UserInputService:GetMouseLocation()

    if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
        MouseIcon.Image = "rbxassetid://76829970172849"
    else
        MouseIcon.Image = "rbxassetid://98428842247007"
    end

    MouseIcon.Position = UDim2.fromOffset(v1.X - 22, v1.Y - 20)
    mouse.Icon = "rbxassetid://47872772"
    UserInputService.MouseIconEnabled = false
end)
