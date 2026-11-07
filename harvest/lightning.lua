-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.effects.lightning
-- Class: ModuleScript
-- bytes: 71786

local ModAttributes_m = require("../mod/attributes")
local ModTween_m = require("../mod/tween")
local _ = require("../types")
local ModUtility_m = require("../mod/utility")
local ModCommonBezier_m = require("../mod/common/bezier")
local ObjBezier_m = require("../obj/Bezier")
local PkgPromise_m = require("../pkg/Promise")
local _ = require("../obj/ObjectCache")
local t = {}
local v1 = nil

function t.init(arg1) -- line: 16
    -- upvalues:
    --  [1] v1 (ref)

    v1 = arg1
end

function t.deinit() -- line: 20
    -- upvalues:
    --  [1] v1 (ref)

    v1 = nil
end

local function readLightningAttributes(u1: userdata) -- line: 24
    -- upvalues:
    --  [1] ModAttributes_m (copy)
    --  [2] ModUtility_m (copy)

    local t_1 = {
        segments = nil,
        jaggedness = nil,
        offsetScale = nil,
        refreshRate = nil,
        independentSegments = nil,
        refreshDuringDissipate = nil,
        nestedEffectMode = nil,
        colorSequence = nil,
        colorEasingData = nil,
        colorDuration = nil,
        transparencyStart = nil,
        transparencyEnd = nil,
        fillColorSequence = nil,
        fillColorEasingData = nil,
        fillColorDuration = nil,
        fillTransparencyStart = nil,
        fillTransparencyEnd = nil,
        fillDepthMode = nil,
        fadeInStart = nil,
        fadeInDuration = nil,
        fadeInCurveData = nil,
        fadeOutEnd = nil,
        fadeOutDuration = nil,
        fadeOutCurveData = nil,
        lengthStart = nil,
        lengthEnd = nil,
        dissipateMode = nil,
        dissipateDuration = nil,
        dissipateCurveData = nil,
        widthStart = nil,
        widthEnd = nil
    }
    local v2 = ModAttributes_m.get(u1, "Segments", 8)
    t_1.segments = math.max(v2, 2)
    t_1.jaggedness = ModAttributes_m.getRange(
        u1,
        "Jaggedness",
        NumberRange.new(0.5, 1),
        NumberRange.new(0, math.huge)
    )
    t_1.offsetScale = ModAttributes_m.get(u1, "OffsetScale", 1)
    t_1.refreshRate = ModAttributes_m.get(u1, "RefreshRate", 15)
    t_1.independentSegments = ModAttributes_m.get(u1, "IndependentSegments", false)
    t_1.refreshDuringDissipate = ModAttributes_m.get(u1, "RefreshDuringDissipate", false)
    t_1.nestedEffectMode = ModAttributes_m.getEnum(
        u1,
        "NestedEffectMode",
        "None",
        { "None", "All", "Head", "Tail" }
    )
    t_1.colorSequence = ModAttributes_m.get(u1, "Color", ColorSequence.new(Color3.new(1, 1, 1)))
    t_1.colorEasingData = ModAttributes_m.get(u1, "Color_Curve", ModUtility_m.linear_bezier)
    t_1.colorDuration = ModAttributes_m.get(u1, "Color_Duration", 1)
    t_1.transparencyStart = ModAttributes_m.get(u1, "Transparency_Start", 0)
    t_1.transparencyEnd = ModAttributes_m.get(u1, "Transparency_End", 0)
    t_1.fillColorSequence = ModAttributes_m.get(
        u1,
        "Fill_Color",
        ColorSequence.new(Color3.new(1, 1, 1))
    )
    t_1.fillColorEasingData = ModAttributes_m.get(
        u1,
        "Fill_Color_Curve",
        ModUtility_m.linear_bezier
    )
    t_1.fillColorDuration = ModAttributes_m.get(u1, "Fill_Color_Duration", 1)
    t_1.fillTransparencyStart = ModAttributes_m.get(u1, "Fill_Transparency_Start", 1)
    t_1.fillTransparencyEnd = ModAttributes_m.get(u1, "Fill_Transparency_End", 1)
    t_1.fillDepthMode = ModAttributes_m.getEnum(
        u1,
        "Fill_DepthMode",
        "Occluded",
        { "AlwaysOnTop", "Occluded" }
    )
    t_1.fadeInStart = ModAttributes_m.get(u1, "Fade_In_Start", 1)
    t_1.fadeInDuration = ModAttributes_m.get(u1, "Fade_In_Duration", 0)
    t_1.fadeInCurveData = ModAttributes_m.get(u1, "Fade_In_Curve", ModUtility_m.default_bezier)
    t_1.fadeOutEnd = ModAttributes_m.get(u1, "Fade_Out_End", 1)
    t_1.fadeOutDuration = ModAttributes_m.get(u1, "Fade_Out_Duration", 0)
    t_1.fadeOutCurveData = ModAttributes_m.get(u1, "Fade_Out_Curve", ModUtility_m.default_bezier)
    t_1.lengthStart = ModAttributes_m.get(u1, "Length_Start", 1)
    t_1.lengthEnd = ModAttributes_m.get(u1, "Length_End", 1)
    t_1.dissipateMode = ModAttributes_m.getEnum(
        u1,
        "Dissipate_Mode",
        "None",
        { "None", "Retract", "Scale" }
    )
    t_1.dissipateDuration = ModAttributes_m.get(u1, "Dissipate_Duration", 0.5)
    t_1.dissipateCurveData = ModAttributes_m.get(u1, "Dissipate_Curve", ModUtility_m.default_bezier)
    t_1.widthStart = ModAttributes_m.get(u1, "Width_Start", 2)
    t_1.widthEnd = ModAttributes_m.get(u1, "Width_End", 0.2)

    return t_1
end

local function createSegmentStates(n1: number) -- line: 77
    local t_2 = {}

    for index = 1, n1 do
        t_2[index] = {
            birthTime = nil,
            initialWidth = nil,
            initialTransparency = nil,
            wasVisible = false
        }
    end

    return t_2
end

local _ = function(
    u2: userdata,
    u3: NumberRange,
    n2: number,
    n3: number,
    vec1: Vector3,
    vec2: Vector3
) --[[ computeJaggedOffset ]] -- line: 92
    local v3 = u2:NextNumber(u3.Min, u3.Max)
    local v4 = math.min(v3 * n2 * n3, n3 * 0.8)
    local v5 = u2:NextNumber(0, 6.283185307179586)

    return (vec1 * math.cos(v5) + vec2 * math.sin(v5)) * v4
end

local function generateLightningPoints(
    u4: userdata,
    n4: number,
    f1: (...any) -> ...any,
    u5: NumberRange,
    n5: number
) -- line: 109
    -- upvalues:
    --  [1] ModCommonBezier_m (copy)

    local t_3 = table.create(n4 + 1)
    local v7 = 1 / n4
    t_3[1] = f1(0)
    local v8 = t_3[1]

    for index_1 = 1, n4 - 1 do
        local v9 = index_1 * v7
        local v10 = f1(v9)
        local v11 = f1((math.min(v9 + 0.01, 1))) - v10

        if v11.Magnitude > 0.001 then
            v11 = v11.Unit
        else
            v11 = Vector3.new(0, 1, 0)
        end

        local v12, v13 = ModCommonBezier_m.getPerpendicularVectors(v11)
        local Magnitude = (v10 - v8).Magnitude
        local v15 = math.min(u4:NextNumber(u5.Min, u5.Max) * n5 * Magnitude, Magnitude * 0.8)
        local v16 = u4:NextNumber(0, 6.283185307179586)
        v10 += (v12 * math.cos(v16) + v13 * math.sin(v16)) * v15
        v8 = v10
        t_3[index_1 + 1] = v10
    end

    t_3[n4 + 1] = f1(1)

    return t_3
