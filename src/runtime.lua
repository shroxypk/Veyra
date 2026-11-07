-- Veyra: minigames, experimental melee parry, broom speed, and quest guidance.
local G = getgenv()
if G.VeyraController then G.VeyraController.unload() end
if G.VeyraMinigames then G.VeyraMinigames.stop() end
if G.VeyraQuestAssist then G.VeyraQuestAssist.stop() end
if G.VeyraParry then G.VeyraParry.stop() end
if G.VeyraBossAlerts then G.VeyraBossAlerts.stop() end
if G.VeyraDodge then G.VeyraDodge.stop() end
  -- Legacy guard: builds before v2 kept a Kill Aura module here. Reloading the
  -- hub must release its held mouse button, or it keeps swinging on its own.
  if G.VeyraKillAura and G.VeyraKillAura.stop then G.VeyraKillAura.stop() end
  G.VeyraKillAura=nil
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local player = Players.LocalPlayer
local H = {alive=true, connections={}, tweens={}, broomSpeed=1}
G.VeyraController = H
local function connect(signal, callback)
 local c=signal:Connect(callback)
 table.insert(H.connections,c)
 return c
end
-- Hidden UI access is optional; use PlayerGui even in runtimes without gethui.
local uiRoots={player.PlayerGui,game:GetService("CoreGui")}
if type(gethui)=="function" then
 local ok,hidden=pcall(gethui)
 if ok and hidden and hidden~=player.PlayerGui then table.insert(uiRoots,hidden) end
end
for _,root in ipairs(uiRoots) do
 local ok,children=pcall(function() return root:GetChildren() end)
 if ok then
  for _,child in ipairs(children) do
   if child.Name=="VeyraPanel" then child:Destroy() end
  end
 end
