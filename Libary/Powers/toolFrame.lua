--{assert(0, "LUA")}--

require 'intCommon@lib:Fate'

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
<form name="Character Sheet" action="]]..macro.linkText("toolFrame@lib:Fate", "None", {}, "none")..[["><input type="submit" name="Refresh" value="Refresh"></form>
]]

local sel = tokens.selected()[1]
local fname = ""
local dswitch = "all"

function gmFP ()
	output = output.."<table><th colspan='2'>Fate Points</th>"
	output = output.."<tr valign='middle'><td>Current FP</td><td>Player Count</td></tr>"
	output = output.."<tr valign='middle'><td>"..tokens.getLibProperty("GMFP","lib:Fate").value.."</td><td>"..tokens.getLibProperty("PlayerCount","lib:Fate").value.."</td></tr>"
	output = output.."</table>"
end

function covertSkill()
	output = output.."<table><th>Character Convert (please impersonate)</th>"
	output = output.."<tr valign='middle'><td align='left' class='oddRow' width='100%'>"..macro.link("Convert Skills", "charConvert@lib:Fate", dswitch, {token=sel, mode="skill", frame="char"}, token).."</td></tr>"
	output = output.."<tr valign='middle'><td align='left' class='evenRow' width='100%'>"..macro.link("Convert Stunts", "charConvert@lib:Fate", dswitch, {token=sel, mode="stunt", frame="char"}, token).."</td></tr>"
	output = output.."</table>"
end

function gameReset ()
	output = output.."<table><th>Reset controls</th>"
	output = output.."<tr valign='middle'><td align='left' class='oddRow' width='100%'>"..macro.link("Reset Scene", "gameReset@lib:Fate", "all", {token=sel, mode="scene", frame="char"}, nil).."</td></tr>"
	output = output.."<tr valign='middle'><td align='left' class='evenRow' width='100%'>"..macro.link("Reset Session", "gameReset@lib:Fate", "all", {token=sel, mode="session", frame="char"}, nil).."</td></tr>"
	output = output.."<tr valign='middle'><td align='left' class='oddRow' width='100%'>"..macro.link("Reset Scenario", "gameReset@lib:Fate", "all", {token=sel, mode="scenario", frame="char"}, nil).."</td></tr>"
	output = output.."<tr valign='middle'><td align='left' class='evenRow' width='100%'>"..macro.link("Reset Arc", "gameReset@lib:Fate", "all", {token=sel, mode="arc", frame="char"}, nil).."</td></tr>"
	output = output.."</table>"
end

function conFP ()
	output = output.."<table><th>Fatepoint Control</th>"
	output = output.."<tr valign='middle'><td align='left' class='oddRow' width='100%'>"..macro.link("Give FP", "modFP@lib:Fate", "all", {token=sel, mode="give", frame="tool"}, "selected").."</td></tr>"
	output = output.."<tr valign='middle'><td align='left' class='evenRow' width='100%'>"..macro.link("Take FP", "modFP@lib:Fate", "all", {token=sel, mode="take", frame="tool"}, "selected").."</td></tr>"
	output = output.."</table>"
end

function SitList ()
	output = output.."<table><th colspan='3'>Situational Aspects</th>"
		for h, asp in ipairs(tokens.getLibProperty("SitAspect","lib:Fate").converted) do
			if h % 2 == 0 then row = "evenRow" else row = "oddRow" end
			output = output.."<tr valign=\"middle\" class=\""..row.."\"><td width='90%'>"..asp.."</td>" 
			output = output.."<td align='right' width='15px'>"..macro.link("Edit", "sitStart@lib:Fate", dswitch, {aspect=asp, mode="sitEdit", token=nil, slot=h, frame="tool"}, nil)
			output = output.."<td align='right' width='15px'>"..macro.link("Del", "sitStart@lib:Fate", dswitch, {aspect=asp, mode="sitDel", token=nil, slot=h, frame="tool"}, nil)
			output = output.."</td></tr>"
		end
	output = output.."<tr valign='middle'><td colspan='3' align='right' width='100%'>"..macro.link("Add Situational Aspect", "sitStart@lib:Fate", dswitch, {token=sel, mode="sitAdd", frame="tool"}, nil).."</td></tr>"
	output = output.."</table>"
end

if isGM() then
	gmFP()
	covertSkill()
	SitList()
	gameReset ()
	conFP ()
	fname = "GM Tool Box"
else 
	covertSkill()
	fname = "Tool Box"
end

UI.frame(fname,output,"width=250; height=500; temporary=1")