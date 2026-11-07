-- Decompiled with Veyra harvester
-- Instance: StarterGui.Gameplay.Main.Menu.Pages.Skills.Progression
-- Class: LocalScript
-- bytes: 15306

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local Modules = ReplicatedStorage.Modules
local BackpackUtils_m = require(Modules.BackpackUtils)
local StatManager_m = require(Modules.StatManager)
local TraitRequirements_m = require(Modules.TraitRequirements)
local v2, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local v4 = StatManager_m.require(v2)
local _ = v2:WaitForChild("PlayerGui"):WaitForChild("Gameplay")
local v5 = Services_m.Maid.new()
local Skills = v2.Skills
local Skills_m = require(Modules.Skills)
local Skillsets = Skills_m.Skillsets
local Skills_1 = Skills_m.Skills
local Parent = script.Parent
local List = Parent.List
local Scrolling = List.Scrolling
local ConfirmFrame = Parent.ConfirmFrame
local t = {}
local t_1 = {}
local t_2 = {}

local function CreateContents(arg1) -- line: 42
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] t_2 (copy)
    --  [3] t (copy)
    --  [4] Scrolling (copy)

    arg1 = t_1[arg1] or arg1

    if not t_2[arg1] then
        local v6 = script.TemplateContents:Clone()
        v6.Name = arg1
        local v7 = script.Header:Clone()
        v7.Label.Text = arg1
        v7.Parent = v6
        local Items = v6.Items
        Items.ChildRemoved:Connect(function(child) -- line: 55
            -- upvalues:
            --  [1] t (ref)
            --  [2] Items (copy)
            --  [3] v6 (copy)
            --  [4] t_2 (ref)
            --  [5] arg1 (ref)

            t[child.Name] = nil

            if #Items:GetChildren() <= 2 then
                v6:Destroy()
                t_2[arg1] = nil
            end
        end)
        v6.Parent = Scrolling
        t_2[arg1] = v6
    end

    return t_2[arg1]
end

local function UnHighlight() -- line: 72
    -- upvalues:
    --  [1] v5 (copy)
    --  [2] ConfirmFrame (copy)
    --  [3] BackpackUtils_m (copy)
    --  [4] List (copy)

    v5:Destroy()
    ConfirmFrame.Visible = false
    BackpackUtils_m:HideHover()

    for _, val in List:QueryDescendants("[$Highlighted]") do
        val:SetAttribute("Highlighted", false)
    end
end

local _ = function(arg3) --[[ getContainer ]] -- line: 83
    -- upvalues:
    --  [1] Skills (copy)

    return Skills:FindFirstChild(arg3)
end

