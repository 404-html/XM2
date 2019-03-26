--幻灭神话 妖精·迷灯
function c84530814.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84530814,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetHintTiming(0,0x11e0)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,84530784)
	e1:SetCost(c84530814.cost)
	e1:SetTarget(c84530814.tg)
	e1:SetOperation(c84530814.op)
	c:RegisterEffect(e1)
	--to Hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(84530814,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_REMOVED)
	e2:SetCost(c84530814.thcost)
	e2:SetCountLimit(1,84530785)
	e2:SetTarget(c84530814.thtg)
	e2:SetOperation(c84530814.thop)
	c:RegisterEffect(e2)
end
function c84530814.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c84530814.filter(c)
	return (c:GetType()==TYPE_SPELL or c:GetType()==TYPE_TRAP or c:IsType(TYPE_QUICKPLAY+TYPE_SPELL) or c:IsType(TYPE_RITUAL+TYPE_SPELL) or c:IsType(TYPE_CONTINUOUS+TYPE_SPELL) or c:IsType(TYPE_EQUIP+TYPE_SPELL) or c:IsType(TYPE_FIELD+TYPE_SPELL) or c:IsType(TYPE_CONTINUOUS+TYPE_TRAP) or c:IsType(TYPE_COUNTER+TYPE_TRAP)) and c:IsAbleToRemove()
end
function c84530814.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_GRAVE) and c84530814.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c84530814.filter,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c84530814.filter,tp,0,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c84530814.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_REMOVED) then
		local c=e:GetHandler()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
		e1:SetTarget(c84530814.distg)
		e1:SetLabel(tc:GetOriginalType())
		e1:SetReset(RESET_PHASE+PHASE_END,1)
		Duel.RegisterEffect(e1,tp)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_CHAIN_SOLVING)
		e2:SetCondition(c84530814.discon)
		e2:SetOperation(c84530814.disop)
		e2:SetLabel(tc:GetOriginalType())
		e2:SetReset(RESET_PHASE+PHASE_END,1)
		Duel.RegisterEffect(e2,tp)
	end
--效果发动后，限制
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetTargetRange(1,0)
	e3:SetValue(c84530814.aclimit)
	Duel.RegisterEffect(e3,tp)
end
function c84530814.aclimit(e,re,tp)
	return not re:GetHandler():IsSetCard(0x8351) and re:IsActiveType(0x2+0x4) and not re:GetHandler():IsImmuneToEffect(e)
end
function c84530814.distg(e,c)
	local code=e:GetLabel()
	local code1,code2=c:GetOriginalType()
	return code1==code or code2==code
end
function c84530814.discon(e,tp,eg,ep,ev,re,r,rp)
	local code=e:GetLabel()
	local code1,code2=re:GetHandler():GetOriginalType()
	return (re:GetType()==TYPE_SPELL or re:GetType()==TYPE_TRAP or re:IsType(TYPE_QUICKPLAY+TYPE_SPELL) or re:IsType(TYPE_RITUAL+TYPE_SPELL) or re:IsType(TYPE_CONTINUOUS+TYPE_SPELL) or re:IsType(TYPE_EQUIP+TYPE_SPELL) or re:IsType(TYPE_FIELD+TYPE_SPELL) or re:IsType(TYPE_CONTINUOUS+TYPE_TRAP) or re:IsType(TYPE_COUNTER+TYPE_TRAP)) and (code1==code or code2==code)
end
function c84530814.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
function c84530814.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToDeckAsCost() end
	Duel.SendtoDeck(c,nil,2,REASON_COST)
end
function c84530814.thfilter(c)
	return c:IsSetCard(0x8351) and c:GetLevel()==1 and c:IsAbleToHand()
end
function c84530814.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c84530814.thfilter,tp,0x20,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,0x20)
end
function c84530814.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c84530814.thfilter,tp,0x20,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end