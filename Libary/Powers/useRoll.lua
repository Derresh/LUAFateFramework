--{assert(0, "LUA")}--

require 'intCommon@lib:Fate'

local data=macro.args

if data.mode == "rNormal" then diceRoller ("Normal", "gray", 4, nil, nil)

elseif data.mode == "rAttack" or data.mode == "rDefend" then

	local list = {}
	local modifier = {}
	local skillDB = token.properties.skillDB.converted
	skillDB.Untrained  = {"Untrained"}
	local mods = {Untrained = 0, Average = 1, Fair = 2, Good = 3, Great = 4, Superb = 5, Fantastic = 6}
	local last = 0
	local pick = 0

	for mod, skills in pairs(skillDB) do
		for i, skill in ipairs(skills) do
			table.insert(list, skill)
			modifier[skill]=mod
		end
	end

	local label = "Pick skill to "
	local dlabel = "Number of "
	if data.mode == "rAttack" then 
		label = label.."Attack with"
		dlabel = dlabel.."red dice"
		lastD = token.properties.LastRed.value
		lastS = token.properties.LastAttack.value
	elseif data.mode == "rDefend" then 
		label = label.."Defend with"
		dlabelD = dlabel.."blue dice"
		lastD = token.properties.LastBlue.value
		lastS = token.properties.LastDefend.value		
	end
	
	pick = table.indexOf(list, lastS)-1
	
	local r= input({content=label, type="LABEL", span="TRUE"}, {type="LIST", VALUE="STRING", content=list, span=true, name="Selection", Icon=true, select=pick}, {type="LIST", name="sDice", prompt=dlabel, content={0,1,2,3,4}, select=lastD})
		
	if data.mode == "rAttack" then
		local call = "Attack with "..r.Selection
		diceRoller (call, "red", 4, mods[modifier[r.Selection]], r.sDice)
		token.properties.LastAttack = r.Selection
		token.properties.LastRed = r.sDice
	elseif data.mode == "rDefend" then
		local call = "Defend with "..r.Selection
		diceRoller (call, "blue", 4, mods[modifier[r.Selection]], r.sDice)
		token.properties.LastDefend = r.Selection
		token.properties.LastBlue = r.sDice
	end

else
	println("ERROR: Unsupported Mode in useRoll.lua")
	println("DEBUG:<br>",toJSON(data))
end