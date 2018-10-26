--化学化合物-氢氧化铜
function c44452018.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode3(c,44450001,44450008,44450029,true,true)
	--to deck and NEGATE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44452018,0))
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_POSITION+CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c44452018.con)
	e1:SetTarget(c44452018.tg)
	e1:SetOperation(c44452018.op)
	c:RegisterEffect(e1)
	--spsummon and remove
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44452018,1))
	e11:SetCategory(CATEGORY_REMOVE)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetRange(LOCATION_MZONE)
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e11:SetProperty(EFFECT_FLAG_DELAY)
	e11:SetCode(EVENT_SPSUMMON_SUCCESS)
	e11:SetCountLimit(1)
	e11:SetCost(c44452018.cost)
	e11:SetTarget(c44452018.target)
	e11:SetOperation(c44452018.operation)
	c:RegisterEffect(e11)
	--exsummon
	local e31=Effect.CreateEffect(c)
	e31:SetDescription(aux.Stringid(44452018,2))
	e31:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e31:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e31:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e31:SetCode(EVENT_TO_GRAVE)
	e31:SetCondition(c44452018.escon)
	e31:SetTarget(c44452018.estg)
	e31:SetOperation(c44452018.esop)
	c:RegisterEffect(e31)
end
function c44452018.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION
end
function c44452018.filter(c)
	return c:IsSetCard(0x650) and c:IsAbleToDeck() and c:IsType(TYPE_MONSTER)
end
function c44452018.chfilter(c)
	return not c:IsPosition(POS_FACEUP_DEFENSE) and c:IsCanChangePosition()
end
function c44452018.dfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c44452018.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c44452018.filter(chkc) end
    if chk==0 then return Duel.IsExistingMatchingCard(c44452018.chfilter,tp,0,LOCATION_MZONE,1,nil) end
	if Duel.IsExistingTarget(c44452018.filter,tp,LOCATION_GRAVE,0,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g1=Duel.SelectTarget(tp,c44452018.filter,tp,LOCATION_GRAVE,0,1,1,nil)
		local g2=Duel.GetMatchingGroup(c44452018.chfilter,tp,0,LOCATION_MZONE,nil)
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g1,g1:GetCount(),0,0)
		Duel.SetOperationInfo(0,CATEGORY_POSITION,g2,g2:GetCount(),0,LOCATION_MZONE)
	end
end	
function c44452018.op(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not tg or tg:FilterCount(Card.IsRelateToEffect,nil,e)~=1 then return end
	Duel.SendtoDeck(tg,nil,0,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	if g:IsExists(Card.IsLocation,1,nil,LOCATION_DECK) then Duel.ShuffleDeck(tp) end
	local ct=g:FilterCount(Card.IsLocation,nil,LOCATION_DECK+LOCATION_EXTRA)
	if ct==1 then
    local g=Duel.GetMatchingGroup(c44452018.dfilter,tp,0,LOCATION_ONFIELD,nil)
	local cg=Duel.GetMatchingGroup(c44452018.chfilter,tp,0,LOCATION_MZONE,nil)
	if cg:GetCount()>0 then
		Duel.ChangePosition(cg,POS_FACEUP_DEFENSE)
	       local tc=g:GetFirst()
	       local c=e:GetHandler()
	       while tc do
		    local e1=Effect.CreateEffect(c)
		    e1:SetType(EFFECT_TYPE_SINGLE)
		    e1:SetCode(EFFECT_DISABLE)
		    e1:SetReset(RESET_PHASE+PHASE_END)
		    tc:RegisterEffect(e1)
		    local e2=Effect.CreateEffect(c)
		    e2:SetType(EFFECT_TYPE_SINGLE)
		    e2:SetCode(EFFECT_DISABLE_EFFECT)
		    e2:SetReset(RESET_PHASE+PHASE_END)
		    tc:RegisterEffect(e2)
		    tc=g:GetNext() 
			end
	    end
	end
end
--spsummon and remove
function c44452018.cfilter(c,tp)
	return c:IsAbleToDeckAsCost() and c:IsSetCard(0x650) and c:IsType(TYPE_MONSTER)
end
function c44452018.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44452018.cfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c44452018.cfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	Duel.SendtoDeck(g,nil,2,REASON_COST)
	Duel.ShuffleDeck(tp)
end
function c44452018.refilter(c,e)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT) and ep~=tp
		and (not e or c:IsRelateToEffect(e)) and c:IsAbleToRemove()
end
function c44452018.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c44452018.refilter,1,nil,nil) end
	local g=eg:Filter(c44452018.refilter,nil,nil)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c44452018.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c44452018.refilter,nil,e)
	if g:GetCount()>0 then
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
--exsummon
function c44452018.escon(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return e:GetHandler():IsReason(REASON_EFFECT) and rc:IsType(TYPE_SPELL) and rc:IsCode(44454002)
end
function c44452018.spfilter1(c,e,tp)
	return c:IsCode(44452020) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
		and Duel.IsExistingMatchingCard(c44452018.spfilter2,tp,LOCATION_GRAVE,0,1,c,e,tp)
end
function c44452018.spfilter2(c,e,tp)
	return c:IsCode(44452023) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c44452018.estg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.IsExistingMatchingCard(c44452018.spfilter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_GRAVE)
end
function c44452018.esop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2
		or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,c44452018.spfilter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectMatchingCard(tp,c44452018.spfilter2,tp,LOCATION_GRAVE,0,1,1,g1:GetFirst(),e,tp)
	g1:Merge(g2)
	if g1:GetCount()==2 then
		Duel.SpecialSummon(g1,0,tp,tp,true,true,POS_FACEUP)
	end
end