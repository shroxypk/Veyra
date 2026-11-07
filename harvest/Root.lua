-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.widgets.Root
-- Class: ModuleScript
-- bytes: 4646

local _ = require(script.Parent.Parent.Types)

return function(arg1, arg2) -- line: 3
    local v1 = 0
    local t = {
        hasState = false,
        hasChildren = true,
        Args = {},
        Events = {},
        Generate = nil,
        Update = nil,
        Discard = nil,
        ChildAdded = nil,
        ChildDiscarded = nil
    }

    function t.Generate(_) -- line: 11
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] arg2 (copy)

        local IrisRoot_Folder = Instance.new("Folder")
        IrisRoot_Folder.Name = "Iris_Root"
        local v2

        if arg1._config.UseScreenGUIs then
            v2 = Instance.new("ScreenGui")
            v2.ResetOnSpawn = false
            v2.DisplayOrder = arg1._config.DisplayOrderOffset
            v2.IgnoreGuiInset = arg1._config.IgnoreGuiInset
        else
            v2 = Instance.new("Folder")
        end

        v2.Name = "PseudoWindowScreenGui"
        v2.Parent = IrisRoot_Folder
        local v3

        if arg1._config.UseScreenGUIs then
            v3 = Instance.new("ScreenGui")
            v3.ResetOnSpawn = false
            v3.DisplayOrder = arg1._config.DisplayOrderOffset + 1024
            v3.IgnoreGuiInset = arg1._config.IgnoreGuiInset
            local TooltipContainer_Frame = Instance.new("Frame")
            TooltipContainer_Frame.Name = "TooltipContainer"
            TooltipContainer_Frame.AutomaticSize = Enum.AutomaticSize.XY
            TooltipContainer_Frame.Size = UDim2.fromOffset(0, 0)
            TooltipContainer_Frame.BackgroundTransparency = 1
            TooltipContainer_Frame.BorderSizePixel = 0
            arg2.UIListLayout(
                TooltipContainer_Frame,
                Enum.FillDirection.Vertical,
                UDim.new(0, arg1._config.PopupBorderSize)
            )
            TooltipContainer_Frame.Parent = v3
            local Frame_1 = Instance.new("Frame")
            Frame_1.Name = "MenuBarContainer"
            Frame_1.AutomaticSize = Enum.AutomaticSize.Y
            Frame_1.Size = UDim2.fromScale(1, 0)
            Frame_1.BackgroundTransparency = 1
            Frame_1.BorderSizePixel = 0
            Frame_1.Parent = v3
        else
            v3 = Instance.new("Folder")
        end

        v3.Name = "PopupScreenGui"
        v3.Parent = IrisRoot_Folder
        v3 = Instance.new("Frame")
        v3.Name = "PseudoWindow"
        v3.Size = UDim2.new(0, 0, 0, 0)
        v3.Position = UDim2.fromOffset(0, 22)
        v3.AutomaticSize = Enum.AutomaticSize.XY
        v3.BackgroundTransparency = arg1._config.WindowBgTransparency
        v3.BackgroundColor3 = arg1._config.WindowBgColor
        v3.BorderSizePixel = arg1._config.WindowBorderSize
        v3.BorderColor3 = arg1._config.BorderColor
        v3.Selectable = false
        v3.SelectionGroup = true
        v3.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
        v3.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
        v3.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
        v3.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
        v3.Visible = false
        arg2.UIPadding(v3, arg1._config.WindowPadding)
        arg2.UIListLayout(v3, Enum.FillDirection.Vertical, UDim.new(0, arg1._config.ItemSpacing.Y))
        v3.Parent = v2

        return IrisRoot_Folder
    end

    function t.Update(arg4) -- line: 85
        -- upvalues:
        --  [1] v1 (ref)

        if v1 > 0 then
            arg4.Instance.PseudoWindowScreenGui.PseudoWindow.Visible = true
        end
    end

    function t.Discard(arg5) -- line: 93
        -- upvalues:
        --  [1] v1 (ref)

        v1 = 0
        arg5.Instance:Destroy()
    end

    function t.ChildAdded(arg6, arg7) -- line: 97
        -- upvalues:
        --  [1] v1 (ref)

        local v4 = arg6.Instance

        if arg7.type == "Window" then
            return arg6.Instance
        end

        if arg7.type == "Tooltip" then
            return v4.PopupScreenGui.TooltipContainer
        end

        if arg7.type == "MenuBar" then
            return v4.PopupScreenGui.MenuBarContainer
        end

        local PseudoWindow = v4.PseudoWindowScreenGui.PseudoWindow
        v1 += 1
        PseudoWindow.Visible = true

        return PseudoWindow
    end

    function t.ChildDiscarded(arg8, arg9) -- line: 116
        -- upvalues:
        --  [1] v1 (ref)

        if arg9.type ~= "Window" and arg9.type ~= "Tooltip" and arg9.type ~= "MenuBar" then
            v1 -= 1

            if v1 == 0 then
                arg8.Instance.PseudoWindowScreenGui.PseudoWindow.Visible = false
            end
        end
    end

    arg1.WidgetConstructor("Root", t)
end
