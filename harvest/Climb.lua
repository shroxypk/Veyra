-- Decompiled with Veyra harvester
-- Instance: Workspace.pCharacters.yolitsff_si.CharacterScripts.State Handler.Client.Climb
-- Class: ModuleScript
-- bytes: 17418

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local _ = require(game:GetService("ReplicatedFirst").Services)
local Modules = ReplicatedStorage.Modules
local StateManager_m = require(Modules.StateManager)
local v2, v3 = require(Modules.scriptObjs).GetPlayerCharacter()
local Agility = v2:WaitForChild("Skills"):WaitForChild("Agility")
local Humanoid = v3:WaitForChild("Humanoid")
local Animator = Humanoid:WaitForChild("Animator")
local HumanoidRootPart = v3:WaitForChild("HumanoidRootPart")
local v4 = StateManager_m.require(v3)
local t = {
    IsClimbing = function(_) --[[ IsClimbing ]] -- line: 240
        -- upvalues:
        --  [1] v4 (copy)

        return v4:IsClimbing()
    end
}
local KeyCode_Space = Enum.KeyCode.Space
local KeyCode_ButtonA = Enum.KeyCode.ButtonA
local t_1 = { Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.D, Enum.KeyCode.ButtonL2 }
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
local t_2 = { workspace.Map, workspace.Terrain }
local MapMisc = workspace:FindFirstChild("MapMisc")

if MapMisc then
    table.insert(t_2, MapMisc)
end

raycastParams.FilterDescendantsInstances = t_2
local raycastParams_1 = RaycastParams.new()
raycastParams_1.FilterType = Enum.RaycastFilterType.Include
raycastParams_1.IgnoreWater = true
local LadderParts = workspace.Map:FindFirstChild("LadderParts")

if LadderParts then
    raycastParams_1.FilterDescendantsInstances = { LadderParts }
end

local v5 = Animator:LoadAnimation(ReplicatedStorage.Animations.Movement.ClimbUp)
local v6 = Animator:LoadAnimation(ReplicatedStorage.Animations.Movement.ClimbLedge)
local v7 = Animator:LoadAnimation(ReplicatedStorage.Animations.Movement.WallBounce)
local ClimbGyro_BodyGyro = Instance.new("BodyGyro")
ClimbGyro_BodyGyro.Name = "Climb Gyro"
ClimbGyro_BodyGyro.CFrame = CFrame.new()
ClimbGyro_BodyGyro.D = 100
ClimbGyro_BodyGyro.MaxTorque = Vector3.new(1, 1, 1) * math.huge
ClimbGyro_BodyGyro.P = 3000
local t_3 = {}
local v8 = nil
local v9 = nil
local v10 = true
local v11 = false
local v12 = 0

local _ = function() --[[ isLowHealth ]] -- line: 114
    -- upvalues:
    --  [1] Humanoid (copy)

    return Humanoid.Health < Humanoid.MaxHealth / 2
end

local _ = function() --[[ getClimbSpeed ]] -- line: 118
    -- upvalues:
    --  [1] Humanoid (copy)
    --  [2] Agility (copy)
    --  [3] v3 (copy)

    local v14 = Humanoid.Health < Humanoid.MaxHealth / 2 and true
    local v15 = if not v14 then 0.5 else 0.3
    v14 = Agility.Level.Value * v15

    if v3:FindFirstChild("Climbing Mastery") then
        v14 *= 1.15
    end

    return 24 + v14
end

local function hasMovementInput() -- line: 129
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] UserInputService (copy)

    for _, val in t_1 do
        if UserInputService:IsKeyDown(val) then
            return true
        end

        if UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, val) then
            return true
        end
    end

    return false
end

local function clearClimbVelocity() -- line: 146
    -- upvalues:
    --  [1] v9 (ref)
    --  [2] HumanoidRootPart (copy)

    if v9 then
        v9:Destroy()
        v9 = nil
    end

    for _, child in HumanoidRootPart:GetChildren() do
        if child:IsA("BodyVelocity") and child.Name == "ClimbVelocity" then
            child:Destroy()
        end
    end
end

