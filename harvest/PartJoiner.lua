-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Crits.Wolfcrest_FX.PartJoiner
-- Class: ModuleScript
-- bytes: 1804

local t = {
    CalcWeldC0 = function(arg1, arg2) --[[ CalcWeldC0 ]] -- line: 3
        return arg1:ToObjectSpace(arg2)
    end
}

local _ = function(
    s1: string,
    u1: userdata,
    u2: userdata,
    u3: CFrame?,
    u4: CFrame?,
    u5: userdata?
) --[[ joinParts ]] -- line: 7
    -- upvalues:
    --  [1] t (copy)

    local v1 = Instance.new(s1)
    v1.Part0 = u1
    v1.Part1 = u2

    if s1 ~= "WeldConstraint" then
        local v2 = u3 or t.CalcWeldC0(u1.CFrame, u2.CFrame)
        v1.C0 = v2

        if u4 then
            v1.C1 = u4
        end
    end

    v1.Parent = u5 or u1

    return v1
end

function t.AddMotor6D(
    u6: userdata,
    u7: userdata,
    u8: CFrame?,
    u9: CFrame?,
    u10: userdata?
) -- line: 22
    -- upvalues:
    --  [1] t (copy)

    local Motor6D = Instance.new("Motor6D")
    Motor6D.Part0 = u6
    Motor6D.Part1 = u7
    local v3 = u8 or t.CalcWeldC0(u6.CFrame, u7.CFrame)
    Motor6D.C0 = v3

    if u9 then
        Motor6D.C1 = u9
    end

    Motor6D.Parent = u10 or u6

    return Motor6D
end

function t.Weld(
    u11: userdata,
    u12: userdata,
    u13: CFrame?,
    u14: CFrame?,
    u15: userdata?
) -- line: 26
    -- upvalues:
    --  [1] t (copy)

    local Weld = Instance.new("Weld")
    Weld.Part0 = u11
    Weld.Part1 = u12
    local v4 = u13 or t.CalcWeldC0(u11.CFrame, u12.CFrame)
    Weld.C0 = v4

    if u14 then
        Weld.C1 = u14
    end

    Weld.Parent = u15 or u11

    return Weld
end

function t.AddWeldConstraint(
    u16: userdata,
    u17: userdata,
    _: CFrame?,
    _: CFrame?,
    u20: userdata?
) -- line: 30
    local WeldConstraint = Instance.new("WeldConstraint")
    WeldConstraint.Part0 = u16
    WeldConstraint.Part1 = u17
    WeldConstraint.Parent = u20 or u16

    return WeldConstraint
end

return t
