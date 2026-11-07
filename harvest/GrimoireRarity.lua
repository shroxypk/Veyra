-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.GrimoireRarity
-- Class: ModuleScript
-- bytes: 24442

local _ = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local StatManager_m = require(game:GetService("ReplicatedStorage").Modules.StatManager)
local rng = Random.new()
local t = {
    Light = true,
    BasePart = true,
    ParticleEmitter = true,
    Trail = true,
    Beam = true,
    ImageLabel = true,
    Decal = true,
    SpecialMesh = true,
    Highlight = true,
    Fire = true,
    Smoke = true
}
local t_1 = {
    ImageLabel = "ImageColor3",
    Decal = "Color3",
    SpecialMesh = "VertexColor",
    Highlight = { "FillColor", "OutlineColor" },
    Fire = { "Color", "SecondaryColor" }
}

local _ = function(arg1) --[[ getTotalWeightOfLootTable ]] -- line: 37
    local v2 = 0

    for _, val in ipairs(arg1) do
        v2 += val.Weight
    end

    return v2
end

local _ = function(arg2, arg3, arg4) --[[ rgbToHsv ]] -- line: 45
    local v3 = math.max(arg2, arg3, arg4)
    local v4 = v3 - math.min(arg2, arg3, arg4)
    local v5 = 0
    local v6 = if v3 == 0 then 0 else v4 / v3
    v5 = if v4 == 0 then v5 else if v3 ~= arg2 then if v3 ~= arg3 then ((arg2 - arg3) / v4 + 4) / 6 else ((arg4 - arg2) / v4 + 2) / 6 else (arg3 - arg4) / v4 % 6 / 6

    return v5, v6, v3
end

local function hsvToRgb(arg5, arg6, arg7) -- line: 68
    local _ = 0
    local _ = 0
    local _ = 0
    local v10 = math.floor(arg5 * 6)
    local v11 = arg5 * 6 - v10
    local v12 = arg7 * (1 - arg6)
    local v13 = arg7 * (1 - v11 * arg6)
    local v14 = arg7 * (1 - (1 - v11) * arg6)
    v10 %= 6

    if v10 == 0 then
        return arg7, v14, v12
    end

    if v10 == 1 then
        return v13, arg7, v12
    end

    if v10 == 2 then
        return v12, arg7, v14
    end

    if v10 == 3 then
        return v12, v13, arg7
    end

    if v10 == 4 then
        return v14, v12, arg7
    end

    local v15, v16, v17

    if v10 == 5 then
        v15 = arg7
        v16 = v12
        v17 = v13
    end

    return v15, v16, v17
end

local _ = function(arg8, arg9, arg10, arg11) --[[ shiftToTargetColor ]] -- line: 96
    -- upvalues:
    --  [1] hsvToRgb (copy)

    local v18 = math.max(arg8, arg9, arg10)
    local v19 = v18 - math.min(arg8, arg9, arg10)
    local v20 = 0
    local v21 = if v18 == 0 then 0 else v19 / v18
    v20 = if v19 == 0 then v20 else if v18 ~= arg8 then if v18 ~= arg9 then ((arg8 - arg9) / v19 + 4) / 6 else ((arg10 - arg8) / v19 + 2) / 6 else (arg9 - arg10) / v19 % 6 / 6
    local v22 = v21
    v22 = if not (v22 < 0.05) then v22 else 0.35

    return hsvToRgb(arg11, v22, v18)
end

local function processColorSequence(arg12, arg13) -- line: 105
    -- upvalues:
    --  [1] hsvToRgb (copy)

    local t_2 = {}

    for index = 0, #arg12.Keypoints - 1 do
        local v23 = arg12.Keypoints[index + 1]
        local R = v23.Value.R
        local G = v23.Value.G
        local B = v23.Value.B
        local _ = #arg12.Keypoints - 1
        local v25 = math.max(R, G, B)
        local v26 = v25 - math.min(R, G, B)
        local v27 = 0
        local v28 = if v25 == 0 then 0 else v26 / v25
        v27 = if v26 == 0 then v27 else if v25 ~= R then if v25 ~= G then ((R - G) / v26 + 4) / 6 else ((B - R) / v26 + 2) / 6 else (G - B) / v26 % 6 / 6
        local v29 = v28
        v29 = if not (v29 < 0.05) then v29 else 0.35
        local v30, v31
        v30, v27, v31 = hsvToRgb(arg13, v29, v25)
        table.insert(t_2, ColorSequenceKeypoint.new(v23.Time, Color3.new(v30, v27, v31)))
    end

    return ColorSequence.new(t_2)
