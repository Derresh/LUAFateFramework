--{assert(0, "LUA")}--
require 'intCommon@lib:Fate'

local args = macro.args
local sel = tokens.resolve(args.token)
local bList = sel.properties.BoostList.converted
if sel.properties.BoostList.converted ~= "" then bList = sel.properties.BoostList.converted else bList={} end

function bAdd()

	local r= input({content="Boost Name", type="LABEL", span="TRUE"}, {type="TEXT", span=true, name="text"})
	macro.abort(r)	
	table.insert (bList,r.text)
	println(sel.name," Has gained a boost ",r.text)
	sel.properties.BoostList.value = bList
	
end

function bUse(pick)	
	for h, test in ipairs(bList) do
		if test == pick then table.remove(bList, h) end
	end 
	sel.properties.BoostList.value = bList
end	

if args.mod == "bUse" then
	bUse(args.aspect)
elseif args.mod =="bGet" then
	bAdd()
else
	println(toJSON(args))
end

intRefresh(args.frame)
