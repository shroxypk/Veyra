-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.Invisicam
-- Class: ModuleScript
-- bytes: 19465

local Players = game:GetService("Players")
local UserRaycastPerformanceImprovements = require(
    script.Parent.Parent:WaitForChild("CommonUtils"):WaitForChild("FlagUtil")
).getUserFlag("UserRaycastPerformanceImprovements")
local t = {
    LIMBS = 2,
    MOVEMENT = 3,
    CORNERS = 4,
    CIRCLE1 = 5,
    CIRCLE2 = 6,
    LIMBMOVE = 7,
    SMART_CIRCLE = 8,
    CHAR_OUTLINE = 9
}
local t_1 = {
    Head = true,
    ["Left Arm"] = true,
    ["Right Arm"] = true,
    ["Left Leg"] = true,
    ["Right Leg"] = true,
    LeftLowerArm = true,
    RightLowerArm = true,
    LeftUpperLeg = true,
    RightUpperLeg = true
}
local t_2 = {
    Vector3.new(1, 1, -1),
    Vector3.new(1, -1, -1),
    Vector3.new(-1, -1, -1),
    Vector3.new(-1, 1, -1)
}
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
local raycastParams_1 = RaycastParams.new()
raycastParams_1.FilterType = Enum.RaycastFilterType.Include

local function AssertTypes(arg1, ...) -- line: 71
    local t_3 = {}
    local v1 = ""

    for _, val in pairs({ ... }) do
        local v2
        t_3[val], v2 = true, v1
        v1 = v2 .. (if v1 ~= "" then " or " else "") .. val
    end

    local v4 = type(arg1)
    assert(t_3[v4], v1 .. " type expected, got: " .. v4)
end

local _ = function(
    n1: number,
    n2: number,
    n3: number,
    n4: number,
    n5: number,
    n6: number,
    n7: number,
    n8: number,
    n9: number
) --[[ Det3x3 ]] -- line: 83
    return n1 * (n5 * n9 - n6 * n8) - n2 * (n4 * n9 - n6 * n7) + n3 * (n4 * n8 - n5 * n7)
end

local function RayIntersection(vec1: Vector3, vec2: Vector3, vec3: Vector3, vec4: Vector3) -- line: 91
    local v5 = vec2:Cross(vec4)
    local v6 = vec3.X - vec1.X
    local v7 = vec3.Y - vec1.Y
    local v8 = vec3.Z - vec1.Z
    local Y = vec2.Y
    local v9 = -vec4.Y
    local Y_1 = v5.Y
    local Z = vec2.Z
    local v10 = -vec4.Z
    local Z_1 = v5.Z
    local v11 = vec2.X * (v9 * Z_1 - Y_1 * v10) - -vec4.X * (Y * Z_1 - Y_1 * Z) + v5.X * (Y * v10 - v9 * Z)

    if v11 == 0 then
        return Vector3.new(0, 0, 0)
    end

    local v12 = -vec4.Y
    local Y_2 = v5.Y
    local v13 = -vec4.Z
    local Z_2 = v5.Z
    local Y_3 = vec2.Y
    local Y_4 = v5.Y
    local Z_3 = vec2.Z
    local Z_4 = v5.Z
    local v14 = vec1 + (v6 * (v12 * Z_2 - Y_2 * v13) - -vec4.X * (v7 * Z_2 - Y_2 * v8) + v5.X * (v7 * v13 - v12 * v8)) / v11 * vec2
    local v15 = vec3 + (vec2.X * (v7 * Z_4 - Y_4 * v8) - v6 * (Y_3 * Z_4 - Y_4 * Z_3) + v5.X * (Y_3 * v8 - v7 * Z_3)) / v11 * vec4

    if (v15 - v14).Magnitude < 0.25 then
        return v14 + (v15 - v14) * 0.5
    end

    return Vector3.new(0, 0, 0)
end

local BaseOcclusion_m = require(script.Parent:WaitForChild("BaseOcclusion"))
local t_4 = setmetatable({}, BaseOcclusion_m)
t_4.__index = t_4

