-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.UI.InventoryFilterSort
-- Class: ModuleScript
-- bytes: 16075

local UserInputService = game:GetService("UserInputService")
local t = {}
t.__index = t
local color = Color3.fromRGB(235, 235, 240)
local color_1 = Color3.fromRGB(58, 58, 76)
local color_2 = Color3.fromRGB(40, 40, 62)
local color_3 = Color3.fromRGB(230, 230, 235)
local color_4 = Color3.fromRGB(165, 165, 180)
local color_5 = Color3.fromRGB(12, 12, 18)
local color_6 = Color3.fromRGB(105, 105, 128)
local color_7 = Color3.new(1, 1, 1)

local _ = function(arg1) --[[ isPress ]] -- line: 17
    return arg1.UserInputType == Enum.UserInputType.MouseButton1 or arg1.UserInputType == Enum.UserInputType.Touch
end

local function newSignal() -- line: 21
    local BindableEvent = Instance.new("BindableEvent")
    local t_1 = { Connect = nil, Fire = nil }

    function t_1.Connect(_, arg3) -- line: 24
        -- upvalues:
        --  [1] BindableEvent (copy)

        return BindableEvent.Event:Connect(arg3)
    end

    function t_1.Fire(_, ...) -- line: 27
        -- upvalues:
        --  [1] BindableEvent (copy)

        BindableEvent:Fire(...)
    end

    return t_1
end

local function bindRow(u1: userdata, arg5: any) -- line: 33
    -- upvalues:
    --  [1] color_1 (copy)
    --  [2] color_2 (copy)
    --  [3] color (copy)
    --  [4] color_5 (copy)
    --  [5] color_6 (copy)
    --  [6] color_3 (copy)
    --  [7] color_4 (copy)

    local Box = u1.Box
    local Label = u1.Label
    local Stroke = u1:FindFirstChild("Stroke")
    local Stroke_1 = Box:FindFirstChild("Stroke")
    local t_2 = { Row = u1, Checked = false, Implicit = false, Hover = false }

    function t_2.Render() -- line: 41
        -- upvalues:
        --  [1] t_2 (copy)
        --  [2] Stroke (copy)
        --  [3] u1 (copy)
        --  [4] color_1 (ref)
        --  [5] color_2 (ref)
        --  [6] Box (copy)
        --  [7] color (ref)
        --  [8] color_5 (ref)
        --  [9] Stroke_1 (copy)
        --  [10] color_6 (ref)
        --  [11] Label (copy)
        --  [12] color_3 (ref)
        --  [13] color_4 (ref)

        local Checked = t_2.Checked

        if Stroke then
            Stroke.Enabled = Checked
        end

        if Checked then
            u1.BackgroundColor3 = color_1
            u1.BackgroundTransparency = 0.1
        elseif t_2.Hover then
            u1.BackgroundColor3 = color_2
            u1.BackgroundTransparency = 0.4
        else
            u1.BackgroundTransparency = 1
        end

        local v2 = Checked and color or color_5
        Box.BackgroundColor3 = v2

        if Stroke_1 then
            v2 = Checked and color or color_6
            Stroke_1.Color = v2
        end

        Box.Check.Visible = Checked
        v2 = if Checked then color_3 or color_4 else if t_2.Implicit then color_3 or color_4 else t_2.Hover and color_3 or color_4
        Label.TextColor3 = v2
    end

    u1.MouseEnter:Connect(function() -- line: 65
        -- upvalues:
        --  [1] t_2 (copy)

        t_2.Hover = true
        t_2.Render()
    end)
    u1.MouseLeave:Connect(function() -- line: 69
        -- upvalues:
        --  [1] t_2 (copy)

        t_2.Hover = false
        t_2.Render()
    end)
    u1.Activated:Connect(arg5)
    t_2.Render()

    return t_2
end

local function bindHover(u2: userdata) -- line: 79
    -- upvalues:
    --  [1] color_2 (copy)

    local BackgroundColor3 = u2.BackgroundColor3
    u2.MouseEnter:Connect(function() -- line: 81
        -- upvalues:
        --  [1] u2 (copy)
        --  [2] color_2 (ref)

        u2.BackgroundColor3 = color_2
    end)
    u2.MouseLeave:Connect(function() -- line: 84
        -- upvalues:
        --  [1] u2 (copy)
        --  [2] BackgroundColor3 (copy)

        u2.BackgroundColor3 = BackgroundColor3
    end)
end

local function find(u3: userdata, s1: string) -- line: 89
    local v3 = u3:FindFirstChild(s1, true)

    while not v3 do
        u3.DescendantAdded:Wait()
        v3 = u3:FindFirstChild(s1, true)
    end

    return v3
