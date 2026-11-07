-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Formatter
-- Class: ModuleScript
-- bytes: 1087

return {
    addCommas = function(arg1) --[[ addCommas ]] -- line: 3
        local str = tostring((math.floor(arg1)))

        return #str % 3 == 0 and str:reverse():gsub("(%d%d%d)", "%1,"):reverse():sub(2) or str:reverse():gsub(
            "(%d%d%d)",
            "%1,"
        ):reverse()
    end,
    formatItem = function(arg2) --[[ formatItem ]] -- line: 8
        return arg2:split("_")[1]
    end,
    formatMinuteSecs = function(arg3) --[[ formatMinuteSecs ]] -- line: 12
        local v3 = math.floor(arg3 / 60) % 60
        local _ = math.floor(arg3 / 3600) % 24
        local _ = math.floor(arg3 / 86400)

        return v3 .. "m " .. math.floor(arg3 % 60) .. "s"
    end,
    formatDecimal = function(arg4) --[[ formatDecimal ]] -- line: 20
        return string.format("%.2f", arg4)
    end,
    formatNumber = function(arg5) --[[ formatNumber ]] -- line: 25
        return (string.format("%.2f", arg5):gsub("0+$", ""):gsub("%.$", ""))
    end,
    round = function(arg6, arg7) --[[ round ]] -- line: 32
        return math.round(arg6 * 10 ^ arg7) * 10 ^ (-arg7)
    end
}
