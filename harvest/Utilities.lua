-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Utilities
-- Class: ModuleScript
-- bytes: 12625

local HttpService = game:GetService("HttpService")
local Config_m = require(script.Parent:WaitForChild("Config"))
local DefaultObjectSettings_m = require(script.Parent:WaitForChild("DefaultObjectSettings"))

local _ = function(vec1: Vector3) --[[ SafeUnit ]] -- line: 14
    if vec1.Magnitude == 0 then
        return Vector3.new(-0, -1, -0)
    end

    return vec1.Unit
end

local t = {
    LogIndent = 0,
    GetRotationBetween = function(vec2: Vector3, vec3: Vector3) --[[ GetRotationBetween ]] -- line: 25
        local v3 = vec2:Dot(vec3)
        local v4 = math.atan2(vec2:Cross(vec3).Magnitude, v3)
        local v5 = vec2:Cross(vec3)

        return CFrame.fromAxisAngle(
            if v5.Magnitude == 0 then Vector3.new(-0, -1, -0) else v5.Unit,
            v4
        )
    end,
    GetCFrameAxis = function(u1: CFrame, s1: string) --[[ GetCFrameAxis ]] -- line: 34
        local v7, v8, v9 = u1:ToEulerAnglesXYZ()

        if s1 == "X" then
            return v7
        end

        if s1 == "Y" then
            return v8
        end

        if s1 == "Z" then
            return v9
        end

        return nil
    end,
    GatherObjectSettings = function(u2: userdata) --[[ GatherObjectSettings ]] -- line: 46
        -- upvalues:
        --  [1] DefaultObjectSettings_m (copy)

        local t_1 = {}

        local _ = function(arg1: any, s2: string, s3: string) --[[ Expect ]] -- line: 49
            -- upvalues:
            --  [1] u2 (copy)

            if typeof(arg1) ~= s2 then
                local g_warn = warn
                local Name = u2.Name
                local v10 = typeof(arg1)
                g_warn(
                    `[SmartBone][Object] Expected attribute {s3} on {Name} to be of type {s2}, got type {v10}`
                )

                return false
            end

            return true
        end

        local v14

        for key, val in DefaultObjectSettings_m do
            local v11 = u2:GetAttribute(key)

            if v11 ~= nil then
                local v12 = typeof(val)

                if typeof(v11) ~= v12 then
                    local g_warn_1 = warn
                    local Name_1 = u2.Name
                    local v13 = typeof(v11)
                    g_warn_1(
                        `[SmartBone][Object] Expected attribute {key} on {Name_1} to be of type {v12}, got type {v13}`
                    )
                    v14 = false
                else
                    v14 = true
                end

                if not v14 then
                    v11 = nil
                end
            end

            v14 = if v11 ~= nil then v11 else val or v11
            t_1[key] = v14
        end

        return t_1
    end,
    GatherBoneSettings = function(u3: userdata) --[[ GatherBoneSettings ]] -- line: 73
        local _ = function(s4: string) --[[ Attrib ]] -- line: 74
            -- upvalues:
            --  [1] u3 (copy)

            return u3:GetAttribute(s4)
        end

        local _ = function(arg2: any, s5: string, s6: string) --[[ Expect ]] -- line: 78
            -- upvalues:
            --  [1] u3 (copy)

            if typeof(arg2) ~= s5 then
                local g_warn_2 = warn
                local Name_2 = u3.Name
                local v15 = typeof(arg2)
                g_warn_2(
                    `[SmartBone][Bone] Expected attribute {s6} on {Name_2} to be of type {s5}, got type {v15}`
                )
            end
        end

        local v16 = u3:GetAttribute("XAxisLocked") or false
        local v17 = u3:GetAttribute("YAxisLocked") or false
        local v18 = u3:GetAttribute("ZAxisLocked") or false
        local v19 = u3:GetAttribute("XAxisLimits") or NumberRange.new(-math.huge, math.huge)
        local v20 = u3:GetAttribute("YAxisLimits") or NumberRange.new(-math.huge, math.huge)
        local v21 = u3:GetAttribute("ZAxisLimits") or NumberRange.new(-math.huge, math.huge)
        local v22 = u3:GetAttribute("Radius") or 0.25
        local v23 = u3:GetAttribute("RotationLimit") or 180
        local v24 = u3:GetAttribute("Force") or "\194\172"
        local v25 = u3:GetAttribute("Gravity") or "\194\172"

        if typeof(v16) ~= "boolean" then
            local g_warn_3 = warn
            local Name_3 = u3.Name
            local v26 = typeof(v16)
            g_warn_3(
                `[SmartBone][Bone] Expected attribute XAxisLocked on {Name_3} to be of type boolean, got type {v26}`
            )
        end

        if typeof(v17) ~= "boolean" then
            local g_warn_4 = warn
            local Name_4 = u3.Name
            local v27 = typeof(v17)
            g_warn_4(
                `[SmartBone][Bone] Expected attribute YAxisLocked on {Name_4} to be of type boolean, got type {v27}`
            )
        end

        if typeof(v18) ~= "boolean" then
            local g_warn_5 = warn
            local Name_5 = u3.Name
            local v28 = typeof(v18)
            g_warn_5(
                `[SmartBone][Bone] Expected attribute ZAxisLocked on {Name_5} to be of type boolean, got type {v28}`
            )
        end

        if typeof(v19) ~= "NumberRange" then
            local g_warn_6 = warn
            local Name_6 = u3.Name
            local v29 = typeof(v19)
            g_warn_6(
                `[SmartBone][Bone] Expected attribute XAxisLimits on {Name_6} to be of type NumberRange, got type {v29}`
            )
        end

        if typeof(v20) ~= "NumberRange" then
            local g_warn_7 = warn
            local Name_7 = u3.Name
            local v30 = typeof(v20)
            g_warn_7(
                `[SmartBone][Bone] Expected attribute YAxisLimits on {Name_7} to be of type NumberRange, got type {v30}`
            )
        end

        if typeof(v21) ~= "NumberRange" then
            local g_warn_8 = warn
            local Name_8 = u3.Name
            local v31 = typeof(v21)
            g_warn_8(
                `[SmartBone][Bone] Expected attribute ZAxisLimits on {Name_8} to be of type NumberRange, got type {v31}`
            )
        end

        if typeof(v22) ~= "number" then
            local g_warn_9 = warn
            local Name_9 = u3.Name
            local v32 = typeof(v22)
            g_warn_9(
                `[SmartBone][Bone] Expected attribute Radius on {Name_9} to be of type number, got type {v32}`
            )
        end

        if typeof(v23) ~= "number" then
            local g_warn_10 = warn
            local Name_10 = u3.Name
            local v33 = typeof(v23)
            g_warn_10(
                `[SmartBone][Bone] Expected attribute RotationLimit on {Name_10} to be of type number, got type {v33}`
            )
        end

        if v24 ~= "\194\172" and typeof(v24) ~= "Vector3" then
            local g_warn_11 = warn
            local Name_11 = u3.Name
            local v34 = typeof(v24)
            g_warn_11(
                `[SmartBone][Bone] Expected attribute Force on {Name_11} to be of type Vector3, got type {v34}`
            )
        end

        if v24 ~= "\194\172" and typeof(v25) ~= "Vector3" then
            local g_warn_12 = warn
            local Name_12 = u3.Name
            local v35 = typeof(v25)
            g_warn_12(
                `[SmartBone][Bone] Expected attribute Gravity on {Name_12} to be of type Vector3, got type {v35}`
            )
        end

        return {
            AxisLocked = { v16, v17, v18 },
            XAxisLimits = v19,
            YAxisLimits = v20,
            ZAxisLimits = v21,
            RotationLimit = v23,
            Radius = v22,
            Force = v24,
            Gravity = v25
        }
    end,
    ClosestPointOnLine = function(vec4: Vector3, vec5: Vector3, n1: number, vec6: Vector3) --[[ ClosestPointOnLine ]] -- line: 131
        local v36 = (vec6 - vec4):Dot(vec5)

        return vec4 + vec5 * math.clamp(v36, -n1, n1)
    end,
    ClosestPointInBox = function(u4: CFrame, vec7: Vector3, vec8: Vector3) --[[ ClosestPointInBox ]] -- line: 139
        local v37 = u4:PointToObjectSpace(vec8)
        local X = vec7.X
        local X_1 = vec7.X
        local Z = vec7.Z
        local X_2 = v37.X
        local Y = v37.Y
        local Z_1 = v37.Z

        if v37 ~= v37 or vec7 ~= vec7 then
            return false, u4.Position, Vector3.new(0, 1, 0)
        end

        local v38 = math.clamp(X_2, -X * 0.5, X * 0.5)
        local v39 = math.clamp(Y, -X_1 * 0.5, X_1 * 0.5)
        local v40 = math.clamp(Z_1, -Z * 0.5, Z * 0.5)

        if v38 ~= X_2 or v39 ~= Y or v40 ~= Z_1 then
            local v41 = u4 * Vector3.new(v38, v39, v40)

            return false, v41, (vec8 - v41).unit
        end

        local v42 = X_2 - X * 0.5
        local v43 = Y - X_1 * 0.5
        local v44 = Z_1 - Z * 0.5
        local v45 = -X_2 - X * 0.5
        local v46 = -Y - X_1 * 0.5
        local v47 = -Z_1 - Z * 0.5
        local v48 = math.max(
            v42,
            v43,
            v44,
            v45,
            v46,
            v47
        )

        if v48 == v42 then
            return true, u4 * Vector3.new(X * 0.5, Y, Z_1), u4.XVector
        end

        if v48 == v43 then
            return true, u4 * Vector3.new(X_2, X_1 * 0.5, Z_1), u4.YVector
        end

        if v48 == v44 then
            return true, u4 * Vector3.new(X_2, Y, Z * 0.5), u4.ZVector
        end

        if v48 == v45 then
            return true, u4 * Vector3.new(-X * 0.5, Y, Z_1), -u4.XVector
        end

        if v48 == v46 then
            return true, u4 * Vector3.new(X_2, -X_1 * 0.5, Z_1), -u4.YVector
        end

        if v48 == v47 then
            return true, u4 * Vector3.new(X_2, Y, -Z * 0.5), -u4.ZVector
        end

        warn("CLOSEST POINT ON BOX FAIL")

        return false, Vector3.new(0, 0, 0), Vector3.new(0, 1, 0)
    end
}
local t_3 = {
    Block = "Box",
    Ball = "Sphere",
    Capsule = "Capsule",
    Sphere = "Sphere",
    Box = "Box",
    Cylinder = "Cylinder"
}

