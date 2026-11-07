-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.effects.particle
-- Class: ModuleScript
-- bytes: 2423

local ModAttributes_m = require("../mod/attributes")
local ModTween_m = require("../mod/tween")
local _ = require("../types")
local ModUtility_m = require("../mod/utility")

return {
    emit = function(u1: userdata, u2: userdata, arg1: any) --[[ emit ]] -- line: 8
        -- upvalues:
        --  [1] ModAttributes_m (copy)
        --  [2] ModTween_m (copy)
        --  [3] ModUtility_m (copy)

        if u1.Enabled then
            u1.Enabled = false
        end

        local v1 = ModAttributes_m.get(u1, "EmitDelay", 0)
        local v2 = ModAttributes_m.get(u1, "EmitCount", 1)
        local v3 = ModAttributes_m.get(u1, "EmitDuration", 0)
        local v4 = v3 > 0 and true
        task.wait(v1)

        if v4 then
            u2.Enabled = true
        end

        local v5 = ModAttributes_m.get(u1, "TimeScale_Start", u2.TimeScale, true)
        local v6 = ModAttributes_m.get(u1, "TimeScale_End", u2.TimeScale, true)
        local v7 = nil

        if v5 ~= v6 then
            local v8 = ModAttributes_m.get(u1, "TimeScale_Duration", 0.1)
            v7 = ModTween_m.fromParams(ModAttributes_m.get(
                u1,
                "TimeScale_Curve",
                ModUtility_m.default_bezier
            ), v8, function(arg2, arg3) -- line: 36
                -- upvalues:
                --  [1] ModUtility_m (ref)
                --  [2] v5 (copy)
                --  [3] v6 (copy)
                --  [4] u2 (copy)

                u2.TimeScale = ModUtility_m.lerp(v5, v6, (math.clamp(arg2, 0, 1)))

                return arg3
            end)
            table.insert(arg1, v7)
        elseif v5 ~= u2.TimeScale then
            u2.TimeScale = v5
        end

        ModUtility_m.onCancel(arg1, function() -- line: 50
            -- upvalues:
            --  [1] v4 (copy)
            --  [2] u2 (copy)

            if v4 then
                u2.Enabled = false
            end

            u2:Clear()
        end)
        u2:Emit(v2)

        if v4 then
            task.wait(v3)
            u2.Enabled = false
        end

        ModTween_m.timer(u1.Lifetime.Max, function(arg4, arg5) -- line: 65
            -- upvalues:
            --  [1] u1 (copy)
            --  [2] v7 (ref)

            return if u1.TimeScale > 0 then arg4 * u1.TimeScale else if not (arg5 > 0) then nil else if not v7 then nil else if not v7.Connected then nil else arg4 * u1.TimeScale
        end, v7, arg1)
    end
}
