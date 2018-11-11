--百夜之后白昼为先
function c44449029.initial_effect(c)
	--synchro summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44449029+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c44449029.cost)
	e1:SetTarget(c44449029.target)
	e1:SetOperation(c44449029.activate)
	c:RegisterEffect(e1)
	--poschange
	local e22=Effect.CreateEffect(c)
	e22:SetDescription(aux.Stringid(44449029,1))
	e22:SetCategory(CATEGORY_POSITION)
	e22:SetType(EFFECT_TYPE_IGNITION)
	e22:SetRange(LOCATION_GRAVE)
	e22:SetCost(aux.bfgcost)
	e22:SetTarget(c44449029.chtg)
	e22:SetOperation(c44449029.chop)
	c:RegisterEffect(e22)
end
function c44449029.cfilter(c,tp)
	return c:IsSetCard(0x644) and c:IsAbleToDeckAsCost()
end
function c44449029.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44444499.cfilter,tp,LOCATION_REMOVED,0,10,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c44444499.cfilter,tp,LOCATION_REMOVED,0,10,10,e:GetHandler())
	Duel.SendtoDeck(g,nil,2,REASON_COST)
	Duel.ShuffleDeck(tp)
end
function c44449029.filter(c,e,tp)
	return c:IsCode(44447200) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false)
end
function c44449029.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCountFromEx(tp)>0
		and aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_SMATERIAL)
		and Duel.IsExistingMatchingCard(c44449029.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c44449029.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCountFromEx(tp)<=0 or not aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_SMATERIAL) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c44449029.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_CANNOT_ATTACK)
		e4:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e4:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e4,true)
		tc:CompleteProcedure()
	end
end
--poschange
function c44449029.chfilter(c)
	return not c:IsPosition(POS_FACEUP_DEFENSE) and c:IsCanChangePosition()
end
function c44449029.chtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44449029.chfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c44449029.chfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c44449029.chop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c44449029.chfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
	end
end