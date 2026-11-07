-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.Multipliers.Wrath Unbound
-- Class: ModuleScript
-- bytes: 368

local function main(u1: userdata, _: userdata, arg1: any) -- line: 7
    local v1 = table.find(arg1.AttackTypes, "P")
    local v2 = 0
    local HitStreak = u1:GetAttribute("HitStreak")

    if v1 then
        if u1:FindFirstChild(`{script.Name}`) and HitStreak then
            v2 = math.min(HitStreak, 10) * 0.025
        end
    end

    return v2
end

return main
