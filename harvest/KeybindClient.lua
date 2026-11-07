-- Decompiled with Veyra harvester
-- Instance: StarterGui.Permanent.Window.Settings.Pages.Controls.KeybindClient
-- Class: LocalScript
-- bytes: 22685

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local v2, _ = require(ReplicatedStorage.Modules.scriptObjs).GetPlayerCharacter()
local Binds = v2:WaitForChild("Binds")
local GamepadLayer_m = require(ReplicatedStorage.Modules.GamepadLayer)
local PadBinds_m = require(ReplicatedStorage.Modules.PadBinds)
local Keybinds = script.Parent.Keybinds
local t = { Enum.UserInputType.Keyboard, Enum.UserInputType.MouseButton3 }
local t_1 = {
    One = 1,
    Two = 2,
    Three = 3,
    Four = 4,
    Five = 5,
    Six = 6,
    Seven = 7,
    Eight = 8,
    Nine = 9,
    Zero = 0,
    LeftControl = "LCtrl",
    RightControl = "RCtrl"
}
local t_2 = {
    Combat = { "Block", "Critical", "Roll", "Grip" },
    UI = { "Emotes", "Cinematic Mode", "Menu", "Quest Journal", "Map" },
    Misc = { "Interact", "Utility Spells", "Broom", "Summon Spirit", "Crouch", "Show Grimoire" },
    Hotbar = {}
}
table.insert(t_2.Hotbar, "Tool Slot " .. 0)
table.insert(t_2.Hotbar, "Tool Slot " .. 1)
table.insert(t_2.Hotbar, "Tool Slot " .. 2)
table.insert(t_2.Hotbar, "Tool Slot " .. 3)
table.insert(t_2.Hotbar, "Tool Slot " .. 4)
table.insert(t_2.Hotbar, "Tool Slot " .. 5)
table.insert(t_2.Hotbar, "Tool Slot " .. 6)
table.insert(t_2.Hotbar, "Tool Slot " .. 7)
table.insert(t_2.Hotbar, "Tool Slot " .. 8)
table.insert(t_2.Hotbar, "Tool Slot " .. 9)
local color = Color3.fromRGB(0, 0, 0)
local color_1 = Color3.fromRGB(255, 111, 111)
local color_2 = Color3.fromRGB(255, 248, 193)
local color_3 = Color3.fromRGB(40, 40, 40)
local t_3 = {
    Enum.KeyCode.ButtonA,
    Enum.KeyCode.ButtonB,
    Enum.KeyCode.ButtonX,
    Enum.KeyCode.ButtonY,
    Enum.KeyCode.ButtonL1,
    Enum.KeyCode.ButtonR1,
    Enum.KeyCode.ButtonL2,
    Enum.KeyCode.ButtonR2,
    Enum.KeyCode.ButtonL3,
    Enum.KeyCode.ButtonR3,
    Enum.KeyCode.DPadUp,
    Enum.KeyCode.DPadDown,
    Enum.KeyCode.DPadLeft,
    Enum.KeyCode.DPadRight,
    Enum.KeyCode.ButtonSelect,
    Enum.KeyCode.ButtonStart
}
local v4 = nil

local function anyPadButtonDown() -- line: 85
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] UserInputService (copy)

    for _, val in t_3 do
        if UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, val) then
            return true
        end
    end

    return false
end

local _ = function() --[[ usingPad ]] -- line: 94
    -- upvalues:
    --  [1] GamepadLayer_m (copy)

    return GamepadLayer_m.isGamepadActive()
end

local t_4 = {}

local function clearChildren(arg1) -- line: 100
    for _, child in arg1:GetChildren() do
        if not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end
end

local function addText(arg2, arg3, arg4) -- line: 108
    local v5 = arg2.Display.Key.Label:Clone()
    v5.Name = "Text" .. arg4
    v5.Visible = true
    v5.Text = arg3
    v5.LayoutOrder = arg4
    v5.Position = UDim2.new()
    v5.AnchorPoint = Vector2.zero
    v5.Size = UDim2.fromScale(0, 0.75)
    v5.AutomaticSize = Enum.AutomaticSize.X
    v5.ZIndex = 8
    v5.Parent = arg2.PadIcons
end

