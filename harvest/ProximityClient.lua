-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.ProximityClient
-- Class: LocalScript
-- bytes: 18861

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local TweenService = game:GetService("TweenService")
local Formatter_m = require(ReplicatedStorage.Modules.Formatter)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Bin = LocalPlayer:WaitForChild("bin")
local GamepadButtonImage_m = require(script.GamepadButtonImage)
local KeyboardButtonImage_m = require(script.KeyboardButtonImage)
local KeyboardButtonIconMapping_m = require(script.KeyboardButtonIconMapping)
local KeyCodeToTextMapping_m = require(script.KeyCodeToTextMapping)
local t = { ChatPrompt = "Chat", HarvestPrompt = "Harvest", MinePrompt = "Mine" }
local t_1 = { ChatPrompt = true, HarvestPrompt = true, MinePrompt = true }
local CustomPrompt = script.CustomPrompt
local Ripple = script.Ripple
local ObjectHighlight = ReplicatedStorage.Effects.ObjectHighlight
local tweenInfo = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local KeyCode_E = Enum.KeyCode.E

local _ = function() --[[ getInteractKey ]] -- line: 59
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] KeyCode_E (copy)

    local v1 = LocalPlayer:FindFirstChild("Binds")
    local v2 = v1

    if v2 then
        v2 = v1:FindFirstChild("Interact")
    end

    v1 = v2

    if v1 then
        v1 = if v2.Value ~= "" then Enum.KeyCode:FromName(v2.Value) else false
    end

    return v1 or KeyCode_E
end

local function applyInteractKey(arg1) -- line: 66
    -- upvalues:
    --  [1] KeyCode_E (copy)
    --  [2] LocalPlayer (copy)

    if not arg1:IsA("ProximityPrompt") then
        return
    end

    local v4 = arg1:GetAttribute("FollowsInteractBind")

    if v4 == nil then
        local v5 = if arg1.KeyboardKeyCode == KeyCode_E then if arg1:GetAttribute("FixedKey") == true then false else true else false
        v4 = v5
        arg1:SetAttribute("FollowsInteractBind", v4)
    end

    if v4 then
        local v6 = LocalPlayer:FindFirstChild("Binds")
        local v7 = v6

        if v7 then
            v7 = v6:FindFirstChild("Interact")
        end

        v6 = v7

        if v6 then
            v6 = if v7.Value ~= "" then Enum.KeyCode:FromName(v7.Value) else false
        end

        arg1.KeyboardKeyCode = v6 or KeyCode_E
    end
end

local t_2 = {}

local function applyInteractKeyToShown() -- line: 89
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] applyInteractKey (copy)

    for key in t_2 do
        if key.Parent then
            applyInteractKey(key)
        else
            t_2[key] = nil
        end
    end
end

ProximityPromptService.PromptHidden:Connect(function(prompt) -- line: 99
    -- upvalues:
    --  [1] t_2 (copy)

    t_2[prompt] = nil
end)
task.spawn(function() -- line: 104
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] applyInteractKeyToShown (copy)
    --  [3] t_2 (copy)
    --  [4] applyInteractKey (copy)

    local Binds = LocalPlayer:WaitForChild("Binds")

    local function watch(arg3) -- line: 106
        -- upvalues:
        --  [1] applyInteractKeyToShown (ref)
        --  [2] t_2 (ref)
        --  [3] applyInteractKey (ref)

        if arg3.Name == "Interact" and arg3:IsA("StringValue") then
            arg3:GetPropertyChangedSignal("Value"):Connect(applyInteractKeyToShown)

            for key_1 in t_2 do
                if key_1.Parent then
                    applyInteractKey(key_1)
                else
                    t_2[key_1] = nil
                end
            end
        end
    end

    for _, child in Binds:GetChildren() do
        if child.Name == "Interact" and child:IsA("StringValue") then
            child:GetPropertyChangedSignal("Value"):Connect(applyInteractKeyToShown)

            for key_3 in t_2 do
                if key_3.Parent then
                    applyInteractKey(key_3)
                else
                    t_2[key_3] = nil
                end
            end
        end
    end

    Binds.ChildAdded:Connect(watch)
