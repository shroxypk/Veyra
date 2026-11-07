-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Types.ConditionFunction
-- Class: ModuleScript
-- bytes: 170

return function(arg1) -- line: 1
    arg1:RegisterType(
        "conditionFunction",
        arg1.Cmdr.Util.MakeEnumType("ConditionFunction", { "startsWith" })
    )
end
