-- Decompiled with Veyra harvester
-- Instance: StarterGui.HalloweenUI.HalloweenBlacksmith
-- Class: LocalScript
-- bytes: 38663

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Formatter_m = require(ReplicatedStorage.Modules.Formatter)
local StatManager_m = require(ReplicatedStorage.Modules.StatManager)
local Items_m = require(ReplicatedStorage.Modules.Items)
local ViewportHandle_m = require(ReplicatedStorage.Modules.ViewportHandle)
local HalloweenWeapons_m = require(ReplicatedStorage.Modules.HalloweenWeapons)
local Basic_m = require(ReplicatedStorage.Modules.Basic)
local Star = ReplicatedStorage.Modules.BackpackUtils:FindFirstChild("Star")

local _ = function(n1: number) --[[ starText ]] -- line: 30
    -- upvalues:
    --  [1] Basic_m (copy)

    local v1 = math.floor(n1)
    n1 = math.clamp(v1, 0, Basic_m.MaxQuality)

    return string.rep("\226\152\133", n1) .. string.rep("\226\152\134", Basic_m.MaxQuality - n1)
end

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Parent = script.Parent
local color = Color3.fromRGB(255, 255, 255)
local color_1 = Color3.fromRGB(255, 245, 235)
local color_2 = Color3.fromRGB(225, 215, 235)
local HalloweenBlacksmith = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local TextBox = nil
local t = {}
local v12 = "All"
local Frame_1 = nil
local v14 = nil
local ScrollingFrame_1 = nil
local UIGridLayout = nil
local v17 = nil
local v18 = nil
local v19 = nil
local v20 = nil
local v21 = nil
local t_1 = {}

local _ = function(arg1) --[[ stat ]] -- line: 78
    -- upvalues:
    --  [1] v4 (ref)

    local v22 = v4

    if v22 then
        v22 = v4:GetStat(arg1)
    end

    return v22
end

local _ = function(s1: string, s2: string) --[[ colored ]] -- line: 82
    return `<font color="{s1}">{s2}</font>`
end

local _ = function(arg2, arg3) --[[ change ]] -- line: 87
    return `{arg2} > <b>{arg3}</b>`
end

local function halloweenWeapons() -- line: 92
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] Formatter_m (copy)
    --  [3] Items_m (copy)
    --  [4] HalloweenWeapons_m (copy)

    local t_2 = {}
    local Inventory = LocalPlayer:FindFirstChild("Inventory")

    for _, val in Inventory and Inventory:GetChildren() or {} do
        local v24 = Formatter_m.formatItem(val.Name)
        local v25 = Items_m:LookupItem(v24)

        if HalloweenWeapons_m.Is(v25) then
            local t_3 = { Key = nil, Name = nil, Info = nil, Container = nil, Level = nil }
            t_3.Key, t_3.Name, t_3.Info, t_3.Container = val.Name, v24, v25, val
            t_3.Level = HalloweenWeapons_m.LevelOf(val)
            table.insert(t_2, t_3)
        end
    end

    table.sort(t_2, function(arg4, arg5) -- line: 103
        return if arg4.Level == arg5.Level then if arg4.Name == arg5.Name then arg4.Key < arg5.Key else arg4.Name < arg5.Name else arg4.Level > arg5.Level
    end)

    return t_2
end

local _ = function(arg6, arg7) --[[ copiesFor ]] -- line: 116
    -- upvalues:
    --  [1] v4 (ref)

    local v26 = v4

    if v26 then
        v26 = v4:GetStat("FightingStyle")
    end

    local t_4 = {}

    for _, val_1 in arg7 do
        if val_1.Name == arg6.Name and val_1.Key ~= arg6.Key and val_1.Key ~= v26 and not val_1.Container:GetAttribute(
            "Locked"
        ) then
            table.insert(t_4, val_1)
        end
    end

    table.sort(t_4, function(arg8, arg9) -- line: 125
        return if arg8.Level == arg9.Level then arg8.Key < arg9.Key else arg8.Level < arg9.Level
    end)

    return t_4
end

local _ = function(u1: userdata, b1: boolean) --[[ setEnabled ]] -- line: 134
    u1.Label.TextTransparency = if not b1 then 0.45 else 0
end

local _ = function(u2: userdata, arg10: any) --[[ addClick ]] -- line: 138
    local Click_TextButton = Instance.new("TextButton")
    Click_TextButton.Name = "Click"
    Click_TextButton.Size = UDim2.fromScale(1, 1)
    Click_TextButton.BackgroundTransparency = 1
    Click_TextButton.Text = ""
    Click_TextButton.ZIndex = u2.ZIndex + 10
    Click_TextButton.Parent = u2
    Click_TextButton.Activated:Connect(arg10)

    return Click_TextButton
end

local _ = function(arg11: any, s3: string) --[[ showWeapon ]] -- line: 150
    -- upvalues:
    --  [1] ViewportHandle_m (copy)
    --  [2] color (copy)
    --  [3] color_1 (copy)

    local v28 = ViewportHandle_m.new(s3, arg11.Icon, true)

    if v28 then
        v28.Ambient = color
        v28.LightColor = color_1
        v28.ZIndex = arg11.Icon.ZIndex + 1
    end
end

