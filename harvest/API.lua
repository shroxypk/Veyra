-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.API
-- Class: ModuleScript
-- bytes: 12067

local _ = require(script.Parent.Types)

return function(arg1) -- line: 3
    local _ = function(s1: string) --[[ wrapper ]] -- line: 5
        -- upvalues:
        --  [1] arg1 (copy)

        return function(arg2, arg3) -- line: 6
            -- upvalues:
            --  [1] arg1 (ref)
            --  [2] s1 (copy)

            return arg1.Internal._Insert(s1, arg2, arg3)
        end
    end

    local v1 = "Window"

    function arg1.Window(arg4, arg5) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v1 (copy)

        return arg1.Internal._Insert(v1, arg4, arg5)
    end

    arg1.SetFocusedWindow = arg1.Internal.SetFocusedWindow
    local v2 = "Tooltip"

    function arg1.Tooltip(arg6, arg7) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v2 (copy)

        return arg1.Internal._Insert(v2, arg6, arg7)
    end

    local v3 = "MenuBar"

    function arg1.MenuBar(arg8, arg9) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v3 (copy)

        return arg1.Internal._Insert(v3, arg8, arg9)
    end

    local v4 = "Menu"

    function arg1.Menu(arg10, arg11) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v4 (copy)

        return arg1.Internal._Insert(v4, arg10, arg11)
    end

    local v5 = "MenuItem"

    function arg1.MenuItem(arg12, arg13) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v5 (copy)

        return arg1.Internal._Insert(v5, arg12, arg13)
    end

    local v6 = "MenuToggle"

    function arg1.MenuToggle(arg14, arg15) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v6 (copy)

        return arg1.Internal._Insert(v6, arg14, arg15)
    end

    local v7 = "Separator"

    function arg1.Separator(arg16, arg17) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v7 (copy)

        return arg1.Internal._Insert(v7, arg16, arg17)
    end

    local v8 = "Indent"

    function arg1.Indent(arg18, arg19) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v8 (copy)

        return arg1.Internal._Insert(v8, arg18, arg19)
    end

    local v9 = "SameLine"

    function arg1.SameLine(arg20, arg21) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v9 (copy)

        return arg1.Internal._Insert(v9, arg20, arg21)
    end

    local v10 = "Group"

    function arg1.Group(arg22, arg23) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v10 (copy)

        return arg1.Internal._Insert(v10, arg22, arg23)
    end

    local v11 = "Text"

    function arg1.Text(arg24, arg25) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v11 (copy)

        return arg1.Internal._Insert(v11, arg24, arg25)
    end

    function arg1.TextWrapped(arg26) -- line: 41
        -- upvalues:
        --  [1] arg1 (copy)

        arg26[2] = true

        return arg1.Internal._Insert("Text", arg26)
    end

    function arg1.TextColored(arg27) -- line: 46
        -- upvalues:
        --  [1] arg1 (copy)

        arg27[3] = arg27[2]
        arg27[2] = nil

        return arg1.Internal._Insert("Text", arg27)
    end

    local v12 = "SeparatorText"

    function arg1.SeparatorText(arg28, arg29) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v12 (copy)

        return arg1.Internal._Insert(v12, arg28, arg29)
    end

    local v13 = "InputText"

    function arg1.InputText(arg30, arg31) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v13 (copy)

        return arg1.Internal._Insert(v13, arg30, arg31)
    end

    local v14 = "Button"

    function arg1.Button(arg32, arg33) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v14 (copy)

        return arg1.Internal._Insert(v14, arg32, arg33)
    end

    local v15 = "SmallButton"

    function arg1.SmallButton(arg34, arg35) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v15 (copy)

        return arg1.Internal._Insert(v15, arg34, arg35)
    end

    local v16 = "Checkbox"

    function arg1.Checkbox(arg36, arg37) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v16 (copy)

        return arg1.Internal._Insert(v16, arg36, arg37)
    end

    local v17 = "RadioButton"

    function arg1.RadioButton(arg38, arg39) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v17 (copy)

        return arg1.Internal._Insert(v17, arg38, arg39)
    end

    local v18 = "Tree"

    function arg1.Tree(arg40, arg41) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v18 (copy)

        return arg1.Internal._Insert(v18, arg40, arg41)
    end

    local v19 = "CollapsingHeader"

    function arg1.CollapsingHeader(arg42, arg43) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v19 (copy)

        return arg1.Internal._Insert(v19, arg42, arg43)
    end

    local v20 = "InputNum"

    function arg1.InputNum(arg44, arg45) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v20 (copy)

        return arg1.Internal._Insert(v20, arg44, arg45)
    end

    local v21 = "InputVector2"

    function arg1.InputVector2(arg46, arg47) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v21 (copy)

        return arg1.Internal._Insert(v21, arg46, arg47)
    end

    local v22 = "InputVector3"

    function arg1.InputVector3(arg48, arg49) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v22 (copy)

        return arg1.Internal._Insert(v22, arg48, arg49)
    end

    local v23 = "InputUDim"

    function arg1.InputUDim(arg50, arg51) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v23 (copy)

        return arg1.Internal._Insert(v23, arg50, arg51)
    end

    local v24 = "InputUDim2"

    function arg1.InputUDim2(arg52, arg53) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v24 (copy)

        return arg1.Internal._Insert(v24, arg52, arg53)
    end

    local v25 = "InputRect"

    function arg1.InputRect(arg54, arg55) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v25 (copy)

        return arg1.Internal._Insert(v25, arg54, arg55)
    end

    local v26 = "DragNum"

    function arg1.DragNum(arg56, arg57) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v26 (copy)

        return arg1.Internal._Insert(v26, arg56, arg57)
    end

    local v27 = "DragVector2"

    function arg1.DragVector2(arg58, arg59) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v27 (copy)

        return arg1.Internal._Insert(v27, arg58, arg59)
    end

    local v28 = "DragVector3"

    function arg1.DragVector3(arg60, arg61) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v28 (copy)

        return arg1.Internal._Insert(v28, arg60, arg61)
    end

    local v29 = "DragUDim"

    function arg1.DragUDim(arg62, arg63) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v29 (copy)

        return arg1.Internal._Insert(v29, arg62, arg63)
    end

    local v30 = "DragUDim2"

    function arg1.DragUDim2(arg64, arg65) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v30 (copy)

        return arg1.Internal._Insert(v30, arg64, arg65)
    end

    local v31 = "DragRect"

    function arg1.DragRect(arg66, arg67) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v31 (copy)

        return arg1.Internal._Insert(v31, arg66, arg67)
    end

    local v32 = "InputColor3"

    function arg1.InputColor3(arg68, arg69) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v32 (copy)

        return arg1.Internal._Insert(v32, arg68, arg69)
    end

    local v33 = "InputColor4"

    function arg1.InputColor4(arg70, arg71) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v33 (copy)

        return arg1.Internal._Insert(v33, arg70, arg71)
    end

    local v34 = "SliderNum"

    function arg1.SliderNum(arg72, arg73) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v34 (copy)

        return arg1.Internal._Insert(v34, arg72, arg73)
    end

    local v35 = "SliderVector2"

    function arg1.SliderVector2(arg74, arg75) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v35 (copy)

        return arg1.Internal._Insert(v35, arg74, arg75)
    end

    local v36 = "SliderVector3"

    function arg1.SliderVector3(arg76, arg77) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v36 (copy)

        return arg1.Internal._Insert(v36, arg76, arg77)
    end

    local v37 = "SliderUDim"

    function arg1.SliderUDim(arg78, arg79) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v37 (copy)

        return arg1.Internal._Insert(v37, arg78, arg79)
    end

    local v38 = "SliderUDim2"

    function arg1.SliderUDim2(arg80, arg81) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v38 (copy)

        return arg1.Internal._Insert(v38, arg80, arg81)
    end

    local v39 = "SliderRect"

    function arg1.SliderRect(arg82, arg83) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v39 (copy)

        return arg1.Internal._Insert(v39, arg82, arg83)
    end

    local v40 = "Selectable"

    function arg1.Selectable(arg84, arg85) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v40 (copy)

        return arg1.Internal._Insert(v40, arg84, arg85)
    end

    local v41 = "Combo"

    function arg1.Combo(arg86, arg87) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v41 (copy)

        return arg1.Internal._Insert(v41, arg86, arg87)
    end

    function arg1.ComboArray(arg88: any, arg89: any, t1: table) -- line: 112
        -- upvalues:
        --  [1] arg1 (copy)

        local v42 = if arg89 ~= nil then arg89 else arg1.State(t1[1])
        local v43 = arg1.Internal._Insert("Combo", arg88, v42)
        v42 = v43.state.index

        for _, val in t1 do
            arg1.Internal._Insert("Selectable", { val, val }, { index = v42 })
        end

        arg1.End()

        return v43
    end

    function arg1.ComboEnum(arg90: any, arg91: any, u1: userdata) -- line: 129
        -- upvalues:
        --  [1] arg1 (copy)

        local v44 = if arg91 ~= nil then arg91 else arg1.State(u1[1])
        local v45 = arg1.Internal._Insert("Combo", arg90, v44)
        v44 = v45.state.index

        for _, val_1 in u1:GetEnumItems() do
            arg1.Internal._Insert("Selectable", { val_1.Name, val_1 }, { index = v44 })
        end

        arg1.End()

        return v45
    end

    arg1.InputEnum = arg1.ComboEnum
    local v46 = "Table"

    function arg1.Table(arg92, arg93) -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v46 (copy)

        return arg1.Internal._Insert(v46, arg92, arg93)
    end

    function arg1.NextColumn() -- line: 149
        -- upvalues:
        --  [1] arg1 (copy)

        local v47 = arg1.Internal._GetParentWidget()
        v47.RowColumnIndex += 1
    end

    function arg1.SetColumnIndex(n1: number) -- line: 153
        -- upvalues:
        --  [1] arg1 (copy)

        local v48 = arg1.Internal._GetParentWidget()
        assert(n1 >= v48.InitialNumColumns, "Iris.SetColumnIndex Argument must be in column range")
        v48.RowColumnIndex = math.floor(v48.RowColumnIndex / v48.InitialNumColumns) + (n1 - 1)
    end

    function arg1.NextRow() -- line: 159
        -- upvalues:
        --  [1] arg1 (copy)

        local v50 = arg1.Internal._GetParentWidget()
        local InitialNumColumns = v50.InitialNumColumns
        v50.RowColumnIndex = math.floor((v50.RowColumnIndex + 1) / InitialNumColumns) * InitialNumColumns
    end
end
