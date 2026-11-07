-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Dire Wolf.Clawed_Attack_VFX
-- Class: ModuleScript
-- bytes: 4943

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local _ = game:GetService("UserInputService")
local _ = game:GetService("RunService")
local _ = game:GetService("Debris")
local _ = game:GetService("TweenService")
local _ = game:GetService("RunService")
local _ = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Effects = _G.GetModule("Effects")

local function main(u1: userdata?, arg1: any) -- line: 16
    -- upvalues:
    --  [1] Services_m (copy)
    --  [2] TweenService (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] Effects (copy)

    local FrontFoot2L, FrontFoot2R, Highlight, Highlight_1, _, PrimaryPart

    if u1 then
        if (u1:GetPivot().Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 600 then
            return
        end

        PrimaryPart = u1.PrimaryPart
        _ = u1.Humanoid

        if arg1 == 0 then
            FrontFoot2L = u1:FindFirstChild("FrontFoot_2.L", true)
            FrontFoot2R = u1:FindFirstChild("FrontFoot_2.R", true)
            Highlight = Instance.new("Highlight")
            Highlight.FillColor = Color3.fromRGB(255, 0, 0)
            Highlight.OutlineColor = Color3.fromRGB(255, 44, 76)
            Highlight.OutlineTransparency = 0
            Highlight.FillTransparency = 0
            Highlight.Parent = u1
            Services_m.Debris(Highlight, 0.6)
            TweenService:Create(
                Highlight,
                TweenInfo.new(0.5),
                { FillTransparency = 1, OutlineTransparency = 1 }
            ):Play()
            local v3 = ReplicatedStorage.Effects.MagicFX.DireWolf.Clawed_Effect.Spin_Effect:Clone()
            local v4 = ReplicatedStorage.Effects.MagicFX.DireWolf.Clawed_Effect.Spin_Effect:Clone()

            if FrontFoot2R then
                v3.Parent = FrontFoot2R
                Effects:CleanEmitParticle(v3, 2)
                Services_m.Debris(v3, 2)
            end

            task.wait(1)
            Highlight_1 = Instance.new("Highlight")
            Highlight_1.FillColor = Color3.fromRGB(255, 0, 0)
            Highlight_1.OutlineColor = Color3.fromRGB(255, 44, 76)
            Highlight_1.OutlineTransparency = 0
            Highlight_1.FillTransparency = 0
            Highlight_1.Parent = u1
            Services_m.Debris(Highlight_1, 0.6)
            TweenService:Create(
                Highlight_1,
                TweenInfo.new(0.5),
                { FillTransparency = 1, OutlineTransparency = 1 }
            ):Play()

            if FrontFoot2L then
                v4.Parent = FrontFoot2L
                Effects:CleanEmitParticle(v4, 2)
                Services_m.Debris(v4, 2)

                return
            end
        else
            if arg1 == 1 then
                local v6 = ReplicatedStorage.Effects.MagicFX.DireWolf.Claw_After:Clone()
                v6.CFrame = PrimaryPart.CFrame * CFrame.new(-4, -6, -20)
                v6.Anchored = true
                v6.Parent = workspace.Effects
                Effects:CleanEmitParticle(v6, 5)
                Services_m.Debris(v6, 5)
                local v8 = ReplicatedStorage.Effects.MagicFX.DireWolf.Claw_1:Clone()
                v8.CFrame = PrimaryPart.CFrame * CFrame.new(0, -7, -10)
                v8.Anchored = true
                v8.Parent = workspace.Effects
                Services_m.Debris(v8, 2)
                Effects:CleanEmitParticle(v8, 5)
                Effects:BeamSlash(
                    v8,
                    0.2,
                    0.1,
                    -2,
                    0,
                    0,
                    0,
                    0,
                    false
                )
                task.wait(1)
                local v10 = ReplicatedStorage.Effects.MagicFX.DireWolf.Claw_After2:Clone()
                v10.CFrame = PrimaryPart.CFrame * CFrame.new(2, -5.5, -20)
                v10.Anchored = true
                v10.Parent = workspace.Effects
                Effects:CleanEmitParticle(v10, 5)
                Services_m.Debris(v10, 5)
                local v12 = ReplicatedStorage.Effects.MagicFX.DireWolf.Claw_2:Clone()
                v12.CFrame = PrimaryPart.CFrame * CFrame.new(0, -7, -10)
                v12.Anchored = true
                v12.Parent = workspace.Effects
                Services_m.Debris(v12, 2)
                Effects:CleanEmitParticle(v12, 5)
                Effects:BeamSlash(
                    v12,
                    0.2,
                    0.1,
                    -2,
                    0,
                    0,
                    0,
                    0,
                    false
                )

                return
            end

            warn("No Args for Howling Move")
        end

        return
    else
        return
    end
end

return main
