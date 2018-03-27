--{assert(0, "LUA")}--

require 'intCommon@lib:Fate'

local data = macro.args

function sceneReset()

	for j, sel in ipairs(tokens.visible()) do
		if sel.pc then
			local conDB = sel.properties.conDB.converted
			conDB.Mild = "Non Taken" 				
			sel.properties.conDB.value = conDB
		end
	end
	
	
	pcall(function() 
		tokens.getLibProperty("GMFP","lib:Fate").value = tokens.getLibProperty("PlayerCount","lib:Fate").converted
		end)
		
end

function sessionReset()

	for j, sel in ipairs(tokens.visible()) do
		if sel.pc then
		if sel.properties.CurrentFP.value < sel.properties.Refresh.value then sel.properties.CurrentFP.value = sel.properties.Refresh.value end
		local sdb = sel.properties.stuntsDB.converted
			for k, stunt in pairs(sdb) do
				if stunt.sType == "Session" then stunt.sUsed = "No" end
			end
		local conDB = sel.properties.conDB.converted
		local reset = {"Mild", "Moderate", "ModPhysical", "ModMental"}
			for i, slot in pairs(reset) do 
				if conDB[slot] and string.find(conDB[slot], "(H)") then
					conDB[slot] = "Non Taken" 				
				end
			end
			sel.properties.conDB.value = conDB
			sel.properties.stuntsDB.value = sdb		
			
		end
	end
		pcall(function() 
		tokens.getLibProperty("GMFP","lib:Fate").value = tokens.getLibProperty("PlayerCount","lib:Fate").value
		end)
end

function scenarioReset()

for j, sel in ipairs(tokens.visible()) do
		if sel.pc then
		if sel.properties.CurrentFP.value ~= sel.properties.Refresh.value then sel.properties.CurrentFP.value = sel.properties.Refresh.value end
		local sdb = sel.properties.stuntsDB.converted
			for k, stunt in pairs(sdb) do
				if stunt.sType == "Session" or  stunt.sType == "Scenario" then stunt.sUsed = "No" end
			end
		local reset = {"Mild", "Moderate", "ModPhysical", "ModMental", "Severe"}
		local conDB = sel.properties.conDB.converted
			for i, slot in pairs(reset) do 
				if conDB[slot] and string.find(conDB[slot], "(H)") then
					conDB[slot] = "Non Taken" 				
				end
			end
			sel.properties.conDB.value = conDB
			sel.properties.stuntsDB.value = sdb
			pcall(function() 
			tokens.getLibProperty("GMFP","lib:Fate").value = tokens.getLibProperty("PlayerCount","lib:Fate").value
			end)
		end
	end
			pcall(function() 
			tokens.getLibProperty("GMFP","lib:Fate").value = tokens.getLibProperty("PlayerCount","lib:Fate").value
			end)
end

function arcReset ()

for j, sel in ipairs(tokens.visible()) do
		if sel.pc then
		if sel.properties.CurrentFP.value ~= sel.properties.Refresh.value then sel.properties.CurrentFP.value = sel.properties.Refresh.value end
		local sdb = sel.properties.stuntsDB.converted
			for k, stunt in pairs(sdb) do
				if stunt.sType == "Session" or  stunt.sType == "Scenario" or stunt.sType == "Arc" then stunt.sUsed = "No" end
			end
		local conDB = sel.properties.conDB.converted
			for i, slot in pairs(reset) do 
				if conDB[slot] and string.find(conDB[slot], "(H)") then
					conDB[slot] = "Non Taken" 				
				end
			end
			sel.properties.conDB.value = conDB
			sel.properties.stuntsDB.value = sdb
						
		end
	end
			pcall(function() 
			tokens.getLibProperty("GMFP","lib:Fate").value = tokens.getLibProperty("PlayerCount","lib:Fate").value
			end)
end

if data.mode == "scene" then

	local output = [[<H2>New Scene</H2>
	Its a scene
	<br><br>   
	--Remove healing mild consequences.<br>
	--GM Recovers FP<br>
	<br>]]

	println(output)	
	sceneReset()

elseif data.mode == "session" then 

	local output = [[<H2>New Session</H2>
	A session is one sitting of play time.
	<br><br>   
	--Remove healing mild and moderate consequences.<br>
	--Reset session stunts.<br>
	--Set FP to refresh if FP is below refresh value.
	<br>]]

	println(output)	
	sessionReset()
elseif data.mode == "scenario" then 
	local output = [[<H2>New Scenario</H2>
	A scenario is the time it takes for a significant problem to be resolved, it consists of one or multiple sessions. Think of it as an episode of a TV show.<br><br>
	--Remove healing mild, moderate and severe consequences.
	--Reset scenario stunts.<br>
	--Set all FP values to refresh value.<br>
	<br>
	]]
	println(output)
	scenarioReset()
elseif data.mode == "arc" then

	local output = [[<H2>New Arc</H2><br>
	Change Arc End to New Arc and change tooltip text to "Reset all macros and FP values." and change display text to:
	An arc is the time it takes to resolve the major problem of the game. Think of it as a season of a TV show.<br><br>

	--Reset All Stunts<br>
	--Set all FP values to refresh value.<br>
	<br>]]
	println(output)
	 arcReset()
else 
	println("ERROR: Unsupported mode in gameReset.lua")
	println("Debug:<br>",toJSON(data))
end

intRefresh("tool")