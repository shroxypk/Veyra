-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.DebrisCircle
-- Class: ModuleScript
-- bytes: 15737

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local os_clock = os.clock
local ReplicatedStorage = Services_m.ReplicatedStorage
local TweenService = Services_m.TweenService
local RunService = Services_m.RunService

function getXAndZPositions(arg1, arg2) -- line: 9
    return math.cos(arg1) * arg2, math.sin(arg1) * arg2
end

function removelight(arg3) -- line: 15
    -- upvalues:
    --  [1] TweenService (copy)

    pcall(function() -- line: 16
        -- upvalues:
        --  [1] TweenService (ref)
        --  [2] arg3 (copy)

        local v3 = TweenService:Create(
            arg3,
            TweenInfo.new(0.8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            { Range = 0, Brightness = 0 }
        )
        v3:Play()
        v3.Completed:Wait()
    end)
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
local t_2 = {}
t_2.__index = t_2
local Ignore = ReplicatedStorage.Effects.Ignore

function t_2.new(
    arg4,
    arg5,
    arg6,
    arg7,
    arg8,
    arg9
) -- line: 39
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] Ignore (copy)
    --  [3] raycastParams (copy)
    --  [4] rng (copy)
    --  [5] os_clock (copy)
    --  [6] t_1 (copy)

    local t_3 = setmetatable({}, t_2)
    t_3.Active = true
    t_3.Parts = {}
    local v4 = arg4 or Ignore:Clone()
    local v5 = arg9 or v4.CFrame
    v4.CFrame = v5
    v5 = if v4.Name ~= "Ignore" then v4.Parent else arg8 or (workspace.Effects or v4.Parent)
    v4.Parent = v5

    if v4.Name == "Ignore" then
        _G.Debris(v4, 5)
    end

    local v6

    for index = 1, arg5 do
        local v7
        v6, v7 = getXAndZPositions(index * (6.283185307179586 / arg5), arg7)
        local P = (v4.CFrame * CFrame.new(v6, 0, v7)).p
        local Position = v4.Position
        local v6 = script.Part:Clone()
        v6.Name = "circleParts"
        v6.CFrame = CFrame.new(P, Position)
        local v9 = workspace:Raycast(v6.Position, Vector3.new(0, -10, 0), raycastParams)

        if v9 then
            if v9.Instance then
                local Material = v9.Material
                local v10 = v9.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(
                    Material
                ) or v9.Instance.Color
                v6.Color, v6.Transparency = v10, v9.Instance.Transparency
                v6.Material = Material

                if v9.Instance.MaterialVariant ~= "" then
                    v6.MaterialVariant = v9.Instance.MaterialVariant
                end

                local v11 = CFrame.new(v9.Position) * CFrame.new(0, -arg6.Y / 10, 0)
                v6.CFrame = v11 * CFrame.fromEulerAnglesXYZ(
                    rng:NextInteger(-25, 25),
                    0,
                    rng:NextInteger(-25, 25)
                )
                v6.Parent = arg8 or workspace.Effects
                local t_4 = { Size = nil }
                local Tween = _G.Tween
                local t_5 = { 0.2, "EntranceExpressive", Enum.EasingDirection.Out }
                local v14 = rng:NextNumber(1, 1.5)
                t_4.Size = arg6 - Vector3.new(v14, rng:NextNumber(1, 1.5), rng:NextNumber(1, 1.5))
                Tween(v6, t_5, t_4)
                task.delay(5, function() -- line: 82
                    -- upvalues:
                    --  [1] v6 (copy)

                    _G.Tween(
                        v6,
                        { 0.25, "Smooth", Enum.EasingDirection.Out },
                        { Transparency = 1, Size = Vector3.new(0, 0, 0) },
                        true
                    )
                end)
            else
                v6:Destroy()
            end
        else
            v6:Destroy()
        end

        t_3.Parts[index] = v6
    end

    t_3.StartT = os_clock()
    t_3.RefIndex = #t_1 + 1
    t_1[t_3.RefIndex] = t_3

    return t_3
end