end)

local _ = function(arg4) --[[ getModel ]] -- line: 120
    local v8 = arg4:FindFirstAncestorWhichIsA("Model")

    if v8 == workspace then
        return nil
    end

    return v8
end

local _ = function(arg5) --[[ getActionText ]] -- line: 128
    -- upvalues:
    --  [1] t (copy)

    return if arg5.ActionText == "" then t[arg5.Name] or "Interact" else if arg5.ActionText == "Interact" then t[arg5.Name] or "Interact" else arg5.ActionText
end

local _ = function(arg6) --[[ getObjectText ]] -- line: 135
    -- upvalues:
    --  [1] t_1 (copy)

    if arg6.ObjectText ~= "" then
        return arg6.ObjectText
    end

    local v9 = arg6:GetAttribute("DisplayName")

    if v9 then
        return v9
    end

    local v10 = arg6:FindFirstAncestorWhichIsA("Model")
    v9 = if v10 == workspace then nil else v10

    if v9 then
        local DisplayName = v9:GetAttribute("DisplayName")

        if DisplayName then
            return DisplayName
        end

        if t_1[arg6.Name] then
            return v9.Name
        end
    end

    return ""
end

local function getKeyDisplay(arg7, arg8) -- line: 160
    -- upvalues:
    --  [1] UserInputService (copy)
    --  [2] GamepadButtonImage_m (copy)
    --  [3] KeyboardButtonImage_m (copy)
    --  [4] KeyboardButtonIconMapping_m (copy)
    --  [5] KeyCodeToTextMapping_m (copy)

    if arg8 == Enum.ProximityPromptInputType.Touch then
        return "rbxasset://textures/ui/Controls/TouchTapIcon.png", nil
    end

    local v13

    if arg8 == Enum.ProximityPromptInputType.Gamepad then
        local v11 = UserInputService:GetImageForKeyCode(arg7.GamepadKeyCode)

        if v11 and v11 ~= "" then
            return v11, nil
        end

        if GamepadButtonImage_m[arg7.GamepadKeyCode] then
            return GamepadButtonImage_m[arg7.GamepadKeyCode], nil
        end

        local v12 = string.gsub(
            UserInputService:GetStringForKeyCode(arg7.GamepadKeyCode),
            "^Button",
            ""
        )
        v13 = v12

        if v12 == "" or not v13 then
            v13 = arg7.GamepadKeyCode.Name
        end

        return nil, v13
    else
        local KeyboardKeyCode = arg7.KeyboardKeyCode
        local v14 = UserInputService:GetStringForKeyCode(KeyboardKeyCode)
        v13 = KeyboardButtonImage_m[KeyboardKeyCode] or KeyboardButtonIconMapping_m[v14]

        if v13 then
            return v13, nil
        end

        v13 = KeyCodeToTextMapping_m[KeyboardKeyCode] or v14
        v13 = if not v13 then KeyboardKeyCode.Name else if v13 ~= "" then v13 else KeyboardKeyCode.Name

        return nil, v13
    end
end

local _ = function(arg9) --[[ getItemName ]] -- line: 197
    if arg9.ObjectText ~= "" then
        return arg9.ObjectText
    end

    local v15 = arg9:FindFirstAncestorWhichIsA("Model")
    local v16 = if v15 == workspace then nil else v15

    if v16 then
        return v16:GetAttribute("DisplayName") or v16.Name
    end

    return arg9:GetAttribute("DisplayName") or "Item"
end

local _ = function(arg10) --[[ getPurchaseText ]] -- line: 208
    -- upvalues:
    --  [1] Formatter_m (copy)

    local Price = arg10:FindFirstChild("Price")
    local v18

    if Price then
        v18 = Formatter_m.addCommas(Price.Value)

        if not v18 then
            v18 = Price and tostring(Price.Value) or "?"
        end
    else
        v18 = Price and tostring(Price.Value) or "?"
    end

    return `Purchase: {v18} Marks`
end

