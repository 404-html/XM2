--激活
function c32880002.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c32880002.actcon)
	e1:SetTarget(c32880002.target)
	e1:SetOperation(c32880002.activate)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32880002,0))
	e2:SetCategory(CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c32880002.thtg)
	e2:SetOperation(c32880002.operation)
	c:RegisterEffect(e2)
end
function c32880002.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x731)
end
function c32880002.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c32880002.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c32880002.filter(c)
	return c:IsPosition(POS_FACEUP) and c:IsCode(32880022)
end
function c32880002.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_FZONE) and chkc:IsControler(tp) and c32880002.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c32880002.filter,tp,LOCATION_FZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c32880002.filter,tp,LOCATION_FZONE,0,1,1,nil)
end
function c32880002.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc then
		tc:AddCounter(0x755,1)
	end
end
function c32880002.filter1(c)
	return c:IsSetCard(0x730) and c:IsAbleToHand()
end
function c32880002.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c32880002.filter1,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c32880002.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c32880002.filter1,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end