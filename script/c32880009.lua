--治疗之触
function c32880009.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(32880009,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c32880009.cost)
	e1:SetCondition(c32880009.actcon)
	e1:SetTarget(c32880009.target)
	e1:SetOperation(c32880009.activate)
	c:RegisterEffect(e1) 
	--recover
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32880009,1))
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCost(c32880009.cost)
	e2:SetCondition(c32880009.actcon)
	e2:SetTarget(c32880009.rectg)
	e2:SetOperation(c32880009.recop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(32880009,2))
	e3:SetCategory(CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c32880009.thtg)
	e3:SetOperation(c32880009.operation)
	c:RegisterEffect(e3)
end
function c32880009.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x755,3,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x755,3,REASON_COST)
end
function c32880009.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x731)
end
function c32880009.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c32880009.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c32880009.filter(c,e,tp)
	return (c:IsDefenseBelow(3500) or c:IsAttackBelow(3500)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
end
function c32880009.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c32880009.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c32880009.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c32880009.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c32880009.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c32880009.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(3500)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,3500)
end
function c32880009.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
function c32880009.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_DECK,0,1,nil) end
end
function c32880009.filter2(c)
	return c:IsPosition(POS_FACEUP) and c:IsCode(32880022)
end
function c32880009.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsType(TYPE_SPELL+TYPE_TRAP) and tc:IsSetCard(0x730) and tc:IsAbleToHand() then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ShuffleHand(tp)
		Duel.BreakEffect()
		local sg=Duel.SelectMatchingCard(tp,c32880009.filter2,tp,LOCATION_FZONE,0,1,1,nil)
		local hc=sg:GetFirst()
		hc:AddCounter(0x755,1)
	else
		Duel.DisableShuffleCheck()
		Duel.Destroy(tc,REASON_EFFECT+REASON_REVEAL)
	end
end

