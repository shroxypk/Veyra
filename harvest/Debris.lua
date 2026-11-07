-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Debris
-- Class: ModuleScript
-- bytes: 1610

local t = { Instance = "Destroy", table = true, RBXScriptConnection = "Disconnect" }
local t_1 = { "Destroy", "Disconnect", "destroy", "disconnect" }

local function addDebris(arg1, arg2) -- line: 12
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_1 (copy)

    local v1 = typeof(arg1)
    assert(t[v1], "Invalid object type")
    assert(if typeof(arg2) ~= "number" then false else true, "lifeTime must be a number")

    if v1 == "Instance" then
        task.delay(arg2, function() -- line: 19
            -- upvalues:
            --  [1] arg1 (copy)

            arg1.Parent = nil
            arg1:Destroy()
        end)

        return
    end

    if v1 == "RBXScriptConnection" then
        task.delay(arg2, function() -- line: 24
            -- upvalues:
            --  [1] arg1 (copy)

            arg1:Disconnect()
        end)

        return
    end

    if v1 == "table" then
        for _, val in ipairs(t_1) do
            local v3 = arg1[val]

            if typeof(v3) == "function" then
                task.delay(arg2, function() -- line: 31
                    -- upvalues:
                    --  [1] v3 (copy)
                    --  [2] arg1 (copy)

                    v3(arg1)
                end)

                return
            end
        end
    end
end

local function AddItems(arg3, arg4) -- line: 40
    -- upvalues:
    --  [1] addDebris (copy)

    local v4 = arg3

    if type(arg3) ~= "table" or not v4 then
        v4 = { arg3 }
    end

    for _, val_1 in ipairs(v4) do
        task.spawn(addDebris, val_1, arg4)
    end
end

_G.Debris = AddItems

return AddItems
