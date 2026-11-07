-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.BackpackUtils
-- Class: ModuleScript
-- bytes: 32533

local _ = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Modules = ReplicatedStorage.Modules
local Basic_m = require(Modules.Basic)
local Items_m = require(Modules.Items)
local HalloweenWeapons_m = require(game:GetService("ReplicatedStorage").Modules.HalloweenWeapons)
local Formatter_m = require(Modules.Formatter)
local Skills_m = require(Modules.Skills)
local StatManager_m = require(Modules.StatManager)
local Weight_m = require(Modules.Weight)
local v3 = nil
local v4 = nil
local Zero = Vector2.zero
local t = {
    _keys = {
        [Enum.KeyCode.Zero] = 0,
        [Enum.KeyCode.One] = 1,
        [Enum.KeyCode.Two] = 2,
        [Enum.KeyCode.Three] = 3,
        [Enum.KeyCode.Four] = 4,
        [Enum.KeyCode.Five] = 5,
        [Enum.KeyCode.Six] = 6,
        [Enum.KeyCode.Seven] = 7,
        [Enum.KeyCode.Eight] = 8,
        [Enum.KeyCode.Nine] = 9
    },
    StatOrder = {
        ArmorType = -1,
        ["Health "] = 0,
        ["Energy "] = 1,
        ["Physical "] = 2,
        ["Magic "] = 2
    },
    validAttributes = {
        BaseDamage = " DMG",
        Weight = " WEIGHT",
        SwingSpeed = " SPEED",
        Scale = "Proficiency Scaling: ",
        Range = "Range: ",
        EnergyCost = " Energy Required",
        ArmorType = "Armor Type: ",
        Traits = "Trait: "
    }
}
t.inputTypes = require(script.inputTypes)
t.validKeys = require(script.keys)
t._armorStats = require(script.armorStats)
t._enchants = require(script.enchants)
t.SkillColors = require(script.SkillColors)
t.Categories = require(script.Categories)
t.__index = t
local t_4 = { CarryWeight = true }
local t_5 = {
    [0] = Color3.fromRGB(170, 170, 170),
    [1] = Color3.fromRGB(140, 220, 140),
    [2] = Color3.fromRGB(110, 170, 255),
    [3] = Color3.fromRGB(255, 200, 90)
}
local ValidAttributes = t.validAttributes
local t_6 = { "Fire ", "Shadow ", "Wind ", "Lightning ", "Light " }
local t_7 = { "Type", "ArmorType", "Slot", "Category", "SubType" }
local t_8 = { "FightingStyle" }
local t_9 = {}
local t_10 = { Stock = true, Q1 = true, Q2 = true, Q3 = true }
t.QualityColors = t_5
local v5 = nil

local function debugLog(...) -- line: 104
end

local _ = function(arg1) --[[ round ]] -- line: 110
    return (tonumber(string.format("%.2f", arg1)))
end

