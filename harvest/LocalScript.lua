-- Decompiled with Veyra harvester
-- Instance: StarterGui.Permanent.Window.Shop.Pages.Content.Items.Essence.Option4.Label.UIGradient.LocalScript
-- Class: LocalScript
-- bytes: 910

local TweenService = game:GetService("TweenService")
local Parent = script.Parent
local v1 = TweenService:Create(
    Parent,
    TweenInfo.new(1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out),
    { Offset = Vector2.new(1, 0) }
)
local vec2 = Vector2.new(-1, 0)
Parent.Offset = vec2

local function animate() -- line: 13
    -- upvalues:
    --  [1] v1 (copy)
    --  [2] Parent (copy)
    --  [3] vec2 (copy)
    --  [4] animate (copy)

    v1:Play()
    v1.Completed:Once(function() -- line: 15
        -- upvalues:
        --  [1] Parent (ref)
        --  [2] vec2 (ref)
        --  [3] animate (ref)

        Parent.Offset = vec2
        task.wait(1.25)
        animate()
    end)
end

v1:Play()
v1.Completed:Once(function() -- line: 15
    -- upvalues:
    --  [1] Parent (copy)
    --  [2] vec2 (copy)
    --  [3] animate (copy)

    Parent.Offset = vec2
    task.wait(1.25)
    animate()
end)