end
local moduleErrors={}
local function startModule(name,start)
 local ok,err=pcall(start)
 if not ok then
  table.insert(moduleErrors,name..": "..tostring(err))
  warn("Veyra: "..moduleErrors[#moduleErrors])
 end
end
-- Preferences load before any UI so geometry and hotkeys are right on the
-- first frame. Only preferences are stored; every automation toggle still
-- starts off, so a stale file can never arm a feature on its own.
local config
startModule("config",function() config=loadstring(readfile("Veyra/src/config.lua"),"config.lua")() end)
if not config then
 local function copy(value)
  if type(value)~="table" then return value end
  local out={} for k,v in pairs(value) do out[k]=copy(v) end return out
 end
 config={values={},stop=function() end}
 function config.load(defaults) config.defaults=copy(defaults) config.values=copy(defaults) return config.values end
 function config.reset() config.values=copy(config.defaults) return config.values end
 function config.set(key,value) config.values[key]=value end
 function config.patch(key,value) for k,v in pairs(value) do config.values[key][k]=v end end
end
local initialView=workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920,1080)
local prefs=config.load({
 broomSpeed=1,
 panel={x=-1,y=-1,width=math.min(430,math.max(320,initialView.X-24)),
  height=math.min(560,math.max(420,initialView.Y-52)),preset=1},
 hotkeys={toggle="RightControl",minimize="Delete",size="Insert",panic="End"},
 parry={range=14,lead=0.1,grantLag=0.15,pressRate=0.35,releaseHorizon=0.8,sessionMin=0.16,pulseDeadline=0.55,whiffLock=1.25,graceLock=0.75,scanRadius=150,effectiveRangeBuffer=2,closeSpinThreshold=8,heightThreshold=10,closingSpeedHorizon=0.25,facingDot=0.25,parryWindow=0.25,biasGain=0.5,biasLimit=0.15,staleSlack=0.3,staleHitSlack=0.5,attackLengthMin=0.2,attackLengthMax=6,clusterThreshold=0.28,derivedHitOffset=0.03,derivedSpeedThreshold=6,derivedPeakThreshold=0.15,derivedMinHit=0.2,derivedMaxHitSlack=0.05,biasResidualWindow=0.4,hitResidualsMax=20,unobservedGrantsMax=512,derivedMaxProfiles=512,derivedSaveInterval=2,scanInterval=0.4},
 quest={pins="ALL"},
})
H.prefs=prefs
local usedKeys={}
for _,entry in ipairs({{"toggle","RightControl"},{"minimize","Delete"},{"size","Insert"},{"panic","End"}}) do
 local name=prefs.hotkeys[entry[1]]
 local ok,key=pcall(function() return Enum.KeyCode[name] end)
  if not ok or not key or key==Enum.KeyCode.Unknown or key==Enum.KeyCode.Escape or usedKeys[name] then
   prefs.hotkeys={toggle="RightControl",minimize="Delete",size="Insert",panic="End"}
   break
  end
 prefs.hotkeys[entry[1]]=name usedKeys[name]=true
end
if prefs.quest.pins~="ALL" and prefs.quest.pins~="NEAR" and prefs.quest.pins~="OFF" then prefs.quest.pins="ALL" end
H.broomSpeed=math.clamp(tonumber(prefs.broomSpeed) or 1,1,3)
startModule("minigames",function() loadstring(readfile("Veyra/src/minigames.lua"),"minigames.lua")() end)
startModule("quest assist",function() loadstring(readfile("Veyra/src/quest_assist.lua"),"quest_assist.lua")() end)
startModule("boss alerts",function() loadstring(readfile("Veyra/src/boss_alerts.lua"),"boss_alerts.lua")() end)
startModule("auto parry",function() loadstring(readfile("Veyra/src/auto_parry.lua"),"auto_parry.lua")() end)
startModule("auto dodge",function() loadstring(readfile("Veyra/src/auto_dodge.lua"),"auto_dodge.lua")() end)
local AD = G.VeyraDodge
H.autoDodge=AD
local AP = G.VeyraParry
H.parry=AP
local QA = G.VeyraQuestAssist
local BA = G.VeyraBossAlerts
local MG = G.VeyraMinigames
-- Restore the preferences the modules own, before their first frame.
if AP then AP.range=math.clamp(tonumber(prefs.parry.range) or 14,6,30) end
if QA and prefs.quest.pins then QA.markerMode=prefs.quest.pins end
H.questAssist=QA
H.bossAlerts=BA
H.minigames=MG
-- Broom velocity is set by the game's own flight controller. Madium A/B
-- captures showed 80 studs/s at BOTH 1x and 2x even though this scaler was
-- armed: the game's PreSimulation write replaced our scheduled write.
-- Watch changes to the active LinearVelocity instead and scale the value
-- immediately after the game supplies it. Keep all vertical movement intact.
local function boostedBroomVector(v,mult)
 if mult<=1 then return nil end
 local mag=math.sqrt(v.X*v.X+v.Z*v.Z)
 if mag<1 or mag>250 then return nil end
 local target=math.min(mag*mult,240)
 if target<=mag+0.001 then return nil end
 return Vector3.new(v.X/mag*target,v.Y,v.Z/mag*target)
end
-- One scaling path for both the watcher and manual calls, so a value we
-- already boosted is never boosted a second time (40 -> 80 -> 160 -> cap was
-- reachable when the signal and a direct call overlapped).
local lastWritten
local function scaleBroomVelocity(lv)
 local raw=lv.VectorVelocity
 if lastWritten and (raw-lastWritten).Magnitude<=0.001 then return false end
 local boosted=boostedBroomVector(raw,H.broomSpeed)
 if not boosted then return false end
 lastWritten=boosted
 H.broomDebug.appliedWrites+=1
 H.broomDebug.lastBase=math.sqrt(raw.X*raw.X+raw.Z*raw.Z)
 H.broomDebug.lastBoost=math.sqrt(boosted.X*boosted.X+boosted.Z*boosted.Z)
 lv.VectorVelocity=boosted
 return true
end
local broomScaler
local broomRoot,broomVelocity,broomVelocityConn
local broomGeneration=0
local mountConnection
H.broomDebug={observedWrites=0,appliedWrites=0,attached=false,lastBase=0,lastBoost=0}
local function detachBroomVelocity()
 lastWritten=nil
 if broomVelocityConn then broomVelocityConn:Disconnect() broomVelocityConn=nil end
 broomVelocity=nil
 H.broomDebug.attached=false
end
local function watchBroomVelocity(lv,generation,character)
 if broomVelocity==lv then return end
 detachBroomVelocity()
 broomVelocity=lv
 if not lv then return end
 local function onVelocityChanged()
  if not H.alive or generation~=broomGeneration or character~=player.Character
   or not character:GetAttribute("Flying") or not lv.Parent then return end
  H.broomDebug.observedWrites+=1
  scaleBroomVelocity(lv)
 end
 broomVelocityConn=lv:GetPropertyChangedSignal("VectorVelocity"):Connect(onVelocityChanged)
 H.broomDebug.attached=true
 onVelocityChanged()
end
local function armBroom()
 broomGeneration+=1
 local generation=broomGeneration
 if broomScaler then broomScaler:Disconnect() broomScaler=nil end
 detachBroomVelocity()
 broomRoot=nil
 local character=player.Character
 if H.alive and H.broomSpeed>1 and character and character:GetAttribute("Flying") then
  -- Locate the live actuator as soon as it exists; do not assume callback
  -- order on PreSimulation. The property watcher handles controller writes.
  task.delay(0.1,function()
   if generation==broomGeneration and H.alive and H.broomSpeed>1
    and character==player.Character and character:GetAttribute("Flying") and not broomScaler then
    broomScaler=RS.PreSimulation:Connect(function()
     local me=player.Character
     if not me or not me:GetAttribute("Flying") then return end
     local root=me:FindFirstChild("HumanoidRootPart")
     if root~=broomRoot then
      broomRoot=root
      detachBroomVelocity()
     end
     local lv=root and root:FindFirstChildWhichIsA("LinearVelocity",true)
     if lv~=broomVelocity then watchBroomVelocity(lv,generation,character) end
    end)
   end
  end)
 end
end
local function wireBroomCharacter(char)
 if mountConnection then mountConnection:Disconnect() mountConnection=nil end
 if not char then return end
 mountConnection=char:GetAttributeChangedSignal("Flying"):Connect(function()
  if H.alive then armBroom() end
 end)
 armBroom()
end
H.scaleBroomVelocity=scaleBroomVelocity
H.armBroom=armBroom
H.testBroomConn=function() return broomScaler~=nil end
H.testBroomWatcher=function() return broomVelocityConn~=nil end
local palette={
 bg=Color3.fromRGB(11,11,13),
 panel=Color3.fromRGB(22,22,26),
 chip=Color3.fromRGB(29,29,34),
 line=Color3.fromRGB(43,43,50),
 text=Color3.fromRGB(237,237,241),
 muted=Color3.fromRGB(138,138,148),
 accent=Color3.fromRGB(229,56,59),
 accentDim=Color3.fromRGB(122,28,31),
 locked=Color3.fromRGB(110,86,88),
 onAccent=Color3.fromRGB(255,255,255),
}
local hover=Color3.fromRGB(31,31,37)
local toggleOn=Color3.fromRGB(200,44,47)
local function new(class,props,parent)
 local o=Instance.new(class)
 for k,v in pairs(props) do o[k]=v end
 o.Parent=parent
 return o
end
local function corner(o,r) new("UICorner",{CornerRadius=UDim.new(0,r or 10)},o) end
local function tween(o,props)
 if H.tweens[o] then H.tweens[o]:Cancel() end
 local t=TS:Create(o,TweenInfo.new(0.16,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),props)
 H.tweens[o]=t
 t:Play()
end
-- Event callbacks can access PlayerGui without gethui's Plugin capability.
local gui=new("ScreenGui",{Name="VeyraPanel",ResetOnSpawn=false,IgnoreGuiInset=true,DisplayOrder=10000,ZIndexBehavior=Enum.ZIndexBehavior.Sibling},player.PlayerGui)
H.gui=gui
-- Toasts: short, self-dismissing notices anchored to the top-right corner.
-- CanvasGroup gives one property to fade, so the card and its text disappear
-- together instead of popping off the screen.
local toastHost=new("Frame",{Name="Toasts",AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-16,0,16),Size=UDim2.fromOffset(264,0),BackgroundTransparency=1,BorderSizePixel=0},gui)
new("UIListLayout",{Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,HorizontalAlignment=Enum.HorizontalAlignment.Right},toastHost)
local toasts={}
local function dismissToast(card)
 if H.tweens[card] then H.tweens[card]:Cancel() H.tweens[card]=nil end
 for index,entry in ipairs(toasts) do
  if entry==card then table.remove(toasts,index) break end
 end
 if card.Parent then card:Destroy() end
