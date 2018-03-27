--{assert(0, "LUA")}--

require 'intCommon@lib:Fate'

local picks = {}
	picks.pc = {"HighConcept", "Trouble", "APR", "AP1", "AP2", "AP3", "APW", "APA"}
	picks.pccon = {"MildC", "ModC", "Sevc"} 
	picks.pcconf = {"Mild", "Moderate", "Severe", "Cripling", "Deadly"}
	
local sel = tokens.selected()[1]

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
.NormalEvenRow {
	background-color: #bfdecb;
}
.NormalOddRow {
	background-color: #cce5cc;
}
.AspectEvenRow {
	background-color: #f2c4cb;
}
.AspectOddRow {
	background-color: #ffcccc;
}
.RaceEvenRow {
	background-color: #bfc4fe;
}
.RaceOddRow {
	background-color: #ccccff;
}
.ItemEvenRow {
	background-color: #f2e5cb;
}
.ItemOddRow {
	background-color: #ffedcc;
}
.SessionEvenRow {
	background-color: #bff7cb;
}
.SessionOddRow {
	background-color: #ccffcc;
}
.SessionEvenRowUsed {
	background-color: #bfc4cb;
	color: #008000;
}
.SessionOddRowUsed {
	background-color: #cccccc;
	color: #008000;
}
.ScenarioEvenRow {
	background-color: #d8c4e4;
}
.ScenarioOddRow {
	background-color: #e5cce5;
}
.ScenarioEvenRowUsed {
	background-color: #bfc4cb;
	color: purple;
}
.ScenarioOddRowUsed {
	background-color: #cccccc;
	color: purple;
}
.ArcEvenRow {
	background-color: #e5ebf1;
}
.ArcOddRow {
	background-color: #f2f2f2;
}
.ArcEvenRowUsed {
	background-color: #bfc4cb;
	color:#808080;
}
.ArcOddRowUsed {
	background-color: #cccccc;
	color:#808080;
}

</style>
<body>
<form name="Character Sheet" action="]]..macro.linkText("charFrame@lib:Fate", "None", {}, "selected")..[["><input type="submit" name="Refresh" value="Refresh"></form>
<link rel='onChangeSelection' type='macro' href=']]..macro.linkText("charFrame@lib:Fate", "None", {}, "selected")..[['>
]]

--header build
function Nametag()

	if sel.pc then 
	cFP = sel.properties.CurrentFP.value
	cRe = sel.properties.Refresh.value
	smode = "pcSet"
	else
	cFP = tokens.getLibProperty("GMFP","lib:Fate").converted
	cRe = "GM"
	smode = "npcSet"
	end
output = output.."<table><tr height='150'><td><table width='150'>"
output = output.."<tr><td align='right' colspan='2'>"..macro.link("Setup", "charSetup@lib:Fate", "none", {token=sel, mode=smode, frame="char"}, token).."</td></tr><tr align='center'><td colspan='2'><left><h2>"..sel.name
output = output.."</left></h2></td></tr><tr><td align='center'>Fate Points</td><td align='center'>Refresh</td></tr><tr align='center'><td>"..cFP.."</td><td>"..cRe.."</td></tr>"
if sel.pc then output = output.."<tr><td align='right'>Resources:</td><td align='center'>"..sel.properties.Resources.value.."</td></tr>" else output = output.."<tr></tr>" end
output = output.."<tr><td align='center'><a href='"..macro.linkText("useRoll@lib:Fate", "all", {mode="rAttack", token=sel, frame="char"}, isGM() and "selected" or "impersonated").."'<img width=72 height=25 src='"..iconRender(7).."'></a></td><td align='center'><a href='"..macro.linkText("useRoll@lib:Fate", "all", {mode="rDefend", token=sel, frame="char"}, isGM() and "selected" or "impersonated").."'<img width=72 height=25 src='"..iconRender(8).."'></a></td></tr>"
output = output.."<tr><td colspan ='2' align='center'><a href='"..macro.linkText("useSkill@lib:Fate", nil, {mode="skillUse", token=sel, frame="char"}, isGM() and "selected" or "impersonated").."'<img width=150 height=25 src='"..iconRender(5).."'></a></td></tr>"
output = output.."<tr><td colspan ='2' align='center'><a href='"..macro.linkText("useRoll@lib:Fate", "all", {mode="rNormal", token=sel, frame="char"}, isGM() and "selected" or "impersonated").."'<img width=150 height=25 src='"..iconRender(6).."'></a></td></tr>"
output = output.."<tr><td colspan ='2' align='center'><a href='"..macro.linkText("sitFrame@lib:Fate", nil, {mode="rNormal", token=sel, frame="char"}, isGM() and "selected" or "impersonated").."'<img width=150 height=25 src='"..iconRender(9).."'></a></td></tr></table>"
output = output.."</td><td width='10%'><img width=150 height=150 src='"..sel.portrait.."'></img></td></tr></table>"

end 

