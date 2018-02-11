--{assert(0, "LUA")}--

require 'intCommon@lib:Fate'

local picks = {}
	picks.pc = {"HighConcept", "Trouble", "APR", "AP1", "AP2", "AP3", "APW", "APA"}
	picks.pccon = {"MildC", "ModC", "Sevc", "CripC", "DeadC"} 
	picks.pcconf = {"Mild", "Moderate", "Severe", "Cripling", "Deadly"}
	
local sel = tokens.selected()[1]
if not sel then sel=token end 

-- init css and frame
local output = [[
<html>

<style>

table {
	width: 250px;
	align: left;
	border: 1px solid black;
}
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
.redevenRow {
	color: #FFFFFF;
	background-color:#FF0000; 
}
.redoddRow {
	color: #FFFFFF;
	background-color:#FF8080; 
}
.blueevenRow {
	color: #FFFFFF;
	background-color:#0000FF; 
}
.blueoddRow {
	color: #FFFFFF;
	background-color:#8080FF; 
}
.sRow1 {
	text-align: center;
	
}
tr.sRowSmall {
	text-align: center;
	height: 15px;
}
tr.sRowBig {
	text-align: center;
	height: 25px;
}
td.sCol {
	text-align: center;
	width: 25px;
}
a img {
	border: none;
	outline : none;
}


</style>
<body>
<form name="Character Sheet" action="]]..macro.linkText("charFrame@lib:Fate")..[["><input type="submit" name="Refresh" value="Refresh"></form>
<link rel='onChangeSelection' type='macro' href=']]..macro.linkText("charFrame@lib:Fate")..[['>
]]

--header build
function pcNametag()

output = output.."<table><tr height='150'><td><table width='150'><tr align='center'><td colspan='2'><left><h2>"..sel.name.."</left></h2></td></tr><tr><td>Fate Points</td><td>Refresh</td></tr><tr align='center'><td>"..sel.properties.CurrentFP.value.."</td><td>"..sel.properties.Refresh.value.."</td></tr></table></td><td width=\"10\%\"><img width=150 height=150 src='"..sel.portrait.."'></img></td></tr></table>"

end 

--Render Sress boxes
function renderStress()

local pStress = sel.properties.pStress.converted
local mStress = sel.properties.mStress.converted
local pCount = string.len(pStress)
local mCount = string.len(mStress)
local size = 1

if pCount > size then size = pCount end
if mCount > size then size = mCount end

output = output.."<table  border='1'><th colspan='"..size.."'>Physical Stress</th><tr class='sRow1'>"
	--Count Row
	for i=1,size do
		output = output.."<td class='sCol'>"..i.." Shift</td>"
	end
output = output.."</tr><tr class='sRowSmall'>"
	--Physical Take Row
	for i=1,pCount do
		if string.sub(pStress,i,i) == "O" then
			output = output.."<td align='center'><a href='"..macro.linkText("healthMod@lib:Fate", "all", {mod="sTake", token=sel, slot="PS", num=i, frame="char"}, isGM() and "selected" or "impersonated").."'<img width=15 height=15 src='"..iconRender(2).."'></a></td>"
		else
			output = output.."<td align='center'><img width=25 height=15 src='"..iconRender(2).."'></td>"
		end
	end
output = output.."</tr><tr class='sRowBig'>"
	--Physical Stress Row
	for i=1,pCount do
		local j = "5"
		if string.sub(pStress,i,i) == "X" then j=4 else j=1 end		
		output = output.."<td align='center'><img width=25 height=25 src='"..iconRender(j).."'></td>"
	end
output = output.."</tr><tr class='sRowSmall'>"
	--Physical Heal Row
	for i=1,pCount do
		if string.sub(pStress,i,i) == "X" then
			output = output.."<td align='center'><a href='"..macro.linkText("healthMod@lib:Fate", "all", {mod="sHeal", token=sel, slot="PS", num=i, frame="char"}, isGM() and "selected" or "impersonated").."'<img width=15 height=15 src='"..iconRender(3).."'></a></td>"
		else
			output = output.."<td align='center'><img width=15 height=15 src='"..iconRender(3).."'></td>"
		end
	end
