-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.StatusCombat
-- Class: ModuleScript
-- bytes: 3830

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("ServerStorage")
local _ = game:GetService("CollectionService")
local StateManager_m = require(ReplicatedStorage.Modules.StateManager)
local ResidualShockDamage_m = require(script.Parent.ResidualShockDamage)
local ResidualBurnDamage_m = require(script.Parent.ResidualBurnDamage)
local ResidualPoisonDamage_m = require(script.Parent.ResidualPoisonDamage)

return function(
    arg1,
    arg2,
    arg3,
    arg4,
    arg5
) -- line: 14
    -- upvalues:
    --  [1] Players (copy)
    --  [2] StateManager_m (copy)
    --  [3] ResidualBurnDamage_m (copy)
    --  [4] ResidualPoisonDamage_m (copy)
    --  [5] Services_m (copy)
    --  [6] ReplicatedStorage (copy)
    --  [7] ResidualShockDamage_m (copy)

    local _ = Players:GetPlayerFromCharacter(arg1)
    local playerFromCharacter_1 = Players:GetPlayerFromCharacter(arg2)
    local PrimaryPart = arg2.PrimaryPart
    local v2 = StateManager_m.require(arg1)
    local v3 = StateManager_m.require(arg2)

    if v3:IsBurning() and arg1:FindFirstChild("Amplified Wrath") then
        return arg5 * 1.1
    end

    if arg3 == "Fire" then
        ResidualBurnDamage_m(arg1, arg2)

        return arg5
    end

    if arg3 == "Poison" then
        ResidualPoisonDamage_m(arg1, playerFromCharacter_1, nil, arg2)

        return arg5
    end

    local v4

    if arg3 ~= "Electric" then
        if not v2:HasState("PurpleLightning") then
            if v2:HasState("LTNG_M1S") then
                v4 = v2:HasState("PurpleLightning") and Color3.fromRGB(170, 85, 255) or arg4

                if v2:HasState("LTNG_M1S") then
                    local v5 = v4
                    v4 = Color3.fromRGB(170, 85, 255) or v5
                else
                    v4 = v4
                end

                Services_m.PlaySound(
                    ReplicatedStorage.SFX.Effects.Lightning,
                    PrimaryPart,
                    nil,
                    nil,
                    2,
                    nil
                )
                ResidualShockDamage_m(arg1, arg2, v4, 2)

                return arg5
            end

            if arg3 == "Light" and arg1:FindFirstChild("Blindstrike") and playerFromCharacter_1 and not v3:HasState(
                "BlindCooldown"
            ) then
                ReplicatedStorage.Remotes.Client.ScreenFX:FireClient(
                    playerFromCharacter_1,
                    "BlindLight"
                )
                v2:AddState("BlindCooldown", 7)
            end

            return arg5
        else
            v4 = v2:HasState("PurpleLightning") and Color3.fromRGB(170, 85, 255) or arg4

            if v2:HasState("LTNG_M1S") then
                local v6 = v4
                v4 = Color3.fromRGB(170, 85, 255) or v6
            else
                v4 = v4
            end

            Services_m.PlaySound(
                ReplicatedStorage.SFX.Effects.Lightning,
                PrimaryPart,
                nil,
                nil,
                2,
                nil
            )
            ResidualShockDamage_m(arg1, arg2, v4, 2)

            return arg5
        end
    else
        v4 = v2:HasState("PurpleLightning") and Color3.fromRGB(170, 85, 255) or arg4

        if v2:HasState("LTNG_M1S") then
            local v7 = v4
            v4 = Color3.fromRGB(170, 85, 255) or v7
        else
            v4 = v4
        end

        Services_m.PlaySound(
            ReplicatedStorage.SFX.Effects.Lightning,
            PrimaryPart,
            nil,
            nil,
            2,
            nil
        )
        ResidualShockDamage_m(arg1, arg2, v4, 2)

        return arg5
    end
end