--Render Sress boxes
function renderStress()

local pStress = sel.properties.pStress.converted
local mStress = sel.properties.mStress.converted
local pCount = string.len(pStress)
local mCount = string.len(mStress)
local size = 1

if pStress == "Mob" or mStress =="Mob" then

	output = output.."<table border='1'><tr><td align='right'>"..macro.link("Setup Health", "charSetup@lib:Fate", "none", {token=sel, mode="view", mode="npcHP", frame="char"}, token).."</td></tr>"
	output = output..[[<th>Mob</th><tr><td>This creature is a mob, it follows mob rules, in that it has no skills higher than +1 and is defeated in one successful hit.
	Mobs can clump together to gain strength, making their rolls the same as their numbers, these numbers increase/decrease with size. When a mob forms, they take either the highest inititive, or roll their inititive at the start, combining their scores as nornal.
	Mobs only have one turn per exchange, unless otherwise noted, sacrificing more turns for more power.
	</td></tr></table>
	]]

else

	if pCount > size then size = pCount end
	if mCount > size then size = mCount end

	output = output.."<table  border='1'>"

	if sel.NPC and isGM() then
		output = output.."<tr><td colspan='"..size.."' align='right'>"..macro.link("Setup Health", "charSetup@lib:Fate", "none", {token=sel, mode="view", mode="npcHP", frame="char"}, token).."</td></tr>"
		output = output.."<th colspan='"..size.."'>Physical Stress</th><tr class='sRow1'>"	
	else
		output = output.."<tr></tr><th colspan='"..size.."'>Physical Stress</th><tr class='sRow1'>"
	end

	--Count Row
		for i=1,size do
			output = output.."<td class='sCol'>"..i.." Shift</td>"
		end
	output = output.."</tr><tr class='sRowSmall'>"
		--Physical Take Row
		for i=1,pCount do
			if string.sub(pStress,i,i) == "O" then
				output = output.."<td align='center'><a href='"..macro.linkText("healthMod@lib:Fate", nil, {mod="sTake", token=sel, slot="PS", num=i, frame="char"}, isGM() and "selected" or "impersonated").."'<img width=15 height=15 src='"..iconRender(2).."'></a></td>"
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
				output = output.."<td align='center'><a href='"..macro.linkText("healthMod@lib:Fate", nil, {mod="sHeal", token=sel, slot="PS", num=i, frame="char"}, isGM() and "selected" or "impersonated").."'<img width=15 height=15 src='"..iconRender(3).."'></a></td>"
			else
				output = output.."<td align='center'><img width=15 height=15 src='"..iconRender(3).."'></td>"
			end
		end
	output = output.."</tr><th colspan='"..size.."'>Mental Stress</th><tr class='sRow1'>"
		--Mental Take Row
		for i=1,mCount do
			if string.sub(mStress,i,i) == "O" then
				output = output.."<td align='center'><a href='"..macro.linkText("healthMod@lib:Fate", nil, {mod="sTake", token=sel, slot="MS", num=i, frame="char"}, isGM() and "selected" or "impersonated").."'<img width=15 height=15 src='"..iconRender(2).."'></a></td>"
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
				output = output.."<td align='center'><a href='"..macro.linkText("healthMod@lib:Fate", nil, {mod="sHeal", token=sel, slot="MS", num=i, frame="char"}, isGM() and "selected" or "impersonated").."'<img width=15 height=15 src='"..iconRender(3).."'></a></td>"
			else
				output = output.."<td align='center'><img width=15 height=15 src='"..iconRender(3).."'></td>"
			end
		end		
	output = output.."</tr></table>"
	end
end

--list consequences
function renCon()

local order = {"Mild", "Moderate", "Severe", "Cripling", "Deadly", "ModPhysical", "ModMental"} 
local conDB = sel.properties.conDB.converted
	output = output.."<table><th colspan='3'>Consequence</th>"
		for c, key in pairs(order) do
		if conDB[key] then
				if conDB[key] ~= "" and string.find(conDB[key], "(H)") then			
					if c % 2 == 0 then row = "blueevenRow" else row = "blueoddRow" end
					output = output.."<tr valign=\"middle\" class=\""..row.."\"><td>"..key.."</td><td colspan='2'>"..conDB[key].."</td>"				
				elseif conDB[key] ~= "Non Taken" then
					if c % 2 == 0 then row = "redevenRow" else row = "redoddRow" end
					output = output.."<tr valign=\"middle\" class=\""..row.."\"><td>"..key.."</td><td>"..conDB[key].."</td><td align='right'>"..macro.link("Heal", "healthMod@lib:Fate", "all", {mod="heal", aspect=conDB[key], token=sel, slot=key, frame="char"}, isGM() and "selected" or "impersonated").."</td>"
				else
					if c % 2 == 0 then row = "evenRow" else row = "oddRow" end
					output = output.."<tr valign=\"middle\" class=\""..row.."\"><td>"..key.."</td><td>Non Taken</td><td align='right'>"..macro.link("Take", "healthMod@lib:Fate", "all", {mod="take", aspect=conDB[key], token=sel, slot=key, frame="char"}, isGM() and "selected" or "impersonated").."</td>"
				end
			end
		end	
	output = output.."</table>"
