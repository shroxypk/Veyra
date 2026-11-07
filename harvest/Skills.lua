-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills
-- Class: ModuleScript
-- bytes: 1185

local _ = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
_G.NoDescription = "No description available."
_G.agil_icon = "rbxassetid://16176208452"
_G.misc_icon = "rbxassetid://16176203007"
_G.mob_icon = "rbxassetid://16176226718"
_G.weapon_icon = "rbxassetid://16178731754"
_G.spirit_icon = "rbxassetid://10413967972"
local t = {}
t.__index = t
t.Skillsets = {}
t.Skills = {}

local function init() -- line: 21
    -- upvalues:
    --  [1] t (copy)

    for _, val in script:QueryDescendants("ModuleScript") do
        local v1 = require(val)
        t.Skillsets[val.Name] = {}
        local v2 = t.Skillsets[val.Name]

        for key_1, val_1 in v1 do
            v2[key_1] = val_1
            t.Skills[key_1] = val_1
        end
    end
end

init()

function t.Request(arg1, arg2) -- line: 37
    local v3 = arg2:match("Info") and arg2 or arg2 .. "Info"
    local v4 = v3
    v3 = {}

    for key_2, val_2 in arg1.Skillsets[v4] do
        v3[key_2] = val_2
    end

    return v3
end

function t.LookupSkill(arg3, arg4) -- line: 49
    return arg3.Skills[arg4]
end

if RunService:IsStudio() then
    print("All Skills", t.Skills)
end

return t
