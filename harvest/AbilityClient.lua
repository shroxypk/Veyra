-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Main.Menu.Pages.Ability.AbilityClient
-- Class: LocalScript
-- bytes: 31983

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local Modules = ReplicatedStorage.Modules
local Items_m = require(Modules.Items)
local BackpackUtils_m = require(Modules.BackpackUtils)
local Categories = BackpackUtils_m.Categories
local StatManager_m = require(Modules.StatManager)
local Products_m = require(Modules.Products)
local GrimoireRarity_m = require(Modules.GrimoireRarity)
local GrimoireMastery_m = require(Modules.GrimoireMastery)
local v2 = require(Modules.scriptObjs).GetPlayerCharacter()
local v3 = StatManager_m.require(v2)
local Inventory = v2:WaitForChild("Inventory")
local Grimoire = ReplicatedStorage.Remotes.Grimoire
local v4 = script.Parent:WaitForChild("Content")
local Tabs = v4:WaitForChild("Tabs")
local AbilityView = v4:WaitForChild("AbilityView")
local AugmentView = v4:WaitForChild("AugmentView")
local t = { Ability = AbilityView, Augments = AugmentView }
local Body = AbilityView.Info.Body
local Body_1 = AbilityView.Mastery.Body
local Body_2 = AbilityView.Attributes.Body
local List = Body_2.List
local Body_3 = AugmentView.Mastery.Body
local BookHolder = AugmentView.Grimoire.BookHolder
local Body_4 = AugmentView.Available.Body
local Slots = Body_4.Slots
local Empty = Body_4.Empty
local Reset = AugmentView:WaitForChild("Reset")
local InventorySlot = script:WaitForChild("InventorySlot")
local t_1 = { "Augment1", "Augment2", "Augment3" }
local ImageColor3 = script.Outline.ImageColor3
local color = Color3.fromRGB(255, 190, 124)

local _ = function(arg1, arg2) --[[ darken ]] -- line: 63
    return arg1:Lerp(Color3.new(0, 0, 0), arg2)
end

local _ = function(arg3, arg4) --[[ lighten ]] -- line: 67
    return arg3:Lerp(Color3.new(1, 1, 1), arg4)
end

local function hover(arg5, arg6, arg7) -- line: 71
    -- upvalues:
    --  [1] BackpackUtils_m (copy)

    arg5.MouseEnter:Connect(function() -- line: 72
        -- upvalues:
        --  [1] BackpackUtils_m (ref)
        --  [2] arg6 (copy)
        --  [3] arg7 (copy)

        BackpackUtils_m:ShowHover({ key = arg6, text = arg7 })
    end)
    arg5.MouseLeave:Connect(function() -- line: 75
        -- upvalues:
        --  [1] BackpackUtils_m (ref)

        BackpackUtils_m:HideHover()
    end)
end

local function styleTab(arg8, arg9) -- line: 84
    local Background = arg8.Background
    Background:SetAttribute(
        "OriginalColor",
        Background:GetAttribute("OriginalColor") or Background.BackgroundColor3
    )
    local OriginalColor = Background:GetAttribute("OriginalColor")
    Background.BackgroundColor3 = arg9 and OriginalColor or OriginalColor:Lerp(Color3.new(), 0.6)
    local LockBackground = arg8:FindFirstChild("LockBackground")

    if LockBackground then
        LockBackground.Visible = if arg8:GetAttribute("Locked") ~= true then false else true
    end

    local _

    for _, descendant in arg8:GetDescendants() do
        if not descendant:GetAttribute("Ignore") then
            if descendant:IsA("ImageLabel") then
                descendant:SetAttribute(
                    "OriginalColor",
                    descendant:GetAttribute("OriginalColor") or descendant.ImageColor3
                )
                local OriginalColor_1 = descendant:GetAttribute("OriginalColor")
                descendant.ImageColor3 = arg9 and OriginalColor_1 or OriginalColor_1:Lerp(
                    Color3.new(),
                    0.6
                )
            elseif descendant:IsA("TextLabel") then
                descendant.TextTransparency = if not arg9 then 0.6 else 0
            end
        end
    end
end

local Ability = Tabs.Ability

local function refreshTabs(arg10) -- line: 112
    -- upvalues:
    --  [1] Ability (ref)
    --  [2] Tabs (copy)
    --  [3] styleTab (copy)
    --  [4] t (copy)
    --  [5] BackpackUtils_m (copy)

    Ability = arg10

    for _, child in Tabs:GetChildren() do
        if child:IsA("TextButton") then
            local v10 = child == arg10
            styleTab(child, v10)
            local v11 = t[child.Name]

            if v11 then
                v11.Visible = v10
            end
        end
    end

    BackpackUtils_m:HideHover()
