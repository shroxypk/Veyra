-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.emitters
-- Class: ModuleScript
-- bytes: 17694

local EffectsBeam_m = require("./effects/beam")
local EffectsSpin_m = require("./effects/spin")
local EffectsMesh_m = require("./effects/mesh")
local EffectsSound_m = require("./effects/sound")
local EffectsBezier_m = require("./effects/bezier")
local EffectsScreen_m = require("./effects/screen")
local EffectsParticle_m = require("./effects/particle")
local EffectsLightning_m = require("./effects/lightning")
local EffectsCameraShake_m = require("./effects/camera_shake")
local EffectsTweener_m = require("./effects/tweener")
local EffectsRandomizer_m = require("./effects/randomizer")
local EffectsShockwaveRing_m = require("./effects/shockwave_ring")
local EffectsShockwaveLine_m = require("./effects/shockwave_line")
local EffectsShockwaveDebris_m = require("./effects/shockwave_debris")
local ModAttributes_m = require("./mod/attributes")
local _ = require("./types")
local ModUtility_m = require("./mod/utility")
local PkgPromise_m = require("./pkg/Promise")
local t = {
    particle = function(
        u2: userdata,
        arg2: any,
        t1: table,
        t2: table,
        n1: number
    ) --[[ particle ]] -- line: 46
        -- upvalues:
        --  [1] ModAttributes_m (copy)
        --  [2] ModUtility_m (copy)
        --  [3] EffectsParticle_m (copy)

        local v5 = if not ModUtility_m.PLUGIN_CONTEXT then nil else 1
        local v6 = ModAttributes_m.get(u2, "EmitCount", v5)
        local v7 = ModAttributes_m.get(u2, "EmitDuration", 0, true)

        if not v6 or v6 <= 0 and v7 <= 0 then
            return
        end

        if not u2:IsDescendantOf(workspace) then
            local v8, v9 = ModUtility_m.cloneParticleAncestry(u2, t2)

            if not v8 then
                return
            end

            local v10 = u2:Clone()
            v10.Archivable = false
            v10.Parent = v8

            if not t1[v9] then
                v9.Parent = workspace.Terrain
                t1[v9] = 1
            else
                t1[v9] += 1
            end

            table.insert(arg2, function() -- line: 78
                -- upvalues:
                --  [1] t1 (copy)
                --  [2] v9 (copy)

                local v11 = t1
                local v12 = v9
                v11[v12] -= 1

                if t1[v9] <= 0 then
                    v9:Destroy()
                end
            end)
            ModUtility_m.try(
                "failed to emit particle with error: %s",
                EffectsParticle_m.emit,
                u2,
                v10,
                arg2,
                n1
            )

            return
        else
            ModUtility_m.try(
                "failed to emit particle with error: %s",
                EffectsParticle_m.emit,
                u2,
                u2,
                arg2,
                n1
            )

            return
        end
    end,
    beam = function(u3: userdata, arg3: any, n2: number) --[[ beam ]] -- line: 92
        -- upvalues:
        --  [1] ModAttributes_m (copy)
        --  [2] ModUtility_m (copy)
        --  [3] EffectsBeam_m (copy)

        local Attachment0 = u3.Attachment0
        local Attachment1 = u3.Attachment1

        if not Attachment0 or not Attachment1 then
            return
        end

        local v13 = u3:Clone()
        v13.Archivable = false
        v13.Parent = workspace.Terrain
        local range = NumberRange.new(1, 1)
        local v14, v15

        if ModAttributes_m.get(u3, "Length_Scale_Start", range, true) == range then
            if ModAttributes_m.get(u3, "Length_Scale_End", range, true) ~= range then
                v14 = Attachment0:Clone()
                v15 = Attachment1:Clone()
                table.insert(arg3, v14)
                table.insert(arg3, v15)
                v14.Name = "_ForgeTempAttachment"
                v15.Name = "_ForgeTempAttachment"
                v14:AddTag(ModUtility_m.EMIT_EXCLUDE_TAG)
                v15:AddTag(ModUtility_m.EMIT_EXCLUDE_TAG)
                v13.Attachment0 = v14
                v13.Attachment1 = v15
                v14.Parent = Attachment0.Parent
                v15.Parent = Attachment1.Parent
            end
        else
            v14 = Attachment0:Clone()
            v15 = Attachment1:Clone()
            table.insert(arg3, v14)
            table.insert(arg3, v15)
            v14.Name = "_ForgeTempAttachment"
            v15.Name = "_ForgeTempAttachment"
            v14:AddTag(ModUtility_m.EMIT_EXCLUDE_TAG)
            v15:AddTag(ModUtility_m.EMIT_EXCLUDE_TAG)
            v13.Attachment0 = v14
            v13.Attachment1 = v15
            v14.Parent = Attachment0.Parent
            v15.Parent = Attachment1.Parent
        end

        table.insert(arg3, v13)
        ModUtility_m.try(
            "failed to emit beam with error: %s",
            EffectsBeam_m.emit,
            u3,
            v13,
            arg3,
            n2
        )
    end,
    trail = function(u4: userdata) --[[ trail ]] -- line: 133
        u4.Enabled = true
    end,
    bezier = function(u5: userdata, arg4: any, b1: boolean?) --[[ bezier ]] -- line: 137
        -- upvalues:
        --  [1] ModUtility_m (copy)
        --  [2] EffectsBezier_m (copy)

        local Part = u5:FindFirstChildOfClass("Part")

        if not Part then
            return
        end

        if not b1 and u5:GetAttribute("Enabled") then
            u5:SetAttribute("Enabled", false)
        end

        local v16 = Part:Clone()
        v16.Locked = true
        table.insert(arg4, v16)
        ModUtility_m.try(
            "failed to emit bezier with error: %s",
            EffectsBezier_m.emit,
            u5,
            v16,
            arg4,
            b1
        )
    end,
    lightning = function(u6: userdata, arg5: any, b2: boolean?) --[[ lightning ]] -- line: 156
        -- upvalues:
        --  [1] ModUtility_m (copy)
        --  [2] EffectsLightning_m (copy)

        local Part_1 = u6:FindFirstChildOfClass("Part")

        if not Part_1 then
            return
        end

        if not b2 and u6:GetAttribute("Enabled") then
            u6:SetAttribute("Enabled", false)
        end

        local v17 = Part_1:Clone()
        v17.Locked = true
        table.insert(arg5, v17)
        ModUtility_m.try(
            "failed to emit lightning with error: %s",
            EffectsLightning_m.emit,
            u6,
            v17,
            arg5,
            b2
        )
    end,
    mesh = function(
        u7: userdata,
        arg6: any,
        arg7: any,
        n3: number,
        b3: boolean?
    ) --[[ mesh ]] -- line: 175
        -- upvalues:
        --  [1] ModUtility_m (copy)
        --  [2] ModAttributes_m (copy)
        --  [3] PkgPromise_m (copy)
        --  [4] EffectsMesh_m (copy)

        local Start = u7:FindFirstChild("Start")

        if not Start then
            return
        end

        if not b3 and u7:GetAttribute("Enabled") then
            u7:SetAttribute("Enabled", false)
        end

        local t_1 = {}
        local Context = arg6._context
        local v18 = u7:HasTag(ModUtility_m.ENABLED_VFX_TAG)

        if v18 then
            v18 = ModAttributes_m.get(u7, "EmitDuration", 0) > 0 and true
        end

        local v19 = if not v18 then ModAttributes_m.get(u7, "EmitCount", 1) else if b3 then ModAttributes_m.get(
            u7,
            "EmitCount",
            1
        ) else 1

        for _ = 1, v19 do
            v18 = PkgPromise_m.new(function(arg8) -- line: 199
                -- upvalues:
                --  [1] ModUtility_m (ref)
                --  [2] EffectsMesh_m (ref)
                --  [3] u7 (copy)
                --  [4] Start (copy)
                --  [5] arg6 (copy)
                --  [6] arg7 (copy)
                --  [7] n3 (copy)
                --  [8] b3 (copy)

                ModUtility_m.try(
                    "failed to emit mesh with error: %s",
                    EffectsMesh_m.emit,
                    u7,
                    ModUtility_m.assembleMeshVFX(Start, arg6, arg7),
                    arg6,
                    n3,
                    b3
                )
                arg8()
            end)
            table.insert(t_1, v18)

            if Context then
                table.insert(Context._promises, v18)
            end
        end

        PkgPromise_m.all(t_1):await()
    end,
    spin = function(u8: userdata, arg9: any) --[[ spin ]] -- line: 223
        -- upvalues:
        --  [1] ModUtility_m (copy)
        --  [2] EffectsSpin_m (copy)

        if ModUtility_m.lock(u8) then
            return
        end

        ModUtility_m.try(
            "failed to emit spinning model with error: %s",
            EffectsSpin_m.emit,
            u8,
            arg9
        )
        ModUtility_m.unlock(u8)
    end,
    camera_shake = function(u9: userdata, arg10: any) --[[ camera_shake ]] -- line: 232
        -- upvalues:
        --  [1] ModUtility_m (copy)
        --  [2] EffectsCameraShake_m (copy)

        ModUtility_m.try(
            "failed to emit camera shake with error: %s",
            EffectsCameraShake_m.emit,
            u9,
            arg10
        )
    end,
    property_tweener = function(u10: userdata, arg11: any) --[[ property_tweener ]] -- line: 236
        -- upvalues:
        --  [1] ModUtility_m (copy)
        --  [2] EffectsTweener_m (copy)

        if u10.Parent then
            if ModUtility_m.lock(u10) then
                return
            end

            ModUtility_m.try(
                "failed to emit property tweener with error: %s",
                EffectsTweener_m.emit,
                u10,
                arg11,
                false
            )
            ModUtility_m.unlock(u10)

            return
        else
            return
        end
    end,
    attribute_tweener = function(u11: userdata, arg12: any) --[[ attribute_tweener ]] -- line: 245
        -- upvalues:
        --  [1] ModUtility_m (copy)
        --  [2] EffectsTweener_m (copy)

        if u11.Parent then
            if ModUtility_m.lock(u11) then
                return
            end

            ModUtility_m.try(
                "failed to emit attribute tweener with error: %s",
                EffectsTweener_m.emit,
                u11.Parent,
                u11,
                arg12,
                true
            )
            ModUtility_m.unlock(u11)

            return
        else
            return
        end
    end,
    screen = function(u12: userdata, arg13: any) --[[ screen ]] -- line: 254
        -- upvalues:
        --  [1] ModUtility_m (copy)
        --  [2] EffectsScreen_m (copy)

        local v21, v22 = ModUtility_m.try(
            "failed to emit screen effect with error: %s",
            EffectsScreen_m.emit,
            u12,
            arg13
        )

        if v21 then
            return v22
        end

        return false
    end,
    shockwave_ring = function(u13: userdata, u14: userdata, arg14: any) --[[ shockwave_ring ]] -- line: 260
        -- upvalues:
        --  [1] ModUtility_m (copy)
        --  [2] EffectsShockwaveRing_m (copy)

        ModUtility_m.try(
            "failed to emit shockwave ring with error: %s",
            EffectsShockwaveRing_m.emit,
            u13,
            u14,
            arg14
        )
    end,
    shockwave_debris = function(u15: userdata, u16: userdata, arg15: any) --[[ shockwave_debris ]] -- line: 264
        -- upvalues:
        --  [1] ModUtility_m (copy)
        --  [2] EffectsShockwaveDebris_m (copy)

        ModUtility_m.try(
            "failed to emit shockwave debris with error: %s",
            EffectsShockwaveDebris_m.emit,
            u15,
            u16,
            arg15
        )
    end,
    shockwave_line = function(u17: userdata, u18: userdata, arg16: any) --[[ shockwave_line ]] -- line: 268
        -- upvalues:
        --  [1] ModUtility_m (copy)
        --  [2] EffectsShockwaveLine_m (copy)

        ModUtility_m.try(
            "failed to emit shockwave line with error: %s",
            EffectsShockwaveLine_m.emit,
            u17,
            u18,
            arg16
        )
    end,
    sound = function(u19: userdata, arg17: any) --[[ sound ]] -- line: 272
        -- upvalues:
        --  [1] ModAttributes_m (copy)
        --  [2] ModUtility_m (copy)
        --  [3] EffectsSound_m (copy)

        if ModAttributes_m.get(u19, "EmitCount", 1, true) <= 0 then
            return
        end

        ModUtility_m.try("failed to emit sound with error: %s", EffectsSound_m.emit, u19, arg17)
    end
}

