-- Decompiled with Veyra harvester
-- Instance: StarterGui.AlchemyUI.Main.AlchemyClient
-- Class: LocalScript
-- bytes: 71464

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local v1 = ReplicatedStorage:WaitForChild("Modules")
local Alchemy_m = require(v1.Alchemy)
local Items_m = require(v1.Items)
local ViewportHandle_m = require(v1.ViewportHandle)
local BackpackUtils_m = require(v1.BackpackUtils)
local Professions_m = require(v1.Professions)
local LocalPlayer = Players.LocalPlayer
local Inventory = LocalPlayer:WaitForChild("Inventory")
local Professions = LocalPlayer:WaitForChild("Professions")
local Alchemy = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Alchemy")
local AlchemyRemote = Alchemy:WaitForChild("AlchemyRemote")
local Open = Alchemy:WaitForChild("Open")
local Parent = script.Parent
local Window = Parent:WaitForChild("Window")
local Templates = Parent:WaitForChild("Templates")
local t = {
    Scale = Window.Scale,
    Header = Window.Header,
    BrewView = Window.BrewView,
    BookView = Window.BookView
}
t.Tabs = t.Header.Tabs
t.Ingredients = t.BrewView.Ingredients
t.Grid = t.Ingredients.Grid
t.Search = t.Ingredients.Search.Box
t.Filters = t.Ingredients.Filters
t.Stage = t.BrewView.Cauldron.Stage
t.Batch = t.BrewView.Cauldron.Batch
t.Result = t.BrewView.Result
t.PotionList = t.BookView.Potions.List
t.BookSearch = t.BookView.Potions.Search.Box
t.Detail = t.BookView.Detail
t.Recipe = t.BookView.Recipe
local t_1 = {
    BUTTON = Color3.fromRGB(30, 24, 44),
    BUTTON_ON = Color3.fromRGB(58, 45, 90),
    BUTTON_OFF = Color3.fromRGB(34, 30, 44),
    CARD = Color3.fromRGB(32, 26, 48),
    ACCENT = Color3.fromRGB(196, 160, 255),
    TEXT = Color3.fromRGB(225, 225, 225),
    DIM = Color3.fromRGB(175, 175, 175),
    OFF = Color3.fromRGB(120, 120, 130)
}
local t_2 = {
    GOOD = "rgb(212, 255, 155)",
    BAD = "rgb(255, 94, 97)",
    WARN = "rgb(255, 220, 140)",
    DIM = "rgb(175, 175, 175)",
    ACCENT = "rgb(196, 160, 255)",
    STAR = "rgb(255, 207, 92)"
}
local font = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold)
local Star = v1.BackpackUtils:FindFirstChild("Star")
v1 = Star and Star.Image or "rbxassetid://11739217830"

local _ = function(arg1) --[[ cloneTemplate ]] -- line: 87
    -- upvalues:
    --  [1] Templates (copy)

    local v2 = Templates[arg1]:Clone()
    v2.Visible = true

    return v2
end

local _ = function(arg2) --[[ rgb ]] -- line: 93
    return string.format("rgb(%d, %d, %d)", arg2.R * 255, arg2.G * 255, arg2.B * 255)
end

local _ = function(arg3, arg4) --[[ colored ]] -- line: 97
    return `<font color="{arg4}">{arg3}</font>`
end

local _ = function(arg5, arg6) --[[ setSelected ]] -- line: 101
    local SelectedOutline = arg5:FindFirstChild("SelectedOutline")

    if SelectedOutline then
        SelectedOutline.Visible = arg6
    end
end

local _ = function(arg7, arg8) --[[ styleButton ]] -- line: 108
    -- upvalues:
    --  [1] t_1 (copy)

    local v3 = arg8 and t_1.BUTTON_ON or t_1.BUTTON_OFF
    arg7.BackgroundColor3 = v3
    v3 = arg7:FindFirstChild("Label")

    if v3 then
        v3.TextColor3 = arg8 and t_1.TEXT or t_1.OFF
    end

    local SelectedOutline_1 = arg7:FindFirstChild("SelectedOutline")

    if SelectedOutline_1 then
        SelectedOutline_1.Visible = arg8
    end
end

local function clearChildren(arg9, arg10) -- line: 117
    -- upvalues:
    --  [1] ViewportHandle_m (copy)

    for _, child in arg9:GetChildren() do
        if arg10 then
            if not child:IsA("UIListLayout") and not child:IsA("UIPadding") and not child:IsA(
                "UIGridLayout"
            ) then
                if child:IsA("ViewportFrame") then
                    ViewportHandle_m:Destroy(child)
                end

                child:Destroy()
            end
        else
            if child:IsA("ViewportFrame") then
                ViewportHandle_m:Destroy(child)
            end

            child:Destroy()
        end
    end
end

local _ = function(arg11) --[[ holderOf ]] -- line: 128
    return arg11:FindFirstChild("Holder") or arg11
end

local function setIcon(arg12, arg13, arg14) -- line: 133
    -- upvalues:
    --  [1] ViewportHandle_m (copy)

    local v5 = arg12:FindFirstChild("Holder") or arg12
    local v7

    if arg13 then
        v7 = (if not arg14 then "" else "spin:") .. arg13 or nil
    else
        v7 = nil
    end

    if v5:GetAttribute("Item") == v7 then
        return
    end

    v5:SetAttribute("Item", v7)

    for _, child_1 in v5:GetChildren() do
        if child_1:IsA("ViewportFrame") then
            ViewportHandle_m:Destroy(child_1)
        end

        child_1:Destroy()
    end

    if not arg13 then
        return
    end

    v7 = ViewportHandle_m.new(arg13, v5, not arg14)

    if v7 then
        v7.AnchorPoint = Vector2.new(0.5, 0.5)
        v7.Position = UDim2.fromScale(0.5, 0.5)
        v7.Size = UDim2.fromScale(1, 1)
        v7.BackgroundTransparency = 1
        v7.ZIndex = v5.ZIndex + 1
        v7.Ambient = Color3.fromRGB(215, 210, 220)
        v7.LightColor = Color3.fromRGB(255, 246, 240)
        v7.LightDirection = Vector3.new(-1, -1.5, -1)
    end
end

local function setImage(arg15, arg16, arg17, arg18) -- line: 157
    -- upvalues:
    --  [1] ViewportHandle_m (copy)
    --  [2] t_1 (copy)

    local v8 = arg15:FindFirstChild("Holder") or arg15

    if v8:GetAttribute("Item") == "image:" .. arg16 then
        return
    end

    v8:SetAttribute("Item", "image:" .. arg16)

    for _, child_2 in v8:GetChildren() do
        if child_2:IsA("ViewportFrame") then
            ViewportHandle_m:Destroy(child_2)
        end

        child_2:Destroy()
    end

    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = arg16
    local v10 = arg17 or t_1.OFF
    ImageLabel.ImageColor3 = v10
    ImageLabel.ScaleType = Enum.ScaleType.Fit
    ImageLabel.Size = UDim2.fromScale(arg18 or 0.6, arg18 or 0.6)
    ImageLabel.Position = UDim2.fromScale(0.5, 0.5)
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.ZIndex = v8.ZIndex + 1
    ImageLabel.Parent = v8
end

local function setGlyph(arg19, arg20, arg21) -- line: 176
    -- upvalues:
    --  [1] ViewportHandle_m (copy)
    --  [2] t_1 (copy)

    local v11 = arg19:FindFirstChild("Holder") or arg19

    if v11:GetAttribute("Item") == "glyph:" .. arg20 then
        return
    end

    v11:SetAttribute("Item", "glyph:" .. arg20)

    for _, child_3 in v11:GetChildren() do
        if child_3:IsA("ViewportFrame") then
            ViewportHandle_m:Destroy(child_3)
        end

        child_3:Destroy()
    end

    local TextLabel = Instance.new("TextLabel")
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = arg20
    local v13 = arg21 or t_1.ACCENT
    TextLabel.TextColor3 = v13
    TextLabel.TextScaled = true
    TextLabel.FontFace = Font.new(
        "rbxasset://fonts/families/AccanthisADFStd.json",
        Enum.FontWeight.Bold
    )
    TextLabel.Size = UDim2.fromScale(0.6, 0.6)
    TextLabel.Position = UDim2.fromScale(0.5, 0.5)
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    TextLabel.ZIndex = v11.ZIndex + 1
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(60, 30, 110)
    UIStroke.Thickness = 2
    UIStroke.Parent = TextLabel
    TextLabel.Parent = v11
end

local function renderSegments(arg22, arg23, arg24, arg25) -- line: 201
    -- upvalues:
    --  [1] clearChildren (copy)
    --  [2] font (copy)
    --  [3] t_1 (copy)
    --  [4] Star (copy)
    --  [5] v1 (copy)

    local v14 = {}

    for _, val in arg23 do
        local v15 = val

        if type(val) ~= "string" or not v15 then
            v15 = "*" .. val.stars
        end

        table.insert(v14, v15)
    end

    local v17 = table.concat(v14, "|") .. "@" .. tostring(arg24) .. ":" .. tostring(arg25)

    if arg22:GetAttribute("RenderKey") == v17 then
        return
    end

    arg22:SetAttribute("RenderKey", v17)
    clearChildren(arg22, true)
    arg24 = arg24 or 16

    for key_5, val_1 in arg23 do
        if type(val_1) == "string" then
            local TextLabel_1 = Instance.new("TextLabel")
            TextLabel_1.BackgroundTransparency = 1
            TextLabel_1.FontFace = font
            TextLabel_1.TextSize = arg25 or 13
            TextLabel_1.TextColor3 = t_1.TEXT
            TextLabel_1.RichText = true
            TextLabel_1.Text = val_1
            TextLabel_1.AutomaticSize = Enum.AutomaticSize.X
            TextLabel_1.Size = UDim2.fromOffset(0, arg24)
            TextLabel_1.LayoutOrder = key_5
            TextLabel_1.ZIndex = arg22.ZIndex + 1
            TextLabel_1.Parent = arg22
        elseif val_1.stars and val_1.stars > 0 then
            v14 = val_1.size or math.floor(arg24 * 0.85)

            for index = 1, math.clamp(val_1.stars, 0, 3) do
                local _ = math.clamp(val_1.stars, 0, 3)
                local v19 = Star and Star:Clone() or Instance.new("ImageLabel")
                v19.Name = "Star"
                v19.Image = v1
                v19.BackgroundTransparency = 1
                v19.ScaleType = Enum.ScaleType.Fit
                v19.SizeConstraint = Enum.SizeConstraint.RelativeXY
                v19.Size = UDim2.fromOffset(v14, v14)
                v19.Position = UDim2.new()
                v19.AnchorPoint = Vector2.zero
                v19.LayoutOrder = key_5 * 10 + index
                v19.ZIndex = arg22.ZIndex + 1
                v19.Parent = arg22
            end
        end
    end
