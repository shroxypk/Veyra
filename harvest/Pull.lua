-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.Lizard.Pull
-- Class: ModuleScript
-- bytes: 2339

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.VFX
local _ = Services_m.HttpService
local RunService = Services_m.RunService
local TweenService = Services_m.TweenService
local Utility_m = require(Services_m.ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

local _ = function(
    u1: userdata,
    n1: number,
    n2: number,
    n3: number,
    u2: userdata,
    u3: userdata
) --[[ tweenScale ]] -- line: 18
    -- upvalues:
    --  [1] RunService (copy)
    --  [2] TweenService (copy)

    local v2 = 0

    local _ = function(n4: number, n5: number, n6: number) --[[ lerp ]] -- line: 24
        return n4 + (n5 - n4) * n6
    end

    local v3 = n2 + n3
    local v4 = nil
    v4 = RunService.Heartbeat:Connect(function(deltaTime) -- line: 28
        -- upvalues:
        --  [1] v2 (ref)
        --  [2] TweenService (ref)
        --  [3] n1 (copy)
        --  [4] u2 (copy)
        --  [5] u3 (copy)
        --  [6] u1 (copy)
        --  [7] n2 (copy)
        --  [8] v3 (copy)
        --  [9] v4 (ref)

        v2 += deltaTime
        local v7 = TweenService:GetValue(math.min(v2 / n1, 1), u2, u3)
        local v8 = n2
        u1:ScaleTo(v8 + (v3 - v8) * v7)

        if v2 >= n1 then
            v4:Disconnect()
        end
    end)
end

return function(arg2, _, arg4, arg5) -- line: 39
    -- upvalues:
    --  [1] Utility_m (copy)

    if arg2 == "PullAura" then
        local v10 = script.Hit:Clone()
        v10.CFrame = arg5.CFrame
        v10.Parent = workspace.Effects
        Utility_m.EmitParticles(v10)
        _G.Debris(v10, 5)
        local v11 = script.PullBackWind:Clone()
        v11.Name = arg4.Name .. "PullBack"
        v11.Parent = workspace.Effects
        Utility_m.Toggle(v11, true)
        local Weld = Instance.new("Weld")
        Weld.Part0 = arg5
        Weld.Part1 = v11
        Weld.C0 = CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966)
        Weld.Parent = v11

        return
    end

    if arg2 == "PullBackFinished" then
        local v13 = workspace.Effects:FindFirstChild(arg4.Name .. "PullBack")
        Utility_m.Toggle(v13, false)
        _G.Debris(v13, 2)
    end
end
