-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Lightning.Lightning Barrage
-- Class: ModuleScript
-- bytes: 1899

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage.Modules
local VFX = Services_m.VFX
local StateManager_m = require(Modules.StateManager)
local GrimoireRarity_m = require(Modules.GrimoireRarity)

local function Attack(arg1, arg2, _, ...) -- line: 15
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] StateManager_m (copy)
    --  [3] VFX (copy)
    --  [4] ReplicatedStorage (copy)

    local _ = ({ ... })[1]
    local _ = { workspace.Map }
    local HumanoidRootPart = arg1:FindFirstChild("HumanoidRootPart")
    local v3 = GrimoireRarity_m:GetPlayerVariant(arg1)

    if arg2 == "V" then
        local DragBV_BodyVelocity = Instance.new("BodyVelocity")
        DragBV_BodyVelocity.Name = "DragBV"
        DragBV_BodyVelocity.MaxForce = Vector3.new(Infinity, 0, Infinity)
        DragBV_BodyVelocity.Velocity = HumanoidRootPart.CFrame.LookVector * 20
        DragBV_BodyVelocity.Parent = HumanoidRootPart
        _G.Debris(DragBV_BodyVelocity, 0.3)

        return
    end

    if arg2 == "FX" then
        local v4 = StateManager_m.require(arg1)

        while arg1 do
            if not arg1.Parent then
                break
            end

            if not v4:HasState("UsingBarrage") then
                break
            end

            local v5 = HumanoidRootPart.CFrame
            local v6 = script.Particles:Clone()
            _G.Debris(v6, 1)
            GrimoireRarity_m:ApplyVariantEffect(v6, v3)
            v6.CFrame = v5 * CFrame.new(0, 0, -3.5) * CFrame.Angles(0, 1.5707963267948966, 0)
            v6.Parent = workspace.Effects
            VFX.Emit2(v6, true)
            _G.PlaySound(ReplicatedStorage.SFX.Skills.LightningBarrage, v5)
            task.wait(0.1)
        end
    end
end

return Attack
