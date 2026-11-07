-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Icon.Features.Themes
-- Class: ModuleScript
-- bytes: 13703

local t = {
    getThemeValue = function(arg1, arg2, arg3, _) --[[ getThemeValue ]] -- line: 16
        if arg1 then
            for _, val in pairs(arg1) do
                local v1, v2, v3 = unpack(val)

                if arg2 == v1 and arg3 == v2 then
                    return v3
                end
            end
        end

        return nil
    end,
    getInstanceValue = function(arg5, arg6) --[[ getInstanceValue ]] -- line: 28
        return if not pcall(function() -- line: 29
            -- upvalues:
            --  [1] arg5 (copy)
            --  [2] arg6 (copy)

            return arg5[arg6]
        end) then arg5:GetAttribute(arg6) else nil
    end,
    getRealInstance = function(arg7) --[[ getRealInstance ]] -- line: 38
        if not arg7:GetAttribute("IsAClippedClone") then
            return
        end

        local OriginalInstance = arg7:FindFirstChild("OriginalInstance")

        if not OriginalInstance then
            return
        end

        return OriginalInstance.Value
    end,
    getClippedClone = function(arg8) --[[ getClippedClone ]] -- line: 49
        if not arg8:GetAttribute("HasAClippedClone") then
            return
        end

        local ClippedClone = arg8:FindFirstChild("ClippedClone")

        if not ClippedClone then
            return
        end

        return ClippedClone.Value
    end
}
local Utility_m = require(script.Parent.Parent.Utility)
local Default_m = require(script.Default)

function t.refresh(arg9, arg10, arg11) -- line: 60
    -- upvalues:
    --  [1] t (copy)

    if arg11 then
        local v6 = t.getThemeValue(arg9:getStateGroup(), arg10.Name, arg11) or t.getInstanceValue(
            arg10,
            arg11
        )
        t.apply(
            arg9,
            arg10,
            arg11,
            v6,
            true
        )

        return
    end

    local v7 = arg9:getStateGroup()

    if not v7 then
        return
    end

    local t_1 = { [arg10.Name] = arg10 }

    for _, val_1 in pairs(arg10:GetDescendants()) do
        local Collective = val_1:GetAttribute("Collective")

        if Collective then
            t_1[Collective] = val_1
        end

        t_1[val_1.Name] = val_1
    end

    for _, val_2 in pairs(v7) do
        local v9, v10, v11 = unpack(val_2)
        local v12 = t_1[v9]

        if v12 then
            t.apply(
                arg9,
                v12.Name,
                v10,
                v11,
                true
            )
        end
    end
end

function t.apply(
    arg12,
    arg13,
    arg14,
    arg15,
    arg16
) -- line: 93
    -- upvalues:
    --  [1] t (copy)

    if arg12.isDestroyed then
        return
    end

    local v13 = arg13
    local v14

    if typeof(arg13) == "Instance" then
        v14 = { arg13 }
        v13 = arg13.Name
    else
        v14 = arg12:getInstanceOrCollective(arg13)
    end

    v13 = arg12.customBehaviours[v13 .. "-" .. arg14]

    for _, val_3 in pairs(v14) do
        local v16 = t.getClippedClone(val_3)

        if v16 then
            table.insert(v14, v16)
        end
    end

    local v19

    for _, val_4 in pairs(v14) do
        if arg14 == "Position" then
            if not t.getClippedClone(val_4) then
                if arg14 == "Size" then
                    if not t.getRealInstance(val_4) then
                        if arg16 or arg15 ~= t.getInstanceValue(val_4, arg14) then
                            v19 = if not v13 then arg15 else if v13(arg15, val_4, arg14) == nil then arg15 else v13(
                                arg15,
                                val_4,
                                arg14
                            )

                            if not pcall(function() -- line: 139
                                -- upvalues:
                                --  [1] val_4 (copy)
                                --  [2] arg14 (copy)
                                --  [3] v19 (ref)

                                val_4[arg14] = v19
                            end) then
                                val_4:SetAttribute(arg14, v19)
                            end
                        end
                    end
                elseif arg16 or arg15 ~= t.getInstanceValue(val_4, arg14) then
                    v19 = if not v13 then arg15 else if v13(arg15, val_4, arg14) == nil then arg15 else v13(
                        arg15,
                        val_4,
                        arg14
                    )

                    if not pcall(function() -- line: 139
                        -- upvalues:
                        --  [1] val_4 (copy)
                        --  [2] arg14 (copy)
                        --  [3] v19 (ref)

                        val_4[arg14] = v19
                    end) then
                        val_4:SetAttribute(arg14, v19)
                    end
                end
            end
        elseif arg14 == "Size" then
            if not t.getRealInstance(val_4) then
                if arg16 or arg15 ~= t.getInstanceValue(val_4, arg14) then
                    v19 = if not v13 then arg15 else if v13(arg15, val_4, arg14) == nil then arg15 else v13(
                        arg15,
                        val_4,
                        arg14
                    )

                    if not pcall(function() -- line: 139
                        -- upvalues:
                        --  [1] val_4 (copy)
                        --  [2] arg14 (copy)
                        --  [3] v19 (ref)

                        val_4[arg14] = v19
                    end) then
                        val_4:SetAttribute(arg14, v19)
                    end
                end
            end
        elseif arg16 or arg15 ~= t.getInstanceValue(val_4, arg14) then
            v19 = if not v13 then arg15 else if v13(arg15, val_4, arg14) == nil then arg15 else v13(
                arg15,
                val_4,
                arg14
            )

            if not pcall(function() -- line: 139
                -- upvalues:
                --  [1] val_4 (copy)
                --  [2] arg14 (copy)
                --  [3] v19 (ref)

                val_4[arg14] = v19
            end) then
                val_4:SetAttribute(arg14, v19)
            end
        end
    end