local function fillCard(arg12, arg13) -- line: 160
    -- upvalues:
    --  [1] HalloweenWeapons_m (copy)
    --  [2] Basic_m (copy)
    --  [3] Formatter_m (copy)

    local Level = arg13.Level
    local v29 = HalloweenWeapons_m.Cost(Level)
    local v30 = HalloweenWeapons_m.Stats(arg13.Info, Level)
    local v31 = tonumber(arg13.Container:GetAttribute("Quality")) or 0
    arg12.ItemName.RichText = true
    local ItemName = arg12.ItemName
    local Name = arg13.Name
    local v32 = math.floor(v31)
    local v33 = math.clamp(v32, 0, Basic_m.MaxQuality)
    local v35 = string.rep("\226\152\133", v33) .. string.rep(
        "\226\152\134",
        Basic_m.MaxQuality - v33
    )
    ItemName.Text = `{Name}  <font color="#FFD27A">{v35}</font>`

    if v29 then
        arg12.ItemType.Text = `Level {`{Level} > <b>{Level + 1}</b>`}`
        arg12.Stats.Text = `Damage {`{v30} > <b>{HalloweenWeapons_m.Stats(arg13.Info, Level + 1)}</b>`}`
        local Needs = arg12.Needs
        local MasteryType = arg13.Info.MasteryType
        Needs.Text = `{MasteryType} Prof. {`{Level} > <b>{Level + 1}</b>`}`
        arg12.Price.Visible = true
        arg12.Price.Amount.Text = Formatter_m.addCommas(v29)
        arg12.Purchase.Label.Text = "Reforge"
        arg12.Purchase.Label.TextTransparency = 0

        return
    end

    arg12.ItemType.Text = `Level {Level} (max)`
    arg12.Stats.Text = `Damage {v30}`
    arg12.Needs.Text = `{arg13.Info.MasteryType} Prof. {Level}`
    arg12.Price.Visible = false
    arg12.Purchase.Label.Text = "Max Level"
    arg12.Purchase.Label.TextTransparency = 0.45
end

local v36 = nil

local function showList() -- line: 187
    -- upvalues:
    --  [1] v21 (ref)
    --  [2] v19 (ref)
    --  [3] v36 (ref)

    v21 = nil
    v19 = nil
    v36()
end

local _ = function(s4: string) --[[ showStep ]] -- line: 193
    -- upvalues:
    --  [1] v21 (ref)
    --  [2] v19 (ref)
    --  [3] ScrollingFrame_1 (ref)
    --  [4] v36 (ref)

    v21 = s4
    v19 = nil
    ScrollingFrame_1.CanvasPosition = Vector2.zero
    v36()
end

local _ = function(arg14) --[[ blockedReason ]] -- line: 201
    -- upvalues:
    --  [1] v4 (ref)

    local v37 = v4
    local Key = arg14.Key

    if v37 then
        v37 = v4:GetStat("FightingStyle")
    end

    if Key == v37 then
        return "Equipped: unequip it to melt it down."
    end

    if arg14.Container:GetAttribute("Locked") then
        return "Locked: unlock it in your inventory to melt it down."
    end

    return nil
end

local function describe(arg15) -- line: 210
    local v38 = tonumber(arg15.Container:GetAttribute("Quality")) or 0
    local Enchantment = arg15.Container:GetAttribute("Enchantment")

    return table.concat(
        {
            `Level {arg15.Level}`,
            if v38 > 0 then `Quality {v38}` else "no quality",
            if typeof(Enchantment) == "string" and Enchantment ~= "" then `enchant: {Enchantment}` else "no enchantment"
        },
        ", "
    )
end

local function makeSlot(arg16) -- line: 221
    -- upvalues:
    --  [1] v8 (ref)
    --  [2] ViewportHandle_m (copy)
    --  [3] color (copy)
    --  [4] color_1 (copy)
    --  [5] Basic_m (copy)
    --  [6] Star (copy)
    --  [7] v7 (ref)
    --  [8] v19 (ref)
    --  [9] v36 (ref)
    --  [10] ScrollingFrame_1 (ref)

    local v42 = v8:Clone()
    v42.Name = arg16.Key
    v42.Visible = true
    local v43 = ViewportHandle_m.new(arg16.Name, v42:FindFirstChild("Holder") or v42, true)

    if v43 then
        v43.Ambient = color
        v43.LightColor = color_1
    end

    local Stars = v42:FindFirstChild("Stars")
    local v44 = math.floor(tonumber(arg16.Container:GetAttribute("Quality")) or 0)

    if Stars and Star then
        for _ = 1, math.clamp(v44, 0, Basic_m.MaxQuality) do
            local _ = math.clamp(v44, 0, Basic_m.MaxQuality)
            Star:Clone().Parent = Stars
        end
    end

    local v46 = v7.ItemType:Clone()
    v46.Name = "LevelBadge"

    for _, child in v46:GetChildren() do
        child:Destroy()
    end

    v46.RichText = false
    v46.TextScaled = false
    v46.TextSize = 12
    v46.TextColor3 = Color3.fromRGB(255, 200, 140)
    v46.TextStrokeTransparency = 0.3
    v46.TextXAlignment = Enum.TextXAlignment.Left
    v46.TextYAlignment = Enum.TextYAlignment.Bottom
    v46.AnchorPoint = Vector2.zero
    v46.Position = UDim2.fromOffset(4, 0)
    v46.Size = UDim2.new(1, -6, 1, -3)
    v46.ZIndex = v42.ZIndex + 5
    v46.Parent = v42
    local v47 = v46:Clone()
    v47.Name = "StateTag"
    v47.TextColor3 = Color3.fromRGB(235, 225, 240)
    v47.TextXAlignment = Enum.TextXAlignment.Left
    v47.TextYAlignment = Enum.TextYAlignment.Top
    v47.Position = UDim2.fromOffset(4, 2)
    v47.Parent = v42

    if v42:IsA("GuiButton") then
        v42.Activated:Connect(function() -- line: 264
            -- upvalues:
            --  [1] v19 (ref)
            --  [2] arg16 (copy)
            --  [3] v36 (ref)

            v19 = arg16.Key
            v36()
        end)
    else
        local TextButton_1 = Instance.new("TextButton")
        TextButton_1.Name = "Click"
        TextButton_1.Size = UDim2.fromScale(1, 1)
        TextButton_1.BackgroundTransparency = 1
        TextButton_1.Text = ""
        TextButton_1.ZIndex = v42.ZIndex + 10
        TextButton_1.Parent = v42
        TextButton_1.Activated:Connect(function() -- line: 269
            -- upvalues:
            --  [1] v19 (ref)
            --  [2] arg16 (copy)
            --  [3] v36 (ref)

            v19 = arg16.Key
            v36()
        end)
    end

    v42.Parent = ScrollingFrame_1

    return v42
