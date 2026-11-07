-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.scriptObjs
-- Class: ModuleScript
-- bytes: 1587

local Players = game:GetService("Players")
local t = { new = nil, GetPlayerCharacter = nil }
local LocalPlayer = Players.LocalPlayer

function t.new() -- line: 6
    -- upvalues:
    --  [1] LocalPlayer (copy)

    repeat
        task.wait()
    until _G.Use ~= nil and (_G.Tween ~= nil and _G.PROMPTS ~= nil)

    local Character = LocalPlayer.Character
    local v1 = Character

    if not Character or Character.Parent == nil or not v1 then
        v1 = LocalPlayer.CharacterAdded:Wait()
    end

    local PlayerFolder = LocalPlayer:WaitForChild("PlayerFolder")
    local Bin = LocalPlayer:WaitForChild("bin")
    local Binds = LocalPlayer:WaitForChild("Binds")
    local Values = Bin.Values

    repeat
        task.wait()
    until v1.Parent == workspace.pCharacters

    repeat
        task.wait()
    until v1:FindFirstChild("Humanoid")

    v1:WaitForChild("Humanoid"):WaitForChild("Animator")

    return LocalPlayer, v1, PlayerFolder, Bin, Values, game:GetService("UserInputService"), Binds
end

function t.GetPlayerCharacter() -- line: 19
    -- upvalues:
    --  [1] Players (copy)

    local LocalPlayer_1 = Players.LocalPlayer
    local Character_1 = LocalPlayer_1.Character
    local v3 = Character_1

    if not Character_1 or Character_1.Parent == nil or not v3 then
        v3 = LocalPlayer_1.CharacterAdded:Wait()
    end

    repeat
        task.wait()
    until v3.Parent == workspace.pCharacters and (v3:FindFirstChild("Humanoid") and v3:FindFirstChild(
        "States"
    ))

    v3.Humanoid:WaitForChild("Animator")

    return LocalPlayer_1, v3
end

return t
