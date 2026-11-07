-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.OrbitalCamera
-- Class: ModuleScript
-- bytes: 11096

local _ = {
    InitialDistance = 25,
    MinDistance = 10,
    MaxDistance = 100,
    InitialElevation = 35,
    MinElevation = 35,
    MaxElevation = 35,
    ReferenceAzimuth = -45,
    CWAzimuthTravel = 90,
    CCWAzimuthTravel = 90,
    UseAzimuthLimits = false
}
local CameraUtils_m = require(script.Parent:WaitForChild("CameraUtils"))
local CameraInput_m = require(script.Parent:WaitForChild("CameraInput"))
local Players = game:GetService("Players")
local BaseCamera_m = require(script.Parent:WaitForChild("BaseCamera"))
local t_1 = setmetatable({}, BaseCamera_m)
t_1.__index = t_1

function t_1.new() -- line: 42
    -- upvalues:
    --  [1] BaseCamera_m (copy)
    --  [2] t_1 (copy)

    local t_2 = setmetatable(BaseCamera_m.new(), t_1)
    t_2.lastUpdate = tick()
    t_2.changedSignalConnections = {}
    t_2.refAzimuthRad = nil
    t_2.curAzimuthRad = nil
    t_2.minAzimuthAbsoluteRad = nil
    t_2.maxAzimuthAbsoluteRad = nil
    t_2.useAzimuthLimits = nil
    t_2.curElevationRad = nil
    t_2.minElevationRad = nil
    t_2.maxElevationRad = nil
    t_2.curDistance = nil
    t_2.minDistance = nil
    t_2.maxDistance = nil
    t_2.gamepadDollySpeedMultiplier = 1
    t_2.lastUserPanCamera = tick()
    t_2.externalProperties = {}
    t_2.externalProperties.InitialDistance = 25
    t_2.externalProperties.MinDistance = 10
    t_2.externalProperties.MaxDistance = 100
    t_2.externalProperties.InitialElevation = 35
    t_2.externalProperties.MinElevation = 35
    t_2.externalProperties.MaxElevation = 35
    t_2.externalProperties.ReferenceAzimuth = -45
    t_2.externalProperties.CWAzimuthTravel = 90
    t_2.externalProperties.CCWAzimuthTravel = 90
    t_2.externalProperties.UseAzimuthLimits = false
    t_2:LoadNumberValueParameters()

    return t_2
end

function t_1.LoadOrCreateNumberValueParameter(t1: table, s1: string, arg1: any, arg2: any) -- line: 81
    local v5 = script:FindFirstChild(s1)

    if v5 then
        if v5:isA(arg1) then
            t1.externalProperties[s1] = v5.Value
        elseif t1.externalProperties[s1] ~= nil then
            v5 = Instance.new(arg1)
            v5.Name = s1
            v5.Parent = script
            v5.Value = t1.externalProperties[s1]
        else
            return
        end

        if arg2 then
            if t1.changedSignalConnections[s1] then
                t1.changedSignalConnections[s1]:Disconnect()
            end

            t1.changedSignalConnections[s1] = v5.Changed:Connect(function(arg3) -- line: 101
                -- upvalues:
                --  [1] t1 (copy)
                --  [2] s1 (copy)
                --  [3] arg2 (copy)

                t1.externalProperties[s1] = arg3
                arg2(t1)
            end)
        end

        return
    end

    if t1.externalProperties[s1] ~= nil then
        v5 = Instance.new(arg1)
        v5.Name = s1
        v5.Parent = script
        v5.Value = t1.externalProperties[s1]
    else
        return
    end

    if arg2 then
        if t1.changedSignalConnections[s1] then
            t1.changedSignalConnections[s1]:Disconnect()
        end

        t1.changedSignalConnections[s1] = v5.Changed:Connect(function(arg4) -- line: 101
            -- upvalues:
            --  [1] t1 (copy)
            --  [2] s1 (copy)
            --  [3] arg2 (copy)

            t1.externalProperties[s1] = arg4
            arg2(t1)
        end)
    end
end

