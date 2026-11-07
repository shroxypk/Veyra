-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Items._settings
-- Class: ModuleScript
-- bytes: 569

local t = {}
t.Rarities = {
    Common = Color3.fromRGB(172, 172, 172),
    Uncommon = Color3.fromRGB(168, 212, 85),
    Unique = Color3.fromRGB(153, 197, 255),
    Fabled = Color3.fromRGB(255, 99, 85),
    Event = Color3.fromRGB(164, 111, 255),
    Premium = Color3.fromRGB(255, 42, 205),
    Exclusive = Color3.fromRGB(255, 161, 28),
    Unclassified = Color3.fromRGB(255, 255, 255)
}

function t.get_rarity_index(arg1, arg2) -- line: 13
    for key, val in pairs(arg1.Rarities) do
        if val == arg2 then
            return key
        end
    end
end

return t
