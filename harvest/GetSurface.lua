-- Decompiled with Veyra harvester
-- Instance: ReplicatedFirst.Services.Cast.Functions.GetSurface
-- Class: ModuleScript
-- bytes: 581

return function(arg1, arg2) -- line: 1
    local t = {}
    t.Back = arg2.CFrame * CFrame.new(0, 0, arg2.Size.Z)
    t.Front = arg2.CFrame * CFrame.new(0, 0, -arg2.Size.Z)
    t.Top = arg2.CFrame * CFrame.new(0, arg2.Size.Y, 0)
    t.Bottom = arg2.CFrame * CFrame.new(0, -arg2.Size.Y, 0)
    t.Right = arg2.CFrame * CFrame.new(arg2.Size.X, 0, 0)
    t.Left = arg2.CFrame * CFrame.new(-arg2.Size.X, 0, 0)
    local v7 = "Back"

    for key, val in pairs(t) do
        v7 = (arg1 - val.Position).Magnitude > (arg1 - t[v7].Position).Magnitude and v7 or key
    end

    return v7
end