end

local v20 = nil

local _ = function(arg26, arg27) --[[ showTip ]] -- line: 249
    -- upvalues:
    --  [1] v20 (ref)
    --  [2] BackpackUtils_m (copy)

    v20 = arg26
    pcall(function() -- line: 251
        -- upvalues:
        --  [1] BackpackUtils_m (ref)
        --  [2] arg27 (copy)

        BackpackUtils_m:ShowHover(arg27)
    end)
end

local _ = function(arg28) --[[ hideTip ]] -- line: 255
    -- upvalues:
    --  [1] v20 (ref)
    --  [2] BackpackUtils_m (copy)

    if v20 ~= nil and (arg28 == nil or v20 == arg28) then
        v20 = nil
        pcall(function() -- line: 258
            -- upvalues:
            --  [1] BackpackUtils_m (ref)

            BackpackUtils_m:HideHover()
        end)
    end
end

local function hoverTip(arg29, arg30) -- line: 263
    -- upvalues:
    --  [1] v20 (ref)
    --  [2] BackpackUtils_m (copy)

    arg29.MouseEnter:Connect(function() -- line: 264
        -- upvalues:
        --  [1] arg30 (copy)
        --  [2] arg29 (copy)
        --  [3] v20 (ref)
        --  [4] BackpackUtils_m (ref)

        local v21 = arg30()

        if v21 then
            v20 = arg29
            pcall(function() -- line: 251
                -- upvalues:
                --  [1] BackpackUtils_m (ref)
                --  [2] v21 (copy)

                BackpackUtils_m:ShowHover(v21)
            end)
        end
    end)
    arg29.MouseLeave:Connect(function() -- line: 270
        -- upvalues:
        --  [1] arg29 (copy)
        --  [2] v20 (ref)
        --  [3] BackpackUtils_m (ref)

        local v22 = arg29

        if v20 ~= nil and (v22 == nil or v20 == v22) then
            v20 = nil
            pcall(function() -- line: 258
                -- upvalues:
                --  [1] BackpackUtils_m (ref)

                BackpackUtils_m:HideHover()
            end)
        end
    end)
end

local t_3 = {
    Slots = {},
    Batch = 1,
    Filter = "All",
    Book = nil,
    BySignature = {},
    SelectedPotion = Alchemy_m.Order[1],
    RecipeIndex = {},
    View = "Brew",
    Busy = false,
    Station = nil,
    Prompt = nil,
    Dirty = true,
    Status = "",
    BookStatus = "",
    Tiles = {}
}

local function signature(arg31) -- line: 297
    local t_4 = {}

    for key_6, val_2 in arg31 do
        if val_2 > 0 then
            local v23 = math.floor(val_2)
            table.insert(t_4, `{key_6}:{v23}`)
        end
    end

    table.sort(t_4)

    return table.concat(t_4, "|")
end

local _ = function() --[[ getLevel ]] -- line: 308
    -- upvalues:
    --  [1] Alchemy_m (copy)
    --  [2] LocalPlayer (copy)

    return Alchemy_m.GetLevel(LocalPlayer)
end

local _ = function() --[[ getBenefits ]] -- line: 312
    -- upvalues:
    --  [1] Alchemy_m (copy)
    --  [2] LocalPlayer (copy)

    return Alchemy_m.GetBenefits(LocalPlayer)
end

local _ = function() --[[ getMaxBatch ]] -- line: 316
    -- upvalues:
    --  [1] Alchemy_m (copy)
    --  [2] LocalPlayer (copy)

    local v25 = math.floor(Alchemy_m.GetBenefits(LocalPlayer).bulk_brew or 0)

    return (math.max(1, v25))
end

local function getMaterials() -- line: 321
    -- upvalues:
    --  [1] Inventory (copy)
    --  [2] Items_m (copy)

    local t_5 = {}

    for _, child_4 in Inventory:GetChildren() do
        local v26 = child_4.Name:split("_")[1]
        local v27 = Items_m.AllItems[v26]

        if type(v27) == "table" and v27.Type == "Material" then
            local v28 = t_5[v26]

            if not v28 then
                local t_6 = { Stock = 0, Counts = nil }
                local t_7 = { [0] = 0, [1] = 0, [2] = 0 }
                t_7[3] = 0
                t_6.Counts = t_7
                v28 = t_6
                t_5[v26] = v28
            end

            local v29 = child_4:GetAttribute("Stock") or 0
            local v30 = child_4:GetAttribute("Q1") or 0
            local v31 = child_4:GetAttribute("Q2") or 0
            local v32 = child_4:GetAttribute("Q3") or 0
            v28.Stock += v29
            local Counts = v28.Counts
            local v33 = 0
            Counts[v33] = Counts[v33] + math.max(v29 - v30 - v31 - v32, 0)
            local Counts_1 = v28.Counts
            Counts_1[1] = Counts_1[1] + v30
            local Counts_2 = v28.Counts
            Counts_2[2] = Counts_2[2] + v31
            local Counts_3 = v28.Counts
            Counts_3[3] = Counts_3[3] + v32
        end
    end

    return t_5
end

local _ = function(arg32) --[[ getOwned ]] -- line: 346
    -- upvalues:
    --  [1] Inventory (copy)

    local v35 = Inventory:FindFirstChild(arg32)
    local v36

    if v35 then
        v36 = v35:GetAttribute("Stock")

        if not v36 then
            return 0
        end
    else
        v36 = 0
    end

    return v36
end

local function qualityOrder(arg33) -- line: 352
    local t_8 = { arg33 }

    for index_1 = arg33 - 1, 0, -1 do
        table.insert(t_8, index_1)
    end

    for index_2 = arg33 + 1, 3 do
        table.insert(t_8, index_2)
    end

    return t_8
end

local _ = function(arg34) --[[ bestStar ]] -- line: 364
    return if arg34 then if not (arg34.Counts[0] > 0) then if not (arg34.Counts[1] > 0) then if not (arg34.Counts[2] > 0) then if not (arg34.Counts[3] > 0) then 0 else 3 else 2 else 1 else 0 else 0
end

local function readMixture(arg35, arg36, arg37) -- line: 377
    -- upvalues:
    --  [1] Alchemy_m (copy)
    --  [2] qualityOrder (copy)

    local t_9 = {}
    local v37 = 0
    local v38 = true
    local v39 = 0
    local v40 = 0
    local v41

    for index_3 = 1, Alchemy_m.MaxSlots do
        v41 = arg35[index_3]
        local _ = Alchemy_m.MaxSlots

        if v41 then
            v37 += 1
            t_9[v41.Item] = (t_9[v41.Item] or 0) + v41.Amount
            local v42 = arg36[v41.Item]
            local v43 = v41.Amount * arg37
            v38 = if not v42 then false else if not (v43 > v42.Stock) then v38 else false

            if v42 then
                local v44 = v43

                for _, val_3 in qualityOrder(v41.Star) do
                    local v45 = math.min(v42.Counts[val_3], v44)
                    v39 += v45 * val_3
                    v40 += v45
                    v44 -= v45
                end
            end
        end
    end

    v41 = v40 > 0 and v39 / v40 or 0

    return t_9, v37, v38, v41
end

local function recipeSlots(arg38, arg39) -- line: 406
    local t_10 = {}

    for key_9 in arg38.Ingredients do
        table.insert(t_10, key_9)
    end

    table.sort(t_10)
    local t_11 = {}

    for key_10, val_4 in t_10 do
        local t_12 = { Item = val_4, Amount = arg38.Ingredients[val_4], Star = nil }
        local v46 = arg39[val_4]
        t_12.Star = if v46 then if not (v46.Counts[0] > 0) then if not (v46.Counts[1] > 0) then if not (v46.Counts[2] > 0) then if not (v46.Counts[3] > 0) then 0 else 3 else 2 else 1 else 0 else 0
        t_11[key_10] = t_12
    end

    return t_11
end

local function knownFor(arg40) -- line: 419
    -- upvalues:
    --  [1] t_3 (copy)

    local t_13 = {}

    if t_3.Book then
        for _, val_5 in t_3.Book.Known do
            if val_5.Potion == arg40 then
                table.insert(t_13, val_5)
            end
        end
    end

    table.sort(t_13, function(arg41, arg42) -- line: 428
        return if arg41.Tier == arg42.Tier then arg41.Level < arg42.Level else arg41.Tier < arg42.Tier
    end)

    return t_13
end

local _ = function(arg43) --[[ chanceColor ]] -- line: 437
    return if not (arg43 >= 75) then if not (arg43 >= 50) then "rgb(255, 94, 97)" else "rgb(255, 220, 140)" else "rgb(212, 255, 155)"
end

