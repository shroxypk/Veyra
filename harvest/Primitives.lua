-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Types.Primitives
-- Class: ModuleScript
-- bytes: 4520

local Util_m = require(script.Parent.Parent.Shared.Util)
local t = {
    Validate = function(arg1) --[[ Validate ]] -- line: 4
        return arg1 ~= nil
    end,
    Parse = function(arg2) --[[ Parse ]] -- line: 8
        return (tostring(arg2))
    end
}
local t_1 = {
    Transform = function(arg3) --[[ Transform ]] -- line: 14
        return (tonumber(arg3))
    end,
    Validate = function(arg4) --[[ Validate ]] -- line: 18
        return arg4 ~= nil
    end,
    Parse = function(arg5) --[[ Parse ]] -- line: 22
        return arg5
    end
}
local t_2 = {
    Transform = function(arg6) --[[ Transform ]] -- line: 28
        return (tonumber(arg6))
    end,
    Validate = function(arg7) --[[ Validate ]] -- line: 32
        return if arg7 ~= nil then if arg7 ~= math.floor(arg7) then false else true else false, "Only whole numbers are valid."
    end,
    Parse = function(arg8) --[[ Parse ]] -- line: 36
        return arg8
    end
}
local t_3 = {
    Transform = function(arg9) --[[ Transform ]] -- line: 42
        return (tonumber(arg9))
    end,
    Validate = function(arg10) --[[ Validate ]] -- line: 46
        return if arg10 ~= nil then if arg10 == math.floor(arg10) then arg10 > 0 else false else false, "Only positive whole numbers are valid."
    end,
    Parse = function(arg11) --[[ Parse ]] -- line: 50
        return arg11
    end
}
local t_4 = {
    Transform = function(arg12) --[[ Transform ]] -- line: 56
        return (tonumber(arg12))
    end,
    Validate = function(arg13) --[[ Validate ]] -- line: 60
        return if arg13 ~= nil then if arg13 == math.floor(arg13) then arg13 >= 0 else false else false, "Only non-negative whole numbers are valid."
    end,
    Parse = function(arg14) --[[ Parse ]] -- line: 64
        return arg14
    end
}
local t_5 = {
    Transform = function(arg15) --[[ Transform ]] -- line: 70
        return (tonumber(arg15))
    end,
    Validate = function(arg16) --[[ Validate ]] -- line: 74
        return if arg16 ~= nil then if arg16 == math.floor(arg16) then arg16 >= 0 and arg16 <= 255 else false else false, "Only bytes are valid."
    end,
    Parse = function(arg17) --[[ Parse ]] -- line: 78
        return arg17
    end
}
local t_6 = {
    Transform = function(arg18) --[[ Transform ]] -- line: 84
        return (tonumber(arg18))
    end,
    Validate = function(arg19) --[[ Validate ]] -- line: 88
        return if arg19 ~= nil then if arg19 == math.floor(arg19) then arg19 >= 0 and arg19 <= 9 else false else false, "Only digits are valid."
    end,
    Parse = function(arg20) --[[ Parse ]] -- line: 92
        return arg20
    end
}
local v8 = Util_m.MakeDictionary({ "true", "t", "yes", "y", "on", "enable", "enabled", "1", "+" })
local v9 = Util_m.MakeDictionary(
    { "false", "f", "no", "n", "off", "disable", "disabled", "0", "-" }
)
local t_8 = {
    Transform = function(arg21) --[[ Transform ]] -- line: 102
        return arg21:lower()
    end,
    Validate = function(arg22) --[[ Validate ]] -- line: 106
        -- upvalues:
        --  [1] v8 (copy)
        --  [2] v9 (copy)

        return v8[arg22] ~= nil or v9[arg22] ~= nil, "Please use true/yes/on or false/no/off."
    end,
    Parse = function(arg23) --[[ Parse ]] -- line: 110
        -- upvalues:
        --  [1] v8 (copy)
        --  [2] v9 (copy)

        return if not v8[arg23] then if not v9[arg23] then nil else false else true
    end
}

return function(arg24) -- line: 122
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_1 (copy)
    --  [3] t_2 (copy)
    --  [4] t_3 (copy)
    --  [5] t_4 (copy)
    --  [6] t_5 (copy)
    --  [7] t_6 (copy)
    --  [8] t_8 (ref)
    --  [9] Util_m (copy)

    arg24:RegisterType("string", t)
    arg24:RegisterType("number", t_1)
    arg24:RegisterType("integer", t_2)
    arg24:RegisterType("positiveInteger", t_3)
    arg24:RegisterType("nonNegativeInteger", t_4)
    arg24:RegisterType("byte", t_5)
    arg24:RegisterType("digit", t_6)
    arg24:RegisterType("boolean", t_8)
    arg24:RegisterType("strings", Util_m.MakeListableType(t))
    arg24:RegisterType("numbers", Util_m.MakeListableType(t_1))
    arg24:RegisterType("integers", Util_m.MakeListableType(t_2))
    arg24:RegisterType("positiveIntegers", Util_m.MakeListableType(t_3))
    arg24:RegisterType("nonNegativeIntegers", Util_m.MakeListableType(t_4))
    arg24:RegisterType("bytes", Util_m.MakeListableType(t_5))
    arg24:RegisterType("digits", Util_m.MakeListableType(t_6))
    arg24:RegisterType("booleans", Util_m.MakeListableType(t_8))
end
