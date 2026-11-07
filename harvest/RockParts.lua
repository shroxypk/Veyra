-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.RockParts
-- Class: ModuleScript
-- bytes: 2423

local _ = require(game:GetService("ReplicatedFirst").Services).ReplicatedStorage
local rng = Random.new()
local _ = { workspace.Map }

return function(
    arg1,
    arg2,
    arg3,
    arg4,
    arg5
) -- line: 9
    -- upvalues:
    --  [1] rng (copy)

    if typeof(arg1) == "Vector3" then
        arg1 = CFrame.new(arg1)
    end

    local v1 = script.DebrisBlock:Clone()
    arg4 = arg4 or { XZ = 50, Y = 60, Y2 = 100 }

    for _ = 1, arg2 do
        _G.FastSpawn(function() -- line: 20
            -- upvalues:
            --  [1] v1 (copy)
            --  [2] arg1 (ref)
            --  [3] rng (ref)
            --  [4] arg5 (copy)
            --  [5] arg3 (copy)
            --  [6] arg4 (ref)

            local v3 = v1:Clone()
            v3.Name = "briks"
            v3.CFrame = arg1 * CFrame.new(rng:NextInteger(-5, 5), 0, rng:NextInteger(-5, 5)) * CFrame.Angles(
                rng:NextInteger(-45, 45),
                rng:NextInteger(-45, 45),
                rng:NextInteger(-45, 45)
            )
            v3.Material = arg5 and arg5.Material or Enum.Material.Slate

            if arg5 and arg5.MaterialVariant ~= "" then
                v3.MaterialVariant = arg5.MaterialVariant
            end

            v3.TopSurface = Enum.SurfaceType.Smooth
            v3.BottomSurface = Enum.SurfaceType.Smooth
            v3.Color = arg5 and arg5.Color or Color3.fromRGB(95, 89, 74)
            local v11 = rng:NextNumber(arg3.Min, arg3.Max)
            local v12 = rng:NextNumber(arg3.Min, arg3.Max)
            v3.Size = Vector3.new(v11, v12, rng:NextNumber(arg3.Min, arg3.Max))
            local v14 = rng:NextNumber(-arg4.XZ, arg4.XZ)
            local v15 = rng:NextNumber(arg4.Y, arg4.Y2)
            v3.Velocity = Vector3.new(v14, v15, rng:NextNumber(-arg4.XZ, arg4.XZ))
            local BodyVelocity = Instance.new("BodyVelocity")
            local v18 = rng:NextInteger(-arg4.XZ, arg4.XZ)
            local v19 = rng:NextInteger(arg4.Y, arg4.Y2)
            BodyVelocity.Velocity = Vector3.new(v18, v19, rng:NextInteger(-arg4.XZ, arg4.XZ))
            BodyVelocity.Parent = v3
            v3.Parent = workspace.Effects
            BodyVelocity:Destroy()
            task.wait(0.35)
            _G.Tween(
                v3,
                { 0.5, "Smooth", Enum.EasingDirection.Out },
                { Size = Vector3.new(0, 0, 0) },
                true
            )
        end)
    end
end
