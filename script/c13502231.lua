local m=13502231
local cm=_G["c"..m]
cm.name="蜥蜴姬 法姆"
function cm.initial_effect(c)
	--Dual Status
	aux.EnableDualAttribute(c)
	--Atk 2800
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(aux.IsDualState)
	e1:SetValue(2800)
	c:RegisterEffect(e1)
	--Immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(aux.IsDualState)
	e2:SetValue(cm.efilter)
	c:RegisterEffect(e2)
end
--Immune
function cm.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end