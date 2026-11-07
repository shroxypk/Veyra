-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.clear
-- Class: ModuleScript
-- bytes: 722

local Players = game:GetService("Players")

return {
    Name = "clear",
    Aliases = {},
    Description = "Clear all lines above the entry line of the Cmdr window.",
    Group = "DefaultUtil",
    Args = {},
    ClientRun = function() --[[ ClientRun ]] -- line: 9
        -- upvalues:
        --  [1] Players (copy)

        local Cmdr = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Cmdr")
        local Frame = Cmdr:WaitForChild("Frame")

        if Cmdr and Frame then
            for _, val in pairs(Frame:GetChildren()) do
                if val.Name == "Line" and val:IsA("TextBox") then
                    val:Destroy()
                end
            end
        end

        return ""
    end
}