function t.GetCollider(u5: userdata) -- line: 194
    -- upvalues:
    --  [1] HttpService (copy)
    --  [2] t_3 (copy)

    local SelfCollider = u5:FindFirstChild("self.Collider")
    local v49 = nil

    if SelfCollider and SelfCollider:IsA("ModuleScript") then
        local v51 = require(SelfCollider)
        local v52 = nil
        pcall(function() -- line: 203
            -- upvalues:
            --  [1] v52 (ref)
            --  [2] HttpService (ref)
            --  [3] v51 (copy)

            v52 = HttpService:JSONDecode(v51)
        end)
        v49 = v52
    end

    if v49 then
        return v49
    end

    local _ = function(arg3) --[[ GetShapeName ]] -- line: 216
        local ColliderShape = arg3:GetAttribute("ColliderShape")

        if ColliderShape then
            return ColliderShape
        end

        if arg3:IsA("Part") then
            return arg3.Shape.Name
        end

        return "Box"
    end

    local v53 = t_3
    local ColliderShape_1 = u5:GetAttribute("ColliderShape")
    local v55 = v53[if ColliderShape_1 then ColliderShape_1 else if u5:IsA("Part") then u5.Shape.Name else "Box"]

    return {
        {
            Type = v55 or "Box",
            ScaleX = 1,
            ScaleY = 1,
            ScaleZ = 1,
            OffsetX = 0,
            OffsetY = 0,
            OffsetZ = 0,
            RotationX = 0,
            RotationY = 0,
            RotationZ = 0
        }
    }
