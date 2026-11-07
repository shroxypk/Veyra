-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services
-- Class: ModuleScript
-- bytes: 1094

return (setmetatable({
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    ServerStorage = game:GetService("ServerStorage"),
    ServerScriptService = game:GetService("ServerScriptService"),
    CollectionService = game:GetService("CollectionService"),
    RunService = game:GetService("RunService"),
    HttpService = game:GetService("HttpService"),
    MemoryStoreService = game:GetService("MemoryStoreService"),
    MessagingService = game:GetService("MessagingService"),
    TextChatService = game:GetService("TextChatService"),
    TweenService = game:GetService("TweenService"),
    UserInputService = game:GetService("UserInputService"),
    Lighting = game:GetService("Lighting")
}, {
    __index = function(arg1, arg2) --[[ __index ]] -- line: 18
        local v1 = script:FindFirstChild(arg2, true)

        if v1 then
            local v2 = require(v1)
            rawset(arg1, arg2, v2)

            return v2
        end

        local v3 = game:GetService(arg2)
        rawset(arg1, arg2, v3)

        return v3
    end
}))
