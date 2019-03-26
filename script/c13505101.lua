local m=13505101
local cm=_G["c"..m]
cm.name="东元帅 威斯海德"
function cm.initial_effect(c)
	--Pendulum Summon
	aux.EnablePendulumAttribute(c)
	--Special Summon Proc
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTargetRange(POS_FACEUP_ATTACK,0)
	e1:SetCondition(cm.sppcon)
	e1:SetOperation(cm.sppop)
	c:RegisterEffect(e1)
end
--Special Summon Proc
function cm.sppfilter(c)
	return c:IsCode(m) and c:IsAbleToRemoveAsCost()
end
function cm.sppcon(e,c)
	if c==nil then return true end
	return Duel.GetMZoneCount(c:GetControler())>0
		and Duel.IsExistingMatchingCard(cm.sppfilter,c:GetControler(),LOCATION_DECK,0,1,nil)
end
function cm.sppop(e,tp,eg,ep,ev,re,r,rp,c)
	local tc=Duel.GetFirstMatchingCard(cm.sppfilter,tp,LOCATION_DECK,0,nil)
	Duel.Remove(tc,POS_FACEUP,REASON_COST)
end