local function setStats(arg44, arg45) -- line: 445
    -- upvalues:
    --  [1] Templates (copy)
    --  [2] renderSegments (copy)

    local t_14 = {}

    for _, child_5 in arg44:GetChildren() do
        if child_5:IsA("Frame") then
            t_14[child_5.Name] = child_5
        end
    end

    for key_13, val_6 in arg45 do
        local v48 = "Row" .. key_13
        local v49 = t_14[v48]

        if not v49 then
            v49 = Templates.StatRow:Clone()
            v49.Visible = true
            v49.Name = v48
            v49.Parent = arg44
        end

        t_14[v48] = nil
        v49.LayoutOrder = key_13
        v49.StatName.Text = val_6[1]
        renderSegments(v49.Value, val_6[2], 22, 15)
    end

    for _, val_7 in t_14 do
        val_7:Destroy()
    end
end

local function qualitySegments(arg46) -- line: 470
    local v50 = nil
    local v51 = nil

    if (arg46[0] or 0) > 0.001 then
        v50 = v50 or 0
        v51 = 0
    end

    if (arg46[1] or 0) > 0.001 then
        v50 = v50 or 1
        v51 = 1
    end

    if (arg46[2] or 0) > 0.001 then
        v50 = v50 or 2
        v51 = 2
    end

    if (arg46[3] or 0) > 0.001 then
        v50 = v50 or 3
        v51 = 3
    end

    v50 = v50 or 0
    v51 = v51 or 0
    local t_15 = {}

    if v50 == 0 then
        table.insert(t_15, "Plain")
    else
        table.insert(t_15, { stars = v50 })
    end

    if v50 < v51 then
        local v52 = math.floor(arg46[v51] * 100 + 0.5)
        table.insert(t_15, `<font color="rgb(175, 175, 175)">{` {v52}%`}</font>`)
        table.insert(t_15, { stars = v51 })
    end

    return t_15
end

local function renderHeader() -- line: 497
    -- upvalues:
    --  [1] Alchemy_m (copy)
    --  [2] LocalPlayer (copy)
    --  [3] Professions_m (copy)
    --  [4] t (copy)
    --  [5] Professions (copy)

    local v53 = Alchemy_m.GetLevel(LocalPlayer)
    local v54 = Professions_m:GetRank(v53)
    local Level = t.Header.Level
    local Name = v54.Name
    Level.Text = `{Name} Alchemist   {`<font color="rgb(196, 160, 255)">{"Lv " .. v53}</font>`}`
    local XPBar = t.Header.XPBar

    if v53 >= Professions_m.MaxLevel then
        XPBar.Front.Size = UDim2.fromScale(1, 1)
        XPBar.Label.Text = "MAX"

        return
    end

    local v55 = Professions:FindFirstChild("AlchemyXP")
    local AlchemyMXP = Professions:FindFirstChild("AlchemyMXP")
    local v56 = v55 and v55.Value or 0
    v55 = AlchemyMXP and AlchemyMXP.Value or 0

    if v55 <= 0 then
        v55 = Professions_m:GetRequiredXP(Alchemy_m.Profession, v53)
    end

    XPBar.Front.Size = UDim2.fromScale(math.clamp(v56 / math.max(v55, 1), 0, 1), 1)
    XPBar.Label.Text = `{v56} / {v55} XP`
end

local function slotIndexOf(arg47) -- line: 526
    -- upvalues:
    --  [1] Alchemy_m (copy)
    --  [2] t_3 (copy)

    for index_4 = 1, Alchemy_m.MaxSlots do
        if t_3.Slots[index_4] and t_3.Slots[index_4].Item == arg47 then
            return index_4
        end
    end

    return nil
end

local function renderFilters() -- line: 535
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_3 (copy)
    --  [3] t_1 (copy)

    for _, child_6 in t.Filters:GetChildren() do
        if child_6:IsA("GuiButton") then
            local v57 = t_3.Filter == child_6.Name
            local SelectedOutline_2 = child_6:FindFirstChild("SelectedOutline")

            if SelectedOutline_2 then
                SelectedOutline_2.Visible = v57
            end

            child_6.BackgroundColor3 = v57 and t_1.BUTTON_ON or t_1.BUTTON
        end
    end
end

local v59 = nil

local function renderIngredients(arg48) -- line: 545
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_3 (copy)
    --  [3] Templates (copy)
    --  [4] setIcon (copy)
    --  [5] v59 (ref)
    --  [6] hoverTip (copy)
    --  [7] getMaterials (copy)
    --  [8] Alchemy_m (copy)
    --  [9] renderSegments (copy)
    --  [10] slotIndexOf (copy)
    --  [11] renderFilters (copy)

    local v60 = string.lower(t.Search.Text or "")
    local t_18 = {}

    for key_16 in arg48 do
        table.insert(t_18, key_16)
    end

    table.sort(t_18)

    for key_17, val_8 in t_3.Tiles do
        if not arg48[key_17] then
            val_8:Destroy()
            t_3.Tiles[key_17] = nil
        end
    end

    local v61 = 0
    local v65

    for key_18, val_9 in t_18 do
        local v62 = arg48[val_9]
        local v63 = t_3.Tiles[val_9]

        if not v63 then
            v63 = Templates.IngredientTile:Clone()
            v63.Visible = true
            v63.Name = val_9
            v63.ItemName.Text = val_9
            v63.Parent = t.Grid
            setIcon(v63.IconBox, val_9)
            v63.MouseButton1Click:Connect(function() -- line: 570
                -- upvalues:
                --  [1] v59 (ref)
                --  [2] val_9 (copy)

                v59(val_9)
            end)
            hoverTip(v63, function() -- line: 573
                -- upvalues:
                --  [1] getMaterials (ref)
                --  [2] val_9 (copy)

                local v64 = getMaterials()[val_9]

                if v64 and v64.Counts[1] + v64.Counts[2] + v64.Counts[3] > 0 then
                    return {
                        key = val_9,
                        text = `Plain: {v64.Counts[0]}   1-star: {v64.Counts[1]}   2-star: {v64.Counts[2]}   3-star: {v64.Counts[3]}`
                    }
                end

                return { key = val_9 }
            end)
            t_3.Tiles[val_9] = v63
        end

        v63.LayoutOrder = key_18

        if t_3.Filter ~= "All" then
            v65 = false

            if Alchemy_m.GetCategory(val_9) == t_3.Filter then
                v65 = true

                if v60 ~= "" then
                    v65 = if string.find(string.lower(val_9), v60, 1, true) == nil then false else true
                end
            end
        else
            v65 = true

            if v60 ~= "" then
                v65 = if string.find(string.lower(val_9), v60, 1, true) == nil then false else true
            end
        end

        v63.Visible = v65
        v63.Count.Text = `x{v62.Stock}`
        local v67 = 0
        renderSegments(
            v63.Stars,
            {
                {
                    stars = if v62.Counts[3] > 0 then 3 else if not ((0)[2] > 0) then if not (v62.Counts[1] > 0) then v67 else 1 else 2,
                    size = 12
                }
            },
            13,
            13
        )
        local v68 = slotIndexOf(val_9) ~= nil
        v67 = v63:FindFirstChild("SelectedOutline")

        if v67 then
            v67.Visible = v68
        end

        if v65 then
            v61 += 1
        end
    end

    local Empty = t.Ingredients.Empty
    Empty.Visible = v61 == 0
    Empty.Text = if #t_18 ~= 0 then "Nothing here." else "No ingredients yet.\nHarvest herbs, mine ores and hunt monsters to find some."
    renderFilters()
end

function v59(arg49) --[[ addIngredient ]] -- line: 612
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] slotIndexOf (copy)
    --  [3] Alchemy_m (copy)
    --  [4] getMaterials (copy)

    if t_3.Busy then
        return
    end

    local v70 = slotIndexOf(arg49)

    if v70 then
        local v71 = t_3.Slots[v70]
        v71.Amount = math.min(v71.Amount + 1, Alchemy_m.MaxPerSlot)
    else
        for index_5 = 1, Alchemy_m.MaxSlots do
            if not t_3.Slots[index_5] then
                local t_22 = { Item = arg49, Amount = 1, Star = nil }
                local _ = Alchemy_m.MaxSlots
                local Slots = t_3.Slots
                local v72 = getMaterials()[arg49]
                t_22.Star = if v72 then if not (v72.Counts[0] > 0) then if not (v72.Counts[1] > 0) then if not (v72.Counts[2] > 0) then if not (v72.Counts[3] > 0) then 0 else 3 else 2 else 1 else 0 else 0
                Slots[index_5] = t_22
                v70 = index_5
                break
            end
        end

        if not v70 then
            t_3.Status = "<font color=\"rgb(255, 94, 97)\">The cauldron only holds three ingredients.</font>"
        end
    end

    t_3.Dirty = true
end

