-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Chat.DialogueClient
-- Class: LocalScript
-- bytes: 14492

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")
local _ = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local Modules = ReplicatedStorage.Modules
local BackpackUtils_m = require(Modules.BackpackUtils)
local Basic_m = require(Modules.Basic)
local DialogueManager_m = require(script.DialogueManager)
local GamepadLayer_m = require(Modules.GamepadLayer)
local Typewriter_m = require(script.Typewriter)
local NPCS = require(Modules.ClientNPCS).NPCS
local v2, v3 = require(Modules.scriptObjs).GetPlayerCharacter()
local Chatting = v2:WaitForChild("bin").Chatting
local HumanoidRootPart = v3:WaitForChild("HumanoidRootPart")
local ChatBox = script.Parent.ChatBox
local Container = ChatBox.ChatText.Container
DialogueManager_m:SetChatBox(ChatBox)
local Choices = ChatBox.Choices
local Keys = BackpackUtils_m._keys
local t = {}

for key in Keys do
    table.insert(t, key)
end

local v4 = nil
local v5 = nil
local v6 = nil
local v7 = 0

local function selectFirstChoice() -- line: 57
    -- upvalues:
    --  [1] GamepadLayer_m (copy)
    --  [2] Choices (copy)
    --  [3] GuiService (copy)

    if not GamepadLayer_m.isGamepadActive() or not Choices.Visible then
        return
    end

    local v8 = nil
    local v9 = math.huge

    for _, child in Choices:GetChildren() do
        if child:IsA("Frame") and v9 > child.LayoutOrder then
            v8 = child
            v9 = child.LayoutOrder
        end
    end

    if v8 then
        GuiService.SelectedObject = v8.Button
    end
end

local _ = function() --[[ releaseChoiceSelection ]] -- line: 74
    -- upvalues:
    --  [1] GuiService (copy)
    --  [2] Choices (copy)

    local SelectedObject = GuiService.SelectedObject

    if SelectedObject and SelectedObject:IsDescendantOf(Choices) then
        GuiService.SelectedObject = nil
    end
end

local function fadeInOptions(arg1, _) -- line: 81
    -- upvalues:
    --  [1] TweenService (copy)

    local Button = arg1.Button
    local Background = arg1.Background
    local Outline = arg1.Outline
    local UIStroke = Button.UIStroke
    local tweenInfo = TweenInfo.new(0.3)
    TweenService:Create(Button, tweenInfo, { TextTransparency = 0 }):Play()
    TweenService:Create(Background, tweenInfo, { BackgroundTransparency = 0.5 }):Play()
    TweenService:Create(Outline, tweenInfo, { ImageTransparency = 0 }):Play()
    TweenService:Create(UIStroke, tweenInfo, { Transparency = 0 }):Play()
end

local function clearChoices() -- line: 95
    -- upvalues:
    --  [1] GuiService (copy)
    --  [2] Choices (copy)

    local SelectedObject_1 = GuiService.SelectedObject

    if SelectedObject_1 and SelectedObject_1:IsDescendantOf(Choices) then
        GuiService.SelectedObject = nil
    end

    for _, child_1 in ipairs(Choices:GetChildren()) do
        if child_1:IsA("Frame") then
            child_1:Destroy()
        end
    end
end

local _ = function(s1: string, u1: userdata, b1: boolean, u2: userdata) --[[ AnimateText ]] -- line: 105
    -- upvalues:
    --  [1] Typewriter_m (copy)
    --  [2] Container (copy)

    Typewriter_m:Clean(Container)
    Typewriter_m:Write(u1, s1, b1, u2)
end

