-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.mod.recolor
-- Class: ModuleScript
-- bytes: 5507

local t = {
    Single = {
        Color3 = { "Decal", "Texture" },
        Color = {
            "Part",
            "Union",
            "MeshPart",
            "SpotLight",
            "PointLight",
            "SurfaceLight",
            "SurfaceAppearance"
        }
    },
    Sequence = { Color = { "Beam", "Trail", "ParticleEmitter" } }
}

local _ = function(n1: number) --[[ warp ]] -- line: 30
    return (n1 % 1 + 1) % 1
end

local _ = function(n2: number, n3: number) --[[ multiplyHue ]] -- line: 34
    return ((n2 + (n3 - 0.5) * 1) % 1 + 1) % 1
end

local _ = function(n4: number, n5: number) --[[ multiplyChannel ]] -- line: 39
    local v1 = n5 * 2 - 1

    if v1 >= 0 then
        return (math.clamp(n4 + (1 - n4) * v1, 0, 1))
    end

    return (math.clamp(n4 - n4 * math.abs(v1), 0, 1))
end

local _ = function(u1: Color3) --[[ normalizeColor ]] -- line: 49
    local R = u1.R
    local G = u1.G
    local B = u1.B
    local v2 = math.max(1, R, G, B)

    return v2, Color3.new(R / v2, G / v2, B / v2)
end

local function multiplyRGB(u2: Color3, n6: number) -- line: 55
    return Color3.new(u2.R * n6, u2.G * n6, u2.B * n6)
end

local function recolorObj(u3: userdata, u4: Color3, s1: string, b1: boolean) -- line: 59
    -- upvalues:
    --  [1] t (copy)
    --  [2] multiplyRGB (copy)

    if not b1 and u3:IsA("BasePart") then
        return
    end

    local v3, v4, v5 = u4:ToHSV()
    local B_3

    for _, val in t do
        for key_1, val_1 in val do
            if table.find(val_1, u3.ClassName) then
                local v6 = u3[key_1]

                if s1 == "multiply" then
                    if typeof(v6) == "Color3" then
                        local R_1 = v6.R
                        local G_1 = v6.G
                        local B_1 = v6.B
                        local v7 = math.max(1, R_1, G_1, B_1)
                        local v8 = v7
                        local v11, v9
                        v9, B_3, v11 = Color3.new(R_1 / v7, G_1 / v7, B_1 / v7):ToHSV()
                        local v12 = ((v9 + (v3 - 0.5) * 1) % 1 + 1) % 1
                        local v13 = v4 * 2 - 1
                        v9 = if v13 >= 0 then math.clamp(B_3 + (1 - B_3) * v13, 0, 1) else math.clamp(
                            B_3 - B_3 * math.abs(v13),
                            0,
                            1
                        )
                        local v14 = v5 * 2 - 1
                        local color = Color3.fromHSV(
                            v12,
                            v9,
                            if v14 >= 0 then math.clamp(v11 + (1 - v11) * v14, 0, 1) else math.clamp(
                                v11 - v11 * math.abs(v14),
                                0,
                                1
                            )
                        )
                        u3[key_1] = Color3.new(color.R * v8, color.G * v8, color.B * v8)
                    elseif typeof(v6) == "ColorSequence" then
                        local t_3 = {}

                        for _, val_2 in v6.Keypoints do
                            local Value = val_2.Value
                            local R_2 = Value.R
                            local G_2 = Value.G
                            local B_2 = Value.B
                            local v15 = math.max(1, R_2, G_2, B_2)
                            local v16, v17, v18 = Color3.new(R_2 / v15, G_2 / v15, B_2 / v15):ToHSV()
                            local v19 = ((v16 + (v3 - 0.5) * 1) % 1 + 1) % 1
                            local v20 = v4 * 2 - 1
                            v16 = if v20 >= 0 then math.clamp(v17 + (1 - v17) * v20, 0, 1) else math.clamp(
                                v17 - v17 * math.abs(v20),
                                0,
                                1
                            )
                            local v21 = v5 * 2 - 1
                            v17 = if v21 >= 0 then math.clamp(v18 + (1 - v18) * v21, 0, 1) else math.clamp(
                                v18 - v18 * math.abs(v21),
                                0,
                                1
                            )
                            table.insert(
                                t_3,
                                ColorSequenceKeypoint.new(
                                    val_2.Time,
                                    multiplyRGB(Color3.fromHSV(v19, v16, v17), v15)
                                )
                            )
                        end

                        u3[key_1] = ColorSequence.new(t_3)
                    end
                elseif typeof(v6) == "Color3" then
                    local R_3 = v6.R
                    local G_3 = v6.G
                    B_3 = v6.B
                    local v23 = math.max(1, R_3, G_3, B_3)
                    local v24 = v23
                    local _ = Color3.new(R_3 / v23, G_3 / v23, B_3 / v23)
                    u3[key_1] = Color3.new(u4.R * v24, u4.G * v24, u4.B * v24)
                elseif typeof(v6) == "ColorSequence" then
                    u3[key_1] = ColorSequence.new(u4)
                end
            end
        end
    end
end

local function recolor(u5: Color3, s2: string, ...) -- line: 112
    -- upvalues:
    --  [1] recolorObj (copy)

    for _, val_3 in { ... } do
        recolorObj(val_3, u5, s2, true)

        for _, descendant in val_3:GetDescendants() do
            recolorObj(descendant, u5, s2, false)
        end
    end
end

return recolor
