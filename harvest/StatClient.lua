-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Main.Menu.Pages.Stats.StatClient
-- Class: LocalScript
-- bytes: 9831

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage.Modules
local StatManager_m = require(Modules.StatManager)
local BackpackUtils_m = require(Modules.BackpackUtils)
local _ = require(Modules.Skills).Skillsets
local Skills = require(Modules.Skills).Skills
local v2, v3 = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StatManager_m.require(v2)
local Skills_1 = v2.Skills
local Humanoid = v3:WaitForChild("Humanoid")
local _ = v3:WaitForChild("HumanoidRootPart")
local States = v3:WaitForChild("States")
local _ = v2:WaitForChild("PlayerGui"):WaitForChild("Gameplay")
local Parent = script.Parent
local F2 = Parent.F2
local vec2 = Vector2.new(12, -24)

local _ = function(arg1) --[[ convertSeconds ]] -- line: 36
    local v5 = math.floor(arg1 / 60) % 60
    local v6 = math.floor(arg1 / 3600) % 24

    return math.floor(arg1 / 86400) .. "d " .. v6 .. "h " .. v5 .. "m"
end

local function setupStat(arg2) -- line: 43
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Services_m (copy)
    --  [3] Skills (copy)
    --  [4] BackpackUtils_m (copy)
    --  [5] vec2 (copy)
    --  [6] Parent (copy)

    local v7 = script.Template:Clone()
    local Name = arg2.Parent.Name

    if Name ~= "Magic Power" then
    else
    end

    local function upgradeStat() -- line: 49
        -- upvalues:
        --  [1] ReplicatedStorage (ref)
        --  [2] Name (copy)
        --  [3] Services_m (ref)

        if ReplicatedStorage.Remotes.Player.SkillEvent:InvokeServer("Unlock", Name) then
            Services_m.PlaySound(ReplicatedStorage.SFX.Misc.Upgrade, script)
        end
    end

    local function update() -- line: 55
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] Skills (ref)
        --  [3] Name (copy)
        --  [4] v7 (copy)

        local v8 = arg2.Value >= Skills[Name].MaxUpgrades and true
        v7.Frame.Val.Text = arg2.Value
        v7.Frame.Val.TextTransparency = if not v8 then 0 else 0.5
    end

    v7.Name = Name
    v7.Frame.Title.Text = Name
    v7.Frame.Plus.MouseButton1Click:Connect(upgradeStat)
    v7.MouseEnter:Connect(function() -- line: 65
        -- upvalues:
        --  [1] BackpackUtils_m (ref)
        --  [2] Name (copy)
        --  [3] vec2 (ref)

        BackpackUtils_m:ShowHover({ key = Name, offset = vec2 })
    end)
    v7.MouseLeave:Connect(function() -- line: 71
        -- upvalues:
        --  [1] BackpackUtils_m (ref)

        BackpackUtils_m:HideHover()
    end)
    v7.Parent = Parent.F1.List
    arg2:GetPropertyChangedSignal("Value"):Connect(update)
    upgradeStat = arg2.Value >= Skills[Name].MaxUpgrades and true
    v7.Frame.Val.Text = arg2.Value
    v7.Frame.Val.TextTransparency = if not upgradeStat then 0 else 0.5
end

local _ = function(arg3) --[[ createLabel ]] -- line: 81
    -- upvalues:
    --  [1] F2 (copy)

    local v11 = script.Stat:Clone()
    v11.Name = arg3
    v11.Parent = F2.List
end

