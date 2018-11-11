--碧蓝工舰-女灶神
function c85469214.initial_effect(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(85469214,0))
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e1:SetCountLimit(1,85469214)
	e1:SetCondition(c85469214.negcon)
	e1:SetCost(c85469214.negcost)
	e1:SetTarget(c85469214.negtg)
	e1:SetOperation(c85469214.negop)
	c:RegisterEffect(e1)  
	--unba
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(85469214,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e2:SetCost(aux.bfgcost)
	e2:SetOperation(c85469214.rmop)
	c:RegisterEffect(e2)  
end
function c85469214.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_REMOVE)
	e3:SetReset(RESET_PHASE+PHASE_END)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x8fc))
	e3:SetValue(1)
	Duel.RegisterEffect(e3,tp)
end
function c85469214.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return (c:IsDiscardable() and c:IsLocation(LOCATION_HAND)) or (c:IsReleasable() and c:IsLocation(LOCATION_MZONE)) end
	if c:IsLocation(LOCATION_HAND) then Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
	else
	   Duel.Release(c,REASON_COST)
	end
end
function c85469214.tfilter(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsControler(tp) and c:IsFaceup() and c:IsSetCard(0x8fc)
end
function c85469214.negcon(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g and g:IsExists(c85469214.tfilter,1,nil,tp) and Duel.IsChainDisablable(ev)
end
function c85469214.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c85469214.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
