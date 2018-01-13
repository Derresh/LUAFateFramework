--{assert(0, "LUA")}--

local list = tokens.getLibProperty("SitAspect","lib:Fate").converted
if (type(list) ~= "table") then list={} end

function AddNew()
	local r= input({content="Add new Situational Aspect", type="LABEL", span="TRUE"}, {type="TEXT", name="AspName"},{content="Number of Free Invokes", type="LABEL", span="TRUE"}, {type="LIST", name="Count", content={"None",1,2,3,4,5,6,7,8,9}},{content="GM Only aspect, check for yes", type="LABEL", span="TRUE"}, {type="CHECK", name="GMOnly", content=0} )
    macro.abort(r)
	
	local result = r.AspName
	if (r.GMOnly) then result = "!"..result end
	if (r.Count > 0) then result = result .. " ("..r.Count..")" end

	table.insert(list,result)	
end

function Edit(aspect)
	local aspecttext = list[aspect]
	local gmonly = string.startsWith(aspecttext, "!")
	if gmonly then aspecttext = string.sub(aspecttext, 2, -1) end
	local i, j = string.find(aspecttext, "%(%d+%)$")
	local c = 0
	if (i) then
		c = tonumber(string.sub(aspecttext, i+1, j-1))
		aspecttext = string.sub(aspecttext, 0, i-1) 
	end
	local r= input({content="Edit Situational Aspect", type="LABEL", span="TRUE"}, {type="TEXT", name="AspName", content = aspecttext},{content="Number of Free Invokes", type="LABEL", span="TRUE"}, {type="LIST", name="Count", content={"None",1,2,3,4,5,6,7,8,9}, select=c},{content="GM Only aspect, check for yes", type="LABEL", span="TRUE"}, {type="CHECK", name="GMOnly", content=(gmonly and 1 or 0)} )
    macro.abort(r)
	
	local result = r.AspName
	if (r.GMOnly) then result = "!"..result end
	if (r.Count > 0) then result = result .. " ("..r.Count..")" end
	list[aspect] = result
end

function Del(aspect)
	table.remove(list, aspect)
end


local r= input({content="Pick Situational Aspect", type="LABEL", span="TRUE"}, {type="RADIO", content={"Add", "Edit", "Delete"}, span=true, orient="h", name="Mode", select=1}, {type="RADIO", content=list, span="true", orient="v", name="Aspect"})
macro.abort(r)

if r.Mode == 0 then AddNew()
	elseif r.Mode == 1 then Edit(r.Aspect + 1)
	else Del(r.Aspect + 1)
end

pcall(function() 
tokens.getLibProperty("SitAspect","lib:Fate").value = list
end)