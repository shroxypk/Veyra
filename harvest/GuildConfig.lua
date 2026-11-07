-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.GuildConfig
-- Class: ModuleScript
-- bytes: 689

local t = {
    PointsPerRating = { ReputationPvP = 1, ReputationPvE = 1 },
    BaseMemberCap = 10,
    MemberCapPerLevel = 5,
    MemberCapCosts = { 250, 500, 1000, 2000 },
    UpgradeRanks = { Captain = true }
}

function t.GetMaxMemberCapLevel() -- line: 28
    -- upvalues:
    --  [1] t (copy)

    return #t.MemberCapCosts
end

function t.GetMemberCap(n1: number?) -- line: 32
    -- upvalues:
    --  [1] t (copy)

    return t.BaseMemberCap + math.clamp(tonumber(n1) or 0, 0, #t.MemberCapCosts) * t.MemberCapPerLevel
end

function t.GetMemberCapCost(n2: number?) -- line: 38
    -- upvalues:
    --  [1] t (copy)

    return t.MemberCapCosts[(tonumber(n2) or 0) + 1]
end

return t
