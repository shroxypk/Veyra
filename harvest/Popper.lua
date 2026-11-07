-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.ZoomController.Popper
-- Class: ModuleScript
-- bytes: 13752

local Players = game:GetService("Players")
local CurrentCamera = game.Workspace.CurrentCamera
local UserRaycastPerformanceImprovements = require(
    script.Parent.Parent.Parent:WaitForChild("CommonUtils"):WaitForChild("FlagUtil")
).getUserFlag("UserRaycastPerformanceImprovements")
local math_min = math.min
local math_tan = math.tan
local math_rad = math.rad
local New = Ray.new
local raycastParams = RaycastParams.new()
raycastParams.IgnoreWater = true
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
local raycastParams_1 = RaycastParams.new()
raycastParams_1.IgnoreWater = true
raycastParams_1.FilterType = Enum.RaycastFilterType.Include

local _ = function(arg1) --[[ getTotalTransparency ]] -- line: 31
    return 1 - (1 - arg1.Transparency) * (1 - arg1.LocalTransparencyModifier)
end

local _ = function(arg2, arg3) --[[ eraseFromEnd ]] -- line: 35
    for index = #arg2, arg3 + 1, -1 do
        arg2[index] = nil
    end
end

local v1 = nil
local v2 = nil

local function updateProjection() -- line: 42
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] math_rad (copy)
    --  [3] v1 (ref)
    --  [4] math_tan (copy)
    --  [5] v2 (ref)

    local v3 = math_rad(CurrentCamera.FieldOfView)
    local ViewportSize = CurrentCamera.ViewportSize
    local v4 = ViewportSize.X / ViewportSize.Y
    v1 = math_tan(v3 / 2) * 2
    v2 = v4 * v1
end

CurrentCamera:GetPropertyChangedSignal("FieldOfView"):Connect(updateProjection)
CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateProjection)
local v5 = math_rad(CurrentCamera.FieldOfView)
local ViewportSize_1 = CurrentCamera.ViewportSize
local v6 = ViewportSize_1.X / ViewportSize_1.Y
v1 = math_tan(v5 / 2) * 2
v2 = v6 * v1
local NearPlaneZ = CurrentCamera.NearPlaneZ
CurrentCamera:GetPropertyChangedSignal("NearPlaneZ"):Connect(function() -- line: 57
    -- upvalues:
    --  [1] NearPlaneZ (ref)
    --  [2] CurrentCamera (copy)

    NearPlaneZ = CurrentCamera.NearPlaneZ
end)
local t_3 = {}
local t = {}

local _ = function() --[[ refreshIgnoreList ]] -- line: 65
    -- upvalues:
    --  [1] t_3 (ref)
    --  [2] t (copy)

    local v8 = 1
    t_3 = {}

    for _, val in pairs(t) do
        t_3[v8] = val
        v8 += 1
    end
end

local function playerAdded(arg4) -- line: 74
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_3 (ref)

    local function characterAdded(arg5) -- line: 75
        -- upvalues:
        --  [1] t (ref)
        --  [2] arg4 (copy)
        --  [3] t_3 (ref)

        t[arg4] = arg5
        local v9 = 1
        t_3 = {}

        for _, val_1 in pairs(t) do
            t_3[v9] = val_1
            v9 += 1
        end
    end

    local function characterRemoving() -- line: 79
        -- upvalues:
        --  [1] t (ref)
        --  [2] arg4 (copy)
        --  [3] t_3 (ref)

        t[arg4] = nil
        local v10 = 1
        t_3 = {}

        for _, val_2 in pairs(t) do
            t_3[v10] = val_2
            v10 += 1
        end
    end

    arg4.CharacterAdded:Connect(characterAdded)
    arg4.CharacterRemoving:Connect(characterRemoving)

    if arg4.Character then
        t[arg4] = arg4.Character
        characterRemoving = 1
        t_3 = {}

        for _, val_3 in pairs(t) do
            t_3[characterRemoving] = val_3
            characterRemoving += 1
        end
    end
end

local function playerRemoving(arg6) -- line: 91
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_3 (ref)

    t[arg6] = nil
    local v11 = 1
    t_3 = {}

    for _, val_4 in pairs(t) do
        t_3[v11] = val_4
        v11 += 1
    end
end

Players.PlayerAdded:Connect(playerAdded)
Players.PlayerRemoving:Connect(playerRemoving)

for _, val_5 in ipairs(Players:GetPlayers()) do
    playerAdded(val_5)
end

playerRemoving = 1
t_3 = {}

for _, val_6 in pairs(t) do
    t_3[playerRemoving] = val_6
    playerRemoving += 1
end

