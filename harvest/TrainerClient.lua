-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.UI.TrainerClient
-- Class: LocalScript
-- bytes: 10926

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local Basic_m = require(Modules.Basic)
local _ = require(Modules.Skills).Skillsets
local Skills = require(Modules.Skills).Skills
local StatManager_m = require(Modules.StatManager)
local Formatter_m = require(Modules.Formatter)
local v2, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StatManager_m.require(v2)
local Inventory = v2:WaitForChild("Inventory")
local Skills_1 = v2:WaitForChild("Skills")
local Main = script.Main
local List = Main.Options.List
local Info = Main.Info
local Header = Info.Header
local Description = Info.Description
local Requirements = Info.Requirements
local Mastery = Main.Mastery
local Chat = Main.Chat
local v5 = script.Parent.DisplayName.Value
local Header_1 = Main.TopBar.Header
local v6 = script.Parent:FindFirstChild("UIName") and script.Parent.UIName.Value or v5
Header_1.Text = `\227\128\136 {string.upper(v6)} \227\128\137`
Chat.Header.Text = v5
Chat.Description.Text = script.Parent:GetAttribute("ChatLine") or "What gifts would you be interested in developing today?"
Header:GetPropertyChangedSignal("Text"):Connect(function() -- line: 42
    -- upvalues:
    --  [1] Header (copy)

    Header.Visible = Header.Text ~= ""
end)

function UnHighlight() -- line: 46
    -- upvalues:
    --  [1] Header (copy)
    --  [2] Description (copy)
    --  [3] Requirements (copy)
    --  [4] List (copy)
    --  [5] Info (copy)

    Header.Text = ""
    Description.Text = ""

    for _, val in Requirements:QueryDescendants("Frame") do
        val:Destroy()
    end

    for _, val_1 in List:QueryDescendants("[Name=\"Highlight\"]") do
        val_1.Visible = false
    end

    Info.Action.Visible = false
end

for _, child in script.Parent.Skills:GetChildren() do
    v6 = child.Name
    v5 = Skills[v6]

    if v5 then
        local v8 = script.Template:Clone()
        v8.Name = v6
        local Labels = v8.Labels
        local Label = Labels.Label
        Label:GetPropertyChangedSignal("TextBounds"):Connect(function() -- line: 75
            -- upvalues:
            --  [1] Label (copy)

            Label.Size = UDim2.new(0, Label.TextBounds.X + 5, 0, Label.Size.Y.Offset)
        end)
        Label.Text = v6
        Label.Highlight.Text = Label.Text
        v8.Button.MouseButton1Up:Connect(function() -- line: 82
            -- upvalues:
            --  [1] Labels (copy)
            --  [2] Header (copy)
            --  [3] Description (copy)
            --  [4] v5 (copy)
            --  [5] Formatter_m (copy)
            --  [6] Requirements (copy)
            --  [7] Info (copy)
            --  [8] Skills_1 (copy)
            --  [9] v6 (copy)

            if Labels.Label.Highlight.Visible then
                return
            end

            UnHighlight()
            Labels.Label.Highlight.Visible = true
            Header.Text = Labels.Label.Text
            Description.Text = v5.Description
            local v12 = v5.Required or {}

            for key_3, val_2 in v12 do
                local v13 = script:FindFirstChild(key_3)

                if v13 then
                    v13 = script:FindFirstChild(key_3):Clone()
                end

                if v13 then
                    local Amount = v13:FindFirstChild("Amount")

                    if key_3 == "Insight" then
                        Amount.Text = `{val_2} Insight`
                    elseif key_3 == "Marks" then
                        local v15 = Formatter_m.addCommas(val_2)
                        Amount.Text = `{v15} Marks`
                    elseif key_3 == "Points" then
                        Amount.Text = val_2 .. " Skill Points"
                    elseif key_3 == "Proficiency" then
                        Amount.Text = `{val_2.Amount} {val_2.Type} Proficiency`
                    elseif key_3 == "Stat" then
                        for key_4, val_3 in val_2 do
                            local v16 = script.Label:Clone()
                            v16.Name = key_4
                            v16.Text = key_4 .. " " .. val_3
                            v16.Parent = v13
                        end
                    elseif key_3 == "" then
                    end

                    v13.Parent = Requirements

                    if Amount then
                        Amount:GetPropertyChangedSignal("TextBounds"):Connect(function() --[[ AdjustTaskSize ]] -- line: 122
                            -- upvalues:
                            --  [1] Amount (copy)

                            Amount.Size = UDim2.new(0, Amount.TextBounds.X + 1, 1, 0)
                        end)
                        Amount.Size = UDim2.new(0, Amount.TextBounds.X + 1, 1, 0)
                    end
                end
            end

            Info.Action.Visible = not Skills_1:FindFirstChild(v6)
        end)

        if Skills_1:FindFirstChild(v6) then
            Labels.Unlocked.Visible = true
        end

        v8.Parent = List
    end
end

Info.Action.MouseButton1Click:Connect(function() -- line: 142
    -- upvalues:
    --  [1] Skills_1 (copy)
    --  [2] Header (copy)
    --  [3] ReplicatedStorage (copy)
    --  [4] Services_m (copy)

    if Skills_1:FindFirstChild(Header.Text) or Header.Text == "" then
        return
    end

    if ReplicatedStorage.Remotes.Player.SkillEvent:InvokeServer("UnlockTrainer", Header.Text) then
        return
    end

    Services_m.PlaySound(ReplicatedStorage.SFX.Misc.Error, script)
end)

