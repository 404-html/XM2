--我俏丽吗
function c91000005.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(91000005,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c91000005.target)
	e1:SetOperation(c91000005.activate)
	c:RegisterEffect(e1)
end
function c91000005.filter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_LINK) and c:GetLinkedGroupCount()>0
end
function c91000005.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE)  and c91000005.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c91000005.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c91000005.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
   
end
function c91000005.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	 local lg=tc:GetLinkedGroup():Filter(Card.IsAbleToHand,nil)
	Duel.SendtoHand(lg,nil,REASON_EFFECT)
end
