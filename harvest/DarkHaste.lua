-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Shadow.DarkHaste
-- Class: ModuleScript
-- bytes: 4904

local GrimoireRarity_m = require(game:GetService("ReplicatedStorage").Modules.GrimoireRarity)

local _ = function(arg1) --[[ __getVariant ]] -- line: 3
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)

    if typeof(arg1) ~= "Instance" then
        return nil
    end

    return GrimoireRarity_m:GetSkillVariant(arg1, "Shadow")
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

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
local t = {
    WindUp = function(arg4) --[[ WindUp ]] -- line: 18
        -- upvalues:
        --  [1] GrimoireRarity_m (copy)

        local v2 = if typeof(arg4) ~= "Instance" then nil else GrimoireRarity_m:GetSkillVariant(
            arg4,
            "Shadow"
        )

        if (arg4.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 200 then
            return
        end

        local Debris = _G.Debris
        local VFX = require(game.ReplicatedFirst.Services).VFX
        local v3 = script.WindUp.WindUp:Clone()

        if v2 and typeof(v3) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v3, v2)

            if not v3:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v3, v2, true)
            end
        end

        v3.Parent = arg4["Right Arm"]
        Debris(v3, 3)
        VFX.Enable(v3, true)
        task.delay(0.6, function() -- line: 31
            -- upvalues:
            --  [1] VFX (copy)
            --  [2] v3 (copy)

            VFX.Enable(v3, false)
        end)
        local v4 = script.WindUp.WindUpDone:Clone()

        if v2 and typeof(v4) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v4, v2)

            if not v4:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v4, v2, true)
            end
        end

        local v5, v6
        v4.Parent, v5, v6 = arg4["Right Arm"], Debris, v4
        v5(v6, 3)
        task.delay(0.7, function() -- line: 39
            -- upvalues:
            --  [1] VFX (copy)
            --  [2] v4 (copy)

            VFX.Emit2(v4)
        end)
    end,
    Impact = function(arg5) --[[ Impact ]] -- line: 44
        -- upvalues:
        --  [1] GrimoireRarity_m (copy)
        --  [2] raycastParams (copy)

        local v7 = if typeof(arg5) ~= "Instance" then nil else GrimoireRarity_m:GetSkillVariant(
            arg5,
            "Shadow"
        )

        if (arg5.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 200 then
            return
        end

        local Debris_1 = _G.Debris
        local _ = _G.GetModule("CameraShaker")
        local VFX_1 = require(game.ReplicatedFirst.Services).VFX
        local v8 = script.Impact.Dust:Clone()

        if v7 and typeof(v8) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v8, v7)

            if not v8:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v8, v7, true)
            end
        end

        v8.Parent = arg5.PrimaryPart
        Debris_1(v8, 5)
        task.spawn(function() -- line: 58
            -- upvalues:
            --  [1] arg5 (copy)
            --  [2] raycastParams (ref)
            --  [3] v8 (copy)

            local v9 = workspace:Raycast(
                arg5.PrimaryPart.Position,
                Vector3.new(0, -6, 0),
                raycastParams
            )

            if v9 and v9.Instance then
                v8.HeavySmoke2.Color = ColorSequence.new(v9.Instance.Color)
                v8.Smoke.Color = ColorSequence.new(v9.Instance.Color)
            end
        end)
        VFX_1.Emit2(v8)
        local v10 = script.Impact.Impact:Clone()

        if v7 and typeof(v10) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v10, v7)

            if not v10:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v10, v7, true)
            end
        end

        local v11, v12
        v10.Parent, v11, v12 = arg5.PrimaryPart, Debris_1, v10
        v11(v12, 5)
        VFX_1.Emit2(v10)

        if (arg5.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude <= 60 then
            _G.CameraShake("SmallBump")
        end
    end
}

return function(arg6, arg7, ...) -- line: 79
    -- upvalues:
    --  [1] t (copy)

    local v13 = t[arg7]

    if v13 and type(v13) == "function" then
        task.spawn(v13, arg6, ...)
    end
end
