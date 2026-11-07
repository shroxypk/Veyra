-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.FadeSound
-- Class: ModuleScript
-- bytes: 464

local TweenService = game:GetService("TweenService")

local function fadeSound(arg1) -- line: 3
    -- upvalues:
    --  [1] TweenService (copy)

    local v1 = TweenService:Create(
        arg1,
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { Volume = 0 }
    )
    v1.Completed:Once(function() -- line: 6
        -- upvalues:
        --  [1] arg1 (copy)

        arg1:Destroy()
    end)
    v1:Play()
end

return fadeSound