local function renderSlots(arg50) -- line: 635
    -- upvalues:
    --  [1] Alchemy_m (copy)
    --  [2] t (copy)
    --  [3] t_3 (copy)
    --  [4] setIcon (copy)
    --  [5] v1 (copy)
    --  [6] t_1 (copy)
    --  [7] ViewportHandle_m (copy)
    --  [8] LocalPlayer (copy)

    local _

    for index_6 = 1, Alchemy_m.MaxSlots do
        local v74 = t.Stage["Slot" .. index_6]
        local Box = v74.Box
        local v75 = t_3.Slots[index_6]
        local _ = Alchemy_m.MaxSlots
        local v76 = if v75 == nil then false else true
        Box.Plus.Visible = not v76
        Box.Count.Visible = v76
        Box.RemoveButton.Visible = v76
        v74.ItemName.Visible = v76
        v74.Controls.Visible = v76
        local SelectedOutline_3 = Box:FindFirstChild("SelectedOutline")

        if SelectedOutline_3 then
            SelectedOutline_3.Visible = v76
        end

        if v76 then
            local v77 = arg50[v75.Item]
            local v78 = v77 and v77.Stock or 0
            local v79 = v75.Amount * t_3.Batch
            setIcon(Box, v75.Item)
            local Count_1 = Box.Count
            local v80 = `x{v75.Amount}`
            local v81 = if v79 <= v78 then "rgb(255, 255, 255)" else "rgb(255, 94, 97)"
            Count_1.Text = `<font color="{v81}">{v80}</font>`
            v74.ItemName.Text = v75.Item
            v78 = v74.Controls.StarPick

            for index_7 = 1, 3 do
                local v82 = v78.Stars["Star" .. index_7]
                v82.Image = v1
                v82.ImageColor3 = index_7 <= v75.Star and Color3.new(1, 1, 1) or Color3.fromRGB(
                    70,
                    70,
                    80
                )
                v82.ImageTransparency = if not (index_7 <= v75.Star) then 0.35 else 0
            end

            v78.SelectedOutline.Visible = v75.Star > 0 and true
            v78.BackgroundColor3 = v75.Star > 0 and t_1.BUTTON_ON or t_1.BUTTON
        else
            local v86 = Box:FindFirstChild("Holder") or Box

            if v86:GetAttribute("Item") ~= nil then
                v86:SetAttribute("Item", nil)

                for _, child_7 in v86:GetChildren() do
                    if child_7:IsA("ViewportFrame") then
                        ViewportHandle_m:Destroy(child_7)
                    end

                    child_7:Destroy()
                end
            end
        end
    end

    local v87 = math.floor(Alchemy_m.GetBenefits(LocalPlayer).bulk_brew or 0)
    local v88 = math.max(1, v87)
    t_3.Batch = math.clamp(t_3.Batch, 1, v88)
    t.Batch.Amount.Count.Text = tostring(t_3.Batch)
    t.Batch.Note.Text = `Max {v88}`
end

local function renderResult(arg51) -- line: 682
    -- upvalues:
    --  [1] t (copy)
    --  [2] readMixture (copy)
    --  [3] t_3 (copy)
    --  [4] Alchemy_m (copy)
    --  [5] LocalPlayer (copy)
    --  [6] setImage (copy)
    --  [7] t_1 (copy)
    --  [8] setStats (copy)
    --  [9] signature (copy)
    --  [10] setIcon (copy)
    --  [11] t_2 (copy)
    --  [12] qualitySegments (copy)
    --  [13] setGlyph (copy)

    local Result = t.Result
    local v90, v91, v92, v93 = readMixture(t_3.Slots, arg51, t_3.Batch)
    local v94 = Alchemy_m.GetLevel(LocalPlayer)
    local v95 = Alchemy_m.GetBenefits(LocalPlayer)
    local v96 = v91 > 0 and true
    local v98

    if v91 == 0 then
        setImage(Result.IconBox, "rbxassetid://76994426015118", t_1.OFF, 0.5)
        Result.PotionName.Text = "<font color=\"rgb(175, 175, 175)\">Empty Cauldron</font>"
        Result.Effect.Text = "Pick ingredients from the list on the left to fill the cauldron."
        setStats(Result.Stats, { { "Ingredients", { `0 / {Alchemy_m.MaxSlots}` } } })
    else
        v98 = t_3.BySignature[signature(v90)]

        if v98 then
            local v99 = Alchemy_m.Potions[v98.Potion]
            local v100 = Alchemy_m.ItemName(v98.Potion, v98.Tier)
            setIcon(Result.IconBox, v100, true)
            local Color = v99.Color
            Result.PotionName.Text = `<font color="{string.format(
                "rgb(%d, %d, %d)",
                Color.R * 255,
                Color.G * 255,
                Color.B * 255
            )}">{v100}</font>`
            Result.Effect.Text = Alchemy_m.Describe(v98.Potion, v98.Tier, 0, v95)
            local t_26 = {}

            if v94 < v98.Level then
                table.insert(
                    t_26,
                    {
                        "Requires",
                        { `<font color="rgb(255, 94, 97)">{`Alchemy Lv {v98.Level}`}</font>` }
                    }
                )
            else
                local v101 = Alchemy_m.GetSuccessChance(v94, v95, v93, v98)
                local v102 = `{v101}%`
                local v103 = v101 >= 75 and t_2.GOOD or (v101 >= 50 and t_2.WARN or t_2.BAD)
                table.insert(t_26, { "Success", { `<font color="{v103}">{v102}</font>` } })
                local _ = {}
                table.insert(
                    t_26,
                    { "Quality", (qualitySegments(Alchemy_m.GetStarOdds(v93, v98.Quality, v95))) }
                )
            end

            local v105 = Alchemy_m.GetXP(v98.Tier, v98)
            table.insert(t_26, { "XP", { `+{v105} each` } })
            setStats(Result.Stats, t_26)
        else
            setGlyph(Result.IconBox, "?", t_1.ACCENT)
            Result.PotionName.Text = "<font color=\"rgb(196, 160, 255)\">Unknown Mixture</font>"
            Result.Effect.Text = "A real recipe becomes a potion and goes in your book. Anything else turns into a Failed Potion."
            local v106 = Alchemy_m.GetSuccessChance(v94, v95, v93, nil)
            setStats(
                Result.Stats,
                {
                    {
                        "Success",
                        { `~{v106}%`, "<font color=\"rgb(175, 175, 175)\"> if real</font>" }
                    },
                    { "Ingredients", { `{v91} / {Alchemy_m.MaxSlots}` } }
                }
            )
        end
    end

    v98 = v96 and (v92 and not t_3.Busy)
    v96 = v98
    local Label_1 = Result.BrewButton.Label
    Label_1.Text = if t_3.Busy then "BREWING..." else t_3.Batch > 1 and `BREW x{t_3.Batch}` or "BREW"
    local BrewButton = Result.BrewButton
    BrewButton.BackgroundColor3 = v96 and t_1.BUTTON_ON or t_1.BUTTON_OFF
    local Label_2 = BrewButton:FindFirstChild("Label")

    if Label_2 then
        Label_2.TextColor3 = v96 and t_1.TEXT or t_1.OFF
    end

    local SelectedOutline_5 = BrewButton:FindFirstChild("SelectedOutline")

    if SelectedOutline_5 then
        SelectedOutline_5.Visible = v96
    end

    if not v92 and (v91 > 0 and (not t_3.Busy and t_3.Status == "")) then
        Result.Status.Text = "<font color=\"rgb(255, 94, 97)\">You don't have enough ingredients.</font>"

        return
    end

    Result.Status.Text = t_3.Status
end

local function setView(arg52) -- line: 741
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] t (copy)
    --  [3] t_1 (copy)

    t_3.View = arg52
    local BrewView = t.BrewView
    BrewView.Visible = arg52 == "Brew"
    local BookView = t.BookView
    BookView.Visible = arg52 == "Book"

    for _, val_10 in { "Brew", "Book" } do
        local v112 = arg52 == val_10
        local SelectedOutline_6 = t.Tabs[val_10]:FindFirstChild("SelectedOutline")

        if SelectedOutline_6 then
            SelectedOutline_6.Visible = v112
        end

        t.Tabs[val_10].BackgroundColor3 = v112 and t_1.BUTTON_ON or t_1.BUTTON
    end

    t_3.Dirty = true
end

