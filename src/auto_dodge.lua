-- Auto Dodge: rolls for attacks Auto Parry cannot handle.
--
-- Everything here is verified against the recovered client sources:
--   * the client requests a roll with
--     `Packets.Combat.packets.RollInput.send({Action="Roll", typeOf=...})`
--     where typeOf is "" or a *special* dash ("Surge", "AirDash",
--     "Lightning Dash"); there is no "Backstep" value, so plain rolls send "";
--   * the server answers on the same packet with Action "success" or
--     "rejected", so a send is not proof of a roll;
--   * `StateManager:CanDash()` is the authoritative gate (alive, no
--     DashCooldown, not Parried/Occupied/Stunned/ParriedAttack/Attacking,
--     not flying, incapacitated, using a skill, dodging or parrying).
--
-- Division of labour with Auto Parry:
--   * parry owns every attack it has a profile for, and it publishes the
--     soonest impact (`impactIn`), why it cannot press (`blockedReason`) and how
--     long its cooldown still runs (`cooldownWait`);
--   * dodge only rolls when parry provably cannot cover the hit: the cooldown
--     outlives the impact, or parry has no profile for the animation at all;
--   * dodge never rolls while a parry session is open, because a roll cancels
--     the parry it was waiting for.
local G=getgenv()
if G.VeyraDodge then G.VeyraDodge.stop() end
local Players=game:GetService("Players")
local RS=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local storage=game:GetService("ReplicatedStorage")
local player=Players.LocalPlayer

local state={enabled=false,alive=true,status="Dodge off",
 attempts=0,confirmed=0,rejected=0,log={},animators={}}
G.VeyraDodge=state

local worker,packet,responseConn,manager,character
local conns={}
local lastSent=-math.huge
local backoffUntil=0
local SEND_GAP=0.55   -- stay clear of DashCooldown; CanDash() is the real gate
local ROLL_LEAD=0.42  -- roll this long before an impact parry cannot cover
local REACH=15        -- only react to attackers this close
local MAX_RISE=8      -- ignore attackers this far above/below
local SCAN_RATE=0.07

-- Non-attack clips. Anything matching these is never a threat, so an NPC's
-- reaction or locomotion animation can never trigger a roll.
local NON_ATTACK={"idle","walk","run","sprint","jump","fall","land","sit","emote",
 "dance","salute","laugh","meditate","sleep","spawn","death","dead","downed",
 "stagger","flinch","hit","parry","block","dodge","roll","equip","sheathe",
 "draw","carry","victim","grabbed","stunned","vault","climb","swim","sing",
 "spellcast","channel","idle2","turn"}

local function log(msg)
 if #state.log>=120 then table.remove(state.log,1) end
 table.insert(state.log,string.format("%.3f %s",os.clock(),msg))
end

local function attackLike(track)
 if track.Looped or track.Length<0.25 then return nil end
 local anim=track.Animation
 if not anim then return nil end
 local lower=string.lower(anim.Name or "")
 if lower=="" or lower=="animation" then
  -- Unnamed clips are treated as attacks only when they are short and played
  -- once; that still excludes looping locomotion.
  return anim.AnimationId:match("%d+"),anim.Name or "?"
 end
 for _,word in ipairs(NON_ATTACK) do
  if string.find(lower,word,1,true) then return nil end
 end
 return anim.AnimationId:match("%d+"),anim.Name
end

-- Soonest impact, in seconds, from an attack Auto Parry has no profile for.
-- A negative result means the clip already ran past its authored length.
local function unprofiledImpact(parry)
 local c=player.Character
 local root=c and c:FindFirstChild("HumanoidRootPart")
 if not root then return nil end
 local best
 for animator in pairs(state.animators) do
  local h=animator.Parent
  local model=h and h.Parent
  local other=model and model:FindFirstChild("HumanoidRootPart")
  if h and h:IsA("Humanoid") and h.Health>0 and model~=c and other
   and not Players:GetPlayerFromCharacter(model)
   and math.abs(other.Position.Y-root.Position.Y)<=MAX_RISE
   and (other.Position-root.Position).Magnitude<=REACH then
   for _,track in ipairs(animator:GetPlayingAnimationTracks()) do
    local id=attackLike(track)
    if id and not (parry and parry.enabled and parry.knows and parry.knows(id)) then
     local speed=track.Speed>0.01 and track.Speed or 1
     local remaining=(track.Length-track.TimePosition)/speed
     if remaining>=-0.1 and (not best or remaining<best) then best=remaining end
    end
   end
  end
 end
 return best
end

local function canRoll()
 if not character or not manager then return false end
 local ok,dash=pcall(function() return manager:CanDash() end)
 if not ok or not dash then return false end
 local hum=character:FindFirstChildOfClass("Humanoid")
 if not hum or hum.Health<=0 then return false end
 -- Damage is discarded inside a safezone; a roll there only burns the cooldown.
 if hum:GetAttribute("InSafezone")==true then return false end
 if UIS:GetFocusedTextBox() then return false end
 local now=os.clock()
 if now<backoffUntil or now-lastSent<SEND_GAP then return false end
 return true