end

--list player aspects
function PlayerList ()

	output = output.."<table><th colspan='3'>Aspects"
	
	
	if isGM() and sel.npc and token.properties.Scanned.value == "No" then output = output.." - PC Hidden</th><tr><td align='right' colspan='3'>"..macro.link("Show Aspects", "charSetup@lib:Fate", "none", {mode="scanOn", token=sel, frame="char"}, isGM() and "selected" or "impersonated").."</td></tr>"
	elseif isGM() and sel.npc and token.properties.Scanned.value == "Yes" then output = output.." - PC Visible</th><tr><td align='right' colspan='3'>"..macro.link("Hide Aspects", "charSetup@lib:Fate", "none", {mode="scanOff", token=sel, frame="char"}, isGM() and "selected" or "impersonated").."</td></tr>"
	else
	output = output.."<tr></tr>"
	end
	
	for i, prop in ipairs(picks.pc) do  
		local value = sel.properties[prop].value
		if value ~= "" then
			if i % 2 == 0 then row = "evenRow" else row = "oddRow" end
			output = output.."<tr valign=\"middle\" class=\""..row.."\"><td colspan='2'>"..value.."</td><td align='right'>"..macro.link("Invoke", "invInit@lib:Fate", "all", {free=false, aspect=value, token=sel, slot=prop, frame="char"}, isGM() and "selected" or "impersonated").."</td></tr>"
		end
	end
	output = output.."</table>"
end

--list boosts

function renderBoost()	
	local row = ""		
		output = output.."<table><th colspan='2'>Boost List</th>"
		output = output.."<tr valign='middle'><td align='right' colspan='2'>"..macro.link("Gain Boost", "ctrlBoost@lib:Fate", "all", {token=sel, mod="bGet", frame="char"}, isGM() and "selected" or "impersonated").."</td></tr>"
		if sel.properties.BoostList.converted ~= "" then 	
			for h, boost in ipairs(sel.properties.BoostList.converted) do		
				if h % 2 == 0 then row = "evenRow" else row = "oddRow" end
				output = output.."<tr valign='middle' class='"..row.."'><td>"..boost.."</td><td align='right'>"..macro.link("Use", "ctrlBoost@lib:Fate", "all", {token=sel, aspect=boost, mod="bUse", frame="char"}, isGM() and "selected" or "impersonated").."</td></tr>"
			end
		end
		output = output.."</table>"
	
end

-- render stunts 
function renderStunts()
	local order = {Normal=1, Aspect=2, Race=3, Item=4, Session=5, Scenario=6, Arc=7}
	local c = 0
	local row = ""		
		output = output.."<table><th colspan='3'>Stunt List</th>"
		if sel.properties.stuntsDB.converted ~= "" then 	
			for h, stunt in spairs(sel.properties.stuntsDB.converted, function (t, a, b)
				return order[t[a].sType] == order[t[b].sType] and a < b or order[t[a].sType] < order[t[b].sType]
			end) do		
				if c % 2 == 0 then row = stunt.sType.."EvenRow"..(stunt.sUsed ~= "No" and "Used" or "") else row = stunt.sType.."OddRow"..(stunt.sUsed ~= "No" and "Used" or "") end
				if stunt.sUsed == "No" then
					output = output.."<tr valign='middle' class='"..row.."'><td>"..stunt.sName.."</td><td align='right'>"..macro.link("Preview", "ctrlStunt@lib:Fate", "none", {token=sel, mode="view", stunt=stunt.sName, frame="char"}, isGM() and "selected" or "impersonated").."</td><td width='30px' align='right'>"..macro.link("Use", "ctrlStunt@lib:Fate", "all", {token=sel, mode="use", stunt=stunt.sName, frame="char"}, token).."</td></tr>"
				else
					output = output.."<tr valign='middle' colspan='2' class='"..row.."'><td>"..stunt.sName.."</td><td align='right'>"..macro.link("Preview", "ctrlStunt@lib:Fate", "none", {token=sel, mode="view", stunt=stunt.sName, frame="char"}, isGM() and "selected" or "impersonated").."</td></tr>"
				end
				c = c+1
			end
		end
		output = output.."<tr valign='middle'><td align='right' colspan='3'>"..macro.link("Add Stunts", "ctrlStunt@lib:Fate", "none", {token=sel, mode="mod", frame="char"}, token).."</td></tr>"
		output = output.."</table>"
	
end

if sel ~= nil then 
	if sel.name~="lib:Fate" then 
		Nametag()
		renderStress()
		renCon()
		PlayerList()
		renderBoost()
		renderStunts()	
	end
 end


UI.frame("Character Sheet",output,"width=250; height=500; temporary=1")