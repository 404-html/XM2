--古夕幻历-静夜庭思
function c44460104.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1c0+TIMING_SUMMON+TIMING_SPSUMMON)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCode(EVENT_SPSUMMON)
	e2:SetCountLimit(1,44460080)
    e2:SetCondition(c44460104.scon)
	e2:SetTarget(c44460104.thtg1)
	e2:SetOperation(c44460104.thop1)
	c:RegisterEffect(e2)
	--destroy
	local e31=Effect.CreateEffect(c)
	e31:SetDescription(aux.Stringid(44460104,1))
	e31:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e31:SetRange(LOCATION_SZONE)
	e31:SetCode(EVENT_SUMMON_SUCCESS)
	e31:SetCondition(c44460104.descon)
	e31:SetTarget(c44460104.destg)
	e31:SetOperation(c44460104.desop)
	c:RegisterEffect(e31)
	local e33=e31:Clone()
	e33:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e33)
	--summon
	local e42=Effect.CreateEffect(c)
	e42:SetDescription(aux.Stringid(44460104,2))
	e42:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e42:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e42:SetRange(LOCATION_SZONE)
	e42:SetCode(EVENT_SPSUMMON_SUCCESS)
	e42:SetCountLimit(1,44461080)
	e42:SetCondition(c44460104.condition2)
    e42:SetTarget(c44460104.target)
	e42:SetOperation(c44460104.top)
	c:RegisterEffect(e42)
	local e43=e42:Clone()
	e43:SetCode(EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e43)
end
--tohand
function c44460104.sfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
end
function c44460104.scon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460104.sfilter,1,nil,tp)
end
function c44460104.thtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,eg,eg:GetCount(),0,0)
end
function c44460104.thop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.SendtoHand(eg,nil,REASON_EFFECT)
end
--destroy
function c44460104.cfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL)
end
function c44460104.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460104.cfilter,1,nil,tp) and not eg:IsContains(e:GetHandler())
end
function c44460104.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c44460104.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.Destroy(c,REASON_EFFECT)
	end
end
--summon
function c44460104.filter2(c,tp)
	return c:IsType(TYPE_EFFECT) and c:IsControler(1-tp)
end
function c44460104.condition2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460104.filter2,1,nil,tp)
end
function c44460104.thfilter(c)
	return c:IsSetCard(0x699) and c:IsAbleToHand()
end
function c44460104.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44460104.thfilter,tp,LOCATION_DECK,0,1,nil) end
	--Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_ATOHAND,nil,1,tp,LOCATION_DECK)
end
function c44460104.top(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c44460104.thfilter),tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end