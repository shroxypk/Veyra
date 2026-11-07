-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.TeleportCharacter
-- Class: ModuleScript
-- bytes: 6973

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local ZeroSecure_m = require(game:GetService("ServerStorage").GameModules.ZeroSecure)
local StreamingEnabled = workspace.StreamingEnabled
local t = setmetatable({}, { __mode = "k" })

local function tp(u1: userdata, arg1: any, arg2: any) -- line: 22
    -- upvalues:
    --  [1] StreamingEnabled (copy)
    --  [2] t (copy)
    --  [3] ZeroSecure_m (copy)
    --  [4] ReplicatedStorage (copy)

    if not u1 then
        return
    end

    local cframe

    if typeof(arg1) ~= "CFrame" then
        if typeof(arg1) == "Vector3" then
            cframe = CFrame.new(arg1)
        else
            return
        end
    end

    if StreamingEnabled then
        pcall(function() -- line: 36
            -- upvalues:
            --  [1] u1 (copy)
            --  [2] cframe (ref)

            u1:RequestStreamAroundAsync(cframe.Position, 3)
        end)
    end

    local v7 = nil
    local Humanoid = nil
    local PrimaryPart = nil
    local t_1 = {}

    local _ = function() --[[ superseded ]] -- line: 44
        -- upvalues:
        --  [1] v7 (ref)
        --  [2] t (ref)
        --  [3] t_1 (copy)

        return if v7 == nil then false else t[v7] ~= t_1
    end

    local t_2 = {}
    local _, Result = pcall(function() -- line: 52
        -- upvalues:
        --  [1] v7 (ref)
        --  [2] u1 (copy)
        --  [3] Humanoid (ref)
        --  [4] PrimaryPart (ref)
        --  [5] t (ref)
        --  [6] t_1 (copy)
        --  [7] ZeroSecure_m (ref)
        --  [8] t_2 (copy)
        --  [9] ReplicatedStorage (ref)
        --  [10] arg2 (copy)
        --  [11] cframe (ref)

        v7 = u1.Character or u1.CharacterAdded:Wait()
        Humanoid = v7.Humanoid
        PrimaryPart = v7.PrimaryPart

        if PrimaryPart:CanSetNetworkOwnership() then
        end

        t[v7] = t_1
        Humanoid.PlatformStand = true
        PrimaryPart.Anchored = true

        local function updatePosition(arg3) -- line: 67
            -- upvalues:
            --  [1] v7 (ref)
            --  [2] t (ref)
            --  [3] t_1 (ref)
            --  [4] PrimaryPart (ref)
            --  [5] ZeroSecure_m (ref)
            --  [6] u1 (ref)
            --  [7] t_2 (ref)
            --  [8] ReplicatedStorage (ref)

            local v12 = 0
            local v15

            repeat
                if if v7 == nil then false else t[v7] ~= t_1 then
                    break
                end

                v12 += 1
                local Rotation = PrimaryPart.CFrame.Rotation
                PrimaryPart.Velocity = Vector3.new(0, 0, 0)
                PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                ZeroSecure_m:MoveCharacter(u1, Rotation + arg3.Position)

                for _, child in v7:GetChildren() do
                    if child:IsA("BasePart") then
                        child.Velocity = Vector3.new(0, 0, 0)
                    end
                end

                for _, val in v7:QueryDescendants("BodyPosition, AlignPosition") do
                    if not t_2[val] then
                        val.Position = arg3.Position
                    end
                end

                local BodyPosition = Instance.new("BodyPosition")
                BodyPosition.MaxForce = Vector3.new(Infinity, Infinity, Infinity)
                BodyPosition.Position = arg3.Position + Vector3.new(0, 3, 0)
                BodyPosition.Parent = v7.Head
                t_2[BodyPosition] = true
                task.spawn(pcall, function() -- line: 103
                    -- upvalues:
                    --  [1] ReplicatedStorage (ref)
                    --  [2] u1 (ref)
                    --  [3] PrimaryPart (ref)
                    --  [4] arg3 (copy)

                    ReplicatedStorage.Remotes.setClientMovers:InvokeClient(
                        u1,
                        PrimaryPart,
                        arg3.Position
                    )
                end)
                task.wait(0.5)

                for _, child_1 in v7:GetChildren() do
                    if child_1:IsA("BasePart") then
                        child_1.Velocity = Vector3.new(0, 0, 0)
                    end
                end

                PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)

                if (PrimaryPart.Position - arg3.Position).Magnitude < 5 or (v12 >= 12 or (u1.Character ~= v7 or not PrimaryPart.Parent)) then
                    break
                end

                v15 = if v7 == nil then false else t[v7] ~= t_1
            until v15

            if (PrimaryPart.Position - arg3.Position).Magnitude >= 5 and u1.Character == v7 then
                if not (if v7 == nil then false else t[v7] ~= t_1) then
                    local g_warn = warn
                    local Name = u1.Name
                    local v17 = math.floor((PrimaryPart.Position - arg3.Position).Magnitude)
                    g_warn(
                        `[TeleportCharacter] {Name} didn't reach the destination after {v12} attempts ({v17} studs away)`
                    )
                end
            end
        end

        if arg2 then
            ReplicatedStorage.Remotes.Transition:FireClient(
                u1,
                { Type = "Teleport", Action = "In" }
            )
            task.wait(0.5)
        end

        updatePosition(cframe)

        for key_3 in t_2 do
            key_3:Destroy()
        end

        table.clear(t_2)

        if if v7 == nil then false else t[v7] ~= t_1 then
            if arg2 then
                ReplicatedStorage.Remotes.Transition:FireClient(
                    u1,
                    { Type = "Teleport", Action = "Out" }
                )
            end

            return
        end

        for _, child_2 in v7:GetChildren() do
            if child_2:IsA("BasePart") then
                child_2.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                child_2.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            end
        end

        PrimaryPart.Anchored = false

        if PrimaryPart:CanSetNetworkOwnership() then
        end

        if Humanoid then
            Humanoid.PlatformStand = false
        end

        if arg2 then
            ReplicatedStorage.Remotes.Transition:FireClient(
                u1,
                { Type = "Teleport", Action = "Out" }
            )
            task.wait(0.5)
        end
    end)

    if Result then
        warn(Result)
    end

    for key_5 in t_2 do
        key_5:Destroy()
    end

    if if v7 == nil then false else t[v7] ~= t_1 then
        return
    end

    if v7 then
        t[v7] = nil
    end

    if PrimaryPart and PrimaryPart.Parent and PrimaryPart.Anchored then
        PrimaryPart.Anchored = false
    end

    if Humanoid and Humanoid.Parent and Humanoid.PlatformStand then
        Humanoid.PlatformStand = false
    end
end

return tp