end

local function generateProjectilePoints(
    u6: userdata,
    n6: number,
    vec3: Vector3,
    vec4: Vector3,
    u7: NumberRange,
    n7: number,
    vec5: Vector3
) -- line: 148
    -- upvalues:
    --  [1] ModCommonBezier_m (copy)

    local t_4 = table.create(n6 + 1)
    local v19 = 1 / n6
    local v20 = vec4 - vec3
    local Magnitude_1 = v20.Magnitude
    local v21 = if not (Magnitude_1 > 0.001) then vec5 else v20 / Magnitude_1
    local v22, v23 = ModCommonBezier_m.getPerpendicularVectors(v21)
    v21 = Magnitude_1 * v19
    t_4[1] = vec3

    for index_2 = 1, n6 - 1 do
        local v24 = vec3:Lerp(vec4, index_2 * v19)
        local v26 = math.min(u6:NextNumber(u7.Min, u7.Max) * n7 * v21, v21 * 0.8)
        local v27 = u6:NextNumber(0, 6.283185307179586)
        t_4[index_2 + 1] = v24 + (v22 * math.cos(v27) + v23 * math.sin(v27)) * v26
    end

    t_4[n6 + 1] = vec4

    return t_4
end

local function getBlendedPosition(
    n8: number,
    f2: (...any) -> ...any,
    vec6: Vector3,
    vec7: Vector3,
    t1: table
) -- line: 193
    local v29 = math.clamp(
        (t1.distanceTraveled - (1 - n8) * t1.boltLength) / t1.transitionBuffer,
        0,
        1
    )
    local v30 = math.min(t1.distanceTraveled / t1.boltLength, 1)

    return f2((math.min(1, t1.curvedTailT + n8 * t1.curvedLengthT + v30 * t1.curvedLengthT))):Lerp(
        vec6:Lerp(vec7, n8),
        v29
    )
end

local function generateTransitionPoints(
    u8: userdata,
    n9: number,
    f3: (...any) -> ...any,
    vec8: Vector3,
    vec9: Vector3,
    u9: NumberRange,
    n10: number,
    vec10: Vector3,
    t2: table
) -- line: 217
    -- upvalues:
    --  [1] ModCommonBezier_m (copy)
    --  [2] getBlendedPosition (copy)

    local t_5 = table.create(n9 + 1)
    local t_6 = table.create(n9 + 1)
    local v32 = 1 / n9
    local v33 = vec9 - vec8
    local Magnitude_2 = v33.Magnitude
    local v34 = if not (Magnitude_2 > 0.001) then vec10 else v33 / Magnitude_2
    local v35, v36 = ModCommonBezier_m.getPerpendicularVectors(v34)
    v34 = Magnitude_2 * v32

    for index_3 = 0, n9 do
        local v37 = getBlendedPosition(
            index_3 * v32,
            f3,
            vec8,
            vec9,
            t2
        )

        if index_3 == 0 or index_3 == n9 then
            t_5[index_3 + 1] = v37
            t_6[index_3 + 1] = Vector3.new(0, 0, 0)
        else
            local v39 = math.min(u8:NextNumber(u9.Min, u9.Max) * n10 * v34, v34 * 0.8)
            local v40 = u8:NextNumber(0, 6.283185307179586)
            local v42 = (v35 * math.cos(v40) + v36 * math.sin(v40)) * v39
            t_5[index_3 + 1] = v37 + v42
            t_6[index_3 + 1] = v42
        end
    end

    return t_5, t_6
end

local function updateTransitionPoints(
    n11: number,
    f4: (...any) -> ...any,
    vec11: Vector3,
    vec12: Vector3,
    t3: table
) -- line: 259
    -- upvalues:
    --  [1] getBlendedPosition (copy)

    local t_7 = table.create(n11 + 1)
    local v43 = 1 / n11
    local JaggedOffsets = t3.jaggedOffsets

    for index_4 = 0, n11 do
        local v44 = getBlendedPosition(
            index_4 * v43,
            f4,
            vec11,
            vec12,
            t3
        )
        local v45 = if not JaggedOffsets then Vector3.new(0, 0, 0) else JaggedOffsets[index_4 + 1]
        t_7[index_4 + 1] = v44 + v45
    end

    return t_7
end

local _ = function(t4: table) --[[ isTransitionComplete ]] -- line: 281
    return t4.distanceTraveled >= t4.boltLength + t4.transitionBuffer
end

