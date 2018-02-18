--{assert(0, "LUA")}--

require 'intCommon@lib:Fate'
require 'intDialog@lib:Fate'

local invoke = macro.args

local sel = tokens.selected()[1]
if not sel then sel=token end

local sdb = sel.properties.stuntsDB.converted

function modStunt()
	print("add")
end

function editStunt ()
	print("edit")
end

function delStunt ()
	print("del")
end

function runStunt (name)
	local c = colorPick (name)
	local s = sdb[name]
	local html = [[
		<table  style="width:200px">
		<tr  style="background:]]..c.bg..[[;  color:]]..c.face..[[">
		<td  style="width:150;  text-align:left;  font-size:20pt">]]..s.sName..[[</td>
		<td  style="width:50;  padding-left:40px;  font-style:italic">]]..s.sType..[[</td>
		</tr>
		<tr>
		<b>Requiers  Fate  Point:  </b>]]..s.sFP..[[
		</tr>
		]]..s.sDesc..[[
		</table>  
	]]	
	print(html)
	
	
	if s.sType == "Arc" or s.sType == "Session" or s.sType == "Scenario" then
		s.sUsed = "Yes"
		sdb[name] = s
		token.properties["stuntsDB"].value = sdb
	end
	
end

if invoke.mode == "mod" then modStunt()
elseif invoke.mode == "use" then runStunt(invoke.stunt)
else println ("ERROR: Unsupported mod") end