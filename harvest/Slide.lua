-- Decompiled with Veyra harvester
-- Instance: Workspace.pCharacters.yolitsff_si.CharacterScripts.State Handler.Client.Slide
-- Class: ModuleScript
-- bytes: 10454

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Services_m = require(game:GetService("ReplicatedFirst").Services)
local Modules = ReplicatedStorage.Modules
local StateManager_m = require(Modules.StateManager)
local v2, v3 = require(Modules.scriptObjs).GetPlayerCharacter()
local Agility = v2:WaitForChild("Skills"):WaitForChild("Agility")
local Humanoid = v3:WaitForChild("Humanoid")
local Animator = Humanoid:WaitForChild("Animator")
local HumanoidRootPart = v3:WaitForChild("HumanoidRootPart")
local RootJoint = HumanoidRootPart:WaitForChild("RootJoint")
local v4 = StateManager_m.require(v3)
local t = {
    IsSliding = function(_) --[[ IsSliding ]] -- line: 200
        -- upvalues:
        --  [1] v4 (copy)

        return v4:IsSliding()
    end
}
local C0 = RootJoint.C0
local v5 = Animator:LoadAnimation(ReplicatedStorage.Animations.Movement.Sliding)
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
local t_1 = { workspace.Map, workspace.Terrain }
local MapMisc = workspace:FindFirstChild("MapMisc")

if MapMisc then
    table.insert(t_1, MapMisc)
end

raycastParams.FilterDescendantsInstances = t_1
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = 0

local _ = function() --[[ isLowHealth ]] -- line: 65
    -- upvalues:
    --  [1] Humanoid (copy)

    return Humanoid.Health < Humanoid.MaxHealth / 2
end

local _ = function() --[[ getCooldown ]] -- line: 69
    -- upvalues:
    --  [1] Humanoid (copy)

    if if not (Humanoid.Health < Humanoid.MaxHealth / 2) then false else true then
        return 1.25
    end

    return 1
end

local _ = function() --[[ getSlideDirection ]] -- line: 75
    -- upvalues:
    --  [1] HumanoidRootPart (copy)

    local LookVector = HumanoidRootPart.CFrame.LookVector
    local vec3 = Vector3.new(LookVector.X, 0, LookVector.Z)

    if vec3.Magnitude == 0 then
        return Vector3.new(0, 0, 0)
    end

    return vec3.Unit
end

local _ = function(n1: number) --[[ modifySlideSpeed ]] -- line: 91
    -- upvalues:
    --  [1] Humanoid (copy)
    --  [2] Agility (copy)
    --  [3] v4 (copy)

    n1 = if not (Humanoid.Health < Humanoid.MaxHealth / 2 and true) then n1 + Agility.Level.Value * 0.15 else n1 * 0.8 + Agility.Level.Value * 0.05

    if v4:HasState("slowEffect") then
        n1 *= 0.5
    end

    return (math.min(n1, 50))
end

local function getSlopeSpeed(u1: RaycastResult, vec1: Vector3) -- line: 106
    -- upvalues:
    --  [1] HumanoidRootPart (copy)

    local Normal = u1.Normal

    if Normal:Dot(Vector3.new(0, 1, 0)) >= 0.98 then
        return nil
    end

    local vec3_1 = Vector3.new(Normal.X, 0, Normal.Z)

    if vec3_1.Magnitude == 0 then
        return nil
    end

    local v15 = math.acos((math.clamp(vec1:Dot(vec3_1.Unit), -1, 1)))
    local v16 = u1.Instance
    local v18 = HumanoidRootPart.CFrame.LookVector:Dot(-v16.CFrame.LookVector)
    local v19 = math.deg(v15)
    local v20 = if v18 < HumanoidRootPart.CFrame.LookVector:Dot(v16.CFrame.LookVector) then Normal:Cross(
        v16.CFrame.RightVector
    ) else Normal:Cross(-v16.CFrame.RightVector)
    v20 = math.clamp(51 + (v20:Dot(Vector3.new(0, -1, 0)) * 10) ^ 2, 0, 80)

    if v19 > 90 then
        v20 *= 0.5
    end

    return v20
end

