-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Misc.Rampage_FX
-- Class: ModuleScript
-- bytes: 3642

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

local function main(s1: string, u1: userdata, n1: number, ...) -- line: 27
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] Services_m (copy)
    --  [4] t (copy)
    --  [5] ForgeVFX_m (copy)
    --  [6] v2 (copy)

    if not u1 or (u1.PrimaryPart.Position - CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    if s1 == "Rush" then
        local PrimaryPart = u1.PrimaryPart
        local _ = (CurrentCamera.CFrame.Position - u1.PrimaryPart.Position).Magnitude
        local _ = u1:FindFirstChild("Right Arm")
        local v3 = ReplicatedStorage.Effects.Skills.Rampage_FX.Rush:Clone()
        Services_m.Debris(v3, 6)
        t[n1 .. "RushFX"] = v3
        v3:PivotTo(PrimaryPart.CFrame * CFrame.Angles(0, 1.5707963267948966, 0))
        local WeldConstraint = Instance.new("WeldConstraint")
        WeldConstraint.Part0 = v3
        WeldConstraint.Part1 = PrimaryPart
        v3.Parent = workspace.Effects
        WeldConstraint.Parent = v3
        ForgeVFX_m.enable(v3)

        for _, val in v3:QueryDescendants("Beam") do
            val.Enabled = true
        end

        return
    end

    if s1 == "Jump" then
        local PrimaryPart_1 = u1.PrimaryPart
        local v5 = t[n1 .. "RushFX"]
        local _ = (CurrentCamera.CFrame.Position - u1.PrimaryPart.Position).Magnitude
        local v6 = ReplicatedStorage.Effects.Skills.Rampage_FX.Jump:Clone()
        Services_m.Debris(v6, 4)
        v6.CFrame = PrimaryPart_1.CFrame * CFrame.new(0, -2.5, 0)
        v6.Parent = workspace.Effects
        ForgeVFX_m.emit(v6)
        Services_m.PlaySound(ReplicatedStorage.SFX.Skills.Rampage.JumpImpact, PrimaryPart_1)

        if v5 then
            ForgeVFX_m.disable(v5)

            for _, _ in v5:QueryDescendants("Beam") do
            end

            task.delay(2, function() -- line: 76
                -- upvalues:
                --  [1] v5 (copy)

                v5:Destroy()
            end)

            return
        end
    elseif s1 == "Slam" then
        local Magnitude_2 = (CurrentCamera.CFrame.Position - u1.PrimaryPart.Position).Magnitude
        local PrimaryPart_2 = u1.PrimaryPart
        local v8 = ReplicatedStorage.Effects.Skills.Rampage_FX.Slam:Clone()
        Services_m.Debris(v8, 5)
        v8:PivotTo(PrimaryPart_2.CFrame * CFrame.new(0, -2.5, -3.5))
        ForgeVFX_m.emit(v8)

        if Magnitude_2 < 100 then
            v2:ShakeOnce(2.5, 20, 0, 0.45)

            return
        end
    elseif s1 == "Cleanup" and t[n1 .. "RushFX"] then
        local v11 = t[n1 .. "RushFX"]
        ForgeVFX_m.disable(v11)
        task.delay(2, function() -- line: 100
            -- upvalues:
            --  [1] v11 (copy)
            --  [2] t (ref)
            --  [3] n1 (copy)

            v11:Destroy()
            t[n1 .. "RushFX"] = nil
        end)
    end
end

return main
