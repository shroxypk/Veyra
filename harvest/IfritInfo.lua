-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Skills.Spirits.IfritInfo
-- Class: ModuleScript
-- bytes: 698

local _ = _G.NoDescription
local t = {}
t["Heat Resistance"] = {
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "While in Spirit Surge, gain immunity to burning damage status effect.",
    Skillset = "Ifrit Passive",
    Type = "Spirit",
    Image = _G.spirit_icon,
    Restrictions = {}
}
t["Ignition Reflex"] = {
    ReqType = "Trainer",
    Requirement = 1,
    RequirementText = "",
    Description = "While in Spirit Surge, successfully dodging an attack creates a blast of flames around the player, inflicting burn to those nearby.",
    Skillset = "Ifrit Passive",
    Type = "Spirit",
    Image = _G.spirit_icon,
    Restrictions = {}
}

return t
