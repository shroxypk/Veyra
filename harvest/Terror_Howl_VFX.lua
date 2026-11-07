-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Dire Wolf.Terror_Howl_VFX
-- Class: ModuleScript
-- bytes: 3286

local _ = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local _ = game:GetService("UserInputService")
local _ = game:GetService("RunService")
local _ = game:GetService("Debris")
local _ = game:GetService("TweenService")
local _ = game:GetService("RunService")
local _ = game:GetService("Workspace")
local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local Effects = _G.GetModule("Effects")
local UpRocks_m = require(script.UpRocks)

local function main(u1: userdata?, arg1: any) -- line: 14
    -- upvalues:
    --  [1] Services_m (copy)
    --  [2] TweenService (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] Effects (copy)
    --  [5] UpRocks_m (copy)

    local Highlight, _, HumanoidRootPart, LowerMouth

    if u1 then
        if (u1:GetPivot().Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 600 then
            return
        end

        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart")
        _ = u1:WaitForChild("Humanoid")

        if arg1 == 0 then
            Highlight = Instance.new("Highlight")
            Highlight.FillColor = Color3.fromRGB(255, 49, 76)
            Highlight.OutlineColor = Color3.fromRGB(255, 44, 76)
            Highlight.OutlineTransparency = 0
            Highlight.FillTransparency = 0
            Highlight.Parent = u1
            Services_m.Debris(Highlight, 2)
            TweenService:Create(
                Highlight,
                TweenInfo.new(2),
                { FillTransparency = 1, OutlineTransparency = 1 }
            ):Play()
            local v3 = ReplicatedStorage.Effects.MagicFX.DireWolf.Howl_Start:Clone()
            v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -5, -4) * CFrame.Angles(
                0,
                1.5707963267948966,
                0
            )
            v3.Parent = workspace.Effects
            Effects:CleanEmitParticle(v3, 1)
            Services_m.Debris(v3, 4)

            return
        end

        if arg1 == 1 then
            LowerMouth = u1:FindFirstChild("LowerMouth", true)
            local v6 = ReplicatedStorage.Effects.MagicFX.DireWolf.Howl_Box:Clone()
            v6.Parent = u1
            v6.Weld.Part1 = HumanoidRootPart
            Effects:CleanEmitParticle(v6, 4, true)
            local v7 = ReplicatedStorage.Effects.MagicFX.DireWolf.Howl_Effects.Start_Roar:Clone()
            local v8 = ReplicatedStorage.Effects.MagicFX.DireWolf.Howl_Effects.End_Roar:Clone()

            if LowerMouth then
                v8.Parent = LowerMouth
                v7.Parent = LowerMouth
                Effects:CleanEmitParticle(v7, 3, true)
            end

            coroutine.wrap(UpRocks_m.Start)(
                u1,
                3,
                2,
                2,
                CFrame.new(0, 0, 0)
            )
            task.wait(1.5)
            Effects:CleanEmitParticle(v7, 1, false)
            Effects:CleanEmitParticle(v6, 2, false)
            Effects:CleanEmitParticle(v8, 2, false)
            Services_m.Debris(v7, 5)
            Services_m.Debris(v8, 5)

            return
        end

        warn("No Args for Howling Move")

        return
    else
        return
    end
end

return main
