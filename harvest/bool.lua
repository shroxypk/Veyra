-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.dataTypes.bool
-- Class: ModuleScript
-- bytes: 404

local BufferWriter_m = require(script.Parent.Parent.process.bufferWriter)
local _ = require(script.Parent.Parent.types)
local t = {
    read = function(buf1: buffer, n1: number) --[[ read ]] -- line: 11
        return if buffer.readu8(buf1, n1) ~= 1 then false else true, 1
    end,
    write = BufferWriter_m.bool
}

return function() -- line: 18
    -- upvalues:
    --  [1] t (copy)

    return t
end
