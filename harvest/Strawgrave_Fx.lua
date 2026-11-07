-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Halloween.Strawgrave_Fx
-- Class: ModuleScript
-- bytes: 47591

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")
local HalloweenFxUtil_m = require(script.Parent.HalloweenFxUtil)
local Assets = script.Assets
local _ = Color3.fromRGB(25, 0, 40)
local _ = Color3.fromRGB(150, 70, 255)
local color_2 = Color3.fromRGB(6, 0, 10)
local color_3 = Color3.fromRGB(95, 30, 170)
local color_4 = Color3.fromRGB(10, 2, 16)
local color_5 = Color3.fromRGB(150, 90, 220)
local color_6 = Color3.new(0, 0, 0)
local _ = Color3.fromRGB(120, 40, 160)
local v1 = 1
local t = { 1.5, -1.5, -2.5 }
local t_1 = {}

local _ = function(u1: userdata) --[[ get ]] -- line: 99
    -- upvalues:
    --  [1] t_1 (copy)

    local v2 = t_1[u1]

    if not v2 then
        v2 = { Crows = {} }
        t_1[u1] = v2
    end

    return v2
end

local _ = function(u2: userdata) --[[ anchored ]] -- line: 108
    u2.Anchored = true
    u2.CanCollide = false
    u2.CanQuery = false
    u2.CanTouch = false
    u2.CastShadow = false
end

local _ = function(u3: userdata) --[[ scytheCFrame ]] -- line: 118
    local Scythe = u3:FindFirstChild("Scythe")

    if not Scythe then
        return nil, nil
    end

    local WeaponHandleR = u3:FindFirstChild("WeaponHandle.R", true)

    if not WeaponHandleR then
        return Scythe.CFrame, nil
    end

    return WeaponHandleR.TransformedWorldCFrame * WeaponHandleR.WorldCFrame:Inverse() * Scythe.CFrame, WeaponHandleR
end

local cframe = CFrame.Angles(0, 0, -0.24434609527920614)
local _ = { Yaw = 3.001966313430247, Elevation = 0.5934119456780721, Scale = 0.9 }
local _ = { Yaw = 2.8797932657906435, Elevation = 0.3490658503988659 }
local _ = { Yaw = -2.181661564992912, Elevation = -0.12217304763960307 }
local t_6 = {
    Vector3.new(-3.6, -9.9, 0),
    Vector3.new(-3.5, -6.5, 0),
    Vector3.new(-3.4, -3, 0),
    Vector3.new(-3.5, 0.5, 0),
    Vector3.new(-3.7, 4, 0),
    Vector3.new(-3.9, 7.5, 0)
}
local t_7 = {
    Vector3.new(-3.9, 9.1, 0),
    Vector3.new(-1.2, 9.4, 0),
    Vector3.new(1.8, 7.9, 0),
    Vector3.new(3.6, 6.4, 0),
    Vector3.new(4.6, 4.5, 0)
}
local t_8 = { Vector3.new(-3.28, -8.76, 0), Vector3.new(-1.87, 8.56, 0) }
local t_9 = { 9, 14 }
local t_10 = { 12, 18 }
local t_11 = { 1.6, 2.4 }
local t_12 = { 4, 15 }
local t_13 = { Burst = 0.45 }
local t_14 = { Burst = 0.8 }
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.FilterDescendantsInstances = { workspace.Terrain, workspace:FindFirstChild("Map") }

local _ = function(vec1: Vector3) --[[ groundAt ]] -- line: 134
    -- upvalues:
    --  [1] raycastParams (copy)

    local v4 = workspace:Raycast(vec1 + Vector3.new(0, 8, 0), Vector3.new(0, -60, 0), raycastParams)

    return v4 and v4.Position or vec1
end

local _ = function(u4: userdata, b1: boolean) --[[ hideOwn ]] -- line: 146
    local Scythe_1 = u4:FindFirstChild("Scythe")

    if Scythe_1 and Scythe_1:IsA("BasePart") then
        Scythe_1.LocalTransparencyModifier = if not b1 then 0 else 1
    end
end

local function hideOwnTrails(u5: userdata, b2: boolean) -- line: 154
    local WeaponHandleR_1 = u5:FindFirstChild("WeaponHandle.R", true)

    for _, val in WeaponHandleR_1 and WeaponHandleR_1:GetDescendants() or {} do
        if val:IsA("Trail") then
            if b2 then
                if val:GetAttribute("ThrowWasEnabled") == nil then
                    val:SetAttribute("ThrowWasEnabled", val.Enabled)
                end

                val.Enabled = false
            elseif val:GetAttribute("ThrowWasEnabled") ~= nil then
                val.Enabled = val:GetAttribute("ThrowWasEnabled")
                val:SetAttribute("ThrowWasEnabled", nil)
            end
        end
    end
end

local _ = function(arg1) --[[ dropThrown ]] -- line: 171
    if arg1.Thrown then
        arg1.Thrown.Part:Destroy()
        arg1.Thrown.Loop:Disconnect()
        arg1.Thrown = nil
    end
end

local _ = function(vec2: Vector3, n1: number) --[[ spinning ]] -- line: 180
    return CFrame.new(vec2) * CFrame.Angles(0, n1 * 18.84955592153876, 0) * CFrame.Angles(
        1.5707963267948966,
        0,
        0
    )
end

local v9 = nil