local function addGlyph(arg5, arg6, arg7) -- line: 122
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "Glyph" .. arg7
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.ScaleType = Enum.ScaleType.Fit
    ImageLabel.Size = UDim2.fromScale(1, 0.9)
    ImageLabel.Image = arg6
    ImageLabel.LayoutOrder = arg7
    ImageLabel.ZIndex = 8
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint.AspectRatio = 1
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
    UIAspectRatioConstraint.Parent = ImageLabel
    ImageLabel.Parent = arg5.PadIcons
end

local function refreshRow(arg8) -- line: 141
    -- upvalues:
    --  [1] GamepadLayer_m (copy)
    --  [2] v4 (ref)
    --  [3] t_1 (copy)
    --  [4] color_1 (copy)
    --  [5] color (copy)
    --  [6] clearChildren (copy)
    --  [7] PadBinds_m (copy)
    --  [8] addText (copy)
    --  [9] addGlyph (copy)
    --  [10] color_3 (copy)

    local Display = arg8.Display
    local v6 = GamepadLayer_m.isGamepadActive()
    arg8.PadIcons.Visible = v6
    arg8.PadButton.Visible = v6
    arg8.KeyButton.Visible = not v6
    arg8.Template.Title.TextColor3 = Color3.fromRGB(255, 255, 255)

    if v4 and v4.row == arg8 then
        return
    end

    if not v6 then
        local v7 = arg8.Bind.Value

        if v7:match("Mouse") then
            v7 = v7:gsub("^MouseButton(%d+)$", "MB%1")
        end

        Display.Key.Label.Text = t_1[v7] or v7
        local v8 = Display.Key.Label
        v8.Visible = v7 ~= ""
        v8 = if v7 ~= "" then color else color_1 or color
        Display.BackgroundColor3 = v8

        return
    end

    Display.Key.Label.Visible = false
    clearChildren(arg8.PadIcons)
    local v10 = PadBinds_m.FIXED[arg8.Name]

    if v10 then
        addText(arg8, v10[2], 1)
        addGlyph(arg8, PadBinds_m.getIcon(v10[1]), 2)
        Display.BackgroundColor3 = color_3

        return
    end

    local v12 = PadBinds_m.getKeys(PadBinds_m.getValue(arg8.Name))

    for key_2, val_1 in v12 do
        if key_2 > 1 then
            addText(arg8, "+", key_2 * 2 - 1)
        end

        addGlyph(arg8, PadBinds_m.getIcon(val_1), key_2 * 2)
    end

    Display.BackgroundColor3 = if #v12 ~= 0 then color else color_1 or color
end

local function refreshAll() -- line: 188
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] refreshRow (copy)

    for _, val_2 in t_4 do
        refreshRow(val_2)
    end
end

local _ = function(arg9) --[[ stopRecording ]] -- line: 194
    -- upvalues:
    --  [1] ContextActionService (copy)
    --  [2] v4 (ref)
    --  [3] refreshRow (copy)
    --  [4] GuiService (copy)

    ContextActionService:UnbindAction("PadBindRecord")
    v4 = nil
    refreshRow(arg9)

    if arg9.PadButton.Visible then
        GuiService.SelectedObject = arg9.PadButton
    end
end

