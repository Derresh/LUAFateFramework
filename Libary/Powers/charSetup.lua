--{assert(0, "LUA")}--

require 'intCommon@lib:Fate'

local data = macro.args


local target = tokens.resolve(data.token)

function npcHPset()

	local list = {"None", "Mild", "Moderate", "Severe", "Cripling", "Deadly"} 
	local p = target.properties.pStress.converted
	local m = target.properties.mStress.converted
	local conset = target.properties.conDB.converted
	local size = 0
	local eP = 0
	local eM = 0
	local eMob = 0
	
	if p == "Mob" or m == "Mob" then eMob = 1 end
	if conset.ModPhysical then eP = 1 conset.ModPhysical = nil end
	if conset.ModMental then eM = 1 conset.ModMental = nil end
	
	for j,test in ipairs(list) do 
		if conset[test] ~= nil then size = size+1 end
	end
	
	local r= input({content="NPC Health Setup", type="LABEL", span="TRUE"},
	{type="LIST", name="Physical", content={1,2,3,4,5,6,7,8,9,10}, select=string.len(p)-1},
	{type="LIST", name="Mental", content={1,2,3,4,5,6,7,8,9,10}, select=string.len(m)-1},
	{type="LIST", name="MaxCon", prompt="Maximum Consequence", content=list, select=size},
	{type="RADIO", name="ExtraPhysical", prompt="Extra Physical", content={"No","Yes"}, select=eP},
	{type="RADIO", name="ExtraMental",prompt="Extra Mental", content={"No","Yes"}, select=eM}, 
	{type="RADIO", name="Mob",prompt="Is this a Mob ?", content={"No","Yes"}, select=eMob}) 
	macro.abort(type(r.Physical)~="nummber")
	
	conset = {}
	p = "O"
	m = "O"
	if r.Mob ~= 1 then 
		for i=1,r.Physical do
			p = p.."O"
		end		
		for i=1,r.Mental do
			m = m.."O"
		end
		if r.MaxCon ~= 0 then
			for i=1,r.MaxCon+1 do
				local con = list[i]
				conset[con] = "Non Taken"
			end	
		end
		if r.ExtraPhysical == 1 then conset.ModPhysical = "Non Taken" end
		if r.ExtraMental == 1 then conset.ModMental = "Non Taken" end
	else
		p = "Mob"
		m = "Mob"
	end
	
	target.properties.pStress.value = p
	target.properties.mStress.value = m
	target.properties.conDB.value = conset
end

function pcSetup ()
	
	local r= input({type="LABEL",content="PC Basic Setup", span="TRUE"},
					{type="LIST", name="Refresh", content={1,2,3,4,5,6,7,8,9,10}, select=token.properties.Refresh.value-1},
					{type="LIST", name="Resources", content={0,1,2,3,4,5,6,7,8,9,10}, select=token.properties.Resources.value},
					{type="TEXT", name="HighConcept", prompt="Hight Concept", content=token.properties.HighConcept.value},
					{type="TEXT", name="Trouble", prompt="Trouble", content=token.properties.Trouble.value},
					{type="TEXT", name="APR", prompt="Race", content=token.properties.APR.value},
					{type="TEXT", name="AP1", prompt="Phase 1 Aspect", content=token.properties.AP1.value},
					{type="TEXT", name="AP2", prompt="Phase 2 Aspect", content=token.properties.AP2.value},
					{type="TEXT", name="AP3", prompt="Phase 3 Aspect", content=token.properties.AP3.value},
					{type="TEXT", name="APW", prompt="Weapon Aspect", content=token.properties.APW.value},
					{type="TEXT", name="APA", prompt="Armor Aspect", content=token.properties.APA.value})
	macro.abort(r)
	
	local vars = {"HighConcept", "Trouble", "APR", "AP1", "AP2", "AP3", "APW", "APA"}
	token.properties.Refresh = r.Refresh+1
	token.properties.Resources = r.Resources
	for i, pick in pairs(vars) do
		token.properties[pick].value = r[pick]
	end
	
end

function npcSetup()
local r= input({type="LABEL",content="NPC Basic Setup", span="TRUE"},
					{type="TEXT", name="HighConcept", prompt="Hight Concept", content=token.properties.HighConcept.value},
					{type="TEXT", name="Trouble", prompt="Trouble", content=token.properties.Trouble.value},
					{type="TEXT", name="APR", prompt="Race", content=token.properties.APR.value},
					{type="TEXT", name="AP1", prompt="Phase 1 Aspect", content=token.properties.AP1.value},
					{type="TEXT", name="AP2", prompt="Phase 2 Aspect", content=token.properties.AP2.value},
					{type="TEXT", name="AP3", prompt="Phase 3 Aspect", content=token.properties.AP3.value},
					{type="TEXT", name="APW", prompt="Weapon Aspect", content=token.properties.APW.value},
					{type="TEXT", name="APA", prompt="Armor Aspect", content=token.properties.APA.value})
	macro.abort(r)
	
	local vars = {"HighConcept", "Trouble", "APR", "AP1", "AP2", "AP3", "APW", "APA"}
	for i, pick in pairs(vars) do
		token.properties[pick].value = r[pick]
	end
end


if data.mode == "npcHP" then npcHPset()
elseif data.mode == "pcSet" then pcSetup()
elseif data.mode == "npcSet" then npcSetup()
elseif data.mode == "scanOn" then token.properties.Scanned.value = "Yes"
elseif data.mode == "scanOff" then token.properties.Scanned.value = "No"
else 
	println("ERROR: Unsupported mode in charSetup")
	println(toJSON(data))
end

intRefresh(data.frame)