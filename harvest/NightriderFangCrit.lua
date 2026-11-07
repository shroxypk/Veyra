-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Crits.NightriderFangCrit
-- Class: ModuleScript
-- bytes: 1569

local HeadlessFxUtil_m = require(
    script:FindFirstAncestor("Attack Modules")._NPCS.Headless.HeadlessFxUtil
)
local cframe = CFrame.Angles(0, 1.5707963267948966, 0)

return function(s1: string, u1: userdata, _: string, ...) -- line: 12
    -- upvalues:
    --  [1] HeadlessFxUtil_m (copy)
    --  [2] cframe (copy)

    local v2 = u1

    if v2 then
        v2 = u1.PrimaryPart
    end

    if v2 then
        if s1 ~= "Cleanup" then
            if not HeadlessFxUtil_m.Near(v2.Position) then
                return
            end

            if s1 == "Appear" then
                local v3, v4 = ...
                local v5 = v3
                local PlaceAt = HeadlessFxUtil_m.PlaceAt
                local Vanish = script.Vanish

                if not v5 then
                    v5 = v2.CFrame
                end

                PlaceAt(Vanish, v5)
                v5 = v4 or v2.CFrame
                HeadlessFxUtil_m.PlaceAt(script.Vanish, v5)

                return
            end

            if s1 == "Slice" then
                local v6 = ...
                local v7 = v6 and v6.Position or (v2.CFrame * CFrame.new(0, 0, -2.5)).Position
                HeadlessFxUtil_m.PlaceAt(script.Hit, CFrame.new(v7) * v2.CFrame.Rotation * cframe)
                HeadlessFxUtil_m.Shake(v7, 2.5, 9, 0.3)

                return
            end

            if s1 == "Toss" then
                HeadlessFxUtil_m.Shake(v2.Position, 2, 8, 0.25)
            end

            return
        else
            return
        end
    else
        return
    end
end