function t_1.SetAndBoundsCheckAzimuthValues(arg5) -- line: 108
    local v6 = math.rad(arg5.externalProperties.ReferenceAzimuth)
    local v7 = math.rad(arg5.externalProperties.CWAzimuthTravel)
    arg5.minAzimuthAbsoluteRad = v6 - math.abs(v7)
    local v8 = math.rad(arg5.externalProperties.ReferenceAzimuth)
    local v9 = math.rad(arg5.externalProperties.CCWAzimuthTravel)
    arg5.maxAzimuthAbsoluteRad = v8 + math.abs(v9)
    arg5.useAzimuthLimits = arg5.externalProperties.UseAzimuthLimits

    if arg5.useAzimuthLimits then
        arg5.curAzimuthRad = math.max(arg5.curAzimuthRad, arg5.minAzimuthAbsoluteRad)
        arg5.curAzimuthRad = math.min(arg5.curAzimuthRad, arg5.maxAzimuthAbsoluteRad)
    end
end

function t_1.SetAndBoundsCheckElevationValues(arg6) -- line: 118
    local v10 = math.max(arg6.externalProperties.MinElevation, -80)
    local v11 = math.min(arg6.externalProperties.MaxElevation, 80)
    local v12 = math.min(v10, v11)
    arg6.minElevationRad = math.rad(v12)
    local v13 = math.max(v10, v11)
    arg6.maxElevationRad = math.rad(v13)
    arg6.curElevationRad = math.max(arg6.curElevationRad, arg6.minElevationRad)
    arg6.curElevationRad = math.min(arg6.curElevationRad, arg6.maxElevationRad)
end

function t_1.SetAndBoundsCheckDistanceValues(arg7) -- line: 134
    arg7.minDistance = arg7.externalProperties.MinDistance
    arg7.maxDistance = arg7.externalProperties.MaxDistance
    arg7.curDistance = math.max(arg7.curDistance, arg7.minDistance)
    arg7.curDistance = math.min(arg7.curDistance, arg7.maxDistance)
end

function t_1.LoadNumberValueParameters(arg8) -- line: 142
    arg8:LoadOrCreateNumberValueParameter("InitialElevation", "NumberValue", nil)
    arg8:LoadOrCreateNumberValueParameter("InitialDistance", "NumberValue", nil)
    arg8:LoadOrCreateNumberValueParameter(
        "ReferenceAzimuth",
        "NumberValue",
        arg8.SetAndBoundsCheckAzimuthValue
    )
    arg8:LoadOrCreateNumberValueParameter(
        "CWAzimuthTravel",
        "NumberValue",
        arg8.SetAndBoundsCheckAzimuthValues
    )
    arg8:LoadOrCreateNumberValueParameter(
        "CCWAzimuthTravel",
        "NumberValue",
        arg8.SetAndBoundsCheckAzimuthValues
    )
    arg8:LoadOrCreateNumberValueParameter(
        "MinElevation",
        "NumberValue",
        arg8.SetAndBoundsCheckElevationValues
    )
    arg8:LoadOrCreateNumberValueParameter(
        "MaxElevation",
        "NumberValue",
        arg8.SetAndBoundsCheckElevationValues
    )
    arg8:LoadOrCreateNumberValueParameter(
        "MinDistance",
        "NumberValue",
        arg8.SetAndBoundsCheckDistanceValues
    )
    arg8:LoadOrCreateNumberValueParameter(
        "MaxDistance",
        "NumberValue",
        arg8.SetAndBoundsCheckDistanceValues
    )
    arg8:LoadOrCreateNumberValueParameter(
        "UseAzimuthLimits",
        "BoolValue",
        arg8.SetAndBoundsCheckAzimuthValues
    )
    arg8.curAzimuthRad = math.rad(arg8.externalProperties.ReferenceAzimuth)
    arg8.curElevationRad = math.rad(arg8.externalProperties.InitialElevation)
    arg8.curDistance = arg8.externalProperties.InitialDistance
    arg8:SetAndBoundsCheckAzimuthValues()
    arg8:SetAndBoundsCheckElevationValues()
    arg8:SetAndBoundsCheckDistanceValues()
end

function t_1.GetModuleName(_) -- line: 167
    return "OrbitalCamera"
end

function t_1.SetInitialOrientation(t2: table, u1: userdata) -- line: 171
    -- upvalues:
    --  [1] CameraUtils_m (copy)

    if not u1 or not u1.RootPart then
        warn("OrbitalCamera could not set initial orientation due to missing humanoid")

        return
    end

    assert(u1.RootPart, "")
    local Unit = (u1.RootPart.CFrame.LookVector - Vector3.new(0, 0.23, 0)).Unit
    local v14 = CameraUtils_m.GetAngleBetweenXZVectors(Unit, t2:GetCameraLookVector())
    local v16 = math.asin(t2:GetCameraLookVector().Y) - math.asin(Unit.Y)

    if not CameraUtils_m.IsFinite(v14) then
    end

    if not CameraUtils_m.IsFinite(v16) then
    end
