--神龙天征
function c44444010.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44444010+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCondition(c44444010.condition)
	e1:SetCost(c44444010.cost)
	e1:SetTarget(c44444010.target)
	e1:SetOperation(c44444010.activate)
	c:RegisterEffect(e1)
end
function c44444010.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c44444010.cfilter1(c,rg)
	if not c:IsAttribute(ATTRIBUTE_WIND) then return false end
	rg:RemoveCard(c)
	local ret=rg:IsExists(c44444010.cfilter2,1,nil,rg)
	rg:AddCard(c)
	return ret
end
function c44444010.cfilter2(c,rg)
	if not c:IsAttribute(ATTRIBUTE_WATER) then return false end
	rg:RemoveCard(c)
	local ret=rg:IsExists(c44444010.cfilter3,1,nil,rg)
	rg:AddCard(c)
	return ret
end
function c44444010.cfilter3(c,rg)
	if not c:IsAttribute(ATTRIBUTE_FIRE) then return false end
	rg:RemoveCard(c)
	local ret=rg:IsExists(c44444010.cfilter4,1,nil,rg)
	rg:AddCard(c)
	return ret
end
function c44444010.cfilter4(c,rg)
	if not c:IsAttribute(ATTRIBUTE_EARTH) then return false end
	rg:RemoveCard(c)
	local ret=rg:IsExists(c44444010.cfilter5,1,nil,rg)
	rg:AddCard(c)
	return ret
end
function c44444010.cfilter5(c,rg)
	if not c:IsAttribute(ATTRIBUTE_DARK) then return false end
	rg:RemoveCard(c)
	local ret=rg:IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_LIGHT)
	rg:AddCard(c)
	return ret
end

function c44444010.rfilter(c)
	return c:IsFaceup() and c:IsHasEffect(EFFECT_EXTRA_RELEASE) and c:IsAbleToRemove() and c:IsRace(RACE_DRAGON)
end
function c44444010.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_SPSUMMON)==0 and Duel.GetActivityCount(tp,ACTIVITY_BATTLE_PHASE)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_BP)
	Duel.RegisterEffect(e2,tp)
	local g1=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,LOCATION_DECK+LOCATION_EXTRA,0,nil)
	local g2=Duel.GetMatchingGroup(c44444010.rfilter,tp,0,LOCATION_DECK+LOCATION_EXTRA,nil)
	g1:Merge(g2)
	if chk==0 then return g1:GetCount()>5 and g1:IsExists(c44444010.cfilter1,1,nil,g1) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg1=g1:FilterSelect(tp,c44444010.cfilter1,1,1,nil,g1)
	g1:Sub(rg1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg2=g1:FilterSelect(tp,c44444010.cfilter2,1,1,nil,g1)
	g1:Sub(rg2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg3=g1:FilterSelect(tp,c44444010.cfilter3,1,1,nil,g1)
	g1:Sub(rg3)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg4=g1:FilterSelect(tp,c44444010.cfilter4,1,1,nil,g1)
	g1:Sub(rg4)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg5=g1:FilterSelect(tp,c44444010.cfilter5,1,1,nil,g1)
	g1:Sub(rg5)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg6=g1:FilterSelect(tp,Card.IsAttribute,1,1,nil,ATTRIBUTE_LIGHT)
	rg1:Merge(rg2)
	rg1:Merge(rg3)
	rg1:Merge(rg4)
	rg1:Merge(rg5)
	rg1:Merge(rg6)
	Duel.Remove(rg1,POS_FACEUP,REASON_COST)
end
function c44444010.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c44444010.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,aux.ExceptThisCard(e))
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end
