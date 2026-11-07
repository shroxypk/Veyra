-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.EldritchIntroduction
-- Class: LocalScript
-- bytes: 14467

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local _ = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local _ = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local v2, _ = require(ReplicatedStorage.Modules.scriptObjs).GetPlayerCharacter()
local Bin = v2:WaitForChild("bin")
local Quests = v2:WaitForChild("Quests")
local Inventory = v2:WaitForChild("Inventory")
local PlayerGui = v2:WaitForChild("PlayerGui")
local EldritchStoryRemote = ReplicatedStorage.Remotes:WaitForChild("EldritchStoryRemote")
local CurrentCamera = workspace.CurrentCamera
local UI = script.UI
local Cams = script.Cams
local Fade = UI.Fade
local CinematicBottom = UI.CinematicBottom
local Dialogue = UI.Dialogue
local now = nil
local v5 = nil
local v6 = nil
local RichText_m = require(script.RichText)

local function WRITE_TEXT(
    arg1,
    arg2,
    arg3,
    arg4,
    arg5
) -- line: 33
    -- upvalues:
    --  [1] now (ref)
    --  [2] v5 (ref)
    --  [3] RichText_m (copy)

    if arg4 ~= now then
        return
    end

    if arg1.Parent:IsA("Frame") then
        arg1.Parent.Visible = true
    end

    if v5 then
        v5:Hide()
    end

    v5 = RichText_m:New(arg1, arg2, arg3)
    v5:Animate(not arg5)
end

local function Transition(arg6, arg7) -- line: 46
    -- upvalues:
    --  [1] now (ref)
    --  [2] Fade (copy)
    --  [3] CurrentCamera (copy)

    if arg7 ~= now then
        return
    end

    _G.Tween(
        Fade,
        { 1, "Quad", Enum.EasingDirection.Out },
        { BackgroundTransparency = 0 },
        false,
        true
    )

    if arg6 then
        CurrentCamera.CFrame = arg6.CFrame
    end

    _G.Tween(Fade, { 0.5, "Quad", Enum.EasingDirection.Out }, { BackgroundTransparency = 1 })
end

local _ = function(arg8, arg9, arg10) --[[ CameraDisplay ]] -- line: 55
    -- upvalues:
    --  [1] now (ref)
    --  [2] v6 (ref)
    --  [3] TweenService (copy)
    --  [4] CurrentCamera (copy)

    if arg10 ~= now then
        return
    end

    v6 = TweenService:Create(CurrentCamera, arg8, arg9)
    v6:Play()

    return v6
end

local function reset() -- line: 62
    -- upvalues:
    --  [1] v6 (ref)
    --  [2] now (ref)
    --  [3] v5 (ref)
    --  [4] Fade (copy)
    --  [5] CinematicBottom (copy)
    --  [6] CurrentCamera (copy)
    --  [7] v2 (copy)
    --  [8] EldritchStoryRemote (copy)
    --  [9] Bin (copy)
    --  [10] UI (copy)

    if v6 then
        v6:Cancel()
    end

    now = tick()

    if v5 then
        v5:Hide()
    end

    _G.Tween(
        Fade,
        { 1, "Quad", Enum.EasingDirection.Out },
        { BackgroundTransparency = 0 },
        false,
        true
    )
    CinematicBottom.Visible = false
    _G.Tween(Fade, { 0.5, "Quad", Enum.EasingDirection.Out }, { BackgroundTransparency = 1 }, false)
    CurrentCamera.CameraType = "Custom"
    CurrentCamera.CameraSubject = v2.Character.Humanoid
    EldritchStoryRemote:FireServer("StopCutscene")
    Bin.Event.Value = ""
    UI.Parent = script
end

local MiasmicQuest = workspace.Map.Areas["@EldritchQuests"].MiasmicQuest
local CoreQuest = MiasmicQuest:WaitForChild("CoreQuest")
CoreQuest:SetAttribute("MapHidden", true)
CoreQuest.Parent = nil
local ChiefKasyaClient = script.ChiefKasyaClient
local EldritchStarter

while true do
    EldritchStarter = Quests:FindFirstChild("EldritchStarter")

    if EldritchStarter then
    end

    local Tasks = EldritchStarter.Tasks
    local v7 = 0
    local _ = #Tasks:GetChildren()

    for _, child in Tasks:GetChildren() do
        local _ = child.Name
        local TaskMax = child:GetAttribute("TaskMax")
        local TaskType = child:GetAttribute("TaskType")
        local attribute = child:GetAttribute("Object")
        local v10 = 0

        if TaskType == "Collect" then
            local v12 = Inventory:FindFirstChild(attribute)
            local v14 = v12 and v12:GetAttribute("Stock") or v10
            v10 = v14
        else
            v10 = child:GetAttribute("TaskProgress")
        end

        if TaskMax <= v10 then
            v7 += 1
        end
    end

    if v7 >= 1 then
        break
    end

    task.wait(0.5)
