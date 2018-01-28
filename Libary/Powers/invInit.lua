--{assert(0, "LUA")}--

local picks = {}
	picks.pc = {"HighConcept", "Trouble", "APR", "AP1", "AP2", "AP3", "APW", "APA", "MildC", "MildCPH", "MildCWI", "ModC", "Sevc", "CripC", "DeadC"}
	picks.npc = {"MildC", "MildCPH", "MildCWI", "ModC", "Sevc", "CripC", "DeadC"}
	
	
local asplist = {}
asplist.asp = {}
asplist.source = {}
asplist.loc = {}
asplist.ammo = {}

local display = {"Other"}
local sitIcon = "asset://none"
local GMToken = tokens.resolve("GM Token")


if GMToken then sitIcon = GMToken.getHandout() end


function PlayerList()

	local selected = tokens.selected()[1]
	
	for i, prop in ipairs(picks.pc) do  
		local value = selected.properties[prop].value
		if value ~= "" then
			table.insert(asplist.asp,value)
			table.insert(asplist.source,selected)
			table.insert(asplist.loc,prop)
			table.insert(asplist.ammo,0)
			table.insert(display,value..": "..selected.name..selected.image)
		end
	end
end

function NPCList()
	for j, sel in ipairs(tokens.visible()) do
		if sel.npc then
			for i, prop in ipairs(picks.npc) do		
				local value = sel.properties[prop].value
				if value ~= "" then
					table.insert(asplist.asp,value)
					local i, j = string.find(value, "%(%d+%)$")
					local c = 0
					if (i) then
						c = tonumber(string.sub(value, i+1, j-1))
						value = string.sub(value, 0, i-1) 
					end
					table.insert(asplist.source,sel)
					table.insert(asplist.loc,prop)
					table.insert(asplist.ammo,c)
					if c and c > 0 then
						table.insert(display,"("..c..") "..value..": "..sel.name..sel.image)
					else
						table.insert(display,value..": "..sel.name..sel.image)
					end
				end
			end
		end
	end
end

function SitList()
	local c = 0;
		for h, asp in ipairs(tokens.getLibProperty("SitAspect","lib:Fate").converted) do
			if isGM() or not string.startsWith(asp, "!") then
			table.insert(asplist.asp,asp)
			local i, j = string.find(asp, "%(%d+%)$")
			local c = 0
			if (i) then
				c = tonumber(string.sub(asp, i+1, j-1))
				asp = string.sub(asp, 0, i-1) 
			end
			table.insert(asplist.source,"Situational")
			table.insert(asplist.loc,h)
			table.insert(asplist.ammo,c)
			if c and c > 0 then
				table.insert(display,"("..c..") "..asp..": ".."Situational"..sitIcon)
			else
				table.insert(display,asp..": ".."Situational"..sitIcon)
			end
		end
	end 
end

local invoke={}

local args = macro.args

if args and args ~= "" then
	invoke = args
else 
	PlayerList()
	NPCList()
	SitList()

	local r= input({content="Pick Aspect to Invoke", type="LABEL", span="TRUE"}, {type="LIST", content=display, span=true, name="Selection", Icon=true}, {type="CHECK", name="Free", prompt="Free Invoke (if possible)", content="TRUE"})
	macro.abort(type(r.Selection)=="number")
	if r.Selection == 0 then 
		invoke={free=r.Free and true or false, token=nil, slot=nil, aspect="TODO: Input for other"}
	else
		invoke = {free=r.Free and asplist.ammo[r.Selection] > 0 and true or false, token = asplist.source[r.Selection] ~= "Situational" and asplist.source[r.Selection] or nil, slot=asplist.loc[r.Selection], aspect=asplist.asp[r.Selection]}
	end
		
end

local target = type(invoke.token) == "string" and tokens.resolve(invoke.token) or invoke.token
local aspect = invoke.aspect
local free = invoke.free
local slot = invoke.slot


if free then 

	if target and slot then
		
		local i, j = string.find(aspect, "%(%d+%)$")
		local co = 0
			if (i) then
				co = tonumber(string.sub(aspect, i+1, j-1))
				aspect = string.sub(aspect, 0, i-1) 
			end
		co = co-1
		if co>0 then 
			println(token.name," uses a free invoke of ",aspect," of ",target.name," ",co," free uses remain") 
			aspect = aspect.."("..co..")"
		else
			println(token.name," uses the last free invoke of ",aspect," of ",target.name)
		end
		target.properties[slot].value = aspect
		
	else
		if slot then
			local i, j = string.find(aspect, "%(%d+%)$")
			local co = 0
				if (i) then
					co = tonumber(string.sub(aspect, i+1, j-1))
					aspect = string.sub(aspect, 0, i-1) 
				end
			co = co-1
			if co>0 then 
				println(token.name," uses a free invoke of ",aspect," ",co," free uses remain") 
				aspect = aspect.."("..co..")"
			else
				println(token.name," uses the last free invoke of ",aspect)
			end
					
			local list = tokens.getLibProperty("SitAspect","lib:Fate").converted
			list[slot] = aspect
			pcall(function() 
			tokens.getLibProperty("SitAspect","lib:Fate").value = list
			end)
			
			else
			
			-- Other Invoke, do nothing I guess
		end
	end
else
	local res, output = macro.call("useFP@lib:Fate")
	print(output)
end

if invoke.frame then macro.call("sitFrame@lib:Fate") end




