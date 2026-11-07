-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Types.UserInput
-- Class: ModuleScript
-- bytes: 940

local Util_m = require(script.Parent.Parent.Shared.Util)
local v1 = Enum.UserInputType:GetEnumItems()

for _, val in pairs(Enum.KeyCode:GetEnumItems()) do
    v1[#v1 + 1] = val
end

local t = {
    Transform = function(arg1) --[[ Transform ]] -- line: 10
        -- upvalues:
        --  [1] Util_m (copy)
        --  [2] v1 (copy)

        return Util_m.MakeFuzzyFinder(v1)(arg1)
    end,
    Validate = function(arg2) --[[ Validate ]] -- line: 16
        return #arg2 > 0
    end,
    Autocomplete = function(arg3) --[[ Autocomplete ]] -- line: 20
        -- upvalues:
        --  [1] Util_m (copy)

        return Util_m.GetNames(arg3)
    end,
    Parse = function(arg4) --[[ Parse ]] -- line: 24
        return arg4[1]
    end
}

return function(arg5) -- line: 29
    -- upvalues:
    --  [1] t (copy)
    --  [2] Util_m (copy)

    arg5:RegisterType("userInput", t)
    arg5:RegisterType("userInputs", Util_m.MakeListableType(t))
end
