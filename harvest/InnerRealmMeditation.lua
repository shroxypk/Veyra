-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.InnerRealmMeditation
-- Class: LocalScript
-- bytes: 3527

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local v1 = nil
pcall(function() -- line: 13
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] LocalPlayer (copy)

    v1 = require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls()
end)
local v2 = false
UserInputService.JumpRequest:Connect(function() -- line: 18
    -- upvalues:
    --  [1] v2 (ref)

    v2 = true
end)

local _ = function(arg1) --[[ wantsToMove ]] -- line: 22
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] v1 (ref)

    if v2 then
        return true
    end

    if v1 then
        return v1:GetMoveVector().Magnitude > 0.1 and true
    end

    return arg1.MoveDirection.Magnitude > 0.1
end

local Meditate = ReplicatedStorage.Animations.Emotes:WaitForChild("Meditate")
local ChatObject = ReplicatedStorage.Remotes:WaitForChild("ChatObject")
local v4 = false

local function meditate(u1: userdata) -- line: 39
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] v4 (ref)
    --  [3] Meditate (copy)
    --  [4] v2 (ref)
    --  [5] v1 (ref)

    local Character = LocalPlayer.Character
    local v5 = Character

    if v5 then
        v5 = Character:FindFirstChildOfClass("Humanoid")
    end

    local v6 = Character

    if v6 then
        v6 = Character:FindFirstChild("HumanoidRootPart")
    end

    local v7 = v5

    if v7 then
        v7 = v5:FindFirstChildOfClass("Animator")
    end

    if not v7 or not v6 or v5.Health <= 0 then
        return
    end

    local Bin = LocalPlayer:FindFirstChild("bin")
    local v8 = Bin

    if v8 then
        v8 = Bin:FindFirstChild("Chatting")
    end

    if not v8 or v8.Value then
        return
    end

    v4 = true
    Character:SetAttribute("Meditating", true)
    v6.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    v6.Anchored = true
    local v9 = v7:LoadAnimation(Meditate)
    v9.Priority = Enum.AnimationPriority.Action4
    v9.Looped = true
    v9:Play(0.3)
    v7 = os.clock()

    while true do
        if v8.Value then
            break
        end

        if not (os.clock() - v7 < 5) then
            break
        end

        task.wait()
    end

    v7 = false
    v2 = false
    local v10

    while true do
        if not v8.Value then
            break
        end

        task.wait()

        if not Character.Parent or (v5.Health <= 0 or not u1.Parent) then
            break
        end

        if v2 then
            v10 = true
        elseif v1 then
            local _ = u1.Parent
            v10 = v1:GetMoveVector().Magnitude > 0.1 and true
        else
            v10 = v5.MoveDirection.Magnitude > 0.1 and true
        end

        if not v10 then
            continue
        end

        v7 = true
        break
    end

    Character:SetAttribute("Meditating", false)
    v9:Stop(0.3)
    v6.Anchored = false
    v2 = false

    if v7 and v8.Value and _G.EndDialogue then
        _G.EndDialogue()
    end

    v4 = false
end

ChatObject.OnClientEvent:Connect(function(arguments) -- line: 97
    -- upvalues:
    --  [1] v4 (ref)
    --  [2] meditate (copy)

    if not v4 then
        if typeof(arguments) == "Instance" then
            if not arguments:HasTag("MeditationSpot") then
                return
            end

            meditate(arguments)

            return
        else
            return
        end
    else
        return
    end
end)