end

local v48 = nil

local function fillStep(arg17, arg18) -- line: 279
    -- upvalues:
    --  [1] HalloweenWeapons_m (copy)
    --  [2] v21 (ref)
    --  [3] v19 (ref)
    --  [4] v36 (ref)
    --  [5] v48 (ref)
    --  [6] v7 (ref)
    --  [7] Frame_1 (ref)
    --  [8] ViewportHandle_m (copy)
    --  [9] color (copy)
    --  [10] color_1 (copy)
    --  [11] fillCard (copy)
    --  [12] v4 (ref)
    --  [13] v14 (ref)
    --  [14] ScrollingFrame_1 (ref)
    --  [15] makeSlot (copy)
    --  [16] UIGridLayout (ref)
    --  [17] v20 (ref)
    --  [18] v17 (ref)
    --  [19] describe (copy)
    --  [20] v18 (ref)
    --  [21] t_1 (copy)

    if not HalloweenWeapons_m.Cost(arg17.Level) then
        v21 = nil
        v19 = nil
        v36()

        return
    end

    local v50, v51

    if v48 then
        if v48:GetAttribute("Key") ~= arg17.Key then
            if v48 then
                v48:Destroy()
            end

            v48 = v7:Clone()
            v48.Name = "Weapon"
            v48:SetAttribute("Key", arg17.Key)
            v48.Position = UDim2.fromOffset(42, v7.Position.Y.Offset)
            v48.Purchase.Visible = false
            v48.Visible = true
            v48.Parent = Frame_1
            v50 = v48
            v51 = ViewportHandle_m.new(arg17.Name, v50.Icon, true)

            if v51 then
                v51.Ambient = color
                v51.LightColor = color_1
                v51.ZIndex = v50.Icon.ZIndex + 1
            end
        end
    else
        if v48 then
            v48:Destroy()
        end

        v48 = v7:Clone()
        v48.Name = "Weapon"
        v48:SetAttribute("Key", arg17.Key)
        v48.Position = UDim2.fromOffset(42, v7.Position.Y.Offset)
        v48.Purchase.Visible = false
        v48.Visible = true
        v48.Parent = Frame_1
        v50 = v48
        v51 = ViewportHandle_m.new(arg17.Name, v50.Icon, true)

        if v51 then
            v51.Ambient = color
            v51.LightColor = color_1
            v51.ZIndex = v50.Icon.ZIndex + 1
        end
    end

    fillCard(v48, arg17)
    local t_6 = {}
    local v53 = 0

    for _, val_2 in arg18 do
        if val_2.Name == arg17.Name and val_2.Key ~= arg17.Key then
            local Key_2 = val_2.Key
            local v54 = v4

            if v54 then
                v54 = v4:GetStat("FightingStyle")
            end

            val_2.Blocked = if Key_2 == v54 then "Equipped: unequip it to melt it down." else if val_2.Container:GetAttribute(
                "Locked"
            ) then "Locked: unlock it in your inventory to melt it down." else nil
            table.insert(t_6, val_2)

            if not val_2.Blocked then
                v53 += 1
            end
        end
    end

    table.sort(t_6, function(arg19, arg20) -- line: 313
        return if arg19.Blocked == nil == (if arg20.Blocked ~= nil then false else true) then if arg19.Level == arg20.Level then arg19.Key < arg20.Key else arg19.Level < arg20.Level else arg19.Blocked == nil
    end)
    local v58 = nil

    for _, val_3 in t_6 do
        if val_3.Key == v19 then
            v58 = val_3
        end
    end

    if not v58 and t_6[1] and not t_6[1].Blocked then
        v58 = t_6[1]
        v19 = v58.Key
    end

    v14.Text = if v53 > 0 then `Pick a duplicate {arg17.Name} to melt down:` else `Needs a duplicate {arg17.Name} to melt down. You have none that aren't equipped or locked.`
    v53 = {}

    for key_5, val_4 in t_6 do
        v53[val_4.Key] = true
        local v61 = ScrollingFrame_1:FindFirstChild(val_4.Key) or makeSlot(val_4)
        v61.LayoutOrder = key_5
        v61.LevelBadge.Text = `Lv {val_4.Level}`
        local StateTag = v61.StateTag
        local Key_3 = val_4.Key
        local v62 = v4

        if v62 then
            v62 = v4:GetStat("FightingStyle")
        end

        StateTag.Text = if Key_3 ~= v62 then "" else "E"
        local v64 = v61:FindFirstChild("Lock")

        if v64 and v64:IsA("GuiObject") then
            v64.Visible = if val_4.Container:GetAttribute("Locked") ~= true then false else true
        end

        v64 = if v58 == nil then false else val_4.Key == v58.Key

        for _, val_5 in { "SelectedOutline", "Check" } do
            local v66 = v61:FindFirstChild(val_5)

            if v66 and v66:IsA("GuiObject") then
                v66.Visible = v64
            end
        end

        for _, child_1 in (v61:FindFirstChild("Holder") or v61):GetChildren() do
            if child_1:IsA("ViewportFrame") then
                child_1.ImageTransparency = if not val_4.Blocked then 0 else 0.65
            end
        end
    end

    for _, child_2 in ScrollingFrame_1:GetChildren() do
        if child_2:IsA("GuiObject") and not v53[child_2.Name] then
            child_2:Destroy()
        end
    end

    ScrollingFrame_1.CanvasSize = UDim2.fromOffset(0, UIGridLayout.AbsoluteContentSize.Y)
    local v72

    if v20 then
        if v20.Key == arg17.Key then
            if os.clock() < v20.Until then
                v17.Text = `<font color="#E0705A">{v20.Text}</font>`
            elseif not v58 then
                v17.Text = ""
            elseif v58.Blocked then
                v17.Text = `<font color="#E0705A">{v58.Blocked}</font>`
            else
                local v71 = v17
                local Name_1 = v58.Name
                v72 = describe(v58)
                v71.Text = `Melts: {Name_1}, {v72}`
            end
        elseif not v58 then
            v17.Text = ""
        elseif v58.Blocked then
            v17.Text = `<font color="#E0705A">{v58.Blocked}</font>`
        else
            local v74 = v17
            local Name_2 = v58.Name
            v72 = describe(v58)
            v74.Text = `Melts: {Name_2}, {v72}`
        end
    elseif not v58 then
        v17.Text = ""
    elseif v58.Blocked then
        v17.Text = `<font color="#E0705A">{v58.Blocked}</font>`
    else
        local v76 = v17
        local Name_3 = v58.Name
        v72 = describe(v58)
        v76.Text = `Melts: {Name_3}, {v72}`
    end

    local Label = v18.Label
    local v77

    if v58 then
        v77 = if os.clock() < (t_1[v58.Key] or 0) then `Sure? It's Lv {v58.Level}` else "Melt & Reforge"
    else
        v77 = "Melt & Reforge"
    end

    Label.Text = v77
    v77 = false
    local v78 = v18

    if v58 ~= nil then
        v77 = not v58.Blocked
    end

    v78.Label.TextTransparency = if not v77 then 0.45 else 0
