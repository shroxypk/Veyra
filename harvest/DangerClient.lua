-- Decompiled with Veyra harvester
-- Instance: StarterGui.DangerUI.DangerClient
-- Class: LocalScript
-- bytes: 1268

local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local v1, _ = require(ReplicatedStorage.Modules.scriptObjs).GetPlayerCharacter()
local InCombat = script.Parent.InCombat
v1:GetAttributeChangedSignal("InCombat"):Connect(function() -- line: 9
    -- upvalues:
    --  [1] InCombat (copy)
    --  [2] v1 (copy)

    InCombat.Visible = v1:GetAttribute("InCombat")
end)

local function syncAttribute() -- line: 13
    -- upvalues:
    --  [1] v1 (copy)
    --  [2] InCombat (copy)

    local v4 = v1:GetAttribute("CombatTimer") or 0

    if if v1:GetAttribute("InCombat") ~= "PlayerCombat" then false else true then
        InCombat.Icon.ImageColor3 = Color3.fromRGB(255, 75, 75)
    else
        InCombat.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    end

    InCombat.Timer.Text = math.ceil(v4) .. "s"
end

InCombat.Icon.MouseEnter:Connect(function() -- line: 25
    -- upvalues:
    --  [1] InCombat (copy)

    InCombat.Timer.Visible = true
end)
InCombat.Icon.MouseLeave:Connect(function() -- line: 29
    -- upvalues:
    --  [1] InCombat (copy)

    InCombat.Timer.Visible = false
end)
v1:GetAttributeChangedSignal("CombatTimer"):Connect(syncAttribute)
syncAttribute()
