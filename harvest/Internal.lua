-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.Internal
-- Class: ModuleScript
-- bytes: 16685

local _ = require(script.Parent.Types)

return function(arg1) -- line: 3
    local t = {
        _started = false,
        _cycleTick = 0,
        _globalRefreshRequested = false,
        _localRefreshActive = false,
        _widgets = {},
        _widgetCount = 0,
        _stackIndex = 1,
        _rootInstance = nil
    }
    t._rootWidget = { ID = "R", type = "Root", Instance = t._rootInstance, ZIndex = 0 }
    t._lastWidget = t._rootWidget
    t._rootConfig = {}
    t._config = t._rootConfig
    t._IDStack = { "R" }
    t._usedIDs = {}
    t._pushedId = nil
    t._nextWidgetId = nil
    t._states = {}
    t._postCycleCallbacks = {}
    t._connectedFunctions = {}
    t._cycleCoroutine = coroutine.create(function() -- line: 49
        -- upvalues:
        --  [1] t (copy)

        for _, val in t._connectedFunctions do
            debug.profilebegin("Iris/Connection")
            local Success, Result = pcall(val)
            debug.profileend()

            if not Success then
                t._stackIndex = 1
                coroutine.yield(false, Result)
            end

            if t._stackIndex ~= 1 then
                t._stackIndex = 1
                error("Callback has too few calls to Iris.End()", 0)
            end
        end

        coroutine.yield(true)
    end)
    local t_2 = {}
    t_2.__index = t_2

    function t_2.get(arg2) -- line: 80
        return arg2.value
    end

    function t_2.set(arg3, arg4) -- line: 84
        -- upvalues:
        --  [1] t (copy)

        if arg4 == arg3.value then
            return arg3.value
        end

        arg3.value = arg4

        for _, val_1 in arg3.ConnectedWidgets do
            t._widgets[val_1.type].UpdateState(val_1)
        end

        for _, val_2 in arg3.ConnectedFunctions do
            val_2(arg4)
        end

        return arg3.value
    end

    function t_2.onChange(t1: table, f1: (...any) -> ...any) -- line: 99
        table.insert(t1.ConnectedFunctions, f1)
    end

    t.StateClass = t_2

    function t._cycle() -- line: 111
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] t (copy)

        if arg1.Disabled then
            return
        end

        t._rootWidget.lastCycleTick = t._cycleTick

        if t._rootInstance == nil or t._rootInstance.Parent == nil then
            arg1.ForceRefresh()
        end

        for _, val_3 in t._lastVDOM do
            if val_3.lastCycleTick ~= t._cycleTick then
                t._DiscardWidget(val_3)
            end
        end

        t._lastVDOM = t._VDOM
        t._VDOM = t._generateEmptyVDOM()
        task.spawn(function() -- line: 135
            -- upvalues:
            --  [1] t (ref)

            for _, val_4 in t._postCycleCallbacks do
                val_4()
            end
        end)

        if t._globalRefreshRequested then
            t._generateSelectionImageObject()
            t._globalRefreshRequested = false

            for _, val_5 in t._lastVDOM do
                t._DiscardWidget(val_5)
            end

            t._generateRootInstance()
            t._lastVDOM = t._generateEmptyVDOM()
        end

        local v3 = t
        v3._cycleTick += 1
        t._widgetCount = 0
        table.clear(t._usedIDs)

        if t.parentInstance:IsA("GuiBase2d") and math.min(
            t.parentInstance.AbsoluteSize.X,
            t.parentInstance.AbsoluteSize.Y
        ) < 100 then
            error("Iris Parent Instance is too small")
        end

        local v4 = t.parentInstance:IsA("GuiBase2d") or (t.parentInstance:IsA("CoreGui") or (t.parentInstance:IsA(
            "PluginGui"
        ) or t.parentInstance:IsA("PlayerGui")))

        if v4 == false then
            error("Iris Parent Instance cant contain GUI")
        end

        if game:GetService("RunService"):IsStudio() then
            for _, val_6 in t._connectedFunctions do
                val_6()
            end

            return
        end

        v4 = coroutine.status(t._cycleCoroutine)

        if v4 == "suspended" then
            local _, thread_ret2, v5 = coroutine.resume(t._cycleCoroutine)

            if thread_ret2 == false then
                error(v5, 0)

                return
            end
        else
            if v4 == "running" then
                error(
                    "Iris cycleCoroutine took to long to yield. Connected functions should not yield."
                )

                return
            end

            error("unrecoverable state")
        end
    end

    function t._NoOp() -- line: 206
    end

    function t.WidgetConstructor(s1: string, arg5: any) -- line: 210
        -- upvalues:
        --  [1] t (copy)
        --  [2] arg1 (copy)

        local t_3 = {
            All = {
                Required = {
                    "Generate",
                    "Discard",
                    "Update",
                    "Args",
                    "Events",
                    "hasChildren",
                    "hasState"
                },
                Optional = {}
            },
            IfState = { Required = { "GenerateState", "UpdateState" }, Optional = {} },
            IfChildren = { Required = { "ChildAdded" }, Optional = { "ChildDiscarded" } }
        }
        local t_7 = {}
        local v6

        for _, val_7 in t_3.All.Required do
            v6 = arg5[val_7] ~= nil
            assert(v6, `field {val_7} is missing from widget {s1}, it is required for all widgets`)
            t_7[val_7] = arg5[val_7]
        end

        for _, val_8 in t_3.All.Optional do
            if arg5[val_8] == nil then
                t_7[val_8] = t._NoOp
            else
                t_7[val_8] = arg5[val_8]
            end
        end

        if arg5.hasState then
            for _, val_9 in t_3.IfState.Required do
                v6 = arg5[val_9] ~= nil
                assert(
                    v6,
                    `field {val_9} is missing from widget {s1}, it is required for all widgets with state`
                )
                t_7[val_9] = arg5[val_9]
            end

            for _, val_10 in t_3.IfState.Optional do
                if arg5[val_10] == nil then
                    t_7[val_10] = t._NoOp
                else
                    t_7[val_10] = arg5[val_10]
                end
            end
        end

        if arg5.hasChildren then
            for _, val_11 in t_3.IfChildren.Required do
                v6 = arg5[val_11] ~= nil
                assert(
                    v6,
                    `field {val_11} is missing from widget {s1}, it is required for all widgets with children`
                )
                t_7[val_11] = arg5[val_11]
            end

            for _, val_12 in t_3.IfChildren.Optional do
                if arg5[val_12] == nil then
                    t_7[val_12] = t._NoOp
                else
                    t_7[val_12] = arg5[val_12]
                end
            end
        end

        t._widgets[s1] = t_7
        arg1.Args[s1] = t_7.Args
        local t_8 = {}

        for key_13, val_13 in t_7.Args do
            t_8[val_13] = key_13
        end

        t_7.ArgNames = t_8

        for key_14, _ in t_7.Events do
            if arg1.Events[key_14] == nil then
                arg1.Events[key_14] = function() -- line: 301
                    -- upvalues:
                    --  [1] t (ref)
                    --  [2] key_14 (copy)

                    return t._EventCall(t._lastWidget, key_14)
                end
            end
        end
    end

    function t._Insert(s2: string, arg6: any, arg7: any) -- line: 308
        -- upvalues:
        --  [1] t (copy)

        local v10 = nil
        local v11 = t._getID(3)
        local v12 = t._widgets[s2]
        local v13 = t
        v13._widgetCount += 1

        if t._VDOM[v11] then
            return t._ContinueWidget(v11, s2)
        end

        local t_9 = {}

        if arg6 ~= nil then
            if type(arg6) ~= "table" then
                arg6 = { arg6 }
            end

            for key_15, val_15 in arg6 do
                t_9[v12.ArgNames[key_15]] = val_15
            end
        end

        table.freeze(t_9)

        if t._lastVDOM[v11] and s2 == t._lastVDOM[v11].type then
            if t._localRefreshActive then
                t._DiscardWidget(t._lastVDOM[v11])
            else
                v10 = t._lastVDOM[v11]
            end
        end

        if v10 == nil then
            v10 = t._GenNewWidget(s2, t_9, arg7, v11)
        end

        if t._deepCompare(v10.providedArguments, t_9) == false then
            v10.arguments = t._deepCopy(t_9)
            v10.providedArguments = t_9
            v12.Update(v10)
        end

        v10.lastCycleTick = t._cycleTick

        if v12.hasChildren then
            local v14 = t
            v14._stackIndex += 1
            t._IDStack[t._stackIndex] = v10.ID
        end

        t._VDOM[v11] = v10
        t._lastWidget = v10

        return v10
    end

    function t._GenNewWidget(s3: string, arg8: any, arg9: any, arg10: any) -- line: 375
        -- upvalues:
        --  [1] t (copy)

        local v15 = t._widgets[s3]
        local t_10 = {}
        local v16 = t._IDStack[t._stackIndex]
        setmetatable(t_10, t_10)
        t_10.ID = arg10
        t_10.type = s3
        t_10.parentWidget = t._VDOM[v16]
        t_10.trackedEvents = {}
        t_10.ZIndex = t_10.parentWidget.ZIndex + t._widgetCount * 64 + t._config.ZIndexOffset
        t_10.Instance = v15.Generate(t_10)
        t_10.Instance.Parent = if t._config.Parent then t._config.Parent else t._widgets[t_10.parentWidget.type].ChildAdded(
            t_10.parentWidget,
            t_10
        )
        t_10.providedArguments = arg8
        t_10.arguments = t._deepCopy(arg8)
        v15.Update(t_10)
        local v20

        if v15.hasState then
            if arg9 then
                for key_16, val_16 in arg9 do
                    if type(val_16) == "table" then
                        if getmetatable(val_16) ~= t.StateClass then
                            arg9[key_16] = t._widgetState(t_10, key_16, val_16)
                        end
                    else
                        arg9[key_16] = t._widgetState(t_10, key_16, val_16)
                    end
                end

                t_10.state = arg9

                for _, val_17 in arg9 do
                    val_17.ConnectedWidgets[t_10.ID] = t_10
                end
            else
                t_10.state = {}
            end

            v15.GenerateState(t_10)
            v15.UpdateState(t_10)
            t_10.stateMT = {}
            setmetatable(t_10.state, t_10.stateMT)
            t_10.__index = t_10.state
            v20 = t_10.stateMT
        else
            v20 = t_10
        end

        function v20.__index(_: any, s4: string) -- line: 432
            -- upvalues:
            --  [1] t (ref)
            --  [2] t_10 (copy)

            return function() -- line: 433
                -- upvalues:
                --  [1] t (ref)
                --  [2] t_10 (ref)
                --  [3] s4 (copy)

                return t._EventCall(t_10, s4)
            end
        end

        return t_10
    end

    function t._ContinueWidget(arg12: any, s5: string) -- line: 440
        -- upvalues:
        --  [1] t (copy)

        local v21 = t._VDOM[arg12]

        if t._widgets[s5].hasChildren then
            local v22 = t
            v22._stackIndex += 1
            t._IDStack[t._stackIndex] = v21.ID
        end

        t._lastWidget = v21

        return v21
    end

    function t._DiscardWidget(arg13) -- line: 454
        -- upvalues:
        --  [1] t (copy)

        local ParentWidget = arg13.parentWidget

        if ParentWidget then
            t._widgets[ParentWidget.type].ChildDiscarded(ParentWidget, arg13)
        end

        t._widgets[arg13.type].Discard(arg13)
    end

    function t._widgetState(arg14: any, s6: string, arg15: any) -- line: 465
        -- upvalues:
        --  [1] t (copy)

        local v23 = arg14.ID .. s6

        if t._states[v23] then
            t._states[v23].ConnectedWidgets[arg14.ID] = arg14

            return t._states[v23]
        end

        local t_11 = { value = arg15, ConnectedWidgets = nil, ConnectedFunctions = nil }
        local t_12 = {}
        t_12[arg14.ID] = arg14
        t_11.ConnectedWidgets = t_12
        local States = t._states
        t_11.ConnectedFunctions = {}
        States[v23] = t_11
        setmetatable(t._states[v23], t.StateClass)

        return t._states[v23]
    end

    function t._EventCall(arg16: any, s7: string) -- line: 481
        -- upvalues:
        --  [1] t (copy)

        local v24 = t._widgets[arg16.type].Events[s7]
        assert(v24 ~= nil, `widget {arg16.type} has no event of name {s7}`)

        if arg16.trackedEvents[s7] == nil then
            v24.Init(arg16)
            arg16.trackedEvents[s7] = true
        end

        return v24.Get(arg16)
    end

    function t._GetParentWidget() -- line: 493
        -- upvalues:
        --  [1] t (copy)

        return t._VDOM[t._IDStack[t._stackIndex]]
    end

    function t._generateEmptyVDOM() -- line: 499
        -- upvalues:
        --  [1] t (copy)

        return { R = t._rootWidget }
    end

    function t._generateRootInstance() -- line: 505
        -- upvalues:
        --  [1] t (copy)

        t._rootInstance = t._widgets.Root.Generate(t._widgets.Root)
        t._rootInstance.Parent = t.parentInstance
        t._rootWidget.Instance = t._rootInstance
    end

    function t._generateSelectionImageObject() -- line: 512
        -- upvalues:
        --  [1] t (copy)

        if t.SelectionImageObject then
            t.SelectionImageObject:Destroy()
        end

        local Frame = Instance.new("Frame")
        Frame.Position = UDim2.fromOffset(-1, -1)
        Frame.Size = UDim2.new(1, 2, 1, 2)
        Frame.BackgroundColor3 = t._config.SelectionImageObjectColor
        Frame.BackgroundTransparency = t._config.SelectionImageObjectTransparency
        Frame.BorderSizePixel = 0
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Thickness = 1
        UIStroke.Color = t._config.SelectionImageObjectBorderColor
        UIStroke.Transparency = t._config.SelectionImageObjectBorderTransparency
        UIStroke.LineJoinMode = Enum.LineJoinMode.Round
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        UIStroke.Parent = Frame
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 2)
        UICorner.Parent = Frame
        t.SelectionImageObject = Frame
    end

    function t._getID(n1: number) -- line: 543
        -- upvalues:
        --  [1] t (copy)

        if t._nextWidgetId then
            local NextWidgetId = t._nextWidgetId
            t._nextWidgetId = nil

            return NextWidgetId
        end

        local v28 = 1 + (n1 or 1)
        local v29 = ""
        local v30 = debug.info(v28, "l")

        while v30 ~= -1 do
            if v30 == nil then
                break
            end

            v29 ..= "+" .. v30
            v28 += 1
            v30 = debug.info(v28, "l")
        end

        if t._usedIDs[v29] then
            local UsedIDs = t._usedIDs
            UsedIDs[v29] += 1
        else
            t._usedIDs[v29] = 1
        end

        v30 = t._pushedId or t._usedIDs[v29]

        return v29 .. ":" .. v30
    end

    function t._deepCompare(t2: table, t3: table) -- line: 570
        -- upvalues:
        --  [1] t (copy)

        for key_18, val_18 in t2 do
            local v31 = t3[key_18]

            if type(val_18) == "table" then
                if v31 then
                    if type(v31) == "table" then
                        if t._deepCompare(val_18, v31) == false then
                            return false
                        end
                    else
                        return false
                    end
                else
                    return false
                end
            elseif type(val_18) ~= type(v31) or val_18 ~= v31 then
                return false
            end
        end

        return true
    end

    function t._deepCopy(t4: table) -- line: 592
        -- upvalues:
        --  [1] t (copy)

        local t_14 = {}

        for key_19, val_19 in pairs(t4) do
            if type(val_19) == "table" then
                val_19 = t._deepCopy(val_19)
            end

            t_14[key_19] = val_19
        end

        return t_14
    end

    t._lastVDOM = t._generateEmptyVDOM()
    t._VDOM = t._generateEmptyVDOM()
    arg1.Internal = t
    arg1._config = t._config

    return t
end
