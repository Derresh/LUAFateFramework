--{assert(0, "LUA")}--

function intRefresh(frame)
	if frame == "char" then macro.call("charFrame@lib:Fate") 
	elseif frame == "sit" then macro.call("sitFrame@lib:Fate") 
	elseif frame == "tool" then macro.call("toolFrame@lib:Fate") 
	else println("ERROR: Unsupported interface element")
	end
end
	
function iconRender (icon)
	export("die", icon)
	local icon = eval("tableimage(\"Icons\", die)")
	return icon
end

function diceRender (icon,color)
	export("die", icon)
	export("color", color)
	local icon = eval("tableimage(color, die)")
	return icon
end

function symbolRender (icon)
	export("die", icon)
	local icon = eval("tableimage(\"Plus Minus\", die)")
	return icon
end

function diceRoller (name, color, count, bonus, scount)

	local dice = {dice.fudge(1),dice.fudge(1),dice.fudge(1),dice.fudge(1)}
	local setup = {"NormalFD","NormalFD","NormalFD","NormalFD"}
	local result = 0
	
	if color == "red" then
		for i=1,scount do setup[i]="RedFD" end
	elseif color == "blue" then
		for i=1,scount do setup[i]="BlueFD" end
	end	
	
	local rOutput = [[
	<h2>]]..token.name.." is rolling "..name..[[</h2>
	<table cellspacing=2 valign=middle>
	<tr> ]]
	for i=1,count do 
		rOutput = rOutput..[[<td><image src=']]..diceRender(dice[i],setup[i])..[['></image></td>]]
		result = result+dice[i]
	end	
	if bonus ~= nil then 
		rOutput = rOutput..[[<td><image src=']]..symbolRender(1)..[['></image></td>]]
		rOutput = rOutput..[[<td><image src=']]..diceRender(bonus,"GreenND")..[['></image></td>]]
		result = result+bonus
	end	
	rOutput = rOutput.."</td>="..result.."</tr></table>"		
	print(rOutput)
end

function colorPick (name)
	local s = tokens.selected()[1]
	local pick = s.properties.stuntsDB.converted
	local t = pick[name].sType
	local u = pick[name].sUsed
	local color = {}
	color.face = ""
	color.bg = ""
	color.pos = ""
	
	if t == "Normal" then color.face="white" color.bg="green" color.pos = 1
	elseif t == "Aspect" then color.face="white" color.bg="red" color.pos = 2
	elseif t == "Race" then color.face="white" color.bg="blue" color.pos = 3
	elseif t == "Item" then color.face="white" color.bg="orange" color.pos = 4
	elseif t == "Session" and u == "No" then color.face="black" color.bg="lime" color.pos = 5
	elseif t == "Session" and u == "Yes" then color.face="lime" color.bg="black" color.pos = 5
	elseif t == "Scenario" and u == "No" then color.face="white" color.bg="purple" color.pos = 6
	elseif t == "Scenario" and u == "Yes" then color.face="purple" color.bg="black" color.pos = 6
	elseif t == "Arc" and u == "No" then color.face="red" color.bg="silver" color.pos = 7
	elseif t == "Arc" and u == "Yes" then color.face="silver" color.bg="black" color.pos = 7
	else color.face="black" color.bg="white" end

return color
end

function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function contains(t, val)
   for i=1,#t do
      if t[i] == val then 
         return true
      end
   end
   return false
end

function skillSet()

	local skill = token.properties.skillDB.converted
	local conset = token.properties.conDB.converted
	conset.ModPhysical=nil
	conset.ModMental=nil

	if contains(skill.Average,"Physique") or contains(skill.Fair,"Physique") then 
		token.properties.pStress = "OOO"
	elseif contains(skill.Good,"Physique") or contains(skill.Great,"Physique") then
		token.properties.pStress = "OOOO"
	elseif contains(skill.Superb,"Physique") or contains(skill.Fantastic,"Physique") then
		token.properties.pStress = "OOOO"
		conset.ModPhysical="Non Taken"
	end
	
	if contains(skill.Average,"Will") or contains(skill.Fair,"Will") then 
		token.properties.mStress = "OOO"
	elseif contains(skill.Good,"Will") or contains(skill.Great,"Will") then
		token.properties.mStress = "OOOO"
	elseif contains(skill.Superb,"Will") or contains(skill.Fantastic,"Will") then
		token.properties.pStress = "OOOO"
		conset.ModMental="Non Taken"
	end
	
	token.properties.conDB = conset
	intRefresh("char")
end

table.indexOf = function( t, object )
	local result

	if "table" == type( t ) then
		for i=1,#t do
			if object == t[i] then
				result = i
				break
			end
		end
	end

	return result
end