local _ = function() --[[ createClimbVelocity ]] -- line: 159
    -- upvalues:
    --  [1] clearClimbVelocity (copy)
    --  [2] HumanoidRootPart (copy)
    --  [3] v9 (ref)

    clearClimbVelocity()
    local ClimbVelocity_BodyVelocity = Instance.new("BodyVelocity")
    ClimbVelocity_BodyVelocity.Name = "ClimbVelocity"
    ClimbVelocity_BodyVelocity.MaxForce = Vector3.new(1, 1, 1) * math.huge
    ClimbVelocity_BodyVelocity.P = 1000
    ClimbVelocity_BodyVelocity.Parent = HumanoidRootPart
    v9 = ClimbVelocity_BodyVelocity

    return ClimbVelocity_BodyVelocity
end

local _ = function() --[[ playClimbSound ]] -- line: 173
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] HumanoidRootPart (copy)

    local v16 = ReplicatedStorage.SFX.Movement.Climb:Clone()
    v16.PlayOnRemove = true
    v16.Parent = HumanoidRootPart
    v16:Destroy()
end

local _ = function() --[[ getWall ]] -- line: 181
    -- upvalues:
    --  [1] HumanoidRootPart (copy)
    --  [2] raycastParams (copy)

    return workspace:Raycast(
        HumanoidRootPart.Position,
        HumanoidRootPart.CFrame.LookVector * 3,
        raycastParams
    )
end

local _ = function(vec1: Vector3) --[[ getFlatNormal ]] -- line: 190
    if math.abs(vec1.Y) > 0.5 then
        return nil
    end

    return Vector3.new(vec1.X, 0, vec1.Z).Unit
end

local _ = function(vec2: Vector3) --[[ faceWall ]] -- line: 198
    -- upvalues:
    --  [1] ClimbGyro_BodyGyro (copy)
    --  [2] HumanoidRootPart (copy)

    ClimbGyro_BodyGyro.CFrame = CFrame.lookAt(Vector3.new(0, 0, 0), -vec2)
    ClimbGyro_BodyGyro.Parent = HumanoidRootPart
end

local function hasLedge(vec3: Vector3, vec4: Vector3) -- line: 205
    -- upvalues:
    --  [1] HumanoidRootPart (copy)
    --  [2] raycastParams (copy)

    local Position = HumanoidRootPart.Position
    local v19 = Position.Y + 5

    if workspace:Raycast(Vector3.new(Position.X, v19, Position.Z), -vec4 * 4, raycastParams) then
        return false
    end

    local v22 = workspace:Raycast(
        Vector3.new(vec3.X, v19, vec3.Z) - vec4 * 1,
        Vector3.new(0, -6, 0),
        raycastParams
    )

    return if v22 ~= nil then v22.Normal.Y >= 0.7 else false
end

local _ = function() --[[ stopActiveConnection ]] -- line: 233
    -- upvalues:
    --  [1] v8 (ref)

    if v8 then
        v8:Disconnect()
        v8 = nil
    end
end

function t.CanClimb(_) -- line: 244
    -- upvalues:
    --  [1] v10 (ref)
    --  [2] v4 (copy)

    return v10 and v4:CanClimb() or v4:IsSwimming()
end

function t.Stop(_) -- line: 249
    -- upvalues:
    --  [1] v12 (ref)
    --  [2] v8 (ref)
    --  [3] clearClimbVelocity (copy)
    --  [4] ClimbGyro_BodyGyro (copy)
    --  [5] Humanoid (copy)
    --  [6] v5 (copy)
    --  [7] v4 (copy)

    v12 += 1

    if v8 then
        v8:Disconnect()
        v8 = nil
    end

    clearClimbVelocity()
    ClimbGyro_BodyGyro.Parent = nil
    Humanoid.AutoRotate = true
    Humanoid.PlatformStand = false
    v5:Stop(0.25)

    if v4:IsClimbing() then
        v4:RemoveState("Climbing")
    end
end