--{assert(0, "LUA")}--

local picks = {}
	picks.pc = {"HighConcept", "Trouble", "APR", "AP1", "AP2", "AP3", "APW", "APA", "MildC", "MildCPH", "MildCWI", "ModC", "Sevc", "CripC", "DeadC"}
	picks.npc = {"MildC", "MildCPH", "MildCWI", "ModC", "Sevc", "CripC", "DeadC"}
	
	
local asplist = {}
asplist.asp = {}
asplist.source = {}
asplist.loc = {}
asplist.ammo = {}

local display = {"Other"}
local sitIcon = "asset://none"
local GMToken = tokens.resolve("GM Token")


if GMToken then sitIcon = GMToken.getHandout() end


function PlayerList()

	local selected = tokens.selected()[1]
	
	for i, prop in ipairs(picks.pc) do  
		local value = selected.properties[prop].value
		if value ~= "" then
			table.insert(asplist.asp,value)
			table.insert(asplist.source,selected)
			table.insert(asplist.loc,prop)
			table.insert(asplist.ammo,0)
			table.insert(display,value..": "..selected.name..selected.image)
		end
	end
end

function NPCList()
	for j, sel in ipairs(tokens.visible()) do
		if sel.npc then
			for i, prop in ipairs(picks.npc) do		
				local value = sel.properties[prop].value
				if value ~= "" then
					table.insert(asplist.asp,value)
					local i, j = string.find(value, "%(%d+%)$")
					local c = 0
					if (i) then
						c = tonumber(string.sub(value, i+1, j-1))
						value = string.sub(value, 0, i-1) 
					end
					table.insert(asplist.source,sel)
					table.insert(asplist.loc,prop)
					table.insert(asplist.ammo,c)
					if c and c > 0 then
						table.insert(display,"("..c..") "..value..": "..sel.name..sel.image)
					else
						table.insert(display,value..": "..sel.name..sel.image)
					end
				end
			end
		end
	end
end

function SitList()
	local c = 0;
		for h, asp in ipairs(tokens.getLibProperty("SitAspect","lib:Fate").converted) do
			if isGM() or not string.startsWith(asp, "!") then
			table.insert(asplist.asp,asp)
			local i, j = string.find(asp, "%(%d+%)$")
			local c = 0
			if (i) then
				c = tonumber(string.sub(asp, i+1, j-1))
				asp = string.sub(asp, 0, i-1) 
			end
			table.insert(asplist.source,"Situational")
			table.insert(asplist.loc,h)
			table.insert(asplist.ammo,c)
			if c and c > 0 then
				table.insert(display,"("..c..") "..asp..": ".."Situational"..sitIcon)
			else
				table.insert(display,asp..": ".."Situational"..sitIcon)
			end
		end
	end 
end

local invoke={}

local args = macro.args

if args and args ~= "" then
	invoke = args
else 
	PlayerList()
	NPCList()
	SitList()

	local r= input({content="Pick Aspect to Invoke", type="LABEL", span="TRUE"}, {type="LIST", content=display, span=true, name="Selection", Icon=true}, {type="CHECK", name="Free", prompt="Free Invoke (if possible)", content="TRUE"})
	macro.abort(type(r.Selection)=="number")
	if r.Selection == 0 then 
		invoke={free=r.Free and true or false, token=nil, slot=nil, aspect="TODO: Input for other"}
	else
		invoke = {free=r.Free and asplist.ammo[r.Selection] > 0 and true or false, token = asplist.source[r.Selection] ~= "Situational" and asplist.source[r.Selection] or nil, slot=asplist.loc[r.Selection], aspect=asplist.asp[r.Selection]}
	end
		
end

local target = type(invoke.token) == "string" and tokens.resolve(invoke.token) or invoke.token
local aspect = invoke.aspect
local free = invoke.free
local slot = invoke.slot


if free then 

	if target and slot then
		
		local i, j = string.find(aspect, "%(%d+%)$")
		local co = 0
			if (i) then
				co = tonumber(string.sub(aspect, i+1, j-1))
				aspect = string.sub(aspect, 0, i-1) 
			end
		co = co-1
		if co>0 then 
			println(token.name," uses a free invoke of ",aspect," of ",target.name," ",co," free uses remain") 
			aspect = aspect.."("..co..")"
		else
			println(token.name," uses the last free invoke of ",aspect," of ",target.name)
		end
		target.properties[slot].value = aspect
		
	else
		if slot then
			local i, j = string.find(aspect, "%(%d+%)$")
			local co = 0
				if (i) then
					co = tonumber(string.sub(aspect, i+1, j-1))
					aspect = string.sub(aspect, 0, i-1) 
				end
			co = co-1
			if co>0 then 
				println(token.name," uses a free invoke of ",aspect," ",co," free uses remain") 
				aspect = aspect.."("..co..")"
			else
				println(token.name," uses the last free invoke of ",aspect)
			end
					
			local list = tokens.getLibProperty("SitAspect","lib:Fate").converted
			list[slot] = aspect
			pcall(function() 
			tokens.getLibProperty("SitAspect","lib:Fate").value = list
			end)
			
			else
			
			-- Other Invoke, do nothing I guess
		end
	end
else
	local res, output = macro.call("useFP@lib:Fate")
	print(output)
end

if invoke.frame then macro.call("sitFrame@lib:Fate") end




