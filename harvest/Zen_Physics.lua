-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Zen_Physics
-- Class: ModuleScript
-- bytes: 1842

local _ = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local _ = game:GetService("ReplicatedStorage")
local _ = game:GetService("PhysicsService")
local RunService = game:GetService("RunService")

return {
    weldPhysics = function(arg1, arg2, arg3) --[[ weldPhysics ]] -- line: 13
        -- upvalues:
        --  [1] Players (copy)
        --  [2] RunService (copy)

        local v1 = not Players:GetPlayerFromCharacter(arg1)
        local Humanoid = arg1:FindFirstChildWhichIsA("Humanoid")

        if not Humanoid then
            warn("weldPhysics: No Humanoid found in the character.")

            return
        end

        Humanoid.PlatformStand = arg2

        if RunService:IsServer() then
            _G.ToggleCollisions(arg1, not arg2)
        end

        for _, val in ipairs(arg1:GetDescendants()) do
            if val:IsA("BasePart") then
                if val:GetAttribute("OriginalMassless") == nil then
                    val:SetAttribute("OriginalMassless", val.Massless)
                end

                val.Massless = if arg2 then true else val:GetAttribute("OriginalMassless")

                if not arg2 and v1 and val:CanSetNetworkOwnership() then
                    val:SetNetworkOwner(nil)
                end
            elseif arg2 then
                if not val:IsA("BodyVelocity") then
                    if val:IsA("BodyGyro") then
                        val:Destroy()
                    end
                else
                    val:Destroy()
                end
            end
        end

        if arg3 then
            local v4 = not arg2
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, v4)

            if v4 then
                Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
        end
    end
}
