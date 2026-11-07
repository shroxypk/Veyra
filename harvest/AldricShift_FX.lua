-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules._NPCS.AldricShift_FX
-- Class: ModuleScript
-- bytes: 2865

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local AldricShift = ReplicatedStorage.Effects.WeaponFX:WaitForChild("AldricShift")

local function getParts(u1: userdata) -- line: 13
    local t = {}

    if u1:IsA("BasePart") then
        table.insert(t, u1)
    end

    for _, val in u1:QueryDescendants("BasePart") do
        table.insert(t, val)
    end

    return t
end

local _ = function(u2: userdata) --[[ emitMotes ]] -- line: 24
    -- upvalues:
    --  [1] AldricShift (copy)
    --  [2] Debris (copy)

    local v1 = AldricShift.Motes:Clone()
    v1.Parent = u2
    local v2 = math.floor(u2.Size.Magnitude * 6)
    v1:Emit((math.clamp(v2, 4, 30)))
    Debris:AddItem(v1, 1.5)
end

local function emitBurst(u3: userdata) -- line: 31
    -- upvalues:
    --  [1] AldricShift (copy)
    --  [2] Debris (copy)

    local v4 = u3:FindFirstChild("Handle") or u3:FindFirstChildWhichIsA("BasePart", true)

    if not v4 then
        return
    end

    local v5 = AldricShift.Burst:Clone()
    v5.Parent = v4
    v5:Emit(2)
    Debris:AddItem(v5, 1)
end

local function fade(u4: userdata, n1: number, n2: number) -- line: 43
    -- upvalues:
    --  [1] TweenService (copy)

    TweenService:Create(
        u4,
        TweenInfo.new(n2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { Transparency = n1 }
    ):Play()
end

local CurrentCamera = workspace.CurrentCamera

return function(s1: string, u5: userdata, u6: userdata) -- line: 47
    -- upvalues:
    --  [1] CurrentCamera (copy)
    --  [2] emitBurst (copy)
    --  [3] getParts (copy)
    --  [4] AldricShift (copy)
    --  [5] Debris (copy)
    --  [6] fade (copy)

    if not u5 or not u5.PrimaryPart or not u6 or not u6.Parent then
        return
    end

    if (u5.PrimaryPart.Position - CurrentCamera.CFrame.Position).Magnitude > 300 then
        return
    end

    if s1 == "Dissolve" then
        emitBurst(u6)

        for _, val_1 in getParts(u6) do
            local v7 = AldricShift.Motes:Clone()
            v7.Parent = val_1
            v7:Emit((math.clamp(math.floor(val_1.Size.Magnitude * 6), 4, 30)))
            Debris:AddItem(v7, 1.5)
            fade(val_1, 1, 0.35)
        end

        return
    end

    if s1 == "Materialize" then
        for _, val_2 in getParts(u6) do
            local FormTransparency = val_2:GetAttribute("FormTransparency")

            if FormTransparency then
                val_2.Transparency = 1
                local v10 = AldricShift.Motes:Clone()
                v10.Parent = val_2
                v10:Emit((math.clamp(math.floor(val_2.Size.Magnitude * 6), 4, 30)))
                Debris:AddItem(v10, 1.5)
                fade(val_2, FormTransparency, 0.4)
            end
        end

        emitBurst(u6)
    end
end
