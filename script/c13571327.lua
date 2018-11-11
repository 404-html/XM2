local m=13571327
local cm=_G["c"..m]
cm.name="歪秤 黑武士"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Link
	aux.AddLinkProcedure(c,cm.mfilter,1,1)
	--Pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end
--Link
function cm.mfilter(c)
	return c:IsLevel(4) and c:IsLinkType(TYPE_EFFECT)
end