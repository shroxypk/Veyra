-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax.packets.definePacket
-- Class: ModuleScript
-- bytes: 355

local _: any = require(script.Parent.Parent.types)
local Packet_m: any = require(script.Parent.packet)

return function(arg1) -- line: 12
    -- upvalues:
    --  [1] Packet_m (copy)

    return function(n1: number) -- line: 13
        -- upvalues:
        --  [1] Packet_m (ref)
        --  [2] arg1 (copy)

        return Packet_m(arg1, n1)
    end
end
