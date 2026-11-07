-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.CloverClient.Attack Modules.Spatial.RiftDive_FX
-- Class: ModuleScript
-- bytes: 14526

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Modules = ReplicatedStorage.Modules
local VFX_m = require(Modules.Shared.VFX)
local GrimoireRarity_m = require(Modules.GrimoireRarity)
local ForgeVFX_m = require(Modules.Packages.ForgeVFX)
local Skills_m = require(Modules.Skills)
local Spatial = ReplicatedStorage.Effects.VFX.Spatial
local Dive = Skills_m:LookupSkill("Rift Dive").Dive
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local t = {
    Teleport = Spatial.Counter.Teleport,
    HitEffect = Spatial.Counter.HitEffect,
    Marker = Spatial.Mark.Lop,
    Portal = Spatial["Spatial Volley"].Portal,
    Shoot = Spatial["Spatial Volley"].Shoot,
    Trail = Spatial["Spatial Volley"].Projectile,
    Emit = Spatial["Spatial Volley"].Emit,
    GroundFX = Spatial["Skyward Ascent"].GroundFX
}
local t_1 = {
    Color = nil,
    PortalRotation = CFrame.identity,
    ShootRotation = CFrame.Angles(0, 3.141592653589793, 0),
    ShootOffset = CFrame.new(0, 0, -3),
    MarkerHeight = 2.25,
    AimSendInterval = 0.06666666666666667,
    GroundFXHeight = 0.2,
    EmitHeight = 2.8,
    ImpactShake = { { 2.2, 26, 0, 0.18, 0 }, { 1.6, 30, 0, 0.2, 0.07 } },
    ImpactShakeDistance = 120
}
local RiftDiveAim = ReplicatedStorage.Remotes:WaitForChild("RiftDiveAim")

local function shake(vec1: Vector3, n1: number, t1: table) -- line: 87
    -- upvalues:
    --  [1] CurrentCamera (copy)

    if not _G.CameraShake then
        return
    end

    if n1 < (vec1 - CurrentCamera.CFrame.Position).Magnitude then
        return
    end

    for _, val in t1 do
        local v1, v2, v3, v4, v5 = table.unpack(val)
        local t_2 = { v1, v2, v3, v4 }

        if v5 and v5 > 0 then
            task.delay(v5, _G.CameraShake, t_2)
        else
            _G.CameraShake(t_2)
        end
    end
end

local _ = function(vec2: Vector3) --[[ inRange ]] -- line: 105
    -- upvalues:
    --  [1] CurrentCamera (copy)

    return (vec2 - CurrentCamera.CFrame.Position).Magnitude <= 400
end

local t_3 = {}

local function artFor(arg1: any, u1: userdata) -- line: 112
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] t_1 (copy)
    --  [3] GrimoireRarity_m (copy)
    --  [4] t (copy)

    if typeof(arg1) == "string" and t_3[arg1] then
        return t_3[arg1]
    end

    local v7 = if t_1.Color then { Primary = t_1.Color } else GrimoireRarity_m:GetSkillVariant(
        u1,
        "Spatial"
    )

    if not v7 then
        return t
    end

    local t_4 = {}

    for key_1, val_1 in t do
        local v9 = val_1:Clone()
        GrimoireRarity_m:ApplyVariantEffect(v9, v7)
        t_4[key_1] = v9
    end

    if typeof(arg1) == "string" then
        t_3[arg1] = t_4
    end

    task.delay(5, function() -- line: 133
        -- upvalues:
        --  [1] arg1 (copy)
        --  [2] t_3 (ref)
        --  [3] t_4 (copy)

        if typeof(arg1) == "string" then
            t_3[arg1] = nil
        end

        for _, val_2 in t_4 do
            val_2:Destroy()
        end
    end)

    return t_4
end

