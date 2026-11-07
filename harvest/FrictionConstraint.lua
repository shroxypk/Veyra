-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Components.Constraints.FrictionConstraint
-- Class: ModuleScript
-- bytes: 95

return function(arg1, arg2, arg3) -- line: 1
    return arg3:Lerp(arg2, 1 - arg1.Friction)
end