end

function t_1.GetCameraToSubjectDistance(arg10) -- line: 189
    return arg10.curDistance
end

function t_1.SetCameraToSubjectDistance(arg11, arg12) -- line: 193
    -- upvalues:
    --  [1] Players (copy)

    if Players.LocalPlayer then
        arg11.currentSubjectDistance = math.clamp(arg12, arg11.minDistance, arg11.maxDistance)
        arg11.currentSubjectDistance = math.max(
            arg11.currentSubjectDistance,
            arg11.FIRST_PERSON_DISTANCE_THRESHOLD
        )
    end

    arg11.inFirstPerson = false
    arg11:UpdateMouseBehavior()

    return arg11.currentSubjectDistance
end

function t_1.CalculateNewLookVector(t3: table, vec1: Vector3, u2: Vector2) -- line: 206
    local v17 = vec1 or t3:GetCameraLookVector()
    local v18 = math.asin(v17.Y)
    local v19 = math.clamp(u2.Y, v18 - 1.3962634015954636, v18 - -1.3962634015954636)
    local vec2 = Vector2.new(u2.X, v19)
    local cframe = CFrame.new(Vector3.new(0, 0, 0), v17)

    return (CFrame.Angles(0, -vec2.X, 0) * cframe * CFrame.Angles(-vec2.Y, 0, 0)).LookVector
end

function t_1.Update(t4: table, n1: number) -- line: 217
    -- upvalues:
    --  [1] CameraInput_m (copy)
    --  [2] Players (copy)

    local now = tick()
    local v21 = now - t4.lastUpdate
    local v23 = if CameraInput_m.getRotation() == Vector2.new() then false else true
    local CurrentCamera = workspace.CurrentCamera
    local v24 = CurrentCamera.CFrame
    local v25 = CurrentCamera.Focus
    local v26 = CurrentCamera and CurrentCamera.CameraSubject
    local v27 = v26
    local LocalPlayer = Players.LocalPlayer

    if v27 then
        v27 = v26:IsA("VehicleSeat")
    end

    local v28 = v26

    if v28 then
        v28 = v26:IsA("SkateboardPlatform")
    end

    if t4.lastUpdate == nil or v21 > 1 then
        t4.lastCameraTransform = nil
    end

    if v23 then
        t4.lastUserPanCamera = tick()
    end

    v23 = t4:GetSubjectPosition()

    if v23 and LocalPlayer and CurrentCamera then
        if t4.gamepadDollySpeedMultiplier ~= 1 then
            t4:SetCameraToSubjectDistance(
                t4.currentSubjectDistance * t4.gamepadDollySpeedMultiplier
            )
        end

        v25 = CFrame.new(v23)
        local v30 = CameraInput_m.getRotation(n1)
        t4.curAzimuthRad -= v30.X

        if t4.useAzimuthLimits then
            t4.curAzimuthRad = math.clamp(
                t4.curAzimuthRad,
                t4.minAzimuthAbsoluteRad,
                t4.maxAzimuthAbsoluteRad
            )
        else
            t4.curAzimuthRad = t4.curAzimuthRad ~= 0 and math.sign(t4.curAzimuthRad) * (math.abs(
                t4.curAzimuthRad
            ) % 6.283185307179586) or 0
        end

        t4.curElevationRad = math.clamp(
            t4.curElevationRad + v30.Y,
            t4.minElevationRad,
            t4.maxElevationRad
        )
        v24 = CFrame.new(
            v23 + t4.currentSubjectDistance * (CFrame.fromEulerAnglesYXZ(
                -t4.curElevationRad,
                t4.curAzimuthRad,
                0
            ) * Vector3.new(0, 0, 1)),
            v23
        )
        t4.lastCameraTransform = v24
        t4.lastCameraFocus = v25

        if not v27 then
            if v28 then
                if v26:IsA("BasePart") then
                    t4.lastSubjectCFrame = v26.CFrame
                else
                    t4.lastSubjectCFrame = nil
                end
            else
                t4.lastSubjectCFrame = nil
            end
        elseif v26:IsA("BasePart") then
            t4.lastSubjectCFrame = v26.CFrame
        else
            t4.lastSubjectCFrame = nil
        end
    end

    t4.lastUpdate = now

    return v24, v25
end

return t_1
