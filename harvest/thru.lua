-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.thru
-- Class: ModuleScript
-- bytes: 1052

return {
    Name = "thru",
    Aliases = { "t", "through" },
    Description = "Teleports you through whatever your mouse is hovering over, placing you equidistantly from the wall.",
    Group = "DefaultDebug",
    Args = {
        {
            Type = "number",
            Name = "Extra distance",
            Description = "Go through the wall an additional X studs.",
            Default = 0
        }
    },
    ClientRun = function(arg1, arg2) --[[ ClientRun ]] -- line: 15
        local mouse = arg1.Executor:GetMouse()
        local Character = arg1.Executor.Character
        local Position

        if Character then
            if not Character:FindFirstChild("HumanoidRootPart") then
                return "You don't have a character."
            end

            Position = Character.HumanoidRootPart.Position
            local v1 = mouse.Hit.p - Position
            Character:MoveTo(v1 * 2 + v1.unit * arg2 + Position)

            return "Blinked!"
        else
            return "You don't have a character."
        end
    end
}
