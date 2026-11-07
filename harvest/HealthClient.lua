-- Decompiled with Veyra harvester
-- Instance: StarterGui.WorldHealth.Main.HealthClient
-- Class: LocalScript
-- bytes: 14235

local _ = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local Formatter_m = require(Modules.Formatter)
local v2, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local Parent = script.Parent
local HealthFrame = Parent.HealthFrame
local ResolveFrame = Parent.ResolveFrame
local Damage = Parent.Details.Damage
local Drops = Parent.Details.Drops
Parent.Interactable = false

for _, val in { Damage, Drops } do
    val.Active = false
    val.ScrollingEnabled = false
end

local ContributionLabel = script.ContributionLabel
local DropLabel = script.DropLabel
local color = Color3.fromRGB(200, 255, 164)
local v5 = 0
local v6 = nil
local _ = nil
local t = {}
local TextColor3 = ContributionLabel.TextColor3

local function AddInstance(arg1) -- line: 51
    -- upvalues:
    --  [1] t (copy)

    if t[arg1] ~= nil then
        return
    end

    t[arg1] = false
    local States = arg1:WaitForChild("States", 10)

    if t[arg1] == false and arg1:HasTag("ShowIndicator") then
        t[arg1] = States or nil
    end
end

local function RemoveInstance(arg2) -- line: 65
    -- upvalues:
    --  [1] t (copy)

    t[arg2] = nil
end

local _ = function(arg3) --[[ inRange ]] -- line: 69
    -- upvalues:
    --  [1] v2 (copy)

    local PrimaryPart = arg3.PrimaryPart

    if not PrimaryPart then
        return false, math.huge
    end

    local v8 = v2:DistanceFromCharacter(PrimaryPart.Position)

    return if v8 > 0 then v8 < 400 else false, v8
end

local function findNearestNPC() -- line: 79
    -- upvalues:
    --  [1] v6 (ref)
    --  [2] t (copy)
    --  [3] v2 (copy)

    local v10

    if v6 and t[v6] then
        local PrimaryPart_1 = v6.PrimaryPart

        if not PrimaryPart_1 then
            v10 = false
        else
            local _ = t[v6]
            local v12 = v2:DistanceFromCharacter(PrimaryPart_1.Position)
            v10 = if v12 > 0 then v12 < 400 and true else false
        end

        if v10 then
            return v6, t[v6]
        end
    else
        v10 = nil
        local v13 = nil
        local v14 = math.huge
        local v15, v16

        for key_1, val_1 in t do
            if val_1 then
                local PrimaryPart_2 = key_1.PrimaryPart

                if not PrimaryPart_2 then
                    v15 = false
                    v16 = math.huge
                else
                    local v17 = v2:DistanceFromCharacter(PrimaryPart_2.Position)
                    v15 = if v17 > 0 then v17 < 400 else false
                    v16 = v17
                end

                if v15 and v14 > v16 then
                    v10 = key_1
                    v13 = val_1
                    v14 = v16
                end
            end
        end

        return v10, v13
    end
end

local t_1 = {}
local t_2 = {}
local t_3 = {}
local v18 = false

local function markDirty() -- line: 105
    -- upvalues:
    --  [1] v18 (ref)

    v18 = true
end

local function watchConfig(arg4) -- line: 109
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] markDirty (copy)
    --  [3] v18 (ref)

    if not arg4:IsA("Configuration") or t_2[arg4] then
        return
    end

    t_2[arg4] = arg4:GetAttributeChangedSignal("DMGTotal"):Connect(markDirty)
    v18 = true
end

local function unwatchConfig(arg5) -- line: 118
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] v18 (ref)

    local v20 = t_2[arg5]

    if v20 then
        v20:Disconnect()
        t_2[arg5] = nil
    end

    v18 = true
end

local function clearContribution() -- line: 128
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] t_2 (copy)
    --  [3] t_1 (copy)
    --  [4] v18 (ref)

    for _, val_2 in t_3 do
        val_2:Disconnect()
    end

    table.clear(t_3)

    for _, val_3 in t_2 do
        val_3:Disconnect()
    end

    table.clear(t_2)

    for _, val_4 in t_1 do
        val_4:Destroy()
    end

    table.clear(t_1)
    v18 = false
end

local function bindContribution(arg6) -- line: 147
    -- upvalues:
    --  [1] clearContribution (copy)
    --  [2] t_2 (copy)
    --  [3] markDirty (copy)
    --  [4] v18 (ref)
    --  [5] t_3 (copy)
    --  [6] watchConfig (copy)
    --  [7] unwatchConfig (copy)

    clearContribution()

    for _, child in arg6:GetChildren() do
        if child:IsA("Configuration") and not t_2[child] then
            t_2[child] = child:GetAttributeChangedSignal("DMGTotal"):Connect(markDirty)
            v18 = true
        end
    end

    table.insert(t_3, arg6.ChildAdded:Connect(watchConfig))
    table.insert(t_3, arg6.ChildRemoved:Connect(unwatchConfig))
    v18 = true
end

