--瞳器·遗落之地
function c44480025.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--disable
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44480025,1))
	e11:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DISABLE+CATEGORY_TOHAND)
	e11:SetType(EFFECT_TYPE_IGNITION)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetRange(LOCATION_FZONE)
	e11:SetCountLimit(1,44480025)
	e11:SetCondition(c44480025.condition)
	e11:SetTarget(c44480025.target)
	e11:SetOperation(c44480025.op)
	c:RegisterEffect(e11)
	--disable
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_FIELD)
	e22:SetRange(LOCATION_FZONE)
	e22:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e22:SetCondition(c44480025.con)
	e22:SetTarget(c44480025.disable)
	e22:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e22)
end
function c44480025.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x646)
end
function c44480025.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44480025.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c44480025.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local c=e:GetHandler()
	local g2=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_ONFIELD,0,nil,0x646)
	if chk==0 then return c:IsAbleToHand() and g2:GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g2,1,0,0)
end
function c44480025.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(500)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_DISABLE_EFFECT)
		e3:SetValue(RESET_TURN_SET)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3)
	end
	local g=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_ONFIELD,0,nil,0x646)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOHAND)
	local sg=g:Select(tp,1,2,nil)
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
end
--disable
function c44480025.con(e)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
function c44480025.disable(e,c)
	return not c:IsDisabled() and c:IsType(TYPE_EFFECT) or bit.band(c:GetOriginalType(),TYPE_EFFECT)==TYPE_EFFECT
end