local function recordPad(arg10) -- line: 203
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] PadBinds_m (copy)
    --  [3] clearChildren (copy)
    --  [4] addText (copy)
    --  [5] color_2 (copy)
    --  [6] GuiService (copy)
    --  [7] anyPadButtonDown (copy)
    --  [8] addGlyph (copy)
    --  [9] ContextActionService (copy)
    --  [10] refreshRow (copy)
    --  [11] ReplicatedStorage (copy)
    --  [12] color_1 (copy)
    --  [13] UserInputService (copy)
    --  [14] t_3 (copy)

    if not v4 then
        if not PadBinds_m.FIXED[arg10.Name] then
            if not PadBinds_m.isRebindable(arg10.Name) then
                return
            end

            local t_5 = {}
            v4 = { row = arg10, token = t_5 }
            clearChildren(arg10.PadIcons)
            addText(arg10, "...", 1)
            arg10.Display.BackgroundColor3 = color_2
            GuiService.SelectedObject = nil
            local clock = os.clock()

            while true do
                if not anyPadButtonDown() then
                    break
                end

                if not (os.clock() - clock < 6) then
                    break
                end

                task.wait()
            end

            local v24 = v4
            local v25 = v4.token

            if not v24 or v25 ~= t_5 then
                return
            end

            local v26 = nil
            local v27 = nil
            local v28 = nil

            local function showResult() -- line: 231
                -- upvalues:
                --  [1] clearChildren (ref)
                --  [2] arg10 (copy)
                --  [3] PadBinds_m (ref)
                --  [4] v26 (ref)
                --  [5] addText (ref)
                --  [6] addGlyph (ref)

                clearChildren(arg10.PadIcons)

                for key_4, val_3 in PadBinds_m.getKeys(v26) do
                    if key_4 > 1 then
                        addText(arg10, "+", key_4 * 2 - 1)
                    end

                    addGlyph(arg10, PadBinds_m.getIcon(val_3), key_4 * 2)
                end
            end

            local function finish() -- line: 241
                -- upvalues:
                --  [1] v4 (ref)
                --  [2] t_5 (copy)
                --  [3] v26 (ref)
                --  [4] arg10 (copy)
                --  [5] ContextActionService (ref)
                --  [6] refreshRow (ref)
                --  [7] GuiService (ref)
                --  [8] ReplicatedStorage (ref)
                --  [9] color_1 (ref)

                if not v4 or v4.token ~= t_5 then
                    return
                end

                local v32 = v26
                local v33 = arg10
                ContextActionService:UnbindAction("PadBindRecord")
                v4 = nil
                refreshRow(v33)

                if v33.PadButton.Visible then
                    GuiService.SelectedObject = v33.PadButton
                end

                if v32 == nil then
                    return
                end

                if not ReplicatedStorage.Remotes.RequestBindChange:InvokeServer(
                    "ChangePad",
                    arg10.Name,
                    v32
                ) then
                    arg10.Display.BackgroundColor3 = color_1
                    task.delay(0.4, function() -- line: 257
                        -- upvalues:
                        --  [1] v4 (ref)
                        --  [2] refreshRow (ref)
                        --  [3] arg10 (ref)

                        if not v4 then
                            refreshRow(arg10)
                        end
                    end)
                end
            end

            ContextActionService:BindActionAtPriority(
                "PadBindRecord",
                function(_, arg12, arg13) -- line: 265
                    -- upvalues:
                    --  [1] v27 (ref)
                    --  [2] v28 (ref)
                    --  [3] UserInputService (ref)
                    --  [4] v26 (ref)
                    --  [5] showResult (copy)
                    --  [6] finish (copy)

                    local KeyCode = arg13.KeyCode
                    local v34 = KeyCode == Enum.KeyCode.ButtonL2 or KeyCode == Enum.KeyCode.ButtonR2

                    if v34 and v27 == nil then
                        if arg12 == Enum.UserInputState.Begin then
                            v28 = v28 or KeyCode
                        elseif arg12 == Enum.UserInputState.End or arg12 == Enum.UserInputState.Cancel then
                            if v28 and not (UserInputService:IsGamepadButtonDown(
                                Enum.UserInputType.Gamepad1,
                                Enum.KeyCode.ButtonL2
                            ) or UserInputService:IsGamepadButtonDown(
                                Enum.UserInputType.Gamepad1,
                                Enum.KeyCode.ButtonR2
                            )) then
                                v26 = v28.Name
                                v27 = v28
                                showResult()
                                task.defer(finish)
                            end
                        end

                        return Enum.ContextActionResult.Sink
                    end

                    if arg12 == Enum.UserInputState.Begin and v27 == nil then
                        if KeyCode == Enum.KeyCode.ButtonStart then
                            v26 = nil
                        elseif KeyCode == Enum.KeyCode.ButtonSelect then
                            v26 = ""
                        else
                            v34 = {}

                            if UserInputService:IsGamepadButtonDown(
                                Enum.UserInputType.Gamepad1,
                                Enum.KeyCode.ButtonL2
                            ) then
                                table.insert(v34, "ButtonL2")
                            end

                            if UserInputService:IsGamepadButtonDown(
                                Enum.UserInputType.Gamepad1,
                                Enum.KeyCode.ButtonR2
                            ) then
                                table.insert(v34, "ButtonR2")
                            end

                            table.insert(v34, KeyCode.Name)
                            v26 = table.concat(v34, "+")
                            showResult()
                        end

                        v27 = KeyCode

                        return Enum.ContextActionResult.Sink
                    end

                    if (arg12 == Enum.UserInputState.End or arg12 == Enum.UserInputState.Cancel) and KeyCode == v27 then
                        task.defer(finish)
                    end

                    return Enum.ContextActionResult.Sink
                end,
                false,
                5000,
                table.unpack(t_3)
            )
            task.delay(6, function() -- line: 320
                -- upvalues:
                --  [1] v4 (ref)
                --  [2] t_5 (copy)
                --  [3] v27 (ref)
                --  [4] v26 (ref)
                --  [5] finish (copy)

                if v4 and v4.token == t_5 then
                    if v27 == nil then
                        v26 = nil
                    end

                    finish()
                end
            end)

            return
        else
            return
        end
    else
        return
    end
