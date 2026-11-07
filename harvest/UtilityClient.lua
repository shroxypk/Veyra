-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Utility.UtilityClient
-- Class: LocalScript
-- bytes: 12879

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local _ = require(Modules.ByteNetMax)
local Packets_m = require(Modules.Packets)
local CreateBindableAction_m = require(Modules.CreateBindableAction)
local GamepadLayer_m = require(Modules.GamepadLayer)
local StatManager_m = require(Modules.StatManager)
local Basic_m = require(Modules.Basic)
local Professions_m = require(Modules.Professions)
local v2, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local mouse = v2:GetMouse()
local v4 = StatManager_m.require(v2)
local Binds = v2:WaitForChild("Binds")
local _ = v2:WaitForChild("Inventory")
local Skills = v2:WaitForChild("Skills")
local PlayerGui = v2:WaitForChild("PlayerGui")
local _ = PlayerGui:WaitForChild("Gameplay")
local UtilitySpells = Binds:WaitForChild("Utility Spells")
local Parent = script.Parent
local Buttons = Parent.Buttons
local Pointer = Parent.Pointer
local v5 = false

local _ = function() --[[ getWheelRadius ]] -- line: 47
    -- upvalues:
    --  [1] Buttons (copy)

    local AbsoluteSize = Buttons.AbsoluteSize

    return math.min(AbsoluteSize.X, AbsoluteSize.Y) * 0.15
end

local t = {
    ["Mana Vision"] = {
        desc = "See hidden objects, magical auras, and secret passages. Detect invisible traps and entities concealed from the naked eye."
    },
    ["Luminous Wisp"] = {
        desc = "Summon a wisp of light energy that illuminates the area. Extremely effective in dark, cave-like regions."
    },
    ["Mission Bird"] = { desc = "Browse available mission orders and choose your next assignment." }
}
t["Inner Realm"] = {
    desc = "Enter the Inner Realm to deepen your magic, unlock new traits, and discover what lies within.",
    color = Color3.fromRGB(255, 196, 128)
}
t.Tracker = { desc = "Choose which ores and plants to track." }
t.Cancel = {
    desc = "Close the wheel without casting anything.",
    color = Color3.fromRGB(150, 40, 40),
    selectedColor = Color3.fromRGB(255, 90, 90)
}
local t_3 = { "Mining", "Harvesting" }
local t_4 = { "Inner Realm", "Mana Vision", "Luminous Wisp", "Mission Bird" }
local v6 = Services_m.Maid.new()

if not Basic_m.World then
    t_4[1] = nil
end

local t_5 = {}
local v7 = 0

local _ = function() --[[ getPointerCenter ]] -- line: 90
    -- upvalues:
    --  [1] Pointer (copy)

    return Pointer.AbsolutePosition + Pointer.AbsoluteSize / 2
end

local function layoutButtons() -- line: 94
    -- upvalues:
    --  [1] Buttons (copy)
    --  [2] Pointer (copy)
    --  [3] v7 (ref)
    --  [4] t_5 (copy)

    local AbsoluteSize_1 = Buttons.AbsoluteSize
    local v8 = math.min(AbsoluteSize_1.X, AbsoluteSize_1.Y) * 0.15
    local v9 = Pointer.AbsolutePosition + Pointer.AbsoluteSize / 2 - Buttons.AbsolutePosition
    local v10 = 360 / v7

    for key, val in t_5 do
        local v11 = Buttons:FindFirstChild(val)

        if v11 then
            local v12 = math.rad(90 + v10 * (key - 1))
            v11.AnchorPoint = Vector2.new(0.5, 0.5)
            v11.Position = UDim2.fromOffset(v9.X + v8 * math.cos(v12), v9.Y - v8 * math.sin(v12))
        end
    end
end

local function CREATE(arg1, arg2) -- line: 116
    -- upvalues:
    --  [1] Buttons (copy)

    local Color = arg2.color
    local v14 = script.Template:Clone()
    v14.Name = arg1
    v14.Label.Text = arg1

    if Color then
        v14.Label.BackgroundColor3 = Color
        v14.Outline.ImageColor3 = Color
        v14:SetAttribute("BackgroundColor", Color)
        v14:SetAttribute("OutlineColor", Color)
    end

    if arg2.selectedColor then
        v14:SetAttribute("SelectedColor", arg2.selectedColor)
    end

    v14.Parent = Buttons
end

