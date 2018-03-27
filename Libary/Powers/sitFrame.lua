--{assert(0, "LUA")}--
	
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
<form name="Aspect Tracker" action="]]..macro.linkText("sitFrame@lib:Fate","none","", "selected")..[["><input type="submit" name="Refresh" value="Refresh"></form>
<table width='300' border='0'>
]]

local vars = {"HighConcept", "Trouble", "APR", "AP1", "AP2", "AP3", "APW", "APA"}
local order = {"Mild", "Moderate", "Severe", "Cripling", "Deadly", "ModPhysical", "ModMental"}

function mePC (sel)

	if sel.pc then
		output = output..[[<table width='300'><tr height='50'><td width="10%"><img width=50 height=50 src="]]..sel.image..[["></img></td><td><left><h2>]]..sel.name.."</left></h2></td></tr></table><table width='300'>"
			for i, prop in ipairs(vars) do  
			local value = sel.properties[prop].converted
				if value ~= "" then 
					if i % 2 == 0 then row = "evenRow" else row = "oddRow" end
					output = output..[[<tr valign="middle" class="]]..row..[["><td>]]..value..[[</td><td align='right' width="10%">]]..macro.link("Invoke", "invInit@lib:Fate", "all", {free=false, aspect=value, token=sel, slot=prop, frame="sit"}, "selected").."</td>"
				end
			end
		output = output.."</table>"
	end
	
end

function ListPC ()
	local list = tokens.visible()
	
	if tokens.impersonated() then
		for i, sel in ipairs(list) do if sel.id == tokens.impersonated().id then table.remove(list,i) end end
	end
		
	for j, sel in ipairs(list) do
		if sel.pc then
		output = output..[[<table width='300'><tr height='50'><td width="10%"><img width=50 height=50 src="]]..sel.image..[["></img></td><td><left><h2>]]..sel.name.."</left></h2></td></tr></table><table width='300'>"
			for i, prop in ipairs(vars) do  
			local value = sel.properties[prop].converted
				if value ~= "" then 
					if i % 2 == 0 then row = "evenRow" else row = "oddRow" end
					output = output..[[<tr valign="middle" class="]]..row..[["><td>]]..value..[[</td>]]
					output = output..[[<td align='right' width="10%">]]..macro.link("Compel", "compInit@lib:Fate", "all", {mode="start", aspect=value, target=sel.name, slot=prop, frame="sit"}, "selected").."</td>"
					if isGM() then output = output..[[<td align='right' width="10%">]]..macro.link("Invoke", "invInit@lib:Fate", "all", {free=false, aspect=value, token=sel, slot=prop, frame="sit"}, "selected").."</td>" end
					output = output.."</tr>"
				end			
			end
			if isGM() then
				local conDB = sel.properties.conDB.converted
				for i, key in pairs(order) do	
					local cout = ""
					local hasasp = false
					if conDB[key] and conDB[key] ~= "Non Taken" then					
						if i % 2 == 0 then row = "evenRow" else row = "oddRow" end
						cout = cout..[[<tr valign="middle" class="]]..row..[["><td width="85%">]]..conDB[key].."</td>" 
						hasasp = true
						local k, j = string.find(conDB[key], "%(%d+%)$")
						local c = 0
						if (k) then
							c = tonumber(string.sub(conDB[key], k+1, j-1))
						end
						cout = cout.."<td align='right'>"..macro.link("Invoke", "invInit@lib:Fate", "all", {free=false, aspect=conDB[key], token=sel, slot=key, frame="sit"}, "selected").."</td>"
						if c and c > 0 then cout = cout.."<td align='right'>"..macro.link("Free", "invInit@lib:Fate", "all", {free=true, aspect=conDB[key], token=sel, slot=key, frame="sit"}, "selected").."</td>" end
						cout = cout.."</tr>"
					if hasasp then output = output..cout end
				end
			end
		end			
	output = output.."</table>"
	end
	end
