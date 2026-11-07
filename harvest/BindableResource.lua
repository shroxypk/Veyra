-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Types.BindableResource
-- Class: ModuleScript
-- bytes: 162

return function(arg1) -- line: 1
    arg1:RegisterType(
        "bindableResource",
        arg1.Cmdr.Util.MakeEnumType("BindableResource", { "Chat" })
    )
end