function t.LedgeClimb(t1: table, vec5: Vector3) -- line: 267
    -- upvalues:
    --  [1] v11 (ref)
    --  [2] v12 (ref)
    --  [3] v8 (ref)
    --  [4] clearClimbVelocity (copy)
    --  [5] v4 (copy)
    --  [6] Humanoid (copy)
    --  [7] ClimbGyro_BodyGyro (copy)
    --  [8] HumanoidRootPart (copy)
    --  [9] v5 (copy)
    --  [10] v6 (copy)
    --  [11] v9 (ref)

    if v11 then
        return false
    end

    v11 = true
    v12 += 1
    local v25 = v12

    if v8 then
        v8:Disconnect()
        v8 = nil
    end

    clearClimbVelocity()

    if not v4:IsClimbing() then
        v4:AddState("Climbing")
    end

    Humanoid.AutoRotate = false
    Humanoid.PlatformStand = true
    ClimbGyro_BodyGyro.CFrame = CFrame.lookAt(Vector3.new(0, 0, 0), -vec5)
    ClimbGyro_BodyGyro.Parent = HumanoidRootPart
    v5:Stop()
    v6:Play(0, nil, 0.7)
    clearClimbVelocity()
    local BodyVelocity_1 = Instance.new("BodyVelocity")
    BodyVelocity_1.Name = "ClimbVelocity"
    BodyVelocity_1.MaxForce = Vector3.new(1, 1, 1) * math.huge
    BodyVelocity_1.P = 1000
    BodyVelocity_1.Parent = HumanoidRootPart
    v9 = BodyVelocity_1
    BodyVelocity_1.Velocity = HumanoidRootPart.CFrame.LookVector * 15 + Vector3.new(0, 39, 0)
    task.delay(0.25, function() -- line: 299
        -- upvalues:
        --  [1] v25 (copy)
        --  [2] v12 (ref)
        --  [3] t1 (copy)

        if v25 ~= v12 then
            return
        end

        t1:Stop()
    end)

    return true
end

function t.WallBounce(arg4) -- line: 310
    -- upvalues:
    --  [1] v12 (ref)
    --  [2] clearClimbVelocity (copy)
    --  [3] HumanoidRootPart (copy)
    --  [4] v9 (ref)
    --  [5] v7 (copy)
    --  [6] Humanoid (copy)
    --  [7] Agility (copy)
    --  [8] v3 (copy)

    v12 += 1
    local v27 = v12
    clearClimbVelocity()
    local BodyVelocity_2 = Instance.new("BodyVelocity")
    BodyVelocity_2.Name = "ClimbVelocity"
    BodyVelocity_2.MaxForce = Vector3.new(1, 1, 1) * math.huge
    BodyVelocity_2.P = 1000
    BodyVelocity_2.Parent = HumanoidRootPart
    v9 = BodyVelocity_2
    v7:Play(0.1, nil, 1.5)
    local v28 = HumanoidRootPart.CFrame.LookVector * -16
    local v29 = Humanoid.Health < Humanoid.MaxHealth / 2 and true
    local v30 = if not v29 then 0.5 else 0.3
    v29 = Agility.Level.Value * v30

    if v3:FindFirstChild("Climbing Mastery") then
        v29 *= 1.15
    end

    BodyVelocity_2.Velocity = v28 + Vector3.new(0, (24 + v29) * 1.5, 0)
    task.delay(0.3, function() -- line: 323
        -- upvalues:
        --  [1] v27 (copy)
        --  [2] v12 (ref)
        --  [3] arg4 (copy)

        if v27 ~= v12 then
            return
        end

        arg4:Stop()
    end)
end