local _ = function(arg2) --[[ escapeRichText ]] -- line: 114
    return (tostring(arg2):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

local _ = function(arg3) --[[ trim ]] -- line: 118
    return (arg3:gsub("%s+$", ""))
end

local _ = function(arg4) --[[ formatNumber ]] -- line: 122
    return (tostring(math.floor(arg4 * 100 + 0.5) / 100))
end

function t.getValidStats(arg5) -- line: 126
    -- upvalues:
    --  [1] t (copy)

    local t_11 = {}
    local v6 = if typeof(arg5) ~= "table" then false else true

    local _ = function(arg6) --[[ getStat ]] -- line: 130
        -- upvalues:
        --  [1] v6 (copy)
        --  [2] arg5 (copy)

        if not arg6 then
            return nil
        end

        if v6 then
            return arg5[arg6]
        end

        return arg6
    end

    for key, val in t._armorStats do
        local v7 = val.Equipped
        local v8 = if v7 then if not v6 then v7 else arg5[v7] else nil
        local v9 = val.Visible
        v7 = if v9 then if not v6 then v9 else arg5[v9] else nil
        local v10 = val.Vanity
        v9 = if v10 then if not v6 then v10 else arg5[v10] else nil

        if v8 and v7 and v9 then
            v10 = v6 and key .. "Visible" or v7
            t_11[v10] = { Equipped = v8, Vanity = v9, VanityName = val.Vanity }
        end
    end

    return t_11
end

function t.getQualityBuckets(arg7) -- line: 161
    local v11 = tonumber(arg7:GetAttribute("Stock")) or 0
    local t_13 = {}
    local v12 = 0
    local v13 = 0

    for index = 1, 3 do
        local v15 = math.max(0, tonumber(arg7:GetAttribute("Q" .. index)) or 0)
        t_13[index] = v15
        v12 += v15

        if v15 > 0 then
            v13 = index
        end
    end

    t_13[0] = math.max(0, v11 - v12)

    return t_13, v13, v12 > 0 and true
end

function t.SetQuality(
    arg8,
    arg9,
    arg10,
    arg11,
    arg12
) -- line: 182
    -- upvalues:
    --  [1] Basic_m (copy)
    --  [2] Items_m (copy)

    if arg10 == "Game" then
        return
    end

    local Quality = arg9.Quality

    if Quality:IsA("Frame") then
        for _, child in Quality:GetChildren() do
            if child:IsA("ImageLabel") then
                child:Destroy()
            end
        end

        for _ = 1, arg11 do
            script.Star:Clone().Parent = Quality
        end
    else
        for index_2 = 1, Basic_m.MaxQuality do
            local _ = Basic_m.MaxQuality

            if arg11 >= index_2 then
                arg9.Quality.Text ..= "\226\152\133"
            else
                arg9.Quality.Text ..= "\226\152\134"
            end
        end
    end

    local v17 = if arg11 ~= Basic_m.MaxQuality then false else Color3.fromRGB(255, 198, 106)
    local v18 = arg12 and arg9.Parent or arg9
    local v19 = v18:GetAttribute("RealName") or v18.Name

    if v17 then
        v18.Outline.ImageColor3 = v17
    end

    v17 = Items_m:LookupItem(v19)

    if v17 and v17.Rarity == "Legendary" then
        local OutlineColor = arg8.Categories.Legendary.OutlineColor
        v18.BackgroundColor3 = arg8.Categories.Legendary.BackgroundColor
        v18.Outline.ImageColor3 = OutlineColor
    end

    if Quality:IsA("Frame") then
        local _, v21, v22 = v18.BackgroundColor3:ToHSV()

        if v22 > 0.75 and v21 < 0.25 then
            for _, child_1 in Quality:GetChildren() do
                if child_1:IsA("ImageLabel") then
                    child_1.ImageColor3 = Color3.fromRGB(45, 45, 50)
                    child_1.ImageTransparency = 0.15
                end
            end
        end
    end
end

function t.SetEnchantment(arg13, arg14, arg15, arg16) -- line: 237
    if arg15 == "" then
        return
    end

    arg14.Name = "." .. arg14.Name
    arg14.BackgroundColor3 = arg13.Categories.Enchant.BackgroundColor
    local v23 = arg16 and arg14.Parent:FindFirstChild("Glow") or arg14:FindFirstChild("Glow")

    if v23 then
        v23.ImageColor3 = Color3.fromRGB(150, 50, 0)
        v23.Visible = true
    end

    if arg16 then
        arg14.Parent.BackgroundColor3 = arg13.Categories.Enchant.BackgroundColor
        arg14.Parent.Outline.ImageColor3 = arg13.Categories.Enchant.OutlineColor

        return
    end

    arg14.Enchantment.Text = arg13._enchants[arg15] or "N/A"
    arg14.Outline.ImageColor3 = arg13.Categories.Enchant.OutlineColor
end

function t.getRequirements(arg17) -- line: 260
    local t_14 = {}

    for key_3, val_1 in arg17 do
        table.insert(t_14, key_3 .. " " .. val_1)
    end

    local v24 = ""

    for key_4, val_2 in ipairs(t_14) do
        v24 ..= val_2

        if key_4 < #t_14 then
            v24 ..= ", "
        end
    end

    return v24
end

function t.getAttrib(arg18, _, _, _) -- line: 275
    -- upvalues:
    --  [1] t_6 (copy)

    local v25 = arg18:match("%d+")
    local v26 = arg18:match("[%a%s]+")

    if v26 ~= "Physical " then
        if v26 ~= "Magic " then
            if table.find(t_6, v26) then
                return "+" .. v25 .. "% " .. v26 .. "Resistance"
            end

            if v26 == "DamagePvE " then
                return "+" .. v25 .. "% PvE Damage"
            end

            if v26 == "ManaRegen " then
                return "+" .. v25 .. "% Mana Regen"
            end

            if v26 == "HallowedWard " then
                return "+" .. v25 .. "% Hallowed Ward"
            end

            return "+" .. v25 .. " " .. v26
        else
            return "+" .. v25 .. "% " .. v26 .. "Resistance"
        end
    else
        return "+" .. v25 .. "% " .. v26 .. "Resistance"
    end
end

local _ = function(arg22, arg23) --[[ formatAttribute ]] -- line: 296
    arg23 = tostring(arg23)

    if arg22:sub(-1) == " " then
        return arg22 .. arg23
    end

    if arg22:sub(1, 1) == " " then
        return arg23 .. arg22
    end

    return arg22 .. arg23
end

local _ = function(arg24) --[[ sortEntries ]] -- line: 308
    table.sort(arg24, function(arg25, arg26) -- line: 309
        return if arg25.order == arg26.order then arg25.id < arg26.id else arg25.order < arg26.order
    end)
end

local function collectAttributeEntries(arg27, arg28, arg29, arg30) -- line: 318
    -- upvalues:
    --  [1] ValidAttributes (copy)
    --  [2] StatManager_m (copy)
    --  [3] Players (copy)
    --  [4] Basic_m (copy)
    --  [5] t (copy)

    for key_5, val_3 in ValidAttributes do
        local v27 = arg28[key_5]

        if v27 then
            local v28 = v27
            local num = nil

            if key_5 == "BaseDamage" and arg30 and arg28.Scale and arg29 then
                local v32 = StatManager_m.require(Players.LocalPlayer):GetStat(arg30 .. "Mastery")
                local v34 = Basic_m:CalculateWeaponDamage(
                    Basic_m:CalculateQualityDamage(arg28.BaseDamage, arg29:GetAttribute("Quality")),
                    v32,
                    arg28.Scale
                )
                v28 = `{v27} ({v34})`
                num = tonumber(v34)
            end

            local t_15 = {
                id = key_5,
                order = t.StatOrder[key_5] or 1,
                value = tonumber(v27) or v27,
                scaledValue = num,
                text = nil
            }
            local str = tostring(v28)
            t_15.text = if val_3:sub(-1) == " " then val_3 .. str else if val_3:sub(1, 1) == " " then str .. val_3 else val_3 .. str
            table.insert(arg27, t_15)
        end
    end
end

local function collectStatEntries(arg31, arg32, arg33) -- line: 349
    -- upvalues:
    --  [1] t (copy)

    local t_16 = {}
    local t_17 = {}

    local _ = function(arg34, arg35) --[[ add ]] -- line: 353
        -- upvalues:
        --  [1] t_16 (copy)
        --  [2] t_17 (copy)

        if not arg34 or not arg35 then
            return
        end

        if t_16[arg34] == nil then
            t_16[arg34] = 0
            table.insert(t_17, arg34)
        end

        local v36 = t_16
        v36[arg34] += arg35
    end

    if arg33 then
        local Stats = arg33:GetAttribute("Stats")

        if typeof(Stats) == "string" then
            for _, val_4 in Stats:split(",") do
                if val_4 ~= "" then
                    local v37 = val_4:match("[%a%s]+")
                    local num_1 = tonumber(val_4:match("%d+"))

                    if v37 and num_1 then
                        if t_16[v37] == nil then
                            t_16[v37] = 0
                            table.insert(t_17, v37)
                        end

                        t_16[v37] += num_1
                    end
                end
            end
        end
    end

    local Stats_1 = arg32._stats

    if Stats_1 then
        for key_7, val_5 in Stats_1 do
            local v38 = tonumber(val_5) or tonumber(tostring(val_5):match("%d+") or "")
            local v39 = key_7 .. " "

            if v39 and v38 then
                if t_16[v39] == nil then
                    t_16[v39] = 0
                    table.insert(t_17, v39)
                end

                t_16[v39] += v38
            end
        end
    end

    for _, val_6 in t_17 do
        local v40 = t_16[val_6]

        if v40 ~= 0 then
            table.insert(
                arg31,
                {
                    id = "stat:" .. val_6,
                    order = t.StatOrder[val_6] or 1,
                    value = v40,
                    text = t.getAttrib(val_6 .. v40)
                }
            )
        end
    end
end

local function collectItemEntries(arg36, arg37) -- line: 398
    -- upvalues:
    --  [1] collectStatEntries (copy)
    --  [2] collectAttributeEntries (copy)
    --  [3] Weight_m (copy)

    local t_19 = {}
    collectStatEntries(t_19, arg36, arg37)
    collectAttributeEntries(t_19, arg36, arg37, arg36.MasteryType)
    local v41 = Weight_m.GetItemWeight(arg36, arg37)

    if v41 > 0 then
        table.insert(
            t_19,
            {
                id = "CarryWeight",
                order = 99,
                value = v41,
                text = "Carry Weight: " .. Weight_m.FormatNumber(v41)
            }
        )
    end

    local v42 = Weight_m.GetEquipBonus(arg36)

    if v42 > 0 then
        table.insert(
            t_19,
            {
                id = "EquipCarryBonus",
                order = 99,
                value = v42,
                text = "+" .. Weight_m.FormatNumber(v42) .. " Max Carry Weight"
            }
        )
    end

    table.sort(t_19, function(arg38, arg39) -- line: 309
        return if arg38.order == arg39.order then arg38.id < arg39.id else arg38.order < arg39.order
    end)

    return t_19
end

local function comparableValues(arg40, arg41) -- line: 431
    local v43

    if arg41 == nil then
        v43 = arg40.scaledValue or arg40.value

        if typeof(v43) == "number" then
            return v43, 0
        end

        return nil, nil
    else
        v43 = if arg40.scaledValue == nil then false else arg41.scaledValue ~= nil
        local v44 = if not v43 then arg40.value else arg40.scaledValue
        local v45 = if not v43 then arg41.value else arg41.scaledValue

        if typeof(v44) == "number" and typeof(v45) == "number" then
            return v44, v45
        end

        return nil, nil
    end
end

local _ = function(arg42, arg43) --[[ deltaTag ]] -- line: 455
    -- upvalues:
    --  [1] t_4 (copy)

    local v46 = if not t_4[arg42] then arg43 > 0 else arg43 < 0
    local v47 = if not v46 then "#E65A5A" else "#78DC78"
    local v48 = if not v46 then "\226\134\147" else "\226\134\145"
    local v49 = if not (arg43 > 0) then "-" else "+"

    return `<font color="{v47}">{v48} ({v49 .. tostring(
        math.floor(math.abs(arg43) * 100 + 0.5) / 100
    )})</font>`
end

local function renderStats(arg44, arg45) -- line: 464
    -- upvalues:
    --  [1] comparableValues (copy)
    --  [2] t_4 (copy)

    local t_24 = nil

    if arg45 then
        t_24 = {}

        for _, val_7 in arg45 do
            t_24[val_7.id] = val_7
        end
    end

    local t_22 = {}
    local t_23 = {}

    for _, val_8 in arg44 do
        t_23[val_8.id] = true
        local v51 = tostring((val_8.text:gsub("%s+$", ""))):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
            ">",
            "&gt;"
        )

        if t_24 then
            local v52, v53 = comparableValues(val_8, t_24[val_8.id])

            if v52 and v53 and math.abs(v52 - v53) > 1E-06 then
                local v54 = v52 - v53
                local v55 = if not t_4[val_8.id] then v54 > 0 else v54 < 0
                local v56 = if not v55 then "#E65A5A" else "#78DC78"
                local v57 = if not v55 then "\226\134\147" else "\226\134\145"
                local v58 = if not (v54 > 0) then "-" else "+"
                v51 ..= " " .. `<font color="{v56}">{v57} ({v58 .. tostring(
                    math.floor(math.abs(v54) * 100 + 0.5) / 100
                )})</font>`
            end
        end

        table.insert(t_22, v51)
    end

    if arg45 then
        for _, val_9 in arg45 do
            if not t_23[val_9.id] then
                table.insert(
                    t_22,
                    `<font color="#E65A5A"><s>{tostring((val_9.text:gsub("%s+$", ""))):gsub(
                        "&",
                        "&amp;"
                    ):gsub("<", "&lt;"):gsub(">", "&gt;")}</s></font>`
                )
            end
        end
    end

    return table.concat(t_22, "\n")
