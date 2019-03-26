--炎之怀抱
function c44770244.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44770244+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c44770244.target)
	e1:SetOperation(c44770244.activate)
	c:RegisterEffect(e1)
end
function c44770244.tgfilter(c)
	return c:IsAttribute(ATTRIBUTE_FIRE) and c:IsAbleToGrave()
end
function c44770244.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44770244.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c44770244.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44770244.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and Duel.SendtoGrave(tc,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_GRAVE) and tc:IsType(TYPE_NORMAL)
		and Duel.IsExistingMatchingCard(c44770244.tgfilter,tp,0,LOCATION_MZONE,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(44770244,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g1=Duel.SelectMatchingCard(tp,c44770244.tgfilter,tp,0,LOCATION_MZONE,1,1,nil)
		Duel.Destroy(g1,REASON_EFFECT)
	end
end

