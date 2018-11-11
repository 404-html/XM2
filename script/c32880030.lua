--多重射击
function c32880030.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c32880030.cost)
	e1:SetCondition(c32880030.condition)
	e1:SetOperation(c32880030.desop)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32880030,0))
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c32880030.cttg)
	e2:SetOperation(c32880030.activate)
	c:RegisterEffect(e2)
end
function c32880030.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x755,4,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x755,4,REASON_COST)
end
function c32880030.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x733)
end
function c32880030.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c32880030.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c32880030.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_MZONE):RandomSelect(1-tp,2)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)<=1 then return end
	local c=e:GetHandler()
	local tc=g:GetFirst()
	local dg=Group.CreateGroup()
	while tc do
		local preatk=tc:GetAttack()
		local predef=tc:GetDefense()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-1500)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(-1500)
		tc:RegisterEffect(e2)
		if (preatk==0 or tc:GetAttack()==0) or (predef==0 or tc:GetDefense()==0) then dg:AddCard(tc) end   
		tc=g:GetNext()
	end
	Duel.Destroy(dg,REASON_EFFECT)
end
function c32880030.filter2(c)
	return c:IsPosition(POS_FACEUP) and c:IsCode(32880022)
end
function c32880030.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_FZONE) and chkc:IsControler(tp) and c32880030.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c32880030.filter2,tp,LOCATION_FZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c32880030.filter2,tp,LOCATION_FZONE,0,1,1,nil)
end
function c32880030.spfilter(c,e,tp)
	return c:IsSetCard(0x730) and c:IsAbleToHand() and c:IsType(TYPE_SPELL) 
end
function c32880030.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c32880030.spfilter),tp,LOCATION_DECK,0,nil,e,tp)
	if tc then
		tc:AddCounter(0x755,2)
	end
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tg=Duel.SelectMatchingCard(tp,c32880030.spfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then 
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end