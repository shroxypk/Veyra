-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Crits.HollowHorsemanCrit
-- Class: ModuleScript
-- bytes: 2352

local Debris = game:GetService("Debris")
local HeadlessFxUtil_m = require(
    script:FindFirstAncestor("Attack Modules")._NPCS.Headless.HeadlessFxUtil
)
local Slash = script.Slash
local cframe = CFrame.new(Slash.CLEAVE.Position):ToObjectSpace(Slash:GetPivot())

local _ = function(u1: CFrame) --[[ flat ]] -- line: 25
    local LookVector = u1.LookVector
    local vec3 = Vector3.new(LookVector.X, 0, LookVector.Z)

    return CFrame.lookAt(
        u1.Position,
        u1.Position + (if vec3.Magnitude > 0.01 then vec3 else Vector3.new(-0, -0, -1))
    )
end

local t = {}

return function(s1: string, u2: userdata, s2: string, ...) -- line: 31
    -- upvalues:
    --  [1] t (copy)
    --  [2] Debris (copy)
    --  [3] HeadlessFxUtil_m (copy)
    --  [4] Slash (copy)
    --  [5] cframe (copy)

    local v3 = u2

    if v3 then
        v3 = u2.PrimaryPart
    end

    if not v3 then
        return
    end

    if s1 == "Cleanup" then
        local v4 = t[s2]
        t[s2] = nil

        if v4 then
            Debris:AddItem(v4, 4)
        end

        return
    end

    if not HeadlessFxUtil_m.Near(v3.Position) then
        return
    end

    if s1 == "Swing" then
        local v5 = ... or v3.CFrame
        local LookVector_1 = v5.LookVector
        local Spawn = HeadlessFxUtil_m.Spawn
        local v6 = Slash
        local vec3_1 = Vector3.new(LookVector_1.X, 0, LookVector_1.Z)
        local v8 = Spawn(
            v6,
            CFrame.lookAt(
                v5.Position,
                v5.Position + (if vec3_1.Magnitude > 0.01 then vec3_1 else Vector3.new(-0, -0, -1))
            ) * cframe
        )
        v5 = v8:FindFirstChild("CLEAVE")
        local v9 = v5

        if v9 then
            v9 = v5.Position
        end

        v8:ScaleTo(v8:GetScale() * 2.2)

        if v9 then
            v8:PivotTo(v8:GetPivot() + (v9 - v5.Position))
        end

        t[s2] = v8
        HeadlessFxUtil_m.Emit(v8:FindFirstChild("CLEAVE"))

        return
    end

    if s1 == "Hit" then
        local v13 = t[s2]
        local v14 = v13

        if v14 then
            v14 = v13:FindFirstChild("Final")
        end

        if v14 then
            HeadlessFxUtil_m.Emit(v14)
        end

        HeadlessFxUtil_m.Shake(v3.Position, 5, 10, 0.45)

        if v13 then
            Debris:AddItem(v13, 4)
        end
    end
end
