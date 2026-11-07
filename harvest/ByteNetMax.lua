-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ByteNetMax
-- Class: ModuleScript
-- bytes: 2298

local RunService = game:GetService("RunService")
local Client_m = require(script.process.client)
local Array_m = require(script.dataTypes.array)
local Bool_m = require(script.dataTypes.bool)
local Buff_m = require(script.dataTypes.buff)
local Color3_m = require(script.dataTypes.color3)
local Cframe_m = require(script.dataTypes.cframe)
local Float32_m = require(script.dataTypes.float32)
local Float64_m = require(script.dataTypes.float64)
local Inst_m = require(script.dataTypes.inst)
local Int16_m = require(script.dataTypes.int16)
local Int32_m = require(script.dataTypes.int32)
local Int8_m = require(script.dataTypes.int8)
local Map_m = require(script.dataTypes.map)
local Nothing_m = require(script.dataTypes.nothing)
local Optional_m = require(script.dataTypes.optional)
local String_m = require(script.dataTypes.string)
local Struct_m = require(script.dataTypes.struct)
local Uint16_m = require(script.dataTypes.uint16)
local Uint32_m = require(script.dataTypes.uint32)
local Uint8_m = require(script.dataTypes.uint8)
local Unknown_m = require(script.dataTypes.unknown)
local Vec2_m = require(script.dataTypes.vec2)
local Vec3_m = require(script.dataTypes.vec3)
local Namespace_m = require(script.namespaces.namespace)
local DefinePacket_m = require(script.packets.definePacket)
local DefineQuery_m = require(script.queries.defineQuery)
local Server_m = require(script.process.server)
local Values_m = require(script.replicated.values)
local _ = require(script.types)
Values_m.start()

if RunService:IsServer() then
    Server_m.start()
else
    Client_m.start()
end

local t = {
    definePacket = DefinePacket_m,
    defineQuery = DefineQuery_m,
    defineNamespace = Namespace_m,
    array = Array_m,
    bool = Bool_m(),
    optional = Optional_m,
    uint8 = Uint8_m(),
    uint16 = Uint16_m(),
    uint32 = Uint32_m(),
    int8 = Int8_m(),
    int16 = Int16_m(),
    int32 = Int32_m(),
    float32 = Float32_m(),
    float64 = Float64_m(),
    color3 = Color3_m(),
    cframe = Cframe_m(),
    string = String_m(),
    vec2 = Vec2_m(),
    vec3 = Vec3_m(),
    buff = Buff_m(),
    struct = Struct_m,
    map = Map_m,
    inst = Inst_m(),
    unknown = Unknown_m(),
    nothing = Nothing_m(),
    playerName = String_m(),
    playerIdentifier = Uint8_m()
}

return (table.freeze(t))
