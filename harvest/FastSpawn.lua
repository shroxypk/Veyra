-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.FastSpawn
-- Class: ModuleScript
-- bytes: 336

return function(arg1, ...) -- line: 5
    assert(if type(arg1) ~= "function" then false else true)
    local t = { ... }
    local v2 = select("#", ...)
    task.spawn(function() -- line: 21
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] t (copy)
        --  [3] v2 (copy)

        arg1(unpack(t, 1, v2))
    end)
end
