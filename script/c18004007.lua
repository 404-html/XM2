--性感手枪7号
if not pcall(function() require("expansions/script/c18004001") end) then require("script/c18004001") end
local m=18004007
local cm=_G["c"..m]
cm.rssetcode="SexGun"
function cm.initial_effect(c)
	rssg.SexGunCode(c)   
	rssg.SexGunSummonEffect(c,m)
end