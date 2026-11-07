-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ButtonControl
-- Class: ModuleScript
-- bytes: 1712

local Players = game:GetService("Players")
local _ = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local v1 = PlayerGui:FindFirstChild("ScreenEffects")

if not v1 then
    v1 = Instance.new("ScreenGui")
    v1.Name = "ScreenEffects"
    v1.DisplayOrder = 999999999
    v1.IgnoreGuiInset = true
    v1.Parent = PlayerGui
end

local t = {}

function t.new(u1: userdata) -- line: 20
    -- upvalues:
    --  [1] UserInputService (copy)
    --  [2] v1 (ref)
    --  [3] TweenService (copy)

    u1.MouseEnter:Connect(function() -- line: 21
    end)

    if not u1:HasTag("IgnoreButtonControl") then
        u1.Activated:Connect(function() -- line: 26
            -- upvalues:
            --  [1] UserInputService (ref)
            --  [2] v1 (ref)
            --  [3] TweenService (ref)

            script.Click:Play()
            local v2 = Random.new():NextNumber(0.05, 0.1)
            local v3 = UserInputService:GetMouseLocation()
            local v4 = script.Ripple:Clone()
            v4.Parent = v1
            v4.Position = UDim2.new(0, v3.X, 0, v3.Y)
            local v5 = TweenService
            local v6 = v5:Create(
                v4,
                TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
                { ImageTransparency = 1, Size = UDim2.fromScale(v2, v2) }
            )
            v6.Completed:Once(function() -- line: 39
                -- upvalues:
                --  [1] v4 (copy)

                v4:Destroy()
            end)
            v6:Play()
        end)
    end
end

return t
