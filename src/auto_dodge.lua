-- Auto Dodge: fires Combat.RollInput when parry is on cooldown or attack is unparryable.
local G=getgenv()
if G.VeyraDodge then G.VeyraDodge.stop() end
local storage=game:GetService("ReplicatedStorage")
local player=game:GetService("Players").LocalPlayer
local RS=game:GetService("RunService")

local state={alive=true,enabled=false,status="Auto Dodge off",dodges=0}
G.VeyraDodge=state

local connections={}
local worker
local dodgePacket,parryModule

local DODGE_WINDOW=0.35   -- how early before impact to dodge
local MIN_DODGE_GAP=1.5   -- minimum time between dodges

local lastDodge=-math.huge

local function log(msg)
	table.insert(state.log or {},string.format("%.3f %s",os.clock(),msg))
	if #(state.log or {})>40 then table.remove(state.log,1) end
end

local function getParryState()
	local parry=G.VeyraParry
	if not parry or not parry.enabled then return nil end
	return {
		enabled=true,
		cooldown=parry.state and parry.state.cooldownWait or 0,
		blockedReason=parry.state and parry.state.blockedReason,
		lead=parry.state and parry.state.lead or 0,
	}
end

local function findInboundDodgeCandidate()
	local parry=G.VeyraParry
	if not parry or not parry.pending then return end
	local c=player.Character
	local myRoot=c and c:FindFirstChild("HumanoidRootPart")
	if not myRoot then return end
	local now=os.clock()
	local best,bestRemaining
	for _,candidate in ipairs(parry.pending) do
		if not candidate.track.IsPlaying then continue end
		local pos=candidate.track.TimePosition
		local remaining=(candidate.hit-pos)/candidate.track.Speed
		if remaining<=0 or remaining>DODGE_WINDOW then continue end
		-- Only dodge unparryable attacks or when parry is on cooldown
		local model=candidate.model
		local other=model and model:FindFirstChild("HumanoidRootPart")
		if not other then continue end
		local dist=(myRoot.Position-other.Position).Magnitude
		if dist>15 then continue end
		-- Check if parry would handle this
		local parryState=getParryState()
		local canParry=parryState and (parryState.blockedReason~="ParryCooldown") and not parry.isUnparryable and parry.isUnparryable and not parry.isUnparryable(candidate)
		if not canParry then
			if not bestRemaining or remaining<bestRemaining then
				best=candidate
				bestRemaining=remaining
			end
		end
	end
	return best,bestRemaining
end

local function sendDodge()
	if not dodgePacket then return false end
	local ok,err=pcall(function() dodgePacket.send({Action="Roll",typeOf="Dodge"}) end)
	if not ok then log("dodge send: "..tostring(err)) return false end
	return true
end

local function step()
	if not state.enabled or not state.alive then return end
	local c=player.Character
	if not c then return end
	local humanoid=c:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health<=0 then return end
	local myRoot=c:FindFirstChild("HumanoidRootPart")
	if not myRoot then return end

	local now=os.clock()
	if now-lastDodge<MIN_DODGE_GAP then
		state.status=string.format("Dodge gap: %.1fs",MIN_DODGE_GAP-(now-lastDodge))
		return
	end

	local candidate,remaining=findInboundDodgeCandidate()
	if candidate and remaining>0.05 and remaining<=DODGE_WINDOW then
		if sendDodge() then
			lastDodge=now
			state.dodges+=1
			log(string.format("dodged %s (%.2fs remaining)",candidate.name,remaining))
			state.status=string.format("Dodged %s",candidate.name)
		end
	else
		state.status="Auto Dodge active · waiting for unparryable"
	end
end

function state.setEnabled(on)
	on=on==true
	if on==state.enabled then return on end
	if not on then
		state.enabled=false
		if worker then worker:Disconnect() worker=nil end
		for _,conn in ipairs(connections) do conn:Disconnect() end
		table.clear(connections)
		state.status="Auto Dodge off"
		return false
	end
	local ok,packets=pcall(function() return require(storage.Modules.Packets) end)
	if not ok or not packets or not packets.Combat then state.status="Packets unavailable" return false end
	dodgePacket=packets.Combat.packets and packets.Combat.packets.RollInput
	if not dodgePacket then state.status="RollInput unavailable" return false end
	parryModule=G.VeyraParry
	state.enabled=true
	state.status="Auto Dodge active"
	worker=RS.Heartbeat:Connect(function()
		local ok,err=pcall(step)
		if not ok then state.setEnabled(false) state.status="Error: "..tostring(err) log(state.status) end
	end)
	return true
end

function state.stop()
	state.setEnabled(false)
	state.alive=false
	if G.VeyraDodge==state then G.VeyraDodge=nil end
end

connections[1]=player.CharacterAdded:Connect(function()
	task.wait(1)
	-- Auto re-arm handled by setEnabled
end)
state.log={}
return state