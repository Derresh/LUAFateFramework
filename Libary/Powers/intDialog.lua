--{assert(0, "LUA")}--

function StuntD ()
	local dialog = [[
	<html>
		<head>
		<title>Stunt</title>
		</head>
	<body>
		<form action="]]..macro.linkText("test@lib:Fate", "all",nil,token)..[[" method="json">
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

