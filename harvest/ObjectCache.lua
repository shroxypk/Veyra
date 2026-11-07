-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.obj.ObjectCache
-- Class: ModuleScript
-- bytes: 6606

local ModUtility_m = require("../mod/utility")
local t = {}
t.__index = t

local _ = function(arg1, arg2) --[[ reconcile ]] -- line: 39
    for key, val in arg2 do
        if arg1[key] == nil then
            arg1[key] = val
        end
    end

    return arg1
end

local t_1 = table.create(10000)
local t_2 = table.create(10000)
local v1 = false
local thread = coroutine.create(function() -- line: 54
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] t_2 (copy)
    --  [3] v1 (ref)

    while true do
        workspace:BulkMoveTo(t_1, t_2, Enum.BulkMoveMode.FireCFrameChanged)
        table.clear(t_1)
        table.clear(t_2)
        v1 = false
        coroutine.yield()
    end
end)

function t.new(u1: userdata, u2: userdata?, t1: table?) -- line: 67
    -- upvalues:
    --  [1] t (copy)

    local t_3 = setmetatable({}, t)
    t_3.ref = u1
    t_3.parent = u2
    t_3.amount = 0
    t_3.restore_amount = 0
    local v2 = t1 or {}

    for key_1, val_1 in { size = 100, excess_lifetime = 30 } do
        if v2[key_1] == nil then
            v2[key_1] = val_1
        end
    end

    t_3.params = v2
    t_3.scope = { u1, u2 }
    t_3.unused = table.create(t_3.params.size)
    t_3.item_map = {}
    t_3.part_mode = u1:IsA("BasePart")

    for _ = 1, t_3.params.size do
        local _ = t_3.params.size
        t_3:_add()
    end

    table.insert(t_3.scope, task.spawn(function() -- line: 93
        -- upvalues:
        --  [1] t_3 (copy)

        while true do
            if not task.wait(15) then
                break
            end

            if t_3.restore_amount > 0 then
                for _ = 1, t_3.restore_amount do
                    local _ = t_3.restore_amount
                    t_3:_add()
                    local v3 = t_3
                    v3.restore_amount -= 1
                end
            end

            if t_3.amount <= t_3.params.size then
                continue
            end

            local v4 = 0

            for index_2 = 1, #t_3.unused do
                if t_3.amount <= t_3.params.size then
                    break
                end

                local v5 = index_2 - v4
                local v6 = t_3.unused[v5]
                local _ = #t_3.unused

                if v6.dependents == 0 then
                    if not (os.clock() - v6.added > t_3.params.excess_lifetime) then
                        v6:destroy()
                        table.remove(t_3.unused, v5)
                        t_3.item_map[v6.key] = nil
                        local v8 = t_3
                        v8.amount -= 1
                        v4 += 1
                    end
                end
            end
        end
    end))

    return t_3
end

function t._add(arg3: any, arg4: any, b1: boolean?) -- line: 137
    local v9 = arg3.ref:Clone()
    v9.Archivable = false
    v9.Parent = arg3.parent
    local t_4 = { key = arg4, value = v9, added = os.clock(), dependents = 1 }
    local v10 = false

    function t_4.destroy(_) -- line: 152
        -- upvalues:
        --  [1] v10 (ref)
        --  [2] v9 (copy)

        v10 = true
        v9:Destroy()
    end

    arg3.amount += 1
    v9.Destroying:Connect(function() -- line: 159
        -- upvalues:
        --  [1] v10 (ref)
        --  [2] arg3 (copy)
        --  [3] t_4 (copy)

        if v10 then
            return
        end

        local v11 = table.find(arg3.unused, t_4)

        if v11 then
            table.remove(arg3.unused, v11)
        end

        if t_4.key then
            arg3.item_map[t_4.key] = nil
        end

        local v12 = arg3
        v12.amount -= 1
        local v13 = arg3
        v13.restore_amount += 1
    end)

    if arg4 then
        arg3.item_map[arg4] = t_4
    end

    if not b1 then
        table.insert(arg3.unused, t_4)
    end

    return t_4
end

function t.has(arg6, arg7) -- line: 189
    if arg6.item_map[arg7] then
        return true
    end

    return false
end

function t.peek(arg8, arg9) -- line: 193
    return arg8.item_map[arg9]
end

function t.get(arg10, arg11) -- line: 197
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] t_2 (copy)
    --  [3] v1 (ref)
    --  [4] thread (copy)

    local v14

    if arg10:has(arg11) then
        v14 = arg10:peek(arg11)

        if v14 then
            v14.dependents += 1
        end

        return v14.value
    end

    v14 = table.remove(arg10.unused)

    if v14 then
        v14.key = arg11
        v14.added = os.clock()
        arg10.item_map[arg11] = v14
    else
        v14 = arg10:_add(arg11, true)
    end

    if arg10.part_mode then
        local t_5 = {}

        function t_5.__newindex(_, arg13, arg14) -- line: 222
            -- upvalues:
            --  [1] t_1 (ref)
            --  [2] v14 (ref)
            --  [3] t_2 (ref)
            --  [4] v1 (ref)
            --  [5] thread (ref)

            if arg13 == "CFrame" then
                table.insert(t_1, v14.value)
                table.insert(t_2, arg14)

                if not v1 then
                    v1 = true
                    task.defer(thread)

                    return
                end
            else
                v14.value[arg13] = arg14
            end
        end

        function t_5.__index(_, arg16) -- line: 236
            -- upvalues:
            --  [1] v14 (ref)

            local v15 = v14.value[arg16]

            if typeof(v15) == "function" then
                return function(_, ...) -- line: 240
                    -- upvalues:
                    --  [1] v15 (copy)
                    --  [2] v14 (ref)

                    return v15(v14.value, ...)
                end
            end

            return v15
        end

        local t_6 = { _getReal = nil }

        function t_6._getReal() -- line: 249
            -- upvalues:
            --  [1] v14 (ref)

            return v14.value
        end

        return (setmetatable(t_6, t_5))
    end

    return v14.value
end

function t.free(arg18, arg19) -- line: 258
    local v16 = arg18.item_map[arg19]

    if not v16 then
        return
    end

    v16.dependents = math.max(v16.dependents - 1, 0)

    if v16.dependents == 0 then
        v16.added = os.clock()

        if arg18.params.on_free then
            arg18.params.on_free(v16)
        end

        table.insert(arg18.unused, v16)
    end
end

function t.destroy(arg20) -- line: 278
    -- upvalues:
    --  [1] ModUtility_m (copy)

    ModUtility_m.cleanupScope(arg20.scope)

    for _, val_2 in arg20.item_map do
        val_2.value:Destroy()
    end

    table.clear(arg20.unused)
    table.clear(arg20.item_map)
end

return t
