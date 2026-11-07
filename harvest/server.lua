-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.process.server
-- Class: ModuleScript
-- bytes: 9233

local Players: any = game:GetService("Players")
local RunService: any = game:GetService("RunService")
local _: any = require(script.Parent.Parent.types)
local Read_m: any = require(script.Parent.read)
local BufferWriter_m: any = require(script.Parent.bufferWriter)
local Alloc: any = BufferWriter_m.alloc
local U8: any = BufferWriter_m.u8
local Load: any = BufferWriter_m.load
local MAXBUFFERSIZE = script.Parent.Parent:GetAttribute("MAX_BUFFER_SIZE")
local v1: number = math.floor(MAXBUFFERSIZE)
local t: any = { bytesPerSec = v1, refillRate = v1 }
local t_1: table = {}
local t_2: table = {}
local t_3: table = {}

local function create() -- line: 26
    return { cursor = 0, size = 256, references = {}, buff = buffer.create(256) }
end

local _: any = function(arg1) --[[ dump ]] -- line: 35
    local Cursor: any = arg1.cursor
    local buf: any = buffer.create(Cursor)
    buffer.copy(
        buf,
        0,
        arg1.buff,
        0,
        Cursor
    )
    local v2 = buf

    if #arg1.references > 0 then
        return v2, arg1.references
    end

    return v2, nil
end

local v3: any = create()
local v4: any = create()

local function checkPlayerAllowedToSend(u1: userdata, n1: number) -- line: 49
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] t (copy)

    local clock: any = os.clock()
    t_3[u1].currentBytes = math.min(
        t_3[u1].currentBytes + (clock - t_3[u1].lastTime) * t.refillRate,
        t.bytesPerSec
    )
    t_3[u1].lastTime = clock

    if n1 <= t_3[u1].currentBytes then
        local v6 = t_3[u1]
        v6.currentBytes -= n1

        return true
    end

    return false
end

local function verifyBuffer(u2: userdata, arg2: any) -- line: 68
    -- upvalues:
    --  [1] v1 (copy)
    --  [2] checkPlayerAllowedToSend (copy)
    --  [3] t (copy)

    if typeof(arg2) ~= "buffer" then
        warn("Data is not a buffer.")

        return false
    end

    local buf_1 = buffer.len(arg2)

    if buf_1 > v1 then
        warn("Buffer is too large. Size limit exceeded: " .. tostring(v1) .. " bytes.")

        return false
    end

    if not checkPlayerAllowedToSend(u2, buf_1) then
        warn("Rate limit exceeded: " .. tostring(t.bytesPerSec) .. " bytes per second.")

        return false
    end

    return true
end

local function onServerEvent(u3: userdata, arg3: any, arg4: any) -- line: 90
    -- upvalues:
    --  [1] verifyBuffer (copy)
    --  [2] Read_m (copy)

    if not verifyBuffer(u3, arg3) then
        return
    end

    Read_m(arg3, arg4, u3)
end

local function onServerInvoke(u4: userdata, arg5: any, arg6: any, n2: number) -- line: 98
    -- upvalues:
    --  [1] verifyBuffer (copy)
    --  [2] Read_m (copy)

    if not verifyBuffer(u4, arg5) then
        return
    end

    local v7, v8 = Read_m(
        arg5,
        arg6,
        u4,
        "query",
        n2
    )

    return v7, v8
end

local function playerAdded(arg7) -- line: 108
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] create (copy)
    --  [3] t_2 (copy)
    --  [4] t_3 (copy)
    --  [5] v1 (copy)

    if not t_1[arg7] then
        t_1[arg7] = create()
    end

    if not t_2[arg7] then
        t_2[arg7] = create()
    end

    t_3[arg7] = { lastTime = os.clock(), currentBytes = v1 }
end

local function playerRemoving(u5: userdata) -- line: 123
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] t_2 (copy)
    --  [3] t_3 (copy)

    local v12 = t_2[u5]
    local v13 = t_3[u5]

    if t_1[u5] ~= nil then
        t_1[u5] = nil
    end

    if v12 ~= nil then
        t_2[u5] = nil
    end

    if v13 ~= nil then
        t_3[u5] = nil
    end
end

local t_6: any = {}

function t_6.sendAllReliable(n3: number, f1: (...any) -> ...any, t1: table) -- line: 143
    -- upvalues:
    --  [1] Load (copy)
    --  [2] v3 (ref)
    --  [3] Alloc (copy)
    --  [4] U8 (copy)
    --  [5] BufferWriter_m (copy)

    Load(v3)
    Alloc(1)
    U8(n3)
    f1(t1)
    v3 = BufferWriter_m.export()
end

function t_6.sendAllUnreliable(n4: number, f2: (...any) -> ...any, t2: table) -- line: 153
    -- upvalues:
    --  [1] Load (copy)
    --  [2] v4 (ref)
    --  [3] create (copy)
    --  [4] Alloc (copy)
    --  [5] U8 (copy)
    --  [6] BufferWriter_m (copy)

    Load(v4 or create())
    Alloc(1)
    U8(n4)
    f2(t2)
    v4 = BufferWriter_m.export()
end

