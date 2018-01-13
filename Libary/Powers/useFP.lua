--{assert(0, "LUA")}--

function GMUse()
 local imp = tokens.resolve("GM Token")
 imp.properties.CurrentFP.value = imp.properties.CurrentFP.value - 1
 println("GM Uses a Fate point for ", token.name, " GM Has ", imp.properties.CurrentFP.value, " left")
end
 
function PCUse()
 token.properties.CurrentFP.value = token.properties.CurrentFP.value - 1
 println(token.name, " Has spend a fate point and has ", CurrentFP, " left")
end

function NPCUse ()
 local players = {}
 local pictures = {}
 for i, pc in ipairs(tokens.pc()) do
  if (pc.properties.CurrentFP.value > 0) then 
   table.insert(players, pc) 
   table.insert(pictures, "<html><table><tr><td height='100'><img width=50 height=50 src='"..pc.image.."'></img></td></tr><tr><td align='center'>"..pc.name.."</td></tr></table></html>")
  end
 end
 if (#players == 0) then 
  input({content="No PC has fate points", type="LABEL", span="TRUE"})
  macro.abort()
 end
 local r= input({content="Who is donating a fate point?", type="LABEL", span="TRUE"}, {type="RADIO", content=pictures, span=true, orient="h", name="Donor"})
 macro.abort(r)
 macro.abort(type(r.Donor)=="number")
 
 local imp = players[r.Donor+1]
 imp.properties.CurrentFP.value = imp.properties.CurrentFP.value - 1
 println(imp.name, " uses a Fate point for ", token.name, " and has", imp.properties.CurrentFP.value, " left")
end

if isGM() then GMUse()
	elseif token.pc then PCUse()
	else NPCUse() 
end
