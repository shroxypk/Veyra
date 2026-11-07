-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.NPCGrimoireClient
-- Class: LocalScript
-- bytes: 13014

local CollectionService = game:GetService("CollectionService")
local v1 = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local t = {
    Default = {
        offset = CFrame.new(-2.5, 0, -2),
        angle = CFrame.Angles(1.5707963267948966, 3.141592653589793, 0.6108652381980153),
        bob = Vector3.new(0, 0, 0.2)
    },
    Time = { offset = CFrame.new(0, 10, 0), angle = nil, bob = Vector3.new(0, 0.5, 0) }
}
local NPCGrimoireBooks = v1:WaitForChild("NPCGrimoireBooks")
local GrimoireAnimations = v1:WaitForChild("Animations"):WaitForChild("GrimoireAnimations")
v1 = workspace:FindFirstChild("Effects") or workspace.CurrentCamera
local t_3 = {}
local t_4 = {}
local t_5 = {}

local function newBook(s1: string) -- line: 60
    -- upvalues:
    --  [1] NPCGrimoireBooks (copy)

    local v2 = (NPCGrimoireBooks:FindFirstChild(s1) or NPCGrimoireBooks.Grimoire_Default):Clone()
    local PrimaryPart = v2.PrimaryPart
    local t_6 = {}
    local t_7 = {}

    for _, descendant in v2:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false
            descendant.CanTouch = false
            descendant.CanQuery = false
            descendant.CastShadow = false
            table.insert(t_6, descendant)
        elseif not descendant:IsA("ParticleEmitter") then
            if not descendant:IsA("Beam") then
                if descendant:IsA("Trail") then
                    table.insert(t_7, { descendant, descendant.Enabled })
                    descendant.Enabled = false
                end
            else
                table.insert(t_7, { descendant, descendant.Enabled })
                descendant.Enabled = false
            end
        else
            table.insert(t_7, { descendant, descendant.Enabled })
            descendant.Enabled = false
        end
    end

    PrimaryPart.Anchored = true
    local BookAttach = PrimaryPart:FindFirstChild("BookAttach")
    local AnimationController = v2:FindFirstChildWhichIsA("AnimationController")
    local t_8 = {
        name = s1,
        model = v2,
        root = PrimaryPart,
        parts = t_6,
        emitters = t_7,
        attach = nil,
        animator = nil,
        track = nil,
        fxOn = false
    }
    local v3 = BookAttach and BookAttach.CFrame or CFrame.identity
    t_8.attach = v3
    v3 = AnimationController

    if v3 then
        v3 = AnimationController:FindFirstChildWhichIsA("Animator") or AnimationController
    end

    t_8.animator = v3

    return t_8
end

local _ = function(arg1: any, b1: boolean) --[[ setFx ]] -- line: 96
    if arg1.fxOn == b1 then
        return
    end

    arg1.fxOn = b1

    for _, val in arg1.emitters do
        local v4 = b1 and val[2]
        val[1].Enabled = v4
    end
end

local function playAnimation(arg2: any, b2: boolean) -- line: 107
    -- upvalues:
    --  [1] GrimoireAnimations (copy)

    if not arg2.animator then
        return
    end

    if not arg2.track then
        local v6 = GrimoireAnimations:FindFirstChild(if not b2 then "Open" else "TimeIdle")

        if not v6 then
            return
        end

        local v7 = arg2.animator:LoadAnimation(v6)

        if b2 then
            v7.Priority = Enum.AnimationPriority.Action2
        else
            v7.Looped = false
            v7:GetMarkerReachedSignal("End"):Connect(function() -- line: 123
                -- upvalues:
                --  [1] v7 (copy)

                v7:AdjustSpeed(0)
            end)
        end

        arg2.track = v7
    end

    arg2.track:Stop(0)
    arg2.track:Play(0.2)
    arg2.track:AdjustSpeed(1)
end

local _ = function(arg3) --[[ stash ]] -- line: 135
    -- upvalues:
    --  [1] t_5 (copy)

    if arg3.fxOn ~= false then
        arg3.fxOn = false

        for _, val_1 in arg3.emitters do
            val_1[1].Enabled = false
        end
    end

    arg3.model.Parent = nil
    local v8 = t_5[arg3.name]

    if not v8 then
        v8 = {}
        t_5[arg3.name] = v8
    end

    table.insert(v8, arg3)
end

