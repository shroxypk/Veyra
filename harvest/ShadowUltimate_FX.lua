-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Ultimates.ShadowUltimate_FX
-- Class: ModuleScript
-- bytes: 4287

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local VFX_m = require(Modules.Shared.VFX)
local CameraShaker_m = require(Modules.CameraShaker)
local GrimoireRarity_m = require(Modules.GrimoireRarity)
local _ = require(Modules.Shared.ScreenFlash)
local Shadow = ReplicatedStorage.Effects.VFX.Shadow
local CurrentCamera = workspace.CurrentCamera
local v2 = CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 22
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end)
local t = {
    Startup = { StartUp = Shadow["1_Startup"].StartUp },
    Attacks = {
        TorsoEmit = Shadow["2_Attacks"].TorsoEmit,
        TorsoEffects = Shadow["2_Attacks"].TorsoEffects,
        Spiral = Shadow["2_Attacks"].Spiral
    }
}

local _ = function(u1: userdata) --[[ getAnchorRoot ]] -- line: 62
    return (u1:FindFirstChild("HumanoidRootPart"))
end

local _ = function(u2: userdata, vec1: Vector3, b1: boolean) --[[ getFootCFrame ]] -- line: 71
    local HumanoidRootPart = u2:FindFirstChild("HumanoidRootPart")

    if not HumanoidRootPart then
        return nil
    end

    local v4 = HumanoidRootPart.CFrame * CFrame.new(vec1 + Vector3.new(0, -3, 0))

    if b1 then
        return v4
    end

    return (CFrame.new(v4.Position))
end

local _ = function(u3: userdata) --[[ fireStartUp ]] -- line: 81
    -- upvalues:
    --  [1] VFX_m (copy)
    --  [2] t (copy)

    local HumanoidRootPart_1 = u3:FindFirstChild("HumanoidRootPart")

    if not HumanoidRootPart_1 then
        return
    end

    VFX_m.burstAttached(t.Startup.StartUp, HumanoidRootPart_1, CFrame.new(Vector3.new(0, -3, 0)), 2)
end

local function fireTorsoBurst(u4: userdata, n1: number) -- line: 96
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] t (copy)
    --  [3] VFX_m (copy)

    local Torso = u4:FindFirstChild("Torso")

    if not Torso then
        return
    end

    local v5 = GrimoireRarity_m:GetPlayerVariant(u4)
    local t_3 = {}
    table.insert(t_3, t.Attacks.TorsoEmit:Clone())
    table.insert(t_3, t.Attacks.TorsoEffects:Clone())
    GrimoireRarity_m:ApplyVariantEffect(t_3, v5)
    VFX_m.burstOnto(t_3[1], Torso)

    if n1 == 1 then
        VFX_m.burstOnto(t_3[2], Torso)
    end

    for _, val in t_3 do
        val:Destroy()
    end
end

local function fireAttack(u5: userdata, u6: CFrame, n2: number) -- line: 125
    -- upvalues:
    --  [1] fireTorsoBurst (copy)
    --  [2] GrimoireRarity_m (copy)
    --  [3] t (copy)
    --  [4] VFX_m (copy)

    fireTorsoBurst(u5, n2)
    local v6 = GrimoireRarity_m:GetPlayerVariant(u5)
    local t_4 = {}
    table.insert(t_4, t.Attacks.Spiral:Clone())
    GrimoireRarity_m:ApplyVariantEffect(t_4, v6)
    VFX_m.burst(t_4[1], u6)

    for _, val_1 in t_4 do
        val_1:Destroy()
    end
end

local t_5 = { Offset = Vector3.new(0, 0, 0), WeldToRoot = true, MinLifetime = 2 }
local _ = { TorsoLimbName = "Torso", TorsoEffectsOnStep = 1 }
v2:Start()
VFX_m.init()
VFX_m.preload({ Shadow })

local function main(s1: string, u7: userdata, u8: CFrame, n3: number) -- line: 148
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] t_5 (copy)
    --  [3] VFX_m (copy)
    --  [4] t (copy)
    --  [5] fireAttack (copy)

    if not u7 or not u7.PrimaryPart then
        return
    end

    if (CurrentCamera.CFrame.Position - u7.PrimaryPart.Position).Magnitude > 500 then
        return
    end

    if s1 == "Start" then
        local HumanoidRootPart_2 = u7:FindFirstChild("HumanoidRootPart")

        if not HumanoidRootPart_2 then
            return
        end

        local cframe_1 = CFrame.new(t_5.Offset + Vector3.new(0, -3, 0))

        if t_5.WeldToRoot then
            VFX_m.burstAttached(t.Startup.StartUp, HumanoidRootPart_2, cframe_1, t_5.MinLifetime)

            return
        end

        VFX_m.burst(t.Startup.StartUp, HumanoidRootPart_2.CFrame * cframe_1)

        return
    else
        if s1 == "Attack" then
            fireAttack(u7, u8, n3)

            return
        end

        return
    end
end

return main