function t.emit(u10: userdata, u11: userdata, arg2: any, b1: boolean?) -- line: 285
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] ModCommonBezier_m (copy)
    --  [3] readLightningAttributes (copy)
    --  [4] ModUtility_m (copy)
    --  [5] ModAttributes_m (copy)
    --  [6] ModTween_m (copy)
    --  [7] ObjBezier_m (copy)
    --  [8] PkgPromise_m (copy)
    --  [9] createSegmentStates (copy)
    --  [10] generateLightningPoints (copy)
    --  [11] generateTransitionPoints (copy)
    --  [12] generateProjectilePoints (copy)
    --  [13] updateTransitionPoints (copy)

    local Points = u10:FindFirstChild("Points")
    local t_9

    if Points then
        if not Points:IsA("Attachment") or not v1 then
            return
        end

        local v48 = ModCommonBezier_m.readCommonAttributes(u10)
        local v50 = readLightningAttributes(u10)
        local v49 = ModCommonBezier_m.drawFuncMap[v48.shapeType]

        if v49 then
            v49 = ModCommonBezier_m.drawFuncMap[v48.shapeType][v48.shapeStyle]
        end

        if not v49 then
            return
        end

        local v51 = v48.emitDuration > 0 and true
        task.wait(v48.emitDelay)

        if v51 and not b1 then
            ModUtility_m.forceEmit(u10, true)
            ModAttributes_m.trigger(u10, "Enabled", true)
            ModUtility_m.onCancel(arg2, function() -- line: 310
                -- upvalues:
                --  [1] ModUtility_m (ref)
                --  [2] u10 (copy)

                local v52 = ModUtility_m.stopEmitDuration(u10)

                if v52 then
                    ModUtility_m.cancelToken(v52)
                end
            end)

            if v48.speedStart ~= v48.speedEnd then
                ModAttributes_m.setState(u10, "SpeedTweening", true)
                local DefaultBezier = ModUtility_m.default_bezier
                local FromParams = ModTween_m.fromParams
                local v54 = ModAttributes_m.get(u10, "Speed_Curve", DefaultBezier)
                local v56 = ModAttributes_m.get(u10, "Speed_Duration", 0.1)
                table.insert(arg2, FromParams(
                    v54,
                    v56,
                    function(arg3, arg4) -- line: 326
                        -- upvalues:
                        --  [1] ModAttributes_m (ref)
                        --  [2] u10 (copy)
                        --  [3] ModUtility_m (ref)
                        --  [4] v48 (copy)

                        ModAttributes_m.setState(
                            u10,
                            "SpeedOverride",
                            ModUtility_m.lerp(v48.speedStart, v48.speedEnd, arg3)
                        )

                        return arg4
                    end,
                    nil,
                    function() -- line: 331
                        -- upvalues:
                        --  [1] ModAttributes_m (ref)
                        --  [2] u10 (copy)

                        ModAttributes_m.setState(u10, "SpeedTweening", nil)
                    end
                ))
            end

            task.wait(v48.emitDuration)
            ModUtility_m.awaitEmitDuration(ModUtility_m.stopEmitDuration(u10))

            return
        end

        if v48.emitCount <= 0 then
            return
        end

        local v59 = ModCommonBezier_m.validateParent(u10)

        if not v59 then
            return
        end

        local v60, v61 = ModUtility_m.getTransformedOriginExtents(v59)

        if not v60 then
            return
        end

        local v62, v63 = ModCommonBezier_m.findEndAttachments(u10)
        local v64 = ModUtility_m.getBezierPoints(Points)
        local rng = Random.new()
        local v58 = not v62 and ObjBezier_m.new(v64)
        local v65 = ObjBezier_m.new(ModUtility_m.deserializePath(v50.colorEasingData), 0)
        local v66 = ObjBezier_m.new(ModUtility_m.deserializePath(v50.fillColorEasingData), 0)
        local v67 = ObjBezier_m.new(ModUtility_m.deserializePath(v50.fadeInCurveData), 0)
        local v68 = ObjBezier_m.new(ModUtility_m.deserializePath(v50.fadeOutCurveData), 0)
        local t_8 = {
            enabled = nil,
            collisionGroup = nil,
            filterTag = nil,
            filterType = nil,
            ignoreCanCollide = nil
        }
        local CreateHitboxParams = ModCommonBezier_m.createHitboxParams
        t_8.enabled = v48.hitboxEnabled
        t_8.collisionGroup = v48.hitboxCollisionGroup
        t_8.filterTag = v48.hitboxFilterTag
        t_8.filterType = v48.hitboxFilterType
        local v69, v70
        t_8.ignoreCanCollide, v69, v70 = v48.hitboxIgnoreCanCollide, v59, Points
        local v71 = CreateHitboxParams(t_8, v69, v70)
        t_9 = {}
        local v73

        for _ = 1, v48.emitCount do
            local _ = v48.emitCount
            local v72 = rng:NextNumber(v48.duration.Min, v48.duration.Max)
            v73 = v48.projectileEnabled

            if v73 then
                v73 = rng:NextNumber(v48.projectileLifetime.Min, v48.projectileLifetime.Max)
            end

            table.insert(t_9, PkgPromise_m.new(function(arg5) -- line: 390
                -- upvalues:
                --  [1] ModCommonBezier_m (ref)
                --  [2] v60 (copy)
                --  [3] v61 (copy)
                --  [4] v48 (copy)
                --  [5] v49 (copy)
                --  [6] rng (copy)
                --  [7] v62 (copy)
                --  [8] v59 (copy)
                --  [9] v58 (copy)
                --  [10] v64 (copy)
                --  [11] v63 (copy)
                --  [12] v50 (copy)
                --  [13] createSegmentStates (ref)
                --  [14] v1 (ref)
                --  [15] v66 (copy)
                --  [16] arg2 (copy)
                --  [17] u11 (copy)
                --  [18] ModUtility_m (ref)
                --  [19] generateLightningPoints (ref)
                --  [20] t_9 (copy)
                --  [21] ModAttributes_m (ref)
                --  [22] u10 (copy)
                --  [23] ModTween_m (ref)
                --  [24] v71 (copy)
                --  [25] generateTransitionPoints (ref)
                --  [26] generateProjectilePoints (ref)
                --  [27] updateTransitionPoints (ref)
                --  [28] v65 (copy)
                --  [29] v67 (copy)
                --  [30] v68 (copy)
                --  [31] v72 (copy)
                --  [32] v73 (copy)

                local v79 = ModCommonBezier_m.calculateEmissionCFrame(
                    v60,
                    v61,
                    {
                        face = v48.face,
                        spreadAngle = v48.spreadAngle,
                        mirror = v48.mirror,
                        mirrorRot = v48.mirrorRot,
                        partial = v48.partial,
                        emissionDirection = v48.emissionDirection
                    },
                    v49,
                    rng,
                    v62,
                    v59:IsA("Attachment")
                )
                local v80 = v58 or ModCommonBezier_m.createBezierWithEndpoint(v64, v79, v62, v63)
                local v81 = ModCommonBezier_m.createPosGetter(
                    v80,
                    v64,
                    v79,
                    v62,
                    true
                )
                v80 = table.create(v50.segments)
                local t_11 = table.create(v50.segments)
                local v82 = createSegmentStates(v50.segments)
                local v83 = 1 / v50.segments
                local t_12 = table.create(v50.segments)

                for index_6 = 1, v50.segments do
                    local t_13 = { start = (index_6 - 1) * v83, finish = index_6 * v83 }
                    local _ = v50.segments
                    t_12[index_6] = t_13
                end

                local v84

                if not v1 then
                    v84 = arg5
                    v84()

                    return
                end

                v84 = v50.fillTransparencyStart
                local v85 = 1
                v83 = v84 < v85 or v50.fillTransparencyEnd < 1
                v84 = nil
                v85 = nil
                local v88

                if v83 then
                    local LightningContainer_Model = Instance.new("Model")
                    LightningContainer_Model.Name = "LightningContainer"
                    LightningContainer_Model.Parent, v85 = workspace.Terrain, LightningContainer_Model
                    local Highlight = Instance.new("Highlight")
                    Highlight.Adornee = LightningContainer_Model
                    local FillColorSequence = v50.fillColorSequence
                    v88 = 0
                    Highlight.FillColor = ModCommonBezier_m.getColorWithEasingOklab(
                        FillColorSequence,
                        v88,
                        v66
                    )
                    Highlight.FillTransparency = v50.fillTransparencyStart
                    Highlight.OutlineTransparency = 1
                    local HighlightDepthMode = Enum.HighlightDepthMode
                    v88 = v50.fillDepthMode
                    Highlight.DepthMode = HighlightDepthMode[v88]
                    Highlight.Parent = LightningContainer_Model
                    v84 = Highlight
                end

                local function shouldEmitNested(n12: number) -- line: 448
                    -- upvalues:
                    --  [1] v50 (ref)

                    local NestedEffectMode = v50.nestedEffectMode

                    return if NestedEffectMode ~= "All" then if NestedEffectMode ~= "Head" then if NestedEffectMode ~= "Tail" then false else n12 == 1 else n12 == v50.segments else true
                end

                local v90 = if v50.nestedEffectMode == "None" then nil else arg2.effects.prepareEmitOnFinish(
                    u11,
                    arg2
                )
                local t_14 = {}
                local t_15 = {}
                v88 = v50.segments

                for index_7 = 1, v88, 1 do
                    local v93 = ModUtility_m.getRandomId()
                    local GetReal = v1:get(v93)._getReal()
                    ModUtility_m.copyProperties(u11, GetReal, ModUtility_m.COPY_PART_PROPERTIES)
                    GetReal.Size = Vector3.new(v50.widthStart, v50.widthStart, 1)
                    GetReal.Anchored = true
                    GetReal.CanQuery = false
                    GetReal.CanTouch = false
                    GetReal.CanCollide = false

                    if v83 and v85 then
                        GetReal.Parent = v85
                    end

                    local NestedEffectMode_1 = v50.nestedEffectMode
                    local v106 = if NestedEffectMode_1 ~= "All" then if NestedEffectMode_1 ~= "Head" then if NestedEffectMode_1 ~= "Tail" then false else index_7 == 1 else index_7 == v50.segments else true

                    if v106 then
                        v106 = u11:Clone()

                        for _, val in v106:GetChildren(), nil, nil do
                            val.Parent = GetReal

                            if v50.nestedEffectMode == "Head" then
                                table.insert(t_15, val)
                            end
                        end

                        v106:Destroy()
                        table.insert(t_14, index_7)
                    end

                    v80[index_7] = GetReal
                    t_11[index_7] = v93
                end

                v88 = nil

                if v50.nestedEffectMode == "Head" then
                    if #t_15 > 0 then
                        for _, val_1 in t_15, nil, nil do
                            val_1.Parent = v80[1]
                        end

                        v88 = 1
                    end
                end

                local v119 = arg2

                local function v117() -- line: 521
                    -- upvalues:
                    --  [1] v1 (ref)
                    --  [2] v50 (ref)
                    --  [3] t_11 (copy)
                    --  [4] v85 (ref)

                    if v1 then
                        for index_8 = 1, v50.segments do
                            local _ = v50.segments
                            v1:free(t_11[index_8])
                        end

                        if v85 then
                            v85:Destroy()
                        end
                    end
                end

                table.insert(v119, v117)
                shouldEmitNested = v85 or u11
                local v120 = false
                local v121 = v48.speedStart
                local v122 = v50.widthStart
                local v123 = v50.lengthStart
                local v124 = v50.transparencyStart
                local v125 = v50.fillTransparencyStart
                local v126 = 0
                local v127 = 0
                local v128 = 0
                local v129 = generateLightningPoints(
                    rng,
                    v50.segments,
                    v81,
                    v50.jaggedness,
                    v50.offsetScale
                )
                local v137 = nil
                local v139

                for _, val_2 in t_14, nil, v137 do
                    v139 = if v50.nestedEffectMode ~= "Head" then val_2 else 1
                    local v140 = arg2.effects.emitNested(v80[v139], arg2.depth + 1, arg2)
                    table.insert(t_9, v140.Finished)
                end

                local v146 = Vector3.new(0, 0, 0)
                local v147 = Vector3.new(0, 0, 0)
                v137 = 0
                local v148 = false
                local v149 = 0
                v139 = 0
                local v150 = 0
                local v151 = v50.widthStart
                local v152 = v60
                local v153 = nil
                local v154 = nil
                local v155 = nil
                local v156 = nil
                local v157 = nil

                if v48.speedStart ~= v48.speedEnd and not ModAttributes_m.getState(
                    u10,
                    "SpeedOverride",
                    nil
                ) then
                    v157 = ModTween_m.fromParams(ModAttributes_m.get(
                        u10,
                        "Speed_Curve",
                        ModUtility_m.default_bezier
                    ), ModAttributes_m.get(u10, "Speed_Duration", 0.1), function(arg6, arg7) -- line: 586
                        -- upvalues:
                        --  [1] v121 (ref)
                        --  [2] ModUtility_m (ref)
                        --  [3] v48 (ref)

                        v121 = ModUtility_m.lerp(v48.speedStart, v48.speedEnd, arg6)

                        return arg7
                    end)
                    table.insert(arg2, v157)
                end

                local function getEffectiveSpeed() -- line: 595
                    -- upvalues:
                    --  [1] ModAttributes_m (ref)
                    --  [2] u10 (ref)
                    --  [3] v121 (ref)

                    return ModAttributes_m.getState(u10, "SpeedOverride", v121)
                end

                local _ = function() --[[ isSpeedTweening ]] -- line: 599
                    -- upvalues:
                    --  [1] v157 (ref)
                    --  [2] ModAttributes_m (ref)
                    --  [3] u10 (ref)

                    if v157 then
                        return v157.Connected
                    end

                    return (ModAttributes_m.getState(u10, "SpeedTweening", false))
                end

                local _ = function(n13: number, b2: boolean?) --[[ getSpeedDelta ]] -- line: 603
                    -- upvalues:
                    --  [1] ModAttributes_m (ref)
                    --  [2] u10 (ref)
                    --  [3] v121 (ref)
                    --  [4] v157 (ref)

                    local SpeedOverride = ModAttributes_m.getState(u10, "SpeedOverride", v121)
                    v121 = SpeedOverride

                    return if not (SpeedOverride > 0) then if b2 then n13 * SpeedOverride else if not v157 then if not ModAttributes_m.getState(
                        u10,
                        "SpeedTweening",
                        false
                    ) then nil else n13 * SpeedOverride else if not v157.Connected then nil else n13 * SpeedOverride else n13 * SpeedOverride
                end

                local _ = function() --[[ getHeadSegmentIndex ]] -- line: 616
                    -- upvalues:
                    --  [1] v149 (ref)
                    --  [2] v50 (ref)

                    local v160 = math.ceil(v149 * v50.segments)

                    return (math.clamp(v160, 1, v50.segments))
                end

                local _ = function() --[[ shapecast ]] -- line: 620
                    -- upvalues:
                    --  [1] v48 (ref)
                    --  [2] v80 (copy)
                    --  [3] v149 (ref)
                    --  [4] v50 (ref)
                    --  [5] v71 (ref)

                    if not v48.hitboxEnabled then
                        return false
                    end

                    local v163 = v80[math.clamp(math.ceil(v149 * v50.segments), 1, v50.segments)]

                    if v163 and v163.Transparency < 1 and workspace:GetPartsInPart(v163, v71)[1] then
                        return true
                    end

                    return false
                end

                local function refreshPoints() -- line: 639
                    -- upvalues:
                    --  [1] v154 (ref)
                    --  [2] v155 (ref)
                    --  [3] v153 (ref)
                    --  [4] v156 (ref)
                    --  [5] v129 (ref)
                    --  [6] generateTransitionPoints (ref)
                    --  [7] rng (ref)
                    --  [8] v50 (ref)
                    --  [9] v81 (copy)
                    --  [10] generateProjectilePoints (ref)
                    --  [11] generateLightningPoints (ref)

                    if v154 and (v155 and v153) then
                        if v156 then
                            local v164 = v156

                            if not (if not (v164.distanceTraveled >= v164.boltLength + v164.transitionBuffer) then false else true) then
                                v129, v156.jaggedOffsets = generateTransitionPoints(
                                    rng,
                                    v50.segments,
                                    v81,
                                    v155,
                                    v154,
                                    v50.jaggedness,
                                    v50.offsetScale,
                                    v153,
                                    v156
                                )

                                return
                            end
                        end

                        v129 = generateProjectilePoints(
                            rng,
                            v50.segments,
                            v155,
                            v154,
                            v50.jaggedness,
                            v50.offsetScale,
                            v153
                        )

                        if v156 then
                            v156.jaggedOffsets = nil

                            return
                        end
                    else
                        v129 = generateLightningPoints(
                            rng,
                            v50.segments,
                            v81,
                            v50.jaggedness,
                            v50.offsetScale
                        )
                    end
                end

                local function updatePointsBetweenRefreshes(n14: number) -- line: 674
                    -- upvalues:
                    --  [1] v156 (ref)
                    --  [2] v129 (ref)
                    --  [3] updateTransitionPoints (ref)
                    --  [4] v50 (ref)
                    --  [5] v81 (copy)
                    --  [6] v155 (ref)
                    --  [7] v154 (ref)
                    --  [8] generateTransitionPoints (ref)
                    --  [9] rng (ref)
                    --  [10] v153 (ref)
                    --  [11] v48 (ref)

                    if v156 then
                        local v167 = v156

                        if not (if not (v167.distanceTraveled >= v167.boltLength + v167.transitionBuffer) then false else true) then
                            if v156.jaggedOffsets then
                                v129 = updateTransitionPoints(
                                    v50.segments,
                                    v81,
                                    v155,
                                    v154,
                                    v156
                                )

                                return
                            end

                            v129, v156.jaggedOffsets = generateTransitionPoints(
                                rng,
                                v50.segments,
                                v81,
                                v155,
                                v154,
                                v50.jaggedness,
                                v50.offsetScale,
                                v153,
                                v156
                            )

                            return
                        end
                    end

                    local v170 = v153 * v48.projectileSpeed * n14

                    for index_9 = 1, #v129 do
                        local _ = #v129
                        v129[index_9] += v170
                    end
                end

                local function updateSegments(
                    n15: number,
                    n16: number?,
                    n17: number,
                    b3: boolean?,
                    n18: number?
                ) -- line: 708
                    -- upvalues:
                    --  [1] v149 (ref)
                    --  [2] v123 (ref)
                    --  [3] v122 (ref)
                    --  [4] v50 (ref)
                    --  [5] v128 (ref)
                    --  [6] refreshPoints (copy)
                    --  [7] v82 (copy)
                    --  [8] t_12 (copy)
                    --  [9] v80 (copy)
                    --  [10] v124 (ref)
                    --  [11] ModCommonBezier_m (ref)
                    --  [12] v126 (ref)
                    --  [13] v65 (ref)
                    --  [14] v137 (ref)
                    --  [15] v67 (ref)
                    --  [16] ModUtility_m (ref)
                    --  [17] v148 (ref)
                    --  [18] v139 (ref)
                    --  [19] v68 (ref)
                    --  [20] v129 (ref)
                    --  [21] v84 (ref)
                    --  [22] v127 (ref)
                    --  [23] v66 (ref)
                    --  [24] v125 (ref)
                    --  [25] v88 (ref)
                    --  [26] t_15 (copy)
                    --  [27] v81 (copy)
                    --  [28] v146 (ref)
                    --  [29] v147 (ref)

                    local clock = os.clock()
                    v149 = n15
                    local v172 = n16 or math.max(0, n15 - v123)
                    local v173 = n18 or v122

                    if b3 ~= false and v50.refreshRate > 0 then
                        local v174 = 1 / v50.refreshRate
                        v128 += n17

                        if v174 <= v128 then
                            refreshPoints()
                            v128 = 0
                        end
                    end

                    for index_10 = 1, v50.segments do
                        local v175 = v82[index_10]
                        local v176 = t_12[index_10]
                        local v177 = v80[index_10]
                        local Start = v176.start
                        local Finish = v176.finish
                        v176 = v172 < Finish and n15 > Start
                        local _ = v50.segments

                        if not v176 then
                            v177.Transparency = 1

                            if v175.wasVisible then
                                v175.wasVisible = false
                                v175.birthTime = nil
                                v175.initialWidth = nil
                                v175.initialTransparency = nil
                            end
                        else
                            if not v175.wasVisible then
                                v175.wasVisible = true
                                v175.birthTime = clock
                                v175.initialWidth = v122
                                v175.initialTransparency = v124
                            end

                            v177.Color = ModCommonBezier_m.getColorWithEasingOklab(
                                v50.colorSequence,
                                v126,
                                v65
                            )
                            local v178 = v50.independentSegments and v175.initialTransparency or v124
                            local v179 = if v50.fadeInDuration > 0 then math.clamp(
                                v137 / v50.fadeInDuration,
                                0,
                                1
                            ) else 1
                            local v180 = ModUtility_m.lerp(
                                v50.fadeInStart,
                                v178,
                                1 - v67:getEase(v179).y
                            )
                            local v181 = if v148 and v50.fadeOutDuration > 0 then ModUtility_m.lerp(
                                v178,
                                v50.fadeOutEnd,
                                1 - v68:getEase((math.clamp(v139 / v50.fadeOutDuration, 0, 1))).y
                            ) else v178
                            local v182 = if not (v179 < 1) then if not v148 then v178 else v181 else v180
                            v177.Transparency = v182

                            if n18 then
                                v180 = v50.independentSegments and v175.initialWidth or v122
                                v182 = v180 * (if not (v122 > 0) then 0 else n18 / v122)
                            else
                                v182 = v50.independentSegments and v175.initialWidth or v173
                            end

                            v181 = v129[index_10]
                            v179 = v129[index_10 + 1]

                            if v181 and v179 then
                                v178 = if v172 > Start then v181:Lerp(
                                    v179,
                                    (v172 - Start) / (Finish - Start)
                                ) else v181
                                local v186 = if n15 < Finish then v181:Lerp(
                                    v179,
                                    (n15 - Start) / (Finish - Start)
                                ) else v179
                                local v187 = (v178 + v186) / 2
                                local Magnitude_3 = (v186 - v178).Magnitude

                                if Magnitude_3 > 0.001 then
                                    v177.Size = Vector3.new(v182, v182, Magnitude_3)
                                    v177.CFrame = CFrame.lookAt(v187, v186)
                                end
                            end
                        end
                    end

                    if v84 then
                        v84.FillColor = ModCommonBezier_m.getColorWithEasingOklab(
                            v50.fillColorSequence,
                            v127,
                            v66
                        )
                        v84.FillTransparency = v125
                    end

                    if v88 then
                        v173 = math.clamp(math.ceil(v149 * v50.segments), 1, v50.segments)

                        if v173 ~= v88 then
                            v172 = v80[v173]

                            for _, val_3 in t_15 do
                                val_3.Parent = v172
                            end

                            v88 = v173
                        end
                    end

                    local v191 = v81((math.min(n15, 1)))

                    if n17 > 0 then
                        v146 = (v191 - v147) / n17
                    end

                    v147 = v191
                end

                ModCommonBezier_m.createPropertyTween(
                    arg2,
                    u10,
                    "Width",
                    v72,
                    v50.widthStart,
                    v50.widthEnd,
                    function(arg8) -- line: 868
                        -- upvalues:
                        --  [1] v122 (ref)

                        v122 = arg8
                    end,
                    getEffectiveSpeed,
                    v157
                )
                ModCommonBezier_m.createPropertyTween(
                    arg2,
                    u10,
                    "Transparency",
                    v72,
                    v50.transparencyStart,
                    v50.transparencyEnd,
                    function(arg9) -- line: 879
                        -- upvalues:
                        --  [1] v124 (ref)

                        v124 = arg9
                    end,
                    getEffectiveSpeed,
                    v157
                )
                ModCommonBezier_m.createPropertyTween(
                    arg2,
                    u10,
                    "Length",
                    v72,
                    v50.lengthStart,
                    v50.lengthEnd,
                    function(arg10) -- line: 893
                        -- upvalues:
                        --  [1] v123 (ref)

                        v123 = arg10
                    end,
                    getEffectiveSpeed,
                    v157
                )

                if v83 then
                    ModCommonBezier_m.createPropertyTween(
                        arg2,
                        u10,
                        "FillTransparency",
                        v50.fillColorDuration,
                        v50.fillTransparencyStart,
                        v50.fillTransparencyEnd,
                        function(arg11) -- line: 908
                            -- upvalues:
                            --  [1] v125 (ref)

                            v125 = arg11
                        end,
                        getEffectiveSpeed,
                        v157
                    )
                end

                function v83(
                    n19: number,
                    n20: number,
                    n21: number,
                    s1: string,
                    n22: number,
                    s2: string,
                    f5: (...any) -> ...any
                ) --[[ handleDissipation ]] -- line: 917
                    -- upvalues:
                    --  [1] v148 (ref)
                    --  [2] v150 (ref)
                    --  [3] v151 (ref)
                    --  [4] ModTween_m (ref)
                    --  [5] v139 (ref)
                    --  [6] ModAttributes_m (ref)
                    --  [7] u10 (ref)
                    --  [8] v121 (ref)
                    --  [9] v137 (ref)
                    --  [10] v50 (ref)
                    --  [11] v126 (ref)
                    --  [12] v127 (ref)
                    --  [13] ModUtility_m (ref)
                    --  [14] updateSegments (copy)
                    --  [15] v157 (ref)
                    --  [16] arg2 (ref)

                    v148 = true
                    v150 = n20
                    v151 = n21
                    ModTween_m.fromParams(
                        s1,
                        n22,
                        function(arg12, arg13, arg14) -- line: 930
                            -- upvalues:
                            --  [1] v139 (ref)
                            --  [2] ModAttributes_m (ref)
                            --  [3] u10 (ref)
                            --  [4] v121 (ref)
                            --  [5] v137 (ref)
                            --  [6] v50 (ref)
                            --  [7] v126 (ref)
                            --  [8] v127 (ref)
                            --  [9] s2 (copy)
                            --  [10] ModUtility_m (ref)
                            --  [11] v150 (ref)
                            --  [12] n19 (copy)
                            --  [13] v151 (ref)
                            --  [14] updateSegments (ref)

                            v139 = arg14
                            local v192 = arg13 * ModAttributes_m.getState(
                                u10,
                                "SpeedOverride",
                                v121
                            )
                            v137 += v192

                            if v50.refreshDuringDissipate then
                                v126 = (v126 + v192 / v50.colorDuration) % 1
                                v127 = (v127 + v192 / v50.fillColorDuration) % 1
                            end

                            local v193 = if s2 ~= "Retract" then nil else ModUtility_m.lerp(
                                v150,
                                n19,
                                arg12
                            )
                            local v194 = if s2 == "Scale" then ModUtility_m.lerp(v151, 0, arg12) else nil
                            updateSegments(
                                n19,
                                v193,
                                v192,
                                v50.refreshDuringDissipate,
                                v194
                            )
                            v194 = ModAttributes_m.getState(u10, "SpeedOverride", v121)
                            v121 = v194

                            if v194 > 0 then
                                return arg13 * v194
                            end

                            return arg13 * v194
                        end,
                        v157,
                        f5,
                        true,
                        ModUtility_m.RENDER_PRIORITY + arg2.depth
                    )
                end

                local function startDissipation() -- line: 950
                    -- upvalues:
                    --  [1] v148 (ref)
                    --  [2] v120 (ref)
                    --  [3] v149 (ref)
                    --  [4] v90 (copy)
                    --  [5] arg2 (ref)
                    --  [6] shouldEmitNested (copy)
                    --  [7] arg5 (copy)
                    --  [8] v50 (ref)
                    --  [9] v123 (ref)
                    --  [10] v122 (ref)
                    --  [11] v150 (ref)
                    --  [12] v151 (ref)
                    --  [13] ModTween_m (ref)
                    --  [14] v139 (ref)
                    --  [15] ModAttributes_m (ref)
                    --  [16] u10 (ref)
                    --  [17] v121 (ref)
                    --  [18] v137 (ref)
                    --  [19] v126 (ref)
                    --  [20] v127 (ref)
                    --  [21] ModUtility_m (ref)
                    --  [22] updateSegments (copy)
                    --  [23] v157 (ref)

                    if v148 or v120 then
                        return
                    end

                    local v195 = v149
                    local v196 = if not v90 then nil else arg2.effects.emitOnFinish(
                        v90,
                        shouldEmitNested,
                        arg2.depth + 1,
                        arg2
                    )

                    local function onDissipationComplete() -- line: 961
                        -- upvalues:
                        --  [1] v120 (ref)
                        --  [2] v196 (copy)
                        --  [3] arg5 (ref)

                        if v120 then
                            return
                        end

                        v120 = true

                        if v196 then
                            v196.Finished:finally(function() -- line: 969
                                -- upvalues:
                                --  [1] arg5 (ref)

                                arg5()
                            end)

                            return
                        end

                        arg5()
                    end

                    if v50.dissipateMode ~= "None" then
                        local v197 = math.max(0, v195 - v123)
                        local DissipateMode = v50.dissipateMode
                        local v198 = v122
                        local DissipateCurveData = v50.dissipateCurveData
                        local DissipateDuration = v50.dissipateDuration
                        v148 = true
                        v150 = v197
                        v151 = v198
                        ModTween_m.fromParams(
                            DissipateCurveData,
                            DissipateDuration,
                            function(arg15, arg16, arg17) -- line: 930
                                -- upvalues:
                                --  [1] v139 (ref)
                                --  [2] ModAttributes_m (ref)
                                --  [3] u10 (ref)
                                --  [4] v121 (ref)
                                --  [5] v137 (ref)
                                --  [6] v50 (ref)
                                --  [7] v126 (ref)
                                --  [8] v127 (ref)
                                --  [9] DissipateMode (copy)
                                --  [10] ModUtility_m (ref)
                                --  [11] v150 (ref)
                                --  [12] v195 (copy)
                                --  [13] v151 (ref)
                                --  [14] updateSegments (ref)

                                v139 = arg17
                                local v199 = arg16 * ModAttributes_m.getState(
                                    u10,
                                    "SpeedOverride",
                                    v121
                                )
                                v137 += v199

                                if v50.refreshDuringDissipate then
                                    v126 = (v126 + v199 / v50.colorDuration) % 1
                                    v127 = (v127 + v199 / v50.fillColorDuration) % 1
                                end

                                local v200 = if DissipateMode ~= "Retract" then nil else ModUtility_m.lerp(
                                    v150,
                                    v195,
                                    arg15
                                )
                                local v201 = if DissipateMode == "Scale" then ModUtility_m.lerp(
                                    v151,
                                    0,
                                    arg15
                                ) else nil
                                updateSegments(
                                    v195,
                                    v200,
                                    v199,
                                    v50.refreshDuringDissipate,
                                    v201
                                )
                                v201 = ModAttributes_m.getState(u10, "SpeedOverride", v121)
                                v121 = v201

                                if v201 > 0 then
                                    return arg16 * v201
                                end

                                return arg16 * v201
                            end,
                            v157,
                            onDissipationComplete,
                            true,
                            ModUtility_m.RENDER_PRIORITY + arg2.depth
                        )

                        return
                    end

                    if v50.fadeOutDuration > 0 then
                        local v202 = math.max(0, v195 - v123)
                        local v203 = v122
                        local FadeOutCurveData = v50.fadeOutCurveData
                        local FadeOutDuration = v50.fadeOutDuration
                        v148 = true
                        v150 = v202
                        v151 = v203
                        local v204 = "None"
                        ModTween_m.fromParams(
                            FadeOutCurveData,
                            FadeOutDuration,
                            function(arg18, arg19, arg20) -- line: 930
                                -- upvalues:
                                --  [1] v139 (ref)
                                --  [2] ModAttributes_m (ref)
                                --  [3] u10 (ref)
                                --  [4] v121 (ref)
                                --  [5] v137 (ref)
                                --  [6] v50 (ref)
                                --  [7] v126 (ref)
                                --  [8] v127 (ref)
                                --  [9] v204 (copy)
                                --  [10] ModUtility_m (ref)
                                --  [11] v150 (ref)
                                --  [12] v195 (copy)
                                --  [13] v151 (ref)
                                --  [14] updateSegments (ref)

                                v139 = arg20
                                local v205 = arg19 * ModAttributes_m.getState(
                                    u10,
                                    "SpeedOverride",
                                    v121
                                )
                                v137 += v205

                                if v50.refreshDuringDissipate then
                                    v126 = (v126 + v205 / v50.colorDuration) % 1
                                    v127 = (v127 + v205 / v50.fillColorDuration) % 1
                                end

                                local v206 = if v204 ~= "Retract" then nil else ModUtility_m.lerp(
                                    v150,
                                    v195,
                                    arg18
                                )
                                local v207 = if v204 == "Scale" then ModUtility_m.lerp(
                                    v151,
                                    0,
                                    arg18
                                ) else nil
                                updateSegments(
                                    v195,
                                    v206,
                                    v205,
                                    v50.refreshDuringDissipate,
                                    v207
                                )
                                v207 = ModAttributes_m.getState(u10, "SpeedOverride", v121)
                                v121 = v207

                                if v207 > 0 then
                                    return arg19 * v207
                                end

                                return arg19 * v207
                            end,
                            v157,
                            onDissipationComplete,
                            true,
                            ModUtility_m.RENDER_PRIORITY + arg2.depth
                        )

                        return
                    end

                    if v120 then
                        return
                    end

                    v120 = true

                    if v196 then
                        v196.Finished:finally(function() -- line: 969
                            -- upvalues:
                            --  [1] arg5 (ref)

                            arg5()
                        end)

                        return
                    end

                    arg5()
                end

                table.insert(arg2, ModTween_m.fromParams(
                    ModAttributes_m.get(u10, "Easing_Curve", ModUtility_m.linear_bezier),
                    v72,
                    function(arg21, arg22, _) -- line: 1008
                        -- upvalues:
                        --  [1] ModAttributes_m (ref)
                        --  [2] u10 (ref)
                        --  [3] v121 (ref)
                        --  [4] v137 (ref)
                        --  [5] v126 (ref)
                        --  [6] v50 (ref)
                        --  [7] v127 (ref)
                        --  [8] v48 (ref)
                        --  [9] ModUtility_m (ref)
                        --  [10] v59 (ref)
                        --  [11] v152 (ref)
                        --  [12] v129 (ref)
                        --  [13] updateSegments (copy)
                        --  [14] v80 (copy)
                        --  [15] v149 (ref)
                        --  [16] v71 (ref)
                        --  [17] startDissipation (copy)
                        --  [18] v157 (ref)
                        --  [19] v72 (ref)
                        --  [20] v73 (ref)

                        local v210 = arg22 * ModAttributes_m.getState(u10, "SpeedOverride", v121)
                        v137 += v210
                        v126 = (v126 + v210 / v50.colorDuration) % 1
                        v127 = (v127 + v210 / v50.fillColorDuration) % 1

                        if v48.syncPosition then
                            local v211 = ModUtility_m.getTransformedOriginExtents(v59)
                            local v212 = v211 * v152:Inverse()

                            for index_11 = 1, #v129 do
                                local _ = #v129
                                v129[index_11] = v212:PointToWorldSpace(
                                    v152:PointToObjectSpace(v129[index_11])
                                )
                            end

                            v152 = v211
                        end

                        updateSegments(arg21, nil, v210)
                        local v215

                        if not v48.hitboxEnabled then
                            v215 = false
                        else
                            local _ = updateSegments
                            local v219 = v80[math.clamp(
                                math.ceil(v149 * v50.segments),
                                1,
                                v50.segments
                            )]
                            v215 = if v219 then if v219.Transparency < 1 then if workspace:GetPartsInPart(
                                v219,
                                v71
                            )[1] then true else false else false else false
                        end

                        if v215 then
                            startDissipation()

                            return nil
                        end

                        local SpeedOverride_1 = ModAttributes_m.getState(u10, "SpeedOverride", v121)
                        v121 = SpeedOverride_1
                        local v220

                        if SpeedOverride_1 > 0 then
                            v220 = arg22 * SpeedOverride_1
                        else
                            v220 = if if v157 then v157.Connected else ModAttributes_m.getState(
                                u10,
                                "SpeedTweening",
                                false
                            ) then arg22 * SpeedOverride_1 else nil
                        end

                        if v220 == nil then
                            return nil
                        end

                        if if not v48.projectileEnabled then not v48.projectileEnabled else arg21 * v72 < v73 or not v48.projectileEnabled then
                            return v220
                        end

                        startDissipation()

                        return nil
                    end,
                    v157,
                    function() -- line: 1048
                        -- upvalues:
                        --  [1] v148 (ref)
                        --  [2] v120 (ref)
                        --  [3] v48 (ref)
                        --  [4] ModTween_m (ref)
                        --  [5] ModUtility_m (ref)
                        --  [6] ModAttributes_m (ref)
                        --  [7] u10 (ref)
                        --  [8] v121 (ref)
                        --  [9] v137 (ref)
                        --  [10] v126 (ref)
                        --  [11] v50 (ref)
                        --  [12] v127 (ref)
                        --  [13] updateSegments (copy)
                        --  [14] v80 (copy)
                        --  [15] v149 (ref)
                        --  [16] v71 (ref)
                        --  [17] startDissipation (copy)
                        --  [18] v157 (ref)
                        --  [19] arg2 (ref)
                        --  [20] v62 (ref)
                        --  [21] v146 (ref)
                        --  [22] v81 (copy)
                        --  [23] v123 (ref)
                        --  [24] v129 (ref)
                        --  [25] v156 (ref)
                        --  [26] v73 (ref)
                        --  [27] v154 (ref)
                        --  [28] v155 (ref)
                        --  [29] v153 (ref)
                        --  [30] v128 (ref)
                        --  [31] refreshPoints (copy)
                        --  [32] updatePointsBetweenRefreshes (copy)

                        if v148 or v120 then
                            return
                        end

                        local v222

                        if not v48.projectileEnabled then
                            v222 = v48.destroyDelay

                            if v222 > 0 then
                                v222 = ModTween_m.fromParams
                                v222(
                                    ModUtility_m.linear_bezier,
                                    v48.destroyDelay,
                                    function(_, arg25) -- line: 1059
                                        -- upvalues:
                                        --  [1] ModAttributes_m (ref)
                                        --  [2] u10 (ref)
                                        --  [3] v121 (ref)
                                        --  [4] v137 (ref)
                                        --  [5] v126 (ref)
                                        --  [6] v50 (ref)
                                        --  [7] v127 (ref)
                                        --  [8] updateSegments (ref)
                                        --  [9] v48 (ref)
                                        --  [10] v80 (ref)
                                        --  [11] v149 (ref)
                                        --  [12] v71 (ref)
                                        --  [13] startDissipation (ref)

                                        local v225 = arg25 * ModAttributes_m.getState(
                                            u10,
                                            "SpeedOverride",
                                            v121
                                        )
                                        v137 += v225
                                        v126 = (v126 + v225 / v50.colorDuration) % 1
                                        v127 = (v127 + v225 / v50.fillColorDuration) % 1
                                        updateSegments(1, nil, v225, true)
                                        local v226

                                        if not v48.hitboxEnabled then
                                            v226 = false
                                        else
                                            local _ = updateSegments
                                            local v230 = v80[math.clamp(
                                                math.ceil(v149 * v50.segments),
                                                1,
                                                v50.segments
                                            )]
                                            v226 = if v230 then if v230.Transparency < 1 then if workspace:GetPartsInPart(
                                                v230,
                                                v71
                                            )[1] then true else false else false else false
                                        end

                                        if v226 then
                                            startDissipation()

                                            return nil
                                        end

                                        local SpeedOverride_2 = ModAttributes_m.getState(
                                            u10,
                                            "SpeedOverride",
                                            v121
                                        )
                                        v121 = SpeedOverride_2

                                        if SpeedOverride_2 > 0 then
                                            return arg25 * SpeedOverride_2
                                        end

                                        return arg25 * SpeedOverride_2
                                    end,
                                    v157,
                                    function() -- line: 1076
                                        -- upvalues:
                                        --  [1] startDissipation (ref)

                                        startDissipation()
                                    end,
                                    true,
                                    ModUtility_m.RENDER_PRIORITY + arg2.depth
                                )

                                return
                            end

                            v222 = startDissipation
                            v222()

                            return
                        else
                            v222 = if not v48.projectileMatchEnd then v146.Unit else if not v62 then v146.Unit else v62.WorldCFrame.LookVector
                            v222 = if v222 ~= v222 then Vector3.new(0, 0, 1) else if not (v222.Magnitude < 0.001) then v222.Unit else Vector3.new(0, 0, 1)
                            local v233 = v81(1)
                            local Magnitude_4 = (v233 - v81((math.max(0, 1 - v123)))).Magnitude
                            local v236 = math.max(0, 1 - v123)
                            local v237 = 1 - v236
                            local v238 = Magnitude_4 * 0.3
                            local t_16 = table.create(v50.segments + 1)

                            for index_12 = 0, v50.segments do
                                local _ = v50.segments
                                t_16[index_12 + 1] = v129[index_12 + 1] - v81(
                                    v236 + index_12 / v50.segments * v237
                                )
                            end

                            local t_17 = {
                                curvedTailT = v236,
                                curvedLengthT = v237,
                                boltLength = Magnitude_4,
                                transitionBuffer = v238,
                                distanceTraveled = 0,
                                jaggedOffsets = t_16
                            }
                            v156 = t_17
                            ModTween_m.timer(
                                v73,
                                function(arg26, arg27) -- line: 1132
                                    -- upvalues:
                                    --  [1] ModAttributes_m (ref)
                                    --  [2] u10 (ref)
                                    --  [3] v121 (ref)
                                    --  [4] v137 (ref)
                                    --  [5] v126 (ref)
                                    --  [6] v50 (ref)
                                    --  [7] v127 (ref)
                                    --  [8] v48 (ref)
                                    --  [9] t_17 (copy)
                                    --  [10] v233 (copy)
                                    --  [11] v222 (ref)
                                    --  [12] Magnitude_4 (copy)
                                    --  [13] v154 (ref)
                                    --  [14] v155 (ref)
                                    --  [15] v153 (ref)
                                    --  [16] v128 (ref)
                                    --  [17] refreshPoints (ref)
                                    --  [18] updatePointsBetweenRefreshes (ref)
                                    --  [19] updateSegments (ref)
                                    --  [20] v80 (ref)
                                    --  [21] v149 (ref)
                                    --  [22] v71 (ref)
                                    --  [23] startDissipation (ref)
                                    --  [24] v73 (ref)

                                    local v239 = arg26 * ModAttributes_m.getState(
                                        u10,
                                        "SpeedOverride",
                                        v121
                                    )
                                    v137 += v239
                                    v126 = (v126 + v239 / v50.colorDuration) % 1
                                    v127 = (v127 + v239 / v50.fillColorDuration) % 1
                                    local v240 = arg27 * v48.projectileSpeed
                                    t_17.distanceTraveled = v240
                                    local v241 = v233 + v222 * v240
                                    v154, v155 = v241, v241 - v222 * Magnitude_4
                                    v153 = v222
                                    v241 = v50.refreshRate > 0 and true

                                    if v241 then
                                        v128 += v239

                                        if v128 >= 1 / v50.refreshRate then
                                            refreshPoints()
                                            v128 = 0
                                        else
                                            updatePointsBetweenRefreshes(arg26)
                                        end
                                    else
                                        updatePointsBetweenRefreshes(arg26)
                                    end

                                    updateSegments(1, nil, v239, false)
                                    local v242

                                    if not v48.hitboxEnabled then
                                        v242 = false
                                    else
                                        local _ = updateSegments
                                        v241 = v80[math.clamp(
                                            math.ceil(v149 * v50.segments),
                                            1,
                                            v50.segments
                                        )]
                                        v242 = if v241 then if v241.Transparency < 1 then if workspace:GetPartsInPart(
                                            v241,
                                            v71
                                        )[1] then true else false else false else false
                                    end

                                    if v242 then
                                        startDissipation()

                                        return nil
                                    end

                                    if arg27 >= v73 then
                                        return nil
                                    end

                                    local SpeedOverride_3 = ModAttributes_m.getState(
                                        u10,
                                        "SpeedOverride",
                                        v121
                                    )
                                    v121 = SpeedOverride_3

                                    if SpeedOverride_3 > 0 then
                                        return arg26 * SpeedOverride_3
                                    end

                                    return arg26 * SpeedOverride_3
                                end,
                                v157,
                                arg2,
                                ModUtility_m.RENDER_PRIORITY + arg2.depth
                            )
                            startDissipation()

                            return
                        end
                    end,
                    true,
                    ModUtility_m.RENDER_PRIORITY + arg2.depth
                ))
            end))
        end

        PkgPromise_m.all(t_9):await()

        return
    else
        return
    end
end

return t
