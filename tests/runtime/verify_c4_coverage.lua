-- F4: C4 coverage metric verification.
-- Run with the Luau CLI from the repository root.

local GRACE_LOCK=0.75

local function coveredFor(group, impactAt, mode, now, rollDur)
  local gap=(mode=="parry") and (GRACE_LOCK+0.03) or (rollDur+0.03)
  local count=1
  for k=2,#group do
    local nextImpact=now+group[k].remaining
    if nextImpact>=impactAt+gap then count=count+1 end
  end
  return count
end

local function assignDecision(group, now, canDash, rollDur)
  local impactAt=now+group[1].remaining
  if #group==1 then return "parry" end
  if canDash and coveredFor(group, impactAt, "roll", now, rollDur) > coveredFor(group, impactAt, "parry", now, rollDur) then
    return "roll-then-parry"
  else
    return "parry-then-drop"
  end
end

-- Two hits 0.4s apart (hit1 at 0.2s, hit2 at 0.6s), now=0
local group={{remaining=0.2},{remaining=0.6}}

-- With ROLL_DURATION=0.3 (learned value < 0.4):
-- - parry: gap=0.78, actual 0.4 -> covers 1
-- - roll: gap=0.33, actual 0.4 -> covers 2
-- Roll wins when CanDash is available
local result=assignDecision(group, 0, true, 0.3)
assert(result=="roll-then-parry", "expected roll-then-parry, got "..result)

-- With CanDash false: always parry
result=assignDecision(group, 0, false, 0.3)
assert(result=="parry-then-drop", "expected parry-then-drop with CanDash false, got "..result)

-- With ROLL_DURATION=0.45 (default): both cover 1, tie goes to parry
result=assignDecision(group, 0, true, 0.45)
assert(result=="parry-then-drop", "expected parry-then-drop on tie, got "..result)

print("PASS: C4 coverage - roll-first wins only when it covers more (CanDash available); tie goes to parry")
