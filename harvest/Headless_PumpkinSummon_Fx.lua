-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Headless.Headless_PumpkinSummon_Fx
-- Class: ModuleScript
-- bytes: 14912

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HeadlessFxUtil_m = require(script.Parent.HeadlessFxUtil)
local Assets = script.Assets
local PumpkinModel = script.Parent.Headless_PumpkinExplosion_Fx.Assets.PumpkinModel
local cframe = CFrame.Angles(0, 0, 1.5707963267948966)
local t = setmetatable({}, { __mode = "k" })
local t_1 = {}
local t_2 = {}
local v1 = PumpkinModel:FindFirstChildWhichIsA("BasePart").Size.Y / 2
local v2 = nil

local _ = function(vec1: Vector3) --[[ flat ]] -- line: 34
    return (Vector3.new(vec1.X, 0, vec1.Z))
end

local function turnToward(vec2: Vector3, vec3: Vector3, n1: number) -- line: 38
    local v3 = vec2:Dot(vec3)
    local v4 = math.clamp(v3, -1, 1)
    local v5 = math.acos(v4)

    if n1 >= v5 or v5 < 0.001 then
        return vec3
    end

    local v6 = vec2:Cross(vec3)

    if v6.Magnitude < 0.001 then
        v6 = Vector3.new(0, 1, 0)
    end

    return (CFrame.fromAxisAngle(v6.Unit, n1) * vec2).Unit
end

local _ = function(n2: number) --[[ removePumpkin ]] -- line: 50
    -- upvalues:
    --  [1] t_2 (copy)

    local v7 = t_2[n2]
    t_2[n2] = nil

    if v7 and v7.Model then
        v7.Model:Destroy()
    end
end

local function step(n3: number) -- line: 58
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] v2 (ref)
    --  [3] turnToward (copy)
    --  [4] HeadlessFxUtil_m (copy)
    --  [5] v1 (copy)
    --  [6] cframe (copy)

    if not next(t_2) then
        v2:Disconnect()
        v2 = nil

        return
    end

    local v13

    for key, val in t_2 do
        val.Age += n3

        if val.Age > 15 then
            local v8 = t_2[key]
            t_2[key] = nil

            if v8 and v8.Model then
                v8.Model:Destroy()
            end
        else
            local Pounce = val.Pounce

            if Pounce then
                local v9 = math.clamp((os.clock() - Pounce.Start) / Pounce.Duration, 0, 1)
                local v11 = Pounce.From:Lerp(Pounce.To, v9) + Vector3.new(
                    0,
                    4 * Pounce.Height * v9 * (1 - v9),
                    0
                )
                local v12 = v11 - val.Position
                v13 = Vector3.new(v12.X, 0, v12.Z).Magnitude
                local v14 = Pounce.To - Pounce.From
                local vec3_1 = Vector3.new(v14.X, 0, v14.Z)

                if vec3_1.Magnitude > 0.1 then
                    val.Direction = vec3_1.Unit
                end

                val.Position = v11
            elseif val.Rolling then
                local v15 = val.Victim

                if v15 then
                    v15 = val.Victim:FindFirstChild("HumanoidRootPart")
                end

                if v15 then
                    local v16 = v15.Position - val.Position
                    local vec3_2 = Vector3.new(v16.X, 0, v16.Z)

                    if vec3_2.Magnitude > 0.1 then
                        val.Direction = turnToward(val.Direction, vec3_2.Unit, val.TurnRate * n3)
                    end
                end

                v15 = val.Position + val.Direction * val.Speed * n3
                v13 = val.Speed * n3
                val.Position = Vector3.new(
                    v15.X,
                    HeadlessFxUtil_m.GroundY(v15, v15.Y - v1) + v1,
                    v15.Z
                )
            end

            val.Spin = val.Spin * CFrame.Angles(-v13 / v1, 0, 0)
            val.Model:PivotTo(
                CFrame.lookAt(val.Position, val.Position + val.Direction) * val.Spin * cframe
            )
        end
    end
end

local _ = function() --[[ startStepping ]] -- line: 105
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] RunService (copy)
    --  [3] step (copy)

    if not v2 then
        v2 = RunService.RenderStepped:Connect(step)
    end
end

local _ = function(vec4: Vector3, n4: number) --[[ explode ]] -- line: 112
    -- upvalues:
    --  [1] HeadlessFxUtil_m (copy)
    --  [2] Assets (copy)

    HeadlessFxUtil_m.PlaceScaled(Assets.Explosion, CFrame.new(vec4), n4)
    HeadlessFxUtil_m.PlaceScaled(Assets.Smoke, CFrame.new(vec4), n4 * 0.6)
end