end

local function melt() -- line: 386
    -- upvalues:
    --  [1] HalloweenBlacksmith (ref)
    --  [2] v21 (ref)
    --  [3] v19 (ref)
    --  [4] v18 (ref)
    --  [5] LocalPlayer (copy)
    --  [6] HalloweenWeapons_m (copy)
    --  [7] t_1 (copy)
    --  [8] v36 (ref)
    --  [9] v20 (ref)

    if not HalloweenBlacksmith or not v21 or not v19 or v18.Label.TextTransparency ~= 0 then
        return
    end

    local v80 = v19
    local v81 = LocalPlayer.Inventory:FindFirstChild(v80)

    if v81 and HalloweenWeapons_m.LevelOf(v81) > 1 then
        if os.clock() > (t_1[v80] or 0) then
            t_1[v80] = os.clock() + 3
            v36()
            task.delay(3, v36)

            return
        end
    end

    t_1[v80] = nil
    local v83 = v21
    local v84, v85 = HalloweenBlacksmith:InvokeServer("Upgrade", v83, v80)

    if v84 then
        v21 = nil
        v19 = nil
        v36()

        return
    end

    local t_7 = {
        Key = v83,
        Text = tostring(v85 or "Couldn't reforge it."),
        Until = os.clock() + 4
    }
    v20 = t_7
    v36()
    task.delay(4, v36)
end

local t_8 = {}