local _ = function() --[[ selectedRecipe ]] -- line: 753
    -- upvalues:
    --  [1] knownFor (copy)
    --  [2] t_3 (copy)

    local v114 = knownFor(t_3.SelectedPotion)

    if #v114 == 0 then
        return nil, v114
    end

    local v115 = math.clamp(t_3.RecipeIndex[t_3.SelectedPotion] or 1, 1, #v114)
    t_3.RecipeIndex[t_3.SelectedPotion] = v115

    return v114[v115], v114, v115
end

local function renderBook(arg53) -- line: 763
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] Alchemy_m (copy)
    --  [3] LocalPlayer (copy)
    --  [4] t (copy)
    --  [5] Templates (copy)
    --  [6] setIcon (copy)
    --  [7] knownFor (copy)
    --  [8] t_1 (copy)
    --  [9] Inventory (copy)
    --  [10] recipeSlots (copy)
    --  [11] ViewportHandle_m (copy)
    --  [12] readMixture (copy)
    --  [13] t_2 (copy)
    --  [14] setStats (copy)

    local v116 = t_3.Book
    local v117 = Alchemy_m.GetLevel(LocalPlayer)
    local v118 = Alchemy_m.GetBenefits(LocalPlayer)
    local v119 = string.lower(t.BookSearch.Text or "")
    local v120 = 0
    local v121 = 0

    if v116 then
        for _ in v116.Known do
            v120 += 1
        end

        for _, val_11 in v116.Totals do
            v121 += val_11.Total
        end
    end

    local Progress = t.BookView.Potions.Progress
    Progress.Text = v116 and `{v120} of {v121} recipes discovered` or "Opening your book..."

    for key_23, val_12 in Alchemy_m.Order do
        v121 = Alchemy_m.Potions[val_12]
        v120 = t.PotionList:FindFirstChild(val_12)

        if not v120 then
            v120 = Templates.PotionButton:Clone()
            v120.Visible = true
            v120.Name = val_12
            v120.LayoutOrder = key_23
            v120.PotionName.Text = v121.Name
            v120.Stat.Text = v121.Stat
            v120.Parent = t.PotionList
            setIcon(v120.IconBox, Alchemy_m.ItemName(val_12, 2))
            v120.MouseButton1Click:Connect(function() -- line: 792
                -- upvalues:
                --  [1] t_3 (ref)
                --  [2] val_12 (copy)

                t_3.SelectedPotion = val_12
                t_3.BookStatus = ""
                t_3.Dirty = true
            end)
        end

        local v124 = if not v116 then { Total = 0 } else v116.Totals[val_12] or { Total = 0 }
        local Count_3 = v120.Count
        local v125 = #knownFor(val_12)
        Count_3.Text = `{v125}/{v124.Total}`
        v124 = true

        if v119 ~= "" then
            v124 = true

            if string.find(string.lower(v121.Name), v119, 1, true) == nil then
                v124 = if string.find(string.lower(v121.Stat), v119, 1, true) == nil then false else true
            end
        end

        if not v124 then
            for _, val_13 in knownFor(val_12) do
                for key_25 in val_13.Ingredients do
                    if string.find(string.lower(key_25), v119, 1, true) then
                        v124 = true
                    end
                end
            end
        end

        v120.Visible = v124
        v124 = t_3.SelectedPotion == val_12
        local SelectedOutline_7 = v120:FindFirstChild("SelectedOutline")

        if SelectedOutline_7 then
            SelectedOutline_7.Visible = v124
        end

        v120.BackgroundColor3 = v124 and t_1.BUTTON_ON or t_1.CARD
    end

    local SelectedPotion = t_3.SelectedPotion
    local v127 = Alchemy_m.Potions[SelectedPotion]
    local v128 = knownFor(t_3.SelectedPotion)
    local v129, v130, v131

    if #v128 == 0 then
        v129 = nil
        v130 = v128
        v131 = nil
    else
        local _ = Alchemy_m.Potions
        local v132 = math.clamp(t_3.RecipeIndex[t_3.SelectedPotion] or 1, 1, #v128)
        t_3.RecipeIndex[t_3.SelectedPotion] = v132
        v129 = v128[v132]
        v130 = v128
        v131 = v132
    end

    local v133 = t.Detail
    local Color_1 = v127.Color
    local PotionName_1 = v133.PotionName
    local Name_1 = v127.Name
    PotionName_1.Text = `<font color="{string.format(
        "rgb(%d, %d, %d)",
        Color_1.R * 255,
        Color_1.G * 255,
        Color_1.B * 255
    )}">{Name_1}</font>`
    v133.Stat.Text = v127.Stat
    v133.Flavor.Text = v127.Flavor or ""
    local v134 = setIcon
    local Showcase = v133.Showcase
    v134(Showcase, Alchemy_m.ItemName(SelectedPotion, v129 and v129.Tier or 3), true)
    local Glow = v133.Showcase:FindFirstChild("Glow")

    if Glow then
        for _, child_8 in Glow:GetChildren() do
            if child_8:IsA("Frame") then
                child_8.BackgroundColor3 = v127.Color
            end
        end
    end

    local Tiers = v133.Tiers
    local v141, v138, v139

    for index_8 = 1, 3 do
        v133 = Tiers:FindFirstChild("Tier" .. index_8)

        if not v133 then
            v133 = Templates.TierRow:Clone()
            v133.Visible = true
            v133.Name = "Tier" .. index_8
            v133.LayoutOrder = index_8
            v138 = v133.Rule
            v139 = index_8 < 3 and true
            v138.Visible = v139
            v133.Parent = Tiers
        end

        v138 = if v129 == nil then false else v129.Tier == index_8
        local v140 = Inventory:FindFirstChild((Alchemy_m.ItemName(SelectedPotion, index_8)))
        v139 = v140 and v140:GetAttribute("Stock") or 0
        v141 = v133.Tier
        local v142 = if not v138 then if index_8 ~= 1 then "rgb(196, 160, 255)" else "rgb(225, 225, 225)" else "rgb(196, 160, 255)"
        v141.Text = `<font color="{v142}">{Alchemy_m.Tiers[index_8].Name}</font>`
        v141 = v139 > 0 and `<font color="rgb(175, 175, 175)">{`  (x{v139})`}</font>` or ""
        v133.Effect.Text = Alchemy_m.Describe(SelectedPotion, index_8, 0, v118) .. v141
        v133.BackgroundTransparency = if v138 then 0.85 else 1
    end

    local Recipe = t.Recipe
    local Selector = Recipe.Selector
    local Prev = Selector.Prev
    local v144 = #v130 > 1
    Prev.Visible = v144
    local v145 = Selector.Next
    v144 = #v130 > 1
    v145.Visible = v144
    v145 = if not v116 then { Total = 0 } else v116.Totals[SelectedPotion] or { Total = 0 }
    local t_39 = {}
    v116 = false

    if v129 then
        v144 = v129.Scroll and "<font color=\"rgb(196, 160, 255)\">  \194\183 Rare</font>" or ""
        local RecipeName = Selector.RecipeName
        v141 = `{Alchemy_m.Tiers[v129.Tier].Name} {v127.Short}{v144}`
        local v143

        if #v130 > 1 then
            local v146 = #v130
            v143 = `<font color="rgb(175, 175, 175)">{`   {v131}/{v146}`}</font>` or ""
        else
            v143 = ""
        end

        RecipeName.Text = v141 .. v143
        Recipe.Hint.Text = "Put these in the cauldron to brew this recipe."
        v144 = recipeSlots(v129, arg53)
        local v149

        for index_9 = 1, 3 do
            v143 = Recipe.Slots["Slot" .. index_9]
            local v147 = v144[index_9]
            v143.Visible = true

            if v147 then
                local v148 = arg53[v147.Item]
                v149 = v148 and v148.Stock or 0
                local v150 = v147.Amount * t_3.Batch
                setIcon(v143.IconBox, v147.Item)
                v143.Plus.Visible = false
                v143.ItemName.Text = `{`<font color="rgb(196, 160, 255)">{"x" .. v147.Amount}</font>`} {v147.Item}`
                local Detail = v143.Detail
                local v151 = `You have {v149}`
                local v152 = if v150 <= v149 then "rgb(175, 175, 175)" else "rgb(255, 94, 97)"
                Detail.Text = `<font color="{v152}">{v151}</font>`
            else
                local IconBox_1 = v143.IconBox
                v149 = IconBox_1:FindFirstChild("Holder") or IconBox_1

                if v149:GetAttribute("Item") ~= nil then
                    v149:SetAttribute("Item", nil)

                    for _, child_9 in v149:GetChildren() do
                        if child_9:IsA("ViewportFrame") then
                            ViewportHandle_m:Destroy(child_9)
                        end

                        child_9:Destroy()
                    end
                end

                v143.Plus.Visible = false
                v143.ItemName.Text = "<font color=\"rgb(175, 175, 175)\">Not needed</font>"
                v143.Detail.Text = "This recipe uses fewer ingredients."
            end
        end

        local _, _
        local v155
        _, _, v141, v155 = readMixture(v144, arg53, t_3.Batch)

        if v117 < v129.Level then
            table.insert(
                t_39,
                {
                    "Success Rate",
                    { `<font color="rgb(255, 94, 97)">{`Needs Lv {v129.Level}`}</font>` }
                }
            )
        else
            local v156 = Alchemy_m.GetSuccessChance(v117, v118, v155, v129)
            local v158 = `{v156}%`
            local v159 = v156 >= 75 and t_2.GOOD or (v156 >= 50 and t_2.WARN or t_2.BAD)
            table.insert(t_39, { "Success Rate", { `<font color="{v159}">{v158}</font>` } })
        end

        v116 = v141 and (v117 >= v129.Level and not t_3.Busy)
    else
        Selector.RecipeName.Text = "<font color=\"rgb(175, 175, 175)\">No recipe known</font>"
        Recipe.Hint.Text = "Experiment at the cauldron to discover this potion's recipes."

        for index_10 = 1, 3 do
            local v161 = Recipe.Slots["Slot" .. index_10]
            local IconBox_2 = v161.IconBox
            local v162 = IconBox_2:FindFirstChild("Holder") or IconBox_2

            if v162:GetAttribute("Item") ~= nil then
                v162:SetAttribute("Item", nil)

                for _, child_10 in v162:GetChildren() do
                    if child_10:IsA("ViewportFrame") then
                        ViewportHandle_m:Destroy(child_10)
                    end

                    child_10:Destroy()
                end
            end

            v161.Plus.Visible = true
            v161.ItemName.Text = "Empty Slot"
            v161.Detail.Text = "Add an ingredient from your inventory."
        end

        table.insert(
            t_39,
            {
                "Success Rate",
                {
                    `<font color="rgb(196, 160, 255)">{`~{Alchemy_m.GetSuccessChance(
                        v117,
                        v118,
                        0,
                        nil
                    )}% if real`}</font>`
                }
            }
        )
    end

    local v163 = #v130
    local t_46 = { "Recipe Progress", { `{v163} / {v145.Total}` } }
    table.insert(t_39, t_46)
    setStats(Recipe.Stats, t_39)
    local Label_3 = Recipe.BrewButton.Label
    Label_3.Text = if t_3.Busy then "BREWING..." else t_3.Batch > 1 and `BREW x{t_3.Batch}` or "BREW"
    local BrewButton_1 = Recipe.BrewButton
    BrewButton_1.BackgroundColor3 = v116 and t_1.BUTTON_ON or t_1.BUTTON_OFF
    v145 = BrewButton_1:FindFirstChild("Label")

    if v145 then
        v145.TextColor3 = v116 and t_1.TEXT or t_1.OFF
    end

    local SelectedOutline_8 = BrewButton_1:FindFirstChild("SelectedOutline")

    if SelectedOutline_8 then
        SelectedOutline_8.Visible = v116
    end

    Recipe.Status.Text = t_3.BookStatus
end

local _ = function() --[[ fetchBook ]] -- line: 918
    -- upvalues:
    --  [1] AlchemyRemote (copy)
    --  [2] t_3 (copy)
    --  [3] signature (copy)

    task.spawn(function() -- line: 919
        -- upvalues:
        --  [1] AlchemyRemote (ref)
        --  [2] t_3 (ref)
        --  [3] signature (ref)

        local Success, Result_1 = pcall(function() -- line: 920
            -- upvalues:
            --  [1] AlchemyRemote (ref)

            return AlchemyRemote:InvokeServer("Book")
        end)

        if Success and type(Result_1) == "table" then
            t_3.Book = Result_1
            t_3.BySignature = {}

            for _, val_14 in Result_1.Known do
                t_3.BySignature[signature(val_14.Ingredients)] = val_14
            end

            t_3.Dirty = true
        end
    end)
end

local _ = function() --[[ refresh ]] -- line: 938
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] renderHeader (copy)
    --  [3] getMaterials (copy)
    --  [4] renderIngredients (copy)
    --  [5] renderSlots (copy)
    --  [6] renderResult (copy)
    --  [7] renderBook (copy)

    t_3.Dirty = false
    renderHeader()
    local v167 = getMaterials()

    if t_3.View == "Brew" then
        renderIngredients(v167)
        renderSlots(v167)
        renderResult(v167)

        return
    end

    renderBook(v167)
