-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Headless.Headless_Fx
-- Class: ModuleScript
-- bytes: 4656

local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local HeadlessFxUtil_m = require(script.Parent.HeadlessFxUtil)
local Assets = script.Parent.Headless_ShadowDash_Fx.Assets
local Assets_1 = script.Assets
local Assets_2 = script.Parent.Headless_PumpkinSummon_Fx.Assets
local Assets_3 = script.Parent.Headless_PumpkinExplosion_Fx.Assets
local t = setmetatable({}, { __mode = "k" })

local function rise(u1: userdata, u2: CFrame) -- line: 26
    -- upvalues:
    --  [1] Assets_2 (copy)
    --  [2] HeadlessFxUtil_m (copy)
    --  [3] Assets (copy)
    --  [4] Assets_3 (copy)
    --  [5] TweenService (copy)
    --  [6] Debris (copy)

    local PumpkinSpawn = Assets_2["Pumpkin Spawn"]
    local v1 = PumpkinSpawn:GetAttribute("Offset") or CFrame.identity
    HeadlessFxUtil_m.PlaceScaled(PumpkinSpawn, u2 + Vector3.new(0, v1.Y * 3.2, 0), 3.2)
    HeadlessFxUtil_m.Place(Assets.AuraSTartUp, u2)
    HeadlessFxUtil_m.Place(Assets.Vanish, u2)
    HeadlessFxUtil_m.Shake(
        u2.Position,
        5,
        10,
        1.2,
        250
    )
    task.delay(0.15, function() -- line: 34
        -- upvalues:
        --  [1] HeadlessFxUtil_m (ref)
        --  [2] Assets_3 (ref)
        --  [3] u2 (copy)

        HeadlessFxUtil_m.PlaceScaled(Assets_3.Explosion, u2, 2.2)
        HeadlessFxUtil_m.PlaceScaled(Assets_3.Smoke, u2, 3)
    end)
    local v2 = Assets.ShadowHighlight:Clone()
    v2.Adornee = u1
    v2.FillColor = Color3.new(0, 0, 0)
    v2.OutlineColor = Color3.fromRGB(255, 110, 30)
    v2.FillTransparency = 0
    v2.OutlineTransparency = 0
    v2.DepthMode = Enum.HighlightDepthMode.Occluded
    v2.Parent = u1
    task.delay(0.5, function() -- line: 48
        -- upvalues:
        --  [1] v2 (copy)
        --  [2] TweenService (ref)

        if v2.Parent then
            TweenService:Create(
                v2,
                TweenInfo.new(1.2, Enum.EasingStyle.Quad),
                { FillTransparency = 1, OutlineTransparency = 1 }
            ):Play()
        end
    end)
    Debris:AddItem(v2, 1.8)
end

local cframe = CFrame.new(0, 1, -5)

return function(u3: userdata, s1: string, ...) -- line: 62
    -- upvalues:
    --  [1] HeadlessFxUtil_m (copy)
    --  [2] t (copy)
    --  [3] Assets_1 (copy)
    --  [4] cframe (copy)
    --  [5] rise (copy)
    --  [6] Assets (copy)

    local v5 = HeadlessFxUtil_m.Feet(u3)

    if not v5 then
        return
    end

    if s1 == "Step" then
        HeadlessFxUtil_m.Shake(
            v5.Position,
            1.2,
            6,
            0.25,
            60
        )
        local HumanoidRootPart = u3:FindFirstChild("HumanoidRootPart")

        if HumanoidRootPart then
            HeadlessFxUtil_m.Sound("Footstep", HumanoidRootPart)
            local v6 = t[u3]

            if v6 then
                if v6.Parent then
                    if not v6.IsPlaying then
                        t[u3] = HeadlessFxUtil_m.Sound("WalkFoley", HumanoidRootPart)

                        return
                    end
                else
                    t[u3] = HeadlessFxUtil_m.Sound("WalkFoley", HumanoidRootPart)

                    return
                end
            else
                t[u3] = HeadlessFxUtil_m.Sound("WalkFoley", HumanoidRootPart)

                return
            end
        end
    elseif s1 == "Unparryable" then
        local Head = u3:FindFirstChild("Head")

        if not Head then
            return
        end

        local v10 = Assets_1.UnparryableWarning:Clone()
        v10.CFrame = cframe
        HeadlessFxUtil_m.ScaleParticles(v10, 3)
        v10.Parent = Head
        HeadlessFxUtil_m.Emit(v10)

        return
    else
        if s1 == "Spawn" then
            rise(u3, v5)

            return
        end

        if s1 == "Despawn" then
            HeadlessFxUtil_m.Place(Assets.Vanish, v5)
            HeadlessFxUtil_m.Shake(
                v5.Position,
                3,
                8,
                0.6,
                150
            )

            return
        end

        if s1 == "Phase" then
            HeadlessFxUtil_m.Place(Assets.Vanish, v5)
            HeadlessFxUtil_m.Place(Assets.AuraSTartUp, v5)
            HeadlessFxUtil_m.Shake(
                v5.Position,
                4,
                10,
                0.8,
                200
            )

            return
        end

        if s1 == "Death" then
            HeadlessFxUtil_m.Place(Assets.Vanish, v5)
            HeadlessFxUtil_m.Shake(
                v5.Position,
                5,
                10,
                1,
                200
            )
        end
    end
end
