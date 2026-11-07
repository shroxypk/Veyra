-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Flame.ScorchingBarrage
-- Class: ModuleScript
-- bytes: 4410

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local GrimoireRarity_m = require(ReplicatedStorage.Modules.GrimoireRarity)
local VFX = Services_m.VFX
local Effects = _G.GetModule("Effects")
local MagicCircle = _G.GetModule("MagicCircle")
local CameraShaker_m = require(ReplicatedStorage.Modules:FindFirstChild("CameraShaker"))
local CurrentCamera = workspace.CurrentCamera
local v3 = CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 17
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end)
v3:Start()
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }

local function main(arg2, arg3, arg4) -- line: 26
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] GrimoireRarity_m (copy)
    --  [3] MagicCircle (copy)
    --  [4] v3 (copy)
    --  [5] raycastParams (copy)
    --  [6] Effects (copy)
    --  [7] VFX (copy)
    --  [8] Services_m (copy)
    --  [9] ReplicatedStorage (copy)

    local _, v5 = CurrentCamera:WorldToScreenPoint(arg4.Position)

    if not v5 or (CurrentCamera.CFrame.Position - arg4.Position).Magnitude > 300 then
        return
    end

    local v6 = GrimoireRarity_m:GetPlayerVariant(arg3)

    if arg2 == "WindUp" then
        local v7 = script.WindUp.Trail:Clone()
        local v8 = script.WindUp.Trail2:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v7, v6)
        GrimoireRarity_m:ApplyVariantEffect(v8, v6)
        v7.Parent = arg3["Left Arm"]
        v7.Trail.Attachment1 = v8
        v8.Parent = arg3["Left Arm"]
        v7.Trail.Enabled = true
        task.delay(0.4, function() -- line: 48
            -- upvalues:
            --  [1] v7 (copy)

            if v7.Trail then
                v7.Trail.Enabled = false
            end
        end)

        return
    end

    if arg2 == "Start" then
        local v9 = MagicCircle.new(Color3.fromRGB(765, 255, 0), 1.2)
        GrimoireRarity_m:ApplyVariantEffect(v9.Part, v6)
        v9.Part.CFrame = arg4 * CFrame.new(0, 18, 0)
        v9.Part.Mesh.Scale = Vector3.new()
        _G.Tween(v9.Part.Mesh, { 0.5, "Expo", "Out" }, { Scale = Vector3.new(6, 1, 6) })

        return
    end

    if arg2 == "BigStart" then
        local v10 = MagicCircle.new(Color3.fromRGB(765, 255, 0), 1.2)
        GrimoireRarity_m:ApplyVariantEffect(v10.Part, v6)
        v10.Part.CFrame = arg4 * CFrame.new(0, 19, 0)
        v10.Part.Mesh.Scale = Vector3.new()
        _G.Tween(v10.Part.Mesh, { 0.5, "Expo", "Out" }, { Scale = Vector3.new(9, 1, 9) })

        return
    end

    if arg2 == "BigImpact" then
        v3:ShakeOnce(8, 8, 0, 0.275)
        local v12 = workspace:Raycast(
            arg4.Position + Vector3.new(0, 5, 0),
            Vector3.new(0, -20, 0),
            raycastParams
        )
        local Color = nil

        if v12 and v12.Instance then
            Color = v12.Instance.Color
            arg4 = CFrame.new(v12.Position)
            _G.GetModule("RockParts")(arg4, 5, NumberRange.new(1, 3), { XZ = 35, Y = 60, Y2 = 100 })
        end

        local v14 = script.BigImpact:Clone()
        v14.CFrame = arg4
        GrimoireRarity_m:ApplyVariantEffect(v14, v6)
        Effects:SetParticleColor(v14, Color, "Smoke")
        v14.Parent = workspace.Effects
        VFX.Emit2(v14, true)
        Services_m.Debris(v14, 4)
        Services_m.PlaySound(
            ReplicatedStorage.SFX.Explosions.Explosion5,
            v14,
            200,
            1,
            1.5,
            nil
        )

        return
    end

    _G.CameraShake("SmallestBump")
    local v16 = workspace:Raycast(
        arg4.Position + Vector3.new(0, 5, 0),
        Vector3.new(0, -20, 0),
        raycastParams
    )

    if v16 and v16.Instance then
        arg4 = CFrame.new(v16.Position)
    end

    local v17 = script.Impact:Clone()
    v17.CFrame = arg4
    GrimoireRarity_m:ApplyVariantEffect(v17, v6)
    v17.Parent = workspace.Effects
    VFX.Emit2(v17, true)
    Services_m.Debris(v17, 4)
    Services_m.PlaySound(
        ReplicatedStorage.SFX.Explosions.Explosion5,
        v17,
        200,
        1,
        nil,
        nil
    )
end

return main