end

function t.new(u4: userdata) -- line: 98
    -- upvalues:
    --  [1] t (copy)
    --  [2] newSignal (copy)
    --  [3] find (copy)
    --  [4] color_7 (copy)

    local t_3 = setmetatable({}, t)
    t_3.Frame = u4
    t_3.Changed = newSignal()
    t_3.FilterButton = find(u4, "FilterButton")
    t_3.SortButton = find(u4, "SortButton")
    t_3.FilterPanel = find(u4, "FilterPanel")
    t_3.SortPanel = find(u4, "SortPanel")
    t_3._buttonParts = {}

    for _, val in { t_3.FilterButton, t_3.SortButton } do
        local Outline = val:FindFirstChild("Outline")
        local t_4 = { Outline = Outline, OutlineColor = nil, Chevron = nil }
        local v4 = Outline.ImageColor3
        local ButtonParts = t_3._buttonParts

        if not Outline or not v4 then
            v4 = color_7
        end

        t_4.OutlineColor = v4
        t_4.Chevron = val:FindFirstChild("Chevron", true)
        ButtonParts[val] = t_4
    end

    t_3._filterList = t_3.FilterPanel.List
    t_3._rowTemplate = t_3.FilterPanel.RowTemplate
    t_3._rowTemplate.Visible = false
    t_3._categories = {}
    t_3._selected = {}
    t_3._filterRows = {}
    t_3._sortRows = {}
    t_3._openPanel = nil
    t_3._clickInside = false
    t_3.FilterPanel.Visible = false
    t_3.SortPanel.Visible = false
    t_3:_bindButtons()
    t_3:_bindFilterPanel()
    t_3:_bindSortPanel()
    t_3:_bindClose()
    t_3:_refreshFilterRows()
    t_3:_refreshSortRows()

    return t_3
end

function t._markInside(t1: table, u5: userdata) -- line: 144
    local function hook(arg6) -- line: 145
        -- upvalues:
        --  [1] t1 (copy)

        if arg6:IsA("GuiObject") then
            arg6.InputBegan:Connect(function(input) -- line: 147
                -- upvalues:
                --  [1] t1 (ref)

                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    t1._clickInside = true
                end
            end)
        end
    end

    if u5:IsA("GuiObject") then
        u5.InputBegan:Connect(function(input_1) -- line: 147
            -- upvalues:
            --  [1] t1 (copy)

            if input_1.UserInputType == Enum.UserInputType.MouseButton1 or input_1.UserInputType == Enum.UserInputType.Touch then
                t1._clickInside = true
            end
        end)
    end

    for _, descendant in u5:GetDescendants() do
        if descendant:IsA("GuiObject") then
            descendant.InputBegan:Connect(function(input_2) -- line: 147
                -- upvalues:
                --  [1] t1 (copy)

                if input_2.UserInputType == Enum.UserInputType.MouseButton1 or input_2.UserInputType == Enum.UserInputType.Touch then
                    t1._clickInside = true
                end
            end)
        end
    end

    u5.DescendantAdded:Connect(hook)
end

function t._bindButtons(arg10) -- line: 161
    -- upvalues:
    --  [1] bindHover (copy)

    for _, val_1 in { arg10.FilterButton, arg10.SortButton } do
        bindHover(val_1)
        arg10:_markInside(val_1)
    end

    arg10.FilterButton.Activated:Connect(function() -- line: 167
        -- upvalues:
        --  [1] arg10 (copy)

        arg10:_toggle("Filter")
    end)
    arg10.SortButton.Activated:Connect(function() -- line: 170
        -- upvalues:
        --  [1] arg10 (copy)

        arg10:_toggle("Sort")
    end)
end

function t._fitPanel(_, arg12, arg13) -- line: 175
    local UIListLayout = arg13:FindFirstChildWhichIsA("UIListLayout")
    local v8 = UIListLayout and UIListLayout.Padding.Offset or 4
    local v9 = 0
    local v10 = 22

    for _, child in arg13:GetChildren() do
        if child:IsA("GuiButton") then
            v9 += 1
            v10 = child.Size.Y.Offset
        end
    end

    local Offset = arg13.Position.Y.Offset
    local v11 = Offset + (-arg13.Size.Y.Offset - Offset)
    local v12 = math.min(v9, 10)
    arg12.Size = UDim2.new(
        arg12.Size.X.Scale,
        arg12.Size.X.Offset,
        0,
        v11 + (v12 * v10 + math.max(v12 - 1, 0) * v8 + 2)
    )