local function f() -- line: 412
    -- upvalues:
    --  [1] v5 (ref)
    --  [2] halloweenWeapons (copy)
    --  [3] v21 (ref)
    --  [4] v6 (ref)
    --  [5] v9 (ref)
    --  [6] Frame_1 (ref)
    --  [7] t (copy)
    --  [8] TextBox (ref)
    --  [9] fillStep (copy)
    --  [10] v12 (ref)
    --  [11] t_8 (copy)
    --  [12] v7 (ref)
    --  [13] ViewportHandle_m (copy)
    --  [14] color (copy)
    --  [15] color_1 (copy)
    --  [16] v19 (ref)
    --  [17] ScrollingFrame_1 (ref)
    --  [18] f (ref)
    --  [19] fillCard (copy)
    --  [20] Formatter_m (copy)
    --  [21] v4 (ref)

    if not v5 then
        return
    end

    local v86 = halloweenWeapons()

    if v21 then
        for _, val_6 in v86 do
            if val_6.Key == v21 then
                v6.Visible = false
                v9.Visible = false
                Frame_1.Visible = true

                for _, val_7 in t, nil, nil do
                    val_7.Visible = false
                end

                TextBox.Parent.Visible = false
                fillStep(val_6, v86)

                return
            end
        end

        v21 = nil
    end

    v6.Visible = true
    v9.Visible = true
    Frame_1.Visible = false
    TextBox.Parent.Visible = true
    local v88 = string.lower(TextBox.Text)
    local t_9 = {}

    for _, val_8 in v86 do
        local v89 = v12
        local Info = val_8.Info.MasteryType

        if v89 == "All" or Info == v12 then
            if v88 ~= "" then
                if string.find(string.lower(val_8.Name), v88, 1, true) then
                    table.insert(t_9, val_8)
                end
            else
                table.insert(t_9, val_8)
            end
        end
    end

    local v90

    for key_12, val_9 in t do
        v90 = true
        val_9.Visible = v90
        v90 = if key_12 ~= v12 then false else true
        val_9.Label.TextTransparency = if not v90 then 0.45 else 0
    end

    local t_10 = {}

    for key_13, val_10 in t_9 do
        v90 = val_10.Key
        t_10[v90] = true
        v90 = t_8[val_10.Key]

        if not v90 then
            v90 = v7:Clone()
            v90.Name = val_10.Key
            v90.Visible = true
            t_8[val_10.Key] = v90
            v90.Parent = v6
            local v92 = v90
            local v93 = ViewportHandle_m.new(val_10.Name, v92.Icon, true)

            if v93 then
                v93.Ambient = color
                v93.LightColor = color_1
                v93.ZIndex = v92.Icon.ZIndex + 1
            end

            local Key_4 = val_10.Key
            local Purchase = v90.Purchase
            local TextButton_2 = Instance.new("TextButton")
            TextButton_2.Name = "Click"
            TextButton_2.Size = UDim2.fromScale(1, 1)
            TextButton_2.BackgroundTransparency = 1
            TextButton_2.Text = ""
            TextButton_2.ZIndex = Purchase.ZIndex + 10
            TextButton_2.Parent = Purchase
            TextButton_2.Activated:Connect(function() -- line: 464
                -- upvalues:
                --  [1] v90 (ref)
                --  [2] Key_4 (copy)
                --  [3] v21 (ref)
                --  [4] v19 (ref)
                --  [5] ScrollingFrame_1 (ref)
                --  [6] f (ref)

                if v90.Purchase.Label.TextTransparency == 0 then
                    v21 = Key_4
                    v19 = nil
                    ScrollingFrame_1.CanvasPosition = Vector2.zero
                    f()
                end
            end)
        end

        v90.Position = UDim2.fromOffset((key_13 - 1) * (v7.Size.X.Offset + 20), 0)
        fillCard(v90, val_10)
    end

    for key_14, val_11 in t_8 do
        if not t_10[key_14] then
            val_11:Destroy()
            t_8[key_14] = nil
        end
    end

    local v97 = #t_9 * (v7.Size.X.Offset + 20)
    v6.CanvasSize = UDim2.fromOffset(math.max(0, v97 - 20), 0)
    local v99 = v9
    local v100

    if #v86 == 0 then
        v100 = "Bring me a Halloween weapon, another copy of it to melt down, and Candy Corn."
    elseif #t_9 == 0 then
        v100 = "Nothing matches."
    else
        v97 = v4
        local AddCommas = Formatter_m.addCommas

        if v97 then
            v97 = v4:GetStat("CandyCorn")
        end

        local v101 = AddCommas(v97 or 0)
        v100 = `You have {v101} Candy Corn. Each level costs Candy Corn and another copy of the weapon.`
    end

    v99.Text = v100
end

local v102 = nil
local t_11 = { "All", "Light", "Medium", "Heavy" }
local v103 = nil

