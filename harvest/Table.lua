-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Table
-- Class: ModuleScript
-- bytes: 6463

local _ = require(script.Parent.Parent.Types)

return function(arg1, arg2) -- line: 3
    local t = {}
    table.insert(arg1._postCycleCallbacks, function() -- line: 7
        -- upvalues:
        --  [1] t (copy)

        for _, val in t do
            val.RowColumnIndex = 0
        end
    end)
    local t_1 = {
        hasState = false,
        hasChildren = true,
        Args = nil,
        Events = nil,
        Generate = nil,
        Update = nil,
        Discard = nil,
        ChildAdded = nil
    }
    local WidgetConstructor = arg1.WidgetConstructor
    t_1.Args = { NumColumns = 1, RowBg = 2, BordersOuter = 3, BordersInner = 4 }
    t_1.Events = {
        hovered = arg2.EVENTS.hover(function(arg3) -- line: 23
            return arg3.Instance
        end)
    }

    function t_1.Generate(arg4) -- line: 27
        -- upvalues:
        --  [1] t (copy)
        --  [2] arg1 (copy)
        --  [3] arg2 (copy)

        t[arg4.ID] = arg4
        arg4.InitialNumColumns = -1
        arg4.RowColumnIndex = 0
        arg4.ColumnInstances = {}
        arg4.CellInstances = {}
        local IrisTable_Frame = Instance.new("Frame")
        IrisTable_Frame.Name = "Iris_Table"
        IrisTable_Frame.Size = UDim2.new(arg1._config.ItemWidth, UDim.new(0, 0))
        IrisTable_Frame.AutomaticSize = Enum.AutomaticSize.Y
        IrisTable_Frame.BackgroundTransparency = 1
        IrisTable_Frame.BorderSizePixel = 0
        IrisTable_Frame.ZIndex = arg4.ZIndex + 1024
        IrisTable_Frame.LayoutOrder = arg4.ZIndex
        IrisTable_Frame.ClipsDescendants = true
        arg2.UIListLayout(IrisTable_Frame, Enum.FillDirection.Horizontal, UDim.new(0, 0))
        arg2.UIStroke(
            IrisTable_Frame,
            1,
            arg1._config.TableBorderStrongColor,
            arg1._config.TableBorderStrongTransparency
        )

        return IrisTable_Frame
    end

    function t_1.Update(arg5) -- line: 51
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] arg1 (copy)

        local v1 = arg5.Instance

        if arg5.arguments.BordersOuter == false then
            v1.UIStroke.Thickness = 0
        else
            v1.UIStroke.Thickness = 1
        end

        if arg5.InitialNumColumns == -1 then
            if arg5.arguments.NumColumns == nil then
                error("Iris.Table NumColumns argument is required", 5)
            end

            arg5.InitialNumColumns = arg5.arguments.NumColumns

            for index = 1, arg5.InitialNumColumns do
                local v2 = arg5.ZIndex + 1 + index
                local _ = arg5.InitialNumColumns
                local Frame_1 = Instance.new("Frame")
                Frame_1.Name = `Column_{index}`
                Frame_1.Size = UDim2.new(1 / arg5.InitialNumColumns, 0, 0, 0)
                Frame_1.AutomaticSize = Enum.AutomaticSize.Y
                Frame_1.BackgroundTransparency = 1
                Frame_1.BorderSizePixel = 0
                Frame_1.ZIndex = v2
                Frame_1.LayoutOrder = v2
                Frame_1.ClipsDescendants = true
                arg2.UIListLayout(Frame_1, Enum.FillDirection.Vertical, UDim.new(0, 0))
                arg5.ColumnInstances[index] = Frame_1
                Frame_1.Parent = v1
            end
        elseif arg5.arguments.NumColumns ~= arg5.InitialNumColumns then
            error("Iris.Table NumColumns Argument must be static")
        end

        if arg5.arguments.RowBg == false then
            for _, val_1 in arg5.CellInstances do
                val_1.BackgroundTransparency = 1
            end
        else
            for key_2, val_2 in arg5.CellInstances do
                val_2.BackgroundTransparency = if math.ceil(key_2 / arg5.InitialNumColumns) % 2 == 0 then arg1._config.TableRowBgAltTransparency else arg1._config.TableRowBgTransparency
            end
        end

        if arg5.arguments.BordersInner == false then
            for _, val_3 in arg5.CellInstances do
                val_3.UIStroke.Thickness = 0
            end

            return
        end

        for _, val_4 in arg5.CellInstances do
            val_4.UIStroke.Thickness = 0.5
        end
    end

    function t_1.Discard(arg6) -- line: 113
        -- upvalues:
        --  [1] t (copy)

        t[arg6.ID] = nil
        arg6.Instance:Destroy()
    end

    function t_1.ChildAdded(arg7) -- line: 117
        -- upvalues:
        --  [1] arg2 (copy)
        --  [2] arg1 (copy)

        if arg7.RowColumnIndex == 0 then
            arg7.RowColumnIndex = 1
        end

        local v4 = arg7.CellInstances[arg7.RowColumnIndex]

        if v4 then
            return v4
        end

        local v5 = arg7.ColumnInstances[(arg7.RowColumnIndex - 1) % arg7.InitialNumColumns + 1]
        local v6 = v5.ZIndex + arg7.RowColumnIndex
        local Frame_2 = Instance.new("Frame")
        Frame_2.Name = `Cell_{arg7.RowColumnIndex}`
        Frame_2.Size = UDim2.new(1, 0, 0, 0)
        Frame_2.AutomaticSize = Enum.AutomaticSize.Y
        Frame_2.BackgroundTransparency = 1
        Frame_2.BorderSizePixel = 0
        Frame_2.ZIndex = v6
        Frame_2.LayoutOrder = v6
        Frame_2.ClipsDescendants = true
        arg2.UIPadding(Frame_2, arg1._config.CellPadding)
        arg2.UIListLayout(
            Frame_2,
            Enum.FillDirection.Vertical,
            UDim.new(0, arg1._config.ItemSpacing.Y)
        )

        if arg7.arguments.BordersInner == false then
            arg2.UIStroke(
                Frame_2,
                0,
                arg1._config.TableBorderLightColor,
                arg1._config.TableBorderLightTransparency
            )
        else
            arg2.UIStroke(
                Frame_2,
                0.5,
                arg1._config.TableBorderLightColor,
                arg1._config.TableBorderLightTransparency
            )
        end

        if arg7.arguments.RowBg ~= false then
            local v7 = math.ceil(arg7.RowColumnIndex / arg7.InitialNumColumns)
            local v8 = if v7 % 2 == 0 then arg1._config.TableRowBgAltColor else arg1._config.TableRowBgColor
            local v9 = if v7 % 2 ~= 0 then arg1._config.TableRowBgTransparency else arg1._config.TableRowBgAltTransparency
            Frame_2.BackgroundColor3 = v8
            Frame_2.BackgroundTransparency = v9
        end

        arg7.CellInstances[arg7.RowColumnIndex] = Frame_2
        Frame_2.Parent = v5

        return Frame_2
    end

    WidgetConstructor("Table", t_1)
end
