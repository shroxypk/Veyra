-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.effects.randomizer
-- Class: ModuleScript
-- bytes: 2889

local ModAttributes_m = require("../mod/attributes")
local ModLerp_m = require("../mod/lerp")
local ModTween_m = require("../mod/tween")
local _ = require("../types")
local ModUtility_m = require("../mod/utility")
local ObjBezier_m = require("../obj/Bezier")
local rng = Random.new()
local t = {}

local function getBezier(s1: string) -- line: 14
    -- upvalues:
    --  [1] ModTween_m (copy)
    --  [2] ModUtility_m (copy)
    --  [3] ObjBezier_m (copy)

    local v1 = ModTween_m.bezier_cache[s1]

    if not v1 then
        local Success, Result = pcall(function() -- line: 18
            -- upvalues:
            --  [1] ModUtility_m (ref)
            --  [2] s1 (copy)

            return ModUtility_m.deserializePath(s1)
        end)

        if not Success then
            return nil
        end

        v1 = ObjBezier_m.new(Result, 0)
        ModTween_m.bezier_cache[s1] = v1
    end

    return v1
end

local _ = function(arg1) --[[ sampleWeighted ]] -- line: 33
    -- upvalues:
    --  [1] rng (copy)

    return 1 - arg1:getEase((rng:NextNumber())).y
end

function t.emit(u1: userdata, _: any, b1: boolean) -- line: 40
    -- upvalues:
    --  [1] ModUtility_m (copy)
    --  [2] ModAttributes_m (copy)
    --  [3] getBezier (copy)
    --  [4] ModLerp_m (copy)
    --  [5] rng (copy)

    local v2 = ModUtility_m.getTarget(u1)

    if not v2 then
        return
    end

    local Name = u1.Name
    local v3 = ModAttributes_m.get(u1, "_START_VALUE", nil)
    local v4 = ModAttributes_m.get(u1, "_END_VALUE", nil)

    if v3 == nil or v4 == nil then
        return
    end

    local v5 = typeof(v3)

    if v5 ~= typeof(v4) then
        return
    end

    local v8 = getBezier((ModAttributes_m.get(u1, "Weight_Curve", ModUtility_m.linear_bezier)))

    if not v8 then
        return
    end

    local _ = nil
    local v10

    if b1 then
        _ = ModAttributes_m.get(v2, Name, nil)
    else
        local Success_1, Result_1 = pcall(function() -- line: 74
            -- upvalues:
            --  [1] v2 (copy)
            --  [2] Name (copy)

            return v2[Name]
        end)

        if not Success_1 then
            return
        end

        v10 = Result_1
    end

    local v12 = (ModLerp_m[v5] or ModLerp_m.Other)(v3, v4, 1 - v8:getEase((rng:NextNumber())).y)
    local v13 = ModAttributes_m.get(u1, "ResetOnFinish", true)

    if b1 then
        ModAttributes_m.set(v2, Name, v12)
    else
        v2[Name] = v12
    end

    if v13 then
        task.defer(function() -- line: 100
            -- upvalues:
            --  [1] b1 (copy)
            --  [2] ModAttributes_m (ref)
            --  [3] v2 (copy)
            --  [4] Name (copy)
            --  [5] v10 (ref)

            if b1 then
                ModAttributes_m.set(v2, Name, v10)

                return
            end

            v2[Name] = v10
        end)
    end
end

return t
