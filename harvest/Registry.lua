-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Shared.Registry
-- Class: ModuleScript
-- bytes: 8868

local RunService = game:GetService("RunService")
local Util_m = require(script.Parent.Util)
local t = {
    TypeMethods = Util_m.MakeDictionary(
        {
            "Transform",
            "Validate",
            "Autocomplete",
            "Parse",
            "DisplayName",
            "Listable",
            "ValidateOnce",
            "Prefixes",
            "Default",
            "ArgumentOperatorAliases"
        }
    ),
    CommandMethods = Util_m.MakeDictionary(
        {
            "Name",
            "Aliases",
            "AutoExec",
            "Description",
            "Args",
            "Run",
            "ClientRun",
            "Data",
            "Group"
        }
    ),
    CommandArgProps = Util_m.MakeDictionary(
        { "Name", "Type", "Description", "Optional", "Default" }
    ),
    Types = {},
    TypeAliases = {},
    Commands = {},
    CommandsArray = {},
    Cmdr = nil,
    Hooks = { BeforeRun = {}, AfterRun = {} },
    Stores = setmetatable({}, {
        __index = function(arg1, arg2) --[[ __index ]] -- line: 20
            arg1[arg2] = {}

            return arg1[arg2]
        end
    }),
    AutoExecBuffer = {}
}

function t.RegisterType(arg3, arg4, arg5) -- line: 30
    if arg4 then
        if typeof(arg4) ~= "string" then
            error("Invalid type name provided: nil")
        end
    else
        error("Invalid type name provided: nil")
    end

    if not arg4:find("^[%d%l]%w*$") then
        error(
            ("Invalid type name provided: \"%s\", type names must be alphanumeric and start with a lower-case letter or a digit."):format(
                arg4
            )
        )
    end

    for key, _ in pairs(arg5) do
        if arg3.TypeMethods[key] == nil then
            error("Unknown key/method in type \"" .. arg4 .. "\": " .. key)
        end
    end

    if arg3.Types[arg4] ~= nil then
        error(("Type \"%s\" has already been registered."):format(arg4))
    end

    arg5.Name = arg4
    arg5.DisplayName = arg5.DisplayName or arg4
    arg3.Types[arg4] = arg5

    if arg5.Prefixes then
        arg3:RegisterTypePrefix(arg4, arg5.Prefixes)
    end
end

function t.RegisterTypePrefix(arg6, arg7, arg8) -- line: 59
    if not arg6.TypeAliases[arg7] then
        arg6.TypeAliases[arg7] = arg7
    end

    arg6.TypeAliases[arg7] = ("%s %s"):format(arg6.TypeAliases[arg7], arg8)
end

function t.RegisterTypeAlias(arg9, arg10, arg11) -- line: 67
    assert(
        if arg9.TypeAliases[arg10] ~= nil then false else true,
        ("Type alias %s already exists!"):format(arg11)
    )
    arg9.TypeAliases[arg10] = arg11
end

function t.RegisterTypesIn(arg12, arg13) -- line: 73
    for _, child in pairs(arg13:GetChildren()) do
        if child:IsA("ModuleScript") then
            child.Parent = arg12.Cmdr.ReplicatedRoot.Types
            require(child)(arg12)
        else
            arg12:RegisterTypesIn(child)
        end
    end
end

t.RegisterHooksIn = t.RegisterTypesIn

function t.RegisterCommandObject(arg14, arg15, _) -- line: 90
    -- upvalues:
    --  [1] RunService (copy)

    for key_2, _ in pairs(arg15) do
        if arg14.CommandMethods[key_2] == nil then
            error(
                "Unknown key/method in command " .. (arg15.Name or "unknown command") .. ": " .. key_2
            )
        end
    end

    if arg15.Args then
        for key_3, val_2 in pairs(arg15.Args) do
            if type(val_2) == "table" then
                for key_4, _ in pairs(val_2) do
                    if arg14.CommandArgProps[key_4] == nil then
                        error(
                            ("Unknown property in command \"%s\" argument #%d: %s"):format(
                                arg15.Name or "unknown",
                                key_3,
                                key_4
                            )
                        )
                    end
                end
            end
        end
    end

    if arg15.AutoExec and RunService:IsClient() then
        table.insert(arg14.AutoExecBuffer, arg15.AutoExec)
        arg14:FlushAutoExecBufferDeferred()
    end

    local v3 = arg14.Commands[arg15.Name:lower()]

    if v3 and v3.Aliases then
        for _, val_4 in pairs(v3.Aliases) do
            arg14.Commands[val_4:lower()] = nil
        end
    elseif not v3 then
        table.insert(arg14.CommandsArray, arg15)
    end

    arg14.Commands[arg15.Name:lower()] = arg15

    if arg15.Aliases then
        for _, val_5 in pairs(arg15.Aliases) do
            arg14.Commands[val_5:lower()] = arg15
        end
    end
