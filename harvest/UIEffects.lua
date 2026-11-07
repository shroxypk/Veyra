-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.UI.UIEffects
-- Class: ModuleScript
-- bytes: 9522

local _ = require(game:GetService("ReplicatedFirst").Services)
local _ = game:GetService("Players")
local _ = game:GetService("ReplicatedStorage")
local _ = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local t = {
    FadeIn = function(u2: userdata, b1: boolean?, b2: boolean?, u3: userdata?) --[[ FadeIn ]] -- line: 23
        -- upvalues:
        --  [1] TweenService (copy)
        --  [2] tweenInfo (copy)

        local function process(arg3) -- line: 25
            -- upvalues:
            --  [1] u2 (copy)
            --  [2] b1 (copy)
            --  [3] u3 (copy)
            --  [4] TweenService (ref)
            --  [5] tweenInfo (ref)

            local v4 = nil

            if arg3:IsA("TextLabel") then
                v4 = { TextTransparency = 0, TextStrokeTransparency = 0.7 }
            elseif arg3:IsA("ImageLabel") then
                v4 = { ImageTransparency = u2:GetAttribute("fadeIn") or 0.2 }
            elseif arg3:IsA("Frame") then
                v4 = { BackgroundTransparency = u2:GetAttribute("fadeIn") or 0.5 }
            else
                local t_3

                if not arg3:IsA("UIStroke") then
                    if arg3:IsA("UIShadow") then
                        t_3 = { Transparency = u2:GetAttribute("fadeIn") or 0 }
                        v4 = t_3
                    end
                else
                    t_3 = { Transparency = u2:GetAttribute("fadeIn") or 0 }
                    v4 = t_3
                end
            end

            if v4 then
                if b1 then
                    for key, val in v4 do
                        arg3[key] = val
                    end

                    return
                end

                TweenService:Create(arg3, u3 or tweenInfo, v4):Play()
            end
        end

        for _, val_1 in u2:QueryDescendants(":not([$Ignore])") do
            if not val_1:GetAttribute("Ignore") then
                process(val_1)
            end
        end

        if b2 then
            process(u2)
        end
    end
}

local _ = function(arg1: any, arg2: any, u1: userdata?) --[[ tween ]] -- line: 16
    -- upvalues:
    --  [1] TweenService (copy)
    --  [2] tweenInfo (copy)

    local v3 = TweenService:Create(arg1, u1 or tweenInfo, arg2)
    v3:Play()

    return v3
end

function t.FadeOut(u4: userdata, b3: boolean?, b4: boolean?, u5: userdata?) -- line: 62
    -- upvalues:
    --  [1] t (copy)
    --  [2] TweenService (copy)
    --  [3] tweenInfo (copy)

    local function process_1(arg4) --[[ process ]] -- line: 64
        -- upvalues:
        --  [1] b3 (copy)
        --  [2] t (ref)
        --  [3] u5 (copy)
        --  [4] TweenService (ref)
        --  [5] tweenInfo (ref)

        local t_4 = nil

        if arg4:IsA("TextLabel") then
            t_4 = { TextTransparency = 1, TextStrokeTransparency = 1 }

            if not b3 then
                t.Vanish(arg4)
            end
        elseif arg4:IsA("ImageLabel") then
            t_4 = { ImageTransparency = 1 }
        elseif arg4:IsA("Frame") then
            t_4 = { BackgroundTransparency = 1 }
        elseif not arg4:IsA("UIStroke") then
            if arg4:IsA("UIShadow") then
                t_4 = { Transparency = 1 }
            end
        else
            t_4 = { Transparency = 1 }
        end

        if t_4 then
            if b3 then
                for key_2, val_2 in t_4 do
                    arg4[key_2] = val_2
                end

                return
            end

            TweenService:Create(arg4, u5 or tweenInfo, t_4):Play()
        end
    end

    for _, descendant in u4:GetDescendants() do
        process_1(descendant)
    end

    if b4 then
        process_1(u4)
    end
end

