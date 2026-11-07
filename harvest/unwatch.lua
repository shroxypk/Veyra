-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.unwatch
-- Class: ModuleScript
-- bytes: 457

return {
    Name = "unwatch",
    Aliases = { "uncamera", "unfollow" },
    Description = "Unwatches a player with your camera.",
    Group = "DefaultAdmin",
    Args = {},
    ClientRun = function(arg1) --[[ ClientRun ]] -- line: 8
        local Character = arg1.Executor.Character

        if Character then
            workspace.CurrentCamera.CameraSubject = Character:FindFirstChildOfClass("Humanoid")
        end

        return "Unwatched"
    end
}
