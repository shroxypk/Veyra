-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.BoatTween.Lerps
-- Class: ModuleScript
-- bytes: 15461

local v1 = ipairs
local color = Color3.new()

local function RobloxLerp(arg1, arg2) -- line: 6
    return function(arg3) -- line: 7
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)

        return arg1:Lerp(arg2, arg3)
    end
end

local _ = function(arg4, arg5, arg6) --[[ Lerp ]] -- line: 12
    return arg4 + arg6 * (arg5 - arg4)
end

local function SortByTime(arg7, arg8) -- line: 16
    return arg7.Time < arg8.Time
end

return (setmetatable({
    boolean = function(arg9, arg10) --[[ boolean ]] -- line: 21
        return function(arg11) -- line: 22
            -- upvalues:
            --  [1] arg9 (copy)
            --  [2] arg10 (copy)

            if arg11 < 0.5 then
                return arg9
            end

            return arg10
        end
    end,
    number = function(arg12, arg13) --[[ number ]] -- line: 31
        local v3 = arg13 - arg12

        return function(arg14) -- line: 33
            -- upvalues:
            --  [1] arg12 (copy)
            --  [2] v3 (copy)

            return arg12 + v3 * arg14
        end
    end,
    CFrame = RobloxLerp,
    Color3 = function(arg15, arg16) --[[ Color3 ]] -- line: 39
        -- upvalues:
        --  [1] color (copy)

        local R = arg15.R
        local G = arg15.G
        local B = arg15.B
        local v4 = R < 0.0404482362771076 and R / 12.92 or 0.87941546140213 * (R + 0.055) ^ 2.4
        local v5 = v4
        v4 = G < 0.0404482362771076 and G / 12.92 or 0.87941546140213 * (G + 0.055) ^ 2.4
        local v6 = v4
        v4 = B < 0.0404482362771076 and B / 12.92 or 0.87941546140213 * (B + 0.055) ^ 2.4
        local v7 = v4
        v4 = 0.2125862307855956 * v5 + 0.7151703037034108 * v6 + 0.0722004986433362 * v7
        local v8 = 3.6590806972265884 * v5 + 11.442689580057424 * v6 + 4.114991502426484 * v7
        local v9 = v4 > 0.008856451679035631 and 116 * v4 ^ 0.3333333333333333 - 16 or 903.296296296296 * v4
        local v10, v11, v12

        if v8 > 1E-15 then
            v10 = v9
            v11 = v9 * (0.9257063972951867 * v5 - 0.8333736323779866 * v6 - 0.09209820666085898 * v7) / v8
            v12 = v9 * (9 * v4 / v8 - 0.46832)
        else
            v10 = v9
            v11 = -0.19783 * v9
            v12 = -0.46832 * v9
        end

        local R_1 = arg16.R
        local G_1 = arg16.G
        local B_1 = arg16.B
        local v13 = R_1 < 0.0404482362771076 and R_1 / 12.92 or 0.87941546140213 * (R_1 + 0.055) ^ 2.4
        local v14 = v13
        v13 = G_1 < 0.0404482362771076 and G_1 / 12.92 or 0.87941546140213 * (G_1 + 0.055) ^ 2.4
        local v15 = v13
        v13 = B_1 < 0.0404482362771076 and B_1 / 12.92 or 0.87941546140213 * (B_1 + 0.055) ^ 2.4
        local v16 = v13
        v9 = 0.2125862307855956 * v14 + 0.7151703037034108 * v15 + 0.0722004986433362 * v16
        local v17 = 3.6590806972265884 * v14 + 11.442689580057424 * v15 + 4.114991502426484 * v16
        v4 = v9 > 0.008856451679035631 and 116 * v9 ^ 0.3333333333333333 - 16 or 903.296296296296 * v9
        local v18, v19, v20

        if v17 > 1E-15 then
            v18 = v4
            v19 = v4 * (0.9257063972951867 * v14 - 0.8333736323779866 * v15 - 0.09209820666085898 * v16) / v17
            v20 = v4 * (9 * v9 / v17 - 0.46832)
        else
            v18 = v4
            v19 = -0.19783 * v4
            v20 = -0.46832 * v4
        end

        return function(arg17) -- line: 74
            -- upvalues:
            --  [1] v10 (ref)
            --  [2] v18 (ref)
            --  [3] color (ref)
            --  [4] v11 (ref)
            --  [5] v19 (ref)
            --  [6] v12 (ref)
            --  [7] v20 (ref)

            local v21 = (1 - arg17) * v10 + arg17 * v18

            if v21 < 0.0197955 then
                return color
            end

            local v22 = ((1 - arg17) * v11 + arg17 * v19) / v21 + 0.19783
            local v23 = ((1 - arg17) * v12 + arg17 * v20) / v21 + 0.46832
            local v24 = (v21 + 16) / 116
            local v26 = v24 > 0.20689655172413793 and v24 * v24 * v24 or 0.12841854934601665 * v24 - 0.01771290335807126
            local v27 = v26 * v22 / v23
            local v28 = v26 * ((3 - 0.75 * v22) / v23 - 5)
            v23 = 7.2914074 * v27 - 1.537208 * v26 - 0.4986286 * v28
            v22 = -2.180094 * v27 + 1.8757561 * v26 + 0.0415175 * v28
            local v29 = 0.1253477 * v27 - 0.2040211 * v26 + 1.0569959 * v28

            if v23 < 0 and (v22 > v23 and v23 < v29) then
                v22 -= v23
                v29 -= v23
                v23 = 0
            elseif v22 < 0 and v22 < v29 then
                v23 -= v22
                v29 -= v22
                v22 = 0
            elseif v29 < 0 then
                v23 -= v29
                v22 -= v29
                v29 = 0
            end

            local v30 = v23 < 0.0031306684425 and 12.92 * v23 or 1.055 * v23 ^ 0.4166666666666667 - 0.055
            v23 = v30
            v30 = v22 < 0.0031306684425 and 12.92 * v22 or 1.055 * v22 ^ 0.4166666666666667 - 0.055
            v22 = v30
            v30 = v29 < 0.0031306684425 and 12.92 * v29 or 1.055 * v29 ^ 0.4166666666666667 - 0.055
            v29 = v30
            local v31 = if not (v23 > 1) then if not (v23 < 0) then v23 else 0 else 1
            local v32 = if not (v22 > 1) then if not (v22 < 0) then v22 else 0 else 1
            local v33 = if not (v29 > 1) then if not (v29 < 0) then v29 else 0 else 1

            return Color3.new(v31, v32, v33)
        end
    end,
    NumberRange = function(arg18, arg19) --[[ NumberRange ]] -- line: 112
        local Min = arg18.Min
        local Max = arg18.Max
        local v34 = arg19.Min - Min
        local v35 = arg19.Max - Max

        return function(arg20) -- line: 116
            -- upvalues:
            --  [1] Min (copy)
            --  [2] v34 (copy)
            --  [3] Max (copy)
            --  [4] v35 (copy)

            return NumberRange.new(Min + arg20 * v34, Max + arg20 * v35)
        end
    end,
    NumberSequenceKeypoint = function(arg21, arg22) --[[ NumberSequenceKeypoint ]] -- line: 121
        local Time = arg21.Time
        local Value = arg21.Value
        local Envelope = arg21.Envelope
        local v36 = arg22.Time - Time
        local v37 = arg22.Value - Value
        local v38 = arg22.Envelope - Envelope

        return function(arg23) -- line: 125
            -- upvalues:
            --  [1] Time (copy)
            --  [2] v36 (copy)
            --  [3] Value (copy)
            --  [4] v37 (copy)
            --  [5] Envelope (copy)
            --  [6] v38 (copy)

            return NumberSequenceKeypoint.new(
                Time + arg23 * v36,
                Value + arg23 * v37,
                Envelope + arg23 * v38
            )
        end
    end,
    PhysicalProperties = function(arg24, arg25) --[[ PhysicalProperties ]] -- line: 130
        local Density = arg24.Density
        local Elasticity = arg24.Elasticity
        local ElasticityWeight = arg24.ElasticityWeight
        local Friction = arg24.Friction
        local FrictionWeight = arg24.FrictionWeight
        local v39 = arg25.Density - Density
        local v40 = arg25.Elasticity - Elasticity
        local v41 = arg25.ElasticityWeight - ElasticityWeight
        local v42 = arg25.Friction - Friction
        local v43 = arg25.FrictionWeight - FrictionWeight

        return function(arg26) -- line: 141
            -- upvalues:
            --  [1] Density (copy)
            --  [2] v39 (copy)
            --  [3] Elasticity (copy)
            --  [4] v40 (copy)
            --  [5] ElasticityWeight (copy)
            --  [6] v41 (copy)
            --  [7] Friction (copy)
            --  [8] v42 (copy)
            --  [9] FrictionWeight (copy)
            --  [10] v43 (copy)

            return PhysicalProperties.new(
                Density + arg26 * v39,
                Elasticity + arg26 * v40,
                ElasticityWeight + arg26 * v41,
                Friction + arg26 * v42,
                FrictionWeight + arg26 * v43
            )
        end
    end,
    Ray = function(arg27, arg28) --[[ Ray ]] -- line: 150
        local Origin = arg27.Origin
        local Direction = arg27.Direction
        local Origin_1 = arg28.Origin
        local Direction_1 = arg28.Direction
        local X = Origin.X
        local Y = Origin.Y
        local Z = Origin.Z
        local X_1 = Direction.X
        local Y_1 = Direction.Y
        local Z_1 = Direction.Z
        local v44 = Origin_1.X - X
        local v45 = Origin_1.Y - Y
        local v46 = Origin_1.Z - Z
        local v47 = Direction_1.X - X_1
        local v48 = Direction_1.Y - Y_1
        local v49 = Direction_1.Z - Z_1

        return function(arg29) -- line: 155
            -- upvalues:
            --  [1] X (copy)
            --  [2] v44 (copy)
            --  [3] Y (copy)
            --  [4] v45 (copy)
            --  [5] Z (copy)
            --  [6] v46 (copy)
            --  [7] X_1 (copy)
            --  [8] v47 (copy)
            --  [9] Y_1 (copy)
            --  [10] v48 (copy)
            --  [11] Z_1 (copy)
            --  [12] v49 (copy)

            return Ray.new(
                Vector3.new(X + arg29 * v44, Y + arg29 * v45, Z + arg29 * v46),
                (Vector3.new(X_1 + arg29 * v47, Y_1 + arg29 * v48, Z_1 + arg29 * v49))
            )
        end
    end,
    UDim = function(arg30, arg31) --[[ UDim ]] -- line: 163
        local Scale = arg30.Scale
        local Offset = arg30.Offset
        local v50 = arg31.Scale - Scale
        local v51 = arg31.Offset - Offset

        return function(arg32) -- line: 167
            -- upvalues:
            --  [1] Scale (copy)
            --  [2] v50 (copy)
            --  [3] Offset (copy)
            --  [4] v51 (copy)

            return UDim.new(Scale + arg32 * v50, Offset + arg32 * v51)
        end
    end,
    UDim2 = RobloxLerp,
    Vector2 = RobloxLerp,
    Vector3 = RobloxLerp,
    Rect = function(arg33, arg34) --[[ Rect ]] -- line: 175
        return function(arg35) -- line: 176
            -- upvalues:
            --  [1] arg33 (copy)
            --  [2] arg34 (copy)

            return Rect.new(
                arg33.Min.X + arg35 * (arg34.Min.X - arg33.Min.X),
                arg33.Min.Y + arg35 * (arg34.Min.Y - arg33.Min.Y),
                arg33.Max.X + arg35 * (arg34.Max.X - arg33.Max.X),
                arg33.Max.Y + arg35 * (arg34.Max.Y - arg33.Max.Y)
            )
        end
    end,
    Region3 = function(arg36, arg37) --[[ Region3 ]] -- line: 184
        return function(arg38) -- line: 185
            -- upvalues:
            --  [1] arg36 (copy)
            --  [2] arg37 (copy)

            local v52 = arg36.CFrame * (-arg36.Size / 2)
            local v53 = v52 + arg38 * (arg37.CFrame * (-arg37.Size / 2) - v52)
            local v54 = arg36.CFrame * (arg36.Size / 2)
            local v55 = v54 + arg38 * (arg37.CFrame * (arg37.Size / 2) - v54)
            local X_2 = v53.X
            local X_3 = v55.X
            local Y_2 = v53.Y
            local Y_3 = v55.Y
            local Z_2 = v53.Z
            local Z_3 = v55.Z
            local v56 = X_2 < X_3 and X_2 or X_3
            local v57 = Y_2 < Y_3 and Y_2 or Y_3
            local v58 = Z_3 > Z_2 and Z_2 or Z_3
            local New_1 = Region3.new
            local vec3_1 = Vector3.new(v56, v57, v58)
            v57 = X_2 > X_3 and X_2 or X_3
            v58 = Y_2 > Y_3 and Y_2 or Y_3
            local v59 = Z_3 < Z_2 and Z_2 or Z_3

            return New_1(vec3_1, (Vector3.new(v57, v58, v59)))
        end
    end,
    NumberSequence = function(arg39, arg40) --[[ NumberSequence ]] -- line: 203
        -- upvalues:
        --  [1] v1 (copy)
        --  [2] SortByTime (copy)

        return function(arg41) -- line: 204
            -- upvalues:
            --  [1] v1 (ref)
            --  [2] arg39 (copy)
            --  [3] arg40 (copy)
            --  [4] SortByTime (ref)

            local t_1 = {}
            local t_2 = {}
            local v60 = 0
            local v61, v63, v64

            for _, val in v1(arg39.Keypoints) do
                v61 = nil
                local v62 = nil

                for _, val_1 in v1(arg40.Keypoints) do
                    if val_1.Time == val.Time then
                        v61 = val_1
                        v62 = val_1
                        break
                    end

                    if val_1.Time < val.Time and (v62 == nil or val_1.Time > v62.Time) then
                        v62 = val_1
                    else
                        v61 = if not (val_1.Time > val.Time) then v61 else if v61 == nil then val_1 else if not (val_1.Time < v61.Time) then v61 else val_1
                    end
                end

                if v61 == v62 then
                    v63 = v61.Value
                    v64 = v61.Envelope
                else
                    local v65 = (val.Time - v62.Time) / (v61.Time - v62.Time)
                    v63 = (v61.Value - v62.Value) * v65 + v62.Value
                    v64 = (v61.Envelope - v62.Envelope) * v65 + v62.Envelope
                end

                v64 = NumberSequenceKeypoint.new(
                    val.Time,
                    (v63 - val.Value) * arg41 + val.Value,
                    (v64 - val.Envelope) * arg41 + val.Envelope
                )
                v60 += 1
                t_1[v60] = v64
                t_2[val.Time] = true
            end

            local v67, v68

            for _, val_2 in v1(arg40.Keypoints) do
                if not t_2[val_2.Time] then
                    v61 = nil
                    local v66 = nil

                    for _, val_3 in v1(arg39.Keypoints) do
                        if val_3.Time == val_2.Time then
                            v61 = val_3
                            v66 = val_3
                            break
                        end

                        if val_3.Time < val_2.Time and (v66 == nil or val_3.Time > v66.Time) then
                            v66 = val_3
                        else
                            v61 = if not (val_3.Time > val_2.Time) then v61 else if v61 == nil then val_3 else if not (val_3.Time < v61.Time) then v61 else val_3
                        end
                    end

                    if v61 == v66 then
                        v67 = v61.Value
                        v68 = v61.Envelope
                    else
                        local v69 = (val_2.Time - v66.Time) / (v61.Time - v66.Time)
                        v67 = (v61.Value - v66.Value) * v69 + v66.Value
                        v68 = (v61.Envelope - v66.Envelope) * v69 + v66.Envelope
                    end

                    v68 = NumberSequenceKeypoint.new(
                        val_2.Time,
                        (val_2.Value - v67) * arg41 + v67,
                        (val_2.Envelope - v68) * arg41 + v68
                    )
                    v60 += 1
                    t_1[v60] = v68
                end
            end

            table.sort(t_1, SortByTime)

            return NumberSequence.new(t_1)
        end
    end
}, {
    __index = function(_, arg43) --[[ __index ]] -- line: 279
        error("No lerp function is defined for type " .. tostring(arg43) .. ".", 4)
    end,
    __newindex = function(_, arg45) --[[ __newindex ]] -- line: 283
        error("No lerp function is defined for type " .. tostring(arg45) .. ".", 4)
    end
}))