function t.StartClimb(
    t2: table,
    u1: RaycastResult,
    vec6: Vector3,
    b1: boolean?,
    b2: boolean?
) -- line: 332
    -- upvalues:
    --  [1] v4 (copy)
    --  [2] v12 (ref)
    --  [3] v8 (ref)
    --  [4] clearClimbVelocity (copy)
    --  [5] ReplicatedStorage (copy)
    --  [6] HumanoidRootPart (copy)
    --  [7] Humanoid (copy)
    --  [8] ClimbGyro_BodyGyro (copy)
    --  [9] hasMovementInput (copy)
    --  [10] v5 (copy)
    --  [11] v9 (ref)
    --  [12] Agility (copy)
    --  [13] v3 (copy)
    --  [14] RunService (copy)
    --  [15] raycastParams (copy)
    --  [16] hasLedge (copy)

    if v4:IsClimbing() and not b1 then
        t2:Stop()

        return
    end

    v12 += 1
    local v31 = v12

    if v8 then
        v8:Disconnect()
        v8 = nil
    end

    clearClimbVelocity()

    if not b2 and not v4:IsClimbing() then
        v4:AddState("Climbing")
    end

    local v32 = ReplicatedStorage.SFX.Movement.Climb:Clone()
    v32.PlayOnRemove = true
    v32.Parent = HumanoidRootPart
    v32:Destroy()
    Humanoid.AutoRotate = false
    Humanoid.PlatformStand = true
    ClimbGyro_BodyGyro.CFrame = CFrame.lookAt(Vector3.new(0, 0, 0), -vec6)
    ClimbGyro_BodyGyro.Parent = HumanoidRootPart

    if hasMovementInput() or _G.ControllerPlugged then
        v5:Play(0.1)
        clearClimbVelocity()
        local ClimbVelocity_BodyVelocity_1 = Instance.new("BodyVelocity")
        ClimbVelocity_BodyVelocity_1.Name = "ClimbVelocity"
        ClimbVelocity_BodyVelocity_1.MaxForce = Vector3.new(1, 1, 1) * math.huge
        ClimbVelocity_BodyVelocity_1.P = 1000
        ClimbVelocity_BodyVelocity_1.Parent = HumanoidRootPart
        v9 = ClimbVelocity_BodyVelocity_1
        local v44 = Humanoid.Health < Humanoid.MaxHealth / 2 and true
        local v45 = if not v44 then 0.5 else 0.3
        v44 = Agility.Level.Value * v45

        if v3:FindFirstChild("Climbing Mastery") then
            v44 *= 1.15
        end

        ClimbVelocity_BodyVelocity_1.Velocity = Vector3.new(0, 24 + v44, 0)
        local Position_1 = u1.Position
        local v46 = nil
        v8 = RunService.Heartbeat:Connect(function() -- line: 374
            -- upvalues:
            --  [1] v31 (copy)
            --  [2] v12 (ref)
            --  [3] v46 (ref)
            --  [4] v4 (ref)
            --  [5] t2 (copy)
            --  [6] HumanoidRootPart (ref)
            --  [7] raycastParams (ref)
            --  [8] Position_1 (ref)
            --  [9] hasLedge (ref)
            --  [10] vec6 (copy)

            if v31 ~= v12 then
                if v46 then
                    v46:Disconnect()
                end

                return
            end

            if not v4:IsClimbing() then
                t2:Stop()

                return
            end

            local v48 = workspace:Raycast(
                HumanoidRootPart.Position,
                HumanoidRootPart.CFrame.LookVector * 3,
                raycastParams
            )

            if v48 then
                Position_1 = v48.Position
            end

            if hasLedge(Position_1, vec6) then
                t2:LedgeClimb(vec6)
            end
        end)
        task.delay(0.4, function() -- line: 402
            -- upvalues:
            --  [1] v31 (copy)
            --  [2] v12 (ref)
            --  [3] t2 (copy)

            if v31 ~= v12 then
                return
            end

            t2:Stop()
        end)

        return
    end

    t2:WallBounce()
end

function t.TryClimb(arg5) -- line: 416
    -- upvalues:
    --  [1] HumanoidRootPart (copy)
    --  [2] raycastParams (copy)
    --  [3] v10 (ref)

    if not arg5:CanClimb() then
        return false
    end

    if workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -4, 0), raycastParams) then
        return false
    end

    local v50 = workspace:Raycast(
        HumanoidRootPart.Position,
        HumanoidRootPart.CFrame.LookVector * 3,
        raycastParams
    )

    if not v50 or not v50.Instance.CanCollide then
        return false
    end

    local Normal = v50.Normal
    local v51

    if math.abs(Normal.Y) > 0.5 then
        v51 = nil
    else
        local _ = v50.Instance.CanCollide
        v51 = Vector3.new(Normal.X, 0, Normal.Z).Unit
    end

    if not v51 then
        return false
    end

    v10 = false
    arg5:StartClimb(v50, v51)

    return true
