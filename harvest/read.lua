-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.process.read
-- Class: ModuleScript
-- bytes: 6410

local RunService: any = game:GetService("RunService")
local PacketIDs_m: any = require(script.Parent.Parent.namespaces.packetIDs)
local QueryIDs_m: any = require(script.Parent.Parent.namespaces.queryIDs)
local ReadRefs_m: any = require(script.Parent.readRefs)
local _: any = require(script.Parent.Parent.types)
local BufferWriter_m: any = require(script.Parent.bufferWriter)
local Alloc = BufferWriter_m.alloc
local U8 = BufferWriter_m.u8
local _ = BufferWriter_m.load
local v1: any = PacketIDs_m.ref()
local v2: thread? = nil

local function functionPasser(arg1, ...) -- line: 19
    -- upvalues:
    --  [1] v2 (ref)

    local v3 = v2
    v2 = nil
    arg1(...)
    v2 = v3
end

local function yielder() -- line: 26
    -- upvalues:
    --  [1] functionPasser (copy)

    while true do
        functionPasser(coroutine.yield())
    end
end

local function runListener(arg2: any, b1: boolean, arg3: any, ...) -- line: 32
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] yielder (copy)

    if v2 == nil then
        v2 = coroutine.create(yielder)
        coroutine.resume(v2)
    end

    task.spawn(v2, arg2, ...)

    if b1 then
        arg3.disconnect(arg2)
    end
end

local function runQueryListener(arg4: any, b2: boolean, arg5: any, ...) -- line: 44
    -- upvalues:
    --  [1] v2 (ref)
    --  [2] yielder (copy)

    local v5: any = nil
    local now: any = tick()

    if v2 == nil then
        v2 = coroutine.create(yielder)
        coroutine.resume(v2)
    end

    local v6 = v2

    local function v7(...) -- line: 52
        -- upvalues:
        --  [1] v5 (ref)
        --  [2] arg4 (copy)

        v5 = arg4(...)
    end

    task.spawn(v6, v7, ...)

    repeat
        task.wait()

        if v5 then
            break
        end
    until tick() - now > 10

    if v5 == nil then
        warn("queryResult hung for 10 seconds, returning null.")
    end

    if b2 then
        arg5.disconnect(arg4)
    end

    return v5
end

local _: any = function() --[[ create ]] -- line: 71
    return { cursor = 0, size = 256, references = {}, buff = buffer.create(256) }
end

local _: any = function(arg6) --[[ dump ]] -- line: 80
    local Cursor: any = arg6.cursor
    local buf: any = buffer.create(Cursor)
    buffer.copy(
        buf,
        0,
        arg6.buff,
        0,
        Cursor
    )
    local v8 = buf

    if #arg6.references > 0 then
        return v8, arg6.references
    end

    return v8, nil
end

local v9: any = QueryIDs_m.ref()

return function(
    buf1: buffer,
    t1: table?,
    u1: userdata?,
    s1: string?,
    n1: number?
) -- line: 89
    -- upvalues:
    --  [1] ReadRefs_m (copy)
    --  [2] v1 (copy)
    --  [3] v9 (copy)
    --  [4] RunService (copy)
    --  [5] runListener (copy)
    --  [6] runQueryListener (copy)
    --  [7] _ (copy)
    --  [8] _ (copy)
    --  [9] Alloc (copy)
    --  [10] U8 (copy)
    --  [11] BufferWriter_m (copy)

    local buf_1: any = buffer.len(buf1)
    local v10: number = 0
    s1 = s1 or "packet"
    ReadRefs_m.set(t1)

    while buf_1 > v10 do
        local v11 = nil

        if s1 == "packet" then
            v11 = v1[buffer.readu8(buf1, v10)]
        elseif s1 == "query" then
            v11 = v9[buffer.readu8(buf1, v10)]
        else
            error("readType not valid.")
        end

        if not v11 then
            error(
                "No readable entity found for ID: " .. buffer.readu8(buf1, v10) .. " for type: " .. s1
            )
        end

        v10 += 1
        local v14 = nil
        local v15 = nil

        if s1 == "query" then
            if RunService:IsServer() then
                v14, v15 = v11.requestReader(buf1, v10)
            elseif RunService:IsClient() then
                v14, v15 = v11.responseReader(buf1, v10)
            end
        elseif s1 == "packet" then
            v14, v15 = v11.reader(buf1, v10)
        end

        v10 += v15

        if s1 == "packet" then
            for _, val in table.clone(v11.getListeners()) do
                if typeof(val) == "table" then
                    runListener(
                        val.OnceCallback,
                        true,
                        v11,
                        v14,
                        u1
                    )
                elseif typeof(val) == "function" then
                    runListener(
                        val,
                        false,
                        v11,
                        v14,
                        u1
                    )
                else
                    error("Listener type not recognised for packet: " .. typeof(val))
                end
            end

            continue
        end

        if s1 ~= "query" then
            continue
        end

        if RunService:IsServer() then
            for _, val_1 in v11.getListeners() do
                local v16 = nil

                if typeof(val_1) == "table" then
                    v16 = runQueryListener(
                        val_1.OnceCallback,
                        true,
                        v11,
                        v14,
                        u1
                    )
                elseif typeof(val_1) == "function" then
                    v16 = runQueryListener(
                        val_1,
                        false,
                        v11,
                        v14,
                        u1
                    )
                else
                    error("Listener type not recognised for query: " .. typeof(val_1))
                end

                Alloc(1)
                U8(n1)
                v11.responseWriter(v16)
                local v17 = BufferWriter_m.export()

                if v17.cursor > 0 then
                    v16 = v17.cursor
                    local buf_2 = buffer.create(v16)
                    buffer.copy(
                        buf_2,
                        0,
                        v17.buff,
                        0,
                        v16
                    )
                    local v18 = buf_2

                    if #v17.references > 0 then
                        return v18, v17.references
                    else
                        return v18, nil
                    end
                end
            end

            continue
        end

        if not RunService:IsClient() then
            continue
        end

        return v14
    end
end
