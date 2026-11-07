-- Decompiled with Veyra harvester
-- Instance: StarterPlayer.StarterPlayerScripts.Day / Night Cycle
-- Class: LocalScript
-- bytes: 942

local Lighting = game:GetService("Lighting")
local v1 = 15
game:GetService("RunService").Heartbeat:Connect(function(deltaTime) -- line: 27
    -- upvalues:
    --  [1] v1 (ref)
    --  [2] Lighting (copy)

    v1 += deltaTime

    if v1 < 15 then
        return
    end

    local v2 = Lighting:GetAttribute("ClockRunning")

    if v2 then
        v2 = not Lighting:GetAttribute("ClockDisabled")
    end

    if not v2 then
        return
    end

    v1 = 0
    v2 = (workspace:GetServerTimeNow() / 60 + 10) % 24
    Lighting.ClockTime = v2
    local v3 = Lighting:GetAttribute("HeldBrightness") or math.cos(
        v2 * 0.2617993877991494 + 3.141592653589793
    ) * 1 + 0.25

    if math.abs(Lighting.Brightness - v3) > 0.002 then
        Lighting.Brightness = v3
    end

    v3 = math.cos(v2 * 0.5235987755982988) * 0.2 + 0.8

    if math.abs(Lighting.ShadowSoftness - v3) > 0.002 then
        Lighting.ShadowSoftness = v3
    end
end)
