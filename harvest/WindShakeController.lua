-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.WindShakeController
-- Class: LocalScript
-- bytes: 2658

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local WindShake_m = require(script.WindShake)
local WindLines_m = require(script.WindLines)
local Unit: Vector3 = (Vector3.new(1, 0, 0.3)).Unit
WindShake_m:SetDefaultSettings({ WindDirection = Unit, WindSpeed = 16, WindPower = 0.4 })
WindShake_m:Init({ MatchWorkspaceWind = false })
WindLines_m:Init({ Direction = Unit, Speed = 16, Lifetime = 2.5, SpawnRate = 5 })
local LocalPlayer = Players.LocalPlayer
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.RespectCanCollide = true
raycastParams.IgnoreWater = true
local t = { Vector3.new(0, 200, 0) }

for index = 0, 3 do
    table.insert(
        t,
        (CFrame.Angles(0, index * 3.141592653589793 / 2, 0) * CFrame.Angles(
            0.4363323129985824,
            0,
            0
        )):VectorToWorldSpace(Vector3.new(0, 1, 0)) * 200
    )
end

local function isCovered(vec1: Vector3, vec2: Vector3) -- line: 63
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] raycastParams (copy)

    local t_1 = { workspace.CurrentCamera }

    if LocalPlayer.Character then
        table.insert(t_1, LocalPlayer.Character)
    end

    raycastParams.FilterDescendantsInstances = t_1

    for _ = 1, 4 do
        local v1 = workspace:Raycast(vec1, vec2, raycastParams)

        if not v1 then
            return false
        end

        local v2 = v1.Instance

        if v2:IsA("BasePart") then
            if v2:HasTag("WindShake") or v2.Transparency >= 0.9 then
                raycastParams:AddToFilter(v2)
            else
                return true
            end
        else
            return true
        end
    end

    return true
end

local function isIndoors() -- line: 88
    -- upvalues:
    --  [1] t (copy)
    --  [2] isCovered (copy)

    local v3 = workspace.CurrentCamera

    if not v3 then
        return false
    end

    local Position = v3.CFrame.Position
    v3 = 0

    for _, val in t do
        if isCovered(Position, val) then
            v3 += 1
        end
    end

    return v3 >= 4
end

local v5 = 0
RunService.Heartbeat:Connect(function(deltaTime) -- line: 106
    -- upvalues:
    --  [1] v5 (ref)
    --  [2] isIndoors (copy)
    --  [3] WindLines_m (copy)

    v5 += deltaTime

    if v5 < 0.5 then
        return
    end

    v5 = 0
    local v6 = isIndoors()

    if v6 and WindLines_m.Enabled then
        WindLines_m.Enabled = false
        WindLines_m:FadeOutLines(0.6)

        return
    end

    if not v6 and not WindLines_m.Enabled then
        WindLines_m.Enabled = true
    end
end)
