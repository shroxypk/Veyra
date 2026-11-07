-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Titles
-- Class: ModuleScript
-- bytes: 5622

local t = {}
t.Adventurer = {
    Desc = "Took the first step into the unknown, solving your first sphinx riddle.",
    Color = Color3.fromRGB(153, 218, 152)
}
t.Baron = {
    Desc = "Amassed and stored the maximum wealth possible within the bank.",
    Color = Color3.fromRGB(255, 241, 189)
}
t["Beast Slayer"] = { Desc = "Achieved 1000 mob kills.", Color = Color3.fromRGB(180, 40, 40) }
t.Executioner = { Desc = "Achieved 100 player kills." }
t["No Life King"] = {
    Desc = "Endured the passage of time itself, reaching an unfathomable amount of playtime.",
    Color = Color3.fromRGB(145, 49, 49)
}
t.Soulkeeper = {
    Desc = "Purified souls trapped within the Eldritch Region, guiding them to their final rest."
}
t.Sovereign = {
    Desc = "Reached the highest rank in the colosseum. Reserved to the top 50 players eclipsing X rating."
}
t.Knight = { Desc = "Successfully passed the Magic Exams.", Color = Color3.fromRGB(210, 232, 255) }
t.Windborne = {
    Desc = "Trusted in the wind at the hidden shrine, unlocking the Air Dash.",
    Color = Color3.fromRGB(170, 225, 255)
}
t.Wayfarer = {
    Desc = "For those who have mastered the roads between worlds.",
    Color = Color3.fromRGB(221, 174, 255)
}
t.Explorer = { Desc = "Discovered 10 locations." }
t.Boundless = { Desc = "Discovered all possible locations." }
t.Bookworm = { Desc = "Collected 5 books.", Color = Color3.fromRGB(178, 224, 171) }
t.Scholar = { Desc = "Collected 10 books.", Color = Color3.fromRGB(186, 214, 255) }
t.Archivist = { Desc = "Collected 25 books.", Color = Color3.fromRGB(255, 214, 140) }
t["Combat Warrior"] = { Desc = "No description available.", Color = Color3.fromRGB(180, 40, 40) }
t.Deepdelver = { Desc = "No description available." }
t.Herbalist = { Desc = "No description available.", Color = Color3.fromRGB(183, 200, 156) }
t.Forgemaster = { Desc = "No description available.", Color = Color3.fromRGB(157, 121, 62) }
t["Air Savant"] = { Desc = "No description available." }
t.Godslayer = { Desc = "???", Hidden = false }
t["One Man Army"] = { Desc = "???", Hidden = false }
t["Eldritch Huntmaster"] = {
    Desc = "Completed Master Hunter Goran's trial, proving yourself the apex hunter of the Eldritch Region.",
    Color = Color3.fromRGB(163, 93, 252)
}
t["Kamo Huntmaster"] = {
    Desc = "Completed Skadi's trial, proving yourself the apex hunter of the Kamo Region.",
    Color = Color3.fromRGB(120, 200, 255)
}
t.Tester = {
    Desc = "Helped shape the realm as a Tester before release.",
    Color = Color3.fromRGB(124, 214, 196)
}
t["Early Access"] = {
    Desc = "Entered the realm ahead of the rest with Early Access.",
    Color = Color3.fromRGB(255, 205, 120)
}
t.Transcendent = {
    Desc = "Stood with the Thousandfold from the very beginning, as a Premium Tester.",
    Color = Color3.fromRGB(190, 240, 255)
}
t.Primordial = {
    Desc = "Present at the dawn of the realm. Claimed from the Release Bundle.",
    Color = Color3.fromRGB(200, 30, 30),
    Gradient = "Primordial",
    Font = Enum.Font.Garamond
}
t.Hallowed = {
    Desc = "Took to the night sky on a burning broom. Claimed from the 2026 Halloween Bundle.",
    Color = Color3.fromRGB(255, 109, 25),
    Gradient = "Hallowed",
    Font = Enum.Font.Garamond
}
t["Trick or Treater"] = {
    Desc = "Earned 15,000 Candy Corn in the 2026 Halloween event.",
    Color = Color3.fromRGB(235, 140, 50)
}
t["Spirit Caller"] = {
    Desc = "Earned 65,000 Candy Corn in the 2026 Halloween event.",
    Color = Color3.fromRGB(170, 150, 235)
}
t.Haunted = {
    Desc = "Completed the 2026 Halloween Pass (300,000 Candy Corn).",
    Color = Color3.fromRGB(200, 40, 40)
}
t.Harvester = {
    Desc = "Found every treat in the 2026 Trick-or-Treat Journal.",
    Color = Color3.fromRGB(255, 190, 70)
}
t.Dreadbringer = {
    Desc = "Survived every trick in the 2026 Trick-or-Treat Journal.",
    Color = Color3.fromRGB(150, 60, 200)
}
t.Nightwalker = {
    Desc = "Met every trick-or-treater in the 2026 Trick-or-Treat Journal.",
    Color = Color3.fromRGB(110, 140, 220)
}
t.Witchborn = {
    Desc = "Completed the 2026 Trick-or-Treat Journal.",
    Color = Color3.fromRGB(120, 230, 110)
}
local Success, Result = pcall(require, script.Parent.DonationTitles)

if Success then
    for _, val in Result.Tiers do
        local t_28 = { Desc = val.Desc, Color = val.Color }
        t[val.Title] = t_28
    end

    t[Result.TopTitle] = {
        Desc = `Reached the top {Result.TopCount} of the donation leaderboard (with at least {Result.TopMinDonated} Robux donated).`,
        Color = Result.TopColor
    }
else
    warn("[Titles] could not load donation titles:", Result)
end

local Success_1, Result_1 = pcall(require, script.Parent.Professions)

if Success_1 then
    local v1 = Result_1:GetProfessions()
    local v4

    for key_1, val_1 in Result_1:GetAllTitles() do
        local v2 = t[key_1]

        if val_1.Profession then
            local v3 = Result_1.Ranks[val_1.Rank]
            v4 = `Reached {v3.Name} rank (level {v3.Level}) in {val_1.Profession}.`
        else
            v4 = `Reached a combined profession level of {val_1.Total}.`
        end

        if v2 then
            if v2.Desc == "No description available." then
                v2.Desc = v4
            end
        else
            local v5 = val_1.Profession

            if v5 then
                v5 = v1[val_1.Profession]
            end

            local t_30 = { Desc = v4, Color = v5 and v5.Color or Color3.fromRGB(255, 214, 140) }
            t[key_1] = t_30
        end
    end

    return t
end

warn("[Titles] could not load profession titles:", Result_1)

return t
