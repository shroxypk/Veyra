-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Main.Menu.Pages.Equipment.Overview
-- Class: LocalScript
-- bytes: 17214

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local _ = require(Modules.ByteNetMax)
local Packets_m = require(Modules.Packets)
local BackpackUtils_m = require(Modules.BackpackUtils)
local Items_m = require(Modules.Items)
local ViewportHandle_m = require(Modules.ViewportHandle)
local Formatter_m = require(Modules.Formatter)
local StatManager_m = require(Modules.StatManager)
local v2, v3 = require(Modules.scriptObjs).GetPlayerCharacter()
local Humanoid = v3:WaitForChild("Humanoid")
local v4 = StatManager_m.require(v2)
local CustomizeFolder = v2:WaitForChild("CustomizeFolder")
local _ = v2:WaitForChild("Binds")
local _ = v2:WaitForChild("bin")
local States = v3:WaitForChild("States")
local Inventory = v2:WaitForChild("Inventory")
local _ = v2:WaitForChild("PlayerGui"):WaitForChild("Gameplay")
local Parent = script.Parent
local Tabs = Parent.Tabs
local Scrolling = Parent.F1.Scrolling
local Vanity = Parent.F1.Vanity
local F2 = Parent.F2
local t = {
    FightingStyle = { Order = 1, Display = "Weapon" },
    Outfit = { Order = 2, Vanity = true, Display = "Outfit" },
    Helmet = { Order = 3, Vanity = true },
    Chest = { Order = 4, Vanity = true },
    Legs = { Order = 5, Vanity = true },
    Face = { Order = 6, Vanity = true },
    Neck = { Order = 7, Vanity = true },
    Back = { Order = 8, Vanity = true }
}
local t_1 = {
    {
        "Health",
        function() -- line: 81
            -- upvalues:
            --  [1] Humanoid (copy)

            return `Health<font face='SourceSans'>:</font> <font color='rgb(107, 170, 109)'>{Humanoid.MaxHealth}</font>`
        end
    },
    {
        "Resolve",
        function() -- line: 85
            -- upvalues:
            --  [1] States (copy)

            return `Resolve<font face='SourceSans'>:</font> <font color='rgb(184, 123, 0)'>{States.MaxResolve.Value}</font>`
        end
    },
    {
        "Energy",
        function() -- line: 89
            -- upvalues:
            --  [1] States (copy)

            return `Energy<font face='SourceSans'>:</font> <font color='rgb(162, 219, 255)'>{States.MaxEnergy.Value}</font>`
        end
    },
    {
        "Health Bonus",
        function() -- line: 93
            -- upvalues:
            --  [1] States (copy)

            return `+{States.Armor.HealthBonus.Value} <font color='rgb(175, 175, 175)'>Health from Gear</font>`
        end
    },
    {
        "Energy Bonus",
        function() -- line: 97
            -- upvalues:
            --  [1] States (copy)

            return `+{States.Armor.EnergyBonus.Value} <font color='rgb(175, 175, 175)'>Energy from Gear</font>`
        end
    },
    {
        "Physical Resistance",
        function() -- line: 101
            -- upvalues:
            --  [1] States (copy)

            return `+{States.Armor.Physical.Value}% <font color='rgb(175, 175, 175)'>Physical Resistance</font>`
        end
    },
    {
        "Magic Resistance",
        function() -- line: 105
            -- upvalues:
            --  [1] States (copy)

            return `+{States.Armor.Magic.Value}% <font color='rgb(175, 175, 175)'>Magic Resistance</font>`
        end
    },
    {
        "Magic Regen",
        function() -- line: 109
            -- upvalues:
            --  [1] States (copy)

            return `+{States.Armor.ManaRegen.Value}% <font color='rgb(175, 175, 175)'>Mana Regen</font>`
        end
    },
    {
        "MonsterBonus",
        function() -- line: 113
            -- upvalues:
            --  [1] States (copy)

            return `+{States.Armor.MonsterBonus.Value}% <font color='rgb(175, 175, 175)'>PvE Damage</font>`
        end
    },
    {
        "HallowedWard",
        function() -- line: 117
            -- upvalues:
            --  [1] States (copy)

            local HallowedWard = States.Armor:FindFirstChild("HallowedWard")
            local v5 = HallowedWard and math.min(HallowedWard.Value, 35) or 0

            return `+{v5}% <font color='rgb(175, 175, 175)'>Hallowed Ward</font>`
        end
    },
    {
        "PEN_PHYS",
        function() -- line: 122
            -- upvalues:
            --  [1] States (copy)

            return `+{States.Armor.PEN_PHYS.Value}% <font color='rgb(175, 175, 175)'>Physical PEN</font>`
        end
    },
    {
        "PEN_MAGIC",
        function() -- line: 126
            -- upvalues:
            --  [1] States (copy)

            return `+{States.Armor.PEN_MAGIC.Value}% <font color='rgb(175, 175, 175)'>Magic PEN</font>`
        end
    }
}
local v6 = Services_m.Maid.new()

