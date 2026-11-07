-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Types.PlayerId
-- Class: ModuleScript
-- bytes: 2739

local Util_m = require(script.Parent.Parent.Shared.Util)
local Players = game:GetService("Players")
local t = {}

local _ = function(arg1) --[[ getUserId ]] -- line: 5
    -- upvalues:
    --  [1] t (copy)
    --  [2] Players (copy)

    if t[arg1] then
        return t[arg1]
    end

    if Players:FindFirstChild(arg1) then
        t[arg1] = Players[arg1].UserId

        return Players[arg1].UserId
    end

    local Success, Result = pcall(Players.GetUserIdFromNameAsync, Players, arg1)

    if not Success then
        return nil
    end

    t[arg1] = Result

    return Result
end

local t_1 = {
    DisplayName = "Full Player Name",
    Prefixes = "# integer",
    Transform = function(arg2) --[[ Transform ]] -- line: 27
        -- upvalues:
        --  [1] Util_m (copy)
        --  [2] Players (copy)

        return arg2, Util_m.MakeFuzzyFinder(Players:GetPlayers())(arg2)
    end,
    ValidateOnce = function(arg3) --[[ ValidateOnce ]] -- line: 33
        -- upvalues:
        --  [1] t (copy)
        --  [2] Players (copy)

        local v1

        if t[arg3] then
            v1 = t[arg3]
        elseif Players:FindFirstChild(arg3) then
            t[arg3] = Players[arg3].UserId
            v1 = Players[arg3].UserId
        else
            local Success_1, Result_1 = pcall(Players.GetUserIdFromNameAsync, Players, arg3)

            if not Success_1 then
                v1 = nil
            else
                t[arg3], v1 = Result_1, Result_1
            end
        end

        return v1 ~= nil, "No player with that name could be found."
    end,
    Autocomplete = function(_, arg5) --[[ Autocomplete ]] -- line: 37
        -- upvalues:
        --  [1] Util_m (copy)

        return Util_m.GetNames(arg5)
    end,
    Parse = function(arg6) --[[ Parse ]] -- line: 41
        -- upvalues:
        --  [1] t (copy)
        --  [2] Players (copy)

        if t[arg6] then
            return t[arg6]
        end

        if Players:FindFirstChild(arg6) then
            t[arg6] = Players[arg6].UserId

            return Players[arg6].UserId
        end

        local Success_2, Result_2 = pcall(Players.GetUserIdFromNameAsync, Players, arg6)

        if not Success_2 then
            return nil
        end

        local v3
        t[arg6], v3 = Result_2, Result_2

        return v3
    end,
    Default = function(arg7) --[[ Default ]] -- line: 45
        return arg7.Name
    end,
    ArgumentOperatorAliases = { me = ".", all = "*", others = "**", random = "?" }
}

return function(arg8) -- line: 57
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] Util_m (copy)

    arg8:RegisterType("playerId", t_1)
    arg8:RegisterType("playerIds", Util_m.MakeListableType(t_1, { Prefixes = "# integers" }))
end
