-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ControlWeather
-- Class: ModuleScript
-- bytes: 9054

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local RunService = Services_m.RunService
local LocalPlayer = Services_m.Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local rng = Random.new()
local v2 = Services_m.Maid.new()
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.FilterDescendantsInstances = { workspace.Map }
raycastParams.IgnoreWater = true
local v3 = ReplicatedStorage.Effects.WeatherParts.Rain:Clone()
v3.Name = "WeatherRadius"
v3.Parent = workspace.Terrain
local children = v3:GetChildren()
local t = {
    SmallRain = Color3.fromRGB(190, 40, 45),
    LongRain = Color3.fromRGB(215, 45, 50),
    Smoke = Color3.fromRGB(140, 30, 35),
    Beam = Color3.fromRGB(195, 30, 35),
    OuterRing = Color3.fromRGB(220, 40, 40),
    Ring = Color3.fromRGB(220, 40, 40),
    Splash1 = Color3.fromRGB(175, 20, 25)
}

local _ = function() --[[ isBloodMoon ]] -- line: 38
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    return if ReplicatedStorage:GetAttribute("BloodMoon") ~= true then false else true
end

local _ = function(arg1) --[[ tintBloodRain ]] -- line: 43
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] t (copy)

    if (if ReplicatedStorage:GetAttribute("BloodMoon") ~= true then false else true) and t[arg1.Name] then
        arg1.Color = ColorSequence.new(t[arg1.Name])
    end
end

local t_1 = {}

for _, val in children do
    if t[val.Name] then
        t_1[val] = val.Color
    end
end

local function updateRainColors() -- line: 56
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] ReplicatedStorage (copy)
    --  [3] t (copy)

    for key_1, val_1 in t_1 do
        local v6 = if ReplicatedStorage:GetAttribute("BloodMoon") ~= true then false else true
        key_1.Color = v6 and ColorSequence.new(t[key_1.Name]) or val_1
    end
end

updateRainColors()
ReplicatedStorage:GetAttributeChangedSignal("BloodMoon"):Connect(updateRainColors)
local t_2 = {}
t_2.__index = t_2

