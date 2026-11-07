-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.ElkStomp
-- Class: ModuleScript
-- bytes: 4485

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.VFX
local rng = Random.new()
local g_require_1 = require
local CurrentCamera = workspace.CurrentCamera
g_require_1(ReplicatedStorage.Modules:FindFirstChild("CameraShaker")).new(Enum.RenderPriority.Camera.Value, function(
    arg1
) -- line: 11
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end):Start()
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local CircleGrow_m = require(ReplicatedStorage.Modules.CircleGrow)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map }
raycastParams.FilterType = Enum.RaycastFilterType.Include

function Attack(u1: CFrame, arg2: any) -- line: 25
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] rng (copy)
    --  [3] Utility_m (copy)
    --  [4] CircleGrow_m (copy)
    --  [5] raycastParams (copy)

    if (u1.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 then
        return
    end

    local Material = arg2.Material
    local v3 = arg2:IsA("Terrain") and workspace.Terrain:GetMaterialColor(Material) or arg2.Color
    local v5 = script.SlamContact:Clone()
    v5.CFrame = u1
    v5.Parent = workspace.Effects
    _G.Debris(v5, 5)
    _G.PlaySound(
        ReplicatedStorage.SFX.Explosions.Explosion5,
        v5,
        500,
        1,
        rng:NextNumber(1, 2),
        nil
    )
    wait()
    local v9 = pairs

    for _, val in v9(v5:GetDescendants()) do
        if val:IsA("ParticleEmitter") then
            if not val.Name:match("Smoke") then
                if val.Name:match("Rock") then
                    val.Color = ColorSequence.new(v3)
                end
            else
                val.Color = ColorSequence.new(v3)
            end
        end
    end

    Utility_m.EmitParticles(v5)
    _G.CameraShake("Explosion")
    _G.GetModule("RockParts")(
        u1 * CFrame.new(0, 0.5, 0),
        7,
        NumberRange.new(2, 5),
        { XZ = 40, Y = 65, Y2 = 95 },
        arg2
    )
    v3 = (Vector3.new(3.5, 3.5, 3.5)).Y * rng:NextInteger(50, 120) / 100
    local vec3 = Vector3.new(8.666666666666666, v3, v3)
    local v20, v21 = CircleGrow_m:CircleGrowConnected(
        nil,
        10,
        vec3,
        13,
        nil,
        u1 * CFrame.new(0, 1, 0)
    )

    for key_1, val_1 in pairs(v20) do
        local v22, v23 = v21(key_1 * 0.6283185307179586, 13)
        local Position_1 = (u1 * CFrame.new(v22, 0, v23)).Position
        _G.FastSpawn(function() -- line: 78
            -- upvalues:
            --  [1] vec3 (ref)
            --  [2] rng (ref)
            --  [3] val_1 (copy)
            --  [4] Position_1 (copy)
            --  [5] raycastParams (ref)

            local v27 = vec3.Y * rng:NextInteger(50, 120) / 100
            local vec3_1 = Vector3.new(8.666666666666666, v27, v27)
            local v28 = val_1:Clone()
            v28.Position += Vector3.new(0, 0.5, 0)
            local v29 = nil
            local EasingDirection_Out = Enum.EasingDirection.Out
            local t = { Size = vec3_1, Position = nil }
            local v30 = Position_1
            local Tween = _G.Tween
            t.Position = v30
            local v31 = Tween(v28, { 0.2, "Smooth", EasingDirection_Out }, t)
            v31.Completed:Connect(function() -- line: 87
                -- upvalues:
                --  [1] v29 (ref)

                v29 = true
            end)

            while not v29 do
                local v32 = workspace:Raycast(v28.Position, Vector3.new(0, -6, 0), raycastParams)

                if v32 then
                    local Position = v32.Position
                    val_1.Size = v28.Size
                    val_1.Position = Position
                else
                    v31:Stop()
                    break
                end

                task.wait()
            end

            v28:Destroy()
            task.delay(4, function() -- line: 106
                -- upvalues:
                --  [1] val_1 (ref)

                _G.Tween(
                    val_1,
                    { 0.25, "Smooth", Enum.EasingDirection.Out },
                    { Transparency = 1, Size = Vector3.new(0, 0, 0) },
                    true
                )
            end)
        end)
    end

    for key_2, _ in pairs(v20) do
        v20[key_2] = nil
    end
end

return Attack