end



function ListNPC ()
	local list = tokens.visible()
	for j, sel in ipairs(list) do		
		if sel.npc and sel.gmName ~= "Ignore" then
			output = output..[[<table width='300'><tr height='50'><td width="10%"><img width=50 height=50 src="]]..sel.image..[["></img></td><td><left><h2>]]..sel.name.."</left></h2></td></tr></table><table width='300'>"
			if isGM() or sel.properties.Scanned.value == "Yes" then				
				for i, prop in ipairs(vars) do  
				local value = sel.properties[prop].converted
					if value ~= "" then 
						if i % 2 == 0 then row = "evenRow" else row = "oddRow" end
						output = output..[[<tr valign="middle" class="]]..row..[["><td>]]..value..[[</td>]]
						if isGM() then output = output..[[<td align='right' width="10%">]]..macro.link("Compel", "invInit@lib:Fate", "all", {free=false, mode="compel", aspect=value, token=sel, slot=prop, frame="sit"}, "selected").."</td>" end
						output = output..[[<td align='right' width="10%">]]..macro.link("Invoke", "invInit@lib:Fate", "all", {free=false, aspect=value, token=sel, slot=prop, frame="sit"}, "selected").."</td>" 
						output = output.."</tr>"
					end			
				end
			end
				local conDB = sel.properties.conDB.converted
				for i, key in ipairs(order) do
				local hasasp = false
				local cout = ""
				if conDB[key] and conDB[key] ~= "Non Taken" then					
					if i % 2 == 0 then row = "evenRow" else row = "oddRow" end
					cout = cout..[[<tr valign="middle" class="]]..row..[["><td width="85%">]]..conDB[key].."</td>" 
					hasasp = true
					local k, j = string.find(conDB[key], "%(%d+%)$")
					local c = 0
					if (k) then
						c = tonumber(string.sub(conDB[key], k+1, j-1))
					end
					cout = cout.."<td align='right'>"..macro.link("Invoke", "invInit@lib:Fate", "all", {free=false, aspect=conDB[key], token=sel, slot=key, frame="sit"}, "selected").."</td>"
					if c and c > 0 then cout = cout.."<td align='right'>"..macro.link("Free", "invInit@lib:Fate", "all", {free=true, aspect=conDB[key], token=sel, slot=key, frame="sit"}, "selected").."</td>" end
					cout = cout.."</tr>"
				if hasasp then output = output..cout end
				end
			end
		end			
	output = output.."</table>"
	end
	end


function ListSit ()
	local c = 0;
	output = output.."<table width='300'><tr height='50'><td colspan='4'><center><h2>Situational Aspects</center></h2></td></tr>"
		for h, asp in ipairs(tokens.getLibProperty("SitAspect","lib:Fate").converted) do
			if isGM() or not string.startsWith(asp, "!") then
				if c % 2 == 0 then row = "evenRow" else row = "oddRow" end
				output = output.."<tr valign=\"middle\" class=\""..row.."\"><td colspan='3'>"..asp.."</td>" 
				c = c+1
				local k, j = string.find(asp, "%(%d+%)$")
				local a = 0
				if (k) then
					a = tonumber(string.sub(asp, k+1, j-1))
				end
				output = output.."<td align='right'>"..macro.link("Invoke", "invInit@lib:Fate", "all", {free=false, aspect=asp, token=nil, slot=c, frame="sit"},"selected").."</td>"
				if a and a > 0 then
					output = output.."<td align='right'>"..macro.link("Free", "invInit@lib:Fate", "all", {free=true, aspect=asp, token=nil, slot=c, frame="sit"},"selected").."</td>"
				end
				output = output.."</tr>"
			end	
		end 
	output = output.."</table>"
end

if tokens.impersonated() then mePC(tokens.impersonated()) end
ListSit()
ListPC()
ListNPC()




UI.frame("Aspect Tracker",output,"width=200; height=300; temporary=1")