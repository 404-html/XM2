local m=13507031
local cm=_G["c"..m]
cm.name="珊海的绝隶王&姬"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Synchro Summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),2)
	--Cannot Attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCondition(cm.atkcon)
	e1:SetTarget(cm.atktg)
	c:RegisterEffect(e1)
	--Immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(cm.efilter)
	c:RegisterEffect(e2)
end
--Cannot Attack
function cm.atkcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function cm.atktg(e,c)
	return c:GetAttack()<e:GetHandler():GetAttack()
end
--Immune
function cm.efilter(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:GetHandler():GetAttack()<e:GetHandler():GetAttack()
end