local function buildCustomPrompt(arg11, arg12, arg13, arg14) -- line: 216
    -- upvalues:
    --  [1] CustomPrompt (copy)
    --  [2] getKeyDisplay (copy)

    local v19 = CustomPrompt:Clone()
    local Button = v19.InputFrame.Button
    local v20, v21 = getKeyDisplay(arg11, arg12)
    Button.ButtonImage.Image = v20 or ""
    Button.ButtonImage.Visible = if v20 == nil then false else true
    Button.ButtonText.Text = v21 or ""
    local ButtonText = Button.ButtonText
    ButtonText.Visible = v21 ~= nil
    local Labels = v19.InputFrame.Labels
    Labels.Top.Text = arg13
    Labels.Bottom.Text = arg14
    local v23 = Labels.Bottom
    v23.Visible = arg14 ~= ""
    v23 = nil

    for _, child_1 in Button:GetChildren() do
        v23 = if child_1.Name ~= "Outline" then v23 else if child_1.Visible then v23 else child_1
    end

    return v19, Button, v23
end

local function getKeyLayout(arg15, arg16) -- line: 247
    local v24 = arg16.Size.X.Offset

    if v24 <= 0 or arg16.AbsoluteSize.X <= 0 then
        return nil
    end

    local v25 = arg16.AbsoluteSize.X / v24
    v24 = arg16

    while true do
        if not v24.Parent then
            break
        end

        if v24.Parent == arg15 then
            break
        end

        v24 = v24.Parent
    end

    if v24.Parent ~= arg15 then
        return nil
    end

    local vec2 = Vector2.new(arg15.Size.X.Offset, arg15.Size.Y.Offset)
    local v26 = v24.AbsoluteSize / v25
    local vec2_1 = Vector2.new(
        v24.Position.X.Scale * vec2.X + v24.Position.X.Offset - v24.AnchorPoint.X * v26.X,
        v24.Position.Y.Scale * vec2.Y + v24.Position.Y.Offset - v24.AnchorPoint.Y * v26.Y
    )
    local v27 = arg16.AbsoluteSize / v25

    return vec2_1 + (arg16.AbsolutePosition - v24.AbsolutePosition) / v25 + v27 / 2, v27
end

local function playRipple(arg17, arg18) -- line: 275
    -- upvalues:
    --  [1] Ripple (copy)
    --  [2] getKeyLayout (copy)
    --  [3] PlayerGui (copy)
    --  [4] TweenService (copy)
    --  [5] tweenInfo (copy)

    if not arg17.Parent then
        return
    end

    local v28 = Ripple:Clone()
    local Ripple_1 = v28.Ripple
    local v29, v30 = getKeyLayout(arg17, arg18)

    if v29 then
        Ripple_1.Position = UDim2.fromOffset(v29.X, v29.Y)
    else
        v30 = Vector2.new(35, 35)
    end

    Ripple_1.Size = UDim2.fromOffset(v30.X, v30.Y)
    v28.Adornee = arg17.Adornee
    v28.StudsOffset = arg17.StudsOffset
    v28.StudsOffsetWorldSpace = arg17.StudsOffsetWorldSpace
    v28.ExtentsOffset = arg17.ExtentsOffset
    v28.Enabled = true
    v28.Parent = PlayerGui
    local v33 = TweenService:Create(
        Ripple_1,
        tweenInfo,
        { Size = UDim2.fromOffset(v30.X * 2.6, v30.Y * 2.6), ImageTransparency = 1 }
    )
    v33.Completed:Once(function() -- line: 303
        -- upvalues:
        --  [1] v28 (copy)

        v28:Destroy()
    end)
    v33:Play()
end

local function createHighlight(arg19) -- line: 309
    -- upvalues:
    --  [1] ObjectHighlight (copy)

    local Parent = arg19.Parent

    if Parent and Parent:IsA("Attachment") then
        Parent = Parent.Parent
    end

    if not Parent then
        return nil
    end

    local v34 = Parent
    local Parent_1 = Parent.Parent

    if Parent_1 and Parent_1:IsA("Model") and Parent_1 ~= workspace then
        v34 = Parent_1
    end

    local v35 = ObjectHighlight:Clone()
    v35.Enabled = if arg19:GetAttribute("DisableHighlight") == true then false else true
    v35.Parent = v34

    return v35
end

