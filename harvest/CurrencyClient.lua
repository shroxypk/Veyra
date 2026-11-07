-- Decompiled with Veyra harvester
-- Instance: StarterGui.CurrencyUI.CurrencyClient
-- Class: LocalScript
-- bytes: 4859

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("MarketplaceService")
local _ = game:GetService("TweenService")
local _ = game:GetService("CollectionService")
local Modules = ReplicatedStorage.Modules
local StatManager_m = require(Modules.StatManager)
local Formatter_m = require(Modules.Formatter)
local v2, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StatManager_m.require(v2)
local UI = script.Parent.UI
local Marks_1 = nil
local Insight = nil
local Essence_1 = nil
local v8 = nil
local v9 = nil

local _ = function() --[[ updateOld ]] -- line: 22
    -- upvalues:
    --  [1] Marks_1 (ref)
    --  [2] v4 (copy)
    --  [3] Insight (ref)
    --  [4] Essence_1 (ref)
    --  [5] v8 (ref)
    --  [6] v9 (ref)

    Marks_1 = v4:GetStat("Marks")
    Insight = v4:GetStat("Insight")
    Essence_1 = v4:GetStat("Essence")
    v8 = v4:GetStat("LockedEssence") or 0
    v9 = v4:GetStat("CandyCorn") or 0
end

local function updateCurrency(arg1) -- line: 30
    -- upvalues:
    --  [1] v4 (copy)
    --  [2] UI (copy)
    --  [3] Formatter_m (copy)
    --  [4] Marks_1 (ref)
    --  [5] ReplicatedStorage (copy)
    --  [6] Insight (ref)
    --  [7] Essence_1 (ref)
    --  [8] v8 (ref)
    --  [9] v9 (ref)
    --  [10] Services_m (copy)

    local Marks = v4:GetStat("Marks")
    local v10 = math.floor(Marks)
    local Essence = v4:GetStat("Essence")
    UI.Marks.Amount.Text = if v10 > 1099511627776 then "INF" else Formatter_m.addCommas(v10)
    UI.Insight.Amount.Text = v4:GetStat("Insight")
    UI.Essence.Amount.Text = Formatter_m.addCommas(Essence)
    local v12 = v4:GetStat("LockedEssence") or 0
    UI.LockedEssence.Amount.Text = Formatter_m.addCommas(v12)
    UI.LockedEssence.Visible = v12 > 0 and true
    UI.CandyCorn.Amount.Text = Formatter_m.addCommas(v4:GetStat("CandyCorn") or 0)

    local function createIncrementText(arg2) -- line: 46
        -- upvalues:
        --  [1] UI (ref)
        --  [2] Marks_1 (ref)
        --  [3] ReplicatedStorage (ref)
        --  [4] Insight (ref)
        --  [5] Essence_1 (ref)
        --  [6] v8 (ref)
        --  [7] v9 (ref)
        --  [8] v4 (ref)
        --  [9] Services_m (ref)

        local t = {}
        t.Marks = {
            Parent = UI.Marks.Amount,
            old = Marks_1,
            sfx = ReplicatedStorage.SFX.Misc.Coins
        }
        t.Insight = { Parent = UI.Insight.Amount, old = Insight }
        t.Essence = { Parent = UI.Essence.Amount, old = Essence_1 }
        t.LockedEssence = { Parent = UI.LockedEssence.Amount, old = v8 }
        t.CandyCorn = { Parent = UI.CandyCorn.Amount, old = v9 }
        local Parent = t[arg2].Parent
        local Sfx = t[arg2].sfx
        local Old = t[arg2].old
        local v14 = (v4:GetStat(arg2) or 0) - (Old or 0)

        if v14 ~= 0 then
            if Sfx then
                Services_m.PlaySound(Sfx, script)
            end

            local v15 = script.increment:Clone()
            v15.TextStrokeColor3 = Parent.TextStrokeColor3
            v15.Text = v14 > 0 and "+" .. v14 or v14
            v15.Parent = Parent
            local t_6 = { Position = UDim2.new(0.2, 100, 0, 0) }
            _G.Tween(
                v15,
                { 0.35, "Quad", Enum.EasingDirection.Out },
                t_6,
                false,
                true
            )
            task.wait(0.1)
            local t_8 = {
                Position = UDim2.new(0.2, 100, -0.175, 0),
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }
            _G.Tween(v15, { 0.25, "Quad", Enum.EasingDirection.Out }, t_8, true)
        end
    end

    if not arg1 then
        task.spawn(createIncrementText, "Marks")
        task.spawn(createIncrementText, "Insight")
        task.spawn(createIncrementText, "Essence")
        task.spawn(createIncrementText, "LockedEssence")
        task.spawn(createIncrementText, "CandyCorn")
    end

    Marks_1 = v4:GetStat("Marks")
    Insight = v4:GetStat("Insight")
    Essence_1 = v4:GetStat("Essence")
    v8 = v4:GetStat("LockedEssence") or 0
    v9 = v4:GetStat("CandyCorn") or 0
end

v4:OnStatChanged("Marks", updateCurrency)
v4:OnStatChanged("Insight", updateCurrency)
v4:OnStatChanged("Essence", updateCurrency)
v4:OnStatChanged("LockedEssence", updateCurrency)
v4:OnStatChanged("CandyCorn", updateCurrency)
Marks_1 = v4:GetStat("Marks")
Insight = v4:GetStat("Insight")
Essence_1 = v4:GetStat("Essence")
v8 = v4:GetStat("LockedEssence") or 0
v9 = v4:GetStat("CandyCorn") or 0
updateCurrency(true)
local CurrencyInfo_m = require(Modules.CurrencyInfo)

for _, val in { "Marks", "Insight", "Essence", "LockedEssence", "CandyCorn" } do
    CurrencyInfo_m.AttachHover(UI[val], val)
end
