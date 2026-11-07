-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Icon.Attribute
-- Class: ModuleScript
-- bytes: 573

task.defer(function() -- line: 21
    local RunService = game:GetService("RunService")
    local VERSION_m = require(script.Parent.VERSION)
    local v1 = VERSION_m.getAppVersion()
    local v2 = VERSION_m.getLatestVersion()
    local v3 = not VERSION_m.isUpToDate()

    if not RunService:IsStudio() then
        print(`\240\159\141\141 Running TopbarPlus {v1} by @ForeverHD & HD Admin`)
    end

    if v3 then
        warn(
            `A new version of TopbarPlus ({v2}) is available: https://devforum.roblox.com/t/topbarplus/1017485`
        )
    end
end)

return {}
