-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.effects.beam
-- Class: ModuleScript
-- bytes: 13342

local ModAttributes_m = require("../mod/attributes")
local ModTween_m = require("../mod/tween")
local _ = require("../types")
local ModUtility_m = require("../mod/utility")
local ModCommonFlipbook_m = require("../mod/common/flipbook")
local PkgPromise_m = require("../pkg/Promise")
local rng = Random.new()

local function getLegacyWidths(u1: userdata, n1: number) -- line: 12
    -- upvalues:
    --  [1] ModAttributes_m (copy)

    return ModAttributes_m.get(u1, "Width0", u1.Width0, true) * n1, ModAttributes_m.get(
        u1,
        "Width1",
        u1.Width1,
        true
    ) * n1, ModAttributes_m.get(u1, "StartWidth0", u1.Width0, true) * n1, ModAttributes_m.get(
        u1,
        "StartWidth1",
        u1.Width1,
        true
    ) * n1
end

return {
    emit = function(u2: userdata, u3: userdata, arg1: any, n2: number) --[[ emit ]] -- line: 24
        -- upvalues:
        --  [1] getLegacyWidths (copy)
        --  [2] ModAttributes_m (copy)
        --  [3] rng (copy)
        --  [4] ModTween_m (copy)
        --  [5] ModUtility_m (copy)
        --  [6] ModCommonFlipbook_m (copy)
        --  [7] PkgPromise_m (copy)

        local v4 = arg1.effects.prepareEmitOnFinish(u3, arg1)
        local v5, v6, v7, v8 = getLegacyWidths(u2, n2)
        local v9 = ModAttributes_m.get(u2, "Width0_Start", v7)
        local v10 = ModAttributes_m.get(u2, "Width0_End", v5)
        local v11 = ModAttributes_m.get(u2, "Width1_Start", v8)
        local v12 = ModAttributes_m.get(u2, "Width1_End", v6)
        local v13 = ModAttributes_m.get(u2, "CurveSize0_Start", u3.CurveSize0)
        local v14 = ModAttributes_m.get(u2, "CurveSize0_End", u3.CurveSize0)
        local v15 = ModAttributes_m.get(u2, "CurveSize1_Start", u3.CurveSize1)
        local v16 = ModAttributes_m.get(u2, "CurveSize1_End", u3.CurveSize1)
        local v17 = ModAttributes_m.get(u2, "EmitDelay", 0)
        local v18 = ModAttributes_m.get(u2, "Duration", 1, true)
        local v19 = ModAttributes_m.get(u2, "EndTransparencyScale", 1, true)
        local EffectDuration = ModAttributes_m.getRange(
            u2,
            "EffectDuration",
            NumberRange.new(v18, v18),
            NumberRange.new(0, math.huge)
        )
        local v21 = ModAttributes_m.get(u2, "Length_Scale_Start", NumberRange.new(1, 1))
        local v22 = ModAttributes_m.get(u2, "Length_Scale_End", NumberRange.new(1, 1))
        local v23 = ModAttributes_m.get(u2, "Length_Texture_Start", u2.TextureLength)
        local v24 = ModAttributes_m.get(u2, "Length_Texture_End", u2.TextureLength)
        local v25 = rng:NextNumber(EffectDuration.Min, EffectDuration.Max)
        local v26 = rng:NextNumber(v22.Min, v22.Max)
        local v27 = rng:NextNumber(v21.Min, v21.Max)
        local v28 = ModAttributes_m.get(u2, "Transparency_Scale_Start", 1)
        local v29 = ModAttributes_m.get(u2, "Transparency_Scale_End", v19)
        local v30 = ModAttributes_m.get(u2, "Speed_Texture_Start", u2.TextureSpeed)
        local v31 = ModAttributes_m.get(u2, "Speed_Texture_End", u2.TextureSpeed)
        local v32 = ModAttributes_m.get(u2, "Speed_Start", 1)
        local v33 = ModAttributes_m.get(u2, "Speed_End", 1)
        local TextureSpeed = u3.TextureSpeed
        task.wait(v17)
        u3.Enabled = true
        local t_1 = {}
        local v34 = 1
        local v35 = nil
        table.insert(t_1, arg1.effects.emitNested(u3, arg1.depth + 1, arg1).Finished)

        if v30 ~= v31 then
            ModTween_m.fromParams(ModAttributes_m.get(
                u2,
                "Speed_Texture_Curve",
                ModUtility_m.default_bezier
            ), v25, function(arg2, arg3) -- line: 86
                -- upvalues:
                --  [1] TextureSpeed (ref)
                --  [2] ModUtility_m (ref)
                --  [3] v30 (copy)
                --  [4] v31 (copy)
                --  [5] u3 (copy)
                --  [6] v34 (ref)

                TextureSpeed = ModUtility_m.lerp(v30, v31, arg2)
                u3.TextureSpeed = TextureSpeed * v34

                return arg3
            end)
        end

        if v32 ~= v33 then
            v35 = ModTween_m.fromParams(ModAttributes_m.get(
                u2,
                "Speed_Curve",
                ModUtility_m.default_bezier
            ), ModAttributes_m.get(u3, "Speed_Duration", 0.1), function(arg4, arg5) -- line: 98
                -- upvalues:
                --  [1] v34 (ref)
                --  [2] ModUtility_m (ref)
                --  [3] v32 (copy)
                --  [4] v33 (copy)
                --  [5] u3 (copy)
                --  [6] TextureSpeed (ref)

                v34 = ModUtility_m.lerp(v32, v33, arg4)
                u3.TextureSpeed = TextureSpeed * v34

                return arg5
            end)
            table.insert(arg1, v35)
        end

        local Keypoints = u2.Transparency.Keypoints
        local v39 = #Keypoints
        local t_2 = table.create(v39)
        local t_3 = table.create(v39)

        for key, val in Keypoints do
            t_3[key] = { time = val.Time, value = val.Value, envelope = val.Envelope }
        end

        local v40 = nil

        local function setTScale(n3: number) -- line: 127
            -- upvalues:
            --  [1] v40 (ref)
            --  [2] t_3 (copy)
            --  [3] t_2 (copy)
            --  [4] u3 (copy)

            if v40 and math.abs(n3 - v40) < 0.001 then
                return
            end

            v40 = n3
            local v41 = n3 > 1 and n3 - 1 or 1 - n3

            for key_1, val_1 in t_3 do
                local Value = val_1.value
                local v42 = n3 > 1 and 1 - Value or -Value
                t_2[key_1] = NumberSequenceKeypoint.new(
                    val_1.time,
                    Value + v42 * v41,
                    val_1.envelope
                )
            end

            u3.Transparency = NumberSequence.new(t_2)
        end

        local Attachment0 = u3.Attachment0
        local Attachment1 = u3.Attachment1
        local v46 = Attachment0 and Attachment0.CFrame
        local v47 = Attachment1 and Attachment1.CFrame

        local function setLengthScale(n4: number) -- line: 149
            -- upvalues:
            --  [1] v46 (copy)
            --  [2] v47 (copy)
            --  [3] Attachment0 (copy)
            --  [4] Attachment1 (copy)

            if not v46 or not v47 then
                return
            end

            local v48 = (v47.Position - v46.Position) * 0.5
            local v49 = v46.Position + v48
            local v50 = v48 * n4
            Attachment0.CFrame = CFrame.new(v49 - v50) * (v46 - v46.Position)
            Attachment1.CFrame = CFrame.new(v49 + v50) * (v47 - v47.Position)
        end

        table.insert(arg1, function() -- line: 168
            -- upvalues:
            --  [1] setLengthScale (copy)

            setLengthScale(1)
        end)

        if v28 ~= v29 then
            table.insert(arg1, ModTween_m.fromParams(ModAttributes_m.get(
                u2,
                "Transparency_Scale_Curve",
                ModUtility_m.default_bezier
            ), v25, function(arg6, arg7) -- line: 178
                -- upvalues:
                --  [1] setTScale (copy)
                --  [2] ModUtility_m (ref)
                --  [3] v28 (copy)
                --  [4] v29 (copy)
                --  [5] v34 (ref)

                setTScale(ModUtility_m.lerp(v28, v29, arg6))

                return arg7 * v34
            end, v35))
        elseif v28 ~= 1 then
            setTScale(v28)
        end

        if v23 ~= v24 then
            table.insert(arg1, ModTween_m.fromParams(ModAttributes_m.get(
                u2,
                "Length_Texture_Curve",
                ModUtility_m.default_bezier
            ), v25, function(arg8, arg9) -- line: 195
                -- upvalues:
                --  [1] u3 (copy)
                --  [2] ModUtility_m (ref)
                --  [3] v23 (copy)
                --  [4] v24 (copy)
                --  [5] v34 (ref)

                u3.TextureLength = ModUtility_m.lerp(v23, v24, arg8)

                return arg9 * v34
            end, v35))
        end

        if v27 ~= v26 then
            table.insert(arg1, ModTween_m.fromParams(ModAttributes_m.get(
                u2,
                "Length_Scale_Curve",
                ModUtility_m.default_bezier
            ), v25, function(arg10, arg11) -- line: 207
                -- upvalues:
                --  [1] ModUtility_m (ref)
                --  [2] v27 (copy)
                --  [3] v26 (copy)
                --  [4] setLengthScale (copy)
                --  [5] v34 (ref)

                setLengthScale((ModUtility_m.lerp(v27, v26, arg10)))

                return arg11 * v34
            end, v35))
        elseif v23 ~= 1 then
            setLengthScale(v27)
        end

        if v9 ~= v10 then
            table.insert(arg1, ModTween_m.fromParams(ModAttributes_m.get(
                u2,
                "Width0_Curve",
                ModUtility_m.default_bezier
            ), v25, function(arg12, arg13) -- line: 222
                -- upvalues:
                --  [1] u3 (copy)
                --  [2] ModUtility_m (ref)
                --  [3] v9 (copy)
                --  [4] v10 (copy)
                --  [5] v34 (ref)

                u3.Width0 = ModUtility_m.lerp(v9, v10, arg12)

                return arg13 * v34
            end, v35))
        else
            u3.Width0 = v9
        end

        if v11 ~= v12 then
            table.insert(arg1, ModTween_m.fromParams(ModAttributes_m.get(
                u2,
                "Width1_Curve",
                ModUtility_m.default_bezier
            ), v25, function(arg14, arg15) -- line: 234
                -- upvalues:
                --  [1] u3 (copy)
                --  [2] ModUtility_m (ref)
                --  [3] v11 (copy)
                --  [4] v12 (copy)
                --  [5] v34 (ref)

                u3.Width1 = ModUtility_m.lerp(v11, v12, arg14)

                return arg15 * v34
            end, v35))
        else
            u3.Width1 = v11
        end

        if v13 ~= v14 then
            table.insert(arg1, ModTween_m.fromParams(ModAttributes_m.get(
                u2,
                "CurveSize0_Curve",
                ModUtility_m.default_bezier
            ), v25, function(arg16, arg17) -- line: 246
                -- upvalues:
                --  [1] u3 (copy)
                --  [2] ModUtility_m (ref)
                --  [3] v13 (copy)
                --  [4] v14 (copy)
                --  [5] v34 (ref)

                u3.CurveSize0 = ModUtility_m.lerp(v13, v14, arg16)

                return arg17 * v34
            end, v35))
        else
            u3.Width0 = v9
        end

        if v15 ~= v16 then
            table.insert(arg1, ModTween_m.fromParams(ModAttributes_m.get(
                u2,
                "CurveSize1_Curve",
                ModUtility_m.default_bezier
            ), v25, function(arg18, arg19) -- line: 258
                -- upvalues:
                --  [1] u3 (copy)
                --  [2] ModUtility_m (ref)
                --  [3] v15 (copy)
                --  [4] v16 (copy)
                --  [5] v34 (ref)

                u3.CurveSize1 = ModUtility_m.lerp(v15, v16, arg18)

                return arg19 * v34
            end, v35))
        else
            u3.Width1 = v11
        end

        local v66 = 0
        local v67 = ModCommonFlipbook_m.getFlipbookData(u2)
        local t_5

        if v67 then
            t_5 = {
                ref = u2,
                frames = v67,
                speedTween = v35,
                effectDuration = v25,
                curve = ModAttributes_m.get(u2, "Flipbook_Change_Curve", ModUtility_m.linear_bezier),
                duration = ModAttributes_m.get(u2, "Flipbook_Change_Duration", v25),
                getSpeed = nil,
                setTexture = nil
            }

            function t_5.getSpeed() -- line: 281
                -- upvalues:
                --  [1] v34 (ref)

                return v34
            end

            function t_5.setTexture(arg20) -- line: 285
                -- upvalues:
                --  [1] u3 (copy)

                u3.Texture = arg20
            end

            v66 = ModCommonFlipbook_m.getChangeDuration(t_5)
            table.insert(
                arg1,
                ModTween_m.fromParams(
                    t_5.curve,
                    v66,
                    ModCommonFlipbook_m.createUpdateCallback(t_5),
                    v35
                )
            )
        end

        local Timer = ModTween_m.timer
        local v68 = math.max(v25, v66)
        Timer(v68, function(arg21, arg22) -- line: 298
            -- upvalues:
            --  [1] v34 (ref)
            --  [2] v35 (ref)

            return if v34 > 0 then arg21 * v34 else if not (arg22 > 0) then nil else if not v35 then nil else if not v35.Connected then nil else arg21 * v34
        end, v35, arg1)
        local _ = ModCommonFlipbook_m.createUpdateCallback(t_5)

        if v4 then
            v68 = u3.Parent or workspace.Terrain
            table.insert(t_1, arg1.effects.emitOnFinish(v4, v68, arg1.depth + 1, arg1).Finished)
        end

        PkgPromise_m.all(t_1):await()
    end
}
