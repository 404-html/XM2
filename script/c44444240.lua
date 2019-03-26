--战祸乱世
function c44444240.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44444240+EFFECT_COUNT_CODE_OATH)
	--e1:SetTarget(c44444240.target)
	e1:SetOperation(c44444240.activate)
	c:RegisterEffect(e1)
	--duel status
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_FIELD)
	e11:SetRange(LOCATION_FZONE)
	e11:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e11:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_DUAL))
	e11:SetCode(EFFECT_DUAL_STATUS)
	c:RegisterEffect(e11)
	--
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_CANNOT_TO_DECK)
	e12:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e12:SetRange(LOCATION_FZONE)
	e12:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e12:SetTarget(c44444240.attarget)
	c:RegisterEffect(e12)
	local e22=e12:Clone()
	e22:SetCode(EFFECT_CANNOT_TO_HAND)
	e22:SetTarget(c44444240.etarget)
	c:RegisterEffect(e22)
	--cost
	local e44=Effect.CreateEffect(c)
	e44:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e44:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e44:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e44:SetRange(LOCATION_FZONE)
	e44:SetCountLimit(1)
	e44:SetOperation(c44444240.mtop)
	c:RegisterEffect(e44)
end

function c44444240.desfilter(c)
	return c:IsSetCard(0x642) and c:IsType(TYPE_MONSTER)
end
function c44444240.tdfilter(c)
	return c:IsSetCard(0x642) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c44444240.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c44444240.desfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(44444240,0)) then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local sg=g:Select(tp,1,1,nil)
		Duel.HintSelection(sg)
		Duel.Destroy(sg,REASON_EFFECT)
		local tg=Duel.GetMatchingGroup(c44444240.tdfilter,tp,LOCATION_GRAVE,0,e:GetHandler())
	    if tg:GetCount()~=0 and Duel.SelectYesNo(tp,aux.Stringid(44444240,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	    local ag=tg:Select(tp,1,1,nil)
		Duel.SendtoDeck(ag,nil,2,REASON_EFFECT)
	    end
	end
end
--can not to deck
function c44444240.etarget(e,c)
	return bit.band(c:GetOriginalType(),TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK)~=0
	and c:IsType(TYPE_DUAL)
end
function c44444240.attarget(e,c)
	return c:IsType(TYPE_DUAL)
end
--cost
function c44444240.cffilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsType(TYPE_DUAL) and c:IsAbleToDeck()
end
function c44444240.mtop(e,tp,eg,ep,ev,re,r,rp)

	if Duel.IsExistingMatchingCard(c44444240.cffilter,tp,LOCATION_HAND,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(44444240,2)) then
	local g=Duel.SelectMatchingCard(tp,c44444240.cffilter,tp,LOCATION_HAND,0,1,1,nil)
		Duel.ConfirmCards(1-tp,g)
		Duel.SendtoDeck(g,nil,2,REASON_RULE)
		Duel.ShuffleHand(tp)
	else
		Duel.Destroy(e:GetHandler(),REASON_RULE)
	end
end