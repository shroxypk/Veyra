-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.mod.logger
-- Class: ModuleScript
-- bytes: 582

local function msg(...) -- line: 1
    local v1 = table.concat({ ... }, " ")

    return `[Forge Emit API]: {v1}`
end

return {
    error = function(...) --[[ error ]] -- line: 7
        -- upvalues:
        --  [1] msg (copy)

        error(msg(..., "\n"))
    end,
    warn = function(...) --[[ warn ]] -- line: 11
        -- upvalues:
        --  [1] msg (copy)

        warn(msg(...))
        warn(msg(debug.traceback("stack trace:")))
    end,
    info = function(...) --[[ info ]] -- line: 16
        -- upvalues:
        --  [1] msg (copy)

        print(msg(...))
    end
}
