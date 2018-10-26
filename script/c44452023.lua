--化学化合物-氧化铜
function c44452023.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
    aux.AddFusionProcCode2(c,44450008,44450029,true,true)
	--todeck and tograve
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44452023,0))
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c44452023.con)
	e1:SetTarget(c44452023.tg)
	e1:SetOperation(c44452023.op)
	c:RegisterEffect(e1)
	--todeck and tohand
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44452023,1))
	e11:SetCategory(CATEGORY_TOGRAVE)
	e11:SetType(EFFECT_TYPE_IGNITION)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCountLimit(1)

	e11:SetTarget(c44452023.target)
	e11:SetOperation(c44452023.operation)
	c:RegisterEffect(e11)
end
function c44452023.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION
end
function c44452023.tdfilter(c)
	return c:IsSetCard(0x650) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c44452023.tgfilter(c)
	return c:IsSetCard(0x650) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c44452023.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44452023.tdfilter,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingMatchingCard(c44452023.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c44452023.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tg=Duel.SelectMatchingCard(tp,c44452023.tdfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	local tc=tg:GetFirst()
	if tc and Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)~=0 then
		local g=Duel.GetMatchingGroup(c44452023.tgfilter,tp,LOCATION_DECK,0,nil)
		if g:GetCount()<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg1=g:Select(tp,1,1,nil)
		g:Remove(Card.IsCode,nil,sg1:GetFirst():GetCode())
		if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(44452023,2)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local sg2=g:Select(tp,1,1,nil)
			sg1:Merge(sg2)
		end
		Duel.SendtoGrave(sg1,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg1)
	end
end
--todeck and tohand
function c44452023.filter(c)
	return c:IsSetCard(0x650) and c:IsAbleToDeck() and c:IsType(TYPE_MONSTER)
end
function c44452023.refilter(c)
	return c:IsAbleToHand() and c:IsSetCard(0x651)
end
function c44452023.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c44452023.filter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c44452023.refilter,tp,LOCATION_DECK,0,1,nil) end
	if Duel.IsExistingTarget(c44452023.filter,tp,LOCATION_GRAVE,0,2,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectTarget(tp,c44452023.filter,tp,LOCATION_GRAVE,0,2,2,nil)
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,0,tp,1)
	end
end
function c44452023.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not tg or tg:FilterCount(Card.IsRelateToEffect,nil,e)~=2 then return end
	Duel.SendtoDeck(tg,nil,2,REASON_EFFECT)
	Duel.BreakEffect()
	local g=Duel.GetOperatedGroup()
	if g:IsExists(Card.IsLocation,1,nil,LOCATION_DECK) then Duel.ShuffleDeck(tp) end
	local ct=g:FilterCount(Card.IsLocation,nil,LOCATION_DECK+LOCATION_EXTRA)
	if ct==2 then
	    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=Duel.SelectMatchingCard(tp,c44452023.refilter,tp,LOCATION_DECK,0,1,1,nil)
		Duel.HintSelection(sg)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
	end
end