end

local function renderBuckets(arg46) -- line: 506
    -- upvalues:
    --  [1] t_5 (copy)
    --  [2] Formatter_m (copy)

    local t_25 = { "<font color=\"#AAAAAA\">Quality</font>" }

    for index_3 = 0, 3 do
        local v60 = arg46[index_3]
        local v61 = t_5[index_3]:ToHex()
        local v62 = Formatter_m.addCommas(v60)
        local v63 = `<font color="#{v61}">{index_3}\226\152\133</font>  \195\151{v62}`

        if v60 <= 0 then
            v63 = `<font transparency="0.55">{v63}</font>`
        end

        table.insert(t_25, v63)
    end

    return table.concat(t_25, "\n")
end

local _ = function(arg47, _, arg49) --[[ fillBuckets ]] -- line: 524
    -- upvalues:
    --  [1] t (copy)
    --  [2] renderBuckets (copy)

    if not arg47 then
        return
    end

    local _

    if arg49 then
        if arg49:GetAttribute("Stock") == nil then
            arg47.Text = ""
            arg47.Visible = false

            return
        end

        local v64, v66
        v64, _, v66 = t.getQualityBuckets(arg49)
        arg47.Text = if v66 then renderBuckets(v64) else ""
        arg47.Visible = v66

        return
    else
        arg47.Text = ""
        arg47.Visible = false

        return
    end
