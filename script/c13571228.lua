local m=13571228
local cm=_G["c"..m]
cm.name="歪秤 惩戒枪"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Link
	aux.AddLinkProcedure(c,cm.mfilter,1,1)
	--Atk Up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(cm.atkval)
	c:RegisterEffect(e1)
end
--Link
function cm.mfilter(c)
	return c:IsLinkType(TYPE_PENDULUM)
end
--Atk Up
function cm.atkval(e,c)
	return Duel.GetMatchingGroupCount(Card.IsFaceup,c:GetControler(),LOCATION_EXTRA,0,nil)*200
end