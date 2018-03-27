--{assert(0, "LUA")}--

require 'intCommon@lib:Fate'

local data = macro.args
local target = tokens.selected()[1]

function stuntConvert()

	local sdb = target.properties.sDB.converted
	local stuntsdb = target.properties.stuntsDB.converted


	for i, s in pairs(sdb) do
		local converted = fromStr(s, "LONGSTRINGTHATDOESNTEXISTSANYWHEREELSE", ";", false, true)
		stuntsdb[converted.sName] = converted
	end

	target.properties.sDB = {}
	target.properties.stuntsDB = stuntsdb

	println(toJSON(stuntsdb))

end

function skillConvert()

	local data = {}
	data.Fantastic = {}
	data.Superb = {}
	data.Great = {}
	data.Good = {}
	data.Fair = {}
	data.Average = {}
	data.Mediocer = {}

		data.Fantastic = fromStr(target.properties.Fantastic.value, ",")
		data.Superb = fromStr(target.properties.Superb.value, ",")
		data.Great = fromStr(target.properties.Great.value, ",")
		data.Good = fromStr(target.properties.Good.value, ",")
		data.Fair = fromStr(target.properties.Fair.value, ",")
		data.Average = fromStr(target.properties.Average.value, ",")
		data.Mediocer = fromStr(target.properties.Mediocer.value, ",")

		for j, t in pairs(data) do
		for i = #t, 1, -1 do
			if not t[i] or string.trim(t[i]) == "" then
			table.remove(t, i)
			end
		end
	end

	target.properties.skillDB.value = data
end

if data.mode == "skill" then skillConvert()
elseif data.mode == "stunt" then stuntConvert()
else println ("ERROR: Unsupported mode in charConvert.lua") end