if script.Parent.Name:match("WepTrainer") then
    Mastery.Visible = true
    Chat.Visible = false
    local t = {
        LightWepTrainer = { Index = "Light" },
        MediumWepTrainer = { Index = "Medium" },
        HeavyWepTrainer = { Index = "Heavy" }
    }
    local Index = t[script.Parent.Name].Index
    local Remotes = ReplicatedStorage.Remotes.Mastery:InvokeServer("GetPrice", Index)
    Mastery.Header.Text = `Upgrading {Index} Proficiency`

    local _ = function() --[[ PriceDisplay ]] -- line: 178
        -- upvalues:
        --  [1] Mastery (copy)
        --  [2] Remotes (ref)
        --  [3] Basic_m (copy)

        Mastery.Action.info.Marks.Amount.Text = Remotes .. " MARKS"
        Mastery.Action.info.Insight.Amount.Text = Basic_m.MasteryInsight
        Mastery.Action.info.Points.Amount.Text = Basic_m.MasterySP .. " Stat Points"
    end

    local function UpdateUI() -- line: 184
        -- upvalues:
        --  [1] v4 (copy)
        --  [2] Index (copy)
        --  [3] Basic_m (copy)
        --  [4] Inventory (copy)
        --  [5] Mastery (copy)
        --  [6] t (copy)
        --  [7] Remotes (ref)
        --  [8] ReplicatedStorage (copy)

        local v20 = v4:GetStat(`{Index}Mastery`)
        local v21 = `Your {Index} Proficiency is currently <font color="rgb(91, 168, 57)">LEVEL {v20}</font>.`

        if v20 == Basic_m.MasteryUncap then
            if Inventory:FindFirstChild("Percival's Recommendation") then
                Mastery.Description.Text = `Your {Index} Proficiency is currently <font color="rgb(91, 168, 57)">LEVEL {v20}</font>. <font color='rgb(150, 38, 38)'>Choosing to go down this path will now lock other weapon proficiencies from being upgraded</font>.`
                Mastery.Action.Locked.Visible = false
            else
                Mastery.Description.Text = "Further advancement in weapon proficiency requires obtaining a letter of recommendation from <font color='rgb(255, 128, 37)'>Percival</font>. No other trainers will permit further upgrades without his authorization."
                Mastery.Action.Locked.Visible = true
            end
        else
            Mastery.Description.Text = v21
            Mastery.Action.Locked.Visible = false
        end

        local v22 = nil

        for _, val_4 in pairs(t) do
            if v4:GetStat(`{val_4.Index}Mastery`) > Basic_m.MasteryUncap then
                v22 = true
                break
            end
        end

        local v25 = v22 and v20 <= Basic_m.MasteryUncap
        Mastery.Locked.Visible = v25
        Remotes = ReplicatedStorage.Remotes.Mastery:InvokeServer("GetPrice", Index)
        Mastery.Action.info.Marks.Amount.Text = Remotes .. " MARKS"
        Mastery.Action.info.Insight.Amount.Text = Basic_m.MasteryInsight
        Mastery.Action.info.Points.Amount.Text = Basic_m.MasterySP .. " Stat Points"
    end

    UpdateUI()
    Mastery.Action.MouseEnter:Connect(function() -- line: 221
        -- upvalues:
        --  [1] Mastery (copy)
        --  [2] Remotes (ref)
        --  [3] Basic_m (copy)

        Mastery.Action.info.Marks.Amount.Text = Remotes .. " MARKS"
        Mastery.Action.info.Insight.Amount.Text = Basic_m.MasteryInsight
        Mastery.Action.info.Points.Amount.Text = Basic_m.MasterySP .. " Stat Points"
        Mastery.Action.info.Visible = true
    end)
    Mastery.Action.MouseLeave:Connect(function() -- line: 226
        -- upvalues:
        --  [1] Mastery (copy)

        Mastery.Action.info.Visible = false
    end)
    Mastery.Action.MouseButton1Up:Connect(function() -- line: 230
        -- upvalues:
        --  [1] ReplicatedStorage (copy)
        --  [2] Index (copy)
        --  [3] UpdateUI (copy)
        --  [4] Services_m (copy)

        if ReplicatedStorage.Remotes.Mastery:InvokeServer(Index) then
            UpdateUI()
            Services_m.PlaySound(ReplicatedStorage.SFX.Misc.Buy, script)

            return
        end

        Services_m.PlaySound(ReplicatedStorage.SFX.Misc.Error, script)
    end)
    Inventory.ChildAdded:Connect(function(child_1) -- line: 239
        -- upvalues:
        --  [1] UpdateUI (copy)

        if child_1.Name == "Percival's Recommendation" then
            UpdateUI()
        end
    end)
    local v26 = `{Index}MasteryXP`
    local v27 = `{Index}MasteryMXP`

    local function UpdateBar() -- line: 249
        -- upvalues:
        --  [1] v4 (copy)
        --  [2] v26 (copy)
        --  [3] v27 (copy)
        --  [4] Mastery (copy)

        local v28 = v4:GetStat(v26)
        local v29 = v4:GetStat(v27)
        Mastery.Bar.Front:TweenSize(
            UDim2.new(math.clamp(v28 / v29, 0, 1), 0, 1, 0),
            "Out",
            "Quad",
            0.5,
            true
        )
    end

    v4:OnStatChanged(v26, UpdateBar)
    v4:OnStatChanged(v27, UpdateBar)
    UpdateBar()
else
    Mastery.Visible = false
    Chat.Visible = true
end

Main.Parent = script.Parent

local function v32(arg2) -- line: 266
    -- upvalues:
    --  [1] List (copy)
    --  [2] Header (copy)

    local Name = arg2.Name
    local v31 = List:FindFirstChild(Name)

    if v31 then
        v31.Labels.Unlocked.Visible = true
    end

    if Header.Text == Name then
        UnHighlight()
    end
end

Skills_1.ChildAdded:Connect(v32)
