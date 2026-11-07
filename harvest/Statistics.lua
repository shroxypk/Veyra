-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.MatchmakingService.OpenSkill.Statistics
-- Class: ModuleScript
-- bytes: 1713

local t = {}
local v1 = require(script.Parent.Gaussian).new(0, 1)

function t.phiMajor(arg1) -- line: 6
    -- upvalues:
    --  [1] v1 (copy)

    return v1:cdf(arg1)
end

function t.phiMinor(arg2) -- line: 10
    -- upvalues:
    --  [1] v1 (copy)

    return v1:pdf(arg2)
end

function t.v(arg3, arg4) -- line: 14
    -- upvalues:
    --  [1] t (copy)

    local v2 = arg3 - arg4
    local v3 = t.phiMajor(v2)

    if v3 < 2.2204460492503E-16 then
        return -v2
    end

    return t.phiMinor(v2) / v3
end

function t.w(arg5, arg6) -- line: 24
    -- upvalues:
    --  [1] t (copy)

    local v4 = arg5 - arg6

    if t.phiMajor(v4) < 2.2204460492503E-16 then
        if arg5 < 0 then
            return 1
        end

        return 0
    else
        return t.v(arg5, arg6) * (t.v(arg5, arg6) + v4)
    end
end

function t.vt(arg7, arg8) -- line: 37
    -- upvalues:
    --  [1] t (copy)

    local v6 = math.abs(arg7)
    local v8 = t.phiMajor(arg8 - v6) - t.phiMajor(-arg8 - v6)

    if v8 < 1E-05 then
        if arg7 < 0 then
            return -arg7 - arg8
        end

        return -arg7 + arg8
    else
        local v10 = t.phiMinor(-arg8 - v6) - t.phiMinor(arg8 - v6)

        if arg7 < 0 then
            return -v10 / v8
        end

        return v10 / v8
    end
end

function t.wt(arg9, arg10) -- line: 52
    -- upvalues:
    --  [1] t (copy)

    local v11 = math.abs(arg9)
    local v13 = t.phiMajor(arg10 - v11) - t.phiMajor(-arg10 - v11)

    if v13 < 2.2204460492503E-16 then
        return 1
    end

    return ((arg10 - v11) * t.phiMinor(arg10 - v11) + (arg10 + v11) * t.phiMinor(-arg10 - v11)) / v13 + t.vt(
        arg9,
        arg10
    ) * t.vt(arg9, arg10)
end

return t
