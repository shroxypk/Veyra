-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.ClientInteractions.World.BellClient
-- Class: ModuleScript
-- bytes: 4711

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.RunService
local _ = Services_m.CollectionService
local BellRemote = Services_m.ReplicatedStorage.Remotes:WaitForChild("BellRemote")
local ChurchBells = workspace.Objects.QuestObjects:WaitForChild("ChurchBells")
local v2 = script
local Ghost = ChurchBells.ghost
v2:SetAttribute("Count", 0)

function Main() -- line: 20
    -- upvalues:
    --  [1] ChurchBells (copy)
    --  [2] v2 (copy)

    for _, child in ChurchBells:GetChildren() do
        if child:IsA("Model") and child.Name == "ChurchBell" then
            local v3 = script.Prompt:Clone()
            v3.Triggered:Connect(function(_) -- line: 24
                -- upvalues:
                --  [1] v3 (copy)
                --  [2] v2 (ref)

                v3:Destroy()
                v2:SetAttribute("Count", v2:GetAttribute("Count") + 1)
                _G.PlaySound(script.Ring, script)
            end)
            v3.Parent = child.PrimaryPart
        end
    end
end

BellRemote.OnClientEvent:Connect(function(arg2, arg3) -- line: 35
    -- upvalues:
    --  [1] ChurchBells (copy)
    --  [2] Services_m (copy)

    if arg2 == "Completed" then
        ChurchBells.Completed.Value = true

        if arg3 and _G.CanRender(script.effect.CFrame) then
            local v6 = script.effect:Clone()
            v6.Parent = workspace.Effects
            _G.ToggleParticles(v6, true)

            for _, descendant in v6:GetDescendants() do
                if descendant:IsA("Light") then
                    _G.Tween(
                        descendant,
                        { 1.5, "Quad", Enum.EasingDirection.Out },
                        { Brightness = 1.5, Range = 15 }
                    )
                end
            end

            local TweenService = game:GetService("TweenService")
            local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Linear)
            local v8 = TweenService:Create(
                v6,
                tweenInfo,
                { CFrame = v6.CFrame * CFrame.Angles(0, 2.0943951023931953, 0) }
            )
            local v10 = TweenService:Create(
                v6,
                tweenInfo,
                { CFrame = v6.CFrame * CFrame.Angles(0, 4.1887902047863905, 0) }
            )
            local v12 = TweenService:Create(
                v6,
                tweenInfo,
                { CFrame = v6.CFrame * CFrame.Angles(0, 6.283185307179586, 0) }
            )
            v8.Completed:Connect(function() -- line: 58
                -- upvalues:
                --  [1] v10 (copy)

                v10:Play()
            end)
            v10.Completed:Connect(function() -- line: 59
                -- upvalues:
                --  [1] v12 (copy)

                v12:Play()
            end)
            v12.Completed:Connect(function() -- line: 60
                -- upvalues:
                --  [1] v8 (copy)

                v8:Play()
            end)
            v8:Play()
            task.wait(6)

            for _, descendant_1 in v6:GetDescendants() do
                if descendant_1:IsA("Light") then
                    _G.Tween(
                        descendant_1,
                        { 1.5, "Quad", Enum.EasingDirection.Out },
                        { Brightness = 0, Range = 0 }
                    )
                end
            end

            _G.ToggleParticles(v6)
            Services_m.Debris(v6, 8)
        end
    end
end)
BellRemote:FireServer("CheckCompleted")

local function Completed() -- line: 79
    -- upvalues:
    --  [1] ChurchBells (copy)
    --  [2] Ghost (copy)

    if ChurchBells.Completed.Value then
        for _, descendant_2 in Ghost:GetDescendants() do
            if descendant_2:IsA("BasePart") then
                _G.Tween(
                    descendant_2,
                    { 0.5, "Quad", Enum.EasingDirection.Out },
                    { Transparency = 1 }
                )
            end
        end

        task.delay(0.5, function() -- line: 87
            -- upvalues:
            --  [1] Ghost (ref)

            Ghost.Parent = nil
        end)

        for _, descendant_3 in ChurchBells:GetDescendants() do
            if descendant_3:IsA("ProximityPrompt") then
                descendant_3:Destroy()
            end
        end
    end
end

ChurchBells.Completed:GetPropertyChangedSignal("Value"):Connect(Completed)
task.spawn(Completed)

local function syncAttribute() -- line: 102
    -- upvalues:
    --  [1] BellRemote (copy)

    if script:GetAttribute("Count") >= 4 then
        BellRemote:FireServer("Complete")
    end
end

v2:GetAttributeChangedSignal("Count"):Connect(syncAttribute)

return Main