end

local _ = function(arg50) --[[ isWeapon ]] -- line: 541
    return arg50.BaseDamage ~= nil or arg50.MasteryType ~= nil
end

local function getSlot(arg51) -- line: 546
    -- upvalues:
    --  [1] t_7 (copy)
    --  [2] t_9 (copy)
    --  [3] t (copy)
    --  [4] t_8 (copy)

    for _, val_10 in t_7 do
        local v69 = arg51[val_10]

        if typeof(v69) == "string" then
            if t_9[v69] then
                return v69, { t_9[v69] }
            end

            local v70 = t._armorStats[v69]
            local v71 = v70 and (v70.Equipped or v70.Stat)

            if v71 then
                return v69, { v71 }
            end
        end
    end

    if arg51.BaseDamage ~= nil or arg51.MasteryType ~= nil then
        return "Weapon", t_8
    end

    return nil, nil
end

local _ = function(arg52) --[[ isEmptyValue ]] -- line: 573
    return arg52 == nil or (arg52 == false or (arg52 == "" or arg52 == "None"))
end

local function resolveEquipped(arg53, arg54, arg55) -- line: 578
    -- upvalues:
    --  [1] getSlot (copy)
    --  [2] debugLog (copy)
    --  [3] StatManager_m (copy)
    --  [4] Players (copy)
    --  [5] Items_m (copy)
    --  [6] HalloweenWeapons_m (copy)
    --  [7] collectItemEntries (copy)

    local v74, v75 = getSlot(arg54)

    if not v75 then
        debugLog(
            arg53,
            "-> no slot match. Type =",
            arg54.Type,
            "| ArmorType =",
            arg54.ArmorType,
            "| Slot =",
            arg54.Slot,
            "| Category =",
            arg54.Category
        )

        return nil, false
    end

    local v76 = StatManager_m.require(Players.LocalPlayer)
    local v77 = nil
    local v78 = nil
    local v81

    for _, val_11 in v75 do
        local Success, Result = pcall(v76.GetStat, v76, val_11)
        debugLog(
            arg53,
            "-> slot:",
            v74,
            "| tried stat:",
            val_11,
            "| value:",
            if Success then Result else "ERR " .. tostring(Result)
        )

        if Success then
            v81 = Result == nil or (Result == false or (Result == "" or Result == "None"))

            if not v81 then
                v77 = Result
                v78 = val_11
                break
            end
        end
    end

    if v77 == nil then
        return nil, false
    end

    local str_1 = tostring(v77)

    if str_1 == arg53 then
        return nil, true
    end

    v77 = arg55:FindFirstChild(str_1)
    v75 = Items_m:LookupItem(str_1)

    if not v75 and v77 then
        local RealName = v77:GetAttribute("RealName")

        if RealName then
            v75 = Items_m:LookupItem(RealName)
        end
    end

    if not v75 then
        v81 = v77 ~= nil
        debugLog(
            arg53,
            "-> couldn't look up equipped item",
            str_1,
            "from",
            v78,
            "| container in Inventory:",
            v81
        )

        return nil, false
    end

    v81 = v77 ~= nil
    debugLog(
        arg53,
        "-> comparing against",
        str_1,
        "from",
        v78,
        "| container in Inventory:",
        v81
    )
    v75 = HalloweenWeapons_m.Apply(v75, v77)

    return { key = str_1, item = v75, container = v77, entries = collectItemEntries(v75, v77) }, false