end
local function toast(title,text)
 if not H.alive or not gui.Parent then return end
 while #toasts>=3 do dismissToast(toasts[1]) end
 local card=new("CanvasGroup",{Size=UDim2.fromOffset(264,52),BackgroundColor3=palette.panel,BorderSizePixel=0,GroupTransparency=0},toastHost)
 corner(card,10)
 new("UIStroke",{Color=palette.line,Thickness=1,Transparency=0.2},card)
 new("Frame",{Name="AccentBar",Position=UDim2.fromOffset(0,11),Size=UDim2.fromOffset(3,30),BackgroundColor3=palette.accent,BorderSizePixel=0},card)
 new("TextLabel",{Position=UDim2.fromOffset(14,8),Size=UDim2.new(1,-24,0,18),BackgroundTransparency=1,Text=title,Font=Enum.Font.GothamBold,TextSize=13,TextColor3=palette.text,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},card)
 new("TextLabel",{Position=UDim2.fromOffset(14,27),Size=UDim2.new(1,-24,0,16),BackgroundTransparency=1,Text=text,Font=Enum.Font.Gotham,TextSize=11,TextColor3=palette.muted,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},card)
 table.insert(toasts,card)
 task.delay(3.4,function()
  if not card.Parent then return end
  tween(card,{GroupTransparency=1})
  task.delay(0.2,function() dismissToast(card) end)
 end)
 return card
end
H.toast=toast
local size=Vector2.new(
 math.clamp(tonumber(prefs.panel.width) or 430,320,math.max(320,math.min(680,initialView.X-16))),
 math.clamp(tonumber(prefs.panel.height) or 560,420,math.max(420,math.min(860,initialView.Y-40))))
local savedX=tonumber(prefs.panel.x) or -1
local savedY=tonumber(prefs.panel.y) or -1
local startX=savedX>=0 and savedX or math.max(8,math.min(35,initialView.X-size.X-8))
local startY=savedY>=0 and savedY or math.max(8,math.min(120,initialView.Y-size.Y-8))
local HEADER=66
local BODY_TOP=70
local BOTTOM=72
local frame=new("Frame",{Name="Main",Size=UDim2.fromOffset(size.X,size.Y),Position=UDim2.fromOffset(math.clamp(startX,0,math.max(0,initialView.X-size.X)),math.clamp(startY,0,math.max(0,initialView.Y-size.Y))),BackgroundColor3=palette.bg,BorderSizePixel=0,ClipsDescendants=true,Active=true},gui)
corner(frame,16)
new("UIStroke",{Color=palette.line,Thickness=1,Transparency=0.25},frame)
local header=new("TextButton",{Name="DragHeader",Size=UDim2.new(1,-50,0,HEADER),BackgroundTransparency=1,Text="",AutoButtonColor=false},frame)
new("Frame",{Name="AccentBar",Position=UDim2.fromOffset(20,16),Size=UDim2.fromOffset(4,32),BackgroundColor3=palette.accent,BorderSizePixel=0},header)
new("TextLabel",{Position=UDim2.fromOffset(34,10),Size=UDim2.new(1,-50,0,26),BackgroundTransparency=1,Text="VEYRA",Font=Enum.Font.GothamBold,TextSize=19,TextColor3=palette.text,TextXAlignment=Enum.TextXAlignment.Left},header)
new("TextLabel",{Position=UDim2.fromOffset(34,38),Size=UDim2.new(1,-50,0,16),BackgroundTransparency=1,Text="CLOVER RPG · AUTOMATION",Font=Enum.Font.Gotham,TextSize=10,TextColor3=palette.muted,TextXAlignment=Enum.TextXAlignment.Left},header)
local minimize=new("TextButton",{Name="Minimize",Position=UDim2.new(1,-52,0,16),Size=UDim2.fromOffset(36,36),BackgroundColor3=palette.panel,Text="-",TextSize=24,Font=Enum.Font.Gotham,TextColor3=palette.text,BorderSizePixel=0},frame)
corner(minimize,9)
-- Each feature group owns its scroll position; changing tabs only changes UI.
local minimized=false
local order=0
local bodyHost=new("Frame",{Name="Body",Position=UDim2.fromOffset(14,BODY_TOP),Size=UDim2.new(1,-28,0,382),BackgroundTransparency=1,BorderSizePixel=0},frame)
local tabBar=new("Frame",{Name="Tabs",Size=UDim2.new(1,0,0,34),BackgroundTransparency=1},bodyHost)
local pages,tabButtons={},{}
local body
local function selectTab(name)
 if not pages[name] then return end
 H.activeTab=name
 for pageName,page in pairs(pages) do
  local selected=pageName==name
  page.Visible=selected
  tabButtons[pageName].BackgroundColor3=selected and palette.accent or palette.panel
  tabButtons[pageName].TextColor3=selected and palette.onAccent or palette.muted
 end
