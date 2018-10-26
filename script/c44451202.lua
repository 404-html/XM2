--化学元素提取
function c44451202.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44451202+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c44451202.target)
	e1:SetOperation(c44451202.activate)
	c:RegisterEffect(e1)
end
function c44451202.tgfilter(c)
	return c:IsFaceup() and Duel.IsExistingMatchingCard(c44451202.cfilter,c:GetControler(),LOCATION_HAND+LOCATION_DECK,0,1,nil,c)
end
function c44451202.cfilter(c,tc)
	return c:IsSetCard(0x650) and c:IsType(TYPE_MONSTER) and c:GetOriginalAttribute()==tc:GetOriginalAttribute()
	and not c:IsCode(tc:GetCode()) and c:IsAbleToGrave()
end
function c44451202.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c44451202.tgfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44451202.tgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c44451202.tgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c44451202.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44451202.cfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,tc)
	if g:GetCount()>0 then
		local gc=g:GetFirst()
		if Duel.SendtoGrave(gc,REASON_EFFECT)~=0 and gc:IsLocation(LOCATION_GRAVE) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_CODE)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			e1:SetValue(gc:GetCode())
			tc:RegisterEffect(e1)
		end
	end
end
