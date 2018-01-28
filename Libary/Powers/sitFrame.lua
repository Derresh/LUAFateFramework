--{assert(0, "LUA")}--

local picks = {}
	picks.pc = {"HighConcept", "Trouble", "APR", "AP1", "AP2", "AP3", "APW", "APA", "MildC", "MildCPH", "MildCWI", "ModC", "Sevc", "CripC", "DeadC"}
	picks.npc = {"MildC", "MildCPH", "MildCWI", "ModC", "Sevc", "CripC", "DeadC"}
	
	
local output = [[
<html>

<style>
td {
	padding: 0px;
}
th {
	padding: 0px;
}
.litUpRow {
	background-color: rgb(255, 166, 166);
}
.oddRow {
	background-color: rgb(255, 255, 255); 
}
.evenRow {
	background-color: rgb(239, 246, 254); 
}
</style>
<body>
<form name="Aspect Tracker" action="]]..macro.linkText("sitFrame@lib:Fate","none","",isGM() and "selected" or "impersonated")..[["><input type="submit" name="Refresh" value="Refresh"></form>
<table width='300' border='0'>
]]

function PlayerList ()

	local selected = tokens.selected()[1]
	output = output.."<tr height='50'><td width=\"10\%\"><img width=50 height=50 src='"..selected.image.."'></img></td><td colspan='2'><left><h2>"..selected.name.."</left></h2></td></tr>"
	
	for i, prop in ipairs(picks.pc) do  
		local value = selected.properties[prop].value
		if value ~= "" then
			if i % 2 == 0 then row = "evenRow" else row = "oddRow" end
			output = output.."<tr valign=\"middle\" class=\""..row.."\"><td colspan='2'>"..value.."</td><td align='right'>"..macro.link("Invoke", "invInit@lib:Fate", "all", {free=false, aspect=value, token=selected, slot=prop}, isGM() and "selected" or "impersonated").."</td>"
		end
	end
end

function NPCList ()
	for j, sel in ipairs(tokens.visible()) do
		if sel.npc then
			local cout = "<tr height='50'><td width='50'><img width=50 height=50 src='"..sel.image.."'></img></td><td colspan='2'><left><h2>"..sel.name.."</left></h2></td></tr>"
			local hasasp = false
			for i, prop in ipairs(picks.npc) do		
				local value = sel.properties[prop].value
				if value ~= "" then
					if i % 2 == 0 then row = "evenRow" else row = "oddRow" end
					cout = cout.."<tr valign=\"middle\" class=\""..row.."\"><td colspan='2' width='85%'>"..value.."</td>" 
					hasasp = true
					local k, j = string.find(value, "%(%d+%)$")
					local c = 0
					if (k) then
						c = tonumber(string.sub(value, k+1, j-1))
					end
					cout = cout.."<td align='right'>"..macro.link("Invoke", "invInit@lib:Fate", "all", {free=false, aspect=value, token=sel, slot=prop}, isGM() and "selected" or "impersonated")
					if c and c > 0 then
						cout = cout.." "..macro.link("Free", "invInit@lib:Fate", "all", {free=true, aspect=value, token=sel, slot=prop}, isGM() and "selected" or "impersonated")
					end
					cout = cout.."</td></tr>"
				end
			end
			if hasasp then output = output..cout end
		end
	end
end

function SitList ()
	local c = 0;
	output = output.."<tr height='50'><td colspan='3'><center><h2>Situational Aspects</center></h2></td></tr>"
		for h, asp in ipairs(tokens.getLibProperty("SitAspect","lib:Fate").converted) do
			if isGM() or not string.startsWith(asp, "!") then
			if c % 2 == 0 then row = "evenRow" else row = "oddRow" end
			output = output.."<tr valign=\"middle\" class=\""..row.."\"><td colspan='2'>"..asp.."</td>" 
			c = c+1
			local k, j = string.find(asp, "%(%d+%)$")
			local c = 0
			if (k) then
				c = tonumber(string.sub(asp, k+1, j-1))
			end
			output = output.."<td align='right'>"..macro.link("Invoke", "invInit@lib:Fate", "all", {free=false, aspect=asp, token=nil, slot=c}, isGM() and "selected" or "impersonated")
			if c and c > 0 then
				output = output.." "..macro.link("Free", "invInit@lib:Fate", "all", {free=true, aspect=asp, token=nil, slot=c}, isGM() and "selected" or "impersonated")
			end
			output = output.."</td></tr>"
		end
	end 
end


PlayerList ()
NPCList ()
SitList ()

output = output.. "</table>"

UI.frame("Aspect Tracker",output,"width=200; height=300; temporary=1")