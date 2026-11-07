-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Icon.Features.Overflow
-- Class: ModuleScript
-- bytes: 10479

local t = {}
local t_1 = {}
local t_2 = {}
local IconsDictionary = nil
local t_3 = {}
local CurrentCamera = workspace.CurrentCamera
local t_4 = {}
local Utility_m = require(script.Parent.Parent.Utility)
local v2 = false
local v3 = nil

function t.start(arg1) -- line: 25
    -- upvalues:
    --  [1] v3 (ref)
    --  [2] IconsDictionary (ref)
    --  [3] t_1 (copy)
    --  [4] Utility_m (copy)
    --  [5] t (copy)
    --  [6] v2 (ref)
    --  [7] CurrentCamera (copy)

    v3 = arg1
    IconsDictionary = v3.iconsDictionary
    local v4 = nil

    for _, val in pairs(v3.container) do
        v4 = if v4 ~= nil then v4 else if val.ScreenInsets ~= Enum.ScreenInsets.TopbarSafeInsets then v4 else val

        for _, val_1 in pairs(val.Holders:GetChildren()) do
            if val_1:GetAttribute("IsAHolder") then
                t_1[val_1.Name] = val_1
            end
        end
    end

    local v6 = false
    local v7 = Utility_m.createStagger(0.1, function(arg2) -- line: 43
        -- upvalues:
        --  [1] v6 (ref)
        --  [2] t (ref)

        if not v6 then
            return
        end

        if not arg2 then
            t.updateAvailableIcons("Center")
        end

        t.updateBoundary("Left")
        t.updateBoundary("Right")
    end)
    task.delay(0.5, function() -- line: 53
        -- upvalues:
        --  [1] v6 (ref)
        --  [2] v7 (copy)

        v6 = true
        v7()
    end)
    task.delay(2, function() -- line: 57
        -- upvalues:
        --  [1] v2 (ref)
        --  [2] v7 (copy)

        v2 = true
        v7()
    end)
    v3.iconAdded:Connect(v7)
    v3.iconRemoved:Connect(v7)
    v3.iconChanged:Connect(v7)
    CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- line: 67
        -- upvalues:
        --  [1] v7 (copy)

        v7(true)
    end)
    v4:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- line: 70
        -- upvalues:
        --  [1] v7 (copy)

        v7(true)
    end)
end

function t.getWidth(arg3, _) -- line: 75
    local Widget = arg3.widget

    return Widget:GetAttribute("TargetWidth") or Widget.AbsoluteSize.X
end

function t.getAvailableIcons(arg5) -- line: 80
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] t (copy)

    return t_2[arg5] or t.updateAvailableIcons(arg5)
end

function t.updateAvailableIcons(arg6) -- line: 88
    -- upvalues:
    --  [1] IconsDictionary (ref)
    --  [2] t_3 (copy)
    --  [3] t_2 (copy)

    local v10 = 0
    local t_5 = {}

    for _, val_2 in pairs(IconsDictionary) do
        local ParentIconUID = val_2.parentIconUID

        if (not ParentIconUID or t_3[ParentIconUID]) and val_2.alignment == arg6 and not t_3[val_2.UID] and val_2.isEnabled then
            table.insert(t_5, val_2)
            v10 += 1
        end
    end

    if v10 <= 0 then
        return {}
    end

    table.sort(t_5, function(arg7, arg8) -- line: 110
        local LayoutOrder = arg7.widget.LayoutOrder
        local LayoutOrder_1 = arg8.widget.LayoutOrder
        local ParentIconUID_1 = arg7.parentIconUID
        local ParentIconUID_2 = arg8.parentIconUID

        return if ParentIconUID_1 ~= ParentIconUID_2 then if not ParentIconUID_2 then if not ParentIconUID_1 then nil else true else false else if not (LayoutOrder < LayoutOrder_1) then if not (LayoutOrder > LayoutOrder_1) then arg7.widget.AbsolutePosition.X < arg8.widget.AbsolutePosition.X else false else true
    end)
    t_2[arg6] = t_5

    return t_5
end

function t.getRealXPositions(arg9, arg10) -- line: 137
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] Utility_m (copy)
    --  [3] t (copy)

    local v12 = if arg9 ~= "Left" then false else true
    local v13 = t_1[arg9]
    local X = v13.AbsolutePosition.X
    local X_1 = v13.AbsoluteSize.X
    local Offset = v13.UIListLayout.Padding.Offset
    local v14 = v12 and X or X + X_1
    local t_6 = {}

    if v12 then
        Utility_m.reverseTable(arg10)
    end

    for index = #arg10, 1, -1 do
        local v15 = arg10[index]
        local v16 = t.getWidth(v15)

        if not v12 then
            v14 -= v16
        end

        t_6[v15.UID] = v14

        if v12 then
            v14 += v16
        end

        local v17 = v12 and Offset or -Offset
        v14 += v17
    end

    return t_6
end

local v18 = false

