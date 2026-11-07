-- Decompiled with Veyra harvester
-- Instance: StarterGui.TraitUI.Main.TraitClient
-- Class: LocalScript
-- bytes: 15614

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Modules = ReplicatedStorage.Modules
local _ = require(Modules.BackpackUtils)
local _ = require(Modules.Formatter)
local StatManager_m = require(Modules.StatManager)
local Skillsets = require(Modules.Skills).Skillsets
local _ = require(Modules.Skills).Skills
local TraitInfo = Skillsets.TraitInfo
local v2, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StatManager_m.require(v2)
local Skills_1 = v2:WaitForChild("Skills")
local Window = script.Parent.Window
local Pages = Window.Pages
local RightPage = Window.RightPage
local Scrolling = Pages.Scrolling
local Label = RightPage.Scrolling.Description.Display.Label
local Header = RightPage.Header
local Display = RightPage.Scrolling.Required.Display
local t = {}
local Quests = v2:WaitForChild("Quests")
local t_1 = {}
local _ = Color3.fromRGB(170, 255, 127)

local function CreateContents(arg1) -- line: 46
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] Scrolling (copy)

    arg1 = if arg1 == "" then "Misc" else arg1

    if not t_1[arg1] then
        local v6 = script.TemplateContents:Clone()
        v6.Name = arg1
        local Header_1 = v6.Header
        Header_1.Label.Text = arg1
        v6.Parent = Scrolling
        local t_2 = {}

        local _ = function() --[[ handleVisible ]] -- line: 59
            -- upvalues:
            --  [1] t_2 (copy)
            --  [2] v6 (copy)
            --  [3] Header_1 (copy)
            --  [4] arg1 (ref)

            local v7 = #t_2
            local v8 = #v6.Items:GetChildren() - 2
            v6.Visible = v7 > 0 and true
            Header_1.Label.Text = `{arg1} <font face='SourceSans'>({v7}/{v8})</font>`
        end

        local function childAdded(arg2) -- line: 66
            -- upvalues:
            --  [1] t_2 (copy)
            --  [2] v6 (copy)
            --  [3] Header_1 (copy)
            --  [4] arg1 (ref)

            if not arg2:IsA("GuiObject") then
                return
            end

            arg2:GetPropertyChangedSignal("Visible"):Connect(function() --[[ objectVisibility ]] -- line: 71
                -- upvalues:
                --  [1] arg2 (copy)
                --  [2] t_2 (ref)
                --  [3] v6 (ref)
                --  [4] Header_1 (ref)
                --  [5] arg1 (ref)

                if arg2.Visible then
                    table.insert(t_2, arg2.Name)
                else
                    local v11 = table.find(t_2, arg2.Name)

                    if v11 then
                        table.remove(t_2, v11)
                    end
                end

                local v12 = #t_2
                local v13 = #v6.Items:GetChildren() - 2
                v6.Visible = v12 > 0 and true
                Header_1.Label.Text = `{arg1} <font face='SourceSans'>({v12}/{v13})</font>`
            end)

            if arg2.Visible then
                table.insert(t_2, arg2.Name)
            else
                local v16 = table.find(t_2, arg2.Name)

                if v16 then
                    table.remove(t_2, v16)
                end
            end

            local v17 = #t_2
            local v18 = #v6.Items:GetChildren() - 2
            v6.Visible = v17 > 0 and true
            Header_1.Label.Text = `{arg1} <font face='SourceSans'>({v17}/{v18})</font>`
        end

        local function childRemoved(arg3) -- line: 87
            -- upvalues:
            --  [1] t_2 (copy)
            --  [2] v6 (copy)
            --  [3] Header_1 (copy)
            --  [4] arg1 (ref)

            if not arg3:IsA("GuiObject") then
                return
            end

            local v21 = table.find(t_2, arg3.Name)

            if v21 then
                table.remove(t_2, v21)
            end

            local v22 = #t_2
            local v23 = #v6.Items:GetChildren() - 2
            v6.Visible = v22 > 0 and true
            Header_1.Label.Text = `{arg1} <font face='SourceSans'>({v22}/{v23})</font>`
        end

        v6.Items.ChildAdded:Connect(childAdded)
        v6.Items.ChildRemoved:Connect(childRemoved)
        local v26 = #t_2
        local v27 = #v6.Items:GetChildren() - 2
        v6.Visible = v26 > 0 and true
        Header_1.Label.Text = `{arg1} <font face='SourceSans'>({v26}/{v27})</font>`
        t_1[arg1] = v6
    end

    return arg1