end

for _, child_1 in Tabs:GetChildren() do
    if child_1:IsA("TextButton") then
        child_1.Activated:Connect(function() -- line: 129
            -- upvalues:
            --  [1] child_1 (copy)
            --  [2] refreshTabs (copy)

            if child_1:GetAttribute("Locked") then
                return
            end

            refreshTabs(child_1)
        end)
    end
end

Tabs.Augments.MouseEnter:Connect(function() -- line: 138
    -- upvalues:
    --  [1] Tabs (copy)
    --  [2] BackpackUtils_m (copy)

    if Tabs.Augments:GetAttribute("Locked") then
        BackpackUtils_m:ShowHover({ key = "Augments", text = "You have not unlocked Augments." })
    end
end)
Tabs.Augments.MouseLeave:Connect(function() -- line: 143
    -- upvalues:
    --  [1] BackpackUtils_m (copy)

    BackpackUtils_m:HideHover()
end)
local Quests = v2:WaitForChild("Quests")
local v12 = nil

local _ = function(arg11) --[[ setAugmentsLocked ]] -- line: 153
    -- upvalues:
    --  [1] Tabs (copy)
    --  [2] Ability (ref)
    --  [3] refreshTabs (copy)

    Tabs.Augments:SetAttribute("Locked", arg11)

    if arg11 and Ability == Tabs.Augments then
        refreshTabs(Tabs.Ability)

        return
    end

    refreshTabs(Ability)
end

local function watchAugmentQuest(arg12) -- line: 162
    -- upvalues:
    --  [1] v12 (ref)
    --  [2] Tabs (copy)
    --  [3] Ability (ref)
    --  [4] refreshTabs (copy)

    if arg12.Name ~= "AugmentQuest" then
        return
    end

    if v12 then
        v12:Disconnect()
    end

    v12 = arg12:GetAttributeChangedSignal("Completed"):Connect(function() -- line: 169
        -- upvalues:
        --  [1] arg12 (copy)
        --  [2] Tabs (ref)
        --  [3] Ability (ref)
        --  [4] refreshTabs (ref)

        local v14 = if arg12:GetAttribute("Completed") == true then false else true
        Tabs.Augments:SetAttribute("Locked", v14)

        if v14 and Ability == Tabs.Augments then
            refreshTabs(Tabs.Ability)

            return
        end

        refreshTabs(Ability)
    end)
    local v13 = if arg12:GetAttribute("Completed") == true then false else true
    Tabs.Augments:SetAttribute("Locked", v13)

    if v13 and Ability == Tabs.Augments then
        refreshTabs(Tabs.Ability)

        return
    end

    refreshTabs(Ability)
end

Quests.ChildAdded:Connect(watchAugmentQuest)
Quests.ChildRemoved:Connect(function(child_5) -- line: 176
    -- upvalues:
    --  [1] Tabs (copy)
    --  [2] Ability (ref)
    --  [3] refreshTabs (copy)

    if child_5.Name == "AugmentQuest" then
        Tabs.Augments:SetAttribute("Locked", true)

        if Ability == Tabs.Augments then
            refreshTabs(Tabs.Ability)

            return
        end

        refreshTabs(Ability)
    end
end)
refreshTabs(Tabs.Ability)
local AugmentQuest = Quests:FindFirstChild("AugmentQuest")

if AugmentQuest then
    watchAugmentQuest(AugmentQuest)
else
    Tabs.Augments:SetAttribute("Locked", true)

    if Ability == Tabs.Augments then
        refreshTabs(Tabs.Ability)
    else
        refreshTabs(Ability)
    end
end

local RerollRow = Body.RerollRow
local VariantsList = Body.VariantsList
local Disclaimer = Body:FindFirstChild("Disclaimer")
local t_3 = {}
local v16

for _, val in { 1, 5, 10 } do
    local v15 = Products_m.Products["VariantReroll" .. val]
    local t_4 = { Amount = val, Product = nil, Frame = nil }
    v16 = v15 and v15.Product or 0
    t_4.Product = v16
    t_4.Frame = RerollRow:FindFirstChild("Reroll" .. val)
    table.insert(t_3, t_4)
end

local v18 = false
local v19

for _, val_1 in t_3 do
    if val_1.Frame then
        v19 = val_1.Frame
        v19.Visible = val_1.Product ~= 0
    end

    v19 = v18 or val_1.Product ~= 0
    v18 = v19
end

