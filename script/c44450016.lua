--化学单质-硫磺 
function c44450016.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44450016,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE+LOCATION_HAND)
	e1:SetCountLimit(1,44450016)
	e1:SetCondition(c44450016.actcon)
    e1:SetCost(c44450016.spcost)
	e1:SetTarget(c44450016.sptg)
	e1:SetOperation(c44450016.spop)
	c:RegisterEffect(e1)
	--special summon1
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44450016,1))
	e11:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e11:SetType(EFFECT_TYPE_IGNITION)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCountLimit(1,44451016)
	e11:SetCost(c44450016.cost1)
	e11:SetTarget(c44450016.target1)
	e11:SetOperation(c44450016.operation1)
	c:RegisterEffect(e11)
	--special summon2
	local e12=Effect.CreateEffect(c)
	e12:SetDescription(aux.Stringid(44450016,2))
	e12:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e12:SetType(EFFECT_TYPE_IGNITION)
	e12:SetRange(LOCATION_MZONE)
	e12:SetCountLimit(1,44451016)
	e12:SetCost(c44450016.cost2)
	e12:SetTarget(c44450016.target2)
	e12:SetOperation(c44450016.operation2)
	c:RegisterEffect(e12)
	Duel.AddCustomActivityCounter(44450016,ACTIVITY_SPSUMMON,c44450016.counterfilter)
end
function c44450016.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x650)
end
function c44450016.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44450016.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c44450016.counterfilter(c)
	return c:IsSetCard(0x650)
end
function c44450016.filter(c)
	return c:IsAbleToGraveAsCost() and c:IsSetCard(0x652)
end
function c44450016.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(44450016,tp,ACTIVITY_SPSUMMON)==0
	and Duel.IsExistingMatchingCard(c44450016.filter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44450016.filter,tp,LOCATION_EXTRA,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c44450016.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c44450016.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x650) 
end
function c44450016.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c44450016.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
--special summon1+2
function c44450016.spfilter(c,e,tp)
	return c:IsSetCard(0x651) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c44450016.costfilter(c)
	return c:IsAbleToGraveAsCost() and c:IsSetCard(0x652)
end
function c44450016.costfilter2(c)
	return c:IsSetCard(0x652)
end
function c44450016.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44450016.costfilter,tp,LOCATION_EXTRA,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local cg=Duel.SelectMatchingCard(tp,c44450016.costfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	Duel.SendtoGrave(cg,REASON_COST)
	e:SetLabel(cg:GetCount())
end
function c44450016.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44450016.costfilter2,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local cg=Duel.SelectMatchingCard(tp,c44450016.costfilter2,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SendtoDeck(cg,nil,1,REASON_EFFECT)
	e:SetLabel(cg:GetCount())
end
function c44450016.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c44450016.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	local g=Duel.GetMatchingGroup(c44450016.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end
function c44450016.operation1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetMatchingGroup(c44450016.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()==0 then return end
	local ct=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectMatchingCard(tp,c44450016.spfilter,tp,LOCATION_DECK,0,1,ct,nil,e,tp)
	if g2:GetCount()>0 then
		local tc=g2:GetFirst()
		while tc do
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
			local e1=Effect.CreateEffect(e:GetHandler())
            e1:SetType(EFFECT_TYPE_SINGLE)
	        e1:SetCode(EFFECT_DISABLE)
	        e1:SetReset(RESET_EVENT+0x1fe0000)
	        tc:RegisterEffect(e1)
          	local e2=Effect.CreateEffect(e:GetHandler())
            e2:SetType(EFFECT_TYPE_SINGLE)
	        e2:SetCode(EFFECT_DISABLE_EFFECT)
	        e2:SetReset(RESET_EVENT+0x1fe0000)
	        tc:RegisterEffect(e2)
			tc:RegisterFlagEffect(44450016,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
			tc=g2:GetNext()			
		end
	end
	Duel.SpecialSummonComplete()
	g2:KeepAlive()
	local e11=Effect.CreateEffect(e:GetHandler())
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e11:SetCode(EVENT_PHASE+PHASE_END)
	e11:SetReset(RESET_PHASE+PHASE_END)
	e11:SetCountLimit(1)
	e11:SetLabelObject(g2)
	e11:SetOperation(c44450016.desop)
	Duel.RegisterEffect(e11,tp)
end
function c44450016.desfilter(c)
	return c:GetFlagEffect(44450016)>0
end
function c44450016.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c44450016.desfilter,nil)
	g:DeleteGroup()
	Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)
end

function c44450016.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c44450016.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	local g=Duel.GetMatchingGroup(c44450016.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end
function c44450016.operation2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetMatchingGroup(c44450016.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()==0 then return end
	local ct=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectMatchingCard(tp,c44450016.spfilter,tp,LOCATION_DECK,0,1,ct,nil,e,tp)
	if g2:GetCount()>0 then
		local tc=g2:GetFirst()
		while tc do
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
			local e1=Effect.CreateEffect(e:GetHandler())
            e1:SetType(EFFECT_TYPE_SINGLE)
	        e1:SetCode(EFFECT_DISABLE)
	        e1:SetReset(RESET_EVENT+0x1fe0000)
	        tc:RegisterEffect(e1)
          	local e2=Effect.CreateEffect(e:GetHandler())
            e2:SetType(EFFECT_TYPE_SINGLE)
	        e2:SetCode(EFFECT_DISABLE_EFFECT)
	        e2:SetReset(RESET_EVENT+0x1fe0000)
	        tc:RegisterEffect(e2)
			tc:RegisterFlagEffect(44450016,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
			tc=g2:GetNext()			
		end
	end
	Duel.SpecialSummonComplete()
	g2:KeepAlive()
	local e11=Effect.CreateEffect(e:GetHandler())
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e11:SetCode(EVENT_PHASE+PHASE_END)
	e11:SetReset(RESET_PHASE+PHASE_END)
	e11:SetCountLimit(1)
	e11:SetLabelObject(g2)
	e11:SetOperation(c44450016.desop)
	Duel.RegisterEffect(e11,tp)
end
