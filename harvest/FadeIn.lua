-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.UI.TeleportScreen.FadeIn
-- Class: LocalScript
-- bytes: 1201

local TweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local tweenInfo_1 = TweenInfo.new(
    0.75,
    Enum.EasingStyle.Sine,
    Enum.EasingDirection.Out,
    math.huge,
    true,
    0.1
)
local t = {
    Frame = { BackgroundTransparency = 0 },
    ImageLabel = { ImageTransparency = 0 },
    TextLabel = { TextStrokeTransparency = 0.7, TextTransparency = 0.5 }
}

for _, descendant in pairs(script.Parent:GetDescendants()) do
    local ClassName = descendant.ClassName
    local v2 = t[ClassName]

    if v2 then
        local v3 = TweenService:Create(descendant, tweenInfo, v2)
        v3.Completed:Connect(function() -- line: 17
            -- upvalues:
            --  [1] ClassName (copy)
            --  [2] TweenService (copy)
            --  [3] descendant (copy)
            --  [4] tweenInfo_1 (copy)

            if ClassName == "TextLabel" then
                TweenService:Create(
                    descendant,
                    tweenInfo_1,
                    { TextTransparency = 0, TextStrokeTransparency = 1 }
                ):Play()
            end
        end)
        v3:Play()
    end
end