end

function t.RegisterCommand(arg17, arg18, arg19, arg20) -- line: 135
    -- upvalues:
    --  [1] RunService (copy)

    local v4 = require(arg18)
    local v5 = if typeof(v4) ~= "table" then false else true
    local Name = arg18.Name
    local v6 = typeof(v4)
    assert(
        v5,
        `Invalid return value from command script "{Name}" (CommandDefinition expected, got {v6})`
    )

    if arg19 then
        assert(
            RunService:IsServer(),
            "The commandServerScript parameter is not valid for client usage."
        )
        v4.Run = require(arg19)
    end

    if arg20 and not arg20(v4) then
        return
    end

    arg17:RegisterCommandObject(v4)
    arg18.Parent = arg17.Cmdr.ReplicatedRoot.Commands
end

function t.RegisterCommandsIn(arg21, arg22, arg23) -- line: 157
    local t_3 = {}
    local t_4 = {}

    for _, child_1 in pairs(arg22:GetChildren()) do
        if child_1:IsA("ModuleScript") then
            if not child_1.Name:find("Server") then
                local v10 = arg22:FindFirstChild(child_1.Name .. "Server")

                if v10 then
                    t_4[v10] = true
                end

                arg21:RegisterCommand(child_1, v10, arg23)
            else
                t_3[child_1] = true
            end
        else
            arg21:RegisterCommandsIn(child_1, arg23)
        end
    end

    for key_8, _ in pairs(t_3) do
        if not t_4[key_8] then
            warn(
                "Command script " .. key_8.Name .. " was skipped because it has 'Server' in its name, and has no equivalent shared script."
            )
        end
    end
end

function t.RegisterDefaultCommands(arg24, arg25) -- line: 187
    -- upvalues:
    --  [1] RunService (copy)
    --  [2] Util_m (copy)

    assert(RunService:IsServer(), "RegisterDefaultCommands cannot be called from the client.")
    local v12 = if type(arg25) ~= "table" then false else true

    if v12 then
        arg25 = Util_m.MakeDictionary(arg25)
    end

    arg24:RegisterCommandsIn(arg24.Cmdr.DefaultCommandsFolder, v12 and function(arg26) -- line: 196
        -- upvalues:
        --  [1] arg25 (ref)

        return arg25[arg26.Group] or false
    end or arg25)
end

function t.GetCommand(arg27, arg28) -- line: 202
    return arg27.Commands[(arg28 or ""):lower()]
end

function t.GetCommands(arg29) -- line: 208
    return arg29.CommandsArray
end

function t.GetCommandNames(arg30) -- line: 213
    local t_5 = {}

    for _, val_7 in pairs(arg30.CommandsArray) do
        table.insert(t_5, val_7.Name)
    end

    return t_5
end

t.GetCommandsAsStrings = t.GetCommandNames

function t.GetTypeNames(arg31) -- line: 226
    local t_6 = {}

    for key_10, _ in pairs(arg31.Types) do
        table.insert(t_6, key_10)
    end

    return t_6
end

function t.GetType(arg32, arg33) -- line: 238
    return arg32.Types[arg33]
end

function t.GetTypeName(arg34, arg35) -- line: 243
    return arg34.TypeAliases[arg35] or arg35
end

function t.RegisterHook(arg36, arg37, arg38, arg39) -- line: 248
    if not arg36.Hooks[arg37] then
        error(("Invalid hook name: %q"):format(arg37), 2)
    end

    table.insert(arg36.Hooks[arg37], { callback = arg38, priority = arg39 or 0 })
    table.sort(arg36.Hooks[arg37], function(arg40, arg41) -- line: 254
        return arg40.priority < arg41.priority
    end)
end

t.AddHook = t.RegisterHook

function t.GetStore(arg42, arg43) -- line: 262
    return arg42.Stores[arg43]
end

function t.FlushAutoExecBufferDeferred(arg44) -- line: 267
    -- upvalues:
    --  [1] RunService (copy)

    if arg44.AutoExecFlushConnection then
        return
    end

    arg44.AutoExecFlushConnection = RunService.Heartbeat:Connect(function() -- line: 272
        -- upvalues:
        --  [1] arg44 (copy)

        arg44.AutoExecFlushConnection:Disconnect()
        arg44.AutoExecFlushConnection = nil
        arg44:FlushAutoExecBuffer()
    end)
end

function t.FlushAutoExecBuffer(arg45) -- line: 280
    for _, val_9 in ipairs(arg45.AutoExecBuffer) do
        for _, val_10 in ipairs(val_9) do
            arg45.Cmdr.Dispatcher:EvaluateAndRun(val_10)
        end
    end

    arg45.AutoExecBuffer = {}
end

return function(arg46) -- line: 290
    -- upvalues:
    --  [1] t (copy)

    t.Cmdr = arg46

    return t
end
