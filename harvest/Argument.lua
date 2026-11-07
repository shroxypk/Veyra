-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Shared.Argument
-- Class: ModuleScript
-- bytes: 6927

local Util_m = require(script.Parent.Util)

local function unescapeOperators(arg1) -- line: 3
    for _, val in ipairs({ "%.", "%?", "%*", "%*%*" }) do
        arg1 = arg1:gsub("\\" .. val, val:gsub("%%", ""))
    end

    return arg1
end

local t = {}
t.__index = t

function t.new(arg2, arg3, arg4) -- line: 15
    -- upvalues:
    --  [1] Util_m (copy)
    --  [2] t (copy)

    local t_1 = {
        Command = arg2,
        Type = nil,
        Name = arg3.Name,
        Object = arg3,
        Required = if arg3.Default ~= nil then false else arg3.Optional ~= true,
        Executor = arg2.Executor,
        RawValue = arg4,
        RawSegments = {},
        TransformedValues = {},
        Prefix = "",
        TextSegmentInProgress = "",
        RawSegmentsAreAutocomplete = false
    }

    if type(arg3.Type) == "table" then
        t_1.Type = arg3.Type
    else
        local v3, v4, v5 = Util_m.ParsePrefixedUnionType(
            arg2.Cmdr.Registry:GetTypeName(arg3.Type),
            arg4
        )
        t_1.Type = arg2.Dispatcher.Registry:GetType(v3)
        t_1.RawValue = v4
        t_1.Prefix = v5

        if t_1.Type == nil then
            error(
                string.format(
                    "%s has an unregistered type %q",
                    t_1.Name or "<none>",
                    v3 or "<none>"
                )
            )
        end
    end

    setmetatable(t_1, t)
    t_1:Transform()

    return t_1
end

function t.GetDefaultAutocomplete(arg5) -- line: 55
    if arg5.Type.Autocomplete then
        local v6, v7 = arg5.Type.Autocomplete(arg5:TransformSegment(""))

        return v6, v7 or {}
    end

    return {}
end

function t.Transform(arg6) -- line: 67
    -- upvalues:
    --  [1] unescapeOperators (copy)
    --  [2] Util_m (copy)

    if #arg6.TransformedValues ~= 0 then
        return
    end

    local v9 = arg6.RawValue

    if arg6.Type.ArgumentOperatorAliases then
        v9 = arg6.Type.ArgumentOperatorAliases[v9] or v9
    end

    if v9 == "." and arg6.Type.Default then
        v9 = arg6.Type.Default(arg6.Executor) or ""
        arg6.RawSegmentsAreAutocomplete = true
    end

    if v9 == "?" and arg6.Type.Autocomplete then
        local v10, v11 = arg6:GetDefaultAutocomplete()

        if not v11.IsPartial and #v10 > 0 then
            v9 = v10[math.random(1, #v10)]
            arg6.RawSegmentsAreAutocomplete = true
        end
    end

    if arg6.Type.Listable and #arg6.RawValue > 0 then
        local v12 = v9:match("^%?(%d+)$")

        if v12 then
            local num = tonumber(v12)

            if num and num > 0 then
                local t_2 = {}
                local v13, v14 = arg6:GetDefaultAutocomplete()

                if not v14.IsPartial and #v13 > 0 then
                    for _ = 1, math.min(num, #v13) do
                        local _ = math.min(num, #v13)
                        table.insert(t_2, table.remove(v13, math.random(1, #v13)))
                    end

                    v9 = table.concat(t_2, ",")
                    arg6.RawSegmentsAreAutocomplete = true
                end
            end
        elseif v9 == "*" or v9 == "**" then
            local v16, v17 = arg6:GetDefaultAutocomplete()

            if not v17.IsPartial and #v16 > 0 then
                if v9 == "**" and arg6.Type.Default then
                    local v18 = arg6.Type.Default(arg6.Executor) or ""

                    for key_1, val_1 in ipairs(v16) do
                        if val_1 == v18 then
                            table.remove(v16, key_1)
                        end
                    end
                end

                v9 = table.concat(v16, ",")
                arg6.RawSegmentsAreAutocomplete = true
            end
        end

        v9 = unescapeOperators(v9)
        local v19 = Util_m.SplitStringSimple(v9, ",")
        v19 = if #v19 ~= 0 then v19 else { "" }

        if v9:sub(#v9, #v9) == "," then
            v19[#v19 + 1] = ""
        end

        for key_2, val_2 in ipairs(v19) do
            arg6.RawSegments[key_2] = val_2
            arg6.TransformedValues[key_2] = { arg6:TransformSegment(val_2) }
        end

        arg6.TextSegmentInProgress = v19[#v19]

        return
    end

    local v22 = unescapeOperators(v9)
    arg6.RawSegments[1] = unescapeOperators(v22)
    arg6.TransformedValues[1] = { arg6:TransformSegment(v22) }
    arg6.TextSegmentInProgress = arg6.RawValue
end

function t.TransformSegment(arg7, arg8) -- line: 159
    if arg7.Type.Transform then
        return arg7.Type.Transform(arg8, arg7.Executor)
    end

    return arg8
end

function t.GetTransformedValue(arg9, arg10) -- line: 168
    return unpack(arg9.TransformedValues[arg10])
end

function t.Validate(arg11, arg12) -- line: 173
    if arg11.RawValue == nil or #arg11.RawValue == 0 and arg11.Required == false then
        return true
    end

    if arg11.Required and (arg11.RawSegments[1] == nil or #arg11.RawSegments[1] == 0) then
        return false, "This argument is required."
    end

    if arg11.Type.Validate or arg11.Type.ValidateOnce then
        for index_1 = 1, #arg11.TransformedValues do
            local _ = #arg11.TransformedValues

            if arg11.Type.Validate then
                local v24, v25 = arg11.Type.Validate(arg11:GetTransformedValue(index_1))

                if not v24 then
                    return v24, v25 or "Invalid value"
                end
            end

            if arg12 and arg11.Type.ValidateOnce then
                local v26, v27 = arg11.Type.ValidateOnce(arg11:GetTransformedValue(index_1))

                if not v26 then
                    return v26, v27
                end
            end
        end

        return true
    end

    return true
end

function t.GetAutocomplete(arg13) -- line: 208
    if arg13.Type.Autocomplete then
        return arg13.Type.Autocomplete(arg13:GetTransformedValue(#arg13.TransformedValues))
    end

    return {}
end

function t.ParseValue(arg14, arg15) -- line: 216
    if arg14.Type.Parse then
        return arg14.Type.Parse(arg14:GetTransformedValue(arg15))
    end

    return arg14:GetTransformedValue(arg15)
end

function t.GetValue(arg16) -- line: 225
    if #arg16.RawValue == 0 and (not arg16.Required and arg16.Object.Default ~= nil) then
        return arg16.Object.Default
    end

    if not arg16.Type.Listable then
        return arg16:ParseValue(1)
    end

    local t_5 = {}

    for index_2 = 1, #arg16.TransformedValues do
        local _ = #arg16.TransformedValues
        local v30 = arg16:ParseValue(index_2)

        if type(v30) ~= "table" then
            error(("Listable types must return a table from Parse (%s)"):format(arg16.Type.Name))
        end

        for _, val_3 in pairs(v30) do
            t_5[val_3] = true
        end
    end

    local t_6 = {}

    for key_4, _ in pairs(t_5) do
        t_6[#t_6 + 1] = key_4
    end

    return t_6
end

return t
