-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Components.Constraints.CollisionConstraint
-- Class: ModuleScript
-- bytes: 580

return function(arg1, arg2, arg3) -- line: 1
    debug.profilebegin("Collision Constraint")
    local t = {}
    local t_1 = {}

    for _, val in arg3 do
        local v1 = val:GetCollisions(arg2, arg1.Radius)

        if #v1 > 0 then
            table.insert(t_1, val:GetObject())
        end

        for _, val_1 in v1 do
            table.insert(t, val_1)
        end
    end

    for _, val_2 in t do
        arg2 = val_2.ClosestPoint + val_2.Normal * arg1.Radius
    end

    arg1.CollisionsData = t
    arg1.CollisionHits = t_1
    debug.profileend()

    return arg2
end
