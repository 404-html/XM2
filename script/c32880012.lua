--星火术
function c32880012.initial_effect(c)
	--Activate  
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(32880012,0))
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c32880012.cost)
	e1:SetCondition(c32880012.actcon)
	e1:SetTarget(c32880012.damtg)
	e1:SetOperation(c32880012.damop)
	c:RegisterEffect(e1)
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32880012,1))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCost(c32880012.cost)
	e2:SetCondition(c32880012.actcon)
	e2:SetTarget(c32880012.atktg)
	e2:SetOperation(c32880012.atkop)
	c:RegisterEffect(e2)
	--counter
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(32880012,2))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,32880012)
	e3:SetTarget(c32880012.cttg)
	e3:SetOperation(c32880012.activate)
	c:RegisterEffect(e3)
end
function c32880012.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x755,6,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x755,6,REASON_COST)
end
function c32880012.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x731)
end
function c32880012.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c32880012.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c32880012.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(2500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,2500)
end
function c32880012.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
	Duel.Draw(tp,1,REASON_EFFECT)
end
function c32880012.atkfilter(c)
	return c:IsPosition(POS_FACEUP) and not c:IsSetCard(0x732)
end
function c32880012.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c32880012.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c32880012.atkfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c32880012.atkfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c32880012.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local dg=Group.CreateGroup()
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local preatk=tc:GetAttack()
		local predef=tc:GetDefense()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-2500)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(-2500)
		tc:RegisterEffect(e2)
		if (preatk==0 or tc:GetAttack()==0) or (predef==0 or tc:GetDefense()==0) then dg:AddCard(tc) end   
	end
	Duel.Destroy(dg,REASON_EFFECT)
	Duel.Draw(tp,1,REASON_EFFECT)
end
function c32880012.filter2(c)
	return c:IsPosition(POS_FACEUP) and c:IsCode(32880022)
end
function c32880012.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_FZONE) and chkc:IsControler(tp) and c32880012.filter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c32880012.filter2,tp,LOCATION_FZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c32880012.filter2,tp,LOCATION_FZONE,0,1,1,nil)
end
function c32880012.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local gc=Duel.GetMatchingGroupCount(Card.IsCode,p,LOCATION_GRAVE,0,nil,32880012)
	if tc then
		tc:AddCounter(0x755,3*gc)
	end
	Duel.BreakEffect()
	Duel.Draw(tp,gc,REASON_EFFECT)
end