local function throw(u6: userdata, arg2: any, vec3: Vector3, n2: number) -- line: 184
    -- upvalues:
    --  [1] hideOwnTrails (copy)
    --  [2] HalloweenFxUtil_m (copy)
    --  [3] Assets (copy)
    --  [4] v9 (ref)
    --  [5] RunService (copy)

    if arg2.Thrown then
        arg2.Thrown.Part:Destroy()
        arg2.Thrown.Loop:Disconnect()
        arg2.Thrown = nil
    end

    local Scythe_2 = u6:FindFirstChild("Scythe")
    local v10

    if not Scythe_2 then
        v10 = nil
    else
        local WeaponHandleR_2 = u6:FindFirstChild("WeaponHandle.R", true)
        v10 = if not WeaponHandleR_2 then Scythe_2.CFrame else WeaponHandleR_2.TransformedWorldCFrame * WeaponHandleR_2.WorldCFrame:Inverse() * Scythe_2.CFrame
    end

    local Scythe_3 = u6:FindFirstChild("Scythe")

    if Scythe_3 and Scythe_3:IsA("BasePart") then
        Scythe_3.LocalTransparencyModifier = 1
    end

    hideOwnTrails(u6, true)
    local v11 = v10 and v10.Position or vec3

    if not HalloweenFxUtil_m.Near(v11) and not HalloweenFxUtil_m.Near(vec3) then
        return
    end

    local v12 = Assets.Scythe:Clone()
    v12.Anchored = true
    v12.CanCollide = false
    v12.CanQuery = false
    v12.CanTouch = false
    v12.CastShadow = false
    local v13 = 1.25 * u6:GetScale()
    v12.Size *= v13
    v12.CFrame = v10 or CFrame.new(v11)
    v9(v12, u6, v13)

    for _, child in v12:GetChildren() do
        if child:IsA("Trail") then
            child.Enabled = true
        end
    end

    v12.Parent = workspace.Effects
    local t_16 = {
        Part = v12,
        From = v11,
        To = vec3,
        StartedAt = os.clock(),
        Time = n2,
        Loop = RunService.RenderStepped:Connect(function() -- line: 223
            -- upvalues:
            --  [1] t_16 (copy)
            --  [2] u6 (copy)
            --  [3] v12 (copy)
            --  [4] arg2 (copy)

            local clock = os.clock()
            local v20 = math.min((clock - t_16.StartedAt) / t_16.Time, 1)
            local v21 = t_16.To

            if t_16.Returning then
                local v22 = u6
                local Scythe_4 = v22:FindFirstChild("Scythe")
                local v23

                if not Scythe_4 then
                    v23 = nil
                else
                    local WeaponHandleR_3 = v22:FindFirstChild("WeaponHandle.R", true)
                    v23 = if not WeaponHandleR_3 then Scythe_4.CFrame else WeaponHandleR_3.TransformedWorldCFrame * WeaponHandleR_3.WorldCFrame:Inverse() * Scythe_4.CFrame
                end

                v22 = v23 and v23.Position or v21
                v21 = v22
            end

            local v24 = v12
            local v25 = t_16.From:Lerp(v21, v20)
            local clock_1 = os.clock()
            v24.CFrame = CFrame.new(v25) * CFrame.Angles(0, clock_1 * 18.84955592153876, 0) * CFrame.Angles(
                1.5707963267948966,
                0,
                0
            )

            if t_16.Returning and v20 >= 1 then
                local v27 = arg2

                if v27.Thrown then
                    v27.Thrown.Part:Destroy()
                    v27.Thrown.Loop:Disconnect()
                    v27.Thrown = nil
                end
            end
        end)
    }
    task.delay(n2, function() -- line: 210
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] t_16 (copy)
        --  [3] Assets (ref)
        --  [4] HalloweenFxUtil_m (ref)
        --  [5] vec3 (copy)
        --  [6] u6 (copy)

        local rng = Random.new()
        local v15 = 1

        while true do
            if arg2.Thrown ~= t_16 then
                break
            end

            if t_16.Returning then
                break
            end

            local v17 = Assets:FindFirstChild("Swing" .. v15)

            if v17 then
                local v18 = v17:GetAttribute("Offset") or CFrame.identity
                HalloweenFxUtil_m.PlaceScaled(
                    v17,
                    CFrame.new(vec3) * CFrame.Angles(0, rng:NextNumber(0, 6.283185307179586), 0) * v18.Rotation,
                    0.85 * u6:GetScale()
                )
            end

            v15 = v15 % 2 + 1
            task.wait(0.3)
        end
    end)
    arg2.Thrown = t_16
end

local function returnThrown(arg3: any, n3: number) -- line: 242
    -- upvalues:
    --  [1] TweenService (copy)

    local Thrown = arg3.Thrown

    if not Thrown then
        return
    end

    Thrown.From = Thrown.Part.Position
    Thrown.StartedAt = os.clock()
    Thrown.Time = n3
    Thrown.Returning = true
    TweenService:Create(Thrown.Part, TweenInfo.new(n3), { Transparency = 1 }):Play()
    task.delay(n3 * 0.6, function() -- line: 252
        -- upvalues:
        --  [1] Thrown (copy)

        for _, child_1 in Thrown.Part:GetChildren() do
            if child_1:IsA("Trail") then
                child_1.Enabled = false
            end
        end
    end)
end

local _ = function(arg4) --[[ stopAura ]] -- line: 265
    -- upvalues:
    --  [1] HalloweenFxUtil_m (copy)

    HalloweenFxUtil_m.Stop(arg4.Aura)
    HalloweenFxUtil_m.Stop(arg4.Charge)
    arg4.Aura, arg4.Charge = nil, nil
end

local _ = function(vec4: Vector3) --[[ newCrow ]] -- line: 271
    -- upvalues:
    --  [1] Assets (copy)
    --  [2] color_6 (copy)

    local v29 = Assets.Crow:Clone()
    v29.Anchored = true
    v29.CanCollide = false
    v29.CanQuery = false
    v29.CanTouch = false
    v29.CastShadow = false
    v29.Size *= 1.3
    v29.Color = color_6
    v29.Material = Enum.Material.Fabric
    v29.CFrame = CFrame.new(vec4)
    v29.Parent = workspace.Effects

    return v29
end

local _ = function(arg5, arg6) --[[ removeCrow ]] -- line: 282
    local v30 = table.find(arg5.Crows, arg6)

    if v30 then
        table.remove(arg5.Crows, v30)
    end

    arg6.Loop:Disconnect()
end

