--红魔✿小恶魔
function c60300.initial_effect(c)
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60300,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c60300.sumop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(60300,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,60300)
	e3:SetCondition(c60300.spcon)
	e3:SetTarget(c60300.sptg)
	e3:SetOperation(c60300.spop)
	c:RegisterEffect(e3)
end
function c60300.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,59463312)~=0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetValue(0x1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_EXTRA_SET_COUNT)
	Duel.RegisterEffect(e2,tp)
	Duel.RegisterFlagEffect(tp,59463312,RESET_PHASE+PHASE_END,0,1)
end
function c60300.cfilter(c,tp)
	return c:IsSetCard(0x813) and c:IsReason(REASON_DESTROY)
		and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp
end
function c60300.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c60300.cfilter,1,nil,tp)
end
function c60300.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c60300.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x47e0000)
		e1:SetValue(LOCATION_DECK)
		c:RegisterEffect(e1,true)
		--synchro effect
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(aux.Stringid(60300,2))
		e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e2:SetType(EFFECT_TYPE_QUICK_O)
		e2:SetCode(EVENT_FREE_CHAIN)
		e2:SetCountLimit(1)	
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCondition(c60300.sccon)
		e2:SetTarget(c60300.sctarg)
		e2:SetOperation(c60300.scop)
		c:RegisterEffect(e2)
	end
end
function c60300.sccon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
		and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
end
function c60300.sctarg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(60300)==0
		and Duel.IsExistingMatchingCard(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,1,nil,c) end
	c:RegisterFlagEffect(60300,RESET_CHAIN,0,1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c60300.scop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetControler()~=tp or not c:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,nil,c)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SynchroSummon(tp,sg:GetFirst(),c)
	end
end