local function utilityAction(_, arg4, _) -- line: 137
    -- upvalues:
    --  [1] Parent (copy)
    --  [2] layoutButtons (copy)
    --  [3] v6 (copy)
    --  [4] RunService (copy)
    --  [5] Pointer (copy)
    --  [6] mouse (copy)
    --  [7] v5 (ref)
    --  [8] GamepadLayer_m (copy)
    --  [9] v7 (ref)
    --  [10] t_5 (copy)
    --  [11] Packets_m (copy)
    --  [12] ReplicatedStorage (copy)
    --  [13] PlayerGui (copy)

    if arg4 == Enum.UserInputState.Begin then
        Parent.Visible = true
        script:SetAttribute("Selected", "")
        layoutButtons()
        v6:GiveTask(RunService.RenderStepped:Connect(function() -- line: 144
            -- upvalues:
            --  [1] Pointer (ref)
            --  [2] mouse (ref)
            --  [3] v5 (ref)
            --  [4] GamepadLayer_m (ref)
            --  [5] v7 (ref)
            --  [6] t_5 (ref)

            local v15 = Pointer.AbsolutePosition + Pointer.AbsoluteSize / 2
            local v16 = Vector2.new(mouse.X, mouse.Y) - v15

            if v5 then
                local v17 = GamepadLayer_m.getStick()

                if v17.Magnitude < 0.35 then
                    return
                end

                v16 = Vector2.new(v17.X, -v17.Y)
            end

            local v18 = math.atan2(v16.Y, v16.X)
            local v19 = math.deg(v18) % 360
            v16 = (270 - v19) % 360
            local v20 = 360 / v7
            local v21 = nil
            local v22 = math.huge

            for key_1, val_1 in t_5 do
                local v23 = math.abs((v16 - v20 * (key_1 - 1) + 180) % 360 - 180)

                if v22 > v23 then
                    v22 = v23
                    v21 = val_1
                end
            end

            if v21 and v22 <= 25 then
                script:SetAttribute("Selected", v21)
            else
                script:SetAttribute("Selected", "")
            end

            Pointer.Rotation = v19
        end))

        return
    end

    if arg4 == Enum.UserInputState.End then
        v6:Destroy()
        local Selected = script:GetAttribute("Selected")

        if Selected == "Mission Bird" then
            Packets_m.Systems.packets.Summon.send({ Action = "Summon" })
        elseif Selected == "Inner Realm" then
            ReplicatedStorage.Remotes.Gateway:FireServer("Trait")
        elseif Selected == "Tracker" then
            local ProfessionTrackerHUD = PlayerGui:FindFirstChild("ProfessionTrackerHUD")
            local v25 = ProfessionTrackerHUD

            if v25 then
                v25 = ProfessionTrackerHUD:FindFirstChild("OpenTracker")
            end

            if v25 then
                v25:Fire(true)
            end
        elseif Selected ~= "Cancel" and Selected and Selected ~= "" then
            ReplicatedStorage.Remotes.Utility:FireServer(Selected)
        end

        Parent.Visible = false
    end
end

local function check(arg6) -- line: 212
    -- upvalues:
    --  [1] Buttons (copy)

    if typeof(arg6) == "Instance" then
        arg6 = arg6.Name
    end

    local v26 = Buttons:FindFirstChild(arg6)

    if not v26 then
        return
    end

    v26.Lock.Visible = false
    v26.LockBackground.Visible = false
end

for _, val_2 in t_4 do
    local v27 = t[val_2]

    if v27 then
        CREATE(val_2, v27)
        table.insert(t_5, val_2)
    end
end

