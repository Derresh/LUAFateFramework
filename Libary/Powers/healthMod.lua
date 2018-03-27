--{assert(0, "LUA")}--

require 'intCommon@lib:Fate'

local invoke = macro.args
local sel = type(invoke.token) == "string" and tokens.resolve(invoke.token) or invoke.token
local aspect = invoke.aspect
local slot = invoke.slot
local conDB = token.properties.conDB.converted

function conHeal()
	
	local i, j = string.find(aspect, "%(%d+%)$")
	local c = 0
	if (i) then
		c = tonumber(string.sub(aspect, i+1, j-1))
		aspect = string.sub(aspect, 0, i-1) 
	end
	conDB[slot] = aspect.." (H)"
	println(sel.name," Has started healing",aspect)	

end

function conTake()

	local r= input({content="Consequence Name", type="LABEL", span="TRUE"}, {type="TEXT", span=true, name="text"})
	macro.abort(r)
	conDB[slot] = r.text.." (1)"
	println(sel.name," Has taken a consequence ",aspect)		

	
end

function sHeal ()
	
	if slot == "PS" then
		local current = sel.properties.pStress.converted
		local i = invoke.num
		sel.properties.pStress.value = string.sub(current,1,i-1).."O"..string.sub(current,i+1)
	
	elseif slot == "MS" then 
		local current = sel.properties.mStress.converted
		local i = invoke.num
		sel.properties.mStress.value = string.sub(current,1,i-1).."O"..string.sub(current,i+1)
	else
		println("Error:Unsupported slot")
		println(toJSON(invoke))
	end

end

function sTake ()
	
	if slot == "PS" then
		local current = sel.properties.pStress.converted
		local i = invoke.num
		sel.properties.pStress.value = string.sub(current,1,i-1).."X"..string.sub(current,i+1)
						
	elseif slot == "MS" then 
		local current = sel.properties.mStress.converted
		local i = invoke.num
		sel.properties.mStress.value = string.sub(current,1,i-1).."X"..string.sub(current,i+1)
								
	else
		println("Error:Unsupported slot")
		println(toJSON(invoke))
	end

end

if invoke.mod == "heal" then conHeal()
elseif invoke.mod == "take" then conTake()
elseif invoke.mod == "sHeal" then sHeal()
elseif invoke.mod == "sTake" then sTake()
else
	println("Undefined")
	println(toJSON(invoke))
end

token.properties.conDB.value = conDB
intRefresh(invoke.frame)
