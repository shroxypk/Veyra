-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Zone.Enum
-- Class: ModuleScript
-- bytes: 3390

local t = {}
local t_1 = {}
t.enums = t_1

function t.createEnum(arg1, arg2) -- line: 20
    -- upvalues:
    --  [1] t_1 (copy)

    assert(
        if typeof(arg1) ~= "string" then false else true,
        "bad argument #1 - enums must be created using a string name!"
    )
    assert(
        if typeof(arg2) ~= "table" then false else true,
        "bad argument #2 - enums must be created using a table!"
    )
    assert(not t_1[arg1], ("enum '%s' already exists!"):format(arg1))
    local t_2 = {}
    local t_3 = {}
    local t_4 = {}
    local t_5 = {}
    local t_6 = { getName = nil, getValue = nil, getProperty = nil }

    function t_6.getName(arg3) -- line: 30
        -- upvalues:
        --  [1] t_4 (copy)
        --  [2] t_5 (copy)
        --  [3] arg2 (copy)

        arg3 = tostring(arg3)
        local v3 = t_4[arg3] or t_5[arg3]

        if v3 then
            return arg2[v3][1]
        end
    end

    function t_6.getValue(arg4) -- line: 40
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] t_5 (copy)
        --  [3] arg2 (copy)

        arg4 = tostring(arg4)
        local v4 = t_3[arg4] or t_5[arg4]

        if v4 then
            return arg2[v4][2]
        end
    end

    function t_6.getProperty(arg5) -- line: 50
        -- upvalues:
        --  [1] t_3 (copy)
        --  [2] t_4 (copy)
        --  [3] arg2 (copy)

        arg5 = tostring(arg5)
        local v5 = t_3[arg5] or t_4[arg5]

        if v5 then
            return arg2[v5][3]
        end
    end

    for key, val in pairs(arg2) do
        assert(
            if typeof(val) ~= "table" then false else true,
            ("bad argument #2.%s - details must only be comprised of tables!"):format(key)
        )
        local v7 = val[1]
        assert(
            if typeof(v7) ~= "string" then false else true,
            ("bad argument #2.%s.1 - detail name must be a string!"):format(key)
        )
        assert(
            typeof(not t_3[v7]),
            ("bad argument #2.%s.1 - the detail name '%s' already exists!"):format(key, v7)
        )
        assert(
            typeof(not t_6[v7]),
            ("bad argument #2.%s.1 - that name is reserved."):format(key, v7)
        )
        t_3[tostring(v7)] = key
        local v10 = val[2]
        local str = tostring(v10)
        assert(
            typeof(not t_4[str]),
            ("bad argument #2.%s.2 - the detail value '%s' already exists!"):format(key, str)
        )
        t_4[str] = key
        local v12 = val[3]

        if v12 then
            assert(
                typeof(not t_5[v12]),
                ("bad argument #2.%s.3 - the detail property '%s' already exists!"):format(
                    key,
                    (tostring(v12))
                )
            )
            t_5[tostring(v12)] = key
        end

        t_2[v7] = v10
        local t_7 = { __index = nil }

        function t_7.__index(_, arg7) -- line: 80
            -- upvalues:
            --  [1] t_6 (copy)

            return t_6[arg7]
        end

        setmetatable(t_2, t_7)
    end

    t_1[arg1] = t_2

    return t_2
end

function t.getEnums() -- line: 90
    -- upvalues:
    --  [1] t_1 (copy)

    return t_1
end

local CreateEnum = t.createEnum

for _, child in pairs(script:GetChildren()) do
    if child:IsA("ModuleScript") then
        CreateEnum(child.Name, (require(child)))
    end
end

return t
