--鱼人总动员
function c32880229.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCondition(c32880229.spcon)
	e1:SetCost(c32880229.lvcost)
	e1:SetOperation(c32880229.activate)
	c:RegisterEffect(e1)
end
function c32880229.tfilter(c,e,tp)
	return c:IsCode(32880230) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c32880229.filter(c,e,tp)
	return c:IsSetCard(0x735)
		and Duel.IsExistingMatchingCard(c32880229.tfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp)
		and Duel.GetLocationCountFromEx(tp,tp,c)>0
end
function c32880229.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x744)
end
function c32880229.spcon(e,c)
	return Duel.IsExistingMatchingCard(c32880229.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c32880229.lvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x755,1,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x755,1,REASON_COST)
end
function c32880229.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectTarget(tp,c32880229.filter,tp,LOCATION_MZONE+LOCATION_HAND+LOCATION_GRAVE,0,5,5,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	Duel.BreakEffect()
	if Duel.GetLocationCountFromEx(tp)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c32880229.tfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if sg:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SpecialSummon(sg,0,tp,tp,true,false,POS_FACEUP)
		sg:GetFirst():CompleteProcedure()
	end
end
