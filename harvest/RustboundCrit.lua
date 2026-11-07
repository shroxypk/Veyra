-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Crits.RustboundCrit
-- Class: ModuleScript
-- bytes: 1510

local HeadlessFxUtil_m = require(
    script:FindFirstAncestor("Attack Modules")._NPCS.Headless.HeadlessFxUtil
)
local cframe = CFrame.Angles(0, 0, 1.3028882866137672)
local cframe_1 = CFrame.new(
    -0.772,
    -3.002,
    -8.762,
    -1,
    0,
    0,
    0,
    0,
    -1,
    0,
    -1,
    0
)

return function(s1: string, u1: userdata, _: string, ...) -- line: 14
    -- upvalues:
    --  [1] HeadlessFxUtil_m (copy)
    --  [2] cframe (copy)
    --  [3] cframe_1 (copy)

    local v2 = u1

    if v2 then
        v2 = u1.PrimaryPart
    end

    local vec3

    if v2 then
        if s1 == "Slam" then
            if not HeadlessFxUtil_m.Near(v2.Position) then
                return
            end

            local v3 = ... or v2.CFrame
            v2 = v3.LookVector
            vec3 = Vector3.new(v2.X, 0, v2.Z)
            local v5 = CFrame.lookAt(
                v3.Position,
                v3.Position + (if vec3.Magnitude > 0.01 then vec3 else Vector3.new(-0, -0, -1))
            )
            HeadlessFxUtil_m.PlaceAt(script.HeavySlash, v5 * cframe)
            local v6 = v5 * cframe_1
            local v7 = v6.Rotation + Vector3.new(
                v6.X,
                HeadlessFxUtil_m.GroundY(v6.Position, v6.Y) + 0.05,
                v6.Z
            )
            HeadlessFxUtil_m.PlaceAt(script.HeavySlashImpact, v7)
            HeadlessFxUtil_m.Shake(v7.Position, 4, 10, 0.4)

            return
        else
            return
        end
    else
        return
    end
end
