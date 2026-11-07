-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.services.caches
-- Class: ModuleScript
-- bytes: 1813

local ObjObjectCache_m = require("../obj/ObjectCache")
local ModUtility_m = require("../mod/utility")

return {
    init = function(t1: table) --[[ init ]] -- line: 7
        -- upvalues:
        --  [1] ModUtility_m (copy)
        --  [2] ObjObjectCache_m (copy)

        local Part = Instance.new("Part")
        Part.Transparency = 1
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanQuery = false
        Part.Locked = true
        local DONOTREMOVEForgeSharedPartCache_Folder = Instance.new("Folder")
        DONOTREMOVEForgeSharedPartCache_Folder.Name = "DO_NOT_REMOVE_ForgeSharedPartCache"
        DONOTREMOVEForgeSharedPartCache_Folder.Archivable = false
        DONOTREMOVEForgeSharedPartCache_Folder.Parent = workspace.Terrain
        ModUtility_m.protectParent(t1, DONOTREMOVEForgeSharedPartCache_Folder)
        local t_1 = { size = 150, on_free = nil }

        function t_1.on_free(arg1) -- line: 27
            -- upvalues:
            --  [1] DONOTREMOVEForgeSharedPartCache_Folder (copy)

            local Value = arg1.value
            Value.Transparency = 1
            Value.Anchored = true
            Value.CanQuery = false
            Value.CanCollide = false
            Value.CollisionGroup = "ForgeMouseIgnore"
            Value.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            Value.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            Value.Parent = DONOTREMOVEForgeSharedPartCache_Folder
            Value:ClearAllChildren()
        end

        local v1 = ObjObjectCache_m.new(Part, DONOTREMOVEForgeSharedPartCache_Folder, t_1)
        local t_2 = { shared_part = v1 }
        table.insert(t1, function() -- line: 55
            -- upvalues:
            --  [1] v1 (ref)

            v1:destroy()
        end)

        return t_2
    end
}
