-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.DamageTag
-- Class: ModuleScript
-- bytes: 1160

local function damageTag(
    u1: userdata,
    u2: userdata,
    n1: number,
    _: number?,
    b1: boolean?
) -- line: 7
    local Name = u2.Name
    local v2 = u1:QueryDescendants(`Configuration[Name="{Name}"]`)[1]

    if not v2 then
        v2 = Instance.new("Configuration")
        v2.Name = Name
        v2:SetAttribute("Owner", Name)
        v2:SetAttribute("DMG", 0)
        v2:SetAttribute("DMGTotal", 0)
        v2:SetAttribute("HitCount", 0)
        local v3 = 0
        v2:GetAttributeChangedSignal("DMG"):Connect(function() -- line: 23
            -- upvalues:
            --  [1] v2 (ref)
            --  [2] v3 (ref)

            local DMG_1 = v2:GetAttribute("DMG")
            local v4 = DMG_1 - v3

            if v4 > 0 then
                v2:SetAttribute("DMGTotal", v2:GetAttribute("DMGTotal") + v4)
            end

            v3 = DMG_1
        end)
        v2.Parent = u1
    end

    v2:SetAttribute("DMG", v2:GetAttribute("DMG") + n1)
    v2:SetAttribute("HitCount", v2:GetAttribute("HitCount") + 1)

    if not b1 then
        u1:SetAttribute("Skill_Damaged", not u1:GetAttribute("Skill_Damaged"))
    end
end

return damageTag
