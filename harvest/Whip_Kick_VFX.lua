-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Dire Wolf.Whip_Kick_VFX
-- Class: ModuleScript
-- bytes: 5786

local _ = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local _ = game:GetService("UserInputService")
local _ = game:GetService("RunService")
local _ = game:GetService("TweenService")
local _ = game:GetService("RunService")
local _ = game:GetService("Workspace")
local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local Effects = _G.GetModule("Effects")

local function main(u1: userdata?, arg1: any) -- line: 12
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] TweenService (copy)
    --  [3] Effects (copy)
    --  [4] Services_m (copy)

    local Highlight, Highlight_1, _, PrimaryPart

    if u1 then
        if (u1:GetPivot().Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 600 then
            return
        end

        PrimaryPart = u1.PrimaryPart
        _ = u1.Humanoid

        if arg1 == 0 then
            local v2 = ReplicatedStorage.Effects.MagicFX.DireWolf.Whip_Kick_Effects.Middle_Part:Clone()

            if u1:FindFirstChild("Torso_4", true) then
                v2.Parent = u1
            end

            Highlight = Instance.new("Highlight")
            Highlight.FillColor = Color3.fromRGB(0, 0, 0)
            Highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
            Highlight.OutlineTransparency = 1
            Highlight.FillTransparency = 1
            Highlight.Parent = u1
            TweenService:Create(
                Highlight,
                TweenInfo.new(0.8),
                { FillTransparency = 0, OutlineTransparency = 0 }
            ):Play()
            task.wait(1)
            local v4 = ReplicatedStorage.Effects.MagicFX.DireWolf.Whip_Kick_Effects.Whip_Dis:Clone()
            v4.CFrame = PrimaryPart.CFrame
            v4.Parent = workspace
            Effects:CleanEmitParticle(v4, 1)
            Services_m.Debris(v4, 3)
            v2:Destroy()
            Highlight:Destroy()
            task.wait(0.7)
            local v5 = ReplicatedStorage.Effects.MagicFX.DireWolf.Whip_Kick_Effects.Whip_Dis:Clone()
            v5.CFrame = PrimaryPart.CFrame
            v5.Parent = workspace
            Effects:CleanEmitParticle(v5, 1)
            Services_m.Debris(v5, 3)

            return
        end

        if arg1 == 1 then
            for index = 1, 2 do
                local v6 = ReplicatedStorage.Effects.MagicFX.DireWolf.Whip_Kick_Effects.Whip_Kick_Side:Clone()
                local v7 = ReplicatedStorage.Effects.MagicFX.DireWolf.Whip_Kick_Effects.Whip_Kick_Ground:Clone()
                v7.Size = Vector3.new(8.687, 0.001, 0.001)

                if index == 2 then
                    v6.CFrame = PrimaryPart.CFrame * CFrame.new(1, -7.5, -20)
                    v7.CFrame = PrimaryPart.CFrame * CFrame.new(1, -7.7, -50)
                else
                    v6.CFrame = PrimaryPart.CFrame * CFrame.new(-4, -7.5, -20)
                    v7.CFrame = PrimaryPart.CFrame * CFrame.new(-4, -7.7, -50)
                end

                v6.Parent = workspace.Effects
                v7.Parent = workspace.Effects
                task.spawn(function() -- line: 74
                    -- upvalues:
                    --  [1] Effects (ref)
                    --  [2] v6 (copy)

                    Effects:CleanEmitParticle(v6, 3)
                end)
                Services_m.Debris(v6, 5)
                TweenService:Create(
                    v7.Decal,
                    TweenInfo.new(0.15, Enum.EasingStyle.Back),
                    { Transparency = 0, Color3 = Color3.fromRGB(2555, 100, 100) }
                ):Play()
                TweenService:Create(
                    v7,
                    TweenInfo.new(0.15, Enum.EasingStyle.Back),
                    { Size = Vector3.new(8, 0, 52.855) }
                ):Play()
                task.delay(5, function() -- line: 82
                    -- upvalues:
                    --  [1] Services_m (ref)
                    --  [2] v7 (copy)
                    --  [3] TweenService (ref)

                    Services_m.Debris(v7, 2)
                    TweenService:Create(
                        v7.Decal,
                        TweenInfo.new(3, Enum.EasingStyle.Quad),
                        { Transparency = 1, Color3 = Color3.fromRGB(0, 0, 0) }
                    ):Play()
                end)
            end
        elseif arg1 == 2 then
            local v15 = ReplicatedStorage.Effects.MagicFX.DireWolf.Whip_Kick_Effects.Middle_Part:Clone()

            if u1:FindFirstChild("Torso_4", true) then
                v15.Parent = u1
            end

            Highlight_1 = Instance.new("Highlight")
            Highlight_1.FillColor = Color3.fromRGB(0, 0, 0)
            Highlight_1.OutlineColor = Color3.fromRGB(0, 0, 0)
            Highlight_1.OutlineTransparency = 1
            Highlight_1.FillTransparency = 1
            Highlight_1.Parent = u1
            local v17 = TweenService:Create(
                Highlight_1,
                TweenInfo.new(1),
                { FillTransparency = 0, OutlineTransparency = 0 }
            )
            v17:Play()
            v17.Completed:Wait()
            local v19 = TweenService:Create(
                Highlight_1,
                TweenInfo.new(1),
                { FillTransparency = 1, OutlineTransparency = 1 }
            )
            TweenService:Create(u1["Cube.003"], TweenInfo.new(0.5), { Transparency = 1 }):Play()
            v19:Play()
            v19.Completed:Wait()
            task.wait(0.3)

            for _, val in v15:QueryDescendants("ParticleEmitter") do
                val.Enabled = false
            end

            Services_m.Debris(v15, 2)
        end

        return
    else
        return
    end
end

return main
