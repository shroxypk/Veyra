-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.RotatedRegion3.Vertices
-- Class: ModuleScript
-- bytes: 6557

local t = {
    Vector3.new(1, 1, 1),
    Vector3.new(-1, 1, 1),
    Vector3.new(-1, 1, -1),
    Vector3.new(1, 1, -1),
    Vector3.new(1, -1, 1),
    Vector3.new(-1, -1, 1),
    Vector3.new(-1, -1, -1),
    Vector3.new(1, -1, -1)
}
local t_1 = { 1, 2, 3, 4, 5, 6, 7, 8 }
local t_2 = { 1, 2, 5, 6, 7, 8 }
local t_3 = { 4, 5, 6, 7, 8 }

local _ = function(arg1) --[[ fromIndexArray ]] -- line: 32
    -- upvalues:
    --  [1] t (copy)

    local t_4 = {}

    for index = 1, #arg1 do
        t_4[index] = t[arg1[index]]
    end

    return t_4
end

local function cylinder(arg2) -- line: 40
    local t_5 = {}
    local v1 = 6.283185307179586 / arg2

    for index_1 = 1, arg2 do
        local v2 = CFrame.fromAxisAngle(Vector3.new(1, 0, 0), index_1 * v1) * Vector3.new(0, 1, 0)
        t_5[index_1] = Vector3.new(1, 0, 0) + v2
        t_5[arg2 + index_1] = Vector3.new(-1, 0, 0) + v2
    end

    return t_5
end

