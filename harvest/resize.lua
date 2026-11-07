-- Decompiled with Veyra harvester
-- Instance: ReplicatedStorage.Modules.Packages.ForgeVFX.mod.resize
-- Class: ModuleScript
-- bytes: 4624

local Utility_m = require("./utility")
local t = {
    apply = function(u1: userdata, n1: number) --[[ apply ]] -- line: 5
        -- upvalues:
        --  [1] Utility_m (copy)

        if u1:IsA("ParticleEmitter") then
            u1.Size = Utility_m.scaleNumberSequence(u1.Size, n1)
            u1.Speed = NumberRange.new(u1.Speed.Min * n1, u1.Speed.Max * n1)
            u1.Acceleration *= n1

            return
        end

        if u1:IsA("Beam") then
            Utility_m.scaleAttribute(u1, n1, "Width0_Start")
            Utility_m.scaleAttribute(u1, n1, "Width1_Start")
            Utility_m.scaleAttribute(u1, n1, "Width0_End")
            Utility_m.scaleAttribute(u1, n1, "Width1_End")
            Utility_m.scaleAttribute(u1, n1, "CurveSize0_Start")
            Utility_m.scaleAttribute(u1, n1, "CurveSize1_Start")
            Utility_m.scaleAttribute(u1, n1, "CurveSize0_End")
            Utility_m.scaleAttribute(u1, n1, "CurveSize1_End")
            Utility_m.scaleAttribute(u1, n1, "Length_Scale_Start")
            Utility_m.scaleAttribute(u1, n1, "Length_Scale_End")
            u1.Width0 *= n1
            u1.Width1 *= n1
            u1.CurveSize0 *= n1
            u1.CurveSize1 *= n1
            Utility_m.scaleAttachmentDistance(u1.Attachment0, u1.Attachment1, n1)

            return
        end

        if u1:IsA("Trail") then
            Utility_m.scaleAttachmentDistance(u1.Attachment0, u1.Attachment1, n1)

            return
        end

        if u1:IsA("Sound") then
            u1.RollOffMinDistance *= n1
            u1.RollOffMaxDistance *= n1
            Utility_m.scaleAttribute(u1, n1, "RollOff_Start")
            Utility_m.scaleAttribute(u1, n1, "RollOff_End")

            return
        end

        if u1:IsA("Model") then
            if Utility_m.isMeshVFX(u1) then
                local Start = u1:FindFirstChild("Start")
                local End = u1:FindFirstChild("End")

                if Start and End then
                    Start.Size *= n1
                    End.Size *= n1
                    local SpecialMesh = Start:FindFirstChildOfClass("SpecialMesh")
                    local SpecialMesh_1 = End:FindFirstChildOfClass("SpecialMesh")

                    if SpecialMesh and SpecialMesh_1 then
                        SpecialMesh.Scale *= n1
                        SpecialMesh_1.Scale *= n1

                        return
                    end
                end
            else
                Utility_m.scaleAttribute(u1, n1, "Scale_Start")
                Utility_m.scaleAttribute(u1, n1, "Scale_End")

                return
            end
        else
            if u1:IsA("Attachment") and u1:HasTag(Utility_m.LIGHTNING_TAG) then
                Utility_m.scaleAttribute(u1, n1, "OffsetScale")
                Utility_m.scaleAttribute(u1, n1, "Width_Start")
                Utility_m.scaleAttribute(u1, n1, "Width_End")

                return
            end

            if u1:IsA("BasePart") then
                if u1.Parent then
                    if Utility_m.findFirstClassWithTag(
                        u1.Parent,
                        "Attachment",
                        Utility_m.SHOCKWAVE_TAG
                    ) then
                        Utility_m.scaleAttribute(u1, n1, "Radius")
                        Utility_m.scaleAttribute(u1, n1, "Length")
                        Utility_m.scaleAttribute(u1, n1, "MinSize")
                        Utility_m.scaleAttribute(u1, n1, "MaxSize")

                        if u1:GetAttribute("LinearMagnitude") then
                            u1.Size *= n1
                            Utility_m.scaleAttribute(u1, n1, "LinearMagnitude")
                            Utility_m.scaleAttribute(u1, n1, "AngularMagnitude")

                            return
                        end
                    elseif u1:IsA("RayValue") and u1:HasTag(Utility_m.SCREENSHAKE_TAG) then
                        Utility_m.scaleAttribute(u1, n1, "Falloff")
                    end
                elseif u1:IsA("RayValue") and u1:HasTag(Utility_m.SCREENSHAKE_TAG) then
                    Utility_m.scaleAttribute(u1, n1, "Falloff")
                end
            elseif u1:IsA("RayValue") and u1:HasTag(Utility_m.SCREENSHAKE_TAG) then
                Utility_m.scaleAttribute(u1, n1, "Falloff")
            end
        end
    end
}

function t.batch(n2: number, ...) -- line: 85
    -- upvalues:
    --  [1] t (copy)

    for _, val in { ... } do
        t.apply(val, n2)

        for _, descendant in val:GetDescendants() do
            t.apply(descendant, n2)
        end
    end
end

return t