local _ = function(arg14) --[[ variantColor ]] -- line: 213
    local Colors = arg14.Colors
    local v21 = Colors and (Colors.Button or Colors.Primary)

    if not v21 then
        return Color3.fromRGB(225, 225, 225)
    end

    local _, _, v24 = v21:ToHSV()

    if v24 < 0.45 then
        v21 = v21:Lerp(Color3.new(1, 1, 1), 0.45)
    end

    return v21
end

local function buildVariantsText(arg15, arg16) -- line: 227
    local v25 = 0

    for _, val_2 in arg15 do
        v25 += val_2.Weight or 0
    end

    local t_5 = table.clone(arg15)
    table.sort(t_5, function(arg17, arg18) -- line: 235
        local v26 = arg17.Weight or 0
        local v27 = arg18.Weight or 0

        return if v26 == v27 then (arg17.Name or "") < (arg18.Name or "") else v26 > v27
    end)
    local t_6 = {}
    local v30

    for _, val_3 in t_5 do
        local Name = val_3.Name
        local v28 = v25 > 0 and (val_3.Weight or 0) / v25 * 100 or 0
        local Colors_1 = val_3.Colors
        local v29 = Colors_1 and (Colors_1.Button or Colors_1.Primary)

        if not v29 then
            v30 = Color3.fromRGB(225, 225, 225)
        else
            local _, _, v33 = v29:ToHSV()

            if v33 < 0.45 then
                v29 = v29:Lerp(Color3.new(1, 1, 1), 0.45)
            end

            v30 = v29
        end

        v30 = v30:ToHex()
        v29 = string.format("%g", math.floor(v28 * 10 + 0.5) / 10)
        local v34 = `<font color="#{v30}">{Name}</font> {v29}%`

        if Name == arg16 then
            v34 = `<b>{v34}</b>`
        end

        table.insert(t_6, v34)
    end

    return table.concat(t_6, "  |  ")
end

local function updateInfo() -- line: 256
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] Body (copy)
    --  [3] GrimoireRarity_m (copy)
    --  [4] v2 (copy)
    --  [5] v18 (ref)
    --  [6] RerollRow (copy)
    --  [7] BackpackUtils_m (copy)
    --  [8] Disclaimer (copy)
    --  [9] VariantsList (copy)
    --  [10] buildVariantsText (copy)

    local v35 = v3:GetStat("Magic")
    local MagicVariant = v3:GetStat("MagicVariant")
    local v36 = v35
    local Value = Body.Columns.Magic.Value

    if not v35 or v35 == "" or not v36 then
        v36 = "None"
    end

    Value.Text = v36
    v36 = if not MagicVariant then "None" else if MagicVariant == "" then "None" else MagicVariant or "None"
    Body.Columns.Variant.Value.Text = v36
    local v37 = v35

    if v37 then
        v37 = GrimoireRarity_m.Variants[v35]
    end

    v35 = if v37 == nil then false else #v37 > 1
    local v39 = v35 and ((if v2:GetAttribute("PaidRandomItemsRestricted") ~= false then false else true) and v18)

    if not v39 and RerollRow.Visible then
        BackpackUtils_m:HideHover()
    end

    RerollRow.Visible = v39

    if Disclaimer then
        Disclaimer.Visible = v35
    end

    VariantsList.Visible = v35

    if v35 then
        VariantsList.Text = buildVariantsText(v37, MagicVariant)
    end
end

for _, val_4 in t_3 do
    v16 = val_4.Frame

    if v16 and val_4.Product ~= 0 then
        local v41 = `{val_4.Amount}x Reroll`
        v16.Display.Label.Text = v41
        v16.Button.Activated:Connect(function() -- line: 289
            -- upvalues:
            --  [1] BackpackUtils_m (copy)
            --  [2] v2 (copy)
            --  [3] MarketplaceService (copy)
            --  [4] val_4 (copy)

            BackpackUtils_m:HideHover()

            if v2:GetAttribute("PaidRandomItemsRestricted") ~= false then
                return
            end

            MarketplaceService:PromptProductPurchase(v2, val_4.Product)
        end)
        hover(
            v16.Button,
            ("%* Variant Reroll%*"):format(val_4.Amount, if val_4.Amount == 1 then "" else "s"),
            "Buy Variant Rerolls (tradeable). Use one from your inventory to reroll your magic's variant."
        )
        task.spawn(function() -- line: 297
            -- upvalues:
            --  [1] MarketplaceService (copy)
            --  [2] val_4 (copy)
            --  [3] v16 (copy)
            --  [4] v41 (copy)

            local Success, Result = pcall(
                MarketplaceService.GetProductInfoAsync,
                MarketplaceService,
                val_4.Product,
                Enum.InfoType.Product
            )

            if Success and Result then
                v16.Display.Label.Text = `{v41} \238\128\130 {Result.PriceInRobux}`
            end
        end)
    end
