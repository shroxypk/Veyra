-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.mod.attributes
-- Class: ModuleScript
-- bytes: 5730

local RunService = game:GetService("RunService")
local Logger_m = require("./logger")
local v1 = RunService:IsServer()
local t = {}
local t_1 = {}
local t_2 = {}
local v2 = 0
local t_3 = {}

function t_3.cache(u1: userdata) -- line: 34
    -- upvalues:
    --  [1] Logger_m (copy)
    --  [2] v2 (ref)
    --  [3] t (copy)

    local U = u1:GetAttribute("U")

    if U then
        Logger_m.warn(`{u1} is already cached (id={U})`)

        return
    end

    local v3 = u1:GetAttributes()

    if next(v3) == nil then
        return
    end

    v2 += 1
    local v4 = v2
    local t_4 = {}

    for key, val in v3 do
        if key ~= "U" then
            t_4[key] = val
            u1:SetAttribute(key, nil)
        end
    end

    t[v4] = t_4
    u1:SetAttribute("U", v4)
end

function t_3.restore(u2: userdata) -- line: 67
    -- upvalues:
    --  [1] t (copy)
    --  [2] Logger_m (copy)

    local U_1 = u2:GetAttribute("U")
    local v5 = t[U_1]

    if not v5 then
        Logger_m.warn(`{u2} with cache id '{U_1}' doesn't have any cached attributes`)

        return
    end

    for key_1, val_1 in v5 do
        u2:SetAttribute(key_1, val_1)
    end

    u2:SetAttribute("U", nil)
end

function t_3.get(
    u3: userdata,
    s1: string,
    arg1: any,
    b1: boolean?,
    f1: ((...any) -> ...any)?
) -- line: 84
    -- upvalues:
    --  [1] t (copy)
    --  [2] v1 (copy)

    local v6 = t[u3:GetAttribute("U")]
    local v7 = v6

    if v7 then
        v7 = v6[s1]
    end

    if v7 ~= nil then
        if f1 then
            return (f1(v7))
        end

        if v7 == nil then
            return arg1
        end

        return v7
    else
        v7 = u3:GetAttribute(s1)

        if f1 then
            v7 = f1(v7)
        elseif v7 == nil then
            v7 = arg1
        end

        if not b1 and v1 then
            u3:SetAttribute(s1, v7)
        end

        return v7
    end
end

function t_3.getRange(
    u4: userdata,
    s2: string,
    u5: NumberRange,
    u6: NumberRange?,
    b2: boolean?
) -- line: 109
    -- upvalues:
    --  [1] t_3 (copy)

    return t_3.get(
        u4,
        s2,
        u5,
        b2,
        function(arg2) -- line: 110
            -- upvalues:
            --  [1] u5 (copy)
            --  [2] u6 (copy)

            if typeof(arg2) ~= "NumberRange" then
                return u5
            end

            if u6 then
                return NumberRange.new(
                    math.clamp(arg2.Min, u6.Min, u6.Max),
                    (math.clamp(arg2.Max, u6.Min, u6.Max))
                )
            end

            return arg2
        end
    )
end

function t_3.getEnum(
    u7: userdata,
    s3: string,
    arg3: any,
    t1: table,
    b3: boolean?
) -- line: 127
    -- upvalues:
    --  [1] t_3 (copy)

    return t_3.get(
        u7,
        s3,
        arg3,
        b3,
        function(arg4) -- line: 128
            -- upvalues:
            --  [1] t1 (copy)
            --  [2] arg3 (copy)

            if arg4 ~= nil then
                if not table.find(t1, arg4) then
                    return arg3
                end

                return arg4
            else
                return arg3
            end
        end
    )
end

function t_3.set(u8: userdata, s4: string, arg5: any) -- line: 137
    -- upvalues:
    --  [1] t (copy)

    local v9 = t[u8:GetAttribute("U")]

    if v9 then
        v9[s4] = arg5

        return
    end

    u8:SetAttribute(s4, arg5)
end

function t_3.isCached(u9: userdata) -- line: 149
    return if u9:GetAttribute("U") == nil then false else true
end

function t_3.getState(u10: userdata, s5: string, arg6: any) -- line: 153
    -- upvalues:
    --  [1] t_2 (copy)

    local v11 = t_2[u10]
    local v12 = v11

    if v12 then
        v12 = v11[s5]
    end

    if v12 ~= nil then
        return v12
    end

    return arg6
end

function t_3.setState(u11: userdata, s6: string, arg7: any) -- line: 160
    -- upvalues:
    --  [1] t_2 (copy)

    local v13 = t_2[u11]

    if not v13 then
        v13 = {}
        t_2[u11] = v13
    end

    v13[s6] = arg7
end

function t_3.clearState(u12: userdata) -- line: 171
    -- upvalues:
    --  [1] t_2 (copy)

    t_2[u12] = nil
end

function t_3.trigger(u13: userdata, s7: string, arg8: any) -- line: 175
    -- upvalues:
    --  [1] t_1 (copy)

    local v14 = t_1[u13]
    local v15 = v14

    if v15 then
        v15 = v14[s7]
    end

    if not v15 then
        return
    end

    for _, val_2 in v15 do
        val_2(arg8)
    end
end

function t_3.hook(u14: userdata, s8: string, f2: (...any) -> ...any) -- line: 188
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] t_3 (copy)

    local v16 = t_1[u14]

    if not v16 then
        v16 = {}
        t_1[u14] = v16
    end

    local v17 = v16[s8]

    if not v17 then
        v17 = {}
        v16[s8] = v17
    end

    table.insert(v17, f2)
    local v18 = if not t_3.isCached(u14) then u14:GetAttributeChangedSignal(s8):Connect(function() -- line: 208
        -- upvalues:
        --  [1] u14 (copy)
        --  [2] s8 (copy)
        --  [3] f2 (copy)

        f2((u14:GetAttribute(s8)))
    end) else nil

    return function() -- line: 214
        -- upvalues:
        --  [1] v18 (ref)
        --  [2] v17 (ref)
        --  [3] f2 (copy)
        --  [4] v16 (ref)
        --  [5] s8 (copy)
        --  [6] t_1 (ref)
        --  [7] u14 (copy)

        if v18 then
            v18:Disconnect()
        end

        local v20 = table.find(v17, f2)

        if v20 then
            table.remove(v17, v20)
        end

        if #v17 == 0 then
            v16[s8] = nil
        end

        if next(v16) == nil then
            t_1[u14] = nil
        end
    end
end

return t_3