local _ = function(arg7) --[[ getAttackerPlayer ]] -- line: 160
    -- upvalues:
    --  [1] Players (copy)

    local v24 = Players:FindFirstChild(arg7.Name)

    if v24 and v24:IsA("Player") then
        return v24
    end

    return nil
end

local function renderContribution(arg8, _) -- line: 165
    -- upvalues:
    --  [1] v18 (ref)
    --  [2] Players (copy)
    --  [3] t_1 (copy)
    --  [4] ContributionLabel (copy)
    --  [5] Damage (copy)
    --  [6] Formatter_m (copy)
    --  [7] v2 (copy)
    --  [8] color (copy)
    --  [9] TextColor3 (copy)

    v18 = false
    local t_4 = {}
    local v25 = 0
    local v27

    for _, child_1 in arg8:GetChildren() do
        if child_1:IsA("Configuration") then
            local DMGTotal = child_1:GetAttribute("DMGTotal")

            if typeof(DMGTotal) == "number" and not (DMGTotal <= 0) then
                local v26 = Players:FindFirstChild(child_1.Name)
                v27 = if v26 then if v26:IsA("Player") then v26 else nil else nil

                if v27 then
                    v25 += DMGTotal
                    table.insert(t_4, { config = child_1, damage = DMGTotal, player = v27 })
                end
            end
        end
    end

    table.sort(t_4, function(arg10, arg11) -- line: 195
        return if arg10.damage == arg11.damage then arg10.config.Name < arg11.config.Name else arg10.damage > arg11.damage
    end)
    local v28 = v25
    v25 = {}

    for key_7, val_5 in t_4 do
        v27 = val_5.config
        v25[v27] = true
        local v29 = t_1[v27]

        if not v29 then
            v29 = ContributionLabel:Clone()
            v29.Visible = true
            v29.Parent = Damage
            t_1[v27] = v29
        end

        local v30 = if not val_5.player then v27.Name else val_5.player.DisplayName
        v27 = if v28 > 0 then math.clamp(val_5.damage / v28 * 100, 0, 100) else 0
        local v31 = Formatter_m.addCommas((math.floor(val_5.damage)))
        local v32 = math.floor(v27 + 0.5)
        v29.Text = `{key_7}. {v30}  <font color='#863d3d'>{v31} ({v32}%)</font>`
        v29.LayoutOrder = key_7
        v29.TextColor3 = if val_5.player == v2 then color else TextColor3
    end

    for key_8, val_6 in t_1 do
        if not v25[key_8] then
            val_6:Destroy()
            t_1[key_8] = nil
        end
    end
end

local t_6 = {}
local t_7 = {}

local _ = function() --[[ clearDropRows ]] -- line: 237
    -- upvalues:
    --  [1] t_6 (copy)

    for _, val_7 in t_6 do
        val_7:Destroy()
    end

    table.clear(t_6)
end

local _ = function() --[[ clearDrops ]] -- line: 244
    -- upvalues:
    --  [1] t_7 (copy)
    --  [2] t_6 (copy)
    --  [3] Drops (copy)

    for _, val_8 in t_7 do
        val_8:Disconnect()
    end

    table.clear(t_7)

    for _, val_9 in t_6 do
        val_9:Destroy()
    end

    table.clear(t_6)
    Drops.Visible = false
end

local _ = function(arg12) --[[ getChance ]] -- line: 254
    local Chance = arg12:GetAttribute("Chance")

    if typeof(Chance) == "number" then
        return Chance
    end

    if not arg12:IsA("NumberValue") then
        if arg12:IsA("IntValue") then
            return arg12.Value
        end

        return nil
    else
        return arg12.Value
    end
end

local _ = function(arg13) --[[ formatChance ]] -- line: 267
    return (tostring(math.floor(arg13 * 100 + 0.5) / 100))
end

local function renderDrops(arg14) -- line: 271
    -- upvalues:
    --  [1] t_6 (copy)
    --  [2] Formatter_m (copy)
    --  [3] DropLabel (copy)
    --  [4] Drops (copy)

    for _, val_10 in t_6 do
        val_10:Destroy()
    end

    table.clear(t_6)
    local children = arg14:GetChildren()
    table.sort(children, function(arg15, arg16) -- line: 276
        local v34 = arg15:GetAttribute("Chance")
        local v35

        if typeof(v34) == "number" then
            v35 = v34
        elseif not arg15:IsA("NumberValue") then
            v35 = if arg15:IsA("IntValue") then arg15.Value else nil
        else
            v35 = arg15.Value
            v35 = nil
        end

        local v36 = v35 or -1
        local Chance_1 = arg16:GetAttribute("Chance")

        if typeof(Chance_1) == "number" then
            v34 = Chance_1
        elseif not arg16:IsA("NumberValue") then
            v34 = if arg16:IsA("IntValue") then arg16.Value else nil
        else
            v34 = arg16.Value
            v34 = nil
        end

        v35 = v34 or -1

        return if v36 == v35 then arg15.Name < arg16.Name else v36 > v35
    end)
    local v38, v40

    for key_13, val_11 in children do
        local v37 = Formatter_m.formatItem(val_11.Name)
        local Chance_2 = val_11:GetAttribute("Chance")

        if typeof(Chance_2) == "number" then
            v38 = Chance_2
        elseif not val_11:IsA("NumberValue") then
            v38 = if val_11:IsA("IntValue") then val_11.Value else nil
        else
            v38 = val_11.Value
            v38 = nil
        end

        local v39 = DropLabel:Clone()

        if v38 then
            local str = tostring(math.floor(v38 * 100 + 0.5) / 100)
            v40 = `{v37} ({str}%)`
        else
            v40 = v37
        end

        v39.Text = v40
        v39.LayoutOrder = key_13
        v39.Visible = true
        v39.Parent = Drops
        table.insert(t_6, v39)
    end

    Drops.Visible = #children > 0
