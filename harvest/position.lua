-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.position
-- Class: ModuleScript
-- bytes: 836

return {
    Name = "position",
    Aliases = { "pos" },
    Description = "Returns Vector3 position of you or other players. Empty string is the player has no character.",
    Group = "DefaultDebug",
    Args = {
        {
            Type = "player",
            Name = "Player",
            Description = "The player to report the position of. Omit for your own position.",
            Default = game:GetService("Players").LocalPlayer
        }
    },
    ClientRun = function(_, arg2) --[[ ClientRun ]] -- line: 17
        local Character = arg2.Character

        if Character then
            if not Character:FindFirstChild("HumanoidRootPart") then
                return ""
            end

            return tostring(Character.HumanoidRootPart.Position):gsub("%s", "")
        else
            return ""
        end
    end
}
