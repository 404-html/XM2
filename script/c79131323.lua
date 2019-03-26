--灵噬·疫
function c79131323.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,99,c79131323.lcheck)
	c:EnableReviveLimit()
	--Cannot target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTargetRange(LOCATION_ONFIELD,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x1204))
	e1:SetValue(c79131323.evalue)
	c:RegisterEffect(e1)
	--position
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(79131323,0))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,79131323)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCost(c79131323.cost)
	e2:SetTarget(c79131323.target)
	e2:SetOperation(c79131323.activate)
	c:RegisterEffect(e2)
	--disable and destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_CHAIN_ACTIVATING)
	e3:SetTargetRange(1,1)
	e3:SetCondition(c79131323.condition)
	e3:SetOperation(c79131323.disop)
	c:RegisterEffect(e3)
end
function c79131323.lcheck(g,lc)
	return g:IsExists(Card.IsLinkSetCard,1,nil,0x1204)
end
function c79131323.evalue(e,re,rp)
	return rp==1-e:GetHandlerPlayer()
end
function c79131323.filter1(c)
	return (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsSetCard(0x1204) and c:IsType(TYPE_MONSTER) and not c:IsCode(79131323) and c:IsAbleToRemoveAsCost()
end
function c79131323.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c79131323.filter1,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c79131323.filter1,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c79131323.filter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c79131323.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c79131323.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c79131323.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c79131323.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c79131323.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsLocation(LOCATION_MZONE) and tc:IsFaceup() then
		Duel.ChangePosition(tc,POS_FACEDOWN_DEFENSE)
	end
end
function c79131323.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()>3
end
function c79131323.disop(e,tp,eg,ep,ev,re,r,rp)
	if chk==0 then return end
	local rc=re:GetHandler()
	Duel.NegateEffect(ev)
end