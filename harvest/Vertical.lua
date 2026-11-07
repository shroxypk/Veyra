-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Vertical
-- Class: ModuleScript
-- bytes: 3938

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.HttpService
local VFX = Services_m.VFX
local _ = Random.new()
local _ = ReplicatedStorage.Effects.WeaponFX.SkyDiveSmash
local CameraShaker_m = require(ReplicatedStorage.Modules:FindFirstChild("CameraShaker"))
local CurrentCamera = workspace.CurrentCamera
CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 15
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end):Start()
local Effects = _G.GetModule("Effects")
local DebrisCircle = _G.GetModule("DebrisCircle")
local Utility_m = require(ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace:FindFirstChild("MapMisc") }
raycastParams.FilterType = Enum.RaycastFilterType.Include

return function(arg2, arg3, ...) -- line: 29
    -- upvalues:
    --  [1] raycastParams (copy)
    --  [2] DebrisCircle (copy)
    --  [3] Utility_m (copy)
    --  [4] ReplicatedStorage (copy)
    --  [5] Effects (copy)
    --  [6] VFX (copy)

    if not arg2 or not arg2.PrimaryPart or (arg2.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    local PrimaryPart = arg2.PrimaryPart
    local v3 = ...

    if arg3 == "Strike" then
        local _ = Enum.Material.Slate
        local v4 = Color3.fromRGB(104, 104, 104)
        local Position_1 = v3.Position
        local v6 = workspace:Raycast(v3.Position, Vector3.new(0, -15, 0), raycastParams)

        if v6 and v6.Instance then
            local Material = v6.Material
            v4 = v6.Instance:IsA("Terrain") and workspace.Terrain:GetMaterialColor(Material) or v6.Instance.Color
            Position_1 = v6.Position
            local v8 = v6.Instance
            _G.GetModule("RockParts")(
                CFrame.new(Position_1) * CFrame.new(0, 0.5, 0),
                4,
                NumberRange.new(1, 4),
                { XZ = 10, Y = 75, Y2 = 85 },
                v8
            )
            local cframe_1 = CFrame.new(v6.Position)
            DebrisCircle.ConnectedCircle(
                nil,
                12,
                2,
                10,
                nil,
                cframe_1 * CFrame.new(0, 1, 0)
            )
        end

        local v10 = script.GroundSmash:Clone()
        v10.Position = Position_1
        v10.Parent = workspace.Effects
        _G.Debris(v10, 4)
        wait()

        for _, val in pairs(v10:GetDescendants()) do
            if val:IsA("ParticleEmitter") then
                if not val.Name:match("Smoke") then
                    if not val.Name:match("Rock") then
                        if val.Name:match("Shock") then
                            val.Color = ColorSequence.new(v4)
                        end
                    else
                        val.Color = ColorSequence.new(v4)
                    end
                else
                    val.Color = ColorSequence.new(v4)
                end
            end
        end

        Utility_m.EmitParticles(v10)

        return
    end

    if arg3 == "Lift" then
        _G.PlaySound(
            ReplicatedStorage.SFX.Skills.Lift,
            PrimaryPart,
            nil,
            1,
            nil,
            nil
        )
        local v12 = workspace:Raycast(PrimaryPart.Position, Vector3.new(0, -15, 0), raycastParams)

        if v12 and v12.Instance then
            local Color = v12.Instance.Color
            local Position = v12.Position
            local v13 = script.Lift:Clone()
            v13.Position = Position
            v13.Parent = workspace.Effects
            Effects:SetParticleColor(v13, Color, "Smoke")
            VFX.Emit2(v13, true)
            _G.Debris(v13, 2)
        end
    end
end
