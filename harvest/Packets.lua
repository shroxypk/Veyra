-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packets
-- Class: ModuleScript
-- bytes: 10826

local ByteNetMax_m = require(game:GetService("ReplicatedStorage").Modules.ByteNetMax)

return {
    Combat = ByteNetMax_m.defineNamespace("Combat", function() -- line: 9
        -- upvalues:
        --  [1] ByteNetMax_m (copy)

        local t_1 = { packets = nil }
        local t_2 = {
            MisdirectInput = nil,
            BlockInput = nil,
            AttackInput = nil,
            RollInput = nil,
            CrouchInput = nil,
            aerialForce = nil,
            slamForce = nil
        }
        local t_3 = { reliabilityType = "unreliable", value = nil }
        local t_4 = { Action = ByteNetMax_m.bool }
        local DefinePacket = ByteNetMax_m.definePacket
        t_3.value = ByteNetMax_m.struct(t_4)
        t_2.MisdirectInput = DefinePacket(t_3)
        local t_5 = { value = nil }
        local t_6 = { Action = ByteNetMax_m.string }
        local DefinePacket_1 = ByteNetMax_m.definePacket
        t_5.value = ByteNetMax_m.struct(t_6)
        t_2.BlockInput = DefinePacket_1(t_5)
        local t_7 = { value = nil }
        local t_8 = { Action = ByteNetMax_m.string, SprintAttack = ByteNetMax_m.bool }
        local DefinePacket_2 = ByteNetMax_m.definePacket
        t_7.value = ByteNetMax_m.struct(t_8)
        t_2.AttackInput = DefinePacket_2(t_7)
        local t_9 = { value = nil }
        local t_10 = {
            Action = ByteNetMax_m.string,
            typeOf = ByteNetMax_m.optional(ByteNetMax_m.string)
        }
        local DefinePacket_3 = ByteNetMax_m.definePacket
        t_9.value = ByteNetMax_m.struct(t_10)
        t_2.RollInput = DefinePacket_3(t_9)
        local t_11 = { value = nil }
        local t_12 = { Action = ByteNetMax_m.string }
        local DefinePacket_4 = ByteNetMax_m.definePacket
        t_11.value = ByteNetMax_m.struct(t_12)
        t_2.CrouchInput = DefinePacket_4(t_11)
        local t_13 = { value = nil }
        local t_14 = { Action = ByteNetMax_m.bool, Character = ByteNetMax_m.inst }
        local DefinePacket_5 = ByteNetMax_m.definePacket
        t_13.value = ByteNetMax_m.struct(t_14)
        t_2.aerialForce = DefinePacket_5(t_13)
        local t_15 = { value = nil }
        local t_16 = { Character = ByteNetMax_m.inst }
        local DefinePacket_6 = ByteNetMax_m.definePacket
        t_15.value = ByteNetMax_m.struct(t_16)
        t_2.slamForce = DefinePacket_6(t_15)
        t_1.packets = t_2

        return t_1
    end),
    Tools = ByteNetMax_m.defineNamespace("Tools", function() -- line: 62
        -- upvalues:
        --  [1] ByteNetMax_m (copy)

        local t_17 = { packets = nil }
        local t_18 = { Horn = nil, BasicTechnique = nil }
        local t_19 = { value = nil }
        local t_20 = { Action = ByteNetMax_m.string }
        local DefinePacket_7 = ByteNetMax_m.definePacket
        t_19.value = ByteNetMax_m.struct(t_20)
        t_18.Horn = DefinePacket_7(t_19)
        local t_21 = { value = nil }
        local t_22 = { Skill = ByteNetMax_m.string }
        local DefinePacket_8 = ByteNetMax_m.definePacket
        t_21.value = ByteNetMax_m.struct(t_22)
        t_18.BasicTechnique = DefinePacket_8(t_21)
        t_17.packets = t_18

        return t_17
    end),
    Magic = ByteNetMax_m.defineNamespace("Magic", function() -- line: 79
        -- upvalues:
        --  [1] ByteNetMax_m (copy)

        local t_23 = { packets = nil }
        local t_24 = { Client = nil, Ultimate = nil, Cast = nil }
        local t_25 = { value = nil }
        local t_26 = {
            Module = ByteNetMax_m.string,
            Action = ByteNetMax_m.string,
            Character = ByteNetMax_m.optional(ByteNetMax_m.inst),
            Root = ByteNetMax_m.optional(ByteNetMax_m.inst),
            Position = ByteNetMax_m.optional(ByteNetMax_m.unknown),
            EndPosition = ByteNetMax_m.optional(ByteNetMax_m.unknown),
            CastId = ByteNetMax_m.optional(ByteNetMax_m.unknown),
            Shots = ByteNetMax_m.optional(ByteNetMax_m.buff)
        }
        local DefinePacket_9 = ByteNetMax_m.definePacket
        t_25.value = ByteNetMax_m.struct(t_26)
        t_24.Client = DefinePacket_9(t_25)
        local t_27 = { value = ByteNetMax_m.struct({}) }
        t_24.Ultimate = ByteNetMax_m.definePacket(t_27)
        local t_28 = { value = nil }
        local t_29 = { Skill = ByteNetMax_m.string }
        local DefinePacket_11 = ByteNetMax_m.definePacket
        t_28.value = ByteNetMax_m.struct(t_29)
        t_24.Cast = DefinePacket_11(t_28)
        t_23.packets = t_24

        return t_23
    end),
    Spawn = ByteNetMax_m.defineNamespace("Spawn", function() -- line: 110
        -- upvalues:
        --  [1] ByteNetMax_m (copy)

        local t_30 = { packets = nil }
        local t_31 = { Update = nil }
        local t_32 = { value = nil }
        local t_33 = { Action = ByteNetMax_m.nothing }
        local DefinePacket_12 = ByteNetMax_m.definePacket
        t_32.value = ByteNetMax_m.struct(t_33)
        t_31.Update = DefinePacket_12(t_32)
        t_30.packets = t_31

        return t_30
    end),
    Inventory = ByteNetMax_m.defineNamespace("Inventory", function() -- line: 122
        -- upvalues:
        --  [1] ByteNetMax_m (copy)

        local t_34 = { packets = nil, queries = nil }
        local t_35 = { Tool = nil, OrderDefault = nil, Equip = nil, ToggleWeapon = nil, Drop = nil }
        local t_36 = { value = nil }
        local t_37 = {
            Action = ByteNetMax_m.optional(ByteNetMax_m.string),
            Item = ByteNetMax_m.optional(ByteNetMax_m.inst)
        }
        local DefinePacket_13 = ByteNetMax_m.definePacket
        t_36.value = ByteNetMax_m.struct(t_37)
        t_35.Tool = DefinePacket_13(t_36)
        local t_38 = { value = nil }
        local t_39 = { Tool = ByteNetMax_m.string }
        local DefinePacket_14 = ByteNetMax_m.definePacket
        t_38.value = ByteNetMax_m.struct(t_39)
        t_35.OrderDefault = DefinePacket_14(t_38)
        local t_40 = { value = nil }
        local t_41 = { Item = ByteNetMax_m.inst }
        local DefinePacket_15 = ByteNetMax_m.definePacket
        t_40.value = ByteNetMax_m.struct(t_41)
        t_35.Equip = DefinePacket_15(t_40)
        local t_42 = { value = nil }
        local t_43 = { Action = ByteNetMax_m.string, Item = ByteNetMax_m.inst }
        local DefinePacket_16 = ByteNetMax_m.definePacket
        t_42.value = ByteNetMax_m.struct(t_43)
        t_35.ToggleWeapon = DefinePacket_16(t_42)
        local t_44 = { value = nil }
        local t_45 = { Item = ByteNetMax_m.inst, Quantity = ByteNetMax_m.int8 }
        local DefinePacket_17 = ByteNetMax_m.definePacket
        t_44.value = ByteNetMax_m.struct(t_45)
        t_35.Drop = DefinePacket_17(t_44)
        t_34.packets = t_35
        local t_46 = { Unequip = nil, ToggleLock = nil, OrderBackpack = nil }
        local t_47 = { request = nil, response = nil }
        local t_48 = { Item = ByteNetMax_m.inst }
        local DefineQuery = ByteNetMax_m.defineQuery
        t_47.request = ByteNetMax_m.struct(t_48)
        local t_49 = { Received = ByteNetMax_m.optional(ByteNetMax_m.bool) }
        t_47.response = ByteNetMax_m.struct(t_49)
        t_46.Unequip = DefineQuery(t_47)
        local t_50 = { request = nil, response = nil }
        local t_51 = { Item = ByteNetMax_m.inst }
        local DefineQuery_1 = ByteNetMax_m.defineQuery
        t_50.request = ByteNetMax_m.struct(t_51)
        local t_52 = { Received = ByteNetMax_m.optional(ByteNetMax_m.bool) }
        t_50.response = ByteNetMax_m.struct(t_52)
        t_46.ToggleLock = DefineQuery_1(t_50)
        local t_53 = { request = nil, response = nil }
        local t_54 = { Tool = ByteNetMax_m.inst, index = ByteNetMax_m.uint8 }
        local DefineQuery_2 = ByteNetMax_m.defineQuery
        t_53.request = ByteNetMax_m.struct(t_54)
        local t_55 = {
            Replaced = ByteNetMax_m.optional(ByteNetMax_m.bool),
            Swapped = ByteNetMax_m.optional(ByteNetMax_m.bool)
        }
        t_53.response = ByteNetMax_m.struct(t_55)
        t_46.OrderBackpack = DefineQuery_2(t_53)
        t_34.queries = t_46

        return t_34
    end),
    Systems = ByteNetMax_m.defineNamespace("Systems", function() -- line: 189
        -- upvalues:
        --  [1] ByteNetMax_m (copy)

        local t_56 = { packets = nil, queries = nil }
        local t_57 = {
            Summon = nil,
            MissionClient = nil,
            ShowDetails = nil,
            ShowResults = nil,
            InvasionClient = nil
        }
        local t_58 = { value = nil }
        local t_59 = { Action = ByteNetMax_m.string }
        local DefinePacket_18 = ByteNetMax_m.definePacket
        t_58.value = ByteNetMax_m.struct(t_59)
        t_57.Summon = DefinePacket_18(t_58)
        local t_60 = { value = nil }
        local t_61 = {
            Action = ByteNetMax_m.string,
            Pos = ByteNetMax_m.optional(ByteNetMax_m.cframe),
            MarkId = ByteNetMax_m.optional(ByteNetMax_m.string)
        }
        local DefinePacket_19 = ByteNetMax_m.definePacket
        t_60.value = ByteNetMax_m.struct(t_61)
        t_57.MissionClient = DefinePacket_19(t_60)
        local t_62 = { value = ByteNetMax_m.map(ByteNetMax_m.string, ByteNetMax_m.unknown) }
        t_57.ShowDetails = ByteNetMax_m.definePacket(t_62)
        local t_63 = { value = ByteNetMax_m.map(ByteNetMax_m.string, ByteNetMax_m.unknown) }
        t_57.ShowResults = ByteNetMax_m.definePacket(t_63)
        local t_64 = { value = ByteNetMax_m.map(ByteNetMax_m.string, ByteNetMax_m.unknown) }
        t_57.InvasionClient = ByteNetMax_m.definePacket(t_64)
        t_56.packets = t_57
        local t_65 = { RequestMission = nil, RequestInvasion = nil }
        local t_66 = { request = nil, response = nil }
        local t_67 = {
            Action = ByteNetMax_m.string,
            Rank = ByteNetMax_m.optional(ByteNetMax_m.int8)
        }
        local DefineQuery_3 = ByteNetMax_m.defineQuery
        t_66.request = ByteNetMax_m.struct(t_67)
        local t_68 = { Result = ByteNetMax_m.optional(ByteNetMax_m.bool) }
        t_66.response = ByteNetMax_m.struct(t_68)
        t_65.RequestMission = DefineQuery_3(t_66)
        local t_69 = { request = nil, response = nil }
        local t_70 = {
            Action = ByteNetMax_m.string,
            Region = ByteNetMax_m.optional(ByteNetMax_m.string),
            Exclude = ByteNetMax_m.optional(ByteNetMax_m.string)
        }
        local DefineQuery_4 = ByteNetMax_m.defineQuery
        t_69.request = ByteNetMax_m.struct(t_70)
        local t_71 = {
            Result = ByteNetMax_m.optional(ByteNetMax_m.bool),
            Message = ByteNetMax_m.optional(ByteNetMax_m.string)
        }
        t_69.response = ByteNetMax_m.struct(t_71)
        t_65.RequestInvasion = DefineQuery_4(t_69)
        t_56.queries = t_65

        return t_56
    end)
}