end
for index,name in ipairs({"Combat","Movement","Guidance","Settings"}) do
 local page=new("ScrollingFrame",{Name=name,Position=UDim2.fromOffset(0,44),Size=UDim2.new(1,0,1,-44),Visible=false,BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=4,ScrollBarImageColor3=palette.line,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollingDirection=Enum.ScrollingDirection.Y,ElasticBehavior=Enum.ElasticBehavior.Never},bodyHost)
 new("UIListLayout",{Padding=UDim.new(0,9),SortOrder=Enum.SortOrder.LayoutOrder},page)
 local button=new("TextButton",{Name=name,Position=UDim2.new((index-1)/5,2,0,0),Size=UDim2.new(1/5,-4,1,0),BackgroundColor3=palette.panel,BorderSizePixel=0,Text=name,Font=Enum.Font.GothamMedium,TextSize=10,TextColor3=palette.muted,AutoButtonColor=false},tabBar)
 corner(button,7)
 pages[name]=page tabButtons[name]=button
 connect(button.Activated,function() selectTab(name) end)
end
H.selectTab=selectTab
selectTab("Combat")
local function layoutPages()
 local height=math.max(140,(minimized and HEADER or size.Y)-BODY_TOP-BOTTOM)
 bodyHost.Size=UDim2.new(1,-28,0,height)
end
layoutPages()
local toggleRefresh={}
-- Small drawn chip that gives each row a landmark. Shapes only: font glyphs
-- render as empty boxes on clients whose font set lacks them.
local function iconChip(parent,y)
 local chip=new("Frame",{Name="Icon",Position=UDim2.fromOffset(11,y+1),Size=UDim2.fromOffset(24,24),BackgroundColor3=palette.chip,BorderSizePixel=0},parent)
 corner(chip,7)
 local dot=new("Frame",{Name="Dot",Position=UDim2.fromOffset(8,8),Size=UDim2.fromOffset(8,8),BackgroundColor3=palette.accent,BorderSizePixel=0},chip)
 corner(dot,4)
 return 33
end
local function heading(text)
 order+=1
 return new("TextLabel",{Name="Section "..text,LayoutOrder=order,Size=UDim2.new(1,-5,0,20),BackgroundTransparency=1,Text=text:upper(),Font=Enum.Font.GothamBold,TextSize=11,TextColor3=palette.muted,TextXAlignment=Enum.TextXAlignment.Left},body)
end
local function toggle(name,description,initial,callback,getState)
 local on=initial
 order+=1
 local b=new("TextButton",{Name=name,LayoutOrder=order,Size=UDim2.new(1,-5,0,58),BackgroundColor3=palette.panel,BorderSizePixel=0,Text="",AutoButtonColor=false},body)
 corner(b,10)
 local pad=iconChip(b,8)
 new("TextLabel",{Position=UDim2.fromOffset(12+pad,9),Size=UDim2.new(1,-90-pad,0,20),BackgroundTransparency=1,Text=name,Font=Enum.Font.GothamMedium,TextSize=14,TextColor3=palette.text,TextXAlignment=Enum.TextXAlignment.Left},b)
 new("TextLabel",{Position=UDim2.fromOffset(12+pad,32),Size=UDim2.new(1,-90-pad,0,16),BackgroundTransparency=1,Text=description,Font=Enum.Font.Gotham,TextSize=12,TextColor3=palette.muted,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},b)
 local track=new("Frame",{Position=UDim2.new(1,-58,0.5,-12),Size=UDim2.fromOffset(44,24),BorderSizePixel=0},b)
 corner(track,12)
 local knob=new("Frame",{Size=UDim2.fromOffset(17,17),BackgroundColor3=palette.text,BorderSizePixel=0},track)
 corner(knob,9)
 local function paint()
  tween(track,{BackgroundColor3=on and toggleOn or palette.line})
  tween(knob,{Position=UDim2.fromOffset(on and 23 or 4,4)})
 end
 paint()
 connect(b.Activated,function()
  if getState then on=getState() end
  on=not on callback(on)
  if getState then on=getState() end
  paint()
 end)
 if getState then
  table.insert(toggleRefresh,function()
   local current=getState()
   if current~=on then on=current paint() end
  end)
 end
 connect(b.MouseEnter,function() tween(b,{BackgroundColor3=hover}) end)
 connect(b.MouseLeave,function() tween(b,{BackgroundColor3=palette.panel}) end)
 return b