local _ = function(arg20) --[[ isPromptInput ]] -- line: 333
    return arg20.UserInputType == Enum.UserInputType.Touch or arg20.UserInputType == Enum.UserInputType.MouseButton1
end

local function showPrompt(arg21, arg22) -- line: 337
    -- upvalues:
    --  [1] Formatter_m (copy)
    --  [2] t (copy)
    --  [3] t_1 (copy)
    --  [4] buildCustomPrompt (copy)
    --  [5] getKeyDisplay (copy)
    --  [6] UserInputService (copy)
    --  [7] playRipple (copy)
    --  [8] createHighlight (copy)
    --  [9] PlayerGui (copy)

    local v45, v46
    local t_4 = {}

    local _ = function(arg23) --[[ track ]] -- line: 339
        -- upvalues:
        --  [1] t_4 (copy)

        table.insert(t_4, arg23)
    end

    local v38, v42, v43

    if arg21.Name == "BuyPrompt" then
        local v40

        if arg21.ObjectText ~= "" then
            v38 = arg21.ObjectText
        else
            local v39 = arg21:FindFirstAncestorWhichIsA("Model")
            v40 = if v39 == workspace then nil else v39
            v38 = if v40 then v40:GetAttribute("DisplayName") or v40.Name else arg21:GetAttribute(
                "DisplayName"
            ) or "Item"
        end

        v40 = arg21:FindFirstChild("Price")
        local v41

        if v40 then
            v41 = Formatter_m.addCommas(v40.Value)

            if not v41 then
                v41 = v40 and tostring(v40.Value) or "?"
            end
        else
            v41 = v40 and tostring(v40.Value) or "?"
        end

        v42 = `Purchase: {v41} Marks`
    else
        v38 = if arg21.ActionText == "" then t[arg21.Name] or "Interact" else if arg21.ActionText == "Interact" then t[arg21.Name] or "Interact" else arg21.ActionText

        if arg21.ObjectText ~= "" then
            v42 = arg21.ObjectText
        else
            v43 = arg21:GetAttribute("DisplayName")

            if v43 then
                v42 = v43
            else
                local v44 = arg21:FindFirstAncestorWhichIsA("Model")
                v43 = if v44 == workspace then nil else v44

                if v43 then
                    local DisplayName_1 = v43:GetAttribute("DisplayName")
                    v42 = if DisplayName_1 then DisplayName_1 else if not t_1[arg21.Name] then "" else v43.Name
                else
                    v42 = ""
                end
            end
        end
    end

    v43, v45, v46 = buildCustomPrompt(arg21, arg22, v38, v42)
    local KeyboardKeyCode_1 = arg21:GetPropertyChangedSignal("KeyboardKeyCode"):Connect(function() -- line: 353
        -- upvalues:
        --  [1] getKeyDisplay (ref)
        --  [2] arg21 (copy)
        --  [3] arg22 (copy)
        --  [4] v45 (copy)

        local v47, v48 = getKeyDisplay(arg21, arg22)
        v45.ButtonImage.Image = v47 or ""
        v45.ButtonImage.Visible = v47 ~= nil
        v45.ButtonText.Text = v48 or ""
        v45.ButtonText.Visible = v48 ~= nil
    end)
    table.insert(t_4, KeyboardKeyCode_1)

    function v42(arg24) --[[ setPressed ]] -- line: 361
        -- upvalues:
        --  [1] v46 (copy)

        if v46 then
            v46.Visible = arg24
        end
    end

    local v50 = false
    v38 = v43.TextButton
    v38.Visible = true
    local v52 = v38.InputBegan:Connect(function(input) -- line: 373
        -- upvalues:
        --  [1] v50 (ref)
        --  [2] v46 (copy)
        --  [3] arg21 (copy)

        if (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) and input.UserInputState ~= Enum.UserInputState.Change then
            v50 = true

            if v46 then
                v46.Visible = true
            end

            arg21:InputHoldBegin()
        end
    end)
    table.insert(t_4, v52)
    local v54 = v38.InputEnded:Connect(function(input_1) -- line: 380
        -- upvalues:
        --  [1] v50 (ref)
        --  [2] v46 (copy)
        --  [3] arg21 (copy)

        if (input_1.UserInputType == Enum.UserInputType.Touch or input_1.UserInputType == Enum.UserInputType.MouseButton1) and v50 then
            v50 = false

            if v46 then
                v46.Visible = false
            end

            arg21:InputHoldEnd()
        end
    end)
    table.insert(t_4, v54)
    v43.Active = true
    local v55 = UserInputService.InputBegan:Connect(function(input_2) -- line: 393
        -- upvalues:
        --  [1] UserInputService (ref)
        --  [2] arg21 (copy)
        --  [3] v46 (copy)

        if UserInputService:GetFocusedTextBox() then
            return
        end

        if (input_2.KeyCode == arg21.KeyboardKeyCode or input_2.KeyCode == arg21.GamepadKeyCode) and v46 then
            v46.Visible = true
        end
    end)
    table.insert(t_4, v55)
    local v56 = UserInputService.InputEnded:Connect(function(input_3) -- line: 401
        -- upvalues:
        --  [1] arg21 (copy)
        --  [2] v46 (copy)

        if (input_3.KeyCode == arg21.KeyboardKeyCode or input_3.KeyCode == arg21.GamepadKeyCode) and v46 then
            v46.Visible = false
        end
    end)
    table.insert(t_4, v56)
    local v57 = arg21.Triggered:Connect(function() -- line: 407
        -- upvalues:
        --  [1] playRipple (ref)
        --  [2] v43 (copy)
        --  [3] v45 (copy)

        playRipple(v43, v45)
    end)
    table.insert(t_4, v57)
    local v58 = createHighlight(arg21)

    if v58 then
        local DisableHighlight = arg21:GetAttributeChangedSignal("DisableHighlight")
        table.insert(t_4, (DisableHighlight:Connect(function() -- line: 414
            -- upvalues:
            --  [1] v58 (copy)
            --  [2] arg21 (copy)

            v58.Enabled = if arg21:GetAttribute("DisableHighlight") == true then false else true
        end)))
    end

    v43.Adornee = arg21.Parent
    v43.Enabled = true
    v43.Parent = PlayerGui

    return function() -- line: 423
        -- upvalues:
        --  [1] t_4 (copy)
        --  [2] v50 (ref)
        --  [3] arg21 (copy)
        --  [4] v43 (copy)
        --  [5] v58 (copy)

        for _, val in t_4 do
            val:Disconnect()
        end

        if v50 then
            v50 = false
            arg21:InputHoldEnd()
        end

        v43:Destroy()

        if v58 then
            v58:Destroy()
        end
    end
