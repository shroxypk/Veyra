-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Dagon.Astral_Authority_Fx.FlyingRocks
-- Class: ModuleScript
-- bytes: 2439

local _ = game:GetService("ReplicatedStorage")
local _ = game:GetService("TweenService")
local Debris = game:GetService("Debris")

return {
    Start = function(
        arg1,
        arg2,
        arg3,
        arg4,
        arg5,
        arg6,
        _
    ) -- line: 8
        -- upvalues:
        --  [1] Debris (copy)

        local Folder = Instance.new("Folder")
        Folder.Parent = workspace.Effects
        local v1 = arg3 or math.random(2, 18)
        local v2 = arg4 or 5

        for _ = 1, arg5 or 5 do
            if arg1 then
                local v3 = script.Rock:Clone()
                v3.Parent = Folder

                if arg6 then
                    for _, val in pairs(v3:GetChildren()) do
                        if val.Name == arg6 then
                            val.Enabled = true
                        end
                    end
                end

                v3.Size = Vector3.new(v1 / v2, v1 / v2, v1 / v2)
                v3.Rotation = Vector3.new(
                    math.random(-360, 360),
                    math.random(-360, 360),
                    math.random(-360, 360)
                )
                v3.Material = arg1.Material
                v3.Color = arg1.Color
                v3.Position = arg2
                local v5 = pairs
                local _ = math.random(-360, 360)

                for _, val_1 in v5(arg1:GetChildren()) do
                    if val_1:IsA("Texture") then
                        val_1:Clone().Parent = v3
                    end
                end

                local BodyVelocity = Instance.new("BodyVelocity")
                BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
                local v7 = math.random(-25, 25)
                BodyVelocity.Velocity = Vector3.new(v7, math.random(45, 50), math.random(-25, 25))
                BodyVelocity.Parent = v3
                Debris:AddItem(BodyVelocity, 0.1)
                task.delay(0.3, function() -- line: 53
                    -- upvalues:
                    --  [1] v3 (copy)
                    --  [2] Debris (ref)

                    v3.CanCollide = true
                    task.wait(2)
                    v3.Anchored = true
                    v3.CanCollide = false
                    v3.Attachment.Rockz:Emit(3)
                    v3.Transparency = 1
                    Debris:AddItem(v3, 3)
                end)
            end
        end
    end
}