end

local function makeFrame(arg56) -- line: 640
    -- upvalues:
    --  [1] Players (copy)

    local v82 = script.STATS:Clone()
    v82.Name = arg56
    v82.Visible = false
    v82.AnchorPoint = Vector2.zero
    v82.Parent = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Permanent")
    v82.Display.Header.RichText = true
    v82.Display.Stats.RichText = true
    local v83 = v82.Display.Stats:Clone()
    v83.Name = "Buckets"
    v83.LayoutOrder = v82.Display.Stats.LayoutOrder + 1
    v83.TextColor3 = Color3.fromRGB(225, 225, 225)
    v83.RichText = true
    v83.Text = ""
    v83.Visible = false
    v83.Parent = v82.Display

    return v82
end

function t.CreateFrame(_) -- line: 663
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] makeFrame (copy)

    v3 = makeFrame("STATS")

    return v3
end

function t.GetFrame(arg58) -- line: 668
    -- upvalues:
    --  [1] v3 (ref)

    if not v3 or not v3.Parent then
        v3 = nil

        return arg58:CreateFrame()
    end

    return v3
end

function t.GetCompareFrame(_) -- line: 677
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] makeFrame (copy)

    if not v4 or not v4.Parent then
        v4 = makeFrame("STATS_Compare")
        v4.Display.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end

    return v4
