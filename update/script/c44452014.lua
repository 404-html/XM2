--化学化合物-一氧化氮 
function c44452014.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,44450007,44450008,true,true)
	--fusion summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44452014,0))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c44452014.tocon)
	e2:SetTarget(c44452014.totg)
	e2:SetOperation(c44452014.toop)
	c:RegisterEffect(e2)
	--spexsummon
	local e31=Effect.CreateEffect(c)
	e31:SetDescription(aux.Stringid(44452014,1))
	e31:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e31:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e31:SetType(EFFECT_TYPE_IGNITION)
	e31:SetRange(LOCATION_MZONE)
	e31:SetCountLimit(1)
	e31:SetTarget(c44452014.estg)
	e31:SetOperation(c44452014.esop)
	c:RegisterEffect(e31)
end
function c44452014.tocon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c44452014.filter(c)
	return c:IsSetCard(0x650) and c:IsAbleToDeck() and c:IsType(TYPE_MONSTER)
end
function c44452014.tfilter(c)
	return c:IsCode(44452010) and c:IsAbleToGrave()
end
function c44452014.totg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c44452014.filter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c44452014.tfilter,tp,LOCATION_EXTRA,0,1,nil) end
	if Duel.IsExistingTarget(c44452014.filter,tp,LOCATION_GRAVE,0,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectTarget(tp,c44452014.filter,tp,LOCATION_GRAVE,0,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_EXTRA)
end
function c44452014.toop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not tg or tg:FilterCount(Card.IsRelateToEffect,nil,e)~=1 then return end
	Duel.SendtoDeck(tg,nil,0,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	if g:IsExists(Card.IsLocation,1,nil,LOCATION_DECK) then Duel.ShuffleDeck(tp) end
	local ct=g:FilterCount(Card.IsLocation,nil,LOCATION_DECK+LOCATION_EXTRA)
	if ct==1 then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=Duel.SelectMatchingCard(tp,c44452014.tfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	    if sg:GetCount()>0 then
		Duel.SendtoGrave(sg,REASON_EFFECT)
	    end
	end
end
--spexsummon
function c44452014.spfilter1(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x650) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
		and Duel.IsExistingMatchingCard(c44452014.spfilter2,tp,LOCATION_GRAVE,0,1,c,e,tp)
end
function c44452014.spfilter2(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsCode(44452010) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c44452014.estg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.IsExistingMatchingCard(c44452014.spfilter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_GRAVE)
end
function c44452014.esop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2
		or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,c44452014.spfilter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectMatchingCard(tp,c44452014.spfilter2,tp,LOCATION_GRAVE,0,1,1,g1:GetFirst(),e,tp)
	g1:Merge(g2)
	if g1:GetCount()==2 then
		Duel.SpecialSummon(g1,0,tp,tp,true,true,POS_FACEUP)
		local tc=g1:GetFirst()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		local sc=g2:GetFirst()
		local e11=Effect.CreateEffect(c)
		e11:SetType(EFFECT_TYPE_SINGLE)
		e11:SetCode(EFFECT_DISABLE)
		e11:SetReset(RESET_EVENT+0x1fe0000)
		sc:RegisterEffect(e11)
		local e21=Effect.CreateEffect(c)
		e21:SetType(EFFECT_TYPE_SINGLE)
		e21:SetCode(EFFECT_DISABLE_EFFECT)
		e21:SetReset(RESET_EVENT+0x1fe0000)
		sc:RegisterEffect(e21)
		Duel.BreakEffect()
	    if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.SendtoDeck(c,nil,0,REASON_EFFECT)
	    end
	end
end