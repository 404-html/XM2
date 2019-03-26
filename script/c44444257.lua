--鸣狐-盛装祭典·次回
function c44444257.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44444257+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c44444257.con)
	e1:SetOperation(c44444257.activate)
	c:RegisterEffect(e1)
	--act in set turn
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetCondition(c44444257.actcon)
	c:RegisterEffect(e2)
	--act qp in hand
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_FIELD)
	e11:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e11:SetRange(LOCATION_SZONE)
	e11:SetTargetRange(LOCATION_HAND,0)
	e11:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x642))
	e11:SetCountLimit(1)
	e11:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e11:SetCondition(c44444257.condition)
	--e11:SetCost(c44444257.cost)
	c:RegisterEffect(e11)
	--Atk
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_FIELD)
	e21:SetCode(EFFECT_UPDATE_ATTACK)
	e21:SetRange(LOCATION_SZONE)
	e21:SetTargetRange(LOCATION_MZONE,0)
	e21:SetTarget(c44444257.tg)
	e21:SetValue(100)
	c:RegisterEffect(e21)
end
--act in set turn
function c44444257.actcon(e)
	return not Duel.IsExistingMatchingCard(Card.IsType,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil,TYPE_MONSTER)
end
--Atk
function c44444257.tg(e,c)
	return c:IsSetCard(0x642)
end
--Activate
function c44444257.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c44444257.thfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHand() and c:IsSetCard(0x642)
end
function c44444257.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c44444257.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(44444257,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
--act qp in hand
function c44444257.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c44444257.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44444257.cfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c44444257.cfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil)
	if g:GetFirst():IsLocation(LOCATION_HAND) then
		Duel.ConfirmCards(1-tp,g)
	end
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c44444257.cfilter(c)
	return c:IsSetCard(0x642) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeckAsCost() and (c:IsLocation(LOCATION_HAND) or c:IsFaceup())
end