end

local function reset(arg60) -- line: 686
    arg60.Header.Text = ""
    arg60.Description.Text = ""
    arg60.Description.RichText = true
    arg60.Req.Text = ""
    arg60.Req.Visible = false
    arg60.Trade.Visible = false
    arg60.Locked.Visible = false
    arg60.Bounded.Visible = false
    arg60.Marks.Amount.Text = ""
    arg60.Marks.Visible = false
    arg60.Stats.Text = ""
    arg60.Stats.Visible = false
    arg60.Divider1.Visible = true
    local Buckets = arg60:FindFirstChild("Buckets")

    if Buckets then
        Buckets.Text = ""
        Buckets.Visible = false
    end
end

local function populateItem(
    arg61,
    arg62,
    arg63,
    arg64,
    arg65,
    arg66,
    arg67
) -- line: 710
    -- upvalues:
    --  [1] Formatter_m (copy)
    --  [2] HalloweenWeapons_m (copy)
    --  [3] t (copy)
    --  [4] Items_m (copy)
    --  [5] renderStats (copy)
    --  [6] renderBuckets (copy)

    local v84 = Formatter_m.formatItem(arg62)
    local v85 = arg63.Desc or (arg63.Description or "No description available.")
    v85 = if v85 == "" then "No description available" else v85
    local v86 = arg64

    if v86 then
        v86 = arg64:GetAttribute("Locked")
    end

    local v87 = arg64 and arg64:GetAttribute("Bounded") or arg63.Soulbound
    local v88 = arg63.Tradeable
    local Sellable = arg63.Sellable
    local v89

    if v88 then
        v89 = arg64

        if v89 then
            v89 = arg64:GetAttribute("Bounded") or arg64:GetAttribute("Untradable")
        end

        v88 = not v89
    end

    v89 = tostring(v84):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")

    if arg63.HalloweenLevel then
        v89 ..= ` <font color="#FF9A4A">Lv. {arg63.HalloweenLevel}</font>`
    end

    arg61.Header.Text = v89
    arg61.Parent.Equipped.Visible = arg67
    arg61.Description.RichText = arg63.HalloweenLevel ~= nil

    if arg63.HalloweenLevel then
        v89 = if arg63.HalloweenLevel < HalloweenWeapons_m.MAX_LEVEL then `Upgradable by {HalloweenWeapons_m.BLACKSMITH} on Gravelight Isle. Lv. {arg63.HalloweenLevel}/{HalloweenWeapons_m.MAX_LEVEL}` else `Fully upgraded (Lv. {HalloweenWeapons_m.MAX_LEVEL}/{HalloweenWeapons_m.MAX_LEVEL}).`
        v85 = `{tostring(v85):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")}\n<font color="#FF9A4A">{v89}</font>`
    end

    arg61.Description.Text = v85
    local v91 = arg63.Required or {}
    arg61.Req.Text = t.getRequirements(v91) .. " Required"
    arg61.Req.Visible = if arg61.Req.Text == " Required" then false else true
    arg61.Trade.Visible = if not v88 then false else true
    arg61.Locked.Visible = if not v86 then false else true
    arg61.Bounded.Visible = if not v87 then false else true
    arg61.Marks.Amount.Text = Formatter_m.addCommas(Items_m:GetSellPrice(v84) or 0)
    arg61.Marks.Visible = if Sellable then true else false
    arg61.Stats.Text = renderStats(arg65, arg66)
    arg61.Stats.Visible = arg61.Stats.Text ~= ""
    local Buckets_1 = arg61:FindFirstChild("Buckets")

    if not Buckets_1 then
        return
    end

    local _

    if arg64 then
        if arg64:GetAttribute("Stock") == nil then
            Buckets_1.Text = ""
            Buckets_1.Visible = false

            return
        end

        local v93, v95
        v93, _, v95 = t.getQualityBuckets(arg64)
        Buckets_1.Text = if v95 then renderBuckets(v93) else ""
        Buckets_1.Visible = v95

        return
    else
        Buckets_1.Text = ""
        Buckets_1.Visible = false

        return
    end
