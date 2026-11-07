-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.MutualGlobals
-- Class: ModuleScript
-- bytes: 4528

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
ReplicatedStorage:WaitForChild("Modules")
ReplicatedStorage.Modules:WaitForChild("FastSpawn")
local _ = Services_m.Debris

function _G.FadeSound(arg1) -- line: 12
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v2 = game:GetService("TweenService"):Create(arg1, tweenInfo, { Volume = 0 })
    v2:Play()
    v2.Completed:Connect(function() -- line: 17
        -- upvalues:
        --  [1] arg1 (copy)

        arg1:Destroy()
    end)
end

function _G.ToggleParticles(arg2, arg3) -- line: 21
    for _, descendant in pairs(arg2:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = arg3
        end
    end
end

_G.FastSpawn = require(ReplicatedStorage.Modules.FastSpawn)

function _G.CreateMagicCircle(
    arg4,
    arg5,
    arg6,
    arg7,
    arg8,
    arg9,
    arg10
) -- line: 31
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] RunService (copy)

    local v5 = arg4 or Color3.fromRGB(255, 255, 255)
    arg4 = v5
    v5 = ReplicatedStorage.Effects.MagicCircle:Clone()
    v5.Color = arg4
    v5.Size = arg5 / 4
    v5.Anchored = not (arg7 and arg8)

    for _, descendant_1 in pairs(v5:GetDescendants()) do
        if descendant_1:IsA("ImageLabel") then
            descendant_1.ImageTransparency = arg10 or 0
            descendant_1.ImageColor3 = arg4
        end
    end

    local Weld = nil

    if arg7 and arg8 then
        Weld = Instance.new("Weld")
        Weld.Part0 = v5
        Weld.Part1 = arg8
        local v8 = arg9 or CFrame.new(0, 0, 0)
        Weld.C0 = v8
        Weld.Parent = Weld.Part0
    else
        local v9 = nil
        local t_2

        if RunService:IsServer() then
            local t = { Size = arg5, Orientation = Vector3.new(0, 5 * arg6, 0) }
            v9 = _G.ServerTween(v5, { arg6 or 2, "Quad", Enum.EasingDirection.Out }, t)
        else
            t_2 = {
                arg6 or 2,
                "Quad",
                Enum.EasingDirection.Out,
                Orientation = Vector3.new(0, 10 * arg6, 0)
            }
            v9 = _G.Tween(v5, t_2, { Size = arg5 })
        end

        local function Destroy() -- line: 63
            -- upvalues:
            --  [1] v9 (ref)
            --  [2] v5 (copy)
            --  [3] RunService (ref)

            v9:Stop()
            local X = v5.Size.X
            local Position = v5.Position
            task.spawn(function() -- line: 67
                -- upvalues:
                --  [1] RunService (ref)
                --  [2] v5 (ref)

                if RunService:IsServer() then
                    for _, val in pairs(v5:GetDescendants()) do
                        if val:IsA("ImageLabel") then
                            _G.ServerTween(
                                val,
                                { 0.5, "Quad", Enum.EasingDirection.Out },
                                { ImageTransparency = 1 },
                                false,
                                true
                            )
                        end
                    end
                else
                    for _, val_1 in pairs(v5:GetDescendants()) do
                        if val_1:IsA("ImageLabel") then
                            _G.Tween(
                                val_1,
                                { 0.5, "Quad", Enum.EasingDirection.Out },
                                { ImageTransparency = 1 },
                                false,
                                true
                            )
                        end
                    end
                end

                v5:Destroy()
            end)

            return X, Position
        end

        local function Stop() -- line: 86
            -- upvalues:
            --  [1] v9 (ref)

            v9:Stop()
        end

        v9.Stopped:Connect(function() -- line: 90
            -- upvalues:
            --  [1] Weld (ref)
            --  [2] v5 (copy)

            if Weld then
                Weld:Destroy()
                v5.Anchored = true
            end
        end)
        local t_3
        local v12, v13
        v5.Rotate.Disabled, t_2, t_3, v12, v13 = false, v5, Destroy, Stop, v9

        return t_2, t_3, v12, v13
    end
end

return {}