local function addMist(n5: number, vec5: Vector3, n6: number) -- line: 118
    -- upvalues:
    --  [1] Assets (copy)
    --  [2] HeadlessFxUtil_m (copy)
    --  [3] t_1 (copy)

    local PumpkinLinger = Assets.PumpkinLinger
    local v18 = PumpkinLinger:GetAttribute("Offset") or CFrame.identity
    local v19 = n6 * 2
    local Y = v18.Y
    local v20 = v19 / math.max(PumpkinLinger.Size.X, PumpkinLinger.Size.Z)
    local v21 = v20 ^ 0.5
    local v22 = HeadlessFxUtil_m.Spawn(PumpkinLinger, CFrame.new(vec5 + Vector3.new(0, Y, 0)))
    v22.Size = Vector3.new(
        PumpkinLinger.Size.X * v20,
        PumpkinLinger.Size.Y,
        PumpkinLinger.Size.Z * v20
    )
    HeadlessFxUtil_m.ScaleParticles(v22, v21)

    for _, descendant in v22:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Rate *= v21
        end
    end

    HeadlessFxUtil_m.Enable(v22)
    t_1[n5] = v22
end

local _ = function(n7: number) --[[ removeMist ]] -- line: 136
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] HeadlessFxUtil_m (copy)

    local v23 = t_1[n7]
    t_1[n7] = nil
    HeadlessFxUtil_m.Stop(v23)
end

local t_3 = {}

