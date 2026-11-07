-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.mod.color.sRGB
-- Class: ModuleScript
-- bytes: 1301

local t = {
    fromLinear = function(u1: Color3) --[[ fromLinear ]] -- line: 61
        local v1 = u1.R
        local v2 = if not (v1 < 0.0031308) then v1 ^ 0.4166666666666667 * 1.055 - 0.055 else v1 * 12.92
        local v3 = u1.G
        v1 = if not (v3 < 0.0031308) then v3 ^ 0.4166666666666667 * 1.055 - 0.055 else v3 * 12.92
        local B = u1.B
        v3 = if not (B < 0.0031308) then B ^ 0.4166666666666667 * 1.055 - 0.055 else B * 12.92

        return Color3.new(v2, v1, v3)
    end,
    toLinear = function(u2: Color3) --[[ toLinear ]] -- line: 67
        local v4 = u2.R
        local v5 = if not (v4 < 0.04045) then ((v4 + 0.055) / 1.055) ^ 2.4 else v4 / 12.92
        local v6 = u2.G
        v4 = if not (v6 < 0.04045) then ((v6 + 0.055) / 1.055) ^ 2.4 else v6 / 12.92
        local B_1 = u2.B
        v6 = if not (B_1 < 0.04045) then ((B_1 + 0.055) / 1.055) ^ 2.4 else B_1 / 12.92

        return Color3.new(v5, v4, v6)
    end
}

local _ = function(n1: number) --[[ transform ]] -- line: 42
    if n1 < 0.04045 then
        return n1 / 12.92
    end

    return ((n1 + 0.055) / 1.055) ^ 2.4
end

local _ = function(n2: number) --[[ inverse ]] -- line: 52
    if n2 < 0.0031308 then
        return n2 * 12.92
    end

    return n2 ^ 0.4166666666666667 * 1.055 - 0.055
end

return t
