-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Icon.Template
-- Class: ModuleScript
-- bytes: 7445

local t = {}
local IconTemplates = script.Parent:FindFirstChild("IconTemplates")
local v1 = IconTemplates

if v1 then
    v1 = IconTemplates:FindFirstChild("TopbarStandard")
end

t.screenGui = v1
v1 = t.screenGui

if v1 then
    v1 = t.screenGui:FindFirstChild("IconButtonTemplate", true)
end

t.iconButton = v1
v1 = t.iconButton and t.iconButton.Parent
t.widget = v1
local t_1 = {
    "BackgroundColor3",
    "BackgroundTransparency",
    "BorderSizePixel",
    "BorderColor3",
    "Rotation",
    "ImageColor3",
    "ImageTransparency",
    "ScaleType",
    "SliceCenter",
    "SliceScale",
    "ResampleMode",
    "TileSize",
    "TextColor3",
    "TextStrokeColor3",
    "TextStrokeTransparency",
    "CornerRadius",
    "Color",
    "Thickness",
    "Transparency",
    "Offset",
    "Enabled"
}
local t_2 = { ["IconImage.Image"] = true, ["IconLabel.Text"] = true }

local function copy(arg1, arg2, arg3) -- line: 32
    -- upvalues:
    --  [1] t_2 (copy)

    local v2

    for _, val in arg3 do
        if not t_2[arg1.Name .. "." .. val] then
            local Success
            Success, v2 = pcall(function() -- line: 37
                -- upvalues:
                --  [1] arg1 (copy)
                --  [2] val (copy)

                return arg1[val]
            end)

            if Success and v2 ~= nil then
                pcall(function() -- line: 39
                    -- upvalues:
                    --  [1] arg2 (copy)
                    --  [2] val (copy)
                    --  [3] v2 (copy)

                    if arg2[val] ~= v2 then
                        arg2[val] = v2
                    end
                end)
            end
        end
    end
end

local function applyTree(arg4, arg5, arg6) -- line: 50
    -- upvalues:
    --  [1] copy (copy)
    --  [2] t_1 (copy)
    --  [3] applyTree (copy)

    copy(arg4, arg5, t_1)

    for _, child in arg4:GetChildren() do
        local v3 = arg5:FindFirstChild(child.Name)

        if v3 then
            if v3.ClassName == child.ClassName then
                applyTree(child, v3, false)
            elseif not v3 and arg6 then
                child:Clone().Parent = arg5
            end
        elseif not v3 and arg6 then
            child:Clone().Parent = arg5
        end
    end
end

local t_3 = {
    "IgnoreGuiInset",
    "ScreenInsets",
    "SafeAreaCompatibility",
    "ClipToDeviceSafeArea",
    "ZIndexBehavior",
    "ResetOnSpawn",
    "AutoLocalize"
}

function t.applyToButton(arg7) -- line: 62
    -- upvalues:
    --  [1] t (copy)
    --  [2] applyTree (copy)

    if not t.iconButton then
        return
    end

    applyTree(t.iconButton, arg7, true)
    local UICorner = t.iconButton:FindFirstChild("UICorner")
    local UICorner_1 = arg7:FindFirstChild("UICorner")

    if UICorner and UICorner_1 then
        UICorner_1:SetAttribute("Collective", nil)
        UICorner_1.CornerRadius = UICorner.CornerRadius
    end
end

function t.applyToScreenGui(arg8) -- line: 76
    -- upvalues:
    --  [1] t (copy)
    --  [2] copy (copy)
    --  [3] t_3 (copy)

    local ScreenGui = t.screenGui

    if not ScreenGui then
        return
    end

    copy(ScreenGui, arg8, t_3)
    local Holders = ScreenGui:FindFirstChild("Holders")
    local Holders_1 = arg8:FindFirstChild("Holders")

    if not Holders or not Holders_1 then
        return
    end

    local function addExtras(arg9, arg10) -- line: 86
        for _, child_1 in arg9:GetChildren() do
            if not child_1:IsA("GuiObject") and not arg10:FindFirstChild(child_1.Name) then
                child_1:Clone().Parent = arg10
            end
        end
    end

    addExtras(Holders, Holders_1)

    for _, val_1 in { "Left", "Right", "Center" } do
        local v4 = Holders:FindFirstChild(val_1)
        local v5 = Holders_1:FindFirstChild(val_1)

        if v4 and v5 then
            addExtras(v4, v5)
        end
    end
end

function t.patchTheme(arg11) -- line: 104
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_1 (copy)
    --  [3] t_2 (copy)

    local IconButton = t.iconButton

    if not IconButton then
        return arg11
    end

    local t_4 = { IconButton = IconButton }

    for _, descendant in IconButton:GetDescendants() do
        t_4[descendant.Name] = t_4[descendant.Name] or descendant
    end

    local t_5 = { Value = true }

    for _, val_2 in t_1 do
        t_5[val_2] = true
    end

    local Widget = t.widget
    local UICorner_2 = IconButton:FindFirstChildOfClass("UICorner")
    local Result, Success_1, attribute

    for _, val_3 in arg11 do
        local v6 = val_3[1]
        local v7 = val_3[2]
        local v8 = val_3[3]
        local v9 = val_3[4]

        if v9 ~= nil then
            if v9 == "Deselected" then
                if v6 == "Widget" and Widget then
                    attribute = Widget:GetAttribute(v7)

                    if typeof(attribute) == typeof(v8) then
                        val_3[3] = attribute
                    end
                elseif v6 == "IconCorners" and (v7 == "CornerRadius" and UICorner_2) then
                    val_3[3] = UICorner_2.CornerRadius
                else
                    local v11 = t_4[v6]

                    if v11 and t_5[v7] and (v9 == nil or v9 == "Deselected") and not t_2[v6 .. "." .. v7] then
                        Success_1, Result = pcall(function() -- line: 136
                            -- upvalues:
                            --  [1] v11 (copy)
                            --  [2] v7 (copy)

                            return v11[v7]
                        end)

                        if Success_1 then
                            if typeof(Result) == typeof(v8) then
                                val_3[3] = Result
                            end
                        end
                    end
                end
            else
                local v13 = t_4[v6]

                if v13 and t_5[v7] and (v9 == nil or v9 == "Deselected") and not t_2[v6 .. "." .. v7] then
                    Success_1, Result = pcall(function() -- line: 136
                        -- upvalues:
                        --  [1] v13 (copy)
                        --  [2] v7 (copy)

                        return v13[v7]
                    end)

                    if Success_1 then
                        if typeof(Result) == typeof(v8) then
                            val_3[3] = Result
                        end
                    end
                end
            end
        elseif v6 == "Widget" and Widget then
            attribute = Widget:GetAttribute(v7)

            if typeof(attribute) == typeof(v8) then
                val_3[3] = attribute
            end
        elseif v6 == "IconCorners" and (v7 == "CornerRadius" and UICorner_2) then
            val_3[3] = UICorner_2.CornerRadius
        else
            local v14 = t_4[v6]

            if v14 and t_5[v7] and (v9 == nil or v9 == "Deselected") and not t_2[v6 .. "." .. v7] then
                Success_1, Result = pcall(function() -- line: 136
                    -- upvalues:
                    --  [1] v14 (copy)
                    --  [2] v7 (copy)

                    return v14[v7]
                end)

                if Success_1 then
                    if typeof(Result) == typeof(v8) then
                        val_3[3] = Result
                    end
                end
            end
        end
    end

    return arg11
end

return t