local function build() -- line: 486
    -- upvalues:
    --  [1] Parent (copy)
    --  [2] v5 (ref)
    --  [3] v102 (ref)
    --  [4] v7 (ref)
    --  [5] PlayerGui (copy)
    --  [6] v8 (ref)
    --  [7] v6 (ref)
    --  [8] Frame_1 (ref)
    --  [9] v14 (ref)
    --  [10] color_2 (copy)
    --  [11] ScrollingFrame_1 (ref)
    --  [12] UIGridLayout (ref)
    --  [13] v18 (ref)
    --  [14] melt (copy)
    --  [15] v17 (ref)
    --  [16] v9 (ref)
    --  [17] t_11 (copy)
    --  [18] t (copy)
    --  [19] v12 (ref)
    --  [20] f (ref)
    --  [21] TextBox (ref)
    --  [22] v103 (ref)
    --  [23] showList (copy)
    --  [24] v10 (ref)

    local Shop = Parent:WaitForChild("Shop")
    v5 = Instance.new("ScreenGui")
    v5.Name = "HalloweenForge"
    v5.ResetOnSpawn = false
    v5.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local v104 = v5
    local v105 = Parent:IsA("ScreenGui") and Parent.DisplayOrder or 0
    v104.DisplayOrder = v105 + 1
    v5.Enabled = false
    v102 = Shop:Clone()
    v102.Name = "Forge"
    v102.Visible = true
    v102.AnchorPoint = Vector2.new(0.5, 0.5)
    v102.Position = UDim2.new(0.5, 0, 0.5, -30)

    for _, val_12 in { "SwitchHint", "RotationTimer" } do
        local v108 = v102:FindFirstChild(val_12)

        if v108 then
            v108:Destroy()
        end
    end

    local TitlePlate = v102.TitlePlate

    if TitlePlate:FindFirstChild("Switch") then
        TitlePlate.Switch:Destroy()
    end

    TitlePlate.Title.Text = "Gravelight Forge"
    TitlePlate.Subtitle.Text = "Halloween weapons, reforged with Candy Corn"
    local v109 = v102.Panel
    local Card1 = v109.Card1
    v7 = Card1:Clone()

    for _, child_3 in v109:GetChildren() do
        if child_3.Name ~= "PanelOverlay" then
            child_3:Destroy()
        end
    end

    v7.ItemType.RichText = true

    for _, val_13 in { { "Stats", 163 }, { "Needs", 179 } } do
        local v110 = v7.ItemType:Clone()
        v110.Name = val_13[1]
        v110.Position = UDim2.fromOffset(v7.ItemType.Position.X.Offset, val_13[2])
        v110.TextScaled = true
        local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
        UITextSizeConstraint.MaxTextSize = v7.ItemType.TextSize
        UITextSizeConstraint.MinTextSize = 9
        UITextSizeConstraint.Parent = v110
        v110.Parent = v7
    end

    v7.Price.Position = v7.Price.Position + UDim2.fromOffset(0, 16)
    v7.Purchase.Position = v7.Purchase.Position + UDim2.fromOffset(0, 10)
    local _ = UDim2.fromOffset(0, 10)

    for _, child_4 in v7.Icon:GetChildren() do
        if child_4:IsA("ViewportFrame") or child_4.Name == "Glow" then
            child_4:Destroy()
        end
    end

    local Click = v7.Purchase:FindFirstChild("Click")

    if Click then
        Click:Destroy()
    end

    local BlacksmithUI = PlayerGui:FindFirstChild("BlacksmithUI")
    local v111 = BlacksmithUI

    if v111 then
        v111 = BlacksmithUI:FindFirstChild("Grid", true)
    end

    local v112 = v111
    v111 = v112

    if v111 then
        v111 = v112:FindFirstChildWhichIsA("GuiButton")
    end

    if v111 then
        v8 = v111:Clone()
        local Holder = v8:FindFirstChild("Holder")

        for _, val_14 in Holder and Holder:GetChildren() or {} do
            val_14:Destroy()
        end

        local Stars_1 = v8:FindFirstChild("Stars")

        for _, val_15 in Stars_1 and Stars_1:GetChildren() or {} do
            if not val_15:IsA("UIListLayout") then
                val_15:Destroy()
            end
        end

        for _, val_16 in { "Lock", "Check", "SelectedOutline" } do
            local v115 = v8:FindFirstChild(val_16)

            if v115 and v115:IsA("GuiObject") then
                v115.Visible = false
            end
        end
    else
        v8 = Instance.new("TextButton")
        v8.Text = ""
        v8.AutoButtonColor = false
        v8.BackgroundColor3 = Color3.fromRGB(28, 26, 40)
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 6)
        UICorner.Parent = v8
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Color = Color3.fromRGB(120, 105, 150)
        UIStroke.Parent = v8
        local UIStroke_1 = Instance.new("UIStroke")
        local SelectedOutline_Frame = Instance.new("Frame")
        SelectedOutline_Frame.Name = "SelectedOutline"
        SelectedOutline_Frame.BackgroundTransparency = 1
        SelectedOutline_Frame.Size = UDim2.fromScale(1, 1)
        SelectedOutline_Frame.Visible = false
        UIStroke_1.Color = Color3.fromRGB(255, 170, 90)
        UIStroke_1.Thickness = 2
        UIStroke_1.Parent = SelectedOutline_Frame
        SelectedOutline_Frame.Parent = v8
    end

    v8.Size = UDim2.fromOffset(56, 56)

    function v111(s5: string, n2: number, n3: number, u3: UDim) --[[ scroller ]] -- line: 594
        -- upvalues:
        --  [1] v7 (ref)
        --  [2] Card1 (copy)

        local ScrollingFrame = Instance.new("ScrollingFrame")
        ScrollingFrame.Name = s5
        ScrollingFrame.BackgroundTransparency = 1
        ScrollingFrame.BorderSizePixel = 0
        ScrollingFrame.Position = UDim2.fromOffset(n2, n3)
        ScrollingFrame.Size = UDim2.new(u3.Scale, u3.Offset, 0, v7.Size.Y.Offset + 12)
        ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X
        ScrollingFrame.ScrollBarThickness = 4
        ScrollingFrame.CanvasSize = UDim2.new()
        ScrollingFrame.ZIndex = Card1.ZIndex

        return ScrollingFrame
    end

    v6 = v111("Weapons", 42, Card1.Position.Y.Offset, UDim.new(1, -84))
    v6.Parent = v109
    Frame_1 = Instance.new("Frame")
    Frame_1.Name = "Reforge"
    Frame_1.BackgroundTransparency = 1
    Frame_1.Size = UDim2.fromScale(1, 1)
    Frame_1.Visible = false
    Frame_1.Parent = v109
    local v119 = 42 + v7.Size.X.Offset + 20
    v14 = v7.ItemType:Clone()
    v14.Name = "Needs"
    v14.TextXAlignment = Enum.TextXAlignment.Left
    v14.TextYAlignment = Enum.TextYAlignment.Top
    v14.TextWrapped = true
    v14.TextScaled = false
    v14.TextSize = math.max(v14.TextSize, 15)
    v14.LineHeight = 1.1

    for _, child_5 in v14:GetChildren() do
        if child_5:IsA("UIGradient") then
            child_5:Destroy()
        end
    end

    v14.TextColor3 = color_2
    v14.Position = UDim2.fromOffset(v119, Card1.Position.Y.Offset + 8)
    v14.Size = UDim2.new(1, -v119 - 42, 0, 40)
    v14.Parent = Frame_1
    ScrollingFrame_1 = Instance.new("ScrollingFrame")
    ScrollingFrame_1.Name = "Copies"
    ScrollingFrame_1.BackgroundTransparency = 1
    ScrollingFrame_1.BorderSizePixel = 0
    ScrollingFrame_1.Position = UDim2.fromOffset(v119, Card1.Position.Y.Offset + 40)
    ScrollingFrame_1.Size = UDim2.new(1, -v119 - 42, 0, 192)
    ScrollingFrame_1.ScrollingDirection = Enum.ScrollingDirection.Y
    ScrollingFrame_1.ScrollBarThickness = 4
    ScrollingFrame_1.CanvasSize = UDim2.new()
    ScrollingFrame_1.ZIndex = Card1.ZIndex
    ScrollingFrame_1.Parent = Frame_1
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingLeft = UDim.new(0, 4)
    UIPadding.PaddingTop = UDim.new(0, 4)
    UIPadding.Parent = ScrollingFrame_1
    UIGridLayout = Instance.new("UIGridLayout")
    UIGridLayout.CellSize = UDim2.fromOffset(56, 56)
    UIGridLayout.CellPadding = UDim2.fromOffset(8, 8)
    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIGridLayout.Parent = ScrollingFrame_1
    local v128 = Card1.Position.Y.Offset + 40 + 192 + 6
    v18 = v7.Purchase:Clone()
    v18.Name = "Melt"
    v18.AnchorPoint = Vector2.new(1, 0)
    v18.Position = UDim2.new(1, -42, 0, v128 + (44 - v18.Size.Y.Offset) / 2)
    v18.Parent = Frame_1
    local v131 = v18
    local v132 = melt
    local TextButton_3 = Instance.new("TextButton")
    Instance.new("TextButton").Name = "Click"
    TextButton_3.Size = UDim2.fromScale(1, 1)
    TextButton_3.BackgroundTransparency = 1
    TextButton_3.Text = ""
    TextButton_3.ZIndex = v131.ZIndex + 10
    TextButton_3.Parent = v131
    TextButton_3.Activated:Connect(v132)
    v17 = v14:Clone()
    v17.Name = "Picked"
    v17.TextYAlignment = Enum.TextYAlignment.Center
    v17.TextSize = v14.TextSize - 1
    v17.Position = UDim2.fromOffset(v119, v128)
    v17.Size = UDim2.new(1, -v119 - 42 - v18.Size.X.Offset - 12, 0, 44)
    v17.Parent = Frame_1
    v9 = v7.ItemType:Clone()
    v9.Name = "Info"
    v9.TextWrapped = true
    v9.TextXAlignment = Enum.TextXAlignment.Center
    v9.Position = UDim2.fromOffset(42, 304)
    v9.Size = UDim2.new(1, -84, 0, 36)
    v9.TextSize = math.max(v9.TextSize, 15)
    v9.Parent = v109
    v128 = v102.Size.X.Offset - 50
    local Offset_1 = v7.Purchase.Size.Y.Offset

    for index_1 = #t_11, 1, -1 do
        v109 = t_11[index_1]
        local v138 = v7.Purchase:Clone()
        v138.Name = "Filter" .. v109
        v138.AnchorPoint = Vector2.new(1, 0)
        v138.Position = UDim2.fromOffset(v128, 61)
        v138.Size = UDim2.fromOffset(54, Offset_1)
        v138.Label.Text = v109
        v138.Parent = v102
        v128 -= 60
        t[v109] = v138
        local TextButton_4 = Instance.new("TextButton")
        TextButton_4.Name = "Click"
        TextButton_4.Size = UDim2.fromScale(1, 1)
        TextButton_4.BackgroundTransparency = 1
        TextButton_4.Text = ""
        TextButton_4.ZIndex = v138.ZIndex + 10
        TextButton_4.Parent = v138
        TextButton_4.Activated:Connect(function() -- line: 696
            -- upvalues:
            --  [1] v12 (ref)
            --  [2] v109 (copy)
            --  [3] v6 (ref)
            --  [4] f (ref)

            v12 = v109
            v6.CanvasPosition = Vector2.zero
            f()
        end)
    end

    local v139 = v7.Purchase:Clone()
    v139.Name = "Search"
    v139.AnchorPoint = Vector2.new(1, 0)
    v139.Position = UDim2.fromOffset(v128 - 2, 61)
    v139.Size = UDim2.fromOffset(150, Offset_1)
    v139.Parent = v102
    v128 = v139.Label
    TextBox = Instance.new("TextBox")
    TextBox.Name = "Query"
    TextBox.BackgroundTransparency = 1
    TextBox.ClearTextOnFocus = false
    TextBox.Text = ""
    TextBox.PlaceholderText = "Search..."
    TextBox.FontFace = v128.FontFace
    TextBox.TextSize = v128.TextSize
    TextBox.TextColor3 = v128.TextColor3
    TextBox.PlaceholderColor3 = v128.TextColor3:Lerp(Color3.new(0, 0, 0), 0.4)
    TextBox.TextXAlignment = Enum.TextXAlignment.Left
    TextBox.Position = UDim2.fromOffset(10, 0)
    TextBox.Size = UDim2.new(1, -20, 1, 0)
    TextBox.ZIndex = v128.ZIndex
    TextBox.Parent = v139
    v128:Destroy()
    TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- line: 725
        -- upvalues:
        --  [1] v6 (ref)
        --  [2] f (ref)

        v6.CanvasPosition = Vector2.zero
        f()
    end)
    v103 = v7.Purchase:Clone()
    v103.Name = "Back"
    v103.AnchorPoint = Vector2.new(1, 0)
    v103.Position = UDim2.fromOffset(v102.Size.X.Offset - 50, 61)
    v103.Size = UDim2.fromOffset(108, Offset_1)
    v103.Label.Text = "Back"
    v103.Label.TextTransparency = 0
    v103.Parent = v102
    local v146 = v103
    local v147 = showList
    local TextButton_5 = Instance.new("TextButton")
    TextButton_5.Name = "Click"
    TextButton_5.Size = UDim2.fromScale(1, 1)
    TextButton_5.BackgroundTransparency = 1
    TextButton_5.Text = ""
    TextButton_5.ZIndex = v146.ZIndex + 10
    TextButton_5.Parent = v146
    TextButton_5.Activated:Connect(v147)
    Frame_1:GetPropertyChangedSignal("Visible"):Connect(function() -- line: 739
        -- upvalues:
        --  [1] v103 (ref)
        --  [2] Frame_1 (ref)

        v103.Visible = Frame_1.Visible
    end)
    v103.Visible = false
    v102.Close.Activated:Connect(function() -- line: 744
        -- upvalues:
        --  [1] v5 (ref)
        --  [2] v10 (ref)

        v5.Enabled = false
        v10 = nil
    end)
    v102.Parent = v5
    v5.Parent = PlayerGui