local _ = function(arg4) --[[ removeActive ]] -- line: 149
    -- upvalues:
    --  [1] t_4 (copy)

    local v9 = table.find(t_4, arg4)

    if v9 then
        t_4[v9] = t_4[#t_4]
        t_4[#t_4] = nil
    end
end

local function acquire(arg5) -- line: 157
    -- upvalues:
    --  [1] NPCGrimoireBooks (copy)
    --  [2] t_5 (copy)
    --  [3] newBook (copy)
    --  [4] t (copy)
    --  [5] v1 (copy)
    --  [6] playAnimation (copy)
    --  [7] t_4 (copy)

    local GrimoireMagic = arg5.npc:GetAttribute("GrimoireMagic")
    local v10 = GrimoireMagic and (NPCGrimoireBooks:FindFirstChild(GrimoireMagic) and GrimoireMagic) or "Grimoire_Default"
    local v11 = t_5[v10]
    local v12 = v11 and table.remove(v11) or newBook(v10)
    arg5.book = v12
    local v13 = t[GrimoireMagic] or t.Default
    arg5.pose = v13
    arg5.cf = nil
    v12.model.Parent = v1
    playAnimation(v12, GrimoireMagic == "Time")
    table.insert(t_4, arg5)
end

local function release(arg6: any, b3: boolean?) -- line: 174
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] t_5 (copy)
    --  [3] TweenService (copy)

    local Book = arg6.book

    if not Book then
        return
    end

    arg6.book = nil
    local v15 = table.find(t_4, arg6)

    if v15 then
        t_4[v15] = t_4[#t_4]
        t_4[#t_4] = nil
    end

    if not b3 then
        if Book.fxOn ~= false then
            Book.fxOn = false

            for _, val_2 in Book.emitters do
                val_2[1].Enabled = false
            end
        end

        Book.model.Parent = nil
        local v16 = t_5[Book.name]

        if not v16 then
            v16 = {}
            t_5[Book.name] = v16
        end

        table.insert(v16, Book)

        return
    end

    if Book.fxOn ~= false then
        Book.fxOn = false

        for _, val_3 in Book.emitters do
            val_3[1].Enabled = false
        end
    end

    local tweenInfo = TweenInfo.new(0.4)

    for _, val_4 in Book.parts do
        TweenService:Create(val_4, tweenInfo, { LocalTransparencyModifier = 1 }):Play()
    end

    task.delay(0.45, function() -- line: 194
        -- upvalues:
        --  [1] Book (copy)
        --  [2] t_5 (ref)

        for _, val_5 in Book.parts do
            val_5.LocalTransparencyModifier = 0
        end

        local v17 = Book

        if v17.fxOn ~= false then
            v17.fxOn = false

            for _, val_6 in v17.emitters do
                val_6[1].Enabled = false
            end
        end

        v17.model.Parent = nil
        local v18 = t_5[v17.name]

        if not v18 then
            v18 = {}
            t_5[v17.name] = v18
        end

        table.insert(v18, v17)
    end)
end

local function onAdded(u1: userdata) -- line: 202
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] t (copy)

    local _

    if not t_3[u1] then
        if not u1:IsA("Model") then
            return
        end

        t_3[u1] = {
            npc = u1,
            book = nil,
            pose = t.Default,
            cf = nil,
            dist = 0,
            phase = math.random() * 5.2
        }

        return
    else
        return
    end
end

local function onRemoved(u2: userdata) -- line: 217
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] release (copy)

    local v21 = t_3[u2]

    if not v21 then
        return
    end

    t_3[u2] = nil
    release(v21, u2:IsDescendantOf(workspace))
end

CollectionService:GetInstanceAddedSignal("NPCGrimoire"):Connect(onAdded)
CollectionService:GetInstanceRemovedSignal("NPCGrimoire"):Connect(onRemoved)

for _, val_7 in CollectionService:GetTagged("NPCGrimoire") do
    onAdded(val_7)
end

local function byDistance(arg7, arg8) -- line: 238
    return arg7.dist < arg8.dist
end

local t_10 = {}

local function updateLOD() -- line: 242
    -- upvalues:
    --  [1] t_3 (copy)
    --  [2] t_10 (copy)
    --  [3] t_4 (copy)
    --  [4] t_5 (copy)
    --  [5] byDistance (copy)
    --  [6] acquire (copy)

    local CurrentCamera = workspace.CurrentCamera
    local Book_1, Book_2, Book_3, Position, PrimaryPart_1

    if CurrentCamera then
        if next(t_3) == nil then
            return
        end

        Position = CurrentCamera.CFrame.Position
        table.clear(t_10)

        for key_9, val_8 in t_3 do
            PrimaryPart_1 = key_9.PrimaryPart
            local v24 = if not val_8.book then 120 else 135
            local v25 = PrimaryPart_1

            if v25 then
                v25 = (PrimaryPart_1.Position - Position).Magnitude
            end

            if v25 and v24 >= v25 then
                val_8.dist = v25
                table.insert(t_10, val_8)
            elseif val_8.book then
                Book_1 = val_8.book

                if Book_1 then
                    val_8.book = nil
                    local v26 = table.find(t_4, val_8)

                    if v26 then
                        t_4[v26] = t_4[#t_4]
                        t_4[#t_4] = nil
                    end

                    if Book_1.fxOn ~= false then
                        Book_1.fxOn = false

                        for _, val_9 in Book_1.emitters do
                            val_9[1].Enabled = false
                        end
                    end

                    Book_1.model.Parent = nil
                    local v27 = t_5[Book_1.name]

                    if not v27 then
                        v27 = {}
                        t_5[Book_1.name] = v27
                    end

                    table.insert(v27, Book_1)
                end
            end
        end

        if #t_10 > 10 then
            table.sort(t_10, byDistance)

            for index = 11, #t_10 do
                local v28 = t_10[index]
                Book_2 = v28.book
                local _ = #t_10

                if Book_2 then
                    v28.book = nil
                    local v30 = table.find(t_4, v28)

                    if v30 then
                        t_4[v30] = t_4[#t_4]
                        t_4[#t_4] = nil
                    end

                    if Book_2.fxOn ~= false then
                        Book_2.fxOn = false

                        for _, val_10 in Book_2.emitters do
                            val_10[1].Enabled = false
                        end
                    end

                    Book_2.model.Parent = nil
                    local v31 = t_5[Book_2.name]

                    if not v31 then
                        v31 = {}
                        t_5[Book_2.name] = v31
                    end

                    table.insert(v31, Book_2)
                end
            end
        end

        for index_1 = 1, math.min(#t_10, 10) do
            local v32 = t_10[index_1]
            local _ = math.min(#t_10, 10)

            if not v32.book then
                acquire(v32)
            end

            Book_3 = v32.book
            local v34 = v32.dist <= 70 and true

            if Book_3.fxOn ~= v34 then
                Book_3.fxOn = v34

                for _, val_11 in Book_3.emitters do
                    local v35 = v34 and val_11[2]
                    val_11[1].Enabled = v35
                end
            end
        end

        return
    else
        return
    end
end

task.spawn(function() -- line: 281
    -- upvalues:
    --  [1] updateLOD (copy)

    while true do
        updateLOD()
        task.wait(0.25)
    end
end)
local t_11 = {}
local t_12 = {}
RunService.PreRender:Connect(function(deltaTimeRender) -- line: 293
    -- upvalues:
    --  [1] t_4 (copy)
    --  [2] t_11 (copy)
    --  [3] t_12 (copy)

    local v38 = #t_4

    if v38 == 0 then
        return
    end

    local clock = os.clock()
    local v39 = 1 - math.exp(-14 * deltaTimeRender)
    local v40 = 0

    for index_4 = 1, v38 do
        local v41 = t_4[index_4]
        local PrimaryPart_2 = v41.npc.PrimaryPart

        if PrimaryPart_2 then
            local Book_4 = v41.book
            local Pose = v41.pose
            local v42 = PrimaryPart_2.CFrame
            local Position_1 = (Book_4.attach * CFrame.new(
                Pose.bob * ((1 - math.cos((clock + v41.phase) * 6.283185307179586 / 5.2)) * 0.5)
            )).Position
            local v45 = CFrame.new((v42 * Pose.offset).Position) * (if Pose.angle then (v42 * Pose.angle).Rotation else CFrame.identity) * CFrame.new(
                -Position_1
            )
            local v46 = v41.cf

            if v46 then
                v46 = v46:Lerp(v45, v39)
            else
                v46 = v45
            end

            v41.cf = v46
            v40 += 1
            t_11[v40] = Book_4.root
            t_12[v40] = v46
        end
    end

    for index_5 = v40 + 1, #t_11 do
        local _ = #t_11
        t_11[index_5] = nil
        t_12[index_5] = nil
    end

    if v40 > 0 then
        workspace:BulkMoveTo(t_11, t_12, Enum.BulkMoveMode.FireCFrameChanged)
    end
end)
