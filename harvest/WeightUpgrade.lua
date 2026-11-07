-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Chat.DialogueClient.DialogueManager.Actions.WeightUpgrade
-- Class: ModuleScript
-- bytes: 2151

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ContextActionService = game:GetService("ContextActionService")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local function fadeScreen() -- line: 13
    -- upvalues:
    --  [1] PlayerGui (copy)
    --  [2] TweenService (copy)

    local YosugaFade_ScreenGui = Instance.new("ScreenGui")
    YosugaFade_ScreenGui.Name = "YosugaFade"
    YosugaFade_ScreenGui.IgnoreGuiInset = true
    YosugaFade_ScreenGui.ResetOnSpawn = false
    YosugaFade_ScreenGui.DisplayOrder = 1000
    YosugaFade_ScreenGui.Parent = PlayerGui
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.fromScale(1, 1)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0
    Frame.Parent = YosugaFade_ScreenGui
    local v2 = TweenService:Create(
        Frame,
        TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { BackgroundTransparency = 0 }
    )
    v2:Play()
    v2.Completed:Wait()
    task.wait(0.5)
    local v4 = TweenService:Create(
        Frame,
        TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        { BackgroundTransparency = 1 }
    )
    v4:Play()
    v4.Completed:Wait()
    YosugaFade_ScreenGui:Destroy()
end

local function main(arg1) -- line: 49
    -- upvalues:
    --  [1] ContextActionService (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] fadeScreen (copy)

    ContextActionService:UnbindAction("ChatSkipKeys")
    arg1:HideChatBox()
    local YosugaWeightUpgrade = ReplicatedStorage.Remotes:FindFirstChild("YosugaWeightUpgrade")

    if not YosugaWeightUpgrade then
        warn("[WeightUpgrade] YosugaWeightUpgrade remote not found")

        return
    end

    local Success, Result = pcall(function() -- line: 61
        -- upvalues:
        --  [1] YosugaWeightUpgrade (copy)

        return YosugaWeightUpgrade:InvokeServer()
    end)

    if Success and Result == true then
        fadeScreen()
    end
end

return main
