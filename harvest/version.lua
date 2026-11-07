-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Icon.VERSION
-- Class: ModuleScript
-- bytes: 1069

local t = { appVersion = "v3.4.0", latestVersion = nil }

function t.getLatestVersion() -- line: 14
    -- upvalues:
    --  [1] t (copy)

    local v1 = t.latestVersion

    if v1 then
        return v1
    end

    local Name

    while true do
        local Success, Result = pcall(function() -- line: 22
            return game:GetService("MarketplaceService"):GetProductInfo(117501901079852)
        end)

        if Success then
        end

        if Result then
            break
        end

        Name = Result.Name
        task.wait(1)
    end

    v1 = string.match(Name, "^TopbarPlus (.*)$")

    if v1 then
        v1 = v1:gsub("%s+", "")
    end

    t.latestVersion = v1

    return v1
end

function t.getAppVersion() -- line: 39
    -- upvalues:
    --  [1] t (copy)

    return t.appVersion
end

function t.isUpToDate() -- line: 43
    -- upvalues:
    --  [1] t (copy)

    local GetLatestVersion = t.getLatestVersion
    local v2 = t.getAppVersion()

    return if GetLatestVersion() == nil then false else GetLatestVersion() == v2
end

return t