end

local _ = function() --[[ stopHoverWatch ]] -- line: 753
    -- upvalues:
    --  [1] v5 (ref)

    if v5 then
        v5:Disconnect()
        v5 = nil
    end
end

local _ = function() --[[ hideCompare ]] -- line: 760
    -- upvalues:
    --  [1] v4 (ref)

    if v4 then
        v4.Visible = false
    end
end

function t.ShowHover(arg68, arg69) -- line: 766
    -- upvalues:
    --  [1] Players (copy)
    --  [2] Zero (ref)
    --  [3] Items_m (copy)
    --  [4] Skills_m (copy)
    --  [5] v5 (ref)
    --  [6] reset (copy)
    --  [7] v4 (ref)
    --  [8] Formatter_m (copy)
    --  [9] HalloweenWeapons_m (copy)
    --  [10] collectItemEntries (copy)
    --  [11] resolveEquipped (copy)
    --  [12] populateItem (copy)
    --  [13] t_10 (copy)
    --  [14] t (copy)
    --  [15] renderBuckets (copy)
    --  [16] collectAttributeEntries (copy)
    --  [17] renderStats (copy)

    local Inventory = Players.LocalPlayer.Inventory
    local v97 = arg68:GetFrame()
    local Key = arg69.key
    local Text = arg69.text
    local v98 = if typeof(arg69.offset) == "Vector2" then arg69.offset else Vector2.zero
    Zero = v98
    v98 = Items_m:LookupItem(Key)
    local v99 = Skills_m:LookupSkill(Key)
    local Display_1 = v97.Display

    if v5 then
        v5:Disconnect()
        v5 = nil
    end

    reset(Display_1)
    local v103

    if Text then
        if v4 then
            v4.Visible = false
        end

        Display_1.Divider1.Visible = false
        v103 = tostring((Formatter_m.formatItem(Key))):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(
            ">",
            "&gt;"
        )
        local Header = Display_1.Header
        local v105

        if typeof(arg69.color) == "Color3" then
            local v104 = arg69.color:ToHex()
            v105 = `<font color="#{v104}">{v103}</font>`
        else
            v105 = v103
        end

        Header.Text = v105
        Display_1.Description.Text = Text
    elseif v98 then
        v103 = if typeof(arg69.container) == "Instance" then arg69.container else Inventory:FindFirstChild(
            Key
        )
        v98 = HalloweenWeapons_m.Apply(v98, v103)
        local v106 = collectItemEntries(v98, v103)
        local v107, v108 = resolveEquipped(Key, v98, Inventory)
        populateItem(
            Display_1,
            Key,
            v98,
            v103,
            v106,
            v107 and v107.entries,
            if not v108 then nil else "EQUIPPED"
        )

        if v103 and v103:GetAttribute("Stock") ~= nil then
            v5 = v103.AttributeChanged:Connect(function(attribute) -- line: 821
                -- upvalues:
                --  [1] t_10 (ref)
                --  [2] v97 (copy)
                --  [3] Display_1 (copy)
                --  [4] v98 (ref)
                --  [5] v103 (copy)
                --  [6] t (ref)
                --  [7] renderBuckets (ref)

                if t_10[attribute] and v97.Visible then
                    local Buckets_2 = Display_1:FindFirstChild("Buckets")
                    local v111 = v103

                    if not Buckets_2 then
                        return
                    end

                    local _

                    if v111 then
                        local _ = v98

                        if v111:GetAttribute("Stock") == nil then
                            Buckets_2.Text = ""
                            Buckets_2.Visible = false

                            return
                        end

                        local v113, v115
                        v113, _, v115 = t.getQualityBuckets(v111)
                        Buckets_2.Text = if v115 then renderBuckets(v113) else ""
                        Buckets_2.Visible = v115
                    else
                        local _ = v98
                        Buckets_2.Text = ""
                        Buckets_2.Visible = false

                        return
                    end
                end
            end)
        end

        if v107 then
            local v118 = arg68:GetCompareFrame()
            local Display_2 = v118.Display
            reset(Display_2)
            populateItem(
                Display_2,
                v107.key,
                v107.item,
                v107.container,
                v107.entries,
                nil,
                "EQUIPPED"
            )
            v118.Visible = true
        elseif v4 then
            v4.Visible = false
        end
    elseif v99 then
        if v4 then
            v4.Visible = false
        end

        local v119 = v99.Desc or (v99.Description or "No description available.")
        local v120 = if v119 ~= "" then v119 else "No description available"
        Display_1.Header.Text = tostring(Key):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
        Display_1.Description.Text = v120
        Display_1.Req.Text = ""
        local t_27 = {}
        collectAttributeEntries(t_27, v99, nil, nil)
        table.sort(t_27, function(arg71, arg72) -- line: 309
            return if arg71.order == arg72.order then arg71.id < arg72.id else arg71.order < arg72.order
        end)
        Display_1.Stats.Text = renderStats(t_27, nil)
        Display_1.Stats.Visible = if Display_1.Stats.Text == "" then false else true
    else
        if v4 then
            v4.Visible = false
        end

        warn("Invalid object for gui hover")

        return
    end

    v97.Visible = true
