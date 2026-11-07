-- Decompiled with Veyra harvester
-- Instance: StarterGui.ButtonEFFECTS
-- Class: LocalScript
-- bytes: 1076

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local ButtonControl_m = require(ReplicatedStorage.Modules.ButtonControl)

local function AddInstance(arg1) -- line: 17
    -- upvalues:
    --  [1] ButtonControl_m (copy)

    if arg1:GetAttribute("buttonEffectsInstanced") then
        return
    end

    arg1.DescendantAdded:Connect(function(descendant_1) --[[ setupButton ]] -- line: 21
        -- upvalues:
        --  [1] ButtonControl_m (ref)

        if descendant_1:IsA("GuiButton") then
            ButtonControl_m.new(descendant_1)
        end
    end)

    for _, descendant in arg1:GetDescendants() do
        if descendant:IsA("GuiButton") then
            ButtonControl_m.new(descendant)
        end
    end
end

CollectionService:GetInstanceAddedSignal("useButtonEffects"):Connect(AddInstance)

for _, val in CollectionService:GetTagged("useButtonEffects") do
    AddInstance(val)
end
