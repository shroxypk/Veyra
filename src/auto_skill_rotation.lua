-- Auto Skill Rotation: fires Magic.Cast / Tools.BasicTechnique on cooldown.
local G=getgenv()
if G.VeyraSkillRotation then G.VeyraSkillRotation.stop() end
local storage=game:GetService("ReplicatedStorage")
local player=game:GetService("Players").LocalPlayer
local HttpService=game:GetService("HttpService")

local state={alive=true,enabled=false,magic={},weapon={},status="Skill Rotation off"}
G.VeyraSkillRotation=state

local connections={}
local worker
local magicPacket,weaponPacket

local SKILL_DB={
	Light={"DivineField","BlindingRush","Conviction","AerialAssault","SlashesOfLight","FallingLance"},
	Flame={"FireStomp","BindingFlame","FlameTrap","ScorchingBarrage","BurstPistol","FieryGrapple"},
	Wind={"Tornado","RushingTempest","WindRush","Palm","WindStomp","Blade"},
	Lightning={"LightningShroud","VoltSurge","ElectroBeam","LightningBarrage","ThunderStrike","DragonImpact"},
	Shadow={"ShadowAnnihilation","DarkCyclone","ViciousAssault","SavageMaw","UmbraSurge","DarkHaste"},
	Beast={"PrimalRoar","HolyHunting","FeralImpact","SavageMaul","ApexClaw","BeastClaw"},
	Time={"TimeStop","Rewind","ChronoSurge","SlowZone","BlitzSkill","PalmSkill"},
}

local function log(msg)
	table.insert(state.log or {},string.format("%.3f %s",os.clock(),msg))
	if #(state.log or {})>60 then table.remove(state.log,1) end
end

local function getMagic()
	local c=player.Character
	if not c then return end
	local magic=c:GetAttribute("Magic")
	if not magic then return end
	return magic
end

local function getWeaponSkill()
	local c=player.Character
	if not c then return end
	local tool=c:FindFirstChildOfClass("Tool")
	if not tool then return end
	local skill=tool:GetAttribute("Skill")
	if not skill then return end
	return skill
end

local function getCooldowns()
	local c=player.Character
	if not c then return {} end
	local info=c:FindFirstChild("CombatInfo")
	if not info then return {} end
	local out={}
	for _,child in ipairs(info:GetChildren()) do
		if child:IsA("NumberValue") and child.Value>0 then
			out[child.Name]=child.Value
		end
	end
	return out
end

local function getSkillMetadata(magicType,skillName)
	if not magicType then return nil end
	local data=SKILL_DB[magicType]
	if not data then return nil end
	for _,s in ipairs(data) do
		if s==skillName then return {magic=magicType,skill=skillName} end
	end
	return nil
end

local function buildSkillList()
	local list={}
	local magicType=getMagic()
	if magicType then
		for _,skill in ipairs(SKILL_DB[magicType] or {}) do
			table.insert(list,{type="magic",skill=skill,magic=magicType})
		end
	end
	local weaponSkill=getWeaponSkill()
	if weaponSkill then
		table.insert(list,{type="weapon",skill=weaponSkill})
	end
	state.skillList=list
	return list
end

local function sendMagic(skill)
	if not magicPacket then return false end
	local ok,err=pcall(function() magicPacket.send({Skill=skill}) end)
	if not ok then log("magic send: "..tostring(err)) end
	return ok
end

local function sendWeapon(skill)
	if not weaponPacket then return false end
	local ok,err=pcall(function() weaponPacket.send({Skill=skill}) end)
	if not ok then log("weapon send: "..tostring(err)) end
	return ok
end

local function step()
	if not state.enabled or not state.alive then return end
	local c=player.Character
	if not c then return end
	local humanoid=c:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health<=0 then return end

	local list=state.skillList
	if #list==0 then buildSkillList() end
	if #list==0 then state.status="No skills found" return end

	local cooldowns=getCooldowns()
	local now=os.clock()
	local best,soonest
	for _,entry in ipairs(list) do
		local cd=cooldowns[entry.skill]
		if not cd then
			if entry.type=="magic" then sendMagic(entry.skill) else sendWeapon(entry.skill) end
			return
		end
		local readyAt=now+cd
		if not soonest or readyAt<soonest then soonest=readyAt best=entry end
	end
	if best then
		state.status=string.format("Next: %s (%.1fs)",best.skill,soonest-now)
	else
		state.status="All skills on cooldown"
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
		state.status="Skill Rotation off"
		return false
	end
	local ok,packets=pcall(function() return require(storage.Modules.Packets) end)
	if not ok or not packets then state.status="Packets unavailable" return false end
	magicPacket=packets.Magic and packets.Magic.packets and packets.Magic.packets.Cast
	weaponPacket=packets.Tools and packets.Tools.packets and packets.Tools.packets.BasicTechnique
	if not magicPacket and not weaponPacket then state.status="No skill packets" return false end
	buildSkillList()
	state.enabled=true
	state.status="Skill Rotation active"
	worker=game:GetService("RunService").Heartbeat:Connect(function()
		local ok,err=pcall(step)
		if not ok then state.setEnabled(false) state.status="Error: "..tostring(err) log(state.status) end
	end)
	return true
end

function state.stop()
	state.setEnabled(false)
	state.alive=false
	if G.VeyraSkillRotation==state then G.VeyraSkillRotation=nil end
end

connections[1]=player.CharacterAdded:Connect(function()
	task.wait(1)
	if state.enabled then buildSkillList() end
end)
state.log={}
return state