end

local function bindDrops(arg17) -- line: 302
    -- upvalues:
    --  [1] t_7 (copy)
    --  [2] t_6 (copy)
    --  [3] Drops (copy)
    --  [4] bindDrops (copy)
    --  [5] renderDrops (copy)

    for _, val_12 in t_7 do
        val_12:Disconnect()
    end

    table.clear(t_7)

    for _, val_13 in t_6 do
        val_13:Destroy()
    end

    table.clear(t_6)
    Drops.Visible = false
    local UniqueDrops = arg17:FindFirstChild("UniqueDrops")

    if not UniqueDrops then
        table.insert(t_7, arg17.ChildAdded:Connect(function(child_2) -- line: 308
            -- upvalues:
            --  [1] bindDrops (ref)
            --  [2] arg17 (copy)

            if child_2.Name == "UniqueDrops" then
                bindDrops(arg17)
            end
        end))

        return
    end

    local function refresh() -- line: 316
        -- upvalues:
        --  [1] renderDrops (ref)
        --  [2] UniqueDrops (copy)

        renderDrops(UniqueDrops)
    end

    table.insert(t_7, UniqueDrops.ChildAdded:Connect(refresh))
    table.insert(t_7, UniqueDrops.ChildRemoved:Connect(refresh))
    renderDrops(UniqueDrops)
end

local _ = function(arg19, arg20) --[[ ratio ]] -- line: 326
    if arg20 <= 0 then
        return 0
    end

    return (math.clamp(arg19 / arg20, 0, 1))
end

RunService.Heartbeat:Connect(function(deltaTime) -- line: 333
    -- upvalues:
    --  [1] v5 (ref)
    --  [2] findNearestNPC (copy)
    --  [3] v6 (ref)
    --  [4] HealthFrame (copy)
    --  [5] _ (ref)
    --  [6] bindContribution (copy)
    --  [7] bindDrops (copy)
    --  [8] v18 (ref)
    --  [9] renderContribution (copy)
    --  [10] ResolveFrame (copy)
    --  [11] Parent (copy)
    --  [12] clearContribution (copy)
    --  [13] t_7 (copy)
    --  [14] t_6 (copy)
    --  [15] Drops (copy)

    v5 += deltaTime

    if v5 < 0.1 then
        return
    end

    v5 = 0
    local v45, v46 = findNearestNPC()
    local v47 = v45

    if v47 then
        v47 = v45:FindFirstChildOfClass("Humanoid")
    end

    if v45 and (v47 and v46) then
        if v45 ~= v6 then
            HealthFrame.Title.Text = v47.DisplayName
            v6 = v45
            _ = v46
            bindContribution(v45)
            bindDrops(v45)
        end

        if v18 then
            renderContribution(v45, v47)
        end

        local Health = v47.Health
        local MaxHealth = v47.MaxHealth
        local v48

        if MaxHealth <= 0 then
            v48 = 0
        else
            local _ = renderContribution
            v48 = math.clamp(Health / MaxHealth, 0, 1)
        end

        HealthFrame.Bar.Front:TweenSize(
            UDim2.new(v48, 0, 1, 0),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.4,
            true
        )
        HealthFrame.Bar.Loss:TweenSize(
            UDim2.new(v48, 0, 1, 0),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            1,
            true
        )
        local Front_1 = ResolveFrame.Bar.Front
        local Value = v46.MaxResolve.Value
        Front_1:TweenSize(
            UDim2.new(
                if Value <= 0 then 0 else math.clamp(v46.Resolve.Value / Value, 0, 1),
                0,
                1,
                0
            ),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.4,
            true
        )
        Parent.Visible = true

        return
    end

    if v6 then
        clearContribution()

        for _, val_14 in t_7 do
            val_14:Disconnect()
        end

        table.clear(t_7)

        for _, val_15 in t_6 do
            val_15:Destroy()
        end

        table.clear(t_6)
        Drops.Visible = false
    end

    v6 = nil
    _ = nil
    Parent.Visible = false
end)
CollectionService:GetInstanceAddedSignal("ShowIndicator"):Connect(AddInstance)
CollectionService:GetInstanceRemovedSignal("ShowIndicator"):Connect(RemoveInstance)

for _, val_16 in CollectionService:GetTagged("ShowIndicator") do
    task.spawn(AddInstance, val_16)
end