end

local function recolorTo(u1: Color3, u2: Color3, arg14: any, n1: number?) -- line: 145
    local v32, v33, v34 = u1:ToHSV()
    local v35, v36, v37 = u2:ToHSV()

    if v37 < 0.15 then
        local v38 = v34 * 0.06

        if arg14.MinValue then
            v38 = math.max(v38, arg14.MinValue + v34 * 0.12)
        end

        return Color3.fromHSV(v32, v33 * 0.2, v38)
    end

    if v36 < 0.15 then
        return Color3.fromHSV(v35, v36, (math.clamp(v34 + (v37 - v34) * 0.65, 0, 1)))
    end

    v37 = if v33 < 0.05 then v36 * 0.8 else math.clamp(v33 * (arg14.SatScale or 1), 0, 1)

    if arg14.MinSat then
        v37 = math.max(v37, arg14.MinSat)
    end

    v37 = if not n1 then v37 else if not (n1 > 1) then v37 else 1 - (1 - v37) / n1
    v36 = math.clamp(v34 * (arg14.ValueScale or 1), 0, 1)

    if arg14.MinValue then
        v36 = math.max(v36, arg14.MinValue)
    end

    return Color3.fromHSV(v35, v37, v36)
end

local _ = function(arg15, arg16) --[[ hueDistance ]] -- line: 176
    local v39 = math.abs(arg15 - arg16) % 1

    return (math.min(v39, 1 - v39))
end

local function pickTarget(u3: Color3, arg17: any) -- line: 181
    local Secondary = arg17.Secondary

    if not Secondary then
        return arg17.Primary
    end

    local v40, v41, v42 = u3:ToHSV()

    if arg17.SplitHue then
        if v41 >= 0.15 then
            local v43 = math.abs(v40 - arg17.SplitHue) % 1

            if math.min(v43, 1 - v43) <= (arg17.SplitRange or 0.1) then
                return Secondary
            end
        end

        return arg17.Primary
    end

    if v41 < (arg17.SplitSat or 0.4) and v42 > 0.5 then
        return Secondary
    end

    return arg17.Primary
end

local function recolor(u4: Color3, arg18: any, n2: number?) -- line: 201
    -- upvalues:
    --  [1] recolorTo (copy)
    --  [2] pickTarget (copy)

    return recolorTo(u4, pickTarget(u4, arg18), arg18, n2)
end

local t_3 = { ParticleEmitter = true, Beam = true, Trail = true }
local t_4 = { Highlight = true, Fire = true, Smoke = true }
local t_5 = setmetatable({}, { __mode = "k" })

local function boostOpacity(u5: userdata, n3: number) -- line: 210
    local t_6 = {}

    for _, val_1 in u5.Keypoints do
        local Value = val_1.Value
        local v45 = val_1.Envelope

        if Value > 0 and Value < 1 then
            Value ^= n3
            v45 = math.min(v45, Value, 1 - Value)
        end

        table.insert(t_6, NumberSequenceKeypoint.new(val_1.Time, Value, v45))
    end

    return NumberSequence.new(t_6)
end

local t_7 = {
    ["12297331803"] = Color3.new(0.9, 0.67, 0.58),
    ["15540912052"] = Color3.new(0.72, 0.54, 0.36),
    ["12090748677"] = Color3.new(0.84, 0.53, 0.15),
    ["13386835990"] = Color3.new(0.64, 0.56, 0.45)
}