local v13 = nil
local v14 = nil
CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function() -- line: 125
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] v14 (ref)

    local CameraSubject_1 = CurrentCamera.CameraSubject

    if CameraSubject_1:IsA("Humanoid") then
        v14 = CameraSubject_1.RootPart

        return
    end

    if CameraSubject_1:IsA("BasePart") then
        v14 = CameraSubject_1

        return
    end

    v14 = nil
end)

local _ = function(arg7) --[[ canOcclude ]] -- line: 136
    -- upvalues:
    --  [1] v13 (ref)

    local v15 = false

    if 1 - (1 - arg7.Transparency) * (1 - arg7.LocalTransparencyModifier) < 0.25 then
        v15 = arg7.CanCollide

        if v15 then
            v15 = if v13 ~= (arg7:GetRootPart() or arg7) then not arg7:IsA("TrussPart") else false
        end
    end

    return v15
end

local t_1 = {
    Vector2.new(0.4, 0),
    Vector2.new(-0.4, 0),
    Vector2.new(0, -0.4),
    Vector2.new(0, 0.4),
    Vector2.new(0, 0.2)
}

local function getCollisionPoint(arg8, arg9) -- line: 164
    -- upvalues:
    --  [1] UserRaycastPerformanceImprovements (copy)
    --  [2] raycastParams (copy)
    --  [3] t_3 (ref)
    --  [4] New (copy)

    if UserRaycastPerformanceImprovements then
        raycastParams.FilterDescendantsInstances = t_3

        while true do
            local v17 = workspace:Raycast(arg8, arg9, raycastParams)

            if v17 then
                if v17.Instance.CanCollide then
                    return v17.Position, true
                end

                raycastParams:AddToFilter(v17.Instance)
            end

            if v17 then
                continue
            end
        end
    else
        local v18 = #t_3
        local v21

        repeat
            local v22
            v21, v22 = workspace:FindPartOnRayWithIgnoreList(New(arg8, arg9), t_3, false, true)

            if v21 then
                if v21.CanCollide then
                    local v23 = t_3

                    for index_1 = #v23, v18 + 1, -1 do
                        v23[index_1] = nil
                    end

                    return v22, true
                end

                t_3[#t_3 + 1] = v21
            end
        until not v21

        local v24 = t_3

        for index_2 = #v24, v18 + 1, -1 do
            v24[index_2] = nil
        end
    end

    return arg8 + arg9, false
end

local function queryPoint(arg10, arg11, arg12, arg13) -- line: 202
    -- upvalues:
    --  [1] t_3 (ref)
    --  [2] NearPlaneZ (ref)
    --  [3] UserRaycastPerformanceImprovements (copy)
    --  [4] raycastParams (copy)
    --  [5] v13 (ref)
    --  [6] raycastParams_1 (copy)
    --  [7] New (copy)

    debug.profilebegin("queryPoint")
    local v25 = #t_3
    arg12 += NearPlaneZ
    local v26 = arg10 + arg11 * arg12
    local v27 = math.huge
    local v28 = math.huge
    local v29 = arg10
    local v30 = 0
    local v33

    if UserRaycastPerformanceImprovements then
        while true do
            raycastParams.FilterDescendantsInstances = t_3
            local v31 = v26 - v29
            local v32 = workspace:Raycast(v29, v31, raycastParams)
            v33 = nil

            if v32 then
                v33 = v32.Instance
                local Position = v32.Position
                v30 += 1
                v31 = v30 >= 64
                local v34 = false

                if 1 - (1 - v33.Transparency) * (1 - v33.LocalTransparencyModifier) < 0.25 then
                    v34 = v33.CanCollide

                    if v34 then
                        v34 = if v13 ~= (v33:GetRootPart() or v33) then not v33:IsA("TrussPart") else false
                    end
                end

                if v34 or v31 then
                    raycastParams_1.FilterDescendantsInstances = { v33 }
                    local v37 = workspace:Raycast(v26, Position - v26, raycastParams_1)
                    local Magnitude = (Position - arg10).Magnitude

                    if v37 and not v31 then
                        local v39 = if arg13 then workspace:Raycast(
                            arg13,
                            v26 - arg13,
                            raycastParams_1
                        ) or workspace:Raycast(v26, arg13 - v26, raycastParams_1) else nil

                        if v39 then
                            v28 = Magnitude
                        elseif arg12 < v27 then
                            v27 = Magnitude
                        end
                    else
                        v28 = Magnitude
                    end
                end

                raycastParams:AddToFilter(v33)
                v29 = Position - arg11 * 0.001
            end

            if not (v28 < math.huge) and v33 then
                continue
            end
        end
    else
        local v43

        repeat
            local v41 = workspace
            local v42 = New(v29, v26 - v29)
            v43, v33 = v41:FindPartOnRayWithIgnoreList(v42, t_3, false, true)
            v30 += 1

            if v43 then
                v42 = v30 >= 64
                local v44 = false

                if 1 - (1 - v43.Transparency) * (1 - v43.LocalTransparencyModifier) < 0.25 then
                    v44 = v43.CanCollide

                    if v44 then
                        v44 = if v13 ~= (v43:GetRootPart() or v43) then not v43:IsA("TrussPart") else false
                    end
                end

                if v44 or v42 then
                    local t_2 = { v43 }
                    local v46 = workspace
                    local v47 = New(v26, v33 - v26)
                    local v48 = v46:FindPartOnRayWithWhitelist(v47, t_2, true)
                    local Magnitude_1 = (v33 - arg10).Magnitude

                    if v48 and not v42 then
                        v47 = false

                        if arg13 then
                            v47 = workspace:FindPartOnRayWithWhitelist(
                                New(arg13, v26 - arg13),
                                t_2,
                                true
                            ) or workspace:FindPartOnRayWithWhitelist(
                                New(v26, arg13 - v26),
                                t_2,
                                true
                            )
                        end

                        if v47 then
                            v28 = Magnitude_1
                        elseif arg12 < v27 then
                            v27 = Magnitude_1
                        end
                    else
                        v28 = Magnitude_1
                    end
                end

                t_3[#t_3 + 1] = v43
                v29 = v33 - arg11 * 0.001
            end
        until v28 < math.huge or not v43

        local v54 = t_3

        for index_3 = #v54, v25 + 1, -1 do
            v54[index_3] = nil
        end
    end

    debug.profileend()

    return v27 - NearPlaneZ, v28 - NearPlaneZ
end

local function queryViewport(arg14, arg15) -- line: 306
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] v2 (ref)
    --  [3] v1 (ref)
    --  [4] NearPlaneZ (ref)
    --  [5] queryPoint (copy)

    debug.profilebegin("queryViewport")
    local P = arg14.p
    local RightVector = arg14.rightVector
    local UpVector = arg14.upVector
    local v55 = -arg14.lookVector
    local ViewportSize_2 = CurrentCamera.ViewportSize
    local v56 = math.huge
    local v57 = math.huge

    for index_4 = 0, 1 do
        local v58 = RightVector * ((index_4 - 0.5) * v2)

        for index_5 = 0, 1 do
            local v62, v63 = queryPoint(
                P + NearPlaneZ * (v58 + UpVector * ((index_5 - 0.5) * v1)),
                v55,
                arg15,
                CurrentCamera:ViewportPointToRay(
                    ViewportSize_2.x * index_4,
                    ViewportSize_2.y * index_5
                ).Origin
            )

            if v56 > v63 then
                v56 = v63
            end

            if v57 > v62 then
                v57 = v62
            end
        end
    end

    debug.profileend()

    return v57, v56
end

local function testPromotion(arg16, arg17, arg18) -- line: 347
    -- upvalues:
    --  [1] getCollisionPoint (copy)
    --  [2] math_min (copy)
    --  [3] queryPoint (copy)
    --  [4] t_1 (copy)

    debug.profilebegin("testPromotion")
    local P_1 = arg16.p
    local RightVector_1 = arg16.rightVector
    local UpVector_1 = arg16.upVector
    local v64 = -arg16.lookVector
    debug.profilebegin("extrapolate")

    for index_6 = 0, math_min(
        1.25,
        arg18.rotVelocity.magnitude + (getCollisionPoint(P_1, arg18.posVelocity * 1.25) - P_1).Magnitude / arg18.posVelocity.magnitude
    ), 0.0625 do
        local v65 = arg18.extrapolate(index_6)

        if arg17 <= queryPoint(v65.p, -v65.lookVector, arg17) then
            return false
        end
    end

    debug.profileend()
    debug.profilebegin("testOffsets")

    for _, val_7 in ipairs(t_1) do
        local v66 = getCollisionPoint(P_1, RightVector_1 * val_7.x + UpVector_1 * val_7.y)

        if queryPoint(v66, (P_1 + v64 * arg17 - v66).Unit, arg17) == math.huge then
            return false
        end
    end

    debug.profileend()
    debug.profileend()

    return true
end

local function Popper(arg19, arg20, arg21) -- line: 396
    -- upvalues:
    --  [1] v13 (ref)
    --  [2] v14 (ref)
    --  [3] queryViewport (copy)
    --  [4] testPromotion (copy)

    debug.profilebegin("popper")
    local v67 = v14 and v14:GetRootPart() or v14
    v13 = v67
    v67 = arg20
    local v68, v69 = queryViewport(arg19, arg20)

    if v67 > v69 then
        v67 = v69
    end

    v67 = if not (v67 > v68) then v67 else if not testPromotion(arg19, arg20, arg21) then v67 else v68
    v13 = nil
    debug.profileend()

    return v67
end

return Popper
