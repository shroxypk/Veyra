-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.ConvertSeconds
-- Class: ModuleScript
-- bytes: 531

function Format(arg1) -- line: 1
    return string.format("%02i", arg1)
end

return function(arg2) -- line: 5
    local v1 = (arg2 - arg2 % 60) / 60
    arg2 -= v1 * 60
    local v2 = (v1 - v1 % 60) / 60
    v1 -= v2 * 60

    if arg2 < 30 and (v1 < 1 and v2 < 1) then
        return "less than 30 seconds"
    end

    if v2 < 1 then
        return Format(v1) .. " Minute(s) "
    end

    if v1 < 1 then
        return Format(arg2) .. " Second(s)"
    end

    return Format(v2) .. " Hour(s) " .. Format(v1) .. " Minute(s) "
end
