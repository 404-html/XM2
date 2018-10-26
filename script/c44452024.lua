--化学化合物-氯化钠
function c44452024.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,44450011,44450017,true,true)
	--to deck and tograve
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44452024,0))
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c44452024.con)
	e1:SetTarget(c44452024.tg)
	e1:SetOperation(c44452024.op)
	c:RegisterEffect(e1)
	--tograve
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44452024,1))
	e11:SetCategory(CATEGORY_TOGRAVE)
	e11:SetType(EFFECT_TYPE_QUICK_O)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCountLimit(1)
	e11:SetCost(c44452024.cost)
	e11:SetTarget(c44452024.target)
	e11:SetOperation(c44452024.operation)
	e11:SetHintTiming(0,0x1e0)
	c:RegisterEffect(e11)
	--exsummon
	local e31=Effect.CreateEffect(c)
	e31:SetDescription(aux.Stringid(44452024,2))
	e31:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e31:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e31:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e31:SetCode(EVENT_TO_GRAVE)
	e31:SetCondition(c44452024.escon)
	e31:SetTarget(c44452024.estg)
	e31:SetOperation(c44452024.esop)
	c:RegisterEffect(e31)
end
function c44452024.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION
end
function c44452024.filter(c)
	return c:IsSetCard(0x650) and c:IsAbleToDeck() and c:IsType(TYPE_MONSTER)
end
function c44452024.refilter(c)
	return c:IsAbleToGrave()
end
function c44452024.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c44452024.filter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c44452024.refilter,tp,0,LOCATION_ONFIELD,1,nil) end
	if Duel.IsExistingTarget(c44452024.filter,tp,LOCATION_GRAVE,0,2,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectTarget(tp,c44452024.filter,tp,LOCATION_GRAVE,0,2,2,nil)
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,0,tp,1)
	end
end
function c44452024.op(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not tg or tg:FilterCount(Card.IsRelateToEffect,nil,e)~=2 then return end
	Duel.SendtoDeck(tg,nil,2,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	if g:IsExists(Card.IsLocation,1,nil,LOCATION_DECK) then Duel.ShuffleDeck(tp) end
	local ct=g:FilterCount(Card.IsLocation,nil,LOCATION_DECK+LOCATION_EXTRA)
	if ct==2 then
	    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=Duel.SelectMatchingCard(tp,c44452024.refilter,tp,0,LOCATION_ONFIELD,1,1,nil)
		Duel.HintSelection(sg)
		Duel.SendtoGrave(sg,REASON_EFFECT)
	end
end
--tograve
function c44452024.cfilter(c,tp)
	return c:IsAbleToDeckAsCost() and c:IsSetCard(0x650) and c:IsType(TYPE_MONSTER)
end
function c44452024.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44452024.cfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c44452024.cfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	Duel.SendtoDeck(g,nil,2,REASON_COST)
	Duel.ShuffleDeck(tp)
end
function c44452024.tfilter(c)
	return c:IsSetCard(0x652) and c:IsAbleToDeck() and c:IsType(TYPE_FUSION)
end
function c44452024.rfilter(c)
	return c:IsFaceup() and c:IsAbleToGrave() and c:GetType()==TYPE_CONTINUOUS
end
function c44452024.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_SZONE) and c44452024.rfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44452024.rfilter,tp,0,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,c44452024.rfilter,tp,0,LOCATION_SZONE,1,1,nil)
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c44452024.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoGrave(tc,REASON_EFFECT)~=0 then
	end
end
--exsummon
function c44452024.escon(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return e:GetHandler():IsReason(REASON_EFFECT) and rc:IsType(TYPE_SPELL) and rc:IsCode(44454002)
end
function c44452024.spfilter1(c,e,tp)
	return c:IsCode(44450011) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
		and Duel.IsExistingMatchingCard(c44452024.spfilter2,tp,LOCATION_GRAVE,0,1,c,e,tp)
end
function c44452024.spfilter2(c,e,tp)
	return c:IsCode(44450017) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c44452024.estg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.IsExistingMatchingCard(c44452024.spfilter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_GRAVE)
end
function c44452024.esop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2
		or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,c44452024.spfilter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectMatchingCard(tp,c44452024.spfilter2,tp,LOCATION_GRAVE,0,1,1,g1:GetFirst(),e,tp)
	g1:Merge(g2)
	if g1:GetCount()==2 then
		Duel.SpecialSummon(g1,0,tp,tp,true,true,POS_FACEUP)
	end
end