-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Time.SlowZoneSkill
-- Class: ModuleScript
-- bytes: 1824

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.VFX
local _ = Services_m.HttpService
local _ = Services_m.TweenService
local RunService = Services_m.RunService
local _ = require(Services_m.ReplicatedStorage.Modules.Utility)
local _ = _G.GetModule("Effects")
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = {
    workspace.Map,
    workspace:FindFirstChild("MapMisc"),
    workspace.Terrain
}
raycastParams.FilterType = Enum.RaycastFilterType.Include
local v2 = CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.6, 0)

local function main(arg1, arg2, arg3) -- line: 20
    -- upvalues:
    --  [1] RunService (copy)
    --  [2] raycastParams (copy)
    --  [3] v2 (copy)

    if not arg2 or not arg2.PrimaryPart then
        return
    end

    if arg1 == "Follow" and arg3 then
        local PrimaryPart = arg2.PrimaryPart
        local v3 = nil
        v3 = RunService.Heartbeat:Connect(function(deltaTime) -- line: 32
            -- upvalues:
            --  [1] arg3 (copy)
            --  [2] v3 (ref)
            --  [3] PrimaryPart (copy)
            --  [4] raycastParams (ref)
            --  [5] v2 (ref)

            if not arg3.Parent then
                v3:Disconnect()

                return
            end

            local v4 = workspace:Raycast(
                PrimaryPart.Position,
                Vector3.new(0, -10, 0),
                raycastParams
            )
            local v5 = if v4 then CFrame.lookAt(v4.Position, v4.Position + v4.Normal) * v2 else PrimaryPart.CFrame * CFrame.new(
                0,
                -2,
                0
            )
            local v7 = 1 - math.exp(-6 * deltaTime)
            arg3:PivotTo(arg3:GetPivot():Lerp(v5, v7))
        end)
    end
end

return main
