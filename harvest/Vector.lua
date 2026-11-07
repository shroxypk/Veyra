-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Types.Vector
-- Class: ModuleScript
-- bytes: 942

local Util_m = require(script.Parent.Parent.Shared.Util)

local function validateVector(arg1, arg2) -- line: 3
    if arg1 == nil then
        return false, ("Invalid or missing number at position %d in Vector type."):format(arg2)
    end

    return true
end

local v1 = Util_m.MakeSequenceType(
    {
        ValidateEach = validateVector,
        TransformEach = tonumber,
        Constructor = Vector3.new,
        Length = 3
    }
)
local v2 = Util_m.MakeSequenceType(
    {
        ValidateEach = validateVector,
        TransformEach = tonumber,
        Constructor = Vector2.new,
        Length = 2
    }
)

return function(arg3) -- line: 25
    -- upvalues:
    --  [1] v1 (copy)
    --  [2] Util_m (copy)
    --  [3] v2 (copy)

    arg3:RegisterType("vector3", v1)
    arg3:RegisterType("vector3s", Util_m.MakeListableType(v1))
    arg3:RegisterType("vector2", v2)
    arg3:RegisterType("vector2s", Util_m.MakeListableType(v2))
end
