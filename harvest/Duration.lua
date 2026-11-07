-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Types.Duration
-- Class: ModuleScript
-- bytes: 2898

local Util_m = require(script.Parent.Parent.Shared.Util)
local t = {
    Years = 31556926,
    Months = 2629744,
    Weeks = 604800,
    Days = 86400,
    Hours = 3600,
    Minutes = 60,
    Seconds = 1
}
local t_1 = {}

for key, _ in pairs(t) do
    table.insert(t_1, key)
end

local v1 = Util_m.MakeFuzzyFinder(t_1)

local function stringToSecondDuration(arg1) -- line: 19
    -- upvalues:
    --  [1] v1 (copy)
    --  [2] t (copy)

    if arg1 == nil or arg1 == "" then
        return nil
    end

    local num = tonumber(arg1)

    if num and num == 0 then
        return 0, 0, true
    end

    local v2 = arg1:gsub("-?%d+%a+", ""):match("-?%d+")

    if v2 then
        return nil, tonumber(v2), true
    end

    v2 = nil
    local v3 = nil

    for key_1 in arg1:gmatch("-?%d+%a+") do
        local v4
        v3, v4 = key_1:match("(-?%d+)(%a+)")
        local v5 = v1(v4)

        if #v5 == 0 then
            return nil, (tonumber(v3))
        end

        if v2 == nil then
            v2 = 0
        end

        v2 += (if v4:lower() == "m" then 60 else t[v5[1]]) * tonumber(v3)
    end

    if v2 == nil then
        return nil
    end

    return v2, (tonumber(v3))
end

local function mapUnits(arg2, arg3, arg4, arg5) -- line: 58
    arg5 = arg5 or 1
    local t_2 = {}

    for key_2, val_1 in pairs(arg2) do
        if arg4 == 1 then
            t_2[key_2] = arg3 .. val_1:sub(arg5, #val_1 - 1)
        else
            t_2[key_2] = arg3 .. val_1:sub(arg5)
        end
    end

    return t_2
end

local t_3 = {
    Transform = function(arg6) --[[ Transform ]] -- line: 72
        -- upvalues:
        --  [1] stringToSecondDuration (copy)

        return arg6, stringToSecondDuration(arg6)
    end,
    Validate = function(_, arg8) --[[ Validate ]] -- line: 76
        return arg8 ~= nil
    end,
    Autocomplete = function(
        arg9,
        arg10,
        arg11,
        arg12,
        arg13
    ) --[[ Autocomplete ]] -- line: 80
        -- upvalues:
        --  [1] v1 (copy)
        --  [2] mapUnits (copy)

        local _ = {}
        local v11

        if arg12 or arg13 then
            v11 = if arg12 ~= true then arg13 else v1("") or arg13

            if arg12 == true then
                return (mapUnits(v11, arg9, arg11))
            end

            return (mapUnits(v11, arg9, arg9:match("^.*(%a+)$"):len() + 1))
        end

        local v12

        if arg10 ~= nil then
            v11 = arg9:match("^.*-?%d+(%a+)%s?$")
            v12 = mapUnits(v1(v11), arg9, arg11, #v11 + 1)
            table.sort(v12)
        end

        return v12
    end,
    Parse = function(_, arg15) --[[ Parse ]] -- line: 104
        return arg15
    end
}

return function(arg16) -- line: 109
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] Util_m (copy)

    arg16:RegisterType("duration", t_3)
    arg16:RegisterType("durations", Util_m.MakeListableType(t_3))
end