local function compensate(arg19, arg20, arg21) -- line: 236
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] t_7 (copy)

    if arg21.Compensate == false or not t_3[arg19.ClassName] then
        return arg20
    end

    local v46 = string.match(arg19.Texture, "(%d+)%s*$")
    local v47 = v46

    if v47 then
        v47 = t_7[v46]
    end

    if not v47 then
        return arg20
    end

    local v48 = math.max
    local v49 = v48(v47.R, v47.G, v47.B)
    v48 = if type(arg21.Compensate) == "number" then arg21.Compensate else 0.35

    local _ = function(arg22) --[[ pull ]] -- line: 248
        -- upvalues:
        --  [1] v49 (copy)
        --  [2] v48 (copy)

        return 1 - (1 - math.max(arg22 / v49, 0.08)) * v48
    end

    local v50 = 1 - (1 - math.max(v47.R / v49, 0.08)) * v48
    local v51 = 1 - (1 - math.max(v47.G / v49, 0.08)) * v48
    local v52 = 1 - (1 - math.max(v47.B / v49, 0.08)) * v48
    local t_8 = {}
    local v53 = 1

    for key_2, val_2 in arg20 do
        local Value_1 = val_2.Value
        local v54 = Value_1.R / v50
        local v55 = Value_1.G / v51
        local v56 = Value_1.B / v52
        t_8[key_2] = { val_2.Time, v54, v55, v56 }
        v53 = math.max(v53, v54, v55, v56)
    end

    local t_9 = {}

    for key_3, val_3 in t_8 do
        t_9[key_3] = ColorSequenceKeypoint.new(
            val_3[1],
            Color3.new(val_3[2] / v53, val_3[3] / v53, val_3[4] / v53)
        )
    end

    arg19.Brightness = arg19.Brightness * (math.min(v53, 4) * (arg21.BakedBoost or 1))

    return t_9
end

local function applyRecolor(arg23, arg24, arg25) -- line: 268
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] recolorTo (copy)
    --  [3] pickTarget (copy)
    --  [4] recolor (copy)
    --  [5] compensate (copy)

    local v59 = arg23[arg24]
    local v60 = typeof(v59)
    local v61 = if arg25.BrightSat and t_3[arg23.ClassName] then arg23.Brightness else nil

    if v60 == "Color3" then
        arg23[arg24] = recolorTo(v59, pickTarget(v59, arg25), arg25, v61)

        return
    end

    if v60 == "ColorSequence" then
        local t_10 = {}

        for _, val_4 in v59.Keypoints do
            table.insert(
                t_10,
                ColorSequenceKeypoint.new(val_4.Time, recolor(val_4.Value, arg25, v61))
            )
        end

        arg23[arg24] = ColorSequence.new((compensate(arg23, t_10, arg25)))

        return
    end

    if v60 == "Vector3" then
        local color = Color3.new(v59.X, v59.Y, v59.Z)
        local v64 = recolorTo(color, pickTarget(color, arg25), arg25, nil)
        arg23[arg24] = Vector3.new(v64.R, v64.G, v64.B)
    end
end

local function applyRecolorExtras(arg26, arg27) -- line: 288
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] boostOpacity (copy)

    if t_3[arg26.ClassName] then
        if arg27.LightEmission ~= nil then
            arg26.LightEmission = arg27.LightEmission
        elseif arg27.NegativeEmission ~= nil and arg26.LightEmission < 0 then
            arg26.LightEmission = arg27.NegativeEmission
        end

        if arg27.MinBrightness or arg27.MaxBrightness then
            local v65 = arg26.Brightness

            if arg27.MinBrightness then
                v65 = math.max(v65, arg27.MinBrightness)
            end

            if arg27.MaxBrightness then
                v65 = math.min(v65, arg27.MaxBrightness)
            end

            arg26.Brightness = v65
        end

        if arg27.OpacityBoost then
            arg26.Transparency = boostOpacity(arg26.Transparency, arg27.OpacityBoost)

            return
        end
    elseif arg27.OpacityBoost and arg26:IsA("BasePart") then
        local Transparency = arg26.Transparency

        if Transparency > 0 and Transparency < 1 then
            arg26.Transparency = Transparency ^ arg27.OpacityBoost
        end
    end
end