end

local function describeMade(arg54) -- line: 955
    local t_48 = {}
    local v173

    for key_30, val_15 in arg54 do
        local v168 = val_15[1] + val_15[2] + val_15[3] + val_15[4]
        local t_49 = {}

        if val_15[2] > 0 then
            table.insert(t_49, `{val_15[2]}x {1}\226\152\133`)
        end

        if val_15[3] > 0 then
            table.insert(t_49, `{val_15[3]}x {2}\226\152\133`)
        end

        if val_15[4] > 0 then
            table.insert(t_49, `{val_15[4]}x {3}\226\152\133`)
        end

        if #t_49 > 0 then
            local v172 = table.concat(t_49, ", ")
            v173 = `<font color="rgb(255, 207, 92)">{` ({v172})`}</font>` or ""
        else
            v173 = ""
        end

        table.insert(t_48, `{key_30} x{v168}{v173}`)
    end

    return table.concat(t_48, ", ")
end

local function describeResult(arg55) -- line: 971
    -- upvalues:
    --  [1] describeMade (copy)

    local t_50 = {}

    if next(arg55.Made) ~= nil then
        table.insert(
            t_50,
            "<font color=\"rgb(212, 255, 155)\">Brewed </font>" .. describeMade(arg55.Made)
        )

        if arg55.Failed > 0 then
            table.insert(t_50, `<font color="rgb(255, 94, 97)">{`{arg55.Failed} failed`}</font>`)
        end

        if arg55.Discovered then
            local v175 = (arg55.DiscoveryXP or 0) > 0 and ` (+{arg55.DiscoveryXP} discovery XP)` or ""
            table.insert(
                t_50,
                `<font color="rgb(196, 160, 255)">{"New recipe written in your book!" .. v175}</font>`
            )
        end

        if arg55.TierUp then
            table.insert(t_50, "<font color=\"rgb(255, 207, 92)\">Philosopher's Touch!</font>")
        end
    elseif arg55.Outcome == "Collapsed" then
        table.insert(
            t_50,
            "<font color=\"rgb(255, 94, 97)\">It shimmered, then collapsed into sludge.</font>"
        )
        table.insert(
            t_50,
            "<font color=\"rgb(196, 160, 255)\">This mixture IS a recipe. Try again!</font>"
        )
    elseif arg55.Outcome == "Locked" then
        table.insert(
            t_50,
            `<font color="rgb(255, 94, 97)">{`Too advanced: needs Alchemy Lv {arg55.Level}.`}</font>`
        )
    else
        table.insert(
            t_50,
            "<font color=\"rgb(255, 94, 97)\">Not a recipe. It turned to sludge.</font>"
        )

        if arg55.Overlap then
            if arg55.Overlap >= 2 then
                table.insert(
                    t_50,
                    `<font color="rgb(196, 160, 255)">{`Your intuition says {arg55.Overlap} of these belong together.`}</font>`
                )
            else
                table.insert(
                    t_50,
                    "<font color=\"rgb(175, 175, 175)\">Your intuition says these don't belong together.</font>"
                )
            end
        end
    end

    if (arg55.XP or 0) > 0 then
        table.insert(t_50, `<font color="rgb(196, 160, 255)">{`+{arg55.XP} Alchemy XP`}</font>`)
    end

    return table.concat(t_50, "\n")
end

local function doBrew(arg56, arg57) -- line: 1007
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] getMaterials (copy)
    --  [3] readMixture (copy)
    --  [4] Alchemy_m (copy)
    --  [5] renderHeader (copy)
    --  [6] renderIngredients (copy)
    --  [7] renderSlots (copy)
    --  [8] renderResult (copy)
    --  [9] renderBook (copy)
    --  [10] t (copy)
    --  [11] TweenService (copy)
    --  [12] AlchemyRemote (copy)
    --  [13] describeResult (copy)
    --  [14] signature (copy)

    if t_3.Busy then
        return
    end

    local v176 = getMaterials()
    local _
    local v178
    _, v178, v176 = readMixture(arg56, v176, t_3.Batch)

    if v178 == 0 or not v176 then
        return
    end

    local t_51 = {}

    for index_11 = 1, Alchemy_m.MaxSlots do
        local v179 = arg56[index_11]
        local _ = Alchemy_m.MaxSlots

        if v179 then
            table.insert(t_51, { Item = v179.Item, Amount = v179.Amount, Star = v179.Star })
        end
    end

    t_3.Busy = true

    if arg57 then
        t_3.BookStatus = "<font color=\"rgb(175, 175, 175)\">The cauldron bubbles...</font>"
    else
        t_3.Status = "<font color=\"rgb(175, 175, 175)\">The cauldron bubbles...</font>"
    end

    t_3.Dirty = false
    renderHeader()
    local v180 = getMaterials()

    if t_3.View == "Brew" then
        renderIngredients(v180)
        renderSlots(v180)
        renderResult(v180)
    else
        renderBook(v180)
    end

    local v181 = Alchemy_m.BrewTime + (t_3.Batch - 1) * Alchemy_m.BrewTimePerExtra
    local v182 = arg57 and t.Recipe.BrewButton or t.Result.BrewButton
    local Progress_1 = v182.Progress
    Progress_1.Size = UDim2.fromScale(0, 1)
    v182 = TweenService:Create(
        Progress_1,
        TweenInfo.new(v181, Enum.EasingStyle.Linear),
        { Size = UDim2.fromScale(1, 1) }
    )
    v182:Play()
    local Success_1, Result_2, v184 = pcall(function() -- line: 1040
        -- upvalues:
        --  [1] AlchemyRemote (ref)
        --  [2] t_51 (copy)
        --  [3] t_3 (ref)

        return AlchemyRemote:InvokeServer("Brew", t_51, t_3.Batch)
    end)
    v182:Cancel()
    Progress_1.Size = UDim2.fromScale(0, 1)
    t_3.Busy = false
    local v185

    if Success_1 then
        if type(Result_2) == "table" then
            v185 = describeResult(Result_2)

            if Result_2.Discovered then
                task.spawn(function() -- line: 919
                    -- upvalues:
                    --  [1] AlchemyRemote (ref)
                    --  [2] t_3 (ref)
                    --  [3] signature (ref)

                    local Success_2, Result_3 = pcall(function() -- line: 920
                        -- upvalues:
                        --  [1] AlchemyRemote (ref)

                        return AlchemyRemote:InvokeServer("Book")
                    end)

                    if Success_2 and type(Result_3) == "table" then
                        t_3.Book = Result_3
                        t_3.BySignature = {}

                        for _, val_16 in Result_3.Known do
                            t_3.BySignature[signature(val_16.Ingredients)] = val_16
                        end

                        t_3.Dirty = true
                    end
                end)
            end
        else
            v185 = `<font color="rgb(255, 94, 97)">{tostring(v184 or "The brew failed.")}</font>`
        end
    else
        v185 = `<font color="rgb(255, 94, 97)">{tostring(v184 or "The brew failed.")}</font>`
    end

    if arg57 then
        t_3.BookStatus = v185:split("\n")[1]
    else
        t_3.Status = v185
    end

    t_3.Dirty = true
end

local function pickerTip(arg58) -- line: 1071
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] getMaterials (copy)

    local v187 = t_3.Slots[arg58]

    if not v187 then
        return nil
    end

    local Item_2 = v187.Item
    local Star_1 = v187.Star
    local v188 = getMaterials()[Item_2]
    local v189 = v188 and v188.Counts[Star_1] or 0
    local v190

    if Star_1 <= 0 then
        v190 = `Uses your unstarred {Item_2} first ({v189} owned). Click to use 1-star first.`
    else
        local v191 = `Uses your {Star_1}-star {Item_2} first ({v189} owned), then lower stars.`
        local v193

        if Star_1 < 3 then
            local v192 = Star_1 + 1
            v193 = ` Click to use {v192}-star first.`
        else
            v193 = " Click to reset."
        end

        v190 = v191 .. v193
    end

    return { key = Item_2, text = v190 }
end

local v194

