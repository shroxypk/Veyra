-- Decompiled with Veyra harvester
-- Instance: StarterGui.Safezone.SafezoneClient
-- Class: LocalScript
-- bytes: 862

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local _, v3 = require(game:GetService("ReplicatedStorage").Modules.scriptObjs).GetPlayerCharacter()
local Humanoid = v3:WaitForChild("Humanoid")
local Parent = script.Parent

local function safeZoneChanged() -- line: 12
    -- upvalues:
    --  [1] Humanoid (copy)
    --  [2] Parent (copy)

    Parent.Enabled = Humanoid:GetAttribute("InSafezone")
end

Humanoid:GetAttributeChangedSignal("InSafezone"):Connect(safeZoneChanged)
Parent.Enabled = Humanoid:GetAttribute("InSafezone")
Parent.Frame.MouseEnter:Connect(function() -- line: 20
    -- upvalues:
    --  [1] Parent (copy)

    Parent.Frame.Tip.Visible = true
end)
Parent.Frame.MouseLeave:Connect(function() -- line: 23
    -- upvalues:
    --  [1] Parent (copy)

    Parent.Frame.Tip.Visible = false
end)