local _ = function() --[[ CLEAR_CONNECTIONS ]] -- line: 134
    -- upvalues:
    --  [1] v6 (copy)

    v6:Destroy()
end

local function setSelected(...) -- line: 138
    script:SetAttribute("Selected", ...)
end

local _ = function() --[[ getSelected ]] -- line: 142
    return script:GetAttribute("Selected")
end

local function UnHighlight() -- line: 146
    -- upvalues:
    --  [1] v6 (copy)
    --  [2] setSelected (copy)
    --  [3] Parent (copy)

    v6:Destroy()
    setSelected("")

    for _, descendant in Parent:GetDescendants() do
        if descendant:GetAttribute("Highlighted") ~= nil then
            descendant:SetAttribute("Highlighted", false)
        end
    end
end

local function createLabel(arg1) -- line: 158
    -- upvalues:
    --  [1] F2 (copy)

    local v7 = script.Stat:Clone()
    v7.Name = arg1
    v7.Parent = F2.List
end

local function UpdateUI() -- line: 164
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] F2 (copy)
    --  [3] States (copy)

    for _, val in ipairs(t_1) do
        F2.List[val[1]].Label.Text = val[2]()
    end

    local HallowedWard_1 = F2.List:FindFirstChild("HallowedWard")

    if HallowedWard_1 then
        local HallowedWard_2 = States.Armor:FindFirstChild("HallowedWard")
        HallowedWard_1.Visible = if HallowedWard_2 ~= nil then HallowedWard_2.Value > 0 else false
    end
end

local function updateHair() -- line: 176
    -- upvalues:
    --  [1] CustomizeFolder (copy)
    --  [2] Parent (copy)

    local v9 = if CustomizeFolder.HideHair.Value then "<font color='rgb(255, 76, 79)'>No</font>" else "<font color='rgb(107, 170, 109)'>Yes</font>"
    Parent.F1.HideHair.Display.Label.Text = `Show Hair: {v9}`
end

local function getStat(arg2) -- line: 187
    -- upvalues:
    --  [1] v4 (copy)

    if typeof(arg2) == "Instance" then
        return arg2.Value
    end

    return v4:GetStat(arg2)
end