function t_4.new() -- line: 124
    -- upvalues:
    --  [1] BaseOcclusion_m (copy)
    --  [2] t_4 (copy)
    --  [3] t (copy)

    local t_5 = setmetatable(BaseOcclusion_m.new(), t_4)
    t_5.char = nil
    t_5.humanoidRootPart = nil
    t_5.torsoPart = nil
    t_5.headPart = nil
    t_5.childAddedConn = nil
    t_5.childRemovedConn = nil
    t_5.behaviors = {}
    t_5.behaviors[t.LIMBS] = t_5.LimbBehavior
    t_5.behaviors[t.MOVEMENT] = t_5.MoveBehavior
    t_5.behaviors[t.CORNERS] = t_5.CornerBehavior
    t_5.behaviors[t.CIRCLE1] = t_5.CircleBehavior
    t_5.behaviors[t.CIRCLE2] = t_5.CircleBehavior
    t_5.behaviors[t.LIMBMOVE] = t_5.LimbMoveBehavior
    t_5.behaviors[t.SMART_CIRCLE] = t_5.SmartCircleBehavior
    t_5.behaviors[t.CHAR_OUTLINE] = t_5.CharacterOutlineBehavior
    t_5.mode = t.SMART_CIRCLE
    t_5.behaviorFunction = t_5.SmartCircleBehavior
    t_5.savedHits = {}
    t_5.trackedLimbs = {}
    t_5.camera = game.Workspace.CurrentCamera
    t_5.enabled = false

    return t_5
end

function t_4.Enable(arg2, arg3) -- line: 157
    arg2.enabled = arg3

    if not arg3 then
        arg2:Cleanup()
    end
end

function t_4.GetOcclusionMode(_) -- line: 165
    return Enum.DevCameraOcclusionMode.Invisicam
end

function t_4.LimbBehavior(arg5, arg6) -- line: 170
    for key_1, _ in pairs(arg5.trackedLimbs) do
        arg6[#arg6 + 1] = key_1.Position
    end
end

function t_4.MoveBehavior(arg7, arg8) -- line: 176
    for index = 1, 3 do
        local Velocity = arg7.humanoidRootPart.Velocity
        arg8[#arg8 + 1] = arg7.humanoidRootPart.Position + (index - 1) * arg7.humanoidRootPart.CFrame.lookVector * (Vector3.new(
            Velocity.X,
            0,
            Velocity.Z
        ).Magnitude / 2)
    end
end

