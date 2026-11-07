-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Shadow.ShadowReaping
-- Class: ModuleScript
-- bytes: 4917

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
raycastParams.FilterDescendantsInstances = { workspace.Map }

return function(arg4, arg5, ...) -- line: 17
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] raycastParams (copy)

    local v2 = if typeof(arg4) ~= "Instance" then nil else GrimoireRarity_m:GetSkillVariant(
        arg4,
        "Shadow"
    )

    if (arg4.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 300 then
        return
    end

    local _ = { ... }
    local PrimaryPart = arg4.PrimaryPart

    if arg5 == "Start" then
        _G.PlaySound(script.Sound, PrimaryPart)
        local v3 = script.Start.Attachment:Clone()

        if v2 and typeof(v3) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v3, v2)

            if not v3:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v3, v2, true)
            end
        end

        v3.Parent = PrimaryPart
        coroutine.resume(coroutine.create(function() -- line: 32
            -- upvalues:
            --  [1] v3 (copy)

            for _, child in pairs(v3:GetChildren()) do
                if child:IsA("ParticleEmitter") then
                    child:Emit(child:GetAttribute("EmitCount"))
                end
            end
        end))
        _G.Debris(v3, 1)

        return
    end

    if arg5 == "Slash1" then
        _G.CameraShake("Bump")
        local v5 = script.Slash1:Clone()
        _G.Debris(v5, 2)

        if v2 and typeof(v5) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v5, v2)

            if not v5:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v5, v2, true)
            end
        end

        v5.CFrame = PrimaryPart.CFrame
        v5.Parent = workspace.Effects
        v5.Attachment2.Wind:Emit(2)
        v5.Slash:Play()
        local v6 = workspace:Raycast(
            PrimaryPart.CFrame.Position,
            Vector3.new(0, -10, 0),
            raycastParams
        )

        if v6 and v6.Instance then
            v5.Attachment2.Smoke.Color = ColorSequence.new(v6.Instance.Color)
            v5.Attachment2.Smoke:Emit(15)
        end

        for _, val in pairs(v5.Attachment:GetChildren()) do
            if val:IsA("ParticleEmitter") then
                val:Emit(val:GetAttribute("EmitCount"))
            end
        end

        for _, val_1 in pairs(v5.Attachment_2:GetChildren()) do
            if val_1:IsA("ParticleEmitter") then
                val_1:Emit(val_1:GetAttribute("EmitCount"))
            end
        end

        return
    end

    if arg5 == "Slash2" then
        _G.CameraShake("Bump")
        local v9 = script.Slash2:Clone()
        _G.Debris(v9, 2)

        if v2 and typeof(v9) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v9, v2)

            if not v9:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v9, v2, true)
            end
        end

        v9.CFrame = PrimaryPart.CFrame * CFrame.new(0, 2, 0)
        v9.Parent = workspace.Effects
        v9.Slash:Play()
        local v11 = pairs
        local _ = CFrame.new(0, 2, 0)

        for _, val_2 in v11(v9.Attachment:GetChildren()) do
            if val_2:IsA("ParticleEmitter") then
                val_2:Emit(val_2:GetAttribute("EmitCount"))
            end
        end

        local v12 = script.Slash1:Clone()
        _G.Debris(v12, 2)

        if v2 and typeof(v12) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v12, v2)

            if not v12:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v12, v2, true)
            end
        end

        v12.CFrame = PrimaryPart.CFrame
        v12.Parent = workspace.Effects
        local v13 = workspace:Raycast(
            PrimaryPart.CFrame.Position,
            Vector3.new(0, -10, 0),
            raycastParams
        )

        if v13 and v13.Instance then
            v12.Attachment2.Smoke.Color = ColorSequence.new(v13.Instance.Color)
            v12.Attachment2.Smoke:Emit(15)
        end
    end
end
