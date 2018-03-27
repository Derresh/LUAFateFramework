	--{assert(0, "LUA")}--

	function StuntD ()
		local dialog = [[
		<html>
			<head>
			<title>Stunt</title>
			</head>
		<body>
			<form action="]]..macro.linkText("frmAction@lib:Fate", "none",nil,token)..[[" method="json">
		<table>
		<tr>
			<td>Stunt Name:</td>
			<td><input type="text" name="sName" size="45"><td>
			<input type="hidden" name="sID" value="">
		</tr>
		<tr>
			<td>Type:</td>
			<td?
			<select name="sType" size="150px">
				<option selected="selected">Normal</option>
				<option>Aspect</option>
				<option>Race</option>
				<option>Item</option>
				<option>Session</option>
				<option>Scenario</option>
				<option>Arc</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Requires a fate point to use?</td>
			<td>
			No<input type="radio" name="sFP" value="No" checked="checked">
			Yes<input type="radio" name="sFP" value="Yes">
			<td>
		</tr>
	</table>
	<br>

		<textarea name="sDesc" cols="60" rows="10">Enter Stunt description</textarea>
	<br>
		<center> <h4>Item Fields (works only for item type)</h4></center>
		<HR WIDTH="80%">

	<table>	
		<tr>
			<td>Item Aspects:</td>
			<td><input type="text" name="sItemAsp" size="45"><td>
		</tr>
		<tr>
			<td>Item Type:</td>
			<td><input type="text" name="sItemType" size="45"><td>
		</tr>
			<tr>
			<td>Item Rating:</td>
			<td><input type="text" name="sItemRate" size="45"><td>
		</tr>
		<tr>
			<td><input type="text" name="sItemStuntName1" size="10" value="Item Stunt 1:"></td>
			<td><input type="text" name="sItemStunt1" size="45"><td>
		</tr>
		<tr>
			<td><input type="text" name="sItemStuntName2" size="10" value="Item Stunt 2:"></td>
			<td><input type="text" name="sItemStunt2" size="45"><td>
		</tr>
		<tr>
			<td><input type="text" name="sItemStuntName3" size="10" value="Item Stunt 3:"></td>
			<td><input type="text" name="sItemStunt3" size="45"><td>
		</tr>
		<tr>
			<td><input type="text" name="sItemStuntName4" size="10" value="Item Stunt 4:"></td>
			<td><input type="text" name="sItemStunt4" size="45"><td>
		</tr>
		<tr>
			<td><input type="text" name="sItemStuntName5" size="10" value="Item Stunt 5:"></td>
			<td><input type="text" name="sItemStunt5" size="45"><td>
		</tr>
	</table>
	<br>
	<input type="hidden" name="sUsed" value="No">
	<br>


	<input type="submit" name="Save" value="Save"></input>
	<input type="submit" name="Cancel" value="Cancel"></input>

		</body>
	  </html>
	}]
		]]
		
		local r = UI.dialog("AddStunt",dialog,"width=650; height=700; temporary=1;input=1")
	end

	function stuntV (name,data)
		local dialog = [[
		<html>
			<head>
			<title>]]..name..[[</title>
			</head>
		<body>
		<form action="]]..macro.linkText("frmAction@lib:Fate", "none",nil,token)..[[" method="json">
		<input type="hidden" name="sName" value="]]..name..[[">
		<input type="submit" name="Edit" value="Edit"></input>
		<input type="submit" name="Delete" value="Delete"></input>
		<input type="submit" name="Cancel" value="Close"></input>
		<br>
		]]..data
		local r = UI.dialog("Stunt Preview",dialog,"width=350; height=600; temporary=1;input=1")
	end
	
	function StuntE (data)
		local dialog = [[
		<html>
			<head>
			<title>]]..data.sName..[[</title>
			</head>
		<body>
			<form action="]]..macro.linkText("frmAction@lib:Fate", "none",nil,token)..[[" method="json">
		<table>
		<tr>
			<td>Stunt Name:</td>
			<td><input type="text" name="sName" size="45" value="]]..data.sName..[["><td>
			<input type="hidden" name="sID" value="">
		</tr>
		<tr>
			<td>Type:</td>
			<td>
			<select name="sType" size="150px">]]			
			
		if data.sType == "Normal" then dialog = dialog..[[<option selected="selected">Normal</option>]] else dialog = dialog.."<option>Normal</option>" end
		if data.sType == "Aspect" then dialog = dialog..[[<option selected="selected">Aspect</option>]] else dialog = dialog.."<option>Aspect</option>" end
		if data.sType == "Race" then dialog = dialog..[[<option selected="selected">Race</option>]] else dialog = dialog.."<option>Race</option>" end
		if data.sType == "Item" then dialog = dialog..[[<option selected="selected">Item</option>]] else dialog = dialog.."<option>Item</option>" end	
		if data.sType == "Session" then dialog = dialog..[[<option selected="selected">Session</option>]] else dialog = dialog.."<option>Session</option>" end				
		if data.sType == "Scenario" then dialog = dialog..[[<option selected="selected">Scenario</option>]] else dialog = dialog.."<option>Scenario</option>" end
		if data.sType == "Arc" then dialog = dialog..[[<option selected="selected">Arc</option>]] else dialog = dialog.."<option>Arc</option>" end
		
		dialog = dialog..[[</select></td>
		</tr>
		<tr>
			<td>Requires a fate point to use?</td>
			<td>]]
			
		if data.sFP == "No" then dialog = dialog..[[No<input type="radio" name="sFP" value="No" checked="checked">]] else dialog = dialog..[[No<input type="radio" name="sFP" value="No">]] end
		if data.sFP == "Yes" then dialog = dialog..[[Yes<input type="radio" name="sFP" value="Yes" checked="checked">]] else dialog = dialog..[[Yes<input type="radio" name="sFP" value="Yes">]] end
		
		dialog = dialog..[[</td></tr>
	</table>
	<br>

		<textarea name="sDesc" cols="60" rows="10">]]..data.sDesc..[[</textarea>
	<br>
		<center> <h4>Item Fields (works only for item type)</h4></center>
		<HR WIDTH="80%">

	<table>	
		<tr>
			<td>Item Aspects:</td>
			<td><input type="text" name="sItemAsp" size="45" value="]]..data.sItemAsp..[["><td>
		</tr>
		<tr>
			<td>Item Type:</td>
			<td><input type="text" name="sItemType" size="45" value="]]..data.sItemType..[["><td>
		</tr>
			<tr>
			<td>Item Rating:</td>
			<td><input type="text" name="sItemRate" size="45" value="]]..data.sItemRate..[["><td>
		</tr>
		<tr>
			<td><input type="text" name="sItemStuntName1" size="10" value="]]..data.sItemStuntName1..[["></td>
			<td><input type="text" name="sItemStunt1" size="45" value="]]..data.sItemStunt1..[["><td>
		</tr>
		<tr>
			<td><input type="text" name="sItemStuntName2" size="10" value="]]..data.sItemStuntName2..[["></td>
			<td><input type="text" name="sItemStunt2" size="45" value="]]..data.sItemStunt2..[["><td>
		</tr>
		<tr>
			<td><input type="text" name="sItemStuntName3" size="10" value="]]..data.sItemStuntName3..[["></td>
			<td><input type="text" name="sItemStunt3" size="45" value="]]..data.sItemStunt3..[["><td>
		</tr>
		<tr>
			<td><input type="text" name="sItemStuntName4" size="10" value="]]..data.sItemStuntName4..[["></td>
			<td><input type="text" name="sItemStunt4" size="45" value="]]..data.sItemStunt4..[["><td>
		</tr>
		<tr>
			<td><input type="text" name="sItemStuntName5" size="10" value="]]..data.sItemStuntName5..[["></td>
			<td><input type="text" name="sItemStunt5" size="45" value="]]..data.sItemStunt5..[["><td>
		</tr>
	
	<TR><td>Used Up ?</td><td>]]
		
	if data.sUsed == "No" then dialog = dialog..[[No<input type="radio" name="sUsed" value="No" checked="checked">]] else dialog = dialog..[[No<input type="radio" name="sUsed" value="No">]] end
	if data.sUsed == "Yes" then dialog = dialog..[[Yes<input type="radio" name="sUsed" value="Yes" checked="checked">]] else dialog = dialog..[[Yes<input type="radio" name="sUsed" value="Yes">]] end
	
	dialog = dialog..[[
	</td></tr></table><BR>
	<input type="submit" name="Save" value="Save"></input>
	<input type="submit" name="Cancel" value="Cancel"></input>

	  </body>
	  </html>
	}]
		]]
		local fname = "Editing: "..data.sName
		local r = UI.dialog(fname,dialog,"width=650; height=700; temporary=1;input=1")
