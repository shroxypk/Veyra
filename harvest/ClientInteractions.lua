-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.ClientInteractions
-- Class: LocalScript
-- bytes: 1123

local _ = game:GetService("Players")
local Modules = game:GetService("ReplicatedStorage").Modules
local Basic_m = require(Modules.Basic)
local _, _ = require(Modules.scriptObjs).GetPlayerCharacter()
local v3 = os.clock() + 30

while true do
    if _G.Tween then
        break
    end

    if not (v3 > os.clock()) then
        break
    end

    task.wait()
end

for _, child in script:GetChildren() do
    if child:IsA("Folder") and (child.Name ~= "World" or Basic_m.World) then
        for _, child_1 in child:GetChildren() do
            if child_1:IsA("ModuleScript") then
                task.spawn(function() -- line: 31
                    -- upvalues:
                    --  [1] child_1 (copy)

                    local Success, Result = pcall(require, child_1)

                    if not Success then
                        warn(Result)

                        return
                    end

                    local _, Result_1 = pcall(Result)

                    if Result_1 then
                        warn(Result_1)
                    end
                end)
            end
        end
    end
end