output = output.."</tr><th colspan='"..size.."'>Mental Stress</th><tr class='sRow1'>"
	--Mental Take Row
	for i=1,mCount do
		if string.sub(mStress,i,i) == "O" then
			output = output.."<td align='center'><a href='"..macro.linkText("healthMod@lib:Fate", "all", {mod="sTake", token=sel, slot="MS", num=i, frame="char"}, isGM() and "selected" or "impersonated").."'<img width=15 height=15 src='"..iconRender(2).."'></a></td>"
		else
			output = output.."<td align='center'><img width=15 height=15 src='"..iconRender(2).."'></td>"
		end
	end
output = output.."</tr><tr class='sRowBig'>"
	--Mental Stress Row
	for i=1,mCount do
		local j = "5"
		if string.sub(mStress,i,i) == "X" then j=4 else j=1 end		
		output = output.."<td align='center'><img width=25 height=25 src='"..iconRender(j).."'></td>"
	end
output = output.."</tr><tr class='sRowSmall'>"
	--Mental Heal Row
	for i=1,mCount do
		if string.sub(mStress,i,i) == "X" then
			output = output.."<td align='center'><a href='"..macro.linkText("healthMod@lib:Fate", "all", {mod="sHeal", token=sel, slot="MS", num=i, frame="char"}, isGM() and "selected" or "impersonated").."'<img width=15 height=15 src='"..iconRender(3).."'></a></td>"
		else
			output = output.."<td align='center'><img width=15 height=15 src='"..iconRender(3).."'></td>"
		end
	end
	
output = output.."</tr></table>"
end

--list consequences
function PlayerCon()



	output = output.."<table><th colspan='3'>Consequence</th>"
		for i, prop in ipairs(picks.pccon) do  
		local value = sel.properties[prop].value
			if value ~= "" and string.find(value, "(H)") then			
				if i % 2 == 0 then row = "blueevenRow" else row = "blueoddRow" end
				output = output.."<tr valign=\"middle\" class=\""..row.."\"><td>"..picks.pcconf[i].."</td><td colspan='2'>"..value.."</td>"				
			elseif value ~= "" then
				if i % 2 == 0 then row = "redevenRow" else row = "redoddRow" end
				output = output.."<tr valign=\"middle\" class=\""..row.."\"><td>"..picks.pcconf[i].."</td><td>"..value.."</td><td align='right'>"..macro.link("Heal", "healthMod@lib:Fate", "all", {mod="heal", aspect=value, token=sel, slot=prop, frame="char"}, isGM() and "selected" or "impersonated").."</td>"
			else
				if i % 2 == 0 then row = "evenRow" else row = "oddRow" end
				output = output.."<tr valign=\"middle\" class=\""..row.."\"><td>"..picks.pcconf[i].."</td><td>Non Taken</td><td align='right'>"..macro.link("Take", "healthMod@lib:Fate", "all", {mod="take", aspect=value, token=sel, slot=prop, frame="char"}, isGM() and "selected" or "impersonated").."</td>"
			end
		end	
	output = output.."</table>"
end

--list player aspects
function PlayerList ()

	output = output.."<table><th colspan='3'>Aspects</th>"
	
	for i, prop in ipairs(picks.pc) do  
		local value = sel.properties[prop].value
		if value ~= "" then
			if i % 2 == 0 then row = "evenRow" else row = "oddRow" end
			output = output.."<tr valign=\"middle\" class=\""..row.."\"><td colspan='2'>"..value.."</td><td align='right'>"..macro.link("Invoke", "invInit@lib:Fate", "all", {free=false, aspect=value, token=sel, slot=prop, frame="char"}, isGM() and "selected" or "impersonated").."</td>"
		end
	end
	output = output.."</table>"
end


if token.PC then
 pcNametag()
 renderStress()
 PlayerCon()
 PlayerList()
 end



UI.frame("Character Sheet",output,"width=250; height=500; temporary=1")