--爪击
function c32880004.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCost(c32880004.cost)
	e1:SetTarget(c32880004.target)
	e1:SetOperation(c32880004.operation)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32880004,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(aux.exccon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c32880004.destg)
	e2:SetOperation(c32880004.activate)
	c:RegisterEffect(e2)
end
function c32880004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x755,1,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x755,1,REASON_COST)
end
function c32880004.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x732) and c:IsType(TYPE_MONSTER)
end
function c32880004.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c32880004.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c32880004.filter2(c,e)
	return c:IsFaceup() and c:IsSetCard(0x732) and c:IsType(TYPE_MONSTER) and not c:IsImmuneToEffect(e)
end
function c32880004.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c32880004.filter2,tp,LOCATION_MZONE,0,nil,e)
	local c=e:GetHandler()
	local fid=c:GetFieldID()
	local tc=sg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(800)
		tc:RegisterEffect(e1)
		tc:RegisterFlagEffect(32880004,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(1000)
		tc:RegisterEffect(e2)
		tc=sg:GetNext()
	end
	sg:KeepAlive()
end
function c32880004.filter3(c)
	return c:IsFaceup() and c:GetAttack()>0 and c:IsSetCard(0x731)
end
function c32880004.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c32880004.filter3(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c32880004.filter3,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c32880004.filter3,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c32880004.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
	   local atk=tc:GetAttack()/2
	   Duel.Damage(1-tp,atk,REASON_EFFECT)
	end
end