function t.updateBoundary(arg11) -- line: 166
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] t (copy)
    --  [3] t_4 (copy)
    --  [4] v3 (ref)
    --  [5] t_3 (copy)
    --  [6] v18 (ref)
    --  [7] v2 (ref)
    --  [8] Utility_m (copy)

    local v19 = t_1[arg11]
    local UIListLayout = v19.UIListLayout
    local X_2 = v19.AbsolutePosition.X
    local X_3 = v19.AbsoluteSize.X
    local Offset_1 = UIListLayout.Padding.Offset
    local Offset_2 = UIListLayout.Padding.Offset
    local v20 = t.updateAvailableIcons(arg11)
    local v21 = 0
    local v22 = 0

    for _, val_3 in pairs(v20) do
        v21 += t.getWidth(val_3) + Offset_2
        v22 += 1
    end

    if v22 <= 0 then
        return
    end

    v22 = arg11 == "Center"
    v21 = arg11 == "Left"
    local v23 = not v21
    local v24 = t_4[arg11]

    if not v24 and not v22 and #v20 > 0 then
        local v25 = if not v21 then 9999999 else -9999999
        v24 = v3.new()
        v24:setImage(6069276526, "Deselected")
        v24:setName("Overflow" .. arg11)
        v24:setOrder(v25)
        v24:setAlignment(arg11)
        v24:autoDeselect(false)
        v24.isAnOverflow = true
        v24:select("OverflowStart", v24)
        v24:setEnabled(false)
        t_4[arg11] = v24
        t_3[v24.UID] = true

        if not v3.closeableOverflowMenus then
            v24:getInstance("IconSpot").Visible = false
        end
    end

    v22 = if arg11 ~= "Left" then "Left" else "Right"
    local v30 = t.updateAvailableIcons(v22)
    local v31 = v21 and v30[1] or v23 and v30[#v30]
    local v32 = t_4[v22]
    local v33 = v21 and X_2 + X_3 or X_2
    local v37

    if v31 then
        local v35 = t.getRealXPositions(v22, v30)[v31.UID]
        local v36 = t.getWidth(v31)
        v37 = v21 and v35 - Offset_1 or v35 + v36 + Offset_1
        v33 = v37
    end

    local v38 = 0

    local function checkToShiftCentralIcon() -- line: 233
        -- upvalues:
        --  [1] t (ref)
        --  [2] v21 (copy)
        --  [3] v18 (ref)
        --  [4] arg11 (copy)
        --  [5] v20 (copy)
        --  [6] v23 (copy)
        --  [7] Offset_1 (copy)
        --  [8] v2 (ref)
        --  [9] v38 (ref)
        --  [10] checkToShiftCentralIcon (copy)

        local v39 = t.getAvailableIcons("Center")
        local v40 = if not v21 then #v39 else 1
        local v41 = v39[v40]

        function v40() --[[ secondaryCheck ]] -- line: 237
            -- upvalues:
            --  [1] v18 (ref)
            --  [2] t (ref)
            --  [3] arg11 (ref)

            if not v18 then
                v18 = true
                task.delay(3, t.updateBoundary, arg11)
            end
        end

        if v41 and not v41.hasRelocatedInOverflow then
            v39 = v21 and v20[#v20] or v23 and v20[1]
            local v42 = v41.widget.AbsolutePosition.X
            local X_4 = v39.widget.AbsolutePosition.X
            local v43 = t.getWidth(v39)
            v39 = v21 and v42 - Offset_1 or v42 + t.getWidth(v41) + Offset_1
            v42 = v21 and X_4 + v43 or X_4
            v43 = false

            if v21 then
                if v39 < v42 then
                    if not v2 then
                        if not v18 then
                            v18 = true
                            task.delay(3, t.updateBoundary, arg11)
                        end

                        return
                    end

                    v41:align("Left")
                    v41.hasRelocatedInOverflow = true
                    v43 = true
                end
            elseif v23 and v39 > v42 then
                if not v2 or v42 < 0 then
                    if not v18 then
                        v18 = true
                        task.delay(3, t.updateBoundary, arg11)
                    end

                    return
                end

                v41:align("Right")
                v41.hasRelocatedInOverflow = true
                v43 = true
            end

            if v43 then
                v38 += 1

                if v38 <= 4 then
                    t.updateAvailableIcons("Center")
                    checkToShiftCentralIcon()
                end
            end
        end
    end

    checkToShiftCentralIcon()

    if v24 then
        v22 = v24:getInstance("Menu")
        local v44 = X_2 + X_3
        v37 = X_3

        if v22 and v32 then
            local X_5 = v32.widget.AbsolutePosition.X
            local v45 = t.getWidth(v32)
            local v46 = v21 and X_5 - Offset_1 or X_5 + v45 + Offset_1
            v45 = v22.AbsoluteCanvasSize.X >= v32:getInstance("Menu").AbsoluteCanvasSize.X and true
            local v48 = X_2 + X_3 / 2
            local v49 = v21 and v48 - Offset_1 / 2 or v48 + Offset_1 / 2
            local v50 = v49
            v50 = if not v45 then v50 else v46
            v49 = v21 and v50 - X_2 or v44 - v50
            v37 = v49
        end

        v44 = v22

        if v44 then
            v44 = v22:GetAttribute("MaxWidth")
        end

        v37 = Utility_m.round(v37)

        if v22 and v44 ~= v37 then
            v22:SetAttribute("MaxWidth", v37)
        end
    end

    v32 = false
    local v51 = t.getRealXPositions(arg11, v20)

    for index_1 = #v20, 1, -1 do
        local v52 = v20[index_1]
        local v53 = t.getWidth(v52)
        local v54 = v51[v52.UID]
        v32 = v21 and v33 <= v54 + v53 or (if not v23 then v32 else if not (v33 >= v54) then v32 else true)
    end

    for index_2 = #v20, 1, -1 do
        v33 = v20[index_2]
        local _ = t_3
        local _ = v33.UID

        if not t_3[v33.UID] then
            if v32 then
                if not v33.parentIconUID then
                    v33:joinMenu(v24)
                elseif not v32 and v33.parentIconUID then
                    v33:leave()
                end
            elseif not v32 and v33.parentIconUID then
                v33:leave()
            end
        end
    end

    local _ = v33.parentIconUID

    if v24.isEnabled ~= v32 then
        v24:setEnabled(v32)
    end

    if v24.isEnabled and not v24.overflowAlreadyOpened then
        v24.overflowAlreadyOpened = true
        v24:select()
    end
end

return t