local function riseCrows(u7: userdata, arg7: any, n4: number) -- line: 291
    -- upvalues:
    --  [1] raycastParams (copy)
    --  [2] t_9 (copy)
    --  [3] t_10 (copy)
    --  [4] t_11 (copy)
    --  [5] t_12 (copy)
    --  [6] Assets (copy)
    --  [7] color_6 (copy)
    --  [8] RunService (copy)
    --  [9] HalloweenFxUtil_m (copy)
    --  [10] TweenService (copy)

    local rng_1 = Random.new()
    local HumanoidRootPart = u7:FindFirstChild("HumanoidRootPart")

    if not HumanoidRootPart then
        return
    end

    local Position = HumanoidRootPart.Position
    local v32 = workspace:Raycast(
        Position + Vector3.new(0, 8, 0),
        Vector3.new(0, -60, 0),
        raycastParams
    )
    local _ = (v32 and v32.Position or Position).Y
    local v34 = u7:GetScale()

    for index = 1, n4 do
        local t_17 = {
            Angle = index / n4 * 3.141592653589793 * 2 + rng_1:NextNumber(-0.3, 0.3),
            Radius = rng_1:NextNumber(t_9[1], t_9[2]) * v34,
            Height = rng_1:NextNumber(t_10[1], t_10[2]) * v34,
            Speed = nil,
            Bob = nil,
            BornAt = nil
        }
        local v37 = rng_1:NextNumber(t_11[1], t_11[2])
        t_17.Speed = v37 * (if rng_1:NextNumber() < 0.15 then -1 else 1)
        t_17.Bob = rng_1:NextNumber(0, 6.283185307179586)
        t_17.BornAt = os.clock() + rng_1:NextNumber(0, 0.55)
        local v39 = rng_1:NextNumber(t_12[1], t_12[2]) * v34
        local vec3_1 = Vector3.new(math.cos(t_17.Angle) * v39, 0, math.sin(t_17.Angle) * v39)
        local v41 = HumanoidRootPart.Position + vec3_1
        local v43 = workspace:Raycast(
            v41 + Vector3.new(0, 8, 0),
            Vector3.new(0, -60, 0),
            raycastParams
        )
        v39 = v43 and v43.Position or v41
        t_17.Emerge = vec3_1
        t_17.EmergeY = v39.Y - HumanoidRootPart.Position.Y
        local v44 = v39 - Vector3.new(0, 2, 0)
        local v45 = Assets.Crow:Clone()
        v45.Anchored = true
        v45.CanCollide = false
        v45.CanQuery = false
        v45.CanTouch = false
        v45.CastShadow = false
        v45.Size *= 1.3
        v45.Color = color_6
        v45.Material = Enum.Material.Fabric
        v45.CFrame = CFrame.new(v44)
        v45.Parent = workspace.Effects
        t_17.Part = v45
        t_17.Part.Transparency = 1
        t_17.Born = false
        t_17.Loop = RunService.RenderStepped:Connect(function(deltaTime) -- line: 317
            -- upvalues:
            --  [1] t_17 (copy)
            --  [2] arg7 (copy)
            --  [3] HalloweenFxUtil_m (ref)
            --  [4] u7 (copy)
            --  [5] Assets (ref)
            --  [6] TweenService (ref)

            local Part_1 = t_17.Part

            if not Part_1.Parent then
                local v46 = arg7
                local v47 = t_17
                local v48 = table.find(v46.Crows, v47)

                if v48 then
                    table.remove(v46.Crows, v48)
                end

                v47.Loop:Disconnect()

                return
            end

            if t_17.Dive then
                local Dive = t_17.Dive
                local v49 = math.min((os.clock() - Dive.StartedAt) / Dive.Time, 1)
                local v50 = Dive.From:Lerp(Dive.Over, v49)
                local v51 = Dive.Over:Lerp(Dive.To, v49)
                local v52 = v50:Lerp(v51, v49)
                local v53 = v51 - v50
                Part_1.CFrame = v53.Magnitude > 0.01 and CFrame.lookAt(v52, v52 + v53) or CFrame.new(
                    v52
                )

                if v49 >= 1 then
                    local v55 = arg7
                    local v56 = t_17
                    local v57 = table.find(v55.Crows, v56)

                    if v57 then
                        table.remove(v55.Crows, v57)
                    end

                    v56.Loop:Disconnect()
                    HalloweenFxUtil_m.FadeOut(Part_1, 0.1)
                end

                return
            end

            if t_17.Scatter then
                local Scatter = t_17.Scatter
                local v58 = math.min((os.clock() - Scatter.StartedAt) / Scatter.Time, 1)
                Part_1.CFrame = CFrame.lookAt(
                    Scatter.From:Lerp(Scatter.To, v58),
                    Scatter.To + (Scatter.To - Scatter.From)
                )

                if v58 >= 1 then
                    local v60 = arg7
                    local v61 = t_17
                    local v62 = table.find(v60.Crows, v61)

                    if v62 then
                        table.remove(v60.Crows, v62)
                    end

                    v61.Loop:Disconnect()
                    Part_1:Destroy()
                end

                return
            end

            local HumanoidRootPart_1 = u7:FindFirstChild("HumanoidRootPart")

            if not HumanoidRootPart_1 then
                return
            end

            local clock_5 = os.clock()

            if clock_5 < t_17.BornAt then
                return
            end

            if not t_17.Born then
                t_17.Born = true
                Part_1.Transparency = 0
                HalloweenFxUtil_m.PlaceAtPoint(
                    Assets.CrowBurst,
                    HumanoidRootPart_1.Position + t_17.Emerge + Vector3.new(0, t_17.EmergeY, 0),
                    nil,
                    0.35
                )
            end

            local v64 = math.min((clock_5 - t_17.BornAt) / 0.9, 1)

            if v64 >= 1 then
                local v65 = t_17
                v65.Angle += t_17.Speed * deltaTime
            end

            local v66 = TweenService:GetValue(v64, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local v68 = math.cos(t_17.Angle) * t_17.Radius
            local v69 = t_17.Height + math.sin(clock_5 * 3 + t_17.Bob) * 0.8
            local vec3_2 = Vector3.new(v68, v69, math.sin(t_17.Angle) * t_17.Radius)
            local v71 = t_17.Emerge + Vector3.new(0, t_17.EmergeY, 0)
            local v75 = HumanoidRootPart_1.Position + Vector3.new(
                v71.X + (vec3_2.X - v71.X) * v66,
                v71.Y + (vec3_2.Y - v71.Y) * TweenService:GetValue(
                    math.min(v64 * 1.6, 1),
                    Enum.EasingStyle.Sine,
                    Enum.EasingDirection.Out
                ),
                v71.Z + (vec3_2.Z - v71.Z) * v66
            )
            local v76 = t_17.LastPosition or v75 - Vector3.new(0, 1, 0)
            t_17.LastPosition = v75

            if v64 < 1 then
                local v77 = v75 - v76
                Part_1.CFrame = v77.Magnitude > 0.01 and CFrame.lookAt(v75, v75 + v77) or CFrame.new(
                    v75
                )

                return
            end

            local v79 = -math.sin(t_17.Angle)
            Part_1.CFrame = CFrame.lookAt(
                v75,
                v75 + Vector3.new(v79, 0, (math.cos(t_17.Angle))) * math.sign(t_17.Speed)
            ) * CFrame.Angles(0, 0, math.sign(t_17.Speed) * -0.3490658503988659)
        end)
        table.insert(arg7.Crows, t_17)
    end
end

local _ = function(vec5: Vector3, arg9: any) --[[ crowImpact ]] -- line: 394
    -- upvalues:
    --  [1] HalloweenFxUtil_m (copy)
    --  [2] Assets (copy)

    if not HalloweenFxUtil_m.Near(vec5) then
        return
    end

    HalloweenFxUtil_m.PlaceAtPoint(Assets.CrowBurst, vec5, nil, arg9.Burst)
end

local function shootCrows(arg10) -- line: 402
    -- upvalues:
    --  [1] HalloweenFxUtil_m (copy)
    --  [2] Assets (copy)
    --  [3] color_6 (copy)
    --  [4] RunService (copy)
    --  [5] t_13 (copy)

    local _

    for _, val_1 in arg10 do
        local v81 = val_1[1]
        local v82 = val_1[2]
        local v83 = math.max(val_1[3], 0.05)

        if not HalloweenFxUtil_m.Near(v81) then
            if HalloweenFxUtil_m.Near(v82) then
                local v84 = Assets.Crow:Clone()
                v84.Anchored = true
                v84.CanCollide = false
                v84.CanQuery = false
                v84.CanTouch = false
                v84.CastShadow = false
                v84.Size *= 1.3
                v84.Color = color_6
                v84.Material = Enum.Material.Fabric
                v84.CFrame = CFrame.new(v81)
                v84.Parent = workspace.Effects
                v84.Size *= 1.6
                local clock_6 = os.clock()
                local v86 = v81:Lerp(v82, 0.4) + Vector3.new(0, 9, 0)

                _ = function(n5: number) --[[ at ]] -- line: 413
                    -- upvalues:
                    --  [1] v81 (copy)
                    --  [2] v86 (copy)
                    --  [3] v82 (copy)

                    return v81:Lerp(v86, n5):Lerp(v86:Lerp(v82, n5), n5)
                end

                local v89 = v81
                local v90 = nil
                v90 = RunService.RenderStepped:Connect(function() -- line: 418
                    -- upvalues:
                    --  [1] clock_6 (copy)
                    --  [2] v83 (copy)
                    --  [3] v81 (copy)
                    --  [4] v86 (copy)
                    --  [5] v82 (copy)
                    --  [6] v89 (ref)
                    --  [7] v84 (copy)
                    --  [8] v90 (ref)
                    --  [9] t_13 (ref)
                    --  [10] HalloweenFxUtil_m (ref)
                    --  [11] Assets (ref)

                    local v91 = math.min((os.clock() - clock_6) / v83, 1)
                    local v92 = v81:Lerp(v86, v91):Lerp(v86:Lerp(v82, v91), v91)
                    local v94 = v92 - v89
                    v89 = v92
                    local v95 = v84
                    v95.CFrame = v94.Magnitude > 0.01 and CFrame.lookAt(v92, v92 + v94) or CFrame.new(
                        v92
                    )

                    if v91 >= 1 then
                        v90:Disconnect()
                        local v97 = v82
                        local v98 = t_13

                        if HalloweenFxUtil_m.Near(v97) then
                            HalloweenFxUtil_m.PlaceAtPoint(Assets.CrowBurst, v97, nil, v98.Burst)
                        end

                        HalloweenFxUtil_m.FadeOut(v84, 0.08)
                    end
                end)
            end
        else
            local v84 = Assets.Crow:Clone()
            v84.Anchored = true
            v84.CanCollide = false
            v84.CanQuery = false
            v84.CanTouch = false
            v84.CastShadow = false
            v84.Size *= 1.3
            v84.Color = color_6
            v84.Material = Enum.Material.Fabric
            v84.CFrame = CFrame.new(v81)
            v84.Parent = workspace.Effects
            v84.Size *= 1.6
            local clock_6 = os.clock()
            local v86 = v81:Lerp(v82, 0.4) + Vector3.new(0, 9, 0)

            _ = function(n6: number) --[[ at ]] -- line: 413
                -- upvalues:
                --  [1] v81 (copy)
                --  [2] v86 (copy)
                --  [3] v82 (copy)

                return v81:Lerp(v86, n6):Lerp(v86:Lerp(v82, n6), n6)
            end

            local v89 = v81
            local v90 = nil
            v90 = RunService.RenderStepped:Connect(function() -- line: 418
                -- upvalues:
                --  [1] clock_6 (copy)
                --  [2] v83 (copy)
                --  [3] v81 (copy)
                --  [4] v86 (copy)
                --  [5] v82 (copy)
                --  [6] v89 (ref)
                --  [7] v84 (copy)
                --  [8] v90 (ref)
                --  [9] t_13 (ref)
                --  [10] HalloweenFxUtil_m (ref)
                --  [11] Assets (ref)

                local v103 = math.min((os.clock() - clock_6) / v83, 1)
                local v104 = v81:Lerp(v86, v103):Lerp(v86:Lerp(v82, v103), v103)
                local v106 = v104 - v89
                v89 = v104
                local v107 = v84
                v107.CFrame = v106.Magnitude > 0.01 and CFrame.lookAt(v104, v104 + v106) or CFrame.new(
                    v104
                )

                if v103 >= 1 then
                    v90:Disconnect()
                    local v109 = v82
                    local v110 = t_13

                    if HalloweenFxUtil_m.Near(v109) then
                        HalloweenFxUtil_m.PlaceAtPoint(Assets.CrowBurst, v109, nil, v110.Burst)
                    end

                    HalloweenFxUtil_m.FadeOut(v84, 0.08)
                end
            end)
        end
    end
end

local function disperseCrows(arg11) -- line: 433
    -- upvalues:
    --  [1] HalloweenFxUtil_m (copy)

    local rng_2 = Random.new()

    for _, val_2 in arg11.Crows do
        if not val_2.Dive and not val_2.Scatter then
            local Position_1 = val_2.Part.Position
            local vec3_4 = Vector3.new(rng_2:NextNumber(-1, 1), 0, rng_2:NextNumber(-1, 1))
            local v111 = vec3_4.Magnitude > 0.01 and vec3_4.Unit or Vector3.new(1, 0, 0)
            local v112 = v111
            v111 = {
                From = Position_1,
                To = Position_1 + v112 * rng_2:NextNumber(30, 45) + Vector3.new(
                    0,
                    rng_2:NextNumber(15, 25),
                    0
                ),
                StartedAt = os.clock(),
                Time = rng_2:NextNumber(0.8, 1.2)
            }
            val_2.Scatter = v111
            HalloweenFxUtil_m.FadeOut(val_2.Part, val_2.Scatter.Time)
        end
    end
end

local function fadeShadow(arg12) -- line: 455
    -- upvalues:
    --  [1] TweenService (copy)
    --  [2] HalloweenFxUtil_m (copy)

    local Shadow = arg12.Shadow

    if not Shadow then
        return
    end

    arg12.Shadow = nil
    TweenService:Create(Shadow.Part, TweenInfo.new(0.35), { Transparency = 1 }):Play()
    HalloweenFxUtil_m.RemoveHighlight(Shadow.Highlight)

    for _, descendant in Shadow.Part:GetDescendants() do
        if not descendant:IsA("ParticleEmitter") then
            if descendant:IsA("Trail") then
                descendant.Enabled = false
            end
        else
            descendant.Enabled = false
        end
    end

    task.delay(1, function() -- line: 468
        -- upvalues:
        --  [1] Shadow (copy)

        Shadow.Loop:Disconnect()
        Shadow.Part:Destroy()
    end)
end

local _ = function(u8: userdata) --[[ levelRoot ]] -- line: 475
    local v116 = u8.CFrame.LookVector
    v116 = Vector3.new(v116.X, 0, v116.Z)

    if v116.Magnitude < 0.1 then
        v116 = Vector3.new(0, 0, -1)
    end

    return CFrame.lookAt(u8.Position, u8.Position + v116)
end

local function reapPose(
    u9: CFrame,
    n7: number,
    n8: number,
    n9: number,
    n10: number
) -- line: 486
    -- upvalues:
    --  [1] v1 (ref)

    local v118 = math.sin(n7) * math.cos(n8)
    local v119 = math.sin(n8)
    local v120 = -math.cos(n7)
    local v121 = u9:VectorToWorldSpace((Vector3.new(v118, v119, v120 * math.cos(n8))))
    local v122 = -math.cos(n7)
    local v123 = u9:VectorToWorldSpace((Vector3.new(v122, 0, -math.sin(n7))))
    local v124 = math.sin(n7)
    local v125 = u9:VectorToWorldSpace((Vector3.new(v124, 0, -math.cos(n7))))
    local v126 = u9.Position + v125 * 1.5 * v1
    local v127 = Vector3.new(-3.6, -9.9, 0) * (v1 * 2.1) * n10

    return CFrame.fromMatrix(
        v126 + Vector3.new(0, n9 * v1, 0) - v123 * v127.X - v121 * v127.Y,
        v123,
        v121
    )
end

local function ownTrails(u10: userdata) -- line: 501
    local WeaponHandleR_4 = u10:FindFirstChild("WeaponHandle.R", true)
    local t_18 = {}
    local t_19 = {}

    for _, val_3 in WeaponHandleR_4 and WeaponHandleR_4:GetDescendants() or {} do
        if val_3:IsA("Trail") and val_3.Attachment0 and not t_19[val_3.Texture] then
            t_19[val_3.Texture] = true
            table.insert(t_18, val_3)
        end
    end

    return t_18
end

function v9(u11: userdata, u12: userdata, n11: number?) --[[ addTrails ]] -- line: 515
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] ownTrails (copy)
    --  [3] t_8 (copy)
    --  [4] color_2 (copy)

    local v129 = n11 or v1 * 2.1
    n11 = v129
    v129 = ownTrails(u12)

    if #v129 > 0 then
        for key_7, val_4 in t_8 do
            local Attachment = Instance.new("Attachment")
            Attachment.Name = "TrailA" .. key_7
            Attachment.Position = (val_4 - Vector3.new(0, 0, 0.77)) * n11
            Attachment.Parent = u11
            local Attachment_1 = Instance.new("Attachment")
            Attachment_1.Name = "TrailB" .. key_7
            Attachment_1.Position = (val_4 + Vector3.new(0, 0, 0.77)) * n11
            Attachment_1.Parent = u11

            for _, val_5 in v129 do
                local v130 = val_5:Clone()
                v130.Name = "ReapTrail"
                v130.Attachment0 = Attachment
                v130.Attachment1 = Attachment_1

                if v130.TextureMode ~= Enum.TextureMode.Stretch then
                    v130.TextureLength *= n11
                end

                v130.Enabled = false
                v130.Parent = u11
            end
        end

        return
    end

    local BladeShadow = u11:FindFirstChild("BladeShadow")
    local v131 = nil

    for _, child_2 in u11:GetChildren() do
        if child_2.Name == "BladeShadow" then
            v131 = child_2
        end
    end

    local ReapTrail_Trail = Instance.new("Trail")
    ReapTrail_Trail.Name = "ReapTrail"
    ReapTrail_Trail.Attachment0 = BladeShadow
    ReapTrail_Trail.Attachment1 = v131
    ReapTrail_Trail.Color = ColorSequence.new(Color3.fromRGB(14, 6, 20), color_2)
    ReapTrail_Trail.Transparency = NumberSequence.new(
        { NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(1, 1) }
    )
    ReapTrail_Trail.LightEmission = 0
    ReapTrail_Trail.LightInfluence = 0
    ReapTrail_Trail.Lifetime = 0.22
    ReapTrail_Trail.MinLength = 0.1
    ReapTrail_Trail.Enabled = false
    ReapTrail_Trail.Parent = u11
