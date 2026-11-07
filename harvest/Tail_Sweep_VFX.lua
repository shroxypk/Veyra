-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Wolf.Tail_Sweep_VFX
-- Class: ModuleScript
-- bytes: 1876

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local _ = game:GetService("UserInputService")
local _ = game:GetService("RunService")
local Effects = _G.GetModule("Effects")

local function main(u1: userdata?, arg1: any) -- line: 11
    -- upvalues:
    --  [1] Services_m (copy)
    --  [2] TweenService (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] Effects (copy)

    local Highlight

    if u1 then
        if (u1:GetPivot().Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 600 then
            return
        end

        if arg1 == 0 then
            Highlight = Instance.new("Highlight")
            Highlight.FillColor = Color3.fromRGB(255, 255, 255)
            Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            Highlight.OutlineTransparency = 0
            Highlight.FillTransparency = 0
            Highlight.Parent = u1
            Services_m.Debris(Highlight, 0.6)
            TweenService:Create(
                Highlight,
                TweenInfo.new(0.5),
                { FillTransparency = 1, OutlineTransparency = 1 }
            ):Play()
            local v3 = ReplicatedStorage.Effects.MagicFX.Wolf.Wolf_Tail_Assets.Tail_Star:Clone()
            v3.Parent = u1.Cube
            Effects:CleanEmitParticle(u1.Cube, 1)
            Services_m.Debris(v3, 3)

            return
        end

        if arg1 == 1 then
            local v4 = ReplicatedStorage.Effects.MagicFX.Wolf.Wolf_Tail_Assets.Tail_Sweep:Clone()
            v4.Parent = u1.HumanoidRootPart
            Effects:CleanEmitParticle(v4, 3)
            Services_m.Debris(v4, 5)

            return
        end

        return
    else
        return
    end
end

return main
