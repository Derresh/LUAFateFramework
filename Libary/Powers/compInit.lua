--{assert(0, "LUA")}--

require 'intCommon@lib:Fate'

local data = macro.args
local caller = ""
local target = type(data.target) == "string" and tokens.resolve(data.target) or data.target
local aspect = data.aspect

if isGM () then
	caller = "GM"
else
	caller = token.name
end

function startframe()

local output = [[<table width="350" border='1'><th colspan="2">Compel Called by: ]]..caller..[[</th><tr><td colspan="2">]]..caller..[[ has compelled ]]..target.name..[['s aspect ]]..data.aspect..[[<br> Does ]]..target.name..[[ acceot the compel ?</tr><tr>]]
output = output.."<td align='center' width='15px'>"..macro.link("Yes", "compInit@lib:Fate", "all", {aspect=data.asp, mode="comYes", token=target.name, slot=token.selected, frame="sit"}, "selected").."</td>"
output = output.."<td align='center' width='15px'>"..macro.link("No", "compInit@lib:Fate", "all", {aspect=data.asp, mode="comNo", token=target.name, slot=token.selected, frame="sit"}, "selected").."</td>"
output = output.."</tr></table>"

println(output)
end

function acceptCompel()
	if data.token == token.name then
		println(token.name," has accepted the compel and gains a Fate Point")
		token.properties.CurrentFP.value = token.properties.CurrentFP.converted+1
	else
		println("You are not the target of this compel")
	end
end

function refuseComepl()
	if data.token == token.name then
		println(token.name," has declined the compel and looses a Fate Point")
		token.properties.CurrentFP.value = token.properties.CurrentFP.converted-1
	else
		println("You are not the target of this compel")
	end
end

if data.mode == "start" then startframe()
elseif data.mode == "comYes" then acceptCompel()
elseif data.mode == "comNo" then refuseComepl()
end