end

local function UnHighlight() -- line: 110
    -- upvalues:
    --  [1] Header (copy)
    --  [2] Label (copy)
    --  [3] Display (copy)
    --  [4] Pages (copy)

    script:SetAttribute("ItemVal", nil)
    Header.Text = ""
    Label.Text = ""

    for _, child in Display:GetChildren() do
        if child:GetAttribute("Req") then
            child:Destroy()
        end
    end

    for _, descendant in Pages:GetDescendants() do
        if descendant:GetAttribute("Highlighted") ~= nil then
            descendant:SetAttribute("Highlighted", false)
        end
    end
end

local function CheckRequirements(arg4, _) -- line: 130
    -- upvalues:
    --  [1] t (copy)
    --  [2] Skills_1 (copy)
    --  [3] TraitInfo (copy)
    --  [4] v4 (copy)
    --  [5] Quests (copy)

    local _ = t[arg4]

    if Skills_1:FindFirstChild(arg4) then
        return true
    end

    local v30 = TraitInfo[arg4]

    if v30 then
        local t_3 = {}
        local v31 = 0
        local v32 = 0

        for key_2, val in v30.Required do
            if key_2 == "Stat" or key_2 == "Quest" then
                v32 += 1
                t_3[key_2] = val
            end
        end

        local v33

        for key_3, val_1 in t_3 do
            if key_3 == "Stat" then
                v33 = 0
                local v34 = 0

                for _, _ in pairs(val_1) do
                    v34 += 1
                end

                for key_5, val_3 in pairs(val_1) do
                    local v35 = v4:GetStat(key_5)

                    if v35 ~= nil and val_3 <= v35 then
                        v33 += 1
                    else
                        local v36 = Skills_1:FindFirstChild(key_5)

                        if v36 and val_3 <= v36.Level.Value then
                            v33 += 1
                        end
                    end
                end

                if v33 >= v34 then
                    v31 += 1
                end
            elseif key_3 == "Quest" then
                v33 = Quests:FindFirstChild(val_1)

                if v33 and v33:GetAttribute("Completed") then
                    v31 += 1
                end
            end
        end

        if v31 >= v32 then
            return true
        end
    end
end

local function getDiscoverableTraits() -- line: 189
    -- upvalues:
    --  [1] t (copy)
    --  [2] Pages (copy)

    local v37 = 0
    local v38 = 0

    for _, val_4 in t do
        v38 += 1

        if val_4.Visible then
            v37 += 1
        end
    end

    local _ = v38 - v37
    Pages.discoverableTraits.Text = `{v37} of {v38} traits discovered...`
end

local function TRAIT_DISCOVERED(arg6) -- line: 203
    -- upvalues:
    --  [1] Skills_1 (copy)
    --  [2] t (copy)
    --  [3] Services_m (copy)
    --  [4] ReplicatedStorage (copy)
    --  [5] UnHighlight (copy)

    local v40 = if Skills_1:FindFirstChild(arg6) then true else false
    local v41 = t[arg6]

    if v41 and not Skills_1:FindFirstChild(arg6) and not v41:GetAttribute("Discovered") then
        v41:SetAttribute("Unlocked", v40)

        if v41:GetAttribute("Discovered") then
            return
        end

        v41.Discovered.Visible = true
        v41:SetAttribute("Discovered", true)
        Services_m.PlaySound(ReplicatedStorage.SFX.Player.blip, script)
        UnHighlight()
        _G.CreateAlert(`You discovered the trait <font color='rgb(155, 198, 255)'>({arg6})</font>`)
    end
end