end

local function shroud(u13: userdata, u14: userdata) -- line: 565
    -- upvalues:
    --  [1] color_4 (copy)
    --  [2] color_3 (copy)
    --  [3] t_6 (copy)
    --  [4] v1 (ref)
    --  [5] t_7 (copy)
    --  [6] v9 (ref)

    local function emitters(u15: userdata, n12: number) -- line: 566
        -- upvalues:
        --  [1] color_4 (ref)
        --  [2] color_3 (ref)

        local ShadowSmoke_ParticleEmitter = Instance.new("ParticleEmitter")
        ShadowSmoke_ParticleEmitter.Name = "ShadowSmoke"
        ShadowSmoke_ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds"
        ShadowSmoke_ParticleEmitter.Color = ColorSequence.new(color_4)
        ShadowSmoke_ParticleEmitter.LightEmission = 0
        ShadowSmoke_ParticleEmitter.LightInfluence = 0
        ShadowSmoke_ParticleEmitter.Brightness = 1
        ShadowSmoke_ParticleEmitter.Size = NumberSequence.new(
            { NumberSequenceKeypoint.new(0, 2), NumberSequenceKeypoint.new(1, 5.5) }
        )
        ShadowSmoke_ParticleEmitter.Transparency = NumberSequence.new(
            {
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.15, 0.35),
                NumberSequenceKeypoint.new(1, 1)
            }
        )
        ShadowSmoke_ParticleEmitter.Lifetime = NumberRange.new(0.45, 0.85)
        ShadowSmoke_ParticleEmitter.Rate = n12
        ShadowSmoke_ParticleEmitter.Speed = NumberRange.new(0.5, 2)
        ShadowSmoke_ParticleEmitter.SpreadAngle = Vector2.new(180, 180)
        ShadowSmoke_ParticleEmitter.Drag = 3
        ShadowSmoke_ParticleEmitter.Acceleration = Vector3.new(0, 3, 0)
        ShadowSmoke_ParticleEmitter.Rotation = NumberRange.new(0, 360)
        ShadowSmoke_ParticleEmitter.RotSpeed = NumberRange.new(-50, 50)
        ShadowSmoke_ParticleEmitter.LockedToPart = false
        ShadowSmoke_ParticleEmitter.Parent = u15
        local ParticleEmitter_1 = Instance.new("ParticleEmitter")
        ParticleEmitter_1.Name = "ShadowEmbers"
        ParticleEmitter_1.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        ParticleEmitter_1.Color = ColorSequence.new(color_3)
        ParticleEmitter_1.LightEmission = 1
        ParticleEmitter_1.Size = NumberSequence.new(
            { NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 0) }
        )
        ParticleEmitter_1.Transparency = NumberSequence.new(0.2)
        ParticleEmitter_1.Lifetime = NumberRange.new(0.3, 0.6)
        ParticleEmitter_1.Rate = n12 * 0.35
        ParticleEmitter_1.Speed = NumberRange.new(1, 3)
        ParticleEmitter_1.SpreadAngle = Vector2.new(180, 180)
        ParticleEmitter_1.Drag = 2
        ParticleEmitter_1.Parent = u15
    end

    for _, val_6 in t_6 do
        local Attachment_2 = Instance.new("Attachment")
        Attachment_2.Name = "HandleShadow"
        Attachment_2.Position = val_6 * (v1 * 2.1)
        Attachment_2.Parent = u13
        emitters(Attachment_2, 14)
    end

    for _, val_7 in t_7 do
        local Attachment_3 = Instance.new("Attachment")
        Attachment_3.Name = "BladeShadow"
        Attachment_3.Position = val_7 * (v1 * 2.1)
        Attachment_3.Parent = u13
        emitters(Attachment_3, 22)
    end

    v9(u13, u14)