function t_6.sendPlayerReliable(u6: userdata, n5: number, f3: (...any) -> ...any, t3: table) -- line: 163
    -- upvalues:
    --  [1] Load (copy)
    --  [2] t_1 (copy)
    --  [3] create (copy)
    --  [4] Alloc (copy)
    --  [5] U8 (copy)
    --  [6] BufferWriter_m (copy)

    Load(t_1[u6] or create())
    Alloc(1)
    U8(n5)
    f3(t3)
    t_1[u6] = BufferWriter_m.export()
end

function t_6.sendPlayerUnreliable(u7: userdata, n6: number, f4: (...any) -> ...any, t4: table) -- line: 178
    -- upvalues:
    --  [1] Load (copy)
    --  [2] t_2 (copy)
    --  [3] Alloc (copy)
    --  [4] U8 (copy)
    --  [5] BufferWriter_m (copy)

    Load(t_2[u7])
    Alloc(1)
    U8(n6)
    f4(t4)
    t_2[u7] = BufferWriter_m.export()
end

function t_6.start() -- line: 193
    -- upvalues:
    --  [1] onServerEvent (copy)
    --  [2] onServerInvoke (copy)
    --  [3] Players (copy)
    --  [4] playerAdded (copy)
    --  [5] playerRemoving (copy)
    --  [6] RunService (copy)
    --  [7] v3 (ref)
    --  [8] v4 (ref)
    --  [9] t_1 (copy)
    --  [10] t_2 (copy)

    local System_Folder: any = Instance.new("Folder")
    System_Folder.Name = "system"
    System_Folder.Parent = script.Parent.Parent
    local ByteNetReliable_RemoteEvent: any = Instance.new("RemoteEvent")
    ByteNetReliable_RemoteEvent.Name = "ByteNetReliable"
    ByteNetReliable_RemoteEvent.OnServerEvent:Connect(onServerEvent)
    ByteNetReliable_RemoteEvent.Parent = System_Folder
    local ByteNetUnreliable_UnreliableRemoteEvent: any = Instance.new("UnreliableRemoteEvent")
    ByteNetUnreliable_UnreliableRemoteEvent.Name = "ByteNetUnreliable"
    ByteNetUnreliable_UnreliableRemoteEvent.OnServerEvent:Connect(onServerEvent)
    ByteNetUnreliable_UnreliableRemoteEvent.Parent = System_Folder
    local ByteNetQuery_RemoteFunction: any = Instance.new("RemoteFunction")
    ByteNetQuery_RemoteFunction.Name = "ByteNetQuery"
    ByteNetQuery_RemoteFunction.OnServerInvoke = onServerInvoke
    ByteNetQuery_RemoteFunction.Parent = System_Folder

    for _, val in Players:GetPlayers() do
        playerAdded(val)
    end

    Players.PlayerAdded:Connect(playerAdded)
    Players.PlayerRemoving:Connect(playerRemoving)
    RunService.Heartbeat:Connect(function() -- line: 220
        -- upvalues:
        --  [1] v3 (ref)
        --  [2] ByteNetReliable_RemoteEvent (copy)
        --  [3] v4 (ref)
        --  [4] ByteNetUnreliable_UnreliableRemoteEvent (copy)
        --  [5] Players (ref)
        --  [6] t_1 (ref)
        --  [7] t_2 (ref)

        local v20

        if v3.cursor > 0 then
            local v18 = v3
            local Cursor_1 = v18.cursor
            local buf_2 = buffer.create(Cursor_1)
            buffer.copy(
                buf_2,
                0,
                v18.buff,
                0,
                Cursor_1
            )
            v20 = if not (#v18.references > 0) then nil else v18.references
            ByteNetReliable_RemoteEvent:FireAllClients(buf_2, v20)
            v3.cursor = 0
            table.clear(v3.references)
        end

        if v4.cursor > 0 then
            local v21 = v4
            local Cursor_2 = v21.cursor
            local buf_3 = buffer.create(Cursor_2)
            buffer.copy(
                buf_3,
                0,
                v21.buff,
                0,
                Cursor_2
            )
            v20 = if not (#v21.references > 0) then nil else v21.references
            ByteNetUnreliable_UnreliableRemoteEvent:FireAllClients(buf_3, v20)
            v4.cursor = 0
            table.clear(v4.references)
        end

        local v25

        for _, val_1 in Players:GetPlayers() do
            local v23 = t_1[val_1]
            local v24 = t_2[val_1]

            if v23 ~= nil and v23.cursor > 0 then
                local Cursor_3 = v23.cursor
                local buf_4 = buffer.create(Cursor_3)
                buffer.copy(
                    buf_4,
                    0,
                    v23.buff,
                    0,
                    Cursor_3
                )
                v25 = if not (#v23.references > 0) then nil else v23.references
                ByteNetReliable_RemoteEvent:FireClient(val_1, buf_4, v25)
                v23.cursor = 0
                table.clear(v23.references)
            end

            if v24 ~= nil and v24.cursor > 0 then
                local Cursor_4 = v24.cursor
                local buf_5 = buffer.create(Cursor_4)
                buffer.copy(
                    buf_5,
                    0,
                    v24.buff,
                    0,
                    Cursor_4
                )
                v25 = if not (#v24.references > 0) then nil else v24.references
                ByteNetUnreliable_UnreliableRemoteEvent:FireClient(val_1, buf_5, v25)
                v24.cursor = 0
                table.clear(v24.references)
            end
        end
    end)
end

return t_6
