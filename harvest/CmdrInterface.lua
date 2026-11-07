-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.CmdrInterface
-- Class: ModuleScript
-- bytes: 6079

local LocalPlayer = game:GetService("Players").LocalPlayer

return function(arg1) -- line: 6
    -- upvalues:
    --  [1] LocalPlayer (copy)

    local Util = arg1.Util
    local Window_m = require(script:WaitForChild("Window"))
    Window_m.Cmdr = arg1
    local v2 = require(script:WaitForChild("AutoComplete"))(arg1)
    Window_m.AutoComplete = v2

    function Window_m.ProcessEntry(arg2) -- line: 17
        -- upvalues:
        --  [1] Util (copy)
        --  [2] Window_m (copy)
        --  [3] arg1 (copy)
        --  [4] LocalPlayer (ref)

        arg2 = Util.TrimString(arg2)

        if #arg2 == 0 then
            return
        end

        Window_m:AddLine(Window_m:GetLabel() .. " " .. arg2, Color3.fromRGB(255, 223, 93))
        Window_m:AddLine(arg1.Dispatcher:EvaluateAndRun(arg2, LocalPlayer, { IsHuman = true }))
    end

    function Window_m.OnTextChanged(arg3) -- line: 30
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] LocalPlayer (ref)
        --  [3] Util (copy)
        --  [4] Window_m (copy)
        --  [5] v2 (copy)

        local v6 = arg1.Dispatcher:Evaluate(arg3, LocalPlayer, true)
        local v7 = Util.SplitString(arg3)
        local v8 = table.remove(v7, 1)
        local v9 = false

        if v6 then
            v7 = Util.MashExcessArguments(v7, #v6.Object.Args)
            v9 = #v7 == #v6.Object.Args
        end

        local v10 = v8

        if v10 then
            v10 = #v7 > 0 and true
        end

        if arg3:sub(#arg3, #arg3):match("%s") and not v9 then
            v10 = true
            v7[#v7 + 1] = ""
        end

        if v6 and v10 then
            local v13, v14 = v6:Validate()
            Window_m:SetIsValidInput(v13, ("Validation errors: %s"):format(v14 or ""))
            local t = {}
            local v16 = #v7
            local v17 = v6:GetArgument(v16)

            if v17 then
                local TextSegmentInProgress = v17.TextSegmentInProgress
                v16 = false
                local v18

                if v17.RawSegmentsAreAutocomplete then
                    for key, val in ipairs(v17.RawSegments) do
                        t[key] = { val, val }
                    end
                else
                    local v19
                    v18, v19 = v17:GetAutocomplete()
                    v16 = (v19 or {}).IsPartial or false

                    for key_1, val_1 in pairs(v18) do
                        t[key_1] = { TextSegmentInProgress, val_1 }
                    end
                end

                v18 = true

                if #TextSegmentInProgress > 0 then
                    v18, v14 = v17:Validate()
                end

                if not v9 and v18 then
                    Window_m:HideInvalidState()
                end

                local v21 = v2
                local t_3 = {
                    at = nil,
                    prefix = nil,
                    isLast = nil,
                    numArgs = nil,
                    command = nil,
                    arg = nil,
                    name = nil,
                    type = nil,
                    description = nil,
                    invalid = nil,
                    isPartial = nil
                }
                local v23 = v9

                if v23 then
                    local v24 = #arg3 - #TextSegmentInProgress
                    v23 = v24 + (if arg3:sub(#arg3, #arg3):match("%s") then -1 else 0)
                end

                t_3.at = v23
                v23 = if #v17.RawSegments ~= 1 then "" else v17.Prefix or ""
                t_3.prefix = v23
                v23 = if #v6.Arguments ~= #v6.ArgumentDefinitions then false else #TextSegmentInProgress > 0
                t_3.isLast = v23
                t_3.numArgs = #v7
                t_3.command = v6
                t_3.arg = v17
                local v28 = if not v17.Required then "?" else ""
                t_3.name = v17.Name .. v28
                t_3.type = v17.Type.DisplayName
                local v29 = v14

                if v18 ~= false or not v29 then
                    v29 = v17.Object.Description
                end

                t_3.description = v29
                t_3.invalid = not v18
                t_3.isPartial = v16

                return v21:Show(t, t_3)
            end
        elseif v8 and #v7 == 0 then
            Window_m:SetIsValidInput(true)
            local v30 = arg1.Registry:GetCommand(v8)
            local v31 = nil

            if v30 then
                local v32 = { v30.Name, v30.Name }
                v32.options = { name = v30.Name, description = v30.Description }
                v31 = v32
                v32 = v30.Args and v30.Args[1]

                if type(v32) == "function" then
                    v32 = v32(v6)
                end

                if v32 and not v32.Optional and v32.Default == nil then
                    Window_m:SetIsValidInput(false, "This command has required arguments.")
                    Window_m:HideInvalidState()
                end
            else
                Window_m:SetIsValidInput(
                    false,
                    ("%q is not a valid command name. Use the help command to see all available commands."):format(
                        v8
                    )
                )
            end

            local t_1 = { v31 }

            for _, val_2 in pairs(arg1.Registry:GetCommandNames()) do
                if v8:lower() == val_2:lower():sub(1, #v8) and (v31 == nil or v31[1] ~= v8) then
                    local v38 = arg1.Registry:GetCommand(val_2)
                    local t_2 = { v8, val_2 }
                    t_2.options = { name = v38.Name, description = v38.Description }
                    t_1[#t_1 + 1] = t_2
                end
            end

            return v2:Show(t_1)
        end

        Window_m:SetIsValidInput(false, "Use the help command to see all available commands.")
        v2:Hide()
    end

    Window_m:UpdateLabel()
    Window_m:UpdateWindowHeight()

    return { Window = Window_m, AutoComplete = v2 }
end
