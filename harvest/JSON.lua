-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Types.JSON
-- Class: ModuleScript
-- bytes: 564

local HttpService = game:GetService("HttpService")

return function(arg1) -- line: 3
    -- upvalues:
    --  [1] HttpService (copy)

    arg1:RegisterType("json", {
        Validate = function(arg2) --[[ Validate ]] -- line: 5
            -- upvalues:
            --  [1] HttpService (ref)

            return pcall(HttpService.JSONDecode, HttpService, arg2)
        end,
        Parse = function(arg3) --[[ Parse ]] -- line: 9
            -- upvalues:
            --  [1] HttpService (ref)

            return HttpService:JSONDecode(arg3)
        end
    })
end
