--化学化合物-氯化氢
function c44452028.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,44450001,44450017,true,true)
	--fusion summon success destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44452028,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c44452028.descon)
	e1:SetTarget(c44452028.destg)
	e1:SetOperation(c44452028.desop)
	c:RegisterEffect(e1)
	--remove
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44452028,1))
	e11:SetCategory(CATEGORY_REMOVE)
	e11:SetType(EFFECT_TYPE_QUICK_O)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCountLimit(1)
	e11:SetCost(c44452028.cost)
	e11:SetTarget(c44452028.target)
	e11:SetOperation(c44452028.operation)
	e11:SetHintTiming(0,0x1e0)
	c:RegisterEffect(e11)
	--exsummon
	local e31=Effect.CreateEffect(c)
	e31:SetDescription(aux.Stringid(44452028,1))
	e31:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e31:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e31:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e31:SetCode(EVENT_TO_GRAVE)
	e31:SetCondition(c44452028.escon)
	e31:SetTarget(c44452028.estg)
	e31:SetOperation(c44452028.esop)
	c:RegisterEffect(e31)
end
function c44452028.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION
end
function c44452028.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsFacedown()
end
function c44452028.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44452028.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local sg=Duel.GetMatchingGroup(c44452028.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetChainLimit(c44452028.chainlm)
end
function c44452028.chainlm(e,rp,tp)
	return tp==rp
end
function c44452028.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c44452028.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	local ct=Duel.Destroy(sg,REASON_EFFECT)
end
--remove
function c44452028.cfilter(c,tp)
	return c:IsAbleToDeckAsCost() and c:IsSetCard(0x650) and c:IsType(TYPE_MONSTER)
end
function c44452028.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44452028.cfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c44452028.cfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	Duel.SendtoDeck(g,nil,2,REASON_COST)
	Duel.ShuffleDeck(tp)
end
function c44452028.tfilter(c)
	return c:IsSetCard(0x652) and c:IsAbleToDeck() and c:IsType(TYPE_FUSION)
end
function c44452028.rfilter(c)
	return c:GetAttack()~=c:GetBaseAttack()
end
function c44452028.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c44452028.rfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44452028.rfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c44452028.rfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c44452028.operation(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)~=0 then
    end
end
--exsummon
function c44452028.escon(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return e:GetHandler():IsReason(REASON_EFFECT) and rc:IsType(TYPE_SPELL) and rc:IsCode(44454002)
end
function c44452028.spfilter1(c,e,tp)
	return c:IsCode(44450001) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
		and Duel.IsExistingMatchingCard(c44452028.spfilter2,tp,LOCATION_GRAVE,0,1,c,e,tp)
end
function c44452028.spfilter2(c,e,tp)
	return c:IsCode(44450017) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c44452028.estg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.IsExistingMatchingCard(c44452028.spfilter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_GRAVE)
end
function c44452028.esop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2
		or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,c44452028.spfilter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectMatchingCard(tp,c44452028.spfilter2,tp,LOCATION_GRAVE,0,1,1,g1:GetFirst(),e,tp)
	g1:Merge(g2)
	if g1:GetCount()==2 then
		Duel.SpecialSummon(g1,0,tp,tp,true,true,POS_FACEUP)
	end
end