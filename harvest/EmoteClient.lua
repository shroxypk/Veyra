-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Emotes.EmoteClient
-- Class: LocalScript
-- bytes: 8367

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local _ = game:GetService("CollectionService")
local _ = game:GetService("UserInputService")
local _ = game:GetService("ContextActionService")
local MarketplaceService = game:GetService("MarketplaceService")
local StateManager_m = require(ReplicatedStorage.Modules.StateManager)
local CreateBindableAction_m = require(ReplicatedStorage.Modules.CreateBindableAction)
local v2, v3 = require(ReplicatedStorage.Modules.scriptObjs).GetPlayerCharacter()
local mouse = v2:GetMouse()
local v4 = StateManager_m.require(v3)
local Binds = v2:WaitForChild("Binds")
local Bin = v2:WaitForChild("bin")
local Emoting = v3:WaitForChild("States").Emoting
local Humanoid = v3:WaitForChild("Humanoid")
local HumanoidRootPart = v3:WaitForChild("HumanoidRootPart")
local WeldConstraint = Instance.new("WeldConstraint")
local ProxyPart_Part = Instance.new("Part")
ProxyPart_Part.Name = "ProxyPart"
ProxyPart_Part.Anchored = false
ProxyPart_Part.Transparency = 0
ProxyPart_Part.CanCollide = false
ProxyPart_Part.CanQuery = false
ProxyPart_Part.CanTouch = false
WeldConstraint.Parent = ProxyPart_Part
local Parent = script.Parent
local ScrollingFrame = Parent.Buttons.ScrollingFrame
local Preview = Parent.Preview
local PreviewCharacter = Preview.WorldModel.PreviewCharacter
local UIGridLayout = ScrollingFrame.UIGridLayout
UIGridLayout.Changed:Connect(function() -- line: 45
    -- upvalues:
    --  [1] UIGridLayout (copy)
    --  [2] ScrollingFrame (copy)

    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIGridLayout.AbsoluteContentSize.Y + 30)
end)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include
local t = {}
local t_1 = {}

for _, descendant in ReplicatedStorage.Animations.Emotes:GetDescendants() do
    if descendant:IsA("Animation") then
        if descendant.Parent == ReplicatedStorage.Animations.Emotes.EmotePack1 then
            t_1[descendant.Name] = 2
        elseif descendant.Parent == ReplicatedStorage.Animations.Emotes.EmotePack2 then
            t_1[descendant.Name] = 3
        elseif descendant:GetAttribute("Weld") then
            t_1[descendant.Name] = "weld"
        else
            t_1[descendant.Name] = false
        end
    end
end

local t_2 = {
    Spit = script.Spit,
    ["Flashy Poses"] = script.Paparazzi,
    Laugh = script.Laugh,
    ["Silly Dance"] = script.CartoonRun
}
local v6 = Services_m.Maid.new()

function StopEmoting() -- line: 82
    -- upvalues:
    --  [1] v6 (copy)
    --  [2] Emoting (copy)
    --  [3] t (copy)
    --  [4] Humanoid (copy)

    v6:Destroy()
    Emoting.Value = false

    for _, val in t do
        val:Stop(0.1)
    end

    Humanoid.AutoRotate = true
end

function StopSounds() -- line: 94
    -- upvalues:
    --  [1] t_2 (copy)

    for _, val_1 in t_2 do
        val_1:Stop(0.1)
    end
end

