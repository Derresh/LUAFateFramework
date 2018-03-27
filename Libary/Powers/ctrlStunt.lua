--{assert(0, "LUA")}--

require 'intCommon@lib:Fate'
require 'intDialog@lib:Fate'

local invoke = macro.args

local sel = tokens.selected()[1]
if not sel then sel=token end

local sdb = sel.properties.stuntsDB.converted

function addStunt ()
	StuntD()
end

function runStunt (name,mode)
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
		]]
	
	if s.sType == "Item" then
		html = html.."<tr><b>Item Aspects:</b>"..s.sItemAsp.."</tr><tr><b>Item Type:</b>"..s.sItemType.."</tr><tr><b>Item Rating:</b>"..s.sItemRate.."</tr>" 
		
		for i=1,5,1 do 
			local pick1 = "sItemStuntName"..i
			local pick2 = "sItemStunt"..i
			if s[pick2] ~= "" then html = html.."<tr><b>"..s[pick1].." </b>"..s[pick2].."</tr>" end
		end
	end
			
	html = html.."<BR><b>Description:</b><br>"..s.sDesc.."</table>"
	
	if mode == "use" then print(html)
	elseif mode == "view" then stuntV(s.sName,html)		
	else print("something is wrong") end
	
	
	if mode == "use" then
		if s.sType == "Arc" or s.sType == "Session" or s.sType == "Scenario" then
		s.sUsed = "Yes"
		sdb[name] = s
		token.properties["stuntsDB"].value = sdb
		end
	end
end

if invoke.mode == "mod" then addStunt()
elseif invoke.mode == "use" or invoke.mode == "view" then runStunt(invoke.stunt,invoke.mode)
else println ("ERROR: Unsupported mod") end

	intRefresh("char")