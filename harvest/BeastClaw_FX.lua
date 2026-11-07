-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Beast.BeastClaw_FX
-- Class: ModuleScript
-- bytes: 8900

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage.Modules
local VFX_m = require(Modules.Shared.VFX)
local GrimoireRarity_m = require(Modules.GrimoireRarity)
local CameraShaker_m = require(Modules.CameraShaker)
local BeastClaw = ReplicatedStorage:WaitForChild("Effects"):WaitForChild("VFX"):WaitForChild(
    "BeastClaw"
)
local _ = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
VFX_m.init()
VFX_m.preload({ BeastClaw })

for _, child in BeastClaw:GetChildren() do
    VFX_m.retime(child, 1.3)
end

CameraShaker_m.new(Enum.RenderPriority.Camera.Value, function(arg1) -- line: 36
    -- upvalues:
    --  [1] CurrentCamera (copy)

    CurrentCamera.CFrame *= arg1
end):Start()
local t = {
    { roll = 60, pitch = -30, yaw = 0 },
    { roll = 120, pitch = -30, yaw = 0 },
    { roll = 60, pitch = -30, yaw = 0 },
    { roll = 150, pitch = -30, yaw = 0 }
}

local _ = function() --[[ getFXParent ]] -- line: 73
    return workspace:FindFirstChild("Effects") or workspace
end

local _ = function(arg2, arg3) --[[ getTemplate ]] -- line: 78
    -- upvalues:
    --  [1] BeastClaw (copy)

    return BeastClaw:FindFirstChild(arg2 .. arg3) or BeastClaw:FindFirstChild(arg2)
end

local t_1 = { roll = 90, pitch = 0, yaw = 0 }

local function getHitCFrame(arg4, arg5) -- line: 83
    -- upvalues:
    --  [1] t (copy)
    --  [2] t_1 (copy)

    local v4 = t[arg5] or t_1

    return arg4.CFrame * CFrame.new(Vector3.new(0, 0, -3.5) + (v4.offset or Vector3.new(0, 0, 0))) * CFrame.Angles(
        0,
        math.rad(v4.yaw or 0),
        0
    ) * CFrame.Angles(math.rad(v4.pitch or 0), 0, 0) * CFrame.Angles(0, 0, (math.rad(v4.roll or 0)))
end

local function getEmitterCentre(arg6) -- line: 94
    local v9 = Vector3.new(0, 0, 0)
    local v10 = 0

    for _, descendant in arg6:GetDescendants() do
        if descendant:IsA("Attachment") and descendant:FindFirstChildWhichIsA("ParticleEmitter") then
            v9 += arg6.CFrame:PointToObjectSpace(descendant.WorldPosition)
            v10 += 1
        end
    end

    return v10 > 0 and v9 / v10 or Vector3.new(0, 0, 0)
end

local t_2 = {}

local function getSplit(arg7) -- line: 113
    -- upvalues:
    --  [1] t_2 (copy)
    --  [2] getEmitterCentre (copy)

    local v12 = t_2[arg7]

    if v12 then
        return v12
    end

    local t_3 = { swing = arg7, slashOffset = Vector3.new(0, 0, 0) }

    if arg7:IsA("PVInstance") then
        local Slash = arg7:FindFirstChild("slash", true)

        if Slash and Slash:IsA("BasePart") then
            t_3.slashOffset = arg7:GetPivot():PointToObjectSpace(Slash.Position)
        end
    end

    local Impact = arg7:FindFirstChild("Impact", true)

    if Impact and Impact:IsA("BasePart") and arg7:IsA("PVInstance") then
        local v14 = arg7:GetPivot()
        local v15 = arg7:Clone()
        local Impact_1 = v15:FindFirstChild("Impact", true)

        if Impact_1 then
            Impact_1:Destroy()
        end

        local v16 = Impact:Clone()
        v16.Anchored = true
        v16.CanCollide = false
        v16.CanTouch = false
        v16.CanQuery = false
        t_3.swing = v15
        t_3.impact = v16
        t_3.impactOffset = v14:ToObjectSpace(Impact.CFrame)
        t_3.impactCentre = getEmitterCentre(Impact)
    end

    t_2[arg7] = t_3

    return t_3
end

local _ = function(arg8, arg9, arg10) --[[ getSwingPivot ]] -- line: 155
    -- upvalues:
    --  [1] getHitCFrame (copy)

    return getHitCFrame(arg8, arg9) * CFrame.new(-arg10.slashOffset)
end

local function play(arg11, arg12, arg13) -- line: 161
    -- upvalues:
    --  [1] VFX_m (copy)

    if arg11:IsA("Attachment") then
        if not arg13 then
            return
        end

        VFX_m.burstOnto(arg11, arg13, arg13.CFrame:ToObjectSpace(arg12))

        return
    else
        VFX_m.burst(arg11, arg12, workspace:FindFirstChild("Effects") or workspace)

        return
    end
end

local t_4 = setmetatable({}, { __mode = "k" })

