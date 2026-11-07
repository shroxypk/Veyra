-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.UI.TeleportScreen.Main.Icon.Rotate
-- Class: LocalScript
-- bytes: 257

local tweenInfo = TweenInfo.new(
    13,
    Enum.EasingStyle.Quad,
    Enum.EasingDirection.Out,
    -1,
    false,
    0
)
local Parent = script.Parent
game:GetService("TweenService"):Create(Parent, tweenInfo, { Rotation = Parent.Rotation + 360 }):Play()
