-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Cmdr.Initialize
-- Class: ModuleScript
-- bytes: 1701

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local CreateGui_m = require(script.Parent.CreateGui)

return function(arg1) -- line: 6
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] StarterGui (copy)
    --  [3] CreateGui_m (copy)

    local CmdrClient = nil

    local _ = function(arg2, arg3, arg4) --[[ Create ]] -- line: 9
        -- upvalues:
        --  [1] CmdrClient (ref)

        local v2 = Instance.new(arg2)
        v2.Name = arg3
        local v3 = arg4 or CmdrClient
        v2.Parent = v3

        return v2
    end

    CmdrClient = script.Parent.CmdrClient
    CmdrClient.Parent = ReplicatedStorage
    local CmdrFunction_RemoteFunction = Instance.new("RemoteFunction")
    CmdrFunction_RemoteFunction.Name = "CmdrFunction"
    CmdrFunction_RemoteFunction.Parent = CmdrClient
    local CmdrEvent_RemoteEvent = Instance.new("RemoteEvent")
    CmdrEvent_RemoteEvent.Name = "CmdrEvent"
    CmdrEvent_RemoteEvent.Parent = CmdrClient
    local Folder = Instance.new("Folder")
    local _
    Folder.Name, _, Folder.Parent = "Commands", CmdrClient, "Commands"
    local Folder_1 = Instance.new("Folder")
    local _
    Folder_1.Name, _, Folder_1.Parent = "Types", CmdrClient, "Types"
    script.Parent.Shared.Parent = CmdrClient
    arg1.ReplicatedRoot = CmdrClient
    arg1.RemoteFunction = CmdrFunction_RemoteFunction
    arg1.RemoteEvent = CmdrEvent_RemoteEvent
    arg1:RegisterTypesIn(script.Parent.BuiltInTypes)
    script.Parent.BuiltInTypes:Destroy()
    script.Parent.BuiltInCommands.Name = "Server commands"

    if StarterGui:FindFirstChild("Cmdr") == nil then
        CreateGui_m()
    end
end
