-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.KnockbackFunction
-- Class: ModuleScript
-- bytes: 4588

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("ServerStorage")
local _ = game:GetService("RunService")
local _ = game:GetService("TweenService")
local StateManager_m = require(ReplicatedStorage.Modules.StateManager)
local v2 = Services_m.Cast:Get("GetSurface")
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map }
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.IgnoreWater = true

local function Knockback(arg1, arg2, arg3) -- line: 17
    -- upvalues:
    --  [1] StateManager_m (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] raycastParams (copy)
    --  [4] v2 (copy)

    local PrimaryPart = arg1.PrimaryPart
    local PrimaryPart_1 = arg2.PrimaryPart

    if not PrimaryPart or not PrimaryPart_1 then
        return
    end

    local v3 = StateManager_m.require(arg2)
    local Humanoid = arg2.Humanoid
    local v4 = PrimaryPart_1.CFrame.LookVector * -2
    local v5 = PrimaryPart.CFrame.LookVector * (arg3 or 40)
    v3:AddState("Stunned")
    v3:AddState("KnockSlide")
    ReplicatedStorage.Remotes.Client.ClientVFX:FireAllClients(
        "KnockSlide",
        nil,
        arg2,
        PrimaryPart_1
    )
    task.wait()
    local v8 = true
    local LaunchBV_BodyVelocity = Instance.new("BodyVelocity")
    LaunchBV_BodyVelocity.Name = "LaunchBV"
    LaunchBV_BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
    LaunchBV_BodyVelocity.Velocity = v5
    local v9 = Humanoid.Animator:LoadAnimation(ReplicatedStorage.Animations.Hit.Knockback)
    v9.Priority = Enum.AnimationPriority.Action3
    v9.Stopped:Once(function() -- line: 49
        -- upvalues:
        --  [1] v8 (ref)
        --  [2] LaunchBV_BodyVelocity (copy)
        --  [3] v3 (copy)

        if v8 then
            v8 = nil
        end

        LaunchBV_BodyVelocity:Destroy()
        v3:RemoveState("Stunned")
        v3:RemoveState("KnockSlide")
    end)
    v9:Play(0.2)
    v9.TimePosition = 0.4
    task.wait()
    LaunchBV_BodyVelocity.Parent = PrimaryPart_1

    if not v3:HasState("SmashCooldown") then
        local v17

        while v8 do
            local v11 = workspace:Raycast(PrimaryPart_1.Position, v4, raycastParams)

            if v11 then
                local Position = v11.Position
                local _ = v11.Material
                local Normal = v11.Normal
                local v12 = v2(Position, v11.Instance)
                local _ = v11.Instance

                if not PrimaryPart_1 or (Humanoid.Health <= 0 or (v12 == "Top" or v12 == "Bottom")) then
                    break
                end

                LaunchBV_BodyVelocity:Destroy()
                PrimaryPart_1.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                PrimaryPart_1.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                PrimaryPart_1.Anchored = true
                v9:Stop(0)
                local v14 = Humanoid.Animator:LoadAnimation(ReplicatedStorage.Animations.Hit.Downed)
                v14:Play(0)
                ReplicatedStorage.Remotes.Combat:FireAllClients("Dizzy", arg2)
                ReplicatedStorage.Remotes.Combat:FireAllClients(
                    "GroundContact",
                    arg2,
                    v11.Instance,
                    v11.Position,
                    CFrame.new(Position, Position + Normal)
                )
                PrimaryPart_1.CFrame = CFrame.new(Position, Position + Normal) * CFrame.Angles(
                    0,
                    6.283185307179586,
                    0
                ) * CFrame.new(0, 0, -0.15)
                v3:AddState("Stunned", 2)
                v17 = arg2.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Animations.Hit.Dizzy)
                v17:Play()
                v17:AdjustSpeed(1)
                task.delay(1.25, function() -- line: 103
                    -- upvalues:
                    --  [1] v17 (copy)
                    --  [2] v3 (copy)

                    v17:Stop(0.25)
                    v3:RemoveState("Stunned")
                end)
                v3:AddState("SmashCooldown", 5)
                Humanoid.AutoRotate = false
                task.wait(0.5)
                v14:Stop(0.1)
                PrimaryPart_1.Anchored = false
                Humanoid.AutoRotate = true
                break
            end

            task.wait()
        end
    end

    Humanoid.AutoRotate = true
end

return Knockback
