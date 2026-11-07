-- Decompiled with Veyra harvester
-- Instance: Workspace.pCharacters.yolitsff_si.CharacterScripts.State Handler.Client.Crouch
-- Class: ModuleScript
-- bytes: 2431

local v1 = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage.Modules
local Packets_m = require(Modules.Packets)
local StateManager_m = require(Modules.StateManager)
local CreateBindableAction_m = require(Modules.CreateBindableAction)
local t = {}
local LocalPlayer = v1.LocalPlayer
v1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Animator = v1:WaitForChild("Humanoid"):WaitForChild("Animator")
local Crouch = LocalPlayer:WaitForChild("Binds"):WaitForChild("Crouch")
local v2 = StateManager_m.require(v1)
local v3 = Animator:LoadAnimation(ReplicatedStorage.Animations.Movement.CrouchIdle)
v3.Priority = Enum.AnimationPriority.Movement
local v4 = nil

function t.StartCrouching(_) -- line: 31
    -- upvalues:
    --  [1] v2 (copy)
    --  [2] Packets_m (copy)

    if not v2:CanCrouch() then
        return
    end

    Packets_m.Combat.packets.CrouchInput.send({ Action = "Start Crouching" })
end

function t.StopCrouching(_) -- line: 41
    -- upvalues:
    --  [1] v2 (copy)
    --  [2] Packets_m (copy)

    if not v2:IsCrouching() then
        return
    end

    Packets_m.Combat.packets.CrouchInput.send({ Action = "Stop Crouching" })
end

function t.SetSlideHandler(_: table, f1: (...any) -> ...any) -- line: 51
    -- upvalues:
    --  [1] v4 (ref)

    v4 = f1
end

local function crouchAction(_: string, arg3: any, _: userdata) -- line: 55
    -- upvalues:
    --  [1] v2 (copy)
    --  [2] t (copy)
    --  [3] v4 (ref)

    if arg3 ~= Enum.UserInputState.Begin then
        return
    end

    if v2:CanCrouch() then
        t:StartCrouching()

        return
    end

    t:StopCrouching()

    if v2:CanSlide() and v2:IsSprinting() and v4 then
        v4()
    end
end

function t.Start(_) -- line: 76
    -- upvalues:
    --  [1] CreateBindableAction_m (copy)
    --  [2] Crouch (copy)
    --  [3] crouchAction (copy)
    --  [4] v2 (copy)
    --  [5] v3 (copy)

    CreateBindableAction_m("Crouch", Crouch, crouchAction)
    v2:ObserveReplicatedStateAdded(function(arg5) -- line: 84
        -- upvalues:
        --  [1] v3 (ref)

        if arg5 == "Crouching" then
            v3:Play(0.1)
        end
    end)
    v2:ObserveReplicatedStateRemoved(function(arg6) -- line: 90
        -- upvalues:
        --  [1] v3 (ref)

        if arg6 == "Crouching" then
            v3:Stop(0.1)
        end
    end)
end

return t
