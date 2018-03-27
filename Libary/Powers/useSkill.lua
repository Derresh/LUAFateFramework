--{assert(0, "LUA")}--

require 'intCommon@lib:Fate'
require 'intDialog@lib:Fate'

local sel = tokens.selected()[1]
local skill = sel.properties.skillDB.converted
local conset = sel.properties.conSetup.converted
local data = macro.args

function skillRoll()
	local bonus = 7-data.bonus
	local name = data.skill
	diceRoller(name, "green", 4, bonus, nil)
end

function skillInt()
	skillV()
end


if data.mode=="skillUse" then skillV()
elseif data.mode=="skillRoll" then skillRoll()
else 
println("ERROR:Unsupported mode in useSkill.lua")
end