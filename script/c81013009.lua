--魔术师的自信
function c81013009.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,81013008)
	--counter
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(81013009,1))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,81013009)
	e3:SetCondition(aux.exccon)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c81013009.cttg)
	e3:SetOperation(c81013009.ctop)
	c:RegisterEffect(e3)
end
function c81013009.ctfilter(c)
	return c:IsFaceup() and c:IsCanAddCounter(0x1,3)
end
function c81013009.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c81013009.ctfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c81013009.ctfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,94)
	Duel.SelectTarget(tp,c81013009.ctfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x1)
end
function c81013009.ctop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		tc:AddCounter(0x1,3)
	end
end
