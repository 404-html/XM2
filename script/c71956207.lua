--少女前線 站線基地
local m=71956207
local set=0xde5
local cm=_G["c"..m]
function cm.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(cm.target)
	e1:SetOperation(cm.activate)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xde5))
	e2:SetValue(500)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCode(EFFECT_SEND_REPLACE)
	e4:SetTarget(cm.reptg)
	e4:SetValue(cm.repval)
	c:RegisterEffect(e4)
end
function cm.tdfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xde5) and c:IsAbleToDeck()
end
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(cm.tdfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function cm.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(cm.tdfilter,tp,LOCATION_GRAVE,0,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	end
end
function cm.repfilter(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_GRAVE) and c:GetDestination()==LOCATION_DECK and c:IsType(TYPE_MONSTER)
		and c:IsAbleToHand()
end
function cm.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return bit.band(r,REASON_EFFECT)~=0 and re and re:IsActiveType(TYPE_MONSTER)
		and re:GetHandler():IsSetCard(0xde5) and eg:IsExists(cm.repfilter,1,nil,tp) end
	if Duel.SelectYesNo(tp,aux.Stringid(m,0)) then
		local g=eg:Filter(cm.repfilter,nil,tp)
		local ct=g:GetCount()
		if ct>1 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
			g=g:Select(tp,1,ct,nil)
		end
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_TO_DECK_REDIRECT)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetValue(LOCATION_HAND)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(m,RESET_EVENT+0x1de0000+RESET_PHASE+PHASE_END,0,1)
			tc=g:GetNext()
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e1:SetCode(EVENT_TO_HAND)
		e1:SetCountLimit(1)
		e1:SetCondition(cm.thcon)
		e1:SetOperation(cm.thop)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		return true
	else return false end
end
function cm.repval(e,c)
	return false
end
function cm.thfilter(c)
	return c:GetFlagEffect(m)~=0
end
function cm.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(cm.thfilter,1,nil)
end
function cm.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(cm.thfilter,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
end
