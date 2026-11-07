-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.MatchmakingService.OpenSkill.Gaussian
-- Class: ModuleScript
-- bytes: 3587

local function erfc(n1: number) -- line: 6
    local v1 = math.abs(n1)
    local v2 = 1 / (v1 / 2 + 1)
    local v3 = v2 * math.exp(
        -v1 * v1 - 1.26551223 + v2 * (v2 * (v2 * (v2 * (v2 * (v2 * (v2 * (v2 * (v2 * 0.17087277 + -0.82215223) + 1.48851587) + -1.13520398) + 0.27886807) + -0.18628806) + 0.09678418) + 0.37409196) + 1.00002368)
    )

    return n1 < 0 and 2 - v3 or v3
end

local function ierfc(n2: number) -- line: 16
    -- upvalues:
    --  [1] erfc (copy)

    if n2 >= 2 then
        return -100
    end

    if n2 <= 0 then
        return 100
    end

    local v5 = n2 < 1 and n2 or 2 - n2
    local v6 = math.sqrt(math.log(v5 / 2) * -2)
    local v7 = ((v6 * 0.27061 + 2.30753) / (v6 * (v6 * 0.04481 + 0.99229) + 1) - v6) * -0.70711

    for _ = 1, 2 do
        local v8 = erfc(v7) - v5
        v7 += v8 / (math.exp(-(v7 * v7)) * 1.1283791670955126 - v7 * v8)
    end

    return n2 < 1 and v7 or -v7
end

local t = {}
t.__index = t

local function fromPrecisionMean(n3: number, n4: number) -- line: 33
    -- upvalues:
    --  [1] t (copy)

    return t.new(n4 / n3, 1 / n3)
end

function t.__mul(arg1, arg2) -- line: 37
    -- upvalues:
    --  [1] fromPrecisionMean (copy)

    if type(arg2) == "number" then
        return arg1:scale(arg2)
    end

    local v10 = 1 / arg1.variance
    local v11 = 1 / arg2.variance

    return fromPrecisionMean(v10 + v11, v10 * arg1.mean + v11 * arg2.mean)
end

function t.__div(arg3, arg4) -- line: 48
    -- upvalues:
    --  [1] fromPrecisionMean (copy)

    if type(arg4) == "number" then
        return arg3:scale(1 / arg4)
    end

    local v13 = 1 / arg3.variance
    local v14 = 1 / arg4.variance

    return fromPrecisionMean(v13 - v14, v13 * arg3.mean - v14 * arg4.mean)
end

function t.__add(arg5, arg6) -- line: 59
    -- upvalues:
    --  [1] t (copy)

    if type(arg6) == "number" then
        error("Only gaussians can be added")
    end

    return t.new(arg5.mean + arg6.mean, arg5.variance + arg6.variance)
end

function t.__sub(arg7, arg8) -- line: 66
    -- upvalues:
    --  [1] t (copy)

    if type(arg8) == "number" then
        error("Only gaussians can be subtracted")
    end

    return t.new(arg7.mean - arg8.mean, arg7.variance + arg8.variance)
end

function t.new(n5: number, n6: number) -- line: 73
    -- upvalues:
    --  [1] t (copy)

    if n6 <= 0 then
        error("Variance must be > 0, but is " .. n6)
    end

    return (setmetatable({ mean = n5, variance = n6, standardDeviation = math.sqrt(n6) }, t))
end

function t.random(t1: table, n7: number) -- line: 86
    local Mean = t1.mean
    local StandardDeviation = t1.standardDeviation
    local t_2 = {}

    for _ = 1, n7 do
        table.insert(
            t_2,
            math.sqrt(math.log(math.random()) * -2) * math.cos(6.283185307179586 * math.random()) * StandardDeviation + Mean
        )
    end

    return t_2
end

function t.pdf(t2: table, n8: number) -- line: 99
    return math.exp(-math.pow(n8 - t2.mean, 2) / (2 * t2.variance)) / (t2.standardDeviation * 2.5066282746310002)
end

function t.cdf(t3: table, n9: number) -- line: 106
    -- upvalues:
    --  [1] erfc (copy)

    return erfc(-(n9 - t3.mean) / (t3.standardDeviation * 1.4142135623730951)) * 0.5
end

function t.ppf(t4: table, n10: number) -- line: 111
    -- upvalues:
    --  [1] ierfc (copy)

    return t4.mean - t4.standardDeviation * 1.4142135623730951 * ierfc(n10 * 2)
end

function t.scale(t5: table, n11: number) -- line: 115
    -- upvalues:
    --  [1] t (copy)

    return t.new(t5.mean * n11, t5.variance * n11 * n11)
end

return t
