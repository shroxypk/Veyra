-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.mod.retime
-- Class: ModuleScript
-- bytes: 6364

local Utility_m = require("./utility")
local t = {
    apply = function(u1: userdata, n1: number, n2: number) --[[ apply ]] -- line: 5
        -- upvalues:
        --  [1] Utility_m (copy)

        if u1:IsA("ParticleEmitter") then
            Utility_m.scaleAttribute(u1, n2, "EmitDelay")
            Utility_m.scaleAttribute(u1, n2, "EmitDuration")
            Utility_m.scaleAttribute(u1, n2, "TimeScale_Duration")
            u1.Speed = NumberRange.new(u1.Speed.Min * n1, u1.Speed.Max * n1)
            u1.RotSpeed = NumberRange.new(u1.RotSpeed.Min * n1, u1.RotSpeed.Max * n1)
            u1.Lifetime = NumberRange.new(u1.Lifetime.Min / n1, u1.Lifetime.Max / n1)
            u1.Acceleration *= n1 ^ 2
            u1.Drag *= n1
            u1.Rate *= n1

            return
        end

        if u1:IsA("Beam") then
            Utility_m.scaleAttribute(u1, n2, "EmitDelay")
            Utility_m.scaleAttribute(u1, n2, "EmitDuration")
            Utility_m.scaleAttribute(u1, n2, "EffectDuration")
            Utility_m.scaleAttribute(u1, n2, "Speed_Duration")
            Utility_m.scaleAttribute(u1, n2, "Duration")
            u1.TextureSpeed *= n1

            return
        end

        if u1:IsA("Trail") then
            u1.Lifetime *= n2

            return
        end

        if u1:IsA("Sound") then
            Utility_m.scaleAttribute(u1, n2, "EmitDelay")
            Utility_m.scaleAttribute(u1, n2, "EmitDuration")
            Utility_m.scaleAttribute(u1, n2, "EmitInterval")
            Utility_m.scaleAttribute(u1, n2, "RepeatInterval")
            Utility_m.scaleAttribute(u1, n2, "FadeOutTime")
            Utility_m.scaleAttribute(u1, n2, "Volume_Duration")
            Utility_m.scaleAttribute(u1, n2, "Speed_Duration")
            Utility_m.scaleAttribute(u1, n2, "RollOff_Duration")

            return
        end

        if u1:IsA("Model") then
            if Utility_m.isMeshVFX(u1) then
                Utility_m.scaleAttribute(u1, n2, "EmitDelay")
                Utility_m.scaleAttribute(u1, n2, "DestroyDelay")
                Utility_m.scaleAttribute(u1, n2, "EmitDuration")
                Utility_m.scaleAttribute(u1, n2, "EffectDuration")
                Utility_m.scaleAttribute(u1, n2, "Speed_Duration")
                Utility_m.scaleAttribute(u1, n2, "Duration")
                Utility_m.scaleAttribute(u1, n1, "Rate")
                Utility_m.scaleAttribute(u1, n1, "Part_RotSpeed_Start")
                Utility_m.scaleAttribute(u1, n1, "Part_RotSpeed_End")

                return
            end

            Utility_m.scaleAttribute(u1, n1, "SpinRotation")
            Utility_m.scaleAttribute(u1, n2, "EmitDelay")
            Utility_m.scaleAttribute(u1, n2, "ResetDelay")
            Utility_m.scaleAttribute(u1, n2, "SpinDuration")
            Utility_m.scaleAttribute(u1, n2, "Scale_Duration")
            Utility_m.scaleAttribute(u1, n2, "SpinSpeed_Duration")

            return
        else
            if u1:IsA("Attachment") and u1:HasTag(Utility_m.BEZIER_TAG) then
                Utility_m.scaleAttribute(u1, n2, "EmitDelay")
                Utility_m.scaleAttribute(u1, n2, "DestroyDelay")
                Utility_m.scaleAttribute(u1, n2, "EmitDuration")
                Utility_m.scaleAttribute(u1, n2, "Duration")
                Utility_m.scaleAttribute(u1, n2, "Speed_Duration")
                Utility_m.scaleAttribute(u1, n1, "ProjectileSpeed")
                Utility_m.scaleAttribute(u1, n2, "ProjectileLifetime")
                Utility_m.scaleAttribute(u1, n1, "Rate")
                Utility_m.scaleAttribute(u1, n1, "Part_RotSpeed_Start")
                Utility_m.scaleAttribute(u1, n1, "Part_RotSpeed_End")

                return
            end

            if u1:IsA("Attachment") and u1:HasTag(Utility_m.LIGHTNING_TAG) then
                Utility_m.scaleAttribute(u1, n2, "EmitDelay")
                Utility_m.scaleAttribute(u1, n2, "DestroyDelay")
                Utility_m.scaleAttribute(u1, n2, "EmitDuration")
                Utility_m.scaleAttribute(u1, n2, "Duration")
                Utility_m.scaleAttribute(u1, n2, "Speed_Duration")
                Utility_m.scaleAttribute(u1, n2, "Color_Duration")
                Utility_m.scaleAttribute(u1, n2, "Fill_Color_Duration")
                Utility_m.scaleAttribute(u1, n2, "Fade_In_Duration")
                Utility_m.scaleAttribute(u1, n2, "Fade_Out_Duration")
                Utility_m.scaleAttribute(u1, n2, "Dissipate_Duration")
                Utility_m.scaleAttribute(u1, n1, "ProjectileSpeed")
                Utility_m.scaleAttribute(u1, n2, "ProjectileLifetime")
                Utility_m.scaleAttribute(u1, n1, "Rate")
                Utility_m.scaleAttribute(u1, n1, "RefreshRate")

                return
            end

            if u1:IsA("BasePart") and u1.Parent and Utility_m.findFirstClassWithTag(
                u1.Parent,
                "Attachment",
                Utility_m.SHOCKWAVE_TAG
            ) then
                Utility_m.scaleAttribute(u1, n2, "EmitDelay")
                Utility_m.scaleAttribute(u1, n2, "Size_Duration")
                Utility_m.scaleAttribute(u1, n2, "Transparency_Duration")
                Utility_m.scaleAttribute(u1, n2, "Lifetime")
                Utility_m.scaleAttribute(u1, n2, "Duration")
                Utility_m.scaleAttribute(u1, n1, "Rate_Start")
                Utility_m.scaleAttribute(u1, n1, "Rate_End")

                return
            end

            if u1:IsA("RayValue") and u1:HasTag(Utility_m.SCREENSHAKE_TAG) then
                Utility_m.scaleAttribute(u1, n2, "EmitDelay")
                Utility_m.scaleAttribute(u1, n2, "EmitDuration")
                Utility_m.scaleAttribute(u1, n2, "Scale_Duration")

                return
            end

            if u1:IsA("RayValue") then
                Utility_m.scaleAttribute(u1, n2, "Duration")
                Utility_m.scaleAttribute(u1, n2, "Speed_Duration")
                Utility_m.scaleAttribute(u1, n2, "EmitDelay")
            end

            return
        end
    end
}

function t.batch(n3: number, ...) -- line: 112
    -- upvalues:
    --  [1] t (copy)

    local v1 = 1 / n3

    for _, val in { ... } do
        t.apply(val, n3, v1)

        for _, descendant in val:GetDescendants() do
            t.apply(descendant, n3, v1)
        end
    end
end

return t