end

v3:OnStatChanged("Magic", updateInfo)
v3:OnStatChanged("MagicVariant", updateInfo)
v2:GetAttributeChangedSignal("PaidRandomItemsRestricted"):Connect(updateInfo)
updateInfo()
local Mastery = AbilityView.Mastery
local Progress = Body_1.Progress
local t_7 = {
    body = Body_1.BackgroundColor3,
    outline = Mastery.Outline.ImageColor3,
    front = Progress.Front.BackgroundColor3,
    barOutline = Progress.Outline.ImageColor3,
    label = Progress.Label.TextColor3
}
local v45 = "#FFBE7C"

local function updateMasteryColors() -- line: 329
    -- upvalues:
    --  [1] BackpackUtils_m (copy)
    --  [2] v3 (copy)
    --  [3] Body_1 (copy)
    --  [4] t_7 (copy)
    --  [5] Mastery (copy)
    --  [6] Progress (copy)
    --  [7] v45 (ref)

    local v46 = BackpackUtils_m.SkillColors[v3:GetStat("Magic") or ""]

    if not v46 then
        Body_1.BackgroundColor3 = t_7.body
        Mastery.Outline.ImageColor3 = t_7.outline
        Progress.Front.BackgroundColor3 = t_7.front
        Progress.Outline.ImageColor3 = t_7.barOutline
        Progress.Label.TextColor3 = t_7.label
        v45 = "#FFBE7C"

        return
    end

    local BackgroundColor = v46.BackgroundColor
    local v47 = BackgroundColor:Lerp(Color3.new(0, 0, 0), 0.5)
    Body_1.BackgroundColor3 = BackgroundColor:Lerp(Color3.new(0, 0, 0), 0.8)
    Mastery.Outline.ImageColor3 = v47
    Progress.Front.BackgroundColor3 = BackgroundColor:Lerp(Color3.new(0, 0, 0), 0.2)
    Progress.Outline.ImageColor3 = v47
    Progress.Label.TextColor3 = BackgroundColor:Lerp(Color3.new(1, 1, 1), 0.5)
    v45 = "#" .. BackgroundColor:Lerp(Color3.new(1, 1, 1), 0.3):ToHex()
end

local _ = function() --[[ getMasteryProgress ]] -- line: 352
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] GrimoireMastery_m (copy)

    local v49 = v3:GetStat(GrimoireMastery_m.XPStat) or 0

    return v49, GrimoireMastery_m.TotalXP, GrimoireMastery_m.GetProgress(v49)
end

local function updateMagicMastery() -- line: 357
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] GrimoireMastery_m (copy)
    --  [3] updateMasteryColors (copy)
    --  [4] Body_1 (copy)
    --  [5] Progress (copy)

    local v50 = v3:GetStat(GrimoireMastery_m.XPStat) or 0
    local _ = GrimoireMastery_m.TotalXP
    local v51 = GrimoireMastery_m.GetProgress(v50)
    updateMasteryColors()
    Body_1.Head.Title.Text = "Magic Mastery"
    local Label_2 = Progress.Label
    local v52

    if v51 >= 1 then
        v52 = "Magic Level: MAX"
    else
        local v53 = math.floor(v51 * 100)
        v52 = `Magic Level: {v53}%`
    end

    Label_2.Text = v52
    Progress.Front:TweenSize(
        UDim2.fromScale(v51, 1),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.5,
        true
    )
end

v3:OnStatChanged("Magic", updateMagicMastery)
v3:OnStatChanged(GrimoireMastery_m.XPStat, updateMagicMastery)
Progress.MouseEnter:Connect(function() -- line: 369
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] GrimoireMastery_m (copy)
    --  [3] BackpackUtils_m (copy)
    --  [4] v45 (ref)

    local v54 = v3:GetStat(GrimoireMastery_m.XPStat) or 0
    local TotalXP_2 = GrimoireMastery_m.TotalXP
    local v55 = GrimoireMastery_m.GetProgress(v54)
    local t_8 = { key = "Magic Mastery", text = nil }
    local v56 = math.floor(100 / GrimoireMastery_m.Steps)
    local v57 = BackpackUtils_m
    local v58 = v45
    local v59 = math.floor(v55 * 100)
    t_8.text = `Your proficiency with your magic. Level it up to unlock stronger abilities.\nGained by dealing damage with and using your magic. Every {v56}% grants a Mastery Point.\n<font color="{v58}">{v59}%  ({v54} / {TotalXP_2} XP)</font>`
    v57:ShowHover(t_8)