local function emitDust(u2: RaycastResult) -- line: 159
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Services_m (copy)

    if not u2.Instance then
        return
    end

    local v22 = u2.Instance
    local v23 = ReplicatedStorage.Effects.SlideDust:Clone()
    Services_m.Debris(v23, 2)
    v23.Dust.Color = ColorSequence.new(v22.Color)
    v23.Position = u2.Position
    v23.Parent = workspace.Effects

    for _, val in v23:QueryDescendants("ParticleEmitter") do
        val:Emit(val:GetAttribute("EmitCount") or 1)
    end
end

local _ = function() --[[ cleanup ]] -- line: 178
    -- upvalues:
    --  [1] v6 (ref)
    --  [2] v7 (ref)
    --  [3] v8 (ref)
    --  [4] Services_m (copy)
    --  [5] v5 (copy)
    --  [6] Humanoid (copy)
    --  [7] RootJoint (copy)
    --  [8] C0 (copy)

    if v6 then
        v6:Disconnect()
        v6 = nil
    end

    if v7 then
        v7:Destroy()
        v7 = nil
    end

    if v8 then
        Services_m.FadeSound(v8)
        v8 = nil
    end

    v5:Stop(0.1)
    Humanoid.AutoRotate = true
    RootJoint.C0 = C0
end

function t.IsOnCooldown(_) -- line: 204
    -- upvalues:
    --  [1] v9 (ref)

    return time() < v9
end

function t.CanStart(arg3) -- line: 208
    -- upvalues:
    --  [1] v4 (copy)

    local v25 = not arg3:IsSliding()

    if v25 then
        v25 = not arg3:IsOnCooldown()

        if v25 then
            v25 = v4:CanSlide()

            if v25 then
                v25 = v4:IsSprinting()
            end
        end
    end

    return v25
end

function t.Stop(_) -- line: 215
    -- upvalues:
    --  [1] v4 (copy)
    --  [2] v6 (ref)
    --  [3] v7 (ref)
    --  [4] v9 (ref)
    --  [5] Humanoid (copy)
    --  [6] v8 (ref)
    --  [7] Services_m (copy)
    --  [8] v5 (copy)
    --  [9] RootJoint (copy)
    --  [10] C0 (copy)

    if v4:IsSliding() then
        v4:RemoveState("Sliding")
    end

    if v6 or v7 then
        local v26 = time()
        local v28 = if not (Humanoid.Health < Humanoid.MaxHealth / 2 and true) then 1 else 1.25
        v9 = v26 + v28
    end

    if v6 then
        v6:Disconnect()
        v6 = nil
    end

    if v7 then
        v7:Destroy()
        v7 = nil
    end

    if v8 then
        Services_m.FadeSound(v8)
        v8 = nil
    end

    v5:Stop(0.1)
    Humanoid.AutoRotate = true
    RootJoint.C0 = C0
end

