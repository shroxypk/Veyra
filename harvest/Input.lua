-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Input
-- Class: ModuleScript
-- bytes: 75280

local _ = require(script.Parent.Parent.Types)

return function(arg1, arg2) -- line: 3
    local t = {
        Init = function(_) -- line: 5
        end
    }

    function t.Get(arg4) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)

        return arg4.lastNumberChangedTick == arg1._cycleTick
    end

    local function getValueByIndex(arg5: any, n1: number, arg6: any) -- line: 11
        if typeof(arg5) == "number" then
            return arg5
        end

        if typeof(arg5) == "Vector2" then
            if n1 == 1 then
                return arg5.X
            end

            if n1 == 2 then
                return arg5.Y
            end
        elseif typeof(arg5) == "Vector3" then
            if n1 == 1 then
                return arg5.X
            end

            if n1 == 2 then
                return arg5.Y
            end

            if n1 == 3 then
                return arg5.Z
            end
        elseif typeof(arg5) == "UDim" then
            if n1 == 1 then
                return arg5.Scale
            end

            if n1 == 2 then
                return arg5.Offset
            end
        elseif typeof(arg5) == "UDim2" then
            if n1 == 1 then
                return arg5.X.Scale
            end

            if n1 == 2 then
                return arg5.X.Offset
            end

            if n1 == 3 then
                return arg5.Y.Scale
            end

            if n1 == 4 then
                return arg5.Y.Offset
            end
        elseif typeof(arg5) == "Color3" then
            local t_2

            if arg6.UseHSV then
                if not { arg5:ToHSV() } then
                    t_2 = { arg5.R, arg5.G, arg5.B }
                end
            else
                t_2 = { arg5.R, arg5.G, arg5.B }
            end

            if n1 == 1 then
                return t_2[1]
            end

            if n1 == 2 then
                return t_2[2]
            end

            if n1 == 3 then
                return t_2[3]
            end
        elseif typeof(arg5) == "Rect" then
            if n1 == 1 then
                return arg5.Min.X
            end

            if n1 == 2 then
                return arg5.Min.Y
            end

            if n1 == 3 then
                return arg5.Max.X
            end

            if n1 == 4 then
                return arg5.Max.Y
            end
        elseif typeof(arg5) == "table" then
            return arg5[n1]
        end

        local g_error = error
        local v3 = typeof(arg5)
        g_error(`Incorrect datatype or value: {arg5} {v3} {n1}`)
    end

    local function updateValueByIndex(arg7: any, n2: number, n3: number, arg8: any) -- line: 70
        if typeof(arg7) == "number" then
            return n3
        end

        if typeof(arg7) == "Vector2" then
            if n2 == 1 then
                return Vector2.new(n3, arg7.Y)
            end

            if n2 == 2 then
                return Vector2.new(arg7.X, n3)
            end
        elseif typeof(arg7) == "Vector3" then
            if n2 == 1 then
                return (Vector3.new(n3, arg7.Y, arg7.Z))
            end

            if n2 == 2 then
                return (Vector3.new(arg7.X, n3, arg7.Z))
            end

            if n2 == 3 then
                return (Vector3.new(arg7.X, arg7.Y, n3))
            end
        elseif typeof(arg7) == "UDim" then
            if n2 == 1 then
                return UDim.new(n3, arg7.Offset)
            end

            if n2 == 2 then
                return UDim.new(arg7.Scale, n3)
            end
        elseif typeof(arg7) == "UDim2" then
            if n2 == 1 then
                return UDim2.new(UDim.new(n3, arg7.X.Offset), arg7.Y)
            end

            if n2 == 2 then
                return UDim2.new(UDim.new(arg7.X.Scale, n3), arg7.Y)
            end

            if n2 == 3 then
                return UDim2.new(arg7.X, UDim.new(n3, arg7.Y.Offset))
            end

            if n2 == 4 then
                return UDim2.new(arg7.X, UDim.new(arg7.Y.Scale, n3))
            end
        elseif typeof(arg7) == "Rect" then
            if n2 == 1 then
                return Rect.new(Vector2.new(n3, arg7.Min.Y), arg7.Max)
            end

            if n2 == 2 then
                return Rect.new(Vector2.new(arg7.Min.X, n3), arg7.Max)
            end

            if n2 == 3 then
                return Rect.new(arg7.Min, Vector2.new(n3, arg7.Max.Y))
            end

            if n2 == 4 then
                return Rect.new(arg7.Min, Vector2.new(arg7.Max.X, n3))
            end
        elseif typeof(arg7) == "Color3" then
            if arg8.UseHSV then
                local v4, v5, v6 = arg7:ToHSV()

                if n2 == 1 then
                    return Color3.fromHSV(n3, v5, v6)
                end

                if n2 == 2 then
                    return Color3.fromHSV(v4, n3, v6)
                end

                if n2 == 3 then
                    return Color3.fromHSV(v4, v5, n3)
                end
            end

            if n2 == 1 then
                return Color3.new(n3, arg7.G, arg7.B)
            end

            if n2 == 2 then
                return Color3.new(arg7.R, n3, arg7.B)
            end

            if n2 == 3 then
                return Color3.new(arg7.R, arg7.G, n3)
            end
        end

        local g_error_1 = error
        local v7 = typeof(arg7)
        g_error_1(`Incorrect datatype or value {arg7} {v7} {n2}`)
    end

    local t_3 = {
        Num = { 1 },
        Vector2 = { 1, 1 },
        Vector3 = { 1, 1, 1 },
        UDim = { 0.01, 1 },
        UDim2 = { 0.01, 1, 0.01, 1 },
        Color3 = { 1, 1, 1 },
        Color4 = { 1, 1, 1, 1 },
        Rect = { 1, 1, 1, 1 }
    }
    local t_4 = {
        Num = { 0 },
        Vector2 = { 0, 0 },
        Vector3 = { 0, 0, 0 },
        UDim = { 0, 0 },
        UDim2 = { 0, 0, 0, 0 },
        Rect = { 0, 0, 0, 0 }
    }
    local t_5 = {
        Num = { 100 },
        Vector2 = { 100, 100 },
        Vector3 = { 100, 100, 100 },
        UDim = { 1, 960 },
        UDim2 = { 1, 960, 1, 960 },
        Rect = { 960, 960, 960, 960 }
    }
    local t_6 = {
        Num = { "" },
        Vector2 = { "X: ", "Y: " },
        Vector3 = { "X: ", "Y: ", "Z: " },
        UDim = { "", "" },
        UDim2 = { "", "", "", "" },
        Color3_RGB = { "R: ", "G: ", "B: " },
        Color3_HSV = { "H: ", "S: ", "V: " },
        Color4_RGB = { "R: ", "G: ", "B: ", "T: " },
        Color4_HSV = { "H: ", "S: ", "V: ", "T: " },
        Rect = { "X: ", "Y: ", "X: ", "Y: " }
    }
    local t_7 = {
        Num = { 0 },
        Vector2 = { 0, 0 },
        Vector3 = { 0, 0, 0 },
        UDim = { 3, 0 },
        UDim2 = { 3, 0, 3, 0 },
        Color3 = { 0, 0, 0 },
        Color4 = { 0, 0, 0, 0 },
        Rect = { 0, 0, 0, 0 }
    }

    local function generateButtons(arg9: any, u1: userdata, n4: number, n5: number) -- line: 194
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)
        --  [3] getValueByIndex (copy)

        n4 += 2 * arg1._config.ItemInnerSpacing.X + n5 * 2
        local v8 = arg2.abstractButton.Generate(arg9)
        v8.Name = "SubButton"
        v8.ZIndex = arg9.ZIndex + 5
        v8.LayoutOrder = arg9.ZIndex + 5
        v8.TextXAlignment = Enum.TextXAlignment.Center
        v8.Text = "-"
        v8.Size = UDim2.fromOffset(
            arg1._config.TextSize + 2 * arg1._config.FramePadding.Y,
            arg1._config.TextSize
        )
        v8.Parent = u1
        v8.MouseButton1Click:Connect(function() -- line: 206
            -- upvalues:
            --  [1] arg2 (ref)
            --  [2] arg9 (copy)
            --  [3] getValueByIndex (ref)
            --  [4] arg1 (ref)

            local v9 = arg2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or arg2.UserInputService:IsKeyDown(
                Enum.KeyCode.RightControl
            )
            local v10 = arg9.arguments.Increment and getValueByIndex(
                arg9.arguments.Increment,
                1,
                arg9.arguments
            ) or 1
            local v11 = if not v9 then 1 else 100
            v9 = arg9.state.number.value - v10 * v11

            if arg9.arguments.Min ~= nil then
                v9 = math.max(v9, getValueByIndex(arg9.arguments.Min, 1, arg9.arguments))
            end

            if arg9.arguments.Max ~= nil then
                v9 = math.min(v9, getValueByIndex(arg9.arguments.Max, 1, arg9.arguments))
            end

            arg9.state.number:set(v9)
            arg9.lastNumberChangedTick = arg1._cycleTick + 1
        end)
        local v12 = arg2.abstractButton.Generate(arg9)
        v12.Name = "AddButton"
        v12.ZIndex = arg9.ZIndex + 6
        v12.LayoutOrder = arg9.ZIndex + 6
        v12.TextXAlignment = Enum.TextXAlignment.Center
        v12.Text = "+"
        v12.Size = UDim2.fromOffset(
            arg1._config.TextSize + 2 * arg1._config.FramePadding.Y,
            arg1._config.TextSize
        )
        v12.Parent = u1
        v12.MouseButton1Click:Connect(function() -- line: 232
            -- upvalues:
            --  [1] arg2 (ref)
            --  [2] arg9 (copy)
            --  [3] getValueByIndex (ref)
            --  [4] arg1 (ref)

            local v13 = arg2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or arg2.UserInputService:IsKeyDown(
                Enum.KeyCode.RightControl
            )
            local v14 = arg9.arguments.Increment and getValueByIndex(
                arg9.arguments.Increment,
                1,
                arg9.arguments
            ) or 1
            local v15 = if not v13 then 1 else 100
            v13 = arg9.state.number.value + v14 * v15

            if arg9.arguments.Min ~= nil then
                v13 = math.max(v13, getValueByIndex(arg9.arguments.Min, 1, arg9.arguments))
            end

            if arg9.arguments.Max ~= nil then
                v13 = math.min(v13, getValueByIndex(arg9.arguments.Max, 1, arg9.arguments))
            end

            arg9.state.number:set(v13)
            arg9.lastNumberChangedTick = arg1._cycleTick + 1
        end)

        return n4
    end

    local function generateInputScalar(arg10: any, n6: number, arg11: any) -- line: 252
        -- upvalues:
        --  [1] t (copy)
        --  [2] arg2 (copy)
        --  [3] arg1 (copy)
        --  [4] generateButtons (copy)
        --  [5] getValueByIndex (copy)
        --  [6] updateValueByIndex (copy)
        --  [7] t_7 (copy)
        --  [8] t_6 (copy)

        local t_8 = {
            hasState = true,
            hasChildren = false,
            Args = { Text = 1, Increment = 2, Min = 3, Max = 4, Format = 5 },
            Events = {
                numberChanged = t,
                hovered = arg2.EVENTS.hover(function(arg12) -- line: 265
                    return arg12.Instance
                end)
            },
            Generate = nil,
            Update = nil,
            Discard = nil,
            GenerateState = nil,
            UpdateState = nil
        }

        function t_8.Generate(arg13) -- line: 269
            -- upvalues:
            --  [1] arg10 (copy)
            --  [2] arg2 (ref)
            --  [3] arg1 (ref)
            --  [4] n6 (copy)
            --  [5] generateButtons (ref)
            --  [6] getValueByIndex (ref)
            --  [7] updateValueByIndex (ref)

            local Frame = Instance.new("Frame")
            Frame.Name = "Iris_Input" .. arg10
            Frame.Size = UDim2.fromScale(1, 0)
            Frame.BackgroundTransparency = 1
            Frame.BorderSizePixel = 0
            Frame.ZIndex = arg13.ZIndex
            Frame.LayoutOrder = arg13.ZIndex
            Frame.AutomaticSize = Enum.AutomaticSize.Y
            arg2.UIListLayout(
                Frame,
                Enum.FillDirection.Horizontal,
                UDim.new(0, arg1._config.ItemInnerSpacing.X)
            )
            local v16 = 0
            local v17 = arg1._config.TextSize + 2 * arg1._config.FramePadding.Y

            if n6 == 1 then
                v16 = generateButtons(arg13, Frame, v16, v17)
            end

            local udim_2 = UDim.new(
                arg1._config.ContentWidth.Scale / n6,
                (arg1._config.ContentWidth.Offset - arg1._config.ItemInnerSpacing.X * (n6 - 1) - v16) / n6
            )
            local v18 = UDim.new(
                udim_2.Scale * (n6 - 1),
                udim_2.Offset * (n6 - 1) + arg1._config.ItemInnerSpacing.X * (n6 - 1) + v16
            )
            v16 = arg1._config.ContentWidth - v18

            for index = 1, n6 do
                local _ = n6
                v18 = Instance.new("TextBox")
                v18.Name = "InputField" .. tostring(index)
                v18.ZIndex = arg13.ZIndex + index
                v18.LayoutOrder = arg13.ZIndex + index

                if index == n6 then
                    v18.Size = UDim2.new(v16, UDim.new())
                else
                    v18.Size = UDim2.new(udim_2, UDim.new())
                end

                v18.AutomaticSize = Enum.AutomaticSize.Y
                v18.BackgroundColor3 = arg1._config.FrameBgColor
                v18.BackgroundTransparency = arg1._config.FrameBgTransparency
                v18.ClearTextOnFocus = false
                v18.TextTruncate = Enum.TextTruncate.AtEnd
                v18.ClipsDescendants = true
                arg2.applyFrameStyle(v18)
                arg2.applyTextStyle(v18)
                arg2.UISizeConstraint(v18, Vector2.new(1, 0))
                v18.Parent = Frame
                v18.FocusLost:Connect(function() -- line: 325
                    -- upvalues:
                    --  [1] v18 (copy)
                    --  [2] arg13 (copy)
                    --  [3] getValueByIndex (ref)
                    --  [4] index (copy)
                    --  [5] updateValueByIndex (ref)
                    --  [6] arg1 (ref)

                    local v20 = tonumber(v18.Text:match("-?%d*%.?%d*"))

                    if v20 ~= nil then
                        if arg13.arguments.Min ~= nil then
                            v20 = math.max(
                                v20,
                                getValueByIndex(arg13.arguments.Min, index, arg13.arguments)
                            )
                        end

                        if arg13.arguments.Max ~= nil then
                            v20 = math.min(
                                v20,
                                getValueByIndex(arg13.arguments.Max, index, arg13.arguments)
                            )
                        end

                        if arg13.arguments.Increment then
                            v20 = math.round(
                                v20 / getValueByIndex(
                                    arg13.arguments.Increment,
                                    index,
                                    arg13.arguments
                                )
                            ) * getValueByIndex(arg13.arguments.Increment, index, arg13.arguments)
                        end

                        arg13.state.number:set(
                            updateValueByIndex(
                                arg13.state.number.value,
                                index,
                                v20,
                                arg13.arguments
                            )
                        )
                        arg13.lastNumberChangedTick = arg1._cycleTick + 1
                    end

                    v20 = arg13.arguments.Format[index] or arg13.arguments.Format[1]

                    if arg13.arguments.Prefix then
                        v20 = arg13.arguments.Prefix[index] .. v20
                    end

                    v18.Text = string.format(
                        v20,
                        getValueByIndex(arg13.state.number.value, index, arg13.arguments)
                    )
                    arg13.state.editingText:set(0)
                end)
                v18.Focused:Connect(function() -- line: 352
                    -- upvalues:
                    --  [1] v18 (copy)
                    --  [2] arg13 (copy)
                    --  [3] index (copy)

                    v18.CursorPosition = #v18.Text + 1
                    v18.SelectionStart = 1
                    arg13.state.editingText:set(index)
                end)
            end

            local TextLabel = Instance.new("TextLabel")
            TextLabel.Name = "TextLabel"
            TextLabel.Size = UDim2.fromOffset(0, v17)
            TextLabel.BackgroundTransparency = 1
            TextLabel.BorderSizePixel = 0
            TextLabel.ZIndex = arg13.ZIndex + 7
            TextLabel.LayoutOrder = arg13.ZIndex + 7
            TextLabel.AutomaticSize = Enum.AutomaticSize.X
            arg2.applyTextStyle(TextLabel)
            TextLabel.Parent = Frame

            return Frame
        end

        function t_8.Update(arg14) -- line: 376
            -- upvalues:
            --  [1] arg10 (copy)
            --  [2] n6 (copy)
            --  [3] t_7 (ref)
            --  [4] getValueByIndex (ref)
            --  [5] t_6 (ref)

            local v23 = arg14.Instance
            local TextLabel_1 = v23.TextLabel
            TextLabel_1.Text = arg14.arguments.Text or `Input {arg10}`

            if n6 == 1 then
                v23.SubButton.Visible = not arg14.arguments.NoButtons
                v23.AddButton.Visible = not arg14.arguments.NoButtons
            end

            if arg14.arguments.Format and typeof(arg14.arguments.Format) ~= "table" then
                arg14.arguments.Format = { arg14.arguments.Format }

                return
            end

            local t_11 = {}
            local v26

            for index_1 = 1, n6 do
                v23 = t_7[arg10][index_1]
                local _ = n6

                if arg14.arguments.Increment then
                    v26 = if getValueByIndex(arg14.arguments.Increment, index_1, arg14.arguments) ~= 0 then getValueByIndex(
                        arg14.arguments.Increment,
                        index_1,
                        arg14.arguments
                    ) else 1
                    v23 = math.max(v23, math.ceil(-math.log10(v26)), v23)
                end

                if arg14.arguments.Max then
                    v26 = if getValueByIndex(arg14.arguments.Max, index_1, arg14.arguments) ~= 0 then getValueByIndex(
                        arg14.arguments.Max,
                        index_1,
                        arg14.arguments
                    ) else 1
                    v23 = math.max(v23, math.ceil(-math.log10(v26)), v23)
                end

                if arg14.arguments.Min then
                    v26 = if getValueByIndex(arg14.arguments.Min, index_1, arg14.arguments) ~= 0 then getValueByIndex(
                        arg14.arguments.Min,
                        index_1,
                        arg14.arguments
                    ) else 1
                    v23 = math.max(v23, math.ceil(-math.log10(v26)), v23)
                end

                if v23 > 0 then
                    t_11[index_1] = `%.{v23}f`
                else
                    t_11[index_1] = "%d"
                end
            end

            arg14.arguments.Format = t_11
            arg14.arguments.Prefix = t_6[arg10]
        end

        function t_8.Discard(arg15) -- line: 421
            -- upvalues:
            --  [1] arg2 (ref)

            arg15.Instance:Destroy()
            arg2.discardState(arg15)
        end

        function t_8.GenerateState(arg16) -- line: 425
            -- upvalues:
            --  [1] arg1 (ref)
            --  [2] arg11 (copy)

            if arg16.state.number == nil then
                arg16.state.number = arg1._widgetState(arg16, "number", arg11)
            end

            if arg16.state.editingText == nil then
                arg16.state.editingText = arg1._widgetState(arg16, "editingText", 0)
            end
        end

        function t_8.UpdateState(arg17) -- line: 433
            -- upvalues:
            --  [1] n6 (copy)
            --  [2] getValueByIndex (ref)

            local v30 = arg17.Instance

            for index_2 = 1, n6 do
                local _ = n6
                local v33 = v30:FindFirstChild("InputField" .. tostring(index_2))
                local v34 = arg17.arguments.Format[index_2] or arg17.arguments.Format[1]

                if arg17.arguments.Prefix then
                    v34 = arg17.arguments.Prefix[index_2] .. v34
                end

                v33.Text = string.format(
                    v34,
                    getValueByIndex(arg17.state.number.value, index_2, arg17.arguments)
                )
            end
        end

        return t_8
    end

    local v35 = 0
    local v36 = false
    local v37 = nil
    local v38 = 0
    local v39 = ""

    local function updateActiveDrag() -- line: 461
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] v35 (ref)
        --  [3] v36 (ref)
        --  [4] v37 (ref)
        --  [5] v39 (ref)
        --  [6] v38 (ref)
        --  [7] getValueByIndex (copy)
        --  [8] t_3 (copy)
        --  [9] updateValueByIndex (copy)
        --  [10] arg1 (copy)

        local X_2 = arg2.getMouseLocation().X
        local v40 = X_2 - v35
        v35 = X_2

        if v36 == false then
            return
        end

        if v37 == nil then
            return
        end

        local v41 = v37.state.number
        v41 = if v39 == "Color3" then if v38 ~= 4 then v37.state.color else v37.state.transparency else if v39 ~= "Color4" then v41 else if v38 ~= 4 then v37.state.color else v37.state.transparency
        local v42 = v37.arguments.Increment and getValueByIndex(
            v37.arguments.Increment,
            v38,
            v37.arguments
        ) or t_3[v39][v38]
        local v43

        if not arg2.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            v43 = if arg2.UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then 10 else 1
        else
            v43 = 10
            v43 = 1
        end

        v42 *= v43

        if not arg2.UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) then
            v43 = if arg2.UserInputService:IsKeyDown(Enum.KeyCode.RightAlt) then 0.1 else 1
        else
            v43 = 0.1
            v43 = 1
        end

        local v44 = v42 * v43
        v43 = if v39 == "Color3" then 5 else if v39 ~= "Color4" then 1 else 5
        v42 = v44 * v43
        local v45 = getValueByIndex(v41.value, v38, v37.arguments) + v40 * v42

        if v37.arguments.Min ~= nil then
            v45 = math.max(v45, getValueByIndex(v37.arguments.Min, v38, v37.arguments))
        end

        if v37.arguments.Max ~= nil then
            v45 = math.min(v45, getValueByIndex(v37.arguments.Max, v38, v37.arguments))
        end

        v41:set(updateValueByIndex(v41.value, v38, v45, v37.arguments))
        v37.lastNumberChangedTick = arg1._cycleTick + 1
    end

    local function DragMouseDown(
        arg18: any,
        arg19: any,
        n7: number,
        n8: number,
        n9: number
    ) -- line: 502
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] arg1 (copy)
        --  [3] v36 (ref)
        --  [4] v37 (ref)
        --  [5] v38 (ref)
        --  [6] v39 (ref)
        --  [7] updateActiveDrag (copy)

        local v46 = arg2.getTime()
        local v47 = v46 - arg18.lastClickedTime < arg1._config.MouseDoubleClickTime
        local v48 = arg2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or arg2.UserInputService:IsKeyDown(
            Enum.KeyCode.RightControl
        )

        if v47 then
            if (Vector2.new(n8, n9) - arg18.lastClickedPosition).Magnitude < arg1._config.MouseDoubleClickMaxDist or v48 then
                arg18.state.editingText:set(n7)

                return
            end

            arg18.lastClickedTime = v46
            arg18.lastClickedPosition = Vector2.new(n8, n9)
            v36 = true
            v37 = arg18
            v38 = n7
            v39 = arg19
            updateActiveDrag()

            return
        end

        if v48 then
            arg18.state.editingText:set(n7)

            return
        end

        arg18.lastClickedTime = v46
        arg18.lastClickedPosition = Vector2.new(n8, n9)
        v36 = true
        v37 = arg18
        v38 = n7
        v39 = arg19
        updateActiveDrag()
    end

    arg2.UserInputService.InputChanged:Connect(updateActiveDrag)
    arg2.UserInputService.InputEnded:Connect(function(input: userdata) -- line: 525
        -- upvalues:
        --  [1] v36 (ref)
        --  [2] v37 (ref)
        --  [3] v38 (ref)

        if input.UserInputType == Enum.UserInputType.MouseButton1 and v36 then
            v36 = false
            v37 = nil
            v38 = 0
        end
    end)

    local function generateDragScalar(arg20: any, n10: number, arg21: any) -- line: 533
        -- upvalues:
        --  [1] t (copy)
        --  [2] arg2 (copy)
        --  [3] arg1 (copy)
        --  [4] getValueByIndex (copy)
        --  [5] updateValueByIndex (copy)
        --  [6] DragMouseDown (copy)
        --  [7] t_7 (copy)
        --  [8] t_6 (copy)

        local t_12 = {
            hasState = true,
            hasChildren = false,
            Args = { Text = 1, Increment = 2, Min = 3, Max = 4, Format = 5 },
            Events = {
                numberChanged = t,
                hovered = arg2.EVENTS.hover(function(arg22) -- line: 546
                    return arg22.Instance
                end)
            },
            Generate = nil,
            Update = nil,
            Discard = nil,
            GenerateState = nil,
            UpdateState = nil
        }

        function t_12.Generate(arg23) -- line: 550
            -- upvalues:
            --  [1] arg20 (copy)
            --  [2] arg2 (ref)
            --  [3] arg1 (ref)
            --  [4] n10 (copy)
            --  [5] getValueByIndex (ref)
            --  [6] updateValueByIndex (ref)
            --  [7] DragMouseDown (ref)

            arg23.lastClickedTime = -1
            arg23.lastClickedPosition = Vector2.zero
            local Frame_1 = Instance.new("Frame")
            Frame_1.Name = "Iris_Drag" .. arg20
            Frame_1.Size = UDim2.fromScale(1, 0)
            Frame_1.BackgroundTransparency = 1
            Frame_1.BorderSizePixel = 0
            Frame_1.ZIndex = arg23.ZIndex
            Frame_1.LayoutOrder = arg23.ZIndex
            Frame_1.AutomaticSize = Enum.AutomaticSize.Y
            arg2.UIListLayout(
                Frame_1,
                Enum.FillDirection.Horizontal,
                UDim.new(0, arg1._config.ItemInnerSpacing.X)
            )
            local v49 = 0
            local v50 = arg1._config.TextSize + 2 * arg1._config.FramePadding.Y

            if arg20 == "Color3" or arg20 == "Color4" then
                v49 += arg1._config.ItemInnerSpacing.X + v50
                local ColorBox_ImageLabel = Instance.new("ImageLabel")
                ColorBox_ImageLabel.Name = "ColorBox"
                ColorBox_ImageLabel.BorderSizePixel = 0
                ColorBox_ImageLabel.Size = UDim2.fromOffset(v50, v50)
                ColorBox_ImageLabel.ZIndex = arg23.ZIndex + 5
                ColorBox_ImageLabel.LayoutOrder = arg23.ZIndex + 5
                ColorBox_ImageLabel.Image = arg2.ICONS.ALPHA_BACKGROUND_TEXTURE
                ColorBox_ImageLabel.ImageTransparency = 1
                arg2.applyFrameStyle(ColorBox_ImageLabel, true, true)
                ColorBox_ImageLabel.Parent = Frame_1
            end

            local udim_3 = UDim.new(
                arg1._config.ContentWidth.Scale / n10,
                (arg1._config.ContentWidth.Offset - arg1._config.ItemInnerSpacing.X * (n10 - 1) - v49) / n10
            )
            local udim_4 = UDim.new(
                udim_3.Scale * (n10 - 1),
                udim_3.Offset * (n10 - 1) + arg1._config.ItemInnerSpacing.X * (n10 - 1) + v49
            )
            v49 = arg1._config.ContentWidth - udim_4

            for index_3 = 1, n10 do
                local _ = n10
                local TextButton = Instance.new("TextButton")
                TextButton.Name = "DragField" .. tostring(index_3)
                TextButton.ZIndex = arg23.ZIndex + index_3
                TextButton.LayoutOrder = arg23.ZIndex + index_3

                if index_3 == n10 then
                    TextButton.Size = UDim2.new(v49, UDim.new())
                else
                    TextButton.Size = UDim2.new(udim_3, UDim.new())
                end

                TextButton.AutomaticSize = Enum.AutomaticSize.Y
                TextButton.BackgroundColor3 = arg1._config.FrameBgColor
                TextButton.BackgroundTransparency = arg1._config.FrameBgTransparency
                TextButton.AutoButtonColor = false
                TextButton.Text = ""
                TextButton.ClipsDescendants = true
                arg2.applyFrameStyle(TextButton)
                arg2.applyTextStyle(TextButton)
                arg2.UISizeConstraint(TextButton, Vector2.new(1, 0))
                TextButton.TextXAlignment = Enum.TextXAlignment.Center
                TextButton.Parent = Frame_1
                arg2.applyInteractionHighlights(
                    TextButton,
                    TextButton,
                    {
                        ButtonColor = arg1._config.FrameBgColor,
                        ButtonTransparency = arg1._config.FrameBgTransparency,
                        ButtonHoveredColor = arg1._config.FrameBgHoveredColor,
                        ButtonHoveredTransparency = arg1._config.FrameBgHoveredTransparency,
                        ButtonActiveColor = arg1._config.FrameBgActiveColor,
                        ButtonActiveTransparency = arg1._config.FrameBgActiveTransparency
                    }
                )
                local InputField_TextBox = Instance.new("TextBox")
                InputField_TextBox.Name = "InputField"
                InputField_TextBox.ZIndex = arg23.ZIndex + 5
                InputField_TextBox.LayoutOrder = arg23.ZIndex + 2
                InputField_TextBox.Size = UDim2.new(1, 0, 1, 0)
                InputField_TextBox.BackgroundTransparency = 1
                InputField_TextBox.ClearTextOnFocus = false
                InputField_TextBox.TextTruncate = Enum.TextTruncate.AtEnd
                InputField_TextBox.ClipsDescendants = true
                InputField_TextBox.Visible = false
                arg2.applyFrameStyle(InputField_TextBox, true)
                arg2.applyTextStyle(InputField_TextBox)
                InputField_TextBox.Parent = TextButton
                InputField_TextBox.FocusLost:Connect(function() -- line: 648
                    -- upvalues:
                    --  [1] InputField_TextBox (copy)
                    --  [2] arg23 (copy)
                    --  [3] arg20 (ref)
                    --  [4] index_3 (copy)
                    --  [5] getValueByIndex (ref)
                    --  [6] updateValueByIndex (ref)
                    --  [7] arg1 (ref)

                    local v53 = tonumber(InputField_TextBox.Text:match("-?%d*%.?%d*"))
                    local v54 = arg23.state.number
                    v54 = if arg20 == "Color4" and index_3 == 4 then arg23.state.transparency else if arg20 == "Color3" then arg23.state.color else if arg20 ~= "Color4" then v54 else arg23.state.color

                    if v53 ~= nil then
                        v53 = if arg20 == "Color3" then v53 / 255 else if arg20 ~= "Color4" then v53 else if arg23.arguments.UseFloats then v53 else v53 / 255

                        if arg23.arguments.Min ~= nil then
                            v53 = math.max(
                                v53,
                                getValueByIndex(arg23.arguments.Min, index_3, arg23.arguments)
                            )
                        end

                        if arg23.arguments.Max ~= nil then
                            v53 = math.min(
                                v53,
                                getValueByIndex(arg23.arguments.Max, index_3, arg23.arguments)
                            )
                        end

                        if arg23.arguments.Increment then
                            v53 = math.round(
                                v53 / getValueByIndex(
                                    arg23.arguments.Increment,
                                    index_3,
                                    arg23.arguments
                                )
                            ) * getValueByIndex(arg23.arguments.Increment, index_3, arg23.arguments)
                        end

                        v54:set(updateValueByIndex(v54.value, index_3, v53, arg23.arguments))
                        arg23.lastNumberChangedTick = arg1._cycleTick + 1
                    end

                    v53 = getValueByIndex(v54.value, index_3, arg23.arguments)

                    if arg20 == "Color3" or arg20 == "Color4" and not arg23.arguments.UseFloats then
                        v53 = math.round(v53 * 255)
                    end

                    v54 = arg23.arguments.Format[index_3] or arg23.arguments.Format[1]

                    if arg23.arguments.Prefix then
                        v54 = arg23.arguments.Prefix[index_3] .. v54
                    end

                    InputField_TextBox.Text = string.format(v54, v53)
                    arg23.state.editingText:set(0)
                    InputField_TextBox:ReleaseFocus(true)
                end)
                InputField_TextBox.Focused:Connect(function() -- line: 691
                    -- upvalues:
                    --  [1] InputField_TextBox (copy)
                    --  [2] arg23 (copy)
                    --  [3] index_3 (copy)

                    InputField_TextBox.CursorPosition = #InputField_TextBox.Text + 1
                    InputField_TextBox.SelectionStart = 1
                    arg23.state.editingText:set(index_3)
                end)
                TextButton.MouseButton1Down:Connect(function(x: number, y: number) -- line: 699
                    -- upvalues:
                    --  [1] DragMouseDown (ref)
                    --  [2] arg23 (copy)
                    --  [3] arg20 (ref)
                    --  [4] index_3 (copy)

                    DragMouseDown(
                        arg23,
                        arg20,
                        index_3,
                        x,
                        y
                    )
                end)
            end

            local TextLabel_2 = Instance.new("TextLabel")
            TextLabel_2.Name = "TextLabel"
            TextLabel_2.Size = UDim2.fromOffset(0, v50)
            TextLabel_2.BackgroundTransparency = 1
            TextLabel_2.BorderSizePixel = 0
            TextLabel_2.ZIndex = arg23.ZIndex + 5
            TextLabel_2.LayoutOrder = arg23.ZIndex + 5
            TextLabel_2.AutomaticSize = Enum.AutomaticSize.X
            arg2.applyTextStyle(TextLabel_2)
            TextLabel_2.Parent = Frame_1

            return Frame_1
        end

        function t_12.Update(arg24) -- line: 719
            -- upvalues:
            --  [1] arg20 (copy)
            --  [2] n10 (copy)
            --  [3] t_7 (ref)
            --  [4] getValueByIndex (ref)
            --  [5] t_6 (ref)

            local TextLabel_3 = arg24.Instance.TextLabel
            TextLabel_3.Text = arg24.arguments.Text or `Drag {arg20}`

            if arg24.arguments.Format and typeof(arg24.arguments.Format) ~= "table" then
                arg24.arguments.Format = { arg24.arguments.Format }

                return
            end

            if not arg24.arguments.Format then
                local t_16 = {}
                local v60

                for index_4 = 1, n10 do
                    local v58 = t_7[arg20][index_4]
                    local _ = n10

                    if arg24.arguments.Increment then
                        v60 = if getValueByIndex(
                            arg24.arguments.Increment,
                            index_4,
                            arg24.arguments
                        ) ~= 0 then getValueByIndex(
                            arg24.arguments.Increment,
                            index_4,
                            arg24.arguments
                        ) else 1
                        v58 = math.max(v58, math.ceil(-math.log10(v60)), v58)
                    end

                    if arg24.arguments.Max then
                        v60 = if getValueByIndex(arg24.arguments.Max, index_4, arg24.arguments) ~= 0 then getValueByIndex(
                            arg24.arguments.Max,
                            index_4,
                            arg24.arguments
                        ) else 1
                        v58 = math.max(v58, math.ceil(-math.log10(v60)), v58)
                    end

                    if arg24.arguments.Min then
                        v60 = if getValueByIndex(arg24.arguments.Min, index_4, arg24.arguments) ~= 0 then getValueByIndex(
                            arg24.arguments.Min,
                            index_4,
                            arg24.arguments
                        ) else 1
                        v58 = math.max(v58, math.ceil(-math.log10(v60)), v58)
                    end

                    if v58 > 0 then
                        t_16[index_4] = `%.{v58}f`
                    else
                        t_16[index_4] = "%d"
                    end
                end

                arg24.arguments.Format = t_16
                arg24.arguments.Prefix = t_6[arg20]
            end
        end

        function t_12.Discard(arg25) -- line: 759
            -- upvalues:
            --  [1] arg2 (ref)

            arg25.Instance:Destroy()
            arg2.discardState(arg25)
        end

        function t_12.GenerateState(arg26) -- line: 763
            -- upvalues:
            --  [1] arg1 (ref)
            --  [2] arg21 (copy)

            if arg26.state.number == nil then
                arg26.state.number = arg1._widgetState(arg26, "number", arg21)
            end

            if arg26.state.editingText == nil then
                arg26.state.editingText = arg1._widgetState(arg26, "editingText", false)
            end
        end

        function t_12.UpdateState(arg27) -- line: 771
            -- upvalues:
            --  [1] n10 (copy)
            --  [2] arg20 (copy)
            --  [3] getValueByIndex (ref)
            --  [4] arg1 (ref)

            local v64 = arg27.Instance

            for index_5 = 1, n10 do
                local v65 = arg27.state.number
                v65 = if arg20 == "Color3" then if index_5 ~= 4 then arg27.state.color else arg27.state.transparency else if arg20 ~= "Color4" then v65 else if index_5 ~= 4 then arg27.state.color else arg27.state.transparency
                local _ = n10
                local v68 = v64:FindFirstChild("DragField" .. tostring(index_5))
                local InputField = v68.InputField
                local v69 = getValueByIndex(v65.value, index_5, arg27.arguments)

                if (arg20 == "Color3" or arg20 == "Color4") and not arg27.arguments.UseFloats then
                    v69 = math.round(v69 * 255)
                end

                v65 = arg27.arguments.Format[index_5] or arg27.arguments.Format[1]

                if arg27.arguments.Prefix then
                    v65 = arg27.arguments.Prefix[index_5] .. v65
                end

                v68.Text = string.format(v65, v69)
                InputField.Text = tostring(v69)

                if arg27.state.editingText.value == index_5 then
                    InputField.Visible = true
                    InputField:CaptureFocus()
                    v68.TextTransparency = 1
                else
                    InputField.Visible = false
                    v68.TextTransparency = arg1._config.TextTransparency
                end
            end

            if arg20 == "Color3" or arg20 == "Color4" then
                local ColorBox = v64.ColorBox
                ColorBox.BackgroundColor3 = arg27.state.color.value

                if arg20 == "Color4" then
                    ColorBox.ImageTransparency = 1 - arg27.state.transparency.value
                end
            end
        end

        return t_12
    end

    local function generateColorDragScalar(arg28, ...) -- line: 819
        -- upvalues:
        --  [1] generateDragScalar (ref)
        --  [2] arg2 (copy)
        --  [3] t_6 (copy)
        --  [4] arg1 (copy)

        local t_17 = { ... }
        local v72 = generateDragScalar(arg28, if arg28 == "Color4" then 4 else 3, t_17[1])
        local t_18 = { Args = nil, Update = nil, GenerateState = nil }
        local Extend = arg2.extend
        t_18.Args = { Text = 1, UseFloats = 2, UseHSV = 3, Format = 4 }

        function t_18.Update(arg29) -- line: 830
            -- upvalues:
            --  [1] arg28 (copy)
            --  [2] t_6 (ref)
            --  [3] arg1 (ref)

            local v73 = arg29.arguments.Text
            local TextLabel_4 = arg29.Instance.TextLabel

            if not v73 then
                v73 = `Drag {arg28}`
            end

            TextLabel_4.Text = v73
            local v74

            if arg29.arguments.Format then
                if typeof(arg29.arguments.Format) ~= "table" then
                    arg29.arguments.Format = { arg29.arguments.Format }
                else
                    if arg29.arguments.UseFloats then
                        arg29.arguments.Format = { "%.3f" }
                    else
                        arg29.arguments.Format = { "%d" }
                    end

                    v74 = if not arg29.arguments.UseHSV then "_RGB" else "_HSV"
                    arg29.arguments.Prefix = t_6[arg28 .. v74]
                end
            else
                if arg29.arguments.UseFloats then
                    arg29.arguments.Format = { "%.3f" }
                else
                    arg29.arguments.Format = { "%d" }
                end

                v74 = if not arg29.arguments.UseHSV then "_RGB" else "_HSV"
                arg29.arguments.Prefix = t_6[arg28 .. v74]
            end

            arg29.arguments.Min = { 0, 0, 0, 0 }
            arg29.arguments.Max = { 1, 1, 1, 1 }
            arg29.arguments.Increment = { 0.001, 0.001, 0.001, 0.001 }

            if arg29.state then
                arg1._widgets[arg29.type].UpdateState(arg29)
            end
        end

        function t_18.GenerateState(arg30) -- line: 857
            -- upvalues:
            --  [1] arg1 (ref)
            --  [2] t_17 (copy)
            --  [3] arg28 (copy)

            if arg30.state.color == nil then
                arg30.state.color = arg1._widgetState(arg30, "color", t_17[1])
            end

            if arg28 == "Color4" and arg30.state.transparency == nil then
                arg30.state.transparency = arg1._widgetState(arg30, "transparency", t_17[2])
            end

            if arg30.state.editingText == nil then
                arg30.state.editingText = arg1._widgetState(arg30, "editingText", false)
            end
        end

        return Extend(v72, t_18)
    end

    local v75 = false
    local v76 = nil
    local v77 = 0
    local v78 = ""

    local function updateActiveSlider() -- line: 885
        -- upvalues:
        --  [1] v75 (ref)
        --  [2] v76 (ref)
        --  [3] v77 (ref)
        --  [4] getValueByIndex (copy)
        --  [5] t_3 (copy)
        --  [6] v78 (ref)
        --  [7] t_4 (copy)
        --  [8] t_5 (copy)
        --  [9] arg1 (copy)
        --  [10] arg2 (copy)
        --  [11] updateValueByIndex (copy)

        if v75 == false then
            return
        end

        if v76 == nil then
            return
        end

        local v81 = v76.Instance:FindFirstChild("SliderField" .. tostring(v77))
        local v82 = v76.arguments.Increment and getValueByIndex(
            v76.arguments.Increment,
            v77,
            v76.arguments
        ) or t_3[v78][v77]
        local v83 = v76.arguments.Min and getValueByIndex(v76.arguments.Min, v77, v76.arguments) or t_4[v78][v77]
        local v84 = v76.arguments.Max and getValueByIndex(v76.arguments.Max, v77, v76.arguments) or t_5[v78][v77]
        local X_3 = arg1._config.FramePadding.X
        local v85 = if not (v82 < 1) then 1 else 0
        local v86 = math.floor((v85 + v84 - v83) / v82)
        v76.state.number:set(
            updateValueByIndex(
                v76.state.number.value,
                v77,
                math.clamp(
                    math.floor(
                        (arg2.getMouseLocation().X - (v81.AbsolutePosition.X + X_3)) / (v81.AbsoluteSize.X - X_3 * 2) * v86
                    ) * v82 + v83,
                    v83,
                    v84
                ),
                v76.arguments
            )
        )
        v76.lastNumberChangedTick = arg1._cycleTick + 1
    end

    local function SliderMouseDown(arg31: any, arg32: any, n13: number) -- line: 915
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] v75 (ref)
        --  [3] v76 (ref)
        --  [4] v77 (ref)
        --  [5] v78 (ref)
        --  [6] updateActiveSlider (copy)

        if arg2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or arg2.UserInputService:IsKeyDown(
            Enum.KeyCode.RightControl
        ) then
            arg31.state.editingText:set(n13)

            return
        end

        v75 = true
        v76 = arg31
        v77 = n13
        v78 = arg32
        updateActiveSlider()
    end

    arg2.UserInputService.InputChanged:Connect(updateActiveSlider)
    arg2.UserInputService.InputEnded:Connect(function(input_1: userdata) -- line: 931
        -- upvalues:
        --  [1] v75 (ref)
        --  [2] v76 (ref)
        --  [3] v77 (ref)
        --  [4] v78 (ref)

        if input_1.UserInputType == Enum.UserInputType.MouseButton1 and v75 then
            v75 = false
            v76 = nil
            v77 = 0
            v78 = ""
        end
    end)

    local function generateSliderScalar(arg33: any, n14: number, arg34: any, ...) -- line: 940
        -- upvalues:
        --  [1] t (copy)
        --  [2] arg2 (copy)
        --  [3] arg1 (copy)
        --  [4] getValueByIndex (copy)
        --  [5] updateValueByIndex (copy)
        --  [6] SliderMouseDown (copy)
        --  [7] t_7 (copy)
        --  [8] t_6 (copy)
        --  [9] t_3 (copy)
        --  [10] t_4 (copy)
        --  [11] t_5 (copy)

        local t_20 = {
            hasState = true,
            hasChildren = false,
            Args = { Text = 1, Increment = 2, Min = 3, Max = 4, Format = 5 },
            Events = {
                numberChanged = t,
                hovered = arg2.EVENTS.hover(function(arg35) -- line: 953
                    return arg35.Instance
                end)
            },
            Generate = nil,
            Update = nil,
            Discard = nil,
            GenerateState = nil,
            UpdateState = nil
        }

        function t_20.Generate(arg36) -- line: 957
            -- upvalues:
            --  [1] arg33 (copy)
            --  [2] arg2 (ref)
            --  [3] arg1 (ref)
            --  [4] n14 (copy)
            --  [5] getValueByIndex (ref)
            --  [6] updateValueByIndex (ref)
            --  [7] SliderMouseDown (ref)

            local Frame_2 = Instance.new("Frame")
            Frame_2.Name = "Iris_Slider" .. arg33
            Frame_2.Size = UDim2.fromScale(1, 0)
            Frame_2.BackgroundTransparency = 1
            Frame_2.BorderSizePixel = 0
            Frame_2.ZIndex = arg36.ZIndex
            Frame_2.LayoutOrder = arg36.ZIndex
            Frame_2.AutomaticSize = Enum.AutomaticSize.Y
            arg2.UIListLayout(
                Frame_2,
                Enum.FillDirection.Horizontal,
                UDim.new(0, arg1._config.ItemInnerSpacing.X)
            )
            local v88 = arg1._config.TextSize + 2 * arg1._config.FramePadding.Y
            local udim_5 = UDim.new(
                arg1._config.ContentWidth.Scale / n14,
                (arg1._config.ContentWidth.Offset - arg1._config.ItemInnerSpacing.X * (n14 - 1)) / n14
            )
            local udim_6 = UDim.new(
                udim_5.Scale * (n14 - 1),
                udim_5.Offset * (n14 - 1) + arg1._config.ItemInnerSpacing.X * (n14 - 1)
            )
            local v89 = arg1._config.ContentWidth - udim_6
            local OverlayText_TextLabel

            for index_6 = 1, n14 do
                local _ = n14
                local TextButton_1 = Instance.new("TextButton")
                TextButton_1.Name = "SliderField" .. tostring(index_6)
                TextButton_1.ZIndex = arg36.ZIndex + index_6
                TextButton_1.LayoutOrder = arg36.ZIndex + index_6

                if index_6 == n14 then
                    TextButton_1.Size = UDim2.new(v89, UDim.new())
                else
                    TextButton_1.Size = UDim2.new(udim_5, UDim.new())
                end

                TextButton_1.AutomaticSize = Enum.AutomaticSize.Y
                TextButton_1.BackgroundColor3 = arg1._config.FrameBgColor
                TextButton_1.BackgroundTransparency = arg1._config.FrameBgTransparency
                TextButton_1.AutoButtonColor = false
                TextButton_1.Text = ""
                TextButton_1.ClipsDescendants = true
                arg2.applyFrameStyle(TextButton_1)
                arg2.applyTextStyle(TextButton_1)
                arg2.UISizeConstraint(TextButton_1, Vector2.new(1, 0))
                TextButton_1.Parent = Frame_2
                OverlayText_TextLabel = Instance.new("TextLabel")
                OverlayText_TextLabel.Name = "OverlayText"
                OverlayText_TextLabel.Size = UDim2.fromScale(1, 1)
                OverlayText_TextLabel.BackgroundTransparency = 1
                OverlayText_TextLabel.BorderSizePixel = 0
                OverlayText_TextLabel.ZIndex = arg36.ZIndex + 10
                OverlayText_TextLabel.ClipsDescendants = true
                arg2.applyTextStyle(OverlayText_TextLabel)
                OverlayText_TextLabel.TextXAlignment = Enum.TextXAlignment.Center
                OverlayText_TextLabel.Parent = TextButton_1
                arg2.applyInteractionHighlights(
                    TextButton_1,
                    TextButton_1,
                    {
                        ButtonColor = arg1._config.FrameBgColor,
                        ButtonTransparency = arg1._config.FrameBgTransparency,
                        ButtonHoveredColor = arg1._config.FrameBgHoveredColor,
                        ButtonHoveredTransparency = arg1._config.FrameBgHoveredTransparency,
                        ButtonActiveColor = arg1._config.FrameBgActiveColor,
                        ButtonActiveTransparency = arg1._config.FrameBgActiveTransparency
                    }
                )
                local OverlayText_TextLabel = Instance.new("TextBox")
                OverlayText_TextLabel.Name = "InputField"
                OverlayText_TextLabel.ZIndex = arg36.ZIndex + 5
                OverlayText_TextLabel.LayoutOrder = arg36.ZIndex + 2
                OverlayText_TextLabel.Size = UDim2.new(1, 0, 1, 0)
                OverlayText_TextLabel.BackgroundTransparency = 1
                OverlayText_TextLabel.ClearTextOnFocus = false
                OverlayText_TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
                OverlayText_TextLabel.ClipsDescendants = true
                OverlayText_TextLabel.Visible = false
                arg2.applyFrameStyle(OverlayText_TextLabel, true)
                arg2.applyTextStyle(OverlayText_TextLabel)
                OverlayText_TextLabel.Parent = TextButton_1
                OverlayText_TextLabel.FocusLost:Connect(function() -- line: 1045
                    -- upvalues:
                    --  [1] OverlayText_TextLabel (copy)
                    --  [2] arg36 (copy)
                    --  [3] getValueByIndex (ref)
                    --  [4] index_6 (copy)
                    --  [5] updateValueByIndex (ref)
                    --  [6] arg1 (ref)

                    local v92 = tonumber(OverlayText_TextLabel.Text:match("-?%d*%.?%d*"))

                    if v92 ~= nil then
                        if arg36.arguments.Min ~= nil then
                            v92 = math.max(
                                v92,
                                getValueByIndex(arg36.arguments.Min, index_6, arg36.arguments)
                            )
                        end

                        if arg36.arguments.Max ~= nil then
                            v92 = math.min(
                                v92,
                                getValueByIndex(arg36.arguments.Max, index_6, arg36.arguments)
                            )
                        end

                        if arg36.arguments.Increment then
                            v92 = math.round(
                                v92 / getValueByIndex(
                                    arg36.arguments.Increment,
                                    index_6,
                                    arg36.arguments
                                )
                            ) * getValueByIndex(arg36.arguments.Increment, index_6, arg36.arguments)
                        end

                        arg36.state.number:set(
                            updateValueByIndex(
                                arg36.state.number.value,
                                index_6,
                                v92,
                                arg36.arguments
                            )
                        )
                        arg36.lastNumberChangedTick = arg1._cycleTick + 1
                    end

                    v92 = arg36.arguments.Format[index_6] or arg36.arguments.Format[1]

                    if arg36.arguments.Prefix then
                        v92 = arg36.arguments.Prefix[index_6] .. v92
                    end

                    OverlayText_TextLabel.Text = string.format(
                        v92,
                        getValueByIndex(arg36.state.number.value, index_6, arg36.arguments)
                    )
                    arg36.state.editingText:set(0)
                    OverlayText_TextLabel:ReleaseFocus(true)
                end)
                OverlayText_TextLabel.Focused:Connect(function() -- line: 1075
                    -- upvalues:
                    --  [1] OverlayText_TextLabel (copy)
                    --  [2] arg36 (copy)
                    --  [3] index_6 (copy)

                    OverlayText_TextLabel.CursorPosition = #OverlayText_TextLabel.Text + 1
                    OverlayText_TextLabel.SelectionStart = 1
                    arg36.state.editingText:set(index_6)
                end)
                TextButton_1.MouseButton1Down:Connect(function() -- line: 1083
                    -- upvalues:
                    --  [1] SliderMouseDown (ref)
                    --  [2] arg36 (copy)
                    --  [3] arg33 (ref)
                    --  [4] index_6 (copy)

                    SliderMouseDown(arg36, arg33, index_6)
                end)
                local Frame_3 = Instance.new("Frame")
                Frame_3.Name = "GrabBar"
                Frame_3.ZIndex = arg36.ZIndex + 5
                Frame_3.LayoutOrder = arg36.ZIndex + 5
                Frame_3.AnchorPoint = Vector2.new(0, 0.5)
                Frame_3.Position = UDim2.new(0, 0, 0.5, 0)
                Frame_3.BorderSizePixel = 0
                Frame_3.BackgroundColor3 = arg1._config.SliderGrabColor
                Frame_3.Transparency = arg1._config.SliderGrabTransparency

                if arg1._config.GrabRounding > 0 then
                    arg2.UICorner(Frame_3, arg1._config.GrabRounding)
                end

                Frame_3.Parent = TextButton_1
            end

            local TextLabel_5 = Instance.new("TextLabel")
            TextLabel_5.Name = "TextLabel"
            TextLabel_5.Size = UDim2.fromOffset(0, v88)
            TextLabel_5.BackgroundTransparency = 1
            TextLabel_5.BorderSizePixel = 0
            TextLabel_5.ZIndex = arg36.ZIndex + 5
            TextLabel_5.LayoutOrder = arg36.ZIndex + 5
            TextLabel_5.AutomaticSize = Enum.AutomaticSize.X
            arg2.applyTextStyle(TextLabel_5)
            TextLabel_5.Parent = Frame_2

            return Frame_2
        end

        function t_20.Update(arg37) -- line: 1118
            -- upvalues:
            --  [1] arg33 (copy)
            --  [2] n14 (copy)
            --  [3] t_7 (ref)
            --  [4] getValueByIndex (ref)
            --  [5] t_6 (ref)
            --  [6] t_3 (ref)
            --  [7] t_4 (ref)
            --  [8] t_5 (ref)
            --  [9] arg1 (ref)

            local v95 = arg37.Instance
            local TextLabel_6 = v95.TextLabel
            TextLabel_6.Text = arg37.arguments.Text or `Slider {arg33}`
            local t_24
            local v97, v99

            if arg37.arguments.Format then
                if typeof(arg37.arguments.Format) ~= "table" then
                    arg37.arguments.Format = { arg37.arguments.Format }
                else
                    t_24 = {}

                    for index_7 = 1, n14 do
                        v97 = t_7[arg33][index_7]
                        local _ = n14

                        if arg37.arguments.Increment then
                            v99 = if getValueByIndex(
                                arg37.arguments.Increment,
                                index_7,
                                arg37.arguments
                            ) ~= 0 then getValueByIndex(
                                arg37.arguments.Increment,
                                index_7,
                                arg37.arguments
                            ) else 1
                            v97 = math.max(v97, math.ceil(-math.log10(v99)), v97)
                        end

                        if arg37.arguments.Max then
                            v99 = if getValueByIndex(arg37.arguments.Max, index_7, arg37.arguments) ~= 0 then getValueByIndex(
                                arg37.arguments.Max,
                                index_7,
                                arg37.arguments
                            ) else 1
                            v97 = math.max(v97, math.ceil(-math.log10(v99)), v97)
                        end

                        if arg37.arguments.Min then
                            v99 = if getValueByIndex(arg37.arguments.Min, index_7, arg37.arguments) ~= 0 then getValueByIndex(
                                arg37.arguments.Min,
                                index_7,
                                arg37.arguments
                            ) else 1
                            v97 = math.max(v97, math.ceil(-math.log10(v99)), v97)
                        end

                        if v97 > 0 then
                            t_24[index_7] = `%.{v97}f`
                        else
                            t_24[index_7] = "%d"
                        end
                    end

                    arg37.arguments.Format = t_24
                    arg37.arguments.Prefix = t_6[arg33]
                end
            else
                t_24 = {}

                for index_8 = 1, n14 do
                    v97 = t_7[arg33][index_8]
                    local _ = n14

                    if arg37.arguments.Increment then
                        v99 = if getValueByIndex(
                            arg37.arguments.Increment,
                            index_8,
                            arg37.arguments
                        ) ~= 0 then getValueByIndex(
                            arg37.arguments.Increment,
                            index_8,
                            arg37.arguments
                        ) else 1
                        v97 = math.max(v97, math.ceil(-math.log10(v99)), v97)
                    end

                    if arg37.arguments.Max then
                        v99 = if getValueByIndex(arg37.arguments.Max, index_8, arg37.arguments) ~= 0 then getValueByIndex(
                            arg37.arguments.Max,
                            index_8,
                            arg37.arguments
                        ) else 1
                        v97 = math.max(v97, math.ceil(-math.log10(v99)), v97)
                    end

                    if arg37.arguments.Min then
                        v99 = if getValueByIndex(arg37.arguments.Min, index_8, arg37.arguments) ~= 0 then getValueByIndex(
                            arg37.arguments.Min,
                            index_8,
                            arg37.arguments
                        ) else 1
                        v97 = math.max(v97, math.ceil(-math.log10(v99)), v97)
                    end

                    if v97 > 0 then
                        t_24[index_8] = `%.{v97}f`
                    else
                        t_24[index_8] = "%d"
                    end
                end

                arg37.arguments.Format = t_24
                arg37.arguments.Prefix = t_6[arg33]
            end

            for index_9 = 1, n14 do
                local _ = n14
                local v106 = v95:FindFirstChild("SliderField" .. tostring(index_9))
                local GrabBar = v106.GrabBar
                local v107 = arg37.arguments.Increment and getValueByIndex(
                    arg37.arguments.Increment,
                    index_9,
                    arg37.arguments
                ) or t_3[arg33][index_9]
                local v108 = arg37.arguments.Min and getValueByIndex(
                    arg37.arguments.Min,
                    index_9,
                    arg37.arguments
                ) or t_4[arg33][index_9]
                local v109 = arg37.arguments.Max and getValueByIndex(
                    arg37.arguments.Max,
                    index_9,
                    arg37.arguments
                ) or t_5[arg33][index_9]
                GrabBar.Size = UDim2.new(
                    math.max(
                        1 / math.floor((v109 + 1 - v108) / v107),
                        arg1._config.GrabMinSize / v106.AbsoluteSize.X
                    ),
                    0,
                    1,
                    0
                )
            end
        end

        function t_20.Discard(arg38) -- line: 1176
            -- upvalues:
            --  [1] arg2 (ref)

            arg38.Instance:Destroy()
            arg2.discardState(arg38)
        end

        function t_20.GenerateState(arg39) -- line: 1180
            -- upvalues:
            --  [1] arg1 (ref)
            --  [2] arg34 (copy)

            if arg39.state.number == nil then
                arg39.state.number = arg1._widgetState(arg39, "number", arg34)
            end

            if arg39.state.editingText == nil then
                arg39.state.editingText = arg1._widgetState(arg39, "editingText", false)
            end
        end

        function t_20.UpdateState(arg40) -- line: 1188
            -- upvalues:
            --  [1] n14 (copy)
            --  [2] getValueByIndex (ref)
            --  [3] t_3 (ref)
            --  [4] arg33 (copy)
            --  [5] t_4 (ref)
            --  [6] t_5 (ref)
            --  [7] arg1 (ref)

            local v111 = arg40.Instance

            for index_10 = 1, n14 do
                local _ = n14
                local v114 = v111:FindFirstChild("SliderField" .. tostring(index_10))
                local InputField_1 = v114.InputField
                local OverlayText = v114.OverlayText
                local GrabBar_1 = v114.GrabBar
                local v115 = getValueByIndex(arg40.state.number.value, index_10, arg40.arguments)
                local v116 = arg40.arguments.Format[index_10] or arg40.arguments.Format[1]

                if arg40.arguments.Prefix then
                    v116 = arg40.arguments.Prefix[index_10] .. v116
                end

                OverlayText.Text = string.format(v116, v115)
                InputField_1.Text = tostring(v115)
                v116 = arg40.arguments.Increment and getValueByIndex(
                    arg40.arguments.Increment,
                    index_10,
                    arg40.arguments
                ) or t_3[arg33][index_10]
                local v117 = arg40.arguments.Min and getValueByIndex(
                    arg40.arguments.Min,
                    index_10,
                    arg40.arguments
                ) or t_4[arg33][index_10]
                local v118 = arg40.arguments.Max and getValueByIndex(
                    arg40.arguments.Max,
                    index_10,
                    arg40.arguments
                ) or t_5[arg33][index_10]
                local v119 = if not (v116 < 1) then 1 else 0
                local X_4 = arg1._config.FramePadding.X
                local v120 = math.floor((v119 + v118 - v117) / v116)
                GrabBar_1.Position = UDim2.new(
                    math.clamp(
                        math.floor((v115 - v117) / (v118 - v117) * v120) / v120,
                        0,
                        1 - GrabBar_1.AbsoluteSize.X / (v114.AbsoluteSize.X - X_4 * 2)
                    ),
                    0,
                    0.5,
                    0
                )

                if arg40.state.editingText.value == index_10 then
                    InputField_1.Visible = true
                    OverlayText.Visible = false
                    GrabBar_1.Visible = false
                    InputField_1:CaptureFocus()
                else
                    InputField_1.Visible = false
                    OverlayText.Visible = true
                    GrabBar_1.Visible = true
                end
            end
        end

        return t_20
    end

    local _ = function(u4: userdata, u5: userdata) --[[ generateEnumSliderScalar ]] -- line: 1238
        -- upvalues:
        --  [1] generateSliderScalar (ref)
        --  [2] arg2 (copy)
        --  [3] arg1 (copy)

        local v122 = generateSliderScalar("Enum", 1, u5.Value)
        local t_25 = { string }

        for _, val in u4:GetEnumItems() do
            t_25[val.Value] = val.Name
        end

        local t_27 = { Args = nil, Update = nil, GenerateState = nil }
        local Extend_1 = arg2.extend
        t_27.Args = { Text = 1 }

        function t_27.Update(arg41) -- line: 1250
            -- upvalues:
            --  [1] u4 (copy)
            --  [2] arg1 (ref)

            local v124 = arg41.Instance
            v124.TextLabel.Text = arg41.arguments.Text or "Input Enum"
            arg41.arguments.Increment = 1
            arg41.arguments.Min = 0
            arg41.arguments.Max = #u4:GetEnumItems() - 1
            local SliderField1 = v124:FindFirstChild("SliderField1")
            local GrabBar_2 = SliderField1.GrabBar
            local v125 = math.max(
                1 / math.floor(#u4:GetEnumItems()),
                arg1._config.GrabMinSize / SliderField1.AbsoluteSize.X
            )
            GrabBar_2.Size = UDim2.new(v125, 0, 1, 0)
        end

        function t_27.GenerateState(arg42) -- line: 1266
            -- upvalues:
            --  [1] arg1 (ref)
            --  [2] u5 (copy)

            if arg42.state.number == nil then
                arg42.state.number = arg1._widgetState(arg42, "number", u5.Value)
            end

            if arg42.state.enumItem == nil then
                arg42.state.enumItem = arg1._widgetState(arg42, "enumItem", u5)
            end

            if arg42.state.editingText == nil then
                arg42.state.editingText = arg1._widgetState(arg42, "editingText", false)
            end
        end

        return Extend_1(v122, t_27)
    end

    local v126 = generateInputScalar("Num", 1, 0)
    local Args = v126.Args
    Args.NoButtons = 6
    arg1.WidgetConstructor("InputNum", v126)
    local WidgetConstructor_1 = arg1.WidgetConstructor
    WidgetConstructor_1("InputVector2", generateInputScalar("Vector2", 2, Vector2.zero))
    local WidgetConstructor_2 = arg1.WidgetConstructor
    WidgetConstructor_2("InputVector3", generateInputScalar("Vector3", 3, Vector3.new(0, 0, 0)))
    local WidgetConstructor_3 = arg1.WidgetConstructor
    WidgetConstructor_3("InputUDim", generateInputScalar("UDim", 2, UDim.new()))
    local WidgetConstructor_4 = arg1.WidgetConstructor
    WidgetConstructor_4("InputUDim2", generateInputScalar("UDim2", 4, UDim2.new()))
    local WidgetConstructor_5 = arg1.WidgetConstructor
    WidgetConstructor_5("InputRect", generateInputScalar("Rect", 4, Rect.new(0, 0, 0, 0)))
    local WidgetConstructor_6 = arg1.WidgetConstructor
    WidgetConstructor_6("DragNum", generateDragScalar("Num", 1, 0))
    local WidgetConstructor_7 = arg1.WidgetConstructor
    WidgetConstructor_7("DragVector2", generateDragScalar("Vector2", 2, Vector2.zero))
    local WidgetConstructor_8 = arg1.WidgetConstructor
    WidgetConstructor_8("DragVector3", generateDragScalar("Vector3", 3, Vector3.new(0, 0, 0)))
    local WidgetConstructor_9 = arg1.WidgetConstructor
    WidgetConstructor_9("DragUDim", generateDragScalar("UDim", 2, UDim.new()))
    local WidgetConstructor_10 = arg1.WidgetConstructor
    WidgetConstructor_10("DragUDim2", generateDragScalar("UDim2", 4, UDim2.new()))
    local WidgetConstructor_11 = arg1.WidgetConstructor
    WidgetConstructor_11("DragRect", generateDragScalar("Rect", 4, Rect.new(0, 0, 0, 0)))
    local WidgetConstructor_12 = arg1.WidgetConstructor
    WidgetConstructor_12("InputColor3", generateColorDragScalar("Color3", Color3.fromRGB(0, 0, 0)))
    local WidgetConstructor_13 = arg1.WidgetConstructor
    WidgetConstructor_13(
        "InputColor4",
        generateColorDragScalar("Color4", Color3.fromRGB(0, 0, 0), 0)
    )
    local WidgetConstructor_14 = arg1.WidgetConstructor
    WidgetConstructor_14("SliderNum", generateSliderScalar("Num", 1, 0))
    local WidgetConstructor_15 = arg1.WidgetConstructor
    WidgetConstructor_15("SliderVector2", generateSliderScalar("Vector2", 2, Vector2.zero))
    local WidgetConstructor_16 = arg1.WidgetConstructor
    WidgetConstructor_16("SliderVector3", generateSliderScalar("Vector3", 3, Vector3.new(0, 0, 0)))
    local WidgetConstructor_17 = arg1.WidgetConstructor
    WidgetConstructor_17("SliderUDim", generateSliderScalar("UDim", 2, UDim.new()))
    local WidgetConstructor_18 = arg1.WidgetConstructor
    WidgetConstructor_18("SliderUDim2", generateSliderScalar("UDim2", 4, UDim2.new()))
    local WidgetConstructor_19 = arg1.WidgetConstructor
    WidgetConstructor_19("SliderRect", generateSliderScalar("Rect", 4, Rect.new(0, 0, 0, 0)))
    local WidgetConstructor_20 = arg1.WidgetConstructor
    local t_28 = {
        hasState = true,
        hasChildren = false,
        Args = { Text = 1, TextHint = 2 },
        Events = nil,
        Generate = nil,
        Update = nil,
        Discard = nil,
        GenerateState = nil,
        UpdateState = nil
    }
    local t_30 = {}
    local t_31 = {
        Init = function(arg43) -- line: 1319
            arg43.lastTextchangeTick = 0
        end
    }

    function t_31.Get(arg44) -- line: 1322
        -- upvalues:
        --  [1] arg1 (copy)

        return arg44.lastTextchangeTick == arg1._cycleTick
    end

    t_30.textChanged = t_31
    t_30.hovered = arg2.EVENTS.hover(function(arg45) -- line: 1326
        return arg45.Instance
    end)
    t_28.Events = t_30

    function t_28.Generate(arg46) -- line: 1330
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)

        local Frame_4 = Instance.new("Frame")
        Frame_4.Name = "Iris_InputText"
        Frame_4.Size = UDim2.new(arg1._config.ContentWidth, UDim.new(0, 0))
        Frame_4.BackgroundTransparency = 1
        Frame_4.BorderSizePixel = 0
        Frame_4.ZIndex = arg46.ZIndex
        Frame_4.LayoutOrder = arg46.ZIndex
        Frame_4.AutomaticSize = Enum.AutomaticSize.Y
        arg2.UIListLayout(
            Frame_4,
            Enum.FillDirection.Horizontal,
            UDim.new(0, arg1._config.ItemInnerSpacing.X)
        )
        local InputField_TextBox_1 = Instance.new("TextBox")
        InputField_TextBox_1.Name = "InputField"
        InputField_TextBox_1.Size = UDim2.new(1, 0, 0, 0)
        InputField_TextBox_1.AutomaticSize = Enum.AutomaticSize.Y
        InputField_TextBox_1.BackgroundColor3 = arg1._config.FrameBgColor
        InputField_TextBox_1.BackgroundTransparency = arg1._config.FrameBgTransparency
        InputField_TextBox_1.Text = ""
        InputField_TextBox_1.PlaceholderColor3 = arg1._config.TextDisabledColor
        InputField_TextBox_1.TextTruncate = Enum.TextTruncate.AtEnd
        InputField_TextBox_1.ClearTextOnFocus = false
        InputField_TextBox_1.ZIndex = arg46.ZIndex + 1
        InputField_TextBox_1.LayoutOrder = arg46.ZIndex + 1
        InputField_TextBox_1.ClipsDescendants = true
        arg2.applyFrameStyle(InputField_TextBox_1)
        arg2.applyTextStyle(InputField_TextBox_1)
        arg2.UISizeConstraint(InputField_TextBox_1, Vector2.new(1, 0))
        InputField_TextBox_1.Parent = Frame_4
        InputField_TextBox_1.FocusLost:Connect(function() -- line: 1362
            -- upvalues:
            --  [1] arg46 (copy)
            --  [2] InputField_TextBox_1 (copy)
            --  [3] arg1 (ref)

            arg46.state.text:set(InputField_TextBox_1.Text)
            arg46.lastTextchangeTick = arg1._cycleTick + 1
        end)
        local v192 = arg1._config.TextSize + arg1._config.FramePadding.Y * 2
        local TextLabel_7 = Instance.new("TextLabel")
        TextLabel_7.Name = "TextLabel"
        TextLabel_7.Size = UDim2.fromOffset(0, v192)
        TextLabel_7.AutomaticSize = Enum.AutomaticSize.X
        TextLabel_7.BackgroundTransparency = 1
        TextLabel_7.BorderSizePixel = 0
        TextLabel_7.ZIndex = arg46.ZIndex + 4
        TextLabel_7.LayoutOrder = arg46.ZIndex + 4
        arg2.applyTextStyle(TextLabel_7)
        TextLabel_7.Parent = Frame_4

        return Frame_4
    end

    function t_28.Update(arg47) -- line: 1384
        local v193 = arg47.Instance
        local InputField_2 = v193.InputField
        v193.TextLabel.Text = arg47.arguments.Text or "Input Text"
        InputField_2.PlaceholderText = arg47.arguments.TextHint or ""
    end

    function t_28.Discard(arg48) -- line: 1392
        -- upvalues:
        --  [1] arg2 (copy)

        arg48.Instance:Destroy()
        arg2.discardState(arg48)
    end

    function t_28.GenerateState(arg49) -- line: 1396
        -- upvalues:
        --  [1] arg1 (copy)

        if arg49.state.text == nil then
            arg49.state.text = arg1._widgetState(arg49, "text", "")
        end
    end

    function t_28.UpdateState(arg50) -- line: 1401
        arg50.Instance.InputField.Text = arg50.state.text.value
    end

    WidgetConstructor_20("InputText", t_28)
end