end)
Progress.MouseLeave:Connect(function() -- line: 377
    -- upvalues:
    --  [1] BackpackUtils_m (copy)

    BackpackUtils_m:HideHover()
end)
updateMagicMastery()
local t_9 = {
    Damage = "Increases the damage dealt by your magic abilities.",
    Cooldown = "Reduces the cooldown of your magic abilities.",
    EnergyCost = "Reduces the energy cost of your magic abilities.",
    Penetration = "Lets your magic ignore a portion of the target's magic resistance."
}

local function formatBonus(arg19, arg20) -- line: 395
    local v60 = if arg19 ~= "Penetration" then 100 else 1
    local v61 = string.format("%g", math.floor(arg20 * v60 * 10 + 0.5) / 10)

    if arg19 == "Damage" then
        return `+{v61}% damage`
    end

    if arg19 == "Cooldown" then
        return `-{v61}% cooldown`
    end

    if arg19 == "EnergyCost" then
        return `-{v61}% energy cost`
    end

    return `{v61}% resistance ignored`
end

local Reset_1 = Body_2.Reset
local Product = Products_m.Products.ResetGrimoireMastery.Product

local _ = function() --[[ getPoints ]] -- line: 412
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] GrimoireMastery_m (copy)

    return v3:GetStat(GrimoireMastery_m.PointsStat) or 0
end

local function getSpent() -- line: 416
    -- upvalues:
    --  [1] GrimoireMastery_m (copy)
    --  [2] v3 (copy)

    local v62 = 0

    for _, val_5 in GrimoireMastery_m.Attributes do
        v62 += v3:GetStat(GrimoireMastery_m.AttributeStat(val_5.Key)) or 0
    end

    return v62
end

local function updateMasteryPoints() -- line: 424
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] GrimoireMastery_m (copy)
    --  [3] Body_2 (copy)
    --  [4] List (copy)
    --  [5] Product (copy)
    --  [6] getSpent (copy)
    --  [7] Reset_1 (copy)
    --  [8] BackpackUtils_m (copy)

    local v64 = v3:GetStat(GrimoireMastery_m.PointsStat) or 0
    Body_2.Points.Amount.Text = ("%* Mastery Point%* Available"):format(
        v64,
        if v64 == 1 then "" else "s"
    )

    for _, child_2 in List:GetChildren() do
        local Frame = child_2:FindFirstChild("Frame")

        if Frame and Frame:FindFirstChild("Plus") then
            Frame.Plus.Visible = v64 > 0
        end
    end

    v64 = if Product == 0 then false else getSpent() > 0

    if not v64 and Reset_1.Visible then
        BackpackUtils_m:HideHover()
    end

    Reset_1.Visible = v64
end

local _ = function(arg21, arg22) --[[ setPoints ]] -- line: 444
    arg21:SetAttribute("Points", arg22)
    arg21.Frame.Val.Text = tostring(arg22)
end

for _, val_6 in GrimoireMastery_m.Attributes do
    local Key = val_6.Key
    local v68 = List:FindFirstChild(Key)

    if v68 then
        local Text = v68.Frame.Title.Text
        local v70 = GrimoireMastery_m.AttributeStat(Key)
        v68.MouseEnter:Connect(function() -- line: 459
            -- upvalues:
            --  [1] GrimoireMastery_m (copy)
            --  [2] v2 (copy)
            --  [3] Key (copy)
            --  [4] BackpackUtils_m (copy)
            --  [5] Text (copy)
            --  [6] t_9 (copy)
            --  [7] formatBonus (copy)
            --  [8] val_6 (copy)

            local v71 = GrimoireMastery_m.GetBonus(v2, Key)
            local t_10 = { key = Text, text = nil }
            local v72 = BackpackUtils_m
            local v73 = t_9[Key] or ""
            local v74 = formatBonus(Key, val_6.PerPoint)
            local v75 = formatBonus(Key, v71)
            t_10.text = `{v73}\nEach point: {v74}\n<font color="#FFBE7C">Current: {v75}</font>`
            v72:ShowHover(t_10)
        end)
        v68.MouseLeave:Connect(function() -- line: 466
            -- upvalues:
            --  [1] BackpackUtils_m (copy)

            BackpackUtils_m:HideHover()
        end)
        v68.Frame.Plus.Activated:Connect(function() -- line: 470
            -- upvalues:
            --  [1] v3 (copy)
            --  [2] GrimoireMastery_m (copy)
            --  [3] Grimoire (copy)
            --  [4] Key (copy)

            if (v3:GetStat(GrimoireMastery_m.PointsStat) or 0) <= 0 then
                return
            end

            Grimoire:FireServer("SpendMasteryPoint", Key)
        end)
        v3:OnStatChanged(v70, function(arg23) -- line: 477
            -- upvalues:
            --  [1] v68 (copy)
            --  [2] updateMasteryPoints (copy)

            local v76 = v68
            local v77 = arg23 or 0
            v76:SetAttribute("Points", v77)
            v76.Frame.Val.Text = tostring(v77)
            updateMasteryPoints()
        end)
        local v78 = v3:GetStat(v70) or 0
        v68:SetAttribute("Points", v78)
        v68.Frame.Val.Text = tostring(v78)
    end
