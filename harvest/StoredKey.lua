-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Types.StoredKey
-- Class: ModuleScript
-- bytes: 1117

local Util_m = require(script.Parent.Parent.Shared.Util)
local t = { "^%a[%w_]*$", "^%$%a[%w_]*$", "^%.%a[%w_]*$", "^%$%.%a[%w_]*$" }

return function(arg1) -- line: 10
    -- upvalues:
    --  [1] t (copy)
    --  [2] Util_m (copy)

    local t_1 = { Autocomplete = nil, Validate = nil, Parse = nil }

    function t_1.Autocomplete(arg2) -- line: 12
        -- upvalues:
        --  [1] arg1 (copy)

        local MakeFuzzyFinder = arg1.Cmdr.Util.MakeFuzzyFinder

        return MakeFuzzyFinder(arg1.Cmdr.Util.DictionaryKeys(arg1:GetStore("vars_used") or {}))(
            arg2
        )
    end

    function t_1.Validate(arg3) -- line: 18
        -- upvalues:
        --  [1] t (ref)

        for _, val in ipairs(t) do
            if arg3:match(val) then
                return true
            end
        end

        return false, "Key names must start with an optional modifier: . $ or $. and must begin with a letter."
    end

    function t_1.Parse(arg4) -- line: 28
        return arg4
    end

    arg1:RegisterType("storedKey", t_1)
    arg1:RegisterType("storedKeys", Util_m.MakeListableType(t_1))
end
