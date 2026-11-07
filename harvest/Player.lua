-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Types.Player
-- Class: ModuleScript
-- bytes: 1125

local Util_m = require(script.Parent.Parent.Shared.Util)
local Players = game:GetService("Players")
local t = {
    Transform = function(arg1) --[[ Transform ]] -- line: 5
        -- upvalues:
        --  [1] Util_m (copy)
        --  [2] Players (copy)

        return Util_m.MakeFuzzyFinder(Players:GetPlayers())(arg1)
    end,
    Validate = function(arg2) --[[ Validate ]] -- line: 11
        return #arg2 > 0, "No player with that name could be found."
    end,
    Autocomplete = function(arg3) --[[ Autocomplete ]] -- line: 15
        -- upvalues:
        --  [1] Util_m (copy)

        return Util_m.GetNames(arg3)
    end,
    Parse = function(arg4) --[[ Parse ]] -- line: 19
        return arg4[1]
    end,
    Default = function(arg5) --[[ Default ]] -- line: 23
        return arg5.Name
    end,
    ArgumentOperatorAliases = { me = ".", all = "*", others = "**", random = "?" }
}

return function(arg6) -- line: 35
    -- upvalues:
    --  [1] t (copy)
    --  [2] Util_m (copy)

    arg6:RegisterType("player", t)
    arg6:RegisterType("players", Util_m.MakeListableType(t, { Prefixes = "% teamPlayers" }))
end
