-- Veyra settings store: JSON preferences with debounced, best-effort autosave.
-- Only preferences are persisted. Every automation toggle still starts off, so
-- a stale file can never arm a feature without a click.
local G=getgenv()
if G.VeyraConfig then G.VeyraConfig.stop() end
local HttpService=game:GetService("HttpService")
local state={alive=true,values={},dirty=false,loaded=false,path="Veyra/config.json",lastError=nil}
G.VeyraConfig=state

local function copy(value)
 if type(value)~="table" then return value end
 local out={}
 for key,item in pairs(value) do out[key]=copy(item) end
 return out
end

-- Merge saved values over defaults, keeping the default's type so a corrupted
-- or hand-edited file cannot turn a number into a table or a string into nil.
local function merge(defaults,saved)
 local out={}
 for key,default in pairs(defaults) do
  local value
  if type(saved)=="table" then value=saved[key] end
  if type(default)=="table" then
   out[key]=merge(default,type(value)=="table" and value or nil)
  elseif value~=nil and type(value)==type(default)
   and (type(value)~="number" or (value==value and math.abs(value)<math.huge)) then
   out[key]=value
  else
   out[key]=default
  end
 end
 return out
end

local scheduled=false
function state.schedule()
 if scheduled then return end
 scheduled=true
 task.delay(0.5,function()
  scheduled=false
  if state.alive and state.dirty then state.flush() end
 end)
end

function state.load(defaults)
 state.defaults=copy(defaults or {})
 local saved=nil
 if type(readfile)=="function" then
  local ok,raw=pcall(readfile,state.path)
  if ok and type(raw)=="string" and #raw>0 then
   local decoded
   local okDecode,result=pcall(function() return HttpService:JSONDecode(raw) end)
   if okDecode then decoded=result end
   if type(decoded)=="table" then
    saved=decoded
    state.loaded=true
   else
    state.lastError="config could not be parsed"
   end
  end
 end
 state.values=merge(state.defaults,saved)
 return state.values
end

function state.get(key,fallback)
 local value=state.values[key]
 if value==nil then return fallback end
 return value
end

function state.set(key,value)
 state.values[key]=value
 state.dirty=true
 state.schedule()
end

function state.patch(key,partial)
 local base=state.values[key]
 if type(base)~="table" then
  base={}
  state.values[key]=base
 end
 for field,value in pairs(partial or {}) do base[field]=value end
 state.dirty=true
 state.schedule()
end

function state.flush()
 if not state.dirty then return true end
 if type(writefile)~="function" then
  state.dirty=false
  state.lastError="writefile unavailable"
  return false
 end
 local ok,encoded=pcall(function() return HttpService:JSONEncode(state.values) end)
 if not ok or type(encoded)~="string" then
  state.lastError="config could not be encoded"
  return false
 end
 if type(makefolder)=="function" then pcall(makefolder,"Veyra") end
 local wrote=pcall(writefile,state.path,encoded)
 state.dirty=not wrote
 state.lastError=not wrote and "config could not be written" or nil
 return wrote
end

function state.reset(defaults)
 state.values=copy(defaults or state.defaults or {})
 state.dirty=true
 state.flush()
 return state.values
end

function state.stop()
 if not state.alive then return end
 state.alive=false
 state.flush()
 if G.VeyraConfig==state then G.VeyraConfig=nil end
end

return state
