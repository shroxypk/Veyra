-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Shadow.Tendril
-- Class: ModuleScript
-- bytes: 1304

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local ReplicatedStorage = Services_m.ReplicatedStorage
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local CameraShaker_m = require(ReplicatedStorage.Modules:FindFirstChild("CameraShaker"))
local CurrentCamera = workspace.CurrentCamera
CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 13
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end):Start()
local _ = require(ReplicatedStorage.Modules.Utility)
local _ = _G.GetModule("Effects")
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

return function(arg2, arg3, arg4, arg5) -- line: 25
    local ClientDebris = workspace.Map:WaitForChild("client_debris")

    if arg2 == "Lock" then
        local v3 = script.Barrier:Clone()
        v3.Name = arg4
        v3.Position = arg3.Position
        v3.Size = Vector3.new(arg5, 200, arg5)
        v3.Parent = ClientDebris

        return
    end

    if arg2 == "Destroy" then
        local v4 = ClientDebris:FindFirstChild(arg4)

        if v4 then
            v4:Destroy()
        end
    end
end