end

local _ = function(u4: userdata?) --[[ open ]] -- line: 752
    -- upvalues:
    --  [1] v5 (ref)
    --  [2] build (copy)
    --  [3] v10 (ref)
    --  [4] v21 (ref)
    --  [5] f (ref)

    if not v5 then
        local Success, Result = pcall(build)

        if not Success then
            warn("[HalloweenForge] couldn't build the window:", Result)

            if v5 then
                v5:Destroy()
            end

            v5 = nil

            return
        end
    end

    v10 = u4
    v21 = nil
    f()
    v5.Enabled = true
end

local v148 = false
local BindableEvent = Instance.new("BindableEvent")
BindableEvent.Event:Connect(function(arguments: userdata?) -- line: 776
    -- upvalues:
    --  [1] v5 (ref)
    --  [2] build (copy)
    --  [3] v10 (ref)
    --  [4] v21 (ref)
    --  [5] f (ref)
    --  [6] v148 (ref)

    if not v5 then
        local Success_1, Result_1 = pcall(build)

        if not Success_1 then
            warn("[HalloweenForge] couldn't build the window:", Result_1)

            if v5 then
                v5:Destroy()
            end

            v5 = nil
        else
            v10 = arguments
            v21 = nil
            f()
            v5.Enabled = true
        end
    else
        v10 = arguments
        v21 = nil
        f()
        v5.Enabled = true
    end

    v148 = false
end)