end

Reset_1.Button.Activated:Connect(function() -- line: 484
    -- upvalues:
    --  [1] BackpackUtils_m (copy)
    --  [2] Product (copy)
    --  [3] MarketplaceService (copy)
    --  [4] v2 (copy)

    BackpackUtils_m:HideHover()

    if Product ~= 0 then
        MarketplaceService:PromptProductPurchase(v2, Product)
    end
end)
hover(
    Reset_1.Button,
    "Reset Points",
    "Refund every Mastery Point you've spent so you can spend them again."
)
local v80
local _ = tostring(v80)

if Product ~= 0 then
    task.spawn(function() -- line: 493
        -- upvalues:
        --  [1] MarketplaceService (copy)
        --  [2] Product (copy)
        --  [3] Reset_1 (copy)

        local Success_1, Result_1 = pcall(
            MarketplaceService.GetProductInfoAsync,
            MarketplaceService,
            Product,
            Enum.InfoType.Product
        )

        if Success_1 and Result_1 then
            Reset_1.Display.Label.Text = `Reset Points  {Result_1.PriceInRobux}`
        end
    end)
end

local Points = Body_2.Points
local PointsPerStep = GrimoireMastery_m.PointsPerStep
local v81 = GrimoireMastery_m.Steps * GrimoireMastery_m.PointsPerStep
hover(
    Points,
    "Mastery Points",
    `Earned as Magic Mastery fills: +{PointsPerStep} for every {math.floor(
        100 / GrimoireMastery_m.Steps
    )}% ({v81} total), plus +{GrimoireMastery_m.EvolveBonus} when your grimoire evolves. Spend them to improve your magic's attributes.`
)
v3:OnStatChanged(GrimoireMastery_m.PointsStat, updateMasteryPoints)
updateMasteryPoints()

local function updateMastery() -- line: 508
    -- upvalues:
    --  [1] v3 (copy)
    --  [2] Body_3 (copy)
    --  [3] t_1 (copy)
    --  [4] BookHolder (copy)

    local v82 = v3:GetStat("AugmentLevel") or 0
    local v83 = v3:GetStat("AugmentXP") or 0
    local v84 = v3:GetStat("AugmentMXP") or 1
    local v85 = v84 > 0 and math.clamp(v83 / v84, 0, 1) or 0
    Body_3.Head.Title.Text = `Augment Mastery <font color="#FFBE7C">{v82}</font>`
    Body_3.Progress.Label.Text = `{v83} / {v84}`
    Body_3.Progress.Front:TweenSize(
        UDim2.fromScale(v85, 1),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.5,
        true
    )
    local Slots_1 = Body_3.Slots
    local v86 = math.min(v82, 3)
    Slots_1.Text = `<font color="#FFBE7C">{v86} / {3}</font> augment slots unlocked`

    for key_11, val_7 in t_1 do
        v85 = BookHolder[val_7]
        v84 = v82 < key_11
        v85.Locked.Visible = v84
        local v87 = not v84 and v85.Icon.Image == ""
        v85.Number.Visible = v87
    end
end

hover(
    Body_3.Progress,
    "Augment Mastery",
    "Your proficiency with augments. Can be increased by defeating your evolution spirit & clearing devil rifts."
)

