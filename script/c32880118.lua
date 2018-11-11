--嗜血
function c32880118.initial_effect(c)
	--Activate1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(32880118,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c32880118.condition)
	e1:SetTarget(c32880118.atktg)
	e1:SetOperation(c32880118.atkop1)
	c:RegisterEffect(e1)
	--Activate2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32880118,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c32880118.condition)
	e2:SetCost(c32880118.cost1)
	e2:SetTarget(c32880118.atktg)
	e2:SetOperation(c32880118.atkop2)
	c:RegisterEffect(e2)
	--Activate3
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(32880118,2))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_ACTIVATE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCondition(c32880118.condition)
	e3:SetCost(c32880118.cost2)
	e3:SetTarget(c32880118.atktg)
	e3:SetOperation(c32880118.atkop3)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(32880118,3))
	e4:SetCategory(CATEGORY_COUNTER)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCost(aux.bfgcost)
	e4:SetTarget(c32880118.destg)
	e4:SetOperation(c32880118.activate)
	c:RegisterEffect(e4)
end
function c32880118.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x744)
end
function c32880118.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c32880118.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c32880118.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x755,3,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x755,3,REASON_COST)
end
function c32880118.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x755,5,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x755,5,REASON_COST)
end
function c32880118.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x730)
end
function c32880118.filter2(c,e)
	return c:IsFaceup() and c:IsSetCard(0x730) and not c:IsImmuneToEffect(e)
end
function c32880118.filter3(c)
	return c:IsPosition(POS_FACEUP) and c:IsCode(32880022)
end
function c32880118.filter4(c)
	return c:IsPosition(POS_FACEUP) and c:IsAttackAbove(1500) 
end
function c32880118.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c32880118.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c32880118.atkop1(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c32880118.filter2,tp,LOCATION_MZONE,0,nil,e)
	local c=e:GetHandler()
	local fid=c:GetFieldID()
	local tc=sg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(300)
		tc:RegisterEffect(e1)
		tc:RegisterFlagEffect(32880118,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
		tc=sg:GetNext()
	end
	sg:KeepAlive()
end
function c32880118.atkop2(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c32880118.filter2,tp,LOCATION_MZONE,0,nil,e)
	local c=e:GetHandler()
	local fid=c:GetFieldID()
	local tc=sg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(900)
		tc:RegisterEffect(e1)
		tc:RegisterFlagEffect(32880118,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
		tc=sg:GetNext()
	end
	sg:KeepAlive()
end
function c32880118.atkop3(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c32880118.filter2,tp,LOCATION_MZONE,0,nil,e)
	local c=e:GetHandler()
	local fid=c:GetFieldID()
	local tc=sg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(1500)
		tc:RegisterEffect(e1)
		tc:RegisterFlagEffect(32880118,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
		tc=sg:GetNext()
	end
	sg:KeepAlive()
end
function c32880118.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_FZONE) and chkc:IsControler(tp) and c32880118.filter3(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c32880118.filter3,tp,LOCATION_FZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c32880118.filter3,tp,LOCATION_FZONE,0,1,1,nil)
end
function c32880118.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local g=Duel.GetMatchingGroup(c32880118.filter4,tp,LOCATION_MZONE,0,nil)
	local ct=g:FilterCount(c32880118.filter4,nil)  
	if tc then
		tc:AddCounter(0x755,ct)
	end
end