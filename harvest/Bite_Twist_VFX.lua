-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Dire Wolf.Bite_Twist_VFX
-- Class: ModuleScript
-- bytes: 2304

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local _ = game:GetService("UserInputService")
local _ = game:GetService("RunService")
local Effects = _G.GetModule("Effects")

local function main(arg1, arg2) -- line: 11
    -- upvalues:
    --  [1] Services_m (copy)
    --  [2] TweenService (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] Effects (copy)

    local Highlight, LowerMouth, LowerMouth_1

    if arg1 then
        if (arg1:GetPivot().Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 600 then
            return
        end

        if arg2 == 0 then
            Highlight = Instance.new("Highlight")
            Highlight.FillColor = Color3.fromRGB(255, 255, 255)
            Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            Highlight.OutlineTransparency = 0
            Highlight.FillTransparency = 0
            Highlight.Parent = arg1
            Services_m.Debris(Highlight, 1)
            TweenService:Create(
                Highlight,
                TweenInfo.new(1),
                { FillTransparency = 1, OutlineTransparency = 1 }
            ):Play()
            LowerMouth = arg1:FindFirstChild("LowerMouth", true)

            if LowerMouth then
                local v3 = ReplicatedStorage.Effects.MagicFX.DireWolf.Bite_Spark:Clone()
                v3.Parent = LowerMouth
                Effects:CleanEmitParticle(v3, 2)
                Services_m.Debris(v3, 4)

                return
            end
        else
            if arg2 == 1 then
                local v4 = ReplicatedStorage.Effects.MagicFX.DireWolf.Bite_Mouth:Clone()
                LowerMouth_1 = arg1:FindFirstChild("LowerMouth", true)

                if LowerMouth_1 then
                    v4.Parent = LowerMouth_1
                    Effects:CleanEmitParticle(v4, 2, true)
                end

                task.wait(1)
                Effects:CleanEmitParticle(v4, 1, false)
                Services_m.Debris(v4, 4)

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
