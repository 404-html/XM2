--化学化合物-氧化钙
function c44452021.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
    aux.AddFusionProcCode2(c,44450008,44450020,true,true)
	--to deck and sset
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44452021,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c44452021.con)
	e1:SetTarget(c44452021.tg)
	e1:SetOperation(c44452021.op)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c44452021.reptg)
	e2:SetValue(c44452021.repval)
	c:RegisterEffect(e2)
end
--to deck and sset
function c44452021.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION
end
function c44452021.filter(c)
	return c:IsSetCard(0x650) and c:IsAbleToDeck() and c:IsType(TYPE_MONSTER)
end
function c44452021.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c44452021.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44452021.filter,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingMatchingCard(c44452021.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	if Duel.IsExistingTarget(c44452021.filter,tp,LOCATION_GRAVE,0,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectTarget(tp,c44452021.filter,tp,LOCATION_GRAVE,0,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
	end
end
function c44452021.thfilter(c)
	return c:IsSSetable() and c:IsSetCard(0x650) and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c44452021.sfilter(c)
	return c:IsAbleToHand() and c:IsSetCard(0x650)
end
function c44452021.op(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not tg or tg:FilterCount(Card.IsRelateToEffect,nil,e)~=1 then return end
	Duel.SendtoDeck(tg,nil,0,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	if g:IsExists(Card.IsLocation,1,nil,LOCATION_DECK) then Duel.ShuffleDeck(tp) end
	local ct=g:FilterCount(Card.IsLocation,nil,LOCATION_DECK+LOCATION_EXTRA)
	if ct==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
		local sg=Duel.SelectMatchingCard(tp,c44452021.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
		if sg:GetCount()>0 then
			Duel.BreakEffect()
			Duel.SSet(tp,sg:GetFirst())
			Duel.ConfirmCards(1-tp,sg)
		end
	end
end
--destroy replace
function c44452021.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_SZONE)
	and c:IsSetCard(0x650) and c:IsReason(REASON_EFFECT)
end
function c44452021.rmfilter(c)
	return c:IsSetCard(0x650) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c44452021.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c44452021.repfilter,1,nil,tp)
		and Duel.IsExistingMatchingCard(c44452021.rmfilter,tp,LOCATION_GRAVE,0,1,nil) end
	if Duel.SelectEffectYesNo(tp,e:GetHandler(),96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,c44452021.rmfilter,tp,LOCATION_GRAVE,0,1,1,nil)
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT+REASON_REPLACE)
		return true
	end
	return false
end
function c44452021.repval(e,c)
	return c44452021.repfilter(c,e:GetHandlerPlayer())
end