-- Decompiled with Veyra harvester
-- Instance: Workspace.ChatObjects.SphinxRiddles.SphinxServer.Utils
-- Class: ModuleScript
-- bytes: 401

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("ReplicatedStorage")
local t = { Riddles = {} }

for _, child in script:GetChildren() do
    if child:IsA("ModuleScript") then
        t.Riddles[child.Name] = require(child)
    end
end

function t.ChooseRiddle(_, arg2) -- line: 14
    -- upvalues:
    --  [1] t (copy)

    return t.Riddles[arg2]
end

return t
