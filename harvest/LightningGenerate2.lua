-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Effects.LightningGenerate2
-- Class: ModuleScript
-- bytes: 2336

local rng = Random.new()

return function(
    arg1,
    arg2,
    arg3,
    arg4,
    arg5
) -- line: 3
    -- upvalues:
    --  [1] rng (copy)

    task.spawn(function() -- line: 4
        -- upvalues:
        --  [1] arg3 (ref)
        --  [2] arg1 (copy)
        --  [3] arg2 (copy)
        --  [4] arg5 (ref)
        --  [5] rng (ref)
        --  [6] arg4 (copy)

        arg3 = math.clamp(arg3 or 4, 4, 7)
        local Lightning_Folder = Instance.new("Folder", workspace.Effects)
        _G.Debris(Lightning_Folder, 3)
        Lightning_Folder.Name = "Lightning"
        local v1 = arg1
        local v2 = (arg1 - arg2).Magnitude / arg3
        local v3 = arg5

        if not v3 then
            v3 = rng:NextInteger(1, 3) == 1 and Color3.fromRGB(105, 150, 255) or Color3.fromRGB(
                110,
                153,
                202
            )
        end

        arg5 = v3
        local v6, v8

        for index = 1, arg3 do
            local _ = arg3
            local v5 = if index ~= arg3 then false else true
            v6 = if v5 then 0 else rng:NextInteger(-2, 2) * 5
            local v7 = if v5 then 0 else rng:NextInteger(-2, 2) * 5
            v8 = if v5 then 0 else rng:NextInteger(-2, 2) * 5
            v5 = CFrame.new(v1, arg2 + Vector3.new(v6, v7, v8)) * CFrame.new(0, 0, -v2)
            local v8 = (v1 - v5.p).Magnitude
            v7 = arg4.Max / index
            local v6 = Instance.new("Part")
            v6.Material = Enum.Material.Neon
            v6.Color = arg5
            v6.TopSurface = Enum.SurfaceType.SmoothNoOutlines
            v6.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
            v6.CanCollide = false
            v6.Anchored = true
            v6.CastShadow = false
            v6.Size = Vector3.new(v7, v7, v8)
            v6.CFrame = CFrame.lookAt(v1, v5.p) * CFrame.new(0, 0, -v8 / 2)
            v6.Parent = Lightning_Folder
            task.delay(0.05, function() -- line: 40
                -- upvalues:
                --  [1] v6 (copy)
                --  [2] v8 (copy)

                local t = { Size = Vector3.new(0, 0, v8), Transparency = 1 }
                _G.Tween(v6, { 0.125, "Quad", Enum.EasingDirection.Out }, t, true)
            end)
            v1 = v5.p
        end

        task.wait(0.15)
        Lightning_Folder:Destroy()
    end)
end
