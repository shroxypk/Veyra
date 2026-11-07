-- Decompiled with Veyra harvester
-- Instance: StarterGui.BookUI.BookClass
-- Class: LocalScript
-- bytes: 8610

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("TweenService")
local _ = game:GetService("RunService")
local _ = game:GetService("CollectionService")
local TextService = game:GetService("TextService")
local Modules = ReplicatedStorage.Modules
local Lore_m = require(Modules.Items.Lore)
local _, v3 = require(Modules.scriptObjs).GetPlayerCharacter()
local BookDisplay = script.Parent.BookDisplay
local UIPageLayout = BookDisplay.Pages.UIPageLayout
local Backward = BookDisplay.PageNumber.Backward
BookDisplay.PageNumber.Forward.MouseButton1Up:Connect(function() -- line: 22
    -- upvalues:
    --  [1] UIPageLayout (copy)

    UIPageLayout:Next()
end)
Backward.MouseButton1Up:Connect(function() -- line: 26
    -- upvalues:
    --  [1] UIPageLayout (copy)

    UIPageLayout:Previous()
end)

function ClearPages() -- line: 30
    -- upvalues:
    --  [1] BookDisplay (copy)
    --  [2] UIPageLayout (copy)

    for _, child in BookDisplay.Pages:GetChildren() do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end

    UIPageLayout:JumpToIndex(1)
end

function PageShowing(_) -- line: 39
    -- upvalues:
    --  [1] UIPageLayout (copy)
    --  [2] BookDisplay (copy)

    if UIPageLayout.CurrentPage then
        local v4 = 0
        local v5 = UIPageLayout.CurrentPage.Name:sub(5)

        for _, val in pairs(BookDisplay.Pages:GetChildren()) do
            if val:IsA("TextLabel") then
                v4 += 1
            end
        end

        BookDisplay.PageNumber.Text = v5 .. " / " .. v4
    end
end

UIPageLayout.Changed:Connect(PageShowing)
local PageTemplate = script.PageTemplate