local function CreateEntry(arg7) -- line: 223
    -- upvalues:
    --  [1] t (copy)
    --  [2] TraitInfo (copy)
    --  [3] CreateContents (copy)
    --  [4] Scrolling (copy)
    --  [5] TweenService (copy)
    --  [6] Skills_1 (copy)
    --  [7] CheckRequirements (copy)
    --  [8] getDiscoverableTraits (copy)
    --  [9] UnHighlight (copy)

    if t[arg7] then
        return
    end

    local v42 = TraitInfo[arg7]

    if not v42 then
        return
    end

    local v43 = CreateContents(v42.Class or "Misc")
    local v44 = Scrolling:FindFirstChild(v43)
    local v45 = script.SubTemplate:Clone()
    local Press = v45.Press
    local Display_1 = v45.Display
    v45:SetAttribute("FilterType", v43)
    v45.Name = arg7
    Display_1.Label.Text = arg7

    local function updateBackground() -- line: 248
        -- upvalues:
        --  [1] v45 (copy)
        --  [2] TweenService (ref)
        --  [3] Press (copy)

        local color_1 = Color3.fromRGB(21, 21, 34)
        local color_2 = Color3.fromRGB(53, 53, 85)

        if v45:GetAttribute("Unlocked") then
            color_1 = Color3.fromRGB(54, 83, 32)
            color_2 = Color3.fromRGB(65, 85, 46)
        end

        if v45:GetAttribute("Highlighted") then
            color_2 = Color3.fromRGB(139, 106, 40)
        end

        TweenService:Create(Press, TweenInfo.new(0.2), { BackgroundColor3 = color_1 }):Play()
        TweenService:Create(v45.Outline, TweenInfo.new(0.2), { ImageColor3 = color_2 }):Play()
    end

    t[arg7] = v45
    v45:GetAttributeChangedSignal("Unlocked"):Connect(updateBackground)
    v45:GetAttributeChangedSignal("Discovered"):Connect(function() -- line: 268
        -- upvalues:
        --  [1] v45 (copy)

        v45.Visible = v45:GetAttribute("Discovered")
    end)
    v43 = false
    local v51 = false

    if Skills_1:FindFirstChild(arg7) then
        v43 = true
    elseif CheckRequirements(arg7) then
        v51 = true
    end

    v45:SetAttribute("Unlocked", v43)
    v45:SetAttribute("Discovered", v51 or v45:GetAttribute("Unlocked"))
    v45:GetPropertyChangedSignal("Visible"):Connect(getDiscoverableTraits)
    v45:SetAttribute("Highlighted", false)
    v45:GetAttributeChangedSignal("Highlighted"):Connect(function() -- line: 288
        -- upvalues:
        --  [1] v45 (copy)
        --  [2] arg7 (copy)
        --  [3] updateBackground (copy)

        if v45:GetAttribute("Highlighted") then
            script:SetAttribute("ItemVal", arg7)
        end

        updateBackground()
    end)
    v45.Press.MouseButton1Up:Connect(function() -- line: 296
        -- upvalues:
        --  [1] arg7 (copy)
        --  [2] UnHighlight (ref)
        --  [3] v45 (copy)

        if script:GetAttribute("ItemVal") == arg7 then
            UnHighlight()

            return
        end

        v45.Discovered.Visible = false
        UnHighlight()
        v45:SetAttribute("Highlighted", true)
    end)
    v45.Parent = v44.Items
end