end

if not EldritchStarter:GetAttribute("Completed") then
    local v15 = script.Prompt:Clone()

    function Main() -- line: 142
        -- upvalues:
        --  [1] now (ref)
        --  [2] v15 (copy)
        --  [3] EldritchStoryRemote (copy)
        --  [4] RunService (copy)
        --  [5] UI (copy)
        --  [6] PlayerGui (copy)
        --  [7] Bin (copy)
        --  [8] CinematicBottom (copy)
        --  [9] CurrentCamera (copy)
        --  [10] Transition (copy)
        --  [11] Cams (copy)
        --  [12] v6 (ref)
        --  [13] TweenService (copy)
        --  [14] WRITE_TEXT (copy)
        --  [15] Dialogue (copy)
        --  [16] reset (copy)

        local v16 = now
        v15:Destroy()
        EldritchStoryRemote:FireServer("StartCutscene")

        if not RunService:IsStudio() then
            UI.Parent = PlayerGui
            Bin.Event.Value = "thing"
            CinematicBottom.Visible = true
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            Transition(Cams.Introduction["0"], v16)
            local New = TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local t = { CFrame = Cams.Introduction["1"].CFrame }

            if v16 == now then
                v6 = TweenService:Create(CurrentCamera, New, t)
                v6:Play()
            end

            WRITE_TEXT(
                Dialogue,
                "It's been ages since an outsider set foot in our village.<AnimateYield=0.5> I am Kasya, chief of this... what's left of this place.",
                nil,
                v16
            )
            task.wait(1)
            Transition(Cams.Introduction["2"], v16)
            local New_1 = TweenInfo.new(12, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local t_1 = { CFrame = Cams.Introduction["3"].CFrame }

            if v16 == now then
                v6 = TweenService:Create(CurrentCamera, New_1, t_1)
                v6:Play()
            end

            WRITE_TEXT(
                Dialogue,
                "You see the state of us, don't you? The miasmic fog... it's been our curse.<AnimateYield=1.25> It crept in slowly, then it spread, swallowing homes and lives. Those who stayed too long in its grasp... changed.<AnimateYield=0.5> Now, half the village is lost to it, and the fog...<AnimateYield=0.5> it doesn't stop.",
                nil,
                v16
            )
            task.wait(1)
            local v27 = nil
            Transition(Cams.Introduction["4"], v16)
            local tweenInfo = TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local t_2 = { CFrame = Cams.Introduction["5"].CFrame }

            if v16 == now then
                v6 = TweenService:Create(CurrentCamera, tweenInfo, t_2)
                v6:Play()
            end

            task.delay(3, function() -- line: 178
                -- upvalues:
                --  [1] Transition (ref)
                --  [2] Cams (ref)
                --  [3] v16 (copy)
                --  [4] CurrentCamera (ref)
                --  [5] now (ref)
                --  [6] v6 (ref)
                --  [7] TweenService (ref)
                --  [8] v27 (ref)

                Transition(Cams.Introduction["6"], v16)
                local tweenInfo_1 = TweenInfo.new(
                    2,
                    Enum.EasingStyle.Linear,
                    Enum.EasingDirection.Out
                )
                local t_3 = { CFrame = CurrentCamera.CFrame * CFrame.new(-2, 0, 0) }
                local v31

                if v16 ~= now then
                    v31 = nil
                else
                    local _ = Transition
                    v6 = TweenService:Create(CurrentCamera, tweenInfo_1, t_3)
                    v6:Play()
                    v31 = v6
                end

                v31.Completed:Connect(function() -- line: 180
                    -- upvalues:
                    --  [1] CurrentCamera (ref)
                    --  [2] Cams (ref)
                    --  [3] v16 (ref)
                    --  [4] now (ref)
                    --  [5] v6 (ref)
                    --  [6] TweenService (ref)
                    --  [7] v27 (ref)

                    task.wait(0.25)
                    CurrentCamera.CFrame = Cams.Introduction["7"].CFrame
                    local tweenInfo_2 = TweenInfo.new(
                        2,
                        Enum.EasingStyle.Linear,
                        Enum.EasingDirection.Out
                    )
                    local t_4 = { CFrame = CurrentCamera.CFrame * CFrame.new(-2, 0, 0) }
                    local v34

                    if v16 ~= now then
                        v34 = nil
                    else
                        v6 = TweenService:Create(CurrentCamera, tweenInfo_2, t_4)
                        v6:Play()
                        v34 = v6
                    end

                    v34.Completed:Connect(function() -- line: 183
                        -- upvalues:
                        --  [1] CurrentCamera (ref)
                        --  [2] Cams (ref)
                        --  [3] v16 (ref)
                        --  [4] now (ref)
                        --  [5] v6 (ref)
                        --  [6] TweenService (ref)
                        --  [7] v27 (ref)

                        task.wait(0.25)
                        CurrentCamera.CFrame = Cams.Introduction["8"].CFrame
                        local tweenInfo_3 = TweenInfo.new(
                            2,
                            Enum.EasingStyle.Linear,
                            Enum.EasingDirection.Out
                        )
                        local t_5 = { CFrame = CurrentCamera.CFrame * CFrame.new(-2, 0, 0) }
                        local v36

                        if v16 ~= now then
                            v36 = nil
                        else
                            v6 = TweenService:Create(CurrentCamera, tweenInfo_3, t_5)
                            v6:Play()
                            v36 = v6
                        end

                        v36.Completed:Connect(function() -- line: 186
                            -- upvalues:
                            --  [1] CurrentCamera (ref)
                            --  [2] Cams (ref)
                            --  [3] v27 (ref)

                            task.wait(0.25)
                            CurrentCamera.CFrame = Cams.Introduction["9"].CFrame
                            v27 = true
                        end)
                    end)
                end)
            end)
            WRITE_TEXT(
                Dialogue,
                "We've tried to fight it. Enchanted lanterns can push it back, but we've lost too many hands to keep them lit.<AnimateYield=1.25> Please... will you help us?<AnimateYield=0.5> Light the lanterns.<AnimateYield=1> Hold back the fog.<AnimateYield=0.5> Save us.",
                nil,
                v16
            )

            repeat
                task.wait()
            until v27

            task.wait(1)
        end

        reset()
    end

    local v41 = CFrame.new(6054.412, 147.902, 3742.075) * CFrame.Angles(0, 1.1758632236536197, 0)
    ChiefKasyaClient.Parent = workspace.ChatObjects
    ChiefKasyaClient:SetPrimaryPartCFrame(v41)
    v15.Triggered:Once(Main)
    v15.Parent = ChiefKasyaClient.PrimaryPart
end

local v42 = nil

while not v42 do
    v42 = Quests:FindFirstChild("MiasmicQuest")
    task.wait(0.1)
end

local Crystal = MiasmicQuest:WaitForChild("Crystal")
local Tasks_1 = v42.Tasks
v42 = 0
local _ = #Tasks_1:GetChildren()
local v47

for _, child_1 in Tasks_1:GetChildren() do
    local TaskMax_1 = child_1:GetAttribute("TaskMax")
    local TaskType_1 = child_1:GetAttribute("TaskType")
    local Object = child_1:GetAttribute("Object")
    local TaskProgress = child_1:GetAttribute("TaskProgress")

    if TaskType_1 == "Collect" then
        local v45 = v2.Inventory:FindFirstChild(Object)
        local v46 = v45 and v45:GetAttribute("Stock") or 0
        v47 = v46
    else
        v47 = TaskProgress
    end

    if if not (TaskMax_1 <= v47) then false else true then
        v42 += 1
    end
end

local function controlParent(_) -- line: 248
    -- upvalues:
    --  [1] Quests (copy)
    --  [2] CoreQuest (copy)
    --  [3] MiasmicQuest (copy)
    --  [4] ChiefKasyaClient (copy)

    if Quests:FindFirstChild("CoreQuest") then
        CoreQuest:SetAttribute("MapHidden", true)
        CoreQuest.Parent = nil

        return
    end

    CoreQuest:SetAttribute("MapHidden", false)
    CoreQuest.Parent = MiasmicQuest
    ChiefKasyaClient.Parent = nil
end

EldritchStoryRemote.OnClientEvent:Connect(function(arguments) -- line: 290
    -- upvalues:
    --  [1] Crystal (copy)
    --  [2] Quests (copy)
    --  [3] CoreQuest (copy)
    --  [4] MiasmicQuest (copy)
    --  [5] ChiefKasyaClient (copy)

    if arguments == "Finished" then
        for _, descendant in Crystal:GetDescendants() do
            if descendant:IsA("BasePart") then
                _G.Tween(descendant, { 1, "Quad", Enum.EasingDirection.Out }, { Transparency = 1 })
                descendant.CanCollide = false
                descendant.CanQuery = false
                descendant.CanTouch = false
            elseif descendant:IsA("Light") then
                _G.Tween(
                    descendant,
                    { 1, "Quad", Enum.EasingDirection.Out },
                    { Range = 0, Brightness = 0 }
                )
            end
        end

        if Quests:FindFirstChild("CoreQuest") then
            CoreQuest:SetAttribute("MapHidden", true)
            CoreQuest.Parent = nil

            return
        end

        CoreQuest:SetAttribute("MapHidden", false)
        CoreQuest.Parent = MiasmicQuest
        ChiefKasyaClient.Parent = nil
    end
end)

if Quests:FindFirstChild("CoreQuest") then
    CoreQuest:SetAttribute("MapHidden", true)
    CoreQuest.Parent = nil
else
    CoreQuest:SetAttribute("MapHidden", false)
    CoreQuest.Parent = MiasmicQuest
    ChiefKasyaClient.Parent = nil
end

Quests.ChildAdded:Connect(controlParent)
