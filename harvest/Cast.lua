-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast
-- Class: ModuleScript
-- bytes: 1073

local _ = require(game:GetService("ReplicatedStorage").Modules.Basic)
local t = {}
t.__index = t
t.StoredModules = {}
_G.BURNING_TAG = "P_Burning"
_G.FREEZE_TAG = "P_Frozen"

function t.Get(arg1, arg2) -- line: 13
    if arg1.StoredModules[arg2] then
        return arg1.StoredModules[arg2]
    end

    for _, descendant in script.Functions:GetDescendants() do
        if descendant:IsA("ModuleScript") and descendant.Name == arg2 then
            arg1.StoredModules[arg2] = require(descendant)

            return arg1.StoredModules[arg2]
        end
    end
end

function t.scriptObjs() -- line: 25
    local Players = game:GetService("Players")
    local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
    local ServerStorage = game:GetService("ServerStorage")

    return Players, ReplicatedStorage_1, ServerStorage, game:GetService("ServerScriptService"), game:GetService(
        "RunService"
    ), game:GetService("TweenService"), game:GetService("CollectionService"), ServerStorage.Assets, workspace.FightableNPCS, workspace.pCharacters
end

return t