end

function t._bindFilterPanel(arg14) -- line: 196
    -- upvalues:
    --  [1] bindRow (copy)
    --  [2] color_3 (copy)
    --  [3] color_4 (copy)

    local FilterPanel = arg14.FilterPanel
    arg14:_markInside(FilterPanel)
    arg14._allRow = bindRow(arg14._filterList.All, function() -- line: 200
        -- upvalues:
        --  [1] arg14 (copy)

        arg14:SetFilter(nil)
    end)
    local Clear = FilterPanel:FindFirstChild("Clear")

    if Clear then
        Clear.MouseEnter:Connect(function() -- line: 206
            -- upvalues:
            --  [1] Clear (copy)
            --  [2] color_3 (ref)

            Clear.TextColor3 = color_3
        end)
        Clear.MouseLeave:Connect(function() -- line: 209
            -- upvalues:
            --  [1] Clear (copy)
            --  [2] color_4 (ref)

            Clear.TextColor3 = color_4
        end)
        Clear.Activated:Connect(function() -- line: 212
            -- upvalues:
            --  [1] arg14 (copy)

            arg14:SetFilter(nil)
        end)
    end

    arg14:_fitPanel(FilterPanel, arg14._filterList)
end

function t._bindSortPanel(arg15) -- line: 220
    -- upvalues:
    --  [1] bindRow (copy)

    local SortPanel = arg15.SortPanel
    arg15:_markInside(SortPanel)
    local t_5 = {}

    for _, child_1 in SortPanel.List:GetChildren() do
        if child_1:IsA("GuiButton") then
            table.insert(t_5, child_1)
        end
    end

    table.sort(t_5, function(arg16, arg17) -- line: 230
        return arg16.LayoutOrder < arg17.LayoutOrder
    end)
    arg15.SortModes = {}

    for _, val_2 in t_5 do
        local Name = val_2.Name
        table.insert(arg15.SortModes, Name)
        arg15._sortRows[Name] = bindRow(val_2, function() -- line: 238
            -- upvalues:
            --  [1] arg15 (copy)
            --  [2] Name (copy)

            arg15:SetSortMode(Name)
        end)
    end

    arg15._defaultSort = arg15.SortModes[1]
    arg15.SortMode = arg15._defaultSort
    arg15:_fitPanel(SortPanel, SortPanel.List)
end

function t._renderButtons(arg18) -- line: 249
    -- upvalues:
    --  [1] color (copy)

    local v16 = next(arg18._selected) ~= nil
    local v17 = arg18.SortMode ~= arg18._defaultSort

    local _ = function(arg19, arg20, arg21) --[[ style ]] -- line: 253
        -- upvalues:
        --  [1] arg18 (copy)
        --  [2] color (ref)

        local v18 = arg18._buttonParts[arg19]

        if v18.Outline then
            local v19 = if arg20 then color or v18.OutlineColor else arg21 and color or v18.OutlineColor
            v18.Outline.ImageColor3 = v19
        end

        if v18.Chevron then
            v18.Chevron.Rotation = if not arg20 then 0 else 180
        end
    end

    local v20 = arg18._openPanel == "Filter"
    local v21 = arg18._buttonParts[arg18.FilterButton]

    if v21.Outline then
        local v22 = if v20 then color or v21.OutlineColor else v16 and color or v21.OutlineColor
        v21.Outline.ImageColor3 = v22
    end

    if v21.Chevron then
        v21.Chevron.Rotation = if not v20 then 0 else 180
    end

    v20 = arg18._openPanel == "Sort"
    v16 = arg18._buttonParts[arg18.SortButton]

    if v16.Outline then
        local v23 = if v20 then color or v16.OutlineColor else v17 and color or v16.OutlineColor
        v16.Outline.ImageColor3 = v23
    end

    if v16.Chevron then
        v16.Chevron.Rotation = if not v20 then 0 else 180
    end
end

function t._toggle(arg22, arg23) -- line: 267
    if arg22._openPanel == arg23 then
        arg22:Close()

        return
    end

    arg22:Open(arg23)
end

function t._placePanel(arg24, arg25, arg26) -- line: 275
    local Frame = arg24.Frame
    local v24 = arg26.AbsolutePosition.X - Frame.AbsolutePosition.X
    local v25 = arg26.AbsolutePosition.Y + arg26.AbsoluteSize.Y - Frame.AbsolutePosition.Y + 4
    local Offset_1 = arg25.Size.X.Offset
    v24 = if not (v24 + Offset_1 > Frame.AbsoluteSize.X) then v24 else v24 + arg26.AbsoluteSize.X - Offset_1
    arg25.AnchorPoint = Vector2.new(0, 0)
    arg25.Position = UDim2.fromOffset(v24, v25 + 3)
