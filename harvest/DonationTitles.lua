-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.DonationTitles
-- Class: ModuleScript
-- bytes: 1223

local t = {}
t.Tiers = {
    {
        Name = "Small Donation",
        Title = "Donator",
        Required = 50,
        Color = Color3.fromRGB(255, 236, 140),
        Desc = "Donated to support the game."
    },
    {
        Name = "Medium Donation",
        Title = "Patron",
        Required = 500,
        Color = Color3.fromRGB(255, 205, 40),
        Desc = "Donated a total of 500 Robux to support the game."
    },
    {
        Name = "Large Donation",
        Title = "Gilded Patron",
        Required = 2000,
        Color = Color3.fromRGB(78, 145, 62),
        Desc = "Donated a total of 2,000 Robux to support the game."
    },
    {
        Name = "Giant Donation",
        Title = "Kingmaker",
        Required = 10000,
        Color = Color3.fromRGB(170, 235, 120),
        Desc = "Donated a total of 10,000 Robux to support the game."
    }
}
t.TopTitle = "Crown of Patrons"
t.TopCount = 5
t.TopMinDonated = 10000
t.TopColor = Color3.fromRGB(229, 191, 97)

function t.IsTopEligible(_, arg2, arg3) -- line: 29
    -- upvalues:
    --  [1] t (copy)

    return if typeof(arg2) == "number" then if arg2 <= t.TopCount then (tonumber(arg3) or 0) >= t.TopMinDonated and true else false else false
end

return t