local function burstModel(u2: userdata, u3: CFrame) -- line: 147
    -- upvalues:
    --  [1] ForgeVFX_m (copy)

    local v10 = u2:Clone()
    v10:PivotTo(u3)
    v10.Parent = workspace
    local v11 = 0

    local function finished() -- line: 153
        -- upvalues:
        --  [1] v11 (ref)
        --  [2] v10 (copy)

        v11 -= 1

        if v11 <= 0 then
            v10:Destroy()
        end
    end

    for _, child in v10:GetChildren() do
        if not child:IsA("BasePart") then
            if not child:IsA("Model") then
                if child:IsA("Attachment") then
                    v11 += 1
                    ForgeVFX_m.emit(child).Finished:catch(function(arg2) -- line: 164
                        -- upvalues:
                        --  [1] u2 (copy)
                        --  [2] child (copy)

                        warn(`[RiftDive_FX] emit failed for {u2.Name}.{child.Name}: {arg2}`)
                    end):finally(finished)
                end
            else
                v11 += 1
                ForgeVFX_m.emit(child).Finished:catch(function(arg3) -- line: 164
                    -- upvalues:
                    --  [1] u2 (copy)
                    --  [2] child (copy)

                    warn(`[RiftDive_FX] emit failed for {u2.Name}.{child.Name}: {arg3}`)
                end):finally(finished)
            end
        else
            v11 += 1
            ForgeVFX_m.emit(child).Finished:catch(function(arg4) -- line: 164
                -- upvalues:
                --  [1] u2 (copy)
                --  [2] child (copy)

                warn(`[RiftDive_FX] emit failed for {u2.Name}.{child.Name}: {arg4}`)
            end):finally(finished)
        end
    end

    if v11 == 0 then
        v10:Destroy()
    end
end

local Rotation = t.GroundFX.CFrame.Rotation
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.IgnoreWater = true
local v12 = nil

local _ = function(arg5) --[[ stopAiming ]] -- line: 187
    -- upvalues:
    --  [1] v12 (ref)

    if v12 and (arg5 == nil or v12.CastId == arg5) then
        v12.Stop()
        v12 = nil
    end
end

local function markerPoint(vec3: Vector3, vec4: Vector3) -- line: 196
    -- upvalues:
    --  [1] UserInputService (copy)
    --  [2] CurrentCamera (copy)
    --  [3] raycastParams (copy)
    --  [4] Dive (copy)

    local v13 = UserInputService:GetMouseLocation()
    local v14 = CurrentCamera:ViewportPointToRay(v13.X, v13.Y)
    local v16 = workspace:Raycast(v14.Origin, v14.Direction * 1000, raycastParams)
    local v17 = if v16 then v16.Position else v14.Origin + v14.Direction * 1000
    v14 = Vector3.new(v17.X - vec3.X, 0, v17.Z - vec3.Z)

    if v14.Magnitude > Dive.MaxRange then
        v14 = v14.Unit * Dive.MaxRange
    end

    v17 = Vector3.new(vec3.X + v14.X, vec4.Y, vec3.Z + v14.Z)
    v14 = workspace:Raycast(
        v17,
        Vector3.new(0, -(vec4.Y - vec3.Y) - Dive.MaxDrop - 3, 0),
        raycastParams
    )

    if v14 then
        return v14.Position
    end

    return (Vector3.new(v17.X, vec3.Y, v17.Z))
end

