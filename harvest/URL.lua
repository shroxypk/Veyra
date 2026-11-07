-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Types.URL
-- Class: ModuleScript
-- bytes: 559

local Util_m = require(script.Parent.Parent.Shared.Util)
local t = {
    Validate = function(arg1) --[[ Validate ]] -- line: 4
        if arg1:match("^https?://.+$") then
            return true
        end

        return false, "URLs must begin with http:// or https://"
    end,
    Parse = function(arg2) --[[ Parse ]] -- line: 12
        return arg2
    end
}

return function(arg3) -- line: 17
    -- upvalues:
    --  [1] t (copy)
    --  [2] Util_m (copy)

    arg3:RegisterType("url", t)
    arg3:RegisterType("urls", Util_m.MakeListableType(t))
end