function t_4.CornerBehavior(arg9, arg10) -- line: 185
    -- upvalues:
    --  [1] t_2 (copy)

    local v18 = arg9.humanoidRootPart.CFrame
    local Position_1 = v18.Position
    local v19 = v18 - Position_1
    local v20 = arg9.char:GetExtentsSize() / 2
    arg10[#arg10 + 1] = Position_1

    for index_1 = 1, #t_2 do
        local _ = #t_2
        arg10[#arg10 + 1] = Position_1 + v19 * (v20 * t_2[index_1])
    end
end

function t_4.CircleBehavior(arg11, arg12) -- line: 196
    -- upvalues:
    --  [1] t (copy)

    local v22 = if arg11.mode ~= t.CIRCLE1 then arg11.camera.CoordinateFrame - arg11.camera.CoordinateFrame.Position + arg11.humanoidRootPart.Position else arg11.humanoidRootPart.CFrame
    arg12[#arg12 + 1] = v22.Position

    for index_2 = 0, 9 do
        local v23 = 0.6283185307179586 * index_2
        local v24 = math.cos(v23)
        arg12[#arg12 + 1] = v22 * (Vector3.new(v24, math.sin(v23), 0) * 3)
    end
end

function t_4.LimbMoveBehavior(arg13, arg14) -- line: 212
    arg13:LimbBehavior(arg14)
    arg13:MoveBehavior(arg14)
end

function t_4.CharacterOutlineBehavior(arg15, arg16) -- line: 217
    -- upvalues:
    --  [1] UserRaycastPerformanceImprovements (copy)
    --  [2] raycastParams_1 (copy)

    local Unit = arg15.torsoPart.CFrame.upVector.unit
    local Unit_1 = arg15.torsoPart.CFrame.rightVector.unit
    arg16[#arg16 + 1] = arg15.torsoPart.CFrame.p
    arg16[#arg16 + 1] = arg15.torsoPart.CFrame.p + Unit
    arg16[#arg16 + 1] = arg15.torsoPart.CFrame.p - Unit
    arg16[#arg16 + 1] = arg15.torsoPart.CFrame.p + Unit_1
    arg16[#arg16 + 1] = arg15.torsoPart.CFrame.p - Unit_1

    if arg15.headPart then
        arg16[#arg16 + 1] = arg15.headPart.CFrame.p
    end

    local cframe = CFrame.new(
        Vector3.new(0, 0, 0),
        (Vector3.new(
            arg15.camera.CoordinateFrame.lookVector.X,
            0,
            arg15.camera.CoordinateFrame.lookVector.Z
        ))
    )
    local v27 = arg15.torsoPart and arg15.torsoPart.Position or arg15.humanoidRootPart.Position
    local t_6 = { arg15.torsoPart }

    if arg15.headPart then
        t_6[#t_6 + 1] = arg15.headPart
    end

    for index_3 = 1, 24 do
        local v28 = 6.283185307179586 * index_3 / 24
        local v29 = math.cos(v28)
        local v31 = cframe * (Vector3.new(v29, math.sin(v28), 0) * 3)
        local vec3_1 = Vector3.new(v31.X, math.max(v31.Y, -2.25), v31.Z)

        if UserRaycastPerformanceImprovements then
            raycastParams_1.FilterDescendantsInstances = t_6
            local v35 = game.Workspace:Raycast(v27 + vec3_1, -3 * vec3_1, raycastParams_1)

            if v35 then
                local Position_2 = v35.Position
                arg16[#arg16 + 1] = Position_2 + 0.2 * (v27 - Position_2).unit
            end
        else
            local v36, v37 = game.Workspace:FindPartOnRayWithWhitelist(
                Ray.new(v27 + vec3_1, -3 * vec3_1),
                t_6,
                false
            )

            if v36 then
                arg16[#arg16 + 1] = v37 + 0.2 * (v27 - v37).unit
            end
        end
    end
end

function t_4.SmartCircleBehavior(arg17, arg18) -- line: 268
    -- upvalues:
    --  [1] UserRaycastPerformanceImprovements (copy)
    --  [2] raycastParams (copy)
    --  [3] RayIntersection (copy)

    local Unit_2 = arg17.torsoPart.CFrame.upVector.unit
    local Unit_3 = arg17.torsoPart.CFrame.rightVector.unit
    arg18[#arg18 + 1] = arg17.torsoPart.CFrame.p
    arg18[#arg18 + 1] = arg17.torsoPart.CFrame.p + Unit_2
    arg18[#arg18 + 1] = arg17.torsoPart.CFrame.p - Unit_2
    arg18[#arg18 + 1] = arg17.torsoPart.CFrame.p + Unit_3
    arg18[#arg18 + 1] = arg17.torsoPart.CFrame.p - Unit_3

    if arg17.headPart then
        arg18[#arg18 + 1] = arg17.headPart.CFrame.p
    end

    local v38 = arg17.camera.CFrame - arg17.camera.CFrame.p
    local v41 = Vector3.new(0, 0.5, 0) + (arg17.torsoPart and arg17.torsoPart.Position or arg17.humanoidRootPart.Position)

    for index_4 = 1, 24 do
        local v42 = 0.2617993877991494 * index_4 - 1.5707963267948966
        local v43 = math.cos(v42)
        local v45 = v41 + v38 * (Vector3.new(v43, math.sin(v42), 0) * 2.5)
        local v46 = v45 - arg17.camera.CFrame.p

        if UserRaycastPerformanceImprovements then
            raycastParams.FilterDescendantsInstances = { arg17.char }
            local v48 = game.Workspace:Raycast(v41, v45 - v41, raycastParams)
            local v49 = v45

            if v48 then
                local Normal = v48.Normal
                local v50 = v48.Position + 0.1 * Normal.unit
                local v51 = v50 - v41
                local Unit_4 = v51:Cross(v46).unit:Cross(Normal).unit
                local v52 = -Unit_4
                local Unit_5 = (v50 - arg17.camera.CFrame.p).unit

                if v51.unit:Dot(v52) < v51.unit:Dot(Unit_5) then
                    v49 = RayIntersection(v50, Unit_4, v45, v46)

                    if v49.Magnitude > 0 then
                        local v55 = game.Workspace:Raycast(v50, v49 - v50, raycastParams)

                        if v55 then
                            v49 = v55.Position + 0.1 * v55.Normal.Unit
                        end
                    else
                        v49 = v50
                    end
                else
                    v49 = v50
                end

                local v57 = game.Workspace:Raycast(v41, v49 - v41, raycastParams)

                if v57 then
                    v49 = v57.Position - 0.1 * (v49 - v41).unit
                end
            end

            arg18[#arg18 + 1] = v49
        else
            local v59, v60, v61 = game.Workspace:FindPartOnRayWithIgnoreList(
                Ray.new(v41, v45 - v41),
                { arg17.char },
                false,
                false
            )
            local v58 = v45

            if v59 then
                local v62 = v60 + 0.1 * v61.unit
                local v63 = v62 - v41
                local Unit_6 = v63:Cross(v46).unit:Cross(v61).unit
                local v64 = -Unit_6
                local Unit_7 = (v62 - arg17.camera.CFrame.p).unit

                if v63.unit:Dot(v64) < v63.unit:Dot(Unit_7) then
                    v58 = RayIntersection(v62, Unit_6, v45, v46)

                    if v58.Magnitude > 0 then
                        local v66, v67, v68 = game.Workspace:FindPartOnRayWithIgnoreList(
                            Ray.new(v62, v58 - v62),
                            { arg17.char },
                            false,
                            false
                        )

                        if v66 then
                            v58 = v67 + 0.1 * v68.unit
                        end
                    else
                        v58 = v62
                    end
                else
                    v58 = v62
                end

                local v69, v70, _ = game.Workspace:FindPartOnRayWithIgnoreList(
                    Ray.new(v41, v58 - v41),
                    { arg17.char },
                    false,
                    false
                )

                if v69 then
                    v58 = v70 - 0.1 * (v58 - v41).unit
                end
            end

            arg18[#arg18 + 1] = v58
        end
    end
end

function t_4.CheckTorsoReference(arg19) -- line: 403
    if arg19.char then
        arg19.torsoPart = arg19.char:FindFirstChild("Torso")

        if not arg19.torsoPart then
            arg19.torsoPart = arg19.char:FindFirstChild("UpperTorso")

            if not arg19.torsoPart then
                arg19.torsoPart = arg19.char:FindFirstChild("HumanoidRootPart")
            end
        end

        arg19.headPart = arg19.char:FindFirstChild("Head")
    end
end

function t_4.CharacterAdded(t1: table, u1: userdata, u2: userdata) -- line: 417
    -- upvalues:
    --  [1] Players (copy)
    --  [2] t_1 (copy)

    if u2 ~= Players.LocalPlayer then
        return
    end

    if t1.childAddedConn then
        t1.childAddedConn:Disconnect()
        t1.childAddedConn = nil
    end

    if t1.childRemovedConn then
        t1.childRemovedConn:Disconnect()
        t1.childRemovedConn = nil
    end

    t1.char = u1
    t1.trackedLimbs = {}

    local function childAdded(arg20) -- line: 433
        -- upvalues:
        --  [1] t_1 (ref)
        --  [2] t1 (copy)

        if arg20:IsA("BasePart") then
            if t_1[arg20.Name] then
                t1.trackedLimbs[arg20] = true
            end

            if arg20.Name == "Torso" or arg20.Name == "UpperTorso" then
                t1.torsoPart = arg20
            end

            if arg20.Name == "Head" then
                t1.headPart = arg20
            end
        end
    end

    local function childRemoved(arg21) -- line: 449
        -- upvalues:
        --  [1] t1 (copy)

        t1.trackedLimbs[arg21] = nil
        t1:CheckTorsoReference()
    end

    t1.childAddedConn = u1.ChildAdded:Connect(childAdded)
    t1.childRemovedConn = u1.ChildRemoved:Connect(childRemoved)

    for _, val_2 in pairs(t1.char:GetChildren()) do
        if val_2:IsA("BasePart") then
            if t_1[val_2.Name] then
                t1.trackedLimbs[val_2] = true
            end

            if val_2.Name == "Torso" or val_2.Name == "UpperTorso" then
                t1.torsoPart = val_2
            end

            if val_2.Name == "Head" then
                t1.headPart = val_2
            end
        end
    end
end

function t_4.SetMode(t2: table, n10: number) -- line: 463
    -- upvalues:
    --  [1] AssertTypes (copy)
    --  [2] t (copy)

    AssertTypes(n10, "number")

    for _, val_3 in pairs(t) do
        if val_3 == n10 then
            t2.mode = n10
            t2.behaviorFunction = t2.behaviors[t2.mode]

            return
        end
    end

    error("Invalid mode number")
end

function t_4.GetObscuredParts(arg22) -- line: 475
    return arg22.savedHits
end

function t_4.Cleanup(arg23) -- line: 480
    for key_4, val_4 in pairs(arg23.savedHits) do
        key_4.LocalTransparencyModifier = val_4
    end
end

function t_4.Update(t3: table, _: number, u3: CFrame, u4: CFrame) -- line: 486
    if not t3.enabled or not t3.char then
        return u3, u4
    end

    t3.camera = game.Workspace.CurrentCamera

    if not t3.humanoidRootPart then
        local Humanoid = t3.char:FindFirstChildOfClass("Humanoid")
        local Char
        local v73

        if Humanoid then
            if Humanoid.RootPart then
                t3.humanoidRootPart = Humanoid.RootPart
            else
                Char = t3.char:FindFirstChild("HumanoidRootPart")
                t3.humanoidRootPart = Char

                if not t3.humanoidRootPart then
                    return u3, u4
                end
            end

            v73 = nil
            v73 = t3.humanoidRootPart.AncestryChanged:Connect(function(child, parent) -- line: 511
                -- upvalues:
                --  [1] t3 (copy)
                --  [2] v73 (ref)

                if child == t3.humanoidRootPart and not parent then
                    t3.humanoidRootPart = nil

                    if v73 and v73.Connected then
                        v73:Disconnect()
                        v73 = nil
                    end
                end
            end)
        else
            Char = t3.char:FindFirstChild("HumanoidRootPart")
            t3.humanoidRootPart = Char

            if not t3.humanoidRootPart then
                return u3, u4
            end

            v73 = nil
            v73 = t3.humanoidRootPart.AncestryChanged:Connect(function(child_1, parent_1) -- line: 511
                -- upvalues:
                --  [1] t3 (copy)
                --  [2] v73 (ref)

                if child_1 == t3.humanoidRootPart and not parent_1 then
                    t3.humanoidRootPart = nil

                    if v73 and v73.Connected then
                        v73:Disconnect()
                        v73 = nil
                    end
                end
            end)
        end
    end

    if not t3.torsoPart then
        t3:CheckTorsoReference()

        if not t3.torsoPart then
            return u3, u4
        end
    end

    local t_7 = {}
    t3.behaviorFunction(t3, t_7)
    local t_8 = {}
    local t_9 = { t3.char }

    local _ = function(arg28) --[[ add ]] -- line: 537
        -- upvalues:
        --  [1] t_8 (copy)
        --  [2] t3 (copy)

        t_8[arg28] = true

        if not t3.savedHits[arg28] then
            t3.savedHits[arg28] = arg28.LocalTransparencyModifier
        end
    end

    local v74 = 0
    local t_10 = {}
    local v75 = 0.75
    local v76 = 0.75
    local v77 = t3.headPart and t3.headPart.CFrame.p or t_7[1]
    local v78 = t3.torsoPart and t3.torsoPart.CFrame.p or t_7[2]
    local v79 = t3.camera:GetPartsObscuringTarget({ v77, v78 }, t_9)

    for index_5 = 1, #v79 do
        v78 = v79[index_5]
        v74 += 1
        t_10[v78] = true

        for _, val_5 in pairs(v78:GetChildren()) do
            if not val_5:IsA("Decal") then
                if val_5:IsA("Texture") then
                    v74 += 1
                    break
                end
            else
                v74 += 1
                break
            end
        end
    end

    if v74 > 0 then
        v75 = math.pow(0.375 / v74 + 0.375, 1 / v74)
        v76 = math.pow(0.25 / v74 + 0.25, 1 / v74)
    end

    local v81 = t3.camera:GetPartsObscuringTarget(t_7, t_9)
    v74 = {}

    for index_6 = 1, #v81 do
        local v82 = v81[index_6]
        v74[v82] = t_10[v82] and v75 or v76

        if v82.Transparency < v74[v82] then
            t_8[v82] = true

            if not t3.savedHits[v82] then
                t3.savedHits[v82] = v82.LocalTransparencyModifier
            end
        end

        for _, val_6 in pairs(v82:GetChildren()) do
            if not val_6:IsA("Decal") then
                if val_6:IsA("Texture") and val_6.Transparency < v74[v82] then
                    v74[val_6] = v74[v82]
                    t_8[val_6] = true

                    if not t3.savedHits[val_6] then
                        t3.savedHits[val_6] = val_6.LocalTransparencyModifier
                    end
                end
            elseif val_6.Transparency < v74[v82] then
                v74[val_6] = v74[v82]
                t_8[val_6] = true

                if not t3.savedHits[val_6] then
                    t3.savedHits[val_6] = val_6.LocalTransparencyModifier
                end
            end
        end
    end

    for key_7, val_7 in pairs(t3.savedHits) do
        if t_8[key_7] then
            key_7.LocalTransparencyModifier = key_7.Transparency < 1 and (v74[key_7] - key_7.Transparency) / (1 - key_7.Transparency) or 0
        else
            key_7.LocalTransparencyModifier = val_7
            t3.savedHits[key_7] = nil
        end
    end

    return u3, u4
end

return t_4