local function handleOverview(arg3) -- line: 196
    -- upvalues:
    --  [1] BackpackUtils_m (copy)
    --  [2] t (copy)
    --  [3] v4 (copy)
    --  [4] v2 (copy)
    --  [5] Services_m (copy)
    --  [6] UnHighlight (copy)
    --  [7] Formatter_m (copy)
    --  [8] Items_m (copy)
    --  [9] ViewportHandle_m (copy)
    --  [10] Inventory (copy)
    --  [11] getStat (copy)
    --  [12] ReplicatedStorage (copy)
    --  [13] Packets_m (copy)
    --  [14] Vanity (copy)
    --  [15] Scrolling (copy)

    local v12, v16, v17

    for key_2, val_1 in BackpackUtils_m._armorStats do
        local v10 = nil
        local v11 = nil
        v12 = t[key_2]
        local v13 = v12.Display or key_2
        local Vanity_2 = v12.Vanity
        local v15 = v12.Order or 1
        v12 = val_1.Equipped

        if v4:GetStat(val_1.Equipped) == nil or not v12 then
            v12 = v2.CustomizeFolder:FindFirstChild(val_1.Stat)
        end

        v16 = if v4:GetStat(val_1.Visible) ~= nil then val_1.Visible else false
        v17 = if v4:GetStat(val_1.Vanity) ~= nil then val_1.Vanity else false
        local v18 = arg3 and v17 or v12
        local v12 = Services_m.Maid.new()

        local function handleViewPort() -- line: 214
            -- upvalues:
            --  [1] UnHighlight (ref)
            --  [2] v12 (copy)
            --  [3] v10 (ref)
            --  [4] v4 (ref)
            --  [5] v11 (ref)
            --  [6] Formatter_m (ref)
            --  [7] Items_m (ref)
            --  [8] ViewportHandle_m (ref)
            --  [9] v18 (copy)
            --  [10] Inventory (ref)
            --  [11] getStat (ref)
            --  [12] v17 (copy)
            --  [13] Vanity_2 (copy)
            --  [14] arg3 (copy)
            --  [15] ReplicatedStorage (ref)
            --  [16] v16 (copy)
            --  [17] Packets_m (ref)

            UnHighlight()
            v12:Destroy()
            local v19 = v10
            local v20

            if typeof(v19) == "Instance" then
                v20 = v19.Value
            else
                local _ = v12
                v20 = v4:GetStat(v19)
            end

            local Hide = v11.Options.Hide
            local Unequip = v11.Options.Unequip
            local Vanity_1 = v11.Options.Vanity

            for _, child in v11:GetChildren() do
                if child:IsA("ViewportFrame") then
                    child:Destroy()
                end
            end

            local v22 = Formatter_m.formatItem(v20)
            v20 = Items_m:LookupItem(v22)
            local v23 = ViewportHandle_m.new(v22, v11)

            if v23 then
                v23.Size = UDim2.new(0.85, 0, 0.85, 0)
            end

            local v24 = false
            local v25 = v18

            if v25 then
                v25 = Inventory:FindFirstChild(getStat(v18))
            end

            if v25 and v20 then
                local ArmorType = v20.ArmorType
                local v27 = ArmorType or v17

                if v22 ~= "" then
                    v24 = true
                    local v28 = Vanity_2 and not arg3
                    Vanity_1.Visible = v28
                    v12:GiveTask(Hide.MouseButton1Up:Connect(function() -- line: 252
                        -- upvalues:
                        --  [1] ArmorType (copy)
                        --  [2] v17 (ref)
                        --  [3] ReplicatedStorage (ref)
                        --  [4] v16 (ref)

                        if not ArmorType or not v17 then
                            return
                        end

                        local v29 = v16 or v17

                        if ReplicatedStorage.Remotes.Player.VanityEvent:InvokeServer("Toggle", v29) then
                        end
                    end))
                    v12:GiveTask(Unequip.MouseButton1Up:Connect(function() -- line: 261
                        -- upvalues:
                        --  [1] Packets_m (ref)
                        --  [2] v25 (copy)
                        --  [3] UnHighlight (ref)

                        if Packets_m.Inventory.queries.Unequip.invoke({ Item = v25 }) then
                            UnHighlight()
                        end
                    end))
                    v12:GiveTask(Vanity_1.MouseButton1Up:Connect(function() -- line: 270
                        -- upvalues:
                        --  [1] v27 (copy)
                        --  [2] v17 (ref)
                        --  [3] ReplicatedStorage (ref)
                        --  [4] v16 (ref)
                        --  [5] v22 (copy)

                        if not v27 or not v17 then
                            return
                        end

                        if ReplicatedStorage.Remotes.Player.VanityEvent:InvokeServer(
                            "Vanity",
                            v16,
                            v22
                        ) then
                        end
                    end))
                end
            end

            v11.Empty.Visible = if v23 ~= nil then false else true
            v11.Options.Visible = v24
        end

        if arg3 then
            if Vanity_2 then
                v11 = script.Template:Clone()
                v11.LayoutOrder = v15
                v11.Name = key_2 .. "Vanity"
                v11.Type.Text = v13
                v11.Parent = Vanity

                if v11 then
                    v10 = val_1.Vanity
                end
            end
        else
            v11 = script.Template:Clone()
            v11.LayoutOrder = v15
            v11.Name = "Equipped" .. key_2
            v11.Type.Text = v13
            v11.Parent = Scrolling

            if v11 then
                v10 = if v4:GetStat(val_1.Equipped) then val_1.Equipped else if v4:GetStat(
                    val_1.Stat
                ) then val_1.Stat else v2.CustomizeFolder:FindFirstChild(val_1.Stat or "")
            end
        end

        if v11 and v10 then
            v11:SetAttribute("Highlighted", false)
            v11:GetAttributeChangedSignal("Highlighted"):Connect(function() -- line: 320
                -- upvalues:
                --  [1] v11 (ref)

                local v33 = v11:GetAttribute("Highlighted") and Color3.fromRGB(103, 140, 121) or Color3.fromRGB(
                    0,
                    0,
                    0
                )
                v11.BackgroundTransparency = 0.6
                v11.BackgroundColor3 = v33
            end)
            v11.Button.MouseEnter:Connect(function() -- line: 328
                -- upvalues:
                --  [1] Inventory (ref)
                --  [2] getStat (ref)
                --  [3] v10 (ref)
                --  [4] BackpackUtils_m (ref)

                local v35 = Inventory:FindFirstChild(getStat(v10))

                if not v35 then
                    return
                end

                BackpackUtils_m:ShowHover({ key = v35.Name })
            end)
            v11.Button.MouseLeave:Connect(function() -- line: 339
                -- upvalues:
                --  [1] BackpackUtils_m (ref)

                BackpackUtils_m:HideHover()
            end)
        end

        if v10 then
            if typeof(v10) == "Instance" then
                v10:GetPropertyChangedSignal("Value"):Connect(handleViewPort)
            else
                v4:OnStatChanged(v10, handleViewPort)
            end

            task.spawn(handleViewPort)
        end
    end
