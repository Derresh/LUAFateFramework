--{assert(0, "LUA")}--

require 'intDialog@lib:Fate'
require 'intCommon@lib:Fate'

local data = macro.args;
local sdb = token.properties["stuntsDB"].converted;
local pick = sdb[data.sName]

if data.Edit then
	data.Edit = nil	
	StuntE(pick)
	
elseif data.Delete then	
	data.Delete = nil
	
	local r= input({content="Are You Sure ?", type="LABEL", span="TRUE"}, {type="RADIO", name="Sure", content={"No", "Yes"}})
	macro.abort(type(r.Sure)~="nummber")
		
	if r.Sure == 1 then 
		sdb[data.sName]=nil
		token.properties.stuntsDB.value = sdb
	end
	
elseif data.Save then
  data.Save = nil
  println(toJSON(data))
  local sdb = token.properties["stuntsDB"].converted;
  if type(sdb) ~= "table" then
    sdb = {};
  end
  sdb[data.sName] = data
  token.properties["stuntsDB"].value = sdb
--  pcall(function() token.properties["stuntsDB"].value = list end)

elseif data.skillEdit then skillE()

elseif data.skillSave then
	local skillDB = {}
	local ladder = {"Good", "Great", "Fair", "Average", "Superb", "Fantastic"}
	
	for i, v in ipairs(ladder) do
		local res = {}
		for name, skill in pairs(data) do
			if string.startsWith(name, v) then 
				table.insert(res, skill)
			end
		end
		if #res then skillDB[v] = res end
	end
		
	for j, t in pairs(skillDB) do
		for i = #t, 1, -1 do
			if not t[i] or string.trim(t[i]) == "" then	table.remove(t, i) end
		end
	end
	
token.properties.skillDB.value = skillDB
skillSet()
	
else
println("ERROR: Unsported mode in frmAction.lua")
println("DEBUG:<BR>"..toJSON(data))
end

intRefresh("char")