-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.MatchmakingService.OpenSkill.Constants
-- Class: ModuleScript
-- bytes: 618

local t = {
    z = function(arg1) --[[ z ]] -- line: 3
        return arg1.z or 3
    end,
    mu = function(arg2) --[[ mu ]] -- line: 7
        return arg2.mu or 25
    end
}

function t.sigma(arg3) -- line: 11
    -- upvalues:
    --  [1] t (copy)

    return arg3.sigma or t.mu(arg3) / t.z(arg3)
end

function t.epsilon(arg4) -- line: 15
    return arg4.epsilon or 0.0001
end

function t.beta(arg5) -- line: 19
    -- upvalues:
    --  [1] t (copy)

    return arg5.beta or t.sigma(arg5) / 2
end

function t.betaSq(arg6) -- line: 23
    -- upvalues:
    --  [1] t (copy)

    return t.beta(arg6) ^ 2
end

return t
