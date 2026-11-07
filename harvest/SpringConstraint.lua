-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Components.Constraints.SpringConstraint
-- Class: ModuleScript
-- bytes: 1143

return function(
    arg1,
    arg2,
    arg3,
    arg4,
    arg5
) -- line: 2
    debug.profilebegin("Spring Constraint")
    local Settings: any = arg4.Settings
    local Stiffness: any = Settings.Stiffness
    local Elasticity: any = Settings.Elasticity
    local v1: any = arg4.Bones[arg1.ParentIndex]

    if v1 then
        local FreeLength = arg1.FreeLength

        if Stiffness > 0 or Elasticity > 0 then
            arg3 = arg3 or (CFrame.new(v1.Position) * v1.TransformOffset.Rotation * CFrame.new(
                arg1.LocalTransformOffset.Position
            )).Position
            arg2 += (arg3 - arg2) * (Elasticity * arg5)
            arg2 = if not (Stiffness > 0) then arg2 else if not ((arg3 - arg2).Magnitude > FreeLength * (1 - Stiffness) * 2) then arg2 else arg2 + (arg3 - arg2) * (((arg3 - arg2).Magnitude - FreeLength * (1 - Stiffness) * 2) / (arg3 - arg2).Magnitude)
        end

        local v4 = v1.Position - arg2
        local Magnitude = v4.Magnitude

        if Magnitude > 0 then
            arg2 += v4 * ((Magnitude - FreeLength) / Magnitude)
        end
    end

    debug.profileend()

    return arg2
end