for index_12 = 1, Alchemy_m.MaxSlots do
    v194 = t.Stage["Slot" .. index_12]
    local Box_1 = v194.Box
    local Controls = v194.Controls

    function v194(arg59) --[[ change ]] -- line: 1094
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] index_12 (copy)
        --  [3] Alchemy_m (copy)

        local v197 = t_3.Slots[index_12]

        if v197 and not t_3.Busy then
            v197.Amount = math.clamp(v197.Amount + arg59, 1, Alchemy_m.MaxPerSlot)
            t_3.Status = ""
            t_3.Dirty = true
        end
    end

    local _ = Alchemy_m.MaxSlots
    Controls.Minus.MouseButton1Click:Connect(function() -- line: 1102
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] index_12 (copy)
        --  [3] Alchemy_m (copy)

        local v198 = t_3.Slots[index_12]

        if v198 and not t_3.Busy then
            v198.Amount = math.clamp(v198.Amount + -1, 1, Alchemy_m.MaxPerSlot)
            t_3.Status = ""
            t_3.Dirty = true
        end
    end)
    Controls.Plus.MouseButton1Click:Connect(function() -- line: 1105
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] index_12 (copy)
        --  [3] Alchemy_m (copy)

        local v199 = t_3.Slots[index_12]

        if v199 and not t_3.Busy then
            v199.Amount = math.clamp(v199.Amount + 1, 1, Alchemy_m.MaxPerSlot)
            t_3.Status = ""
            t_3.Dirty = true
        end
    end)
    Box_1.RemoveButton.MouseButton1Click:Connect(function() -- line: 1108
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] index_12 (copy)

        if not t_3.Busy then
            t_3.Slots[index_12] = nil
            t_3.Status = ""
            t_3.Dirty = true
        end
    end)
    Box_1.MouseButton1Click:Connect(function() -- line: 1115
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] index_12 (copy)
        --  [3] t (copy)

        if not t_3.Slots[index_12] then
            t.Search:CaptureFocus()
        end
    end)
    Controls.StarPick.MouseButton1Click:Connect(function() -- line: 1121
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] index_12 (copy)
        --  [3] Controls (copy)
        --  [4] pickerTip (ref)
        --  [5] v20 (ref)
        --  [6] BackpackUtils_m (copy)

        local v200 = t_3.Slots[index_12]

        if not v200 or t_3.Busy then
            return
        end

        v200.Star = (v200.Star + 1) % 4
        t_3.Dirty = true
        local StarPick = Controls.StarPick
        local v201 = pickerTip(index_12)
        v20 = StarPick
        pcall(function() -- line: 251
            -- upvalues:
            --  [1] BackpackUtils_m (ref)
            --  [2] v201 (copy)

            BackpackUtils_m:ShowHover(v201)
        end)
    end)
    hoverTip(Controls.StarPick, function() -- line: 1131
        -- upvalues:
        --  [1] pickerTip (ref)
        --  [2] index_12 (copy)

        return pickerTip(index_12)
    end)
    hoverTip(Box_1, function() -- line: 1134
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] index_12 (copy)

        local v202 = t_3.Slots[index_12]

        return v202 and { key = v202.Item } or nil
    end)
end

t.Batch.Amount.Minus.MouseButton1Click:Connect(function() -- line: 1140
    -- upvalues:
    --  [1] t_3 (copy)

    if not t_3.Busy then
        t_3.Batch = math.max(t_3.Batch - 1, 1)
        t_3.Dirty = true
    end
end)
t.Batch.Amount.Plus.MouseButton1Click:Connect(function() -- line: 1146
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] Alchemy_m (copy)
    --  [3] LocalPlayer (copy)

    if not t_3.Busy then
        t_3.Batch = math.min(
            t_3.Batch + 1,
            (math.max(1, (math.floor(Alchemy_m.GetBenefits(LocalPlayer).bulk_brew or 0))))
        )
        t_3.Dirty = true
    end
end)
t.Batch.Amount.Count.FocusLost:Connect(function() -- line: 1152
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] t (copy)
    --  [3] Alchemy_m (copy)
    --  [4] LocalPlayer (copy)

    local v209 = t_3
    local v210 = tonumber(t.Batch.Amount.Count.Text) or t_3.Batch
    local v211 = math.floor(v210)
    local v212 = math.floor(Alchemy_m.GetBenefits(LocalPlayer).bulk_brew or 0)
    local v213 = math.max(1, v212)
    v209.Batch = math.clamp(v211, 1, v213)
    t_3.Dirty = true
end)
t.Batch.Clear.MouseButton1Click:Connect(function() -- line: 1156
    -- upvalues:
    --  [1] t_3 (copy)

    if not t_3.Busy then
        t_3.Slots = {}
        t_3.Status = ""
        t_3.Dirty = true
    end
end)
hoverTip(t.Batch.Label, function() -- line: 1163
    return {
        key = "Batch Size",
        text = "Brew several potions at once. Uses the ingredients once per potion; each potion rolls its own success."
    }
end)
local v214

for _, child_11 in t.Filters:GetChildren() do
    if child_11:IsA("GuiButton") then
        v214 = "All Ingredients"

        for _, val_17 in Alchemy_m.Categories do
            if val_17.Key == child_11.Name then
                v214 = val_17.Label
            end
        end

        child_11.MouseButton1Click:Connect(function() -- line: 1176
            -- upvalues:
            --  [1] t_3 (copy)
            --  [2] child_11 (copy)

            t_3.Filter = child_11.Name
            t_3.Dirty = true
        end)
        hoverTip(child_11, function() -- line: 1180
            -- upvalues:
            --  [1] v214 (ref)

            return { key = v214, text = "Show only these ingredients." }
        end)
    end
end