local _ = function(arg24) --[[ connectSlot ]] -- line: 532
    -- upvalues:
    --  [1] BookHolder (copy)
    --  [2] Services_m (copy)
    --  [3] v3 (copy)
    --  [4] Items_m (copy)
    --  [5] BackpackUtils_m (copy)
    --  [6] ImageColor3 (copy)
    --  [7] updateMastery (copy)
    --  [8] color (copy)

    local v88 = BookHolder[arg24]
    local v89 = Services_m.Maid.new()

    local function update() -- line: 536
        -- upvalues:
        --  [1] v89 (copy)
        --  [2] v3 (ref)
        --  [3] arg24 (copy)
        --  [4] Items_m (ref)
        --  [5] BackpackUtils_m (ref)
        --  [6] v88 (copy)
        --  [7] ImageColor3 (ref)
        --  [8] updateMastery (ref)
        --  [9] color (ref)

        v89:DoCleaning()
        local v90 = v3:GetStat(arg24)
        local v91 = v90

        if v91 then
            v91 = if v90 ~= "" then Items_m:LookupItem(v90) else false
        end

        if not v91 then
            BackpackUtils_m:HideHover()
            v88.Icon.Image = ""
            v88.AugmentName.Visible = false
            v88.Glow.Visible = false
            v88.Outline.ImageColor3 = ImageColor3
            updateMastery()

            return
        end

        v88.Icon.Image = v91.Icon or ""
        v88.AugmentName.Text = v90:gsub(" Augment$", "")
        v88.AugmentName.Visible = true
        v88.Glow.Visible = true
        v88.Outline.ImageColor3 = color
        v89:GiveTask(v88.MouseEnter:Connect(function() -- line: 558
            -- upvalues:
            --  [1] BackpackUtils_m (ref)
            --  [2] v90 (copy)
            --  [3] v91 (copy)

            BackpackUtils_m:ShowHover({ key = v90, text = v91.Desc })
        end))
        v89:GiveTask(v88.MouseLeave:Connect(function() -- line: 561
            -- upvalues:
            --  [1] BackpackUtils_m (ref)

            BackpackUtils_m:HideHover()
        end))
        updateMastery()
    end

    v3:OnStatChanged(arg24, update)
    update()
end

local Product_1 = Products_m.Products.ResetAugments.Product

local function updateResetButton() -- line: 578
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] v3 (copy)
    --  [3] Reset (copy)
    --  [4] BackpackUtils_m (copy)
    --  [5] MarketplaceService (copy)
    --  [6] Product_1 (copy)

    local v94 = false

    for _, val_8 in t_1 do
        local v95 = v3:GetStat(val_8)

        if v95 and v95 ~= "" then
            v94 = true
            break
        end
    end

    if not v94 and Reset.Visible then
        BackpackUtils_m:HideHover()
    end

    Reset.Visible = v94
    v94 = MarketplaceService:GetProductInfoAsync(Product_1, Enum.InfoType.Product)
    local _ = v94.UserBasePriceInRobux
    Reset.Display.Label.Text = `Reset Augments \238\128\130 {v94.PriceInRobux}`
end

Reset.Button.Activated:Connect(function() -- line: 601
    -- upvalues:
    --  [1] BackpackUtils_m (copy)
    --  [2] MarketplaceService (copy)
    --  [3] v2 (copy)
    --  [4] Product_1 (copy)

    BackpackUtils_m:HideHover()
    MarketplaceService:PromptProductPurchase(v2, Product_1)
end)
hover(
    Reset.Button,
    "Reset Augments",
    "Reset your augments and refund them back to you. (Can also be done in-game)"
)

local function refreshEmpty() -- line: 610
    -- upvalues:
    --  [1] Slots (copy)
    --  [2] Empty (copy)

    local v96 = 0

    for _, child_3 in Slots:GetChildren() do
        if child_3:IsA("GuiButton") and child_3.Visible then
            v96 += 1
        end
    end

    Slots.Visible = v96 > 0
    Empty.Visible = v96 == 0
end