end

local function raiseShadow(u16: userdata, arg13: any, n13: number?) -- line: 624
    -- upvalues:
    --  [1] fadeShadow (copy)
    --  [2] v1 (ref)
    --  [3] Assets (copy)
    --  [4] color_2 (copy)
    --  [5] color_3 (copy)
    --  [6] TweenService (copy)
    --  [7] shroud (copy)
    --  [8] reapPose (copy)
    --  [9] t (copy)
    --  [10] RunService (copy)

    fadeShadow(arg13)
    local HumanoidRootPart_2 = u16:FindFirstChild("HumanoidRootPart")

    if not HumanoidRootPart_2 then
        return
    end

    v1 = u16:GetScale()
    local v135 = math.max(n13 or 0.3, 0.05)
    local v136 = Assets.Scythe:Clone()

    for _, child_3 in v136:GetChildren() do
        if child_3:IsA("SurfaceAppearance") then
            child_3:Destroy()
        end
    end

    v136.TextureID = ""
    v136.Anchored = true
    v136.CanCollide = false
    v136.CanQuery = false
    v136.CanTouch = false
    v136.CastShadow = false
    local v137 = v136.Size * (v1 * 2.1)
    v136.Size = v137 * 0.9
    v136.Color = color_2
    v136.Material = Enum.Material.SmoothPlastic
    v136.Reflectance = 0
    v136.Transparency = 1
    local Highlight = Instance.new("Highlight")
    Highlight.FillColor = color_2
    Highlight.OutlineColor = color_3
    Highlight.FillTransparency = 1
    Highlight.OutlineTransparency = 1
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.Adornee = v136
    Highlight.Parent = v136
    local tweenInfo_2 = TweenInfo.new((math.min(v135, 0.2)))
    TweenService:Create(
        Highlight,
        tweenInfo_2,
        { FillTransparency = 0.05, OutlineTransparency = 0.3 }
    ):Play()
    TweenService:Create(v136, tweenInfo_2, { Transparency = 0.1 }):Play()
    shroud(v136, u16)
    local clock_7 = os.clock()

    local function follow() -- line: 663
        -- upvalues:
        --  [1] HumanoidRootPart_2 (copy)
        --  [2] clock_7 (copy)
        --  [3] v135 (ref)
        --  [4] TweenService (ref)
        --  [5] v136 (copy)
        --  [6] v137 (copy)
        --  [7] reapPose (ref)
        --  [8] t (ref)

        if not HumanoidRootPart_2.Parent then
            return
        end

        local v139 = TweenService:GetValue(
            math.min((os.clock() - clock_7) / v135, 1),
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.Out
        )
        local v140 = 0.9 + 0.09999999999999998 * v139
        v136.Size = v137 * v140

        for _, child_4 in v136:GetChildren() do
            local v141 = child_4:IsA("Attachment")

            if v141 then
                v141 = child_4:GetAttribute("Point")
            end

            if typeof(v141) == "Vector3" then
                child_4.Position = v141 * v140
            end
        end

        local v142 = HumanoidRootPart_2
        local v143 = v142.CFrame.LookVector
        local v144 = v136
        local v145 = reapPose
        v143 = Vector3.new(v143.X, 0, v143.Z)

        if v143.Magnitude < 0.1 then
            v143 = Vector3.new(0, 0, -1)
        end

        v144.CFrame = v145(
            CFrame.lookAt(v142.Position, v142.Position + v143),
            3.001966313430247 + -0.12217304763960346 * v139,
            0.5934119456780721 + -0.2443460952792062 * v139,
            t[1],
            v140
        )
    end

    for _, child_5 in v136:GetChildren() do
        if child_5:IsA("Attachment") then
            child_5:SetAttribute("Point", child_5.Position)
        end
    end

    follow()
    v136.Parent = workspace.Effects
    arg13.Shadow = {
        Part = v136,
        Highlight = Highlight,
        Loop = RunService.RenderStepped:Connect(follow)
    }
