-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.effects.shockwave_ring
-- Class: ModuleScript
-- bytes: 10504

local CollectionService = game:GetService("CollectionService")
local ModAttributes_m = require("../mod/attributes")
local ModTween_m = require("../mod/tween")
local _ = require("../types")
local ModUtility_m = require("../mod/utility")
local PkgPromise_m = require("../pkg/Promise")
local _ = require("../obj/ObjectCache")
local rng = Random.new()
local t = {}
local v1 = nil

function t.init(arg1) -- line: 17
    -- upvalues:
    --  [1] v1 (ref)

    v1 = arg1
end

function t.deinit() -- line: 21
    -- upvalues:
    --  [1] v1 (ref)

    v1 = nil
end

function t.emit(u1: userdata, u2: userdata, arg2: any) -- line: 25
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] ModAttributes_m (copy)
    --  [3] CollectionService (copy)
    --  [4] ModUtility_m (copy)
    --  [5] rng (copy)
    --  [6] ModTween_m (copy)
    --  [7] PkgPromise_m (copy)

    if not v1 then
        return
    end

    local v2 = ModAttributes_m.get(u1, "RayDirection", Vector3.new(0, -50, 0))
    local v3 = ModAttributes_m.get(u1, "RayCollisionGroup", "Default")
    local v5 = ModAttributes_m.get(u1, "FilterTag", "")
    local v7 = ModAttributes_m.get(u1, "FilterType", "Exclude")
    local v9 = ModAttributes_m.get(u1, "IgnoreWater", true)
    local v10 = ModAttributes_m.get(u1, "IgnoreCanCollide", false)
    local raycastParams = RaycastParams.new()
    raycastParams.CollisionGroup = v3
    raycastParams.IgnoreWater = v9
    raycastParams.RespectCanCollide = not v10
    raycastParams.FilterType = Enum.RaycastFilterType[v7]
    raycastParams.FilterDescendantsInstances = CollectionService:GetTagged(v5)

    if v7 == "Exclude" then
        raycastParams:AddToFilter({ workspace.Terrain })
    end

    local v13 = ModAttributes_m.get(u2, "EmitDelay", 0)
    local v15 = ModAttributes_m.get(u2, "Radius", 5)
    local v17 = ModAttributes_m.get(u2, "Segments", 7)
    local Lifetime = ModAttributes_m.getRange(
        u2,
        "Lifetime",
        NumberRange.new(2, 3),
        NumberRange.new(0, math.huge)
    )
    local v20 = ModAttributes_m.get(u2, "PartOffset", Vector3.new(0, 0, 0), true)
    local v22 = ModAttributes_m.get(u2, "BaseOffset", v20)
    local v24 = ModAttributes_m.get(u2, "Offset_Start", v20)
    local v26 = ModAttributes_m.get(u2, "Offset_End", v20)
    local v28 = ModAttributes_m.get(u2, "Offset_Start_Duration", 0.5)
    local v29 = ModAttributes_m.get(u2, "Offset_End_Duration", 0.5)
    local v30 = ModAttributes_m.get(u2, "SizeScaleStart", Vector3.new(0, 0, 0))
    local v31 = ModAttributes_m.get(u2, "SizeScaleEnd", Vector3.new(0, 0, 0))
    local v32 = ModAttributes_m.get(u2, "MinSize", Vector3.new(2, 1, 2))
    local v33 = ModAttributes_m.get(u2, "MaxSize", Vector3.new(3, 2, 3))
    local v35 = ModAttributes_m.get(u2, "Size_Curve", ModUtility_m.default_bezier, true)
    local v37 = ModAttributes_m.get(u2, "Size_Duration", 0.5, true)
    local v39 = ModAttributes_m.get(u2, "Size_Start_Curve", v35)
    local v41 = ModAttributes_m.get(u2, "Size_End_Curve", v35)
    local v43 = ModAttributes_m.get(u2, "Size_Start_Duration", v37)
    local v44 = ModAttributes_m.get(u2, "Size_End_Duration", v37)
    local v45 = ModAttributes_m.get(u2, "Transparency_Duration", 0.5)
    local v46 = ModAttributes_m.get(u2, "Transparency_Start", 0)
    local v47 = ModAttributes_m.get(u2, "Transparency_End", 0)
    task.wait(v13)
    local t_1 = {}
    local v48 = ModUtility_m.getTransformedOriginExtents(u1)
    local v60, v61, v62, v69

    for index = 0, v17 - 1 do
        local v49 = index / v17 * 3.141592653589793 * 2
        local v50 = v15 * math.cos(v49)
        local v53 = workspace:Raycast(
            (v48 * CFrame.new(v50, 0, v15 * math.sin(v49))).Position,
            v48:VectorToWorldSpace(v2),
            raycastParams
        )

        if v53 then
            local v54 = rng:NextNumber(v32.X, v33.X)
            local v55 = rng:NextNumber(v32.Y, v33.Y)
            local v56 = rng:NextNumber(v32.Z, v33.Z)
            local v57 = ModUtility_m.getRandomId()
            local v58 = v1:get(v57)
            local v59 = v58._getReal()
            v60 = v59
            v61 = ModUtility_m.COPY_PART_PROPERTIES
            ModUtility_m.copyProperties(u2, v60, v61)
            v60 = v59
            v61 = ModUtility_m.COPY_EXTENDED_PART_PROPERTIES
            ModUtility_m.copyProperties(u2, v60, v61)

            if #u2:GetChildren() ~= 0 then
                v62 = u2:Clone()

                for _, child in v62:GetChildren() do
                    child.Parent = v59
                end

                v62:Destroy()
            end

            local v63 = arg2.effects.prepareEmitOnFinish(v58, arg2)

            function v60() -- line: 130
                -- upvalues:
                --  [1] v1 (ref)
                --  [2] v57 (copy)

                if v1 then
                    v1:free(v57)
                end
            end

            table.insert(arg2, v60)
            v58.Color = v53.Instance.Color
            v58.Material = v53.Material
            v58.Transparency = v53.Instance.Transparency

            if v58.Transparency == 0 then
                v58.Transparency = v46
            end

            v58.Size = Vector3.new(0, 0, 0)
            v60 = v49
            v62 = -math.cos(v60)
            v61 = v49
            v60 = math.sin(v61)
            v60 = v48:VectorToWorldSpace((Vector3.new(v62, 0, -v60)))
            v61 = v53.Normal
            local Unit = v60:Cross(v61).Unit
            v60 = CFrame.fromMatrix
            v61 = v53.Position
            v60 = v60(v61, Unit, v53.Normal)
            v61 = CFrame.fromOrientation(-math.atan(v55 / v56), 0, 0)
            local v67 = v60 * v61
            v61 = CFrame.new(v24)
            v60 = v61 * v67
            v58.CFrame = v60
            v60 = nil
            v61 = nil
            v69 = Vector3.new(0, 0, 0)

            if v24 ~= v22 then
                v61 = ModTween_m.fromParams(ModAttributes_m.get(
                    u2,
                    "Offset_Start_Curve",
                    ModUtility_m.default_bezier
                ), v28, function(arg3, arg4) -- line: 166
                    -- upvalues:
                    --  [1] v69 (ref)
                    --  [2] v24 (copy)
                    --  [3] v22 (copy)
                    --  [4] v58 (copy)
                    --  [5] v67 (copy)

                    v69 = v24:Lerp(v22, arg3)
                    v58.CFrame = CFrame.new(v69) * v67

                    return arg4
                end)
                table.insert(arg2, v60)
            end

            local vec3 = Vector3.new(v54, v55, v56)

            if vec3 * v30 ~= vec3 then
                v60 = ModTween_m.fromParams(v39, v43, function(arg5, arg6) -- line: 179
                    -- upvalues:
                    --  [1] v58 (copy)
                    --  [2] vec3 (copy)
                    --  [3] v30 (copy)

                    v58.Size = (vec3 * v30):Lerp(vec3, arg5)

                    return arg6
                end)
                table.insert(arg2, v60)
            else
                v58.Size = vec3 * v30
            end

            table.insert(t_1, arg2.effects.emitNested(v58, arg2.depth + 1, arg2).Finished)
            task.delay(rng:NextNumber(Lifetime.Min, Lifetime.Max), function() -- line: 192
                -- upvalues:
                --  [1] v60 (ref)
                --  [2] v61 (ref)
                --  [3] v58 (copy)
                --  [4] vec3 (copy)
                --  [5] v31 (copy)
                --  [6] arg2 (copy)
                --  [7] ModTween_m (ref)
                --  [8] v41 (copy)
                --  [9] v44 (copy)
                --  [10] v69 (ref)
                --  [11] v26 (copy)
                --  [12] ModAttributes_m (ref)
                --  [13] u2 (copy)
                --  [14] ModUtility_m (ref)
                --  [15] v29 (copy)
                --  [16] v67 (copy)
                --  [17] v47 (copy)
                --  [18] v45 (copy)
                --  [19] v63 (copy)
                --  [20] t_1 (copy)

                if v60 then
                    v60:Disconnect()
                end

                if v61 then
                    v61:Disconnect()
                end

                local Size = v58.Size
                local Transparency = v58.Transparency

                if Size ~= vec3 * v31 then
                    table.insert(arg2, ModTween_m.fromParams(v41, v44, function(arg7, arg8) -- line: 207
                        -- upvalues:
                        --  [1] v58 (ref)
                        --  [2] Size (copy)
                        --  [3] vec3 (ref)
                        --  [4] v31 (ref)

                        v58.Size = Size:Lerp(vec3 * v31, arg7)

                        return arg8
                    end))
                end

                if v69 ~= v26 then
                    table.insert(arg2, ModTween_m.fromParams(ModAttributes_m.get(
                        u2,
                        "Offset_End_Curve",
                        ModUtility_m.default_bezier
                    ), v29, function(arg9, arg10) -- line: 220
                        -- upvalues:
                        --  [1] v58 (ref)
                        --  [2] v69 (ref)
                        --  [3] v26 (ref)
                        --  [4] v67 (ref)

                        v58.CFrame = CFrame.new(v69:Lerp(v26, arg9)) * v67

                        return arg10
                    end))
                end

                if Transparency ~= v47 then
                    table.insert(arg2, ModTween_m.fromParams(ModAttributes_m.get(
                        u2,
                        "Transparency_Curve",
                        ModUtility_m.default_bezier
                    ), v45, function(arg11, arg12) -- line: 234
                        -- upvalues:
                        --  [1] v58 (ref)
                        --  [2] ModUtility_m (ref)
                        --  [3] Transparency (copy)
                        --  [4] v47 (ref)

                        v58.Transparency = ModUtility_m.lerp(Transparency, v47, arg11)

                        return arg12
                    end))
                end

                table.insert(
                    t_1,
                    arg2.effects.emitOnFinish(v63, v58, arg2.depth + 1, arg2).Finished
                )
            end)
        end
    end

    task.wait(Lifetime.Max + math.max(v44, v29))
    PkgPromise_m.all(t_1):await()
end

return t
