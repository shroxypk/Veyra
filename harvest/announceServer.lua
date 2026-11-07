-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Cmdr.Server commands.Admin.announceServer
-- Class: ModuleScript
-- bytes: 1745

local TextService = game:GetService("TextService")
local Players = game:GetService("Players")
local _ = game:GetService("Chat")

local _ = function(arg1, arg2) --[[ getFilterResult ]] -- line: 5
    -- upvalues:
    --  [1] TextService (copy)

    local v1 = nil
    local Success, Result = pcall(function() -- line: 7
        -- upvalues:
        --  [1] v1 (ref)
        --  [2] TextService (ref)
        --  [3] arg1 (copy)
        --  [4] arg2 (copy)

        v1 = TextService:FilterStringAsync(arg1, arg2)
    end)

    if Success then
        return v1
    end

    warn("Error generating TextFilterResult:", Result)
end

return function(_, arg4) -- line: 18
    -- upvalues:
    --  [1] Players (copy)
    --  [2] TextService (copy)

    local v4

    for _, val in Players:GetPlayers() do
        local v2 = val.UserId
        local v3 = nil
        local Success_1, Result_1 = pcall(function() -- line: 7
            -- upvalues:
            --  [1] v3 (ref)
            --  [2] TextService (ref)
            --  [3] arg4 (copy)
            --  [4] v2 (copy)

            v3 = TextService:FilterStringAsync(arg4, v2)
        end)

        if Success_1 then
            v4 = v3
        else
            warn("Error generating TextFilterResult:", Result_1)
            v4 = nil
        end

        if v4 then
            local function v5() -- line: 22
                -- upvalues:
                --  [1] v4 (copy)

                return v4:GetNonChatStringForBroadcastAsync()
            end

            v2, v5 = pcall(v5)

            if v2 then
                _G.ServerNotify(val, v5, true)
            else
                warn("Error filtering text!")
            end
        end
    end

    return "Created announcement."
end
