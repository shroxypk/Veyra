-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Misc.ManaShield_FX
-- Class: ModuleScript
-- bytes: 2417

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local _ = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local VFX_m = require(Modules.Shared.VFX)
local CameraShaker_m = require(Modules.CameraShaker)
local _ = require(Modules.GrimoireRarity)
local ForgeVFX_m = require(Modules.Packages.ForgeVFX)
local CurrentCamera = workspace.CurrentCamera
local v2 = CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 18
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end)
local t = {}
VFX_m.init()
v2:Start()

return function(s1: string, u1: userdata, n1: number, ...) -- line: 27
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] Services_m (copy)
    --  [4] t (copy)
    --  [5] ForgeVFX_m (copy)

    if (u1.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    local _ = (CurrentCamera.CFrame.Position - u1.PrimaryPart.Position).Magnitude

    if s1 == "Spawn" then
        local v3 = ReplicatedStorage.Effects.Skills.ManaShield_FX.ShieldFX:Clone()
        Services_m.Debris(v3, 20)
        t[n1 .. "Shield"] = v3
        v3.Position = Vector3.new(0, 0, 0)
        v3.Parent = u1.HumanoidRootPart

        for _, child in v3:GetChildren() do
            local Size = child.Size
            local Transparency = child.Transparency
            child.Size = NumberSequence.new(0)
            child.Transparency = NumberSequence.new(1)
            _G.Tween(
                child,
                { 0.25, "Linear", Enum.EasingDirection.Out },
                { Size = Size, Transparency = Transparency }
            )
            ForgeVFX_m.enable(child)
        end

        return
    end

    if s1 == "Delete" and t[n1 .. "Shield"] then
        local v4 = t[n1 .. "Shield"]

        for _, child_1 in v4:GetChildren() do
            local t_2 = { Transparency = NumberSequence.new(1) }
            _G.Tween(child_1, { 0.15, "Linear", Enum.EasingDirection.Out }, t_2)
            local t_4 = { Size = NumberSequence.new(3) }
            _G.Tween(child_1, { 0.25, "Linear", Enum.EasingDirection.Out }, t_4)
        end

        Services_m.Debris(v4, 1)
    end
end
