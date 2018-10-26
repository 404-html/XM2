--化学操作失误
function c44454012.initial_effect(c)
	--Activate1 spell NEGATE
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,44454012)
	e1:SetCondition(c44454012.condition1)
	e1:SetCost(c44454012.cost)
	e1:SetTarget(c44454012.target1)
	e1:SetOperation(c44454012.activate1)
	c:RegisterEffect(e1)
	--Activate2(summon)
	local e12=Effect.CreateEffect(c)
	e12:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e12:SetType(EFFECT_TYPE_ACTIVATE)
	e12:SetCode(EVENT_SPSUMMON)
	e12:SetCondition(c44454012.condition2)
	e12:SetCost(c44454012.cost)
	e12:SetTarget(c44454012.target2)
	e12:SetOperation(c44454012.activate2)
	c:RegisterEffect(e12)
	--Activate3 draw NEGATE
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c44454012.condition3)
	e1:SetCost(c44454012.cost)
	e1:SetTarget(c44454012.target3)
	e1:SetOperation(c44454012.activate3)
	c:RegisterEffect(e1)
end
function c44454012.cfilter(c)
	return c:IsSetCard(0x650) and not c:IsStatus(STATUS_BATTLE_DESTROYED) and c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c44454012.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c44454012.cfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c44454012.cfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
--Activate1 spell NEGATE
function c44454012.condition1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44454012.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
		 and re:IsHasType(EFFECT_TYPE_ACTIVATE)
		 and Duel.IsChainNegatable(ev) and re:IsActiveType(TYPE_SPELL)
end
function c44454012.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c44454012.activate1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	    local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_FIELD)
	    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	    e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	    e1:SetTargetRange(0,1)
	    e1:SetValue(c44454012.aclimit)
	    e1:SetReset(RESET_PHASE+PHASE_END)
	    Duel.RegisterEffect(e1,tp)
    end
end
function c44454012.aclimit(e,re,tp)
	return re:GetHandler():IsType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--Activate2(summon)
function c44454012.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0
end
function c44454012.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c44454012.activate2(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(0,1)
	Duel.RegisterEffect(e1,tp)
end
--Activate3 draw NEGATE
function c44454012.condition3(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_PLAYER_TARGET) then return false end
	if Duel.GetOperationCount(ev)~=1 then return false end
	local ex,cg,cc,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DRAW)
	return ex and cv>0 and Duel.IsChainDisablable(ev)
end
function c44454012.target3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c44454012.activate3(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_DRAW)
		e1:SetReset(RESET_PHASE+PHASE_END)
	    e1:SetTargetRange(0,1)
	    Duel.RegisterEffect(e1,tp)
	end
end
