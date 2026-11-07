-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.CircleGrow
-- Class: ModuleScript
-- bytes: 4627

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.TweenService

function getXAndZPositions(arg1, arg2) -- line: 6
    return math.cos(arg1) * arg2, math.sin(arg1) * arg2
end

local rng = Random.new()
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = {
    workspace.Map,
    workspace.Terrain,
    workspace:FindFirstChild("MapMisc")
}
raycastParams.FilterType = Enum.RaycastFilterType.Include
local t_1 = {}
t_1.__index = t_1

function t_1.CircleGrow(
    _,
    arg4,
    arg5,
    arg6,
    arg7,
    arg8,
    arg9
) -- line: 23
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] raycastParams (copy)
    --  [3] rng (copy)

    local t_2 = {}
    local v3 = arg4 or ReplicatedStorage.Effects.Ignore:Clone()
    local v4 = arg9 or v3.CFrame
    v3.CFrame = v4
    v4 = if v3.Name ~= "Ignore" then v3.Parent else arg8 or (workspace.Effects or v3.Parent)
    v3.Parent = v4

    if v3.Name == "Ignore" then
        _G.Debris(v3, 5)
    end

    local v5 = arg7 / 2
    local v6 = arg6 / 3

    for index = 1, arg5 do
        local v7, v8 = getXAndZPositions(index * (6.283185307179586 / arg5), v5)
        local P = (v3.CFrame * CFrame.new(v7, 0, v8)).p
        local Position = v3.Position
        local v10 = script.Part:Clone()
        v10.Name = "circleParts"
        v10.CFrame = CFrame.new(P, Position)
        local v11 = workspace:Raycast(v10.Position, Vector3.new(0, -10, 0), raycastParams)

        if v11 then
            if v11.Instance then
                table.insert(t_2, v10)
                local Material = v11.Material
                local v12 = v11.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(
                    Material
                ) or v11.Instance.Color
                v10.Color, v10.Transparency = v12, v11.Instance.Transparency
                v10.Material = Material
                v10.CFrame = CFrame.new(v11.Position) * CFrame.new(0, -v6.Y / 10, 0) * CFrame.fromEulerAnglesXYZ(
                    rng:NextInteger(-20, 20),
                    0,
                    rng:NextInteger(-20, 20)
                )
                v10.Parent = arg8 or workspace.Effects
                v10.Size = v6
            else
                v10:Destroy()
            end
        else
            v10:Destroy()
        end
    end

    return t_2, getXAndZPositions
end

function t_1.CircleGrowConnected(
    _,
    arg11,
    arg12,
    arg13,
    arg14,
    arg15,
    arg16
) -- line: 73
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] raycastParams (copy)
    --  [3] rng (copy)

    local t_3 = {}
    local v16 = arg11 or ReplicatedStorage.Effects.Ignore:Clone()
    local v17 = arg16 or v16.CFrame
    v16.CFrame = v17
    v17 = if v16.Name ~= "Ignore" then v16.Parent else arg15 or (workspace.Effects or v16.Parent)
    v16.Parent = v17

    if v16.Name == "Ignore" then
        _G.Debris(v16, 5)
    end

    local v18 = arg14 / 2
    local v19 = arg13 / 3

    for index_1 = 1, arg12 do
        local v20, v21 = getXAndZPositions(index_1 * (6.283185307179586 / arg12), v18)
        local P_1 = (v16.CFrame * CFrame.new(v20, 0, v21)).p
        local Position_1 = v16.Position
        local v23 = script.Part:Clone()
        v23.Name = "circleParts"
        v23.CFrame = CFrame.new(P_1, Position_1)
        local v24 = workspace:Raycast(v23.Position, Vector3.new(0, -10, 0), raycastParams)

        if v24 then
            if v24.Instance then
                table.insert(t_3, v23)
                local Material_1 = v24.Material
                local v25 = v24.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(
                    Material_1
                ) or v24.Instance.Color
                local Transparency = v24.Instance.Transparency
                local v26 = arg13 * rng:NextInteger(50, 120) / 100
                local _ = Vector3.new(arg14 / 1.5, v26, v26)
                v23.Color = v25
                v23.Transparency = Transparency
                v23.Material = Material_1
                v23.CFrame = CFrame.lookAt(v24.Position, v16.Position) * CFrame.new(
                    0,
                    -arg13.Y / 10,
                    0
                ) * CFrame.fromEulerAnglesXYZ(0.7853981633974483, 0, 0)
                v23.Parent = arg15 or workspace.Effects
                v23.Size = v19
            else
                v23:Destroy()
            end
        else
            v23:Destroy()
        end
    end

    return t_3, getXAndZPositions
end

return t_1
