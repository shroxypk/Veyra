-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Water.Surging Waves
-- Class: ModuleScript
-- bytes: 2870

local ReplicatedStorage = require(game:GetService("ReplicatedFirst").Services).ReplicatedStorage

local function SplashPuddle(arg1, arg2, arg3, arg4) -- line: 15
    for _ = 1, arg2 do
        local v1 = math.random(10, 25) / 10
        local v2 = script.ball:Clone()
        _G.Debris(v2, 30)
        v2.Anchored = false
        v2.Transparency = 0.7
        v2.Size = Vector3.new(v1, v1, v1)
        local v4 = CFrame.new(arg3) * CFrame.new(0, 2, 0) * CFrame.Angles(1.5707963267948966, 0, 0)
        local Angles = CFrame.Angles
        local v6 = math.rad((math.random(-45, 45)))
        v2.CFrame = v4 * Angles(v6, math.rad((math.random(-45, 45))), 0)
        v2.Velocity = v2.CFrame.LookVector * (arg4 or 40)
        v2.CanTouch = true
        v2.Touched:Connect(function(otherPart) -- line: 26
            -- upvalues:
            --  [1] arg1 (copy)
            --  [2] v2 (copy)
            --  [3] v1 (ref)

            if not otherPart:IsDescendantOf(arg1) and not otherPart:IsDescendantOf(
                workspace.Effects
            ) and not otherPart:IsDescendantOf(workspace.CurrentCamera) then
                v2.Anchored = true
                v2.CFrame = CFrame.new(v2.Position)
                v1 = math.random(5, 9)
                local t = { Size = Vector3.new(v1, 0.25, v1) }
                _G.Tween(v2, { 0.5, "Quad", Enum.EasingDirection.Out }, t, true)
                coroutine.wrap(function() -- line: 35
                    -- upvalues:
                    --  [1] v2 (ref)

                    task.wait(0.75)
                    local t_2 = { Color = Color3.fromRGB(93, 204, 255), Transparency = 1 }
                    _G.Tween(v2, { 10, "Quad", Enum.EasingDirection.Out }, t_2, true)
                end)()
            end
        end)
        v2.Parent = workspace.Effects
    end
end

function Attack(arg6, arg7, _, ...) -- line: 46
    -- upvalues:
    --  [1] SplashPuddle (copy)
    --  [2] ReplicatedStorage (copy)

    local t_4 = { ... }
    local _ = t_4[1]
    local _ = { workspace.Map }
    local v12 = t_4[2]

    if arg7 == "DiveEffect" then
        SplashPuddle(arg6, 3, arg6.HumanoidRootPart.Position)
        local v13 = ReplicatedStorage.Effects.CurvyRing:Clone()
        v13.Anchored = true
        v13.Color = Color3.fromRGB(120, 197, 255)
        v13.Material = Enum.Material.ForceField
        v13.Size = Vector3.new(10, 1.5, 10)
        v13.CFrame = v12 * CFrame.new(0, 5, 0)
        v13.Parent = workspace.Effects
        local t_6 = { CFrame = nil, Size = nil, Transparency = 1 }
        local Tween_2 = _G.Tween
        local t_7 = { 0.75, "EntranceExpressive", Enum.EasingDirection.Out }
        t_6.CFrame = v13.CFrame * CFrame.new(0, -5, 0)
        t_6.Size = v13.Size + Vector3.new(5, -1, 5)
        Tween_2(v13, t_7, t_6, true)

        return
    end

    if arg7 == "" then
    end
end

return Attack