return function(u1: userdata, s1: string, ...) -- line: 142
    -- upvalues:
    --  [1] t (copy)
    --  [2] HeadlessFxUtil_m (copy)
    --  [3] Assets (copy)
    --  [4] PumpkinModel (copy)
    --  [5] v1 (copy)
    --  [6] cframe (copy)
    --  [7] t_3 (copy)
    --  [8] TweenService (copy)
    --  [9] t_2 (copy)
    --  [10] v2 (ref)
    --  [11] RunService (copy)
    --  [12] step (copy)
    --  [13] t_1 (copy)
    --  [14] addMist (copy)

    local HumanoidRootPart

    if s1 == "Begin" then
        if not t[u1] then
            if not HeadlessFxUtil_m.Feet(u1) then
                return
            end

            t[u1] = HeadlessFxUtil_m.Highlight(u1, Assets.SummonHighlight, 0.6, 0.4)
            HumanoidRootPart = u1:FindFirstChild("HumanoidRootPart")

            if HumanoidRootPart then
                HeadlessFxUtil_m.Sound("PumpkinSummonCast", HumanoidRootPart)

                return
            end
        else
            return
        end
    else
        if s1 == "End" then
            HeadlessFxUtil_m.RemoveHighlight(t[u1])
            t[u1] = nil

            return
        end

        local v27, v33

        if s1 == "Rise" then
            local v26, v28
            HumanoidRootPart, v26, v27, v28 = ...

            if not HeadlessFxUtil_m.Near(v26) then
                return
            end

            local PumpkinSpawn = Assets["Pumpkin Spawn"]
            local v29 = PumpkinSpawn:GetAttribute("Offset") or CFrame.identity
            local v30 = v26 + Vector3.new(0, v29.Y, 0)
            HeadlessFxUtil_m.PlaceAt(PumpkinSpawn, CFrame.lookAt(v30, v30 + v27))
            local v31 = PumpkinModel:Clone()
            local BasePart = v31:FindFirstChildWhichIsA("BasePart")
            v31.PrimaryPart = BasePart
            BasePart.PivotOffset = CFrame.identity
            BasePart.Anchored = true
            BasePart.CanCollide = false
            BasePart.CanQuery = false
            BasePart.CanTouch = false
            local v32 = v26 + Vector3.new(0, v1, 0)
            v33 = CFrame.lookAt(v32, v32 + v27) * cframe
            v31:PivotTo(v33 - Vector3.new(0, v1 * 2.5, 0))
            v31.Parent = workspace.Effects
            local clock_1 = os.clock()

            for index = #t_3, 1, -1 do
                if clock_1 - t_3[index] > 0.6 then
                    table.remove(t_3, index)
                end
            end

            if #t_3 < 4 then
                table.insert(t_3, clock_1)
                HeadlessFxUtil_m.Sound("PumpkinRise", BasePart)
            end

            local CFrameValue = Instance.new("CFrameValue")
            CFrameValue.Value = v31:GetPivot()
            CFrameValue.Changed:Connect(function(arg1) -- line: 194
                -- upvalues:
                --  [1] v31 (copy)

                if v31.Parent then
                    v31:PivotTo(arg1)
                end
            end)
            TweenService:Create(
                CFrameValue,
                TweenInfo.new(v28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                { Value = v33 }
            ):Play()
            task.delay(v28 + 0.1, CFrameValue.Destroy, CFrameValue)
            t_2[HumanoidRootPart] = {
                Model = v31,
                Position = v32,
                Direction = v27,
                Spin = CFrame.identity,
                Victim = nil,
                Rolling = false,
                Speed = 0,
                TurnRate = 0,
                Pounce = nil,
                Age = 0
            }

            if not v2 then
                v2 = RunService.RenderStepped:Connect(step)

                return
            end
        else
            if s1 == "Roll" then
                HumanoidRootPart, v33, v27 = ...

                for _, val_1 in HumanoidRootPart do
                    local v35 = t_2[val_1.Id]

                    if v35 then
                        v35.Rolling = true
                        local LoopSound = HeadlessFxUtil_m.LoopSound
                        local v36 = v35.Model:FindFirstChildWhichIsA("BasePart") or v35.Model
                        v35.RollSound = LoopSound("PumpkinRoll", v36)
                        v35.Victim = val_1.Victim
                        v35.Speed = v33
                        v35.TurnRate = v27
                    end
                end

                return
            end

            local v37

            if s1 == "Retarget" then
                HumanoidRootPart, v33 = ...
                v37 = t_2[HumanoidRootPart]

                if v37 then
                    v37.Victim = v33

                    return
                end
            else
                local BasePart_1

                if s1 == "Pounce" then
                    local v38
                    HumanoidRootPart, v33, v37, v38 = ...
                    local v39 = t_2[HumanoidRootPart]

                    if v39 then
                        local t_6 = {
                            From = nil,
                            To = nil,
                            Start = nil,
                            Duration = nil,
                            Height = nil
                        }
                        t_6.From, t_6.To = v39.Position, v33
                        t_6.Start = os.clock()
                        t_6.Duration = v37
                        t_6.Height = v38
                        v39.Pounce = t_6
                        HeadlessFxUtil_m.StopSound(v39.RollSound, 0.1)
                        BasePart_1 = v39.Model:FindFirstChildWhichIsA("BasePart")

                        if BasePart_1 then
                            HeadlessFxUtil_m.Sound("PumpkinHop", BasePart_1)

                            return
                        end
                    end
                else
                    local v41

                    if s1 == "Explode" then
                        BasePart_1, v33 = ...
                        v41 = t_2[BasePart_1]
                        t_2[BasePart_1] = nil

                        if v41 and v41.Model then
                            v41.Model:Destroy()
                        end

                        if HeadlessFxUtil_m.Near(v33) then
                            HeadlessFxUtil_m.PlaceScaled(Assets.Explosion, CFrame.new(v33), 1)
                            HeadlessFxUtil_m.PlaceScaled(Assets.Smoke, CFrame.new(v33), 0.6)
                            HeadlessFxUtil_m.Shake(
                                v33,
                                2,
                                10,
                                0.3,
                                70
                            )
                            HeadlessFxUtil_m.Sound("PumpkinExplode", v33)

                            return
                        end
                    else
                        local v43, v44

                        if s1 == "Remove" then
                            v43 = ...
                            v44 = t_2[v43]
                            t_2[v43] = nil

                            if v44 and v44.Model then
                                v44.Model:Destroy()

                                return
                            end
                        elseif s1 == "MistSpawn" then
                            v43, v44, v41 = ...
                            local v45 = t_1[v43]
                            t_1[v43] = nil
                            HeadlessFxUtil_m.Stop(v45)

                            if HeadlessFxUtil_m.Near(v44) then
                                addMist(v43, v44, v41)
                                HeadlessFxUtil_m.Sound("PoisonGround", v44)

                                return
                            end
                        else
                            local v47

                            if s1 == "MistRemove" then
                                v47 = ...
                                local v48 = t_1[v47]
                                t_1[v47] = nil
                                HeadlessFxUtil_m.Stop(v48)

                                return
                            end

                            if s1 == "MistDetonate" then
                                v47, v44 = ...
                                local v49 = t_1[v47]
                                t_1[v47] = nil
                                HeadlessFxUtil_m.Stop(v49)

                                if HeadlessFxUtil_m.Near(v44) then
                                    local v50 = v44 + Vector3.new(0, 2, 0)
                                    HeadlessFxUtil_m.PlaceScaled(
                                        Assets.Explosion,
                                        CFrame.new(v50),
                                        1.6
                                    )
                                    HeadlessFxUtil_m.PlaceScaled(
                                        Assets.Smoke,
                                        CFrame.new(v50),
                                        0.96
                                    )
                                    HeadlessFxUtil_m.Shake(
                                        v44,
                                        3,
                                        10,
                                        0.4,
                                        100
                                    )
                                    HeadlessFxUtil_m.Sound("PumpkinExplode", v44)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
