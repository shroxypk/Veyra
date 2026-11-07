-- Decompiled with Veyra harvester
-- Instance: Workspace.pCharacters.yolitsff_si.Animate.Tilt
-- Class: LocalScript
-- bytes: 1543

local _ = game:GetService("Players")
local RunService = game:GetService("RunService")
local _, v2 = require(game:GetService("ReplicatedStorage").Modules.scriptObjs).GetPlayerCharacter()
local HumanoidRootPart = v2.HumanoidRootPart
local Torso = v2.Torso
local RootJoint = HumanoidRootPart.RootJoint
local LeftHip = Torso["Left Hip"]
local RightHip = Torso["Right Hip"]

local _ = function(arg1, arg2, arg3) --[[ Lerp ]] -- line: 20
    return arg1 + (arg2 - arg1) * arg3
end

local v3 = nil
local Unit = nil
local v5 = 0
local v6 = 0
local C0 = RootJoint.C0
local C0_1 = LeftHip.C0
local C0_2 = RightHip.C0
RunService.RenderStepped:Connect(function() -- line: 33
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] HumanoidRootPart (copy)
    --  [3] Unit (ref)
    --  [4] v5 (ref)
    --  [5] v6 (ref)
    --  [6] RootJoint (copy)
    --  [7] C0 (copy)
    --  [8] LeftHip (copy)
    --  [9] C0_1 (copy)
    --  [10] RightHip (copy)
    --  [11] C0_2 (copy)

    v3 = HumanoidRootPart.Velocity * Vector3.new(1, 0, 1)

    if v3.Magnitude > 0.001 then
        Unit = v3.Unit
        v5 = HumanoidRootPart.CFrame.RightVector:Dot(Unit)
        v6 = HumanoidRootPart.CFrame.LookVector:Dot(Unit)
    else
        v5 = 0
        v6 = 0
    end

    RootJoint.C0 = RootJoint.C0:Lerp(
        C0 * CFrame.Angles(math.rad(v6 * 3), math.rad(-v5 * 5), 0),
        0.2
    )
    LeftHip.C0 = LeftHip.C0:Lerp(C0_1 * CFrame.Angles(math.rad(v5 * 3.5), 0, 0), 0.2)
    RightHip.C0 = RightHip.C0:Lerp(C0_2 * CFrame.Angles(math.rad(-v5 * 3.5), 0, 0), 0.2)
end)