end

function t.getModifications(arg17) -- line: 153
    if typeof(arg17[1]) ~= "table" then
        arg17 = { arg17 }
    end

    return arg17
end

function t.merge(arg18, arg19, arg20) -- line: 162
    -- upvalues:
    --  [1] t (copy)

    local v20, v21, v22, v23 = table.unpack(arg19)
    local v24, v25, _, v27 = table.unpack(arg18)

    if v20 == v24 and v21 == v25 and t.statesMatch(v23, v27) then
        arg18[3] = v22

        if arg20 then
            arg20(arg18)
        end

        return true
    end

    return false
end

function t.modify(arg21, arg22, arg23) -- line: 175
    -- upvalues:
    --  [1] Utility_m (copy)
    --  [2] t (copy)

    task.spawn(function() -- line: 183
        -- upvalues:
        --  [1] arg23 (ref)
        --  [2] Utility_m (ref)
        --  [3] arg22 (ref)
        --  [4] t (ref)
        --  [5] arg21 (copy)

        local v28 = arg23 or Utility_m.generateUID()
        arg23 = v28
        arg22 = t.getModifications(arg22)
        local v32

        for _, val_5 in pairs(arg22) do
            local v29, v30, v31, v32 = table.unpack(val_5)

            if v32 == nil then
                t.modify(arg21, { v29, v30, v31, "Selected" }, arg23)
                t.modify(arg21, { v29, v30, v31, "Viewing" }, arg23)
            end

            local v33 = Utility_m.formatStateName(v32 or "Deselected")
            local v32 = arg21:getStateGroup(v33)

            local _ = function() --[[ nowSetIt ]] -- line: 195
                -- upvalues:
                --  [1] v33 (copy)
                --  [2] arg21 (ref)
                --  [3] t (ref)
                --  [4] v29 (copy)
                --  [5] v30 (copy)
                --  [6] v31 (copy)

                if v33 == arg21.activeState then
                    t.apply(arg21, v29, v30, v31)
                end
            end

            (function() --[[ updateRecord ]] -- line: 200
                -- upvalues:
                --  [1] v32 (copy)
                --  [2] t (ref)
                --  [3] val_5 (copy)
                --  [4] arg23 (ref)
                --  [5] v33 (copy)
                --  [6] arg21 (ref)
                --  [7] v29 (copy)
                --  [8] v30 (copy)
                --  [9] v31 (copy)

                for _, val_6 in pairs(v32) do
                    if t.merge(val_6, val_5, function(arg24) -- line: 202
                        -- upvalues:
                        --  [1] arg23 (ref)
                        --  [2] v33 (ref)
                        --  [3] arg21 (ref)
                        --  [4] t (ref)
                        --  [5] v29 (ref)
                        --  [6] v30 (ref)
                        --  [7] v31 (ref)

                        arg24[5] = arg23

                        if v33 == arg21.activeState then
                            t.apply(arg21, v29, v30, v31)
                        end
                    end) then
                        return
                    end
                end

                table.insert(v32, { v29, v30, v31, v33, arg23 })

                if v33 == arg21.activeState then
                    t.apply(arg21, v29, v30, v31)
                end
            end)()
        end
    end)

    return arg23
