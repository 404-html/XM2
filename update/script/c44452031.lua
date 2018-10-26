--化学化合物-硝酸
function c44452031.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode3(c,44450001,44450007,44450008,true,true)
	--fusion summon success remove hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44452031,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c44452031.rehcon)
	e1:SetTarget(c44452031.rehtg)
	e1:SetOperation(c44452031.rehop)
	c:RegisterEffect(e1)
	--all to deck
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44452031,2))
	e11:SetCategory(CATEGORY_TODECK)
	e11:SetType(EFFECT_TYPE_QUICK_O)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCountLimit(1)
	e11:SetCondition(c44452031.con)
	e11:SetTarget(c44452031.tdtg)
	e11:SetOperation(c44452031.tdop)
	e11:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e11)
	--exsummon
	local e31=Effect.CreateEffect(c)
	e31:SetDescription(aux.Stringid(44452031,1))
	e31:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e31:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e31:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e31:SetCode(EVENT_TO_GRAVE)
	e31:SetCondition(c44452031.escon)
	e31:SetTarget(c44452031.estg)
	e31:SetOperation(c44452031.esop)
	c:RegisterEffect(e31)
end
function c44452031.rehcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION
end
function c44452031.rehtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
end
function c44452031.rehop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(44452031,1))
		local tg=g:FilterSelect(tp,Card.IsType,1,1,nil,TYPE_SPELL)
		local tc=tg:GetFirst()
		if tc then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
		end
		Duel.ShuffleHand(1-tp)
	end
end
--all to deck
function c44452031.con(e)
	return Duel.IsExistingMatchingCard(Card.IsPosition,e:GetHandlerPlayer(),0,LOCATION_MZONE,2,nil,POS_FACEUP)
end
function c44452031.tdfilter1(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck() 
end
function c44452031.tdfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x650) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c44452031.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingMatchingCard(c44452031.tdfilter1,tp,0,LOCATION_MZONE,1,nil)
		and Duel.IsExistingTarget(c44452031.tdfilter2,tp,LOCATION_GRAVE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c44452031.tdfilter1,tp,0,LOCATION_MZONE,nil)
	local tg=g:GetMinGroup(Card.GetAttack)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g2=Duel.SelectTarget(tp,c44452031.tdfilter2,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g2,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,tg,1,0,0)

end
function c44452031.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	    if g:GetCount()>0  then
        Duel.SendtoDeck(g,nil,1,REASON_EFFECT)
	    end
	    local cg=Duel.GetMatchingGroup(c44452031.tdfilter1,tp,0,LOCATION_MZONE,nil)
	    if cg:GetCount()>0 then
		local tg=cg:GetMinGroup(Card.GetAttack)
		if tg:GetCount()>1 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local sg=tg:Select(tp,1,1,nil)
			Duel.HintSelection(sg)
			Duel.SendtoDeck(sg,nil,1,REASON_EFFECT)
		else Duel.SendtoDeck(tg,nil,1,REASON_EFFECT) end
	end
	
end
--exsummon
function c44452031.escon(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return e:GetHandler():IsReason(REASON_EFFECT) and rc:IsType(TYPE_SPELL) and rc:IsCode(44454002)
end
function c44452031.spfilter1(c,e,tp)
	return c:IsCode(44450008) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
		and Duel.IsExistingMatchingCard(c44452031.spfilter2,tp,LOCATION_GRAVE,0,1,c,e,tp)
		and Duel.IsExistingMatchingCard(c44452031.spfilter3,tp,LOCATION_GRAVE,0,1,c,e,tp)
end
function c44452031.spfilter2(c,e,tp)
	return c:IsCode(44452020) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c44452031.spfilter3(c,e,tp)
	return c:IsCode(44452010) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c44452031.estg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.IsExistingMatchingCard(c44452031.spfilter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,tp,LOCATION_GRAVE)
end
function c44452031.esop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<3
		or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,c44452031.spfilter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectMatchingCard(tp,c44452031.spfilter2,tp,LOCATION_GRAVE,0,1,1,g1:GetFirst(),e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g3=Duel.SelectMatchingCard(tp,c44452031.spfilter3,tp,LOCATION_GRAVE,0,1,1,g1:GetFirst(),e,tp)
	g1:Merge(g2)
	g1:Merge(g3)
	if g1:GetCount()==3 then
		Duel.SpecialSummon(g1,0,tp,tp,true,true,POS_FACEUP)
	end
end