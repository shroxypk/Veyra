-- Decompiled with Veyra harvester
-- Instance: Workspace.pCharacters.yolitsff_si.FallDamage
-- Class: LocalScript
-- bytes: 4213

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("UserInputService")
local _, v3 = require(ReplicatedStorage.Modules.scriptObjs).GetPlayerCharacter()
local Humanoid = v3:WaitForChild("Humanoid")
local PrimaryPart = v3.PrimaryPart
local Animator = Humanoid:FindFirstChildWhichIsA("Animator")
local Values_m = require(script.Values)

local _ = function(arg1) --[[ CalculateDamage ]] -- line: 17
    -- upvalues:
    --  [1] Values_m (copy)

    if arg1 - Values_m.MinimumFallDamageStuds >= 0 then
        return arg1 * Values_m.DamageMultiplication + 10
    end

    return 0
end

local _ = function(arg2) --[[ getHumanoidState ]] -- line: 33
    return arg2:GetState()
end

local t = {
    [Enum.HumanoidStateType.Running] = true,
    [Enum.HumanoidStateType.RunningNoPhysics] = true,
    [Enum.HumanoidStateType.Climbing] = true,
    [Enum.HumanoidStateType.Ragdoll] = true,
    [Enum.HumanoidStateType.FallingDown] = true,
    [Enum.HumanoidStateType.Flying] = true,
    [Enum.HumanoidStateType.GettingUp] = true,
    [Enum.HumanoidStateType.Dead] = true,
    [Enum.HumanoidStateType.None] = true,
    [Enum.HumanoidStateType.Physics] = true,
    [Enum.HumanoidStateType.Swimming] = true,
    [Enum.HumanoidStateType.Seated] = true,
    [Enum.HumanoidStateType.PlatformStanding] = true
}
Humanoid.StateChanged:Connect(function(_, arg4) -- line: 54
    -- upvalues:
    --  [1] Values_m (copy)
    --  [2] PrimaryPart (copy)
    --  [3] Animator (copy)
    --  [4] ReplicatedStorage (copy)
    --  [5] v3 (copy)
    --  [6] Services_m (copy)

    if arg4 == Enum.HumanoidStateType.Landed then
        if Values_m.LastStandingPos then
            if math.abs(PrimaryPart.AssemblyLinearVelocity.Y) > 100 then
                Values_m.DontUpdateYet = true
                local v6 = math.clamp(
                    Values_m.LastStandingPos.Y - PrimaryPart.Position.Y,
                    0,
                    math.huge
                )
                local v7 = if v6 - Values_m.MinimumFallDamageStuds >= 0 then v6 * Values_m.DamageMultiplication + 10 else 0
                local v8 = v7

                if v6 > 15 then
                    v7 = v6 > 20 and ReplicatedStorage.Animations.Movement.Landing or ReplicatedStorage.Animations.Movement.SoftLanding
                    local v10 = Animator:LoadAnimation(v7)
                    v10.Stopped:Connect(function() -- line: 65
                        -- upvalues:
                        --  [1] v10 (ref)

                        v10:Destroy()
                        v10 = nil
                    end)
                    v10.Priority = Enum.AnimationPriority.Movement
                    v10:Play(0.15)
                end

                if v8 > 0 then
                    if not v3:GetAttribute("DisableFallDamage") then
                        script.Event:FireServer(v8, v6 > 250)

                        if v6 > 90 then
                            for _ = 1, 10 do
                                workspace.CurrentCamera.CoordinateFrame = workspace.CurrentCamera.CoordinateFrame * CFrame.new(
                                    Random.new():NextInteger(-500, 500) / 10000,
                                    Random.new():NextInteger(-500, 500) / 10000,
                                    0
                                ) * CFrame.Angles(
                                    math.rad(Random.new():NextInteger(-500, 500) / 10000, 0),
                                    0,
                                    (math.rad(Random.new():NextInteger(-500, 500) / 10000, 0))
                                )
                                Services_m.RunService.RenderStepped:Wait()
                            end
                        end
                    end
                end

                Values_m.DontUpdateYet = false
                v3:SetAttribute("DisableFallDamage", false)
            end
        end
    end
end)

while true do
    if t[Humanoid:GetState()] and not Values_m.DontUpdateYet then
        Values_m.LastStandingPos = PrimaryPart.Position
    end

    task.wait()
end
