-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.Poppercam
-- Class: ModuleScript
-- bytes: 3875

local ZoomController_m = require(script.Parent:WaitForChild("ZoomController"))
local t = {}
t.__index = t
local cframe = CFrame.new()

local _ = function(u1: CFrame) --[[ cframeToAxis ]] -- line: 13
    local v2, v3 = u1:ToAxisAngle()

    return v2 * v3
end

local _ = function(vec1: Vector3) --[[ axisToCFrame ]] -- line: 18
    -- upvalues:
    --  [1] cframe (copy)

    local Magnitude = vec1.Magnitude

    if Magnitude > 1E-05 then
        return CFrame.fromAxisAngle(vec1, Magnitude)
    end

    return cframe
end

local _ = function(u2: CFrame) --[[ extractRotation ]] -- line: 26
    local _, _, _, v7, v8, v9, v10, v11, v12, v13, v14, v15 = u2:GetComponents()

    return CFrame.new(
        0,
        0,
        0,
        v7,
        v8,
        v9,
        v10,
        v11,
        v12,
        v13,
        v14,
        v15
    )
end

function t.new() -- line: 31
    -- upvalues:
    --  [1] t (copy)

    return (setmetatable({ lastCFrame = nil }, t))
end

function t.Step(t1: table, n1: number, u3: CFrame) -- line: 37
    -- upvalues:
    --  [1] cframe (copy)

    local v16 = t1.lastCFrame or u3
    t1.lastCFrame = u3
    local Position = u3.Position
    local _, _, _, v20, v21, v22, v23, v24, v25, v26, v27, v28 = u3:GetComponents()
    local cframe_1 = CFrame.new(
        0,
        0,
        0,
        v20,
        v21,
        v22,
        v23,
        v24,
        v25,
        v26,
        v27,
        v28
    )
    local _ = CFrame.new(
        0,
        0,
        0,
        v20,
        v21,
        v22,
        v23,
        v24,
        v25,
        v26,
        v27,
        v28
    )
    local P = v16.p
    local _, _, _, v32, v33, v34, v35, v36, v37, v38, v39, v40 = v16:GetComponents()
    local v41 = (Position - P) / n1
    local v42, v43 = (cframe_1 * CFrame.new(
        0,
        0,
        0,
        v32,
        v33,
        v34,
        v35,
        v36,
        v37,
        v38,
        v39,
        v40
    ):inverse()):ToAxisAngle()
    local v44 = v42 * v43 / n1

    local function extrapolate(arg1) -- line: 52
        -- upvalues:
        --  [1] v41 (copy)
        --  [2] Position (copy)
        --  [3] v44 (copy)
        --  [4] cframe (ref)
        --  [5] cframe_1 (copy)

        local v45 = v41 * arg1 + Position
        local v46 = v44 * arg1
        local Magnitude_1 = v46.Magnitude

        return (if not (Magnitude_1 > 1E-05) then cframe else CFrame.fromAxisAngle(v46, Magnitude_1)) * cframe_1 + v45
    end

    return { extrapolate = extrapolate, posVelocity = v41, rotVelocity = v44 }
end

function t.Reset(arg2) -- line: 65
    arg2.lastCFrame = nil
end

local BaseOcclusion_m = require(script.Parent:WaitForChild("BaseOcclusion"))
local t_2 = setmetatable({}, BaseOcclusion_m)
t_2.__index = t_2

function t_2.new() -- line: 75
    -- upvalues:
    --  [1] BaseOcclusion_m (copy)
    --  [2] t_2 (copy)
    --  [3] t (copy)

    local t_3 = setmetatable(BaseOcclusion_m.new(), t_2)
    t_3.focusExtrapolator = t.new()

    return t_3
end

function t_2.GetOcclusionMode(_) -- line: 81
    return Enum.DevCameraOcclusionMode.Zoom
end

function t_2.Enable(arg4, _) -- line: 85
    arg4.focusExtrapolator:Reset()
end

function t_2.Update(
    arg6,
    arg7,
    arg8,
    arg9,
    _
) -- line: 89
    -- upvalues:
    --  [1] ZoomController_m (copy)

    local v50 = CFrame.new(arg9.p, arg8.p) * CFrame.new(
        0,
        0,
        0,
        -1,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        -1
    )
    local v51 = arg6.focusExtrapolator:Step(arg7, v50)
    local v52 = ZoomController_m.Update(arg7, v50, v51)

    return v50 * CFrame.new(0, 0, v52), arg9
end

function t_2.CharacterAdded(_, _, _) -- line: 102
end

function t_2.CharacterRemoving(_, _, _) -- line: 106
end

function t_2.OnCameraSubjectChanged(_, _) -- line: 109
end

return t_2
