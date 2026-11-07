-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Items
-- Class: ModuleScript
-- bytes: 3223

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Modules = ReplicatedStorage.Modules
local Formatter_m = require(Modules.Formatter)
local Basic_m = require(Modules.Basic)
_G.NoDescription = "No description available."
local t = {}
t.__index = t
t.AllItems = {}
t.Swords = {}
t.Renamed = {
    ["Zogratis Cloak"] = "Nightfall Cloak",
    ["Princia's Cape"] = "Regent's Cape",
    ["Emberwitch Attire"] = "Emberwitch Robe"
}
t.HardCoded = {
    Augment = true,
    Artifact = true,
    Book = true,
    Broom = true,
    Consumable = true,
    Product = true,
    Game = true,
    Outfit = true,
    Tool = true,
    Pickaxe = true,
    Sickle = true,
    Schematic = true,
    Material = true
}

function t.GetSellPrice(arg1, arg2) -- line: 40
    if typeof(arg2) == "Instance" or not arg1.AllItems[arg2] then
        return
    end

    local v1 = if arg1.AllItems[arg2].Type ~= "Consumable" then arg1.AllItems[arg2].Price * 0.35 else arg1.AllItems[arg2].Price * 0.2

    return (math.floor(arg1.AllItems[arg2].SellPrice or v1))
end

t.UNTRADABLE_PREFIX = "Locked "

function t.GetBaseName(t1: table, s1: string) -- line: 66
    local UNTRADABLEPREFIX = t1.UNTRADABLE_PREFIX

    if typeof(s1) == "string" and string.sub(s1, 1, #UNTRADABLEPREFIX) == UNTRADABLEPREFIX then
        return (string.sub(s1, #UNTRADABLEPREFIX + 1))
    end

    return s1
end

function t.GetUntradableVariant(t2: table, s2: string) -- line: 75
    local v2 = t2.UNTRADABLE_PREFIX .. s2

    if t2.AllItems[v2] then
        return v2
    end

    return nil
end

function t.IsTradeableItem(t3: table, s3: string) -- line: 84
    local v3 = t3.AllItems[s3]

    return if v3 == nil then false else v3.Tradeable == true
end

function t.LookupItem(arg3, arg4) -- line: 89
    -- upvalues:
    --  [1] Formatter_m (copy)

    return arg3.AllItems[Formatter_m.formatItem(arg4)]
end

function t.GetMaxStock(arg5, arg6) -- line: 93
    -- upvalues:
    --  [1] Basic_m (copy)

    local v5 = nil

    if typeof(arg6) == "Instance" then
        v5 = arg6.Name
    elseif typeof(arg6) == "string" then
        v5 = arg6:split("_")[1]
    elseif not arg5.AllItems[arg6] then
        return Basic_m.MaxStock
    end

    return arg5.AllItems[v5].MaxStock or Basic_m.MaxStock
end

function t.GetIdentifier(t4: table, s4: string) -- line: 105
    -- upvalues:
    --  [1] HttpService (copy)

    local v7 = s4
    local v8 = nil
    local v9 = t4.AllItems[s4]

    if not v9 or (if t4.HardCoded[v9.Type] then false else if v9.HardCoded then false else true) then
        v8 = HttpService:GenerateGUID(false)
        v7 = s4 .. "_" .. v8
    end

    return v7, v8
end

local function initialize() -- line: 127
    -- upvalues:
    --  [1] t (copy)

    for _, child in script:GetChildren() do
        if child:IsA("ModuleScript") then
            for key_1, val in require(child) do
                t.AllItems[key_1] = val

                if child.Name == "Swords" then
                    t.Swords[key_1] = val
                end
            end
        end
    end

    if game["Run Service"]:IsStudio() then
        print("All Items", t.AllItems)
    end
end

initialize()

return t