end

ProximityPromptService.PromptShown:Connect(function(prompt_1, inputType) -- line: 438
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] applyInteractKey (copy)
    --  [3] Bin (copy)
    --  [4] showPrompt (copy)

    t_2[prompt_1] = true
    applyInteractKey(prompt_1)

    if prompt_1.Style == Enum.ProximityPromptStyle.Default or not prompt_1.Enabled or Bin.Chatting.Value then
        return
    end

    local Success, Result = pcall(showPrompt, prompt_1, inputType)

    if not Success then
        warn((("[ProximityClient] Couldn't show %*: %*"):format(prompt_1:GetFullName(), Result)))

        return
    end

    local v63 = false
    local v64 = nil
    local v65 = nil
    v64 = prompt_1.PromptHidden:Connect(function() --[[ finish ]] -- line: 456
        -- upvalues:
        --  [1] v63 (ref)
        --  [2] v64 (ref)
        --  [3] v65 (ref)
        --  [4] Result (copy)

        if v63 then
            return
        end

        v63 = true
        v64:Disconnect()
        v65:Disconnect()
        Result()
    end)
    v65 = prompt_1.AncestryChanged:Connect(function(_, arg32) -- line: 467
        -- upvalues:
        --  [1] v63 (ref)
        --  [2] v64 (ref)
        --  [3] v65 (ref)
        --  [4] Result (copy)

        if not arg32 then
            if v63 then
                return
            end

            v63 = true
            v64:Disconnect()
            v65:Disconnect()
            Result()
        end
    end)
end)
