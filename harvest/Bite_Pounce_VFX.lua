-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Wolf.Bite_Pounce_VFX
-- Class: ModuleScript
-- bytes: 2222

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

    local Highlight, LowerMouth, LowerMouth_1

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
            LowerMouth = u1:FindFirstChild("LowerMouth", true)

            if LowerMouth then
                local v3 = ReplicatedStorage.Effects.MagicFX.Wolf.Wolf_Bite_Assets.Charge_Bite_Pounce:Clone()
                v3.Parent = LowerMouth
                Effects:CleanEmitParticle(v3, 1)
                Services_m.Debris(v3, 1)

                return
            end
        elseif arg1 == 1 then
            LowerMouth_1 = u1:FindFirstChild("LowerMouth", true)

            if LowerMouth_1 then
                local v4 = ReplicatedStorage.Effects.MagicFX.Wolf.Wolf_Bite_Assets.Bite_Pounce_Hit:Clone()
                v4.Parent = LowerMouth_1
                Effects:CleanEmitParticle(v4, 2)
                Services_m.Debris(v4, 3)

                return
            end
        else
            warn("No Args for Howling Move")
        end

        return
    else
        return
    end
end

return main
