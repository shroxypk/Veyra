-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.RotatedRegion3.GJK
-- Class: ModuleScript
-- bytes: 2778

local t = {}
t.__index = t

local _ = function(arg1, arg2, arg3) --[[ tripleProduct ]] -- line: 11
    return arg2 * arg3:Dot(arg1) - arg1 * arg3:Dot(arg2)
end

local function containsOrigin(_, arg5, arg6) -- line: 15
    local v2 = arg5[#arg5]
    local v3 = -v2

    if #arg5 == 4 then
        local v4 = arg5[3] - v2
        local v5 = arg5[2] - v2
        local v6 = arg5[1] - v2
        local v7 = v4:Cross(v5)
        local v8 = v5:Cross(v6)
        local v9 = v6:Cross(v4)
        local v10 = v7:Dot(v6) > 0 and -v7 or v7
        local v11 = v10
        v10 = v8:Dot(v4) > 0 and -v8 or v8
        local v12 = v10
        v10 = v9:Dot(v5) > 0 and -v9 or v9
        local v13 = v10

        if v11:Dot(v3) > 0 then
            table.remove(arg5, 1)
            arg6 = v11
        elseif v12:Dot(v3) > 0 then
            table.remove(arg5, 2)
            arg6 = v12
        elseif v13:Dot(v3) > 0 then
            table.remove(arg5, 3)
            arg6 = v13
        else
            return true
        end
    elseif #arg5 == 3 then
        local v14 = arg5[2] - v2
        local v15 = arg5[1] - v2
        local v16 = v14:Cross(v15)
        local Unit = (v14 * v14:Dot(v15) - v15 * v14:Dot(v14)).Unit
        local Unit_1 = (v15 * v15:Dot(v14) - v14 * v15:Dot(v15)).Unit

        if Unit:Dot(v3) > 0 then
            table.remove(arg5, 1)
            arg6 = Unit
        elseif Unit_1:Dot(v3) > 0 then
            table.remove(arg5, 2)
            arg6 = Unit_1
        else
            if not (if v2 - v2 ~= Vector3.new(0, 0, 0) then false else true) then
                return true
            end

            arg6 = v16:Dot(v3) > 0 and v16 or -v16
        end
    else
        local v20 = arg5[1] - v2
        arg6 = (v3 * v20:Dot(v20) - v20 * v20:Dot(v3)).Unit
    end

    return false, arg6
end

function t.new(
    arg7,
    arg8,
    arg9,
    arg10,
    arg11,
    arg12
) -- line: 74
    -- upvalues:
    --  [1] t (copy)

    local t_1 = setmetatable({}, t)
    t_1.SetA = arg7
    t_1.SetB = arg8
    t_1.CentroidA = arg9
    t_1.CentroidB = arg10
    t_1.SupportA = arg11
    t_1.SupportB = arg12

    return t_1
end

function t.IsColliding(arg13) -- line: 89
    -- upvalues:
    --  [1] containsOrigin (copy)

    local v22 = (arg13.CentroidA - arg13.CentroidB).Unit
    local _ = {}
    local t_3 = { arg13.SupportA(arg13.SetA, v22) - arg13.SupportB(arg13.SetB, -v22) }
    v22 = -v22

    for _ = 1, 20 do
        table.insert(t_3, arg13.SupportA(arg13.SetA, v22) - arg13.SupportB(arg13.SetB, -v22))

        if t_3[#t_3]:Dot(v22) <= 0 then
            return false
        end

        local v25, v26 = containsOrigin(arg13, t_3, v22)

        if v25 then
            return true
        end

        v22 = v26
    end

    return false
end

return t