end

for _, val_2 in ipairs(t_1) do
    local v36 = val_2[1]
    local v37 = script.Stat:Clone()
    v37.Name = v36
    v37.Parent = F2.List
end

handleOverview(nil)
handleOverview(true)
local t_4 = { Vanity, Scrolling }

for _, child_1 in Tabs:GetChildren() do
    if child_1:IsA("TextButton") then
        createLabel = Parent.F1:FindFirstChild(child_1.Name)
        local BackgroundColor3 = child_1.BackgroundColor3

        local function attribConnect() -- line: 378
            -- upvalues:
            --  [1] child_1 (copy)
            --  [2] BackgroundColor3 (copy)

            local Selected = child_1:GetAttribute("Selected")
            local v39 = child_1
            v39.BackgroundColor3 = Selected and BackgroundColor3 or BackgroundColor3:Lerp(
                Color3.new(),
                0.6
            )

            for _, child_2 in child_1:GetChildren() do
                if child_2:IsA("ImageLabel") then
                    child_2:SetAttribute(
                        "OriginalColor",
                        child_2:GetAttribute("OriginalColor") or child_2.ImageColor3
                    )
                    local OriginalColor = child_2:GetAttribute("OriginalColor")
                    child_2.ImageColor3 = Selected and OriginalColor or OriginalColor:Lerp(
                        Color3.new(),
                        0.6
                    )
                elseif child_2:IsA("TextLabel") then
                    child_2.TextTransparency = if not Selected then 0.6 else 0
                end
            end
        end

        child_1.MouseButton1Up:Connect(function() -- line: 394
            -- upvalues:
            --  [1] child_1 (copy)
            --  [2] Tabs (copy)
            --  [3] UnHighlight (copy)
            --  [4] t_4 (copy)
            --  [5] createLabel (copy)

            if child_1:GetAttribute("Selected") then
                return
            end

            for _, child_3 in Tabs:GetChildren() do
                if child_3:IsA("TextButton") then
                    child_3:SetAttribute("Selected", false)
                end
            end

            UnHighlight()
            child_1:SetAttribute("Selected", true)

            for _, val_3 in t_4 do
                val_3.Visible = val_3 == createLabel
            end
        end)
        child_1:SetAttribute("Selected", createLabel.Visible)
        child_1:GetAttributeChangedSignal("Selected"):Connect(attribConnect)
        task.spawn(attribConnect)
    end
end

script:GetAttributeChangedSignal("Selected"):Connect(function() -- line: 419
end)
Parent.F1.HideHair.MouseButton1Up:Connect(function() -- line: 423
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    ReplicatedStorage.Remotes.Player.VanityEvent:InvokeServer("HideHair")
end)
CustomizeFolder.HideHair:GetPropertyChangedSignal("Value"):Connect(updateHair)
v4:OnStatChanged("TimePlayed", UpdateUI)
UpdateUI()
local v46 = if not CustomizeFolder.HideHair.Value then "<font color='rgb(107, 170, 109)'>Yes</font>" else "<font color='rgb(255, 76, 79)'>No</font>"
Parent.F1.HideHair.Display.Label.Text = `Show Hair: {v46}`
