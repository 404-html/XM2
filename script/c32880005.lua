--野性印记
function c32880005.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c32880005.cost)
	e1:SetCondition(c32880005.actcon)
	e1:SetTarget(c32880005.target)
	e1:SetOperation(c32880005.operation)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32880005,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(aux.exccon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c32880005.cttg)
	e2:SetOperation(c32880005.activate)
	c:RegisterEffect(e2)
end
function c32880005.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x755,2,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x755,2,REASON_COST)
end
function c32880005.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x731)
end
function c32880005.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c32880005.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c32880005.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x730) 
end
function c32880005.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(c32880005.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c32880005.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c32880005.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(800)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(800)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(e:GetHandler()) 
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
		e3:SetRange(LOCATION_MZONE)
		e3:SetTargetRange(0,LOCATION_MZONE)
		e3:SetCondition(c32880005.condition)
		e3:SetValue(c32880005.limit)
		e3:SetLabel(tc:GetCode())
		tc:RegisterEffect(e3)
	end
end
function c32880005.condition(e)
	return e:GetHandler():IsPosition(POS_FACEUP)
end
function c32880005.limit(e,c)
	return c:IsFacedown() or c:GetCode()~=e:GetLabel()
end
function c32880005.filter2(c)
	return c:IsPosition(POS_FACEUP) and c:IsCode(32880022)
end
function c32880005.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_FZONE) and chkc:IsControler(tp) and c32880005.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c32880005.filter2,tp,LOCATION_FZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c32880005.filter2,tp,LOCATION_FZONE,0,1,1,nil)
end
function c32880005.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc then
		tc:AddCounter(0x755,1)
	end
	Duel.BreakEffect()
	local ct=tc:GetCounter(0x755)
	if ct>0 then
	Duel.DiscardDeck(1-tp,ct,REASON_EFFECT)
	end
end