end

local _ = function(arg20) --[[ isKeyboardKey ]] -- line: 339
    return if arg20 ~= "" then if Enum.KeyCode:FromName(arg20) == nil then false else true else false
end

local function changeBind(arg21, arg22) -- line: 343
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Binds (copy)

    local RequestBindChange = ReplicatedStorage.Remotes.RequestBindChange
    local v54 = if arg22.UserInputType ~= Enum.UserInputType.Keyboard then false else true
    local v55 = if not v54 then arg22.UserInputType.Name else arg22.KeyCode.Name
    local Value = arg21.Value

    if arg21.Name == "Interact" and not v54 then
        return false
    end

    v54 = nil

    for _, child_1 in Binds:GetChildren() do
        if child_1:IsA("ValueBase") then
            v54 = if child_1 == arg21 then v54 else if child_1.Value ~= v55 then v54 else child_1
        end
    end

    v55 = if v54 == nil then false else v54.Name == "Interact" or arg21.Name == "Interact"

    if v55 and v54.Name == "Interact" then
        if not (if Value ~= "" then if Enum.KeyCode:FromName(Value) == nil then false else true else false) then
            return false
        end
    else
        if not RequestBindChange:InvokeServer(
            "Change",
            arg21.Name,
            arg22.UserInputType,
            arg22.KeyCode
        ) then
            return false
        end

        if v55 then
            if if Value ~= "" then if Enum.KeyCode:FromName(Value) == nil then false else true else false then
                RequestBindChange:InvokeServer(
                    "Change",
                    v54.Name,
                    Enum.UserInputType.Keyboard,
                    Enum.KeyCode:FromName(Value)
                )
            end
        end

        return true
    end
end

local _ = function(arg23) --[[ getCategory ]] -- line: 382
    -- upvalues:
    --  [1] t_2 (copy)

    for key_8, val_6 in t_2 do
        if table.find(val_6, arg23) then
            return key_8
        end
    end

    return "Misc"
end

local _ = function(arg24) --[[ createCategory ]] -- line: 392
    -- upvalues:
    --  [1] Keybinds (copy)

    local v58 = Keybinds:FindFirstChild(arg24)

    if v58 then
        return v58
    end

    local v59 = script.Category:Clone()
    v59.Name = arg24
    local v60 = script.Header:Clone()
    v60.Text = arg24
    v60.Parent = v59
    v60.Name = "@"
    v59.Parent = Keybinds

    return v59
end

local v63, v64, v65, v66