end

local function sweepShadow(u17: userdata, arg14: any, n14: number) -- line: 702
    -- upvalues:
    --  [1] Assets (copy)
    --  [2] v1 (ref)
    --  [3] RunService (copy)
    --  [4] TweenService (copy)
    --  [5] t (copy)
    --  [6] reapPose (copy)

    local Shadow_1 = arg14.Shadow
    local HumanoidRootPart_3 = u17:FindFirstChild("HumanoidRootPart")

    if not Shadow_1 or not HumanoidRootPart_3 then
        return
    end

    Shadow_1.Loop:Disconnect()
    local Part_3 = Shadow_1.Part
    local v148 = HumanoidRootPart_3.CFrame.LookVector
    v148 = Vector3.new(v148.X, 0, v148.Z)

    if v148.Magnitude < 0.1 then
        v148 = Vector3.new(0, 0, -1)
    end

    local cframe_5 = CFrame.lookAt(HumanoidRootPart_3.Position, HumanoidRootPart_3.Position + v148)
    local v149 = math.max(n14, 0.03)
    local v150

    if Part_3.Size.Y / (Assets.Scythe.Size.Y * (v1 * 2.1)) < 0.999 then
        Part_3.Size = Assets.Scythe.Size * (v1 * 2.1)

        for _, child_6 in Part_3:GetChildren() do
            v150 = child_6:IsA("Attachment")

            if v150 then
                v150 = child_6:GetAttribute("Point")
            end

            if typeof(v150) == "Vector3" then
                child_6.Position = v150
            end
        end
    end

    local t_25 = {}

    for _, child_7 in Part_3:GetChildren() do
        local _ = typeof(v150)

        if child_7:IsA("Trail") and child_7.Name == "ReapTrail" then
            child_7.Enabled = true
            table.insert(t_25, child_7)
        end
    end

    local clock_8 = os.clock()
    Shadow_1.Loop = RunService.RenderStepped:Connect(function() -- line: 733
        -- upvalues:
        --  [1] clock_8 (copy)
        --  [2] v149 (ref)
        --  [3] TweenService (ref)
        --  [4] t (ref)
        --  [5] t_25 (copy)
        --  [6] Part_3 (copy)
        --  [7] reapPose (ref)
        --  [8] cframe_5 (copy)

        local v152 = os.clock() - clock_8
        local v155, v156, v157

        if v152 < v149 then
            local v154 = TweenService:GetValue(
                v152 / v149,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.In
            )
            v155 = 2.8797932657906435 * (1 - v154)
            v156 = 0.3490658503988659 + -0.3141592653589793 * v154
            v157 = t[1] + (t[2] - t[1]) * v154
        else
            local v158 = TweenService:GetValue(
                math.min((v152 - v149) / 0.24, 1),
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            )
            v155 = -2.181661564992912 * v158
            v156 = 0.03490658503988659 + -0.15707963267948966 * v158
            v157 = t[2] + (t[3] - t[2]) * v158

            if v158 >= 1 then
                for _, val_8 in t_25 do
                    val_8.Enabled = false
                end
            end
        end

        Part_3.CFrame = reapPose(
            cframe_5,
            v155,
            v156,
            v157,
            1
        )
    end)
