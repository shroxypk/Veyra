-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Time.TimeStopSkill
-- Class: ModuleScript
-- bytes: 12723

local GrimoireRarity_m = require(game:GetService("ReplicatedStorage").Modules.GrimoireRarity)

local _ = function(arg1) --[[ __getVariant ]] -- line: 3
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)

    if typeof(arg1) ~= "Instance" then
        return nil
    end

    return GrimoireRarity_m:GetSkillVariant(arg1, "Time")
end

local _ = function(arg2, arg3) --[[ __tintVariant ]] -- line: 7
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)

    if arg3 then
        if typeof(arg2) ~= "Instance" then
            return
        end

        GrimoireRarity_m:ApplyVariantEffect(arg2, arg3)

        if not arg2:IsA("BasePart") then
            GrimoireRarity_m:ApplyVariantEffect(arg2, arg3, true)
        end

        return
    else
        return
    end
end

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local RunService = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local TweenService = Services_m.TweenService
local Utility_m = require(Services_m.ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

local _ = function(
    u1: userdata,
    n1: number,
    n2: number,
    n3: number,
    u2: userdata,
    u3: userdata
) --[[ tweenScale ]] -- line: 29
    -- upvalues:
    --  [1] RunService (copy)
    --  [2] TweenService (copy)

    local v3 = 0

    local _ = function(n4: number, n5: number, n6: number) --[[ lerp ]] -- line: 35
        return n4 + (n5 - n4) * n6
    end

    local v4 = n2 + n3
    local v5 = nil
    v5 = RunService.Heartbeat:Connect(function(deltaTime) -- line: 39
        -- upvalues:
        --  [1] v3 (ref)
        --  [2] TweenService (ref)
        --  [3] n1 (copy)
        --  [4] u2 (copy)
        --  [5] u3 (copy)
        --  [6] u1 (copy)
        --  [7] n2 (copy)
        --  [8] v4 (copy)
        --  [9] v5 (ref)

        v3 += deltaTime
        local v8 = TweenService:GetValue(math.min(v3 / n1, 1), u2, u3)
        local v9 = n2
        u1:ScaleTo(v9 + (v4 - v9) * v8)

        if v3 >= n1 then
            v5:Disconnect()
        end
    end)
end

return function(arg5, arg6, arg7) -- line: 50
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] Utility_m (copy)
    --  [3] RunService (copy)
    --  [4] TweenService (copy)

    local v11 = if typeof(arg7) ~= "Instance" then nil else GrimoireRarity_m:GetSkillVariant(
        arg7,
        "Time"
    )

    if arg5 == "Clock" then
        local v12 = script.Clock:Clone()

        if v11 and typeof(v12) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v12, v11)

            if not v12:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v12, v11, true)
            end
        end

        v12.Name = arg7.Name .. "ClockBall"
        v12.CFrame = arg6 * CFrame.new(0, 40, 0)
        v12.Parent = workspace.Effects
        Utility_m.Toggle(v12, true)
        task.wait(3)
        Utility_m.Toggle(v12, false)
        _G.Debris(v12, 7)

        return
    end

    if arg5 == "Bubbles" then
        local v20 = workspace.Effects:WaitForChild(arg7.Name .. "ClockBall")
        local v21 = script["Time Ball"]:Clone()

        if v11 and typeof(v21) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v21, v11)

            if not v21:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v21, v11, true)
            end
        end

        v21.PrimaryPart.CFrame = arg6
        v21.Parent = workspace.Effects
        local EasingStyle_Bounce = Enum.EasingStyle.Bounce
        local EasingDirection_In = Enum.EasingDirection.In
        local v28 = 0
        local v29 = nil

        local _ = function(n7: number, n8: number, n9: number) --[[ lerp ]] -- line: 35
            return n7 + (n8 - n7) * n9
        end

        local v31 = 0.2
        local v32 = 0.1
        local v33 = 1.2000000000000002
        v29 = RunService.Heartbeat:Connect(function(deltaTime_1) -- line: 39
            -- upvalues:
            --  [1] v28 (ref)
            --  [2] TweenService (ref)
            --  [3] v31 (copy)
            --  [4] EasingStyle_Bounce (copy)
            --  [5] EasingDirection_In (copy)
            --  [6] v21 (copy)
            --  [7] v32 (copy)
            --  [8] v33 (copy)
            --  [9] v29 (ref)

            v28 += deltaTime_1
            local v36 = TweenService:GetValue(
                math.min(v28 / v31, 1),
                EasingStyle_Bounce,
                EasingDirection_In
            )
            local v37 = v32
            v21:ScaleTo(v37 + (v33 - v37) * v36)

            if v28 >= v31 then
                v29:Disconnect()
            end
        end)

        for _, child in v21.Lines:GetChildren() do
            local t = { Orientation = nil }
            local Tween = _G.Tween
            local t_1 = { 1.3, "Linear", Enum.EasingDirection.In, false, false, -1 }
            t.Orientation = v21.Lines.Base.Orientation + Vector3.new(0, -360, -360)
            Tween(child, t_1, t)
        end

        for _, child_1 in v21.Lines2:GetChildren() do
            local t_2 = { Orientation = nil }
            local Tween_1 = _G.Tween
            local t_3 = { 1.3, "Linear", Enum.EasingDirection.In, false, false, -1 }
            t_2.Orientation = v21.Lines.Base.Orientation + Vector3.new(-360, -360, 0)
            Tween_1(child_1, t_3, t_2)
        end

        local v45 = script.Emit:Clone()

        if v11 then
            if typeof(v45) == "Instance" then
                GrimoireRarity_m:ApplyVariantEffect(v45, v11)

                if not v45:IsA("BasePart") then
                    GrimoireRarity_m:ApplyVariantEffect(v45, v11, true)
                end
            end
        end

        v45.CFrame = arg6
        v45.Parent = workspace.Effects
        Utility_m.EmitParticles(v45)
        local v58 = script.Enable:Clone()

        if v11 then
            if typeof(v58) == "Instance" then
                GrimoireRarity_m:ApplyVariantEffect(v58, v11)

                if not v58:IsA("BasePart") then
                    GrimoireRarity_m:ApplyVariantEffect(v58, v11, true)
                end
            end
        end

        v58.CFrame = arg6
        v58.Parent = workspace.Effects
        Utility_m.Toggle(v58, true)
        task.wait(1.5)

        for _, val in v20:GetDescendants(), nil, nil do
            if not val:IsA("Part") then
                if val:IsA("MeshPart") then
                    _G.Tween(val, { 0.2, "Linear", Enum.EasingDirection.In }, { Transparency = 1 })
                end
            else
                _G.Tween(val, { 0.2, "Linear", Enum.EasingDirection.In }, { Transparency = 1 })
            end
        end

        local v74 = script.Emit:Clone()

        if v11 then
            if typeof(v74) == "Instance" then
                GrimoireRarity_m:ApplyVariantEffect(v74, v11)

                if not v74:IsA("BasePart") then
                    GrimoireRarity_m:ApplyVariantEffect(v74, v11, true)
                end
            end
        end

        v74.CFrame = arg6
        v74.Parent = workspace.Effects
        Utility_m.EmitParticles(v74)
        local EasingStyle_Linear = Enum.EasingStyle.Linear
        local EasingDirection_In_1 = Enum.EasingDirection.In
        local v87 = 0
        local v88 = nil

        local _ = function(n10: number, n11: number, n12: number) --[[ lerp ]] -- line: 35
            return n10 + (n11 - n10) * n12
        end

        local v89 = 0.5
        local v90 = 1
        local v91 = 0.09999999999999998
        v88 = RunService.Heartbeat:Connect(function(deltaTime_2) -- line: 39
            -- upvalues:
            --  [1] v87 (ref)
            --  [2] TweenService (ref)
            --  [3] v89 (copy)
            --  [4] EasingStyle_Linear (copy)
            --  [5] EasingDirection_In_1 (copy)
            --  [6] v21 (copy)
            --  [7] v90 (copy)
            --  [8] v91 (copy)
            --  [9] v88 (ref)

            v87 += deltaTime_2
            local v94 = TweenService:GetValue(
                math.min(v87 / v89, 1),
                EasingStyle_Linear,
                EasingDirection_In_1
            )
            local v95 = v90
            v21:ScaleTo(v95 + (v91 - v95) * v94)

            if v87 >= v89 then
                v88:Disconnect()
            end
        end)
        Utility_m.Toggle(v58, false)

        return
    end

    if arg5 == "Barrier" then
        local v100 = script.Barrier:Clone()

        if v11 and typeof(v100) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v100, v11)

            if not v100:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v100, v11, true)
            end
        end

        v100.PrimaryPart.CFrame = arg6 * CFrame.new(0, -2.5, 0)
        v100.Parent = workspace.Effects
        Utility_m.Toggle(v100, true)
        local EasingStyle_Linear_1 = Enum.EasingStyle.Linear
        local EasingDirection_In_2 = Enum.EasingDirection.In
        local v108 = 0
        local v109 = nil

        local _ = function(n13: number, n14: number, n15: number) --[[ lerp ]] -- line: 35
            return n13 + (n14 - n13) * n15
        end

        local v111 = 0.3
        local v112 = 0.1
        local v113 = 2.1
        v109 = RunService.Heartbeat:Connect(function(deltaTime_3) -- line: 39
            -- upvalues:
            --  [1] v108 (ref)
            --  [2] TweenService (ref)
            --  [3] v111 (copy)
            --  [4] EasingStyle_Linear_1 (copy)
            --  [5] EasingDirection_In_2 (copy)
            --  [6] v100 (copy)
            --  [7] v112 (copy)
            --  [8] v113 (copy)
            --  [9] v109 (ref)

            v108 += deltaTime_3
            local v116 = TweenService:GetValue(
                math.min(v108 / v111, 1),
                EasingStyle_Linear_1,
                EasingDirection_In_2
            )
            local v117 = v112
            v100:ScaleTo(v117 + (v113 - v117) * v116)

            if v108 >= v111 then
                v109:Disconnect()
            end
        end)
        Utility_m.Toggle(v100, true)
        task.wait(2.7)
        local EasingStyle_Linear_2 = Enum.EasingStyle.Linear
        local EasingDirection_In_3 = Enum.EasingDirection.In
        local v120 = 0
        local v121 = nil

        local _ = function(n16: number, n17: number, n18: number) --[[ lerp ]] -- line: 35
            return n16 + (n17 - n16) * n18
        end

        local v123 = 0.2
        local v124 = 2.1
        local v125 = 0.1100000000000001
        v121 = RunService.Heartbeat:Connect(function(deltaTime_4) -- line: 39
            -- upvalues:
            --  [1] v120 (ref)
            --  [2] TweenService (ref)
            --  [3] v123 (copy)
            --  [4] EasingStyle_Linear_2 (copy)
            --  [5] EasingDirection_In_3 (copy)
            --  [6] v100 (copy)
            --  [7] v124 (copy)
            --  [8] v125 (copy)
            --  [9] v121 (ref)

            v120 += deltaTime_4
            local v128 = TweenService:GetValue(
                math.min(v120 / v123, 1),
                EasingStyle_Linear_2,
                EasingDirection_In_3
            )
            local v129 = v124
            v100:ScaleTo(v129 + (v125 - v129) * v128)

            if v120 >= v123 then
                v121:Disconnect()
            end
        end)

        local function v132() -- line: 138
            -- upvalues:
            --  [1] v100 (copy)

            for _, descendant in pairs(v100:GetDescendants()) do
                if descendant:IsA("Beam") then
                    _G.Tween(
                        descendant,
                        { 0.2, "Linear", Enum.EasingDirection.In },
                        { Width0 = 0, Width1 = 0 }
                    )
                end
            end
        end

        task.delay(0.4, v132)
        task.wait(0.3)
        Utility_m.Toggle(v100, false)

        for _, descendant_1 in v100:GetDescendants() do
            if not descendant_1:IsA("MeshPart") then
                if descendant_1:IsA("BasePart") then
                    _G.Tween(
                        descendant_1,
                        { 0.2, "Linear", Enum.EasingDirection.In },
                        { Transparency = 1 }
                    )
                end
            else
                _G.Tween(
                    descendant_1,
                    { 0.2, "Linear", Enum.EasingDirection.In },
                    { Transparency = 1 }
                )
            end
        end

        _G.Debris(v100, 2)
    end
end
