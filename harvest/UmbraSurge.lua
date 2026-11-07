-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Shadow.UmbraSurge
-- Class: ModuleScript
-- bytes: 2242

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
raycastParams.FilterType = Enum.RaycastFilterType.Whitelist
raycastParams.FilterDescendantsInstances = { workspace.Map }

return function(_, arg5, arg6, ...) -- line: 17
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)

    local v2 = if typeof(arg5) ~= "Instance" then nil else GrimoireRarity_m:GetSkillVariant(
        arg5,
        "Shadow"
    )

    if (arg5.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 200 then
        return
    end

    local _ = { ... }

    if arg6 == "Pull" then
        return
    end

    if arg6 == "Hit" then
        local HumanoidRootPart = arg5.HumanoidRootPart
        _G.CameraShake("SmallBump")
        local v3 = script.Hit:Clone()

        if v2 and typeof(v3) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v3, v2)

            if not v3:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v3, v2, true)
            end
        end

        v3.CFrame = HumanoidRootPart.CFrame
        v3.Parent = workspace.Effects
        coroutine.resume(coroutine.create(function() -- line: 35
            -- upvalues:
            --  [1] v3 (copy)

            for _, child in pairs(v3.Attachment:GetChildren()) do
                if child:IsA("ParticleEmitter") then
                    child:Emit(child:GetAttribute("EmitCount"))
                end
            end
        end))
        _G.Debris(v3, 2)
    end
end
