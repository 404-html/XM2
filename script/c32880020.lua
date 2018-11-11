--HS 森林狼
function c32880020.initial_effect(c)
	--boost
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c32880020.tg)
	e1:SetValue(500)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c32880020.spcon)
	e2:SetOperation(c32880020.spop)
	c:RegisterEffect(e2)
end
function c32880020.tg(e,c)
	return c:IsSetCard(0x734) and c~=e:GetHandler()
end
function c32880020.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x733)
end
function c32880020.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c32880020.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
		   and Duel.IsCanRemoveCounter(tp,1,0,0x755,1,REASON_COST)
end
function c32880020.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.RemoveCounter(tp,1,0,0x755,1,REASON_COST)
end