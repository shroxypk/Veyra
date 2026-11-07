-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Dire Wolf.Terror_Howl_VFX.UpRocks
-- Class: ModuleScript
-- bytes: 3517

local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")

return {
    Start = function(
        arg1,
        arg2,
        arg3,
        arg4,
        arg5
    ) -- line: 6
        -- upvalues:
        --  [1] TweenService (copy)
        --  [2] Debris (copy)

        local ROCKS_Folder = Instance.new("Folder")
        ROCKS_Folder.Name = "ROCKS"
        ROCKS_Folder.Parent = workspace.Effects

        for index = 1, arg2 do
            task.wait(0.04)

            for index_1 = 1, math.random(5, 10) do
                task.wait()
                local v2 = math.sin(index * 360) * math.random(5, 50)
                local v4 = Vector3.new(v2, 0, math.cos(index * 360) * math.random(5, 50)) + arg1.HumanoidRootPart.CFrame * arg5.Position
                local v5 = CFrame.new(v4).UpVector * -10
                local raycastParams = RaycastParams.new()
                raycastParams.FilterDescendantsInstances = { arg1, workspace.Effects }
                raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                raycastParams.IgnoreWater = true
                local v6 = workspace:Raycast(v4, v5, raycastParams)
                local _ = math.random(5, 10)

                if v6 then
                    local v8 = v6.Instance or nil
                    local _ = v6.Normal or nil

                    if v8 then
                        local v10 = v6.Position or nil
                        local v11 = game.ReplicatedStorage.Effects.MagicFX.DireWolf.wolfblock:Clone()
                        local v12 = math.random(20, 50) / 200
                        v11.Size = Vector3.new(
                            v12,
                            math.random(20, 50) / 200,
                            math.random(20, 50) / 200
                        ) * index_1
                        v11.Position = v10
                        local v14 = math.random(-360, 360)
                        v11.Rotation = Vector3.new(
                            v14,
                            math.random(-360, 360),
                            math.random(-360, 360)
                        )
                        v11.Transparency = 0
                        v11.Color = v8.Color
                        v11.Material = v8.Material
                        v11.Parent = ROCKS_Folder
                        local v16 = TweenService
                        local tweenInfo = TweenInfo.new(
                            arg4,
                            Enum.EasingStyle.Linear,
                            Enum.EasingDirection.Out
                        )
                        local t_1 = {}
                        local Orientation = v11.Orientation
                        local v17 = math.random(-360, 360)
                        t_1.Orientation = Orientation + Vector3.new(
                            v17,
                            math.random(-360, 360),
                            math.random(-360, 360)
                        )
                        t_1.Position = v11.Position + Vector3.new(0, math.random(1, 15), 0)
                        local v20 = v16:Create(v11, tweenInfo, t_1)
                        v20:Play()
                        v20:Destroy()
                    end
                end
            end
        end

        task.wait(arg3)

        for _, child in pairs(ROCKS_Folder:GetChildren()) do
            child.CanCollide = true
            child.Anchored = false
        end

        Debris:AddItem(ROCKS_Folder, 3)
    end
}
