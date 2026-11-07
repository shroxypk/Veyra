-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Wind.nado
-- Class: ModuleScript
-- bytes: 2523

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local TweenService = Services_m.TweenService
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local _ = _G.GetModule("Effects")
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

return function(arg1, arg2, arg3) -- line: 20
    -- upvalues:
    --  [1] GrimoireRarity_m (copy)
    --  [2] Utility_m (copy)
    --  [3] TweenService (copy)

    if (arg2.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    local v2 = GrimoireRarity_m:GetPlayerVariant(arg3)

    if arg1 == "TornadoActive" then
        local v3 = script.Tornado:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v3, v2)
        v3.PrimaryPart.CFrame = arg2 * CFrame.Angles(0, 0, 0)
        Utility_m.Toggle(v3, true)

        for _, val in pairs(v3:GetChildren()) do
            if val:IsA("BasePart") then
                TweenService:Create(
                    val,
                    TweenInfo.new(
                        0.5,
                        Enum.EasingStyle.Linear,
                        Enum.EasingDirection.Out,
                        -1,
                        false
                    ),
                    { Orientation = val.Orientation + Vector3.new(0, -360, 0) }
                ):Play()
            end
        end

        v3.Parent = workspace.Effects
        local v6 = Utility_m.CreateWeld(arg3.HumanoidRootPart, v3.PrimaryPart)
        task.delay(0.1, function() -- line: 42
            -- upvalues:
            --  [1] v3 (copy)
            --  [2] TweenService (ref)
            --  [3] v6 (copy)

            for _, child in pairs(v3:GetChildren()) do
                if child:IsA("BasePart") then
                    TweenService:Create(
                        child,
                        TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                        { Transparency = 1 }
                    ):Play()
                end
            end

            v6:Destroy()
        end)
        task.wait(0.2)
        Utility_m.Toggle(v3, false)
        _G.Debris(v3, 1)
        _G.Debris(v6, 1)
    end
end