end

function t.TryLedgeClimb(arg6) -- line: 449
    -- upvalues:
    --  [1] Humanoid (copy)
    --  [2] v4 (copy)
    --  [3] v11 (ref)
    --  [4] HumanoidRootPart (copy)
    --  [5] raycastParams (copy)
    --  [6] hasLedge (copy)
    --  [7] v10 (ref)

    if Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
        return false
    end

    if v4:IsClimbing() or v11 then
        return false
    end

    if not arg6:CanClimb() then
        return false
    end

    local v53 = workspace:Raycast(
        HumanoidRootPart.Position,
        HumanoidRootPart.CFrame.LookVector * 3,
        raycastParams
    )

    if not v53 or not v53.Instance.CanCollide then
        return false
    end

    local Normal_1 = v53.Normal
    local v54

    if math.abs(Normal_1.Y) > 0.5 then
        v54 = nil
    else
        local _ = v53.Instance.CanCollide
        v54 = Vector3.new(Normal_1.X, 0, Normal_1.Z).Unit
    end

    if not v54 then
        return false
    end

    if not hasLedge(v53.Position, v54) then
        return false
    end

    if not arg6:LedgeClimb(v54) then
        return false
    end

    v10 = false

    return true
end

function t.UpdateLadderState(_) -- line: 487
    -- upvalues:
    --  [1] LadderParts (copy)
    --  [2] HumanoidRootPart (copy)
    --  [3] raycastParams_1 (copy)
    --  [4] Humanoid (copy)

    if not LadderParts then
        return
    end

    local v58 = workspace:Raycast(
        (HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)).Position,
        HumanoidRootPart.CFrame.LookVector * 5,
        raycastParams_1
    )
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, if v58 == nil then false else true)
end

function t.Start(_) -- line: 501
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] UserInputService (copy)
    --  [3] KeyCode_Space (copy)
    --  [4] KeyCode_ButtonA (copy)
    --  [5] t (copy)
    --  [6] Humanoid (copy)
    --  [7] v10 (ref)
    --  [8] v11 (ref)
    --  [9] LadderParts (copy)
    --  [10] RunService (copy)

    table.insert(t_3, UserInputService.InputBegan:Connect(function(input, gameProcessedEvent) -- line: 504
        -- upvalues:
        --  [1] KeyCode_Space (ref)
        --  [2] KeyCode_ButtonA (ref)
        --  [3] t (ref)

        if gameProcessedEvent and input.UserInputType ~= Enum.UserInputType.Gamepad1 then
            return
        end

        if input.KeyCode ~= KeyCode_Space and input.KeyCode ~= KeyCode_ButtonA then
            return
        end

        t:TryClimb()
    end))
    table.insert(t_3, UserInputService.JumpRequest:Connect(function() -- line: 523
        -- upvalues:
        --  [1] t (ref)

        t:TryLedgeClimb()
    end))
    local v63 = t_3
    local FloorMaterial = Humanoid:GetPropertyChangedSignal("FloorMaterial")
    table.insert(v63, FloorMaterial:Connect(function() -- line: 530
        -- upvalues:
        --  [1] Humanoid (ref)
        --  [2] v10 (ref)
        --  [3] v11 (ref)

        if Humanoid.FloorMaterial == Enum.Material.Air then
            return
        end

        v10 = true
        v11 = false
    end))

    if LadderParts then
        local v64 = 0
        table.insert(t_3, RunService.Heartbeat:Connect(function(deltaTime) -- line: 545
            -- upvalues:
            --  [1] v64 (ref)
            --  [2] t (ref)

            v64 += deltaTime

            if v64 < 0.05 then
                return
            end

            v64 %= 0.05
            t:UpdateLadderState()
        end))
    end
end

function t.Destroy(arg12) -- line: 560
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] ClimbGyro_BodyGyro (copy)

    arg12:Stop()

    for _, val_1 in t_3 do
        val_1:Disconnect()
    end

    table.clear(t_3)
    ClimbGyro_BodyGyro:Destroy()
end

return t
