-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.effects.spin
-- Class: ModuleScript
-- bytes: 4222

local ModAttributes_m = require("../mod/attributes")
local ModTween_m = require("../mod/tween")
local _ = require("../types")
local ModUtility_m = require("../mod/utility")

return {
    emit = function(u1: userdata, arg1: any) --[[ emit ]] -- line: 8
        -- upvalues:
        --  [1] ModUtility_m (copy)
        --  [2] ModAttributes_m (copy)
        --  [3] ModTween_m (copy)

        if ModUtility_m.isSpinModelStatic(u1) then
            return
        end

        local v2 = ModAttributes_m.get(u1, "SpinRotation", Vector3.new(0, 0, 0)) * ModUtility_m.DEG_TO_RAD
        local v3 = ModAttributes_m.get(u1, "Scale_Start", 1)
        local v4 = ModAttributes_m.get(u1, "Scale_End", 1)
        local v5 = ModAttributes_m.get(u1, "EmitDelay", 0)
        local v6 = ModAttributes_m.get(u1, "ResetDelay", 0)
        local v7 = ModAttributes_m.get(u1, "ResetOnFinish", true)
        local v8 = ModAttributes_m.get(u1, "SyncPosition", false)
        local v9 = ModAttributes_m.get(u1, "SpinDuration", 0.5)
        local v11 = ModAttributes_m.get(u1, "SpinSpeed_Duration", 0.1)
        local v13 = 0
        local v14 = ModAttributes_m.get(u1, "SpinSpeed_Start", v13)
        local v15 = u1
        v13 = "SpinSpeed_End"
        local v17 = ModAttributes_m.get(v15, v13, 1)
        local v18 = v14
        v13 = task.wait
        v13(v5)
        v13 = nil

        if v14 ~= v17 then
            v13 = ModTween_m.fromParams(ModAttributes_m.get(
                u1,
                "SpinSpeed_Curve",
                ModUtility_m.default_bezier
            ), v11, function(arg2, arg3) -- line: 40
                -- upvalues:
                --  [1] v18 (ref)
                --  [2] ModUtility_m (ref)
                --  [3] v14 (copy)
                --  [4] v17 (copy)

                v18 = ModUtility_m.lerp(v14, v17, arg2)

                return arg3
            end)
            table.insert(arg1, v13)
        end

        local v23 = u1:GetPivot()
        local v25 = u1:GetScale()

        if v3 ~= v4 then
            local FromParams = ModTween_m.fromParams
            local v26 = ModAttributes_m.get(u1, "Scale_Curve", ModUtility_m.default_bezier)
            table.insert(arg1, FromParams(v26, v9, function(arg4, arg5) -- line: 55
                -- upvalues:
                --  [1] u1 (copy)
                --  [2] ModUtility_m (ref)
                --  [3] v3 (copy)
                --  [4] v4 (copy)

                u1:ScaleTo(ModUtility_m.lerp(v3, v4, arg4))

                return arg5
            end))
        else
            u1:ScaleTo(v3)
        end

        local v28 = u1:FindFirstAncestorOfClass("Attachment") or u1:FindFirstAncestorWhichIsA(
            "BasePart"
        )

        if v7 then
            table.insert(arg1, function() -- line: 67
                -- upvalues:
                --  [1] u1 (copy)
                --  [2] v28 (copy)
                --  [3] ModUtility_m (ref)
                --  [4] v23 (copy)
                --  [5] v25 (copy)

                u1:PivotTo(v28 and ModUtility_m.getTransformedOriginExtents(v28) or v23)
                u1:ScaleTo(v25)
            end)
        end

        v2 *= v9
        ModTween_m.timer(
            v9 + v6,
            function(arg6, arg7) -- line: 75
                -- upvalues:
                --  [1] v9 (copy)
                --  [2] v2 (ref)
                --  [3] v28 (copy)
                --  [4] v8 (copy)
                --  [5] ModUtility_m (ref)
                --  [6] v23 (copy)
                --  [7] u1 (copy)
                --  [8] v18 (ref)
                --  [9] v13 (ref)

                local v30 = v2 * math.clamp(arg7 / v9, 0, 1)
                u1:PivotTo(
                    (if v28 and v8 then ModUtility_m.getTransformedOriginExtents(v28) else v23) * CFrame.fromOrientation(
                        v30.x,
                        v30.y,
                        v30.z
                    )
                )

                if v18 > 0 or arg7 > 0 and v13.Connected then
                    return arg6 * v18
                end

                return nil
            end,
            v13,
            arg1,
            ModUtility_m.RENDER_PRIORITY + arg1.depth
        )
    end
}
