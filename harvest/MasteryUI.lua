-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Player.Bars.Mastery.MasteryUI
-- Class: LocalScript
-- bytes: 1851

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local Basic_m = require(Modules.Basic)
local StatManager_m = require(Modules.StatManager)
local v1, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local v3 = StatManager_m.require(v1)
local Parent = script.Parent

function _G.SetupUI(arg1, arg2) -- line: 15
    -- upvalues:
    --  [1] Parent (copy)

    if typeof(arg1) ~= "string" then
        return
    end

    local v4 = Parent:FindFirstChild(arg1)

    if v4 then
        v4.Visible = arg2
    end
end

local _ = Parent.Light
local _ = Parent.Medium
local _ = Parent.Heavy
local t = { Light = Parent.Light, Medium = Parent.Medium, Heavy = Parent.Heavy }
local t_1 = {}

for key, val in t do
    t_1[key] = val.Title.Text
    script.Message:Clone().Parent = val.Title
end

function UpdateUI() -- line: 45
    -- upvalues:
    --  [1] t (copy)
    --  [2] v3 (copy)
    --  [3] t_1 (copy)
    --  [4] Basic_m (copy)

    for key_1, val_1 in t do
        local v8 = v3:GetStat(`{key_1}Mastery`)
        local v11 = v3:GetStat(`{key_1}MasteryXP`)
        local v14 = v3:GetStat(`{key_1}MasteryMXP`)
        val_1.Title.Text = `{t_1[key_1]} <font color='rgb(89, 102, 126)'>LVL {v8}</font>`
        local v15 = false
        local Message = val_1.Title.Message

        if v11 >= v14 then
            v15 = v8 < Basic_m.MaxMastery
        end

        Message.Visible = v15
        val_1.Front:TweenSize(
            UDim2.fromScale(math.clamp(v11 / v14, 0, 1), 1),
            "Out",
            "Quad",
            0.5,
            true
        )
    end
end

for key_2 in t do
    v3:OnStatChanged(`{key_2}Mastery`, UpdateUI)
    v3:OnStatChanged(`{key_2}MasteryXP`, UpdateUI)
    v3:OnStatChanged(`{key_2}MasteryMXP`, UpdateUI)
end

UpdateUI()