end

function t.Open(arg27, arg28) -- line: 292
    if arg28 == "Filter" then
        arg27:_placePanel(arg27.FilterPanel, arg27.FilterButton)
    elseif arg28 == "Sort" then
        arg27:_placePanel(arg27.SortPanel, arg27.SortButton)
    end

    arg27._openPanel = arg28
    arg27.FilterPanel.Visible = arg28 == "Filter"
    arg27.SortPanel.Visible = arg28 == "Sort"
    arg27:_renderButtons()
end

function t.Close(arg29) -- line: 305
    if not arg29._openPanel then
        return
    end

    arg29._openPanel = nil
    arg29.FilterPanel.Visible = false
    arg29.SortPanel.Visible = false
    arg29:_renderButtons()
end

function t._bindClose(arg30) -- line: 315
    -- upvalues:
    --  [1] UserInputService (copy)

    UserInputService.InputBegan:Connect(function(input_3) -- line: 316
        -- upvalues:
        --  [1] arg30 (copy)

        if not (input_3.UserInputType == Enum.UserInputType.MouseButton1 or input_3.UserInputType == Enum.UserInputType.Touch) then
            return
        end

        task.spawn(function() -- line: 321
            -- upvalues:
            --  [1] arg30 (ref)

            task.wait()

            if arg30._openPanel and not arg30._clickInside then
                arg30:Close()
            end

            arg30._clickInside = false
        end)
    end)

    for _, val_3 in { arg30.Frame, arg30.Frame.Parent } do
        if val_3 and val_3:IsA("GuiObject") then
            val_3:GetPropertyChangedSignal("Visible"):Connect(function() -- line: 332
                -- upvalues:
                --  [1] val_3 (copy)
                --  [2] arg30 (copy)

                if not val_3.Visible then
                    arg30:Close()
                end
            end)
        end
    end
end

function t._refreshFilterRows(arg32) -- line: 341
    local v28 = next(arg32._selected) == nil
    arg32._allRow.Checked = v28
    arg32._allRow.Render()

    for key_7, val_4 in arg32._filterRows do
        val_4.Checked = arg32._selected[key_7] == true
        val_4.Implicit = v28
        val_4.Render()
    end

    arg32:_renderButtons()
end

function t._refreshSortRows(arg33) -- line: 356
    for key_8, val_5 in arg33._sortRows do
        val_5.Checked = key_8 == arg33.SortMode
        val_5.Render()
    end

    arg33:_renderButtons()
end

function t.AddCategory(t2: table, s2: string, n1: number) -- line: 364
    -- upvalues:
    --  [1] bindRow (copy)

    if t2._categories[s2] then
        return
    end

    t2._categories[s2] = n1
    local v31 = t2._rowTemplate:Clone()
    v31.Name = s2
    v31.LayoutOrder = n1
    v31.Label.Text = s2
    v31.Visible = true
    v31.Parent = t2._filterList
    t2._filterRows[s2] = bindRow(v31, function() -- line: 377
        -- upvalues:
        --  [1] t2 (copy)
        --  [2] s2 (copy)

        t2:ToggleCategory(s2)
    end)
    t2:_fitPanel(t2.FilterPanel, t2._filterList)
    t2:_refreshFilterRows()
end

function t.ToggleCategory(t3: table, s3: string) -- line: 385
    if t3._selected[s3] then
        t3._selected[s3] = nil
    else
        t3._selected[s3] = true
    end

    local v32 = true

    for key_9 in t3._categories do
        if not t3._selected[key_9] then
            v32 = false
            break
        end
    end

    if v32 then
        table.clear(t3._selected)
    end

    t3:_refreshFilterRows()
    t3.Changed:Fire("Filter")
end

function t.SetFilter(t4: table, t5: table?) -- line: 407
    table.clear(t4._selected)
    local v33 = t5 or {}

    for _, val_6 in v33 do
        t4._selected[val_6] = true
    end

    t4:_refreshFilterRows()
    t4.Changed:Fire("Filter")
end

function t.IsCategoryShown(t6: table, s4: string) -- line: 416
    return next(t6._selected) == nil or t6._selected[s4] == true
end

function t.SetSortMode(t7: table, s5: string) -- line: 420
    if t7.SortMode == s5 or not t7._sortRows[s5] then
        return
    end

    t7.SortMode = s5
    t7:_refreshSortRows()
    t7.Changed:Fire("Sort")
end

return t
