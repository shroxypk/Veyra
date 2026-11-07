-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.mod.color.Oklab
-- Class: ModuleScript
-- bytes: 1751

local ColorSRGB_m = require("../color/sRGB")
local t = {
    fromLinear = function(u1: Color3) --[[ fromLinear ]] -- line: 42
        local v1 = (u1.R * 0.4122214708 + u1.G * 0.5363325363 + u1.B * 0.0514459929) ^ 0.3333333333333333
        local v2 = (u1.R * 0.2119034982 + u1.G * 0.6806995451 + u1.B * 0.1073969566) ^ 0.3333333333333333
        local v3 = (u1.R * 0.0883024619 + u1.G * 0.2817188376 + u1.B * 0.6299787005) ^ 0.3333333333333333

        return (Vector3.new(
            v1 * 0.2104542553 + v2 * 0.793617785 - v3 * 0.0040720468,
            v1 * 1.9779984951 - v2 * 2.428592205 + v3 * 0.4505937099,
            v1 * 0.0259040371 + v2 * 0.7827717662 - v3 * 0.808675766
        ))
    end
}

function t.fromSRGB(u2: Color3) -- line: 59
    -- upvalues:
    --  [1] t (copy)
    --  [2] ColorSRGB_m (copy)

    return t.fromLinear(ColorSRGB_m.toLinear(u2))
end

function t.toLinear(vec1: Vector3, b1: boolean?) -- line: 65
    local v4 = (vec1.X + vec1.Y * 0.3963377774 + vec1.Z * 0.2158037573) ^ 3
    local v5 = (vec1.X - vec1.Y * 0.1055613458 - vec1.Z * 0.0638541728) ^ 3
    local v6 = (vec1.X - vec1.Y * 0.0894841775 - vec1.Z * 1.291485548) ^ 3
    local v7 = v4 * 4.0767416621 - v5 * 3.3077115913 + v6 * 0.2309699292
    local v8 = v4 * -1.2684380046 + v5 * 2.6097574011 - v6 * 0.3413193965
    local v9 = v4 * -0.0041960863 - v5 * 0.7034186147 + v6 * 1.707614701

    if not b1 then
        v7 = math.clamp(v7, 0, 1)
        v8 = math.clamp(v8, 0, 1)
        v9 = math.clamp(v9, 0, 1)
    end

    return Color3.new(v7, v8, v9)
end

function t.toSRGB(vec2: Vector3, b2: boolean?) -- line: 89
    -- upvalues:
    --  [1] ColorSRGB_m (copy)
    --  [2] t (copy)

    return ColorSRGB_m.fromLinear(t.toLinear(vec2, b2))
end

return t
