-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Zone.ZoneController.CollectiveWorldModel
-- Class: ModuleScript
-- bytes: 1270

local t = {}
local WorldModel = nil
local RunService = game:GetService("RunService")

function t.setupWorldModel(_) -- line: 8
    -- upvalues:
    --  [1] WorldModel (ref)
    --  [2] RunService (copy)

    if WorldModel then
        return WorldModel
    end

    local v2 = if RunService:IsClient() then "ReplicatedStorage" else "ServerStorage"
    WorldModel = Instance.new("WorldModel")
    WorldModel.Name = "ZonePlusWorldModel"
    WorldModel.Parent = game:GetService(v2)

    return WorldModel
end

function t._getCombinedResults(_, arg3, ...) -- line: 22
    -- upvalues:
    --  [1] WorldModel (ref)

    local v4 = workspace[arg3](workspace, ...)

    if WorldModel then
        for _, val in pairs((WorldModel[arg3](WorldModel, ...))) do
            table.insert(v4, val)
        end
    end

    return v4
end

function t.GetPartBoundsInBox(arg4, arg5, arg6, arg7) -- line: 33
    return arg4:_getCombinedResults("GetPartBoundsInBox", arg5, arg6, arg7)
end

function t.GetPartBoundsInRadius(arg8, arg9, arg10, arg11) -- line: 37
    return arg8:_getCombinedResults("GetPartBoundsInRadius", arg9, arg10, arg11)
end

function t.GetPartsInPart(arg12, arg13, arg14) -- line: 41
    return arg12:_getCombinedResults("GetPartsInPart", arg13, arg14)
end

return t
