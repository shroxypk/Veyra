-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.UI.NotificationStack
-- Class: ModuleScript
-- bytes: 393

return {
    Active = 0,
    DelayPerNotification = 0.5,
    GetLifetime = function(arg1, arg2) --[[ GetLifetime ]] -- line: 6
        return arg2 + arg1.Active * arg1.DelayPerNotification
    end,
    Push = function(arg3) --[[ Push ]] -- line: 12
        arg3.Active += 1
    end,
    Pop = function(arg4) --[[ Pop ]] -- line: 16
        arg4.Active = math.max(0, arg4.Active - 1)
    end
}
