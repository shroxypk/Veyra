-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Time.PalmSkill
-- Class: ModuleScript
-- bytes: 2457

local GrimoireRarity_m = require(game:GetService("ReplicatedStorage").Modules.GrimoireRarity)

local _ = function(arg1) --[[ __getVariant ]] -- line: 3
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)

    if typeof(arg1) ~= "Instance" then
        return nil
    end

    return GrimoireRarity_m:GetSkillVariant(arg1, "Time")
end

local _ = function(arg2, arg3) --[[ __tintVariant ]] -- line: 7
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)

    if arg3 then
        if typeof(arg2) ~= "Instance" then
            return
        end

        GrimoireRarity_m:ApplyVariantEffect(arg2, arg3)

        if not arg2:IsA("BasePart") then
            GrimoireRarity_m:ApplyVariantEffect(arg2, arg3, true)
        end

        return
    else
        return
    end
end

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local _ = Services_m.TweenService
local Utility_m = require(Services_m.ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

local _ = function(arg4, arg5, arg6) --[[ Weld ]] -- line: 29
    local Weld = Instance.new("Weld")
    Weld.Name = arg4.Name .. "Weld"
    Weld.Part0 = arg4
    Weld.Part1 = arg5
    Weld.C0 = arg6
    Weld.Parent = arg5
end

return function(arg7, arg8, arg9) -- line: 39
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] Utility_m (copy)

    local v3 = if typeof(arg9) ~= "Instance" then nil else GrimoireRarity_m:GetSkillVariant(
        arg9,
        "Time"
    )
    local PrimaryPart = arg9.PrimaryPart

    if arg7 == "Palm" then
        local cframe = CFrame.new(0, 0, -3)
        local v4 = script.Palm:Clone()

        if v3 and typeof(v4) == "Instance" then
            GrimoireRarity_m:ApplyVariantEffect(v4, v3)

            if not v4:IsA("BasePart") then
                GrimoireRarity_m:ApplyVariantEffect(v4, v3, true)
            end
        end

        v4.CFrame = arg8 * cframe
        v4.Parent = workspace.Effects
        local Weld_2 = Instance.new("Weld")
        Weld_2.Name = PrimaryPart.Name .. "Weld"
        Weld_2.Part0 = PrimaryPart
        Weld_2.Part1 = v4
        Weld_2.C0 = cframe
        Weld_2.Parent = v4
        Utility_m.EmitParticles(v4)
        _G.Debris(v4, 2)
    end
end
