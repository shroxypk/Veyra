-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Crits.NightriderLanceCrit
-- Class: ModuleScript
-- bytes: 3294

local RunService = game:GetService("RunService")
local HeadlessFxUtil_m = require(
    script:FindFirstAncestor("Attack Modules")._NPCS.Headless.HeadlessFxUtil
)
script.DashEnable.PrimaryPart = script.DashEnable:FindFirstChild("Root")
script.ImpactKick.PrimaryPart = script.ImpactKick:FindFirstChild("KickAway")

local _ = function(arg1) --[[ stopDash ]] -- line: 20
    -- upvalues:
    --  [1] HeadlessFxUtil_m (copy)

    if not arg1 then
        return
    end

    if arg1.follow then
        arg1.follow:Disconnect()
        arg1.follow = nil
    end

    if arg1.dash then
        HeadlessFxUtil_m.Stop(arg1.dash)
        arg1.dash = nil
    end
end

local t = {}

return function(s1: string, u1: userdata, s2: string, ...) -- line: 34
    -- upvalues:
    --  [1] t (copy)
    --  [2] HeadlessFxUtil_m (copy)
    --  [3] RunService (copy)

    local v2 = u1

    if v2 then
        v2 = u1.PrimaryPart
    end

    if not v2 then
        return
    end

    local v3 = t[s2]

    if s1 == "Cleanup" then
        local v4 = v3

        if v4 then
            if v4.follow then
                v4.follow:Disconnect()
                v4.follow = nil
            end

            if v4.dash then
                HeadlessFxUtil_m.Stop(v4.dash)
                v4.dash = nil
            end
        end

        t[s2] = nil

        return
    end

    if not HeadlessFxUtil_m.Near(v2.Position) then
        return
    end

    local t_1

    if not v3 then
        t_1 = {}
        t[s2] = t_1
    end

    if s1 == "Launch" then
        local v5 = t_1

        if v5 then
            if v5.follow then
                v5.follow:Disconnect()
                v5.follow = nil
            end

            if v5.dash then
                HeadlessFxUtil_m.Stop(v5.dash)
                v5.dash = nil
            end
        end

        local v6 = HeadlessFxUtil_m.Spawn(script.DashEnable, v2.CFrame)
        t_1.dash = v6
        HeadlessFxUtil_m.Enable(v6)
        t_1.follow = RunService.RenderStepped:Connect(function() -- line: 63
            -- upvalues:
            --  [1] v6 (copy)
            --  [2] v2 (copy)
            --  [3] t_1 (ref)
            --  [4] HeadlessFxUtil_m (ref)

            if not v6.Parent or not v2.Parent then
                local v7 = t_1

                if not v7 then
                    return
                end

                if v7.follow then
                    v7.follow:Disconnect()
                    v7.follow = nil
                end

                if v7.dash then
                    HeadlessFxUtil_m.Stop(v7.dash)
                    v7.dash = nil
                end

                return
            end

            v6:PivotTo(v2.CFrame)
        end)
    elseif s1 == "Strike" then
        local v8 = t_1

        if v8 then
            if v8.follow then
                v8.follow:Disconnect()
                v8.follow = nil
            end

            if v8.dash then
                HeadlessFxUtil_m.Stop(v8.dash)
                v8.dash = nil
            end
        end

        if ... then
            HeadlessFxUtil_m.Shake(v2.Position, 2, 8, 0.25)
        end
    elseif s1 == "Kick" then
        HeadlessFxUtil_m.PlaceAt(script.ImpactKick, v2.CFrame)
        HeadlessFxUtil_m.Shake(v2.Position, 3, 10, 0.35)
    end
end
