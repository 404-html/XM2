--咕咕咕
function c88480604.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON)
	e1:SetCondition(c88480604.condition1)
	e1:SetTarget(c88480604.target1)
	e1:SetOperation(c88480604.activate1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e3)
	local e4=e1:Clone()
	e4:SetCategory(CATEGORY_NEGATE+CATEGORY_TODECK)
	e4:SetCode(EVENT_CHAINING)
	e4:SetCondition(c88480604.con)
	e4:SetTarget(c88480604.tg)
	e4:SetOperation(c88480604.op)
	c:RegisterEffect(e4)
	--回 场
	local e12=Effect.CreateEffect(c)
	e12:SetDescription(aux.Stringid(88480604,0))
	e12:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_LEAVE_FIELD)
	e12:SetRange(LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_ONFIELD)
	e12:SetTarget(c88480604.e12tg)
	e12:SetCondition(c88480604.e12con)
	c:RegisterEffect(e12)
	
end
function c88480604.condition1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0 and e:GetHandler():GetFlagEffect(88480601)>0
end
function c88480604.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,eg,eg:GetCount(),0,0)
end
function c88480604.activate1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.SendtoDeck(eg,nil,2,REASON_EFFECT)
end
function c88480604.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsChainNegatable(ev) and e:GetHandler():GetFlagEffect(88480601)>0
end
function c88480604.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_TODECK,eg,1,0,0)
	end
end
function c88480604.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		 re:GetHandler():CancelToGrave()
		 Duel.SendtoDeck(re:GetHandler(),nil,2,REASON_EFFECT)
	end
end
function c88480604.e12con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(88480601)>0 and Duel.GetLocationCount(1-tp,LOCATION_SZONE)>0
end
function c88480604.e12tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SSet(tp,e:GetHandler(),1-tp)
	e:GetHandler():RegisterFlagEffect(88480604,RESET_EVENT+RESETS_STANDARD-RESET_TOGRAVE-RESET_LEAVE,0,1)
end