local function processRandomizers(u1: userdata, arg1: any) -- line: 24
    -- upvalues:
    --  [1] ModUtility_m (copy)
    --  [2] EffectsRandomizer_m (copy)

    local v2 = u1:QueryDescendants(`> RayValue.{ModUtility_m.PROPERTY_RANDOMIZER_TAG}`)
    local v4 = u1:QueryDescendants(`> RayValue.{ModUtility_m.ATTRIBUTE_RANDOMIZER_TAG}`)

    if u1:IsA("RayValue") then
        if u1:HasTag(ModUtility_m.PROPERTY_RANDOMIZER_TAG) then
            table.insert(v2, u1)
        elseif u1:HasTag(ModUtility_m.ATTRIBUTE_RANDOMIZER_TAG) then
            table.insert(v4, u1)
        end
    end

    for _, val in v2 do
        ModUtility_m.try(
            "failed to emit property randomizer with error: %s",
            EffectsRandomizer_m.emit,
            val,
            arg1,
            false
        )
    end

    for _, val_1 in v4 do
        ModUtility_m.try(
            "failed to emit attribute randomizer with error: %s",
            EffectsRandomizer_m.emit,
            val_1,
            arg1,
            true
        )
    end
end

function t.dispatch(
    arg18: any,
    arg19: any,
    t3: table,
    t4: table,
    arg20: any,
    n4: number
) -- line: 283
    -- upvalues:
    --  [1] processRandomizers (copy)
    --  [2] t (copy)
    --  [3] ModUtility_m (copy)

    local ClassName = arg18.ClassName
    processRandomizers(arg18, arg19)

    if ClassName == "ParticleEmitter" then
        t.particle(
            arg18,
            arg19,
            t3,
            t4,
            n4
        )

        return
    end

    if ClassName == "Beam" then
        t.beam(arg18, arg19, n4)

        return
    end

    if ClassName == "Trail" then
        t.trail(arg18)

        return
    end

    if ClassName == "Sound" then
        t.sound(arg18, arg19)

        return
    end

    if ClassName == "RayValue" then
        if arg18:HasTag(ModUtility_m.SCREENSHAKE_TAG) then
            t.camera_shake(arg18, arg19)

            return
        end

        if arg18:HasTag(ModUtility_m.ATTRIBUTE_TWEENER_TAG) then
            t.attribute_tweener(arg18, arg19)

            return
        end

        if not arg18:HasTag(ModUtility_m.PROPERTY_RANDOMIZER_TAG) then
            if arg18:HasTag(ModUtility_m.ATTRIBUTE_RANDOMIZER_TAG) then
                return
            end

            t.property_tweener(arg18, arg19)
        end

        return
    else
        if arg18:HasTag(ModUtility_m.BEZIER_TAG) then
            t.bezier(arg18, arg19)

            return
        end

        if arg18:HasTag(ModUtility_m.LIGHTNING_TAG) then
            t.lightning(arg18, arg19)

            return
        end

        if ClassName == "Model" then
            if ModUtility_m.isMeshVFX(arg18) then
                t.mesh(arg18, arg19, arg20, n4)

                return
            end

            t.spin(arg18, arg19)

            return
        else
            if ClassName == "Part" then
                local v23 = ModUtility_m.findFirstClassWithTag(
                    arg18,
                    "Attachment",
                    ModUtility_m.SHOCKWAVE_TAG
                )

                if v23 then
                    local v24 = arg18.Parent and arg18.Parent.Name or ""

                    if v24 == "Rings" then
                        t.shockwave_ring(v23, arg18, arg19)

                        return
                    end

                    if v24 == "Debris" then
                        t.shockwave_debris(v23, arg18, arg19)

                        return
                    end

                    if v24 == "Lines" then
                        t.shockwave_line(v23, arg18, arg19)
                    end
                end
            end

            return
        end
    end