end

local function sendRoll()
 state.attempts+=1
 local ok,err=pcall(function() packet.send({Action="Roll",typeOf=""}) end)
 if not ok then
  log("roll send failed: "..tostring(err))
  backoffUntil=os.clock()+0.5
  return false
 end
 lastSent=os.clock()
 return true
end

local nextScan=0
local function scan()
 local keep={}
 for animator in pairs(state.animators) do
  local h=animator.Parent
  local model=h and h.Parent
  local other=model and model:FindFirstChild("HumanoidRootPart")
  local c=player.Character
  local root=c and c:FindFirstChild("HumanoidRootPart")
  if h and h:IsA("Humanoid") and h.Health>0 and other and root and model~=c
   and not Players:GetPlayerFromCharacter(model)
   and (other.Position-root.Position).Magnitude<=REACH+15 then
   keep[animator]=true
  end
 end
 for animator in pairs(state.animators) do
  if not keep[animator] then state.animators[animator]=nil end
 end
end

local function bindCharacter(c)
 character=c
 if c then
  local ok,result=pcall(function() return require(storage.Modules.StateManager).require(c) end)
  manager=ok and result or nil
 else
  manager=nil
 end
end

local function step()
 local now=os.clock()
 if player.Character~=character then bindCharacter(player.Character) end
 if now>=nextScan then nextScan=now+SCAN_RATE scan() end
 if not character or not manager then return end

 local parry=G.VeyraParry
 local reason
 -- A parry session is already in flight: rolling now would cancel it.
 if parry and parry.enabled and parry.pressing then return end

 if parry and parry.enabled then
  local impact=parry.impactIn
  if impact and impact<=ROLL_LEAD and impact>=-0.05 then
   if parry.blockedReason=="ParryCooldown" then
    local wait=parry.cooldownWait or math.huge
    -- The server publishes the real expiry; parry aims its press at it. Only
    -- roll when that press would still land after the hit.
    if wait>=impact then reason=string.format("cooldown %.2fs > impact %.2fs",wait,impact) end
   end
  end
 end
 if not reason then
  local unprofiled=unprofiledImpact(parry)
  if unprofiled and unprofiled<=ROLL_LEAD then
   reason=string.format("unprofiled impact %.2fs",unprofiled)
  end
 end

 if not reason then
  if state.status:find("^Dodge ·") then
   state.status=string.format("Dodge · %d rolls · %d confirmed · %d rejected",
    state.attempts,state.confirmed,state.rejected)
  end
  return
 end
 if not canRoll() then return end
 if sendRoll() then
  state.status=string.format("Dodge · %d rolls · %d confirmed · %d rejected",
   state.attempts,state.confirmed,state.rejected)
  log("roll: "..reason)
 end
end

local function watch(item)
 if item:IsA("Animator") then state.animators[item]=true end
end

function state.setEnabled(on)
 if not state.alive then return false end
 on=on==true
 if on==state.enabled then return on end
 if not on then
  state.enabled=false
  if worker then worker:Disconnect() worker=nil end
  if responseConn then responseConn() responseConn=nil end
  for _,conn in ipairs(conns) do conn:Disconnect() end
  table.clear(conns)
  table.clear(state.animators)
  state.status="Dodge off"
  return false
 end
 local ok,result=pcall(function() return require(storage.Modules.Packets).Combat.packets.RollInput end)
 if not ok or not result or type(result.send)~="function" then
  state.status="Dodge: input unavailable"
  log(tostring(result))
  return false
 end
 packet=result
 table.clear(state.animators)
 state.enabled=true
 -- Seed from what is already streamed in, then follow new arrivals.
 for _,item in ipairs(workspace:GetDescendants()) do watch(item) end
 conns[#conns+1]=workspace.DescendantAdded:Connect(watch)
 conns[#conns+1]=workspace.DescendantRemoving:Connect(function(item)
  if state.animators[item] then state.animators[item]=nil end
 end)
 if type(result.listen)=="function" then
  responseConn=result.listen(function(response)
   if type(response)~="table" then return end
   if response.Action=="success" then
    state.confirmed+=1
   elseif response.Action=="rejected" then
    state.rejected+=1
    backoffUntil=os.clock()+0.4
   end
  end)
 end
 bindCharacter(player.Character)
 worker=RS.Heartbeat:Connect(function()
  local success,err=pcall(step)
  if not success then
   state.setEnabled(false)
   state.status="Dodge error: "..tostring(err)
   log(state.status)
  end
 end)
 return true
end

function state.stop()
 if not state.alive then return end
 state.setEnabled(false)
 state.alive=false
 if G.VeyraDodge==state then G.VeyraDodge=nil end
end

return state
