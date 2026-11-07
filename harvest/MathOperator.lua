-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Types.MathOperator
-- Class: ModuleScript
-- bytes: 1139

return function(arg1) -- line: 1
    arg1:RegisterType("mathOperator", arg1.Cmdr.Util.MakeEnumType("Math Operator", {
        {
            Name = "+",
            Perform = function(arg2, arg3) --[[ Perform ]] -- line: 5
                return arg2 + arg3
            end
        },
        {
            Name = "-",
            Perform = function(arg4, arg5) --[[ Perform ]] -- line: 11
                return arg4 - arg5
            end
        },
        {
            Name = "*",
            Perform = function(arg6, arg7) --[[ Perform ]] -- line: 17
                return arg6 * arg7
            end
        },
        {
            Name = "/",
            Perform = function(arg8, arg9) --[[ Perform ]] -- line: 23
                return arg8 / arg9
            end
        },
        {
            Name = "**",
            Perform = function(arg10, arg11) --[[ Perform ]] -- line: 29
                return arg10 ^ arg11
            end
        },
        {
            Name = "%",
            Perform = function(arg12, arg13) --[[ Perform ]] -- line: 35
                return arg12 % arg13
            end
        }
    }))
end
