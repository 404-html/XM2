--鸣狐幽灯
function c44444245.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44444245+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c44444245.cost)
	e1:SetTarget(c44444245.target)
	e1:SetOperation(c44444245.operation)
	c:RegisterEffect(e1)
end
function c44444245.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,44444245)==0 end
	Duel.RegisterFlagEffect(tp,44444245,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c44444245.cfilter(c)
	return c:IsSetCard(0x642) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c44444245.sfilter(c)
	return c:IsSetCard(0x642) and c:IsSSetable() and not c:IsCode(44444245)
end
function c44444245.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
	and Duel.IsExistingMatchingCard(c44444245.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c44444245.sfilter,tp,LOCATION_DECK,0,1,nil) end
	local g1=Duel.GetMatchingGroup(c44444245.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,nil)
	local g2=Duel.GetMatchingGroup(c44444245.sfilter,tp,LOCATION_DECK,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g1,1,0,0)
end
function c44444245.operation(e,tp,eg,ep,ev,re,r,rp)
    local ct1=Duel.GetMatchingGroupCount(c44444245.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,nil)
	local rg=Duel.SelectMatchingCard(tp,c44444245.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,3,e:GetHandler())
	Duel.SendtoDeck(rg,nil,2,REASON_EFFECT)
	local ft=rg:GetCount()
	if ft<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c44444245.sfilter,tp,LOCATION_DECK,0,ft,ft,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
		Duel.SSet(tp,tc)
		tc=g:GetNext()
		end
		Duel.ConfirmCards(1-tp,g)
	end
end