local function applyColor(arg28, arg29, _) -- line: 318
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_4 (copy)
    --  [3] t_5 (copy)
    --  [4] t_1 (copy)
    --  [5] applyRecolorExtras (copy)
    --  [6] applyRecolor (copy)
    --  [7] hsvToRgb (copy)
    --  [8] processColorSequence (copy)

    if arg28:HasTag("IgnoreFX") then
        return
    end

    local v66 = nil

    for key_5 in t do
        if arg28:IsA(key_5) then
            v66 = key_5
            break
        end
    end

    if not v66 then
        return
    end

    local Primary = arg29.Primary

    if not Primary then
        return
    end

    if t_4[v66] and not arg29.Recolor then
        return
    end

    if t_5[arg28] == arg29 then
        return
    end

    t_5[arg28] = arg29
    local v67 = t_1[v66] or "Color"

    if arg29.Recolor then
        applyRecolorExtras(arg28, arg29)

        if type(v67) == "table" then
            for _, val_5 in v67 do
                applyRecolor(arg28, val_5, arg29)
            end

            return
        end

        applyRecolor(arg28, v67, arg29)

        return
    else
        local v68, v69, v70 = Primary:ToHSV()
        v69 = v70 < 0.15 and true
        local v71 = typeof(arg28[v67])
        v66 = arg28[v67]
        local v77

        if v71 == "Color3" then
            local R_1 = v66.R
            local G_1 = v66.G
            local B_1 = v66.B
            local v72 = math.max(R_1, G_1, B_1)
            local v73 = v72 - math.min(R_1, G_1, B_1)
            local v74 = 0
            local v75 = if v72 == 0 then 0 else v73 / v72
            v74 = if v73 == 0 then v74 else if v72 ~= R_1 then if v72 ~= G_1 then ((R_1 - G_1) / v73 + 4) / 6 else ((B_1 - R_1) / v73 + 2) / 6 else (G_1 - B_1) / v73 % 6 / 6
            local v76 = v75
            v76 = if not (v76 < 0.05) then v76 else 0.35
            local v78, v79
            v77, v78, v79 = hsvToRgb(v68, v76, v72)
            local v80 = math.max(v77, v78, v79)
            local v81 = v80 - math.min(v77, v78, v79)
            local v82 = 0
            local v83 = if v80 == 0 then 0 else v81 / v80
            v82 = if v81 == 0 then v82 else if v80 ~= v77 then if v80 ~= v78 then ((v77 - v78) / v81 + 4) / 6 else ((v79 - v77) / v81 + 2) / 6 else (v78 - v79) / v81 % 6 / 6

            if v69 then
                arg28[v67] = Color3.fromRGB(1, 1, 1)

                return
            end

            arg28[v67] = Color3.fromHSV(v68, v83, v80)

            return
        elseif v71 == "ColorSequence" then
            if v69 then
                local t_11 = {}

                for index_1 = 1, #v66.Keypoints do
                    local v84 = v66.Keypoints[index_1]
                    local _ = #v66.Keypoints
                    table.insert(
                        t_11,
                        ColorSequenceKeypoint.new(
                            v84.Time,
                            (Color3.new(v84.Value.R, v84.Value.G, v84.Value.B):Lerp(Primary, 0.99))
                        )
                    )
                end

                arg28[v67] = ColorSequence.new(t_11)

                return
            end

            arg28[v67] = processColorSequence(v66, v68)

            return
        else
            if v71 == "Vector3" then
                v77 = v66.X
                local Y = v66.Y
                local Z = v66.Z
                local v87 = math.max(v77, Y, Z)
                local v88 = v87 - math.min(v77, Y, Z)
                local v89 = 0
                local _ = if v87 == 0 then 0 else v88 / v87
                v89 = if v88 == 0 then v89 else if v87 ~= v77 then if v87 ~= Y then ((v77 - Y) / v88 + 4) / 6 else ((Z - v77) / v88 + 2) / 6 else (Y - Z) / v88 % 6 / 6

                if v69 then
                    arg28[v67] = Vector3.new(0, 0, 0)

                    return
                end

                arg28[v67] = Vector3.new(Primary.R, Primary.G, Primary.B)
            end

            return
        end
    end
end