end
local function stepper(name,description,minValue,maxValue,step,initial,format,callback)
 order+=1
 local b=new("Frame",{Name=name,LayoutOrder=order,Size=UDim2.new(1,-5,0,58),BackgroundColor3=palette.panel,BorderSizePixel=0},body)
 corner(b,10)
 new("TextLabel",{Position=UDim2.fromOffset(14,9),Size=UDim2.new(1,-90,0,20),BackgroundTransparency=1,Text=name,Font=Enum.Font.GothamMedium,TextSize=14,TextColor3=palette.text,TextXAlignment=Enum.TextXAlignment.Left},b)
 new("TextLabel",{Position=UDim2.fromOffset(14,32),Size=UDim2.new(1,-90,0,16),BackgroundTransparency=1,Text=description,Font=Enum.Font.Gotham,TextSize=12,TextColor3=palette.muted,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},b)
 local valueLabel=new("TextLabel",{Name="Value",Position=UDim2.new(1,-152,0.5,-11),Size=UDim2.fromOffset(62,22),BackgroundTransparency=1,Text=format(initial),Font=Enum.Font.GothamBold,TextSize=14,TextColor3=palette.accent,TextXAlignment=Enum.TextXAlignment.Right},b)
 local value=initial
 local function paint()
  valueLabel.Text=format(value)
 end
 local function adjust(delta)
  local nextValue=math.clamp(math.floor((value+delta)*100+0.5)/100,minValue,maxValue)
  if nextValue==value then return end -- Do not re-arm the broom at a limit.
  value=nextValue
  callback(value)
  paint()
 end
 local function button(symbol,label,offset)
  local btn=new("TextButton",{Name=label,Position=UDim2.new(1,offset,0.5,-14),Size=UDim2.fromOffset(32,28),BackgroundColor3=palette.line,BorderSizePixel=0,Text=symbol,Font=Enum.Font.GothamBold,TextSize=18,TextColor3=palette.text},b)
  corner(btn,8)
  connect(btn.Activated,function() adjust(label=="Plus" and step or -step) end)
  connect(btn.MouseEnter,function() tween(btn,{BackgroundColor3=hover}) end)
  connect(btn.MouseLeave,function() tween(btn,{BackgroundColor3=palette.line}) end)
 end
 button("-","Minus",-76)
 button("+","Plus",-40)
 paint()
 return b,function(nextValue) value=nextValue paint() end
end
-- One row for a plain action, with a right-aligned value the caller can
-- repaint (used for hotkey bindings and the reset button).
local function action(name,description,initialText,callback)
 order+=1
 local b=new("TextButton",{Name=name,LayoutOrder=order,Size=UDim2.new(1,-5,0,58),BackgroundColor3=palette.panel,BorderSizePixel=0,Text="",AutoButtonColor=false},body)
 corner(b,10)
 local pad=iconChip(b,8)
 new("TextLabel",{Position=UDim2.fromOffset(12+pad,9),Size=UDim2.new(1,-142-pad,0,20),BackgroundTransparency=1,Text=name,Font=Enum.Font.GothamMedium,TextSize=14,TextColor3=palette.text,TextXAlignment=Enum.TextXAlignment.Left},b)
 new("TextLabel",{Position=UDim2.fromOffset(12+pad,32),Size=UDim2.new(1,-142-pad,0,16),BackgroundTransparency=1,Text=description,Font=Enum.Font.Gotham,TextSize=12,TextColor3=palette.muted,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},b)
 local value=new("TextLabel",{Name="Value",Position=UDim2.new(1,-118,0.5,-12),Size=UDim2.fromOffset(106,24),BackgroundTransparency=1,Text=initialText,Font=Enum.Font.GothamBold,TextSize=12,TextColor3=palette.accent,TextXAlignment=Enum.TextXAlignment.Right,TextTruncate=Enum.TextTruncate.AtEnd},b)
 connect(b.Activated,function() callback(value) end)
 connect(b.MouseEnter,function() tween(b,{BackgroundColor3=hover}) end)
 connect(b.MouseLeave,function() tween(b,{BackgroundColor3=palette.panel}) end)
 return b,value
end
-- Rebindable hotkeys: a row per action, click it, press a key. Bindings are
-- stored by KeyCode name so a saved file stays readable and portable.
local hotkeyRows={}
local bindingAction
local updateFooter
local function keyLabel(name)
 return (tostring(name or "?"):gsub("(%l)(%u)","%1 %2"):upper())
end
local function applyHotkey(actionKey,name)
 for key,value in pairs(prefs.hotkeys) do
  if key~=actionKey and value==name then
   hotkeyRows[actionKey].Text=keyLabel(prefs.hotkeys[actionKey])
   toast("Key already bound","Choose a different key")
   return false
  end
 end
 prefs.hotkeys[actionKey]=name
 config.set("hotkeys",prefs.hotkeys)
 local row=hotkeyRows[actionKey]
 if row then row.Text=keyLabel(name) end
 if updateFooter then updateFooter() end
 return true
end
local function bindHotkey(actionKey,valueLabel)
 if bindingAction then hotkeyRows[bindingAction].Text=keyLabel(prefs.hotkeys[bindingAction]) end
 bindingAction=actionKey
 valueLabel.Text="PRESS A KEY"
 toast("Rebind "..actionKey,"Any key binds · Esc cancels")
end
body=pages.Combat
heading("Minigames")
toggle("Auto Minigames","Solves every harvest + mining minigame for you",false,
 function(on) if MG then MG.setEnabled(on) end end,
 function() return MG and MG.enabled end)
body=pages.Combat
heading("Defense")
toggle("Auto Parry","Predicts mob impact from animation poses · equip a melee weapon",false,
 function(on) if AP then AP.setEnabled(on) end end,
 function() return AP and AP.enabled end)
toggle("Auto Dodge","Rolls for unparryables · fills parry cooldown gaps",false,
 function(on) if AD then AD.setEnabled(on) end end,
 function() return AD and AD.enabled end)
local _,resetRange=stepper("Parry Range","Only react to attackers inside this distance",6,30,1,
 math.clamp(tonumber(prefs.parry.range) or 14,6,30),
 function(v) return string.format("%.0f studs",v) end,
 function(v) if AP then AP.range=v end config.set("parry",{range=v}) end)
toggle("Boss Attack Alerts","Adaptive cues for profiled boss windups",false,function(on) if BA then BA.setEnabled(on) end end,function() return BA and BA.enabled end)
body=pages.Guidance
heading("Quest Guidance")
toggle("Quest Assistance","Draggable tracker · progress · marker controls",false,
 function(on) if QA then QA.setEnabled(on) end end,function() return QA and QA.enabled end)
