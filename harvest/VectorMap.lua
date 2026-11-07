-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.WindShakeController.WindShake.VectorMap
-- Class: ModuleScript
-- bytes: 7934

local t = {}
t.__index = t

function t.new(n1: number?) -- line: 6
    -- upvalues:
    --  [1] t (copy)

    return (setmetatable({ _voxelSize = n1 or 50, _voxels = {} }, t))
end

function t._debugDrawVoxel(t1: table, vec1: Vector3) -- line: 13
    local Part = Instance.new("Part")
    Part.Name = tostring(vec1)
    Part.Anchored = true
    Part.CanCollide = false
    Part.Transparency = 1
    Part.Size = Vector3.new(1, 1, 1) * t1._voxelSize
    Part.Position = vec1 * t1._voxelSize + Vector3.new(1, 1, 1) * (t1._voxelSize / 2)
    Part.Parent = workspace
    local SelectionBox = Instance.new("SelectionBox")
    SelectionBox.Color3 = Color3.new(0, 0, 1)
    SelectionBox.Adornee = Part
    SelectionBox.Parent = Part
    task.delay(0.03333333333333333, Part.Destroy, Part)
end

function t.AddObject(t2: table, vec2: Vector3, arg1: any) -- line: 31
    local ClassName = arg1.ClassName
    local VoxelSize = t2._voxelSize
    local v1 = math.floor(vec2.X / VoxelSize)
    local v2 = math.floor(vec2.Y / VoxelSize)
    local v3 = math.floor(vec2.Z / VoxelSize)
    local vec3 = Vector3.new(v1, v2, v3)
    local v4 = t2._voxels[vec3]

    if v4 == nil then
        t2._voxels[vec3] = { [ClassName] = { arg1 } }

        return vec3
    end

    if v4[ClassName] == nil then
        v4[ClassName] = { arg1 }

        return vec3
    end

    table.insert(v4[ClassName], arg1)

    return vec3
end

function t.RemoveObject(t3: table, vec4: Vector3, arg2: any) -- line: 56
    local v5 = t3._voxels[vec4]

    if v5 == nil then
        return
    end

    local ClassName_1 = arg2.ClassName

    if v5[ClassName_1] == nil then
        return
    end

    local v6 = v5[ClassName_1]

    for key, val in v6 do
        if val == arg2 then
            local v7 = #v6
            v6[key] = v6[v7]
            v6[v7] = nil
            break
        end
    end

    if #v6 == 0 then
        v5[ClassName_1] = nil

        if next(v5) == nil then
            t3._voxels[vec4] = nil
        end
    end
end

function t.GetVoxel(t4: table, vec5: Vector3) -- line: 90
    return t4._voxels[vec5]
end

function t.ForEachObjectInRegion(t5: table, vec6: Vector3, vec7: Vector3, f1: (...any) -> ...any) -- line: 94
    local VoxelSize_1 = t5._voxelSize
    local v8 = math.min(vec7.X, vec6.X)
    local v9 = math.min(vec7.Y, vec6.Y)
    local v10 = math.min(vec7.Z, vec6.Z)
    local v11 = math.max(vec7.X, vec6.X)
    local v12 = math.max(vec7.Y, vec6.Y)
    local v13 = math.max(vec7.Z, vec6.Z)

    for index = math.floor(v8 / VoxelSize_1), math.floor(v11 / VoxelSize_1) do
        for index_1 = math.floor(v10 / VoxelSize_1), math.floor(v13 / VoxelSize_1) do
            for index_2 = math.floor(v9 / VoxelSize_1), math.floor(v12 / VoxelSize_1) do
                local v17 = t5._voxels[Vector3.new(index, index_2, index_1)]
                local _ = math.floor(v11 / VoxelSize_1)
                local _ = math.floor(v13 / VoxelSize_1)
                local _ = math.floor(v12 / VoxelSize_1)

                if v17 then
                    for key_1, val_1 in v17 do
                        for _, val_2 in val_1 do
                            f1(key_1, val_2)
                        end
                    end
                end
            end
        end
    end
end

