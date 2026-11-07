-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Shared.Dispatcher
-- Class: ModuleScript
-- bytes: 5924

local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local Util_m = require(script.Parent.Util)
local Command_m = require(script.Parent.Command)
local v1 = false
local t = {
    Cmdr = nil,
    Registry = nil,
    Evaluate = function(
        arg1,
        arg2,
        arg3,
        arg4,
        arg5
    ) --[[ Evaluate ]] -- line: 21
        -- upvalues:
        --  [1] RunService (copy)
        --  [2] Players (copy)
        --  [3] Util_m (copy)
        --  [4] Command_m (copy)

        if RunService:IsClient() == true and arg3 ~= Players.LocalPlayer then
            error("Can't evaluate a command that isn't sent by the local player.")
        end

        local v2 = Util_m.SplitString(arg2)
        local v3 = table.remove(v2, 1)
        local v4 = arg1.Registry:GetCommand(v3)

        if v4 then
            local v5 = Command_m.new(
                {
                    Dispatcher = arg1,
                    Text = arg2,
                    CommandObject = v4,
                    Alias = v3,
                    Executor = arg3,
                    Arguments = Util_m.MashExcessArguments(v2, #v4.Args),
                    Data = arg5
                }
            )
            local v6, v7 = v5:Parse(arg4)

            if v6 then
                return v5
            end

            return false, v7
        else
            return false, ("%q is not a valid command name. Use the help command to see all available commands."):format(
                (tostring(v3))
            )
        end
    end,
    EvaluateAndRun = function(arg6, arg7, arg8, arg9) --[[ EvaluateAndRun ]] -- line: 58
        -- upvalues:
        --  [1] Players (copy)
        --  [2] RunService (copy)

        local v8 = arg8 or Players.LocalPlayer
        local v9 = v8
        v8 = arg9 or {}
        arg9 = v8

        if RunService:IsClient() and arg9.IsHuman then
            arg6:PushHistory(arg7)
        end

        local v10, v11 = arg6:Evaluate(arg7, v9, nil, arg9.Data)

        if not v10 then
            return v11
        end

        local Success, Result = xpcall(function() -- line: 72
            -- upvalues:
            --  [1] v10 (copy)

            local v12, v13 = v10:Validate(true)

            if not v12 then
                return v13
            end

            return v10:Run() or "Command executed."
        end, function(arg10) -- line: 80
            return debug.traceback((tostring(arg10)))
        end)

        if not Success then
            warn(
                ("Error occurred while evaluating command string %q\n%s"):format(
                    arg7,
                    (tostring(Result))
                )
            )
        end

        return Success and Result or "An error occurred while running this command. Check the console for more information."
    end,
    Send = function(arg11, arg12, arg13) --[[ Send ]] -- line: 92
        -- upvalues:
        --  [1] RunService (copy)

        if RunService:IsClient() == false then
            error("Dispatcher:Send can only be called from the client.")
        end

        return arg11.Cmdr.RemoteFunction:InvokeServer(arg12, { Data = arg13 })
    end,
    Run = function(arg14, ...) --[[ Run ]] -- line: 104
        -- upvalues:
        --  [1] Players (copy)

        if not Players.LocalPlayer then
            error("Dispatcher:Run can only be called from the client.")
        end

        local t_3 = { ... }
        local v15 = t_3[1]

        for index = 2, #t_3 do
            v15 ..= " " .. tostring(t_3[index])
        end

        local v16, v17 = arg14:Evaluate(v15, Players.LocalPlayer)

        if not v16 then
            error(v17)
        end

        local v18, v19 = v16:Validate(true)

        if not v18 then
            error(v19)
        end

        return v16:Run()
    end
}

function t.RunHooks(arg15, arg16, arg17, ...) -- line: 132
    -- upvalues:
    --  [1] RunService (copy)
    --  [2] v1 (ref)

    if not arg15.Registry.Hooks[arg16] then
        error(("Invalid hook name: %q"):format(arg16), 2)
    end

    if arg16 == "BeforeRun" and #arg15.Registry.Hooks[arg16] == 0 and arg17.Group ~= "DefaultUtil" and arg17.Group ~= "UserAlias" and arg17:HasImplementation() then
        if RunService:IsStudio() then
            if v1 == false then
                arg17:Reply(
                    (if RunService:IsServer() then "<Server>" else "<Client>") .. " Commands will not run in-game if no BeforeRun hook is configured. Learn more: https://eryn.io/Cmdr/guide/Hooks.html",
                    Color3.fromRGB(255, 228, 26)
                )
                v1 = true
            end
        else
            return "Command blocked for security as no BeforeRun hook is configured."
        end
    end

    for _, val in ipairs(arg15.Registry.Hooks[arg16]) do
        local v22 = val.callback(arg17, ...)

        if v22 ~= nil then
            return (tostring(v22))
        end
    end
end

function t.PushHistory(arg18, arg19) -- line: 164
    -- upvalues:
    --  [1] RunService (copy)
    --  [2] Util_m (copy)
    --  [3] TeleportService (copy)

    assert(RunService:IsClient(), "PushHistory may only be used from the client.")
    local v24 = arg18:GetHistory()

    if Util_m.TrimString(arg19) == "" or arg19 == v24[#v24] then
        return
    end

    v24[#v24 + 1] = arg19
    TeleportService:SetTeleportSetting("CmdrCommandHistory", v24)
end

function t.GetHistory(_) -- line: 179
    -- upvalues:
    --  [1] RunService (copy)
    --  [2] TeleportService (copy)

    assert(RunService:IsClient(), "GetHistory may only be used from the client.")

    return TeleportService:GetTeleportSetting("CmdrCommandHistory") or {}
end

return function(arg21) -- line: 185
    -- upvalues:
    --  [1] t (copy)

    t.Cmdr = arg21
    t.Registry = arg21.Registry

    return t
end
