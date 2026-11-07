-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Locations
-- Class: ModuleScript
-- bytes: 1663

local _ = require(game:GetService("ReplicatedFirst").Services)
local Locations = game:GetService("ReplicatedStorage")._Locations
local v2 = 0

for _, _ in Locations:QueryDescendants("Folder[$MapLocation]") do
    v2 += 1
end

local t = {}
local t_1 = {}
t_1.__index = t_1

function t_1.GetInfo(_, arg2) -- line: 18
    -- upvalues:
    --  [1] t (copy)
    --  [2] Locations (copy)

    if t[arg2] then
        return t[arg2]
    end

    local v3 = Locations:FindFirstChild(arg2, true)

    if not v3 then
        return
    end

    v3:SetAttribute("UID", tostring(os.clock() * 1000000):gsub("%.", ""))
    local t_2 = { ID = v3:GetAttribute("UID") }

    for key_1, val_1 in v3:GetAttributes() do
        t_2[key_1] = val_1
    end

    t[arg2] = t_2

    return t[arg2]
end

function t_1.GetLocations(_) -- line: 43
    -- upvalues:
    --  [1] t (copy)

    return t
end

function t_1.GetDiscoverableLocations(_) -- line: 47
    -- upvalues:
    --  [1] v2 (ref)

    return v2
end

function t_1.AddLocation(_, arg6, arg7) -- line: 51
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] Locations (copy)

    local Folder = Instance.new("Folder")
    Folder.Name = arg6

    for key_2, val_2 in pairs(arg7) do
        Folder:SetAttribute(key_2, val_2)

        if key_2 == "MapLocation" and val_2 == true then
            v2 += 1
        end
    end

    Folder.Parent = Locations["Server : Locations"]
end

function t_1.RemoveLocation(_, arg9) -- line: 63
    -- upvalues:
    --  [1] Locations (copy)
    --  [2] t (copy)

    local v4 = Locations:FindFirstChild(arg9, true)

    if v4 then
        v4:Destroy()
        t[arg9] = nil
    end
end

return t_1
