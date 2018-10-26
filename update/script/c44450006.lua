--化学单质-碳粉
function c44450006.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44450006,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE+LOCATION_HAND)
	e1:SetCountLimit(1,44450006)
	e1:SetCondition(c44450006.actcon)
    e1:SetCost(c44450006.spcost)
	e1:SetTarget(c44450006.sptg)
	e1:SetOperation(c44450006.spop)
	c:RegisterEffect(e1)
    --draw and remove
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44450006,1))
	e11:SetCategory(CATEGORY_DRAW+CATEGORY_REMOVE)
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e11:SetCode(EVENT_SPSUMMON_SUCCESS)
	e11:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e11:SetCountLimit(1,44451006)
	e11:SetTarget(c44450006.hsptg)
	e11:SetOperation(c44450006.hspop)
	c:RegisterEffect(e11)
	Duel.AddCustomActivityCounter(44450006,ACTIVITY_SPSUMMON,c44450006.counterfilter)
end
function c44450006.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x650)
end
function c44450006.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44450006.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c44450006.counterfilter(c)
	return c:IsSetCard(0x650)
end
function c44450006.filter(c)
	return c:IsAbleToGraveAsCost() and c:IsSetCard(0x652)
end
function c44450006.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(44450006,tp,ACTIVITY_SPSUMMON)==0
	and Duel.IsExistingMatchingCard(c44450006.filter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44450006.filter,tp,LOCATION_EXTRA,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c44450006.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c44450006.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x650) 
end
function c44450006.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c44450006.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
--draw and remove
function c44450006.efilter(c)
	return c:IsFaceup() 
end
function c44450006.hsptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c44450006.hspop(e,tp,eg,ep,ev,re,r,rp)
		local ct=Duel.Draw(tp,1,REASON_EFFECT)
		if ct==0 then return end
		local dc=Duel.GetOperatedGroup():GetFirst()
		if dc:IsSetCard(0x650) and Duel.IsExistingMatchingCard(c44450006.efilter,tp,0,LOCATION_MZONE,1,nil)
			and Duel.SelectYesNo(tp,aux.Stringid(44450006,2)) then
			Duel.BreakEffect()
			Duel.ConfirmCards(1-tp,dc)
			local g=Duel.SelectMatchingCard(tp,c44450006.efilter,tp,0,LOCATION_MZONE,1,1,nil)
			local tc=g:GetFirst()
			if Duel.Remove(tc,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
            local e1=Effect.CreateEffect(e:GetHandler())
   		    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		    e1:SetCode(EVENT_PHASE+PHASE_END)
		    e1:SetReset(RESET_PHASE+PHASE_END)
		    e1:SetLabelObject(tc)
		    e1:SetCountLimit(1)
		    e1:SetOperation(c44450006.retop)
		    Duel.RegisterEffect(e1,tp)
			Duel.ShuffleHand(tp)
		end
	end
end
function c44450006.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetLabelObject())
end