end

function t.remove(arg25, arg26) -- line: 220
    -- upvalues:
    --  [1] t (copy)

    for _, val_7 in pairs(arg25.appearance) do
        for index = #val_7, 1, -1 do
            if val_7[index][5] == arg26 then
                table.remove(val_7, index)
            end
        end
    end

    t.rebuild(arg25)
end

function t.removeWith(arg27, arg28, arg29, arg30) -- line: 233
    -- upvalues:
    --  [1] t (copy)

    for key_8, val_8 in pairs(arg27.appearance) do
        if arg30 == key_8 or not arg30 then
            for index_1 = #val_8, 1, -1 do
                local v34 = val_8[index_1]

                if v34[1] == arg28 and v34[2] == arg29 then
                    table.remove(val_8, index_1)
                end
            end
        end
    end

    t.rebuild(arg27)
end

function t.change(arg31) -- line: 249
    -- upvalues:
    --  [1] t (copy)

    for _, val_9 in pairs((arg31:getStateGroup())) do
        local v36, v37, v38 = unpack(val_9)
        t.apply(arg31, v36, v37, v38)
    end
end

function t.set(arg32, arg33) -- line: 259
    -- upvalues:
    --  [1] t (copy)

    local ThemesJanitor = arg32.themesJanitor
    ThemesJanitor:clean()
    ThemesJanitor:add(arg32.stateChanged:Connect(function() -- line: 265
        -- upvalues:
        --  [1] t (ref)
        --  [2] arg32 (copy)

        t.change(arg32)
    end))

    if typeof(arg33) == "Instance" and arg33:IsA("ModuleScript") then
        arg33 = require(arg33)
    end

    arg32.appliedTheme = arg33
    t.rebuild(arg32)
end

function t.statesMatch(arg34, arg35) -- line: 275
    local v39 = arg34 and string.lower(arg34)
    local v40 = arg35

    if v40 then
        v40 = string.lower(arg35)
    end

    return v39 == v40 or (not arg34 or not arg35)
end

function t.rebuild(arg36) -- line: 282
    -- upvalues:
    --  [1] t (copy)
    --  [2] Utility_m (copy)
    --  [3] Default_m (copy)

    local t_3 = { "Deselected", "Selected", "Viewing" }
    local AppliedTheme = arg36.appliedTheme

    local function generateTheme() -- line: 289
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] t (ref)
        --  [3] Utility_m (ref)
        --  [4] Default_m (ref)
        --  [5] AppliedTheme (copy)
        --  [6] arg36 (copy)

        for _, val_10 in pairs(t_3) do
            local t_4 = {}

            local function updateDetails(arg37, arg38) -- line: 295
                -- upvalues:
                --  [1] t (ref)
                --  [2] Utility_m (ref)
                --  [3] t_4 (copy)

                if not arg37 then
                    return
                end

                for _, val_11 in pairs(arg37) do
                    local v42 = val_11[5]

                    if t.statesMatch(arg38, val_11[4]) then
                        local v43 = val_11[1] .. "-" .. val_11[2]
                        local v44 = Utility_m.copyTable(val_11)
                        v44[5] = v42
                        t_4[v43] = v44
                    end
                end
            end

            if val_10 == "Selected" then
                updateDetails(Default_m, "Deselected")
            end

            updateDetails(Default_m, "Empty")
            updateDetails(Default_m, val_10)

            if AppliedTheme ~= Default_m then
                if val_10 == "Selected" then
                    updateDetails(AppliedTheme, "Deselected")
                end

                updateDetails(Default_m, "Empty")
                updateDetails(AppliedTheme, val_10)
            end

            local t_5 = {}
            local v45 = arg36.appearance[val_10]

            if v45 then
                for _, val_12 in pairs(v45) do
                    local v46 = val_12[5]

                    if v46 ~= nil then
                        table.insert(t_5, { val_12[1], val_12[2], val_12[3], val_10, v46 })
                    end
                end
            end

            updateDetails(t_5, val_10)
            local t_7 = {}

            for _, val_13 in pairs(t_4) do
                table.insert(t_7, val_13)
            end

            arg36.appearance[val_10] = t_7
        end

        t.change(arg36)
    end

    generateTheme()
end

return t
