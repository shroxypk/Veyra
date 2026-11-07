-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.PlaceFlags
-- Class: ModuleScript
-- bytes: 652

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local _ = function(s1: string) --[[ flag ]] -- line: 6
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    local attribute = workspace:GetAttribute(s1)

    if attribute == nil then
        attribute = ReplicatedStorage:GetAttribute(s1)
    end

    return attribute
end

local t = { Dungeon = nil, Arena = nil }
local v2 = workspace:GetAttribute("Dungeon")

if v2 == nil then
    v2 = ReplicatedStorage:GetAttribute("Dungeon")
end

t.Dungeon = v2
v2 = workspace:GetAttribute("Arena")

if v2 == nil then
    v2 = ReplicatedStorage:GetAttribute("Arena")
end

t.Arena = v2

return t