t.Result.BrewButton.MouseButton1Click:Connect(function() -- line: 1186
    -- upvalues:
    --  [1] doBrew (copy)
    --  [2] t_3 (copy)

    doBrew(t_3.Slots, false)
end)
t.Recipe.BrewButton.MouseButton1Click:Connect(function() -- line: 1189
    -- upvalues:
    --  [1] knownFor (copy)
    --  [2] t_3 (copy)
    --  [3] doBrew (copy)
    --  [4] recipeSlots (copy)
    --  [5] getMaterials (copy)

    local v215 = knownFor(t_3.SelectedPotion)
    local v216

    if #v215 == 0 then
        v216 = nil
    else
        local v217 = math.clamp(t_3.RecipeIndex[t_3.SelectedPotion] or 1, 1, #v215)
        t_3.RecipeIndex[t_3.SelectedPotion] = v217
        v216 = v215[v217]
    end

    if v216 then
        doBrew(recipeSlots(v216, (getMaterials())), true)
    end
end)
t.Recipe.Selector.Prev.MouseButton1Click:Connect(function() -- line: 1195
    -- upvalues:
    --  [1] knownFor (copy)
    --  [2] t_3 (copy)

    local v220 = knownFor(t_3.SelectedPotion)
    local v221, v222

    if #v220 == 0 then
        v221 = v220
        v222 = nil
    else
        local v223 = math.clamp(t_3.RecipeIndex[t_3.SelectedPotion] or 1, 1, #v220)
        t_3.RecipeIndex[t_3.SelectedPotion] = v223
        local _ = v220[v223]
        v221 = v220
        v222 = v223
    end

    if v222 and #v221 > 1 then
        t_3.RecipeIndex[t_3.SelectedPotion] = (v222 - 2) % #v221 + 1
        t_3.BookStatus = ""
        t_3.Dirty = true
    end
end)
t.Recipe.Selector.Next.MouseButton1Click:Connect(function() -- line: 1203
    -- upvalues:
    --  [1] knownFor (copy)
    --  [2] t_3 (copy)

    local v225 = knownFor(t_3.SelectedPotion)
    local v226, v227

    if #v225 == 0 then
        v226 = v225
        v227 = nil
    else
        local v228 = math.clamp(t_3.RecipeIndex[t_3.SelectedPotion] or 1, 1, #v225)
        t_3.RecipeIndex[t_3.SelectedPotion] = v228
        local _ = v225[v228]
        v226 = v225
        v227 = v228
    end

    if v227 and #v226 > 1 then
        t_3.RecipeIndex[t_3.SelectedPotion] = v227 % #v226 + 1
        t_3.BookStatus = ""
        t_3.Dirty = true
    end
end)

for index_13 = 1, 3 do
    hoverTip(t.Recipe.Slots["Slot" .. index_13].IconBox, function() -- line: 1213
        -- upvalues:
        --  [1] knownFor (copy)
        --  [2] t_3 (copy)
        --  [3] recipeSlots (copy)
        --  [4] index_13 (copy)

        local v230 = knownFor(t_3.SelectedPotion)
        local v231

        if #v230 == 0 then
            v231 = nil
        else
            local v232 = math.clamp(t_3.RecipeIndex[t_3.SelectedPotion] or 1, 1, #v230)
            t_3.RecipeIndex[t_3.SelectedPotion] = v232
            v231 = v230[v232]
        end

        if not v231 then
            return nil
        end

        local v233 = recipeSlots(v231, {})[index_13]

        return v233 and { key = v233.Item } or nil
    end)
end

t.Search:GetPropertyChangedSignal("Text"):Connect(function() -- line: 1223
    -- upvalues:
    --  [1] t_3 (copy)

    t_3.Dirty = true
end)
t.BookSearch:GetPropertyChangedSignal("Text"):Connect(function() -- line: 1226
    -- upvalues:
    --  [1] t_3 (copy)

    t_3.Dirty = true
end)
t.Tabs.Brew.MouseButton1Click:Connect(function() -- line: 1229
    -- upvalues:
    --  [1] setView (copy)

    setView("Brew")
end)
t.Tabs.Book.MouseButton1Click:Connect(function() -- line: 1232
    -- upvalues:
    --  [1] setView (copy)

    setView("Book")
end)
local CauldronView = t.Stage:FindFirstChild("CauldronView")
local v235 = CauldronView

if v235 then
    v235 = CauldronView:FindFirstChildWhichIsA("Model")
end

local index_13 = nil
local v194 = nil
local child_11 = nil

if v235 then
    index_13 = Instance.new("Camera")
    index_13.FieldOfView = 30
    index_13.Parent = CauldronView
    CauldronView.CurrentCamera = index_13
    local v236, v237 = v235:GetBoundingBox()
    v194 = v236.Position
    child_11 = math.max(v237.X, v237.Y, v237.Z) * 1.9
end

function v235() --[[ updateCauldronCamera ]] -- line: 1253
    -- upvalues:
    --  [1] index_13 (ref)
    --  [2] child_11 (ref)
    --  [3] v194 (ref)

    if not index_13 then
        return
    end

    local v238 = os.clock() * 0.25
    local v239 = math.sin(v238)
    local v240 = math.cos(v238)
    index_13.CFrame = CFrame.lookAt(
        v194 + Vector3.new(v239, 0.55, v240).Unit * child_11,
        v194 + Vector3.new(0, 0.6, 0)
    )
end

if index_13 then
    local v242 = os.clock() * 0.25
    local v243 = math.sin(v242)
    local v245 = Vector3.new(v243, 0.55, (math.cos(v242))).Unit * child_11
    index_13.CFrame = CFrame.lookAt(v194 + v245, v194 + Vector3.new(0, 0.6, 0))
end

local function updateScale() -- line: 1267
    -- upvalues:
    --  [1] t (copy)

    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    local ViewportSize = CurrentCamera.ViewportSize
    t.Scale.Scale = math.clamp(
        math.min(ViewportSize.X * 0.66 / 900, ViewportSize.Y * 0.8 / 580),
        0.45,
        1
    )
end

local function close() -- line: 1277
    -- upvalues:
    --  [1] Parent (copy)
    --  [2] v20 (ref)
    --  [3] BackpackUtils_m (copy)
    --  [4] t_3 (copy)

    if not Parent.Visible then
        return
    end

    Parent.Visible = false

    if v20 ~= nil then
        v20 = nil
        pcall(function() -- line: 258
            -- upvalues:
            --  [1] BackpackUtils_m (ref)

            BackpackUtils_m:HideHover()
        end)
    end

    if t_3.Prompt then
        t_3.Prompt.Enabled = true
        t_3.Prompt = nil
    end

    t_3.Station = nil
end

local function open(arg60) -- line: 1290
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] t (copy)
    --  [3] setView (copy)
    --  [4] Parent (copy)
    --  [5] AlchemyRemote (copy)
    --  [6] signature (copy)
    --  [7] renderHeader (copy)
    --  [8] getMaterials (copy)
    --  [9] renderIngredients (copy)
    --  [10] renderSlots (copy)
    --  [11] renderResult (copy)
    --  [12] renderBook (copy)

    t_3.Station = arg60
    local v246 = arg60

    if v246 then
        v246 = arg60:FindFirstChild("AlchemyPrompt")
    end

    if v246 then
        if _G.PROMPTS then
            _G.PROMPTS[v246] = true
        end

        v246.Enabled = false
        t_3.Prompt = v246
    end

    t_3.Status = ""
    t_3.BookStatus = ""
    v246 = workspace.CurrentCamera

    if v246 then
        local ViewportSize_1 = v246.ViewportSize
        t.Scale.Scale = math.clamp(
            math.min(ViewportSize_1.X * 0.66 / 900, ViewportSize_1.Y * 0.8 / 580),
            0.45,
            1
        )
    end

    setView("Brew")
    Parent.Visible = true
    task.spawn(function() -- line: 919
        -- upvalues:
        --  [1] AlchemyRemote (ref)
        --  [2] t_3 (ref)
        --  [3] signature (ref)

        local Success_3, Result_4 = pcall(function() -- line: 920
            -- upvalues:
            --  [1] AlchemyRemote (ref)

            return AlchemyRemote:InvokeServer("Book")
        end)

        if Success_3 and type(Result_4) == "table" then
            t_3.Book = Result_4
            t_3.BySignature = {}

            for _, val_18 in Result_4.Known do
                t_3.BySignature[signature(val_18.Ingredients)] = val_18
            end

            t_3.Dirty = true
        end
    end)
    t_3.Dirty = false
    renderHeader()
    local v247 = getMaterials()

    if t_3.View == "Brew" then
        renderIngredients(v247)
        renderSlots(v247)
        renderResult(v247)

        return
    end

    renderBook(v247)
end

Open.OnClientEvent:Connect(function(arguments) -- line: 1309
    -- upvalues:
    --  [1] open (copy)

    if typeof(arguments) == "Instance" then
        open(arguments)
    end
end)
t.Header.Close.MouseButton1Click:Connect(close)

local _ = function(arg62) --[[ watch ]] -- line: 1318
    -- upvalues:
    --  [1] t_3 (copy)

    arg62.AttributeChanged:Connect(function() -- line: 1319
        -- upvalues:
        --  [1] t_3 (ref)

        t_3.Dirty = true
    end)
end

for _, child_12 in Inventory:GetChildren() do
    child_12.AttributeChanged:Connect(function() -- line: 1319
        -- upvalues:
        --  [1] t_3 (copy)

        t_3.Dirty = true
    end)
end

Inventory.ChildAdded:Connect(function(child_13) -- line: 1326
    -- upvalues:
    --  [1] t_3 (copy)

    child_13.AttributeChanged:Connect(function() -- line: 1319
        -- upvalues:
        --  [1] t_3 (ref)

        t_3.Dirty = true
    end)
    t_3.Dirty = true
end)
Inventory.ChildRemoved:Connect(function() -- line: 1330
    -- upvalues:
    --  [1] t_3 (copy)

    t_3.Dirty = true
end)

for _, val_19 in { "Alchemy", "AlchemyXP", "AlchemyMXP" } do
    task.spawn(function() -- line: 1334
        -- upvalues:
        --  [1] Professions (copy)
        --  [2] val_19 (copy)
        --  [3] t_3 (copy)

        local v249 = Professions:WaitForChild(val_19, 30)

        if v249 then
            v249.Changed:Connect(function() -- line: 1337
                -- upvalues:
                --  [1] t_3 (ref)

                t_3.Dirty = true
            end)
        end
    end)
end

task.spawn(function() -- line: 1343
    -- upvalues:
    --  [1] Professions (copy)
    --  [2] Alchemy_m (copy)
    --  [3] Parent (copy)
    --  [4] AlchemyRemote (copy)
    --  [5] t_3 (copy)
    --  [6] signature (copy)

    local v250 = Professions:WaitForChild(Alchemy_m.RecipesValue, 30)

    if v250 then
        v250.Changed:Connect(function() -- line: 1346
            -- upvalues:
            --  [1] Parent (ref)
            --  [2] AlchemyRemote (ref)
            --  [3] t_3 (ref)
            --  [4] signature (ref)

            if Parent.Visible then
                task.spawn(function() -- line: 919
                    -- upvalues:
                    --  [1] AlchemyRemote (ref)
                    --  [2] t_3 (ref)
                    --  [3] signature (ref)

                    local Success_4, Result_5 = pcall(function() -- line: 920
                        -- upvalues:
                        --  [1] AlchemyRemote (ref)

                        return AlchemyRemote:InvokeServer("Book")
                    end)

                    if Success_4 and type(Result_5) == "table" then
                        t_3.Book = Result_5
                        t_3.BySignature = {}

                        for _, val_20 in Result_5.Known do
                            t_3.BySignature[signature(val_20.Ingredients)] = val_20
                        end

                        t_3.Dirty = true
                    end
                end)
            end
        end)
    end
end)
local CurrentCamera_1 = workspace.CurrentCamera
local _ = task.spawn

if CurrentCamera_1 then
    CurrentCamera_1:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
end

local CurrentCamera_2 = workspace.CurrentCamera

if CurrentCamera_2 then
    local ViewportSize_2 = CurrentCamera_2.ViewportSize
    t.Scale.Scale = math.clamp(
        math.min(ViewportSize_2.X * 0.66 / 900, ViewportSize_2.Y * 0.8 / 580),
        0.45,
        1
    )
end

RunService.Heartbeat:Connect(function() -- line: 1360
    -- upvalues:
    --  [1] Parent (copy)
    --  [2] LocalPlayer (copy)
    --  [3] t_3 (copy)
    --  [4] v20 (ref)
    --  [5] BackpackUtils_m (copy)
    --  [6] index_13 (ref)
    --  [7] child_11 (ref)
    --  [8] v194 (ref)
    --  [9] renderHeader (copy)
    --  [10] getMaterials (copy)
    --  [11] renderIngredients (copy)
    --  [12] renderSlots (copy)
    --  [13] renderResult (copy)
    --  [14] renderBook (copy)

    if not Parent.Visible then
        return
    end

    local Character = LocalPlayer.Character
    local v251 = Character

    if v251 then
        v251 = Character:FindFirstChild("HumanoidRootPart")
    end

    local Station = t_3.Station

    if not t_3.Busy and (not v251 or (not Station or (not Station.Parent or (v251.Position - Station.Position).Magnitude > 14))) then
        if not Parent.Visible then
            return
        end

        Parent.Visible = false

        if v20 ~= nil then
            v20 = nil
            pcall(function() -- line: 258
                -- upvalues:
                --  [1] BackpackUtils_m (ref)

                BackpackUtils_m:HideHover()
            end)
        end

        if t_3.Prompt then
            t_3.Prompt.Enabled = true
            t_3.Prompt = nil
        end

        t_3.Station = nil

        return
    end

    if t_3.View == "Brew" and index_13 then
        v251 = os.clock() * 0.25
        local v252 = math.sin(v251)
        local v253 = math.cos(v251)
        index_13.CFrame = CFrame.lookAt(
            v194 + Vector3.new(v252, 0.55, v253).Unit * child_11,
            v194 + Vector3.new(0, 0.6, 0)
        )
    end

    if t_3.Dirty then
        t_3.Dirty = false
        renderHeader()
        local v255 = getMaterials()

        if t_3.View == "Brew" then
            renderIngredients(v255)
            renderSlots(v255)
            renderResult(v255)

            return
        end

        renderBook(v255)
    end
end)
setView("Brew")