body=pages.Movement
heading("Movement")
local _,resetBroom=stepper("Broom Speed","Flight velocity multiplier · 1 = normal",1,3,0.25,
 math.clamp(tonumber(prefs.broomSpeed) or 1,1,3),
 function(v) return string.format("%.2fx",v) end,
 function(v) H.broomSpeed=v armBroom() config.set("broomSpeed",v) end)
body=pages.Settings
heading("Controls")
for _,entry in ipairs({
 {key="toggle",label="Open / close panel",description="Show or hide the hub"},
 {key="minimize",label="Minimize panel",description="Collapse to the title bar"},
 {key="size",label="Cycle panel size",description="Step through the size presets"},
 {key="panic",label="Panic stop",description="Disable every automation at once"},
}) do
 local _,value=action(entry.label,entry.description,keyLabel(prefs.hotkeys[entry.key]),
  function(label) bindHotkey(entry.key,label) end)
 hotkeyRows[entry.key]=value
end
local resetGeometry
action("Reset Settings","Forget saved geometry, hotkeys and ranges","RESET",function()
 config.reset()
 prefs=config.values
 H.prefs=prefs
 resetRange(prefs.parry.range)
 resetBroom(prefs.broomSpeed)
 bindingAction=nil
 if resetGeometry then resetGeometry() end
 H.broomSpeed=math.clamp(tonumber(prefs.broomSpeed) or 1,1,3)
 if AP then AP.range=math.clamp(tonumber(prefs.parry.range) or 14,6,30) end
 if QA and prefs.quest.pins then QA.markerMode=prefs.quest.pins end
 for actionKey,row in pairs(hotkeyRows) do row.Text=keyLabel(prefs.hotkeys[actionKey]) end
 armBroom()
 if updateFooter then updateFooter() end
 toast("Settings reset","Default preferences restored")
end)
local status=new("TextLabel",{Name="Status",Position=UDim2.new(0,20,1,-54),Size=UDim2.new(1,-134,0,20),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=12,TextColor3=palette.accent,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Text="Minigames off"},frame)
local footer=new("TextLabel",{Position=UDim2.new(0,20,1,-32),Size=UDim2.new(1,-70,0,18),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=11,TextColor3=palette.muted,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},frame)
function updateFooter()
 footer.Text=string.format("%s hide · %s min · %s size · %s stop",
  keyLabel(prefs.hotkeys.toggle),keyLabel(prefs.hotkeys.minimize),
  keyLabel(prefs.hotkeys.size),keyLabel(prefs.hotkeys.panic))
end
updateFooter()
local unload=new("TextButton",{Position=UDim2.new(1,-102,1,-58),Size=UDim2.fromOffset(82,30),BackgroundColor3=Color3.fromRGB(36,18,20),BorderSizePixel=0,Text="Unload",Font=Enum.Font.GothamMedium,TextSize=12,TextColor3=palette.accent},frame)
corner(unload,8)
new("UIStroke",{Color=palette.accentDim,Thickness=1,Transparency=0.35},unload)
connect(unload.MouseEnter,function() tween(unload,{BackgroundColor3=Color3.fromRGB(58,24,26)}) end)
connect(unload.MouseLeave,function() tween(unload,{BackgroundColor3=Color3.fromRGB(36,18,20)}) end)
local grip=new("TextButton",{Name="ResizeGrip",Position=UDim2.new(1,-34,1,-34),Size=UDim2.fromOffset(34,34),BackgroundTransparency=1,Text="",AutoButtonColor=false},frame)
-- Dotted grip, drawn with frames so no font glyph is required.
for i=0,2 do
 new("Frame",{Name="GripDot"..i,Position=UDim2.fromOffset(22-i*6,22-i*6),Size=UDim2.fromOffset(3,3),BackgroundColor3=palette.muted,BorderSizePixel=0},grip)
