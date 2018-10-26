--化学化合物-碳酸钙
function c44452025.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
    aux.AddFusionProcCode3(c,44450006,44450008,44450020,true,true)
	--to deck and tograve
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44452025,0))
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c44452025.con)
	e1:SetTarget(c44452025.tg)
	e1:SetOperation(c44452025.op)
	c:RegisterEffect(e1)
	--spsummon
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44452025,1))
	e11:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e11:SetType(EFFECT_TYPE_QUICK_O)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCountLimit(1)
	e11:SetCost(c44452025.cost)
	e11:SetTarget(c44452025.target)
	e11:SetOperation(c44452025.operation)
	e11:SetHintTiming(0,0x1e0)
	c:RegisterEffect(e11)
	--exsummon
	local e31=Effect.CreateEffect(c)
	e31:SetDescription(aux.Stringid(44452025,2))
	e31:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e31:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e31:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e31:SetCode(EVENT_TO_GRAVE)
	e31:SetCondition(c44452025.escon)
	e31:SetTarget(c44452025.estg)
	e31:SetOperation(c44452025.esop)
	c:RegisterEffect(e31)
end
function c44452025.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION
end
function c44452025.filter(c,e,tp)
	return c:IsSetCard(0x650) and c:IsAbleToDeck() and c:IsType(TYPE_MONSTER)
	and Duel.IsExistingMatchingCard(c44452025.refilter,tp,LOCATION_GRAVE,0,1,c,e,tp)
end
function c44452025.refilter(c)
	return c:IsSetCard(0x651) 
end
function c44452025.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c44452025.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsExistingMatchingCard(c44452025.refilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	if Duel.IsExistingTarget(c44452025.filter,tp,LOCATION_GRAVE,0,3,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectTarget(tp,c44452025.filter,tp,LOCATION_GRAVE,0,2,2,nil)
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
        Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
	end
end
function c44452025.op(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not tg or tg:FilterCount(Card.IsRelateToEffect,nil,e)~=2 then return end
	Duel.SendtoDeck(tg,nil,2,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	if g:IsExists(Card.IsLocation,1,nil,LOCATION_DECK) then Duel.ShuffleDeck(tp) end
	local ct=g:FilterCount(Card.IsLocation,nil,LOCATION_DECK+LOCATION_EXTRA)
	if ct==2 then
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c44452025.refilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	    if sg:GetCount()>0 then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	    end
	end
end
--spsummon
function c44452025.spfilter(c,e,tp)
	return c:IsSetCard(0x651) and c:IsType(TYPE_MONSTER)and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c44452025.costfilter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToDeckAsCost() and c:IsSetCard(0x650)
		and Duel.IsExistingMatchingCard(c44452025.spfilter,tp,LOCATION_GRAVE,0,1,c,e,tp)
end
function c44452025.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c44452025.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		if e:GetLabel()~=0 then
			e:SetLabel(0)
			return Duel.IsExistingMatchingCard(c44452025.costfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
		else
			return Duel.IsExistingMatchingCard(c44452025.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
		end
	end
	if e:GetLabel()~=0 then
		e:SetLabel(0)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(tp,c44452025.costfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		Duel.SendtoDeck(g,nil,2,REASON_COST)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c44452025.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c44452025.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end







--exsummon
function c44452025.escon(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return e:GetHandler():IsReason(REASON_EFFECT) and rc:IsType(TYPE_SPELL) and rc:IsCode(44454002)
end
function c44452025.spfilter1(c,e,tp)
	return c:IsCode(44452012) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
		and Duel.IsExistingMatchingCard(c44452025.spfilter2,tp,LOCATION_GRAVE,0,1,c,e,tp)
end
function c44452025.spfilter2(c,e,tp)
	return c:IsCode(44452021) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c44452025.estg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.IsExistingMatchingCard(c44452025.spfilter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_GRAVE)
end
function c44452025.esop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2
		or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,c44452025.spfilter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectMatchingCard(tp,c44452025.spfilter2,tp,LOCATION_GRAVE,0,1,1,g1:GetFirst(),e,tp)
	g1:Merge(g2)
	if g1:GetCount()==2 then
		Duel.SpecialSummon(g1,0,tp,tp,true,true,POS_FACEUP)
	end
end