end

local v160 = 0

local function fear(u18: userdata, n15: number) -- line: 765
    -- upvalues:
    --  [1] HalloweenFxUtil_m (copy)
    --  [2] color_5 (copy)
    --  [3] Players (copy)
    --  [4] v160 (ref)
    --  [5] Lighting (copy)
    --  [6] TweenService (copy)
    --  [7] Debris (copy)

    local HumanoidRootPart_4 = u18:FindFirstChild("HumanoidRootPart")
    local tweenInfo_3

    if HumanoidRootPart_4 then
        if not HalloweenFxUtil_m.Near(HumanoidRootPart_4.Position) then
            return
        end

        HalloweenFxUtil_m.Tint(u18, color_5, 0.55, n15)

        if u18 ~= Players.LocalPlayer.Character then
            return
        end

        v160 += 1
        local v162 = v160
        local v163 = Lighting:FindFirstChild("HalloweenFear")

        if not v163 then
            v163 = Instance.new("ColorCorrectionEffect")
        end

        v163.Name = "HalloweenFear"
        v163.Parent = Lighting
        local v164 = TweenService
        tweenInfo_3 = TweenInfo.new(0.15)
        v164:Create(
            v163,
            tweenInfo_3,
            { Saturation = -0.6, Contrast = 0.15, TintColor = Color3.fromRGB(205, 190, 255) }
        ):Play()
        HalloweenFxUtil_m.Shake(HumanoidRootPart_4.Position, 2.5, 14, 0.6)
        task.delay(n15, function() -- line: 786
            -- upvalues:
            --  [1] v162 (copy)
            --  [2] v160 (ref)
            --  [3] v163 (copy)
            --  [4] TweenService (ref)
            --  [5] Debris (ref)

            if v162 ~= v160 or not v163.Parent then
                return
            end

            TweenService:Create(
                v163,
                TweenInfo.new(0.4),
                { Saturation = 0, Contrast = 0, TintColor = Color3.new(1, 1, 1) }
            ):Play()
            Debris:AddItem(v163, 0.45)
        end)

        return
    else
        return
    end
end

