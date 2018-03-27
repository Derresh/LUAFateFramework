--{assert(0, "LUA")}--

require 'intCommon@lib:Fate'
local target = tokens.selected()[1]
local data = macro.args


if data.mode == "give" and target.pc then
	target.properties.CurrentFP.value = target.properties.CurrentFP.value+1
	println("The GM has given a fate point to "..target.name)
elseif data.mode == "take" and target.pc then
	target.properties.CurrentFP.value = target.properties.CurrentFP.value-1
	println("The GM has taken a fate point from "..target.name)
elseif data.mode == "give" and target.npc then
	pcall(function() 
	tokens.getLibProperty("GMFP","lib:Fate").value = tokens.getLibProperty("GMFP","lib:Fate").value+1
	end)
	println("The GM has given themselves a fate point")
elseif data.mode == "take" and target.npc then
	pcall(function() 
	tokens.getLibProperty("GMFP","lib:Fate").value = tokens.getLibProperty("GMFP","lib:Fate").value-1
	end)
	println("The GM has taken a fate point from themself")
end