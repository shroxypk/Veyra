-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.DefaultEventHandlers
-- Class: ModuleScript
-- bytes: 667

local StarterGui = game:GetService("StarterGui")
local Window_m = require(script.Parent.CmdrInterface.Window)

return function(arg1) -- line: 4
    -- upvalues:
    --  [1] StarterGui (copy)
    --  [2] Window_m (copy)

    arg1:HandleEvent("Message", function(arg2) -- line: 5
        -- upvalues:
        --  [1] StarterGui (ref)

        StarterGui:SetCore(
            "ChatMakeSystemMessage",
            { Text = ("[Announcement] %s"):format(arg2), Color = Color3.fromRGB(249, 217, 56) }
        )
    end)
    arg1:HandleEvent("AddLine", function(...) -- line: 12
        -- upvalues:
        --  [1] Window_m (ref)

        Window_m:AddLine(...)
    end)
end
