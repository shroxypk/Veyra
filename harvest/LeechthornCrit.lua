-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Crits.LeechthornCrit
-- Class: ModuleScript
-- bytes: 1376

local HeadlessFxUtil_m = require(
    script:FindFirstAncestor("Attack Modules")._NPCS.Headless.HeadlessFxUtil
)
local t = {}
local v2 = CFrame.new(-1.155, -1.727, -9.35) * CFrame.Angles(0, 1.5707963267948966, 0)

return function(s1: string, u1: userdata, s2: string, ...) -- line: 17
    -- upvalues:
    --  [1] t (copy)
    --  [2] HeadlessFxUtil_m (copy)
    --  [3] v2 (copy)

    local v3 = u1

    if v3 then
        v3 = u1.PrimaryPart
    end

    if not v3 then
        return
    end

    if s1 == "Cleanup" then
        t[s2] = nil

        return
    end

    if not HeadlessFxUtil_m.Near(v3.Position) then
        return
    end

    local v5

    if s1 == "Launch" then
        local v4 = ... or v3.CFrame
        t[s2] = v4
        v5 = v4 * CFrame.new(0, 0, -20)
        HeadlessFxUtil_m.PlaceAt(script.Dash, v5 * CFrame.Angles(0, 3.141592653589793, 0))

        return
    end

    if s1 == "Hit" then
        v5 = t[s2] or v3.CFrame
        local v6 = v5 * CFrame.new(0, 0, -20) * v2
        local v8 = v3.CFrame * CFrame.new(0, 0, -3)

        if (v6.Position - v8.Position).Magnitude > 6 then
            v6 = CFrame.new(v8.Position + Vector3.new(0, v2.Y, 0)) * v5.Rotation * v2.Rotation
        end

        HeadlessFxUtil_m.PlaceAt(script.Hit, v6)

        if ... then
            HeadlessFxUtil_m.Shake(v6.Position, 2, 8, 0.25)
        end
    end
end