local t_12 = {}
t_12.__index = t_12
local t_13 = {
    Spatial = nil,
    Wind = nil,
    Light = nil,
    Flame = nil,
    Lightning = nil,
    Shadow = nil,
    Beast = nil,
    Time = nil
}
local t_14 = { Name = "Default", Weight = 1, Colors = { Primary = Color3.fromRGB(167, 123, 255) } }
t_13.Spatial = { t_14 }
local t_17 = {
    Name = "Default",
    Weight = 0.8,
    Colors = { Primary = Color3.fromRGB(169, 209, 162) }
}
local t_20 = {
    Name = "Crimson",
    Weight = 0.02,
    Colors = { Primary = Color3.fromRGB(213, 59, 59), Button = Color3.fromRGB(213, 176, 166) }
}
local t_22 = {
    Name = "Sandstorm",
    Weight = 0.04,
    Colors = {
        Recolor = true,
        Primary = Color3.fromRGB(222, 192, 120),
        MinSat = 0.3,
        BrightSat = true,
        Button = Color3.fromRGB(228, 205, 145)
    }
}
local t_24 = {
    Name = "Zephyr",
    Weight = 0.08,
    Colors = {
        Recolor = true,
        Primary = Color3.fromRGB(245, 245, 245),
        Button = Color3.fromRGB(235, 235, 235)
    }
}
local t_26 = {
    Name = "Ocean Breeze",
    Weight = 0.06,
    Colors = {
        Recolor = true,
        Primary = Color3.fromRGB(90, 155, 220),
        MinSat = 0.33,
        BrightSat = true,
        Button = Color3.fromRGB(145, 185, 230)
    }
}
t_13.Wind = { t_17, t_20, t_22, t_24, t_26 }
local t_28 = {
    Name = "Default",
    Weight = 0.8,
    Colors = { Primary = Color3.fromRGB(255, 234, 129) }
}
local t_31 = {
    Name = "Moon",
    Weight = 0.11,
    Colors = { Primary = Color3.fromRGB(132, 136, 251), Button = Color3.fromRGB(202, 204, 251) }
}
local t_33 = {
    Name = "Radiant",
    Weight = 0.03,
    Colors = {
        Recolor = true,
        Primary = Color3.fromRGB(255, 255, 255),
        Button = Color3.fromRGB(240, 240, 240)
    }
}
local t_35 = {
    Name = "Scarlet",
    Weight = 0.06,
    Colors = {
        Recolor = true,
        Primary = Color3.fromRGB(230, 45, 45),
        Button = Color3.fromRGB(235, 140, 140)
    }
}
t_13.Light = { t_28, t_31, t_33, t_35 }
local t_37 = {
    Name = "Amaterasu",
    Weight = 0.03,
    Colors = { Primary = Color3.fromRGB(0, 0, 0), Button = Color3.fromRGB(47, 47, 47) }
}
local t_41 = {
    Name = "Azure",
    Weight = 0.14,
    Colors = { Primary = Color3.fromRGB(34, 65, 132), Button = Color3.fromRGB(134, 176, 255) }
}
local t_43 = {
    Name = "Holy",
    Weight = 0.03,
    Colors = {
        Recolor = true,
        Primary = Color3.fromRGB(255, 255, 255),
        NegativeEmission = 0,
        MinBrightness = 1,
        Compensate = 0,
        BakedBoost = 2.5,
        Button = Color3.fromRGB(240, 240, 240)
    }
}
t_13.Flame = { { Name = "Default", Weight = 0.8 }, t_37, t_41, t_43 }
local t_45 = { Name = "Default", Weight = 0.8, Colors = { Primary = Color3.fromRGB(170, 85, 255) } }
local t_48 = {
    Name = "Storm",
    Weight = 0.08,
    Colors = { Primary = Color3.fromRGB(115, 222, 251), Button = Color3.fromRGB(155, 171, 181) }
}
local t_50 = {
    Name = "Solar",
    Weight = 0.05,
    Colors = { Primary = Color3.fromRGB(253, 255, 129), Button = Color3.fromRGB(255, 238, 170) }
}
local t_52 = {
    Name = "Verdant",
    Weight = 0.04,
    Colors = { Primary = Color3.fromRGB(169, 209, 162), Button = Color3.fromRGB(61, 145, 61) }
}
local t_54 = {
    Name = "Bloodstorm",
    Weight = 0.02,
    Colors = {
        Recolor = true,
        Primary = Color3.fromRGB(230, 35, 35),
        Button = Color3.fromRGB(240, 130, 130)
    }
}
local t_56 = {
    Name = "Ignis",
    Weight = 0.01,
    Colors = {
        Recolor = true,
        Primary = Color3.fromRGB(255, 130, 30),
        Button = Color3.fromRGB(255, 180, 110)
    }
}
t_13.Lightning = { t_45, t_48, t_50, t_52, t_54, t_56 }
local t_58 = {
    Name = "Void",
    Weight = 0.06,
    Colors = {
        Recolor = true,
        Primary = Color3.fromRGB(120, 50, 200),
        ValueScale = 0.7,
        MinValue = 0.42,
        MinSat = 0.6,
        MinBrightness = 1,
        MaxBrightness = 1.2,
        Button = Color3.fromRGB(170, 130, 230)
    }
}
local t_62 = {
    Name = "Bloodshade",
    Weight = 0.04,
    Colors = {
        Recolor = true,
        Primary = Color3.fromRGB(125, 15, 25),
        ValueScale = 0.5,
        MinValue = 0.28,
        MinSat = 0.65,
        MinBrightness = 1,
        MaxBrightness = 1.2,
        Button = Color3.fromRGB(180, 70, 80)
    }
}
local t_64 = {
    Name = "Miasma",
    Weight = 0.08,
    Colors = {
        Recolor = true,
        Primary = Color3.fromRGB(38, 105, 46),
        ValueScale = 0.45,
        MinValue = 0.26,
        MinSat = 0.55,
        MinBrightness = 1,
        MaxBrightness = 1.2,
        Button = Color3.fromRGB(100, 165, 110)
    }
}
local t_66 = {
    Name = "Phantom",
    Weight = 0.02,
    Colors = {
        Recolor = true,
        Primary = Color3.fromRGB(240, 240, 240),
        NegativeEmission = 0,
        MinBrightness = 1,
        Button = Color3.fromRGB(230, 230, 230)
    }
}
t_13.Shadow = { { Name = "Default", Weight = 0.8 }, t_58, t_62, t_64, t_66 }
local t_68 = {
    Name = "Silverfang",
    Weight = 0.17,
    Colors = {
        Recolor = true,
        Primary = Color3.fromRGB(195, 200, 210),
        Button = Color3.fromRGB(205, 210, 220)
    }
}
local t_72 = {
    Name = "Duskfang",
    Weight = 0.03,
    Colors = {
        Recolor = true,
        Primary = Color3.fromRGB(95, 85, 240),
        Button = Color3.fromRGB(150, 145, 245)
    }
}
t_13.Beast = { { Name = "Default", Weight = 0.8 }, t_68, t_72 }
local t_74 = {
    Name = "Gilded",
    Weight = 0.05,
    Colors = {
        Recolor = true,
        Primary = Color3.fromRGB(255, 200, 70),
        Secondary = Color3.fromRGB(255, 255, 255),
        SplitHue = 0.63,
        Button = Color3.fromRGB(255, 220, 130)
    }
}
local t_78 = {
    Name = "Monochrome",
    Weight = 0.01,
    Colors = {
        Recolor = true,
        Primary = Color3.fromRGB(255, 255, 255),
        Secondary = Color3.fromRGB(0, 0, 0),
        SplitHue = 0.63,
        Button = Color3.fromRGB(200, 200, 200)
    }
}
local t_80 = {
    Name = "Cosmic",
    Weight = 0.14,
    Colors = {
        Recolor = true,
        Primary = Color3.fromRGB(255, 255, 255),
        Secondary = Color3.fromRGB(150, 90, 255),
        SplitHue = 0.63,
        Button = Color3.fromRGB(190, 160, 255)
    }
}
t_13.Time = { { Name = "Default", Weight = 0.8 }, t_74, t_78, t_80 }
t_12.Variants = t_13
t_12.TextureTints = t_7
t_12.VariantAliases = { Whitefire = "Holy", Ashen = "Holy" }
t_12.Grimoires = {
    { Name = "Beast", Weight = 0.05 },
    { Name = "Flame", Weight = 0.22 },
    { Name = "Light", Weight = 0.22 },
    { Name = "Wind", Weight = 0.2 },
    { Name = "Lightning", Weight = 0.15 },
    { Name = "Shadow", Weight = 0.15 },
    { Name = "Time", Weight = 0.01 },
    { Name = "Spatial", Weight = 0 }
}
table.sort(t_12.Grimoires, function(arg31, arg32) -- line: 487
    return arg31.Weight < arg32.Weight
end)

