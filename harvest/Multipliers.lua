-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.Multipliers
-- Class: ModuleScript
-- bytes: 585

local RunService = game:GetService("RunService")
local t = {}

for _, child in script:GetChildren() do
    t[child.Name] = require(child)
end

local function addMultiplier(arg1, arg2, arg3, arg4) -- line: 9
    -- upvalues:
    --  [1] t (copy)
    --  [2] RunService (copy)

    local v1 = 1

    for key_1, val in t do
        local v2 = val(arg1, arg2, arg4, arg3)

        if RunService:IsStudio() and v2 > 0 then
            print(`Multiplier Apply: {key_1}, {v2}`)
        end

        v1 += v2
    end

    if v1 > 1 then
    end

    return arg3 * v1
end

return addMultiplier