for _, child_2 in Binds:GetChildren() do
    if child_2:IsA("ValueBase") then
        local Name_2 = child_2.Name

        for key_10, val_7 in t_2 do
            if table.find(val_7, Name_2) then
                v63 = key_10
            end
        end

        v63 = "Misc"
        v64 = Keybinds:FindFirstChild(v63)

        if v64 then
            v65 = v64
        else
            v64 = script.Category:Clone()
            v64.Name = v63
            v66 = script.Header:Clone()
            v66.Text = v63
            v66.Parent = v64
            v66.Name = "@"
            v64.Parent = Keybinds
            v65 = v64
        end

        v63 = script.Template:Clone()
        local v64 = v63.Display
        v63.Name = Name_2
        v63.Title.Text = Name_2
        v66 = Instance.new("Frame")
        v66.Name = "PadIcons"
        v66.BackgroundTransparency = 1
        v66.Size = UDim2.fromScale(1, 1)
        v66.ZIndex = 7
        v66.Visible = false
        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.FillDirection = Enum.FillDirection.Horizontal
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 3)
        UIListLayout.Parent = v66
        v66.Parent = v64
        local KeyButton_TextButton = Instance.new("TextButton")
        KeyButton_TextButton.Name = "KeyButton"
        KeyButton_TextButton.BackgroundTransparency = 1
        KeyButton_TextButton.Text = ""
        KeyButton_TextButton.Size = UDim2.fromScale(1, 1)
        KeyButton_TextButton.ZIndex = 9
        KeyButton_TextButton.Selectable = false
        KeyButton_TextButton.Parent = v64
        v64.Key.Active = false
        v64.Key.Selectable = false
        local TextButton_1 = Instance.new("TextButton")
        TextButton_1.Name = "PadButton"
        TextButton_1.BackgroundTransparency = 1
        TextButton_1.Text = ""
        TextButton_1.Size = UDim2.fromScale(1, 1)
        TextButton_1.ZIndex = 9
        TextButton_1.Selectable = true
        TextButton_1.Visible = false
        TextButton_1.Parent = v64
        local t_12 = {
            Name = Name_2,
            Bind = child_2,
            Template = v63,
            Display = v64,
            PadIcons = v66,
            PadButton = TextButton_1,
            KeyButton = KeyButton_TextButton
        }
        t_4[Name_2] = t_12
        local v66 = Services_m.Maid.new()

        local function displaykey() -- line: 484
            -- upvalues:
            --  [1] refreshRow (copy)
            --  [2] t_12 (copy)

            refreshRow(t_12)
        end

        TextButton_1.Activated:Connect(function() -- line: 488
            -- upvalues:
            --  [1] recordPad (copy)
            --  [2] t_12 (copy)

            task.spawn(recordPad, t_12)
        end)
        local v68 = nil
        KeyButton_TextButton.Activated:Connect(function() -- line: 496
            -- upvalues:
            --  [1] GamepadLayer_m (copy)
            --  [2] v4 (ref)
            --  [3] v66 (copy)
            --  [4] v64 (copy)
            --  [5] color_2 (copy)
            --  [6] v68 (ref)
            --  [7] UserInputService (copy)
            --  [8] t (copy)
            --  [9] changeBind (copy)
            --  [10] child_2 (copy)
            --  [11] refreshRow (copy)
            --  [12] t_12 (copy)

            if GamepadLayer_m.isGamepadActive() or v4 then
                return
            end

            v66:Destroy()
            v64.Key.Label.Visible = false
            v64.BackgroundColor3 = color_2
            local t_11 = {}
            v68 = t_11
            task.defer(function() -- line: 509
                -- upvalues:
                --  [1] v68 (ref)
                --  [2] t_11 (copy)
                --  [3] v66 (ref)
                --  [4] UserInputService (ref)
                --  [5] t (ref)
                --  [6] changeBind (ref)
                --  [7] child_2 (ref)
                --  [8] refreshRow (ref)
                --  [9] t_12 (ref)

                if v68 ~= t_11 then
                    return
                end

                v66:GiveTask(UserInputService.InputBegan:Connect(function(input) -- line: 514
                    -- upvalues:
                    --  [1] t (ref)
                    --  [2] v66 (ref)
                    --  [3] v68 (ref)
                    --  [4] changeBind (ref)
                    --  [5] child_2 (ref)
                    --  [6] refreshRow (ref)
                    --  [7] t_12 (ref)

                    if table.find(t, input.UserInputType) then
                        v66:Destroy()
                        v68 = nil

                        if not changeBind(child_2, input) then
                            print("can't make this key a keybind:", input.KeyCode)
                        end

                        refreshRow(t_12)

                        return
                    end

                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
                        v66:Destroy()
                        v68 = nil
                        refreshRow(t_12)
                    end
                end))
            end)
            task.delay(6, function() -- line: 531
                -- upvalues:
                --  [1] v68 (ref)
                --  [2] t_11 (copy)
                --  [3] v66 (ref)
                --  [4] refreshRow (ref)
                --  [5] t_12 (ref)

                if v68 == t_11 then
                    v68 = nil
                    v66:Destroy()
                    refreshRow(t_12)
                end
            end)
        end)
        child_2:GetPropertyChangedSignal("Value"):Connect(displaykey)
        refreshRow(t_12)
        v63.Parent = v65
    end
end

PadBinds_m.Changed:Connect(function(arg26) -- line: 546
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] refreshRow (copy)

    local v70 = t_4[arg26]

    if v70 then
        refreshRow(v70)
    end
end)
GamepadLayer_m.InputModeChanged:Connect(refreshAll)
Keybinds.Parent.ResetBinds.Activated:Connect(function() -- line: 555
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] GamepadLayer_m (copy)

    local v71 = if not GamepadLayer_m.isGamepadActive() then "Reset" else "ResetPad"
    ReplicatedStorage.Remotes.RequestBindChange:InvokeServer(v71)
end)