function _G.OpenHalloweenForge(u6: userdata?) -- line: 781
    -- upvalues:
    --  [1] v148 (ref)
    --  [2] BindableEvent (copy)
    --  [3] v5 (ref)

    v148 = true
    BindableEvent:Fire(u6)

    return function() -- line: 784
        -- upvalues:
        --  [1] v148 (ref)
        --  [2] v5 (ref)

        return v148 or (if v5 == nil then false else v5.Enabled)
    end
end

local function whileOpen() -- line: 790
    -- upvalues:
    --  [1] v5 (ref)
    --  [2] f (ref)

    if v5 and v5.Enabled then
        f()
    end
end

local function watchInventory(u7: userdata) -- line: 796
    -- upvalues:
    --  [1] HalloweenWeapons_m (copy)
    --  [2] whileOpen (copy)
    --  [3] v5 (ref)
    --  [4] f (ref)

    local _ = function(arg21) --[[ watch ]] -- line: 797
        -- upvalues:
        --  [1] HalloweenWeapons_m (ref)
        --  [2] whileOpen (ref)

        arg21:GetAttributeChangedSignal(HalloweenWeapons_m.ATTRIBUTE):Connect(whileOpen)
        arg21:GetAttributeChangedSignal("Locked"):Connect(whileOpen)
    end

    for _, child_6 in u7:GetChildren() do
        child_6:GetAttributeChangedSignal(HalloweenWeapons_m.ATTRIBUTE):Connect(whileOpen)
        child_6:GetAttributeChangedSignal("Locked"):Connect(whileOpen)
    end

    u7.ChildAdded:Connect(function(child_7) -- line: 804
        -- upvalues:
        --  [1] HalloweenWeapons_m (ref)
        --  [2] whileOpen (ref)
        --  [3] v5 (ref)
        --  [4] f (ref)

        child_7:GetAttributeChangedSignal(HalloweenWeapons_m.ATTRIBUTE):Connect(whileOpen)
        child_7:GetAttributeChangedSignal("Locked"):Connect(whileOpen)

        if v5 and v5.Enabled then
            f()
        end
    end)
    u7.ChildRemoved:Connect(whileOpen)
end

task.spawn(function() -- line: 811
    -- upvalues:
    --  [1] watchInventory (copy)
    --  [2] LocalPlayer (copy)

    watchInventory(LocalPlayer:WaitForChild("Inventory"))
end)
task.spawn(function() -- line: 815
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] StatManager_m (copy)
    --  [3] LocalPlayer (copy)
    --  [4] whileOpen (copy)
    --  [5] HalloweenBlacksmith (ref)
    --  [6] ReplicatedStorage (copy)

    v4 = StatManager_m.require(LocalPlayer)

    if v4 then
        for _, val_17 in {
            "CandyCorn",
            "LightMastery",
            "MediumMastery",
            "HeavyMastery",
            "FightingStyle"
        } do
            v4:OnStatChanged(val_17, whileOpen)
        end
    end

    HalloweenBlacksmith = ReplicatedStorage.Remotes:WaitForChild("HalloweenBlacksmith")
end)
task.spawn(function() -- line: 826
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] v5 (ref)
    --  [3] v10 (ref)

    while true do
        task.wait(0.5)
        local v151 = LocalPlayer.Character

        if v151 then
            v151 = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        end

        if not v5 then
            continue
        end

        if not v5.Enabled then
            continue
        end

        if not v10 then
            continue
        end

        if not v151 or (v151.Position - v10.Position).Magnitude > 22 then
            v5.Enabled = false
            v10 = nil
        end
    end
end)
