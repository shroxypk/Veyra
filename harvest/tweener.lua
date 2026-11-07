-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.effects.tweener
-- Class: ModuleScript
-- bytes: 4641

local ModAttributes_m = require("../mod/attributes")
local ModLerp_m = require("../mod/lerp")
local ModTween_m = require("../mod/tween")
local _ = require("../types")
local ModUtility_m = require("../mod/utility")
local rng = Random.new()

return {
    emit = function(u1: userdata, arg1: any, b1: boolean) --[[ emit ]] -- line: 11
        -- upvalues:
        --  [1] ModUtility_m (copy)
        --  [2] ModAttributes_m (copy)
        --  [3] rng (copy)
        --  [4] ModTween_m (copy)
        --  [5] ModLerp_m (copy)

        local v1 = ModUtility_m.getTarget(u1)

        if not v1 then
            return
        end

        local Name = u1.Name
        local v2 = ModAttributes_m.get(u1, "EmitDelay", 0)
        local v4 = ModAttributes_m.get(u1, "ResetOnFinish", true)
        local Duration = ModAttributes_m.getRange(
            u1,
            "Duration",
            NumberRange.new(1, 1),
            NumberRange.new(0, math.huge)
        )

        if v2 > 0 then
            task.wait(v2)
        end

        local v12 = ModAttributes_m.get(u1, "_END_VALUE", nil)
        local v14 = ModAttributes_m.get(u1, "_START_VALUE", nil)
        local _ = nil
        local v18

        if b1 then
            _ = ModAttributes_m.get(v1, Name, nil)
        else
            local Success, Result = pcall(function() -- line: 37
                -- upvalues:
                --  [1] v1 (copy)
                --  [2] Name (copy)

                return v1[Name]
            end)

            if not Success then
                return
            end

            v18 = Result
        end

        if v14 then
            v18 = v14
        end

        local v19 = typeof(v18)

        if v19 ~= typeof(v12) then
            return
        end

        local Min = Duration.Min
        local v20 = Duration.Max
        local v21 = rng:NextNumber(Min, v20)
        v20 = "Speed_Start"
        local v24 = ModAttributes_m.get(u1, v20, 1)
        v20 = "Speed_End"
        local v27 = ModAttributes_m.get(u1, v20, 1)
        local v28 = v24
        v20 = nil

        if v24 ~= v27 then
            v20 = ModTween_m.fromParams(ModAttributes_m.get(
                u1,
                "Speed_Curve",
                ModUtility_m.default_bezier
            ), ModAttributes_m.get(u1, "Speed_Duration", 0.1), function(arg2, arg3) -- line: 71
                -- upvalues:
                --  [1] v28 (ref)
                --  [2] ModUtility_m (ref)
                --  [3] v24 (copy)
                --  [4] v27 (copy)

                v28 = ModUtility_m.lerp(v24, v27, arg2)

                return arg3
            end)
            table.insert(arg1, v20)
        end

        local v32 = ModLerp_m[v19] or ModLerp_m.Other
        v19 = if b1 then function(arg4, arg5) -- line: 83
            -- upvalues:
            --  [1] ModAttributes_m (ref)
            --  [2] v1 (copy)
            --  [3] Name (copy)
            --  [4] v32 (copy)
            --  [5] v18 (ref)
            --  [6] v12 (copy)
            --  [7] v28 (ref)

            ModAttributes_m.set(v1, Name, v32(v18, v12, arg4))

            return arg5 * v28
        end else function(arg6, arg7) -- line: 87
            -- upvalues:
            --  [1] v1 (copy)
            --  [2] Name (copy)
            --  [3] v32 (copy)
            --  [4] v18 (ref)
            --  [5] v12 (copy)
            --  [6] v28 (ref)

            v1[Name] = v32(v18, v12, arg6)

            return arg7 * v28
        end
        table.insert(
            arg1,
            ModTween_m.fromParams(
                ModAttributes_m.get(u1, "Easing_Curve", ModUtility_m.linear_bezier),
                v21,
                v19,
                v20,
                nil,
                nil,
                ModUtility_m.RENDER_PRIORITY + arg1.depth
            )
        )

        if v4 then
            table.insert(arg1, function() -- line: 106
                -- upvalues:
                --  [1] b1 (copy)
                --  [2] ModAttributes_m (ref)
                --  [3] v1 (copy)
                --  [4] Name (copy)
                --  [5] v18 (ref)

                if b1 then
                    ModAttributes_m.set(v1, Name, v18)

                    return
                end

                v1[Name] = v18
            end)
        end

        ModTween_m.timer(v21, function(arg8, arg9) -- line: 115
            -- upvalues:
            --  [1] v28 (ref)
            --  [2] v20 (ref)

            return if v28 > 0 then arg8 * v28 else if not (arg9 > 0) then nil else if not v20 then nil else if not v20.Connected then nil else arg8 * v28
        end, v20, arg1)
    end
}
