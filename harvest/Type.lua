-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Types.Type
-- Class: ModuleScript
-- bytes: 774

local Util_m = require(script.Parent.Parent.Shared.Util)

return function(arg1) -- line: 3
    -- upvalues:
    --  [1] Util_m (copy)

    local t = { Transform = nil, Validate = nil, Autocomplete = nil, Parse = nil }

    function t.Transform(arg2) -- line: 5
        -- upvalues:
        --  [1] Util_m (ref)
        --  [2] arg1 (copy)

        return Util_m.MakeFuzzyFinder(arg1:GetTypeNames())(arg2)
    end

    function t.Validate(arg3) -- line: 11
        return #arg3 > 0, "No type with that name could be found."
    end

    function t.Autocomplete(arg4) -- line: 15
        return arg4
    end

    function t.Parse(arg5) -- line: 19
        return arg5[1]
    end

    arg1:RegisterType("type", t)
    arg1:RegisterType("types", Util_m.MakeListableType(t))
end