end

function t.SB_INDENT_LOG() -- line: 250
    -- upvalues:
    --  [1] t (copy)

    local v56 = t
    v56.LogIndent += 1
end

function t.SB_UNINDENT_LOG() -- line: 254
    -- upvalues:
    --  [1] t (copy)

    local v57 = t
    v57.LogIndent -= 1
    t.LogIndent = math.max(t.LogIndent, 0)
end

function t.SB_ASSERT_CB(arg4, arg5, ...) -- line: 259
    if arg4 == false or arg4 == nil then
        arg5(...)
    end
end

function t.SB_VERBOSE_LOG(s7: string) -- line: 265
    -- upvalues:
    --  [1] Config_m (copy)
    --  [2] t (copy)

    if not Config_m.LOG_VERBOSE then
        return
    end

    local v59 = string.rep("    ", t.LogIndent)
    print(`{v59}[SmartBone][Log]: {s7}`)
end

function t.SB_VERBOSE_WARN(s8: string) -- line: 275
    -- upvalues:
    --  [1] Config_m (copy)
    --  [2] t (copy)

    if not Config_m.LOG_VERBOSE then
        return
    end

    local v60 = string.rep("    ", t.LogIndent)
    warn(`{v60}[SmartBone][Warn]: {s8}`)
end

function t.SB_VERBOSE_ERROR(s9: string) -- line: 285
    -- upvalues:
    --  [1] Config_m (copy)
    --  [2] t (copy)

    if not Config_m.LOG_VERBOSE then
        return
    end

    local v61 = string.rep("    ", t.LogIndent)
    error(`{v61}[SmartBone][Error]: {s9}`)
end

return t