local function createSlot(arg4: any, b1: boolean) -- line: 87
    -- upvalues:
    --  [1] Skills_1 (copy)
    --  [2] t (copy)
    --  [3] CreateContents (copy)
    --  [4] BackpackUtils_m (copy)
    --  [5] Skills (copy)
    --  [6] ConfirmFrame (copy)
    --  [7] v4 (copy)
    --  [8] UnHighlight (copy)
    --  [9] v5 (copy)
    --  [10] ReplicatedStorage (copy)
    --  [11] TraitRequirements_m (copy)

    local v8 = Skills_1[arg4]

    if not v8 or v8.Type == "Body" or t[arg4] then
        return
    end

    local Requirement = v8.Requirement
    local ReqType = v8.ReqType
    local Skillset = v8.Skillset
    local Description = v8.Description
    local v9 = v8.Type or ""
    local v10 = CreateContents(Skillset)
    local color = Color3.fromRGB(255, 255, 255)
    local v12 = BackpackUtils_m.SkillColors[string.gsub(Skillset, " Passive", "")]

    if v12 then
        local v13, v14, v15 = v12.BackgroundColor:ToHSV()
        color = Color3.fromHSV(v13, math.min(v14 + 0.1, 1), (math.min(v15 + 0.4, 1)))
    end

    local v17 = nil
    local v18 = script.SubTemplate:Clone()
    local Lock = v18.Lock
    local Display = v18.Display

    local function setupTemplate() -- line: 116
        -- upvalues:
        --  [1] v18 (copy)
        --  [2] v9 (copy)
        --  [3] arg4 (copy)
        --  [4] Display (copy)
        --  [5] v8 (copy)
        --  [6] color (ref)
        --  [7] Lock (copy)
        --  [8] Skills (ref)
        --  [9] ReqType (copy)
        --  [10] b1 (copy)

        local v19 = v18
        local v20 = v9[1]

        if typeof(v9) ~= "table" or not v20 then
            v20 = v9
        end

        v19:SetAttribute("FilterType", v20)
        v18.Name = arg4
        Display.Icon.Image = v8.Image or ""
        Display.Icon.ImageColor3 = color
        local v21 = false
        local Icon = Display.Icon

        if Display.Icon.Image ~= "" then
            v21 = Display.Icon.Image ~= "rbxassetid://"
        end

        Icon.Visible = v21
        Display.Label.Text = arg4
        Display.Label.TextColor3 = color
        local v22 = Lock
        local v23 = Skills:FindFirstChild(arg4) or ReqType == "SkillPoints"
        v22.Visible = not v23
        v18:SetAttribute("Highlighted", false)
        v18:SetAttribute("Magic", b1)
    end

    local LockBackground = v18.LockBackground
    Lock:GetPropertyChangedSignal("Visible"):Connect(function() -- line: 133
        -- upvalues:
        --  [1] LockBackground (copy)
        --  [2] Lock (copy)

        LockBackground.Visible = Lock.Visible
    end)
    setupTemplate()
    v18:GetAttributeChangedSignal("Highlighted"):Connect(function() -- line: 139
        -- upvalues:
        --  [1] v18 (copy)
        --  [2] Display (copy)
        --  [3] arg4 (copy)
        --  [4] ReqType (copy)
        --  [5] Skills (ref)
        --  [6] ConfirmFrame (ref)
        --  [7] Requirement (copy)

        if not v18:GetAttribute("Highlighted") then
            Display.Label.Text = arg4

            return
        end

        Display.Label.Text = `<b> {arg4}</b>`

        if ReqType == "SkillPoints" and not Skills:FindFirstChild(arg4) then
            ConfirmFrame.Skill.Text = arg4
            local Amount = ConfirmFrame.Amount
            Amount.Text = Requirement == 1 and Requirement .. " Skill Point" or Requirement .. " Skill Points"
            ConfirmFrame.Visible = true
        end
    end)

    local _ = function() --[[ cleanup ]] -- line: 154
        -- upvalues:
        --  [1] v18 (copy)
        --  [2] v17 (ref)
        --  [3] t (ref)
        --  [4] arg4 (copy)

        v18:Destroy()

        if v17 then
            v17:Disconnect()
            v17 = nil
        end

        t[arg4] = nil
    end

    local _ = function() --[[ connectAncestry ]] -- line: 165
        -- upvalues:
        --  [1] arg4 (copy)
        --  [2] Skills (ref)
        --  [3] v17 (ref)
        --  [4] Skillset (copy)
        --  [5] v4 (ref)
        --  [6] setupTemplate (copy)
        --  [7] v18 (copy)
        --  [8] t (ref)

        local v25 = Skills:FindFirstChild(arg4)

        if v25 and not v17 then
            v17 = v25.AncestryChanged:Connect(function(_, arg6) -- line: 168
                -- upvalues:
                --  [1] Skillset (ref)
                --  [2] v4 (ref)
                --  [3] setupTemplate (ref)
                --  [4] v18 (ref)
                --  [5] v17 (ref)
                --  [6] t (ref)
                --  [7] arg4 (ref)

                if if Skillset ~= v4:GetStat("Magic") then false else true then
                    setupTemplate()

                    return
                end

                if not arg6 then
                    v18:Destroy()

                    if v17 then
                        v17:Disconnect()
                        v17 = nil
                    end

                    t[arg4] = nil
                end
            end)
        end
    end

    local function buttonPressed() -- line: 181
        -- upvalues:
        --  [1] UnHighlight (ref)
        --  [2] v18 (copy)
        --  [3] arg4 (copy)
        --  [4] Skills (ref)
        --  [5] v5 (ref)
        --  [6] ConfirmFrame (ref)
        --  [7] ReplicatedStorage (ref)
        --  [8] v17 (ref)
        --  [9] Skillset (copy)
        --  [10] v4 (ref)
        --  [11] setupTemplate (copy)
        --  [12] t (ref)

        UnHighlight()
        v18:SetAttribute("Highlighted", true)

        if not Skills:FindFirstChild(arg4) then
            v5:GiveTask(ConfirmFrame.Accept.MouseButton1Up:Connect(function() -- line: 187
                -- upvalues:
                --  [1] Skills (ref)
                --  [2] arg4 (ref)
                --  [3] ReplicatedStorage (ref)
                --  [4] UnHighlight (ref)
                --  [5] v17 (ref)
                --  [6] Skillset (ref)
                --  [7] v4 (ref)
                --  [8] setupTemplate (ref)
                --  [9] v18 (ref)
                --  [10] t (ref)

                if not Skills:FindFirstChild(arg4) then
                    ReplicatedStorage.Remotes.Player.SkillEvent:InvokeServer("Unlock", arg4)
                    UnHighlight()
                    local v28 = Skills:FindFirstChild(arg4)

                    if v28 and not v17 then
                        v17 = v28.AncestryChanged:Connect(function(_, arg8) -- line: 168
                            -- upvalues:
                            --  [1] Skillset (ref)
                            --  [2] v4 (ref)
                            --  [3] setupTemplate (ref)
                            --  [4] v18 (ref)
                            --  [5] v17 (ref)
                            --  [6] t (ref)
                            --  [7] arg4 (ref)

                            if if Skillset ~= v4:GetStat("Magic") then false else true then
                                setupTemplate()

                                return
                            end

                            if not arg8 then
                                v18:Destroy()

                                if v17 then
                                    v17:Disconnect()
                                    v17 = nil
                                end

                                t[arg4] = nil
                            end
                        end)
                    end
                end
            end))

            return
        end

        local v32 = Skills:FindFirstChild(arg4)

        if v32 and not v17 then
            v17 = v32.AncestryChanged:Connect(function(_, arg10) -- line: 168
                -- upvalues:
                --  [1] Skillset (ref)
                --  [2] v4 (ref)
                --  [3] setupTemplate (ref)
                --  [4] v18 (ref)
                --  [5] v17 (ref)
                --  [6] t (ref)
                --  [7] arg4 (ref)

                if if Skillset ~= v4:GetStat("Magic") then false else true then
                    setupTemplate()

                    return
                end

                if not arg10 then
                    v18:Destroy()

                    if v17 then
                        v17:Disconnect()
                        v17 = nil
                    end

                    t[arg4] = nil
                end
            end)
        end
    end

    local v35 = Skills:FindFirstChild(arg4)

    if v35 and not v17 then
        v17 = v35.AncestryChanged:Connect(function(_, arg12) -- line: 168
            -- upvalues:
            --  [1] Skillset (copy)
            --  [2] v4 (ref)
            --  [3] setupTemplate (copy)
            --  [4] v18 (copy)
            --  [5] v17 (ref)
            --  [6] t (ref)
            --  [7] arg4 (copy)

            if if Skillset ~= v4:GetStat("Magic") then false else true then
                setupTemplate()

                return
            end

            if not arg12 then
                v18:Destroy()

                if v17 then
                    v17:Disconnect()
                    v17 = nil
                end

                t[arg4] = nil
            end
        end)
    end

    t[arg4] = v18
    v18.MouseButton1Up:Connect(buttonPressed)
    v18.MouseEnter:Connect(function() -- line: 207
        -- upvalues:
        --  [1] v8 (copy)
        --  [2] ReqType (copy)
        --  [3] Requirement (copy)
        --  [4] TraitRequirements_m (ref)
        --  [5] Skills (ref)
        --  [6] arg4 (copy)
        --  [7] BackpackUtils_m (ref)
        --  [8] color (ref)
        --  [9] Description (copy)

        local v38 = ""
        local v39 = v8.Type == "Trait"

        if ReqType == "SkillPoints" then
            v38 = Requirement == 1 and Requirement .. " Skill Point needed." or Requirement .. " Skill Points needed."
        elseif ReqType == "Gameplay" then
            v38 = "Unlocked in your Inner Realm."
        elseif ReqType == "Trainer" then
            v38 = v8.RequirementText

            if v39 then
                if v38 ~= nil then
                    if v38 == "" then
                        v38 = TraitRequirements_m.text(v8)
                    end
                else
                    v38 = TraitRequirements_m.text(v8)
                end
            end
        elseif ReqType ~= "Prereq" then
            v38 = "Level " .. Requirement .. " Required"
        end

        local v41 = if Skills:FindFirstChild(arg4) == nil then false else true
        v38 = if not v41 then v38 else if v39 then v38 else ""

        if v38 and v38 ~= "" then
            v38 = if v41 then `\n\n<font color='rgb(150, 150, 150)'>Requirements: {v38}</font>` else `\n\n<font color='rgb(148, 119, 70)'><b>{v38}</b></font>`
        end

        BackpackUtils_m:ShowHover({ key = arg4, color = color, text = `{Description}{v38}` })
    end)
    v18.MouseLeave:Connect(function() -- line: 249
        -- upvalues:
        --  [1] BackpackUtils_m (ref)

        BackpackUtils_m:HideHover()
    end)
    v18.Parent = v10.Items
