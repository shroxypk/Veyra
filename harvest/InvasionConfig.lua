-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.InvasionConfig
-- Class: ModuleScript
-- bytes: 4338

local t = {
    DebugSameServer = game:GetService("RunService"):IsStudio(),
    SettingName = "AllowInvasions",
    InvadedBonus = 0.4,
    DefenderBonusChestScale = 0.65,
    PartyChestScale = 0.8,
    ConsolationMarksScale = 0.5,
    InvaderXPScale = 1,
    InvaderRankXPWeight = 0.75,
    ExtraTime = 120,
    HealingMultiplier = 0.5,
    SpawnDistance = 150,
    RevealRadius = 100,
    RevealPlayerRadius = 45,
    OverheadDistance = 80,
    LeashRadius = 400,
    LeashGrace = 10,
    EnterGrace = 30,
    BlockRepeatTargets = false,
    MinTimeLeftToJoin = 120,
    TeleportMargin = 30,
    MaxProgressToJoin = 0.7,
    ListingTTL = 30,
    ListingRefresh = 10,
    SearchInterval = 5,
    PreferredRegionTime = 30,
    MaxLevelGap = 22,
    LevelGapSteps = { { time = 0, gap = 7 }, { time = 20, gap = 15 }, { time = 40, gap = 22 } },
    DepartCountdown = 5,
    IncomingTimeout = 90,
    PartyArrivalWindow = 45,
    LootTime = 45,
    ReturnDelay = 8,
    ForfeitLimit = 3,
    ForfeitWindow = 86400,
    ForfeitCooldown = 86400,
    Regions = {
        { Id = "Any", Name = "Any" },
        { Id = "NA", Name = "NA" },
        { Id = "EU", Name = "EU" },
        { Id = "AS", Name = "ASIA" },
        { Id = "OC", Name = "OCE" },
        { Id = "SA", Name = "SA" }
    }
}
local t_1 = {
    US = "NA",
    CA = "NA",
    MX = "NA",
    PR = "NA",
    GT = "NA",
    CR = "NA",
    PA = "NA",
    DO = "NA",
    JM = "NA",
    HN = "NA",
    SV = "NA",
    NI = "NA",
    CU = "NA",
    TT = "NA",
    BS = "NA",
    BR = "SA",
    AR = "SA",
    CL = "SA",
    CO = "SA",
    PE = "SA",
    VE = "SA",
    EC = "SA",
    UY = "SA",
    PY = "SA",
    BO = "SA",
    GB = "EU",
    IE = "EU",
    FR = "EU",
    DE = "EU",
    NL = "EU",
    BE = "EU",
    LU = "EU",
    ES = "EU",
    PT = "EU",
    IT = "EU",
    CH = "EU",
    AT = "EU",
    PL = "EU",
    CZ = "EU",
    SK = "EU",
    HU = "EU",
    RO = "EU",
    BG = "EU",
    GR = "EU",
    HR = "EU",
    SI = "EU",
    RS = "EU",
    BA = "EU",
    DK = "EU",
    NO = "EU",
    SE = "EU",
    FI = "EU",
    EE = "EU",
    LV = "EU",
    LT = "EU",
    UA = "EU",
    BY = "EU",
    RU = "EU",
    TR = "EU",
    IS = "EU",
    MT = "EU",
    CY = "EU",
    MD = "EU",
    AL = "EU",
    MK = "EU",
    IL = "EU",
    EG = "EU",
    MA = "EU",
    DZ = "EU",
    TN = "EU",
    ZA = "EU",
    NG = "EU",
    KE = "EU",
    SA = "EU",
    AE = "EU",
    QA = "EU",
    KW = "EU",
    BH = "EU",
    OM = "EU",
    JO = "EU",
    LB = "EU",
    JP = "AS",
    KR = "AS",
    CN = "AS",
    HK = "AS",
    TW = "AS",
    SG = "AS",
    MY = "AS",
    TH = "AS",
    VN = "AS",
    PH = "AS",
    ID = "AS",
    IN = "AS",
    PK = "AS",
    BD = "AS",
    LK = "AS",
    NP = "AS",
    KH = "AS",
    MM = "AS",
    MN = "AS",
    KZ = "AS",
    AU = "OC",
    NZ = "OC",
    FJ = "OC",
    PG = "OC"
}
local t_2 = {
    ["United States"] = "NA",
    Canada = "NA",
    ["United Kingdom"] = "EU",
    Netherlands = "EU",
    France = "EU",
    Germany = "EU",
    Poland = "EU",
    India = "AS",
    Japan = "AS",
    Singapore = "AS",
    ["Hong Kong"] = "AS",
    Australia = "OC",
    Brazil = "SA"
}

function t.RegionFromCountryCode(s1: string?) -- line: 94
    -- upvalues:
    --  [1] t_1 (copy)

    if not s1 then
        return nil
    end

    return t_1[string.upper(s1)]
end

function t.RegionFromCountryName(s2: string?) -- line: 101
    -- upvalues:
    --  [1] t_2 (copy)

    if not s2 then
        return nil
    end

    return t_2[s2]
end

function t.GetRegionName(s3: string?) -- line: 108
    -- upvalues:
    --  [1] t (copy)

    for _, val in t.Regions do
        if val.Id == s3 then
            return val.Name
        end
    end

    return "Any"
end

function t.IsValidRegion(arg1) -- line: 117
    -- upvalues:
    --  [1] t (copy)

    if type(arg1) ~= "string" then
        return false
    end

    for _, val_1 in t.Regions do
        if val_1.Id == arg1 then
            return true
        end
    end

    return false
end

function t.GetLevelGap(n1: number) -- line: 129
    -- upvalues:
    --  [1] t (copy)

    local Gap = t.LevelGapSteps[1].gap

    for _, val_2 in t.LevelGapSteps do
        if n1 >= val_2.time then
            Gap = val_2.gap
        end
    end

    return (math.min(Gap, t.MaxLevelGap))
end

return t
