-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.UI.Uxie.Main.Frames.Weapon.FrameHandle
-- Class: LocalScript
-- bytes: 2434

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage.Modules
local Basic_m = require(Modules.Basic)
local StatManager_m = require(Modules.StatManager)
local _ = require(Modules.Formatter)
local v2, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StatManager_m.require(v2)
local Parent = script.Parent
local t = { "Light", "Medium", "Heavy" }

local function getMain() -- line: 21
    -- upvalues:
    --  [1] t (copy)
    --  [2] v4 (copy)
    --  [3] Basic_m (copy)

    for _, val in t do
        if (v4:GetStat(`{val}Mastery`) or 1) > Basic_m.MasteryUncap then
            return val
        end
    end
end

local function updateDescription() -- line: 29
    -- upvalues:
    --  [1] getMain (copy)
    --  [2] t (copy)
    --  [3] v4 (copy)
    --  [4] Basic_m (copy)
    --  [5] Parent (copy)

    local v7 = getMain()
    local t_1 = {}
    local v8 = 0

    for _, val_1 in t do
        local v11 = v4:GetStat(`{val_1}Mastery`) or 1

        if val_1 ~= v7 and v11 > 1 then
            table.insert(t_1, `<b>{val_1}</b> (Lv. {v11})`)
            v8 += (v11 - 1) * Basic_m.MasterySP
        end
    end

    if #t_1 == 0 then
        Parent.Description.Text = "Uxie offers to let your hands forget the weapons you never committed to. You have no unlocked weapon proficiency above level 1 to reset."
        Parent.Action.Visible = false

        return
    end

    Parent.Action.Visible = true
    local Description = Parent.Description
    local v13 = table.concat(t_1, ", ")
    Description.Text = `Uxie offers to let your hands forget the weapons you never committed to. Resets {v13} to level 1, returning <font color='rgb(255, 85, 127)'>{v8}</font> stat points.`
end

local v14 = false

local function onPress() -- line: 54
    -- upvalues:
    --  [1] v14 (ref)
    --  [2] ReplicatedStorage (copy)
    --  [3] Services_m (copy)
    --  [4] updateDescription (copy)

    if v14 then
        return
    end

    v14 = true

    if ReplicatedStorage.Remotes.ExchangeEvent:InvokeServer("ResetProficiency", 1) then
        Services_m.PlaySound(ReplicatedStorage.SFX.Misc.Coins, script)
    end

    v14 = false
    updateDescription()
end

updateDescription()
Parent.Action.MouseButton1Click:Connect(onPress)

for _, val_2 in t do
    v4:OnStatChanged(`{val_2}Mastery`, updateDescription)
end