local function endDialogue() -- line: 110
    -- upvalues:
    --  [1] v7 (ref)
    --  [2] v6 (ref)
    --  [3] v4 (ref)
    --  [4] v5 (ref)
    --  [5] ChatBox (copy)
    --  [6] Chatting (copy)
    --  [7] ContextActionService (copy)
    --  [8] Typewriter_m (copy)
    --  [9] Container (copy)
    --  [10] clearChoices (copy)

    v7 += 1
    v6 = nil
    v4 = nil

    if v5 then
        v5.Enabled = not v5:GetAttribute("ServerDisabled")
    end

    ChatBox.Visible = false
    Chatting.Value = false
    ContextActionService:UnbindAction("ChatSkipKeys")
    Typewriter_m:Clean(Container)
    clearChoices()
end

local function keyboardAction(_, arg4, arg5) -- line: 128
    -- upvalues:
    --  [1] Keys (copy)
    --  [2] v4 (ref)
    --  [3] v7 (ref)
    --  [4] v6 (ref)
    --  [5] v5 (ref)
    --  [6] ChatBox (copy)
    --  [7] Chatting (copy)
    --  [8] ContextActionService (copy)
    --  [9] Typewriter_m (copy)
    --  [10] Container (copy)
    --  [11] clearChoices (copy)

    if arg4 == Enum.UserInputState.Begin and Keys[arg5.KeyCode] then
        if not v4 then
            return
        end

        local v12 = v4:GetAvailableChoices()

        if not v12 then
            return
        end

        local v13 = Keys[arg5.KeyCode]

        if v12[v13] then
            v4:Choose(v13)

            if v4 and v4:IsFinished() then
                v7 += 1
                v6 = nil
                v4 = nil

                if v5 then
                    v5.Enabled = not v5:GetAttribute("ServerDisabled")
                end

                ChatBox.Visible = false
                Chatting.Value = false
                ContextActionService:UnbindAction("ChatSkipKeys")
                Typewriter_m:Clean(Container)
                clearChoices()

                return
            end

            renderNode()
        end
    end
end

