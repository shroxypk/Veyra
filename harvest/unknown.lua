-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.dataTypes.unknown
-- Class: ModuleScript
-- bytes: 947

local BufferWriter_m = require(script.Parent.Parent.process.bufferWriter)
local ReadRefs_m = require(script.Parent.Parent.process.readRefs)
local _ = require(script.Parent.Parent.types)
local Alloc = BufferWriter_m.alloc
local Reference = BufferWriter_m.reference

return function() -- line: 8
    -- upvalues:
    --  [1] Alloc (copy)
    --  [2] Reference (copy)
    --  [3] ReadRefs_m (copy)

    return {
        write = function(arg1) --[[ write ]] -- line: 10
            -- upvalues:
            --  [1] Alloc (ref)
            --  [2] Reference (ref)

            Alloc(1)
            Reference(arg1)
        end,
        read = function(buf1: buffer, n1: number) --[[ read ]] -- line: 15
            -- upvalues:
            --  [1] ReadRefs_m (ref)

            local v1 = ReadRefs_m.get()

            if not v1 then
                return nil, 1
            end

            return v1[buffer.readu8(buf1, n1)], 1
        end
    }
end