local _ = function() --[[ placeCancel ]] -- line: 237
    -- upvalues:
    --  [1] t_5 (copy)

    local v28 = table.find(t_5, "Cancel")

    if v28 then
        table.remove(t_5, v28)
    end

    table.insert(t_5, math.floor((#t_5 + 1) / 2) + 1, "Cancel")
end

CREATE("Cancel", t.Cancel)
local v30 = "Cancel"

if typeof(v30) == "Instance" then
    v30 = v30.Name
end

local v31 = Buttons:FindFirstChild(v30)

if v31 then
    v31.Lock.Visible = false
    v31.LockBackground.Visible = false
end

v30 = table.find(t_5, "Cancel")

if v30 then
    table.remove(t_5, v30)
end

table.insert(t_5, math.floor((#t_5 + 1) / 2) + 1, "Cancel")
v7 = #t_5

local function hasTracker() -- line: 252
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] Professions_m (copy)
    --  [3] v2 (copy)

    for _, val_3 in t_3 do
        if (Professions_m:GetPlayerBenefits(v2, val_3).tracker or 0) >= 1 then
            return true
        end
    end

    return false
end

local function updateTrackerOption() -- line: 262
    -- upvalues:
    --  [1] hasTracker (copy)
    --  [2] t_5 (copy)
    --  [3] CREATE (copy)
    --  [4] t (copy)
    --  [5] Buttons (copy)
    --  [6] v7 (ref)
    --  [7] layoutButtons (copy)

    local v32 = hasTracker()
    local v33 = table.find(t_5, "Tracker")

    if v32 and not v33 then
        CREATE("Tracker", t.Tracker)
        table.insert(t_5, "Tracker")
        local v34 = "Tracker"

        if typeof(v34) == "Instance" then
            v34 = v34.Name
        end

        local v35 = Buttons:FindFirstChild(v34)

        if v35 then
            v35.Lock.Visible = false
            v35.LockBackground.Visible = false
        end
    elseif not v32 and v33 then
        table.remove(t_5, v33)
        local Tracker = Buttons:FindFirstChild("Tracker")

        if Tracker then
            Tracker:Destroy()
        end
    else
        return
    end

    local v36 = table.find(t_5, "Cancel")

    if v36 then
        table.remove(t_5, v36)
    end

    table.insert(t_5, math.floor((#t_5 + 1) / 2) + 1, "Cancel")
    v7 = #t_5
    layoutButtons()
end

task.spawn(function() -- line: 285
    -- upvalues:
    --  [1] v2 (copy)
    --  [2] t_3 (copy)
    --  [3] updateTrackerOption (copy)

    local Professions = v2:WaitForChild("Professions")

    for _, val_4 in t_3 do
        task.spawn(function() -- line: 288
            -- upvalues:
            --  [1] Professions (copy)
            --  [2] val_4 (copy)
            --  [3] updateTrackerOption (ref)

            local v38 = Professions:WaitForChild(val_4, 60)

            if v38 then
                v38.Changed:Connect(updateTrackerOption)
                updateTrackerOption()
            end
        end)
    end
end)
layoutButtons()
Buttons:GetPropertyChangedSignal("AbsoluteSize"):Connect(layoutButtons)
script:GetAttributeChangedSignal("Selected"):Connect(function() -- line: 301
    -- upvalues:
    --  [1] Parent (copy)
    --  [2] t (copy)
    --  [3] Buttons (copy)
    --  [4] TweenService (copy)

    local Selected_2 = script:GetAttribute("Selected")
    Parent.Header.Text = Selected_2
    local Info = Parent.Header.Info
    Info.Text = t[Selected_2] and t[Selected_2].desc or ""

    for _, child in Buttons:GetChildren() do
        if child:IsA("GuiObject") then
            local v40 = child:GetAttribute("BackgroundColor") or Color3.fromRGB(0, 0, 0)
            local v41 = child:GetAttribute("OutlineColor") or Color3.fromRGB(255, 255, 255)
            local v42 = Selected_2 == child.Name
            local v43 = child:GetAttribute("SelectedColor") or Color3.fromRGB(190, 250, 255)
            local v44 = v42 and v43 or v40
            v40 = v42 and v43 or v41
            TweenService:Create(child.Label, TweenInfo.new(0.2), { BackgroundColor3 = v44 }):Play()
            TweenService:Create(child.Outline, TweenInfo.new(0.2), { ImageColor3 = v40 }):Play()
        end
    end
end)
CreateBindableAction_m("Utility Spells", UtilitySpells, utilityAction)
GamepadLayer_m.setHold(Enum.KeyCode.DPadRight, function() -- line: 334
    -- upvalues:
    --  [1] v5 (ref)
    --  [2] GamepadLayer_m (copy)
    --  [3] utilityAction (copy)

    v5 = true
    GamepadLayer_m.beginStickCapture()
    utilityAction("Utility Spells", Enum.UserInputState.Begin)
end, function() -- line: 338
    -- upvalues:
    --  [1] utilityAction (copy)
    --  [2] GamepadLayer_m (copy)
    --  [3] v5 (ref)

    utilityAction("Utility Spells", Enum.UserInputState.End)
    GamepadLayer_m.endStickCapture()
    v5 = false
end)

local function missionUnlocked() -- line: 344
    -- upvalues:
    --  [1] v4 (copy)
    --  [2] Buttons (copy)

    if v4:GetStat("MissionsUnlocked") then
        local v47 = "Mission Bird"

        if typeof(v47) == "Instance" then
            v47 = v47.Name
        end

        local v48 = Buttons:FindFirstChild(v47)

        if not v48 then
            return
        end

        v48.Lock.Visible = false
        v48.LockBackground.Visible = false
    end
end

v4:OnStatChanged("MissionsUnlocked", missionUnlocked)
local v49

if v4:GetStat("MissionsUnlocked") then
    v49 = "Mission Bird"

    if typeof(v49) == "Instance" then
        v49 = v49.Name
    end

    local v50 = Buttons:FindFirstChild(v49)

    if v50 then
        v50.Lock.Visible = false
        v50.LockBackground.Visible = false
    end
end

v49 = "Inner Realm"

if typeof(v49) == "Instance" then
    v49 = v49.Name
end

local v51 = Buttons:FindFirstChild(v49)

if v51 then
    v51.Lock.Visible = false
    v51.LockBackground.Visible = false
end

Skills.ChildAdded:Connect(check)

for _, child_1 in Skills:GetChildren() do
    task.spawn(check, child_1)
end