function renderNode() -- line: 156
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] v7 (ref)
    --  [3] v2 (copy)
    --  [4] Basic_m (copy)
    --  [5] Chatting (copy)
    --  [6] ChatBox (copy)
    --  [7] Choices (copy)
    --  [8] ContextActionService (copy)
    --  [9] clearChoices (copy)
    --  [10] Container (copy)
    --  [11] Typewriter_m (copy)
    --  [12] keyboardAction (copy)
    --  [13] t (copy)
    --  [14] fadeInOptions (copy)
    --  [15] v6 (ref)
    --  [16] v5 (ref)
    --  [17] selectFirstChoice (copy)

    if not v4 then
        return
    end

    v7 += 1
    local v15 = v7
    local v16 = v4:GetCurrentNode()

    if not v16 then
        return
    end

    local v17 = v4:GetAvailableChoices()
    local v18 = v16.text
    local Yield = v16.__yield

    if type(v18) == "function" then
        v18 = v18()
    elseif typeof(v18) == "table" then
        v18 = v18[math.random(1, #v18)]
    end

    if v18:match("{reputation}") then
        local v19 = v4.Owner
        local v20 = v19

        if v20 then
            v20 = v19:FindFirstChild("Reputation")
        end

        v19 = v20 and v20.Value
        v20 = v19

        if v20 then
            v20 = v2.Factions:FindFirstChild(v19)
        end

        if v19 and v20 then
            v18 = string.gsub(v18, "{reputation}", Basic_m:GetRepResetCost(v20.Value))
        end
    end

    Chatting.Value = true
    ChatBox.Visible = true
    Choices.Visible = false
    ChatBox.Header.Text = string.gsub(v4.DisplayName, " Respawnable", "")
    ContextActionService:UnbindAction("ChatSkipKeys")
    clearChoices()
    local v21 = Container
    Typewriter_m:Clean(Container)
    Typewriter_m:Write(v21, v18, Yield, nil)

    if v15 ~= v7 or not v4 then
        return
    end

    ContextActionService:BindActionAtPriority(
        "ChatSkipKeys",
        keyboardAction,
        false,
        2,
        table.unpack(t)
    )

    for key_3, val in ipairs(v17) do
        local Data = val.data
        local v24 = script.ChoiceTemplate:Clone()
        v24.LayoutOrder = key_3
        v24.Button.Text = `{key_3}. {Data.text}`
        v24.Parent = Choices
        fadeInOptions(v24)
        v24.Button.Activated:Connect(function() -- line: 218
            -- upvalues:
            --  [1] v4 (ref)
            --  [2] key_3 (copy)
            --  [3] v7 (ref)
            --  [4] v6 (ref)
            --  [5] v5 (ref)
            --  [6] ChatBox (ref)
            --  [7] Chatting (ref)
            --  [8] ContextActionService (ref)
            --  [9] Typewriter_m (ref)
            --  [10] Container (ref)
            --  [11] clearChoices (ref)

            if not v4 then
                return
            end

            v4:Choose(key_3)

            if v4 and v4:IsFinished() then
                v7 += 1
                v6 = nil
                v4 = nil

                if v5 then
                    v5.Enabled = not v5:GetAttribute("ServerDisabled")
                end

                ChatBox.Visible = false
                Chatting.Value = false
                ContextActionService:UnbindAction("ChatSkipKeys")
                Typewriter_m:Clean(Container)
                clearChoices()

                return
            end

            renderNode()
        end)
    end

    if v15 ~= v7 or not v4 then
        return
    end

    Choices.Visible = true
    selectFirstChoice()
end

function startDialogue(arg6, arg7) -- line: 241
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] ReplicatedStorage (copy)
    --  [3] NPCS (copy)
    --  [4] DialogueManager_m (copy)
    --  [5] v5 (ref)
    --  [6] v6 (ref)

    if v4 then
        return
    end

    ReplicatedStorage.SFX.Misc.Ding:Play()
    local v26 = if typeof(arg6) == "string" then arg6 else arg6.Name
    v4 = DialogueManager_m.new(arg6, NPCS[v26], v26)
    v5 = arg7
    v6 = arg6

    if arg7 then
        _G.PROMPTS[arg7] = true
        arg7.Enabled = false
    end

    renderNode()
end

function startObjectDialogue(arg8, arg9, arg10) -- line: 270
    -- upvalues:
    --  [1] Chatting (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] v4 (ref)
    --  [4] DialogueManager_m (copy)
    --  [5] v5 (ref)
    --  [6] v6 (ref)

    if Chatting.Value then
        return
    end

    ReplicatedStorage.SFX.Misc.Ding:Play()
    local v27 = if typeof(arg8) == "string" then arg8 else arg8.Name
    local v28 = arg10 or arg8:FindFirstChild("Info")
    local v29 = typeof(v28)
    local v30 = nil

    if v29 == "string" then
        local t_1 = { start = "initial", nodes = nil }
        local t_2 = { initial = { text = v28 } }
        t_1.nodes = t_2
        v30 = t_1
    elseif v29 == "Instance" then
        v30 = require(v28)
    elseif v29 == "table" then
        v30 = v28
    else
        warn("nil received for InfoToUse")
    end

    v4 = DialogueManager_m.new(arg8, v30, v27)
    v5 = arg9
    v6 = arg8

    if arg9 then
        _G.PROMPTS[arg9] = true
        arg9.Enabled = false
    end

    renderNode()
end

function forceDialogue(arg11, arg12) -- line: 323
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] DialogueManager_m (copy)
    --  [3] v5 (ref)

    if v4 then
        return
    end

    v4 = DialogueManager_m.new(nil, arg11, "")

    if arg12 then
        v5 = arg12
        _G.PROMPTS[arg12] = true
        arg12.Enabled = false
    end

    renderNode()
end