function t_2.ToggleRain(_, arg3) -- line: 67
    -- upvalues:
    --  [1] v2 (copy)
    --  [2] children (copy)
    --  [3] RunService (copy)
    --  [4] ReplicatedStorage (copy)
    --  [5] Services_m (copy)
    --  [6] CurrentCamera (copy)
    --  [7] rng (copy)
    --  [8] raycastParams (copy)
    --  [9] t (copy)
    --  [10] v3 (copy)
    --  [11] LocalPlayer (copy)

    if arg3 then
        v2:Destroy()

        for _, val_2 in children do
            val_2.Enabled = true
        end

        local v10 = 0
        v2:GiveTask(RunService.Stepped:Connect(function() -- line: 78
            -- upvalues:
            --  [1] v10 (ref)
            --  [2] ReplicatedStorage (ref)
            --  [3] Services_m (ref)
            --  [4] v2 (ref)
            --  [5] CurrentCamera (ref)
            --  [6] rng (ref)
            --  [7] raycastParams (ref)
            --  [8] t (ref)
            --  [9] v3 (ref)
            --  [10] LocalPlayer (ref)
            --  [11] children (ref)

            local now = tick()

            if now - v10 >= 0.1 then
                v10 = now
                task.spawn(function() -- line: 83
                    -- upvalues:
                    --  [1] ReplicatedStorage (ref)
                    --  [2] Services_m (ref)
                    --  [3] v2 (ref)
                    --  [4] CurrentCamera (ref)
                    --  [5] rng (ref)
                    --  [6] raycastParams (ref)
                    --  [7] t (ref)

                    local v11 = ReplicatedStorage.Effects.WeatherParts.Sky:Clone()
                    local v12 = ReplicatedStorage.Effects.WeatherParts.Floor:Clone()
                    Services_m.Debris(v11, 1)
                    Services_m.Debris(v12, 1)
                    v2:GiveTask(v11)
                    v2:GiveTask(v12)
                    local v13 = CurrentCamera.CFrame
                    local New = CFrame.new
                    local v14 = rng:NextInteger(-70, 70)
                    v11.CFrame = v13 * New(v14, 200, rng:NextInteger(-70, 70))
                    v12.Position = v11.Position
                    local v15 = if rng:NextInteger(1, 2) == 1 then -82 else -90
                    local cframe = CFrame.Angles(math.rad(v15), 0, 0)
                    v15 = workspace:Raycast(
                        v11.Position,
                        (v12.CFrame * cframe).lookVector * 500,
                        raycastParams
                    )
                    local Beam, OuterRing, Ring, Splash1

                    if v15 then
                        if not v15.Instance.CanCollide then
                            v11:Destroy()
                            v12:Destroy()

                            return
                        end

                        v11.Parent = workspace.Effects
                        v12.Parent = workspace.Effects
                        v11.Beam.Attachment0 = v11.Sky
                        v11.Beam.Attachment1 = v12.Ground
                        Beam = v11.Beam

                        if (if ReplicatedStorage:GetAttribute("BloodMoon") ~= true then false else true) and t[Beam.Name] then
                            Beam.Color = ColorSequence.new(t[Beam.Name])
                        end

                        OuterRing = v12.Ground.OuterRing

                        if (if ReplicatedStorage:GetAttribute("BloodMoon") ~= true then false else true) and t[OuterRing.Name] then
                            OuterRing.Color = ColorSequence.new(t[OuterRing.Name])
                        end

                        Ring = v12.Ground.Ring

                        if (if ReplicatedStorage:GetAttribute("BloodMoon") ~= true then false else true) and t[Ring.Name] then
                            Ring.Color = ColorSequence.new(t[Ring.Name])
                        end

                        Splash1 = v12.Splash1

                        if (if ReplicatedStorage:GetAttribute("BloodMoon") ~= true then false else true) and t[Splash1.Name] then
                            Splash1.Color = ColorSequence.new(t[Splash1.Name])
                        end

                        pcall(function() -- line: 120
                            -- upvalues:
                            --  [1] v11 (copy)
                            --  [2] v12 (copy)
                            --  [3] rng (ref)
                            --  [4] v15 (copy)

                            local t_3 = { Transparency = NumberSequence.new(1) }
                            _G.Tween(v11.Beam, { 0.5, "Linear", Enum.EasingDirection.Out }, t_3)
                            _G.Tween(
                                v12,
                                { rng:NextNumber(0.2, 0.225), "Linear", Enum.EasingDirection.Out },
                                { Position = v15.Position },
                                false,
                                true
                            )
                            v12.Ground.OuterRing:Emit(1)
                            v12.Ground.Ring:Emit(1)
                            v12.Splash1:Emit(5)
                            v12.Splash2.Color = ColorSequence.new(v15.Instance.Color)
                            v12.Splash2:Emit(2)
                        end)

                        return
                    end

                    v11:Destroy()
                    v12:Destroy()

                    return
                end)
            end

            v3.Position = CurrentCamera.CFrame.Position + Vector3.new(0, 75, 0)
            local v27 = workspace:Raycast(
                LocalPlayer.Character and (LocalPlayer.Character.PrimaryPart and LocalPlayer.Character.PrimaryPart.Position) or CurrentCamera.CFrame.Position,
                Vector3.new(0, 400, 0),
                raycastParams
            )

            if v27 and v27.Instance then
                local v28 = v27.Instance

                if v28:FindFirstAncestorWhichIsA("Model") then
                    if v28:FindFirstAncestorWhichIsA("Model") ~= workspace then
                        local _, v31 = v28:FindFirstAncestorWhichIsA("Model"):GetBoundingBox()
                        local v32 = math.max(v31.X, v31.Y, v31.Z) * -1

                        for _, val_3 in children do
                            val_3.ZOffset = v32
                        end

                        return
                    end
                end

                local v34 = (v28.Size.Z > v28.Size.X and v28.Size.Z or v28.Size.X) * -1

                for _, val_4 in children do
                    val_4.ZOffset = v34
                end

                return
            end

            for _, val_5 in children do
                val_5.ZOffset = 0
            end
        end))
        script.RainLoop_1:Play()
        script.Wind:Play()

        return
    end

    v2:Destroy()

    for _, val_6 in children do
        val_6.Enabled = false
    end

    script.RainLoop_1:Stop()
    script.Wind:Stop()
end

return t_2
