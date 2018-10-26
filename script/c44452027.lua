--化学化合物-硫酸铜
function c44452027.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
    aux.AddFusionProcCode3(c,44450008,44450016,44450029,true,true)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44452027,0))
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c44452027.con)
	e1:SetTarget(c44452027.tg)
	e1:SetOperation(c44452027.op)
	c:RegisterEffect(e1)
	--DISABLE
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44452027,1))
	e11:SetCategory(CATEGORY_DISABLE)
	e11:SetType(EFFECT_TYPE_QUICK_O)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCountLimit(1)
	e11:SetTarget(c44452027.target)
	e11:SetOperation(c44452027.operation)
	e11:SetHintTiming(0,0x1e0)
	c:RegisterEffect(e11)
	--exsummon
	local e31=Effect.CreateEffect(c)
	e31:SetDescription(aux.Stringid(44452027,2))
	e31:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e31:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e31:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e31:SetCode(EVENT_TO_GRAVE)
	e31:SetCondition(c44452027.escon)
	e31:SetTarget(c44452027.estg)
	e31:SetOperation(c44452027.esop)
	c:RegisterEffect(e31)
end
function c44452027.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION
end
function c44452027.afilter(c)
	return c:IsFaceup() and c:IsSetCard(0x650)
end
function c44452027.filter(c)
	return c:IsAbleToDeck() and c:IsSetCard(0x650) and c:IsType(TYPE_MONSTER)
end
function c44452027.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c44452027.filter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c44452027.afilter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	if Duel.IsExistingTarget(c44452027.filter,tp,LOCATION_GRAVE,0,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectTarget(tp,c44452027.filter,tp,LOCATION_GRAVE,0,1,3,nil)
		e:SetLabel(g:GetCount())
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g,e:GetLabel(),0,0)
	end
end
function c44452027.op(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not tg then return end
	Duel.SendtoDeck(tg,nil,0,REASON_EFFECT)
	local g=Duel.GetMatchingGroup(c44452027.afilter,tp,LOCATION_MZONE,0,nil)
	local ct=e:GetLabel()
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(ct*400)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
--DISABLE
function c44452027.cfilter(c,tp)
	return c:IsAbleToDeck() and c:IsSetCard(0x650) and c:IsType(TYPE_MONSTER)
end
function c44452027.disfilter(c)
	return c:IsFaceup() and not c:IsDisabled() and c:IsType(TYPE_SPELL)
end
function c44452027.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_SZONE) and c44452027.disfilter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c44452027.cfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler())
	and Duel.IsExistingTarget(c44452027.disfilter,tp,0,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c44452027.disfilter,tp,0,LOCATION_SZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_GRAVE)
end
function c44452027.operation(e,tp,eg,ep,ev,re,r,rp)
	    local c=e:GetHandler()
	    local tc=Duel.GetFirstTarget()
	    if tc:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsType(TYPE_SPELL) and not tc:IsDisabled() and tc:IsControler(1-tp) then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	    local g=Duel.GetMatchingGroup(c44452027.cfilter,p,LOCATION_GRAVE,0,nil)
	    if g:GetCount()>=1 then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
		local sg=g:Select(p,1,1,nil)
		Duel.ConfirmCards(1-p,sg)
		Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
		Duel.ShuffleDeck(p)
		end
	end
end
--exsummon
function c44452027.escon(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return e:GetHandler():IsReason(REASON_EFFECT) and rc:IsType(TYPE_SPELL) and rc:IsCode(44454002)
end
function c44452027.spfilter1(c,e,tp)
	return c:IsCode(44452013) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
		and Duel.IsExistingMatchingCard(c44452027.spfilter2,tp,LOCATION_GRAVE,0,1,c,e,tp)
end
function c44452027.spfilter2(c,e,tp)
	return c:IsCode(44452023) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c44452027.estg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.IsExistingMatchingCard(c44452027.spfilter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_GRAVE)
end
function c44452027.esop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2
		or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,c44452027.spfilter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectMatchingCard(tp,c44452027.spfilter2,tp,LOCATION_GRAVE,0,1,1,g1:GetFirst(),e,tp)
	g1:Merge(g2)
	if g1:GetCount()==2 then
		Duel.SpecialSummon(g1,0,tp,tp,true,true,POS_FACEUP)
	end
end