GamepadLayer_m.InputModeChanged:Connect(function(arg13) -- line: 341
    -- upvalues:
    --  [1] selectFirstChoice (copy)
    --  [2] GuiService (copy)
    --  [3] Choices (copy)

    if arg13 then
        selectFirstChoice()

        return
    end

    local SelectedObject_2 = GuiService.SelectedObject

    if SelectedObject_2 and SelectedObject_2:IsDescendantOf(Choices) then
        GuiService.SelectedObject = nil
    end
end)
ReplicatedStorage.Remotes.NPC.OnClientEvent:Connect(startDialogue)
ReplicatedStorage.Remotes.ChatObject.OnClientEvent:Connect(startObjectDialogue)
ReplicatedStorage.Remotes.ForceChat.OnClientEvent:Connect(forceDialogue)
_G.ClientChatObject = startObjectDialogue
_G.ForceChat = forceDialogue
_G.EndDialogue = endDialogue
local t_4 = {}

local function registerNPC(arg14) -- line: 358
    -- upvalues:
    --  [1] t_4 (copy)

    if not arg14:FindFirstChildWhichIsA("Humanoid") then
        return
    end

    if not arg14:FindFirstChild("Head") then
        return
    end

    if not arg14:FindFirstChild("Torso") then
        return
    end

    if arg14:HasTag("Inanimate") then
        return
    end

    local Torso = arg14.Torso
    local Neck = Torso:FindFirstChild("Neck")

    if not Neck then
        return
    end

    local v31 = Neck:GetAttribute("Original")

    if not v31 then
        v31 = Neck.C0
        Neck:SetAttribute("Original", v31)
    end

    t_4[arg14] = {
        modelroot = arg14.PrimaryPart,
        head = arg14.Head,
        torso = Torso,
        neck = Neck,
        original = v31
    }
end

local function unregisterNPC(arg15) -- line: 383
    -- upvalues:
    --  [1] t_4 (copy)

    t_4[arg15] = nil
end

for _, val_1 in workspace.NPCS:QueryDescendants("Model") do
    registerNPC(val_1)
end

workspace.NPCS.ChildAdded:Connect(registerNPC)
workspace.NPCS.ChildRemoved:Connect(unregisterNPC)
local v32 = 0
RunService.Stepped:Connect(function(_, arg17) -- line: 397
    -- upvalues:
    --  [1] v32 (ref)
    --  [2] v6 (ref)
    --  [3] HumanoidRootPart (copy)
    --  [4] v7 (ref)
    --  [5] v4 (ref)
    --  [6] v5 (ref)
    --  [7] ChatBox (copy)
    --  [8] Chatting (copy)
    --  [9] ContextActionService (copy)
    --  [10] Typewriter_m (copy)
    --  [11] Container (copy)
    --  [12] clearChoices (copy)
    --  [13] v3 (copy)
    --  [14] t_4 (copy)

    v32 += arg17

    if v32 < 0.03333333333333333 then
        return
    end

    v32 = 0

    if v6 and v6.PrimaryPart then
        if math.clamp(v6:GetExtentsSize().Magnitude, 15, 30) < (HumanoidRootPart.Position - v6.PrimaryPart.Position).Magnitude then
            v7 += 1
            v6 = nil
            v4 = nil

            if v5 then
                v5.Enabled = not v5:GetAttribute("ServerDisabled")
            end

            ChatBox.Visible = false
            Chatting.Value = false
            ContextActionService:UnbindAction("ChatSkipKeys")
            Typewriter_m:Clean(Container)
            clearChoices()
        end
    end

    if not v3 or not v3.PrimaryPart then
        return
    end

    local Position = v3.PrimaryPart.Position

    for key_5, val_2 in t_4 do
        if not val_2.modelroot or not val_2.modelroot.Parent then
            t_4[key_5] = nil
        else
            local Neck_1 = val_2.neck
            local Original = val_2.original

            if (val_2.modelroot.Position - Position).Magnitude < 20 then
                Neck_1.C0 = Neck_1.C0:Lerp(
                    Original * CFrame.Angles(
                        0,
                        0,
                        (val_2.head.Position - Position).Unit:Cross(val_2.torso.CFrame.LookVector).Y
                    ),
                    0.1
                )
            else
                Neck_1.C0 = Neck_1.C0:Lerp(Original, 0.1)
            end
        end
    end
end)