function t_2.ConnectedCircle(arg10, ...) -- line: 99
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] Ignore (copy)
    --  [3] raycastParams (copy)
    --  [4] rng (copy)
    --  [5] os_clock (copy)
    --  [6] t_1 (copy)

    local t_6 = { ... }
    local v16 = t_6[1]
    local v17 = t_6[2]
    local v18 = t_6[3]
    local v19 = t_6[4]
    local v20 = t_6[5]
    local t_7 = setmetatable({}, t_2)
    t_7.Active = true
    t_7.Parts = {}
    local v21 = arg10 or Ignore:Clone()
    local v22 = v20 or v21.CFrame
    v21.CFrame = v22
    v22 = if v21.Name ~= "Ignore" then v21.Parent else v19 or (workspace.Effects or v21.Parent)
    v21.Parent = v22

    if v21.Name == "Ignore" then
        _G.Debris(v21, 5)
    end

    local v23

    for index_1 = 1, v16 do
        local v24
        v23, v24 = getXAndZPositions(index_1 * (6.283185307179586 / v16), v18)
        local P_1 = (v21.CFrame * CFrame.new(v23, 0, v24)).p
        local Position_1 = v21.Position
        local v23 = script.Part:Clone()
        v23.Name = "circleParts"
        v23.CFrame = CFrame.new(P_1, Position_1)
        local v26 = workspace:Raycast(v23.Position, Vector3.new(0, -10, 0), raycastParams)

        if v26 and v26.Instance then
            local Material_1 = v26.Material
            local v27 = v26.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(
                Material_1
            ) or v26.Instance.Color
            local Transparency = v26.Instance.Transparency
            local v28 = v17 * rng:NextInteger(50, 120) / 100
            local vec3 = Vector3.new(v18 / 1.5, v28, v28)
            v23.Color = v27
            v23.Transparency = Transparency
            v23.Material = Material_1

            if v26.Instance.MaterialVariant ~= "" then
                v23.MaterialVariant = v26.Instance.MaterialVariant
            end

            local v29 = v19 or workspace.Effects
            v23.Parent = v29
            _G.Tween(v23, { 0.2, "EntranceExpressive", Enum.EasingDirection.Out }, { Size = vec3 })
            v23.CFrame = CFrame.lookAt(v26.Position, v21.Position) * CFrame.new(0, -vec3.Y / 10, 0) * CFrame.fromEulerAnglesXYZ(
                0.7853981633974483,
                0,
                0
            )
            task.delay(5, function() -- line: 152
                -- upvalues:
                --  [1] v23 (copy)

                _G.Tween(
                    v23,
                    { 0.25, "Smooth", Enum.EasingDirection.Out },
                    { Transparency = 1, Size = Vector3.new(0, 0, 0) },
                    true
                )
            end)
        end

        t_7.Parts[index_1] = v23
    end

    t_7.StartT = os_clock()
    t_7.RefIndex = #t_1 + 1
    t_1[t_7.RefIndex] = t_7

    return t_7
end

function t_2.RockPath(arg11, ...) -- line: 167
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] Ignore (copy)
    --  [3] raycastParams (copy)
    --  [4] rng (copy)
    --  [5] os_clock (copy)
    --  [6] t_1 (copy)

    local t_9 = { ... }
    local v31 = t_9[1]
    local v32 = t_9[2]
    local v33 = t_9[3]
    local v34 = t_9[4]
    local v35 = t_9[5]
    local v36 = t_9[6]
    local t_10 = setmetatable({}, t_2)
    t_10.Active = true
    t_10.Parts = {}
    local v37 = arg11 or Ignore:Clone()
    local v38 = v35 or v37.CFrame
    v37.CFrame = v38
    v38 = if v37.Name ~= "Ignore" then v37.Parent else v34 or (workspace.Effects or v37.Parent)
    v37.Parent = v38

    if v37.Name == "Ignore" then
        _G.Debris(v37, 5)
    end

    for index_2 = 1, 2 do
        _G.FastSpawn(function() -- line: 188
            -- upvalues:
            --  [1] v33 (ref)
            --  [2] index_2 (copy)
            --  [3] v35 (copy)
            --  [4] v36 (copy)
            --  [5] v31 (copy)
            --  [6] raycastParams (ref)
            --  [7] rng (ref)
            --  [8] v34 (copy)
            --  [9] v32 (copy)
            --  [10] t_10 (copy)

            local v39 = if index_2 ~= 1 then -v33 else v33 or -v33
            v33 = v39
            v39 = (v35 * CFrame.new(v33, 0, v33)).Position
            local Position_2 = (v36 * CFrame.new(v33, 0, v33)).Position

            for index_3 = 0, v31 do
                local _ = v31
                local v43 = script.Part:Clone()
                v43.Name = "PathPart"
                local v44 = workspace:Raycast(
                    v39 + (Position_2 - v39).Unit * index_3 * (Position_2 - v39).Magnitude / v31,
                    Vector3.new(0, -10, 0),
                    raycastParams
                )

                if v44 then
                    if v44.Instance then
                        local Material_2 = v44.Material
                        local v45 = v44.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(
                            Material_2
                        ) or v44.Instance.Color
                        v43.Color, v43.Transparency = v45, v44.Instance.Transparency
                        v43.Material = Material_2

                        if v44.Instance.MaterialVariant ~= "" then
                            v43.MaterialVariant = v44.Instance.MaterialVariant
                        end

                        local cframe_2 = CFrame.new(v44.Position)
                        v43.CFrame = cframe_2 * CFrame.fromEulerAnglesXYZ(
                            rng:NextInteger(-25, 25),
                            0,
                            rng:NextInteger(-25, 25)
                        )
                        v43.Parent = v34 or workspace.Effects
                        local t_11 = { Size = nil }
                        local Tween_1 = _G.Tween
                        local t_12 = { 0.2, "EntranceExpressive", Enum.EasingDirection.Out }
                        local v48 = v32
                        local v49 = rng:NextNumber(-1, -1.5)
                        t_11.Size = v48 + Vector3.new(
                            v49,
                            rng:NextNumber(-1, -1.5),
                            rng:NextNumber(-1, -1.5)
                        )
                        Tween_1(v43, t_12, t_11)
                        task.delay(4, function() -- line: 221
                            -- upvalues:
                            --  [1] v43 (copy)

                            _G.Tween(
                                v43,
                                { 0.25, "Smooth", Enum.EasingDirection.Out },
                                { Transparency = 1, Size = Vector3.new(0, 0, 0) },
                                true
                            )
                        end)
                    else
                        v43:Destroy()
                    end
                else
                    v43:Destroy()
                end

                t_10.Parts[index_3] = v43
                task.wait()
            end
        end)
    end

    t_10.StartT = os_clock()
    t_10.RefIndex = #t_1 + 1
    t_1[t_10.RefIndex] = t_10

    return t_10
