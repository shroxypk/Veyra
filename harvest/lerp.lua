-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.mod.lerp
-- Class: ModuleScript
-- bytes: 6293

local ColorOklab_m = require("./color/Oklab")
local t = {
    number = function(n1: number, n2: number, n3: number) --[[ number ]] -- line: 7
        return n1 + (n2 - n1) * n3
    end,
    Vector3 = function(vec1: Vector3, vec2: Vector3, n4: number) --[[ Vector3 ]] -- line: 11
        return vec1:Lerp(vec2, n4)
    end,
    Vector2 = function(u1: Vector2, u2: Vector2, n5: number) --[[ Vector2 ]] -- line: 15
        return u1:Lerp(u2, n5)
    end,
    CFrame = function(u3: CFrame, u4: CFrame, n6: number) --[[ CFrame ]] -- line: 19
        return u3:Lerp(u4, n6)
    end,
    UDim2 = function(u5: UDim2, u6: UDim2, n7: number) --[[ UDim2 ]] -- line: 23
        return u5:Lerp(u6, n7)
    end
}

function t.UDim(u7: UDim, u8: UDim, n8: number) -- line: 27
    -- upvalues:
    --  [1] t (copy)

    return UDim.new(t.number(u7.Scale, u8.Scale, n8), t.number(u7.Offset, u8.Offset, n8))
end

function t.NumberRange(u9: NumberRange, u10: NumberRange, n9: number) -- line: 35
    -- upvalues:
    --  [1] t (copy)

    return NumberRange.new(t.number(u9.Min, u10.Min, n9), t.number(u9.Max, u10.Max, n9))
end

function t.Color3(u11: Color3, u12: Color3, n10: number) -- line: 43
    -- upvalues:
    --  [1] ColorOklab_m (copy)

    return ColorOklab_m.toSRGB(ColorOklab_m.fromSRGB(u11):Lerp(ColorOklab_m.fromSRGB(u12), n10))
end

function t.PhysicalProperties(u13: userdata, u14: userdata, n11: number) -- line: 50
    -- upvalues:
    --  [1] t (copy)

    return PhysicalProperties.new(
        t.number(u13.Density, u14.Density, n11),
        t.number(u13.Friction, u14.Friction, n11),
        t.number(u13.Elasticity, u14.Elasticity, n11),
        t.number(u13.FrictionWeight, u14.FrictionWeight, n11),
        t.number(u13.ElasticityWeight, u14.ElasticityWeight, n11)
    )
end

function t.Rect(u15: Rect, u16: Rect, n12: number) -- line: 60
    return Rect.new(u15.Min:Lerp(u16.Min, n12), u15.Max:Lerp(u16.Max, n12))
end

function t.NumberSequence(u17: userdata, u18: userdata, n13: number) -- line: 65
    local t_1 = {}
    local t_2 = {}
    local v10 = 0
    local v11, v12, v13, v14

    for _, val in u17.Keypoints do
        v11 = nil
        v12 = nil

        for _, val_1 in u18.Keypoints do
            if val_1.Time == val.Time then
                v11 = val_1
                v12 = val_1
                break
            end

            if val_1.Time < val.Time and (v12 == nil or val_1.Time > v12.Time) then
                v12 = val_1
            else
                v11 = if not (val_1.Time > val.Time) then v11 else if v11 == nil then val_1 else if not (val_1.Time < v11.Time) then v11 else val_1
            end
        end

        if v11 == v12 then
            v13 = v11.Value
            v14 = v11.Envelope
        else
            local v15 = (val.Time - v12.Time) / (v11.Time - v12.Time)
            v13 = (v11.Value - v12.Value) * v15 + v12.Value
            v14 = (v11.Envelope - v12.Envelope) * v15 + v12.Envelope
        end

        v10 += 1
        t_1[v10] = NumberSequenceKeypoint.new(
            val.Time,
            (v13 - val.Value) * n13 + val.Value,
            (v14 - val.Envelope) * n13 + val.Envelope
        )
        t_2[val.Time] = true
    end

    local v16, v17

    for _, val_2 in u18.Keypoints do
        if not t_2[val_2.Time] then
            v11 = nil
            v12 = nil

            for _, val_3 in u17.Keypoints do
                if val_3.Time == val_2.Time then
                    v11 = val_3
                    v12 = val_3
                    break
                end

                if val_3.Time < val_2.Time and (v12 == nil or val_3.Time > v12.Time) then
                    v12 = val_3
                else
                    v11 = if not (val_3.Time > val_2.Time) then v11 else if v11 == nil then val_3 else if not (val_3.Time < v11.Time) then v11 else val_3
                end
            end

            if v11 == v12 then
                v16 = v11.Value
                v17 = v11.Envelope
            else
                local v18 = (val_2.Time - v12.Time) / (v11.Time - v12.Time)
                v16 = (v11.Value - v12.Value) * v18 + v12.Value
                v17 = (v11.Envelope - v12.Envelope) * v18 + v12.Envelope
            end

            v10 += 1
            t_1[v10] = NumberSequenceKeypoint.new(
                val_2.Time,
                (val_2.Value - v16) * n13 + v16,
                (val_2.Envelope - v17) * n13 + v17
            )
        end
    end

    table.sort(t_1, function(arg1, arg2) -- line: 136
        return arg1.Time < arg2.Time
    end)
    local v20

    if #t_1 > 20 then
        v20 = {}
        v10 = (#t_1 - 1) / 19

        for index = 0, 19 do
            table.insert(v20, t_1[math.floor(index * v10 + 1)])
        end

        if v20[#v20].Time < t_1[#t_1].Time then
            v20[#v20] = t_1[#t_1]
        end
    else
        v20 = t_1
    end

    return NumberSequence.new(v20)
end

local function getColorAtTime(u19: userdata, n14: number) -- line: 161
    local Keypoints = u19.Keypoints

    if n14 <= Keypoints[1].Time then
        return Keypoints[1].Value
    end

    if n14 >= Keypoints[#Keypoints].Time then
        return Keypoints[#Keypoints].Value
    end

    local v21 = nil
    local v22 = nil

    for index_1 = 1, #Keypoints do
        local v23 = Keypoints[index_1]

        if v23.Time == n14 then
            return v23.Value
        end

        if n14 > v23.Time then
            v21 = v23
        elseif n14 < v23.Time then
            v22 = v23
            break
        end
    end

    return v21.Value:Lerp(v22.Value, (n14 - v21.Time) / (v22.Time - v21.Time))
end

function t.ColorSequence(u20: userdata, u21: userdata, n15: number) -- line: 192
    -- upvalues:
    --  [1] getColorAtTime (copy)
    --  [2] ColorOklab_m (copy)

    local t_3 = {}

    for _, val_4 in ipairs(u21.Keypoints) do
        local v24 = getColorAtTime(u20, val_4.Time)
        table.insert(
            t_3,
            ColorSequenceKeypoint.new(
                val_4.Time,
                (ColorOklab_m.toSRGB(ColorOklab_m.fromSRGB(v24:Lerp(val_4.Value, n15))))
            )
        )
    end

    return ColorSequence.new(t_3)
end

function t.Other(arg3: any, arg4: any, n16: number) -- line: 206
    return n16 < 0.5 and arg3 or arg4
end

return t