end
local edgeR=new("TextButton",{Name="ResizeRight",Position=UDim2.new(1,-5,0,0),Size=UDim2.new(0,5,1,-24),BackgroundTransparency=1,Text="",AutoButtonColor=false},frame)
local edgeB=new("TextButton",{Name="ResizeBottom",Position=UDim2.new(0,0,1,-5),Size=UDim2.new(1,-24,0,5),BackgroundTransparency=1,Text="",AutoButtonColor=false},frame)
local drag,resize,startMouse,startPos,startSize,dragTouch
local sizePresets={Vector2.new(430,560),Vector2.new(500,620),Vector2.new(580,700)}
local presetIndex=math.clamp(math.floor(tonumber(prefs.panel.preset) or 1),1,#sizePresets)
-- Geometry is written on gesture end, never per frame: a drag would otherwise
-- queue a save on every mouse-move.
local function savePanel()
 local position=frame.AbsolutePosition
 config.patch("panel",{x=math.floor(position.X+0.5),y=math.floor(position.Y+0.5),
  width=math.floor(size.X+0.5),height=math.floor(size.Y+0.5),preset=presetIndex})
end
local function setMinimized(state)
 minimized=state
 bodyHost.Visible=not minimized status.Visible=not minimized footer.Visible=not minimized unload.Visible=not minimized
 minimize.Text=minimized and "+" or "-"
 tween(frame,{Size=UDim2.fromOffset(size.X,minimized and HEADER or size.Y)})
 layoutPages()
end
local function cycleSize()
 presetIndex=presetIndex%#sizePresets+1
 local view=workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or initialView
 local requested=sizePresets[presetIndex]
 size=Vector2.new(math.min(requested.X,math.max(320,view.X-24)),math.min(requested.Y,math.max(420,view.Y-52)))
 local position=frame.AbsolutePosition
 frame.Position=UDim2.fromOffset(math.clamp(position.X,8,math.max(8,view.X-size.X-8)),
  math.clamp(position.Y,8,math.max(8,view.Y-(minimized and HEADER or size.Y)-8)))
 layoutPages()
 if not minimized then tween(frame,{Size=UDim2.fromOffset(size.X,size.Y)}) end
 savePanel()
end
resetGeometry=function()
 presetIndex=1
 size=Vector2.new(prefs.panel.width,prefs.panel.height)
 frame.Position=UDim2.fromOffset(math.max(0,math.min(35,initialView.X-size.X)),math.max(0,math.min(120,initialView.Y-size.Y)))
 setMinimized(false)
end
local function begin(input,mode)
 if minimized and mode=="resize" then return end
 if input.UserInputType~=Enum.UserInputType.MouseButton1 and input.UserInputType~=Enum.UserInputType.Touch then return end
 drag=mode=="drag" resize=mode=="resize"
 dragTouch=input.UserInputType==Enum.UserInputType.Touch and input or nil
 startMouse=Vector2.new(input.Position.X,input.Position.Y)
 startPos=frame.AbsolutePosition startSize=frame.AbsoluteSize
end
connect(header.InputBegan,function(i) begin(i,"drag") end)
connect(grip.InputBegan,function(i) begin(i,"resize") end)
connect(edgeR.InputBegan,function(i) begin(i,"resize") end)
connect(edgeB.InputBegan,function(i) begin(i,"resize") end)
connect(grip.MouseEnter,function()
 for _,dot in ipairs(grip:GetChildren()) do
  if dot:IsA("Frame") then tween(dot,{BackgroundColor3=palette.text}) end
 end
end)
connect(grip.MouseLeave,function()
 for _,dot in ipairs(grip:GetChildren()) do
  if dot:IsA("Frame") then tween(dot,{BackgroundColor3=palette.muted}) end
 end
end)
local function viewport() return workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920,1080) end
connect(UIS.InputChanged,function(i)
 if not drag and not resize then return end
 if dragTouch and i~=dragTouch then return end
 if not dragTouch and i.UserInputType~=Enum.UserInputType.MouseMovement then return end
 local delta=Vector2.new(i.Position.X,i.Position.Y)-startMouse
 local view=viewport()
 if drag then
  frame.Position=UDim2.fromOffset(math.clamp(startPos.X+delta.X,0,math.max(0,view.X-frame.AbsoluteSize.X)),math.clamp(startPos.Y+delta.Y,0,math.max(0,view.Y-frame.AbsoluteSize.Y)))
 else
  if H.tweens[frame] then H.tweens[frame]:Cancel() end
    size=Vector2.new(math.clamp(startSize.X+delta.X,320,math.max(320,math.min(680,view.X-16))),math.clamp(startSize.Y+delta.Y,420,math.max(420,math.min(860,view.Y-40))))
  frame.Size=UDim2.fromOffset(size.X,size.Y)
  layoutPages()
 end
end)
connect(UIS.InputEnded,function(i)
 if (dragTouch and i==dragTouch) or (not dragTouch and i.UserInputType==Enum.UserInputType.MouseButton1) then
  local changed=drag or resize
  drag=false resize=false dragTouch=nil
  if changed then savePanel() end
 end
end)
connect(minimize.Activated,function() setMinimized(not minimized) end)
local cursor=new("Frame",{Name="HubCursor",Size=UDim2.fromOffset(10,10),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,ZIndex=100,Visible=false},gui)
corner(cursor,5)
new("UIStroke",{Color=Color3.new(0,0,0),Thickness=1,Transparency=0.45},cursor)
local savedCursor,ownsCursor=false,false
local hovering=false
local function cursorRelease()
 if ownsCursor then UIS.MouseIconEnabled=savedCursor ownsCursor=false end
 header.Modal=false
 hovering=false
 cursor.Visible=false if MG then MG.paused=false end
end
local cursorBound=false
local nextStatus=0
local function refreshStatus()
 for _,refresh in ipairs(toggleRefresh) do refresh() end
 local label="Ready · features disabled"
 if BA and BA.enabled then label=BA.status end
 if AP and AP.enabled then label=AP.status end
 if QA and QA.enabled then
  label=QA.selected and ("Quest: "..QA.selected..(QA.distance and (" · "..QA.distance.." studs") or "")) or QA.status
 end
 if MG and MG.enabled then
  label=MG.paused and "Minigames paused" or MG.activity or "Waiting for minigame"
  if MG.lastResult and not MG.paused then label=label.." · "..MG.lastResult end
 end
 if GA and GA.enabled then label=GA.status end
  -- Combat warning takes priority over other status messages when active.
 if BA and BA.enabled and BA.status:find("Boss marker",1,true) then label=BA.status end
 if #moduleErrors>0 then label="Module issue · "..moduleErrors[1] end
 if status.Text~=label then status.Text=label end
 -- The tracker's own PINS button is the only place marker mode changes, so
 -- mirror it into preferences instead of adding a second control for it.
 if QA and QA.markerMode and QA.markerMode~=prefs.quest.pins then
  prefs.quest.pins=QA.markerMode
  config.patch("quest",{pins=QA.markerMode})
 end
end
local function cursorFree()
 -- A locked mouse means gameplay owns the pointer. The panel must never take
 -- it over then: setting Modal or MouseIconEnabled mid-game makes the game
 -- treat the cursor as free and drop character movement.
 return UIS.MouseBehavior~=Enum.MouseBehavior.LockCenter
