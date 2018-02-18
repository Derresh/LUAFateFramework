--{assert(0, "LUA")}--

function intRefresh(frame)
	if frame == "char" then macro.call("charFrame@lib:Fate") 
	elseif frame == "sti" then macro.call("sitFrame@lib:Fate") 
	else println("ERROR: Unsupported interface element")
	end
end
	
function iconRender (icon)
	export("die", icon)
	local icon = eval("tableimage(\"Icons\", die)")
	return icon
end

function colorPick (name)
	local s = tokens.selected()[1]
	local pick = s.properties.stuntsDB.converted
	local t = pick[name].sType
	local u = pick[name].sUsed
	local color = {}
	color.face = ""
	color.bg = ""
	color.pos = ""
	
	if t == "Normal" then color.face="white" color.bg="green" color.pos = 1
	elseif t == "Aspect" then color.face="white" color.bg="red" color.pos = 2
	elseif t == "Race" then color.face="white" color.bg="blue" color.pos = 3
	elseif t == "Item" then color.face="white" color.bg="orange" color.pos = 4
	elseif t == "Session" and u == "No" then color.face="black" color.bg="lime" color.pos = 5
	elseif t == "Session" and u == "Yes" then color.face="lime" color.bg="black" color.pos = 5
	elseif t == "Scenario" and u == "No" then color.face="white" color.bg="purple" color.pos = 6
	elseif t == "Scenario" and u == "Yes" then color.face="purple" color.bg="black" color.pos = 6
	elseif t == "Arc" and u == "No" then color.face="red" color.bg="silver" color.pos = 7
	elseif t == "Arc" and u == "Yes" then color.face="silver" color.bg="black" color.pos = 7
	else color.face="black" color.bg="white" end

return color
end