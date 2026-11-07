-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.RbxCharacterSounds.AtomicBinding
-- Class: ModuleScript
-- bytes: 7706

local function parsePath(arg1) -- line: 4
    local v1 = string.split(arg1, "/")

    for index = #v1, 1, -1 do
        if v1[index] == "" then
            table.remove(v1, index)
        end
    end

    return v1
end

local _ = function(arg2, arg3) --[[ isManifestResolved ]] -- line: 14
    local v2 = 0

    for _, _ in pairs(arg2) do
        v2 += 1
    end

    assert(arg3 >= v2, v2)

    return if v2 ~= arg3 then false else true
end

local function unbindNodeDescend(arg4, arg5) -- line: 24
    -- upvalues:
    --  [1] unbindNodeDescend (copy)

    if arg4.instance == nil then
        return
    end

    arg4.instance = nil
    local Connections = arg4.connections

    if Connections then
        for _, val_1 in ipairs(Connections) do
            val_1:Disconnect()
        end

        table.clear(Connections)
    end

    if arg5 and arg4.alias then
        arg5[arg4.alias] = nil
    end

    local Children = arg4.children

    if Children then
        for _, val_2 in pairs(Children) do
            unbindNodeDescend(val_2, arg5)
        end
    end
end

local t = {}
t.__index = t

function t.new(arg6, arg7) -- line: 54
    -- upvalues:
    --  [1] parsePath (copy)
    --  [2] t (copy)

    local t_5 = {}
    local v5 = 1

    for key_3, val_3 in pairs(arg6) do
        t_5[key_3] = parsePath(val_3)
        v5 += 1
    end

    return (setmetatable(
        {
            _boundFn = arg7,
            _parsedManifest = t_5,
            _manifestSizeTarget = v5,
            _dtorMap = {},
            _connections = {},
            _rootInstToRootNode = {},
            _rootInstToManifest = {}
        },
        t
    ))
end

function t._startBoundFn(arg8, arg9, arg10) -- line: 80
    local DtorMap = arg8._dtorMap
    local v6 = DtorMap[arg9]
    local BoundFn = arg8._boundFn

    if v6 then
        v6()
        DtorMap[arg9] = nil
    end

    local v7 = BoundFn(arg10)

    if v7 then
        DtorMap[arg9] = v7
    end
end

function t._stopBoundFn(arg11, arg12) -- line: 96
    local DtorMap_1 = arg11._dtorMap
    local v8 = DtorMap_1[arg12]

    if v8 then
        v8()
        DtorMap_1[arg12] = nil
    end
end