end

local function childAdded(arg13) -- line: 256
    -- upvalues:
    --  [1] Skills_1 (copy)
    --  [2] v4 (copy)
    --  [3] List (copy)
    --  [4] t (copy)
    --  [5] createSlot (copy)

    local Name = arg13.Name
    local v43 = Skills_1[Name]

    if not arg13:IsA("Folder") or not v43 then
        return
    end

    v43 = if v43.Skillset ~= v4:GetStat("Magic") then false else true

    for _, val_1 in List:QueryDescendants(`TextButton[Name="{Name}"]`) do
        if val_1:FindFirstChild("Lock") then
            val_1.Lock.Visible = false
        end
    end

    local v45 = t[Name]

    if v45 and not v43 then
        arg13.AncestryChanged:Connect(function(_, arg15) -- line: 275
            -- upvalues:
            --  [1] v45 (copy)
            --  [2] t (ref)
            --  [3] Name (copy)

            if not arg15 then
                v45:Destroy()
                t[Name] = nil
            end
        end)

        return
    end

    createSlot(Name, v43)
end

ConfirmFrame.Close.MouseButton1Up:Connect(function() -- line: 286
    -- upvalues:
    --  [1] ConfirmFrame (copy)

    ConfirmFrame.Visible = false
end)

for _, child_1 in Skills:GetChildren() do
    createSlot(child_1.Name)
end

Skills.ChildAdded:Connect(childAdded)

local _ = function() --[[ clearMagicSkills ]] -- line: 296
    -- upvalues:
    --  [1] Scrolling (copy)

    for _, val_2 in Scrolling:QueryDescendants("[$Magic]") do
        val_2:Destroy()
    end
end

local function LoadMagicSkills() -- line: 302
    -- upvalues:
    --  [1] Scrolling (copy)
    --  [2] Skillsets (copy)
    --  [3] v4 (copy)
    --  [4] createSlot (copy)

    for _, val_3 in Scrolling:QueryDescendants("[$Magic]") do
        val_3:Destroy()
    end

    local v47 = Skillsets[v4:GetStat("Magic") .. "Info"]

    if not v47 then
        return
    end

    for key_5, _ in v47 do
        createSlot(key_5, true)
    end
end

v4:OnStatChanged("Magic", LoadMagicSkills)
LoadMagicSkills()