local t_1 = {
    Skills_1:WaitForChild("Agility").Level,
    Skills_1:WaitForChild("Endurance").Level,
    Skills_1:WaitForChild("Strength").Level,
    Skills_1:WaitForChild("Intelligence").Level,
    Skills_1:WaitForChild("Vitality").Level,
    Skills_1:WaitForChild("Magic Power").Level
}
local t_2 = {
    {
        "Level",
        function() -- line: 97
            -- upvalues:
            --  [1] v4 (copy)

            local Level_5 = v4:GetStat("Level")

            return `<font color='rgb(176, 132, 208)'>Level {Level_5}</font>`
        end
    },
    {
        "Health",
        function() -- line: 101
            -- upvalues:
            --  [1] Humanoid (copy)

            return `Health<font face='SourceSans'>:</font> <font color='rgb(107, 170, 109)'>{Humanoid.MaxHealth}</font>`
        end
    },
    {
        "Resolve",
        function() -- line: 105
            -- upvalues:
            --  [1] States (copy)

            return `Resolve<font face='SourceSans'>:</font> <font color='rgb(184, 123, 0)'>{States.MaxResolve.Value}</font>`
        end
    },
    {
        "Energy",
        function() -- line: 109
            -- upvalues:
            --  [1] States (copy)

            return `Energy<font face='SourceSans'>:</font> <font color='rgb(162, 219, 255)'>{States.MaxEnergy.Value}</font>`
        end
    },
    {
        "Magic",
        function() -- line: 113
            -- upvalues:
            --  [1] v4 (copy)

            local Magic = v4:GetStat("Magic")
            local MagicVariant = v4:GetStat("MagicVariant")

            if Magic == "None" then
                return "User's magic ability is suppressed"
            end

            return `{Magic} Magic User ({MagicVariant})`
        end
    },
    {
        "Race",
        function() -- line: 119
            -- upvalues:
            --  [1] v2 (copy)

            return `Race<font face='SourceSans'>:</font> {v2.CustomizeFolder.Race.Value}`
        end
    },
    {
        "Health Bonus",
        function() -- line: 123
            -- upvalues:
            --  [1] States (copy)

            return `+{States.Armor.HealthBonus.Value} <font color='rgb(175, 175, 175)'>Health from Gear</font>`
        end
    },
    {
        "Energy Bonus",
        function() -- line: 127
            -- upvalues:
            --  [1] States (copy)

            return `+{States.Armor.EnergyBonus.Value} <font color='rgb(175, 175, 175)'>Energy from Gear</font>`
        end
    },
    {
        "Physical Resistance",
        function() -- line: 131
            -- upvalues:
            --  [1] States (copy)

            return `+{States.Armor.Physical.Value}% <font color='rgb(175, 175, 175)'>Physical Resistance</font>`
        end
    },
    {
        "Magic Resistance",
        function() -- line: 135
            -- upvalues:
            --  [1] States (copy)

            return `+{States.Armor.Magic.Value}% <font color='rgb(175, 175, 175)'>Magic Resistance</font>`
        end
    },
    {
        "Magic Regen",
        function() -- line: 139
            -- upvalues:
            --  [1] States (copy)

            return `+{States.Armor.ManaRegen.Value}% <font color='rgb(175, 175, 175)'>Mana Regen</font>`
        end
    },
    {
        "MonsterBonus",
        function() -- line: 143
            -- upvalues:
            --  [1] States (copy)

            return `+{States.Armor.MonsterBonus.Value}% <font color='rgb(175, 175, 175)'>PvE Damage</font>`
        end
    },
    {
        "HallowedWard",
        function() -- line: 147
            -- upvalues:
            --  [1] States (copy)

            local HallowedWard = States.Armor:FindFirstChild("HallowedWard")
            local v12 = HallowedWard and math.min(HallowedWard.Value, 35) or 0

            return `+{v12}% <font color='rgb(175, 175, 175)'>Hallowed Ward</font>`
        end
    },
    {
        "PEN_PHYS",
        function() -- line: 152
            -- upvalues:
            --  [1] States (copy)

            return `+{States.Armor.PEN_PHYS.Value}% <font color='rgb(175, 175, 175)'>Physical PEN</font>`
        end
    },
    {
        "PEN_MAGIC",
        function() -- line: 156
            -- upvalues:
            --  [1] States (copy)

            return `+{States.Armor.PEN_MAGIC.Value}% <font color='rgb(175, 175, 175)'>Magic PEN</font>`
        end
    },
    {
        "Time Played",
        function() -- line: 160
            -- upvalues:
            --  [1] v4 (copy)

            local TimePlayed = v4:GetStat("TimePlayed")
            local v13 = math.floor(TimePlayed / 60) % 60
            local v14 = math.floor(TimePlayed / 3600) % 24
            local v15 = math.floor(TimePlayed / 86400) .. "d " .. v14 .. "h " .. v13 .. "m"

            return `Time Played<font face='SourceSans'>:</font> {v15}`
        end
    },
    {
        "NPCKills",
        function() -- line: 164
            -- upvalues:
            --  [1] v4 (copy)

            local NPCKills = v4:GetStat("NPCKills")

            return `NPCS Slain<font face='SourceSans'>:</font> {NPCKills}`
        end
    },
    {
        "PlayerKills",
        function() -- line: 168
            -- upvalues:
            --  [1] v4 (copy)

            local PlayerKills = v4:GetStat("PlayerKills")

            return `Players Slain<font face='SourceSans'>:</font> {PlayerKills}`
        end
    }
}

local function UpdateUI() -- line: 173
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] F2 (copy)
    --  [3] States (copy)
    --  [4] Parent (copy)
    --  [5] v4 (copy)
    --  [6] Skills (copy)

    for _, val in ipairs(t_2) do
        F2.List[val[1]].Label.Text = val[2]()
    end

    local HallowedWard_1 = F2.List:FindFirstChild("HallowedWard")

    if HallowedWard_1 then
        local HallowedWard_2 = States.Armor:FindFirstChild("HallowedWard")
        HallowedWard_1.Visible = if HallowedWard_2 ~= nil then HallowedWard_2.Value > 0 else false
    end

    local MagicPower = Parent.F1.List["Magic Power"]
    MagicPower.Frame.Title.Text = v4:GetStat("Magic") .. " Intensity"
    MagicPower.Visible = if v4:GetStat("Magic") == "None" then false else true

    for _, descendant in Parent.F1.List:GetDescendants() do
        if descendant:FindFirstChild("Plus") then
            local Name_1 = descendant.Parent.Name
            local v18 = false
            local Plus = descendant.Plus

            if v4:GetStat("StatPoints") > 0 then
                v18 = tonumber(descendant.Val.Text) < Skills[Name_1].MaxUpgrades
            end

            Plus.Visible = v18
        end
    end
end

for _, val_1 in ipairs(t_2) do
    local v19 = val_1[1]
    local v20 = script.Stat:Clone()
    v20.Name = v19
    v20.Parent = F2.List
end

for _, val_2 in t_1 do
    setupStat(val_2)
end

v4:OnStatChanged("TimePlayed", UpdateUI)
UpdateUI()