local function icoSphere(arg3) -- line: 51
    local t_6 = {
        Vector3.new(-1, 1.618034, 0),
        Vector3.new(1, 1.618034, 0),
        Vector3.new(-1, -1.618034, 0),
        Vector3.new(1, -1.618034, 0),
        Vector3.new(0, -1, 1.618034),
        Vector3.new(0, 1, 1.618034),
        Vector3.new(0, -1, -1.618034),
        Vector3.new(0, 1, -1.618034),
        Vector3.new(1.618034, 0, -1),
        Vector3.new(1.618034, 0, 1),
        Vector3.new(-1.618034, 0, -1),
        Vector3.new(-1.618034, 0, 1)
    }
    local t_7 = {
        1,
        12,
        6,
        1,
        6,
        2,
        1,
        2,
        8,
        1,
        8,
        11,
        1,
        11,
        12,
        2,
        6,
        10,
        6,
        12,
        5,
        12,
        11,
        3,
        11,
        8,
        7,
        8,
        2,
        9,
        4,
        10,
        5,
        4,
        5,
        3,
        4,
        3,
        7,
        4,
        7,
        9,
        4,
        9,
        10,
        5,
        10,
        6,
        3,
        5,
        12,
        7,
        3,
        11,
        9,
        7,
        8,
        10,
        9,
        2
    }
    local t_8 = {}

    local _ = function(arg4, arg5) --[[ split ]] -- line: 97
        -- upvalues:
        --  [1] t_8 (copy)
        --  [2] t_6 (copy)

        local v3 = arg4 < arg5 and arg4 .. "," .. arg5 or arg5 .. "," .. arg4

        if not t_8[v3] then
            t_6[#t_6 + 1] = (t_6[arg4] + t_6[arg5]) / 2
            t_8[v3] = #t_6
        end

        return t_8[v3]
    end

    for _ = 1, arg3 do
        for index_3 = #t_7, 1, -3 do
            local v4 = t_7[index_3 - 2]
            local v5 = t_7[index_3 - 1]
            local v6 = t_7[index_3]
            local v7 = v4 < v5 and v4 .. "," .. v5 or v5 .. "," .. v4

            if not t_8[v7] then
                t_6[#t_6 + 1] = (t_6[v4] + t_6[v5]) / 2
                t_8[v7] = #t_6
            end

            local v8 = t_8[v7]
            local v9 = v5 < v6 and v5 .. "," .. v6 or v6 .. "," .. v5

            if not t_8[v9] then
                t_6[#t_6 + 1] = (t_6[v5] + t_6[v6]) / 2
                t_8[v9] = #t_6
            end

            v7 = t_8[v9]
            local v10 = v4 > v6 and v6 .. "," .. v4 or v4 .. "," .. v6

            if not t_8[v10] then
                t_6[#t_6 + 1] = (t_6[v6] + t_6[v4]) / 2
                t_8[v10] = #t_6
            end

            v9 = t_8[v10]
            t_7[#t_7 + 1] = v4
            t_7[#t_7 + 1] = v8
            t_7[#t_7 + 1] = v9
            t_7[#t_7 + 1] = v5
            t_7[#t_7 + 1] = v7
            t_7[#t_7 + 1] = v8
            t_7[#t_7 + 1] = v6
            t_7[#t_7 + 1] = v9
            t_7[#t_7 + 1] = v7
            t_7[#t_7 + 1] = v8
            t_7[#t_7 + 1] = v7
            t_7[#t_7 + 1] = v9
            table.remove(t_7, index_3)
            table.remove(t_7, index_3 - 1)
            table.remove(t_7, index_3 - 2)
        end
    end

    for index_4 = 1, #t_6 do
        t_6[index_4] = t_6[index_4].Unit
    end

    return t_6
end

local function vertShape(arg6, arg7, arg8) -- line: 147
    local t_9 = {}

    for index_5 = 1, #arg8 do
        t_9[index_5] = arg6:PointToWorldSpace(arg8[index_5] * arg7)
    end

    return t_9
end

local function getCentroidFromSet(arg9) -- line: 155
    local v12 = arg9[1]

    for _ = 2, #arg9 do
        v12 += arg9[2]
    end

    return v12 / #arg9
end

local function classify(arg10) -- line: 163
    if arg10.ClassName == "Part" then
        if arg10.Shape == Enum.PartType.Block then
            return "Block"
        end

        if arg10.Shape == Enum.PartType.Cylinder then
            return "Cylinder"
        end

        if arg10.Shape == Enum.PartType.Ball then
            return "Ball"
        end

        if arg10.Shape == Enum.PartType.Wedge then
            return "Wedge"
        end
    else
        if arg10.ClassName == "WedgePart" then
            return "Wedge"
        end

        if arg10.ClassName == "CornerWedgePart" then
            return "CornerWedge"
        end

        if arg10:IsA("BasePart") then
            return "Block"
        end
    end
end

local t_10 = {}

for index_7 = 1, #t_1 do
    t_10[index_7] = t[t_1[index_7]]
end

local t_11 = {}

for index_8 = 1, #t_2 do
    t_11[index_8] = t[t_2[index_8]]
end

local t_12 = {}

for index_9 = 1, #t_3 do
    t_12[index_9] = t[t_3[index_9]]
end

local v13 = cylinder(20)
local t_13 = {
    Block = function(arg11, arg12) --[[ Block ]] -- line: 192
        -- upvalues:
        --  [1] vertShape (copy)
        --  [2] t_10 (copy)

        return (vertShape(arg11, arg12, t_10))
    end,
    Wedge = function(arg13, arg14) --[[ Wedge ]] -- line: 193
        -- upvalues:
        --  [1] vertShape (copy)
        --  [2] t_11 (copy)

        return (vertShape(arg13, arg14, t_11))
    end,
    CornerWedge = function(arg15, arg16) --[[ CornerWedge ]] -- line: 194
        -- upvalues:
        --  [1] vertShape (copy)
        --  [2] t_12 (copy)

        return (vertShape(arg15, arg16, t_12))
    end,
    Cylinder = function(arg17, arg18) --[[ Cylinder ]] -- line: 195
        -- upvalues:
        --  [1] vertShape (copy)
        --  [2] v13 (copy)

        return (vertShape(arg17, arg18, v13))
    end,
    Ball = nil,
    GetCentroid = nil,
    Classify = nil
}
local v14 = icoSphere(2)

function t_13.Ball(arg19, arg20) -- line: 196
    -- upvalues:
    --  [1] vertShape (copy)
    --  [2] v14 (copy)

    return (vertShape(arg19, arg20, v14))
end

t_13.GetCentroid = getCentroidFromSet
t_13.Classify = classify

return t_13
