-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.RotatedRegion3.Supports
-- Class: ModuleScript
-- bytes: 1405

local _ = function(arg1, arg2, arg3, arg4) --[[ rayPlane ]] -- line: 6
    local v2 = -(arg1 - arg3):Dot(arg4) / arg2:Dot(arg4)

    return arg1 + v2 * arg2, v2
end

return {
    PointCloud = function(arg5, arg6) --[[ PointCloud ]] -- line: 16
        local v3 = arg5[1]
        local v4 = arg5[1]:Dot(arg6)

        for index = 2, #arg5 do
            local v5 = arg5[index]:Dot(arg6)

            if v4 < v5 then
                v3 = arg5[index]
                v4 = v5
            end
        end

        return v3
    end,
    Cylinder = function(arg7, arg8) --[[ Cylinder ]] -- line: 28
        local v6, v7 = unpack(arg7)
        arg8 = v6:VectorToObjectSpace(arg8)
        local v8 = math.min(v7.y, v7.z)
        local v9 = arg8:Dot(Vector3.new(1, 0, 0))
        local vec3 = Vector3.new(v7.x, 0, 0)
        local v10

        if v9 == 0 then
            v10 = arg8.Unit * v8
        else
            local v12 = v9 > 0 and vec3 or -vec3
            v10 = v12 + (Vector3.new(0, 0, 0) + -(Vector3.new(0, 0, 0) - v12):Dot(
                Vector3.new(1, 0, 0)
            ) / arg8:Dot(Vector3.new(1, 0, 0)) * arg8 - v12).Unit * v8
        end

        return v6:PointToWorldSpace(v10)
    end,
    Ellipsoid = function(arg9, arg10) --[[ Ellipsoid ]] -- line: 46
        local v15, v16 = unpack(arg9)

        return v15:PointToWorldSpace(v16 * (v16 * v15:VectorToObjectSpace(arg10)).Unit)
    end
}
