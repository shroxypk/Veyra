-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Player.Compass.CompassHandler
-- Class: LocalScript
-- bytes: 1914

local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local _, _ = require(ReplicatedStorage.Modules.scriptObjs).GetPlayerCharacter()
local CurrentCamera = workspace.CurrentCamera
local CompassFrame = script.Parent:WaitForChild("CompassFrame")
local DirectionLabelTemplate = script:WaitForChild("DirectionLabelTemplate")
local v3 = nil
local v4 = 0
local t = {
    N = { Angle = 0 },
    NE = { Angle = 45 },
    E = { Angle = 90 },
    SE = { Angle = 135 },
    S = { Angle = 180 },
    SW = { Angle = -135 },
    W = { Angle = -90 },
    NW = { Angle = -45 }
}

for key, val in t do
    local v5 = DirectionLabelTemplate:Clone()
    v5.Name = key
    v5.Text = key
    v5.Visible = true
    v5.Parent = CompassFrame
    val.Label = v5
end

local function setWidth() -- line: 44
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] CompassFrame (copy)

    v3 = CompassFrame.AbsoluteSize.X + 200
end

local function updateCompass(arg1) -- line: 48
    -- upvalues:
    --  [1] t (copy)
    --  [2] v3 (ref)

    for _, val_1 in t do
        local Label = val_1.Label
        local v6 = (val_1.Angle - arg1 + 180) % 360 - 180
        local v7 = v6 / 135 * (v3 / 2)
        Label.TextTransparency = math.clamp(math.abs(v6) / 94.5, 0, 1)
        Label.Position = UDim2.new(0.5, v7, 0, 0)
    end
end

v3 = CompassFrame.AbsoluteSize.X + 200
CompassFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(setWidth)
RunService.RenderStepped:Connect(function(deltaTime) -- line: 68
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] v4 (ref)
    --  [3] updateCompass (copy)

    local LookVector = CurrentCamera.CFrame.LookVector
    local v8 = math.atan2(LookVector.X, -LookVector.Z)
    local v9 = (math.deg(v8) - v4 + 180) % 360 - 180
    v4 = v4 + v9 * math.clamp(deltaTime * 10, 0, 1)
    updateCompass(v4)
end)