local function tokenize(arg2) -- line: 60
    local t = {}
    local v7 = 1

    while true do
        if not (v7 <= #arg2) then
            break
        end

        local v8 = string.match(arg2, "^</?[bi]>", v7)
        local v9 = not v8 and string.match(arg2, "^%s+", v7)
        local v11 = v8 or (v9 or (not v8 and (not v9 and string.match(arg2, "^[^%s<]+", v7)) or string.sub(
            arg2,
            v7,
            v7
        )))
        table.insert(t, v11)
        v7 += #v11
    end

    return t
end

local function openTags(arg3, arg4, arg5) -- line: 75
    local t_1 = table.clone(arg3)

    for index = 1, arg5 do
        local v12, v13 = string.match(arg4[index], "^<(/?)([bi])>$")

        if v13 then
            t_1[v13] = v12 == "" or nil
        end
    end

    return t_1
end

local _ = function(arg6) --[[ closeTags ]] -- line: 86
    return (if not arg6.i then "" else "</i>") .. (if not arg6.b then "" else "</b>")
end

local _ = function(arg7) --[[ reopenTags ]] -- line: 90
    return (if not arg7.b then "" else "<b>") .. (if not arg7.i then "" else "<i>")
end

local function textLength(arg8, arg9) -- line: 97
    local v19 = 0

    for index_1 = arg9, #arg8 do
        v19 = if string.match(arg8[index_1], "^<") then v19 else if string.match(
            arg8[index_1],
            "^%s+$"
        ) then v19 else v19 + #arg8[index_1]
    end

    return v19
end

local function fitPages(arg10, arg11, arg12) -- line: 107
    -- upvalues:
    --  [1] PageTemplate (copy)
    --  [2] TextService (copy)
    --  [3] tokenize (copy)
    --  [4] openTags (copy)
    --  [5] textLength (copy)

    local GetTextBoundsParams = Instance.new("GetTextBoundsParams")
    GetTextBoundsParams.RichText = true
    GetTextBoundsParams.Font = PageTemplate.FontFace
    GetTextBoundsParams.Size = PageTemplate.TextSize
    GetTextBoundsParams.Width = arg11

    local _ = function(arg13) --[[ fits ]] -- line: 114
        -- upvalues:
        --  [1] GetTextBoundsParams (copy)
        --  [2] TextService (ref)
        --  [3] arg12 (copy)

        GetTextBoundsParams.Text = string.gsub(arg13, "%s+$", "")
        local Success, Result = pcall(
            TextService.GetTextBoundsAsync,
            TextService,
            GetTextBoundsParams
        )

        return not Success or Result.Y <= arg12
    end

    local t_2 = {}
    local v22 = {}
    local v23 = tokenize(arg10)

    while true do
        if not (#v23 > 0) then
            break
        end

        local v26 = (if not v22.b then "" else "<b>") .. (if not v22.i then "" else "<i>")
        GetTextBoundsParams.Text = string.gsub(v26 .. table.concat(v23), "%s+$", "")
        local Success_1, Result_1 = pcall(
            TextService.GetTextBoundsAsync,
            TextService,
            GetTextBoundsParams
        )
        local v27 = not Success_1 or arg12 >= Result_1.Y and true

        if v27 then
            table.insert(t_2, v26 .. table.concat(v23))
            break
        end

        v27 = 1
        local v28 = #v23 - 1

        while v27 < v28 do
            local v29 = math.ceil((v27 + v28) / 2)
            local v30 = table.concat(v23, "", 1, v29)
            local v31 = openTags(v22, v23, v29)
            local v32 = if v31.i then "</i>" else ""
            local v33 = if not v31.b then "" else "</b>"
            GetTextBoundsParams.Text = string.gsub(v26 .. v30 .. v32 .. v33, "%s+$", "")
            local Success_2, Result_2 = pcall(
                TextService.GetTextBoundsAsync,
                TextService,
                GetTextBoundsParams
            )

            if not Success_2 or arg12 >= Result_2.Y and true then
                v27 = v29
                continue
            end

            v28 = v29 - 1
        end

        if textLength(v23, v27 + 1) < 60 then
            for index_2 = v27 - 1, math.ceil(v27 / 2), -1 do
                v28 = string.find(v23[index_2], "\n", 1, true)
                local _ = math.ceil(v27 / 2)

                if not v28 then
                    v28 = string.match(v23[index_2], "[%.!%?]['\"]?$")
                end

                if v28 and textLength(v23, index_2 + 1) >= 60 then
                    v27 = index_2
                    break
                end
            end
        end

        local v36 = openTags(v22, v23, v27)
        local v37 = table.concat(v23, "", 1, v27)
        local v38 = if not v36.i then "" else "</i>"
        local v39 = if not v36.b then "" else "</b>"
        table.insert(t_2, v26 .. v37 .. v38 .. v39)
        local v40 = table.move(
            v23,
            v27 + 1,
            #v23,
            1,
            {}
        )

        while true do
            if not v40[1] then
                break
            end

            if not string.match(v40[1], "^%s+$") then
                break
            end

            table.remove(v40, 1)
        end

        v22 = v36
        v23 = v40
    end

    if #t_2 == 0 then
        table.insert(t_2, arg10)
    end

    return t_2
end

local function pageArea() -- line: 174
    -- upvalues:
    --  [1] BookDisplay (copy)
    --  [2] PageTemplate (copy)

    local Pages = BookDisplay.Pages

    if BookDisplay.Size.X.Offset > 0 and BookDisplay.Size.Y.Offset > 0 then
        return BookDisplay.Size.X.Offset * Pages.Size.X.Scale * PageTemplate.Size.X.Scale, BookDisplay.Size.Y.Offset * Pages.Size.Y.Scale
    end

    return Pages.AbsoluteSize.X * PageTemplate.Size.X.Scale, Pages.AbsoluteSize.Y
end

local v41 = 0
v3.ChildAdded:Connect(function(child_1) -- line: 185
    -- upvalues:
    --  [1] Lore_m (copy)
    --  [2] v41 (ref)
    --  [3] BookDisplay (copy)
    --  [4] pageArea (copy)
    --  [5] fitPages (copy)
    --  [6] v3 (copy)
    --  [7] PageTemplate (copy)

    if child_1:IsA("Tool") and Lore_m[child_1.Name] then
        local Contents = Lore_m[child_1.Name].Contents
        v41 += 1
        local v42 = v41
        ClearPages()
        PageShowing()
        BookDisplay.TopBar.Header.Text = child_1.Name
        local v43, v44 = pageArea()
        local t_3 = {}

        for _, val_1 in ipairs(Contents) do
            for _, val_2 in fitPages(val_1, v43, v44) do
                table.insert(t_3, val_2)
            end
        end

        if v42 ~= v41 or child_1.Parent ~= v3 then
            return
        end

        for key_4, val_3 in t_3 do
            local v45 = PageTemplate:Clone()
            v45.Text = val_3
            v45.Name = "Page" .. key_4
            v45.Parent = BookDisplay.Pages
        end

        PageShowing()
        BookDisplay.Visible = true
    end
end)
v3.ChildRemoved:Connect(function(child_2) -- line: 220
    -- upvalues:
    --  [1] Lore_m (copy)
    --  [2] BookDisplay (copy)

    if child_2:IsA("Tool") and Lore_m[child_2.Name] then
        BookDisplay.Visible = false
    end
end)