function t.Typewrite(u6: userdata, s1: string) -- line: 100
    local t_5 = {}
    local v8 = 1

    while true do
        if not (v8 <= #s1) then
            break
        end

        if s1:sub(v8, v8) == "<" then
            local v9 = s1:find(">", v8, true)

            if v9 then
                table.insert(t_5, { char = s1:sub(v8, v9), spinnable = false })
                v8 = v9 + 1
                continue
            end

            table.insert(t_5, { char = s1:sub(v8, v8), spinnable = false })
            v8 += 1
            continue
        else
            local v10 = s1:sub(v8, v8)
            local t_8 = { char = v10, spinnable = if v10 == " " then false else true }
            table.insert(t_5, t_8)
            v8 += 1
        end
    end

    v8 = {}
    local t_9 = {}
    local _

    for key_4, val_3 in t_5 do
        t_9[key_4] = not val_3.spinnable
        v8[key_4] = val_3.spinnable and ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!?@#"):sub(
            math.random(1, 66),
            math.random(1, 66)
        ) or val_3.char
    end

    local _ = function() --[[ render ]] -- line: 140
        -- upvalues:
        --  [1] u6 (copy)
        --  [2] v8 (copy)

        u6.Text = table.concat(v8)
    end

    u6.Text = table.concat(v8)
    local t_10 = {}

    for key_5, val_4 in t_5 do
        if val_4.spinnable then
            table.insert(t_10, key_5)
        end
    end

    local t_11 = {}
    local v15 = 1

    while true do
        if not (v15 <= #t_10) then
            break
        end

        local t_12 = {}

        if not (v15 > #t_10) then
            table.insert(t_12, t_10[v15])
            v15 += 1

            if not (v15 > #t_10) then
                table.insert(t_12, t_10[v15])
                v15 += 1

                if not (v15 > #t_10) then
                    table.insert(t_12, t_10[v15])
                    v15 += 1
                end
            end
        end

        table.insert(t_11, t_12)
    end

    for key_6, val_5 in t_11 do
        task.delay((key_6 - 1) * 0.034999999999999996 + 0.075, function() -- line: 168
            -- upvalues:
            --  [1] val_5 (copy)
            --  [2] t_9 (copy)
            --  [3] v8 (copy)
            --  [4] t_5 (copy)

            for _, val_6 in val_5 do
                t_9[val_6] = true
                v8[val_6] = t_5[val_6].char
            end
        end)
    end

    local v16 = (#t_11 - 1) * 0.034999999999999996 + 0.075
    local v17 = tick() + v16
    task.spawn(function() -- line: 180
        -- upvalues:
        --  [1] v17 (copy)
        --  [2] t_5 (copy)
        --  [3] t_9 (copy)
        --  [4] v8 (copy)
        --  [5] u6 (copy)

        while true do
            if not (tick() < v17) then
                break
            end

            for key_8, val_7 in t_5 do
                if not t_9[key_8] and val_7.spinnable then
                    local v18 = math.random(1, 66)
                    v8[key_8] = ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!?@#"):sub(
                        v18,
                        v18
                    )
                end
            end

            u6.Text = table.concat(v8)
            task.wait(0.022222222222222223)
        end

        for key_9, val_8 in t_5 do
            v8[key_9] = val_8.char
        end

        u6.Text = table.concat(v8)
    end)
end

function t.ScrambleOut(u7: userdata, n1: number?, n2: number?) -- line: 199
    local v22 = n1 or 0.06
    local v23 = n2 or 0.2
    local Text = u7.Text
    local t_13 = {}

    for index = 1, #Text do
        t_13[index] = Text:sub(index, index)
    end

    local t_14 = {}
    task.spawn(function() -- line: 211
        -- upvalues:
        --  [1] t_13 (copy)
        --  [2] v22 (copy)
        --  [3] v23 (copy)
        --  [4] u7 (copy)
        --  [5] t_14 (copy)

        for index_1 = 1, #t_13 do
            local _ = #t_13
            task.delay((index_1 - 1) * v22, function() -- line: 213
                -- upvalues:
                --  [1] v23 (ref)
                --  [2] t_13 (ref)
                --  [3] index_1 (copy)
                --  [4] u7 (ref)
                --  [5] t_14 (ref)

                local v24 = tick() + v23

                while true do
                    if not (v24 > tick()) then
                        break
                    end

                    if t_13[index_1] ~= " " then
                        t_13[index_1] = ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!?@#"):sub(
                            math.random(1, 66),
                            math.random(1, 66)
                        )
                        u7.Text = table.concat(t_13)
                    end

                    task.wait(0.022222222222222223)
                end

                t_14[index_1] = true
                local t_15 = {}

                for index_2 = 1, #t_13 do
                    local _ = #t_13

                    if not t_14[index_2] then
                        table.insert(t_15, t_13[index_2])
                    end
                end

                u7.Text = table.concat(t_15)
            end)
        end
    end)
end

function t.Vanish(u8: userdata, n3: number?) -- line: 234
    local Text_1 = u8.Text
    local v32 = n3 or 0.01
    task.spawn(function() -- line: 238
        -- upvalues:
        --  [1] Text_1 (copy)
        --  [2] u8 (copy)
        --  [3] v32 (copy)

        for index_3 = 1, #Text_1 do
            local v33 = index_3 + 1
            local _ = #Text_1
            u8.Text = Text_1:sub(v33)
            task.wait(v32)
        end
    end)
end

return t
