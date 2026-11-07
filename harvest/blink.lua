-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.CmdrClient.Commands.blink
-- Class: ModuleScript
-- bytes: 488

return {
    Name = "blink",
    Aliases = { "b" },
    Description = "Teleports you to where your mouse is hovering.",
    Group = "DefaultDebug",
    Args = {},
    ClientRun = function(arg1) --[[ ClientRun ]] -- line: 8
        local mouse = arg1.Executor:GetMouse()
        local Character = arg1.Executor.Character

        if not Character then
            return "You don't have a character."
        end

        Character:MoveTo(mouse.Hit.p)

        return "Blinked!"
    end
}