function t.bindRoot(arg13, arg14) -- line: 106
    -- upvalues:
    --  [1] unbindNodeDescend (copy)

    debug.profilebegin("AtomicBinding:BindRoot")
    local ParsedManifest = arg13._parsedManifest
    local v9 = arg13._rootInstToRootNode
    local RootInstToManifest = arg13._rootInstToManifest
    local ManifestSizeTarget = arg13._manifestSizeTarget
    assert(if RootInstToManifest[arg14] ~= nil then false else true)
    local t_7 = {}
    RootInstToManifest[arg14] = t_7
    debug.profilebegin("BuildTree")
    local t_8 = { alias = "root", instance = arg14 }

    if next(ParsedManifest) then
        t_8.children = {}
        t_8.connections = {}
    end

    v9[arg14] = t_8

    for key_4, val_4 in pairs(ParsedManifest) do
        v9 = t_8

        for key_5, val_5 in ipairs(val_4) do
            local v11 = key_5 == #val_4
            local v12 = v9.children[val_5] or {}

            if v11 then
                if v12.alias ~= nil then
                    error("Multiple aliases assigned to one instance")
                end

                v12.alias = key_4
            else
                v12.children = v12.children or {}
                v12.connections = v12.connections or {}
            end

            v9.children[val_5], v9 = v12, v12
        end
    end

    debug.profileend()

    local function processNode(arg15) -- line: 160
        -- upvalues:
        --  [1] t_7 (copy)
        --  [2] processNode (copy)
        --  [3] arg13 (copy)
        --  [4] arg14 (copy)
        --  [5] unbindNodeDescend (ref)
        --  [6] ManifestSizeTarget (copy)

        local v14 = assert(arg15.instance)
        local Children_1 = arg15.children
        local Alias = arg15.alias
        local v15 = not Children_1

        if Alias then
            t_7[Alias] = v14
        end

        if not v15 then
            local function processAddChild(arg16) -- line: 172
                -- upvalues:
                --  [1] Children_1 (copy)
                --  [2] processNode (ref)

                local v16 = Children_1[arg16.Name]

                if not v16 or v16.instance ~= nil then
                    return
                end

                v16.instance = arg16
                processNode(v16)
            end

            local function processDeleteChild(arg17) -- line: 183
                -- upvalues:
                --  [1] Children_1 (copy)
                --  [2] arg13 (ref)
                --  [3] arg14 (ref)
                --  [4] unbindNodeDescend (ref)
                --  [5] t_7 (ref)
                --  [6] v14 (copy)
                --  [7] processNode (ref)

                local Name = arg17.Name
                local v17 = Children_1[Name]

                if not v17 then
                    return
                end

                if v17.instance ~= arg17 then
                    return
                end

                arg13:_stopBoundFn(arg14)
                unbindNodeDescend(v17, t_7)
                assert(if v17.instance ~= nil then false else true)
                local v19 = v14:FindFirstChild(Name)

                if v19 then
                    local v20 = Children_1[v19.Name]

                    if v20 then
                        if v20.instance ~= nil then
                            return
                        end

                        v20.instance = v19
                        processNode(v20)
                    end
                end
            end

            for _, val_6 in ipairs(v14:GetChildren()) do
                local v22 = Children_1[val_6.Name]

                if v22 and v22.instance == nil then
                    v22.instance = val_6
                    processNode(v22)
                end
            end

            table.insert(arg15.connections, v14.ChildAdded:Connect(processAddChild))
            table.insert(arg15.connections, v14.ChildRemoved:Connect(processDeleteChild))
        end

        if v15 then
            local v23 = ManifestSizeTarget
            local v24 = 0

            for _, _ in pairs(t_7) do
                v24 += 1
            end

            assert(v23 >= v24, v24)

            if if v24 ~= v23 then false else true then
                arg13:_startBoundFn(arg14, t_7)
            end
        end
    end

    debug.profilebegin("ResolveTree")
    processNode(t_8)
    debug.profileend()
    debug.profileend()
end

function t.unbindRoot(arg18, arg19) -- line: 236
    -- upvalues:
    --  [1] unbindNodeDescend (copy)

    local RootInstToRootNode = arg18._rootInstToRootNode
    local RootInstToManifest_1 = arg18._rootInstToManifest
    arg18:_stopBoundFn(arg19)
    local v26 = RootInstToRootNode[arg19]

    if v26 then
        unbindNodeDescend(v26, (assert(RootInstToManifest_1[arg19])))
        RootInstToRootNode[arg19] = nil
    end

    RootInstToManifest_1[arg19] = nil
end

function t.destroy(arg20) -- line: 252
    -- upvalues:
    --  [1] unbindNodeDescend (copy)

    debug.profilebegin("AtomicBinding:destroy")

    for _, val_8 in pairs(arg20._dtorMap) do
        val_8:destroy()
    end

    table.clear(arg20._dtorMap)

    for _, val_9 in ipairs(arg20._connections) do
        val_9:Disconnect()
    end

    table.clear(arg20._connections)
    local RootInstToManifest_2 = arg20._rootInstToManifest

    for key_10, val_10 in pairs(arg20._rootInstToRootNode) do
        unbindNodeDescend(val_10, (assert(RootInstToManifest_2[key_10])))
    end

    table.clear(arg20._rootInstToManifest)
    table.clear(arg20._rootInstToRootNode)
    debug.profileend()
end

return t
