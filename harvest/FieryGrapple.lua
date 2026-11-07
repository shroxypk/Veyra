-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Flame.FieryGrapple
-- Class: ModuleScript
-- bytes: 2334

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local VFX = Services_m.VFX

local function Attack(arg1, arg2, arg3) -- line: 11
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] VFX (copy)
    --  [3] Services_m (copy)

    if not arg3 then
        return
    end

    local v2 = GrimoireRarity_m:GetPlayerVariant(arg2)

    if arg1 == "WindUp" then
        local v3 = script.Part.WindUp:Clone()
        v3.Parent = arg3
        v3.Sound:Play()
        GrimoireRarity_m:ApplyVariantEffect(v3, v2)
        VFX.Emit2(v3)
        Services_m.Debris(v3, 3)

        return
    end

    if arg1 == "Dash" then
        local v4 = script.Dash:Clone()
        v4.Parent = arg3
        v4.PlayOnRemove = true
        v4:Destroy()
        local v5 = script.Part.Dash:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v5, v2)
        v5.Parent = arg3
        VFX.Emit2(v5)
        Services_m.Debris(v5, 4)
        local v6 = script.WindLines:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v6, v2)
        v6.Parent = workspace.Effects
        local Weld = Instance.new("Weld")
        Weld.Part0 = arg3
        Weld.Part1 = v6
        Weld.Parent = v6
        VFX.Enable(v6, true)
        task.delay(0.225, function() -- line: 54
            -- upvalues:
            --  [1] VFX (ref)
            --  [2] v6 (copy)
            --  [3] Services_m (ref)

            VFX.Enable(v6, false)
            Services_m.Debris(v6, 1)
        end)

        return
    end

    if arg1 == "Blast" then
        local v7 = script.Part.BlastWindUp:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v7, v2)
        v7.Parent = arg3
        VFX.Emit2(v7)
        Services_m.Debris(v7, 1)
        local v8 = script.Part.Blast:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v8, v2)
        v8.Parent = arg3
        Services_m.Debris(v8, 10)
        task.delay(0.2, function() -- line: 74
            -- upvalues:
            --  [1] v8 (copy)
            --  [2] VFX (ref)

            v8.Sound:Play()
            v8.Sound2:Play()
            VFX.Emit2(v8)
        end)
    end
end

return Attack
