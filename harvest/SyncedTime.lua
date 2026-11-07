-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.SyncedTime
-- Class: ModuleScript
-- bytes: 1960

local t = {
    Jan = 1,
    Feb = 2,
    Mar = 3,
    Apr = 4,
    May = 5,
    Jun = 6,
    Jul = 7,
    Aug = 8,
    Sep = 9,
    Oct = 10,
    Nov = 11,
    Dec = 12
}
local HttpService = game:GetService("HttpService")

local function RFC2616DateStringToUnixTimestamp(arg1) -- line: 16
    -- upvalues:
    --  [1] t (copy)

    local v1, v2, v3, v4, v5, v6 = arg1:match(".*, (.*) (.*) (.*) (.*):(.*):(.*) .*")

    return os.time({ day = v1, month = t[v2], year = v3, hour = v4, min = v5, sec = v6 })
end

local v7 = false
local v8 = nil
local now_1 = nil
local v10 = nil

local function inited() -- line: 35
    -- upvalues:
    --  [1] v7 (ref)

    return v7
end

local function init() -- line: 39
    -- upvalues:
    --  [1] v7 (ref)
    --  [2] HttpService (copy)
    --  [3] v8 (ref)
    --  [4] RFC2616DateStringToUnixTimestamp (copy)
    --  [5] now_1 (ref)
    --  [6] v10 (ref)

    if not v7 then
        if not pcall(function() -- line: 41
            -- upvalues:
            --  [1] HttpService (ref)
            --  [2] v8 (ref)
            --  [3] RFC2616DateStringToUnixTimestamp (ref)
            --  [4] now_1 (ref)
            --  [5] v10 (ref)

            local now = tick()
            v8 = RFC2616DateStringToUnixTimestamp(
                HttpService:RequestAsync({ Url = "http://google.com" }).Headers.date
            )
            now_1 = tick()
            v10 = (now_1 - now) / 2
        end) then
            warn("Cannot get time from google.com. Make sure that http requests are enabled!")
            v8 = os.time()
            now_1 = tick()
            v10 = 0
        end

        v7 = true
    end
end

local function v12() --[[ time ]] -- line: 61
    -- upvalues:
    --  [1] v7 (ref)
    --  [2] init (copy)
    --  [3] v8 (ref)
    --  [4] now_1 (ref)
    --  [5] v10 (ref)

    if not v7 then
        init()
    end

    return v8 + tick() - now_1 - v10
end

return { inited = inited, init = init, time = v12 }
