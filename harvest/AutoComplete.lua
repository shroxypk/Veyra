-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.CmdrInterface.AutoComplete
-- Class: ModuleScript
-- bytes: 7507

local LocalPlayer = game:GetService("Players").LocalPlayer

return function(arg1) -- line: 5
    -- upvalues:
    --  [1] LocalPlayer (copy)

    local t = { Items = {}, ItemOptions = {}, SelectedItem = 0 }
    local Util = arg1.Util
    local Autocomplete = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Cmdr"):WaitForChild(
        "Autocomplete"
    )
    local TextButton = Autocomplete:WaitForChild("TextButton")
    local Title = Autocomplete:WaitForChild("Title")
    local Description = Autocomplete:WaitForChild("Description")
    local Entry = Autocomplete.Parent:WaitForChild("Frame"):WaitForChild("Entry")
    TextButton.Parent = nil

    local function SetText(arg2, arg3, arg4, arg5) -- line: 24
        -- upvalues:
        --  [1] Util (copy)

        arg2.Visible = arg4 ~= nil
        arg3.Text = arg4 or ""

        if arg5 then
            arg3.Size = UDim2.new(
                0,
                Util.GetTextSize(
                    arg4 or "",
                    arg3,
                    Vector2.new(1000, 1000),
                    1,
                    0
                ).X,
                arg2.Size.Y.Scale,
                arg2.Size.Y.Offset
            )
        end
    end

    local function UpdateContainerSize() -- line: 38
        -- upvalues:
        --  [1] Autocomplete (copy)
        --  [2] Title (copy)

        Autocomplete.Size = UDim2.new(
            0,
            math.max(
                Title.Field.TextBounds.X + Title.Field.Type.TextBounds.X,
                Autocomplete.Size.X.Offset
            ),
            0,
            (math.min(
                Autocomplete.UIListLayout.AbsoluteContentSize.Y,
                Autocomplete.Parent.AbsoluteSize.Y - Autocomplete.AbsolutePosition.Y - 10
            ))
        )
    end

    local ScrollBarThickness = Autocomplete.ScrollBarThickness

    local function UpdateInfoDisplay(arg6) -- line: 48
        -- upvalues:
        --  [1] SetText (copy)
        --  [2] Title (copy)
        --  [3] Description (copy)
        --  [4] Autocomplete (copy)
        --  [5] UpdateContainerSize (copy)
        --  [6] ScrollBarThickness (copy)

        SetText(Title, Title.Field, arg6.name, true)
        local v4 = arg6.type
        local Type = Title.Field.Type
        local Type_1 = Title.Field.Type

        if v4 then
            v4 = ": " .. arg6.type:sub(1, 1):upper() .. arg6.type:sub(2)
        end

        Type.Visible = v4 ~= nil
        Type_1.Text = v4 or ""
        v4 = arg6.description
        local v6 = v4 ~= nil
        local Label = Description.Label
        Description.Visible = v6
        Label.Text = v4 or ""
        Description.Label.TextColor3 = arg6.invalid and Color3.fromRGB(255, 73, 73) or Color3.fromRGB(
            255,
            255,
            255
        )
        Description.Size = UDim2.new(1, 0, 0, 40)

        repeat
            if Description.Label.TextFits then
                break
            end

            Description.Size = Description.Size + UDim2.new(0, 0, 0, 2)
        until Description.Size.Y.Offset > 500

        task.wait()
        Autocomplete.UIListLayout:ApplyLayout()
        UpdateContainerSize()
        Autocomplete.ScrollBarThickness = ScrollBarThickness
    end

    function t.Show(arg7, arg8, arg9) -- line: 88
        -- upvalues:
        --  [1] Autocomplete (copy)
        --  [2] TextButton (copy)
        --  [3] Entry (copy)
        --  [4] Util (copy)
        --  [5] UpdateInfoDisplay (copy)

        arg9 = arg9 or {}

        for _, val in pairs(arg7.Items) do
            if val.gui then
                val.gui:Destroy()
            end
        end

        arg7.SelectedItem = 1
        arg7.Items = arg8
        arg7.Prefix = arg9.prefix or ""
        arg7.LastItem = arg9.isLast or false
        arg7.Command = arg9.command
        arg7.Arg = arg9.arg
        arg7.NumArgs = arg9.numArgs
        arg7.IsPartial = arg9.isPartial
        local v11 = 200
        Autocomplete.ScrollBarThickness = 0

        for key_1, val_1 in pairs(arg7.Items) do
            local v12 = val_1[1]
            local v13 = val_1[2]
            local v14 = TextButton:Clone()
            v14.Name = v12 .. v13
            v14.BackgroundTransparency = if key_1 == arg7.SelectedItem then 0.5 else 1
            local string_find = string.find
            local v16 = v13:lower()
            local v15
            v15, v16 = string_find(v16, v12:lower(), 1, true)
            v14.Typed.Text = string.rep(" ", v15 - 1) .. v12
            v14.Suggest.Text = string.sub(v13, 0, v15 - 1) .. string.rep(" ", #v12) .. string.sub(
                v13,
                v16 + 1
            )
            v14.Parent = Autocomplete
            v14.LayoutOrder = key_1
            local v19 = math.max(v14.Typed.TextBounds.X, v14.Suggest.TextBounds.X) + 20

            if v11 < v19 then
                v11 = v19
            end

            val_1.gui = v14
        end

        Autocomplete.UIListLayout:ApplyLayout()
        local Text = Entry.TextBox.Text
        local v20 = Util.SplitString(Text)

        if Text:sub(#Text, #Text) == " " and not arg9.at then
            v20[#v20 + 1] = "e"
        end

        table.remove(v20, #v20)
        local v23 = arg9.at and arg9.at or #table.concat(v20, " ") + 1
        Autocomplete.Position = UDim2.new(
            0,
            Entry.TextBox.AbsolutePosition.X - 10 + v23 * 7,
            0,
            Entry.TextBox.AbsolutePosition.Y + 30
        )
        Autocomplete.Size = UDim2.new(0, v11, 0, Autocomplete.UIListLayout.AbsoluteContentSize.Y)
        Autocomplete.Visible = true
        UpdateInfoDisplay(arg7.Items[1] and arg7.Items[1].options or arg9)
    end

    function t.GetSelectedItem(_) -- line: 161
        -- upvalues:
        --  [1] Autocomplete (copy)
        --  [2] t (copy)

        if Autocomplete.Visible == false then
            return nil
        end

        return t.Items[t.SelectedItem]
    end

    function t.Hide(_) -- line: 170
        -- upvalues:
        --  [1] Autocomplete (copy)

        Autocomplete.Visible = false
    end

    function t.IsVisible(_) -- line: 175
        -- upvalues:
        --  [1] Autocomplete (copy)

        return Autocomplete.Visible
    end

    function t.Select(arg13, arg14) -- line: 180
        -- upvalues:
        --  [1] Autocomplete (copy)
        --  [2] Title (copy)
        --  [3] Description (copy)
        --  [4] TextButton (copy)
        --  [5] UpdateInfoDisplay (copy)

        if not Autocomplete.Visible then
            return
        end

        arg13.SelectedItem += arg14

        if arg13.SelectedItem > #arg13.Items then
            arg13.SelectedItem = 1
        elseif arg13.SelectedItem < 1 then
            arg13.SelectedItem = #arg13.Items
        end

        for key_2, val_2 in pairs(arg13.Items) do
            val_2.gui.BackgroundTransparency = if key_2 ~= arg13.SelectedItem then 1 else 0.5
        end

        Autocomplete.CanvasPosition = Vector2.new(
            0,
            (math.max(
                0,
                Title.Size.Y.Offset + Description.Size.Y.Offset + arg13.SelectedItem * TextButton.Size.Y.Offset - Autocomplete.Size.Y.Offset
            ))
        )

        if arg13.Items[arg13.SelectedItem] and arg13.Items[arg13.SelectedItem].options then
            UpdateInfoDisplay(arg13.Items[arg13.SelectedItem].options or {})
        end
    end

    Autocomplete.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateContainerSize)

    return t
end
