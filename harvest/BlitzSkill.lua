-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Time.BlitzSkill
-- Class: ModuleScript
-- bytes: 5894

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
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local _ = Services_m.TweenService
local Utility_m = require(Services_m.ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

local _ = function(arg4, arg5, arg6) --[[ Weld ]] -- line: 29
    local Weld = Instance.new("Weld")
    Weld.Name = arg4.Name .. "Weld"
    Weld.Part0 = arg4
    Weld.Part1 = arg5
    Weld.C0 = arg6
    Weld.Parent = arg5
end

return function(arg7, arg8, arg9, arg10) -- line: 38
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] Utility_m (copy)

    local v3 = if typeof(arg9) ~= "Instance" then nil else GrimoireRarity_m:GetSkillVariant(
        arg9,
        "Time"
    )

    if (arg8.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 or not arg9 then
        return
    end

    if arg7 == "Teleport" then
        local v4 = script.Teleport:Clone()

        if v3 and typeof(v4) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v4, v3)

            if not v4:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v4, v3, true)
            end
        end

        v4.CFrame = arg8 * CFrame.Angles(0, 1.5707963267948966, 0)
        v4.Parent = workspace.Effects
        Utility_m.Toggle(v4, true)
        local HumanoidRootPart = arg9.HumanoidRootPart
        local cframe = CFrame.Angles(0, 0, 1.5707963267948966)
        local Weld_2 = Instance.new("Weld")
        Weld_2.Name = HumanoidRootPart.Name .. "Weld"
        Weld_2.Part0 = HumanoidRootPart
        Weld_2.Part1 = v4
        Weld_2.C0 = cframe
        Weld_2.Parent = v4
        task.wait(0.5)
        Utility_m.Toggle(v4, false)
        _G.Debris(v4, 2)

        return
    end

    if arg7 == "TimeBall" then
        local v5 = script["Time Ball"]:Clone()

        if v3 and typeof(v5) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v5, v3)

            if not v5:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v5, v3, true)
            end
        end

        v5.Name = arg9.Name .. "TimeBall"
        local PrimaryPart = v5.PrimaryPart
        PrimaryPart.CFrame = arg8
        local RightArm = arg9["Right Arm"]
        local cframe_1 = CFrame.new(0, -2.5, 0)
        local Weld_3 = Instance.new("Weld")
        Weld_3.Name = RightArm.Name .. "Weld"
        Weld_3.Part0 = RightArm
        Weld_3.Part1 = PrimaryPart
        Weld_3.C0 = cframe_1
        Weld_3.Parent = PrimaryPart
        v5.Parent = workspace.Effects
        Utility_m.Toggle(v5, true)
        _G.Debris(v5, 2)

        return
    end

    if arg7 == "Expo" and arg10 then
        local v7 = workspace.Effects:FindFirstChild(arg9.Name .. "TimeBall")

        if v7 then
            local _ = v7.PrimaryPart

            for _, descendant in v7:GetDescendants() do
                if not descendant:IsA("MeshPart") then
                    if descendant:IsA("BasePart") then
                        _G.Tween(
                            descendant,
                            { 0.2, "Linear", Enum.EasingDirection.In },
                            { Transparency = 1 }
                        )
                    end
                else
                    _G.Tween(
                        descendant,
                        { 0.2, "Linear", Enum.EasingDirection.In },
                        { Transparency = 1 }
                    )
                end
            end

            Utility_m.Toggle(v7, false)
        end

        local v8 = script.Emit:Clone()

        if v3 and typeof(v8) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v8, v3)

            if not v8:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v8, v3, true)
            end
        end

        v8.CFrame = arg10.CFrame * CFrame.new(0, -2.5, 0)
        v8.Parent = workspace.Effects
        Utility_m.EmitParticles(v8)
        _G.Debris(v8, 2)

        return
    end

    if arg7 == "ClearBall" then
        local v11 = workspace.Effects:FindFirstChild(arg9.Name .. "TimeBall")

        if v11 then
            local _ = v11.PrimaryPart

            for _, descendant_1 in v11:GetDescendants() do
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

            Utility_m.Toggle(v11, false)
        end
    end
end
