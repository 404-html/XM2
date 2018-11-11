--HS 蛮鱼图腾
function c32880235.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c32880235.spcon)
	e1:SetOperation(c32880235.spop)
	c:RegisterEffect(e1)
	--token
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,32880235)
	e2:SetTarget(c32880235.target)
	e2:SetOperation(c32880235.operation)
	c:RegisterEffect(e2)
end
function c32880235.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x744)
end
function c32880235.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c32880235.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsCanRemoveCounter(tp,1,0,0x755,2,REASON_COST)
end
function c32880235.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.RemoveCounter(tp,1,0,0x755,2,REASON_COST)
end
function c32880235.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
	   and Duel.IsPlayerCanSpecialSummonMonster(tp,32880236,0x730,0x4011,500,500,1,RACE_FISH,ATTRIBUTE_WATER) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c32880235.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,32880236,0x730,0x4011,500,500,1,RACE_FISH,ATTRIBUTE_WATER) then
			local token=Duel.CreateToken(tp,32880236)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	end
		Duel.SpecialSummonComplete()
end