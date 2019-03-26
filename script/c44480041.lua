--瞳器·无慈悲之刃
function c44480041.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44480041,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCountLimit(1,44480041+EFFECT_COUNT_CODE_OATH)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c44480041.target)
	e1:SetOperation(c44480041.activate)
	c:RegisterEffect(e1)
	--atk
	local e20=Effect.CreateEffect(c)
	e20:SetType(EFFECT_TYPE_EQUIP)
	e20:SetCode(EFFECT_UPDATE_ATTACK)
	e20:SetValue(500)
	c:RegisterEffect(e20)
	--disable
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_EQUIP)
	e21:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e21)
	--immune
	local e51=Effect.CreateEffect(c)
	e51:SetType(EFFECT_TYPE_EQUIP)
	e51:SetCode(EFFECT_IMMUNE_EFFECT)
	e20:SetCondition(c44480041.descon)
	e51:SetValue(c44480041.efilter)
	c:RegisterEffect(e51)
end
function c44480041.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget():IsSetCard(0x645)
end
function c44480041.efilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer() and te:IsActiveType(TYPE_MONSTER)
end
--ds deck
function c44480041.dkfilter(c)
	return c:IsSetCard(0x647) or c:IsSetCard(0x648)
end
function c44480041.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44480041.dkfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44480041.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44480041.dkfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
