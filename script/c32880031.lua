--HS野兽 苔原犀牛
function c32880031.initial_effect(c)
	--effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c32880031.cona)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x734))
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c32880031.spcon)
	e2:SetOperation(c32880031.spop)
	c:RegisterEffect(e2)
end
function c32880031.cona(e)
	return e:GetHandler():IsPosition(POS_FACEUP)
end
function c32880031.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x733)
end
function c32880031.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c32880031.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsCanRemoveCounter(tp,1,0,0x755,5,REASON_COST)
end
function c32880031.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.RemoveCounter(tp,1,0,0x755,5,REASON_COST)
end