local function createSlot(arg25) -- line: 621
    -- upvalues:
    --  [1] Items_m (copy)
    --  [2] Categories (copy)
    --  [3] Services_m (copy)
    --  [4] InventorySlot (copy)
    --  [5] BackpackUtils_m (copy)
    --  [6] Grimoire (copy)
    --  [7] v3 (copy)
    --  [8] refreshEmpty (copy)
    --  [9] Inventory (copy)
    --  [10] Slots (copy)

    if not arg25 then
        return
    end

    local Name_1 = arg25.Name
    local v98 = Items_m.AllItems[Name_1]

    if not v98 or v98.Type ~= "Augment" then
        return
    end

    local v99 = Categories[v98.Type]
    local v100 = v99 and v99.Color or Color3.fromRGB(163, 163, 163)
    local v101 = Services_m.Maid.new()
    local v102 = InventorySlot:Clone()
    v102:SetAttribute("RealName", Name_1)
    local v103 = v99 and v99.Order or 0
    v102.Name = v103 .. Name_1
    v102.BackgroundColor3 = v100
    v102.Outline.ImageColor3 = v100:Lerp(Color3.new(0, 0, 0), 0.3)
    v102.Label.Text = Name_1
    v101:GiveTask(v102)
    v101:GiveTask(v102.Activated:Connect(function() -- line: 645
        -- upvalues:
        --  [1] BackpackUtils_m (ref)
        --  [2] Grimoire (ref)
        --  [3] v3 (ref)
        --  [4] arg25 (copy)

        BackpackUtils_m:HideHover()
        Grimoire:FireServer("EquipAugment", v3:GetStat("Augment1"), arg25)
    end))
    v101:GiveTask(v102.MouseEnter:Connect(function() -- line: 649
        -- upvalues:
        --  [1] BackpackUtils_m (ref)
        --  [2] Name_1 (copy)
        --  [3] v98 (copy)

        BackpackUtils_m:ShowHover({ key = Name_1, text = v98.Desc })
    end))
    v101:GiveTask(v102.MouseLeave:Connect(function() -- line: 652
        -- upvalues:
        --  [1] BackpackUtils_m (ref)

        BackpackUtils_m:HideHover()
    end))
    v101:GiveTask(arg25:GetAttributeChangedSignal("Stock"):Connect(function() --[[ updateStock ]] -- line: 656
        -- upvalues:
        --  [1] arg25 (copy)
        --  [2] v102 (copy)
        --  [3] refreshEmpty (ref)

        local v105 = arg25:GetAttribute("Stock") or 1
        v102.Stock.Visible = v105 > 1 and true
        v102.Stock.Text = "x" .. v105
        v102.Visible = v105 > 0 and true
        refreshEmpty()
    end))
    v101:GiveTask(arg25.AncestryChanged:Connect(function(_, arg27) -- line: 665
        -- upvalues:
        --  [1] Inventory (ref)
        --  [2] v101 (copy)
        --  [3] BackpackUtils_m (ref)
        --  [4] refreshEmpty (ref)

        if not arg27 or arg27 ~= Inventory then
            v101:Destroy()
            BackpackUtils_m:HideHover()
            task.defer(refreshEmpty)
        end
    end))
    v102.Parent = Slots
    local v108 = arg25:GetAttribute("Stock") or 1
    v102.Stock.Visible = v108 > 1 and true
    v102.Stock.Text = "x" .. v108
    v102.Visible = v108 > 0 and true
    refreshEmpty()
end

local v111

for _, val_9 in t_1 do
    v111 = BookHolder[val_9]
    local v112 = Services_m.Maid.new()

    local function update_1() --[[ update ]] -- line: 536
        -- upvalues:
        --  [1] v112 (copy)
        --  [2] v3 (copy)
        --  [3] val_9 (copy)
        --  [4] Items_m (copy)
        --  [5] BackpackUtils_m (copy)
        --  [6] v111 (copy)
        --  [7] ImageColor3 (copy)
        --  [8] updateMastery (copy)
        --  [9] color (copy)

        v112:DoCleaning()
        local v113 = v3:GetStat(val_9)
        local v114 = v113

        if v114 then
            v114 = if v113 ~= "" then Items_m:LookupItem(v113) else false
        end

        if not v114 then
            BackpackUtils_m:HideHover()
            v111.Icon.Image = ""
            v111.AugmentName.Visible = false
            v111.Glow.Visible = false
            v111.Outline.ImageColor3 = ImageColor3
            updateMastery()

            return
        end

        v111.Icon.Image = v114.Icon or ""
        v111.AugmentName.Text = v113:gsub(" Augment$", "")
        v111.AugmentName.Visible = true
        v111.Glow.Visible = true
        v111.Outline.ImageColor3 = color
        v112:GiveTask(v111.MouseEnter:Connect(function() -- line: 558
            -- upvalues:
            --  [1] BackpackUtils_m (ref)
            --  [2] v113 (copy)
            --  [3] v114 (copy)

            BackpackUtils_m:ShowHover({ key = v113, text = v114.Desc })
        end))
        v112:GiveTask(v111.MouseLeave:Connect(function() -- line: 561
            -- upvalues:
            --  [1] BackpackUtils_m (ref)

            BackpackUtils_m:HideHover()
        end))
        updateMastery()
    end

    v3:OnStatChanged(val_9, update_1)
    update_1()
    v3:OnStatChanged(val_9, updateResetButton)
end

updateResetButton()
v3:OnStatChanged("AugmentLevel", updateMastery)
v3:OnStatChanged("AugmentXP", updateMastery)
v3:OnStatChanged("AugmentMXP", updateMastery)
updateMastery()
Inventory.ChildAdded:Connect(createSlot)

for _, child_4 in Inventory:GetChildren() do
    task.spawn(createSlot, child_4)
end

refreshEmpty()