local function createButton(arg1, arg2) -- line: 100
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] t (copy)
    --  [3] Humanoid (copy)
    --  [4] t_1 (copy)
    --  [5] v2 (copy)
    --  [6] MarketplaceService (copy)
    --  [7] v4 (copy)
    --  [8] t_2 (copy)
    --  [9] Emoting (copy)
    --  [10] HumanoidRootPart (copy)
    --  [11] raycastParams (copy)
    --  [12] v6 (copy)
    --  [13] RunService (copy)
    --  [14] PreviewCharacter (copy)
    --  [15] Preview (copy)
    --  [16] ScrollingFrame (copy)

    local v7 = script.Template:Clone()
    v7.Name = arg1
    v7.Text = arg1
    local v8 = arg2

    if typeof(arg2) ~= "number" or not v8 then
        v8 = 1
    end

    v7.LayoutOrder = v8
    v8 = ReplicatedStorage.Animations.Emotes:FindFirstChild(arg1, true)
    local v9 = v8
    local v10 = t

    if v9 then
        v9 = Humanoid:LoadAnimation(v8)
    end

    v10[arg1] = v9

    if t[arg1] then
        t[arg1].Priority = Enum.AnimationPriority.Action
    end

    local function mouseClick() -- line: 112
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] t_1 (ref)
        --  [3] t (ref)
        --  [4] v2 (ref)
        --  [5] MarketplaceService (ref)
        --  [6] v4 (ref)
        --  [7] t_2 (ref)
        --  [8] Emoting (ref)
        --  [9] HumanoidRootPart (ref)
        --  [10] raycastParams (ref)
        --  [11] Humanoid (ref)
        --  [12] v6 (ref)
        --  [13] RunService (ref)

        local v11 = arg1
        local v12 = t_1[v11]
        local v13 = t[v11]

        if not v2.Gamepasses.EmotePack.Value and v12 == 2 then
            MarketplaceService:PromptGamePassPurchase(v2, 83806155)

            return
        end

        if not v2.Gamepasses.EmotePack2.Value and v12 == 3 then
            MarketplaceService:PromptGamePassPurchase(v2, 152217782)

            return
        end

        if not v4:CanEmote() then
            return
        end

        StopEmoting()
        StopSounds()

        if t_2[v11] then
            t_2[v11]:Play(0.1)
            v13.Stopped:Once(function() -- line: 136
                -- upvalues:
                --  [1] t_2 (ref)
                --  [2] v11 (copy)

                t_2[v11]:Stop()
            end)
        end

        Emoting.Value = true

        if v12 == "weld" then
            local v14 = workspace:Spherecast(
                HumanoidRootPart.Position,
                1.5,
                Vector3.new(0, -4.5, 0),
                raycastParams
            )

            if v14 then
                if v14.Instance then
                    local _, _, _ = HumanoidRootPart.CFrame:ToEulerAnglesXYZ()
                    v13:Play(0.1)
                    Humanoid.AutoRotate = false
                    v6:GiveTask(Humanoid.Changed:Connect(function() -- line: 153
                        -- upvalues:
                        --  [1] Humanoid (ref)

                        if Humanoid.AutoRotate == true or Humanoid.Jump then
                            StopEmoting()
                        end
                    end))
                else
                    StopEmoting()
                end
            else
                StopEmoting()
            end
        else
            v13:Play(0.1)
        end

        v6:GiveTask(Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function() -- line: 164
            -- upvalues:
            --  [1] Humanoid (ref)

            if Humanoid.MoveDirection.Magnitude > 0 then
                StopEmoting()
            end
        end))
        v6:GiveTask(RunService.Heartbeat:Connect(function() -- line: 169
            -- upvalues:
            --  [1] v4 (ref)

            if not v4:CanEmote() then
                StopEmoting()
            end
        end))
    end

    local function mouseEnter() -- line: 176
        -- upvalues:
        --  [1] PreviewCharacter (ref)
        --  [2] ReplicatedStorage (ref)
        --  [3] arg1 (copy)
        --  [4] Preview (ref)

        local Animator = PreviewCharacter.Humanoid.Animator

        for _, val_2 in Animator:GetPlayingAnimationTracks() do
            val_2:Stop()
        end

        local v21 = ReplicatedStorage.Animations.Emotes:FindFirstChild(arg1, true)

        if v21 then
            Animator:LoadAnimation(v21):Play(0.1)
            Preview.Visible = true
        end
    end

    local function mouseLeave() -- line: 193
        -- upvalues:
        --  [1] Preview (ref)

        Preview.Visible = false
    end

    v7.MouseButton1Click:Connect(mouseClick)
    v7.MouseEnter:Connect(mouseEnter)
    v7.MouseLeave:Connect(mouseLeave)
    v7.Parent = ScrollingFrame
end

for key_4, val_3 in t_1 do
    createButton(key_4, val_3)
end

local function emoteAction(_, arg4, _) -- line: 209
    -- upvalues:
    --  [1] Bin (copy)
    --  [2] Parent (copy)
    --  [3] mouse (copy)

    if Bin.Chatting.Value or Bin.Event.Value ~= "" then
        return
    end

    if arg4 == Enum.UserInputState.Begin then
        Parent.Visible = true
        Parent.Position = UDim2.new(0, mouse.X, 0.5, 0)

        return
    end

    if arg4 == Enum.UserInputState.End then
        Parent.Visible = false
    end
end

CreateBindableAction_m("Emote", Binds:WaitForChild("Emotes"), emoteAction)