local function skillChanged() -- line: 312
    -- upvalues:
    --  [1] RightPage (copy)
    --  [2] TraitInfo (copy)
    --  [3] Display (copy)
    --  [4] Header (copy)
    --  [5] Label (copy)
    --  [6] Skills_1 (copy)

    local ItemVal = script:GetAttribute("ItemVal")

    if not ItemVal then
        RightPage.Visible = false

        return
    end

    local v53 = TraitInfo[ItemVal]
    local Description = v53.Description
    local v54 = v53.Type
    v54 = v53.Required or {}

    for key_7, val_5 in v54 do
        local v55 = script:FindFirstChild(key_7)

        if v55 then
            local v56 = v55:Clone()
            v56:SetAttribute("Req", true)

            if key_7 == "Insight" then
                v56.Amount.Text = val_5 .. " Insight"
            elseif key_7 == "Marks" then
                v56.Amount.Text = _G.addCommas(val_5) .. " Marks"
            elseif key_7 == "Points" then
                v56.Amount.Text = val_5 .. " Skill Points"
            elseif key_7 == "Prereq" then
                for key_8 in val_5 do
                    v56.Text = `{v56.Text}-{key_8}\n`
                end
            end

            v56.Parent = Display
        end
    end

    Header.Text = ItemVal
    Label.Text = Description

    if Skills_1:FindFirstChild(ItemVal) then
        RightPage.Options.Action.Visible = false
    else
        RightPage.Options.Action.Visible = true
    end

    RightPage.Visible = true
end

local function viewingChanged() -- line: 359
    -- upvalues:
    --  [1] t (copy)

    local Viewing = script:GetAttribute("Viewing")

    for _, val_6 in t do
        local v57 = string.upper(val_6.Name)
        local v58 = string.upper(val_6:GetAttribute("FilterType"))

        if val_6:GetAttribute("Unlocked") or val_6:GetAttribute("Discovered") then
            if Viewing ~= "" then
                if string.find(v57, Viewing) == nil then
                    if string.find(v58, Viewing) ~= nil then
                        val_6.Visible = true
                    else
                        val_6.Visible = false
                    end
                else
                    val_6.Visible = true
                    val_6.Visible = false
                end
            else
                val_6.Visible = true
                val_6.Visible = false
            end
        end
    end
end

for key_10, _ in TraitInfo do
    CreateEntry(key_10)
end

local v60 = 0
local v61 = 0

for _, val_8 in t do
    v61 += 1

    if val_8.Visible then
        v60 += 1
    end
end

local _ = v61 - v60
Pages.discoverableTraits.Text = `{v60} of {v61} traits discovered...`
script:GetAttributeChangedSignal("Viewing"):Connect(viewingChanged)
script:GetAttributeChangedSignal("ItemVal"):Connect(skillChanged)
script:SetAttribute("Viewing", "")
local SearchBox = Window.SearchBox

function UpdateInputOfSearchText() -- line: 388
    -- upvalues:
    --  [1] SearchBox (copy)

    script:SetAttribute("Viewing", (string.upper(SearchBox.Text)))
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(UpdateInputOfSearchText)
RightPage.Options.Action.MouseButton1Up:Connect(function() -- line: 395
    -- upvalues:
    --  [1] ReplicatedStorage (copy)
    --  [2] Services_m (copy)

    local ItemVal_1 = script:GetAttribute("ItemVal")

    if not ItemVal_1 then
        return
    end

    if ReplicatedStorage.Remotes.Player.SkillEvent:InvokeServer("UnlockTrainer", ItemVal_1) then
        return
    end

    Services_m.PlaySound(ReplicatedStorage.SFX.Misc.Error, script)
end)
Skills_1.ChildAdded:Connect(function(child_1) -- line: 407
    -- upvalues:
    --  [1] Header (copy)
    --  [2] UnHighlight (copy)

    if string.upper(Header.Text) == string.upper(child_1.Name) then
        UnHighlight()
    end
end)

while true do
    local _, Result = pcall(function() -- line: 414
        -- upvalues:
        --  [1] t (copy)
        --  [2] Skills_1 (copy)
        --  [3] CheckRequirements (copy)
        --  [4] TRAIT_DISCOVERED (copy)

        for _, val_9 in t do
            local Name = val_9.Name

            if Skills_1:FindFirstChild(Name) then
                val_9:SetAttribute("Unlocked", true)
                val_9:SetAttribute("Discovered", true)
            else
                if val_9:GetAttribute("Unlocked") then
                    val_9:SetAttribute("Unlocked", false)
                end

                if CheckRequirements(Name) then
                    TRAIT_DISCOVERED(Name)
                else
                    val_9:SetAttribute("Discovered", false)
                end
            end
        end
    end)

    if Result then
        warn(Result)
    end

    task.wait(0.5)
end
