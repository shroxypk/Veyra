-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Beast.SavageMaul_FX
-- Class: ModuleScript
-- bytes: 6717

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
local _ = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local _ = workspace.CurrentCamera
local _ = Random.new()
local Effects = _G.GetModule("Effects")

local function popIn(arg4) -- line: 27
    -- upvalues:
    --  [1] Effects (copy)
    --  [2] TweenService (copy)
    --  [3] RunService (copy)

    local PrimaryPart = arg4.PrimaryPart

    if not PrimaryPart then
        return
    end

    PrimaryPart.Transparency = 1
    Effects:CleanEmitParticle(arg4, 1, false)
    local NumberValue = Instance.new("NumberValue")
    NumberValue.Value = 0.1
    local v5 = TweenService:Create(
        NumberValue,
        TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        { Value = 1 }
    )
    arg4:ScaleTo(NumberValue.Value)
    v5:Play()
    Effects:CleanEmitParticle(arg4, 1, true)
    TweenService:Create(
        PrimaryPart,
        TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
        { Transparency = 0 }
    ):Play()
    local v8 = nil
    v8 = RunService.Heartbeat:Connect(function() -- line: 50
        -- upvalues:
        --  [1] arg4 (copy)
        --  [2] v8 (ref)
        --  [3] NumberValue (copy)

        if not arg4.Parent then
            v8:Disconnect()

            return
        end

        arg4:ScaleTo((math.max(NumberValue.Value, 0.05)))
    end)
    v5.Completed:Once(function() -- line: 58
        -- upvalues:
        --  [1] v8 (ref)
        --  [2] arg4 (copy)

        v8:Disconnect()

        if arg4.Parent then
            arg4:ScaleTo(1)
        end
    end)
end

local function popInWhenStreamed(arg5) -- line: 68
    -- upvalues:
    --  [1] popIn (copy)

    local Effects_1 = workspace:FindFirstChild("Effects")

    if Effects_1 then
        if typeof(arg5) ~= "string" then
            return
        end

        for _, val in Effects_1:GetChildren(), nil, nil do
            if val:GetAttribute("PopInId") == arg5 then
                popIn(val)

                return
            end
        end

        local v11 = nil
        v11 = Effects_1.ChildAdded:Connect(function(child) -- line: 82
            -- upvalues:
            --  [1] arg5 (copy)
            --  [2] v11 (ref)
            --  [3] popIn (ref)

            if child:IsA("Model") and child:GetAttribute("PopInId") == arg5 then
                v11:Disconnect()
                popIn(child)
            end
        end)
        task.delay(1, function() -- line: 89
            -- upvalues:
            --  [1] v11 (ref)

            if v11.Connected then
                v11:Disconnect()
            end
        end)

        return
    else
        return
    end
end

local function Attack(arg8, arg9, arg10) -- line: 96
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] popIn (copy)
    --  [3] popInWhenStreamed (copy)
    --  [4] Services_m (copy)
    --  [5] Effects (copy)
    --  [6] TweenService (copy)

    local v12 = arg9

    if v12 then
        v12 = arg9:FindFirstChildOfClass("Humanoid") and arg9 or arg9:FindFirstChild("Caster") and arg9.Caster.Value
    end

    local v13 = if typeof(v12) ~= "Instance" then nil else GrimoireRarity_m:GetSkillVariant(
        v12,
        "Beast"
    )

    if arg8 == "TweenIn" then
        if arg9 then
            popIn(arg9)

            return
        end

        popInWhenStreamed(arg10)

        return
    else
        local PrimaryPart_1

        if arg9 then
            if (arg9:GetPivot().Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 400 then
                return
            end

            PrimaryPart_1 = arg9.PrimaryPart

            if arg8 == "Bite" and arg10 then
                local v14 = script.BiteNew:Clone()

                if v13 and typeof(v14) == "Instance" then
                    GrimoireRarity_m:ApplyVariantEffect(v14, v13)

                    if not v14:IsA("BasePart") then
                        GrimoireRarity_m:ApplyVariantEffect(v14, v13, true)
                    end
                end

                v14.CFrame = arg10.CFrame
                v14.Parent = workspace.Effects
                Services_m.Debris(v14, 3)

                for _, descendant in arg9:GetDescendants() do
                    if not descendant:IsA("ParticleEmitter") then
                        if descendant:IsA("Beam") then
                            descendant.Enabled = false
                        elseif descendant:IsA("Light") then
                            _G.Tween(
                                descendant,
                                { 0.5, "Quad", Enum.EasingDirection.Out },
                                { Range = 0, Brightness = 0 }
                            )
                        end
                    else
                        descendant.Enabled = false

                        if descendant:IsA("Light") then
                            _G.Tween(
                                descendant,
                                { 0.5, "Quad", Enum.EasingDirection.Out },
                                { Range = 0, Brightness = 0 }
                            )
                        end
                    end
                end

                Effects:CleanEmitParticle(v14, 1, false)
                Effects:CleanEmitParticle(arg9, 1, false)
                TweenService:Create(
                    PrimaryPart_1,
                    TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                    { Transparency = 1 }
                ):Play()

                return
            end

            if arg8 == "Slider" then
                Effects:CleanEmitParticle(arg10, 0, true)
            end

            return
        else
            return
        end
    end
end

return Attack
