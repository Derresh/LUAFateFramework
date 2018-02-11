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