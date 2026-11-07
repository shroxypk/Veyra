-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Types.Team
-- Class: ModuleScript
-- bytes: 1522

local Teams = game:GetService("Teams")
local Util_m = require(script.Parent.Parent.Shared.Util)
local t = {
    Transform = function(arg1) --[[ Transform ]] -- line: 5
        -- upvalues:
        --  [1] Util_m (copy)
        --  [2] Teams (copy)

        return Util_m.MakeFuzzyFinder(Teams:GetTeams())(arg1)
    end,
    Validate = function(arg2) --[[ Validate ]] -- line: 11
        return #arg2 > 0, "No team with that name could be found."
    end,
    Autocomplete = function(arg3) --[[ Autocomplete ]] -- line: 15
        -- upvalues:
        --  [1] Util_m (copy)

        return Util_m.GetNames(arg3)
    end,
    Parse = function(arg4) --[[ Parse ]] -- line: 19
        return arg4[1]
    end
}
local t_1 = {
    Listable = true,
    Transform = t.Transform,
    Validate = t.Validate,
    Autocomplete = t.Autocomplete,
    Parse = function(arg5) --[[ Parse ]] -- line: 30
        return arg5[1]:GetPlayers()
    end
}
local t_2 = {
    Transform = t.Transform,
    Validate = t.Validate,
    Autocomplete = t.Autocomplete,
    Parse = function(arg6) --[[ Parse ]] -- line: 40
        return arg6[1].TeamColor
    end
}

return function(arg7) -- line: 45
    -- upvalues:
    --  [1] t (copy)
    --  [2] Util_m (copy)
    --  [3] t_1 (copy)
    --  [4] t_2 (copy)

    arg7:RegisterType("team", t)
    arg7:RegisterType("teams", Util_m.MakeListableType(t))
    arg7:RegisterType("teamPlayers", t_1)
    arg7:RegisterType("teamColor", t_2)
    arg7:RegisterType("teamColors", Util_m.MakeListableType(t_2))
end
