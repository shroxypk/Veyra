-- Decompiled with Veyra harvester
-- Instance: StarterGui.Permanent.Window.Party.Client.MemberTemplate.MemberHealth
-- Class: LocalScript
-- bytes: 1017

local Humanoid = script:WaitForChild("Figure").Value:WaitForChild("Humanoid")
local HealthBar = script.Parent.HealthBar
HealthBar.Front.BackgroundColor3 = Color3.fromRGB(255, 0, 0):lerp(
    Color3.fromRGB(170, 255, 126),
    Humanoid.Health / Humanoid.MaxHealth
)
HealthBar.Front.Size = UDim2.new(Humanoid.Health / Humanoid.MaxHealth, 0, 1, 0)
HealthBar.Loss.Size = UDim2.new(Humanoid.Health / Humanoid.MaxHealth, 0, 1, 0)
Humanoid.HealthChanged:Connect(function(health) -- line: 10
    -- upvalues:
    --  [1] HealthBar (copy)
    --  [2] Humanoid (copy)

    HealthBar.Front.BackgroundColor3 = Color3.fromRGB(255, 0, 0):lerp(
        Color3.fromRGB(170, 255, 126),
        health / Humanoid.MaxHealth
    )
    HealthBar.Front:TweenSize(
        UDim2.new(health / Humanoid.MaxHealth, 0, 1, 0),
        "Out",
        "Quad",
        0.5,
        true
    )
    HealthBar.Loss:TweenSize(
        UDim2.new(health / Humanoid.MaxHealth, 0, 1, 0),
        "Out",
        "Quad",
        1.5,
        true
    )
end)
