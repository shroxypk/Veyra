-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.ClassicCamera
-- Class: ModuleScript
-- bytes: 11968

local _ = Vector2.new(0, 0)
local v1 = 0
local cframe = CFrame.fromOrientation(-0.2617993877991494, 0, 0)
local FlagUtil_m = require(
    script.Parent.Parent:WaitForChild("CommonUtils"):WaitForChild("FlagUtil")
)
local UserFixCameraOffsetJitter2 = FlagUtil_m.getUserFlag("UserFixCameraOffsetJitter2")
local UserCameraInputDt = FlagUtil_m.getUserFlag("UserCameraInputDt")
local Players = game:GetService("Players")
local CameraInput_m = require(script.Parent:WaitForChild("CameraInput"))
local CameraUtils_m = require(script.Parent:WaitForChild("CameraUtils"))
local BaseCamera_m = require(script.Parent:WaitForChild("BaseCamera"))
local t = setmetatable({}, BaseCamera_m)
t.__index = t

function t.new() -- line: 41
    -- upvalues:
    --  [1] BaseCamera_m (copy)
    --  [2] t (copy)
    --  [3] CameraUtils_m (copy)

    local t_1 = setmetatable(BaseCamera_m.new(), t)
    t_1.isFollowCamera = false
    t_1.isCameraToggle = false
    t_1.lastUpdate = tick()
    t_1.cameraToggleSpring = CameraUtils_m.Spring.new(5, 0)

    return t_1
end

function t.GetCameraToggleOffset(t1: table, n1: number) -- line: 52
    -- upvalues:
    --  [1] CameraInput_m (copy)
    --  [2] CameraUtils_m (copy)

    if t1.isCameraToggle then
        local CurrentSubjectDistance = t1.currentSubjectDistance

        if CameraInput_m.getTogglePan() then
            t1.cameraToggleSpring.goal = math.clamp(
                CameraUtils_m.map(
                    CurrentSubjectDistance,
                    0.5,
                    t1.FIRST_PERSON_DISTANCE_THRESHOLD,
                    0,
                    1
                ),
                0,
                1
            )
        else
            t1.cameraToggleSpring.goal = 0
        end

        return (Vector3.new(
            0,
            t1.cameraToggleSpring:step(n1) * (math.clamp(
                CameraUtils_m.map(
                    CurrentSubjectDistance,
                    0.5,
                    64,
                    0,
                    1
                ),
                0,
                1
            ) + 1),
            0
        ))
    end

    return (Vector3.new())
end

function t.SetCameraMovementMode(arg1, arg2) -- line: 70
    -- upvalues:
    --  [1] BaseCamera_m (copy)

    BaseCamera_m.SetCameraMovementMode(arg1, arg2)
    arg1.isFollowCamera = arg2 == Enum.ComputerCameraMovementMode.Follow
    arg1.isCameraToggle = arg2 == Enum.ComputerCameraMovementMode.CameraToggle
end