local function startAiming(arg6: any, s1: string, vec5: Vector3, vec6: Vector3) -- line: 212
    -- upvalues:
    --  [1] v12 (ref)
    --  [2] LocalPlayer (copy)
    --  [3] raycastParams (copy)
    --  [4] markerPoint (copy)
    --  [5] VFX_m (copy)
    --  [6] t_1 (copy)
    --  [7] RiftDiveAim (copy)
    --  [8] RunService (copy)
    --  [9] UserInputService (copy)
    --  [10] Dive (copy)

    if v12 then
        v12.Stop()
        v12 = nil
    end

    raycastParams.FilterDescendantsInstances = {
        LocalPlayer.Character,
        workspace.Effects,
        workspace.pCharacters,
        workspace.FightableNPCS
    }
    local v19 = markerPoint(vec5, vec6)
    local v21 = VFX_m.sustain(
        arg6.Marker,
        CFrame.new(v19 + Vector3.new(0, t_1.MarkerHeight, 0)),
        workspace.Effects
    )
    local t_5 = {}
    local t_6 = {}
    local v22 = v21.Instance

    for _, val_3 in { v22, table.unpack(v22:QueryDescendants("BasePart")) } do
        val_3.Anchored = true
        table.insert(t_5, val_3)
        table.insert(t_6, v22.CFrame:ToObjectSpace(val_3.CFrame))
    end

    local t_8 = table.create(#t_5)
    local v23 = false
    local v24 = 0

    local _ = function(b1: boolean) --[[ send ]] -- line: 236
        -- upvalues:
        --  [1] RiftDiveAim (ref)
        --  [2] s1 (copy)
        --  [3] v19 (ref)
        --  [4] v24 (ref)

        RiftDiveAim:FireServer(s1, v19, b1)
        v24 = os.clock()
    end

    RiftDiveAim:FireServer(s1, v19, false)
    v24 = os.clock()
    local v27 = RunService.RenderStepped:Connect(function() -- line: 243
        -- upvalues:
        --  [1] v19 (ref)
        --  [2] markerPoint (ref)
        --  [3] vec5 (copy)
        --  [4] vec6 (copy)
        --  [5] t_1 (ref)
        --  [6] t_6 (copy)
        --  [7] t_8 (copy)
        --  [8] t_5 (copy)
        --  [9] v23 (ref)
        --  [10] v24 (ref)
        --  [11] RiftDiveAim (ref)
        --  [12] s1 (copy)

        v19 = markerPoint(vec5, vec6)
        local cframe = CFrame.new(v19 + Vector3.new(0, t_1.MarkerHeight, 0))

        for key_5, val_4 in t_6 do
            t_8[key_5] = cframe * val_4
        end

        workspace:BulkMoveTo(t_5, t_8, Enum.BulkMoveMode.FireCFrameChanged)

        if not v23 and os.clock() - v24 >= t_1.AimSendInterval then
            RiftDiveAim:FireServer(s1, v19, false)
            v24 = os.clock()
        end
    end)
    local v28 = UserInputService.InputBegan:Connect(function(input) -- line: 257
        -- upvalues:
        --  [1] v23 (ref)
        --  [2] RiftDiveAim (ref)
        --  [3] s1 (copy)
        --  [4] v19 (ref)
        --  [5] v24 (ref)

        if v23 then
            return
        end

        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            v23 = true
            RiftDiveAim:FireServer(s1, v19, true)
            v24 = os.clock()
        end
    end)
    local t_9 = { CastId = s1, Stop = nil }

    function t_9.Stop() -- line: 270
        -- upvalues:
        --  [1] v27 (copy)
        --  [2] v28 (copy)
        --  [3] v21 (copy)

        v27:Disconnect()
        v28:Disconnect()
        v21.Stop(0.5)
    end

    local v29 = t_9
    v12 = v29
    task.delay(Dive.AimWindow + 2, function() -- line: 279
        -- upvalues:
        --  [1] v12 (ref)
        --  [2] v29 (ref)

        if v12 == v29 and v12 then
            v12.Stop()
            v12 = nil
        end
    end)
end

VFX_m.init()
VFX_m.preload(
    { Spatial.Counter, Spatial.Mark, Spatial["Spatial Volley"], Spatial["Skyward Ascent"].GroundFX }
)

local function main(arg8) -- line: 291
    -- upvalues:
    --  [1] LocalPlayer (copy)
    --  [2] v12 (ref)
    --  [3] CurrentCamera (copy)
    --  [4] VFX_m (copy)
    --  [5] artFor (copy)
    --  [6] startAiming (copy)
    --  [7] Dive (copy)
    --  [8] t_1 (copy)
    --  [9] burstModel (copy)
    --  [10] Rotation (copy)
    --  [11] shake (copy)

    local Character = arg8.Character
    local Action = arg8.Action
    local CastId = arg8.CastId
    local Position = arg8.Position

    if not Character then
        return
    end

    local v30 = Character == LocalPlayer.Character

    if Action == "Cancel" then
        if v30 and (v12 and (CastId == nil or v12.CastId == CastId)) then
            v12.Stop()
            v12 = nil
        end

        return
    end

    if Action == "Hit" then
        local Root = arg8.Root

        if typeof(Root) == "Instance" and Root:IsA("BasePart") then
            if if not ((Root.Position - CurrentCamera.CFrame.Position).Magnitude <= 400) then false else true then
                VFX_m.burst(artFor(CastId, Character).HitEffect, Root.CFrame)
            end
        end

        return
    end

    if typeof(Position) ~= "CFrame" then
        return
    end

    if Action == "Rise" then
        local EndPosition = arg8.EndPosition

        if typeof(EndPosition) ~= "CFrame" then
            return
        end

        local v32 = artFor(CastId, Character)

        if v30 and typeof(CastId) == "string" then
            startAiming(v32, CastId, Position.Position, EndPosition.Position)
        end

        if if not ((Position.Position - CurrentCamera.CFrame.Position).Magnitude <= 400) then false else true then
            VFX_m.burst(v32.Teleport, Position)
        end

        if if not ((EndPosition.Position - CurrentCamera.CFrame.Position).Magnitude <= 400) then false else true then
            VFX_m.burst(v32.Teleport, EndPosition)
            local v34 = EndPosition.Position + Vector3.new(0, Dive.PortalGap, 0)
            VFX_m.burst(
                v32.Portal,
                CFrame.lookAt(v34, v34 - Vector3.new(0, 1, 0), EndPosition.LookVector) * t_1.PortalRotation
            )

            return
        end
    else
        local v35

        if Action == "Dive" then
            if v30 and (v12 and (CastId == nil or v12.CastId == CastId)) then
                v12.Stop()
                v12 = nil
            end

            v35 = arg8.EndPosition

            if typeof(v35) ~= "Vector3" then
                return
            end

            if not (if not ((Position.Position - CurrentCamera.CFrame.Position).Magnitude <= 400) then false else true) then
                if not (if not ((v35 - CurrentCamera.CFrame.Position).Magnitude <= 400) then false else true) then
                    return
                end
            end

            local v36 = artFor(CastId, Character)
            burstModel(v36.Shoot, Position * t_1.ShootOffset * t_1.ShootRotation)
            local PrimaryPart = Character.PrimaryPart

            if PrimaryPart then
                local v37 = (v35 - Position.Position).Magnitude / Dive.DiveSpeed
                local v40 = VFX_m.burstAttached(
                    v36.Trail,
                    PrimaryPart,
                    PrimaryPart.CFrame:ToObjectSpace(
                        CFrame.new(PrimaryPart.Position) * Position.Rotation
                    ),
                    v37 + 0.4
                )

                for _, val_5 in { v40, table.unpack(v40:GetDescendants()) } do
                    if val_5:IsA("BasePart") then
                        val_5.Transparency = 1
                    elseif val_5:IsA("Trail") then
                        val_5.Enabled = true
                    end
                end

                return
            end
        elseif Action == "Impact" then
            v35 = arg8.EndPosition == true
            local v41 = (Position.Position - CurrentCamera.CFrame.Position).Magnitude <= 400 and true

            if v41 then
                v41 = artFor(CastId, Character)

                if v35 then
                    VFX_m.burst(
                        v41.GroundFX,
                        Position * CFrame.new(0, t_1.GroundFXHeight, 0) * Rotation
                    )
                end

                local v42 = if not v35 then 0 else t_1.EmitHeight
                VFX_m.burst(v41.Emit, CFrame.new(Position.Position + Vector3.new(0, v42, 0)))
            end

            shake(Position.Position, t_1.ImpactShakeDistance, t_1.ImpactShake)
        end
    end
end

return main
