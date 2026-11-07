-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Spatial.DimensionalComet_FX
-- Class: ModuleScript
-- bytes: 528

local _ = game:GetService("ReplicatedStorage")
local CurrentCamera = workspace.CurrentCamera

local function main(arg1) -- line: 18
    -- upvalues:
    --  [1] CurrentCamera (copy)

    local Character = arg1.Character
    local _ = arg1.CastId

    if not Character or not Character.PrimaryPart then
        return
    end

    local Action = arg1.Action

    if (Character:GetPivot().Position - CurrentCamera.CFrame.Position).Magnitude > 400 then
        return
    end

    if Action == "Cast" then
    end
end

return main
