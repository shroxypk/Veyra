-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.LegacyCamera
-- Class: ModuleScript
-- bytes: 3404

local _ = Vector2.new()
local _ = require(script.Parent:WaitForChild("CameraUtils"))
local CameraInput_m = require(script.Parent:WaitForChild("CameraInput"))
local Players = game:GetService("Players")
local BaseCamera_m = require(script.Parent:WaitForChild("BaseCamera"))
local t = setmetatable({}, BaseCamera_m)
t.__index = t

function t.new() -- line: 21
    -- upvalues:
    --  [1] BaseCamera_m (copy)
    --  [2] t (copy)

    local t_1 = setmetatable(BaseCamera_m.new(), t)
    t_1.cameraType = Enum.CameraType.Fixed
    t_1.lastUpdate = tick()
    t_1.lastDistanceToSubject = nil

    return t_1
end

function t.GetModuleName(_) -- line: 31
    return "LegacyCamera"
end

function t.SetCameraToSubjectDistance(arg2, arg3) -- line: 36
    -- upvalues:
    --  [1] BaseCamera_m (copy)

    return BaseCamera_m.SetCameraToSubjectDistance(arg2, arg3)
end

function t.Update(t1: table, n1: number) -- line: 40
    -- upvalues:
    --  [1] Players (copy)
    --  [2] CameraInput_m (copy)

    if not t1.cameraType then
        return nil, nil
    end

    local now = tick()
    local v5 = now - t1.lastUpdate
    local CurrentCamera = workspace.CurrentCamera
    local v6 = CurrentCamera.CFrame
    local v7 = CurrentCamera.Focus
    local LocalPlayer = Players.LocalPlayer
    local v8 = CameraInput_m.getRotation(n1)

    if t1.lastUpdate == nil or v5 > 1 then
        t1.lastDistanceToSubject = nil
    end

    local v9 = t1:GetSubjectPosition()

    if t1.cameraType == Enum.CameraType.Fixed then
        if v9 and LocalPlayer and CurrentCamera then
            local v10 = t1:GetCameraToSubjectDistance()
            local v11 = t1:CalculateNewLookVectorFromArg(nil, v8)
            v7 = CurrentCamera.Focus
            v6 = CFrame.new(CurrentCamera.CFrame.p, CurrentCamera.CFrame.p + v10 * v11)
        end
    elseif t1.cameraType == Enum.CameraType.Attach then
        local v12 = t1:GetSubjectCFrame()
        local v13 = CurrentCamera.CFrame:ToEulerAnglesYXZ()
        local _, v15 = v12:ToEulerAnglesYXZ()
        local v16 = math.clamp(v13 - v8.Y, -1.3962634015954636, 1.3962634015954636)
        v7 = CFrame.new(v12.p) * CFrame.fromEulerAnglesYXZ(v16, v15, 0)
        v6 = v7 * CFrame.new(0, 0, t1:StepZoom())
    elseif t1.cameraType == Enum.CameraType.Watch then
        if v9 and LocalPlayer and CurrentCamera then
            local Unit = nil

            if v9 == CurrentCamera.CFrame.p then
                warn("Camera cannot watch subject in same position as itself")

                return CurrentCamera.CFrame, CurrentCamera.Focus
            end

            local v18 = t1:GetHumanoid()

            if v18 and v18.RootPart then
                local v19 = v9 - CurrentCamera.CFrame.p
                Unit = v19.unit

                if t1.lastDistanceToSubject then
                    if t1.lastDistanceToSubject == t1:GetCameraToSubjectDistance() then
                        t1:SetCameraToSubjectDistance(v19.magnitude)
                    end
                end
            end

            local v20 = t1:GetCameraToSubjectDistance()
            local v21 = t1:CalculateNewLookVectorFromArg(Unit, v8)
            v7 = CFrame.new(v9)
            v6 = CFrame.new(v9 - v20 * v21, v9)
            t1.lastDistanceToSubject = v20
        end
    else
        return CurrentCamera.CFrame, CurrentCamera.Focus
    end

    t1.lastUpdate = now

    return v6, v7
end

return t
