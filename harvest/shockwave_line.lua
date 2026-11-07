-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.effects.shockwave_line
-- Class: ModuleScript
-- bytes: 16634

local CollectionService = game:GetService("CollectionService")
local ModAttributes_m = require("../mod/attributes")
local ModTween_m = require("../mod/tween")
local _ = require("../types")
local ModLogger_m = require("../mod/logger")
local ModUtility_m = require("../mod/utility")
local ObjBezier_m = require("../obj/Bezier")
local PkgPromise_m = require("../pkg/Promise")
local _ = require("../obj/ObjectCache")
local rng = Random.new()
local t = {}
local v1 = nil

function t.init(arg1) -- line: 19
    -- upvalues:
    --  [1] v1 (ref)

    v1 = arg1
end

function t.deinit() -- line: 23
    -- upvalues:
    --  [1] v1 (ref)

    v1 = nil
end

function t.emit(u1: userdata, u2: userdata, arg2: any) -- line: 27
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] ModAttributes_m (copy)
    --  [3] CollectionService (copy)
    --  [4] ModUtility_m (copy)
    --  [5] ModTween_m (copy)
    --  [6] ModLogger_m (copy)
    --  [7] ObjBezier_m (copy)
    --  [8] rng (copy)
    --  [9] PkgPromise_m (copy)

    if not v1 then
        return
    end

    local v2 = ModAttributes_m.get(u1, "RayDirection", Vector3.new(0, -50, 0))
    local v3 = ModAttributes_m.get(u1, "RayCollisionGroup", "Default")
    local v4 = ModAttributes_m.get(u1, "FilterTag", "")
    local v5 = ModAttributes_m.get(u1, "FilterType", "Exclude")
    local v6 = true
    local v7 = ModAttributes_m.get(u1, "IgnoreWater", v6)
    v6 = "IgnoreCanCollide"
    local v8 = false
    local v9 = ModAttributes_m.get(u1, v6, v8)
    local raycastParams = RaycastParams.new()
    raycastParams.CollisionGroup = v3
    raycastParams.IgnoreWater = v7
    v6 = not v9
    raycastParams.RespectCanCollide = v6
    v8 = Enum.RaycastFilterType
    v6 = v8[v5]
    raycastParams.FilterType = v6
    v6 = CollectionService:GetTagged(v4)
    raycastParams.FilterDescendantsInstances = v6
    local v11

    if v5 == "Exclude" then
        v11 = workspace.Terrain
        raycastParams:AddToFilter({ v11 })
    end

    v6 = ModAttributes_m.get
    v8 = u2
    v11 = 0
    v6 = v6(v8, "EmitDelay", v11)
    local v13 = v6
    v6 = ModAttributes_m.get
    v8 = u2
    v11 = 30
    v6 = v6(v8, "Rate_Start", v11)
    v8 = ModAttributes_m.get
    local v15 = u2
    v11 = "Rate_End"
    v8 = v8(v15, v11, 30)
    local Get = ModAttributes_m.get
    v11 = u2
    local v17 = Get(v11, "FixedAmount", 0)
    local Get_1 = ModAttributes_m.get
    v11 = u2
    local v19 = Get_1(v11, "Scale_Start", 1)
    local Get_2 = ModAttributes_m.get
    v11 = u2
    local v21 = Get_2(v11, "Scale_End", 1)
    local v22 = ModAttributes_m.get
    v11 = u2
    v22 = v22(v11, "Duration", 1)
    v11 = ModAttributes_m.get(u2, "Direction", Vector3.new(0, 0, -1))
    local v23 = ModAttributes_m.get(u2, "Length", 50)
    local Rotation = ModAttributes_m.getRange(u2, "Rotation", NumberRange.new(-180, 180))
    local v25 = ModAttributes_m.get(u2, "PartOffset", Vector3.new(0, 0, 0), true)
    local v26 = ModAttributes_m.get(u2, "BaseOffset", v25)
    local v27 = ModAttributes_m.get(u2, "Offset_Start", v25)
    local v28 = ModAttributes_m.get(u2, "Offset_End", v25)
    local v29 = ModAttributes_m.get(u2, "Offset_Start_Duration", 0.5)
    local v30 = ModAttributes_m.get(u2, "Offset_End_Duration", 0.5)
    local Lifetime = ModAttributes_m.getRange(
        u2,
        "Lifetime",
        NumberRange.new(2, 3),
        NumberRange.new(0, math.huge)
    )
    local v32 = ModAttributes_m.get(u2, "SizeScaleStart", Vector3.new(0, 0, 0))
    local v33 = ModAttributes_m.get(u2, "SizeScaleEnd", Vector3.new(0, 0, 0))
    local v34 = ModAttributes_m.get(u2, "MinSize", Vector3.new(2, 1, 2))
    local v35 = ModAttributes_m.get(u2, "MaxSize", Vector3.new(3, 2, 3))
    local v36 = ModAttributes_m.get(u2, "Size_Curve", ModUtility_m.default_bezier, true)
    local v37 = ModAttributes_m.get(u2, "Size_Duration", 0.5, true)
    local v38 = ModAttributes_m.get(u2, "Size_Start_Curve", v36)
    local v39 = ModAttributes_m.get(u2, "Size_End_Curve", v36)
    local v40 = ModAttributes_m.get(u2, "Size_Start_Duration", v37)
    local v41 = ModAttributes_m.get(u2, "Size_End_Duration", v37)
    local v43 = ModAttributes_m.get(u2, "Transparency_Duration", 0.5)
    local v45 = ModAttributes_m.get(u2, "Transparency_Start", 0)
    local v48 = ModAttributes_m.get(u2, "Transparency_End", 0)
    local v52 = ModAttributes_m.get(u2, "SyncPosition", false)
    local v55 = math.max(v22, 0.001)

    if v17 > 0 then
        local v57 = v17 / v55
        v6 = v57
        v8 = v57
    end

    v11 = v11.Unit
    v11 = if v11 == v11 then v11 else Vector3.new(-0, -0, -1)
    task.wait(v13)
    local t_2 = {}
    local v59 = ModUtility_m.getTransformedOriginExtents(u1)
    local v61 = 0
    local v62 = 0
    local v63 = v6
    local v64 = v19

    if v19 ~= v21 then
        table.insert(arg2, ModTween_m.fromParams(ModAttributes_m.get(
            u2,
            "Scale_Curve",
            ModUtility_m.default_bezier
        ), v55, function(arg3, arg4) -- line: 131
            -- upvalues:
            --  [1] v64 (ref)
            --  [2] ModUtility_m (ref)
            --  [3] v19 (copy)
            --  [4] v21 (copy)

            v64 = ModUtility_m.lerp(v19, v21, arg3)

            return arg4
        end))
    end

    if v6 ~= v8 then
        table.insert(arg2, ModTween_m.fromParams(ModAttributes_m.get(
            u2,
            "Rate_Curve",
            ModUtility_m.default_bezier
        ), v55, function(arg5, arg6) -- line: 141
            -- upvalues:
            --  [1] v63 (ref)
            --  [2] ModUtility_m (ref)
            --  [3] v6 (ref)
            --  [4] v8 (ref)

            v63 = ModUtility_m.lerp(v6, v8, arg5)

            return arg6
        end))
    end

    local v67 = ModAttributes_m.get(u2, "Path_Curve", ModUtility_m.linear_bezier)
    local Success, Result = pcall(function() -- line: 150
        -- upvalues:
        --  [1] ModUtility_m (ref)
        --  [2] v67 (copy)

        return ModUtility_m.deserializePath(v67)
    end)

    if not Success then
        ModLogger_m.error(`failed to decode bezier path data with error: {Result}`)
    end

    local v68 = ObjBezier_m.new(Result, 0)
    table.insert(arg2, ModTween_m.fromParams(
        ModUtility_m.linear_bezier,
        v55,
        function(_, arg8) -- line: 162
            -- upvalues:
            --  [1] v61 (ref)
            --  [2] v63 (ref)
            --  [3] v55 (ref)
            --  [4] v62 (ref)
            --  [5] v68 (copy)
            --  [6] v52 (copy)
            --  [7] v59 (ref)
            --  [8] ModUtility_m (ref)
            --  [9] u1 (copy)
            --  [10] v11 (ref)
            --  [11] v23 (copy)
            --  [12] v2 (copy)
            --  [13] raycastParams (copy)
            --  [14] rng (ref)
            --  [15] v34 (copy)
            --  [16] v35 (copy)
            --  [17] v1 (ref)
            --  [18] u2 (copy)
            --  [19] arg2 (copy)
            --  [20] v45 (copy)
            --  [21] Rotation (copy)
            --  [22] v27 (copy)
            --  [23] v26 (copy)
            --  [24] ModTween_m (ref)
            --  [25] ModAttributes_m (ref)
            --  [26] v29 (copy)
            --  [27] v64 (ref)
            --  [28] v32 (copy)
            --  [29] v38 (copy)
            --  [30] v40 (copy)
            --  [31] t_2 (copy)
            --  [32] Lifetime (copy)
            --  [33] v33 (copy)
            --  [34] v39 (copy)
            --  [35] v41 (copy)
            --  [36] v28 (copy)
            --  [37] v30 (copy)
            --  [38] v48 (copy)
            --  [39] v43 (copy)

            v61 += arg8
            local v69 = 1 / v63
            local v70 = v55 * v63

            if v69 > v61 or v70 <= v62 then
                return arg8
            end

            local v76, v83, v85, v86, v89

            for _ = 1, v61 // v69 do
                local _ = v61 // v69

                if not (v70 <= v62) then
                    v62 += 1
                    local v72 = 1 - v68:getEase((math.clamp(v62 / v70, 0, 1))).y

                    if v52 then
                        v59 = ModUtility_m.getTransformedOriginExtents(u1)
                    end

                    local v73 = ModUtility_m.getTransformedOriginExtents(u1)
                    local v77 = workspace:Raycast(
                        v59.Position + v59:VectorToWorldSpace(v11) * v23 * v72,
                        v73:VectorToWorldSpace(v2),
                        raycastParams
                    )

                    if not v77 then
                        v61 = 0

                        return arg8
                    end

                    local v78 = rng:NextNumber(v34.X, v35.X)
                    local v79 = rng:NextNumber(v34.Y, v35.Y)
                    local v80 = rng:NextNumber(v34.Z, v35.Z)
                    local v76 = ModUtility_m.getRandomId()
                    local v81 = v1:get(v76)
                    local v82 = v81._getReal()
                    ModUtility_m.copyProperties(u2, v82, ModUtility_m.COPY_PART_PROPERTIES)
                    ModUtility_m.copyProperties(u2, v82, ModUtility_m.COPY_EXTENDED_PART_PROPERTIES)

                    if #u2:GetChildren() ~= 0 then
                        v83 = u2:Clone()

                        for _, child in v83:GetChildren() do
                            child.Parent = v82
                        end

                        v83:Destroy()
                    end

                    local v83 = arg2.effects.prepareEmitOnFinish(v82, arg2)
                    table.insert(arg2, function() -- line: 226
                        -- upvalues:
                        --  [1] v1 (ref)
                        --  [2] v76 (copy)

                        if v1 then
                            v1:free(v76)
                        end
                    end)
                    v81.Color = v77.Instance.Color
                    v81.Material = v77.Material
                    v81.Transparency = v77.Instance.Transparency

                    if v81.Transparency == 0 then
                        v81.Transparency = v45
                    end

                    v81.Size = Vector3.new(0, 0, 0)
                    local v84 = rng:NextNumber(Rotation.Min, Rotation.Max)
                    local Unit = v73:VectorToWorldSpace(
                        (Vector3.new(-math.cos(v84), 0, -math.sin(v84)))
                    ):Cross(v77.Normal).Unit
                    v86 = CFrame.fromMatrix(v77.Position, Unit, v77.Normal)
                    local v85 = v86 * CFrame.fromOrientation(-math.atan(v79 / v80), 0, 0)
                    v86 = CFrame.new(v27) * v85
                    v81.CFrame = v86
                    v86 = nil
                    v89 = nil
                    local v90 = Vector3.new(0, 0, 0)

                    if v27 ~= v26 then
                        v89 = ModTween_m.fromParams(ModAttributes_m.get(
                            u2,
                            "Offset_Start_Curve",
                            ModUtility_m.default_bezier
                        ), v29, function(arg9, arg10) -- line: 264
                            -- upvalues:
                            --  [1] v90 (ref)
                            --  [2] v27 (ref)
                            --  [3] v26 (ref)
                            --  [4] v81 (copy)
                            --  [5] v85 (copy)

                            v90 = v27:Lerp(v26, arg9)
                            v81.CFrame = CFrame.new(v90) * v85

                            return arg10
                        end)
                        table.insert(arg2, v89)
                    end

                    local v93 = Vector3.new(v78, v79, v80) * v64

                    if v93 * v32 ~= v93 then
                        v86 = ModTween_m.fromParams(v38, v40, function(arg11, arg12) -- line: 277
                            -- upvalues:
                            --  [1] v81 (copy)
                            --  [2] v93 (copy)
                            --  [3] v32 (ref)

                            v81.Size = (v93 * v32):Lerp(v93, arg11)

                            return arg12
                        end)
                        table.insert(arg2, v86)
                    else
                        v81.Size = v93 * v32
                    end

                    table.insert(t_2, arg2.effects.emitNested(v82, arg2.depth + 1, arg2).Finished)
                    task.delay(rng:NextNumber(Lifetime.Min, Lifetime.Max), function() -- line: 290
                        -- upvalues:
                        --  [1] v86 (ref)
                        --  [2] v89 (ref)
                        --  [3] v81 (copy)
                        --  [4] v93 (copy)
                        --  [5] v33 (ref)
                        --  [6] arg2 (ref)
                        --  [7] ModTween_m (ref)
                        --  [8] v39 (ref)
                        --  [9] v41 (ref)
                        --  [10] v90 (ref)
                        --  [11] v28 (ref)
                        --  [12] ModAttributes_m (ref)
                        --  [13] u2 (ref)
                        --  [14] ModUtility_m (ref)
                        --  [15] v30 (ref)
                        --  [16] v85 (copy)
                        --  [17] v48 (ref)
                        --  [18] v43 (ref)
                        --  [19] v83 (copy)
                        --  [20] v82 (copy)
                        --  [21] t_2 (ref)

                        if v86 then
                            v86:Disconnect()
                        end

                        if v89 then
                            v89:Disconnect()
                        end

                        local Size = v81.Size
                        local Transparency = v81.Transparency

                        if Size ~= v93 * v33 then
                            table.insert(arg2, ModTween_m.fromParams(v39, v41, function(
                                arg13,
                                arg14
                            ) -- line: 305
                                -- upvalues:
                                --  [1] v81 (ref)
                                --  [2] Size (copy)
                                --  [3] v93 (ref)
                                --  [4] v33 (ref)

                                v81.Size = Size:Lerp(v93 * v33, arg13)

                                return arg14
                            end))
                        end

                        if v90 ~= v28 then
                            table.insert(arg2, ModTween_m.fromParams(ModAttributes_m.get(
                                u2,
                                "Offset_End_Curve",
                                ModUtility_m.default_bezier
                            ), v30, function(arg15, arg16) -- line: 318
                                -- upvalues:
                                --  [1] v81 (ref)
                                --  [2] v90 (ref)
                                --  [3] v28 (ref)
                                --  [4] v85 (ref)

                                v81.CFrame = CFrame.new(v90:Lerp(v28, arg15)) * v85

                                return arg16
                            end))
                        end

                        if Transparency ~= v48 then
                            table.insert(arg2, ModTween_m.fromParams(ModAttributes_m.get(
                                u2,
                                "Transparency_Curve",
                                ModUtility_m.default_bezier
                            ), v43, function(arg17, arg18) -- line: 332
                                -- upvalues:
                                --  [1] v81 (ref)
                                --  [2] ModUtility_m (ref)
                                --  [3] Transparency (copy)
                                --  [4] v48 (ref)

                                v81.Transparency = ModUtility_m.lerp(Transparency, v48, arg17)

                                return arg18
                            end))
                        end

                        table.insert(
                            t_2,
                            arg2.effects.emitOnFinish(v83, v82, arg2.depth + 1, arg2).Finished
                        )
                    end)
                end
            end

            v61 %= v69

            return arg8
        end,
        nil,
        nil,
        true,
        ModUtility_m.RENDER_PRIORITY + arg2.depth
    ))
    task.wait(Lifetime.Max + v55 + math.max(v41, v30))
    PkgPromise_m.all(t_2):await()
end

return t
