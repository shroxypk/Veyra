-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.GameplayHandle
-- Class: LocalScript
-- bytes: 7866

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("Lighting")
local _ = game:GetService("MarketplaceService")
local _ = game:GetService("TweenService")
local _ = game:GetService("CollectionService")
local Modules = ReplicatedStorage.Modules
local StatManager_m = require(Modules.StatManager)
local Basic_m = require(Modules.Basic)
local v2, v3 = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StatManager_m.require(v2)
local Humanoid = v3.Humanoid
local _ = Humanoid:FindFirstChildWhichIsA("Animator")
local _ = v3:WaitForChild("HumanoidRootPart")
local States = v3:WaitForChild("States")
local Resolve = States.Resolve
local MaxResolve = States.MaxResolve
local Energy = States.Energy
local MaxEnergy = States.MaxEnergy
_G.Use = true
v2:GetMouse().TargetFilter = workspace.Effects
local Gameplay = v2:WaitForChild("PlayerGui"):WaitForChild("Gameplay")
local Menu = Gameplay.Main.Menu
local Bars = Gameplay.Player.Bars

for key, _ in _G.PROMPTS do
    key.Enabled = not key:GetAttribute("ServerDisabled")
    _G.PROMPTS[key] = nil
end

function UpdateUI() -- line: 49
    -- upvalues:
    --  [1] Bars (copy)
    --  [2] Resolve (copy)
    --  [3] MaxResolve (copy)
    --  [4] MaxEnergy (copy)
    --  [5] Energy (copy)
    --  [6] Humanoid (copy)

    Bars.ResolveFrame.Front:TweenSize(
        UDim2.fromScale(Resolve.Value / MaxResolve.Value, 1),
        "Out",
        "Quad",
        0.5,
        true
    )
    local v5 = MaxEnergy.Value > 0 and Energy.Value / MaxEnergy.Value or 0
    Bars.EnergyFrame.Front:TweenSize(
        UDim2.fromScale(v5, 1),
        "Out",
        "Quad",
        0.5,
        true
    )
    Bars.EnergyFrame.Loss:TweenSize(
        UDim2.fromScale(v5, 1),
        "Out",
        "Quad",
        2,
        true
    )
    Bars.EnergyFrame.Val.Text = math.floor(v5 * 100) .. "%"
    Bars.HealthFrame.Val.Text = math.floor(Humanoid.Health / Humanoid.MaxHealth * 100) .. "%"
    Bars.HealthFrame.Front:TweenSize(
        UDim2.fromScale(Humanoid.Health / Humanoid.MaxHealth, 1),
        "Out",
        "Quad",
        0.5,
        true
    )
    Bars.HealthFrame.Loss:TweenSize(
        UDim2.fromScale(Humanoid.Health / Humanoid.MaxHealth, 1),
        "Out",
        "Quad",
        2,
        true
    )
end

UpdateUI()
Humanoid.HealthChanged:Connect(UpdateUI)
v4:OnStatChanged("TimePlayed", UpdateUI)
v4:OnStatChanged("NPCKills", UpdateUI)
v4:OnStatChanged("PlayerKills", UpdateUI)
v4:OnStatChanged("Magic", UpdateUI)
Resolve:GetPropertyChangedSignal("Value"):Connect(UpdateUI)
Energy:GetPropertyChangedSignal("Value"):Connect(UpdateUI)
MaxEnergy:GetPropertyChangedSignal("Value"):Connect(UpdateUI)
local ShowHPPercent = v2:WaitForChild("Settings"):FindFirstChild("ShowHPPercent")
local v7 = false
local v8 = false

local function updateBarText() -- line: 81
    -- upvalues:
    --  [1] ShowHPPercent (copy)
    --  [2] Bars (copy)
    --  [3] v7 (ref)
    --  [4] v8 (ref)

    local v9 = if ShowHPPercent == nil then false else ShowHPPercent.Value
    Bars.HealthFrame.Val.Visible = v7 or v9
    Bars.EnergyFrame.Val.Visible = v8 or v9
end

