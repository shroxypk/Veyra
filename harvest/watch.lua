-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.watch
-- Class: ModuleScript
-- bytes: 540

return {
    Name = "watch",
    Aliases = { "camera", "follow" },
    Description = "Watches a player with your camera.",
    Group = "DefaultAdmin",
    Args = { { Type = "player", Name = "target", Description = "The player to watch." } },
    ClientRun = function(_, arg2) --[[ ClientRun ]] -- line: 14
        if arg2.Character and arg2.Character:FindFirstChildOfClass("Humanoid") then
            workspace.CurrentCamera.CameraSubject = arg2.Character:FindFirstChildOfClass("Humanoid")
        end

        return "Watching"
    end
}
