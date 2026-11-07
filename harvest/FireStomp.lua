-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Flame.FireStomp
-- Class: ModuleScript
-- bytes: 2153

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local VFX = Services_m.VFX

local function Attack(arg1, arg2) -- line: 11
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] VFX (copy)
    --  [3] Services_m (copy)

    local v2 = arg2

    if v2 then
        v2 = arg2.PrimaryPart
    end

    if not v2 or (v2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 250 then
        return
    end

    local v3 = GrimoireRarity_m:GetPlayerVariant(arg2)

    if arg1 == "WindUp" then
        for _, child in script.Folder:GetChildren() do
            if child:IsA("ParticleEmitter") then
                local v4 = child:Clone()
                v4.Parent = arg2["Right Leg"]
                GrimoireRarity_m:ApplyVariantEffect(v4, v3, true)
                VFX.Emit(v4, v4:GetAttribute("EmitCount"))
                Services_m.Debris(v4, 1)
            elseif child:IsA("Sound") then
                local v5 = child:Clone()
                v5.PlayOnRemove = true
                v5.Parent = arg2["Right Leg"]
                v5:Destroy()
            end
        end

        return
    end

    if arg1 == "Impact" then
        local v6 = script.Sound:Clone()
        v6.PlayOnRemove = true
        v6.Parent = v2
        v6:Destroy()
        local v7 = script.Part.Attachment:Clone()
        local v8 = script.Part.Attachment2:Clone()
        Services_m.Debris({ v7, v8 }, 5)
        GrimoireRarity_m:ApplyVariantEffect(v7, v3)
        GrimoireRarity_m:ApplyVariantEffect(v8, v3)
        v7.Parent = v2
        v8.Parent = v2
        task.spawn(VFX.Emit2, v7)
        task.spawn(VFX.Emit2, v8)
        v8.PointLight.Brightness = 10
        _G.Tween(v8.PointLight, { 0.5, "Quad", "Out" }, { Brightness = 0, Range = 15 })

        if (v2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude <= 100 then
            _G.CameraShake("SmallBump")
        end
    end
end

return Attack