end

local t_2 = {
    mesh = {
        check = function(u20: userdata) --[[ check ]] -- line: 367
            -- upvalues:
            --  [1] ModUtility_m (copy)

            return ModUtility_m.isMeshVFX(u20)
        end,
        emit = function(u21: userdata, arg21: any, arg22: any) --[[ emit ]] -- line: 370
            -- upvalues:
            --  [1] t (copy)

            t.mesh(
                u21,
                arg21,
                arg22,
                1,
                true
            )
        end
    },
    bezier = {
        check = function(u22: userdata) --[[ check ]] -- line: 376
            -- upvalues:
            --  [1] ModUtility_m (copy)

            return u22:HasTag(ModUtility_m.BEZIER_TAG)
        end,
        emit = function(u23: userdata, arg23: any, _: any) --[[ emit ]] -- line: 379
            -- upvalues:
            --  [1] t (copy)

            t.bezier(u23, arg23, true)
        end
    },
    lightning = {
        check = function(u24: userdata) --[[ check ]] -- line: 385
            -- upvalues:
            --  [1] ModUtility_m (copy)

            return u24:HasTag(ModUtility_m.LIGHTNING_TAG)
        end,
        emit = function(u25: userdata, arg25: any, _: any) --[[ emit ]] -- line: 388
            -- upvalues:
            --  [1] t (copy)

            t.lightning(u25, arg25, true)
        end
    }
}
t.enabled_registry = t_2

return t
