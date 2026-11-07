-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._Weapons.Crits.VenomFang
-- Class: ModuleScript
-- bytes: 2178

local Services_m = require(game:GetService("ReplicatedFirst").Services)
local _ = Services_m.RunService
local _ = Services_m.VFX
local _ = Services_m.HttpService
local Utility_m = require(Services_m.ReplicatedStorage.Modules.Utility)
local raycastParams = RaycastParams.new()
raycastParams.FilterDescendantsInstances = { workspace.Map, workspace.Terrain }
raycastParams.FilterType = Enum.RaycastFilterType.Include

local function EasyWeld(arg1, arg2) -- line: 17
    local Weld = Instance.new("Weld")
    Weld.Part0 = arg1
    Weld.Part1 = arg2
    Weld.Parent = arg2
    local v2 = nil
    v2 = arg2.AncestryChanged:Connect(function(_, arg4) -- line: 24
        -- upvalues:
        --  [1] Weld (copy)
        --  [2] v2 (ref)

        if not arg4 then
            Weld:Destroy()
            v2:Disconnect()
        end
    end)
    local v3 = nil
    v3 = arg1.AncestryChanged:Connect(function(_, arg6) -- line: 31
        -- upvalues:
        --  [1] Weld (copy)
        --  [2] v3 (ref)

        if not arg6 then
            Weld:Destroy()
            v3:Disconnect()
        end
    end)
end

return function(arg7, arg8, arg9) -- line: 39
    -- upvalues:
    --  [1] Utility_m (copy)
    --  [2] EasyWeld (copy)

    if not arg8 or (arg8.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 500 then
        return
    end

    if arg7 == "Dash" then
        local v4 = script.Dash:Clone()
        v4.CFrame = arg8.CFrame
        v4.Parent = workspace.Effects
        Utility_m.EmitParticles(v4)
        _G.Debris(v4, 4)

        return
    end

    if arg7 == "Trails" then
        local v5 = script.Trails:Clone()
        v5.Parent = workspace.Effects

        for _, val in pairs(v5:GetChildren()) do
            EasyWeld(val, (arg9:FindFirstChild(val.Name)))
        end

        Utility_m.Toggle(v5, true)
        task.wait(0.6)
        Utility_m.Toggle(v5, false)
        _G.Debris(v5, 3)

        return
    end

    if arg7 == "Slashes" then
        local v7 = script.Slashes:Clone()
        _G.Debris(v7, 4)
        v7.CFrame = arg8.CFrame * CFrame.new(0, -2.5, 0)
        v7.Parent = workspace.Effects
        Utility_m.EmitParticles(v7)
    end
end