end


function skillV()

	local sel = tokens.selected()[1]
	local skill = sel.properties.skillDB.converted
	local ranks = {"Fantastic","Superb","Great","Good","Fair","Average"}
	local pcount = 1

	local dialog = [[
		<html>
			<head>
			<title>Skills</title>
			</head>
		<body>
			<form action="]]..macro.linkText("frmAction@lib:Fate", "none",nil,token)..[[" method="json">
		<table border=1>]]
		
		for r, row in ipairs(ranks) do
			dialog = dialog.."<tr>"
			dialog = dialog.."<td>"..row.."</td>"
				for h, pick in ipairs(sel.properties.skillDB.converted[row]) do
				if pick ~= "" then dialog = dialog.."<td>"..macro.link(pick, "useSkill@lib:Fate", "all", {token=sel, mode="skillRoll", bonus=r, skill=pick, frame="char"}, token).."</td>" end
				end	
			dialog = dialog.."</tr>"
		end
				
	dialog = dialog..[[
	</tr></table><BR>
	<input type="submit" name="skillEdit" value="Edit"></input>
	<input type="submit" name="Cancel" value="Cancel"></input>
	</body>
	</html>]]
	
	local r = UI.dialog("Skill",dialog,"width=450; height=300; temporary=1;input=1")
end

function skillE()

	local sel = tokens.selected()[1]
	local skill = sel.properties.skillDB.converted
	local ranks = {"Fantastic","Superb","Great","Good","Fair","Average"}
	local pcount = 1

	local dialog = [[
		<html>
			<head>
			<title>Skills</title>
			</head>
		<body>
			<form action="]]..macro.linkText("frmAction@lib:Fate", "none",nil,token)..[[" method="json">
		<table border=1>]]
		
		
		for r, row in ipairs(ranks) do
			dialog = dialog.."<tr>"
			dialog = dialog.."<td>"..row.."</td>"
			local pick = skill[row]
				for h=1,pcount do
				if pick[h] ~= nil then dialog = dialog..[[<td><input type="text" name="]]..row..h..[[" value="]]..pick[h]..[["></td>]] else dialog = dialog..[[<td><input type="text" name="]]..row..h..[["></td>]]  end
				end	
			pcount=pcount+1
			dialog = dialog.."</tr>"
		end
		
				
	dialog = dialog..[[
	</tr></table><BR>
	<input type="submit" name="skillSave" value="Save"></input>
	<input type="submit" name="Cancel" value="Cancel"></input>
	</body>
	</html>]]
	
	local r = UI.dialog("Skill Edit",dialog,"width=450; height=300; temporary=1;input=1")
end