end

function t.HideHover(arg73) -- line: 874
    -- upvalues:
    --  [1] v5 (ref)
    --  [2] Zero (ref)
    --  [3] v4 (ref)

    if v5 then
        v5:Disconnect()
        v5 = nil
    end

    Zero = Vector2.zero
    arg73:GetFrame().Visible = false

    if v4 then
        v4.Visible = false
    end
end

if RunService:IsClient() then
    local _ = Players.LocalPlayer:GetMouse()
    RunService.RenderStepped:Connect(function() -- line: 886
        -- upvalues:
        --  [1] v3 (ref)
        --  [2] UserInputService (copy)
        --  [3] v4 (ref)
        --  [4] Zero (ref)

        if not v3 or not v3.Visible then
            return
        end

        local v124 = UserInputService:GetMouseLocation()
        local AbsoluteSize = v3.AbsoluteSize
        local ViewportSize = workspace.CurrentCamera.ViewportSize
        local v125 = if v4 ~= nil then v4.Visible else false
        local v126 = if not v125 then Vector2.zero else v4.AbsoluteSize
        local v127 = AbsoluteSize.X
        v127 = if not v125 then v127 else v127 + (6 + v126.X)
        local v128 = v124.X + Zero.X
        local v129 = v124.Y - AbsoluteSize.Y + Zero.Y
        v129 = if not (Zero.Y < 0) then v129 else if not (v129 < 0) then v129 else v124.Y - Zero.Y
        local v130 = math.max(0, ViewportSize.X - v127)
        local v131 = math.clamp(v128, 0, v130)
        local v132 = math.max(0, ViewportSize.Y - AbsoluteSize.Y)
        v129 = math.clamp(v129, 0, v132)
        v3.Position = UDim2.fromOffset(v131, v129)

        if v125 then
            v127 = v131 + AbsoluteSize.X + 6
            local v134 = math.max(0, ViewportSize.Y - v126.Y)
            v4.Position = UDim2.new(0, v127, 0, (math.clamp(v129, 0, v134)))
        end
    end)
end

return t