function t_12.GetPlayerVariant(arg33, arg34) -- line: 491
    -- upvalues:
    --  [1] Players (copy)
    --  [2] StatManager_m (copy)

    local playerFromCharacter = Players:GetPlayerFromCharacter(arg34)

    if not playerFromCharacter then
        return
    end

    local v92 = StatManager_m.require(playerFromCharacter)
    local Magic = v92:GetStat("Magic")
    local MagicVariant = v92:GetStat("MagicVariant")
    MagicVariant = arg33.VariantAliases[MagicVariant] or MagicVariant
    local v93 = arg33.Variants[Magic]

    if not v93 then
        return
    end

    for _, val_6 in v93 do
        local Colors = val_6.Colors

        if val_6.Name == MagicVariant and Colors then
            return Colors
        end
    end

    return nil
end

function t_12.GetSkillVariant(arg35, arg36, arg37) -- line: 518
    -- upvalues:
    --  [1] Players (copy)
    --  [2] StatManager_m (copy)

    local v94 = arg35.Variants[arg37]

    if not v94 then
        return nil
    end

    local v95 = "Default"
    local v96 = Players:GetPlayerFromCharacter(arg36)

    if v96 then
        local v97 = StatManager_m.require(v96)

        if v97:GetStat("Magic") == arg37 then
            v95 = v97:GetStat("MagicVariant") or "Default"
            v95 = arg35.VariantAliases[v95] or v95
        end
    end

    v96 = nil

    for _, val_7 in v94 do
        if val_7.Name == v95 and val_7.Colors then
            return val_7.Colors
        end

        if val_7.Name == "Default" then
            v96 = val_7.Colors
        end
    end

    return v96