end
local nextPanel=0
local function updatePanel()
 local now=os.clock()
 if now>=nextStatus then nextStatus=now+0.5 refreshStatus() end
 -- Hover hit-testing does not need every render frame; the drag path still
 -- runs each frame so resizing and dragging stay smooth.
 if not drag and not resize and now<nextPanel then return end
 nextPanel=now+0.022
 local mouse=UIS:GetMouseLocation()
 local p,s=frame.AbsolutePosition,frame.AbsoluteSize
 local free=cursorFree()
 local inside=free and mouse.X>=p.X and mouse.X<=p.X+s.X and mouse.Y>=p.Y and mouse.Y<=p.Y+s.Y
 local want=inside or drag or resize
 -- Transition only. Re-asserting this every frame fights the game's input
 -- state; touching it once on enter and once on leave does not.
 if want~=hovering then
  hovering=want
  header.Modal=want
  if want then
   if not ownsCursor then savedCursor=UIS.MouseIconEnabled ownsCursor=true end
   UIS.MouseIconEnabled=true
   if MG then MG.paused=true end
  else
   cursorRelease()
  end
 end
 if hovering then
  cursor.Position=UDim2.fromOffset(mouse.X,mouse.Y)
  cursor.Visible=true
 end
end
local function showPanel(enabled)
 gui.Enabled=enabled
 if enabled then
  if not cursorBound then
   cursorBound=true
   RS:BindToRenderStep("VeyraCursor",Enum.RenderPriority.Last.Value+1,updatePanel)
  end
  nextStatus=0
  refreshStatus()
 else
  if cursorBound then
   cursorBound=false
   RS:UnbindFromRenderStep("VeyraCursor")
  end
  header.Modal=false
  cursorRelease()
 end
end
-- Panic stop: one key disables every automation, including a parry session
-- that is mid-swing, without unloading the hub or touching the character.
local function disableAll(reason)
 for _,module in pairs({MG,QA,BA,AP,GA,SR,AD}) do
  if module and module.setEnabled then pcall(module.setEnabled,false) end
 end
 H.broomSpeed=1
 resetBroom(1)
 armBroom()
 config.set("broomSpeed",1)
 refreshStatus()
 toast("Panic stop",reason or "All automation disabled")
end
H.panic=disableAll
local function handleHubKeys(i,processed)
 if not H.alive then return end
 local code=i.KeyCode
 -- A pending rebind consumes the next key, even one the game also uses.
 if bindingAction then
  if i.UserInputType==Enum.UserInputType.Keyboard and code then
   local target=bindingAction
   bindingAction=nil
   local row=hotkeyRows[target]
   if code==Enum.KeyCode.Escape then
    if row then row.Text=keyLabel(prefs.hotkeys[target]) end
    toast("Rebind cancelled","Kept "..keyLabel(prefs.hotkeys[target]))
   else
    if code~=Enum.KeyCode.Unknown and applyHotkey(target,code.Name) then
     toast("Hotkey bound",target.." · "..keyLabel(code.Name))
    end
   end
  end
  return
 end
 if processed or UIS:GetFocusedTextBox() then return end
 if code==Enum.KeyCode[prefs.hotkeys.toggle] then
  showPanel(not gui.Enabled)
 elseif code==Enum.KeyCode[prefs.hotkeys.minimize] then
  setMinimized(not minimized)
 elseif code==Enum.KeyCode[prefs.hotkeys.size] then
  cycleSize()
 elseif code==Enum.KeyCode[prefs.hotkeys.panic] then
  disableAll()
 end
end
connect(UIS.InputBegan,handleHubKeys)
H.testKeybind=handleHubKeys
H.isCursorActive=function() return cursorBound end
-- Low-health warning: one toast per life, re-armed once health recovers, so a
-- long fight cannot spam the corner.
local healthConnection,healthWarned
local function watchHealth(character)
 if healthConnection then healthConnection:Disconnect() healthConnection=nil end
 healthWarned=false
 local humanoid=character and character:FindFirstChildOfClass("Humanoid")
 if not humanoid then return end
 healthConnection=humanoid.HealthChanged:Connect(function(value)
  local maximum=humanoid.MaxHealth
  if maximum<=0 then return end
  local ratio=value/maximum
  if ratio<=0.3 and value>0 and not healthWarned then
   healthWarned=true
   toast("Low health",string.format("%.0f / %.0f · disengage",value,maximum))
  elseif ratio>0.5 then
   healthWarned=false
  end
 end)
end
H.testHealth=watchHealth
wireBroomCharacter(player.Character)
watchHealth(player.Character)
connect(player.CharacterAdded,function(char)
 task.defer(function()
  if not H.alive or char~=player.Character then return end
  wireBroomCharacter(char)
  watchHealth(char)
 end)
end)
function H.unload()
 if not H.alive then return end
 H.alive=false
 broomGeneration+=1
 if mountConnection then mountConnection:Disconnect() mountConnection=nil end
 if broomScaler then broomScaler:Disconnect() broomScaler=nil end
 if healthConnection then healthConnection:Disconnect() healthConnection=nil end
 detachBroomVelocity()
 savePanel()
 showPanel(false)
 if MG and MG.stop then MG.stop() end
 if QA and QA.stop then QA.stop() end
 if BA and BA.stop then BA.stop() end
 if AP and AP.stop then AP.stop() end
 if GA and GA.stop then GA.stop() end
 if SR and SR.stop then SR.stop() end
 if AD and AD.stop then AD.stop() end
 if config and config.stop then config.stop() end
 for _,c in ipairs(H.connections) do c:Disconnect() end
 table.clear(H.connections)
 for _,t in pairs(H.tweens) do t:Cancel() end
 table.clear(H.tweens)
 gui:Destroy()
 if G.VeyraController==H then G.VeyraController=nil end
end
connect(unload.Activated,H.unload)
showPanel(true)
return "Veyra ready"
