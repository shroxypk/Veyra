-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.effects.camera_shake
-- Class: ModuleScript
-- bytes: 5935

local RunService = game:GetService("RunService")
local ModAttributes_m = require("../mod/attributes")
local ModTween_m = require("../mod/tween")
local _ = require("../types")
local ModUtility_m = require("../mod/utility")
local PkgShake_m = require("../pkg/Shake")
local t = {}
local Identity = CFrame.identity

local function updateCamera() -- line: 13
    -- upvalues:
    --  [1] t (ref)
    --  [2] RunService (copy)
    --  [3] Identity (ref)

    if #t == 0 then
        return
    end

    local CurrentCamera = workspace.CurrentCamera
    local v2, v3

    if not RunService:IsRunning() then
        CurrentCamera.CFrame = CurrentCamera.CFrame * Identity:Inverse()
        v2 = CurrentCamera.CFrame
        local v4
        v3, v4 = v2:ToOrientation()
        CurrentCamera.CFrame = CFrame.new(v2.Position) * CFrame.fromOrientation(v3, v4, 0)
    end

    v2 = Vector3.new(0, 0, 0)
    v3 = CFrame.identity
    local t_1 = {}

    for _, val in t do
        if not val.done then
            v2 += val.pos
            v3 *= CFrame.Angles(val.rot.x, val.rot.y, val.rot.z)
            table.insert(t_1, val)
        end
    end

    t = t_1
    local v5 = CFrame.new(v2) * v3

    if not RunService:IsRunning() then
        Identity = v5
    end

    CurrentCamera.CFrame *= v5
end

local t_2 = {}
local v6 = nil
local v7 = nil

function t_2.init() -- line: 63
    -- upvalues:
    --  [1] v6 (ref)
    --  [2] RunService (copy)
    --  [3] v7 (ref)
    --  [4] updateCamera (copy)

    if v6 then
        return
    end

    if RunService:IsRunning() then
        v6 = RunService.Heartbeat:Connect(function() -- line: 69
            -- upvalues:
            --  [1] v7 (ref)

            if not v7 then
                return
            end

            workspace.CurrentCamera.CFrame = v7
        end)
    end

    RunService:BindToRenderStep(
        "forge_updateCameraShake",
        Enum.RenderPriority.Last.Value + 1,
        updateCamera
    )
end

function t_2.deinit() -- line: 81
    -- upvalues:
    --  [1] v6 (ref)
    --  [2] RunService (copy)

    if v6 then
        v6:Disconnect()
        v6 = nil
    end

    RunService:UnbindFromRenderStep("forge_updateCameraShake")
end

function t_2.emit(u1: userdata, arg1: any) -- line: 90
    -- upvalues:
    --  [1] ModAttributes_m (copy)
    --  [2] PkgShake_m (copy)
    --  [3] ModTween_m (copy)
    --  [4] ModUtility_m (copy)
    --  [5] RunService (copy)
    --  [6] t (ref)
    --  [7] v7 (ref)

    local v9 = ModAttributes_m.get(u1, "EmitDelay", 0)
    local v10 = ModAttributes_m.get(u1, "EmitDuration", 0)
    local v11 = ModAttributes_m.get(u1, "Falloff", 30)
    local v12 = ModAttributes_m.get(u1, "Amplitude", 2.5)
    local v13 = ModAttributes_m.get(u1, "Frequency", 0.2)
    local v14 = ModAttributes_m.get(u1, "FadeInTime", 0.3)
    local v15 = ModAttributes_m.get(u1, "FadeOutTime", 2)
    local v16 = ModAttributes_m.get(u1, "SustainTime", 1)
    local v17 = ModAttributes_m.get(u1, "PositionInfluence", Vector3.new(1, 1, 1))
    local v18 = ModAttributes_m.get(u1, "RotationInfluence", Vector3.new(0.2, 0.2, 0.2))
    local v19 = ModAttributes_m.get(u1, "Speed_Start", 1)
    local v20 = ModAttributes_m.get(u1, "Speed_End", 1)
    local v21 = v10 > 0 and true
    local v22 = PkgShake_m.new()
    v22.Sustain = v21
    v22.Amplitude = v12
    v22.Frequency = v13
    v22.FadeInTime = v14
    v22.FadeOutTime = v15
    v22.SustainTime = v16
    v22.PositionInfluence = v17
    v22.RotationInfluence = v18
    local v23 = 1
    local v24 = 0

    function v22.TimeFunction() -- line: 125
        -- upvalues:
        --  [1] v24 (ref)

        return v24
    end

    if v19 ~= v20 then
        local FromParams = ModTween_m.fromParams
        local v25 = ModAttributes_m.get(u1, "Speed_Curve", ModUtility_m.default_bezier)
        table.insert(arg1, (FromParams(v25, ModAttributes_m.get(u1, "Speed_Duration", 0.1), function(
            arg2,
            arg3
        ) -- line: 133
            -- upvalues:
            --  [1] v23 (ref)
            --  [2] ModUtility_m (ref)
            --  [3] v19 (copy)
            --  [4] v20 (copy)

            v23 = ModUtility_m.lerp(v19, v20, arg2)

            return arg3
        end)))
    end

    table.insert(arg1, RunService.RenderStepped:Connect(function(deltaTime) -- line: 144
        -- upvalues:
        --  [1] v24 (ref)
        --  [2] v23 (ref)

        v24 += deltaTime * v23
    end))
    local t_3 = { done = false, pos = Vector3.new(0, 0, 0), rot = Vector3.new(0, 0, 0) }
    task.wait(v9)
    table.insert(t, t_3)
    local thread = coroutine.running()
    v22:BindToRenderStep(PkgShake_m.NextRenderName(), ModUtility_m.RENDER_PRIORITY + arg1.depth, function(
        arg5,
        arg6,
        arg7
    ) -- line: 161
        -- upvalues:
        --  [1] v7 (ref)
        --  [2] u1 (copy)
        --  [3] ModUtility_m (ref)
        --  [4] v11 (copy)
        --  [5] t_3 (copy)
        --  [6] thread (copy)

        local CurrentCamera_1 = workspace.CurrentCamera
        v7 = CurrentCamera_1.CFrame
        local v29 = u1:FindFirstAncestorOfClass("Attachment") or u1:FindFirstAncestorWhichIsA(
            "BasePart"
        )

        if v29 then
            local v30 = ModUtility_m.getTransformedOriginExtents(v29) and ModUtility_m.getTransformedOriginExtents(
                v29
            ).Position or v29.Position
            local v31 = 1 - math.clamp(
                (CurrentCamera_1.CFrame.Position - v30).Magnitude / v11,
                0,
                1
            )
            arg5 *= v31
            arg6 *= v31
        end

        t_3.pos = arg5
        t_3.rot = arg6
        t_3.done = arg7

        if arg7 then
            v7 = nil
            task.spawn(thread)
        end
    end)
    v22:Start()

    if v21 then
        task.wait(v10)
        v22:StopSustain()
    end

    if not t_3.done then
        coroutine.yield()
    end
end

return t_2