end

function t_12.GetPlayerGrimoire(arg38, arg39) -- line: 548
    for _, val_8 in arg38.Grimoires do
        if val_8.Name == arg39 then
            return val_8
        end
    end
end

function t_12.ApplyVariantEffect(
    _,
    arg41,
    arg42,
    arg43,
    arg44
) -- line: 556
    -- upvalues:
    --  [1] applyColor (copy)

    if not arg41 or not arg42 then
        return
    end

    local v98 = if typeof(arg41) == "table" then arg41 else { arg41 }

    if arg43 then
        for _, val_9 in v98 do
            applyColor(val_9, arg42, arg44)
        end

        return
    end

    for _, val_10 in v98 do
        if val_10:IsA("BasePart") then
            applyColor(val_10, arg42)
        end

        for _, descendant in val_10:GetDescendants() do
            applyColor(descendant, arg42, arg44)
        end
    end
end

function t_12.GetVariant(arg45, arg46) -- line: 581
    -- upvalues:
    --  [1] rng (copy)

    local v99 = arg45.Variants[arg46]

    if not v99 then
        return "Default"
    end

    local v100 = 0

    for _, val_11 in ipairs(v99) do
        v100 += val_11.Weight
    end

    local v101 = rng:NextNumber(0, v100)

    for _, val_12 in ipairs(v99) do
        if v101 <= val_12.Weight then
            return val_12.Name
        end

        v101 -= val_12.Weight
    end
end

function t_12.GetGrimoire(arg47) -- line: 599
    -- upvalues:
    --  [1] rng (copy)

    local v102 = 0

    for _, val_13 in ipairs(arg47.Grimoires) do
        v102 += val_13.Weight
    end

    local v103 = rng:NextNumber(0, v102)

    for _, val_14 in ipairs(arg47.Grimoires) do
        local Name = val_14.Name
        local Weight = val_14.Weight

        if Weight > 0 and v103 <= Weight then
            return Name, Weight, (arg47:GetVariant(Name))
        end

        v103 -= Weight
    end

    task.wait()
end

return t_12