Bars.HealthFrame.MouseEnter:Connect(function() -- line: 87
    -- upvalues:
    --  [1] v7 (ref)
    --  [2] ShowHPPercent (copy)
    --  [3] Bars (copy)
    --  [4] v8 (ref)

    v7 = true
    local v10 = if ShowHPPercent == nil then false else ShowHPPercent.Value
    Bars.HealthFrame.Val.Visible = v7 or v10
    Bars.EnergyFrame.Val.Visible = v8 or v10
end)
Bars.HealthFrame.MouseLeave:Connect(function() -- line: 91
    -- upvalues:
    --  [1] v7 (ref)
    --  [2] ShowHPPercent (copy)
    --  [3] Bars (copy)
    --  [4] v8 (ref)

    v7 = false
    local v11 = if ShowHPPercent == nil then false else ShowHPPercent.Value
    Bars.HealthFrame.Val.Visible = v7 or v11
    Bars.EnergyFrame.Val.Visible = v8 or v11
end)
Bars.EnergyFrame.MouseEnter:Connect(function() -- line: 95
    -- upvalues:
    --  [1] v8 (ref)
    --  [2] ShowHPPercent (copy)
    --  [3] Bars (copy)
    --  [4] v7 (ref)

    v8 = true
    local v12 = if ShowHPPercent == nil then false else ShowHPPercent.Value
    Bars.HealthFrame.Val.Visible = v7 or v12
    Bars.EnergyFrame.Val.Visible = v8 or v12
end)
Bars.EnergyFrame.MouseLeave:Connect(function() -- line: 99
    -- upvalues:
    --  [1] v8 (ref)
    --  [2] ShowHPPercent (copy)
    --  [3] Bars (copy)
    --  [4] v7 (ref)

    v8 = false
    local v13 = if ShowHPPercent == nil then false else ShowHPPercent.Value
    Bars.HealthFrame.Val.Visible = v7 or v13
    Bars.EnergyFrame.Val.Visible = v8 or v13
end)

if ShowHPPercent then
    ShowHPPercent:GetPropertyChangedSignal("Value"):Connect(updateBarText)
end

v4 = if ShowHPPercent == nil then false else ShowHPPercent.Value
Bars.HealthFrame.Val.Visible = v7 or v4
Bars.EnergyFrame.Val.Visible = v8 or v4
local t = {}
local v14 = Menu.Pages
local Buttons = v14.Buttons
local v15

for _, child in Buttons:GetChildren() do
    v15 = v14:FindFirstChild(child.Name)

    if child:IsA("GuiButton") and v15 then
        table.insert(t, v15)
    end
end

for _, val_1 in t do
    v14 = Buttons[val_1.Name]
    v15 = v14.Background
    local BackgroundColor3 = v15.BackgroundColor3

    local function attribConnect() -- line: 130
        -- upvalues:
        --  [1] v14 (copy)
        --  [2] v15 (copy)
        --  [3] BackgroundColor3 (copy)
        --  [4] t (copy)
        --  [5] val_1 (copy)

        local Selected = v14:GetAttribute("Selected")
        local v17 = v15
        v17.BackgroundColor3 = Selected and BackgroundColor3 or BackgroundColor3:Lerp(
            Color3.new(),
            0.6
        )

        for _, val_2 in v14:QueryDescendants("ImageLabel, TextLabel") do
            if not val_2:GetAttribute("Ignore") then
                if val_2:IsA("ImageLabel") then
                    val_2:SetAttribute(
                        "OriginalColor",
                        val_2:GetAttribute("OriginalColor") or val_2.ImageColor3
                    )
                    local OriginalColor = val_2:GetAttribute("OriginalColor")
                    val_2.ImageColor3 = Selected and OriginalColor or OriginalColor:Lerp(
                        Color3.new(),
                        0.6
                    )
                elseif val_2:IsA("TextLabel") then
                    local v22 = if not Selected then 0.6 else 0
                    val_2.TextTransparency = v22
                end
            end
        end

        if Selected then
            for _, val_3 in t do
                val_3.Visible = val_3 == val_1
            end
        end
    end

    v14.MouseButton1Up:Connect(function() -- line: 157
        -- upvalues:
        --  [1] v14 (copy)
        --  [2] Buttons (copy)

        if v14:GetAttribute("Selected") then
            return
        end

        for _, child_1 in Buttons:GetChildren() do
            if child_1:IsA("TextButton") then
                child_1:SetAttribute("Selected", false)
            end
        end

        v14:SetAttribute("Selected", true)
    end)
    v14:GetAttributeChangedSignal("Selected"):Connect(attribConnect)
    task.spawn(attribConnect)
end

local Heartbeat = script.Heartbeat
Humanoid.HealthChanged:Connect(function() -- line: 176
    -- upvalues:
    --  [1] Humanoid (copy)
    --  [2] Basic_m (copy)
    --  [3] v3 (copy)
    --  [4] Heartbeat (copy)

    if Humanoid.Health < Humanoid.MaxHealth * Basic_m.LowThreshold then
        if not v3:HasTag("Dead") then
            if not Heartbeat.IsPlaying then
                Heartbeat:Play()

                return
            end
        elseif Heartbeat.IsPlaying then
            Heartbeat:Stop()
        end

        return
    end

    if Heartbeat.IsPlaying then
        Heartbeat:Stop()
    end
end)
