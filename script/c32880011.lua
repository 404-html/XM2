--横扫
function c32880011.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(32880011,0))
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCost(c32880011.cost)
	e1:SetCondition(c32880011.condition)
	e1:SetTarget(c32880011.damtg)
	e1:SetOperation(c32880011.damop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32880011,1))
	e2:SetCategory(CATEGORY_DAMAGE+CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCost(c32880011.cost)
	e2:SetCondition(c32880011.condition)
	e2:SetTarget(c32880011.target)
	e2:SetOperation(c32880011.desop)
	c:RegisterEffect(e2)
	--destroy2
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(32880011,2))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCondition(c32880011.descon)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c32880011.destg)
	e3:SetOperation(c32880011.activate)
	c:RegisterEffect(e3)
end
function c32880011.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x755,4,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x755,4,REASON_COST)
end
function c32880011.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x731)
end
function c32880011.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c32880011.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c32880011.atkfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c32880011.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(2000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,2000)
end
function c32880011.filter2(c,e)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and not c:IsImmuneToEffect(e)
end
function c32880011.damop(e,tp,eg,ep,ev,re,r,rp)   
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
	Duel.BreakEffect()
	local sg=Duel.GetMatchingGroup(c32880011.filter2,tp,0,LOCATION_MZONE,nil,e)
	local dg=Group.CreateGroup()
	local c=e:GetHandler()
	local tc=sg:GetFirst()
	while tc do
		local preatk=tc:GetAttack()
		local predef=tc:GetDefense()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-500)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(-500)
		tc:RegisterEffect(e2)
		if (preatk==0 or tc:GetAttack()==0) or (predef==0 or tc:GetDefense()==0) then dg:AddCard(tc) end   
		tc=sg:GetNext()
	end
	Duel.Destroy(dg,REASON_EFFECT)
end
function c32880011.filter(c)
	return c:IsPosition(POS_FACEUP)
end
function c32880011.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c32880011.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c32880011.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c32880011.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c32880011.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ac=Duel.GetFirstTarget()
	local cg=Group.CreateGroup()
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if ac:IsRelateToEffect(e) and ac:IsFaceup() then
		local preatk=ac:GetAttack()
		local predef=ac:GetDefense()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-1500)
		ac:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(-1500)
		ac:RegisterEffect(e2)
		if (preatk==0 or ac:GetAttack()==0) or (predef==0 or ac:GetDefense()==0) then cg:AddCard(ac) end   
	end
	Duel.Destroy(cg,REASON_EFFECT)
	Duel.BreakEffect()
	local ag=Duel.GetMatchingGroup(c32880011.filter2,tp,0,LOCATION_MZONE,nil,e)
	local bg=Group.CreateGroup()
	local hc=ag:GetFirst()
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	while hc do
		local preatk=hc:GetAttack()
		local predef=hc:GetDefense()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-500)
		hc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(-500)
		hc:RegisterEffect(e2)
		if (preatk==0 or hc:GetAttack()==0) or (predef==0 or hc:GetDefense()==0) then bg:AddCard(hc) end   
		hc=ag:GetNext()
	end
	Duel.Destroy(bg,REASON_EFFECT)
	Duel.Damage(1-tp,500,REASON_EFFECT)
end
function c32880011.descon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c32880011.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c32880011.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end