-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Beast.ViciousAssault_FX
-- Class: ModuleScript
-- bytes: 5131

local GrimoireRarity_m = require(game:GetService("ReplicatedStorage").Modules.GrimoireRarity)

local _ = function(arg1) --[[ __getVariant ]] -- line: 3
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)

    if typeof(arg1) ~= "Instance" then
        return nil
    end

    return GrimoireRarity_m:GetSkillVariant(arg1, "Beast")
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
local _ = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CameraShaker_m = require(ReplicatedStorage.Modules.CameraShaker)
local CurrentCamera = workspace.CurrentCamera
local v3 = CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg4) -- line: 25
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg4
end)
v3:Start()
local Effects = _G.GetModule("Effects")

local function main(arg5) -- line: 34
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] CurrentCamera (copy)
    --  [3] v3 (copy)
    --  [4] ReplicatedStorage (copy)
    --  [5] Effects (copy)
    --  [6] RunService (copy)
    --  [7] TweenService (copy)
    --  [8] Services_m (copy)

    local v4 = arg5 and arg5.Character
    local v5 = if typeof(v4) ~= "Instance" then nil else GrimoireRarity_m:GetSkillVariant(
        v4,
        "Beast"
    )
    v4 = arg5.Character
    local Action = arg5.Action

    if v4 then
        if (v4:GetPivot().Position - CurrentCamera.CFrame.Position).Magnitude > 400 then
            return
        end

        local PrimaryPart = v4.PrimaryPart

        if Action == "Fire" then
            if (CurrentCamera.CFrame.Position - PrimaryPart.Position).Magnitude < 200 then
                v3:ShakeOnce(2, 6, 0, 0.4)
            end

            local v7 = ReplicatedStorage.Effects.MagicFX.Beast_FX.Viscous_Assault:Clone()

            if v5 and typeof(v7) == "Instance" then
                GrimoireRarity_m:ApplyVariantEffect(v7, v5)

                if not v7:IsA("BasePart") then
                    GrimoireRarity_m:ApplyVariantEffect(v7, v5, true)
                end
            end

            v7.PrimaryPart = v7.Speed
            local Y = v7.PrimaryPart.Size.Y
            v7:PivotTo(PrimaryPart.CFrame)
            v7.Name = "VIS_SLASHES"
            v7.Parent = v4
            Effects:CleanEmitParticle(v7, 5, true)
            local NumberValue = Instance.new("NumberValue")
            NumberValue.Value = 0.6
            local v15 = nil
            v15 = RunService.Heartbeat:Connect(function() -- line: 77
                -- upvalues:
                --  [1] v7 (copy)
                --  [2] v15 (ref)
                --  [3] NumberValue (copy)
                --  [4] Y (copy)
                --  [5] PrimaryPart (copy)

                if not v7.Parent then
                    v15:Disconnect()
                    NumberValue:Destroy()

                    return
                end

                local Value = NumberValue.Value
                v7:ScaleTo(Value)
                v7:PivotTo(PrimaryPart.CFrame * CFrame.new(0, 2 + (Y * Value - Y) / 2, 0))
            end)
            TweenService:Create(
                NumberValue,
                TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                { Value = 1 }
            ):Play()

            return
        end

        if Action == "Explosion" then
            for _, child in v4:GetChildren() do
                if child.Name == "VIS_SLASHES" then
                    Effects:CleanEmitParticle(child, 1, false)
                    Services_m.Debris(child, 1)
                end
            end

            local v20 = ReplicatedStorage.Effects.MagicFX.Beast_FX.Viscous_Explo:Clone()

            if v5 and typeof(v20) == "Instance" then
                GrimoireRarity_m:ApplyVariantEffect(v20, v5)

                if not v20:IsA("BasePart") then
                    GrimoireRarity_m:ApplyVariantEffect(v20, v5, true)
                end
            end

            v20.CFrame = PrimaryPart.CFrame * CFrame.new(0, -1.5, 0)
            v20.Parent = workspace.Effects
            Effects:CleanEmitParticle(v20, 15, false)
            Services_m.Debris(v20, 8)

            return
        end

        if Action == "Cleanup" then
            for _, child_1 in v4:GetChildren() do
                if child_1.Name == "VIS_SLASHES" then
                    Effects:CleanEmitParticle(child_1, 1, false)
                    Services_m.Debris(child_1, 1)
                end
            end
        end

        return
    else
        return
    end
end

return main
