-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.replicated.replicatedValue
-- Class: ModuleScript
-- bytes: 1162

local HttpService = game:GetService("HttpService")
local v1 = if game:GetService("RunService"):IsServer() then "server" else "client"
local t = {}
local t_1 = { __index = t }

function t.write(arg1: any, t1: table) -- line: 16
    -- upvalues:
    --  [1] v1 (copy)
    --  [2] HttpService (copy)

    assert(v1 == "server", "cannot write to replicatdvalue on client")
    arg1._luauData = t1
    arg1._value.Value = HttpService:JSONEncode(t1)
end

function t.read(arg2) -- line: 25
    return arg2._luauData
end

return function(u1: userdata) -- line: 29
    -- upvalues:
    --  [1] t_1 (copy)
    --  [2] v1 (copy)
    --  [3] HttpService (copy)

    local t_2 = setmetatable({}, t_1)
    t_2._luauData = {}
    t_2._value = u1

    if v1 == "client" then
        t_2._luauData = table.freeze(HttpService:JSONDecode(u1.Value))
        u1.Changed:Connect(function(s1: string) -- line: 40
            -- upvalues:
            --  [1] t_2 (copy)
            --  [2] HttpService (ref)

            if not s1 then
                return
            end

            t_2._luauData = table.freeze(HttpService:JSONDecode(s1))
        end)
    end

    return t_2
end