return function(u19: userdata, arg15: any, ...) -- line: 801
    -- upvalues:
    --  [1] fear (copy)
    --  [2] t_1 (copy)
    --  [3] hideOwnTrails (copy)
    --  [4] returnThrown (copy)
    --  [5] fadeShadow (copy)
    --  [6] HalloweenFxUtil_m (copy)
    --  [7] disperseCrows (copy)
    --  [8] shootCrows (copy)
    --  [9] t_14 (copy)
    --  [10] Assets (copy)
    --  [11] throw (copy)
    --  [12] riseCrows (copy)
    --  [13] raiseShadow (copy)
    --  [14] sweepShadow (copy)
    --  [15] cframe (copy)

    if arg15 == "Fear" then
        fear(u19, ...)

        return
    end

    local v171 = t_1[u19]

    if not v171 then
        v171 = { Crows = {} }
        t_1[u19] = v171
    end

    if arg15 == "Caught" then
        if v171.Thrown then
            v171.Thrown.Part:Destroy()
            v171.Thrown.Loop:Disconnect()
            v171.Thrown = nil
        end

        local Scythe_5 = u19:FindFirstChild("Scythe")

        if Scythe_5 and Scythe_5:IsA("BasePart") then
            Scythe_5.LocalTransparencyModifier = 0
        end

        return
    end

    if arg15 == "ThrowDone" then
        hideOwnTrails(u19, false)

        return
    end

    if arg15 == "Return" then
        returnThrown(v171, ...)

        return
    end

    if arg15 == "ReapFade" then
        fadeShadow(v171)

        return
    end

    if arg15 == "CrowsDisperse" then
        HalloweenFxUtil_m.Stop(v171.Aura)
        HalloweenFxUtil_m.Stop(v171.Charge)
        v171.Aura, v171.Charge = nil, nil
        disperseCrows(v171)

        return
    end

    if arg15 == "CrowShots" then
        shootCrows((...))

        return
    end

    if arg15 == "CrowHit" then
        local v172 = ...
        local v173 = t_14

        if HalloweenFxUtil_m.Near(v172) then
            HalloweenFxUtil_m.PlaceAtPoint(Assets.CrowBurst, v172, nil, v173.Burst)
        end

        HalloweenFxUtil_m.Shake(
            v172,
            1.5,
            10,
            0.2,
            40
        )

        return
    end

    local v174 = HalloweenFxUtil_m.Root(u19)

    if not v174 then
        return
    end

    if arg15 == "Swing" then
        local v175 = ...
        local v178 = Assets:FindFirstChild("Swing" .. tostring(v175))

        if v178 and v175 == 3 then
            local v179 = v178:GetAttribute("Offset") or CFrame.identity
            local v180 = 1.35 * u19:GetScale()
            HalloweenFxUtil_m.PlaceScaled(
                v178,
                v174 * CFrame.new(v179.Position * v180) * v179.Rotation,
                v180
            )
        elseif v178 then
            HalloweenFxUtil_m.Place(v178, u19)
        end

        local v181 = if v175 ~= 3 then 1.5 else 3
        HalloweenFxUtil_m.Shake(
            v174.Position,
            v181,
            8,
            0.35,
            90
        )

        return
    end

    if arg15 == "Throw" then
        throw(u19, v171, ...)

        return
    end

    if arg15 == "Aura" then
        HalloweenFxUtil_m.Stop(v171.Aura)
        HalloweenFxUtil_m.Stop(v171.Charge)
        v171.Aura, v171.Charge = nil, nil
        local v182 = u19:GetScale()
        local Spawn = HalloweenFxUtil_m.Spawn
        local CrowAura = Assets.CrowAura
        local ScaleOffset = HalloweenFxUtil_m.ScaleOffset
        local v183 = Assets.CrowAura:GetAttribute("Offset") or CFrame.identity
        v171.Aura = Spawn(CrowAura, v174 * ScaleOffset(v183, v182))
        local Spawn_1 = HalloweenFxUtil_m.Spawn
        local CrowCharge = Assets.CrowCharge
        local ScaleOffset_1 = HalloweenFxUtil_m.ScaleOffset
        v183 = Assets.CrowCharge:GetAttribute("Offset") or CFrame.identity
        v171.Charge = Spawn_1(CrowCharge, v174 * ScaleOffset_1(v183, v182))

        if v182 ~= 1 then
            HalloweenFxUtil_m.ScaleParticles(v171.Aura, v182)
            HalloweenFxUtil_m.ScaleParticles(v171.Charge, v182)
        end

        HalloweenFxUtil_m.Enable(v171.Aura, true)
        HalloweenFxUtil_m.Enable(v171.Charge)
        local Aura = v171.Aura
        task.delay(9, function() -- line: 865
            -- upvalues:
            --  [1] v171 (copy)
            --  [2] Aura (copy)
            --  [3] HalloweenFxUtil_m (ref)

            if v171.Aura == Aura then
                local v184 = v171
                HalloweenFxUtil_m.Stop(v184.Aura)
                HalloweenFxUtil_m.Stop(v184.Charge)
                v184.Aura, v184.Charge = nil, nil
            end
        end)

        return
    end

    if arg15 == "CrowsRise" then
        riseCrows(u19, v171, (...))
        HalloweenFxUtil_m.PlaceAtPoint(Assets.CrowBurst, v174.Position)
        HalloweenFxUtil_m.Shake(
            v174.Position,
            2,
            8,
            0.4,
            100
        )

        return
    end

    if arg15 == "ReapAppear" then
        raiseShadow(u19, v171, (...))

        return
    end

    if arg15 == "ReapSwing" then
        local v185 = ...
        sweepShadow(u19, v171, v185 or 0.09)
        local v186 = Assets.Reap:GetAttribute("Offset") or CFrame.identity
        local v187 = 1.55 * u19:GetScale()
        local v188 = v186.Position * v187
        local v189 = v174 * CFrame.new(v188.X, -1.5 * u19:GetScale(), v188.Z) * cframe * v186.Rotation
        task.delay(v185 or 0, function() -- line: 886
            -- upvalues:
            --  [1] HalloweenFxUtil_m (ref)
            --  [2] Assets (ref)
            --  [3] v189 (copy)
            --  [4] v187 (copy)
            --  [5] v174 (copy)

            HalloweenFxUtil_m.PlaceScaled(Assets.Reap, v189, v187)
            HalloweenFxUtil_m.Shake(
                v174.Position,
                5,
                10,
                0.6,
                150
            )
        end)

        return
    end

    if arg15 == "Scream" then
        HalloweenFxUtil_m.Place(Assets.Scream, u19)
        HalloweenFxUtil_m.Shake(
            v174.Position,
            4,
            14,
            0.7,
            58
        )

        return
    end

    if arg15 == "Spawn" or arg15 == "Despawn" then
        HalloweenFxUtil_m.Place(Assets.CrowAura, u19)
        HalloweenFxUtil_m.PlaceAtPoint(Assets.CrowBurst, v174.Position)
        HalloweenFxUtil_m.Shake(
            v174.Position,
            3,
            8,
            0.6,
            150
        )

        if arg15 == "Despawn" then
            fadeShadow(v171)

            if v171.Thrown then
                v171.Thrown.Part:Destroy()
                v171.Thrown.Loop:Disconnect()
                v171.Thrown = nil
            end

            HalloweenFxUtil_m.Stop(v171.Aura)
            HalloweenFxUtil_m.Stop(v171.Charge)
            v171.Aura, v171.Charge = nil, nil
            disperseCrows(v171)
            t_1[u19] = nil

            return
        end
    else
        if arg15 == "Death" then
            fadeShadow(v171)

            if v171.Thrown then
                v171.Thrown.Part:Destroy()
                v171.Thrown.Loop:Disconnect()
                v171.Thrown = nil
            end

            HalloweenFxUtil_m.Stop(v171.Aura)
            HalloweenFxUtil_m.Stop(v171.Charge)
            v171.Aura, v171.Charge = nil, nil
            disperseCrows(v171)
            t_1[u19] = nil
            HalloweenFxUtil_m.PlaceAtPoint(Assets.CrowBurst, v174.Position)
            HalloweenFxUtil_m.Place(Assets.Scream, u19)
            HalloweenFxUtil_m.Shake(
                v174.Position,
                4,
                10,
                0.8,
                150
            )

            return
        end

        if arg15 == "Unparryable" then
            HalloweenFxUtil_m.Unparryable(u19, 2.5, CFrame.new(0, 3, -4))
        end
    end
end