end

function t_2.Explosion(
    arg12,
    arg13,
    arg14,
    arg15,
    arg16,
    _,
    arg18
) -- line: 242
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] rng (copy)

    _G.FastSpawn(function() -- line: 243
        -- upvalues:
        --  [1] arg15 (copy)
        --  [2] ReplicatedStorage (ref)
        --  [3] arg18 (copy)
        --  [4] arg14 (copy)
        --  [5] arg12 (copy)
        --  [6] arg13 (copy)
        --  [7] rng (ref)
        --  [8] arg16 (copy)

        local Color = arg15.Color
        local Material_3 = arg15.Material
        local v51 = ReplicatedStorage.Effects:FindFirstChild(arg18 .. "Block")

        for _ = 1, arg14 do
            local _ = arg14
            _G.FastSpawn(function() -- line: 249
                -- upvalues:
                --  [1] v51 (copy)
                --  [2] arg12 (ref)
                --  [3] arg13 (ref)
                --  [4] rng (ref)
                --  [5] Material_3 (copy)
                --  [6] Color (copy)
                --  [7] arg16 (ref)
                --  [8] arg18 (ref)

                local v52 = v51:Clone()
                v52.Name = arg12.Name .. " briks"
                v52.CFrame = arg13 * CFrame.new(rng:NextInteger(-5, 5), 0, rng:NextInteger(-5, 5)) * CFrame.Angles(
                    rng:NextInteger(-45, 45),
                    rng:NextInteger(-45, 45),
                    rng:NextInteger(-45, 45)
                )
                v52.CanCollide = false
                v52.Anchored = false
                v52.Material = Material_3 or Enum.Material.Slate
                v52.TopSurface = Enum.SurfaceType.Smooth
                v52.BottomSurface = Enum.SurfaceType.Smooth
                local v59 = Color or Color3.fromRGB(30, 30, 30)
                v52.Color = v59
                local v60 = rng:NextInteger(arg16.Min, arg16.Max)
                local v61 = rng:NextInteger(arg16.Min, arg16.Max)
                v52.Size = Vector3.new(v60, v61, rng:NextInteger(arg16.Min, arg16.Max))
                local v62 = rng:NextInteger(-50, 50)
                local v63 = rng:NextInteger(60, 100)
                v52.Velocity = Vector3.new(v62, v63, rng:NextInteger(-50, 50))
                local BodyVelocity = Instance.new("BodyVelocity")
                BodyVelocity.Parent = v52
                local v64 = rng:NextInteger(-50, 50)
                local v65 = rng:NextInteger(60, 100)
                BodyVelocity.Velocity = Vector3.new(v64, v65, rng:NextInteger(-50, 50))

                if arg18 == "Smoke" then
                    for _, val in pairs(v52:GetDescendants()) do
                        if val:IsA("ParticleEmitter") then
                            val.Color = ColorSequence.new(Color)
                        end
                    end
                elseif arg18 == "Light" then
                    for _, val_1 in pairs(v52:GetDescendants()) do
                        if val_1:IsA("ParticleEmitter") and val_1.Name == "PartColor" then
                            val_1.Color = ColorSequence.new(Color)
                        end
                    end
                end

                v52.Parent = workspace.Effects
                BodyVelocity:Destroy()
                task.wait(3)

                for _, descendant in pairs(v52:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false
                    elseif descendant:IsA("PointLight") then
                        removelight(descendant)
                    end
                end

                _G.Tween(
                    v52,
                    { 0.5, "Smooth", Enum.EasingDirection.Out },
                    { Transparency = 1, Size = Vector3.new(0, 0, 0) },
                    true
                )
            end)
        end

        task.wait(0.2)

        for _, child in pairs(workspace.Effects:GetChildren()) do
            if child.Name == arg12.Name .. " briks" then
                child.CanCollide = true
            end
        end
    end)
end

function t_2.Destroy(arg19) -- line: 306
    -- upvalues:
    --  [1] t_1 (copy)

    t_1[arg19.RefIndex] = nil

    for index_5 = 1, #arg19.Parts do
        local _ = #arg19.Parts
        arg19.Parts[index_5]:Destroy()

        if index_5 % 100 == 0 then
            wait()
        end
    end
end

RunService.RenderStepped:Connect(function() -- line: 318
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] os_clock (copy)

    for _, val_2 in pairs(t_1) do
        if val_2.Active == true then
            if not (os_clock() - val_2.StartT < 8) then
                val_2:Destroy()
            end
        end
    end
end)

return t_2
