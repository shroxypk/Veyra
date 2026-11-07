-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Frustum
-- Class: ModuleScript
-- bytes: 3504

local Parent: any = script.Parent
local Config_m: any = require(Parent:WaitForChild("Config"))
local Utilities_m: any = require(Parent:WaitForChild("Utilities"))
local t: any = {
    GetCFrames = function(arg1, arg2) --[[ GetCFrames ]] -- line: 8
        debug.profilebegin("Frustum::GetCFrames")
        local v3: any = arg1.CFrame
        local Position: any = v3.Position
        local RightVector: any = v3.RightVector
        local UpVector: any = v3.UpVector
        local v4: any = arg2 * 0.5
        local v5: any = math.tan((arg1.FieldOfView + 5) * 0.5 * 0.017453) * arg2
        local v6: any = v5 * (arg1.ViewportSize.X / arg1.ViewportSize.Y)
        local v7: any = v3 * CFrame.new(0, 0, -arg2)
        local v8: any = v7 * Vector3.new(v6, v5, 0)
        local v9: any = v7 * Vector3.new(-v6, -v5, 0)
        local v10: any = v7 * Vector3.new(v6, -v5, 0)
        local v11 = v10 - Position
        local v12 = (v3 * CFrame.new(0, 0, -v4)):Inverse()
        local v13 = v9 - Position
        local Unit = UpVector:Cross(v11).Unit
        local v14 = Position - v8
        local Unit_1 = UpVector:Cross(v13).Unit
        local v15 = Position - v10
        local Unit_2 = RightVector:Cross(v14).Unit
        local Unit_3 = RightVector:Cross(v15).Unit
        debug.profileend()

        return v12, v6, v5, v4, Unit, Unit_1, Unit_2, Unit_3, v3
    end,
    InViewFrustum = function(
        arg3,
        arg4,
        arg5,
        arg6,
        arg7,
        arg8,
        arg9,
        arg10,
        arg11,
        arg12
    ) --[[ InViewFrustum ]] -- line: 32
        debug.profilebegin("Frustum::InViewFrustum")
        local v16: any = arg4 * arg3
        local Position_1

        if arg5 < v16.X or v16.X < -arg5 or arg6 < v16.Y or v16.Y < -arg6 or arg7 < v16.Z or v16.Z < -arg7 then
            Position_1 = arg12.Position
            debug.profileend()

            return false
        end

        local v17: any = arg3 - Position_1

        if not (arg8:Dot(v17) < 0) then
            if not (arg9:Dot(v17) > 0) then
                if not (arg10:Dot(v17) < 0) then
                    if arg11:Dot(v17) > 0 then
                        debug.profileend()

                        return false
                    end

                    debug.profileend()

                    return true
                else
                    debug.profileend()

                    return false
                end
            else
                debug.profileend()

                return false
            end
        else
            debug.profileend()

            return false
        end
    end
}

function t.ObjectInFrustum(
    arg13,
    arg14,
    arg15,
    arg16,
    arg17,
    arg18,
    arg19,
    arg20,
    arg21,
    arg22
) -- line: 73
    -- upvalues:
    --  [1] Config_m (copy)
    --  [2] Utilities_m (copy)
    --  [3] t (copy)

    local v18: any = arg13.CFrame
    local v19: any = Config_m.FAR_PLANE * 0.5
    local Size = arg13.Size
    local v20: any = Utilities_m.ClosestPointOnLine(
        arg22.Position + arg22.LookVector * v19,
        arg22.LookVector,
        v19,
        v18.Position
    )
    local v21: any, v22 = Utilities_m.ClosestPointInBox(v18, Size, v20)

    if v21 then
        return true
    end

    if t.InViewFrustum(
        v22,
        arg14,
        arg15,
        arg16,
        arg17,
        arg18,
        arg19,
        arg20,
        arg21,
        arg22
    ) then
        return true
    end

    return false
end

return t
