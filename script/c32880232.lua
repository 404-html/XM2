--冰钓术
function c32880232.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c32880232.cost)
	e1:SetCondition(c32880232.actcon)
	e1:SetTarget(c32880232.target)
	e1:SetOperation(c32880232.activate)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32880232,0))
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c32880232.destg)
	e2:SetOperation(c32880232.operation)
	c:RegisterEffect(e2)
end
function c32880232.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x755,2,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x755,2,REASON_COST)
end
function c32880232.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x744)
end
function c32880232.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c32880232.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c32880232.filter(c)
	return c:IsSetCard(0x735) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c32880232.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c32880232.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_DECK)
end
function c32880232.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c32880232.filter,tp,LOCATION_DECK,0,2,2,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c32880232.filter2(c)
	return c:IsPosition(POS_FACEUP) and c:IsCode(32880022)
end
function c32880232.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_FZONE) and chkc:IsControler(tp) and c32880232.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c32880232.filter2,tp,LOCATION_FZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c32880232.filter2,tp,LOCATION_FZONE,0,1,1,nil)
end
function c32880232.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc then
		tc:AddCounter(0x755,2)
	end
end