local function tintFor(arg14, arg15) -- line: 174
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] GrimoireRarity_m (copy)

    if not arg14 or not arg15 then
        return arg14
    end

    local v19 = t_4[arg14]

    if not v19 then
        v19 = {}
        t_4[arg14] = v19
    end

    local v20 = v19[arg15]

    if not v20 then
        v20 = arg14:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v20, arg15)

        if not v20:IsA("BasePart") then
            GrimoireRarity_m:ApplyVariantEffect(v20, arg15, true)
        end

        v19[arg15] = v20
    end

    return v20
end

local _ = function(arg16) --[[ inRange ]] -- line: 195
    -- upvalues:
    --  [1] CurrentCamera (copy)

    return arg16 and (arg16.Position - CurrentCamera.CFrame.Position).Magnitude <= 300
end

local function Swing(arg17, arg18, arg19) -- line: 199
    -- upvalues:
    --  [1] BeastClaw (copy)
    --  [2] CurrentCamera (copy)
    --  [3] getSplit (copy)
    --  [4] GrimoireRarity_m (copy)
    --  [5] tintFor (copy)
    --  [6] getHitCFrame (copy)
    --  [7] VFX_m (copy)

    local v22 = arg17

    if v22 then
        v22 = arg17:FindFirstChild("HumanoidRootPart")
    end

    local v24 = BeastClaw:FindFirstChild("Swing" .. arg18) or BeastClaw:FindFirstChild("Swing")
    local Beast

    if v24 then
        if v22 then
            if not (v22 and (v22.Position - CurrentCamera.CFrame.Position).Magnitude <= 300) then
                return
            end

            local v26 = getSplit(v24)
            Beast = GrimoireRarity_m:GetSkillVariant(arg17, "Beast")
            task.delay(tonumber(arg19) or 0, function() -- line: 207
                -- upvalues:
                --  [1] v22 (copy)
                --  [2] tintFor (ref)
                --  [3] v26 (copy)
                --  [4] Beast (copy)
                --  [5] arg18 (copy)
                --  [6] getHitCFrame (ref)
                --  [7] VFX_m (ref)

                if not v22.Parent then
                    return
                end

                local v27 = tintFor(v26.swing, Beast)
                local v28 = v26
                local v30 = getHitCFrame(v22, arg18) * CFrame.new(-v28.slashOffset)

                if v27:IsA("Attachment") then
                    return
                end

                VFX_m.burst(v27, v30, workspace:FindFirstChild("Effects") or workspace)
            end)

            return
        else
            return
        end
    else
        return
    end
end

local function Hit(arg20, arg21, arg22) -- line: 213
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] BeastClaw (copy)
    --  [3] getSplit (copy)
    --  [4] GrimoireRarity_m (copy)
    --  [5] getHitCFrame (copy)
    --  [6] tintFor (copy)
    --  [7] VFX_m (copy)
    --  [8] play (copy)

    local v44 = arg20

    if v44 then
        v44 = arg20:FindFirstChild("HumanoidRootPart")
    end

    local v45 = arg22

    if v45 then
        v45 = arg22:FindFirstChild("HumanoidRootPart") or arg22.PrimaryPart
    end

    local v46 = v45 or v44
    local v47 = v46 and (v46.Position - CurrentCamera.CFrame.Position).Magnitude <= 300

    if not v47 then
        return
    end

    v47 = BeastClaw:FindFirstChild("Swing" .. arg21) or BeastClaw:FindFirstChild("Swing")
    local v49 = v47 and getSplit(v47)
    v47 = arg20

    if v47 then
        v47 = GrimoireRarity_m:GetSkillVariant(arg20, "Beast")
    end

    if v49 and (v49.impact and v44) then
        local v51 = getHitCFrame(v44, arg21) * CFrame.new(-v49.slashOffset) * v49.impactOffset
        local v53 = (v45 and v45.Position or getHitCFrame(v44, arg21).Position) - v51:PointToWorldSpace(
            v49.impactCentre
        )
        local v54 = tintFor(v49.impact, v47)
        local v55 = v51 + v53

        if v54:IsA("Attachment") then
            return
        end

        VFX_m.burst(v54, v55, workspace:FindFirstChild("Effects") or workspace)

        return
    end

    if v45 then
        local v58 = BeastClaw:FindFirstChild("Hit" .. arg21) or BeastClaw:FindFirstChild("Hit")

        if v58 then
            local Position = v45.Position
            local v59 = v44 and (Position - v44.Position) * Vector3.new(1, 0, 1) or Vector3.new(0, 0, 0)

            if v59.Magnitude < 0.01 then
                v59 = v44 and v44.CFrame.LookVector or v45.CFrame.LookVector
            end

            play(tintFor(v58, v47), CFrame.lookAt(Position, Position + v59.Unit), v45)
        end
    end
end

return function(arg23, arg24, arg25, arg26) -- line: 253
    -- upvalues:
    --  [1] Swing (copy)
    --  [2] Hit (copy)

    if typeof(arg24) ~= "Instance" then
        return
    end

    arg25 = tonumber(arg25) or 1

    if arg23 == "Swing" then
        Swing(arg24, arg25, arg26)

        return
    end

    if arg23 == "Hit" then
        Hit(arg24, arg25, arg26)
    end
end