function t.Update(arg3, arg4) -- line: 77
    -- upvalues:
    --  [1] UserCameraInputDt (copy)
    --  [2] cframe (copy)
    --  [3] Players (copy)
    --  [4] CameraInput_m (copy)
    --  [5] v1 (ref)
    --  [6] UserFixCameraOffsetJitter2 (copy)
    --  [7] CameraUtils_m (copy)

    local now = tick()
    local v11 = now - arg3.lastUpdate
    v11 = if not UserCameraInputDt then v11 else arg4
    local CurrentCamera = workspace.CurrentCamera
    local v12 = CurrentCamera.CFrame
    local v13 = CurrentCamera.Focus
    local v14 = nil

    if arg3.resetCameraAngle then
        local v15 = arg3:GetHumanoidRootPart()
        v14 = if v15 then (v15.CFrame * cframe).lookVector else cframe.lookVector
        arg3.resetCameraAngle = false
    end

    local LocalPlayer = Players.LocalPlayer
    local v16 = arg3:GetHumanoid()
    local CameraSubject = CurrentCamera.CameraSubject
    local v17 = CameraSubject

    if v17 then
        v17 = CameraSubject:IsA("VehicleSeat")
    end

    local v18 = CameraSubject

    if v18 then
        v18 = CameraSubject:IsA("SkateboardPlatform")
    end

    local v19 = v16

    if v19 then
        v19 = if v16:GetState() ~= Enum.HumanoidStateType.Climbing then false else true
    end

    if arg3.lastUpdate == nil or v11 > 1 then
        arg3.lastCameraTransform = nil
    end

    local v20 = CameraInput_m.getRotation(v11)
    arg3:StepZoom()
    local v21 = arg3:GetCameraHeight()

    if v20 ~= Vector2.new() then
        v1 = 0
        arg3.lastUserPanCamera = tick()
    end

    local v22 = now - arg3.lastUserPanCamera < 2
    local v23 = arg3:GetSubjectPosition()

    if v23 and LocalPlayer and CurrentCamera then
        local v24 = arg3:GetCameraToSubjectDistance()

        if v24 < 0.5 then
            v24 = 0.5
        end

        local v28, v29, v30, v31, v33

        if arg3:GetIsMouseLocked() then
            if not arg3:IsInFirstPerson() then
                local v25 = arg3:CalculateNewLookCFrameFromArg(v14, v20)
                local v26 = arg3:GetMouseLockOffset()

                if UserFixCameraOffsetJitter2 and v16 then
                    v26 += v16.CameraOffset
                end

                local v27 = v26.X * v25.RightVector + v26.Y * v25.UpVector + v26.Z * v25.LookVector

                if CameraUtils_m.IsFiniteVector3(v27) then
                    v23 += v27
                end
            elseif not (if v20 == Vector2.new() then false else true) and arg3.lastCameraTransform then
                v28 = arg3:IsInFirstPerson()

                if if v17 then arg3.lastUpdate and (v16 and v16.Torso) else if v18 then arg3.lastUpdate and (v16 and v16.Torso) else arg3.isFollowCamera and (v19 and (arg3.lastUpdate and (v16 and v16.Torso))) then
                    if v28 then
                        if arg3.lastSubjectCFrame then
                            if not v17 then
                                if v18 and CameraSubject:IsA("BasePart") then
                                    v29 = -CameraUtils_m.GetAngleBetweenXZVectors(
                                        arg3.lastSubjectCFrame.lookVector,
                                        CameraSubject.CFrame.lookVector
                                    )

                                    if CameraUtils_m.IsFinite(v29) then
                                        v20 += Vector2.new(v29, 0)
                                    end

                                    v1 = 0
                                end
                            elseif CameraSubject:IsA("BasePart") then
                                v29 = -CameraUtils_m.GetAngleBetweenXZVectors(
                                    arg3.lastSubjectCFrame.lookVector,
                                    CameraSubject.CFrame.lookVector
                                )

                                if CameraUtils_m.IsFinite(v29) then
                                    v20 += Vector2.new(v29, 0)
                                end

                                v1 = 0
                            end
                        end
                    elseif not v22 then
                        local LookVector = v16.Torso.CFrame.lookVector
                        v1 = math.clamp(v1 + 3.839724354387525 * v11, 0, 4.363323129985824)
                        v30 = if arg3:IsInFirstPerson() and (not arg3.isFollowCamera or not arg3.isClimbing) then 1 else math.clamp(
                            v1 * v11,
                            0,
                            1
                        )
                        v31 = CameraUtils_m.GetAngleBetweenXZVectors(
                            LookVector,
                            arg3:GetCameraLookVector()
                        )

                        if CameraUtils_m.IsFinite(v31) and math.abs(v31) > 0.0001 then
                            v20 += Vector2.new(v31 * v30, 0)
                        end
                    end
                elseif arg3.isFollowCamera and not v28 and not v22 then
                    v33 = CameraUtils_m.GetAngleBetweenXZVectors(
                        -(arg3.lastCameraTransform.p - v23),
                        arg3:GetCameraLookVector()
                    )

                    if CameraUtils_m.IsFinite(v33) and math.abs(v33) > 0.0001 then
                        if math.abs(v33) > 0.4 * v11 then
                            v20 += Vector2.new(v33, 0)
                        end
                    end
                end
            end
        elseif not (if v20 == Vector2.new() then false else true) and arg3.lastCameraTransform then
            v28 = arg3:IsInFirstPerson()

            if if v17 then arg3.lastUpdate and (v16 and v16.Torso) else if v18 then arg3.lastUpdate and (v16 and v16.Torso) else arg3.isFollowCamera and (v19 and (arg3.lastUpdate and (v16 and v16.Torso))) then
                if v28 then
                    if arg3.lastSubjectCFrame then
                        if not v17 then
                            if v18 and CameraSubject:IsA("BasePart") then
                                v29 = -CameraUtils_m.GetAngleBetweenXZVectors(
                                    arg3.lastSubjectCFrame.lookVector,
                                    CameraSubject.CFrame.lookVector
                                )

                                if CameraUtils_m.IsFinite(v29) then
                                    v20 += Vector2.new(v29, 0)
                                end

                                v1 = 0
                            end
                        elseif CameraSubject:IsA("BasePart") then
                            v29 = -CameraUtils_m.GetAngleBetweenXZVectors(
                                arg3.lastSubjectCFrame.lookVector,
                                CameraSubject.CFrame.lookVector
                            )

                            if CameraUtils_m.IsFinite(v29) then
                                v20 += Vector2.new(v29, 0)
                            end

                            v1 = 0
                        end
                    end
                elseif not v22 then
                    local LookVector_1 = v16.Torso.CFrame.lookVector
                    v1 = math.clamp(v1 + 3.839724354387525 * v11, 0, 4.363323129985824)
                    v30 = if arg3:IsInFirstPerson() and (not arg3.isFollowCamera or not arg3.isClimbing) then 1 else math.clamp(
                        v1 * v11,
                        0,
                        1
                    )
                    v31 = CameraUtils_m.GetAngleBetweenXZVectors(
                        LookVector_1,
                        arg3:GetCameraLookVector()
                    )

                    if CameraUtils_m.IsFinite(v31) and math.abs(v31) > 0.0001 then
                        v20 += Vector2.new(v31 * v30, 0)
                    end
                end
            elseif arg3.isFollowCamera and not v28 and not v22 then
                v33 = CameraUtils_m.GetAngleBetweenXZVectors(
                    -(arg3.lastCameraTransform.p - v23),
                    arg3:GetCameraLookVector()
                )

                if CameraUtils_m.IsFinite(v33) and math.abs(v33) > 0.0001 then
                    if math.abs(v33) > 0.4 * v11 then
                        v20 += Vector2.new(v33, 0)
                    end
                end
            end
        end

        if not arg3.isFollowCamera then
            v13 = CFrame.new(v23)
            local P = v13.p
            v12 = CFrame.new(P - v24 * arg3:CalculateNewLookVectorFromArg(v14, v20), P)
        else
            local v37 = arg3:CalculateNewLookVectorFromArg(v14, v20)
            v13 = CFrame.new(v23)
            v12 = CFrame.new(v13.p - v24 * v37, v13.p) + Vector3.new(0, v21, 0)
        end

        v24 = arg3:GetCameraToggleOffset(v11)
        v13 += v24
        v12 += v24
        arg3.lastCameraTransform = v12
        arg3.lastCameraFocus = v13

        if not v17 then
            if v18 then
                if CameraSubject:IsA("BasePart") then
                    arg3.lastSubjectCFrame = CameraSubject.CFrame
                else
                    arg3.lastSubjectCFrame = nil
                end
            else
                arg3.lastSubjectCFrame = nil
            end
        elseif CameraSubject:IsA("BasePart") then
            arg3.lastSubjectCFrame = CameraSubject.CFrame
        else
            arg3.lastSubjectCFrame = nil
        end
    end

    arg3.lastUpdate = now

    return v12, v13
end

return t
