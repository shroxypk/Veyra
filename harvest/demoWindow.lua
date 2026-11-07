-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.demoWindow
-- Class: ModuleScript
-- bytes: 43071

local _ = require(script.Parent.Types)

return function(arg1) -- line: 3
    local v1 = arg1.State(true)
    local v2 = arg1.State(false)
    local v3 = arg1.State(false)
    local v4 = arg1.State(false)
    local v5 = arg1.State(false)
    local v6 = arg1.State(false)

    local function helpMarker(arg2) -- line: 12
        -- upvalues:
        --  [1] arg1 (copy)

        arg1.PushConfig({ TextColor = arg1._config.TextDisabledColor })
        local v7 = arg1.Text({ "(?)" })
        arg1.PopConfig()
        local t_1 = { ContentWidth = UDim.new(0, 350) }
        arg1.PushConfig(t_1)

        if v7.hovered() then
            arg1.Tooltip({ arg2 })
        end

        arg1.PopConfig()
    end

    local t_2 = {
        Basic = nil,
        Tree = nil,
        CollapsingHeader = nil,
        Group = nil,
        Indent = nil,
        Input = nil,
        InputText = nil,
        MultiInput = nil,
        Tooltip = nil,
        Selectable = nil,
        Combo = nil
    }

    function t_2.Basic() -- line: 26
        -- upvalues:
        --  [1] arg1 (copy)

        arg1.Tree({ "Basic" })
        arg1.SeparatorText({ "Basic" })
        local v8 = arg1.State(1)
        arg1.Button({ "Button" })
        arg1.SmallButton({ "SmallButton" })
        arg1.Text({ "Text" })
        arg1.TextWrapped({ "Text Wrapped Text Wrapped Text Wrapped Text Wrapped Text Wrapped " })
        arg1.TextColored({ "Colored Text", Color3.fromRGB(255, 128, 0) })
        arg1.Text(
            {
                "Rich Text: <b>bold text</b> <i>italic text</i> <u>underline text</u> <s>strikethrough text</s> <font color= \"rgb(240, 40, 10)\">red text</font> <font size=\"32\">bigger text</font>",
                true,
                nil,
                true
            }
        )
        arg1.SameLine()
        arg1.RadioButton({ "Index '1'", 1 }, { index = v8 })
        arg1.RadioButton({ "Index 'two'", "two" }, { index = v8 })

        if arg1.RadioButton({ "Index 'false'", false }, { index = v8 }).active() == false and arg1.SmallButton(
            { "Select last" }
        ).clicked() then
            v8:set(false)
        end

        arg1.End()
        arg1.Text({ "The Index is: " .. tostring(v8.value) })
        arg1.SeparatorText({ "Inputs" })
        arg1.InputNum({})
        arg1.DragNum({})
        arg1.SliderNum({})
        arg1.End()
    end

    function t_2.Tree() -- line: 57
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] helpMarker (copy)

        arg1.Tree({ "Trees" })
        arg1.Tree({ "Tree using SpanAvailWidth", [arg1.Args.Tree.SpanAvailWidth] = true })
        helpMarker(
            "SpanAvailWidth determines if the Tree is selectable from its entire with, or only the text area"
        )
        arg1.End()
        local v9 = arg1.Tree({ "Tree with Children" })
        arg1.Text({ "Im inside the first tree!" })
        arg1.Button({ "Im a button inside the first tree!" })
        arg1.Tree({ "Im a tree inside the first tree!" })
        arg1.Text({ "I am the innermost text!" })
        arg1.End()
        arg1.End()
        arg1.Checkbox({ "Toggle above tree" }, { isChecked = v9.state.isUncollapsed })
        arg1.End()
    end

    function t_2.CollapsingHeader() -- line: 76
        -- upvalues:
        --  [1] arg1 (copy)

        arg1.Tree({ "Collapsing Headers" })
        arg1.CollapsingHeader({ "A header" })
        arg1.Text({ "This is under the first header!" })
        arg1.End()
        local v10 = arg1.State(true)
        arg1.CollapsingHeader({ "Another header" }, { isUncollapsed = v10 })

        if arg1.Button({ "Shhh... secret button!" }).clicked() then
            v10:set(true)
        end

        arg1.End()
        arg1.End()
    end

    function t_2.Group() -- line: 91
        -- upvalues:
        --  [1] arg1 (copy)

        arg1.Tree({ "Groups" })
        arg1.SameLine()
        arg1.Group()
        arg1.Text({ "I am in group A" })
        arg1.Button({ "Im also in A" })
        arg1.End()
        arg1.Separator()
        arg1.Group()
        arg1.Text({ "I am in group B" })
        arg1.Button({ "Im also in B" })
        arg1.Button({ "Also group B" })
        arg1.End()
        arg1.End()
        arg1.End()
    end

    function t_2.Indent() -- line: 110
        -- upvalues:
        --  [1] arg1 (copy)

        arg1.Tree({ "Indents" })
        arg1.Text({ "Not Indented" })
        arg1.Indent()
        arg1.Text({ "Indented" })
        arg1.Indent({ 7 })
        arg1.Text({ "Indented by 7 more pixels" })
        arg1.End()
        arg1.Indent({ -7 })
        arg1.Text({ "Indented by 7 less pixels" })
        arg1.End()
        arg1.End()
        arg1.End()
    end

    function t_2.Input() -- line: 126
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] helpMarker (copy)

        arg1.Tree({ "Input" })
        local v11 = arg1.State(false)
        local v12 = arg1.State(0)
        local v13 = arg1.State(100)
        local v14 = arg1.State(1)
        local v15 = arg1.State("%d")
        local t_12 = { ContentWidth = UDim.new(1, -120) }
        arg1.PushConfig(t_12)
        local v16 = arg1.InputNum(
            {
                "Input Number",
                [arg1.Args.InputNum.NoButtons] = v11.value,
                [arg1.Args.InputNum.Min] = v12.value,
                [arg1.Args.InputNum.Max] = v13.value,
                [arg1.Args.InputNum.Increment] = v14.value,
                [arg1.Args.InputNum.Format] = { v15.value }
            }
        )
        arg1.PopConfig()
        arg1.Text({ "The Value is: " .. v16.number.value })
        local v17 = arg1.State(false)

        if arg1.Button({ "Randomize Number" }).clicked() then
            v16.number:set(math.random(1, 99))
        end

        local v18 = arg1.Checkbox({ "NoField" }, { isChecked = v17 })
        local v19 = arg1.Checkbox({ "NoButtons" }, { isChecked = v11 })

        if v18.checked() and v19.isChecked.value == true then
            v19.isChecked:set(false)
        end

        if v19.checked() and v18.isChecked.value == true then
            v18.isChecked:set(false)
        end

        local t_16 = { ContentWidth = UDim.new(1, -120) }
        arg1.PushConfig(t_16)
        arg1.InputVector2({ "InputVector2" })
        arg1.InputVector3({ "InputVector3" })
        arg1.InputUDim({ "InputUDim" })
        arg1.InputUDim2({ "InputUDim2" })
        local v20 = arg1.State(false)
        local v21 = arg1.State(false)
        local v22 = arg1.State(Color3.new())
        local v23 = arg1.State(0)
        arg1.SliderNum({ "Transparency", 0.01, 0, 1 }, { number = v23 })
        arg1.InputColor3({ "InputColor3", v20:get(), v21:get() }, { color = v22 })
        arg1.InputColor4(
            { "InputColor4", v20:get(), v21:get() },
            { color = v22, transparency = v23 }
        )
        arg1.SameLine()
        arg1.Text({ v22:get():ToHex() })
        arg1.Checkbox({ "Use Floats" }, { isChecked = v20 })
        arg1.Checkbox({ "Use HSV" }, { isChecked = v21 })
        arg1.End()
        arg1.PopConfig()
        arg1.Separator()
        arg1.SameLine()
        arg1.Text({ "Slider Numbers" })
        helpMarker("ctrl + click slider number widgets to input a number")
        arg1.End()
        local t_25 = { ContentWidth = UDim.new(1, -120) }
        arg1.PushConfig(t_25)
        arg1.SliderNum({ "Slide Int", 1, 1, 8 })
        arg1.SliderNum({ "Slide Float", 0.01, 0, 100 })
        arg1.SliderNum({ "Small Numbers", 0.001, -2, 1, "%f radians" })
        arg1.SliderNum({ "Odd Ranges", 0.001, -3.141592653589793, 3.141592653589793, "%f radians" })
        arg1.SliderNum({ "Big Numbers", 10000, 100000, 10000000 })
        arg1.SliderNum({ "Few Numbers", 1, 0, 3 })
        arg1.PopConfig()
        arg1.Separator()
        arg1.SameLine()
        arg1.Text({ "Drag Numbers" })
        helpMarker(
            "ctrl + click or double click drag number widgets to input a number, hold shift/alt while dragging to increase/decrease speed"
        )
        arg1.End()
        local t_26 = { ContentWidth = UDim.new(1, -120) }
        arg1.PushConfig(t_26)
        arg1.DragNum({ "Drag Int" })
        arg1.DragNum({ "Slide Float", 0.001, -10, 10 })
        arg1.DragNum({ "Percentage", 1, 0, 100, "%d %%" })
        arg1.PopConfig()
        arg1.End()
    end

    function t_2.InputText() -- line: 203
        -- upvalues:
        --  [1] arg1 (copy)

        arg1.Tree({ "Input Text" })
        local t_27 = { ContentWidth = UDim.new(0, 250) }
        arg1.PushConfig(t_27)
        local v26 = arg1.InputText(
            { "Input Text Test", [arg1.Args.InputText.TextHint] = "Input Text here" }
        )
        arg1.PopConfig()
        arg1.Text({ "The text is: " .. v26.text.value })
        arg1.End()
    end

    function t_2.MultiInput() -- line: 212
        -- upvalues:
        --  [1] arg1 (copy)

        arg1.Tree({ "Multi-Component Input" })
        local v27 = arg1.State(Vector2.new())
        local v28 = arg1.State((Vector3.new()))
        local v29 = arg1.State(UDim.new())
        local v30 = arg1.State(UDim2.new())
        local v31 = arg1.State(Color3.new())
        local v32 = arg1.State(Rect.new(0, 0))
        arg1.SeparatorText({ "Input" })
        arg1.InputVector2({}, { number = v27 })
        arg1.InputVector3({}, { number = v28 })
        arg1.InputUDim({}, { number = v29 })
        arg1.InputUDim2({}, { number = v30 })
        arg1.InputRect({}, { number = v32 })
        arg1.SeparatorText({ "Drag" })
        arg1.DragVector2({}, { number = v27 })
        arg1.DragVector3({}, { number = v28 })
        arg1.DragUDim({}, { number = v29 })
        arg1.DragUDim2({}, { number = v30 })
        arg1.DragRect({}, { number = v32 })
        arg1.SeparatorText({ "Slider" })
        arg1.SliderVector2({}, { number = v27 })
        arg1.SliderVector3({}, { number = v28 })
        arg1.SliderUDim({}, { number = v29 })
        arg1.SliderUDim2({}, { number = v30 })
        arg1.SliderRect({}, { number = v32 })
        arg1.SeparatorText({ "Color" })
        arg1.InputColor3({}, { color = v31 })
        arg1.InputColor4({}, { color = v31 })
        arg1.End()
    end

    function t_2.Tooltip() -- line: 254
        -- upvalues:
        --  [1] arg1 (copy)

        local t_46 = { ContentWidth = UDim.new(0, 250) }
        arg1.PushConfig(t_46)
        arg1.Tree({ "Tooltip" })

        if arg1.Text({ "Hover over me to reveal a tooltip" }).hovered() then
            arg1.Tooltip({ "I am some helpful tooltip text" })
        end

        local v33 = arg1.State("Hello ")
        local v34 = arg1.State(1)

        if arg1.InputNum({ "# of repeat", 1, 1, 50 }, { number = v34 }).numberChanged() then
            v33:set(string.rep("Hello ", v34:get()))
        end

        if arg1.Checkbox({ "Show dynamic text tooltip" }).isChecked.value then
            arg1.Tooltip({ v33:get() })
        end

        arg1.End()
        arg1.PopConfig()
    end

    function t_2.Selectable() -- line: 272
        -- upvalues:
        --  [1] arg1 (copy)

        arg1.Tree({ "Selectable" })
        local v35 = arg1.State(2)
        arg1.Selectable({ "Selectable #1", 1 }, { index = v35 })
        arg1.Selectable({ "Selectable #2", 2 }, { index = v35 })

        if arg1.Selectable({ "Double click Selectable", 3, true }, { index = v35 }).doubleClicked() then
            v35:set(3)
        end

        arg1.Selectable({ "Impossible to select", 4, true }, { index = v35 })

        if arg1.Button({ "Select last" }).clicked() then
            v35:set(4)
        end

        arg1.Selectable({ "Independent Selectable" })
        arg1.End()
    end

    function t_2.Combo() -- line: 288
        -- upvalues:
        --  [1] arg1 (copy)

        arg1.Tree({ "Combo" })
        local t_53 = { ContentWidth = UDim.new(1, -120) }
        arg1.PushConfig(t_53)
        local v36 = arg1.State("No Selection")
        arg1.SameLine()
        local v37 = arg1.Checkbox({ "No Preview" })
        local v38 = arg1.Checkbox({ "No Button" })

        if v37.checked() and v38.isChecked.value == true then
            v38.isChecked:set(false)
        end

        if v38.checked() and v37.isChecked.value == true then
            v37.isChecked:set(false)
        end

        arg1.End()
        arg1.Combo({ "Basic Usage", v38.isChecked:get(), v37.isChecked:get() }, { index = v36 })
        arg1.Selectable({ "Select 1", "One" }, { index = v36 })
        arg1.Selectable({ "Select 2", "Two" }, { index = v36 })
        arg1.Selectable({ "Select 3", "Three" }, { index = v36 })
        arg1.End()
        arg1.ComboArray(
            { "Using ComboArray" },
            { index = "No Selection" },
            { "Red", "Green", "Blue" }
        )
        local v40 = arg1.State("7 AM")
        arg1.Combo({ "Combo with Inner widgets" }, { index = v40 })
        arg1.Tree({ "Morning Shifts" })
        arg1.Selectable({ "Shift at 7 AM", "7 AM" }, { index = v40 })
        arg1.Selectable({ "Shift at 11 AM", "11 AM" }, { index = v40 })
        arg1.Selectable({ "Shist at 3 PM", "3 PM" }, { index = v40 })
        arg1.End()
        arg1.Tree({ "Night Shifts" })
        arg1.Selectable({ "Shift at 6 PM", "6 PM" }, { index = v40 })
        arg1.Selectable({ "Shift at 9 PM", "9 PM" }, { index = v40 })
        arg1.End()
        arg1.End()
        local v41 = arg1.ComboEnum(
            { "Using ComboEnum" },
            { index = Enum.UserInputState.Begin },
            Enum.UserInputState
        )
        arg1.Text({ "Selected: " .. v41.index:get().Name })
        arg1.PopConfig()
        arg1.End()
    end

    local function recursiveTree() -- line: 331
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] recursiveTree (copy)

        if arg1.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
            recursiveTree()
        end

        arg1.End()
    end

    local function recursiveWindow(arg3) -- line: 339
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] recursiveWindow (copy)

        local t_67 = { size = nil, isOpened = nil }
        local Window = arg1.Window
        t_67.size = arg1.State(Vector2.new(175, 100))
        t_67.isOpened = arg3
        Window({ "Recursive Window" }, t_67)
        local v42 = arg1.Checkbox({ "Recurse Again" })
        arg1.End()

        if v42.isChecked.value then
            recursiveWindow(v42.isChecked)
        end
    end

    local function runtimeInfo() -- line: 349
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v3 (copy)
        --  [3] helpMarker (copy)

        local v43 = arg1.Window({ "Runtime Info" }, { isOpened = v3 })
        local LastVDOM = arg1.Internal._lastVDOM
        local States = arg1.Internal._states
        local v44 = arg1.State(3)
        local v45 = arg1.State(0)
        local v46 = arg1.State(os.clock())
        arg1.SameLine()
        arg1.InputNum(
            { "", [arg1.Args.InputNum.Format] = "%d Seconds", [arg1.Args.InputNum.Max] = 10 },
            { number = v44 }
        )

        if arg1.Button({ "Disable" }).clicked() then
            arg1.Disabled = true
            task.delay(v44:get(), function() -- line: 362
                -- upvalues:
                --  [1] arg1 (ref)

                arg1.Disabled = false
            end)
        end

        arg1.End()
        local v48 = os.clock()
        v45.value += (v48 - v46.value - v45.value) * 0.2
        v46.value = v48
        arg1.Text(
            { string.format("Average %.3f ms/frame (%.1f FPS)", v45.value * 1000, 1 / v45.value) }
        )
        arg1.Text(
            {
                string.format(
                    "Window Position: (%d, %d), Window Size: (%d, %d)",
                    v43.position.value.X,
                    v43.position.value.Y,
                    v43.size.value.X,
                    v43.size.value.Y
                )
            }
        )
        arg1.SameLine()
        arg1.Text({ "Enter an ID to learn more about it." })
        helpMarker(
            "every widget and state has an ID which Iris tracks to remember which widget is which. below lists all widgets and states, with their respective IDs"
        )
        arg1.End()
        local t_74 = { ItemWidth = UDim.new(1, -150) }
        arg1.PushConfig(t_74)
        local t_75 = { text = arg1.State(v43.ID) }
        local v49 = arg1.InputText({ "ID field" }, t_75).text.value
        arg1.PopConfig()
        arg1.Indent()
        local v50 = LastVDOM[v49]
        local v51 = States[v49]

        if v50 then
            arg1.Table({ 1, [arg1.Args.Table.RowBg] = false })
            arg1.Text({ string.format("The ID, \"%s\", is a widget", v49) })
            arg1.NextRow()
            arg1.Text({ string.format("Widget is type: %s", v50.type) })
            arg1.NextRow()
            arg1.Tree({ "Widget has Args:" }, { isUncollapsed = arg1.State(true) })

            for key, val in v50.arguments do
                arg1.Text({ key .. " - " .. tostring(val) })
            end

            arg1.End()
            arg1.NextRow()

            if v50.state then
                arg1.Tree({ "Widget has State:" }, { isUncollapsed = arg1.State(true) })

                for key_1, val_1 in v50.state do
                    arg1.Text({ key_1 .. " - " .. tostring(val_1.value) })
                end

                arg1.End()
            end

            arg1.End()
        elseif v51 then
            arg1.Table({ 1, [arg1.Args.Table.RowBg] = false })
            arg1.Text({ string.format("The ID, \"%s\", is a state", v49) })
            arg1.NextRow()
            local _ = {}
            arg1.Text(
                {
                    string.format(
                        "Value is type: %s, Value = %s",
                        typeof(v51.value),
                        (tostring(v51.value))
                    )
                }
            )
            arg1.NextRow()
            arg1.Tree({ "state has connected widgets:" }, { isUncollapsed = arg1.State(true) })

            for key_2, val_2 in v51.ConnectedWidgets do
                arg1.Text({ key_2 .. " - " .. val_2.type })
            end

            arg1.End()
            arg1.NextRow()
            arg1.Text(
                { string.format("state has: %d connected functions", #v51.ConnectedFunctions) }
            )
            arg1.End()
        else
            arg1.Text({ string.format("The ID, \"%s\", is not a state or widget", v49) })
        end

        arg1.End()

        if arg1.Tree({ "Widgets" }).isUncollapsed.value then
            v49 = 0
            v50 = ""

            for _, val_3 in LastVDOM do
                v49 += 1
                v50 ..= "\n" .. val_3.ID .. " - " .. val_3.type
            end

            arg1.Text({ "Number of Widgets: " .. v49 })
            arg1.Text({ v50 })
        end

        arg1.End()

        if arg1.Tree({ "States" }).isUncollapsed.value then
            v51 = 0
            v48 = ""

            for key_4, val_4 in States do
                v51 += 1
                v48 ..= "\n" .. key_4 .. " - " .. tostring(val_4.value)
            end

            arg1.Text({ "Number of States: " .. v51 })
            arg1.Text({ v48 })
        end

        arg1.End()
        arg1.End()
    end

    local function recursiveMenu() -- line: 464
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] recursiveMenu (copy)

        if arg1.Menu({ "Recursive" }).state.isOpened.value then
            arg1.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl })
            arg1.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl })
            arg1.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl })
            arg1.Separator()
            arg1.MenuToggle({ "Autosave" })
            arg1.MenuToggle({ "Checked" })
            arg1.Separator()
            arg1.Menu({ "Options" })
            arg1.MenuItem({ "Red" })
            arg1.MenuItem({ "Yellow" })
            arg1.MenuItem({ "Green" })
            arg1.MenuItem({ "Blue" })
            arg1.Separator()
            recursiveMenu()
            arg1.End()
        end

        arg1.End()
    end

    local function mainMenuBar() -- line: 488
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] recursiveMenu (copy)
        --  [3] v2 (copy)
        --  [4] v5 (copy)
        --  [5] v6 (copy)
        --  [6] v3 (copy)
        --  [7] v4 (copy)

        arg1.MenuBar()
        arg1.Menu({ "File" })
        arg1.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl })
        arg1.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl })
        arg1.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl })
        recursiveMenu()
        arg1.MenuItem({ "Quit", Enum.KeyCode.Q, Enum.ModifierKey.Alt })
        arg1.End()
        arg1.Menu({ "Examples" })
        arg1.MenuToggle({ "Recursive Window" }, { isChecked = v2 })
        arg1.MenuToggle({ "Windowless" }, { isChecked = v5 })
        arg1.MenuToggle({ "Main Menu Bar" }, { isChecked = v6 })
        arg1.End()
        arg1.Menu({ "Tools" })
        arg1.MenuToggle({ "Runtime Info" }, { isChecked = v3 })
        arg1.MenuToggle({ "Style Editor" }, { isChecked = v4 })
        arg1.End()
        arg1.End()
    end

    local _ = function() --[[ mainMenuBarExample ]] -- line: 511
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] mainMenuBar (copy)

        local _ = arg1.Internal._rootWidget.Instance.PseudoWindowScreenGui.AbsoluteSize
        mainMenuBar()
    end

    local function v72() -- line: 526
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v4 (copy)

        local v53 = arg1.State(1)
        local t_114 = {
            {
                "Sizing",
                function() -- line: 532
                    -- upvalues:
                    --  [1] arg1 (ref)

                    local v54 = arg1.State({})

                    if arg1.Button({ "Update Config" }).clicked() then
                        arg1.UpdateGlobalConfig(v54:get())
                        v54:set({})
                    end

                    for _, val_5 in {
                        { "ItemWidth", nil, UDim.new(), UDim.new(1, 200) },
                        { "ContentWidth", nil, UDim.new(), UDim.new(1, 200) }
                    } do
                        local v55 = arg1.SliderUDim(
                            { table.unpack(val_5) },
                            { number = arg1.WeakState(arg1._config[val_5[1]]) }
                        )

                        if v55.numberChanged() then
                            v54:get()[val_5[1]] = v55.number:get()
                        end
                    end

                    for _, val_6 in {
                        { "WindowPadding", nil, Vector2.zero, Vector2.one * 20 },
                        { "WindowResizePadding", nil, Vector2.zero, Vector2.one * 20 },
                        { "FramePadding", nil, Vector2.zero, Vector2.one * 20 },
                        { "ItemSpacing", nil, Vector2.zero, Vector2.one * 20 },
                        { "ItemInnerSpacing", nil, Vector2.zero, Vector2.one * 20 },
                        { "CellPadding", nil, Vector2.zero, Vector2.one * 20 },
                        { "DisplaySafeAreaPadding", nil, Vector2.zero, Vector2.one * 20 }
                    } do
                        local v58 = arg1.SliderVector2(
                            { table.unpack(val_6) },
                            { number = arg1.WeakState(arg1._config[val_6[1]]) }
                        )

                        if v58.numberChanged() then
                            v54:get()[val_6[1]] = v58.number:get()
                        end
                    end

                    for _, val_7 in {
                        { "TextSize", 1, 4, 20 },
                        { "FrameBorderSize", 0.1, 0, 1 },
                        { "FrameRounding", 1, 0, 12 },
                        { "GrabRounding", 1, 0, 12 },
                        { "WindowBorderSize", 0.1, 0, 1 },
                        { "PopupBorderSize", 0.1, 0, 1 },
                        { "PopupRounding", 1, 0, 12 },
                        { "ScrollbarSize", 1, 0, 20 },
                        { "GrabMinSize", 1, 0, 20 }
                    } do
                        local v61 = arg1.SliderNum(
                            { table.unpack(val_7) },
                            { number = arg1.WeakState(arg1._config[val_7[1]]) }
                        )

                        if v61.numberChanged() then
                            v54:get()[val_7[1]] = v61.number:get()
                        end
                    end

                    for _, val_8 in { "WindowTitleAlign" } do
                        local t_105 = { index = arg1.WeakState(arg1._config[val_8]) }
                        local v64 = arg1.ComboEnum({ val_8 }, t_105, arg1._config[val_8].EnumType)

                        if v64.closed() then
                            local t_107 = { [val_8] = v64.index:get() }
                            arg1.UpdateGlobalConfig(t_107)
                        end
                    end
                end
            },
            {
                "Colors",
                function() -- line: 599
                    -- upvalues:
                    --  [1] arg1 (ref)

                    local v65 = arg1.State({})

                    if arg1.Button({ "Update Config" }).clicked() then
                        arg1.UpdateGlobalConfig(v65:get())
                        v65:set({})
                    end

                    for _, val_9 in { "BorderColor", "BorderActiveColor" } do
                        local t_108 = { color = arg1.WeakState(arg1._config[val_9]) }
                        local v66 = arg1.InputColor3({ val_9 }, t_108)

                        if v66.numberChanged() then
                            local t_110 = { [val_9] = v66.color:get() }
                            arg1.UpdateGlobalConfig(t_110)
                        end
                    end

                    for _, val_10 in {
                        "Text",
                        "TextDisabled",
                        "WindowBg",
                        "ScrollbarGrab",
                        "TitleBg",
                        "TitleBgActive",
                        "TitleBgCollapsed",
                        "MenubarBg",
                        "FrameBg",
                        "FrameBgHovered",
                        "FrameBgActive",
                        "Button",
                        "ButtonHovered",
                        "ButtonActive",
                        "SliderGrab",
                        "SliderGrabActive",
                        "Header",
                        "HeaderHovered",
                        "HeaderActive",
                        "SelectionImageObject",
                        "SelectionImageObjectBorder",
                        "TableBorderStrong",
                        "TableBorderLight",
                        "TableRowBg",
                        "TableRowBgAlt",
                        "NavWindowingHighlight",
                        "NavWindowingDimBg",
                        "Separator",
                        "CheckMark"
                    } do
                        local t_112 = {
                            color = arg1.WeakState(arg1._config[val_10 .. "Color"]),
                            transparency = arg1.WeakState(arg1._config[val_10 .. "Transparency"])
                        }
                        local v67 = arg1.InputColor4({ val_10 }, t_112)

                        if v67.numberChanged() then
                            v65:get()[val_10 .. "Color"] = v67.color:get()
                            v65:get()[val_10 .. "Transparency"] = v67.transparency:get()
                        end
                    end
                end
            }
        }
        arg1.Window({ "Style Editor" }, { isOpened = v4 })
        arg1.Text({ "Customize the look of Iris in realtime." })
        arg1.SameLine()

        if arg1.SmallButton({ "Light Theme" }).clicked() then
            arg1.UpdateGlobalConfig(arg1.TemplateConfig.colorLight)
        end

        if arg1.SmallButton({ "Dark Theme" }).clicked() then
            arg1.UpdateGlobalConfig(arg1.TemplateConfig.colorDark)
        end

        arg1.End()
        arg1.SameLine()

        if arg1.SmallButton({ "Classic Size" }).clicked() then
            arg1.UpdateGlobalConfig(arg1.TemplateConfig.sizeDefault)
        end

        if arg1.SmallButton({ "Larger Size" }).clicked() then
            arg1.UpdateGlobalConfig(arg1.TemplateConfig.sizeClear)
        end

        arg1.End()

        if arg1.SmallButton({ "Reset Everything" }).clicked() then
            arg1.UpdateGlobalConfig(arg1.TemplateConfig.colorDark)
            arg1.UpdateGlobalConfig(arg1.TemplateConfig.sizeDefault)
        end

        arg1.Separator()
        arg1.SameLine()

        for key_11, val_11 in ipairs(t_114) do
            arg1.RadioButton({ val_11[1], key_11 }, { index = v53 })
        end

        arg1.End()
        t_114[v53:get()][2]()
        arg1.End()
    end

    local function widgetEventInteractivity() -- line: 699
        -- upvalues:
        --  [1] arg1 (copy)

        arg1.CollapsingHeader({ "Widget Event Interactivity" })
        local v73 = arg1.State(0)

        if arg1.Button({ "Click to increase Number" }).clicked() then
            v73:set(v73:get() + 1)
        end

        arg1.Text({ "The Number is: " .. v73:get() })
        arg1.Separator()
        local v75 = arg1.State(false)
        local v76 = arg1.State("clicked")
        arg1.SameLine()
        arg1.RadioButton({ "clicked", "clicked" }, { index = v76 })
        arg1.RadioButton({ "rightClicked", "rightClicked" }, { index = v76 })
        arg1.RadioButton({ "doubleClicked", "doubleClicked" }, { index = v76 })
        arg1.RadioButton({ "ctrlClicked", "ctrlClicked" }, { index = v76 })
        arg1.End()
        arg1.SameLine()

        if arg1.Button({ v76:get() .. " to reveal text" })[v76:get()]() then
            v75:set(not v75:get())
        end

        if v75:get() then
            arg1.Text({ "Here i am!" })
        end

        arg1.End()
        arg1.Separator()
        local v78 = arg1.State(0)
        arg1.SameLine()

        if arg1.Button({ "Click to show text for 20 frames" }).clicked() then
            v78:set(20)
        end

        if v78:get() > 0 then
            arg1.Text({ "Here i am!" })
        end

        arg1.End()
        v78:set((math.max(0, v78:get() - 1)))
        arg1.Text({ "Text Timer: " .. v78:get() })
        local v80 = arg1.Checkbox({ "Event-tracked checkbox" })
        arg1.Indent()
        arg1.Text({ "unchecked: " .. tostring(v80.unchecked()) })
        arg1.Text({ "checked: " .. tostring(v80.checked()) })
        arg1.End()
        arg1.SameLine()

        if arg1.Button({ "Hover over me" }).hovered() then
            arg1.Text({ "The button is hovered" })
        end

        arg1.End()
        arg1.End()
    end

    local function widgetStateInteractivity() -- line: 755
        -- upvalues:
        --  [1] arg1 (copy)

        arg1.CollapsingHeader({ "Widget State Interactivity" })
        local v81 = arg1.Checkbox({ "Widget-Generated State" })
        arg1.Text({ `isChecked: {v81.state.isChecked.value}\n` })
        local t_127 = { isChecked = arg1.State(false) }
        local v83 = arg1.Checkbox({ "User-Generated State" }, t_127)
        arg1.Text({ `isChecked: {v83.state.isChecked.value}\n` })
        local t_129 = { isChecked = arg1.Checkbox({ "Widget Coupled State" }).state.isChecked }
        arg1.Text(
            {
                `isChecked: {arg1.Checkbox({ "Coupled to above Checkbox" }, t_129).state.isChecked.value}\n`
            }
        )
        local v85 = arg1.State(false)
        local _ = { isChecked = v85 }

        if arg1.Button({ "Click to toggle above checkbox" }).clicked() then
            v85:set(not v85:get())
        end

        arg1.Text({ `isChecked: {v85.value}\n` })
        local v86 = arg1.State(true)
        local v87 = arg1.ComputedState(v86, function(arg4) -- line: 777
            return not arg4
        end)
        local _ = arg1.Checkbox({ "ComputedState (dynamic coupling)" }, { isChecked = v86 })
        local _ = arg1.Checkbox({ "Inverted of above checkbox" }, { isChecked = v87 })
        arg1.Text({ `isChecked: {v87.value}\n` })
        arg1.End()
    end

    local function dynamicStyle() -- line: 787
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] helpMarker (copy)

        arg1.CollapsingHeader({ "Dynamic Styles" })
        local v90 = arg1.State(0)
        arg1.SameLine()

        if arg1.Button({ "Change Color" }).clicked() then
            v90:set(math.random())
        end

        arg1.Text({ "Hue: " .. math.floor(v90:get() * 255) })
        helpMarker("Using PushConfig with a changing value, this can be done with any config field")
        arg1.End()
        local t_137 = { TextColor = nil }
        local PushConfig_9 = arg1.PushConfig
        t_137.TextColor = Color3.fromHSV(v90:get(), 1, 1)
        PushConfig_9(t_137)
        arg1.Text({ "Text with a unique and changable color" })
        arg1.PopConfig()
        arg1.End()
    end

    local function tablesDemo() -- line: 803
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] helpMarker (copy)

        local v91 = arg1.State(false)
        arg1.CollapsingHeader({ "Tables & Columns" }, { isUncollapsed = v91 })

        if v91.value == false then
            arg1.End()

            return
        end

        arg1.SameLine()
        arg1.Text({ "Table using NextRow and NextColumn syntax:" })
        helpMarker(
            "calling Iris.NextRow() in the outer loop, and Iris.NextColumn()in the inner loop"
        )
        arg1.End()
        arg1.Table({ 3 })

        for index = 1, 4 do
            arg1.NextRow()

            for index_1 = 1, 3 do
                arg1.NextColumn()
                arg1.Text({ `Row: {index}, Column: {index_1}` })
            end
        end

        arg1.End()
        arg1.Text({ "" })
        arg1.SameLine()
        arg1.Text({ "Table using NextColumn only syntax:" })
        helpMarker("only calling Iris.NextColumn() in the inner loop, the result is identical")
        arg1.End()
        arg1.Table({ 2 })

        for index_2 = 1, 4 do
            for index_3 = 1, 2 do
                arg1.NextColumn()
                arg1.Text({ `Row: {index_2}, Column: {index_3}` })
            end
        end

        arg1.End()
        arg1.Separator()
        local v92 = arg1.State(false)
        local v93 = arg1.State(false)
        local v94 = arg1.State(true)
        local v95 = arg1.State(true)
        local v96 = arg1.State(3)
        arg1.Text({ "Table with Customizable Arguments" })
        arg1.Table(
            {
                4,
                [arg1.Args.Table.RowBg] = v92.value,
                [arg1.Args.Table.BordersOuter] = v93.value,
                [arg1.Args.Table.BordersInner] = v94.value
            }
        )

        for index_4 = 1, v96:get() do
            for index_5 = 1, 4 do
                arg1.NextColumn()
                local _ = v96:get()

                if v95.value then
                    arg1.Button({ `Month: {index_4}, Week: {index_5}` })
                else
                    arg1.Text({ `Month: {index_4}, Week: {index_5}` })
                end
            end
        end

        arg1.End()
        arg1.Checkbox({ "RowBg" }, { isChecked = v92 })
        arg1.Checkbox({ "BordersOuter" }, { isChecked = v93 })
        arg1.Checkbox({ "BordersInner" }, { isChecked = v94 })
        arg1.SameLine()
        arg1.RadioButton({ "Buttons", true }, { index = v95 })
        arg1.RadioButton({ "Text", false }, { index = v95 })
        arg1.End()
        arg1.InputNum(
            {
                "Number of rows",
                [arg1.Args.InputNum.Min] = 0,
                [arg1.Args.InputNum.Max] = 100,
                [arg1.Args.InputNum.Format] = "%d"
            },
            { number = v96 }
        )
        arg1.End()
    end

    local function layoutDemo() -- line: 888
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] helpMarker (copy)

        arg1.CollapsingHeader({ "Widget Layout" })
        arg1.Tree({ "Content Width" })
        local v98 = arg1.State(50)
        local v99 = arg1.State(Enum.Axis.X)
        arg1.Text(
            { "The Content Width is a size property which determines the width of input fields." }
        )
        arg1.SameLine()
        arg1.Text({ "By default the value is UDim.new(0.65, 0)" })
        helpMarker("This is the default value from Dear ImGui.\nIt is 65% of the window width.")
        arg1.End()
        arg1.Text(
            {
                "This works well, but sometimes we know how wide elements are going to be and want to maximise the space."
            }
        )
        arg1.Text({ "Therefore, we can use Iris.PushConfig() to change the width" })
        arg1.Separator()
        arg1.SameLine()
        arg1.Text({ "Content Width = 150 pixels" })
        helpMarker("UDim.new(0, 150)")
        arg1.End()
        local t_150 = { ContentWidth = UDim.new(0, 150) }
        arg1.PushConfig(t_150)
        arg1.DragNum({ "number", 1, 0, 100 }, { number = v98 })
        arg1.ComboEnum({ "axis" }, { index = v99 }, Enum.Axis)
        arg1.PopConfig()
        arg1.SameLine()
        arg1.Text({ "Content Width = 50% window width" })
        helpMarker("UDim.new(0.5, 0)")
        arg1.End()
        local t_153 = { ContentWidth = UDim.new(0.5, 0) }
        arg1.PushConfig(t_153)
        arg1.DragNum({ "number", 1, 0, 100 }, { number = v98 })
        arg1.ComboEnum({ "axis" }, { index = v99 }, Enum.Axis)
        arg1.PopConfig()
        arg1.SameLine()
        arg1.Text({ "Content Width = -150 pixels from the right side" })
        helpMarker("UDim.new(1, -150)")
        arg1.End()
        local t_156 = { ContentWidth = UDim.new(1, -150) }
        arg1.PushConfig(t_156)
        arg1.DragNum({ "number", 1, 0, 100 }, { number = v98 })
        arg1.InputEnum({ "axis" }, { index = v99 }, Enum.Axis)
        arg1.PopConfig()
        arg1.End()
        arg1.End()
    end

    local function windowlessDemo() -- line: 935
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] helpMarker (copy)

        local t_159 = { ItemWidth = UDim.new(0, 150) }
        arg1.PushConfig(t_159)
        arg1.SameLine()
        arg1.TextWrapped({ "Windowless widgets" })
        helpMarker(
            "Widgets which are placed outside of a window will appear on the top left side of the screen."
        )
        arg1.End()
        arg1.Button({})
        arg1.Tree({})
        arg1.InputText({})
        arg1.End()
        arg1.PopConfig()
    end

    local t_160 = {
        "Basic",
        "Tree",
        "CollapsingHeader",
        "Group",
        "Indent",
        "Input",
        "MultiInput",
        "InputText",
        "Tooltip",
        "Selectable",
        "Combo"
    }

    return function() -- line: 949
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] v1 (copy)
        --  [3] mainMenuBar (copy)
        --  [4] widgetEventInteractivity (copy)
        --  [5] widgetStateInteractivity (copy)
        --  [6] recursiveTree (copy)
        --  [7] dynamicStyle (copy)
        --  [8] t_160 (copy)
        --  [9] t_2 (copy)
        --  [10] tablesDemo (copy)
        --  [11] layoutDemo (copy)
        --  [12] v2 (copy)
        --  [13] recursiveWindow (copy)
        --  [14] v3 (copy)
        --  [15] runtimeInfo (copy)
        --  [16] v4 (copy)
        --  [17] v72 (ref)
        --  [18] v5 (copy)
        --  [19] windowlessDemo (copy)
        --  [20] v6 (copy)

        local v100 = arg1.State(false)
        local v101 = arg1.State(false)
        local v102 = arg1.State(false)
        local v103 = arg1.State(true)
        local v104 = arg1.State(false)
        local v105 = arg1.State(false)
        local v106 = arg1.State(false)
        local v107 = arg1.State(false)
        local v108 = arg1.State(false)

        if v1.value == false then
            arg1.Checkbox({ "Open main window" }, { isChecked = v1 })

            return
        end

        local t_162 = {
            "Iris Demo Window",
            [arg1.Args.Window.NoTitleBar] = v100.value,
            [arg1.Args.Window.NoBackground] = v101.value,
            [arg1.Args.Window.NoCollapse] = v102.value,
            [arg1.Args.Window.NoClose] = v103.value,
            [arg1.Args.Window.NoMove] = v104.value,
            [arg1.Args.Window.NoScrollbar] = v105.value,
            [arg1.Args.Window.NoResize] = v106.value,
            [arg1.Args.Window.NoNav] = v107.value,
            [arg1.Args.Window.NoMenu] = v108.value
        }
        local t_163 = { size = nil, position = nil, isOpened = nil }
        local Window_1 = arg1.Window
        t_163.size = arg1.State(Vector2.new(600, 550))
        t_163.position = arg1.State(Vector2.new(100, 25))
        t_163.isOpened = v1
        Window_1(t_162, t_163)
        mainMenuBar()
        arg1.Text({ "Iris says hello. (2.1.1)" })
        arg1.CollapsingHeader({ "Window Options" })
        arg1.Table({ 3, false, false, false })
        arg1.NextColumn()
        arg1.Checkbox({ "NoTitleBar" }, { isChecked = v100 })
        arg1.NextColumn()
        arg1.Checkbox({ "NoBackground" }, { isChecked = v101 })
        arg1.NextColumn()
        arg1.Checkbox({ "NoCollapse" }, { isChecked = v102 })
        arg1.NextColumn()
        arg1.Checkbox({ "NoClose" }, { isChecked = v103 })
        arg1.NextColumn()
        arg1.Checkbox({ "NoMove" }, { isChecked = v104 })
        arg1.NextColumn()
        arg1.Checkbox({ "NoScrollbar" }, { isChecked = v105 })
        arg1.NextColumn()
        arg1.Checkbox({ "NoResize" }, { isChecked = v106 })
        arg1.NextColumn()
        arg1.Checkbox({ "NoNav" }, { isChecked = v107 })
        arg1.NextColumn()
        arg1.Checkbox({ "NoMenu" }, { isChecked = v108 })
        arg1.End()
        arg1.End()
        widgetEventInteractivity()
        widgetStateInteractivity()
        arg1.CollapsingHeader({ "Recursive Tree" })

        if arg1.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
            recursiveTree()
        end

        arg1.End()
        arg1.End()
        dynamicStyle()
        arg1.Separator()
        arg1.CollapsingHeader({ "Widgets" })

        for _, val_12 in t_160 do
            t_2[val_12]()
        end

        arg1.End()
        tablesDemo()
        layoutDemo()
        arg1.End()

        if v2.value then
            recursiveWindow(v2)
        end

        if v3.value then
            runtimeInfo()
        end

        if v4.value then
            v72()
        end

        if v5.value then
            windowlessDemo()
        end

        if v6.value then
            local _ = arg1.Internal._rootWidget.Instance.PseudoWindowScreenGui.AbsoluteSize
            mainMenuBar()
        end
    end
end
