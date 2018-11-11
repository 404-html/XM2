--野性成长
function c32880006.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c32880006.cost)
	e1:SetCondition(c32880006.actcon)
	e1:SetTarget(c32880006.target)
	e1:SetOperation(c32880006.activate)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32880006,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c32880006.thtg)
	e2:SetOperation(c32880006.thop)
	c:RegisterEffect(e2)
end
function c32880006.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x755,2,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x755,2,REASON_COST)
end
function c32880006.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x731)
end
function c32880006.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c32880006.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c32880006.filter(c)
	return c:IsPosition(POS_FACEUP) and c:IsCode(32880022)
end
function c32880006.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_FZONE) and chkc:IsControler(tp) and c32880006.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c32880006.filter,tp,LOCATION_FZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c32880006.filter,tp,LOCATION_FZONE,0,1,1,nil)
end
function c32880006.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() then
	   tc:EnableCounterPermit(0x755)
	   local e1=Effect.CreateEffect(c)
	   e1:SetDescription(aux.Stringid(32880022,0))
	   e1:SetCategory(CATEGORY_COUNTER)
	   e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	   e1:SetRange(LOCATION_FZONE)
	   e1:SetCountLimit(1)
	   e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	   e1:SetCondition(c32880006.ctcon)
	   e1:SetOperation(c32880006.ctop)
	   tc:RegisterEffect(e1)
	end
end
function c32880006.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c32880006.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=Duel.GetTurnCount()
	if ct<=10 then
	   c:AddCounter(0x755,1)
	end
end
function c32880006.thfilter(c)
	return c:IsSetCard(0x730) and c:IsAbleToHand()
end
function c32880006.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c32880006.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c32880006.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c32880006.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end