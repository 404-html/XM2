--蓝瞳器·剪重斧
function c44480055.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44480055,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44480055+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(TIMING_BATTLE_PHASE,0x1c0+TIMING_BATTLE_PHASE)
	e1:SetTarget(c44480055.target)
	e1:SetOperation(c44480055.activate)
	c:RegisterEffect(e1)
	--def
	local e20=Effect.CreateEffect(c)
	e20:SetType(EFFECT_TYPE_EQUIP)
	e20:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e20:SetValue(c:GetDefense()*2)
	c:RegisterEffect(e20)
	--disable
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_EQUIP)
	e21:SetCode(EFFECT_DISABLE)
	e21:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e21)
	--Pos Change defense
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_EQUIP)
	e22:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e22:SetCode(EFFECT_SET_POSITION)
	e22:SetRange(LOCATION_MZONE)
	e22:SetValue(POS_FACEUP_DEFENSE)
	c:RegisterEffect(e22)
	--indes
	local e24=Effect.CreateEffect(c)
	e24:SetType(EFFECT_TYPE_EQUIP)
	e24:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e24:SetValue(1)
	e24:SetCondition(c44480055.descon)
	c:RegisterEffect(e24)
end
function c44480055.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget():IsCode(44480005) 
end
function c44480055.chfilter(c)
	return c:IsFaceup() and c:IsAttackPos() and not c:IsType(TYPE_LINK)
end
function c44480055.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c44480055.chfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44480055.chfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c44480055.chfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c44480055.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if tc:IsRelateToEffect(e) and tc:IsLocation(LOCATION_MZONE) and tc:IsFaceup() then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_DISABLE_EFFECT)
		e3:SetValue(RESET_TURN_SET)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3)
	end
end
function c44480055.value(e,c)
	return c:GetDefense()*2
end