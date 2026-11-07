-- Decompiled with Veyra harvester
-- Instance: Workspace.pCharacters.yolitsff_si.CharacterScripts.State Handler.Client
-- Class: LocalScript
-- bytes: 1946

local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Modules = ReplicatedStorage.Modules
local StateManager_m = require(Modules.StateManager)
local v1, v2 = require(Modules.scriptObjs).GetPlayerCharacter()
local _ = v2:WaitForChild("Humanoid"):WaitForChild("Animator")
local _ = v2:WaitForChild("HumanoidRootPart")
local _ = v1:WaitForChild("Settings")
local _ = v1:WaitForChild("Binds")
local v3 = StateManager_m.require(v2)
local Sprint_m = require(script.Sprint)
local Dash_m = require(script.Dash)
local Crouch_m = require(script.Crouch)
local Slide_m = require(script.Slide)
Dash_m.new():Start()
local v4 = Sprint_m.new()
v4:Start()
Crouch_m:SetSlideHandler(function() -- line: 35
    -- upvalues:
    --  [1] Slide_m (copy)

    Slide_m:TryStart()
end)
Crouch_m:Start()
local t = {
    Swimming = true,
    Stunned = true,
    Blocking = true,
    SwordBlocking = true,
    Ragdoll = true,
    Detained = true,
    Parrying = true,
    Swinging = true,
    Parried = true
}
local t_1 = {
    Stunned = true,
    Blocking = true,
    SwordBlocking = true,
    Ragdoll = true,
    Detained = true,
    Parrying = true,
    Swinging = true,
    Parried = true,
    Sprinting = true,
    Dodging = true
}
v3:ObserveReplicatedStateAdded(function(arg1) -- line: 66
    -- upvalues:
    --  [1] Crouch_m (copy)
    --  [2] t_1 (copy)
    --  [3] t (copy)
    --  [4] v4 (copy)

    if arg1 == "Crouching" then
        Crouch_m:StartCrouching()
    end

    if t_1[arg1] then
        Crouch_m:StopCrouching()
    end

    if t[arg1] then
        v4:StopSprinting()
    end
end)
UserInputService.JumpRequest:Connect(function() -- line: 80
    -- upvalues:
    --  [1] Crouch_m (copy)
    --  [2] Slide_m (copy)

    Crouch_m:StopCrouching()
    Slide_m:Jump()
end)
require(script.Climb):Start()