function t.TryStart(arg5) -- line: 227
    -- upvalues:
    --  [1] HumanoidRootPart (copy)
    --  [2] raycastParams (copy)
    --  [3] v6 (ref)
    --  [4] v7 (ref)
    --  [5] v8 (ref)
    --  [6] Services_m (copy)
    --  [7] v5 (copy)
    --  [8] Humanoid (copy)
    --  [9] RootJoint (copy)
    --  [10] C0 (copy)
    --  [11] v4 (copy)
    --  [12] getSlopeSpeed (copy)
    --  [13] Agility (copy)
    --  [14] ReplicatedStorage (copy)
    --  [15] RunService (copy)
    --  [16] emitDust (copy)

    if not arg5:CanStart() then
        return false
    end

    local v31 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -8, 0), raycastParams)

    if not v31 then
        return false
    end

    if v6 then
        v6:Disconnect()
        v6 = nil
    end

    if v7 then
        v7:Destroy()
        v7 = nil
    end

    if v8 then
        Services_m.FadeSound(v8)
        v8 = nil
    end

    v5:Stop(0.1)
    Humanoid.AutoRotate = true
    RootJoint.C0 = C0
    v4:AddState("Sliding")
    local LookVector_2 = HumanoidRootPart.CFrame.LookVector
    local vec3_2 = Vector3.new(LookVector_2.X, 0, LookVector_2.Z)
    local v36 = if vec3_2.Magnitude == 0 then Vector3.new(0, 0, 0) else vec3_2.Unit
    local v40

    if v36 == Vector3.new(0, 0, 0) then
        v4:RemoveState("Sliding")
        v40 = false

        return v40
    end

    v40 = 38
    v40 = getSlopeSpeed(v31, v36) or v40
    local v42 = v40
    v42 = if not (Humanoid.Health < Humanoid.MaxHealth / 2 and true) then v42 + Agility.Level.Value * 0.15 else v42 * 0.8 + Agility.Level.Value * 0.05

    if v4:HasState("slowEffect") then
        v42 *= 0.5
    end

    v40 = math.min(v42, 50)
    local v44 = ReplicatedStorage.SFX.Misc.Slide:Clone()
    v44.Parent = HumanoidRootPart
    v44:Play()
    v8 = v44
    v5:Play(0.2)
    local SlideVelocity_BodyVelocity = Instance.new("BodyVelocity")
    SlideVelocity_BodyVelocity.Name = "SlideVelocity"
    SlideVelocity_BodyVelocity.P = 100000
    SlideVelocity_BodyVelocity.MaxForce = Vector3.new(1000000, 0, 1000000)
    SlideVelocity_BodyVelocity.Velocity = v36 * v40
    SlideVelocity_BodyVelocity.Parent = HumanoidRootPart
    v7 = SlideVelocity_BodyVelocity
    local v54 = 0
    v6 = RunService.Heartbeat:Connect(function(deltaTime) -- line: 285
        -- upvalues:
        --  [1] v7 (ref)
        --  [2] arg5 (copy)
        --  [3] v4 (ref)
        --  [4] HumanoidRootPart (ref)
        --  [5] raycastParams (ref)
        --  [6] v54 (ref)
        --  [7] emitDust (ref)
        --  [8] v40 (ref)
        --  [9] SlideVelocity_BodyVelocity (copy)

        if not v7 or not v7.Parent then
            arg5:Stop()

            return
        end

        local LookVector_1, vec3_3

        if v4:IsSliding() then
            if not v4:CanSlide() then
                arg5:Stop()

                return
            end

            local v55 = workspace:Raycast(
                HumanoidRootPart.Position,
                Vector3.new(0, -10, 0),
                raycastParams
            )

            if not v55 then
                arg5:Stop()

                return
            end

            v54 += deltaTime

            if v54 >= 0.1 then
                v54 %= 0.1
                emitDust(v55)
            end

            v40 = math.max(v40 - 16 * deltaTime, 0)

            if v40 <= 0 then
                arg5:Stop()

                return
            end

            LookVector_1 = HumanoidRootPart.CFrame.LookVector
            vec3_3 = Vector3.new(LookVector_1.X, 0, LookVector_1.Z)
            v55 = if vec3_3.Magnitude == 0 then Vector3.new(0, 0, 0) else vec3_3.Unit

            if v55 == Vector3.new(0, 0, 0) then
                arg5:Stop()

                return
            end

            SlideVelocity_BodyVelocity.Velocity = v55 * v40

            return
        else
            arg5:Stop()

            return
        end
    end)

    return true
end

function t.Jump(arg7) -- line: 338
    -- upvalues:
    --  [1] v4 (copy)
    --  [2] HumanoidRootPart (copy)
    --  [3] Services_m (copy)

    if not v4:IsSliding() then
        return false
    end

    arg7:Stop()

    for _, val_1 in HumanoidRootPart:QueryDescendants("BodyMover[Name=\"SlideVelocity\"]") do
        val_1:Destroy()
    end

    local DragBV_BodyVelocity = Instance.new("BodyVelocity")
    DragBV_BodyVelocity.Name = "DragBV"
    DragBV_BodyVelocity.P = 100000
    DragBV_BodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
    DragBV_BodyVelocity.Velocity = HumanoidRootPart.CFrame.LookVector * 45 + Vector3.new(0, 22, 0)
    DragBV_BodyVelocity.Parent = HumanoidRootPart
    Services_m.Debris(DragBV_BodyVelocity, 0.2)

    return true
end

function t.Destroy(arg8) -- line: 362
    arg8:Stop()
end

return t
