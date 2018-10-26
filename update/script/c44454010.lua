--反应物过量
function c44454010.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_REMOVE+CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44454010+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c44454010.target)
	e1:SetOperation(c44454010.activate)
	c:RegisterEffect(e1)
	--tograve
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(44454010,1))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c44454010.tgtg1)
	e3:SetOperation(c44454010.tgop1)
	c:RegisterEffect(e3)
	--todeck
	local e33=Effect.CreateEffect(c)
	e33:SetDescription(aux.Stringid(44454010,2))
	e33:SetCategory(CATEGORY_TODECK)
	e33:SetType(EFFECT_TYPE_QUICK_O)
	e33:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e33:SetCode(EVENT_FREE_CHAIN)
	e33:SetRange(LOCATION_GRAVE)
	e33:SetCost(aux.bfgcost)
	e33:SetTarget(c44454010.tgtg2)
	e33:SetOperation(c44454010.tgop2)
	c:RegisterEffect(e33)
end
function c44454010.efilter(c,e,tp)
	return c:IsSetCard(0x651) and c:IsAbleToRemove()
end
function c44454010.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,30459350) and Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c44454010.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	Duel.ShuffleHand(p)
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(p,Card.IsSetCard,p,LOCATION_HAND,0,1,1,nil,0x651)
	local tg=g:GetFirst()
	if tg then
		if Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)==0 then
			Duel.ConfirmCards(1-p,tg)
			Duel.ShuffleHand(p)
		end
	else
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_FIELD)
	    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	    e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	    e1:SetReset(RESET_PHASE+PHASE_END)
	    e1:SetTargetRange(1,0)
		e1:SetTarget(c44454010.splimit)
	    Duel.RegisterEffect(e1,tp)
	end
end
function c44454010.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x650)
end
--tograve
function c44454010.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x652) and c:IsAbleToGrave()
end
function c44454010.tgtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44454010.cfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_EXTRA)
end
function c44454010.tgop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44454010.cfilter,tp,LOCATION_EXTRA,0,1,3,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
--todeck
function c44454010.filter(c,tid)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToDeck() and c:IsSetCard(0x650)
end
function c44454010.tgtg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c44454010.filter(chkc,Duel.GetTurnCount()) end
	if chk==0 then return Duel.IsExistingTarget(c44454010.filter,tp,LOCATION_GRAVE,0,1,nil,Duel.GetTurnCount()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c44454010.filter,tp,LOCATION_GRAVE,0,1,3,nil,Duel.GetTurnCount())
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c44454010.tgop2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
	end
end