function t.ForEachObjectInView(t6: table, u1: userdata, n2: number, f2: (...any) -> ...any) -- line: 117
    local VoxelSize_2 = t6._voxelSize
    local v21 = u1.CFrame
    local Position = v21.Position
    local RightVector = v21.RightVector
    local UpVector = v21.UpVector
    local v22 = n2 / 2
    local v23 = math.rad((u1.FieldOfView + 5) / 2)
    local v24 = math.tan(v23) * n2
    local v25 = v24 * (u1.ViewportSize.X / u1.ViewportSize.Y)
    local v26 = v21 * CFrame.new(0, 0, -n2)
    local v27 = v26 * Vector3.new(-v25, v24, 0)
    local v28 = v26 * Vector3.new(v25, v24, 0)
    local v29 = v26 * Vector3.new(-v25, -v24, 0)
    local v30 = v26 * Vector3.new(v25, -v24, 0)
    local v31 = (v21 * CFrame.new(0, 0, -v22)):Inverse()
    local v32 = v30 - Position
    local v33 = v29 - Position
    local Unit = UpVector:Cross(v32).Unit
    local Unit_1 = UpVector:Cross(v33).Unit
    local Unit_2 = RightVector:Cross(Position - v28).Unit
    local Unit_3 = RightVector:Cross(Position - v30).Unit
    local v34 = Position:Min(v27):Min(v28):Min(v29):Min(v30)
    local v35 = Position:Max(v27):Max(v28):Max(v29):Max(v30)
    local v36 = math.floor(v34.X / VoxelSize_2)
    local v37 = math.floor(v34.Y / VoxelSize_2)
    local v38 = math.floor(v34.Z / VoxelSize_2)
    local vec3_1 = Vector3.new(v36, v37, v38)
    local v39 = math.floor(v35.X / VoxelSize_2)
    local v40 = math.floor(v35.Y / VoxelSize_2)
    local v41 = math.floor(v35.Z / VoxelSize_2)
    local vec3_2 = Vector3.new(v39, v40, v41)

    local function isPointInView(vec8: Vector3) -- line: 155
        -- upvalues:
        --  [1] v31 (copy)
        --  [2] v25 (copy)
        --  [3] v24 (copy)
        --  [4] v22 (copy)
        --  [5] Position (copy)
        --  [6] Unit (copy)
        --  [7] Unit_1 (copy)
        --  [8] Unit_2 (copy)
        --  [9] Unit_3 (copy)

        local v42 = v31 * vec8

        if v42.X > v25 or v42.X < -v25 or v42.Y > v24 or v42.Y < -v24 or v42.Z > v22 or v42.Z < -v22 then
            return false
        end

        local v43 = vec8 - Position

        if not (Unit:Dot(v43) < 0) then
            if not (Unit_1:Dot(v43) > 0) then
                if not (Unit_2:Dot(v43) < 0) then
                    if Unit_3:Dot(v43) > 0 then
                        return false
                    end

                    return true
                else
                    return false
                end
            else
                return false
            end
        else
            return false
        end
    end

    for index_3 = vec3_1.X, vec3_2.X do
        local v44 = index_3 * VoxelSize_2
        local _ = vec3_2.X
        local v45 = math.clamp(v26.X, v44, v44 + VoxelSize_2)

        for index_4 = vec3_1.Y, vec3_2.Y do
            local v46 = index_4 * VoxelSize_2
            local _ = vec3_2.Y
            local v47 = math.clamp(v26.Y, v46, v46 + VoxelSize_2)

            for index_5 = vec3_1.Z, vec3_2.Z do
                local v48 = index_5 * VoxelSize_2
                local _ = vec3_2.Z

                if isPointInView(
                    (Vector3.new(v45, v47, (math.clamp(v26.Z, v48, v48 + VoxelSize_2))))
                ) then
                    local v51 = vec3_1.Z - 1
                    v48 = index_5
                    local v52 = vec3_2.Z

                    while v52 >= v48 do
                        local v53 = math.floor((v48 + v52) / 2)

                        if isPointInView(
                            (Vector3.new(
                                v45,
                                v47,
                                (math.clamp(
                                    v26.Z,
                                    v53 * VoxelSize_2,
                                    v53 * VoxelSize_2 + VoxelSize_2
                                ))
                            ))
                        ) then
                            v51 = v53
                            v48 = v53 + 1
                            continue
                        end

                        v52 = v53 - 1
                    end

                    for index_6 = index_5, v51 do
                        v48 = t6._voxels[Vector3.new(index_3, index_4, index_6)]

                        if v48 then
                            for key_3, val_3 in v48 do
                                for _, val_4 in val_3 do
                                    f2(key_3, val_4)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function t.ClearAll(arg3) -- line: 238
    arg3._voxels = {}
end

return t
