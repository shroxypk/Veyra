-- Decompiled with Veyra harvester
-- Instance: StarterGui.Permanent.Window.Settings.Pages.Titles.TitleClient
-- Class: LocalScript
-- bytes: 4114

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage.Modules
local Titles_m = require(Modules.Titles)
local TitleStyle_m = require(Modules.Titles.TitleStyle)
local BackpackUtils_m = require(Modules.BackpackUtils)
local v2, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local PlayerTitles = v2:WaitForChild("PlayerTitles")
local Parent = script.Parent
local Bar = Parent.Bar

local _ = function(arg1) --[[ getDictCount ]] -- line: 19
    if typeof(arg1) ~= "table" then
        return 1
    end

    local v4 = 0

    for _, _ in pairs(arg1) do
        v4 += 1
    end

    return v4
end

local function updateTitle(arg2) -- line: 32
    -- upvalues:
    --  [1] PlayerTitles (copy)
    --  [2] Parent (copy)

    local v5 = PlayerTitles.Title.Value
    local v6 = if v5 ~= "" then v5 else "@None"

    for _, child in Parent.List:GetChildren() do
        if child:IsA("Frame") then
            local _ = child:GetAttribute("Unlocked")
            child.Selected.Visible = if child.Name ~= v6 then false else true
        end
    end

    if not arg2 then
        if v5 == "" then
            v5 = "None"
        end

        _G.CreateAlert(`Your title was changed: {v5}.`)
    end
end

local v8 = 0
local v9

if typeof(Titles_m) ~= "table" then
    v9 = 1
else
    local v10 = 0

    for _, _ in pairs(Titles_m) do
        v10 += 1
    end

    v9 = v10
end

local _ = function() --[[ updateCount ]] -- line: 54
    -- upvalues:
    --  [1] v8 (ref)
    --  [2] Bar (copy)
    --  [3] v9 (copy)

    v8 += 1
    Bar.Header.Text = `{v8}/{v9} titles unlocked`
    Bar.Front.Size = UDim2.fromScale(v8 / v9, 1)
end

for _, child_1 in PlayerTitles:GetChildren() do
    if child_1:IsA("BoolValue") then
        local Name = child_1.Name
        local v12 = Titles_m[Name]

        if v12 then
            local v13 = script.TitleTemplate:Clone()
            v13.Name = Name
            v13.Header.Text = Name

            local function handleTitle() -- line: 76
                -- upvalues:
                --  [1] child_1 (copy)
                --  [2] v13 (copy)
                --  [3] Name (copy)
                --  [4] ReplicatedStorage (copy)
                --  [5] v8 (ref)
                --  [6] Bar (copy)
                --  [7] v9 (copy)

                if not child_1.Value then
                    v13.Header.Text = `<s>{Name}</s>`

                    return
                end

                v13:SetAttribute("Unlocked", true)
                v13.Locked.Visible = false
                v13.Header.Text = Name
                v13.Button.Activated:Connect(function() -- line: 87
                    -- upvalues:
                    --  [1] ReplicatedStorage (ref)
                    --  [2] Name (ref)

                    ReplicatedStorage.Remotes.SetTitle:FireServer(Name)
                end)
                v8 += 1
                Bar.Header.Text = `{v8}/{v9} titles unlocked`
                Bar.Front.Size = UDim2.fromScale(v8 / v9, 1)
            end

            TitleStyle_m.Apply(v13.Header, Name)
            v13.MouseEnter:Connect(function() -- line: 97
                -- upvalues:
                --  [1] BackpackUtils_m (copy)
                --  [2] Name (copy)
                --  [3] v12 (copy)

                BackpackUtils_m:ShowHover({ key = Name, text = v12.Desc })
            end)
            v13.MouseLeave:Connect(function() -- line: 103
                -- upvalues:
                --  [1] BackpackUtils_m (copy)

                BackpackUtils_m:HideHover()
            end)
            child_1:GetPropertyChangedSignal("Value"):Connect(handleTitle)
            handleTitle()
            v13.Parent = Parent.List
        end
    end
end

Parent.List["@None"].Button.Activated:Connect(function() -- line: 113
    -- upvalues:
    --  [1] ReplicatedStorage (copy)

    ReplicatedStorage.Remotes.SetTitle:FireServer("None")
end)
PlayerTitles.Title:GetPropertyChangedSignal("Value"):Connect(updateTitle)
updateTitle(true)
